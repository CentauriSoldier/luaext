--[[
> luax
> Concept and Code By Centauri Soldier
> http://www.github.com/CentauriSoldier/LuaPlugs
> Version 0.3
>
> This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License.
> To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/
> or send a letter to Creative Commons, 444 Castro Street, Suite 900, Mountain View, California, 94041, USA.
--]]
luax = {};


local t_luax = {
	author = "Centauri Soldier",
	libs = {"io","math","string", "table"},
	license = "",
	restrictedFunctions = { --[[these functions that will be searched
								for by the io.scriptissafe() function.
								You can toggle each of these by using comments.
								]]
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
	path = "plugins/luax",
	version = "0.2.5"
};


function luax.init(p_path)
	
	--[[
	The path is set by luaplugs if called by it
	or by the user if LuaEx	is being used by
	itself, without luaplugs.
	]]
	if type(p_path) == "string" then
	t_luax.path = p_path;
	end
	
	for n_lib, s_lib in pairs(t_luax.libs) do
	require(t_luax.path..".modules."..s_lib);	
	end

end


function luax.getPath()
return t_luax.restrictedFunctions
end



function luax.getRestrictedFunctions()
return t_luax.restrictedFunctions
end