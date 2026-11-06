//! Transpiled from Horizon Rust crate
//! Module: horizon-world_sculk
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `minecraft:sculk_patch`: the world-generation SculkSpreader with sculk,
//! sculk vein and default charge-cursor behaviours.
// use super::{
    // rust: DecodeError, Object,
    // rust: block_feature::FeatureBlockBindings,
    // rust: feature::FeatureWorld,
    // rust: feature_graph::FeatureExecutionError,
    // rust: int_range,
    // rust: placement::{PlacementContext, PlacementQueryError},
    // rust: required,
    // rust: tree::{TreeResult, kind, read, write},
    // rust: tree_blocks::{self as tb, TreeBlocks},
}
// use crate::registry::BlockStateId;
// use horizon_core::{geometry::Direction, random::RandomSource};
// use std::{collections::BTreeSet, sync::Arc};

    // rust: fn query<E>(error: PlacementQueryError) -> FeatureExecutionError<E> {
    // rust: FeatureExecutionError::Query(error)
}

// Worldgen spreader constants (SculkSpreader.createWorldGenSpreader).
pub const GROWTH_SPAWN_COST: i32 = 50;
pub const NO_GROWTH_RADIUS: i32 = 1;
pub const CHARGE_DECAY_RATE: i32 = 5;
pub const ADDITIONAL_DECAY_RATE: i32 = 10;
pub const MAX_CURSORS: usize = 32;

pub const Behaviour = enum {
    Default,
    Sculk,
    Vein,
};
pub const Spread = enum {
    SamePosition,
    SamePlane,
    WrapAround,
};
pub const ALL_SPREADS: [Spread; 3] = [Spread::SamePosition, Spread::SamePlane, Spread::WrapAround];

