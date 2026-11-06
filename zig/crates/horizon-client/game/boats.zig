//! Transpiled from Horizon Rust crate
//! Module: horizon-client_boats
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Boats and rafts (`AbstractBoat`): water/land/air status, floating,
//! paddling controls, collisions, riding (`positionRider`, `clampRotation`,
//! dismounting), `BoatItem` placement, `VehicleEntity.hurtServer` breaking,
//! saving and `AbstractBoatRenderer` with animated paddles.
    // rust: mod placement;

// use super::{Game, InteractTarget, entity::Entity, entity_culling::at, view_vector};
// use horizon_client::actions::Action;
// use horizon_client::entity_rules::EntityRules;
// use horizon_client::{
    // rust: blocks::Fluid,
    // rust: collisions::{EntityCollisions, SceneCollisions},
    // rust: items::ItemStack,
    // rust: mesher::Vertex,
    // rust: mobs::{
    // rust: Part,
    // rust: anim::Poses,
    // rust: leash::{Holder, Pending},
    // rust: riders,
    // rust: },
    // rust: motion::{BubbleColumn, RiddenBoat, bubble_column_at},
}
// use horizon_core::{
    // rust: geometry::{Aabb, ShapeOp, Vec3, VoxelShape},
    // rust: position::BlockPos,
    // rust: random::RandomSource,
}
// use horizon_world::collision_context::CollisionContext;
// use std::{collections::HashMap, f32::consts::PI, sync::Arc};

    // rust: pub(super) enum Status {
    // rust: InWater,
    // rust: UnderWater,
    // rust: UnderFlowingWater,
    // rust: OnLand,
    // rust: InAir,
}
    // rust: pub(super) struct Boat {
    /// `Entity.xRot`: kept for `/tp` and `Rotation`; the kind turns only in yaw.
    // rust: pub pitch: f32,
    /// When it joined its list (`horizon_client::join_seq`); set by the list.
    // rust: pub(super) join: horizon_client::join_seq::JoinSeq,
    // rust: pub id: u32,
    /// Wood type (`oak`, `bamboo` for the raft).
    // rust: pub wood: Arc<str>,
    // rust: pub position: Vec3,
    // rust: pub previous: Vec3,
    // rust: pub velocity: Vec3,
    // rust: pub yaw: f32,
    // rust: pub previous_yaw: f32,
    // rust: pub delta_rotation: f32,
    // rust: status: Status,
    // rust: old_status: Status,
    /// `AbstractBoat.oldStatus` is null until the first tick has set a status.
    // rust: status_known: bool,
    // rust: water_level: f64,
    // rust: land_friction: f32,
    // rust: pub(super) out_of_control: f32,
    /// `AbstractBoat.DATA_ID_BUBBLE_TIME` (synched): the ticks of `BUBBLE_TIME`
    /// left before a bubble column lifts or drags the boat; 0 when it is not
    /// over one.
    // rust: pub bubble_time: i32,
    /// `AbstractBoat.isAboveBubbleColumn`, set by `onAboveBubbleColumn` and
    /// cleared by `tickBubbleColumn` (the server's).
    // rust: above_bubble_column: bool,
    /// `AbstractBoat.bubbleColumnDirectionIsDown`.
    // rust: bubble_down: bool,
    /// The server asked a rider whose client moves it (a player) to get out:
    /// `guest_vehicle_tick` honors it (`Entity.ejectPassengers`).
    // rust: pub eject_riders: bool,
    /// `Entity.tickCount`, counted where the wobble is (a client's tick).
    // rust: tick_count: i32,
    /// `AbstractBoat.bubbleMultiplier`, `bubbleAngle` and `bubbleAngleO`
    /// (a client's).
    // rust: bubble_multiplier: f32,
    // rust: bubble_angle: f32,
    // rust: bubble_angle_old: f32,
    // rust: pub hurt_time: i32,
    // rust: pub hurt_dir: i32,
    // rust: pub damage: f32,
    /// `Entity.noGravity` (`NoGravity` in its save).
    // rust: pub no_gravity: bool,
    // rust: pub paddles: [f32; 2],
    // rust: pub paddling: [bool; 2],
    /// Whether this boat has a player controlling its paddles.
    // rust: pub paddle_controller: bool,
    /// left, right, up, down
    // rust: pub input: [bool; 4],
    // rust: pub on_ground: bool,
    /// `Entity.stuckSpeedMultiplier`: set where the boat sits in powder snow
    /// (`PowderSnowBlock.entityInside`), spent by the next move.
    // rust: stuck: Vec3,
    /// `ChestBoat`: a chest with 27 slots in the back seat.
    // rust: pub chest: bool,
    // rust: pub items: Vec<Option<ItemStack>>,
    /// `AbstractBoat.leashData`: who holds its lead (`boat_leads.rs`).
    // rust: pub leash: Option<Holder>,
    /// The player a `Holder::Player` lead is tied to (their UUID).
    // rust: pub leash_player: Option<[i32; 4]>,
    /// A holder read from a save that is not in the world yet.
    // rust: pub leash_pending: Option<Pending>,
    /// `LeashData.angularMomentum`.
    // rust: pub leash_spin: f64,
    /// `Entity.tickCount`, for the 100 ticks a saved holder is waited for.
    // rust: pub age: i32,
}
/// `ChestBoat.CONTAINER_SIZE`.
    // rust: pub(super) const CHEST_SLOTS: usize = 27;
/// `AbstractBoat.BUBBLE_TIME`: the ticks over a bubble column before it
/// lifts or drags the boat.
pub const BUBBLE_TIME: i32 = 60;
/// `EntityEvent` 71 and 72, which `AbstractBoat.tickBubbleColumn` broadcasts
/// for a down and an up column.
    // rust: pub(super) const BUBBLE_DOWN_EVENT: i8 = 71;
    // rust: pub(super) const BUBBLE_UP_EVENT: i8 = 72;
/// What `PowderSnowBlock.entityInside` passes to `makeStuckInBlock`.
pub fn powder_snow_stuck() V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Vec3::new(f64::from(0.9_f32), 1.5, f64::from(0.9_f32))
}
/// The powder snow cells a box reaches into (deflated by 1e-5, as `Entity.checkInsideBlocks`
/// does), in x, y, z order.
pub fn powder_snow_cells(bounds: Aabb, is_snow: impl Fn([i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let e = f64::from(1.0e-5_f32);
    // rust: let bounds = bounds.deflate(Vec3::new(e, e, e));
    // rust: let (lo, hi) = (bounds.min_position(), bounds.max_position());
    // rust: let mut cells = Vec::new();
    // rust: for x in lo.x.floor() as i32..=hi.x.floor() as i32 {
    // rust: for y in lo.y.floor() as i32..=hi.y.floor() as i32 {
    // rust: for z in lo.z.floor() as i32..=hi.z.floor() as i32 {
    // rust: if is_snow([x, y, z]) {
    // rust: cells.push([x, y, z]);
}
}
}
}
    // rust: cells
}
/// The snowflake `PowderSnowBlock.entityInside` sends for an entity whose known movement is
/// `known`: none unless it moved horizontally and a coin falls so, then `Mth.randomBetween(-1, 1)`
/// over 12 sideways and 0.05 up.
pub fn snowflake_velocity(known: Vec3, random: *mut impl RandomSource) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if (known.x == 0.0 && known.z == 0.0) || !random.next_boolean() {
    // rust: return None;
}
    // rust: let xa = (random.next_float() * 2.0 - 1.0) * 0.083_333_336_f32;
    // rust: let za = (random.next_float() * 2.0 - 1.0) * 0.083_333_336_f32;
    // rust: Some([f64::from(xa), f64::from(0.05_f32), f64::from(za)])
}
    // rust: pub(super) const WIDTH: f64 = 1.375;
    // rust: pub(super) const HEIGHT: f64 = 0.5625;
    // rust: impl Boat {
    /// `AbstractBoat.tick`: passengers lose control after 60 consecutive
    /// underwater ticks; any other status resets the counter.
pub fn tick_submersion(self: *Self) void {
}
    // rust: self.out_of_control =
    // rust: if matches!(self.status, Status::UnderWater | Status::UnderFlowingWater) {
    // rust: self.out_of_control + 1.0
    // rust: } else {
    // rust: 0.0
}
}

pub fn new(id: u32, wood: *str, position: Vec3, yaw: f32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: pitch: 0.0,
    // rust: join: Default::default(),
    // rust: id,
    // rust: wood,
    // rust: position,
    // rust: previous: position,
    // rust: velocity: Vec3::ZERO,
    // rust: yaw,
    // rust: previous_yaw: yaw,
    // rust: delta_rotation: 0.0,
    // rust: status: Status::InAir,
    // rust: old_status: Status::InAir,
    // rust: status_known: false,
    // rust: water_level: 0.0,
    // rust: land_friction: 0.0,
    // rust: out_of_control: 0.0,
    // rust: bubble_time: 0,
    // rust: above_bubble_column: false,
    // rust: bubble_down: false,
    // rust: eject_riders: false,
    // rust: tick_count: 0,
    // rust: bubble_multiplier: 0.0,
    // rust: bubble_angle: 0.0,
    // rust: bubble_angle_old: 0.0,
    // rust: hurt_time: 0,
    // rust: hurt_dir: 1,
    // rust: damage: 0.0,
    // rust: no_gravity: false,
    // rust: paddles: [0.0; 2],
    // rust: paddling: [false; 2],
    // rust: paddle_controller: false,
    // rust: input: [false; 4],
    // rust: on_ground: false,
    // rust: stuck: Vec3::ZERO,
    // rust: chest: false,
    // rust: items: Vec::new(),
    // rust: leash: None,
    // rust: leash_player: None,
    // rust: leash_pending: None,
    // rust: leash_spin: 0.0,
    // rust: age: 0,
}
}
    /// A chest boat or chest raft.
pub fn with_chest() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.chest = true;
    // rust: self.items = vec![None; CHEST_SLOTS];
    // rust: self
}
pub fn bounds(self: *Self) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::bounds_at(self.position)
}
    /// The box of a boat whose position is `p`.
pub fn bounds_at(p: Vec3) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let w = WIDTH / 2.0;
    // rust: Aabb::new(
    // rust: Vec3::new(p.x - w, p.y, p.z - w),
    // rust: Vec3::new(p.x + w, p.y + HEIGHT, p.z + w),
    // rust: )
}
    /// The start of `Entity.move`: a boat made stuck since its last move goes its
    /// velocity times the multiplier, and its velocity and the multiplier are spent.
