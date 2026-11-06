//! Transpiled from Horizon Rust crate
package horizon_core_jmath

import "core:fmt"
import "core:mem"
import "core:math"

// `java.lang.Math` as HotSpot computes it on the machine Horizon runs on.
//
// Rust's float functions call the platform's libm, and those round
// differently: glibc, Apple's libm and fdlibm disagree in the last bit for
// a few percent of arguments. Vanilla's own results differ between machines
// too, because HotSpot replaces some `Math` methods with intrinsics:
//
// - `atan2`, `atan`, `asin`, `acos` and `hypot` are `StrictMath`'s (fdlibm)
//   everywhere.
// - On x86-64, `sin`, `cos`, `tan`, `exp`, `log`, `log10` and `pow` are
//   Intel's libm stubs, which round like glibc for nearly every argument;
//   there they use the platform libm, as before. Windows' libm (Microsoft's)
//   rounds `sin` and `cos` differently for about 3% of arguments, so there
//   they are correctly rounded instead ([`exact`]), as Intel's stubs are for
//   all but about 0.1%.
// - On AArch64 only `sin` and `cos` are intrinsics: fdlibm's kernels
//   evaluated with fused multiply-adds (`macroAssembler_aarch64_trig.cpp`).
//   Everything else is `StrictMath`.
//
// So these functions return what vanilla returns on the same machine, on
// Linux and on an Apple silicon Mac alike.

// `Math.round(float)`, bit for bit: exact (no `x + 0.5` in `f32`), ties toward
// positive infinity, saturating to the `int` range, NaN to 0.
round_f32 :: proc(a: f32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let bits = a.to_bits() as i32;
    // rust: let biased_exp = (bits & 0x7F80_0000) >> 23;
    // rust: let shift = (22 + 127) - biased_exp;
    // rust: if shift & -32 == 0 {
    // rust: let mut r = bits & 0x007F_FFFF | 0x0080_0000;
    // rust: if bits < 0 {
    // rust: r = -r;
}
    // rust: ((r >> shift) + 1) >> 1
    // rust: } else {
    // rust: a as i32
}
}

// `Math.sin`.
sin :: proc(x: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if cfg!(target_arch = "aarch64") {
    // rust: aarch64::sin(x)
    // rust: } else if cfg!(windows) {
    // rust: exact::sin(x)
    // rust: } else {
    // rust: x.sin()
}
}

// `Math.cos`.
cos :: proc(x: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if cfg!(target_arch = "aarch64") {
    // rust: aarch64::cos(x)
    // rust: } else if cfg!(windows) {
    // rust: exact::cos(x)
    // rust: } else {
    // rust: x.cos()
}
}

// `Math.tan`.
tan :: proc(x: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if cfg!(target_arch = "aarch64") {
    // rust: libm::tan(x)
    // rust: } else {
    // rust: x.tan()
}
}

// `Math.exp`.
exp :: proc(x: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if cfg!(target_arch = "aarch64") {
    // rust: libm::exp(x)
    // rust: } else {
    // rust: x.exp()
}
}

// `Math.log`.
log :: proc(x: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if cfg!(target_arch = "aarch64") {
    // rust: fdlibm::log(x)
    // rust: } else {
    // rust: x.ln()
}
}

// `Math.log10`.
log10 :: proc(x: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if cfg!(target_arch = "aarch64") {
    // rust: fdlibm::log10(x)
    // rust: } else {
    // rust: x.log10()
}
}

// `Math.pow`.
pow :: proc(x: f64, y: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if cfg!(target_arch = "aarch64") {
    // rust: libm::pow(x, y)
    // rust: } else {
    // rust: x.powf(y)
}
}

// `Math.cbrt`.
cbrt :: proc(x: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if cfg!(target_arch = "aarch64") {
    // rust: fdlibm::cbrt(x)
    // rust: } else {
    // rust: x.cbrt()
}
}

// `Math.atan2`.
atan2 :: proc(y: f64, x: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: crate::geometry::trig::fdlibm_atan2(y, x)
}

// `Math.atan`.
atan :: proc(x: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: libm::atan(x)
}

// `Math.asin`.
asin :: proc(x: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: libm::asin(x)
}

// `Math.acos`.
acos :: proc(x: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: libm::acos(x)
}

// `Math.hypot`.
hypot :: proc(x: f64, y: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: fdlibm::hypot(x, y)
}

// `Math.round(double)`: the nearest `long`, ties toward positive infinity
// (so `-2.5` is `-2`), saturating, `NaN` is 0.
round :: proc(x: f64) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let f = x.floor();
    // rust: (if x - f >= 0.5 { f + 1.0 } else { f }) as i64
}

hi :: proc(x: f64) -> i {
    // Ported from Horizon
    return {}
}
    // rust: (x.to_bits() >> 32) as i32
}

with_hi :: proc(x: f64, high: i32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: f64::from_bits((x.to_bits() & 0xffff_ffff) | (u64::from(high as u32) << 32))
}

// `java.lang.FdLibm` ports (`StrictMath`) of what the `libm` crate computes
// differently.
// fdlibm's constants and NaN, verbatim.
    // rust: pub mod fdlibm {
//     use super::{hi, with_hi};

TWO54 :: 1.80143985094819840000e+16

    // `FdLibm.Log`.
