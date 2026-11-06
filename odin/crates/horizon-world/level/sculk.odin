//! Transpiled from Horizon Rust crate
package horizon_world_sculk

import "core:fmt"
import "core:mem"
import "core:math"

// Sculk: the sensor's phases, the shrieker and catalyst blocks, and the
// level `SculkSpreader` with the sculk, sculk vein and default charge-cursor
// behaviours (`SculkBlock`, `SculkVeinBlock`, `SculkBehaviour`).
// use super::{
    // rust: Behaviours, LevelAccess, LevelEvent, Sim, Ticks,
    // rust: classes::Class,
    // rust: update::{above, below, rel},
}
// use crate::{fluid::FluidState, registry::BlockStateId};
// use horizon_core::{geometry::Direction, position::BlockPos, random::RandomSource};

// `SculkSensorBlock.ACTIVE_TICKS` (calibrated sensors use 10).
SENSOR_ACTIVE_TICKS :: 30
CALIBRATED_ACTIVE_TICKS :: 10
// `SculkSensorBlock.COOLDOWN_TICKS`.
SENSOR_COOLDOWN_TICKS :: 10
// `SculkShriekerBlockEntity` shrieking time.
SHRIEKING_TICKS :: 90
// `SculkCatalystBlockEntity.CatalystListener.PULSE_TICKS`.
PULSE_TICKS :: 8

// SculkSpreader.createLevelSpreader.
GROWTH_SPAWN_COST :: 10
NO_GROWTH_RADIUS :: 4
CHARGE_DECAY_RATE :: 10
ADDITIONAL_DECAY_RATE :: 5
MAX_CURSORS :: 32
MAX_CHARGE :: 1000
MAX_CURSOR_DISTANCE :: 1024

// One `SculkSpreader.ChargeCursor`.
ChargeCursor :: struct {
    pos: BlockPos,
    charge: i32,
    update_delay: i32,
    decay_delay: i32,
    // The faces of the block the cursor last moved onto, if any.
    facings: Maybe([dynamic]Direction),
}
    // rust: impl ChargeCursor {
new :: proc(pos: BlockPos, charge: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: pos,
    // rust: charge,
    // rust: update_delay: 0,
    // rust: decay_delay: 1,
    // rust: facings: None,
}
}
}
// A catalyst's `SculkSpreader` (the level configuration).
SculkSpreader :: struct {
    cursors: [dynamic]ChargeCursor,
}
    // rust: impl SculkSpreader {
    // `addCursors`: charge in chunks of at most 1000, at most 32 cursors.
add_cursors :: proc(self: ^Self, start: BlockPos, mut charge: i32) {
}
    // rust: while charge > 0 {
    // rust: let current = charge.min(MAX_CHARGE);
    // rust: self.add_cursor(ChargeCursor::new(start, current));
    // rust: charge -= current;
}
}
add_cursor :: proc(self: ^Self, cursor: ChargeCursor) {
}
    // rust: if self.cursors.len() < MAX_CURSORS {
    // rust: self.cursors.push(cursor);
}
}
}

Behaviour :: enum {
    Default,
    Sculk,
    Vein,
}
Spread :: enum {
    SamePosition,
    SamePlane,
    WrapAround,
}
ALL_SPREADS :: [Spread::SamePosition, Spread::SamePlane, Spread::WrapAround]

// `MultifaceBlock.pack`: the faces as bits of their ordinals.
pack_faces :: proc(faces: ^[Direction]) -> i {
    // Ported from Horizon
    return {}
}
    // rust: faces.iter().fold(0, |code, d| code | 1 << *d as i32)
}
// `MultifaceBlock.unpack`.
unpack_faces :: proc(data: i32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: Direction::ALL
    // rust: .into_iter()
    // rust: .filter(|d| data & (1 << *d as i32) != 0)
    // rust: .collect()
}

    // rust: impl<L: LevelAccess + ?Sized> Sim<'_, L> {