pub fn take_movement(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.stuck.length_squared() <= 1.0e-7 {
    // rust: return self.velocity;
}
    // rust: let movement = self.velocity.multiply(self.stuck);
    // rust: self.stuck = Vec3::ZERO;
    // rust: self.velocity = Vec3::ZERO;
    // rust: movement
}
    /// `isUnderWater`; it stands in for `canAddPassenger`'s
    /// `isEyeInFluid(WATER)` too.
pub fn under_water(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(self.status, Status::UnderWater | Status::UnderFlowingWater)
}
    /// `Entity.isInLiquid`, for `Leashable.angularFriction`.
pub fn in_liquid(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(
    // rust: self.status,
    // rust: Status::InWater | Status::UnderWater | Status::UnderFlowingWater
    // rust: )
}
    /// `getMaxPassengers`: two, one beside a chest.
pub fn max_passengers(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.chest { 1 } else { 2 }
}
    /// `rideHeight`: a third of a boat's height, 8/9 of a raft's.
pub fn ride_height(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let height = HEIGHT as f32;
    // rust: f64::from(if &*self.wood == "bamboo" {
    // rust: height * 0.888_888_9
    // rust: } else {
    // rust: height / 3.0
    // rust: })
}
    /// Where the passenger at `index` of `count` stands, at the boat's current
    /// (or, with `previous`, last) place: `getPassengerAttachmentPoint`
    /// turned with the boat, less the passenger's `rider_offset`.
    // rust: pub fn seat(
    // rust: &self,
    // rust: index: usize,
    // rust: count: usize,
    // rust: animal: bool,
    // rust: rider_offset: f64,
    // rust: previous: bool,
    // rust: ) -> Vec3 {
    // rust: let mut z = if self.chest { 0.15f32 } else { 0.0 };
    // rust: if count > 1 {
    // rust: z = if index == 0 { 0.2 } else { -0.6 };
    // rust: if animal {
    // rust: z += 0.2;
}
}
    // rust: let (at, yaw) = if previous {
    // rust: (self.previous, self.previous_yaw)
    // rust: } else {
    // rust: (self.position, self.yaw)
}
    // rust: riders::seat(
    // rust: [0.0, self.ride_height(), f64::from(z)],
    // rust: rider_offset,
    // rust: at,
    // rust: yaw,
    // rust: )
}
    /// `AbstractBoat.getBubbleAngle`: the wobble, in degrees, `a` of the way
    /// from the last tick's to this one's.
pub fn bubble_angle(self: *Self, a: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.bubble_angle_old + a * (self.bubble_angle - self.bubble_angle_old)
}
    /// `AbstractBoat.tickBubbleColumn`: on a client, the wobble grows by 0.05 a
    /// tick while the synched bubble time runs and fades by 0.1 otherwise.
    // rust: pub(super) fn tick_bubble_wobble(&mut self) {
    // rust: self.tick_count += 1;
    // rust: if self.bubble_time > 0 {
    // rust: self.bubble_multiplier += 0.05;
    // rust: } else {
    // rust: self.bubble_multiplier -= 0.1;
}
    // rust: self.bubble_multiplier = self.bubble_multiplier.clamp(0.0, 1.0);
    // rust: self.bubble_angle_old = self.bubble_angle;
    // rust: self.bubble_angle =
    // rust: 10.0 * (0.5 * f64::from(self.tick_count)).sin() as f32 * self.bubble_multiplier;
}
    /// `AbstractBoat.tickBubbleColumn`'s countdown on the server: the bubble
    /// time drops while the boat stays over a column and resets when it leaves.
    /// `Some(down)` on the tick it runs out: the boat is thrown up (`false`) or
    /// pulled down (`true`).
    // rust: pub(super) fn tick_bubble_countdown(&mut self) -> Option<bool> {
    // rust: if !self.above_bubble_column {
    // rust: self.bubble_time = 0;
}
    // rust: if self.bubble_time <= 0 {
    // rust: return None;
}
    // rust: self.bubble_time -= 1;
    // rust: let diff = BUBBLE_TIME - self.bubble_time - 1;
    // rust: let fired = (diff > 0 && self.bubble_time == 0).then_some(self.bubble_down);
    // rust: self.above_bubble_column = false;
    // rust: fired
}
    /// `getRowingTime`.
pub fn paddle_state(self: *Self, side: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.paddling[side] && self.paddle_controller
}
pub fn rowing_time(self: *Self, side: usize, a: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.paddle_state(side) {
    // rust: let current = self.paddles[side];
    // rust: let previous = current - PI / 8.0;
    // rust: previous + a.clamp(0.0, 1.0) * (current - previous)
    // rust: } else {
    // rust: 0.0
}
}
}
/// Item id -> (boat entity id, wood).
    // rust: impl Boat {
    /// The vanilla entity type id (`oak_boat`, `bamboo_chest_raft`), also
    /// the item it drops.
    // rust: pub(super) fn entity_type(&self) -> String {
    // rust: let chest = if self.chest { "chest_" } else { "" };
    // rust: if &*self.wood == "bamboo" {
    // rust: format!("minecraft:bamboo_{chest}raft")
    // rust: } else {
    // rust: format!("minecraft:{}_{chest}boat", self.wood)
}
}
}
/// The wood of a boat or chest boat item or entity type, and whether it
/// carries a chest.
    // rust: pub(super) fn any_boat_wood(item: &str) -> Option<(&str, bool)> {
    // rust: let name = item.strip_prefix("minecraft:")?;
    // rust: if let Some(wood) = name
    // rust: .strip_suffix("_chest_boat")
    // rust: .or_else(|| name.strip_suffix("_chest_raft"))
    // rust: {
    // rust: return Some((wood, true));
}
    // rust: boat_wood(item).map(|w| (w, false))
}
    // rust: pub(super) fn boat_wood(item: &str) -> Option<&str> {
    // rust: let name = item.strip_prefix("minecraft:")?;
    // rust: name.strip_suffix("_boat")
    // rust: .or_else(|| name.strip_suffix("_raft"))
    // rust: .filter(|w| !w.ends_with("_chest"))
}
    // rust: pub(super) struct BoatModels {
    // rust: pub models: HashMap<String, Part>,
    // rust: pub chest_models: HashMap<String, Part>,
    /// `ModelLayers.BOAT_WATER_PATCH`, shared by every boat (not rafts).
    // rust: pub water_patch: Option<Part>,
}
    // rust: impl BoatModels {
    /// Whether a boat of this wood (with or without a chest) can be drawn.
pub fn has(self: *Self, wood: []const u8, chest: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if chest {
    // rust: self.chest_models.contains_key(wood)
    // rust: } else {
    // rust: self.models.contains_key(wood)
}
}
pub fn load(document: ?*horizon_client::mobs::EntityModelDocument) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut models = HashMap::new();
    // rust: let mut chest_models = HashMap::new();
    // rust: if let Some(document) = document {
    // rust: for key in document.keys() {
    // rust: if let Some(wood) = key
    // rust: .strip_prefix("minecraft:boat/")
    // rust: .and_then(|k| k.strip_suffix("#main"))
    // rust: && let Some(part) = document.model(key)
    // rust: {
    // rust: models.insert(wood.to_owned(), part);
}
    // rust: if let Some(wood) = key
    // rust: .strip_prefix("minecraft:chest_boat/")
    // rust: .and_then(|k| k.strip_suffix("#main"))
    // rust: && let Some(part) = document.model(key)
    // rust: {
    // rust: chest_models.insert(wood.to_owned(), part);
}
}
}
    // rust: Self {
    // rust: models,
    // rust: chest_models,
    // rust: water_patch: document.and_then(|d| d.model("minecraft:boat#water_patch")),
}
}
}
    // rust: impl Game<'_> {
pub fn fluid_height(self: *Self, x: i32, y: i32, z: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.fluid_height_of(x, y, z, Some(Fluid::Water))
}
    /// The horizontal water plane around the camera for the water mirror: the median
    /// standing-water surface of a grid of columns 48 blocks around, each scanned down from
    /// the camera to its ground. A lake or the sea has one plane; the mirror shows only the
    /// water on it. With no water in reach the last plane found stays, so the mirror never
    /// switches off as the camera moves.
    // rust: pub(super) fn water_plane(&self, camera: glam::DVec3) -> Option<f32> {
pub const RADIUS: i32 = 48;
pub const STEP: usize = 4;
pub const DEPTH: i32 = 96;
    // rust: let (cx, cz) = (camera.x.floor() as i32, camera.z.floor() as i32);
    // rust: let top = camera.y.floor() as i32 + 2;
        // Scanned again once the camera moves 8 blocks, or every 5 seconds: a scan reads up
        // to 60 000 blocks on the game thread, and the plane rarely changes.
    // rust: let scan = (
    // rust: [cx >> 3, top >> 3, cz >> 3],
    // rust: self.world.game_time.div_euclid(100),
    // rust: );
    // rust: if self.water_plane_scan.replace(Some(scan)) == Some(scan) {
    // rust: return self.water_plane_memo.get();
}
    // rust: let mut heights = Vec::with_capacity(625);
    // rust: for x in (cx - RADIUS..=cx + RADIUS).step_by(STEP) {
    // rust: for z in (cz - RADIUS..=cz + RADIUS).step_by(STEP) {
                // The top of the column's water: the highest standing water under the
                // camera (a full block's water continues above it).
    // rust: for y in (top - DEPTH..=top).rev() {
    // rust: if let Some((h, source)) = self.fluid_height(x, y, z) {
    // rust: if source && h < 1.0 {
    // rust: heights.push(y as f32 + h);
}
    // rust: break;
}
    // rust: if self.res.facts().get(self.world.block(x, y, z)).solid_render {
    // rust: break;
}
}
}
}
    // rust: if heights.is_empty() {
    // rust: return self.water_plane_memo.get();
}
    // rust: heights.sort_by(f32::total_cmp);
    // rust: let found = heights[heights.len() / 2];
        // The plane in use stays while a quarter of the columns are still on it, so two
        // lakes at different heights do not make the mirror flicker between them.
    // rust: let plane = match self.water_plane_memo.get() {
    // rust: Some(last)
    // rust: if 4 * heights.iter().filter(|h| (*h - last).abs() < 0.05).count()
    // rust: >= heights.len() =>
    // rust: {
    // rust: last
}
    // rust: _ => found,
}
    // rust: self.water_plane_memo.set(Some(plane));
    // rust: Some(plane)
}
    /// `FluidState.getHeight` and whether it is a source, for `fluid` or,
    /// with `None`, any fluid (`ClipContext.Fluid.ANY`).
    // rust: pub(super) fn fluid_height_of(
    // rust: &self,
    // rust: x: i32,
    // rust: y: i32,
    // rust: z: i32,
    // rust: fluid: Option<Fluid>,
    // rust: ) -> Option<(f32, bool)> {
    // rust: let f = self.res.facts().get(self.world.block(x, y, z));
    // rust: if f.fluid == Fluid::None || fluid.is_some_and(|want| f.fluid != want) {
    // rust: return None;
}
    // rust: let above = self.res.facts().get(self.world.block(x, y + 1, z));
        // FluidState.getHeight: 1 under the same fluid, else amount / 9.
    // rust: let height = if above.fluid == f.fluid {
    // rust: 1.0
    // rust: } else {
    // rust: f32::from(f.fluid_level) / 9.0
}
    // rust: Some((height, f.fluid_level == 8 && !f.fluid_falling))
}
    /// `getWaterLevelAbove`: the top of the water column the hull is in.
