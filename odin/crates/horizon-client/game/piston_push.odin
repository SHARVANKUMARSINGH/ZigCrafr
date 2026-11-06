//! Transpiled from Horizon Rust crate
package horizon_client_piston_push

import "core:fmt"
import "core:mem"
import "core:math"

// `PistonMovingBlockEntity.moveCollidedEntities` and `moveStuckEntities` for
// the entities the game moves itself: the players and the mobs. The shulker
// box lid's push (`ShulkerBoxBlockEntity.moveCollidedEntities`) rides along,
// with `Entity.move(MoverType.SHULKER_BOX, …)` taking the same path.
//
// The geometry is in [`horizon_world::piston_push`]; this file supplies the
// bodies and applies the movement the way `Entity.move(MoverType.PISTON, …)`
// does: limited to 0.51 blocks per tick per axis (`Entity.limitPistonMovement`),
// then run through the block collision scan, so a pushed entity stops at a
// wall instead of passing through it.
//
// use super::{
    // rust: Game,
    // rust: entity::{Entity, EntityHandle, with_entity, with_entity_mut},
}
// use horizon_client::collisions::{EntityCollisions, SceneCollisions, with_piston_noclip};
// use horizon_client::motion::MotionWorld;
// use horizon_core::geometry::{Aabb, Axis, Direction, ShapeOp, Vec3, border::BorderGeometry};
// use horizon_core::position::BlockPos;
// use horizon_world::{
    // rust: block_collision_scan::BlockCollisionWorld, level::data::PushReaction::IgnoreEntity,
    // rust: level::pistons::MovingPiston, piston_movement::PistonMovement, piston_push,
    // rust: world_movement::EntityMovementWorld,
}

// What one piston asks for this tick: where it is, its state, and the progress
// `moveCollidedEntities` runs at (before the tick stores it).
    // rust: pub(super) type Push = (BlockPos, MovingPiston, f32);

// What one shulker box asks for this tick (`moveCollidedEntities`): where it
// is, its facing as a 3D data value, and the lid box it swept
// (`Shulker.getProgressDeltaAabb`).
    // rust: pub(super) type ShulkerPush = ([i32; 3], u8, [f64; 6]);

// Which entity was pushed, so its storage can be reached after the world
// borrow ends.
Target :: enum {
    Player,
    Guest(u32),
    Entity(EntityHandle),
}

// `Entity.getStepHeight` of each body, read before the push.
StepHeights :: struct {
    player: f32,
    guests: std::collections::HashMap<u32,
}

// What the push needs from one entity.
Body :: struct {
    bounds: Aabb,
    position: Vec3,
    on_ground: bool,
    step_height: f32,
    // Standing on the piston's own block (`Entity.isSupportedBy`).
    supported: bool,
}

    // rust: impl Game<'_> {
    // Push whatever this tick's moving pistons ran into, in the order the
    // pistons ticked: vanilla pushes from each block entity's own tick.
    // rust: pub(super) fn push_piston_entities(&mut self, pushes: Vec<Push>) {
    // rust: let mut accumulators = std::collections::HashMap::new();
    // rust: for push in pushes {
    // rust: self.push_for_piston(push, &mut accumulators);
}
}

    // `ShulkerBoxBlockEntity.moveCollidedEntities` for the bodies this game
    // moves itself: every entity the sweeping lid box meets moves out along
    // the box's facing by the box's own size plus 0.01
    // (`Entity.move(MoverType.SHULKER_BOX, …)`).
    // rust: pub(super) fn push_shulker_entities(&mut self, pushes: Vec<ShulkerPush>) {
    // rust: let steps = self.push_step_heights();
    // rust: for (pos, facing, lid) in pushes {
    // rust: self.push_for_shulker(pos, facing, lid, &steps);
}
}

    // One box's push, a body at a time. The move resolves as a piston's does
    // (`Entity.move` stops at the blocks and the world border), without a
    // piston's per-tick travel limit or its noclip. The local player takes the
    // client's own move instead (`shulker_push_player`).
