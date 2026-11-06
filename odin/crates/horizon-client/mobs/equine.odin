//! Transpiled from Horizon Rust crate
package horizon_client_equine

import "core:fmt"
import "core:mem"
import "core:math"

// Horses, donkeys, mules and the undead horses (`AbstractHorse`): random
// stats, coat colours and markings, eating, rearing, taming by riding,
// the ridden movement and jump, offspring stats and `AbstractEquineModel`.
// use super::finalize::{Attr, set_base};
// use super::{
    // rust: Mob, MobEvent, MobWorld, Species,
    // rust: anim::{Poses, State},
    // rust: goals::{
    // rust: Breed, Cx, Float, FollowParent, Goal, LookAtPlayer, MOVE, Panic, RandomLookAround, Stroll,
    // rust: Tempt, goal_clone,
    // rust: },
}
// use horizon_core::geometry::Vec3;
// use horizon_core::geometry::trig::Mth;
// use horizon_core::random::RandomSource;
// use std::f32::consts::PI;

    // rust: pub const COLORS: [&str; 7] = [
    // rust: "white",
    // rust: "creamy",
    // rust: "chestnut",
    // rust: "brown",
    // rust: "black",
    // rust: "gray",
    // rust: "darkbrown",
    // rust: ];
// `Horse.Variant.getSerializedName` in id order (WHITE 0 to DARK_BROWN 6):
// the names a `minecraft:horse/variant` component and the save's `Variant`
// byte carry. [`COLORS`] is the same order, but names the texture
// (`horse_darkbrown`), which drops the underscore.
    // rust: pub const VARIANT_NAMES: [&str; 7] = [
    // rust: "white",
    // rust: "creamy",
    // rust: "chestnut",
    // rust: "brown",
    // rust: "black",
    // rust: "gray",
    // rust: "dark_brown",
    // rust: ];
MARKINGS :: ["", "white", "whitefield", "whitedots", "blackdots"]

// AnimState slots.
EAT :: 0
STAND :: 1
MOUTH :: 2
// `AbstractHorse.tailCounter`: client-side, it only drives the model.
TAIL :: 3

// What a rider asks of its mount this tick.
Rider :: struct {
    strafe: f32,
    forward: f32,
    yaw: f32,
    pitch: f32,
    // `playerJumpPendingScale` from the jump bar.
    jump: f32,
    // Holding the mount's steering stick (pigs, striders).
    steer: bool,
    // Sprinting (camels run faster).
    sprint: bool,
    // Holding the jump key (a happy ghast rises).
    jumping: bool,
    // A server's player whose own client moves the mount
    // (`Entity.isClientAuthoritative`): here it only turns (`tickRidden`).
    client: bool,
}

