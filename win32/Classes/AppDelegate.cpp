#include "AppDelegate.h"
#include "scripting/lua-bindings/manual/CCLuaEngine.h"
#include "audio/include/SimpleAudioEngine.h"
#include "cocos2d.h"
#include "scripting/lua-bindings/manual/lua_module_register.h"

#include "ext/WSClient.h"
#include "ext/MD5.h"
#include "ext/lua_ScrollViewExtend_auto.hpp"
#include "ext/lua_PanelExt_auto.hpp"
#include "JPushBridge.h"
#include "audio/include/AudioEngine.h"

#if (CC_TARGET_PLATFORM != CC_PLATFORM_LINUX)
#include "ide-support/CodeIDESupport.h"
#endif

#if (COCOS2D_DEBUG > 0) && (CC_CODE_IDE_DEBUG_SUPPORT > 0)
#include "runtime/Runtime.h"
#include "ide-support/RuntimeLuaImpl.h"
#endif

using namespace CocosDenshion;

USING_NS_CC;
using namespace std;

std::map<int, WSClient*> socks;
MD5 _md5;

WSClient* getSock(int  sockid)
{
	if (socks.find(sockid) == socks.end()){
		socks.insert(std::make_pair(sockid, new WSClient()));
	}
	return socks.at(sockid);
}

int base64decode(lua_State *L)
{
	std::string  luastring = lua_tostring(L, -1);
	const int BUFFER_LEN = 512;
	unsigned char* out = (unsigned char*)malloc(sizeof(unsigned char) * BUFFER_LEN);
	memset(out, 0, BUFFER_LEN);
	int len = base64Decode((const unsigned char *)luastring.c_str(), luastring.length(), &out);
	*(out + len) = 0;
	std::string decodeStr((char*)out);
	lua_pushstring(L, decodeStr.c_str());
	free(out);
	return 1;
}

int base64encode(lua_State *L)
{
	std::string  luastring = lua_tostring(L, -1);
	const int BUFFER_LEN = 512;
	char* out = (char*)malloc(sizeof(char) * BUFFER_LEN);
	memset(out, 0, BUFFER_LEN);
	base64Encode((const unsigned char *)luastring.c_str(), luastring.length(), &out);
	std::string encodeStr(out);
	lua_pushstring(L, encodeStr.c_str());
	free(out);
	return 1;
}

int md5(lua_State *L)
{
	std::string luastring = lua_tostring(L, -1);
	unsigned char* buffer = (unsigned char*)luastring.c_str();
	_md5.GenerateMD5(buffer, luastring.size());
	lua_pushstring(L, _md5.ToString().c_str());
	return 1;
}

//连接服务器
int wsConnect(lua_State *L)
{
	std::string luastring = lua_tostring(L, 1);
	int sockid = lua_tointeger(L, 2);
	log("sockid=%d", sockid);
	getSock(sockid)->connect(luastring.c_str());
	return 1;
}

//发送数据
int wsSend(lua_State *L)
{
	std::string luastring = lua_tostring(L, 1);
	int sockid = lua_tointeger(L, 2);
	getSock(sockid)->send(luastring.c_str(), luastring.size());
	return 1;
}

//检查新的数据
int wsCheckMsg(lua_State *L)
{
	int sockid = lua_tointeger(L, 1);
	if (getSock(sockid)->msglist.empty()){
		lua_pushnumber(L, 0); //没有数据，传回0
		return 1;
	}
	std::string msg = getSock(sockid)->msglist.front();
	getSock(sockid)->msglist.pop();
	lua_pushstring(L, msg.c_str());
	return 1;
}

//检查当前状态
int wsCheckStatus(lua_State *L)
{
	int sockid = lua_tointeger(L, 1);
	lua_pushnumber(L, getSock(sockid)->status);
	return 1;
}

//关闭连接
int wsClose(lua_State *L)
{
	int sockid = lua_tointeger(L, 1);
	getSock(sockid)->close();
	return 1;
}

void setAliasCallback(void *p_handle, int responseCode,
	const char *alias, set<string> *tags)
{
	log("jpush setalias responseCode =%d, alias=%s", responseCode, alias);
}

