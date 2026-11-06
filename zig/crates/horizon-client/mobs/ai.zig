//! Transpiled from Horizon Rust crate
//! Module: horizon-client_ai
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The per-tick mob update in vanilla order (`Entity.baseTick`,
//! `LivingEntity.baseTick/tick/aiStep`, `Mob.serverAiStep`) and the
//! dispatch to each species family's goals and special behaviour.
// use super::{
    // rust: Damage, DamageKind, Mob, MobEvent, MobWorld, Species, Who, aquatic,
    // rust: control::{BodyRotation, LookControl, MoveControl},
    // rust: farm,
    // rust: goals::{Cx, GoalSelector},
    // rust: hostile,
    // rust: nav::Navigation,
    // rust: path::{PATH_TYPES, Path},
    // rust: undead,
}
// use crate::blocks::Fluid;
// use crate::breathing::{Breath, breathe, drown};
// use horizon_core::{
    // rust: geometry::{Aabb, ShapeOp, Vec3, VoxelShape},
    // rust: random::{LegacyRandom, RandomSource},
}

// use crate::powder_snow::particle_velocity as powder_snow_particle_velocity;

/// The inside-block effects of fire and lava (`InsideBlockEffectType`
/// FIRE_IGNITE and LAVA_IGNITE): ignite, then hurt.
pub fn block_contact_damage(m: *mut Mob, w: *MobWorld, fire: f32) void {
}
    // rust: if fire > 0.0 && !m.kind.flags.fire_immune {
    // rust: let multiplier = m.burning_time();
    // rust: m.fire_ticks = crate::motion::environment::ignite_contact(
    // rust: m.fire_ticks,
    // rust: false,
    // rust: &mut m.random,
    // rust: multiplier,
    // rust: );
    // rust: m.damage(fire, Damage::of(DamageKind::InFire));
}
    // rust: if m.fluids.in_lava && !m.kind.flags.fire_immune {
    // rust: m.ignite_for_ticks(300);
    // rust: m.damage(4.0, Damage::of(DamageKind::Lava));
}
    // Entity.applyEffectsFromBlocks: rain puts the fire out afterwards.
    // rust: if m.fire_ticks > 0 && in_rain(m, w) {
    // rust: m.fire_ticks = 0;
}
}

pub const Ai = struct {
    /// `Mob.homePosition` and `homeRadius`: where a restricted mob stays
    /// (a lead's holder, a happy ghast's float area).
    home: Option<([i32,
    /// Mob keeps homePosition even when clearHome makes homeRadius -1.
    /// Active homes still use `home`; this only retains its hidden position.
    last_home_position: [i32,
    goals: GoalSelector,
    targets: GoalSelector,
    nav: Navigation,
    // rust: pub(super) navigation_redirect: Option<Box<super::nav::Redirect>>,
    mov: MoveControl,
    look: LookControl,
    body: BodyRotation,
    /// JumpControl.jump (requested this tick).
    jump: bool,
    /// LivingEntity.jumping
    jumping: bool,
    no_jump_delay: i32,
    xxa: f32,
    yya: f32,
    zza: f32,
    speed: f32,
    target: ?Who,
    last_hurt_by: ?Who,
    last_hurt_by_time: i32,
    /// Ticks left during which kills count as player kills.
    last_hurt_by_player: i32,
    no_action_time: i32,
    aggressive: bool,
    panicking: bool,
    malus: [?f32,
    /// A path computed in canUse and consumed by start.
    pending_path: ?Path,
    /// Sensing: line-of-sight results cached for one tick.
    seen_cache: Vec<(Who,
    /// Swing animation progress (attackAnim) and ticks.
    swing_time: i32,
    swinging: bool,
    /// The current swing's `SwingDescription.durationTicks`; 0 is the default 6.
    swing_duration: i32,
    /// Walked distance and the next footstep.
    steps: super::living::Steps,
};
    // rust: impl Ai {
    /// `Mob.getHomePosition`, including the position retained by clearHome.
pub fn home_position(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.home.map_or(self.last_home_position, |(pos, _)| pos)
}
    /// Adopt only the two persistent home fields after loading Mob data.
pub fn restore_home(self: *Self, pos: [i32; 3], radius: i32) void {
}
    // rust: self.last_home_position = pos;
    // rust: self.home = (radius != -1).then_some((pos, radius));
}
    /// `Mob.clearHome`: clear the radius, retaining the position.
pub fn clear_home(self: *Self) void {
}
    // rust: self.last_home_position = self.home_position();
    // rust: self.home = None;
}
}
    // rust: impl Mob {
    /// `LivingEntity.getCurrentSwingDuration`: 6 ticks unless a swing set its own.
pub fn swing_duration(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.ai.swing_duration > 0 {
    // rust: self.ai.swing_duration
    // rust: } else {
    // rust: 6
}
}
    /// `SwingState.startIfAble`: a swing past the first half of the current
    /// one restarts it.
pub fn start_swing(self: *Self, duration: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let half = self.swing_duration() / 2;
    // rust: if self.ai.swinging && self.ai.swing_time >= 0 && self.ai.swing_time < half {
    // rust: return false;
}
    // rust: self.ai.swing_time = -1;
    // rust: self.ai.swinging = true;
    // rust: self.ai.swing_duration = duration.max(1);
    // rust: true
}
    /// LivingEntity.swing
pub fn swing(self: *Self) void {
}
    // rust: if self.start_swing(6) {
    // rust: self.extra.swing_right_arm = None;
    // rust: self.extra.swing_stab = false;
}
}
    /// `LivingEntity.swing(hand, animation, false)` for a swing of `duration`
    /// ticks (`getModifiedSwingDuration`): the arm is `hand.asArm(mainArm)`.
pub fn swing_hand(self: *Self, off_hand: bool, duration: i32) void {
}
    // rust: if self.start_swing(duration) {
    // rust: self.extra.swing_right_arm = Some(!off_hand != self.main_arm_left());
    // rust: self.extra.swing_stab = false;
}
}
    /// `swing_hand` for a swing of `animation`, lengthened or shortened by
    /// this mob's haste, conduit power or mining fatigue
    /// (`LivingEntity.getModifiedSwingDuration`).
    // rust: pub fn swing_hand_modified(
    // rust: &mut self,
    // rust: off_hand: bool,
    // rust: animation: crate::first_person::SwingAnimation,
    // rust: ) {
    // rust: let amplifier = |id: &str| self.extra.effects.iter().find(|e| e.0 == id).map(|e| e.2);
    // rust: let dig_speed = amplifier("minecraft:haste").max(amplifier("minecraft:conduit_power"));
    // rust: let fatigue = amplifier("minecraft:mining_fatigue");
    // rust: let duration = crate::first_person::swing_duration(animation, dig_speed, fatigue);
    // rust: if self.start_swing(duration) {
    // rust: self.extra.swing_right_arm = Some(!off_hand != self.main_arm_left());
    // rust: self.extra.swing_stab = animation.kind == 2;
}
}
}
/// The module implementing a species' behaviour.
pub const Family = enum {
    Farm,
    Undead,
    Hostile,
    Aquatic,
    Generic,
    /// No goals at all (Giant).
    Inert,
    Witch,
    Enderman,
    Tame,
    /// Blazes and ghasts.
    Nether,
    Golem,
    Illager,
    /// Piglins, brutes, hoglins and zoglins.
    Piglin,
    Equine,
    Phantom,
    /// Slimes and magma cubes.
    Cube,
    Guardian,
    Shulker,
    Vex,
    Ravager,
    Wither,
    Allay,
    Villager,
    Trader,
    Breeze,
    Sniffer,
    HappyGhast,
    Warden,
    Creaking,
    /// Nautili and zombie nautili.
    Nautilus,
    Strider,
    Bat,
    Bee,
    Panda,
    PolarBear,
};
pub fn family(s: Species) F {
    // Implementation ported from Horizon
    return undefined;
}
//     use Species as S;
    // rust: match s {
    // rust: S::Pig | S::Cow | S::Mooshroom | S::Sheep | S::Chicken => Family::Farm,
    // rust: S::Zombie
    // rust: | S::Husk
    // rust: | S::Drowned
    // rust: | S::ZombieVillager
    // rust: | S::Skeleton
    // rust: | S::Stray
    // rust: | S::Bogged
    // rust: | S::Parched
    // rust: | S::WitherSkeleton
    // rust: | S::ZombifiedPiglin => Family::Undead,
    // rust: S::Creeper | S::Spider | S::CaveSpider | S::Silverfish | S::Endermite => Family::Hostile,
    // rust: S::Squid
    // rust: | S::GlowSquid
    // rust: | S::Cod
    // rust: | S::Tadpole
    // rust: | S::Salmon
    // rust: | S::TropicalFish
    // rust: | S::Pufferfish
    // rust: | S::Dolphin
    // rust: | S::Axolotl => Family::Aquatic,
    // rust: S::Giant => Family::Inert,
    // rust: S::Witch => Family::Witch,
    // rust: S::Wolf | S::Cat => Family::Tame,
    // rust: S::Blaze | S::Ghast => Family::Nether,
    // rust: S::IronGolem | S::SnowGolem | S::CopperGolem => Family::Golem,
    // rust: S::Pillager | S::Vindicator | S::Evoker | S::Illusioner => Family::Illager,
    // rust: S::Vex => Family::Vex,
    // rust: S::Ravager => Family::Ravager,
    // rust: S::Wither => Family::Wither,
    // rust: S::Allay => Family::Allay,
    // rust: S::Creaking => Family::Creaking,
    // rust: S::Villager => Family::Villager,
    // rust: S::WanderingTrader => Family::Trader,
    // rust: S::Breeze => Family::Breeze,
    // rust: S::Sniffer => Family::Sniffer,
    // rust: S::HappyGhast => Family::HappyGhast,
    // rust: S::Piglin | S::PiglinBrute | S::Hoglin | S::Zoglin => Family::Piglin,
    // rust: S::Horse
    // rust: | S::Donkey
    // rust: | S::Mule
    // rust: | S::SkeletonHorse
    // rust: | S::ZombieHorse
    // rust: | S::Camel
    // rust: | S::CamelHusk
    // rust: | S::Llama
    // rust: | S::TraderLlama => Family::Equine,
    // rust: S::Nautilus | S::ZombieNautilus => Family::Nautilus,
    // rust: S::Phantom => Family::Phantom,
    // rust: S::Enderman => Family::Enderman,
    // rust: S::Slime | S::MagmaCube | S::SulfurCube => Family::Cube,
    // rust: S::Guardian | S::ElderGuardian => Family::Guardian,
    // rust: S::Warden => Family::Warden,
    // rust: S::Shulker => Family::Shulker,
    // rust: S::Strider => Family::Strider,
    // rust: S::Bat => Family::Bat,
    // rust: S::Bee => Family::Bee,
    // rust: S::Panda => Family::Panda,
    // rust: S::PolarBear => Family::PolarBear,
    // rust: _ => Family::Generic,
}
}
/// The `setPathfindingMalus` calls of the vanilla constructors, base classes
/// first: the species' own register may still change them.
pub fn constructor_maluses(m: *mut Mob) void {
}
//     use super::path::PathType as P;
//     use Species as S;
    // rust: let s = m.species();
    // `Animal()`: no walking through fire, and a wide berth around it.
    // rust: let animal = matches!(
    // rust: s,
    // rust: S::Armadillo
    // rust: | S::Axolotl
    // rust: | S::Bee
    // rust: | S::Camel
    // rust: | S::CamelHusk
    // rust: | S::Cat
    // rust: | S::Chicken
    // rust: | S::Cow
    // rust: | S::Donkey
    // rust: | S::Fox
    // rust: | S::Frog
    // rust: | S::Goat
    // rust: | S::HappyGhast
    // rust: | S::Hoglin
    // rust: | S::Horse
    // rust: | S::Llama
    // rust: | S::Mule
    // rust: | S::Mooshroom
    // rust: | S::Nautilus
    // rust: | S::Ocelot
    // rust: | S::Panda
    // rust: | S::Parrot
    // rust: | S::Pig
    // rust: | S::PolarBear
    // rust: | S::Rabbit
    // rust: | S::Sheep
    // rust: | S::SkeletonHorse
    // rust: | S::Sniffer
    // rust: | S::Strider
    // rust: | S::TraderLlama
    // rust: | S::Turtle
    // rust: | S::Wolf
    // rust: | S::ZombieHorse
    // rust: | S::ZombieNautilus
    // rust: );
    // `AbstractVillager()`, `AbstractPiglin()` and `CopperGolem()` say the same.
    // rust: if animal
    // rust: || matches!(
    // rust: s,
    // rust: S::Villager | S::WanderingTrader | S::Piglin | S::PiglinBrute | S::CopperGolem
    // rust: )
    // rust: {
    // rust: m.set_malus(P::FireInNeighbor, 16.0);
    // rust: m.set_malus(P::Fire, -1.0);
}
    // rust: match s {
    // rust: S::Fox => {
    // rust: m.set_malus(P::DamagingInNeighbor, 0.0);
    // rust: m.set_malus(P::Damaging, 0.0);
}
    // rust: S::Parrot => {
    // rust: m.set_malus(P::FireInNeighbor, -1.0);
    // rust: m.set_malus(P::Fire, -1.0);
    // rust: m.set_malus(P::Cocoa, -1.0);
}
    // rust: S::Frog => {
    // rust: m.set_malus(P::Water, 4.0);
    // rust: m.set_malus(P::Trapdoor, -1.0);
}
    // rust: S::Goat | S::Wolf => {
    // rust: m.set_malus(P::PowderSnow, -1.0);
    // rust: m.set_malus(P::OnTopOfPowderSnow, -1.0);
}
    // rust: S::CopperGolem => m.set_malus(P::DamagingInNeighbor, 16.0),
    // rust: S::Blaze => {
    // rust: m.set_malus(P::Water, -1.0);
    // rust: m.set_malus(P::Lava, 8.0);
    // rust: m.set_malus(P::FireInNeighbor, 0.0);
    // rust: m.set_malus(P::Fire, 0.0);
}
    // rust: S::ZombifiedPiglin | S::WitherSkeleton => m.set_malus(P::Lava, 8.0),
    // rust: _ => {}
}
}
pub fn register(m: *mut Mob) void {
}
    // rust: constructor_maluses(m);
    // Raider subclasses call super.registerGoals() first.
    // rust: super::raider::register(m);
    // rust: match family(m.species()) {
    // rust: Family::Farm => farm::register(m),
    // rust: Family::Undead => undead::register(m),
    // rust: Family::Hostile => hostile::register(m),
    // rust: Family::Aquatic => aquatic::register(m),
        // Turtle.registerGoals has its own list, none of the generic goals.
    // rust: Family::Generic if m.species() == Species::Turtle => super::turtle::register(m),
    // rust: Family::Generic if m.species() == Species::Armadillo => super::armadillo::register(m),
    // rust: Family::Generic if m.species() == Species::Frog => super::frog::register(m),
    // rust: Family::Generic if m.species() == Species::Fox => super::fox::register(m),
    // rust: Family::Generic if m.species() == Species::Parrot => super::parrot::register(m),
    // rust: Family::Generic if m.species() == Species::Rabbit => super::rabbit::register(m),
    // rust: Family::Generic if m.species() == Species::Ocelot => super::tame::register_ocelot(m),
    // rust: Family::Generic => {
    // rust: generic(m);
    // rust: if m.species() == Species::Frog {
                // `Frog()`: SmoothSwimmingMoveControl(85, 10, 0.02, 0.1, true).
                // The speed attribute is 1.0, so the controller's scaling is
                // what keeps a frog at a walking pace on land.
    // rust: m.ai.mov.kind = super::control::MoveKind::SmoothSwimming {
    // rust: max_turn_x: 85.0,
    // rust: max_turn_y: 10.0,
    // rust: in_water: 0.02,
    // rust: outside: 0.1,
    // rust: gravity: true,
}
}
    // rust: if m.species() == Species::Goat {
    // rust: super::goat::register(m);
}
}
    // rust: Family::Inert => {}
    // rust: Family::Witch => super::witch::register(m),
    // rust: Family::Tame if m.species() == Species::Cat => super::tame::register_cat(m),
    // rust: Family::Tame => super::tame::register(m),
    // rust: Family::Nether if m.species() == Species::Ghast => super::nether::register_ghast(m),
    // rust: Family::Nether => super::nether::register_blaze(m),
    // rust: Family::Golem if m.species() == Species::IronGolem => super::golem::register_iron(m),
    // rust: Family::Golem if m.species() == Species::CopperGolem => super::copper_golem::register(m),
    // rust: Family::Golem => super::golem::register_snow(m),
    // rust: Family::Illager if m.species() == Species::Pillager => super::illager::register_pillager(m),
    // rust: Family::Illager if m.species() == Species::Evoker => super::illager::register_evoker(m),
    // rust: Family::Illager if m.species() == Species::Illusioner => super::illusioner::register(m),
    // rust: Family::Illager => super::illager::register_vindicator(m),
    // rust: Family::Equine => super::equine::register(m),
    // rust: Family::Phantom => super::phantom::register(m),
    // rust: Family::Piglin => match m.species() {
    // rust: Species::Piglin => super::piglin::register_piglin(m),
    // rust: Species::PiglinBrute => super::piglin::register_brute(m),
    // rust: Species::Hoglin => super::piglin::register_hoglin(m),
    // rust: _ => super::piglin::register_zoglin(m),
    // rust: },
    // rust: Family::Enderman => super::enderman::register(m),
    // rust: Family::Cube => super::cube::register(m),
    // rust: Family::Guardian => super::guardian::register(m),
    // rust: Family::Shulker => super::shulker::register(m),
    // rust: Family::Vex => super::vex::register(m),
    // rust: Family::Ravager => super::ravager::register(m),
    // rust: Family::Wither => super::wither::register(m),
    // rust: Family::Allay => super::allay::register(m),
    // rust: Family::Villager => super::villager::register(m),
    // rust: Family::Trader => super::trader::register(m),
    // rust: Family::Breeze => super::breeze::register(m),
    // rust: Family::Sniffer => super::sniffer::register(m),
    // rust: Family::HappyGhast => super::happy_ghast::register(m),
    // rust: Family::Warden => super::warden::register(m),
    // rust: Family::Creaking => super::creaking::register(m),
    // rust: Family::Nautilus => super::nautilus::register(m),
    // rust: Family::Strider => super::strider::register(m),
    // rust: Family::Bat => super::bat::register(m),
    // rust: Family::Bee => super::bee::register(m),
    // rust: Family::Panda => super::panda::register(m),
    // rust: Family::PolarBear => super::polar_bear::register(m),
}
    // rust: native_register_goals(m);
    // FloatGoal's constructor lets the navigation float, as do the
    // constructors of these brain-driven and flying mobs. A floater rises
    // 0.04 a tick in Mob.jumpInLiquid, the others 0.3 (the bounce of #542).
    // rust: if m.ai.goals.has("Float")
    // rust: || matches!(
    // rust: m.species(),
    // rust: Species::Allay
    // rust: | Species::Armadillo
    // rust: | Species::Camel
    // rust: | Species::Goat
    // rust: | Species::Parrot
    // rust: | Species::Wither
    // rust: )
    // rust: {
    // rust: m.ai.nav.can_float = true;
}
}
/// A new mob's goals (`Mob.registerGoals`): `mob.ai.goals` (vanilla's
/// `goalSelector`) and `mob.ai.targets` (`targetSelector`) hold the goals of
/// its species, which for a mod's type is its template's. Clear them to
/// replace them, as a class whose `registerGoals` skips `super`'s, or add
/// yours with `GoalSelector::add(priority, goal)`. Each mob gets its own
/// goals, so a goal's fields are that mob's state while it lives (for state
/// that is saved, see attachments on `Holder::Entity(mob.id)`). Asked for
/// every mob Horizon makes, a client's copies of a server's mobs included,
/// before its saved data is read; goals tick only where the mob's AI runs.
/// `goals::Float` keeps the navigation floating, as FloatGoal's
/// constructor does. API @API:register_goals@.
pub fn native_register_goals(mob: *mut Mob) void {
}
    // rust: crate::native_client_hooks::register_goals(mob);
}
/// Mob.tick additions that run before the entity tick (cube/creeper fuses, puffing).
pub fn pre_tick(m: *mut Mob, w: *MobWorld, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: if m.species() == Species::SulfurCube {
        // SulfurCube.tick calls tickFuse before super.tick, outside serverAiStep.
    // rust: super::sulfur_cube::tick_fuse(m, events);
}
    // rust: if m.species() == Species::Wither && m.alive() {
    // rust: super::wither::steer(m);
}
    // rust: if m.species() == Species::Breeze {
    // rust: super::breeze::tick(m, w, events);
}
    // rust: match family(m.species()) {
    // rust: Family::Hostile => {
    // rust: if m.species() == Species::Creeper {
    // rust: hostile::creeper_tick(m, events)
}
}
    // rust: Family::Aquatic => aquatic::tick(m, events),
    // rust: _ => {}
}
}
/// Move controls implemented by the species (MoveKind::Custom).
pub fn custom_move_control(m: *mut Mob, w: *MobWorld, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: if m.species() == Species::Drowned {
    // rust: return undead::drowned_move_control(m, w);
}
    // rust: if m.species() == Species::Ghast {
    // rust: return super::nether::ghast_move_control(m, w);
}
    // rust: if m.species() == Species::HappyGhast {
    // rust: return super::happy_ghast::move_control(m, w);
}
    // rust: if m.species() == Species::Phantom {
    // rust: return super::phantom::move_control(m);
}
    // rust: if family(m.species()) == Family::Guardian {
    // rust: return super::guardian::move_control(m);
}
    // rust: if m.species() == Species::Vex {
    // rust: return super::vex::move_control(m);
}
    // rust: match family(m.species()) {
    // rust: Family::Aquatic => aquatic::fish_move_control(m),
    // rust: Family::Cube => super::cube::move_control(m, events),
    // rust: _ => {}
}
}
/// A fallback for species without bespoke goals yet: animals stroll and
/// panic, monsters hunt the player in melee.
pub fn generic(m: *mut Mob) void {
}
//     use super::goals::*;
    // rust: let hostile = m.hostile();
    // rust: let g = &mut m.ai.goals;
    // rust: if hostile {
    // rust: g.add(1, Float);
    // rust: g.add(2, MeleeAttack::new(1.0, false));
    // rust: g.add(5, Stroll::avoiding_water(0.8));
    // rust: g.add(6, LookAtPlayer::new(8.0));
    // rust: g.add(6, RandomLookAround::default());
    // rust: m.ai.targets.add(1, HurtByTarget::new());
    // rust: m.ai.targets.add(2, NearestTarget::player(true));
    // rust: } else {
    // rust: if m.kind.species == Species::Goat {
            // GoatAi's idle and core behaviours (the ram and long jump
            // activities are not here): panic 2.0, AnimalMakeLove, tempting
            // with goat_food and baby follow at 1.25, then stroll.
    // rust: g.add(0, Float);
    // rust: g.add(1, Panic::new(2.0));
    // rust: g.add(2, Breed::new(1.0));
    // rust: g.add(3, Tempt::new(1.25, m.kind.food.clone(), false));
    // rust: g.add(4, FollowParent::new(1.25));
    // rust: g.add(5, Stroll::avoiding_water(1.0));
    // rust: g.add(6, LookAtPlayer::new(6.0));
    // rust: g.add(7, RandomLookAround::default());
    // rust: return;
}
    // rust: g.add(0, Float);
    // rust: g.add(1, Panic::new(1.25));
    // rust: g.add(5, Stroll::avoiding_water(1.0));
    // rust: g.add(6, LookAtPlayer::new(6.0));
    // rust: g.add(7, RandomLookAround::default());
    // rust: if m.kind.species == Species::Armadillo {
            // Armadillo's constructor: pickNextScuteDropTime.
    // rust: m.extra.egg_time = next_scute_time(m);
}
}
}
/// Subclasses of `net.minecraft.world.entity.monster.Monster`.
pub fn is_monster(s: Species) b {
    // Implementation ported from Horizon
    return undefined;
}
//     use Species as S;
    // rust: matches!(
    // rust: s,
    // rust: S::Zombie
    // rust: | S::Husk
    // rust: | S::Drowned
    // rust: | S::ZombieVillager
    // rust: | S::ZombifiedPiglin
    // rust: | S::Giant
    // rust: | S::Skeleton
    // rust: | S::Stray
    // rust: | S::Bogged
    // rust: | S::Parched
    // rust: | S::WitherSkeleton
    // rust: | S::Creeper
    // rust: | S::Spider
    // rust: | S::CaveSpider
    // rust: | S::Enderman
    // rust: | S::Endermite
    // rust: | S::Silverfish
    // rust: | S::Witch
    // rust: | S::Pillager
    // rust: | S::Vindicator
    // rust: | S::Evoker
    // rust: | S::Illusioner
    // rust: | S::Ravager
    // rust: | S::Vex
    // rust: | S::Piglin
    // rust: | S::PiglinBrute
    // rust: | S::Zoglin
    // rust: | S::Blaze
    // rust: | S::Guardian
    // rust: | S::ElderGuardian
    // rust: | S::Breeze
    // rust: | S::Creaking
    // rust: | S::Warden
    // rust: | S::Wither
    // rust: )
}
/// One full entity tick. Returns false when the mob is gone.
/// `Mob.getTarget` / `Mob.setTarget` (`asValidTarget`): a player in creative
/// or spectator mode is never a mob's target, however the target was set (an
/// alert from another mob included). A `NeutralMob` angry at that player stops
/// being angry (`NeutralMob.updatePersistentAnger`).
pub fn drop_invalid_player_target(m: *mut Mob, w: *MobWorld) void {
}
    // rust: if m.ai.target == Some(Who::Player)
    // rust: && w.player.as_ref().is_some_and(|p| p.creative || p.spectator)
    // rust: {
    // rust: m.ai.target = None;
    // rust: if matches!(m.species(), Species::ZombifiedPiglin | Species::IronGolem) {
    // rust: m.extra.anger = 0;
}
}
}
    // rust: pub fn tick(
    // rust: m: &mut Mob,
    // rust: w: &MobWorld,
    // rust: level_random: &mut LegacyRandom,
    // rust: events: &mut Vec<MobEvent>,
    // rust: ) -> bool {
    // rust: if m.removed {
    // rust: return false;
}
    // ServerLevel.tick checks despawning before ticking the entity.
    // rust: if !check_despawn(m, w) {
    // rust: m.removed = true;
    // rust: return false;
}
    // `Entity.computeSpeed`: what it moved in the last tick.
    // rust: let known_speed = m.position.subtract(m.previous);
    // rust: m.previous = m.position;
    // rust: m.previous_yaw = m.yaw;
    // rust: m.previous_body_yaw = m.body_yaw;
    // rust: m.previous_head_yaw = m.head_yaw;
    // rust: m.previous_head_pitch = m.head_pitch;
    // rust: m.previous_swell = m.swell;
    // rust: m.anim.begin_tick();
    // rust: m.age += 1;
    // rust: m.ai.seen_cache.clear();
    // rust: if m.ai.last_hurt_by_player > 0 {
    // rust: m.ai.last_hurt_by_player -= 1;
}
    // rust: drop_invalid_player_target(m, w);
    // Mob.tick pre-update hooks (Creeper.tick swells before super.tick).
    // rust: pre_tick(m, w, events);
    // rust: if m.removed {
    // rust: return false;
}
    // rust: if m.species() == Species::ZombieVillager {
        // ZombieVillager.tick counts the cure down before super.tick, with
        // or without AI (NoAI only skips serverAiStep).
    // rust: super::zombie_villager::step(
    // rust: m,
    // rust: &mut Cx {
    // rust: w,
    // rust: lr: level_random,
    // rust: events,
    // rust: },
    // rust: );
}
    // rust: super::warden::pre_tick(m, w, events);
    // rust: if m.species() == Species::Strider {
    // rust: super::strider::pre_tick(m, w, events);
}
    // rust: base_tick(m, w, events);
    // rust: if m.species() == Species::Rabbit {
    // rust: super::rabbit::base_tick(m);
}
    // rust: if m.death_time >= super::creaking::death_limit(m) {
        // Creaking.tickDeath: a heart's creaking crumbles away.
    // rust: if super::creaking::is_creaking(m) && super::creaking::tearing_down(m) {
    // rust: super::creaking::tear_down(m, events);
}
    // rust: return false;
}
    // LivingEntity.tick: updatingUsingItem, the stab of a spear in use.
    // rust: if m.alive() {
    // rust: super::spear_use::update_using_item(m, w, known_speed, events);
}
    // LivingEntity.tick: a sleeper whose bed is gone stands up before
    // aiStep, with or without AI.
    // rust: if super::villager::sleeping(m)
    // rust: && super::villager::sleeping_pos(m)
    // rust: .filter(|p| w.block_name(p[0], p[1], p[2]).ends_with("_bed"))
    // rust: .is_none()
    // rust: {
    // rust: super::villager::stop_sleeping(m, w, events);
    // rust: super::villager_brain::woken(m, w.game_time);
}
    // rust: if m.no_ai {
    // rust: reset_effect_fall_distance(m);
        // Mob.aiStep still runs without AI (only serverAiStep is skipped),
        // so undead still burn in daylight and the endermite's life keeps
        // counting.
    // rust: burn_undead(m, w, events);
    // rust: if m.species() == Species::Endermite {
    // rust: endermite_lifetime(m);
}
        // AbstractHorse.aiStep (it overrides LivingEntity.aiStep, which NoAI
        // doesn't skip) and AbstractHorse.tick: a NoAI horse still swishes
        // its tail before super.aiStep, then heals, grazes and runs its
        // stand counter and animations.
    // rust: let horse = super::equine::is_equine(m.species())
    // rust: && !super::camel::is_camel(m.species())
    // rust: && !super::llama::is_llama(m.species());
    // rust: if horse {
    // rust: super::equine::tail_tick(m);
}
    // rust: ageable_step(m, w, level_random, events);
    // rust: animal_step(m, events);
    // rust: if m.species() == Species::Chicken {
    // rust: farm::chicken_egg_step(m, events);
}
    // rust: if m.species() == Species::Allay {
    // rust: super::allay::passive_heal(m);
    // rust: super::allay::update_duplication_cooldown(m);
}
    // rust: if horse {
    // rust: super::equine::ai_step(m, w, events);
}
        // Ravager.aiStep runs outside serverAiStep: NoAI still advances
        // attack/stun/roar, including the stun-to-roar transition.
    // rust: if m.species() == Species::Ravager {
    // rust: super::ravager::ai_step(m, w, events);
}
    // rust: if m.species() == Species::Pufferfish {
            // Pufferfish.aiStep's mob contacts run even when serverAiStep is skipped.
    // rust: aquatic::sting_touching_mobs(m, w, events);
}
    // rust: } else {
    // rust: ai_step(m, w, level_random, events);
}
    // rust: effects_from_blocks(m, w, level_random, events);
    // rust: if m.species() == Species::SulfurCube && m.alive() {
        // SulfurCube.doPush applies the body's contact damage even with NoAI.
        // Player contact keeps its existing player_push route.
    // rust: super::sulfur_cube::mob_contacts(m, w, events);
}
    // rust: if m.species() == Species::Rabbit {
    // rust: super::rabbit::post_tick(m);
}
    // Mob.tickHeadTurn -> BodyRotationControl.clientTick (a frozen
    // creaking's waits).
    // rust: if m.alive()
    // rust: && (!super::creaking::is_creaking(m) || super::creaking::can_move(m))
    // rust: && !super::armadillo::scared(m)
    // rust: {
    // rust: m.body_rotation_tick();
}
    // rust: events.append(&mut m.outbox);
    // rust: m.update_walk_animation();
    // rust: super::axolotl::tick_animation(m);
    // rust: m.anim.end_tick(m.ai.swinging);
    // rust: tick_swing(m);
    // rust: flower_contact_effects(m, w);
    // rust: if m.species() == Species::CopperGolem {
        // CopperGolem.tick: updateWeathering after the living tick.
    // rust: super::copper_golem::update_weathering(m, w, level_random, events);
}
    // rust: if m.species() == Species::Strider {
    // rust: super::strider::float(m, w);
}
    // rust: if m.species() == Species::Bat {
    // rust: super::bat::tick(m);
}
    // rust: if m.species() == Species::Bee {
    // rust: super::bee::tick(m, level_random);
}
    // rust: if m.species() == Species::Allay {
    // rust: super::allay::tick(m, w, events);
}
    // rust: if m.species() == Species::Panda {
    // rust: super::panda::tick(m, w, events);
}
    // rust: aquatic::school_tick(m, w, level_random);
    // rust: true
}
/// `LivingEntity.aiStep` -> `Entity.applyEffectsFromBlocks` for the blocks
/// that hurt, hold or slide a mob: the cactus (`CactusBlock.entityInside`, 1),
/// the cobweb (stuck at 0.25, 0.05, 0.25), the sweet berry bush
/// (`SweetBerryBushBlock.entityInside`: stuck at 0.8, 0.75, 0.8, and a grown bush pricks for 1 when the mob moved at least 0.003 on X
/// or Z this tick) and the honey block (`honey_slide`). The blocks are those
/// the mob's box touches anywhere along its move this tick, from where it
/// started to where it ended.
    // rust: fn effects_from_blocks(
    // rust: m: &mut Mob,
    // rust: w: &MobWorld,
    // rust: level_random: &mut LegacyRandom,
    // rust: events: &mut Vec<MobEvent>,
    // rust: ) {
    // Block.stepOn for the block under a mob on the ground (`getOnPosLegacy`):
    // MagmaBlock.stepOn's hot floor, 1 damage (a mob never sneaks).
    // rust: if m.on_ground && m.alive() {
        // 0.2 below the feet, or the supporting block when the centre is over
        // its edge.
    // rust: let [x, y, z] = m.block_on_legacy(w);
    // rust: crate::block_contact::emit(crate::block_contact::Event::StepOn(
    // rust: crate::block_contact::Contact {
    // rust: entity: m.id as i32,
    // rust: kind: &m.kind.id,
    // rust: block: w.block_name(x, y, z),
    // rust: state: w.world.block(x, y, z),
    // rust: position: horizon_core::position::BlockPos::new(x, y, z),
    // rust: },
    // rust: ));
    // rust: if w.block_name(x, y, z) == "minecraft:magma_block" {
    // rust: m.damage(1.0, Damage::of(DamageKind::HotFloor));
}
        // TurtleEggBlock.stepOn: a mob never steps carefully, so an egg under
        // it breaks one time in a hundred (`destroyEgg`), unless it is a turtle
        // or a bat or mob griefing is off (`canDestroyEgg`); the roll is the
        // level's and comes only after those checks.
    // rust: if w.block_name(x, y, z) == "minecraft:turtle_egg"
    // rust: && !matches!(m.species(), Species::Turtle | Species::Bat)
    // rust: && w.mob_griefing
    // rust: && level_random.next_int_bound(100).unwrap_or(1) == 0
    // rust: {
    // rust: events.push(MobEvent::CrackTurtleEgg { pos: [x, y, z] });
}
}
    // rust: let mut visited: Vec<[i32; 3]> = Vec::new();
    // rust: let travel = m.position.subtract(m.previous);
    // rust: let longest = travel.x.abs().max(travel.y.abs()).max(travel.z.abs());
    // rust: let steps = ((longest / 0.2).ceil() as i32).clamp(1, 100);
    // rust: for step in 0..=steps {
    // rust: if !m.alive() {
    // rust: return;
}
    // rust: let at = m
    // rust: .previous
    // rust: .add_vector(travel.scale(f64::from(step) / f64::from(steps)));
    // rust: let b = m.bounds_at(at).deflate(Vec3::new(1e-5, 1e-5, 1e-5));
    // rust: for x in b.min_position().x.floor() as i32..=b.max_position().x.floor() as i32 {
    // rust: for y in b.min_position().y.floor() as i32..=b.max_position().y.floor() as i32 {
    // rust: for z in b.min_position().z.floor() as i32..=b.max_position().z.floor() as i32 {
    // rust: let p = [x, y, z];
    // rust: if visited.contains(&p) {
    // rust: continue;
}
    // rust: crate::block_contact::emit(crate::block_contact::Event::Inside(
    // rust: crate::block_contact::Contact {
    // rust: entity: m.id as i32,
    // rust: kind: &m.kind.id,
    // rust: block: w.block_name(x, y, z),
    // rust: state: w.world.block(x, y, z),
    // rust: position: horizon_core::position::BlockPos::new(x, y, z),
    // rust: },
    // rust: ));
    // rust: visited.push(p);
    // rust: match w.block_name(x, y, z) {
    // rust: "minecraft:cactus" => {
    // rust: m.damage(1.0, Damage::of(DamageKind::Cactus));
}
                        // CampfireBlock.entityInside: a lit campfire hurts a
                        // living entity by its fire damage (1, soul 2).
    // rust: name @ ("minecraft:campfire" | "minecraft:soul_campfire")
    // rust: if w.prop(x, y, z, "lit") == Some("true") =>
    // rust: {
    // rust: let damage = if name == "minecraft:campfire" {
    // rust: 1.0
    // rust: } else {
    // rust: 2.0
}
    // rust: m.damage(damage, Damage::of(DamageKind::Campfire));
}
                        // WebBlock.entityInside -> makeStuckInBlock, which a
                        // spider ignores for cobwebs and a wither always.
    // rust: "minecraft:cobweb"
    // rust: if !matches!(
    // rust: m.species(),
    // rust: Species::Spider | Species::CaveSpider | Species::Wither
    // rust: ) =>
    // rust: {
    // rust: m.fall_distance = 0.0;
    // rust: m.stuck_multiplier = if m.has_effect("minecraft:weaving") {
    // rust: Vec3::new(0.5, 0.25, 0.5)
    // rust: } else {
    // rust: Vec3::new(0.25, f64::from(0.05_f32), 0.25)
}
}
    // rust: "minecraft:sweet_berry_bush"
    // rust: if !matches!(m.species(), Species::Fox | Species::Bee) =>
    // rust: {
    // rust: if m.species() != Species::Wither {
    // rust: m.fall_distance = 0.0;
    // rust: m.stuck_multiplier =
    // rust: Vec3::new(f64::from(0.8_f32), 0.75, f64::from(0.8_f32));
}
    // rust: let moved = m.previous.subtract(m.position);
    // rust: if w.prop(x, y, z, "age") != Some("0")
    // rust: && moved.horizontal_distance_squared() > 0.0
    // rust: && (moved.x.abs() >= f64::from(0.003_f32)
    // rust: || moved.z.abs() >= f64::from(0.003_f32))
    // rust: {
    // rust: m.damage(1.0, Damage::of(DamageKind::SweetBerryBush));
}
}
                        // PowderSnowBlock.entityInside: a living entity is stuck
                        // (and forgets its fall) only while the block at its
                        // own feet is powder snow.
    // rust: "minecraft:powder_snow"
    // rust: if w.block_name(
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: ) == "minecraft:powder_snow" =>
    // rust: {
    // rust: if m.species() != Species::Wither {
    // rust: m.fall_distance = 0.0;
    // rust: m.stuck_multiplier =
    // rust: Vec3::new(f64::from(0.9_f32), 1.5, f64::from(0.9_f32));
}
    // rust: let known_movement =
    // rust: w.controlling_player_movement.unwrap_or(m.velocity);
    // rust: if let Some(velocity) =
    // rust: powder_snow_particle_velocity(known_movement, level_random)
    // rust: {
    // rust: events.push(MobEvent::PowderSnowParticle {
    // rust: at: [m.position.x, f64::from(y + 1), m.position.z],
    // rust: velocity,
    // rust: });
}
}
    // rust: "minecraft:honey_block" => honey_slide(m, p, level_random, events),
    // rust: _ => continue,
}
}
}
}
}
}

    // rust: mod powder_snow_particle_tests {
