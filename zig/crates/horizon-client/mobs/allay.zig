//! Transpiled from Horizon Rust crate
//! Module: horizon-client_allay
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Allays (`Allay`): given an item, they fetch matching drops within 32
//! blocks and bring them to their player (or a liked note block), dance to
//! jukeboxes and duplicate when given an amethyst shard mid-dance.
// use super::{
    // rust: Mob, MobEvent, MobWorld,
    // rust: anim::{Poses, State as AnimState},
    // rust: control::MoveKind,
    // rust: goals::{Cx, Goal, LookAtPlayer, MOVE, Panic, RandomLookAround, Stroll, goal_clone},
    // rust: nav::NavKind,
}
// use crate::items::ItemStack;
// use crate::sculk::{self, Context, Info};
// use horizon_core::geometry::trig::Mth;
// use horizon_core::geometry::{Aabb, Vec3};
// use horizon_protocol::entity_data::PositionSource;

    // rust: pub mod interaction;

// Allay state: `main_hand` the held filter; `State::inventory` the fetched stack,
// `tame` a liked player, `point` the wanted item (set by the game),
// `State::noteblock` the liked note block with `ints[2]` its cooldown,
// `ints[3]` the pickup cooldown, `flag` dancing with `ints[4]` the dance clock,
// `egg_time` the duplication cooldown. AnimState slots: holding (0),
// spinning (1).
pub const HOLD: usize = 0;
pub const SPIN: usize = 1;
/// `Allay.isLikedPlayer`: compare the supplied verified player UUID with
/// the live liked-player memory; identity is supplied by the Game context.
pub fn is_liked_player(m: *Mob, attacker: ?super::Who, uuid: [i32; 4]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: attacker == Some(super::Who::Player) && m.extra.tame && m.extra.owner == Some(uuid)
}
/// `Allay.VibrationUser.VIBRATION_EVENT_LISTENER_RANGE`.
pub const LISTENER_RADIUS: i64 = 16;

/// `AllayAi.TIME_TO_FORGET_NOTEBLOCK`.
pub const TIME_TO_FORGET_NOTEBLOCK: i32 = 600;
/// `Allay.MAX_NOTEBLOCK_DISTANCE`.
pub const MAX_NOTEBLOCK_DISTANCE: i32 = 1024;

/// `GlobalPos`: a block position in a dimension.
pub const GlobalPos = struct {
    dimension: *'static str,
    pos: [i32,
};
    // rust: impl GlobalPos {
    /// `GlobalPos.isCloseEnough`: the same dimension and at most
    /// `max_distance` blocks away on every axis (`Vec3i.distChessboard`).
pub fn is_close_enough(self: *Self, dimension: []const u8, pos: [i32; 3], max_distance: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let chessboard = (0..3)
    // rust: .map(|i| self.pos[i].wrapping_sub(pos[i]).wrapping_abs())
    // rust: .max()
    // rust: .unwrap_or(0);
    // rust: self.dimension == dimension && chessboard <= max_distance
}
}
/// The identifier of a dimension as a `'static` string, for loading saves.
pub fn dimension_id(id: []const u8) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match id {
    // rust: "minecraft:the_nether" => "minecraft:the_nether",
    // rust: "minecraft:the_end" => "minecraft:the_end",
    // rust: _ => "minecraft:overworld",
}
}
/// `Level.dimension` of the level the mob ticks in.
pub fn dimension(w: *MobWorld) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if w.nether {
    // rust: "minecraft:the_nether"
    // rust: } else if w.end {
    // rust: "minecraft:the_end"
    // rust: } else {
    // rust: "minecraft:overworld"
}
}

/// `AllayAi.allayConsidersItemEqual`: the same item (`ItemStack.isSameItem`)
/// and the same potion contents (`!hasNonMatchingPotion`); no
/// `potion_contents` on a stack is the empty contents, and two empty ones match.
// shortcut: only the potion id is compared, not custom effects or colour, which
// `StackData` does not keep; upgrade when it does.
pub fn considers_item_equal(held: *ItemStack, candidate: *ItemStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: held.item == candidate.item && held.potion() == candidate.potion()
}

