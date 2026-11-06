//! Transpiled from Horizon Rust crate
//! Module: horizon-client_leash
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Leads (`Leashable`): who holds a mob's lead and the elastic physics of
//! `Leashable.tickLeash` (a pull once the rope stretches past six blocks,
//! the lead snapping past twelve, `PathfinderMob`'s walk toward the holder
//! while the rope is slack).
// use super::{Mob, MobEvent, MobWorld, Species, Who};
// use horizon_core::geometry::Vec3;
// use horizon_world::nbt::Tag;

/// `Leashable.LEASH_ELASTIC_DIST`.
pub const ELASTIC: f64 = 6.0;
/// `Leashable.LEASH_TOO_FAR_DIST`.
pub const SNAP: f64 = 12.0;

/// What holds the other end of a lead.
pub const Holder = enum {
    Player,
    Mob(u32),
    /// A boat or raft (`AbstractBoat` is `Leashable`, and any entity can be a holder).
    Boat(u32),
    /// A `LeashFenceKnotEntity` on the fence at this block.
    Knot([i32; 3]),
};
    // rust: impl Holder {
pub fn who(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Holder::Player => Some(Who::Player),
    // rust: Holder::Mob(id) => Some(Who::Mob(id)),
    // rust: Holder::Boat(_) | Holder::Knot(_) => None,
}
}
}
/// A holder read from a save that is not in the world yet (the entity may
/// load later): the holder's UUID, or the fence knot's block.
pub const Pending = enum {
    Uuid([i32; 4]),
    Knot([i32; 3]),
};
/// `Leashable.LeashData.CODEC`: `{UUID: [I;..]}` for an entity holder or the
/// fence's block position as an int array.
pub fn pending_from_nbt(tag: ?*Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match tag? {
    // rust: Tag::IntArray(p) if p.len() == 3 => Some(Pending::Knot([p[0], p[1], p[2]])),
    // rust: t @ Tag::Compound(_) => crate::save::uuid_from_tag(t.get("UUID")).map(Pending::Uuid),
    // rust: _ => None,
}
}
/// The `leash` tag for a holder: the holder entity's UUID, or the knot's block.
pub fn to_nbt(holder: Holder, uuid: ?[i32; 4]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match holder {
    // rust: Holder::Knot(p) => Some(Tag::IntArray(p.to_vec())),
    // rust: _ => uuid.map(|u| Tag::compound([("UUID", Tag::IntArray(u.to_vec()))])),
}
}
/// Where the other end of the lead is this tick.
pub const HolderState = struct {
    position: Vec3,
    center: Vec3,
    width: f64,
    height: f64,
    yaw: f32,
    velocity: Vec3,
};
/// `LeashFenceKnotEntity`: 0.375 wide, 0.5 tall, centred a block's 0.375 up.
pub fn knot_state(pos: [i32; 3]) H {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let position = Vec3::new(
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(pos[1]) + 0.375,
    // rust: f64::from(pos[2]) + 0.5,
    // rust: );
    // rust: HolderState {
    // rust: position,
    // rust: center: Vec3::new(position.x, position.y + 0.25, position.z),
    // rust: width: 0.375,
    // rust: height: 0.5,
    // rust: yaw: 0.0,
    // rust: velocity: Vec3::ZERO,
}
}
/// The holder's state, or `None` when it is gone.
pub fn holder_state(w: *MobWorld, holder: Holder) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match holder {
    // rust: Holder::Player => {
    // rust: let p = w.player.as_ref()?;
    // rust: let size = p.bounds.max_position().subtract(p.bounds.min_position());
    // rust: Some(HolderState {
    // rust: position: p.position,
    // rust: center: Vec3::new(p.position.x, p.position.y + size.y / 2.0, p.position.z),
    // rust: width: size.x,
    // rust: height: size.y,
    // rust: yaw: p.yaw,
    // rust: velocity: p.velocity,
    // rust: })
}
    // rust: Holder::Mob(id) => {
    // rust: let s = w.seen(id).filter(|s| s.alive)?;
    // rust: let lo = s.bounds.min_position();
    // rust: let hi = s.bounds.max_position();
    // rust: Some(HolderState {
    // rust: position: s.position,
    // rust: center: Vec3::new(
    // rust: (lo.x + hi.x) / 2.0,
    // rust: (lo.y + hi.y) / 2.0,
    // rust: (lo.z + hi.z) / 2.0,
    // rust: ),
    // rust: width: hi.x - lo.x,
    // rust: height: hi.y - lo.y,
    // rust: yaw: s.yaw,
    // rust: velocity: s.velocity,
    // rust: })
}
    // rust: Holder::Boat(id) => w
    // rust: .leash_boats
    // rust: .iter()
    // rust: .find(|(boat, _)| *boat == id)
    // rust: .map(|(_, state)| *state),
    // rust: Holder::Knot(pos) => {
    // rust: let fence = w.has_tag("minecraft:fences", w.block_name(pos[0], pos[1], pos[2]));
    // rust: fence.then(|| knot_state(pos))
}
}
}
/// `Entity.yRot(angle)` on a vector (rotation about the Y axis).
pub fn rot_y(v: [f64; 3], angle: f64) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (s, c) = (angle.sin(), angle.cos());
    // rust: [v[0] * c + v[2] * s, v[1], v[2] * c - v[0] * s]
}
/// `Leashable.computeDampenedSpringInteraction` for the single attachment
/// of a mob (0, 0.5, 0.5 of its box) and its holder (0, 0.5, 0): the force
/// toward the holder and the torque on the mob, or `None` while slack.
    // rust: pub fn spring(
    // rust: position: Vec3,
    // rust: yaw: f32,
    // rust: size: (f64, f64),
    // rust: holder: &HolderState,
    // rust: own_motion: Vec3,
    // rust: ) -> Option<([f64; 3], f64)> {
    // rust: let (w, h) = size;
    // rust: let lever = rot_y([0.0, 0.5 * h, 0.5 * w], -f64::from(yaw.to_radians()));
    // rust: let object = [
    // rust: position.x + lever[0],
    // rust: position.y + lever[1],
    // rust: position.z + lever[2],
    // rust: ];
    // rust: let arm = rot_y(
    // rust: [0.0, 0.5 * holder.height, 0.0],
    // rust: -f64::from(holder.yaw.to_radians()),
    // rust: );
    // rust: let pivot = [
    // rust: holder.position.x + arm[0],
    // rust: holder.position.y + arm[1],
    // rust: holder.position.z + arm[2],
    // rust: ];
    // rust: let d = [
    // rust: pivot[0] - object[0],
    // rust: pivot[1] - object[1],
    // rust: pivot[2] - object[2],
    // rust: ];
    // rust: let distance = (d[0] * d[0] + d[1] * d[1] + d[2] * d[2]).sqrt();
    // rust: if distance < ELASTIC {
    // rust: return None;
}
    // rust: let scale = (distance - ELASTIC) / distance;
    // rust: let mut force = [d[0] * scale, d[1] * scale, d[2] * scale];
    // rust: let torque = lever[2] * force[0] - lever[0] * force[2];
    // rust: let same_direction =
    // rust: own_motion.x * force[0] + own_motion.y * force[1] + own_motion.z * force[2] >= 0.0;
    // rust: if same_direction {
    // rust: for f in &mut force {
    // rust: *f *= f64::from(0.3_f32);
}
}
    // rust: Some((force, torque))
}
/// `Leashable.checkElasticInteractions` for an entity of this size at
/// `position` turned `yaw`, hanging on `holder`: the summed force toward it
/// and the torque, or `None` while every spring is slack. With `quad` (a
/// holder that `supportQuadLeashAsHolder` and a leashee that supports one)
/// the four corners pull, a quarter each.
    // rust: pub fn elastic_pull(
    // rust: position: Vec3,
    // rust: yaw: f32,
    // rust: size: (f64, f64),
    // rust: holder: &HolderState,
    // rust: motion: Vec3,
    // rust: quad: bool,
    // rust: ) -> Option<([f64; 3], f64)> {
    // SHARED_QUAD_ATTACHMENT_POINTS, ENTITY_ATTACHMENT_POINT, LEASHER_ATTACHMENT_POINT.
    // rust: const SHARED_QUAD: [[f64; 3]; 4] = [
    // rust: [-0.5, 0.5, 0.5],
    // rust: [-0.5, 0.5, -0.5],
    // rust: [0.5, 0.5, -0.5],
    // rust: [0.5, 0.5, 0.5],
    // rust: ];
