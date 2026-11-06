//! Transpiled from Horizon Rust crate
//! Module: horizon-client_illager
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Illagers outside raids: pillagers (crossbow charging and volleys) and
//! vindicators (axes, Johnny), with `IllagerModel`'s arm poses.
// use super::{
    // rust: Mob, MobEvent, Species, Who,
    // rust: anim::{Poses, State},
    // rust: goals::{
    // rust: Cx, Float, Goal, HurtByTarget, LOOK, LookAtPlayer, MOVE, MeleeAttack, NearestTarget, Prey,
    // rust: Stroll, goal_clone, reduced,
    // rust: },
}
// use crate::items::ItemStack;
// use crate::projectiles::{Projectile, ProjectileKind};
// use horizon_core::geometry::trig::{DEG_TO_RAD, Mth};
// use horizon_core::{geometry::Vec3, random::RandomSource};
// use std::f32::consts::PI;

pub fn targets(m: *mut Mob, villagers_seen: bool) void {
}
    // rust: let mut hurt = HurtByTarget::new().alert();
    // rust: hurt.ignore = vec![
    // rust: Species::Pillager,
    // rust: Species::Vindicator,
    // rust: Species::Witch,
    // rust: Species::Evoker,
    // rust: Species::Illusioner,
    // rust: Species::Vex,
    // rust: Species::Ravager,
    // rust: ];
    // rust: m.ai.targets.add(1, hurt);
    // rust: m.ai.targets.add(2, NearestTarget::player(true));
    // rust: m.ai.targets.add(
    // rust: 3,
    // rust: NearestTarget::species(
    // rust: &[Species::Villager, Species::WanderingTrader],
    // rust: villagers_seen,
    // rust: ),
    // rust: );
    // rust: m.ai.targets
    // rust: .add(3, NearestTarget::species(&[Species::IronGolem], true));
}
/// `AvoidEntityGoal<>(this, Creaking.class, 8.0F, walk, sprint)`.
pub fn avoid_creaking(walk: f64, sprint: f64) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: super::goals::AvoidEntity::new(
    // rust: super::goals::Avoid::Species(vec![Species::Creaking]),
    // rust: 8.0,
    // rust: walk,
    // rust: sprint,
    // rust: )
}
pub fn register_pillager(m: *mut Mob) void {
}
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(0, Float);
    // rust: g.add(1, avoid_creaking(1.0, 1.2));
    // rust: g.add(2, super::raider::HoldGroundAttack::new(10.0));
    // rust: g.add(3, CrossbowAttack::new(1.0, 8.0));
    // rust: g.add(8, Stroll::new(0.6));
    // rust: g.add(9, LookAtPlayer::new(15.0).probability(1.0));
    // rust: g.add(10, LookAtPlayer::mobs(15.0));
    // rust: targets(m, false);
}
pub fn register_vindicator(m: *mut Mob) void {
}
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(0, Float);
    // rust: g.add(1, avoid_creaking(1.0, 1.2));
    // rust: g.add(2, super::doors::BreakDoor::vindicator());
    // rust: g.add(3, super::doors::RaiderOpenDoor::default());
    // rust: g.add(4, super::raider::HoldGroundAttack::new(10.0));
    // rust: g.add(5, MeleeAttack::new(1.0, false));
    // rust: g.add(8, Stroll::new(0.6));
    // rust: g.add(9, LookAtPlayer::new(3.0).probability(1.0));
    // rust: g.add(10, LookAtPlayer::mobs(8.0));
    // rust: targets(m, true);
    // VindicatorJohnnyAttackGoal: a vindicator named Johnny attacks any
    // living entity, other raiders included.
    // rust: m.ai.targets.add(
    // rust: 4,
    // rust: NearestTarget::new(Prey::Filter(|_| true), true)
    // rust: .interval(0)
    // rust: .when(|m, _| m.custom_name.as_deref() == Some("Johnny")),
    // rust: );
}
/// `Vindicator.customServerAiStep`: its navigation opens doors while a raid
/// is at its position.
pub fn vindicator_server_ai_step(m: *mut Mob) void {
}
    // rust: if super::doors::can_navigate_ground(m) {
    // rust: m.ai.nav.can_open_doors = super::raider::state(m).is_some_and(|s| s.raided);
}
}
// Evoker state: `counter` spellCastingTickCount, `variant2` the spell
// being cast (0 none, 1 vexes, 2 fangs, 3 wololo), `counter2` the wololo
// sheep's id.
pub fn register_evoker(m: *mut Mob) void {
}
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(0, Float);
    // rust: g.add(1, CastingSpell);
    // rust: g.add(
    // rust: 2,
    // rust: super::goals::AvoidEntity::new(super::goals::Avoid::Player, 8.0, 0.6, 1.0),
    // rust: );
    // rust: g.add(3, avoid_creaking(0.6, 1.0));
    // rust: g.add(4, UseSpell::new(Spell::Vexes));
    // rust: g.add(5, UseSpell::new(Spell::Fangs));
    // rust: g.add(6, UseSpell::new(Spell::Wololo));
    // rust: g.add(8, Stroll::new(0.6));
    // rust: g.add(9, LookAtPlayer::new(3.0).probability(1.0));
    // rust: g.add(10, LookAtPlayer::mobs(8.0));
    // rust: targets(m, false);
}
pub const Spell = enum {
    Vexes = 1,
    Fangs = 2,
    Wololo = 3,
};
/// `IllagerSpell.spellColor` as `(float)` red, green and blue, by spell id
/// (1 summon vex, 2 fangs, 3 wololo, 4 disappear, 5 blindness).
pub fn spell_color(id: u8) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match id {
    // rust: 1 => [0.7, 0.7, 0.8],
    // rust: 2 => [0.4, 0.3, 0.35],
    // rust: 3 => [0.7, 0.5, 0.2],
    // rust: 4 => [0.3, 0.3, 0.8],
    // rust: 5 => [0.1, 0.1, 0.2],
    // rust: _ => [0.0; 3],
}
}
/// The client half of `SpellcasterIllager.tick`: while the casting-spell data
/// is above 0, two `entity_effect` particles in the spell's colour, one at each
/// hand, which swing with the body and a wobble of the age.
pub fn cast_particles(m: *Mob, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: if m.extra.variant2 == 0 {
    // rust: return;
}
    // rust: let [r, g, b] = spell_color(m.extra.variant2);
    // rust: let angle = m.body_yaw * DEG_TO_RAD + (m.age as f32 * 0.6662).mcos() * 0.25;
    // rust: let (cos, sin) = (f64::from(angle.mcos()), f64::from(angle.msin()));
    // rust: let scale = super::riders::scale(m);
    // rust: let (reach, height) = (0.6 * scale, 1.8 * scale);
    // rust: let p = m.position;
    // rust: for side in [1.0, -1.0] {
    // rust: events.push(MobEvent::ParticleColored {
    // rust: at: [
    // rust: p.x + side * cos * reach,
    // rust: p.y + height,
    // rust: p.z + side * sin * reach,
    // rust: ],
    // rust: color: [r, g, b],
    // rust: });
}
}
/// `SpellcasterCastingSpellGoal`: stand still facing the target while a
/// spell is cast.
    // rust: pub(super) struct CastingSpell;
    // rust: impl Goal for CastingSpell {
    // rust: goal_clone!();
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: MOVE | LOOK
}
pub fn can_use(self: *Self, m: *mut Mob, _cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.extra.counter > 0
}
pub fn start(self: *Self, m: *mut Mob, _cx: *mut Cx) void {
}
    // rust: m.ai.nav.stop();
}
pub fn stop(self: *Self, m: *mut Mob, _cx: *mut Cx) void {
}
    // rust: m.extra.variant2 = 0;
}
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: let look = match m.target_info(cx.w) {
    // rust: Some(t) => Some([t.position.x, t.eye_y, t.position.z]),
    // rust: None => {
    // rust: let id = m.extra.counter2 as u32;
    // rust: cx.w.others
    // rust: .iter()
    // rust: .find(|s| s.id == id)
    // rust: .map(|s| [s.position.x, s.eye_y, s.position.z])
}
}
    // rust: if let Some(at) = look {
    // rust: let (y, x) = (m.kind.head_rot_speed, m.kind.max_head_x_rot);
    // rust: m.look_at_speed(at, y, x);
}
}
}
/// `SpellcasterUseSpellGoal` with the evoker's three spells.
pub const UseSpell = struct {
    spell: Spell,
    warmup: i32,
    next: i64,
};
    // rust: impl UseSpell {
