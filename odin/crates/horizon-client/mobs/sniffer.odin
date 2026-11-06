//! Transpiled from Horizon Rust crate
package horizon_client_sniffer

import "core:fmt"
import "core:mem"
import "core:math"

// Sniffers (`Sniffer`, `SnifferAi`): the brain's core, idle, sniff and dig
// activities, scenting and sniffing for diggable ground, walking there,
// digging up a seed, the explored positions, laying eggs when bred, and
// `SnifferModel`'s keyframe animations.
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
IDLING :: 0
FEELING_HAPPY :: 1
SCENTING :: 2
SNIFFING :: 3
SEARCHING :: 4
DIGGING :: 5
RISING :: 6

// `Sniffer.getBabyStartAge`.
BABY_START_AGE :: -48000

state :: proc(m: ^Mob) -> u {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.variant
}
now :: proc(m: ^Mob) -> i {
    // Ported from Horizon
    return {}
}
    // rust: m.age as i32
}
// `Sniffer.getDefaultDimensions`: lower while digging.
digging :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: state(m) == DIGGING
}
// `Sniffer.canPlayDiggingSound`.
can_play_digging_sound :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(state(m), DIGGING | SEARCHING)
}
register :: proc(m: ^Mob) {
}
//     use super::path::PathType;
    // rust: m.ai.nav.can_float = true;
    // rust: m.set_malus(PathType::Water, -1.0);
    // rust: m.set_malus(PathType::OnTopOfPowderSnow, -1.0);
    // rust: m.set_malus(PathType::DamageCautious, -1.0);
}
// `Sniffer.setState`.
set_state :: proc(m: ^Mob, s: u8) {
}
    // rust: m.extra.variant = s;
}
// `Sniffer.getOnPos`: the block under its feet.
on_pos :: proc(m: ^Mob) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [
    // rust: m.position.x.floor() as i32,
    // rust: (m.position.y - f64::from(0.2_f32)).floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: ]
}
// `Sniffer.getHeadBlock`: 2.25 blocks along `getForward()`, at its feet
// plus 0.2.
head_block :: proc(m: ^Mob) -> [ {
    // Ported from Horizon
    return {}
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
// `Sniffer.tick` and `Sniffer.aiStep` additions: the animation states,
// the dropped seed and the water malus.
ai_step :: proc(m: ^Mob, events: ^[dynamic]MobEvent) {
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
// `Sniffer.onSyncedDataUpdated(DATA_STATE)`: the animation states of the
// state it changed to (on a client, each tick for the state it has).
animate :: proc(m: ^Mob) {
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
// The brain memory holding the explored positions
// (`SNIFFER_EXPLORED_POSITIONS`).
to_nbt :: proc(m: ^Mob, map: ^horizon_world::nbt::Compound) {
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
from_nbt :: proc(m: ^Mob, tag: ^horizon_world::nbt::Tag) {
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
// `Sniffer.canMate`'s state test.
can_mate_state :: proc(s: u8) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(s, IDLING | SCENTING | FEELING_HAPPY)
}
// Ambient sound: none while digging or searching.
ambient :: proc(m: ^Mob) -> O {
    // Ported from Horizon
    return {}
}
    // rust: (!matches!(state(m), DIGGING | SEARCHING)).then_some("entity.sniffer.idle")
}
// `SnifferModel.setupAnim` (and `SniffletModel`'s baby transform).
anim :: proc(m: ^Mob, s: ^State, p: ^Poses, animations: ^HashMap<string) {
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

only_calm_states_can_mate :: proc() {
}
    // rust: assert!(can_mate_state(IDLING));
    // rust: assert!(can_mate_state(SCENTING));
    // rust: assert!(can_mate_state(FEELING_HAPPY));
    // rust: assert!(!can_mate_state(SNIFFING));
    // rust: assert!(!can_mate_state(DIGGING));
}
}
