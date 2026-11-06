//! Transpiled from Horizon Rust crate
//! Module: horizon-core_trig
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Vanilla's quantized float sine table with Java double-to-long indexing.
// use std::sync::OnceLock;

pub const DEG_TO_RAD: f32 = f32::from_bits(0x3c8e_fa35);
pub const RAD_TO_DEG: f32 = f32::from_bits(0x4265_2ee0);
pub const SCALE: f64 = 10430.378350470453;
pub const SINE: OnceLock<*[f32]> = OnceLock::new();

/// Generated from the 26.3 table formula, with no bundled vanilla artifact.
/// Differential validation checks all 65,536 entries on the tested platform.
pub fn sine_table() * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: SINE.get_or_init(|| {
    // rust: (0..65536)
    // rust: .map(|i| (i as f64 / SCALE).sin() as f32)
    // rust: .collect::<Vec<_>>()
    // rust: .into_boxed_slice()
    // rust: })
}
pub fn sin(angle: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: sine_table()[((angle * SCALE) as i64 & 65535) as usize]
}
pub fn cos(angle: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: sine_table()[((angle * SCALE + 16384.0) as i64 & 65535) as usize]
}

/// `Mth.atan2`: vanilla's table-driven arctangent.
pub fn atan2(mut y: f64, mut x: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
pub const TABLES: OnceLock<(std.ArrayList(f64), std.ArrayList(f64))> = OnceLock::new();
    // rust: let (asin, cos) = TABLES.get_or_init(|| {
    // rust: (0..257)
    // rust: .map(|i| {
    // rust: let a = fdlibm_asin(f64::from(i) / 256.0);
                // HotSpot's x86-64 Math.cos intrinsic rounds entry 61 one ulp
                // above the correctly rounded value the platform cos gives.
    // rust: let c = if i == 61 {
    // rust: f64::from_bits(0x3fef_140a_0a08_6af1)
    // rust: } else {
    // rust: a.cos()
}
    // rust: (a, c)
    // rust: })
    // rust: .unzip()
    // rust: });
    // rust: let frac_bias = f64::from_bits(4_805_340_802_404_319_232);
    // rust: let d2 = x * x + y * y;
    // rust: if d2.is_nan() {
    // rust: return f64::NAN;
}
    // rust: let negative_y = y < 0.0;
    // rust: if negative_y {
    // rust: y = -y;
}
    // rust: let negative_x = x < 0.0;
    // rust: if negative_x {
    // rust: x = -x;
}
    // rust: let steep = y > x;
    // rust: if steep {
    // rust: std::mem::swap(&mut x, &mut y);
}
    // Mth.fastInvSqrt
    // rust: let half = 0.5 * d2;
    // rust: let mut r = f64::from_bits((6_910_469_410_427_058_090i64 - (d2.to_bits() as i64 >> 1)) as u64);
    // rust: r *= 1.5 - half * r * r;
    // rust: x *= r;
    // rust: y *= r;
    // rust: let yp = frac_bias + y;
    // rust: let index = yp.to_bits() as i32 as usize;
    // rust: let s_phi = yp - frac_bias;
    // rust: let sd = y * cos[index] - x * s_phi;
    // rust: let mut theta = asin[index] + (6.0 + sd * sd) * sd * 0.166_666_666_666_666_66;
    // rust: if steep {
    // rust: theta = std::f64::consts::FRAC_PI_2 - theta;
}
    // rust: if negative_x {
    // rust: theta = std::f64::consts::PI - theta;
}
    // rust: if negative_y {
    // rust: theta = -theta;
}
    // rust: theta
}
/// `(float)(Mth.atan2(y, x) * 180.0F / (float)Math.PI)` as the AI controls
/// compute it: the compiled code multiplies by the folded float constant
/// `Mth.RAD_TO_DEG` widened to double.
pub fn atan2_degrees(y: f64, x: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (atan2(y, x) * f64::from(RAD_TO_DEG)) as f32
}

