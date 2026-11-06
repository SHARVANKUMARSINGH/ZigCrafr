//! Transpiled from Horizon Rust crate
//! Module: horizon-world_ore_feature
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Ore placement with ordered replacement rules and air-exposure checks.
// use super::{
    // rust: DecodeError, Object,
    // rust: block_feature::{BlockReplacements, FeatureBlockBindings, decode_targets},
    // rust: density::identifier,
    // rust: feature::{FeatureError, FeatureWorld},
    // rust: feature_graph::FeatureExecutionError,
    // rust: int_range, number_text,
    // rust: placement::PlacementContext,
    // rust: required,
}
// use crate::heightmap::HeightmapType;
// use crate::registry::BlockStateId;
// use horizon_core::{geometry::Direction, random::RandomSource};

pub const ScatteredOreFeature = struct {
    targets: BlockReplacements,
    size: i32,
    discard: f32,
    air: [BlockStateId,
};
    // rust: impl ScatteredOreFeature {
pub fn from_json(json: []const u8, bindings: *FeatureBlockBindings<'_>) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::decode(json, bindings, 0, &mut 65536)
}
    // rust: pub(crate) fn decode(
    // rust: json: &str,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: depth: usize,
    // rust: remaining: &mut usize,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: let kind = identifier(&serde_json::from_str::<String>(
    // rust: required(&object, "type")?.get(),
    // rust: )?)?;
    // rust: if kind != "minecraft:scattered_ore" {
    // rust: return Err(DecodeError::Field("scattered ore type"));
}
    // rust: let targets = decode_targets(&object, bindings, depth, remaining)?;
    // rust: let size = int_range(required(&object, "size")?, "ore size", 0, 64)?;
    // rust: let discard: f32 = number_text(required(&object, "discard_chance_on_air_exposure")?)?
    // rust: .parse()
    // rust: .map_err(|_| DecodeError::Field("ore air exposure"))?;
    // rust: if !(0.0..=1.0).contains(&discard) || discard.is_sign_negative() {
    // rust: return Err(DecodeError::Field("ore air exposure"));
}
    // rust: Ok(Self {
    // rust: targets,
    // rust: size,
    // rust: discard,
    // rust: air: bindings.air,
    // rust: })
}
    // rust: pub fn place<W: FeatureWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut impl RandomSource,
    // rust: origin: [i32; 3],
    // rust: ) -> Result<bool, FeatureError<W::Error>> {
    // rust: let count = random
    // rust: .next_int_bound(self.size + 1)
    // rust: .map_err(FeatureError::Random)?;
    // rust: for attempt in 0..count {
    // rust: let spread = attempt.min(7) as f32;
    // rust: let position = origin.map(|component| {
    // rust: let offset = (random.next_float() - random.next_float()) * spread;
                // Widen before adding 0.5 so a float just below a tie cannot
                // round up during addition. Values are bounded by +/-7.
    // rust: let offset = (f64::from(offset) + 0.5).floor() as i32;
    // rust: component.wrapping_add(offset)
    // rust: });
    // rust: let current = world.block(position).map_err(FeatureError::World)?;
    // rust: for (rule, state) in &self.targets {
    // rust: if !rule.test(current, position, random) {
    // rust: continue;
}
    // rust: let skip_air = self.discard <= 0.0
    // rust: || (self.discard < 1.0 && random.next_float() >= self.discard);
    // rust: if !skip_air {
    // rust: let mut exposed = false;
    // rust: for direction in Direction::ALL {
    // rust: let delta = direction.normal();
    // rust: let neighbor = std::array::from_fn(|i| position[i].wrapping_add(delta[i]));
    // rust: if self
    // rust: .air
    // rust: .contains(&world.block(neighbor).map_err(FeatureError::World)?)
    // rust: {
    // rust: exposed = true;
    // rust: break;
}
}
    // rust: if exposed {
    // rust: continue;
}
}
    // rust: world
    // rust: .set_block(position, *state, 2)
    // rust: .map_err(FeatureError::World)?;
    // rust: break;
}
}
    // rust: Ok(true)
}
}

