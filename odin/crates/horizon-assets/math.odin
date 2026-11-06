//! Transpiled from Horizon Rust crate
package horizon_assets_math

import "core:fmt"
import "core:mem"
import "core:math"

// Column-major `Matrix4f` arithmetic as JOML 1.10.9 computes it, for composing
// item-model transformations: each operation takes the path JOML picks from
// the matrix properties (identity, translation, affine...), and `Math.fma` is
// `a * b + c` since Minecraft leaves `joml.useMathFma` off.

// `Matrix4fc.PROPERTY_*` bits.
PERSPECTIVE :: 1
AFFINE :: 2
IDENTITY :: 4
TRANSLATION :: 8
ORTHONORMAL :: 16

// JOML `Math.fma` without `joml.useMathFma`.
fma :: proc(a: f32, b: f32, c: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: a * b + c
}
// JOML `Math.absEqualsOne`.
abs_equals_one :: proc(r: f32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: r.to_bits() & 0x7FFF_FFFF == 0x3F80_0000
}

// A JOML `Matrix4f`: `m[column][row]`, with its property bits.
Mat4 :: struct {

    // rust: impl Mat4 {
    // `new Matrix4f()`.
    // rust: pub const IDENTITY: Self = Self(
    // rust: [
    // rust: [1.0, 0.0, 0.0, 0.0],
    // rust: [0.0, 1.0, 0.0, 0.0],
    // rust: [0.0, 0.0, 1.0, 0.0],
    // rust: [0.0, 0.0, 0.0, 1.0],
    // rust: ],
    // rust: IDENTITY | AFFINE | TRANSLATION | ORTHONORMAL,
    // rust: );
    // `Matrix4f.translation(x, y, z)`.
translation :: proc(t: [f32; 3]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut m = Self::IDENTITY;
    // rust: m.0[3][..3].copy_from_slice(&t);
    // rust: m.1 = AFFINE | TRANSLATION | ORTHONORMAL;
    // rust: m
}
    // `ExtraCodecs.MATRIX4F`: sixteen values in row-major order, then
    // `determineProperties`.
from_row_major :: proc(values: [f32; 16]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut m = Self([[0.0; 4]; 4], 0);
    // rust: for (i, v) in values.into_iter().enumerate() {
    // rust: m.0[i & 3][i >> 2] = v;
}
    // rust: m.1 = m.determine_properties();
    // rust: m
}
    // `Matrix4f.determineProperties`.
determine_properties :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let m = &self.0;
    // rust: let mut properties = 0;
    // rust: if m[0][3] == 0.0 && m[1][3] == 0.0 {
    // rust: if m[2][3] == 0.0 && m[3][3] == 1.0 {
    // rust: properties |= AFFINE;
    // rust: if m[0] == [1.0, 0.0, 0.0, 0.0]
    // rust: && m[1] == [0.0, 1.0, 0.0, 0.0]
    // rust: && m[2] == [0.0, 0.0, 1.0, 0.0]
    // rust: {
    // rust: properties |= TRANSLATION | ORTHONORMAL;
    // rust: if m[3][0] == 0.0 && m[3][1] == 0.0 && m[3][2] == 0.0 {
    // rust: properties |= IDENTITY;
}
}
    // rust: } else if m[0][1] == 0.0
    // rust: && m[0][2] == 0.0
    // rust: && m[1][0] == 0.0
    // rust: && m[1][2] == 0.0
    // rust: && m[2][0] == 0.0
    // rust: && m[2][1] == 0.0
    // rust: && m[3][0] == 0.0
    // rust: && m[3][1] == 0.0
    // rust: && m[3][3] == 0.0
    // rust: {
    // rust: properties |= PERSPECTIVE;
}
}
    // rust: properties
}
has :: proc(self: ^Self, property: u8) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.1 & property != 0
}
    // The matrix as `[row][column]` entries, the order `getRowColumn` reads.
