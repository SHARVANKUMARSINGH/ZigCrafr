//! Transpiled from Horizon Rust crate
//! Module: horizon-client_creaking_heart
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The creaking heart's block entity (`CreakingHeartBlockEntity`): at night
//! an awake heart in a pale oak trunk spawns a creaking that protects it
//! (`SpawnUtil.trySpawnMob`), lets it go by day, when it strays or when a
//! player is stuck in it, and when that creaking is hurt by a player emits
//! trails and spreads resin over the logs. The game and the mob AI probe
//! both tick hearts through this module; the host applies the block changes
//! and plays what it reports.
// use super::{Mob, MobEvent, MobType, MobWorld, creaking};
// use crate::{collisions::SceneCollisions, containers::CreakingHeart};
// use horizon_core::{
    // rust: geometry::{Aabb, Vec3},
    // rust: random::{LegacyRandom, RandomSource},
}
// use horizon_world::registry::BlockStateId;
// use std::sync::Arc;

/// `Creaking.CREAKING_ORANGE` and `CREAKING_GRAY`.
pub const ORANGE: u32 = 16_545_810;
pub const GRAY: u32 = 6_250_335;
/// `CreakingHeartBlockEntity.DISTANCE_CREAKING_TOO_FAR`.
pub const TOO_FAR: f64 = 34.0;
/// `Direction.values()`: down, up, north, south, west, east.
    // rust: const DIRECTIONS: [[i32; 3]; 6] = [
    // rust: [0, -1, 0],
    // rust: [0, 1, 0],
    // rust: [0, 0, -1],
    // rust: [0, 0, 1],
    // rust: [-1, 0, 0],
    // rust: [1, 0, 0],
    // rust: ];
pub const FACE_NAMES: [[]const u8; 6] = ["down", "up", "north", "south", "west", "east"];

/// What a heart's tick did, for its host to apply.
pub const HeartEvent = enum {
    /// `Level.setBlockAndUpdate`.
    SetBlock([i32; 3], BlockStateId),
    /// `Level.playSound(null, ...)`: heard by everyone.
    Sound(&'static str, [f64; 3], f32, f32),
    /// A `TrailParticleOption` sent from `at` towards `target`.
    Trail {,
    at: [f64; 3],
    target: [f64; 3],
    color: u32,
    duration: i32,
    // rust: },
    /// `updateNeighbourForOutputSignal`: comparators read the new signal.
    OutputChanged([i32; 3]),
    /// A mob's own sounds and effects (the spawned creaking's voice, a
    /// creaking falling apart).
    Mob(MobEvent),
};

/// The mobs a heart sees and the creakings it spawns.
    // rust: pub trait HeartHost {
pub fn mob(self: *Self, id: u32) O;
pub fn mob_mut(self: *Self, id: u32) O;
    /// The loaded mob with this UUID.
pub fn mob_for_uuid(self: *Self, uuid: [i32; 4]) O;
pub fn uuid_for(self: *Self, id: u32) [;
    /// The creaking's entity type.
pub fn creaking_type(self: *Self) O;
    /// A new mob of the type (the next entity id, its random seeded).
pub fn create_mob(self: *Self, kind: *MobType, at: Vec3) M;
    /// `Level.addFreshEntity`.
pub fn add_mob(self: *Self, m: Mob) void;
    /// `ServerLevel.isSpawningMonsters` (rules and difficulty).
pub fn spawning_monsters(self: *Self) b;
}

/// Block reads during a tick see the tick's own changes.
pub const Blocks = struct {
    w: *'a MobWorld<'w>,
    changed: Vec<([i32,
};
    // rust: impl Blocks<'_, '_> {
pub fn get(self: *Self, p: [i32; 3]) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.changed
    // rust: .iter()
    // rust: .rev()
    // rust: .find(|(q, _)| *q == p)
    // rust: .map_or_else(|| self.w.world.block(p[0], p[1], p[2]), |(_, s)| *s)
}
pub fn set(self: *Self, p: [i32; 3], s: BlockStateId, out: *mut std.ArrayList(HeartEvent)) void {
}
    // rust: self.changed.push((p, s));
    // rust: out.push(HeartEvent::SetBlock(p, s));
}
pub fn name(self: *Self, s: BlockStateId) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.w.facts.get(s).name
}
pub fn prop(self: *Self, s: BlockStateId, key: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.w
    // rust: .registry
    // rust: .state(s)
    // rust: .and_then(|st| st.properties.get(key).cloned())
}
pub fn with_prop(self: *Self, s: BlockStateId, key: []const u8, value: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut st = self.w.registry.state(s)?.clone();
    // rust: st.properties.insert(key.to_owned(), value.to_owned());
    // rust: self.w.registry.resolve(&st).ok()
}
pub fn is_pale_oak_log(self: *Self, p: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let s = self.get(p);
    // rust: self.w.has_tag("minecraft:pale_oak_logs", self.name(s))
}
}