log :: proc(mut x: f64) -> f {
    // Ported from Horizon
    return {}
}
LN2_HI :: 6.93147180369123816490e-01
LN2_LO :: 1.90821492927058770002e-10
LG1 :: 6.666666666666735130e-01
LG2 :: 3.999999999940941908e-01
LG3 :: 2.857142874366239149e-01
LG4 :: 2.222219843214978396e-01
LG5 :: 1.818357216161805012e-01
LG6 :: 1.531383769920937332e-01
LG7 :: 1.479819860511658591e-01
    // rust: let mut hx = hi(x);
    // rust: let lx = x.to_bits() as u32;
    // rust: let mut k = 0;
    // rust: if hx < 0x0010_0000 {
    // rust: if ((hx & 0x7fff_ffff) as u32 | lx) == 0 {
    // rust: return -TWO54 / 0.0;
}
    // rust: if hx < 0 {
    // rust: return (x - x) / 0.0;
}
    // rust: k -= 54;
    // rust: x *= TWO54;
    // rust: hx = hi(x);
}
    // rust: if hx >= 0x7ff0_0000 {
    // rust: return x + x;
}
    // rust: k += (hx >> 20) - 1023;
    // rust: hx &= 0x000f_ffff;
    // rust: let i = (hx + 0x9_5f64) & 0x10_0000;
    // rust: x = with_hi(x, hx | (i ^ 0x3ff0_0000));
    // rust: k += i >> 20;
    // rust: let f = x - 1.0;
    // rust: if (0x000f_ffff & (2 + hx)) < 3 {
    // rust: if f == 0.0 {
    // rust: if k == 0 {
    // rust: return 0.0;
}
    // rust: let dk = f64::from(k);
    // rust: return dk * LN2_HI + dk * LN2_LO;
}
    // rust: let r = f * f * (0.5 - 0.33333333333333333 * f);
    // rust: if k == 0 {
    // rust: return f - r;
}
    // rust: let dk = f64::from(k);
    // rust: return dk * LN2_HI - ((r - dk * LN2_LO) - f);
}
    // rust: let s = f / (2.0 + f);
    // rust: let dk = f64::from(k);
    // rust: let z = s * s;
    // rust: let mut i = hx - 0x6_147a;
    // rust: let w = z * z;
    // rust: let j = 0x6b851 - hx;
    // rust: let t1 = w * (LG2 + w * (LG4 + w * LG6));
    // rust: let t2 = z * (LG1 + w * (LG3 + w * (LG5 + w * LG7)));
    // rust: i |= j;
    // rust: let r = t2 + t1;
    // rust: if i > 0 {
    // rust: let hfsq = 0.5 * f * f;
    // rust: if k == 0 {
    // rust: f - (hfsq - s * (hfsq + r))
    // rust: } else {
    // rust: dk * LN2_HI - ((hfsq - (s * (hfsq + r) + dk * LN2_LO)) - f)
}
    // rust: } else if k == 0 {
    // rust: f - s * (f - r)
    // rust: } else {
    // rust: dk * LN2_HI - ((s * (f - r) - dk * LN2_LO) - f)
}
}

    // `FdLibm.Log10`.
log10 :: proc(mut x: f64) -> f {
    // Ported from Horizon
    return {}
}
IVLN10 :: 4.34294481903251816668e-01
LOG10_2HI :: 3.01029995663611771306e-01
LOG10_2LO :: 3.69423907715893078616e-13
    // rust: let mut hx = hi(x);
    // rust: let lx = x.to_bits() as u32;
    // rust: let mut k = 0;
    // rust: if hx < 0x0010_0000 {
    // rust: if ((hx & 0x7fff_ffff) as u32 | lx) == 0 {
    // rust: return -TWO54 / 0.0;
}
    // rust: if hx < 0 {
    // rust: return (x - x) / 0.0;
}
    // rust: k -= 54;
    // rust: x *= TWO54;
    // rust: hx = hi(x);
}
    // rust: if hx >= 0x7ff0_0000 {
    // rust: return x + x;
}
    // rust: k += (hx >> 20) - 1023;
    // rust: let i = ((k as u32) >> 31) as i32;
    // rust: hx = (hx & 0x000f_ffff) | ((0x3ff - i) << 20);
    // rust: let y = f64::from(k + i);
    // rust: x = with_hi(x, hx);
    // rust: let z = y * LOG10_2LO + IVLN10 * log(x);
    // rust: z + y * LOG10_2HI
}

    // `FdLibm.Cbrt`.
cbrt :: proc(mut x: f64) -> f {
    // Ported from Horizon
    return {}
}
B1 :: 715094163
B2 :: 696219795
C :: 5.42857142857142815906e-01
D :: -7.05306122448979611050e-01
E :: 1.41428571428571436819e+00
F :: 1.60714285714285720630e+00
G :: 3.57142857142857150787e-01
    // rust: if x == 0.0 || !x.is_finite() {
    // rust: return x;
}
    // rust: let sign = if x < 0.0 { -1.0 } else { 1.0 };
    // rust: x = x.abs();
    // rust: let mut t = 0.0f64;
    // rust: if x < f64::MIN_POSITIVE {
    // rust: t = 18014398509481984.0; // 2^54
    // rust: t *= x;
    // rust: t = with_hi(t, hi(t) / 3 + B2);
    // rust: } else {
    // rust: t = with_hi(t, hi(x) / 3 + B1);
}
    // rust: let mut r = t * t / x;
    // rust: let mut s = C + r * t;
    // rust: t *= G + F / (s + E + D / s);
    // rust: t = f64::from_bits(t.to_bits() & 0xffff_ffff_0000_0000);
    // rust: t = with_hi(t, hi(t) + 1);
    // rust: s = t * t;
    // rust: r = x / s;
    // rust: let w = t + t;
    // rust: r = (r - t) / (w + r);
    // rust: t += t * r;
    // rust: sign * t
}

    // `FdLibm.Hypot`.
