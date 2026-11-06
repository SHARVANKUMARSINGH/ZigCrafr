//! Transpiled from Horizon Rust crate
//! Module: horizon-world_entity_fluid
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Entity fluid immersion trackers and current accumulation across update ticks.
// use crate::fluid::{FluidKind, FluidState};
// use horizon_core::{
    // rust: geometry::{Aabb, Vec3},
    // rust: position::BlockPos,
}
// use std::fmt;

pub const FluidTagId = struct {};
    // rust: pub trait FluidMembership {
pub fn fluid_in_tag(self: *Self, fluid: FluidKind, tag: FluidTagId) b;
}
pub const FluidTracker = struct {
    fluid: FluidKind,
    height: f64,
    eyes_inside: bool,
};
pub const CurrentAccumulator = struct {
    height: f64,
    accumulated: Vec3,
    count: i32,
};
    // rust: impl Default for CurrentAccumulator {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: height: 0.0,
    // rust: accumulated: Vec3::ZERO,
    // rust: count: 0,
}
}
}
    // rust: pub trait CurrentTarget {
    // rust: type Error;
pub fn is_player_class(self: *Self) b;
pub fn velocity(self: *Self) R;
    /// Entity.addDeltaMovement, including finite-addition filtering and a fresh
    /// velocity read. Entity-specific overrides remain the provider's dispatch.
pub fn add_delta_movement(self: *Self, delta: Vec3) R;
}
    // rust: impl CurrentAccumulator {
pub fn reset(self: *Self) void {
}
    // rust: *self = Self::default();
}
pub fn accumulate(self: *Self, current: Vec3) void {
}
    // rust: self.accumulated = add(self.accumulated, current);
    // rust: self.count = self.count.wrapping_add(1);
}
    // rust: pub fn apply_to<W: CurrentTarget>(&self, world: &mut W, speed: f64) -> Result<(), W::Error> {
    // rust: if self.count == 0 || self.accumulated.length_squared() < f64::from(1.0e-5f32) {
    // rust: return Ok(());
}
    // rust: let mut current = if world.is_player_class() {
    // rust: self.accumulated.scale(1.0 / f64::from(self.count))
    // rust: } else {
    // rust: self.accumulated.normalize()
}
    // rust: let velocity = world.velocity()?;
    // rust: current = current.scale(speed);
    // rust: if velocity.x.abs() < 0.003
    // rust: && velocity.z.abs() < 0.003
    // rust: && current.length() < 0.0045000000000000005
    // rust: {
    // rust: current = current.normalize().scale(0.0045000000000000005);
}
    // rust: world.add_delta_movement(current)
}
}
pub const FluidSections = struct {
    minimum_section_y: i32,
    has_fluid: *'a [bool],
};
    // rust: pub trait FluidInteractionWorld: FluidMembership {
    // rust: type Error;
    // rust: type Chunk: Copy;
pub fn interaction_box(self: *Self) R;
    /// FULL chunk lookup without generating/loading absent chunks.
pub fn loaded_chunk(self: *Self, x: i32, z: i32) R;
pub fn chunk_sections(self: *Self, chunk: Self::Chunk) R;
pub fn bounding_box_min_y(self: *Self) f;
pub fn block_x(self: *Self) i;
pub fn eye_y(self: *Self) R;
pub fn block_z(self: *Self) i;
pub fn fluid_state(self: *Self, position: BlockPos) R;
pub fn fluid_height(self: *Self, state: FluidState, position: BlockPos) R;
pub fn camera_height(self: *Self, state: FluidState, position: BlockPos) R;
pub fn flow(self: *Self, state: FluidState, position: BlockPos) R;
}
pub const FluidInteractionError = enum {
    World(E),
    NonFiniteBounds,
    BudgetExceeded,
};
    // rust: impl<E: fmt::Display> fmt::Display for FluidInteractionError<E> {