//     use super::*;

    /// A ridden mount uses the controlling player's known movement for the
    /// powder-snow roll, even when the mount's own delta is zero.
pub fn a_controlled_mount_uses_its_riders_known_movement() void {
}
    // rust: let seed = (0..1000)
    // rust: .find(|seed| {
    // rust: let mut random = LegacyRandom::new(*seed);
    // rust: random.next_boolean()
    // rust: })
    // rust: .unwrap();
    // rust: let player_movement = Vec3::new(0.2, 0.0, 0.0);
    // rust: let mut expected_random = LegacyRandom::new(seed);
    // rust: let expected =
    // rust: powder_snow_particle_velocity(player_movement, &mut expected_random).unwrap();

    // rust: let ran = crate::mobs::world::with_built_test_world(
    // rust: &[],
    // rust: |world, registry| {
    // rust: for cx in -1..1 {
    // rust: for cz in -1..1 {
    // rust: world.chunks.insert(
    // rust: (cx, cz),
    // rust: std::sync::Arc::new(crate::chunk::Chunk::empty(cx, cz)),
    // rust: );
}
}
    // rust: world
    // rust: .set(
    // rust: 0,
    // rust: 64,
    // rust: 0,
    // rust: registry.default_state("minecraft:powder_snow").unwrap(),
    // rust: )
    // rust: .unwrap();
    // rust: },
    // rust: |w, types| {
    // rust: let mut w = w.clone();
    // rust: w.controlling_player_movement = Some(player_movement);
    // rust: let kind = std::sync::Arc::new(types.types["minecraft:horse"].clone());
    // rust: let mut horse = Mob::new(1, kind, Vec3::new(0.5, 64.0, 0.5), 0.0);
    // rust: horse.extra.saddled = true;
    // rust: horse.rider = Some(crate::mobs::equine::Rider::default());
    // rust: let mut random = LegacyRandom::new(seed);
    // rust: let mut events = Vec::new();

    // rust: effects_from_blocks(&mut horse, &w, &mut random, &mut events);

    // rust: assert!(events.iter().any(|event| matches!(
    // rust: event,
    // rust: MobEvent::PowderSnowParticle { velocity, .. } if *velocity == expected
    // rust: )));
    // rust: },
    // rust: );
    // rust: assert!(ran, "the vanilla test resources must be available");
}
}

/// `HoneyBlock.entityInside` for a mob: a falling mob beside the honey block at
/// `p` slides down it (`isSlidingDown`, `doSlideMovement`, `maybeDoSlideEffects`).
    // rust: fn honey_slide(
    // rust: m: &mut Mob,
    // rust: p: [i32; 3],
    // rust: level_random: &mut LegacyRandom,
    // rust: events: &mut Vec<MobEvent>,
    // rust: ) {
    // rust: let old_delta_y = |dy: f64| dy / f64::from(0.98_f32) + 0.08;
    // rust: let new_delta_y = |dy: f64| (dy - 0.08) * f64::from(0.98_f32);
    // rust: let [x, y, z] = p.map(f64::from);
    // rust: let pos = m.position;
    // rust: if m.on_ground || pos.y > y + 0.9375 - 1.0e-7 || old_delta_y(m.velocity.y) >= -0.08 {
    // rust: return;
}
    // rust: let dx = (x + 0.5 - pos.x).abs();
    // rust: let dz = (z + 0.5 - pos.z).abs();
    // rust: let overlap = 0.4375 + f64::from(m.width()) / 2.0;
    // rust: if dx + 1.0e-7 <= overlap && dz + 1.0e-7 <= overlap {
    // rust: return;
}
    // doSlideMovement
    // rust: let v = m.velocity;
    // rust: let old = old_delta_y(v.y);
    // rust: m.velocity = if old < -0.13 {
    // rust: let factor = -0.05 / old;
    // rust: Vec3::new(v.x * factor, new_delta_y(-0.05), v.z * factor)
    // rust: } else {
    // rust: Vec3::new(v.x, new_delta_y(-0.05), v.z)
}
    // rust: m.fall_distance = 0.0;
    // maybeDoSlideEffects: the slide sound (one time in five, unless silent),
    // then the server's entity event 53 (one time in five).
    // rust: let sound = level_random.next_int_bound(5).unwrap_or(1) == 0;
    // rust: if sound && !m.silent {
    // rust: events.push(MobEvent::Sound(
    // rust: "block.honey_block.slide",
    // rust: [pos.x, pos.y, pos.z],
    // rust: 1.0,
    // rust: 1.0,
    // rust: ));
}
    // rust: if level_random.next_int_bound(5).unwrap_or(1) == 0 {
    // rust: events.push(MobEvent::EntityEvent {
    // rust: mob: m.id,
    // rust: event: 53,
    // rust: at: [pos.x, pos.y, pos.z],
    // rust: });
}
}
/// LivingEntity.updateSwingTime.
pub fn tick_swing(m: *mut Mob) void {
}
    // rust: let duration = m.swing_duration();
    // rust: if m.ai.swinging {
    // rust: m.ai.swing_time += 1;
    // rust: if m.ai.swing_time >= duration {
    // rust: m.ai.swing_time = 0;
    // rust: m.ai.swinging = false;
    // rust: m.ai.swing_duration = 0;
    // rust: m.extra.swing_right_arm = None;
    // rust: m.extra.swing_stab = false;
}
    // rust: } else {
    // rust: m.ai.swing_time = 0;
}
    // rust: m.anim.attack_anim = m.ai.swing_time as f32 / duration as f32;
}
/// `Entity.isInRain`: rain at the block position, or at the top of the box.
    // rust: pub(super) fn in_rain(m: &Mob, w: &MobWorld) -> bool {
    // rust: let (x, y, z) = (
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: );
    // rust: let top = (m.position.y + f64::from(m.height())).floor() as i32;
    // rust: w.raining_at(x, y, z) || w.raining_at(x, top, z)
}
/// `LivingEntity.baseTick` refills a breather's air by 4, then
/// `Axolotl.handleAirSupply` (unless the mob has no AI): water or rain fills
/// it, anywhere else it runs down from the pre-tick value, and at -20 the
/// axolotl dries out.
pub fn axolotl_air_supply(m: *mut Mob, w: *MobWorld) void {
}
    // rust: let before = m.air;
    // rust: m.air = (m.air + 4).min(super::axolotl::MAX_AIR);
    // rust: if m.no_ai {
    // rust: return;
}
    // rust: if m.fluids.in_water || in_rain(m, w) {
    // rust: m.air = super::axolotl::MAX_AIR;
    // rust: } else {
    // rust: m.air = before - 1;
    // rust: if m.air <= -20 {
    // rust: m.air = 0;
    // rust: m.damage(2.0, Damage::of(DamageKind::DryOut));
}
}
}
/// `Entity.isInWall` (minus the noPhysics early-out, which the caller applies):
/// visit every cell covered by the thin eye box and ask whether a suffocating
/// collision shape actually intersects it. Width multiplication is a float.
    // rust: fn in_wall(
    // rust: width: f32,
    // rust: eye: [f64; 3],
    // rust: mut intersects: impl FnMut(i32, i32, i32, &Aabb) -> bool,
    // rust: ) -> bool {
    // rust: let side = f64::from(width * 0.8_f32);
    // rust: let half = [side / 2.0, 1.0e-6 / 2.0, side / 2.0];
    // rust: let lo = [0, 1, 2].map(|i| eye[i] - half[i]);
    // rust: let hi = [0, 1, 2].map(|i| eye[i] + half[i]);
    // rust: let bounds = Aabb::new(
    // rust: Vec3::new(lo[0], lo[1], lo[2]),
    // rust: Vec3::new(hi[0], hi[1], hi[2]),
    // rust: );
    // rust: let c0 = lo.map(|v| v.floor() as i32);
    // rust: let c1 = hi.map(|v| v.floor() as i32);
    // rust: (c0[0]..=c1[0])
    // rust: .any(|x| (c0[1]..=c1[1]).any(|y| (c0[2]..=c1[2]).any(|z| intersects(x, y, z, &bounds))))
}
/// Entity.baseTick + LivingEntity.baseTick + Mob.baseTick.
pub fn base_tick(m: *mut Mob, w: *MobWorld, events: *mut std.ArrayList(MobEvent)) void {
}
    // Entity.canSpawnSprintParticle / spawnSprintParticle (a dashing cat or
    // ocelot): a server level drops the particle, but its spot is drawn
    // from the mob's random first.
    // `IronGolem.canSpawnSprintParticle`: moving, and a one in five draw, sprinting or not.
    // rust: let spawn = if m.species() == Species::IronGolem {
    // rust: let horizontal = m.velocity.x * m.velocity.x + m.velocity.z * m.velocity.z;
    // rust: horizontal > f64::from(2.500_000_3e-7_f32) && m.random.next_int_bound(5).unwrap_or(1) == 0
    // rust: } else {
    // rust: m.extra.sprinting && !m.fluids.in_water && !m.fluids.in_lava && m.alive()
}
    // rust: if spawn {
    // rust: let at = m.block_on_legacy(w);
    // rust: let state = w.world.block(at[0], at[1], at[2]);
    // rust: if w.facts.get(state).render_shape != crate::blocks::RenderShape::Invisible {
    // rust: let _ = (m.random.next_double(), m.random.next_double());
}
}
    // rust: m.was_eye_in_water = m.fluids.eye_in_water;
    // rust: m.update_fluids(w, events);
    // rust: if m.species() == Species::Drowned {
    // rust: super::undead::drowned_update_swimming(m, w);
}
    // rust: let fire = crate::motion::environment::fire_contact(w.world, w.registry, m.bounds());
    // rust: if fire > 0.0 {
    // rust: m.ticks_frozen = 0;
}
    // Fire: water or rain (Entity.isInRain) extinguishes, lava ignites,
    // burning hurts every second.
    // rust: if m.fire_ticks > 0 && (m.fluids.in_water || in_rain(m, w)) {
    // rust: m.fire_ticks = 0;
    // rust: events.push(MobEvent::Sound(
    // rust: "entity.generic.extinguish_fire",
    // rust: m.center(),
    // rust: 0.7,
    // rust: 1.6 + (m.random.next_float() - m.random.next_float()) * 0.4,
    // rust: ));
}
    // rust: if m.fire_ticks > 0 {
    // rust: if m.kind.flags.fire_immune {
    // rust: m.fire_ticks = 0;
    // rust: } else {
    // rust: if m.fire_ticks % 20 == 0 && !m.fluids.in_lava {
    // rust: m.damage(1.0, Damage::of(DamageKind::OnFire));
}
    // rust: m.fire_ticks -= 1;
}
}
    // Entity.checkBelowWorld: LivingEntity.onBelowWorld hurts 4 a tick.
    // rust: if m.position.y < f64::from(w.world.bottom_y() - 64) {
    // rust: m.damage(4.0, Damage::of(DamageKind::OutOfWorld));
}
    // rust: m.first_tick = false;
    // rust: if m.alive() {
        // LivingEntity.baseTick: a suffocating shape intersects the eye. Entity.isInWall
        // is false under noPhysics, which Vex.tick holds while it ticks.
    // rust: let mut scene = crate::collisions::SceneCollisions {
    // rust: world: w.world,
    // rust: binding: w.collision,
    // rust: subject: None,
}
    // rust: if m.species() != Species::Vex
    // rust: && in_wall(
    // rust: m.width(),
    // rust: [m.position.x, m.eye_y(), m.position.z],
    // rust: |x, y, z, eye_bounds| {
    // rust: let p = [x, y, z];
    // rust: let state = w.world.block(x, y, z);
    // rust: if !w
    // rust: .suffocation
    // rust: .is_suffocating(&mut scene, state, p)
    // rust: .unwrap_or(false)
    // rust: {
    // rust: return false;
}
    // rust: w.collision
    // rust: .collision_shape(&mut scene, state, p)
    // rust: .ok()
    // rust: .is_some_and(|shape| {
    // rust: let Ok(eye_shape) = VoxelShape::from_box(*eye_bounds) else {
    // rust: return false;
}
    // rust: shape
    // rust: .moved(Vec3::new(f64::from(x), f64::from(y), f64::from(z)))
    // rust: .join_is_not_empty(&eye_shape, ShapeOp::AND)
    // rust: .unwrap_or(false)
    // rust: })
    // rust: },
    // rust: )
    // rust: {
    // rust: m.damage(1.0, Damage::of(DamageKind::InWall));
}
        // Air supply and drowning (WaterAnimal.handleAirSupply for aquatic mobs).
    // rust: if m.species() == Species::Axolotl {
    // rust: axolotl_air_supply(m, w);
    // rust: } else if m.kind.flags.needs_water {
    // rust: if !m.fluids.in_water {
    // rust: m.air -= 1;
    // rust: if m.air == -20 {
    // rust: m.air = 0;
    // rust: m.damage(2.0, Damage::of(DamageKind::Drown));
}
    // rust: } else {
    // rust: m.air = 300;
}
    // rust: } else {
            // LivingEntity.baseTick's air supply (LivingBreatheEvent): an
            // entity with its eyes in water that can't breathe there loses
            // air, any other gains it.
    // rust: let drowns = m.fluids.eye_in_water && !m.kind.flags.breathes_water;
    // rust: let vanilla = Breath {
    // rust: can_breathe: !drowns,
    // rust: consume: 1,
    // rust: refill: if drowns { 0 } else { 4 },
}
    // rust: let breath = breathe(m.id, &m.kind.id, vanilla);
    // rust: if let Some(drowning) = drown(m.id, &m.kind.id, &mut m.air, breath, true) {
    // rust: events.push(MobEvent::Drown {
    // rust: mob: m.id,
    // rust: at: [m.position.x, m.position.y, m.position.z],
    // rust: });
    // rust: if let Some(damage) = drowning.damage {
    // rust: m.damage(damage, Damage::of(DamageKind::Drown));
}
}
}

    // rust: if m.kind.flags.water_sensitive && (m.fluids.in_water || in_rain(m, w)) {
    // rust: m.damage(1.0, Damage::of(DamageKind::Drown));
}
    // rust: freeze_tick(m, w);
}
    // rust: if m.species() == Species::Illusioner {
    // rust: super::illusioner::tick(m, events);
}
    // rust: if matches!(m.species(), Species::Evoker | Species::Illusioner) {
    // rust: super::illager::cast_particles(m, events);
}
    // rust: if m.hurt_time > 0 {
    // rust: m.hurt_time -= 1;
}
    // rust: if m.invulnerable > 0 {
    // rust: m.invulnerable -= 1;
}
    // LivingEntity.baseTick runs tickEffects after the timers count down.
    // rust: tick_effects(m, w.mod_effects);
    // Entity.applyEffectsFromBlocks runs in LivingEntity.aiStep, after
    // baseTick has counted the fire and the hurt timers down: a fire block or
    // lava ignites to the full 160 / 300 ticks and its hit lands after the
    // invulnerable time of that tick has already dropped.
    // rust: block_contact_damage(m, w, fire);
    // rust: if !m.alive() {
    // rust: m.death_time += 1;
}
    // Hurt sounds of the damage above come before the ambient sound.
    // rust: events.append(&mut m.outbox);
    // Mob.baseTick: ambient sounds.
    // rust: if m.alive() {
    // rust: let roll = m.random.next_int_bound(1000).unwrap_or(999);
    // rust: let t = m.ambient_timer;
    // rust: m.ambient_timer += 1;
    // rust: if roll < t {
    // rust: m.ambient_timer = -m.ambient_interval();
    // rust: play_ambient(m, w, events);
}
}
    // Entity.baseTick ends with Leashable.tickLeash.
    // rust: super::leash::tick(m, w, events);
}
/// `LivingEntity.aiStep`'s "freezing" with `InsideBlockEffectType.FREEZE`:
/// powder snow builds `ticks_frozen` up, anywhere else it melts twice as
/// fast, and a fully frozen mob takes one freeze damage every 40 ticks.
pub fn freeze_tick(m: *mut Mob, w: *MobWorld) void {
}
    // rust: let in_snow = in_powder_snow(m, w);
    // rust: if !in_snow && m.ticks_frozen == 0 {
    // rust: return;
}
    // rust: let can_freeze = can_freeze(m, w);
    // rust: if in_snow && can_freeze {
    // rust: m.ticks_frozen =
    // rust: (m.ticks_frozen + 1).min(crate::motion::PlayerMotion::TICKS_REQUIRED_TO_FREEZE);
    // rust: } else {
    // rust: m.ticks_frozen = (m.ticks_frozen - 2).max(0);
}
    // rust: if m.age.is_multiple_of(40) && m.is_fully_frozen() && can_freeze {
    // rust: m.damage(1.0, Damage::of(DamageKind::Freeze));
}
}
/// Whether the mob's box (shrunk by `1.0E-5`, as in `Entity.checkInsideBlocks`)
/// touches powder snow.
    // rust: pub(super) fn in_powder_snow(m: &Mob, w: &MobWorld) -> bool {
    // rust: let b = m.bounds().deflate(Vec3::new(1e-5, 1e-5, 1e-5));
    // rust: let (min, max) = (b.min_position(), b.max_position());
    // rust: for x in min.x.floor() as i32..=max.x.floor() as i32 {
    // rust: for y in min.y.floor() as i32..=max.y.floor() as i32 {
    // rust: for z in min.z.floor() as i32..=max.z.floor() as i32 {
    // rust: if &*w.facts.get(w.world.block(x, y, z)).name == "minecraft:powder_snow" {
    // rust: return true;
}
}
}
}
    // rust: false
}
/// `LivingEntity.canFreeze`: not a `#freeze_immune_entity_types` mob and no
/// worn piece in `#freeze_immune_wearables`.
pub fn can_freeze(m: *Mob, w: *MobWorld) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if w.data
    // rust: .entity_has("minecraft:freeze_immune_entity_types", &m.kind.id)
    // rust: {
    // rust: return false;
}
    // rust: let immune = w
    // rust: .items
    // rust: .and_then(|i| i.item_tags.get("minecraft:freeze_immune_wearables"));
    // A wolf's armor (its body slot) is `#freeze_immune_wearables`.
    // rust: ![
    // rust: &m.extra.body,
    // rust: &m.extra.head,
    // rust: &m.extra.chest,
    // rust: &m.extra.legs,
    // rust: &m.extra.feet,
    // rust: ]
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .any(|item| immune.is_some_and(|t| t.contains(&**item)))
}
/// `Mob.playAmbientSound` on demand: a spawn egg or a mob bucket just placed `m`.
pub fn ambient_sound(m: *mut Mob, w: *MobWorld, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: play_ambient(m, w, events);
}
pub fn play_ambient(m: *mut Mob, w: *MobWorld, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: if super::axolotl::is_playing_dead(m) {
    // rust: return;
}
    // rust: let sound = match m.species() {
        // Warden.getAmbientSound: by anger, silent while roaring or digging.
    // rust: Species::Warden => match super::warden::ambient_sound(m) {
    // rust: Some(sound) => sound,
    // rust: None => return,
    // rust: },
    // rust: Species::Zombie | Species::Husk if m.is_baby() => m.kind.sounds[0],
    // rust: Species::Drowned if m.fluids.in_water => "entity.drowned.ambient_water",
        // Nautilus/ZombieNautilus.getAmbientSound: by age, under water or on land.
    // rust: Species::Nautilus | Species::ZombieNautilus => super::nautilus::sounds(m)[0],
    // rust: Species::Enderman if m.ai.target.is_some() => "entity.enderman.scream",
        // Wolf.isAngry reads the persistent anger timer, not the current target.
    // rust: Species::Wolf if super::tame::angry(m) => {
    // rust: super::finalize::variant_sound(m, "growl").unwrap_or("entity.wolf.growl")
}
    // rust: Species::Wolf if m.random.next_int_bound(3).unwrap_or(1) == 0 => {
    // rust: let kind = if m.extra.tame && m.health < m.attrs.max_health / 2.0 {
    // rust: "whine"
    // rust: } else {
    // rust: "pant"
}
    // rust: super::finalize::variant_sound(m, kind).unwrap_or("entity.wolf.pant")
}
    // rust: Species::Parrot => super::parrot::ambient(m, w),
        // Cat.getAmbientSound: purr in love, purreow one time in four, else ambient.
    // rust: Species::Cat if m.extra.tame && m.extra.in_love > 0 => {
    // rust: super::finalize::variant_sound(m, "purr").unwrap_or("entity.cat.purr")
}
    // rust: Species::Cat if m.extra.tame && m.random.next_int_bound(4).unwrap_or(1) == 0 => {
    // rust: super::finalize::variant_sound(m, "purreow").unwrap_or("entity.cat.purreow")
}
    // rust: Species::Cat if !m.extra.tame => {
    // rust: super::finalize::variant_sound(m, "stray_ambient").unwrap_or("entity.cat.stray_ambient")
}
        // Fox.getAmbientSound: a sleeping fox makes its sleep sound.
    // rust: Species::Fox if super::fox::flag(m, super::fox::SLEEPING) => "entity.fox.sleep",
        // Fox.playAmbientSound: the screech at volume 2. Anything else goes to
        // Mob.playAmbientSound, which asks getAmbientSound again (a second draw).
    // rust: Species::Fox => {
    // rust: if super::fox::awake_ambient(m, w) == super::fox::SCREECH {
    // rust: let pitch = m.voice_pitch();
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: events.push(MobEvent::Sound(super::fox::SCREECH, at, 2.0, pitch));
    // rust: return;
}
    // rust: super::fox::awake_ambient(m, w)
}
        // Turtle.getAmbientSound: the land ambient only on land and grown up, else silent.
    // rust: Species::Turtle if m.fluids.in_water || !m.on_ground || m.is_baby() => return,
    // rust: Species::PolarBear if m.is_baby() => "entity.polar_bear.ambient_baby",
        // Turtle.getAmbientSound: only an adult on land makes a sound.
    // rust: Species::Turtle if turtle_ambient_silent(m) => return,
    // rust: Species::Dolphin if !m.fluids.in_water => "entity.dolphin.ambient",
    // rust: Species::Guardian if !m.fluids.in_water => "entity.guardian.ambient_land",
    // rust: Species::ElderGuardian if !m.fluids.in_water => "entity.elder_guardian.ambient_land",
    // rust: Species::Axolotl if !m.fluids.in_water => "entity.axolotl.idle_air",
        // Villager.getAmbientSound: silent while asleep, the trade sound
        // while a player has its menu open.
    // rust: Species::Villager if super::villager::sleeping(m) => return,
    // rust: Species::Villager if m.extra.flag2 => "entity.villager.trade",
        // WanderingTrader.getAmbientSound: only the trade branch, it never sleeps.
    // rust: Species::WanderingTrader if m.extra.flag2 => "entity.wandering_trader.trade",
    // rust: Species::Bat if m.extra.flag && m.random.next_int_bound(4).unwrap_or(1) != 0 => return,
    // rust: Species::Allay if m.extra.main_hand.is_some() => "entity.allay.ambient_with_item",
        // Strider.getAmbientSound: quiet while panicking or tempted.
    // rust: Species::Strider if m.ai.panicking || m.ai.goals.is_running("Tempt") => return,
        // HappyGhast: its own voice, never pitched up.
    // rust: Species::HappyGhast => {
    // rust: let sound = super::happy_ghast::sounds(m)[0];
    // rust: events.push(MobEvent::Sound(
    // rust: sound,
    // rust: m.center(),
    // rust: super::happy_ghast::volume(m),
    // rust: 1.0,
    // rust: ));
    // rust: return;
}
        // Sniffer.getAmbientSound.
    // rust: Species::Sniffer => match super::sniffer::ambient(m) {
    // rust: Some(s) => s,
    // rust: None => return,
    // rust: },
        // Breeze.playAmbientSound: a local sound, nothing drawn.
    // rust: Species::Breeze => {
    // rust: if let Some(s) = super::breeze::ambient(m) {
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: events.push(MobEvent::LocalSound(s, at, 1.0, 1.0));
}
    // rust: return;
}
        // Creaking.getAmbientSound: silent while awake.
    // rust: Species::Creaking if m.extra.flag => return,
        // Shulker.playAmbientSound: silent while closed.
    // rust: Species::Shulker if m.extra.counter == 0 => return,
    // rust: Species::ZombifiedPiglin if m.ai.target.is_some() => "entity.zombified_piglin.angry",
    // rust: Species::Piglin => super::piglin::piglin_ambient(m, w),
    // rust: Species::Hoglin => super::piglin::hoglin_ambient(m, w),
        // Zoglin.getAmbientSound: with an attack target, the angry sound.
    // rust: Species::Zoglin if m.ai.target.is_some() => "entity.zoglin.angry",
    // rust: _ => voice_sounds(m)[0],
}
    // rust: let _ = w;
    // rust: if !sound.is_empty() {
    // rust: m.voice(sound, events);
}
}
/// `Turtle.getAmbientSound`: `entity.turtle.ambient_land` only when the turtle
/// is out of water, on the ground and not a baby; otherwise `null` (silent).
pub fn turtle_ambient_silent(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.fluids.in_water || !m.on_ground || m.is_baby()
}
/// `Animal.aiStep`: age-based love clearing and countdown, following the age step.
/// Both the normal and NoAI paths run it after the age step.
pub fn animal_step(m: *mut Mob, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: if m.alive() {
    // rust: if m.extra.age != 0 {
    // rust: m.extra.in_love = 0;
}
    // rust: if m.extra.in_love > 0 {
    // rust: m.extra.in_love -= 1;
    // rust: if m.extra.in_love % 10 == 0 {
                // The heart's speed and getRandomX/Y/Z, drawn even on the server.
    // rust: let (w, h) = (f64::from(m.width()), f64::from(m.height()));
    // rust: let r = &mut m.random;
    // rust: let velocity = [
    // rust: r.next_gaussian() * 0.02,
    // rust: r.next_gaussian() * 0.02,
    // rust: r.next_gaussian() * 0.02,
    // rust: ];
    // rust: let x = m.position.x + w * (2.0 * r.next_double() - 1.0);
    // rust: let y = m.position.y + h * r.next_double() + 0.5;
    // rust: let z = m.position.z + w * (2.0 * r.next_double() - 1.0);
    // rust: events.push(MobEvent::ParticleAt {
    // rust: kind: "heart",
    // rust: at: [x, y, z],
    // rust: velocity,
    // rust: });
}
}
}
}
/// `AgeableMob.aiStep` runs even when `Mob.serverAiStep` is disabled.
    // rust: fn ageable_step(
    // rust: m: &mut Mob,
    // rust: w: &MobWorld,
    // rust: level_random: &mut LegacyRandom,
    // rust: events: &mut Vec<MobEvent>,
    // rust: ) {
    // AgeableMob.aiStep: a forced age-up's particles (`sendParticles`, so the
    // players are sent them), then the age.
    // rust: if m.extra.forced_age_timer > 0 {
    // rust: if m.extra.forced_age_timer % 4 == 0 {
    // rust: let (w, h) = (f64::from(m.width()), f64::from(m.height()));
    // rust: let r = &mut m.random;
    // rust: let x = m.position.x + w * (2.0 * r.next_double() - 1.0);
    // rust: let y = m.position.y + h * r.next_double() + 0.5;
    // rust: let z = m.position.z + w * (2.0 * r.next_double() - 1.0);
            // sendParticles(HAPPY_VILLAGER, x, y, z, 1, 0, 0, 0, 0): exactly there, at rest.
    // rust: events.push(MobEvent::LevelParticles {
    // rust: kind: "happy_villager",
    // rust: at: [x, y, z],
    // rust: spread: [0.0; 3],
    // rust: speed: 0.0,
    // rust: count: 1,
    // rust: });
}
    // rust: m.extra.forced_age_timer -= 1;
}
    // AgeableMob.aiStep: an age counts only for its subclasses (a tadpole
    // counts its own age up, a zombie's baby age never moves). `canAgeUp`:
    // a baby grows unless an age lock holds it; a breeding pause counts down.
    // rust: if m.alive() && super::finalize::ageable(m.species()) {
    // rust: if can_age_up(m) {
    // rust: let (bw, bh, _) = m.dims();
            // AgeableMob.setAge(getAge() + 1): the crossing is where a species'
            // ageBoundaryReached runs (a goat's and a hoglin's attack damage, a
            // sulfur cube's size), which the age write used to skip.
    // rust: let next = m.extra.age + 1;
    // rust: super::finalize::set_age(m, next);
            // setAge at the age boundary: refreshDimensions.
    // rust: if m.extra.age >= 0 {
    // rust: m.fudge_position_after_size_change(w, bw, bh);
    // rust: if m.species() == Species::Villager {
    // rust: super::villager_brain::age_boundary_reached(m, w, level_random, events);
}
                // Turtle.ageBoundaryReached: a grown turtle drops a scute.
    // rust: if m.species() == Species::Turtle {
    // rust: events.push(MobEvent::GiftLoot {
    // rust: mob: m.id,
    // rust: table: "minecraft:gameplay/turtle_grow",
    // rust: at: [m.position.x, m.position.y, m.position.z],
    // rust: });
}
}
    // rust: } else if m.extra.age > 0 {
    // rust: m.extra.age -= 1;
}
}
    // rust: if super::finalize::ageable(m.species()) {
    // rust: make_age_locked_particle(m, events);
}
}

