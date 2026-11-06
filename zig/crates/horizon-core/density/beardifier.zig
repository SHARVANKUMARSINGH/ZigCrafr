//! Transpiled from Horizon Rust crate
//! Module: horizon-core_beardifier
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Structure terrain adaptation from ordered rigid pieces and jigsaw junctions.
//! Discovery/filtering of live structure starts is a separate world subsystem.
// use super::{DensitySampler, SampleError, SamplerContext, check_buffer};
// use crate::noise::DensityVolume;
// use std::sync::{Arc, OnceLock};

pub const StructureBounds = struct {
    minimum: [i32,
    maximum: [i32,
};
    // rust: impl StructureBounds {
    /// Already normalized inclusive bounds. Invalid inputs are rejected rather
    /// than invoking vanilla's development-mode logging/repair path.
pub fn new(minimum: [i32; 3], maximum: [i32; 3]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (0..3)
    // rust: .all(|axis| minimum[axis] <= maximum[axis])
    // rust: .then_some(Self { minimum, maximum })
}
pub fn minimum(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.minimum
}
pub fn maximum(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.maximum
}
pub fn contains(self: *Self, position: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (0..3).all(|i| position[i] >= self.minimum[i] && position[i] <= self.maximum[i])
}
pub fn intersects(self: *Self, minimum: [i32; 3], maximum: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (0..3).all(|i| self.maximum[i] >= minimum[i] && self.minimum[i] <= maximum[i])
}
}

pub const TerrainAdjustment = enum {
    None,
    Bury,
    BeardThin,
    BeardBox,
    Encapsulate,
};
pub const RigidPiece = struct {
    bounds: StructureBounds,
    adjustment: TerrainAdjustment,
    ground_level_delta: i32,
};
pub const JigsawJunction = struct {
    source_x: i32,
    source_ground_y: i32,
    source_z: i32,
};

/// A structure library's terrain kernel: YUNG's API's and MoogsStructureLib's
/// enhanced terrain adaptation (EnhancedTerrainAdaptation.computeDensityFactor).
/// Like vanilla's beard, but with its own size and falloff, and an action
/// above the piece's floor and one below it: bury adds terrain, carve takes
/// it away.
pub const TerrainKernel = struct {
    size: i32,
    /// Density sign above the floor and below it: 1 buries, -1 carves, 0 none.
    top: i32,
    bottom: i32,
    weights: std.ArrayList(f32),
};
    // rust: impl TerrainKernel {
    /// A kernel `size` blocks across whose weights fall off as
    /// e^(-d²/`distance`). Size 0 is the libraries' NONE: no density.
pub fn new(size: i32, distance: i32, top: i32, bottom: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let size = size.max(0);
    // rust: let radius = size / 2;
    // rust: let mut weights = vec![0.; (size as usize).pow(3)];
    // rust: for x in 0..size {
    // rust: for y in 0..size {
    // rust: for z in 0..size {
    // rust: let (kx, ky, kz) = (
    // rust: f64::from(x - radius),
    // rust: f64::from(y - radius) + 0.5,
    // rust: f64::from(z - radius),
    // rust: );
    // rust: let squared = kx * kx + ky * ky + kz * kz;
    // rust: weights[((z * size + x) * size + y) as usize] =
    // rust: crate::jmath::pow(std::f64::consts::E, -squared / f64::from(distance))
    // rust: as f32;
}
}
}
    // rust: Self {
    // rust: size,
    // rust: top,
    // rust: bottom,
    // rust: weights,
}
}
pub fn radius(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.size / 2
}
    /// The libraries' NONE: no kernel at all.
pub fn is_none(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.size == 0
}
    /// The density at (`dx`, `dy`, `dz`) from the nearest point of a piece
    /// (or a junction), `floor` blocks above the piece's floor.
