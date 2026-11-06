//! Transpiled from Horizon Rust crate
package horizon_client_render_pack_uniforms

import "core:fmt"
import "core:mem"
import "core:math"

// `invert_generic`, `invert_affine` and the formulas of `pack_projection` and `shadow_ortho` in
// this file are adapted from JOML 1.10.9's `Matrix4f` (https://github.com/JOML-CI/JOML, MIT; see
// THIRD_PARTY_NOTICES.md).
//
// Copyright (c) 2015-2026 Richard Greenlees
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

// The uniforms a shader pack's post-processing programs read once per frame (spec 5.2, class
// F), from the renderer's `Frame` and the few values only the game knows (`PackInputs`).
// Matrices follow GL's conventions (5.5): `gbufferProjection` maps view depth to clip z in
// [-w, w], and the depth buffers packs read hold GL window depth.

// use glam::{DMat4, DVec3, Mat4, Vec3, Vec4};
// use horizon_shaders::Shadow;

// use super::Frame;

// What the game passes for the pack's uniforms, beyond what `Frame` carries.
PackInputs :: struct {
    // `Level.getDayTime`.
    day_time: i64,
    // The interpolated rain and thunder levels, 0..1.
    rain: f32,
    thunder: f32,
    // The fluid at the camera: 0 none, 1 water, 2 lava, 3 powder snow.
    eye_in: i32,
    blindness: f32,
    // Block and sky light at the camera, 0..15.
    eye_light: [i32,
    hide_gui: bool,
    // The brightness option, 0..1.
    brightness: f32,
    // The biome at the camera (3.4): registry id, `CAT_*`, `PPT_*`, temperature, downfall.
    biome: i32,
    biome_category: i32,
    biome_precipitation: i32,
    temperature: f32,
    rainfall: f32,
    // Whether the biome at the camera is known (its chunk is loaded).
    biome_known: bool,
    // `heldItemId`, `heldItemId2` (item.properties, 5.3) and `heldBlockLightValue(2)`.
    held_items: [i32,
    held_light: [i32,
    // `isRightHanded` (the Main Hand option) and `is_on_ground`.
    right_handed: bool,
    on_ground: bool,
    // The dimension type's lowest block (`bedrockLevel`), build height (`heightLimit`),
    // logical height, sky light and ceiling.
    min_y: i32,
    height: i32,
    logical_height: i32,
    has_skylight: bool,
    has_ceiling: bool,
    // `isElytraFlying`: the player is fall flying.
    elytra_flying: bool,
    // `cloudHeight`, see [`cloud_height`].
    cloud_height: f32,
    // `cloudTime`: how far the game's clouds have moved along X, in blocks (`clouds::drift`
    // times vanilla's 0.03 blocks a tick). Iris 1.11.7 gives it, though ShaderDoc doesn't list
    // it: observed with a probe pack, three game times 0.03 apart per tick.
    cloud_time: f32,
    // The values native mods hand their packs (`frame.mods`, `native_shader_params`).
    mod_params: [[f32,
    // The player's state, for Iris's status uniforms.
    status: PlayerStatus,
    // The End flash: its intensity, 0..1 (0 outside the End), and its direction from the
    // camera in world space, of length 100 (`endFlashIntensity`, `endFlashPosition`).
    end_flash: f32,
    end_flash_direction: Vec3,
    // The dimension type's `ambient_light` (`ambientLight`).
    ambient_light: f32,
    // The player's cave mood, 0..1 (`BiomeAmbientSoundsHandler`'s moodiness):
    // `playerMood` and `constantMood`.
    mood: f32,
    // Under `HORIZON_STILL`, the world's ticks: the pack's clock (`frameTimeCounter`,
    // `frameCounter`) instead of the wall clock and the frames drawn, and smoothed values
    // (`wetness`, `eyeBrightnessSmooth`, `centerDepthSmooth`) at their targets.
    still_ticks: Maybe(u64),
}

// The `cloudHeight` uniform: the dimension's `visual/cloud_height`
// (`EnvironmentAttributes.CLOUD_HEIGHT`, 192.33 where the dimension doesn't set it), whether or
// not it has clouds. ShaderDoc says NaN for a dimension without clouds, but Iris 1.11.7 reads
// 192.33 in the Nether and the End, in every program kind our probe packs read it from.
cloud_height :: proc(sky: ^crate::environment::Sky) -> f {
    // Ported from Horizon
    return {}
}
    // rust: sky.cloud_height
}

// The local player's state behind Iris's status uniforms (`currentPlayerHealth`,
// `isSpectator`, `is_burning`...).
PlayerStatus :: struct {
    // Survival or adventure: the vitals are -1 in creative and spectator.
    survival: bool,
    health: f32,
    max_health: f32,
    food: f32,
    // Air supply ticks, of 300.
    air: f32,
    // Armor points (the `armor` attribute).
    armor: f32,
    spectator: bool,
    riding: bool,
    feet_in_water: bool,
    swimming: bool,
    burning: bool,
    hurt: bool,
    invisible: bool,
    sneaking: bool,
    sprinting: bool,
}

// `maxPlayerHunger`, `maxPlayerAir` and `maxPlayerArmor`: Minecraft's own maximums.
MAX_HUNGER :: 20.0
MAX_AIR :: 300.0
MAX_ARMOR :: 50.0

// One uniform's value: up to 16 floats or 3 integers.
Value :: enum {
    F([f32; 16]),
    I([i32; 3]),
}

    // rust: impl Value {
f :: proc(v: ^[f32]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut a = [0.0; 16];
    // rust: a[..v.len()].copy_from_slice(v);
    // rust: Value::F(a)
}
i :: proc(v: ^[i32]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut a = [0; 3];
    // rust: a[..v.len()].copy_from_slice(v);
    // rust: Value::I(a)
}

    // Whether a program that declares the built-in `name` as `ty` reads this value. Iris 1.11.7
    // disables a built-in declared with another GLSL type than the one it gives ("Wrong uniform
    // type ... Disabling that uniform"), and the program reads 0. Our probe packs saw it for a
    // float declared `int` or `vec2`, an int `float`, an `ivec2` `vec2`, `int` or `ivec3`, a
    // `vec3` `vec2` or `vec4`, a `mat4` `mat3`, and any `uint`; an int or a bool built-in
    // declared `bool` or `int` was kept. A float declared `bool` is left as it was: Iris warned,
    // but our probe read true.
read_as :: proc(self: ^Self, name: string, ty: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let int = matches!(self, Value::I(_));
    // rust: let (declared_int, size) = match ty {
    // rust: "float" => (false, 1),
    // rust: "bool" if !int => return true,
    // rust: "int" | "bool" => (true, 1),
    // rust: "mat2" => (false, 4),
    // rust: "mat3" => (false, 9),
    // rust: "mat4" => (false, 16),
    // rust: t if t.starts_with('u') => return false,
    // rust: t if let Some(n) = t.strip_prefix("ivec") => (true, n.parse().unwrap_or(0)),
    // rust: t if let Some(n) = t.strip_prefix("vec") => (false, n.parse().unwrap_or(0)),
    // rust: _ => return true,
}
    // rust: let name = name.strip_prefix("gbuffers.").unwrap_or(name);
    // rust: declared_int == int && size == components(name)
}

    // Writes the value as the type the pack declared, at `offset` of a std140 block.
write :: proc(self: ^Self, ty: string, out: []u8, offset: uint) {
}
    // rust: let ints = matches!(ty, "int" | "bool" | "uint") || ty.starts_with(['i', 'u']);
    // rust: let (floats, integers): ([f32; 16], [i32; 16]) = match *self {
    // rust: Value::F(f) => (f, f.map(|v| v as i32)),
    // rust: Value::I(i) => {
    // rust: let mut f = [0.0; 16];
    // rust: let mut v = [0; 16];
    // rust: for k in 0..3 {
    // rust: f[k] = i[k] as f32;
    // rust: v[k] = i[k];
}
    // rust: (f, v)
}
}
    // rust: let count = match ty {
    // rust: "mat4" => 16,
    // rust: "mat3" => {
                // std140: three columns, each padded to a vec4, from the mat4's upper left.
    // rust: for c in 0..3 {
    // rust: let column: [f32; 3] = std::array::from_fn(|r| floats[c * 4 + r]);
    // rust: put(out, offset + c * 16, bytemuck::cast_slice(&column));
}
    // rust: return;
}
    // rust: t => match t.as_bytes().last() {
    // rust: Some(n @ b'2'..=b'4') if t.contains("vec") => (n - b'0') as usize,
    // rust: _ => 1,
    // rust: },
}
    // rust: if ints {
    // rust: put(out, offset, bytemuck::cast_slice(&integers[..count]));
    // rust: } else {
    // rust: put(out, offset, bytemuck::cast_slice(&floats[..count]));
}
}
}

put :: proc(out: []u8, offset: uint, bytes: []u8) {
}
    // rust: if let Some(dst) = out.get_mut(offset..offset + bytes.len()) {
    // rust: dst.copy_from_slice(bytes);
}
}

// The uniforms provided, in the order of [`FrameUniforms::values`].
    // rust: pub const NAMES: &[&str] = &[
    // rust: "cameraPosition",
    // rust: "previousCameraPosition",
    // rust: "eyeAltitude",
    // rust: "upPosition",
    // rust: "sunPosition",
    // rust: "moonPosition",
    // rust: "shadowLightPosition",
    // rust: "sunAngle",
    // rust: "shadowAngle",
    // rust: "worldTime",
    // rust: "worldDay",
    // rust: "moonPhase",
    // rust: "frameCounter",
    // rust: "frameTime",
    // rust: "frameTimeCounter",
    // rust: "viewWidth",
    // rust: "viewHeight",
    // rust: "aspectRatio",
    // rust: "near",
    // rust: "far",
    // rust: "rainStrength",
    // rust: "wetness",
    // rust: "thunderStrength",
    // rust: "fogColor",
    // rust: "skyColor",
    // rust: "fogMode",
    // rust: "fogStart",
    // rust: "fogEnd",
    // rust: "fogDensity",
    // rust: "fogShape",
    // rust: "isEyeInWater",
    // rust: "blindness",
    // rust: "nightVision",
    // rust: "darknessFactor",
    // rust: "darknessLightFactor",
    // rust: "screenBrightness",
    // rust: "hideGUI",
    // rust: "eyeBrightness",
    // rust: "eyeBrightnessSmooth",
    // rust: "heldItemId",
    // rust: "heldItemId2",
    // rust: "heldBlockLightValue",
    // rust: "heldBlockLightValue2",
    // rust: "renderStage",
    // rust: "biome",
    // rust: "biome_category",
    // rust: "biome_precipitation",
    // rust: "temperature",
    // rust: "rainfall",
    // rust: "gbufferModelView",
    // rust: "gbufferModelViewInverse",
    // rust: "gbufferProjection",
    // rust: "gbufferProjectionInverse",
    // rust: "gbufferPreviousModelView",
    // rust: "gbufferPreviousProjection",
    // rust: "atlasSize",
    // rust: "shadowModelView",
    // rust: "shadowModelViewInverse",
    // rust: "shadowProjection",
    // rust: "shadowProjectionInverse",
    // rust: "cameraPositionInt",
    // rust: "cameraPositionFract",
    // rust: "previousCameraPositionInt",
    // rust: "previousCameraPositionFract",
    // rust: "eyePosition",
    // rust: "relativeEyePosition",
    // rust: "playerLookVector",
    // rust: "playerBodyVector",
    // rust: "firstPersonCamera",
    // rust: "currentPlayerHealth",
    // rust: "maxPlayerHealth",
    // rust: "currentPlayerHunger",
    // rust: "maxPlayerHunger",
    // rust: "currentPlayerAir",
    // rust: "maxPlayerAir",
    // rust: "currentPlayerArmor",
    // rust: "maxPlayerArmor",
    // rust: "isSpectator",
    // rust: "isRiding",
    // rust: "feetInWater",
    // rust: "inSwimmingAnimation",
    // rust: "is_burning",
    // rust: "is_hurt",
    // rust: "is_invisible",
    // rust: "is_sneaking",
    // rust: "is_sprinting",
    // rust: "endFlashIntensity",
    // rust: "endFlashPosition",
    // rust: "ambientLight",
    // rust: "playerMood",
    // rust: "constantMood",
    // rust: "centerDepthSmooth",
    // rust: "alphaTestRef",
    // rust: "entityId",
    // rust: "blockEntityId",
    // rust: "entityColor",
    // rust: GBUFFERS_FOG_MODE,
    // rust: GBUFFERS_FOG_SHAPE,
    // rust: GBUFFERS_CENTER_DEPTH,
    // rust: "isRightHanded",
    // rust: "is_on_ground",
    // rust: "bedrockLevel",
    // rust: "heightLimit",
    // rust: "logicalHeightLimit",
    // rust: "hasSkylight",
    // rust: "hasCeiling",
    // rust: "cloudTime",
    // rust: "isElytraFlying",
    // rust: "cloudHeight",
    // rust: ];

// What programs that draw the game's geometry (gbuffers, shadow) read as `fogMode`,
// `fogShape` and `centerDepthSmooth`: no GLSL name can hold a dot, so no pack reads these
// directly.
GBUFFERS_FOG_MODE :: "gbuffers.fogMode"
GBUFFERS_FOG_SHAPE :: "gbuffers.fogShape"
GBUFFERS_CENTER_DEPTH :: "gbuffers.centerDepthSmooth"

// Values carried from frame to frame.
FrameUniforms :: struct {
    values: [dynamic]Value,
    // The block atlas's size (`atlasSize`), 0 without one.
    atlas: [u32,
    start: std::time::Instant,
    last: Maybe(std::time::Instant),
    frame: u32,
    // The last frame's `PackInputs::still_ticks`, for `eval_custom`.
    still_ticks: Maybe(u64),
    previous: Option<(glam::DVec3,
    wetness: f32,
    eye_smooth: [f32,
    // `depthtex0` at the screen's centre as last read back, and `centerDepthSmooth`.
    center_depth_raw: Maybe(f32),
    center_depth: Maybe(f32),
    // The pack's shadow settings (7.1).
    shadow: Shadow,
}

    // rust: impl Default for FrameUniforms {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: values: Vec::new(),
    // rust: atlas: [0; 2],
    // rust: start: std::time::Instant::now(),
    // rust: last: None,
    // rust: frame: 0,
    // rust: still_ticks: None,
    // rust: previous: None,
    // rust: wetness: 0.0,
    // rust: eye_smooth: [0.0; 2],
    // rust: center_depth_raw: None,
    // rust: center_depth: None,
    // rust: shadow: Shadow::default(),
}
}
}

