//! Transpiled from Horizon Rust crate
//! Module: horizon-client_respawn_anchor
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `RespawnAnchorBlock` in the game: glowstone charges it (`useItemOn`), a
//! right click on a charged anchor sets the respawn point in the Nether and
//! blows it up anywhere else (`useWithoutItem`), and respawning goes to it
//! (`ServerPlayer.findRespawnAndUseSpawnBlock`, `PlayerList.respawn`),
//! using a charge.
// use super::{Dim, Game};
// use horizon_client::first_person::Hand;
// use horizon_client::{
    // rust: Result,
    // rust: blocks::Fluid,
    // rust: collisions::{SceneCollisions, no_collision_empty},
    // rust: items::ItemStack,
    // rust: mobs::Who,
    // rust: stand_up::{StandUpLevel, StandUpType, bed_forward, stand_up_fallback},
    // rust: text::Text,
}
// use horizon_core::{
    // rust: geometry::{Aabb, Axis, Vec3, VoxelShape},
    // rust: position::BlockPos,
}
// use horizon_world::{collision_context::CollisionContext, registry::BlockStateId};

/// `ServerPlayer.RespawnConfig`: a respawn point other than the world spawn
/// that the game resolves through its block (a respawn anchor).
    // rust: pub(super) struct RespawnConfig {
    // rust: pub dim: Dim,
    // rust: pub pos: [i32; 3],
    // rust: pub yaw: f32,
    // rust: pub forced: bool,
}

/// A respawn point as a player's save keeps it (`respawn`): dimension,
/// block, yaw and whether it is forced.
    // rust: pub(super) type SavedRespawn = (String, [i32; 3], f32, bool);

    // rust: impl RespawnConfig {
    /// `RespawnData.of`: the yaw wrapped to [-180, 180).
    // rust: pub(super) fn wrapped(dim: Dim, pos: [i32; 3], yaw: f32, forced: bool) -> Self {
    // rust: Self {
    // rust: dim,
    // rust: pos,
    // rust: yaw: wrap_degrees(f64::from(yaw)) as f32,
    // rust: forced,
}
}
    // rust: pub(super) fn from_saved((dim, pos, yaw, forced): &SavedRespawn) -> Self {
    // rust: Self {
    // rust: dim: Dim::from_id(dim),
    // rust: pos: *pos,
    // rust: yaw: *yaw,
    // rust: forced: *forced,
}
}
    // rust: pub(super) fn saved(&self) -> SavedRespawn {
    // rust: (self.dim.id().to_owned(), self.pos, self.yaw, self.forced)
}
}

/// `RespawnAnchorBlock.RESPAWN_HORIZONTAL_OFFSETS`, then the same a block
/// below, a block above, and straight above.
    // rust: const HORIZONTAL: [[i32; 3]; 8] = [
    // rust: [0, 0, -1],
    // rust: [-1, 0, 0],
    // rust: [0, 0, 1],
    // rust: [1, 0, 0],
    // rust: [-1, 0, -1],
    // rust: [1, 0, -1],
    // rust: [-1, 0, 1],
    // rust: [1, 0, 1],
    // rust: ];
/// Blocks vanilla defines with `.liquid()`: water, lava and the bubble column.
pub fn is_liquid_block_name(name: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(
    // rust: name,
    // rust: "minecraft:water" | "minecraft:lava" | "minecraft:bubble_column"
    // rust: )
}

pub fn respawn_offsets() i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: HORIZONTAL
    // rust: .into_iter()
    // rust: .chain(HORIZONTAL.into_iter().map(|[x, y, z]| [x, y - 1, z]))
    // rust: .chain(HORIZONTAL.into_iter().map(|[x, y, z]| [x, y + 1, z]))
    // rust: .chain(std::iter::once([0, 1, 0]))
}

