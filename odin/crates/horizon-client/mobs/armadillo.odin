//! Transpiled from Horizon Rust crate
package horizon_client_armadillo

import "core:fmt"
import "core:mem"
import "core:math"

// Armadillos (`Armadillo`, `ArmadilloAi`): a player who sprints or rides
// nearby, an undead mob or the last attacker scares one into a ball (IDLE,
// ROLLING, SCARED, UNROLLING); it peeks out now and then, and a ball takes
// less damage. The brain's `ARMADILLO_SCARE_DETECTED` sensor, its
// `DANGER_DETECTED_RECENTLY` memory and the `ArmadilloBallUp` behaviour are
// kept in `State`; the walking behaviours are the goals of `register`.
// AnimState states: roll out, roll up, peek.
// use super::{
    // rust: Damage, DamageKind, Mob, MobEvent, MobWorld, Species, Who,
    // rust: goals::{
    // rust: Breed, Cx, Float, Goal, LOOK, LookAtPlayer, MOVE, Panic, RandomLookAround, Stroll, Tempt,
    // rust: goal_clone,
    // rust: },
}
// use horizon_core::{
    // rust: geometry::{Aabb, Vec3},
    // rust: random::RandomSource,
}

IDLE :: 0
ROLLING :: 1
SCARED :: 2
UNROLLING :: 3

ROLL_OUT :: 0
ROLL_UP :: 1
PEEK :: 2

// `ArmadilloState.animationDuration`.
animation_duration :: proc(state: u8) -> i {
    // Ported from Horizon
    return {}
}
    // rust: match state {
    // rust: ROLLING => 10,
    // rust: SCARED => 50,
    // rust: UNROLLING => 30,
    // rust: _ => 0,
}
}

// `Armadillo.ARMADILLO_STATE` and the brain's memory and behaviour.
State :: struct {
    state: u8,
    // `inStateTicks`.
    in_state_ticks: i32,
    // `DANGER_DETECTED_RECENTLY`: ticks to live, 0 when absent.
    danger: i32,
    // Ticks to the sensor's next scan.
    sensor: i32,
    // `ArmadilloBallUp`: running, its peek timer and whether it saw the
    // danger around last tick.
    ball_up: bool,
    next_peek: i32,
    danger_was_around: bool,
    // Whether the PANIC activity was the active one after the last tick.
    panic_activity: bool,
    // `peekReceivedClient`.
    peek_received: bool,
}

register :: proc(m: ^Mob) {
}
    // rust: let mut panic = Panic::new(2.0);
    // rust: panic.environmental = true;
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(0, Float);
    // rust: g.add(1, ArmadilloPanic(panic));
    // rust: g.add(2, Rolled);
    // ArmadilloAi.initIdleActivity: AnimalMakeLove(1.0), then RunOne of
    // FollowTemptation(1.25, armadillo_food) and BabyFollowAdult(5..16, 1.25).
    // rust: g.add(3, Idle(Breed::new(1.0)));
    // rust: let tempt = Tempt::new(1.25, m.kind.food.clone(), false);
    // rust: g.add(4, Idle(ArmadilloTempt(tempt)));
    // rust: g.add(4, Idle(BabyFollowAdult::default()));
    // rust: g.add(5, Stroll::avoiding_water(1.0));
    // rust: g.add(6, LookAtPlayer::new(6.0));
    // rust: g.add(7, RandomLookAround::default());
}

// `AdultSensor` and `BabyFollowAdult.create(5..16, 1.25)`: a baby with no walk
// target walks towards the nearest adult of its kind in sight that is 5 to 17
// blocks away, until it is within 4.
BabyFollowAdult :: struct {
    adult: Maybe(u32),
}
// `UniformInt.of(5, 16)`'s bounds and `speedModifier`.
FOLLOW_MIN :: 5.0
FOLLOW_MAX :: 16.0
FOLLOW_SPEED :: 1.25
    // rust: impl BabyFollowAdult {
    // `NearestVisibleLivingEntities.findClosest(same type and not a baby)`.