pub fn water_level_above(self: *Self, b: *Boat) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let bb = b.bounds();
    // rust: let (lo, hi) = (bb.min_position(), bb.max_position());
    // rust: let (y0, y1) = (hi.y.floor() as i32, hi.y.ceil() as i32);
    // rust: 'rows: for y in y0..y1 {
    // rust: let mut height = 0.0f32;
    // rust: for x in lo.x.floor() as i32..hi.x.ceil() as i32 {
    // rust: for z in lo.z.floor() as i32..hi.z.ceil() as i32 {
    // rust: if let Some((h, _)) = self.fluid_height(x, y, z) {
    // rust: height = height.max(h);
}
    // rust: if height >= 1.0 {
    // rust: continue 'rows;
}
}
}
    // rust: if height < 1.0 {
    // rust: return f64::from(y) + f64::from(height);
}
}
    // rust: f64::from(y1 + 1)
}
pub fn boat_status(self: *Self, b: *mut Boat) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let bb = b.bounds();
    // rust: let (lo, hi) = (bb.min_position(), bb.max_position());
        // isUnderwater
    // rust: let max_y = hi.y + 0.001;
    // rust: let mut under = false;
    // rust: for x in lo.x.floor() as i32..hi.x.ceil() as i32 {
    // rust: for y in hi.y.floor() as i32..max_y.ceil() as i32 {
    // rust: for z in lo.z.floor() as i32..hi.z.ceil() as i32 {
    // rust: if let Some((h, source)) = self.fluid_height(x, y, z)
    // rust: && max_y < f64::from(y) + f64::from(h)
    // rust: {
    // rust: if !source {
    // rust: b.water_level = hi.y;
    // rust: return Status::UnderFlowingWater;
}
    // rust: under = true;
}
}
}
}
    // rust: if under {
    // rust: b.water_level = hi.y;
    // rust: return Status::UnderWater;
}
        // checkInWater
    // rust: let mut in_water = false;
    // rust: b.water_level = -f64::MAX;
    // rust: for x in lo.x.floor() as i32..hi.x.ceil() as i32 {
    // rust: for y in lo.y.floor() as i32..(lo.y + 0.001).ceil() as i32 {
    // rust: for z in lo.z.floor() as i32..hi.z.ceil() as i32 {
    // rust: if let Some((h, _)) = self.fluid_height(x, y, z) {
    // rust: let level = f64::from(y) + f64::from(h);
    // rust: b.water_level = b.water_level.max(level);
    // rust: in_water |= lo.y < level;
}
}
}
}
    // rust: if in_water {
    // rust: return Status::InWater;
}
    // rust: let friction = self.boat_ground_friction(bb);
    // rust: if friction > 0.0 {
    // rust: b.land_friction = friction;
    // rust: Status::OnLand
    // rust: } else {
    // rust: Status::InAir
}
}
    /// `AbstractBoat.getGroundFriction`: average friction of the blocks whose
    /// collision shape meets a thin slab just under the hull (lily pads skipped).
