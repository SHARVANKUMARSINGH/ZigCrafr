//! Transpiled from Horizon Rust crate
//! Module: horizon-client_perspective
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The camera type (`CameraType`: first person, third person behind and
//! in front, cycled by F5), the detached camera (`Camera.setup` with
//! `getMaxZoom`), and the local player drawn as a model: in third person
//! and in the inventory (`InventoryScreen.extractEntityInInventoryFollowsMouse`).
// use super::{Game, Screen, native_mob_draw::NativePlayerRender, shoulders::shoulder_variants};
// use horizon_client::{
    // rust: blocks::BlockFacts,
    // rust: camera::{CameraEntity, LivingCamera},
    // rust: collisions::SceneCollisions,
}
// use horizon_client::{
    // rust: hud::HudBatch,
    // rust: mobs::{Anim, Brain, Mob, MobType},
    // rust: mouse::Rotation,
    // rust: pose::Pose,
}
// use horizon_core::{
    // rust: geometry::{Aabb, ShapeOp, Vec3, VoxelShape},
    // rust: position::BlockPos,
}
// use horizon_world::{
    // rust: collision_context::{CollisionContext, CollisionEntity, CollisionItem},
    // rust: entity_obstruction::EntityIdentity,
    // rust: registry::BlockStateId,
    // rust: world_ray::{RayBlockMode, RayFluidMode, RayWorld, clip_world},
}
// use std::{
    // rust: io,
    // rust: path::{Path, PathBuf},
    // rust: sync::{Arc, Mutex},
}

/// `Level.clip` with `ClipContext.Block.VISUAL` and no fluids:
/// `BlockBehaviour.getVisualShape` is the collision shape except for the
/// blocks that override it.
pub const VisualRays = struct {
    scene: SceneCollisions<'a,
    facts: *'a BlockFacts,
    context: CollisionContext<'static>,
};
    // rust: impl RayWorld for VisualRays<'_, '_> {
    // rust: type Error = io::Error;
    // rust: type Block = BlockStateId;
    // rust: type Fluid = ();
pub fn block_state(self: *Self, p: BlockPos) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.scene.world.block(p.x, p.y, p.z))
}
pub fn fluid_state(self: *Self, _: BlockPos) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(())
}
    // rust: fn block_shape(
    // rust: &mut self,
    // rust: state: BlockStateId,
    // rust: p: BlockPos,
    // rust: _: RayBlockMode,
    // rust: ) -> io::Result<VoxelShape> {
    // rust: let facts = self.facts.get(state);
    // rust: let name = &*facts.name;
        // TransparentBlock (glass, stained and tinted glass, copper grates),
        // IronBarsBlock (bars and panes) and PowderSnowBlock: nothing;
        // SoulSandBlock and MudBlock: a full block; SnowLayerBlock and
        // FenceBlock: their outline.
    // rust: if name.ends_with("glass")
    // rust: || name.ends_with("glass_pane")
    // rust: || name.ends_with("_bars")
    // rust: || name.ends_with("copper_grate")
    // rust: || name == "minecraft:powder_snow"
    // rust: {
    // rust: return Ok(VoxelShape::empty());
}
    // rust: if name == "minecraft:soul_sand" || name == "minecraft:mud" {
    // rust: return Ok(VoxelShape::block());
}
    // rust: if name == "minecraft:snow" || name.ends_with("_fence") {
    // rust: let mut shape = VoxelShape::empty();
    // rust: for b in facts.outline.iter() {
    // rust: let b = b.map(f64::from);
    // rust: let part = VoxelShape::from_box(Aabb::new(
    // rust: Vec3::new(b[0], b[1], b[2]),
    // rust: Vec3::new(b[3], b[4], b[5]),
    // rust: ))
    // rust: .map_err(|e| io::Error::other(format!("{e:?}")))?;
    // rust: shape = shape
    // rust: .join(&part, ShapeOp::OR)
    // rust: .map_err(|e| io::Error::other(format!("{e:?}")))?;
}
    // rust: return Ok(shape);
}
    // rust: let binding = self.scene.binding;
    // rust: binding
    // rust: .collision_shape_with_context(&mut self.scene, state, p, &self.context)
    // rust: .map_err(|e| io::Error::other(format!("{e:?}")))
}
pub fn interaction_shape(self: *Self, _: BlockStateId, _: BlockPos) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(VoxelShape::empty())
}
pub fn fluid_is_source(self: *Self, _: () void {
}
    // rust: Ok(false)
}
pub fn fluid_is_empty(self: *Self, _: () void {
}
    // rust: Ok(true)
}
pub fn fluid_is_water(self: *Self, _: () void {
}
    // rust: Ok(false)
}
pub fn fluid_shape(self: *Self, _: () void {
}
    // rust: Ok(VoxelShape::empty())
}
}

    // rust: pub(super) enum CameraType {
    // rust: FirstPerson,
    // rust: ThirdPersonBack,
    // rust: ThirdPersonFront,
}
    // rust: impl CameraType {
    // rust: pub(super) fn first_person(self) -> bool {
    // rust: self == CameraType::FirstPerson
}
pub fn cycle(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: CameraType::FirstPerson => CameraType::ThirdPersonBack,
    // rust: CameraType::ThirdPersonBack => CameraType::ThirdPersonFront,
    // rust: CameraType::ThirdPersonFront => CameraType::FirstPerson,
}
}
}
/// `Entity.isInvisible` for the window's player: shared flag 5 as its server
/// sets it (`shared_flag`), with the Invisibility effect or by a plugin's
/// `setInvisible` alone, as pose plugins hide the real body under the pose
/// (#3788); a world in the frame has only the effect.
pub fn own_invisible(effects: *horizon_client::effects::PlayerEffects, shared_flag: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: shared_flag || effects.get("invisibility").is_some()
}
/// `LivingEntityRenderer.isBodyVisible` and `isInvisibleTo` for the player's
/// own body, seen by itself: an invisible player (`own_invisible`) hides it
/// unless its team sees friendly invisibles, where vanilla draws it
/// translucent.
pub fn body_visible(invisible: bool, team: ?*horizon_client::scoreboard::Team) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !horizon_client::scoreboard::invisible_to(team, team, false, invisible)
}
/// The player's model type for each resources root it was asked for.
pub const PLAYER_TYPES: Mutex<std.ArrayList((PathBuf, ?*MobType))> = Mutex::new(Vec::new());

/// The player's model type (`PlayerModel` with the default skin), read once
/// per resources root: `entity-models.json` doesn't change while the game
/// runs, and parsing it again held every world join for about 100 ms. The
/// world resources read it as the game starts (`load_world_rest`), so a join
/// finds it; a resource pack change's new root is read once.
    // rust: pub(super) fn player_type(root: &Path) -> Option<Arc<MobType>> {
    // rust: let mut cache = PLAYER_TYPES.lock().unwrap_or_else(|e| e.into_inner());
    // rust: if let Some((_, kind)) = cache.iter().find(|(cached, _)| cached == root) {
    // rust: return kind.clone();
}
    // rust: let kind = load_player_type(root);
    // rust: cache.push((root.to_owned(), kind.clone()));
    // rust: kind
}
/// `player_type` from the document: the model and its layers from one parse.
pub fn load_player_type(root: *Path) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let models = horizon_client::mobs::EntityModelDocument::load(root).ok()?;
    // rust: models.model("minecraft:player#main").map(|model| {
    // rust: Arc::new(MobType {
    // rust: id: "minecraft:player".into(),
            // Players render as a humanoid; the species only drives local AI.
    // rust: species: horizon_client::mobs::Species::Zombie,
    // rust: width: 0.6,
    // rust: height: 1.8,
    // rust: eye_height: 1.62,
    // rust: category: "misc".into(),
    // rust: max_health: 20.0,
    // rust: speed: 0.1,
    // rust: flying_speed: 0.02,
    // rust: attack_damage: 1.0,
    // rust: attack_knockback: 0.0,
    // rust: follow_range: 0.0,
    // rust: step_height: 0.6,
    // rust: armor: 0.0,
    // rust: armor_toughness: 0.0,
    // rust: knockback_resistance: 0.0,
    // rust: jump_strength: 0.42,
    // rust: attributes: Default::default(),
    // rust: item_stack_limits: Default::default(),
    // rust: gravity: 0.08,
    // rust: safe_fall_distance: 3.0,
    // rust: fall_damage_multiplier: 1.0,
    // rust: water_efficiency: 0.0,
    // rust: water_slowdown: 0.8,
    // rust: air_speed: 0.02,
    // rust: baby_scale: 0.5,
    // rust: head_rot_speed: 10.0,
    // rust: max_head_x_rot: 40.0,
    // rust: max_head_y_rot: 75.0,
    // rust: ambient_interval: 80,
    // rust: flags: Default::default(),
    // rust: model: Arc::new(model),
            // PlayerModel's slim arms, for slim skins, and PlayerCapeModel.
    // rust: layers: ["player_slim#main", "player#cape"]
    // rust: .into_iter()
    // rust: .filter_map(|key| {
    // rust: let model = models.model(&format!("minecraft:{key}"))?;
    // rust: Some((key.to_owned(), Arc::new(model)))
    // rust: })
    // rust: .collect(),
    // rust: texture: "entity/player/wide/steve".into(),
    // rust: brain: Brain::Passive,
    // rust: anim: Anim::Humanoid { zombie_arms: false },
    // rust: sounds: [
    // rust: "entity.player.hurt",
    // rust: "entity.player.hurt",
    // rust: "entity.player.death",
    // rust: ],
    // rust: step_sound: None,
    // rust: food: Arc::from([]),
    // rust: tempt: Arc::from([]),
    // rust: })
    // rust: })
}
/// What sets the body's yaw of a player riding something (`Game::ridden_body`).
pub const RiddenBody = enum {
    /// The boat's yaw.
    Boat(f32),
    /// The living vehicle's body yaw.
    Living(f32),
};

/// Whether a shadow pass that draws the player (`shadow_draws_player`: shadowPlayer, or a
/// native pack's shadow) takes the player's own model in first person. A shader pack's shadow
/// pass does, except for a spectator: in our probe packs' readings of Iris 1.11.7's shadow map
/// in spectator mode, the texels at the first-person camera hold the terrain below it, where
/// Horizon drew the spectator's model (vanilla's `PlayerModel` hides a spectator's body:
/// `showBody = !state.isSpectator`). A native pack's shadow keeps it.
    // rust: fn shadow_pass_takes_own_model(
    // rust: shadow_draws_player: bool,
    // rust: shader_pack: bool,
    // rust: spectator: bool,
    // rust: ) -> bool {
    // rust: shadow_draws_player && !(shader_pack && spectator)
}