is_equine :: proc(s: Species) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: s,
    // rust: Species::Horse
    // rust: | Species::Donkey
    // rust: | Species::Mule
    // rust: | Species::SkeletonHorse
    // rust: | Species::ZombieHorse
    // rust: | Species::Camel
    // rust: | Species::CamelHusk
    // rust: | Species::Llama
    // rust: | Species::TraderLlama
    // rust: )
}
// `Entity.canSprint`: false everywhere but the camel (`Camel.canSprint`). A
// rider's `LocalPlayer.isSprintingPossible` asks its vehicle.
can_sprint :: proc(s: Species) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(s, Species::Camel | Species::CamelHusk)
}
// `AbstractHorse.getMaxTemper`: 100, 30 for llamas.
max_temper :: proc(s: Species) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if super::llama::is_llama(s) {
    // rust: super::llama::MAX_TEMPER
    // rust: } else {
    // rust: 100
}
}
// `canPerformRearing`: every `AbstractHorse` but llamas (and camels).
can_rear :: proc(s: Species) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: s,
    // rust: Species::Horse
    // rust: | Species::Donkey
    // rust: | Species::Mule
    // rust: | Species::SkeletonHorse
    // rust: | Species::ZombieHorse
    // rust: )
}
// `AbstractHorse.getPassengerAttachmentPoint`: what it adds to its seat
// before the yaw turns it. A horse up on its hind legs slides its rider back
// and up by the stand animation of the last tick (`standAnimO`), at
// `getAgeScale`. Camels and llamas never rear.
rear_offset :: proc(m: ^Mob) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: if !can_rear(m.species()) {
    // rust: return [0.0; 3];
}
    // rust: let stand = f64::from(m.anim.vo[STAND]);
    // rust: let scale = f64::from(if m.is_baby() { 0.5_f32 } else { 1.0 });
    // rust: [0.0, 0.15 * stand * scale, -0.7 * stand * scale]
}
// `AbstractHorse.isImmobile`: no goals while it eats or rears. A mount its
// rider steers still takes their input (`travelRidden`).
immobile :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: can_rear(m.species()) && (m.extra.flag || m.extra.counter > 0) && !controlled(m)
}
// `AbstractHorse.onElasticLeashPull`: a lead pulled taut ends the horse's
// grazing, and `Camel.onElasticLeashPull` stands a sitting camel up.
on_elastic_leash_pull :: proc(m: ^Mob, w: ^MobWorld, events: ^[dynamic]MobEvent) {
}
    // rust: if grazes(m.species()) {
    // rust: m.extra.flag = false;
}
    // rust: if super::camel::is_camel(m.species()) {
    // rust: super::camel::on_elastic_leash_pull(m, w, events);
}
}
// `AbstractHorse.getJumpSound` (`playJumpSound` plays it at 0.4): the donkey
// and the mule have their own, and a skeleton horse in water splashes.
jump_sound :: proc(m: ^Mob) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match m.species() {
    // rust: Species::Donkey => "entity.donkey.jump",
    // rust: Species::Mule => "entity.mule.jump",
    // rust: Species::SkeletonHorse if m.fluids.in_water => "entity.skeleton_horse.jump_water",
    // rust: _ => "entity.horse.jump",
}
}
// `PlayerRideableJumping.getPlayerJumpPendingScale`: the charge `data` out of
// 100 as the scale a mount leaps or dashes with (a full bar is 1.0 and the
// shortest is 0.4).
jump_pending_scale :: proc(data: i32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if data >= 90 {
    // rust: 1.0
    // rust: } else {
    // rust: 0.4 + 0.4 * data as f32 / 90.0
}
}
// `AbstractHorse.onPlayerJump`: a released jump bar lets the horse slide on
// the rider's keys (`allowStandSliding`) and makes it rear.
on_player_jump :: proc(m: ^Mob) {
}
    // rust: m.extra.stand_sliding = true;
    // rust: stand_if_possible(m);
}
register :: proc(m: ^Mob) {
}
    // rust: if super::camel::is_camel(m.species()) {
    // rust: return super::camel::register(m);
}
    // rust: if super::llama::is_llama(m.species()) {
    // rust: return super::llama::register(m);
}
    // rust: let tempt = m.kind.tempt.clone();
    // rust: let species = m.species();
    // rust: let rears = can_rear(species);
    // rust: let stand_interval = m.kind.ambient_interval;
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(1, RunAroundLikeCrazy);
    // rust: g.add(2, Breed::new(1.0));
    // rust: g.add(4, FollowParent::new(1.0));
    // rust: g.add(6, Stroll::avoiding_water(0.7));
    // rust: g.add(7, LookAtPlayer::new(6.0));
    // rust: g.add(8, RandomLookAround::default());
    // rust: if rears {
        // resetStandInterval: -getAmbientStandInterval (400 for every horse).
    // rust: g.add(
    // rust: 9,
    // rust: RandomStand {
    // rust: next: -stand_interval,
    // rust: },
    // rust: );
}
    // addBehaviourGoals, after the rest: none for the skeleton horse (it
    // sinks), no mount panic for the zombie horse.
    // rust: if species != Species::SkeletonHorse {
    // rust: g.add(0, Float);
    // rust: if species != Species::ZombieHorse {
    // rust: g.add(1, MountPanic(Panic::new(1.2)));
}
    // rust: g.add(3, Tempt::new(1.25, tempt, false));
}
}
// `randomizeAttributes` of each class: horses roll health, speed and jump,
// donkeys and mules only health (their jump stays 0.5), skeleton horses only
// the jump, zombie horses a smaller jump and their own speed. The health and
// speed are attribute bases (`setBaseValue`), so the server syncs them to
// the clients that draw the mount's hearts.
finalize :: proc(m: ^Mob) {
}
    // rust: let species = m.species();
    // rust: let r = &mut m.random;
    // rust: let health = matches!(species, Species::Horse | Species::Donkey | Species::Mule).then(|| {
    // rust: 15.0 + r.next_int_bound(8).unwrap_or(0) as f32 + r.next_int_bound(9).unwrap_or(0) as f32
    // rust: });
    // rust: let mut speed = None;
    // rust: match species {
    // rust: Species::Horse => {
    // rust: speed = Some(
    // rust: (0.45 + r.next_double() * 0.3 + r.next_double() * 0.3 + r.next_double() * 0.3)
    // rust: * 0.25,
    // rust: );
    // rust: m.extra.vector[0] =
    // rust: 0.4 + r.next_double() * 0.2 + r.next_double() * 0.2 + r.next_double() * 0.2;
    // rust: m.extra.variant = r.next_int_bound(7).unwrap_or(0) as u8;
    // rust: m.extra.variant2 = r.next_int_bound(5).unwrap_or(0) as u8;
}
    // rust: Species::Donkey | Species::Mule => m.extra.vector[0] = 0.5,
    // rust: Species::ZombieHorse => {
            // ZombieHorse.generateZombieHorseJumpStrength and ...Speed.
    // rust: let d = 0.066_666_666_666_666_67;
    // rust: m.extra.vector[0] =
    // rust: 0.5 + r.next_double() * d + r.next_double() * d + r.next_double() * d;
    // rust: speed = Some(
    // rust: (9.0 + r.next_double() + r.next_double() + r.next_double()) / f64::from(42.16f32),
    // rust: );
}
    // rust: _ => {
    // rust: m.extra.vector[0] =
    // rust: 0.4 + r.next_double() * 0.2 + r.next_double() * 0.2 + r.next_double() * 0.2
}
}
    // rust: if let Some(health) = health {
    // rust: set_base(m, Attr::MaxHealth, f64::from(health));
}
    // rust: if let Some(speed) = speed {
    // rust: set_base(m, Attr::MovementSpeed, speed);
}
    // rust: m.health = m.attrs.max_health;
}
// `AbstractHorse.createOffspringAttribute`.
offspring :: proc(a: f64, b: f64, min: f64, max: f64, r: ^impl RandomSource) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let (a, b) = (a.clamp(min, max), b.clamp(min, max));
    // rust: let margin = 0.15 * (max - min);
    // rust: let range = (a - b).abs() + margin * 2.0;
    // rust: let quality = (r.next_double() + r.next_double() + r.next_double()) / 3.0 - 0.5;
    // rust: let v = (a + b) / 2.0 + range * quality;
    // rust: if v > max {
    // rust: max - (v - max)
    // rust: } else if v < min {
    // rust: min + (min - v)
    // rust: } else {
    // rust: v
}
}
// `AbstractHorse.setOffspringAttributes` from two parents.
inherit :: proc(child: ^Mob, a: ^Mob, b: ^Mob, r: ^impl RandomSource) {
}
    // rust: let health = offspring(
    // rust: f64::from(a.attrs.max_health),
    // rust: f64::from(b.attrs.max_health),
    // rust: 15.0,
    // rust: 30.0,
    // rust: r,
    // rust: );
    // rust: set_base(child, Attr::MaxHealth, f64::from(health as f32));
    // rust: child.health = child.attrs.max_health;
    // rust: child.extra.vector[0] = offspring(a.extra.vector[0], b.extra.vector[0], 0.4, 1.0, r);
    // rust: let speed = offspring(a.attrs.speed, b.attrs.speed, 0.1125, 0.3375, r);
    // rust: set_base(child, Attr::MovementSpeed, speed);
}
// The rider controls the mount: saddled, with a player on it.
controlled :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(r) = m.rider else {
    // rust: return false;
}
    // rust: match m.species() {
        // Pig/Strider.getControllingPassenger: saddled, the rider holding the stick.
    // rust: Species::Pig | Species::Strider => m.extra.saddled && r.steer,
    // rust: Species::HappyGhast => super::happy_ghast::controlled(m),
    // rust: Species::Nautilus | Species::ZombieNautilus => super::nautilus::controlled(m),
        // AbstractHorse.getControllingPassenger: saddled with a player on it. A
        // tamed skeleton horse (SkeletonTrapGoal only tames it) needs the saddle too.
    // rust: _ => m.extra.saddled,
}
}
// Saddled equines (not llamas), pigs and striders: the controlling player
// moves the mount on their own client
// (`Entity.isLocalInstanceAuthoritative`, `LivingEntity.travelRidden`) and
// sends the moves (`ServerboundMoveVehiclePacket`).
moved_by_rider :: proc(s: Species) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(s, Species::Pig | Species::Strider) || (is_equine(s) && !super::llama::is_llama(s))
}
// A server's mount that its rider's client moves: `travelRidden` without
// `canSimulateMovement` turns it (`tickRidden`) and stops it there.
moved_by_client :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: moved_by_rider(m.species()) && m.rider.is_some_and(|r| r.client) && controlled(m)
}
// `ItemBasedSteering.boost`: 140 to 980 ticks of extra speed.
boost :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if m.extra.counter2 > 0 {
    // rust: return false;
}
    // rust: m.extra.counter2 = m.random.next_int_bound(841).unwrap_or(0) + 140;
    // rust: m.extra.counter = 0;
    // rust: true
}
// `ItemBasedSteering.tickBoost` and `boostFactor`.
boost_factor :: proc(m: ^Mob) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if m.extra.counter2 <= 0 {
    // rust: return 1.0;
}
    // rust: m.extra.counter += 1;
    // rust: if m.extra.counter > m.extra.counter2 {
    // rust: m.extra.counter2 = 0;
    // rust: return 1.0;
}
    // rust: 1.0 + 1.15 * (m.extra.counter as f32 / m.extra.counter2 as f32 * PI).msin()
}
// `AbstractHorse.MountPanicGoal`: only without a rider.
MountPanic :: struct {
    // rust: impl Goal for MountPanic {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.0.flags()
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.rider.is_none() && self.0.can_use(m, cx)
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.rider.is_none() && self.0.can_continue(m, cx)
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.0.start(m, cx)
}
stop :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.0.stop(m, cx)
}
}
// `RunAroundLikeCrazyGoal`: an untamed horse with a rider bolts about until
// it is tamed (temper) or throws the rider off.
    // rust: pub(super) struct RunAroundLikeCrazy;
    // rust: impl Goal for RunAroundLikeCrazy {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if m.extra.tame || m.rider.is_none() {
    // rust: return false;
}
    // rust: let r = &mut m.random;
    // rust: let (dx, dz) = (
    // rust: r.next_int_bound(11).unwrap_or(5) - 5,
    // rust: r.next_int_bound(11).unwrap_or(5) - 5,
    // rust: );
    // rust: let dy = r.next_int_bound(9).unwrap_or(4) - 4;
    // rust: let t = [
    // rust: m.position.x + f64::from(dx),
    // rust: m.position.y + f64::from(dy),
    // rust: m.position.z + f64::from(dz),
    // rust: ];
    // rust: m.nav_move_to(cx.w, t, 1.2)
}
can_continue :: proc(self: ^Self, m: ^Mob, _: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !m.extra.tame && !m.ai.nav.is_done() && m.rider.is_some()
}
every_tick :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: if m.extra.tame || m.random.next_int_bound(50).unwrap_or(1) != 0 {
    // rust: return;
}
    // rust: let temper = i32::from(m.extra.variant3);
    // rust: let max = max_temper(m.species());
    // rust: if m.random.next_int_bound(max).unwrap_or(0) < temper {
            // tameWithName
    // rust: m.extra.tame = true;
    // rust: cx.events.push(MobEvent::Tamed { mob: m.id });
    // rust: return;
}
    // rust: m.extra.variant3 = (temper + 5).min(max) as u8;
    // rust: cx.events.push(MobEvent::Buck { mob: m.id });
    // rust: make_mad(m, cx.events);
}
}
// `AbstractHorse.standIfPossible`: `setStanding(20)` (which also stops the
// eating) when `canPerformRearing`.
stand_if_possible :: proc(m: ^Mob) {
}
    // rust: if can_rear(m.species()) {
    // rust: m.extra.counter = 20;
    // rust: m.extra.flag = false;
}
}
// `AbstractHorse.hurtServer`, after the hurt went through: one hit in three
// rears the horse. Llamas and camels make the draw too, but never rear.
after_hurt_server :: proc(m: ^Mob) {
}
    // rust: if m.random.next_int_bound(3).unwrap_or(1) == 0 {
    // rust: stand_if_possible(m);
}
}
// `AbstractHorse.makeMad`: rear with the angry sound (`makeSound`).
make_mad :: proc(m: ^Mob, events: ^[dynamic]MobEvent) {
}
    // rust: if m.extra.counter > 0 {
    // rust: return;
}
    // rust: stand_if_possible(m);
    // getAngrySound: null (silent) for the skeleton horse.
    // rust: let sound = match m.species() {
    // rust: Species::SkeletonHorse => return,
    // rust: Species::Donkey => "entity.donkey.angry",
    // rust: Species::Mule => "entity.mule.angry",
    // rust: Species::ZombieHorse => "entity.zombie_horse.angry",
    // rust: Species::Llama | Species::TraderLlama => "entity.llama.angry",
    // rust: _ if m.is_baby() => "entity.baby_horse.angry",
    // rust: _ => "entity.horse.angry",
}
    // rust: m.voice(sound, events);
}
// What `Horse`, `AbstractChestedHorse` (donkeys, mules, llamas) and
// `ZombieHorse.mobInteract` do with a held item before
// `AbstractHorse.mobInteract`.
HeldItem :: enum {
    // `isFood`: `fedFood`, whether it eats or not.
    Feed,
    // Untamed: `makeMad` instead of taking the rider.
    Refused,
}
// That branch for a click with `item` (empty for none): no rider, not
// opening a tamed adult's inventory (`sneaking`), not a baby while the
// player holds a golden dandelion (`dandelion`; zombie horses skip that
// check). An untamed mount is made mad here.
    // rust: pub fn held_item(
    // rust: m: &mut Mob,
    // rust: item: &str,
    // rust: sneaking: bool,
    // rust: dandelion: bool,
    // rust: events: &mut Vec<MobEvent>,
    // rust: ) -> Option<HeldItem> {
    // rust: let species = m.species();
    // rust: let checks_dandelion = match species {
    // rust: Species::Horse | Species::Donkey | Species::Mule => true,
    // rust: Species::Llama | Species::TraderLlama => true,
    // rust: Species::ZombieHorse => false,
    // rust: _ => return None,
}
    // rust: let open_inventory = !m.is_baby() && m.extra.tame && sneaking;
    // rust: if m.rider.is_some()
    // rust: || open_inventory
    // rust: || (checks_dandelion && m.is_baby() && dandelion)
    // rust: || item.is_empty()
    // rust: {
    // rust: return None;
}
    // ZombieHorse.isFood: the zombie_horse_food tag.
    // rust: let food = if species == Species::ZombieHorse {
    // rust: item == "minecraft:red_mushroom"
    // rust: } else {
    // rust: m.kind.food.iter().any(|f| f == item)
}
    // rust: if food {
    // rust: return Some(HeldItem::Feed);
}
    // rust: if m.extra.tame {
    // rust: return None;
}
    // rust: make_mad(m, events);
    // rust: Some(HeldItem::Refused)
}
// `RandomStandGoal`.
RandomStand :: struct {
    next: i32,
}
    // rust: impl Goal for RandomStand {
    // rust: goal_clone!();
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: "RandomStandGoal"
}
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: 0
}
can_use :: proc(self: ^Self, m: ^Mob, _: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.next += 1;
    // rust: if self.next > 0 && m.random.next_int_bound(1000).unwrap_or(1000) < self.next {
    // rust: self.next = -m.kind.ambient_interval;
    // rust: return !immobile(m) && m.random.next_int_bound(10).unwrap_or(1) == 0;
}
    // rust: false
}
can_continue :: proc(self: ^Self, _: ^Mob, _: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: stand_if_possible(m);
        // playStandSound: getAmbientStandSound is the ambient sound, plain
        // playSound(sound) at volume and pitch 1.
    // rust: let sound = super::ai::voice_sounds(m)[0];
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: cx.events.push(MobEvent::Sound(sound, at, 1.0, 1.0));
}
}
// Horses that step with `AbstractHorse.playStepSound` (llamas and camels
// have their own).
hoof_steps :: proc(s: Species) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: s,
    // rust: Species::Horse
    // rust: | Species::Donkey
    // rust: | Species::Mule
    // rust: | Species::SkeletonHorse
    // rust: | Species::ZombieHorse
    // rust: )
}
// `Entity.isVehicle`: someone on its back, the player steering it
// (`rider`) or a mob that boarded it (`extra.rider`).
is_vehicle :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.rider.is_some() || m.extra.rider.is_some()
}
// `SkeletonHorse.getSwimSound`: an undead horse splashes its own way. In the
// water it swims; on the ground a horse with nobody on it splashes, and a
// ridden one counts on the same `gallopSoundCounter` its hoof steps use, so
// it splashes for the first five steps, then gallops through the water every
// third and swims in between.
skeleton_horse_swim_sound :: proc(m: ^Mob) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: if !m.on_ground {
    // rust: return "entity.skeleton_horse.swim";
}
    // rust: if !is_vehicle(m) {
    // rust: return "entity.skeleton_horse.step_water";
}
    // rust: m.ai.steps.gallop += 1;
    // rust: let count = m.ai.steps.gallop;
    // rust: if count > 5 && count % 3 == 0 {
    // rust: "entity.skeleton_horse.gallop_water"
    // rust: } else if count <= 5 {
    // rust: "entity.skeleton_horse.step_water"
    // rust: } else {
    // rust: "entity.skeleton_horse.swim"
}
}
// `SkeletonHorse.playSwimSound`: a skeleton horse standing on the ground
// splashes at 0.3, and one in the water at `min(0.1, f * 25.0)` - which
// saturates at 0.1 for any speed a swim sound plays at.
swim_volume :: proc(m: ^Mob, f: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if m.species() != Species::SkeletonHorse {
    // rust: return f;
}
    // rust: if m.on_ground {
    // rust: 0.3
    // rust: } else {
    // rust: (f * 25.0).min(0.1)
}
}
// `AbstractHorse.playStepSound` (and `Horse.playGallopSound`) on the block
// `pos`: silent on liquids; a ridden horse walks on wood for five steps,
// then gallops every third; unridden, wood or the plain step by age.
// Donkeys and mules never gallop (`canGallop`).
    // rust: pub fn play_step(
    // rust: m: &mut Mob,
    // rust: w: &MobWorld,
    // rust: pos: [i32; 3],
    // rust: state: horizon_world::registry::BlockStateId,
    // rust: events: &mut Vec<MobEvent>,
    // rust: ) {
    // rust: if matches!(
    // rust: &*w.facts.get(state).name,
    // rust: "minecraft:water" | "minecraft:lava" | "minecraft:bubble_column"
    // rust: ) {
    // rust: return;
}
    // rust: let above = w.world.block(pos[0], pos[1] + 1, pos[2]);
    // rust: let sound_type = if &*w.facts.get(above).name == "minecraft:snow" {
    // rust: &w.facts.get(above).sounds
    // rust: } else {
    // rust: &w.facts.get(state).sounds
}
    // rust: let (volume, pitch) = (sound_type.volume, sound_type.pitch);
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: let baby = m.is_baby();
    // rust: let can_gallop = !matches!(m.species(), Species::Donkey | Species::Mule);
    // rust: if m.rider.is_some() && can_gallop {
    // rust: m.ai.steps.gallop += 1;
    // rust: let count = m.ai.steps.gallop;
    // rust: if count > 5 && count % 3 == 0 {
    // rust: events.push(MobEvent::Sound(
    // rust: "entity.horse.gallop",
    // rust: at,
    // rust: volume * 0.15,
    // rust: pitch,
    // rust: ));
            // Horse.playGallopSound: now and then it breathes too.
    // rust: if m.species() == Species::Horse && m.random.next_int_bound(10).unwrap_or(1) == 0 {
    // rust: let breathe = if baby {
    // rust: "entity.baby_horse.breathe"
    // rust: } else {
    // rust: "entity.horse.breathe"
}
    // rust: events.push(MobEvent::Sound(breathe, at, volume * 0.6, pitch));
}
    // rust: } else if count <= 5 {
    // rust: events.push(MobEvent::Sound(
    // rust: "entity.horse.step_wood",
    // rust: at,
    // rust: volume * 0.15,
    // rust: pitch,
    // rust: ));
}
    // rust: } else if is_wood_sound_type(sound_type) {
    // rust: events.push(MobEvent::Sound(
    // rust: "entity.horse.step_wood",
    // rust: at,
    // rust: volume * 0.15,
    // rust: pitch,
    // rust: ));
    // rust: } else {
    // rust: let step = if baby {
    // rust: "entity.baby_horse.step"
    // rust: } else {
    // rust: "entity.horse.step"
}
    // rust: events.push(MobEvent::Sound(step, at, volume * 0.15, pitch));
}
}
// `AbstractHorse.isWoodSoundType`: WOOD, NETHER_WOOD, STEM, CHERRY_WOOD and
// BAMBOO_WOOD (not HARD_CROP, which only shares WOOD's step).
is_wood_sound_type :: proc(sounds: ^horizon_items::blocks::Sounds) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let step = sounds
    // rust: .step
    // rust: .strip_prefix("minecraft:")
    // rust: .unwrap_or(&sounds.step);
    // rust: let place = sounds
    // rust: .place
    // rust: .strip_prefix("minecraft:")
    // rust: .unwrap_or(&sounds.place);
    // rust: match step {
    // rust: "block.wood.step" => place == "block.wood.place",
    // rust: "block.nether_wood.step"
    // rust: | "block.stem.step"
    // rust: | "block.cherry_wood.step"
    // rust: | "block.bamboo_wood.step" => true,
    // rust: _ => false,
}
}
// The mount takes its rider's input (`getRiddenInput`, `tickRidden`).
ridden_step :: proc(m: ^Mob) {
}
    // rust: let Some(r) = m.rider else {
    // rust: return;
}
    // AbstractHorse.tickRidden: not pressing forward ends the gallop.
    // rust: if hoof_steps(m.species()) && r.forward <= 0.0 {
    // rust: m.ai.steps.gallop = 0;
}
    // AbstractNautilus.tickRidden turns half way toward the rider.
    // rust: if super::nautilus::is_nautilus(m.species()) {
    // rust: return super::nautilus::ridden(m);
}
    // rust: if m.species() == Species::HappyGhast {
    // rust: return super::happy_ghast::ridden(m);
}
    // AbstractHorse.tickRidden: setRot(getRiddenRotation), then the body and
    // head turn with it. A camel that refuses to move keeps its rotation
    // (Camel.getRiddenRotation).
    // rust: if !(super::camel::is_camel(m.species()) && super::camel::refuse_to_move(m)) {
    // rust: m.yaw = r.yaw;
    // rust: m.head_pitch = r.pitch * 0.5;
}
    // rust: m.body_yaw = m.yaw;
    // rust: m.head_yaw = m.yaw;
    // rust: m.ai.nav.stop();

    // rust: if matches!(m.species(), Species::Pig | Species::Strider) {
        // Pig/Strider: always forward along the rider's look, at a fraction
        // of the movement speed, boosted by the stick.
    // rust: m.head_pitch = r.pitch * 0.5;
        // Strider.getRiddenSpeed: slower while it shivers out of the warmth.
    // rust: let factor = if m.species() == Species::Pig {
    // rust: 0.225
    // rust: } else if super::strider::suffocating(m) {
    // rust: 0.35
    // rust: } else {
    // rust: 0.55
}
    // rust: let boost = boost_factor(m);
        // travelRidden: setSpeed(getRiddenSpeed), then travel(getRiddenInput);
        // the input is set after the speed (Mob.setSpeed also sets zza).
        // getAttributeValue(MOVEMENT_SPEED): with the cold strider's modifier.
    // rust: m.set_speed((m.movement_speed() * factor) as f32 * boost);
    // rust: m.ai.xxa = 0.0;
    // rust: m.ai.zza = 1.0;
    // rust: return;
}
    // rust: if super::camel::is_camel(m.species()) {
        // Camel.tickRidden / getRiddenInput: forward stands it up; no input
        // while sitting; the jump is a dash.
    // rust: if r.forward > 0.0 && super::camel::sitting(m) {
    // rust: let mut ev = Vec::new();
    // rust: super::camel::stand_up(m, &mut ev);
}
    // rust: if super::camel::refuse_to_move(m) {
    // rust: m.ai.xxa = 0.0;
    // rust: m.ai.zza = 0.0;
    // rust: return;
}
    // rust: let forward = if r.forward <= 0.0 {
    // rust: r.forward * 0.25
    // rust: } else {
    // rust: r.forward
}
    // rust: let bonus = if r.sprint && m.extra.anim_ticks == 0 {
    // rust: 0.1
    // rust: } else {
    // rust: 0.0
}
    // rust: m.set_speed(m.movement_speed() as f32 + bonus);
    // rust: m.ai.xxa = r.strafe * 0.5;
    // rust: m.ai.zza = forward;
    // rust: if r.jump > 0.0 {
    // rust: let mut ev = Vec::new();
    // rust: if super::camel::dash(m, r.jump, &mut ev)
    // rust: && let Some(rider) = m.rider.as_mut()
    // rust: {
    // rust: rider.jump = 0.0;
}
}
    // rust: return;
}
    // AbstractHorse.getRiddenInput: no input on the ground while rearing,
    // unless a jump let it slide.
    // rust: let standing = m.extra.counter > 0;
    // rust: if m.on_ground && r.jump == 0.0 && standing && !m.extra.stand_sliding {
    // rust: m.ai.xxa = 0.0;
    // rust: m.ai.zza = 0.0;
    // rust: return;
}
    // rust: let forward = if r.forward <= 0.0 {
    // rust: r.forward * 0.25
    // rust: } else {
    // rust: r.forward
}
    // rust: let speed = m.movement_speed() as f32;
    // rust: m.set_speed(speed);
    // rust: m.ai.xxa = r.strafe * 0.5;
    // rust: m.ai.zza = forward;
    // rust: if m.on_ground && r.jump > 0.0 {
        // executeRidersJump
    // rust: let impulse = m.extra.vector[0] as f32 * r.jump;
    // rust: m.velocity.y = f64::from(impulse);
    // rust: if forward > 0.0 {
    // rust: let (s, c) = (m.yaw.to_radians().msin(), m.yaw.to_radians().mcos());
    // rust: m.velocity.x += f64::from(-0.4 * s * r.jump);
    // rust: m.velocity.z += f64::from(0.4 * c * r.jump);
}
    // rust: crate::motion::native_living_jump(m.id, &m.kind.id);
    // rust: if let Some(rider) = m.rider.as_mut() {
    // rust: rider.jump = 0.0;
}
}
}
// `AbstractHorse.aiStep`'s `moveTail` (one in 200 ticks) and the counter's
// step in `tick` (it runs to 8, then stops). A client runs it on its own
// random, as vanilla's client-side `aiStep` does.
tail_tick :: proc(m: ^Mob) {
}
    // rust: if m.random.next_int_bound(200).unwrap_or(1) == 0 {
    // rust: m.anim.v[TAIL] = 1.0;
}
    // rust: if m.anim.v[TAIL] > 0.0 {
    // rust: m.anim.v[TAIL] += 1.0;
    // rust: if m.anim.v[TAIL] > 8.0 {
    // rust: m.anim.v[TAIL] = 0.0;
}
}
}
// `AbstractHorse.aiStep` and `tick`: healing, grazing, the rear and the
// eating/standing/mouth animations.
ai_step :: proc(m: ^Mob, w: ^MobWorld, events: ^[dynamic]MobEvent) {
}
    // rust: if super::camel::is_camel(m.species()) {
        // Camel.aiStep runs AbstractHorse.aiStep first, and its followMommy is
        // the last thing that does.
    // rust: follow_mommy(m, w);
    // rust: return super::camel::ai_step(m, events);
}
    // rust: if super::llama::is_llama(m.species()) {
    // rust: follow_mommy(m, w);
    // rust: return super::llama::ai_step(m, w);
}
    // rust: if m.alive() && m.random.next_int_bound(900).unwrap_or(1) == 0 && m.death_time == 0 {
    // rust: m.heal(1.0);
}
    // Grazing (canEatGrass: horses and donkeys alike).
    // rust: if m.alive() && m.rider.is_none() {
    // rust: let below = w.facts.get(w.world.block(
    // rust: m.position.x.floor() as i32,
    // rust: (m.position.y - 0.5).floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: ));
    // rust: if !m.extra.flag
    // rust: && m.random.next_int_bound(300).unwrap_or(1) == 0
    // rust: && &*below.name == "minecraft:grass_block"
    // rust: {
    // rust: m.extra.flag = true;
    // rust: m.extra.counter2 = 0;
}
}
    // rust: if m.extra.flag {
    // rust: m.extra.counter2 += 1;
    // rust: if m.extra.counter2 > 50 {
    // rust: m.extra.counter2 = 0;
    // rust: m.extra.flag = false;
}
}
    // rust: stand_tick(m);
    // rust: animate(m);
    // rust: follow_mommy(m, w);
}