hypot :: proc(x: f64, y: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let mut a = x.abs();
    // rust: let mut b = y.abs();
    // rust: if !a.is_finite() || !b.is_finite() {
    // rust: if a == f64::INFINITY || b == f64::INFINITY {
    // rust: return f64::INFINITY;
}
    // rust: return a + b;
}
    // rust: if b > a {
    // rust: std::mem::swap(&mut a, &mut b);
}
    // rust: let mut ha = hi(a);
    // rust: let mut hb = hi(b);
    // rust: if ha - hb > 0x3c0_0000 {
    // rust: return a + b;
}
    // rust: let mut k = 0;
    // rust: if a > f64::from_bits(0x5f30_0000_ffff_ffff) {
    // rust: ha -= 0x2580_0000;
    // rust: hb -= 0x2580_0000;
    // rust: a *= f64::from_bits(0x1a70_0000_0000_0000); // 2^-600
    // rust: b *= f64::from_bits(0x1a70_0000_0000_0000);
    // rust: k += 600;
}
    // rust: if b < f64::from_bits(0x20b0_0000_0000_0000) {
            // 2^-500
    // rust: if b < f64::MIN_POSITIVE {
    // rust: if b == 0.0 {
    // rust: return a;
}
    // rust: let t1 = f64::from_bits(0x7fd0_0000_0000_0000); // 2^1022
    // rust: b *= t1;
    // rust: a *= t1;
    // rust: k -= 1022;
    // rust: } else {
    // rust: ha += 0x2580_0000;
    // rust: hb += 0x2580_0000;
    // rust: a *= f64::from_bits(0x6570_0000_0000_0000); // 2^600
    // rust: b *= f64::from_bits(0x6570_0000_0000_0000);
    // rust: k -= 600;
}
}
    // rust: let mut w = a - b;
    // rust: if w > b {
    // rust: let t1 = with_hi(0.0, ha);
    // rust: let t2 = a - t1;
    // rust: w = (t1 * t1 - (b * (-b) - t2 * (a + t1))).sqrt();
    // rust: } else {
    // rust: a += a;
    // rust: let y1 = with_hi(0.0, hb);
    // rust: let y2 = b - y1;
    // rust: let t1 = with_hi(0.0, ha + 0x0010_0000);
    // rust: let t2 = a - t1;
    // rust: w = (t1 * y1 - (w * (-w) - (t1 * y2 + t2 * b))).sqrt();
}
    // rust: if k != 0 {
    // rust: f64::from_bits(((1023 + k) as u64) << 52) * w
    // rust: } else {
    // rust: w
}
}
}

// HotSpot's AArch64 `Math.sin` / `Math.cos` stubs
// (`MacroAssembler::generate_dsin_dcos`): fdlibm with fused multiply-adds.
// Exposed on every architecture so they can be tested anywhere.
// HotSpot's tables, verbatim.
    // rust: clippy::excessive_precision,
    // rust: clippy::approx_constant,
    // rust: clippy::unreadable_literal
    // rust: )]
    // rust: pub mod aarch64 {
//     use super::hi;

    // rust: const S: [f64; 6] = [
    // rust: -1.66666666666666324348e-01,
    // rust: 8.33333333332248946124e-03,
    // rust: -1.98412698298579493134e-04,
    // rust: 2.75573137070700676789e-06,
    // rust: -2.50507602534068634195e-08,
    // rust: 1.58969099521155010221e-10,
    // rust: ];
    // rust: const C: [f64; 6] = [
    // rust: 4.16666666666666019037e-02,
    // rust: -1.38888888888741095749e-03,
    // rust: 2.48015872894767294178e-05,
    // rust: -2.75573143513906633035e-07,
    // rust: 2.08757232129817482790e-09,
    // rust: -1.13596475577881948265e-11,
    // rust: ];
INVPIO2 :: 6.36619772367581382433e-01
PIO2_1 :: 1.57079632673412561417e+00
PIO2_1T :: 6.07710050650619224932e-11
PIO2_2 :: 6.07710050630396597660e-11
PIO2_2T :: 2.02226624879595063154e-21
PIO2_3 :: 2.02226624871116645580e-21
PIO2_3T :: 8.47842766036889956997e-32
    // rust: const NPIO2_HW: [i32; 32] = [
    // rust: 0x3FF921FB, 0x400921FB, 0x4012D97C, 0x401921FB, 0x401F6A7A, 0x4022D97C, 0x4025FDBB,
    // rust: 0x402921FB, 0x402C463A, 0x402F6A7A, 0x4031475C, 0x4032D97C, 0x40346B9C, 0x4035FDBB,
    // rust: 0x40378FDB, 0x403921FB, 0x403AB41B, 0x403C463A, 0x403DD85A, 0x403F6A7A, 0x40407E4C,
    // rust: 0x4041475C, 0x4042106C, 0x4042D97C, 0x4043A28C, 0x40446B9C, 0x404534AC, 0x4045FDBB,
    // rust: 0x4046C6CB, 0x40478FDB, 0x404858EB, 0x404921FB,
    // rust: ];

    // `generate_kernel_sin`.
kernel_sin :: proc(x: f64, y: f64, iy: bool) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let z = x * x;
    // rust: let v = z * x;
    // rust: let mut r = z.mul_add(S[5], S[4]);
    // rust: r = z.mul_add(r, S[3]);
    // rust: r = z.mul_add(r, S[2]);
    // rust: r = z.mul_add(r, S[1]);
    // rust: if !iy {
    // rust: v.mul_add(z.mul_add(r, S[0]), x)
    // rust: } else {
    // rust: let t = (-v).mul_add(r, 0.5 * y);
    // rust: let t = (-z).mul_add(t, y);
    // rust: x + v.mul_add(S[0], t)
}
}

    // `generate_kernel_cos`. `ix` is the high word of the *original*
    // argument: the stub reuses the register, so a reduced argument always
    // takes the `qx = 0.28125` branch.