// `(0, 100, 0)` on the frame the sky draws a body on: Y -90°, then X by its angle in degrees;
// `sunPathRotation` (`tilt`, degrees) then turns the path about the world's X axis (7.1, OQ-6).
body :: proc(angle: f32, tilt: f32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: (tilt_matrix(tilt)
    // rust: * Mat4::from_rotation_y((-90.0f32).to_radians())
    // rust: * Mat4::from_rotation_x(angle.to_radians()))
    // rust: .transform_vector3(Vec3::new(0.0, 100.0, 0.0))
}

// `sunPosition` and `moonPosition` (`angle`: the body's sky angle in degrees) and `upPosition`
// (`angle` none) to the last bit, as Iris 1.11.7 gives them: our probes' readings (50: 25 ticks
// of day and night, `sunPathRotation` 0 and 30, four view directions) fit `(0, 100, 0, 0)`
// times `gbufferModelView` turned by JOML quaternions, in floats: `rotate(rotationY(-90°))`,
// then for a body `rotate(rotationZ(sunPathRotation))` and `rotate(rotationX(angle))`. Turned
// by matrices instead, as `body` and vanilla 26.3's sky do, 4e-6 stands where Iris has an exact
// 0, and the rest differs by 1 to 2 ulps (#8464).
celestial :: proc(view: Mat4, tilt: f32, angle: Maybe(f32)) -> V {
    // Ported from Horizon
    return {}
}
//     use crate::camera::joml::{Mat4 as Joml, Quat};
//     use horizon_core::geometry::trig::DEG_TO_RAD;
    // rust: let mut m = Joml::affine(view);
    // rust: m.rotate_affine(Quat::rotation_y(-90.0 * DEG_TO_RAD));
    // rust: if let Some(angle) = angle {
    // rust: m.rotate_affine(Quat::rotation_z(tilt * DEG_TO_RAD));
    // rust: m.rotate_affine(Quat::rotation_x(angle * DEG_TO_RAD));
}
    // rust: Vec3::from_array(m.transform_affine([0.0, 100.0, 0.0, 0.0]))
}

// `sunPathRotation`'s turn of the sky's bodies: `tilt` degrees about the world's X axis, so a
// positive angle moves the noon sun toward -Z (north), as Iris does.
tilt_matrix :: proc(tilt: f32) -> M {
    // Ported from Horizon
    return {}
}
    // rust: Mat4::from_rotation_x(-tilt.to_radians())
}

// The world direction of the shadow light (7.1): the sun by day, the moon by night.
shadow_light :: proc(frame: ^Frame, shadow: ^Shadow) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let sun_angle = (frame.sky.sun_angle / 360.0 + 0.25).rem_euclid(1.0);
    // rust: let angle = if sun_angle < 0.5 {
    // rust: frame.sky.sun_angle
    // rust: } else {
    // rust: frame.sky.moon_angle
}
    // rust: body(angle, shadow.sun_path_rotation).normalize()
}

// A sky angle in degrees as the fraction of a day Iris 1.11.7 gives packs (`sunAngle`,
// `shadowAngle`): 0 at sunrise, 0.25 at noon. Our probes' readings fit `((angle + 90) % 360)
// / 360` in floats to the last bit, by day and by night.
day_fraction :: proc(degrees: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: (degrees + 90.0) % 360.0 / 360.0
}

// `shadowAngle`: the day fraction of the body that casts the shadows, the sun by day and the
// moon (taken below 360) at night.
shadow_angle :: proc(frame: ^Frame) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let sun = day_fraction(frame.sky.sun_angle);
    // rust: if sun < 0.5 {
    // rust: sun
    // rust: } else {
    // rust: day_fraction(frame.sky.moon_angle % 360.0)
}
}

// The angle in degrees `shadowModelView` turns the light's path by, from `shadowAngle`:
// `(shadowAngle - 0.25) * 360` in floats, plus 360 when that is negative. Our probes' readings
// of Iris 1.11.7 (50: 25 ticks of day and night, among them 7295 to 7305 one by one, with
// `sunPathRotation` 0 and 30) fit this to the last bit; the body's own sky angle, which the
// fraction is made from, misses 16 of them by 1 to 6 ulps (#8464).
shadow_matrix_degrees :: proc(frame: ^Frame) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let degrees = (shadow_angle(frame) - 0.25) * 360.0;
    // rust: if degrees < 0.0 {
    // rust: degrees + 360.0
    // rust: } else {
    // rust: degrees
}
}

// `shadowModelView` and its inverse to the last bit, as Iris 1.11.7 gives them: our probes'
// readings (times of day and night, `sunPathRotation` 0 and 30, cameras off the block grid)
// fit these JOML float operations, in this order: `rotateX(90°)`, `rotateZ(-angle)` with
// `shadow_matrix_degrees`, `rotateX(sunPathRotation)`, then `translate` by minus the origin
// `shadow_camera` describes, from the camera's position as a float; and JOML's `invert()`.
// `shadow_camera`'s view, built in doubles, differs in the last bits (6e-17 for 0), and on a
// texel boundary of the map that is enough to read the other texel (#8464).
shadow_model_view :: proc(frame: ^Frame, shadow: ^Shadow) -> ( {
    // Ported from Horizon
    return {}
}
//     use horizon_core::geometry::trig::DEG_TO_RAD;
    // rust: let mut m = crate::camera::joml::Mat4::IDENTITY;
    // rust: m.rotate_x(90.0 * DEG_TO_RAD);
    // rust: m.rotate_z(-(shadow_matrix_degrees(frame) * DEG_TO_RAD));
    // rust: m.rotate_x(shadow.sun_path_rotation * DEG_TO_RAD);
    // rust: let step = shadow.interval;
    // rust: if step > 0.0 {
    // rust: let camera = frame.camera.as_vec3();
    // rust: let remainder = if shadow.euclidean_snap {
    // rust: camera.rem_euclid(Vec3::splat(step))
    // rust: } else {
    // rust: camera % step
}
    // rust: let origin = Vec3::splat(step / 2.0) - remainder;
    // rust: m.translate(-origin.x, -origin.y, -origin.z);
}
    // rust: let inverse = m
    // rust: .invert_orthonormal()
    // rust: .expect("rotations and a translation are orthonormal");
    // rust: (m.to_glam(), inverse.to_glam())
}

// `gbufferProjection` and its inverse to the last bit, as Iris 1.11.7 gives them: our probes'
// readings fit JOML's `setPerspective` formula worked in doubles from the float field of view
// in radians, the float aspect ratio and the near plane 0.05 as a float, narrowed to floats;
// and JOML's general `invert()` of that, in floats. glam's perspective differs in the last
// bits.
pack_projection :: proc(fov_degrees: f32, aspect: f32, far: f32) -> ( {
    // Ported from Horizon
    return {}
}
//     use horizon_core::geometry::trig::DEG_TO_RAD;
    // rust: let fov = f64::from(fov_degrees * DEG_TO_RAD);
    // rust: let (aspect, near, far) = (f64::from(aspect), f64::from(0.05f32), f64::from(far));
    // rust: let h = (fov * 0.5).tan();
    // rust: let m = glam::DMat4::from_cols(
    // rust: glam::DVec4::new(1.0 / (h * aspect), 0.0, 0.0, 0.0),
    // rust: glam::DVec4::new(0.0, 1.0 / h, 0.0, 0.0),
    // rust: glam::DVec4::new(0.0, 0.0, (far + near) / (near - far), -1.0),
    // rust: glam::DVec4::new(0.0, 0.0, (far + far) * near / (near - far), 0.0),
    // rust: )
    // rust: .as_mat4();
    // rust: (m, invert_generic(m))
}

// JOML's `Matrix4f.invert()` of a matrix with no known shape (`invertGeneric`), operation by
// operation (JOML's `Math.fma` without `joml.useMathFma` is a product and a sum).
invert_generic :: proc(m: Mat4) -> M {
    // Ported from Horizon
    return {}
}
    // rust: let g = |c: usize, r: usize| m.col(c)[r];
    // rust: let (m00, m01, m02, m03) = (g(0, 0), g(0, 1), g(0, 2), g(0, 3));
    // rust: let (m10, m11, m12, m13) = (g(1, 0), g(1, 1), g(1, 2), g(1, 3));
    // rust: let (m20, m21, m22, m23) = (g(2, 0), g(2, 1), g(2, 2), g(2, 3));
    // rust: let (m30, m31, m32, m33) = (g(3, 0), g(3, 1), g(3, 2), g(3, 3));
    // rust: let a = m00 * m11 - m01 * m10;
    // rust: let b = m00 * m12 - m02 * m10;
    // rust: let c = m00 * m13 - m03 * m10;
    // rust: let d = m01 * m12 - m02 * m11;
    // rust: let e = m01 * m13 - m03 * m11;
    // rust: let f = m02 * m13 - m03 * m12;
    // rust: let gg = m20 * m31 - m21 * m30;
    // rust: let h = m20 * m32 - m22 * m30;
    // rust: let i = m20 * m33 - m23 * m30;
    // rust: let j = m21 * m32 - m22 * m31;
    // rust: let k = m21 * m33 - m23 * m31;
    // rust: let l = m22 * m33 - m23 * m32;
    // rust: let det = 1.0 / (a * l - b * k + c * j + d * i - e * h + f * gg);
    // `Math.fma(x, y, z)` unfused.
    // rust: let fma = |x: f32, y: f32, z: f32| x * y + z;
    // rust: Mat4::from_cols_array(&[
    // rust: fma(m11, l, fma(-m12, k, m13 * j)) * det,
    // rust: fma(-m01, l, fma(m02, k, -m03 * j)) * det,
    // rust: fma(m31, f, fma(-m32, e, m33 * d)) * det,
    // rust: fma(-m21, f, fma(m22, e, -m23 * d)) * det,
    // rust: fma(-m10, l, fma(m12, i, -m13 * h)) * det,
    // rust: fma(m00, l, fma(-m02, i, m03 * h)) * det,
    // rust: fma(-m30, f, fma(m32, c, -m33 * b)) * det,
    // rust: fma(m20, f, fma(-m22, c, m23 * b)) * det,
    // rust: fma(m10, k, fma(-m11, i, m13 * gg)) * det,
    // rust: fma(-m00, k, fma(m01, i, -m03 * gg)) * det,
    // rust: fma(m30, e, fma(-m31, c, m33 * a)) * det,
    // rust: fma(-m20, e, fma(m21, c, -m23 * a)) * det,
    // rust: fma(-m10, j, fma(m11, h, -m12 * gg)) * det,
    // rust: fma(m00, j, fma(-m01, h, m02 * gg)) * det,
    // rust: fma(-m30, d, fma(m31, b, -m32 * a)) * det,
    // rust: fma(m20, d, fma(-m21, b, m22 * a)) * det,
    // rust: ])
}

// `shadow_camera`'s view and projection in wgpu's clip space (depth 0..1), for culling.
shadow_culling :: proc(frame: ^Frame, shadow: ^Shadow) -> M {
    // Ported from Horizon
    return {}
}
    // rust: shadow_culling_at(shadow_light(frame, shadow), frame.camera, shadow)
}

// `shadow_culling` for the direction toward the light and the camera's position.
shadow_culling_at :: proc(light: Vec3, camera: DVec3, shadow: ^Shadow) -> M {
    // Ported from Horizon
    return {}
}
    // rust: let (view, gl) = shadow_camera(light, camera, shadow);
    // GL's depth -w..w to wgpu's 0..w.
    // rust: let depth = Mat4::from_cols(
    // rust: Vec4::X,
    // rust: Vec4::Y,
    // rust: Vec4::new(0.0, 0.0, 0.5, 0.0),
    // rust: Vec4::new(0.0, 0.0, 0.5, 1.0),
    // rust: );
    // rust: depth * gl * view
}

// How far toward the light a `shadowMapFov` projection starts, in blocks.
SHADOW_EYE :: 100.0

// The orthographic shadow projection's planes when the pack sets none, as JOML's `zNear` and
// `zFar`: Iris 1.11.7's, measured with a probe pack (each unset plane on its own).
SHADOW_NEAR :: -100.05
SHADOW_FAR :: 156.0

// `shadowProjection` and its inverse to the last bit, as Iris 1.11.7 gives them: our probes'
// readings (13 settings of `shadowDistance`, `shadowNearPlane` and `shadowFarPlane`, each
// plane set or not) fit JOML's `setOrtho` over `shadowDistance` each side with `zZeroToOne`,
// its depth terms then taken to GL's -1..1 (`m22 * 2`, `m32 * 2 - 1`), in floats; and JOML's
// `invertAffine` of that. The planes are the pack's, or `SHADOW_NEAR`/`SHADOW_FAR`: a pack
// that sets one gets it as it is, with no 100-block offset (#8464).
shadow_ortho :: proc(shadow: ^Shadow) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let d = shadow.distance;
    // rust: let near = shadow.near.unwrap_or(SHADOW_NEAR);
    // rust: let far = shadow.far.unwrap_or(SHADOW_FAR);
    // rust: let side = 2.0 / (d - -d);
    // rust: let projection = Mat4::from_cols(
    // rust: Vec4::new(side, 0.0, 0.0, 0.0),
    // rust: Vec4::new(0.0, side, 0.0, 0.0),
    // rust: Vec4::new(0.0, 0.0, 1.0 / (near - far) * 2.0, 0.0),
    // rust: Vec4::new(0.0, 0.0, near / (near - far) * 2.0 - 1.0, 1.0),
    // rust: );
    // rust: (projection, invert_affine(projection))
}

