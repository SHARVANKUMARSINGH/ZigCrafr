//! Transpiled from Horizon Rust crate
//! Module: horizon-world_iceberg
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Vanilla `minecraft:iceberg`, with native float/double rounding and the
//! short-circuited random draws of IcebergFeature.
// use super::{
    // rust: DecodeError, Object,
    // rust: block_feature::FeatureBlockBindings,
    // rust: feature::FeatureWorld,
    // rust: placement::PlacementContext,
    // rust: required,
    // rust: tree::{TreeResult, kind, read, write},
    // rust: tree_blocks::{self as tb, TreeBlocks},
}
// use crate::registry::BlockStateId;
// use horizon_core::random::RandomSource;
// use std::sync::Arc;

pub const IcebergFeature = struct {
    state: BlockStateId,
    blocks: *TreeBlocks,
    air: BlockStateId,
    water: BlockStateId,
    snow_block: BlockStateId,
    ice: BlockStateId,
    packed_ice: BlockStateId,
    blue_ice: BlockStateId,
    snow: BlockStateId,
};
pub fn ceil(v: f32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: f64::from(v).ceil() as i32
}
pub fn pow2(v: i32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: horizon_core::jmath::pow(f64::from(v), 2.0)
}
    // rust: impl IcebergFeature {
    // rust: pub(crate) fn decode(
    // rust: json: &str,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: if kind(&object)? != "minecraft:iceberg" {
    // rust: return Err(DecodeError::Field("iceberg type"));
}
    // rust: let state = bindings
    // rust: .codec
    // rust: .decode(required(&object, "state")?.get(), false)
    // rust: .map_err(|e| DecodeError::Registry(e.to_string()))?;
    // rust: let registry = bindings.registry();
    // rust: let get = |name: &str| {
    // rust: registry
    // rust: .default_state(name)
    // rust: .ok_or_else(|| DecodeError::Registry(format!("missing iceberg block {name}")))
}
    // rust: Ok(Self {
    // rust: state,
    // rust: blocks: bindings.tree_blocks()?,
    // rust: air: get("minecraft:air")?,
    // rust: water: get("minecraft:water")?,
    // rust: snow_block: get("minecraft:snow_block")?,
    // rust: ice: get("minecraft:ice")?,
    // rust: packed_ice: get("minecraft:packed_ice")?,
    // rust: blue_ice: get("minecraft:blue_ice")?,
    // rust: snow: get("minecraft:snow")?,
    // rust: })
}
pub fn is(self: *Self, a: BlockStateId, b: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.blocks.same_block(a, b)
}
pub fn iceberg_state(self: *Self, s: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.is(s, self.packed_ice) || self.is(s, self.snow_block) || self.is(s, self.blue_ice)
}
    // rust: pub(crate) fn place<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut R,
    // rust: origin: [i32; 3],
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: let origin = [origin[0], world.generation().sea_level, origin[2]];
    // rust: let snow_on_top = random.next_double() > 0.7;
    // rust: let angle = random.next_double() * 2.0 * std::f64::consts::PI;
    // rust: let ellipse_a = 11 - random.next_int_bound(5)?;
    // rust: let ellipse_c = 3 + random.next_int_bound(3)?;
    // rust: let is_ellipse = random.next_double() > 0.7;
    // rust: let mut over = if is_ellipse {
    // rust: random.next_int_bound(6)? + 6
    // rust: } else {
    // rust: random.next_int_bound(15)? + 3
}
    // rust: if !is_ellipse && random.next_double() > 0.9 {
    // rust: over += random.next_int_bound(19)? + 7;
}
    // rust: let under = (over + random.next_int_bound(11)?).min(18);
    // rust: let width = (over + random.next_int_bound(7)? - random.next_int_bound(5)?).min(11);
    // rust: let a = if is_ellipse { ellipse_a } else { 11 };
    // rust: for xo in -a..a {
    // rust: for zo in -a..a {
    // rust: for y in 0..over {
    // rust: let radius = if is_ellipse {
    // rust: let scale =
    // rust: (1.0f32 - pow2(y) as f32 / (over as f32 * 1.0f32)) * width as f32;
    // rust: ceil(scale / 2.0)
    // rust: } else {
    // rust: self.radius_round(random, y, over, width)?
}
    // rust: if is_ellipse || xo < radius {
    // rust: self.generate_block(
    // rust: world,
    // rust: random,
    // rust: origin,
    // rust: over,
    // rust: xo,
    // rust: y,
    // rust: zo,
    // rust: radius,
    // rust: a,
    // rust: is_ellipse,
    // rust: ellipse_c,
    // rust: angle,
    // rust: snow_on_top,
    // rust: )?;
}
}
}
}
    // rust: self.smooth(world, origin, width, over, is_ellipse, ellipse_a)?;
    // rust: for xo in -a..a {
    // rust: for zo in -a..a {
    // rust: let mut y = -1;
    // rust: while y > -under {
    // rust: let new_a = if is_ellipse {
    // rust: ceil(a as f32 * (1.0f32 - pow2(y) as f32 / (under as f32 * 8.0f32)))
    // rust: } else {
    // rust: a
}
    // rust: let radius = self.radius_steep(random, -y, under, width)?;
    // rust: if xo < radius {
    // rust: self.generate_block(
    // rust: world,
    // rust: random,
    // rust: origin,
    // rust: under,
    // rust: xo,
    // rust: y,
    // rust: zo,
    // rust: radius,
    // rust: new_a,
    // rust: is_ellipse,
    // rust: ellipse_c,
    // rust: angle,
    // rust: snow_on_top,
    // rust: )?;
}
    // rust: y -= 1;
}
}
}
    // rust: let cut_out = if is_ellipse {
    // rust: random.next_double() > 0.1
    // rust: } else {
    // rust: random.next_double() > 0.7
}
    // rust: if cut_out {
    // rust: self.cut_out(
    // rust: world, random, width, over, origin, is_ellipse, ellipse_a, angle, ellipse_c,
    // rust: )?;
}
    // rust: Ok(true)
}
    // rust: fn cut_out<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut R,
    // rust: width: i32,
    // rust: height: i32,
    // rust: origin: [i32; 3],
    // rust: is_ellipse: bool,
    // rust: ellipse_a: i32,
    // rust: angle: f64,
    // rust: ellipse_c: i32,
    // rust: ) -> TreeResult<(), W::Error> {
    // rust: let sign_x = if random.next_boolean() { -1 } else { 1 };
    // rust: let sign_z = if random.next_boolean() { -1 } else { 1 };
    // rust: let mut x_off = random.next_int_bound((width / 2 - 2).max(1))?;
    // rust: if random.next_boolean() {
    // rust: x_off = width / 2 + 1 - random.next_int_bound((width - width / 2 - 1).max(1))?;
}
    // rust: let mut z_off = random.next_int_bound((width / 2 - 2).max(1))?;
    // rust: if random.next_boolean() {
    // rust: z_off = width / 2 + 1 - random.next_int_bound((width - width / 2 - 1).max(1))?;
}
    // rust: if is_ellipse {
    // rust: x_off = random.next_int_bound((ellipse_a - 5).max(1))?;
    // rust: z_off = x_off;
}
    // rust: let local = [sign_x * x_off, 0, sign_z * z_off];
    // rust: let angle = if is_ellipse {
    // rust: angle + std::f64::consts::FRAC_PI_2
    // rust: } else {
    // rust: random.next_double() * 2.0 * std::f64::consts::PI
}
    // rust: for y in 0..height - 3 {
    // rust: let radius = self.radius_round(random, y, height, width)?;
    // rust: self.carve(
    // rust: world, radius, y, origin, false, angle, local, ellipse_a, ellipse_c,
    // rust: )?;
}
    // rust: let mut y = -1;
    // rust: while y > -height + random.next_int_bound(5)? {
    // rust: let radius = self.radius_steep(random, -y, height, width)?;
    // rust: self.carve(
    // rust: world, radius, y, origin, true, angle, local, ellipse_a, ellipse_c,
    // rust: )?;
    // rust: y -= 1;
}
    // rust: Ok(())
}
    // rust: fn carve<W: FeatureWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: radius: i32,
    // rust: y: i32,
    // rust: origin: [i32; 3],
    // rust: under_water: bool,
    // rust: angle: f64,
    // rust: local: [i32; 3],
    // rust: ellipse_a: i32,
    // rust: ellipse_c: i32,
    // rust: ) -> TreeResult<(), W::Error> {
    // rust: let a = radius + 1 + ellipse_a / 3;
    // rust: let c = (radius - 3).min(3) + ellipse_c / 2 - 1;
    // rust: for xo in -a..a {
    // rust: for zo in -a..a {
    // rust: if signed_ellipse(xo, zo, local, a, c, angle) < 0.0 {
    // rust: let p = tb::offset(origin, xo, y, zo);
    // rust: let state = read(world, p)?;
    // rust: if self.iceberg_state(state) || self.is(state, self.snow_block) {
    // rust: if under_water {
    // rust: write(world, p, self.water, 3)?;
    // rust: } else {
    // rust: write(world, p, self.air, 3)?;
    // rust: let above = tb::offset(p, 0, 1, 0);
    // rust: if self.is(read(world, above)?, self.snow) {
    // rust: write(world, above, self.air, 3)?;
}
}
}
}
}
}
    // rust: Ok(())
}
    // rust: fn generate_block<W: FeatureWorld, R: RandomSource>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut R,
    // rust: origin: [i32; 3],
    // rust: height: i32,
    // rust: xo: i32,
    // rust: y: i32,
    // rust: zo: i32,
    // rust: radius: i32,
    // rust: a: i32,
    // rust: is_ellipse: bool,
    // rust: ellipse_c: i32,
    // rust: angle: f64,
    // rust: snow_on_top: bool,
    // rust: ) -> TreeResult<(), W::Error> {
    // rust: let signed = if is_ellipse {
    // rust: let mut c = ellipse_c;
    // rust: if y > 0 && height - y <= 3 {
    // rust: c -= 4 - (height - y);
}
    // rust: signed_ellipse(xo, zo, [0; 3], a, c, angle)
    // rust: } else {
    // rust: let off = 10.0f32 * random.next_float().clamp(0.2, 0.8) / radius as f32;
    // rust: f64::from(off) + pow2(xo) + pow2(zo) - pow2(radius)
}
        // `signedDist < 0.0` fails for NaN too (a zero-width ellipse layer at its centre).
    // rust: if signed.is_nan() || signed >= 0.0 {
    // rust: return Ok(());
}
    // rust: let p = tb::offset(origin, xo, y, zo);
    // rust: let compare = if is_ellipse {
    // rust: -0.5
    // rust: } else {
    // rust: f64::from(-6 - random.next_int_bound(3)?)
}
    // rust: if signed > compare && random.next_double() > 0.9 {
    // rust: return Ok(());
}
    // rust: let h_diff = height - y;
    // rust: let state = read(world, p)?;
    // rust: if self.blocks.is_air(state)
    // rust: || self.is(state, self.snow_block)
    // rust: || self.is(state, self.ice)
    // rust: || self.is(state, self.water)
    // rust: {
    // rust: let randomness = !is_ellipse || random.next_double() > 0.05;
    // rust: let divisor = if is_ellipse { 3 } else { 2 };
    // rust: let snow = snow_on_top
    // rust: && !self.is(state, self.water)
    // rust: && f64::from(h_diff)
    // rust: <= f64::from(random.next_int_bound((height / divisor).max(1))?)
    // rust: + f64::from(height) * 0.6
    // rust: && randomness;
    // rust: write(world, p, if snow { self.snow_block } else { self.state }, 3)?;
}
    // rust: Ok(())
}
    // rust: fn radius_round<R: RandomSource, E>(
    // rust: &self,
    // rust: random: &mut R,
    // rust: y: i32,
    // rust: height: i32,
    // rust: width: i32,
    // rust: ) -> TreeResult<i32, E> {
    // rust: let k = 3.5f32 - random.next_float();
    // rust: let mut scale = (1.0f32 - pow2(y) as f32 / (height as f32 * k)) * width as f32;
    // rust: if height > 15 + random.next_int_bound(5)? {
    // rust: let temp = if y < 3 + random.next_int_bound(6)? {
    // rust: y / 2
    // rust: } else {
    // rust: y
}
    // rust: scale = (1.0f32 - temp as f32 / (height as f32 * k * 0.4f32)) * width as f32;
}
    // rust: Ok(ceil(scale / 2.0))
}
    // rust: fn radius_steep<R: RandomSource, E>(
    // rust: &self,
    // rust: random: &mut R,
    // rust: y: i32,
    // rust: height: i32,
    // rust: width: i32,
    // rust: ) -> TreeResult<i32, E> {
    // rust: let k = 1.0f32 + random.next_float() / 2.0;
    // rust: let scale = (1.0f32 - y as f32 / (height as f32 * k)) * width as f32;
    // rust: Ok(ceil(scale / 2.0))
}
    // rust: fn smooth<W: FeatureWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: origin: [i32; 3],
    // rust: width: i32,
    // rust: height: i32,
    // rust: is_ellipse: bool,
    // rust: ellipse_a: i32,
    // rust: ) -> TreeResult<(), W::Error> {
    // rust: let a = if is_ellipse { ellipse_a } else { width / 2 };
    // rust: for x in -a..=a {
    // rust: for z in -a..=a {
    // rust: for y in 0..=height {
    // rust: let p = tb::offset(origin, x, y, z);
    // rust: let state = read(world, p)?;
    // rust: if !(self.iceberg_state(state) || self.is(state, self.snow)) {
    // rust: continue;
}
    // rust: if self.blocks.is_air(read(world, tb::offset(p, 0, -1, 0))?) {
    // rust: write(world, p, self.air, 3)?;
    // rust: write(world, tb::offset(p, 0, 1, 0), self.air, 3)?;
    // rust: } else if self.iceberg_state(state) {
    // rust: let mut counter = 0;
    // rust: for (dx, dz) in [(-1, 0), (1, 0), (0, -1), (0, 1)] {
    // rust: if !self.iceberg_state(read(world, tb::offset(p, dx, 0, dz))?) {
    // rust: counter += 1;
}
}
    // rust: if counter >= 3 {
    // rust: write(world, p, self.air, 3)?;
}
}
}
}
}
    // rust: Ok(())
}
}
pub fn signed_ellipse(xo: i32, zo: i32, origin: [i32; 3], a: i32, c: i32, angle: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let dx = f64::from(xo - origin[0]);
    // rust: let dz = f64::from(zo - origin[2]);
    // rust: let (sin, cos) = (
    // rust: horizon_core::jmath::sin(angle),
    // rust: horizon_core::jmath::cos(angle),
    // rust: );
    // rust: horizon_core::jmath::pow((dx * cos - dz * sin) / f64::from(a), 2.0)
    // rust: + horizon_core::jmath::pow((dx * sin + dz * cos) / f64::from(c), 2.0)
    // rust: - 1.0
}
