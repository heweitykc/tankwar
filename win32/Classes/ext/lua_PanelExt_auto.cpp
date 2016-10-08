#include "lua_PanelExt_auto.hpp"
#include "PanelExt.h"
#include "tolua_fix.h"
#include "LuaBasicConversions.h"


int lua_PanelExt_PanelExt_onTouchMoved(lua_State* tolua_S)
{
    int argc = 0;
    PanelExt* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"PanelExt",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (PanelExt*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_PanelExt_PanelExt_onTouchMoved'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 2) 
    {
        cocos2d::Touch* arg0;
        cocos2d::Event* arg1;

        ok &= luaval_to_object<cocos2d::Touch>(tolua_S, 2, "cc.Touch",&arg0, "PanelExt:onTouchMoved");

        ok &= luaval_to_object<cocos2d::Event>(tolua_S, 3, "cc.Event",&arg1, "PanelExt:onTouchMoved");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_PanelExt_PanelExt_onTouchMoved'", nullptr);
            return 0;
        }
        cobj->onTouchMoved(arg0, arg1);
        lua_settop(tolua_S, 1);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "PanelExt:onTouchMoved",argc, 2);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_PanelExt_PanelExt_onTouchMoved'.",&tolua_err);
#endif

    return 0;
}
int lua_PanelExt_PanelExt_moveItems(lua_State* tolua_S)
{
    int argc = 0;
    PanelExt* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"PanelExt",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (PanelExt*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_PanelExt_PanelExt_moveItems'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        cocos2d::Vec2 arg0;

        ok &= luaval_to_vec2(tolua_S, 2, &arg0, "PanelExt:moveItems");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_PanelExt_PanelExt_moveItems'", nullptr);
            return 0;
        }
        cobj->moveItems(arg0);
        lua_settop(tolua_S, 1);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "PanelExt:moveItems",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_PanelExt_PanelExt_moveItems'.",&tolua_err);
#endif

    return 0;
}
int lua_PanelExt_PanelExt_onTouchCancelled(lua_State* tolua_S)
{
    int argc = 0;
    PanelExt* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"PanelExt",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (PanelExt*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_PanelExt_PanelExt_onTouchCancelled'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 2) 
    {
        cocos2d::Touch* arg0;
        cocos2d::Event* arg1;

        ok &= luaval_to_object<cocos2d::Touch>(tolua_S, 2, "cc.Touch",&arg0, "PanelExt:onTouchCancelled");

        ok &= luaval_to_object<cocos2d::Event>(tolua_S, 3, "cc.Event",&arg1, "PanelExt:onTouchCancelled");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_PanelExt_PanelExt_onTouchCancelled'", nullptr);
            return 0;
        }
        cobj->onTouchCancelled(arg0, arg1);
        lua_settop(tolua_S, 1);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "PanelExt:onTouchCancelled",argc, 2);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_PanelExt_PanelExt_onTouchCancelled'.",&tolua_err);
#endif

    return 0;
}
int lua_PanelExt_PanelExt_onTouchBegan(lua_State* tolua_S)
{
    int argc = 0;
    PanelExt* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"PanelExt",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (PanelExt*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_PanelExt_PanelExt_onTouchBegan'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 2) 
    {
        cocos2d::Touch* arg0;
        cocos2d::Event* arg1;

        ok &= luaval_to_object<cocos2d::Touch>(tolua_S, 2, "cc.Touch",&arg0, "PanelExt:onTouchBegan");

        ok &= luaval_to_object<cocos2d::Event>(tolua_S, 3, "cc.Event",&arg1, "PanelExt:onTouchBegan");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_PanelExt_PanelExt_onTouchBegan'", nullptr);
            return 0;
        }
        bool ret = cobj->onTouchBegan(arg0, arg1);
        tolua_pushboolean(tolua_S,(bool)ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "PanelExt:onTouchBegan",argc, 2);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_PanelExt_PanelExt_onTouchBegan'.",&tolua_err);
#endif

    return 0;
}
int lua_PanelExt_PanelExt_setItemsMargin(lua_State* tolua_S)
{
    int argc = 0;
    PanelExt* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"PanelExt",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (PanelExt*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_PanelExt_PanelExt_setItemsMargin'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        double arg0;

        ok &= luaval_to_number(tolua_S, 2,&arg0, "PanelExt:setItemsMargin");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_PanelExt_PanelExt_setItemsMargin'", nullptr);
            return 0;
        }
        cobj->setItemsMargin(arg0);
        lua_settop(tolua_S, 1);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "PanelExt:setItemsMargin",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_PanelExt_PanelExt_setItemsMargin'.",&tolua_err);
#endif

    return 0;
}
int lua_PanelExt_PanelExt_pushBackItem(lua_State* tolua_S)
{
    int argc = 0;
    PanelExt* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"PanelExt",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (PanelExt*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_PanelExt_PanelExt_pushBackItem'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        cocos2d::ui::Widget* arg0;

        ok &= luaval_to_object<cocos2d::ui::Widget>(tolua_S, 2, "ccui.Widget",&arg0, "PanelExt:pushBackItem");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_PanelExt_PanelExt_pushBackItem'", nullptr);
            return 0;
        }
        cobj->pushBackItem(arg0);
        lua_settop(tolua_S, 1);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "PanelExt:pushBackItem",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_PanelExt_PanelExt_pushBackItem'.",&tolua_err);
#endif

    return 0;
}
int lua_PanelExt_PanelExt_onTouchEnded(lua_State* tolua_S)
{
    int argc = 0;
    PanelExt* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"PanelExt",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (PanelExt*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_PanelExt_PanelExt_onTouchEnded'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 2) 
    {
        cocos2d::Touch* arg0;
        cocos2d::Event* arg1;

        ok &= luaval_to_object<cocos2d::Touch>(tolua_S, 2, "cc.Touch",&arg0, "PanelExt:onTouchEnded");

        ok &= luaval_to_object<cocos2d::Event>(tolua_S, 3, "cc.Event",&arg1, "PanelExt:onTouchEnded");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_PanelExt_PanelExt_onTouchEnded'", nullptr);
            return 0;
        }
        cobj->onTouchEnded(arg0, arg1);
        lua_settop(tolua_S, 1);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "PanelExt:onTouchEnded",argc, 2);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_PanelExt_PanelExt_onTouchEnded'.",&tolua_err);
#endif

    return 0;
}
int lua_PanelExt_PanelExt_create(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"PanelExt",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 0)
    {
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_PanelExt_PanelExt_create'", nullptr);
            return 0;
        }
        PanelExt* ret = PanelExt::create();
        object_to_luaval<PanelExt>(tolua_S, "PanelExt",(PanelExt*)ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d\n ", "PanelExt:create",argc, 0);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_PanelExt_PanelExt_create'.",&tolua_err);
#endif
    return 0;
}
int lua_PanelExt_PanelExt_constructor(lua_State* tolua_S)
{
    int argc = 0;
    PanelExt* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif



    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_PanelExt_PanelExt_constructor'", nullptr);
            return 0;
        }
        cobj = new PanelExt();
        cobj->autorelease();
        int ID =  (int)cobj->_ID ;
        int* luaID =  &cobj->_luaID ;
        toluafix_pushusertype_ccobject(tolua_S, ID, luaID, (void*)cobj,"PanelExt");
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "PanelExt:PanelExt",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_error(tolua_S,"#ferror in function 'lua_PanelExt_PanelExt_constructor'.",&tolua_err);
#endif

    return 0;
}