pub const OWN: [[f64; 3]; 1] = [[0.0, 0.5, 0.5]];
pub const THEIRS: [[f64; 3]; 1] = [[0.0, 0.5, 0.0]];
    // rust: let (own, theirs): (&[[f64; 3]], &[[f64; 3]]) = if quad {
    // rust: (&SHARED_QUAD, &SHARED_QUAD)
    // rust: } else {
    // rust: (&OWN, &THEIRS)
}
    // Vec3.yRot takes a float angle and widens Mth's float lookup results.
    // Bound the repair to quad attachment physics; retain the single spring.
    // rust: let rotate = |v: [f64; 3], angle: f64| {
    // rust: if quad {
    // rust: let v = Vec3::new(v[0], v[1], v[2]).rotate_y(angle as f32);
    // rust: [v.x, v.y, v.z]
    // rust: } else {
    // rust: rot_y(v, angle)
}
}
    // rust: let (w, h) = size;
    // rust: let own_yaw = f64::from(yaw.to_radians());
    // rust: let holder_yaw = f64::from(holder.yaw.to_radians());
    // rust: let mut force = [0.0; 3];
    // rust: let mut torque = 0.0;
    // rust: let mut any = false;
    // rust: for (mine, other) in own.iter().zip(theirs) {
    // rust: let lever = rotate([mine[0] * w, mine[1] * h, mine[2] * w], -own_yaw);
    // rust: let object = [
    // rust: position.x + lever[0],
    // rust: position.y + lever[1],
    // rust: position.z + lever[2],
    // rust: ];
    // rust: let arm = rotate(
    // rust: [
    // rust: other[0] * holder.width,
    // rust: other[1] * holder.height,
    // rust: other[2] * holder.width,
    // rust: ],
    // rust: -holder_yaw,
    // rust: );
    // rust: let pivot = [
    // rust: holder.position.x + arm[0],
    // rust: holder.position.y + arm[1],
    // rust: holder.position.z + arm[2],
    // rust: ];
    // rust: let d = [
    // rust: pivot[0] - object[0],
    // rust: pivot[1] - object[1],
    // rust: pivot[2] - object[2],
    // rust: ];
    // rust: let distance = (d[0] * d[0] + d[1] * d[1] + d[2] * d[2]).sqrt();
    // rust: if distance < ELASTIC {
    // rust: continue;
}
        // Vec3.normalize, then scale(distance - slack).
    // rust: let length = distance;
    // rust: let unit = if length < 1.0e-5 {
    // rust: [0.0; 3]
    // rust: } else {
    // rust: [d[0] / length, d[1] / length, d[2] / length]
}
    // rust: let pull = distance - ELASTIC;
    // rust: let mut f = [unit[0] * pull, unit[1] * pull, unit[2] * pull];
    // rust: let t = lever[2] * f[0] - lever[0] * f[2];
    // rust: if motion.x * f[0] + motion.y * f[1] + motion.z * f[2] >= 0.0 {
    // rust: for v in &mut f {
    // rust: *v *= f64::from(0.3_f32);
}
}
    // rust: for k in 0..3 {
    // rust: force[k] += f[k];
}
    // rust: torque += t;
    // rust: any = true;
}
    // rust: if !any {
    // rust: return None;
}
    // rust: if quad {
    // rust: for v in &mut force {
    // rust: *v *= 0.25;
}
    // rust: torque *= 0.25;
}
    // rust: Some((force, torque))
}
/// `Entity.checkFallDistanceAccumulation`.
pub fn check_fall_distance(m: *mut Mob) void {
}
    // rust: if m.velocity.y > -0.5 && m.fall_distance > 1.0 {
    // rust: m.fall_distance = 1.0;
}
}
/// Whether a mob can be put on a lead (`Mob.canBeLeashed` and overrides).
pub fn can_be_leashed(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
//     use Species as S;
    // rust: match m.species() {
    // rust: S::Hoglin | S::Zoglin => true,
    // rust: S::Villager
    // rust: | S::WanderingTrader
    // rust: | S::Turtle
    // rust: | S::Panda
    // rust: | S::Bat
    // rust: | S::Cod
    // rust: | S::Salmon
    // rust: | S::TropicalFish
    // rust: | S::Pufferfish
    // rust: | S::Tadpole => false,
    // rust: S::Wolf => !super::tame::angry(m),
        // Nautilus.canBeLeashed and ZombieNautilus.canBeLeashed: never while
        // it is aggravated. The zombie also refuses while a mob is riding it
        // (`isMobControlled`), which a mob alone cannot see.
        // shortcut: isMobControlled, when a mob can ride a zombie nautilus.
    // rust: S::Nautilus | S::ZombieNautilus => !super::nautilus::aggravated(m),
        // SulfurCube.canBeLeashed: `hasBodyItem()`, so only a cube with a
        // block in its body takes a lead. Its category is a monster's, which
        // `Mob.canBeLeashed`'s `!(this instanceof Enemy)` rule would refuse.
    // rust: S::SulfurCube => super::sulfur_cube::has_body(m),
    // rust: _ => !m.hostile() && !m.removed,
}
}
/// `Leashable.tickLeash` at the end of `Entity.baseTick`.
pub fn tick(m: *mut Mob, w: *MobWorld, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: let Some(holder) = m.extra.leash else {
    // rust: m.extra.leash_spin = 0.0;
    // rust: return;
}
    // Leashable.tickLeash: a dying entity cannot interact with the level.
    // rust: if !m.alive() {
    // rust: events.push(MobEvent::LeashBreak {
    // rust: mob: m.id,
    // rust: drop: true,
    // rust: sound: false,
    // rust: });
    // rust: return;
}
    // Leashable.tickLeash: a holder that cannot interact with the level (dead
    // or spectating, `Entity.canInteractWithLevel`) drops the lead.
    // rust: if holder == Holder::Player
    // rust: && let Some(p) = w.player.as_ref()
    // rust: && m.extra.leash_player.is_none_or(|u| p.uuid == u)
    // rust: && (p.spectator || !p.alive)
    // rust: {
    // rust: events.push(MobEvent::LeashBreak {
    // rust: mob: m.id,
    // rust: drop: true,
    // rust: sound: false,
    // rust: });
    // rust: return;
}
    // rust: let state = holder_state(w, holder).filter(|_| {
    // rust: holder != Holder::Player
    // rust: || m.extra
    // rust: .leash_player
    // rust: .is_none_or(|u| w.player.as_ref().is_some_and(|p| p.uuid == u))
    // rust: });
    // rust: let Some(state) = state else {
        // The holder is gone: the lead drops.
    // rust: if !matches!(holder, Holder::Player) {
    // rust: events.push(MobEvent::LeashBreak {
    // rust: mob: m.id,
    // rust: drop: true,
    // rust: sound: false,
    // rust: });
}
    // rust: return;
}
    // PathfinderMob.whenLeashedTo: home is the holder's block, within the
    // elastic distance less one.
    // rust: let elastic = if m.species() == super::Species::HappyGhast {
    // rust: 10.0
    // rust: } else {
    // rust: ELASTIC
}
    // rust: m.ai.home = Some((
    // rust: [
    // rust: state.position.x.floor() as i32,
    // rust: state.position.y.floor() as i32,
    // rust: state.position.z.floor() as i32,
    // rust: ],
    // rust: elastic as i32 - 1,
    // rust: ));
    // Leashable.whenLeashedTo: `leashHolder.notifyLeashHolder(this)`.
    // rust: if let Holder::Mob(id) = holder
    // rust: && supports_quad_leash(m.species())
    // rust: {
    // rust: events.push(MobEvent::NotifyLeashHolder { holder: id });
}
    // rust: let b = m.bounds();
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: let center = Vec3::new(
    // rust: (lo.x + hi.x) / 2.0,
    // rust: (lo.y + hi.y) / 2.0,
    // rust: (lo.z + hi.z) / 2.0,
    // rust: );
    // rust: let distance = ((state.center.x - center.x).powi(2)
    // rust: + (state.center.y - center.y).powi(2)
    // rust: + (state.center.z - center.z).powi(2))
    // rust: .sqrt();
    // rust: if distance > SNAP {
    // rust: events.push(MobEvent::LeashBreak {
    // rust: mob: m.id,
    // rust: drop: true,
    // rust: sound: true,
    // rust: });
    // rust: return;
}
    // rust: let stretched = distance > ELASTIC - state.width - f64::from(m.width());
    // Leashable.checkElasticInteractions: both ends must support the shared
    // quad attachment points. The live holder was resolved and checked above;
    // these physics points are independent of the rendered rope offsets.
    // rust: let quad = supports_quad_leash(m.species())
    // rust: && matches!(holder, Holder::Mob(id) if w.seen(id).is_some_and(|s|
    // rust: matches!(s.species, Species::Ghast | Species::HappyGhast)));
    // rust: let pulled = stretched
    // rust: && elastic_pull(
    // rust: m.position,
    // rust: m.yaw,
    // rust: (f64::from(m.width()), f64::from(m.height())),
    // rust: &state,
    // rust: m.velocity,
    // rust: quad,
    // rust: )
    // rust: .is_some_and(|(force, torque)| {
    // rust: m.extra.leash_spin += 10.0 * torque;
    // rust: let rel = Vec3::new(
    // rust: state.velocity.x - m.velocity.x,
    // rust: state.velocity.y - m.velocity.y,
    // rust: state.velocity.z - m.velocity.z,
    // rust: );
    // rust: m.velocity = Vec3::new(
    // rust: m.velocity.x + force[0] * 0.8 + rel.x * 0.11,
    // rust: m.velocity.y + force[1] * 0.2 + rel.y * 0.11,
    // rust: m.velocity.z + force[2] * 0.8 + rel.z * 0.11,
    // rust: );
    // rust: check_fall_distance(m);
    // rust: super::equine::on_elastic_leash_pull(m, w, events);
    // rust: true
    // rust: });
    // rust: if !pulled {
    // rust: close_range(m, w, &state);
}
    // tickLeash widens the float yaw before subtracting double momentum.
    // rust: if quad {
    // rust: m.yaw = (f64::from(m.yaw) - m.extra.leash_spin) as f32;
    // rust: } else {
    // rust: m.yaw -= m.extra.leash_spin as f32;
}
    // rust: let friction = if m.on_ground {
    // rust: 0.6 * 0.91
    // rust: } else if m.is_in_liquid() {
    // rust: 0.8
    // rust: } else {
    // rust: 0.91
}
    // rust: if quad {
        // angularFriction returns a float, including the ground product.
    // rust: let friction = if m.on_ground {
    // rust: let [x, y, z] = m.on_pos(0.500_001);
    // rust: w.facts.get(w.world.block(x, y, z)).friction * 0.91_f32
    // rust: } else if m.is_in_liquid() {
    // rust: 0.8_f32
    // rust: } else {
    // rust: 0.91_f32
}
    // rust: m.extra.leash_spin *= f64::from(friction);
    // rust: } else {
    // rust: m.extra.leash_spin *= friction;
}
}
/// The lead comes off (`Mob.onLeashRemoved`): no more home.
pub fn remove(m: *mut Mob) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let was = m.extra.leash.take();
    // rust: if was.is_some() {
    // rust: m.ai.clear_home();
}
    // rust: was
}
/// `PathfinderMob.closeRangeLeashBehaviour`: walk to within two blocks of
/// the holder unless panicking.
pub fn close_range(m: *mut Mob, w: *MobWorld, holder: *HolderState) void {
}
    // rust: if m.ai.panicking {
    // rust: return;
}
    // rust: let d = Vec3::new(
    // rust: holder.position.x - m.position.x,
    // rust: holder.position.y - m.position.y,
    // rust: holder.position.z - m.position.z,
    // rust: );
    // rust: let dist = d.length();
    // rust: let len = d.length();
    // rust: let scale = if len > 0.0 {
    // rust: (dist - 2.0).max(0.0) / len
    // rust: } else {
    // rust: 0.0
}
    // rust: let target = [
    // rust: m.position.x + d.x * scale,
    // rust: m.position.y + d.y * scale,
    // rust: m.position.z + d.z * scale,
    // rust: ];
    // rust: let speed = follow_speed(m);
    // rust: m.nav_move_to(w, target, speed);
}
/// `followLeashSpeed`: 1.0, 2.0 for llamas.
pub fn follow_speed(m: *Mob) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if super::llama::is_llama(m.species()) {
    // rust: 2.0
    // rust: } else {
    // rust: 1.0
}
}
/// `Mob.leashable` position of the rope on a mob (`getLeashOffset`).
pub fn leash_offset(m: *Mob) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if super::llama::is_llama(m.species()) {
        // Llama.getLeashOffset.
    // rust: [0.0, 0.75 * m.eye_height(), f64::from(m.width()) * 0.5]
    // rust: } else if m.species() == super::Species::Wolf {
        // Wolf.getLeashOffset: 0.6 of the eye height.
    // rust: [
    // rust: 0.0,
    // rust: f64::from(0.6_f32 * m.eye_height() as f32),
    // rust: f64::from(m.width() * 0.4),
    // rust: ]
    // rust: } else if m.species() == super::Species::Allay {
        // Allay.getLeashOffset.
    // rust: [0.0, m.eye_height() * 0.6, f64::from(m.width()) * 0.1]
    // rust: } else if matches!(
    // rust: m.species(),
    // rust: super::Species::Camel | super::Species::CamelHusk
    // rust: ) {
    // rust: super::camel::leash_offset(m)
    // rust: } else if m.species() == super::Species::Bee {
        // Bee.getLeashOffset: half the eye height, a fifth of the width ahead.
    // rust: [0.0, 0.5 * m.eye_height(), f64::from(m.width() * 0.2)]
    // rust: } else if m.species() == super::Species::IronGolem {
        // IronGolem.getLeashOffset: 0.875 of the eye height.
    // rust: [
    // rust: 0.0,
    // rust: f64::from(0.875_f32 * m.eye_height() as f32),
    // rust: f64::from(m.width() * 0.4),
    // rust: ]
    // rust: } else if m.species() == super::Species::SnowGolem {
        // SnowGolem.getLeashOffset: 0.75 of the eye height.
    // rust: [
    // rust: 0.0,
    // rust: f64::from(0.75_f32 * m.eye_height() as f32),
    // rust: f64::from(m.width() * 0.4),
    // rust: ]
    // rust: } else if m.species() == super::Species::CopperGolem {
        // CopperGolem.getLeashOffset: 0.75 of the eye height, on the centre
        // rather than the default `bbWidth / 2` in front.
    // rust: [0.0, f64::from(0.75_f32 * m.eye_height() as f32), 0.0]
    // rust: } else if m.species() == super::Species::SulfurCube {
        // SulfurCube.getLeashOffset: half of `getBbHeight`, on the centre
        // rather than the default `bbWidth / 2` in front.
    // rust: [0.0, f64::from(m.height() / 2.0), 0.0]
    // rust: } else if m.species() == super::Species::Fox {
        // Fox.getLeashOffset: 0.55 of the eye height.
    // rust: [
    // rust: 0.0,
    // rust: f64::from(0.55_f32 * m.eye_height() as f32),
    // rust: f64::from(m.width() * 0.4),
    // rust: ]
    // rust: } else if let Some(factor) = match m.species() {
        // Pig.getLeashOffset, Rabbit.getLeashOffset and
        // Strider.getLeashOffset: 0.6 of the eye height; Parrot.getLeashOffset
        // and Ocelot.getLeashOffset: half of it.
    // rust: super::Species::Pig | super::Species::Rabbit | super::Species::Strider => Some(0.6_f32),
    // rust: super::Species::Parrot | super::Species::Ocelot => Some(0.5_f32),
    // rust: _ => None,
    // rust: } {
    // rust: [
    // rust: 0.0,
    // rust: f64::from(factor * m.eye_height() as f32),
    // rust: f64::from(m.width() * 0.4),
    // rust: ]
    // rust: } else if m.species() == super::Species::HappyGhast {
        // HappyGhast.getLeashOffset: the origin, so the rope hangs at the
        // ghast's feet rather than an eye height up.
    // rust: [0.0, 0.0, 0.0]
    // rust: } else {
    // rust: [0.0, m.eye_height(), f64::from(m.width() * 0.4)]
}
}
/// `Leashable.createQuadLeashOffsets`: four attachment points around an
/// entity of this size, front-left first, turning clockwise from above.
    // rust: pub fn create_quad_leash_offsets(
    // rust: width: f32,
    // rust: height: f32,
    // rust: front_offset: f64,
    // rust: front_back: f64,
    // rust: left_right: f64,
    // rust: up: f64,
    // rust: ) -> [[f64; 3]; 4] {
    // rust: let front = front_offset * f64::from(width);
    // rust: let front_back = front_back * f64::from(width);
    // rust: let left_right = left_right * f64::from(width);
    // rust: let y = up * f64::from(height);
    // rust: [
    // rust: [-left_right, y, front_back + front],
    // rust: [-left_right, y, -front_back + front],
    // rust: [left_right, y, -front_back + front],
    // rust: [left_right, y, front_back + front],
    // rust: ]
}
/// `Leashable.supportQuadLeash`: `AbstractHorse` (horses, donkeys, mules, the
/// undead horses, camels), `Sniffer` and `AbstractBoat` say yes; `Llama`
/// overrides `AbstractHorse` back to no. Boats are not mobs here.
pub fn supports_quad_leash(s: Species) b {
    // Implementation ported from Horizon
    return undefined;
}
//     use Species as S;
    // rust: matches!(
    // rust: s,
    // rust: S::Horse
    // rust: | S::Donkey
    // rust: | S::Mule
    // rust: | S::SkeletonHorse
    // rust: | S::ZombieHorse
    // rust: | S::Camel
    // rust: | S::CamelHusk
    // rust: | S::Sniffer
    // rust: )
}
/// `Leashable.getQuadLeashOffsets` of a mob for which `supports_quad_leash`:
/// `AbstractHorse`'s, with the overrides of `AbstractChestedHorse` and
/// `ZombieHorse`, `Camel` and `Sniffer`.
pub fn quad_leash_offsets(m: *Mob) [ {
    // Implementation ported from Horizon
    return undefined;
}
//     use Species as S;
    // rust: let (front, front_back, left_right, up) = match m.species() {
    // rust: S::Donkey | S::Mule | S::ZombieHorse => (0.04, 0.41, 0.18, 0.73),
    // rust: S::Camel | S::CamelHusk => (0.02, 0.48, 0.25, 0.82),
    // rust: S::Sniffer => (-0.01, 0.63, 0.38, 1.15),
    // rust: S::Horse | S::SkeletonHorse => (0.04, 0.52, 0.23, 0.87),
    // rust: _ => (0.0, 0.5, 0.5, 0.5),
}
    // rust: create_quad_leash_offsets(m.width(), m.height(), front, front_back, left_right, up)
}
/// `AbstractBoat.getLeashOffset` for a boat or raft (1.375 by 0.5625).
pub fn boat_leash_offset() [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (width, height) = (1.375_f32, 0.5625_f32);
    // rust: [
    // rust: 0.0,
    // rust: f64::from(0.88_f32 * height),
    // rust: f64::from(0.64_f32 * width),
    // rust: ]
}
/// `AbstractBoat.getQuadLeashOffsets`.
pub fn boat_quad_leash_offsets() [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: create_quad_leash_offsets(1.375, 0.5625, 0.0, 0.64, 0.382, 0.88)
}
/// `Entity.supportQuadLeashAsHolder` and `getQuadLeashHolderOffsets`: the
/// `Ghast` family holds a quad lead, the happy ghast at its own points.
pub fn quad_holder_offsets(m: *Mob) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match m.species() {
    // rust: Species::HappyGhast => Some(create_quad_leash_offsets(
    // rust: m.width(),
    // rust: m.height(),
    // rust: -0.03125,
    // rust: 0.4375,
    // rust: 0.46875,
    // rust: 0.03125,
    // rust: )),
    // rust: Species::Ghast => Some(create_quad_leash_offsets(
    // rust: m.width(),
    // rust: m.height(),
    // rust: 0.0,
    // rust: 0.5,
    // rust: 0.5,
    // rust: 0.0,
    // rust: )),
    // rust: _ => None,
}
}
    // rust: mod tests {
