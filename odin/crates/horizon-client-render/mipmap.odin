//! Transpiled from Horizon Rust crate
package horizon_client_render_mipmap

import "core:fmt"
import "core:mem"
import "core:math"

// `MipmapGenerator`: the mip levels of a sprite. Cutout textures keep the
// alpha-test coverage of their base level at every level
// (`scaleAlphaToCoverage`), so thin cutout edges (cactus sides, leaves,
// flowers) don't erode into gaps with distance; colours average in linear
// light (`ARGB.meanLinear`).

// `MipmapStrategy`, from the texture's `.mcmeta` `texture` section.
Strategy :: enum {
    Auto,
    Mean,
    Cutout,
    StrictCutout,
    DarkCutout,
}
    // rust: impl Strategy {
parse :: proc(name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(match name {
    // rust: "auto" => Self::Auto,
    // rust: "mean" => Self::Mean,
    // rust: "cutout" => Self::Cutout,
    // rust: "strict_cutout" => Self::StrictCutout,
    // rust: "dark_cutout" => Self::DarkCutout,
    // rust: _ => return None,
    // rust: })
}
}

// How a sprite's mips are made: its `.mcmeta` `texture` section, whether
// it has a fully transparent pixel and whether it is an `item/` sprite.
Settings :: struct {
    // Original square frame edge, before fitting the sprite into the array.
    // Zero means the supplied image is already at its native size.
    native_size: u32,
    strategy: Strategy,
    alpha_cutoff_bias: f32,
    has_transparent: bool,
    item: bool,
    // Whether a high-resolution cutout's small levels are dithered ([`dither_cutout_levels`]).
    dither_cutouts: bool,
}

// The `ditherCutoutMips` setting, for textures loaded from now on.
DITHER_CUTOUTS :: std::sync::atomic::AtomicBool::new(false)

// Sets `ditherCutoutMips`; true if that changes it, when the textures must load again.
set_dither_cutouts :: proc(on: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: DITHER_CUTOUTS.swap(on, std::sync::atomic::Ordering::Relaxed) != on
}

// The `ditherCutoutMips` setting.
dither_cutouts :: proc() -> b {
    // Ported from Horizon
    return {}
}
    // rust: DITHER_CUTOUTS.load(std::sync::atomic::Ordering::Relaxed)
}

// A square or rectangular RGBA8 image, rows top to bottom.
Image :: struct {
    width: u32,
    height: u32,
    pixels: Vec<[u8,
}
    // rust: impl Image {
resized :: proc(self: ^Self, size: u32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: width: size,
    // rust: height: size,
    // rust: pixels: (0..size * size)
    // rust: .map(|i| self.get(i % size * self.width / size, i / size * self.height / size))
    // rust: .collect(),
}
}
get :: proc(self: ^Self, x: u32, y: u32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: self.pixels[(x + y * self.width) as usize]
}
set :: proc(self: ^Self, x: u32, y: u32, p: [u8; 4]) {
}
    // rust: self.pixels[(x + y * self.width) as usize] = p;
}
}

// `ARGB.SRGB_TO_LINEAR`: an sRGB channel in linear light, 0 to 1023.
srgb_to_linear :: proc() -> ^ {
    // Ported from Horizon
    return {}
}
TABLE :: std::sync::OnceLock::new()
    // rust: TABLE.get_or_init(|| {
    // rust: std::array::from_fn(|i| {
    // rust: let x = i as f32 / 255.0;
    // rust: let linear = if x >= 0.04045 {
    // rust: ((f64::from(x) + 0.055) / 1.055).powf(2.4) as f32
    // rust: } else {
    // rust: x / 12.92
}
    // rust: horizon_core::jmath::round_f32(linear * 1023.0) as u16
    // rust: })
    // rust: })
}
// `ARGB.LINEAR_TO_SRGB`: 1024 linear steps back to sRGB.
linear_to_srgb :: proc() -> ^ {
    // Ported from Horizon
    return {}
}
TABLE :: std::sync::OnceLock::new()
    // rust: TABLE.get_or_init(|| {
    // rust: std::array::from_fn(|i| {
    // rust: let x = i as f32 / 1023.0;
    // rust: let srgb = if x >= 0.003_130_8 {
    // rust: (1.055 * f64::from(x).powf(0.416_666_666_666_666_7) - 0.055) as f32
    // rust: } else {
    // rust: 12.92 * x
}
    // rust: horizon_core::jmath::round_f32(srgb * 255.0) as u8
    // rust: })
    // rust: })
}
// `ARGB.alphaFloat`.
alpha_float :: proc(p: [u8; 4]) -> f {
    // Ported from Horizon
    return {}
}
    // rust: f32::from(p[3]) / 255.0
}

