//! Transpiled from Horizon Rust crate
package horizon_client_copper_golem

import "core:fmt"
import "core:mem"
import "core:math"

// Copper golems (`CopperGolem`): their brain (`CopperGolemAi`, in
// `animal_brain`) carries items from copper chests to chests
// (`transport_items`); here the chest interaction animations, the idle head
// spin, and weathering until they turn into statues.
// use super::{
    // rust: Mob, MobEvent, MobWorld,
    // rust: anim::{Poses, State},
    // rust: keyframes::Animation,
}
// use horizon_core::random::RandomSource;
// use std::collections::HashMap;

// Copper golem state: `variant` the weathering (0 unaffected .. 3 oxidized),
// `variant3` the `CopperGolemState`, `main_hand` with `ints[1]` the carried
// stack, the saddle slot the antenna (`EQUIPMENT_SLOT_ANTENNA`), `vector[0]`
// the next weathering tick (-1 unset, -2 waxed), `ints[0]` the idle animation
// start tick, `opened_chest` the `openedChestPos`. AnimationState slots: idle
// (0), getting an item (1), getting nothing (2), dropping an item (3),
// dropping nothing (4).
IDLE :: 0
GETTING_ITEM :: 1
GETTING_NO_ITEM :: 2
DROPPING_ITEM :: 3
DROPPING_NO_ITEM :: 4
// `WeatheringCopper.WeatherState` names.
WEATHER :: ["unaffected", "exposed", "weathered", "oxidized"]

