//! Transpiled from Horizon Rust crate
//! Module: horizon-client_shulker
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Shulkers (`Shulker`): fixed to a block face, peeking out of their shell,
//! firing homing bullets at players within 20 blocks, teleporting when
//! their face is lost or when badly hurt, and shrugging off arrows while
//! closed.
// use super::{
    // rust: Damage, DamageKind, Mob, MobEvent, MobWorld, Species, Who,
    // rust: anim::{Poses, State},
    // rust: control::LookKind,
    // rust: goals::{
    // rust: Cx, Goal, HurtByTarget, LOOK, LookAtPlayer, MOVE, NearestTarget, RandomLookAround,
    // rust: goal_clone, reduced,
    // rust: },
}
// use crate::projectiles::{Projectile, ProjectileWorld, STEPS};
// use horizon_core::geometry::trig::Mth;
// use horizon_core::{
    // rust: geometry::{Aabb, Direction, ShapeOp, Vec3, VoxelShape},
    // rust: random::{LegacyRandom, RandomSource},
}
// use std::f32::consts::PI;

// Shulker state: `variant3` the attach face (3D data value), `counter` the
// raw peek (0..100), `color` the shell colour (16 none). AnimState slot 0
// the current peek amount. On the client, `scratch[0]` is
// `clientSideTeleportInterpolation` and `scratch[1..3]` is
// `clientOldAttachPosition`.
pub const PEEK: usize = 0;
pub const NO_COLOR: u8 = 16;
/// `Direction.DOWN`'s 3D data value.
pub const DOWN: u8 = 0;

/// `Shulker.startRiding`: a shulker that boards a vehicle puts its attach face
/// back to `DOWN`, so it rides lid up whatever block face it was stuck to.
/// The client half clears the teleport slide (`clientOldAttachPosition` and
/// `clientSideTeleportInterpolation`).
pub fn on_start_riding(m: *mut Mob) void {
}
    // rust: if m.species() == Species::Shulker {
    // rust: m.extra.variant3 = DOWN;
    // rust: m.extra.scratch[0] = 0;
}
}

/// `Shulker.getDefaultDimensions`: a shell attached to the block below it
/// (attach face `DOWN`, its lid opening upward) grows `1 + currentPeekAmount`
/// tall as the lid opens. Width is
/// untouched, and so is every other attach face.
pub fn peek_height_scale(m: *Mob) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let peek = m.anim.v[PEEK];
    // rust: (m.extra.variant3 == DOWN && peek > 0.0).then_some(1.0 + peek)
}

pub fn register(m: *mut Mob) void {
}
    // rust: m.no_gravity = true;
    // rust: m.yaw = 0.0;
    // rust: m.body_yaw = 0.0;
    // rust: m.previous_body_yaw = 0.0;
    // rust: if m.extra.color == 0 && m.extra.variant == 0 {
    // rust: m.extra.color = NO_COLOR;
}
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(1, LookAtPlayer::new(8.0).probability(0.02));
    // rust: g.add(4, ShulkerAttack { attack_time: 0 });
    // rust: g.add(7, Peek { time: 0 });
    // rust: g.add(8, RandomLookAround::default());
    // `ShulkerLookControl`: the head turns in the attach face's plane.
    // rust: m.ai.look.kind = LookKind::Shulker;
    // `HurtByTargetGoal(this, Shulker.class).setAlertOthers()`: damage from
    // another shulker draws no retaliation (`toIgnoreDamage`), but a hurt
    // shulker alerts every targetless shulker around.
    // rust: m.ai.targets
    // rust: .add(1, HurtByTarget::new().alert().ignoring(&[Species::Shulker]));
    // ShulkerNearestAttackGoal: the search box is only 4 deep along the
    // attach axis.
    // rust: m.ai.targets.add(
    // rust: 2,
    // rust: NearestTarget::player(true).gate(peaceful_off).when(|m, w| {
    // rust: let Some(p) = &w.player else { return false };
    // rust: let d = p.position.subtract(m.position);
    // rust: let axis = match m.extra.variant3 {
    // rust: 0 | 1 => d.y,
    // rust: 2 | 3 => d.z,
    // rust: _ => d.x,
}
    // rust: axis.abs() <= 4.0 + 0.5
    // rust: }),
    // rust: );
}
pub fn face_step(face: u8) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: STEPS[face.min(5) as usize]
}
/// `Direction.getOpposite` for a 3D data value.
pub fn opposite(face: u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: face.min(5) ^ 1
}
pub fn block_pos(m: *Mob) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: ]
}
/// `Shulker.getProgressDeltaAabb` at scale 1: the shell's box from `pos`
/// (the bottom centre), grown `from`..`to` along `direction`.
pub fn progress_aabb(direction: u8, from: f64, to: f64, pos: Vec3) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let s = face_step(direction).map(f64::from);
    // rust: let (max, min) = (from.max(to), from.min(to));
    // rust: Aabb::new(Vec3::new(-0.5, 0.0, -0.5), Vec3::new(0.5, 1.0, 0.5))
    // rust: .expand_towards(Vec3::new(s[0] * max, s[1] * max, s[2] * max))
    // rust: .contract(Vec3::new(
    // rust: -s[0] * (1.0 + min),
    // rust: -s[1] * (1.0 + min),
    // rust: -s[2] * (1.0 + min),
    // rust: ))
    // rust: .move_by(pos)
}
/// Block queries shared by attachment and teleport candidates. Entity overlap
/// is checked separately, using the nearby-entity index from MobWorld.
pub const BlockSpace = struct {
    world: *'w crate::world::World,
    registry: *'r horizon_world::registry::BlockRegistry,
    facts: *'w crate::blocks::BlockFacts,
    binding: *'w horizon_world::block_collision::BlockCollisionRegistry<'r>,
    powder_walkable: bool,
};
    // rust: impl<'w, 'r> BlockSpace<'w, 'r> {