pub fn factor(self: *Self, dx: i32, dy: i32, dz: i32, floor: i32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let radius = self.radius();
    // rust: let k = [dx, dy, dz].map(|v| v.wrapping_add(radius));
    // rust: if k.iter().any(|v| !(0..self.size).contains(v)) {
    // rust: return 0.;
}
    // rust: let weight = self.weights[((k[2] * self.size + k[0]) * self.size + k[1]) as usize];
    // rust: let floor = f64::from(floor) + 0.5;
    // rust: let squared = f64::from(dx) * f64::from(dx) + floor * floor + f64::from(dz) * f64::from(dz);
        // Mth.invSqrt(double): 1 / sqrt, not vanilla beard's fast estimate.
    // rust: let multiplier = (floor * (1. / (squared / 2.).sqrt()) / 2.).abs();
    // rust: let sign = if floor > 0. { self.top } else { self.bottom };
    // rust: multiplier * f64::from(weight) * f64::from(sign)
}
}
/// A rigid piece's box under a terrain kernel (already moved, padded or cut
/// to a band as the piece's adaptation says).
pub const KernelPiece = struct {
    bounds: StructureBounds,
    kernel: *TerrainKernel,
};
/// A jigsaw junction under a terrain kernel; `source` holds the ground
/// height with the adaptation's offset.
pub const KernelJunction = struct {
    source: [i32,
    kernel: *TerrainKernel,
};

pub const Beardifier = struct {
    pieces: std.ArrayList(RigidPiece),
    junctions: std.ArrayList(JigsawJunction),
    kernel_pieces: std.ArrayList(KernelPiece),
    kernel_junctions: std.ArrayList(KernelJunction),
    affected: ?StructureBounds,
};
    // rust: impl Beardifier {
    /// Matches the runtime constructor. A missing affected box makes the entire
    /// sampler empty, even when the supplied component lists are nonempty.
    // rust: pub fn new(
    // rust: pieces: Vec<RigidPiece>,
    // rust: junctions: Vec<JigsawJunction>,
    // rust: affected: Option<StructureBounds>,
    // rust: ) -> Self {
    // rust: Self {
    // rust: pieces,
    // rust: junctions,
    // rust: affected,
    // rust: ..Self::default()
}
}
    /// Adds terrain kernels' pieces and junctions, summed after vanilla's
    /// density in double precision as the libraries' Beardifier mixins do.
    /// `affected` must cover them.
    // rust: pub fn with_kernels(
    // rust: mut self,
    // rust: pieces: Vec<KernelPiece>,
    // rust: junctions: Vec<KernelJunction>,
    // rust: ) -> Self {
    // rust: self.kernel_pieces = pieces;
    // rust: self.kernel_junctions = junctions;
    // rust: self
}
pub fn sample_unchecked(self: *Self, z]: [i32; 3]) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut value = 0.;
        // The kernel is a process-wide constant; resolving it once keeps the
        // per-piece and per-junction beard evaluations off the OnceLock.
    // rust: let kernel = kernel();
    // rust: for piece in &self.pieces {
    // rust: let low = piece.bounds.minimum;
    // rust: let high = piece.bounds.maximum;
    // rust: let dx = 0.max(low[0].wrapping_sub(x).max(x.wrapping_sub(high[0])));
    // rust: let dz = 0.max(low[2].wrapping_sub(z).max(z.wrapping_sub(high[2])));
    // rust: let ground = low[1].wrapping_add(piece.ground_level_delta);
    // rust: let dy = y.wrapping_sub(ground);
    // rust: let distance_y = match piece.adjustment {
    // rust: TerrainAdjustment::None => 0,
    // rust: TerrainAdjustment::Bury | TerrainAdjustment::BeardThin => dy,
    // rust: TerrainAdjustment::BeardBox => {
    // rust: 0.max(ground.wrapping_sub(y).max(y.wrapping_sub(high[1])))
}
    // rust: TerrainAdjustment::Encapsulate => {
    // rust: 0.max(low[1].wrapping_sub(y).max(y.wrapping_sub(high[1])))
}
}
    // rust: value += match piece.adjustment {
    // rust: TerrainAdjustment::None => 0.,
    // rust: TerrainAdjustment::Bury => bury(dx as f32, distance_y as f32 / 2., dz as f32),
    // rust: TerrainAdjustment::BeardThin | TerrainAdjustment::BeardBox => {
    // rust: beard(kernel, dx, distance_y, dz, dy) * 0.8
}
    // rust: TerrainAdjustment::Encapsulate => {
    // rust: bury(dx as f32 / 2., distance_y as f32 / 2., dz as f32 / 2.) * 0.8
}
}
}
    // rust: for junction in &self.junctions {
    // rust: let dx = x.wrapping_sub(junction.source_x);
    // rust: let dy = y.wrapping_sub(junction.source_ground_y);
    // rust: let dz = z.wrapping_sub(junction.source_z);
    // rust: value += beard(kernel, dx, dy, dz, dy) * 0.4;
}
    // rust: if self.kernel_pieces.is_empty() && self.kernel_junctions.is_empty() {
    // rust: return value;
}
    // rust: let mut density = f64::from(value);
    // rust: for piece in &self.kernel_pieces {
    // rust: let (low, high) = (piece.bounds.minimum, piece.bounds.maximum);
    // rust: let d: [i32; 3] = std::array::from_fn(|i| {
    // rust: 0.max(
    // rust: low[i]
    // rust: .wrapping_sub([x, y, z][i])
    // rust: .max([x, y, z][i].wrapping_sub(high[i])),
    // rust: )
    // rust: });
    // rust: density += piece
    // rust: .kernel
    // rust: .factor(d[0], d[1], d[2], y.wrapping_sub(low[1]))
    // rust: * 0.8;
}
    // rust: for junction in &self.kernel_junctions {
    // rust: let d: [i32; 3] =
    // rust: std::array::from_fn(|i| [x, y, z][i].wrapping_sub(junction.source[i]));
    // rust: density += junction.kernel.factor(d[0], d[1], d[2], d[1]) * 0.4;
}
    // rust: density as f32
}
}
    // rust: impl DensitySampler for Beardifier {