push_for_shulker :: proc(self: ^Self, pos: [i32; 3], facing: u8, lid: [f64; 6], steps: ^StepHeights) {
}
    // rust: let (movement, area) = shulker_lid(facing, lid);
    // rust: let at = BlockPos::new(pos[0], pos[1], pos[2]);
    // rust: self.push_targets().for_each(|target| {
    // rust: let Some(body) = self.push_body(target, at, steps) else {
    // rust: return;
}
    // rust: if !body.bounds.intersects(area) {
    // rust: return;
}
    // rust: if target == Target::Player {
    // rust: self.shulker_push_player(movement);
    // rust: return;
}
    // rust: let Ok(moved) = pushed_movement(
    // rust: SceneCollisions {
    // rust: world: &self.world,
    // rust: binding: self.collision,
    // rust: subject: None,
    // rust: },
    // rust: self.border.geometry(),
    // rust: [body.position.x, body.position.z],
    // rust: body.bounds,
    // rust: movement,
                // `Entity.move(MoverType.SHULKER_BOX, ...)`: steps and reads the ground flag,
    // rust: body.step_height,
    // rust: body.on_ground,
    // rust: ) else {
    // rust: return;
}
    // rust: if moved.length_squared() > 0.0 {
    // rust: self.apply_push(target, moved);
}
    // rust: });
}

    // `ShulkerBoxBlockEntity.moveCollidedEntities` for the player this game
    // moves itself: the lid's pushes, applied to its own body. A client owns
    // its player's position (the server thread's guest included), so the push
    // is the client's own `Entity.move(MoverType.SHULKER_BOX, …)`.
    // rust: pub(super) fn push_shulker_local(&mut self, pushes: Vec<ShulkerPush>) {
    // rust: for (_, facing, lid) in pushes {
    // rust: let (movement, area) = shulker_lid(facing, lid);
    // rust: let Some(player) = self.player.as_ref() else {
    // rust: return;
}
    // rust: if player.spectator || !player.bounds().intersects(area) {
    // rust: continue;
}
    // rust: self.shulker_push_player(movement);
}
}

    // `Entity.move(MoverType.SHULKER_BOX, …)` for the local player: an
    // ordinary move, so the collision scan steps it and its end writes the
    // ground state (`Entity.setOnGroundWithMovement`). A lid lifting the body
    // off the ground leaves it airborne, and the next tick's gravity lands it
    // on the lid instead of a stale ground flag holding it in place.
