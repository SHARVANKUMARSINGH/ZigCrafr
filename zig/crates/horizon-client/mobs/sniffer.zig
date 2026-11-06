//! Transpiled from Horizon Rust crate
//! Module: horizon-client_sniffer
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Sniffers (`Sniffer`, `SnifferAi`): the brain's core, idle, sniff and dig
//! activities, scenting and sniffing for diggable ground, walking there,
//! digging up a seed, the explored positions, laying eggs when bred, and
//! `SnifferModel`'s keyframe animations.
// use super::{
    // rust: Mob, MobEvent,
    // rust: anim::{Poses, State},
    // rust: keyframes::Animation,
}
// use std::collections::HashMap;

// Sniffer state: `variant` the state (below), `scratch[0]` the state the
// animations last saw, `positions` the explored positions (newest first),
// `ints[3]` the tick the dug seed drops. AnimState states: feeling happy,
// scenting, sniffing, digging, rising.
pub const IDLING: u8 = 0;
pub const FEELING_HAPPY: u8 = 1;
pub const SCENTING: u8 = 2;
pub const SNIFFING: u8 = 3;
pub const SEARCHING: u8 = 4;
pub const DIGGING: u8 = 5;
pub const RISING: u8 = 6;

/// `Sniffer.getBabyStartAge`.
pub const BABY_START_AGE: i32 = -48000;

