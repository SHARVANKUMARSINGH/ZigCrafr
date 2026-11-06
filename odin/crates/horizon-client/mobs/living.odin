//! Transpiled from Horizon Rust crate
package horizon_client_living

import "core:fmt"
import "core:mem"
import "core:math"

// `LivingEntity` movement for mobs: `aiStep` input decay and jumping,
// `travel` in air, water and lava (friction-scaled acceleration, gravity,
// fluid slowdown and falling adjustment), fluid immersion heights, fall
// damage, fire and the walk animation.
// use super::{Mob, MobEvent, MobWorld};
// use crate::{
    // rust: blocks::Fluid,
    // rust: collisions::{PowderSnowSubject, SceneCollisions},
}
// use horizon_core::{
    // rust: geometry::{Aabb, Vec3, trig},
    // rust: position::BlockPos,
    // rust: random::RandomSource,
}
// use horizon_world::{
    // rust: block_landing::LandingEntityKind,
    // rust: entity_fluid::{CurrentAccumulator, CurrentTarget},
    // rust: fluid::{FluidKind, FluidState},
    // rust: fluid_flow::{FluidFlowWorld, flow_at},
    // rust: movement_restitution::{RestitutionInput, RestitutionWorld, restitute_movement},
    // rust: registry::BlockStateId,
}

// How many block particles a landing throws up
// (`(int)(min(0.2F + power / 15, 2.5) * 150)`), none when the fall is within
// `safe_fall_distance` (`power = max(floor(fall + 1.0E-6 - safe), 0)`).
landing_dust_count :: proc(fall_distance: f64, safe_fall_distance: f64) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let power = f64::from(((fall_distance + 1.0e-6 - safe_fall_distance).floor() as i32).max(0));
    // rust: (power > 0.0).then(|| (150.0 * (f64::from(0.2_f32) + power / 15.0).min(2.5)) as i32)
}
// Where the dust starts: at the mob, or, when its own block is not the one it
// landed on (`landing`), on that block's face toward the mob.
landing_dust_at :: proc(position: Vec3, landing: [i32; 3]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: if landing[0] == position.x.floor() as i32 && landing[2] == position.z.floor() as i32 {
    // rust: return position;
}
    // rust: let dx = position.x - f64::from(landing[0]) - 0.5;
    // rust: let dz = position.z - f64::from(landing[2]) - 0.5;
    // rust: let scale = dx.abs().max(dz.abs());
    // rust: Vec3::new(
    // rust: f64::from(landing[0]) + 0.5 + dx / scale * 0.5,
    // rust: position.y,
    // rust: f64::from(landing[2]) + 0.5 + dz / scale * 0.5,
    // rust: )
}

// `Entity.moveDist`, `flyDist`, `nextStep` and `Parrot.nextFlap`.
Steps :: struct {
    move_dist: f32,
    fly_dist: f32,
    next_step: f32,
    next_flap: f32,
    // `AbstractHorse.gallopSoundCounter`.
    gallop: i32,
}
    // rust: impl Default for Steps {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: move_dist: 0.0,
    // rust: fly_dist: 0.0,
    // rust: next_step: 1.0,
    // rust: next_flap: 1.0,
    // rust: gallop: 0,
}
}
}
Fluids :: struct {
    water: f64,
    lava: f64,
    in_water: bool,
    in_lava: bool,
    eye_in_water: bool,
}
// `FluidFlowWorld` over the mob's scene: the neighbours a flow vector reads.
FlowScene :: struct {
    // rust: impl FluidFlowWorld for FlowScene<'_, '_> {
    // rust: type Error = std::convert::Infallible;
    // rust: type Block = BlockStateId;
fluid :: proc(self: ^Self, p: BlockPos) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.0.fluid_tables.fluid(self.0.world.block(p.x, p.y, p.z)))
}
block :: proc(self: ^Self, p: BlockPos) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.0.world.block(p.x, p.y, p.z))
}
blocks_fluid_flow :: proc(self: ^Self, s: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.0.fluid_tables.blocks_flow(s)
}
is_ice_class :: proc(self: ^Self, s: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.0.fluid_tables.ice(s)
}
    // rust: fn is_face_sturdy(
    // rust: &mut self,
    // rust: s: BlockStateId,
    // rust: _: BlockPos,
    // rust: d: horizon_core::geometry::Direction,
    // rust: ) -> Result<bool, Self::Error> {
    // rust: Ok(self.0.fluid_tables.sturdy(s, d))
}
}
// The mob's velocity, for `CurrentAccumulator::apply_to`.
Pushed :: struct {
    // rust: impl CurrentTarget for Pushed<'_> {
    // rust: type Error = std::convert::Infallible;
is_player_class :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
velocity :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(*self.0)
}
add_delta_movement :: proc(self: ^Self, delta: Vec3) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let sum = Vec3::new(self.0.x + delta.x, self.0.y + delta.y, self.0.z + delta.z);
    // rust: if delta.is_finite() && sum.is_finite() {
    // rust: *self.0 = sum;
}
    // rust: Ok(())
}
}
wrap :: proc(a: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let mut a = a % 360.0;
    // rust: if a >= 180.0 {
    // rust: a -= 360.0;
}
    // rust: if a < -180.0 {
    // rust: a += 360.0;
}
    // rust: a
}
    // rust: impl MobWorld<'_> {
    // FluidState.getHeight: a full block under the same fluid, else amount / 9.
fluid_height :: proc(self: ^Self, x: i32, y: i32, z: i32) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let f = self.facts.get(self.world.block(x, y, z));
    // rust: if f.fluid == Fluid::None {
    // rust: return (Fluid::None, 0.0);
}
    // rust: let above = self.facts.get(self.world.block(x, y + 1, z));
    // rust: if above.fluid == f.fluid {
    // rust: return (f.fluid, 1.0);
}
    // rust: (f.fluid, f64::from(f.fluid_level) / 9.0)
}
    // Entity.updateFluidHeightAndDoFluidPushing heights over the deflated box.
fluids :: proc(self: ^Self, bounds: Aabb, eye_y: f64) -> F {
    // Ported from Horizon
    return {}
}
    // rust: let b = bounds.deflate(Vec3::new(0.001, 0.001, 0.001));
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: let mut out = Fluids::default();
        // The eye column below, in the box but for a box thinner than the
        // deflation.
    // rust: let (ex, ez) = (
    // rust: ((lo.x + hi.x) / 2.0).floor() as i32,
    // rust: ((lo.z + hi.z) / 2.0).floor() as i32,
    // rust: );
        // Most boxes are in sections without a fluid: no cell to read.
    // rust: let cells = (
    // rust: [
    // rust: (lo.x.floor() as i32).min(ex),
    // rust: lo.y.floor() as i32,
    // rust: (lo.z.floor() as i32).min(ez),
    // rust: ],
    // rust: [
    // rust: (hi.x.ceil() as i32 - 1).max(ex),
    // rust: hi.y.ceil() as i32 - 1,
    // rust: (hi.z.ceil() as i32 - 1).max(ez),
    // rust: ],
    // rust: );
    // rust: if !self
    // rust: .world
    // rust: .may_hold(cells.0, cells.1, |s| self.facts.get(s).fluid != Fluid::None)
    // rust: {
    // rust: return out;
}
    // rust: for x in lo.x.floor() as i32..=(hi.x.ceil() as i32 - 1) {
    // rust: for y in lo.y.floor() as i32..=(hi.y.ceil() as i32 - 1) {
    // rust: for z in lo.z.floor() as i32..=(hi.z.ceil() as i32 - 1) {
    // rust: let (fluid, h) = self.fluid_height(x, y, z);
    // rust: if fluid == Fluid::None {
    // rust: continue;
}
    // rust: let top = f64::from(y) + h;
    // rust: if top >= lo.y {
    // rust: let depth = top - lo.y;
    // rust: match fluid {
    // rust: Fluid::Water => {
    // rust: out.water = out.water.max(depth);
    // rust: out.in_water = true;
}
    // rust: Fluid::Lava => {
    // rust: out.lava = out.lava.max(depth);
    // rust: out.in_lava = true;
}
    // rust: Fluid::None => {}
}
}
}
}
}
        // EntityFluidInteraction.update: the eyes are in a fluid block of
        // the box in the entity's column, between its bottom and its height
        // for the camera.
    // rust: for y in lo.y.floor() as i32..=(hi.y.ceil() as i32 - 1) {
    // rust: let (fluid, h) = self.fluid_height(ex, y, ez);
    // rust: if fluid != Fluid::Water || f64::from(y) + h < lo.y || eye_y < f64::from(y) {
    // rust: continue;
}
    // rust: let state = self.world.block(ex, y, ez);
    // rust: let source = self
    // rust: .registry
    // rust: .state(state)
    // rust: .and_then(|s| s.properties.get("level"))
    // rust: .is_none_or(|l| l == "0");
    // rust: let above = self.facts.get(self.world.block(ex, y + 1, ez));
    // rust: let camera = if source && above.sturdy_full & 1 != 0 {
    // rust: 1.0
    // rust: } else {
    // rust: h
}
    // rust: if eye_y <= f64::from(y) + camera {
    // rust: out.eye_in_water = true;
}
}
    // rust: out
}
    // Entity.updateFluidHeightAndDoFluidPushing's currents over the deflated
    // box: the flow of every water and lava block it touches, summed (a thin
    // fluid layer scales its flow down), as (water, lava).
fluid_currents :: proc(self: ^Self, bounds: Aabb) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let base_y = bounds.min_position().y;
    // rust: let b = bounds.deflate(Vec3::new(0.001, 0.001, 0.001));
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: let mut scene = FlowScene(self);
    // rust: let (mut water, mut lava) = (CurrentAccumulator::default(), CurrentAccumulator::default());
    // rust: for x in lo.x.floor() as i32..=(hi.x.ceil() as i32 - 1) {
    // rust: for y in lo.y.floor() as i32..=(hi.y.ceil() as i32 - 1) {
    // rust: for z in lo.z.floor() as i32..=(hi.z.ceil() as i32 - 1) {
    // rust: let p = BlockPos::new(x, y, z);
    // rust: let state = self.fluid_tables.fluid(self.world.block(x, y, z));
    // rust: let current = match state.kind() {
    // rust: FluidKind::Empty => continue,
    // rust: FluidKind::Water | FluidKind::FlowingWater => &mut water,
    // rust: FluidKind::Lava | FluidKind::FlowingLava => &mut lava,
}
    // rust: let surface = f64::from(y) + self.fluid_height(x, y, z).1;
    // rust: if surface < lo.y {
    // rust: continue;
}
    // rust: current.height = current.height.max(surface - base_y);
    // rust: let mut flow = flow_at(&mut scene, state, p).unwrap_or(Vec3::ZERO);
    // rust: if current.height < 0.4 {
    // rust: flow = flow.scale(current.height);
}
    // rust: current.accumulate(flow);
}
}
}
    // rust: (water, lava)
}
    // `BlockState.getCollisionShape(level, pos)` (the empty collision
    // context) as boxes in the world.
block_collision_boxes :: proc(self: ^Self, x: i32, y: i32, z: i32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut scene = SceneCollisions {
    // rust: world: self.world,
    // rust: binding: self.collision,
    // rust: subject: None,
}
    // rust: let state = self.world.block(x, y, z);
    // rust: let at = horizon_core::position::BlockPos::new(x, y, z);
    // rust: let context = horizon_world::collision_context::CollisionContext::empty(false);
    // rust: let offset = Vec3::new(f64::from(x), f64::from(y), f64::from(z));
    // rust: self.collision
    // rust: .collision_shape_with_context(&mut scene, state, at, &context)
    // rust: .map(|shape| shape.boxes().iter().map(|b| b.move_by(offset)).collect())
    // rust: .unwrap_or_default()
}
    // `Level.findSupportingBlock`: of the blocks whose collision shape
    // meets `area`, the one whose centre is nearest `from` (ties: the
    // greatest by `Vec3i.compareTo`, y then z then x).
    //
    // Like `BlockCollisions`' cursor, a block whose shape stays inside its
    // own cell (not `hasLargeCollisionShape`, not a moving piston) is only
    // shaped when that cell meets `area`: elsewhere it cannot. The pick is
    // a total order, so the column-by-column visit finds the same block.
supporting_block :: proc(self: ^Self, area: Aabb, from: Vec3) -> O {
    // Ported from Horizon
    return {}
}
//         use horizon_core::geometry::Axis;
    // rust: let range = |axis| {
    // rust: (area.min(axis) - 1.0e-7).floor() as i32 - 1
    // rust: ..=(area.max(axis) + 1.0e-7).floor() as i32 + 1
}
        // Aabb.intersects of the unit cell at `c` along one axis.
    // rust: let meets = |axis, c: i32| {
    // rust: let c = f64::from(c);
    // rust: c < area.max(axis) && c + 1.0 > area.min(axis)
}
        // Where no section of the cursor holds a block reaching out of its
        // cell, only the cells meeting `area` can hold the support.
    // rust: let (rx, ry, rz) = (range(Axis::X), range(Axis::Y), range(Axis::Z));
    // rust: let outer = self.world.may_hold(
    // rust: [*rx.start(), *ry.start(), *rz.start()],
    // rust: [*rx.end(), *ry.end(), *rz.end()],
    // rust: |s| self.collision.reaches_out(s),
    // rust: );
    // rust: let mut best: Option<(f64, [i32; 3])> = None;
    // rust: for x in rx {
    // rust: for z in rz.clone() {
    // rust: let column = meets(Axis::X, x) && meets(Axis::Z, z);
    // rust: if !outer && !column {
    // rust: continue;
}
    // rust: let Some(chunk) = self.world.chunks.get(&(x >> 4, z >> 4)) else {
    // rust: continue;
}
    // rust: for y in ry.clone() {
    // rust: if !outer && !meets(Axis::Y, y) {
    // rust: continue;
}
    // rust: let state = chunk.block(x & 15, y, z & 15);
    // rust: let Ok(block) = self.collision.collision_block(state) else {
    // rust: continue;
}
    // rust: if !(block.large_collision_shape
    // rust: || block.moving_piston
    // rust: || (column && meets(Axis::Y, y)))
    // rust: {
    // rust: continue;
}
    // rust: if !self
    // rust: .block_collision_boxes(x, y, z)
    // rust: .iter()
    // rust: .any(|b| b.intersects(area))
    // rust: {
    // rust: continue;
}
    // rust: let d = (f64::from(x) + 0.5 - from.x).powi(2)
    // rust: + (f64::from(y) + 0.5 - from.y).powi(2)
    // rust: + (f64::from(z) + 0.5 - from.z).powi(2);
    // rust: let greater = |b: [i32; 3]| (y, z, x) > (b[1], b[2], b[0]);
    // rust: if best.is_none_or(|(bd, b)| d < bd || d == bd && greater(b)) {
    // rust: best = Some((d, [x, y, z]));
}
}
}
}
    // rust: best.map(|(_, p)| p)
}
no_collision :: proc(self: ^Self, b: Aabb) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let mut scene = SceneCollisions {
    // rust: world: self.world,
    // rust: binding: self.collision,
    // rust: subject: None,
}
    // rust: scene.unobstructed(b).unwrap_or(false)
}
    // `LevelReader.containsAnyLiquid`: the blocks from the box's minimum
    // corner to the block holding its maximum corner.