rows :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: std::array::from_fn(|r| std::array::from_fn(|c| self.0[c][r]))
}
    // `this * right` (`Matrix4f.mul`).
mul :: proc(self: ^Self, right: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let (m, r) = (&self.0, &right.0);
    // rust: if self.has(IDENTITY) {
    // rust: return *right;
}
    // rust: if right.has(IDENTITY) {
    // rust: return *self;
}
    // rust: let mut out = [[0.0; 4]; 4];
    // rust: if self.has(TRANSLATION) && right.has(AFFINE) {
            // mulTranslationAffine
    // rust: for c in 0..4 {
    // rust: out[c] = [r[c][0], r[c][1], r[c][2], m[c][3]];
}
    // rust: for row in 0..3 {
    // rust: out[3][row] = r[3][row] + m[3][row];
}
    // rust: return Self(out, AFFINE | right.1 & ORTHONORMAL);
}
    // rust: if self.has(AFFINE) && right.has(AFFINE) {
            // mulAffine
    // rust: for c in 0..3 {
    // rust: for row in 0..3 {
    // rust: out[c][row] = fma(
    // rust: m[0][row],
    // rust: r[c][0],
    // rust: fma(m[1][row], r[c][1], m[2][row] * r[c][2]),
    // rust: );
}
    // rust: out[c][3] = m[c][3];
}
    // rust: for row in 0..3 {
    // rust: out[3][row] = fma(
    // rust: m[0][row],
    // rust: r[3][0],
    // rust: fma(m[1][row], r[3][1], fma(m[2][row], r[3][2], m[3][row])),
    // rust: );
}
    // rust: out[3][3] = m[3][3];
    // rust: return Self(out, AFFINE | self.1 & right.1 & ORTHONORMAL);
}
    // rust: if self.has(PERSPECTIVE) && right.has(AFFINE) {
            // mulPerspectiveAffine
    // rust: for c in 0..4 {
    // rust: out[c] = [
    // rust: m[0][0] * r[c][0],
    // rust: m[1][1] * r[c][1],
    // rust: m[2][2] * r[c][2],
    // rust: m[2][3] * r[c][2],
    // rust: ];
}
    // rust: out[3][2] = m[2][2] * r[3][2] + m[3][2];
    // rust: out[3][3] = m[2][3] * r[3][2];
    // rust: return Self(out, 0);
}
    // rust: if right.has(AFFINE) {
            // mulAffineR
    // rust: for c in 0..3 {
    // rust: for row in 0..4 {
    // rust: out[c][row] = fma(
    // rust: m[0][row],
    // rust: r[c][0],
    // rust: fma(m[1][row], r[c][1], m[2][row] * r[c][2]),
    // rust: );
}
}
    // rust: for row in 0..4 {
    // rust: out[3][row] = fma(
    // rust: m[0][row],
    // rust: r[3][0],
    // rust: fma(m[1][row], r[3][1], fma(m[2][row], r[3][2], m[3][row])),
    // rust: );
}
    // rust: return Self(
    // rust: out,
    // rust: self.1 & !(PERSPECTIVE | IDENTITY | TRANSLATION | ORTHONORMAL),
    // rust: );
}
        // mul0
    // rust: for c in 0..4 {
    // rust: for row in 0..4 {
    // rust: out[c][row] = fma(
    // rust: m[0][row],
    // rust: r[c][0],
    // rust: fma(
    // rust: m[1][row],
    // rust: r[c][1],
    // rust: fma(m[2][row], r[c][2], m[3][row] * r[c][3]),
    // rust: ),
    // rust: );
}
}
    // rust: Self(out, 0)
}
    // `Matrix4f.translate(x, y, z)`.
