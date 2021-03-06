--[[
> table
> Concept and Code By Centauri Soldier
> http://www.github.com/CentauriSoldier/LuaPlugs
> Version 3.4
>
> This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License.
> To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/
> or send a letter to Creative Commons, 444 Castro Street, Suite 900, Mountain View, California, 94041, USA.
--]]

local tEscapeChars = {
	[1] = {
		Char = "\\",
		RelacementChar = "\\\\",
	},
	[2] = {
		Char = "\a",
		RelacementChar = "\\a",
	},
	[3] = {
		Char = "\b",
		RelacementChar = "\\b",
	},
	[4] = {
		Char = "\f",
		RelacementChar = "\\f",
	},
	[5] = {
		Char = "\n",
		RelacementChar = "\\n",
	},
	[6] = {
		Char = "\r",
		RelacementChar = "\\r",
	},
	[7] = {
		Char = "\t",
		RelacementChar = "\\t",
	},
	[8] = {
		Char = "\v",
		RelacementChar = "\\v",
	},
	[9] = {
		Char = "\"",
		RelacementChar = "\\\"",
	},
	[10] = {
		Char = "\'",
		RelacementChar = "\\'",
	},	 
	[11] = {
		Char = "%[",
		RelacementChar = "%%[",
	},
	[12] = {
		Char = "%]",
		RelacementChar = "%%]",
	},		
};



function table.copy(vInput)

	if type(vInput) ~= "table" then
	return vInput
	end
	
	local tNew = {};
	local tMeta = getmetatable(vInput);
			
	for vIndex, vItem in pairs(vInput) do
		
		if type(vItem) == "table" then
		vItem = table.copy(vItem);
		end
		
	tNew[vIndex] = vItem;
	end
	
	setmetatable(tNew, tMeta);

return tNew
end



function table.dump(pFile, tTable, bAppend, bOpenBinary)
assert(type(pFile) == "string", "File path must be a string.");
assert(type(tTable) == "table", "Input table must be of type table.");

local sOpenType = "w";
	
	if bOpenBinary then
	sOpenType = sOpenType.."b";
	end
	
	if bAppend then
	sOpenType = sOpenType.."+";
	end

	local hFile = assert(io.open(pFile, sOpenType), "Error in file: "..pFile.."\r\nDestination file could not be created or opened.\r\nPerhaps you do not have the required permissions for this action.");

	if hFile then
	hFile:write(table.tostring(tTable, 0));
	
	hFile:close();
	end

end


--MAKE THIS RECURSIV
function table.find(tInput, vValue)
	
	if type(tInput) == "table" then
		
		for nIndex, vExistingValue in pairs(tInput) do
			
			if vExistingValue == vValue then
			return nIndex
			end
			
		end
		
	end	
	
end



function table.getassocorder(tTable, fCompare)
local tReturn = {};

if type(tTable) == "table" then

	for sIndex, vValue in pairs(tTable) do
	tReturn[#tReturn + 1] = sIndex;
	end

	table.sort(tReturn, fCompare);

end

return tReturn
end



--[[
The number(argument #2) tells
the function how many indents
we want from the start. This can be 0.
]]
function table.tostring(tInput, nStartCount)
local sRet = "";
local nCount = 0;
	
	if type(nStartCount) == "number" then
	nCount = nStartCount;
	end

local sTab = "";

for x = 1, nCount do
sTab = sTab.."\t";
end

local sIndexTab = sTab.."\t";

nCount = nCount + 1;

	if type(tInput) == "table" then
	sRet = sRet.."{\r\n";
				
		for vIndex, vItem in pairs(tInput) do
		local sIndexType = type(vIndex);
		local sItemType = type(vItem);
		local sIndex = "";
				
			--write the index to string
			if sIndexType == "boolean" then
				
				if vIndex == true then
				sRet = sRet..sIndexTab.."[true] = ";
				
				else
				sRet = sRet..sIndexTab.."[false] = ";
				
				end
			
			
			elseif sIndexType == "function" then
			sRet = sRet..sIndexTab.."["..string.getfuncname(vIndex).."] = ";
			
			
			elseif sIndexType == "number" then
			sRet = sRet..sIndexTab.."["..vIndex.."] = ";
					
			elseif sIndexType == "string" then
			sIndex = sIndexTab.."[\""..vIndex.."\"] = ";
				
			elseif sIndexType == "table" then
			sIndex = sIndexTab.."["..table.tostring(vIndex, nCount).."] = ";
			
			end
			
			--write the item to string
			if sItemType == "number" then
			sRet = sRet..sIndex..vItem..",\n"
			
			elseif sItemType == "string" then
			
				for nIndex, tChar in pairs(tEscapeChars) do
				vItem = string.gsub(vItem, tChar.Char, tChar.RelacementChar);
				end
			
			sRet = sRet..sIndex.."\""..vItem.."\",\n";
			
			elseif sItemType == "boolean" then
			
				if vItem then
				sRet = sRet..sIndex.."true,\n";
				else
				sRet = sRet..sIndex.."false,\n";
				end
			
			elseif sItemType == "nil" then
			sRet = sRet..sIndex.."nil,\n";
			
			elseif sItemType == "function" then
			sRet = sRet..sIndex..string.getfuncname(vItem)..",\n";
									
			elseif sItemType == "userdata" then
			sRet = sRet..sIndex.."\"_USERDATA_\",\n"
			
			elseif sItemType == "table" then
			sRet = sRet..sIndex..table.tostring(vItem, nCount)..",\n";			
			
			end
			
		end
			
	end

	
sRet = sRet..sTab.."}"

return sRet
end