static int lua_PanelExt_PanelExt_finalize(lua_State* tolua_S)
{
    printf("luabindings: finalizing LUA object (PanelExt)");
    return 0;
}

int lua_register_PanelExt_PanelExt(lua_State* tolua_S)
{
    tolua_usertype(tolua_S,"PanelExt");
    tolua_cclass(tolua_S,"PanelExt","PanelExt","ccui.Layout",nullptr);

    tolua_beginmodule(tolua_S,"PanelExt");
        tolua_function(tolua_S,"new",lua_PanelExt_PanelExt_constructor);
        tolua_function(tolua_S,"onTouchMoved",lua_PanelExt_PanelExt_onTouchMoved);
        tolua_function(tolua_S,"moveItems",lua_PanelExt_PanelExt_moveItems);
        tolua_function(tolua_S,"onTouchCancelled",lua_PanelExt_PanelExt_onTouchCancelled);
        tolua_function(tolua_S,"onTouchBegan",lua_PanelExt_PanelExt_onTouchBegan);
        tolua_function(tolua_S,"setItemsMargin",lua_PanelExt_PanelExt_setItemsMargin);
        tolua_function(tolua_S,"pushBackItem",lua_PanelExt_PanelExt_pushBackItem);
        tolua_function(tolua_S,"onTouchEnded",lua_PanelExt_PanelExt_onTouchEnded);
        tolua_function(tolua_S,"create", lua_PanelExt_PanelExt_create);
    tolua_endmodule(tolua_S);
    std::string typeName = typeid(PanelExt).name();
    g_luaType[typeName] = "PanelExt";
    g_typeCast["PanelExt"] = "PanelExt";
    return 1;
}
TOLUA_API int register_all_PanelExt(lua_State* tolua_S)
{
	tolua_open(tolua_S);
	
	tolua_module(tolua_S,nullptr,0);
	tolua_beginmodule(tolua_S,nullptr);

	lua_register_PanelExt_PanelExt(tolua_S);

	tolua_endmodule(tolua_S);
	return 1;
}