// JOML's `Matrix4f.invertAffine()`, operation by operation.
invert_affine :: proc(m: Mat4) -> M {
    // Ported from Horizon
    return {}
}
    // rust: let g = |c: usize, r: usize| m.col(c)[r];
    // rust: let (m00, m01, m02) = (g(0, 0), g(0, 1), g(0, 2));
    // rust: let (m10, m11, m12) = (g(1, 0), g(1, 1), g(1, 2));
    // rust: let (m20, m21, m22) = (g(2, 0), g(2, 1), g(2, 2));
    // rust: let (m30, m31, m32) = (g(3, 0), g(3, 1), g(3, 2));
    // rust: let (m11m00, m10m01, m10m02) = (m00 * m11, m01 * m10, m02 * m10);
    // rust: let (m12m00, m12m01, m11m02) = (m00 * m12, m01 * m12, m02 * m11);
    // rust: let det = (m11m00 - m10m01) * m22 + (m10m02 - m12m00) * m21 + (m12m01 - m11m02) * m20;
    // rust: let s = 1.0 / det;
    // rust: let (m10m22, m10m21, m11m22) = (m10 * m22, m10 * m21, m11 * m22);
    // rust: let (m11m20, m12m21, m12m20) = (m11 * m20, m12 * m21, m12 * m20);
    // rust: let (m20m02, m20m01, m21m02) = (m20 * m02, m20 * m01, m21 * m02);
    // rust: let (m21m00, m22m01, m22m00) = (m21 * m00, m22 * m01, m22 * m00);
    // rust: Mat4::from_cols_array(&[
    // rust: (m11m22 - m12m21) * s,
    // rust: (m21m02 - m22m01) * s,
    // rust: (m12m01 - m11m02) * s,
    // rust: 0.0,
    // rust: (m12m20 - m10m22) * s,
    // rust: (m22m00 - m20m02) * s,
    // rust: (m10m02 - m12m00) * s,
    // rust: 0.0,
    // rust: (m10m21 - m11m20) * s,
    // rust: (m20m01 - m21m00) * s,
    // rust: (m11m00 - m10m01) * s,
    // rust: 0.0,
    // rust: (m10m22 * m31 - m10m21 * m32 + m11m20 * m32 - m11m22 * m30 + m12m21 * m30 - m12m20 * m31)
    // rust: * s,
    // rust: (m20m02 * m31 - m20m01 * m32 + m21m00 * m32 - m21m02 * m30 + m22m01 * m30 - m22m00 * m31)
    // rust: * s,
    // rust: (m11m02 * m30 - m12m01 * m30 + m12m00 * m31 - m10m02 * m31 + m10m01 * m32 - m11m00 * m32)
    // rust: * s,
    // rust: 1.0,
    // rust: ])
}

// The shadow camera as Iris places it (7.1; measured from the outside): its view (player
// space to shadow view space) and GL projection. The view undoes `sunPathRotation`, turns the
// light's path about Z by the light's angle from the zenith, then X by 90 degrees, so the
// light lies on the view's +Z. Its origin is `shadowIntervalSize / 2 - camera % interval`
// (the remainder takes the camera's sign) from the player on each world axis, so the map moves
// in whole steps. The orthographic projection is `shadow_ortho`'s; or perspective with
// `shadowMapFov`, from `shadowNearPlane` (0.05) to `shadowFarPlane` (256) counted from
// `SHADOW_EYE` blocks toward the light.
shadow_camera :: proc(light: Vec3, camera: DVec3, shadow: ^Shadow) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let tilt = f64::from(shadow.sun_path_rotation).to_radians();
    // rust: let untilted = DMat4::from_rotation_x(tilt).transform_vector3(light.as_dvec3());
    // rust: let zenith = untilted.x.atan2(untilted.y);
    // rust: let rotation = DMat4::from_rotation_x(std::f64::consts::FRAC_PI_2)
    // rust: * DMat4::from_rotation_z(zenith)
    // rust: * DMat4::from_rotation_x(tilt);
    // rust: let step = f64::from(shadow.interval);
    // rust: let origin = if step > 0.0 {
    // rust: let remainder = if shadow.euclidean_snap {
    // rust: camera.rem_euclid(DVec3::splat(step))
    // rust: } else {
    // rust: camera % step
}
    // rust: DVec3::splat(step / 2.0) - remainder
    // rust: } else {
    // rust: DVec3::ZERO
}
    // rust: let view = (rotation * DMat4::from_translation(-origin)).as_mat4();
    // rust: let projection = match shadow.fov {
    // rust: Some(fov) => {
    // rust: let (near, far) = (shadow.near.unwrap_or(0.05), shadow.far.unwrap_or(256.0));
    // rust: let eye = Mat4::from_translation(Vec3::new(0.0, 0.0, -SHADOW_EYE));
    // rust: Mat4::perspective_rh_gl(fov.to_radians(), 1.0, near, far) * eye
}
    // rust: None => shadow_ortho(shadow).0,
}
    // rust: (view, projection)
}

// The seconds a tick of a smoothing half-life (`wetnessHalflife`, `eyeBrightnessHalflife`,
// `centerDepthHalflife`) lasts in Iris 1.11.7: measured, twice a game tick.
SECONDS_A_TICK :: 0.1

// `value` moved toward `target` with a half-life of `half_life` seconds over `dt` (5.6).
smooth :: proc(value: f32, target: f32, half_life: f32, dt: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: target + (value - target) * 0.5f32.powf(dt / half_life)
}

    // rust: impl FrameUniforms {
    // This frame's values for a render size of `size` pixels.
update :: proc(self: ^Self, frame: ^Frame, inputs: ^PackInputs, size: [u32; 2]) {
}
    // rust: let now = std::time::Instant::now();
    // rust: let measured = self.last.map_or(0.0, |l| (now - l).as_secs_f32());
    // rust: self.last = Some(now);
    // rust: self.still_ticks = inputs.still_ticks;
        // Smoothing over an endless step lands on its target.
    // rust: let dt = inputs.still_ticks.map_or(measured, |_| f32::INFINITY);
    // rust: let aspect = size[0] as f32 / size[1].max(1) as f32;
        // Packs take gbufferProjection for a plain perspective (they invert only its perspective
        // terms): the view bob and the nausea spin belong to the model-view, as GL drew them.
        // Vanilla's view rotation to the last bit (Iris 1.11.7's gbufferModelView and its inverse
        // match it bit for bit in our probes): fragments on a texel boundary of the shadow map
        // then read the same texel as in Iris (#8464).
    // rust: let (rotation, rotation_inverse) =
    // rust: crate::camera::view_rotation_matrix(frame.yaw, frame.pitch);
    // rust: let (view, view_inverse) = if frame.bob == Mat4::IDENTITY && frame.spin == Mat4::IDENTITY {
    // rust: (rotation, rotation_inverse)
    // rust: } else {
    // rust: let view = frame.bob * frame.spin * rotation;
    // rust: (view, view.inverse())
}
    // rust: let (projection, projection_inverse) =
    // rust: pack_projection(frame.fov_degrees, aspect, frame.depth_far);
    // rust: let camera = frame.camera.as_vec3();
    // rust: let first_frame = self.previous.is_none();
    // rust: let (previous_exact, previous_view, previous_projection) =
    // rust: self.previous.unwrap_or((frame.camera, view, projection));
    // rust: let previous_camera = previous_exact.as_vec3();
    // rust: self.previous = Some((frame.camera, view, projection));
        // The camera's whole blocks and the rest, exact however far from the origin.
    // rust: let whole = |p: glam::DVec3| p.floor();
    // rust: let int = |p: glam::DVec3| Value::i(&whole(p).as_ivec3().to_array());
    // rust: let fract = |p: glam::DVec3| Value::f(&(p - whole(p)).as_vec3().to_array());
        // The player's, not the camera's: in a third-person view the camera is behind (or in
        // front of, turned around) the eye the pack lights from.
    // rust: let [yaw, pitch] = frame.eye_rotation.map(f32::to_radians);
    // rust: let look = Vec3::new(
    // rust: -yaw.sin() * pitch.cos(),
    // rust: -pitch.sin(),
    // rust: yaw.cos() * pitch.cos(),
    // rust: );

    // rust: let to_view = |v: Vec3| view.transform_vector3(v);
    // rust: let sun_angle = day_fraction(frame.sky.sun_angle);
    // rust: let day = sun_angle < 0.5;
    // rust: let tilt = self.shadow.sun_path_rotation;
    // rust: let sun = celestial(view, tilt, Some(frame.sky.sun_angle));
    // rust: let moon = celestial(view, tilt, Some(frame.sky.moon_angle));
        // Half-lives are given in ticks (7.2); smoothing runs per frame in seconds (OQ-26), at
        // a tenth of a second a tick: Iris 1.11.7 smooths that slowly (measured frame by frame
        // with a probe pack: wetness 60 s rising, 20 s falling; eyeBrightnessSmooth 1 s;
        // centerDepthSmooth 0.1 s).
    // rust: let half_life = if inputs.rain > self.wetness {
    // rust: 600.0
    // rust: } else {
    // rust: 200.0
}
    // rust: self.wetness = smooth(self.wetness, inputs.rain, half_life * SECONDS_A_TICK, dt);
    // rust: let eye = inputs.eye_light.map(|l| (l * 16) as f32);
    // rust: if first_frame {
    // rust: self.wetness = inputs.rain;
    // rust: self.eye_smooth = eye;
}
    // rust: for (smoothed, target) in self.eye_smooth.iter_mut().zip(eye) {
    // rust: *smoothed = smooth(*smoothed, target, 10.0 * SECONDS_A_TICK, dt);
}
        // `centerDepthHalflife`'s default, 1 tick (OptiFine's shaders.txt); the first value
        // read back is taken as it is.
    // rust: if let Some(raw) = self.center_depth_raw {
    // rust: self.center_depth = Some(match self.center_depth {
    // rust: Some(v) => smooth(v, raw, SECONDS_A_TICK, dt),
    // rust: None => raw,
    // rust: });
}
    // rust: let center_depth = self.center_depth.unwrap_or(1.0);
        // Vanilla fades by the stronger of two linear fogs; a pack gets the environmental one
        // (`FogData::environmental_start`/`environmental_end`), as Iris 1.11.7 gives it in every
        // program kind: 0 to 1024 on a clear day, -160 to 768 in rain, -8 to 96 under water, 10
        // to 96 in the Nether (measured with a probe pack).
    // rust: let (fog_color, fog_start, fog_end) = match &frame.fog {
    // rust: Some(f) => (
    // rust: [f.color[0], f.color[1], f.color[2]],
    // rust: f.environmental_start,
    // rust: f.environmental_end,
    // rust: ),
    // rust: None => (frame.sky.fog_color, frame.distance * 0.9, frame.distance),
}
    // rust: let light = shadow_light(frame, &self.shadow);
    // rust: let (shadow_projection, shadow_projection_inverse) = match self.shadow.fov {
    // rust: Some(_) => {
    // rust: let (_, projection) = shadow_camera(light, frame.camera, &self.shadow);
    // rust: (projection, projection.inverse())
}
    // rust: None => shadow_ortho(&self.shadow),
}
    // rust: let (shadow_view, shadow_view_inverse) = shadow_model_view(frame, &self.shadow);
    // rust: let day_time = inputs.day_time.rem_euclid(24000) as i32;
    // rust: let world_day = inputs.day_time.div_euclid(24000);
    // rust: let (seconds, frame_time, frame_counter) = match inputs.still_ticks {
    // rust: Some(ticks) => (
    // rust: (ticks as f32 / 20.0) % 3600.0,
    // rust: 0.05,
    // rust: (ticks % 720_720) as i32,
    // rust: ),
    // rust: None => (
    // rust: (now - self.start).as_secs_f32() % 3600.0,
    // rust: measured,
    // rust: self.frame as i32,
    // rust: ),
}

    // rust: let value = |name: &str| -> Value {
    // rust: let v3 = |v: Vec3| Value::f(&v.to_array());
    // rust: let m4 = |m: Mat4| Value::f(&m.to_cols_array());
    // rust: match name {
    // rust: "cameraPosition" => v3(camera),
    // rust: "previousCameraPosition" => v3(previous_camera),
    // rust: "cameraPositionInt" => int(frame.camera),
    // rust: "cameraPositionFract" => fract(frame.camera),
    // rust: "previousCameraPositionInt" => int(previous_exact),
    // rust: "previousCameraPositionFract" => fract(previous_exact),
                // The camera is the eye in first person.
    // rust: "eyePosition" => v3(frame.eye.as_vec3()),
    // rust: "relativeEyePosition" => v3((frame.camera - frame.eye).as_vec3()),
    // rust: "playerLookVector" | "playerBodyVector" => v3(look),
    // rust: "firstPersonCamera" => Value::i(&[i32::from(frame.first_person)]),
    // rust: "isRightHanded" => Value::i(&[i32::from(inputs.right_handed)]),
    // rust: "is_on_ground" => Value::i(&[i32::from(inputs.on_ground)]),
    // rust: "bedrockLevel" => Value::i(&[inputs.min_y]),
    // rust: "heightLimit" => Value::i(&[inputs.height]),
    // rust: "logicalHeightLimit" => Value::i(&[inputs.logical_height]),
    // rust: "hasSkylight" => Value::i(&[i32::from(inputs.has_skylight)]),
    // rust: "hasCeiling" => Value::i(&[i32::from(inputs.has_ceiling)]),
    // rust: "eyeAltitude" => Value::f(&[frame.camera.y as f32]),
    // rust: "upPosition" => v3(celestial(view, tilt, None)),
    // rust: "sunPosition" => v3(sun),
    // rust: "endFlashPosition" => v3(to_view(inputs.end_flash_direction)),
    // rust: "centerDepthSmooth" => Value::f(&[center_depth]),
    // rust: "moonPosition" => v3(moon),
    // rust: "shadowLightPosition" => v3(if day { sun } else { moon }),
    // rust: "sunAngle" => Value::f(&[sun_angle]),
    // rust: "shadowAngle" => Value::f(&[shadow_angle(frame)]),
    // rust: "worldTime" => Value::i(&[day_time]),
    // rust: "worldDay" => Value::i(&[world_day as i32]),
    // rust: "moonPhase" => Value::i(&[world_day.rem_euclid(8) as i32]),
    // rust: "frameCounter" => Value::i(&[frame_counter]),
    // rust: "shadowModelView" => m4(shadow_view),
    // rust: "shadowModelViewInverse" => m4(shadow_view_inverse),
    // rust: "shadowProjection" => m4(shadow_projection),
    // rust: "shadowProjectionInverse" => m4(shadow_projection_inverse),
    // rust: "atlasSize" => Value::i(&[self.atlas[0] as i32, self.atlas[1] as i32]),
    // rust: "frameTime" => Value::f(&[frame_time]),
    // rust: "frameTimeCounter" => Value::f(&[seconds]),
    // rust: "viewWidth" => Value::f(&[size[0] as f32]),
    // rust: "viewHeight" => Value::f(&[size[1] as f32]),
    // rust: "aspectRatio" => Value::f(&[aspect]),
    // rust: "near" => Value::f(&[0.05]),
                // The chunk render distance, not the distant terrain's reach.
    // rust: "far" => Value::f(&[frame.detail_distance]),
    // rust: "rainStrength" => Value::f(&[inputs.rain]),
    // rust: "wetness" => Value::f(&[self.wetness]),
    // rust: "thunderStrength" => Value::f(&[inputs.thunder]),
    // rust: "fogColor" => Value::f(&fog_color),
    // rust: "skyColor" => Value::f(&frame.sky.sky_color),
                // Iris 1.11.7, measured: programs that draw no geometry read no fog mode (0) and
                // shape (-1); those that do read GL_LINEAR and a cylinder (1). The density is 0.
    // rust: "fogMode" => Value::i(&[0]),
    // rust: GBUFFERS_FOG_MODE => Value::i(&[9729]),
    // rust: "fogStart" => Value::f(&[fog_start]),
    // rust: "fogEnd" => Value::f(&[fog_end]),
    // rust: "fogDensity" => Value::f(&[0.0]),
    // rust: "fogShape" => Value::i(&[-1]),
    // rust: GBUFFERS_FOG_SHAPE => Value::i(&[1]),
                // Iris 1.11.7 gives gbuffers programs 0 (measured in 16 scenes).
    // rust: GBUFFERS_CENTER_DEPTH => Value::f(&[0.0]),
                // Outside a draw (gbuffers programs get these per draw), as Iris 1.11.7 gives
                // them to composite and final programs (measured).
    // rust: "alphaTestRef" => Value::f(&[0.1]),
    // rust: "blockEntityId" => Value::i(&[-1]),
    // rust: "entityColor" => Value::f(&[0.0; 4]),
    // rust: "isEyeInWater" => Value::i(&[inputs.eye_in]),
    // rust: "blindness" => Value::f(&[inputs.blindness]),
    // rust: "nightVision" => Value::f(&[frame.night_vision]),
    // rust: "darknessFactor" => Value::f(&[frame.darkness.0]),
    // rust: "darknessLightFactor" => Value::f(&[frame.darkness.1]),
    // rust: "screenBrightness" => Value::f(&[inputs.brightness]),
    // rust: "hideGUI" => Value::i(&[inputs.hide_gui as i32]),
    // rust: "eyeBrightness" => Value::i(&eye.map(|v| v as i32)),
    // rust: "biome" => Value::i(&[inputs.biome]),
    // rust: "biome_category" => Value::i(&[inputs.biome_category]),
    // rust: "biome_precipitation" => Value::i(&[inputs.biome_precipitation]),
    // rust: "temperature" => Value::f(&[inputs.temperature]),
    // rust: "rainfall" => Value::f(&[inputs.rainfall]),
                // Rounded down, as Iris 1.11.7 gives it (probe pack).
    // rust: "eyeBrightnessSmooth" => Value::i(&self.eye_smooth.map(|v| v.floor() as i32)),
    // rust: "gbufferModelView" => m4(view),
    // rust: "gbufferModelViewInverse" => m4(view_inverse),
    // rust: "gbufferProjection" => m4(projection),
    // rust: "gbufferProjectionInverse" => m4(projection_inverse),
    // rust: "gbufferPreviousModelView" => m4(previous_view),
    // rust: "gbufferPreviousProjection" => m4(previous_projection),
    // rust: "heldItemId" => Value::i(&[inputs.held_items[0]]),
    // rust: "heldItemId2" => Value::i(&[inputs.held_items[1]]),
    // rust: "heldBlockLightValue" => Value::i(&[inputs.held_light[0]]),
    // rust: "heldBlockLightValue2" => Value::i(&[inputs.held_light[1]]),
    // rust: "isElytraFlying" => Value::i(&[inputs.elytra_flying as i32]),
    // rust: "cloudHeight" => Value::f(&[inputs.cloud_height]),
    // rust: "cloudTime" => Value::f(&[inputs.cloud_time]),
    // rust: "ambientLight" => Value::f(&[inputs.ambient_light]),
                // Iris 1.11.7 gave both the same value in every scene measured.
    // rust: "playerMood" | "constantMood" => Value::f(&[inputs.mood]),
                // renderStage is NONE outside gbuffers draws.
    // rust: _ => status_value(name, inputs).unwrap_or(Value::i(&[0])),
}
}
    // rust: self.values.clear();
    // rust: self.values.extend(NAMES.iter().map(|n| value(n)));
    // rust: self.frame = (self.frame + 1) % 720_720;
}

    // `hz_fog_color` and `hz_fog` of the translator's block (the compatibility `gl_Fog`).
    // Its density is `fogDensity`'s (0): Iris 1.11.7 gave `gl_Fog.density` 0, not 1, in every
    // program kind our probe pack read it in (gbuffers_terrain and deferred, in a cave and in
    // the Nether), where `fogDensity` read 0 too.