//     use super::*;

pub fn mob_tick_selects_quad_only_when_both_live_ends_support_it() void {
}
    // rust: let ran = crate::mobs::world::with_test_world(&[], |world, types| {
    // rust: for (kind, holder_kind, quad) in [
    // rust: ("horse", "happy_ghast", true),
    // rust: ("horse", "ghast", true),
    // rust: ("horse", "cow", false),
    // rust: ("llama", "happy_ghast", false),
    // rust: ] {
    // rust: let new = |id, kind: &str, position, yaw| {
    // rust: Mob::new(
    // rust: id,
    // rust: std::sync::Arc::new(types.types[&format!("minecraft:{kind}")].clone()),
    // rust: position,
    // rust: yaw,
    // rust: )
}
    // rust: let mut mob = new(1, kind, Vec3::new(-7.5, 100.0, -4.5), 90.0);
    // rust: let holder = new(2, holder_kind, Vec3::new(0.5, 104.0, 0.5), 30.0);
    // rust: let others = [holder.seen(None)];
    // rust: let mut w = world.clone();
    // rust: w.others = &others;
    // rust: mob.extra.leash = Some(Holder::Mob(holder.id));
    // rust: let state = holder_state(&w, Holder::Mob(holder.id)).unwrap();
    // rust: let (force, torque) = elastic_pull(
    // rust: mob.position,
    // rust: mob.yaw,
    // rust: (f64::from(mob.width()), f64::from(mob.height())),
    // rust: &state,
    // rust: Vec3::ZERO,
    // rust: quad,
    // rust: )
    // rust: .unwrap();
    // rust: let mut events = Vec::new();
    // rust: tick(&mut mob, &w, &mut events);
    // rust: assert_eq!(
    // rust: mob.velocity,
    // rust: Vec3::new(force[0] * 0.8, force[1] * 0.2, force[2] * 0.8),
    // rust: "{kind} held by {holder_kind}"
    // rust: );
    // rust: let yaw = if quad {
    // rust: (90.0 - 10.0 * torque) as f32
    // rust: } else {
    // rust: 90.0 - (10.0 * torque) as f32
}
    // rust: assert_eq!(mob.yaw, yaw);
    // rust: assert!(
    // rust: !events
    // rust: .iter()
    // rust: .any(|e| matches!(e, MobEvent::LeashBreak { .. }))
    // rust: );
}
    // rust: });
    // rust: if !ran {
    // rust: eprintln!("quad-leash mob fixture skipped: prepare vanilla entity/movement test data");
}
}