/// Vanilla `minecraft:ore`: an interpolated chain of spheres written straight
/// into chunk sections (BulkSectionAccess), bypassing block update effects.
pub const OreFeature = struct {
    targets: BlockReplacements,
    size: i32,
    discard: f32,
    air: [BlockStateId,
};
    // rust: impl OreFeature {
pub fn from_json(json: []const u8, bindings: *FeatureBlockBindings<'_>) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::decode(json, bindings, 0, &mut 65536)
}
    // rust: pub(crate) fn decode(
    // rust: json: &str,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: depth: usize,
    // rust: remaining: &mut usize,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: let kind = identifier(&serde_json::from_str::<String>(
    // rust: required(&object, "type")?.get(),
    // rust: )?)?;
    // rust: if kind != "minecraft:ore" {
    // rust: return Err(DecodeError::Field("ore type"));
}
    // rust: let targets = decode_targets(&object, bindings, depth, remaining)?;
    // rust: let size = int_range(required(&object, "size")?, "ore size", 0, 64)?;
    // rust: let discard: f32 = number_text(required(&object, "discard_chance_on_air_exposure")?)?
    // rust: .parse()
    // rust: .map_err(|_| DecodeError::Field("ore air exposure"))?;
    // rust: if !(0.0..=1.0).contains(&discard) || discard.is_sign_negative() {
    // rust: return Err(DecodeError::Field("ore air exposure"));
}
    // rust: Ok(Self {
    // rust: targets,
    // rust: size,
    // rust: discard,
    // rust: air: bindings.air,
    // rust: })
}
    // rust: pub fn place<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut impl RandomSource,
    // rust: origin: [i32; 3],
    // rust: ) -> Result<bool, FeatureExecutionError<W::Error>> {
    // rust: let dir = random.next_float() * std::f32::consts::PI;
    // rust: let spread_xy = self.size as f32 / 8.0;
    // rust: let max_radius = ((self.size as f32 / 16.0 * 2.0 + 1.0) / 2.0).ceil() as i32;
    // rust: let (ox, oz) = (f64::from(origin[0]), f64::from(origin[2]));
    // rust: let (sin, cos) = (
    // rust: horizon_core::jmath::sin(f64::from(dir)),
    // rust: horizon_core::jmath::cos(f64::from(dir)),
    // rust: );
    // rust: let spread = f64::from(spread_xy);
    // rust: let x0 = ox + sin * spread;
    // rust: let x1 = ox - sin * spread;
    // rust: let z0 = oz + cos * spread;
    // rust: let z1 = oz - cos * spread;
    // rust: let y0 = f64::from(
    // rust: origin[1]
    // rust: .wrapping_add(random.next_int_bound(3)?)
    // rust: .wrapping_sub(2),
    // rust: );
    // rust: let y1 = f64::from(
    // rust: origin[1]
    // rust: .wrapping_add(random.next_int_bound(3)?)
    // rust: .wrapping_sub(2),
    // rust: );
    // rust: let spread_ceil = spread.ceil() as i32;
    // rust: let x_start = origin[0].wrapping_sub(spread_ceil).wrapping_sub(max_radius);
    // rust: let y_start = origin[1].wrapping_sub(2).wrapping_sub(max_radius);
    // rust: let z_start = origin[2].wrapping_sub(spread_ceil).wrapping_sub(max_radius);
    // rust: let size_xz = 2 * (spread_ceil + max_radius);
    // rust: let size_y = 2 * (2 + max_radius);
    // rust: if let Some(found) = world
    // rust: .any_height_at_least(
    // rust: HeightmapType::OceanFloorWg,
    // rust: [x_start, z_start],
    // rust: size_xz,
    // rust: y_start,
    // rust: )
    // rust: .map_err(FeatureExecutionError::Query)?
    // rust: {
    // rust: return match found {
    // rust: true => self.do_place(
    // rust: world,
    // rust: random,
    // rust: [x0, x1, z0, z1, y0, y1],
    // rust: [x_start, y_start, z_start],
    // rust: size_xz,
    // rust: size_y,
    // rust: ),
    // rust: false => Ok(false),
}
}
    // rust: for x in 0..=size_xz {
    // rust: for z in 0..=size_xz {
    // rust: let (px, pz) = (x_start.wrapping_add(x), z_start.wrapping_add(z));
    // rust: let floor = world
    // rust: .height(HeightmapType::OceanFloorWg, px, pz)
    // rust: .map_err(FeatureExecutionError::Query)?;
    // rust: if y_start <= floor {
    // rust: return self.do_place(
    // rust: world,
    // rust: random,
    // rust: [x0, x1, z0, z1, y0, y1],
    // rust: [x_start, y_start, z_start],
    // rust: size_xz,
    // rust: size_y,
    // rust: );
}
}
}
    // rust: Ok(false)
}
    // rust: fn do_place<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut impl RandomSource,
    // rust: [x0, x1, z0, z1, y0, y1]: [f64; 6],
    // rust: [x_start, y_start, z_start]: [i32; 3],
    // rust: size_xz: i32,
    // rust: size_y: i32,
    // rust: ) -> Result<bool, FeatureExecutionError<W::Error>> {
    // rust: let size = self.size as usize;
    // rust: let mut data = vec![[0f64; 4]; size];
    // rust: for (i, entry) in data.iter_mut().enumerate() {
    // rust: let step = i as f32 / self.size as f32;
    // rust: let step64 = f64::from(step);
    // rust: let xx = x0 + step64 * (x1 - x0);
    // rust: let yy = y0 + step64 * (y1 - y0);
    // rust: let zz = z0 + step64 * (z1 - z0);
    // rust: let ss = random.next_double() * f64::from(self.size) / 16.0;
    // rust: let sine = horizon_core::geometry::trig::sin(f64::from(std::f32::consts::PI * step));
    // rust: let r = (f64::from(sine + 1.0) * ss + 1.0) / 2.0;
    // rust: *entry = [xx, yy, zz, r];
}
    // rust: for i1 in 0..size.saturating_sub(1) {
    // rust: if data[i1][3] <= 0.0 {
    // rust: continue;
}
    // rust: for i2 in i1 + 1..size {
    // rust: if data[i2][3] <= 0.0 {
    // rust: continue;
}
    // rust: let dx = data[i1][0] - data[i2][0];
    // rust: let dy = data[i1][1] - data[i2][1];
    // rust: let dz = data[i1][2] - data[i2][2];
    // rust: let dr = data[i1][3] - data[i2][3];
    // rust: if dr * dr > dx * dx + dy * dy + dz * dz {
    // rust: if dr > 0.0 {
    // rust: data[i2][3] = -1.0;
    // rust: } else {
    // rust: data[i1][3] = -1.0;
}
}
}
}
    // rust: let tested_len = (size_xz as usize) * (size_y as usize) * (size_xz as usize);
    // rust: let mut tested = vec![0u64; tested_len.div_ceil(64)];
    // rust: let mut placed = 0;
    // rust: let mut squares = SphereSquares::default();
    // rust: for sphere in data {
    // rust: if sphere[3] < 0.0 {
    // rust: continue;
}
    // rust: squares.each_cell(sphere, [x_start, y_start, z_start], |[x, y, z]| {
    // rust: if world
    // rust: .outside_build_height(y)
    // rust: .map_err(FeatureExecutionError::Query)?
    // rust: {
    // rust: return Ok(());
}
    // rust: let index = i64::from(x.wrapping_sub(x_start))
    // rust: + i64::from(y.wrapping_sub(y_start)) * i64::from(size_xz)
    // rust: + i64::from(z.wrapping_sub(z_start)) * i64::from(size_xz) * i64::from(size_y);
                // The sphere bounds keep indices inside the native BitSet.
    // rust: let Some(index) = usize::try_from(index).ok().filter(|&i| i < tested_len) else {
    // rust: return Err(FeatureExecutionError::WorkLimit);
}
    // rust: let (word, bit) = (&mut tested[index / 64], 1u64 << (index % 64));
    // rust: if *word & bit != 0 {
    // rust: return Ok(());
}
    // rust: *word |= bit;
    // rust: let p = [x, y, z];
    // rust: if !world
    // rust: .ensure_can_write(p)
    // rust: .map_err(FeatureExecutionError::Query)?
    // rust: {
    // rust: return Ok(());
}
    // rust: let Some(state) = world
    // rust: .section_block(p)
    // rust: .map_err(FeatureExecutionError::Query)?
    // rust: else {
    // rust: return Ok(());
}
    // rust: for (rule, target) in &self.targets {
    // rust: if !rule.test(state, p, random) {
    // rust: continue;
}
    // rust: if !skip_air_check(random, self.discard) {
    // rust: let mut exposed = false;
    // rust: for direction in Direction::ALL {
    // rust: let n = direction.normal();
    // rust: let q = std::array::from_fn(|i| p[i].wrapping_add(n[i]));
    // rust: let neighbor = world
    // rust: .section_block(q)
    // rust: .map_err(FeatureExecutionError::Query)?
    // rust: .unwrap_or(self.air[0]);
    // rust: if self.air.contains(&neighbor) {
    // rust: exposed = true;
    // rust: break;
}
}
    // rust: if exposed {
    // rust: continue;
}
}
    // rust: world
    // rust: .set_section_block(p, *target)
    // rust: .map_err(FeatureExecutionError::Query)?;
    // rust: placed += 1;
    // rust: break;
}
    // rust: Ok(())
    // rust: })?;
}
    // rust: Ok(placed > 0)
}
}
/// The cells OreFeature.doPlace tests for one sphere `[x, y, z, r]` of a
/// blob: those of the sphere's box (clamped below to the blob's `start`)
/// whose `xd * xd + yd * yd + zd * zd` is under 1, in vanilla's x, y, z order.
///
/// Along one axis, `d * d` depends on that coordinate alone, so each axis's
/// squares are worked out once per sphere with vanilla's expression, and
/// every sum is bit for bit vanilla's. Along an axis the squares fall and then
/// rise (each step rounds a monotonic function, as does adding a fixed sum),
/// so the cells of a row that pass form one run around the smallest square:
/// it is found from there outwards, and the cells outside the sphere are
/// never visited.
pub const SphereSquares = struct {
    axes: [std.ArrayList(f64),
};
    // rust: impl SphereSquares {
    // rust: fn each_cell<E>(
    // rust: &mut self,
    // rust: [xx, yy, zz, r]: [f64; 4],
    // rust: start: [i32; 3],
    // rust: mut cell: impl FnMut([i32; 3]) -> Result<(), E>,
    // rust: ) -> Result<(), E> {
    // rust: let centre = [xx, yy, zz];
    // rust: let mut from = [0; 3];
    // rust: let mut lowest = [0; 3];
    // rust: for axis in 0..3 {
    // rust: let low = ((centre[axis] - r).floor() as i32).max(start[axis]);
    // rust: let high = ((centre[axis] + r).floor() as i32).max(low);
    // rust: let squares = &mut self.axes[axis];
    // rust: squares.clear();
    // rust: squares.extend((low..=high).map(|v| {
    // rust: let d = (f64::from(v) + 0.5 - centre[axis]) / r;
    // rust: d * d
    // rust: }));
    // rust: from[axis] = low;
    // rust: lowest[axis] = (0..squares.len())
    // rust: .min_by(|&a, &b| squares[a].total_cmp(&squares[b]))
    // rust: .unwrap_or(0);
}
    // rust: let [xs, ys, zs] = &self.axes;
        // Vanilla's `xd * xd >= 1.0` is `0.0 + xd * xd >= 1.0`: a square is
        // never negative zero, and adding zero to it rounds nothing.
    // rust: let Some((x_low, x_high)) = pass_run(xs, lowest[0], 0.0) else {
    // rust: return Ok(());
}
    // rust: for i in x_low..=x_high {
    // rust: let xd2 = xs[i];
    // rust: let Some((y_low, y_high)) = pass_run(ys, lowest[1], xd2) else {
    // rust: continue;
}
    // rust: for j in y_low..=y_high {
    // rust: let xy = xd2 + ys[j];
    // rust: let Some((z_low, z_high)) = pass_run(zs, lowest[2], xy) else {
    // rust: continue;
}
    // rust: for k in z_low..=z_high {
    // rust: cell([from[0] + i as i32, from[1] + j as i32, from[2] + k as i32])?;
}
}
}
    // rust: Ok(())
}
}
/// The run of `squares` around index `lowest` (a smallest one) where vanilla's
/// `base + square >= 1.0` fails, or None when even the smallest reaches 1.
/// The sums are never NaN (a sphere's radius is at least 0.5), so failing
/// that test is being under 1.
pub fn pass_run(squares: *[f64], lowest: usize, base: f64) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let passes = |i: usize| base + squares[i] < 1.0;
    // rust: if !passes(lowest) {
    // rust: return None;
}
    // rust: let (mut low, mut high) = (lowest, lowest);
    // rust: while low > 0 && passes(low - 1) {
    // rust: low -= 1;
}
    // rust: while high + 1 < squares.len() && passes(high + 1) {
    // rust: high += 1;
}
    // rust: Some((low, high))
}
pub fn skip_air_check(random: *mut impl RandomSource, discard: f32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if discard <= 0.0 {
    // rust: true
    // rust: } else if discard >= 1.0 {
    // rust: false
    // rust: } else {
    // rust: random.next_float() >= discard
}
}

    // rust: mod tests {
