//! Transpiled from Horizon Rust crate
package horizon_client_fox

import "core:fmt"
import "core:mem"
import "core:math"

// Foxes (`net.minecraft.world.entity.animal.fox.Fox`): the goal list, the
// flags byte (sleeping, sitting, crouching, interested, pouncing,
// faceplanted), stalking and pouncing, napping in the shade by day, seeking
// shelter, perching, eating berries and the food held in the mouth (with the
// item's on-consumed effects: a chorus fruit teleports it).
// Strolling through villages and defending trusted players are not ported yet.
// The goal that walks to a dropped item is here; the game side takes the
// items (`Fox.pickUpItem`, `game/foxes.rs`). A totem in the mouth is a
// `death_protection` item like any other held one (`Mob::damage`).
// use super::{
    // rust: Mob, MobEvent, MobWorld, Seen, Species,
    // rust: goals::{
    // rust: Avoid, AvoidEntity, Breed, ClimbOnTopOfPowderSnow, Cx, Float, FollowParent, Goal, JUMP,
    // rust: LOOK, LeapAtTarget, LookAtPlayer, MOVE, MeleeAttack, MoveToBlock, NearestTarget, Panic,
    // rust: Prey, Stroll, goal_clone, hide_pos, reduced,
    // rust: },
    // rust: living::wrap,
    // rust: riders,
}
// use horizon_core::{
    // rust: geometry::{Axis, Vec3},
    // rust: jmath,
    // rust: random::RandomSource,
}
// use horizon_items::items::ConsumeEffect;
// use horizon_world::registry::BlockStateId;
// use horizon_world::teleport_consume::TeleportConsume;

// Fox.DATA_FLAGS_ID, kept in `extra.ints[0]` (and sent to clients as is).
SITTING :: 1
CROUCHING :: 4
INTERESTED :: 8
POUNCING :: 16
SLEEPING :: 32
FACEPLANTED :: 64
DEFENDING :: 128
// `Fox.ticksSinceEaten`.
TICKS_SINCE_EATEN :: 1
// `Fox.interestedAngle` and `crouchAmount` in `anim.v`, the previous tick's
// values in `anim.vo`.
INTERESTED_ANGLE :: 0
CROUCH_AMOUNT :: 1
// `Fox.MAX_CROUCH_AMOUNT`.
MAX_CROUCH_AMOUNT :: 5.0

flag :: proc(m: ^Mob, f: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.ints[0] & f != 0
}
// `Fox.getAmbientSound` for a fox awake: when it isn't bright outside, one
// time in ten, the screech if no non-spectator player's box is within 16
// blocks of the fox's; otherwise the ambient sound.
awake_ambient :: proc(m: ^Mob, w: ^MobWorld) -> ^ {
    // Ported from Horizon
    return {}
}
    // Level.isBrightOutside: the End has a fixed time, so never there.
    // rust: let bright = w.daylight && !w.end;
    // rust: if !bright && m.random.next_float() < 0.1 {
    // rust: let around = m.bounds().inflate(Vec3::new(16.0, 16.0, 16.0));
    // rust: let player_near = w
    // rust: .player
    // rust: .as_ref()
    // rust: .is_some_and(|p| !p.spectator && p.bounds.intersects(around));
    // rust: if !player_near {
    // rust: return SCREECH;
}
}
    // rust: "entity.fox.ambient"
}
// `SoundEvents.FOX_SCREECH`.
SCREECH :: "entity.fox.screech"
set_flag :: proc(m: ^Mob, f: i32, on: bool) {
}
    // rust: if on {
    // rust: m.extra.ints[0] |= f;
    // rust: } else {
    // rust: m.extra.ints[0] &= !f;
}
}
// `Fox.clearStates`.
clear_states :: proc(m: ^Mob) {
}
    // rust: m.extra.ints[0] = 0;
}
// `Fox.getTrustedEntities`: the UUIDs a fox trusts, `DATA_TRUSTED_ID_0`
// first.
trusted_entities :: proc(m: ^Mob) -> i {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.trusted.iter().flatten().copied()
}
// `Fox.addTrustedEntity`: the first free slot, and once both are taken a new
// one replaces the second.
add_trusted_entity :: proc(m: ^Mob, uuid: [i32; 4]) {
}
    // rust: let slot = usize::from(m.extra.trusted[0].is_some());
    // rust: m.extra.trusted[slot] = Some(uuid);
}
// `Fox.clearTrusted`: forget everyone.
clear_trusted :: proc(m: ^Mob) {
}
    // rust: m.extra.trusted = [None; 2];
}
// `Fox.trusts`: the UUID is one of the trusted.
trusts :: proc(m: ^Mob, uuid: [i32; 4]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: trusted_entities(m).any(|trusted| trusted == uuid)
}
// The trust of a fox's breeding (`Fox.FoxBreedGoal.breed`): the baby trusts
// the player who fed this fox into love and, when it is another player, the
// one who fed its partner.
    // rust: pub fn trust_breeders(
    // rust: baby: &mut Mob,
    // rust: love_cause: Option<[i32; 4]>,
    // rust: partner_love_cause: Option<[i32; 4]>,
    // rust: ) {
    // rust: if let Some(cause) = love_cause {
    // rust: add_trusted_entity(baby, cause);
}
    // rust: if let Some(cause) = partner_love_cause
    // rust: && partner_love_cause != love_cause
    // rust: {
    // rust: add_trusted_entity(baby, cause);
}
}
// `Fox.canMove`, which `FoxMoveControl` waits for.
can_move :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !flag(m, SLEEPING | SITTING | FACEPLANTED)
}
// `FoxLookControl.resetXRotOnTick`: stalking and pouncing keep their pitch.
resets_x_rot :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !flag(m, POUNCING | CROUCHING | INTERESTED | FACEPLANTED)
}