/// `EnvironmentAttributes.CREAKING_ACTIVE`: the overworld's night, from
/// 12600 to 23400.
pub fn creaking_active(w: *MobWorld) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !w.nether && !w.end && (12600..23401).contains(&w.day_time.rem_euclid(24000))
}
/// `CreakingHeartBlock.hasRequiredLogs`: pale oak logs on both ends of the
/// heart's axis, along the same axis.
pub fn has_required_logs(b: *Blocks, state: BlockStateId, pos: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let axis = b.prop(state, "axis").unwrap_or_else(|| "y".into());
    // rust: let dirs: [usize; 2] = match axis.as_str() {
    // rust: "x" => [4, 5],
    // rust: "z" => [2, 3],
    // rust: _ => [0, 1],
}
    // rust: dirs.iter().all(|&d| {
    // rust: let n = [
    // rust: pos[0] + DIRECTIONS[d][0],
    // rust: pos[1] + DIRECTIONS[d][1],
    // rust: pos[2] + DIRECTIONS[d][2],
    // rust: ];
    // rust: let s = b.get(n);
    // rust: b.w.has_tag("minecraft:pale_oak_logs", b.name(s))
    // rust: && b.prop(s, "axis").as_deref() == Some(axis.as_str())
    // rust: })
}

/// `getCreakingProtector`: the protector's entity, resolving a UUID read
/// from a save (forgotten 30 ticks after the heart came back unresolved).
pub fn protector(heart: *mut CreakingHeart, host: *impl HeartHost) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (id, uuid) = heart.creaking?;
    // rust: if let Some(id) = id {
    // rust: if host.mob(id).is_some_and(|m| !m.removed) {
    // rust: return Some(id);
}
        // setCreakingInfo(uuid)
    // rust: heart.creaking = Some((None, uuid));
    // rust: heart.ticks_existed = 0;
}
    // rust: if let Some(id) = host.mob_for_uuid(uuid) {
    // rust: heart.creaking = Some((Some(id), uuid));
    // rust: return Some(id);
}
    // rust: if heart.ticks_existed >= 30 {
    // rust: heart.creaking = None;
}
    // rust: None
}
pub fn distance_to_creaking(heart: *mut CreakingHeart, pos: [i32; 3], host: *impl HeartHost) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: protector(heart, host)
    // rust: .and_then(|id| host.mob(id))
    // rust: .map_or(0.0, |m| {
    // rust: let at = Vec3::new(
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(pos[1]),
    // rust: f64::from(pos[2]) + 0.5,
    // rust: );
    // rust: m.distance_sqr(at).sqrt()
    // rust: })
}
/// `computeAnalogOutputSignal`.
pub fn output_signal(heart: *mut CreakingHeart, pos: [i32; 3], host: *impl HeartHost) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if heart.creaking.is_none() || protector(heart, host).is_none() {
    // rust: return 0;
}
    // rust: let scaled = distance_to_creaking(heart, pos, host).clamp(0.0, 32.0) / 32.0;
    // rust: 15 - (scaled * 15.0).floor() as i32
}
/// `removeProtector`: the creaking falls apart (`tearDown`), or with a
/// damage source (`by_player`) twitches to death.
    // rust: pub fn remove_protector(
    // rust: heart: &mut CreakingHeart,
    // rust: host: &mut impl HeartHost,
    // rust: by_player: bool,
    // rust: out: &mut Vec<HeartEvent>,
    // rust: ) {
    // rust: let Some(id) = protector(heart, host) else {
    // rust: return;
}
    // rust: if let Some(m) = host.mob_mut(id) {
    // rust: let mut events = Vec::new();
    // rust: if by_player {
            // creakingDeathEffects, setTearingDown, setHealth(0).
    // rust: creaking::set_tearing_down(m);
    // rust: m.health = 0.0;
    // rust: m.voice("entity.creaking.twitch", &mut events);
    // rust: } else {
    // rust: creaking::tear_down(m, &mut events);
}
    // rust: out.extend(events.into_iter().map(HeartEvent::Mob));
}
    // rust: heart.creaking = None;
}
/// `emitParticles`: trails between the protector and the heart.
    // rust: fn emit_particles(
    // rust: heart: &mut CreakingHeart,
    // rust: pos: [i32; 3],
    // rust: count: i32,
    // rust: towards: bool,
    // rust: lr: &mut LegacyRandom,
    // rust: host: &impl HeartHost,
    // rust: out: &mut Vec<HeartEvent>,
    // rust: ) {
    // rust: let Some(b) = protector(heart, host)
    // rust: .and_then(|id| host.mob(id))
    // rust: .map(Mob::bounds)
    // rust: else {
    // rust: return;
}
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: for _ in 0..count {
    // rust: let mut source = [
    // rust: lo.x + lr.next_double() * (hi.x - lo.x),
    // rust: lo.y + lr.next_double() * (hi.y - lo.y),
    // rust: lo.z + lr.next_double() * (hi.z - lo.z),
    // rust: ];
    // rust: let mut destination = [
    // rust: f64::from(pos[0]) + lr.next_double(),
    // rust: f64::from(pos[1]) + lr.next_double(),
    // rust: f64::from(pos[2]) + lr.next_double(),
    // rust: ];
    // rust: if towards {
    // rust: std::mem::swap(&mut source, &mut destination);
}
    // rust: let duration = lr.next_int_bound(40).unwrap_or(0) + 10;
    // rust: out.push(HeartEvent::Trail {
    // rust: at: source,
    // rust: target: destination,
    // rust: color: if towards { ORANGE } else { GRAY },
    // rust: duration,
    // rust: });
}
}
/// `Util.shuffledCopy(Direction.values(), random)`.
pub fn shuffled_directions(lr: *mut LegacyRandom) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut order = [0, 1, 2, 3, 4, 5];
    // rust: for i in (2..=6).rev() {
    // rust: let j = lr.next_int_bound(i as i32).unwrap_or(0) as usize;
    // rust: order.swap(i - 1, j);
}
    // rust: order
}
pub fn offset(p: [i32; 3], d: usize) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [
    // rust: p[0] + DIRECTIONS[d][0],
    // rust: p[1] + DIRECTIONS[d][1],
    // rust: p[2] + DIRECTIONS[d][2],
    // rust: ]
}
/// `spreadResin`: a resin clump on the first log face found within two steps
/// of pale oak logs (`BlockPos.breadthFirstTraversal(pos, 2, 64, ...)`).
    // rust: fn spread_resin(
    // rust: b: &mut Blocks,
    // rust: pos: [i32; 3],
    // rust: lr: &mut LegacyRandom,
    // rust: out: &mut Vec<HeartEvent>,
    // rust: ) -> Option<[i32; 3]> {
    // rust: let mut visited: Vec<[i32; 3]> = Vec::new();
    // rust: let mut queue: std::collections::VecDeque<([i32; 3], i32)> = Default::default();
    // rust: queue.push_back((pos, 0));
    // rust: let mut count = 0;
    // rust: while let Some((current, depth)) = queue.pop_front() {
    // rust: if visited.contains(&current) {
    // rust: continue;
}
    // rust: visited.push(current);
        // The node visitor.
    // rust: if b.is_pale_oak_log(current) {
    // rust: for d in shuffled_directions(lr) {
    // rust: let n = offset(current, d);
    // rust: let mut neighbour = b.get(n);
    // rust: let opposite = d ^ 1;
    // rust: let facts = b.w.facts.get(neighbour);
    // rust: if b.w.facts.is_air(neighbour) {
    // rust: neighbour = b.w.registry.default_state("minecraft:resin_clump")?;
    // rust: } else if &*facts.name == "minecraft:water"
    // rust: && facts.fluid_level == 8
    // rust: && !facts.fluid_falling
    // rust: {
    // rust: let clump = b.w.registry.default_state("minecraft:resin_clump")?;
    // rust: neighbour = b.with_prop(clump, "waterlogged", "true")?;
}
    // rust: if b.name(neighbour) == "minecraft:resin_clump"
    // rust: && b.prop(neighbour, FACE_NAMES[opposite]).as_deref() != Some("true")
    // rust: {
    // rust: let placed = b.with_prop(neighbour, FACE_NAMES[opposite], "true")?;
    // rust: b.set(n, placed, out);
    // rust: return Some(n);
}
}
}
    // rust: count += 1;
    // rust: if count >= 64 {
    // rust: return None;
}
    // rust: if depth < 2 {
            // The neighbour provider: adjacent pale oak logs.
    // rust: for d in shuffled_directions(lr) {
    // rust: let n = offset(current, d);
    // rust: if b.is_pale_oak_log(n) {
    // rust: queue.push_back((n, depth + 1));
}
}
}
}
    // rust: None
}
/// `creakingHurt`: a player hurt the protector.
    // rust: pub fn creaking_hurt(
    // rust: heart: &mut CreakingHeart,
    // rust: pos: [i32; 3],
    // rust: w: &MobWorld,
    // rust: lr: &mut LegacyRandom,
    // rust: host: &mut impl HeartHost,
    // rust: out: &mut Vec<HeartEvent>,
    // rust: ) {
    // rust: let Some(id) = protector(heart, host) else {
    // rust: return;
}
    // rust: if heart.emitter > 0 {
    // rust: return;
}
    // rust: emit_particles(heart, pos, 20, false, lr, host, out);
    // rust: let mut b = Blocks {
    // rust: w,
    // rust: changed: Vec::new(),
}
    // rust: let state = b.get(pos);
    // rust: if b.prop(state, "creaking_heart_state").as_deref() == Some("awake") {
    // rust: let clumps = lr.next_int_between_inclusive(2, 3).unwrap_or(2);
    // rust: for _ in 0..clumps {
    // rust: if let Some(at) = spread_resin(&mut b, pos, lr, out) {
    // rust: out.push(HeartEvent::Sound("block.resin.place", centre(at), 1.0, 1.0));
}
}
}
    // rust: heart.emitter = 100;
    // rust: heart.emitter_target = host.mob(id).map(Mob::center);
}
pub fn centre(p: [i32; 3]) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [
    // rust: f64::from(p[0]) + 0.5,
    // rust: f64::from(p[1]) + 0.5,
    // rust: f64::from(p[2]) + 0.5,
    // rust: ]
}

