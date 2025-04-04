ZombieActions = ZombieActions or {}

ZombieActions.TelevisionToggle = {}
ZombieActions.TelevisionToggle.onStart = function(zombie, task)
    return true
end

ZombieActions.TelevisionToggle.onWorking = function(zombie, task)
    if not zombie:getVariableString("BumpAnimFinished") then
        return false
    else
        return true
    end
end

ZombieActions.TelevisionToggle.onComplete = function(zombie, task)
    local square = zombie:getCell():getGridSquare(task.x, task.y, task.z)
    if square then
        local objects = square:getObjects()
        for i=0, objects:size()-1 do
            local object = objects:get(i)
            if instanceof(object, "IsoTelevision") or instanceof(object, "IsoRadio") then
                local dd = object:getDeviceData()

                dd:setIsTurnedOn(task.on)
                if task.on then
                    if task.channel then
                        dd:setChannel(task.channel)
                    end
                    if task.volume then
                        dd:setDeviceVolume(task.volume)
                    end
                end
            end
        end
    end
    return true
end

