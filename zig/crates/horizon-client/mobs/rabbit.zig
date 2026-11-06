//! Transpiled from Horizon Rust crate
//! Module: horizon-client_rabbit
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Rabbit hopping controls and the clocks consumed by `RabbitModel`.
// use super::{
    // rust: Mob, MobEvent, MobWorld, Species,
    // rust: control::Operation,
    // rust: goals::{
    // rust: Avoid, AvoidEntity, Breed, ClimbOnTopOfPowderSnow, Cx, Float, Goal, HurtByTarget, JUMP,
    // rust: LookAtPlayer, MOVE, MeleeAttack, MoveToBlock, NearestTarget, Panic, Stroll, Tempt,
    // rust: goal_clone, reduced,
    // rust: },
}
// use horizon_core::{
    // rust: geometry::{Vec3, trig},
    // rust: random::RandomSource,
}

// Rabbit's transient state in Extra (none of these clocks are saved).
pub const JUMP_TICKS: usize = 0;
pub const JUMP_DURATION: usize = 1;
pub const MOVE_DELAY: usize = 2;
pub const IDLE_TIMEOUT: usize = 3;
// Client counters start only when the actual ground jump emits entity event 1.
pub const CLIENT_JUMP_TICKS: usize = 4;
pub const CLIENT_JUMP_DURATION: usize = 5;

/// The killer bunny's variant id (`Rabbit.Variant.EVIL`).
pub const EVIL: u8 = 99;

/// Rabbit.registerGoals.
pub fn register(m: *mut Mob) void {
}
    // rust: let food = m.kind.food.clone();
    // rust: let monsters = super::species::ALL
    // rust: .iter()
    // rust: .map(|d| d.species)
    // rust: .filter(|s| super::ai::is_monster(*s))
    // rust: .collect::<Vec<Species>>();
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(1, Float);
    // rust: g.add(1, ClimbOnTopOfPowderSnow);
    // rust: g.add(1, Panic::new(2.2));
    // rust: g.add(2, Breed::new(0.8));
    // rust: g.add(3, Tempt::new(1.0, food, false));
    // rust: g.add(4, RabbitAvoid::new(Avoid::Player, 8.0));
    // rust: g.add(
    // rust: 4,
    // rust: RabbitAvoid::new(Avoid::Species(vec![Species::Wolf]), 10.0),
    // rust: );
    // rust: g.add(4, RabbitAvoid::new(Avoid::Species(monsters), 4.0));
    // rust: g.add(5, RaidGarden::new());
    // rust: g.add(6, Stroll::avoiding_water(0.6));
    // rust: g.add(11, LookAtPlayer::new(10.0));
    // rust: m.ai.mov.kind = super::control::MoveKind::Custom;
    // rust: m.ai.nav.can_float = true;
    // rust: m.extra.ints[IDLE_TIMEOUT] = m.random.next_int_bound(40).unwrap_or(0) + 180;
}

/// `Rabbit.RaidGardenGoal.isValidTarget`: farmland-like ground (`#supports_crops`) under a
/// carrot crop at its maximum age, while the rabbit wants more food and has not found one.
pub fn raid_target(w: *MobWorld, p: [i32; 3], wants_to_raid: bool, can_raid: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: w.has_tag("minecraft:supports_crops", w.block_name(p[0], p[1], p[2]))
    // rust: && wants_to_raid
    // rust: && !can_raid
    // rust: && w.block_name(p[0], p[1] + 1, p[2]) == "minecraft:carrots"
    // rust: && w.prop(p[0], p[1] + 1, p[2], "age")
    // rust: .and_then(|a| a.parse::<i32>().ok())
    // rust: .is_some_and(|age| age >= CARROT_MAX_AGE)
}
/// `CarrotBlock.MAX_AGE`.
pub const CARROT_MAX_AGE: i32 = 7;

/// `Rabbit.RaidGardenGoal`: a `MoveToBlockGoal` (0.7, 16) to ripe carrots that eats one age
/// of them, then keeps the rabbit full for 40 ticks (`moreCarrotTicks`).
pub const RaidGarden = struct {
    block: MoveToBlock,
    wants_to_raid: bool,
    can_raid: bool,
};
    // rust: impl RaidGarden {