nearest_adult :: proc(m: ^Mob, cx: ^Cx) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let species = m.species();
    // rust: let p = m.position;
    // rust: let area = Aabb::new(
    // rust: Vec3::new(p.x - FOLLOW_MAX, p.y - FOLLOW_MAX, p.z - FOLLOW_MAX),
    // rust: Vec3::new(p.x + FOLLOW_MAX, p.y + FOLLOW_MAX, p.z + FOLLOW_MAX),
    // rust: );
    // rust: let ids: Vec<(u32, f64)> =
    // rust: cx.w.others_near(area)
    // rust: .filter(|s| s.alive && !s.baby && s.species == species)
    // rust: .map(|s| (s.id, m.distance_sqr(s.position)))
    // rust: .collect();
    // rust: let mut best: Option<(u32, f64)> = None;
    // rust: for (id, d) in ids {
    // rust: if best.is_none_or(|b| d < b.1) && m.sees(cx.w, Who::Mob(id)) {
    // rust: best = Some((id, d));
}
}
    // rust: best.map(|b| b.0)
}
target :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let s = cx.w.seen(self.adult?)?;
    // rust: Some((
    // rust: [s.position.x, s.position.y, s.position.z],
    // rust: m.distance_sqr(s.position),
    // rust: ))
}
}
    // rust: impl Goal for BabyFollowAdult {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE | LOOK
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if !m.is_baby() || !m.ai.nav.is_done() {
    // rust: return false;
}
    // rust: self.adult = Self::nearest_adult(m, cx);
    // rust: self.target(m, cx).is_some_and(|(_, d)| {
    // rust: (FOLLOW_MIN * FOLLOW_MIN..(FOLLOW_MAX + 1.0) * (FOLLOW_MAX + 1.0)).contains(&d)
    // rust: })
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.is_baby()
    // rust: && !m.ai.nav.is_done()
    // rust: && self
    // rust: .target(m, cx)
    // rust: .is_some_and(|(_, d)| d > (FOLLOW_MIN - 1.0) * (FOLLOW_MIN - 1.0))
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: if let Some((at, _)) = self.target(m, cx) {
    // rust: m.nav_move_to_entity(cx.w, at, FOLLOW_MIN as i32 - 1, FOLLOW_SPEED);
}
}
stop :: proc(self: ^Self, m: ^Mob, _cx: ^Cx) {
}
    // rust: m.nav_stop();
    // rust: self.adult = None;
}
every_tick :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: if let Some(s) = self.adult.and_then(|a| cx.w.seen(a)) {
    // rust: m.look_at([s.position.x, s.eye_y, s.position.z]);
}
}
}

