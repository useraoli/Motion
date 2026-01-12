-- GLOBAL VARIABLES
local RunService = game:GetService('RunService')

local CurveHandler = require('@self/CurveHandler')
local MotionAnim = require('@self/MotionAnim')

local Motion = {}

-- PRIVATE VARIABLES

local _update_types = {
	RunService.RenderStepped;
	RunService.PreRender;
	RunService.PreAnimation;
	RunService.Stepped;
	RunService.PreSimulation;
	RunService.Heartbeat;
	RunService.PostSimulation;
}

local _update_connection = nil
local _update_priority = nil

-- FLAGS

local _INDEPENDENT_UPDATE_FLAG = false


-- PUBLIC METHODS

-- This creates a new motion instance.
function Motion:createMotion(
	curve_name: string, duration: number,
	focus: {Instance}, goals: {any})

	local curve = CurveHandler.curves[curve_name]
	local motion_instance = MotionAnim.
		createMotion(curve, duration, focus, goals)
	
	return motion_instance
end

--[[
This determines the baking accuracy of the curve.

> Only takes in a range from <0 - 1>
> Zero being 60 and one being 240
]]
function Motion:createCurve(name: string,
	curve: {number}, accuracy: number)
	CurveHandler.bakeCurve(name, curve, accuracy)
end

--[[
This determines the update priority of the motion.

---------------------------------
* 1 - PreRender
* 2 - RenderStepped
* 3 - PreSimulation
* 4 - Heartbeat
---------------------------------
]]
function Motion.setUpdatePriority(priority: number)
	_update_priority = _update_types[priority]
	
	if not _INDEPENDENT_UPDATE_FLAG then
		jumpstartUpdate() end
end

--[[
This determines the baking accuracy of the curve.

> Only takes in a range from <0 - 1>
> Zero being 60 and one being 240
]]
function Motion.setCurveAccuracy(accuracy: number)
	CurveHandler.accuracy = math.clamp(accuracy, 0, 1)
end

--[[
This determines if the updates will be overidden/handled manually.

> If <enabled> is set to TRUE, then you will need to handle the updates yourself
]]
function Motion.independentUpdate(enabled: boolean)
	_INDEPENDENT_UPDATE_FLAG = enabled;
	(enabled and disconnectUpdate or connectUpdate)()
end

--[[
This handles the updates for each tween

> ONLY WORKS IF INDEPENDENT UPDATE IS ENABLED
]]
function Motion.updateSignal(deltaTime: number)
	if not _INDEPENDENT_UPDATE_FLAG then return end
	onUpdate(deltaTime)
end

-- PRIVATE METHODS

function disconnectUpdate()
	if not _update_connection then return end
	_update_connection:Disconnect()
	_update_connection = nil
end

function connectUpdate()
	if _update_connection then return end
	_update_connection = _update_priority:
		Connect(onUpdate)
end

function jumpstartUpdate()
	disconnectUpdate()
	connectUpdate()
end

function onUpdate(frame_time: number)
	MotionAnim.onUpdate(frame_time)
end

Motion.setUpdatePriority(1)

return Motion