pub fn new() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: block: MoveToBlock::new(0.7, 16, 1),
    // rust: wants_to_raid: false,
    // rust: can_raid: false,
}
}
}
    // rust: impl Goal for RaidGarden {
    // rust: goal_clone!();
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: "RaidGardenGoal"
}
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: MOVE | JUMP
}
pub fn can_use(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
        // MoveToBlockGoal.canUse draws the next delay only once the last one ran out.
    // rust: if self.block.next_start > 0 {
    // rust: self.block.next_start -= 1;
    // rust: return false;
}
    // rust: if !cx.w.mob_griefing {
    // rust: return false;
}
    // rust: self.can_raid = false;
    // rust: self.wants_to_raid = m.extra.more_carrot_ticks <= 0;
    // rust: let next = reduced(200 + m.random.next_int_bound(200).unwrap_or(0));
    // rust: let wants = self.wants_to_raid;
    // rust: let found = std::cell::Cell::new(false);
    // rust: let target = self.block.can_use(m, cx.w, next, |w, p| {
    // rust: let ok = raid_target(w, p, wants, false);
    // rust: found.set(found.get() || ok);
    // rust: ok
    // rust: });
    // rust: self.can_raid = found.get();
    // rust: target
}
pub fn can_continue(self: *Self, _: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (wants, raid) = (self.wants_to_raid, self.can_raid);
    // rust: self.can_raid
    // rust: && self
    // rust: .block
    // rust: .can_continue(cx.w, |w, p| raid_target(w, p, wants, raid))
}
pub fn start(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: self.block.start(m, cx.w);
}
pub fn every_tick(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: self.block.tick(m, cx.w);
    // rust: let b = self.block.block;
    // rust: m.ai.look.set_look_at(
    // rust: [
    // rust: f64::from(b[0]) + 0.5,
    // rust: f64::from(b[1] + 1),
    // rust: f64::from(b[2]) + 0.5,
    // rust: ],
    // rust: 10.0,
    // rust: m.max_head_x_rot(),
    // rust: );
    // rust: if !self.block.reached {
    // rust: return;
}
    // rust: let crop = [b[0], b[1] + 1, b[2]];
    // rust: if self.can_raid && cx.w.block_name(crop[0], crop[1], crop[2]) == "minecraft:carrots" {
    // rust: let age =
    // rust: cx.w.prop(crop[0], crop[1], crop[2], "age")
    // rust: .and_then(|a| a.parse::<i32>().ok())
    // rust: .unwrap_or(0);
    // rust: let old = cx.w.world.block(crop[0], crop[1], crop[2]);
    // rust: if age == 0 {
                // `setBlock(AIR, 2)`, then `destroyBlock` finds air and does nothing.
    // rust: if let Some(air) = cx.w.registry.default_state("minecraft:air") {
    // rust: cx.events.push(MobEvent::CropRaided {
    // rust: pos: crop,
    // rust: state: air,
    // rust: old: None,
    // rust: mob: m.id,
    // rust: });
}
    // rust: } else if let Some(mut s) = cx.w.registry.state(old).cloned() {
    // rust: s.properties.insert("age".into(), (age - 1).to_string());
    // rust: if let Some(state) = cx.w.registry.id(&s) {
    // rust: cx.events.push(MobEvent::CropRaided {
    // rust: pos: crop,
    // rust: state,
    // rust: old: Some(old),
    // rust: mob: m.id,
    // rust: });
}
}
    // rust: m.extra.more_carrot_ticks = 40;
}
    // rust: self.can_raid = false;
    // rust: self.block.next_start = 10;
}
}

/// `Rabbit.RabbitAvoidEntityGoal(rabbit, class, maxDist, 2.2, 2.2)`: the
/// killer bunny flees nothing.
pub const RabbitAvoid = struct {};
    // rust: impl RabbitAvoid {
pub fn new(what: Avoid, max_dist: f32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self(AvoidEntity::new(what, max_dist, 2.2, 2.2))
}
}
    // rust: impl Goal for RabbitAvoid {
    // rust: goal_clone!();
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: "RabbitAvoidEntityGoal"
}
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.flags()
}
pub fn can_use(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.extra.variant != EVIL && self.0.can_use(m, cx)
}
pub fn can_continue(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.can_continue(m, cx)
}
pub fn start(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: self.0.start(m, cx)
}
pub fn stop(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: self.0.stop(m, cx)
}
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: self.0.tick(m, cx)
}
}

/// Rabbit.baseTick: the idle timeout branch precedes the hop clock branch.
pub fn base_tick(m: *mut Mob) void {
}
    // rust: let age = m.age as f32;
    // rust: let leashed = m.extra.leash.is_some();
    // rust: if m.extra.ints[IDLE_TIMEOUT] <= 0 && !leashed && !m.no_ai {
    // rust: m.extra.ints[IDLE_TIMEOUT] = m.random.next_int_bound(40).unwrap_or(0) + 180;
    // rust: m.anim.states[1].start(age);
    // rust: } else if m.extra.ints[CLIENT_JUMP_TICKS] > 0 {
    // rust: m.anim.states[0].start_if_stopped(age);
    // rust: m.anim.states[1].stop();
    // rust: } else {
    // rust: m.extra.ints[IDLE_TIMEOUT] -= 1;
    // rust: m.anim.states[0].stop();
}
    // rust: if leashed {
    // rust: m.anim.states[1].stop();
}
}