pub fn fmt(self: *Self, f: *mut fmt::Formatter<'_>) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::World(e) => e.fmt(f),
    // rust: Self::NonFiniteBounds => f.write_str("nonfinite immersion bounds"),
    // rust: Self::BudgetExceeded => f.write_str("immersion query budget exceeded"),
}
}
}
    // rust: impl<E: std::error::Error + 'static> std::error::Error for FluidInteractionError<E> {}
    // rust: fn spend<E>(budget: &mut usize) -> Result<(), FluidInteractionError<E>> {
    // rust: if *budget == 0 {
    // rust: return Err(FluidInteractionError::BudgetExceeded);
}
    // rust: *budget -= 1;
    // rust: Ok(())
}
pub fn add(a: Vec3, b: Vec3) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Vec3::new(a.x + b.x, a.y + b.y, a.z + b.z)
}
pub fn java_max(a: f64, b: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if a.is_nan() {
    // rust: a
    // rust: } else if b.is_nan() {
    // rust: b
    // rust: } else if a == 0.0 && b == 0.0 {
    // rust: f64::from_bits(a.to_bits() & b.to_bits())
    // rust: } else {
    // rust: a.max(b)
}
}
/// Every required chunk must be loaded, even after a wet section is found.
/// Chunk order is Z then X; section order is ascending Y without early success.
    // rust: pub fn has_fluid_and_loaded<W: FluidInteractionWorld>(
    // rust: world: &mut W,
    // rust: min: BlockPos,
    // rust: max: BlockPos,
    // rust: budget: &mut usize,
    // rust: ) -> Result<bool, FluidInteractionError<W::Error>> {
    // rust: let mut present = false;
    // rust: for z in (min.z >> 4)..=(max.z >> 4) {
    // rust: for x in (min.x >> 4)..=(max.x >> 4) {
    // rust: spend(budget)?;
    // rust: let Some(chunk) = world
    // rust: .loaded_chunk(x, z)
    // rust: .map_err(FluidInteractionError::World)?
    // rust: else {
    // rust: return Ok(false);
}
    // rust: let sections = world
    // rust: .chunk_sections(chunk)
    // rust: .map_err(FluidInteractionError::World)?;
    // rust: for y in (min.y >> 4)..=(max.y >> 4) {
    // rust: spend(budget)?;
    // rust: let index = y.wrapping_sub(sections.minimum_section_y);
    // rust: if index >= 0 && (index as usize) < sections.has_fluid.len() {
    // rust: present |= sections.has_fluid[index as usize];
}
}
}
}
    // rust: Ok(present)
}
pub const EntityFluidInteraction = struct {
    trackers: std.ArrayList(FluidTracker),
    currents: Vec<(FluidTagId,
};
    // rust: impl EntityFluidInteraction {
    /// Preserve the caller's tag-set iteration order: a fluid's current belongs
    /// to the first matching tag, even when several tags contain that fluid.
pub fn new(tags: impl IntoIterator<Item = FluidTagId>) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut state = Self::default();
    // rust: for tag in tags {
    // rust: if !state.currents.iter().any(|(t, _)| *t == tag) {
    // rust: state.currents.push((tag, CurrentAccumulator::default()));
}
}
    // rust: state
}
pub fn trackers(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.trackers
}
pub fn currents(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.currents
}
    // rust: pub fn fluid_height<W: FluidMembership>(&self, tags: &W, tag: FluidTagId) -> f64 {
    // rust: let mut height = 0.0;
    // rust: for t in &self.trackers {
    // rust: if t.height > height && tags.fluid_in_tag(t.fluid, tag) {
    // rust: height = t.height;
}
}
    // rust: height
}
    // rust: pub fn is_in_fluid<W: FluidMembership>(&self, tags: &W, tag: FluidTagId) -> bool {
    // rust: self.fluid_height(tags, tag) > 0.0
}
    // rust: pub fn is_eye_in_fluid<W: FluidMembership>(&self, tags: &W, tag: FluidTagId) -> bool {
    // rust: self.trackers
    // rust: .iter()
    // rust: .any(|t| t.eyes_inside && tags.fluid_in_tag(t.fluid, tag))
}
    // rust: pub fn apply_current<W: CurrentTarget>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: tag: FluidTagId,
    // rust: speed: f64,
    // rust: ) -> Result<(), W::Error> {
    // rust: if let Some((_, current)) = self.currents.iter().find(|(t, _)| *t == tag) {
    // rust: current.apply_to(world, speed)?;
}
    // rust: Ok(())
}
    /// Reset previous tick state before any query. Provider failures and budget
    /// exhaustion retain all preceding tracker/current writes.
    // rust: pub fn update<W: FluidInteractionWorld>(
    // rust: &mut self,
    // rust: world: &mut W,
    // rust: ignore_current: bool,
    // rust: mut budget: usize,
    // rust: ) -> Result<bool, FluidInteractionError<W::Error>> {
    // rust: self.trackers.retain_mut(|t| {
    // rust: if t.height == 0.0 && !t.eyes_inside {
    // rust: return false;
}
    // rust: t.height = 0.0;
    // rust: t.eyes_inside = false;
    // rust: true
    // rust: });
    // rust: for (_, c) in &mut self.currents {
    // rust: c.reset();
}
    // rust: let Some(bounds) = world
    // rust: .interaction_box()
    // rust: .map_err(FluidInteractionError::World)?
    // rust: else {
    // rust: return Ok(false);
}
    // rust: let a = bounds.min_position();
    // rust: let b = bounds.max_position();
    // rust: if [a.x, a.y, a.z, b.x, b.y, b.z]
    // rust: .iter()
    // rust: .any(|v| !v.is_finite())
    // rust: {
    // rust: return Err(FluidInteractionError::NonFiniteBounds);
}
    // rust: let low = BlockPos::new(a.x.floor() as i32, a.y.floor() as i32, a.z.floor() as i32);
    // rust: let high = BlockPos::new(
    // rust: (b.x.ceil() as i32).wrapping_sub(1),
    // rust: (b.y.ceil() as i32).wrapping_sub(1),
    // rust: (b.z.ceil() as i32).wrapping_sub(1),
    // rust: );
    // rust: if !has_fluid_and_loaded(
    // rust: world,
    // rust: BlockPos::new(low.x.wrapping_sub(1), low.y, low.z.wrapping_sub(1)),
    // rust: BlockPos::new(high.x.wrapping_add(1), high.y, high.z.wrapping_add(1)),
    // rust: &mut budget,
    // rust: )? {
    // rust: return Ok(false);
}
    // rust: let base_y = world.bounding_box_min_y();
    // rust: let block_x = world.block_x();
    // rust: let eye = world.eye_y().map_err(FluidInteractionError::World)?;
    // rust: let block_z = world.block_z();
    // rust: let mut last: Option<(FluidKind, usize, Option<usize>)> = None;
    // rust: for x in low.x..=high.x {
    // rust: for y in low.y..=high.y {
    // rust: for z in low.z..=high.z {
    // rust: spend(&mut budget)?;
    // rust: let p = BlockPos::new(x, y, z);
    // rust: let state = world.fluid_state(p).map_err(FluidInteractionError::World)?;
    // rust: if state.kind() == FluidKind::Empty {
    // rust: continue;
}
    // rust: let surface = f64::from(y)
    // rust: + f64::from(
    // rust: world
    // rust: .fluid_height(state, p)
    // rust: .map_err(FluidInteractionError::World)?,
    // rust: );
    // rust: if surface < a.y {
    // rust: continue;
}
    // rust: let kind = state.kind();
    // rust: let (_, index, current) = if let Some(last) =
    // rust: last.filter(|(k, _, _)| *k == kind)
    // rust: {
    // rust: last
    // rust: } else {
    // rust: let index =
    // rust: if let Some(i) = self.trackers.iter().position(|t| t.fluid == kind) {
    // rust: i
    // rust: } else {
    // rust: self.trackers.push(FluidTracker {
    // rust: fluid: kind,
    // rust: height: 0.0,
    // rust: eyes_inside: false,
    // rust: });
    // rust: self.trackers.len() - 1
}
    // rust: let current = if ignore_current {
    // rust: None
    // rust: } else {
    // rust: self.currents
    // rust: .iter()
    // rust: .position(|(tag, _)| world.fluid_in_tag(kind, *tag))
}
    // rust: let entry = (kind, index, current);
    // rust: last = Some(entry);
    // rust: entry
}
    // rust: if x == block_x && z == block_z && eye >= f64::from(y) {
    // rust: let top = f64::from(y)
    // rust: + f64::from(
    // rust: world
    // rust: .camera_height(state, p)
    // rust: .map_err(FluidInteractionError::World)?,
    // rust: );
    // rust: if eye <= top {
    // rust: self.trackers[index].eyes_inside = true;
}
}
    // rust: self.trackers[index].height =
    // rust: java_max(surface - base_y, self.trackers[index].height);
    // rust: if let Some(i) = current {
    // rust: let mut flow =
    // rust: world.flow(state, p).map_err(FluidInteractionError::World)?;
    // rust: let c = &mut self.currents[i].1;
    // rust: c.height = java_max(self.trackers[index].height, c.height);
    // rust: if c.height < 0.4 {
    // rust: flow = flow.scale(c.height);
}
    // rust: c.accumulate(flow);
}
}
}
}
    // rust: Ok(last.is_some())
}
}

    // rust: mod tests {