kernel_cos :: proc(x: f64, y: f64, ix: i32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let z = x * x;
    // rust: let mut r = z.mul_add(C[5], C[4]);
    // rust: r = z.mul_add(r, C[3]);
    // rust: let xy = x * y;
    // rust: r = z.mul_add(r, C[2]);
    // rust: r = z.mul_add(r, C[1]);
    // rust: let zz = z * z;
    // rust: r = z.mul_add(r, C[0]);
    // rust: if ix <= 0x3FD33333 {
    // rust: let v = (-zz).mul_add(r, xy);
    // rust: 1.0 - 0.5f64.mul_add(z, v)
    // rust: } else {
    // rust: let qx = if ix > 0x3fe90000 {
    // rust: 0.28125
    // rust: } else {
    // rust: f64::from_bits(u64::from((ix - 0x0020_0000) as u32) << 32)
}
    // rust: let zr_xy = zz.mul_add(r, -xy);
    // rust: let h = 0.5f64.mul_add(z, -qx);
    // rust: let a = 1.0 - qx;
    // rust: a - (h - zr_xy)
}
}

    // `generate__ieee754_rem_pio2` for |x| <= 2^19·π/2; `None` beyond.
rem_pio2 :: proc(x: f64, ix: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if ix < 0x4002d97c {
    // rust: return Some(if x.to_bits() as i64 >= 0 {
    // rust: let z = x - PIO2_1;
    // rust: if ix != 0x3ff921fb {
    // rust: let y0 = z - PIO2_1T;
    // rust: (1, y0, (z - y0) - PIO2_1T)
    // rust: } else {
    // rust: let z = z - PIO2_2;
    // rust: let y0 = z - PIO2_2T;
    // rust: (1, y0, (z - y0) - PIO2_2T)
}
    // rust: } else {
    // rust: let z = x + PIO2_1;
    // rust: if ix != 0x3ff921fb {
    // rust: let y0 = z + PIO2_1T;
    // rust: (-1, y0, (z - y0) + PIO2_1T)
    // rust: } else {
    // rust: let z = z + PIO2_2;
    // rust: let y0 = z + PIO2_2T;
    // rust: (-1, y0, (z - y0) + PIO2_2T)
}
    // rust: });
}
    // rust: if ix > 0x413921fb {
    // rust: return None;
}
    // rust: let t = x.abs();
    // rust: let fnv = t.mul_add(INVPIO2, 0.5).trunc();
    // rust: let n = fnv as i32;
    // rust: let mut r = (-fnv).mul_add(PIO2_1, t);
    // rust: let mut w = fnv * PIO2_1T;
    // rust: let mut y0 = r - w;
    // rust: if n > 32 || ix == NPIO2_HW[(n - 1) as usize] {
    // rust: let j = ix >> 20;
    // rust: let exponent = |y: f64| ((y.to_bits() << 1) >> 53) as i32;
    // rust: if j - exponent(y0) > 16 {
    // rust: let t = r;
    // rust: let w2 = fnv * PIO2_2;
    // rust: r = t - w2;
    // rust: w = fnv.mul_add(PIO2_2T, w2 - (t - r));
    // rust: y0 = r - w;
    // rust: if j - exponent(y0) > 49 {
    // rust: let t = r;
    // rust: let w3 = fnv * PIO2_3;
    // rust: r = t - w3;
    // rust: w = fnv.mul_add(PIO2_3T, w3 - (t - r));
    // rust: y0 = r - w;
}
}
}
    // rust: let y1 = (r - y0) - w;
    // rust: Some(if x > 0.0 { (n, y0, y1) } else { (-n, -y0, -y1) })
}

sin_cos :: proc(x: f64, is_cos: bool) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let ix = hi(x) & 0x7fff_ffff;
    // rust: if ix < 0x3e400000 {
    // rust: return if is_cos { 1.0 } else { x };
}
    // rust: if ix <= 0x3fe921fb {
    // rust: return if is_cos {
    // rust: kernel_cos(x, 0.0, ix)
    // rust: } else {
    // rust: kernel_sin(x, 0.0, false)
}
}
    // rust: if ix >= 0x7ff00000 {
    // rust: return f64::from_bits(0x7ff0_0000_0000_0001);
}
        // Beyond 2^19·π/2 the stub's Payne–Hanek reduction isn't ported:
        // StrictMath's is used instead.
    // rust: let Some((n, y0, y1)) = rem_pio2(x, ix) else {
    // rust: return if is_cos { libm::cos(x) } else { libm::sin(x) };
}
    // rust: let (value, negate) = if (n & 1 == 1) != is_cos {
    // rust: (
    // rust: kernel_cos(y0, y1, ix),
    // rust: if is_cos { (n ^ (n >> 1)) & 1 } else { n & 2 },
    // rust: )
    // rust: } else {
    // rust: (
    // rust: kernel_sin(y0, y1, true),
    // rust: if is_cos { (n ^ (n >> 1)) & 1 } else { n & 2 },
    // rust: )
}
    // rust: if negate != 0 { -value } else { value }
}

    // `Math.sin` on AArch64 HotSpot.
sin :: proc(x: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: sin_cos(x, false)
}

    // `Math.cos` on AArch64 HotSpot.
cos :: proc(x: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: sin_cos(x, true)
}
}

// `sin` and `cos` correctly rounded, for Windows, whose libm rounds them
// unlike Java's x86-64 intrinsics. Double-double arithmetic (two `f64`s per
// value): `x` reduced by a four-part pi/2, a short series checked against an
// error bound, and where the bound leaves the rounding open, the full series
// with its terms summed exactly. Checked against 400-bit results on 1.3 million
// arguments, small ones and ones next to multiples of pi/2 among them; not a
// proof.
    // rust: pub mod exact {
    // A value `hi + lo` with |lo| <= ulp(hi) / 2.
Dd :: struct {

    // `a + b` exactly, as a sum and its rounding error (Knuth).
two_sum :: proc(a: f64, b: f64) -> D {
    // Ported from Horizon
    return {}
}
    // rust: let s = a + b;
    // rust: let v = s - a;
    // rust: Dd(s, (a - (s - v)) + (b - v))
}

    // `a + b` exactly when |a| >= |b| (Dekker).
fast_two_sum :: proc(a: f64, b: f64) -> D {
    // Ported from Horizon
    return {}
}
    // rust: let s = a + b;
    // rust: Dd(s, b - (s - a))
}

    // `a * b` exactly, as a product and its rounding error (Dekker's split, no fused multiply-add).