sculk_rand :: proc(self: ^Self, bound: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.random().next_int_bound(bound).unwrap_or(0)
}
sculk_in_tag :: proc(self: ^Self, state: BlockStateId, tag: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.b.tag(tag).is_some_and(|set| self.b.in_set(state, set))
}
sculk_sound :: proc(self: ^Self, pos: BlockPos, sound: string, volume: f32, pitch: f32) {
}
    // rust: self.emit(LevelEvent::Sound {
    // rust: pos,
    // rust: sound: sound.into(),
    // rust: volume,
    // rust: pitch,
    // rust: });
}

    // ---- sensors ----

    // `SculkSensorBlock.canActivate`.
    // rust: pub(crate) fn sensor_phase(&self, state: BlockStateId) -> &'static str {
    // rust: match self.b.table.text(state, self.b.props.sculk_sensor_phase) {
    // rust: "active" => "active",
    // rust: "cooldown" => "cooldown",
    // rust: _ => "inactive",
}
}
sensor_update_neighbours :: proc(self: ^Self, pos: BlockPos, state: BlockStateId) {
}
    // rust: let block = self.b.block(state);
    // rust: self.update_neighbors_at(pos, block);
    // rust: self.update_neighbors_at(below(pos), block);
}
    // `SculkSensorBlock.tick`.
    // rust: pub(crate) fn sculk_sensor_tick(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let b = self.b;
    // rust: match self.sensor_phase(state) {
    // rust: "active" => self.sculk_sensor_deactivate(pos, state),
    // rust: "cooldown" => {
    // rust: let next = b
    // rust: .table
    // rust: .set_text(state, b.props.sculk_sensor_phase, "inactive");
    // rust: self.set_block_and_update(pos, next);
    // rust: if !b.table.bool(state, b.props.waterlogged) {
    // rust: let pitch = self.random().next_float() * 0.2 + 0.8;
    // rust: self.sculk_sound(
    // rust: pos,
    // rust: "minecraft:block.sculk_sensor.clicking_stop",
    // rust: 1.0,
    // rust: pitch,
    // rust: );
}
}
    // rust: _ => {}
}
}
    // `SculkSensorBlock.deactivate`.
    // rust: pub(crate) fn sculk_sensor_deactivate(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let b = self.b;
    // rust: let next = b.table.set_int(
    // rust: b.table
    // rust: .set_text(state, b.props.sculk_sensor_phase, "cooldown"),
    // rust: b.props.power,
    // rust: 0,
    // rust: );
    // rust: self.set_block_and_update(pos, next);
    // rust: let block = b.block(state);
    // rust: self.schedule_tick(pos, block, SENSOR_COOLDOWN_TICKS);
    // rust: self.sensor_update_neighbours(pos, state);
}
    // `SculkSensorBlock.activate` without the resonance and the tendril
    // event, which need the source entity.
    // rust: pub(crate) fn sculk_sensor_activate(
    // rust: &mut self,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: power: i32,
    // rust: active_ticks: i32,
    // rust: ) {
    // rust: let b = self.b;
    // rust: let next = b.table.set_int(
    // rust: b.table
    // rust: .set_text(state, b.props.sculk_sensor_phase, "active"),
    // rust: b.props.power,
    // rust: power,
    // rust: );
    // rust: self.set_block_and_update(pos, next);
    // rust: let block = b.block(state);
    // rust: self.schedule_tick(pos, block, active_ticks);
    // rust: self.sensor_update_neighbours(pos, state);
}
    // The activation sound, played after the tendril event.
    // rust: pub(crate) fn sculk_sensor_click(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: if !self.b.table.bool(state, self.b.props.waterlogged) {
    // rust: let pitch = self.random().next_float() * 0.2 + 0.8;
    // rust: self.sculk_sound(pos, "minecraft:block.sculk_sensor.clicking", 1.0, pitch);
}
}

    // ---- shrieker and catalyst ----

    // `SculkShriekerBlock.tick`: the shriek ends and the block responds.
    // rust: pub(crate) fn sculk_shrieker_tick(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let b = self.b;
    // rust: if b.table.bool(state, b.props.shrieking) {
    // rust: let next = b.table.set_bool(state, b.props.shrieking, false);
    // rust: self.set_block_and_update(pos, next);
    // rust: self.emit(LevelEvent::BlockEvent {
    // rust: pos,
    // rust: state: next,
    // rust: kind: "shrieker_respond",
    // rust: });
}
}
    // `SculkCatalystBlock.tick`.
    // rust: pub(crate) fn sculk_catalyst_tick(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let b = self.b;
    // rust: if b.table.bool(state, b.props.bloom) {
    // rust: let next = b.table.set_bool(state, b.props.bloom, false);
    // rust: self.set_block_and_update(pos, next);
}
}

    // ---- the spreader ----