/// `LivingEntityRenderer.solveBodyRot` for the rider of a living vehicle: the
/// body faces the vehicle's body, the head turning at most 85 degrees from it,
/// and past 50 degrees the body turns a fifth of the head's offset along.
pub fn rider_body_yaw(head: f32, vehicle_body: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let diff = wrap(head - vehicle_body).clamp(-85.0, 85.0);
    // rust: let mut body = head - diff;
    // rust: if diff.abs() > 50.0 {
    // rust: body += diff * 0.2;
}
    // rust: body
}

pub fn wrap(d: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let d = d % 360.0;
    // rust: if d >= 180.0 {
    // rust: d - 360.0
    // rust: } else if d < -180.0 {
    // rust: d + 360.0
    // rust: } else {
    // rust: d
}
}
    // rust: impl Game<'_> {
    /// `key.togglePerspective`.
    // rust: pub(super) fn cycle_camera(&mut self) {
    // rust: let previous = self.camera_type;
    // rust: self.camera_type = self.camera_type.cycle();
        // Minecraft.handleKeybinds: the chain follows the first-person view.
    // rust: if previous.first_person() != self.camera_type.first_person() {
    // rust: self.check_entity_post_effect(self.camera_type.first_person());
}
}
    /// `Camera.update` (`alignWithEntity` and `getMaxZoom`): the
    /// interpolated eye, or a point up to the camera distance behind (or in
    /// front of) it, pulled in where visual shapes are in the way. Returns the
    /// position, yaw and pitch to render from.
    // rust: pub(super) fn camera_view(&mut self, partial: f32) -> Option<(glam::DVec3, f32, f32)> {
        // Minecraft.cameraEntity: a server's spectator camera on a mob or
        // another player.
    // rust: let (entity, descending) = match self.camera_mob() {
    // rust: Some(m) => (super::remote_camera::mob_camera_entity(m), false),
    // rust: None => {
    // rust: let mut entity = self.player_camera_entity()?;
    // rust: if let Some(position) = self.remote_minecart_rider_position(partial) {
                    // Already evaluated at partial: do not linearly interpolate
                    // between tick endpoints across a corner a second time.
    // rust: entity.position = position;
    // rust: entity.previous = position;
}
    // rust: (entity, self.player.as_ref()?.shift_key_down)
}
}
    // rust: let mut view = self.view;
        // An emote pulls the camera back from the player's face (`game/emotes.rs`).
    // rust: let pull = self.emote_camera_pull(partial);
    // rust: let kind = match self.camera_type {
    // rust: CameraType::FirstPerson => horizon_client::camera::CameraType::FirstPerson,
    // rust: CameraType::ThirdPersonBack => horizon_client::camera::CameraType::ThirdPersonBack,
    // rust: CameraType::ThirdPersonFront => horizon_client::camera::CameraType::ThirdPersonFront,
}
    // rust: let context = CollisionContext::for_entity(
    // rust: CollisionEntity {
    // rust: identity: EntityIdentity(0),
    // rust: y: entity.position[1],
    // rust: descending,
    // rust: main_hand: Some(CollisionItem::EMPTY),
    // rust: },
    // rust: false,
    // rust: );
    // rust: let mut rays = VisualRays {
    // rust: scene: SceneCollisions {
    // rust: world: &self.world,
    // rust: binding: self.collision,
    // rust: subject: None,
    // rust: },
    // rust: facts: self.res.facts(),
    // rust: context,
}
    // rust: view.align_with_entity_distance(
    // rust: &entity,
    // rust: partial,
    // rust: kind,
    // rust: |distance| {
    // rust: let mut distance = distance * pull;
    // rust: self.native_camera_distance(partial, kind.is_mirrored(), &entity, &mut distance);
    // rust: distance
    // rust: },
    // rust: |from, to| {
    // rust: let hit = clip_world(
    // rust: &mut rays,
    // rust: Vec3::new(from[0], from[1], from[2]),
    // rust: Vec3::new(to[0], to[1], to[2]),
    // rust: RayBlockMode::Visual,
    // rust: RayFluidMode::None,
    // rust: 4096,
    // rust: )
    // rust: .ok()?;
    // rust: (!hit.miss).then_some([hit.hit.location.x, hit.hit.location.y, hit.hit.location.z])
    // rust: },
    // rust: );
    // rust: self.view = view;
    // rust: Some((
    // rust: glam::DVec3::from_array(view.position),
    // rust: view.y_rot,
    // rust: view.x_rot,
    // rust: ))
}
    /// The player as `Camera.alignWithEntity` sees it.