fog :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let get = |name| match index(name).and_then(|i| self.values.get(i)) {
    // rust: Some(Value::F(f)) => *f,
    // rust: _ => [0.0; 16],
}
    // rust: let (color, start, end) = (get("fogColor"), get("fogStart")[0], get("fogEnd")[0]);
    // rust: [
    // rust: Vec4::new(color[0], color[1], color[2], 1.0),
    // rust: Vec4::new(
    // rust: get("fogDensity")[0],
    // rust: start,
    // rust: end,
    // rust: 1.0 / (end - start).max(1e-3),
    // rust: ),
    // rust: ]
}
}

    // rust: impl FrameUniforms {
    // Evaluates the pack's custom uniforms with this frame's values and puts them after
    // `NAMES`' values, in `custom.uniforms()` order.
eval_custom :: proc(self: ^Self, custom: ^horizon_shaders::Custom) {
}
    // rust: if let Some(tick) = self.still_ticks {
    // rust: custom.restart_at(tick);
}
    // rust: self.values.truncate(NAMES.len());
    // rust: let values = &self.values;
    // rust: let builtin = |name: &str| {
    // rust: let v = values.get(index(name)?)?;
    // rust: let n = components(name);
    // rust: Some(match *v {
    // rust: Value::F(f) => horizon_shaders::Val::vector(&f.map(f64::from)[..n]),
    // rust: Value::I(i) => horizon_shaders::Val::vector(&i.map(f64::from)[..n.min(3)]),
    // rust: })
}
    // rust: let dt = match index("frameTime").and_then(|i| values.get(i)) {
    // rust: Some(Value::F(f)) => f64::from(f[0]),
    // rust: _ => 0.0,
}
    // rust: let out = custom.eval(dt, &builtin);
    // rust: self.values
    // rust: .extend(out.iter().map(|v| Value::f(&v.v.map(|x| x as f32)[..v.n])));
}
}

// Iris's player status and dimension uniforms, from `inputs`: the vitals are fractions of
// their maximum, and -1 (with the maximums of health and air) in creative and spectator.
status_value :: proc(name: string, inputs: ^PackInputs) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let status = inputs.status;
    // rust: let vital = |v: f32| {
    // rust: Value::f(&[if status.survival {
    // rust: v.clamp(0.0, 1.0)
    // rust: } else {
    // rust: -1.0
    // rust: }])
}
    // rust: let flag = |b: bool| Value::i(&[i32::from(b)]);
    // rust: Some(match name {
    // rust: "currentPlayerHealth" => vital(status.health / status.max_health.max(1.0)),
    // rust: "maxPlayerHealth" => Value::f(&[if status.survival {
    // rust: status.max_health
    // rust: } else {
    // rust: -1.0
    // rust: }]),
    // rust: "currentPlayerHunger" => vital(status.food / MAX_HUNGER),
    // rust: "maxPlayerHunger" => Value::f(&[MAX_HUNGER]),
    // rust: "currentPlayerAir" => vital(status.air / MAX_AIR),
    // rust: "maxPlayerAir" => Value::f(&[if status.survival { MAX_AIR } else { -1.0 }]),
    // rust: "currentPlayerArmor" => vital(status.armor / MAX_ARMOR),
    // rust: "maxPlayerArmor" => Value::f(&[MAX_ARMOR]),
    // rust: "isSpectator" => flag(status.spectator),
    // rust: "isRiding" => flag(status.riding),
    // rust: "feetInWater" => flag(status.feet_in_water),
    // rust: "inSwimmingAnimation" => flag(status.swimming),
    // rust: "is_burning" => flag(status.burning),
    // rust: "is_hurt" => flag(status.hurt),
        // Spectators count as invisible.
    // rust: "is_invisible" => flag(status.invisible || status.spectator),
    // rust: "is_sneaking" => flag(status.sneaking),
    // rust: "is_sprinting" => flag(status.sprinting),
    // rust: "endFlashIntensity" => Value::f(&[inputs.end_flash]),
    // rust: _ => return None,
    // rust: })
}

// How many components the uniform `name` has (16 for a matrix).
components :: proc(name: string) -> u {
    // Ported from Horizon
    return {}
}
    // rust: match name {
    // rust: "cameraPosition"
    // rust: | "previousCameraPosition"
    // rust: | "cameraPositionInt"
    // rust: | "cameraPositionFract"
    // rust: | "previousCameraPositionInt"
    // rust: | "previousCameraPositionFract"
    // rust: | "eyePosition"
    // rust: | "relativeEyePosition"
    // rust: | "playerLookVector"
    // rust: | "playerBodyVector"
    // rust: | "upPosition"
    // rust: | "sunPosition"
    // rust: | "moonPosition"
    // rust: | "shadowLightPosition"
    // rust: | "fogColor"
    // rust: | "skyColor"
    // rust: | "endFlashPosition" => 3,
    // rust: "eyeBrightness" | "eyeBrightnessSmooth" | "atlasSize" => 2,
    // rust: "entityColor" => 4,
    // rust: n if n.starts_with("gbuffer") || n.starts_with("shadow") && n != "shadowAngle" => 16,
    // rust: _ => 1,
}
}

// What `name` gives custom uniforms before the first frame: zeros, at its size, so their
// shapes check out as on a frame (#9086).
zero :: proc(name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: index(name)?;
    // rust: Some(horizon_shaders::Val::vector(&[0.0; 16][..components(name)]))
}

// The position of `name` in [`NAMES`].
index :: proc(name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: NAMES.iter().position(|n| *n == name)
}

// The position in [`NAMES`] of the value a program reads as `name`; `geometry`: the program
// draws the game's geometry (gbuffers, shadow), which reads its own fog mode and shape and no
// centre depth.
index_in :: proc(name: string, geometry: bool) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match name {
    // rust: "fogMode" if geometry => index(GBUFFERS_FOG_MODE),
    // rust: "fogShape" if geometry => index(GBUFFERS_FOG_SHAPE),
    // rust: "centerDepthSmooth" if geometry => index(GBUFFERS_CENTER_DEPTH),
    // rust: _ => index(name),
}
}

    // rust: mod tests {
//     use super::*;

values_follow_the_declared_type :: proc() {
}
    // rust: let mut out = vec![0u8; 64];
    // rust: Value::i(&[7]).write("float", &mut out, 0);
    // rust: assert_eq!(f32::from_ne_bytes(out[0..4].try_into().unwrap()), 7.0);
    // rust: Value::f(&[1.5, 2.5]).write("ivec2", &mut out, 4);
    // rust: assert_eq!(i32::from_ne_bytes(out[8..12].try_into().unwrap()), 2);
    // rust: Value::i(&[1]).write("bool", &mut out, 16);
    // rust: assert_eq!(i32::from_ne_bytes(out[16..20].try_into().unwrap()), 1);
    // rust: Value::f(&[1.0; 16]).write("mat4", &mut out, 60);
    // rust: assert_eq!(out[60..64], [0; 4], "a value past the block is dropped");
}

    // The declarations our probe packs (#9307) ran in Iris 1.11.7: kept, or read as 0.
built_ins_are_read_only_as_iris_gives_them :: proc() {
}
    // rust: let int = Value::i(&[1]);
    // rust: let float = Value::f(&[0.25]);
    // rust: let matrix = Value::f(&[1.0; 16]);
    // rust: for (value, name, ty, kept) in [
    // rust: (&int, "isSpectator", "bool", true),
    // rust: (&int, "isSpectator", "int", true),
    // rust: (&int, "worldTime", "bool", true),
    // rust: (&int, "worldTime", "uint", false),
    // rust: (&int, "worldTime", "float", false),
    // rust: (&Value::i(&[2048, 2048]), "atlasSize", "ivec2", true),
    // rust: (&Value::i(&[2048, 2048]), "atlasSize", "vec2", false),
    // rust: (&Value::i(&[2048, 2048]), "atlasSize", "int", false),
    // rust: (&Value::i(&[2048, 2048]), "atlasSize", "ivec3", false),
    // rust: (&float, "sunAngle", "float", true),
    // rust: (&float, "sunAngle", "vec2", false),
    // rust: (&float, "viewWidth", "int", false),
    // rust: (&Value::f(&[1.0, 2.0, 3.0]), "cameraPosition", "vec3", true),
    // rust: (&Value::f(&[1.0, 2.0, 3.0]), "cameraPosition", "vec4", false),
    // rust: (&Value::f(&[1.0, 2.0, 3.0]), "cameraPosition", "vec2", false),
    // rust: (&matrix, "gbufferModelView", "mat4", true),
    // rust: (&matrix, "gbufferModelView", "mat3", false),
    // rust: (&Value::i(&[1]), GBUFFERS_FOG_MODE, "int", true),
    // rust: ] {
    // rust: assert_eq!(value.read_as(name, ty), kept, "{ty} {name}");
}
}

    // The load-time run of custom uniforms sees each built-in at its size: Iris 1.11.7 reads 2
    // for the first line of our probes K and X (#9086) and 0 for the others.
custom_uniforms_check_the_shapes_of_built_ins_before_the_first_frame :: proc() {
}
    // rust: let properties = horizon_shaders::Properties::parse(
    // rust: "uniform.vec3.a = skyColor * vec3(0.0, 0.0, 0.0) + vec3(2.0, 2.0, 2.0)\n\
    // rust: uniform.float.b = skyColor\n\
    // rust: uniform.float.c = gbufferModelView * 0.0 + 2.0\n",
    // rust: &horizon_shaders::Macros::standard(),
    // rust: );
    // rust: let mut custom = horizon_shaders::Custom::parse(&properties);
    // rust: custom.eval(0.0, &zero);
    // rust: let broken: Vec<&str> = custom.notes.iter().map(|n| &n[1..2]).collect();
    // rust: assert_eq!(broken, ["b", "c"], "{:?}", custom.notes);
}

    // Iris's status uniforms as its documentation defines them (shaders.properties, "Status").