contains_any_liquid :: proc(self: ^Self, b: Aabb) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: let (x0, y0, z0) = (
    // rust: lo.x.floor() as i32,
    // rust: lo.y.floor() as i32,
    // rust: lo.z.floor() as i32,
    // rust: );
    // rust: let (x1, y1, z1) = (
    // rust: hi.x.floor() as i32,
    // rust: hi.y.floor() as i32,
    // rust: hi.z.floor() as i32,
    // rust: );
    // rust: (x0..=x1).any(|x| {
    // rust: (y0..=y1).any(|y| {
    // rust: (z0..=z1).any(|z| self.facts.get(self.world.block(x, y, z)).fluid != Fluid::None)
    // rust: })
    // rust: })
}
}
    // rust: impl Mob {
    // `Entity.refreshDimensions` after growing from `old_w` by `old_h`:
    // `fudgePositionAfterSizeChange` moves the mob to the free spot nearest
    // its old centre where the bigger box fits (`findFreePosition`), or
    // failing that, one that fits at the old height.
fudge_position_after_size_change :: proc(self: ^Self, w: ^MobWorld, old_w: f64, old_h: f64) {
}
    // rust: let (new_w, new_h, _) = self.dims();
    // rust: let small = new_w <= 4.0 && new_h <= 4.0;
    // rust: if self.age == 0 || self.no_physics() || !small || !(new_w > old_w || new_h > old_h) {
    // rust: return;
}
    // rust: let center = Vec3::new(
    // rust: self.position.x,
    // rust: self.position.y + old_h / 2.0,
    // rust: self.position.z,
    // rust: );
    // rust: let dw = (new_w - old_w).max(0.0) + 1.0e-6;
    // rust: let dh = (new_h - old_h).max(0.0) + 1.0e-6;
    // rust: let at = |allowed: Aabb, size_y: f64| free_position(w, allowed, center, new_w, size_y);
    // rust: if let Some(p) = at(Aabb::of_size(center, Vec3::new(dw, dh, dw)), new_h) {
    // rust: self.position = Vec3::new(p.x, p.y - new_h / 2.0, p.z);
    // rust: return;
}
    // rust: if new_w > old_w
    // rust: && new_h > old_h
    // rust: && let Some(p) = at(Aabb::of_size(center, Vec3::new(dw, 1.0e-6, dw)), old_h)
    // rust: {
    // rust: self.position = Vec3::new(p.x, p.y - old_h / 2.0 + 1.0e-6, p.z);
}
}
no_physics :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
eye_y :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.position.y + self.eye_height()
}
    // `LivingEntity.onClimbable` (`Spider.onClimbable`: the climbing flag):
    // the block it stands in is `#minecraft:climbable` (vines, ladders,
    // scaffolding...), or an open trapdoor over a ladder facing the same way
    // (`trapdoorUsableAsLadder`). A mob gliding (`isFallFlying`) through a
    // `#minecraft:can_glide_through` block (vines) is not on it: that test
    // comes first.
on_climbable :: proc(self: ^Self, w: ^MobWorld) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if self.kind.flags.climber {
    // rust: return self.climbing;
}
    // rust: let (x, y, z) = (
    // rust: self.position.x.floor() as i32,
    // rust: self.position.y.floor() as i32,
    // rust: self.position.z.floor() as i32,
    // rust: );
    // rust: let state = w.world.block(x, y, z);
    // rust: let facts = w.facts.get(state);
    // rust: if self.extra.fall_flying && w.has_tag("minecraft:can_glide_through", &facts.name) {
    // rust: return false;
}
    // rust: if w.has_tag("minecraft:climbable", &facts.name) {
    // rust: return true;
}
    // rust: facts.has_class("TrapDoorBlock")
    // rust: && w.prop(x, y, z, "open") == Some("true")
    // rust: && w.block_name(x, y - 1, z) == "minecraft:ladder"
    // rust: && w.prop(x, y - 1, z, "facing") == w.prop(x, y, z, "facing")
}
    // `LivingEntity.getScale`: the `minecraft:scale` the server sent on this
    // living entity (`extra.model_scale`, 0 when none came), through the
    // species' `sanitizeScale` override. Every box, eye height, seat and
    // shadow radius takes it.
model_scale :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let scale = if self.extra.model_scale > 0.0 {
    // rust: self.extra.model_scale
    // rust: } else {
    // rust: 1.0
}
    // rust: match self.species() {
            // HappyGhast.sanitizeScale: min(scale, 1), it never grows.
    // rust: super::Species::HappyGhast => scale.min(1.0),
            // Shulker.sanitizeScale: min(scale, 3).
    // rust: super::Species::Shulker => scale.min(3.0),
    // rust: _ => scale,
}
}
    // Entity dimensions: the type's, a class's BABY_DIMENSIONS, or the
    // slime size scaling.
    // `EntityDimensions` (float width, height and eye height) widened to double.
dims :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
        // LivingEntity.SLEEPING_DIMENSIONS.
    // rust: if super::villager::sleeping(self) {
    // rust: return (f64::from(0.2_f32), f64::from(0.2_f32), f64::from(0.2_f32));
}
    // rust: self.awake_dims()
}
    // `dims` without the sleeping box: a sleeping villager's
    // `getDimensions(Pose.STANDING)`, whose eye height lays it in the bed
    // (`LivingEntityRenderer.submit`).
awake_dims :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: self.awake_dims_in(self.extra.pose == super::sync::LONG_JUMPING)
}
    // `Entity.getDimensions(Pose)` of the standing pose, or of
    // `Pose.LONG_JUMPING` (what `LongJumpUtil` checks an arc with).
awake_dims_in :: proc(self: ^Self, long_jumping: bool) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let k = &self.kind;
        // `LivingEntity.getDimensions` is `getDefaultDimensions(pose).scale(
        // getScale())` on every living entity: the species' box (a player's or
        // mannequin's follows its pose, Avatar.POSES) times its
        // `minecraft:scale` (`getScale`), width, height and eye height alike.
    // rust: let scale = self.model_scale();
    // rust: if matches!(&*k.id, "minecraft:player" | "minecraft:mannequin") {
    // rust: let d = self.extra.avatar_pose.dimensions(scale);
    // rust: return (
    // rust: f64::from(d.width),
    // rust: f64::from(d.height),
    // rust: f64::from(d.eye_height),
    // rust: );
}
    // rust: let (mut w, mut h, mut e) = (k.width as f32, k.height as f32, k.eye_height as f32);
        // Sniffer.DIGGING_DIMENSIONS: 0.4 lower, its eyes at 0.81.
    // rust: if k.species == super::Species::Sniffer && super::sniffer::digging(self) {
    // rust: (h, e) = (h - 0.4, 0.81);
}
    // rust: if self.is_baby() {
    // rust: match super::species::def(k.species).baby {
    // rust: super::species::Baby::Abs(bw, bh, be) => {
    // rust: (w, h, e) = (bw as f32, bh as f32, be as f32)
}
    // rust: super::species::Baby::Scale(s, eye) => {
    // rust: let s = s as f32;
    // rust: (w, h, e) = (w * s, h * s, eye.map_or(e * s, |x| x as f32))
}
    // rust: super::species::Baby::None => {}
}
}
        // Goat.getDefaultDimensions: a long jump scales the box by 0.7.
    // rust: if long_jumping && k.species == super::Species::Goat {
    // rust: (w, h, e) = (w * 0.7_f32, h * 0.7_f32, e * 0.7_f32);
}
        // Camel.getDefaultDimensions: a sitting camel is lower.
    // rust: if super::camel::is_camel(k.species) && super::camel::sitting(self) {
    // rust: (w, h, e) = super::camel::sitting_dims(self.is_baby());
}
        // Warden.getDefaultDimensions: a metre tall while digging or emerging.
    // rust: if self.kind.species == super::Species::Warden && super::warden::digging_or_emerging(self) {
    // rust: h = 1.0;
    // rust: e = 0.85;
}
    // rust: if self.kind.species == super::Species::Pufferfish {
    // rust: let s = super::aquatic::puff_scale(self.extra.size) as f32;
    // rust: (w, h, e) = (w * s, h * s, e * s);
    // rust: } else if self.kind.species == super::Species::Phantom {
            // Phantom.getDefaultDimensions: 1 + 0.15 per size.
    // rust: let s = 1.0 + 0.15 * self.extra.size as f32;
    // rust: (w, h, e) = (w * s, h * s, e * s);
    // rust: } else if self.extra.size > 0 {
    // rust: let s = self.extra.size as f32;
    // rust: (w, h, e) = (w * s, h * s, e * s);
}
        // Shulker.getDefaultDimensions: the last scale, over everything
        // above, is the lid opening upward on a shell attached to the floor.
    // rust: if k.species == super::Species::Shulker
    // rust: && let Some(s) = super::shulker::peek_height_scale(self)
    // rust: {
    // rust: (h, e) = (h * s, e * s);
}
        // Salmon.getDefaultDimensions: the variant's bounding box scale (small
        // 0.5, medium 1.0, large 1.5) over the whole fish box.
    // rust: if k.species == super::Species::Salmon {
    // rust: let s = super::aquatic::salmon_scale(self.extra.variant);
    // rust: (w, h, e) = (w * s, h * s, e * s);
}
        // PolarBear.getDefaultDimensions: the rear-up animation scales the box
        // by (1, 1 + clientSideStandAnimation / 6), so a bear at full height is
        // twice as tall, with its eyes twice as high and the same width.
    // rust: if k.species == super::Species::PolarBear {
    // rust: let f = super::polar_bear::stand_box_scale(self);
    // rust: (h, e) = (h * f, e * f);
}
        // `EntityDimensions.scale(getScale())`: width and height by the scale,
        // the eye height by its height factor (the same one).
    // rust: (
    // rust: f64::from(w * scale),
    // rust: f64::from(h * scale),
    // rust: f64::from(e * scale),
    // rust: )
}
eye_height :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.dims().2
}
width :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.dims().0 as f32
}
height :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.dims().1 as f32
}
is_baby :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.extra.age < 0
}
fluid_jump_threshold :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
        // Breeze.getFluidJumpThreshold: its eye height.
    // rust: if self.species() == super::Species::Breeze {
    // rust: return self.eye_height();
}
    // rust: if self.eye_height() < 0.4 { 0.0 } else { 0.4 }
}
is_in_liquid :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.fluids.in_water || self.fluids.in_lava
}
    // `Entity.isPushedByFluid`: water animals, turtles, axolotls, frogs and
    // nautiluses keep their own course.
pushed_by_fluid :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
//         use super::Species as S;
    // rust: !matches!(
    // rust: self.species(),
    // rust: S::Tadpole
    // rust: | S::Cod
    // rust: | S::Salmon
    // rust: | S::TropicalFish
    // rust: | S::Pufferfish
    // rust: | S::Squid
    // rust: | S::GlowSquid
    // rust: | S::Dolphin
    // rust: | S::Turtle
    // rust: | S::Axolotl
    // rust: | S::Frog
    // rust: | S::Nautilus
    // rust: | S::ZombieNautilus
    // rust: )
}
affected_by_fluids :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
    // Entity.moveRelative: input rotated by yaw and scaled to `speed`.
move_relative :: proc(self: ^Self, speed: f32, input: Vec3) {
}
    // rust: let len_sq = input.x * input.x + input.y * input.y + input.z * input.z;
    // rust: if len_sq < 1.0e-7 {
            // `getInputVector` is `Vec3.ZERO`, still added to the motion: a -0.0 becomes 0.0.
    // rust: self.velocity = Vec3::new(
    // rust: self.velocity.x + 0.0,
    // rust: self.velocity.y + 0.0,
    // rust: self.velocity.z + 0.0,
    // rust: );
    // rust: return;
}
    // rust: let v = if len_sq > 1.0 {
            // Vec3.normalize
    // rust: let l = len_sq.sqrt();
    // rust: if l < f64::from(1.0e-5_f32) {
    // rust: Vec3::ZERO
    // rust: } else {
    // rust: Vec3::new(input.x / l, input.y / l, input.z / l)
}
    // rust: } else {
    // rust: input
}
    // rust: let v = Vec3::new(
    // rust: v.x * f64::from(speed),
    // rust: v.y * f64::from(speed),
    // rust: v.z * f64::from(speed),
    // rust: );
    // rust: let angle = f64::from(self.yaw * trig::DEG_TO_RAD);
    // rust: let (s, c) = (f64::from(trig::sin(angle)), f64::from(trig::cos(angle)));
    // rust: self.velocity = Vec3::new(
    // rust: self.velocity.x + (v.x * c - v.z * s),
    // rust: self.velocity.y + v.y,
    // rust: self.velocity.z + (v.z * c + v.x * s),
    // rust: );
}
    // Entity.move with block collisions and step-up; updates collision flags
    // and fall distance (Entity.checkFallDamage).
do_move :: proc(self: ^Self, w: ^MobWorld, events: ^[dynamic]MobEvent) {
}
    // rust: let mut wanted = self.velocity;
        // Entity.move: a block the mob is stuck in (sweet berry bush) scales
        // this move once and stops it.
    // rust: if self.stuck_multiplier.length_squared() > 1.0e-7 {
    // rust: wanted = wanted.multiply(self.stuck_multiplier);
    // rust: self.stuck_multiplier = Vec3::ZERO;
    // rust: self.velocity = Vec3::ZERO;
}
    // rust: let step = self.kind.step_height as f32;
    // rust: let scene = SceneCollisions {
    // rust: world: w.world,
    // rust: binding: w.collision,
    // rust: subject: self.kind.flags.lava_walker.then(|| PowderSnowSubject {
    // rust: fall_distance: self.fall_distance,
    // rust: lava_walker: true,
    // rust: ..Default::default()
    // rust: }),
}
        // Entity.collide: the world border's walls stop the mob too.
    // rust: let border = w.border.map(|b| (b, [self.position.x, self.position.z]));
    // rust: let moved = scene
    // rust: .resolve_in_border(self.bounds(), wanted, step, self.on_ground, border)
    // rust: .unwrap_or(Vec3::ZERO);
    // rust: let length = moved.x * moved.x + moved.y * moved.y + moved.z * moved.z;
    // rust: let wanted_length = wanted.x * wanted.x + wanted.y * wanted.y + wanted.z * wanted.z;
    // rust: if length > 1.0e-7 || wanted_length - length < 1.0e-7 {
    // rust: self.position = Vec3::new(
    // rust: self.position.x + moved.x,
    // rust: self.position.y + moved.y,
    // rust: self.position.z + moved.z,
    // rust: );
}
        // !Mth.equal(delta, movement)
    // rust: let differs = |a: f64, b: f64| (b - a).abs() >= f64::from(1.0e-5_f32);
    // rust: let x_hit = differs(wanted.x, moved.x);
    // rust: let z_hit = differs(wanted.z, moved.z);
    // rust: self.horizontal_collision = x_hit || z_hit;
        // A server's mobs are authoritative (`isLocalInstanceAuthoritative`):
        // the vertical flags update even without vertical movement.
    // rust: let moved_vertically = wanted.y.abs() > 0.0;
    // rust: let vertical = wanted.y != moved.y;
    // rust: self.vertical_collision_below = vertical && wanted.y < 0.0;
    // rust: self.on_ground = self.vertical_collision_below;
        // Strider.checkFallDamage: lava breaks any fall, and the fluid state
        // waits for the next baseTick; Bat and Bee.checkFallDamage do nothing.
    // rust: if self.kind.flags.lava_walker && self.fluids.in_lava {
    // rust: self.fall_distance = 0.0;
    // rust: } else if !matches!(self.kind.species, super::Species::Bat | super::Species::Bee) {
    // rust: self.check_fall_damage(w, moved, events);
}
        // Entity.restituteMovementAfterCollisions: the colliding components
        // bounce back by the entity's bounciness or the block's (a slime
        // block, a bed), whichever is larger. A mob never sneaks, so nothing
        // suppresses its bounce there.
    // rust: if moved_vertically && vertical || self.horizontal_collision {
            // Entity.getOnPos(0.2F): the block whose bounce this move sees.
    // rust: let on = (
    // rust: self.position.x.floor() as i32,
    // rust: (self.position.y - f64::from(0.2_f32)).floor() as i32,
    // rust: self.position.z.floor() as i32,
    // rust: );
    // rust: let input = RestitutionInput {
    // rust: block: w.world.block(on.0, on.1, on.2),
    // rust: collided_x: x_hit,
    // rust: collided_z: z_hit,
    // rust: vertical_collision: vertical,
    // rust: collision_below: self.vertical_collision_below,
    // rust: living: true,
    // rust: resolved_movement: moved,
    // rust: fall_distance: self.fall_distance,
}
            // The port's phases cannot fail for a mob: a block outside the
            // registry reads as one with no bounce, never as an error.
    // rust: let _ = restitute_movement(
    // rust: &mut MobRestitution {
    // rust: mob: self,
    // rust: world: w,
    // rust: },
    // rust: input,
    // rust: );
}
        // Entity.checkSupportingBlock
    // rust: self.supporting = self.supporting_block(w, moved);
    // rust: self.movement_emission(w, moved, events);
        // Entity.move's last step: soul sand, honey and the like slow the
        // horizontal speed of whatever the mob stands in or on.
    // rust: let factor = self.block_speed_factor(w);
    // rust: self.velocity = horizon_world::entity_move::scale_by_block_speed(self.velocity, factor);
}
    // `Entity.getBlockSpeedFactor` at the mob's feet.
