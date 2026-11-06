//! Transpiled from Horizon Rust crate
package horizon_world_foliage

import "core:fmt"
import "core:mem"
import "core:math"

// Foliage placers (FoliagePlacer subclasses), in native random-draw order.
// use super::{
    // rust: Layer, Run, TreeDecoder, TreeFeature, TreeResult, kind, read, sample_state, unit_float,
}
// use crate::worldgen::{
    // rust: DecodeError, Object,
    // rust: feature::FeatureWorld,
    // rust: int_range,
    // rust: placement::PlacementContext,
    // rust: required,
    // rust: tree_blocks::{self as tb, Axis},
    // rust: value_provider::IntProvider,
}
// use horizon_core::{geometry::Direction, random::RandomSource};
// use serde_json::value::RawValue;

    // rust: pub(crate) struct FoliageAttachment {
    // rust: pub pos: [i32; 3],
    // rust: pub radius_offset: i32,
    // rust: pub height_offset: i32,
    // rust: size: [i32; 2],
}
    // rust: impl FoliageAttachment {
    // rust: pub(crate) fn new(pos: [i32; 3], radius_offset: i32, double_trunk: bool) -> Self {
    // rust: let size = if double_trunk { 2 } else { 1 };
    // rust: Self {
    // rust: pos,
    // rust: radius_offset,
    // rust: height_offset: 0,
    // rust: size: [size; 2],
}
}
double_trunk :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.size == [2, 2]
}
}

