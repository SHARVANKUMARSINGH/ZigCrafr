//! Transpiled from Horizon Rust crate
package horizon_client_cushions

import "core:fmt"
import "core:mem"
import "core:math"

// Cushions: `CushionItem.useOn` placement on the top face of a block,
// `Cushion.canBePlacedAt`/`survives`, `Cushion.interact` (sit),
// `BlockAttachedEntity.hurtServer` (break, dropping the matching colour),
// `BlockAttachedEntity.tick` and `CushionRenderer`.
//
// A cushion is a `BlockAttachedEntity`, not a block: it has no block state,
// only an entity whose `Pos` is the click point's height. Placement uses
// outline bounds, collision shapes and suffocation predicates.
// use super::{Game, Hit, InteractTarget, Keys, entity_culling::default_range, ray_box};
// use horizon_client::actions::Action;
// use horizon_client::entities::{Cushion, dye_index};
// use horizon_client::items::ItemStack;
// use horizon_client::mobs::anim::Poses;
// use horizon_core::geometry::{Aabb, Vec3};

// `Direction.fromYRot(yaw).toYRot()`: the nearest 90 degree step.
    // rust: pub(crate) fn snap_yaw(yaw: f32) -> f32 {
    // rust: (((f64::from(yaw) / 90.0 + 0.5).floor() as i64) & 3) as f32 * 90.0
}

aabb :: proc(bounds: ([f64; 3]) {
}
    // rust: Aabb::new(
    // rust: Vec3::new(bounds.0[0], bounds.0[1], bounds.0[2]),
    // rust: Vec3::new(bounds.1[0], bounds.1[1], bounds.1[2]),
    // rust: )
}

overlaps :: proc(a: Aabb, b: Aabb) -> b {
    // Ported from Horizon
    return {}
}
    // rust: a.intersects(b)
}
// use horizon_client::cushion::blocks_in;

PlacementWorld :: struct {
    // rust: impl horizon_client::cushion::World for PlacementWorld<'_, '_> {
outline_bounds :: proc(self: ^Self, p: [i32; 3]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let boxes = self.0.outline_boxes(p);
    // rust: let mut shape = *boxes.first()?;
    // rust: for b in &boxes[1..] {
    // rust: for k in 0..3 {
    // rust: shape[k] = shape[k].min(b[k]);
    // rust: shape[k + 3] = shape[k + 3].max(b[k + 3]);
}
}
    // rust: Some(Aabb::new(
    // rust: Vec3::new(shape[0], shape[1], shape[2]),
    // rust: Vec3::new(shape[3], shape[4], shape[5]),
    // rust: ))
}

