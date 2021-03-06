main = function()
	iiFiles = {
		"System/itemInfo.lua", -- 1st priority
		"System/itemInfo_2.lua", -- 2nd
	}

	_TempItems = {}
	_Num = 0

	-- check existing item
	function CheckItem(ItemID, DESC)
		if not (_TempItems[ItemID]) then
			_TempItems[ItemID] = DESC
			_Num = _Num + 1
		else
			myTbl = {}
			for pos,val in pairs(_TempItems[ItemID]) do
				myTbl[pos] = val
			end

			for pos,val in pairs(DESC) do
				if not (myTbl[pos]) or myTbl[pos] == "" then
					myTbl[pos] = val
				end

			end

			_TempItems[ItemID] = myTbl
		end

	end
	-- end check

	-- Read all files
	for i,iiFile in pairs(iiFiles) do
		d = dofile(iiFile)
	end
	-- Read all files


	-- process _TempItems
	for ItemID,DESC in pairs(_TempItems) do
		--print("ItemID",ItemID,"Name",DESC.identifiedDisplayName)
		result, msg = AddItem(ItemID, DESC.unidentifiedDisplayName, DESC.unidentifiedResourceName, DESC.identifiedDisplayName, DESC.identifiedResourceName, DESC.slotCount, DESC.ClassNum)
		if not result then
			return false, msg
		end
		for k,v in pairs(DESC.unidentifiedDescriptionName) do
			result, msg = AddItemUnidentifiedDesc(ItemID, v)
			if not result then
				return false, msg
			end
		end
		for k,v in pairs(DESC.identifiedDescriptionName) do
			result, msg = AddItemIdentifiedDesc(ItemID, v)
			if not result then
				return false, msg
			end
		end
	end
	-- process _TempItems

	_TempItems = nil

    return true, "good"
end