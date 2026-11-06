//! Transpiled from Horizon Rust crate
package horizon_client_goat

import "core:fmt"
import "core:mem"
import "core:math"

// Goats (`Goat`, `GoatAi`): the lowered head (`lowerHeadTick`, entity
// events 58 and 59) and the ram activity: `PrepareRamNearestTarget` picks
// the nearest living thing it can see, walks to a spot four to seven
// blocks away in a straight line and waits there 20 ticks with its head
// down; `RamTarget` then charges at it, knocks it back, or breaks a horn
// on a log, stone or ore. Both are one goal here. The long jump activity is
// the frog's goal (frog.rs) with the goat's numbers.
// use super::{
    // rust: Damage, Mob, MobEvent, MobWorld, Who,
    // rust: goals::{Cx, Goal, LOOK, MOVE, goal_clone},
}
// use horizon_core::{geometry::Vec3, random::RandomSource};

// `GoatAi.TIME_BETWEEN_RAMS` and `TIME_BETWEEN_RAMS_SCREAMER`.
RAMS :: (600, 6000)
RAMS_SCREAMER :: (100, 300)
RAM_PREPARE_TIME :: 20
MIN_RAM_DISTANCE :: 4
MAX_RAM_DISTANCE :: 7
// `PrepareRamNearestTarget.TIME_OUT_DURATION` and `RamTarget`'s.
PREPARE_TIME_OUT :: 160
RAM_TIME_OUT :: 200
// `NEAREST_VISIBLE_LIVING_ENTITIES` reaches 16 blocks.
SENSE_RANGE :: 16.0

Phase :: enum {
    Done,
    Prepare,
    // `RAM_TARGET` is set; `RamTarget` starts on the next tick.
    RamStart,
    Ram,
}
Candidate :: struct {
    start: [i32,
    target_pos: [i32,
    target: Who,
}

// The lowered head and the ram behaviours' state. `RAM_COOLDOWN_TICKS` is a
// brain memory (`ram_cooldown_ticks`), saved with the others.
State :: struct {
    lower_head_tick: i32,
    lowering_head: bool,
    phase: Phase,
    candidate: Maybe(Candidate),
    reached_at: Maybe(i32),
    // `RAM_TARGET`, and the direction of the charge.
    ram_target: Maybe(Vec3),
    ram_direction: Vec3,
    time: i32,
    // `LivingEntity.discardFriction`, set through the long jump.
    discard_friction: bool,
}

register :: proc(m: ^Mob) {
}
    // rust: m.ai.goals.add(2, Ram);
    // `GoatAi.initLongJumpActivity`: the long jump activity comes after the
    // ram activity and before the idle one.
    // rust: m.ai.goals.add(2, super::frog::LongJump::default());
}
// The goat's long jump activity is the one in use: `GoatAi` tries the ram
// activity first, so the ram cooldown runs, and the long jump activity wants
// no tempting player, no breed target and no walk target (the navigation is
// idle).
    // rust: pub(super) fn long_jump_activity(m: &Mob, w: &MobWorld) -> bool {
    // rust: ram_cooldown(m) > 0 && m.ai.nav.is_done() && !tempted(m, w) && !breeding(m, w)
}
// `TemptingSensor.forAnimal`: a player within 10 blocks holds goat food.
tempted :: proc(m: ^Mob, w: ^MobWorld) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let holds = |item: &Option<std::sync::Arc<str>>| {
    // rust: item.as_deref()
    // rust: .is_some_and(|i| m.kind.food.iter().any(|f| f.as_str() == i))
}
    // rust: w.player.as_ref().is_some_and(|p| {
    // rust: p.alive
    // rust: && !p.spectator
    // rust: && m.distance_sqr(p.position) <= 100.0
    // rust: && (holds(&p.main_hand) || holds(&p.off_hand))
    // rust: && m.rider.is_none()
    // rust: })
}
// `AnimalMakeLove.checkExtraStartConditions`: the goat is in love and an
// adult goat in love is near, so `BREED_TARGET` is set or about to be.
breeding :: proc(m: ^Mob, w: ^MobWorld) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let id = m.id;
    // rust: m.extra.in_love > 0
    // rust: && w.nearby(m.position, 8.0, move |s| {
    // rust: s.id != id && s.species == super::Species::Goat && s.in_love && !s.baby
    // rust: })
    // rust: .next()
    // rust: .is_some()
}