collision_shapes :: proc(self: ^Self, bounds: Aabb) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let binding = self.0.res.collision();
    // rust: let mut world = horizon_client::collisions::SceneCollisions {
    // rust: world: &self.0.world,
    // rust: binding,
    // rust: subject: None,
}
        // Include neighbour blocks whose collision shape can reach outside their cell.
    // rust: blocks_in(bounds.inflate(Vec3::new(1.0, 1.0, 1.0)))
    // rust: .filter_map(|p| {
    // rust: let state = self.0.world.block(p[0], p[1], p[2]);
    // rust: binding
    // rust: .collision_shape(&mut world, state, p)
    // rust: .ok()
    // rust: .map(|s| s.moved(Vec3::new(f64::from(p[0]), f64::from(p[1]), f64::from(p[2]))))
    // rust: })
    // rust: .collect()
}
suffocating :: proc(self: ^Self, p: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.0
    // rust: .state_suffocating(self.0.world.block(p[0], p[1], p[2]))
}
}

    // rust: impl Game<'_> {
    // `BlockBehaviour.Properties.isSuffocating` of a state: the block's
    // explicit predicate, else `causes_suffocation` with a full collision
    // shape.
    // rust: pub(super) fn state_suffocating(&self, state: horizon_world::registry::BlockStateId) -> bool {
    // rust: let facts = self.res.facts().get(state);
    // rust: let name = facts.name.as_ref();
        // Blocks' explicit predicates, then the default causes_suffocation/full-shape rule.
    // rust: match name {
    // rust: "minecraft:dirt_path"
    // rust: | "minecraft:farmland"
    // rust: | "minecraft:mud"
    // rust: | "minecraft:soul_sand" => true,
    // rust: "minecraft:piston" | "minecraft:sticky_piston" => self
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .state(state)
    // rust: .is_some_and(|s| s.properties.get("extended").is_some_and(|p| p == "false")),
    // rust: "minecraft:mangrove_roots" | "minecraft:moving_piston" => false,
    // rust: _ if name.ends_with("_leaves")
    // rust: || name.ends_with("glass")
    // rust: || name.ends_with("copper_grate") =>
    // rust: {
    // rust: false
}
            // ShulkerBoxBlock: suffocating while closed; a box seen open
            // here is rare enough to count as closed.
    // rust: _ if name.ends_with("shulker_box") => true,
    // rust: _ => {
    // rust: facts.full_collision
    // rust: && self
    // rust: .res
    // rust: .items()
    // rust: .block_in_tag("minecraft:causes_suffocation", name)
}
}
}

    // `BlockState.isViewBlocking(level, pos, nearPlaneBox)`: stairs and
    // slabs (`NEAR_PLANE_INTERSECTS_OUTLINE`) block when the near plane
    // touches a box of their shape, snow only at eight layers, anything else
    // when it is suffocating.
    // rust: pub(super) fn state_view_blocking(
    // rust: &self,
    // rust: state: horizon_world::registry::BlockStateId,
    // rust: pos: [i32; 3],
    // rust: near_plane: Aabb,
    // rust: ) -> bool {
    // rust: let name = self.res.facts().get(state).name.as_ref();
    // rust: if name == "minecraft:snow" {
    // rust: return self
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .state(state)
    // rust: .and_then(|s| s.properties.get("layers"))
    // rust: .is_some_and(|l| l.parse::<i32>().is_ok_and(|l| l >= 8));
}
    // rust: if (name.ends_with("_stairs") || name.ends_with("_slab"))
    // rust: && name != "minecraft:petrified_oak_slab"
    // rust: {
    // rust: return self
    // rust: .outline_boxes(pos)
    // rust: .iter()
    // rust: .any(|b| aabb(([b[0], b[1], b[2]], [b[3], b[4], b[5]])).intersects(near_plane));
}
    // rust: self.state_suffocating(state)
}
}

    // rust: impl Game<'_> {
    // The cushion under the crosshair, its distance and the hit point.
    // rust: pub(super) fn cushion_hit(&self) -> Option<(usize, f64, [f64; 3])> {
    // rust: let (eye, dir) = self.aim()?;
    // rust: let reach: f64 = self.entity_reach;
    // rust: let mut best: Option<(usize, f64, [f64; 3])> = None;
    // rust: for (i, c) in self.cushions.iter().enumerate() {
    // rust: let Some(d) = ray_box(eye, dir, reach, aabb(c.bounds())) else {
    // rust: continue;
}
    // rust: if best.is_none_or(|b| d < b.1) {
    // rust: best = Some((i, d, std::array::from_fn(|k| eye[k] + dir[k] * d)));
}
}
    // rust: best
}

    // rust: pub(super) fn cushion_survives(&self, c: &Cushion) -> bool {
    // rust: horizon_client::cushion::survives(&PlacementWorld(self), aabb(c.bounds()))
}

    // `Cushion.destroyIfInFire`: a fire-tagged block inside the deflated box.