block_speed_factor :: proc(self: ^Self, w: ^MobWorld) -> f {
    // Ported from Horizon
    return {}
}
    // rust: crate::motion::block_speed_factor_at(
    // rust: w.world,
    // rust: w.movement,
    // rust: self.position,
    // rust: self.supporting.map(|[x, y, z]| BlockPos::new(x, y, z)),
    // rust: )
}
    // `Entity.applyEffectsFromBlocks` as `LivingEntity.aiStep` runs it, after
    // `travel` has moved the mob and applied the drag of its fluid (not inside
    // `Entity.move`): bubble columns push the mob, so the push is not slowed
    // by that tick's drag, and the server shows the surface of one it is at the
    // top of.
apply_effects_from_blocks :: proc(self: ^Self, w: ^MobWorld, events: ^[dynamic]MobEvent) {
}
    // rust: let mut tops = Vec::new();
    // rust: if crate::motion::bubble_column_push_over(
    // rust: w.world,
    // rust: w.registry,
    // rust: w.facts,
    // rust: w.collision,
    // rust: self.bounds(),
    // rust: &mut self.velocity,
    // rust: |pos| tops.push(pos),
    // rust: ) {
    // rust: self.fall_distance = 0.0;
}
    // rust: for pos in tops {
    // rust: events.push(MobEvent::BubbleColumnParticles {
    // rust: pos: [pos.x, pos.y, pos.z],
    // rust: });
}
}
    // LivingEntity.checkFallDamage: the fluid state refreshed out of water
    // (touching water resets the fall), then Entity.checkFallDamage.
check_fall_damage :: proc(self: ^Self, w: ^MobWorld, moved: Vec3, events: ^[dynamic]MobEvent) {
}
    // rust: if !self.fluids.in_water {
    // rust: self.update_fluids(w, events);
}
    // rust: if !self.fluids.in_water && moved.y < 0.0 {
    // rust: self.fall_distance -= f64::from(moved.y as f32);
}
    // rust: if self.on_ground {
    // rust: if self.fall_distance > 0.0 {
    // rust: self.landing_dust(w, events);
    // rust: self.fall_on_block(w, events);
}
    // rust: self.fall_distance = 0.0;
}
}
    // The block particles `LivingEntity.checkFallDamage` sends up from the
    // block a mob lands on, by the power of the fall.
landing_dust :: proc(self: ^Self, w: ^MobWorld, events: ^[dynamic]MobEvent) {
}
    // rust: let pos = self.block_on_legacy(w);
    // rust: let state = w.world.block(pos[0], pos[1], pos[2]);
    // rust: let Some(count) = landing_dust_count(self.fall_distance, self.kind.safe_fall_distance)
    // rust: else {
    // rust: return;
}
    // rust: if w.facts.is_air(state) {
    // rust: return;
}
    // rust: let at = landing_dust_at(self.position, pos);
    // rust: events.push(MobEvent::LandingDust {
    // rust: state,
    // rust: at: [at.x, at.y, at.z],
    // rust: count,
            // `sendParticles(..., 0.15)`: the crumbs fly up a little.
    // rust: speed: f64::from(0.15_f32),
    // rust: });
}
    // Entity.updateFluidInteraction: the fluid state, then touching water
    // resets the fall and entering it (after the first tick) splashes.
    // rust: pub(super) fn update_fluids(&mut self, w: &MobWorld, events: &mut Vec<MobEvent>) {
    // rust: let was_touching_water = self.fluids.in_water;
    // rust: self.fluids = w.fluids(self.bounds(), self.eye_y());
        // EntityFluidInteraction.applyCurrentTo: the flow pushes the mob.
    // rust: if (self.fluids.in_water || self.fluids.in_lava) && self.pushed_by_fluid() {
    // rust: let (water, lava) = w.fluid_currents(self.bounds());
    // rust: let lava_scale = if w.nether {
    // rust: 0.007
    // rust: } else {
    // rust: 0.0023333333333333335
}
    // rust: let mut pushed = Pushed(&mut self.velocity);
    // rust: if water.height > 0.0 {
    // rust: let _ = water.apply_to(&mut pushed, 0.014);
}
    // rust: if lava.height > 0.0 {
    // rust: let _ = lava.apply_to(&mut pushed, lava_scale);
}
}
    // rust: if self.fluids.in_water {
    // rust: self.fall_distance = 0.0;
    // rust: if !was_touching_water && !self.first_tick {
                // The splash is the mob's own: Horizon's mobs carry no
                // controlling passenger here.
    // rust: let _ = horizon_world::water_splash::water_splash(
    // rust: &mut Splash { mob: self, events },
    // rust: 1_000_000,
    // rust: );
}
}
}
    // Entity.applyMovementEmissionAndPlaySound: walked distance, footsteps
    // and swimming sounds.
movement_emission :: proc(self: ^Self, w: ^MobWorld, moved: Vec3, events: ^[dynamic]MobEvent) {
}
    // rust: if !super::ai::emits_movement(self) || self.extra.mount.is_some() {
    // rust: return;
}
    // rust: let full = (moved.length() * f64::from(0.6_f32)) as f32;
    // rust: let horizontal =
    // rust: ((moved.x * moved.x + moved.z * moved.z).sqrt() * f64::from(0.6_f32)) as f32;
    // rust: let supporting = self.supporting;
    // rust: let on = self.supported_on_pos(w, supporting, 1.0e-5);
    // rust: let state = w.world.block(on[0], on[1], on[2]);
    // rust: let climbable = w.facts.get(state).name.as_ref() == "minecraft:powder_snow"
    // rust: || w.has_tag("minecraft:climbable", &w.facts.get(state).name);
    // rust: let steps = &mut self.ai.steps;
    // rust: steps.move_dist += if climbable { full } else { horizontal };
    // rust: steps.fly_dist += full;
    // rust: if steps.move_dist > steps.next_step && !w.facts.is_air(state) {
    // rust: let legacy = self.supported_on_pos(w, supporting, 0.2);
    // rust: let legacy_state = w.world.block(legacy[0], legacy[1], legacy[2]);
    // rust: let produced = !w.facts.is_air(legacy_state)
    // rust: && (self.on_ground || climbable)
    // rust: && !self.fluids_swimming();
    // rust: if produced {
                // `getMovementEmission().emitsSounds()`: the footfall is played
                // only for a type whose emission is `ALL`, while the step game
                // event below is sent by `EVENTS` types too.
    // rust: let heard = super::ai::movement_sounds(self);
    // rust: if super::equine::hoof_steps(self.species()) {
    // rust: if heard && !self.silent {
    // rust: super::equine::play_step(self, w, legacy, legacy_state, events);
}
    // rust: } else if let Some((sound, volume, pitch)) =
    // rust: super::ai::step_sound(self, w, legacy, legacy_state)
    // rust: && heard
    // rust: && !self.silent
    // rust: {
    // rust: let at = [self.position.x, self.position.y, self.position.z];
    // rust: events.push(MobEvent::Sound(sound, at, volume, pitch));
}
                // Entity.vibrationAndSoundEffectsFromBlock: the step's game
                // event, with the supporting block's state when the effect
                // block is another.
    // rust: events.push(MobEvent::GameEvent {
    // rust: event: "minecraft:step",
    // rust: at: [self.position.x, self.position.y, self.position.z],
    // rust: source: self.id,
    // rust: state: if legacy == on { legacy_state } else { state },
    // rust: });
    // rust: self.ai.steps.next_step = self.next_step();
    // rust: } else if self.fluids.in_water {
    // rust: self.ai.steps.next_step = self.next_step();
                // Entity.waterSwimSound, and SkeletonHorse.playSwimSound's
                // mapping of the volume it works out.
    // rust: let v = self.velocity;
    // rust: let speed =
    // rust: (v.x * v.x * f64::from(0.2_f32) + v.y * v.y + v.z * v.z * f64::from(0.2_f32))
    // rust: .sqrt() as f32;
    // rust: let volume = super::equine::swim_volume(self, 1.0_f32.min(speed * 0.35));
    // rust: if !super::ai::movement_sounds(self) {
    // rust: return;
}
    // rust: let pitch = 1.0 + (self.random.next_float() - self.random.next_float()) * 0.4;
                // Entity.playSwimSound asks getSwimSound for its sound even
                // when the mob is silent, and a skeleton horse counts there.
    // rust: let sound = super::ai::swim_sound(self);
    // rust: if !self.silent {
    // rust: let at = [self.position.x, self.position.y, self.position.z];
    // rust: events.push(MobEvent::Sound(sound, at, volume, pitch));
}
}
    // rust: } else if w.facts.is_air(state)
    // rust: && self.species() == super::Species::Bee
    // rust: && !self.on_ground
    // rust: && self.age.is_multiple_of(2)
    // rust: {
            // Entity.processFlappingMovement: a flying bee beats its wings on
            // every other tick (Bee.isFlapping, TICKS_PER_FLAP is 2).
    // rust: events.push(MobEvent::GameEvent {
    // rust: event: "minecraft:flap",
    // rust: at: [self.position.x, self.position.y, self.position.z],
    // rust: source: self.id,
    // rust: state: horizon_world::registry::BlockStateId(0),
    // rust: });
    // rust: } else if w.facts.is_air(state) {
            // Entity.processFlappingMovement: onFlap runs before the game
            // event. Silent birds still emit it, independently of sound.
    // rust: let flapped = match self.species() {
    // rust: super::Species::Chicken => super::farm::chicken_process_flapping(self),
    // rust: super::Species::Parrot => super::parrot::process_flapping(self, events),
    // rust: _ => false,
}
    // rust: if flapped {
    // rust: events.push(MobEvent::GameEvent {
    // rust: event: "minecraft:flap",
    // rust: at: [self.position.x, self.position.y, self.position.z],
    // rust: source: self.id,
    // rust: state: horizon_world::registry::BlockStateId(0),
    // rust: });
}
}
}
    // `Entity.nextStep`: the next whole metre walked; a warden's steps come
    // every 0.55, a strider's every 0.6, a turtle's every 0.15.
next_step :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let walked = self.ai.steps.move_dist;
    // rust: if self.kind.species == super::Species::Warden {
    // rust: walked + 0.55
    // rust: } else if self.kind.species == super::Species::Strider {
    // rust: walked + 0.6
    // rust: } else if self.kind.species == super::Species::Turtle {
    // rust: walked + 0.15
    // rust: } else {
    // rust: (walked as i32).wrapping_add(1) as f32
}
}
    // Entity.isSwimming (mobs never swim in the player sense).
fluids_swimming :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
    // `Entity.checkSupportingBlock` after a move: on the ground, the block
    // under the feet (`mainSupportingBlockPos`), looked for again where
    // the mob came from if none is under it now.
supporting_block :: proc(self: ^Self, w: ^MobWorld, moved: Vec3) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if !self.on_ground {
    // rust: return None;
}
    // rust: let b = self.bounds();
//         use horizon_core::geometry::Axis;
    // rust: let area = Aabb::new(
    // rust: Vec3::new(b.min(Axis::X), b.min(Axis::Y) - 1.0e-6, b.min(Axis::Z)),
    // rust: Vec3::new(b.max(Axis::X), b.min(Axis::Y), b.max(Axis::Z)),
    // rust: );
    // rust: w.supporting_block(area, self.position).or_else(|| {
    // rust: let back = Vec3::new(-moved.x, 0.0, -moved.z);
    // rust: let shifted = Aabb::new(
    // rust: Vec3::new(
    // rust: area.min(Axis::X) + back.x,
    // rust: area.min(Axis::Y),
    // rust: area.min(Axis::Z) + back.z,
    // rust: ),
    // rust: Vec3::new(
    // rust: area.max(Axis::X) + back.x,
    // rust: area.max(Axis::Y),
    // rust: area.max(Axis::Z) + back.z,
    // rust: ),
    // rust: );
    // rust: w.supporting_block(shifted, self.position)
    // rust: })
}
    // `Entity.getBlockStateOnLegacy`'s position: 0.2 below the feet, or the
    // supporting block.
    // rust: pub(super) fn block_on_legacy(&self, w: &MobWorld) -> [i32; 3] {
    // rust: self.supported_on_pos(w, self.supporting, 0.2)
}
    // `Entity.getOnPos(offset)` with a supporting block: its column (its
    // own position for fences, walls and gates up to half a block down).
    // rust: fn supported_on_pos(
    // rust: &self,
    // rust: w: &MobWorld,
    // rust: supporting: Option<[i32; 3]>,
    // rust: offset: f32,
    // rust: ) -> [i32; 3] {
    // rust: let Some(p) = supporting else {
    // rust: return self.on_pos(offset);
}
    // rust: if offset <= 1.0e-5 {
    // rust: return p;
}
    // rust: let name = &w.facts.get(w.world.block(p[0], p[1], p[2])).name;
    // rust: let tall = [
    // rust: "minecraft:fences",
    // rust: "minecraft:walls",
    // rust: "minecraft:fence_gates",
    // rust: ]
    // rust: .iter()
    // rust: .any(|t| w.has_tag(t, name));
    // rust: if offset <= 0.5 && tall {
    // rust: p
    // rust: } else {
    // rust: [
    // rust: p[0],
    // rust: (self.position.y - f64::from(offset)).floor() as i32,
    // rust: p[2],
    // rust: ]
}
}
    // Entity.getOnPos(offset) without a supporting block record.