pub fn boat_ground_friction(self: *Self, bb: Aabb) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (lo, hi) = (bb.min_position(), bb.max_position());
    // rust: let ground = Aabb::new(
    // rust: Vec3::new(lo.x, lo.y - 0.001, lo.z),
    // rust: Vec3::new(hi.x, lo.y, hi.z),
    // rust: );
    // rust: let (g_lo, g_hi) = (ground.min_position(), ground.max_position());
    // rust: let (x0, x1, y0, y1, z0, z1) = (
    // rust: g_lo.x.floor() as i32 - 1,
    // rust: g_hi.x.ceil() as i32 + 1,
    // rust: g_lo.y.floor() as i32 - 1,
    // rust: g_hi.y.ceil() as i32 + 1,
    // rust: g_lo.z.floor() as i32 - 1,
    // rust: g_hi.z.ceil() as i32 + 1,
    // rust: );
    // rust: let slab = VoxelShape::from_box(ground).unwrap_or_else(|_| VoxelShape::empty());
    // rust: let mut scene = SceneCollisions {
    // rust: world: &self.world,
    // rust: binding: self.collision,
    // rust: subject: None,
}
    // rust: let (mut friction, mut count) = (0.0f32, 0);
    // rust: for x in x0..x1 {
    // rust: for z in z0..z1 {
    // rust: let edges = i32::from(x == x0 || x == x1 - 1) + i32::from(z == z0 || z == z1 - 1);
    // rust: if edges == 2 {
    // rust: continue;
}
    // rust: for y in y0..y1 {
    // rust: if edges == 1 && (y == y0 || y == y1 - 1) {
    // rust: continue;
}
    // rust: let state = self.world.block(x, y, z);
    // rust: let f = self.res.facts().get(state);
    // rust: if f.name.as_ref() == "minecraft:air" || f.has_class("LilyPadBlock") {
    // rust: continue;
}
    // rust: let Ok(shape) = self.collision.collision_shape_with_context(
    // rust: &mut scene,
    // rust: state,
    // rust: BlockPos::new(x, y, z),
    // rust: &CollisionContext::empty(false),
    // rust: ) else {
    // rust: continue;
}
    // rust: let world_shape =
    // rust: shape.moved(Vec3::new(f64::from(x), f64::from(y), f64::from(z)));
    // rust: if world_shape
    // rust: .join_is_not_empty(&slab, ShapeOp::AND)
    // rust: .unwrap_or(false)
    // rust: {
    // rust: friction += f.friction;
    // rust: count += 1;
}
}
}
}
    // rust: if count > 0 {
    // rust: friction / count as f32
    // rust: } else {
    // rust: 0.0
}
}
    /// `AbstractBoat.tick` for one boat (`controlled` when the player rides it).
    // rust: pub(super) fn tick_boat(&mut self, mut b: Boat, controlled: bool) -> Boat {
    // rust: b.previous = b.position;
    // rust: b.previous_yaw = b.yaw;
        // Entity.baseTick ends with Leashable.tickLeash, on a server only
        // (a ridden boat's lead ticks in `tick_boats`).
    // rust: if !controlled && self.remote.is_none() {
    // rust: self.tick_boat_leash(&mut b);
}
    // rust: let had_status = std::mem::replace(&mut b.status_known, true);
    // rust: b.old_status = b.status;
    // rust: b.status = self.boat_status(&mut b);
    // rust: b.tick_submersion();
    // rust: b.hurt_time = (b.hurt_time - 1).max(0);
    // rust: b.damage = (b.damage - 1.0).max(0.0);
        // A remote client gets the controller from the passenger packet, even when
        // this window occupies the second seat. Local worlds derive it here.
    // rust: if self.remote.is_none() {
    // rust: b.paddle_controller = controlled;
}
    // rust: if !controlled {
    // rust: b.paddling = [false; 2];
    // rust: b.input = [false; 4];
}
        // `Entity.baseTick`: the boat is immersed and pushed by the current it
        // sits in (`isPushedByFluid`), before `floatBoat` scales the velocity.
    // rust: let _ = b.push_by_fluid(&self.world, &self.res.motion().fluids);
        // floatBoat
        // `-getGravity()`: none with NoGravity.
    // rust: let mut vspeed = 0.0 - b.get_gravity();
    // rust: let mut buoyancy = 0.0;
    // rust: let inv_friction: f32;
    // rust: let obstacles = self.boat_move_obstacles(&b);
    // rust: let mut scene = SceneCollisions {
    // rust: world: &self.world,
    // rust: binding: self.collision,
    // rust: subject: None,
}
    // rust: if had_status
    // rust: && b.old_status == Status::InAir
    // rust: && b.status != Status::InAir
    // rust: && b.status != Status::OnLand
    // rust: {
    // rust: b.water_level = b.position.y;
    // rust: let target = self.water_level_above(&b) - HEIGHT + 0.101;
    // rust: let moved = Aabb::new(
    // rust: Vec3::new(
    // rust: b.bounds().min_position().x,
    // rust: target,
    // rust: b.bounds().min_position().z,
    // rust: ),
    // rust: Vec3::new(
    // rust: b.bounds().max_position().x,
    // rust: target + HEIGHT,
    // rust: b.bounds().max_position().z,
    // rust: ),
    // rust: );
    // rust: if scene.unobstructed(moved).unwrap_or(false) {
    // rust: b.position.y = target;
    // rust: b.velocity.y = 0.0;
}
    // rust: b.status = Status::InWater;
    // rust: } else {
    // rust: match b.status {
    // rust: Status::InWater => {
    // rust: buoyancy = (b.water_level - b.position.y) / HEIGHT;
    // rust: inv_friction = 0.9;
}
    // rust: Status::UnderFlowingWater => {
    // rust: vspeed = -7.0e-4;
    // rust: inv_friction = 0.9;
}
    // rust: Status::UnderWater => {
    // rust: buoyancy = 0.01;
    // rust: inv_friction = 0.45;
}
    // rust: Status::InAir => inv_friction = 0.9,
    // rust: Status::OnLand => {
    // rust: inv_friction = b.land_friction;
    // rust: if controlled {
    // rust: b.land_friction /= 2.0;
}
}
}
    // rust: let f = f64::from(inv_friction);
    // rust: b.velocity = Vec3::new(b.velocity.x * f, b.velocity.y + vspeed, b.velocity.z * f);
    // rust: b.delta_rotation *= inv_friction;
    // rust: if buoyancy > 0.0 {
    // rust: b.velocity.y = (b.velocity.y + buoyancy * (0.04 / 0.65)) * 0.75;
}
}
        // controlBoat
    // rust: if controlled {
    // rust: let [left, right, up, down] = b.input;
    // rust: let mut acceleration = 0.0f32;
    // rust: if left {
    // rust: b.delta_rotation -= 1.0;
}
    // rust: if right {
    // rust: b.delta_rotation += 1.0;
}
    // rust: if right != left && !up && !down {
    // rust: acceleration += 0.005;
}
    // rust: b.yaw += b.delta_rotation;
    // rust: if up {
    // rust: acceleration += 0.04;
}
    // rust: if down {
    // rust: acceleration -= 0.005;
}
    // rust: let r = b.yaw.to_radians();
    // rust: b.velocity.x += f64::from((-r).sin() * acceleration);
    // rust: b.velocity.z += f64::from(r.cos() * acceleration);
    // rust: b.paddling = [right && !left || up, left && !right || up];
}
        // Entity.move: collisions zero the blocked components, the world border's
        // among them (`CollisionGetter.borderCollision`).
    // rust: let mut scene = EntityCollisions {
    // rust: blocks: scene,
    // rust: entities: &obstacles,
    // rust: border: Some((self.border.geometry(), [b.position.x, b.position.z])),
}
    // rust: let movement = b.take_movement();
    // rust: if let Ok(moved) = scene.resolve(b.bounds(), movement, 0.0, b.on_ground) {
    // rust: b.position = Vec3::new(
    // rust: b.position.x + moved.x,
    // rust: b.position.y + moved.y,
    // rust: b.position.z + moved.z,
    // rust: );
    // rust: b.on_ground = movement.y < 0.0 && moved.y > movement.y;
    // rust: if (moved.x - movement.x).abs() > 1.0e-7 {
    // rust: b.velocity.x = 0.0;
}
    // rust: if (moved.z - movement.z).abs() > 1.0e-7 {
    // rust: b.velocity.z = 0.0;
}
    // rust: if (moved.y - movement.y).abs() > 1.0e-7 {
    // rust: b.velocity.y = 0.0;
}
}
        // AbstractBoat.tick's applyEffectsFromBlocks: powder snow makes the boat stuck,
        // which slows its next move (`PowderSnowBlock.entityInside`).
    // rust: if !self.boat_powder_snow_cells(&b).is_empty() {
    // rust: b.stuck = powder_snow_stuck();
}
        // Entity.move's last step: soul sand and honey slow the boat too.
    // rust: let factor = crate::motion::block_speed_factor_at(
    // rust: &self.world,
    // rust: &self.motion.blocks,
    // rust: b.position,
    // rust: None,
    // rust: );
    // rust: b.velocity = horizon_world::entity_move::scale_by_block_speed(b.velocity, factor);
    // rust: Self::tick_boat_paddles(&mut b, &mut self.audio, &mut self.world.random);
    // rust: b
}
    /// `AbstractBoat.tick` advances the oars even when this client does not move the hull.
    // rust: pub(super) fn tick_boat_paddles(
    // rust: b: &mut Boat,
    // rust: audio: &mut super::Audio,
    // rust: random: &mut horizon_core::random::LegacyRandom,
    // rust: ) {
        // Paddle sounds at the top of each stroke.
    // rust: for i in 0..2 {
    // rust: if b.paddle_state(i) {
    // rust: let p = b.paddles[i] % (2.0 * PI);
    // rust: if p <= PI / 4.0 && (b.paddles[i] + PI / 8.0) % (2.0 * PI) >= PI / 4.0 {
    // rust: let sound = match b.status {
    // rust: Status::InWater | Status::UnderWater | Status::UnderFlowingWater => {
    // rust: Some("minecraft:entity.boat.paddle_water")
}
    // rust: Status::OnLand => Some("minecraft:entity.boat.paddle_land"),
    // rust: Status::InAir => None,
}
    // rust: if let Some(sound) = sound {
    // rust: let v = view_vector(b.yaw, 0.0);
    // rust: let (dx, dz) = if i == 1 { (-v[2], v[0]) } else { (v[2], -v[0]) };
    // rust: let pitch = 0.8 + 0.4 * random.next_float();
    // rust: audio.play(
    // rust: sound,
    // rust: Some([b.position.x + dx, b.position.y, b.position.z + dz]),
    // rust: 1.0,
    // rust: pitch,
    // rust: );
}
}
    // rust: b.paddles[i] += PI / 8.0;
    // rust: } else {
    // rust: b.paddles[i] = 0.0;
}
}
}
    /// Every boat but the ridden one (which ticks with its rider).
    // rust: pub(super) fn tick_boats(&mut self) {
    // rust: self.vehicles_ticking(true);
    // rust: self.tick_boats_now();
    // rust: self.vehicles_ticking(false);
}
pub fn tick_boats_now(self: *Self) void {
}
        // ServerLevel.tick: only entities in entity-ticking chunks tick.
    // rust: let ticking = self.entity_ticking_area();
    // rust: let mut round = self.native_tick_round();
        // A server player's boat is driven by its client (lan_vehicles.rs).
    // rust: let driven = self.guest_vehicles();
        // EntityTickEvent.Post comes once AbstractBoat.tick is over, after the
        // passes of `boat_server_passes` (lava, ejection, bubbles, contacts),
        // and before the next boat ticks, as `ServerLevel.tickNonPassenger`.
        // A pass (lava breaks a boat) or a mod's hook may remove boats: the next one is found
        // after this one by its id, so none is skipped or ticked twice.
    // rust: let mut i = 0;
    // rust: while i < self.boats.len() {
    // rust: let id = self.boats[i].id;
    // rust: 'boat: {
    // rust: let p = self.boats[i].position;
    // rust: if Some(id) == self.riding
    // rust: || driven.contains(&id)
    // rust: || !ticking(p.x.floor() as i32, p.z.floor() as i32)
    // rust: {
                    // Its rider's client moves it, but the lead still ticks.
    // rust: if ticking(p.x.floor() as i32, p.z.floor() as i32) && self.remote.is_none() {
    // rust: let mut b = self.boats[i].clone();
    // rust: self.tick_boat_leash(&mut b);
    // rust: self.boats[i] = b;
}
    // rust: self.boat_server_passes(id, &driven, &ticking, &round);
    // rust: break 'boat;
}
    // rust: let kind = if round.listening() {
    // rust: self.boats[i].entity_type()
    // rust: } else {
    // rust: String::new()
}
    // rust: if !self.native_tick_pre_one(&mut round, id, &kind) {
    // rust: self.boat_server_passes(id, &driven, &ticking, &round);
    // rust: break 'boat;
}
                // The hook may have removed boats.
    // rust: let Some(i) = Some(i)
    // rust: .filter(|&i| self.boats.get(i).is_some_and(|b| b.id == id))
    // rust: .or_else(|| self.boats.iter().position(|b| b.id == id))
    // rust: else {
    // rust: break 'boat;
}
    // rust: let b = self.boats[i].clone();
    // rust: self.boats[i] = self.tick_boat(b, false);
    // rust: self.boat_server_passes(id, &driven, &ticking, &round);
    // rust: self.native_tick_post_one(&round, id, &kind);
}
    // rust: i = match self.boats.get(i) {
    // rust: Some(b) if b.id == id => i + 1,
    // rust: _ => self
    // rust: .boats
    // rust: .iter()
    // rust: .position(|b| b.id == id)
    // rust: .map_or(i, |k| k + 1),
}
}
}
    /// The rest of `AbstractBoat.tick` on the server, for every boat, the
    /// client-driven ones too: `applyEffectsFromBlocks` (lava breaks a boat
    /// at once), the passengers of one under water too long get out, and it
    /// picks up or pushes what it touches.
    // rust: fn boat_server_passes(
    // rust: &mut self,
    // rust: id: u32,
    // rust: driven: &[u32],
    // rust: ticking: &impl Fn(i32, i32) -> bool,
    // rust: round: &super::native_ticks::TickRound,
    // rust: ) {
    // rust: let Some(i) = self.boats.iter().position(|b| b.id == id) else {
    // rust: return;
}
    // rust: let p = self.boats[i].position;
    // rust: if !ticking(p.x.floor() as i32, p.z.floor() as i32) || round.canceled(id) {
    // rust: return;
}
    // rust: if Some(id) != self.riding && self.boat_lava_tick(i) {
    // rust: return;
}
    // rust: if self.remote.is_none() {
    // rust: self.boat_powder_snow_snowflakes(i);
}
        // `AbstractBoat.tick` counts submersion on the server even when
        // its controlling client owns the boat's movement.
    // rust: if driven.contains(&id) {
    // rust: self.refresh_boat_status(i);
}
    // rust: if self.boats[i].out_of_control >= 60.0 {
    // rust: self.eject_boat_riders(i);
}
    // rust: self.boat_bubble_tick(i);
    // rust: self.boat_contacts(i);
}
    /// `Entity.canSimulateMovement`: for a boat (`AUTHORITATIVE_SIDE`) a
    /// server leaves the boat its player drives to that player's client, and a
    /// client moves only the boat its player drives.