/// `LivingEntity.aiStep`: both flight effects discard accumulated fall before
/// travel, even when NoAI skips the server AI step.
pub fn reset_effect_fall_distance(m: *mut Mob) void {
}
    // rust: if m.has_effect("minecraft:slow_falling") || m.has_effect("minecraft:levitation") {
    // rust: m.fall_distance = 0.0;
}
}

/// LivingEntity.aiStep (and Mob/AgeableMob/Animal additions).
pub fn ai_step(m: *mut Mob, w: *MobWorld, level_random: *mut LegacyRandom, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: if m.species() == Species::Parrot {
    // rust: super::parrot::ai_step(m, w, level_random, events);
}
    // Witch.aiStep runs before super.aiStep().
    // rust: if m.species() == Species::Witch {
    // rust: let far = m
    // rust: .target_info(w)
    // rust: .is_some_and(|t| t.position.distance_squared(m.position) > 121.0);
    // rust: super::witch::ai_step(m, events, far);
}
    // rust: if m.species() == Species::Fox {
    // rust: super::fox::pre_ai_step(m);
}
    // AbstractHorse.aiStep: the tail swishes now and then (moveTail).
    // rust: if super::equine::is_equine(m.species()) {
    // rust: super::equine::tail_tick(m);
}
    // Monster.aiStep: updateNoActionTime (Raider: always +2).
    // rust: if is_monster(m.species())
    // rust: && (super::raider::is_raider(m.species()) || super::hostile::mob_brightness(m, w) > 0.5)
    // rust: {
    // rust: m.ai.no_action_time += 2;
}
    // rust: if super::creaking::is_creaking(m) {
    // rust: super::creaking::update(m, w, events);
}
    // rust: if m.ai.no_jump_delay > 0 {
    // rust: m.ai.no_jump_delay -= 1;
}
    // rust: let v = m.velocity;
    // rust: m.velocity = Vec3::new(
    // rust: if v.x.abs() < 0.003 { 0.0 } else { v.x },
    // rust: if v.y.abs() < 0.003 { 0.0 } else { v.y },
    // rust: if v.z.abs() < 0.003 { 0.0 } else { v.z },
    // rust: );
    // rust: m.ai.xxa *= 0.98;
    // rust: m.ai.zza *= 0.98;
    // LivingEntity.isImmobile: no goals or input (a biting, stunned or
    // roaring ravager, an eating or rearing horse). A mannequin is an Avatar, not a Mob: LivingEntity's
    // serverAiStep has no goals, so it only falls and is pushed.
    // rust: let immobile = (m.species() == Species::Ravager && super::ravager::immobile(m))
    // rust: || super::equine::immobile(m)
    // rust: || m.species() == Species::Mannequin;
    // rust: if matches!(m.species(), Species::Piglin | Species::Hoglin) && m.alive() {
    // rust: super::piglin::before_goals(m, w, level_random, events);
}
    // rust: if m.alive() && !immobile {
    // rust: server_ai_step(m, w, level_random, events);
    // rust: } else {
    // rust: m.ai.jumping = false;
    // rust: m.ai.xxa = 0.0;
    // rust: m.ai.zza = 0.0;
}
    // rust: m.handle_jumping(w);
    // rust: let input = Vec3::new(
    // rust: f64::from(m.ai.xxa),
    // rust: f64::from(m.ai.yya),
    // rust: f64::from(m.ai.zza),
    // rust: );
    // rust: reset_effect_fall_distance(m);
    // rust: if super::equine::moved_by_client(m) {
        // LivingEntity.travelRidden: the rider's client moves it
        // (handleMoveVehicle), so the server only stops it.
    // rust: m.velocity = Vec3::ZERO;
    // rust: } else if !(m.species() == Species::Mannequin && m.extra.immovable) {
        // Mannequin.isEffectiveAi: an immovable one never travels.
    // rust: m.travel(w, input, events);
}
    // LivingEntity.aiStep: applyEffectsFromBlocks follows travel.
    // rust: m.apply_effects_from_blocks(w, events);
    // rust: push_entities(m, w, events);
    // Spider.tick: climbing while pressed against a wall.
    // rust: if m.kind.flags.climber {
    // rust: m.climbing = m.horizontal_collision;
}
    // rust: ageable_step(m, w, level_random, events);
    // rust: animal_step(m, events);
    // rust: burn_undead(m, w, events);
    // rust: species_ai_step(m, w, level_random, events);
}
    // rust: impl Mob {
    /// LivingEntity.isPushable (and the push it takes from `Entity.push(Entity)`):
    /// bats and shulkers are never moved by others, nor is a mob on a climbable
    /// block (`onClimbable`, cached by the last tick).