on_pos :: proc(self: ^Self, offset: f32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [
    // rust: self.position.x.floor() as i32,
    // rust: (self.position.y - f64::from(offset)).floor() as i32,
    // rust: self.position.z.floor() as i32,
    // rust: ]
}
    // `Block.fallOn` of the block under the mob (`Entity.checkFallDamage`):
    // the block's own rule (hay, honey, slime, powder snow, a bed, a
    // stalagmite, farmland, a turtle egg) decides how much of the fall hurts.
fall_on_block :: proc(self: ^Self, w: ^MobWorld, events: ^[dynamic]MobEvent) {
}
    // rust: let pos = self.block_on_legacy(w);
    // rust: let state = w.world.block(pos[0], pos[1], pos[2]);
    // rust: let species = self.species();
    // rust: let entity = if super::doors::is_zombie(species) {
    // rust: LandingEntityKind::Zombie
    // rust: } else if species == super::Species::Turtle {
    // rust: LandingEntityKind::Turtle
    // rust: } else if species == super::Species::Bat {
    // rust: LandingEntityKind::Bat
    // rust: } else {
    // rust: LandingEntityKind::Living
}
    // rust: let distance = self.fall_distance;
    // rust: let result = w.landing.fall_on(
    // rust: &mut super::landing::MobLanding {
    // rust: mob: self,
    // rust: w,
    // rust: events,
    // rust: pos,
    // rust: },
    // rust: state,
    // rust: BlockPos::new(pos[0], pos[1], pos[2]),
    // rust: entity,
    // rust: distance,
    // rust: );
        // A block outside the landing registry falls back to the plain fall.
    // rust: if result.is_err() {
    // rust: self.cause_fall_damage_at(
    // rust: distance,
    // rust: 1.0,
    // rust: events,
    // rust: Some((w, pos)),
    // rust: super::DamageKind::Fall,
    // rust: );
}
}
    // rust: fn mod_block_fall(
    // rust: &self,
    // rust: contact: Option<(&MobWorld, [i32; 3])>,
    // rust: distance: f64,
    // rust: damage: f32,
    // rust: ) -> f32 {
    // rust: contact.map_or(damage, |(w, p)| {
    // rust: crate::block_contact::fall(
    // rust: crate::block_contact::Contact {
    // rust: entity: self.id as i32,
    // rust: kind: &self.kind.id,
    // rust: block: w.block_name(p[0], p[1], p[2]),
    // rust: state: w.world.block(p[0], p[1], p[2]),
    // rust: position: horizon_core::position::BlockPos::new(p[0], p[1], p[2]),
    // rust: },
    // rust: distance,
    // rust: damage,
    // rust: )
    // rust: })
}
    // `LivingEntity.causeFallDamage`: a fall of `distance` blocks at `modifier`
    // (its own landing, or a vehicle's passed on by `propagateFallToPassengers`)
    // brings the species' sounds and reactions, the damage, and the fall
    // handed to whoever rides it. `AbstractHorse.causeFallDamage` hurts the
    // horse first and passes the fall on only when it was hurt.
    // rust: pub fn cause_fall_damage_from(
    // rust: &mut self,
    // rust: distance: f64,
    // rust: modifier: f32,
    // rust: events: &mut Vec<MobEvent>,
    // rust: ) {
    // rust: self.cause_fall_damage_at(distance, modifier, events, None, super::DamageKind::Fall);
}
    // True when the fall hurt (`causeFallDamage`'s result).
    // rust: pub(super) fn cause_fall_damage_at(
    // rust: &mut self,
    // rust: distance: f64,
    // rust: modifier: f32,
    // rust: events: &mut Vec<MobEvent>,
    // rust: contact: Option<(&MobWorld, [i32; 3])>,
    // rust: source: super::DamageKind,
    // rust: ) -> bool {
        // Breeze.causeFallDamage: a landing from higher than three blocks.
    // rust: if self.species() == super::Species::Breeze && distance > 3.0 {
    // rust: let at = [self.position.x, self.position.y, self.position.z];
    // rust: events.push(MobEvent::Sound("entity.breeze.land", at, 1.0, 1.0));
}
        // Creeper.causeFallDamage: the fall swells the fuse, up to five ticks
        // short of exploding.
    // rust: if self.species() == super::Species::Creeper {
    // rust: self.swell = (self.swell + (distance * 1.5) as i32).min(self.max_swell - 5);
}
        // AbstractHorse.causeFallDamage (llamas override it): a landing of more
        // than a block thuds, and the horse's fall makes no generic fall sound.
    // rust: let thud =
    // rust: super::equine::is_equine(self.species()) && !super::llama::is_llama(self.species());
    // rust: if thud && distance > 1.0 && !self.silent {
    // rust: let at = [self.position.x, self.position.y, self.position.z];
    // rust: let sound = if self.is_baby() {
    // rust: "entity.baby_horse.land"
    // rust: } else {
    // rust: "entity.horse.land"
}
    // rust: events.push(MobEvent::Sound(sound, at, 0.4, 1.0));
}
        // AbstractHorse.causeFallDamage hurts the horse first and passes the fall
        // on to its riders only when it was hurt.
    // rust: let horse = super::equine::is_equine(self.species());
        // `Block.fallOn` is told the fall as it was before the mods' changes.
    // rust: let landed = distance;
    // rust: let mut distance = distance;
    // rust: let mut modifier = modifier;
    // rust: if !horse {
    // rust: let mut cancel = false;
    // rust: crate::landing::native_living_fall(
    // rust: self.id,
    // rust: &self.kind.id,
    // rust: &mut distance,
    // rust: &mut modifier,
    // rust: &mut cancel,
    // rust: );
    // rust: if cancel {
    // rust: self.mod_block_fall(contact, landed, 0.0);
    // rust: return false;
}
}
        // Entity.causeFallDamage: nothing happens to a fall immune entity, nor
        // to those on it.
    // rust: if self.kind.flags.fall_immune {
    // rust: self.mod_block_fall(contact, landed, 0.0);
    // rust: return false;
}
    // rust: let power = distance + 1.0e-6 - self.kind.safe_fall_distance;
    // rust: let mut damage = (power * f64::from(modifier) * self.kind.fall_damage_multiplier).floor();
        // Frog.calculateFallDamage: five points less than the base damage;
        // Goat.calculateFallDamage: ten, so a long jump down a ledge is safe.
    // rust: match self.species() {
    // rust: super::Species::Frog => damage -= 5.0,
    // rust: super::Species::Goat => damage -= 10.0,
    // rust: _ => {}
}
    // rust: let damage = f64::from(self.mod_block_fall(contact, landed, damage as f32));
        // LivingEntity.causeFallDamage lets the riders fall first.
    // rust: if !horse {
    // rust: self.fall_to_passengers(distance, modifier, events);
}
    // rust: if damage > 0.0 {
            // Llama.causeFallDamage: only a fall of six blocks or more hurts the
            // llama and its riders.
    // rust: if super::llama::is_llama(self.species()) && distance < 6.0 {
    // rust: return false;
}
    // rust: let at = [self.position.x, self.position.y, self.position.z];
            // Monster.getFallSounds: the hostile pair.
    // rust: let monster = super::ai::is_monster(self.species());
    // rust: let sound = match (monster, damage > 4.0) {
    // rust: (true, true) => "entity.hostile.big_fall",
    // rust: (true, false) => "entity.hostile.small_fall",
    // rust: (false, true) => "entity.generic.big_fall",
    // rust: (false, false) => "entity.generic.small_fall",
}
            // Horses thud and llamas make no generic fall sound.
    // rust: if !horse {
    // rust: events.push(MobEvent::Sound(sound, at, 1.0, 1.0));
}
    // rust: self.damage(damage as f32, super::Damage::of(source));
    // rust: if horse {
    // rust: self.fall_to_passengers(distance, modifier, events);
}
    // rust: return true;
}
    // rust: false
}
    // `Entity.propagateFallToPassengers`: the game gives the fall to each
    // passenger (`causeFallDamage`), a mob or a player, for this mob is
    // borrowed here.
fall_to_passengers :: proc(self: ^Self, distance: f64, modifier: f32, events: ^[dynamic]MobEvent) {
}
    // rust: if self.rider.is_some() || self.extra.rider.is_some() {
    // rust: events.push(MobEvent::FallToPassengers {
    // rust: mob: self.id,
    // rust: distance,
    // rust: modifier,
    // rust: });
}
}
    // LivingEntity.getFrictionInfluencedSpeed.
friction_speed :: proc(self: ^Self, friction: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if self.on_ground {
    // rust: if friction > 0.6 {
    // rust: self.ai.speed * (0.216_000_02 / (friction * friction * friction))
    // rust: } else {
    // rust: self.ai.speed
}
    // rust: } else {
    // rust: self.flying_speed()
}
}
flying_speed :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: 0.02
}
    // `LivingEntity.getEffectiveGravity`: the gravity, floored to 0.01 while a
    // Slow Falling mob is on its way down.
effective_gravity :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let gravity = self.gravity();
    // rust: if self.velocity.y <= 0.0 && self.has_effect("minecraft:slow_falling") && !gravity.is_nan()
    // rust: {
    // rust: gravity.min(0.01)
    // rust: } else {
    // rust: gravity
}
}
    // Entity.getGravity: none while isNoGravity.
gravity :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if self.no_gravity {
    // rust: 0.0
    // rust: } else {
    // rust: self.kind.gravity
}
}
    // LivingEntity.travel.
travel :: proc(self: ^Self, w: ^MobWorld, input: Vec3, events: ^[dynamic]MobEvent) {
}
    // rust: if super::ai::custom_travel(self, w, input, events) {
    // rust: return;
}
    // rust: if self.kind.flags.flying {
    // rust: return self.travel_flying(w, input, events);
}
        // shouldTravelInFluid: not where the fluid at its feet holds it up.
    // rust: let (x, y, z) = (
    // rust: self.position.x.floor() as i32,
    // rust: self.position.y.floor() as i32,
    // rust: self.position.z.floor() as i32,
    // rust: );
    // rust: let stands_on_fluid = self.kind.flags.lava_walker && w.fluid(x, y, z) == Fluid::Lava;
    // rust: if self.is_in_liquid() && self.affected_by_fluids() && !stands_on_fluid {
    // rust: self.travel_in_fluid(w, input, events);
    // rust: } else {
    // rust: self.travel_in_air(w, input, events);
}
}
    // LivingEntity.travelFlying: no gravity, `0.91F` drag in the air,
    // `0.8F` in water and 0.5 in lava. A happy ghast swims as fast as it
    // flies (`HappyGhast.travel`); the others at 0.02.
travel_flying :: proc(self: ^Self, w: ^MobWorld, input: Vec3, events: ^[dynamic]MobEvent) {
}
    // rust: let fluid_speed = if self.species() == super::Species::HappyGhast {
    // rust: self.kind.air_speed
    // rust: } else {
    // rust: 0.02
}
    // rust: self.travel_flying_speeds(
    // rust: w,
    // rust: input,
    // rust: events,
    // rust: fluid_speed,
    // rust: fluid_speed,
    // rust: self.kind.air_speed,
    // rust: );
}
    // `LivingEntity.travelFlying(input, waterSpeed, lavaSpeed, airSpeed)`:
    // the speeds vary per mob (an allay flies at the speed its move control
    // set, `Allay.travel`).
    // rust: pub fn travel_flying_speeds(
    // rust: &mut self,
    // rust: w: &MobWorld,
    // rust: input: Vec3,
    // rust: events: &mut Vec<MobEvent>,
    // rust: water_speed: f32,
    // rust: lava_speed: f32,
    // rust: air_speed: f32,
    // rust: ) {
    // rust: let (speed, drag) = if self.fluids.in_water {
    // rust: (water_speed, f64::from(0.8_f32))
    // rust: } else if self.fluids.in_lava {
    // rust: (lava_speed, 0.5)
    // rust: } else {
    // rust: (air_speed, f64::from(0.91_f32))
}
    // rust: self.move_relative(speed, input);
    // rust: self.do_move(w, events);
    // rust: self.velocity = Vec3::new(
    // rust: self.velocity.x * drag,
    // rust: self.velocity.y * drag,
    // rust: self.velocity.z * drag,
    // rust: );
}
block_friction :: proc(self: ^Self, w: ^MobWorld) -> f {
    // Ported from Horizon
    return {}
}
        // Entity.getBlockPosBelowThatAffectsMyMovement: 0.500001 below.
    // rust: let x = self.position.x.floor() as i32;
    // rust: let z = self.position.z.floor() as i32;
    // rust: let y = (self.position.y - 0.500_001).floor() as i32;
    // rust: w.facts.get(w.world.block(x, y, z)).friction
}
    // `getAttributeValue(BOUNCINESS)`.
entity_bounciness :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: super::sulfur_cube::physics(self).map_or(0.0, |a| f64::from(a.bounciness.clamp(0.0, 1.0)))
}
    // `LivingEntity.computeModifiedFriction`.
modified_friction :: proc(friction: f32, modifier: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: (1.0 - (1.0 - friction) * modifier).clamp(0.0, 1.0)
}
    // `LivingEntity.getAirDrag`: what vertical air drag a bounce applies.
air_drag :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let base = if self.kind.flags.omnidirectional {
    // rust: 0.91
    // rust: } else {
    // rust: 0.98
}
    // rust: Self::modified_friction(base, self.air_drag_modifier())
}
    // `getAttributeValue(AIR_DRAG_MODIFIER)`.
air_drag_modifier :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: super::sulfur_cube::physics(self).map_or(1.0, |a| a.air_drag_modifier.clamp(0.0, 2048.0))
}
    // `LivingEntity.handleOnClimbable` for a mob, which is never a `Player`
    // that holds still on a ladder: the move across clamped to 0.15 either
    // way and the fall to 0.15, both the float 0.15F (`Mth.clamp`,
    // `Math.max`, which keep a NaN).