/// What a right click with an item does to an anchor before `useWithoutItem`.
    // rust: pub(super) enum AnchorUse {
    /// Glowstone charged it.
    // rust: Charged,
    /// `PASS`: the off hand's glowstone charges it instead.
    // rust: Pass,
    /// `TRY_WITH_EMPTY_HAND`, or not an anchor.
    // rust: Other,
}

    // rust: impl Game<'_> {
    // rust: pub(super) fn is_anchor(&self, state: BlockStateId) -> bool {
    // rust: &*self.res.facts().get(state).name == "minecraft:respawn_anchor"
}
pub fn anchor_charges(self: *Self, state: BlockStateId) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pack
    // rust: .assets
    // rust: .registry
    // rust: .state(state)
    // rust: .and_then(|s| s.properties.get("charges"))
    // rust: .and_then(|c| c.parse().ok())
    // rust: .unwrap_or(0)
}
pub fn anchor_with_charges(self: *Self, state: BlockStateId, charges: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut s = self.pack.assets.registry.state(state)?.clone();
    // rust: s.properties.insert("charges".into(), charges.to_string());
    // rust: self.pack.assets.registry.resolve(&s).ok()
}
    /// `RespawnAnchorBlock.canSetSpawn`: the `respawn_anchor_works` attribute
    /// (only the Nether's dimension type sets it).
    // rust: pub(super) fn anchor_works(&self) -> bool {
    // rust: self.dim == Dim::Nether
}
    /// `RespawnAnchorBlock.charge`: one more charge, the block change and the sound.
    // rust: fn charge_anchor(
    // rust: &mut self,
    // rust: pos: [i32; 3],
    // rust: state: BlockStateId,
    // rust: who: Option<Who>,
    // rust: ) -> Result<()> {
    // rust: let Some(next) = self.anchor_with_charges(state, self.anchor_charges(state) + 1) else {
    // rust: return Ok(());
}
    // rust: self.level_set(pos, next)?;
    // rust: self.post_block_game_event("minecraft:block_change", pos, who, Some(next));
    // rust: let at = [
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(pos[1]) + 0.5,
    // rust: f64::from(pos[2]) + 0.5,
    // rust: ];
    // rust: self.audio
    // rust: .play("minecraft:block.respawn_anchor.charge", Some(at), 1.0, 1.0);
    // rust: Ok(())
}
    /// `RespawnAnchorBlock.useItemOn`'s test: `held` is glowstone
    /// (`isRespawnFuel`) and the block at `pos` is an anchor that takes another
    /// charge (`canBeCharged`).
    // rust: pub(super) fn anchor_takes(&self, pos: [i32; 3], held: Option<&ItemStack>) -> bool {
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: held.is_some_and(|s| &*s.item == "minecraft:glowstone")
    // rust: && self.is_anchor(state)
    // rust: && self.anchor_charges(state) < 4
}
    /// `RespawnAnchorBlock.useItemOn` with `held` in the hand that acts.
    // rust: pub(super) fn use_respawn_anchor(
    // rust: &mut self,
    // rust: pos: [i32; 3],
    // rust: held: Option<&ItemStack>,
    // rust: ) -> Result<AnchorUse> {
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: if !self.is_anchor(state) {
    // rust: return Ok(AnchorUse::Other);
}
    // rust: let fuel = |s: Option<&ItemStack>| s.is_some_and(|s| &*s.item == "minecraft:glowstone");
    // rust: let chargeable = self.anchor_charges(state) < 4;
    // rust: if fuel(held) && chargeable {
    // rust: let used = held.cloned();
    // rust: self.charge_anchor(pos, state, Some(Who::Player))?;
            // itemStack.consume(1, player); the criterion sees the stack as used.
    // rust: self.consume_held();
    // rust: if let Some(stack) = used {
    // rust: self.trigger_block("minecraft:item_used_on_block", pos, &stack);
}
    // rust: return Ok(AnchorUse::Charged);
}
    // rust: if self.hand == Hand::Main && fuel(self.offhand.as_ref()) && chargeable {
    // rust: return Ok(AnchorUse::Pass);
}
    // rust: Ok(AnchorUse::Other)
}
    /// `RespawnAnchorBlock.useWithoutItem` on a charged anchor: outside the
    /// Nether it explodes; inside, it becomes the respawn point.
    // rust: pub(super) fn respawn_anchor_used(&mut self, pos: [i32; 3]) -> Result<()> {
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: if !self.anchor_works() {
    // rust: return self.explode_anchor(pos, state);
}
    // rust: let config = RespawnConfig {
    // rust: dim: self.dim,
    // rust: pos,
    // rust: yaw: 0.0,
    // rust: forced: false,
}
        // RespawnConfig.isSamePosition: dimension and block.
    // rust: let same = self
    // rust: .respawn_config
    // rust: .is_some_and(|c| c.dim == config.dim && c.pos == config.pos);
    // rust: if !same {
    // rust: let mut cancel = false;
    // rust: if let (Some(player), Some(name)) = (self.lan_acting_uuid, self.lan_acting_name.clone())
    // rust: {
    // rust: self.native_player_spawn_point_set(
    // rust: player,
    // rust: &name,
    // rust: self.dim.id(),
    // rust: pos,
    // rust: "respawn_anchor",
    // rust: &mut cancel,
    // rust: );
}
    // rust: if cancel {
    // rust: return Ok(());
}
            // setRespawnPosition(config, true): the message, the point; the
            // anchor replaces a bed.
    // rust: self.system_message(Text::translate("block.minecraft.set_spawn", &[]));
    // rust: self.respawn_config = Some(config);
    // rust: if let Some([x, y, z]) = self.level.world_spawn {
    // rust: self.spawn = Some(Vec3::new(
    // rust: f64::from(x) + 0.5,
    // rust: f64::from(y),
    // rust: f64::from(z) + 0.5,
    // rust: ));
}
    // rust: let at = [
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(pos[1]) + 0.5,
    // rust: f64::from(pos[2]) + 0.5,
    // rust: ];
    // rust: self.audio.play(
    // rust: "minecraft:block.respawn_anchor.set_spawn",
    // rust: Some(at),
    // rust: 1.0,
    // rust: 1.0,
    // rust: );
}
    // rust: Ok(())
}
    /// `RespawnAnchorBlock.isWaterThatWouldFlow`.