two_prod :: proc(a: f64, b: f64) -> D {
    // Ported from Horizon
    return {}
}
split :: proc(a: f64) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let t = 134_217_729.0 * a; // 2^27 + 1
    // rust: let hi = t - (t - a);
    // rust: (hi, a - hi)
}
    // rust: let p = a * b;
    // rust: let (ah, al) = split(a);
    // rust: let (bh, bl) = split(b);
    // rust: Dd(p, ((ah * bh - p) + ah * bl + al * bh) + al * bl)
}

    // rust: impl Dd {
add :: proc(self: ^Self, b: Dd) -> D {
    // Ported from Horizon
    return {}
}
    // rust: let s = two_sum(self.0, b.0);
    // rust: let t = two_sum(self.1, b.1);
    // rust: let s = fast_two_sum(s.0, s.1 + t.0);
    // rust: fast_two_sum(s.0, s.1 + t.1)
}
mul :: proc(self: ^Self, b: Dd) -> D {
    // Ported from Horizon
    return {}
}
    // rust: let p = two_prod(self.0, b.0);
    // rust: fast_two_sum(p.0, p.1 + (self.0 * b.1 + self.1 * b.0))
}
        // Divided by a small whole number (exact in an `f64`).
div :: proc(self: ^Self, d: f64) -> D {
    // Ported from Horizon
    return {}
}
    // rust: let q = self.0 / d;
    // rust: let p = two_prod(q, d);
    // rust: let r = ((self.0 - p.0) - p.1 + self.1) / d;
    // rust: fast_two_sum(q, r)
}
neg :: proc(self: ^Self) -> D {
    // Ported from Horizon
    return {}
}
    // rust: Dd(-self.0, -self.1)
}
}

    // pi/2 = P1 + P2 + P3 + P4 to 2^-160: the first three have 33 significant bits, so `k * Pn` is
    // exact for |k| < 2^20.
P1 :: f64::from_bits(0x3FF9_21FB_5440_0000)
P2 :: f64::from_bits(0x3DD0_B461_1A60_0000)
P3 :: f64::from_bits(0x3BA3_198A_2E00_0000)
P4 :: f64::from_bits(0x397B_839A_2520_49C1)

    // `x - k * pi/2` and the quadrant `k mod 4`, for |x| <= 2^20.
reduce :: proc(x: f64) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let k = (x * std::f64::consts::FRAC_2_PI).round();
    // rust: let r = Dd(x - k * P1, 0.0)
    // rust: .add(Dd(-(k * P2), 0.0))
    // rust: .add(Dd(-(k * P3), 0.0))
    // rust: .add(two_prod(k, P4).neg());
    // rust: (r, (k as i64 & 3) as u32)
}

    // `sum(xs)` rounded once, exactly (Shewchuk's partials, with the half-way fix-up of a final
    // rounding that a running sum can't see).
exact_sum :: proc(xs: ^[f64]) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let mut partials = [0.0f64; 64];
    // rust: let mut len = 0;
    // rust: for &x0 in xs {
    // rust: let mut x = x0;
    // rust: let mut i = 0;
    // rust: for j in 0..len {
    // rust: let mut y = partials[j];
    // rust: if x.abs() < y.abs() {
    // rust: std::mem::swap(&mut x, &mut y);
}
    // rust: let hi = x + y;
    // rust: let lo = y - (hi - x);
    // rust: if lo != 0.0 {
    // rust: partials[i] = lo;
    // rust: i += 1;
}
    // rust: x = hi;
}
    // rust: partials[i] = x;
    // rust: len = i + 1;
}
    // rust: if len == 0 {
    // rust: return 0.0;
}
    // rust: let mut n = len - 1;
    // rust: let mut hi = partials[n];
    // rust: let mut lo = 0.0;
    // rust: while n > 0 {
    // rust: let x = hi;
    // rust: n -= 1;
    // rust: let y = partials[n];
    // rust: hi = x + y;
    // rust: lo = y - (hi - x);
    // rust: if lo != 0.0 {
    // rust: break;
}
}
    // rust: if n > 0 && ((lo < 0.0 && partials[n - 1] < 0.0) || (lo > 0.0 && partials[n - 1] > 0.0)) {
    // rust: let y = lo * 2.0;
    // rust: let x = hi + y;
    // rust: if y == x - hi {
    // rust: hi = x;
}
}
    // rust: hi
}

    // sin(r) or cos(r) for |r| <= pi/4 + a little: the Taylor series to below 2^-110, each term
    // kept as a double-double and the terms summed exactly. The leading terms are exact for a small
    // `x` (r = x), where cos x and sin x come closest to half-way between two doubles.
series :: proc(r: Dd, cos: bool) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let r2 = r.mul(r);
    // rust: let mut parts = [0.0f64; 32];
    // rust: let mut len = 0;
    // rust: let (mut term, first) = if cos { (Dd(1.0, 0.0), 1.0) } else { (r, 2.0) };
    // rust: parts[0] = term.0;
    // rust: parts[1] = term.1;
    // rust: len += 2;
    // rust: for n in 1..=14 {
    // rust: let k = 2.0 * f64::from(n) + first - 1.0;
    // rust: term = term.mul(r2).div(k * (k - 1.0)).neg();
    // rust: parts[len] = term.0;
    // rust: parts[len + 1] = term.1;
    // rust: len += 2;
}
    // rust: exact_sum(&parts[..len])
}

    // Taylor coefficients 1/n! with alternating sign, for the f64 tails: sin from r^7, cos from r^8.
    // rust: const SIN_TAIL: [f64; 9] = [
    // rust: -1.0 / 5040.0,
    // rust: 1.0 / 362880.0,
    // rust: -1.0 / 39916800.0,
    // rust: 1.0 / 6227020800.0,
    // rust: -1.0 / 1307674368000.0,
    // rust: 1.0 / 355687428096000.0,
    // rust: -1.0 / 121645100408832000.0,
    // rust: 1.0 / 51090942171709440000.0,
    // rust: -1.0 / 25852016738884976640000.0,
    // rust: ];
    // rust: const COS_TAIL: [f64; 8] = [
    // rust: 1.0 / 40320.0,
    // rust: -1.0 / 3628800.0,
    // rust: 1.0 / 479001600.0,
    // rust: -1.0 / 87178291200.0,
    // rust: 1.0 / 20922789888000.0,
    // rust: -1.0 / 6402373705728000.0,
    // rust: 1.0 / 2432902008176640000.0,
    // rust: -1.0 / 1124000727777607680000.0,
    // rust: ];