// `Armadillo.isScared`.
scared :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.armadillo.state != IDLE
}
// `Armadillo.mobInteract` on a client: a rolled-up armadillo returns FAIL
// before `Animal.mobInteract`, so its food does not consume the click. A
// brush still goes on to `brushOffScute`.
client_rejects_food :: proc(m: ^Mob, item: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: scared(m) && item != "minecraft:brush"
}
// `ArmadilloState.shouldHideInShell`: the model shows its shell.
hiding_in_shell :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let a = &m.extra.armadillo;
    // rust: match a.state {
    // rust: ROLLING => a.in_state_ticks > 5,
    // rust: SCARED => true,
    // rust: UNROLLING => a.in_state_ticks < 26,
    // rust: _ => false,
}
}
// `Armadillo.getState`, as it is synched.
state :: proc(m: ^Mob) -> u {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.armadillo.state
}
// `Armadillo.switchToState` and `onSyncedDataUpdated(ARMADILLO_STATE)`.
set_state :: proc(m: ^Mob, state: u8) {
}
    // rust: let a = &mut m.extra.armadillo;
    // rust: if a.state != state {
    // rust: a.state = state;
    // rust: a.in_state_ticks = 0;
}
}
// `Armadillo.canStayRolledUp`.
can_stay_rolled_up :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !m.ai.panicking
    // rust: && !m.fluids.in_water
    // rust: && !m.fluids.in_lava
    // rust: && m.extra.leash.is_none()
    // rust: && m.extra.mount.is_none()
    // rust: && m.extra.rider.is_none()
}
// `Entity.playSound(sound)`.
play :: proc(m: ^Mob, events: ^[dynamic]MobEvent, sound: ^'static str) {
}
    // rust: if !m.silent {
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: events.push(MobEvent::Sound(sound, at, 1.0, 1.0));
}
}
// `Entity.gameEvent(GameEvent.ENTITY_ACTION)` at the armadillo, silent or not.
entity_action :: proc(m: ^Mob, events: ^[dynamic]MobEvent) {
}
    // rust: events.push(MobEvent::GameEvent {
    // rust: event: "minecraft:entity_action",
    // rust: at: [m.position.x, m.position.y, m.position.z],
    // rust: source: m.id,
    // rust: state: horizon_world::registry::BlockStateId(0),
    // rust: });
}
// `Armadillo.rollUp`.
roll_up :: proc(m: ^Mob, events: ^[dynamic]MobEvent) {
}
    // rust: if !scared(m) {
    // rust: super::creaking::stop_in_place(m);
    // rust: m.extra.in_love = 0;
    // rust: entity_action(m, events);
    // rust: if !m.silent {
    // rust: m.voice("entity.armadillo.roll", events);
}
    // rust: set_state(m, ROLLING);
}
}
// `Armadillo.rollOut`.
roll_out :: proc(m: ^Mob, events: ^[dynamic]MobEvent) {
}
    // rust: if scared(m) {
    // rust: entity_action(m, events);
    // rust: if !m.silent {
    // rust: m.voice("entity.armadillo.unroll_finish", events);
}
    // rust: set_state(m, IDLE);
}
}

// `Armadillo.hurtServer`: a ball takes half of the damage past the first
// point (below it a negative amount, which `LivingEntity.hurtServer` makes 0).
reduce_damage :: proc(m: ^Mob, amount: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if scared(m) {
    // rust: (amount - 1.0) / 2.0
    // rust: } else {
    // rust: amount
}
}
// `Armadillo.actuallyHurt`: a hit by a living thing curls it up (and keeps
// the danger in mind for 80 ticks), a hit by fire and the like unrolls it.
after_hurt :: proc(m: ^Mob, source: ^Damage) {
}
    // rust: if m.no_ai || m.health <= 0.0 {
    // rust: return;
}
    // rust: let mut events = Vec::new();
    // rust: if source.attacker.is_some() {
    // rust: m.extra.armadillo.danger = 80;
    // rust: if can_stay_rolled_up(m) {
    // rust: roll_up(m, &mut events);
}
    // rust: } else if environmental(source.kind) {
    // rust: roll_out(m, &mut events);
}
    // rust: m.outbox.append(&mut events);
}
// `DamageTypeTags.PANIC_ENVIRONMENTAL_CAUSES`.
environmental :: proc(kind: DamageKind) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: kind,
    // rust: DamageKind::Cactus
    // rust: | DamageKind::OnFire
    // rust: | DamageKind::InFire
    // rust: | DamageKind::Lava
    // rust: | DamageKind::LightningBolt
    // rust: | DamageKind::HotFloor
    // rust: )
}
// The hurt sound: a ball's is muffled, and it has no ambient sound
// (`getAmbientSound`, `getHurtSound`); empty is none.
sounds :: proc(m: ^Mob) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let [ambient, hurt, death] = m.kind.sounds;
    // rust: if scared(m) {
    // rust: ["", "entity.armadillo.hurt_reduced", death]
    // rust: } else {
    // rust: [ambient, hurt, death]
}
}