// `MipmapGenerator.alphaTestCoverage`: the share of the image (bilinearly
// subsampled 4x4 per texel) whose scaled alpha passes `alpha_ref`.
alpha_test_coverage :: proc(image: ^Image, alpha_ref: f32, alpha_scale: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let (width, height) = (image.width as i32, image.height as i32);
    // rust: let mut coverage = 0.0f32;
    // rust: let a =
    // rust: |x: i32, y: i32| (alpha_float(image.get(x as u32, y as u32)) * alpha_scale).clamp(0.0, 1.0);
    // rust: for y in 0..height - 1 {
    // rust: for x in 0..width - 1 {
    // rust: let (a00, a10, a01, a11) = (a(x, y), a(x + 1, y), a(x, y + 1), a(x + 1, y + 1));
    // rust: let mut texel = 0.0f32;
    // rust: for sy in 0..4 {
    // rust: let fy = (sy as f32 + 0.5) / 4.0;
    // rust: for sx in 0..4 {
    // rust: let fx = (sx as f32 + 0.5) / 4.0;
    // rust: let alpha = a00 * (1.0 - fx) * (1.0 - fy)
    // rust: + a10 * fx * (1.0 - fy)
    // rust: + a01 * (1.0 - fx) * fy
    // rust: + a11 * fx * fy;
    // rust: if alpha > alpha_ref {
    // rust: texel += 1.0;
}
}
}
    // rust: coverage += texel / 16.0;
}
}
    // rust: coverage / ((width - 1) * (height - 1)) as f32
}

// `MipmapGenerator.scaleAlphaToCoverage`: five bisection steps for the
// alpha scale whose coverage is nearest `desired`, then every alpha scaled
// and biased.
scale_alpha_to_coverage :: proc(image: ^Image, desired: f32, alpha_ref: f32, bias: f32) {
}
    // rust: let (mut min_scale, mut max_scale) = (0.0f32, 4.0f32);
    // rust: let mut scale = 1.0f32;
    // rust: let mut best_scale = 1.0f32;
    // rust: let mut best_error = f32::MAX;
    // rust: for _ in 0..5 {
    // rust: let current = alpha_test_coverage(image, alpha_ref, scale);
    // rust: let error = (current - desired).abs();
    // rust: if error < best_error {
    // rust: best_error = error;
    // rust: best_scale = scale;
}
    // rust: if current < desired {
    // rust: min_scale = scale;
    // rust: } else if current > desired {
    // rust: max_scale = scale;
    // rust: } else {
    // rust: break;
}
    // rust: scale = (min_scale + max_scale) * 0.5;
}
    // rust: for p in &mut image.pixels {
    // rust: let alpha = (alpha_float(*p) * best_scale + bias + 0.025).clamp(0.0, 1.0);
    // rust: p[3] = (alpha * 255.0).floor() as u8;
}
}

