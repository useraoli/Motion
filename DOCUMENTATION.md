# Documentation ✏️
<img width="1920" height="480" alt="Motion Logo Blur" src="https://github.com/user-attachments/assets/8f27a517-49b4-4610-a828-053a275c716a" />

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

---

# Motion
Used to create and manage [MotionAnim](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#motionanim) objects to interpolate instance properties.

## Summary

Interpolation works ONLY on objects with the compatible property types, including:

- [number](https://create.roblox.com/docs/luau/numbers)
- [Vector2](https://create.roblox.com/docs/reference/engine/datatypes/Vector2)
- [Vector3](https://create.roblox.com/docs/reference/engine/datatypes/Vector3)
- [UDim](https://create.roblox.com/docs/reference/engine/datatypes/UDim)
- [UDim2](https://create.roblox.com/docs/reference/engine/datatypes/UDim2)
- [CFrame](https://create.roblox.com/docs/reference/engine/datatypes/CFrame)
- [Color3](https://create.roblox.com/docs/reference/engine/datatypes/Color3)

## Methods

### :createMotion()

Creates a [MotionAnim](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#motionanim) object with the properties to be interpolated.

```lua
Motion:createMotion(curve_name: string, duration: number?, focus: Instances?, goals: Dictionary?) : MotionAnim
```

---

| Parameters          | Description                                                                                                                      |
| ------------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| curve_name: [string](https://create.roblox.com/docs/reference/engine/libraries/string) | The name of the curve to be used.                             |
| duration: [number?](https://create.roblox.com/docs/luau/numbers) | How long the interpolation will take to its target value.                           |
| focus: [Instances?](https://create.roblox.com/docs/reference/engine/datatypes/Instance) | The desired instances to be interpolated.                    |
| goals: [Dictionary?](https://create.roblox.com/docs/luau/tables#dictionaries) | The following properties, set to the final values, to be interpolated. |

| Returns                                                                                |
| -------------------------------------------------------------------------------------- |
| [MotionAnim](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#motionanim) |

---

The constructor initiates a new [MotionAnim](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#motionanim) object. To create one, Motion will require four arguments:
the curve to use, the duration of the motion, the instances to be interpolated, and a dictionary containing the properties assigned with its target values.

Like [TweenService](https://create.roblox.com/docs/reference/engine/classes/TweenService#Create), the ```goals``` table is similar to the ```propertyTable```, where it needs to be a dictionary with the keys being the desired properties to interpolate, and the value of each key being the final target values of the motion.

The resulting [MotionAnim](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#motionanim) is its own individual object, but unlike the [Tween](https://create.roblox.com/docs/reference/engine/classes/Tween), it can be reused and its public properties are interchangeable.

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
MotionAnim.goals = {
	Position = Vector3.new(1, 1, 1),
	Transparency = 1
}

MotionAnim.duration = 1

 -- You can tween multiple instances.
MotionAnim.focus = {instance_a, instance_b}

-- First argument is the motion framerate
-- and the second is the speed of the motion.
MotionAnim:start(60, 1)
```

---

### :createCurve()

It creates a curve to use for a [MotionAnim](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#motionanim) instance.

```lua
Motion:createCurve(name: string, curve: {number}, accuracy: number?) : ()
```

---

| Parameters          | Description                                                                                    |
| ------------------- | ---------------------------------------------------------------------------------------------  |
| name: [string](https://create.roblox.com/docs/reference/engine/libraries/string) | The identifier for the curve.     |
| curve: {[number](https://create.roblox.com/docs/luau/numbers)} | The 4 control points of a curve. ```{0, 0, 0, 0}``` |
| accuracy: [number?](https://create.roblox.com/docs/luau/numbers) | Controls how many points the curve will generate. |

| Returns |
| ------- |
| None    |

---

The function initiates a curve which is stored internally. To design the curve, [cubic-bezier.com↗](cubic-bezier.com), written by [Lea Verou](https://lea.verou.me/projects/), is recommended to preview and create your own custom curves to import it onto the library.

The accuracy parameter accepts floats from <ins>0–1</ins>, where <ins>0</ins> generates 60 points per curve and <ins>1</ins> generates 240.

Increasing the motion’s duration above 1, or changing ```playback_speed``` stretches the curve, but does not generate additional points. By default, curve accuracy is set to 60 unless overridden using [```.setCurveAccuracy()```]() or by modifying the parameter directly.

## Code Samples
### Instancing a curve

In this example, we will be creating four different curves. ```Ease-in```, ```ease-out```, ```ease-in-out```, and ```ease-out-in```.

```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Motion = require(ReplicatedStorage.Motion)

-- The argument for the name parameter will be used for indexing the-
-- curves to be used for creating a MotionAnim instance.
-- 		@ The accuracy parameter is optional.
Motion:createCurve("ease_in", {.76, .32, .76, .32})
Motion:createCurve("ease_out", {.15, 1, .07, 1})
Motion:createCurve("ease_in_out", {.93, .24, .19, .92}, .5) -- We can change the accuracy!
Motion:createCurve("ease_out_in", {.32, .86, .69, .17}, 1) -- Super accurate animations
```

### Curves used:
<img width="1919" height="1079" alt="Ease In" src="https://github.com/user-attachments/assets/18ae71f6-77e7-4a20-b4f1-94ade399e2ef" />
<img width="1919" height="1079" alt="Ease Out" src="https://github.com/user-attachments/assets/03e94e80-3253-42a7-87a5-850385f09a90" />
<img width="1919" height="1079" alt="Ease In-Out" src="https://github.com/user-attachments/assets/2162aec1-523e-4ede-a371-daed3698fd6c" />
<img width="1919" height="1079" alt="Ease Out-In" src="https://github.com/user-attachments/assets/ab732125-6e3e-4327-a816-e35fa33c204e" />


---

### .setUpdatePriority()
```lua
Motion.setUpdatePriority(priority: number) : ()
```

---

### .setCurveAccuracy()
```lua
Motion.setCurveAccuracy(accuracy: number) : ()
```

---

### .independentUpdate()
```lua
Motion.independentUpdate(enabled: boolean) : ()
```

---

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