//     use super::*;

    /// A body the accumulator pushes: the player flag and the velocity it
    /// reads are the only things `apply_to` asks for.
pub const Body = struct {
    player: bool,
    velocity: Vec3,
    added: Vec3,
};
    // rust: impl CurrentTarget for Body {
    // rust: type Error = std::convert::Infallible;
pub fn is_player_class(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player
}
pub fn velocity(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.velocity)
}
pub fn add_delta_movement(self: *Self, delta: Vec3) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.added = self.added.add_vector(delta);
    // rust: Ok(())
}
}

    /// `EntityFluidInteraction$CurrentAccumulator.applyTo`: a body that is not
    /// a player takes the direction of the accumulated current, so two samples
    /// of one block push as hard as one; a player takes their average, so the
    /// push grows with the number of blocks and is halved by two of them.
pub fn a_current_pushes_a_player_by_its_average_and_anything_else_by_its_direction() void {
}
    // rust: let mut acc = CurrentAccumulator::default();
    // rust: acc.accumulate(Vec3::new(1.0, 0.0, 0.0));
    // rust: let mut mob = Body {
    // rust: player: false,
    // rust: velocity: Vec3::ZERO,
    // rust: added: Vec3::ZERO,
}
    // rust: acc.apply_to(&mut mob, 0.014).unwrap();
    // rust: assert!((mob.added.x - 0.014).abs() < 1e-12, "mob: {}", mob.added.x);
    // rust: acc.accumulate(Vec3::new(1.0, 0.0, 0.0));
    // rust: let mut mob = Body {
    // rust: player: false,
    // rust: velocity: Vec3::ZERO,
    // rust: added: Vec3::ZERO,
}
    // rust: acc.apply_to(&mut mob, 0.014).unwrap();
    // rust: assert!(
    // rust: (mob.added.x - 0.014).abs() < 1e-12,
    // rust: "a second sample does not double a mob's push: {}",
    // rust: mob.added.x
    // rust: );
    // rust: let mut player = Body {
    // rust: player: true,
    // rust: velocity: Vec3::ZERO,
    // rust: added: Vec3::ZERO,
}
    // rust: acc.apply_to(&mut player, 0.014).unwrap();
    // rust: assert!(
    // rust: (player.added.x - 0.014).abs() < 1e-12,
    // rust: "the average of two (1,0,0) samples is (1,0,0): {}",
    // rust: player.added.x
    // rust: );
}

    /// The same body with a single weak sample: the average is (0.5,0,0) for a
    /// player, and a nearly still body gets the 0.0045 lift either way.