// `TextureUtil.solidify`: every transparent pixel takes the colour of the
// nearest opaque one (breadth first, keeping its zero alpha).
solidify :: proc(image: ^Image) {
}
    // rust: let (width, height) = (image.width as i32, image.height as i32);
    // rust: let n = image.pixels.len();
    // rust: let mut nearest = vec![[0u8; 4]; n];
    // rust: let mut distance = vec![i32::MAX; n];
    // rust: let mut queue = std::collections::VecDeque::new();
    // rust: for x in 0..width {
    // rust: for y in 0..height {
    // rust: let i = (x + y * width) as usize;
    // rust: let p = image.pixels[i];
    // rust: if p[3] != 0 {
    // rust: distance[i] = 0;
    // rust: nearest[i] = p;
    // rust: queue.push_back(i);
}
}
}
    // rust: while let Some(i) = queue.pop_front() {
    // rust: let (x, y) = (i as i32 % width, i as i32 / width);
    // rust: for (dx, dy) in [(1, 0), (-1, 0), (0, 1), (0, -1)] {
    // rust: let (nx, ny) = (x + dx, y + dy);
    // rust: if nx >= 0 && ny >= 0 && nx < width && ny < height {
    // rust: let j = (nx + ny * width) as usize;
    // rust: if distance[j] > distance[i] + 1 {
    // rust: distance[j] = distance[i] + 1;
    // rust: nearest[j] = nearest[i];
    // rust: queue.push_back(j);
}
}
}
}
    // rust: for (i, p) in image.pixels.iter_mut().enumerate() {
    // rust: if p[3] == 0 {
    // rust: let c = nearest[i];
    // rust: *p = [c[0], c[1], c[2], 0];
}
}
}

// `TextureUtil.fillEmptyAreasWithDarkColor`: transparent pixels take three
// quarters of the darkest visible colour.
fill_empty_dark :: proc(image: ^Image) {
}
    // rust: let mut darkest = [255u8; 4];
    // rust: let mut min = i32::MAX;
    // rust: for x in 0..image.width {
    // rust: for y in 0..image.height {
    // rust: let p = image.get(x, y);
    // rust: if p[3] != 0 {
    // rust: let brightness = i32::from(p[0]) + i32::from(p[1]) + i32::from(p[2]);
    // rust: if brightness < min {
    // rust: min = brightness;
    // rust: darkest = p;
}
}
}
}
    // rust: let dark = |c: u8| (3 * i32::from(c) / 4) as u8;
    // rust: let fill = [dark(darkest[0]), dark(darkest[1]), dark(darkest[2]), 0];
    // rust: for p in &mut image.pixels {
    // rust: if p[3] == 0 {
    // rust: *p = fill;
}
}
}

// `ARGB.meanLinear`.
mean_linear :: proc(c: [[u8; 4]; 4]) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let (to_linear, to_srgb) = (srgb_to_linear(), linear_to_srgb());
    // rust: let channel = |k: usize| {
    // rust: let sum: u32 = c.iter().map(|p| u32::from(to_linear[p[k] as usize])).sum();
    // rust: to_srgb[(sum / 4) as usize]
}
    // rust: let alpha = c.iter().map(|p| u32::from(p[3])).sum::<u32>() / 4;
    // rust: [channel(0), channel(1), channel(2), alpha as u8]
}

// `MipmapGenerator.darkenedAlphaBlend`: the visible pixels' mean in linear
// light, transparent ones counting as black.
darkened_alpha_blend :: proc(c: [[u8; 4]; 4]) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let to_linear = srgb_to_linear();
    // rust: let linear = |v: u8| f32::from(to_linear[v as usize]) / 1023.0;
    // rust: let mut total = [0.0f32; 4];
    // rust: for p in c.iter().filter(|p| p[3] != 0) {
    // rust: total[3] += linear(p[3]);
    // rust: for k in 0..3 {
    // rust: total[k] += linear(p[k]);
}
}
    // rust: let to_srgb = |v: f32| linear_to_srgb()[(v / 4.0 * 1023.0).floor() as usize];
    // rust: [
    // rust: to_srgb(total[0]),
    // rust: to_srgb(total[1]),
    // rust: to_srgb(total[2]),
    // rust: to_srgb(total[3]),
    // rust: ]
}