pub fn new(spell: Spell) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: spell,
    // rust: warmup: 0,
    // rust: next: 0,
}
}
    /// (warm-up, casting time, interval, prepare sound).
pub fn timing(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.spell {
    // rust: Spell::Vexes => (20, 100, 340, "entity.evoker.prepare_summon"),
    // rust: Spell::Fangs => (20, 40, 100, "entity.evoker.prepare_attack"),
    // rust: Spell::Wololo => (40, 60, 140, "entity.evoker.prepare_wololo"),
}
}
}
    // rust: impl Goal for UseSpell {
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
    // rust: let age = i64::from(m.age);
    // rust: if self.spell == Spell::Wololo {
            // EvokerWololoSpellGoal.canUse: a blue sheep within the box
            // (16 sideways, 4 up or down) and `range(16)`, no target, griefing on.
    // rust: if m.ai.target.is_some() || m.extra.counter > 0 || age < self.next || !cx.w.mob_griefing
    // rust: {
    // rust: return false;
}
    // rust: let p = m.position;
    // rust: let sheep: Vec<u32> =
    // rust: cx.w.others
    // rust: .iter()
    // rust: .filter(|s| {
    // rust: s.species == Species::Sheep
    // rust: && s.alive
    // rust: && s.color == 11
    // rust: && (s.position.x - p.x).abs() <= 16.0
    // rust: && (s.position.y - p.y).abs() <= 4.0
    // rust: && (s.position.z - p.z).abs() <= 16.0
    // rust: && s.position.distance_squared(p) <= 16.0 * 16.0
    // rust: })
    // rust: .map(|s| s.id)
    // rust: .collect();
    // rust: if sheep.is_empty() {
    // rust: return false;
}
    // rust: let pick = m.random.next_int_bound(sheep.len() as i32).unwrap_or(0) as usize;
    // rust: m.extra.counter2 = sheep[pick] as i32;
    // rust: return true;
}
    // rust: if !m.target_info(cx.w).is_some_and(|t| t.alive) || m.extra.counter > 0 || age < self.next {
    // rust: return false;
}
    // rust: if self.spell == Spell::Vexes {
            // EvokerSummonSpellGoal: fewer vexes within `range(16)` than a
            // roll of 1..8.
    // rust: let p = m.position;
    // rust: let vexes =
    // rust: cx.w.others
    // rust: .iter()
    // rust: .filter(|s| {
    // rust: s.species == Species::Vex
    // rust: && s.alive
    // rust: && s.position.distance_squared(p) <= 16.0 * 16.0
    // rust: })
    // rust: .count() as i32;
    // rust: return m.random.next_int_bound(8).unwrap_or(0) + 1 > vexes;
}
    // rust: true
}
pub fn can_continue(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.spell == Spell::Wololo {
    // rust: return m.extra.counter2 != 0 && self.warmup > 0;
}
    // rust: m.target_info(cx.w).is_some_and(|t| t.alive) && self.warmup > 0
}
pub fn start(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: let (warmup, casting, interval, sound) = self.timing();
    // rust: self.warmup = reduced(warmup);
    // rust: m.extra.counter = casting;
    // rust: self.next = i64::from(m.age) + interval;
    // rust: cx.events.push(MobEvent::Sound(
    // rust: sound,
    // rust: [m.position.x, m.position.y, m.position.z],
    // rust: 1.0,
    // rust: 1.0,
    // rust: ));
    // rust: m.extra.variant2 = self.spell as u8;
}
pub fn stop(self: *Self, m: *mut Mob, _cx: *mut Cx) void {
}
    // rust: if self.spell == Spell::Wololo {
    // rust: m.extra.counter2 = 0;
}
}
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: self.warmup -= 1;
    // rust: if self.warmup != 0 {
    // rust: return;
}
    // rust: match self.spell {
    // rust: Spell::Vexes => summon_vexes(m, cx),
    // rust: Spell::Fangs => cast_fangs(m, cx),
    // rust: Spell::Wololo => {
    // rust: let id = m.extra.counter2 as u32;
    // rust: if id != 0 {
    // rust: cx.events.push(MobEvent::Wololo { mob: id });
}
}
}
    // rust: cx.events.push(MobEvent::Sound(
    // rust: "entity.evoker.cast_spell",
    // rust: [m.position.x, m.position.y, m.position.z],
    // rust: 1.0,
    // rust: 1.0,
    // rust: ));
}
}
/// `EvokerSummonSpellGoal.performSpellCasting`: three vexes nearby for 30
/// to 120 seconds.
pub fn summon_vexes(m: *mut Mob, cx: *mut Cx) void {
}
    // rust: let base = [
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: ];
    // rust: for _ in 0..3 {
    // rust: let r = &mut m.random;
    // rust: let p = [
    // rust: base[0] - 2 + r.next_int_bound(5).unwrap_or(2),
    // rust: base[1] + 1,
    // rust: base[2] - 2 + r.next_int_bound(5).unwrap_or(2),
    // rust: ];
    // rust: let life = 20 * (30 + r.next_int_bound(90).unwrap_or(0));
    // rust: cx.events.push(MobEvent::SpawnKind {
    // rust: kind: "minecraft:vex".into(),
    // rust: at: [f64::from(p[0]), f64::from(p[1]), f64::from(p[2])],
    // rust: setup: super::SpawnSetup {
    // rust: owner_mob: Some(m.id),
    // rust: home: Some(p),
    // rust: life: Some(life),
    // rust: ..Default::default()
    // rust: },
    // rust: });
        // `serverLevel.gameEvent(ENTITY_PLACE, pos, Context.of(evoker))` after each vex.
    // rust: cx.events.push(MobEvent::GameEvent {
    // rust: event: "minecraft:entity_place",
    // rust: at: [
    // rust: f64::from(p[0]) + 0.5,
    // rust: f64::from(p[1]) + 0.5,
    // rust: f64::from(p[2]) + 0.5,
    // rust: ],
    // rust: source: m.id,
    // rust: state: horizon_world::registry::BlockStateId(0),
    // rust: });
}
}
/// `EvokerAttackSpellGoal.performSpellCasting`: a ring of fangs when the
/// target is close, else a line of sixteen toward it.
pub fn cast_fangs(m: *mut Mob, cx: *mut Cx) void {
}
    // rust: let Some(t) = m.target_info(cx.w) else {
    // rust: return;
}
    // rust: let min_y = t.position.y.min(m.position.y);
    // rust: let max_y = t.position.y.max(m.position.y) + 1.0;
    // rust: let angle = (t.position.z - m.position.z).atan2(t.position.x - m.position.x) as f32;
    // rust: let mut place = |x: f64, z: f64, a: f32, delay: i32| {
    // rust: if let Some(y) = fang_floor(cx.w, x, z, min_y, max_y) {
    // rust: cx.events.push(MobEvent::Fangs {
    // rust: at: [x, y, z],
    // rust: yaw: a.to_degrees(),
    // rust: delay,
    // rust: owner: m.id,
    // rust: });
}
}
    // rust: let (x, z) = (m.position.x, m.position.z);
    // rust: if m.distance_sqr(t.position) < 9.0 {
    // rust: for i in 0..5 {
    // rust: let a = angle + i as f32 * PI * 0.4;
    // rust: place(
    // rust: x + f64::from(a.mcos()) * 1.5,
    // rust: z + f64::from(a.msin()) * 1.5,
    // rust: a,
    // rust: 0,
    // rust: );
}
    // rust: for i in 0..8 {
    // rust: let a = angle + i as f32 * PI * 2.0 / 8.0 + PI * 2.0 / 5.0;
    // rust: place(
    // rust: x + f64::from(a.mcos()) * 2.5,
    // rust: z + f64::from(a.msin()) * 2.5,
    // rust: a,
    // rust: 3,
    // rust: );
}
    // rust: } else {
    // rust: for i in 0..16 {
    // rust: let reach = 1.25 * f64::from(i + 1);
    // rust: place(
    // rust: x + f64::from(angle.mcos()) * reach,
    // rust: z + f64::from(angle.msin()) * reach,
    // rust: angle,
    // rust: i,
    // rust: );
}
}
}
/// `createSpellEntity`: the first block below `max_y` whose up face is
/// sturdy, standing on the top of whatever collision shape is in the way.
///
/// The floor test is `BlockState.isFaceSturdy(.., UP)`, not a full cube: a
/// soul sand or mud block is 14/16 high and still supports a fang, where
/// requiring a full collision shape drops the fang into the block.
pub fn fang_floor(w: *super::MobWorld, x: f64, z: f64, min_y: f64, max_y: f64) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (bx, bz) = (x.floor() as i32, z.floor() as i32);
    // rust: let mut y = max_y.floor() as i32;
    // rust: while y >= min_y.floor() as i32 - 1 {
    // rust: let below = w.world.block(bx, y - 1, bz);
    // rust: if w.data.state(below).flags & super::data::STURDY_TOP != 0 {
    // rust: let here = w.world.block(bx, y, bz);
    // rust: let top = if w.facts.is_air(here) {
    // rust: 0.0
    // rust: } else {
    // rust: f64::from(w.data.state(here).top)
}
    // rust: return Some(f64::from(y) + top);
}
    // rust: y -= 1;
}
    // rust: None
}
pub const Crossbow = enum {
    Uncharged,
    Charging,
    Charged,
    Ready,
};
/// `RangedCrossbowAttackGoal`.
pub const CrossbowAttack = struct {
    speed: f64,
    radius_sqr: f64,
    state: Crossbow,
    see_time: i32,
    attack_delay: i32,
    path_delay: i32,
};
    // rust: impl CrossbowAttack {