pub fn pushable(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.alive()
    // rust: && !matches!(self.species(), Species::Bat | Species::Shulker)
    // rust: && !self.on_climbable
    // rust: && (self.species() != Species::Creaking || super::creaking::can_move(self))
    // rust: && (self.species() != Species::Warden || !super::warden::digging_or_emerging(self))
}
}
/// LivingEntity.onClimbable for the pusher (Spider.onClimbable: climbing a wall).
pub fn on_climbable(m: *Mob, w: *MobWorld) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.on_climbable(w)
}
/// `Entity.getRootVehicle` of the mob `id` riding `vehicle`: the bottom of
/// its stack of vehicles (itself when it rides nothing).
pub fn root_vehicle(w: *MobWorld, id: u32, vehicle: ?u32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (mut root, mut next) = (id, vehicle);
    // A stack of riders is short; the bound only guards a broken loop.
    // rust: for _ in 0..16 {
    // rust: let Some(v) = next else { break };
    // rust: root = v;
    // rust: next = w.seen(v).and_then(|s| s.vehicle);
}
    // rust: root
}
/// LivingEntity.pushEntities: every pushable entity overlapping the box is
/// pushed apart from this one (`doPush(e)` = `e.push(this)`); pushes of other
/// mobs are `Push` events their tick picks up.
pub fn push_entities(m: *mut Mob, w: *MobWorld, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: m.on_climbable = on_climbable(m, w);
    // rust: if m.species() == Species::Bat {
    // rust: return;
}
    // rust: let bounds = m.bounds();
    // The pusher's own isPushable, checked by `e.push(this)` before moving it.
    // rust: let self_pushable = m.alive()
    // rust: && m.species() != Species::Shulker
    // rust: && !m.on_climbable
    // rust: && (m.species() != Species::Creaking || super::creaking::can_move(m))
    // rust: && (m.species() != Species::Warden || !super::warden::digging_or_emerging(m))
    // rust: && !super::equine::is_vehicle(m);
    // Each with whether it rides a vehicle (`Entity.isPassenger`) and
    // whether it shares this one's root vehicle (`isPassengerOfSameVehicle`).
    // rust: let mut targets: Vec<(Who, Vec3, bool, bool, bool)> = Vec::new();
    // rust: if let Some(p) = &w.player
        // Entity.push: passengers of the same vehicle never push each other.
    // rust: && m.rider.is_none()
    // rust: && p.alive
    // rust: && !p.spectator
    // rust: && p.bounds.intersects(bounds)
    // rust: {
    // rust: targets.push((Who::Player, p.position, p.passenger, false, false));
}
    // rust: let root = root_vehicle(w, m.id, m.extra.mount);
    // rust: for o in w.others_near(bounds) {
    // rust: if o.id != m.id && o.alive && o.pushable && o.bounds.intersects(bounds) {
    // rust: let same = root_vehicle(w, o.id, o.vehicle) == root;
    // rust: targets.push((Who::Mob(o.id), o.position, o.passenger, same, o.is_vehicle));
}
}
    // EntitySelector.pushableBy(this): the teams' collision rules.
    // rust: let own = w.teams.of(Who::Mob(m.id));
    // rust: targets.retain(|(who, ..)| crate::scoreboard::pushable_by(own, w.teams.of(*who), true));
    // Cramming: a quarter of the ticks spent with `maxEntityCramming` or more
    // others around that are not riding anything hurts it by 6.
    // rust: let limit = w.max_entity_cramming;
    // rust: if limit > 0
    // rust: && targets.len() as i64 > i64::from(limit) - 1
    // rust: && m.random.next_int_bound(4).unwrap_or(1) == 0
    // rust: && targets.iter().filter(|t| !t.2).count() as i64 > i64::from(limit) - 1
    // rust: {
    // rust: m.damage(6.0, Damage::of(DamageKind::Cramming));
}
    // rust: for (who, at, _, same, vehicle) in targets {
        // Warden.doPush: touching it angers it, then the push itself.
    // rust: if m.species() == Species::Warden {
    // rust: super::warden::do_push(m, w, who, events);
}
        // IronGolem.doPush: a monster that is not a creeper becomes its target
        // one time in 20, and the draw is made for those alone, then the push.
    // rust: if m.species() == Species::IronGolem
    // rust: && let Who::Mob(id) = who
    // rust: && w.seen(id).is_some_and(super::golem::golem_prey)
    // rust: && m.random.next_int_bound(20).unwrap_or(1) == 0
    // rust: {
    // rust: m.ai.target = Some(who);
}
        // Entity.push: passengers of the same vehicle (a rider and its mount
        // among them) never push each other.
    // rust: if same {
    // rust: continue;
}
        // Entity.push(Entity) with `this` the other entity.
    // rust: let (mut xa, mut za) = (m.position.x - at.x, m.position.z - at.z);
    // rust: let mut dd = xa.abs().max(za.abs());
    // rust: if dd < f64::from(0.01_f32) {
    // rust: continue;
}
    // rust: dd = dd.sqrt();
    // rust: xa /= dd;
    // rust: za /= dd;
    // rust: let pow = (1.0 / dd).min(1.0);
    // rust: xa *= pow;
    // rust: za *= pow;
    // rust: xa *= f64::from(0.05_f32);
    // rust: za *= f64::from(0.05_f32);
        // A guest's server-side push never reaches its client (ServerPlayer
        // motion is synced only when hurt): its client pushes it itself.
    // rust: if !vehicle && (who != Who::Player || w.player.as_ref().is_none_or(|p| !p.remote)) {
    // rust: events.push(MobEvent::Push {
    // rust: target: who,
    // rust: velocity: [-xa, 0.0, -za],
    // rust: });
}
    // rust: if self_pushable {
    // rust: m.velocity = Vec3::new(m.velocity.x + xa, m.velocity.y, m.velocity.z + za);
}
}
}
/// `Mob.aiStep` -> `Mob.burnUndead`: undead burn in daylight. It runs with
/// or without AI (`NoAI` only skips `serverAiStep`).
pub fn burn_undead(m: *mut Mob, w: *MobWorld, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: if m.kind.flags.burns_in_day && m.alive() && sun_burn_tick(m, w) {
        // The head is the sun-protection slot, or the body for the species
        // whose body item is their armour (a zombie horse's, a nautilus's).
    // rust: let protected = if super::drops::body_slot_species(m.species()) {
    // rust: m.extra.body.is_some()
    // rust: } else {
    // rust: m.extra.head.is_some()
}
    // rust: if protected {
    // rust: events.push(MobEvent::SunProtectionWear { mob: m.id });
    // rust: } else {
    // rust: m.ignite_for_ticks(160);
}
}
}
pub fn sun_burn_tick(m: *mut Mob, w: *MobWorld) b {
    // Implementation ported from Horizon
    return undefined;
}
    // Mob.isSunBurnTick: the monsters_burn attribute, not the sky darkness.
    // rust: if !w.monsters_burn {
    // rust: return false;
}
    // rust: let (x, y, z) = (
    // rust: m.position.x.floor() as i32,
    // rust: m.eye_y().floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: );
    // rust: let br = w.brightness(x, y, z);
    // rust: let wet = m.fluids.in_water || in_rain(m, w);
    // rust: br > 0.5 && m.random.next_float() * 30.0 < (br - 0.4) * 2.0 && !wet && w.can_see_sky(x, y, z)
}
/// Mob.serverAiStep
    // rust: fn server_ai_step(
    // rust: m: &mut Mob,
    // rust: w: &MobWorld,
    // rust: level_random: &mut LegacyRandom,
    // rust: events: &mut Vec<MobEvent>,
    // rust: ) {
    // rust: m.ai.no_action_time += 1;
    // A happy ghast set up for its age (ageBoundaryReached runs at once).
    // rust: if m.species() == Species::HappyGhast {
    // rust: super::happy_ghast::ensure_setup(m);
}
    // A saddled mount follows its rider instead of its goals.
    // rust: if super::equine::controlled(m) {
    // rust: super::equine::ridden_step(m);
    // rust: return;
}
    // rust: super::riders::drive(m, w);
    // rust: let tick_count = m.age as i64;
    // rust: let id_based = tick_count + i64::from(m.id);
    // rust: let mut targets = std::mem::take(&mut m.ai.targets);
    // rust: let mut goals = std::mem::take(&mut m.ai.goals);
    // rust: {
    // rust: let mut cx = Cx {
    // rust: w,
    // rust: lr: level_random,
    // rust: events,
}
    // rust: if id_based % 2 != 0 && tick_count > 1 {
    // rust: targets.tick_running(m, &mut cx, false);
    // rust: goals.tick_running(m, &mut cx, false);
    // rust: } else {
    // rust: targets.tick(m, &mut cx);
    // rust: goals.tick(m, &mut cx);
}
}
    // rust: m.ai.targets = targets;
    // rust: m.ai.goals = goals;
    // A creaking looked at stands still: its navigation, move, look and jump
    // controls wait (CreakingPathNavigation and the Creaking*Control).
    // rust: let frozen = super::creaking::is_creaking(m) && !super::creaking::can_move(m);
    // The bee's navigation waits while it pollinates.
    // rust: if !frozen && !super::bee::pollinating(m) {
    // rust: m.nav_tick(w);
}
    // rust: if super::monster_brain::has_brain(m.species()) {
        // Breeze/Creaking.customServerAiStep: the brain, then updateActivity.
    // rust: super::monster_brain::tick(m, w, level_random, events);
}
    // rust: if m.species() == Species::Villager {
        // Villager.customServerAiStep: the brain, then the raid sound roll.
    // rust: super::villager_brain::tick(m, w, level_random, events);
    // rust: let _ = m.random.next_int_bound(100);
}
    // rust: if m.species() == Species::Warden {
        // Warden.customServerAiStep: the brain and its bookkeeping.
    // rust: super::warden::server_ai_step(m, w, level_random, events);
}
    // Sniffer and HappyGhast.customServerAiStep: the brain (a happy ghast's
    // only while it is a ghastling), then updateActivity.
    // rust: if m.species() == Species::Sniffer
    // rust: || m.species() == Species::HappyGhast && m.is_baby()
    // rust: || m.species() == Species::CopperGolem
    // rust: || m.species() == Species::Axolotl
    // rust: || m.species() == Species::Tadpole
    // rust: {
    // rust: super::animal_brain::tick(m, w, level_random, events);
}
    // rust: {
    // rust: let mut cx = Cx {
    // rust: w,
    // rust: lr: level_random,
    // rust: events,
}
    // rust: custom_server_ai_step(m, &mut cx);
}
    // rust: if frozen {
    // rust: m.ai.jumping = false;
    // rust: return;
}
    // rust: if !super::axolotl::is_playing_dead(m) {
    // rust: m.move_control_tick(w, events);
        // BeeLookControl: still while angry.
    // rust: if !(m.species() == Species::Bee && super::bee::angry(m, w)) {
    // rust: m.look_control_tick();
}
}
    // rust: m.jump_control_tick();
}
/// `Armadillo.pickNextScuteDropTime`: 5 to 10 minutes.
pub fn next_scute_time(m: *mut Mob) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.random.next_int_bound(20 * 60 * 5).unwrap_or(0) + 20 * 60 * 5
}
/// `Armadillo.customServerAiStep`: the scute timer keeps counting down and is
/// only reset once `shouldDropLoot` (not a baby, `mob_drops` on) lets it shed.
pub fn armadillo_server_ai_step(m: *mut Mob, mob_drops: bool, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: if !m.alive() {
    // rust: return;
}
    // rust: m.extra.egg_time -= 1;
    // rust: if m.extra.egg_time <= 0 && !m.is_baby() && mob_drops {
    // rust: let pitch = (m.random.next_float() - m.random.next_float()) * 0.2 + 1.0;
    // rust: events.push(MobEvent::ShedScute {
    // rust: mob: m.id,
    // rust: at: [m.position.x, m.position.y, m.position.z],
    // rust: pitch,
    // rust: });
    // rust: m.extra.egg_time = next_scute_time(m);
}
}
pub fn custom_server_ai_step(m: *mut Mob, cx: *mut Cx) void {
}
    // rust: match m.species() {
    // rust: Species::Rabbit => {
    // rust: let target = m.target_info(cx.w).map(|t| t.position);
    // rust: super::rabbit::server_ai_step(m, target)
}
    // rust: Species::Cat | Species::Ocelot => super::tame::feline_server_ai_step(m),
        // Armadillo.customServerAiStep: the brain and its activity, then the scute.
    // rust: Species::Armadillo => {
    // rust: super::armadillo::server_ai_step(m, cx);
    // rust: armadillo_server_ai_step(m, cx.w.mob_drops, cx.events);
}
    // rust: Species::Sheep => {}
    // rust: Species::Zombie
    // rust: | Species::Husk
    // rust: | Species::Drowned
    // rust: | Species::ZombieVillager
    // rust: | Species::Skeleton
    // rust: | Species::Stray
    // rust: | Species::Bogged
    // rust: | Species::Parched
    // rust: | Species::WitherSkeleton
    // rust: | Species::ZombifiedPiglin => undead::custom_server_ai_step(m, cx),
    // rust: Species::Vindicator => super::illager::vindicator_server_ai_step(m),
    // rust: Species::Enderman => super::enderman::custom_server_ai_step(m, cx),
    // rust: Species::Blaze => super::nether::blaze_server_ai_step(m, cx),
    // rust: Species::ElderGuardian => super::guardian::elder_server_ai_step(m, cx),
    // rust: Species::Wither if m.alive() => super::wither::custom_server_ai_step(m, cx.w, cx.events),
        // SpellcasterIllager.customServerAiStep.
    // rust: Species::Evoker | Species::Illusioner if m.extra.counter > 0 => m.extra.counter -= 1,
    // rust: Species::Bat => super::bat::server_ai_step(m, cx.w, cx.events),
    // rust: Species::Bee => super::bee::server_ai_step(m, cx),
    // rust: Species::Frog => super::frog::server_ai_step(m, cx.w),
        // Hoglin and Piglin.customServerAiStep: the brain, then updateActivity.
    // rust: Species::Piglin | Species::Hoglin => super::piglin::brain_step(m, cx),
    // rust: Species::Zoglin => super::piglin::zoglin_step(m, cx),
    // rust: _ => {}
}
}
/// Endermite.aiStep: `counter` is the life; an endermite not required to
/// persist is discarded at 2400.
pub fn endermite_lifetime(m: *mut Mob) void {
}
    // rust: if !m.persistent {
    // rust: m.extra.counter += 1;
}
    // rust: if m.extra.counter >= 2400 {
    // rust: m.removed = true;
}
}
    // rust: fn species_ai_step(
    // rust: m: &mut Mob,
    // rust: w: &MobWorld,
    // rust: level_random: &mut LegacyRandom,
    // rust: events: &mut Vec<MobEvent>,
    // rust: ) {
    // rust: if family(m.species()) == Family::Aquatic {
    // rust: aquatic::ai_step(m, w, events);
}
    // rust: match m.species() {
    // rust: Species::Enderman => super::enderman::ai_step(m, w, events),
        // Endermite.aiStep: `counter` is the life; an endermite not required
        // to persist is discarded at 2400.
    // rust: Species::Endermite => endermite_lifetime(m),
    // rust: Species::Wolf => super::tame::ai_step(m, w, events),
    // rust: Species::Cat => super::tame::cat_ai_step(m, events),
    // rust: Species::Blaze => super::nether::blaze_ai_step(m, events),
    // rust: Species::IronGolem => super::golem::iron_ai_step(m),
    // rust: Species::Piglin | Species::PiglinBrute | Species::Hoglin => {
    // rust: super::piglin::ai_step(m, w, level_random, events)
}
    // rust: Species::Zoglin if m.extra.anim_ticks > 0 => m.extra.anim_ticks -= 1,
    // rust: s if super::equine::is_equine(s) => super::equine::ai_step(m, w, events),
    // rust: Species::Phantom => super::phantom::flap_sound(m, events),
    // rust: Species::Warden => super::warden::ai_step(m, events),
    // rust: Species::Guardian | Species::ElderGuardian => super::guardian::ai_step(m, w, events),
    // rust: Species::Vex => super::vex::ai_step(m, w),
    // rust: Species::Ravager => super::ravager::ai_step(m, w, events),
    // rust: Species::Wither => super::wither::ai_step(m, w, level_random, events),
    // rust: Species::Allay => super::allay::ai_step(m),
    // rust: Species::Bee => super::bee::ai_step(m, w),
    // rust: Species::PolarBear => super::polar_bear::ai_step(m, w),
    // rust: Species::Breeze => super::breeze::ai_step(m),
    // rust: Species::Sniffer => super::sniffer::ai_step(m, events),
    // rust: Species::HappyGhast => super::happy_ghast::ai_step(m, w),
    // rust: Species::Villager => super::villager::ai_step(m, w, events),
    // rust: Species::WanderingTrader => {
    // rust: super::villager::ai_step(m, w, events);
    // rust: super::trader::ai_step(m, w);
}
    // rust: Species::Shulker => {
    // rust: super::shulker::tick(m, w, events);
    // rust: super::shulker::ai_step(m, w, level_random, events);
}
    // rust: Species::SnowGolem => super::golem::snow_ai_step(m, w, events),
    // rust: Species::CopperGolem => super::copper_golem::ai_step(m, w, events),
    // rust: Species::Slime | Species::MagmaCube => super::cube::ai_step(m, w, events),
    // rust: Species::SulfurCube => {
    // rust: super::cube::ai_step(m, w, events);
    // rust: super::sulfur_cube::ai_step(m, w, events);
}
    // rust: Species::Nautilus | Species::ZombieNautilus => super::nautilus::ai_step(m, w, events),
    // rust: Species::Chicken => farm::chicken_ai_step(m, w, events),
    // rust: Species::Parrot => super::parrot::calculate_flapping(m),
    // rust: Species::Armadillo => super::armadillo::tick(m),
    // rust: Species::Frog => super::frog::tick(m),
    // rust: Species::Goat => super::goat::tick(m),
    // rust: Species::Fox => super::fox::ai_step(m, w, events),
    // rust: Species::Turtle => super::turtle::ai_step(m, w, events),
    // rust: Species::Sheep if m.extra.anim_ticks > 0 => {
    // rust: m.extra.anim_ticks -= 1;
}
    // rust: _ => {}
}
}
/// `Entity.checkDespawn` alone, for a mob outside the entity-ticking
/// chunks. Returns false when the mob is gone.
pub fn despawn_check(m: *mut Mob, w: *MobWorld) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if m.removed {
    // rust: return false;
}
    // rust: if !check_despawn(m, w) {
    // rust: m.removed = true;
    // rust: return false;
}
    // rust: true
}
/// `Mob.requiresCustomPersistence` and its overrides: a passenger or a leashed
/// mob, a raider in a raid, an enderman carrying a block, a tame nautilus, a
/// sulfur cube holding a block or let out of a bucket, a fish or axolotl
/// let out of a bucket (`AbstractFish`/`Axolotl`: `|| fromBucket()`). The spawn
/// caps do not count these mobs either (`NaturalSpawner.createState`).
pub fn requires_custom_persistence(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: super::riders::keeps_alive(m)
    // rust: || m.extra.from_bucket
    // rust: || m.extra.leash.is_some()
    // rust: || super::raider::state(m).is_some_and(|s| s.raid_id.is_some())
    // rust: || m.species() == Species::Enderman && m.extra.carried.is_some()
    // rust: || super::nautilus::is_nautilus(m.species()) && m.extra.tame
    // rust: || m.species() == Species::SulfurCube
    // rust: && (super::sulfur_cube::has_body(m) || m.extra.scratch[3] != 0)
}
/// Mob.checkDespawn, before the tick (players are the only despawn
/// reference). Returns false when the mob is discarded.
pub fn check_despawn(m: *mut Mob, w: *MobWorld) b {
    // Implementation ported from Horizon
    return undefined;
}
    // A mannequin is a LivingEntity, which never despawns.
    // rust: if m.species() == Species::Mannequin {
    // rust: return true;
}
    // Mob.checkDespawn discards disallowed types even when persistent or NoAI.
    // rust: if w.difficulty.effective == 0.0 && !super::spawn_rules::allowed_in_peaceful(m.species()) {
    // rust: return false;
}
    // rust: let Some(p) = w.nearest_player else {
    // rust: return true;
}
    // rust: let d = m.distance_sqr(p);
    // rust: let persistent = m.persistent || requires_custom_persistence(m);
    // removeWhenFarAway: animals, villagers, golems, patrols and raiders,
    // zombie villagers being cured and ridden mobs stay, bar the two felines.
    // rust: let creature = m.kind.category == "creature";
    // rust: let feline_goes = feline_removed_when_far(m.species(), m.extra.tame || m.extra.trusting, m.age);
    // rust: let removable = !(never_removed_when_far(m.species())
    // rust: || creature && m.kind.flags.animal && !m.extra.jockey && !feline_goes
    // rust: || super::raider::keeps_alive(m, d)
    // rust: || super::zombie_villager::keeps_alive(m)
    // rust: || super::riders::keeps_alive(m));
    // MobCategory.getDespawnDistance / getNoDespawnDistance
    // rust: let despawn = if m.kind.category == "water_ambient" {
    // rust: 64.0
    // rust: } else {
    // rust: 128.0
}
    // rust: if !persistent && d > despawn * despawn && removable {
    // rust: return false;
}
    // rust: if !persistent
    // rust: && m.ai.no_action_time > 600
    // rust: && m.random.next_int_bound(800).unwrap_or(1) == 0
    // rust: && d > 32.0 * 32.0
    // rust: && removable
    // rust: {
    // rust: return false;
}
    // rust: if d < 32.0 * 32.0 {
    // rust: m.ai.no_action_time = 0;
}
    // rust: true
}
/// `Cat.removeWhenFarAway` and `Ocelot.removeWhenFarAway`: an untamed cat or an
/// untrusting ocelot is removed once it is older than 2400 ticks. That is
/// `Entity.tickCount`, not `AgeableMob.age`, which only counts a baby up to
/// adulthood. `Animal.removeWhenFarAway` keeps every other animal.
pub fn feline_removed_when_far(s: Species, tamed: bool, ticks: u32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(s, Species::Cat | Species::Ocelot) && !tamed && ticks > 2400
}
/// The types whose `removeWhenFarAway` is always false (`Villager`,
/// `WanderingTrader`, `AbstractGolem`: iron, snow and copper golems and
/// shulkers; `Allay`, `Warden`), and the wither, whose `checkDespawn` never
/// removes it for distance.
pub fn never_removed_when_far(s: Species) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(
    // rust: s,
    // rust: Species::Villager
    // rust: | Species::WanderingTrader
    // rust: | Species::IronGolem
    // rust: | Species::SnowGolem
    // rust: | Species::CopperGolem
    // rust: | Species::Shulker
    // rust: | Species::Allay
    // rust: | Species::Warden
    // rust: | Species::Wither
    // rust: )
}
/// Movement speed bonus multiplier (baby zombies are 50% faster, etc.).
pub fn speed_bonus(m: *Mob) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match m.species() {
    // rust: Species::Zombie
    // rust: | Species::Husk
    // rust: | Species::Drowned
    // rust: | Species::ZombieVillager
    // rust: | Species::ZombifiedPiglin
    // rust: | Species::Piglin
    // rust: if m.is_baby() =>
    // rust: {
    // rust: 1.5
}
    // rust: _ => 1.0,
}
}
/// The ambient, hurt and death sounds of species that pick them by state
/// (`getHurtSound` / `getDeathSound` overrides); the type's otherwise.
/// `Goat.getAmbientSound`, `Goat.getHurtSound`, and `Goat.getDeathSound`
/// select the screaming voices from the goat's saved flag.
pub fn voice_sounds(m: *Mob) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match m.species() {
    // rust: Species::Goat if m.extra.screaming => [
    // rust: "entity.goat.screaming.ambient",
    // rust: "entity.goat.screaming.hurt",
    // rust: "entity.goat.screaming.death",
    // rust: ],
    // rust: Species::Nautilus | Species::ZombieNautilus => super::nautilus::sounds(m),
    // rust: Species::SulfurCube => super::sulfur_cube::sounds(m),
    // rust: Species::Armadillo => super::armadillo::sounds(m),
        // HappyGhast.getHurtSound and getDeathSound: the ghastling's by age.
    // rust: Species::HappyGhast => super::happy_ghast::sounds(m),
        // Panda.getAmbientSound.
    // rust: Species::Panda => {
    // rust: let ambient = if super::panda::is_aggressive(m) {
    // rust: "entity.panda.aggressive_ambient"
    // rust: } else if super::panda::is_worried(m) {
    // rust: "entity.panda.worried_ambient"
    // rust: } else {
    // rust: m.kind.sounds[0]
}
    // rust: [ambient, m.kind.sounds[1], m.kind.sounds[2]]
}
        // Horse.getAmbientSound, getHurtSound and getDeathSound by age.
    // rust: Species::Horse if m.is_baby() => [
    // rust: "entity.baby_horse.ambient",
    // rust: "entity.baby_horse.hurt",
    // rust: "entity.baby_horse.death",
    // rust: ],
        // Drowned, Guardian and ElderGuardian: the hurt and death sounds by
        // water or land.
    // rust: Species::Drowned if m.fluids.in_water => [
    // rust: "entity.drowned.ambient_water",
    // rust: "entity.drowned.hurt_water",
    // rust: "entity.drowned.death_water",
    // rust: ],
    // rust: Species::Guardian if !m.fluids.in_water => [
    // rust: m.kind.sounds[0],
    // rust: "entity.guardian.hurt_land",
    // rust: "entity.guardian.death_land",
    // rust: ],
    // rust: Species::ElderGuardian if !m.fluids.in_water => [
    // rust: m.kind.sounds[0],
    // rust: "entity.elder_guardian.hurt_land",
    // rust: "entity.elder_guardian.death_land",
    // rust: ],
        // Slime and MagmaCube.getHurtSound and getDeathSound: tiny ones.
    // rust: Species::Slime if m.extra.size <= 1 => [
    // rust: m.kind.sounds[0],
    // rust: "entity.slime.hurt_small",
    // rust: "entity.slime.death_small",
    // rust: ],
    // rust: Species::MagmaCube if m.extra.size <= 1 => [
    // rust: m.kind.sounds[0],
    // rust: "entity.magma_cube.hurt_small",
    // rust: "entity.magma_cube.death_small",
    // rust: ],
        // Shulker.getHurtSound: a closed shell.
    // rust: Species::Shulker if m.extra.counter == 0 => [
    // rust: m.kind.sounds[0],
    // rust: "entity.shulker.hurt_closed",
    // rust: m.kind.sounds[2],
    // rust: ],
        // Creaking.getHurtSound: bound to a heart it sways, unbound it hands
        // the blow to `Monster.getHurtSound`. `Monster`'s own sounds are the
        // hostile pair, which the giant keeps too.
    // rust: Species::Creaking => [
    // rust: m.kind.sounds[0],
    // rust: if super::creaking::heart_bound(m) {
    // rust: "entity.creaking.sway"
    // rust: } else {
    // rust: "entity.hostile.hurt"
    // rust: },
    // rust: m.kind.sounds[2],
    // rust: ],
    // rust: Species::Giant => [
    // rust: m.kind.sounds[0],
    // rust: "entity.hostile.hurt",
    // rust: "entity.hostile.death",
    // rust: ],
        // Turtle.getHurtSound and getDeathSound by age.
    // rust: Species::Turtle if m.is_baby() => [
    // rust: m.kind.sounds[0],
    // rust: "entity.turtle.hurt_baby",
    // rust: "entity.turtle.death_baby",
    // rust: ],
        // SkeletonHorse.getAmbientSound: its own under water.
    // rust: Species::SkeletonHorse if m.fluids.eye_in_water => [
    // rust: "entity.skeleton_horse.ambient_water",
    // rust: m.kind.sounds[1],
    // rust: m.kind.sounds[2],
    // rust: ],
        // The mob's sound variant set, the baby one for a baby.
    // rust: Species::Pig | Species::Cow | Species::Chicken | Species::Wolf | Species::Cat => {
//             use super::finalize::variant_sound as v;
    // rust: match (v(m, "ambient"), v(m, "hurt"), v(m, "death")) {
    // rust: (Some(a), Some(h), Some(d)) => [a, h, d],
    // rust: _ => m.kind.sounds,
}
}
    // rust: _ => m.kind.sounds,
}
}
/// Whether `Animal.mobInteract` takes the animal's food: an adult at age 0
/// that `canFallInLove` (not in love yet) or a baby that `canAgeUp` (not age
/// locked). Tamed wolves and cats only sit or stand when it does not.
pub fn takes_food(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // `Turtle.canFallInLove` is `super.canFallInLove() && !this.hasEgg()`: a
    // turtle that already carries an egg refuses its food instead of breeding.
    // rust: let breedable =
    // rust: m.extra.in_love <= 0 && !(m.species() == Species::Turtle && super::turtle::has_egg(m));
    // rust: (m.extra.age == 0 && breedable) || (m.extra.age < 0 && !m.extra.age_locked)
}
/// `Animal.mobInteract` with its food in hand: an adult that can fall in
/// love does, a baby grows up by a tenth, and either plays its eating sound
/// (`Strider.mobInteract` plays its own afterwards). `None` when the animal
/// does not take the food; otherwise the sound to play, if any.
    // rust: pub fn feed_animal(
    // rust: m: &mut Mob,
    // rust: level: &mut impl RandomSource,
    // rust: love_cause: Option<[i32; 4]>,
    // rust: ) -> Option<Option<(&'static str, f32, f32)>> {
    // Armadillo.mobInteract: a ball takes no food.
    // rust: if super::armadillo::scared(m) {
    // rust: return None;
}
    // rust: if !takes_food(m) {
    // rust: return None;
}
    // rust: if m.extra.age == 0 {
    // rust: m.extra.in_love = 600;
    // rust: m.extra.love_player = true;
        // Animal.setInLove: the player who fed it, for a fox baby to trust.
    // rust: m.extra.love_cause = love_cause;
    // rust: } else {
        // AgeableMob.ageUp(getSpeedUpSecondsWhenFeeding(-age), true): a tenth.
    // rust: let secs = ((-m.extra.age / 20) as f32 * 0.1) as i32;
    // rust: age_up(m, secs, true);
}
    // rust: let mut sound = eating_sound(m, level);
    // rust: if m.species() == Species::Strider && !m.silent {
    // rust: let pitch = 1.0 + (m.random.next_float() - m.random.next_float()) * 0.2;
    // rust: sound = Some(("entity.strider.eat", 1.0, pitch));
}
    // rust: Some(sound)
}
/// `AgeableMob.canAgeUp`: a baby that no age lock holds back.
pub fn can_age_up(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.is_baby() && !m.extra.age_locked
}
/// `AgeableMob.canUseGoldenDandelion`: a golden dandelion in hand, a baby
/// whose particle timer has run out, and a type outside
/// `#minecraft:cannot_be_age_locked`.
    // rust: pub fn can_use_golden_dandelion(
    // rust: item: &str,
    // rust: baby: bool,
    // rust: cooldown: i32,
    // rust: cannot_be_age_locked: bool,
    // rust: ) -> bool {
    // rust: item == "minecraft:golden_dandelion" && baby && cooldown == 0 && !cannot_be_age_locked
}
/// `AgeableMob.setAgeLockedData`: a golden dandelion flips the lock, puts the
/// age back to a baby's starting age (`getBabyStartAge`) and starts the
/// particle timer (40 ticks).
pub fn set_age_locked_data(m: *mut Mob) void {
}
    // rust: m.extra.age_locked = !m.extra.age_locked;
    // rust: let start = super::finalize::baby_start_age(m.species());
    // rust: super::finalize::set_age(m, start);
    // rust: m.extra.age_lock_particle_timer = 40;
}
/// `AgeableMob.makeAgeLockedParticle`: while the golden dandelion's timer
/// runs, every other tick one pause (locked) or reset (unlocked) growth
/// particle rises above the mob (`sendParticles`, so the players are sent it).
pub fn make_age_locked_particle(m: *mut Mob, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: if m.extra.age_lock_particle_timer <= 0 {
    // rust: return;
}
    // rust: if m.extra.age_lock_particle_timer % 2 == 0 {
    // rust: let locked = m.extra.age_locked;
    // rust: let (w, h) = (f64::from(m.width()), f64::from(m.height()));
    // rust: let r = &mut m.random;
        // getRandomX(1.0), getRandomY(0.2) + getBbHeight() + 0.2F or 0, getRandomZ(1.0).
    // rust: let x = m.position.x + w * (2.0 * r.next_double() - 1.0);
    // rust: let y = m.position.y
    // rust: + h * ((2.0 * r.next_double() - 1.0) * 0.2)
    // rust: + h
    // rust: + if locked { f64::from(0.2_f32) } else { 0.0 };
    // rust: let z = m.position.z + w * (2.0 * r.next_double() - 1.0);
    // rust: events.push(MobEvent::LevelParticles {
    // rust: kind: if locked {
    // rust: "pause_mob_growth"
    // rust: } else {
    // rust: "reset_mob_growth"
    // rust: },
    // rust: at: [x, y, z],
    // rust: spread: [0.0; 3],
    // rust: speed: 0.0,
    // rust: count: 1,
    // rust: });
}
    // rust: m.extra.age_lock_particle_timer -= 1;
}
/// `AgeableMob.ageUp(seconds, forced)`: both writes go through `setAge`, whose
/// crossing is where a species' `ageBoundaryReached` runs (a goat's and a
/// hoglin's attack damage, a sulfur cube's size); a field write skipped it.
pub fn age_up(m: *mut Mob, seconds: i32, forced: bool) void {
}
    // rust: let age = m.extra.age;
    // rust: let grown = (age + seconds * 20).min(0);
    // rust: super::finalize::set_age(m, grown);
    // rust: if forced {
    // rust: m.extra.forced_age += grown - age;
    // rust: if m.extra.forced_age_timer == 0 {
    // rust: m.extra.forced_age_timer = 40;
}
}
    // rust: if m.extra.age == 0 {
    // rust: let forced_age = m.extra.forced_age;
    // rust: super::finalize::set_age(m, forced_age);
}
}
/// `Animal.playEatingSound` (empty) and its overrides, as (sound, volume,
/// pitch); `level` is the level's random. Pigs and cats play their sound
/// variant's set.
    // rust: pub fn eating_sound(
    // rust: m: &mut Mob,
    // rust: level: &mut impl RandomSource,
    // rust: ) -> Option<(&'static str, f32, f32)> {
    // Mth.randomBetween(level.getRandom(), 0.8, 1.2).
    // rust: let mut between = || level.next_float() * 0.4 + 0.8;
    // rust: let (sound, volume, pitch, entity_sound) = match m.species() {
        // makeSound: getSoundVolume, getVoicePitch.
    // rust: Species::Armadillo | Species::Pig | Species::SulfurCube => {
    // rust: let sound = match m.species() {
    // rust: Species::Armadillo => "entity.armadillo.eat",
    // rust: Species::Pig => {
    // rust: super::finalize::variant_sound(m, "eat").unwrap_or("entity.pig.eat")
}
    // rust: _ => "entity.small_sulfur_cube.eat",
}
    // rust: let pitch = m.voice_pitch();
    // rust: (sound, sound_volume(m), pitch, true)
}
        // playSound(sound, 1, 1).
    // rust: Species::Cat => (
    // rust: super::finalize::variant_sound(m, "eat").unwrap_or("entity.cat.eat"),
    // rust: 1.0,
    // rust: 1.0,
    // rust: true,
    // rust: ),
    // rust: Species::Fox => ("entity.fox.eat", 1.0, 1.0, true),
        // level().playSound(null, this, sound, NEUTRAL, volume, pitch).
    // rust: Species::Frog => ("entity.frog.eat", 2.0, 1.0, false),
    // rust: Species::Goat if m.extra.screaming => ("entity.goat.screaming.eat", 1.0, between(), false),
    // rust: Species::Goat => ("entity.goat.eat", 1.0, between(), false),
    // rust: Species::Sniffer => ("entity.sniffer.eat", 1.0, between(), false),
    // rust: _ => return None,
}
    // Entity.playSound is skipped for a silent entity.
    // rust: if entity_sound && m.silent {
    // rust: return None;
}
    // rust: Some((sound, volume, pitch))
}
pub fn sound_volume(m: *Mob) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match m.species() {
    // rust: Species::Ghast => 5.0,
    // rust: Species::HappyGhast => super::happy_ghast::volume(m),
    // rust: Species::Warden => 4.0,
    // rust: Species::Slime | Species::MagmaCube | Species::SulfurCube => {
    // rust: 0.4 * m.extra.size.max(1) as f32
}
    // rust: Species::Bat => 0.1,
    // rust: Species::Squid
    // rust: | Species::GlowSquid
    // rust: | Species::Cow
    // rust: | Species::Mooshroom
    // rust: | Species::Bee
    // rust: | Species::Allay
    // rust: | Species::Wolf => 0.4,
    // rust: s if super::equine::is_equine(s) => 0.8,
    // rust: _ => 1.0,
}
}
/// PathfinderMob.getWalkTargetValue (Animal and Monster overrides).
pub fn walk_target_value(m: *Mob, w: *MobWorld, p: [i32; 3]) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let light = || w.brightness(p[0], p[1], p[2]) - 0.5;
    // Guardian.getWalkTargetValue: water first.
    // rust: if family(m.species()) == Family::Guardian && w.fluid(p[0], p[1], p[2]) == Fluid::Water {
    // rust: return 10.0 + light();
}
    // HappyGhast.getWalkTargetValue: open air, best just above the ground.
    // rust: if m.species() == Species::HappyGhast {
    // rust: let air = |y: i32| w.facts.is_air(w.world.block(p[0], y, p[2]));
    // rust: return if !air(p[1]) {
    // rust: 0.0
    // rust: } else if air(p[1] - 1) && !air(p[1] - 2) {
    // rust: 10.0
    // rust: } else {
    // rust: 5.0
}
}
    // rust: if m.species() == Species::Strider {
    // rust: return super::strider::walk_target_value(m, w, p);
}
    // rust: if m.species() == Species::Turtle {
    // rust: return super::turtle::walk_target_value(m, w, p, light());
}
    // Hoglin.getWalkTargetValue: nowhere near a repellent, crimson nylium best.
    // rust: if m.species() == Species::Hoglin {
    // rust: let near = m.extra.repellent.is_some_and(|r| {
    // rust: let d = |i: usize| i64::from(r[i] - p[i]);
    // rust: d(0) * d(0) + d(1) * d(1) + d(2) * d(2) < 64
    // rust: });
    // rust: return if near {
    // rust: -1.0
    // rust: } else if w.block_name(p[0], p[1] - 1, p[2]) == "minecraft:crimson_nylium" {
    // rust: 10.0
    // rust: } else {
    // rust: 0.0
}
}
    // Bee.getWalkTargetValue: any air block.
    // rust: if m.species() == Species::Bee {
    // rust: return if w.facts.is_air(w.world.block(p[0], p[1], p[2])) {
    // rust: 10.0
    // rust: } else {
    // rust: 0.0
}
}
    // AbstractNautilus, Axolotl and Creaking.getWalkTargetValue: everywhere alike.
    // rust: if matches!(
    // rust: m.species(),
    // rust: Species::Nautilus | Species::ZombieNautilus | Species::Axolotl | Species::Creaking
    // rust: ) {
    // rust: return 0.0;
}
    // Silverfish.getWalkTargetValue: a block sitting on an infested host is
    // the best place to walk to, so it goes back into the stone.
    // rust: if m.species() == Species::Silverfish
    // rust: && super::hostile::is_infested_host(w.block_name(p[0], p[1] - 1, p[2]))
    // rust: {
    // rust: return 10.0;
}
    // rust: if m.hostile()
    // rust: && !matches!(
    // rust: m.species(),
    // rust: Species::Slime | Species::MagmaCube | Species::Ghast | Species::Phantom
    // rust: )
    // rust: {
    // rust: return -light();
}
    // rust: if m.kind.flags.animal {
    // rust: if w.block_name(p[0], p[1] - 1, p[2]) == "minecraft:grass_block" {
    // rust: return 10.0;
}
    // rust: return light();
}
    // rust: 0.0
}
/// `Allay.hurtServer`'s liked-player guard for verified player sources.
/// Other species and unresolved callers retain their existing filters.
    // rust: pub fn accepts_damage_from_player(
    // rust: m: &mut Mob,
    // rust: source: &Damage,
    // rust: amount: f32,
    // rust: uuid: [i32; 4],
    // rust: ) -> bool {
    // rust: if m.species() == Species::Allay {
    // rust: !super::allay::is_liked_player(m, source.attacker, uuid)
    // rust: } else {
    // rust: accepts_damage(m, source, amount)
}
}
/// Species damage filters (LivingEntity.hurtServer overrides).
pub fn accepts_damage(m: *mut Mob, source: *Damage, _amount: f32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match m.species() {
    // rust: Species::Breeze => super::breeze::accepts_damage(m, source),
        // Compatibility for unresolved player sources; verified UUID routes
        // use accepts_damage_from_player instead (this is not UUID parity).
    // rust: Species::Allay if m.extra.tame && source.attacker == Some(Who::Player) => false,
    // rust: Species::Creaking => super::creaking::accepts_damage(m, source),
    // rust: Species::Wither => super::wither::accepts(m, source.kind, source.attacker, false),
    // rust: Species::Warden => super::warden::accepts_damage(m, source),
    // rust: Species::Shulker => super::shulker::accepts(m, source),
        // Bat.hurtServer: a hit wakes it.
    // rust: Species::Bat => {
    // rust: super::bat::hurt(m);
    // rust: true
}
    // rust: Species::Bee => {
    // rust: super::bee::hurt(m);
    // rust: true
}
        // Wolf.hurtServer, Parrot.hurtServer: a hit it isn't invulnerable to
        // stands it up before LivingEntity.hurtServer, even one the hurt
        // frames then turn away.
    // rust: Species::Wolf | Species::Parrot => {
    // rust: super::tame::stand_when_hurt(m);
    // rust: true
}
        // Panda.hurtServer: up first, whatever the damage.
    // rust: Species::Panda => {
    // rust: super::panda::hurt(m);
    // rust: true
}
    // rust: Species::Silverfish => {
    // rust: super::hostile::silverfish_hurt(m, source);
    // rust: true
}
    // rust: Species::Enderman => super::enderman::on_damage(m, source),
    // rust: Species::WitherSkeleton | Species::Blaze | Species::MagmaCube | Species::Strider
    // rust: if source.is_fire() =>
    // rust: {
    // rust: false
}
    // rust: _ => true,
}
}
/// Reactions after taking damage (sounds, anger).
pub fn after_hurt(m: *mut Mob, source: *Damage) void {
}
    // rust: m.ai.no_action_time = 0;
    // rust: match m.species() {
    // rust: Species::Enderman => super::enderman::after_hurt(m, source),
    // rust: Species::Armadillo => super::armadillo::after_hurt(m, source),
    // rust: Species::Shulker => super::shulker::after_hurt(m),
    // rust: Species::Warden => super::warden::hurt(m, source),
    // rust: Species::Nautilus | Species::ZombieNautilus => super::nautilus::after_hurt(m, source),
    // rust: Species::Zombie
    // rust: | Species::Husk
    // rust: | Species::Drowned
    // rust: | Species::ZombieVillager
    // rust: | Species::ZombifiedPiglin => super::undead::after_hurt(m, source),
        // NeutralMob: an iron golem hit by the player stays angry a while.
        // PiglinAi.wasHurtBy: drop what is being admired, no admiring for
        // a while after a player's hit, and anger.
    // rust: Species::Piglin if source.attacker == Some(Who::Player) => {
    // rust: super::piglin::stop_admiring(m);
    // rust: m.extra.egg_time = 400;
    // rust: m.extra.anger = 600;
}
    // rust: Species::IronGolem if source.attacker == Some(Who::Player) => {
    // rust: m.extra.anger = 400 + m.random.next_int_bound(380).unwrap_or(0);
}
    // rust: _ => {}
}
}
/// Mob.doHurtTarget: attack damage (+ species extras) to the target.
pub fn do_hurt_target(m: *mut Mob, who: Who, cx: *mut Cx) void {
}
    // rust: if m.species() == Species::IronGolem {
    // rust: return super::golem::iron_hurt_target(m, who, cx);
}
    // rust: if m.species() == Species::Bee {
    // rust: return super::bee::sting(m, who, cx);
}
    // rust: if matches!(m.species(), Species::Hoglin | Species::Zoglin) {
    // rust: return super::piglin::hoglin_hurt_target(m, who, cx);
}
    // rust: if m.species() == Species::Ravager {
    // rust: super::ravager::on_attack(m, cx.events);
}
    // rust: if m.species() == Species::Panda {
    // rust: super::panda::bit(m);
}
    // rust: if super::creaking::is_creaking(m) {
    // rust: super::creaking::on_attack(m, cx.events);
}
    // rust: let mut amount = super::gear::attack_damage(m, cx.w.items);
    // rust: let from = [m.position.x, m.position.y, m.position.z];
    // rust: let source = Damage::mob(m.id, from).with_species(m.species());
    // rust: let first_event = cx.events.len();
    // `CaveSpider`, `Husk` and `WitherSkeleton.doHurtTarget` all test
    // `target instanceof LivingEntity`, so the effect reaches a mob the hit
    // lands on and not only the player.
    // rust: match m.species() {
        // CaveSpider.doHurtTarget: poison for 7 s on normal, 15 s on hard.
    // rust: Species::CaveSpider if cx.w.difficulty.base >= 2 => {
    // rust: cx.events.push(MobEvent::EffectPlayer {
    // rust: effect: "minecraft:poison",
    // rust: ticks: if cx.w.difficulty.base == 2 { 7 } else { 15 } * 20,
    // rust: amplifier: 0,
    // rust: ambient: false,
    // rust: })
}
        // Husk.doHurtTarget: hunger for 140 ticks per whole point of the
        // local difficulty, only with an empty main hand.
    // rust: Species::Husk if m.extra.main_hand.is_none() => {
    // rust: let ticks = 140 * cx.w.difficulty.effective as i32;
    // rust: if ticks > 0 {
    // rust: cx.events.push(MobEvent::EffectPlayer {
    // rust: effect: "minecraft:hunger",
    // rust: ticks,
    // rust: amplifier: 0,
    // rust: ambient: false,
    // rust: })
}
}
    // rust: Species::WitherSkeleton => cx.events.push(MobEvent::EffectPlayer {
    // rust: effect: "minecraft:wither",
    // rust: ticks: 200,
    // rust: amplifier: 0,
    // rust: ambient: false,
    // rust: }),
    // rust: _ => {}
}
    // rust: if amount <= 0.0 {
    // rust: amount = 1.0;
}
    // The held weapon's enchantments: Sharpness, Smite, Bane of Arthropods,
    // Fire Aspect and Knockback.
    // rust: let target_species = match who {
    // rust: Who::Mob(id) => cx.w.seen(id).map(|s| s.species),
    // rust: Who::Player => None,
}
    // rust: amount += super::gear::melee_bonus(m, target_species);
    // rust: let burn = super::gear::fire_aspect(m);
    // rust: if burn > 0 {
    // rust: cx.events.push(MobEvent::Ignite {
    // rust: target: who,
    // rust: seconds: burn,
    // rust: });
}
    // `Mob.doHurtTarget`: `causeExtraKnockback(target, getKnockback(...))`. `getKnockback` is the
    // `attack_knockback` attribute plus the Knockback enchantment, halved; the push goes along the
    // attacker's facing through `LivingEntity.knockback` (so the target's resistance applies), and
    // slows the attacker.
    // rust: let power = (m.attrs.attack_knockback as f32 + super::gear::knockback(m) as f32) / 2.0;
    // rust: if power > 0.0 {