climbable_velocity :: proc(v: Vec3) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let limit = f64::from(0.15f32);
    // rust: let y = if v.y.is_nan() { v.y } else { v.y.max(-limit) };
    // rust: Vec3::new(v.x.clamp(-limit, limit), y, v.z.clamp(-limit, limit))
}
travel_in_air :: proc(self: ^Self, w: ^MobWorld, input: Vec3, events: ^[dynamic]MobEvent) {
}
    // rust: let friction = if self.on_ground {
            // FRICTION_MODIFIER scales the block's slipperiness.
    // rust: let modifier = super::sulfur_cube::physics(self)
    // rust: .map_or(1.0, |a| a.friction_modifier.clamp(0.0, 2048.0));
    // rust: Self::modified_friction(self.block_friction(w), modifier)
    // rust: } else {
    // rust: 1.0
}
    // rust: let speed = self.friction_speed(friction);
    // rust: self.move_relative(speed, input);
        // LivingEntity.handleRelativeFrictionAndCalculateMovement:
        // handleOnClimbable, the move, then the climb up a wall.
    // rust: if self.on_climbable(w) {
    // rust: self.fall_distance = 0.0;
    // rust: self.velocity = Self::climbable_velocity(self.velocity);
}
    // rust: self.do_move(w, events);
    // rust: let mut movement = self.velocity;
    // rust: if (self.horizontal_collision || self.ai.jumping) && self.on_climbable(w) {
    // rust: movement.y = 0.2;
}
    // rust: let mut y = movement.y;
        // LivingEntity.travelInAir: levitation lifts by its amplifier.
    // rust: if let Some(&(_, _, amp)) = self
    // rust: .extra
    // rust: .effects
    // rust: .iter()
    // rust: .find(|e| e.0 == "minecraft:levitation")
    // rust: {
    // rust: y += (0.05 * f64::from(amp + 1) - movement.y) * 0.2;
    // rust: } else {
    // rust: y -= self.effective_gravity();
}
        // LivingEntity.shouldDiscardFriction (a breeze's, a frog's or a goat's
        // long jump).
    // rust: if super::breeze::discards_friction(self)
    // rust: || self.extra.frog.discard_friction
    // rust: || self.extra.goat.discard_friction
    // rust: {
    // rust: self.velocity = Vec3::new(movement.x, y, movement.z);
    // rust: return;
}
    // rust: let air_drag_modifier = self.air_drag_modifier();
    // rust: let drag = Self::modified_friction(0.91, air_drag_modifier);
    // rust: let f = friction * drag;
    // rust: let vertical = if self.kind.flags.omnidirectional {
    // rust: drag
    // rust: } else {
    // rust: Self::modified_friction(0.98, air_drag_modifier)
}
    // rust: self.velocity = Vec3::new(
    // rust: movement.x * f64::from(f),
    // rust: y * f64::from(vertical),
    // rust: movement.z * f64::from(f),
    // rust: );
}
travel_in_fluid :: proc(self: ^Self, w: ^MobWorld, input: Vec3, events: ^[dynamic]MobEvent) {
}
    // rust: let falling = self.velocity.y <= 0.0;
    // rust: let old_y = self.position.y;
    // rust: let gravity = self.effective_gravity();
    // rust: if self.fluids.in_water {
    // rust: let mut slow = if self.extra.sprinting {
    // rust: 0.9
    // rust: } else {
    // rust: self.kind.water_slowdown
}
    // rust: let mut speed = 0.02f32;
    // rust: let mut efficiency = self.kind.water_efficiency as f32;
    // rust: if !self.on_ground {
    // rust: efficiency *= 0.5;
}
    // rust: if efficiency > 0.0 {
    // rust: slow += (0.546_000_06 - slow) * efficiency;
    // rust: speed += (self.ai.speed - speed) * efficiency;
}
    // rust: self.move_relative(speed, input);
    // rust: self.do_move(w, events);
    // rust: let mut m = self.velocity;
    // rust: if self.horizontal_collision && self.kind.flags.climber {
    // rust: m.y = 0.2;
}
    // rust: m = Vec3::new(
    // rust: m.x * f64::from(slow),
    // rust: m.y * f64::from(0.8_f32),
    // rust: m.z * f64::from(slow),
    // rust: );
    // rust: self.velocity = fluid_falling(gravity, falling, self.extra.sprinting, m);
    // rust: } else {
    // rust: self.move_relative(0.02, input);
    // rust: self.do_move(w, events);
    // rust: if self.fluids.lava <= self.fluid_jump_threshold() {
    // rust: self.velocity = Vec3::new(
    // rust: self.velocity.x * 0.5,
    // rust: self.velocity.y * f64::from(0.8_f32),
    // rust: self.velocity.z * 0.5,
    // rust: );
    // rust: self.velocity =
    // rust: fluid_falling(gravity, falling, self.extra.sprinting, self.velocity);
    // rust: } else {
    // rust: self.velocity = Vec3::new(
    // rust: self.velocity.x * 0.5,
    // rust: self.velocity.y * 0.5,
    // rust: self.velocity.z * 0.5,
    // rust: );
}
    // rust: if gravity != 0.0 {
    // rust: self.velocity.y -= gravity / 4.0;
}
}
        // jumpOutOfFluid: Entity.isFree wants the box dry and clear of the
        // entities a mob collides with (canBeCollidedWith: living shulkers).
    // rust: let m = self.velocity;
    // rust: let ahead = self.bounds().move_by(Vec3::new(
    // rust: m.x,
    // rust: m.y + f64::from(0.6_f32) - self.position.y + old_y,
    // rust: m.z,
    // rust: ));
    // rust: let wide = ahead.inflate(Vec3::new(1.0e-7, 1.0e-7, 1.0e-7));
    // rust: if self.horizontal_collision
    // rust: && w.no_collision(ahead)
    // rust: && !w.contains_any_liquid(ahead)
    // rust: && !w.others_near(wide).any(|s| {
    // rust: s.id != self.id
    // rust: && s.alive
    // rust: && s.species == super::Species::Shulker
    // rust: && s.bounds.intersects(wide)
    // rust: })
    // rust: {
    // rust: self.velocity.y = f64::from(0.3_f32);
}
        // `LivingEntity.travelInFluid` ends with
        // `floatInLiquidWhileRidden(FluidTags.ENTITY_FLOATABLE)`: a mount with
        // a passenger that is in `minecraft:can_float_while_ridden` and deeper
        // in the water than its jump threshold rises 0.04 a tick, which is
        // what keeps a ridden horse and its rider afloat.
    // rust: if (self.rider.is_some() || self.extra.rider.is_some())
    // rust: && w.data
    // rust: .entity_has("minecraft:can_float_while_ridden", &self.kind.id)
    // rust: && self.fluids.water > self.fluid_jump_threshold()
    // rust: {
    // rust: self.velocity.y += f64::from(0.04_f32);
}
}
    // The jump part of LivingEntity.aiStep.
handle_jumping :: proc(self: ^Self, w: ^MobWorld) {
}
    // rust: if self.ai.jumping && self.affected_by_fluids() {
    // rust: let (fluid_height, in_water_with_height) = if self.fluids.in_lava {
    // rust: (self.fluids.lava, false)
    // rust: } else {
    // rust: (
    // rust: self.fluids.water,
    // rust: self.fluids.in_water && self.fluids.water > 0.0,
    // rust: )
}
    // rust: let threshold = self.fluid_jump_threshold();
    // rust: if !in_water_with_height || self.on_ground && fluid_height <= threshold {
    // rust: if !self.fluids.in_lava || self.on_ground && self.fluids.lava <= threshold {
    // rust: if (self.on_ground || in_water_with_height && fluid_height <= threshold)
    // rust: && self.ai.no_jump_delay == 0
    // rust: {
    // rust: self.jump_from_ground(w);
    // rust: self.ai.no_jump_delay = 10;
}
    // rust: } else {
    // rust: self.jump_in_liquid(true);
}
    // rust: } else {
    // rust: self.jump_in_liquid(false);
}
    // rust: } else {
    // rust: self.ai.no_jump_delay = 0;
}
}
    // Mob.jumpInLiquid: floaters rise 0.04 per tick, others 0.3; bees 0.01.
    // A magma cube in lava rises to `0.22 + size * 0.05` instead
    // (`MagmaCube.jumpInLiquid`).
jump_in_liquid :: proc(self: ^Self, lava: bool) {
}
    // rust: if lava && self.species() == super::Species::MagmaCube {
    // rust: self.velocity.y = f64::from(0.22_f32 + self.extra.size as f32 * 0.05);
    // rust: self.needs_sync = true;
    // rust: return;
}
    // rust: self.velocity.y += if self.species() == super::Species::Bee {
    // rust: 0.01
    // rust: } else if self.ai.nav.can_float {
            // LivingEntity.jumpInLiquid adds 0.04F.
    // rust: f64::from(0.04_f32)
    // rust: } else {
    // rust: 0.3
}
}
jump_from_ground :: proc(self: ^Self, w: ^MobWorld) {
}
        // LivingEntity.jumpFromGround (and the rabbit's and cubes' own,
        // which call it or do the same): needsSync.
    // rust: self.needs_sync = true;
    // rust: if self.species() == super::Species::Rabbit {
    // rust: super::rabbit::jump(self, w);
    // rust: crate::motion::native_living_jump(self.id, &self.kind.id);
    // rust: return;
}
    // rust: if matches!(
    // rust: self.species(),
    // rust: super::Species::Slime | super::Species::MagmaCube | super::Species::SulfurCube
    // rust: ) {
    // rust: super::cube::jump(self, w);
    // rust: crate::motion::native_living_jump(self.id, &self.kind.id);
    // rust: return;
}
    // rust: let power = self.jump_power(w);
    // rust: if power > 1.0e-5 {
    // rust: self.velocity.y = f64::from(power).max(self.velocity.y);
            // A sprint jump (a dashing cat or ocelot) adds 0.2 along its yaw.
    // rust: if self.extra.sprinting {
    // rust: let angle = f64::from(self.yaw * trig::DEG_TO_RAD);
    // rust: self.velocity.x += f64::from(-trig::sin(angle)) * 0.2;
    // rust: self.velocity.z += f64::from(trig::cos(angle)) * 0.2;
}
}
        // Sniffer.jumpFromGround: a hop the move control asked for, taken from
        // nearly standing still, carries a tenth of a block forward.
    // rust: if self.species() == super::Species::Sniffer
    // rust: && self.ai.mov.speed_modifier > 0.0
    // rust: && self.velocity.horizontal_distance_squared() < 0.01
    // rust: {
    // rust: self.move_relative(0.1, Vec3::new(0.0, 0.0, 1.0));
}
    // rust: crate::motion::native_living_jump(self.id, &self.kind.id);
}
    // `LivingEntity.getJumpPower`: the jump power with a multiplier of 1.0.
jump_power :: proc(self: ^Self, w: ^MobWorld) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.jump_power_with(w, 1.0)
}
    // `LivingEntity.getJumpPower(float multiplier)`
jump_power_with :: proc(self: ^Self, w: ^MobWorld, multiplier: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.attrs.jump_strength as f32 * multiplier * self.block_jump_factor(w)
    // rust: + self.jump_boost_power()
}
    // `LivingEntity.getJumpBoostPower`: amplifier + 1 times 0.1, or 0.0 without the effect.
jump_boost_power :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.extra
    // rust: .effects
    // rust: .iter()
    // rust: .find(|e| e.0 == "minecraft:jump_boost")
    // rust: .map_or(0.0, |e| 0.1 * (e.2 + 1) as f32)
}
    // `Entity.getBlockJumpFactor`: the block the mob stands in, or the one
    // below that affects movement when the current block has a neutral jump factor of 1.0.
block_jump_factor :: proc(self: ^Self, w: ^MobWorld) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let properties = w.movement;
    // rust: let current = w.world.block(
    // rust: self.position.x.floor() as i32,
    // rust: self.position.y.floor() as i32,
    // rust: self.position.z.floor() as i32,
    // rust: );
    // rust: let below = self.on_pos(0.500_001);
    // rust: let lower = w.world.block(below[0], below[1], below[2]);
    // rust: let current = properties
    // rust: .get(current)
    // rust: .map_or(1.0, |p| p.coefficients.jump_factor);
    // rust: let lower = properties
    // rust: .get(lower)
    // rust: .map_or(1.0, |p| p.coefficients.jump_factor);
    // rust: if current == 1.0 { lower } else { current }
}
    // LivingEntity.updateWalkAnimation (client calculateEntityAnimation).
update_walk_animation :: proc(self: ^Self) {
}
    // rust: let dy = if self.kind.flags.omnidirectional {
    // rust: self.position.y - self.previous.y
    // rust: } else {
    // rust: 0.0
}
    // rust: let dx = self.position.x - self.previous.x;
    // rust: let dz = self.position.z - self.previous.z;
    // rust: let distance = (dx * dx + dy * dy + dz * dz).sqrt() as f32;
    // rust: self.previous_limb_speed = self.limb_speed;
    // rust: if self.alive() {
    // rust: let (target, factor) = match self.species() {
                // Creaking.updateWalkAnimation walks the model faster.
    // rust: super::Species::Creaking => ((distance * 25.0).min(3.0), 0.4),
    // rust: super::Species::Frog => (super::frog::walk_target(self, distance), 0.4),
    // rust: s if super::camel::is_camel(s) => super::camel::walk_target(self, distance),
    // rust: _ => ((distance * 4.0).min(1.0), 0.4),
}
    // rust: self.limb_speed += (target - self.limb_speed) * factor;
    // rust: self.limb_position += self.limb_speed;
    // rust: } else {
    // rust: self.limb_speed = 0.0;
}
}
}
// LivingEntity.getFluidFallingAdjustedMovement.
fluid_falling :: proc(gravity: f64, falling: bool, sprinting: bool, m: Vec3) -> V {
    // Ported from Horizon
    return {}
}
    // rust: if gravity != 0.0 && !sprinting {
    // rust: let y = if falling && (m.y - 0.005).abs() >= 0.003 && (m.y - gravity / 16.0).abs() < 0.003 {
    // rust: -0.003
    // rust: } else {
    // rust: m.y - gravity / 16.0
}
    // rust: Vec3::new(m.x, y, m.z)
    // rust: } else {
    // rust: m
}
}

// `CollisionGetter.findFreePosition`: within `allowed`, the point nearest
// `preferred` at which a box of the size, centred there, meets no block.
    // rust: fn free_position(
    // rust: w: &MobWorld,
    // rust: allowed: Aabb,
    // rust: preferred: Vec3,
    // rust: size_x: f64,
    // rust: size_y: f64,
    // rust: ) -> Option<Vec3> {
//     use horizon_core::geometry::{ShapeOp, VoxelShape};
    // rust: let allowed_shape = VoxelShape::from_box(allowed).ok()?;
    // rust: if allowed_shape.is_empty() {
    // rust: return None;
}
    // rust: let half = Vec3::new(size_x / 2.0, size_y / 2.0, size_x / 2.0);
    // rust: let area = allowed.inflate(half);
    // rust: let (lo, hi) = (area.min_position(), area.max_position());
    // rust: let mut collisions = VoxelShape::empty();
    // getBlockCollisions: the block shapes that reach into the area.
    // rust: for x in (lo.x - 1.0e-7).floor() as i32 - 1..=(hi.x + 1.0e-7).floor() as i32 + 1 {
    // rust: for y in (lo.y - 1.0e-7).floor() as i32 - 1..=(hi.y + 1.0e-7).floor() as i32 + 1 {
    // rust: for z in (lo.z - 1.0e-7).floor() as i32 - 1..=(hi.z + 1.0e-7).floor() as i32 + 1 {
    // rust: let boxes = w.block_collision_boxes(x, y, z);
    // rust: let touches = boxes.iter().any(|b| {
    // rust: let (a, c) = (b.min_position(), b.max_position());
    // rust: a.x < hi.x && c.x > lo.x && a.y < hi.y && c.y > lo.y && a.z < hi.z && c.z > lo.z
    // rust: });
    // rust: if !touches {
    // rust: continue;
}
    // rust: for b in boxes {
    // rust: let grown = VoxelShape::from_box(b.inflate(half)).ok()?;
    // rust: collisions = collisions.join(&grown, ShapeOp::OR).ok()?;
}
}
}
}
    // rust: let free = allowed_shape.join(&collisions, ShapeOp::ONLY_FIRST).ok()?;
    // rust: free.closest_point(preferred)
}

// `Entity.doWaterSplashEffect` for a mob: its own random, its splash sound
// (`getSwimSplashSound`), particles for the client and the SPLASH game event.
Splash :: struct {
    mob: ^'a mut Mob,
    events: ^'a mut [dynamic]MobEvent,
}
    // rust: impl horizon_world::water_splash::WaterSplashWorld for Splash<'_> {
    // rust: type Error = std::convert::Infallible;
    // rust: type Entity = ();
    // rust: type Sound = &'static str;
this_entity :: proc(self: ^Self) {
}
controlling_passenger :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(None)
}
velocity :: proc(self: ^Self, _: () {
}
    // rust: Ok(self.mob.velocity)
}
splash_sound :: proc(self: ^Self, _high_speed: bool) -> R {
    // Ported from Horizon
    return {}
}
//         use super::Species;
        // Entity.getSwimSplashSound and getSwimHighSpeedSplashSound: the
        // overrides are Monster's, the hoglin's, the dolphin's and the axolotl's.
    // rust: let species = self.mob.species();
    // rust: Ok(match species {
    // rust: Species::Dolphin => "entity.dolphin.splash",
    // rust: Species::Axolotl => "entity.axolotl.splash",
    // rust: _ if species == Species::Hoglin || super::ai::is_monster(species) => {
    // rust: "entity.hostile.splash"
}
    // rust: _ => "entity.generic.splash",
    // rust: })
}
random_float :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.mob.random.next_float())
}
random_double :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.mob.random.next_double())
}
    // rust: fn play_sound(
    // rust: &mut self,
    // rust: sound: &'static str,
    // rust: volume: f32,
    // rust: pitch: f32,
    // rust: ) -> Result<(), Self::Error> {
    // rust: if !self.mob.silent {
    // rust: let at = [
    // rust: self.mob.position.x,
    // rust: self.mob.position.y,
    // rust: self.mob.position.z,
    // rust: ];
    // rust: self.events.push(MobEvent::Sound(sound, at, volume, pitch));
}
    // rust: Ok(())
}
position :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.mob.position
}
width :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.mob.width()
}
    // rust: fn particle(
    // rust: &mut self,
    // rust: kind: horizon_world::water_splash::SplashParticle,
    // rust: position: Vec3,
    // rust: velocity: Vec3,
    // rust: ) -> Result<(), Self::Error> {
    // rust: self.events.push(MobEvent::ParticleAt {
    // rust: kind: match kind {
    // rust: horizon_world::water_splash::SplashParticle::Bubble => "bubble",
    // rust: horizon_world::water_splash::SplashParticle::Splash => "splash",
    // rust: },
    // rust: at: [position.x, position.y, position.z],
    // rust: velocity: [velocity.x, velocity.y, velocity.z],
    // rust: });
    // rust: Ok(())
}
splash_event :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.events.push(MobEvent::GameEvent {
    // rust: event: "minecraft:splash",
    // rust: at: [
    // rust: self.mob.position.x,
    // rust: self.mob.position.y,
    // rust: self.mob.position.z,
    // rust: ],
    // rust: source: self.mob.id,
    // rust: state: horizon_world::registry::BlockStateId(0),
    // rust: });
    // rust: Ok(())
}
}