// `EntityTypeTags.UNDEAD`.
undead :: proc(s: Species) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: s,
    // rust: Species::Skeleton
    // rust: | Species::Stray
    // rust: | Species::WitherSkeleton
    // rust: | Species::SkeletonHorse
    // rust: | Species::Bogged
    // rust: | Species::Parched
    // rust: | Species::ZombieHorse
    // rust: | Species::CamelHusk
    // rust: | Species::Zombie
    // rust: | Species::ZombieVillager
    // rust: | Species::ZombifiedPiglin
    // rust: | Species::Zoglin
    // rust: | Species::Drowned
    // rust: | Species::Husk
    // rust: | Species::ZombieNautilus
    // rust: | Species::Wither
    // rust: | Species::Phantom
    // rust: )
}
// `Armadillo.isScaredBy` for the nearby living entities: within 7 blocks
// sideways and 2 up and down, an undead mob, the last attacker, or a
// player who sprints or rides.
scared_by_someone :: proc(m: ^Mob, w: ^MobWorld) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let area = m.bounds().inflate(Vec3::new(7.0, 2.0, 7.0));
    // rust: let attacker =
    // rust: m.ai.last_hurt_by
    // rust: .filter(|_| m.age as i32 - m.ai.last_hurt_by_time <= 100);
    // rust: if let Some(p) = &w.player
    // rust: && p.alive
    // rust: && !p.spectator
    // rust: && p.bounds.intersects(area)
    // rust: && (attacker == Some(Who::Player) || p.sprinting || p.riding)
    // rust: {
    // rust: return true;
}
    // rust: w.others_near(area).any(|s| {
    // rust: s.id != m.id
    // rust: && s.alive
    // rust: && s.bounds.intersects(area)
    // rust: && (undead(s.species) || attacker == Some(Who::Mob(s.id)))
    // rust: })
}

// `Armadillo.customServerAiStep`'s brain: memories expire, the scare
// sensor scans every fifth tick, the core's rolling out, then the
// `ArmadilloBallUp` behaviour of the PANIC activity.
server_ai_step :: proc(m: ^Mob, cx: ^Cx) {
}
    // rust: let events = &mut *cx.events;
    // rust: let a = &mut m.extra.armadillo;
    // rust: if a.danger > 0 {
    // rust: a.danger -= 1;
}
    // rust: a.sensor -= 1;
    // rust: if a.sensor <= 0 {
    // rust: a.sensor = 5;
    // rust: if !can_stay_rolled_up(m) {
    // rust: m.extra.armadillo.danger = 0;
    // rust: } else if scared_by_someone(m, cx.w) {
    // rust: m.extra.armadillo.danger = 80;
}
}
    // ARMADILLO_ROLLING_OUT: no danger left in mind.
    // rust: if m.extra.armadillo.danger == 0 && scared(m) {
    // rust: roll_out(m, events);
}
    // rust: if m.extra.armadillo.panic_activity && !m.extra.armadillo.ball_up && m.on_ground && !liquid(m) {
        // ArmadilloBallUp.start.
    // rust: m.extra.armadillo.ball_up = true;
    // rust: roll_up(m, events);
}
    // rust: if m.extra.armadillo.ball_up {
    // rust: ball_up_tick(m, events);
}
    // rust: let a = &mut m.extra.armadillo;
    // rust: a.panic_activity = a.danger > 0 && !m.ai.panicking;
}
liquid :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.fluids.in_water || m.fluids.in_lava
}
// `ArmadilloBallUp.tickOrStop`.
ball_up_tick :: proc(m: ^Mob, events: ^[dynamic]MobEvent) {
}
    // rust: if !scared(m) {
        // canStillUse is false: stop.
    // rust: m.extra.armadillo.ball_up = false;
    // rust: if !can_stay_rolled_up(m) {
    // rust: roll_out(m, events);
}
    // rust: return;
}
    // rust: let a = &mut m.extra.armadillo;
    // rust: if a.next_peek > 0 {
    // rust: a.next_peek -= 1;
}
    // rust: if a.state == ROLLING && a.in_state_ticks > animation_duration(ROLLING) {
    // rust: set_state(m, SCARED);
    // rust: if m.on_ground {
    // rust: play(m, events, "entity.armadillo.land");
}
    // rust: return;
}
    // rust: let danger = m.extra.armadillo.danger;
    // rust: let around = danger > 75;
    // rust: if around != m.extra.armadillo.danger_was_around {
    // rust: m.extra.armadillo.next_peek = next_peek_timer(m);
}
    // rust: m.extra.armadillo.danger_was_around = around;
    // rust: let state = m.extra.armadillo.state;
    // rust: if state == SCARED {
    // rust: if m.extra.armadillo.next_peek == 0 && m.on_ground && around {
    // rust: peek(m, events);
    // rust: m.extra.armadillo.next_peek = next_peek_timer(m);
}
    // rust: if danger < animation_duration(UNROLLING) {
    // rust: play(m, events, "entity.armadillo.unroll_start");
    // rust: set_state(m, UNROLLING);
}
    // rust: } else if state == UNROLLING && danger > animation_duration(UNROLLING) {
    // rust: set_state(m, SCARED);
}
}
// `ArmadilloBallUp.pickNextPeekTimer`.
next_peek_timer :: proc(m: ^Mob) -> i {
    // Ported from Horizon
    return {}
}
    // rust: animation_duration(SCARED) + m.random.next_int_between_inclusive(100, 400).unwrap_or(100)
}
// `level.broadcastEntityEvent(body, 64)`; the sound is the client's
// `playLocalSound`, which the server plays for everyone here.
peek :: proc(m: ^Mob, events: ^[dynamic]MobEvent) {
}
    // rust: entity_event(m, 64);
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: events.push(MobEvent::EntityEvent {
    // rust: mob: m.id,
    // rust: event: 64,
    // rust: at,
    // rust: });
    // rust: events.push(MobEvent::Sound("entity.armadillo.peek", at, 1.0, 1.0));
}
// `Armadillo.handleEntityEvent`: 64 is a peek.
entity_event :: proc(m: ^Mob, event: u8) {
}
    // rust: if event == 64 {
    // rust: m.extra.armadillo.peek_received = true;
}
}