/// `Allay.setDancing` marks an allay dancing only under `isEffectiveAi()`, so
/// `NoAI` never dances; panicking stops it, and 10 blocks is the jukebox reach
/// (`distance_sq` to the nearest playing jukebox's centre, infinite for none).
pub fn dances(no_ai: bool, panicking: bool, distance_sq: f64) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !no_ai && !panicking && distance_sq <= 100.0
}

/// `Mob.getPickupReach` (1, 1, 1) around the box: `Mob.aiStep`'s looting loop
/// takes an equal drop from here with or without AI, so it is the only pickup a
/// `NoAI` allay has (`canPickUpLoot` and `wantsToPickUp` never ask for AI;
/// walking to a drop is the sensor's and throwing it is the brain's).
pub fn pickup_reach(bounds: Aabb) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: bounds.inflate(Vec3::new(1.0, 1.0, 1.0))
}

/// An allay's vibration listener (`Allay.vibrationData`) and the brain
/// memory `LIKED_NOTEBLOCK_POSITION`; `LIKED_NOTEBLOCK_COOLDOWN_TICKS` is
/// `ints[2]`.
pub const State = struct {
    /// Allay's separate one-slot SimpleContainer.
    inventory: ?ItemStack,
    vibration: sculk::Data,
    noteblock: ?GlobalPos,
};

/// The pocket is independent of the main-hand filter.
pub fn inventory(m: *Mob) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.extra.allay.as_ref()?.inventory.as_ref()
}

    // rust: impl State {
    /// SimpleContainer.canAddItem: merge only identical item components.
pub fn room(self: *Self, stack: *ItemStack, max: u32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let max = max.min(99);
    // rust: match &self.inventory {
    // rust: None => max,
    // rust: Some(held) if held.same_item_same_components(stack) => max.saturating_sub(held.count),
    // rust: Some(_) => 0,
}
}

    /// SimpleContainer.addItem for the Allay's single slot; returns the count accepted.
pub fn add(self: *Self, mut stack: ItemStack, max: u32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let count = stack.count.min(self.room(&stack, max));
    // rust: if count > 0 {
    // rust: if let Some(held) = &mut self.inventory {
    // rust: held.count += count;
    // rust: } else {
    // rust: stack.count = count;
    // rust: self.inventory = Some(stack);
}
}
    // rust: count
}

pub fn take(self: *Self, count: u32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let held = self.inventory.as_mut()?;
    // rust: let mut taken = held.clone();
    // rust: taken.count = count.min(held.count);
    // rust: held.count -= taken.count;
    // rust: if held.count == 0 {
    // rust: self.inventory = None;
}
    // rust: Some(taken)
}
}