// `Fox.populateDefaultEquipmentSlots`: one fox in five holds an emerald, an
// egg, rabbit feet or hide, wheat, leather or a feather in its mouth.
populate_default_equipment :: proc(m: ^Mob) {
}
    // rust: if m.random.next_float() < 0.2 {
    // rust: let odds = m.random.next_float();
    // rust: let held = if odds < 0.05 {
    // rust: "minecraft:emerald"
    // rust: } else if odds < 0.2 {
    // rust: "minecraft:egg"
    // rust: } else if odds < 0.4 {
    // rust: if m.random.next_boolean() {
    // rust: "minecraft:rabbit_foot"
    // rust: } else {
    // rust: "minecraft:rabbit_hide"
}
    // rust: } else if odds < 0.6 {
    // rust: "minecraft:wheat"
    // rust: } else if odds < 0.8 {
    // rust: "minecraft:leather"
    // rust: } else {
    // rust: "minecraft:feather"
}
    // rust: m.extra.main_hand = Some(held.into());
}
}
// `Fox.registerGoals` and `setTargetGoals` (the targets wait for the variant:
// red foxes prefer chickens and rabbits, snow foxes fish).
register :: proc(m: ^Mob) {
}
    // rust: let countdown = m.random.next_int_bound(reduced(140)).unwrap_or(0);
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(0, Wrap::new(Float).on_start(clear_states));
    // rust: g.add(0, ClimbOnTopOfPowderSnow);
    // rust: g.add(1, Faceplant { countdown: 0 });
    // rust: g.add(2, Panic::new(2.2));
    // rust: g.add(3, Wrap::new(Breed::new(1.0)).on_start(clear_states));
    // AVOID_PLAYERS: not a sneaking player.
    // rust: g.add(
    // rust: 4,
    // rust: AvoidEntity::new(Avoid::Player, 16.0, 1.6, 1.4)
    // rust: .player_when(|m, p| !p.sneaking && !p.spectator && !trusts(m, p.uuid)),
    // rust: );
    // rust: g.add(
    // rust: 4,
    // rust: AvoidEntity::new(Avoid::Species(vec![Species::Wolf]), 8.0, 1.6, 1.4).seen_when(|s| !s.tame),
    // rust: );
    // rust: g.add(
    // rust: 4,
    // rust: AvoidEntity::new(Avoid::Species(vec![Species::PolarBear]), 8.0, 1.6, 1.4),
    // rust: );
    // rust: g.add(5, StalkPrey);
    // rust: g.add(6, Pounce);
    // rust: g.add(6, SeekShelter::new(1.25));
    // rust: g.add(
    // rust: 7,
    // rust: Wrap::new(MeleeAttack::new(1.2, true).bite("entity.fox.bite"))
    // rust: .when(
    // rust: |m| !flag(m, SITTING | SLEEPING | CROUCHING | FACEPLANTED),
    // rust: false,
    // rust: )
    // rust: .on_start(|m| set_flag(m, INTERESTED, false)),
    // rust: );
    // rust: g.add(7, Sleep { countdown });
    // rust: g.add(8, Wrap::new(FollowParent::new(1.25)).on_start(clear_states));
    // rust: g.add(10, EatBerries::new());
    // rust: g.add(10, LeapAtTarget::new(0.4));
    // rust: g.add(11, Stroll::avoiding_water(1.0));
    // rust: g.add(11, SearchForItems);
    // FoxLookAtPlayerGoal: not with the nose in the snow or while stalking.
    // rust: g.add(
    // rust: 12,
    // rust: Wrap::new(LookAtPlayer::new(24.0)).when(|m| !flag(m, FACEPLANTED | INTERESTED), true),
    // rust: );
    // rust: g.add(13, Perch::default());
    // rust: let red = |m: &Mob, _: &MobWorld| m.extra.variant == 0;
    // rust: let snow = |m: &Mob, _: &MobWorld| m.extra.variant != 0;
    // rust: let land = || NearestTarget::new(Prey::Filter(chicken_or_rabbit), false).interval(10);
    // rust: let turtle = || NearestTarget::new(Prey::Filter(baby_turtle_on_land), false).interval(10);
    // rust: let fish = || NearestTarget::new(Prey::Filter(schooling_fish), false).interval(20);
    // rust: let t = &mut m.ai.targets;
    // rust: t.add(4, land().gate(red));
    // rust: t.add(4, turtle().gate(red));
    // rust: t.add(6, fish().gate(red));
    // rust: t.add(4, fish().gate(snow));
    // rust: t.add(6, land().gate(snow));
    // rust: t.add(6, turtle().gate(snow));
}

chicken_or_rabbit :: proc(s: ^Seen) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(s.species, Species::Chicken | Species::Rabbit)
}
baby_turtle_on_land :: proc(s: ^Seen) -> b {
    // Ported from Horizon
    return {}
}
    // rust: s.species == Species::Turtle && s.baby && !s.in_water
}
schooling_fish :: proc(s: ^Seen) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: s.species,
    // rust: Species::Cod | Species::Salmon | Species::TropicalFish
    // rust: )
}

// The part of `Fox.tick` a client runs too: the head tilt eases toward the
// interested flag and the crouch builds up to 5 while crouching.
client_tick :: proc(m: ^Mob) {
}
    // rust: let (interested, crouching) = (flag(m, INTERESTED), flag(m, CROUCHING));
    // rust: let v = &mut m.anim.v;
    // rust: m.anim.vo[INTERESTED_ANGLE] = v[INTERESTED_ANGLE];
    // rust: v[INTERESTED_ANGLE] += (if interested { 1.0 } else { 0.0 } - v[INTERESTED_ANGLE]) * 0.4;
    // rust: m.anim.vo[CROUCH_AMOUNT] = v[CROUCH_AMOUNT];
    // rust: v[CROUCH_AMOUNT] = if crouching {
    // rust: (v[CROUCH_AMOUNT] + 0.2).min(MAX_CROUCH_AMOUNT)
    // rust: } else {
    // rust: 0.0
}
}
// `Fox.isFullyCrouched`.
fully_crouched :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.anim.v[CROUCH_AMOUNT] == MAX_CROUCH_AMOUNT
}