// `AbstractHorse.aiStep`'s last call, `followMommy`: a bred foal that is not
// eating keeps a path to the nearest bred `AbstractHorse` within 16 blocks
// while it is more than two blocks away (`MOMMY_TARGETING`, and
// `this.distanceToSqr(mommy) > 4.0`). `PathNavigation.createPath(entity, 0)`
// installs that path and leaves the navigation's speed modifier alone, so the
// foal walks it at whatever speed its goals last asked for.
follow_mommy :: proc(m: ^Mob, w: ^MobWorld) {
}
    // rust: if !m.extra.bred || !m.is_baby() || m.extra.flag {
    // rust: return;
}
    // rust: let at = m.position;
    // `MOMMY_TARGETING`'s range is 16 from the foal's position, and the search
    // box is its own bounding box inflated by the same 16.
    // rust: let area = m.bounds().inflate(Vec3::new(16.0, 16.0, 16.0));
    // rust: let mommy = w
    // rust: .others_near(area)
    // rust: .filter(|o| {
    // rust: o.alive
    // rust: && o.bred
    // rust: && is_equine(o.species)
    // rust: && area.intersects(o.bounds)
    // rust: && at.distance_squared(o.position) <= 256.0
    // rust: })
    // rust: .min_by(|a, b| {
    // rust: at.distance_squared(a.position)
    // rust: .total_cmp(&at.distance_squared(b.position))
    // rust: })
    // rust: .map(|o| o.position);
    // rust: let Some(mommy) = mommy else {
    // rust: return;
}
    // rust: if at.distance_squared(mommy) <= 4.0 {
    // rust: return;
}
    // rust: let speed = m.ai.nav.speed_modifier;
    // rust: let path = m.create_path_to_entity(w, [mommy.x, mommy.y, mommy.z], 0);
    // rust: m.nav_move_to_path(w, path, speed);
}
// `AbstractHorse.tick`: the stand counter runs down to `clearStanding`. It is
// in `tick`, not `aiStep`, so a horse with no AI stops rearing too.
stand_tick :: proc(m: ^Mob) {
}
    // rust: if m.extra.counter > 0 {
    // rust: m.extra.counter -= 1;
}
}
// `AbstractHorse.tick`'s eat, stand and mouth animations, which follow the
// eating and standing flags (`flag` and `counter > 0`), and the end of
// `allowStandSliding` once it stands no more.
animate :: proc(m: ^Mob) {
}
    // rust: let (eating, standing) = (m.extra.flag, m.extra.counter > 0);
    // rust: let v = &mut m.anim.v;
    // rust: if standing {
    // rust: v[EAT] = 0.0;
    // rust: m.anim.vo[EAT] = 0.0;
    // rust: v[STAND] = (v[STAND] + (1.0 - v[STAND]) * 0.4 + 0.05).min(1.0);
    // rust: } else {
    // rust: m.extra.stand_sliding = false;
    // rust: if eating {
    // rust: v[EAT] = (v[EAT] + (1.0 - v[EAT]) * 0.4 + 0.05).min(1.0);
    // rust: } else {
    // rust: v[EAT] = (v[EAT] - v[EAT] * 0.4 - 0.05).max(0.0);
}
    // rust: let s = v[STAND];
    // rust: v[STAND] = (s + (0.8 * s * s * s - s) * 0.6 - 0.05).max(0.0);
}
    // rust: v[MOUTH] = (v[MOUTH] - v[MOUTH] * 0.7 - 0.05).max(0.0);
}
// `AbstractHorse.tick` on a client that is not the server: the animations
// follow the flags of the synched data (`set_flags`).
client_tick :: proc(m: ^Mob) {
}
    // rust: m.anim.vo = m.anim.v;
    // rust: animate(m);
}
// How long a client counts a rear the server's flags say is on. A client
// never runs `standCounter` (`standIfPossible` only sets it on the server);
// `isStanding` is just the synched flag. The mount a client drives does run
// `stand_tick`, so a counter of 1 would end the rear a tick after the flag
// arrived, long before the jump lands. The next flags without the bit end it.
CLIENT_STANDING :: 1 << 20
// `AbstractHorse.DATA_ID_FLAGS` on a client: eating 16 and standing 32.
set_flags :: proc(m: ^Mob, flags: u8) {
}
    // rust: m.extra.flag = flags & 16 != 0;
    // rust: if flags & 32 == 0 {
    // rust: m.extra.counter = 0;
    // rust: } else if m.extra.counter == 0 {
    // rust: m.extra.counter = CLIENT_STANDING;
}
}
// Whether `ai_step` above runs this species' grazing and rearing, so that
// the server's flags 16 and 32 mean eating and standing.
grazes :: proc(s: Species) -> b {
    // Ported from Horizon
    return {}
}
    // rust: is_equine(s) && !super::camel::is_camel(s) && !super::llama::is_llama(s)
}
// Body texture and the markings overlay.
texture :: proc(m: ^Mob) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let baby = if m.is_baby() { "_baby" } else { "" };
    // rust: match m.species() {
    // rust: Species::Horse => {
    // rust: let c = COLORS[(m.extra.variant as usize).min(6)];
    // rust: format!("entity/horse/horse_{c}{baby}")
}
    // rust: Species::Donkey => format!("entity/horse/donkey{baby}"),
    // rust: Species::Mule => format!("entity/horse/mule{baby}"),
    // rust: Species::SkeletonHorse => format!("entity/horse/horse_skeleton{baby}"),
    // rust: Species::Camel => format!("entity/camel/camel{baby}"),
    // rust: Species::CamelHusk => "entity/camel/camel_husk".into(),
    // rust: _ => format!("entity/horse/horse_zombie{baby}"),
}
}
markings :: proc(m: ^Mob) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if m.species() != Species::Horse {
    // rust: return None;
}
    // rust: let mk = MARKINGS[(m.extra.variant2 as usize).min(4)];
    // rust: if mk.is_empty() {
    // rust: return None;
}
    // rust: let baby = if m.is_baby() { "_baby" } else { "" };
    // rust: Some(format!("entity/horse/horse_markings_{mk}{baby}"))
}
// The model key prefix for the species.
model_name :: proc(s: Species) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match s {
    // rust: Species::Horse => "horse",
    // rust: Species::Donkey => "donkey",
    // rust: Species::Mule => "mule",
    // rust: Species::SkeletonHorse => "skeleton_horse",
        // CamelHuskRenderer: the camel's model (and its saddle layer).
    // rust: Species::Camel | Species::CamelHusk => "camel",
    // rust: _ => "zombie_horse",
}
}
// The saddle layer texture.
saddle_texture :: proc(s: Species) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match s {
    // rust: Species::Donkey => "entity/equipment/donkey_saddle/saddle",
    // rust: Species::Mule => "entity/equipment/mule_saddle/saddle",
    // rust: Species::SkeletonHorse => "entity/equipment/skeleton_horse_saddle/saddle",
    // rust: Species::ZombieHorse => "entity/equipment/zombie_horse_saddle/saddle",
    // rust: Species::Camel => "entity/equipment/camel_saddle/saddle",
    // rust: Species::CamelHusk => "entity/equipment/camel_husk_saddle/saddle",
    // rust: _ => "entity/equipment/horse_saddle/saddle",
}
}
// `AbstractEquineModel.setupAnim` with the adult and baby offsets.
anim :: proc(m: ^Mob, s: ^State, p: ^Poses) {
}
    // rust: let baby = m.is_baby();
    // rust: let donkey = matches!(m.species(), Species::Donkey | Species::Mule);
    // Leg/tail/head parameters (getLeg*, getTailXRotOffset).
    // rust: let (stand_angle, stand_y, stand_z, stand_x_off, tail_off) = match (baby, donkey) {
    // rust: (false, _) => (PI / 12.0, 12.0, 4.0, -PI / 3.0, 0.0),
    // rust: (true, false) => (PI / 12.0, 4.0, 0.0, -PI / 3.0, -PI / 2.0),
    // rust: (true, true) => (PI / 3.0, 1.0, 0.5, 0.0, -PI / 4.0),
}
    // rust: let clamped = s.y_rot.clamp(-20.0, 20.0);
    // rust: let mut head_x = s.x_rot.to_radians();
    // rust: let (speed, pos) = (s.speed, s.pos);
    // rust: if speed > 0.2 {
    // rust: head_x += (pos * 0.8).mcos() * 0.15 * speed;
}
    // rust: let eating = m.anim.lerp(EAT, s.partial);
    // rust: let standing = m.anim.lerp(STAND, s.partial);
    // rust: let istand = 1.0 - standing;
    // rust: let feeding = m.anim.lerp(MOUTH, s.partial);
    // rust: let in_water = if m.fluids.in_water { 0.2 } else { 1.0 };
    // rust: let leg1 = (in_water * pos * 0.6662 + PI).mcos();
    // rust: let leg_x = leg1 * 0.8 * speed;
    // rust: let base = (1.0 - standing.max(eating)) * (PI / 6.0 + head_x + feeding * s.age.msin() * 0.05);
    // rust: p.xrot(
    // rust: "head_parts",
    // rust: standing * (PI / 12.0 + head_x) + eating * (2.181_661_6 + s.age.msin() * 0.05) + base,
    // rust: );
    // rust: p.yrot(
    // rust: "head_parts",
    // rust: standing * clamped.to_radians() + (1.0 - standing.max(eating)) * clamped.to_radians(),
    // rust: );
    // animateHeadPartsPlacement
    // rust: {
    // rust: let hp = p.get("head_parts");
    // rust: let lerp = |t: f32, a: f32, b: f32| a + (b - a) * t;
    // rust: if baby && donkey {
    // rust: hp[1] = lerp(eating, hp[1], -1.2);
    // rust: hp[2] = lerp(standing, hp[2], -3.6);
    // rust: } else if baby {
    // rust: hp[1] += lerp(eating, lerp(standing, 0.0, -2.0), 2.0);
    // rust: hp[2] = lerp(standing, hp[2], -4.0);
    // rust: } else {
    // rust: hp[1] += lerp(eating, lerp(standing, 0.0, -8.0), 7.0);
    // rust: hp[2] = lerp(standing, hp[2], -4.0);
}
}
    // rust: let body_x = p.get("body")[3];
    // rust: p.xrot("body", standing * (-PI / 4.0) + istand * body_x);
    // rust: {
    // rust: let lf = p.get("left_front_leg");
    // rust: lf[1] -= stand_y * standing;
    // rust: lf[2] += stand_z * standing;
    // rust: let (y, z) = (lf[1], lf[2]);
    // rust: let rf = p.get("right_front_leg");
    // rust: rf[1] = y;
    // rust: rf[2] = z;
}
    // rust: let stand = stand_angle * standing;
    // rust: let bob = (s.age * 0.6 + PI).mcos();
    // rust: let rleg = (stand_x_off + bob) * standing + leg_x * istand;
    // rust: let lleg = (stand_x_off - bob) * standing - leg_x * istand;
    // rust: p.xrot("left_hind_leg", stand - leg1 * 0.5 * speed * istand);
    // rust: p.xrot("right_hind_leg", stand + leg1 * 0.5 * speed * istand);
    // rust: p.xrot("left_front_leg", rleg);
    // rust: p.xrot("right_front_leg", lleg);
    // rust: if baby && donkey {
    // rust: let lerp = |t: f32, a: f32, b: f32| a + (b - a) * t;
        // BabyDonkeyModel lerps the right leg from the left leg's new height.
    // rust: let y = lerp(standing, p.get("left_hind_leg")[1], -0.3);
    // rust: p.get("left_hind_leg")[1] = y;
    // rust: p.get("right_hind_leg")[1] = lerp(standing, y, -0.3);
}
    // rust: let age = if baby { 0.5 } else { 1.0 };
    // rust: p.xrot("tail", tail_off + PI / 6.0 + speed * 0.75);
    // rust: {
    // rust: let t = p.get("tail");
    // rust: t[1] += speed * age;
    // rust: t[2] += speed * 2.0 * age;
}
    // animateTail: the tail swings while the counter runs.
    // rust: p.yrot(
    // rust: "tail",
    // rust: if m.anim.v[TAIL] > 0.0 {
    // rust: (s.age * 0.7).mcos()
    // rust: } else {
    // rust: 0.0
    // rust: },
    // rust: );
    // rust: if baby && donkey {
        // BabyDonkeyModel overrides the state's pitch with -30 degrees and
        // sets the head parts again.
    // rust: let head_x = -30.0f32 * horizon_core::geometry::trig::DEG_TO_RAD;
    // rust: let base =
    // rust: (1.0 - standing.max(eating)) * (PI / 6.0 + head_x + feeding * s.age.msin() * 0.05);
    // rust: p.xrot(
    // rust: "head_parts",
    // rust: standing * (PI / 12.0 + head_x) + eating * (PI / 2.0 + s.age.msin() * 0.05) + base,
    // rust: );
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::mobs::Damage;
//     use crate::mobs::finalize::base_value;
//     use crate::mobs::sensor_scan_tests::kind;
//     use horizon_core::geometry::Vec3;
//     use std::sync::Arc;