pub fn player_camera_entity(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (scale, distance) = {
    // rust: let p = self.player.as_mut()?;
    // rust: (
    // rust: p.attribute("minecraft:scale").unwrap_or(1.0) as f32,
    // rust: p.attribute("minecraft:camera_distance").unwrap_or(4.0),
    // rust: )
}
    // rust: let p = self.player.as_ref()?;
    // rust: let sleeping = self.sleeping.map(|head| {
    // rust: let state = self.world.block(head[0], head[1], head[2]);
    // rust: let props = self
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .state(state)
    // rust: .map(|s| &s.properties);
            // BedBlock.getBedOrientation as Direction.toYRot.
    // rust: props.and_then(|props| match props.get("facing").map(String::as_str) {
    // rust: Some("south") => Some(0.0),
    // rust: Some("west") => Some(90.0),
    // rust: Some("north") => Some(180.0),
    // rust: Some("east") => Some(270.0),
    // rust: _ => None,
    // rust: })
    // rust: });
        // Camera.setup: the living mount's scale and camera distance
        // attributes (the happy ghast's is 8, the default 4).
    // rust: let mount = self
    // rust: .riding
    // rust: .and_then(|id| self.mobs.iter().find(|m| m.id == id))
    // rust: .map(|m| {
    // rust: let attribute = |name: &str, default: f64| {
    // rust: m.kind.attributes.get(name).copied().unwrap_or(default)
}
    // rust: (
    // rust: attribute("minecraft:scale", 1.0) as f32,
    // rust: attribute("minecraft:camera_distance", 4.0),
    // rust: )
    // rust: });
        // AbstractBoat.positionRider turns a passenger by the boat's
        // deltaRotation after its yRotO was saved, and LocalPlayer.getViewYRot
        // interpolates a passenger's yaw: the boat's turn is spread over the
        // frames of a tick.
    // rust: let ride_turn = self
    // rust: .riding
    // rust: .and_then(|id| self.boats.iter().find(|b| b.id == id))
    // rust: .map_or_else(
    // rust: || {
    // rust: self.riding
    // rust: .and_then(|id| self.carts.iter().find(|c| c.id == id))
    // rust: .map_or(0.0, |c| c.passenger_yaw_delta)
    // rust: },
    // rust: |b| b.delta_rotation,
    // rust: );
    // rust: let entity = CameraEntity {
    // rust: position: [p.position.x, p.position.y, p.position.z],
    // rust: previous: [
    // rust: self.previous_position.x,
    // rust: self.previous_position.y,
    // rust: self.previous_position.z,
    // rust: ],
            // Entity.turn moves the old rotation with the new: the mouse
            // turns the view every frame without interpolation.
    // rust: x_rot: self.pitch,
    // rust: y_rot: self.yaw,
    // rust: x_rot_o: self.pitch,
    // rust: y_rot_o: self.yaw - ride_turn,
    // rust: eye_height: p.dimensions.eye_height,
    // rust: living: Some(LivingCamera {
    // rust: scale,
    // rust: camera_distance: distance,
    // rust: sleeping,
    // rust: dead: None,
    // rust: }),
    // rust: mount,
}
    // rust: Some(entity)
}
    /// Keep the player's model in step with the player (`LivingEntity.tick`
    /// body turning, `WalkAnimationState`, the swing and the pose).
    // rust: pub(super) fn tick_player_model(&mut self) {
    // rust: let scale = self
    // rust: .player
    // rust: .as_mut()
    // rust: .and_then(|p| p.attribute("minecraft:scale").ok())
    // rust: .unwrap_or(1.0) as f32;
    // rust: let Some(p) = self.player.as_ref() else {
    // rust: self.player_model = None;
    // rust: return;
}
    // rust: if self.player_model.is_none() {
    // rust: let Some(kind) = self.res.player_type().clone() else {
    // rust: return;
}
    // rust: let mut m = Mob::new(0, kind, p.position, self.yaw);
    // rust: m.head_pitch = self.pitch;
    // rust: self.player_model = Some(m);
}
    // rust: let pose = p.pose;
    // rust: let crouching = pose == Pose::Crouching;
    // rust: let position = p.position;
    // rust: let (fall_flying, fly_ticks, velocity) = (p.fall_flying, p.fall_fly_ticks, p.velocity);
    // rust: let spinning = p.auto_spin_attack_ticks > 0;
    // rust: let using = self.using.map(|(_, ticks)| ticks as i32 + 1).unwrap_or(0);
    // rust: let using_off_hand = self
    // rust: .using
    // rust: .is_some_and(|(slot, _)| slot == super::shield::OFFHAND_SLOT);
    // rust: let blocking = self
    // rust: .using
    // rust: .and_then(|(slot, _)| self.stack_in(slot))
    // rust: .is_some_and(|stack| self.blocks_attacks(stack).is_some());
    // rust: let charged = self.inventory[self.selected]
    // rust: .as_ref()
    // rust: .is_some_and(|s| s.data().is_some_and(|d| !d.charged.is_empty()));
    // rust: let charge_duration = self.inventory[self.selected]
    // rust: .as_ref()
    // rust: .map_or(25, |s| Self::charge_ticks(s).max(1)) as i32;
    // rust: let attack = (self.swing.old_animation, self.swing.animation);
    // rust: let swinging = self.swing.swinging();
        // currentSwing.hand().asArm(mainArm).
    // rust: let swing_right_arm = swinging.then(|| {
    // rust: (self.swing.attack_hand() == horizon_client::first_person::Hand::Main)
    // rust: != self.settings.main_hand_left
    // rust: });
        // LivingEntity.isVisuallySwimming and Entity.isInWater.
    // rust: let visually_swimming =
    // rust: p.pose == Pose::Swimming || (!p.fall_flying && p.pose == Pose::FallFlying);
    // rust: let in_water = p.fluids.was_touching_water;
    // rust: let in_lava = p.is_in_lava();
    // rust: let (yaw, pitch) = (self.yaw, self.pitch);
    // rust: let main = self.inventory[self.selected].clone();
    // rust: let off = self.offhand.as_ref().map(|s| s.item.clone());
    // rust: let armor = self.armor.clone();
    // rust: let riding = self.riding.is_some();
    // rust: let hurt = p.health.hurt_animation_time;
    // rust: let avatar = self.avatar;
    // rust: let previous_position = self.previous_position;
        // LivingEntity.getBedOrientation: the model lies in the bed as
        // another player's does (`villager::sleep_pose`).
    // rust: let bed = self.sleeping.map_or(0, |head| self.bed_facing(head));
    // rust: let spectator = self.spectator();
    // rust: let ridden = self.ridden_body();
    // rust: let Some(m) = self.player_model.as_mut() else {
    // rust: return;
}
    // rust: m.extra.ints[1] = bed;
    // rust: m.extra.model_scale = scale;
        // The crouch flag is still last tick's here.
    // rust: let (from, at) =
    // rust: player_model_positions(previous_position, position, m.extra.crouching, crouching);
    // rust: m.previous = from;
    // rust: m.position = at;
    // rust: let (dx, dz) = (at.x - m.previous.x, at.z - m.previous.z);
    // rust: let walked = player_walk_distance(m.previous, at);
    // rust: m.previous_yaw = m.yaw;
    // rust: m.previous_body_yaw = m.body_yaw;
    // rust: m.previous_head_yaw = m.head_yaw;
    // rust: m.previous_head_pitch = m.head_pitch;
    // rust: m.yaw = yaw;
    // rust: m.head_yaw = yaw;
    // rust: m.head_pitch = pitch;
    // rust: match ridden {
            // AbstractBoat.positionRider (clampRotation): the passenger's body
            // is set to the boat's yaw each tick.
    // rust: Some(RiddenBody::Boat(boat)) => m.body_yaw += wrap(boat - m.body_yaw),
            // A living vehicle's rider is drawn from its body
            // (`LivingEntityRenderer.solveBodyRot`).
    // rust: Some(RiddenBody::Living(body)) => {
    // rust: m.body_yaw += wrap(rider_body_yaw(yaw, body) - m.body_yaw);
}
            // A minecart's, a cushion's: the body turns as on foot.
    // rust: None => {
    // rust: let mut target = m.body_yaw;
    // rust: if dx * dx + dz * dz > 0.002_500_000_2 {
                    // LivingEntity.tick: walking backwards the body faces away from
                    // the walk direction, not along it.
    // rust: let walk = (dz.atan2(dx) as f32).to_degrees() - 90.0;
    // rust: let facing = (wrap(yaw) - walk).abs();
    // rust: target = if 95.0 < facing && facing < 265.0 {
    // rust: walk - 180.0
    // rust: } else {
    // rust: walk
}
}
    // rust: if swinging {
    // rust: target = yaw;
}
                // tickHeadTurn: ease toward the target, within 50 degrees of the head.
    // rust: m.body_yaw += wrap(target - m.body_yaw) * 0.3;
    // rust: let diff = wrap(yaw - m.body_yaw);
    // rust: if diff.abs() > 50.0 {
    // rust: m.body_yaw += diff - diff.signum() * 50.0;
}
}
}
    // rust: if riding {
            // LivingEntity.calculateEntityAnimation: a passenger stops the
            // walk animation (WalkAnimationState.stop), so the seat moving with
            // the vehicle does not swing the legs.
    // rust: m.previous_limb_speed = 0.0;
    // rust: m.limb_speed = 0.0;
    // rust: m.limb_position = 0.0;
    // rust: } else {
            // WalkAnimationState.update(min(distance * 4, 1), 0.4).
    // rust: m.previous_limb_speed = m.limb_speed;
    // rust: m.limb_speed += ((walked * 4.0).min(1.0) - m.limb_speed) * 0.4;
    // rust: m.limb_position += m.limb_speed;
}
        // Its idle swing holds with the world under `HORIZON_STILL`.
    // rust: if self.clock.runs_normally() || !self.clock.still() {
    // rust: m.age = m.age.wrapping_add(1);
}
    // rust: m.anim.attack_anim_o = attack.0;
    // rust: m.anim.attack_anim = attack.1;
    // rust: m.extra.set_main_hand_stack(main);
    // rust: m.extra.off_hand = off;
    // rust: m.extra.head = self.armor[0].as_ref().map(|s| s.item.clone());
    // rust: m.extra.chest = self.armor[1].as_ref().map(|s| s.item.clone());
    // rust: m.extra.legs = self.armor[2].as_ref().map(|s| s.item.clone());
    // rust: m.extra.feet = self.armor[3].as_ref().map(|s| s.item.clone());
        // The worn stacks, for the elytra's glint (`WingsLayer`).
    // rust: m.extra.armor = armor;
    // rust: m.extra.crouching = crouching;
        // Guests and server players take their pose from DATA_POSE, not here.
    // rust: m.extra.avatar_pose = pose;
        // What custom entity model animations read of the fluids (`is_in_water`, crawling).
    // rust: m.fluids.in_water = in_water;
    // rust: m.fluids.in_lava = in_lava;
    // rust: m.extra.passenger = riding;
    // rust: m.extra.previous_velocity = m.velocity;
    // rust: m.velocity = velocity;
    // rust: m.extra.fall_flying = fall_flying;
    // rust: m.extra.fall_fly_ticks = fly_ticks;
    // rust: m.extra.auto_spin_attack = spinning;
        // LivingEntity.DATA_ARROW_COUNT_ID and DATA_STINGER_COUNT_ID: as the
        // server synced them, else the local body's own.
    // rust: (m.extra.arrow_count, m.extra.stinger_count) = match &self.remote {
    // rust: Some(r) => (r.own_arrows, r.own_stingers),
    // rust: None => (self.combat.stuck.arrows, self.combat.stuck.stingers),
}
    // rust: m.extra.shoulder_parrots = match &self.remote {
    // rust: Some(r) => r.own_shoulders,
    // rust: None => shoulder_variants(self.level.player_extra.as_ref()),
}
    // rust: m.extra.main_hand_left = self.settings.main_hand_left;
    // rust: m.extra.hidden_model_parts = !self.settings.file.model_customisation() & 0x7F;
    // rust: m.extra.spectator = spectator;
    // rust: m.extra.using_item = using;
    // rust: m.extra.using_off_hand = using_off_hand;
    // rust: m.extra.blocking = blocking;
    // rust: m.extra.charged = charged;
    // rust: m.extra.ints[5] = charge_duration;
    // rust: m.extra.elytra.tick(fall_flying, crouching, velocity);
    // rust: m.extra.swim.tick(visually_swimming, in_water);
        // The local player's ClientAvatarState, its cloak in the model's frame
        // (the model stands 0.125 lower while crouching).
    // rust: m.extra.avatar = avatar;
    // rust: if crouching {
    // rust: m.extra.avatar.cloak[1] -= 0.125;
    // rust: m.extra.avatar.cloak_o[1] -= 0.125;
}
    // rust: m.extra.swing_right_arm = swing_right_arm;
    // rust: m.extra.swing_stab = self.swing.current.is_some_and(|c| c.animation.kind == 2);
    // rust: m.hurt_time = hurt;
}
    /// `Entity.turn` for the player, by the mouse, a pad, the arrow keys or an
    /// agent's `turn`.
    /// The model's old pitch is the player's `xRotO`, which the turn moves
    /// with `xRot` (`turn_rotation`).
    // rust: pub(super) fn turn_player(&mut self, xo: f64, yo: f64) {
    // rust: let pitch_o = self.player_model.as_ref().map(|m| m.previous_head_pitch);
    // rust: let rotation = turn_rotation(self.yaw, self.pitch, pitch_o, xo, yo);
    // rust: self.yaw = rotation.y_rot;
    // rust: self.pitch = rotation.x_rot;
    // rust: if let Some(m) = self.player_model.as_mut() {
    // rust: m.previous_head_pitch = rotation.x_rot_o;
    // rust: m.head_pitch = rotation.x_rot;
}
        // Entity.turn ends in AbstractBoat.onPassengerTurned: clampRotation
        // keeps the view within 105 degrees of the boat at every turn, not
        // only at the tick, so it never swings past and back.
    // rust: if let Some(b) = self
    // rust: .riding
    // rust: .and_then(|id| self.boats.iter().find(|b| b.id == id))
    // rust: {
    // rust: let delta = (self.yaw - b.yaw + 180.0).rem_euclid(360.0) - 180.0;
    // rust: self.yaw += delta.clamp(-105.0, 105.0) - delta;
}
}
    /// What the player rides that sets their body's yaw: a boat's yaw, or a
    /// living vehicle's body yaw. Minecarts and cushions leave it to the
    /// player's own turn.
pub fn ridden_body(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let id = self.riding?;
    // rust: if let Some(b) = self.boats.iter().find(|b| b.id == id) {
    // rust: return Some(RiddenBody::Boat(b.yaw));
}
    // rust: let m = self.mobs.iter().find(|m| m.id == id)?;
    // rust: Some(RiddenBody::Living(m.body_yaw))
}
    /// `Entity.setOldRot` after a server sets the player's rotation
    /// (`handleRotatePlayer`): the model's head snaps to it instead of easing
    /// in over the next tick.
    // rust: pub(super) fn snap_player_model_pitch(&mut self) {
    // rust: let pitch = self.pitch;
    // rust: if let Some(m) = self.player_model.as_mut() {
    // rust: m.previous_head_pitch = pitch;
    // rust: m.head_pitch = pitch;
}
}
    /// `LevelExtractor`'s skip of the camera entity: the player's own body
    /// is drawn unless the camera is in first person, or while it sleeps.
    // rust: pub(super) fn own_body_in_view(&self) -> bool {
    // rust: !self.camera_type.first_person() || self.sleeping.is_some()
}
    /// Whether the player's own model shows in the world view (its body or,
    /// while invisible, only its armour and held items).
    // rust: pub(super) fn player_model_shown(&self) -> bool {
    // rust: (self.own_body_in_view()
    // rust: || shadow_pass_takes_own_model(
    // rust: self.pack_shadow_casters.1,
    // rust: self.pack_ids.is_some(),
    // rust: self.spectator(),
    // rust: ))
    // rust: && self
    // rust: .player
    // rust: .as_ref()
    // rust: .is_some_and(|p| !p.health.dead_or_dying())
}
    /// The player's own team: a server's client is in it by its profile name.