// `Armadillo.tick`: the animation states on a client, the ball's head held
// to its body, and `inStateTicks`. Server and client both run it.
tick :: proc(m: ^Mob) {
}
    // rust: animate(m);
    // rust: if scared(m) {
        // clampHeadRotationToBody with getMaxHeadYRot 0.
    // rust: m.head_yaw += super::living::wrap(m.body_yaw - m.head_yaw);
}
    // rust: m.extra.armadillo.in_state_ticks += 1;
}
// `Armadillo.setupAnimationStates`.
animate :: proc(m: ^Mob) {
}
    // rust: let age = m.age as f32;
    // rust: let a = &mut m.extra.armadillo;
    // rust: let s = &mut m.anim.states;
    // rust: match a.state {
    // rust: ROLLING => {
    // rust: s[ROLL_OUT].stop();
    // rust: s[ROLL_UP].start_if_stopped(age);
    // rust: s[PEEK].stop();
}
    // rust: SCARED => {
    // rust: s[ROLL_OUT].stop();
    // rust: s[ROLL_UP].stop();
    // rust: if a.peek_received {
    // rust: s[PEEK].stop();
    // rust: a.peek_received = false;
}
    // rust: if a.in_state_ticks == 0 {
    // rust: s[PEEK].start(age);
    // rust: s[PEEK].fast_forward(animation_duration(SCARED));
    // rust: } else {
    // rust: s[PEEK].start_if_stopped(age);
}
}
    // rust: UNROLLING => {
    // rust: s[ROLL_OUT].start_if_stopped(age);
    // rust: s[ROLL_UP].stop();
    // rust: s[PEEK].stop();
}
    // rust: _ => {
    // rust: s[ROLL_OUT].stop();
    // rust: s[ROLL_UP].stop();
    // rust: s[PEEK].stop();
}
}
}