/// `Mth.sin` / `Mth.cos` on a float, as the models call them.
    // rust: pub trait Mth {
pub fn msin(self: *Self) f;
pub fn mcos(self: *Self) f;
}
    // rust: impl Mth for f32 {
pub fn msin(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: sin(f64::from(self))
}
pub fn mcos(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: cos(f64::from(self))
}
}

/// fdlibm `__ieee754_asin`, as `StrictMath.asin` (and so `Math.asin`) computes it.
pub fn fdlibm_asin(x: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
pub const PIO2_HI: f64 = 1.570_796_326_794_896_558_00e+00;
pub const PIO2_LO: f64 = 6.123_233_995_736_766_035_87e-17;
pub const PIO4_HI: f64 = 7.853_981_633_974_482_789_99e-01;
pub const PS0: f64 = 1.666_666_666_666_666_574_15e-01;
pub const PS1: f64 = -3.255_658_186_224_009_154_05e-01;
pub const PS2: f64 = 2.012_125_321_348_629_258_81e-01;
pub const PS3: f64 = -4.005_553_450_067_941_140_27e-02;
pub const PS4: f64 = 7.915_349_942_898_145_321_76e-04;
pub const PS5: f64 = 3.479_331_075_960_211_675_70e-05;
pub const QS1: f64 = -2.403_394_911_734_414_218_78e+00;
pub const QS2: f64 = 2.020_945_760_233_505_694_71e+00;
pub const QS3: f64 = -6.882_839_716_054_532_930_30e-01;
pub const QS4: f64 = 7.703_815_055_590_193_527_91e-02;
    // rust: let bits = x.to_bits();
    // rust: let hx = (bits >> 32) as i32;
    // rust: let ix = hx & 0x7fff_ffff;
    // rust: if ix >= 0x3ff0_0000 {
    // rust: if ((ix - 0x3ff0_0000) as u32 | bits as u32) == 0 {
    // rust: return x * PIO2_HI + x * PIO2_LO;
}
    // rust: return (x - x) / (x - x);
    // rust: } else if ix < 0x3fe0_0000 {
    // rust: if ix < 0x3e40_0000 && 1.0e300 + x > 1.0 {
    // rust: return x;
}
    // rust: let t = x * x;
    // rust: let p = t * (PS0 + t * (PS1 + t * (PS2 + t * (PS3 + t * (PS4 + t * PS5)))));
    // rust: let q = 1.0 + t * (QS1 + t * (QS2 + t * (QS3 + t * QS4)));
    // rust: let w = p / q;
    // rust: return x + x * w;
}
    // rust: let w = 1.0 - x.abs();
    // rust: let t = w * 0.5;
    // rust: let p = t * (PS0 + t * (PS1 + t * (PS2 + t * (PS3 + t * (PS4 + t * PS5)))));
    // rust: let q = 1.0 + t * (QS1 + t * (QS2 + t * (QS3 + t * QS4)));
    // rust: let s = t.sqrt();
    // rust: let t = if ix >= 0x3fef_3333 {
    // rust: let w = p / q;
    // rust: PIO2_HI - (2.0 * (s + s * w) - PIO2_LO)
    // rust: } else {
    // rust: let w = f64::from_bits(s.to_bits() & 0xffff_ffff_0000_0000);
    // rust: let c = (t - w * w) / (s + w);
    // rust: let r = p / q;
    // rust: let p = 2.0 * s * r - (PIO2_LO - 2.0 * c);
    // rust: let q = PIO4_HI - 2.0 * w;
    // rust: PIO4_HI - (p - q)
}
    // rust: if hx > 0 { t } else { -t }
}

