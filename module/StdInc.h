
#include <stdlib.h>

#ifdef WIN32
#pragma warning (disable : 4996) // DISABLE: 'strcpy': This function or variable may be unsafe.
#endif

#include <assert.h>
#include <cstring>

#include <stdarg.h>
#include "Common.h"
#include "ILuaModuleManager.h"
#include "lauxlib.h"
#include "luaconf.h"
#include "lua.h"
#include "lualib.h"

#include "CFunctions.h"
#include "CLuaArgument.h"
#include "CLuaArguments.h"

#include "ml_system.h"