// `Entity.doWaterSplashEffect` for a mob this window is drawing.
// `Level.addParticle` runs on the client. `ClientLevel.playSeededSound`
// ignores `Entity.playSound` (`except` is null), and the SPLASH game event
// stays on the server, so only the bubble and splash particles are kept.
client_water_splash :: proc(mob: ^Mob, out: ^[dynamic]MobEvent) {
}
    // rust: let mut events = Vec::new();
    // rust: let _ = horizon_world::water_splash::water_splash(
    // rust: &mut Splash {
    // rust: mob,
    // rust: events: &mut events,
    // rust: },
    // rust: 1_000_000,
    // rust: );
    // rust: out.extend(
    // rust: events
    // rust: .into_iter()
    // rust: .filter(|event| matches!(event, MobEvent::ParticleAt { .. })),
    // rust: );
}

// `Entity.restituteMovementAfterCollisions`' native inputs, bound for a mob:
// its own bounciness attribute, the block's coefficients and the pose of a
// mob that never sneaks. The phases themselves are
// `movement_restitution::restitute_movement`, the same port the player and
// dropped items use.
MobRestitution :: struct {
    mob: ^'a mut Mob,
    world: ^'a MobWorld<'w>,
}
    // rust: impl<'a, 'w> MobRestitution<'a, 'w> {
    // The block's movement data: its coefficients and its bounce tag.
    // rust: fn movement(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: ) -> Result<horizon_world::movement_properties::MovementBlock, ()> {
    // rust: self.world.movement.get(state).map_err(|_| ())
}
}
    // rust: impl RestitutionWorld for MobRestitution<'_, '_> {
    // The block data cannot fail here: a state the registry does not know
    // reads as a block with no bounce, never as an error.
    // rust: type Error = ();
    // The entity's own suppression is its sneak pose, and a mob never
    // sneaks; the block's tag is `block_suppresses_bounce` below.
suppressing_bounce :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(false)
}
    // `getAttributeValue(BOUNCINESS)`: a sulfur cube's.
entity_bounciness :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.mob.entity_bounciness())
}
velocity :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.mob.velocity)
}
    // `living_motion::effective_gravity`: the gravity attribute, floored to
    // 0.01 while a Slow Falling mob is on its way down.
effective_gravity :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.mob.effective_gravity())
}
block_suppresses_bounce :: proc(self: ^Self, state: BlockStateId) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.movement(state)?.suppresses_bounce)
}
    // `Entity.getBlockBounciness`: the restitution of the block under the
    // entity, so a mob landing on a slime block or a bed bounces too.
block_bounce_restitution :: proc(self: ^Self, state: BlockStateId) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.movement(state)?.coefficients.bounce_restitution)
}
    // `LivingEntity.getAirDrag`.
air_drag :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.mob.air_drag())
}
    // `Entity.getBlockPosBelowThatAffectsMyMovement`: `Entity.getOnPos(0.500001F)`,
    // which keeps the supporting fence gate's or wall's column. The offset is
    // over 0.5, so the fence case never applies.
movement_support_position :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let position = self.mob.position;
    // rust: let offset = f64::from(horizon_world::movement_support::MOVEMENT_SUPPORT_OFFSET);
    // rust: let Some(support) = self.mob.supporting else {
    // rust: return Ok(BlockPos::new(
    // rust: position.x.floor() as i32,
    // rust: (position.y - offset).floor() as i32,
    // rust: position.z.floor() as i32,
    // rust: ));
}
    // rust: let state = self.world.world.block(support[0], support[1], support[2]);
    // rust: let keeps_column = self
    // rust: .movement(state)
    // rust: .is_ok_and(|b| b.wall || b.coefficients.fence_gate);
    // rust: Ok(if keeps_column {
    // rust: BlockPos::new(support[0], support[1], support[2])
    // rust: } else {
    // rust: BlockPos::new(support[0], (position.y - offset).floor() as i32, support[2])
    // rust: })
}
    // `BlockLandingRegistry.bounce_on`'s only case is the shelf mushroom's
    // bounce sound, which no path plays yet (`landing.rs` binds it for the
    // player too and the game's sound code resolves neither).
bounce_on :: proc(self: ^Self, _: BlockStateId, _: BlockPos, _: f64) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(())
}
bounce_event :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(())
}
    // Nothing to mark: the bounce is already the velocity of this tick, and
    // the mob tracker sends the position and velocity it reads.
mark_position_for_sync :: proc(self: ^Self) {
}
set_velocity :: proc(self: ^Self, velocity: Vec3) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.mob.velocity = velocity;
    // rust: Ok(())
}
}

    // rust: mod tests {
//     use super::*;
    // A pig dropped hard onto a block bounces by that block's restitution
    // (`Entity.getBlockBounciness`): landing on a slime block sends it back
    // up, landing on stone stops it dead. The same 8-block fall then costs the
    // pig what the block's own `fallOn` allows (`Block.fallOn`): all 5 on
    // stone, 1 on hay or honey, 0 on slime, 1 on a bed, and a stalagmite kills.
a_mob_bounces_off_a_bouncy_block_and_not_off_stone :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("entity-types.json").exists()
    // rust: || !root.join("movement-properties.nbt").exists()
    // rust: {
    // rust: return;
}
    // rust: let assets = crate::assets::Assets::load(&root).unwrap();
    // rust: let registry = assets.registry;
    // rust: let facts = crate::blocks::BlockFacts::load(&root, registry).unwrap();
    // rust: let motion = crate::motion::MotionResources::load(&root, &assets).unwrap();
    // rust: let data = super::super::MobData::load(&root, &facts);
    // rust: let types = super::super::MobTypes::load(&root).unwrap();
    // rust: let biomes = crate::biome::Biomes::load(&root).unwrap();
    // rust: let items = crate::items::Items::load(
    // rust: &root,
    // rust: registry,
    // rust: &facts,
    // rust: &horizon_world::loot::PackOverlay::NONE,
    // rust: )
    // rust: .unwrap();
    // rust: let collision = std::sync::Arc::new(crate::collisions::load(&root, registry).unwrap());
    // rust: let suffocation =
    // rust: crate::mobs::suffocation::bind(collision.clone(), &motion.causes_suffocation).unwrap();
    // rust: let lid_openers = std::collections::HashMap::new();
    // rust: for (ground, bounces, health) in [
    // rust: ("minecraft:slime_block", true, 10.0),
    // rust: ("minecraft:stone", false, 5.0),
    // rust: ("minecraft:hay_block", false, 9.0),
    // rust: ("minecraft:honey_block", false, 9.0),
    // rust: ("minecraft:red_bed", true, 9.0),
    // rust: ("minecraft:pointed_dripstone", false, 0.0),
    // rust: ] {
    // rust: let air = registry.default_state("minecraft:air").unwrap();
    // rust: let mut world = crate::world::World::new(air, 0);
    // rust: world.chunks.insert(
    // rust: (0, 0),
    // rust: std::sync::Arc::new(crate::chunk::Chunk::empty(0, 0)),
    // rust: );
    // rust: let floor = registry.default_state(ground).unwrap();
    // rust: for x in 0..=1 {
    // rust: for z in 0..=1 {
    // rust: world.set(x, 0, z, floor).unwrap();
}
}
    // rust: let w = MobWorld {
    // rust: teams: Default::default(),
    // rust: world: &world,
    // rust: registry,
    // rust: facts: &facts,
    // rust: fluid_tables: &motion.fluids,
    // rust: movement: &motion.blocks,
    // rust: collision: &collision,
    // rust: suffocation: &suffocation,
    // rust: data: &data,
    // rust: player: None,
    // rust: controlling_player_movement: None,
    // rust: nearest_player: None,
    // rust: others: &[],
    // rust: dragon: None,
    // rust: leash_boats: &[],
    // rust: others_grid: None,
    // rust: others_index: None,
    // rust: others_villagers: None,
    // rust: daylight: true,
    // rust: monsters_burn: false,
    // rust: game_time: 1000,
    // rust: day_time: 18000,
    // rust: raining: false,
    // rust: thundering: false,
    // rust: nether: false,
    // rust: block_tags: &items.block_tags,
    // rust: landing: &motion.landing,
    // rust: biomes: &biomes,
    // rust: universal_anger: false,
    // rust: mob_griefing: true,
    // rust: mob_drops: true,
    // rust: max_entity_cramming: 24,
    // rust: difficulty: super::super::spawning::LocalDifficulty::new(2, 18000, 0, 0.0),
    // rust: end: false,
    // rust: world_seed: 0,
    // rust: sea_level: 63,
    // rust: items: Some(&items),
    // rust: lid_openers: &lid_openers,
    // rust: mod_effects: None,
    // rust: border: None,
}
    // rust: let kind = std::sync::Arc::new(types.types["minecraft:pig"].clone());
    // rust: let mut m = Mob::new(1, kind, Vec3::new(0.5, 1.0, 0.5), 0.0);
            // Falling faster than gravity, so the landing is hard enough.
    // rust: m.velocity = Vec3::new(0.0, -1.0, 0.0);
    // rust: m.fall_distance = 8.0;
    // rust: m.do_move(&w, &mut Vec::new());
    // rust: assert_eq!(m.health, health, "{ground}: health after an 8 block fall");
    // rust: assert!(
    // rust: m.vertical_collision_below,
    // rust: "{ground}: the pig lands on the block"
    // rust: );
    // rust: if bounces {
    // rust: assert!(
    // rust: m.velocity.y > 0.0,
    // rust: "{ground}: restitution sends the pig back up, got {}",
    // rust: m.velocity.y
    // rust: );
    // rust: } else {
    // rust: assert!(
    // rust: m.velocity.y <= 0.0,
    // rust: "{ground}: no bounce, got {}",
    // rust: m.velocity.y
    // rust: );
}
}
}

    // `LivingEntity.travelInFluid` ends with
    // `floatInLiquidWhileRidden(FluidTags.ENTITY_FLOATABLE)`: a mount that
    // carries a passenger, is in `minecraft:can_float_while_ridden` and sits
    // deeper in the water than its jump threshold gains 0.04 a tick upwards.
    // That is what keeps a ridden horse and its rider afloat; an empty horse
    // gets nothing and goes on sinking.
a_ridden_horse_floats_in_deep_water :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("entity-types.json").exists()
    // rust: || !root.join("movement-properties.nbt").exists()
    // rust: {
    // rust: return;
}
    // rust: let assets = crate::assets::Assets::load(&root).unwrap();
    // rust: let registry = assets.registry;
    // rust: let facts = crate::blocks::BlockFacts::load(&root, registry).unwrap();
    // rust: let motion = crate::motion::MotionResources::load(&root, &assets).unwrap();
    // rust: let data = super::super::MobData::load(&root, &facts);
    // rust: let types = super::super::MobTypes::load(&root).unwrap();
    // rust: let biomes = crate::biome::Biomes::load(&root).unwrap();
    // rust: let items = crate::items::Items::load(
    // rust: &root,
    // rust: registry,
    // rust: &facts,
    // rust: &horizon_world::loot::PackOverlay::NONE,
    // rust: )
    // rust: .unwrap();
    // rust: let collision = std::sync::Arc::new(crate::collisions::load(&root, registry).unwrap());
    // rust: let suffocation =
    // rust: crate::mobs::suffocation::bind(collision.clone(), &motion.causes_suffocation).unwrap();
    // rust: let lid_openers = std::collections::HashMap::new();
    // rust: let air = registry.default_state("minecraft:air").unwrap();
    // rust: let water = registry.default_state("minecraft:water").unwrap();
    // rust: let mut world = crate::world::World::new(air, 0);
    // rust: world.chunks.insert(
    // rust: (0, 0),
    // rust: std::sync::Arc::new(crate::chunk::Chunk::empty(0, 0)),
    // rust: );
    // rust: for x in 4..=12 {
    // rust: for z in 4..=12 {
    // rust: for y in 63..=66 {
    // rust: world.set(x, y, z, water).unwrap();
}
}
}
    // rust: let w = MobWorld {
    // rust: teams: Default::default(),
    // rust: world: &world,
    // rust: registry,
    // rust: facts: &facts,
    // rust: fluid_tables: &motion.fluids,
    // rust: movement: &motion.blocks,
    // rust: collision: &collision,
    // rust: suffocation: &suffocation,
    // rust: data: &data,
    // rust: player: None,
    // rust: controlling_player_movement: None,
    // rust: nearest_player: None,
    // rust: others: &[],
    // rust: dragon: None,
    // rust: leash_boats: &[],
    // rust: others_grid: None,
    // rust: others_index: None,
    // rust: others_villagers: None,
    // rust: daylight: true,
    // rust: monsters_burn: false,
    // rust: game_time: 1000,
    // rust: day_time: 18000,
    // rust: raining: false,
    // rust: thundering: false,
    // rust: nether: false,
    // rust: block_tags: &items.block_tags,
    // rust: landing: &motion.landing,
    // rust: biomes: &biomes,
    // rust: universal_anger: false,
    // rust: mob_griefing: true,
    // rust: mob_drops: true,
    // rust: max_entity_cramming: 24,
    // rust: difficulty: super::super::spawning::LocalDifficulty::new(2, 18000, 0, 0.0),
    // rust: end: false,
    // rust: world_seed: 0,
    // rust: sea_level: 63,
    // rust: items: Some(&items),
    // rust: lid_openers: &lid_openers,
    // rust: mod_effects: None,
    // rust: border: None,
}
    // rust: let kind = std::sync::Arc::new(types.types["minecraft:horse"].clone());
    // rust: let mut sank = 0.0;
    // rust: let mut floated = 0.0;
    // rust: for ridden in [false, true] {
    // rust: let mut m = Mob::new(1, kind.clone(), Vec3::new(8.5, 64.0, 8.5), 0.0);
    // rust: if ridden {
    // rust: m.rider = Some(super::super::equine::Rider {
    // rust: strafe: 0.0,
    // rust: forward: 0.0,
    // rust: yaw: 0.0,
    // rust: pitch: 0.0,
    // rust: jump: 0.0,
    // rust: steer: false,
    // rust: sprint: false,
    // rust: jumping: false,
    // rust: client: false,
    // rust: });
}
    // rust: m.fluids.in_water = true;
    // rust: m.fluids.water = 1.0;
    // rust: m.travel(&w, Vec3::ZERO, &mut Vec::new());
    // rust: if ridden {
    // rust: floated = m.velocity.y;
    // rust: } else {
    // rust: sank = m.velocity.y;
}
}
    // rust: assert!(sank < 0.0, "an empty horse sinks, got {sank}");
    // rust: let lift = floated - sank;
    // rust: assert!(
    // rust: (lift - f64::from(0.04_f32)).abs() < 1.0e-9,
    // rust: "a ridden horse gains 0.04 a tick, got {lift}"
    // rust: );
}

    // `LivingEntity.aiStep` calls `travel` and only then
    // `applyEffectsFromBlocks`, so the lift of a bubble column is added after
    // the water's drag and is not scaled by it. A pig 1.0 high in a column of
    // two blocks of water takes the plain water velocity from `travel`, and
    // the lift (0.06 for each column block its box touches) on top of it.