pub fn context(m: *Mob) h {
    // Implementation ported from Horizon
    return undefined;
}
//         use horizon_world::{
    // rust: collision_context::{CollisionContext, CollisionEntity, CollisionItem},
    // rust: entity_obstruction::EntityIdentity,
}
    // rust: CollisionContext::for_entity(
    // rust: CollisionEntity {
    // rust: identity: EntityIdentity(u64::from(m.id)),
                // A teleport candidate is queried before setPos changes the entity.
    // rust: y: m.position.y,
    // rust: descending: false,
    // rust: main_hand: Some(CollisionItem {
    // rust: item: m.extra.main_hand.as_deref().unwrap_or("minecraft:air"),
    // rust: count: m
    // rust: .extra
    // rust: .main_hand_stack()
    // rust: .map_or(i32::from(m.extra.main_hand.is_some()), |s| {
    // rust: s.count.min(i32::MAX as u32) as i32
    // rust: }),
    // rust: }),
    // rust: },
    // rust: false,
    // rust: )
}
pub fn scene(self: *Self, m: *Mob) c {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: crate::collisions::SceneCollisions {
    // rust: world: self.world,
    // rust: binding: self.binding,
    // rust: subject: Some(crate::collisions::PowderSnowSubject {
    // rust: fall_distance: m.fall_distance,
    // rust: leather_boots: m.extra.feet.as_deref() == Some("minecraft:leather_boots")
    // rust: && m.extra.armor[3].as_ref().is_none_or(|s| s.count > 0),
    // rust: walkable_type: self.powder_walkable,
    // rust: ..Default::default()
    // rust: }),
}
}
pub fn no_collision(self: *Self, m: *Mob, bounds: Aabb) b {
    // Implementation ported from Horizon
    return undefined;
}
//         use horizon_world::{
    // rust: entity_obstruction::EntityIdentity,
    // rust: world_movement::{CollisionCheckRequest, no_world_collision},
}
    // rust: no_world_collision(
    // rust: &mut self.scene(m),
    // rust: CollisionCheckRequest {
    // rust: entity: EntityIdentity(u64::from(m.id)),
    // rust: context: Self::context(m),
    // rust: bounds,
    // rust: candidate_budget: 1_000_000,
    // rust: },
    // rust: )
    // rust: .unwrap_or(false)
}
pub fn can_stay_at(self: *Self, m: *Mob, p: [i32; 3], face: u8) b {
    // Implementation ported from Horizon
    return undefined;
}
        // isPositionBlocked: anything but air blocks, except a moving piston
        // being driven through the shulker's own cell.
    // rust: if !self.facts.is_air(self.world.block(p[0], p[1], p[2]))
    // rust: && (p != block_pos(m)
    // rust: || self
    // rust: .registry
    // rust: .state(self.world.block(p[0], p[1], p[2]))
    // rust: .map_or("", |s| s.name.as_str())
    // rust: != "minecraft:moving_piston")
    // rust: {
    // rust: return false;
}
        // loadedAndEntityCanStandOnFace uses the entity-context collision shape,
        // not the block's generic support shape (notably different on soul sand).
    // rust: let s = face_step(face);
    // rust: let support_pos =
    // rust: horizon_core::position::BlockPos::new(p[0] + s[0], p[1] + s[1], p[2] + s[2]);
    // rust: let support = self
    // rust: .world
    // rust: .block(support_pos.x, support_pos.y, support_pos.z);
    // rust: let open = opposite(face);
    // rust: let Ok(shape) = self.binding.collision_shape_with_context(
    // rust: &mut self.scene(m),
    // rust: support,
    // rust: support_pos,
    // rust: &Self::context(m),
    // rust: ) else {
    // rust: return false;
}
        // Block.isFaceFull. A full cube, what shulkers cling to almost always
        // (canStayAt runs every tick), is full on every face: skip the shape ops.
    // rust: let full = shape.is_block()
    // rust: || shape
    // rust: .face_shape(Direction::ALL[open as usize])
    // rust: .is_ok_and(|face| {
    // rust: VoxelShape::block()
    // rust: .join_is_not_empty(&face, ShapeOp::XOR)
    // rust: .is_ok_and(|differs| !differs)
    // rust: });
    // rust: full && self.no_collision(m, attachment_box(p, face))
}
}
    // rust: fn block_space<'w, 'r>(m: &Mob, w: &'w MobWorld<'r>) -> BlockSpace<'w, 'r> {
    // rust: BlockSpace {
    // rust: world: w.world,
    // rust: registry: w.registry,
    // rust: facts: w.facts,
    // rust: binding: w.collision,
    // rust: powder_walkable: w
    // rust: .data
    // rust: .entity_has("minecraft:powder_snow_walkable_mobs", &m.kind.id),
}
}
pub fn entities_clear(m: *Mob, w: *MobWorld, bounds: Aabb) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let grown = bounds.inflate(Vec3::new(1.0e-7, 1.0e-7, 1.0e-7));
    // rust: !w.others_near(grown).any(|s| {
    // rust: s.id != m.id
    // rust: && s.alive
    // rust: && (s.species == Species::Shulker || (s.species == Species::HappyGhast && !s.baby))
    // rust: && s.bounds.intersects(grown)
    // rust: })
}
pub fn no_collision(m: *Mob, w: *MobWorld, bounds: Aabb) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: block_space(m, w).no_collision(m, bounds) && entities_clear(m, w, bounds)
}
pub fn attachment_box(p: [i32; 3], face: u8) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: progress_aabb(
    // rust: opposite(face),
    // rust: -1.0,
    // rust: 1.0,
    // rust: Vec3::new(
    // rust: f64::from(p[0]) + 0.5,
    // rust: f64::from(p[1]),
    // rust: f64::from(p[2]) + 0.5,
    // rust: ),
    // rust: )
    // rust: .deflate(Vec3::new(1.0e-6, 1.0e-6, 1.0e-6))
}
/// Shulker.canStayAt, including its separately indexed collidable entities.
pub fn can_stay_at(m: *Mob, w: *MobWorld, p: [i32; 3], face: u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: block_space(m, w).can_stay_at(m, p, face) && entities_clear(m, w, attachment_box(p, face))
}
/// `findAttachableSurface`: the first face (down, up, north, south, west,
/// east) to cling to.
pub fn attachable(m: *Mob, w: *MobWorld, p: [i32; 3]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (0..6).find(|&f| can_stay_at(m, w, p, f))
}
/// `BlockUtil.packDifferenceInPosition` within 8 blocks of `pos`.
pub fn pack_diff(pos: [i32; 3], to: [i32; 3]) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ((to[0] - pos[0] + 8) & 0xFF) << 16
    // rust: | ((to[1] - pos[1] + 8) & 0xFF) << 8
    // rust: | (to[2] - pos[2] + 8) & 0xFF
}
/// `Shulker.teleportSomewhere`: up to five tries within 8 blocks.
pub fn teleport(m: *mut Mob, w: *MobWorld, events: *mut std.ArrayList(MobEvent)) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !m.alive() {
    // rust: return false;
}
    // rust: let old = block_pos(m);
    // rust: for _ in 0..5 {
    // rust: let r = |m: &mut Mob| m.random.next_int_bound(17).unwrap_or(8) - 8;
    // rust: let t = [old[0] + r(m), old[1] + r(m), old[2] + r(m)];
    // rust: let unit = Aabb::new(
    // rust: Vec3::new(f64::from(t[0]), f64::from(t[1]), f64::from(t[2])),
    // rust: Vec3::new(
    // rust: f64::from(t[0]) + 1.0,
    // rust: f64::from(t[1]) + 1.0,
    // rust: f64::from(t[2]) + 1.0,
    // rust: ),
    // rust: );
    // rust: if t[1] <= w.world.bottom_y()
    // rust: || !w.facts.is_air(w.world.block(t[0], t[1], t[2]))
    // rust: || !no_collision(m, w, unit.deflate(Vec3::new(1.0e-6, 1.0e-6, 1.0e-6)))
    // rust: {
    // rust: continue;
}
    // rust: let Some(face) = attachable(m, w, t) else {
    // rust: continue;
}
        // `#minecraft:shulker_does_not_teleport_to` (bedrock) is never clung to.
    // rust: let s = face_step(face);
    // rust: if w.has_tag(
    // rust: "minecraft:shulker_does_not_teleport_to",
    // rust: w.block_name(t[0] + s[0], t[1] + s[1], t[2] + s[2]),
    // rust: ) {
    // rust: continue;
}
    // rust: m.extra.variant3 = face;
    // rust: events.push(MobEvent::Sound(
    // rust: "entity.shulker.teleport",
    // rust: [m.position.x, m.position.y, m.position.z],
    // rust: 1.0,
    // rust: 1.0,
    // rust: ));
    // rust: m.position = Vec3::new(
    // rust: f64::from(t[0]) + 0.5,
    // rust: f64::from(t[1]),
    // rust: f64::from(t[2]) + 0.5,
    // rust: );
    // rust: m.previous = m.position;
        // Level.levelEvent(2016, oldPos, packedDiff): the teleport's
        // particles at both ends, seen by the players around.
    // rust: events.push(MobEvent::LevelEvent {
    // rust: id: 2016,
    // rust: pos: old,
    // rust: data: pack_diff(old, t),
    // rust: });
    // rust: m.needs_sync = true;
    // rust: m.extra.counter = 0;
    // rust: m.ai.target = None;
    // rust: return true;
}
    // rust: false
}
/// `Shulker.setRawPeekAmount`: the shell opens or closes with a sound.
pub fn set_peek(m: *mut Mob, amount: i32, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: let sound = if amount == 0 {
    // rust: "entity.shulker.close"
    // rust: } else {
    // rust: "entity.shulker.open"
}
    // rust: events.push(MobEvent::Sound(
    // rust: sound,
    // rust: [m.position.x, m.position.y, m.position.z],
    // rust: 1.0,
    // rust: 1.0,
    // rust: ));
    // Shulker.setRawPeekAmount: CONTAINER_CLOSE as the lid shuts, CONTAINER_OPEN as it opens.
    // rust: events.push(MobEvent::GameEvent {
    // rust: event: if amount == 0 {
    // rust: "minecraft:container_close"
    // rust: } else {
    // rust: "minecraft:container_open"
    // rust: },
    // rust: at: [m.position.x, m.position.y, m.position.z],
    // rust: source: m.id,
    // rust: state: horizon_world::registry::BlockStateId(0),
    // rust: });
    // rust: m.extra.counter = amount;
}
/// `Shulker.updatePeekAmount`/`updatePeekAmountO`: the eased peek.
pub fn ease_peek(m: *mut Mob) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let old = m.anim.v[PEEK];
    // rust: let target = m.extra.counter as f32 * 0.01;
    // rust: let new = if old > target {
    // rust: (old - 0.05).clamp(target, 1.0)
    // rust: } else {
    // rust: (old + 0.05).clamp(0.0, target)
}
    // rust: m.anim.v[PEEK] = new;
    // rust: (old, new)
}
/// `Shulker.tick` additions: keep a face (or teleport), ease the peek
/// (pushing whatever it opens into), stay still and square on its block.
pub fn tick(m: *mut Mob, w: *MobWorld, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: m.velocity = Vec3::ZERO;
    // rust: m.body_yaw = 0.0;
    // rust: m.yaw = 0.0;
    // rust: m.head_pitch = 0.0;
    // rust: let p = block_pos(m);
    // rust: if !can_stay_at(m, w, p, m.extra.variant3) {
    // rust: match attachable(m, w, p) {
    // rust: Some(f) => m.extra.variant3 = f,
    // rust: None => {
    // rust: teleport(m, w, events);
}
}
}
    // rust: let (old, new) = ease_peek(m);
    // rust: if new != old {
    // rust: on_peek_change(m, w, old, new, events);
}
}
/// `Shulker.getPhysicalPeek`: the lid's lift for a peek amount.
pub fn physical_peek(amount: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: f64::from(0.5 - ((0.5 + amount) * PI).msin() * 0.5)
}
/// `Shulker.onPeekAmountChange`: an opening shell pushes out of its way
/// every entity that can be collided with (except other shulkers).
pub fn on_peek_change(m: *Mob, w: *MobWorld, old: f32, new: f32, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: let dir = opposite(m.extra.variant3);
    // rust: let s = face_step(dir).map(f64::from);
    // rust: let (old_p, new_p) = (physical_peek(old), physical_peek(new));
    // rust: let push = new_p - old_p;
    // rust: if push <= 0.0 {
    // rust: return;
}
    // rust: let delta = [push * s[0], push * s[1], push * s[2]];
    // rust: let area = progress_aabb(dir, old_p, new_p, m.position);
    // rust: if let Some(p) = &w.player
    // rust: && p.alive
    // rust: && !p.spectator
    // rust: && p.bounds.intersects(area)
    // rust: {
    // rust: events.push(MobEvent::Shift {
    // rust: target: Who::Player,
    // rust: delta,
    // rust: });
}
    // rust: for seen in w.others_near(area) {
    // rust: if seen.id == m.id
    // rust: || !seen.alive
    // rust: || seen.species == Species::Shulker
    // rust: || !seen.bounds.intersects(area)
    // rust: {
    // rust: continue;
}
    // rust: events.push(MobEvent::Shift {
    // rust: target: Who::Mob(seen.id),
    // rust: delta,
    // rust: });
}
}
/// `ShulkerLookControl.getYRotD`: the look yaw in the open direction's
/// plane (`None`: the target is on the head's own axis).
pub fn look_yaw(m: *Mob, at: [f64; 3]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let open = opposite(m.extra.variant3);
    // `attachFace.getRotation().transform(FORWARD)`: the model's forward
    // rotated as the renderer does (`rotations` uses the same quats).
    // rust: let forward = face_quat(m.extra.variant3) * glam::Vec3::Z;
    // rust: let s = face_step(open).map(|v| v as f32);
    // rust: let right = glam::Vec3::from_array(s).cross(forward);
    // rust: let out = glam::Vec3::new(
    // rust: (at[0] - m.position.x) as f32,
    // rust: (at[1] - m.eye_y()) as f32,
    // rust: (at[2] - m.position.z) as f32,
    // rust: );
    // rust: let (delta_right, delta_forward) = (right.dot(out), forward.dot(out));
    // rust: if delta_right.abs() <= 1.0e-5 && delta_forward.abs() <= 1.0e-5 {
    // rust: return None;
}
    // rust: Some(horizon_core::geometry::trig::atan2_degrees(
    // rust: f64::from(-delta_right),
    // rust: f64::from(delta_forward),
    // rust: ))
}
/// `Shulker.tick` on a client that is not the server: the teleport slide
/// counts down (`setPos` armed it when the move packet arrived), the lid
/// eases to the peek it was sent, and the body stays square
/// (`ShulkerBodyRotationControl`).
pub fn client_tick(m: *mut Mob) void {
}
    // rust: if m.extra.scratch[0] > 0 {
    // rust: m.extra.scratch[0] -= 1;
}
    // rust: m.anim.vo = m.anim.v;
    // rust: ease_peek(m);
    // rust: m.body_yaw = 0.0;
}
/// `Shulker.setPos`. A shulker's interpolation handler is `NO_OP`, so a move
/// packet lands here instead of being stepped. Not a passenger: the position
/// snaps to the block centre. A block change after the first tick closes the
/// lid, and, off a vehicle and other than toward the block the current slide
/// remembers, starts the 6-tick slide from the block it was in before the
/// packet and snaps `previous` so ordinary interpolation does not also run.
pub fn client_set_pos(m: *mut Mob, x: f64, y: f64, z: f64) void {
}
    // rust: let old = block_pos(m);
    // rust: m.position = if m.extra.passenger {
    // rust: Vec3::new(x, y, z)
    // rust: } else {
    // rust: Vec3::new(x.floor() + 0.5, (y + 0.5).floor(), z.floor() + 0.5)
}
    // `setPos` sees `tickCount == 0` and starts nothing.
    // rust: if m.age == 0 {
    // rust: return;
}
    // rust: let pos = block_pos(m);
    // rust: if pos == old {
    // rust: return;
}
    // rust: m.extra.counter = 0;
    // rust: if m.extra.passenger {
    // rust: return;
}
    // rust: let remembered = [m.extra.scratch[1], m.extra.scratch[2], m.extra.scratch[3]];
    // rust: if m.extra.scratch[0] > 0 && pos == remembered {
    // rust: return;
}
    // rust: m.extra.scratch[1] = old[0];
    // rust: m.extra.scratch[2] = old[1];
    // rust: m.extra.scratch[3] = old[2];
    // rust: m.extra.scratch[0] = 6;
    // rust: m.previous = m.position;
}
/// `Shulker.getRenderPosition`: while the slide has ticks left, the model is
/// pulled back toward the block it left by `((ticks - partial) / 6)^2`,
/// times `getScale`. Vanilla's `null` is no offset.
pub fn render_offset(m: *Mob, alpha: f32) g {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let ticks = m.extra.scratch[0];
    // rust: if m.species() != Species::Shulker || ticks <= 0 {
    // rust: return glam::DVec3::ZERO;
}
    // rust: let mut scale = (f64::from(ticks) - f64::from(alpha)) / 6.0;
    // rust: scale *= scale;
    // rust: scale *= f64::from(m.model_scale());
    // rust: let current = block_pos(m);
    // rust: let old = [m.extra.scratch[1], m.extra.scratch[2], m.extra.scratch[3]];
    // rust: glam::DVec3::new(
    // rust: -f64::from(current[0] - old[0]) * scale,
    // rust: -f64::from(current[1] - old[1]) * scale,
    // rust: -f64::from(current[2] - old[2]) * scale,
    // rust: )
}
/// `Shulker.hurtServer` before the damage: arrows bounce off a closed shell.
pub fn accepts(m: *Mob, source: *Damage) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !(m.extra.counter == 0 && source.kind == DamageKind::Arrow)
}
/// `Shulker.hurtServer` after the damage: below half health, a one in four
/// chance to teleport away.
pub fn after_hurt(m: *mut Mob) void {
}
    // rust: if m.health < m.attrs.max_health * 0.5 && m.random.next_int_bound(4).unwrap_or(1) == 0 {
        // The teleport needs the world: ask for it on the next tick.
    // rust: m.extra.flag = true;
}
}
/// `Shulker.hurtServer` after a shulker bullet's damage: unless the
/// low-health teleport was drawn instead (`else if`), `hitByShulkerBullet`
/// runs on the next tick. Whether the shell is open is read here, at hurt
/// time, so a goal opening it before that tick cannot change the outcome.
pub fn hit_by_bullet(m: *mut Mob) void {
}
    // rust: if m.species() == Species::Shulker && !m.extra.flag && m.extra.counter != 0 {
    // rust: m.extra.flag2 = true;
}
}
/// The deferred teleport of `after_hurt` and `hitByShulkerBullet`.
    // rust: pub fn ai_step(
    // rust: m: &mut Mob,
    // rust: w: &MobWorld,
    // rust: level_random: &mut LegacyRandom,
    // rust: events: &mut Vec<MobEvent>,
    // rust: ) {
    // rust: if m.extra.flag {
    // rust: m.extra.flag = false;
    // rust: teleport(m, w, events);
}
    // rust: if m.extra.flag2 {
    // rust: m.extra.flag2 = false;
    // rust: hit_by_shulker_bullet(m, w, level_random, events);
}
}
/// `Shulker.hitByShulkerBullet` (only queued by an open shulker): it
/// teleports, and leaves a new one of its colour behind unless shulkers
/// crowd the place (one in five fewer chances for every other shulker
/// within 8 blocks).
    // rust: fn hit_by_shulker_bullet(
    // rust: m: &mut Mob,
    // rust: w: &MobWorld,
    // rust: level_random: &mut LegacyRandom,
    // rust: events: &mut Vec<MobEvent>,
    // rust: ) {
    // rust: let old_position = m.position;
    // rust: let old_box = m.bounds();
    // rust: if !teleport(m, w, events) {
    // rust: return;
}
    // rust: let area = old_box.inflate(Vec3::new(8.0, 8.0, 8.0));
    // The shulker itself stands within reach of its old box, so it counts.
    // rust: let others = w
    // rust: .others_near(area)
    // rust: .filter(|s| {
    // rust: s.alive && s.species == Species::Shulker && s.id != m.id && s.bounds.intersects(area)
    // rust: })
    // rust: .count();
    // rust: let failure_chance = others as f32 / 5.0;
    // The level's random, not the shulker's.
    // rust: if level_random.next_float() < failure_chance {
    // rust: return;
}
    // rust: let mut baby = Mob::new(0, m.kind.clone(), old_position, 0.0);
    // rust: baby.extra.color = m.extra.color;
    // rust: events.push(MobEvent::Spawn(Box::new(baby)));
}
/// A ProjectileWorld over the mob world, for aiming a new bullet.
pub const Probe = struct {
    w: *'a MobWorld<'w>,
    targets: Vec<(Who,
};
    // rust: impl ProjectileWorld for Probe<'_, '_> {
pub fn clip(self: *Self, _: Vec3, _: Vec3) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: None
}
pub fn in_water(self: *Self, _: Aabb) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: false
}
pub fn targets(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.targets
}
pub fn empty(self: *Self, p: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.w.facts.is_air(self.w.world.block(p[0], p[1], p[2]))
}
pub fn solid(self: *Self, p: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.w
    // rust: .facts
    // rust: .get(self.w.world.block(p[0], p[1], p[2]))
    // rust: .full_collision
}
}
/// `level().getDifficulty() != Difficulty.PEACEFUL`, which the shulker's
/// attack goal and target goal check.
pub fn peaceful_off(_m: *Mob, w: *MobWorld) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: w.difficulty.effective != 0.0
}
/// `ShulkerAttackGoal`: open up and fire a bullet every one to five and a
/// half seconds at a target within 20 blocks.
pub const ShulkerAttack = struct {
    attack_time: i32,
};
    // rust: impl Goal for ShulkerAttack {
    // rust: goal_clone!();
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: MOVE | LOOK
}
pub fn every_tick(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
pub fn can_use(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.target_info(cx.w).is_some_and(|t| t.alive) && peaceful_off(m, cx.w)
}
pub fn start(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: self.attack_time = 20;
    // rust: set_peek(m, 100, cx.events);
}
pub fn stop(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: set_peek(m, 0, cx.events);
}
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: if !peaceful_off(m, cx.w) {
    // rust: return;
}
    // rust: self.attack_time -= 1;
    // rust: let (Some(who), Some(t)) = (m.ai.target, m.target_info(cx.w)) else {
    // rust: return;
}
    // rust: m.look_at_speed([t.position.x, t.eye_y, t.position.z], 180.0, 180.0);
    // rust: if t.position.distance_squared(m.position) >= 400.0 {
    // rust: m.ai.target = None;
    // rust: return;
}
    // rust: if self.attack_time > 0 {
    // rust: return;
}
    // rust: self.attack_time = 20 + m.random.next_int_bound(10).unwrap_or(0) * 20 / 2;
    // rust: let probe = Probe {
    // rust: w: cx.w,
    // rust: targets: vec![(who, t.bounds)],
}
    // rust: let axis = match m.extra.variant3 {
    // rust: 0 | 1 => 1,
    // rust: 2 | 3 => 2,
    // rust: _ => 0,
}
    // rust: let seed = m.random.next_long() as u64 | 1;
    // rust: let bullet =
    // rust: Projectile::shulker_bullet(&probe, block_pos(m), Who::Mob(m.id), who, axis, seed);
    // rust: cx.events.push(MobEvent::Projectile(bullet));
    // rust: let pitch = (m.random.next_float() - m.random.next_float()) * 0.2 + 1.0;
    // rust: cx.events.push(MobEvent::Sound(
    // rust: "entity.shulker.shoot",
    // rust: [m.position.x, m.position.y, m.position.z],
    // rust: 2.0,
    // rust: pitch,
    // rust: ));
}
}
/// `ShulkerPeekGoal`: idle peeks of one to three seconds.
pub const Peek = struct {
    time: i32,
};
    // rust: impl Goal for Peek {
    // rust: goal_clone!();
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 0
}
pub fn can_use(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.ai.target.is_none()
    // rust: && m.random.next_int_bound(reduced(40)).unwrap_or(1) == 0
    // rust: && can_stay_at(m, cx.w, block_pos(m), m.extra.variant3)
}
pub fn can_continue(self: *Self, m: *mut Mob, _cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.ai.target.is_none() && self.time > 0
}
pub fn start(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: self.time = reduced(20 * (1 + m.random.next_int_bound(3).unwrap_or(0)));
    // rust: set_peek(m, 30, cx.events);
}
pub fn stop(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: if m.ai.target.is_none() {
    // rust: set_peek(m, 0, cx.events);
}
}
pub fn tick(self: *Self, _m: *mut Mob, _cx: *mut Cx) void {
}
    // rust: self.time -= 1;
}
}
/// The shell's texture: plain or dyed.
pub fn texture(m: *Mob) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: const COLORS: [&str; 16] = [
    // rust: "white",
    // rust: "orange",
    // rust: "magenta",
    // rust: "light_blue",
    // rust: "yellow",
    // rust: "lime",
    // rust: "pink",
    // rust: "gray",
    // rust: "light_gray",
    // rust: "cyan",
    // rust: "purple",
    // rust: "blue",
    // rust: "brown",
    // rust: "green",
    // rust: "red",
    // rust: "black",
    // rust: ];
    // rust: match COLORS.get(m.extra.color as usize) {
    // rust: Some(c) => format!("entity/shulker/shulker_{c}"),
    // rust: None => "entity/shulker/shulker".into(),
}
}
/// `attachFace.getOpposite().getRotation()` by attach face: the open
/// direction's rotation (`Direction.getRotation` of `face ^ 1`).
pub fn face_quat(face: u8) g {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match face.min(5) {
        // Attached below: upright.
    // rust: 0 => glam::Quat::IDENTITY,
    // rust: 1 => glam::Quat::from_rotation_x(PI),
    // rust: 2 => glam::Quat::from_rotation_x(PI / 2.0),
    // rust: 3 => glam::Quat::from_euler(glam::EulerRot::XYZ, PI / 2.0, 0.0, PI),
    // rust: 4 => glam::Quat::from_euler(glam::EulerRot::XYZ, PI / 2.0, 0.0, -PI / 2.0),
    // rust: _ => glam::Quat::from_euler(glam::EulerRot::XYZ, PI / 2.0, 0.0, PI / 2.0),
}
}
/// `ShulkerRenderer.setupRotations`: turned onto its attach face around the
/// block's centre (after a half turn of the body).
pub fn rotations(m: *Mob) g {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let q = face_quat(m.extra.variant3);
    // rust: glam::Mat4::from_rotation_y(PI)
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(0.0, 0.5, 0.0))
    // rust: * glam::Mat4::from_quat(q)
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(0.0, -0.5, 0.0))
}
/// `ShulkerModel.setupAnim`: the lid rises and twists with the peek, the
/// head turns.
pub fn anim(m: *Mob, s: *State, p: *mut Poses) void {
}
    // rust: let peek = m.anim.lerp(PEEK, s.partial);
    // rust: let bs = (0.5 + peek) * PI;
    // rust: let q = -1.0 + bs.msin();
    // rust: let extra = if bs > PI {
    // rust: (s.age * 0.1).msin() * 0.7
    // rust: } else {
    // rust: 0.0
}
    // rust: let lid = p.get("lid");
    // rust: lid[1] = 16.0 + bs.msin() * 8.0 + extra;
    // rust: lid[4] = if peek > 0.3 {
    // rust: q * q * q * q * PI * 0.125
    // rust: } else {
    // rust: 0.0
}
    // rust: p.xrot("head", s.x_rot.to_radians());
    // rust: p.yrot("head", (s.y_rot - 180.0).to_radians());
}

    // rust: mod space_tests;

    // rust: mod tests {
