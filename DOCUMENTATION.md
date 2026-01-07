# Documentation ✏️

---

# Table of Contents

<details>
<summary>Motion</summary>

- [Description]()
- [Methods]()
  - [:createMotion()]()
  - [:createCurve()]()
  - [.setUpdatePriority()]()
  - [.setCurveAccuracy()]()
  - [.independentUpdate()]()
  - [.updateSignal()]()
</details>

<details>
<summary>MotionAnim</summary>

- [Description]()
- [Methods]()
  - [:start()]()
  - [:stop()]()
  - [:update()]()
  - [.setPlaybackSpeed()]()
  - [.setPlaybackFPS()]()
- [Properties]()
  - [duration]()
  - [focus]()
  - [goals]()
</details>

---

# Motion
Used to create [MotionAnim]() objects to interpolate instance properties.

## Methods
### :createMotion()

Creates a [MotionAnim]() object with the properties wish to be interpolated.

```lua
Motion:createMotion(curve_name: string, duration: number?, focus: Instances?, goals: Dictionary?) : MotionAnim
```

| Parameters          | Description                                                                                                                      |
| -------------       | -------------                                                                                                                    |
| curve_name: [string](https://create.roblox.com/docs/reference/engine/libraries/string) | The name of the curve to be used.                             |
| duration: [number?](https://create.roblox.com/docs/luau/numbers) | How long the interpolation will take to reach it's target value.                    |
| focus: [Instances?](https://create.roblox.com/docs/reference/engine/datatypes/Instance) | The desired instances to be interpolated.                    |
| goals: [Dictionary?](https://create.roblox.com/docs/luau/tables#dictionaries) | The following properties, set to the final values, to be interpolated. |

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