pub fn own_team(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match &self.remote {
    // rust: Some(r) => self.score.board.players_team(&r.profile_name),
    // rust: None => self.player_team(),
}
}
    /// `Entity.isInvisible` for the player itself (`own_invisible`).
    // rust: pub(super) fn own_invisible(&self) -> bool {
    // rust: own_invisible(
    // rust: &self.potions.effects,
    // rust: self.remote.as_ref().is_some_and(|r| r.own_invisible),
    // rust: )
}
    /// Whether the player's own body is drawn (`body_visible`).
    // rust: pub(super) fn own_body_visible(&self) -> bool {
    // rust: body_visible(self.own_invisible(), self.own_team())
}
    /// The player's model for the entity pass in third person.
    // rust: pub(super) fn player_model_geometry(
    // rust: &self,
    // rust: camera: glam::DVec3,
    // rust: alpha: f64,
    // rust: out: &mut Vec<horizon_client::mesher::Vertex>,
    // rust: ) {
    // rust: if !self.player_model_shown() {
    // rust: return;
}
    // rust: let Some(m) = self.player_model.as_ref() else {
    // rust: return;
}
    // rust: let eye = self
    // rust: .player
    // rust: .as_ref()
    // rust: .map_or_else(|| m.eye_height(), |p| f64::from(p.dimensions.eye_height));
    // rust: let probe = entity_light_block(m.position, m.extra.crouching, eye);
    // rust: let light = self.world.light(probe[0], probe[1], probe[2]);
    // rust: let packed = (u32::from(light >> 4) * 16) | ((u32::from(light & 15) * 16) << 8);
    // rust: let atlas = &self.gui.atlas;
    // rust: let lookup = |name: &str| atlas.sprites.get(name).map(|r| [r.u0, r.v0, r.u1, r.v1]);
    // rust: let start = out.len();
    // rust: let body = self.own_body_visible();
        // `native_player_submit`: a native mod's own model for this player,
        // in place of the vanilla one and its layers (an invisible player is
        // not asked, as for the others).
    // rust: let name = self.own_profile_name();
    // rust: let who = NativePlayerRender {
    // rust: name: &name,
    // rust: local: true,
}
    // rust: if body && self.mod_player_geometry(m, who, alpha as f32, camera, packed, out) {
    // rust: return;
}
        // A spectator still draws its own model in third person: the poses'
        // visibility (set by player_model_visibility) hides body parts, and
        // translucent_body marks the body OIT for the ghostly look. Only first
        // person and dead players skip it.
    // rust: let render = if body || self.spectator() {
    // rust: horizon_client::mobs::render::render_with
    // rust: } else {
    // rust: horizon_client::mobs::render::render_layers
}
    // rust: render(
    // rust: m,
    // rust: alpha as f32,
    // rust: camera,
    // rust: &lookup,
    // rust: packed,
    // rust: self.res.mob_data(),
    // rust: &self.player_armor_layers(),
    // rust: out,
    // rust: );
        // AvatarRenderer.shouldRenderLayers: a spectator draws no layers.
    // rust: if horizon_client::mobs::render::layers_shown(m) {
    // rust: let chest = self.armor[1].as_ref().map(|s| &*s.item);
            // CapeLayer: no cape on an invisible player (`isInvisible`, whoever looks).
    // rust: if !self.own_invisible() {
    // rust: self.player_cape_geometry(m, chest, camera, alpha as f32, packed, out);
}
    // rust: self.player_ears_geometry(
    // rust: m,
    // rust: &self.own_profile_name(),
    // rust: camera,
    // rust: alpha as f32,
    // rust: packed,
    // rust: out,
    // rust: );
    // rust: if horizon_cosmetics::enabled() {
    // rust: let base = horizon_client::mobs::render::base_transform(m, alpha as f32, camera);
    // rust: self.cosmetics_geometry(
    // rust: m,
    // rust: true,
    // rust: base,
    // rust: Some(camera),
    // rust: alpha as f32,
    // rust: packed,
    // rust: false,
    // rust: out,
    // rust: );
}
    // rust: self.player_elytra_geometry(m, chest, camera, alpha as f32, packed, out);
    // rust: self.spin_attack_geometry(m, camera, alpha as f32, packed, out);
    // rust: self.shoulder_parrots_geometry(m, camera, alpha as f32, packed, out);
    // rust: self.stuck_in_body_geometry(m, self.own_entity_id(), camera, alpha as f32, packed, out);
    // rust: self.held_item_geometry(m, camera, alpha, packed, true, None, out);
            // CustomHeadLayer: a pumpkin, skull or other head item.
    // rust: self.head_item_geometry(m, camera, alpha, packed, true, out);
            // `native_mob_layer`: a native mod's layer, over the vanilla ones.
    // rust: self.mod_mob_layer_geometry(m, Some(who), alpha as f32, camera, packed, out);
}
        // LivingEntity.isCurrentlyGlowing: the Glowing effect.
    // rust: let vanilla = self
    // rust: .potions
    // rust: .effects
    // rust: .get("glowing")
    // rust: .map(|_| super::glowing::team_color(self.own_team()));
    // rust: let id = u32::try_from(self.own_entity_id()).unwrap_or(0);
    // rust: if let Some(color) = self.entity_outline(id, "minecraft:player", vanilla) {
            // LivingEntityRenderer.getRenderType: an invisible glowing body
            // still draws its outline.
    // rust: if !body {
    // rust: let mut silhouette = Vec::new();
    // rust: horizon_client::mobs::render::render(
    // rust: m,
    // rust: alpha as f32,
    // rust: camera,
    // rust: &lookup,
    // rust: packed,
    // rust: self.res.mob_data(),
    // rust: &mut silhouette,
    // rust: );
    // rust: self.mark_outline(&silhouette, color);
}
    // rust: self.mark_outline(&out[start..], color);
}
}
    /// `extractEntityInInventoryFollowsMouse`: the player in the box
    /// `[x0, x1) x [y0, y1)`, `size` pixels per block, turned toward the
    /// cursor; drawn with a depth buffer and back-face culling.
    // rust: pub(super) fn draw_player_preview(
    // rust: &self,
    // rust: batch: &mut HudBatch,
    // rust: x0: f32,
    // rust: y0: f32,
    // rust: x1: f32,
    // rust: y1: f32,
    // rust: size: f32,
    // rust: offset_y: f32,
    // rust: ) {
    // rust: let Some(m) = self.player_model.as_ref() else {
    // rust: return;
}
    // rust: if self
    // rust: .player
    // rust: .as_ref()
    // rust: .is_some_and(|p| p.health.dead_or_dying())
    // rust: {
    // rust: return;
}
    // rust: let (cx, cy) = ((x0 + x1) / 2.0, (y0 + y1) / 2.0);
    // rust: let x_angle = ((cx - self.cursor.0) / 40.0).atan();
    // rust: let y_angle = ((cy - self.cursor.1) / 40.0).atan();
    // rust: let mut m = m.clone();
        // `extractEntityInInventory` divides the size by the entity's scale: the
        // preview is the same size whatever the player's scale.
    // rust: m.extra.model_scale = 0.0;
        // The render state: still, facing out, the head toward the cursor.
    // rust: m.previous = m.position;
    // rust: m.body_yaw = 180.0 + x_angle * 20.0;
    // rust: m.previous_body_yaw = m.body_yaw;
    // rust: m.head_yaw = m.body_yaw + x_angle * 20.0;
    // rust: m.previous_head_yaw = m.head_yaw;
    // rust: m.head_pitch = -y_angle * 20.0;
    // rust: m.previous_head_pitch = m.head_pitch;
    // rust: m.position.y += 0.125 * f64::from(u8::from(m.extra.crouching));
    // rust: m.previous = m.position;
    // rust: let camera = glam::DVec3::new(m.position.x, m.position.y, m.position.z);
    // rust: let atlas = &self.gui.atlas;
    // rust: let lookup = |name: &str| atlas.sprites.get(name).map(|r| [r.u0, r.v0, r.u1, r.v1]);
    // rust: let mut verts = Vec::new();
        // A spectator preview still draws its own model: the poses'
        // visibility hides body parts, leaving the head and its layers.
    // rust: let render = if self.own_body_visible() || self.spectator() {
    // rust: horizon_client::mobs::render::render_with
    // rust: } else {
    // rust: horizon_client::mobs::render::render_layers
}
        // A screen preview: custom entity model animations see is_in_gui = 1.
    // rust: horizon_client::mobs::cem_anim::in_gui(|| {
    // rust: render(
    // rust: &m,
    // rust: 1.0,
    // rust: camera,
    // rust: &lookup,
    // rust: 240 | 240 << 8,
    // rust: self.res.mob_data(),
    // rust: &self.player_armor_layers(),
    // rust: &mut verts,
    // rust: );
    // rust: });
    // rust: let chest = self.armor[1].as_ref().map(|s| &*s.item);
    // rust: if !self.own_invisible() {
    // rust: self.player_cape_geometry(&m, chest, camera, 1.0, 240 | 240 << 8, &mut verts);
}
    // rust: self.player_ears_geometry(
    // rust: &m,
    // rust: &self.own_profile_name(),
    // rust: camera,
    // rust: 1.0,
    // rust: 240 | 240 << 8,
    // rust: &mut verts,
    // rust: );
    // rust: if horizon_cosmetics::enabled() {
    // rust: let base = horizon_client::mobs::render::base_transform(&m, 1.0, camera);
    // rust: self.cosmetics_geometry(&m, true, base, None, 1.0, 240 | 240 << 8, false, &mut verts);
}
        // `WingsLayer` draws through `RenderTypes.armorCutoutNoCull`: the
        // wings' faces show from both sides (the elytra texture is empty on
        // the face that looks at the body).
    // rust: let wings_start = verts.len();
    // rust: self.player_elytra_geometry(&m, chest, camera, 1.0, 240 | 240 << 8, &mut verts);
    // rust: let wings = wings_start..verts.len();
    // rust: self.shoulder_parrots_geometry(&m, camera, 1.0, 240 | 240 << 8, &mut verts);
    // rust: self.held_item_geometry(&m, camera, 1.0, 240 | 240 << 8, false, None, &mut verts);
    // rust: self.head_item_geometry(&m, camera, 1.0, 240 | 240 << 8, false, &mut verts);
    // rust: let height = if m.extra.crouching { 1.5 } else { 1.8 };
        // PictureInPictureRenderer: the box centre, (size, size, -size);
        // then the translation and Rz(pi) * Rx(y_angle * 20 degrees).
    // rust: let gui = glam::Mat4::from_translation(glam::Vec3::new(cx, cy, 0.0))
    // rust: * glam::Mat4::from_scale(glam::Vec3::new(size, size, -size))
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(0.0, height / 2.0 + offset_y, 0.0))
    // rust: * glam::Mat4::from_rotation_z(std::f32::consts::PI)
    // rust: * glam::Mat4::from_rotation_x((y_angle * 20.0).to_radians());
    // rust: let fire = self
    // rust: .player
    // rust: .as_ref()
    // rust: .filter(|p| p.fire_ticks > 0 && !p.spectator)
    // rust: .map(|p| (p.dimensions.width, p.dimensions.height));
    // rust: let quads = player_preview_quads_no_cull(verts, gui, fire, &atlas.sprites, wings);
    // rust: let start = batch.vertices.len();
    // rust: for (_, p, uv, color) in quads {
    // rust: batch.quad_3d(p, uv, color);
}
    // rust: batch.depth_since(start, [x0, y0, x1, y1]);
}
    /// The survival inventory's player box (`InventoryScreen`).
    // rust: pub(super) fn draw_inventory_player(&self, batch: &mut HudBatch, ox: f32, oy: f32) {
    // rust: if self.screen == Screen::Inventory {
    // rust: self.draw_player_preview(
    // rust: batch,
    // rust: ox + 26.0,
    // rust: oy + 8.0,
    // rust: ox + 75.0,
    // rust: oy + 78.0,
    // rust: 30.0,
    // rust: 0.0625,
    // rust: );
}
}
}

    // rust: impl Game<'_> {
    /// `WingsLayer` for a player wearing `chest`.
    // rust: pub(super) fn player_elytra_geometry(
    // rust: &self,
    // rust: m: &Mob,
    // rust: chest: Option<&str>,
    // rust: camera: glam::DVec3,
    // rust: partial: f32,
    // rust: light: u32,
    // rust: out: &mut Vec<horizon_client::mesher::Vertex>,
    // rust: ) {
    // rust: let stack = m.extra.armor[1]
    // rust: .as_ref()
    // rust: .filter(|s| chest == Some(&*s.item));
    // rust: self.wings_geometry(
    // rust: chest,
    // rust: stack,
    // rust: m.cape.as_deref(),
    // rust: false,
    // rust: horizon_client::mobs::render::base_transform(m, partial, camera),
    // rust: m.extra.elytra.angles(partial),
    // rust: m.extra.crouching,
    // rust: light,
    // rust: self.wings_overlay(stack),
    // rust: out,
    // rust: );
}
    /// `WingsLayer` draws through `EquipmentLayerRenderer.renderLayers`: the
    /// armour glint when the worn elytra `hasFoil()`.
    // rust: pub(super) fn wings_overlay(&self, stack: Option<&horizon_client::items::ItemStack>) -> u32 {
    // rust: let item_glint = |item: &str| {
    // rust: let props = &self.res.items().enchantments.props;
    // rust: props.get(item).is_some_and(|p| p.glint)
}
    // rust: match stack {
    // rust: Some(s) if s.has_foil(item_glint(&s.item)) => horizon_client::mobs::render::ARMOR_GLINT,
    // rust: _ => 0,
}
}
    /// `WingsLayer.submit` for any wearer: the wings of `chest`'s equipment
    /// asset on `base` (the wearer's model transform), `baby` for the baby
    /// elytra model. `cape` is a player's own cape texture, which has its
    /// elytra (`WingsLayer.getPlayerElytraTexture`). `stack` is the worn
    /// stack when known: an OptiFine CIT elytra rule for it replaces the
    /// texture, the cape's too, as OptiFine's `LayerElytra` does.
    // rust: pub(super) fn wings_geometry(
    // rust: &self,
    // rust: chest: Option<&str>,
    // rust: stack: Option<&horizon_client::items::ItemStack>,
    // rust: cape: Option<&str>,
    // rust: baby: bool,
    // rust: base: glam::Mat4,
    // rust: angles: [f32; 3],
    // rust: crouching: bool,
    // rust: light: u32,
    // rust: overlay: u32,
    // rust: out: &mut Vec<horizon_client::mesher::Vertex>,
    // rust: ) {
    // rust: let Some(asset) = chest
    // rust: .and_then(|item| self.items().get(item))
    // rust: .and_then(|i| i.equip_asset.as_ref())
    // rust: else {
    // rust: return;
}
    // rust: let assets = &self.armor_stand_assets;
    // rust: let Some((texture, _)) = assets
    // rust: .equipment
    // rust: .get(asset)
    // rust: .and_then(|k| k.get("wings"))
    // rust: .and_then(|layers| layers.first())
    // rust: else {
    // rust: return;
}
    // rust: let sprites = &self.gui.atlas.sprites;
    // rust: let rule = stack.and_then(|s| self.cit_worn_rule(horizon_client::cit::Kind::Elytra, s));
    // rust: let rect = horizon_client::cit_armor::wings(rule, cape, |s| sprites.get(s));
    // rust: let (Some(model), Some(rect)) = (
    // rust: assets
    // rust: .player
    // rust: .get(if baby { "elytra_baby" } else { "elytra" }),
    // rust: rect.or_else(|| sprites.get(texture)),
    // rust: ) else {
    // rust: return;
}
    // rust: let base = base * glam::Mat4::from_translation(glam::Vec3::new(0.0, 0.0, 0.125));
    // rust: let pose = |part: &horizon_client::mobs::Part| {
    // rust: let mut p = part.pose;
    // rust: if part.name == "left_wing" || part.name == "right_wing" {
    // rust: let invert = if part.name == "left_wing" { 1.0 } else { -1.0 };
    // rust: p[1] = if crouching { 3.0 } else { 0.0 };
    // rust: p[3] = angles[0];
    // rust: p[4] = invert * angles[1];
    // rust: p[5] = invert * angles[2];
}
    // rust: p
}
    // rust: horizon_client::mobs::render_model(
    // rust: model,
    // rust: base,
    // rust: &pose,
    // rust: [rect.u0, rect.v0, rect.u1, rect.v1],
    // rust: light,
    // rust: overlay,
    // rust: out,
    // rust: );
        // The elytra texture's OptiFine emissive overlay (not a cape's), full bright.
    // rust: let glow = cape
    // rust: .and_then(|c| sprites.get(c))
    // rust: .is_none()
    // rust: .then(|| {
    // rust: let emissive = self
    // rust: .res
    // rust: .mob_data()
    // rust: .emissive
    // rust: .read()
    // rust: .unwrap_or_else(std::sync::PoisonError::into_inner);
    // rust: emissive
    // rust: .overlay(texture)
    // rust: .and_then(|e| sprites.get(e))
    // rust: .copied()
    // rust: })
    // rust: .flatten();
    // rust: if let Some(g) = glow {
    // rust: horizon_client::mobs::render_model(
    // rust: model,
    // rust: base,
    // rust: &pose,
    // rust: [g.u0, g.v0, g.u1, g.v1],
    // rust: horizon_client::mobs::render::FULL_BRIGHT,
    // rust: 0,
    // rust: out,
    // rust: );
}
}
    /// `CapeLayer` for a player wearing `chest`: no cape under an elytra's
    /// wings, and moved out over a chestplate.
    // rust: pub(super) fn player_cape_geometry(
    // rust: &self,
    // rust: m: &Mob,
    // rust: chest: Option<&str>,
    // rust: camera: glam::DVec3,
    // rust: partial: f32,
    // rust: light: u32,
    // rust: out: &mut Vec<horizon_client::mesher::Vertex>,
    // rust: ) {
    // rust: let Some(rect) = m
    // rust: .cape
    // rust: .as_deref()
    // rust: .and_then(|c| self.gui.atlas.sprites.get(c))
    // rust: else {
    // rust: return;
}
    // rust: if horizon_client::mobs::trader::is_invisible(m) {
    // rust: return;
}
    // rust: let layers = chest
    // rust: .and_then(|item| self.res.items().get(item))
    // rust: .and_then(|i| i.equip_asset.as_ref())
    // rust: .and_then(|asset| self.armor_stand_assets.equipment.get(asset));
    // rust: if layers.is_some_and(|k| k.contains_key("wings")) {
    // rust: return;
}
    // rust: let mut base = horizon_client::mobs::render::base_transform(m, partial, camera);
    // rust: if layers.is_some_and(|k| k.contains_key("humanoid")) {
    // rust: base *= glam::Mat4::from_translation(glam::Vec3::new(0.0, -0.053125, 0.06875));
}
    // rust: horizon_client::mobs::render::cape(
    // rust: m,
    // rust: partial,
    // rust: base,
    // rust: [rect.u0, rect.v0, rect.u1, rect.v1],
    // rust: light,
    // rust: self.res.mob_data(),
    // rust: out,
    // rust: );
}
    /// `Deadmau5EarsLayer` (`AbstractClientPlayer.showExtraEars`): the ears
    /// of a player whose profile name is `deadmau5`, in the player's skin.
    // rust: pub(super) fn player_ears_geometry(
    // rust: &self,
    // rust: m: &Mob,
    // rust: name: &str,
    // rust: camera: glam::DVec3,
    // rust: partial: f32,
    // rust: light: u32,
    // rust: out: &mut Vec<horizon_client::mesher::Vertex>,
    // rust: ) {
    // rust: if name != "deadmau5" {
    // rust: return;
}
    // rust: let sprites = &self.gui.atlas.sprites;
        // The body's own fallback: a skin with no sprite draws the default.
    // rust: let Some(rect) = m
    // rust: .skin
    // rust: .as_deref()
    // rust: .and_then(|s| sprites.get(s))
    // rust: .or_else(|| sprites.get(&m.kind.texture))
    // rust: else {
    // rust: return;
}
    // rust: horizon_client::mobs::render::ears(
    // rust: m,
    // rust: partial,
    // rust: horizon_client::mobs::render::base_transform(m, partial, camera),
    // rust: [rect.u0, rect.v0, rect.u1, rect.v1],
    // rust: light,
    // rust: self.res.mob_data(),
    // rust: out,
    // rust: );
}
    /// The entity id the local player has on its server.