//         use horizon_core::geometry::trig::Mth;
    // rust: let to_rad = std::f32::consts::PI / 180.0;
    // rust: cx.events.push(MobEvent::Knockback {
    // rust: target: who,
    // rust: power: f64::from(power),
    // rust: x: f64::from((m.yaw * to_rad).msin()),
    // rust: z: f64::from(-(m.yaw * to_rad).mcos()),
    // rust: source,
    // rust: });
    // rust: m.velocity = Vec3::new(m.velocity.x * 0.6, m.velocity.y, m.velocity.z * 0.6);
}
    // Zombies set their target on fire while burning (Zombie.doHurtTarget).
    // rust: if m.fire_ticks > 0 && matches!(m.species(), Species::Zombie) && m.random.next_float() < 0.3 {
    // rust: cx.events.push(MobEvent::Ignite {
    // rust: target: who,
    // rust: seconds: 2,
    // rust: });
}
    // The effect picked above goes with the hit: it applies only when the
    // target takes damage (a shield-blocked hit gives none), for a mob as for
    // the player, since those `doHurtTarget`s take any `LivingEntity`.
    // rust: let effect = cx.events[first_event..]
    // rust: .iter()
    // rust: .position(|e| matches!(e, MobEvent::EffectPlayer { .. }))
    // rust: .and_then(|k| match cx.events.remove(first_event + k) {
    // rust: MobEvent::EffectPlayer {
    // rust: effect,
    // rust: ticks,
    // rust: amplifier,
    // rust: ..
    // rust: } => Some((effect, ticks, amplifier)),
    // rust: _ => None,
    // rust: });
    // rust: match who {
    // rust: Who::Player => cx.events.push(match effect {
    // rust: Some((effect, ticks, amplifier)) => MobEvent::AttackPlayerWithEffect {
    // rust: amount,
    // rust: from,
    // rust: effect,
    // rust: ticks,
    // rust: amplifier,
    // rust: },
    // rust: None => MobEvent::AttackPlayer(amount, from),
    // rust: }),
    // rust: Who::Mob(id) => cx.events.push(match effect {
    // rust: Some((effect, ticks, amplifier)) => MobEvent::AttackMobWithEffect {
    // rust: target: id,
    // rust: amount,
    // rust: source,
    // rust: effect,
    // rust: ticks,
    // rust: amplifier,
    // rust: },
    // rust: None => MobEvent::AttackMob {
    // rust: target: id,
    // rust: amount,
    // rust: source,
    // rust: },
    // rust: }),
}
    // Mob.doHurtTarget ends with playAttackSound once the hit landed.
    // rust: if super::creaking::is_creaking(m) {
    // rust: m.voice("entity.creaking.attack", cx.events);
}
    // Rabbit.playAttackSound: only the killer bunny.
    // rust: if m.species() == Species::Rabbit {
    // rust: super::rabbit::attack_sound(m, cx.events);
}
    // Panda.playAttackSound: playSound(PANDA_BITE, 1.0, 1.0).
    // rust: if m.species() == Species::Panda && !m.silent {
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: cx.events
    // rust: .push(MobEvent::Sound("entity.panda.bite", at, 1.0, 1.0));
}
    // Axolotl.playAttackSound: playSound(AXOLOTL_ATTACK, 1.0, 1.0).
    // rust: if m.species() == Species::Axolotl && !m.silent {
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: cx.events
    // rust: .push(MobEvent::Sound("entity.axolotl.attack", at, 1.0, 1.0));
}
    // Dolphin.playAttackSound: playSound(DOLPHIN_ATTACK, 1.0, 1.0), once
    // the blow landed. A dolphin that is hurt takes its attacker as a target
    // and strikes with the melee goal, so its bite is heard as it lands.
    // rust: if m.species() == Species::Dolphin && !m.silent {
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: cx.events
    // rust: .push(MobEvent::Sound("entity.dolphin.attack", at, 1.0, 1.0));
}
    // rust: let _ = Fluid::None;
}
/// Mob.ate: `gameEvent(GameEvent.EAT)`, then (Sheep.ate) the wool grows back and a baby
/// grows.
pub fn ate(m: *mut Mob, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: events.push(MobEvent::GameEvent {
    // rust: event: "minecraft:eat",
    // rust: at: [m.position.x, m.position.y, m.position.z],
    // rust: source: m.id,
    // rust: state: horizon_world::registry::BlockStateId(0),
    // rust: });
    // rust: if m.species() == Species::Sheep {
    // rust: m.extra.sheared = false;
        // Sheep.ate: only a baby `canAgeUp` (no age lock holds it) grows.
    // rust: if can_age_up(m) {
            // AgeableMob.ageUp(60)
    // rust: age_up(m, 60, false);
}
}
}
/// `NeutralMob.playerDied` for a mob that is neutral: the anger at the
/// player who died ends. The caller checks `forgive_dead_players`.
pub fn forgive_dead_player(m: *mut Mob) void {
}
    // rust: match m.species() {
    // rust: Species::Bee => super::bee::forgive_dead_player(m),
    // rust: Species::PolarBear => super::polar_bear::forgive_dead_player(m),
        // The enderman's and zombified piglin's persistent anger is the
        // target they hold (the stare goal, the hurt-by path): vanilla's
        // `NeutralMob.playerDied` ends it through `stopBeingAngry` when it
        // is the player who died, the last hurt by with it.
    // rust: Species::Enderman | Species::ZombifiedPiglin => {
    // rust: if m.ai.target == Some(Who::Player) {
    // rust: m.ai.last_hurt_by = None;
    // rust: m.ai.last_hurt_by_time = m.age as i32;
    // rust: m.ai.target = None;
}
}
        // The iron golem keeps a timer and its target (the hurt-by goal
        // after a player's hit).
    // rust: Species::IronGolem => {
    // rust: if m.extra.anger > 0 && m.ai.target == Some(Who::Player) {
    // rust: m.ai.last_hurt_by = None;
    // rust: m.ai.last_hurt_by_time = m.age as i32;
    // rust: m.extra.anger = 0;
    // rust: m.ai.target = None;
}
}
    // rust: _ => super::tame::forgive_dead_player(m),
}
}
/// Species-specific travel (fish, squid, dolphins swim with their own rules).
pub fn custom_travel(m: *mut Mob, w: *MobWorld, input: Vec3, events: *mut std.ArrayList(MobEvent)) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if m.species() == Species::Drowned {
    // rust: return undead::drowned_travel(m, w, input, events);
}
    // rust: if m.species() == Species::Turtle {
    // rust: return super::turtle::travel(m, w, input, events);
}
    // rust: if m.species() == Species::Frog {
    // rust: return super::frog::travel(m, w, input, events);
}
    // rust: match family(m.species()) {
    // rust: Family::Aquatic => aquatic::travel(m, w, input, events),
    // rust: Family::Guardian => super::guardian::travel(m, w, input, events),
        // Shulkers never move on their own.
    // rust: Family::Shulker => true,
    // rust: Family::Allay => super::allay::travel(m, w, input, events),
    // rust: Family::Vex => super::vex::travel(m),
    // rust: Family::Nautilus => super::nautilus::travel(m, w, input, events),
    // rust: _ => false,
}
}

/// `Entity.applyEffectsFromBlocks` for the flowers that give an effect:
/// `WitherRoseBlock.entityInside` (wither for 40 ticks on a living mob that
/// can take it, not in peaceful) and `EyeblossomBlock.entityInside` (poison
/// for 25 ticks on a bee, when the open flower attracts bees). The blocks
/// are those the mob's box touches where it started the tick and where it
/// ended.
pub fn flower_contact_effects(m: *mut Mob, w: *MobWorld) void {
}
    // rust: if !m.alive() {
    // rust: return;
}
    // rust: let half = f64::from(m.width()) / 2.0 - 1.0e-5;
    // rust: let height = f64::from(m.height()) - 1.0e-5;
    // rust: let mut visited: Vec<[i32; 3]> = Vec::new();
    // rust: for at in [m.previous, m.position] {
    // rust: let cells = |lo: f64, hi: f64| lo.floor() as i32..=hi.floor() as i32;
    // rust: for x in cells(at.x - half, at.x + half) {
    // rust: for y in cells(at.y + 1.0e-5, at.y + height) {
    // rust: for z in cells(at.z - half, at.z + half) {
    // rust: let p = [x, y, z];
    // rust: if visited.contains(&p) {
    // rust: continue;
}
    // rust: match w.block_name(x, y, z) {
    // rust: "minecraft:wither_rose" => {
                            // World difficulty, not the regional one, and
                            // isInvulnerableTo(wither) (the invulnerable
                            // flag, not the hit timer); a wither and a wither
                            // skeleton refuse the effect in `addEffect`.
    // rust: if w.difficulty.base != 0 && !m.invulnerable_flag {
    // rust: m.add_effect("minecraft:wither", 40, 0);
}
}
    // rust: "minecraft:open_eyeblossom"
    // rust: if m.species() == Species::Bee
    // rust: && super::bee::attracts_bees(w, p)
    // rust: && !m.has_effect("minecraft:poison") =>
    // rust: {
    // rust: m.add_effect("minecraft:poison", 25, 0);
}
    // rust: _ => continue,
}
    // rust: visited.push(p);
}
}
}
}
}

/// MobEffect ticking for the effects mobs receive (poison, wither,
/// regeneration), and a content mod's on a server.
pub fn tick_effects(m: *mut Mob, mods: ?*dyn super::ModEffectTicks) void {
}
    // LivingEntity.tickEffects ticks each active effect with the mob's list
    // still in place: the damage a Poison or Wither tick deals reads the
    // list it finds (Resistance softens the hit, Infested spawns silverfish,
    // a totem adds its effects to it). An effect a tick appends ticks from
    // the next tick on.
    // rust: let first = m.extra.effects.len();
    // rust: let mut i = 0;
    // rust: while i < m.extra.effects.len() && i < first {
    // rust: let (effect, amp) = (m.extra.effects[i].0, m.extra.effects[i].2);
        // MobEffectInstance.tickServer: an infinite (-1) effect times its
        // ticks by the mob's tickCount and never counts down.
    // rust: let infinite = m.extra.effects[i].1 == -1;
        // MobEffectInstance.tickServer: hasRemainingDuration is false at 0, so the
        // instance ticks nothing; LivingEntity.tickEffects drops it below.
    // rust: if !infinite && m.extra.effects[i].1 == 0 {
    // rust: i += 1;
    // rust: continue;
}
    // rust: let count = if infinite {
    // rust: m.age as i32
    // rust: } else {
    // rust: m.extra.effects[i].1
}
    // rust: let interval = |base: i32| (base >> amp.max(0)).max(1);
        // A refused mod effect is left at 0 ticks for the retain below.
    // rust: let mut expired = false;
    // rust: match effect {
    // rust: "minecraft:poison"
    // rust: if count % interval(25) == 0 && !m.kind.flags.undead && m.health > 1.0 =>
    // rust: {
    // rust: m.damage(1.0, Damage::of(DamageKind::Magic));
}
    // rust: "minecraft:wither" if count % interval(40) == 0 => {
                // WitherMobEffect.applyEffectTick: damageSources().wither().
    // rust: m.damage(1.0, Damage::of(DamageKind::Wither));
}
            // InstantenousMobEffect: applied on every tick it has time left
            // (`/effect give` keeps the effect listed for its few ticks; the hit
            // frames let a harming one through once).
    // rust: "minecraft:instant_damage" | "minecraft:instant_health" if count >= 1 => {
    // rust: m.apply_heal_or_harm(
    // rust: effect == "minecraft:instant_damage",
    // rust: m.kind.flags.undead,
    // rust: amp,
    // rust: 1.0,
    // rust: );
}
    // rust: "minecraft:regeneration"
    // rust: if count % interval(50) == 0 && !m.kind.flags.undead && m.alive() =>
    // rust: {
    // rust: m.heal(1.0);
}
    // rust: id if horizon_client_core::potions::is_mod_effect(id) => {
                // tickServer: one with no ticks left goes unasked.
    // rust: if !infinite && m.extra.effects[i].1 <= 0 {
    // rust: i += 1;
    // rust: continue;
}
    // rust: if let Some(mods) = mods
    // rust: && !mods.tick_mod_effect(id, m.id, count, amp)
    // rust: {
                    // Removed before it counts down.
    // rust: expired = true;
}
}
    // rust: _ => {}
}
    // rust: if !infinite && m.extra.effects.get(i).is_some_and(|e| e.0 == effect) {
    // rust: let ticks = &mut m.extra.effects[i].1;
    // rust: *ticks = if expired { 0 } else { *ticks - 1 };
}
    // rust: i += 1;
}
    // AbsorptionMobEffect.removeAttributeModifiers: the hearts it gave go with it.
    // rust: for i in 0..m.extra.effects.len() {
    // rust: let e = m.extra.effects[i];
    // rust: if e.0 == "minecraft:absorption" && e.1 <= 0 && e.1 != -1 {
    // rust: m.absorption = (m.absorption - 4.0 * (e.2 + 1) as f32).max(0.0);
}
}
    // rust: m.extra.effects.retain(|e| e.1 > 0 || e.1 == -1);
    // rust: m.extra
    // rust: .hidden_effects
    // rust: .retain(|h| m.extra.effects.iter().any(|e| e.0 == *h));
    // rust: m.extra
    // rust: .ambient_effects
    // rust: .retain(|h| m.extra.effects.iter().any(|e| e.0 == *h));
}

/// `Entity.getMovementEmission` is not NONE: only a shulker moves without
/// emitting anything at all, neither events nor sounds.
pub fn emits_movement(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !matches!(m.species(), Species::Shulker)
}
/// `Entity.getMovementEmission` includes sounds (`MovementEmission.ALL`): a
/// silverfish, an endermite, a bat, a squid and a glow squid, a guardian, an
/// elder guardian and a breeze answer `EVENTS`, which keeps their footfalls and
/// swim strokes quiet while `Entity.vibrationAndSoundEffectsFromBlock` still
/// sends the step game event. Every other type is `ALL`.
pub fn movement_sounds(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !matches!(
    // rust: m.species(),
    // rust: Species::Silverfish
    // rust: | Species::Endermite
    // rust: | Species::Bat
    // rust: | Species::Squid
    // rust: | Species::GlowSquid
    // rust: | Species::Guardian
    // rust: | Species::ElderGuardian
    // rust: | Species::Breeze
    // rust: )
}
/// `playStepSound`: the species' footstep, or the block's step sound at 15%.
    // rust: pub fn step_sound(
    // rust: m: &Mob,
    // rust: w: &MobWorld,
    // rust: pos: [i32; 3],
    // rust: state: horizon_world::registry::BlockStateId,
    // rust: ) -> Option<(&'static str, f32, f32)> {
//     use Species as S;
    // rust: let baby = m.is_baby();
    // rust: let quiet = |s: &'static str| Some((s, 0.15, 1.0));
    // rust: match m.species() {
        // `playStepSound` overridden with an empty body: a fish, an allay, a bee,
        // a happy ghast and a nautilus have no footfall of their own, so the
        // block's step sound is not taken either.
    // rust: S::Allay
    // rust: | S::Bee
    // rust: | S::Cod
    // rust: | S::Salmon
    // rust: | S::TropicalFish
    // rust: | S::Pufferfish
    // rust: | S::Tadpole
    // rust: | S::HappyGhast
    // rust: | S::Nautilus
    // rust: | S::ZombieNautilus => None,
    // rust: S::Armadillo => quiet("entity.armadillo.step"),
    // rust: S::Chicken | S::Cow | S::Pig | S::Wolf => {
    // rust: super::finalize::variant_sound(m, "step").and_then(quiet)
}
    // rust: S::Mooshroom => quiet("entity.cow.step"),
    // rust: S::Llama | S::TraderLlama => quiet("entity.llama.step"),
    // rust: S::Frog => quiet("entity.frog.step"),
    // rust: S::Goat => quiet("entity.goat.step"),
    // rust: S::Panda => quiet("entity.panda.step"),
    // rust: S::Parrot => quiet("entity.parrot.step"),
    // rust: S::PolarBear => quiet("entity.polar_bear.step"),
    // rust: S::Sheep => quiet("entity.sheep.step"),
    // rust: S::Sniffer => quiet("entity.sniffer.step"),
    // rust: S::Turtle if baby => quiet("entity.turtle.shamble_baby"),
    // rust: S::Turtle => quiet("entity.turtle.shamble"),
    // rust: S::Creaking => quiet("entity.creaking.step"),
    // rust: S::Hoglin => quiet("entity.hoglin.step"),
    // rust: S::Zoglin => quiet("entity.zoglin.step"),
    // rust: S::Piglin => quiet("entity.piglin.step"),
    // rust: S::PiglinBrute => quiet("entity.piglin_brute.step"),
    // rust: S::Ravager => quiet("entity.ravager.step"),
    // rust: S::Skeleton => quiet("entity.skeleton.step"),
    // rust: S::Stray => quiet("entity.stray.step"),
    // rust: S::Bogged => quiet("entity.bogged.step"),
    // rust: S::Parched => quiet("entity.parched.step"),
    // rust: S::WitherSkeleton => quiet("entity.wither_skeleton.step"),
    // rust: S::Spider | S::CaveSpider => quiet("entity.spider.step"),
        // Silverfish.playStepSound and Endermite.playStepSound: both ask for
        // their own step at 15%, though neither type's movement emission plays
        // it (`movement_sounds`).
    // rust: S::Silverfish => quiet("entity.silverfish.step"),
    // rust: S::Endermite => quiet("entity.endermite.step"),
    // rust: S::Zombie | S::ZombifiedPiglin => quiet("entity.zombie.step"),
    // rust: S::Husk => quiet("entity.husk.step"),
    // rust: S::Drowned => quiet("entity.drowned.step"),
    // rust: S::ZombieVillager => quiet("entity.zombie_villager.step"),
        // Camel.playStepSound and CamelHusk.playStepSound: sand and concrete
        // powder have their own step.
    // rust: S::CamelHusk | S::Camel => {
    // rust: let sand = w.has_tag(
    // rust: "minecraft:camel_sand_step_sound_blocks",
    // rust: &w.facts.get(state).name,
    // rust: );
    // rust: Some(match (m.species(), sand) {
    // rust: (S::Camel, true) => ("entity.camel.step_sand", 1.0, 1.0),
    // rust: (S::Camel, false) => ("entity.camel.step", 1.0, 1.0),
    // rust: (_, true) => ("entity.camel_husk.step_sand", 0.4, 1.0),
    // rust: (_, false) => ("entity.camel_husk.step", 0.4, 1.0),
    // rust: })
}
    // rust: S::IronGolem => Some(("entity.iron_golem.step", 1.0, 1.0)),
        // CopperGolem.playStepSound: its oxidation level's step.
    // rust: S::CopperGolem => Some((super::copper_golem::sound(m, "step"), 1.0, 1.0)),
    // rust: S::Strider if m.fluids.in_lava => Some(("entity.strider.step_lava", 1.0, 1.0)),
    // rust: S::Strider => Some(("entity.strider.step", 1.0, 1.0)),
    // rust: S::Warden => Some(("entity.warden.step", 10.0, 1.0)),
    // rust: _ => {
            // Entity.playStepSound: the block's sound type.
    // rust: let _ = pos;
    // rust: let sounds = &w.facts.get(state).sounds;
    // rust: let step: &'static str = super::ai::intern_sound(&sounds.step);
    // rust: Some((step, sounds.volume * 0.15, sounds.pitch))
}
}
}
/// A block sound id as a static string (the block facts intern them).
pub fn intern_sound(s: *std::sync::*str) * {
    // Implementation ported from Horizon
    return undefined;
}
//     use std::{collections::HashSet, sync::Mutex};
pub const NAMES: Mutex<?std.AutoHashMap(*'static str, void)> = Mutex::new(None);
    // rust: let mut names = NAMES.lock().unwrap_or_else(|e| e.into_inner());
    // rust: let set = names.get_or_insert_with(HashSet::new);
    // rust: let key = s.strip_prefix("minecraft:").unwrap_or(s);
    // rust: if let Some(found) = set.get(key) {
    // rust: return found;
}
    // rust: let leaked: &'static str = Box::leak(key.to_owned().into_boxed_str());
    // rust: set.insert(leaked);
    // rust: leaked
}
/// `getSwimSound`. A skeleton horse's own override counts the steps it takes
/// through the water, so it needs the mob, not just its species.
pub fn swim_sound(m: *mut Mob) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if m.species() == Species::SkeletonHorse {
    // rust: return super::equine::skeleton_horse_swim_sound(m);
}
    // rust: match m.species() {
    // rust: Species::Drowned => "entity.drowned.swim",
    // rust: Species::Axolotl => "entity.axolotl.swim",
    // rust: Species::Dolphin => "entity.dolphin.swim",
    // rust: Species::Cod
    // rust: | Species::Salmon
    // rust: | Species::TropicalFish
    // rust: | Species::Pufferfish
    // rust: | Species::Tadpole => "entity.fish.swim",
    // rust: Species::Nautilus if m.is_baby() => "entity.baby_nautilus.swim",
    // rust: Species::Nautilus => "entity.nautilus.swim",
    // rust: Species::ZombieNautilus => "entity.zombie_nautilus.swim",
    // rust: Species::Turtle => "entity.turtle.swim",
        // Monster.getSwimSound, and Hoglin's own override of it.
    // rust: s if s == Species::Hoglin || is_monster(s) => "entity.hostile.swim",
    // rust: _ => "entity.generic.swim",
}
}

    // rust: mod bucket_axolotl_tests {