// `Fox.tick` and `Fox.aiStep`: eating, and `SoundEvents.FOX_AGGRO`
// (`Entity.playSound` at its feet) while the fox is defending. Only the
// server broadcasts that sound.
ai_step :: proc(m: ^Mob, w: ^MobWorld, events: ^[dynamic]MobEvent) {
}
    // rust: client_tick(m);
    // rust: if !m.alive() {
    // rust: return;
}
    // rust: m.extra.ints[TICKS_SINCE_EATEN] += 1;
    // rust: if let Some(item) = m.extra.main_hand.clone()
    // rust: && eats(w, &item)
    // rust: && m.ai.target.is_none()
    // rust: && m.on_ground
    // rust: && !flag(m, SLEEPING)
    // rust: {
    // rust: let eaten = m.extra.ints[TICKS_SINCE_EATEN];
    // rust: if eaten > 600 {
            // ItemStack.finishUsingItem: the consumable's on-consumed effects
            // run (a chorus fruit teleports it), then a use remainder stays.
    // rust: consume(w, m, events, &item);
    // rust: m.extra.set_main_hand(
    // rust: w.items
    // rust: .and_then(|i| i.items.get(&item))
    // rust: .and_then(|i| i.use_remainder.as_deref())
    // rust: .map(Into::into),
    // rust: );
    // rust: m.extra.ints[TICKS_SINCE_EATEN] = 0;
    // rust: } else if eaten > 560 && m.random.next_float() < 0.1 {
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: events.push(MobEvent::Sound("entity.fox.eat", at, 1.0, 1.0));
            // Fox.handleEntityEvent 45: the clients throw the crumbs of the food.
    // rust: events.push(MobEvent::EntityEvent {
    // rust: mob: m.id,
    // rust: event: 45,
    // rust: at,
    // rust: });
}
}
    // rust: if !m.target_info(w).is_some_and(|t| t.alive) {
    // rust: set_flag(m, CROUCHING | INTERESTED, false);
}
    // rust: let in_water = m.fluids.in_water;
    // rust: if in_water || m.ai.target.is_some() || w.thundering {
    // rust: set_flag(m, SLEEPING, false);
}
    // rust: if in_water || flag(m, SLEEPING) {
    // rust: set_flag(m, SITTING, false);
}
    // `Fox.aiStep`, after the living step: one tick in twenty a defending fox
    // growls. `Entity.playSound` is positional and a silent fox stays quiet.
    // rust: if flag(m, DEFENDING) && m.random.next_float() < 0.05 && !m.silent {
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: events.push(MobEvent::Sound("entity.fox.aggro", at, 1.0, 1.0));
}
    // Faceplanted: crumbs of the snow now and then (level event 2001).
    // rust: if flag(m, FACEPLANTED) && m.random.next_float() < 0.2 {
    // rust: let at = [
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: ];
    // rust: events.push(MobEvent::LevelEvent {
    // rust: id: 2001,
    // rust: pos: at,
    // rust: data: w.world.block(at[0], at[1], at[2]).0 as i32,
    // rust: });
}
}
// `Fox.aiStep` before the living step: a sleeping fox takes no input.
pre_ai_step :: proc(m: ^Mob) {
}
    // rust: if flag(m, SLEEPING) {
    // rust: m.ai.jumping = false;
    // rust: m.ai.xxa = 0.0;
    // rust: m.ai.zza = 0.0;
}
}
// `Fox.isConsumableFood`: the item has food and consumable components.
eats :: proc(w: ^MobWorld, item: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: w.items
    // rust: .and_then(|i| i.items.get(item))
    // rust: .is_some_and(|i| i.food.is_some() && i.consumable.is_some())
}

// `Consumable.onConsume`'s `on_consume_effects` when a fox finishes an item
// (`Item.finishUsingItem`): the teleport that a chorus fruit gives it.
consume :: proc(w: ^MobWorld, m: ^Mob, events: ^[dynamic]MobEvent, item: string) {
}
    // rust: let Some(consumable) = w
    // rust: .items
    // rust: .and_then(|i| i.items.get(item))
    // rust: .and_then(|i| i.consumable.as_ref())
    // rust: else {
    // rust: return;
}
    // rust: for effect in &consumable.effects {
    // rust: if let ConsumeEffect::TeleportRandomly(teleport) = effect {
    // rust: teleport_randomly(w, m, events, teleport);
}
}
}

// `TeleportRandomlyConsumeEffect.apply` for a fox: 16 draws of a point in a
// cube of `diameter` around it, the first it can stand at takes it, with the
// fox's own teleport sound and the portal trail (level event 2017).
    // rust: fn teleport_randomly(
    // rust: w: &MobWorld,
    // rust: m: &mut Mob,
    // rust: events: &mut Vec<MobEvent>,
    // rust: teleport: &TeleportConsume,
    // rust: ) {
    // rust: let origin = m.position;
    // rust: let diameter = f64::from(teleport.diameter);
    // `Mth.clamp(y, level.getMinY(), getMinY() + logicalHeight - 1)`.
    // rust: let low = f64::from(w.world.bottom_y());
    // rust: let high = low + f64::from(w.world.shape.logical_height) - 1.0;
    // rust: for _ in 0..16 {
    // rust: let x = origin.x + (m.random.next_double() - 0.5) * diameter;
    // rust: let y = (origin.y + (m.random.next_double() - 0.5) * diameter).clamp(low, high);
    // rust: let z = origin.z + (m.random.next_double() - 0.5) * diameter;
    // rust: if m.extra.passenger {
    // rust: riders::stop_riding(m, None);
}
    // rust: let old = m.position;
    // rust: if !random_teleport(w, m, Vec3::new(x, y, z)) {
    // rust: continue;
}
        // `LivingEntity.checkPositionAndTeleport` broadcasts entity event 46
        // before the teleport sound and the directional trail.
    // rust: events.push(MobEvent::EntityEvent {
    // rust: mob: m.id,
    // rust: event: 46,
    // rust: at: [m.position.x, m.position.y, m.position.z],
    // rust: });
        // `SoundEvents.FOX_TELEPORT`, else the chorus fruit's own; the sound
        // plays at the point reached.
    // rust: events.push(MobEvent::Sound(
    // rust: "entity.fox.teleport",
    // rust: [m.position.x, m.position.y, m.position.z],
    // rust: 1.0,
    // rust: 1.0,
    // rust: ));
    // rust: if teleport.directional_particles {
    // rust: let at = |p: Vec3| [p.x.floor() as i32, p.y.floor() as i32, p.z.floor() as i32];
    // rust: let (from, to) = (at(old), at(m.position));
            // `BlockPos` offset clamped to a byte per axis, packed as vanilla does.
    // rust: let axis = |a: i32, b: i32| (b - a).clamp(-127, 127) + 127;
    // rust: events.push(MobEvent::LevelEvent {
    // rust: id: 2017,
    // rust: pos: from,
    // rust: data: (axis(from[0], to[0]) << 16)
    // rust: | (axis(from[1], to[1]) << 8)
    // rust: | axis(from[2], to[2]),
    // rust: });
}
    // rust: m.fall_distance = 0.0;
    // rust: return;
}
}