pub fn own_entity_id(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.remote.as_ref().map_or(0, |r| r.entity_id)
}
    /// `ArrowLayer` and `BeeStingerLayer` (`StuckInBodyLayer`) for a player:
    /// the arrows and bee stingers stuck in the body, placed from the entity
    /// id `id`.
    // rust: pub(super) fn stuck_in_body_geometry(
    // rust: &self,
    // rust: m: &Mob,
    // rust: id: i32,
    // rust: camera: glam::DVec3,
    // rust: partial: f32,
    // rust: light: u32,
    // rust: out: &mut Vec<horizon_client::mesher::Vertex>,
    // rust: ) {
    // rust: let sprites = &self.gui.atlas.sprites;
    // rust: let layers = [
    // rust: (
    // rust: m.extra.arrow_count,
    // rust: false,
    // rust: self.arrow_model.as_ref(),
    // rust: "entity/projectiles/arrow",
    // rust: ),
    // rust: (
    // rust: m.extra.stinger_count,
    // rust: true,
    // rust: self.bee_stinger_model.as_ref(),
    // rust: "entity/bee/bee_stinger",
    // rust: ),
    // rust: ];
    // rust: for (count, on_surface, model, texture) in layers {
    // rust: let (true, Some(model), Some(rect)) = (count > 0, model, sprites.get(texture)) else {
    // rust: continue;
}
    // rust: horizon_client::mobs::render::stuck_in_body(
    // rust: m,
    // rust: id,
    // rust: partial,
    // rust: camera,
    // rust: self.res.mob_data(),
    // rust: count,
    // rust: on_surface,
    // rust: model,
    // rust: [rect.u0, rect.v0, rect.u1, rect.v1],
    // rust: light,
    // rust: out,
    // rust: );
}
}
    /// `ParrotOnShoulderLayer`: the parrots the player keeps in its
    /// `ShoulderEntityLeft` and `ShoulderEntityRight` (game/shoulders.rs).
    // rust: pub(super) fn shoulder_parrots_geometry(
    // rust: &self,
    // rust: m: &Mob,
    // rust: camera: glam::DVec3,
    // rust: partial: f32,
    // rust: light: u32,
    // rust: out: &mut Vec<horizon_client::mesher::Vertex>,
    // rust: ) {
    // rust: let Some(parrot) = self.res.mob_types().get("minecraft:parrot") else {
    // rust: return;
}
    // rust: let atlas = &self.gui.atlas;
    // rust: let lookup = |name: &str| atlas.sprites.get(name).map(|r| [r.u0, r.v0, r.u1, r.v1]);
    // rust: let base = horizon_client::mobs::render::base_transform(m, partial, camera);
    // rust: for left in [true, false] {
    // rust: if let Some(variant) = m.extra.shoulder_parrots[usize::from(!left)] {
    // rust: horizon_client::mobs::render::shoulder_parrot(
    // rust: m, parrot, variant, left, partial, base, &lookup, light, out,
    // rust: );
}
}
}
    /// `SpinAttackEffectLayer`: Riptide's two boxes turning around a spinning
    /// player (`SpinAttackEffectModel.setupAnim`).
    // rust: pub(super) fn spin_attack_geometry(
    // rust: &self,
    // rust: m: &Mob,
    // rust: camera: glam::DVec3,
    // rust: partial: f32,
    // rust: light: u32,
    // rust: out: &mut Vec<horizon_client::mesher::Vertex>,
    // rust: ) {
    // rust: if !m.extra.auto_spin_attack {
    // rust: return;
}
    // rust: let (Some(model), Some(rect)) = (
    // rust: self.res.spin_attack().as_ref(),
    // rust: self.gui.atlas.sprites.get("entity/trident/trident_riptide"),
    // rust: ) else {
    // rust: return;
}
    // rust: let age = m.age as f32 + partial;
    // rust: horizon_client::mobs::render_model(
    // rust: model,
    // rust: horizon_client::mobs::render::base_transform(m, partial, camera),
    // rust: &|part| {
    // rust: let mut p = part.pose;
    // rust: if let Some(i) = part
    // rust: .name
    // rust: .strip_prefix("box")
    // rust: .and_then(|i| i.parse::<u8>().ok())
    // rust: {
    // rust: let angle = age * -(45.0 + f32::from(i + 1) * 5.0);
    // rust: p[4] = wrap(angle).to_radians();
}
    // rust: p
    // rust: },
    // rust: [rect.u0, rect.v0, rect.u1, rect.v1],
    // rust: light,
    // rust: 0,
    // rust: out,
    // rust: );
}
}