register :: proc(m: ^Mob) {
}
    // rust: m.set_required_path_length(48.0);
    // rust: m.ai.nav.can_open_doors = true;
    // rust: m.persistent = true;
    // nextWeatheringTick starts unset (-1); waxed is -2.
    // rust: m.extra.vector[0] = -1.0;
}
// `CopperGolemOxidationLevels`: the body and eye textures.
texture :: proc(m: ^Mob) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match m.extra.variant {
    // rust: 0 => "entity/copper_golem/copper_golem".into(),
    // rust: n => format!(
    // rust: "entity/copper_golem/copper_golem_{}",
    // rust: WEATHER[n.min(3) as usize]
    // rust: ),
}
}
eye_texture :: proc(m: ^Mob) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match m.extra.variant {
    // rust: 0 => "entity/copper_golem/copper_golem_eyes".into(),
    // rust: n => format!(
    // rust: "entity/copper_golem/copper_golem_eyes_{}",
    // rust: WEATHER[n.min(3) as usize]
    // rust: ),
}
}
// The sound of the oxidation level: `spin`, `hurt`, `death` or `step`.
sound :: proc(m: ^Mob, what: string) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match (m.extra.variant, what) {
    // rust: (2, "spin") => "entity.copper_golem_weathered.spin",
    // rust: (2, "hurt") => "entity.copper_golem_weathered.hurt",
    // rust: (2, "death") => "entity.copper_golem_weathered.death",
    // rust: (2, _) => "entity.copper_golem_weathered.step",
    // rust: (3, "spin") => "entity.copper_golem_oxidized.spin",
    // rust: (3, "hurt") => "entity.copper_golem_oxidized.hurt",
    // rust: (3, "death") => "entity.copper_golem_oxidized.death",
    // rust: (3, _) => "entity.copper_golem_oxidized.step",
    // rust: (_, "spin") => "entity.copper_golem.spin",
    // rust: (_, "hurt") => "entity.copper_golem.hurt",
    // rust: (_, "death") => "entity.copper_golem.death",
    // rust: _ => "entity.copper_golem.step",
}
}
// `CopperGolem.setupAnimationStates` (client) and the sound of the head spin.
ai_step :: proc(m: ^Mob, _w: ^MobWorld, events: ^[dynamic]MobEvent) {
}
    // rust: if animate(m) {
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: events.push(MobEvent::LocalSound(sound(m, "spin"), at, 1.0, 1.0));
}
}
// `CopperGolem.setupAnimationStates`, for the server and a client alike;
// returns whether the head spin sound plays now (a client's sound is the
// server's `LocalSound`).
animate :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let mut spin = false;
    // rust: let age = m.age as f32;
    // rust: let state = m.extra.variant3;
    // rust: let st = &mut m.anim.states;
    // rust: let interaction = |st: &mut [super::keyframes::AnimationState; 6], keep: usize| {
    // rust: for (i, s) in st.iter_mut().enumerate().take(5).skip(1) {
    // rust: if i != keep {
    // rust: s.stop();
}
}
}
    // rust: match state {
    // rust: IDLE => {
    // rust: interaction(st, 0);
    // rust: let tick = m.age as i32;
    // rust: if m.extra.ints[0] == tick {
    // rust: st[0].start(age);
    // rust: } else if m.extra.ints[0] == 0 {
                // The client entity's own random, not the server's.
    // rust: let mut r =
    // rust: horizon_core::random::LegacyRandom::new(i64::from(m.id) ^ i64::from(tick));
    // rust: m.extra.ints[0] = tick + 200 + r.next_int_bound(40).unwrap_or(0);
}
    // rust: if tick == m.extra.ints[0] + 10 {
    // rust: spin = true;
    // rust: m.extra.ints[0] = 0;
}
}
    // rust: s @ GETTING_ITEM..=DROPPING_NO_ITEM => {
    // rust: st[0].stop();
    // rust: m.extra.ints[0] = 0;
    // rust: interaction(st, s as usize);
    // rust: st[s as usize].start_if_stopped(age);
}
    // rust: _ => {}
}
    // rust: spin
}
// `CopperGolem.updateWeathering` on the level random: the first tick sets
// the next weathering tick, which advances the weather state; once
// oxidized, a golem on an air block may turn into a statue
// (`MobEvent::BecomeStatue`, done by the host).
    // rust: pub fn update_weathering(
    // rust: m: &mut Mob,
    // rust: w: &MobWorld,
    // rust: lr: &mut impl RandomSource,
    // rust: events: &mut Vec<MobEvent>,
    // rust: ) {
    // rust: if !m.alive() || m.removed {
    // rust: return;
}
    // rust: let now = w.game_time;
    // rust: let next = m.extra.vector[0] as i64;
    // rust: if next == -2 {
    // rust: return;
}
    // rust: let interval = |r: &mut dyn FnMut() -> i32| 504_000 + i64::from(r());
    // rust: let mut draw = || lr.next_int_bound(48_001).unwrap_or(0);
    // rust: if next == -1 {
    // rust: m.extra.vector[0] = (now + interval(&mut draw)) as f64;
    // rust: return;
}
    // rust: let fully = m.extra.variant >= 3;
    // rust: if now >= next && !fully {
    // rust: let new = weather_next(m.extra.variant);
    // rust: m.extra.variant = new;
    // rust: m.extra.vector[0] = if new >= 3 {
    // rust: 0.0
    // rust: } else {
    // rust: (next + interval(&mut draw)) as f64
}
}
    // rust: if fully {
    // rust: let p = [
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: ];
    // rust: if w.facts.is_air(w.world.block(p[0], p[1], p[2])) && lr.next_float() <= 0.0058 {
    // rust: events.push(MobEvent::BecomeStatue { mob: m.id });
}
}
}
// `CopperGolemModel.setupAnim`.
anim :: proc(m: ^Mob, s: ^State, p: ^Poses, animations: ^HashMap<string) {
}
    // rust: p.xrot("head", s.x_rot.to_radians());
    // rust: p.yrot("head", s.y_rot.to_radians());
    // rust: let get = |n: &str| animations.get(&format!("CopperGolemAnimation.COPPER_GOLEM_{n}"));
    // rust: let holding = m.extra.main_hand.is_some() || m.extra.off_hand.is_some();
    // rust: if holding {
    // rust: if let Some(a) = get("WALK_ITEM") {
    // rust: a.apply_walk(s.pos, s.speed, 2.0, 2.5, p);
}
        // poseHeldItemArmsIfStill.
    // rust: let right = p.get("right_arm");
    // rust: right[3] = right[3].min(-0.872_664_6);
    // rust: right[4] = right[4].min(-0.113_446_4);
    // rust: right[5] = right[5].min(-0.064_577_185);
    // rust: let left = p.get("left_arm");
    // rust: left[3] = left[3].min(-0.872_664_6);
    // rust: left[4] = left[4].max(0.113_446_4);
    // rust: left[5] = left[5].max(0.064_577_185);
    // rust: } else if let Some(a) = get("WALK") {
    // rust: a.apply_walk(s.pos, s.speed, 2.0, 2.5, p);
}
    // rust: for (state, name) in [
    // rust: (&m.anim.states[0], "IDLE"),
    // rust: (&m.anim.states[1], "CHEST_INTERACTION_NOITEM_GET"),
    // rust: (&m.anim.states[2], "CHEST_INTERACTION_NOITEM_NOGET"),
    // rust: (&m.anim.states[3], "CHEST_INTERACTION_ITEM_DROP"),
    // rust: (&m.anim.states[4], "CHEST_INTERACTION_ITEM_NODROP"),
    // rust: ] {
    // rust: if let (Some(ms), Some(a)) = (state.millis(s.age), get(name)) {
    // rust: a.apply(ms, 1.0, p);
}
}
}
// `WeatheringCopper.WeatherState.next`/`previous` on the variant.
weather_next :: proc(v: u8) -> u {
    // Ported from Horizon
    return {}
}
    // rust: (v + 1).min(3)
}
weather_previous :: proc(v: u8) -> u {
    // Ported from Horizon
    return {}
}
    // rust: v.saturating_sub(1)
}
    // rust: mod tests {
//     use super::*;
weathering_stops_at_both_ends :: proc() {
}
    // rust: assert_eq!(weather_next(3), 3);
    // rust: assert_eq!(weather_previous(0), 0);
    // rust: assert_eq!(weather_next(1), 2);
    // rust: assert_eq!(weather_previous(2), 1);
}
}
