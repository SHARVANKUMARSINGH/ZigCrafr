//! Transpiled from Horizon Rust crate
package horizon_client_render_camera

import "core:fmt"
import "core:mem"
import "core:math"

// `joml::Mat4::rotation`, `rotate_affine`, `transform_affine` and `invert_orthonormal`, and
// `joml::Quat::rotation_x`/`_y`/`_z`, in this file are adapted from JOML 1.10.9's `Matrix4f`,
// `Quaternionf` and `Vector4f` (https://github.com/JOML-CI/JOML, MIT; see THIRD_PARTY_NOTICES.md).
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

// The camera (`Camera.tick`, `tickFov`, `calculateFov`, `alignWithEntity`,
// `getMaxZoom`, `setRotation`, `move`), view and hurt bobbing
// (`GameRenderer.bobView`, `bobHurt`), the walk and bob history they read
// (`ClientAvatarState`), and `AbstractClientPlayer.getFieldOfViewModifier`.
//
// The float arithmetic follows vanilla and JOML's default (non-FMA,
// non-fast-math) code paths operation by operation.
// use horizon_core::geometry::trig;

// `(float) Math.PI`.
PI :: std::f32::consts::PI
// `(float) (Math.PI / 180.0)`.
DEG_TO_RAD :: trig::DEG_TO_RAD

// `Math.min(float, float)`: NaN wins and -0.0 is below 0.0.
java_min :: proc(a: f32, b: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if a.is_nan() || b.is_nan() {
    // rust: f32::NAN
    // rust: } else if a == 0.0 && b == 0.0 {
    // rust: f32::from_bits(a.to_bits() | b.to_bits())
    // rust: } else if a <= b {
    // rust: a
    // rust: } else {
    // rust: b
}
}
// `Math.max(float, float)`.
java_max :: proc(a: f32, b: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if a.is_nan() || b.is_nan() {
    // rust: f32::NAN
    // rust: } else if a == 0.0 && b == 0.0 {
    // rust: f32::from_bits(a.to_bits() & b.to_bits())
    // rust: } else if a >= b {
    // rust: a
    // rust: } else {
    // rust: b
}
}
// `Mth.lerp(float, float, float)`.
lerp :: proc(alpha: f32, p0: f32, p1: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: p0 + alpha * (p1 - p0)
}
// `Mth.lerp(double, double, double)`.
lerp_d :: proc(alpha: f64, p0: f64, p1: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: p0 + alpha * (p1 - p0)
}
// `Mth.wrapDegrees(float)`.
wrap_degrees :: proc(angle: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let mut normalized = angle % 360.0;
    // rust: if normalized >= 180.0 {
    // rust: normalized -= 360.0;
}
    // rust: if normalized < -180.0 {
    // rust: normalized += 360.0;
}
    // rust: normalized
}
// `Mth.clamp(float, float, float)`.
clamp :: proc(value: f32, min: f32, max: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if value < min {
    // rust: min
    // rust: } else {
    // rust: java_min(value, max)
}
}

// JOML's float trigonometry (`org.joml.Math` without fast math).
    // rust: pub mod joml {
//     use super::PI;
TAU :: std::f32::consts::TAU
HALF_PI :: std::f32::consts::FRAC_PI_2

    // `Math.sin(float)`: `java.lang.Math.sin` narrowed.
sin :: proc(rad: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: f64::from(rad).sin() as f32
}
    // `Math.cosFromSin(float, float)`.
cos_from_sin :: proc(sin: f32, angle: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let cos = (1.0 - sin * sin).sqrt();
    // rust: let a = angle + HALF_PI;
    // rust: let mut b = a - (a / TAU) as i32 as f32 * TAU;
    // rust: if f64::from(b) < 0.0 {
    // rust: b += TAU;
}
    // rust: if b >= PI { -cos } else { cos }
}

    // A JOML `Quaternionf` (x, y, z, w).
Quat :: struct {
    x: f32,
    y: f32,
    z: f32,
    w: f32,
}
    // rust: impl Quat {
    // rust: pub const IDENTITY: Self = Self {
    // rust: x: 0.0,
    // rust: y: 0.0,
    // rust: z: 0.0,
    // rust: w: 1.0,
}
        // `Quaternionf.rotationYXZ(angleY, angleX, angleZ)`.
rotation_yxz :: proc(angle_y: f32, angle_x: f32, angle_z: f32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let sx = sin(angle_x * 0.5);
    // rust: let cx = cos_from_sin(sx, angle_x * 0.5);
    // rust: let sy = sin(angle_y * 0.5);
    // rust: let cy = cos_from_sin(sy, angle_y * 0.5);
    // rust: let sz = sin(angle_z * 0.5);
    // rust: let cz = cos_from_sin(sz, angle_z * 0.5);
    // rust: let x = cy * sx;
    // rust: let y = sy * cx;
    // rust: let z = sy * sx;
    // rust: let w = cy * cx;
    // rust: Self {
    // rust: x: x * cz + y * sz,
    // rust: y: y * cz - x * sz,
    // rust: z: w * sz - z * cz,
    // rust: w: w * cz + z * sz,
}
}
        // `Quaternionf.rotationX(angle)`.
rotation_x :: proc(angle: f32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let (x, w) = Self::half_turn(angle);
    // rust: Self {
    // rust: x,
    // rust: y: 0.0,
    // rust: z: 0.0,
    // rust: w,
}
}
        // `Quaternionf.rotationY(angle)`.
rotation_y :: proc(angle: f32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let (y, w) = Self::half_turn(angle);
    // rust: Self {
    // rust: x: 0.0,
    // rust: y,
    // rust: z: 0.0,
    // rust: w,
}
}
        // `Quaternionf.rotationZ(angle)`.
rotation_z :: proc(angle: f32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let (z, w) = Self::half_turn(angle);
    // rust: Self {
    // rust: x: 0.0,
    // rust: y: 0.0,
    // rust: z,
    // rust: w,
}
}
half_turn :: proc(angle: f32) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let sin = sin(angle * 0.5);
    // rust: (sin, cos_from_sin(sin, angle * 0.5))
}
        // `Quaternionf.transform(x, y, z, dest)` (`Vector3f.rotate`).
transform :: proc(self: ^Self, v: [f32; 3]) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let [x, y, z] = v;
    // rust: let xx = self.x * self.x;
    // rust: let yy = self.y * self.y;
    // rust: let zz = self.z * self.z;
    // rust: let ww = self.w * self.w;
    // rust: let xy = self.x * self.y;
    // rust: let xz = self.x * self.z;
    // rust: let yz = self.y * self.z;
    // rust: let xw = self.x * self.w;
    // rust: let zw = self.z * self.w;
    // rust: let yw = self.y * self.w;
    // rust: let k = 1.0 / (xx + yy + zz + ww);
    // rust: [
    // rust: (xx - yy - zz + ww) * k * x + (2.0 * (xy - zw) * k * y + 2.0 * (xz + yw) * k * z),
    // rust: 2.0 * (xy + zw) * k * x + ((yy - xx - zz + ww) * k * y + 2.0 * (yz - xw) * k * z),
    // rust: 2.0 * (xz - yw) * k * x + (2.0 * (yz + xw) * k * y + (zz - xx - yy + ww) * k * z),
    // rust: ]
}
}