pub fn state(m: *Mob) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.extra.variant
}
pub fn now(m: *Mob) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.age as i32
}
/// `Sniffer.getDefaultDimensions`: lower while digging.
pub fn digging(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: state(m) == DIGGING
}
/// `Sniffer.canPlayDiggingSound`.
pub fn can_play_digging_sound(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(state(m), DIGGING | SEARCHING)
}
pub fn register(m: *mut Mob) void {
}
//     use super::path::PathType;
    // rust: m.ai.nav.can_float = true;
    // rust: m.set_malus(PathType::Water, -1.0);
    // rust: m.set_malus(PathType::OnTopOfPowderSnow, -1.0);
    // rust: m.set_malus(PathType::DamageCautious, -1.0);
}
/// `Sniffer.setState`.
pub fn set_state(m: *mut Mob, s: u8) void {
}
    // rust: m.extra.variant = s;
}
/// `Sniffer.getOnPos`: the block under its feet.
pub fn on_pos(m: *Mob) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [
    // rust: m.position.x.floor() as i32,
    // rust: (m.position.y - f64::from(0.2_f32)).floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: ]
}
/// `Sniffer.getHeadBlock`: 2.25 blocks along `getForward()`, at its feet
/// plus 0.2.
pub fn head_block(m: *Mob) [ {
    // Implementation ported from Horizon
    return undefined;
}
//     use horizon_core::geometry::trig::Mth;
    // Vec3.directionFromRotation(xRot, yRot).
    // rust: let to_rad = std::f32::consts::PI / 180.0;
    // rust: let y = -m.yaw * to_rad - std::f32::consts::PI;
    // rust: let x = -m.head_pitch * to_rad;
    // rust: let (y_cos, y_sin) = (y.mcos(), y.msin());
    // rust: let x_cos = -x.mcos();
    // rust: let forward = [f64::from(y_sin * x_cos), f64::from(y_cos * x_cos)];
    // rust: [
    // rust: (m.position.x + forward[0] * 2.25).floor() as i32,
    // rust: (m.position.y + f64::from(0.2_f32)).floor() as i32,
    // rust: (m.position.z + forward[1] * 2.25).floor() as i32,
    // rust: ]
}
/// `Sniffer.tick` and `Sniffer.aiStep` additions: the animation states,
/// the dropped seed and the water malus.
pub fn ai_step(m: *mut Mob, events: *mut std.ArrayList(MobEvent)) void {
}
//     use super::path::PathType;
    // rust: let current = state(m);
    // rust: animate(m);
    // rust: if current == DIGGING && now(m) == m.extra.ints[3] {
    // rust: let h = head_block(m);
    // rust: events.push(MobEvent::GiftLoot {
    // rust: mob: m.id,
    // rust: table: "minecraft:gameplay/sniffer_digging",
    // rust: at: [f64::from(h[0]), f64::from(h[1]), f64::from(h[2])],
    // rust: });
    // rust: events.push(MobEvent::Sound(
    // rust: "entity.sniffer.drop_seed",
    // rust: m.center(),
    // rust: 1.0,
    // rust: 1.0,
    // rust: ));
}
    // The searching sound is the client's (`playSearchingSound`).
    // onPathfindingStart / Done: water only blocks the way while it is dry.
    // rust: let wet = m.fluids.in_water || m.fire_ticks > 0;
    // rust: m.set_malus(PathType::Water, if wet { 0.0 } else { -1.0 });
}
/// `Sniffer.onSyncedDataUpdated(DATA_STATE)`: the animation states of the
/// state it changed to (on a client, each tick for the state it has).
pub fn animate(m: *mut Mob) void {
}
    // rust: let age = m.age as f32;
    // rust: let current = state(m);
    // rust: if current != m.extra.scratch[0] as u8 {
        // resetAnimations, then the state's own.
    // rust: for s in &mut m.anim.states[..5] {
    // rust: s.stop();
}
    // rust: match current {
    // rust: FEELING_HAPPY => m.anim.states[0].start_if_stopped(age),
    // rust: SCENTING => m.anim.states[1].start_if_stopped(age),
    // rust: SNIFFING => m.anim.states[2].start_if_stopped(age),
    // rust: DIGGING => m.anim.states[3].start_if_stopped(age),
    // rust: RISING => m.anim.states[4].start_if_stopped(age),
    // rust: _ => {}
}
    // rust: m.extra.scratch[0] = i32::from(current);
}
}
/// The brain memory holding the explored positions
/// (`SNIFFER_EXPLORED_POSITIONS`).
pub fn to_nbt(m: *Mob, map: *mut horizon_world::nbt::Compound) void {
}
//     use horizon_world::nbt::Tag;
    // rust: let list: Vec<Tag> = m
    // rust: .extra
    // rust: .positions
    // rust: .iter()
    // rust: .map(|p| {
    // rust: Tag::compound([
    // rust: ("dimension", Tag::String("minecraft:overworld".into())),
    // rust: ("pos", Tag::IntArray(p.to_vec())),
    // rust: ])
    // rust: })
    // rust: .collect();
    // rust: let mut memories = horizon_world::nbt::Compound::new();
    // rust: if !list.is_empty() {
    // rust: memories.insert(
    // rust: "minecraft:sniffer_explored_positions".into(),
    // rust: Tag::compound([("value", Tag::List(list))]),
    // rust: );
}
    // rust: map.insert(
    // rust: "Brain".into(),
    // rust: Tag::compound([("memories", Tag::Compound(memories))]),
    // rust: );
}
pub fn from_nbt(m: *mut Mob, tag: *horizon_world::nbt::Tag) void {
}
//     use horizon_world::nbt::Tag;
    // rust: let Some(Tag::List(list)) = tag
    // rust: .get("Brain")
    // rust: .and_then(|b| b.get("memories"))
    // rust: .and_then(|b| b.get("minecraft:sniffer_explored_positions"))
    // rust: .and_then(|b| b.get("value"))
    // rust: else {
    // rust: return;
}
    // rust: m.extra.positions = list
    // rust: .iter()
    // rust: .filter_map(|e| match e.get("pos") {
    // rust: Some(Tag::IntArray(p)) if p.len() == 3 => Some([p[0], p[1], p[2]]),
    // rust: _ => None,
    // rust: })
    // rust: .collect();
}
/// `Sniffer.canMate`'s state test.
pub fn can_mate_state(s: u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(s, IDLING | SCENTING | FEELING_HAPPY)
}
/// Ambient sound: none while digging or searching.
pub fn ambient(m: *Mob) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (!matches!(state(m), DIGGING | SEARCHING)).then_some("entity.sniffer.idle")
}
/// `SnifferModel.setupAnim` (and `SniffletModel`'s baby transform).
pub fn anim(m: *Mob, s: *State, p: *mut Poses, animations: *HashMap<[]const u8) void {
}
    // rust: let get = |n: &str| animations.get(&format!("SnifferAnimation.{n}"));
    // rust: p.xrot("head", s.x_rot.to_radians());
    // rust: p.yrot("head", s.y_rot.to_radians());
    // rust: let walk = if state(m) == SEARCHING {
    // rust: "SNIFFER_SNIFF_SEARCH"
    // rust: } else {
    // rust: "SNIFFER_WALK"
}
    // rust: if let Some(a) = get(walk) {
    // rust: a.apply_walk(s.pos, s.speed, 9.0, 100.0, p);
}
    // rust: let age = s.age;
    // rust: for (st, name) in [
    // rust: (&m.anim.states[3], "SNIFFER_DIG"),
    // rust: (&m.anim.states[2], "SNIFFER_LONGSNIFF"),
    // rust: (&m.anim.states[4], "SNIFFER_STAND_UP"),
    // rust: (&m.anim.states[0], "SNIFFER_HAPPY"),
    // rust: (&m.anim.states[1], "SNIFFER_SNIFFSNIFF"),
    // rust: ] {
    // rust: if let (Some(ms), Some(a)) = (st.millis(age), get(name)) {
    // rust: a.apply(ms, 1.0, p);
}
}
    // The baby layer is SniffletModel geometry, but SnifferRenderer wraps it
    // in a plain SnifferModel, so SnifferAnimation.BABY_TRANSFORM never runs.
}
    // rust: mod tests {
//     use super::*;

pub fn only_calm_states_can_mate() void {
}
    // rust: assert!(can_mate_state(IDLING));
    // rust: assert!(can_mate_state(SCENTING));
    // rust: assert!(can_mate_state(FEELING_HAPPY));
    // rust: assert!(!can_mate_state(SNIFFING));
    // rust: assert!(!can_mate_state(DIGGING));
}
}