pub fn boat_can_simulate_movement(self: *Self, id: u32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.remote.is_some() {
    // rust: self.riding == Some(id)
    // rust: } else {
    // rust: !self.guest_vehicles().contains(&id)
}
}
    /// `AbstractBoat.tick`: `status = getStatus()` for a boat this window
    /// does not tick (`tick_boat` sets it for the others): a client's boats
    /// other than the one it drives, and a server's boats its players drive.
    // rust: pub(super) fn refresh_boat_status(&mut self, i: usize) {
    // rust: let b = &self.boats[i];
    // rust: let mut probe = Boat::new(b.id, b.wood.clone(), b.position, b.yaw);
    // rust: let status = self.boat_status(&mut probe);
    // rust: self.boats[i].status = status;
        // `oldStatus = status` runs on every boat, so the next tick has one.
    // rust: self.boats[i].status_known = true;
    // rust: self.boats[i].tick_submersion();
}
    /// `BubbleColumnBlock.entityInside`: the bubble columns boat `i` touches
    /// (its box deflated by 1e-5 as `Entity.checkInsideBlocks` does), in x, y,
    /// z order.
    // rust: pub(super) fn boat_bubble_columns(&self, i: usize) -> Vec<BubbleColumn> {
    // rust: let b = self.boats[i].bounds().deflate(Vec3::new(
    // rust: f64::from(1.0e-5f32),
    // rust: f64::from(1.0e-5f32),
    // rust: f64::from(1.0e-5f32),
    // rust: ));
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: let mut columns = Vec::new();
    // rust: for x in lo.x.floor() as i32..=(hi.x.ceil() as i32 - 1) {
    // rust: for y in lo.y.floor() as i32..=(hi.y.ceil() as i32 - 1) {
    // rust: for z in lo.z.floor() as i32..=(hi.z.ceil() as i32 - 1) {
    // rust: if let Some(column) = bubble_column_at(
    // rust: &self.world,
    // rust: self.pack.assets.registry,
    // rust: self.res.facts(),
    // rust: self.collision,
    // rust: BlockPos::new(x, y, z),
    // rust: ) {
    // rust: columns.push(column);
}
}
}
}
    // rust: columns
}
    /// `Entity.handleOnInsideBubbleColumn`: a column under more water lifts
    /// boat `i` up to 0.7 or drags it down to -0.3 (`AbstractBoat` does not
    /// override `onInsideBubbleColumn`), applied by the column's own push below
    /// the surface.
    // rust: pub(super) fn boat_inside_bubble_column(&mut self, i: usize, column: BubbleColumn) {
    // rust: if !self.boat_can_simulate_movement(self.boats[i].id) {
    // rust: return;
}
    // rust: column.push(&mut self.boats[i].velocity);
}
    /// `AbstractBoat.onAboveBubbleColumn`: whether the splash comes up, one
    /// time in a hundred for a boat that is not under water.
    // rust: pub(super) fn boat_splash_roll(&mut self, i: usize) -> bool {
    // rust: !self.boats[i].under_water() && self.world.random.next_int_bound(100).unwrap_or(1) == 0
}
    /// `AbstractBoat.onAboveBubbleColumn`: the client's half after the roll,
    /// the splash sound and particle at the boat.
    // rust: pub(super) fn boat_bubble_splash(&mut self, i: usize) {
//         use horizon_client::particles::{ParticleOptions, ParticleType};
    // rust: let p = self.boats[i].position;
    // rust: let pitch = 0.8 + 0.4 * self.world.random.next_float();
    // rust: self.audio.play(
    // rust: "minecraft:entity.generic.splash",
    // rust: Some([p.x, p.y, p.z]),
    // rust: 1.0,
    // rust: pitch,
    // rust: );
    // rust: let x = p.x + f64::from(self.world.random.next_float());
    // rust: let z = p.z + f64::from(self.world.random.next_float());
    // rust: self.particles.add(
    // rust: &ParticleOptions::simple(ParticleType::Splash),
    // rust: [x, p.y + 0.7, z],
    // rust: [0.0; 3],
    // rust: );
}
    /// `AbstractBoat.onAboveBubbleColumn`: on the server (this window
    /// simulates the boat) the column is remembered, the countdown starts and
    /// the splash's game event goes to the listeners (its sound and particle
    /// are the client's).
pub fn boat_above_bubble_column(self: *Self, i: usize, drag_down: bool) void {
}
    // rust: let b = &mut self.boats[i];
    // rust: b.above_bubble_column = true;
    // rust: b.bubble_down = drag_down;
    // rust: if b.bubble_time == 0 {
    // rust: b.bubble_time = BUBBLE_TIME;
}
    // rust: if !self.boat_splash_roll(i) {
    // rust: return;
}
        // A window that is its own client hears and sees the splash too.
    // rust: if self.options.execution_role.is_client() {
    // rust: self.boat_bubble_splash(i);
}
    // rust: let (id, p) = (self.boats[i].id, self.boats[i].position);
        // Entity.gameEvent(SPLASH, getControllingPassenger()): the window's
        // own player when it drives the boat.
    // rust: let ctx = if self.riding == Some(id) && self.player.is_some() {
    // rust: self.player_context(None)
    // rust: } else {
    // rust: self.who_context(None, None)
}
    // rust: self.post_game_event("minecraft:splash", [p.x, p.y, p.z], ctx);
}
    /// `AbstractBoat.handleBubbleColumnEffect`: an up column throws the boat
    /// up at 0.6, a down column pulls it down by 0.7.
    // rust: pub(super) fn handle_bubble_column_effect(&mut self, i: usize, drag_down: bool) {
    // rust: if !self.boat_can_simulate_movement(self.boats[i].id) {
    // rust: return;
}
    // rust: let v = &mut self.boats[i].velocity;
    // rust: if drag_down {
            // movement.add(0.0, -0.7, 0.0)
    // rust: v.y += -0.7;
    // rust: } else {
    // rust: v.y = 0.6;
}
}
    /// `Entity.ejectPassengers`: the mobs get out here, this window's player
    /// gets out, and a server's player is asked to
    /// (`guest_vehicle_tick` lets it out through its client).
pub fn eject_boat_riders(self: *Self, i: usize) void {
}
    // rust: self.eject_boat_mobs(i, false);
    // rust: let id = self.boats[i].id;
    // rust: if self.riding == Some(id) && self.player.is_some() {
    // rust: self.dismount(i);
    // rust: } else if self.guest_rides(id) {
    // rust: self.boats[i].eject_riders = true;
}
}
    /// `AbstractBoat.tickBubbleColumn`: on the server, a boat that stays over
    /// a column for `BUBBLE_TIME` ticks is thrown up or pulled down (a down
    /// column lets the riders out first), and every client is told.
pub fn tick_boat_bubble_column(self: *Self, i: usize) void {
}
    // rust: if let Some(down) = self.boats[i].tick_bubble_countdown() {
    // rust: let (id, p) = (self.boats[i].id, self.boats[i].position);
    // rust: let event = if down {
    // rust: BUBBLE_DOWN_EVENT
    // rust: } else {
    // rust: BUBBLE_UP_EVENT
}
    // rust: if down {
    // rust: self.eject_boat_riders(i);
}
    // rust: self.lan_entity_event(id as i32, event, [p.x, p.y, p.z]);
    // rust: self.handle_bubble_column_effect(i, down);
}
}
    /// `AbstractBoat.tick`: the end of it on the server for boat `i`, the two
    /// `applyEffectsFromBlocks` that reach bubble columns (the lava is
    /// `boat_lava_tick`'s), then `tickBubbleColumn`; and the wobble when this
    /// window is its own client.
pub fn boat_bubble_tick(self: *Self, i: usize) void {
}
    // rust: let id = self.boats[i].id;
        // An ejection nobody took (its player left the boat first) is void.
    // rust: if !self.guest_rides(id) {
    // rust: self.boats[i].eject_riders = false;
}
    // rust: let touches = self.boat_bubble_columns(i);
        // AbstractBoat.tick calls applyEffectsFromBlocks twice.
    // rust: for _ in 0..2 {
    // rust: for &column in &touches {
    // rust: if column.surface {
    // rust: self.boat_above_bubble_column(i, column.drag);
    // rust: } else {
    // rust: self.boat_inside_bubble_column(i, column);
}
}
}
    // rust: self.tick_boat_bubble_column(i);
    // rust: if self.options.execution_role.is_client() {
    // rust: self.boats[i].tick_bubble_wobble();
}
}
    /// `PowderSnowBlock.entityInside` for a boat: the powder snow cells its box, and the box it
    /// had before its move, reach into (`Entity.checkInsideBlocks` along the move).
pub fn boat_powder_snow_cells(self: *Self, b: *Boat) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut cells = powder_snow_cells(b.bounds(), |p| self.is_powder_snow(p));
    // rust: if b.previous != b.position {
    // rust: for p in powder_snow_cells(Boat::bounds_at(b.previous), |p| self.is_powder_snow(p)) {
    // rust: if !cells.contains(&p) {
    // rust: cells.push(p);
}
}
}
    // rust: cells
}
    /// `PowderSnowBlock.entityInside`'s `ServerLevel.sendParticles`: a boat that moved
    /// horizontally in powder snow throws snowflakes the players around see. `AbstractBoat.tick`
    /// calls `applyEffectsFromBlocks` twice.
pub fn boat_powder_snow_snowflakes(self: *Self, i: usize) void {
}
    // rust: let b = &self.boats[i];
    // rust: let cells = self.boat_powder_snow_cells(b);
    // rust: if cells.is_empty() {
    // rust: return;
}
    // rust: let known = b.position.subtract(b.previous);
    // rust: let (x, z) = (b.position.x, b.position.z);
    // rust: for _ in 0..2 {
    // rust: for cell in &cells {
    // rust: if let Some(velocity) = snowflake_velocity(known, &mut self.world.random) {
    // rust: self.lan_snowflake([x, f64::from(cell[1] + 1), z], velocity);
}
}
}
}
    /// `LavaFluid.entityInside` (`lavaHurt`) from the two
    /// `applyEffectsFromBlocks` calls in `AbstractBoat.tick`: twice 40
    /// damage, so lava breaks a boat on its first tick inside, and the fire
    /// `lavaIgnite` lights never gets to burn it. True when the boat broke.