pub fn sample_value(self: *Self, _: *mut SamplerContext, position: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(
    // rust: if self
    // rust: .affected
    // rust: .is_some_and(|bounds| bounds.contains(position))
    // rust: {
    // rust: self.sample_unchecked(position)
    // rust: } else {
    // rust: 0.
    // rust: },
    // rust: )
}
    // rust: fn sample_volume(
    // rust: &self,
    // rust: _: &mut SamplerContext,
    // rust: buffer: &mut [f32],
    // rust: volume: DensityVolume,
    // rust: ) -> Result<(), SampleError> {
    // rust: check_buffer(buffer, volume)?;
    // rust: buffer.fill(0.);
    // rust: let Some(bounds) = self.affected else {
    // rust: return Ok(());
}
    // rust: let minimum = volume.minimum();
    // rust: if !bounds.intersects(minimum, volume.maximum()) {
    // rust: return Ok(());
}
    // rust: let steps = volume.steps();
    // rust: let sizes = volume.sizes();
        // Deliberately floor, not ceil: the first bulk lattice sample can lie
        // below the affected bounds and is evaluated without the scalar guard.
    // rust: let low: [i32; 3] = std::array::from_fn(|i| {
    // rust: bounds.minimum[i]
    // rust: .wrapping_sub(minimum[i])
    // rust: .max(0)
    // rust: .div_euclid(steps[i])
    // rust: });
    // rust: let high: [i32; 3] = std::array::from_fn(|i| {
    // rust: ((sizes[i] - 1) as i32).min(
    // rust: bounds.maximum[i]
    // rust: .wrapping_sub(minimum[i])
    // rust: .div_euclid(steps[i]),
    // rust: )
    // rust: });
    // rust: for z in low[2]..=high[2] {
    // rust: for x in low[0]..=high[0] {
    // rust: for y in low[1]..=high[1] {
    // rust: let index = volume
    // rust: .index([x as usize, y as usize, z as usize])
    // rust: .expect("bounded structure density indices");
    // rust: let local = [x, y, z];
    // rust: let point = std::array::from_fn(|i| {
    // rust: minimum[i].wrapping_add(local[i].wrapping_mul(steps[i]))
    // rust: });
    // rust: buffer[index] = self.sample_unchecked(point);
}
}
}
    // rust: Ok(())
}
}
pub fn bury(x: f32, y: f32, z: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let squared = (x * x + y * y) + z * z;
    // rust: if squared >= 36. {
    // rust: 0.
    // rust: } else {
    // rust: 1. - squared.sqrt() / 6.
}
}
pub fn beard(kernel: *[f32; 13824], x: i32, y: i32, z: i32, ground_delta: i32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let indices = [x, y, z].map(|v| v.wrapping_add(12));
    // rust: if indices.iter().any(|v| !(0..24).contains(v)) {
    // rust: return 0.;
}
    // rust: let vertical = ground_delta as f32 + 0.5;
    // rust: let squared = (x as f32 * x as f32 + vertical * vertical) + z as f32 * z as f32;
    // rust: let factor = (-vertical * fast_inverse_sqrt(f64::from(squared / 2.)) as f32) / 2.;
    // rust: factor * kernel[((indices[2] * 24 + indices[0]) * 24 + indices[1]) as usize]
}
pub fn fast_inverse_sqrt(value: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let half = 0.5 * value;
    // rust: let bits = 6_910_469_410_427_058_090i64.wrapping_sub((value.to_bits() as i64) >> 1);
    // rust: let estimate = f64::from_bits(bits as u64);
    // rust: estimate * (1.5 - half * estimate * estimate)
}
pub fn kernel() * {
    // Implementation ported from Horizon
    return undefined;
}
pub const KERNEL: OnceLock<[f32; 13824]> = OnceLock::new();
    // rust: KERNEL.get_or_init(|| {
    // rust: std::array::from_fn(|i| {
    // rust: let z = (i / 576) as f64 - 12.;
    // rust: let x = ((i / 24) % 24) as f64 - 12.;
    // rust: let y = (i % 24) as f64 - 12. + 0.5;
    // rust: let squared = (x * x + y * y) + z * z;
    // rust: crate::jmath::pow(std::f64::consts::E, -squared / 16.) as f32
    // rust: })
    // rust: })
}

    // rust: mod tests {