/// `Rabbit.facePoint`.
pub fn face_point(m: *mut Mob, x: f64, z: f64) void {
}
    // rust: m.yaw = trig::atan2_degrees(z - m.position.z, x - m.position.x) - 90.0;
}

/// `Rabbit.setVariant(EVIL)`, run the first time a killer bunny ticks (its
/// variant comes from `/summon`, a save or a spawn): armor 8, the bite and
/// target goals, attack damage plus 5 and the "Killer Bunny" name.
pub fn set_evil(m: *mut Mob) void {
}
//     use super::finalize::{Attr, Op, add_modifier, set_base};
    // rust: if m.ai.goals.has("MeleeAttack") {
    // rust: return;
}
    // rust: set_base(m, Attr::Armor, 8.0);
    // rust: m.ai.goals.add(4, MeleeAttack::new(1.4, true));
    // rust: m.ai.targets.add(1, HurtByTarget::new().alert());
    // rust: m.ai.targets.add(2, NearestTarget::player(true));
    // rust: m.ai.targets
    // rust: .add(2, NearestTarget::species(&[Species::Wolf], true));
    // rust: add_modifier(m, Attr::AttackDamage, "minecraft:evil", 5.0, Op::AddValue);
    // rust: if m.custom_name.is_none() && m.custom_name_text.is_none() {
    // rust: let name = crate::text::Text::translate("entity.minecraft.killer_bunny", &[]);
    // rust: m.custom_name = Some(name.plain());
    // rust: m.custom_name_text = Some(name);
}
}

pub fn start_jumping(m: *mut Mob) void {
}
    // rust: m.ai.jumping = true;
    // rust: m.extra.ints[JUMP_DURATION] = 15;
    // rust: m.extra.ints[JUMP_TICKS] = 0;
    // rust: let pitch = ((m.random.next_float() - m.random.next_float()) * 0.2 + 1.0) * 0.8;
    // rust: if !m.silent {
    // rust: m.outbox.push(MobEvent::Sound(
    // rust: "entity.rabbit.jump",
    // rust: [m.position.x, m.position.y, m.position.z],
    // rust: 1.0,
    // rust: pitch,
    // rust: ));
}
}

/// `Rabbit.playAttackSound`: only the killer bunny bites with a sound, at
/// volume 1 and a pitch drawn from its own random. The pitch is an argument of
/// `playSound`, so its two draws are made even for a silent rabbit.
pub fn attack_sound(m: *mut Mob, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: if m.extra.variant != EVIL {
    // rust: return;
}
    // rust: let pitch = (m.random.next_float() - m.random.next_float()) * 0.2 + 1.0;
    // rust: if m.silent {
    // rust: return;
}
    // rust: events.push(MobEvent::Sound(
    // rust: "entity.rabbit.attack",
    // rust: [m.position.x, m.position.y, m.position.z],
    // rust: 1.0,
    // rust: pitch,
    // rust: ));
}

/// Rabbit.customServerAiStep: start a hop toward the current path waypoint;
/// `target` is where the rabbit's target stands, if it has one.
pub fn server_ai_step(m: *mut Mob, target: ?Vec3) void {
}
    // rust: if m.extra.variant == EVIL {
    // rust: set_evil(m);
}
    // RabbitMoveControl.setWantedPosition applies the water override before landing checks.
    // rust: if m.fluids.in_water && m.ai.mov.speed_modifier > 0.0 {
    // rust: m.ai.mov.speed_modifier = 1.5;
}
    // rust: if m.extra.ints[MOVE_DELAY] > 0 {
    // rust: m.extra.ints[MOVE_DELAY] -= 1;
}
    // `moreCarrotTicks` runs down by up to 2 a tick.
    // rust: if m.extra.more_carrot_ticks > 0 {
    // rust: m.extra.more_carrot_ticks =
    // rust: (m.extra.more_carrot_ticks - m.random.next_int_bound(3).unwrap_or(0)).max(0);
}
    // rust: if m.on_ground {
    // rust: if !m.extra.flag {
    // rust: m.ai.jumping = false;
    // rust: m.extra.ints[MOVE_DELAY] = if m.ai.mov.speed_modifier < 2.2 { 10 } else { 3 };
}
        // A killer bunny within 4 blocks of its target faces it and hops at it.
    // rust: if m.extra.variant == EVIL
    // rust: && m.extra.ints[MOVE_DELAY] == 0
    // rust: && let Some(t) = target
    // rust: && m.distance_sqr(t) < 16.0
    // rust: {
    // rust: face_point(m, t.x, t.z);
    // rust: let speed = m.ai.mov.speed_modifier;
    // rust: m.ai.mov.set_wanted(t.x, t.y, t.z, speed);
    // rust: start_jumping(m);
}
    // rust: if !m.ai.jump && m.ai.mov.has_wanted() && m.extra.ints[MOVE_DELAY] == 0 {
    // rust: let mut at = m.ai.mov.wanted;
    // rust: if let Some(path) = m.ai.nav.path.as_ref().filter(|p| !p.is_done()) {
    // rust: let p = path.entity_pos_at(path.next, m.width());
    // rust: at = [p.x, p.y, p.z];
}
    // rust: face_point(m, at[0], at[2]);
    // rust: start_jumping(m);
}
}
    // rust: m.extra.flag = m.on_ground;
}