translate :: proc(self: ^Self, t: [f32; 3]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: if self.has(IDENTITY) {
    // rust: return Self::translation(t);
}
        // translateGeneric
    // rust: let mut out = *self;
    // rust: for row in 0..4 {
    // rust: out.0[3][row] = fma(
    // rust: self.0[0][row],
    // rust: t[0],
    // rust: fma(
    // rust: self.0[1][row],
    // rust: t[1],
    // rust: fma(self.0[2][row], t[2], self.0[3][row]),
    // rust: ),
    // rust: );
}
    // rust: out.1 = self.1 & !(PERSPECTIVE | IDENTITY);
    // rust: out
}
    // `Matrix4f.scale(x, y, z)`.
scale :: proc(self: ^Self, s: [f32; 3]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let one = s.iter().all(|&v| abs_equals_one(v));
    // rust: if self.has(IDENTITY) {
            // scaling
    // rust: let mut out = Self::IDENTITY;
    // rust: for (c, v) in s.into_iter().enumerate() {
    // rust: out.0[c][c] = v;
}
    // rust: out.1 = AFFINE | if one { ORTHONORMAL } else { 0 };
    // rust: return out;
}
        // scaleGeneric: the first three columns are scaled.
    // rust: let mut out = *self;
    // rust: for c in 0..3 {
    // rust: for row in 0..4 {
    // rust: out.0[c][row] = self.0[c][row] * s[c];
}
}
    // rust: out.1 =
    // rust: self.1 & !(PERSPECTIVE | IDENTITY | TRANSLATION | if one { 0 } else { ORTHONORMAL });
    // rust: out
}
    // `Matrix4f.rotate(Quaternionfc)`.
rotate :: proc(self: ^Self, q: [f32; 4]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let [x, y, z, w] = q;
    // rust: let (w2, x2, y2, z2) = (w * w, x * x, y * y, z * z);
    // rust: let (zw, xy, xz, yw, yz, xw) = (z * w, x * y, x * z, y * w, y * z, x * w);
    // rust: let (dzw, dxy, dxz, dyw, dyz, dxw) = (zw + zw, xy + xy, xz + xz, yw + yw, yz + yz, xw + xw);
    // rust: let r = [
    // rust: [w2 + x2 - z2 - y2, dxy + dzw, dxz - dyw],
    // rust: [-dzw + dxy, y2 - z2 + w2 - x2, dyz + dxw],
    // rust: [dyw + dxz, dyz - dxw, z2 - y2 - x2 + w2],
    // rust: ];
    // rust: let m = &self.0;
    // rust: let mut out = *self;
    // rust: if self.has(IDENTITY) {
            // rotation
    // rust: for c in 0..3 {
    // rust: out.0[c][..3].copy_from_slice(&r[c]);
}
    // rust: out.1 = AFFINE | ORTHONORMAL;
    // rust: return out;
}
    // rust: out.1 = self.1 & !(PERSPECTIVE | IDENTITY | TRANSLATION);
    // rust: if self.has(TRANSLATION) {
            // rotateTranslation
    // rust: for c in 0..3 {
    // rust: out.0[c] = [r[c][0], r[c][1], r[c][2], 0.0];
}
    // rust: } else if self.has(AFFINE) {
            // rotateAffine
    // rust: for c in 0..3 {
    // rust: for row in 0..3 {
    // rust: out.0[c][row] = m[0][row] * r[c][0] + m[1][row] * r[c][1] + m[2][row] * r[c][2];
}
    // rust: out.0[c][3] = 0.0;
}
    // rust: } else {
            // rotateGeneric
    // rust: for c in 0..3 {
    // rust: for row in 0..4 {
    // rust: out.0[c][row] = fma(
    // rust: m[0][row],
    // rust: r[c][0],
    // rust: fma(m[1][row], r[c][1], m[2][row] * r[c][2]),
    // rust: );
}
}
}
    // rust: out
}
is_finite :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.0.iter().flatten().all(|v| v.is_finite())
}
}

