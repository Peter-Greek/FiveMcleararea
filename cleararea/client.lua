--[[RegisterNetEvent("CA")
AddEventHandler("CA", function()
	local pos = GetEntityCoords(GetPlayerPed(-1), true)
	ClearAreaOfEverything(pos.x, pos.y, pos.z, 100.0, true, false, false, false)
end)]]--

local entityEnumerator = {
  __gc = function(enum)
    if enum.destructor and enum.handle then
      enum.destructor(enum.handle)
    end
    enum.destructor = nil
    enum.handle = nil
  end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
  return coroutine.wrap(function()
    local iter, id = initFunc()
    if not id or id == 0 then
      disposeFunc(iter)
      return
    end
    
    local enum = {handle = iter, destructor = disposeFunc}
    setmetatable(enum, entityEnumerator)
    
    local next = true
    repeat
      coroutine.yield(id)
      next, id = moveFunc(iter)
    until not next
    
    enum.destructor, enum.handle = nil, nil
    disposeFunc(iter)
  end)
end

function EnumerateObjects()
  return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function EnumerateVehicles()
  return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function EnumeratePickups()
  return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end


RegisterNetEvent("CA")
AddEventHandler("CA", function()
	for vehicle in EnumerateVehicles() do
		print(vehicle)
		SetVehicleHasBeenOwnedByPlayer(vehicle, false)
		SetEntityAsMissionEntity( vehicle, true, true )
		DeleteVehicle( vehicle )
	end
end)





--[[Usage:
for ped in EnumeratePeds() do
  <do something with 'ped'>
end
]]