// `Goat.handleEntityEvent`: 58 lowers the head, 59 raises it.
entity_event :: proc(m: ^Mob, event: u8) {
}
    // rust: match event {
    // rust: 58 => m.extra.goat.lowering_head = true,
    // rust: 59 => m.extra.goat.lowering_head = false,
    // rust: _ => {}
}
}
// `Entity.setPose` and the `refreshDimensions` it triggers, for a goat of a
// server: the pose's box (`Goat.getDefaultDimensions` scales a long jump's
// by 0.7), and a box that grew (the goat lands) is moved to a free spot
// (`fudgePositionAfterSizeChange`).
set_pose :: proc(m: ^Mob, w: ^MobWorld, id: u8) {
}
    // rust: let (old_w, old_h, _) = m.dims();
    // rust: m.extra.pose = id;
    // rust: m.fudge_position_after_size_change(w, old_w, old_h);
}
// `Goat.aiStep`'s `lowerHeadTick`; a client runs it too.
tick :: proc(m: ^Mob) {
}
    // rust: let g = &mut m.extra.goat;
    // rust: g.lower_head_tick += if g.lowering_head { 1 } else { -2 };
    // rust: g.lower_head_tick = g.lower_head_tick.clamp(0, 20);
    // `CountDownCooldownTicks(RAM_COOLDOWN_TICKS)`: one less each tick, erased
    // once it runs out.
    // rust: let cooldown = ram_cooldown(m);
    // rust: if cooldown > 0 {
    // rust: set_ram_cooldown(m, cooldown - 1);
}
    // `CountDownCooldownTicks(LONG_JUMP_COOLDOWN_TICKS)` of the core activity.
    // rust: super::frog::count_down_cooldown(m);
}
// `RAM_COOLDOWN_TICKS`: 0 when absent.
ram_cooldown :: proc(m: ^Mob) -> i {
    // Ported from Horizon
    return {}
}
    // rust: m.extra
    // rust: .memories
    // rust: .iter()
    // rust: .find(|x| x.0 == RAM_COOLDOWN)
    // rust: .map_or(0, |x| x.1 as i32)
}
set_ram_cooldown :: proc(m: ^Mob, ticks: i32) {
}
    // rust: let memories = &mut m.extra.memories;
    // rust: match memories.iter().position(|x| x.0 == RAM_COOLDOWN) {
    // rust: Some(i) if ticks > 0 => memories[i].1 = i64::from(ticks),
    // rust: Some(i) => {
    // rust: memories.remove(i);
}
    // rust: None if ticks > 0 => memories.push((RAM_COOLDOWN, i64::from(ticks), i64::MAX)),
    // rust: None => {}
}
}
RAM_COOLDOWN :: "ram_cooldown_ticks"
// `Goat.getRammingXHeadRot`.
ramming_x_head_rot :: proc(m: ^Mob) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let max = if m.is_baby() { 52.5_f32 } else { 30.0 };
    // rust: m.extra.goat.lower_head_tick as f32 / 20.0 * max * (std::f32::consts::PI / 180.0)
}
// A server's `level.broadcastEntityEvent(goat, 58 or 59)`, sent when it
// changes what the goat does.
lower_head :: proc(m: ^Mob, events: ^[dynamic]MobEvent, lower: bool) {
}
    // rust: if m.extra.goat.lowering_head != lower {
    // rust: let event: i8 = if lower { 58 } else { 59 };
    // rust: entity_event(m, event as u8);
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: events.push(MobEvent::EntityEvent {
    // rust: mob: m.id,
    // rust: event,
    // rust: at,
    // rust: });
}
}
between :: proc(m: ^Mob) {
}
    // rust: m.random.next_int_between_inclusive(min, max).unwrap_or(min)
}
rams :: proc(m: ^Mob) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: if m.extra.screaming {
    // rust: RAMS_SCREAMER
    // rust: } else {
    // rust: RAMS
}
}
block_of :: proc(p: Vec3) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [p.x.floor() as i32, p.y.floor() as i32, p.z.floor() as i32]
}
play :: proc(m: ^Mob, events: ^[dynamic]MobEvent, sound: ^'static str, pitch: f32) {
}
    // PrepareRamNearestTarget / RamTarget use the level overload even when
    // Silent is set; the receiving client's bound instance checks silence.
    // rust: events.push(MobEvent::entity_sound(m, sound, 6, 1.0, pitch));
}