/// `Lighting.Entry.ENTITY_IN_UI` through the entity shader's
/// `minecraft_mix_light`: the two inventory lights, (0.2, -1, 1) and
/// (-0.2, -1, 0), with the 0.6 light power and 0.4 ambient. `normal` is the
/// face's outward normal in the preview's screen space (x right, y down, z
/// towards the viewer), where a face that looks up has a negative y.
pub fn entity_in_ui_shade(normal: glam::Vec3) f {
    // Implementation ported from Horizon
    return undefined;
}
pub const LIGHT_0: glam::Vec3 = glam::Vec3::new(0.2, -1.0, 1.0);
pub const LIGHT_1: glam::Vec3 = glam::Vec3::new(-0.2, -1.0, 0.0);
    // rust: let light = LIGHT_0.normalize().dot(normal).max(0.0) + LIGHT_1.normalize().dot(normal).max(0.0);
    // rust: (light * 0.6 + 0.4).min(1.0)
}

    // rust: pub(super) fn player_preview_quads(
    // rust: verts: Vec<horizon_client::mesher::Vertex>,
    // rust: gui: glam::Mat4,
    // rust: fire: Option<(f32, f32)>,
    // rust: sprites: &std::collections::HashMap<String, horizon_client::hud::Rect>,
    // rust: ) -> Vec<(f32, [[f32; 3]; 4], [[f32; 2]; 4], u32)> {
    // rust: player_preview_quads_no_cull(verts, gui, fire, sprites, 0..0)
}

/// `player_preview_quads` where the faces of the vertices in `no_cull` are
/// kept when they look away (a `NoCull` render type); their light still comes
/// from the face's own outward normal, as the vertex normal gives it.
    // rust: pub(super) fn player_preview_quads_no_cull(
    // rust: mut verts: Vec<horizon_client::mesher::Vertex>,
    // rust: gui: glam::Mat4,
    // rust: fire: Option<(f32, f32)>,
    // rust: sprites: &std::collections::HashMap<String, horizon_client::hud::Rect>,
    // rust: no_cull: std::ops::Range<usize>,
    // rust: ) -> Vec<(f32, [[f32; 3]; 4], [[f32; 2]; 4], u32)> {
    // rust: let flame_start = verts.len();
    // rust: if let Some((width, height)) = fire {
    // rust: horizon_client::fire_render::flames(
    // rust: [0.0; 3],
    // rust: width,
    // rust: height,
    // rust: glam::DVec3::ZERO,
    // rust: 0.0,
    // rust: sprites,
    // rust: 0xff,
    // rust: &mut verts,
    // rust: );
}
    // rust: let mut quads: Vec<(f32, [[f32; 3]; 4], [[f32; 2]; 4], u32)> = Vec::new();
    // rust: for (index, q) in verts.as_chunks::<4>().0.iter().enumerate() {
    // rust: let p: [glam::Vec3; 4] =
    // rust: std::array::from_fn(|i| gui.transform_point3(glam::Vec3::from_array(q[i].pos)));
    // rust: let n = (p[1] - p[0]).cross(p[2] - p[0]);
        // The winding gives inward normals: faces with n.z >= 0 point away.
    // rust: let back = n.z >= 0.0;
    // rust: if back && !no_cull.contains(&(index * 4)) {
    // rust: continue;
}
    // rust: let n = n.normalize_or_zero();
    // rust: let shade = if index * 4 >= flame_start {
    // rust: 1.0
    // rust: } else {
    // rust: entity_in_ui_shade(-n)
}
    // rust: let c = q[0].color;
    // rust: let ch = |s: u32| ((((c >> s) & 255) as f32 * shade) as u32) << s;
    // rust: let color = (c & 0xFF00_0000) | ch(0) | ch(8) | ch(16);
    // rust: let depth = p.iter().map(|v| v.z).sum::<f32>() / 4.0;
    // rust: let (mut pos, mut uv) = (p.map(|v| v.to_array()), std::array::from_fn(|i| q[i].uv));
    // rust: if back {
            // Seen from behind: the same quad in the opposite winding.
    // rust: pos.reverse();
    // rust: uv.reverse();
}
    // rust: quads.push((depth, pos, uv, color));
}
    // Keep far-to-near order for translucent faces; opaque overlap uses depth.
    // rust: quads.sort_by(|a, b| a.0.total_cmp(&b.0));
    // rust: quads
}

/// `Entity.turn` adds the turn to `xRotO` as well as to `xRot`, so the local
/// player's `getXRot(partialTick)` follows the mouse every frame instead of
/// easing in over a tick (#3844), while a change the tick made itself (the
/// pitch a sleeper lies at) still eases in. `pitch_o` is the model's old
/// pitch; without a model the old pitch is the pitch.
pub fn turn_rotation(yaw: f32, pitch: f32, pitch_o: ?f32, xo: f64, yo: f64) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut rotation = Rotation {
    // rust: x_rot: pitch,
    // rust: y_rot: yaw,
    // rust: x_rot_o: pitch_o.unwrap_or(pitch),
    // rust: y_rot_o: yaw,
}
    // rust: rotation.turn(xo, yo);
    // rust: rotation
}

/// `EntityRenderer.getPackedLightCoords` (`Entity.getLightProbePosition`):
/// the block containing the entity's eye position, undoing
/// `AvatarRenderer.getRenderOffset`'s 0.125 crouch drop on the model position.
    // rust: pub(super) fn entity_light_block(position: Vec3, crouching: bool, eye_height: f64) -> [i32; 3] {
    // rust: let y = position.y + if crouching { 0.125 } else { 0.0 } + eye_height;
    // rust: [
    // rust: position.x.floor() as i32,
    // rust: y.floor() as i32,
    // rust: position.z.floor() as i32,
    // rust: ]
}