sculk_behaviour :: proc(self: ^Self, state: BlockStateId) -> B {
    // Ported from Horizon
    return {}
}
    // rust: let block = self.b.block(state);
    // rust: if block == self.b.named.sculk {
    // rust: Behaviour::Sculk
    // rust: } else if block == self.b.named.sculk_vein {
    // rust: Behaviour::Vein
    // rust: } else {
    // rust: Behaviour::Default
}
}
is_vein :: proc(self: ^Self, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.b.block(state) == self.b.named.sculk_vein
}
vein_has_face :: proc(self: ^Self, state: BlockStateId, face: Direction) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.is_vein(state) && self.multiface_has_face(state, face)
}
vein_with_face :: proc(self: ^Self, state: BlockStateId, face: Direction, value: bool) -> B {
    // Ported from Horizon
    return {}
}
    // rust: self.b
    // rust: .table
    // rust: .set_bool(state, self.direction_prop(face), value)
}
available_faces :: proc(self: ^Self, state: BlockStateId) -> V {
    // Ported from Horizon
    return {}
}
    // rust: if !self.b.instance_of(state, Class::Multiface) {
    // rust: return Vec::new();
}
    // rust: Direction::ALL
    // rust: .into_iter()
    // rust: .filter(|d| self.multiface_has_face(state, *d))
    // rust: .collect()
}
is_sculk_source :: proc(self: ^Self, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.sculk_behaviour(state) != Behaviour::Default
}

    // `SculkSpreader.updateCursors`.
    // rust: pub(crate) fn sculk_update_cursors(
    // rust: &mut self,
    // rust: spreader: &mut SculkSpreader,
    // rust: origin: BlockPos,
    // rust: spread_veins: bool,
    // rust: ) {
    // rust: if spreader.cursors.is_empty() {
    // rust: return;
}
    // rust: let cursors = std::mem::take(&mut spreader.cursors);
    // rust: let mut processed: Vec<ChargeCursor> = Vec::new();
        // The cursor each position merges into (index into `processed`).
    // rust: let mut mergeable: Vec<(BlockPos, usize)> = Vec::new();
    // rust: let mut charge_map: Vec<(BlockPos, i32)> = Vec::new();
    // rust: for mut cursor in cursors {
    // rust: let distance = (cursor.pos.x.wrapping_sub(origin.x).wrapping_abs())
    // rust: .max(cursor.pos.y.wrapping_sub(origin.y).wrapping_abs())
    // rust: .max(cursor.pos.z.wrapping_sub(origin.z).wrapping_abs());
    // rust: if distance > MAX_CURSOR_DISTANCE {
    // rust: continue;
}
    // rust: self.sculk_cursor_update(&mut cursor, origin, spread_veins);
    // rust: if cursor.charge <= 0 {
    // rust: self.level_event(3006, cursor.pos, 0);
    // rust: continue;
}
    // rust: let pos = cursor.pos;
    // rust: match charge_map.iter_mut().find(|(p, _)| *p == pos) {
    // rust: Some(entry) => entry.1 += cursor.charge,
    // rust: None => charge_map.push((pos, cursor.charge)),
}
    // rust: match mergeable.iter().position(|(p, _)| *p == pos) {
    // rust: None => {
    // rust: mergeable.push((pos, processed.len()));
    // rust: processed.push(cursor);
}
    // rust: Some(slot) => {
    // rust: let index = mergeable[slot].1;
    // rust: if cursor.charge + processed[index].charge <= MAX_CHARGE {
                        // mergeWith
    // rust: processed[index].charge += cursor.charge;
    // rust: processed[index].update_delay =
    // rust: processed[index].update_delay.min(cursor.update_delay);
    // rust: } else {
    // rust: let smaller = cursor.charge < processed[index].charge;
    // rust: processed.push(cursor);
    // rust: if smaller {
    // rust: mergeable[slot].1 = processed.len() - 1;
}
}
}
}
}
    // rust: for (pos, charge) in charge_map {
    // rust: let faces = mergeable
    // rust: .iter()
    // rust: .find(|(p, _)| *p == pos)
    // rust: .and_then(|(_, i)| processed[*i].facings.clone());
    // rust: if charge > 0
    // rust: && let Some(faces) = faces
    // rust: {
    // rust: let particles =
    // rust: (horizon_core::jmath::log(f64::from(charge) + 1.0) as f32 / 2.3) as i32 + 1;
    // rust: let data = (particles << 6) + pack_faces(&faces);
    // rust: self.level_event(3006, pos, data);
}
}
    // rust: spreader.cursors = processed;
}

    // `ChargeCursor.update`.