// `Quaternionf.normalize` as the codec applies it to four components.
normalize_quaternion :: proc(q: [f32; 4]) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let [x, y, z, w] = q;
    // rust: let inv = 1.0 / (x * x + (y * y + (z * z + w * w))).sqrt();
    // rust: [x * inv, y * inv, z * inv, w * inv]
}
// JOML `Math.sin(float)` without fast math.
joml_sin :: proc(rad: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: f64::from(rad).sin() as f32
}
// JOML `Math.cosFromSin(float, float)` without fast math: the magnitude from
// the sine, the sign from the angle's quadrant (exact zeros at right angles).
cos_from_sin :: proc(sin: f32, angle: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let cos = (1.0 - sin * sin).sqrt();
    // rust: let tau = (std::f64::consts::PI * 2.0) as f32;
    // rust: let a = angle + std::f32::consts::FRAC_PI_2;
    // rust: let mut b = a - (a / tau) as i32 as f32 * tau;
    // rust: if b < 0.0 {
    // rust: b += tau;
}
    // rust: if b >= std::f32::consts::PI { -cos } else { cos }
}
// `Quaternionf.rotationXYZ` from angles in radians.
quaternion_xyz :: proc(x: f32, y: f32, z: f32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let half = |a: f32| -> (f32, f32) {
    // rust: let h = a * 0.5;
    // rust: let s = joml_sin(h);
    // rust: (s, cos_from_sin(s, h))
}
    // rust: let ((sx, cx), (sy, cy), (sz, cz)) = (half(x), half(y), half(z));
    // rust: let (cycz, sysz, sycz, cysz) = (cy * cz, sy * sz, sy * cz, cy * sz);
    // rust: [
    // rust: sx * cycz + cx * sysz,
    // rust: cx * sycz - sx * cysz,
    // rust: cx * cysz + sx * sycz,
    // rust: cx * cycz - sx * sysz,
    // rust: ]
}
// `new Quaternionf(new AxisAngle4f(angle, axis))`: the angle is wrapped into
// [0, 2π) and the axis is used as given.
quaternion_from_axis_angle :: proc(angle: f32, axis: [f32; 3]) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let tau = (std::f64::consts::PI * 2.0) as f32;
    // rust: let angle = if angle < 0.0 {
    // rust: tau + angle % tau
    // rust: } else {
    // rust: angle
    // rust: } % tau;
    // rust: let sin = joml_sin(angle * 0.5);
    // rust: let cos = cos_from_sin(sin, angle * 0.5);
    // rust: [axis[0] * sin, axis[1] * sin, axis[2] * sin, cos]
}

// A JOML `Matrix3f`: `m[column][row]`.
    // rust: type Mat3 = [[f32; 3]; 3];

// `Matrix3f.mul`: `a * b`.
mul3 :: proc(a: ^Mat3, b: ^Mat3) -> M {
    // Ported from Horizon
    return {}
}
    // rust: std::array::from_fn(|c| {
    // rust: std::array::from_fn(|r| fma(a[0][r], b[c][0], fma(a[1][r], b[c][1], a[2][r] * b[c][2])))
    // rust: })
}
// `Matrix3f.transpose`.
transpose3 :: proc(m: ^Mat3) -> M {
    // Ported from Horizon
    return {}
}
    // rust: std::array::from_fn(|c| std::array::from_fn(|r| m[r][c]))
}
// `Matrix3f.rotate(Quaternionfc)`: `m * R(q)`, without fma.
rotate3 :: proc(m: ^Mat3, q: [f32; 4]) -> M {
    // Ported from Horizon
    return {}
}
    // rust: let [x, y, z, w] = q;
    // rust: let (w2, x2, y2, z2) = (w * w, x * x, y * y, z * z);
    // rust: let (zw, xy, xz, yw, yz, xw) = (z * w, x * y, x * z, y * w, y * z, x * w);
    // rust: let (zw, xy, xz, yw, yz, xw) = (zw + zw, xy + xy, xz + xz, yw + yw, yz + yz, xw + xw);
    // rust: let rotation = [
    // rust: [w2 + x2 - z2 - y2, xy + zw, xz - yw],
    // rust: [xy - zw, y2 - z2 + w2 - x2, yz + xw],
    // rust: [yw + xz, yz - xw, z2 - y2 - x2 + w2],
    // rust: ];
    // rust: std::array::from_fn(|c| {
    // rust: let rc = rotation[c];
    // rust: std::array::from_fn(|r| m[0][r] * rc[0] + m[1][r] * rc[1] + m[2][r] * rc[2])
    // rust: })
}
// `Quaternionf.mul`: `a * b`.
quaternion_mul :: proc(a: [f32; 4], b: [f32; 4]) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let ([x, y, z, w], [qx, qy, qz, qw]) = (a, b);
    // rust: [
    // rust: fma(w, qx, fma(x, qw, fma(y, qz, -z * qy))),
    // rust: fma(w, qy, fma(-x, qz, fma(y, qw, z * qx))),
    // rust: fma(w, qz, fma(x, qy, fma(-y, qx, z * qw))),
    // rust: fma(w, qw, fma(-x, qx, fma(-y, qy, -z * qz))),
    // rust: ]
}