a_bubble_column_lifts_a_mob_after_travel_not_inside_it :: proc() {
}
    // rust: let run = |column: bool| {
    // rust: let mut out = None;
    // rust: let build =
    // rust: |world: &mut crate::world::World,
    // rust: registry: &horizon_world::registry::BlockRegistry| {
    // rust: world.chunks.insert(
    // rust: (0, 0),
    // rust: std::sync::Arc::new(crate::chunk::Chunk::empty(0, 0)),
    // rust: );
    // rust: let stone = registry.default_state("minecraft:stone").unwrap();
    // rust: let water = registry.default_state("minecraft:water").unwrap();
    // rust: let mut lift = registry
    // rust: .state(registry.default_state("minecraft:bubble_column").unwrap())
    // rust: .unwrap()
    // rust: .clone();
    // rust: lift.properties.insert("drag".into(), "false".into());
    // rust: let lift = registry.resolve(&lift).unwrap();
    // rust: for x in 0..=2 {
    // rust: for z in 0..=2 {
    // rust: world.set(x, 0, z, stone).unwrap();
    // rust: for y in 1..=6 {
    // rust: world.set(x, y, z, water).unwrap();
}
}
}
    // rust: if column {
    // rust: for y in 1..=6 {
    // rust: world.set(1, y, 1, lift).unwrap();
}
}
}
    // rust: crate::mobs::world::with_built_test_world(&[], build, |w, types| {
    // rust: let kind = std::sync::Arc::new(types.types["minecraft:iron_golem"].clone());
    // rust: let mut m = Mob::new(1, kind, Vec3::new(1.5, 2.0, 1.5), 0.0);
    // rust: m.fluids.in_water = true;
    // rust: m.fluids.water = 1.0;
    // rust: m.travel(w, Vec3::ZERO, &mut Vec::new());
    // rust: let after_travel = m.velocity.y;
    // rust: m.apply_effects_from_blocks(w, &mut Vec::new());
    // rust: out = Some((after_travel, m.velocity.y));
    // rust: });
    // rust: out
}
    // rust: let (Some((plain, _)), Some((travelled, lifted))) = (run(false), run(true)) else {
    // rust: return;
}
    // rust: assert_eq!(
    // rust: travelled, plain,
    // rust: "travel alone does not take the column's lift"
    // rust: );
        // The golem's 2.7 high box touches three column blocks (y 2, 3, 4).
    // rust: assert!(
    // rust: (lifted - plain - 3.0 * 0.06).abs() < 1.0e-9,
    // rust: "three column blocks lift it by 0.18 after the drag, got {}",
    // rust: lifted - plain
    // rust: );
}

    // `Entity.move`'s last step, `getBlockSpeedFactor`: a mob sliding on soul
    // sand (0.4) or honey (0.4) keeps 40% of its horizontal speed each move,
    // on stone it keeps all of it, and its vertical speed is untouched.
a_mob_on_soul_sand_or_honey_is_slowed_by_the_move :: proc() {
}
    // rust: for (block, factor) in [
    // rust: ("minecraft:stone", 1.0),
    // rust: ("minecraft:soul_sand", 0.4),
    // rust: ("minecraft:honey_block", 0.4),
    // rust: ] {
    // rust: let build =
    // rust: |world: &mut crate::world::World,
    // rust: registry: &horizon_world::registry::BlockRegistry| {
    // rust: world.chunks.insert(
    // rust: (0, 0),
    // rust: std::sync::Arc::new(crate::chunk::Chunk::empty(0, 0)),
    // rust: );
    // rust: let id = registry.default_state(block).unwrap();
    // rust: for x in 0..=4 {
    // rust: for z in 0..=2 {
    // rust: world.set(x, 0, z, id).unwrap();
}
}
}
    // rust: crate::mobs::world::with_built_test_world(&[], build, |w, types| {
    // rust: let kind = std::sync::Arc::new(types.types["minecraft:zombie"].clone());
    // rust: let mut m = Mob::new(1, kind, Vec3::new(0.5, 1.0, 1.5), 0.0);
    // rust: m.on_ground = true;
    // rust: m.velocity = Vec3::new(0.2, 0.0, 0.0);
    // rust: m.do_move(w, &mut Vec::new());
    // rust: let expected = f64::from(factor as f32) * 0.2;
    // rust: assert!(
    // rust: (m.velocity.x - expected).abs() < 1.0e-9,
    // rust: "{block}: velocity.x {} expected {expected}",
    // rust: m.velocity.x
    // rust: );
    // rust: });
}
}

    // `Entity.collectColliders`: the world border's wall stops a mob's move
    // as it stops the player's (#7080). A border of size 10 around (8, 8)
    // has its east wall at x = 13.
the_world_border_stops_a_mob :: proc() {
}
    // rust: let border =
    // rust: horizon_core::geometry::border::BorderGeometry::new([8.0, 8.0], 10.0, 29_999_984)
    // rust: .unwrap();
    // rust: let build = |world: &mut crate::world::World,
    // rust: _: &horizon_world::registry::BlockRegistry| {
    // rust: world.chunks.insert(
    // rust: (0, 0),
    // rust: std::sync::Arc::new(crate::chunk::Chunk::empty(0, 0)),
    // rust: );
}
    // rust: crate::mobs::world::with_built_test_world(&[], build, |w, types| {
    // rust: let kind = std::sync::Arc::new(types.types["minecraft:pig"].clone());
    // rust: let mut east_edge = [0.0; 2];
    // rust: for (i, bordered) in [false, true].into_iter().enumerate() {
    // rust: let w = MobWorld {
    // rust: border: bordered.then_some(&border),
    // rust: ..w.clone()
}
                // 1.5 blocks east from x = 11.5: past the wall at 13 if nothing stops it.
    // rust: let mut m = Mob::new(1, kind.clone(), Vec3::new(11.5, 64.0, 8.5), 0.0);
    // rust: m.velocity = Vec3::new(1.5, 0.0, 0.0);
    // rust: m.do_move(&w, &mut Vec::new());
    // rust: east_edge[i] = m.bounds().max_position().x;
    // rust: assert_eq!(m.horizontal_collision, bordered);
}
    // rust: assert!(
    // rust: east_edge[0] > 13.0,
    // rust: "no border: the pig walks on, {east_edge:?}"
    // rust: );
    // rust: assert!(
    // rust: (east_edge[1] - 13.0).abs() < 1.0e-7,
    // rust: "the pig's east side stops on the wall at x = 13, {east_edge:?}"
    // rust: );
    // rust: });
}

    // `LivingEntity.checkFallDamage`'s dust: nothing within the safe distance,
    // `150 * min(0.2 + power / 15, 2.5)` block particles beyond it.
a_landing_throws_up_dust_by_the_power_of_the_fall :: proc() {
}
        // Within the safe distance of 3, or by a hair over it: power 0.
    // rust: assert_eq!(landing_dust_count(2.5, 3.0), None);
    // rust: assert_eq!(landing_dust_count(3.0, 3.0), None);
        // A fall of 7: power 4, 150 * (0.2 + 4 / 15) = 70.
    // rust: assert_eq!(landing_dust_count(7.0, 3.0), Some(70));
        // A long fall is capped at 150 * 2.5.
    // rust: assert_eq!(landing_dust_count(60.0, 3.0), Some(375));
        // A mob that takes no fall damage still has a safe distance of its own.
    // rust: assert_eq!(landing_dust_count(7.0, 10.0), None);
}
    // Over the block it lands on the dust starts at the mob; straddling
    // into another column it is pulled to that block's near edge.
landing_dust_is_pulled_to_the_block_it_landed_on :: proc() {
}
    // rust: let on = Vec3::new(4.3, 65.0, 7.6);
    // rust: assert_eq!(landing_dust_at(on, [4, 64, 7]), on);
        // The mob stands over block (4, 7) but its feet block is (5, 7).
    // rust: let straddling = landing_dust_at(Vec3::new(5.1, 65.0, 7.5), [4, 64, 7]);
    // rust: assert_eq!(straddling, Vec3::new(5.0, 65.0, 7.5));
}
    // `LivingEntity.getDimensions` is `getDefaultDimensions(pose).scale(
    // getScale())` on every living entity, not only on a player or mannequin
    // whose pose sets the box (`Avatar.POSES`): a cow's `EntityType.COW` box
    // (0.9 x 1.4, its eyes at 1.3) at `minecraft:scale` 2 is 1.8 x 2.8 with
    // the eyes at 2.6, and the box `Mob.bounds` hands the hitbox raycast, the
    // attack range and the leash pins grows with it.
a_scale_attribute_grows_every_living_entitys_box :: proc() {
}
    // rust: let close = |a: f64, b: f64| (a - b).abs() < 1e-6;
    // rust: let mut cow = Mob::new(1, crate::mobs::sensor_scan_tests::kind(), Vec3::ZERO, 0.0);
    // rust: let (w, h, e) = cow.dims();
    // rust: assert!(
    // rust: close(w, 0.9) && close(h, 1.4) && close(e, 1.3),
    // rust: "no scale: {w}x{h}x{e}"
    // rust: );
    // rust: cow.extra.model_scale = 2.0;
    // rust: let (w, h, e) = cow.dims();
    // rust: assert!(
    // rust: close(w, 1.8) && close(h, 2.8) && close(e, 2.6),
    // rust: "scale 2: {w}x{h}x{e}"
    // rust: );
    // rust: let b = cow.bounds();
    // rust: assert!(
    // rust: close(b.min_position().x, -0.9)
    // rust: && close(b.max_position().x, 0.9)
    // rust: && close(b.max_position().y, 2.8),
    // rust: "scale 2 box: {b:?}"
    // rust: );
        // `RangedAttribute("attribute.name.scale", 1.0, 0.0625, 16.0)`: its
        // floor shrinks the cow to 0.05625 x 0.0875, eyes at 0.08125.
    // rust: cow.extra.model_scale = 0.0625;
    // rust: let (w, h, e) = cow.dims();
    // rust: assert!(
    // rust: close(w, 0.05625) && close(h, 0.0875) && close(e, 0.08125),
    // rust: "scale 0.0625: {w}x{h}x{e}"
    // rust: );
}
    // `LivingEntity.getDimensions` answers a sleeping entity with
    // `SLEEPING_DIMENSIONS` before it ever reaches `getScale`: a sleeper's
    // 0.2 box and eye height stay 0.2 whatever its `minecraft:scale`.
a_sleeping_mob_keeps_its_bed_box_unscaled :: proc() {
}
//         use crate::mobs::Species;
    // rust: let mut kind = (*crate::mobs::sensor_scan_tests::kind()).clone();
    // rust: kind.id = "minecraft:villager".into();
    // rust: kind.species = Species::Villager;
    // rust: let mut villager = Mob::new(1, std::sync::Arc::new(kind), Vec3::ZERO, 0.0);
        // Villager.sleeping: the bed's facing code, not 0.
    // rust: villager.extra.ints[1] = 1;
    // rust: villager.extra.model_scale = 4.0;
    // rust: let (w, h, e) = villager.dims();
    // rust: let close = |a: f64, b: f64| (a - b).abs() < 1e-6;
    // rust: assert!(
    // rust: close(w, 0.2) && close(h, 0.2) && close(e, 0.2),
    // rust: "asleep: {w}x{h}x{e}"
    // rust: );
}
    // `LivingEntity.sanitizeScale`: a shulker takes at most 3 and a happy
    // ghast at most 1, and the box takes the capped value (`EntityType.SHULKER`
    // is 1 x 1 with its eyes at 0.5).
a_species_caps_the_scale_it_takes :: proc() {
}
//         use crate::mobs::Species;
    // rust: let mob = |id: &str, species: Species| {
    // rust: let mut kind = (*crate::mobs::sensor_scan_tests::kind()).clone();
    // rust: kind.id = id.into();
    // rust: kind.species = species;
    // rust: (kind.width, kind.height, kind.eye_height) = (1.0, 1.0, 0.5);
    // rust: Mob::new(1, std::sync::Arc::new(kind), Vec3::ZERO, 0.0)
}
    // rust: let mut shulker = mob("minecraft:shulker", Species::Shulker);
    // rust: shulker.extra.model_scale = 4.0;
    // rust: assert_eq!(shulker.model_scale(), 3.0);
    // rust: let (w, h, e) = shulker.dims();
    // rust: let close = |a: f64, b: f64| (a - b).abs() < 1e-6;
    // rust: assert!(
    // rust: close(w, 3.0) && close(h, 3.0) && close(e, 1.5),
    // rust: "shulker: {w}x{h}x{e}"
    // rust: );
    // rust: let mut ghast = mob("minecraft:happy_ghast", Species::HappyGhast);
    // rust: ghast.extra.model_scale = 2.0;
    // rust: assert_eq!(ghast.model_scale(), 1.0);
        // Every other species takes the attribute as it came.
    // rust: let mut cow = mob("minecraft:cow", Species::Cow);
    // rust: cow.extra.model_scale = 4.0;
    // rust: assert_eq!(cow.model_scale(), 4.0);
}
    // `Sniffer.jumpFromGround`: a hop the move control asked for, taken from
    // nearly standing still, carries the sniffer a tenth of a block along its
    // yaw (`moveRelative(0.1F, (0, 0, 1))`). A sniffer that already moves, one
    // the move control did not ask to move, and every other species keep the
    // hop they had.
a_sniffers_hop_from_a_standstill_carries_it_forward :: proc() {
}
//         use crate::mobs::Species;
    // rust: let sniffer = |speed: f64, sideways: f64| {
    // rust: let mut kind = (*crate::mobs::sensor_scan_tests::kind()).clone();
    // rust: kind.id = "minecraft:sniffer".into();
    // rust: kind.species = Species::Sniffer;
    // rust: kind.jump_strength = 0.42;
    // rust: let mut m = Mob::new(1, std::sync::Arc::new(kind), Vec3::new(0.5, 64.0, 0.5), 0.0);
            // `MoveControl.getSpeedModifier` and the speed it moves at.
    // rust: m.ai.mov.speed_modifier = speed;
    // rust: m.velocity = Vec3::new(0.0, 0.0, sideways);
    // rust: m
}
        // Yaw 0 faces south (+z), so the nudge lands on z.
    // rust: let hop = |m: &mut Mob| {
    // rust: let mut jumped = false;
    // rust: if crate::mobs::world::with_test_world(&[], |w, _| m.jump_from_ground(w)) {
    // rust: jumped = true;
}
    // rust: jumped
}
    // rust: let mut m = sniffer(1.0, 0.0);
    // rust: if !hop(&mut m) {
    // rust: return;
}
    // rust: assert!(
    // rust: (m.velocity.z - 0.1).abs() < 1.0e-6 && m.velocity.x.abs() < 1.0e-6,
    // rust: "the hop goes forward: {:?}",
    // rust: m.velocity
    // rust: );
    // rust: assert!(m.velocity.y > 0.0, "and it is still a hop");
        // Already moving sideways: `horizontalDistanceSqr` is over the 0.01.
    // rust: let mut moving = sniffer(1.0, 0.2);
    // rust: assert!(hop(&mut moving));
    // rust: assert!(
    // rust: (moving.velocity.z - 0.2).abs() < 1.0e-6,
    // rust: "{:?}",
    // rust: moving.velocity
    // rust: );
        // The move control wanted nothing this tick.
    // rust: let mut still = sniffer(0.0, 0.0);
    // rust: assert!(hop(&mut still));
    // rust: assert_eq!(still.velocity.z, 0.0);
        // No other species gets the nudge.
    // rust: let mut kind = (*crate::mobs::sensor_scan_tests::kind()).clone();
    // rust: kind.jump_strength = 0.42;
    // rust: let mut cow = Mob::new(1, std::sync::Arc::new(kind), Vec3::new(0.5, 64.0, 0.5), 0.0);
    // rust: cow.ai.mov.speed_modifier = 1.0;
    // rust: assert!(hop(&mut cow));
    // rust: assert_eq!(cow.velocity.z, 0.0);
}

    // #8140: `LivingEntity.handleOnClimbable` slows any mob in vines, not
    // only a spider on a wall. A cow let go at rest moves before gravity
    // pulls it: 0, then 0.0784, then 0.155232 in open air ((v - 0.08) *
    // 0.98); in vines each move down from the third on is held to 0.15F,
    // and the fall distance, reset before each move, is that one move.