status_uniforms_follow_iris :: proc() {
}
    // rust: let float = |name: &str, inputs: &PackInputs| match status_value(name, inputs) {
    // rust: Some(Value::F(f)) => f[0],
    // rust: other => panic!("{name}: {other:?}"),
}
    // rust: let int = |name: &str, inputs: &PackInputs| match status_value(name, inputs) {
    // rust: Some(Value::I(i)) => i[0],
    // rust: other => panic!("{name}: {other:?}"),
}
    // rust: let mut inputs = PackInputs {
    // rust: status: PlayerStatus {
    // rust: survival: true,
    // rust: health: 15.0,
    // rust: max_health: 20.0,
    // rust: food: 10.0,
    // rust: air: 150.0,
    // rust: armor: 20.0,
    // rust: sneaking: true,
    // rust: ..Default::default()
    // rust: },
    // rust: ..Default::default()
}
        // The vitals are fractions of their maximums.
    // rust: assert_eq!(float("currentPlayerHealth", &inputs), 0.75);
    // rust: assert_eq!(float("maxPlayerHealth", &inputs), 20.0);
    // rust: assert_eq!(float("currentPlayerHunger", &inputs), 0.5);
    // rust: assert_eq!(float("maxPlayerHunger", &inputs), 20.0);
    // rust: assert_eq!(float("currentPlayerAir", &inputs), 0.5);
    // rust: assert_eq!(float("maxPlayerAir", &inputs), 300.0);
    // rust: assert_eq!(float("currentPlayerArmor", &inputs), 0.4);
    // rust: assert_eq!(float("maxPlayerArmor", &inputs), 50.0);
    // rust: assert_eq!(int("is_sneaking", &inputs), 1);
    // rust: assert_eq!(int("is_invisible", &inputs), 0);
        // Creative and spectator: -1 for the vitals and the maximums of health and air;
        // spectators are invisible.
    // rust: inputs.status.survival = false;
    // rust: inputs.status.spectator = true;
    // rust: for name in [
    // rust: "currentPlayerHealth",
    // rust: "maxPlayerHealth",
    // rust: "currentPlayerHunger",
    // rust: "currentPlayerAir",
    // rust: "maxPlayerAir",
    // rust: "currentPlayerArmor",
    // rust: ] {
    // rust: assert_eq!(float(name, &inputs), -1.0, "{name}");
}
    // rust: assert_eq!(float("maxPlayerHunger", &inputs), 20.0);
    // rust: assert_eq!(float("maxPlayerArmor", &inputs), 50.0);
    // rust: assert_eq!(int("isSpectator", &inputs), 1);
    // rust: assert_eq!(int("is_invisible", &inputs), 1);
        // Each is provided, not left at zero for the pack.
    // rust: for name in [
    // rust: "currentPlayerHealth",
    // rust: "isSpectator",
    // rust: "is_sprinting",
    // rust: "bedrockLevel",
    // rust: ] {
    // rust: assert!(index(name).is_some(), "{name} is not provided");
}
    // rust: assert!(
    // rust: NAMES
    // rust: .iter()
    // rust: .filter(|n| status_value(n, &inputs).is_some())
    // rust: .count()
    // rust: == 18
    // rust: );
}

    // A dimension type of `attributes` (JSON), loaded as the game loads one and sampled at noon.
sky_of :: proc(name: string, attributes: string) -> c {
    // Ported from Horizon
    return {}
}
    // rust: let root = std::env::temp_dir().join(format!(
    // rust: "horizon-cloud-height-{}-{name}",
    // rust: std::process::id()
    // rust: ));
    // rust: let dir = root.join("data/minecraft/dimension_type");
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: std::fs::write(
    // rust: dir.join(format!("{name}.json")),
    // rust: format!(r#"{{"attributes": {attributes}}}"#),
    // rust: )
    // rust: .unwrap();
    // rust: let environment =
    // rust: crate::environment::Environment::load_dimension(&root, name, false).unwrap();
    // rust: std::fs::remove_dir_all(&root).unwrap();
    // rust: environment.sample(6000, None, None)
}

cloud_height_is_the_dimensions_with_or_without_clouds :: proc() {
}
        // Our probe packs read 192.33 in Iris 1.11.7's Nether and End, whose dimension types
        // set neither a cloud colour nor a cloud height.
    // rust: let nether = sky_of(
    // rust: "nether_like",
    // rust: r##"{"minecraft:visual/fog_start_distance": 10.0, "minecraft:visual/fog_end_distance": 96.0}"##,
    // rust: );
    // rust: assert_eq!(nether.cloud_color[3], 0.0, "no clouds");
    // rust: assert_eq!(cloud_height(&nether), 192.33);
    // rust: let cloudy = sky_of(
    // rust: "cloudy",
    // rust: r##"{"minecraft:visual/cloud_color": "#ccffffff", "minecraft:visual/cloud_height": 120.0}"##,
    // rust: );
    // rust: assert_eq!(cloud_height(&cloudy), 120.0);
}

elytra_and_cloud_height_uniforms_are_written :: proc() {
}
    // rust: assert!(NAMES.ends_with(&["isElytraFlying", "cloudHeight"]));
    // rust: let mut out = vec![0u8; 16];
    // rust: Value::i(&[1]).write("bool", &mut out, 0);
    // rust: assert_eq!(i32::from_ne_bytes(out[0..4].try_into().unwrap()), 1);
    // rust: Value::f(&[192.33]).write("float", &mut out, 4);
    // rust: assert_eq!(f32::from_ne_bytes(out[4..8].try_into().unwrap()), 192.33);
    // rust: Value::f(&[f32::NAN]).write("float", &mut out, 8);
    // rust: assert!(f32::from_ne_bytes(out[8..12].try_into().unwrap()).is_nan());
}

noon_is_straight_up_and_the_sun_sets_in_the_west :: proc() {
}
    // rust: assert!(body(0.0, 0.0).abs_diff_eq(Vec3::new(0.0, 100.0, 0.0), 1e-3));
    // rust: assert!(body(90.0, 0.0).abs_diff_eq(Vec3::new(-100.0, 0.0, 0.0), 1e-3));
        // sunPathRotation tilts noon toward -Z and leaves sunset on the horizon.
    // rust: assert!(body(0.0, 30.0).abs_diff_eq(Vec3::new(0.0, 86.60254, -50.0), 1e-3));
    // rust: assert!(body(90.0, 30.0).abs_diff_eq(Vec3::new(-100.0, 0.0, 0.0), 1e-3));
}

the_shadow_camera_looks_down_from_the_light_in_steps :: proc() {
}
    // rust: let shadow = Shadow::default();
    // rust: let mut camera = DVec3::new(1000.3, 70.0, -20.7);
        // Noon: the light is straight up.
    // rust: let (view, projection) = shadow_camera(Vec3::Y, camera, &shadow);
    // rust: let at = |p: Vec3| view.transform_point3(p);
        // Straight down: a block below the player is farther from the light.
    // rust: assert!(at(Vec3::new(0.0, -1.0, 0.0)).z < at(Vec3::ZERO).z);
        // The view's origin is interval / 2 - camera % interval from the player on each axis,
        // the remainder with the camera's sign: up to a step and a half on negative axes.
    // rust: let origin = view.inverse().w_axis.truncate();
    // rust: assert!(
    // rust: origin.abs_diff_eq(Vec3::new(0.7, 1.0, 1.7), 1e-3),
    // rust: "{origin}"
    // rust: );
        // Moving within a step keeps the world where it was in the map.
    // rust: camera.x = 1000.6;
    // rust: let (moved, _) = shadow_camera(Vec3::Y, camera, &shadow);
    // rust: let world = Vec3::new(5.0, -3.0, 9.0);
    // rust: let shift = Vec3::new(0.3, 0.0, 0.0);
    // rust: assert!(
    // rust: moved
    // rust: .transform_point3(world - shift)
    // rust: .abs_diff_eq(at(world), 1e-3)
    // rust: );
        // shadowDistance blocks reach the map's edge.
    // rust: let edge = projection.project_point3(Vec3::new(160.0, 0.0, 0.0));
    // rust: assert!((edge.x.abs() - 1.0).abs() < 1e-4, "{edge}");
}

    // Iris's matrices at 3000 ticks with `sunPathRotation = 30` and the camera at
    // (0.5, -58.38, 0.5), read from its uniforms by a probe pack.
the_shadow_camera_matches_iris :: proc() {
}
    // rust: let shadow = Shadow {
    // rust: sun_path_rotation: 30.0,
    // rust: ..Shadow::default()
}
    // rust: let light = Vec3::new(0.56782, 0.71287, -0.41158).normalize();
    // rust: let (view, projection) = shadow_camera(light, DVec3::new(0.5, -58.38, 0.5), &shadow);
    // rust: let iris_view = Mat4::from_cols_array_2d(&[
    // rust: [0.82315, 0.0, 0.56782, 0.0],
    // rust: [-0.49175, -0.5, 0.71287, 0.0],
    // rust: [0.28391, -0.86603, -0.41158, 0.0],
    // rust: [0.12508, 1.12301, -1.06188, 1.0],
    // rust: ]);
    // rust: assert!(view.abs_diff_eq(iris_view, 2e-4), "{view}");
    // rust: assert!(
    // rust: (projection.z_axis.z + 0.0078110).abs() < 1e-6,
    // rust: "{projection}"
    // rust: );
    // rust: assert!((projection.w_axis.z + 0.21851).abs() < 1e-4, "{projection}");
        // Elsewhere the origin keeps to the steps: Iris put it at (-0.5, 1.38, 2.5) here.
    // rust: let (view, _) = shadow_camera(light, DVec3::new(3.5, -58.38, -1.5), &shadow);
    // rust: let origin = view.inverse().w_axis.truncate();
    // rust: assert!(
    // rust: origin.abs_diff_eq(Vec3::new(-0.5, 1.38, 2.5), 1e-3),
    // rust: "{origin}"
    // rust: );
}
}

    // rust: mod initial_history_tests {
//     use super::*;
//     use crate::hud::HudBatch;
float :: proc(u: ^FrameUniforms, name: string) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: match u.values[index(name).unwrap()] {
    // rust: Value::F(v) => v,
    // rust: _ => panic!("float uniform expected"),
}
}
    // The bits of a matrix uniform.
bits :: proc(u: ^FrameUniforms, name: string) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: float(u, name).map(f32::to_bits)
}

    // `shadowProjection` and its inverse to the last bit, as a probe pack of ours read them
    // back in Iris 1.11.7, for `shadowDistance`, `shadowNearPlane` and `shadowFarPlane` (none
    // meaning the pack doesn't set it): a plane the pack sets is taken as it is, with no
    // 100-block offset; one it doesn't set is -100.05 (near) or 156 (far).
the_shadow_projection_is_iris_s_for_the_pack_s_planes :: proc() {
}
    // rust: let hud = HudBatch::new([1280, 720]);
    // rust: let f = frame(&hud);
    // rust: let (o, z, one) = (0, 0x80000000, 0x3f800000);
    // rust: type Case = (f32, Option<f32>, Option<f32>, [u32; 4], [u32; 4]);
        // (distance, near, far, [side, m22, m32, -], [inverse side, m22, m32, -])
    // rust: let cases: [Case; 5] = [
    // rust: (
    // rust: 100.0,
    // rust: None,
    // rust: None,
    // rust: [0x3c23d70a, 0xbbfff335, 0xbe5fc198, 0],
    // rust: [0x42c80001, 0xc3000666, 0xc1dfccc8, 0],
    // rust: ),
    // rust: (
    // rust: 100.0,
    // rust: Some(0.5),
    // rust: Some(128.0),
    // rust: [0x3c23d70a, 0xbc808081, 0xbf810101, 0],
    // rust: [0x42c80000, 0xc27f0000, 0xc2808000, 0],
    // rust: ),
    // rust: (
    // rust: 100.0,
    // rust: None,
    // rust: Some(128.0),
    // rust: [0x3c23d70a, 0xbc0fb013, 0xbdfb0128, 0],
    // rust: [0x42c80000, 0xc2e40ccc, 0xc15f9994, 0],
    // rust: ),
    // rust: (
    // rust: 100.0,
    // rust: Some(0.05),
    // rust: None,
    // rust: [0x3c23d70a, 0xbc521e5f, 0xbf801503, 0],
    // rust: [0x42c80000, 0xc29bf333, 0xc29c0ccd, 0],
    // rust: ),
    // rust: (
    // rust: 127.3,
    // rust: Some(1.7),
    // rust: Some(333.3),
    // rust: [0x3c00b42f, 0xbbc5a2bf, 0xbf814ffb, 0],
    // rust: [0x42fe9999, 0xc325cccc, 0xc3277fff, 0],
    // rust: ),
    // rust: ];
    // rust: for (distance, near, far, [side, m22, m32, _], [i_side, i22, i32, _]) in cases {
    // rust: let mut u = FrameUniforms {
    // rust: shadow: Shadow {
    // rust: distance,
    // rust: near,
    // rust: far,
    // rust: ..Shadow::default()
    // rust: },
    // rust: ..FrameUniforms::default()
}
    // rust: u.update(&f, &PackInputs::default(), [1280, 720]);
    // rust: assert_eq!(
    // rust: bits(&u, "shadowProjection"),
    // rust: [side, o, o, o, o, side, o, o, o, o, m22, o, o, o, m32, one],
    // rust: "{near:?} {far:?}"
    // rust: );
    // rust: assert_eq!(
    // rust: bits(&u, "shadowProjectionInverse"),
    // rust: [
    // rust: i_side, z, z, o, z, i_side, z, o, z, z, i22, o, z, z, i32, one
    // rust: ],
    // rust: "{near:?} {far:?}"
    // rust: );
}
}

    // Iris 1.11.7's camera and shadow matrices to the last bit, read back from its uniforms by
    // a probe pack of ours: on a texel boundary of the shadow map the last bit decides which
    // texel a fragment reads (#8464). Noon at 6000 ticks, looking west (yaw 90) with vanilla's
    // flying field of view (76.99999°) at 1280×720, the camera at (13.5, 69.62, -13.5).