pub const Cursor = struct {
    pos: [i32,
    charge: i32,
    update_delay: i32,
    decay_delay: i32,
    facings: ?std.ArrayList(Direction),
};

pub const SculkPatchFeature = struct {
    charge_count: i32,
    amount_per_charge: i32,
    spread_attempts: i32,
    growth_rounds: i32,
    spread_rounds: i32,
    sculk: BlockStateId,
    vein: BlockStateId,
    shrieker: BlockStateId,
    sensor: BlockStateId,
    water: BlockStateId,
    air: BlockStateId,
    replaceable_world_gen: *BTreeSet<BlockStateId>,
    replaceable: *BTreeSet<BlockStateId>,
    inhibitors: *BTreeSet<BlockStateId>,
    blocks: *TreeBlocks,
};
    // rust: impl SculkPatchFeature {
    // rust: pub(crate) fn decode(
    // rust: json: &str,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: if kind(&object)? != "minecraft:sculk_patch" {
    // rust: return Err(DecodeError::Field("sculk patch type"));
}
    // rust: let int = |name: &'static str, low: i32, high: i32| {
    // rust: int_range(required(&object, name)?, name, low, high)
}
    // rust: let registry = bindings.registry();
    // rust: let default = |name: &str| {
    // rust: registry
    // rust: .default_state(name)
    // rust: .ok_or_else(|| DecodeError::Registry(format!("missing sculk block {name}")))
}
    // rust: let tag = |name: &str| -> Arc<BTreeSet<BlockStateId>> {
    // rust: bindings.tags.get(name).cloned().unwrap_or_default()
}
    // rust: let blocks = bindings.tree_blocks()?;
    // rust: let shrieker = blocks
    // rust: .with(default("minecraft:sculk_shrieker")?, "can_summon", "true")
    // rust: .ok_or(DecodeError::Field("sculk shrieker summon state"))?;
    // rust: Ok(Self {
    // rust: charge_count: int("charge_count", 1, 32)?,
    // rust: amount_per_charge: int("amount_per_charge", 1, 500)?,
    // rust: spread_attempts: int("spread_attempts", 1, 64)?,
    // rust: growth_rounds: int("growth_rounds", 0, 8)?,
    // rust: spread_rounds: int("spread_rounds", 0, 8)?,
    // rust: sculk: default("minecraft:sculk")?,
    // rust: vein: default("minecraft:sculk_vein")?,
    // rust: shrieker,
    // rust: sensor: default("minecraft:sculk_sensor")?,
    // rust: water: default("minecraft:water")?,
    // rust: air: default("minecraft:air")?,
    // rust: replaceable_world_gen: tag("minecraft:sculk_replaceable_world_gen"),
    // rust: replaceable: tag("minecraft:sculk_replaceable"),
    // rust: inhibitors: tag("minecraft:sculk_growth_inhibitors"),
    // rust: blocks,
    // rust: })
}
pub fn behaviour(self: *Self, state: BlockStateId) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.blocks.same_block(state, self.sculk) {
    // rust: Behaviour::Sculk
    // rust: } else if self.blocks.same_block(state, self.vein) {
    // rust: Behaviour::Vein
    // rust: } else {
    // rust: Behaviour::Default
}
}
pub fn has_face(self: *Self, state: BlockStateId, face: Direction) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.blocks
    // rust: .properties
    // rust: .value(state, tb::direction_name(face))
    // rust: == Some("true")
}
pub fn is_vein(self: *Self, state: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.blocks.same_block(state, self.vein)
}
    // rust: pub(crate) fn place<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut R,
    // rust: origin: [i32; 3],
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: if !self.can_spread_from(world, origin)? {
    // rust: return Ok(false);
}
    // rust: let mut cursors: Vec<Cursor> = Vec::new();
    // rust: for round in 0..self.spread_rounds + self.growth_rounds {
    // rust: for _ in 0..self.charge_count {
    // rust: let mut charge = self.amount_per_charge;
    // rust: while charge > 0 {
    // rust: let current = charge.min(1000);
    // rust: if cursors.len() < MAX_CURSORS {
    // rust: cursors.push(Cursor {
    // rust: pos: origin,
    // rust: charge: current,
    // rust: update_delay: 0,
    // rust: decay_delay: 1,
    // rust: facings: None,
    // rust: });
}
    // rust: charge -= current;
}
}
    // rust: let spread_veins = round < self.spread_rounds;
    // rust: for _ in 0..self.spread_attempts {
    // rust: cursors = self.update_cursors(world, random, origin, cursors, spread_veins)?;
}
    // rust: cursors.clear();
}
    // rust: Ok(true)
}
    // rust: fn can_spread_from<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: origin: [i32; 3],
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: let start = read(world, origin)?;
    // rust: if self.behaviour(start) != Behaviour::Default {
    // rust: return Ok(true);
}
    // rust: let water_source =
    // rust: self.blocks.has(start, tb::WATER_BLOCK) && self.blocks.has(start, tb::FLUID_SOURCE);
    // rust: if !self.blocks.is_air(start) && !water_source {
    // rust: return Ok(false);
}
    // rust: for direction in Direction::ALL {
    // rust: let p = tb::relative(origin, direction, 1);
    // rust: let state = read(world, p)?;
    // rust: if world.collision_full_block(state, p).map_err(query)? {
    // rust: return Ok(true);
}
}
    // rust: Ok(false)
}
    // rust: fn update_cursors<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut R,
    // rust: origin: [i32; 3],
    // rust: cursors: Vec<Cursor>,
    // rust: spread_veins: bool,
    // rust: ) -> TreeResult<Vec<Cursor>, W::Error> {
    // rust: let mut processed: Vec<Cursor> = Vec::new();
        // Mergeable cursor charge per position (index into `processed`).
    // rust: let mut mergeable: Vec<([i32; 3], usize, i32)> = Vec::new();
    // rust: for mut cursor in cursors {
    // rust: let distance = (0..3)
    // rust: .map(|i| cursor.pos[i].wrapping_sub(origin[i]).wrapping_abs())
    // rust: .max()
    // rust: .unwrap_or(0);
    // rust: if distance > 1024 {
    // rust: continue;
}
    // rust: self.update(world, random, origin, &mut cursor, spread_veins)?;
    // rust: if cursor.charge <= 0 {
    // rust: continue;
}
    // rust: match mergeable.iter_mut().find(|(p, _, _)| *p == cursor.pos) {
    // rust: None => {
    // rust: mergeable.push((cursor.pos, processed.len(), cursor.charge));
    // rust: processed.push(cursor);
}
    // rust: Some(entry) => {
                    // World generation never merges cursors.
    // rust: if cursor.charge < entry.2 {
    // rust: *entry = (cursor.pos, processed.len(), cursor.charge);
}
    // rust: processed.push(cursor);
}
}
}
    // rust: Ok(processed)
}
    // rust: fn update<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut R,
    // rust: origin: [i32; 3],
    // rust: cursor: &mut Cursor,
    // rust: spread_veins: bool,
    // rust: ) -> TreeResult<(), W::Error> {
    // rust: if cursor.charge <= 0 {
    // rust: return Ok(());
}
    // rust: if cursor.update_delay > 0 {
    // rust: cursor.update_delay -= 1;
    // rust: return Ok(());
}
    // rust: let mut state = read(world, cursor.pos)?;
    // rust: let mut behaviour = self.behaviour(state);
    // rust: if spread_veins
    // rust: && self.attempt_spread_vein(
    // rust: world,
    // rust: behaviour,
    // rust: cursor.pos,
    // rust: state,
    // rust: cursor.facings.as_deref(),
    // rust: )?
    // rust: && behaviour != Behaviour::Sculk
    // rust: {
    // rust: state = read(world, cursor.pos)?;
    // rust: behaviour = self.behaviour(state);
}
    // rust: cursor.charge =
    // rust: self.attempt_use_charge(world, random, origin, behaviour, cursor, spread_veins)?;
    // rust: if cursor.charge <= 0 {
    // rust: self.on_discharged(world, behaviour, state, cursor.pos)?;
    // rust: return Ok(());
}
    // rust: match self.valid_movement(world, random, cursor.pos, origin)? {
    // rust: Some(target) => {
    // rust: self.on_discharged(world, behaviour, state, cursor.pos)?;
    // rust: cursor.pos = target;
    // rust: state = read(world, target)?;
}
    // rust: None => {
    // rust: self.on_discharged(world, behaviour, state, cursor.pos)?;
    // rust: cursor.charge = 0;
    // rust: return Ok(());
}
}
    // rust: if self.behaviour(state) != Behaviour::Default {
    // rust: cursor.facings = Some(
    // rust: Direction::ALL
    // rust: .into_iter()
    // rust: .filter(|d| self.has_face(state, *d))
    // rust: .collect(),
    // rust: );
}
    // rust: cursor.decay_delay = match behaviour {
    // rust: Behaviour::Default => (cursor.decay_delay - 1).max(0),
    // rust: _ => 1,
}
    // rust: cursor.update_delay = 1;
    // rust: Ok(())
}
    // rust: fn attempt_spread_vein<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: behaviour: Behaviour,
    // rust: pos: [i32; 3],
    // rust: state: BlockStateId,
    // rust: facings: Option<&[Direction]>,
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: if behaviour == Behaviour::Default {
    // rust: match facings {
    // rust: None => {
    // rust: let current = read(world, pos)?;
    // rust: return Ok(self.spread_all(world, current, pos, &[Spread::SamePosition])? > 0);
}
    // rust: Some(faces) if !faces.is_empty() => {
    // rust: let water_source = self.blocks.has(state, tb::WATER_SOURCE);
    // rust: if !self.blocks.is_air(state) && !water_source {
    // rust: return Ok(false);
}
    // rust: return self.regrow(world, pos, state, faces);
}
    // rust: Some(_) => {}
}
}
    // rust: Ok(self.spread_all(world, state, pos, &ALL_SPREADS)? > 0)
}
    // rust: fn regrow<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: pos: [i32; 3],
    // rust: existing: BlockStateId,
    // rust: faces: &[Direction],
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: let mut state = self.vein;
    // rust: let mut any = false;
    // rust: for &face in faces {
    // rust: if world.attachment_at(pos, face).map_err(query)? {
    // rust: state = self.with_face(state, face, true)?;
    // rust: any = true;
}
}
    // rust: if !any {
    // rust: return Ok(false);
}
    // rust: if self.blocks.has(existing, tb::ANY_FLUID) {
    // rust: state = self.blocks.waterlogged(state, true);
}
    // rust: write(world, pos, state, 3)?;
    // rust: Ok(true)
}
    // rust: fn with_face<E>(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: face: Direction,
    // rust: value: bool,
    // rust: ) -> TreeResult<BlockStateId, E> {
    // rust: self.blocks
    // rust: .with(
    // rust: state,
    // rust: tb::direction_name(face),
    // rust: if value { "true" } else { "false" },
    // rust: )
    // rust: .ok_or(FeatureExecutionError::InvalidState)
}
    /// MultifaceSpreader.spreadAll with the sculk vein spreader configuration
    /// (post-processing enabled for world generation).
    // rust: fn spread_all<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: state: BlockStateId,
    // rust: pos: [i32; 3],
    // rust: types: &[Spread],
    // rust: ) -> TreeResult<i64, W::Error> {
    // rust: let other_source = !self.is_vein(state);
    // rust: let mut count = 0;
    // rust: for face in Direction::ALL {
    // rust: if !(other_source || self.has_face(state, face)) {
    // rust: continue;
}
    // rust: for direction in Direction::ALL {
    // rust: if tb::Axis::of(direction) == tb::Axis::of(face) {
    // rust: continue;
}
    // rust: if !(other_source
    // rust: || (self.has_face(state, face) && !self.has_face(state, direction)))
    // rust: {
    // rust: continue;
}
    // rust: let mut target = None;
    // rust: for kind in types {
    // rust: let candidate = match kind {
    // rust: Spread::SamePosition => (pos, direction),
    // rust: Spread::SamePlane => (tb::relative(pos, direction, 1), face),
    // rust: Spread::WrapAround => (
    // rust: tb::relative(tb::relative(pos, direction, 1), face, 1),
    // rust: direction.opposite(),
    // rust: ),
}
    // rust: if self.can_spread_into(world, pos, candidate.0, candidate.1)? {
    // rust: target = Some(candidate);
    // rust: break;
}
}
    // rust: let Some((target, face_to)) = target else {
    // rust: continue;
}
    // rust: let old = read(world, target)?;
    // rust: let Some(new) = self.state_for_placement(world, old, target, face_to)? else {
    // rust: continue;
}
    // rust: world.mark_postprocessing(target).map_err(query)?;
    // rust: if write(world, target, new, 2)? {
    // rust: count += 1;
}
}
}
    // rust: Ok(count)
}
    // rust: fn valid_for_placement<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: old: BlockStateId,
    // rust: pos: [i32; 3],
    // rust: face: Direction,
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: if self.is_vein(old) && self.has_face(old, face) {
    // rust: return Ok(false);
}
    // rust: world.attachment_at(pos, face).map_err(query)
}
    // rust: fn state_for_placement<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: old: BlockStateId,
    // rust: pos: [i32; 3],
    // rust: face: Direction,
    // rust: ) -> TreeResult<Option<BlockStateId>, W::Error> {
    // rust: if !self.valid_for_placement(world, old, pos, face)? {
    // rust: return Ok(None);
}
    // rust: let base = if self.is_vein(old) {
    // rust: old
    // rust: } else if self.blocks.has(old, tb::WATER_SOURCE) {
    // rust: self.blocks.waterlogged(self.vein, true)
    // rust: } else {
    // rust: self.vein
}
    // rust: self.with_face(base, face, true).map(Some)
}
    // rust: fn can_spread_into<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: source: [i32; 3],
    // rust: target: [i32; 3],
    // rust: face: Direction,
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: let existing = read(world, target)?;
    // rust: let against = read(world, tb::relative(target, face, 1))?;
    // rust: if self.blocks.has(against, tb::SCULK_BLOCKER) {
    // rust: return Ok(false);
}
    // rust: if tb::dist_manhattan(source, target) == 2 {
    // rust: let neighbor = tb::relative(source, face.opposite(), 1);
    // rust: let state = read(world, neighbor)?;
    // rust: if world
    // rust: .state_face_sturdy(state, neighbor, face)
    // rust: .map_err(query)?
    // rust: {
    // rust: return Ok(false);
}
}
    // rust: if self.blocks.has(existing, tb::ANY_FLUID) && !self.blocks.has(existing, tb::WATER_SOURCE)
    // rust: {
    // rust: return Ok(false);
}
    // rust: if self.blocks.has(existing, tb::FIRE) {
    // rust: return Ok(false);
}
    // rust: let replaceable = self.blocks.has(existing, tb::REPLACEABLE)
    // rust: || self.blocks.is_air(existing)
    // rust: || self.is_vein(existing)
    // rust: || (self.blocks.has(existing, tb::WATER_BLOCK)
    // rust: && self.blocks.has(existing, tb::WATER_SOURCE));
    // rust: Ok(replaceable && self.valid_for_placement(world, existing, target, face)?)
}
    // rust: fn attempt_use_charge<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut R,
    // rust: origin: [i32; 3],
    // rust: behaviour: Behaviour,
    // rust: cursor: &Cursor,
    // rust: spread_veins: bool,
    // rust: ) -> TreeResult<i32, W::Error> {
    // rust: let charge = cursor.charge;
    // rust: match behaviour {
    // rust: Behaviour::Default => Ok(if cursor.decay_delay > 0 { charge } else { 0 }),
    // rust: Behaviour::Vein => {
    // rust: if spread_veins && self.place_sculk(world, random, cursor.pos)? {
    // rust: Ok(charge - 1)
    // rust: } else if random.next_int_bound(CHARGE_DECAY_RATE)? == 0 {
    // rust: Ok((charge as f32 * 0.5f32).floor() as i32)
    // rust: } else {
    // rust: Ok(charge)
}
}
    // rust: Behaviour::Sculk => {
    // rust: if charge == 0 || random.next_int_bound(CHARGE_DECAY_RATE)? != 0 {
    // rust: return Ok(charge);
}
    // rust: let pos = cursor.pos;
    // rust: let dist_sqr: f64 = (0..3)
    // rust: .map(|i| {
    // rust: let d = f64::from(pos[i]) - f64::from(origin[i]);
    // rust: d * d
    // rust: })
    // rust: .sum();
    // rust: let close = dist_sqr < f64::from(NO_GROWTH_RADIUS * NO_GROWTH_RADIUS);
    // rust: if !close && self.can_place_growth(world, pos)? {
    // rust: if random.next_int_bound(GROWTH_SPAWN_COST)? < charge {
    // rust: let above = tb::offset(pos, 0, 1, 0);
    // rust: let mut growth = if random.next_int_bound(11)? == 0 {
    // rust: self.shrieker
    // rust: } else {
    // rust: self.sensor
}
    // rust: if self.blocks.has(growth, tb::WATERLOGGABLE)
    // rust: && self.blocks.has(read(world, above)?, tb::ANY_FLUID)
    // rust: {
    // rust: growth = self.blocks.waterlogged(growth, true);
}
    // rust: write(world, above, growth, 3)?;
}
    // rust: return Ok(0.max(charge - GROWTH_SPAWN_COST));
}
    // rust: if random.next_int_bound(ADDITIONAL_DECAY_RATE)? != 0 {
    // rust: return Ok(charge);
}
    // rust: let penalty = if close {
    // rust: 1
    // rust: } else {
    // rust: let outer = (dist_sqr.sqrt() as f32 - NO_GROWTH_RADIUS as f32).powi(2);
    // rust: let reach = (24 - NO_GROWTH_RADIUS) * (24 - NO_GROWTH_RADIUS);
    // rust: let factor = 1.0f32.min(outer / reach as f32);
    // rust: 1.max((charge as f32 * factor * 0.5f32) as i32)
}
    // rust: Ok(charge - penalty)
}
}
}
    // rust: fn can_place_growth<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: pos: [i32; 3],
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: let above = read(world, tb::offset(pos, 0, 1, 0))?;
    // rust: let open = self.blocks.is_air(above)
    // rust: || (self.blocks.has(above, tb::WATER_BLOCK)
    // rust: && self.blocks.has(above, tb::WATER_SOURCE));
    // rust: if !open {
    // rust: return Ok(false);
}
    // rust: let mut matched = 0;
        // BoxBlockMatcher iterates BlockPos.betweenClosed (x, then y, then z).
    // rust: for dz in -4..=4 {
    // rust: for dy in 0..=2 {
    // rust: for dx in -4..=4 {
    // rust: if self
    // rust: .inhibitors
    // rust: .contains(&read(world, tb::offset(pos, dx, dy, dz))?)
    // rust: {
    // rust: matched += 1;
    // rust: if matched >= 3 {
    // rust: return Ok(false);
}
}
}
}
}
    // rust: Ok(true)
}
    // rust: fn place_sculk<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut R,
    // rust: pos: [i32; 3],
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: let state = read(world, pos)?;
    // rust: let mut directions = Direction::ALL;
    // rust: tb::shuffle(&mut directions, random)?;
    // rust: for support in directions {
    // rust: if !self.has_face(state, support) {
    // rust: continue;
}
    // rust: let support_pos = tb::relative(pos, support, 1);
    // rust: let support_state = read(world, support_pos)?;
    // rust: if !self.replaceable_world_gen.contains(&support_state) {
    // rust: continue;
}
    // rust: write(world, support_pos, self.sculk, 3)?;
    // rust: self.spread_all(world, self.sculk, support_pos, &ALL_SPREADS)?;
    // rust: let skip = support.opposite();
    // rust: for direction in Direction::ALL {
    // rust: if direction == skip {
    // rust: continue;
}
    // rust: let vein_pos = tb::relative(support_pos, direction, 1);
    // rust: let possible = read(world, vein_pos)?;
    // rust: if self.is_vein(possible) {
    // rust: self.on_discharged(world, Behaviour::Vein, possible, vein_pos)?;
}
}
    // rust: return Ok(true);
}
    // rust: Ok(false)
}
    // rust: fn on_discharged<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: behaviour: Behaviour,
    // rust: state: BlockStateId,
    // rust: pos: [i32; 3],
    // rust: ) -> TreeResult<(), W::Error> {
    // rust: if behaviour != Behaviour::Vein || !self.is_vein(state) {
    // rust: return Ok(());
}
    // rust: let mut state = state;
    // rust: for direction in Direction::ALL {
    // rust: if self.has_face(state, direction)
    // rust: && self
    // rust: .blocks
    // rust: .same_block(read(world, tb::relative(pos, direction, 1))?, self.sculk)
    // rust: {
    // rust: state = self.with_face(state, direction, false)?;
}
}
    // rust: if !Direction::ALL.into_iter().any(|d| self.has_face(state, d)) {
    // rust: let here = read(world, pos)?;
    // rust: state = if self.blocks.has(here, tb::ANY_FLUID) {
    // rust: self.water
    // rust: } else {
    // rust: self.air
}
}
    // rust: write(world, pos, state, 3)?;
    // rust: Ok(())
}
    // rust: fn valid_movement<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut R,
    // rust: pos: [i32; 3],
    // rust: origin: [i32; 3],
    // rust: ) -> TreeResult<Option<[i32; 3]>, W::Error> {
        // NON_CORNER_NEIGHBOURS in betweenClosed order (x, then y, then z).
    // rust: let mut offsets = Vec::with_capacity(18);
    // rust: for z in -1..=1 {
    // rust: for y in -1..=1 {
    // rust: for x in -1..=1 {
    // rust: if (x == 0 || y == 0 || z == 0) && (x, y, z) != (0, 0, 0) {
    // rust: offsets.push([x, y, z]);
}
}
}
}
    // rust: tb::shuffle(&mut offsets, random)?;
    // rust: let mut best = pos;
    // rust: for o in offsets {
    // rust: let neighbour = tb::offset(pos, o[0], o[1], o[2]);
    // rust: let dx = origin[0].wrapping_sub(neighbour[0]);
    // rust: let dz = origin[2].wrapping_sub(neighbour[2]);
    // rust: if dx.wrapping_mul(dx).wrapping_add(dz.wrapping_mul(dz)) > 144 {
    // rust: continue;
}
    // rust: let transferee = read(world, neighbour)?;
    // rust: if self.behaviour(transferee) == Behaviour::Default
    // rust: || !self.unobstructed_move(world, pos, neighbour)?
    // rust: {
    // rust: continue;
}
    // rust: best = neighbour;
    // rust: if self.is_vein(transferee) {
    // rust: let mut substrate = false;
    // rust: for direction in Direction::ALL {
    // rust: if self.has_face(transferee, direction)
    // rust: && self
    // rust: .replaceable
    // rust: .contains(&read(world, tb::relative(neighbour, direction, 1))?)
    // rust: {
    // rust: substrate = true;
    // rust: break;
}
}
    // rust: if substrate {
    // rust: break;
}
}
}
    // rust: Ok((best != pos).then_some(best))
}
    // rust: fn unobstructed_move<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: from: [i32; 3],
    // rust: to: [i32; 3],
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: if tb::dist_manhattan(from, to) == 1 {
    // rust: return Ok(true);
}
    // rust: let delta: [i32; 3] = std::array::from_fn(|i| to[i].wrapping_sub(from[i]));
    // rust: let pick = |v: i32, negative: Direction, positive: Direction| {
    // rust: if v < 0 { negative } else { positive }
}
    // rust: let dir_x = pick(delta[0], Direction::West, Direction::East);
    // rust: let dir_y = pick(delta[1], Direction::Down, Direction::Up);
    // rust: let dir_z = pick(delta[2], Direction::North, Direction::South);
    // rust: let (a, b) = if delta[0] == 0 {
    // rust: (dir_y, dir_z)
    // rust: } else if delta[1] == 0 {
    // rust: (dir_x, dir_z)
    // rust: } else {
    // rust: (dir_x, dir_y)
}
    // rust: Ok(self.unobstructed(world, from, a)? || self.unobstructed(world, from, b)?)
}
    // rust: fn unobstructed<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: from: [i32; 3],
    // rust: direction: Direction,
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: let test = tb::relative(from, direction, 1);
    // rust: let state = read(world, test)?;
    // rust: Ok(!world
    // rust: .state_face_sturdy(state, test, direction.opposite())
    // rust: .map_err(query)?)
}
}