// `MipmapGenerator.generateMipLevels` from the base image (`levels` mips
// below it). Array-only enlargement must not run extra alpha-coverage steps
// before the sprite's native mip chain.
generate :: proc(base: Image, levels: u32, settings: Settings) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let native = settings.native_size;
    // rust: if native.is_power_of_two()
    // rust: && native < base.width
    // rust: && base.width == base.height
    // rust: && base.width.is_power_of_two()
    // rust: {
    // rust: let extra = (base.width / native).ilog2();
    // rust: let mut mips =
    // rust: generate_native(base.resized(native), levels.saturating_sub(extra), settings);
    // rust: let mut out: Vec<_> = (0..extra.min(levels + 1))
    // rust: .map(|level| mips[0].resized(base.width >> level))
    // rust: .collect();
    // rust: if levels >= extra {
    // rust: out.append(&mut mips);
}
    // rust: return out;
}
    // rust: generate_native(base, levels, settings)
}

generate_native :: proc(mut base: Image, levels: u32, settings: Settings) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let Settings {
    // rust: strategy,
    // rust: alpha_cutoff_bias,
    // rust: has_transparent,
    // rust: item,
    // rust: ..
    // rust: } = settings;
    // rust: let strategy = match strategy {
    // rust: Strategy::Auto if has_transparent => Strategy::Cutout,
    // rust: Strategy::Auto => Strategy::Mean,
    // rust: s => s,
}
    // rust: if !item {
    // rust: match strategy {
    // rust: Strategy::Cutout | Strategy::StrictCutout => solidify(&mut base),
    // rust: Strategy::DarkCutout => fill_empty_dark(&mut base),
    // rust: _ => {}
}
}
    // rust: let cutout = matches!(
    // rust: strategy,
    // rust: Strategy::Cutout | Strategy::StrictCutout | Strategy::DarkCutout
    // rust: );
    // rust: let alpha_ref = if strategy == Strategy::StrictCutout {
    // rust: 0.3
    // rust: } else {
    // rust: 0.5
}
    // rust: let coverage = if cutout {
    // rust: alpha_test_coverage(&base, alpha_ref, 1.0)
    // rust: } else {
    // rust: 0.0
}
    // rust: let mut out = vec![base];
    // rust: for _ in 1..=levels {
    // rust: let last = out.last().expect("the base level");
    // rust: let (width, height) = (last.width >> 1, last.height >> 1);
    // rust: let mut data = Image {
    // rust: width,
    // rust: height,
    // rust: pixels: vec![[0; 4]; (width * height) as usize],
}
    // rust: for x in 0..width {
    // rust: for y in 0..height {
    // rust: let c = [
    // rust: last.get(x * 2, y * 2),
    // rust: last.get(x * 2 + 1, y * 2),
    // rust: last.get(x * 2, y * 2 + 1),
    // rust: last.get(x * 2 + 1, y * 2 + 1),
    // rust: ];
    // rust: let p = if strategy == Strategy::DarkCutout {
    // rust: darkened_alpha_blend(c)
    // rust: } else {
    // rust: mean_linear(c)
}
    // rust: data.set(x, y, p);
}
}
    // rust: if cutout {
    // rust: scale_alpha_to_coverage(&mut data, coverage, alpha_ref, alpha_cutoff_bias);
}
    // rust: out.push(data);
}
    // rust: if settings.dither_cutouts && cutout && out[0].width >= DITHERED_CUTOUT_SIZE {
    // rust: dither_cutout_levels(&mut out);
}
    // rust: out
}