/// RabbitMoveControl.tick: wait on the ground and restore the last wanted speed in flight.
pub fn move_control(m: *mut Mob, w: *MobWorld) void {
}
    // rust: prepare_move(m);
    // rust: m.ground_move_tick(w, m.movement_speed());
}
pub fn prepare_move(m: *mut Mob) void {
}
    // rust: if m.ai.mov.speed_modifier > 0.0 {
    // rust: m.extra.vector[0] = if m.fluids.in_water {
    // rust: 1.5
    // rust: } else {
    // rust: m.ai.mov.speed_modifier
}
}
    // rust: if m.on_ground && !m.ai.jumping && !m.ai.jump {
    // rust: m.ai.mov.speed_modifier = 0.0;
    // rust: m.set_speed(0.0);
    // rust: } else if m.ai.mov.has_wanted() || m.ai.mov.operation == Operation::Jumping {
    // rust: m.ai.mov.speed_modifier = if m.fluids.in_water {
    // rust: 1.5
    // rust: } else {
    // rust: m.extra.vector[0]
}
}
}

/// RabbitJumpControl.tick: explicit jump requests do not wait for the landing cooldown.
pub fn jump_control(m: *mut Mob) void {
}
    // rust: if m.ai.jump {
    // rust: start_jumping(m);
    // rust: m.ai.jump = false;
}
}

/// Rabbit.aiStep runs after the living physics; the fifteenth tick still renders the hop.
pub fn post_tick(m: *mut Mob) void {
}
    // rust: for (ticks, duration) in [
    // rust: (JUMP_TICKS, JUMP_DURATION),
    // rust: (CLIENT_JUMP_TICKS, CLIENT_JUMP_DURATION),
    // rust: ] {
    // rust: if m.extra.ints[ticks] != m.extra.ints[duration] {
    // rust: m.extra.ints[ticks] += 1;
    // rust: } else if m.extra.ints[duration] != 0 {
    // rust: m.extra.ints[ticks] = 0;
    // rust: m.extra.ints[duration] = 0;
    // rust: if ticks == JUMP_TICKS {
    // rust: m.ai.jumping = false;
}
}
}
}

pub fn jump_scale(m: *Mob) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let step =
    // rust: m.ai.nav
    // rust: .path
    // rust: .as_ref()
    // rust: .filter(|p| !p.is_done())
    // rust: .is_some_and(|p| f64::from(p.next_node().y) > m.position.y + 0.5);
    // rust: let high =
    // rust: m.horizontal_collision || step || m.ai.jumping && m.ai.mov.wanted[1] > m.position.y + 0.5;
    // rust: let base = if high {
    // rust: 0.5
    // rust: } else if m.ai.mov.speed_modifier <= 0.6 {
    // rust: 0.2
    // rust: } else {
    // rust: 0.3
}
    // rust: base / 0.42
}

/// Rabbit.jumpFromGround: ordinary small hops, larger hops toward raised terrain.
pub fn jump(m: *mut Mob, w: *MobWorld) void {
}
    // rust: let power = m.jump_power_with(w, jump_scale(m));
    // rust: apply_jump(m, power);
}

pub fn jump_power(m: *Mob, block_factor: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.attrs.jump_strength as f32 * jump_scale(m) * block_factor + m.jump_boost_power()
}

pub fn apply_jump(m: *mut Mob, power: f32) void {
}
    // rust: if power > 1.0e-5 {
    // rust: m.velocity.y = f64::from(power).max(m.velocity.y);
}
    // rust: if m.ai.mov.speed_modifier > 0.0
    // rust: && m.velocity.x * m.velocity.x + m.velocity.z * m.velocity.z < 0.01
    // rust: {
    // rust: m.move_relative(
    // rust: 0.1,
    // rust: Vec3::new(0.0, if m.is_baby() { 0.5 } else { 1.5 }, 1.0),
    // rust: );
}
    // rust: hop_event(m);
    // rust: m.outbox.push(MobEvent::RabbitHop {
    // rust: mob: m.id,
    // rust: at: [m.position.x, m.position.y, m.position.z],
    // rust: });
}