pub fn new(speed: f64, radius: f64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: speed,
    // rust: radius_sqr: radius * radius,
    // rust: state: Crossbow::Uncharged,
    // rust: see_time: 0,
    // rust: attack_delay: 0,
    // rust: path_delay: 0,
}
}
}
/// The crossbow goal for other crossbow users (piglins).
pub fn crossbow_goal(speed: f64, radius: f64) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: CrossbowAttack::new(speed, radius)
}
/// `CrossbowItem.getChargeDuration` (25 ticks, 5 fewer per level of Quick Charge).
pub fn charge_ticks(m: *Mob) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 25 - 5 * super::gear::level(m, super::gear::MAIN, "minecraft:quick_charge") as i32
}
pub fn holding_crossbow(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.extra.main_hand.as_deref() == Some("minecraft:crossbow")
}

/// `CrossbowItem.setCharged`: the loaded arrow lives in the stack's
/// `charged_projectiles` component, which is what draws it in the crossbow and
/// what `CrossbowItem.isCharged` reads. A mob's held stack carries the
/// components it was spawned or equipped with, so a pillager that loads its
/// own crossbow has to set them itself.
pub fn set_crossbow_charged(m: *mut Mob, charged: bool) void {
}
    // rust: let mut stack = m
    // rust: .extra
    // rust: .main_hand_stack()
    // rust: .cloned()
    // rust: .unwrap_or_else(|| ItemStack::new("minecraft:crossbow", 1));
    // rust: if &*stack.item != "minecraft:crossbow" {
    // rust: return;
}
    // rust: if charged {
    // rust: if stack.data().is_some_and(|d| !d.charged.is_empty()) {
    // rust: return;
}
    // rust: stack.data_mut().charged = vec![ItemStack::new("minecraft:arrow", 1)];
    // rust: } else if stack.data().is_none_or(|d| d.charged.is_empty()) {
    // rust: return;
    // rust: } else {
    // rust: stack.data_mut().charged.clear();
}
    // rust: m.extra.set_main_hand_stack(Some(stack));
}
    // rust: impl Goal for CrossbowAttack {
    // rust: goal_clone!();
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: MOVE | LOOK
}
pub fn can_use(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: holding_crossbow(m)
    // rust: && m.ai
    // rust: .target
    // rust: .and_then(|t| cx.w.target_info(t))
    // rust: .is_some_and(|t| t.alive && !(t.is_player && t.creative))
}
pub fn can_continue(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let valid =
    // rust: m.ai.target
    // rust: .and_then(|t| cx.w.target_info(t))
    // rust: .is_some_and(|t| t.alive && !(t.is_player && t.creative));
    // rust: valid && holding_crossbow(m)
}
pub fn stop(self: *Self, m: *mut Mob, _: *mut Cx) void {
}
    // rust: m.ai.aggressive = false;
    // rust: m.ai.target = None;
    // rust: self.see_time = 0;
    // rust: m.extra.flag = false;
    // rust: m.extra.using_item = 0;
    // rust: self.state = Crossbow::Uncharged;
    // rust: set_crossbow_charged(m, false);
}
pub fn start(self: *Self, m: *mut Mob, _: *mut Cx) void {
}
    // rust: m.ai.aggressive = true;
}
pub fn every_tick(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: let Some(who) = m.ai.target else {
    // rust: return;
}
    // rust: let Some(t) = cx.w.target_info(who) else {
    // rust: return;
}
    // rust: let sees = m.sees(cx.w, who);
    // rust: if sees != (self.see_time > 0) {
    // rust: self.see_time = 0;
}
    // rust: self.see_time += if sees { 1 } else { -1 };
    // rust: let d2 = m.distance_sqr(t.position);
    // rust: let needs_to_move = (d2 > self.radius_sqr || self.see_time < 5) && self.attack_delay == 0;
    // rust: if needs_to_move {
    // rust: self.path_delay -= 1;
    // rust: if self.path_delay <= 0 {
    // rust: let speed = if self.state == Crossbow::Uncharged {
    // rust: self.speed
    // rust: } else {
    // rust: self.speed * 0.5
}
    // rust: m.nav_move_to_entity(cx.w, [t.position.x, t.position.y, t.position.z], 0, speed);
    // rust: self.path_delay = 20 + m.random.next_int_bound(21).unwrap_or(0);
}
    // rust: } else {
    // rust: self.path_delay = 0;
    // rust: m.nav_stop();
}
    // rust: m.look_at_speed([t.position.x, t.eye_y, t.position.z], 30.0, 30.0);
    // rust: match self.state {
    // rust: Crossbow::Uncharged => {
    // rust: if !needs_to_move {
    // rust: self.state = Crossbow::Charging;
    // rust: m.extra.flag = true;
    // rust: m.extra.using_item = 0;
    // rust: let pitch = (m.random.next_float() - m.random.next_float()) * 0.2 + 1.0;
    // rust: cx.events.push(MobEvent::Sound(
    // rust: "item.crossbow.loading_start",
    // rust: m.center(),
    // rust: 1.0,
    // rust: pitch,
    // rust: ));
}
}
    // rust: Crossbow::Charging => {
    // rust: m.extra.using_item += 1;
    // rust: if m.extra.using_item >= charge_ticks(m) {
    // rust: m.extra.using_item = 0;
    // rust: m.extra.flag = false;
    // rust: self.state = Crossbow::Charged;
    // rust: let weapon = m
    // rust: .extra
    // rust: .main_hand_stack()
    // rust: .cloned()
    // rust: .unwrap_or_else(|| ItemStack::new("minecraft:crossbow", 1));
    // rust: set_crossbow_charged(m, true);
                    // The attack delay is drawn before the sound's pitch, as before.
    // rust: self.attack_delay = 20 + m.random.next_int_bound(20).unwrap_or(0);
    // rust: let pitch = 1.0 / (m.random.next_float() * 0.5 + 1.0) + 0.2;
    // rust: cx.events.push(MobEvent::CrossbowLoad {
    // rust: mob: m.id,
    // rust: at: m.center(),
    // rust: pitch,
    // rust: weapon,
    // rust: });
}
}
    // rust: Crossbow::Charged => {
    // rust: self.attack_delay -= 1;
    // rust: if self.attack_delay == 0 {
    // rust: self.state = Crossbow::Ready;
}
}
    // rust: Crossbow::Ready => {
    // rust: if sees {
    // rust: shoot_crossbow(m, who, cx);
    // rust: self.state = Crossbow::Uncharged;
    // rust: set_crossbow_charged(m, false);
}
}
}
}
}
/// `CrossbowAttackMob.performCrossbowAttack` at power 1.6: one arrow aimed a
/// third of the way up the target, lifted by a fifth of the distance.
pub fn shoot_crossbow(m: *mut Mob, who: Who, cx: *mut Cx) void {
}
    // rust: let Some(t) = cx.w.target_info(who) else {
    // rust: return;
}
    // CrossbowItem.shootAll: only the charged projectile flies.
    // rust: let Some(ammo) = m
    // rust: .extra
    // rust: .main_hand_stack()
    // rust: .and_then(|s| s.data())
    // rust: .and_then(|d| d.charged.first().cloned())
    // rust: else {
    // rust: return;
}
    // rust: let start = Vec3::new(m.position.x, m.eye_y() - 0.1, m.position.z);
    // rust: let dx = t.position.x - m.position.x;
    // rust: let dz = t.position.z - m.position.z;
    // rust: let dist = (dx * dx + dz * dz).sqrt();
    // rust: let third =
    // rust: t.bounds.min_position().y + (t.bounds.max_position().y - t.bounds.min_position().y) / 3.0;
    // rust: let dy = third - start.y + dist * 0.2;
    // rust: let mut p = Projectile::new(
    // rust: ProjectileKind::Arrow {
    // rust: base_damage: 2.0,
    // rust: critical: false,
    // rust: effect: None,
    // rust: },
    // rust: start,
    // rust: Some(Who::Mob(m.id)),
    // rust: );
    // rust: p.set_bonus(super::gear::arrow_bonus(m));
    // rangedAttackUncertainty: 14 - 4 * difficulty.
    // rust: p.shoot(
    // rust: &mut crate::projectiles::own_random(m),
    // rust: [dx, dy, dz],
    // rust: 1.6,
    // rust: (14 - i32::from(cx.w.difficulty.id) * 4) as f32,
    // rust: );
    // rust: cx.events.push(MobEvent::CrossbowShot { ammo, arrow: p });
    // rust: let pitch = 1.0 / (m.random.next_float() * 0.5 + 1.8) + 0.53;
    // rust: cx.events.push(MobEvent::Sound(
    // rust: "item.crossbow.shoot",
    // rust: m.center(),
    // rust: 1.0,
    // rust: pitch,
    // rust: ));
}
pub const ArmPose = enum {
    BowAndArrow,
    Spellcasting,
    Crossed,
    Celebrating,
    Neutral,
    Attacking,
    CrossbowHold,
    CrossbowCharge,
    Bow,
};
/// `Pillager` / `Vindicator.getArmPose`.
pub fn arm_pose(m: *Mob) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match m.species() {
    // rust: Species::Pillager => {
    // rust: if m.extra.flag {
    // rust: ArmPose::CrossbowCharge
    // rust: } else if holding_crossbow(m) {
    // rust: ArmPose::CrossbowHold
    // rust: } else if m.ai.aggressive {
    // rust: ArmPose::Attacking
    // rust: } else {
    // rust: ArmPose::Neutral
}
}
    // rust: Species::Illusioner if m.extra.variant2 != 0 => ArmPose::Spellcasting,
    // rust: Species::Illusioner if m.ai.aggressive => ArmPose::Bow,
    // rust: Species::Illusioner => ArmPose::Crossed,
    // rust: Species::Evoker if m.extra.variant2 != 0 => ArmPose::Spellcasting,
    // rust: Species::Evoker if celebrating(m) => ArmPose::Celebrating,
    // rust: Species::Evoker => ArmPose::Crossed,
    // rust: _ => {
    // rust: if m.ai.aggressive {
    // rust: ArmPose::Attacking
    // rust: } else if celebrating(m) {
    // rust: ArmPose::Celebrating
    // rust: } else {
    // rust: ArmPose::Crossed
}
}
}
}
pub fn celebrating(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: super::raider::state(m).is_some_and(|s| s.celebrating)
}
/// Whether the held item shows (vindicators only draw their axe when angry).
pub fn shows_item(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match m.species() {
    // rust: Species::Vindicator => m.ai.aggressive,
    // rust: Species::Illusioner => m.extra.variant2 != 0 || m.ai.aggressive,
    // rust: _ => true,
}
}
pub fn hide(p: *mut Poses, part: []const u8) void {
}
    // rust: p.visible(part, false);
}
/// `IllagerModel.setupAnim`.
pub fn anim(m: *Mob, s: *State, p: *mut Poses) void {
}
    // rust: anim_pose(m, s, p, arm_pose(m));
}
/// `IllagerModel.setupAnim` for a given arm pose.
pub fn anim_pose(m: *Mob, s: *State, p: *mut Poses, pose: ArmPose) void {
}
    // IllagerModel hides the hat; the illusioner's renderer shows it.
    // rust: if m.species() != Species::Illusioner {
    // rust: hide(p, "hat");
}
    // rust: let (hy, hx) = (s.y_rot.to_radians(), s.x_rot.to_radians());
    // rust: p.yrot("head", hy);
    // rust: p.xrot("head", hx);
    // rust: let (pos, sp) = (s.pos, s.speed);
    // rust: if m.extra.passenger {
    // rust: for arm in ["right_arm", "left_arm"] {
    // rust: p.xrot(arm, -PI / 5.0);
    // rust: p.yrot(arm, 0.0);
    // rust: p.zrot(arm, 0.0);
}
    // rust: p.xrot("right_leg", -1.413_716_7);
    // rust: p.yrot("right_leg", PI / 10.0);
    // rust: p.zrot("right_leg", 0.078_539_82);
    // rust: p.xrot("left_leg", -1.413_716_7);
    // rust: p.yrot("left_leg", -PI / 10.0);
    // rust: p.zrot("left_leg", -0.078_539_82);
    // rust: } else {
    // rust: p.xrot("right_arm", (pos * 0.6662 + PI).mcos() * 2.0 * sp * 0.5);
    // rust: p.yrot("right_arm", 0.0);
    // rust: p.zrot("right_arm", 0.0);
    // rust: p.xrot("left_arm", (pos * 0.6662).mcos() * 2.0 * sp * 0.5);
    // rust: p.yrot("left_arm", 0.0);
    // rust: p.zrot("left_arm", 0.0);
    // rust: p.xrot("right_leg", (pos * 0.6662).mcos() * 1.4 * sp * 0.5);
    // rust: p.yrot("right_leg", 0.0);
    // rust: p.zrot("right_leg", 0.0);
    // rust: p.xrot("left_leg", (pos * 0.6662 + PI).mcos() * 1.4 * sp * 0.5);
    // rust: p.yrot("left_leg", 0.0);
    // rust: p.zrot("left_leg", 0.0);
}
    // rust: match pose {
    // rust: ArmPose::Attacking => {
    // rust: if m.extra.main_hand.is_none() {
                // animateZombieArms + bobArms
    // rust: let swing = s.swing;
    // rust: let a = (swing * PI).msin();
    // rust: let b = ((1.0 - (1.0 - swing) * (1.0 - swing)) * PI).msin();
    // rust: p.zrot("right_arm", 0.0);
    // rust: p.zrot("left_arm", 0.0);
    // rust: p.yrot("right_arm", -(0.1 - a * 0.6));
    // rust: p.yrot("left_arm", 0.1 - a * 0.6);
    // rust: let x = -PI / 1.5;
    // rust: p.xrot("right_arm", x + a * 1.2 - b * 0.4);
    // rust: p.xrot("left_arm", x + a * 1.2 - b * 0.4);
    // rust: } else {
                // swingWeaponDown: the main arm swings down.
    // rust: let (main, off) = if m.main_arm_left() {
    // rust: ("left_arm", "right_arm")
    // rust: } else {
    // rust: ("right_arm", "left_arm")
}
    // rust: let swing = s.swing;
    // rust: let a2 = (swing * PI).msin();
    // rust: let a = ((1.0 - (1.0 - swing) * (1.0 - swing)) * PI).msin();
    // rust: p.zrot("right_arm", 0.0);
    // rust: p.zrot("left_arm", 0.0);
    // rust: p.yrot("right_arm", PI / 20.0);
    // rust: p.yrot("left_arm", -PI / 20.0);
    // rust: p.xrot(
    // rust: main,
    // rust: -1.884_955_8 + (s.age * 0.09).mcos() * 0.15 + (a2 * 2.2 - a * 0.4),
    // rust: );
    // rust: p.xrot(
    // rust: off,
    // rust: -0.0 + (s.age * 0.19).mcos() * 0.5 + (a2 * 1.2 - a * 0.4),
    // rust: );
}
    // rust: let bob = |p: &mut Poses, part: &str, sign: f32| {
    // rust: let v = p.get(part);
    // rust: v[5] += sign * ((s.age * 0.09).mcos() * 0.05 + 0.05);
    // rust: v[3] += sign * (s.age * 0.067).msin() * 0.05;
}
    // rust: bob(p, "right_arm", 1.0);
    // rust: bob(p, "left_arm", -1.0);
}
    // rust: ArmPose::Bow => {
    // rust: p.yrot("right_arm", -0.1 + hy);
    // rust: p.xrot("right_arm", -PI / 2.0 + hx);
    // rust: p.xrot("left_arm", -0.942_477_9 + hx);
    // rust: p.yrot("left_arm", hy - 0.4);
    // rust: p.zrot("left_arm", PI / 2.0);
}
    // rust: ArmPose::CrossbowHold => {
    // rust: p.yrot("right_arm", -0.3 + hy);
    // rust: p.yrot("left_arm", 0.6 + hy);
    // rust: p.xrot("right_arm", -PI / 2.0 + hx + 0.1);
    // rust: p.xrot("left_arm", -1.5 + hx);
}
    // rust: ArmPose::CrossbowCharge => {
    // rust: p.yrot("right_arm", -0.8);
    // rust: p.xrot("right_arm", -0.970_796_35);
    // rust: let charge = charge_ticks(m) as f32;
    // rust: let a = (m.extra.using_item as f32 + s.partial).clamp(0.0, charge) / charge;
    // rust: p.yrot("left_arm", 0.4 + (0.85 - 0.4) * a);
    // rust: p.xrot("left_arm", -0.970_796_35 + (-PI / 2.0 + 0.970_796_35) * a);
}
    // rust: ArmPose::Spellcasting => {
    // rust: for (arm, x, z_rot) in [
    // rust: ("right_arm", -5.0, PI * 0.75),
    // rust: ("left_arm", 5.0, -PI * 0.75),
    // rust: ] {
    // rust: let v = p.get(arm);
    // rust: v[2] = 0.0;
    // rust: v[0] = x;
    // rust: v[3] = (s.age * 0.6662).mcos() * 0.25;
    // rust: v[4] = 0.0;
    // rust: v[5] = z_rot;
}
}
    // rust: ArmPose::Celebrating => {
    // rust: for (arm, x, z_rot) in [
    // rust: ("right_arm", -5.0, 2.670_354),
    // rust: ("left_arm", 5.0, -PI * 0.75),
    // rust: ] {
    // rust: let v = p.get(arm);
    // rust: v[2] = 0.0;
    // rust: v[0] = x;
    // rust: v[3] = (s.age * 0.6662).mcos() * 0.05;
    // rust: v[4] = 0.0;
    // rust: v[5] = z_rot;
}
}
    // rust: ArmPose::BowAndArrow => {
    // rust: p.yrot("right_arm", -0.1 + hy);
    // rust: p.xrot("right_arm", -PI / 2.0 + hx);
    // rust: p.xrot("left_arm", -0.942_477_9 + hx);
    // rust: p.yrot("left_arm", hy - 0.4);
    // rust: p.zrot("left_arm", PI / 2.0);
}
    // rust: ArmPose::Crossed | ArmPose::Neutral => {}
}
    // rust: if pose == ArmPose::Crossed {
    // rust: hide(p, "left_arm");
    // rust: hide(p, "right_arm");
    // rust: } else {
    // rust: hide(p, "arms");
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::mobs::Species;
//     use crate::mobs::sensor_scan_tests::kind;
//     use std::sync::Arc;

