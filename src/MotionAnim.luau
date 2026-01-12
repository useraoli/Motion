local MotionAnim = {}
MotionAnim.motions = {}

function MotionAnim.createMotion(
	curve: {}, duration: number,
	focus: {Instance}, goals: {}
)
	local self = setmetatable({
		time_position = 0;
		framerate = 240;
		speed = 1;
		
		duration = duration;
		focus = focus;
		goals = goals;
	}, {})
	
	-- Changable methods
	local _playback_speed = 0
	local _playback_fps = 0
	
	-- Private Variables
	local _playback_time = 0
	local _playback_diff = 0
	
	local _connection_index = nil
	local _starts = {}
	
	function self:start(fps: number, speed: number)
		if _connection_index then return end
		_playback_fps = 1 / (fps or self.framerate)
		_playback_speed = speed or self.speed
		
		_starts = getStartValues(self, _starts)
		_connection_index = connectUpdate(self)
	end
	
	function self:stop()
		if not _connection_index then return end
		disconnectUpdate(_connection_index)
		_connection_index = nil
		self.time_position = 0
		
		table.clear(_starts)
	end
	
	function self:update(deltaTime: number)
		local scaled_duration = self.duration / _playback_speed
		self.time_position = incrementTime(self,
			self.time_position, scaled_duration, deltaTime)
		
		if _playback_diff < _playback_fps then
			_playback_diff = _playback_diff + deltaTime return end
		
		local current_time = self.time_position / scaled_duration
		local interval = getCurveInterval(curve, current_time)
		
		_playback_diff = _playback_diff - _playback_fps
		tweenMotion(_starts, self.goals, self.focus, interval)
		if self.time_position >= scaled_duration then self:stop() end
	end
	
	return self
end

-- PRIVATE METHODS


function getCurveInterval(curve: {{number}}, current_time: number)
	local ease_time, ease_strength = getEasePoints(curve, current_time)
	local same_strength_flag = ease_time.Y == ease_strength.Y
	
	return same_strength_flag and ease_time.Y or
		math.lerp(ease_time.Y, ease_strength.Y, getAccelDeriv(
			ease_time.X, ease_strength.X, current_time))
end

function getEasePoints(curve: {{number}}, current_time: number)
	local ease_time, ease_strength = Vector2.zero, Vector2.zero
	
	for index, point in curve do
		ease_time, ease_strength = getEasingAccel(
			curve, index, current_time)
		if ease_time ~= ease_strength then break end
	end;
	
	return ease_time, ease_strength
end

function getEasingAccel(curve: {{number}},
	index: number, current_time: number)
	
	if current_time >= curve[index].X then
		return curve[index], curve[index]
	end return curve[index - 1], curve[index]
end

function getAccelDeriv(last_strength: number,
	new_strength: number, current_time: number)
	
	local edge = new_strength - last_strength
	local release = current_time - last_strength
	current_time = release / edge
	
	return current_time ~= current_time
		and 0 or current_time
end

function tweenMotion(starts: {any}, goals: {any},
	focus : {Instance} | Instance, interval: number)
	
	(typeof(focus) == 'table' and iterateInstances
		or iterateProperties)(starts, goals, focus, interval)
end


function iterateInstances(starts: {any}, goals: {any},
	focus : {Instance}, interval: number)
	
	for _, instance in focus do
		iterateProperties(starts,
			goals, instance, interval) end
end

function iterateProperties(starts: {any}, goals: {any},
	focus : Instance, interval: number)

	for property, start in starts do
		local goal = goals[property]
		
		decidePropertyType(start, goal,
			property, focus, interval) end
end

function decidePropertyType(start: any, goal: any,
	property: string, focus : Instance, interval: number)
	
	(typeof(start) == 'number' and lerpNumToInterval or
		lerpClassToInterval)(start, goal, property, focus, interval)
end

function lerpClassToInterval(start: any, goal: any,
	property: string, focus : Instance, interval: number)
	focus[property] = start:Lerp(goal, interval)
end

function lerpNumToInterval(start: any, goal: any,
	property: string, focus : Instance, interval: number)
	focus[property] = math.lerp(start, goal, interval)
end

function incrementTime(self, time_inc: number, duration: number, frame_time: number)
	return math.min(time_inc + frame_time, duration)
end

function getStartValues(self, start_values: {})
	return (typeof(self.focus) == 'table' and iterateStartValues
		or getFocusValues)(self, start_values, self.focus)
end

function iterateStartValues(self, start_values: {}, focus: {})
	for _, focus in focus do
		getFocusValues(self, start_values, focus)
	end; return start_values
end

function getFocusValues(self, start_values: {}, focus: Instance)
	for property in self.goals do
		start_values[property] =
			focus[property] end
	
	return start_values
end

-- ECS METHODS
function MotionAnim.onUpdate(frame_time: number)
	for _, motion in MotionAnim.motions do
		motion:update(frame_time) end
end

function disconnectUpdate(motion_index: number)
	MotionAnim.motions[motion_index] = nil
end

function connectUpdate(motion)
	table.insert(MotionAnim.motions, motion)
	return #MotionAnim.motions
end

return MotionAnim
