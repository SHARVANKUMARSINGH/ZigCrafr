//! Transpiled from Horizon Rust crate
package horizon_client_caravan

import "core:fmt"
import "core:mem"
import "core:math"

// Llama caravans and the trader's llamas: `LlamaFollowCaravanGoal` (a
// llama joins the nearest line of llamas that starts at a leashed one and
// follows the llama ahead), `TraderLlamaDefendWanderingTraderGoal` and the
// trader llama's despawn.
// use super::{
    // rust: Mob, MobWorld, Seen, Species, Who,
    // rust: goals::{Cx, Goal, TARGET, TargetState, goal_clone, reduced, target_continue},
    // rust: llama::is_llama,
}
// use horizon_core::geometry::Vec3;

CARAVAN_LIMIT :: 8

// The id plus one of the llama this one follows, 0 when not in a caravan
// (`Llama.caravanHead`, kept in `ints[1]`).
head_of :: proc(m: ^Mob) -> u {
    // Ported from Horizon
    return {}
}
    // rust: if is_llama(m.species()) {
    // rust: m.extra.ints[1].max(0) as u32
    // rust: } else {
    // rust: 0
}
}
in_caravan :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: head_of(m) != 0
}
is_leashed_seen :: proc(s: ^Seen) -> b {
    // Ported from Horizon
    return {}
}
    // rust: s.leash.is_some()
}
// Whether another llama follows `s` (`hasCaravanTail`).
has_tail :: proc(cx: ^Cx, s: ^Seen) -> b {
    // Ported from Horizon
    return {}
}
    // rust: cx.w.others
    // rust: .iter()
    // rust: .any(|o| is_llama(o.species) && o.alive && o.caravan == s.id + 1)
}
// `firstIsLeashed`: the line leads back to a leashed llama in at most
// eight links.
first_is_leashed :: proc(cx: ^Cx, caravan: u32, leashed: bool, counter: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if counter > CARAVAN_LIMIT {
    // rust: return false;
}
    // rust: let _ = leashed;
    // rust: if caravan == 0 {
    // rust: return false;
}
    // rust: let Some(head) = cx.w.seen(caravan - 1) else {
    // rust: return false;
}
    // rust: if is_leashed_seen(head) {
    // rust: true
    // rust: } else {
    // rust: first_is_leashed(cx, head.caravan, false, counter + 1)
}
}
// `LlamaFollowCaravanGoal`.
FollowCaravan :: struct {
    speed: f64,
    dist_check: i32,
}
    // rust: impl FollowCaravan {