/// Rabbit.handleEntityEvent(1): reset the counter without starting the clock early.
pub fn hop_event(m: *mut Mob) void {
}
    // rust: m.extra.ints[CLIENT_JUMP_DURATION] = 15;
    // rust: m.extra.ints[CLIENT_JUMP_TICKS] = 0;
}

    // rust: mod tests {
//     use super::*;
//     use crate::mobs::{
    // rust: Anim, Brain, Flags, MobType, Part, Species,
    // rust: anim::{self, Poses},
    // rust: body_anim,
    // rust: keyframes::Animation,
}
//     use serde_json::json;
//     use std::{collections::HashMap, sync::Arc};

pub fn rabbit() M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let model = Arc::new(Part::parse(
    // rust: "root",
    // rust: &json!({"children": {"head": {}, "left_hind_foot": {}}}),
    // rust: ));
    // rust: let kind = Arc::new(MobType {
    // rust: id: "minecraft:rabbit".into(),
    // rust: species: Species::Rabbit,
    // rust: width: 0.4,
    // rust: height: 0.5,
    // rust: eye_height: 0.4,
    // rust: category: "creature".into(),
    // rust: max_health: 3.0,
    // rust: speed: 0.3,
    // rust: flying_speed: 0.4,
    // rust: attack_damage: 0.0,
    // rust: attack_knockback: 0.0,
    // rust: follow_range: 16.0,
    // rust: step_height: 0.6,
    // rust: armor: 0.0,
    // rust: armor_toughness: 0.0,
    // rust: knockback_resistance: 0.0,
    // rust: jump_strength: 0.42,
    // rust: attributes: Arc::default(),
    // rust: item_stack_limits: Default::default(),
    // rust: gravity: 0.08,
    // rust: safe_fall_distance: 3.0,
    // rust: fall_damage_multiplier: 1.0,
    // rust: water_efficiency: 0.0,
    // rust: water_slowdown: 0.8,
    // rust: air_speed: 0.02,
    // rust: baby_scale: 0.5,
    // rust: head_rot_speed: 10.0,
    // rust: max_head_x_rot: 40.0,
    // rust: max_head_y_rot: 75.0,
    // rust: ambient_interval: 120,
    // rust: flags: Flags {
    // rust: animal: true,
    // rust: ..Default::default()
    // rust: },
    // rust: model,
    // rust: layers: Default::default(),
    // rust: texture: String::new(),
    // rust: brain: Brain::Passive,
    // rust: anim: Anim::Rabbit,
    // rust: sounds: [""; 3],
    // rust: step_sound: None,
    // rust: food: Arc::default(),
    // rust: tempt: Arc::default(),
    // rust: });
    // rust: Mob::new(1, kind, Vec3::ZERO, 0.0)
}
pub fn near(a: f64, b: f64) void {
}
    // rust: assert!((a - b).abs() < 1.0e-6, "{a} != {b}");
}

pub fn summoned_age_selects_the_baby_model_and_texture() void {
}
    // rust: let mut template = rabbit();
    // rust: let kind = Arc::make_mut(&mut template.kind);
    // rust: kind.texture = "entity/rabbit/rabbit_brown".into();
    // rust: kind.layers
    // rust: .insert("rabbit_baby#main".into(), kind.model.clone());
    // rust: let types = HashMap::from([(kind.id.clone(), template.kind.clone())]);
    // rust: for (age, baby) in [(-24000, true), (-1, true), (0, false), (6000, false)] {
    // rust: let (tag, _) = horizon_world::nbt::parse_snbt(&format!(
    // rust: "{{id:\"minecraft:rabbit\",Pos:[0.0d,0.0d,0.0d],Age:{age}}}"
    // rust: ))
    // rust: .unwrap();
    // rust: let m = crate::entity_nbt::mob_from_nbt(&tag, &types, 2, None).unwrap();
    // rust: assert_eq!(m.extra.age, age);
    // rust: assert_eq!(m.is_baby(), baby);
    // rust: assert_eq!(
    // rust: crate::mobs::render::body(&m),
    // rust: if baby {
    // rust: (
    // rust: "rabbit_baby#main".into(),
    // rust: "entity/rabbit/rabbit_brown_baby".into(),
    // rust: )
    // rust: } else {
    // rust: ("rabbit#main".into(), "entity/rabbit/rabbit_brown".into())
}
    // rust: );
}
}