PERSPECTIVE :: 1
AFFINE :: 2
IDENTITY :: 4
TRANSLATION :: 8
ORTHONORMAL :: 16

    // A JOML `Matrix4f` with its property flags, which select the code
    // paths (and so the rounding) of later operations. `m[column * 4 + row]`.
Mat4 :: struct {
    m: [f32,
    properties: u8,
}
    // rust: impl Default for Mat4 {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::IDENTITY
}
}
    // rust: impl Mat4 {
        // `new Matrix4f()`.
    // rust: pub const IDENTITY: Self = Self {
    // rust: m: [
    // rust: 1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0,
    // rust: ],
    // rust: properties: 30,
}
get :: proc(self: ^Self, column: uint, row: uint) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.m[column * 4 + row]
}
set :: proc(self: ^Self, column: uint, row: uint, v: f32) {
}
    // rust: self.m[column * 4 + row] = v;
}
reset_unless_identity :: proc(self: ^Self) {
}
    // rust: if self.properties & IDENTITY == 0 {
    // rust: self.m = Self::IDENTITY.m;
}
}
        // `Matrix4f.translation(x, y, z)`.
translation :: proc(self: ^Self, x: f32, y: f32, z: f32) {
}
    // rust: self.reset_unless_identity();
    // rust: self.set(3, 0, x);
    // rust: self.set(3, 1, y);
    // rust: self.set(3, 2, z);
    // rust: self.properties = 26;
}
        // `Matrix4f.setTranslation(x, y, z)`.
set_translation :: proc(self: ^Self, x: f32, y: f32, z: f32) {
}
    // rust: self.set(3, 0, x);
    // rust: self.set(3, 1, y);
    // rust: self.set(3, 2, z);
    // rust: self.properties &= !(PERSPECTIVE | IDENTITY);
}
        // `Matrix4f.translate(x, y, z)`.
translate :: proc(self: ^Self, x: f32, y: f32, z: f32) {
}
    // rust: if self.properties & IDENTITY != 0 {
    // rust: self.translation(x, y, z);
    // rust: return;
}
    // rust: for row in 0..4 {
    // rust: let v = self.get(0, row) * x
    // rust: + (self.get(1, row) * y + (self.get(2, row) * z + self.get(3, row)));
    // rust: self.set(3, row, v);
}
    // rust: self.properties &= !(PERSPECTIVE | IDENTITY);
}
rotation_axis :: proc(self: ^Self, axis: uint, ang: f32) {
}
    // rust: let sin = sin(ang);
    // rust: let cos = cos_from_sin(sin, ang);
    // rust: self.reset_unless_identity();
    // rust: match axis {
    // rust: 0 => {
    // rust: self.set(1, 1, cos);
    // rust: self.set(1, 2, sin);
    // rust: self.set(2, 1, -sin);
    // rust: self.set(2, 2, cos);
}
    // rust: 1 => {
    // rust: self.set(0, 0, cos);
    // rust: self.set(0, 2, -sin);
    // rust: self.set(2, 0, sin);
    // rust: self.set(2, 2, cos);
}
    // rust: _ => {
    // rust: self.set(0, 0, cos);
    // rust: self.set(0, 1, sin);
    // rust: self.set(1, 0, -sin);
    // rust: self.set(1, 1, cos);
}
}
    // rust: self.properties = 18;
}
        // `Matrix4f.rotateX/rotateY/rotateZ(ang)`, with the identity and
        // pure-translation shortcuts.
rotate_axis :: proc(self: ^Self, axis: uint, ang: f32) {
}
    // rust: if self.properties & IDENTITY != 0 {
    // rust: self.rotation_axis(axis, ang);
    // rust: return;
}
    // rust: if self.properties & TRANSLATION != 0 {
    // rust: let (x, y, z) = (self.get(3, 0), self.get(3, 1), self.get(3, 2));
    // rust: self.rotation_axis(axis, ang);
    // rust: self.set_translation(x, y, z);
    // rust: return;
}
    // rust: let sin = sin(ang);
    // rust: let cos = cos_from_sin(sin, ang);
    // rust: let s = *self;
    // rust: match axis {
    // rust: 0 => {
    // rust: for row in 0..4 {
    // rust: let (l1, l2) = (s.get(1, row), s.get(2, row));
    // rust: self.set(2, row, l1 * -sin + l2 * cos);
    // rust: self.set(1, row, l1 * cos + l2 * sin);
}
}
    // rust: 1 => {
    // rust: for row in 0..4 {
    // rust: let (l0, l2) = (s.get(0, row), s.get(2, row));
    // rust: self.set(0, row, l0 * cos + l2 * -sin);
    // rust: self.set(2, row, l0 * sin + l2 * cos);
}
}
    // rust: _ => {
                    // rotateTowardsXY(sin, cos).
    // rust: let (dx, dy) = (sin, cos);
    // rust: for row in 0..4 {
    // rust: let (l0, l1) = (s.get(0, row), s.get(1, row));
    // rust: self.set(0, row, l0 * dy + l1 * dx);
    // rust: self.set(1, row, l0 * -dx + l1 * dy);
}
}
}
    // rust: self.properties &= !(PERSPECTIVE | IDENTITY | TRANSLATION);
}
rotate_x :: proc(self: ^Self, ang: f32) {
}
    // rust: self.rotate_axis(0, ang);
}
rotate_y :: proc(self: ^Self, ang: f32) {
}
    // rust: self.rotate_axis(1, ang);
}
rotate_z :: proc(self: ^Self, ang: f32) {
}
            // rotateTowardsXY also short-cuts on identity, but rotateZ has
            // already taken that branch.
    // rust: self.rotate_axis(2, ang);
}
        // `Matrix4f.rotation(Quaternionfc)`.
rotation :: proc(self: ^Self, q: Quat) {
}
    // rust: let (w2, x2, y2, z2) = (q.w * q.w, q.x * q.x, q.y * q.y, q.z * q.z);
    // rust: let zw = q.z * q.w;
    // rust: let dzw = zw + zw;
    // rust: let xy = q.x * q.y;
    // rust: let dxy = xy + xy;
    // rust: let xz = q.x * q.z;
    // rust: let dxz = xz + xz;
    // rust: let yw = q.y * q.w;
    // rust: let dyw = yw + yw;
    // rust: let yz = q.y * q.z;
    // rust: let dyz = yz + yz;
    // rust: let xw = q.x * q.w;
    // rust: let dxw = xw + xw;
    // rust: self.reset_unless_identity();
    // rust: self.set(0, 0, w2 + x2 - z2 - y2);
    // rust: self.set(0, 1, dxy + dzw);
    // rust: self.set(0, 2, dxz - dyw);
    // rust: self.set(1, 0, -dzw + dxy);
    // rust: self.set(1, 1, y2 - z2 + w2 - x2);
    // rust: self.set(1, 2, dyz + dxw);
    // rust: self.set(2, 0, dyw + dxz);
    // rust: self.set(2, 1, dyz - dxw);
    // rust: self.set(2, 2, z2 - y2 - x2 + w2);
    // rust: self.properties = AFFINE | ORTHONORMAL;
}
        // An affine matrix of no more specific kind, as JOML's property flags have it.