// `GivensParameters`: the half angle's sine and cosine.
Givens :: struct {

    // rust: impl Givens {
    // `GivensParameters.fromUnnormalized`.
unnormalized :: proc(sin_half: f32, cos_half: f32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let inv = 1.0 / (sin_half * sin_half + cos_half * cos_half).sqrt();
    // rust: Self(inv * sin_half, inv * cos_half)
}
    // `MatrixUtil.PI_4`: `fromPositiveAngle(π / 4)`.
quarter_pi :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: let half = std::f32::consts::FRAC_PI_4 / 2.0;
    // rust: let sin = joml_sin(half);
    // rust: Self(sin, cos_from_sin(sin, half))
}
inverse :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self(-self.0, self.1)
}
cos :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.1 * self.1 - self.0 * self.0
}
sin :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: 2.0 * self.0 * self.1
}
    // `aroundX/Y/Z(Quaternionf)` (axis 0, 1, 2).
quaternion :: proc(self: ^Self, axis: uint) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let mut q = [0.0, 0.0, 0.0, self.1];
    // rust: q[axis] = self.0;
    // rust: q
}
    // `aroundX/Y/Z(Matrix3f)` (axis 0, 1, 2).
matrix :: proc(self: ^Self, axis: uint) -> M {
    // Ported from Horizon
    return {}
}
    // rust: let (cos, sin) = (self.cos(), self.sin());
    // rust: let (a, b) = ((axis + 1) % 3, (axis + 2) % 3);
    // rust: let mut m = [[0.0; 3]; 3];
    // rust: m[axis][axis] = 1.0;
    // rust: m[a][a] = cos;
    // rust: m[b][b] = cos;
    // rust: m[a][b] = sin;
    // rust: m[b][a] = -sin;
    // rust: m
}
}