//     use super::SphereSquares;

    /// OreFeature.doPlace's loops over one sphere's whole box, as vanilla
    /// writes them: the cells it goes on to test.
pub fn box_scan(r]: [f64; 4], z_start]: [i32; 3]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let x_min = ((xx - r).floor() as i32).max(x_start);
    // rust: let y_min = ((yy - r).floor() as i32).max(y_start);
    // rust: let z_min = ((zz - r).floor() as i32).max(z_start);
    // rust: let x_max = ((xx + r).floor() as i32).max(x_min);
    // rust: let y_max = ((yy + r).floor() as i32).max(y_min);
    // rust: let z_max = ((zz + r).floor() as i32).max(z_min);
    // rust: let mut cells = Vec::new();
    // rust: for x in x_min..=x_max {
    // rust: let xd = (f64::from(x) + 0.5 - xx) / r;
    // rust: if xd * xd >= 1.0 {
    // rust: continue;
}
    // rust: for y in y_min..=y_max {
    // rust: let yd = (f64::from(y) + 0.5 - yy) / r;
    // rust: if xd * xd + yd * yd >= 1.0 {
    // rust: continue;
}
    // rust: for z in z_min..=z_max {
    // rust: let zd = (f64::from(z) + 0.5 - zz) / r;
    // rust: if xd * xd + yd * yd + zd * zd >= 1.0 {
    // rust: continue;
}
    // rust: cells.push([x, y, z]);
}
}
}
    // rust: cells
}

