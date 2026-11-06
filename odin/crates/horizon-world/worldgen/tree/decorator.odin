//! Transpiled from Horizon Rust crate
package horizon_world_decorator

import "core:fmt"
import "core:mem"
import "core:math"

// Tree decorators (TreeDecorator subclasses), in native random-draw order.
// use super::{
    // rust: Layer, NestedPlacer, Run, TreeDecoder, TreeResult, kind, read, sample_optional, sample_state,
    // rust: unit_float,
}
// use crate::heightmap::HeightmapType;
// use crate::registry::BlockStateId;
// use crate::worldgen::{
    // rust: DecodeError, Object,
    // rust: feature::FeatureWorld,
    // rust: feature_graph::{FeatureDefinition, FeatureExecutionError},
    // rust: int_range, optional,
    // rust: placement::PlacementContext,
    // rust: required,
    // rust: state_provider::BlockStateProvider,
    // rust: tree_blocks::{self as tb, TreeBlocks},
}
// use horizon_core::{geometry::Direction, random::RandomSource};
// use serde_json::value::RawValue;
// use std::collections::BTreeSet;

// Catalog-injected configured feature for the pale-moss ground patch, which
// vanilla looks up by registry key during decoration.
    // rust: pub(crate) const GROUND_FEATURE_KEY: &str = "horizon:pale_moss_patch";

// Decorator context lists: set iteration order, stably sorted by Y.
    // rust: pub(crate) struct Lists {
    // rust: pub logs: Vec<[i32; 3]>,
    // rust: pub leaves: Vec<[i32; 3]>,
    // rust: pub roots: Vec<[i32; 3]>,
}
    // rust: impl Lists {
    // rust: pub(crate) fn new(
    // rust: mut logs: Vec<[i32; 3]>,
    // rust: mut leaves: Vec<[i32; 3]>,
    // rust: mut roots: Vec<[i32; 3]>,
    // rust: ) -> Self {
    // rust: logs.sort_by_key(|p| p[1]);
    // rust: leaves.sort_by_key(|p| p[1]);
    // rust: roots.sort_by_key(|p| p[1]);
    // rust: Self {
    // rust: logs,
    // rust: leaves,
    // rust: roots,
}
}
    // TreeFeature.getLowestTrunkOrRootOfTree.
lowest :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: if self.roots.is_empty() {
    // rust: self.logs.clone()
    // rust: } else if !self.logs.is_empty() && self.roots[0][1] == self.logs[0][1] {
    // rust: let mut all = self.logs.clone();
    // rust: all.extend(&self.roots);
    // rust: all
    // rust: } else {
    // rust: self.roots.clone()
}
}
}

    // rust: pub(crate) enum TreeDecorator {
    // rust: TrunkVine,
    // rust: LeaveVine(f32),
    // rust: Cocoa(f32),
    // rust: Beehive(f32),
    // rust: AlterGround(BlockStateProvider),
    // rust: AttachedToLeaves {
    // rust: probability: f32,
    // rust: exclusion_xz: i32,
    // rust: exclusion_y: i32,
    // rust: provider: BlockStateProvider,
    // rust: required_empty: i32,
    // rust: directions: Vec<Direction>,
    // rust: },
    // rust: AttachedToLogs {
    // rust: probability: f32,
    // rust: provider: BlockStateProvider,
    // rust: directions: Vec<Direction>,
    // rust: },
    // rust: CreakingHeart(f32),
    // rust: PaleMoss {
    // rust: leaves: f32,
    // rust: trunk: f32,
    // rust: ground: f32,
    // rust: patch: Option<Box<FeatureDefinition>>,
    // rust: },
    // rust: PlaceOnGround {
    // rust: tries: i32,
    // rust: radius: i32,
    // rust: height: i32,
    // rust: provider: BlockStateProvider,
    // rust: },
    // rust: ShelfMushroom(f32),
}