// `Entity.randomTeleport`: the drawn point drops to the first
// motion-blocking ground below it and takes the fox only if its box there
// is free and holds no liquid, on a block the consume effect allows.
// Otherwise the fox stays where it was.
random_teleport :: proc(w: ^MobWorld, m: ^Mob, to: Vec3) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let (x, z) = (to.x, to.z);
    // rust: let (bx, bz) = (x.floor() as i32, z.floor() as i32);
    // rust: if !w.world.loaded(bx, bz) {
    // rust: return false;
}
    // `while (!foundGround && pos.getY() > level().getMinY())`: every step
    // down that is not ground lowers the landing height by one.
    // rust: let mut y = to.y;
    // rust: let mut by = to.y.floor() as i32;
    // rust: let mut ground = false;
    // rust: while by > w.world.bottom_y() {
    // rust: by -= 1;
    // rust: if w.facts.get(w.world.block(bx, by, bz)).full_collision {
    // rust: ground = true;
    // rust: break;
}
    // rust: y -= 1.0;
}
    // rust: if !ground {
    // rust: return false;
}
    // `level().noCollision(this) && !level().containsAnyLiquid(getBoundingBox())
    // && !getBlockState(blockPosition()).is(CONSUMABLE_DOES_NOT_TELEPORT_TO)`.
    // rust: let at = Vec3::new(x, y, z);
    // rust: let bounds = m.bounds_at(at);
    // rust: let landing = w.block_name(x.floor() as i32, y.floor() as i32, z.floor() as i32);
    // rust: if !w.no_collision(bounds)
    // rust: || w.contains_any_liquid(bounds)
    // rust: || w.has_tag("minecraft:consumable_does_not_teleport_to", landing)
    // rust: {
    // rust: return false;
}
    // rust: m.position = at;
    // rust: m.previous = at;
    // rust: m.velocity = Vec3::ZERO;
    // rust: m.ai.nav.stop();
    // rust: true
}

// `Fox.FoxBehaviorGoal.hasShelter`: out of the sky's sight and not a bad spot.
has_shelter :: proc(m: ^Mob, w: ^MobWorld) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let at = [
    // rust: m.position.x.floor() as i32,
    // rust: m.bounds().max(Axis::Y).floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: ];
    // rust: !w.can_see_sky(at[0], at[1], at[2]) && m.walk_target_value(w, at) >= 0.0
}
// `Fox.FoxBehaviorGoal.alertable`: someone within 12 blocks the fox would
// keep watch over (`FoxAlertableEntitiesSelector`).
alertable :: proc(m: ^Mob, w: ^MobWorld) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let (from, id, y) = (m.position, m.id, m.position.y);
    // rust: let mob = w
    // rust: .nearby(from, 12.0, |s: &Seen| {
    // rust: s.id != id
    // rust: && (s.position.y - y).abs() <= 6.0
    // rust: && m.distance_sqr(s.position) <= 144.0
    // rust: && match s.species {
    // rust: Species::Fox => false,
    // rust: Species::Chicken | Species::Rabbit => true,
    // rust: Species::Wolf | Species::Cat | Species::Parrot | Species::Nautilus => !s.tame,
    // rust: _ => true,
}
    // rust: })
    // rust: .next()
    // rust: .is_some();
    // rust: mob || w.player.as_ref().is_some_and(|p| {
    // rust: p.alive
    // rust: && !p.creative
    // rust: && !p.spectator
    // rust: && !p.sneaking
    // rust: && (p.position.y - y).abs() <= 6.0
    // rust: && m.distance_sqr(p.position) <= 144.0
    // rust: })
}

// `Fox.SleepGoal`: nap in the shade by day when nothing is around.
Sleep :: struct {
    countdown: i32,
}
    // rust: impl Sleep {
can_sleep :: proc(self: ^Self, m: ^Mob, w: ^MobWorld) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if self.countdown > 0 {
    // rust: self.countdown -= 1;
    // rust: return false;
}
    // rust: let (x, y, z) = (
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: );
    // rust: w.daylight
    // rust: && has_shelter(m, w)
    // rust: && !alertable(m, w)
    // rust: && w.block_name(x, y, z) != "minecraft:powder_snow"
}
}
    // rust: impl Goal for Sleep {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE | LOOK | JUMP
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.ai.nav.is_done() && (self.can_sleep(m, cx.w) || flag(m, SLEEPING))
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.can_sleep(m, cx.w)
}
start :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: set_flag(m, SITTING | CROUCHING | INTERESTED, false);
    // rust: m.ai.jumping = false;
    // rust: set_flag(m, SLEEPING, true);
    // rust: m.nav_stop();
    // rust: let p = m.position;
    // rust: m.ai.mov.set_wanted(p.x, p.y, p.z, 0.0);
}
stop :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: self.countdown = m.random.next_int_bound(reduced(140)).unwrap_or(0);
    // rust: clear_states(m);
}
}

// A shared goal under the fox's own conditions and start-up: the extra
// `canUse` of `FoxMeleeAttackGoal` and `FoxLookAtPlayerGoal` and the
// `clearStates` or `setIsInterested(false)` its subclasses do in `start`.
Wrap :: struct {
    goal: G,
    when: Maybe(fn(^Mob) -) bool>,
    // The condition also applies to `canContinueToUse`.
    both: bool,
    on_start: Maybe(fn(^Mob)),
}
    // rust: impl<G: Goal + Clone + 'static> Wrap<G> {
new :: proc(goal: G) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: goal,
    // rust: when: None,
    // rust: both: false,
    // rust: on_start: None,
}
}
when :: proc(f: fn(^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: (self.when, self.both) = (Some(f), both);
    // rust: self
}
on_start :: proc(f: fn(^Mob) {
}
    // rust: self.on_start = Some(f);
    // rust: self
}
}
    // rust: impl<G: Goal + Clone + 'static> Goal for Wrap<G> {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.goal.flags()
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.when.is_none_or(|f| f(m)) && self.goal.can_use(m, cx)
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: (!self.both || self.when.is_none_or(|f| f(m))) && self.goal.can_continue(m, cx)
}
interruptable :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.goal.interruptable()
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: if let Some(f) = self.on_start {
    // rust: f(m);
}
    // rust: self.goal.start(m, cx);
}
stop :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.goal.stop(m, cx);
}
every_tick :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.goal.every_tick()
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.goal.tick(m, cx);
}
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.goal.name()
}
}

// `Fox.isPathClear`: six points along the way to the target, each with
// nothing but replaceable blocks in the three above it.
path_clear :: proc(m: ^Mob, w: ^MobWorld, to: Vec3) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let (zdiff, xdiff) = (to.z - m.position.z, to.x - m.position.x);
    // rust: let slope = zdiff / xdiff;
    // rust: for i in 0..6 {
    // rust: let step = f64::from(i as f32 / 6.0);
    // rust: let z = if slope == 0.0 { 0.0 } else { zdiff * step };
    // rust: let x = if slope == 0.0 {
    // rust: xdiff * step
    // rust: } else {
    // rust: z / slope
}
    // rust: for j in 1..4 {
    // rust: let at = [
    // rust: (m.position.x + x).floor() as i32,
    // rust: (m.position.y + f64::from(j)).floor() as i32,
    // rust: (m.position.z + z).floor() as i32,
    // rust: ];
    // rust: if !w.facts.get(w.world.block(at[0], at[1], at[2])).replaceable {
    // rust: return false;
}
}
}
    // rust: true
}
signum :: proc(x: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if x > 0.0 {
    // rust: 1.0
    // rust: } else if x < 0.0 {
    // rust: -1.0
    // rust: } else {
    // rust: 0.0
}
}