//     use super::*;
pub fn bucket_axolotl_uses_aquatic_not_generic_land_ai() void {
}
    // rust: assert_eq!(family(Species::Axolotl), Family::Aquatic);
}
}
    // rust: mod despawn_tests {
//     use super::*;
    /// Village villagers are placed without PersistenceRequired (unlike the
    /// village's iron golem), so they must never despawn for distance.
pub fn villagers_traders_and_golems_never_despawn_for_distance() void {
}
    // rust: for s in [
    // rust: Species::Villager,
    // rust: Species::WanderingTrader,
    // rust: Species::IronGolem,
    // rust: Species::SnowGolem,
    // rust: Species::CopperGolem,
    // rust: Species::Shulker,
    // rust: ] {
    // rust: assert!(never_removed_when_far(s), "{s:?}");
}
    // rust: for s in [Species::Zombie, Species::ZombieVillager, Species::Pillager] {
    // rust: assert!(!never_removed_when_far(s), "{s:?}");
}
}

    /// `Cat.removeWhenFarAway` (`!isTame() && tickCount > 2400`) and
    /// `Ocelot.removeWhenFarAway` (`!isTrusting() && tickCount > 2400`): the two
    /// animals vanilla lets go, on `Entity.tickCount` and never on
    /// `AgeableMob.age`, which an adult keeps at 0.
pub fn an_untamed_feline_goes_once_it_is_old() void {
}
    // rust: for s in [Species::Cat, Species::Ocelot] {
    // rust: assert!(!feline_removed_when_far(s, false, 2400), "{s:?}");
    // rust: assert!(feline_removed_when_far(s, false, 2401), "{s:?}");
    // rust: assert!(!feline_removed_when_far(s, true, 12000), "{s:?}");
}
        // Animal.removeWhenFarAway: every other animal stays at any age.
    // rust: for s in [Species::Cow, Species::Sheep, Species::Wolf] {
    // rust: assert!(!feline_removed_when_far(s, false, 12000), "{s:?}");
}
}
}

    // rust: mod frog_tests {
//     use super::*;
//     use crate::mobs::MobTypes;
//     use crate::mobs::control::MoveKind;
//     use std::sync::Arc;

    /// `Frog()`: `new SmoothSwimmingMoveControl<>(this, 85, 10, 0.02F, 0.1F, true)`.
    /// The frog's movement speed is 1.0, so the controller's 0.1 outside-water
    /// speed is what keeps a walking frog at vanilla's pace. The plain ground
    /// controller walks it ten times too fast, which is the jitter, the
    /// teleporting and the flying of #2213.
pub fn a_frog_walks_at_the_vanilla_speed() void {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("entity-types.json").exists() {
    // rust: return;
}
    // rust: let data = MobTypes::load(&root).unwrap();
    // rust: let kind = Arc::new(data.types.get("minecraft:frog").unwrap().clone());
    // rust: assert_eq!(kind.speed, 1.0, "the frog's movement speed attribute");
    // rust: let mut m = Mob::new(1, kind, Vec3::new(0.0, 4.0, 0.0), 0.0);
    // rust: register(&mut m);
    // rust: assert_eq!(
    // rust: m.ai.mov.kind,
    // rust: MoveKind::SmoothSwimming {
    // rust: max_turn_x: 85.0,
    // rust: max_turn_y: 10.0,
    // rust: in_water: 0.02,
    // rust: outside: 0.1,
    // rust: gravity: true,
}
    // rust: );
}
}

    // rust: mod poison_effect_tests {
//     use super::*;
//     use crate::mobs::MobTypes;
//     use std::sync::Arc;

pub fn poison_effect_damages_living_mobs_but_not_undead() void {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("entity-types.json").exists() {
    // rust: return;
}
    // rust: let data = MobTypes::load(&root).unwrap();

        // Pig is not undead: should take damage from poison.
    // rust: let pig_kind = Arc::new(data.types.get("minecraft:pig").unwrap().clone());
    // rust: let mut pig = Mob::new(1, pig_kind, Vec3::new(0.0, 4.0, 0.0), 0.0);
    // rust: pig.add_effect("poison", 100, 0);
    // rust: assert_eq!(pig.extra.effects[0].0, "minecraft:poison");
    // rust: let initial_pig_health = pig.health;
    // rust: tick_effects(&mut pig, None);
    // rust: assert_eq!(
    // rust: pig.health,
    // rust: initial_pig_health - 1.0,
    // rust: "living mob should take 1.0 damage from poison"
    // rust: );

        // Zombie is undead: immune to poison damage.
    // rust: let zombie_kind = Arc::new(data.types.get("minecraft:zombie").unwrap().clone());
    // rust: let mut zombie = Mob::new(2, zombie_kind, Vec3::new(0.0, 4.0, 0.0), 0.0);
    // rust: zombie.add_effect("poison", 100, 0);
    // rust: let initial_zombie_health = zombie.health;
    // rust: tick_effects(&mut zombie, None);
    // rust: assert_eq!(
    // rust: zombie.health, initial_zombie_health,
    // rust: "undead mobs are immune to poison"
    // rust: );
}

    /// A mob's effects act on it: instant health and harm (inverted for the
    /// undead), Resistance taking 20% a level off a hit, Absorption soaking
    /// damage before health, Slow Falling capping gravity while it falls.
pub fn mob_effects_heal_harm_resist_absorb_and_slow_the_fall() void {
}
//         use std::sync::Arc;
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("entity-types.json").exists() {
    // rust: return;
}
    // rust: let data = MobTypes::load(&root).unwrap();
    // rust: let make = |name: &str| {
    // rust: let kind = Arc::new(data.types.get(name).unwrap().clone());
    // rust: let mut m = Mob::new(1, kind, Vec3::new(0.0, 4.0, 0.0), 0.0);
    // rust: m.attrs.max_health = 100.0;
    // rust: m.health = 60.0;
    // rust: m
}
        // instant_health 1 heals 8 a tick, instant_damage 0 hurts 6 once (hit frames).
    // rust: let mut golem = make("minecraft:iron_golem");
    // rust: golem.add_effect("instant_health", 6, 1);
    // rust: tick_effects(&mut golem, None);
    // rust: assert_eq!(golem.health, 68.0);
    // rust: let mut golem = make("minecraft:iron_golem");
    // rust: golem.add_effect("instant_damage", 6, 0);
    // rust: tick_effects(&mut golem, None);
    // rust: assert_eq!(golem.health, 54.0);
        // The undead are healed by harm.
    // rust: let mut zombie = make("minecraft:zombie");
    // rust: zombie.add_effect("instant_damage", 6, 0);
    // rust: tick_effects(&mut zombie, None);
    // rust: assert_eq!(zombie.health, 64.0);
        // Resistance V (amplifier 4) takes it all, III takes 80%.
    // rust: let mut golem = make("minecraft:iron_golem");
    // rust: golem.health = 100.0;
    // rust: golem.add_effect("resistance", 100, 4);
    // rust: golem.damage(5.0, Damage::of(DamageKind::Generic));
    // rust: assert_eq!(golem.health, 100.0);
    // rust: let mut golem = make("minecraft:iron_golem");
    // rust: golem.health = 100.0;
    // rust: golem.add_effect("resistance", 100, 2);
    // rust: golem.damage(10.0, Damage::of(DamageKind::Generic));
    // rust: assert_eq!(golem.health, 96.0);
        // Absorption II: 8 hearts-halves, 5 damage leaves 3 and costs no health.
    // rust: let mut golem = make("minecraft:iron_golem");
    // rust: golem.health = 100.0;
    // rust: golem.add_effect("absorption", 100, 1);
    // rust: assert_eq!(golem.absorption, 8.0);
    // rust: golem.damage(5.0, Damage::of(DamageKind::Generic));
    // rust: assert_eq!((golem.health, golem.absorption), (100.0, 3.0));
        // Slow Falling: gravity floors at 0.01 while falling, not while rising.
    // rust: let mut pig = make("minecraft:pig");
    // rust: let full = pig.effective_gravity();
    // rust: pig.add_effect("slow_falling", 100, 0);
    // rust: assert!(full > 0.01);
    // rust: assert_eq!(pig.effective_gravity(), 0.01);
    // rust: pig.velocity.y = 0.5;
    // rust: assert_eq!(pig.effective_gravity(), full);
}

    /// `LivingEntity.tickEffects` ticks each effect with the mob's list in
    /// place: a Poison hit reads Resistance there (0.8 of 1.0 at level I).
pub fn effect_ticks_find_the_other_effects() void {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("entity-types.json").exists() {
    // rust: return;
}
    // rust: let data = MobTypes::load(&root).unwrap();
    // rust: let pig_kind = Arc::new(data.types.get("minecraft:pig").unwrap().clone());
    // rust: let mut pig = Mob::new(1, pig_kind.clone(), Vec3::new(0.0, 4.0, 0.0), 0.0);
    // rust: pig.health = 20.0;
    // rust: pig.extra.effects.push(("minecraft:poison", 25, 0));
    // rust: pig.extra.effects.push(("minecraft:resistance", -1, 0));
    // rust: tick_effects(&mut pig, None);
    // rust: assert_eq!(pig.health, 19.2);
        // `onMobHurt` finds Infested in the same in-place list: the hurt mob
        // leaves a silverfish call in the outbox.
    // rust: let mut pig = Mob::new(2, pig_kind.clone(), Vec3::new(0.0, 4.0, 0.0), 0.0);
    // rust: pig.extra.effects.push(("minecraft:poison", 25, 0));
    // rust: pig.extra.effects.push(("minecraft:infested", -1, 0));
    // rust: tick_effects(&mut pig, None);
    // rust: assert!(
    // rust: pig.outbox
    // rust: .iter()
    // rust: .any(|e| matches!(e, MobEvent::Infested { .. })),
    // rust: "a hurt while infested pushes Infested"
    // rust: );
}

    /// `MobEffectInstance.hasRemainingDuration` is false at 0 ticks, so an effect
    /// loaded with `duration: 0` is over on its first tick instead of counting
    /// down to -1, the value that means infinite.
pub fn a_zero_duration_effect_is_dropped_not_made_infinite() void {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("entity-types.json").exists() {
    // rust: return;
}
    // rust: let data = MobTypes::load(&root).unwrap();
    // rust: let pig_kind = Arc::new(data.types.get("minecraft:pig").unwrap().clone());
    // rust: let mut pig = Mob::new(1, pig_kind, Vec3::new(0.0, 4.0, 0.0), 0.0);
    // rust: pig.health = 20.0;
    // rust: pig.extra.effects.push(("minecraft:poison", 0, 0));
    // rust: tick_effects(&mut pig, None);
    // rust: assert!(pig.extra.effects.is_empty());
        // A poison with no remaining duration does not get its first tick either.
    // rust: assert_eq!(pig.health, 20.0);
}

    /// `checkTotemDeathProtection` inside a tick's damage adds the totem's
    /// effects to the live list: they stay on the mob after the tick.
pub fn a_totem_fired_by_effect_damage_keeps_its_effects() void {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("entity-types.json").exists() {
    // rust: return;
}
    // rust: let data = MobTypes::load(&root).unwrap();
    // rust: let pig_kind = Arc::new(data.types.get("minecraft:pig").unwrap().clone());
    // rust: let mut pig = Mob::new(1, pig_kind, Vec3::new(0.0, 4.0, 0.0), 0.0);
    // rust: pig.extra
    // rust: .set_main_hand(Some("minecraft:totem_of_undying".into()));
    // rust: pig.extra.effects.push(("minecraft:instant_damage", 5, 4));
    // rust: tick_effects(&mut pig, None);
    // rust: assert_eq!(pig.health, 1.0);
    // rust: for effect in [
    // rust: "minecraft:regeneration",
    // rust: "minecraft:absorption",
    // rust: "minecraft:fire_resistance",
    // rust: ] {
    // rust: assert!(
    // rust: pig.extra.effects.iter().any(|e| e.0 == effect && e.1 > 0),
    // rust: "{effect} kept after the totem fired"
    // rust: );
}
}

    /// `WitherMobEffect.applyEffectTick` hurts with `wither`, not `magic`:
    /// the damage the tick deals keeps its kind.
pub fn the_wither_effect_hurts_with_wither() void {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("entity-types.json").exists() {
    // rust: return;
}
    // rust: let data = MobTypes::load(&root).unwrap();
    // rust: let pig_kind = Arc::new(data.types.get("minecraft:pig").unwrap().clone());
    // rust: let mut pig = Mob::new(1, pig_kind, Vec3::new(0.0, 4.0, 0.0), 0.0);
    // rust: pig.extra.effects.push(("minecraft:wither", 40, 0));
    // rust: tick_effects(&mut pig, None);
    // rust: assert_eq!(
    // rust: pig.last_damage.map(|(d, _)| d.kind),
    // rust: Some(DamageKind::Wither)
    // rust: );
}
}

    // rust: mod hit_effect_tests {
//     use super::*;
//     use crate::mobs::world::with_test_world;
//     use std::sync::Arc;

    /// The effects of a cave spider's bite, a bare-handed husk's blow and a
    /// wither skeleton's hit go to the `LivingEntity` the hit landed on:
    /// `doHurtTarget` tests `target instanceof LivingEntity`, not `Player`.
    /// Biting a mob carries the effect with the hit — poison for 140 ticks on
    /// normal, hunger for 140 (effective difficulty 1.5), wither for 200 —
    /// where the mob is hit 2. Without the fix each of these is a plain
    /// `AttackMob` and the mob keeps no effect at all (0 ticks).
pub fn a_melee_effect_rides_the_hit_onto_a_mob() void {
}
    // rust: let cases = [
    // rust: ("minecraft:cave_spider", "minecraft:poison", 140),
    // rust: ("minecraft:husk", "minecraft:hunger", 140),
    // rust: ("minecraft:wither_skeleton", "minecraft:wither", 200),
    // rust: ];
    // rust: let mut carried: Vec<(&str, Option<(u32, &'static str, i32, i32)>)> = Vec::new();
    // rust: let mut strays: Vec<(&str, bool, bool)> = Vec::new();
    // rust: let ran = with_test_world(&[], |w, types| {
    // rust: for (kind, _, _) in cases {
    // rust: let mut m = Mob::new(
    // rust: 1,
    // rust: Arc::new(types.types[kind].clone()),
    // rust: Vec3::new(0.5, 64.0, 0.5),
    // rust: 0.0,
    // rust: );
    // rust: let (mut lr, mut events) = (horizon_core::random::LegacyRandom::new(0), Vec::new());
    // rust: let mut cx = Cx {
    // rust: w,
    // rust: lr: &mut lr,
    // rust: events: &mut events,
}
    // rust: do_hurt_target(&mut m, Who::Mob(2), &mut cx);
    // rust: carried.push((
    // rust: kind,
    // rust: events.iter().find_map(|e| match e {
    // rust: MobEvent::AttackMobWithEffect {
    // rust: target,
    // rust: effect,
    // rust: ticks,
    // rust: amplifier,
    // rust: ..
    // rust: } => Some((*target, *effect, *ticks, *amplifier)),
    // rust: _ => None,
    // rust: }),
    // rust: ));
    // rust: strays.push((
    // rust: kind,
    // rust: events
    // rust: .iter()
    // rust: .any(|e| matches!(e, MobEvent::EffectPlayer { .. })),
    // rust: events
    // rust: .iter()
    // rust: .any(|e| matches!(e, MobEvent::AttackMob { .. })),
    // rust: ));
}
    // rust: });
    // rust: if !ran {
    // rust: return;
}
    // rust: let expected: Vec<(&str, Option<(u32, &'static str, i32, i32)>)> = cases
    // rust: .iter()
    // rust: .map(|(kind, effect, ticks)| (*kind, Some((2, *effect, *ticks, 0))))
    // rust: .collect();
    // rust: assert_eq!(carried, expected);
    // rust: for (kind, on_player, effectless) in strays {
    // rust: assert!(!on_player, "{kind} left its effect on the player");
    // rust: assert!(!effectless, "{kind} sent a second, effectless hit");
}
}

    /// On easy the cave spider's poison timer is 0, so nothing rides the hit:
    /// the mob it bites takes the damage alone (`AttackMob`, no effect).
pub fn an_easy_cave_spiders_bite_carries_no_effect() void {
}
    // rust: let mut out: Option<Vec<String>> = None;
    // rust: let ran = with_test_world(&[], |w, types| {
    // rust: let mut easy = w.clone();
    // rust: easy.difficulty = super::super::spawning::LocalDifficulty::new(1, 18000, 0, 0.0);
    // rust: let mut m = Mob::new(
    // rust: 1,
    // rust: Arc::new(types.types["minecraft:cave_spider"].clone()),
    // rust: Vec3::new(0.5, 64.0, 0.5),
    // rust: 0.0,
    // rust: );
    // rust: let (mut lr, mut events) = (horizon_core::random::LegacyRandom::new(0), Vec::new());
    // rust: let mut cx = Cx {
    // rust: w: &easy,
    // rust: lr: &mut lr,
    // rust: events: &mut events,
}
    // rust: do_hurt_target(&mut m, Who::Mob(2), &mut cx);
    // rust: out = Some(
    // rust: events
    // rust: .iter()
    // rust: .filter(|e| {
    // rust: matches!(
    // rust: e,
    // rust: MobEvent::AttackMob { .. } | MobEvent::AttackMobWithEffect { .. }
    // rust: )
    // rust: })
    // rust: .map(|e| match e {
    // rust: MobEvent::AttackMob { target, .. } => format!("plain {target}"),
    // rust: MobEvent::AttackMobWithEffect { effect, .. } => format!("effect {effect}"),
    // rust: _ => unreachable!(),
    // rust: })
    // rust: .collect(),
    // rust: );
    // rust: });
    // rust: if !ran {
    // rust: return;
}
    // rust: assert_eq!(out, Some(vec!["plain 2".to_owned()]));
}
}

    // rust: mod attack_sound_tests {
//     use super::*;
//     use crate::mobs::world::with_test_world;
//     use std::sync::Arc;

    /// The sounds `do_hurt_target` raises for `kind` on a blow that landed,
    /// with `silent` set on the attacker; `None` without the extracted data.
pub fn attack_sounds(kind: []const u8, silent: bool) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut heard = Vec::new();
    // rust: let ran = with_test_world(&[], |w, types| {
    // rust: let mut m = Mob::new(
    // rust: 1,
    // rust: Arc::new(types.types[kind].clone()),
    // rust: Vec3::new(0.5, 64.0, 0.5),
    // rust: 0.0,
    // rust: );
    // rust: m.silent = silent;
    // rust: let (mut lr, mut events) = (horizon_core::random::LegacyRandom::new(0), Vec::new());
    // rust: let mut cx = Cx {
    // rust: w,
    // rust: lr: &mut lr,
    // rust: events: &mut events,
}
    // rust: do_hurt_target(&mut m, Who::Mob(2), &mut cx);
    // rust: heard = events
    // rust: .iter()
    // rust: .filter_map(|e| match e {
    // rust: MobEvent::Sound(s, _, volume, pitch) => Some((*s, *volume, *pitch)),
    // rust: _ => None,
    // rust: })
    // rust: .collect();
    // rust: });
    // rust: if !ran {
    // rust: return None;
}
    // rust: Some(heard)
}

    /// `Mob.doHurtTarget` ends with `playAttackSound`, which `Dolphin`,
    /// `Axolotl` and `Panda` override with their own bite at volume 1 and
    /// pitch 1. Without the dolphin arm its bite is silent (no sound event at
    /// all); the axolotl and the panda sit next to it as the control.
pub fn a_dolphins_blow_plays_its_attack_sound() void {
}
    // rust: let Some(dolphin) = attack_sounds("minecraft:dolphin", false) else {
    // rust: return;
}
    // rust: assert_eq!(dolphin, vec![("entity.dolphin.attack", 1.0, 1.0)]);
    // rust: for (kind, sound) in [
    // rust: ("minecraft:axolotl", "entity.axolotl.attack"),
    // rust: ("minecraft:panda", "entity.panda.bite"),
    // rust: ] {
    // rust: assert_eq!(
    // rust: attack_sounds(kind, false),
    // rust: Some(vec![(sound, 1.0, 1.0)]),
    // rust: "{kind}"
    // rust: );
}
        // Entity.playSound skips a silent entity, so neither attack sound plays.
    // rust: for kind in ["minecraft:dolphin", "minecraft:axolotl", "minecraft:panda"] {
    // rust: assert_eq!(attack_sounds(kind, true), Some(vec![]), "{kind}");
}
}
}

    // rust: mod same_vehicle_push_tests {
//     use super::*;
//     use crate::mobs::world::with_test_world;

    /// What a mob holds and wears, by `EquipmentSlot`: the hand's item, the
    /// worn armour's stack (a dyed piece keeps its colour), a horse's
    /// armour in the body slot and its saddle, and nothing else.
pub fn a_mobs_equipment_is_listed_by_slot() void {
}
    // rust: with_test_world(&[], |_, types| {
    // rust: let mob = |name: &str| {
    // rust: Mob::new(
    // rust: 1,
    // rust: std::sync::Arc::new(types.types[name].clone()),
    // rust: Vec3::new(0.5, 64.0, 0.5),
    // rust: 0.0,
    // rust: )
}
    // rust: let mut zombie = mob("minecraft:zombie");
    // rust: assert!(zombie.equipment_stacks().iter().all(Option::is_none));
    // rust: zombie
    // rust: .extra
    // rust: .set_main_hand(Some(std::sync::Arc::from("minecraft:iron_sword")));
    // rust: zombie.extra.feet = Some(std::sync::Arc::from("minecraft:iron_boots"));
    // rust: let worn = zombie.equipment_stacks();
    // rust: assert_eq!(
    // rust: worn[0].as_ref().unwrap().item.as_ref(),
    // rust: "minecraft:iron_sword"
    // rust: );
    // rust: assert_eq!(
    // rust: worn[2].as_ref().unwrap().item.as_ref(),
    // rust: "minecraft:iron_boots"
    // rust: );
    // rust: assert_eq!(worn.iter().flatten().count(), 2);
    // rust: let mut horse = mob("minecraft:horse");
    // rust: horse.extra.body = Some(std::sync::Arc::from("minecraft:iron_horse_armor"));
    // rust: horse.set_saddle(Some(crate::items::ItemStack::new("minecraft:saddle", 1)));
    // rust: let gear = horse.equipment_stacks();
    // rust: assert_eq!(
    // rust: gear[6].as_ref().unwrap().item.as_ref(),
    // rust: "minecraft:iron_horse_armor"
    // rust: );
    // rust: assert_eq!(gear[7].as_ref().unwrap().item.as_ref(), "minecraft:saddle");
    // rust: assert!(gear[5].is_none());
    // rust: });
}

    /// `Entity.push(Entity)` returns at once for `isPassengerOfSameVehicle`
    /// (the same `getRootVehicle`): a camel and the husk on its back, seated
    /// half a block toward its front and so inside its box, never push each
    /// other (#3199). The camel still pushes a mob that only overlaps it.
pub fn a_camel_and_its_rider_never_push_each_other() void {
}
        // The mobs the camel pushes, and its velocity after, with these mobs
        // around: a husk on its back, and a zombie standing in its back half.
    // rust: let push = |zombie_too: bool| {
    // rust: let mut out = None;
    // rust: let mut riders = Vec::new();
    // rust: with_test_world(&[], |_, types| {
    // rust: let mob = |id: u32, name: &str, at: Vec3| {
    // rust: Mob::new(id, std::sync::Arc::new(types.types[name].clone()), at, 0.0)
}
    // rust: let mut camel = mob(1, "minecraft:camel", Vec3::new(0.5, 64.0, 0.5));
    // rust: let mut husk = mob(2, "minecraft:husk", Vec3::new(0.5, 65.5, 1.0));
    // rust: camel.extra.rider = Some(husk.id);
    // rust: husk.extra.mount = Some(camel.id);
    // rust: riders.push(husk.seen(None));
    // rust: if zombie_too {
    // rust: riders.push(mob(3, "minecraft:zombie", Vec3::new(0.5, 64.0, 0.0)).seen(None));
}
    // rust: out = Some(camel);
    // rust: });
    // rust: let mut camel = out?;
    // rust: let mut events = Vec::new();
    // rust: with_test_world(&riders, |w, _| push_entities(&mut camel, w, &mut events));
    // rust: let pushed: Vec<u32> = events
    // rust: .iter()
    // rust: .filter_map(|e| match e {
    // rust: MobEvent::Push {
    // rust: target: Who::Mob(id),
    // rust: ..
    // rust: } => Some(*id),
    // rust: _ => None,
    // rust: })
    // rust: .collect();
    // rust: Some((pushed, camel.velocity))
}
    // rust: let Some((pushed, velocity)) = push(false) else {
    // rust: return;
}
    // rust: assert_eq!(pushed, Vec::<u32>::new(), "the camel pushes its own rider");
    // rust: assert_eq!(velocity, Vec3::ZERO, "its rider pushes the camel");
    // rust: let (pushed, _) = push(true).unwrap();
    // rust: assert_eq!(pushed, vec![3], "the camel pushes the zombie");
}