horse :: proc(species: Species) -> M {
    // Ported from Horizon
    return {}
}
    // rust: let mut kind = crate::mobs::sensor_scan_tests::kind();
    // rust: let k = Arc::make_mut(&mut kind);
    // rust: k.species = species;
    // rust: k.max_health = 53.0;
    // rust: Mob::new(1, kind, Vec3::ZERO, 0.0)
}

    // The rolled health is the attribute's base, which the server syncs: a
    // rider's client draws the horse's hearts from it, not the type's 53.
rolled_health_and_speed_are_attribute_bases :: proc() {
}
    // rust: for species in [Species::Horse, Species::Donkey, Species::Mule] {
    // rust: let mut m = horse(species);
    // rust: finalize(&mut m);
    // rust: assert!((15.0..=30.0).contains(&m.attrs.max_health));
    // rust: assert_eq!(
    // rust: base_value(&m, Attr::MaxHealth),
    // rust: f64::from(m.attrs.max_health)
    // rust: );
    // rust: assert_eq!(m.health, m.attrs.max_health);
}
    // rust: let mut m = horse(Species::Horse);
    // rust: finalize(&mut m);
    // rust: assert_eq!(base_value(&m, Attr::MovementSpeed), m.attrs.speed);
}

equine :: proc(id: u32, species: Species, name: string) -> M {
    // Ported from Horizon
    return {}
}
    // rust: let mut kind = kind();
    // rust: let k = Arc::make_mut(&mut kind);
    // rust: k.id = name.into();
    // rust: k.species = species;
    // rust: k.max_health = 30.0;
    // rust: Mob::new(id, kind, Vec3::new(f64::from(id), 64.0, 0.0), 0.0)
}
    // Hits `n` fresh mobs of a species once each; how many reared.