pub fn a_players_leash_does_not_pull_toward_a_different_player() void {
}
    // rust: crate::mobs::world::with_test_world(&[], |world, types| {
    // rust: let mut w = world.clone();
    // rust: let mut cow = Mob::new(
    // rust: 1,
    // rust: std::sync::Arc::new(types.types["minecraft:cow"].clone()),
    // rust: Vec3::new(0.5, 64.0, 0.5),
    // rust: 0.0,
    // rust: );
    // rust: let owner = [1, 2, 3, 4];
    // rust: cow.extra.leash = Some(Holder::Player);
    // rust: cow.extra.leash_player = Some(owner);
    // rust: let mut nearby = crate::mobs::world::test_player(Vec3::new(8.5, 64.0, 0.5));
    // rust: nearby.uuid = [5, 6, 7, 8];
    // rust: w.player = Some(nearby);
    // rust: let mut events = Vec::new();
    // rust: tick(&mut cow, &w, &mut events);
    // rust: assert_eq!(
    // rust: cow.velocity,
    // rust: Vec3::ZERO,
    // rust: "absent holder must not use another player"
    // rust: );
    // rust: assert!(events.is_empty());
            // The same distance does pull once the real holder is the player view.
    // rust: w.player.as_mut().unwrap().uuid = owner;
    // rust: tick(&mut cow, &w, &mut events);
    // rust: assert!(
    // rust: cow.velocity.x > 0.0,
    // rust: "the actual holder must still pull the cow"
    // rust: );
    // rust: });
}