// `Fox.FaceplantGoal`: stay put for 40 ticks with the nose in the snow.
Faceplant :: struct {
    countdown: i32,
}
    // rust: impl Goal for Faceplant {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE | LOOK | JUMP
}
can_use :: proc(self: ^Self, m: ^Mob, _: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: flag(m, FACEPLANTED)
}
can_continue :: proc(self: ^Self, m: ^Mob, _: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: flag(m, FACEPLANTED) && self.countdown > 0
}
start :: proc(self: ^Self, _: ^Mob, _: ^Cx) {
}
    // rust: self.countdown = reduced(40);
}
stop :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: set_flag(m, FACEPLANTED, false);
}
tick :: proc(self: ^Self, _: ^Mob, _: ^Cx) {
}
    // rust: self.countdown -= 1;
}
}

// `Fox.StalkPreyGoal`: creep up on a chicken or rabbit more than 6 blocks
// away, then crouch and keep still once it is within 6.
StalkPrey :: struct {
    // rust: impl StalkPrey {
look :: proc(m: ^Mob, eye: [f64; 3]) {
}
    // rust: let (y, x) = (m.kind.max_head_y_rot, m.kind.max_head_x_rot);
    // rust: m.look_at_speed(eye, y, x);
}
}
    // rust: impl Goal for StalkPrey {
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
    // rust: if flag(m, SLEEPING) {
    // rust: return false;
}
    // rust: let Some(t) = m.target_info(cx.w) else {
    // rust: return false;
}
    // rust: let stalkable = match m.ai.target {
    // rust: Some(super::Who::Mob(id)) => {
    // rust: cx.w.seen(id)
    // rust: .is_some_and(|s| matches!(s.species, Species::Chicken | Species::Rabbit))
}
    // rust: _ => false,
}
    // rust: t.alive
    // rust: && stalkable
    // rust: && m.distance_sqr(t.position) > 36.0
    // rust: && !flag(m, CROUCHING | INTERESTED)
    // rust: && !m.ai.jumping
}
start :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: set_flag(m, SITTING | FACEPLANTED, false);
}
stop :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: match m.target_info(cx.w) {
    // rust: Some(t) if path_clear(m, cx.w, t.position) => {
    // rust: set_flag(m, INTERESTED | CROUCHING, true);
    // rust: m.nav_stop();
    // rust: Self::look(m, [t.position.x, t.eye_y, t.position.z]);
}
    // rust: _ => set_flag(m, INTERESTED | CROUCHING, false),
}
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: let Some(t) = m.target_info(cx.w) else { return };
    // rust: Self::look(m, [t.position.x, t.eye_y, t.position.z]);
    // rust: if m.distance_sqr(t.position) <= 36.0 {
    // rust: set_flag(m, INTERESTED | CROUCHING, true);
    // rust: m.nav_stop();
    // rust: } else {
    // rust: let at = [t.position.x, t.position.y, t.position.z];
    // rust: m.nav_move_to_entity(cx.w, at, 0, 1.5);
}
}
}

// `Fox.FoxPounceGoal`: once fully crouched with a clear path, leap at the
// target, tilt with the flight and bite when within 2 blocks, or end up with
// the nose in snow.
Pounce :: struct {
    // rust: impl Goal for Pounce {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE | JUMP
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if !fully_crouched(m) {
    // rust: return false;
}
    // rust: let Some(t) = m.target_info(cx.w).filter(|t| t.alive) else {
    // rust: return false;
}
    // rust: let clear = path_clear(m, cx.w, t.position);
    // rust: if !clear {
    // rust: set_flag(m, CROUCHING | INTERESTED, false);
}
    // rust: clear
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if !m.target_info(cx.w).is_some_and(|t| t.alive) {
    // rust: return false;
}
    // rust: let yd = m.velocity.y;
    // rust: (yd * yd >= f64::from(0.05f32) || m.head_pitch.abs() >= 15.0 || !m.on_ground)
    // rust: && !flag(m, FACEPLANTED)
}
interruptable :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: m.ai.jumping = true;
    // rust: set_flag(m, POUNCING, true);
    // rust: set_flag(m, INTERESTED, false);
    // rust: if let Some(t) = m.target_info(cx.w) {
    // rust: m.look_at_speed([t.position.x, t.eye_y, t.position.z], 60.0, 30.0);
    // rust: let u = m.position.vector_to(t.position).normalize();
    // rust: m.velocity = m.velocity.add_vector(Vec3::new(u.x * 0.8, 0.9, u.z * 0.8));
}
    // rust: m.nav_stop();
}
stop :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: set_flag(m, CROUCHING | INTERESTED | POUNCING, false);
    // rust: m.anim.v[CROUCH_AMOUNT] = 0.0;
    // rust: m.anim.vo[CROUCH_AMOUNT] = 0.0;
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: let target = m.target_info(cx.w);
    // rust: if let Some(t) = &target {
    // rust: m.look_at_speed([t.position.x, t.eye_y, t.position.z], 60.0, 30.0);
}
    // rust: if !flag(m, FACEPLANTED) {
    // rust: let v = m.velocity;
    // rust: if v.y * v.y < f64::from(0.03f32) && m.head_pitch != 0.0 {
    // rust: m.head_pitch += 0.2 * wrap(-m.head_pitch);
    // rust: } else {
    // rust: let horizontal = v.horizontal_distance();
    // rust: let bias = if m.ai.jumping && v.y > 0.0 { 6.5 } else { 1.0 };
    // rust: let y = v.y * bias;
    // rust: let len = (horizontal * horizontal + y * y).sqrt();
    // rust: if len > f64::from(1.0e-5f32) {
    // rust: let pitch = signum(-y) * jmath::acos(horizontal / len) * 180.0
    // rust: / f64::from(std::f32::consts::PI);
    // rust: m.head_pitch = (pitch as f32 % 360.0).clamp(-90.0, 90.0);
}
}
}
    // rust: if let (Some(t), Some(who)) = (&target, m.ai.target)
    // rust: && m.distance_sqr(t.position) <= 4.0
    // rust: {
    // rust: super::ai::do_hurt_target(m, who, cx);
    // rust: } else if m.head_pitch > 0.0
    // rust: && m.on_ground
    // rust: && m.velocity.y as f32 != 0.0
    // rust: && cx.w.block_name(
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: ) == "minecraft:snow"
    // rust: {
    // rust: m.head_pitch = 60.0;
    // rust: m.ai.target = None;
    // rust: set_flag(m, FACEPLANTED, true);
}
}
}