// `MatrixUtil.approxGivensQuat`.
approx_givens :: proc(a11: f32, a12: f32, a22: f32) -> G {
    // Ported from Horizon
    return {}
}
    // rust: let g = 3.0 + 2.0 * 2.0f32.sqrt();
    // rust: let (cos_half, sin_half) = (2.0 * (a11 - a22), a12);
    // rust: if g * sin_half * sin_half < cos_half * cos_half {
    // rust: Givens::unnormalized(sin_half, cos_half)
    // rust: } else {
    // rust: Givens::quarter_pi()
}
}
// `MatrixUtil.qrGivensQuat`.
qr_givens :: proc(a1: f32, a2: f32) -> G {
    // Ported from Horizon
    return {}
}
    // rust: let p = f64::from(a1).hypot(f64::from(a2)) as f32;
    // rust: let mut sin_half = if p > 1.0e-6 { a2 } else { 0.0 };
    // rust: let mut cos_half = a1.abs() + if p > 1.0e-6 { p } else { 1.0e-6 };
    // rust: if a1 < 0.0 {
    // rust: std::mem::swap(&mut sin_half, &mut cos_half);
}
    // rust: Givens::unnormalized(sin_half, cos_half)
}
// `MatrixUtil.stepJacobi`: the xy, xz then yz pairs, each by
// `similarityTransform` (`R^T * m * R`).
step_jacobi :: proc(m: ^Mat3, q: ^[f32; 4]) {
}
    // rust: let mut rotate = |m: &mut Mat3, g: Givens, axis: usize| {
    // rust: *q = quaternion_mul(*q, g.quaternion(axis));
    // rust: let r = g.matrix(axis);
    // rust: *m = mul3(&transpose3(&r), &mul3(m, &r));
}
    // rust: if m[0][1] * m[0][1] + m[1][0] * m[1][0] > 1.0e-6 {
    // rust: let g = approx_givens(m[0][0], 0.5 * (m[0][1] + m[1][0]), m[1][1]);
    // rust: rotate(m, g, 2);
}
    // rust: if m[0][2] * m[0][2] + m[2][0] * m[2][0] > 1.0e-6 {
    // rust: let g = approx_givens(m[0][0], 0.5 * (m[0][2] + m[2][0]), m[2][2]).inverse();
    // rust: rotate(m, g, 1);
}
    // rust: if m[1][2] * m[1][2] + m[2][1] * m[2][1] > 1.0e-6 {
    // rust: let g = approx_givens(m[1][1], 0.5 * (m[1][2] + m[2][1]), m[2][2]);
    // rust: rotate(m, g, 0);
}
}

// `MatrixUtil.svdDecompose(Matrix4fc, ...)`, how `new Transformation(matrix)`
// splits a matrix: translation, left rotation, scale, right rotation. The
// right rotation diagonalizes `a^T * a` (`eigenvalueJacobi`, 5 steps), then
// QR Givens rotations about z, y and x bring `a * R(right)` to the scale.
svd_decompose :: proc(m: ^Mat4) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let inv = 1.0 / m.0[3][3];
    // rust: let a: Mat3 = std::array::from_fn(|c| std::array::from_fn(|r| m.0[c][r] * inv));
    // rust: let mut b = mul3(&transpose3(&a), &a);
    // rust: let mut right = [0.0, 0.0, 0.0, 1.0];
    // rust: for _ in 0..5 {
    // rust: step_jacobi(&mut b, &mut right);
}
    // rust: right = normalize_quaternion(right);
    // rust: let (x_small, y_small) = (f64::from(b[0][0]) < 1.0e-6, f64::from(b[1][1]) < 1.0e-6);
    // rust: let mut left = [0.0, 0.0, 0.0, 1.0];
    // rust: let mut r = rotate3(&a, right);
    // rust: let mut qr = |r: &mut Mat3, g: Givens, axis: usize| {
    // rust: left = quaternion_mul(left, g.quaternion(axis));
    // rust: *r = mul3(&transpose3(&g.matrix(axis)), r);
}
    // rust: let g = if x_small {
    // rust: qr_givens(r[1][1], -r[1][0])
    // rust: } else {
    // rust: qr_givens(r[0][0], r[0][1])
}
    // rust: qr(&mut r, g, 2);
    // rust: let g = if x_small {
    // rust: qr_givens(r[2][2], -r[2][0])
    // rust: } else {
    // rust: qr_givens(r[0][0], r[0][2])
}
    // rust: qr(&mut r, g.inverse(), 1);
    // rust: let g = if y_small {
    // rust: qr_givens(r[2][2], -r[2][1])
    // rust: } else {
    // rust: qr_givens(r[1][1], r[1][2])
}
    // rust: qr(&mut r, g, 0);
    // rust: let scale = [r[0][0], r[1][1], r[2][2]];
    // rust: let translation = std::array::from_fn(|i| m.0[3][i] * inv);
    // rust: let [x, y, z, w] = right;
    // rust: (translation, left, scale, [-x, -y, -z, w])
}

    // rust: mod tests {