directions :: proc(raw: ^RawValue) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let names: Vec<String> = serde_json::from_str(raw.get())?;
    // rust: if names.is_empty() || names.len() > 64 {
    // rust: return Err(DecodeError::Field("decorator directions"));
}
    // rust: names.iter().map(|n| tb::decode_direction(n)).collect()
}

    // rust: pub(crate) type NestedDecoder<'a> =
    // rust: dyn Fn(&str, usize, &mut usize) -> Result<FeatureDefinition, DecodeError> + 'a;

    // rust: impl TreeDecorator {
    // rust: pub(crate) fn decode_list(
    // rust: raw: &RawValue,
    // rust: decoder: &mut TreeDecoder<'_, '_>,
    // rust: ground: Option<&RawValue>,
    // rust: nested: &NestedDecoder<'_>,
    // rust: ) -> Result<Vec<Self>, DecodeError> {
    // rust: let values: Vec<Box<RawValue>> = serde_json::from_str(raw.get())?;
    // rust: if values.len() > 256 {
    // rust: return Err(DecodeError::Field("tree decorator count"));
}
    // rust: values
    // rust: .iter()
    // rust: .map(|raw| Self::decode(raw, decoder, ground, nested))
    // rust: .collect()
}
    // rust: fn decode(
    // rust: raw: &RawValue,
    // rust: decoder: &mut TreeDecoder<'_, '_>,
    // rust: ground: Option<&RawValue>,
    // rust: nested: &NestedDecoder<'_>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let object: Object = serde_json::from_str(raw.get())?;
    // rust: let probability = || unit_float(required(&object, "probability")?, "probability");
    // rust: Ok(match kind(&object)?.as_str() {
    // rust: "minecraft:trunk_vine" => Self::TrunkVine,
    // rust: "minecraft:leave_vine" => Self::LeaveVine(probability()?),
    // rust: "minecraft:cocoa" => Self::Cocoa(probability()?),
    // rust: "minecraft:beehive" => Self::Beehive(probability()?),
    // rust: "minecraft:creaking_heart" => Self::CreakingHeart(probability()?),
    // rust: "minecraft:shelf_mushroom" => Self::ShelfMushroom(probability()?),
    // rust: "minecraft:alter_ground" => {
    // rust: Self::AlterGround(decoder.provider(required(&object, "provider")?)?)
}
    // rust: "minecraft:attached_to_leaves" => Self::AttachedToLeaves {
    // rust: probability: probability()?,
    // rust: exclusion_xz: int_range(
    // rust: required(&object, "exclusion_radius_xz")?,
    // rust: "exclusion_radius_xz",
    // rust: 0,
    // rust: 16,
    // rust: )?,
    // rust: exclusion_y: int_range(
    // rust: required(&object, "exclusion_radius_y")?,
    // rust: "exclusion_radius_y",
    // rust: 0,
    // rust: 16,
    // rust: )?,
    // rust: provider: decoder.provider(required(&object, "block_provider")?)?,
    // rust: required_empty: int_range(
    // rust: required(&object, "required_empty_blocks")?,
    // rust: "required_empty_blocks",
    // rust: 1,
    // rust: 16,
    // rust: )?,
    // rust: directions: directions(required(&object, "directions")?)?,
    // rust: },
    // rust: "minecraft:attached_to_logs" => Self::AttachedToLogs {
    // rust: probability: probability()?,
    // rust: provider: decoder.provider(required(&object, "block_provider")?)?,
    // rust: directions: directions(required(&object, "directions")?)?,
    // rust: },
    // rust: "minecraft:pale_moss" => Self::PaleMoss {
    // rust: leaves: unit_float(
    // rust: required(&object, "leaves_probability")?,
    // rust: "leaves_probability",
    // rust: )?,
    // rust: trunk: unit_float(required(&object, "trunk_probability")?, "trunk_probability")?,
    // rust: ground: unit_float(
    // rust: required(&object, "ground_probability")?,
    // rust: "ground_probability",
    // rust: )?,
    // rust: patch: ground
    // rust: .map(|raw| nested(raw.get(), decoder.depth + 1, decoder.remaining))
    // rust: .transpose()?
    // rust: .map(Box::new),
    // rust: },
    // rust: "minecraft:place_on_ground" => Self::PlaceOnGround {
    // rust: tries: optional(&object, "tries")
    // rust: .map(|raw| int_range(raw, "tries", 1, i32::MAX))
    // rust: .transpose()?
    // rust: .unwrap_or(128),
    // rust: radius: optional(&object, "radius")
    // rust: .map(|raw| int_range(raw, "radius", 0, i32::MAX))
    // rust: .transpose()?
    // rust: .unwrap_or(2),
    // rust: height: optional(&object, "height")
    // rust: .map(|raw| int_range(raw, "height", 0, i32::MAX))
    // rust: .transpose()?
    // rust: .unwrap_or(1),
    // rust: provider: decoder.provider(required(&object, "block_state_provider")?)?,
    // rust: },
    // rust: _ => return Err(DecodeError::Field("tree decorator type")),
    // rust: })
}

    // rust: pub(crate) fn place<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: run: &mut Run<'_, W, R>,
    // rust: blocks: &TreeBlocks,
    // rust: lists: &Lists,
    // rust: nested: &mut NestedPlacer<'_, W, R>,
    // rust: ) -> TreeResult<(), W::Error> {
    // rust: let mut d = Decorate { run, blocks };
    // rust: match self {
    // rust: Self::TrunkVine => {
    // rust: for &pos in &lists.logs {
    // rust: for (direction, face) in [
    // rust: (Direction::West, "east"),
    // rust: (Direction::East, "west"),
    // rust: (Direction::North, "south"),
    // rust: (Direction::South, "north"),
    // rust: ] {
    // rust: if d.run.random.next_int_bound(3)? > 0 {
    // rust: let p = tb::relative(pos, direction, 1);
    // rust: if d.is_air(p)? {
    // rust: d.place_vine(p, face)?;
}
}
}
}
}
    // rust: Self::LeaveVine(probability) => {
    // rust: for &pos in &lists.leaves {
    // rust: for (direction, face) in [
    // rust: (Direction::West, "east"),
    // rust: (Direction::East, "west"),
    // rust: (Direction::North, "south"),
    // rust: (Direction::South, "north"),
    // rust: ] {
    // rust: if d.run.random.next_float() < *probability {
    // rust: let p = tb::relative(pos, direction, 1);
    // rust: if d.is_air(p)? {
    // rust: d.place_vine(p, face)?;
    // rust: let mut below = tb::offset(p, 0, -1, 0);
    // rust: let mut remaining = 4;
    // rust: while d.is_air(below)? && remaining > 0 {
    // rust: d.place_vine(below, face)?;
    // rust: below = tb::offset(below, 0, -1, 0);
    // rust: remaining -= 1;
}
}
}
}
}
}
    // rust: Self::Cocoa(probability) => {
    // rust: if d.run.random.next_float() >= *probability {
    // rust: return Ok(());
}
    // rust: let Some(first) = lists.logs.first() else {
    // rust: return Ok(());
}
    // rust: let tree_y = first[1];
    // rust: for &pos in lists.logs.iter().filter(|p| p[1].wrapping_sub(tree_y) <= 2) {
    // rust: for direction in tb::HORIZONTAL {
    // rust: if d.run.random.next_float() <= 0.25 {
    // rust: let n = direction.opposite().normal();
    // rust: let p = tb::offset(pos, n[0], 0, n[2]);
    // rust: if d.is_air(p)? {
    // rust: let age = d.run.random.next_int_bound(3)?;
    // rust: let state = d.default("minecraft:cocoa")?;
    // rust: let state = d.with(state, "age", &age.to_string())?;
    // rust: let state =
    // rust: d.with(state, "facing", tb::direction_name(direction))?;
    // rust: d.set(p, state)?;
}
}
}
}
}
    // rust: Self::Beehive(probability) => d.beehive(lists, *probability)?,
    // rust: Self::AlterGround(provider) => {
    // rust: let positions = lists.lowest();
    // rust: let Some(first) = positions.first() else {
    // rust: return Ok(());
}
    // rust: let min_y = first[1];
    // rust: for &pos in positions.iter().filter(|p| p[1] == min_y) {
    // rust: d.circle(provider, tb::offset(pos, -1, 0, -1))?;
    // rust: d.circle(provider, tb::offset(pos, 2, 0, -1))?;
    // rust: d.circle(provider, tb::offset(pos, -1, 0, 2))?;
    // rust: d.circle(provider, tb::offset(pos, 2, 0, 2))?;
    // rust: for _ in 0..5 {
    // rust: let placement = d.run.random.next_int_bound(64)?;
    // rust: let (xx, zz) = (placement % 8, placement / 8);
    // rust: if xx == 0 || xx == 7 || zz == 0 || zz == 7 {
    // rust: d.circle(provider, tb::offset(pos, -3 + xx, 0, -3 + zz))?;
}
}
}
}
    // rust: Self::AttachedToLeaves {
    // rust: probability,
    // rust: exclusion_xz,
    // rust: exclusion_y,
    // rust: provider,
    // rust: required_empty,
    // rust: directions,
    // rust: } => {
    // rust: let mut blacklist = BTreeSet::new();
    // rust: let mut leaves = lists.leaves.clone();
    // rust: tb::shuffle(&mut leaves, d.run.random)?;
    // rust: for leaf in leaves {
    // rust: let direction =
    // rust: directions[d.run.random.next_int_bound(directions.len() as i32)? as usize];
    // rust: let p = tb::relative(leaf, direction, 1);
    // rust: if blacklist.contains(&p) || d.run.random.next_float() >= *probability {
    // rust: continue;
}
    // rust: let mut empty = true;
    // rust: for i in 1..=*required_empty {
    // rust: if !d.is_air(tb::relative(leaf, direction, i))? {
    // rust: empty = false;
    // rust: break;
}
}
    // rust: if !empty {
    // rust: continue;
}
    // rust: for dx in -exclusion_xz..=*exclusion_xz {
    // rust: for dy in -exclusion_y..=*exclusion_y {
    // rust: for dz in -exclusion_xz..=*exclusion_xz {
    // rust: blacklist.insert(tb::offset(p, dx, dy, dz));
}
}
}
    // rust: let state = sample_state(provider, d.run.world, d.run.random, p)?;
    // rust: d.set(p, state)?;
}
}
    // rust: Self::AttachedToLogs {
    // rust: probability,
    // rust: provider,
    // rust: directions,
    // rust: } => {
    // rust: let mut logs = lists.logs.clone();
    // rust: tb::shuffle(&mut logs, d.run.random)?;
    // rust: for log in logs {
    // rust: let direction =
    // rust: directions[d.run.random.next_int_bound(directions.len() as i32)? as usize];
    // rust: let p = tb::relative(log, direction, 1);
    // rust: if d.run.random.next_float() <= *probability && d.is_air(p)? {
    // rust: let state = sample_state(provider, d.run.world, d.run.random, p)?;
    // rust: d.set(p, state)?;
}
}
}
    // rust: Self::CreakingHeart(probability) => {
    // rust: if lists.logs.is_empty() || d.run.random.next_float() >= *probability {
    // rust: return Ok(());
}
    // rust: let mut candidates = lists.logs.clone();
    // rust: tb::shuffle(&mut candidates, d.run.random)?;
    // rust: for pos in candidates {
    // rust: let mut enclosed = true;
    // rust: for direction in Direction::ALL {
    // rust: let state = read(d.run.world, tb::relative(pos, direction, 1))?;
    // rust: if !blocks.has(state, tb::LOGS) {
    // rust: enclosed = false;
    // rust: break;
}
}
    // rust: if enclosed {
    // rust: let state = d.default("minecraft:creaking_heart")?;
    // rust: let state = d.with(state, "creaking_heart_state", "dormant")?;
    // rust: let state = d.with(state, "natural", "true")?;
    // rust: d.set(pos, state)?;
    // rust: break;
}
}
}
    // rust: Self::PaleMoss {
    // rust: leaves,
    // rust: trunk,
    // rust: ground,
    // rust: patch,
    // rust: } => {
    // rust: let mut logs = lists.logs.clone();
    // rust: tb::shuffle(&mut logs, d.run.random)?;
    // rust: let Some(origin) = logs
    // rust: .iter()
    // rust: .copied()
    // rust: .reduce(|best, p| if p[1] < best[1] { p } else { best })
    // rust: else {
    // rust: return Ok(());
}
    // rust: if d.run.random.next_float() < *ground {
    // rust: if let Some(patch) = patch {
    // rust: nested(
    // rust: patch,
    // rust: d.run.world,
    // rust: d.run.random,
    // rust: tb::offset(origin, 0, 1, 0),
    // rust: )?;
}
}
    // rust: for (positions, chance) in [(&lists.logs, *trunk), (&lists.leaves, *leaves)] {
    // rust: for &pos in positions {
    // rust: if d.run.random.next_float() < chance {
    // rust: let down = tb::offset(pos, 0, -1, 0);
    // rust: if d.is_air(down)? {
    // rust: d.moss_hanger(down)?;
}
}
}
}
}
    // rust: Self::PlaceOnGround {
    // rust: tries,
    // rust: radius,
    // rust: height,
    // rust: provider,
    // rust: } => {
    // rust: let positions = lists.lowest();
    // rust: let Some(&origin) = positions.first() else {
    // rust: return Ok(());
}
    // rust: let min_y = origin[1];
    // rust: let (mut min_x, mut max_x, mut min_z, mut max_z) =
    // rust: (origin[0], origin[0], origin[2], origin[2]);
    // rust: for p in positions.iter().filter(|p| p[1] == min_y) {
    // rust: min_x = min_x.min(p[0]);
    // rust: max_x = max_x.max(p[0]);
    // rust: min_z = min_z.min(p[2]);
    // rust: max_z = max_z.max(p[2]);
}
    // rust: let low = [
    // rust: min_x.wrapping_sub(*radius),
    // rust: min_y.wrapping_sub(*height),
    // rust: min_z.wrapping_sub(*radius),
    // rust: ];
    // rust: let high = [
    // rust: max_x.wrapping_add(*radius),
    // rust: min_y.wrapping_add(*height),
    // rust: max_z.wrapping_add(*radius),
    // rust: ];
    // rust: for _ in 0..*tries {
    // rust: let p = [
    // rust: d.run.random.next_int_between_inclusive(low[0], high[0])?,
    // rust: d.run.random.next_int_between_inclusive(low[1], high[1])?,
    // rust: d.run.random.next_int_between_inclusive(low[2], high[2])?,
    // rust: ];
    // rust: let above = tb::offset(p, 0, 1, 0);
    // rust: let above_state = read(d.run.world, above)?;
    // rust: if !blocks.has(above_state, tb::AIR | tb::VINE) {
    // rust: continue;
}
    // rust: if !blocks.has(read(d.run.world, p)?, tb::SOLID_RENDER) {
    // rust: continue;
}
    // rust: let surface = d
    // rust: .run
    // rust: .world
    // rust: .height(HeightmapType::MotionBlockingNoLeaves, p[0], p[2])
    // rust: .map_err(FeatureExecutionError::Query)?;
    // rust: if surface <= above[1] {
    // rust: let state = sample_state(provider, d.run.world, d.run.random, above)?;
    // rust: d.set(above, state)?;
}
}
}
    // rust: Self::ShelfMushroom(probability) => d.shelf_mushroom(lists, *probability)?,
}
    // rust: Ok(())
}
}