//     use super::*;
//     use crate::mobs::sensor_scan_tests::kind;
//     use std::sync::Arc;

    /// Shulker.setRawPeekAmount: the lid opening posts CONTAINER_OPEN and shutting
    /// CONTAINER_CLOSE, for the sculk sensors and wardens nearby.
pub fn the_lid_posts_container_open_and_close() void {
}
    // rust: let posted = |events: &[MobEvent]| -> Vec<&'static str> {
    // rust: events
    // rust: .iter()
    // rust: .filter_map(|e| match e {
    // rust: MobEvent::GameEvent { event, .. } => Some(*event),
    // rust: _ => None,
    // rust: })
    // rust: .collect()
}
    // rust: let mut m = shulker();
    // rust: let mut events = Vec::new();
    // rust: set_peek(&mut m, 30, &mut events);
    // rust: assert_eq!(posted(&events), ["minecraft:container_open"]);
    // rust: let mut events = Vec::new();
    // rust: set_peek(&mut m, 0, &mut events);
    // rust: assert_eq!(posted(&events), ["minecraft:container_close"]);
}

    /// A shulker fixed to a block face.
    // rust: pub(super) fn shulker() -> Mob {
    // rust: let mut kind = kind();
    // rust: let k = Arc::make_mut(&mut kind);
    // rust: k.id = "minecraft:shulker".into();
    // rust: k.species = Species::Shulker;
    // rust: k.max_head_y_rot = 180.0;
        // EntityTypes.SHULKER: sized(1.0F, 1.0F).eyeHeight(0.5F).
    // rust: k.width = 1.0;
    // rust: k.height = 1.0;
    // rust: k.eye_height = 0.5;
    // rust: let mut m = Mob::new(1, kind, Vec3::ZERO, 0.0);
    // rust: m.extra.variant3 = 2;
    // rust: m
}

    /// `Shulker.hurtServer` returns false for an `AbstractArrow` while
    /// `isClosed` (raw peek 0). An open shell takes the same arrow.