sculk_cursor_update :: proc(self: ^Self, cursor: ^ChargeCursor, origin: BlockPos, veins: bool) {
}
        // shouldUpdate: charge left and the origin's chunk is ticking.
    // rust: if cursor.charge <= 0 || !self.level.is_ticking_chunk(origin.chunk()) {
    // rust: return;
}
    // rust: if cursor.update_delay > 0 {
    // rust: cursor.update_delay -= 1;
    // rust: return;
}
    // rust: let mut state = self.state(cursor.pos);
    // rust: let mut behaviour = self.sculk_behaviour(state);
    // rust: if veins && self.sculk_attempt_spread_vein(behaviour, cursor.pos, state, &cursor.facings) {
            // SculkBlock.canChangeBlockStateOnSpread is false.
    // rust: if behaviour != Behaviour::Sculk {
    // rust: state = self.state(cursor.pos);
    // rust: behaviour = self.sculk_behaviour(state);
}
    // rust: self.sculk_sound(cursor.pos, "minecraft:block.sculk.spread", 1.0, 1.0);
}
    // rust: cursor.charge = self.sculk_attempt_use_charge(behaviour, cursor, origin, veins);
    // rust: if cursor.charge <= 0 {
    // rust: self.sculk_on_discharged(behaviour, state, cursor.pos);
    // rust: return;
}
    // rust: let transfer = self.sculk_valid_movement(cursor.pos);
    // rust: if let Some(target) = transfer {
    // rust: self.sculk_on_discharged(behaviour, state, cursor.pos);
    // rust: cursor.pos = target;
    // rust: state = self.state(target);
}
    // rust: if self.is_sculk_source(state) {
    // rust: cursor.facings = Some(self.available_faces(state));
}
    // rust: cursor.decay_delay = match behaviour {
    // rust: Behaviour::Default => (cursor.decay_delay - 1).max(0),
    // rust: _ => 1,
}
    // rust: cursor.update_delay = 1;
}

    // `SculkBehaviour.attemptSpreadVein` (the default behaviour's override
    // regrows veins or spreads in the same space).
    // rust: fn sculk_attempt_spread_vein(
    // rust: &mut self,
    // rust: behaviour: Behaviour,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: facings: &Option<Vec<Direction>>,
    // rust: ) -> bool {
    // rust: if behaviour == Behaviour::Default {
    // rust: match facings {
    // rust: None => {
    // rust: let current = self.state(pos);
    // rust: return self.sculk_spread_all(current, pos, &[Spread::SamePosition]) > 0;
}
    // rust: Some(faces) if !faces.is_empty() => {
    // rust: let b = self.b;
    // rust: let water = b.is_block(state, b.named.water) && b.fluid(state).is_source();
    // rust: if !b.is_air(state) && !water {
    // rust: return false;
}
    // rust: return self.sculk_regrow(pos, state, faces);
}
    // rust: Some(_) => {}
}
}
    // rust: self.sculk_spread_all(state, pos, &ALL_SPREADS) > 0
}
    // `SculkVeinBlock.regrow`.
sculk_regrow :: proc(self: ^Self, pos: BlockPos, existing: BlockStateId, faces: ^[Direction]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let b = self.b;
    // rust: let mut state = b.default_of(b.named.sculk_vein);
    // rust: let mut any = false;
    // rust: for &face in faces {
    // rust: if b.multiface_can_attach(self.state(rel(pos, face)), face) {
    // rust: state = self.vein_with_face(state, face, true);
    // rust: any = true;
}
}
    // rust: if !any {
    // rust: return false;
}
    // rust: if b.fluid(existing) != FluidState::EMPTY {
    // rust: state = b.table.set_bool(state, b.props.waterlogged, true);
}
    // rust: self.set_block_and_update(pos, state);
    // rust: true
}
    // `MultifaceSpreader.spreadAll` with the sculk vein configuration.