Kind :: enum {
    Blob(i32),
    Fancy(i32),
    Bush(i32),
    Acacia,
    Spruce(IntProvider),
    Pine(IntProvider),
    MegaPine(IntProvider),
    MegaJungle(i32),
    DarkOak,
    RandomSpread {,
    foliage_height: IntProvider,
    attempts: i32,
    // rust: },
    Cherry {,
    height: IntProvider,
    wide_bottom_hole: f32,
    corner_hole: f32,
    hanging: f32,
    hanging_extension: f32,
    // rust: },
    Poplar {,
    height: IntProvider,
    side_hole: f32,
    // rust: },
}
    // rust: pub(super) struct FoliagePlacer {
    // rust: radius: IntProvider,
    // rust: offset: IntProvider,
    // rust: kind: Kind,
}

abs :: proc(v: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: v.wrapping_abs()
}

    // rust: impl FoliagePlacer {
    // rust: pub(super) fn decode(
    // rust: raw: &RawValue,
    // rust: decoder: &mut TreeDecoder<'_, '_>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let object: Object = serde_json::from_str(raw.get())?;
    // rust: let radius = decoder.int_provider(required(&object, "radius")?, 0, 16)?;
    // rust: let offset = decoder.int_provider(required(&object, "offset")?, 0, 16)?;
    // rust: let fixed_height = || int_range(required(&object, "height")?, "foliage height", 0, 16);
    // rust: let chance = |name: &'static str| unit_float(required(&object, name)?, name);
    // rust: let kind = match kind(&object)?.as_str() {
    // rust: "minecraft:blob_foliage_placer" => Kind::Blob(fixed_height()?),
    // rust: "minecraft:fancy_foliage_placer" => Kind::Fancy(fixed_height()?),
    // rust: "minecraft:bush_foliage_placer" => Kind::Bush(fixed_height()?),
    // rust: "minecraft:jungle_foliage_placer" => Kind::MegaJungle(fixed_height()?),
    // rust: "minecraft:acacia_foliage_placer" => Kind::Acacia,
    // rust: "minecraft:dark_oak_foliage_placer" => Kind::DarkOak,
    // rust: "minecraft:spruce_foliage_placer" => {
    // rust: Kind::Spruce(decoder.int_provider(required(&object, "trunk_height")?, 0, 24)?)
}
    // rust: "minecraft:pine_foliage_placer" => {
    // rust: Kind::Pine(decoder.int_provider(required(&object, "height")?, 0, 24)?)
}
    // rust: "minecraft:mega_pine_foliage_placer" => {
    // rust: Kind::MegaPine(decoder.int_provider(required(&object, "crown_height")?, 0, 24)?)
}
    // rust: "minecraft:random_spread_foliage_placer" => Kind::RandomSpread {
    // rust: foliage_height: decoder.int_provider(
    // rust: required(&object, "foliage_height")?,
    // rust: 1,
    // rust: 512,
    // rust: )?,
    // rust: attempts: int_range(
    // rust: required(&object, "leaf_placement_attempts")?,
    // rust: "leaf_placement_attempts",
    // rust: 0,
    // rust: 256,
    // rust: )?,
    // rust: },
    // rust: "minecraft:cherry_foliage_placer" => Kind::Cherry {
    // rust: height: decoder.int_provider(required(&object, "height")?, 4, 16)?,
    // rust: wide_bottom_hole: chance("wide_bottom_layer_hole_chance")?,
    // rust: corner_hole: chance("corner_hole_chance")?,
    // rust: hanging: chance("hanging_leaves_chance")?,
    // rust: hanging_extension: chance("hanging_leaves_extension_chance")?,
    // rust: },
    // rust: "minecraft:poplar_foliage_placer" => Kind::Poplar {
    // rust: height: decoder.int_provider(required(&object, "height")?, 5, 16)?,
    // rust: side_hole: chance("side_hole_chance")?,
    // rust: },
    // rust: _ => return Err(DecodeError::Field("foliage placer type")),
}
    // rust: Ok(Self {
    // rust: radius,
    // rust: offset,
    // rust: kind,
    // rust: })
}
    // rust: pub(super) fn foliage_height<E>(
    // rust: &self,
    // rust: random: &mut impl RandomSource,
    // rust: tree_height: i32,
    // rust: ) -> TreeResult<i32, E> {
    // rust: Ok(match &self.kind {
    // rust: Kind::Blob(h) | Kind::Fancy(h) | Kind::Bush(h) | Kind::MegaJungle(h) => *h,
    // rust: Kind::Acacia => 0,
    // rust: Kind::DarkOak => 4,
    // rust: Kind::Spruce(trunk) => 4.max(tree_height - trunk.sample(random)?),
    // rust: Kind::Pine(h) | Kind::MegaPine(h) => h.sample(random)?,
    // rust: Kind::RandomSpread { foliage_height, .. } => foliage_height.sample(random)?,
    // rust: Kind::Cherry { height, .. } | Kind::Poplar { height, .. } => height.sample(random)?,
    // rust: })
}
    // rust: pub(super) fn foliage_radius<E>(
    // rust: &self,
    // rust: random: &mut impl RandomSource,
    // rust: trunk_height: i32,
    // rust: ) -> TreeResult<i32, E> {
    // rust: let radius = self.radius.sample(random)?;
    // rust: if matches!(self.kind, Kind::Pine(_)) {
    // rust: return Ok(radius + random.next_int_bound(trunk_height.wrapping_add(1).max(1))?);
}
    // rust: Ok(radius)
}

    // shouldSkipLocation with already-unsigned offsets.
    // rust: fn skip(
    // rust: &self,
    // rust: random: &mut impl RandomSource,
    // rust: dx: i32,
    // rust: y: i32,
    // rust: dz: i32,
    // rust: r: i32,
    // rust: double: bool,
    // rust: ) -> Result<bool, horizon_core::random::InvalidBound> {
    // rust: Ok(match &self.kind {
    // rust: Kind::Blob(_) => dx == r && dz == r && (random.next_int_bound(2)? == 0 || y == 0),
    // rust: Kind::Bush(_) => dx == r && dz == r && random.next_int_bound(2)? == 0,
    // rust: Kind::Fancy(_) => {
    // rust: let a = dx as f32 + 0.5;
    // rust: let b = dz as f32 + 0.5;
    // rust: a * a + b * b > r.wrapping_mul(r) as f32
}
    // rust: Kind::Acacia => {
    // rust: if y == 0 {
    // rust: (dx > 1 || dz > 1) && dx != 0 && dz != 0
    // rust: } else {
    // rust: dx == r && dz == r && r > 0
}
}
    // rust: Kind::Spruce(_) | Kind::Pine(_) => dx == r && dz == r && r > 0,
    // rust: Kind::MegaPine(_) | Kind::MegaJungle(_) => {
    // rust: dx.wrapping_add(dz) >= 7
    // rust: || dx.wrapping_mul(dx).wrapping_add(dz.wrapping_mul(dz)) > r.wrapping_mul(r)
}
    // rust: Kind::DarkOak => {
    // rust: if y == -1 && !double {
    // rust: dx == r && dz == r
    // rust: } else if y == 1 {
    // rust: dx.wrapping_add(dz) > r.wrapping_mul(2).wrapping_sub(2)
    // rust: } else {
    // rust: false
}
}
    // rust: Kind::RandomSpread { .. } => false,
    // rust: Kind::Cherry {
    // rust: wide_bottom_hole,
    // rust: corner_hole,
    // rust: ..
    // rust: } => {
    // rust: if y == -1 && (dx == r || dz == r) && random.next_float() < *wide_bottom_hole {
    // rust: return Ok(true);
}
    // rust: let corner = dx == r && dz == r;
    // rust: if r > 2 {
    // rust: corner
    // rust: || (dx.wrapping_add(dz) > r.wrapping_mul(2).wrapping_sub(2)
    // rust: && random.next_float() < *corner_hole)
    // rust: } else {
    // rust: corner && random.next_float() < *corner_hole
}
}
    // rust: Kind::Poplar { .. } => unreachable!("poplar uses its own row placement"),
    // rust: })
}
    // rust: fn skip_signed(
    // rust: &self,
    // rust: random: &mut impl RandomSource,
    // rust: dx: i32,
    // rust: y: i32,
    // rust: dz: i32,
    // rust: r: i32,
    // rust: double: bool,
    // rust: ) -> Result<bool, horizon_core::random::InvalidBound> {
    // rust: if matches!(self.kind, Kind::DarkOak) {
    // rust: let defer = y != 0
    // rust: || !double
    // rust: || (dx != r.wrapping_neg() && dx < r)
    // rust: || (dz != r.wrapping_neg() && dz < r);
    // rust: if !defer {
    // rust: return Ok(true);
}
}
    // rust: let (mx, mz) = if double {
    // rust: (
    // rust: abs(dx).min(abs(dx.wrapping_sub(1))),
    // rust: abs(dz).min(abs(dz.wrapping_sub(1))),
    // rust: )
    // rust: } else {
    // rust: (abs(dx), abs(dz))
}
    // rust: self.skip(random, mx, y, mz, r, double)
}
    // rust: fn leaves_row<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: run: &mut Run<'_, W, R>,
    // rust: tree: &TreeFeature,
    // rust: origin: [i32; 3],
    // rust: r: i32,
    // rust: y: i32,
    // rust: double: bool,
    // rust: ) -> TreeResult<(), W::Error> {
    // rust: let offset = i32::from(double);
    // rust: let mut dx = r.wrapping_neg();
    // rust: while dx <= r.wrapping_add(offset) {
    // rust: let mut dz = r.wrapping_neg();
    // rust: while dz <= r.wrapping_add(offset) {
    // rust: if !self.skip_signed(run.random, dx, y, dz, r, double)? {
    // rust: tree.try_place_leaf(run, tb::offset(origin, dx, y, dz))?;
}
    // rust: dz += 1;
}
    // rust: dx += 1;
}
    // rust: Ok(())
}
    // rust: fn leaves_row_with_hanging<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: run: &mut Run<'_, W, R>,
    // rust: tree: &TreeFeature,
    // rust: origin: [i32; 3],
    // rust: r: i32,
    // rust: y: i32,
    // rust: double: bool,
    // rust: chance: f32,
    // rust: extension: f32,
    // rust: ) -> TreeResult<(), W::Error> {
    // rust: self.leaves_row(run, tree, origin, r, y, double)?;
    // rust: let offset = i32::from(double);
    // rust: let log = tb::offset(origin, 0, -1, 0);
    // rust: for along in tb::HORIZONTAL {
    // rust: let to_edge = tb::clockwise(along);
    // rust: let positive = matches!(to_edge, Direction::East | Direction::South);
    // rust: let to_edge_offset = if positive { r + offset } else { r };
    // rust: let mut pos = tb::relative(
    // rust: tb::relative(tb::offset(origin, 0, y - 1, 0), to_edge, to_edge_offset),
    // rust: along,
    // rust: r.wrapping_neg(),
    // rust: );
    // rust: let mut along_offset = r.wrapping_neg();
    // rust: while along_offset < r + offset {
    // rust: let above = run.foliage_contains(tb::offset(pos, 0, 1, 0));
    // rust: if above && Self::try_extension(run, tree, chance, log, pos)? {
    // rust: Self::try_extension(run, tree, extension, log, tb::offset(pos, 0, -1, 0))?;
}
    // rust: along_offset += 1;
    // rust: pos = tb::relative(pos, along, 1);
}
}
    // rust: Ok(())
}
    // rust: fn try_extension<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: run: &mut Run<'_, W, R>,
    // rust: tree: &TreeFeature,
    // rust: chance: f32,
    // rust: log: [i32; 3],
    // rust: pos: [i32; 3],
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: if tb::dist_manhattan(pos, log) >= 7 {
    // rust: return Ok(false);
}
    // rust: if run.random.next_float() > chance {
    // rust: return Ok(false);
}
    // rust: tree.try_place_leaf(run, pos)
}

    // rust: pub(super) fn create_foliage<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: run: &mut Run<'_, W, R>,
    // rust: tree: &TreeFeature,
    // rust: _tree_height: i32,
    // rust: attachment: FoliageAttachment,
    // rust: foliage_height: i32,
    // rust: leaf_radius: i32,
    // rust: ) -> TreeResult<(), W::Error> {
    // rust: let offset = self.offset.sample(run.random)?;
    // rust: let double = attachment.double_trunk();
    // rust: let pos = attachment.pos;
    // rust: let with_offset = foliage_height + attachment.height_offset;
    // rust: match &self.kind {
    // rust: Kind::Blob(_) => {
    // rust: let mut yo = offset;
    // rust: while yo >= offset - with_offset {
    // rust: let r = 0.max(leaf_radius + attachment.radius_offset - 1 - yo / 2);
    // rust: self.leaves_row(run, tree, pos, r, yo, double)?;
    // rust: yo -= 1;
}
}
    // rust: Kind::Fancy(_) => {
    // rust: let mut yo = offset;
    // rust: while yo >= offset - foliage_height {
    // rust: let r = leaf_radius + i32::from(yo != offset && yo != offset - foliage_height);
    // rust: self.leaves_row(run, tree, pos, r, yo, double)?;
    // rust: yo -= 1;
}
}
    // rust: Kind::Bush(_) => {
    // rust: let mut yo = offset;
    // rust: while yo >= offset - with_offset {
    // rust: let r = leaf_radius + attachment.radius_offset - 1 - yo;
    // rust: self.leaves_row(run, tree, pos, r, yo, double)?;
    // rust: yo -= 1;
}
}
    // rust: Kind::Acacia => {
    // rust: let p = tb::offset(pos, 0, offset, 0);
    // rust: self.leaves_row(
    // rust: run,
    // rust: tree,
    // rust: p,
    // rust: leaf_radius + attachment.radius_offset,
    // rust: -1 - with_offset,
    // rust: double,
    // rust: )?;
    // rust: self.leaves_row(run, tree, p, leaf_radius - 1, -with_offset, double)?;
    // rust: self.leaves_row(
    // rust: run,
    // rust: tree,
    // rust: p,
    // rust: leaf_radius + attachment.radius_offset - 1,
    // rust: 0,
    // rust: double,
    // rust: )?;
}
    // rust: Kind::Spruce(_) => {
    // rust: let mut r = run.random.next_int_bound(2)?;
    // rust: let mut max_r = 1;
    // rust: let mut min_r = 0;
    // rust: let mut yo = offset;
    // rust: while yo >= -with_offset {
    // rust: self.leaves_row(run, tree, pos, r, yo, double)?;
    // rust: if r >= max_r {
    // rust: r = min_r;
    // rust: min_r = 1;
    // rust: max_r = (max_r + 1).min(leaf_radius + attachment.radius_offset);
    // rust: } else {
    // rust: r += 1;
}
    // rust: yo -= 1;
}
}
    // rust: Kind::Pine(_) => {
    // rust: let mut r = 0;
    // rust: let mut yo = offset;
    // rust: while yo >= offset - with_offset {
    // rust: self.leaves_row(run, tree, pos, r, yo, double)?;
    // rust: if r >= 1 && yo == offset - with_offset + 1 {
    // rust: r -= 1;
    // rust: } else if r < leaf_radius + attachment.radius_offset {
    // rust: r += 1;
}
    // rust: yo -= 1;
}
}
    // rust: Kind::MegaPine(_) => {
    // rust: let mut previous = 0;
    // rust: let mut yy = pos[1] - with_offset + offset;
    // rust: while yy <= pos[1] + offset {
    // rust: let yo = pos[1] - yy;
    // rust: let smooth = leaf_radius
    // rust: .wrapping_add(attachment.radius_offset)
    // rust: .wrapping_add((yo as f32 / with_offset as f32 * 3.5f32).floor() as i32);
    // rust: let jagged = if yo > 0 && smooth == previous && (yy & 1) == 0 {
    // rust: smooth.wrapping_add(1)
    // rust: } else {
    // rust: smooth
}
    // rust: self.leaves_row(run, tree, [pos[0], yy, pos[2]], jagged, 0, double)?;
    // rust: previous = smooth;
    // rust: yy += 1;
}
}
    // rust: Kind::MegaJungle(_) => {
    // rust: let leaf_height = (if double {
    // rust: foliage_height
    // rust: } else {
    // rust: 1 + run.random.next_int_bound(2)?
    // rust: }) + attachment.height_offset;
    // rust: let mut yo = offset;
    // rust: while yo >= offset - leaf_height {
    // rust: let r = leaf_radius + attachment.radius_offset + 1 - yo;
    // rust: self.leaves_row(run, tree, pos, r, yo, double)?;
    // rust: yo -= 1;
}
}
    // rust: Kind::DarkOak => {
    // rust: let p = tb::offset(pos, 0, offset, 0);
    // rust: if double {
    // rust: self.leaves_row(run, tree, p, leaf_radius + 2, -1, double)?;
    // rust: self.leaves_row(run, tree, p, leaf_radius + 3, 0, double)?;
    // rust: self.leaves_row(run, tree, p, leaf_radius + 2, 1, double)?;
    // rust: if run.random.next_boolean() {
    // rust: self.leaves_row(run, tree, p, leaf_radius, 2, double)?;
}
    // rust: } else {
    // rust: self.leaves_row(run, tree, p, leaf_radius + 2, -1, double)?;
    // rust: self.leaves_row(run, tree, p, leaf_radius + 1, 0, double)?;
}
}
    // rust: Kind::RandomSpread { attempts, .. } => {
    // rust: for _ in 0..*attempts {
    // rust: let dx = run.random.next_int_bound(leaf_radius)?
    // rust: - run.random.next_int_bound(leaf_radius)?;
    // rust: let dy = run.random.next_int_bound(foliage_height)?
    // rust: - run.random.next_int_bound(foliage_height)?;
    // rust: let dz = run.random.next_int_bound(leaf_radius)?
    // rust: - run.random.next_int_bound(leaf_radius)?;
    // rust: tree.try_place_leaf(run, tb::offset(pos, dx, dy, dz))?;
}
}
    // rust: Kind::Cherry {
    // rust: hanging,
    // rust: hanging_extension,
    // rust: ..
    // rust: } => {
    // rust: let p = tb::offset(pos, 0, offset, 0);
    // rust: let r = leaf_radius + attachment.radius_offset - 1;
    // rust: self.leaves_row(run, tree, p, r - 2, with_offset - 3, double)?;
    // rust: self.leaves_row(run, tree, p, r - 1, with_offset - 4, double)?;
    // rust: let mut y = with_offset - 5;
    // rust: while y >= 0 {
    // rust: self.leaves_row(run, tree, p, r, y, double)?;
    // rust: y -= 1;
}
    // rust: self.leaves_row_with_hanging(
    // rust: run,
    // rust: tree,
    // rust: p,
    // rust: r,
    // rust: -1,
    // rust: double,
    // rust: *hanging,
    // rust: *hanging_extension,
    // rust: )?;
    // rust: self.leaves_row_with_hanging(
    // rust: run,
    // rust: tree,
    // rust: p,
    // rust: r - 1,
    // rust: -2,
    // rust: double,
    // rust: *hanging,
    // rust: *hanging_extension,
    // rust: )?;
}
    // rust: Kind::Poplar { side_hole, .. } => {
    // rust: let poplar = Poplar {
    // rust: side_hole: *side_hole,
    // rust: flip: run.random.next_boolean(),
    // rust: height: with_offset,
    // rust: double,
}
    // rust: let p = tb::offset(pos, 0, offset, 0);
    // rust: let r = leaf_radius + attachment.radius_offset - 1;
    // rust: poplar.row(run, tree, p, r - 2, with_offset - 1)?;
    // rust: poplar.row(run, tree, p, r - 1, with_offset - 2)?;
    // rust: poplar.row(run, tree, p, r - 1, with_offset - 3)?;
    // rust: let mut y = with_offset - 4;
    // rust: while y >= 1 {
    // rust: poplar.row(run, tree, p, r, y)?;
    // rust: y -= 1;
}
    // rust: poplar.replace_with_log(run, tree, p, r, with_offset - 4)?;
    // rust: poplar.row(run, tree, p, r - 1, 0)?;
    // rust: poplar.row(run, tree, p, (r - 2).clamp(1, 2), -1)?;
}
}
    // rust: Ok(())
}
}