pub fn a_closed_shell_refuses_an_arrow() void {
}
    // rust: let source = Damage::of(DamageKind::Arrow);
    // rust: let mut closed = shulker();
    // rust: closed.extra.counter = 0;
    // rust: let health = closed.health;
    // rust: assert!(
    // rust: !closed.damage_projectile(2.0, source, None, [0.0, 1.0]),
    // rust: "a closed shell rejects the arrow"
    // rust: );
    // rust: assert_eq!(closed.health, health);
    // rust: let mut open = shulker();
    // rust: open.extra.counter = 30;
    // rust: assert!(open.damage_projectile(2.0, source, None, [0.0, 1.0]));
    // rust: assert!(open.health < health);
}

pub fn a_move_packet_starts_the_teleport_slide() void {
}
        // Shulker.createInterpolationHandler is NO_OP, so the packet's end
        // position is setPos. The slide is armed there, from the block before
        // the packet, and client_tick only counts it down.
    // rust: let mut m = shulker();
    // rust: m.age = 10;
    // rust: m.position = Vec3::new(0.5, 0.0, 0.5);
    // rust: m.previous = m.position;
    // rust: client_set_pos(&mut m, 3.2, 1.0, 0.4);
    // rust: assert_eq!(m.position, Vec3::new(3.5, 1.0, 0.5));
    // rust: assert_eq!(m.previous, m.position);
    // rust: assert_eq!(m.extra.scratch[0], 6);
    // rust: assert_eq!(render_offset(&m, 0.0), glam::DVec3::new(-3.0, -1.0, 0.0));
    // rust: client_tick(&mut m);
    // rust: assert_eq!(m.extra.scratch[0], 5);
        // A tick with no new packet does not look at previous and re-arm.
    // rust: m.previous = Vec3::new(80.0, 0.0, 0.0);
    // rust: client_tick(&mut m);
    // rust: assert_eq!(m.extra.scratch[0], 4);
}