pub fn register(m: *mut Mob) void {
}
    // rust: m.extra.allay = Some(Box::default());
    // rust: m.ai.mov.kind = MoveKind::Flying {
    // rust: max_turn: 20.0,
    // rust: hovers: true,
}
    // rust: m.ai.nav.kind = NavKind::Flying;
    // FlyingPathNavigation.setRequiredPathLength(48).
    // rust: m.set_required_path_length(48.0);
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(0, Panic::new(2.5));
    // rust: g.add(1, Fetch);
    // rust: g.add(2, Deliver);
    // rust: g.add(3, StayClose);
    // rust: g.add(4, Stroll::flying(1.0));
    // rust: g.add(5, LookAtPlayer::new(6.0));
    // rust: g.add(6, RandomLookAround::default());
}
/// `Entity.blockPosition`.
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
/// `Allay.VibrationUser.canReceiveVibration`: not without AI; with no liked
/// note block any note will do, with one only that block's, while the allay
/// is within 1024 blocks of it in its dimension (`liked_noteblock_position`).
pub fn can_receive_vibration(m: *Mob, dimension: []const u8, pos: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if m.no_ai {
    // rust: return false;
}
    // rust: let Some(liked_noteblock_position) = m.extra.allay.as_ref().and_then(|st| st.noteblock) else {
    // rust: return true;
}
    // rust: liked_noteblock_position.is_close_enough(dimension, block_pos(m), MAX_NOTEBLOCK_DISTANCE)
    // rust: && liked_noteblock_position.pos == pos
}
/// `AllayAi.hearNoteblock`: an allay without a liked note block likes the
/// one it heard (`liked_noteblock_position`) and waits 600 ticks
/// (`liked_noteblock_cooldown_ticks`); one it already likes starts the wait over.
pub fn hear_noteblock(m: *mut Mob, dimension: *'static str, pos: [i32; 3]) void {
}
    // rust: let heard = GlobalPos { dimension, pos };
    // rust: let Some(st) = m.extra.allay.as_mut() else {
    // rust: return;
}
    // rust: let liked_noteblock_cooldown_ticks = TIME_TO_FORGET_NOTEBLOCK;
    // rust: let liked_noteblock_position = st.noteblock;
    // rust: match liked_noteblock_position {
    // rust: None => {
    // rust: st.noteblock = Some(heard);
    // rust: m.extra.ints[2] = liked_noteblock_cooldown_ticks;
}
    // rust: Some(liked) if liked == heard => m.extra.ints[2] = liked_noteblock_cooldown_ticks,
    // rust: Some(_) => {}
}
}
/// `Allay.VibrationUser.onReceiveVibration`: a note block's note is heard.
pub fn receive_vibration(m: *mut Mob, dimension: *'static str, info: Info) void {
}
    // rust: if info.event == "minecraft:note_block_play" {
    // rust: hear_noteblock(m, dimension, info.pos.map(|v| v.floor() as i32));
}
}
/// `AllayAi.getItemDepositPosition` for the liked note block: the centre of
/// the block above it while the allay is within 1024 blocks of it, it is
/// still a note block and the cooldown runs (`shouldDepositItemsAtLikedNoteblock`),
/// else the memory (`liked_noteblock_position`) is erased and the liked player
/// is the target.
    // rust: pub fn noteblock_deposit(
    // rust: m: &mut Mob,
    // rust: dimension: &str,
    // rust: is_note_block: impl Fn([i32; 3]) -> bool,
    // rust: ) -> Option<[f64; 3]> {
    // rust: let liked = m.extra.allay.as_ref()?.noteblock?;
    // rust: if liked.is_close_enough(dimension, block_pos(m), MAX_NOTEBLOCK_DISTANCE)
    // rust: && is_note_block(liked.pos)
    // rust: && m.extra.ints[2] > 0
    // rust: {
        // `BlockPosTracker(pos.above())`: `Vec3.atCenterOf`.
    // rust: return Some([
    // rust: f64::from(liked.pos[0]) + 0.5,
    // rust: f64::from(liked.pos[1]) + 1.5,
    // rust: f64::from(liked.pos[2]) + 0.5,
    // rust: ]);
}
    // rust: m.extra.allay.as_mut()?.noteblock = None;
    // rust: None
}
/// `AllayAi.getItemDepositPosition`: the liked note block, else the player
/// (`getLikedPlayerPositionTracker`).
pub fn deposit(m: *mut Mob, cx: *Cx) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let dimension = dimension(cx.w);
    // rust: if let Some(p) = noteblock_deposit(m, dimension, |p| {
    // rust: cx.w.block_name(p[0], p[1], p[2]) == "minecraft:note_block"
    // rust: }) {
    // rust: return Some(p);
}
    // rust: if !m.extra.tame {
    // rust: return None;
}
    // rust: let p = cx.w.player.as_ref().filter(|p| p.alive && !p.spectator)?;
    // rust: (p.position.distance_squared(m.position) <= 64.0 * 64.0).then_some([
    // rust: p.position.x,
    // rust: p.position.y,
    // rust: p.position.z,
    // rust: ])
}
/// `GoToWantedItem`: fly to the wanted drop.
pub const Fetch = struct {};
    // rust: impl Goal for Fetch {
    // rust: goal_clone!();
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: MOVE
}
pub fn can_use(self: *Self, m: *mut Mob, _cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.extra.point.is_some() && m.extra.ints[3] <= 0
}
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: if let Some(p) = m.extra.point
    // rust: && (m.ai.nav.is_done() || m.age.is_multiple_of(10))
    // rust: {
    // rust: m.nav_move_to(cx.w, p, 1.75);
}
}
}
/// `GoAndGiveItemsToTarget`: carry the load to the deposit and throw it.
pub const Deliver = struct {};
    // rust: impl Goal for Deliver {
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
    // rust: inventory(m).is_some() && m.extra.point.is_none() && deposit(m, cx).is_some()
}
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: if let Some(p) = deposit(m, cx)
    // rust: && (m.ai.nav.is_done() || m.age.is_multiple_of(10))
    // rust: {
    // rust: m.nav_move_to(cx.w, p, 2.25);
}
}
}
/// `StayCloseToTarget.create(.., 4, 16, 2.25)`: acts only once the deposit is
/// 16 blocks away or more, then walks until within 4.
pub const StayClose = struct {};
    // rust: impl Goal for StayClose {
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
    // rust: m.extra.point.is_none()
    // rust: && deposit(m, cx).is_some_and(|p| {
    // rust: let d = (p[0] - m.position.x).powi(2)
    // rust: + (p[1] - m.position.y).powi(2)
    // rust: + (p[2] - m.position.z).powi(2);
    // rust: d >= 256.0
    // rust: })
}
    /// `MoveToTargetSink.reachedTarget`: the walk target it set is reached
    /// within a Manhattan block distance of 4 (`closeEnough`).