pub fn registers_vanillas_goals_with_the_three_avoidances() void {
}
        // Rabbit.registerGoals: players 8, wolves 10, monsters 4 (#2780).
    // rust: let mut m = rabbit();
    // rust: register(&mut m);
    // rust: for name in [
    // rust: "Float",
    // rust: "Panic",
    // rust: "Breed",
    // rust: "Tempt",
    // rust: "RabbitAvoidEntityGoal",
    // rust: "Stroll",
    // rust: "LookAtPlayer",
    // rust: ] {
    // rust: assert!(m.ai.goals.has(name), "{name}");
}
    // rust: assert!(!m.ai.goals.has("RandomLookAround"));
}

pub fn love_ticks_survive_a_save() void {
}
        // Animal.addAdditionalSaveData / readAdditionalSaveData: "InLove" (#1396).
    // rust: let mut m = rabbit();
    // rust: m.extra.in_love = 570;
    // rust: let tag = crate::entity_nbt::mob_to_nbt(&m, [0, 0, 0, 1], None, None);
    // rust: assert_eq!(tag.get("InLove"), Some(&horizon_world::nbt::Tag::Int(570)));
    // rust: let types = HashMap::from([(m.kind.id.clone(), m.kind.clone())]);
    // rust: let back = crate::entity_nbt::mob_from_nbt(&tag, &types, 2, None).unwrap();
    // rust: assert_eq!(back.extra.in_love, 570);
}

pub fn landing_waits_then_real_hop_clock_moves_the_model() void {
}
    // rust: let mut m = rabbit();
    // rust: m.on_ground = true;
    // rust: m.ai.mov.set_wanted(0.0, 0.0, 5.0, 0.6);
    // rust: server_ai_step(&mut m, None);
    // rust: assert_eq!(m.extra.ints[MOVE_DELAY], 10);
    // rust: assert!(!m.ai.jumping);
    // rust: for _ in 0..9 {
    // rust: server_ai_step(&mut m, None);
}
    // rust: assert!(!m.ai.jumping);
    // rust: server_ai_step(&mut m, None);
    // rust: assert!(m.ai.jumping);
    // rust: assert_eq!(m.extra.ints[JUMP_DURATION], 15);
    // rust: assert_eq!(m.anim.states[0].started, None);
    // rust: apply_jump(&mut m, 0.2);
    // rust: post_tick(&mut m);
    // rust: m.age = 1;
    // rust: base_tick(&mut m);
    // rust: assert_eq!(m.anim.states[0].started, Some(1.0));
    // rust: let curve = Animation::parse(&json!({"length": 0.75, "looping": true,
    // rust: "bones": {"left_hind_foot": [{"target": "rotation", "keyframes": [[0,[0,0,0],[0,0,0],"linear"],[0.75,[1,0,0],[1,0,0],"linear"]]}]}}));
    // rust: let animations = HashMap::from([("RabbitAnimation.HOP".into(), curve)]);
    // rust: let mut poses = Poses::new(&m.kind.model);
    // rust: let state = anim::state(&m, 0.5);
    // rust: body_anim::rabbit(
    // rust: &mut poses,
    // rust: &state,
    // rust: &m.anim.states[0],
    // rust: &m.anim.states[1],
    // rust: &animations,
    // rust: );
    // rust: assert!(poses.get("left_hind_foot")[3] > 0.0);
    // rust: for _ in 1..15 {
    // rust: post_tick(&mut m);
}
    // rust: assert_eq!(m.extra.ints[JUMP_TICKS], 15);
    // rust: assert!(m.ai.jumping);
    // rust: post_tick(&mut m);
    // rust: base_tick(&mut m);
    // rust: assert!(!m.ai.jumping);
    // rust: assert_eq!(m.anim.states[0].started, None);
}

pub fn panic_and_explicit_requests_use_their_own_hop_timing() void {
}
    // rust: let mut m = rabbit();
    // rust: m.on_ground = true;
    // rust: m.ai.mov.set_wanted(0.0, 0.0, 5.0, 2.2);
    // rust: server_ai_step(&mut m, None);
    // rust: assert_eq!(m.extra.ints[MOVE_DELAY], 3);
    // rust: m.ai.jump = true;
    // rust: m.jump_control_tick();
    // rust: assert!(m.ai.jumping);
    // rust: assert!(!m.ai.jump);
    // rust: assert_eq!(m.extra.ints[MOVE_DELAY], 3);
    // rust: m.jump_control_tick();
    // rust: assert!(m.ai.jumping);
}