pub fn a_ridden_horse_is_not_pushed_but_still_pushes() void {
}
    // rust: let pair = |ridden: bool| {
    // rust: let mut out = None;
    // rust: with_test_world(&[], |_, types| {
    // rust: let mob = |id: u32, name: &str, at: Vec3| {
    // rust: Mob::new(id, std::sync::Arc::new(types.types[name].clone()), at, 0.0)
}
    // rust: let mut horse = mob(1, "minecraft:horse", Vec3::new(0.5, 64.0, 0.5));
    // rust: if ridden {
    // rust: horse.extra.rider = Some(3);
}
    // rust: let cow = mob(2, "minecraft:cow", Vec3::new(1.4, 64.0, 0.5));
    // rust: out = Some((horse, cow));
    // rust: });
    // rust: out
}
    // rust: let pushed = |events: &[MobEvent]| -> Vec<u32> {
    // rust: events
    // rust: .iter()
    // rust: .filter_map(|e| match e {
    // rust: MobEvent::Push {
    // rust: target: Who::Mob(id),
    // rust: ..
    // rust: } => Some(*id),
    // rust: _ => None,
    // rust: })
    // rust: .collect()
}
    // rust: let Some((mut horse, cow)) = pair(true) else {
    // rust: return;
}
    // rust: let mut events = Vec::new();
    // rust: with_test_world(&[cow.seen(None)], |w, _| {
    // rust: push_entities(&mut horse, w, &mut events)
    // rust: });
    // rust: assert_eq!(pushed(&events), vec![2], "the ridden horse pushes the cow");
    // rust: assert_eq!(
    // rust: horse.velocity,
    // rust: Vec3::ZERO,
    // rust: "the cow pushes the ridden horse"
    // rust: );

    // rust: let (horse, mut cow) = pair(true).unwrap();
    // rust: let mut events = Vec::new();
    // rust: with_test_world(&[horse.seen(None)], |w, _| {
    // rust: push_entities(&mut cow, w, &mut events)
    // rust: });
    // rust: assert_eq!(
    // rust: pushed(&events),
    // rust: Vec::<u32>::new(),
    // rust: "the cow pushes the ridden horse"
    // rust: );
    // rust: assert!(cow.velocity.x > 0.0, "the ridden horse pushes the cow away");

    // rust: let (horse, mut cow) = pair(false).unwrap();
    // rust: let mut events = Vec::new();
    // rust: with_test_world(&[horse.seen(None)], |w, _| {
    // rust: push_entities(&mut cow, w, &mut events)
    // rust: });
    // rust: assert_eq!(
    // rust: pushed(&events),
    // rust: vec![1],
    // rust: "the cow pushes a horse nobody rides"
    // rust: );
}
}

    // rust: mod warden_push_tests {
//     use super::*;
//     use crate::mobs::warden::{Pose, set_pose};
//     use crate::mobs::world::{test_player, with_test_world};

pub fn a_warden_in_the_ground_does_not_take_collision_pushes() void {
}
    // rust: with_test_world(&[], |world, types| {
    // rust: let mob = |id, kind: &str, x| {
    // rust: Mob::new(
    // rust: id,
    // rust: std::sync::Arc::new(types.types[kind].clone()),
    // rust: Vec3::new(x, 64.0, 0.5),
    // rust: 0.0,
    // rust: )
}
    // rust: for pose in [Pose::Emerging, Pose::Digging, Pose::Standing] {
    // rust: let mut warden = mob(1, "minecraft:warden", 0.5);
    // rust: set_pose(&mut warden, pose);
    // rust: let standing = pose == Pose::Standing;
    // rust: assert_eq!(warden.pushable(), standing, "{pose:?}");
    // rust: assert_eq!(warden.seen(None).pushable, standing, "{pose:?}");

                // The warden's tick: an overlapping mob must not move it.
    // rust: let mut cow = mob(2, "minecraft:cow", 1.0);
    // rust: let others = [cow.seen(None)];
    // rust: let mut w = world.clone();
    // rust: w.others = &others;
    // rust: let mut events = Vec::new();
    // rust: push_entities(&mut warden, &w, &mut events);
    // rust: assert_eq!(warden.velocity.x != 0.0, standing, "mob: {pose:?}");
                // Non-pushable is not an early return: it still pushes others.
    // rust: assert!(events.iter().any(|e| matches!(
    // rust: e,
    // rust: MobEvent::Push {
    // rust: target: Who::Mob(2),
    // rust: ..
}
    // rust: )));

                // The other mob's tick: the warden's Seen must exclude it.
    // rust: let others = [warden.seen(None)];
    // rust: w.others = &others;
    // rust: events.clear();
    // rust: push_entities(&mut cow, &w, &mut events);
    // rust: let pushes_warden = events.iter().any(|e| {
    // rust: matches!(
    // rust: e,
    // rust: MobEvent::Push {
    // rust: target: Who::Mob(1),
    // rust: ..
}
    // rust: )
    // rust: });
    // rust: assert_eq!(pushes_warden, standing, "other tick: {pose:?}");

                // The player branch of the warden's tick has its own target path.
    // rust: w.others = &[];
    // rust: w.player = Some(test_player(Vec3::new(1.0, 64.0, 0.5)));
    // rust: warden.velocity = Vec3::ZERO;
    // rust: events.clear();
    // rust: push_entities(&mut warden, &w, &mut events);
    // rust: assert_eq!(warden.velocity.x != 0.0, standing, "player: {pose:?}");
}
    // rust: });
}
}

    // rust: mod ridden_tests {
//     use super::*;
//     use crate::mobs::world::with_test_world;

    /// #2920: a saddled horse ridden forward, ticked on the server; with
    /// `client` its rider's client moves it (`travelRidden` without
    /// `canSimulateMovement`): it only turns to the rider's look and stops.
pub fn ridden(client: bool) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = None;
    // rust: with_test_world(&[], |w, types| {
    // rust: let kind = std::sync::Arc::new(types.types["minecraft:horse"].clone());
    // rust: let mut m = Mob::new(1, kind, Vec3::new(0.5, 64.0, 0.5), 0.0);
    // rust: m.set_saddle(Some(crate::items::ItemStack::new("minecraft:saddle", 1)));
    // rust: m.persistent = true;
    // rust: m.rider = Some(super::super::equine::Rider {
    // rust: forward: 1.0,
    // rust: yaw: 90.0,
    // rust: client,
    // rust: ..Default::default()
    // rust: });
    // rust: let (mut random, mut events) = (LegacyRandom::new(0), Vec::new());
    // rust: for _ in 0..5 {
    // rust: tick(&mut m, w, &mut random, &mut events);
}
    // rust: out = Some(m);
    // rust: });
    // rust: out
}

pub fn the_server_leaves_a_horse_to_its_riders_client() void {
}
    // rust: let Some(moved) = ridden(false) else {
    // rust: return;
}
        // The host's own ride: the horse walks west and falls through the air.
    // rust: assert!(moved.position.x < 0.4, "{:?}", moved.position);
    // rust: assert!(moved.position.y < 64.0, "{:?}", moved.position);
    // rust: let held = ridden(true).unwrap();
    // rust: assert_eq!(held.position, Vec3::new(0.5, 64.0, 0.5));
    // rust: assert_eq!(held.velocity, Vec3::ZERO);
    // rust: assert_eq!(held.yaw, 90.0, "tickRidden still turns it");
}
}

    // rust: mod bed_wake_tests {
//     use super::*;
//     use crate::mobs::world::with_test_world;

    /// `LivingEntity.tick` wakes a sleeper whose bed is gone before
    /// `aiStep` — `Mob.no_ai` skips the step, not the check (#7875).
pub fn no_ai_sleeper() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = None;
    // rust: with_test_world(&[], |w, types| {
    // rust: let kind = std::sync::Arc::new(types.types["minecraft:villager"].clone());
    // rust: let mut m = Mob::new(1, kind, Vec3::new(0.5, 64.0, 0.5), 0.0);
    // rust: m.no_ai = true;
    // rust: let mut events = Vec::new();
            // The empty world is all air: the "bed" it lies in is gone.
    // rust: assert!(super::super::villager::start_sleeping(
    // rust: &mut m,
    // rust: [0, 64, 0],
    // rust: w,
    // rust: &mut events
    // rust: ));
    // rust: let mut random = LegacyRandom::new(0);
    // rust: tick(&mut m, w, &mut random, &mut events);
    // rust: out = Some(m);
    // rust: });
    // rust: out
}

pub fn a_sleeper_without_ai_still_stands_when_its_bed_is_gone() void {
}
    // rust: let Some(m) = no_ai_sleeper() else { return };
    // rust: assert!(
    // rust: !super::super::villager::sleeping(&m),
    // rust: "a missing bed wakes a no-AI sleeper"
    // rust: );
}
}

    // rust: mod turtle_ambient_tests {
//     use super::*;
//     use std::sync::Arc;

pub fn turtle() M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut kind = crate::mobs::sensor_scan_tests::kind();
    // rust: let k = Arc::make_mut(&mut kind);
    // rust: k.id = "minecraft:turtle".into();
    // rust: k.species = Species::Turtle;
    // rust: Mob::new(1, kind, Vec3::ZERO, 0.0)
}

    /// `Turtle.getAmbientSound`: land ambient only for an adult on the ground
    /// and out of water.
pub fn a_turtle_is_silent_in_water_in_the_air_and_as_a_baby() void {
}
    // rust: let mut m = turtle();
    // rust: m.on_ground = true;
    // rust: assert!(!turtle_ambient_silent(&m));
    // rust: m.on_ground = false;
    // rust: assert!(turtle_ambient_silent(&m));
    // rust: m.on_ground = true;
    // rust: m.fluids.in_water = true;
    // rust: assert!(turtle_ambient_silent(&m));
}
}

    // rust: mod feed_tests {
//     use super::*;
//     use crate::mobs::MobTypes;
//     use std::sync::Arc;

    /// `Animal.mobInteract` (#2780): food grows a tamed baby cat or wolf
    /// (`canAgeUp`), so `Wolf.mobInteract` and `Cat.mobInteract` see the click
    /// consumed and do not make it sit. Only an adult that cannot breed now,
    /// or an age-locked baby, leaves the food to the sit toggle.
pub fn food_grows_a_tamed_baby_cat_or_wolf() void {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("entity-types.json").exists() {
    // rust: return;
}
    // rust: let data = MobTypes::load(&root).unwrap();
    // rust: let mut level = LegacyRandom::new(0);
    // rust: for id in ["minecraft:wolf", "minecraft:cat"] {
    // rust: let kind = Arc::new(data.types.get(id).unwrap().clone());
    // rust: let mut m = Mob::new(1, kind, Vec3::new(0.0, 4.0, 0.0), 0.0);
    // rust: m.extra.tame = true;
    // rust: m.extra.age = -24000;
    // rust: assert!(takes_food(&m), "{id}: a tamed baby takes its food");
    // rust: assert!(feed_animal(&mut m, &mut level, None).is_some(), "{id}");
            // getSpeedUpSecondsWhenFeeding(24000): a tenth of 1200 seconds.
    // rust: assert_eq!(m.extra.age, -24000 + 120 * 20, "{id}: grew a tenth");
    // rust: assert_eq!(m.extra.in_love, 0, "{id}: a baby does not fall in love");

    // rust: m.extra.age_locked = true;
    // rust: assert!(!takes_food(&m), "{id}: an age-locked baby cannot grow");
    // rust: m.extra.age_locked = false;

    // rust: m.extra.age = 0;
    // rust: assert!(takes_food(&m), "{id}: an adult can breed");
    // rust: m.extra.in_love = 600;
    // rust: assert!(!takes_food(&m), "{id}: already in love");
    // rust: m.extra.in_love = 0;
    // rust: m.extra.age = 6000;
    // rust: assert!(!takes_food(&m), "{id}: breeding cooldown");
}
}

    /// `Turtle.canFallInLove` (#8612): a turtle that already carries an egg
    /// cannot fall in love, so `Animal.mobInteract` refuses its food — it is
    /// neither eaten nor turned into love mode.
pub fn a_turtle_carrying_an_egg_refuses_its_food() void {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("entity-types.json").exists() {
    // rust: return;
}
    // rust: let data = MobTypes::load(&root).unwrap();
    // rust: let mut level = LegacyRandom::new(0);
    // rust: let kind = Arc::new(data.types.get("minecraft:turtle").unwrap().clone());
    // rust: let mut m = Mob::new(1, kind, Vec3::new(0.0, 4.0, 0.0), 0.0);
    // rust: m.extra.age = 0;

    // rust: m.extra.flag = true;
    // rust: assert!(crate::mobs::turtle::has_egg(&m));
    // rust: assert!(!takes_food(&m), "an egg-carrying turtle refuses its food");
    // rust: assert!(
    // rust: feed_animal(&mut m, &mut level, None).is_none(),
    // rust: "and does not enter love mode"
    // rust: );
    // rust: assert_eq!(m.extra.in_love, 0);

    // rust: m.extra.flag = false;
    // rust: assert!(takes_food(&m), "a turtle without an egg takes it");
    // rust: assert!(feed_animal(&mut m, &mut level, None).is_some());
    // rust: assert_eq!(m.extra.in_love, 600);
}
}

    // rust: mod forgiveness_tests {
//     use super::*;
//     use std::sync::Arc;

pub fn mob(species: Species) M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut t = (*crate::mobs::sensor_scan_tests::kind()).clone();
    // rust: t.species = species;
    // rust: Mob::new(1, Arc::new(t), Vec3::ZERO, 0.0)
}

    /// The enderman's and zombified piglin's persistent anger is the target
    /// they hold: a dying player they are angry at takes it (and the last
    /// hurt by) with them, as `NeutralMob.playerDied` does through
    /// `stopBeingAngry`.
pub fn a_target_anger_at_the_dying_player_ends() void {
}
    // rust: for species in [Species::Enderman, Species::ZombifiedPiglin] {
    // rust: let mut m = mob(species);
    // rust: m.ai.target = Some(Who::Player);
    // rust: m.ai.last_hurt_by = Some(Who::Player);
    // rust: forgive_dead_player(&mut m);
    // rust: assert_eq!(m.ai.target, None, "{species:?}");
    // rust: assert_eq!(m.ai.last_hurt_by, None, "{species:?}");
            // Anger at something else is not the dying player's to end.
    // rust: let mut m = mob(species);
    // rust: m.ai.target = Some(Who::Mob(7));
    // rust: forgive_dead_player(&mut m);
    // rust: assert_eq!(m.ai.target, Some(Who::Mob(7)), "{species:?}");
}
}

    /// The iron golem's anger is a timer and its target: the dying player
    /// they were hurt by ends both, and anger at another mob stays.
pub fn an_iron_golems_timer_and_target_end_together() void {
}
    // rust: let mut golem = mob(Species::IronGolem);
    // rust: golem.extra.anger = 300;
    // rust: golem.ai.target = Some(Who::Player);
    // rust: golem.ai.last_hurt_by = Some(Who::Player);
    // rust: forgive_dead_player(&mut golem);
    // rust: assert_eq!(golem.extra.anger, 0);
    // rust: assert_eq!(golem.ai.target, None);
    // rust: assert_eq!(golem.ai.last_hurt_by, None);

    // rust: let mut golem = mob(Species::IronGolem);
    // rust: golem.extra.anger = 300;
    // rust: golem.ai.target = Some(Who::Mob(7));
    // rust: forgive_dead_player(&mut golem);
    // rust: assert_eq!(golem.extra.anger, 300, "anger at another mob stays");
    // rust: assert_eq!(golem.ai.target, Some(Who::Mob(7)));
}
}

    // rust: mod endermite_goal_tests {
//     use super::*;
//     use crate::mobs::world::with_test_world;

    /// `Endermite.registerGoals` is the silverfish's family list without the
    /// stone tricks: a powder-snow climb, a stroll at 1.0 and a
    /// `HurtByTargetGoal` that alerts the others. The generic monster block
    /// an unlisted species gets has none of those (stroll 0.8, no alert).
pub fn an_endermite_takes_the_hostile_goal_list() void {
}
    // rust: let ran = with_test_world(&[], |_, types| {
    // rust: let m = Mob::new(
    // rust: 1,
    // rust: std::sync::Arc::new(types.types["minecraft:endermite"].clone()),
    // rust: Vec3::ZERO,
    // rust: 0.0,
    // rust: );
    // rust: assert_eq!(family(m.species()), Family::Hostile);
    // rust: assert!(
    // rust: m.ai.goals.has("ClimbOnTopOfPowderSnow"),
    // rust: "ClimbOnTopOfPowderSnowGoal"
    // rust: );
    // rust: assert!(m.ai.goals.has("Stroll"), "WaterAvoidingRandomStrollGoal");
    // rust: assert!(m.ai.targets.has("HurtByTarget"));
    // rust: assert!(m.ai.targets.has("NearestTarget"));
    // rust: });
    // rust: let _ = ran;
}
}

    // rust: mod villager_ambient_tests {
//     use super::*;
//     use crate::mobs::world::with_test_world;

    /// The ambient sound one tick of `play_ambient` makes, after `setup`.
    // rust: fn sound(
    // rust: w: &MobWorld<'_>,
    // rust: types: &crate::mobs::MobTypes,
    // rust: kind: &str,
    // rust: setup: impl FnOnce(&mut Mob),
    // rust: ) -> Option<&'static str> {
    // rust: let mut m = Mob::new(
    // rust: 1,
    // rust: std::sync::Arc::new(types.types[kind].clone()),
    // rust: Vec3::new(0.5, 64.0, 0.5),
    // rust: 0.0,
    // rust: );
    // rust: setup(&mut m);
    // rust: let mut events = Vec::new();
    // rust: play_ambient(&mut m, w, &mut events);
    // rust: events.into_iter().find_map(|e| match e {
    // rust: MobEvent::Sound(s, ..) => Some(s),
    // rust: _ => None,
    // rust: })
}

    /// `Villager.getAmbientSound`: silent while asleep, the trade sound while a
    /// player has its menu open, ambient otherwise. `WanderingTrader` only has
    /// the trade branch.
pub fn a_villager_is_silent_asleep_and_noisy_while_trading() void {
}
    // rust: with_test_world(&[], |w, types| {
    // rust: assert_eq!(
    // rust: sound(w, types, "minecraft:villager", |_| {}),
    // rust: Some("entity.villager.ambient")
    // rust: );
    // rust: assert_eq!(
    // rust: sound(w, types, "minecraft:villager", |m| m.extra.flag2 = true),
    // rust: Some("entity.villager.trade")
    // rust: );
    // rust: assert_eq!(
    // rust: sound(w, types, "minecraft:villager", |m| m.extra.ints[1] = 1),
    // rust: None,
    // rust: "asleep"
    // rust: );
    // rust: assert_eq!(
    // rust: sound(w, types, "minecraft:villager", |m| {
    // rust: m.extra.ints[1] = 1;
    // rust: m.extra.flag2 = true;
    // rust: }),
    // rust: None,
    // rust: "sleeping wins over trading"
    // rust: );
    // rust: let trading = |m: &mut Mob| m.extra.flag2 = true;
    // rust: assert_eq!(
    // rust: sound(w, types, "minecraft:wandering_trader", trading),
    // rust: Some("entity.wandering_trader.trade")
    // rust: );
    // rust: });
}
}

    // rust: mod fox_screech_tests {
//     use super::*;
//     use crate::mobs::PlayerView;
//     use crate::mobs::world::with_test_world;

pub fn player_at(x: f64) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: crate::mobs::world::test_player(Vec3::new(x, 64.0, 0.5))
}

    /// The (sound, volume) of 200 ambient sounds from one fox in `w`.
pub fn sounds(w: *MobWorld<'_>, types: *crate::mobs::MobTypes) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let kind = std::sync::Arc::new(types.types["minecraft:fox"].clone());
    // rust: let mut m = Mob::new(1, kind, Vec3::new(0.5, 64.0, 0.5), 0.0);
    // rust: let mut events = Vec::new();
    // rust: for _ in 0..200 {
    // rust: play_ambient(&mut m, w, &mut events);
}
    // rust: events
    // rust: .into_iter()
    // rust: .filter_map(|e| match e {
    // rust: MobEvent::Sound(s, _, volume, _) => Some((s, volume)),
    // rust: _ => None,
    // rust: })
    // rust: .collect()
}

    /// `Fox.getAmbientSound` and `playAmbientSound`: at night with nobody
    /// within 16 blocks, about one call in ten screeches at volume 2; by day,
    /// in the End, or with a player near, never.
pub fn a_fox_screeches_only_at_night_with_no_player_near() void {
}
    // rust: with_test_world(&[], |w, types| {
    // rust: let mut night = w.clone();
    // rust: night.daylight = false;
    // rust: let alone = sounds(&night, types);
    // rust: assert_eq!(alone.len(), 200);
    // rust: let screeches: Vec<_> = alone
    // rust: .iter()
    // rust: .filter(|s| s.0 == "entity.fox.screech")
    // rust: .collect();
    // rust: assert!(!screeches.is_empty(), "no screech in 200 night calls");
    // rust: assert!(screeches.len() < 60, "{} screeches", screeches.len());
            // Played by playAmbientSound itself at volume 2...
    // rust: assert!(screeches.iter().any(|s| s.1 == 2.0));
            // ...or picked again through Mob.playAmbientSound (makeSound, volume 1).
    // rust: assert!(screeches.iter().all(|s| s.1 == 2.0 || s.1 == 1.0));
    // rust: assert!(
    // rust: alone
    // rust: .iter()
    // rust: .all(|s| s.0 == "entity.fox.screech" || s.0 == "entity.fox.ambient")
    // rust: );

    // rust: let by_day = sounds(w, types);
    // rust: assert!(by_day.iter().all(|s| s.0 == "entity.fox.ambient"));

    // rust: let mut end = night.clone();
    // rust: end.daylight = true;
    // rust: end.end = true;
    // rust: assert!(
    // rust: sounds(&end, types)
    // rust: .iter()
    // rust: .any(|s| s.0 == "entity.fox.screech")
    // rust: );

    // rust: let mut near = night.clone();
    // rust: near.player = Some(player_at(16.0));
    // rust: assert!(
    // rust: sounds(&near, types)
    // rust: .iter()
    // rust: .all(|s| s.0 == "entity.fox.ambient")
    // rust: );

    // rust: let mut far = night.clone();
    // rust: far.player = Some(player_at(18.0));
    // rust: assert!(
    // rust: sounds(&far, types)
    // rust: .iter()
    // rust: .any(|s| s.0 == "entity.fox.screech")
    // rust: );

    // rust: let mut spectator = night.clone();
    // rust: let mut p = player_at(2.0);
    // rust: p.spectator = true;
    // rust: spectator.player = Some(p);
    // rust: assert!(
    // rust: sounds(&spectator, types)
    // rust: .iter()
    // rust: .any(|s| s.0 == "entity.fox.screech")
    // rust: );
    // rust: });
}
}

    // rust: mod age_up_tests {
//     use super::*;
//     use std::sync::Arc;

    /// Official Java 26.3: NoAI leaves both age clocks running. AgeLocked
    /// holds a baby's age, but a positive breeding cooldown still expires.
pub fn age_clocks_tick_with_no_ai_and_respect_baby_age_lock() void {
}
    // rust: let ran = crate::mobs::world::with_test_world(&[], |w, types| {
    // rust: for species in ["pig", "cow", "horse", "turtle"] {
    // rust: for no_ai in [true, false] {
    // rust: for locked in [false, true] {
    // rust: for age in [-2, 2] {
    // rust: let kind =
    // rust: Arc::new(types.types[&format!("minecraft:{species}")].clone());
    // rust: let mut m = Mob::new(1, kind, Vec3::new(4.0, 220.0, 4.0), 0.0);
    // rust: m.no_ai = no_ai;
    // rust: m.no_gravity = true;
    // rust: m.persistent = true;
    // rust: m.extra.age_locked = locked;
    // rust: super::super::finalize::set_age(&mut m, age);
    // rust: let (mut random, mut events) = (LegacyRandom::new(0), Vec::new());
    // rust: let expected = if age > 0 {
    // rust: [1, 0, 0, 0]
    // rust: } else if locked {
    // rust: [-2, -2, -2, -2]
    // rust: } else {
    // rust: [-1, 0, 0, 0]
}
    // rust: for (elapsed, expected_age) in expected.into_iter().enumerate() {
    // rust: let previous_age = m.extra.age;
    // rust: let previous_position = m.position;
    // rust: tick(&mut m, w, &mut random, &mut events);
    // rust: assert_eq!(
    // rust: m.extra.age,
    // rust: expected_age,
    // rust: "{species}: NoAI={no_ai}, AgeLocked={locked}, initial Age={age}, tick={}",
    // rust: elapsed + 1
    // rust: );
    // rust: if no_ai {
    // rust: assert_eq!(m.velocity, Vec3::ZERO);
                                    // Growing dimensions can reposition the mob at adulthood.
    // rust: if previous_age != -1 || expected_age != 0 {
    // rust: assert_eq!(m.position, previous_position);
}
}
}
    // rust: if species == "turtle" && age < 0 && !locked {
    // rust: assert_eq!(
    // rust: events
    // rust: .iter()
    // rust: .filter(|event| matches!(
    // rust: event,
    // rust: MobEvent::GiftLoot {
    // rust: table: "minecraft:gameplay/turtle_grow",
    // rust: ..
}
    // rust: ))
    // rust: .count(),
    // rust: 1,
    // rust: "growing up drops one scute"
    // rust: );
}
}
}
}
}
    // rust: });
    // rust: if !ran {
    // rust: eprintln!("age clock regression needs prepared vanilla resources");
}
}

    /// A baby goat `age` ticks from adulthood, from no vanilla data.
pub fn baby_goat(age: i32) M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut kind = crate::mobs::sensor_scan_tests::kind();
    // rust: let k = Arc::make_mut(&mut kind);
    // rust: k.id = "minecraft:goat".into();
    // rust: k.species = Species::Goat;
    // rust: let mut m = Mob::new(1, kind, Vec3::ZERO, 0.0);
        // setAge(-24000) as finalizeSpawn does, whose own crossing is where
        // `Goat.ageBoundaryReached` gives the newborn its 1.0.
    // rust: super::super::finalize::set_age(&mut m, age);
    // rust: m
}

    /// `AgeableMob.ageUp` ends in `setAge`, and `setAge` is where
    /// `Goat.ageBoundaryReached` sets the attack damage to 2.0 for an adult:
    /// feeding a baby goat its last two meals makes it a 2.0 goat, and the
    /// meal that leaves it one tick short keeps the baby's 1.0.
pub fn feeding_a_baby_goat_past_its_boundary_sets_the_adult_attack_damage() void {
}
    // rust: let mut m = baby_goat(-21);
    // rust: assert_eq!(m.attrs.attack_damage, 1.0, "a newborn goat hits for 1");

        // 20 ticks of growth: age -1, still a baby.
    // rust: age_up(&mut m, 1, true);
    // rust: assert!(m.is_baby());
    // rust: assert_eq!(m.attrs.attack_damage, 1.0);

        // The next 20 ticks cross the boundary.
    // rust: age_up(&mut m, 1, true);
    // rust: assert!(!m.is_baby());
    // rust: assert_eq!(m.attrs.attack_damage, 2.0);
}

    /// The same crossing on the tick path: `AgeableMob.aiStep` also ages the
    /// mob through `setAge`, so a goat on its last baby tick grows up with the
    /// adult damage rather than keeping the baby's.
pub fn a_goat_that_grows_up_on_its_tick_gets_the_adult_attack_damage() void {
}
    // rust: let mut out: Option<(bool, f32)> = None;
    // rust: crate::mobs::world::with_test_world(&[], |w, types| {
    // rust: let kind = Arc::new(types.types["minecraft:goat"].clone());
    // rust: let mut m = Mob::new(1, kind, Vec3::ZERO, 0.0);
            // As a natural spawn leaves it, then on its last baby tick.
    // rust: super::super::finalize::goat_spawn(&mut m);
    // rust: super::super::finalize::set_age(&mut m, -1);
    // rust: let (mut lr, mut events) = (LegacyRandom::new(0), Vec::new());
    // rust: tick(&mut m, w, &mut lr, &mut events);
    // rust: out = Some((m.is_baby(), m.attrs.attack_damage));
    // rust: });
    // rust: let Some((baby, damage)) = out else {
    // rust: return;
}
    // rust: assert!(!baby, "the tick that reaches 0 grows it up");
    // rust: assert_eq!(damage, 2.0);
}
}

    // rust: mod in_wall_tests {
//     use super::{Aabb, ShapeOp, Vec3, VoxelShape, in_wall};

pub fn a_suffocating_partial_shape_must_reach_the_eye() void {
}
    // rust: let slab = VoxelShape::from_box(Aabb::new(Vec3::ZERO, Vec3::new(1.0, 0.5, 1.0))).unwrap();
    // rust: let intersects = |x, y, z, eye: &Aabb| {
    // rust: (x, y, z) == (0, 0, 0)
    // rust: && slab
    // rust: .join_is_not_empty(&VoxelShape::from_box(*eye).unwrap(), ShapeOp::AND)
    // rust: .unwrap()
}
    // rust: assert!(in_wall(0.6, [0.5, 0.25, 0.5], intersects));
    // rust: assert!(!in_wall(0.6, [0.5, 0.75, 0.5], intersects));
}

    /// `Entity.isInWall` has no width guard (#5872): a hoglin (1.3965 wide)
    /// whose eye is in a solid block, or whose 1.117-wide eye box reaches a
    /// neighbouring wall column, takes in-wall damage like a narrow mob.