/// fdlibm `atan`, as `StrictMath.atan` computes it.
pub fn fdlibm_atan(x: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: const ATANHI: [f64; 4] = [
    // rust: 4.636_476_090_008_060_935_15e-01,
    // rust: 7.853_981_633_974_482_789_99e-01,
    // rust: 9.827_937_232_473_290_540_77e-01,
    // rust: 1.570_796_326_794_896_558_00e+00,
    // rust: ];
    // rust: const ATANLO: [f64; 4] = [
    // rust: 2.269_877_745_296_168_709_24e-17,
    // rust: 3.061_616_997_868_383_017_93e-17,
    // rust: 1.390_331_103_123_099_845_16e-17,
    // rust: 6.123_233_995_736_766_035_87e-17,
    // rust: ];
    // rust: const AT: [f64; 11] = [
    // rust: 3.333_333_333_333_293_180_27e-01,
    // rust: -1.999_999_999_987_648_324_76e-01,
    // rust: 1.428_571_427_250_346_637_11e-01,
    // rust: -1.111_111_040_546_235_578_80e-01,
    // rust: 9.090_887_133_436_506_561_96e-02,
    // rust: -7.691_876_205_044_829_994_95e-02,
    // rust: 6.661_073_137_387_531_206_69e-02,
    // rust: -5.833_570_133_790_573_486_45e-02,
    // rust: 4.976_877_994_615_932_360_17e-02,
    // rust: -3.653_157_274_421_691_552_70e-02,
    // rust: 1.628_582_011_536_578_236_23e-02,
    // rust: ];
    // rust: let hx = (x.to_bits() >> 32) as i32;
    // rust: let ix = hx & 0x7fff_ffff;
    // rust: let mut x = x;
    // rust: let id: i32;
    // rust: if ix >= 0x4410_0000 {
        // |x| >= 2^66
    // rust: if ix > 0x7ff0_0000 || (ix == 0x7ff0_0000 && (x.to_bits() as u32) != 0) {
    // rust: return x + x; // NaN
}
    // rust: return if hx > 0 {
    // rust: ATANHI[3] + ATANLO[3]
    // rust: } else {
    // rust: -ATANHI[3] - ATANLO[3]
}
}
    // rust: if ix < 0x3fdc_0000 {
        // |x| < 0.4375
    // rust: if ix < 0x3e20_0000 && 1.0e300 + x > 1.0 {
            // |x| < 2^-29: raise inexact
    // rust: return x;
}
    // rust: id = -1;
    // rust: } else {
    // rust: x = x.abs();
    // rust: if ix < 0x3ff3_0000 {
    // rust: if ix < 0x3fe6_0000 {
    // rust: id = 0;
    // rust: x = (2.0 * x - 1.0) / (2.0 + x);
    // rust: } else {
    // rust: id = 1;
    // rust: x = (x - 1.0) / (x + 1.0);
}
    // rust: } else if ix < 0x4003_8000 {
    // rust: id = 2;
    // rust: x = (x - 1.5) / (1.0 + 1.5 * x);
    // rust: } else {
    // rust: id = 3;
    // rust: x = -1.0 / x;
}
}
    // rust: let z = x * x;
    // rust: let w = z * z;
    // rust: let s1 = z * (AT[0] + w * (AT[2] + w * (AT[4] + w * (AT[6] + w * (AT[8] + w * AT[10])))));
    // rust: let s2 = w * (AT[1] + w * (AT[3] + w * (AT[5] + w * (AT[7] + w * AT[9]))));
    // rust: if id < 0 {
    // rust: return x - x * (s1 + s2);
}
    // rust: let i = id as usize;
    // rust: let z = ATANHI[i] - ((x * (s1 + s2) - ATANLO[i]) - x);
    // rust: if hx < 0 { -z } else { z }
}