rears :: proc(species: Species, name: string, n: u32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: (1..=n)
    // rust: .filter(|&id| {
    // rust: let mut m = equine(id, species, name);
    // rust: assert!(m.damage(1.0, Damage::player([0.0, 64.0, 0.0])));
    // rust: m.extra.counter == 20
    // rust: })
    // rust: .count() as u32
}

a_hurt_horse_rears_one_hit_in_three :: proc() {
}
        // AbstractHorse.hurtServer: nextInt(3) == 0 -> standIfPossible (#3432).
    // rust: let n = rears(Species::Horse, "minecraft:horse", 300);
    // rust: assert!((60..=140).contains(&n), "{n} of 300 hits reared");
}

a_synched_rear_lasts_until_the_flag_goes :: proc() {
}
        // The mount a client drives ticks `stand_tick` itself; the synched
        // standing flag, not that counter, decides when the rear is over.
    // rust: let mut m = equine(1, Species::Donkey, "minecraft:donkey");
    // rust: set_flags(&mut m, 32);
    // rust: for _ in 0..25 {
    // rust: stand_tick(&mut m);
    // rust: animate(&mut m);
}
    // rust: assert!(m.extra.counter > 0, "still standing");
    // rust: assert_eq!(m.anim.v[STAND], 1.0);
    // rust: set_flags(&mut m, 4);
    // rust: assert_eq!(m.extra.counter, 0);
    // rust: stand_tick(&mut m);
    // rust: animate(&mut m);
    // rust: assert!(m.anim.v[STAND] < 1.0, "falls once the flag is gone");
}