Decorate :: struct {
    run: ^'a mut Run<'w,
    blocks: ^'b TreeBlocks,
}
    // rust: impl<W: FeatureWorld + PlacementContext, R: RandomSource> Decorate<'_, '_, '_, W, R> {
is_air :: proc(self: ^Self, p: [i32; 3]) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.blocks.is_air(read(self.run.world, p)?))
}
has :: proc(self: ^Self, p: [i32; 3], flag: u32) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.blocks.has(read(self.run.world, p)?, flag))
}
set :: proc(self: ^Self, p: [i32; 3], state: BlockStateId) -> T {
    // Ported from Horizon
    return {}
}
    // rust: self.run.set(Layer::Decoration, p, state)
}
default :: proc(self: ^Self, name: string) -> T {
    // Ported from Horizon
    return {}
}
    // rust: self.blocks
    // rust: .default_state(name)
    // rust: .ok_or(FeatureExecutionError::InvalidState)
}
    // rust: fn with(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: name: &str,
    // rust: value: &str,
    // rust: ) -> TreeResult<BlockStateId, W::Error> {
    // rust: self.blocks
    // rust: .with(state, name, value)
    // rust: .ok_or(FeatureExecutionError::InvalidState)
}
place_vine :: proc(self: ^Self, p: [i32; 3], face: string) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let vine = self.default("minecraft:vine")?;
    // rust: let state = self.with(vine, face, "true")?;
    // rust: self.set(p, state)
}
    // rust: fn circle(
    // rust: &mut self,
    // rust: provider: &BlockStateProvider,
    // rust: center: [i32; 3],
    // rust: ) -> TreeResult<(), W::Error> {
    // rust: for xx in -2i32..=2 {
    // rust: for zz in -2i32..=2 {
    // rust: if xx.abs() != 2 || zz.abs() != 2 {
    // rust: let column = tb::offset(center, xx, 0, zz);
    // rust: for dy in (-3..=2).rev() {
    // rust: let cursor = tb::offset(column, 0, dy, 0);
    // rust: if let Some(state) =
    // rust: sample_optional(provider, self.run.world, self.run.random, cursor)?
    // rust: {
    // rust: self.set(cursor, state)?;
    // rust: break;
}
    // rust: if !self.is_air(cursor)? && dy < 0 {
    // rust: break;
}
}
}
}
}
    // rust: Ok(())
}
moss_hanger :: proc(self: ^Self, mut p: [i32; 3]) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let moss = self.default("minecraft:pale_hanging_moss")?;
    // rust: let middle = self.with(moss, "tip", "false")?;
    // rust: let tip = self.with(moss, "tip", "true")?;
    // rust: while self.is_air(tb::offset(p, 0, -1, 0))? && self.run.random.next_float() >= 0.5 {
    // rust: self.set(p, middle)?;
    // rust: p = tb::offset(p, 0, -1, 0);
}
    // rust: self.set(p, tip)
}
beehive :: proc(self: ^Self, lists: ^Lists, probability: f32) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let (Some(first_log), Some(last_log)) = (lists.logs.first(), lists.logs.last()) else {
    // rust: return Ok(());
}
    // rust: if self.run.random.next_float() >= probability {
    // rust: return Ok(());
}
    // rust: let hive_y = match lists.leaves.first() {
    // rust: Some(leaf) => (leaf[1] - 1).max(first_log[1] + 1),
    // rust: None => (first_log[1] + 1 + self.run.random.next_int_bound(3)?).min(last_log[1]),
}
    // rust: let mut placements: Vec<[i32; 3]> = lists
    // rust: .logs
    // rust: .iter()
    // rust: .filter(|p| p[1] == hive_y)
    // rust: .flat_map(|p| {
    // rust: [Direction::East, Direction::South, Direction::West].map(|d| tb::relative(*p, d, 1))
    // rust: })
    // rust: .collect();
    // rust: if placements.is_empty() {
    // rust: return Ok(());
}
    // rust: tb::shuffle(&mut placements, self.run.random)?;
    // rust: for p in placements {
    // rust: if self.is_air(p)? && self.is_air(tb::relative(p, Direction::South, 1))? {
    // rust: let nest = self.default("minecraft:bee_nest")?;
    // rust: let nest = self.with(nest, "facing", "south")?;
    // rust: self.set(p, nest)?;
                // Occupants exist only when the write produced the nest block entity.
    // rust: if read(self.run.world, p)? == nest {
    // rust: let count = 2 + self.run.random.next_int_bound(2)?;
    // rust: let mut ticks = Vec::with_capacity(count as usize);
    // rust: for _ in 0..count {
    // rust: ticks.push(self.run.random.next_int_bound(599)?);
}
    // rust: self.run
    // rust: .world
    // rust: .store_beehive_occupants(p, &ticks)
    // rust: .map_err(FeatureExecutionError::Query)?;
}
    // rust: break;
}
}
    // rust: Ok(())
}
shelf_mushroom :: proc(self: ^Self, lists: ^Lists, probability: f32) -> T {
    // Ported from Horizon
    return {}
}
    // rust: if self.run.random.next_float() >= probability {
    // rust: return Ok(());
}
    // rust: let (Some(first), Some(last)) = (lists.logs.first(), lists.logs.last()) else {
    // rust: return Ok(());
}
    // rust: if first[1] == last[1] {
    // rust: let facings = if first[0] != last[0] {
    // rust: [Direction::North, Direction::South]
    // rust: } else {
    // rust: [Direction::East, Direction::West]
}
    // rust: for &log in &lists.logs {
    // rust: for facing in facings {
    // rust: if self.run.random.next_float() <= 0.25 {
    // rust: let p = mushroom_pos(log, facing);
    // rust: if self.mushroom_replaceable(p)?
    // rust: && !self.adjacent_mushroom(p)?
    // rust: && !self.adjacent_mushroom(log)?
    // rust: {
    // rust: self.place_mushroom(p, facing)?;
}
}
}
}
    // rust: } else {
    // rust: let a = tb::HORIZONTAL[self.run.random.next_int_bound(4)? as usize];
    // rust: let facings = [a, tb::clockwise(a)];
    // rust: let base = first[1];
    // rust: for &log in &lists.logs {
    // rust: let dy = log[1].wrapping_sub(base);
    // rust: if !(1..=4).contains(&dy) {
    // rust: continue;
}
    // rust: for facing in facings {
    // rust: if self.run.random.next_float() <= 0.25 {
    // rust: let p = mushroom_pos(log, facing);
    // rust: if self.mushroom_replaceable(p)?
    // rust: && !self.has(tb::offset(p, 0, -1, 0), tb::SHELF_MUSHROOM)?
    // rust: {
    // rust: self.place_mushroom(p, facing)?;
    // rust: break;
}
}
}
}
}
    // rust: Ok(())
}
mushroom_replaceable :: proc(self: ^Self, p: [i32; 3]) -> T {
    // Ported from Horizon
    return {}
}
    // rust: if !self.has(p, tb::REPLACEABLE)? {
    // rust: return Ok(false);
}
    // rust: for q in [
    // rust: p,
    // rust: tb::offset(p, 1, 0, 0),
    // rust: tb::offset(p, -1, 0, 0),
    // rust: tb::offset(p, 0, 0, -1),
    // rust: tb::offset(p, 0, 0, 1),
    // rust: ] {
    // rust: if self.has(q, tb::WATER_BLOCK)? {
    // rust: return Ok(false);
}
}
    // rust: Ok(true)
}
adjacent_mushroom :: proc(self: ^Self, p: [i32; 3]) -> T {
    // Ported from Horizon
    return {}
}
    // rust: for direction in tb::HORIZONTAL {
    // rust: if self.has(tb::relative(p, direction, 1), tb::SHELF_MUSHROOM)? {
    // rust: return Ok(true);
}
}
    // rust: Ok(false)
}
place_mushroom :: proc(self: ^Self, p: [i32; 3], facing: Direction) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let age = self.run.random.next_int_bound(2)?;
    // rust: let state = self.default("minecraft:shelf_mushroom")?;
    // rust: let state = self.with(state, "age", &age.to_string())?;
    // rust: let state = self.with(state, "facing", tb::direction_name(facing))?;
    // rust: self.set(p, state)
}
}
mushroom_pos :: proc(log: [i32; 3], facing: Direction) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let n = facing.normal();
    // rust: tb::offset(log, n[0], 0, n[2])
}

// The nest's block entity after `BeehiveDecorator` stored its bees
// (`Occupant.create(ticks)`: a bee, with 600 minimum ticks in the hive).
    // rust: pub(crate) fn beehive_occupants(ticks_in_hive: &[i32]) -> crate::nbt::Compound {
//     use crate::nbt::{Compound, Tag};
    // rust: let bees = ticks_in_hive
    // rust: .iter()
    // rust: .map(|&ticks| {
    // rust: let mut entity = Compound::new();
    // rust: entity.insert("id".into(), Tag::String("minecraft:bee".into()));
    // rust: let mut bee = Compound::new();
    // rust: bee.insert("entity_data".into(), Tag::Compound(entity));
    // rust: bee.insert("ticks_in_hive".into(), Tag::Int(ticks));
    // rust: bee.insert("min_ticks_in_hive".into(), Tag::Int(600));
    // rust: Tag::Compound(bee)
    // rust: })
    // rust: .collect();
    // rust: let mut nbt = Compound::new();
    // rust: nbt.insert("id".into(), Tag::String("minecraft:beehive".into()));
    // rust: nbt.insert("bees".into(), Tag::List(bees));
    // rust: nbt
}