// `PrepareRamNearestTarget.isWalkableBlock`.
walkable :: proc(m: ^Mob, w: ^MobWorld, p: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.stable_destination(w, p) && m.malus(w.path_type_static(p[0], p[1], p[2])) == 0.0
}
// `PrepareRamNearestTarget.calculateRammingStartPosition`.
ramming_start :: proc(m: ^Mob, w: ^MobWorld, target: [i32; 3]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if !walkable(m, w, target) {
    // rust: return None;
}
    // Direction.Plane.HORIZONTAL: north, east, south, west.
    // rust: let mut starts = Vec::new();
    // rust: for (dx, dz) in [(0, -1), (1, 0), (0, 1), (-1, 0)] {
    // rust: let mut p = target;
    // rust: for _ in 0..MAX_RAM_DISTANCE {
    // rust: p = [p[0] + dx, p[1], p[2] + dz];
    // rust: if !walkable(m, w, p) {
    // rust: p = [p[0] - dx, p[1], p[2] - dz];
    // rust: break;
}
}
    // rust: let manhattan =
    // rust: (p[0] - target[0]).abs() + (p[1] - target[1]).abs() + (p[2] - target[2]).abs();
    // rust: if manhattan >= MIN_RAM_DISTANCE {
    // rust: starts.push(p);
}
}
    // rust: let here = block_of(m.position);
    // rust: let sqr = |p: &[i32; 3]| {
    // rust: (0..3)
    // rust: .map(|i| i64::from(p[i] - here[i]).pow(2))
    // rust: .sum::<i64>()
}
    // rust: starts.sort_by_key(sqr);
    // rust: starts
    // rust: .into_iter()
    // rust: .find(|&p| m.create_path_to(w, p, 0).is_some_and(|path| path.reached))
}
// `PrepareRamNearestTarget.chooseRamPosition`.
choose :: proc(m: ^Mob, w: ^MobWorld, target: Who) {
}
    // rust: let g = &mut m.extra.goat;
    // rust: g.reached_at = None;
    // rust: let Some(t) = w.target_info(target) else {
    // rust: g.candidate = None;
    // rust: return;
}
    // rust: let target_pos = block_of(t.position);
    // rust: m.extra.goat.candidate = ramming_start(m, w, target_pos).map(|start| Candidate {
    // rust: start,
    // rust: target_pos,
    // rust: target,
    // rust: });
}
// The nearest living thing the goat sees that `RAM_TARGET_CONDITIONS`
// allow: not a goat, a player who is not creative or a spectator.
nearest_target :: proc(m: ^Mob, w: ^MobWorld) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut best: Option<(Who, f64)> = None;
    // rust: if let Some(p) = &w.player
    // rust: && p.alive
    // rust: && !p.creative
    // rust: && !p.spectator
    // rust: && !p.allies.contains(&m.id)
    // rust: && m.distance_sqr(p.position) <= SENSE_RANGE * SENSE_RANGE
    // rust: && m.sees(w, Who::Player)
    // rust: {
    // rust: best = Some((Who::Player, m.distance_sqr(p.position)));
}
    // rust: let id = m.id;
    // rust: let mobs: Vec<(u32, f64)> = w
    // rust: .nearby(m.position, SENSE_RANGE, |s| {
    // rust: s.id != id && s.species != super::Species::Goat && !s.playing_dead
    // rust: })
    // rust: .map(|s| (s.id, m.distance_sqr(s.position)))
    // rust: .collect();
    // rust: for (mob, d) in mobs {
    // rust: if best.is_none_or(|b| d < b.1) && m.sees(w, Who::Mob(mob)) {
    // rust: best = Some((Who::Mob(mob), d));
}
}
    // rust: best.map(|b| b.0)
}