the_rear_ends_after_twenty_ticks :: proc() {
}
        // AbstractHorse.tick: standCounter runs down, then clearStanding.
    // rust: let mut m = equine(1, Species::Horse, "minecraft:horse");
    // rust: stand_if_possible(&mut m);
    // rust: for _ in 0..19 {
    // rust: stand_tick(&mut m);
}
    // rust: assert!(m.extra.counter > 0);
    // rust: stand_tick(&mut m);
    // rust: assert_eq!(m.extra.counter, 0);
}

llamas_and_camels_never_rear_when_hurt :: proc() {
}
        // Llama and Camel: canPerformRearing is false.
    // rust: assert_eq!(rears(Species::Llama, "minecraft:llama", 60), 0);
    // rust: assert_eq!(rears(Species::Camel, "minecraft:camel", 60), 0);
}

    // `SkeletonHorse.getSwimSound`: an undead horse has its own water sounds,
    // and one with someone on it counts its water steps on the same
    // `gallopSoundCounter` its hoof steps use - five splashes, then a gallop
    // through the water every third step and a swim sound in between.
a_skeleton_horse_splashes_and_swims_with_its_own_sounds :: proc() {
}
    // rust: let sound = |m: &mut Mob| crate::mobs::ai::swim_sound(m);
    // rust: let mut m = equine(1, Species::SkeletonHorse, "minecraft:skeleton_horse");
        // In the water it swims; every other animal's default is the generic
        // splash (Entity.getSwimSound).
    // rust: m.on_ground = false;
    // rust: assert_eq!(sound(&mut m), "entity.skeleton_horse.swim");
        // Standing on the ground with nobody on it, it splashes.
    // rust: m.on_ground = true;
    // rust: assert_eq!(sound(&mut m), "entity.skeleton_horse.step_water");
    // rust: m.extra.rider = Some(9);
    // rust: let ridden: Vec<&str> = (0..9).map(|_| sound(&mut m)).collect();
    // rust: assert_eq!(
    // rust: ridden,
    // rust: [
    // rust: "entity.skeleton_horse.step_water",
    // rust: "entity.skeleton_horse.step_water",
    // rust: "entity.skeleton_horse.step_water",
    // rust: "entity.skeleton_horse.step_water",
    // rust: "entity.skeleton_horse.step_water",
    // rust: "entity.skeleton_horse.gallop_water",
    // rust: "entity.skeleton_horse.swim",
    // rust: "entity.skeleton_horse.swim",
    // rust: "entity.skeleton_horse.gallop_water",
    // rust: ]
    // rust: );
    // rust: assert_eq!(m.ai.steps.gallop, 9);
        // A plain horse keeps the generic splash.
    // rust: let mut horse = equine(2, Species::Horse, "minecraft:horse");
    // rust: assert_eq!(sound(&mut horse), "entity.generic.swim");
}

    // `SkeletonHorse.playSwimSound`: 0.3 on the ground, and no more than 0.1
    // in the water, where every other animal keeps the volume
    // `waterSwimSound` works out from its speed.