pub fn a_weak_current_on_a_still_body_is_lifted_to_the_minimum() void {
}
    // rust: let mut acc = CurrentAccumulator::default();
        // A tenth of a block a tick: 0.0014 once scaled, under the minimum.
    // rust: acc.accumulate(Vec3::new(0.1, 0.0, 0.0));
    // rust: let mut player = Body {
    // rust: player: true,
    // rust: velocity: Vec3::ZERO,
    // rust: added: Vec3::ZERO,
}
    // rust: acc.apply_to(&mut player, 0.014).unwrap();
    // rust: assert!(
    // rust: (player.added.x - 0.0045).abs() < 1e-12,
    // rust: "{}",
    // rust: player.added.x
    // rust: );
        // A body that is already moving on x or z takes the small push as it is.
    // rust: let mut moving = Body {
    // rust: player: true,
    // rust: velocity: Vec3::new(0.05, 0.0, 0.0),
    // rust: added: Vec3::ZERO,
}
    // rust: acc.apply_to(&mut moving, 0.014).unwrap();
    // rust: assert!(
    // rust: (moving.added.x - 0.0014).abs() < 1e-12,
    // rust: "{}",
    // rust: moving.added.x
    // rust: );
}

    /// `applyTo` returns before reading the velocity with no samples, and when
    /// the accumulated current is under the 1e-5 of a squared length.
pub fn no_current_and_a_current_under_the_threshold_push_nothing() void {
}
    // rust: let mut body = Body {
    // rust: player: false,
    // rust: velocity: Vec3::ZERO,
    // rust: added: Vec3::ZERO,
}
    // rust: CurrentAccumulator::default()
    // rust: .apply_to(&mut body, 0.014)
    // rust: .unwrap();
    // rust: assert_eq!(body.added, Vec3::ZERO);
    // rust: let mut acc = CurrentAccumulator::default();
    // rust: acc.accumulate(Vec3::new(0.001, 0.0, 0.0));
    // rust: acc.apply_to(&mut body, 0.014).unwrap();
    // rust: assert_eq!(body.added, Vec3::ZERO);
}
}