new :: proc(speed: f64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: speed,
    // rust: dist_check: 0,
}
}
}
    // rust: impl Goal for FollowCaravan {
    // rust: goal_clone!();
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: "LlamaFollowCaravanGoal"
}
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: super::goals::MOVE
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if m.extra.leash.is_some() || in_caravan(m) {
    // rust: return false;
}
    // rust: let area = m.bounds().inflate(Vec3::new(9.0, 4.0, 9.0));
    // rust: let mine = m.position;
    // rust: let id = m.id;
    // rust: let candidates: Vec<&Seen> = cx
    // rust: .w
    // rust: .others
    // rust: .iter()
    // rust: .filter(|s| s.id != id && is_llama(s.species) && s.alive && s.bounds.intersects(area))
    // rust: .collect();
    // rust: let mut closest: Option<&Seen> = None;
    // rust: let mut best = f64::MAX;
    // rust: for c in &candidates {
    // rust: if c.caravan != 0 && !has_tail(cx, c) {
    // rust: let d = mine.distance_squared(c.position);
    // rust: if d <= best {
    // rust: best = d;
    // rust: closest = Some(c);
}
}
}
    // rust: if closest.is_none() {
    // rust: for c in &candidates {
    // rust: if is_leashed_seen(c) && !has_tail(cx, c) {
    // rust: let d = mine.distance_squared(c.position);
    // rust: if d <= best {
    // rust: best = d;
    // rust: closest = Some(c);
}
}
}
}
    // rust: let Some(head) = closest else {
    // rust: return false;
}
    // rust: if best < 4.0 {
    // rust: return false;
}
    // rust: if !is_leashed_seen(head) && !first_is_leashed(cx, head.caravan, false, 1) {
    // rust: return false;
}
    // rust: m.extra.ints[1] = head.id as i32 + 1;
    // rust: true
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let caravan = head_of(m);
    // rust: if caravan == 0 {
    // rust: return false;
}
    // rust: let Some(head) = cx.w.seen(caravan - 1).filter(|h| h.alive) else {
    // rust: return false;
}
    // rust: if !first_is_leashed(cx, caravan, false, 0) {
    // rust: return false;
}
        // Two llamas that joined the same one in the same tick: the one with
        // the higher id leaves and looks for another place.
    // rust: if cx
    // rust: .w
    // rust: .others
    // rust: .iter()
    // rust: .any(|o| o.id < m.id && is_llama(o.species) && o.alive && o.caravan == caravan)
    // rust: {
    // rust: return false;
}
    // rust: let dist_sqr = m.position.distance_squared(head.position);
    // rust: if dist_sqr > 676.0 {
    // rust: if self.speed <= 3.0 {
    // rust: self.speed *= 1.2;
    // rust: self.dist_check = reduced(40);
    // rust: return true;
}
    // rust: if self.dist_check == 0 {
    // rust: return false;
}
}
    // rust: if self.dist_check > 0 {
    // rust: self.dist_check -= 1;
}
    // rust: true
}
stop :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: m.extra.ints[1] = 0;
        // A double 2.1 here, while the llama built it with 2.1F.
    // rust: self.speed = 2.1;
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: let caravan = head_of(m);
    // rust: if caravan == 0 {
    // rust: return;
}
        // A llama leashed to a fence knot does not walk to the one ahead.
    // rust: if matches!(m.extra.leash, Some(super::leash::Holder::Knot(_))) {
    // rust: return;
}
    // rust: let Some(head) = cx.w.seen(caravan - 1) else {
    // rust: return;
}
    // rust: let to = Vec3::new(
    // rust: head.position.x - m.position.x,
    // rust: head.position.y - m.position.y,
    // rust: head.position.z - m.position.z,
    // rust: );
    // rust: let distance = to.length();
    // rust: let delta = to.normalize().scale((distance - 2.0).max(0.0));
    // rust: m.nav_move_to(
    // rust: cx.w,
    // rust: [
    // rust: m.position.x + delta.x,
    // rust: m.position.y + delta.y,
    // rust: m.position.z + delta.z,
    // rust: ],
    // rust: self.speed,
    // rust: );
}
}
// `TraderLlamaDefendWanderingTraderGoal`: attack whoever last hurt the
// wandering trader holding this llama's lead.
DefendTrader :: struct {
    attacker: Maybe(Who),
    timestamp: i32,
    st: TargetState,
}
    // rust: impl Goal for DefendTrader {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: TARGET
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(super::leash::Holder::Mob(id)) = m.extra.leash else {
    // rust: return false;
}
    // rust: let Some(owner) =
    // rust: cx.w.seen(id)
    // rust: .filter(|s| s.species == Species::WanderingTrader)
    // rust: else {
    // rust: return false;
}
    // rust: let Some((by, stamp)) = owner.hurt_by else {
    // rust: return false;
}
    // rust: if stamp == self.timestamp {
    // rust: return false;
}
    // rust: let Some(t) = cx.w.target_info(by) else {
    // rust: return false;
}
    // rust: if !t.alive || t.is_player && t.creative {
    // rust: return false;
}
    // rust: let follow = m.attrs.follow_range;
    // rust: if m.distance_sqr(t.position) > follow * follow || !m.sees(cx.w, by) {
    // rust: return false;
}
    // rust: self.attacker = Some(by);
    // rust: true
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: target_continue(&mut self.st, false, m, cx)
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: m.ai.target = self.attacker;
    // rust: if let Some(super::leash::Holder::Mob(id)) = m.extra.leash
    // rust: && let Some(owner) = cx.w.seen(id)
    // rust: && let Some((_, stamp)) = owner.hurt_by
    // rust: {
    // rust: self.timestamp = stamp;
}
}
stop :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: m.ai.target = None;
}
}
// `TraderLlama.maybeDespawn`: counts down its own delay, or follows the
// trader's when led by one, unless tamed, led by something else, ridden,
// age-locked or kept.
trader_llama_tick :: proc(m: ^Mob, w: ^MobWorld) {
}
    // rust: let trader = match m.extra.leash {
    // rust: Some(super::leash::Holder::Mob(id)) => w
    // rust: .seen(id)
    // rust: .filter(|s| s.species == Species::WanderingTrader)
    // rust: .map(|s| s.delay),
    // rust: _ => None,
}
    // rust: let leashed_other = m.extra.leash.is_some() && trader.is_none();
    // rust: if m.extra.tame || leashed_other || m.rider.is_some() || m.extra.age_locked || m.persistent {
    // rust: return;
}
    // rust: m.extra.ints[0] = trader.unwrap_or(m.extra.ints[0]) - 1;
    // rust: if m.extra.ints[0] <= 0 {
    // rust: super::leash::remove(m);
    // rust: m.removed = true;
}
}