// `ArmadilloAi.ArmadilloPanic`: it unrolls, then runs.
ArmadilloPanic :: struct {
    // rust: impl Goal for ArmadilloPanic {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.0.flags()
}
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: "Panic"
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.0.can_use(m, cx)
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.0.can_continue(m, cx)
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: roll_out(m, cx.events);
    // rust: self.0.start(m, cx);
}
stop :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.0.stop(m, cx);
}
}
// A behaviour of the IDLE activity: `ArmadilloAi.updateActivity` picks
// PANIC over it while danger is in mind and it is not panicking, and a
// ball does not walk (`ArmadilloAi$1`, its `MoveToTargetSink`).
Idle :: struct {
idle :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !scared(m) && !m.extra.armadillo.panic_activity
}
    // rust: impl<G: Goal + Clone + 'static> Goal for Idle<G> {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.0.flags()
}
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.0.name()
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: idle(m) && self.0.can_use(m, cx)
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: idle(m) && self.0.can_continue(m, cx)
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.0.start(m, cx);
}
stop :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.0.stop(m, cx);
}
every_tick :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.0.every_tick()
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.0.tick(m, cx);
}
}
// `FollowTemptation` with `ArmadilloAi.initIdleActivity`'s close enough
// distance: 1 block for a baby, 2 for an adult.
ArmadilloTempt :: struct {
    // rust: impl Goal for ArmadilloTempt {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.0.flags()
}
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.0.name()
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.0.can_use(m, cx)
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.0.can_continue(m, cx)
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.0.start(m, cx);
}
stop :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.0.stop(m, cx);
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.0.stop_distance = if m.is_baby() { 1.0 } else { 2.0 };
    // rust: self.0.tick(m, cx);
}
}
// The behaviours that do not run while the armadillo is a ball: its
// `MoveToTargetSink` and the idle activity's walking and looking.
Rolled :: struct {
    // rust: impl Goal for Rolled {
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
    // rust: scared(m)
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::mobs::sensor_scan_tests::kind;
//     use std::sync::Arc;

    // An armadillo on the ground.
armadillo :: proc() -> M {
    // Ported from Horizon
    return {}
}
    // rust: let mut kind = kind();
    // rust: let k = Arc::make_mut(&mut kind);
    // rust: k.id = "minecraft:armadillo".into();
    // rust: k.species = Species::Armadillo;
    // rust: let mut m = Mob::new(1, kind, Vec3::ZERO, 0.0);
    // rust: m.on_ground = true;
    // rust: m
}

    // Spider eyes are armadillo food. Rolled up, the click fails; a brush
    // does not. Idle, food is left to `Animal.mobInteract`.
a_rolled_up_armadillo_refuses_food :: proc() {
}
    // rust: let mut m = armadillo();
    // rust: set_state(&mut m, SCARED);
    // rust: assert!(client_rejects_food(&m, "minecraft:spider_eye"));
    // rust: assert!(!client_rejects_food(&m, "minecraft:brush"));
    // rust: set_state(&mut m, IDLE);
    // rust: assert!(!client_rejects_food(&m, "minecraft:spider_eye"));
}

a_hit_rolls_it_up_into_a_ball :: proc() {
}
        // Armadillo.actuallyHurt: a hit by a living thing curls it up and
        // keeps the danger in mind for 80 ticks, so the model shows the
        // shell instead of the armadillo (#2759).
    // rust: let mut m = armadillo();
    // rust: after_hurt(&mut m, &Damage::player([0.0, 0.0, 0.0]));
    // rust: assert_eq!(state(&m), ROLLING);
        // Armadillo.rollUp: the roll sound.
    // rust: assert!(
    // rust: m.outbox
    // rust: .iter()
    // rust: .any(|e| matches!(e, MobEvent::Sound(s, ..) if *s == "entity.armadillo.roll")),
    // rust: "the roll plays its sound"
    // rust: );
        // ArmadilloState.shouldHideInShell: the shell shows after five ticks.
    // rust: for _ in 0..6 {
    // rust: tick(&mut m);
}
    // rust: assert!(hiding_in_shell(&m), "the model shows the shell");
}

    // Armadillo.rollUp and rollOut post `GameEvent.ENTITY_ACTION` (#8714),
    // silent or not, for the sculk sensors and wardens nearby.