pub fn a_new_hop_preserves_a_running_clock_until_the_counter_finishes() void {
}
    // rust: let mut m = rabbit();
    // rust: m.anim.states[0].start(4.0);
    // rust: m.extra.ints[CLIENT_JUMP_TICKS] = 8;
    // rust: hop_event(&mut m);
    // rust: assert_eq!(m.anim.states[0].started, Some(4.0));
    // rust: assert_eq!(m.extra.ints[CLIENT_JUMP_TICKS], 0);
    // rust: assert_eq!(m.extra.ints[CLIENT_JUMP_DURATION], 15);
    // rust: post_tick(&mut m);
    // rust: m.age = 12;
    // rust: base_tick(&mut m);
    // rust: assert_eq!(m.anim.states[0].started, Some(4.0));
    // rust: assert!(m.outbox.is_empty());
}

pub fn deep_water_jump_requests_do_not_start_a_client_hop() void {
}
    // rust: let mut m = rabbit();
    // rust: m.fluids.in_water = true;
    // rust: m.fluids.water = 1.0;
    // rust: m.ai.jump = true;
    // rust: jump_control(&mut m);
    // rust: assert!(m.ai.jumping);
    // rust: assert_eq!(m.extra.ints[JUMP_DURATION], 15);
    // rust: post_tick(&mut m);
    // rust: base_tick(&mut m);
    // rust: assert_eq!(m.extra.ints[JUMP_TICKS], 1);
    // rust: assert_eq!(m.extra.ints[CLIENT_JUMP_DURATION], 0);
    // rust: assert!(m.anim.states[0].started.is_none());
    // rust: assert!(
    // rust: !m.outbox
    // rust: .iter()
    // rust: .any(|e| matches!(e, MobEvent::RabbitHop { .. }))
    // rust: );
    // rust: hop_event(&mut m);
    // rust: post_tick(&mut m);
    // rust: base_tick(&mut m);
    // rust: assert!(m.anim.states[0].started.is_some());
}

pub fn grounded_movement_waits_and_water_uses_its_hop_speed() void {
}
    // rust: let mut m = rabbit();
    // rust: m.on_ground = true;
    // rust: m.ai.mov.set_wanted(0.0, 0.0, 5.0, 0.6);
    // rust: prepare_move(&mut m);
    // rust: assert_eq!(m.ai.mov.speed_modifier, 0.0);
    // rust: assert_eq!(m.ai.zza, 0.0);
    // rust: m.ai.jumping = true;
    // rust: prepare_move(&mut m);
    // rust: assert_eq!(m.ai.mov.speed_modifier, 0.6);
    // rust: m.fluids.in_water = true;
    // rust: prepare_move(&mut m);
    // rust: assert_eq!(m.ai.mov.speed_modifier, 1.5);
    // rust: assert_eq!(m.extra.vector[0], 1.5);
    // rust: assert!(m.ai.nav.can_float);
    // rust: m.extra.flag = false;
    // rust: m.ai.mov.set_wanted(0.0, 0.0, 5.0, 2.2);
    // rust: server_ai_step(&mut m, None);
    // rust: assert_eq!(m.ai.mov.speed_modifier, 1.5);
    // rust: assert_eq!(m.extra.ints[MOVE_DELAY], 10);
}

pub fn jump_impulse_scales_strength_terrain_boost_and_baby_kick() void {
}
    // rust: let mut m = rabbit();
    // rust: m.ai.mov.speed_modifier = 0.6;
    // rust: near(f64::from(jump_power(&m, 1.0)), 0.2);
    // rust: m.ai.mov.speed_modifier = 2.2;
    // rust: near(f64::from(jump_power(&m, 1.0)), 0.3);
    // rust: m.horizontal_collision = true;
    // rust: near(f64::from(jump_power(&m, 1.0)), 0.5);
    // rust: m.attrs.jump_strength = 0.84;
    // rust: m.extra.effects.push(("minecraft:jump_boost", 100, 1));
    // rust: near(f64::from(jump_power(&m, 0.5)), 0.7);
    // rust: apply_jump(&mut m, 0.2);
    // rust: near(m.velocity.z, 0.1 / 3.25_f64.sqrt());
    // rust: near(m.velocity.y, 0.2 + 0.15 / 3.25_f64.sqrt());
    // rust: m.extra.age = -100;
    // rust: m.velocity = Vec3::ZERO;
    // rust: apply_jump(&mut m, 0.2);
    // rust: near(m.velocity.z, 0.1 / 1.25_f64.sqrt());
    // rust: near(m.velocity.y, 0.2 + 0.05 / 1.25_f64.sqrt());
    // rust: assert_eq!(m.extra.ints[CLIENT_JUMP_DURATION], 15);
}