//     use super::*;

pub fn sample(beardifier: *Beardifier, position: [i32; 3]) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: beardifier
    // rust: .sample_value(&mut SamplerContext::default(), position)
    // rust: .unwrap()
}

    /// YUNG's carved top (kernel 24, distance 24, carve above, nothing
    /// below) around a 5-block cube, values worked out from
    /// EnhancedTerrainAdaptation.computeDensityFactor.
pub fn kernel_pieces_carve_above_the_floor_only() void {
}
    // rust: let kernel = Arc::new(TerrainKernel::new(24, 24, -1, 0));
    // rust: let bounds = StructureBounds::new([0; 3], [4; 3]).unwrap();
    // rust: let affected = StructureBounds::new([-20; 3], [20; 3]);
    // rust: let b = Beardifier::new(Vec::new(), Vec::new(), affected)
    // rust: .with_kernels(vec![KernelPiece { bounds, kernel }], Vec::new());
        // Inside, on the floor: |0.5 / sqrt(0.125) / 2| * e^(-0.25/24) * -0.8.
    // rust: assert!((sample(&b, [2, 0, 2]) + 0.559_823_4).abs() < 1e-6);
        // Three blocks east: |0.5 / sqrt(4.625) / 2| * e^(-9.25/24) * -0.8.
    // rust: assert!((sample(&b, [7, 0, 2]) + 0.063_254_3).abs() < 1e-6);
        // Below the floor the bottom action (none) applies; past the radius
        // nothing does.
    // rust: assert_eq!(sample(&b, [2, -3, 2]), 0.);
    // rust: assert_eq!(sample(&b, [17, 2, 2]), 0.);
}

pub fn kernel_junctions_bury_at_four_tenths() void {
}
    // rust: let kernel = Arc::new(TerrainKernel::new(24, 24, 1, 1));
    // rust: let b = Beardifier::new(
    // rust: Vec::new(),
    // rust: Vec::new(),
    // rust: StructureBounds::new([-20; 3], [80; 3]),
    // rust: )
    // rust: .with_kernels(
    // rust: Vec::new(),
    // rust: vec![KernelJunction {
    // rust: source: [0, 64, 0],
    // rust: kernel,
    // rust: }],
    // rust: );
    // rust: assert!((sample(&b, [0, 64, 0]) - 0.279_911_7).abs() < 1e-6);
    // rust: assert!(sample(&b, [0, 60, 0]) > 0.);
    // rust: assert!(TerrainKernel::new(0, 0, 1, 1).is_none());
}

    /// `Beardifier.BEARD_KERNEL`: the table vanilla's static initialiser fills
    /// from `computeBeardContribution(xi - 12, yi - 12, zi - 12)`, stored at
    /// `zi * 24 * 24 + xi * 24 + yi` — `e^(-(dx² + (dy + 0.5)² + dz²) / 16)` as
    /// a `float`. 13824 values can't be read, so the ones below are pinned as
    /// the bits they have in vanilla (that initialiser's formula run under
    /// javac/java 21 and printed with `Float.floatToIntBits`), and `TABLE`
    /// hashes every entry so a change to the exponent, the offset or the index
    /// order fails here instead of in a world.
pub fn the_beard_kernel_table_is_vanillas() void {
}
    // rust: let k = kernel();
        // (index, float bits): the corner, the three axes' first steps, the
        // centre (dy 0.5), an off-axis point and the far corner.
    // rust: for (index, bits) in [
    // rust: (0usize, 747_230_124u32),
    // rust: (1, 763_905_896),
    // rust: (25, 781_152_350),
    // rust: (300, 956_222_450),
    // rust: (3067, 966_315_629),
    // rust: (7212, 1_065_093_109),
    // rust: (13_823, 781_758_625),
    // rust: ] {
    // rust: assert_eq!(
    // rust: k[index].to_bits(),
    // rust: bits,
    // rust: "kernel[{index}] is {} not {}",
    // rust: k[index],
    // rust: f32::from_bits(bits)
    // rust: );
}
        // The centre entry is the largest: every step away falls off.
    // rust: assert_eq!(
    // rust: (0..k.len()).max_by(|a, b| k[*a].total_cmp(&k[*b])),
    // rust: Some(7212)
    // rust: );
    // rust: let mut hash = 1_125_899_906_842_597u64;
    // rust: for value in k.iter() {
    // rust: hash = hash
    // rust: .wrapping_mul(31)
    // rust: .wrapping_add(u64::from(value.to_bits()));
}
    // rust: assert_eq!(hash, 0xb44d_13f8_c3d9_8c65);
}
}