rolling_up_and_out_posts_entity_action :: proc() {
}
    // rust: let action = |events: &[MobEvent]| {
    // rust: events.iter().any(|e| {
    // rust: matches!(e, MobEvent::GameEvent { event, source: 1, .. }
    // rust: if *event == "minecraft:entity_action")
    // rust: })
}
    // rust: let mut m = armadillo();
    // rust: m.silent = true;
    // rust: let mut events = Vec::new();
    // rust: roll_up(&mut m, &mut events);
    // rust: assert_eq!(state(&m), ROLLING);
    // rust: assert!(action(&events), "rolling up posts entity_action");
    // rust: let mut events = Vec::new();
    // rust: roll_out(&mut m, &mut events);
    // rust: assert_eq!(state(&m), IDLE);
    // rust: assert!(action(&events), "rolling out posts entity_action");
        // Neither posts anything when it doesn't change state.
    // rust: let mut events = Vec::new();
    // rust: roll_out(&mut m, &mut events);
    // rust: assert!(!action(&events));
}

    // Runs the goals of `m` for `ticks` ticks; the events.
run_goals :: proc(m: ^Mob, w: ^MobWorld, ticks: u32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut events = Vec::new();
    // rust: let mut goals = std::mem::take(&mut m.ai.goals);
    // rust: let mut lr = horizon_core::random::LegacyRandom::new(0);
    // rust: let mut cx = Cx {
    // rust: w,
    // rust: lr: &mut lr,
    // rust: events: &mut events,
}
    // rust: for _ in 0..ticks {
    // rust: goals.tick(m, &mut cx);
}
    // rust: m.ai.goals = goals;
    // rust: events
}
    // Real armadillos from the vanilla data, with their goals, at these
    // spots; `None` without the data.
    // rust: fn real<const N: usize>(at: [[f64; 3]; N]) -> Option<[Mob; N]> {
    // rust: let mut out = None;
    // rust: crate::mobs::world::with_test_world(&[], |_, types| {
    // rust: let kind = Arc::new(types.types["minecraft:armadillo"].clone());
    // rust: let mut id = 0;
    // rust: out = Some(at.map(|[x, y, z]| {
    // rust: id += 1;
    // rust: let mut m = Mob::new(id, kind.clone(), Vec3::new(x, y, z), 0.0);
    // rust: m.on_ground = true;
    // rust: m
    // rust: }));
    // rust: });
    // rust: out
}

two_armadillos_in_love_make_a_baby :: proc() {
}
        // ArmadilloAi.initIdleActivity: AnimalMakeLove(ARMADILLO, 1.0), so two
        // armadillos fed spider eyes breed (#3512).
    // rust: let Some([mut a, mut b, mut c]) =
    // rust: real([[0.5, 64.0, 0.5], [2.5, 64.0, 0.5], [0.5, 64.0, 1.5]])
    // rust: else {
    // rust: return;
}
    // rust: for m in [&mut a, &mut b, &mut c] {
    // rust: m.extra.in_love = 600;
}
    // rust: let partner = [b.seen(None)];
    // rust: crate::mobs::world::with_test_world(&partner, |w, _| {
    // rust: let events = run_goals(&mut a, w, 80);
    // rust: assert!(
    // rust: events.iter().any(|e| matches!(
    // rust: e,
    // rust: MobEvent::Breed {
    // rust: parent: 1,
    // rust: partner: 2,
    // rust: ..
}
    // rust: )),
    // rust: "the pair breeds"
    // rust: );
    // rust: assert_eq!(a.extra.in_love, 0);
    // rust: assert_eq!(a.extra.age, 6000, "the parent rests");

            // ArmadilloAi.updateActivity: with danger in mind and no panic,
            // PANIC replaces IDLE and its behaviours do not run, nor do a
            // ball's.
    // rust: c.extra.armadillo.panic_activity = true;
    // rust: let events = run_goals(&mut c, w, 80);
    // rust: assert!(!events.iter().any(|e| matches!(e, MobEvent::Breed { .. })));
    // rust: assert!(!c.ai.goals.is_running("Breed"));
    // rust: c.extra.armadillo.panic_activity = false;
    // rust: set_state(&mut c, SCARED);
    // rust: run_goals(&mut c, w, 1);
    // rust: assert!(!c.ai.goals.is_running("Breed"), "a ball does not breed");
    // rust: set_state(&mut c, IDLE);
    // rust: run_goals(&mut c, w, 1);
    // rust: assert!(c.ai.goals.is_running("Breed"), "it looks for its mate");
    // rust: });
}