pub fn water_would_flow(self: *Self, p: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let f = self.res.facts().get(self.world.block(p[0], p[1], p[2]));
    // rust: if f.fluid != Fluid::Water {
    // rust: return false;
}
    // rust: if f.fluid_level == 8 && !f.fluid_falling {
    // rust: return true;
}
    // rust: if f.fluid_level < 2 {
    // rust: return false;
}
    // rust: self.res
    // rust: .facts()
    // rust: .get(self.world.block(p[0], p[1] - 1, p[2]))
    // rust: .fluid
    // rust: != Fluid::Water
}
    /// `RespawnAnchorBlock.explode`: the anchor goes, then a power 5 fiery
    /// explosion (`badRespawnPointExplosion`, `ExplosionInteraction.BLOCK`)
    /// whose centre resists like water when water would flow into it.
pub fn explode_anchor(self: *Self, pos: [i32; 3], _state: BlockStateId) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.level_set(pos, self.world.air)?;
    // rust: let horizontal = [[0, 0, -1], [0, 0, 1], [-1, 0, 0], [1, 0, 0]]
    // rust: .into_iter()
    // rust: .any(|d| self.water_would_flow([pos[0] + d[0], pos[1], pos[2] + d[2]]));
    // rust: let above = self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(pos[0], pos[1] + 1, pos[2]))
    // rust: .fluid
    // rust: == Fluid::Water;
    // rust: let in_water = horizontal || above;
    // rust: let center = [
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(pos[1]) + 0.5,
    // rust: f64::from(pos[2]) + 0.5,
    // rust: ];
    // rust: self.block_explosion(center, in_water.then_some(pos))
}
    /// `StrawBedBlock.destroyBed`: the break sound, then the bed is air.
    // rust: pub(super) fn destroy_straw_bed(&mut self, head: [i32; 3]) -> Result<()> {
    // rust: let center = [
    // rust: f64::from(head[0]) + 0.5,
    // rust: f64::from(head[1]) + 0.5,
    // rust: f64::from(head[2]) + 0.5,
    // rust: ];
    // rust: self.audio.play(
    // rust: "minecraft:block.straw_bed.break_leave",
    // rust: Some(center),
    // rust: 1.0,
    // rust: 1.0,
    // rust: );
    // rust: self.level_set(head, self.world.air)
}
    /// `BedRule.destroyOnUse` of the dimension's `bed_rule` and
    /// `straw_bed_rule`: true in the Nether and the End.
    // rust: pub(super) fn beds_destroy_on_use(&self) -> bool {
    // rust: self.dim != Dim::Overworld
}
    /// `AbstractBedBlock.useWithoutItem` where the bed rule destroys on use
    /// (the bed's head at `head`): `BedBlock.destroyOnUse` removes both
    /// halves and explodes; `StrawBedBlock` just falls apart.
    // rust: pub(super) fn destroy_bed_on_use(&mut self, head: [i32; 3]) -> Result<()> {
    // rust: let state = self.world.block(head[0], head[1], head[2]);
    // rust: let name = self.res.facts().get(state).name.clone();
    // rust: let center = [
    // rust: f64::from(head[0]) + 0.5,
    // rust: f64::from(head[1]) + 0.5,
    // rust: f64::from(head[2]) + 0.5,
    // rust: ];
    // rust: if &*name == "minecraft:straw_bed" {
    // rust: return self.destroy_straw_bed(head);
}
        // removeBlock(head), then the foot behind it if it is still this bed.
    // rust: let facing = self
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .state(state)
    // rust: .and_then(|s| s.properties.get("facing").cloned())
    // rust: .unwrap_or_default();
    // rust: let back = match facing.as_str() {
    // rust: "north" => [0, 0, 1],
    // rust: "south" => [0, 0, -1],
    // rust: "west" => [1, 0, 0],
    // rust: _ => [-1, 0, 0],
}
    // rust: self.level_set(head, self.world.air)?;
    // rust: let foot = [head[0] + back[0], head[1], head[2] + back[2]];
    // rust: if self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(foot[0], foot[1], foot[2]))
    // rust: .name
    // rust: == name
    // rust: {
    // rust: self.level_set(foot, self.world.air)?;
}
    // rust: self.block_explosion(center, None)
}
    /// `Level.explode(null, badRespawnPointExplosion(center), calculator,
    /// center, 5, true, ExplosionInteraction.BLOCK)` (beds and anchors):
    /// `water_at` is the block that resists like water.
    // rust: pub(super) fn block_explosion(
    // rust: &mut self,
    // rust: center: [f64; 3],
    // rust: water_at: Option<[i32; 3]>,
    // rust: ) -> Result<()> {
    // rust: let interaction = self.destroy_type("block_explosion_drop_decay");
    // rust: self.server_explode_as(
    // rust: center,
    // rust: 5.0,
    // rust: interaction,
    // rust: true,
    // rust: "minecraft:bad_respawn_point",
    // rust: water_at.map(|p| (p, 100.0)),
    // rust: )
}

    // ---- respawning -------------------------------------------------------

    /// This level as the stand-up search reads it (`crate::stand_up`).
