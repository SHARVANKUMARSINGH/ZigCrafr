//! Transpiled from Horizon Rust crate
//! Module: horizon-client_hostile
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Creepers (swelling, explosions) and spiders (wall climbing, daylight
//! neutrality, leaping).
// use super::{
    // rust: Damage, DamageKind, Mob, MobEvent, MobWorld, Species, Who,
    // rust: goals::{
    // rust: Avoid, AvoidEntity, ClimbOnTopOfPowderSnow, Cx, Float, Goal, HurtByTarget, LeapAtTarget,
    // rust: LookAtPlayer, MOVE, MeleeAttack, NearestTarget, RandomLookAround, Stroll, goal_clone,
    // rust: },
}
// use horizon_core::random::RandomSource;

pub fn register(m: *mut Mob) void {
}
//     use Species as S;
    // rust: match m.species() {
    // rust: S::Creeper => {
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(1, Float);
    // rust: g.add(2, Swell::default());
    // rust: g.add(
    // rust: 3,
    // rust: AvoidEntity::new(Avoid::Species(vec![S::Ocelot]), 6.0, 1.0, 1.2),
    // rust: );
    // rust: g.add(
    // rust: 3,
    // rust: AvoidEntity::new(Avoid::Species(vec![S::Cat]), 6.0, 1.0, 1.2),
    // rust: );
    // rust: g.add(4, MeleeAttack::new(1.0, false));
    // rust: g.add(5, Stroll::avoiding_water(0.8));
    // rust: g.add(6, LookAtPlayer::new(8.0));
    // rust: g.add(6, RandomLookAround::default());
    // rust: m.ai.targets.add(1, NearestTarget::player(true));
    // rust: m.ai.targets.add(2, HurtByTarget::new());
            // Creeper DATA_SWELL_DIR starts at -1.
    // rust: m.extra.counter = -1;
}
    // rust: S::Spider | S::CaveSpider => {
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(1, Float);
    // rust: g.add(
    // rust: 2,
    // rust: AvoidEntity::new(Avoid::Species(vec![S::Armadillo]), 6.0, 1.0, 1.2),
    // rust: );
    // rust: g.add(3, LeapAtTarget::new(0.4));
    // rust: g.add(4, SpiderAttack(MeleeAttack::new(1.0, true)));
    // rust: g.add(5, Stroll::avoiding_water(0.8));
    // rust: g.add(6, LookAtPlayer::new(8.0));
    // rust: g.add(6, RandomLookAround::default());
    // rust: m.ai.targets.add(1, HurtByTarget::new());
    // rust: m.ai.targets
    // rust: .add(2, NearestTarget::player(true).gate(dark_enough));
    // rust: m.ai.targets.add(
    // rust: 3,
    // rust: NearestTarget::species(&[S::IronGolem], true).gate(dark_enough),
    // rust: );
    // rust: m.ai.nav.kind = super::nav::NavKind::WallClimber;
}
    // rust: S::Silverfish => {
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(1, Float);
    // rust: g.add(1, ClimbOnTopOfPowderSnow);
    // rust: g.add(3, SilverfishWakeUpFriends);
    // rust: g.add(4, MeleeAttack::new(1.0, false));
    // rust: g.add(5, SilverfishMergeWithStone::default());
    // rust: m.ai.targets.add(1, HurtByTarget::new().alert());
    // rust: m.ai.targets.add(2, NearestTarget::player(true));
}
        // Endermite.registerGoals: the silverfish's list without the stone
        // tricks, at vanilla's priorities (stroll 1.0, alert others on hurt).
    // rust: S::Endermite => {
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(1, Float);
    // rust: g.add(1, ClimbOnTopOfPowderSnow);
    // rust: g.add(2, MeleeAttack::new(1.0, false));
    // rust: g.add(3, Stroll::avoiding_water(1.0));
    // rust: g.add(7, LookAtPlayer::new(8.0));
    // rust: g.add(8, RandomLookAround::default());
    // rust: m.ai.targets.add(1, HurtByTarget::new().alert());
    // rust: m.ai.targets.add(2, NearestTarget::player(true));
}
    // rust: _ => {}
}
}
/// `InfestedBlock.isCompatibleHostBlock`: the blocks an infested block can
/// be hidden in, i.e. the host side of vanilla's host-to-infested map. A
/// silverfish prefers these as a walking target.
pub fn is_infested_host(name: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(
    // rust: name,
    // rust: "minecraft:stone"
    // rust: | "minecraft:cobblestone"
    // rust: | "minecraft:stone_bricks"
    // rust: | "minecraft:mossy_stone_bricks"
    // rust: | "minecraft:cracked_stone_bricks"
    // rust: | "minecraft:chiseled_stone_bricks"
    // rust: | "minecraft:deepslate"
    // rust: )
}
/// `Silverfish.hurtServer`: a hit by an entity (or magic damage) starts the
/// countdown of its wake-up goal, kept in `extra.counter`.
pub fn silverfish_hurt(m: *mut Mob, source: *Damage) void {
}
    // rust: if (source.attacker.is_some() || source.kind == DamageKind::Magic) && m.extra.counter == 0 {
    // rust: m.extra.counter = super::goals::reduced(20);
}
}
/// `Silverfish.SilverfishWakeUpFriendsGoal`: 20 ticks after being hurt, the
/// infested blocks within 10 blocks sideways and 5 up or down break (or turn
/// back into stone with mob griefing off), until a coin flip stops it.
pub const SilverfishWakeUpFriends = struct {};
    // rust: impl Goal for SilverfishWakeUpFriends {
    // rust: goal_clone!();
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: "SilverfishWakeUpFriendsGoal"
}
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 0
}
pub fn can_use(self: *Self, m: *mut Mob, _cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.extra.counter > 0
}
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: m.extra.counter -= 1;
    // rust: if m.extra.counter > 0 {
    // rust: return;
}
    // rust: let base = [
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: ];
        // The loops' offsets go 0, 1, -1, 2, -2 and so on.
    // rust: let offsets = |limit: i32| std::iter::once(0).chain((1..=limit).flat_map(|i| [i, -i]));
    // rust: for y in offsets(5) {
    // rust: for x in offsets(10) {
    // rust: for z in offsets(10) {
    // rust: let pos = [base[0] + x, base[1] + y, base[2] + z];
    // rust: if !cx
    // rust: .w
    // rust: .block_name(pos[0], pos[1], pos[2])
    // rust: .starts_with("minecraft:infested_")
    // rust: {
    // rust: continue;
}
    // rust: if cx.w.mob_griefing {
    // rust: cx.events.push(MobEvent::BreakBlock { pos, drop: true });
    // rust: } else {
    // rust: cx.events.push(MobEvent::Infest {
    // rust: pos,
    // rust: infested: false,
    // rust: poof: None,
    // rust: });
}
    // rust: if m.random.next_boolean() {
    // rust: return;
}
}
}
}
}
}
/// `Silverfish.SilverfishMergeWithStoneGoal`: a stroll that, now and then
/// with mob griefing on, hides in a stone block next to the silverfish.
pub const SilverfishMergeWithStone = struct {
    stroll: Stroll,
    merge: Option<[i32,
};
    // rust: impl Default for SilverfishMergeWithStone {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: stroll: Stroll::new(1.0).interval(10),
    // rust: merge: None,
}
}
}
    // rust: impl Goal for SilverfishMergeWithStone {
    // rust: goal_clone!();
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: "SilverfishMergeWithStoneGoal"
}
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: MOVE
}
pub fn can_use(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if m.ai.target.is_some() || !m.ai.nav.is_done() {
    // rust: return false;
}
    // rust: if cx.w.mob_griefing
    // rust: && m.random
    // rust: .next_int_bound(super::goals::reduced(10))
    // rust: .unwrap_or(1)
    // rust: == 0
    // rust: {
            // Direction.getRandom: down, up, north, south, west, east.
    // rust: const DIRECTIONS: [[i32; 3]; 6] = [
    // rust: [0, -1, 0],
    // rust: [0, 1, 0],
    // rust: [0, 0, -1],
    // rust: [0, 0, 1],
    // rust: [-1, 0, 0],
    // rust: [1, 0, 0],
    // rust: ];
    // rust: let d = DIRECTIONS[m.random.next_int_bound(6).unwrap_or(0) as usize];
    // rust: let pos = [
    // rust: m.position.x.floor() as i32 + d[0],
    // rust: (m.position.y + 0.5).floor() as i32 + d[1],
    // rust: m.position.z.floor() as i32 + d[2],
    // rust: ];
    // rust: if super::spawn_selection::infested_host(cx.w.block_name(pos[0], pos[1], pos[2])) {
    // rust: self.merge = Some(pos);
    // rust: return true;
}
}
    // rust: self.merge = None;
    // rust: self.stroll.can_use(m, cx)
}
pub fn can_continue(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.merge.is_none() && self.stroll.can_continue(m, cx)
}
pub fn start(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: let Some(pos) = self.merge else {
    // rust: return self.stroll.start(m, cx);
}
    // rust: if super::spawn_selection::infested_host(cx.w.block_name(pos[0], pos[1], pos[2])) {
    // rust: cx.events.push(MobEvent::Infest {
    // rust: pos,
    // rust: infested: true,
    // rust: poof: Some(m.id),
    // rust: });
    // rust: m.removed = true;
}
}
pub fn stop(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: self.stroll.stop(m, cx);
}
}
/// Entity.getLightLevelDependentMagicValue at the eye.
pub fn mob_brightness(m: *Mob, w: *MobWorld) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: w.brightness(
    // rust: m.position.x.floor() as i32,
    // rust: m.eye_y().floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: )
}
pub fn dark_enough(m: *Mob, w: *MobWorld) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: mob_brightness(m, w) < 0.5
}
/// Spider.SpiderAttackGoal: gives up in bright light 1 in 100 ticks.
pub const SpiderAttack = struct {};
    // rust: impl Goal for SpiderAttack {
    // rust: goal_clone!();
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.flags()
}
pub fn can_use(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
        // SpiderAttackGoal.canUse: not while it carries a rider.
    // rust: self.0.can_use(m, cx) && m.extra.rider.is_none()
}
pub fn can_continue(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if mob_brightness(m, cx.w) >= 0.5 && m.random.next_int_bound(100).unwrap_or(1) == 0 {
    // rust: m.ai.target = None;
    // rust: return false;
}
    // rust: self.0.can_continue(m, cx)
}
pub fn start(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: self.0.start(m, cx)
}
pub fn stop(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: self.0.stop(m, cx)
}
pub fn every_tick(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: self.0.tick(m, cx)
}
}
/// SwellGoal: fuse within 3 blocks, defuse beyond 7 or out of sight.
pub const Swell = struct {
    target: ?Who,
};
    // rust: impl Goal for Swell {
    // rust: goal_clone!();
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: MOVE
}
pub fn can_use(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let close = m
    // rust: .target_info(cx.w)
    // rust: .is_some_and(|t| t.alive && m.distance_sqr(t.position) < 9.0);
    // rust: m.extra.counter > 0 || close
}
pub fn start(self: *Self, m: *mut Mob, _: *mut Cx) void {
}
    // rust: m.nav_stop();
    // rust: self.target = m.ai.target;
}
pub fn stop(self: *Self, _: *mut Mob, _: *mut Cx) void {
}
    // rust: self.target = None;
}
pub fn every_tick(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: let dir = match self
    // rust: .target
    // rust: .and_then(|t| cx.w.target_info(t).map(|i| (t, i)))
    // rust: {
    // rust: Some((who, t)) if t.alive => {
    // rust: if m.distance_sqr(t.position) > 49.0 || !m.sees(cx.w, who) {
    // rust: -1
    // rust: } else {
    // rust: 1
}
}
    // rust: _ => -1,
}
    // rust: m.extra.counter = dir;
}
}
/// Creeper.tick on a client of a server: the synced fuse direction
/// (DATA_SWELL_DIR, DATA_IS_IGNITED) swells the creeper the renderer draws;
/// the server explodes it.
pub fn creeper_client_tick(m: *mut Mob) void {
}
    // rust: if !m.alive() {
    // rust: return;
}
    // rust: m.previous_swell = m.swell;
    // rust: if m.extra.flag {
    // rust: m.extra.counter = 1;
}
    // rust: m.swell = (m.swell + m.extra.counter).max(0).min(m.max_swell);
}
/// Creeper.tick: advance the fuse and explode at maxSwell.
pub fn creeper_tick(m: *mut Mob, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: if !m.alive() {
    // rust: return;
}
    // rust: if m.extra.flag {
        // Ignited by flint and steel.
    // rust: m.extra.counter = 1;
}
    // rust: let dir = m.extra.counter;
    // rust: if dir > 0 && m.swell == 0 {
    // rust: events.push(MobEvent::Sound(
    // rust: "entity.creeper.primed",
    // rust: m.center(),
    // rust: 1.0,
    // rust: 0.5,
    // rust: ));
        // Creeper.tick: `gameEvent(GameEvent.PRIME_FUSE)` with the sound.
    // rust: events.push(MobEvent::GameEvent {
    // rust: event: "minecraft:prime_fuse",
    // rust: at: [m.position.x, m.position.y, m.position.z],
    // rust: source: m.id,
    // rust: state: horizon_world::registry::BlockStateId(0),
    // rust: });
}
    // rust: m.swell = (m.swell + dir).max(0);
    // rust: if m.swell >= m.max_swell {
    // rust: m.swell = m.max_swell;
    // rust: let radius = if m.extra.charged { 6.0 } else { 3.0 };
    // rust: let name = match &m.custom_name {
    // rust: Some(name) => crate::text::Text::literal(name.clone()),
    // rust: None => crate::text::Text::translate(
    // rust: &format!("entity.{}", m.kind.id.replace(':', ".")),
    // rust: &[],
    // rust: ),
}
    // rust: events.push(MobEvent::ExplosionSource {
    // rust: mob: m.id,
    // rust: charged: m.extra.charged,
    // rust: name,
    // rust: in_water: m.fluids.in_water,
    // rust: });
    // rust: events.push(MobEvent::Explode(
    // rust: [m.position.x, m.position.y, m.position.z],
    // rust: radius,
    // rust: m.species(),
    // rust: ));
        // Creeper.spawnLingeringCloud: the effects it has make a cloud where it stood, after the
        // blast. A hidden effect (`hideParticles`) takes no part in the cloud's colour.
    // rust: if !m.extra.effects.is_empty() {
            // The ids a potion's effects carry: vanilla ones without the namespace.
    // rust: let effects: Vec<_> = m
    // rust: .extra
    // rust: .effects
    // rust: .iter()
    // rust: .map(|(id, ticks, amp)| (id.strip_prefix("minecraft:").unwrap_or(id), *ticks, *amp))
    // rust: .collect();
    // rust: let color = horizon_client_core::potions::effects_color(
    // rust: effects
    // rust: .iter()
    // rust: .filter(|(id, ..)| !m.extra.hidden_effects.contains(id))
    // rust: .map(|(id, _, amp)| (*id, *amp)),
    // rust: );
    // rust: let hidden = effects
    // rust: .iter()
    // rust: .filter(|(id, ..)| {
    // rust: m.extra
    // rust: .hidden_effects
    // rust: .iter()
    // rust: .any(|h| h.strip_prefix("minecraft:").unwrap_or(h) == *id)
    // rust: })
    // rust: .map(|(id, ..)| *id)
    // rust: .collect();
    // rust: let ambient = effects
    // rust: .iter()
    // rust: .filter(|(id, ..)| {
    // rust: m.extra
    // rust: .ambient_effects
    // rust: .iter()
    // rust: .any(|h| h.strip_prefix("minecraft:").unwrap_or(h) == *id)
    // rust: })
    // rust: .map(|(id, ..)| *id)
    // rust: .collect();
    // rust: events.push(MobEvent::LingeringCloud {
    // rust: at: [m.position.x, m.position.y, m.position.z],
    // rust: effects,
    // rust: hidden,
    // rust: ambient,
    // rust: color,
    // rust: });
}
    // rust: m.removed = true;
}
}