pub fn quad_leash_points_are_vanillas() void {
}
        // Leashable.createQuadLeashOffsets for a horse (1.3964844 x 1.6).
    // rust: let p = create_quad_leash_offsets(1.5, 1.6, 0.04, 0.52, 0.23, 0.87);
    // rust: let (y, fb, lr, f) = (
    // rust: 0.87 * f64::from(1.6_f32),
    // rust: 0.52 * 1.5,
    // rust: 0.23 * 1.5,
    // rust: 0.04 * 1.5,
    // rust: );
    // rust: let near = |a: [f64; 3], b: [f64; 3]| a.iter().zip(b).all(|(x, y)| (x - y).abs() < 1e-9);
    // rust: assert!(near(p[0], [-lr, y, fb + f]));
    // rust: assert!(near(p[1], [-lr, y, -fb + f]));
    // rust: assert!(near(p[2], [lr, y, -fb + f]));
    // rust: assert!(near(p[3], [lr, y, fb + f]));
}
    /// `IronGolem`, `SnowGolem`, `CopperGolem` and `Fox.getLeashOffset`: the
    /// rope hangs at a share of the eye height, and the copper golem's on the
    /// centre instead of the default `bbWidth / 2` in front.
pub fn a_golem_or_a_fox_hangs_its_lead_where_vanilla_does() void {
}
    // rust: let _ = crate::mobs::world::with_test_world(&[], |_, types| {
    // rust: for (kind, factor, forwards) in [
    // rust: ("minecraft:iron_golem", 0.875, 0.4),
    // rust: ("minecraft:snow_golem", 0.75, 0.4),
    // rust: ("minecraft:copper_golem", 0.75, 0.0),
    // rust: ("minecraft:fox", 0.55, 0.4),
    // rust: ] {
    // rust: let m = Mob::new(
    // rust: 1,
    // rust: std::sync::Arc::new(types.types[kind].clone()),
    // rust: Vec3::ZERO,
    // rust: 0.0,
    // rust: );
    // rust: let o = leash_offset(&m);
    // rust: let h = f64::from(factor * m.eye_height() as f32);
    // rust: let z = f64::from(m.width() * forwards as f32);
    // rust: assert!((o[1] - h).abs() < 1e-9, "{kind}: height {} vs {h}", o[1]);
    // rust: assert!((o[2] - z).abs() < 1e-9, "{kind}: forward {} vs {z}", o[2]);
    // rust: assert_eq!(o[0], 0.0, "{kind}: centred");
}
    // rust: });
}
    /// `Pig`, `Rabbit`, `Strider`, `Parrot`, `Ocelot` and
    /// `HappyGhast.getLeashOffset`: 0.6 or half of the eye height, and the
    /// happy ghast's rope at the origin, against the default eye-height
    /// height the fallthrough gave them.