a_skeleton_horses_splash_is_quiet_in_the_water :: proc() {
}
    // rust: let mut m = equine(1, Species::SkeletonHorse, "minecraft:skeleton_horse");
    // rust: m.on_ground = true;
    // rust: assert_eq!(swim_volume(&m, 0.35), 0.3);
    // rust: m.on_ground = false;
    // rust: assert_eq!(swim_volume(&m, 0.35), 0.1);
    // rust: assert_eq!(swim_volume(&m, 1.0), 0.1);
    // rust: assert!((swim_volume(&m, 0.001) - 0.025).abs() < 1.0e-6);
    // rust: let mut horse = equine(2, Species::Horse, "minecraft:horse");
    // rust: horse.on_ground = false;
    // rust: assert_eq!(swim_volume(&horse, 0.35), 0.35);
}
}

    // rust: mod follow_mommy_tests {
//     use super::*;
//     use crate::mobs::world::{with_built_test_world, with_test_world};
//     use std::sync::Arc;

    // The block the foal's navigation path ends on after one `ai_step`, with
    // the foal at x = 0.5 on a stone floor and `others` (name, x, bred)
    // standing on the same floor.
    // rust: fn target_pos(
    // rust: foal: (bool, bool, bool),
    // rust: others: &[(&str, f64, bool)],
    // rust: ) -> Option<Option<[i32; 3]>> {
    // rust: let (bred, baby, eating) = foal;
    // rust: let mut built = None;
    // rust: with_test_world(&[], |_, types| {
    // rust: let mob = |id: u32, name: &str, at: Vec3| {
    // rust: let mut m = Mob::new(id, Arc::new(types.types[name].clone()), at, 0.0);
    // rust: m.on_ground = true;
    // rust: m
}
    // rust: let seen: Vec<_> = others
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, (name, x, bred))| {
    // rust: let mut m = mob(i as u32 + 2, name, Vec3::new(*x, 1.0, 0.5));
    // rust: m.extra.bred = *bred;
    // rust: m.seen(None)
    // rust: })
    // rust: .collect();
    // rust: let mut foal = mob(1, "minecraft:horse", Vec3::new(0.5, 1.0, 0.5));
    // rust: foal.extra.bred = bred;
    // rust: foal.extra.age = if baby { -24_000 } else { 0 };
    // rust: foal.extra.flag = eating;
    // rust: built = Some((foal, seen));
    // rust: });
    // rust: let (mut foal, seen) = built?;
    // rust: let mut out = None;
    // rust: with_built_test_world(
    // rust: &seen,
    // rust: |world, registry| {
                // The chunks the pathfinder looks through, over a stone floor.
    // rust: for (cx, cz) in [
    // rust: (-1, -1),
    // rust: (-1, 0),
    // rust: (-1, 1),
    // rust: (0, -1),
    // rust: (0, 0),
    // rust: (0, 1),
    // rust: (1, -1),
    // rust: (1, 0),
    // rust: (1, 1),
    // rust: ] {
    // rust: world
    // rust: .chunks
    // rust: .insert((cx, cz), Arc::new(crate::chunk::Chunk::empty(cx, cz)));
}
    // rust: let stone = registry.default_state("minecraft:stone").unwrap();
    // rust: for x in -16..32 {
    // rust: for z in -16..32 {
    // rust: world.set(x, 0, z, stone).unwrap();
}
}
    // rust: },
    // rust: |w, _| {
    // rust: let mut events = Vec::new();
    // rust: ai_step(&mut foal, w, &mut events);
    // rust: out = Some(foal.ai.nav.target_pos);
    // rust: },
    // rust: );
    // rust: out
}

    // `AbstractHorse.followMommy`: a bred foal that is not eating keeps a path
    // to the nearest bred `AbstractHorse` within 16 blocks while it is more
    // than two blocks away.