/// The player's model's old and new positions for a tick: the player's old
/// (`Entity.xo`, `yo`, `zo`) and new positions, each 0.125 lower while
/// crouching. The model is the player itself in vanilla, so
/// `EntityRenderer.extractRenderState` lerps it from the same old position
/// `Camera.setup` does, however far it moved: at Levitation 255 (12.75 blocks
/// a tick) the body keeps up with the camera. A teleport or respawn resets
/// the old position, and the model jumps with it.
    // rust: fn player_model_positions(
    // rust: previous_position: Vec3,
    // rust: position: Vec3,
    // rust: was_crouching: bool,
    // rust: crouching: bool,
    // rust: ) -> (Vec3, Vec3) {
    // rust: let drop =
    // rust: |p: Vec3, crouching: bool| Vec3::new(p.x, p.y - if crouching { 0.125 } else { 0.0 }, p.z);
    // rust: (
    // rust: drop(previous_position, was_crouching),
    // rust: drop(position, crouching),
    // rust: )
}

/// The distance `LivingEntity.calculateEntityAnimation` walks the player's
/// model for a move from `from` to `to`. `omnidirectionalAirMover()` is false
/// for every player (`Entity`'s, not overridden), so only the horizontal
/// distance counts, flying and gliding included: rising or sinking straight
/// up or down leaves the legs and arms still.
pub fn player_walk_distance(from: Vec3, to: Vec3) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (dx, dz) = (to.x - from.x, to.z - from.z);
    // rust: (dx * dx + dz * dz).sqrt() as f32
}

    // rust: mod preview_tests {
//     use super::*;
pub fn a_spectators_own_model_stays_out_of_a_shader_packs_shadow_pass() void {
}
        // First person, a shader pack whose shadow pass draws the player: a spectator's head
        // isn't in Iris's map (#8464); the other game modes keep the model, as before.
    // rust: assert!(!shadow_pass_takes_own_model(true, true, true));
    // rust: assert!(shadow_pass_takes_own_model(true, true, false));
        // A native pack's shadow keeps the first-person model, a spectator's too.
    // rust: assert!(shadow_pass_takes_own_model(true, false, true));
        // No shadow pass that draws the player: nothing to take.
    // rust: assert!(!shadow_pass_takes_own_model(false, true, false));
}
pub fn the_player_model_rises_with_the_camera_at_levitation_255() void {
}
        // LivingEntity.travel at Levitation 255: 0.05 * 255 blocks a tick.
    // rust: let from = Vec3::new(0.5, 80.0, 0.5);
    // rust: let to = Vec3::new(0.5, 92.75, 0.5);
        // The camera lerps from the old position: so does the body.
    // rust: assert_eq!(
    // rust: player_model_positions(from, to, false, false),
    // rust: (from, to),
    // rust: "the body jumps instead of rising (#3616)"
    // rust: );
        // Any distance, crouching on both ends.
    // rust: let far = Vec3::new(40.5, 80.0, 0.5);
    // rust: assert_eq!(
    // rust: player_model_positions(from, far, true, true),
    // rust: (Vec3::new(0.5, 79.875, 0.5), Vec3::new(40.5, 79.875, 0.5)),
    // rust: );
        // A teleport resets the old position to the new one: no sweep.
    // rust: assert_eq!(player_model_positions(to, to, false, false), (to, to));
}
pub fn flying_straight_up_does_not_walk_the_player_model() void {
}
    // rust: let from = Vec3::new(0.5, 80.0, 0.5);
        // Creative flight straight up (#3302) and straight down.
    // rust: assert_eq!(player_walk_distance(from, Vec3::new(0.5, 80.375, 0.5)), 0.0);
    // rust: assert_eq!(player_walk_distance(from, Vec3::new(0.5, 78.5, 0.5)), 0.0);
        // Moving sideways while rising walks only the horizontal part.
    // rust: let d = player_walk_distance(from, Vec3::new(0.8, 81.0, 0.9));
    // rust: assert!((d - 0.5).abs() < 1e-6, "{d}");
}
    /// #3844: `getXRot(partialTick)` after `Entity.turn`, as the model's
    /// renderer lerps it, with turns before and after the tick.
pub fn own_head_pitch_follows_the_mouse_between_ticks() void {
}
        // (pitch, the model's previous head pitch, its head pitch), as
        // `turn_player` and `tick_player_model` move them.
    // rust: let turn = |(pitch, previous, _): (f32, f32, f32), degrees: f32| {
    // rust: let r = turn_rotation(0.0, pitch, Some(previous), 0.0, f64::from(degrees / 0.15));
    // rust: (r.x_rot, r.x_rot_o, r.x_rot)
}
    // rust: let tick = |(pitch, _, head): (f32, f32, f32)| (pitch, head, pitch);
    // rust: let x_rot =
    // rust: |(_, previous, head): (f32, f32, f32), alpha: f32| previous + (head - previous) * alpha;
    // rust: let at = |state, pitch: f32| {
    // rust: for alpha in [0.0, 0.5, 1.0] {
    // rust: let x = x_rot(state, alpha);
    // rust: assert!((x - pitch).abs() < 1e-3, "partial tick {alpha}: {x}");
}
}
        // The arrow keys turn before the frame's ticks: the tick then copies
        // ends that are already in step.
    // rust: let still = (10.0, 10.0, 10.0);
    // rust: let state = tick(turn(still, 30.0));
    // rust: at(state, 40.0);
        // The mouse turns after the tick: the head is there at once.
    // rust: let state = turn(state, -30.0);
    // rust: at(state, 10.0);
        // The tick laid the head down from 30 to 0: the turn moves both
        // ends, and the tick's change still eases in.
    // rust: let state = turn((0.0, 30.0, 0.0), 10.0);
    // rust: assert!((x_rot(state, 0.5) - 25.0).abs() < 1e-3, "{state:?}");
        // xRotO is clamped as xRot is.
    // rust: let r = turn_rotation(0.0, 60.0, Some(80.0), 0.0, 200.0);
    // rust: assert_eq!((r.x_rot_o, r.x_rot), (90.0, 90.0));
        // Without a model the old pitch is the pitch.
    // rust: let r = turn_rotation(0.0, 10.0, None, 0.0, 100.0);
    // rust: assert_eq!(r.x_rot_o, r.x_rot);
}
pub fn preview_keeps_crossing_faces_depth_and_clips_without_dropping_faces() void {
}
//         use horizon_client::{
    // rust: hud::{Blend, HudBatch},
    // rust: mesher::Vertex,
}
    // rust: let face = |z: [f32; 4]| {
    // rust: [[-2.0, -1.0], [-2.0, 1.0], [2.0, 1.0], [2.0, -1.0]]
    // rust: .into_iter()
    // rust: .zip(z)
    // rust: .map(|([x, y], z)| Vertex {
    // rust: pos: [x, y, z],
    // rust: uv: [0.0; 2],
    // rust: layer: 0,
    // rust: color: u32::MAX,
    // rust: light: 0,
    // rust: normal: [0; 4],

    // rust: glint_uv: [0.0, 0.0],
    // rust: })
}
        // A shield and arm can intersect: neither average depth orders both ends.
    // rust: let verts = face([1.0, 1.0, -1.0, -1.0]).chain(face([0.0; 4])).collect();
    // rust: let quads = player_preview_quads(verts, glam::Mat4::IDENTITY, None, &Default::default());
    // rust: assert_eq!(quads.len(), 2);
    // rust: let mut batch = HudBatch::new([320, 240]);
    // rust: for (_, p, uv, color) in quads {
    // rust: batch.quad_3d(p, uv, color);
}
        // Its centre is outside this scissor; the visible part must still be drawn.
    // rust: batch.depth_since(0, [1.0, 0.0, 2.0, 1.0]);
    // rust: assert_eq!(batch.vertices.len(), 12);
    // rust: let shield = &batch.vertices[..6];
    // rust: let arm = &batch.vertices[6..];
    // rust: assert!(shield[0].depth < arm[0].depth);
    // rust: assert!(shield[2].depth > arm[2].depth);
    // rust: assert_eq!(batch.runs(), vec![(0..12, Blend::Depth([1, 0, 1, 1]))]);
}

pub fn no_cull_faces_stay_in_the_preview_when_they_look_away() void {
}
//         use horizon_client::mesher::Vertex;
        // The wings' `armorCutoutNoCull`: a face turned from the viewer is
        // dropped by the preview's culling unless its vertices are no-cull.
    // rust: let face = |z: f32| {
    // rust: [[-1.0, -1.0], [-1.0, 1.0], [1.0, 1.0], [1.0, -1.0]].map(|[x, y]| Vertex {
    // rust: pos: [x, y, z],
    // rust: uv: [x, y],
    // rust: layer: 0,
    // rust: color: u32::MAX,
    // rust: light: 0,
    // rust: normal: [0; 4],
    // rust: glint_uv: [0.0, 0.0],
    // rust: })
}
        // Wound one way a face looks at the viewer, the other way it looks away.
    // rust: let mut away = face(0.0);
    // rust: away.reverse();
    // rust: let verts: Vec<_> = face(0.0).into_iter().chain(away).collect();
    // rust: let sprites = Default::default();
    // rust: let gui = glam::Mat4::IDENTITY;
    // rust: let culled = player_preview_quads(verts.clone(), gui, None, &sprites);
    // rust: assert_eq!(culled.len(), 1);
    // rust: let kept = player_preview_quads_no_cull(verts.clone(), gui, None, &sprites, 4..8);
    // rust: assert_eq!(kept.len(), 2);
        // The first face is outside the range and still culled when it looks away.
    // rust: let first_away = player_preview_quads_no_cull(verts, gui, None, &sprites, 0..0);
    // rust: assert_eq!(first_away.len(), 1);
}

pub fn the_inventory_preview_is_lit_as_entity_in_ui() void {
}
        // A face looking at the viewer, up, down, to the right and to the left.
    // rust: let shade = |x, y, z| entity_in_ui_shade(glam::Vec3::new(x, y, z));
    // rust: assert!((shade(0.0, 0.0, 1.0) - 0.8195).abs() < 1e-3);
    // rust: assert_eq!(shade(0.0, -1.0, 0.0), 1.0);
    // rust: assert!((shade(0.0, 1.0, 0.0) - 0.4).abs() < 1e-6);
    // rust: assert!((shade(1.0, 0.0, 0.0) - 0.4839).abs() < 1e-3);
    // rust: assert!((shade(-1.0, 0.0, 0.0) - 0.5176).abs() < 1e-3);
        // Away from the viewer: only the ambient light.
    // rust: assert!((shade(0.0, 0.0, -1.0) - 0.4).abs() < 1e-6);
}