shulker_push_player :: proc(self: ^Self, movement: Vec3) {
}
    // rust: let entities = self.player_entity_collisions();
    // rust: if let Some(player) = self.player.as_mut() {
    // rust: let _ = MotionWorld {
    // rust: entities: &entities,
    // rust: player,
    // rust: scene: &mut self.world,
    // rust: assets: &self.pack.assets,
    // rust: collision_binding: self.collision,
    // rust: resources: self.motion,
    // rust: health: &self.health_resources,
}
    // rust: .shulker_box_push(movement);
}
}

    // rust: fn push_for_piston(
    // rust: &mut self,
    // rust: (pos, piston, new_progress): Push,
    // rust: accumulators: &mut std::collections::HashMap<Target, PistonMovement>,
    // rust: ) {
    // rust: let delta_progress = f64::from(new_progress - piston.progress);
    // rust: if delta_progress <= 0.0 {
    // rust: return;
}
    // rust: let Some(bindings) = self.collision.pistons() else {
    // rust: return;
}
    // rust: let Ok(state) = bindings.collision_related_state(piston.shape_state()) else {
    // rust: return;
}
    // rust: let mut scene = SceneCollisions {
    // rust: world: &self.world,
    // rust: binding: self.collision,
    // rust: subject: None,
}
    // rust: let Ok(shape) = self
    // rust: .collision
    // rust: .collision_shape(&mut scene, state, [pos.x, pos.y, pos.z])
    // rust: else {
    // rust: return;
}
    // rust: if shape.is_empty() {
    // rust: return;
}
    // rust: let movement = piston.movement_direction();
    // rust: let boxes: Vec<Aabb> = shape.boxes().to_vec();
    // rust: let facts = self.res.facts();
    // rust: let slime = &*facts.get(piston.moved_state).name == "minecraft:slime_block";
    // rust: let honey = &*facts.get(piston.moved_state).name == "minecraft:honey_block";
        // `moveStuckEntities` asks the moved state's own top for its box.
    // rust: let sticky_top = if honey {
    // rust: let mut scene = SceneCollisions {
    // rust: world: &self.world,
    // rust: binding: self.collision,
    // rust: subject: None,
}
    // rust: self.collision
    // rust: .collision_shape(&mut scene, piston.moved_state, [pos.x, pos.y, pos.z])
    // rust: .ok()
    // rust: .and_then(|s| s.bounds())
    // rust: .map_or(0.0, |b| b.max_position().y)
    // rust: } else {
    // rust: 0.0
}

    // rust: let steps = self.push_step_heights();
    // rust: let search = shape.bounds().map(|bounds| {
    // rust: piston_push::movement_search_area(
    // rust: piston_push::move_by_position_and_progress(pos, bounds, piston.shape_state()),
    // rust: movement,
    // rust: delta_progress,
    // rust: )
    // rust: });
        // `for_each`: a chain folds list by list, where `next` would re-check every
        // link for each entity.
    // rust: self.push_targets().for_each(|target| {
    // rust: let Some(body) = self.push_body(target, pos, &steps) else {
    // rust: return;
}
    // rust: let amount = piston_push::collided_amount(
    // rust: &boxes,
    // rust: pos,
    // rust: piston.shape_state(),
    // rust: new_progress,
    // rust: movement,
    // rust: body.bounds,
    // rust: );
    // rust: if slime && search.is_some_and(|area| area.intersects(body.bounds)) {
    // rust: self.bounce(target, movement);
}
    // rust: if amount > 0.0 {
    // rust: let step = piston_push::step_vector(movement);
    // rust: let before = body.bounds;
    // rust: self.move_pushed(
    // rust: target,
    // rust: before,
    // rust: [body.position.x, body.position.z],
    // rust: body.step_height,
    // rust: body.on_ground,
    // rust: step.scale(amount),
    // rust: movement,
    // rust: accumulators,
    // rust: );
                // `fixEntityWithinPistonBase`: a retracting source piston drags
                // an entity that is still inside its own block.
    // rust: if !piston.extending
    // rust: && piston.source
    // rust: && let Some(after) = self.push_body(target, pos, &steps)
    // rust: && let Some(fix) = piston_push::fix_within_piston_base(
    // rust: pos,
    // rust: after.bounds,
    // rust: movement,
    // rust: delta_progress,
    // rust: )
    // rust: {
    // rust: let back = piston_push::step_vector(movement.opposite());
    // rust: self.move_pushed(
    // rust: target,
    // rust: after.bounds,
    // rust: [after.position.x, after.position.z],
    // rust: after.step_height,
    // rust: after.on_ground,
    // rust: back.scale(fix),
    // rust: movement,
    // rust: accumulators,
    // rust: );
}
}
    // rust: });
        // Vanilla selects honey passengers after all collided entities have moved.
    // rust: if honey && movement.normal()[1] == 0 {
    // rust: let area = piston_push::sticky_area(pos, piston.shape_state(), sticky_top);
    // rust: for target in self.push_targets() {
    // rust: let Some(body) = self.push_body(target, pos, &steps) else {
    // rust: continue;
}
    // rust: if piston_push::sticky_entity_selected(
    // rust: area,
    // rust: body.bounds,
    // rust: horizon_world::level::data::PushReaction::PushPull,
    // rust: body.on_ground,
    // rust: body.supported,
    // rust: body.position,
    // rust: ) {
    // rust: self.move_pushed(
    // rust: target,
    // rust: body.bounds,
    // rust: [body.position.x, body.position.z],
    // rust: body.step_height,
    // rust: body.on_ground,
    // rust: piston_push::step_vector(movement).scale(delta_progress),
    // rust: movement,
    // rust: accumulators,
    // rust: );
}
}
}
}

    // `Block.pushEntitiesUp(old, new, level, pos)` for the block now at `pos`
    // (`FarmlandBlock.turnToBaseBlock`, `PathBlock.turnToBaseBlock`): every body
    // touching the collision that the new state adds over `old` is lifted
    // onto it with `teleportRelative`, no collision scan.
    // rust: pub(super) fn push_entities_up(
    // rust: &mut self,
    // rust: pos: BlockPos,
    // rust: old: horizon_world::registry::BlockStateId,
    // rust: ) {
    // rust: let new = self.world.block(pos.x, pos.y, pos.z);
    // rust: if new == old {
    // rust: return;
}
    // rust: let at = [pos.x, pos.y, pos.z];
    // rust: let shape = |state| {
    // rust: let mut scene = SceneCollisions {
    // rust: world: &self.world,
    // rust: binding: self.collision,
    // rust: subject: None,
}
    // rust: self.collision.collision_shape(&mut scene, state, at).ok()
}
    // rust: let (Some(old_shape), Some(new_shape)) = (shape(old), shape(new)) else {
    // rust: return;
}
    // rust: let Ok(added) = old_shape.join_unoptimized(&new_shape, ShapeOp::ONLY_SECOND) else {
    // rust: return;
}
    // rust: let added = added.moved(Vec3::new(
    // rust: f64::from(pos.x),
    // rust: f64::from(pos.y),
    // rust: f64::from(pos.z),
    // rust: ));
    // rust: let Some(bounds) = added.bounds() else {
    // rust: return;
}
    // rust: let steps = self.push_step_heights();
    // rust: for target in self.push_targets() {
    // rust: let Some(body) = self.push_body(target, pos, &steps) else {
    // rust: continue;
}
    // rust: if !body.bounds.intersects(bounds) {
    // rust: continue;
}
    // rust: let dy = added.collide(Axis::Y, body.bounds.move_by(Vec3::new(0.0, 1.0, 0.0)), -1.0);
    // rust: self.apply_push(target, Vec3::new(0.0, 1.0 + dy, 0.0));
}
}

    // `Entity.getStepHeight` for each body, read once: the attribute lookup
    // needs the mutable body, and the push only needs the number.