cushion_in_fire :: proc(self: ^Self, c: ^Cushion) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let bounds = aabb(c.bounds()).next_deflated();
    // rust: blocks_in(bounds).any(|p| {
    // rust: let facts = self.res.facts().get(self.world.block(p[0], p[1], p[2]));
    // rust: self.items().block_in_tag("minecraft:fire", &facts.name)
    // rust: })
}

    // `CushionItem.useOn` up to `Cushion.canBePlacedAt`, which the client
    // checks too: on the top face only, at the click's height above the
    // clicked block (or the replaceable block itself). The position and
    // spawn box of a cushion that may go there.
    // rust: pub(super) fn cushion_spawn(&self, hit: &Hit) -> Option<(Vec3, Aabb)> {
        // CushionItem.recalculateContextForSpecialCollisionShapes: open containers
        // (cauldrons, hoppers and composters) use the collision ray's actual height.
    // rust: let mut adjusted = Hit {
    // rust: pos: hit.pos,
    // rust: face: hit.face,
    // rust: point: hit.point,
}
    // rust: let state = self.world.block(hit.pos[0], hit.pos[1], hit.pos[2]);
    // rust: if self.items().block_in_tag(
    // rust: "minecraft:cushion_uses_collision_shape",
    // rust: &self.res.facts().get(state).name,
    // rust: ) && let Some(eye) = self.eye_position()
    // rust: {
    // rust: let start = Vec3::new(eye[0], eye[1], eye[2]);
    // rust: let point = Vec3::new(hit.point[0], hit.point[1], hit.point[2]);
    // rust: let end = point.add_vector(point.subtract(start).normalize().scale(0.001));
    // rust: let binding = self.res.collision();
    // rust: let mut world = horizon_client::collisions::SceneCollisions {
    // rust: world: &self.world,
    // rust: binding,
    // rust: subject: None,
}
    // rust: if let Ok(shape) = binding.collision_shape(&mut world, state, hit.pos)
    // rust: && let Some(result) = shape.clip(
    // rust: start,
    // rust: end,
    // rust: horizon_core::position::BlockPos::new(hit.pos[0], hit.pos[1], hit.pos[2]),
    // rust: )
    // rust: {
    // rust: adjusted.face = result.direction.normal();
    // rust: adjusted.point = [result.location.x, result.location.y, result.location.z];
}
}
    // rust: let hit = &adjusted;
    // rust: if hit.face != [0, 1, 0] {
    // rust: return None;
}
        // BlockPlaceContext: a replaceable clicked block is replaced.
    // rust: let clicked = self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(hit.pos[0], hit.pos[1], hit.pos[2]));
    // rust: let pos = if clicked.replaceable {
    // rust: hit.pos
    // rust: } else {
    // rust: std::array::from_fn(|i| hit.pos[i] + hit.face[i])
}
        // `Vec3.atCenterOfWithY(clickedPos, clickLocation.y)`.
    // rust: let y = hit.point[1];
    // rust: let position = Vec3::new(f64::from(pos[0]) + 0.5, y, f64::from(pos[2]) + 0.5);
    // rust: let bounds = aabb((
    // rust: [position.x - 0.5, position.y, position.z - 0.5],
    // rust: [position.x + 0.5, position.y + 0.25, position.z + 0.5],
    // rust: ));
    // rust: horizon_client::cushion::can_place(&PlacementWorld(self), bounds)
    // rust: .then_some((position, bounds))
}

    // `CushionItem.useOn`: spawn the cushion where `cushion_spawn` allows,
    // unless another cushion is in the way.
    // rust: pub(super) fn place_cushion(&mut self, hit: &Hit, stack: &ItemStack) -> bool {
    // rust: let Some(info) = self.items().get(&stack.item).cloned() else {
    // rust: return false;
}
    // rust: let Some(default_color) = info.cushion_color.as_deref() else {
    // rust: return false;
}
    // rust: let color_override = stack
    // rust: .data()
    // rust: .and_then(|d| d.other("minecraft:cushion/color"))
    // rust: .and_then(|tag| match tag {
    // rust: horizon_world::nbt::Tag::String(s) => Some(s.to_string_lossy()),
    // rust: _ => None,
    // rust: });
    // rust: let color = dye_index(color_override.as_deref().unwrap_or(default_color));
    // rust: let Some((position, bounds)) = self.cushion_spawn(hit) else {
    // rust: return false;
}
        // `getEntitiesOfClass(Cushion.class, spawnAABB).isEmpty()`.
    // rust: if self
    // rust: .cushions
    // rust: .iter()
    // rust: .any(|c| overlaps(aabb(c.bounds()), bounds))
    // rust: {
    // rust: return false;
}
    // rust: self.next_entity += 1;
    // rust: let id = self.next_entity;
        // `BlockAttachedEntity.setPos`: `BlockPos.containing(position)`.
    // rust: let attached = [
    // rust: position.x.floor() as i32,
    // rust: position.y.floor() as i32,
    // rust: position.z.floor() as i32,
    // rust: ];
    // rust: self.cushions.push(Cushion {
    // rust: id,
    // rust: position,
    // rust: pos: attached,
    // rust: yaw: snap_yaw(self.yaw),
    // rust: color,
    // rust: check_interval: 0,
    // rust: custom_name: None,
    // rust: });
    // rust: self.world
    // rust: .modified
    // rust: .insert((attached[0] >> 4, attached[2] >> 4));
        // `destroyIfInFire`: placed into fire, it breaks at once.
    // rust: let placed = self.cushions.len() - 1;
    // rust: if self.cushion_in_fire(&self.cushions[placed]) {
    // rust: self.break_cushion(placed, false);
}
    // rust: self.audio.play(
    // rust: "minecraft:entity.cushion.place",
    // rust: Some([position.x, position.y, position.z]),
    // rust: 0.75,
    // rust: 0.8,
    // rust: );
    // rust: let ctx = self.who_context(Some(horizon_client::mobs::Who::Player), None);
    // rust: self.post_game_event(
    // rust: "minecraft:entity_place",
    // rust: [position.x, position.y, position.z],
    // rust: ctx,
    // rust: );
    // rust: if !self.creative {
    // rust: self.consume_held();
}
        // `CushionItem.useOn` returns SUCCESS: the hand swings.
    // rust: self.swing_arm();
    // rust: true
}

    // `Cushion.interact`: sit down unless sneaking or already occupied. The
    // cushion under the crosshair, or the one a guest's interact packet named.
    // rust: pub(super) fn interact_cushion(&mut self, target: Option<InteractTarget>) -> bool {
    // rust: let Some((i, d, _)) = (match target {
    // rust: Some(t) => {
    // rust: Self::named_entity(&self.cushions, t.id, |c| c.id).map(|i| (i, 0.0, [0.0; 3]))
}
    // rust: None => self.cushion_hit(),
    // rust: }) else {
    // rust: return false;
}
        // Only a client's own pick is stopped by a block: the range check passed.
    // rust: if target.is_none() && !self.before_block(d) {
    // rust: return false;
}
        // isSecondaryUseActive.
    // rust: if self.keys.held(Action::Sneak) {
    // rust: return false;
}
    // rust: let id = self.cushions[i].id;
    // rust: let occupied = self.riding == Some(id)
    // rust: || self
    // rust: .lan
    // rust: .as_ref()
    // rust: .is_some_and(|h| h.hub.guests.iter().any(|g| g.vehicle == Some(id)));
        // `Cushion.interact`: an occupied cushion (`isVehicle`) passes.
    // rust: if occupied {
    // rust: return false;
}
        // `Entity.startRiding`: a passenger first gets off what it rides
        // (`stopRiding`), so a seated player moves to this cushion.
    // rust: if !self.may_board() || !self.native_may_board(id) {
    // rust: return true;
}
    // rust: self.stop_riding();
        // startRiding stops when stopRiding left the passenger seated (a mod
        // canceled the dismount).
    // rust: if self.riding.is_some() {
    // rust: return true;
}
    // rust: self.start_riding(id);
    // rust: let p = self.cushions[i].position;
    // rust: self.audio.play(
    // rust: "minecraft:entity.cushion.sit",
    // rust: Some([p.x, p.y, p.z]),
    // rust: 1.0,
    // rust: 1.0,
    // rust: );
    // rust: self.swing_arm();
    // rust: true
}

    // `Cushion.hurtServer` from a player: killed, then the item dropped.
    // rust: pub(super) fn attack_cushion(&mut self) -> bool {
    // rust: let Some((i, d, _)) = self.cushion_hit() else {
    // rust: return false;
}
    // rust: if !self.before_block(d) || self.mob_hit().is_some_and(|m| m.1 < d) {
    // rust: return false;
}
        // `Cushion.hurtServer` refuses a player who may not build, so
        // skipAttackInteraction is false and Player.attack goes on to onAttack.
    // rust: if !self.may_build() {
    // rust: self.attack_ticks = 0;
    // rust: return true;
}
    // rust: self.break_cushion(i, true);
    // rust: true
}

    // `Cushion.dropItem`: the break sound and particles, then the coloured
    // item unless drops are off or the breaker has infinite materials.
    // rust: pub(super) fn break_cushion(&mut self, index: usize, by_player: bool) {
    // rust: let c = self.cushions.remove(index);
    // rust: let p = c.position;
    // rust: self.world.modified.insert((c.pos[0] >> 4, c.pos[2] >> 4));
    // rust: if self.riding == Some(c.id) {
    // rust: self.dismount_removed_vehicle(p.y);
}
    // rust: self.audio.play(
    // rust: "minecraft:entity.cushion.break",
    // rust: Some([p.x, p.y, p.z]),
    // rust: 1.0,
    // rust: 1.0,
    // rust: );
    // rust: self.cushion_break_particles(&c);
    // rust: if !self.ui.rules.bool("entity_drops") || (by_player && self.creative) {
    // rust: return;
}
    // rust: let stack = c.item_stack_with_data();
    // rust: self.spawn_item(stack, [p.x, p.y, p.z], [0.0; 3], 10);
}

    // `Cushion.showBreakingParticles`: ten of the matching wool block.