horner :: proc(c: ^[f64], x: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: c.iter().rev().fold(0.0, |acc, &k| acc * x + k)
}

    // sin(r) or cos(r) to about 2^-64: the first terms in double-double, the small rest in f64.
fast :: proc(r: Dd, cos: bool) -> D {
    // Ported from Horizon
    return {}
}
    // rust: let r2 = r.mul(r);
    // rust: let x2 = r2.0;
    // rust: if cos {
    // rust: let t2 = r2.div(2.0).neg();
    // rust: let t4 = r2.mul(r2).div(24.0);
    // rust: let t6 = t4.mul(r2).div(30.0).neg();
    // rust: let tail = x2 * x2 * x2 * x2 * horner(&COS_TAIL, x2);
    // rust: Dd(1.0, 0.0).add(t2).add(t4).add(t6).add(Dd(tail, 0.0))
    // rust: } else {
    // rust: let t3 = r2.mul(r).div(6.0).neg();
    // rust: let t5 = t3.mul(r2).div(20.0).neg();
    // rust: let tail = r.0 * x2 * x2 * x2 * horner(&SIN_TAIL, x2);
    // rust: r.add(t3).add(t5).add(Dd(tail, 0.0))
}
}

    // Rounds `v` when its error bound can't change the rounding, else `None`.
rounded :: proc(v: Dd) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let e = v.0.abs() * f64::from_bits(0x3C30_0000_0000_0000); // 2^-60
    // rust: let (a, b) = (v.0 + (v.1 - e), v.0 + (v.1 + e));
    // rust: (a == b).then_some(a)
}

    // sin (`cos == false`) or cos of a reduced angle in quadrant `q`.
eval :: proc(r: Dd, q: u32, cos: bool) -> f {
    // Ported from Horizon
    return {}
}
        // sin(x) = sin r, cos r, -sin r, -cos r in quadrants 0..3; cos(x) is a quadrant later.
    // rust: let q = (q + u32::from(cos)) & 3;
    // rust: let want_cos = q & 1 == 1;
    // rust: let v = rounded(fast(r, want_cos)).unwrap_or_else(|| series(r, want_cos));
    // rust: if q >= 2 { -v } else { v }
}

    // `sin(x)` rounded to nearest; beyond |x| = 2^20 the platform's.
sin :: proc(x: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if x.abs() < f64::from_bits(0x3E40_0000_0000_0000) {
            // |x| < 2^-27: sin x rounds to x (0 included).
    // rust: return x;
}
    // rust: if x.is_nan() || x.abs() > 1_048_576.0 {
    // rust: return x.sin();
}
    // rust: let (r, q) = reduce(x);
    // rust: eval(r, q, false)
}

    // `cos(x)` rounded to nearest; beyond |x| = 2^20 the platform's.
cos :: proc(x: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if x.abs() < f64::from_bits(0x3E40_0000_0000_0000) {
            // |x| < 2^-27: cos x rounds to 1.
    // rust: return 1.0;
}
    // rust: if x.is_nan() || x.abs() > 1_048_576.0 {
    // rust: return x.cos();
}
    // rust: let (r, q) = reduce(x);
    // rust: eval(r, q, true)
}
}

    // rust: mod tests {
//     use super::{aarch64, exact, fdlibm, round_f32};

round_f32_is_exact_like_java :: proc() {
}
    // rust: for (x, expected) in [
    // rust: (0.499_999_97, 0),
    // rust: (0.5, 1),
    // rust: (-0.5, 0),
    // rust: (2.5, 3),
    // rust: (-2.5, -2),
    // rust: (1e10, i32::MAX),
    // rust: (-1e10, i32::MIN),
    // rust: (f32::NAN, 0),
    // rust: (8_388_609.0, 8_388_609),
    // rust: ] {
    // rust: assert_eq!(round_f32(x), expected, "{x}");
}
}

round_ties_toward_positive_infinity :: proc() {
}
    // rust: for (x, want) in [
    // rust: (-2.5, -2),
    // rust: (2.5, 3),
    // rust: (-0.5, 0),
    // rust: (-1.5, -1),
    // rust: (0.5, 1),
    // rust: (-2.6, -3),
    // rust: (0.49999999999999994, 0),
    // rust: (f64::NAN, 0),
    // rust: (f64::INFINITY, i64::MAX),
    // rust: (f64::NEG_INFINITY, i64::MIN),
    // rust: ] {
    // rust: assert_eq!(super::round(x), want, "round({x})");
}
}

    // Java 24's `Math.sin` and `Math.cos` on x86-64 HotSpot, for arguments
    // where Windows' libm rounds the other way.
