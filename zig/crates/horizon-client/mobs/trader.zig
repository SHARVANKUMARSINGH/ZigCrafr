//! Transpiled from Horizon Rust crate
//! Module: horizon-client_trader
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The wandering trader (`WanderingTrader`): drinking invisibility at night
//! and milk by day, fleeing monsters, walking to the place it came to
//! visit, staying within its home, trading and leaving after its despawn
//! delay.
// use super::{
    // rust: Mob, MobEvent, MobWorld, Species,
    // rust: goals::{
    // rust: Avoid, AvoidEntity, Cx, Float, Goal, JUMP, LOOK, LookAtPlayer, MOVE, Panic, Stroll,
    // rust: goal_clone,
    // rust: },
}
// use horizon_core::random::RandomSource;

// Trader state: `point` the wander target, `home` the place it is tied to
// with `ints[4]` the radius, `ints[5]` the despawn delay, `flag2` whether
// a player is trading with it and `using_item` how long it has been
// drinking.

/// `WanderingTraderSpawner`: how long a spawned trader stays.
pub const DESPAWN_DELAY: i32 = 48000;
pub const DRINK_TICKS: i32 = 32;
pub const INVISIBILITY: []const u8 = "minecraft:invisibility";

pub fn register(m: *mut Mob) void {
}
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(0, Float);
    // rust: g.add(
    // rust: 0,
    // rust: DrinkItem {
    // rust: item: "minecraft:potion",
    // rust: finish_sound: "entity.wandering_trader.disappeared",
    // rust: dark: true,
    // rust: },
    // rust: );
    // rust: g.add(
    // rust: 0,
    // rust: DrinkItem {
    // rust: item: "minecraft:milk_bucket",
    // rust: finish_sound: "entity.wandering_trader.reappeared",
    // rust: dark: false,
    // rust: },
    // rust: );
    // rust: g.add(1, TradeWithPlayer);
    // rust: for (species, distance) in [
    // rust: (Species::Zombie, 8.0),
    // rust: (Species::Evoker, 12.0),
    // rust: (Species::Vindicator, 8.0),
    // rust: (Species::Vex, 8.0),
    // rust: (Species::Pillager, 15.0),
    // rust: (Species::Illusioner, 12.0),
    // rust: (Species::Zoglin, 10.0),
    // rust: ] {
        // `Zombie.class` covers the zombie family.
    // rust: let list = if species == Species::Zombie {
    // rust: vec![
    // rust: Species::Zombie,
    // rust: Species::Husk,
    // rust: Species::Drowned,
    // rust: Species::ZombieVillager,
    // rust: Species::ZombifiedPiglin,
    // rust: ]
    // rust: } else {
    // rust: vec![species]
}
    // rust: g.add(
    // rust: 1,
    // rust: AvoidEntity::new(Avoid::Species(list), distance, 0.5, 0.5),
    // rust: );
}
    // rust: g.add(1, Panic::new(0.5));
    // rust: g.add(1, LookAtTradingPlayer);
    // rust: g.add(
    // rust: 2,
    // rust: WanderToPosition {
    // rust: stop: 2.0,
    // rust: speed: 0.35,
    // rust: },
    // rust: );
    // rust: g.add(4, MoveTowardsRestriction::new(0.35));
    // rust: g.add(8, Stroll::avoiding_water(0.35));
    // rust: g.add(9, LookAtPlayer::interact(3.0, 1.0));
    // rust: g.add(10, LookAtPlayer::mobs(8.0));
}
pub fn invisible(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.extra.effects.iter().any(|e| e.0 == INVISIBILITY)
}
pub fn is_invisible(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: invisible(m)
}
/// `UseItemGoal`: drink a potion of invisibility once it is dark outside,
/// or milk to clear it by day.
pub const DrinkItem = struct {
    item: *'static str,
    finish_sound: *'static str,
    dark: bool,
};
    // rust: impl Goal for DrinkItem {
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
        // Level.isDarkOutside / isBrightOutside: a dimension with a fixed
        // time (the Nether and the End) is neither dark nor bright outside,
        // so neither potion is drunk.
    // rust: if cx.w.nether || cx.w.end {
    // rust: return false;
}
    // rust: if self.dark {
    // rust: !cx.w.daylight && !invisible(m)
    // rust: } else {
    // rust: cx.w.daylight && invisible(m)
}
}
pub fn can_continue(self: *Self, m: *mut Mob, _: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.extra.using_item > 0
}
pub fn start(self: *Self, m: *mut Mob, _: *mut Cx) void {
}
        // The potion of invisibility keeps its contents (the item model tints by them).
    // rust: if self.item == "minecraft:potion" {
    // rust: m.extra.set_main_hand_stack(Some(
    // rust: crate::items::ItemStack::new(self.item, 1).with_potion("minecraft:invisibility"),
    // rust: ));
    // rust: } else {
    // rust: m.extra.set_main_hand(Some(self.item.into()));
}
    // rust: m.extra.using_item = 1;
}
pub fn stop(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: m.extra.set_main_hand(None);
    // rust: m.extra.using_item = 0;
    // rust: let pitch = m.random.next_float() * 0.2 + 0.9;
    // rust: cx.events
    // rust: .push(MobEvent::Sound(self.finish_sound, m.center(), 1.0, pitch));
}
pub fn every_tick(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: if m.extra.using_item == 0 {
    // rust: return;
}
    // rust: m.extra.using_item += 1;
    // rust: if m.extra.using_item > DRINK_TICKS {
            // LivingEntity.completeUsingItem: the potion or the milk takes effect.
    // rust: if self.dark {
    // rust: m.extra.effects.retain(|e| e.0 != INVISIBILITY);
    // rust: m.extra.effects.push((INVISIBILITY, 3600, 0));
    // rust: cx.events.push(MobEvent::Sound(
    // rust: "entity.wandering_trader.drink_potion",
    // rust: m.center(),
    // rust: 1.0,
    // rust: 1.0,
    // rust: ));
    // rust: } else {
    // rust: m.extra.effects.clear();
    // rust: cx.events.push(MobEvent::Sound(
    // rust: "entity.wandering_trader.drink_milk",
    // rust: m.center(),
    // rust: 1.0,
    // rust: 1.0,
    // rust: ));
}
    // rust: m.extra.using_item = 0;
}
}
}
/// `TradeWithPlayerGoal`: stand still while trading.
pub const TradeWithPlayer = struct {};
    // rust: impl Goal for TradeWithPlayer {
    // rust: goal_clone!();
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: MOVE | JUMP
}
pub fn can_use(self: *Self, m: *mut Mob, _: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.extra.flag2 && m.alive() && !m.fluids.in_water && m.on_ground
}
pub fn start(self: *Self, m: *mut Mob, _: *mut Cx) void {
}
    // rust: m.nav_stop();
}
}
/// `LookAtTradingPlayerGoal`.
pub const LookAtTradingPlayer = struct {};
    // rust: impl Goal for LookAtTradingPlayer {
    // rust: goal_clone!();
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: LOOK
}
pub fn can_use(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.extra.flag2 && cx.w.player.is_some()
}
pub fn every_tick(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: if let Some(p) = &cx.w.player {
    // rust: m.look_at([p.position.x, p.eye[1], p.position.z]);
}
}
}
/// `WanderingTrader.WanderToPositionGoal`: head for the wander target, in
/// hops of ten blocks while it is far.
pub const WanderToPosition = struct {
    stop: f64,
    speed: f64,
};
pub fn too_far(m: *Mob, p: [f64; 3], distance: f64) b {
    // Implementation ported from Horizon
    return undefined;
}
    // BlockPos.closerToCenterThan.
    // rust: let (x, y, z) = (p[0].floor() + 0.5, p[1].floor() + 0.5, p[2].floor() + 0.5);
    // rust: let d = (x - m.position.x).powi(2) + (y - m.position.y).powi(2) + (z - m.position.z).powi(2);
    // rust: d >= distance * distance
}
    // rust: impl Goal for WanderToPosition {
    // rust: goal_clone!();
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: MOVE
}
pub fn can_use(self: *Self, m: *mut Mob, _: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.extra.point.is_some_and(|p| too_far(m, p, self.stop))
}
pub fn stop(self: *Self, m: *mut Mob, _: *mut Cx) void {
}
    // rust: m.extra.point = None;
    // rust: m.nav_stop();
}
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: let Some(p) = m.extra.point else { return };
    // rust: if !m.ai.nav.is_done() {
    // rust: return;
}
    // rust: if too_far(m, p, 10.0) {
    // rust: let d = [
    // rust: p[0].floor() - m.position.x,
    // rust: p[1].floor() - m.position.y,
    // rust: p[2].floor() - m.position.z,
    // rust: ];
    // rust: let len = (d[0] * d[0] + d[1] * d[1] + d[2] * d[2]).sqrt().max(1e-9);
    // rust: let at = [
    // rust: d[0] / len * 10.0 + m.position.x,
    // rust: d[1] / len * 10.0 + m.position.y,
    // rust: d[2] / len * 10.0 + m.position.z,
    // rust: ];
    // rust: m.nav_move_to(cx.w, at, self.speed);
    // rust: } else {
    // rust: m.nav_move_to(cx.w, [p[0].floor(), p[1].floor(), p[2].floor()], self.speed);
}
}
}
/// `Mob.isWithinHome`.
pub fn within_home(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(h) = m.extra.home else { return true };
    // rust: let r = m.extra.ints[4];
    // rust: if r <= 0 {
    // rust: return true;
}
    // rust: let d = (h[0] - m.position.x.floor() as i32).pow(2)
    // rust: + (h[1] - m.position.y.floor() as i32).pow(2)
    // rust: + (h[2] - m.position.z.floor() as i32).pow(2);
    // rust: d < r * r
}
/// `MoveTowardsRestrictionGoal`.
pub const MoveTowardsRestriction = struct {
    speed: f64,
    wanted: [f64,
};
    // rust: impl MoveTowardsRestriction {
pub fn new(speed: f64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: speed,
    // rust: wanted: [0.0; 3],
}
}
}
    // rust: impl Goal for MoveTowardsRestriction {
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
    // rust: if within_home(m) {
    // rust: return false;
}
    // rust: let Some(h) = m.extra.home else { return false };
    // rust: let to = [
    // rust: f64::from(h[0]) + 0.5,
    // rust: f64::from(h[1]),
    // rust: f64::from(h[2]) + 0.5,
    // rust: ];
    // rust: match m.default_random_pos_towards(cx.w, 16, 7, to, std::f64::consts::FRAC_PI_2) {
    // rust: Some(p) => {
    // rust: self.wanted = p;
    // rust: true
}
    // rust: None => false,
}
}
pub fn can_continue(self: *Self, m: *mut Mob, _: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !m.ai.nav.is_done()
}
pub fn start(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: m.nav_move_to(cx.w, self.wanted, self.speed);
}
}
/// `WanderingTrader.maybeDespawn` in `aiStep`.
pub fn ai_step(m: *mut Mob, _w: *MobWorld) void {
}
    // rust: if m.extra.ints[5] > 0 && !m.extra.flag2 {
    // rust: m.extra.ints[5] -= 1;
    // rust: if m.extra.ints[5] == 0 {
    // rust: m.removed = true;
}
}
}
    // rust: mod tests {