Poplar :: struct {
    side_hole: f32,
    flip: bool,
    height: i32,
    double: bool,
}
    // rust: impl Poplar {
partial_row :: proc(self: ^Self, y: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.height - 1 == y || self.height - 2 == y
}
corner_cut :: proc(self: ^Self, dx: i32, dz: i32, r: i32, partial: bool) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let small = if self.flip {
    // rust: (dx > 0 && dz > 0) || (dz < 0 && dx < 0)
    // rust: } else {
    // rust: (dx > 0 && dz < 0) || (dz > 0 && dx < 0)
}
    // rust: if small {
    // rust: r - 1
    // rust: } else if partial {
    // rust: r + 1
    // rust: } else {
    // rust: r
}
}
within :: proc(r: i32, adx: i32, adz: i32, cut: i32, extra: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: adx.wrapping_add(adz) <= r.wrapping_mul(2).wrapping_sub(cut.wrapping_add(extra))
}
    // rust: fn skip(
    // rust: &self,
    // rust: random: &mut impl RandomSource,
    // rust: dx: i32,
    // rust: y: i32,
    // rust: dz: i32,
    // rust: r: i32,
    // rust: ) -> Result<bool, horizon_core::random::InvalidBound> {
    // rust: let partial = self.partial_row(y);
    // rust: let cut = self.corner_cut(dx, dz, r, partial);
    // rust: let (adx, adz) = (abs(dx), abs(dz));
    // rust: if partial && (adx == r || adz == r) {
    // rust: return Ok(true);
}
    // rust: let extra = i32::from(random.next_float() <= self.side_hole);
    // rust: Ok(!Self::within(r, adx, adz, cut, extra))
}
    // rust: fn row<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: run: &mut Run<'_, W, R>,
    // rust: tree: &TreeFeature,
    // rust: origin: [i32; 3],
    // rust: r: i32,
    // rust: y: i32,
    // rust: ) -> TreeResult<(), W::Error> {
    // rust: let offset = i32::from(self.double);
    // rust: let mut dx = r.wrapping_neg();
    // rust: while dx <= r + offset {
    // rust: let mut dz = r.wrapping_neg();
    // rust: while dz <= r + offset {
    // rust: if !self.skip(run.random, dx, y, dz, r)? {
    // rust: tree.try_place_leaf(run, tb::offset(origin, dx, y, dz))?;
}
    // rust: dz += 1;
}
    // rust: dx += 1;
}
    // rust: Ok(())
}
    // rust: fn replace_with_log<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: run: &mut Run<'_, W, R>,
    // rust: tree: &TreeFeature,
    // rust: origin: [i32; 3],
    // rust: r: i32,
    // rust: y: i32,
    // rust: ) -> TreeResult<(), W::Error> {
    // rust: let offset = i32::from(self.double);
    // rust: let mut dx = r.wrapping_neg();
    // rust: while dx <= r + offset {
    // rust: let mut dz = r.wrapping_neg();
    // rust: while dz <= r + offset {
    // rust: let (adx, adz) = (abs(dx), abs(dz));
    // rust: let cut = self.corner_cut(dx, dz, r, self.partial_row(y));
    // rust: if Self::within(r, adx, adz, cut, 2)
    // rust: && ((adz == 0 && r - adx >= 4) || (adx == 0 && r - adz >= 4))
    // rust: {
    // rust: let pos = tb::offset(origin, dx, y, dz);
    // rust: let axis = if adz == 0 { Axis::X } else { Axis::Z };
                    // The comparison state is sampled from the foliage provider.
    // rust: let here = read(run.world, pos)?;
    // rust: let foliage = sample_state(&tree.foliage_provider, run.world, run.random, pos)?;
    // rust: if here == foliage {
    // rust: let log = sample_state(&tree.trunk_provider, run.world, run.random, pos)?;
    // rust: run.set(Layer::Foliage, pos, tree.blocks.try_axis(log, axis))?;
}
}
    // rust: dz += 1;
}
    // rust: dx += 1;
}
    // rust: Ok(())
}
}