pub fn a_pig_a_rabbit_a_parrot_an_ocelot_and_a_ghast_hang_their_lead_where_vanilla_does() void {
}
    // rust: let _ = crate::mobs::world::with_test_world(&[], |_, types| {
    // rust: for (kind, factor) in [
    // rust: ("minecraft:pig", 0.6),
    // rust: ("minecraft:rabbit", 0.6),
    // rust: ("minecraft:strider", 0.6),
    // rust: ("minecraft:parrot", 0.5),
    // rust: ("minecraft:ocelot", 0.5),
                // `Vec3.ZERO`: no eye-height part and no forward shift.
    // rust: ("minecraft:happy_ghast", 0.0),
    // rust: ] {
    // rust: let m = Mob::new(
    // rust: 1,
    // rust: std::sync::Arc::new(types.types[kind].clone()),
    // rust: Vec3::ZERO,
    // rust: 0.0,
    // rust: );
    // rust: let o = leash_offset(&m);
    // rust: let h = f64::from(factor * m.eye_height() as f32);
    // rust: let z = f64::from(m.width() * 0.4);
    // rust: assert!((o[1] - h).abs() < 1e-9, "{kind}: height {} vs {h}", o[1]);
    // rust: assert!(
    // rust: (o[2] - if factor == 0.0 { 0.0 } else { z }).abs() < 1e-9,
    // rust: "{kind}: forward {} vs {z}",
    // rust: o[2]
    // rust: );
    // rust: assert_eq!(o[0], 0.0, "{kind}: centred");
}
    // rust: });
}
    /// `Nautilus.canBeLeashed` and `ZombieNautilus.canBeLeashed`: an
    /// aggravated nautilus, one holding an `ANGRY_AT` or an `ATTACK_TARGET`
    /// memory, cannot be put on a lead.