pub fn boat_lava_tick(self: *Self, i: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.in_lava(self.boats[i].bounds()) {
    // rust: return false;
}
    // rust: for _ in 0..2 {
    // rust: let p = self.boats[i].position;
    // rust: let broke = self.hurt_boat(i, 4.0, false);
    // rust: self.lava_hurt_sound([p.x, p.y, p.z]);
    // rust: if broke {
    // rust: return true;
}
}
    // rust: false
}
    /// `Entity.lavaHurt`'s sound once the hurt went through.
    // rust: pub(super) fn lava_hurt_sound(&mut self, at: [f64; 3]) {
    // rust: let pitch = 2.0 + self.world.random.next_float() * 0.4;
    // rust: self.audio
    // rust: .play("minecraft:entity.generic.burn", Some(at), 0.4, pitch);
}
    /// Whether a vehicle's box, deflated by 1e-5, reaches into lava below its
    /// surface (`Entity.collidedWithFluid`).
    // rust: pub(super) fn in_lava(&self, bb: Aabb) -> bool {
    // rust: let (lo, hi) = (bb.min_position(), bb.max_position());
    // rust: let e = 1.0e-5;
    // rust: for x in (lo.x + e).floor() as i32..=(hi.x - e).floor() as i32 {
    // rust: for y in (lo.y + e).floor() as i32..=(hi.y - e).floor() as i32 {
    // rust: for z in (lo.z + e).floor() as i32..=(hi.z - e).floor() as i32 {
    // rust: if let Some((height, _)) = self.fluid_height_of(x, y, z, Some(Fluid::Lava))
    // rust: && lo.y + e < f64::from(y) + f64::from(height)
    // rust: {
    // rust: return true;
}
}
}
}
    // rust: false
}
    /// `AbstractBoat.modifyPassengerFluidInteractionBox`: the ridden boat's box
    /// and whether it is underwater, for `Entity.getFluidInteractionBox`. A boat
    /// keeps only the part of the passenger's box above its own top, so a boat
    /// bobbing on water never sinks the passenger's eyes or body.
    // rust: pub(super) fn riding_boat_fluid_box(&self) -> Option<RiddenBoat> {
    // rust: self.boats
    // rust: .iter()
    // rust: .find(|b| Some(b.id) == self.riding)
    // rust: .map(|b| RiddenBoat {
    // rust: under_water: b.under_water(),
    // rust: max_y: b.bounds().max_position().y,
    // rust: })
}
    /// `getDismountLocationForPassenger`: in front of the player if there is
    /// floor there, else on top of the boat.
    // rust: pub(super) fn dismount(&mut self, i: usize) {
    // rust: let id = self.boats[i].id;
    // rust: if self.riding == Some(id) && !self.native_may_leave(id) {
    // rust: return;
}
    // rust: self.riding = None;
        // `AbstractBoat.tick`'s non-authoritative branch: the copy of a boat
        // that no player of this side drives drops its cached motion
        // (`setDeltaMovement(Vec3.ZERO)`, `deltaRotation = 0`) and is not
        // moved, so a boat is at a standstill when its rider gets out instead
        // of coasting on the velocity of the ride that just ended.
    // rust: self.boats[i].velocity = Vec3::ZERO;
    // rust: self.boats[i].delta_rotation = 0.0;
    // rust: let target = self.boat_dismount_target(i, 0.6, self.yaw);
    // rust: if let Some(p) = self.player.as_mut() {
    // rust: p.position = target;
    // rust: p.velocity = Vec3::ZERO;
}
}
    /// `getDismountLocationForPassenger` for a passenger `width` wide
    /// facing `yaw`.
    // rust: pub(super) fn boat_dismount_target(&self, i: usize, width: f64, yaw: f32) -> Vec3 {
    // rust: let b = &self.boats[i];
    // rust: let r = yaw.to_radians();
    // rust: let distance = (WIDTH * std::f64::consts::SQRT_2 + width + 1.0e-5) / 2.0;
    // rust: let (s, c) = (-(r.sin()) as f64, r.cos() as f64);
    // rust: let m = s.abs().max(c.abs());
    // rust: let (x, z) = (
    // rust: b.position.x + s * distance / m,
    // rust: b.position.z + c * distance / m,
    // rust: );
    // rust: let top = b.bounds().max_position().y;
    // rust: let (bx, by, bz) = (x.floor() as i32, top.floor() as i32, z.floor() as i32);
    // rust: let below = self.res.facts().get(self.world.block(bx, by - 1, bz));
    // rust: let here = self.res.facts().get(self.world.block(bx, by, bz));
    // rust: if below.fluid != Fluid::Water
    // rust: && !here.full_collision
    // rust: && (below.full_collision || below.legacy_solid)
    // rust: {
    // rust: Vec3::new(x, f64::from(by), z)
    // rust: } else {
    // rust: Vec3::new(b.position.x, top, b.position.z)
}
}
    /// `BoatItem.use`: aim at a block or the water surface.
    // rust: pub(super) fn place_boat(&mut self, stack: &ItemStack) -> bool {
    // rust: let Some(boat) = self.boat_to_place(stack) else {
    // rust: return false;
}
    // rust: self.next_entity += 1;
    // rust: let key = (
    // rust: boat.position.x.floor() as i32 >> 4,
    // rust: boat.position.z.floor() as i32 >> 4,
    // rust: );
    // rust: self.world.modified.insert(key);
    // rust: self.boats.push(boat);
    // rust: if self.serving.is_some() || self.options.dedicated.is_some() {
    // rust: self.native_vehicle_create(
    // rust: self.boats.last().unwrap().entity_type().as_str(),
    // rust: [
    // rust: self.boats.last().unwrap().position.x,
    // rust: self.boats.last().unwrap().position.y,
    // rust: self.boats.last().unwrap().position.z,
    // rust: ],
    // rust: );
}
        // BoatItem.use: ENTITY_PLACE at the hit (the boat's position), by the player.
    // rust: let at = self
    // rust: .boats
    // rust: .last()
    // rust: .map(|b| [b.position.x, b.position.y, b.position.z]);
    // rust: if let Some(at) = at {
    // rust: let ctx = self.player_context(None);
    // rust: self.post_game_event("minecraft:entity_place", at, ctx);
}
    // rust: if !self.creative {
    // rust: self.consume_held();
}
    // rust: self.award_stat("used", &stack.item, 1);
    // rust: self.swing_arm();
    // rust: true
}
    /// The boat `BoatItem.use` would place for `stack` (its SUCCESS), or
    /// None when it aims at nothing (PASS) or the spot is taken (FAIL).
    // rust: pub(super) fn boat_to_place(&self, stack: &ItemStack) -> Option<Boat> {
    // rust: let (wood, chest) = any_boat_wood(&stack.item)?;
    // rust: if !self.boat_models.has(wood, chest) {
    // rust: return None;
}
    // rust: let hit = self.boat_item_hit()?;
    // rust: let mut boat = Boat::new(
    // rust: self.next_entity + 1,
    // rust: Arc::from(wood),
    // rust: Vec3::new(hit[0], hit[1], hit[2]),
    // rust: self.yaw,
    // rust: );
    // rust: if chest {
    // rust: boat = boat.with_chest();
}
    // rust: let bb = boat.bounds();
    // rust: let (lo, hi) = (bb.min_position(), bb.max_position());
    // rust: let e = 1.0e-7;
    // rust: let inner = Aabb::new(
    // rust: Vec3::new(lo.x + e, lo.y + e, lo.z + e),
    // rust: Vec3::new(hi.x - e, hi.y - e, hi.z - e),
    // rust: );
    // rust: let mut scene = SceneCollisions {
    // rust: world: &self.world,
    // rust: binding: self.collision,
    // rust: subject: None,
}
    // rust: if !scene.unobstructed(inner).unwrap_or(false) || self.boat_entity_collision(bb) {
    // rust: return None;
}
    // rust: Some(boat)
}
    // rust: pub(super) fn boat_hit(&self) -> Option<(usize, f64)> {
    // rust: let (eye, dir) = self.aim()?;
    // rust: let reach: f64 = self.entity_reach;
    // rust: let mut best: Option<(usize, f64)> = None;
    // rust: for (i, b) in self.boats.iter().enumerate() {
    // rust: if Some(b.id) == self.riding {
    // rust: continue;
}
    // rust: let bb = b.bounds();
    // rust: let (lo, hi) = (bb.min_position(), bb.max_position());
    // rust: let (lo, hi) = ([lo.x, lo.y, lo.z], [hi.x, hi.y, hi.z]);
    // rust: let (mut t0, mut t1) = (0.0f64, reach);
    // rust: let mut hit = true;
    // rust: for a in 0..3 {
    // rust: if dir[a].abs() < 1e-9 {
    // rust: hit &= eye[a] >= lo[a] && eye[a] <= hi[a];
    // rust: continue;
}
    // rust: let (mut ta, mut tb) = ((lo[a] - eye[a]) / dir[a], (hi[a] - eye[a]) / dir[a]);
    // rust: if ta > tb {
    // rust: std::mem::swap(&mut ta, &mut tb);
}
    // rust: t0 = t0.max(ta);
    // rust: t1 = t1.min(tb);
}
    // rust: if hit && t0 <= t1 && best.is_none_or(|b| t0 < b.1) {
    // rust: best = Some((i, t0));
}
}
    // rust: best
}
    /// `AbstractBoat.interact`: board the boat under the crosshair, or the one
    /// a guest's interact packet named.
    // rust: pub(super) fn interact_boat(&mut self, target: Option<InteractTarget>) -> bool {
    // rust: let Some((i, d)) = (match target {
    // rust: Some(t) => Self::named_entity(&self.boats, t.id, |b| b.id).map(|i| (i, 0.0)),
    // rust: None => self.boat_hit(),
    // rust: }) else {
    // rust: return false;
}
    // rust: let sneaking = self.keys.held(Action::Sneak);
        // Only a client's own pick is stopped by a block: the range check passed.
    // rust: if target.is_none() && !self.before_block(d) {
    // rust: return false;
}
        // AbstractBoat.interact starts with Entity.interact: the lead.
    // rust: if self.interact_boat_leash(i) {
    // rust: self.swing_arm();
    // rust: return true;
}
        // ChestBoat.interact: sneaking (or a full seat) opens the chest.
    // rust: if self.boats[i].chest && (sneaking || self.riding.is_some() || !self.boat_has_room(i)) {
    // rust: self.open_chest_boat_container(i);
    // rust: self.swing_arm();
    // rust: return true;
}
    // rust: if sneaking
    // rust: || self.boats[i].out_of_control >= 60.0
    // rust: || self.riding.is_some()
    // rust: || !self.may_board()
    // rust: || self.ridden_by_guest(self.boats[i].id)
    // rust: || !self.boat_has_room(i)
    // rust: {
    // rust: return false;
}
    // rust: if !self.native_may_board(self.boats[i].id) {
    // rust: return true;
}
    // rust: let id = self.boats[i].id;
    // rust: self.yaw = self.boats[i].yaw;
        // Entity.startRiding (ServerPlayer.startRiding fires the trigger).
    // rust: self.start_riding(id);
    // rust: true
}
    /// `ContainerEntity.interactWithContainerVehicle` (`AbstractChestBoat`):
    /// the chest's 27 slots go under a placeholder key that the menu edits; a
    /// server hands them to the player as a `ChestMenu` (`as_guest` ->
    /// `lan_open_container`). `AbstractChestBoat.interact` fires
    /// `CONTAINER_OPEN` and angers the piglins that see it.
    // rust: pub(super) fn open_chest_boat_container(&mut self, i: usize) {
    // rust: let b = &self.boats[i];
    // rust: let key = (i32::MAX - 15, super::minecarts::CART_KEY_Y, b.id as i32);
    // rust: let at = [b.position.x, b.position.y, b.position.z];
    // rust: let items = b.items.clone();
    // rust: self.world
    // rust: .block_entities
    // rust: .insert(key, horizon_client::containers::BlockEntity::Chest(items));
    // rust: self.container = Some(key);
    // rust: self.screen = super::Screen::Inventory;
    // rust: self.capture(false);
    // rust: self.right = false;
    // rust: let ctx = self.player_context(None);
    // rust: self.post_game_event("minecraft:container_open", at, ctx);
    // rust: self.anger_piglins(true);
}
    /// `AbstractChestBoat.openCustomInventoryScreen` (`HasCustomInventoryScreen`),
    /// the inventory key while riding a chest boat: its chest opens, not the
    /// player's inventory.
    // rust: pub(super) fn open_ridden_chest_boat(&mut self) -> bool {
    // rust: let Some(id) = self.riding else {
    // rust: return false;
}
    // rust: let Some(i) = self.boats.iter().position(|b| b.id == id) else {
    // rust: return false;
}
    // rust: if !self.boats[i].chest {
    // rust: return false;
}
    // rust: self.open_chest_boat_container(i);
    // rust: true
}
    /// Whether the player rides a chest boat: `HasCustomInventoryScreen`, so
    /// the inventory key sends `ServerboundPlayerCommandPacket.Action.OPEN_INVENTORY`
    /// (`ServerGamePacketListenerImpl.handlePlayerCommand` opens its screen).
    // rust: pub(super) fn riding_chest_boat(&self) -> bool {
    // rust: self.riding
    // rust: .and_then(|id| self.boats.iter().find(|b| b.id == id))
    // rust: .is_some_and(|b| b.chest)
}
    /// `VehicleEntity.hurtServer` from the player's attack.
    // rust: pub(super) fn attack_boat(&mut self) -> bool {
    // rust: let Some((i, d)) = self.boat_hit() else {
    // rust: return false;
}
    // rust: if !self.before_block(d) || self.mob_hit().is_some_and(|m| m.1 < d) {
    // rust: return false;
}
    // rust: self.strike_boat(i);
    // rust: self.swing_arm();
    // rust: true
}
    /// The accepted boat target, shared by aimed attacks and headless parity.
    // rust: pub(super) fn strike_boat(&mut self, i: usize) {
    // rust: let area = self.boats[i].bounds();
        // Player.attack's full damage against the boat's entity type.
    // rust: let (kind, id) = (self.boats[i].entity_type(), self.boats[i].id as i32);
    // rust: let (damage, scale, _, magic) = self.melee_damage(&kind, false);
    // rust: let hurt = self.hurt_boat_result(i, damage, self.creative);
    // rust: self.vehicle_attack_sounds(area, magic.then_some(id));
    // rust: if damage > 0.0
    // rust: && let Some(destroyed) = hurt
    // rust: {
    // rust: let (knockback, _) = self.extra_knockback(&kind, scale);
    // rust: if knockback > 0.0 {
                // Player.causeExtraKnockback uses Entity.push for a boat,
                // not LivingEntity.knockback (no resistance or velocity halving).
    // rust: if !destroyed {
    // rust: let (x, z) = self.extra_knockback_direction();
    // rust: self.boats[i].velocity.x += f64::from(-(x as f32) * knockback);
    // rust: self.boats[i].velocity.y += 0.1;
    // rust: self.boats[i].velocity.z += f64::from(-(z as f32) * knockback);
}
    // rust: if let Some(player) = self.player.as_mut() {
    // rust: player.velocity.x *= horizon_client::attack_strength::ATTACKER_SLOWDOWN;
    // rust: player.velocity.z *= horizon_client::attack_strength::ATTACKER_SLOWDOWN;
}
    // rust: self.stop_sprint_after_extra_knockback();
}
}
        // Player.onAttack: the hit starts the attack strength again.
    // rust: self.attack_ticks = 0;
}
    /// `VehicleEntity.hurtServer`: wobble, add the damage and break past 40
    /// (`creative`: a creative player's hit discards it straight away).
    /// `AbstractChestBoat.remove` drops the chest contents for every removal
    /// reason that destroys the boat (DISCARDED included), while the boat item
    /// itself only drops on the death path (`VehicleEntity.destroy`), not when
    /// a creative hit discards it. True when the boat was removed.
    // rust: pub(super) fn hurt_boat(&mut self, i: usize, damage: f32, creative: bool) -> bool {
    // rust: self.hurt_boat_result(i, damage, creative).unwrap_or(false)
}
    /// None means a canceled hit; Some records whether an accepted hit destroyed it.
