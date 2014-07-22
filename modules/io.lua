--[[
> io
> Concept and Code By Centauri Soldier
> http://www.github.com/CentauriSoldier/LuaPlugs
> Version 0.1
>
> This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License.
> To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/
> or send a letter to Creative Commons, 444 Castro Street, Suite 900, Mountain View, California, 94041, USA.
--]]

local t_io = {
	resFunctions = "", --[[these are generally called from the luax module 
						but can be added to by calling io.addresfunctions
						or by adding them here manually.]]
};

function io.addresfunctions(t_functions)

	if type(t_functions) == "table" then
		
		for nIndex, s_resFunction in pairs(t_functions) do
			
			if type(s_resFunction) == "string" then
							
				if not table.find(t_io.resFunctions, s_resFunction) then
				t_io.resFunctions[#t_io.resFunctions + 1] = s_resFunction;
				end
				
			end
			
		end
		
	end

end


--[[ Checks whether or not the input script contains any
restricted functions. if the script is NOT safe, this function
return two values, false (boolean) and the name of the function
(string) that is disallowed but present in the script.
If the script is safe, this functions returns true boolean).
]]
function io.scriptissafe(p_file, t_resFunctionList)
local s_script = "";
local t_functions = luax.getRestrictedFunctions();
local b_ok, h_file = pcall(io.open, p_file, "rb");

	if not b_ok or not h_file then
	return false, "could not open file for reading"
	end

	s_script = h_file:read("*all");
		
	if type(t_resFunctionList) == "table" then
	t_functions = t_resFunctionList
	end

	for n_index, s_function in pairs(t_functions) do
	local n_lastFound = 1;
		
		repeat
		local n_found = string.find(s_script, s_function, n_lastFound);
			
			if n_found then
			n_lastFound = n_found + 1;
			local n_length = string.len(s_function);
			local n_failCount = 0;
			local s_before = string.sub(s_script, (n_found - 1), (n_found - 1));
			local s_after = string.sub(s_script, (n_found + n_length), (n_found + n_length));
							
				if not string.find(s_before, '[_%a]') then
					
					--if not string.find(s_before, '_') then
					n_failCount = n_failCount + 1;
					--end
					
				end
				
				if not string.find(s_after, '[_%a]') then
					
					--if not string.find(s_before, '_') then
					n_failCount = n_failCount + 1;
					--end
								
				end
				
				if n_failCount > 1 then				
				return false, s_function
				end
				
			
			end
		
		until not n_found
			
	end	
	
	h_file:close();

return true
end