pub fn player_render_transform_uses_vanilla_avatar_scale() void {
}
    // rust: let root = std::path::PathBuf::from(
    // rust: std::env::var_os("HORIZON_TEST_RESOURCES").expect("HORIZON_TEST_RESOURCES"),
    // rust: );
    // rust: let mut m = Mob::new(1, player_type(&root).unwrap(), Vec3::ZERO, 0.0);
    // rust: for (id, expected) in [("minecraft:player", 0.9375), ("minecraft:zombie", 1.0)] {
    // rust: Arc::make_mut(&mut m.kind).id = id.into();
    // rust: let transform =
    // rust: horizon_client::mobs::render::base_transform_at(&m, 1.0, glam::Mat4::IDENTITY);
    // rust: for axis in [glam::Vec3::X, glam::Vec3::Y, glam::Vec3::Z] {
    // rust: assert!((transform.transform_vector3(axis).length() - expected).abs() < 1e-6);
}
}
}

pub fn an_invisible_player_hides_its_own_body() void {
}
//         use horizon_client::{effects::EffectInstance, scoreboard::Scoreboard};
        // The effect as a server's UpdateMobEffect or a drunk potion adds it.
    // rust: let id = horizon_client::brewing::effect("minecraft:invisibility")
    // rust: .unwrap()
    // rust: .id;
    // rust: let mut effects = horizon_client::effects::PlayerEffects::default();
    // rust: assert!(body_visible(own_invisible(&effects, false), None));
    // rust: effects.add(EffectInstance::new(id, 3600, 0));
    // rust: let invisible = own_invisible(&effects, false);
    // rust: assert!(
    // rust: !body_visible(invisible, None),
    // rust: "no team: the body is hidden"
    // rust: );
        // Entity.isInvisibleTo: a team that sees friendly invisibles sees it.
    // rust: let mut board = Scoreboard::default();
    // rust: let team = board.add_team("blue");
    // rust: assert!(body_visible(invisible, Some(team)));
    // rust: team.see_friendly_invisibles = false;
    // rust: assert!(!body_visible(invisible, Some(team)));
}

    /// #3788: a pose plugin's `Player.setInvisible(true)` sets only the
    /// shared flag (no effect); `Entity.isInvisible` reads that flag, so the
    /// real body under the pose is not drawn.
pub fn the_servers_invisible_flag_hides_the_own_body_without_the_effect() void {
}
    // rust: let effects = horizon_client::effects::PlayerEffects::default();
    // rust: assert!(own_invisible(&effects, true));
    // rust: assert!(!body_visible(own_invisible(&effects, true), None));
    // rust: let mut board = horizon_client::scoreboard::Scoreboard::default();
    // rust: let team = board.add_team("blue");
    // rust: assert!(body_visible(own_invisible(&effects, true), Some(team)));
}

    /// LivingEntityRenderer.submit: an invisible body is not drawn, its
    /// HumanoidArmorLayer is.
pub fn an_invisible_body_keeps_its_armour() void {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client/26.3");
    // rust: let Some(kind) = player_type(&root) else {
    // rust: return;
}
    // rust: let m = Mob::new(1, kind.clone(), Vec3::ZERO, 0.0);
    // rust: let armour = [(&*kind.model, [0.5, 0.5, 0.75, 0.75], u32::MAX, 0, false)];
    // rust: let atlas = |_: &str| Some([0.0, 0.0, 0.25, 0.25]);
    // rust: let data = horizon_client::mobs::MobData {
    // rust: states: Vec::new(),
    // rust: placements: Default::default(),
    // rust: heightmaps: Default::default(),
    // rust: animations: Default::default(),
    // rust: biome_tags: Default::default(),
    // rust: entity_tags: Default::default(),
    // rust: villager_hats: Default::default(),
    // rust: cem: Default::default(),
    // rust: random_textures: Default::default(),
    // rust: emissive: Default::default(),
    // rust: blinks: Default::default(),
    // rust: pois: Default::default(),
    // rust: species_placements: Default::default(),
}
    // rust: let draw = |body: bool| {
    // rust: let mut out = Vec::new();
    // rust: let render = if body {
    // rust: horizon_client::mobs::render::render_with
    // rust: } else {
    // rust: horizon_client::mobs::render::render_layers
}
    // rust: render(
    // rust: &m,
    // rust: 1.0,
    // rust: glam::DVec3::ZERO,
    // rust: &atlas,
    // rust: 0xF0F0,
    // rust: &data,
    // rust: &armour,
    // rust: &mut out,
    // rust: );
    // rust: out
}
    // rust: let (shown, hidden) = (draw(true), draw(false));
    // rust: assert!(shown.iter().any(|v| v.uv[0] <= 0.25), "the body draws");
    // rust: assert!(!hidden.is_empty(), "the armour still draws");
    // rust: assert!(hidden.iter().all(|v| v.uv[0] >= 0.5), "only the armour");
    // rust: assert_eq!(hidden.len() * 2, shown.len());
        // AvatarRenderer.shouldRenderLayers: a spectator has no armour layer.
    // rust: let mut ghost = m.clone();
    // rust: ghost.extra.spectator = true;
    // rust: assert!(!horizon_client::mobs::render::layers_shown(&ghost));
    // rust: let mut with_armour = Vec::new();
    // rust: let mut without = Vec::new();
    // rust: for (armour, out) in [(&armour[..], &mut with_armour), (&[][..], &mut without)] {
    // rust: horizon_client::mobs::render::render_layers(
    // rust: &ghost,
    // rust: 1.0,
    // rust: glam::DVec3::ZERO,
    // rust: &atlas,
    // rust: 0xF0F0,
    // rust: &data,
    // rust: armour,
    // rust: out,
    // rust: );
}
    // rust: assert!(without.is_empty() && with_armour.is_empty(), "no armour");
}

pub fn burning_inventory_preview_keeps_visible_fullbright_flames() void {
}
    // rust: let rect = |u0| horizon_client::hud::Rect {
    // rust: u0,
    // rust: v0: 0.0,
    // rust: u1: u0 + 0.1,
    // rust: v1: 0.1,
    // rust: w: 16,
    // rust: h: 16,
}
    // rust: let sprites = std::collections::HashMap::from([
    // rust: ("block/fire_0".into(), rect(0.0)),
    // rust: ("block/fire_1".into(), rect(0.5)),
    // rust: ]);
    // rust: for pitch in [-30.0f32, 0.0, 30.0] {
    // rust: let gui = glam::Mat4::from_scale(glam::Vec3::new(30.0, 30.0, -30.0))
    // rust: * glam::Mat4::from_rotation_z(std::f32::consts::PI)
    // rust: * glam::Mat4::from_rotation_x(pitch.to_radians());
    // rust: assert!(player_preview_quads(Vec::new(), gui, None, &sprites).is_empty());
    // rust: let quads = player_preview_quads(Vec::new(), gui, Some((0.6, 1.8)), &sprites);
    // rust: assert!(
    // rust: !quads.is_empty(),
    // rust: "inventory projection must not cull all flames"
    // rust: );
    // rust: assert!(quads.iter().all(|q| q.3 == 0xffff_ffff));
    // rust: assert!(quads.iter().any(|q| q.2[0][0] <= 0.1));
    // rust: assert!(quads.iter().any(|q| q.2[0][0] >= 0.5));
    // rust: assert!(quads.windows(2).all(|q| q[0].0 <= q[1].0));
}
}

pub fn sleeping_player_light_probe_stays_below_a_two_block_ceiling() void {
}
        // In a 2-block-high room (bed at y = 64, air at 65, solid ceiling at 66),
        // setPosToBed places the sleeper at y = 64 + 0.5625 + 0.125 = 64.6875.
    // rust: let in_bed = Vec3::new(10.5, 64.0 + 0.5625 + 0.125, -4.5);
    // rust: let sleeping_eye = f64::from(Pose::Sleeping.dimensions(1.0).eye_height);
    // rust: assert_eq!(
    // rust: entity_light_block(in_bed, false, sleeping_eye),
    // rust: [10, 64, -5]
    // rust: );
        // Using the standing eye height (1.62) while in bed probed y = 66,
        // inside the ceiling block where light is 0 (#5121).
    // rust: let standing_eye = f64::from(Pose::Standing.dimensions(1.0).eye_height);
    // rust: assert_eq!(
    // rust: entity_light_block(in_bed, false, standing_eye),
    // rust: [10, 66, -5]
    // rust: );
        // A crouching player on a 7-layer snow block (feet y = 65.75, model y
        // dropped by 0.125, crouch eye 1.27) still probes at real y + eye = 67.02.
    // rust: let (_, crouch_model) = player_model_positions(
    // rust: Vec3::new(10.5, 65.75, -4.5),
    // rust: Vec3::new(10.5, 65.75, -4.5),
    // rust: true,
    // rust: true,
    // rust: );
    // rust: let crouch_eye = f64::from(Pose::Crouching.dimensions(1.0).eye_height);
    // rust: assert_eq!(
    // rust: entity_light_block(crouch_model, true, crouch_eye),
    // rust: [10, 67, -5]
    // rust: );
}

    /// `LivingEntityRenderer.solveBodyRot` worked by hand: the head turns at
    /// most 85 degrees from the vehicle's body, and past 50 the body follows a
    /// fifth of the turn.
pub fn a_living_vehicles_rider_faces_its_body_within_85_degrees() void {
}
    // rust: let body = |head, vehicle| (super::rider_body_yaw(head, vehicle) * 1000.0).round() / 1000.0;
    // rust: assert_eq!(body(60.0, 40.0), 40.0);
    // rust: assert_eq!(body(100.0, 40.0), 52.0);
    // rust: assert_eq!(body(140.0, 40.0), 72.0);
    // rust: assert_eq!(body(-60.0, 40.0), 8.0);
        // Across the wrap: head at 170, vehicle at -170 (20 degrees apart).
    // rust: assert_eq!(body(170.0, -170.0), 190.0);
}
}