pub fn hurt_boat_result(self: *Self, i: usize, mut damage: f32, creative: bool) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut cancel = false;
    // rust: self.native_vehicle_damage("boat", &mut damage, &mut cancel);
    // rust: if cancel {
    // rust: return None;
}
    // rust: let b = &mut self.boats[i];
    // rust: b.hurt_dir = -b.hurt_dir;
    // rust: b.hurt_time = 10;
    // rust: b.damage += damage * 10.0;
    // rust: let destroyed = creative || b.damage > 40.0;
    // rust: if destroyed {
    // rust: let at = [b.position.x, b.position.y, b.position.z];
    // rust: self.native_vehicle_destroy("boat", at);
    // rust: self.eject_boat_mobs(i, true);
    // rust: let id = self.boats[i].id;
    // rust: self.release_vehicle_container(id);
    // rust: let b = self.boats.remove(i);
            // AbstractBoat.remove: a destroyed boat drops its lead.
    // rust: self.boat_removed(&b);
            // `AbstractChestBoat.remove` spills the chest through
            // `Containers.dropContents` for every destroying removal reason;
            // that has no `entity_drops` gate of its own.
    // rust: for stack in b.items.iter().flatten() {
    // rust: self.spawn_item(stack.clone(), at, super::dispenser::new_item_motion(), 10);
}
            // `VehicleEntity.destroy(level, dropItem)` drops the boat item on
            // the death path only, and only with `entity_drops` on.
    // rust: if !creative && self.ui.rules.bool("entity_drops") {
    // rust: let item = b.entity_type();
    // rust: self.spawn_item(
    // rust: ItemStack {
    // rust: item: Arc::from(item.as_str()),
    // rust: count: 1,
    // rust: damage: 0,
    // rust: extra: None,
    // rust: },
    // rust: at,
    // rust: [0.0, 0.1, 0.0],
    // rust: 10,
    // rust: );
}
}
    // rust: Some(destroyed)
}
    /// AbstractBoatRenderer.
    // rust: pub(super) fn boat_geometry(&self, camera: glam::DVec3, alpha: f64, out: &mut Vec<Vertex>) {
    // rust: let a = alpha as f32;
    // rust: let range = super::entity_culling::default_range(
    // rust: glam::DVec3::new(WIDTH, HEIGHT, WIDTH),
    // rust: self.view_scale(),
    // rust: );
    // rust: for b in &self.boats {
            // EntityRenderer.shouldRender.
    // rust: let (previous, position) = (at(b.previous), at(b.position));
    // rust: if !self.standing_entity_in_view(
    // rust: camera, previous, position, alpha, WIDTH, HEIGHT, range, 0.0,
    // rust: ) {
    // rust: continue;
}
    // rust: let culling = self.entity_cull_decision(b, alpha);
    // rust: if culling.hides_entity() {
    // rust: continue;
}
    // rust: let entity_start = out.len();
    // rust: let models = if b.chest {
    // rust: &self.boat_models.chest_models
    // rust: } else {
    // rust: &self.boat_models.models
}
    // rust: let Some(model) = models.get(&*b.wood) else {
    // rust: continue;
}
    // rust: let folder = if b.chest { "chest_boat" } else { "boat" };
    // rust: let Some(uv) = self
    // rust: .gui
    // rust: .atlas
    // rust: .sprites
    // rust: .get(&format!("entity/{folder}/{}", b.wood))
    // rust: .map(|r| [r.u0, r.v0, r.u1, r.v1])
    // rust: else {
    // rust: continue;
}
    // rust: let p = glam::DVec3::new(
    // rust: b.previous.x + (b.position.x - b.previous.x) * alpha,
    // rust: b.previous.y + (b.position.y - b.previous.y) * alpha,
    // rust: b.previous.z + (b.position.z - b.previous.z) * alpha,
    // rust: ) - camera;
    // rust: let yaw = b.previous_yaw + (b.yaw - b.previous_yaw) * a;
    // rust: let hurt = b.hurt_time as f32 - a;
    // rust: let damage = (b.damage - a).max(0.0);
    // rust: let mut base =
    // rust: glam::Mat4::from_translation(p.as_vec3() + glam::Vec3::new(0.0, 0.375, 0.0))
    // rust: * glam::Mat4::from_rotation_y((180.0 - yaw).to_radians());
    // rust: if hurt > 0.0 {
    // rust: base *= glam::Mat4::from_rotation_x(
    // rust: (hurt.sin() * hurt * damage / 10.0 * b.hurt_dir as f32).to_radians(),
    // rust: );
}
            // AbstractBoatRenderer.extractRenderState: bubbleAngle.
    // rust: let wobble = b.bubble_angle(a);
            // AbstractBoatRenderer.submit: a boat above water wobbles in a
            // bubble column, about the axis (1, 0, 1).
    // rust: if !b.under_water() && wobble.abs() >= 1.0e-5 {
    // rust: base *= glam::Mat4::from_axis_angle(
    // rust: glam::Vec3::new(1.0, 0.0, 1.0).normalize(),
    // rust: wobble * (std::f64::consts::PI / 180.0) as f32,
    // rust: );
}
    // rust: base *= glam::Mat4::from_scale(glam::Vec3::new(-1.0, -1.0, 1.0))
    // rust: * glam::Mat4::from_rotation_y(90f32.to_radians());
    // rust: let mut poses = Poses::new(model);
            // AbstractBoatModel.animatePaddle
    // rust: for (side, name) in [(0usize, "left_paddle"), (1, "right_paddle")] {
    // rust: if !poses.has(name) {
    // rust: continue;
}
    // rust: let t = b.rowing_time(side, a);
    // rust: let lerp = |f: f32, lo: f32, hi: f32| lo + f.clamp(0.0, 1.0) * (hi - lo);
    // rust: let pose = poses.get(name);
    // rust: pose[3] = lerp(((-t).sin() + 1.0) / 2.0, -PI / 3.0, -PI / 12.0);
    // rust: pose[4] = lerp(((-t + 1.0).sin() + 1.0) / 2.0, -PI / 4.0, PI / 4.0);
    // rust: if side == 1 {
    // rust: pose[4] = PI - pose[4];
}
}
    // rust: let l = self.world.light(
    // rust: b.position.x.floor() as i32,
    // rust: (b.position.y + 0.3).floor() as i32,
    // rust: b.position.z.floor() as i32,
    // rust: );
    // rust: let packed = (u32::from(l >> 4) * 16) | ((u32::from(l & 15) * 16) << 8);
    // rust: horizon_client::mobs::render::draw(
    // rust: model,
    // rust: base,
    // rust: &poses,
    // rust: uv,
    // rust: 0xFFFF_FFFF,
    // rust: packed,
    // rust: 0,
    // rust: out,
    // rust: );
            // BoatRenderer.submitTypeAdditions: the water patch hides the water
            // inside the hull unless the boat is under water (RaftRenderer has none).
    // rust: if let Some(patch) = self.boat_models.water_patch.as_ref()
    // rust: && &*b.wood != "bamboo"
    // rust: && !matches!(b.status, Status::UnderWater | Status::UnderFlowingWater)
    // rust: {
    // rust: horizon_client::mobs::render::draw(
    // rust: patch,
    // rust: base,
    // rust: &Poses::new(patch),
    // rust: uv,
    // rust: 0xFFFF_FFFF,
    // rust: packed,
    // rust: horizon_client::gfx::WATER_MASK_OVERLAY,
    // rust: out,
    // rust: );
}
    // rust: self.finish_entity_occlusion(culling, b, out, entity_start);
}
}
}

    // rust: mod tests {