push_step_heights :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let player = self
    // rust: .player
    // rust: .as_mut()
    // rust: .and_then(|p| p.attribute("minecraft:step_height").ok())
    // rust: .map_or(0.6, |v| v as f32);
    // rust: let mut guests = std::collections::HashMap::new();
    // rust: if let Some(host) = self.lan.as_mut() {
    // rust: for g in &mut host.hub.guests {
    // rust: let step = g
    // rust: .motion
    // rust: .as_mut()
    // rust: .and_then(|m| m.attribute("minecraft:step_height").ok())
    // rust: .map_or(0.6, |v| v as f32);
    // rust: guests.insert(g.conn, step);
}
}
    // rust: StepHeights { player, guests }
}

    // The entities a moving block can run into: the window's player, the LAN
    // guests in the level, then the mobs.
push_targets :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let player = self.player.is_some().then_some(Target::Player);
        // Empty, and so unallocated, unless guests are here.
    // rust: let guests: Vec<Target> = self.lan.as_ref().map_or_else(Vec::new, |host| {
    // rust: host.hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| host.hub.here(g) && g.loaded && !g.dead)
    // rust: .map(|g| Target::Guest(g.conn))
    // rust: .collect()
    // rust: });
    // rust: player
    // rust: .into_iter()
    // rust: .chain(guests)
    // rust: .chain(self.entity_handles().map(Target::Entity))
}

    // What the push needs from one entity, or `None` when it is not pushed:
    // removed, dead, a spectator, or an armor-stand marker.