affine :: proc(m: glam::Mat4) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: m: m.to_cols_array(),
    // rust: properties: AFFINE,
}
}
        // `Matrix4f.rotate(Quaternionfc)` of an affine matrix that is neither the identity nor
        // a pure translation (`rotateAffine`).
rotate_affine :: proc(self: ^Self, q: Quat) {
}
    // rust: debug_assert!(
    // rust: self.properties & AFFINE != 0 && self.properties & (IDENTITY | TRANSLATION) == 0
    // rust: );
    // rust: let (w2, x2, y2, z2) = (q.w * q.w, q.x * q.x, q.y * q.y, q.z * q.z);
    // rust: let zw = q.z * q.w;
    // rust: let dzw = zw + zw;
    // rust: let xy = q.x * q.y;
    // rust: let dxy = xy + xy;
    // rust: let xz = q.x * q.z;
    // rust: let dxz = xz + xz;
    // rust: let yw = q.y * q.w;
    // rust: let dyw = yw + yw;
    // rust: let yz = q.y * q.z;
    // rust: let dyz = yz + yz;
    // rust: let xw = q.x * q.w;
    // rust: let dxw = xw + xw;
    // rust: let r = [
    // rust: [w2 + x2 - z2 - y2, dxy + dzw, dxz - dyw],
    // rust: [-dzw + dxy, y2 - z2 + w2 - x2, dyz + dxw],
    // rust: [dyw + dxz, dyz - dxw, z2 - y2 - x2 + w2],
    // rust: ];
    // rust: let s = *self;
    // rust: for (column, r) in r.iter().enumerate() {
    // rust: for row in 0..3 {
    // rust: let v = s.get(0, row) * r[0] + s.get(1, row) * r[1] + s.get(2, row) * r[2];
    // rust: self.set(column, row, v);
}
    // rust: self.set(column, 3, 0.0);
}
    // rust: self.properties &= !(PERSPECTIVE | IDENTITY | TRANSLATION);
}
        // `Vector4f.mul(Matrix4fc)` of an affine matrix (`mulAffine`, JOML's `Math.fma`
        // unfused): the matrix times `v`, `w` kept.
transform_affine :: proc(self: ^Self, v: [f32; 4]) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: debug_assert!(self.properties & AFFINE != 0);
    // rust: let [x, y, z, w] = v;
    // rust: std::array::from_fn(|row| {
    // rust: self.get(0, row) * x
    // rust: + (self.get(1, row) * y + (self.get(2, row) * z + self.get(3, row) * w))
    // rust: })
}
        // `Matrix4f.invert()` of a rotation and translation (`invertOrthonormal`; with the
        // identity and pure-translation shortcuts). `None` for any other matrix, which JOML
        // inverts by other code paths.
invert_orthonormal :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if self.properties & IDENTITY != 0 {
    // rust: return Some(Self::IDENTITY);
}
    // rust: let mut out = *self;
    // rust: if self.properties & TRANSLATION != 0 {
    // rust: for row in 0..3 {
    // rust: out.set(3, row, -self.get(3, row));
}
    // rust: out.properties = AFFINE | TRANSLATION | ORTHONORMAL;
    // rust: return Some(out);
}
    // rust: if self.properties & ORTHONORMAL == 0 {
    // rust: return None;
}
    // rust: let g = |c, r| self.get(c, r);
    // rust: let t = |c| -(g(c, 0) * g(3, 0) + g(c, 1) * g(3, 1) + g(c, 2) * g(3, 2));
    // rust: out.m = [
    // rust: g(0, 0),
    // rust: g(1, 0),
    // rust: g(2, 0),
    // rust: 0.0,
    // rust: g(0, 1),
    // rust: g(1, 1),
    // rust: g(2, 1),
    // rust: 0.0,
    // rust: g(0, 2),
    // rust: g(1, 2),
    // rust: g(2, 2),
    // rust: 0.0,
    // rust: t(0),
    // rust: t(1),
    // rust: t(2),
    // rust: 1.0,
    // rust: ];
    // rust: out.properties = AFFINE | ORTHONORMAL;
    // rust: Some(out)
}
to_glam :: proc(self: ^Self) -> g {
    // Ported from Horizon
    return {}
}
    // rust: glam::Mat4::from_cols_array(&self.m)
}
}
}
// use joml::{Mat4, Quat};

// `Camera.getViewRotationMatrix` to the last bit: `Matrix4f.rotation` of the conjugate of
// `setRotation`'s quaternion, and its JOML `invert()`. `view_matrix` turns the same quaternion
// into a matrix by glam's formula, which differs in the last bits (1.0 for 0.99999994, 6e-8 for
// 0).
view_rotation_matrix :: proc(yaw: f32, pitch: f32) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let q = Quat::rotation_yxz(PI - yaw * DEG_TO_RAD, -pitch * DEG_TO_RAD, 0.0);
    // rust: let mut m = Mat4::IDENTITY;
    // rust: m.rotation(Quat {
    // rust: x: -q.x,
    // rust: y: -q.y,
    // rust: z: -q.z,
    // rust: w: q.w,
    // rust: });
    // rust: let inverse = m.invert_orthonormal().expect("a rotation is orthonormal");
    // rust: (m.to_glam(), inverse.to_glam())
}

// Camera-relative world view used by terrain, sky and the first-person hand.
view_matrix :: proc(yaw: f32, pitch: f32) -> g {
    // Ported from Horizon
    return {}
}
    // Vanilla uses the conjugate of Camera.rotation, not a world-up look-at.
    // rust: let q = Quat::rotation_yxz(PI - yaw * DEG_TO_RAD, -pitch * DEG_TO_RAD, 0.0);
    // rust: glam::Mat4::from_quat(glam::Quat::from_xyzw(-q.x, -q.y, -q.z, q.w))
}

// `CameraType`.
CameraType :: enum {
    FirstPerson,
    ThirdPersonBack,
    ThirdPersonFront,
}
    // rust: impl CameraType {
is_first_person :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self == Self::FirstPerson
}
is_mirrored :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self == Self::ThirdPersonFront
}
    // `CameraType.cycle` (F5).
cycle :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::FirstPerson => Self::ThirdPersonBack,
    // rust: Self::ThirdPersonBack => Self::ThirdPersonFront,
    // rust: Self::ThirdPersonFront => Self::FirstPerson,
}
}
}

// What `AbstractClientPlayer.getFieldOfViewModifier` reads.
FovPlayer :: struct {
    // `Abilities.flying`.
    flying: bool,
    // `Abilities.getWalkingSpeed()`.
    walking_speed: f32,
    // `getAttributeValue(MOVEMENT_SPEED)`.
    movement_speed: f64,
    // The item in use and its use ticks, when using one.
    using: Option<(UseItem,
}
UseItem :: enum {
    Bow,
    Spyglass,
    Other,
}
// `AbstractClientPlayer.getFieldOfViewModifier(firstPerson, effectScale)`.
field_of_view_modifier :: proc(p: ^FovPlayer, first_person: bool, effect_scale: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let mut modifier = 1.0f32;
    // rust: if p.flying {
    // rust: modifier *= 1.1;
}
    // rust: let walking_speed = p.walking_speed;
    // rust: if walking_speed != 0.0 {
    // rust: let speed_factor = p.movement_speed as f32 / walking_speed;
    // rust: modifier *= (speed_factor + 1.0) / 2.0;
}
    // rust: if let Some((item, ticks)) = p.using {
    // rust: match item {
    // rust: UseItem::Bow => {
    // rust: let scale = java_min(ticks as f32 / 20.0, 1.0);
    // rust: modifier *= 1.0 - scale * scale * 0.15;
}
            // isScoping: using a spyglass.
    // rust: UseItem::Spyglass if first_person => return 0.1,
    // rust: _ => {}
}
}
    // rust: lerp(effect_scale, 1.0, modifier)
}