/// `SpawnUtil.Strategy.ON_TOP_OF_COLLIDER_NO_LEAVES`.
pub fn can_spawn_on(b: *Blocks, pos: [i32; 3], state: BlockStateId, above: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut scene = SceneCollisions {
    // rust: world: b.w.world,
    // rust: binding: b.w.collision,
    // rust: subject: None,
}
    // rust: let above_pos = [pos[0], pos[1] + 1, pos[2]];
    // rust: let above_empty =
    // rust: b.w.collision
    // rust: .collision_shape(&mut scene, above, above_pos)
    // rust: .is_ok_and(|s| s.is_empty());
    // rust: above_empty
    // rust: && !b.w.has_tag("minecraft:leaves", b.name(state))
    // rust: && b.w.facts.get(state).sturdy_full & (1 << 1) != 0
}
/// `SpawnUtil.trySpawnMob(CREAKING, SPAWNER, level, pos, 5, 16, 8,
/// ON_TOP_OF_COLLIDER_NO_LEAVES, true)` and `spawnProtector`.
    // rust: fn spawn_protector(
    // rust: pos: [i32; 3],
    // rust: w: &MobWorld,
    // rust: lr: &mut LegacyRandom,
    // rust: host: &mut impl HeartHost,
    // rust: out: &mut Vec<HeartEvent>,
    // rust: ) -> Option<u32> {
    // rust: let kind = host.creaking_type()?;
    // rust: let b = Blocks {
    // rust: w,
    // rust: changed: Vec::new(),
}
    // rust: for _ in 0..5 {
    // rust: let dx = lr.next_int_between_inclusive(-16, 16).unwrap_or(0);
    // rust: let dz = lr.next_int_between_inclusive(-16, 16).unwrap_or(0);
    // rust: let mut at = [pos[0] + dx, pos[1] + 8, pos[2] + dz];
    // rust: if !w.world.loaded(at[0], at[2]) {
    // rust: continue;
}
        // moveToPossibleSpawnPosition
    // rust: let mut above = b.get(at);
    // rust: let mut found = false;
    // rust: for _ in (-8..=8).rev() {
    // rust: at[1] -= 1;
    // rust: let current = b.get(at);
    // rust: if can_spawn_on(&b, at, current, above) {
    // rust: at[1] += 1;
    // rust: found = true;
    // rust: break;
}
    // rust: above = current;
}
    // rust: if !found {
    // rust: continue;
}
        // noCollision(getSpawnAABB)
    // rust: let half = f64::from(kind.width as f32 / 2.0);
    // rust: let height = f64::from(kind.height as f32);
    // rust: let (x, y, z) = (
    // rust: f64::from(at[0]) + 0.5,
    // rust: f64::from(at[1]),
    // rust: f64::from(at[2]) + 0.5,
    // rust: );
    // rust: let bounds = Aabb::new(
    // rust: Vec3::new(x - half, y, z - half),
    // rust: Vec3::new(x + half, y + height, z + half),
    // rust: );
    // rust: let mut scene = SceneCollisions {
    // rust: world: w.world,
    // rust: binding: w.collision,
    // rust: subject: None,
}
    // rust: if !scene.unobstructed(bounds).unwrap_or(false) {
    // rust: continue;
}
        // EntityType.create: a random yaw, then Mob.finalizeSpawn.
    // rust: let mut m = host.create_mob(kind.clone(), Vec3::new(x, y, z));
    // rust: let yaw = wrap_degrees(lr.next_float() * 360.0);
    // rust: m.yaw = yaw;
    // rust: m.previous_yaw = yaw;
    // rust: m.head_yaw = yaw;
    // rust: m.body_yaw = yaw;
    // rust: finalize_spawn(&mut m, lr);
        // Mob.checkSpawnRules (always true for a creaking) and
        // checkSpawnObstruction (no liquid in the box).
    // rust: if liquid_in(w, m.bounds()) {
    // rust: continue;
}
    // rust: let id = m.id;
        // SpawnUtil: addFreshEntityWithPassengers, then playAmbientSound.
    // rust: let mut events = Vec::new();
    // rust: if !creaking::is_active(&m) {
    // rust: m.voice("entity.creaking.ambient", &mut events);
}
    // rust: creaking::set_transient(&mut m, pos);
        // spawnProtector's caller: the creaking's spawn sound.
    // rust: m.voice("entity.creaking.spawn", &mut events);
    // rust: host.add_mob(m);
    // rust: out.extend(events.into_iter().map(HeartEvent::Mob));
    // rust: out.push(HeartEvent::Sound(
    // rust: "block.creaking_heart.spawn",
    // rust: centre(pos),
    // rust: 1.0,
    // rust: 1.0,
    // rust: ));
    // rust: return Some(id);
}
    // rust: None
}
/// `Mob.finalizeSpawn`: the follow range's random spawn bonus and the
/// handedness, from the level random.
pub fn finalize_spawn(m: *mut Mob, lr: *mut LegacyRandom) void {
}
    // rust: let bonus = lr.triangle(0.0, 0.114_850_000_000_000_01);
    // ADD_MULTIPLIED_BASE on the base value.
    // rust: m.attrs.follow_range += m.kind.follow_range * bonus;
    // rust: m.update_max_visited_nodes();
    // rust: let _left_handed = lr.next_float() < 0.05;
}
pub fn wrap_degrees(angle: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut w = angle % 360.0;
    // rust: if w >= 180.0 {
    // rust: w -= 360.0;
}
    // rust: if w < -180.0 {
    // rust: w += 360.0;
}
    // rust: w
}
pub fn liquid_in(w: *MobWorld, b: Aabb) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: for x in lo.x.floor() as i32..=(hi.x.ceil() as i32 - 1) {
    // rust: for y in lo.y.floor() as i32..=(hi.y.ceil() as i32 - 1) {
    // rust: for z in lo.z.floor() as i32..=(hi.z.ceil() as i32 - 1) {
    // rust: if w.fluid(x, y, z) != crate::blocks::Fluid::None {
    // rust: return true;
}
}
}
}
    // rust: false
}