pub fn stand_up_level(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: StandUpLevel {
    // rust: world: &self.world,
    // rust: registry: self.pack.assets.registry,
    // rust: facts: self.res.facts(),
    // rust: collision: self.collision,
    // rust: block_tags: &self.res.items().block_tags,
    // rust: border: Some(self.border.geometry()),
}
}
    /// `BlockState.getCollisionShape(level, pos)`: the shape under the empty
    /// collision context.
    // rust: pub(super) fn block_collision_shape(&self, p: [i32; 3]) -> VoxelShape {
    // rust: let state = self.world.block(p[0], p[1], p[2]);
    // rust: let binding = self.collision;
    // rust: let mut scene = SceneCollisions {
    // rust: world: &self.world,
    // rust: binding,
    // rust: subject: None,
}
    // rust: binding
    // rust: .collision_shape_with_context(
    // rust: &mut scene,
    // rust: state,
    // rust: BlockPos::new(p[0], p[1], p[2]),
    // rust: &CollisionContext::empty(false),
    // rust: )
    // rust: .unwrap_or_else(|_| VoxelShape::empty())
}
    /// `DismountHelper.canDismountTo(level, entity, box)`: no block collides
    /// with the box and it is inside the world border.
    // rust: pub(super) fn can_dismount_to(&self, bounds: Aabb) -> bool {
    // rust: let mut scene = SceneCollisions {
    // rust: world: &self.world,
    // rust: binding: self.collision,
    // rust: subject: None,
}
    // rust: if !no_collision_empty(&mut scene, bounds) {
    // rust: return false;
}
        // WorldBorder.isWithinBounds(box).
    // rust: let (lo, hi) = (bounds.min(Axis::X), bounds.max(Axis::X) - 1.0e-5);
    // rust: let (lz, hz) = (bounds.min(Axis::Z), bounds.max(Axis::Z) - 1.0e-5);
    // rust: self.border.contains(lo, lz) && self.border.contains(hi, hz)
}
    // rust: pub(super) fn block_in_tag(&self, tag: &str, block: &str) -> bool {
    // rust: self.res
    // rust: .items()
    // rust: .block_tags
    // rust: .get(tag)
    // rust: .is_some_and(|s| s.contains(block))
}
    /// `DismountHelper.findSafeDismountLocation` for a standing player.