// The camera entity as `Camera.alignWithEntity` and the field-of-view
// death and hurt effects see it.
CameraEntity :: struct {
    position: [f64,
    // `xo`, `yo`, `zo`.
    previous: [f64,
    x_rot: f32,
    y_rot: f32,
    x_rot_o: f32,
    y_rot_o: f32,
    // `Entity.getEyeHeight()`.
    eye_height: f32,
    // A living entity's `getScale()` and camera distance attribute.
    living: Maybe(LivingCamera),
    // The vehicle's scale and camera distance when it is living.
    mount: Option<(f32,
}
LivingCamera :: struct {
    scale: f32,
    camera_distance: f64,
    // `isSleeping()` with `getBedOrientation()` as its `toYRot()`.
    sleeping: Maybe(Option<f32)>,
    // `isDeadOrDying()` and `deathTime`.
    dead: Maybe(i32),
}
    // rust: impl CameraEntity {
    // `Entity.getXRot(partialTicks)`.
view_x_rot :: proc(self: ^Self, partial: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if partial == 1.0 {
    // rust: self.x_rot
    // rust: } else {
    // rust: lerp(partial, self.x_rot_o, self.x_rot)
}
}
    // `LocalPlayer.getViewYRot` (`getYRot(partialTicks)`, a `Mth.rotLerp`).
view_y_rot :: proc(self: ^Self, partial: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if partial == 1.0 {
    // rust: self.y_rot
    // rust: } else {
    // rust: self.y_rot_o + partial * wrap_degrees(self.y_rot - self.y_rot_o)
}
}
}

// The fluid `Camera.getFluidInCamera` reports, as the field of view sees it.
CameraFluid :: enum {
    None,
    Water,
    Lava,
    PowderSnow,
}

// `Camera.NearPlane`: the near plane's centre and its half extents toward
// the camera's left and up, relative to the camera.
NearPlane :: struct {
    forward: [f64,
    left: [f64,
    up: [f64,
}
    // rust: impl NearPlane {
    // `forward`, `getTopLeft`, `getTopRight`, `getBottomLeft`, `getBottomRight`:
    // the points `Camera.getFluidInCamera` looks for lava and powder snow at.
points :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let corner = |up: f64, left: f64| -> [f64; 3] {
    // rust: std::array::from_fn(|i| self.forward[i] + self.up[i] * up + self.left[i] * left)
}
    // rust: [
    // rust: self.forward,
    // rust: corner(1.0, 1.0),
    // rust: corner(1.0, -1.0),
    // rust: corner(-1.0, 1.0),
    // rust: corner(-1.0, -1.0),
    // rust: ]
}
}

// `Camera`: the eye-height and field-of-view easing and the view placement.
Camera :: struct {
    eye_height: f32,
    eye_height_old: f32,
    fov_modifier: f32,
    old_fov_modifier: f32,
    position: [f64,
    x_rot: f32,
    y_rot: f32,
    rotation: Quat,
    forwards: [f32,
    up: [f32,
    left: [f32,
    detached: bool,
    // The entity's eye and view rotation (yaw, pitch), where a detached camera backs off
    // from.
    eye: [f64,
    eye_rotation: [f32,
}
    // rust: impl Default for Camera {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: eye_height: 0.0,
    // rust: eye_height_old: 0.0,
    // rust: fov_modifier: 0.0,
    // rust: old_fov_modifier: 0.0,
    // rust: position: [0.0; 3],
    // rust: x_rot: 0.0,
    // rust: y_rot: 0.0,
    // rust: rotation: Quat::IDENTITY,
    // rust: forwards: [0.0, 0.0, -1.0],
    // rust: up: [0.0, 1.0, 0.0],
    // rust: left: [-1.0, 0.0, 0.0],
    // rust: detached: false,
    // rust: eye: [0.0; 3],
    // rust: eye_rotation: [0.0; 2],
}
}
}
    // rust: impl Camera {
    // `Camera.tick`: the eye height eases halfway toward the entity's
    // (with a level and an entity), then `tickFov` with the camera entity's
    // field-of-view modifier target (1 when it is not a player).
tick :: proc(self: ^Self, entity_eye_height: Maybe(f32), target_fov_modifier: f32) {
}
    // rust: if let Some(eye) = entity_eye_height {
    // rust: self.eye_height_old = self.eye_height;
    // rust: self.eye_height += (eye - self.eye_height) * 0.5;
}
    // rust: self.old_fov_modifier = self.fov_modifier;
    // rust: self.fov_modifier += (target_fov_modifier - self.fov_modifier) * 0.5;
    // rust: self.fov_modifier = clamp(self.fov_modifier, 0.1, 1.5);
}
    // `Camera.setRotation`.
set_rotation :: proc(self: ^Self, y_rot: f32, x_rot: f32) {
}
    // rust: self.x_rot = x_rot;
    // rust: self.y_rot = y_rot;
    // rust: self.rotation = Quat::rotation_yxz(PI - y_rot * DEG_TO_RAD, -x_rot * DEG_TO_RAD, 0.0);
    // rust: self.forwards = self.rotation.transform([0.0, 0.0, -1.0]);
    // rust: self.up = self.rotation.transform([0.0, 1.0, 0.0]);
    // rust: self.left = self.rotation.transform([-1.0, 0.0, 0.0]);
}
    // `Camera.getNearPlane(fov)` for a `width` x `height` window, at the
    // projection's `zNear` of 0.05.
near_plane :: proc(self: ^Self, fov: f32, width: f32, height: f32) -> N {
    // Ported from Horizon
    return {}
}
    // rust: let z_near = f64::from(0.05f32);
    // rust: let aspect = f64::from(width) / f64::from(height);
    // rust: let plane_height = horizon_core::jmath::tan(f64::from(fov * DEG_TO_RAD) / 2.0) * z_near;
    // rust: let scale = |v: [f32; 3], by: f64| v.map(|c| f64::from(c) * by);
    // rust: NearPlane {
    // rust: forward: scale(self.forwards, z_near),
    // rust: left: scale(self.left, plane_height * aspect),
    // rust: up: scale(self.up, plane_height),
}
}
    // `Camera.move(forwards, up, right)`.
move_by :: proc(self: ^Self, forwards: f32, up: f32, right: f32) {
}
    // rust: let offset = self.rotation.transform([right, up, -forwards]);
    // rust: self.position = [
    // rust: self.position[0] + f64::from(offset[0]),
    // rust: self.position[1] + f64::from(offset[1]),
    // rust: self.position[2] + f64::from(offset[2]),
    // rust: ];
}
    // `Camera.alignWithEntity` (not riding a minecart with the new
    // movement): the entity's view rotation and interpolated eye, then a
    // detached camera backed off along the view (`getMaxZoom`) or a sleeping
    // one turned to the bed. `clip` is `Level.clip` with
    // `ClipContext.Block.VISUAL` and no fluids; it returns the hit location
    // unless the ray misses.
    // rust: pub fn align_with_entity(
    // rust: &mut self,
    // rust: entity: &CameraEntity,
    // rust: partial: f32,
    // rust: camera_type: CameraType,
    // rust: clip: impl FnMut([f64; 3], [f64; 3]) -> Option<[f64; 3]>,
    // rust: ) {
    // rust: self.align_with_entity_distance(entity, partial, camera_type, |distance| distance, clip);
}
    // Adjust the detached distance after entity/mount scaling, before collision clipping.
    // Only finite overrides in 0..=1024 blocks are accepted (within the game's ray budget).
    // First-person views do not call `adjust_distance`.
    // rust: pub fn align_with_entity_distance(
    // rust: &mut self,
    // rust: entity: &CameraEntity,
    // rust: partial: f32,
    // rust: camera_type: CameraType,
    // rust: adjust_distance: impl FnOnce(f32) -> f32,
    // rust: mut clip: impl FnMut([f64; 3], [f64; 3]) -> Option<[f64; 3]>,
    // rust: ) {
    // rust: self.set_rotation(entity.view_y_rot(partial), entity.view_x_rot(partial));
    // rust: let p = f64::from(partial);
    // rust: self.position = [
    // rust: lerp_d(p, entity.previous[0], entity.position[0]),
    // rust: lerp_d(p, entity.previous[1], entity.position[1])
    // rust: + f64::from(lerp(partial, self.eye_height_old, self.eye_height)),
    // rust: lerp_d(p, entity.previous[2], entity.position[2]),
    // rust: ];
    // rust: self.eye = self.position;
    // rust: self.eye_rotation = [self.y_rot, self.x_rot];
    // rust: self.detached = !camera_type.is_first_person();
    // rust: if self.detached {
    // rust: if camera_type.is_mirrored() {
    // rust: self.set_rotation(self.y_rot + 180.0, -self.x_rot);
}
    // rust: let (mut distance, mut scale) = (4.0f32, 1.0f32);
    // rust: if let Some(living) = &entity.living {
    // rust: scale = living.scale;
    // rust: distance = living.camera_distance as f32;
}
    // rust: let (mut mount_scale, mut mount_distance) = (scale, distance);
    // rust: if let Some((s, d)) = entity.mount {
    // rust: mount_scale = s;
    // rust: mount_distance = d as f32;
}
    // rust: let vanilla = java_max(scale * distance, mount_scale * mount_distance);
    // rust: let adjusted = adjust_distance(vanilla);
    // rust: let distance = if adjusted.is_finite() && (0.0..=1024.0).contains(&adjusted) {
    // rust: adjusted
    // rust: } else {
    // rust: vanilla
}
    // rust: let zoom = self.max_zoom(distance, &mut clip);
    // rust: self.move_by(-zoom, 0.0, 0.0);
    // rust: } else if let Some(LivingCamera {
    // rust: sleeping: Some(bed),
    // rust: ..
    // rust: }) = entity.living
    // rust: {
    // rust: self.set_rotation(bed.map_or(0.0, |yaw| yaw - 180.0), 0.0);
    // rust: self.move_by(0.0, 0.15, 0.0);
}
}
    // `Camera.getMaxZoom`: eight rays from the corners of a 0.2 cube about
    // the eye, shortening the distance to the nearest visual-shape hit.
    // rust: pub fn max_zoom(
    // rust: &self,
    // rust: mut distance: f32,
    // rust: clip: &mut impl FnMut([f64; 3], [f64; 3]) -> Option<[f64; 3]>,
    // rust: ) -> f32 {
    // rust: let at = self.position;
    // rust: for i in 0..8 {
    // rust: let offset = [
    // rust: ((i & 1) * 2 - 1) as f32,
    // rust: ((i >> 1 & 1) * 2 - 1) as f32,
    // rust: ((i >> 2 & 1) * 2 - 1) as f32,
    // rust: ];
    // rust: let from: [f64; 3] = std::array::from_fn(|a| at[a] + f64::from(offset[a] * 0.1));
    // rust: let back = f64::from(-distance);
    // rust: let to: [f64; 3] =
    // rust: std::array::from_fn(|a| from[a] + f64::from(self.forwards[a]) * back);
    // rust: if let Some(hit) = clip(from, to) {
    // rust: let d = [hit[0] - at[0], hit[1] - at[1], hit[2] - at[2]];
    // rust: let dist_sq = (d[0] * d[0] + d[1] * d[1] + d[2] * d[2]) as f32;
    // rust: if dist_sq < distance * distance {
    // rust: distance = dist_sq.sqrt();
}
}
}
    // rust: distance
}
    // `Camera.calculateFov`: the option scaled by the eased modifier, then
    // the death and fluid effects.
    // rust: pub fn calculate_fov(
    // rust: &self,
    // rust: partial: f32,
    // rust: fov_option: i32,
    // rust: effect_scale: f32,
    // rust: dead: Option<i32>,
    // rust: fluid: CameraFluid,
    // rust: panoramic: bool,
    // rust: ) -> f32 {
    // rust: if panoramic {
    // rust: return 90.0;
}
    // rust: let fov = fov_option as f32 * lerp(partial, self.old_fov_modifier, self.fov_modifier);
    // rust: modify_fov_based_on_death_or_fluid(partial, fov, effect_scale, dead, fluid)
}
    // `Camera.calculateHudFov`.
    // rust: pub fn calculate_hud_fov(
    // rust: &self,
    // rust: partial: f32,
    // rust: effect_scale: f32,
    // rust: dead: Option<i32>,
    // rust: fluid: CameraFluid,
    // rust: ) -> f32 {
    // rust: modify_fov_based_on_death_or_fluid(partial, 70.0, effect_scale, dead, fluid)
}
}
// `Camera.update`: the far plane covers four times the render distance and
// the whole cloud range (`depthFar`).
depth_far :: proc(render_distance_chunks: i32, cloud_range_chunks: i32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: (render_distance_chunks as f32 * 16.0 * 4.0).max((cloud_range_chunks * 16) as f32)
}