// `PrepareRamNearestTarget` and `RamTarget` of the ram activity.
Ram :: struct {
    // rust: impl Goal for Ram {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE | LOOK
}
can_use :: proc(self: ^Self, m: ^Mob, _cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
        // The ram activity needs the cooldown to be over (it also waits for
        // no tempting player and no breed target, which goats lack here).
    // rust: ram_cooldown(m) <= 0
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let g = &m.extra.goat;
    // rust: match g.phase {
    // rust: Phase::Done => false,
    // rust: Phase::Prepare => {
    // rust: g.time <= PREPARE_TIME_OUT
    // rust: && g.candidate
    // rust: .is_some_and(|c| cx.w.target_info(c.target).is_some_and(|t| t.alive))
}
    // rust: Phase::RamStart | Phase::Ram => g.ram_target.is_some() && g.time <= RAM_TIME_OUT,
}
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: m.extra.goat.phase = Phase::Prepare;
    // rust: m.extra.goat.time = 0;
    // rust: m.extra.goat.reached_at = None;
    // rust: m.extra.goat.candidate = None;
    // rust: if let Some(target) = nearest_target(m, cx.w) {
    // rust: choose(m, cx.w, target);
}
}
stop :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: match m.extra.goat.phase {
            // PrepareRamNearestTarget.stop: no ram target, so the head comes
            // up and the cooldown starts.
    // rust: Phase::Prepare => {
    // rust: lower_head(m, cx.events, false);
    // rust: let wait = rams(m).0;
    // rust: set_ram_cooldown(m, wait);
}
            // RamTarget.finishRam (also what its timeout leaves undone).
    // rust: Phase::RamStart | Phase::Ram => finish_ram(m, cx.events),
    // rust: Phase::Done => {}
}
    // rust: m.extra.goat.phase = Phase::Done;
    // rust: m.extra.goat.candidate = None;
}
every_tick :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: m.extra.goat.time += 1;
    // rust: match m.extra.goat.phase {
    // rust: Phase::Prepare => prepare_tick(m, cx),
    // rust: Phase::RamStart => {
                // RamTarget.start: charge from here at the ram target.
    // rust: let (Some(target), here) = (m.extra.goat.ram_target, block_of(m.position)) else {
    // rust: return;
}
    // rust: let d = Vec3::new(
    // rust: f64::from(here[0]) - target.x,
    // rust: 0.0,
    // rust: f64::from(here[2]) - target.z,
    // rust: );
    // rust: m.extra.goat.ram_direction = d.normalize();
    // rust: m.extra.goat.phase = Phase::Ram;
    // rust: m.extra.goat.time = 0;
    // rust: m.nav_move_to_entity(cx.w, [target.x, target.y, target.z], 0, 3.0);
    // rust: ram_tick(m, cx);
}
    // rust: Phase::Ram => ram_tick(m, cx),
    // rust: Phase::Done => {}
}
}
}
// `PrepareRamNearestTarget.tick`.
prepare_tick :: proc(m: ^Mob, cx: ^Cx) {
}
    // rust: let Some(c) = m.extra.goat.candidate else {
    // rust: return;
}
    // rust: let Some(t) = cx.w.target_info(c.target) else {
    // rust: return;
}
    // rust: m.look_at([t.position.x, t.eye_y, t.position.z]);
    // rust: let now = m.age as i32;
    // rust: let at = [
    // rust: f64::from(c.start[0]) + 0.5,
    // rust: f64::from(c.start[1]),
    // rust: f64::from(c.start[2]) + 0.5,
    // rust: ];
    // rust: if m.ai.nav.is_done() && block_of(m.position) != c.start {
    // rust: m.nav_move_to_entity(cx.w, at, 0, 1.25);
}
    // rust: if block_of(t.position) != c.target_pos {
        // The target moved: the head comes up and a new spot is chosen.
    // rust: lower_head(m, cx.events, false);
    // rust: m.nav_stop();
    // rust: choose(m, cx.w, c.target);
    // rust: } else if block_of(m.position) == c.start {
    // rust: lower_head(m, cx.events, true);
    // rust: let since = *m.extra.goat.reached_at.get_or_insert(now);
    // rust: if i64::from(now - since) >= RAM_PREPARE_TIME {
            // getEdgeOfBlock.
    // rust: let (x, z) = (
    // rust: f64::from(c.target_pos[0])
    // rust: + 0.5
    // rust: + 0.5 * f64::from(sign(c.target_pos[0] - c.start[0])),
    // rust: f64::from(c.target_pos[2])
    // rust: + 0.5
    // rust: + 0.5 * f64::from(sign(c.target_pos[2] - c.start[2])),
    // rust: );
    // rust: m.extra.goat.ram_target = Some(Vec3::new(x, f64::from(c.target_pos[1]), z));
    // rust: let sound = if m.extra.screaming {
    // rust: "entity.goat.screaming.prepare_ram"
    // rust: } else {
    // rust: "entity.goat.prepare_ram"
}
    // rust: let pitch = m.voice_pitch();
    // rust: play(m, cx.events, sound, pitch);
    // rust: m.extra.goat.candidate = None;
    // rust: m.extra.goat.phase = Phase::RamStart;
}
}
}
sign :: proc(v: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: v.signum()
}
// `RamTarget.tick`.
ram_tick :: proc(m: ^Mob, cx: ^Cx) {
}
    // rust: let impact = if m.extra.screaming {
    // rust: "entity.goat.screaming.ram_impact"
    // rust: } else {
    // rust: "entity.goat.ram_impact"
}
    // rust: let from = [m.position.x, m.position.y, m.position.z];
    // rust: if let Some(target) = rammed(m, cx.w) {
        // hurtServer by `noAggroMobAttack`, then the knockback.
    // rust: let amount = m.attrs.attack_damage;
    // rust: match target {
    // rust: Who::Player => cx.events.push(MobEvent::DamagePlayer {
    // rust: amount,
    // rust: from,
    // rust: kind: "minecraft:mob_attack_no_aggro",
    // rust: }),
    // rust: Who::Mob(id) => cx.events.push(MobEvent::AttackMob {
    // rust: target: id,
    // rust: amount,
    // rust: source: Damage::mob(m.id, from),
    // rust: }),
}
    // rust: let level = |effect: &str| {
    // rust: m.extra
    // rust: .effects
    // rust: .iter()
    // rust: .find(|e| e.0 == effect)
    // rust: .map_or(0, |e| e.2 + 1)
}
    // rust: let boost = 0.25 * (level("minecraft:speed") - level("minecraft:slowness")) as f32;
    // rust: let factor = (m.ai.speed * 1.65).clamp(0.2, 3.0) + boost;
    // rust: let force = if m.is_baby() { 1.0 } else { 2.5 };
    // rust: let d = m.extra.goat.ram_direction;
        // The knockback's source is `mobAttack`, not the hurt's `noAggroMobAttack`.
    // rust: cx.events.push(MobEvent::Knockback {
    // rust: target,
    // rust: power: f64::from(factor * force),
    // rust: x: d.x,
    // rust: z: d.z,
    // rust: source: Damage::mob(m.id, from),
    // rust: });
    // rust: finish_ram(m, cx.events);
    // rust: play(m, cx.events, impact, 1.0);
    // rust: } else if rammed_horn_block(m, cx.w) {
    // rust: play(m, cx.events, impact, 1.0);
    // rust: if drop_horn(m, cx.events) {
    // rust: play(m, cx.events, "entity.goat.horn_break", 1.0);
}
    // rust: finish_ram(m, cx.events);
    // rust: } else if m.ai.nav.is_done() || m.extra.goat.ram_target.is_none() {
        // The walk target is gone: the charge ended where it could.
    // rust: finish_ram(m, cx.events);
}
}
// The first living thing in the goat's box that `RAM_TARGET_CONDITIONS`
// allow.
rammed :: proc(m: ^Mob, w: ^MobWorld) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let bounds = m.bounds();
    // rust: if let Some(p) = &w.player
    // rust: && p.alive
    // rust: && !p.creative
    // rust: && !p.spectator
    // rust: && !p.allies.contains(&m.id)
    // rust: && p.bounds.intersects(bounds)
    // rust: {
    // rust: return Some(Who::Player);
}
    // rust: w.others_near(bounds)
    // rust: .find(|s| {
    // rust: s.id != m.id
    // rust: && s.alive
    // rust: && s.species != super::Species::Goat
    // rust: && !s.playing_dead
    // rust: && s.bounds.intersects(bounds)
    // rust: })
    // rust: .map(|s| Who::Mob(s.id))
}
// `RamTarget.hasRammedHornBreakingBlock`: the block one step ahead, or the
// one above it, snaps a horn.
rammed_horn_block :: proc(m: ^Mob, w: ^MobWorld) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let ahead = Vec3::new(m.velocity.x, 0.0, m.velocity.z).normalize();
    // rust: let at = block_of(m.position.add_vector(ahead));
    // rust: let snaps =
    // rust: |p: [i32; 3]| w.has_tag("minecraft:snaps_goat_horn", w.block_name(p[0], p[1], p[2]));
    // rust: snaps(at) || snaps([at[0], at[1] + 1, at[2]])
}
// `Goat.dropHorn`: one of the horns it still has comes off and drops.
drop_horn :: proc(m: ^Mob, events: ^[dynamic]MobEvent) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if m.is_baby() {
    // rust: return false;
}
    // rust: let [left_lost, right_lost] = m.extra.lost_horns;
    // rust: if left_lost && right_lost {
    // rust: return false;
}
    // rust: let lose_left = if left_lost {
    // rust: false
    // rust: } else if right_lost {
    // rust: true
    // rust: } else {
    // rust: m.random.next_boolean()
}
    // rust: m.extra.lost_horns[usize::from(!lose_left)] = true;
    // `Mth.randomBetween(this.random, ..)` for the push, drawn after createHorn.
    // rust: let mut between = |min: f32, max: f32| f64::from(m.random.next_float() * (max - min) + min);
    // rust: let motion = [between(-0.2, 0.2), between(0.3, 0.7), between(-0.2, 0.2)];
    // rust: events.push(MobEvent::DropGoatHorn {
    // rust: mob: m.id,
    // rust: screaming: m.extra.screaming,
    // rust: at: [m.position.x, m.position.y, m.position.z],
    // rust: motion,
    // rust: });
    // rust: true
}
// `Goat.createHorn`: the instrument is a random pick (by a random seeded
// with the goat's UUID hash) from `#regular_goat_horns` or, for a screaming
// goat, `#screaming_goat_horns`.
create_horn :: proc(uuid: [i32; 4], screaming: bool) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: const REGULAR: [&str; 4] = [
    // rust: "minecraft:ponder_goat_horn",
    // rust: "minecraft:sing_goat_horn",
    // rust: "minecraft:seek_goat_horn",
    // rust: "minecraft:feel_goat_horn",
    // rust: ];
    // rust: const SCREAMING: [&str; 4] = [
    // rust: "minecraft:admire_goat_horn",
    // rust: "minecraft:call_goat_horn",
    // rust: "minecraft:yearn_goat_horn",
    // rust: "minecraft:dream_goat_horn",
    // rust: ];
    // The UUID's Java hash code: the two halves xored, then folded to an int.
    // rust: let [a, b, c, d] = uuid;
    // rust: let mut random = horizon_core::random::LegacyRandom::new(i64::from(a ^ b ^ c ^ d));
    // rust: let list = if screaming { SCREAMING } else { REGULAR };
    // rust: list[random.next_int_bound(list.len() as i32).unwrap_or(0) as usize]
}
// `RamTarget.finishRam`.
finish_ram :: proc(m: ^Mob, events: ^[dynamic]MobEvent) {
}
    // rust: lower_head(m, events, false);
    // rust: let wait = rams(m);
    // rust: let cooldown = between(m, wait);
    // rust: set_ram_cooldown(m, cooldown);
    // rust: m.extra.goat.ram_target = None;
    // rust: m.extra.goat.phase = Phase::Done;
}

    // rust: mod sound_tests {