pub fn an_aggravated_nautilus_cannot_be_leashed() void {
}
    // rust: let ran = crate::mobs::world::with_test_world(&[], |_, types| {
    // rust: let new = |kind: &str| {
    // rust: Mob::new(
    // rust: 1,
    // rust: std::sync::Arc::new(types.types[kind].clone()),
    // rust: horizon_core::geometry::Vec3::ZERO,
    // rust: 0.0,
    // rust: )
}
    // rust: let calm = new("minecraft:nautilus");
    // rust: assert!(can_be_leashed(&calm), "a calm nautilus");
    // rust: let mut angry = new("minecraft:nautilus");
    // rust: angry.extra.anger = 400;
    // rust: assert!(!can_be_leashed(&angry), "ANGRY_AT");
    // rust: let mut charging = new("minecraft:zombie_nautilus");
    // rust: charging.ai.target = Some(crate::mobs::Who::Player);
    // rust: assert!(!can_be_leashed(&charging), "ATTACK_TARGET");
    // rust: assert!(
    // rust: can_be_leashed(&new("minecraft:zombie_nautilus")),
    // rust: "a calm zombie nautilus"
    // rust: );
    // rust: });
    // rust: let _ = ran;
}

pub fn only_horses_camels_and_sniffers_support_a_quad_lead() void {
}
    // rust: assert!(supports_quad_leash(Species::Horse));
    // rust: assert!(supports_quad_leash(Species::Camel));
    // rust: assert!(supports_quad_leash(Species::Sniffer));
        // Llama.supportQuadLeash is false.
    // rust: assert!(!supports_quad_leash(Species::Llama));
    // rust: assert!(!supports_quad_leash(Species::TraderLlama));
    // rust: assert!(!supports_quad_leash(Species::Cow));
}
pub fn a_boats_lead_hangs_at_its_front_and_corners() void {
}
    // rust: let p = boat_leash_offset();
    // rust: assert!((p[1] - 0.88 * 0.5625).abs() < 1e-6 && (p[2] - 0.64 * 1.375).abs() < 1e-6);
    // rust: let q = boat_quad_leash_offsets();
        // Front-left first, as createQuadLeashOffsets orders them.
    // rust: assert!(q[0][0] < 0.0 && q[0][2] > 0.0 && q[2][0] > 0.0 && q[2][2] < 0.0);
    // rust: assert!((q[0][2] - 0.64 * 1.375).abs() < 1e-6 && (q[3][0] - 0.382 * 1.375).abs() < 1e-6);
}
pub fn rotating_about_y_matches_vanilla() void {
}
    // rust: let v = rot_y([0.0, 1.0, 1.0], std::f64::consts::FRAC_PI_2);
    // rust: assert!((v[0] - 1.0).abs() < 1e-9 && v[2].abs() < 1e-9);
}
pub fn holder(x: f64) H {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let position = Vec3::new(x, 64.0, 0.0);
    // rust: HolderState {
    // rust: position,
    // rust: center: Vec3::new(x, 64.9, 0.0),
    // rust: width: 0.6,
    // rust: height: 1.8,
    // rust: yaw: 0.0,
    // rust: velocity: Vec3::ZERO,
}
}
pub fn a_slack_rope_does_not_pull() void {
}
    // rust: let pulled = spring(
    // rust: Vec3::new(0.0, 64.0, 0.0),
    // rust: 0.0,
    // rust: (0.9, 1.87),
    // rust: &holder(3.0),
    // rust: Vec3::ZERO,
    // rust: );
    // rust: assert!(pulled.is_none());
}
pub fn a_stretched_rope_pulls_toward_the_holder() void {
}
    // rust: let (force, _) = spring(
    // rust: Vec3::new(0.0, 64.0, 0.0),
    // rust: 0.0,
    // rust: (0.9, 1.87),
    // rust: &holder(10.0),
    // rust: Vec3::ZERO,
    // rust: )
    // rust: .expect("past the slack");
        // Moving away from nothing: the same-direction damping applies.
    // rust: assert!(force[0] > 0.0);
    // rust: assert!(force[0] < 10.0 - ELASTIC);
}
pub fn one_spring_matches_the_mob_spring() void {
}
    // rust: let at = Vec3::new(1.0, 64.0, 2.0);
    // rust: let (a, ta) = spring(at, 30.0, (1.375, 0.5625), &holder(10.0), Vec3::ZERO).unwrap();
    // rust: let (b, tb) =
    // rust: elastic_pull(at, 30.0, (1.375, 0.5625), &holder(10.0), Vec3::ZERO, false).unwrap();
    // rust: assert!((0..3).all(|k| (a[k] - b[k]).abs() < 1e-9));
    // rust: assert!((ta - tb).abs() < 1e-9);
}
pub fn a_quad_lead_pulls_a_quarter_from_each_corner() void {
}
        // A holder straight ahead pulls every corner alike, so the quad force
        // is the mean of four springs, not their sum.
    // rust: let at = Vec3::new(0.0, 64.0, 0.0);
    // rust: let (quad, _) = elastic_pull(at, 0.0, (1.0, 1.0), &holder(10.0), Vec3::ZERO, true).unwrap();
    // rust: let (single, _) =
    // rust: elastic_pull(at, 0.0, (1.0, 1.0), &holder(10.0), Vec3::ZERO, false).unwrap();
    // rust: assert!(quad[0] > 0.0 && quad[0] <= single[0] * 1.5);
    // rust: assert!(elastic_pull(at, 0.0, (1.0, 1.0), &holder(3.0), Vec3::ZERO, true).is_none());
}
pub fn moving_with_the_pull_damps_it() void {
}
    // rust: let at = Vec3::new(0.0, 64.0, 0.0);
    // rust: let still = spring(
    // rust: at,
    // rust: 0.0,
    // rust: (0.9, 1.87),
    // rust: &holder(10.0),
    // rust: Vec3::new(-0.1, 0.0, 0.0),
    // rust: )
    // rust: .expect("pull")
    // rust: .0;
    // rust: let following = spring(
    // rust: at,
    // rust: 0.0,
    // rust: (0.9, 1.87),
    // rust: &holder(10.0),
    // rust: Vec3::new(0.1, 0.0, 0.0),
    // rust: )
    // rust: .expect("pull")
    // rust: .0;
    // rust: assert!((following[0] - still[0] * 0.3_f32 as f64).abs() < 1e-9);
}
pub fn leash_tags_round_trip() void {
}
    // rust: let knot = to_nbt(Holder::Knot([1, 2, 3]), None).expect("knot tag");
    // rust: assert_eq!(
    // rust: pending_from_nbt(Some(&knot)),
    // rust: Some(Pending::Knot([1, 2, 3]))
    // rust: );
    // rust: let held = to_nbt(Holder::Player, Some([4, 5, 6, 7])).expect("uuid tag");
    // rust: assert_eq!(
    // rust: pending_from_nbt(Some(&held)),
    // rust: Some(Pending::Uuid([4, 5, 6, 7]))
    // rust: );
    // rust: assert_eq!(to_nbt(Holder::Mob(1), None), None);
}
pub fn a_knot_sits_on_the_fence_post() void {
}
    // rust: let k = knot_state([10, 64, -3]);
    // rust: assert_eq!(k.position.x, 10.5);
    // rust: assert_eq!(k.position.y, 64.375);
    // rust: assert_eq!(k.center.y, 64.625);
}
    /// `SulfurCube.canBeLeashed` is `hasBodyItem()`: only a cube with a block
    /// in its body takes a lead. `SulfurCube.getLeashOffset` hangs the rope at
    /// half of `getBbHeight`, on the cube's centre rather than the default
    /// `bbWidth / 2` in front.