// `Fox.SeekShelterGoal`: by day, or in a thunderstorm, leave open sky for
// somewhere the sky does not see. Villages are not told apart yet (vanilla
// stays put in one).
SeekShelter :: struct {
    speed: f64,
    interval: i32,
    wanted: [f64,
}
    // rust: impl SeekShelter {
new :: proc(speed: f64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: speed,
    // rust: interval: reduced(100),
    // rust: wanted: [0.0; 3],
}
}
set_wanted_pos :: proc(self: ^Self, m: ^Mob, w: ^MobWorld) -> b {
    // Ported from Horizon
    return {}
}
    // rust: hide_pos(m, w).is_some_and(|at| {
    // rust: self.wanted = at;
    // rust: true
    // rust: })
}
}
    // rust: impl Goal for SeekShelter {
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
    // rust: if flag(m, SLEEPING) || m.ai.target.is_some() {
    // rust: return false;
}
    // rust: let at = [
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: ];
    // rust: let sees_sky = cx.w.can_see_sky(at[0], at[1], at[2]);
    // rust: if cx.w.thundering && sees_sky {
    // rust: self.set_wanted_pos(m, cx.w)
    // rust: } else if self.interval > 0 {
    // rust: self.interval -= 1;
    // rust: false
    // rust: } else {
    // rust: self.interval = 100;
    // rust: cx.w.daylight && sees_sky && self.set_wanted_pos(m, cx.w)
}
}
can_continue :: proc(self: ^Self, m: ^Mob, _: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !m.ai.nav.is_done()
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: clear_states(m);
    // rust: m.nav_move_to(cx.w, self.wanted, self.speed);
}
}

// `Fox.PerchAndSearchGoal`: now and then sit down and look around two to
// four times when nothing is going on.
Perch :: struct {
    rel: [f64,
    look_time: i32,
    looks_remaining: i32,
}
    // rust: impl Perch {
reset_look :: proc(self: ^Self, m: ^Mob) {
}
    // rust: let angle = std::f64::consts::TAU * m.random.next_double();
    // rust: self.rel = [angle.cos(), angle.sin()];
    // rust: self.look_time = reduced(80 + m.random.next_int_bound(20).unwrap_or(0));
}
}
    // rust: impl Goal for Perch {
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
    // rust: m.ai.last_hurt_by.is_none()
    // rust: && m.random.next_float() < 0.02
    // rust: && !flag(m, SLEEPING)
    // rust: && m.ai.target.is_none()
    // rust: && m.ai.nav.is_done()
    // rust: && !alertable(m, cx.w)
    // rust: && !flag(m, POUNCING | CROUCHING)
}
can_continue :: proc(self: ^Self, _: ^Mob, _: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.looks_remaining > 0
}
start :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: self.reset_look(m);
    // rust: self.looks_remaining = 2 + m.random.next_int_bound(3).unwrap_or(0);
    // rust: set_flag(m, SITTING, true);
    // rust: m.nav_stop();
}
stop :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: set_flag(m, SITTING, false);
}
tick :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: self.look_time -= 1;
    // rust: if self.look_time <= 0 {
    // rust: self.looks_remaining -= 1;
    // rust: self.reset_look(m);
}
    // rust: let at = [
    // rust: m.position.x + self.rel[0],
    // rust: m.eye_y(),
    // rust: m.position.z + self.rel[1],
    // rust: ];
    // rust: let (y, x) = (m.kind.max_head_y_rot, m.kind.max_head_x_rot);
    // rust: m.look_at_speed(at, y, x);
}
}

// `BlockState` with one property changed.
with_prop :: proc(w: ^MobWorld, p: [i32; 3], key: string, value: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut s = w.registry.state(w.world.block(p[0], p[1], p[2]))?.clone();
    // rust: s.properties.insert(key.into(), value.into());
    // rust: w.registry.id(&s)
}
// `FoxEatBerriesGoal.isValidTarget`: a ripe sweet berry bush or glow berries.
has_berries :: proc(w: ^MobWorld, p: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match w.block_name(p[0], p[1], p[2]) {
    // rust: "minecraft:sweet_berry_bush" => w
    // rust: .prop(p[0], p[1], p[2], "age")
    // rust: .and_then(|a| a.parse::<i32>().ok())
    // rust: .is_some_and(|a| a >= 2),
    // rust: "minecraft:cave_vines" | "minecraft:cave_vines_plant" => {
    // rust: w.prop(p[0], p[1], p[2], "berries") == Some("true")
}
    // rust: _ => false,
}
}

// `Fox.FoxEatBerriesGoal`: walk to a ripe berry bush and pick it after 40 ticks.
EatBerries :: struct {
    block: MoveToBlock,
    waited: i32,
}
    // rust: impl EatBerries {