// `Projection.getMatrix` for a perspective set up by `setupPerspective`:
// JOML's `Matrix4f.setPerspective(fov * DEG_TO_RAD, width / height, near,
// far, zZeroToOne)`, column-major. Vanilla's `Projection` passes its planes
// reversed (`near` is `zFar`) for reversed depth.
    // rust: pub fn perspective(
    // rust: fov_degrees: f32,
    // rust: width: f32,
    // rust: height: f32,
    // rust: near: f32,
    // rust: far: f32,
    // rust: zero_to_one: bool,
    // rust: ) -> [f32; 16] {
    // rust: let h = horizon_core::jmath::tan(f64::from(fov_degrees * DEG_TO_RAD * 0.5)) as f32;
    // rust: let aspect = width / height;
    // rust: let mut m = [0.0f32; 16];
    // rust: m[0] = 1.0 / (h * aspect);
    // rust: m[5] = 1.0 / h;
    // rust: let e = 1.0e-6f32;
    // rust: if far > 0.0 && far.is_infinite() {
    // rust: m[10] = e - 1.0;
    // rust: m[14] = (e - if zero_to_one { 1.0 } else { 2.0 }) * near;
    // rust: } else if near > 0.0 && near.is_infinite() {
    // rust: m[10] = (if zero_to_one { 0.0 } else { 1.0 }) - e;
    // rust: m[14] = ((if zero_to_one { 1.0 } else { 2.0 }) - e) * far;
    // rust: } else {
    // rust: m[10] = (if zero_to_one { far } else { far + near }) / (near - far);
    // rust: m[14] = (if zero_to_one { far } else { far + far }) * near / (near - far);
}
    // rust: m[11] = -1.0;
    // rust: m
}
// `Frustum.getNearPlaneBounds`: the box around the four corners of the
// culling frustum's NDC `z = -1` plane, relative to the camera (the caller
// moves it to the eye). The culling projection is `Camera.update`'s
// `setPerspective(fov, aspect, 0.05, depthFar, zZeroToOne)`.
    // rust: pub fn near_plane_bounds(
    // rust: fov_degrees: f32,
    // rust: width: f32,
    // rust: height: f32,
    // rust: yaw: f32,
    // rust: pitch: f32,
    // rust: far: f32,
    // rust: ) -> ([f64; 3], [f64; 3]) {
    // rust: let projection =
    // rust: glam::Mat4::from_cols_array(&perspective(fov_degrees, width, height, 0.05, far, true));
    // Frustum.calculateFrustum: projection * modelView.
    // rust: let clip_to_world = (projection * view_matrix(yaw, pitch)).inverse();
    // rust: let mut min = [f64::INFINITY; 3];
    // rust: let mut max = [f64::NEG_INFINITY; 3];
    // rust: for (x, y) in [(-1.0, -1.0), (1.0, -1.0), (1.0, 1.0), (-1.0, 1.0)] {
    // rust: let p = clip_to_world * glam::Vec4::new(x, y, -1.0, 1.0);
    // rust: let p = [p.x / p.w, p.y / p.w, p.z / p.w];
    // rust: for k in 0..3 {
    // rust: min[k] = min[k].min(f64::from(p[k]));
    // rust: max[k] = max[k].max(f64::from(p[k]));
}
}
    // rust: (min, max)
}
// `GameRenderer.render3dHud`: the first-person hand and held items are
// drawn with their own projection at `hudFov` (70 degrees, changed only by
// death and fluids), never the FOV option or the sprint, speed and bow
// modifier.
hand_projection :: proc(hud_fov: f32, width: f32, height: f32, far: f32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: perspective(hud_fov, width, height, far, 0.05, true)
}
// `Camera.modifyFovBasedOnDeathOrFluid`. `dead` is the camera entity's
// `deathTime` while it is a living entity that is dead or dying.
    // rust: pub fn modify_fov_based_on_death_or_fluid(
    // rust: partial: f32,
    // rust: mut fov: f32,
    // rust: effect_scale: f32,
    // rust: dead: Option<i32>,
    // rust: fluid: CameraFluid,
    // rust: ) -> f32 {
    // rust: if let Some(death_time) = dead {
    // rust: let duration = java_min(death_time as f32 + partial, 20.0);
    // rust: fov /= (1.0 - 500.0 / (duration + 500.0)) * 2.0 + 1.0;
}
    // rust: if matches!(fluid, CameraFluid::Lava | CameraFluid::Water) {
    // rust: fov *= lerp(effect_scale, 1.0, 0.857_142_87);
}
    // rust: fov
}