push_body :: proc(self: ^Self, target: Target, pos: BlockPos, steps: ^StepHeights) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match target {
    // rust: Target::Player => {
    // rust: let p = self.player.as_ref()?;
    // rust: if p.spectator {
    // rust: return None;
}
    // rust: Some(Body {
    // rust: bounds: p.bounds(),
    // rust: position: p.position,
    // rust: on_ground: p.ground.on_ground,
    // rust: step_height: steps.player,
    // rust: supported: p.ground.supporting_block == Some(pos),
    // rust: })
}
    // rust: Target::Guest(conn) => {
    // rust: let host = self.lan.as_ref()?;
    // rust: let g = host.hub.guests.iter().find(|g| g.conn == conn)?;
    // rust: if g.dead || g.game_mode == 3 {
    // rust: return None;
}
    // rust: let p = g.position;
    // rust: Some(Body {
    // rust: bounds: Aabb::new(
    // rust: Vec3::new(p[0] - 0.3, p[1], p[2] - 0.3),
    // rust: Vec3::new(p[0] + 0.3, p[1] + 1.8, p[2] + 0.3),
    // rust: ),
    // rust: position: Vec3::new(p[0], p[1], p[2]),
    // rust: on_ground: g.on_ground,
    // rust: step_height: steps.guests.get(&conn).copied().unwrap_or(0.6),
    // rust: supported: g
    // rust: .motion
    // rust: .as_ref()
    // rust: .is_some_and(|m| m.ground.supporting_block == Some(pos)),
    // rust: })
}
    // rust: Target::Entity(handle) => with_entity!(self, handle, entity => {
    // rust: if !entity.is_alive() || entity.get_piston_push_reaction() == IgnoreEntity {
    // rust: return None;
}
    // rust: Some(Body {
    // rust: bounds: Entity::bounds(entity),
    // rust: position: entity.position(),
    // rust: on_ground: entity.on_ground(),
    // rust: step_height: entity.get_step_height(),
    // rust: supported: entity.is_supported_by(pos),
    // rust: })
    // rust: }),
}
}

    // `Entity.move(MoverType.PISTON, movement)` for one pushed entity: the
    // per-tick piston limit, then the block and world border collision scan.
    // rust: fn move_pushed(
    // rust: &mut self,
    // rust: target: Target,
    // rust: before: Aabb,
    // rust: at: [f64; 2],
    // rust: step_height: f32,
    // rust: on_ground: bool,
    // rust: movement: Vec3,
    // rust: piston_direction: Direction,
    // rust: accumulators: &mut std::collections::HashMap<Target, PistonMovement>,
    // rust: ) {
    // rust: let Some(limited) = self.limit_piston(target, movement, accumulators) else {
    // rust: return;
}
        // `limitPistonMovement` returns zero once the tick's budget is spent.
    // rust: if limited == Vec3::ZERO {
    // rust: return;
}
    // rust: let resolved = with_piston_noclip(piston_direction, || {
    // rust: pushed_movement(
    // rust: SceneCollisions {
    // rust: world: &self.world,
    // rust: binding: self.collision,
    // rust: subject: None,
    // rust: },
    // rust: self.border.geometry(),
    // rust: at,
    // rust: before,
    // rust: limited,
    // rust: step_height,
    // rust: on_ground,
    // rust: )
    // rust: .unwrap_or(Vec3::ZERO)
    // rust: });
        // Entity.move updates an authoritative living entity's ground flag
        // even for a horizontal piston push. Keeping the old support flag
        // would run Frost Walker while the stand is moving over open water.
    // rust: if let Target::Entity(EntityHandle::ArmorStand(i)) = target {
    // rust: self.armor_stands[i].on_ground = limited.y < 0.0 && limited.y != resolved.y;
}
    // rust: if resolved.length_squared() <= 1.0e-7
    // rust: && limited.length_squared() - resolved.length_squared() >= 1.0e-7
    // rust: {
    // rust: return;
}
    // rust: self.apply_push(target, resolved);
}

    // `Entity.limitPistonMovement`: each axis may travel at most 0.51 blocks
    // per game tick, and a move touches only its first non-zero axis.
    // rust: fn limit_piston(
    // rust: &mut self,
    // rust: target: Target,
    // rust: movement: Vec3,
    // rust: accumulators: &mut std::collections::HashMap<Target, PistonMovement>,
    // rust: ) -> Option<Vec3> {
    // rust: let time = self.world.game_time;
    // rust: let limit = |state: &mut PistonMovement| state.limit(movement, || Ok::<i64, ()>(time)).ok();
    // rust: match target {
    // rust: Target::Player => {
    // rust: let p = self.player.as_mut()?;
    // rust: limit(&mut p.piston)
}
    // rust: Target::Guest(conn) => {
    // rust: let host = self.lan.as_mut()?;
    // rust: let g = host.hub.guests.iter_mut().find(|g| g.conn == conn)?;
    // rust: limit(&mut g.motion.as_deref_mut()?.piston)
}
    // rust: Target::Entity(EntityHandle::Mob(i)) => limit(&mut self.mobs[i].piston),
    // rust: _ => limit(accumulators.entry(target).or_default()),
}
}