sculk_spread_all :: proc(self: ^Self, state: BlockStateId, pos: BlockPos, types: ^[Spread]) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let other_source = !self.is_vein(state);
    // rust: let mut count = 0;
    // rust: for face in Direction::ALL {
    // rust: if !(other_source || self.vein_has_face(state, face)) {
    // rust: continue;
}
    // rust: for direction in Direction::ALL {
    // rust: if crate::level::query::axis_of(direction) == crate::level::query::axis_of(face) {
    // rust: continue;
}
    // rust: if !(other_source
    // rust: || (self.vein_has_face(state, face) && !self.vein_has_face(state, direction)))
    // rust: {
    // rust: continue;
}
    // rust: let mut target = None;
    // rust: for kind in types {
    // rust: let candidate = match kind {
    // rust: Spread::SamePosition => (pos, direction),
    // rust: Spread::SamePlane => (rel(pos, direction), face),
    // rust: Spread::WrapAround => {
    // rust: (rel(rel(pos, direction), face), direction.opposite())
}
}
    // rust: if self.sculk_can_spread_into(pos, candidate.0, candidate.1) {
    // rust: target = Some(candidate);
    // rust: break;
}
}
    // rust: let Some((target, face_to)) = target else {
    // rust: continue;
}
    // rust: let old = self.state(target);
    // rust: let Some(new) = self.sculk_state_for_placement(old, target, face_to) else {
    // rust: continue;
}
    // rust: if self.set_block(target, new, 2) {
    // rust: count += 1;
}
}
}
    // rust: count
}
sculk_valid_for_placement :: proc(self: ^Self, old: BlockStateId, pos: BlockPos, face: Direction) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if self.vein_has_face(old, face) {
    // rust: return false;
}
    // rust: self.b
    // rust: .multiface_can_attach(self.state(rel(pos, face)), face)
}
    // `MultifaceBlock.getStateForPlacement` for the sculk vein.
    // rust: fn sculk_state_for_placement(
    // rust: &self,
    // rust: old: BlockStateId,
    // rust: pos: BlockPos,
    // rust: face: Direction,
    // rust: ) -> Option<BlockStateId> {
    // rust: if !self.sculk_valid_for_placement(old, pos, face) {
    // rust: return None;
}
    // rust: let b = self.b;
    // rust: let base = if self.is_vein(old) {
    // rust: old
    // rust: } else if b.fluid(old) == FluidState::WATER {
    // rust: b.table
    // rust: .set_bool(b.default_of(b.named.sculk_vein), b.props.waterlogged, true)
    // rust: } else {
    // rust: b.default_of(b.named.sculk_vein)
}
    // rust: Some(self.vein_with_face(base, face, true))
}
    // `SculkVeinSpreaderConfig.canSpreadInto` (with the default config).