// `ClientAvatarState`: the walked distance, view bob and cloak of a player.
AvatarBob :: struct {
    walk_dist: f32,
    walk_dist_o: f32,
    bob: f32,
    bob_o: f32,
    // `xCloak`, `yCloak`, `zCloak`: a point trailing the player, which the cape leans from.
    cloak: [f64,
    cloak_o: [f64,
}
    // rust: impl AvatarBob {
    // `ClientAvatarState.tick` (at the start of `AbstractClientPlayer.tick`)
    // with the player's position then: `moveCloak` eases the cloak a quarter
    // of the way there, or puts it there from 10 blocks away.
tick :: proc(self: ^Self, position: [f64; 3]) {
}
    // rust: self.walk_dist_o = self.walk_dist;
    // rust: self.cloak_o = self.cloak;
    // rust: for i in 0..3 {
    // rust: let d = position[i] - self.cloak[i];
    // rust: if d > 10.0 || d < -10.0 {
    // rust: self.cloak[i] = position[i];
    // rust: self.cloak_o[i] = position[i];
    // rust: } else {
    // rust: self.cloak[i] += d * 0.25;
}
}
}
    // `AvatarRenderer.extractCapeState`: the cape's `capeFlap`, `capeLean`
    // and `capeLean2` (degrees) for the player at `position` (interpolated)
    // with its body turned `body_yaw` and its `fallFlyingScale`.
    // rust: pub fn cape(
    // rust: &self,
    // rust: partial: f32,
    // rust: position: [f64; 3],
    // rust: body_yaw: f32,
    // rust: fall_flying_scale: f32,
    // rust: ) -> [f32; 3] {
    // rust: let d: [f64; 3] = std::array::from_fn(|i| {
    // rust: lerp_d(f64::from(partial), self.cloak_o[i], self.cloak[i]) - position[i]
    // rust: });
    // rust: let rad = f64::from(body_yaw * DEG_TO_RAD);
    // rust: let (sin, cos) = (f64::from(trig::sin(rad)), f64::from(-trig::cos(rad)));
    // rust: let mut flap = (d[1] as f32 * 10.0).clamp(-6.0, 32.0);
    // rust: let lean = ((d[0] * sin + d[2] * cos) as f32 * 100.0 * (1.0 - fall_flying_scale))
    // rust: .clamp(0.0, 150.0);
    // rust: let lean2 = ((d[0] * cos - d[2] * sin) as f32 * 100.0).clamp(-20.0, 20.0);
    // rust: let bob = self.interpolated_bob(partial);
    // rust: let walk = lerp(partial, self.walk_dist_o, self.walk_dist);
    // rust: flap += trig::sin(f64::from(walk * 6.0)) * 32.0 * bob;
    // rust: [flap, lean, lean2]
}
    // `LocalPlayer.move`: `addWalkedDistance(Mth.length(dx, dz) * 0.6F)`
    // with the float horizontal displacement.
add_walked :: proc(self: ^Self, dx: f32, dz: f32) {
}
    // rust: self.walk_dist += (dx * dx + dz * dz).sqrt() * 0.6;
}
    // `AbstractClientPlayer.updateBob`: toward the horizontal speed (at most
    // 0.1) on the ground, toward 0 otherwise.
update_bob :: proc(self: ^Self, on_ground_alive_not_swimming: bool, velocity: [f64; 3]) {
}
    // rust: let target = if on_ground_alive_not_swimming {
    // rust: java_min(
    // rust: 0.1,
    // rust: (velocity[0] * velocity[0] + velocity[2] * velocity[2]).sqrt() as f32,
    // rust: )
    // rust: } else {
    // rust: 0.0
}
    // rust: self.bob_o = self.bob;
    // rust: self.bob += (target - self.bob) * 0.4;
}
    // `ClientAvatarState.resetBob` (`AbstractClientPlayer.rideTick`).