pub fn safe_dismount_location(self: *Self, p: [i32; 3], check_dangerous: bool) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.stand_up_level()
    // rust: .safe_dismount_location(StandUpType::PLAYER, p, check_dangerous)
}
    /// `Block.isPossibleToRespawnInThis`: neither solid nor liquid; banners,
    /// signs and pressure plates override it to always.
pub fn possible_to_respawn_in(self: *Self, state: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let f = self.res.facts().get(state);
    // rust: let name = &*f.name;
    // rust: name.ends_with("_banner")
    // rust: || f.sign_form().is_some()
    // rust: || name.ends_with("_pressure_plate")
    // rust: || !(f.legacy_solid || is_liquid_block_name(name))
}
    /// `RespawnAnchorBlock.findStandUpPosition`: a safe spot around the
    /// anchor, else any spot.
    // rust: pub(super) fn anchor_stand_up(&self, pos: [i32; 3]) -> Option<Vec3> {
    // rust: for check in [true, false] {
    // rust: for d in respawn_offsets() {
    // rust: let p = [pos[0] + d[0], pos[1] + d[1], pos[2] + d[2]];
    // rust: if let Some(at) = self.safe_dismount_location(p, check) {
    // rust: return Some(at);
}
}
}
    // rust: None
}
    /// `AbstractBedBlock.findStandUpPosition` for a player beside the bed
    /// whose head is at `pos`, facing `forward`, set from `yaw`.
    // rust: pub(super) fn bed_stand_up(&self, pos: [i32; 3], forward: [i32; 3], yaw: f32) -> Option<Vec3> {
    // rust: self.stand_up_level()
    // rust: .bed_stand_up(StandUpType::PLAYER, pos, forward, yaw)
}
    // rust: pub(super) fn is_bed(&self, state: BlockStateId) -> bool {
    // rust: self.res.facts().get(state).name.ends_with("_bed")
}
    /// `LivingEntity.stopSleeping`: when the block at `head` is still a bed,
    /// stand at `AbstractBedBlock.findStandUpPosition` (else 0.1 above the
    /// block over the head), turned toward the bed's bottom centre with a
    /// level pitch.
    // rust: pub(super) fn bed_wake_pose(&self, head: [i32; 3], yaw: f32) -> Option<(Vec3, f32)> {
    // rust: let state = self.world.block(head[0], head[1], head[2]);
    // rust: if !self.is_bed(state) {
    // rust: return None;
}
    // rust: let facing = self.bed_forward(state);
    // rust: let stand = self
    // rust: .bed_stand_up(head, facing, yaw)
    // rust: .unwrap_or_else(|| stand_up_fallback(head));
    // rust: Some((stand, look_at_yaw(stand, head)))
}
    /// The bed's `facing`, as a step.
    // rust: pub(super) fn bed_forward(&self, state: BlockStateId) -> [i32; 3] {
    // rust: let facing = self.pack.assets.registry.state(state);
    // rust: bed_forward(
    // rust: facing
    // rust: .and_then(|s| s.properties.get("facing"))
    // rust: .map(String::as_str),
    // rust: )
}
    /// `BedRule.canSetSpawn` of the bed's rule attribute (`bed_rule`,
    /// `straw_bed_rule`): only the Overworld's beds set the spawn, straw
    /// beds never.
    // rust: pub(super) fn bed_sets_spawn(&self, state: BlockStateId) -> bool {
    // rust: self.dim == Dim::Overworld && &*self.res.facts().get(state).name != "minecraft:straw_bed"
}
    /// `ServerPlayer.findRespawnAndUseSpawnBlock` for a config in the loaded
    /// dimension: the position and yaw, using an anchor's charge; a bed's
    /// stand-up spot. A forced point (`spawnpoint`) that is no anchor or bed
    /// holds if a player fits in it; anything else is gone.
    // rust: pub(super) fn find_respawn_and_use(
    // rust: &mut self,
    // rust: c: RespawnConfig,
    // rust: consume: bool,
    // rust: ) -> Result<Option<(Vec3, f32)>> {
    // rust: let state = self.world.block(c.pos[0], c.pos[1], c.pos[2]);
    // rust: if !(self.is_anchor(state)
    // rust: && (c.forced || self.anchor_charges(state) > 0)
    // rust: && self.anchor_works())
    // rust: {
            // A bed where its bed rule lets it set the spawn.
    // rust: if self.is_bed(state) && self.bed_sets_spawn(state) {
    // rust: let facing = self.bed_forward(state);
    // rust: let stand = self.bed_stand_up(c.pos, facing, c.yaw);
    // rust: return Ok(stand.map(|p| (p, look_at_yaw(p, c.pos))));
}
    // rust: let [x, y, z] = c.pos;
    // rust: let free = c.forced
    // rust: && !self.is_anchor(state)
    // rust: && self.possible_to_respawn_in(state)
    // rust: && self.possible_to_respawn_in(self.world.block(x, y + 1, z));
    // rust: let at = Vec3::new(f64::from(x) + 0.5, f64::from(y) + 0.1, f64::from(z) + 0.5);
    // rust: return Ok(free.then_some((at, c.yaw)));
}
    // rust: let stand = self.anchor_stand_up(c.pos);
    // rust: if !c.forced
    // rust: && consume
    // rust: && stand.is_some()
    // rust: && let Some(next) = self.anchor_with_charges(state, self.anchor_charges(state) - 1)
    // rust: {
    // rust: self.level_set(c.pos, next)?;
}
    // rust: Ok(stand.map(|p| (p, look_at_yaw(p, c.pos))))
}
}