a_mob_in_vines_slides_down_slowly :: proc() {
}
    // rust: let run = |vines: bool| {
    // rust: let mut out = None;
    // rust: let build =
    // rust: |world: &mut crate::world::World,
    // rust: registry: &horizon_world::registry::BlockRegistry| {
    // rust: let stone = registry.default_state("minecraft:stone").unwrap();
    // rust: let mut vine = registry
    // rust: .state(registry.default_state("minecraft:vine").unwrap())
    // rust: .unwrap()
    // rust: .clone();
    // rust: vine.properties.insert("south".into(), "true".into());
    // rust: let vine = registry.resolve(&vine).unwrap();
    // rust: world.chunks.insert(
    // rust: (0, 0),
    // rust: std::sync::Arc::new(crate::chunk::Chunk::empty(0, 0)),
    // rust: );
    // rust: world.set(1, 0, 1, stone).unwrap();
    // rust: for y in 1..=12 {
    // rust: world.set(1, y, 2, stone).unwrap();
    // rust: if vines {
    // rust: world.set(1, y, 1, vine).unwrap();
}
}
}
    // rust: crate::mobs::world::with_built_test_world(&[], build, |w, types| {
    // rust: let kind = std::sync::Arc::new(types.types["minecraft:cow"].clone());
    // rust: let mut m = Mob::new(1, kind, Vec3::new(1.5, 10.0, 1.5), 0.0);
    // rust: m.on_ground = false;
    // rust: let mut drops = Vec::new();
    // rust: for _ in 0..12 {
    // rust: let before = m.position.y;
    // rust: m.travel(w, Vec3::ZERO, &mut Vec::new());
    // rust: drops.push(before - m.position.y);
}
    // rust: out = Some((drops, m.fall_distance));
    // rust: });
    // rust: out
}
    // rust: let (Some((open, open_fall)), Some((vines, vine_fall))) = (run(false), run(true)) else {
    // rust: return;
}
    // rust: assert_eq!(open[0], 0.0, "open air, tick 1: {open:?}");
    // rust: assert!(
    // rust: (open[1] - 0.0784).abs() < 1.0e-6,
    // rust: "open air, tick 2: {open:?}"
    // rust: );
    // rust: assert!(
    // rust: (open[2] - 0.155232).abs() < 1.0e-6,
    // rust: "open air, tick 3: {open:?}"
    // rust: );
    // rust: assert!(
    // rust: open[11] > 0.5 && open_fall > 3.0,
    // rust: "open air keeps speeding up: {open:?}"
    // rust: );
    // rust: let limit = f64::from(0.15f32);
    // rust: assert_eq!(vines[0], 0.0, "vines, tick 1: {vines:?}");
    // rust: assert!(
    // rust: (vines[1] - 0.0784).abs() < 1.0e-6,
    // rust: "vines, tick 2: {vines:?}"
    // rust: );
    // rust: for (tick, drop) in vines.iter().enumerate().skip(2) {
    // rust: assert!(
    // rust: (drop - limit).abs() < 1.0e-9,
    // rust: "vines, tick {}: {vines:?}",
    // rust: tick + 1
    // rust: );
}
        // Reset before the move, then the move's own drop: never more.
    // rust: assert!(
    // rust: (vine_fall - limit).abs() < 1.0e-9,
    // rust: "the vines reset the fall each tick, got {vine_fall}"
    // rust: );
}

    // `LivingEntity.onClimbable`: `isFallFlying` in a block of
    // `#minecraft:can_glide_through` (vines) answers false before the
    // climbable test; a ladder is not in that tag, so a glider still holds
    // on to it.
a_gliding_mob_passes_through_vines_but_not_a_ladder :: proc() {
}
    // rust: let build = |world: &mut crate::world::World,
    // rust: registry: &horizon_world::registry::BlockRegistry| {
    // rust: world.chunks.insert(
    // rust: (0, 0),
    // rust: std::sync::Arc::new(crate::chunk::Chunk::empty(0, 0)),
    // rust: );
    // rust: let vine = registry.default_state("minecraft:vine").unwrap();
    // rust: let ladder = registry.default_state("minecraft:ladder").unwrap();
    // rust: world.set(1, 5, 1, vine).unwrap();
    // rust: world.set(3, 5, 1, ladder).unwrap();
}
    // rust: crate::mobs::world::with_built_test_world(&[], build, |w, types| {
    // rust: let kind = std::sync::Arc::new(types.types["minecraft:zombie"].clone());
    // rust: for (x, block, gliding_holds) in [(1.5, "vine", false), (3.5, "ladder", true)] {
    // rust: let mut m = Mob::new(1, kind.clone(), Vec3::new(x, 5.0, 1.5), 0.0);
    // rust: assert!(m.on_climbable(w), "{block}: climbable when not gliding");
    // rust: m.extra.fall_flying = true;
    // rust: assert_eq!(m.on_climbable(w), gliding_holds, "{block}: while gliding");
}
    // rust: });
}
    // `Entity.applyMovementEmissionAndPlaySound` asks `getMovementEmission`:
    // a squid, a glow squid and a bat answer `EVENTS`, so a beached squid
    // flopping across stone sends the `minecraft:step` game event and no
    // sound, where a sheep walking the same block is heard at the block's
    // step volume times 0.15. A silverfish's own `playStepSound` names
    // `entity.silverfish.step` and is never heard either, and a shulker, whose
    // emission is `NONE`, sends nothing at all.
a_squid_and_a_bat_step_without_a_sound :: proc() {
}
    // rust: let build = |world: &mut crate::world::World,
    // rust: registry: &horizon_world::registry::BlockRegistry| {
    // rust: world.chunks.insert(
    // rust: (0, 0),
    // rust: std::sync::Arc::new(crate::chunk::Chunk::empty(0, 0)),
    // rust: );
    // rust: let id = registry.default_state("minecraft:stone").unwrap();
    // rust: for x in 0..=8 {
    // rust: for z in 0..=8 {
    // rust: world.set(x, 0, z, id).unwrap();
}
}
}
    // rust: crate::mobs::world::with_built_test_world(&[], build, |w, types| {
            // One step's worth of walking: 2 blocks times the 0.6 factor, over
            // the 1.0 the first step waits for.
    // rust: let walk = |id: &str| {
    // rust: let kind = std::sync::Arc::new(types.types[id].clone());
    // rust: let mut m = Mob::new(1, kind, Vec3::new(0.5, 1.0, 0.5), 0.0);
    // rust: m.on_ground = true;
    // rust: m.supporting = Some([0, 0, 0]);
    // rust: let mut events = Vec::new();
    // rust: m.movement_emission(w, Vec3::new(2.0, 0.0, 0.0), &mut events);
    // rust: events
}
    // rust: let heard = |events: &[MobEvent]| {
    // rust: events.iter().find_map(|e| match e {
    // rust: MobEvent::Sound(sound, _, volume, pitch) => Some((*sound, *volume, *pitch)),
    // rust: _ => None,
    // rust: })
}
    // rust: let stepped = |events: &[MobEvent]| {
    // rust: events
    // rust: .iter()
    // rust: .any(|e| matches!(e, MobEvent::GameEvent { event, .. } if *event == "minecraft:step"))
}
    // rust: for quiet in ["minecraft:squid", "minecraft:glow_squid", "minecraft:bat"] {
    // rust: let events = walk(quiet);
    // rust: assert_eq!(heard(&events), None, "{quiet} is silent");
    // rust: assert!(stepped(&events), "{quiet} still sends the step event");
}
            // A silverfish asks for its own step sound and its type's emission
            // never plays it.
    // rust: let events = walk("minecraft:silverfish");
    // rust: assert_eq!(heard(&events), None);
    // rust: assert!(stepped(&events));
            // The same walk from a type whose emission is ALL is heard.
    // rust: let events = walk("minecraft:sheep");
    // rust: assert_eq!(heard(&events), Some(("entity.sheep.step", 0.15, 1.0)));
            // Shulker.getMovementEmission is NONE: not even the event.
    // rust: let events = walk("minecraft:shulker");
    // rust: assert_eq!(heard(&events), None);
    // rust: assert!(!stepped(&events), "a shulker emits nothing");
    // rust: });
}

    // #9058: `LivingEntity.getJumpPower` calculates
    // `jump_strength * multiplier * getBlockJumpFactor() + getJumpBoostPower()`.
    // On honey blocks the jump factor is 0.5, halving the jump impulse.
    // Jump Boost effects add 0.1 * (amplifier + 1.0).
living_jump_power_respects_honey_block_and_jump_boost :: proc() {
}
    // rust: let build = |world: &mut crate::world::World,
    // rust: registry: &horizon_world::registry::BlockRegistry| {
    // rust: let stone = registry.default_state("minecraft:stone").unwrap();
    // rust: let honey = registry.default_state("minecraft:honey_block").unwrap();
    // rust: world.chunks.insert(
    // rust: (0, 0),
    // rust: std::sync::Arc::new(crate::chunk::Chunk::empty(0, 0)),
    // rust: );
            // Stone column at (0, 0, 0)
    // rust: world.set(0, 0, 0, stone).unwrap();
            // Honey column at (2, 0, 0)
    // rust: world.set(2, 0, 0, honey).unwrap();
}
    // rust: let ran = crate::mobs::world::with_built_test_world(&[], build, |w, types| {
    // rust: let cow_kind = std::sync::Arc::new(types.types["minecraft:cow"].clone());
    // rust: let close = |a: f32, b: f32| (a - b).abs() < 1.0e-5;

            // 1. Baseline: On normal block (stone, factor 1.0) with no effects, jump power matches m.attrs.jump_strength.
    // rust: let mut on_stone = Mob::new(1, cow_kind.clone(), Vec3::new(0.5, 1.0, 0.5), 0.0);
    // rust: assert!((on_stone.attrs.jump_strength - 0.42).abs() < 1.0e-5);
    // rust: assert!(close(on_stone.block_jump_factor(w), 1.0));
    // rust: assert_eq!(on_stone.jump_boost_power(), 0.0);
    // rust: assert!(close(on_stone.jump_power(w), 0.42));
    // rust: on_stone.jump_from_ground(w);
    // rust: assert!(
    // rust: (on_stone.velocity.y - 0.42).abs() < 1.0e-5,
    // rust: "stone baseline velocity.y"
    // rust: );

            // 2. Blocked negative / Reduction on honey: On honey block (jump factor 0.5), jump power is halved.
    // rust: let mut on_honey = Mob::new(2, cow_kind.clone(), Vec3::new(2.5, 1.0, 0.5), 0.0);
    // rust: assert!(
    // rust: close(on_honey.block_jump_factor(w), 0.5),
    // rust: "honey jump factor must be 0.5"
    // rust: );
    // rust: assert!(
    // rust: close(on_honey.jump_power(w), 0.42 * 0.5),
    // rust: "honey halving jump power"
    // rust: );
    // rust: on_honey.jump_from_ground(w);
    // rust: assert!(
    // rust: (on_honey.velocity.y - 0.21).abs() < 1.0e-5,
    // rust: "honey reduced velocity.y"
    // rust: );

            // 3. Enabled positive / Jump boost: With minecraft:jump_boost effect (amp 0 and amp 1),
            // jump power increases by +0.1 and +0.2 respectively.
    // rust: let mut boosted_0 = Mob::new(3, cow_kind.clone(), Vec3::new(0.5, 1.0, 0.5), 0.0);
    // rust: boosted_0
    // rust: .extra
    // rust: .effects
    // rust: .push(("minecraft:jump_boost", 200, 0));
    // rust: assert!(close(boosted_0.jump_boost_power(), 0.1));
    // rust: assert!(close(boosted_0.jump_power(w), 0.42 + 0.1));
    // rust: boosted_0.jump_from_ground(w);
    // rust: assert!((boosted_0.velocity.y - 0.52).abs() < 1.0e-5);

    // rust: let mut boosted_1 = Mob::new(4, cow_kind.clone(), Vec3::new(0.5, 1.0, 0.5), 0.0);
    // rust: boosted_1
    // rust: .extra
    // rust: .effects
    // rust: .push(("minecraft:jump_boost", 200, 1));
    // rust: assert!(close(boosted_1.jump_boost_power(), 0.2));
    // rust: assert!(close(boosted_1.jump_power(w), 0.42 + 0.2));
    // rust: boosted_1.jump_from_ground(w);
    // rust: assert!((boosted_1.velocity.y - 0.62).abs() < 1.0e-5);

            // 4. Edge / Special case: Combined honey block + jump boost and custom modified attrs.jump_strength.
    // rust: let mut combined = Mob::new(5, cow_kind.clone(), Vec3::new(2.5, 1.0, 0.5), 0.0);
    // rust: combined
    // rust: .extra
    // rust: .effects
    // rust: .push(("minecraft:jump_boost", 200, 1));
            // jump_strength * 0.5 + 0.2 = 0.42 * 0.5 + 0.2 = 0.41
    // rust: assert!(close(combined.jump_power(w), 0.42 * 0.5 + 0.2));
    // rust: combined.jump_from_ground(w);
    // rust: assert!((combined.velocity.y - 0.41).abs() < 1.0e-5);

            // Custom modified attribute (e.g. 0.80) on honey with jump boost 0 (0.1)
    // rust: let mut custom_attr = Mob::new(6, cow_kind, Vec3::new(2.5, 1.0, 0.5), 0.0);
    // rust: custom_attr.attrs.jump_strength = 0.80;
    // rust: custom_attr
    // rust: .extra
    // rust: .effects
    // rust: .push(("minecraft:jump_boost", 200, 0));
            // 0.80 * 0.5 + 0.1 = 0.50
    // rust: assert!(close(custom_attr.jump_power(w), 0.50));
    // rust: custom_attr.jump_from_ground(w);
    // rust: assert!((custom_attr.velocity.y - 0.50).abs() < 1.0e-5);

            // 5. Cube jump verification (Slime & MagmaCube on honey vs stone)
    // rust: let slime_kind = std::sync::Arc::new(types.types["minecraft:slime"].clone());
    // rust: let mut slime_stone = Mob::new(7, slime_kind.clone(), Vec3::new(0.5, 1.0, 0.5), 0.0);
    // rust: slime_stone.jump_from_ground(w);
    // rust: assert!((slime_stone.velocity.y - 0.42).abs() < 1.0e-5);

    // rust: let mut slime_honey = Mob::new(8, slime_kind, Vec3::new(2.5, 1.0, 0.5), 0.0);
    // rust: slime_honey.jump_from_ground(w);
    // rust: assert!(
    // rust: (slime_honey.velocity.y - 0.21).abs() < 1.0e-5,
    // rust: "slime jump on honey"
    // rust: );

    // rust: let magma_kind = std::sync::Arc::new(types.types["minecraft:magma_cube"].clone());
    // rust: let mut magma_honey = Mob::new(9, magma_kind, Vec3::new(2.5, 1.0, 0.5), 0.0);
    // rust: magma_honey.extra.size = 2; // boost = 2 * 0.1 = 0.2
    // rust: magma_honey.jump_from_ground(w);
            // 0.42 * 0.5 + 0.2 = 0.41
    // rust: assert!(
    // rust: (magma_honey.velocity.y - 0.41).abs() < 1.0e-5,
    // rust: "magma cube jump on honey"
    // rust: );
    // rust: });
    // rust: assert!(ran, "built test world ran");
}
}