sculk_can_spread_into :: proc(self: ^Self, source: BlockPos, target: BlockPos, face: Direction) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let b = self.b;
    // rust: let existing = self.state(target);
    // rust: let against = self.state(rel(target, face));
    // rust: let against_block = b.block(against);
    // rust: if against_block == b.named.sculk
    // rust: || against_block == b.named.sculk_catalyst
    // rust: || against_block == b.named.moving_piston
    // rust: {
    // rust: return false;
}
    // rust: let manhattan =
    // rust: (source.x - target.x).abs() + (source.y - target.y).abs() + (source.z - target.z).abs();
    // rust: if manhattan == 2 {
    // rust: let neighbour = rel(source, face.opposite());
    // rust: if b.is_face_sturdy(self.state(neighbour), face) {
    // rust: return false;
}
}
    // rust: let fluid = b.fluid(existing);
    // rust: if fluid != FluidState::EMPTY && !(b.is_block(existing, b.named.water) && fluid.is_source())
    // rust: {
    // rust: return false;
}
    // rust: if self.sculk_in_tag(existing, "minecraft:fire") {
    // rust: return false;
}
    // rust: let replaceable = b.is_replaceable(existing)
    // rust: || b.is_air(existing)
    // rust: || self.is_vein(existing)
    // rust: || (b.is_block(existing, b.named.water) && fluid.is_source());
    // rust: replaceable && self.sculk_valid_for_placement(existing, target, face)
}

    // `SculkBehaviour.attemptUseCharge` per behaviour.
    // rust: fn sculk_attempt_use_charge(
    // rust: &mut self,
    // rust: behaviour: Behaviour,
    // rust: cursor: &ChargeCursor,
    // rust: origin: BlockPos,
    // rust: veins: bool,
    // rust: ) -> i32 {
    // rust: let charge = cursor.charge;
    // rust: match behaviour {
    // rust: Behaviour::Default => {
    // rust: if cursor.decay_delay > 0 {
    // rust: charge
    // rust: } else {
    // rust: 0
}
}
    // rust: Behaviour::Vein => {
    // rust: if veins && self.sculk_place_sculk(cursor.pos) {
    // rust: charge - 1
    // rust: } else if self.sculk_rand(CHARGE_DECAY_RATE) == 0 {
    // rust: (charge as f32 * 0.5).floor() as i32
    // rust: } else {
    // rust: charge
}
}
    // rust: Behaviour::Sculk => {
    // rust: if charge == 0 || self.sculk_rand(CHARGE_DECAY_RATE) != 0 {
    // rust: return charge;
}
    // rust: let pos = cursor.pos;
    // rust: let dist_sqr = f64::from(
    // rust: (pos.x - origin.x).pow(2)
    // rust: + (pos.y - origin.y).pow(2)
    // rust: + (pos.z - origin.z).pow(2),
    // rust: );
    // rust: let close = dist_sqr < f64::from(NO_GROWTH_RADIUS * NO_GROWTH_RADIUS);
    // rust: if !close && self.sculk_can_place_growth(pos) {
    // rust: if self.sculk_rand(GROWTH_SPAWN_COST) < charge {
    // rust: let growth_pos = above(pos);
    // rust: let growth = self.sculk_random_growth(growth_pos);
    // rust: self.set_block_and_update(growth_pos, growth);
    // rust: let sounds = self.b.data(growth).sounds.clone();
    // rust: self.emit(LevelEvent::Sound {
    // rust: pos,
    // rust: sound: sounds.place.clone(),
    // rust: volume: 1.0,
    // rust: pitch: 1.0,
    // rust: });
}
    // rust: return (charge - GROWTH_SPAWN_COST).max(0);
}
    // rust: if self.sculk_rand(ADDITIONAL_DECAY_RATE) != 0 {
    // rust: return charge;
}
    // rust: let penalty = if close {
    // rust: 1
    // rust: } else {
                    // getDecayPenalty
    // rust: let outer = (dist_sqr.sqrt() as f32 - NO_GROWTH_RADIUS as f32).powi(2);
    // rust: let reach = (24 - NO_GROWTH_RADIUS) * (24 - NO_GROWTH_RADIUS);
    // rust: let factor = 1.0f32.min(outer / reach as f32);
    // rust: 1.max((charge as f32 * factor * 0.5) as i32)
}
    // rust: charge - penalty
}
}
}
    // `SculkBlock.getRandomGrowthState` (not for world generation).
sculk_random_growth :: proc(self: ^Self, pos: BlockPos) -> B {
    // Ported from Horizon
    return {}
}
    // rust: let b = self.b;
    // rust: let state = if self.sculk_rand(11) == 0 {
    // rust: b.default_of(b.named.sculk_shrieker)
    // rust: } else {
    // rust: b.default_of(b.named.sculk_sensor)
}
    // rust: if self.fluid_at(pos) != FluidState::EMPTY {
    // rust: b.table.set_bool(state, b.props.waterlogged, true)
    // rust: } else {
    // rust: state
}
}
    // `SculkBlock.canPlaceGrowth`.
sculk_can_place_growth :: proc(self: ^Self, pos: BlockPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let b = self.b;
    // rust: let state_above = self.state(above(pos));
    // rust: let open = b.is_air(state_above)
    // rust: || (b.is_block(state_above, b.named.water) && b.fluid(state_above).is_source());
    // rust: if !open {
    // rust: return false;
}
    // rust: let mut matched = 0;
    // rust: for dz in -4..=4 {
    // rust: for dy in 0..=2 {
    // rust: for dx in -4..=4 {
    // rust: let state = self.state(pos.offset(dx, dy, dz));
    // rust: if self.sculk_in_tag(state, "minecraft:sculk_growth_inhibitors") {
    // rust: matched += 1;
    // rust: if matched >= 3 {
    // rust: return false;
}
}
}
}
}
    // rust: true
}
    // `SculkVeinBlock.attemptPlaceSculk`.