//     use super::*;
composes_in_joml_order :: proc() {
}
    // rust: let t = Mat4::translation([1.0, 2.0, 3.0]);
    // rust: let s = Mat4::IDENTITY.scale([2.0, -1.0, 1.0]);
    // rust: let m = t.mul(&s);
    // rust: assert_eq!(m.0[0][0], 2.0);
    // rust: assert_eq!(m.0[1][1], -1.0);
    // rust: assert_eq!(m.0[3][..3], [1.0, 2.0, 3.0]);
    // rust: assert_eq!(s.mul(&t).0[3][..3], [2.0, -2.0, 3.0]);
}
quarter_turn_about_z_rotates_x_into_y :: proc() {
}
    // rust: let q = quaternion_from_axis_angle(std::f32::consts::FRAC_PI_2, [0.0, 0.0, 1.0]);
    // rust: let m = Mat4::IDENTITY.rotate(q);
    // rust: assert!((m.0[0][1] - 1.0).abs() < 1e-6 && m.0[0][0].abs() < 1e-6);
}
svd_decomposes_like_matrix_util :: proc() {
}
    // rust: let bits = |v: &[f32]| v.iter().map(|f| f.to_bits()).collect::<Vec<_>>();
    // rust: let parts = |m: [f32; 16]| {
    // rust: let (t, l, s, r) = svd_decompose(&Mat4::from_row_major(m));
    // rust: [bits(&t), bits(&l), bits(&s), bits(&r)]
}
        // Values from MatrixUtil.svdDecompose on the 26.3 jar.
    // rust: let scaled = [
    // rust: 2.0, 0.0, 0.0, 1.0, 0.0, 3.0, 0.0, -2.0, 0.0, 0.0, 0.5, 0.25, 0.0, 0.0, 0.0, 1.0,
    // rust: ];
    // rust: assert_eq!(
    // rust: parts(scaled),
    // rust: [
    // rust: vec![0x3f80_0000u32, 0xc000_0000, 0x3e80_0000],
    // rust: vec![0u32, 0, 0, 0x3f80_0000],
    // rust: vec![0x4000_0000u32, 0x4040_0000, 0x3f00_0000],
    // rust: vec![0x8000_0000u32, 0x8000_0000, 0x8000_0000, 0x3f80_0000],
    // rust: ]
    // rust: );
    // rust: let quarter_turn = [
    // rust: 0.0, -1.0, 0.0, 0.5, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0,
    // rust: ];
    // rust: assert_eq!(
    // rust: parts(quarter_turn),
    // rust: [
    // rust: vec![0x3f00_0000u32, 0, 0],
    // rust: vec![0u32, 0, 0x3f35_04f3, 0x3f35_04f3],
    // rust: vec![0x3f7f_ffffu32, 0x3f7f_ffff, 0x3f80_0000],
    // rust: vec![0x8000_0000u32, 0x8000_0000, 0x8000_0000, 0x3f80_0000],
    // rust: ]
    // rust: );
    // rust: let sheared = [
    // rust: 1.0, 0.5, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.25, 0.0, 2.0, 3.0, 0.0, 0.0, 0.0, 2.0,
    // rust: ];
    // rust: assert_eq!(
    // rust: parts(sheared),
    // rust: [
    // rust: vec![0u32, 0, 0x3fc0_0000],
    // rust: vec![0x3c03_7010u32, 0x3d38_d722, 0x3ea8_ef95, 0x3f71_60d9],
    // rust: vec![0x3f23_2630u32, 0x3ec6_bdde, 0x3f81_5b1f],
    // rust: vec![0xbcc5_7e11u32, 0xbda8_1e36, 0xbee2_916d, 0x3f64_860a],
    // rust: ]
    // rust: );
}
half_turn_has_exact_zeros_like_joml :: proc() {
}
    // rust: let half_turn = 180.0 * (std::f64::consts::PI / 180.0) as f32;
    // rust: assert_eq!(quaternion_xyz(0.0, half_turn, 0.0), [0.0, 1.0, 0.0, 0.0]);
}
}