a_baby_armadillo_follows_an_adult :: proc() {
}
        // BabyFollowAdult(5..16, 1.25) in the idle activity.
    // rust: let Some([mut baby, adult]) = real([[0.5, 64.0, 0.5], [8.5, 64.0, 0.5]]) else {
    // rust: return;
}
    // rust: baby.extra.age = -24000;
    // rust: crate::mobs::world::with_test_world(&[adult.seen(None)], |w, _| {
    // rust: run_goals(&mut baby, w, 1);
    // rust: assert!(baby.ai.goals.is_running("BabyFollowAdult"));
    // rust: set_state(&mut baby, SCARED);
    // rust: run_goals(&mut baby, w, 1);
    // rust: assert!(
    // rust: !baby.ai.goals.is_running("BabyFollowAdult"),
    // rust: "not as a ball"
    // rust: );
    // rust: });
}

a_baby_stays_when_the_adult_is_within_five_blocks :: proc() {
}
        // BabyFollowAdult: `!closerThan(adult, 5)`.
    // rust: let Some([mut baby, adult]) = real([[0.5, 64.0, 0.5], [4.5, 64.0, 0.5]]) else {
    // rust: return;
}
    // rust: baby.extra.age = -24000;
    // rust: crate::mobs::world::with_test_world(&[adult.seen(None)], |w, _| {
    // rust: run_goals(&mut baby, w, 1);
    // rust: assert!(!baby.ai.goals.is_running("BabyFollowAdult"));
    // rust: });
}

a_tempted_baby_comes_closer_than_an_adult :: proc() {
}
        // ArmadilloAi.initIdleActivity: FollowTemptation is close enough at
        // 1 block for a baby and 2 for an adult.
    // rust: let Some([mut baby, mut adult]) = real([[0.5, 64.0, 0.5], [4.5, 64.0, 0.5]]) else {
    // rust: return;
}
    // rust: baby.extra.age = -24000;
    // rust: crate::mobs::world::with_test_world(&[], |w, _| {
    // rust: let mut events = Vec::new();
    // rust: let mut lr = horizon_core::random::LegacyRandom::new(0);
    // rust: let mut cx = Cx {
    // rust: w,
    // rust: lr: &mut lr,
    // rust: events: &mut events,
}
    // rust: let mut tempt = ArmadilloTempt(Tempt::new(1.25, baby.kind.food.clone(), false));
    // rust: tempt.tick(&mut baby, &mut cx);
    // rust: assert_eq!(tempt.0.stop_distance, 1.0);
    // rust: tempt.tick(&mut adult, &mut cx);
    // rust: assert_eq!(tempt.0.stop_distance, 2.0);
    // rust: });
}

campfire_damage_is_fire_and_has_no_knockback_but_does_not_cause_panic :: proc() {
}
        // `campfire` is in #is_fire and #no_knockback, but in neither
        // #panic_causes nor #panic_environmental_causes (#4037).
    // rust: let source = Damage::of(DamageKind::Campfire);
    // rust: assert!(source.is_fire());
    // rust: assert!(source.no_knockback());
    // rust: assert!(!source.causes_panic());
    // rust: assert!(!environmental(DamageKind::Campfire));
}
}