pub fn wide_mobs_suffocate_by_the_eye_box() void {
}
    // rust: let wall = |x: i32, y: i32, z: i32, eye: &Aabb| {
    // rust: x >= 0
    // rust: && VoxelShape::block()
    // rust: .moved(Vec3::new(f64::from(x), f64::from(y), f64::from(z)))
    // rust: .join_is_not_empty(&VoxelShape::from_box(*eye).unwrap(), ShapeOp::AND)
    // rust: .unwrap()
}
        // Eye inside the wall: hoglin and zombie (0.6) alike.
    // rust: assert!(in_wall(1.3965, [0.5, 64.5, 0.5], wall));
    // rust: assert!(in_wall(0.6, [0.5, 64.5, 0.5], wall));
        // Eye in air at x=-0.2: the zombie's 0.48 box (-0.44..0.04) clips
        // x=0, and the hoglin's wider box does too.
    // rust: assert!(in_wall(0.6, [-0.2, 64.5, 0.5], wall));
        // At x=-0.3 the zombie's box (-0.54..-0.06) clears the wall; the
        // hoglin's half-width 0.5586 (-0.8586..0.2586) does not.
    // rust: assert!(!in_wall(0.6, [-0.3, 64.5, 0.5], wall));
    // rust: assert!(in_wall(1.3965, [-0.3, 64.5, 0.5], wall));
        // Open air.
    // rust: assert!(!in_wall(1.3965, [-3.0, 64.5, 0.5], wall));
        // A box edge exactly on the wall face only touches it.
    // rust: assert!(!in_wall(1.0, [-0.4, 64.5, 0.5], wall));
}
}

    // rust: mod burn_and_rose_tests {
//     use super::*;
//     use horizon_world::registry::BlockRegistry;
//     use std::sync::Arc;

pub fn build_with(block: *'static str) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: move |world, registry| {
    // rust: let stone = registry.default_state("minecraft:stone").unwrap();
    // rust: let state = registry.default_state(block).unwrap();
    // rust: for cx in -1..1 {
    // rust: for cz in -1..1 {
    // rust: world
    // rust: .chunks
    // rust: .insert((cx, cz), Arc::new(crate::chunk::Chunk::empty(cx, cz)));
}
}
    // rust: for x in -4..4 {
    // rust: for z in -4..4 {
    // rust: world.set(x, 63, z, stone).unwrap();
}
}
    // rust: world.set(0, 64, 0, state).unwrap();
}
}

pub fn golem(types: *crate::mobs::MobTypes) M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let kind = Arc::new(types.types["minecraft:iron_golem"].clone());
    // rust: let mut m = Mob::new(1, kind, Vec3::new(0.5, 64.0, 0.5), 0.0);
    // rust: register(&mut m);
    // rust: m
}

    /// `WitherRoseBlock.entityInside` tests the world difficulty and
    /// `isInvulnerableTo(wither)`, not the regional difficulty of a fresh
    /// chunk and not the hit timer: a golem that was just hurt still gets it.
pub fn wither_rose_applies_wither_whatever_the_hit_timer_and_local_difficulty() void {
}
    // rust: let ran = crate::mobs::world::with_built_test_world(
    // rust: &[],
    // rust: build_with("minecraft:wither_rose"),
    // rust: |w, types| {
    // rust: let mut m = golem(types);
    // rust: m.invulnerable = 15;
    // rust: assert_eq!(w.difficulty.base, 2);
    // rust: flower_contact_effects(&mut m, w);
    // rust: assert!(m.has_effect("minecraft:wither"), "normal difficulty");

    // rust: let mut peaceful = w.clone();
    // rust: peaceful.difficulty = crate::mobs::spawning::LocalDifficulty::new(0, 18000, 0, 0.0);
    // rust: let mut m = golem(types);
    // rust: flower_contact_effects(&mut m, &peaceful);
    // rust: assert!(!m.has_effect("minecraft:wither"), "peaceful");
    // rust: },
    // rust: );
    // rust: let _ = ran;
}

    /// `applyEffectsFromBlocks` runs after `baseTick` counted the fire and
    /// the invulnerable time down: standing in lava a golem reads Fire 300
    /// (not 299) after its first tick, and the hit that tick starts has its
    /// full invulnerable time.
pub fn lava_ignites_to_the_full_time_and_hits_after_the_timers_count_down() void {
}
    // rust: crate::mobs::world::with_built_test_world(&[], build_with("minecraft:lava"), |w, types| {
    // rust: let mut m = golem(types);
    // rust: let mut events = Vec::new();
    // rust: let start = m.health;
    // rust: base_tick(&mut m, w, &mut events);
    // rust: assert_eq!(m.health, start - 4.0, "one lava hit");
    // rust: assert_eq!(m.fire_ticks, 300, "fire after the first tick");
    // rust: assert_eq!(m.invulnerable, 20, "the hit's own invulnerable time");
    // rust: for _ in 0..10 {
    // rust: base_tick(&mut m, w, &mut events);
}
    // rust: assert_eq!(m.health, start - 8.0, "second hit on tick 11");
    // rust: assert_eq!(m.fire_ticks, 300);
    // rust: });
}
}

    // rust: mod wither_block_slowdown_tests {
//     use super::*;
//     use crate::mobs::world::with_built_test_world;
//     use horizon_world::registry::BlockRegistry;
//     use std::sync::Arc;

pub fn build_with(block: *'static str) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: move |world, registry| {
    // rust: let stone = registry.default_state("minecraft:stone").unwrap();
    // rust: let state = registry.default_state(block).unwrap();
    // rust: for cx in -1..1 {
    // rust: for cz in -1..1 {
    // rust: world
    // rust: .chunks
    // rust: .insert((cx, cz), Arc::new(crate::chunk::Chunk::empty(cx, cz)));
}
}
    // rust: for x in -4..4 {
    // rust: for z in -4..4 {
    // rust: world.set(x, 63, z, stone).unwrap();
}
}
    // rust: world.set(0, 64, 0, state).unwrap();
}
}

pub fn mob(types: *crate::mobs::MobTypes, id: []const u8) M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let kind = Arc::new(types.types[id].clone());
    // rust: let mut m = Mob::new(1, kind, Vec3::new(0.5, 64.0, 0.5), 0.0);
    // rust: register(&mut m);
    // rust: m
}

    /// `SweetBerryBushBlock.entityInside` -> `makeStuckInBlock`: a regular mob
    /// (e.g. cow) is slowed down and its fall distance is reset to 0.
pub fn cow_gets_stuck_in_sweet_berry_bush() void {
}
    // rust: let ran =
    // rust: with_built_test_world(&[], build_with("minecraft:sweet_berry_bush"), |w, types| {
    // rust: let mut m = mob(types, "minecraft:cow");
    // rust: m.fall_distance = 4.5;
    // rust: m.stuck_multiplier = Vec3::ZERO;
    // rust: let mut random = LegacyRandom::new(42);
    // rust: let mut events = Vec::new();
    // rust: effects_from_blocks(&mut m, w, &mut random, &mut events);
    // rust: assert_eq!(m.fall_distance, 0.0, "cow fall distance reset");
    // rust: assert_eq!(
    // rust: m.stuck_multiplier,
    // rust: Vec3::new(f64::from(0.8_f32), 0.75, f64::from(0.8_f32)),
    // rust: "cow stuck multiplier applied"
    // rust: );
    // rust: });
    // rust: let _ = ran;
}

    /// `PowderSnowBlock.entityInside` -> `makeStuckInBlock`: a regular mob
    /// (e.g. cow) in powder snow is slowed down and its fall distance is reset to 0.
pub fn cow_gets_stuck_in_powder_snow() void {
}
    // rust: let ran = with_built_test_world(&[], build_with("minecraft:powder_snow"), |w, types| {
    // rust: let mut m = mob(types, "minecraft:cow");
    // rust: m.fall_distance = 4.5;
    // rust: m.stuck_multiplier = Vec3::ZERO;
    // rust: let mut random = LegacyRandom::new(42);
    // rust: let mut events = Vec::new();
    // rust: effects_from_blocks(&mut m, w, &mut random, &mut events);
    // rust: assert_eq!(m.fall_distance, 0.0, "cow fall distance reset");
    // rust: assert_eq!(
    // rust: m.stuck_multiplier,
    // rust: Vec3::new(f64::from(0.9_f32), 1.5, f64::from(0.9_f32)),
    // rust: "cow powder snow stuck multiplier applied"
    // rust: );
    // rust: });
    // rust: let _ = ran;
}

    /// `WitherBoss.makeStuckInBlock` is a NO-OP: a wither inside sweet berry bush
    /// does not receive stuck multiplier and preserves its fall distance.
pub fn wither_does_not_get_stuck_in_sweet_berry_bush() void {
}
    // rust: let ran =
    // rust: with_built_test_world(&[], build_with("minecraft:sweet_berry_bush"), |w, types| {
    // rust: let mut m = mob(types, "minecraft:wither");
    // rust: m.fall_distance = 4.5;
    // rust: m.stuck_multiplier = Vec3::ZERO;
    // rust: let mut random = LegacyRandom::new(42);
    // rust: let mut events = Vec::new();
    // rust: effects_from_blocks(&mut m, w, &mut random, &mut events);
    // rust: assert_eq!(m.fall_distance, 4.5, "wither fall distance preserved");
    // rust: assert_eq!(m.stuck_multiplier, Vec3::ZERO, "wither not slowed");
    // rust: });
    // rust: let _ = ran;
}

    /// `WitherBoss.makeStuckInBlock` is a NO-OP: a wither inside powder snow
    /// does not receive stuck multiplier and preserves its fall distance.
pub fn wither_does_not_get_stuck_in_powder_snow() void {
}
    // rust: let ran = with_built_test_world(&[], build_with("minecraft:powder_snow"), |w, types| {
    // rust: let mut m = mob(types, "minecraft:wither");
    // rust: m.fall_distance = 4.5;
    // rust: m.stuck_multiplier = Vec3::ZERO;
    // rust: let mut random = LegacyRandom::new(42);
    // rust: let mut events = Vec::new();
    // rust: effects_from_blocks(&mut m, w, &mut random, &mut events);
    // rust: assert_eq!(m.fall_distance, 4.5, "wither fall distance preserved");
    // rust: assert_eq!(m.stuck_multiplier, Vec3::ZERO, "wither not slowed");
    // rust: });
    // rust: let _ = ran;
}

    /// `SweetBerryBushBlock.entityInside`: Wither is NOT exempt from damage
    /// when moving through a mature bush (age > 0).
pub fn wither_takes_damage_when_moving_in_mature_sweet_berry_bush() void {
}
    // rust: let ran = with_built_test_world(
    // rust: &[],
    // rust: |world, registry| {
    // rust: let stone = registry.default_state("minecraft:stone").unwrap();
    // rust: let default_bush = registry
    // rust: .default_state("minecraft:sweet_berry_bush")
    // rust: .unwrap();
    // rust: let mut state = registry.state(default_bush).unwrap().clone();
    // rust: state.properties.insert("age".into(), "3".into());
    // rust: let mature_bush = registry.id(&state).unwrap();
    // rust: for cx in -1..1 {
    // rust: for cz in -1..1 {
    // rust: world
    // rust: .chunks
    // rust: .insert((cx, cz), Arc::new(crate::chunk::Chunk::empty(cx, cz)));
}
}
    // rust: for x in -4..4 {
    // rust: for z in -4..4 {
    // rust: world.set(x, 63, z, stone).unwrap();
}
}
    // rust: world.set(0, 64, 0, mature_bush).unwrap();
    // rust: },
    // rust: |w, types| {
    // rust: let mut m = mob(types, "minecraft:wither");
    // rust: let initial_health = m.health;
    // rust: m.previous = Vec3::new(0.5, 64.0, 0.5);
    // rust: m.position = Vec3::new(0.52, 64.0, 0.5);
    // rust: let mut random = LegacyRandom::new(42);
    // rust: let mut events = Vec::new();
    // rust: effects_from_blocks(&mut m, w, &mut random, &mut events);
    // rust: assert_eq!(
    // rust: m.health,
    // rust: initial_health - 0.86,
    // rust: "wither takes sweet berry bush damage through armor"
    // rust: );
    // rust: assert_eq!(m.stuck_multiplier, Vec3::ZERO, "wither still not slowed");
    // rust: },
    // rust: );
    // rust: let _ = ran;
}
}

    // rust: mod silverfish_walk_target_tests {
//     use super::*;
//     use crate::mobs::world::with_built_test_world;

    /// `Silverfish.getWalkTargetValue`: a block standing on an infested host
    /// (a stone-family block) is worth 10, and everywhere else falls through
    /// to the monster's light value. Horizon treated stone like any other
    /// block, so a silverfish had no reason to walk back into the wall.
pub fn a_silverfish_prefers_a_block_on_an_infested_host() void {
}
    // rust: let build = |world: &mut crate::world::World,
    // rust: registry: &horizon_world::registry::BlockRegistry| {
    // rust: let stone = registry.default_state("minecraft:stone").unwrap();
    // rust: let dirt = registry.default_state("minecraft:dirt").unwrap();
    // rust: for cx in -1..1 {
    // rust: for cz in -1..1 {
    // rust: world.chunks.insert(
    // rust: (cx, cz),
    // rust: std::sync::Arc::new(crate::chunk::Chunk::empty(cx, cz)),
    // rust: );
}
}
    // rust: for x in -4..4 {
    // rust: for z in -4..4 {
    // rust: world.set(x, 64, z, stone).unwrap();
}
}
    // rust: world.set(2, 64, 0, dirt).unwrap();
}
    // rust: let ran = with_built_test_world(&[], build, |w, types| {
    // rust: let m = Mob::new(
    // rust: 1,
    // rust: std::sync::Arc::new(types.types["minecraft:silverfish"].clone()),
    // rust: Vec3::new(0.5, 65.0, 0.5),
    // rust: 0.0,
    // rust: );
    // rust: assert_eq!(
    // rust: walk_target_value(&m, w, [0, 65, 0]),
    // rust: 10.0,
    // rust: "standing on stone"
    // rust: );
    // rust: let dirt = walk_target_value(&m, w, [2, 65, 0]);
    // rust: assert!(dirt < 10.0, "standing on dirt falls through, got {dirt}");
    // rust: });
    // rust: let _ = ran;
}
}

    // rust: mod iron_golem_push_tests {
//     use super::*;
//     use crate::mobs::world::with_test_world;
//     use std::sync::Arc;

pub fn mob(id: u32, species: Species, category: []const u8) M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut kind = (*crate::mobs::sensor_scan_tests::kind()).clone();
    // rust: kind.species = species;
    // rust: kind.category = category.into();
    // rust: Mob::new(id, Arc::new(kind), Vec3::ZERO, 0.0)
}

    /// `IronGolem.doPush`: a monster that is not a creeper and bumps the golem
    /// becomes its target one time in 20, and the draw is made for those alone,
    /// so a creeper or an animal leaves the golem's random alone.
pub fn an_iron_golem_targets_the_monster_that_bumps_it() void {
}
        // CI has no prepared 26.3 data, so a world that does not build skips
        // the whole check rather than asserting the data exists.
    // rust: let hits = |victim: Mob| -> Option<u32> {
    // rust: let seen = victim.seen(None);
    // rust: let mut hits = 0;
    // rust: let ran = with_test_world(&[seen], |w, _| {
    // rust: let mut golem = mob(1, Species::IronGolem, "monster");
    // rust: for _ in 0..400 {
    // rust: let mut events = Vec::new();
    // rust: push_entities(&mut golem, w, &mut events);
    // rust: if golem.ai.target.is_some() {
    // rust: hits += 1;
    // rust: golem.ai.target = None;
}
}
    // rust: });
    // rust: ran.then_some(hits)
}
    // rust: let Some(zombie) = hits(mob(2, Species::Zombie, "monster")) else {
    // rust: return;
}
    // rust: assert!(
    // rust: zombie > 0,
    // rust: "a zombie that bumps the golem is taken as its target"
    // rust: );
    // rust: assert_eq!(
    // rust: hits(mob(3, Species::Creeper, "monster")),
    // rust: Some(0),
    // rust: "IronGolem.doPush never targets a creeper"
    // rust: );
    // rust: assert_eq!(
    // rust: hits(mob(4, Species::Cow, "creature")),
    // rust: Some(0),
    // rust: "a pushed animal is not an Enemy"
    // rust: );
}
    /// #7309: a mob's melee hit is its attack damage attribute plus the
    /// `attack_damage` modifier of the held item (`Mob.doHurtTarget`), for
    /// every mob that holds a weapon. The modifiers are vanilla's, from the
    /// items' components in the data reports (iron axe 8, iron sword 5,
    /// diamond sword 6, stone sword 4, golden axe 6, trident 8, bow none).
pub fn a_held_weapon_adds_its_attack_damage_to_the_melee_hit() void {
}
        // (mob, main hand, the item's attack_damage modifier)
    // rust: let cases: [(&str, Option<&str>, f32); 9] = [
    // rust: ("minecraft:vindicator", Some("minecraft:iron_axe"), 8.0),
    // rust: ("minecraft:vindicator", None, 0.0),
    // rust: ("minecraft:zombie", Some("minecraft:iron_sword"), 5.0),
    // rust: ("minecraft:zombie", Some("minecraft:diamond_sword"), 6.0),
    // rust: ("minecraft:zombie", None, 0.0),
    // rust: (
    // rust: "minecraft:wither_skeleton",
    // rust: Some("minecraft:stone_sword"),
    // rust: 4.0,
    // rust: ),
    // rust: ("minecraft:skeleton", Some("minecraft:bow"), 0.0),
    // rust: ("minecraft:piglin_brute", Some("minecraft:golden_axe"), 6.0),
    // rust: ("minecraft:drowned", Some("minecraft:trident"), 8.0),
    // rust: ];
    // rust: let mut got = Vec::new();
    // rust: let ran = with_test_world(&[], |w, types| {
    // rust: for (kind, hand, _) in cases {
    // rust: let mut m = Mob::new(
    // rust: 1,
    // rust: Arc::new(types.types[kind].clone()),
    // rust: Vec3::new(0.5, 64.0, 0.5),
    // rust: 0.0,
    // rust: );
    // rust: m.extra.main_hand = hand.map(Arc::from);
    // rust: let (mut lr, mut events) = (horizon_core::random::LegacyRandom::new(0), Vec::new());
    // rust: let mut cx = Cx {
    // rust: w,
    // rust: lr: &mut lr,
    // rust: events: &mut events,
}
    // rust: do_hurt_target(&mut m, Who::Player, &mut cx);
    // rust: got.push((
    // rust: m.attrs.attack_damage,
    // rust: events.iter().find_map(|e| match e {
    // rust: MobEvent::AttackPlayer(amount, _)
    // rust: | MobEvent::AttackPlayerWithEffect { amount, .. } => Some(*amount),
    // rust: _ => None,
    // rust: }),
    // rust: ));
}
    // rust: });
    // rust: if !ran {
    // rust: return;
}
    // rust: for ((kind, hand, modifier), (base, hit)) in cases.iter().zip(got) {
    // rust: assert_eq!(hit, Some(base + modifier), "{kind} holding {hand:?}");
}
}
}

    // rust: mod allay_healing_tests {
//     use super::*;
//     use std::sync::Arc;

pub fn allays_heal_on_tenth_ticks_without_enabling_noai_work() void {
}
    // rust: let ran = crate::mobs::world::with_test_world(&[], |w, types| {
    // rust: for no_ai in [true, false] {
    // rust: for initial in [10.0_f32, 19.5, 20.0] {
    // rust: let kind = Arc::new(types.types["minecraft:allay"].clone());
    // rust: let mut mob = Mob::new(1, kind, Vec3::new(16.5, 101.0, 16.5), 0.0);
    // rust: mob.no_ai = no_ai;
    // rust: mob.no_gravity = true;
    // rust: mob.persistent = true;
    // rust: mob.health = initial;
    // rust: mob.extra.ints[2] = 37;
    // rust: mob.extra.ints[3] = 41;
    // rust: mob.extra.egg_time = 30;
    // rust: assert_eq!(mob.attrs.max_health, 20.0);
    // rust: assert_eq!(mob.age, 0);
    // rust: let mut random = LegacyRandom::new(0);
    // rust: let mut events = Vec::new();
    // rust: for elapsed in 1..=20 {
    // rust: assert!(tick(&mut mob, w, &mut random, &mut events));
    // rust: assert_eq!(mob.age, elapsed);
    // rust: assert_eq!(
    // rust: mob.health,
    // rust: (initial + (elapsed / 10) as f32).min(20.0),
    // rust: "NoAI={no_ai}, initial={initial}, tick={elapsed}"
    // rust: );
    // rust: assert_eq!(mob.extra.egg_time, 30 - elapsed as i32);
    // rust: let skipped = if no_ai { 0 } else { elapsed as i32 };
    // rust: assert_eq!(mob.extra.ints[2], 37 - skipped);
    // rust: assert_eq!(mob.extra.ints[3], 41 - skipped);
}
}
}
    // rust: });
    // rust: if !ran {
    // rust: eprintln!("Prepared mob data unavailable; Allay tick coverage did not run");
}
}
}

    // rust: mod ravager_noai_tests {
//     use super::*;
//     use std::sync::Arc;

pub fn ravager_counters_tick_without_ai_and_stun_starts_a_full_roar() void {
}
    // rust: crate::mobs::world::with_test_world(&[], |w, types| {
    // rust: for no_ai in [false, true] {
    // rust: for initial in [(20, 30, 5), (0, 0, 0), (-2, -3, -4), (2, 2, 0)] {
    // rust: let kind = Arc::new(types.types["minecraft:ravager"].clone());
    // rust: let mut mob = Mob::new(1, kind, Vec3::new(10.5, 200.0, 10.5), 0.0);
    // rust: mob.no_ai = no_ai;
    // rust: mob.no_gravity = true;
    // rust: mob.persistent = true;
    // rust: mob.extra.counter = initial.0;
    // rust: mob.extra.counter2 = initial.1;
    // rust: mob.extra.anim_ticks = initial.2;
    // rust: let mut random = LegacyRandom::new(0);
    // rust: let mut events = Vec::new();
    // rust: for elapsed in 1..=22 {
    // rust: tick(&mut mob, w, &mut random, &mut events);
    // rust: let attack = if initial.0 > 0 {
    // rust: (initial.0 - elapsed).max(0)
    // rust: } else {
    // rust: initial.0
}
    // rust: let stun = if initial.1 > 0 {
    // rust: (initial.1 - elapsed).max(0)
    // rust: } else {
    // rust: initial.1
}
    // rust: let roar = match initial {
    // rust: (20, 30, 5) => (5 - elapsed).max(0),
    // rust: (2, 2, 0) if elapsed >= 2 => (22 - elapsed).max(0),
    // rust: _ => initial.2,
}
    // rust: assert_eq!(
    // rust: (mob.extra.counter, mob.extra.counter2, mob.extra.anim_ticks),
    // rust: (attack, stun, roar),
    // rust: "NoAI={no_ai}, initial={initial:?}, tick={elapsed}"
    // rust: );
}
}
}
    // rust: });
}
}

    // rust: mod air_tests {
//     use super::*;

    /// A mob of `kind` in a pool, its eyes under, after `ticks` base ticks.
pub fn air_after(kind: []const u8, air: i32, ticks: u32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let build = |world: &mut crate::world::World,
    // rust: registry: &horizon_world::registry::BlockRegistry| {
    // rust: world.chunks.insert(
    // rust: (0, 0),
    // rust: std::sync::Arc::new(crate::chunk::Chunk::empty(0, 0)),
    // rust: );
    // rust: let water = registry.default_state("minecraft:water").unwrap();
    // rust: for x in 0..=4 {
    // rust: for z in 0..=4 {
    // rust: for y in 0..=8 {
    // rust: world.set(x, y, z, water).unwrap();
}
}
}
}
    // rust: let mut out = None;
    // rust: crate::mobs::world::with_built_test_world(&[], build, |w, types| {
    // rust: let kind = std::sync::Arc::new(types.types[kind].clone());
    // rust: let mut m = Mob::new(1, kind, Vec3::new(2.5, 3.0, 2.5), 0.0);
    // rust: m.air = air;
    // rust: let mut events = Vec::new();
    // rust: for _ in 0..ticks {
    // rust: base_tick(&mut m, w, &mut events);
}
    // rust: out = Some(m.air);
    // rust: });
    // rust: out
}

    /// `Dolphin.handleAirSupply` is empty and the dolphin isn't in
    /// `#can_breathe_under_water`: under water it loses a breath a tick from
    /// its 4800, as `LivingEntity.baseTick` takes it, so it must surface.
pub fn a_dolphin_holds_its_breath_under_water() void {
}
    // rust: let Some(air) = air_after("minecraft:dolphin", 4800, 10) else {
    // rust: return;
}
    // rust: assert_eq!(air, 4790);
}

    /// A copper golem is in `#can_breathe_under_water`: its air stays full.
pub fn a_copper_golem_breathes_under_water() void {
}
    // rust: let Some(air) = air_after("minecraft:copper_golem", 300, 10) else {
    // rust: return;
}
    // rust: assert_eq!(air, 300);
}
}

    // rust: mod flight_effect_fall_tests {
//     use super::*;
//     use std::sync::Arc;

pub fn flight_effects_reset_accumulated_fall_distance_even_without_ai() void {
}
    // rust: let root = std::path::PathBuf::from(std::env::var_os("HORIZON_TEST_RESOURCES").unwrap());
    // rust: let ran = crate::mobs::world::with_resource_test_world(
    // rust: &root,
    // rust: &[],
    // rust: true,
    // rust: true,
    // rust: |world, _| {
    // rust: world
    // rust: .chunks
    // rust: .insert((0, 0), Arc::new(crate::chunk::Chunk::empty(0, 0)));
    // rust: },
    // rust: |world, types| {
    // rust: let mut failures = Vec::new();
    // rust: let mut rows = Vec::new();
    // rust: for effect in [
    // rust: None,
    // rust: Some("minecraft:levitation"),
    // rust: Some("minecraft:slow_falling"),
    // rust: ] {
    // rust: for no_ai in [false, true] {
    // rust: for velocity_y in [0.0, 0.2, -0.2] {
    // rust: let kind = Arc::new(types.types["minecraft:cow"].clone());
    // rust: let mut mob = Mob::new(1, kind, Vec3::new(2.5, 64.0, 2.5), 0.0);
    // rust: mob.no_ai = no_ai;
    // rust: mob.no_gravity = true;
    // rust: mob.persistent = true;
    // rust: mob.fall_distance = 12.0;
    // rust: mob.velocity.y = velocity_y;
    // rust: if let Some(effect) = effect {
    // rust: mob.add_effect(effect, 100, 0);
}
    // rust: let mut random = LegacyRandom::new(0);
    // rust: assert!(tick(&mut mob, world, &mut random, &mut Vec::new()));
                            // The pinned Java aiStep resets before travel. A
                            // downward move then adds 0.2F of NEW fall distance;
                            // NoAI skips movement but must still erase the old fall.
    // rust: let expected = match (effect.is_some(), no_ai, velocity_y < 0.0) {
    // rust: (false, false, true) => 12.200000002980232,
    // rust: (true, false, true) => 0.20000000298023224,
    // rust: (false, _, _) => 12.0,
    // rust: (true, _, _) => 0.0,
}
    // rust: let name = effect.unwrap_or("none").trim_start_matches("minecraft:");
    // rust: rows.push(format!(
    // rust: "{name} {no_ai} {:016x} {:016x}",
    // rust: velocity_y.to_bits(),
    // rust: mob.fall_distance.to_bits()
    // rust: ));
    // rust: if mob.fall_distance != expected {
    // rust: failures.push((effect, no_ai, velocity_y, mob.fall_distance));
}
}
}
}
    // rust: if let Some(path) = std::env::var_os("HORIZON_MOB_FALL_RESET_OUTPUT") {
    // rust: std::fs::write(path, rows.join("\n") + "\n").unwrap();
}
    // rust: assert!(failures.is_empty(), "fall distance differs: {failures:?}");
    // rust: },
    // rust: );
    // rust: assert!(ran, "prepared resources must run the integration fixture");
}
}