// From this size a cutout texture's mips can be dithered ([`dither_cutout_levels`]).
DITHERED_CUTOUT_SIZE :: 64
// A high-resolution cutout's detail is finer than its small mips: grass blades a few
// texels wide at 2048 average to about the same alpha everywhere at 64, and no scale of
// that alpha can keep the coverage, so the alpha test passes the whole quad or none of it.
// Each level below the base takes the base's mean alpha through an ordered dither instead:
// its texels are in or out, about as many in as the base has.
dither_cutout_levels :: proc(levels: ^[Image]) {
}
    // rust: const BAYER: [[f32; 4]; 4] = [
    // rust: [0.0, 8.0, 2.0, 10.0],
    // rust: [12.0, 4.0, 14.0, 6.0],
    // rust: [3.0, 11.0, 1.0, 9.0],
    // rust: [15.0, 7.0, 13.0, 5.0],
    // rust: ];
    // rust: let (mut w, mut h) = (levels[0].width as usize, levels[0].height as usize);
    // rust: let mut alpha: Vec<f32> = levels[0]
    // rust: .pixels
    // rust: .iter()
    // rust: .map(|p| f32::from(p[3]) / 255.0)
    // rust: .collect();
    // rust: for level in &mut levels[1..] {
    // rust: let (nw, nh) = (level.width as usize, level.height as usize);
    // rust: let mut next = vec![0.0; nw * nh];
    // rust: for y in 0..nh {
    // rust: for x in 0..nw {
    // rust: let at = |dx: usize, dy: usize| {
    // rust: alpha[(y * 2 + dy).min(h - 1) * w + (x * 2 + dx).min(w - 1)]
}
    // rust: let mean = (at(0, 0) + at(1, 0) + at(0, 1) + at(1, 1)) / 4.0;
    // rust: next[y * nw + x] = mean;
    // rust: let threshold = (BAYER[y % 4][x % 4] + 0.5) / 16.0;
    // rust: level.pixels[y * nw + x][3] = if mean > threshold { 255 } else { 0 };
}
}
    // rust: alpha = next;
    // rust: (w, h) = (nw, nh);
}
}

    // rust: mod dither_tests {
//     use super::*;
the_dither_only_runs_when_asked_for_and_from_its_size :: proc() {
}
    // rust: let cutout = |side: u32| Image {
    // rust: width: side,
    // rust: height: side,
    // rust: pixels: (0..side * side)
    // rust: .map(|i| {
    // rust: [
    // rust: 90,
    // rust: 140,
    // rust: 40,
    // rust: if (i % side).is_multiple_of(4) { 255 } else { 0 },
    // rust: ]
    // rust: })
    // rust: .collect(),
}
    // rust: let settings = |dither_cutouts| Settings {
    // rust: has_transparent: true,
    // rust: dither_cutouts,
    // rust: ..Settings::default()
}
    // rust: assert_ne!(
    // rust: generate(cutout(128), 4, settings(false)),
    // rust: generate(cutout(128), 4, settings(true))
    // rust: );
    // rust: assert_eq!(
    // rust: generate(cutout(32), 4, settings(false)),
    // rust: generate(cutout(32), 4, settings(true))
    // rust: );
}
a_high_resolution_cutouts_fine_detail_keeps_its_coverage_in_small_mips :: proc() {
}
        // Blades one texel wide, one column in four: too fine for the mips to hold.
    // rust: let side = 128u32;
    // rust: let pixels = (0..side * side)
    // rust: .map(|i| {
    // rust: [
    // rust: 90,
    // rust: 140,
    // rust: 40,
    // rust: if (i % side).is_multiple_of(4) { 255 } else { 0 },
    // rust: ]
    // rust: })
    // rust: .collect();
    // rust: let base = Image {
    // rust: width: side,
    // rust: height: side,
    // rust: pixels,
}
    // rust: let settings = Settings {
    // rust: has_transparent: true,
    // rust: dither_cutouts: true,
    // rust: ..Settings::default()
}
    // rust: let mips = generate(base, 4, settings);
    // rust: for level in &mips[3..] {
    // rust: let passing = level.pixels.iter().filter(|p| p[3] >= 128).count() as f32;
    // rust: let coverage = passing / level.pixels.len() as f32;
    // rust: assert!((0.15..0.35).contains(&coverage), "{coverage}");
}
}
}