reset_bob :: proc(self: ^Self) {
}
    // rust: self.bob_o = self.bob;
    // rust: self.bob = 0.0;
}
interpolated_bob :: proc(self: ^Self, partial: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: lerp(partial, self.bob_o, self.bob)
}
backwards_interpolated_walk_distance :: proc(self: ^Self, partial: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let wda = self.walk_dist - self.walk_dist_o;
    // rust: -(self.walk_dist + wda * partial)
}
}

// The parts of `CameraRenderState.entityRenderState` the bobbing reads.
BobState :: struct {
    // A living camera entity: `hurtTime - partial`, `hurtDuration`,
    // `getHurtDir()`, and `deathTime + partial` when dead or dying.
    living: Maybe(HurtBob),
    // A player camera entity: the backwards-interpolated walk distance and
    // the interpolated bob.
    player: Option<(f32,
}
HurtBob :: struct {
    hurt_time: f32,
    hurt_duration: i32,
    hurt_dir: f32,
    death_time: Maybe(f32),
}
// `PoseStack.rotateDegrees` on the pose with an `Axis`.
rotate_degrees :: proc(m: ^Mat4, axis: uint, degrees: f32) {
}
    // rust: let ang = degrees * DEG_TO_RAD;
    // rust: match axis {
    // rust: 0 => m.rotate_x(ang),
    // rust: 1 => m.rotate_y(ang),
    // rust: _ => m.rotate_z(ang),
}
}
// `GameRenderer.bobHurt`.
bob_hurt :: proc(state: ^BobState, damage_tilt_strength: f64, pose: ^Mat4) {
}
    // rust: let Some(living) = state.living else { return };
    // rust: let mut hurt = living.hurt_time;
    // rust: if let Some(death_time) = living.death_time {
    // rust: let duration = java_min(death_time, 20.0);
    // rust: rotate_degrees(pose, 2, 40.0 - 8000.0 / (duration + 200.0));
}
    // rust: if hurt < 0.0 {
    // rust: return;
}
    // rust: hurt /= living.hurt_duration as f32;
    // rust: hurt = trig::sin(f64::from(hurt * hurt * hurt * hurt * PI));
    // rust: let rr = living.hurt_dir;
    // rust: rotate_degrees(pose, 1, -rr);
    // rust: let tilt = (f64::from(-hurt) * 14.0 * damage_tilt_strength) as f32;
    // rust: rotate_degrees(pose, 2, tilt);
    // rust: rotate_degrees(pose, 1, rr);
}
// `GameRenderer.bobView`.
bob_view :: proc(state: ^BobState, pose: ^Mat4) {
}
    // rust: let Some((walk, bob)) = state.player else {
    // rust: return;
}
    // rust: pose.translate(
    // rust: trig::sin(f64::from(walk * PI)) * bob * 0.5,
    // rust: -(trig::cos(f64::from(walk * PI)) * bob).abs(),
    // rust: 0.0,
    // rust: );
    // rust: rotate_degrees(pose, 2, trig::sin(f64::from(walk * PI)) * bob * 3.0);
    // rust: rotate_degrees(
    // rust: pose,
    // rust: 0,
    // rust: (trig::cos(f64::from(walk * PI - 0.2)) * bob).abs() * 5.0,
    // rust: );
}
// The bob matrix `GameRenderer.renderLevel` multiplies into the projection
// (and `renderItemInHand` into the hand's pose).
bob_matrix :: proc(state: ^BobState, damage_tilt_strength: f64, bob_view_option: bool) -> M {
    // Ported from Horizon
    return {}
}
    // rust: let mut pose = Mat4::IDENTITY;
    // rust: bob_hurt(state, damage_tilt_strength, &mut pose);
    // rust: if bob_view_option {
    // rust: bob_view(state, &mut pose);
}
    // rust: pose
}

// The spinning effect `GameRenderer.renderLevel` multiplies into the level's
// projection after the bob: a skew about a tilted axis, from a portal's or
// Nausea's intensity (already scaled by Distortion Effects) and the angle in
// degrees. The first-person hand keeps its own projection without it.
spinning_effect_matrix :: proc(intensity: f32, angle_degrees: f32) -> g {
    // Ported from Horizon
    return {}
}
    // rust: if intensity <= 0.0 {
    // rust: return glam::Mat4::IDENTITY;
}
    // rust: let mut skew = 5.0 / (intensity * intensity + 5.0) - intensity * 0.04;
    // rust: skew *= skew;
    // rust: let axis = glam::Vec3::new(
    // rust: 0.0,
    // rust: std::f32::consts::SQRT_2 / 2.0,
    // rust: std::f32::consts::SQRT_2 / 2.0,
    // rust: );
    // rust: let angle = angle_degrees * DEG_TO_RAD;
    // rust: glam::Mat4::from_axis_angle(axis, angle)
    // rust: * glam::Mat4::from_scale(glam::Vec3::new(1.0 / skew, 1.0, 1.0))
    // rust: * glam::Mat4::from_axis_angle(axis, -angle)
}

    // rust: mod tests {
near_plane_bounds_sit_half_a_near_distance_ahead_of_the_eye :: proc() {
}
        // Facing +Z (yaw 0): the zero-to-one culling projection puts NDC
        // z = -1 at -far * near / (2 far - near) in front of the camera.
    // rust: let far = 512.0;
    // rust: let (min, max) = super::near_plane_bounds(70.0, 1600.0, 900.0, 0.0, 0.0, far);
    // rust: let depth = f64::from(far * 0.05 / (2.0 * far - 0.05));
    // rust: assert!((min[2] - depth).abs() < 1e-4 && (max[2] - depth).abs() < 1e-4);
    // rust: let half_height = depth * 35.0f64.to_radians().tan();
    // rust: assert!((max[1] - half_height).abs() < 1e-4 && (min[1] + half_height).abs() < 1e-4);
    // rust: let half_width = half_height * 1600.0 / 900.0;
    // rust: assert!((max[0] - half_width).abs() < 1e-3 && (min[0] + half_width).abs() < 1e-3);
}
    // `moveCloak` trails a quarter of the way, jumps from 10 blocks away; the
    // cape leans back as the player walks forward (south, body yaw 0).
the_cloak_trails_the_player :: proc() {
}
    // rust: let mut a = super::AvatarBob::default();
    // rust: a.tick([0.0, 64.0, 0.0]);
    // rust: assert_eq!((a.cloak, a.cloak_o), ([0.0, 64.0, 0.0], [0.0, 64.0, 0.0]));
    // rust: a.tick([0.0, 64.0, 1.0]);
    // rust: assert_eq!(a.cloak, [0.0, 64.0, 0.25]);
    // rust: let [flap, lean, lean2] = a.cape(1.0, [0.0, 64.0, 1.0], 0.0, 0.0);
    // rust: assert_eq!((flap, lean, lean2), (0.0, 75.0, 0.0));
        // Falling lifts the flap, at most 32 degrees.
    // rust: assert_eq!(a.cape(1.0, [0.0, 60.0, 0.25], 0.0, 0.0)[0], 32.0);
        // Gliding takes the lean away.
    // rust: assert_eq!(a.cape(1.0, [0.0, 64.0, 1.0], 0.0, 1.0)[1], 0.0);
}