//     use super::*;

pub fn despawn_delay_is_two_days() void {
}
    // rust: assert_eq!(DESPAWN_DELAY, 2 * 24000);
}

    /// `UseItemGoal` for the wandering trader: the End has a fixed time, so
    /// it is neither dark nor bright outside and the trader drinks nothing.
pub fn a_trader_does_not_drink_in_the_end() void {
}
//         use crate::mobs::world::with_test_world;
//         use horizon_core::geometry::Vec3;
//         use horizon_core::random::LegacyRandom;
//         use std::sync::Arc;
    // rust: let _ = with_test_world(&[], |w, types| {
    // rust: let kind = Arc::new(types.types["minecraft:wandering_trader"].clone());
    // rust: let mut m = Mob::new(1, kind, Vec3::new(0.5, 80.0, 0.5), 0.0);
    // rust: let mut potion = DrinkItem {
    // rust: item: "minecraft:potion",
    // rust: finish_sound: "entity.wandering_trader.disappeared",
    // rust: dark: true,
}
    // rust: let mut milk = DrinkItem {
    // rust: item: "minecraft:milk_bucket",
    // rust: finish_sound: "entity.wandering_trader.reappeared",
    // rust: dark: false,
}
    // rust: let decide =
    // rust: |world: &MobWorld, m: &mut Mob, potion: &mut DrinkItem, milk: &mut DrinkItem| {
    // rust: let mut lr = LegacyRandom::new(1);
    // rust: let mut events = Vec::new();
    // rust: let mut cx = Cx {
    // rust: w: world,
    // rust: lr: &mut lr,
    // rust: events: &mut events,
}
    // rust: let dark = potion.can_use(m, &mut cx);
    // rust: let day = milk.can_use(m, &mut cx);
    // rust: (dark, day)
}
    // rust: let mut night = w.clone();
    // rust: night.daylight = false;
    // rust: night.end = false;
    // rust: night.nether = false;
    // rust: assert_eq!(
    // rust: decide(&night, &mut m, &mut potion, &mut milk),
    // rust: (true, false)
    // rust: );
    // rust: let mut end_dark = night.clone();
    // rust: end_dark.end = true;
    // rust: assert_eq!(
    // rust: decide(&end_dark, &mut m, &mut potion, &mut milk),
    // rust: (false, false)
    // rust: );
    // rust: m.extra.effects.push((INVISIBILITY, 3600, 0));
    // rust: let mut day = w.clone();
    // rust: day.daylight = true;
    // rust: day.end = false;
    // rust: day.nether = false;
    // rust: assert_eq!(decide(&day, &mut m, &mut potion, &mut milk), (false, true));
    // rust: let mut end_bright = day.clone();
    // rust: end_bright.end = true;
    // rust: assert_eq!(
    // rust: decide(&end_bright, &mut m, &mut potion, &mut milk),
    // rust: (false, false)
    // rust: );
    // rust: });
}
}
