#include "lua_ScrollViewExtend_auto.hpp"
#include "ScrollViewExtend.h"
#include "tolua_fix.h"
#include "LuaBasicConversions.h"


int lua_ScrollViewExtend_ScrollViewExtend_setItemsMargin(lua_State* tolua_S)
{
    int argc = 0;
    ScrollViewExtend* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"ScrollViewExtend",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (ScrollViewExtend*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_ScrollViewExtend_ScrollViewExtend_setItemsMargin'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        double arg0;

        ok &= luaval_to_number(tolua_S, 2,&arg0, "ScrollViewExtend:setItemsMargin");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_ScrollViewExtend_ScrollViewExtend_setItemsMargin'", nullptr);
            return 0;
        }
        cobj->setItemsMargin(arg0);
        lua_settop(tolua_S, 1);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "ScrollViewExtend:setItemsMargin",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_ScrollViewExtend_ScrollViewExtend_setItemsMargin'.",&tolua_err);
#endif

    return 0;
}
int lua_ScrollViewExtend_ScrollViewExtend_setItemContentSize(lua_State* tolua_S)
{
    int argc = 0;
    ScrollViewExtend* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"ScrollViewExtend",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (ScrollViewExtend*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_ScrollViewExtend_ScrollViewExtend_setItemContentSize'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        cocos2d::Size arg0;

        ok &= luaval_to_size(tolua_S, 2, &arg0, "ScrollViewExtend:setItemContentSize");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_ScrollViewExtend_ScrollViewExtend_setItemContentSize'", nullptr);
            return 0;
        }
        cobj->setItemContentSize(arg0);
        lua_settop(tolua_S, 1);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "ScrollViewExtend:setItemContentSize",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_ScrollViewExtend_ScrollViewExtend_setItemContentSize'.",&tolua_err);
#endif

    return 0;
}
int lua_ScrollViewExtend_ScrollViewExtend_remedyChildren(lua_State* tolua_S)
{
    int argc = 0;
    ScrollViewExtend* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"ScrollViewExtend",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (ScrollViewExtend*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_ScrollViewExtend_ScrollViewExtend_remedyChildren'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_ScrollViewExtend_ScrollViewExtend_remedyChildren'", nullptr);
            return 0;
        }
        cobj->remedyChildren();
        lua_settop(tolua_S, 1);
        return 1;
    }
    if (argc == 1) 
    {
        cocos2d::Vec2 arg0;

        ok &= luaval_to_vec2(tolua_S, 2, &arg0, "ScrollViewExtend:remedyChildren");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_ScrollViewExtend_ScrollViewExtend_remedyChildren'", nullptr);
            return 0;
        }
        cobj->remedyChildren(arg0);
        lua_settop(tolua_S, 1);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "ScrollViewExtend:remedyChildren",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_ScrollViewExtend_ScrollViewExtend_remedyChildren'.",&tolua_err);
#endif

    return 0;
}
int lua_ScrollViewExtend_ScrollViewExtend_create(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"ScrollViewExtend",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 0)
    {
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_ScrollViewExtend_ScrollViewExtend_create'", nullptr);
            return 0;
        }
        ScrollViewExtend* ret = ScrollViewExtend::create();
        object_to_luaval<ScrollViewExtend>(tolua_S, "ScrollViewExtend",(ScrollViewExtend*)ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d\n ", "ScrollViewExtend:create",argc, 0);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_ScrollViewExtend_ScrollViewExtend_create'.",&tolua_err);
#endif
    return 0;
}
int lua_ScrollViewExtend_ScrollViewExtend_constructor(lua_State* tolua_S)
{
    int argc = 0;
    ScrollViewExtend* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif



    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_ScrollViewExtend_ScrollViewExtend_constructor'", nullptr);
            return 0;
        }
        cobj = new ScrollViewExtend();
        cobj->autorelease();
        int ID =  (int)cobj->_ID ;
        int* luaID =  &cobj->_luaID ;
        toluafix_pushusertype_ccobject(tolua_S, ID, luaID, (void*)cobj,"ScrollViewExtend");
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "ScrollViewExtend:ScrollViewExtend",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_error(tolua_S,"#ferror in function 'lua_ScrollViewExtend_ScrollViewExtend_constructor'.",&tolua_err);
#endif

    return 0;
}

static int lua_ScrollViewExtend_ScrollViewExtend_finalize(lua_State* tolua_S)
{
    printf("luabindings: finalizing LUA object (ScrollViewExtend)");
    return 0;
}

int lua_register_ScrollViewExtend_ScrollViewExtend(lua_State* tolua_S)
{
    tolua_usertype(tolua_S,"ScrollViewExtend");
    tolua_cclass(tolua_S,"ScrollViewExtend","ScrollViewExtend","ccui.ScrollView",nullptr);

    tolua_beginmodule(tolua_S,"ScrollViewExtend");
        tolua_function(tolua_S,"new",lua_ScrollViewExtend_ScrollViewExtend_constructor);
        tolua_function(tolua_S,"setItemsMargin",lua_ScrollViewExtend_ScrollViewExtend_setItemsMargin);
        tolua_function(tolua_S,"setItemContentSize",lua_ScrollViewExtend_ScrollViewExtend_setItemContentSize);
        tolua_function(tolua_S,"remedyChildren",lua_ScrollViewExtend_ScrollViewExtend_remedyChildren);
        tolua_function(tolua_S,"create", lua_ScrollViewExtend_ScrollViewExtend_create);
    tolua_endmodule(tolua_S);
    std::string typeName = typeid(ScrollViewExtend).name();
    g_luaType[typeName] = "ScrollViewExtend";
    g_typeCast["ScrollViewExtend"] = "ScrollViewExtend";
    return 1;
}
TOLUA_API int register_all_ScrollViewExtend(lua_State* tolua_S)
{
	tolua_open(tolua_S);
	
	tolua_module(tolua_S,nullptr,0);
	tolua_beginmodule(tolua_S,nullptr);

	lua_register_ScrollViewExtend_ScrollViewExtend(tolua_S);

	tolua_endmodule(tolua_S);
	return 1;
}