the_matrices_are_iris_to_the_last_bit :: proc() {
}
    // rust: let hud = HudBatch::new([1280, 720]);
    // rust: let mut f = frame(&hud);
    // rust: f.camera = DVec3::new(13.5, 68.0 + f64::from(1.62f32), -13.5);
    // rust: f.yaw = 90.0;
    // rust: f.pitch = 0.0;
    // rust: f.fov_degrees = f32::from_bits(0x4299ffff);
    // rust: f.depth_far = 1024.0;
    // rust: f.sky.sun_angle = 0.0;
    // rust: f.sky.moon_angle = 180.0;
    // rust: let mut u = FrameUniforms::default();
    // rust: u.update(&f, &PackInputs::default(), [1280, 720]);
    // rust: let (o, one, minus) = (0, 0x3f800000, 0xbf800000);
    // rust: let (z, almost) = (0x80000000, 0x3f7fffff);
    // rust: assert_eq!(
    // rust: bits(&u, "gbufferModelView"),
    // rust: [
    // rust: o, o, almost, o, o, almost, o, o, 0xbf7fffff, o, o, o, o, o, o, one
    // rust: ]
    // rust: );
    // rust: assert_eq!(
    // rust: bits(&u, "gbufferModelViewInverse"),
    // rust: [
    // rust: o, o, 0xbf7fffff, o, o, almost, o, o, almost, o, o, o, z, z, z, one
    // rust: ]
    // rust: );
    // rust: assert_eq!(
    // rust: bits(&u, "gbufferProjection"),
    // rust: [
    // rust: 0x3f350867, o, o, o, o, 0x3fa0eb07, o, o, o, o, 0xbf800333, minus, o, o,
    // rust: 0xbdcccf5c, o
    // rust: ]
    // rust: );
    // rust: assert_eq!(
    // rust: bits(&u, "gbufferProjectionInverse"),
    // rust: [
    // rust: 0x3fb5017f, z, z, z, z, 0x3f4ba1af, o, z, z, z, z, 0xc11ffe00, z, z, minus,
    // rust: 0x41200200
    // rust: ]
    // rust: );
        // The origin's height is the camera's as a float, 69.620003, in steps of 2.
    // rust: assert_eq!(
    // rust: bits(&u, "shadowModelView"),
    // rust: [
    // rust: one, o, o, o, o, o, one, o, o, minus, z, o, 0x3f000000, 0x40200000, 0x3f1eb880, one
    // rust: ]
    // rust: );
    // rust: assert_eq!(
    // rust: bits(&u, "shadowModelViewInverse"),
    // rust: [
    // rust: one, o, o, o, o, o, minus, o, o, one, z, o, 0xbf000000, 0xbf1eb880, 0x40200000, one
    // rust: ]
    // rust: );
    // rust: assert_eq!(float(&u, "sunAngle")[0].to_bits(), 0x3e800000);

        // 9000 ticks (the sun 34.598564° past noon), yaw 200, pitch -30.
    // rust: f.yaw = 200.0;
    // rust: f.pitch = -30.0;
    // rust: f.sky.sun_angle = f32::from_bits(0x420a64ee);
    // rust: f.sky.moon_angle = f.sky.sun_angle + 180.0;
    // rust: u.update(&f, &PackInputs::default(), [1280, 720]);
    // rust: assert_eq!(
    // rust: bits(&u, "gbufferModelView"),
    // rust: [
    // rust: 0x3f708fb1, 0xbe2f1d41, 0xbe97a745, o, o, 0x3f5db3d6, 0xbefffffe, o, 0x3eaf1d41,
    // rust: 0x3ef08fb0, 0x3f50550b, o, o, o, o, one
    // rust: ]
    // rust: );
    // rust: assert_eq!(
    // rust: bits(&u, "shadowModelView"),
    // rust: [
    // rust: 0x3f52b9ff, o, 0xbf115cdb, o, 0x3f115cdb, o, 0x3f52b9ff, o, o, minus, z, o,
    // rust: 0x3f437d12, 0x40200000, 0x3e67e0f2, one
    // rust: ]
    // rust: );
    // rust: assert_eq!(float(&u, "sunAngle")[0].to_bits(), 0x3eb134f4);
}

    // `sunPosition`, `moonPosition`, `upPosition` and `shadowLightPosition` to the last bit, as
    // a probe pack of ours read them back in Iris 1.11.7: noon looking west, just after sunset
    // looking south (where Iris's sun is exactly 0 in z), and with `sunPathRotation = 30` at
    // 1000 ticks, at 13000 looking down 45° and at 12786 with yaw 200, pitch -30. The sky
    // angles are vanilla's timeline at those ticks.
the_sun_moon_and_up_are_iris_s_to_the_last_bit :: proc() {
}
    // rust: let hud = HudBatch::new([1280, 720]);
    // rust: let mut f = frame(&hud);
    // rust: let o = 0;
    // rust: type Case = (f32, f32, f32, u32, u32, [[u32; 3]; 3], bool);
    // rust: let cases: [Case; 5] = [
    // rust: (
    // rust: 0.0,
    // rust: 90.0,
    // rust: 0.0,
    // rust: 0,
    // rust: 0x43340000,
    // rust: [[o, 0x42c7fffe, o], [o, 0xc2c7fffe, o], [o, 0x42c7fffe, o]],
    // rust: true,
    // rust: ),
    // rust: (
    // rust: 0.0,
    // rust: 0.0,
    // rust: 0.0,
    // rust: 0x42b420b1,
    // rust: 0x4387082c,
    // rust: [
    // rust: [0x42c7fff7, 0xbde43dae, o],
    // rust: [0xc2c7fff7, 0x3de4376e, o],
    // rust: [o, 0x42c7ffff, o],
    // rust: ],
    // rust: false,
    // rust: ),
    // rust: (
    // rust: 30.0,
    // rust: 90.0,
    // rust: 0.0,
    // rust: 0x4394c5da,
    // rust: 0x43eec5da,
    // rust: [
    // rust: [0x41b8fb81, 0x42203312, 0x42b15411],
    // rust: [0xc1b8fb8c, 0xc220331b, 0xc2b1540f],
    // rust: [o, 0x42c7fffe, o],
    // rust: ],
    // rust: true,
    // rust: ),
    // rust: (
    // rust: 30.0,
    // rust: 0.0,
    // rust: 45.0,
    // rust: 0x42bb0aec,
    // rust: 0x4388c2bb,
    // rust: [
    // rust: [0x42c79f54, 0xbfcb7a52, 0xc0bdd8f1],
    // rust: [0xc2c79f54, 0x3fcb7a25, 0x40bdd8c7],
    // rust: [o, 0x428d6bdc, 0x428d6bde],
    // rust: ],
    // rust: false,
    // rust: ),
    // rust: (
    // rust: 30.0,
    // rust: 200.0,
    // rust: -30.0,
    // rust: 0x42b420b1,
    // rust: 0x4387082c,
    // rust: [
    // rust: [0xc2bbe678, 0x41885944, 0x41edb502],
    // rust: [0x42bbe677, 0xc1885947, 0xc1edb4fc],
    // rust: [o, 0x42ad347e, 0xc247fffe],
    // rust: ],
    // rust: false,
    // rust: ),
    // rust: ];
    // rust: for (tilt, yaw, pitch, sun, moon, [sun_at, moon_at, up], day) in cases {
    // rust: f.yaw = yaw;
    // rust: f.pitch = pitch;
    // rust: f.sky.sun_angle = f32::from_bits(sun);
    // rust: f.sky.moon_angle = f32::from_bits(moon);
    // rust: let mut u = FrameUniforms {
    // rust: shadow: Shadow {
    // rust: sun_path_rotation: tilt,
    // rust: ..Shadow::default()
    // rust: },
    // rust: ..FrameUniforms::default()
}
    // rust: u.update(&f, &PackInputs::default(), [1280, 720]);
    // rust: let vector = |name: &str| -> [u32; 3] {
    // rust: let v = bits(&u, name);
    // rust: [v[0], v[1], v[2]]
}
    // rust: assert_eq!(vector("sunPosition"), sun_at, "{sun:x}");
    // rust: assert_eq!(vector("moonPosition"), moon_at, "{sun:x}");
    // rust: assert_eq!(vector("upPosition"), up, "{sun:x}");
    // rust: let light = if day { sun_at } else { moon_at };
    // rust: assert_eq!(vector("shadowLightPosition"), light, "{sun:x}");
}
}

    // At night the moon casts the shadows, here with `sunPathRotation = 30`: Iris 1.11.7 at
    // 16000 ticks (the moon at 324.4897°), the camera at (-556.5, 76.62, 212.5), whose
    // negative x keeps its sign in the remainder.
the_moon_s_shadow_matrices_are_iris_to_the_last_bit :: proc() {
}
    // rust: let hud = HudBatch::new([1280, 720]);
    // rust: let mut f = frame(&hud);
    // rust: f.camera = DVec3::new(-556.5, 75.0 + f64::from(1.62f32), 212.5);
    // rust: f.sky.sun_angle = f32::from_bits(0x43107d5b);
    // rust: f.sky.moon_angle = f32::from_bits(0x43a23eae);
    // rust: let mut u = FrameUniforms {
    // rust: shadow: Shadow {
    // rust: sun_path_rotation: 30.0,
    // rust: ..Shadow::default()
    // rust: },
    // rust: ..FrameUniforms::default()
}
    // rust: u.update(&f, &PackInputs::default(), [1280, 720]);
    // rust: let (o, one) = (0, 0x3f800000);
    // rust: assert_eq!(
    // rust: bits(&u, "shadowModelView"),
    // rust: [
    // rust: 0x3f506307, o, 0x3f14b28c, o, 0xbf00c699, 0xbf000000, 0x3f3477e1, o, 0x3e94b28c,
    // rust: 0xbf5db3d7, 0xbed06307, o, 0xbf9668fb, 0x3f1f7dac, 0xbf6f86e4, one
    // rust: ]
    // rust: );
    // rust: assert_eq!(
    // rust: bits(&u, "shadowModelViewInverse"),
    // rust: [
    // rust: 0x3f506307, 0xbf00c699, 0x3e94b28c, o, o, 0xbf000000, 0xbf5db3d7, o, 0x3f14b28c,
    // rust: 0x3f3477e1, 0xbed06307, o, 0x3fc00000, 0x3ec28f00, 0x3effffff, one
    // rust: ]
    // rust: );
    // rust: assert_eq!(float(&u, "sunAngle")[0].to_bits(), 0x3f26bf8b);
    // rust: assert_eq!(float(&u, "shadowAngle")[0].to_bits(), 0x3e1afe2e);
}

    // Between whole ticks of the timeline, Iris 1.11.7 turns `shadowModelView` by an angle made
    // from `shadowAngle`, not by the sky's own angle: read back by a probe pack of ours at 7297,
    // 7300 and 16000 ticks, and at 7303 with `sunPathRotation = 30`, the camera at
    // (13.5, 69.62, -13.5). The sky angles are vanilla's timeline at those ticks.
the_shadow_matrices_turn_by_iris_s_angle_between_ticks :: proc() {
}
    // rust: let hud = HudBatch::new([1280, 720]);
    // rust: let mut f = frame(&hud);
    // rust: f.camera = DVec3::new(13.5, 68.0 + f64::from(1.62f32), -13.5);
    // rust: let (o, z, one, minus) = (0, 0x80000000, 0x3f800000, 0xbf800000);
    // rust: let cases: [(f32, u32, u32, [u32; 16], [u32; 16]); 4] = [
    // rust: (
    // rust: 0.0,
    // rust: 0x415d5e10,
    // rust: 0x4341d5e1,
    // rust: [
    // rust: 0x3f789291, o, 0xbe74dfb0, o, 0x3e74dfb0, o, 0x3f789291, o, o, minus, z, o,
    // rust: 0x3f223deb, 0x40200000, 0x3ef7034a, one,
    // rust: ],
    // rust: [
    // rust: 0x3f789291, 0x3e74dfb0, o, o, o, o, minus, o, 0xbe74dfb0, 0x3f789291, z, o,
    // rust: 0xbf000000, 0xbf1eb87f, 0x40200000, one,
    // rust: ],
    // rust: ),
    // rust: (
    // rust: 0.0,
    // rust: 0x415de96f,
    // rust: 0x4341de97,
    // rust: [
    // rust: 0x3f788940, o, 0xbe7576d1, o, 0x3e7576d1, o, 0x3f788940, o, o, minus, z, o,
    // rust: 0x3f2250af, 0x40200000, 0x3ef6d1f4, one,
    // rust: ],
    // rust: [
    // rust: 0x3f788940, 0x3e7576d1, o, o, o, o, minus, o, 0xbe7576d1, 0x3f788940, z, o,
    // rust: 0xbeffffff, 0xbf1eb87f, 0x40200000, one,
    // rust: ],
    // rust: ),
    // rust: (
    // rust: 0.0,
    // rust: 0x43107d5b,
    // rust: 0x43a23eae,
    // rust: [
    // rust: 0x3f506307, o, 0x3f14b28c, o, 0xbf14b28c, z, 0x3f506307, o, o, minus, z, o,
    // rust: 0x3d400268, 0x40200000, 0x3f4b8c94, one,
    // rust: ],
    // rust: [
    // rust: 0x3f506307, 0xbf14b28c, o, o, o, z, minus, o, 0x3f14b28c, 0x3f506307, z, o,
    // rust: 0xbf000000, 0xbf1eb880, 0x40200000, one,
    // rust: ],
    // rust: ),
    // rust: (
    // rust: 30.0,
    // rust: 0x415e74d7,
    // rust: 0x4341e74d,
    // rust: [
    // rust: 0x3f787fe8, o, 0xbe760e06, o, 0x3e5516f6, 0xbf000000, 0x3f5734fd, o,
    // rust: 0xbdf60e06, 0xbf5db3d7, 0xbef87fe8, o, 0x3f6a2bc6, 0x3fed72ac, 0x3fcea5f8, one,
    // rust: ],
    // rust: [
    // rust: 0x3f787fe8, 0x3e5516f6, 0xbdf60e06, o, o, 0xbf000000, 0xbf5db3d7, o,
    // rust: 0xbe760e06, 0x3f5734fd, 0xbef87fe8, o, 0xbf000001, 0xbf1eb881, 0x40200000, one,
    // rust: ],
    // rust: ),
    // rust: ];
    // rust: for (tilt, sun, moon, view, inverse) in cases {
    // rust: f.sky.sun_angle = f32::from_bits(sun);
    // rust: f.sky.moon_angle = f32::from_bits(moon);
    // rust: let mut u = FrameUniforms {
    // rust: shadow: Shadow {
    // rust: sun_path_rotation: tilt,
    // rust: ..Shadow::default()
    // rust: },
    // rust: ..FrameUniforms::default()
}
    // rust: u.update(&f, &PackInputs::default(), [1280, 720]);
    // rust: assert_eq!(bits(&u, "shadowModelView"), view, "{sun:x}");
    // rust: assert_eq!(bits(&u, "shadowModelViewInverse"), inverse, "{sun:x}");
}
}