pub fn evoker(spell: u8) M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut kind = kind();
    // rust: let k = Arc::make_mut(&mut kind);
    // rust: k.id = "minecraft:evoker".into();
    // rust: k.species = Species::Evoker;
    // rust: let mut m = Mob::new(1, kind, Vec3::new(10.0, 64.0, -5.0), 0.0);
    // rust: m.extra.variant2 = spell;
    // rust: m.body_yaw = 90.0;
    // rust: m.age = 7;
    // rust: m
}

    /// `SpellcasterIllager.tick`: two coloured particles at the hands while a
    /// spell is cast, none otherwise; the colours are `IllagerSpell.spellColor`.
pub fn a_casting_evoker_has_a_particle_in_each_hand() void {
}
    // rust: let mut events = Vec::new();
    // rust: cast_particles(&evoker(0), &mut events);
    // rust: assert!(events.is_empty());
    // rust: for (id, want) in [
    // rust: (1, [0.7, 0.7, 0.8]),
    // rust: (2, [0.4, 0.3, 0.35]),
    // rust: (3, [0.7, 0.5, 0.2]),
    // rust: (4, [0.3, 0.3, 0.8]),
    // rust: (5, [0.1, 0.1, 0.2]),
    // rust: ] {
    // rust: events.clear();
    // rust: cast_particles(&evoker(id), &mut events);
    // rust: assert_eq!(events.len(), 2);
    // rust: let hands: Vec<([f64; 3], [f32; 3])> = events
    // rust: .iter()
    // rust: .map(|e| match e {
    // rust: MobEvent::ParticleColored { at, color } => (*at, *color),
    // rust: _ => panic!("not a coloured particle"),
    // rust: })
    // rust: .collect();
    // rust: assert_eq!(hands[0].1, want);
    // rust: assert_eq!(hands[1].1, want);
            // Both at y + 1.8, mirrored about the mob, 0.6 away.
    // rust: assert!((hands[0].0[1] - 65.8).abs() < 1e-9);
    // rust: assert!((hands[0].0[0] + hands[1].0[0] - 20.0).abs() < 1e-9);
    // rust: assert!((hands[0].0[2] + hands[1].0[2] + 10.0).abs() < 1e-9);
    // rust: let (dx, dz) = (hands[0].0[0] - 10.0, hands[0].0[2] + 5.0);
    // rust: assert!((dx.hypot(dz) - 0.6).abs() < 1e-6);
}
}