//设置jpush别名
int JPushSetAlias(lua_State *L)
{
	int uid = lua_tointeger(L, 1);	
	char s[30] = {0};
	sprintf(s, "uid_%d", uid);

	log("jpush setalias %s",s);

#if(CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID)
	APTagAliasCallback callback = setAliasCallback;
	JPushBridge::setAlias((void*)0, s, callback);
#endif

	return 1;
}

#if(CC_TARGET_PLATFORM == CC_PLATFORM_WIN32)

POINT prevPos;
// 移动窗体
int DragWinStart(lua_State *L)
{
	GetCursorPos(&prevPos);
	return 1;
} 

int DragWin(lua_State *L)
{
	POINT pos;	
	RECT rect;
	auto app = Application::getInstance();
	HWND hwnd = app->hwnd;

	GetCursorPos(&pos);	
	GetWindowRect(hwnd, &rect);
	int x = pos.x - prevPos.x;
	int y = pos.y - prevPos.y;
	MoveWindow(hwnd, rect.left + x, rect.top + y, rect.right - rect.left, rect.bottom - rect.top, TRUE);
	prevPos.x = pos.x;
	prevPos.y = pos.y;
	return 1;
}

int DragWinEnd(lua_State *L)
{
	return 1;
}

//设置窗口尺寸
void SetWinSize(int w, int h)
{
	auto app = Application::getInstance();
	HWND hwnd = app->hwnd;
	int scrWidth, scrHeight;
	int winWidth, winHeight;
	scrHeight = GetSystemMetrics(SM_CYSCREEN);
	scrWidth = GetSystemMetrics(SM_CXSCREEN);

	winWidth = w;
	winHeight = h;	

	MoveWindow(hwnd, (scrWidth - winWidth) / 2, (scrHeight - winHeight) / 2, winWidth, winHeight, TRUE);	
}

//窗口隐藏
int SetWinSizeMinimum(lua_State *L)
{
	auto app = Application::getInstance();
	HWND hwnd = app->hwnd;
	RECT rect;
	GetWindowRect(hwnd, &rect);
	ShowWindow(hwnd, SW_MINIMIZE);
	return 1;
}
//窗口最大化
int SetWinSizeMaximize(lua_State *L)
{	
	int scrHeight = GetSystemMetrics(SM_CYSCREEN);
	int scrWidth = GetSystemMetrics(SM_CXSCREEN);
	SetWinSize(scrWidth, scrHeight);
	return 1;
}

//窗口恢复
int SetWinSizeNormal(lua_State *L)
{
	int winWidth  = lua_tointeger(L, 1);
	int winHeight = lua_tointeger(L, 2);
	SetWinSize(winWidth, winHeight);
	return 1;
}

//获取窗口比例
int GetWinWHRatio(lua_State *L)
{	
	int scrWidth, scrHeight;	
	scrWidth = GetSystemMetrics(SM_CXSCREEN);
	scrHeight = GetSystemMetrics(SM_CYSCREEN);
	float ratio = (float)scrHeight / (float)scrWidth;
	lua_pushnumber(L, ratio);
	return 1;
}

#endif

void handlerRemoteNotification(void* p_handler, const char *message){
	//当收到推送通知时，会触发这个回调函数，其中message参数是一个Json字符串，你可以
	//从中获取通知的详细信息
	log("jpush handlerRemoteNotification =%s", message);
	LuaStack * L = LuaEngine::getInstance()->getLuaStack();
	lua_State* tolua_s = L->getLuaState();
	lua_getglobal(tolua_s, "__JPushNotify");    // 获取函数，压入栈中  	
	lua_pushstring(tolua_s, message);
	int iRet = lua_pcall(tolua_s, 1, 1, 0);			// 调用函数，调用完成以后，会将返回值压入栈中，2表示参数个数，1表示返回结果个数。 
	log("handlerRemoteNotification = %d", iRet);
}

AppDelegate::AppDelegate()
{
}

