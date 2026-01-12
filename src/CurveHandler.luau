local CurveHandler = {}
CurveHandler.accuracy = 0
CurveHandler.curves = {}

function CurveHandler.bakeCurve(curve_name: string, curve: {}, accuracy: number)
	local baked_curve = generateBezierCurve(curve, accuracy)
	CurveHandler.curves[curve_name] = baked_curve
end

function CurveHandler.remCurve(curve_name: string)
	CurveHandler.curves[curve_name] = nil
end

function generateBezierCurve(curve: {}, accuracy: number)
	local measure, inverse_acc = getBezierIncrements(accuracy)
	return iterateBezierPoints(measure, inverse_acc, curve, {Vector2.zero})
end

function getBezierIncrements(accuracy: number)
	local measure = math.lerp(60, 240,
		accuracy or CurveHandler.accuracy)
	
	measure = math.floor(measure)
	return measure, 1 / measure
end

function iterateBezierPoints(accuracy: number,
	inverse_acc: number, curve: {}, baked_curve: {})
	
	for i = 1, accuracy do
		local time_inc = i * inverse_acc
		addBezierPoints(time_inc,
			curve, baked_curve) end
	
	return baked_curve
end

function addBezierPoints(time_increment: number,
	curve: {}, baked_curve: {})
	
	table.insert(baked_curve, Vector2.new(
		getBezierValue(curve[1], curve[3], time_increment),
		getBezierValue(curve[2], curve[4], time_increment)))
end

function getBezierValue(p0: number, p1: number, t: number)
	return p0 * (3 * t ^ 3 - 6 * t ^ 2 + 3 * t) +
		p1 * (-3 * t ^ 3 + 3 * t ^ 2) + t ^ 3
end

return CurveHandler