first_history_is_current_then_tracks_the_actual_previous_frame :: proc() {
}
    // rust: let hud = HudBatch::new([800, 450]);
    // rust: let mut f = frame(&hud);
    // rust: let mut u = FrameUniforms::default();
    // rust: f.camera = DVec3::new(1024.25, -3.5, 11.75);
    // rust: f.yaw = 21.0;
    // rust: f.pitch = -16.0;
    // rust: u.update(&f, &PackInputs::default(), [800, 450]);
    // rust: assert_eq!(
    // rust: float(&u, "previousCameraPosition"),
    // rust: float(&u, "cameraPosition")
    // rust: );
    // rust: for (prior, current) in [
    // rust: ("gbufferPreviousProjection", "gbufferProjection"),
    // rust: ("gbufferPreviousModelView", "gbufferModelView"),
    // rust: ] {
    // rust: assert_eq!(float(&u, prior), float(&u, current));
    // rust: assert!(float(&u, prior).iter().any(|v| *v != 0.0));
}
    // rust: let camera = float(&u, "cameraPosition");
    // rust: let view = float(&u, "gbufferModelView");
    // rust: let projection = float(&u, "gbufferProjection");
    // rust: f.camera = DVec3::new(-100.0, 20.0, 40.0);
    // rust: f.yaw = 90.0;
    // rust: f.pitch = 50.0;
    // rust: f.fov_degrees = 100.0;
    // rust: u.update(&f, &PackInputs::default(), [1000, 500]);
    // rust: assert_eq!(float(&u, "previousCameraPosition"), camera);
    // rust: assert_eq!(float(&u, "gbufferPreviousModelView"), view);
    // rust: assert_eq!(float(&u, "gbufferPreviousProjection"), projection);
    // rust: assert_ne!(
    // rust: float(&u, "previousCameraPosition"),
    // rust: float(&u, "cameraPosition")
    // rust: );
}
    // Iris 1.11.7 (probe pack, a world saved at game time 5073 and loaded about ten seconds
    // before): `cloudTime` read 157.98, 160.56 and 163.11, four seconds apart. That is the
    // clouds' drift at 0.03 blocks a tick, 5266 ticks in.
cloud_time_is_how_far_the_clouds_drifted :: proc() {
}
    // rust: let hud = HudBatch::new([800, 450]);
    // rust: let f = frame(&hud);
    // rust: let mut u = FrameUniforms::default();
    // rust: let drift = crate::clouds::drift(5266, 0.0, 256);
    // rust: let input = PackInputs {
    // rust: cloud_time: drift as f32 * 0.030_000_001,
    // rust: ..Default::default()
}
    // rust: u.update(&f, &input, [800, 450]);
    // rust: assert!((float(&u, "cloudTime")[0] - 157.98).abs() < 1e-3);
        // A trip across the 256-cell texture takes 256 * 400 ticks, then starts again.
    // rust: assert_eq!(crate::clouds::drift(256 * 400 + 3, 0.25, 256), 3.25);
}

environmental_smoothing_starts_at_the_first_inputs_without_resetting_each_frame :: proc() {
}
    // rust: let hud = HudBatch::new([800, 450]);
    // rust: let f = frame(&hud);
    // rust: let mut u = FrameUniforms::default();
    // rust: let mut input = PackInputs {
    // rust: rain: 0.75,
    // rust: eye_light: [3, 14],
    // rust: ..Default::default()
}
    // rust: u.update(&f, &input, [800, 450]);
    // rust: assert_eq!(float(&u, "wetness")[0], 0.75);
    // rust: match u.values[index("eyeBrightnessSmooth").unwrap()] {
    // rust: Value::I(v) => assert_eq!(&v[..2], &[48, 224]),
    // rust: _ => panic!("integer uniform expected"),
}
    // rust: input.rain = 0.0;
    // rust: input.eye_light = [0, 0];
    // rust: u.update(&f, &input, [800, 450]);
    // rust: assert!(float(&u, "wetness")[0] > 0.0);
    // rust: assert!(u.eye_smooth.iter().all(|v| *v > 0.0));
}
    // Actual provider bytes through translated GLSL and a GPU pixel, with a nonidentity
    // model-view/projection and a distant camera. Geometry is already camera-relative.
core_matrix_inputs_render_provider_values :: proc() {
}
    // rust: let instance = wgpu::Instance::new(wgpu::InstanceDescriptor::new_without_display_handle());
    // rust: let adapter = pollster::block_on(instance.request_adapter(&Default::default())).unwrap();
    // rust: eprintln!("Core matrix GPU: {:?}", adapter.get_info());
    // rust: let (device, queue) =
    // rust: pollster::block_on(adapter.request_device(&Default::default())).unwrap();
    // rust: let hud = HudBatch::new([800, 400]);
    // rust: let mut f = frame(&hud);
    // rust: f.camera = DVec3::new(1024.25, 100.5, -2048.75);
    // rust: f.yaw = 180.0;
    // rust: f.pitch = 0.0;
    // rust: f.fov_degrees = 90.0;
    // rust: f.bob = Mat4::from_translation(Vec3::new(0.5, -0.25, 0.0));
    // rust: let mut values = FrameUniforms::default();
    // rust: values.update(&f, &PackInputs::default(), [800, 400]);
    // rust: for (declaration, setup, projection, view, expected) in [
    // rust: (
    // rust: "",
    // rust: "",
    // rust: "projectionMatrix",
    // rust: "modelViewMatrix",
    // rust: [64u8, 64, 128, 255],
    // rust: ),
    // rust: (
    // rust: "uniform mat4 projectionMatrix, modelViewMatrix;",
    // rust: "",
    // rust: "projectionMatrix",
    // rust: "modelViewMatrix",
    // rust: [64, 64, 128, 255],
    // rust: ),
    // rust: (
    // rust: "",
    // rust: "",
    // rust: "gl_ProjectionMatrix",
    // rust: "gl_ModelViewMatrix",
    // rust: [64, 64, 128, 255],
    // rust: ),
    // rust: (
    // rust: "",
    // rust: "mat4 projectionMatrix = mat4(2.0); mat4 modelViewMatrix = mat4(3.0);",
    // rust: "projectionMatrix",
    // rust: "modelViewMatrix",
    // rust: [128, 191, 255, 255],
    // rust: ),
    // rust: (
    // rust: "mat4 projectionMatrix = mat4(2.0), modelViewMatrix = mat4(3.0);",
    // rust: "",
    // rust: "projectionMatrix",
    // rust: "modelViewMatrix",
    // rust: [128, 191, 255, 255],
    // rust: ),
    // rust: ] {
    // rust: let vertex = format!(
    // rust: "#version 330 compatibility\n{declaration}\nout vec3 result;\n\
    // rust: void main() {{\n{setup}\n\
    // rust: vec4 q = {projection} * {view} * vec4(0.5, 0.75, -2.0, 1.0);\n\
    // rust: result = vec3(q.xy / q.w, q.w / 4.0);\n\
    // rust: vec2 p = vec2((gl_VertexID << 1) & 2, gl_VertexID & 2);\n\
    // rust: gl_Position = vec4(p * 2.0 - 1.0, 0.0, 1.0);\n}}"
    // rust: );
    // rust: let mapped = draw_line_program(&device, &queue, &values, &vertex);
            // Independent result: translated point (1, .5, -2), perspective (aspect 2,
            // vertical FOV 90): clip (.5, .5, z, 2), hence (.25, .25, .5, 1).
    // rust: for (actual, expected) in mapped[..4].iter().zip(expected) {
    // rust: assert!(
    // rust: actual.abs_diff(expected) <= 1,
    // rust: "{projection}: {:?}",
    // rust: &mapped[..4]
    // rust: );
}
}
}

    // `normalMatrix` in a core-profile gbuffers program is the view's rotation; in the
    // compatibility profile it stays zero (the issue's Iris 1.11.7 probes, #9136).
core_normal_matrix_renders_the_view_rotation :: proc() {
}
    // rust: let instance = wgpu::Instance::new(wgpu::InstanceDescriptor::new_without_display_handle());
    // rust: let adapter = pollster::block_on(instance.request_adapter(&Default::default())).unwrap();
    // rust: eprintln!("Normal matrix GPU: {:?}", adapter.get_info());
    // rust: let (device, queue) =
    // rust: pollster::block_on(adapter.request_device(&Default::default())).unwrap();
    // rust: let hud = HudBatch::new([800, 400]);
    // rust: let mut f = frame(&hud);
        // Facing west (-X), level: view space looks down -Z with +X to the right (north).
    // rust: f.yaw = 90.0;
    // rust: f.pitch = 0.0;
    // rust: let mut values = FrameUniforms::default();
    // rust: values.update(&f, &PackInputs::default(), [800, 400]);
    // rust: for (profile, world, expected) in [
            // East (behind the camera) is view +Z.
    // rust: ("330 core", "vec3(1.0, 0.0, 0.0)", [128u8, 128, 255, 255]),
            // South (to the left) is view -X; up stays up.
    // rust: ("330 core", "vec3(0.0, 0.0, 1.0)", [0, 128, 128, 255]),
    // rust: ("330 core", "vec3(0.0, 1.0, 0.0)", [128, 255, 128, 255]),
    // rust: (
    // rust: "330 compatibility",
    // rust: "vec3(1.0, 0.0, 0.0)",
    // rust: [128, 128, 128, 255],
    // rust: ),
    // rust: ] {
    // rust: let vertex = format!(
    // rust: "#version {profile}\nuniform mat3 normalMatrix;\nout vec3 result;\n\
    // rust: void main() {{\n\
    // rust: result = normalMatrix * {world} * 0.5 + 0.5;\n\
    // rust: vec2 p = vec2((gl_VertexID << 1) & 2, gl_VertexID & 2);\n\
    // rust: gl_Position = vec4(p * 2.0 - 1.0, 0.0, 1.0);\n}}"
    // rust: );
    // rust: let pixel = draw_line_program(&device, &queue, &values, &vertex);
    // rust: eprintln!("{profile} {world}: {pixel:?}");
    // rust: for (actual, expected) in pixel.iter().zip(expected) {
    // rust: assert!(
    // rust: actual.abs_diff(expected) <= 1,
    // rust: "{profile} {world}: {pixel:?}"
    // rust: );
}
}
}

    // Draws one fragment through a translated `gbuffers_line` program with `vertex` and the
    // provider's `values`, and reads it back.
    // rust: fn draw_line_program(
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: values: &FrameUniforms,
    // rust: vertex: &str,
    // rust: ) -> [u8; 4] {
//         use horizon_shaders::{
    // rust: GbuffersInputs, Macros, Pack, Target, preprocess, translate_gbuffers,
}
//         use std::io::Write;
//         use wgpu::util::DeviceExt;
    // rust: let mut zip = zip::ZipWriter::new(std::io::Cursor::new(Vec::new()));
    // rust: for (path, source) in [
    // rust: ("shaders/gbuffers_line.vsh", vertex),
    // rust: (
    // rust: "shaders/gbuffers_line.fsh",
    // rust: "#version 330\nin vec3 result; out vec4 color; void main() { color = vec4(result, 1.0); }",
    // rust: ),
    // rust: ] {
    // rust: zip.start_file(path, zip::write::SimpleFileOptions::default())
    // rust: .unwrap();
    // rust: zip.write_all(source.as_bytes()).unwrap();
}
    // rust: let pack =
    // rust: Pack::from_zip_bytes("matrix-probe.zip", zip.finish().unwrap().into_inner()).unwrap();
    // rust: let macros = Macros::standard();
    // rust: let program = translate_gbuffers(
    // rust: &preprocess(&pack, "gbuffers_line.vsh", &macros),
    // rust: &preprocess(&pack, "gbuffers_line.fsh", &macros),
    // rust: Target::Buffers,
    // rust: &GbuffersInputs::default(),
    // rust: )
    // rust: .unwrap();
    // rust: let mut bytes = vec![0; program.interface.uniform_size as usize];
    // rust: for uniform in &program.interface.uniforms {
    // rust: if let Some(i) = index(&uniform.name) {
    // rust: values.values[i].write(&uniform.ty, &mut bytes, uniform.offset as usize);
}
}
    // rust: let uniform = device.create_buffer_init(&wgpu::util::BufferInitDescriptor {
    // rust: label: None,
    // rust: contents: &bytes,
    // rust: usage: wgpu::BufferUsages::UNIFORM,
    // rust: });
    // rust: let module = |module| {
    // rust: device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: None,
    // rust: source: wgpu::ShaderSource::Naga(std::borrow::Cow::Owned(module)),
    // rust: })
}
    // rust: let vs = module(program.vertex);
    // rust: let fs = module(program.fragment);
    // rust: let pipeline = device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: None,
    // rust: layout: None,
    // rust: vertex: wgpu::VertexState {
    // rust: module: &vs,
    // rust: entry_point: Some("main"),
    // rust: compilation_options: Default::default(),
    // rust: buffers: &[],
    // rust: },
    // rust: primitive: Default::default(),
    // rust: depth_stencil: None,
    // rust: multisample: Default::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: &fs,
    // rust: entry_point: Some("main"),
    // rust: compilation_options: Default::default(),
    // rust: targets: &[Some(wgpu::ColorTargetState {
    // rust: format: wgpu::TextureFormat::Rgba8Unorm,
    // rust: blend: None,
    // rust: write_mask: wgpu::ColorWrites::ALL,
    // rust: })],
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: });
    // rust: let group = device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: None,
    // rust: layout: &pipeline.get_bind_group_layout(0),
    // rust: entries: &[wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: uniform.as_entire_binding(),
    // rust: }],
    // rust: });
    // rust: let texture = device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: None,
    // rust: size: wgpu::Extent3d {
    // rust: width: 1,
    // rust: height: 1,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Rgba8Unorm,
    // rust: usage: wgpu::TextureUsages::RENDER_ATTACHMENT | wgpu::TextureUsages::COPY_SRC,
    // rust: view_formats: &[],
    // rust: });
    // rust: let view = texture.create_view(&Default::default());
    // rust: let read = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: None,
    // rust: size: 256,
    // rust: usage: wgpu::BufferUsages::COPY_DST | wgpu::BufferUsages::MAP_READ,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: {
    // rust: let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: None,
    // rust: color_attachments: &[Some(wgpu::RenderPassColorAttachment {
    // rust: view: &view,
    // rust: resolve_target: None,
    // rust: depth_slice: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(wgpu::Color::BLACK),
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })],
    // rust: ..Default::default()
    // rust: });
    // rust: pass.set_pipeline(&pipeline);
    // rust: pass.set_bind_group(0, &group, &[]);
    // rust: pass.draw(0..3, 0..1);
}
    // rust: encoder.copy_texture_to_buffer(
    // rust: texture.as_image_copy(),
    // rust: wgpu::TexelCopyBufferInfo {
    // rust: buffer: &read,
    // rust: layout: wgpu::TexelCopyBufferLayout {
    // rust: offset: 0,
    // rust: bytes_per_row: Some(256),
    // rust: rows_per_image: None,
    // rust: },
    // rust: },
    // rust: texture.size(),
    // rust: );
    // rust: queue.submit([encoder.finish()]);
    // rust: read.slice(..)
    // rust: .map_async(wgpu::MapMode::Read, |result| result.unwrap());
    // rust: device.poll(wgpu::PollType::wait_indefinitely()).unwrap();
    // rust: let mapped = read.slice(..).get_mapped_range().unwrap();
    // rust: let pixel = mapped[..4].try_into().unwrap();
    // rust: drop(mapped);
    // rust: read.unmap();
    // rust: pixel
}