/// Whether this tick of the heart reaches its update (`updateCreakingState`
/// and the protector checks), the only part of [`server_tick`] that reads the
/// level's other mobs: about once a second, so a host may build them only then.
pub fn tick_updates(heart: *CreakingHeart) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: heart.ticker < 0
}

/// `CreakingHeartBlockEntity.serverTick` (hearts that are not uprooted).
    // rust: pub fn server_tick(
    // rust: heart: &mut CreakingHeart,
    // rust: pos: [i32; 3],
    // rust: w: &MobWorld,
    // rust: lr: &mut LegacyRandom,
    // rust: host: &mut impl HeartHost,
    // rust: out: &mut Vec<HeartEvent>,
    // rust: ) {
    // rust: heart.ticks_existed += 1;
    // rust: let signal = output_signal(heart, pos, host);
    // rust: if heart.output_signal != signal {
    // rust: heart.output_signal = signal;
    // rust: out.push(HeartEvent::OutputChanged(pos));
}
    // rust: if heart.emitter > 0 {
    // rust: if heart.emitter > 50 {
    // rust: emit_particles(heart, pos, 1, true, lr, host, out);
    // rust: emit_particles(heart, pos, 1, false, lr, host, out);
}
    // rust: if heart.emitter % 10 == 0 && heart.emitter_target.is_some() {
    // rust: if let Some(m) = protector(heart, host).and_then(|id| host.mob(id)) {
    // rust: heart.emitter_target = Some(m.center());
}
    // rust: if let Some(target) = heart.emitter_target {
    // rust: let c = centre(pos);
    // rust: let progress = 0.2 + 0.8 * f64::from(100 - heart.emitter) / 100.0;
    // rust: let sound = [
    // rust: (c[0] - target[0]) * progress + target[0],
    // rust: (c[1] - target[1]) * progress + target[1],
    // rust: (c[2] - target[2]) * progress + target[2],
    // rust: ];
                // playSound(null, BlockPos.containing(soundLocation), ...)
    // rust: let at = centre([
    // rust: sound[0].floor() as i32,
    // rust: sound[1].floor() as i32,
    // rust: sound[2].floor() as i32,
    // rust: ]);
    // rust: let volume = heart.emitter as f32 / 2.0 / 100.0 + 0.5;
    // rust: out.push(HeartEvent::Sound(
    // rust: "block.creaking_heart.hurt",
    // rust: at,
    // rust: volume,
    // rust: 1.0,
    // rust: ));
}
}
    // rust: heart.emitter -= 1;
}
    // rust: let ticker = heart.ticker;
    // rust: heart.ticker -= 1;
    // rust: if ticker >= 0 {
    // rust: return;
}
    // rust: heart.ticker = lr.next_int_bound(5).unwrap_or(0) + 20;
    // rust: let mut b = Blocks {
    // rust: w,
    // rust: changed: Vec::new(),
}
    // rust: let state = b.get(pos);
    // updateCreakingState
    // rust: let active = creaking_active(w);
    // rust: let wanted = if !has_required_logs(&b, state, pos) && heart.creaking.is_none() {
    // rust: "uprooted"
    // rust: } else if active {
    // rust: "awake"
    // rust: } else {
    // rust: "dormant"
}
    // rust: let mut updated = state;
    // rust: if b.prop(state, "creaking_heart_state").as_deref() != Some(wanted)
    // rust: && let Some(next) = b.with_prop(state, "creaking_heart_state", wanted)
    // rust: {
    // rust: updated = next;
    // rust: b.set(pos, next, out);
    // rust: if wanted == "uprooted" {
    // rust: return;
}
}
    // rust: if heart.creaking.is_none() {
    // rust: let awake = b.prop(updated, "creaking_heart_state").as_deref() == Some("awake");
    // rust: if awake && host.spawning_monsters() {
            // getNearestPlayer(pos, 32, false): no spectators.
    // rust: let (x, y, z) = (f64::from(pos[0]), f64::from(pos[1]), f64::from(pos[2]));
    // rust: let near = w.player.as_ref().is_some_and(|p| {
    // rust: !p.spectator
    // rust: && (p.position.x - x).powi(2)
    // rust: + (p.position.y - y).powi(2)
    // rust: + (p.position.z - z).powi(2)
    // rust: < 32.0 * 32.0
    // rust: });
    // rust: if near && let Some(id) = spawn_protector(pos, w, lr, host, out) {
    // rust: let uuid = host.uuid_for(id);
    // rust: heart.creaking = Some((Some(id), uuid));
}
}
    // rust: } else if let Some(id) = protector(heart, host) {
    // rust: let persistent = host.mob(id).is_some_and(|m| m.persistent);
        // playerIsStuckInYou reads the creaking's NEAREST_PLAYERS.
    // rust: let stuck = host.mob_mut(id).is_some_and(|m| {
    // rust: let listed = super::monster_brain::nearest_players(m).contains(&super::Who::Player);
    // rust: let eye = w.player.as_ref().filter(|_| listed).map(|p| p.eye);
    // rust: creaking::player_is_stuck(m, eye)
    // rust: });
    // rust: if !active && !persistent || distance_to_creaking(heart, pos, host) > TOO_FAR || stuck {
    // rust: remove_protector(heart, host, false, out);
}
}
}