exact_sin_and_cos_round_like_javas_x86_intrinsics :: proc() {
}
    // rust: for case in [
    // rust: (0x400cfed4c52a225f, 0xbfddb6fb8dfc34d9),
    // rust: (0x401562e96dc95e79, 0xbfe9c702a472eb20),
    // rust: (0x3fe83defdda344b2, 0x3fe5fd24ae6866f7),
    // rust: (0x4015f2973d92bdce, 0xbfe6df4f6eb17f8b),
    // rust: (0x400ccab8c6bca404, 0xbfdc43578964fcd9),
    // rust: (0x4081275db9d375bb, 0x3fe835467b8bb2a8),
    // rust: (0x408545bc77918c1a, 0x3feb130e731423b6),
    // rust: (0xc08a86d7f86386d0, 0xbfe2bc064eff6f2b),
    // rust: ] {
    // rust: check1(exact::sin, case);
}
    // rust: for case in [
    // rust: (0x3fff44a3b3c18058, 0xbfd7f1ca30696aa9),
    // rust: (0x401824074317a30f, 0x3fef055d8c6cc46e),
    // rust: (0x4001b86d21e7b163, 0xbfe33824a109fcc3),
    // rust: (0xc08b37219efa0d36, 0xbfe913c9a4e569fe),
    // rust: (0xc084ce175c9dc180, 0x3feef489ec429ba7),
    // rust: (0x400ed26ab1d4ada5, 0xbfe83e5b263a94b1),
    // rust: (0x40156db4b780dcab, 0x3fe33b5a52983c7c),
    // rust: (0x408e8b5accbb6a88, 0xbfedab57ae231703),
            // About 3e-28 below a half-way point: a double-double running sum loses that.
    // rust: (0x3e937b1311fb4936, 0x3feffffffffffe85),
    // rust: ] {
    // rust: check1(exact::cos, case);
}
        // Small arguments, the quadrant edges and beyond the reduced range.
    // rust: assert_eq!(exact::sin(1e-300), 1e-300);
    // rust: assert_eq!(exact::cos(-1e-10), 1.0);
    // rust: assert_eq!(exact::sin(0.0).to_bits(), 0);
    // rust: assert_eq!(exact::sin(-0.0).to_bits(), (-0.0f64).to_bits());
    // rust: assert!(exact::sin(f64::NAN).is_nan() && exact::cos(f64::INFINITY).is_nan());
    // rust: assert_eq!(exact::sin(std::f64::consts::FRAC_PI_2), 1.0);
    // rust: assert_eq!(exact::cos(std::f64::consts::PI), -1.0);
    // rust: assert_eq!(exact::sin(3.0e6), 3.0e6f64.sin());
}