pub fn can_continue(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.extra.point.is_none()
    // rust: && deposit(m, cx).is_some_and(|p| {
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: (0..3)
    // rust: .map(|i| (p[i].floor() as i32 - at[i].floor() as i32).abs())
    // rust: .sum::<i32>()
    // rust: > 4
    // rust: })
}
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: if let Some(p) = deposit(m, cx)
    // rust: && (m.ai.nav.is_done() || m.age.is_multiple_of(10))
    // rust: {
    // rust: m.nav_move_to(cx.w, p, 2.25);
}
}
}
/// `VibrationSystem.Listener.handleGameEvent` for an allay: a free listener
/// within 16 blocks of its eyes schedules the note block notes it can hear
/// (`GameEventTags.ALLAY_CAN_LISTEN`). `occluded` is
/// `VibrationSystem.Listener.isOccluded`.
    // rust: pub fn listen(
    // rust: m: &mut Mob,
    // rust: now: i64,
    // rust: event: &'static str,
    // rust: pos: [f64; 3],
    // rust: ctx: &Context,
    // rust: dimension: &str,
    // rust: occluded: impl Fn([f64; 3], [f64; 3]) -> bool,
    // rust: ) {
    // rust: let eye = [m.position.x, m.eye_y(), m.position.z];
    // rust: let Some(st) = m.extra.allay.as_ref() else {
    // rust: return;
}
    // rust: if st.vibration.current.is_some() {
    // rust: return;
}
    // rust: let block = |p: [f64; 3]| p.map(|v| i64::from(v.floor() as i32));
    // rust: let (source, listener) = (block(pos), block(eye));
    // rust: let d = [0, 1, 2].map(|i| source[i] - listener[i]);
    // rust: if d[0] * d[0] + d[1] * d[1] + d[2] * d[2] > LISTENER_RADIUS * LISTENER_RADIUS {
    // rust: return;
}
    // rust: if !sculk::valid_vibration(sculk::allay_can_listen(event), event, ctx)
    // rust: || !can_receive_vibration(m, dimension, block(pos).map(|v| v as i32))
    // rust: || occluded(pos, eye)
    // rust: {
    // rust: return;
}
    // rust: let d = [pos[0] - eye[0], pos[1] - eye[1], pos[2] - eye[2]];
    // rust: let distance = (d[0] * d[0] + d[1] * d[1] + d[2] * d[2]).sqrt() as f32;
    // rust: if let Some(st) = m.extra.allay.as_mut() {
    // rust: st.vibration.schedule(
    // rust: Info {
    // rust: event,
    // rust: distance,
    // rust: pos,
    // rust: source: ctx.source,
    // rust: owner: ctx.owner,
    // rust: },
    // rust: now,
    // rust: );
}
}
/// `VibrationSystem.Ticker.tick` for an allay, run after the living tick as
/// the server branch of its `tick` override does: it chooses a vibration, lets
/// it travel to the eyes at a block a tick (the particle starts there) and
/// hands it over on arrival.
pub fn tick(m: *mut Mob, w: *MobWorld, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: let tick = m
    // rust: .extra
    // rust: .allay
    // rust: .as_mut()
    // rust: .map(|st| {
    // rust: st.vibration
    // rust: .tick(w.game_time, true, false, |d| d.floor() as i32)
    // rust: })
    // rust: .unwrap_or_default();
    // rust: if let Some((info, travel)) = tick.started {
    // rust: events.push(MobEvent::Vibration {
    // rust: from: info.pos,
    // rust: to: [m.position.x, m.eye_y(), m.position.z],
    // rust: ticks: travel,
            // `Allay.VibrationUser`: `new EntityPositionSource(allay,
            // allay.getEyeHeight())`.
    // rust: source: PositionSource::Entity {
    // rust: id: m.id as i32,
    // rust: y_offset: (m.eye_y() - m.position.y) as f32,
    // rust: },
    // rust: });
}
    // rust: if let Some(info) = tick.received {
    // rust: receive_vibration(m, dimension(w), info);
}
}
/// `Allay.travel`: `travelFlying(input, getSpeed())` — the airborne speed is
/// the one the move control set this tick, and no gravity applies, so an
/// allay never falls under its own travel.
pub fn travel(m: *mut Mob, w: *MobWorld, input: Vec3, events: *mut std.ArrayList(MobEvent)) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let speed = m.ai.speed;
    // rust: m.travel_flying_speeds(w, input, events, 0.02, 0.02, speed);
    // rust: true
}
/// `Allay.aiStep` / `tick`: healing, cooldowns, the hold and spin clocks.
pub fn ai_step(m: *mut Mob) void {
}
    // rust: passive_heal(m);
    // rust: for i in [2, 3] {
    // rust: if m.extra.ints[i] > 0 {
    // rust: m.extra.ints[i] -= 1;
}
}
    // rust: update_duplication_cooldown(m);
    // rust: animate(m);
}
/// `Allay.aiStep`: server-side healing runs independently of the AI gate.
pub fn passive_heal(m: *mut Mob) void {
}
    // rust: if m.alive() && m.age.is_multiple_of(10) {
    // rust: m.heal(1.0);
}
}
/// `Allay.updateDuplicationCooldown`: the server decrements positive counters,
/// independently of the AI goal gate.
pub fn update_duplication_cooldown(m: *mut Mob) void {
}
    // rust: if m.extra.egg_time > 0 {
    // rust: m.extra.egg_time -= 1;
}
}
/// `Allay.tick`'s client half: the hold and spin clocks (the server's and a
/// client's).
pub fn animate(m: *mut Mob) void {
}
    // rust: let holding = m.extra.main_hand.is_some();
    // rust: let v = &mut m.anim.v;
    // rust: v[HOLD] = (v[HOLD] + if holding { 1.0 } else { -1.0 }).clamp(0.0, 5.0);
    // rust: if m.extra.flag {
    // rust: m.extra.ints[4] += 1;
    // rust: let spinning = (m.extra.ints[4] as f32 % 55.0) < 15.0;
    // rust: v[SPIN] = (v[SPIN] + if spinning { 1.0 } else { -1.0 }).clamp(0.0, 15.0);
    // rust: } else {
    // rust: m.extra.ints[4] = 0;
    // rust: v[SPIN] = 0.0;
    // rust: m.anim.vo[SPIN] = 0.0;
}
}
/// `AllayModel.setupAnim`.
pub fn anim(m: *Mob, s: *AnimState, p: *mut Poses) void {
}
//     use std::f32::consts::PI;
    // rust: let (speed, pos) = (s.speed, s.pos);
    // rust: let flap_speed = (s.age * 20.0).to_radians() + pos;
    // rust: let flap = flap_speed.mcos() * PI * 0.15 + speed;
    // rust: let idle_bob = (s.age * 9.0).to_radians();
    // rust: let flying = (speed / 0.3).min(1.0);
    // rust: let idle = 1.0 - flying;
    // rust: let hold = m.anim.lerp(HOLD, s.partial) / 5.0;
    // rust: if m.extra.flag {
    // rust: let dance = (s.age * 8.0).to_radians() + speed;
    // rust: let freq = dance.mcos() * 16f32.to_radians();
    // rust: let spin = m.anim.lerp(SPIN, s.partial) / 15.0;
    // rust: let spinning = (m.extra.ints[4] as f32 % 55.0) < 15.0;
    // rust: if spinning {
    // rust: p.yrot("root", PI * 4.0 * spin);
}
    // rust: p.zrot("root", freq * (1.0 - spin));
    // rust: p.yrot("head", dance.mcos() * 30f32.to_radians() * (1.0 - spin));
    // rust: p.zrot("head", dance.mcos() * 14f32.to_radians() * (1.0 - spin));
    // rust: } else {
    // rust: p.xrot("head", s.x_rot.to_radians());
    // rust: p.yrot("head", s.y_rot.to_radians());
}
    // rust: p.xrot("right_wing", 0.436_332_32 * (1.0 - flying));
    // rust: p.yrot("right_wing", -PI / 4.0 + flap);
    // rust: p.xrot("left_wing", 0.436_332_32 * (1.0 - flying));
    // rust: p.yrot("left_wing", PI / 4.0 - flap);
    // rust: p.xrot("body", flying * PI / 4.0);
    // rust: let arm_x = hold * (-PI / 3.0 + (-1.134_464 + PI / 3.0) * flying);
    // `(float) Math.cos`: the exact function, not `Mth.cos`.
    // rust: p.get("root")[1] += (f64::from(idle_bob).cos() as f32) * 0.25 * idle;
    // rust: p.xrot("right_arm", arm_x);
    // rust: p.xrot("left_arm", arm_x);
    // rust: let arm_bob = idle * (1.0 - hold);
    // rust: let amount = 0.436_332_32 - (idle_bob + PI * 1.5).mcos() * PI * 0.075 * arm_bob;
    // rust: p.zrot("left_arm", -amount);
    // rust: p.zrot("right_arm", amount);
    // rust: p.yrot("right_arm", 0.279_252_68 * hold);
    // rust: p.yrot("left_arm", -0.279_252_68 * hold);
}
    // rust: mod allay_parity_tests {
