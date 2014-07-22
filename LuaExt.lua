--[[
> LuaExt
> Concept and Code By Centauri Soldier
> http://www.github.com/CentauriSoldier/LuaPlugs
> Version 0.3
>
> This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License.
> To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/
> or send a letter to Creative Commons, 444 Castro Street, Suite 900, Mountain View, California, 94041, USA.
--]]
LuaExt = {};


local tLuaExt = {
	Author = "Centauri Soldier",
	Libs = {"io","math","string", "table"},
	License = "",
	RestrictedFunctions = { --Functions that will be search for by the io.scriptissafe() function. You can toggle each of these by using comments.
		"assert",
		"collectgarbage",
		"dofile",
		"error",
		"getfenv",
		"getmetatable",
		--"ipairs",
		"load",
		"loadfile",
		"loadstring",
		--"math",
		"module",
		--"next",
		--"pairs",
		"pcall",
		"print",
		"rawequal",
		"rawget",
		"rawset",
		"require",
		"select",
		"setfenv",
		"setmetatable",
		--"tonumber",
		--"tostring",
		--"type",
		--"unpack",
		"xpcall",
		"file",
		"io",
		"os",
		"package",
		--"pairs",
		--"string",
		--"table",
		"coroutine",
		"debug",
		},
	Path = "Plugins/luaext",
	Version = "0.2.4"
};



function LuaExt.GetRestrictedFunctions()
return tLuaExt.RestrictedFunctions
end



function LuaExt.Init(pPath)
	
	--[[
	The path is set by LuaPlugs if called by it
	or by the user in the table above if LuaEx
	is being used by itself, without LuaPlugs.
	]]
	if type(pPath) == "string" then
	tLuaExt.Path = pPath;
	end
	
	for nLib, sLib in pairs(tLuaExt.Libs) do
	require(tLuaExt.Path..".modules."..sLib);	
	end

end