int :: proc(u: ^FrameUniforms, at: uint) -> i {
    // Ported from Horizon
    return {}
}
    // rust: match u.values[at] {
    // rust: Value::I(v) => v[0],
    // rust: _ => panic!("integer uniform expected"),
}
}

    // Iris 1.11.7, read back exactly with a probe pack on a clear day (render distance 12,
    // cloud range 64): fogStart 0 and fogEnd 1024 (the environmental fog, not the render
    // distance's 172.8 to 192), fogDensity 0; composite and final programs read alphaTestRef
    // 0.1, blockEntityId -1, fogMode 0 and fogShape -1.
fog_and_draw_uniforms_outside_a_draw_follow_iris :: proc() {
}
    // rust: let hud = HudBatch::new([800, 450]);
    // rust: let mut f = frame(&hud);
    // rust: f.fog = Some(crate::fog::FogData {
    // rust: color: [0.7, 0.8, 1.0, 1.0],
    // rust: environmental_start: 0.0,
    // rust: environmental_end: 1024.0,
    // rust: render_distance_start: 172.8,
    // rust: render_distance_end: 192.0,
    // rust: sky_end: 192.0,
    // rust: cloud_end: 1024.0,
    // rust: });
    // rust: let mut u = FrameUniforms::default();
    // rust: u.update(&f, &PackInputs::default(), [800, 450]);
    // rust: assert_eq!(float(&u, "fogStart")[0], 0.0);
    // rust: assert_eq!(float(&u, "fogEnd")[0], 1024.0);
    // rust: assert_eq!(float(&u, "fogDensity")[0], 0.0);
    // rust: assert_eq!(float(&u, "alphaTestRef")[0], 0.1);
    // rust: assert_eq!(int(&u, index("blockEntityId").unwrap()), -1);
    // rust: assert_eq!(int(&u, index("entityId").unwrap()), 0);
    // rust: assert_eq!(int(&u, index("fogMode").unwrap()), 0);
    // rust: assert_eq!(int(&u, index("fogShape").unwrap()), -1);
}

    // Iris 1.11.7, read back with a probe pack in gbuffers_terrain and in deferred, in a cave
    // (fog 0 to 1024) and in the Nether (fog 10 to 96): `gl_Fog` holds the fog's colour, start
    // and end, a scale of 1 / (end - start), and a density of 0, not 1.
the_compatibility_gl_fog_has_no_density :: proc() {
}
    // rust: let hud = HudBatch::new([800, 450]);
    // rust: let mut f = frame(&hud);
    // rust: f.fog = Some(crate::fog::FogData {
    // rust: color: [0.09, 0.24, 0.23, 1.0],
    // rust: environmental_start: 10.0,
    // rust: environmental_end: 96.0,
    // rust: render_distance_start: 172.8,
    // rust: render_distance_end: 192.0,
    // rust: sky_end: 192.0,
    // rust: cloud_end: 1024.0,
    // rust: });
    // rust: let mut u = FrameUniforms::default();
    // rust: u.update(&f, &PackInputs::default(), [800, 450]);
    // rust: let [color, fog] = u.fog();
    // rust: assert_eq!(color.truncate(), Vec3::new(0.09, 0.24, 0.23));
    // rust: assert_eq!(fog, Vec4::new(0.0, 10.0, 96.0, 1.0 / 86.0));
}

    // Iris 1.11.7 (probe pack): gbuffers programs read fogMode GL_LINEAR (9729) and fogShape 1
    // (cylinder) where composite and final programs read 0 and -1.
programs_that_draw_geometry_read_their_own_fog_and_centre_depth :: proc() {
}
    // rust: let hud = HudBatch::new([800, 450]);
    // rust: let mut u = FrameUniforms::default();
    // rust: u.update(&frame(&hud), &PackInputs::default(), [800, 450]);
    // rust: let at = |name, geometry| index_in(name, geometry).unwrap();
    // rust: assert_eq!(int(&u, at("fogMode", true)), 9729);
    // rust: assert_eq!(int(&u, at("fogShape", true)), 1);
    // rust: assert_eq!(int(&u, at("fogMode", false)), 0);
    // rust: assert_eq!(int(&u, at("fogShape", false)), -1);
    // rust: assert_eq!(at("fogStart", true), at("fogStart", false));
        // Iris 1.11.7 (probe pack): `centerDepthSmooth` reads 0 in gbuffers programs.
    // rust: let depth = |geometry| match u.values[at("centerDepthSmooth", geometry)] {
    // rust: Value::F(v) => v[0],
    // rust: _ => panic!("float uniform expected"),
}
    // rust: assert_eq!(depth(true), 0.0);
    // rust: assert_eq!(depth(false), 1.0);
}

    // Iris 1.11.7, read frame by frame with a probe pack: eyeBrightnessSmooth falls by half
    // in 1 s and is rounded down; wetness takes 60 s to rise halfway and 20 s to fall; the
    // centre depth 0.1 s.
smoothed_uniforms_take_iris_half_lives :: proc() {
}
    // rust: let hud = HudBatch::new([800, 450]);
    // rust: let f = frame(&hud);
    // rust: let mut u = FrameUniforms::default();
        // The next frame comes `seconds` after the last (and a few microseconds of the test).
    // rust: let after = |u: &mut FrameUniforms, seconds: f32| {
    // rust: u.last = Some(std::time::Instant::now() - std::time::Duration::from_secs_f32(seconds));
}
    // rust: let mut input = PackInputs {
    // rust: eye_light: [0, 15],
    // rust: ..Default::default()
}
    // rust: u.center_depth_raw = Some(1.0);
    // rust: u.update(&f, &input, [800, 450]);
    // rust: input.eye_light = [0, 0];
    // rust: u.center_depth_raw = Some(0.0);
    // rust: after(&mut u, 0.1);
    // rust: u.update(&f, &input, [800, 450]);
    // rust: assert!((float(&u, "centerDepthSmooth")[0] - 0.5).abs() < 1e-3);
    // rust: after(&mut u, 0.6);
    // rust: u.update(&f, &input, [800, 450]);
        // 240 falling toward 0 for 0.7 s: 147.8, read as 147.
    // rust: match u.values[index("eyeBrightnessSmooth").unwrap()] {
    // rust: Value::I(v) => assert_eq!(v[1], 147),
    // rust: _ => panic!("integer uniform expected"),
}
    // rust: input.rain = 1.0;
    // rust: after(&mut u, 60.0);
    // rust: u.update(&f, &input, [800, 450]);
    // rust: assert!((float(&u, "wetness")[0] - 0.5).abs() < 1e-3);
    // rust: input.rain = 0.0;
    // rust: after(&mut u, 20.0);
    // rust: u.update(&f, &input, [800, 450]);
    // rust: assert!((float(&u, "wetness")[0] - 0.25).abs() < 1e-3);
}

    // Under `HORIZON_STILL` the pack's clock is the world's ticks, whenever and however often
    // the frame is drawn, and smoothed values are at their targets.
a_still_frame_takes_the_world_ticks_as_its_clock :: proc() {
}
    // rust: let hud = HudBatch::new([800, 450]);
    // rust: let f = frame(&hud);
    // rust: let mut u = FrameUniforms::default();
    // rust: let mut input = PackInputs {
    // rust: eye_light: [0, 15],
    // rust: still_ticks: Some(47_811),
    // rust: ..Default::default()
}
    // rust: u.center_depth_raw = Some(1.0);
    // rust: u.update(&f, &input, [800, 450]);
    // rust: input.eye_light = [0, 0];
    // rust: input.rain = 1.0;
    // rust: u.center_depth_raw = Some(0.0);
    // rust: u.last = Some(std::time::Instant::now() - std::time::Duration::from_secs(3));
    // rust: u.update(&f, &input, [800, 450]);
    // rust: assert_eq!(
    // rust: float(&u, "frameTimeCounter")[0],
    // rust: (47_811.0f32 / 20.0) % 3600.0
    // rust: );
    // rust: assert_eq!(float(&u, "frameTime")[0], 0.05);
    // rust: match u.values[index("frameCounter").unwrap()] {
    // rust: Value::I(v) => assert_eq!(v[0], 47_811),
    // rust: _ => panic!("integer uniform expected"),
}
    // rust: match u.values[index("eyeBrightnessSmooth").unwrap()] {
    // rust: Value::I(v) => assert_eq!(v[1], 0),
    // rust: _ => panic!("integer uniform expected"),
}
    // rust: assert_eq!(float(&u, "wetness")[0], 1.0);
    // rust: assert_eq!(float(&u, "centerDepthSmooth")[0], 0.0);
}

    // Iris 1.11.7 (probe pack): `ambientLight` is the dimension type's (0.1 in the Nether,
    // 0.25 in the End), and `playerMood` and `constantMood` both the cave mood.
ambient_light_and_mood_come_from_the_inputs :: proc() {
}
    // rust: let hud = HudBatch::new([800, 450]);
    // rust: let mut u = FrameUniforms::default();
    // rust: let input = PackInputs {
    // rust: ambient_light: 0.25,
    // rust: mood: 0.0235,
    // rust: ..Default::default()
}
    // rust: u.update(&frame(&hud), &input, [800, 450]);
    // rust: assert_eq!(float(&u, "ambientLight")[0], 0.25);
    // rust: assert_eq!(float(&u, "playerMood")[0], 0.0235);
    // rust: assert_eq!(float(&u, "constantMood")[0], 0.0235);
}

frame :: proc(hud: ^HudBatch) -> F {
    // Ported from Horizon
    return {}
}
    // rust: Frame {
    // rust: eye: glam::DVec3::ZERO,
    // rust: eye_rotation: [0.0; 2],
    // rust: first_person: true,
    // rust: shadow_scene_revision: (0, 0),
    // rust: shadow_cache: false,
    // rust: water_plane: None,
    // rust: weather: &[],
    // rust: weather_time: crate::weather::Time::new(0, 0.0),
    // rust: camera: glam::DVec3::new(0.5, 100.0, 0.5),
    // rust: yaw: 0.0,
    // rust: pitch: 10.0,
    // rust: fov_degrees: 85.0,
    // rust: bob: glam::Mat4::IDENTITY,
    // rust: spin: glam::Mat4::IDENTITY,
    // rust: sky: crate::environment::Sky::default(),
    // rust: distance: 12.0,
    // rust: detail_distance: 12.0,
    // rust: depth_far: 1000.0,
    // rust: underwater: false,
    // rust: cave_culling: false,
    // rust: title: true,
    // rust: sky_blocked: false,
    // rust: skybox: false,
    // rust: end_sky: false,
    // rust: end_sky_sprite: None,
    // rust: environment_fog: None,
    // rust: water_fog: [0.0; 3],
    // rust: fog: None,
    // rust: dark_disc: false,
    // rust: outline: Vec::new(),
    // rust: outline_after_terrain: false,
    // rust: outline_high_contrast: false,
    // rust: pvp: Default::default(),
    // rust: debug_lines: &[],
    // rust: debug_lines_on_top: &[],
    // rust: debug_crosshair: &[],
    // rust: hud,
    // rust: glint_alpha: 0.75,
    // rust: glint_ticks: 0.0,
    // rust: nether_lighting: false,
    // rust: entities: &[],
    // rust: static_block_entities: &[],
    // rust: visible_static_block_entity_sections: &[],
    // rust: static_block_entity_stats: crate::block_entity_render::StaticCacheFrameStats::default(),
    // rust: entity_motion: &[],
    // rust: colored_lights: &[],
    // rust: emissive_layers: &[],
    // rust: shadow_only: &[],
    // rust: entity_spans: &[],
    // rust: skin: None,
    // rust: glowing: &[],
    // rust: dynamic_lights: &[],
    // rust: clouds: None,
    // rust: lightning: Default::default(),
    // rust: additive: &[],
    // rust: see_through: &[],
    // rust: world_primitives: Default::default(),
    // rust: celestial: &[],
    // rust: stars: None,
    // rust: hand: &[],
    // rust: hand_items: &[],
    // rust: hand_fov_degrees: 70.0,
    // rust: screen: &[],
    // rust: pack: Default::default(),
    // rust: border: None,
    // rust: game_time: 0.0,
    // rust: shader_game_time: 0.0,
    // rust: end_portal_sprites: [[0.0; 4]; 2],
    // rust: crumbling_sprite: [0.0; 4],
    // rust: ticks: 0,
    // rust: darkness: (0.0, 0.0),
    // rust: night_vision: 0.0,
    // rust: block_flicker: 0.0,
    // rust: boss_darken: 0.0,
    // rust: menu_blur: None,
    // rust: chunk_fade: 0.0,
    // rust: post_effects: crate::post_chain::Request::none(),
}
}
}

    // rust: mod ftransform_test;