depth_far_covers_the_cloud_range :: proc() {
}
        // renderDistance 2 with the default Cloud Distance (128 chunks).
    // rust: assert_eq!(super::depth_far(2, 128), 2048.0);
    // rust: assert_eq!(super::depth_far(32, 2), 2048.0);
    // rust: assert_eq!(super::depth_far(12, 12), 768.0);
}
//     use super::*;
view_keeps_yaw_at_vertical_pitch_limits :: proc() {
}
    // rust: for yaw in [0.0, 45.0, 90.0, 180.0, -90.0, 360.0] {
    // rust: for pitch in [-90.0, -89.999, 0.0, 89.999, 90.0] {
    // rust: let view = view_matrix(yaw, pitch);
    // rust: let mut camera = Camera::default();
    // rust: camera.set_rotation(yaw, pitch);
    // rust: for (world, expected) in [
    // rust: (camera.forwards, -glam::Vec3::Z),
    // rust: (camera.up, glam::Vec3::Y),
    // rust: (camera.left, -glam::Vec3::X),
    // rust: ] {
    // rust: let got = view.transform_vector3(glam::Vec3::from(world));
    // rust: assert!(
    // rust: (got - expected).length() < 1e-5,
    // rust: "yaw={yaw}, pitch={pitch}: {got:?} != {expected:?}"
    // rust: );
}
}
}
}
camera_eases_eye_height_and_fov :: proc() {
}
    // rust: let mut camera = Camera::default();
    // rust: camera.tick(Some(1.62), 1.0);
    // rust: assert_eq!(camera.eye_height, 0.81);
    // rust: assert_eq!(camera.fov_modifier, 0.5);
    // rust: camera.tick(None, 1.0);
    // rust: assert_eq!(camera.eye_height, 0.81);
    // rust: assert_eq!(camera.fov_modifier, 0.75);
}
rotation_faces_south_at_zero_yaw :: proc() {
}
    // rust: let mut camera = Camera::default();
    // rust: camera.set_rotation(0.0, 0.0);
    // rust: assert!((camera.forwards[2] - 1.0).abs() < 1e-6);
    // rust: camera.set_rotation(90.0, 0.0);
    // rust: assert!((camera.forwards[0] + 1.0).abs() < 1e-6);
}
detached_camera_backs_off_until_blocked :: proc() {
}
    // rust: let entity = CameraEntity {
    // rust: position: [0.0; 3],
    // rust: previous: [0.0; 3],
    // rust: x_rot: 0.0,
    // rust: y_rot: 0.0,
    // rust: x_rot_o: 0.0,
    // rust: y_rot_o: 0.0,
    // rust: eye_height: 1.62,
    // rust: living: None,
    // rust: mount: None,
}
    // rust: let mut camera = Camera::default();
    // rust: camera.align_with_entity(&entity, 1.0, CameraType::ThirdPersonBack, |_, _| None);
    // rust: assert!((camera.position[2] + 4.0).abs() < 1e-6);
    // rust: camera.align_with_entity(&entity, 1.0, CameraType::ThirdPersonBack, |_, _| {
    // rust: Some([0.0, 0.0, -1.0])
    // rust: });
    // rust: assert!(camera.position[2] > -1.1 && camera.position[2] < -0.9);
}
detached_distance_override_keeps_collision_clipping :: proc() {
}
    // rust: let entity = CameraEntity {
    // rust: position: [0.0; 3],
    // rust: previous: [0.0; 3],
    // rust: x_rot: 0.0,
    // rust: y_rot: 0.0,
    // rust: x_rot_o: 0.0,
    // rust: y_rot_o: 0.0,
    // rust: eye_height: 1.62,
    // rust: living: Some(LivingCamera {
    // rust: scale: 2.0,
    // rust: camera_distance: 3.0,
    // rust: sleeping: None,
    // rust: dead: None,
    // rust: }),
    // rust: mount: Some((3.0, 4.0)),
}
    // rust: for kind in [CameraType::ThirdPersonBack, CameraType::ThirdPersonFront] {
    // rust: let mut camera = Camera::default();
    // rust: let mut calls = 0;
    // rust: let mut rays = 0;
    // rust: let z = if kind.is_mirrored() { 1.0 } else { -1.0 };
    // rust: camera.align_with_entity_distance(
    // rust: &entity,
    // rust: 1.0,
    // rust: kind,
    // rust: |distance| {
    // rust: assert_eq!(distance, 12.0);
    // rust: 8.0
    // rust: },
    // rust: |_, _| None,
    // rust: );
    // rust: assert!((camera.position[2] - z * 8.0).abs() < 1e-5);
    // rust: camera.align_with_entity_distance(
    // rust: &entity,
    // rust: 1.0,
    // rust: kind,
    // rust: |distance| {
    // rust: calls += 1;
    // rust: assert_eq!(distance, 12.0);
    // rust: 8.0
    // rust: },
    // rust: |_, _| {
    // rust: rays += 1;
    // rust: Some([0.0, 0.0, z])
    // rust: },
    // rust: );
    // rust: assert_eq!((calls, rays), (1, 8));
    // rust: assert!((camera.position[2] - z).abs() < 0.2);
}
}
detached_distance_rejects_invalid_values_and_accepts_zero :: proc() {
}
    // rust: let entity = CameraEntity {
    // rust: position: [0.0; 3],
    // rust: previous: [0.0; 3],
    // rust: x_rot: 0.0,
    // rust: y_rot: 0.0,
    // rust: x_rot_o: 0.0,
    // rust: y_rot_o: 0.0,
    // rust: eye_height: 1.62,
    // rust: living: None,
    // rust: mount: None,
}
    // rust: for distance in [f32::NAN, f32::INFINITY, -1.0, 1025.0] {
    // rust: let mut camera = Camera::default();
    // rust: camera.align_with_entity_distance(
    // rust: &entity,
    // rust: 1.0,
    // rust: CameraType::ThirdPersonBack,
    // rust: |_| distance,
    // rust: |_, _| None,
    // rust: );
    // rust: assert!((camera.position[2] + 4.0).abs() < 1e-6);
}
    // rust: let mut camera = Camera::default();
    // rust: camera.align_with_entity_distance(
    // rust: &entity,
    // rust: 1.0,
    // rust: CameraType::ThirdPersonBack,
    // rust: |_| 0.0,
    // rust: |_, _| None,
    // rust: );
    // rust: assert_eq!(camera.position, camera.eye);
    // rust: camera.align_with_entity_distance(
    // rust: &entity,
    // rust: 1.0,
    // rust: CameraType::FirstPerson,
    // rust: |_| panic!("first person has no detached distance"),
    // rust: |_, _| None,
    // rust: );
    // rust: assert_eq!(camera.position, camera.eye);
}
fov_modifier_combines_speed_flight_and_bow :: proc() {
}
    // rust: let mut p = FovPlayer {
    // rust: flying: false,
    // rust: walking_speed: 0.1,
    // rust: movement_speed: 0.13,
    // rust: using: None,
}
    // rust: assert_eq!(
    // rust: field_of_view_modifier(&p, true, 1.0),
    // rust: (0.13f32 / 0.1 + 1.0) / 2.0
    // rust: );
    // rust: assert_eq!(field_of_view_modifier(&p, true, 0.0), 1.0);
    // rust: p.using = Some((UseItem::Spyglass, 3));
    // rust: assert_eq!(field_of_view_modifier(&p, true, 1.0), 0.1);
    // rust: assert_ne!(field_of_view_modifier(&p, false, 1.0), 0.1);
}
}
