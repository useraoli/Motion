# Documentation ✏️

---

# Table of Contents

<details>
<summary>Motion</summary>

- [Description](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#motion)
- [Methods](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#methods)
  - [:createMotion()](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#createmotion)
  - [:createCurve()](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#createcurve)
  - [.setUpdatePriority()](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#setupdatepriority)
  - [.setCurveAccuracy()](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#setcurveaccuracy)
  - [.independentUpdate()](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#independentupdate)
  - [.updateSignal()](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#updatesignal)
</details>

<details>
<summary>MotionAnim</summary>

- [Description](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#motionanim)
- [Methods](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#methods-1)
  - [:start()](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#start)
  - [:stop()](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#stop)
  - [:update()](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#update)
  - [.setPlaybackSpeed()](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#setplaybackspeed)
  - [.setPlaybackFPS()](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#setplaybackfps)
- [Properties](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#properties)
  - [duration](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#duration)
  - [focus](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#focus)
  - [goals](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#goals)
</details>

# Summary

Interpolation works ONLY on objects with the compatible property types, including:

- [number](https://create.roblox.com/docs/luau/numbers)
- [Vector2](https://create.roblox.com/docs/reference/engine/datatypes/Vector2)
- [Vector3](https://create.roblox.com/docs/reference/engine/datatypes/Vector3)
- [UDim](https://create.roblox.com/docs/reference/engine/datatypes/UDim)
- [UDim2](https://create.roblox.com/docs/reference/engine/datatypes/UDim2)
- [CFrame](https://create.roblox.com/docs/reference/engine/datatypes/CFrame)
- [Color3](https://create.roblox.com/docs/reference/engine/datatypes/Color3)

---

# Motion
Used to create and manage [MotionAnim](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#motionanim) objects to interpolate instance properties.

## Methods

### :createMotion()

Creates a [MotionAnim](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#motionanim) object with the properties to be interpolated.

```lua
Motion:createMotion(curve_name: string, duration: number?, focus: Instances?, goals: Dictionary?) : MotionAnim
```

| Parameters          | Description                                                                                                                      |
| ------------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| curve_name: [string](https://create.roblox.com/docs/reference/engine/libraries/string) | The name of the curve to be used.                             |
| duration: [number?](https://create.roblox.com/docs/luau/numbers) | How long the interpolation will take to its target value.                    |
| focus: [Instances?](https://create.roblox.com/docs/reference/engine/datatypes/Instance) | The desired instances to be interpolated.                    |
| goals: [Dictionary?](https://create.roblox.com/docs/luau/tables#dictionaries) | The following properties, set to the final values, to be interpolated. |

| Returns                                                                                |
| -------------------------------------------------------------------------------------- |
| [MotionAnim](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#motionanim) |

The constructor initiates a new [MotionAnim](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#motionanim) object. To create one, Motion will require four arguments: the curve to use, the duration of the motion, the instances to be interpolated, and a dictionary containing the properties assigned with its target values.

Like [TweenService](https://create.roblox.com/docs/reference/engine/classes/TweenService#Create), the ```goals``` table is similar to the ```propertyTable```, where it needs to be a dictionary with the keys being the desired properties to interpolate, and the value of each key being the final target values of the motion.

The resulting [MotionAnim](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#motionanim) is its own individual object, but unlike the [Tween](https://create.roblox.com/docs/reference/engine/classes/Tween), it can be reused and its public properties of it are interchangeable.

## Code Samples
### Creating a MotionAnim object

In this example, we will be interpolating an instance's current transparency and position to a new one.

```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Motion = require(ReplicatedStorage.Motion)

-- Creates a curve before the MotionAnim
--	@ The accuracy parameter in this function only ranges from 0 - 1
--	@ The smaller the number, the less memory it'll use.
Motion:createCurve("curve_name", {0, 0, 1, 1}, 0)

-- Insert the name of the curve
local MotionAnim = Motion:createMotion("curve_name", 1, instance, {
	Position = Vector3.new(1, 1, 1);
	Transparency = 1;
})

-- First argument is the motion framerate
-- and the second is the speed of the motion.
MotionAnim:start(60, 1)
```

### Changing the properties of a MotionAnim object
Properties may also be applied after the creation of the MotionAnim object. So these instances are reusable, manageable, and organized. Creating different, individual, tweens for unique properties is no longer necessary.

```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Motion = require(ReplicatedStorage.Motion)

Motion:createCurve("curve_name", {0, 0, 1, 1})

-- Only the curve name is required when creating a MotionAnim instance.
local MotionAnim = Motion:createMotion("curve_name")

-- Before starting the Motion, you must assign-
-- the properties or it will result in an error.
MotionAnim.duration = 1

 -- You can tween multiple instances.
MotionAnim.focus = {
	instance_a;
	instance_b;
}

MotionAnim.goals = {
	Position = Vector3.new(1, 1, 1);
	Transparency = 1;
}

MotionAnim:start(60, 1)
```

---

### :createCurve()
```lua
Motion:createCurve(name: string, curve: {number}, accuracy: number?) : ()
```
### .setUpdatePriority()
```lua
Motion.setUpdatePriority(priority: number) : ()
```

### .setCurveAccuracy()
```lua
Motion.setCurveAccuracy(accuracy: number) : ()
```

### .independentUpdate()
```lua
Motion.independentUpdate(enabled: boolean) : ()
```

### .updateSignal()
```lua
Motion.updateSignal(deltaTime: number) : ()
```

---

# MotionAnim
The MotionAnim object handles the logic for the interpolations.

## Methods
### :start()
```lua
MotionAnim:start(fps: number?, speed: number?) : ()
```

### :stop()
```lua
MotionAnim:stop() : ()
```

### :update()
```lua
MotionAnim:update(deltaTime: number) : ()
```

### .setPlaybackSpeed()
```lua
MotionAnim.setPlaybackSpeed(speed: number?) : ()
```

### .setPlaybackFPS()
```lua
MotionAnim.setPlaybackFPS(fps: number) : ()
```

## Properties
### duration
```lua
MotionAnim.duration : number
```

### focus
```lua
MotionAnim.focus : Instances
```

### goals
```lua
MotionAnim.goals : Dictionary
```