pub fn a_sulfur_cube_is_leashed_by_its_block_and_hangs_at_its_middle() void {
}
        // `with_test_world` answers false when the prepared data is absent, and
        // the edits are inside the closure, so a skip needs no early return.
    // rust: let _ = crate::mobs::world::with_test_world(&[], |_, types| {
    // rust: let new = || {
    // rust: Mob::new(
    // rust: 1,
    // rust: std::sync::Arc::new(types.types["minecraft:sulfur_cube"].clone()),
    // rust: horizon_core::geometry::Vec3::ZERO,
    // rust: 0.0,
    // rust: )
}
    // rust: let empty = new();
    // rust: let mut full = new();
    // rust: full.extra.body = Some("minecraft:stone".into());
    // rust: for m in [&empty, &full] {
    // rust: let o = leash_offset(m);
    // rust: let h = f64::from(m.height() / 2.0);
    // rust: assert!(
    // rust: (o[1] - h).abs() < 1e-9,
    // rust: "half the box height: {} vs {h}",
    // rust: o[1]
    // rust: );
    // rust: assert_eq!((o[0], o[2]), (0.0, 0.0), "hangs on the centre");
}
    // rust: assert!(!can_be_leashed(&empty), "a cube with no block in it");
    // rust: assert!(can_be_leashed(&full), "a cube holding a block");
    // rust: });
}
}
