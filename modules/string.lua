--[[
> string
> Concept and Code By Centauri Soldier
> http://www.github.com/CentauriSoldier/LuaPlugs
> Version 2.3
>
> This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License.
> To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/
> or send a letter to Creative Commons, 444 Castro Street, Suite 900, Mountain View, California, 94041, USA.
--]]
local tString = {
	Articles = {};

};



function string.isblank(sInput)

	if string.gsub(sInput, " ", "") == "" then
	return true
	end

return false
end



function string.cap(sInput, bLowerRemaining)
local sRet = "";

	if string.len(sInput) > 1 then
	local sFirstLetter = string.sub(sInput, 1, 1);
	local sRightSide = string.sub(sInput, 2, string.len(sInput));
	sRet = string.upper(sFirstLetter);

		if bLowerRemaining then
		sRet = sRet..string.lower(sRightSide);

		else
		sRet = sRet..sRightSide;

		end


	else
	sRet = string.upper(sInput);
	end

return sRet
end



function string.capall(sInput)
local sRet = "";
	
	if not string.isblank(sInput) then
	local tWords = string.totable(sInput, " ");
	local nWords = #tWords;
	
		for nIndex, sWord in pairs(tWords) do
		local sSpace = " ";

			if nIndex == nWords then
			sSpace = "";
			end
		
		local sFirstLetter = string.upper(string.sub(sWord, 1, 1));
		local sRightSide = string.sub(sWord, 2);
		sRet = sRet..sFirstLetter..sRightSide..sSpace;
		end
	
	end
	
return sRet, nWords, tWords
end



function string.getfuncname(fFunc)

	if type(fFunc) == "function" then

		for vIndex, vItem in pairs(getfenv(fFunc)) do
			
			if vIndex ~= "_G" then
			local sItemType = type(vItem);
				
				if sItemType == "function" then
					
					if vItem == fFunc then
					return vIndex
					end
				
				elseif sItemType == "table" then
					
					for vIndex2, vItem2 in pairs(vItem)	do
					local sItemType2 = type(vItem2);
		
						if sItemType2 == "function" then
					
							if vItem2 == fFunc then
							return vIndex.."."..vIndex2
							end
						
						elseif sItemType2 == "table" then
						
							for vIndex3, vItem3 in pairs(vItem2) do
							local sItemType3 = type(vItem3);
				
								if sItemType3 == "function" then
							
									if vItem3 == fFunc then
									return vIndex.."."..vIndex2.."."..vIndex3
									end
								
								elseif sItemType3 == "table" then
						
									for vIndex4, vItem4 in pairs(vItem3) do
									local sItemType4 = type(vItem4);
						
										if sItemType4 == "function" then
									
											if vItem4 == fFunc then
											return vIndex.."."..vIndex2.."."..vIndex3.."."..vIndex4
											end
																
										end
								
									end			
															
								end
								
							end			
								
						end
						
					end
					
				end
				
			end
		
		end
		
	end
	
return ""
end



function string.left(sInput, nChars)
local nLength = string.len(sInput);

	if nLength > 0 and nLength > nChars then
	return string.sub(sInput, 1, nChars);
		
	else
	return sInput
	
	end

end



function string.right(sInput, nChars)
local nLength = string.len(sInput);

	if nLength > 0 and nLength > nChars then
	local nStart = nLength - nChars + 1;
	return string.sub(sInput, nStart);
		
	else
	return sInput
	
	end

end



function string.totable(sString, sDelimiter)

	if sString ~= "" and sDelimiter ~= "" then
	local tRet = {};
	local bContinue = true;
	local nSearchIndex = 1;

		while bContinue do
		local nStart, nEnd = string.find(sString, sDelimiter, nSearchIndex);

			if nStart then
			tRet[#tRet + 1] = string.sub(sString, nSearchIndex, nStart - 1);
			nSearchIndex = nEnd + 1;

			else
			tRet[#tRet + 1] = string.sub(sString, nSearchIndex);
			bContinue = false;

			end

		end

	return tRet
	end

end



function string.uuid(sInputPrefix, nMaxPrefixLength)
local tChars = {"7","f","1","e","3","c","6","b","5","9","a","4","8","d","0","2"};
local nChars = #tChars;
local sPrefix = "";
local sUUID = "";
local tSequence = {1,4,4,4,12};
local nMaxPrefixLength = 6;
local sDelimiter = "-";

	if type(sInputPrefix) == "string" then
		
		if not string.isblank(sInputPrefix) then
		sPrefix = sInputPrefix;
		end
		
	end
	
	if type(nMaxLength) == "number" then
		
		if nMaxLength > 0 and nMaxLength <= 8 then
		nMaxPrefixLength = nMaxLength;
		end
		
	end
	
	local nLength = string.len(sPrefix);
	
	if nLength > 1 then

		if nLength > nMaxPrefixLength then
		sPrefix = string.sub(sPrefix, 1, nMaxPrefixLength);
		end
		
		if string.gsub(sPrefix, " ", "") ~= "" then
		sUUID = sPrefix..sDelimiter;
		end
		
		if nLength < nMaxPrefixLength then
		tSequence[1] = tSequence[1] + (nMaxPrefixLength - nLength);
		end
		
	else
	tSequence[1] = 8;
	end

	for nIndex, nSequence in pairs(tSequence) do
		
		for x = 1, nSequence do
		sUUID = sUUID..tChars[math.random(1, nChars)];
		end

	sUUID = sUUID.."-";
	end

sUUID = string.sub(sUUID, 1, string.len(sUUID) - 1);
return sUUID
end