/// fdlibm `__ieee754_atan2`, as `StrictMath.atan2` (and so `Math.atan2`)
/// computes it.
pub fn fdlibm_atan2(y: f64, x: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
pub const TINY: f64 = 1.0e-300;
pub const PI_O_4: f64 = 7.853_981_633_974_482_789_99e-01;
pub const PI_O_2: f64 = 1.570_796_326_794_896_558_00e+00;
pub const PI: f64 = 3.141_592_653_589_793_115_98e+00;
pub const PI_LO: f64 = 1.224_646_799_147_353_207_17e-16;
    // rust: let (xb, yb) = (x.to_bits(), y.to_bits());
    // rust: let hx = (xb >> 32) as i32;
    // rust: let ix = hx & 0x7fff_ffff;
    // rust: let lx = xb as u32;
    // rust: let hy = (yb >> 32) as i32;
    // rust: let iy = hy & 0x7fff_ffff;
    // rust: let ly = yb as u32;
    // rust: if (ix as u32 | ((lx | lx.wrapping_neg()) >> 31)) > 0x7ff0_0000
    // rust: || (iy as u32 | ((ly | ly.wrapping_neg()) >> 31)) > 0x7ff0_0000
    // rust: {
    // rust: return x + y; // NaN
}
    // rust: if hx.wrapping_sub(0x3ff0_0000) as u32 | lx == 0 {
    // rust: return fdlibm_atan(y); // x = 1.0
}
    // rust: let m = ((hy >> 31) & 1) | ((hx >> 30) & 2);
    // rust: if (iy as u32 | ly) == 0 {
    // rust: return match m {
    // rust: 0 | 1 => y,
    // rust: 2 => PI + TINY,
    // rust: _ => -PI - TINY,
}
}
    // rust: if (ix as u32 | lx) == 0 {
    // rust: return if hy < 0 {
    // rust: -PI_O_2 - TINY
    // rust: } else {
    // rust: PI_O_2 + TINY
}
}
    // rust: if ix == 0x7ff0_0000 {
    // rust: if iy == 0x7ff0_0000 {
    // rust: return match m {
    // rust: 0 => PI_O_4 + TINY,
    // rust: 1 => -PI_O_4 - TINY,
    // rust: 2 => 3.0 * PI_O_4 + TINY,
    // rust: _ => -3.0 * PI_O_4 - TINY,
}
}
    // rust: return match m {
    // rust: 0 => 0.0,
    // rust: 1 => -0.0,
    // rust: 2 => PI + TINY,
    // rust: _ => -PI - TINY,
}
}
    // rust: if iy == 0x7ff0_0000 {
    // rust: return if hy < 0 {
    // rust: -PI_O_2 - TINY
    // rust: } else {
    // rust: PI_O_2 + TINY
}
}
    // rust: let k = (iy - ix) >> 20;
    // rust: let z = if k > 60 {
    // rust: PI_O_2 + 0.5 * PI_LO
    // rust: } else if hx < 0 && k < -60 {
    // rust: 0.0
    // rust: } else {
    // rust: fdlibm_atan((y / x).abs())
}
    // rust: match m {
    // rust: 0 => z,
    // rust: 1 => -z,
    // rust: 2 => PI - (z - PI_LO),
    // rust: _ => (z - PI_LO) - PI,
}
}

    // rust: mod tests {
//     use super::*;
    /// Values the 26.3 client computes on x86-64 HotSpot.
pub fn atan2_matches_the_client_tables() void {
}
    // rust: for (y, x, r) in [
    // rust: (
    // rust: 0x402f_3b4b_8041_4df1_u64,
    // rust: 0xc018_53ca_369b_9e91_u64,
    // rust: 0x3fff_1334_9f9d_e798_u64,
    // rust: ),
    // rust: (
    // rust: 0xc025_d316_35f2_9de8,
    // rust: 0xc018_fb4a_7ec4_3ba8,
    // rust: 0xc000_b996_6547_a498,
    // rust: ),
    // rust: (
    // rust: 0xc026_5d9c_2b5a_472d,
    // rust: 0xc030_954d_c2dc_3d10,
    // rust: 0xc004_62e7_82d4_c97e,
    // rust: ),
    // rust: ] {
    // rust: assert_eq!(atan2(f64::from_bits(y), f64::from_bits(x)).to_bits(), r);
}
    // rust: assert_eq!(fdlibm_asin(60.0 / 256.0).to_bits(), 0x3fce_481c_0fce_7134);
    // rust: assert_eq!(fdlibm_asin(61.0 / 256.0).to_bits(), 0x3fce_cbd7_5b6c_d8f0);
}
pub fn long_narrowing_and_quadrants() void {
}
    // rust: assert_eq!(sin(0.0).to_bits(), 0.0f32.to_bits());
    // rust: assert_eq!(sin(f64::NAN), sin(0.0));
    // rust: assert_eq!(sin(f64::INFINITY), sine_table()[65535]);
    // rust: assert_eq!(sin(f64::NEG_INFINITY), sine_table()[0]);
    // rust: assert_eq!(cos(0.0), 1.0);
    // rust: assert_eq!(sin(std::f64::consts::FRAC_PI_2), 1.0);
}