//     use super::*;

pub fn potion(id: []const u8) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ItemStack::new("minecraft:potion", 1).with_potion(id)
}

pub fn pocket_merges_and_splits_full_stacks_without_changing_the_filter() void {
}
    // rust: let mut m = Mob::new(1, super::super::sensor_scan_tests::kind(), Vec3::ZERO, 0.0);
    // rust: register(&mut m);
    // rust: let filter = potion("minecraft:healing");
    // rust: m.extra.set_main_hand_stack(Some(filter.clone()));
    // rust: let pocket = potion("minecraft:swiftness");
    // rust: let st = m.extra.allay.as_mut().unwrap();
    // rust: assert_eq!(st.add(pocket.clone(), 16), 1);
    // rust: assert_eq!(st.add(filter.clone(), 16), 0);
    // rust: assert_eq!(
    // rust: st.add(
    // rust: ItemStack {
    // rust: count: 20,
    // rust: ..pocket.clone()
    // rust: },
    // rust: 16
    // rust: ),
    // rust: 15
    // rust: );
    // rust: let taken = st.take(1).unwrap();
    // rust: assert!(taken.same_item_same_components(&pocket));
    // rust: assert_eq!(taken.count, 1);
    // rust: assert_eq!(st.inventory.as_ref().unwrap().count, 15);
    // rust: assert_eq!(st.take(u32::MAX).unwrap().count, 15);
    // rust: assert!(st.inventory.is_none());
    // rust: assert!(
    // rust: m.extra
    // rust: .main_hand_stack()
    // rust: .unwrap()
    // rust: .same_item_same_components(&filter)
    // rust: );
    // rust: assert_eq!(m.extra.main_hand_stack().unwrap().count, 1);
}