//     use super::*;

pub fn boat() B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Boat::new(1, Arc::from("oak"), Vec3::ZERO, 0.0)
}

    /// `AbstractBoat.tickBubbleColumn` on a client: the wobble grows while the
    /// bubble time runs and fades after.
pub fn the_wobble_grows_while_the_bubble_time_runs_and_fades_after() void {
}
    // rust: let mut b = boat();
    // rust: b.bubble_time = BUBBLE_TIME;
    // rust: for _ in 0..30 {
    // rust: b.tick_bubble_wobble();
}
        // 0.05 a tick, capped at 1.
    // rust: assert_eq!(b.bubble_multiplier, 1.0);
        // 10 * sin(0.5 * tickCount) * multiplier.
    // rust: let expected = 10.0 * (0.5 * 30.0f64).sin() as f32;
    // rust: assert!((b.bubble_angle - expected).abs() < 1.0e-4);
        // The render angle lerps between the last two ticks.
    // rust: let mid = b.bubble_angle(0.5);
    // rust: assert!((mid - (b.bubble_angle_old + b.bubble_angle) / 2.0).abs() < 1.0e-5);
        // Once the bubble time is 0 the multiplier fades by 0.1 a tick.
    // rust: b.bubble_time = 0;
    // rust: for _ in 0..4 {
    // rust: b.tick_bubble_wobble();
}
    // rust: assert!((b.bubble_multiplier - 0.6).abs() < 1.0e-5);
    // rust: for _ in 0..10 {
    // rust: b.tick_bubble_wobble();
}
    // rust: assert_eq!(b.bubble_multiplier, 0.0);
    // rust: assert_eq!(b.bubble_angle, 0.0);
}

    /// `AbstractBoat.tickBubbleColumn` on the server: a boat held over a
    /// column fires on the 60th tick, with the column's direction, then the
    /// time restarts.
pub fn the_bubble_countdown_fires_every_sixty_ticks_over_a_column() void {
}
    // rust: for down in [false, true] {
    // rust: let mut b = boat();
    // rust: let mut fired = Vec::new();
    // rust: for tick in 1..=130 {
                // What boat_above_bubble_column does each tick.
    // rust: b.above_bubble_column = true;
    // rust: b.bubble_down = down;
    // rust: if b.bubble_time == 0 {
    // rust: b.bubble_time = BUBBLE_TIME;
}
    // rust: if let Some(d) = b.tick_bubble_countdown() {
    // rust: fired.push((tick, d));
}
    // rust: assert!(!b.above_bubble_column);
}
    // rust: assert_eq!(fired, vec![(60, down), (120, down)]);
}
}

    /// Leaving the column resets the time: nothing fires, and a boat with no
    /// time left does nothing over a column until the column sets it.
pub fn leaving_the_column_resets_the_bubble_countdown() void {
}
    // rust: let mut b = boat();
    // rust: b.bubble_time = BUBBLE_TIME;
    // rust: for _ in 0..30 {
    // rust: b.above_bubble_column = true;
    // rust: assert_eq!(b.tick_bubble_countdown(), None);
}
    // rust: assert_eq!(b.bubble_time, 30);
        // A tick away from the column.
    // rust: assert_eq!(b.tick_bubble_countdown(), None);
    // rust: assert_eq!(b.bubble_time, 0);
    // rust: b.above_bubble_column = true;
    // rust: assert_eq!(b.tick_bubble_countdown(), None);
    // rust: assert!(b.above_bubble_column);
}

pub fn a_boat_that_never_saw_a_column_does_not_wobble() void {
}
    // rust: let mut b = boat();
    // rust: for _ in 0..10 {
    // rust: b.tick_bubble_wobble();
}
    // rust: assert_eq!(b.bubble_angle, 0.0);
    // rust: assert_eq!(b.bubble_angle(0.5), 0.0);
}

    /// #8156: the powder snow cells a boat's box reaches into, its box deflated by 1e-5.
pub fn a_boat_reaches_the_powder_snow_cells_its_box_touches() void {
}
    // rust: let b = Boat::new(1, "oak".into(), Vec3::new(10.5, 64.0, 10.5), 0.0);
    // rust: let snow = |cells: &'static [[i32; 3]]| move |p: [i32; 3]| cells.contains(&p);
        // Inside, a corner cell, and a cell the box only ends against.
    // rust: assert_eq!(
    // rust: powder_snow_cells(b.bounds(), snow(&[[10, 64, 10]])),
    // rust: vec![[10, 64, 10]]
    // rust: );
    // rust: assert_eq!(
    // rust: powder_snow_cells(b.bounds(), snow(&[[9, 64, 11], [12, 64, 10], [10, 65, 10]])),
    // rust: vec![[9, 64, 11]],
    // rust: "the cell beyond the edge and the one above the box are not reached"
    // rust: );
    // rust: let edge = Boat::new(1, "oak".into(), Vec3::new(11.3125, 64.0, 10.5), 0.0);
    // rust: assert!(powder_snow_cells(edge.bounds(), snow(&[[12, 64, 10]])).is_empty());
        // x, y, z order.
    // rust: let all = powder_snow_cells(b.bounds(), |_| true);
    // rust: assert_eq!(all.len(), 9);
    // rust: assert_eq!((all[0], all[8]), ([9, 64, 9], [11, 64, 11]));
}

    /// `Entity.move`: a boat made stuck goes its velocity times the multiplier once, and
    /// loses its velocity; one that is not goes as it did.
pub fn a_stuck_boat_moves_a_part_of_its_velocity_once() void {
}
    // rust: let mut b = Boat::new(1, "oak".into(), Vec3::ZERO, 0.0);
    // rust: b.velocity = Vec3::new(1.0, 0.5, 2.0);
    // rust: assert_eq!(b.take_movement(), Vec3::new(1.0, 0.5, 2.0));
    // rust: assert_eq!(b.velocity, Vec3::new(1.0, 0.5, 2.0));
    // rust: b.stuck = powder_snow_stuck();
    // rust: let moved = b.take_movement();
    // rust: let slow = f64::from(0.9_f32);
    // rust: assert_eq!(moved, Vec3::new(slow, 0.75, 2.0 * slow));
    // rust: assert_eq!((b.velocity, b.stuck), (Vec3::ZERO, Vec3::ZERO));
    // rust: b.velocity = Vec3::new(0.0, 0.1, 1.0);
    // rust: assert_eq!(b.take_movement(), Vec3::new(0.0, 0.1, 1.0), "spent");
}

    /// `PowderSnowBlock.entityInside`'s snowflake: only for an entity that moved sideways, and
    /// then only when a coin falls so.
pub fn a_boat_moving_sideways_in_powder_snow_throws_snowflakes_now_and_then() void {
}
//         use horizon_core::random::LegacyRandom;
        // Still or only rising: no coin is drawn.
    // rust: let mut random = LegacyRandom::new(7);
    // rust: let mut untouched = LegacyRandom::new(7);
    // rust: assert_eq!(
    // rust: snowflake_velocity(Vec3::new(0.0, 0.4, 0.0), &mut random),
    // rust: None
    // rust: );
    // rust: assert_eq!(random.next_int(), untouched.next_int());
    // rust: let known = Vec3::new(0.1, 0.0, 0.0);
        // One stream, as the server's: about half the calls draw a snowflake. (Seeds a step
        // apart would not do, their first coin is nearly always the same.)
    // rust: let mut stream = LegacyRandom::new(42);
    // rust: let flakes: Vec<[f64; 3]> = (0..200)
    // rust: .filter_map(|_| snowflake_velocity(known, &mut stream))
    // rust: .collect();
    // rust: assert!(
    // rust: (60..=140).contains(&flakes.len()),
    // rust: "about half the seeds: {}",
    // rust: flakes.len()
    // rust: );
    // rust: let limit = f64::from(0.083_333_336_f32);
    // rust: for [x, y, z] in flakes {
    // rust: assert!(x.abs() <= limit && z.abs() <= limit);
    // rust: assert_eq!(y, f64::from(0.05_f32));
}
        // Either horizontal axis is enough.
    // rust: assert!(
    // rust: (0..64)
    // rust: .any(|_| { snowflake_velocity(Vec3::new(0.0, 0.0, -0.1), &mut stream).is_some() })
    // rust: );
}
}
    // rust: horizon_client::impl_joined!(Boat);