pub fn pillager() M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut kind = kind();
    // rust: let k = Arc::make_mut(&mut kind);
    // rust: k.id = "minecraft:pillager".into();
    // rust: k.species = Species::Pillager;
    // rust: Mob::new(1, kind, Vec3::ZERO, 0.0)
}

    /// `CrossbowItem.setCharged`: the arrow lives in the stack's components,
    /// and the model draws whatever the stack carries.
pub fn a_charged_crossbow_carries_its_arrow() void {
}
    // rust: let mut m = pillager();
    // rust: m.extra
    // rust: .set_main_hand_stack(Some(ItemStack::new("minecraft:crossbow", 1)));
    // rust: set_crossbow_charged(&mut m, true);
    // rust: let stack = m.extra.main_hand_stack().unwrap();
    // rust: let charged = &stack.data().unwrap().charged;
    // rust: assert_eq!(charged.len(), 1);
    // rust: assert_eq!(&*charged[0].item, "minecraft:arrow");
    // rust: set_crossbow_charged(&mut m, false);
    // rust: assert!(
    // rust: m.extra
    // rust: .main_hand_stack()
    // rust: .unwrap()
    // rust: .data()
    // rust: .unwrap()
    // rust: .charged
    // rust: .is_empty()
    // rust: );
}

    /// A shot crossbow keeps its stack; only the loaded arrow goes.