apply_push :: proc(self: ^Self, target: Target, movement: Vec3) {
}
    // rust: match target {
    // rust: Target::Player => {
    // rust: if let Some(p) = self.player.as_mut() {
    // rust: p.position = p.position.add_vector(movement);
}
}
    // rust: Target::Guest(conn) => {
    // rust: if let Some(host) = self.lan.as_mut()
    // rust: && let Some(g) = host.hub.guests.iter_mut().find(|g| g.conn == conn)
    // rust: {
                    // The body and the hub's copy of its position move together:
                    // `leave_guest` writes the body back over the hub's.
    // rust: for (slot, delta) in g.position.iter_mut().zip(movement.components()) {
    // rust: *slot += delta;
}
    // rust: if let Some(m) = g.motion.as_deref_mut() {
    // rust: m.position = m.position.add_vector(movement);
}
}
}
    // rust: Target::Entity(handle) => {
    // rust: with_entity_mut!(self, handle, entity => entity.move_by_piston(movement))
}
}
}

    // `causeBounce`: a slime block sets the velocity along the movement axis.
bounce :: proc(self: ^Self, target: Target, movement: Direction) {
}
    // rust: match target {
    // rust: Target::Player => {
    // rust: if let Some(p) = self.player.as_mut() {
    // rust: p.velocity = piston_push::bounce_velocity(movement, p.velocity);
}
}
    // rust: Target::Guest(conn) => {
    // rust: if let Some(host) = self.lan.as_mut()
    // rust: && let Some(guest) = host.hub.guests.iter_mut().find(|g| g.conn == conn)
    // rust: && let Some(motion) = guest.motion.as_deref_mut()
    // rust: {
    // rust: motion.velocity = piston_push::bounce_velocity(movement, motion.velocity);
}
}
    // rust: Target::Entity(handle) => {
    // rust: with_entity_mut!(self, handle, entity => Entity::piston_slime_bounce(entity, movement))
}
}
}
}