pub fn fdlibm_atan2_matches_java_math_atan2() void {
}
        // (y, x, Math.atan2(y, x)) bits from a HotSpot 25 run.
    // rust: let cases: [(u64, u64, u64); 21] = [
    // rust: (0x4036c1a1555ddb90, 0x40b1a89b60fc338e, 0x3f749e66db543fc4),
    // rust: (0xbfc9752ac321b894, 0x3f3d80a505d0aa2b, 0xbff918b5f001ade8),
    // rust: (0x4013fbdac7d52a8f, 0x4043e369b0fa3aad, 0x3fbffc728a3272d5),
    // rust: (0x3fd89fe141e1eea2, 0x3fcfd23d2fa01b78, 0x3fefe8a13ebea603),
    // rust: (0xbf815cc85b3c5c7a, 0x40b1ab07dd5012f3, 0xbebf72476f1c300d),
    // rust: (0xbf6decaf388fcf29, 0x3ffbedddfbfb829e, 0xbf6124a1265c6efd),
    // rust: (0xbfeb43b46f5bbbfc, 0xc0057a5b64b11a12, 0xc006aca11bc899f9),
    // rust: (0x3fd0d1695a72bc5c, 0x3fa34c15b3f8f245, 0x3ff6da7c56d44150),
    // rust: (0xc00e3df263d3716a, 0x4002565c34839cb6, 0xbff069572866761a),
    // rust: (0xbf22b9569c9c365e, 0xbffb7bf36ef636e8, 0xc00921cfba70e58c),
    // rust: (0x40001bca146d16b0, 0xc074c72be81b2112, 0x40091593dd9f4b9d),
    // rust: (0xbf58f46b45074b90, 0x3f752f2393097fe7, 0xbfd25467b1734764),
    // rust: (0x40aa8c9dfed35afe, 0x401d5279f1fc1595, 0x3ff919256ef21d22),
    // rust: (0x3f304a34e8c07c8b, 0xbf346080834c6bae, 0x4003bcd457a3e152),
    // rust: (0x407bc14a1749ce5b, 0x3fa94314f9e58f65, 0x3ff92186d3893ce6),
    // rust: (0xbf4c9156e5163833, 0xc0b2c3a07f21df29, 0xc00921fb3be82bfe),
    // rust: (0xc001fda2a9c29687, 0xc07917504bff0cb1, 0xc009168273a10702),
    // rust: (0xc06911a6f4f07751, 0xbfce4df079fb6418, 0xbff926d12f47ff9f),
    // rust: (0xc044ef11007719e6, 0xbf9984e712cc5687, 0xbff9246b79ec6a20),
    // rust: (0xbfecf1294a501faa, 0x409b7de1660f155a, 0xbf40d815260dd369),
    // rust: (0xc0a7a9f851863c31, 0xc03b3bd7d7a8f4a8, 0xbff946cee06eebe8),
    // rust: ];
    // rust: for (y, x, expected) in cases {
    // rust: let got = fdlibm_atan2(f64::from_bits(y), f64::from_bits(x));
    // rust: assert_eq!(got.to_bits(), expected, "atan2({y:x}, {x:x})");
}
}
}
