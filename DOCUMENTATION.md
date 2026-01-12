# ✏️ Documentation
<img width="1920" height="480" alt="Motion Logo Blur" src="https://github.com/user-attachments/assets/8f27a517-49b4-4610-a828-053a275c716a" />

---

# Table of Contents

<details>
<summary>🏃‍♂️ Motion</summary>

- [Description](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#%E2%80%8D%EF%B8%8F-motion)
- [Defaults](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#-defaults)
- [Methods](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#%EF%B8%8F-methods)
  - [:createMotion()](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#createmotion)
  - [:createCurve()](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#createcurve)
  - [.setUpdatePriority()](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#setupdatepriority)
  - [.setCurveAccuracy()](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#setcurveaccuracy)
  - [.independentUpdate()](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#independentupdate)
  - [.updateSignal()](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#updatesignal)
</details>

<details>
<summary>💨 MotionAnim</summary>

- [Description](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#-motionanim)
- [Error Cases](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#-error-cases)
- [Defaults](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#-defaults-1)
- [Methods](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#%EF%B8%8F-methods-1)
  - [:start()](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#start)
  - [:stop()](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#stop)
  - [:update()](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#update)
- [Properties](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#%EF%B8%8F-properties)
  - [duration](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#duration)
  - [focus](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#focus)
  - [framerate](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#framerate)
  - [goals](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#goals)
  - [speed](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#speed)
  - [time_position](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#time_position)
</details>

---

## 📌 Quick Start

1. Create a curve using ```Motion:createCurve()```.
2. Create a MotionAnim with ```Motion:createMotion()```.
3. Call ```MotionAnim:start()``` to begin interpolation.

---

# 🏃‍♂️ Motion
Used to create and manage [MotionAnim](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#-motionanim) objects to interpolate instance properties.

Interpolation currently works ONLY on objects with the compatible property types, including:

- [number](https://create.roblox.com/docs/luau/numbers)
- [Vector2](https://create.roblox.com/docs/reference/engine/datatypes/Vector2)
- [Vector3](https://create.roblox.com/docs/reference/engine/datatypes/Vector3)
- [UDim2](https://create.roblox.com/docs/reference/engine/datatypes/UDim2)
- [CFrame](https://create.roblox.com/docs/reference/engine/datatypes/CFrame)
- [Color3](https://create.roblox.com/docs/reference/engine/datatypes/Color3)

## 📋 Defaults
| Property                                                        | Default |
| --------------------------------------------------------------- | ------- |
| accuracy: [number](https://create.roblox.com/docs/luau/numbers) | 0       |

## ✒️ Methods

### :createMotion()

- Creates a [MotionAnim](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#-motionanim) object with the properties to be interpolated.

```lua
Motion:createMotion(curve_name: string, duration: number?, focus: Instance | {Instance}?, goals: Dictionary?) : MotionAnim
```

---

| Parameters          | Description                                                                                                                      |
| ------------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| curve_name: [string](https://create.roblox.com/docs/reference/engine/libraries/string) | The name of the curve to be used.                             |
| duration: [number?](https://create.roblox.com/docs/luau/numbers) | How long the interpolation will take to its target value.                           |
| focus: [Instance \| {Instance}?](https://create.roblox.com/docs/reference/engine/datatypes/Instance) | The desired instance(s) to be interpolated.       |
| goals: [Dictionary?](https://create.roblox.com/docs/luau/tables#dictionaries) | The following properties, set to the final values, to be interpolated. |

| Returns                                                                                |
| -------------------------------------------------------------------------------------- |
| [MotionAnim](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#-motionanim) |

---

The constructor initiates a new [MotionAnim](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#-motionanim) object. To create one, a MotionAnim instance will require four arguments:
the curve to use, the duration of the MotionAnim, the instances to be interpolated, and a dictionary containing the properties assigned with its target values.

Like [TweenService](https://create.roblox.com/docs/reference/engine/classes/TweenService#Create), the ```goals``` table is similar to the ```propertyTable```, where it needs to be a dictionary with the keys being the desired properties to interpolate, and the value of each key being the final target values of the MotionAnim.

The resulting [MotionAnim](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#-motionanim) is its own individual object, but unlike the [Tween](https://create.roblox.com/docs/reference/engine/classes/Tween), it can be reused and its public properties are interchangeable.

---

### Code Samples
#### 1. Creating a MotionAnim instance

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

#### 2. Changing the properties of a MotionAnim instance
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

- It creates a curve to use for a [MotionAnim](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#-motionanim) instance.

```lua
Motion:createCurve(name: string, curve: {number}, accuracy: number?) : ()
```

---

| Parameters          | Description                                                                                        |
| ------------------- | -------------------------------------------------------------------------------------------------- |
| name: [string](https://create.roblox.com/docs/reference/engine/libraries/string) | The identifier for the curve.         |
| curve: {[number](https://create.roblox.com/docs/luau/numbers)} | The 4 control points of a curve. ```{x0, y0, x1, y1}``` |
| accuracy: [number?](https://create.roblox.com/docs/luau/numbers) | Controls how many points the curve will generate.     |

| Returns |
| ------- |
| None    |

---

The function initiates a curve which is stored internally. To design the curve, [cubic-bezier.com↗](cubic-bezier.com), written by [Lea Verou](https://lea.verou.me/projects/), is recommended to preview and create your own custom curves to import it onto the library.

The accuracy parameter accepts floats from ```0–1```, where ```0``` generates **60** points per curve and ```1``` generates **240**.

Increasing the motion’s duration above ```1```, or changing MotionAnim.speed/speed argument stretches the curve, but does not generate additional points. By default, curve accuracy is set to ```0``` unless overridden using [Motion.setCurveAccuracy()]() or by modifying the parameter directly.

Learn more details about how curves work [here↗](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#setcurveaccuracy).

---

### Code Samples
#### 1. Instancing a curve

In this example, we will be creating four different curves.
- [```Ease-In↗```](https://cubic-bezier.com/#.76,.32,.76,.32)
- [```Ease-Out↗```](https://cubic-bezier.com/#.15,1,.07,1)
- [```Ease-In-Out↗```](https://cubic-bezier.com/#.93,.24,.19,.92)
- [```Ease-Out-In↗```](https://cubic-bezier.com/#.32,.86,.69,.17)

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

---

### .setUpdatePriority()

- Changes the internal [RunService](https://create.roblox.com/docs/reference/engine/classes/RunService) update method.

```lua
Motion.setUpdatePriority(priority: number) : ()
```

---

| Parameters          | Description                                                                                       |
| ------------------- | ------------------------------------------------------------------------------------------------- |
| priority: [number](https://create.roblox.com/docs/luau/numbers) | Decides which RunService update signal it should use. |

| Returns |
| ------- |
| None    |

---

The method allows the user to change what [RunService](https://create.roblox.com/docs/reference/engine/classes/RunService) signal method it should use. At default the ```update_priority``` is set to the first one.

The following are the valid indices for each update type.
1. [```RunService.RenderStepped```](https://create.roblox.com/docs/reference/engine/classes/RunService#RenderStepped)
2. [```RunService.PreRender```](https://create.roblox.com/docs/reference/engine/classes/RunService#PreRender)
3. [```RunService.PreAnimation```](https://create.roblox.com/docs/reference/engine/classes/RunService#PreAnimation)
4. [```RunService.Stepped```](https://create.roblox.com/docs/reference/engine/classes/RunService#Stepped)
5. [```RunService.PreSimulation```](https://create.roblox.com/docs/reference/engine/classes/RunService#PreSimulation)
6. [```RunService.Heartbeat```](https://create.roblox.com/docs/reference/engine/classes/RunService#Heartbeat)
7. [```RunService.PostSimulation```](https://create.roblox.com/docs/reference/engine/classes/RunService#PostSimulation)

---

### .setCurveAccuracy()

- Changes the default accuracy for the curve generation.

```lua
Motion.setCurveAccuracy(accuracy: number) : ()
```

---

| Parameters          | Description                                                                                   |
| ------------------- | --------------------------------------------------------------------------------------------- |
| accuracy: [number](https://create.roblox.com/docs/luau/numbers) | Controls how many points the curve will generate. |

| Returns |
| ------- |
| None    |

---

The method handles how accurate the curve should be generated. While the default value for this is ```0```, the user may change the accuracy between the range of ```0-1```. With ```0``` being **60** points for the curve, and ```1``` being **240**.

| Range             | Memory Usage      | Benefits                        | Drawbacks                        |
| ----------------- | ----------------- | ------------------------------- | -------------------------------- |
| Lower : 0 - 0.5   | 0.31 KB - 0.76 KB | Conserves more memory.          | Noticeable "chops" when playing. |
| High ...: 0.6 - 1 | 0.85 KB - 1.21 KB | Fluid and smooth animation.     | Consumes more memory.            |

It is recommended to keep this number as low as possible for the least amount of memory consumption.

---

### .independentUpdate()

- Determines whether the system updates should be handled manually ```true``` or automatically ```false```.

```lua
Motion.independentUpdate(enabled: boolean) : ()
```

---

| Parameters          | Description                                                                                  |
| ------------------- | -------------------------------------------------------------------------------------------- |
| enabled: [boolean](https://create.roblox.com/docs/luau/booleans) | Switches the automatic system update on or off. |

| Returns |
| ------- |
| None    |

---

This allows for the internal update scheduler to be overridden by your own update handler.

Suggested uses for this method include:
- Pausing the MotionAnim instances for a custom pause screen.
- A slowing down effect for the animations (without having to tweak the [MotionAnim.speed](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#speed) property).
- Stuttering effect for the playing animations.

---

### .updateSignal()

- The signal used for all the MotionAnim updates.

```lua
Motion.updateSignal(deltaTime: number) : ()
```

---

| Parameters          | Description                                                                   |
| ------------------- | ----------------------------------------------------------------------------- |
| deltaTime: [number](https://create.roblox.com/docs/luau/numbers) | The time interval for the logic. |

| Returns |
| ------- |
| None    |

---

Note that this method can ONLY be overridden if the [Motion.independentUpdate()](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#independentupdate) method is set to ```true```.

---

# 💨 MotionAnim
The MotionAnim instance handles the logic for the interpolations.

## 🚫 Error cases
Errors will be thrown if:

- There is no curve specified when creating the instance.
- The time_position property is set to a negative number.
- The duration property is set to nil.
- The goals property is set to nil.
- The focus property is set to nil.

## 📋 Defaults
| Property                                                             | Default |
| -------------------------------------------------------------------- | ------- |
| framerate: [number](https://create.roblox.com/docs/luau/numbers)     | 240     |
| speed: [number](https://create.roblox.com/docs/luau/numbers)         | 1       |
| time_position: [number](https://create.roblox.com/docs/luau/numbers) | 0       |

## ✒️ Methods
### :start()

- Starts the MotionAnim and begins interpolating its target properties.

```lua
MotionAnim:start(fps: number?, speed: number?) : ()
```

---

| Parameters          | Description                                                                  |
| ------------------- | ---------------------------------------------------------------------------- |
| fps: [number](https://create.roblox.com/docs/luau/numbers) | The framerate of the MotionAnim.      |
| speed: [number](https://create.roblox.com/docs/luau/numbers) | How fast the MotionAnim is playing. |

| Returns |
| ------- |
| None    |

---

This method is used to start/play the MotionAnim. Once this method is called, calling it again while the MotionAnim is already playing will not register.

The speed determines how quick the MotionAnim reaches its target goal (defaults to ```1```). If the speed is set to ```2```, it will take twice as fast to reach its target.

While the fps determines how many times the MotionAnim is updated every second (defaults to 240). If the fps is set to ```30```, it will update every 1/30th of a second.

Note that this does not reset the [MotionAnim.time_position](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#time_position) value when called.

---

### :stop()

- The method allows the MotionAnim to stop when called.

```lua
MotionAnim:stop() : ()
```

---

| Parameters          | Description                                                                   |
| ------------------- | ----------------------------------------------------------------------------- |
| None | None |

| Returns |
| ------- |
| None    |

---

It stops the MotionAnim completely. When called, the [MotionAnim.time_position](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#time_position) value is reset to ```0```.

The method isn't required before reusing the MotionAnim. Because once the [MotionAnim.time_position](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#time_position) property reaches the [MotionAnim.duration](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#duration) value, it will automatically call this method to stop updating the MotionAnim.

---

### :update()

- The signal used for the MotionAnim's updates.

```lua
MotionAnim:update(deltaTime: number) : ()
```

---

| Parameters          | Description                                                                   |
| ------------------- | ----------------------------------------------------------------------------- |
| deltaTime: [number](https://create.roblox.com/docs/luau/numbers) | The time interval for the logic. |

| Returns |
| ------- |
| None    |

---

Handles the MotionAnim's update logic. Depending on the argument inserted into the deltaTime parameter, it serves its purpose as the time increment that increases/decreases the [MotionAnim.time_position](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#time_position) property.

Note that this method runs individually, and when called, it can be used to update the MotionAnim asynchronously.

---

## ✒️ Properties
> Please note that modifying these properties while the MotionAnim is playing may lead to errors and bugs.

### duration
```lua
MotionAnim.duration: number
```

This sets the length of the MotionAnim.

### focus
```lua
MotionAnim.focus: Instance | {Instance}
```

These are the instances(s) that will have its properties interpolated.

### framerate
```lua
MotionAnim.framerate: number
```

This handles how many times the MotionAnim will be updated within a second.

### goals
```lua
MotionAnim.goals: Dictionary
```

These are the target properties for the MotionAnim. With its desired value set to the name of the property.

### speed
```lua
MotionAnim.speed: number
```

This handles how fast the MotionAnim will be playing.

### time_position
```lua
MotionAnim.time_position: number
```

The value determining where the MotionAnim is currently at ranging from 0 to its [duration](https://github.com/useraoli/Motion/blob/main/DOCUMENTATION.md#duration).