pub fn a_sphere_visits_exactly_the_cells_vanillas_box_scan_tests() void {
}
        // SplitMix64: any fixed spread of spheres will do.
    // rust: let mut seed = 0x9e37_79b9_7f4a_7c15_u64;
    // rust: let mut unit = move || {
    // rust: seed = seed.wrapping_add(0x9e37_79b9_7f4a_7c15);
    // rust: let mut z = seed;
    // rust: z = (z ^ (z >> 30)).wrapping_mul(0xbf58_476d_1ce4_e5b9);
    // rust: z = (z ^ (z >> 27)).wrapping_mul(0x94d0_49bb_1331_11eb);
    // rust: ((z ^ (z >> 31)) >> 11) as f64 / (1_u64 << 53) as f64
}
    // rust: let mut squares = SphereSquares::default();
    // rust: let mut visited = 0;
    // rust: for _ in 0..20_000 {
            // Centres and radii on whole and half blocks put cells exactly on
            // the sphere's edge, where a sum is exactly 1.
    // rust: let mut sphere = [0.0; 4];
    // rust: let r = 0.5 + unit() * 4.0;
    // rust: sphere[3] = if unit() < 0.3 {
    // rust: (r * 2.0).round() / 2.0
    // rust: } else {
    // rust: r
}
    // rust: let mut start = [0; 3];
    // rust: for axis in 0..3 {
    // rust: let c = (unit() - 0.5) * 80_000.0;
    // rust: sphere[axis] = match (unit() * 3.0) as u32 {
    // rust: 0 => c.floor(),
    // rust: 1 => c.floor() + 0.5,
    // rust: _ => c,
}
                // Sometimes the blob's start cuts the sphere's box.
    // rust: start[axis] = (sphere[axis] - sphere[3]).floor() as i32 + (unit() * 5.0) as i32 - 1;
}
    // rust: let mut cells = Vec::new();
    // rust: squares
    // rust: .each_cell::<()>(sphere, start, |p| {
    // rust: cells.push(p);
    // rust: Ok(())
    // rust: })
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: cells,
    // rust: box_scan(sphere, start),
    // rust: "sphere {sphere:?}, start {start:?}"
    // rust: );
    // rust: visited += cells.len();
}
    // rust: assert!(visited > 100_000, "only {visited} cells");
}
}