sculk_place_sculk :: proc(self: ^Self, pos: BlockPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let state = self.state(pos);
    // rust: let mut directions = Direction::ALL;
    // rust: for i in (2..=directions.len()).rev() {
    // rust: let swap = self.sculk_rand(i as i32) as usize;
    // rust: directions.swap(i - 1, swap);
}
    // rust: for support in directions {
    // rust: if !self.vein_has_face(state, support) {
    // rust: continue;
}
    // rust: let support_pos = rel(pos, support);
    // rust: let support_state = self.state(support_pos);
    // rust: if !self.sculk_in_tag(support_state, "minecraft:sculk_replaceable") {
    // rust: continue;
}
    // rust: let default_sculk = self.b.default_of(self.b.named.sculk);
    // rust: self.set_block_and_update(support_pos, default_sculk);
    // rust: self.sculk_sound(support_pos, "minecraft:block.sculk.spread", 1.0, 1.0);
    // rust: self.sculk_spread_all(default_sculk, support_pos, &ALL_SPREADS);
    // rust: let skip = support.opposite();
    // rust: for direction in Direction::ALL {
    // rust: if direction == skip {
    // rust: continue;
}
    // rust: let vein_pos = rel(support_pos, direction);
    // rust: let possible = self.state(vein_pos);
    // rust: if self.is_vein(possible) {
    // rust: self.sculk_on_discharged(Behaviour::Vein, possible, vein_pos);
}
}
    // rust: return true;
}
    // rust: false
}
    // `SculkVeinBlock.onDischarged`.
sculk_on_discharged :: proc(self: ^Self, behaviour: Behaviour, state: BlockStateId, pos: BlockPos) {
}
    // rust: if behaviour != Behaviour::Vein || !self.is_vein(state) {
    // rust: return;
}
    // rust: let b = self.b;
    // rust: let mut state = state;
    // rust: for direction in Direction::ALL {
    // rust: if self.multiface_has_face(state, direction)
    // rust: && b.is_block(self.state(rel(pos, direction)), b.named.sculk)
    // rust: {
    // rust: state = self.vein_with_face(state, direction, false);
}
}
    // rust: if !Direction::ALL
    // rust: .into_iter()
    // rust: .any(|d| self.multiface_has_face(state, d))
    // rust: {
    // rust: state = if self.fluid_at(pos) == FluidState::EMPTY {
    // rust: b.default_of(b.named.air)
    // rust: } else {
    // rust: b.default_of(b.named.water)
}
}
    // rust: self.set_block_and_update(pos, state);
}
    // `ChargeCursor.getValidMovementPos`.
sculk_valid_movement :: proc(self: ^Self, pos: BlockPos) -> O {
    // Ported from Horizon
    return {}
}
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
    // rust: for i in (2..=offsets.len()).rev() {
    // rust: let swap = self.sculk_rand(i as i32) as usize;
    // rust: offsets.swap(i - 1, swap);
}
    // rust: let b = self.b;
    // rust: let mut best = pos;
    // rust: for o in offsets {
    // rust: let neighbour = pos.offset(o[0], o[1], o[2]);
    // rust: let transferee = self.state(neighbour);
    // rust: if self.sculk_behaviour(transferee) == Behaviour::Default
    // rust: || !self.sculk_unobstructed_move(pos, neighbour)
    // rust: {
    // rust: continue;
}
    // rust: best = neighbour;
            // SculkVeinBlock.hasSubstrateAccess
    // rust: if self.is_vein(transferee)
    // rust: && Direction::ALL.into_iter().any(|d| {
    // rust: self.multiface_has_face(transferee, d)
    // rust: && self.sculk_in_tag(
    // rust: self.state(rel(neighbour, d)),
    // rust: "minecraft:sculk_replaceable",
    // rust: )
    // rust: })
    // rust: {
    // rust: break;
}
}
    // rust: let _ = b;
    // rust: (best != pos).then_some(best)
}
sculk_unobstructed_move :: proc(self: ^Self, from: BlockPos, to: BlockPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let manhattan = (from.x - to.x).abs() + (from.y - to.y).abs() + (from.z - to.z).abs();
    // rust: if manhattan == 1 {
    // rust: return true;
}
    // rust: let delta = [to.x - from.x, to.y - from.y, to.z - from.z];
    // rust: let dir_x = if delta[0] < 0 {
    // rust: Direction::West
    // rust: } else {
    // rust: Direction::East
}
    // rust: let dir_y = if delta[1] < 0 {
    // rust: Direction::Down
    // rust: } else {
    // rust: Direction::Up
}
    // rust: let dir_z = if delta[2] < 0 {
    // rust: Direction::North
    // rust: } else {
    // rust: Direction::South
}
    // rust: let (a, c) = if delta[0] == 0 {
    // rust: (dir_y, dir_z)
    // rust: } else if delta[1] == 0 {
    // rust: (dir_x, dir_z)
    // rust: } else {
    // rust: (dir_x, dir_y)
}
    // rust: let free = |direction: Direction| {
    // rust: let test = rel(from, direction);
    // rust: !self
    // rust: .b
    // rust: .is_face_sturdy(self.state(test), direction.opposite())
}
    // rust: free(a) || free(c)
}
}

    // rust: impl Behaviours {
    // `SculkSensorBlock.canActivate`: the sensor is inactive.