AppDelegate::~AppDelegate()
{
    SimpleAudioEngine::end();
	experimental::AudioEngine::end();

#if (COCOS2D_DEBUG > 0) && (CC_CODE_IDE_DEBUG_SUPPORT > 0)
    // NOTE:Please don't remove this call if you want to debug with Cocos Code IDE
    RuntimeEngine::getInstance()->end();
#endif 
}

// if you want a different context, modify the value of glContextAttrs
// it will affect all platforms
void AppDelegate::initGLContextAttrs()
{
    // set OpenGL context attributes: red,green,blue,alpha,depth,stencil
    GLContextAttrs glContextAttrs = {8, 8, 8, 8, 24, 8};

    GLView::setGLContextAttrs(glContextAttrs);
}

// if you want to use the package manager to install more packages, 
// don't modify or remove this function
static int register_all_packages()
{
    return 0; //flag for packages manager
}

bool AppDelegate::applicationDidFinishLaunching()
{
    // set default FPS
    Director::getInstance()->setAnimationInterval(1.0 / 30.0f);
	
#if(CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID)
	JPushBridge::init();
	JPushBridge::setDebugMode(false);
	JPushBridge::registerRemoteNotifcationCallback(this, &handlerRemoteNotification);
#endif

    // register lua module
    auto engine = LuaEngine::getInstance();
    ScriptEngineManager::getInstance()->setScriptEngine(engine);
    lua_State* L = engine->getLuaStack()->getLuaState();
    lua_module_register(L);

    register_all_packages();
	register_all_ScrollViewExtend(L);
	register_all_PanelExt(L);

    LuaStack* stack = engine->getLuaStack();
    stack->setXXTEAKeyAndSign("2dxLua", strlen("2dxLua"), "XXTEA", strlen("XXTEA"));

    //register custom function
	lua_register(L, "cm_wsconnect", wsConnect);
	lua_register(L, "cm_wssend",					wsSend);
	lua_register(L, "cm_wscheckmsg",			wsCheckMsg);
	lua_register(L, "cm_wscheckstatus",		wsCheckStatus);
	lua_register(L, "cm_wsclose",					wsClose);
	lua_register(L, "cm_md5",						md5);
	lua_register(L, "cm_base64decode",		base64decode);
	lua_register(L, "cm_base64encode",		base64encode);
	lua_register(L, "cm_jpush_setalias",		JPushSetAlias);

#if(CC_TARGET_PLATFORM == CC_PLATFORM_WIN32)
	lua_register(L, "cm_win_dragstart",		DragWinStart);
	lua_register(L, "cm_win_drag",				DragWin);
	lua_register(L, "cm_win_dragend",			DragWinEnd);
	lua_register(L, "cm_win_gominimum",		SetWinSizeMinimum);
	lua_register(L, "cm_win_gomaximize",		SetWinSizeMaximize);
	lua_register(L, "cm_win_gonormal",			SetWinSizeNormal);
	lua_register(L, "cm_win_getratio",				GetWinWHRatio);				
#endif

#if (COCOS2D_DEBUG > 0) && (CC_CODE_IDE_DEBUG_SUPPORT > 0)
    // NOTE:Please don't remove this call if you want to debug with Cocos Code IDE
    auto runtimeEngine = RuntimeEngine::getInstance();
    runtimeEngine->addRuntime(RuntimeLuaImpl::create(), kRuntimeEngineLua);
    runtimeEngine->start();
#else
    if (engine->executeScriptFile("src/main.lua"))
    {
        return false;
    }
#endif

    return true;
}

// This function will be called when the app is inactive. Note, when receiving a phone call it is invoked.
void AppDelegate::applicationDidEnterBackground()
{
    Director::getInstance()->stopAnimation();
	log("applicationDidEnterBackground");
    SimpleAudioEngine::getInstance()->pauseBackgroundMusic();
	experimental::AudioEngine::pauseAll();
}

// this function will be called when the app is active again
void AppDelegate::applicationWillEnterForeground()
{
    Director::getInstance()->startAnimation();
	log("applicationWillEnterForeground");
    SimpleAudioEngine::getInstance()->resumeBackgroundMusic();
	experimental::AudioEngine::resumeAll();
}