pub fn idle_timeout_hop_priority_no_ai_and_leash_follow_tick_order() void {
}
    // rust: let mut m = rabbit();
    // rust: m.age = 7;
    // rust: m.extra.ints[IDLE_TIMEOUT] = 0;
    // rust: m.extra.ints[CLIENT_JUMP_TICKS] = 2;
    // rust: base_tick(&mut m);
    // rust: assert_eq!(m.anim.states[1].started, Some(7.0));
    // rust: assert!(m.anim.states[0].started.is_none());
    // rust: base_tick(&mut m);
    // rust: assert_eq!(m.anim.states[0].started, Some(7.0));
    // rust: assert!(m.anim.states[1].started.is_none());
    // rust: m.extra.ints[CLIENT_JUMP_TICKS] = 0;
    // rust: m.extra.ints[IDLE_TIMEOUT] = 0;
    // rust: m.no_ai = true;
    // rust: base_tick(&mut m);
    // rust: assert_eq!(m.extra.ints[IDLE_TIMEOUT], -1);
    // rust: assert!(m.anim.states[1].started.is_none());
    // rust: m.no_ai = false;
    // rust: base_tick(&mut m);
    // rust: assert!(m.anim.states[1].started.is_some());
    // rust: m.extra.leash = Some(super::super::leash::Holder::Knot([0, 0, 0]));
    // rust: base_tick(&mut m);
    // rust: assert!(m.anim.states[1].started.is_none());
}
}
    // rust: mod attack_sound_tests {
//     use super::*;
//     use crate::mobs::sensor_scan_tests::kind;

pub fn rabbit(variant: u8) M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut kind = kind();
    // rust: let k = std::sync::Arc::make_mut(&mut kind);
    // rust: k.id = "minecraft:rabbit".into();
    // rust: k.species = Species::Rabbit;
    // rust: let mut m = Mob::new(1, kind, Vec3::new(2.5, 64.0, -1.5), 0.0);
    // rust: m.extra.variant = variant;
    // rust: m
}

    /// `Rabbit.playAttackSound`: the killer bunny's bite at volume 1 and
    /// `(nextFloat - nextFloat) * 0.2 + 1`, and nothing from another rabbit.
pub fn the_killer_bunny_bites_with_its_own_sound() void {
}
    // rust: let mut m = rabbit(EVIL);
    // rust: let mut probe = m.random.clone();
    // rust: let mut events = Vec::new();
    // rust: attack_sound(&mut m, &mut events);
    // rust: let want = (probe.next_float() - probe.next_float()) * 0.2 + 1.0;
    // rust: assert!(
    // rust: matches!(
    // rust: events.as_slice(),
    // rust: [MobEvent::Sound("entity.rabbit.attack", [2.5, 64.0, -1.5], 1.0, p)] if *p == want
    // rust: ),
    // rust: "{events:?}, pitch {want}"
    // rust: );
        // A silent killer bunny still pays the pitch's two draws, then says nothing.
    // rust: let mut quiet = rabbit(EVIL);
    // rust: quiet.silent = true;
    // rust: let mut probe = quiet.random.clone();
    // rust: let _ = (probe.next_float(), probe.next_float());
    // rust: let mut events = Vec::new();
    // rust: attack_sound(&mut quiet, &mut events);
    // rust: assert!(events.is_empty(), "{events:?}");
    // rust: assert_eq!(
    // rust: quiet.random.next_int_bound(1000).unwrap_or(0),
    // rust: probe.next_int_bound(1000).unwrap_or(0),
    // rust: "two draws, silent or not"
    // rust: );
        // A baby killer bunny keeps the plain 1.0 base: the pitch is its own,
        // not the 1.5 a baby's `getVoicePitch` would give.
    // rust: let mut baby = rabbit(EVIL);
    // rust: baby.extra.age = -24_000;
    // rust: let mut probe = baby.random.clone();
    // rust: let mut events = Vec::new();
    // rust: attack_sound(&mut baby, &mut events);
    // rust: let want = (probe.next_float() - probe.next_float()) * 0.2 + 1.0;
    // rust: assert!(
    // rust: matches!(events.as_slice(), [MobEvent::Sound(_, _, 1.0, p)] if *p == want),
    // rust: "{events:?}, pitch {want}"
    // rust: );
        // Any other rabbit: no sound and no draw.
    // rust: let mut plain = rabbit(0);
    // rust: let mut probe = plain.random.clone();
    // rust: let mut events = Vec::new();
    // rust: attack_sound(&mut plain, &mut events);
    // rust: assert!(events.is_empty(), "{events:?}");
    // rust: assert_eq!(
    // rust: plain.random.next_int_bound(1000).unwrap_or(0),
    // rust: probe.next_int_bound(1000).unwrap_or(0),
    // rust: "a brown rabbit draws nothing"
    // rust: );
}
}