pub fn charging_leaves_anything_but_a_crossbow_alone() void {
}
    // rust: let mut m = pillager();
    // rust: m.extra
    // rust: .set_main_hand_stack(Some(ItemStack::new("minecraft:iron_sword", 1)));
    // rust: set_crossbow_charged(&mut m, true);
    // rust: assert!(
    // rust: m.extra
    // rust: .main_hand_stack()
    // rust: .unwrap()
    // rust: .data()
    // rust: .is_none_or(|d| d.charged.is_empty())
    // rust: );
}
    /// `EvokerAttackSpellGoal.createSpellEntity` asks the block below for a
    /// sturdy up face, not for a full cube. Soul sand is 14/16 high and still
    /// supports a fang, which a full-collision test drops into the block.
pub fn a_fang_stands_on_a_soul_sand_floor() void {
}
    // rust: let build = |world: &mut crate::world::World,
    // rust: registry: &horizon_world::registry::BlockRegistry| {
    // rust: let stone = registry.default_state("minecraft:stone").unwrap();
    // rust: let soul_sand = registry.default_state("minecraft:soul_sand").unwrap();
    // rust: for cx in -1..1 {
    // rust: for cz in -1..1 {
    // rust: world
    // rust: .chunks
    // rust: .insert((cx, cz), Arc::new(crate::chunk::Chunk::empty(cx, cz)));
}
}
    // rust: for x in -4..4 {
    // rust: for z in -4..4 {
    // rust: world.set(x, 63, z, stone).unwrap();
}
}
    // rust: world.set(0, 64, 0, soul_sand).unwrap();
}
    // rust: let ran = crate::mobs::world::with_built_test_world(&[], build, |w, _| {
            // An evoker standing on the soul sand has its feet at 64.875, so
            // the cast asks for a floor from 65 down: the soul sand at 64 is
            // the first sturdy block and the fang sits at 65.
    // rust: assert_eq!(fang_floor(w, 0.5, 0.5, 64.0, 65.875), Some(65.0));
    // rust: });
    // rust: let _ = ran;
}
}