cushion_break_particles :: proc(self: ^Self, c: ^Cushion) {
}
    // rust: let name = format!("minecraft:{}_wool", c.color_name());
    // rust: let Some(state) = self.pack.assets.registry.default_state(&name) else {
    // rust: return;
}
    // rust: let p = c.position;
        // Entity.getY(2/3) is relative to the cushion's quarter-block height.
    // rust: let particle_at = [p.x, p.y + 0.25 * (2.0 / 3.0), p.z];
        // Guest actions temporarily take self.lan; flush once the hub is back.
        // Queue before resolving a sprite: a dedicated server has no renderer.
    // rust: if self.audio.capture.is_some() {
    // rust: self.lan_cushion_breaks.push((state, particle_at));
}
    // rust: let at = [p.x.floor() as i32, p.y.floor() as i32, p.z.floor() as i32];
    // rust: let Some((sprite, tint)) = self.particle_sprite(state, at) else {
    // rust: return;
}
    // rust: let options = horizon_client::particles::ParticleOptions::block(
    // rust: horizon_client::particles::ParticleType::Block,
    // rust: sprite,
    // rust: tint,
    // rust: );
    // rust: self.particles
    // rust: .send_particles(&options, particle_at, [0.25, 0.0625, 0.25], 0.05, 10);
}

    // `BlockAttachedEntity.tick`: survive and burn checks after the post-increment reaches 100.
    // rust: pub(super) fn tick_cushions(&mut self) {
    // rust: let ticking = self.entity_ticking_area();
    // rust: let mut i = 0;
    // rust: while i < self.cushions.len() {
    // rust: let p = self.cushions[i].position;
    // rust: if !ticking(p.x.floor() as i32, p.z.floor() as i32) {
    // rust: i += 1;
    // rust: continue;
}
    // rust: let previous = self.cushions[i].check_interval;
    // rust: self.cushions[i].check_interval += 1;
    // rust: if previous < 100 {
    // rust: i += 1;
    // rust: continue;
}
    // rust: self.cushions[i].check_interval = 0;
    // rust: let c = self.cushions[i].clone();
    // rust: if self.cushion_in_fire(&c) || !self.cushion_survives(&c) {
    // rust: self.break_cushion(i, false);
    // rust: continue;
}
    // rust: i += 1;
}
}

    // `LivingEntity.stopRiding` off a cushion: `dismountVehicle` beside it,
    // and `Cushion.removePassenger`'s get-up sound for a rider that left
    // rather than one whose cushion was killed.
    // rust: pub(super) fn get_up_from_cushion(&mut self, c: &Cushion) {
    // rust: if self.riding == Some(c.id) && !self.native_may_leave(c.id) {
    // rust: return;
}
    // rust: let at = c.dismount();
    // rust: self.riding = None;
    // rust: if let Some(p) = self.player.as_mut() {
    // rust: self.previous_position = p.position;
    // rust: p.position = at;
    // rust: p.velocity = Vec3::ZERO;
    // rust: p.fall_distance = 0.0;
}
    // rust: self.audio.play(
    // rust: "minecraft:entity.cushion.get_up",
    // rust: Some([c.position.x, c.position.y, c.position.z]),
    // rust: 1.0,
    // rust: 1.0,
    // rust: );
}

    // `LivingEntity.dismountVehicle` from a removed vehicle (a broken
    // cushion) whose position was at `vehicle_y`: up to the higher of the
    // rider's and the vehicle's heights, then the free spot nearest there
    // (`findFreePosition` within the rider's own box). No get-up sound:
    // `Cushion.removePassenger` plays none once the cushion is removed.
    // rust: pub(super) fn dismount_removed_vehicle(&mut self, vehicle_y: f64) {
    // rust: self.riding = None;
    // rust: let border = self.border_bounds();
    // rust: let b = self.res.behaviours();
    // rust: let Some(p) = self.player.as_ref() else {
    // rust: return;
}
    // rust: let (w, h) = (
    // rust: f64::from(p.dimensions.width),
    // rust: f64::from(p.dimensions.height),
    // rust: );
    // rust: let mut at = Vec3::new(p.position.x, p.position.y.max(vehicle_y), p.position.z);
        // `getBbWidth() <= 4 && getBbHeight() <= 4`.
    // rust: if w <= 4.0 && h <= 4.0 {
    // rust: let center = at.add_vector(Vec3::new(0.0, h / 2.0, 0.0));
    // rust: let size = Vec3::new(w, h, w);
    // rust: let free = horizon_world::level::portal_travel::find_free_position(
    // rust: Aabb::of_size(center, size),
    // rust: center,
    // rust: size,
    // rust: &border,
    // rust: |q| {
    // rust: b.collision_shape(self.world.block(q.x, q.y, q.z))
    // rust: .map(|s| s.moved(Vec3::new(f64::from(q.x), f64::from(q.y), f64::from(q.z))))
    // rust: },
    // rust: );
    // rust: if let Some(free) = free {
    // rust: at = free.add_vector(Vec3::new(0.0, -h / 2.0, 0.0));
}
}
    // rust: if let Some(p) = self.player.as_mut() {
    // rust: self.previous_position = p.position;
    // rust: p.position = at;
    // rust: p.velocity = Vec3::ZERO;
    // rust: p.fall_distance = 0.0;
}
}

    // `Player.rideTick` on a cushion: hold the seat, and get up on sneak.
    // rust: pub(super) fn tick_cushion_riding(&mut self, keys: Keys) -> bool {
    // rust: let Some(c) = self
    // rust: .cushions
    // rust: .iter()
    // rust: .find(|c| Some(c.id) == self.riding)
    // rust: .cloned()
    // rust: else {
    // rust: return false;
}
    // rust: if keys.shift {
    // rust: self.get_up_from_cushion(&c);
    // rust: return true;
}
    // rust: let seat = c.seat();
    // rust: if let Some(p) = self.player.as_mut() {
    // rust: self.previous_position = p.position;
    // rust: p.position = seat;
    // rust: p.velocity = Vec3::ZERO;
    // rust: p.fall_distance = 0.0;
}
    // rust: true
}

    // `CushionRenderer`: the coloured model, rotated to the nearest
    // direction, with its bottom on the cushion's position.
    // rust: pub(super) fn cushion_geometry(
    // rust: &self,
    // rust: camera: glam::DVec3,
    // rust: out: &mut Vec<horizon_client::mesher::Vertex>,
    // rust: ) {
    // rust: let Some(model) = self.cushion_model.as_ref() else {
    // rust: return;
}
    // rust: let sprites = &self.gui.atlas.sprites;
    // rust: for c in &self.cushions {
    // rust: let a = aabb(c.bounds());
    // rust: let (lo, hi) = (a.min_position(), a.max_position());
    // rust: let (lo, hi) = (
    // rust: glam::DVec3::new(lo.x, lo.y, lo.z),
    // rust: glam::DVec3::new(hi.x, hi.y, hi.z),
    // rust: );
    // rust: let range = default_range(hi - lo, self.view_scale());
    // rust: if !self.entity_in_view(camera, (lo + hi) / 2.0, range, lo, hi) {
    // rust: continue;
}
    // rust: let Some(uv) = sprites
    // rust: .get(&format!("entity/cushion/{}_cushion", c.color_name()))
    // rust: .map(|r| [r.u0, r.v0, r.u1, r.v1])
    // rust: else {
    // rust: continue;
}
    // rust: let culling = self.entity_cull_decision(c, 1.0);
    // rust: if culling.hides_entity() {
    // rust: continue;
}
    // rust: let entity_start = out.len();
    // rust: let p = glam::DVec3::new(c.position.x, c.position.y, c.position.z) - camera;
    // rust: let base = glam::Mat4::from_translation(p.as_vec3())
    // rust: * glam::Mat4::from_rotation_y((180.0 - snap_yaw(c.yaw)).to_radians())
    // rust: * glam::Mat4::from_rotation_x(std::f32::consts::PI)
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(0.0, -0.25, 0.0));
            // `EntityRenderer.getPackedLightCoords` probes at the eye height.
    // rust: let l = self.world.light(
    // rust: c.position.x.floor() as i32,
    // rust: (c.position.y + 0.2125).floor() as i32,
    // rust: c.position.z.floor() as i32,
    // rust: );
    // rust: let packed = (u32::from(l >> 4) * 16) | ((u32::from(l & 15) * 16) << 8);
    // rust: horizon_client::mobs::render::draw(
    // rust: model,
    // rust: base,
    // rust: &Poses::new(model),
    // rust: uv,
    // rust: 0xFFFF_FFFF,
    // rust: packed,
    // rust: 0,
    // rust: out,
    // rust: );
    // rust: self.finish_entity_occlusion(culling, c, out, entity_start);
}
}
}

    // rust: mod tests {
//     use super::*;
//     use horizon_world::nbt::Tag;

    // `Cushion.getCushionItemStackWithData`: a named cushion drops named.
a_named_cushion_drops_with_its_name :: proc() {
}
    // rust: let c = Cushion {
    // rust: id: 1,
    // rust: position: Vec3::ZERO,
    // rust: pos: [0, 64, 0],
    // rust: yaw: 0.0,
    // rust: color: 1,
    // rust: check_interval: 0,
    // rust: custom_name: Some(Tag::String("Seat".into())),
}
    // rust: let stack = c.item_stack_with_data();
    // rust: assert_eq!(&*stack.item, "minecraft:orange_cushion");
    // rust: assert!(stack.data().is_some_and(|d| d.custom_name.is_some()));
        // An unnamed one gains no component.
    // rust: let c = Cushion {
    // rust: custom_name: None,
    // rust: ..c
}
    // rust: assert!(c.item_stack_with_data().data().is_none());
}
}