new :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: block: MoveToBlock::new(1.2, 12, 1),
    // rust: waited: 0,
}
}
pick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: let p = self.block.block;
    // rust: let at = [
    // rust: f64::from(p[0]) + 0.5,
    // rust: f64::from(p[1]) + 0.5,
    // rust: f64::from(p[2]) + 0.5,
    // rust: ];
    // rust: if cx.w.block_name(p[0], p[1], p[2]) == "minecraft:sweet_berry_bush" {
    // rust: let age: i32 =
    // rust: cx.w.prop(p[0], p[1], p[2], "age")
    // rust: .and_then(|a| a.parse().ok())
    // rust: .unwrap_or(0);
    // rust: let mut count = 1 + m.random.next_int_bound(2).unwrap_or(0) + i32::from(age == 3);
    // rust: if m.extra.main_hand.is_none() {
    // rust: m.extra
    // rust: .set_main_hand(Some("minecraft:sweet_berries".into()));
    // rust: count -= 1;
}
    // rust: if count > 0 {
    // rust: cx.events.push(MobEvent::DropItem {
    // rust: mob: m.id,
    // rust: item: "minecraft:sweet_berries".into(),
    // rust: count: count as u32,
    // rust: at,
    // rust: });
}
    // rust: if let Some(state) = with_prop(cx.w, p, "age", "1") {
    // rust: cx.events.push(MobEvent::SetBlock { pos: p, state });
}
    // rust: cx.events.push(MobEvent::Sound(
    // rust: "block.sweet_berry_bush.pick_berries",
    // rust: at,
    // rust: 1.0,
    // rust: 1.0,
    // rust: ));
    // rust: } else {
            // CaveVines.use: one glow berry, the vine goes back to bare.
    // rust: cx.events.push(MobEvent::DropItem {
    // rust: mob: m.id,
    // rust: item: "minecraft:glow_berries".into(),
    // rust: count: 1,
    // rust: at,
    // rust: });
    // rust: if let Some(state) = with_prop(cx.w, p, "berries", "false") {
    // rust: cx.events.push(MobEvent::SetBlock { pos: p, state });
}
    // rust: let pitch = 0.8 + m.random.next_float() * 0.4;
    // rust: cx.events.push(MobEvent::Sound(
    // rust: "block.cave_vines.pick_berries",
    // rust: at,
    // rust: 1.0,
    // rust: pitch,
    // rust: ));
}
}
}
    // rust: impl Goal for EatBerries {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE | JUMP
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if flag(m, SLEEPING) {
    // rust: return false;
}
        // MoveToBlockGoal.canUse draws the next delay only once the last one
        // has run out.
    // rust: if self.block.next_start > 0 {
    // rust: self.block.next_start -= 1;
    // rust: return false;
}
    // rust: let next = reduced(200 + m.random.next_int_bound(200).unwrap_or(0));
    // rust: self.block.can_use(m, cx.w, next, has_berries)
}
can_continue :: proc(self: ^Self, _: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.block.can_continue(cx.w, has_berries)
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.waited = 0;
    // rust: set_flag(m, SITTING, false);
    // rust: self.block.start(m, cx.w);
}
every_tick :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: if self.block.reached {
    // rust: if self.waited >= 40 {
    // rust: if cx.w.mob_griefing {
    // rust: self.pick(m, cx);
}
    // rust: } else {
    // rust: self.waited += 1;
}
    // rust: } else if m.random.next_float() < 0.05 {
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: cx.events
    // rust: .push(MobEvent::Sound("entity.fox.sniff", at, 1.0, 1.0));
}
    // rust: self.block.tick_within(m, cx.w, 2.0);
}
}

// `FoxRenderState` as the renderer reads it: the flags, `getHeadRollAngle`
// and `getCrouchAmount` at the partial tick. `FoxModel.legMotionPos` gains
// 0.67 a frame; this takes 60 frames a second.
pose :: proc(m: ^Mob, partial: f32) -> s {
    // Ported from Horizon
    return {}
}
    // rust: super::body_anim::Fox {
    // rust: crouching: flag(m, CROUCHING),
    // rust: sleeping: flag(m, SLEEPING),
    // rust: sitting: flag(m, SITTING),
    // rust: pouncing: flag(m, POUNCING),
    // rust: faceplanted: flag(m, FACEPLANTED),
    // rust: head_roll_angle: m.anim.lerp(INTERESTED_ANGLE, partial) * 0.11 * std::f32::consts::PI,
    // rust: crouch_amount: m.anim.lerp(CROUCH_AMOUNT, partial),
    // rust: leg_motion_pos: (m.age as f32 + partial) * 0.67 * 3.0,
}
}

    // rust: mod trust_tests {
//     use super::*;
//     use crate::mobs::sensor_scan_tests::kind;

fox :: proc() -> M {
    // Ported from Horizon
    return {}
}
    // rust: let mut kind = kind();
    // rust: let k = std::sync::Arc::make_mut(&mut kind);
    // rust: k.id = "minecraft:fox".into();
    // rust: k.species = Species::Fox;
    // rust: Mob::new(1, kind, Vec3::ZERO, 0.0)
}

    // `Fox.addTrustedEntity`: the first free slot, then the second, and a
    // third player replaces the second (`DATA_TRUSTED_ID_0/1`).
a_fox_trusts_two_players_and_the_third_replaces_the_second :: proc() {
}
A :: [1, 2, 3, 4]
B :: [5, 6, 7, 8]
C :: [9, 10, 11, 12]
    // rust: let mut f = fox();
    // rust: assert!(!trusts(&f, A), "a fresh fox trusts nobody");
    // rust: add_trusted_entity(&mut f, A);
    // rust: add_trusted_entity(&mut f, B);
    // rust: assert!(trusts(&f, A) && trusts(&f, B));
    // rust: add_trusted_entity(&mut f, C);
    // rust: assert!(trusts(&f, A), "the first slot stays");
    // rust: assert!(!trusts(&f, B) && trusts(&f, C), "the second is replaced");
    // rust: assert_eq!(trusted_entities(&f).collect::<Vec<_>>(), vec![A, C]);
    // rust: clear_trusted(&mut f);
    // rust: assert_eq!(trusted_entities(&f).count(), 0);
    // rust: assert!(!trusts(&f, A));
}
}

    // rust: mod trust_breed_tests {
//     use super::*;
//     use crate::mobs::sensor_scan_tests::kind;

fox :: proc() -> M {
    // Ported from Horizon
    return {}
}
    // rust: let mut kind = kind();
    // rust: let k = std::sync::Arc::make_mut(&mut kind);
    // rust: k.id = "minecraft:fox".into();
    // rust: k.species = Species::Fox;
    // rust: Mob::new(1, kind, Vec3::ZERO, 0.0)
}

    // `Fox.FoxBreedGoal.breed`: the baby trusts both players who fed the
    // parents into love, and one of them only once when it is the same.
a_baby_fox_trusts_both_players_who_fed_its_parents :: proc() {
}
A :: [1, 2, 3, 4]
B :: [5, 6, 7, 8]
    // rust: let mut baby = fox();
    // rust: trust_breeders(&mut baby, Some(A), Some(B));
    // rust: assert_eq!(trusted_entities(&baby).collect::<Vec<_>>(), vec![A, B]);
    // rust: let mut same = fox();
    // rust: trust_breeders(&mut same, Some(A), Some(A));
    // rust: assert_eq!(trusted_entities(&same).collect::<Vec<_>>(), vec![A]);
    // rust: let mut one = fox();
    // rust: trust_breeders(&mut one, Some(A), None);
    // rust: assert_eq!(trusted_entities(&one).collect::<Vec<_>>(), vec![A]);
    // rust: let mut none = fox();
    // rust: trust_breeders(&mut none, None, None);
    // rust: assert_eq!(trusted_entities(&none).count(), 0);
}
}