sculk_sensor_can_activate :: proc(self: ^Self, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.table.text(state, self.props.sculk_sensor_phase) == "inactive"
}
    // The sensor's phase (`inactive`, `active` or `cooldown`).
sculk_sensor_active :: proc(self: ^Self, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.table.text(state, self.props.sculk_sensor_phase) == "active"
}
    // `SculkSensorBlock.activate` (the state, its ticks and the redstone
    // update); the caller sends the tendril and resonance events.
    // rust: pub fn sculk_sensor_activate<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: power: i32,
    // rust: ) {
    // rust: let mut sim = self.sim(level, ticks);
    // rust: let state = sim.state(pos);
    // rust: let active_ticks = if self.block(state) == self.named.calibrated_sculk_sensor {
    // rust: CALIBRATED_ACTIVE_TICKS
    // rust: } else {
    // rust: SENSOR_ACTIVE_TICKS
}
    // rust: sim.sculk_sensor_activate(pos, state, power, active_ticks);
}
    // The click sound after an activation.
    // rust: pub fn sculk_sensor_click<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: ) {
    // rust: let mut sim = self.sim(level, ticks);
    // rust: let state = sim.state(pos);
    // rust: sim.sculk_sensor_click(pos, state);
}
    // `CalibratedSculkSensorBlockEntity.VibrationUser.getBackSignal`.
    // rust: pub fn calibrated_back_signal<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: ) -> i32 {
    // rust: let sim = self.sim(level, ticks);
    // rust: let state = sim.state(pos);
    // rust: let direction = self.facing(state).opposite();
    // rust: sim.signal(rel(pos, direction), direction)
}
    // `SculkCatalystBlockEntity.CatalystListener.bloom`'s block half.
    // rust: pub fn sculk_catalyst_bloom<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: ) {
    // rust: let mut sim = self.sim(level, ticks);
    // rust: let state = sim.state(pos);
    // rust: if self.block(state) != self.named.sculk_catalyst {
    // rust: return;
}
    // rust: let next = self.table.set_bool(state, self.props.bloom, true);
    // rust: sim.set_block_and_update(pos, next);
    // rust: let block = self.block(state);
    // rust: sim.schedule_tick(pos, block, PULSE_TICKS);
}
    // `SculkShriekerBlockEntity.shriek`'s block half: `shrieking` for 90 ticks.
    // rust: pub fn sculk_shrieker_shriek<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: ) {
    // rust: let mut sim = self.sim(level, ticks);
    // rust: let state = sim.state(pos);
    // rust: if self.block(state) != self.named.sculk_shrieker {
    // rust: return;
}
    // rust: let next = self.table.set_bool(state, self.props.shrieking, true);
    // rust: sim.set_block(pos, next, 2);
    // rust: let block = self.block(state);
    // rust: sim.schedule_tick(pos, block, SHRIEKING_TICKS);
    // rust: sim.level_event(3007, pos, 0);
}
    // `SculkSpreader.updateCursors` for a catalyst at `origin`.
    // rust: pub fn sculk_update_cursors<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: spreader: &mut SculkSpreader,
    // rust: origin: BlockPos,
    // rust: spread_veins: bool,
    // rust: ) {
    // rust: self.sim(level, ticks)
    // rust: .sculk_update_cursors(spreader, origin, spread_veins);
}
}