/// `RespawnPosAngle.calculateLookAtYaw`: the yaw from the position to the
/// bottom centre of the block.
pub fn look_at_yaw(position: Vec3, block: [i32; 3]) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let d = Vec3::new(
    // rust: f64::from(block[0]) + 0.5 - position.x,
    // rust: f64::from(block[1]) - position.y,
    // rust: f64::from(block[2]) + 0.5 - position.z,
    // rust: )
    // rust: .normalize();
    // Mth.atan2(z, x) * 180.0F / (float) Math.PI - 90.0: the compiled code
    // multiplies by the folded float constant widened to double.
    // rust: let degrees = horizon_core::geometry::trig::atan2(d.z, d.x)
    // rust: * f64::from(horizon_core::geometry::trig::RAD_TO_DEG)
    // rust: - 90.0;
    // rust: wrap_degrees(degrees) as f32
}
/// `Mth.wrapDegrees(double)`.
pub fn wrap_degrees(degrees: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut d = degrees % 360.0;
    // rust: if d >= 180.0 {
    // rust: d -= 360.0;
}
    // rust: if d < -180.0 {
    // rust: d += 360.0;
}
    // rust: d
}

    // rust: mod tests {
//     use super::*;

pub fn bubble_column_counts_as_liquid_for_respawn() void {
}
    // rust: assert!(is_liquid_block_name("minecraft:bubble_column"));
    // rust: assert!(is_liquid_block_name("minecraft:water"));
    // rust: assert!(is_liquid_block_name("minecraft:lava"));
    // rust: assert!(!is_liquid_block_name("minecraft:kelp"));
}

pub fn waking_up_next_to_a_bed_looks_toward_the_bed_head() void {
}
    // rust: let head = [10, 64, 5];
        // Standing one block south of the bed head (z + 1) looks north (180 deg).
    // rust: let south = Vec3::new(10.5, 64.0, 6.5);
    // rust: assert!((look_at_yaw(south, head).abs() - 180.0).abs() < 1.0e-4);
        // Standing one block east of the bed head (x + 1) looks west (90 deg).
    // rust: let east = Vec3::new(11.5, 64.0, 5.5);
    // rust: assert!((look_at_yaw(east, head) - 90.0).abs() < 1.0e-4);
}
}