// Where the first item a fox may pick up lies within 8 blocks (`Fox.ALLOWED_ITEMS`:
// no pickup delay, alive), found by the game each tick for `FoxSearchForItemsGoal`.
set_item_at :: proc(m: ^Mob, at: Maybe([f64; 3])) {
}
    // rust: m.extra.point = at;
}
// `Fox.canHoldItem`: an empty mouth, or food to swap for what is not food once it has
// eaten at all. `food` says whether `item` and the held item are consumable food.
can_hold_item :: proc(m: ^Mob, item_is_food: bool, held_is_food: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.main_hand.is_none()
    // rust: || (m.extra.ints[TICKS_SINCE_EATEN] > 0 && item_is_food && !held_is_food)
}
// `Fox.pickUpItem` after the swap: it has taken the item (`ticksSinceEaten = 0`).
took_item :: proc(m: ^Mob) {
}
    // rust: m.extra.ints[TICKS_SINCE_EATEN] = 0;
}
// `Fox.FoxSearchForItemsGoal`: walk to a dropped item while the mouth is empty.
SearchForItems :: struct {
    // rust: impl Goal for SearchForItems {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE
}
can_use :: proc(self: ^Self, m: ^Mob, _cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if m.extra.main_hand.is_some() {
    // rust: return false;
}
    // rust: if m.ai.target.is_some() || m.ai.last_hurt_by.is_some() {
    // rust: return false;
}
    // rust: if !can_move(m) {
    // rust: return false;
}
    // rust: if m.random.next_int_bound(reduced(10)).unwrap_or(0) != 0 {
    // rust: return false;
}
    // rust: m.extra.point.is_some() && m.extra.main_hand.is_none()
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: if let Some(at) = m.extra.point {
    // rust: m.nav_move_to_entity(cx.w, at, 0, f64::from(1.2_f32));
}
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: if m.extra.main_hand.is_none()
    // rust: && let Some(at) = m.extra.point
    // rust: {
    // rust: m.nav_move_to_entity(cx.w, at, 0, f64::from(1.2_f32));
}
}
}

    // rust: mod pickup_tests {
//     use super::*;
//     use crate::mobs::sensor_scan_tests::kind;

fox :: proc() -> M {
    // Ported from Horizon
    return {}
}
    // rust: let mut kind = kind();
    // rust: let k = std::sync::Arc::make_mut(&mut kind);
    // rust: k.id = "minecraft:fox".into();
    // rust: k.species = Species::Fox;
    // rust: Mob::new(1, kind, Vec3::ZERO, 0.0)
}

    // `Fox.canHoldItem`: an empty mouth takes anything; a full one only swaps its non-food
    // for food, and only once the fox has had ticks since it last ate.
a_fox_holds_what_its_mouth_has_room_for :: proc() {
}
    // rust: let mut f = fox();
    // rust: assert!(
    // rust: can_hold_item(&f, false, false),
    // rust: "an empty mouth takes any item"
    // rust: );
    // rust: f.extra.set_main_hand(Some("minecraft:stick".into()));
    // rust: f.extra.ints[TICKS_SINCE_EATEN] = 0;
    // rust: assert!(
    // rust: !can_hold_item(&f, true, false),
    // rust: "no food swap at 0 ticks since eating"
    // rust: );
    // rust: f.extra.ints[TICKS_SINCE_EATEN] = 1;
    // rust: assert!(can_hold_item(&f, true, false), "food replaces a stick");
    // rust: assert!(
    // rust: !can_hold_item(&f, false, false),
    // rust: "a stick does not replace a stick"
    // rust: );
    // rust: assert!(!can_hold_item(&f, true, true), "food does not replace food");
    // rust: took_item(&mut f);
    // rust: assert_eq!(
    // rust: f.extra.ints[TICKS_SINCE_EATEN], 0,
    // rust: "taking an item restarts the clock"
    // rust: );
}
}

    // rust: mod consume_tests {
//     use super::*;
//     use crate::mobs::world::with_built_test_world;

    // `Item.finishUsingItem` → `Consumable.onConsume`: a fox that finishes a
    // chorus fruit takes `TeleportRandomlyConsumeEffect`'s teleport, with its
    // own sound and the portal trail (level event 2017).
a_chorus_fruit_carries_the_fox_to_free_ground :: proc() {
}
    // rust: let ran = with_built_test_world(
    // rust: &[],
    // rust: |world, registry| {
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
    // rust: world.chunks.insert(
    // rust: (cx, cz),
    // rust: std::sync::Arc::new(crate::chunk::Chunk::empty(cx, cz)),
    // rust: );
}
    // rust: let stone = registry.default_state("minecraft:stone").unwrap();
    // rust: for x in -16..32 {
    // rust: for z in -16..32 {
    // rust: world.set(x, 0, z, stone).unwrap();
}
}
    // rust: },
    // rust: |w, types| {
    // rust: let kind = std::sync::Arc::new(types.types["minecraft:fox"].clone());
    // rust: let mut m = Mob::new(1, kind, Vec3::new(0.5, 1.0, 0.5), 0.0);
    // rust: m.on_ground = true;
    // rust: m.extra.set_main_hand(Some("minecraft:chorus_fruit".into()));
                // Past the 600 ticks `Fox.aiStep` waits before it finishes the item.
    // rust: m.extra.ints[TICKS_SINCE_EATEN] = 601;
    // rust: let mut events = Vec::new();
    // rust: ai_step(&mut m, w, &mut events);
    // rust: assert_ne!(m.position, Vec3::new(0.5, 1.0, 0.5), "the fruit moved it");
                // `Entity.randomTeleport` drops the drawn height by one per
                // step until the block below it is ground: just above the stone.
    // rust: assert!(
    // rust: (1.0..2.0).contains(&m.position.y),
    // rust: "it stands on the stone floor, got {}",
    // rust: m.position.y
    // rust: );
    // rust: assert_eq!(m.extra.main_hand, None, "the fruit was eaten");
    // rust: assert_eq!(m.extra.ints[TICKS_SINCE_EATEN], 0);
    // rust: assert!(
    // rust: events
    // rust: .iter()
    // rust: .any(|e| matches!(e, MobEvent::Sound("entity.fox.teleport", ..))),
    // rust: "the fox's teleport sound: {events:?}"
    // rust: );
    // rust: assert!(
    // rust: events
    // rust: .iter()
    // rust: .any(|e| matches!(e, MobEvent::LevelEvent { id: 2017, .. })),
    // rust: "the portal trail: {events:?}"
    // rust: );
    // rust: assert!(
    // rust: events
    // rust: .iter()
    // rust: .any(|e| matches!(e, MobEvent::EntityEvent { event: 46, .. })),
    // rust: "entity event 46: {events:?}"
    // rust: );
    // rust: },
    // rust: );
        // Without the vanilla data under .local/horizon-client (CI's unit
        // tests) there is no fox to feed: the test has nothing to check.
    // rust: let _ = ran;
}
}