// The lid's push: the swept box in world space (`Shulker.
// getProgressDeltaAabb`) and the movement out along the facing, the box's own
// size plus 0.01 (`ShulkerBoxBlockEntity.moveCollidedEntities`).
shulker_lid :: proc(facing: u8, lid: [f64; 6]) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let direction = Direction::ALL[usize::from(facing) % Direction::ALL.len()];
    // rust: let [x, y, z] = direction.normal();
    // rust: (
    // rust: Vec3::new(
    // rust: (lid[3] - lid[0] + 0.01) * f64::from(x),
    // rust: (lid[4] - lid[1] + 0.01) * f64::from(y),
    // rust: (lid[5] - lid[2] + 0.01) * f64::from(z),
    // rust: ),
    // rust: Aabb::new(
    // rust: Vec3::new(lid[0], lid[1], lid[2]),
    // rust: Vec3::new(lid[3], lid[4], lid[5]),
    // rust: ),
    // rust: )
}

// `Entity.move(MoverType.PISTON, movement)` for a pushed body: the movement
// it makes. The world's blocks stop it, and so does the world border:
// `Entity.collectCollidersIgnoringWorldBorder` adds the border's walls when
// the body is inside close to the border, as ordinary movement does.
    // rust: fn pushed_movement<W>(
    // rust: blocks: W,
    // rust: border: &BorderGeometry,
    // rust: at: [f64; 2],
    // rust: before: Aabb,
    // rust: movement: Vec3,
    // rust: step_height: f32,
    // rust: on_ground: bool,
    // rust: ) -> horizon_client::Result<Vec3>
    // rust: where
    // rust: W: BlockCollisionWorld<Error = std::io::Error> + EntityMovementWorld<Error = std::io::Error>,
    // rust: {
    // rust: EntityCollisions::with_border(blocks, border, at).resolve(
    // rust: before,
    // rust: movement,
    // rust: step_height,
    // rust: on_ground,
    // rust: )
}

    // rust: mod tests {
//     use super::*;
//     use horizon_client::collisions::EmptyCollisions;

    // A border 10 wide around the origin: its wall's inner face is at x = 5.
border :: proc() -> B {
    // Ported from Horizon
    return {}
}
    // rust: BorderGeometry::new([0.0, 0.0], 10.0, 29_999_984).expect("a border")
}

    // `Entity.collectCollidersIgnoringWorldBorder`: the border's walls stop a
    // pushed body that is inside close to the border.
a_pushed_body_stops_at_the_world_border :: proc() {
}
        // A body 0.6 wide, 0.4 blocks short of the wall, pushed east into it.
    // rust: let before = Aabb::new(Vec3::new(4.0, 0.0, 0.0), Vec3::new(4.6, 1.8, 0.6));
    // rust: let border = border();
    // rust: let moved = pushed_movement(
    // rust: EmptyCollisions,
    // rust: &border,
    // rust: [4.3, 0.3],
    // rust: before,
    // rust: Vec3::new(0.51, 0.0, 0.0),
    // rust: 0.0,
    // rust: false,
    // rust: )
    // rust: .expect("the push resolves");
        // The wall stops the body 0.4 blocks short of the whole push.
    // rust: assert!(
    // rust: (moved.x - 0.4).abs() < 1.0e-9,
    // rust: "the body was not stopped by the border: {moved:?}"
    // rust: );
}

    // Away from the border, the same push moves the whole way.
a_pushed_body_moves_whole_away_from_the_border :: proc() {
}
    // rust: let before = Aabb::new(Vec3::new(0.0, 0.0, 0.0), Vec3::new(0.6, 1.8, 0.6));
    // rust: let border = border();
    // rust: let moved = pushed_movement(
    // rust: EmptyCollisions,
    // rust: &border,
    // rust: [0.3, 0.3],
    // rust: before,
    // rust: Vec3::new(0.51, 0.0, 0.0),
    // rust: 0.0,
    // rust: false,
    // rust: )
    // rust: .expect("the push resolves");
    // rust: assert!(
    // rust: (moved.x - 0.51).abs() < 1.0e-9,
    // rust: "the body did not move the whole push: {moved:?}"
    // rust: );
}
}