pub fn a_riding_shulker_closes_its_lid_but_does_not_slide() void {
}
        // Shulker.setPos on a passenger: the exact position, the peek set to
        // 0 on a block change, and no clientSideTeleportInterpolation.
    // rust: let mut m = shulker();
    // rust: m.age = 10;
    // rust: m.extra.passenger = true;
    // rust: m.extra.counter = 30;
    // rust: m.position = Vec3::new(0.5, 0.0, 0.5);
    // rust: client_set_pos(&mut m, 2.25, 0.4, 0.5);
    // rust: assert_eq!(m.position, Vec3::new(2.25, 0.4, 0.5));
    // rust: assert_eq!(m.extra.counter, 0);
    // rust: assert_eq!(m.extra.scratch[0], 0);
    // rust: assert_eq!(render_offset(&m, 0.0), glam::DVec3::ZERO);
}

pub fn the_body_stays_square_while_the_head_turns() void {
}
        // Shulker.recreateFromPacket sets the body rotation to 0 and
        // Shulker.ShulkerBodyRotationControl.clientTick is empty, so the
        // shulker's body never turns: it stays square to the block it is
        // fixed to and only its head turns (#1661).
    // rust: let mut m = shulker();
    // rust: m.yaw = 90.0;
    // rust: m.head_yaw = 90.0;
        // It moved, so a body that follows the mob would turn with it.
    // rust: m.previous = Vec3::new(1.0, 0.0, 0.0);
    // rust: m.body_rotation_tick();
    // rust: assert_eq!(
    // rust: m.body_yaw, 0.0,
    // rust: "the shulker's body stays square to the block"
    // rust: );
    // rust: assert_eq!(m.previous_body_yaw, 0.0);
        // A mob that moves turns its body to where it goes.
    // rust: let mut other = Mob::new(2, kind(), Vec3::ZERO, 0.0);
    // rust: other.yaw = 90.0;
    // rust: other.previous = Vec3::new(1.0, 0.0, 0.0);
    // rust: other.body_rotation_tick();
    // rust: assert_eq!(other.body_yaw, 90.0);
}