a_bred_foal_paths_to_the_nearest_bred_horse :: proc() {
}
    // rust: let Some(_) = target_pos((true, true, false), &[]) else {
    // rust: return;
}
    // rust: assert_eq!(
    // rust: target_pos((true, true, false), &[("minecraft:horse", 6.5, true)]).unwrap(),
    // rust: Some([6, 1, 0]),
    // rust: "a bred foal walks to the grown horse"
    // rust: );
        // The nearest of two, whatever the kind.
    // rust: assert_eq!(
    // rust: target_pos(
    // rust: (true, true, false),
    // rust: &[
    // rust: ("minecraft:horse", 12.5, true),
    // rust: ("minecraft:donkey", 6.5, true)
    // rust: ]
    // rust: )
    // rust: .unwrap(),
    // rust: Some([6, 1, 0]),
    // rust: "the nearer of the herd"
    // rust: );
        // `isBred`, `isBaby` and `!isEating` on the foal itself.
    // rust: assert_eq!(
    // rust: target_pos((false, true, false), &[("minecraft:horse", 6.5, true)]).unwrap(),
    // rust: None,
    // rust: "a foal that is not bred does not follow"
    // rust: );
    // rust: assert_eq!(
    // rust: target_pos((true, false, false), &[("minecraft:horse", 6.5, true)]).unwrap(),
    // rust: None,
    // rust: "an adult does not follow"
    // rust: );
    // rust: assert_eq!(
    // rust: target_pos((true, true, true), &[("minecraft:horse", 6.5, true)]).unwrap(),
    // rust: None,
    // rust: "a foal busy eating does not follow"
    // rust: );
        // `MOMMY_TARGETING`: an AbstractHorse, and bred.
    // rust: assert_eq!(
    // rust: target_pos((true, true, false), &[("minecraft:horse", 6.5, false)]).unwrap(),
    // rust: None,
    // rust: "the grown horse must be bred too"
    // rust: );
    // rust: assert_eq!(
    // rust: target_pos((true, true, false), &[("minecraft:cow", 6.5, true)]).unwrap(),
    // rust: None,
    // rust: "another kind is no mommy"
    // rust: );
        // 16 blocks of `MOMMY_TARGETING`, and more than two away.
    // rust: assert_eq!(
    // rust: target_pos((true, true, false), &[("minecraft:horse", 20.5, true)]).unwrap(),
    // rust: None,
    // rust: "out of the 16-block range"
    // rust: );
    // rust: assert_eq!(
    // rust: target_pos((true, true, false), &[("minecraft:horse", 1.5, true)]).unwrap(),
    // rust: None,
    // rust: "already at its side"
    // rust: );
}
}