//     use super::*;

ram_sound_keeps_a_silent_emitters_identity_and_does_not_draw_its_random :: proc() {
}
    // rust: let mut kind = crate::mobs::sensor_scan_tests::kind();
    // rust: let k = std::sync::Arc::make_mut(&mut kind);
    // rust: k.id = "minecraft:goat".into();
    // rust: k.species = super::super::Species::Goat;
    // rust: let mut goat = Mob::new(37, kind, Vec3::new(0.123456789, 64.0, -3.25), 0.0);
    // rust: goat.silent = true;
    // rust: let mut expected = goat.random.clone();
    // rust: let mut events = Vec::new();
    // rust: play(&goat, &mut events, "entity.goat.ram_impact", 1.0);
    // rust: let [
    // rust: MobEvent::EntitySound {
    // rust: mob,
    // rust: name,
    // rust: at,
    // rust: source,
    // rust: volume,
    // rust: pitch,
    // rust: },
    // rust: ] = &events[..]
    // rust: else {
    // rust: panic!("the level sound must survive Silent and retain its emitter");
}
    // rust: assert_eq!((*mob, *name, *source), (37, "entity.goat.ram_impact", 6));
    // rust: assert_eq!(*at, [0.123456789, 64.0, -3.25]);
    // rust: assert_eq!((*volume, *pitch), (1.0, 1.0));
    // rust: assert_eq!(goat.random.next_long(), expected.next_long());
}
}