pub fn the_head_turns_to_its_target() void {
}
        // ShulkerLookControl.clampHeadRotationToBody does nothing, so the
        // head is not clamped to the square body: it turns to the target.
    // rust: let mut m = shulker();
    // rust: m.ai.look.kind = LookKind::Shulker;
    // rust: for _ in 0..20 {
            // A goal keeps the look up to date every tick.
    // rust: m.ai.look.set_look_at([5.0, 0.0, 0.0], 10.0, 10.0);
    // rust: m.look_control_tick();
}
    // rust: assert!(
    // rust: m.head_yaw.abs() > 45.0,
    // rust: "the head turns to the target, not back to the square body"
    // rust: );
    // rust: assert_eq!(m.body_yaw, 0.0);
}

pub fn an_open_shell_on_the_floor_stands_taller() void {
}
        // Shulker.getDefaultDimensions: a shell on Direction.DOWN (attach
        // face 0) with currentPeekAmount p is `scale(1, 1 + p)` of its
        // 1 x 1 x 0.5 box — the width is untouched, the height and the eyes
        // grow. A client eases the peek 0.05 a tick towards the synced raw
        // peek, 100 while ShulkerAttackGoal holds the lid open.
    // rust: let mut m = shulker();
    // rust: m.extra.variant3 = DOWN;
    // rust: m.extra.counter = 100;
    // rust: for _ in 0..10 {
    // rust: client_tick(&mut m);
}
    // rust: assert!((m.anim.v[PEEK] - 0.5).abs() < 1e-6, "{}", m.anim.v[PEEK]);
    // rust: let (w, h, e) = m.dims();
    // rust: assert!(
    // rust: (w - 1.0).abs() < 1e-9 && (h - 1.5).abs() < 1e-5 && (e - 0.75).abs() < 1e-5,
    // rust: "a half open shell is 1 x 1.5 with its eyes at 0.75: {w} x {h} x {e}"
    // rust: );
        // The same box `Mob::bounds_at` and the culling build from `height`.
    // rust: assert!((f64::from(m.height()) - 1.5).abs() < 1e-5, "{}", m.height());
}

pub fn only_a_shell_on_the_floor_grows() void {
}
        // Every other attach face keeps the plain 1 x 1 x 0.5 box, however
        // far the lid opens.
    // rust: for face in [1u8, 2, 3, 4, 5] {
    // rust: let mut m = shulker();
    // rust: m.extra.variant3 = face;
    // rust: m.extra.counter = 100;
    // rust: for _ in 0..20 {
    // rust: client_tick(&mut m);
}
    // rust: assert_eq!(m.anim.v[PEEK], 1.0);
    // rust: let (w, h, e) = m.dims();
    // rust: assert!(
    // rust: (w - 1.0).abs() < 1e-9 && (h - 1.0).abs() < 1e-9 && (e - 0.5).abs() < 1e-9,
    // rust: "a shell on face {face} stays 1 x 1: {w} x {h} x {e}"
    // rust: );
}
        // A closed one on the floor does not grow either.
    // rust: let mut m = shulker();
    // rust: m.extra.variant3 = DOWN;
    // rust: let (_, h, _) = m.dims();
    // rust: assert!((h - 1.0).abs() < 1e-9, "{h}");
}
}