pub fn a_held_potion_matches_only_its_own_contents() void {
}
    // rust: assert!(!considers_item_equal(
    // rust: &potion("minecraft:swiftness"),
    // rust: &potion("minecraft:healing")
    // rust: ));
    // rust: assert!(considers_item_equal(
    // rust: &potion("minecraft:swiftness"),
    // rust: &potion("minecraft:swiftness")
    // rust: ));
}

pub fn stacks_without_potion_contents_match_by_item() void {
}
    // rust: let stone = ItemStack::new("minecraft:stone", 1);
    // rust: assert!(considers_item_equal(&stone, &stone));
    // rust: assert!(!considers_item_equal(
    // rust: &stone,
    // rust: &ItemStack::new("minecraft:dirt", 1)
    // rust: ));
        // An empty potion component on both sides matches; one is not enough.
    // rust: assert!(considers_item_equal(
    // rust: &ItemStack::new("minecraft:potion", 1),
    // rust: &ItemStack::new("minecraft:potion", 1)
    // rust: ));
    // rust: assert!(!considers_item_equal(
    // rust: &ItemStack::new("minecraft:potion", 1),
    // rust: &potion("minecraft:swiftness")
    // rust: ));
}

pub fn a_no_ai_allay_does_not_dance_to_a_playing_jukebox() void {
}
        // Beside a playing jukebox and at the edge of its 10-block reach.
    // rust: for distance_sq in [0.0, 1.5 * 1.5, 99.0, 100.0] {
    // rust: assert!(!dances(true, false, distance_sq), "NoAI at {distance_sq}");
    // rust: assert!(dances(false, false, distance_sq), "AI at {distance_sq}");
}
        // Out of reach, or panicking: no allay dances.
    // rust: assert!(!dances(false, false, 100.5));
    // rust: assert!(!dances(false, true, 1.0));
}

pub fn a_no_ai_allay_takes_only_a_drop_already_in_pickup_reach() void {
}
        // An allay at 0.5, 64, 0.5: 0.6 wide and tall.
    // rust: let bounds = Aabb::new(Vec3::new(0.2, 64.0, 0.2), Vec3::new(0.8, 64.6, 0.8));
    // rust: let reach = pickup_reach(bounds);
        // `Mob.aiStep`'s looting loop takes a drop at its feet, and one just
        // past the box, with no AI.
    // rust: assert!(reach.contains(Vec3::new(0.5, 64.0, 0.5)));
    // rust: assert!(reach.contains(Vec3::new(0.5, 64.0, 1.7)));
        // Past the one-block grow it would have to walk (`GoToWantedItem` is
        // the brain's), and 32 blocks is the sensor's reach, not this one.
    // rust: assert!(!reach.contains(Vec3::new(0.5, 64.0, 1.9)));
    // rust: assert!(!reach.contains(Vec3::new(0.5, 64.0, 20.0)));
    // rust: assert!(!reach.contains(Vec3::new(0.5, 66.0, 0.5)));
}
}