check1 :: proc(f: fn(f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: assert_eq!(f(f64::from_bits(x)).to_bits(), expected, "{x:x}");
}

check2 :: proc(f: fn(f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: assert_eq!(
    // rust: f(f64::from_bits(x), f64::from_bits(y)).to_bits(),
    // rust: expected,
    // rust: "{x:x} {y:x}"
    // rust: );
}

matches_hotspot_on_aarch64 :: proc() {
}
        // (argument bits, Math result bits) from HotSpot 25 on an Apple M4, each
        // one where glibc rounds differently.
        // sin
    // rust: check1(aarch64::sin, (0x3fe63c5ab66b09f0, 0x3fe47d34215b54f7));
    // rust: check1(aarch64::sin, (0xc0569150fe105e6f, 0xbfe7bc19d65ab55c));
    // rust: check1(aarch64::sin, (0x4072c3f15b47b5d6, 0xbfef32be0f0a9124));
    // rust: check1(aarch64::sin, (0x3fee86c6ffce047e, 0x3fea1a47f46cbf28));
        // cos
    // rust: check1(aarch64::cos, (0x3fbb10690eeadb00, 0x3fefd24375dbae28));
    // rust: check1(aarch64::cos, (0xc0496cc08a65245d, 0x3feab1a44a8022c4));
    // rust: check1(aarch64::cos, (0x40099262f89e73f8, 0xbfeff3aa148795ce));
    // rust: check1(aarch64::cos, (0x4001ce4e022387bc, 0xbfe37dd512be4d00));
        // log
    // rust: check1(fdlibm::log, (0x40569150fe105e6f, 0x401202e102f27b78));
    // rust: check1(fdlibm::log, (0x3ff5dec70f518390, 0x3fd4009cda1f8856));
    // rust: check1(fdlibm::log, (0x3feb3d17325d493e, 0xbfc49ee8c4866f84));
    // rust: check1(fdlibm::log, (0x3fe735a40edf77ba, 0xbfd48e1816b18bf2));
        // log10
    // rust: check1(fdlibm::log10, (0x3ff5dec70f518390, 0x3fc15fb52aa5f051));
    // rust: check1(fdlibm::log10, (0x3feb3d17325d493e, 0xbfb1e933cae02f5f));
    // rust: check1(fdlibm::log10, (0x3fe735a40edf77ba, 0xbfc1da98cbb8974c));
    // rust: check1(fdlibm::log10, (0x3fe7febd9ca1bab0, 0xbfc000e8e3b0b56e));
        // cbrt
    // rust: check1(fdlibm::cbrt, (0x401bb21f8568bd0c, 0x3ffe7ee30c7a56f9));
    // rust: check1(fdlibm::cbrt, (0x3fc59f3a45c8fb80, 0x3fe1b0791e0f8a74));
    // rust: check1(fdlibm::cbrt, (0xbfdd73cdc693ddab, 0xbfe8b4a6f43f1b73));
    // rust: check1(fdlibm::cbrt, (0xbfeb0715a8425e10, 0xbfee3f99498da6f6));
        // hypot
    // rust: check2(
    // rust: fdlibm::hypot,
    // rust: (0xc0569150fe105e6f, 0xc0056b970bf3b41a, 0x405693db72f461a6),
    // rust: );
    // rust: check2(
    // rust: fdlibm::hypot,
    // rust: (0x3fdc5999df9270f4, 0xc006c3ad990f72c0, 0x400709de26a1e40a),
    // rust: );
    // rust: check2(
    // rust: fdlibm::hypot,
    // rust: (0x401bb21f8568bd0c, 0xbffeb93d1a2ef904, 0x401cbdbb623d20c3),
    // rust: );
    // rust: check2(
    // rust: fdlibm::hypot,
    // rust: (0x4026d31c32ddb50b, 0xc00e7b2771d6867c, 0x40281027bb313aae),
    // rust: );
        // pow
    // rust: check2(
    // rust: libm::pow,
    // rust: (0x3fee04c313607ea6, 0xc00fd156138baf96, 0x3ff4a199ac2c8e9c),
    // rust: );
    // rust: check2(
    // rust: libm::pow,
    // rust: (0x401bb21f8568bd0c, 0xbffeb93d1a2ef904, 0x3f98ecc16a60feee),
    // rust: );
    // rust: check2(
    // rust: libm::pow,
    // rust: (0x407383ff427dadbd, 0x3ffdc5d178d00264, 0x40e56695c058d704),
    // rust: );
    // rust: check2(
    // rust: libm::pow,
    // rust: (0x3fe0c95b66dd6030, 0xc00c9cfde259a3e6, 0x4024194449e9deca),
    // rust: );
        // exp
    // rust: check1(libm::exp, (0x3fdc5999df9270f4, 0x3ff8eacc53fdbf56));
    // rust: check1(libm::exp, (0x3fcffff502ecbd80, 0x3ff48b5c78bca894));
    // rust: check1(libm::exp, (0x3fc59f3a45c8fb80, 0x3ff2f1c6cb35728c));
    // rust: check1(libm::exp, (0x4056561bf10ba7f6, 0x47fdd21dc9013084));
        // tan
    // rust: check1(libm::tan, (0x40023034f56881f0, 0xbff2e3f762ac9810));
    // rust: check1(libm::tan, (0xbfebf862877c88ec, 0xbff31f61e3e8539e));
    // rust: check1(libm::tan, (0xc00e37e234490564, 0xbfe79ca6eee66726));
    // rust: check1(libm::tan, (0xc075c085c04800b5, 0x3fea18b4a92fcf22));
}

atan2_matches_strictmath :: proc() {
}
        // (y bits, x bits, StrictMath.atan2 bits) from HotSpot 25: x < 0 and
        // |y/x| > 2^60, where libm::atan2 rounds one ulp lower,
    // rust: check2(
    // rust: super::atan2,
    // rust: (0x440e8aff5d1e293c, 0xc007e9768e83b37e, 0x3ff921fb54442d19),
    // rust: );
    // rust: check2(
    // rust: super::atan2,
    // rust: (0x440c610b44a22b37, 0xbfb07327bcb4c280, 0x3ff921fb54442d19),
    // rust: );
    // rust: check2(
    // rust: super::atan2,
    // rust: (0x43eb71600e035874, 0xbfeaff77e5a9ea38, 0x3ff921fb54442d19),
    // rust: );
    // rust: check2(
    // rust: super::atan2,
    // rust: (0x440edb2112965d8f, 0xbffaec4345ac33b1, 0x3ff921fb54442d19),
    // rust: );
    // rust: check2(
    // rust: super::atan2,
    // rust: (0x3ff0000000000000, 0x8000000000000001, 0x3ff921fb54442d19),
    // rust: );
    // rust: check2(
    // rust: super::atan2,
    // rust: (0xbff0000000000000, 0x8000000000000001, 0xbff921fb54442d19),
    // rust: );
    // rust: check2(
    // rust: super::atan2,
    // rust: (0x7fefffffffffffff, 0xbff0000000000000, 0x3ff921fb54442d19),
    // rust: );
    // rust: check2(
    // rust: super::atan2,
    // rust: (0xffefffffffffffff, 0xbff0000000000000, 0xbff921fb54442d19),
    // rust: );
    // rust: check2(
    // rust: super::atan2,
    // rust: (0x38fd955bf292fbac, 0xb4f940da66879af2, 0x3ff921fb54442d19),
    // rust: );
    // rust: check2(
    // rust: super::atan2,
    // rust: (0xf8954a6a9b403072, 0xf49292c2e2d50436, 0xbff921fb54442d19),
    // rust: );
    // rust: check2(
    // rust: super::atan2,
    // rust: (0x07e155d47eb507f2, 0x83d22629ee8e8471, 0x3ff921fb54442d19),
    // rust: );
    // rust: check2(
    // rust: super::atan2,
    // rust: (0xd2471cd599853356, 0xce403e2e72061985, 0xbff921fb54442d19),
    // rust: );
        // and the other quadrants and special cases, which it already matched
    // rust: check2(
    // rust: super::atan2,
    // rust: (0x440e8aff5d1e293c, 0x4007e9768e83b37e, 0x3ff921fb54442d18),
    // rust: );
    // rust: check2(
    // rust: super::atan2,
    // rust: (0xc40e8aff5d1e293c, 0x4007e9768e83b37e, 0xbff921fb54442d18),
    // rust: );
    // rust: check2(
    // rust: super::atan2,
    // rust: (0x0000000000000000, 0xbff0000000000000, 0x400921fb54442d18),
    // rust: );
    // rust: check2(
    // rust: super::atan2,
    // rust: (0x8000000000000000, 0xbff0000000000000, 0xc00921fb54442d18),
    // rust: );
    // rust: check2(
    // rust: super::atan2,
    // rust: (0x3ff0000000000000, 0x3ff0000000000000, 0x3fe921fb54442d18),
    // rust: );
    // rust: check2(
    // rust: super::atan2,
    // rust: (0x3ff0000000000000, 0xc410000000000000, 0x400921fb54442d18),
    // rust: );
    // rust: check2(
    // rust: super::atan2,
    // rust: (0x3e7ad7f29abcaf48, 0xc0f86a0000000000, 0x400921fb5444244c),
    // rust: );
    // rust: check2(
    // rust: super::atan2,
    // rust: (0x7ff0000000000000, 0xfff0000000000000, 0x4002d97c7f3321d2),
    // rust: );
        // NaN payloads may differ, so only NaN-ness is checked.
    // rust: assert!(super::atan2(f64::NAN, 1.0).is_nan());
    // rust: assert!(super::atan2(1.0, f64::NAN).is_nan());
}
}
