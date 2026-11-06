//! Transpiled from Horizon Rust crate
package horizon_client_villager

import "core:fmt"
import "core:mem"
import "core:math"

// Villagers (`Villager`): professions, sleeping, the unhappy head shake,
// food, gossip and the raid state. Their AI is the brain in
// `villager_brain`.
// use super::{
    // rust: Mob, MobEvent, MobWorld, Species,
    // rust: anim::{Poses, State},
}
// use crate::items::ItemStack;
// use horizon_core::geometry::trig::Mth;
// use horizon_core::random::RandomSource;
// use std::f32::consts::PI;

// Villager state: `variant` type, `variant2` profession (index into
// `render::PROFESSIONS`), `variant3` level, `home` the claimed job site,
// `bed` and `meeting` the claimed bed head and bell, `ints[0]` the unhappy
// counter, `ints[1]` the bed's facing while asleep (1 north, 2 south,
// 3 west, 4 east), `trade` the offers, experience and restocks.

NONE :: 0
NITWIT :: 11

// `PoiTypes`: the job site block of each profession.
job_site_profession :: proc(block: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(match block.trim_start_matches("minecraft:") {
    // rust: "blast_furnace" => 1,
    // rust: "smoker" => 2,
    // rust: "cartography_table" => 3,
    // rust: "brewing_stand" => 4,
    // rust: "composter" => 5,
    // rust: "barrel" => 6,
    // rust: "fletching_table" => 7,
    // rust: "cauldron" | "water_cauldron" | "lava_cauldron" | "powder_snow_cauldron" => 8,
    // rust: "lectern" => 9,
    // rust: "stonecutter" => 10,
    // rust: "loom" => 12,
    // rust: "smithing_table" => 13,
    // rust: "grindstone" => 14,
    // rust: _ => return None,
    // rust: })
}

register :: proc(m: ^Mob) {
}
    // rust: if m.extra.variant3 == 0 {
    // rust: m.extra.variant3 = 1;
}
    // Villager's constructor: its brain does everything, it has no goals.
    // rust: m.ai.nav.can_open_doors = true;
    // rust: m.ai.nav.can_float = true;
    // rust: m.set_required_path_length(48.0);
}

// `LivingEntity.addParticlesAroundSelf`: five particles about the body.
particles_around :: proc(m: ^Mob, kind: ^'static str, events: ^[dynamic]MobEvent) {
}
    // rust: let (w, h) = (f64::from(m.width()), f64::from(m.height()));
    // rust: for _ in 0..5 {
    // rust: let at = [
    // rust: m.position.x + w * (2.0 * m.random.next_double() - 1.0),
    // rust: m.position.y + h * m.random.next_double() + 1.0,
    // rust: m.position.z + w * (2.0 * m.random.next_double() - 1.0),
    // rust: ];
    // rust: events.push(MobEvent::Particles { kind, at, count: 0 });
}
}
// The `villager_activity` / `baby_villager_activity` timeline.
Activity :: enum {
    Idle,
    Work,
    Play,
    Meet,
    Rest,
}
activity :: proc(m: ^Mob, day_time: i64) -> A {
    // Ported from Horizon
    return {}
}
    // rust: activity_at(m.is_baby(), day_time)
}
activity_at :: proc(baby: bool, day_time: i64) -> A {
    // Ported from Horizon
    return {}
}
    // rust: let t = day_time.rem_euclid(24000);
    // rust: if baby {
    // rust: match t {
    // rust: 10..3000 | 6000..10000 => Activity::Idle,
    // rust: 3000..6000 | 10000..12000 => Activity::Play,
    // rust: _ => Activity::Rest,
}
    // rust: } else {
    // rust: match t {
    // rust: 10..2000 | 11000..12000 => Activity::Idle,
    // rust: 2000..9000 => Activity::Work,
    // rust: 9000..11000 => Activity::Meet,
    // rust: _ => Activity::Rest,
}
}
}
sleeping :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(m.species(), Species::Villager | Species::WanderingTrader) && m.extra.ints[1] != 0
}
// `LivingEntity.startSleeping`: lie in the bed (`setPosToBed`), whose
// head becomes `occupied`.
start_sleeping :: proc(m: ^Mob, p: [i32; 3], w: ^MobWorld, events: ^[dynamic]MobEvent) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if w.prop(p[0], p[1], p[2], "occupied") == Some("true") {
    // rust: return false;
}
    // rust: m.extra.ints[1] = bed_facing_code(w.prop(p[0], p[1], p[2], "facing"));
    // rust: m.nav_stop();
    // rust: let e = ext_mut(m);
    // rust: e.last_slept = Some(w.game_time);
    // rust: e.sleeping_pos = Some(p);
    // rust: events.push(MobEvent::BedOccupied {
    // rust: pos: p,
    // rust: occupied: true,
    // rust: });
    // rust: m.velocity = horizon_core::geometry::Vec3::ZERO;
    // rust: m.position = horizon_core::geometry::Vec3::new(
    // rust: f64::from(p[0]) + 0.5,
    // rust: f64::from(p[1]) + 0.6875,
    // rust: f64::from(p[2]) + 0.5,
    // rust: );
    // rust: true
}
// `LivingEntity.stopSleeping`: the bed is no longer `occupied`, and the
// sleeper stands at `AbstractBedBlock.findStandUpPosition` for its yaw,
// else 0.1 above the block over the bed.
stop_sleeping :: proc(m: ^Mob, w: ^MobWorld, events: ^[dynamic]MobEvent) {
}
    // rust: m.extra.ints[1] = 0;
    // rust: let bed = m
    // rust: .extra
    // rust: .villager
    // rust: .as_deref_mut()
    // rust: .and_then(|e| e.sleeping_pos.take());
    // rust: let Some(p) = bed else { return };
    // rust: if !w.block_name(p[0], p[1], p[2]).ends_with("_bed") {
    // rust: return;
}
    // rust: events.push(MobEvent::BedOccupied {
    // rust: pos: p,
    // rust: occupied: false,
    // rust: });
    // rust: let level = crate::stand_up::StandUpLevel {
    // rust: world: w.world,
    // rust: registry: w.registry,
    // rust: facts: w.facts,
    // rust: collision: w.collision,
    // rust: block_tags: w.block_tags,
    // rust: border: w.border,
}
    // rust: let forward = crate::stand_up::bed_forward(w.prop(p[0], p[1], p[2], "facing"));
    // rust: let stand = level
    // rust: .bed_stand_up(crate::stand_up::StandUpType::VILLAGER, p, forward, m.yaw)
    // rust: .unwrap_or_else(|| crate::stand_up::stand_up_fallback(p));
    // rust: set_wake_pose(m, p, stand);
}
// Rotation part of `LivingEntity.stopSleeping`, after choosing where to stand.
set_wake_pose :: proc(m: ^Mob, bed: [i32; 3], stand: horizon_core::geometry::Vec3) {
}
//     use horizon_core::geometry::{Vec3, trig};
    // rust: let d = Vec3::new(
    // rust: f64::from(bed[0]) + 0.5,
    // rust: f64::from(bed[1]),
    // rust: f64::from(bed[2]) + 0.5,
    // rust: )
    // rust: .subtract(stand)
    // rust: .normalize();
    // rust: let mut yaw = (trig::atan2(d.z, d.x) * f64::from(trig::RAD_TO_DEG) - 90.0) % 360.0;
    // rust: if yaw >= 180.0 {
    // rust: yaw -= 360.0;
}
    // rust: if yaw < -180.0 {
    // rust: yaw += 360.0;
}
    // rust: m.position = stand;
    // rust: m.yaw = yaw as f32;
    // rust: m.head_pitch = 0.0;
}
// `LivingEntity.getSleepingPos`: the bed head a sleeper lies in.
sleeping_pos :: proc(m: ^Mob) -> O {
    // Ported from Horizon
    return {}
}
    // rust: ext(m).and_then(|e| e.sleeping_pos).filter(|_| sleeping(m))
}
// `LivingEntityRenderer.sleepDirectionToRotation` and the bed's direction
// (the body is shifted back from the pillow by the standing eye height).
// A bed's `facing` as `sleep_pose` keeps it in `ints[1]`.
bed_facing_code :: proc(facing: Maybe(string)) -> i {
    // Ported from Horizon
    return {}
}
    // rust: match facing {
    // rust: Some("north") => 1,
    // rust: Some("south") => 2,
    // rust: Some("west") => 3,
    // rust: _ => 4,
}
}
sleep_pose :: proc(m: ^Mob) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(match m.extra.ints[1] {
    // rust: 1 => (270.0, [0.0, -1.0]),
    // rust: 2 => (90.0, [0.0, 1.0]),
    // rust: 3 => (0.0, [-1.0, 0.0]),
    // rust: 4 => (180.0, [1.0, 0.0]),
    // rust: _ => return None,
    // rust: })
}
// `Villager.tick`: the unhappy counter and the gossip decay; a hurt
// sleeper wakes up (`LivingEntity.hurtServer`; the `checkBedExists` wake
// runs earlier in `LivingEntity.tick`, for AI-less mobs too), and lies the
// way its bed faces (`getBedOrientation`). The brain does the rest.
ai_step :: proc(m: ^Mob, w: ^MobWorld, events: ^[dynamic]MobEvent) {
}
    // rust: if m.extra.ints[0] > 0 {
    // rust: m.extra.ints[0] -= 1;
}
    // rust: if m.species() == Species::Villager {
    // rust: ext_mut(m).maybe_decay(w.game_time);
}
    // rust: if sleeping(m) {
    // rust: let bed = sleeping_pos(m).filter(|p| w.block_name(p[0], p[1], p[2]).ends_with("_bed"));
    // rust: if let Some(p) = bed {
    // rust: m.extra.ints[1] = bed_facing_code(w.prop(p[0], p[1], p[2], "facing"));
}
    // rust: if m.hurt_time > 0 {
    // rust: stop_sleeping(m, w, events);
    // rust: super::villager_brain::woken(m, w.game_time);
}
}
}
// `Villager.setUnhappy`: shake the head for two seconds and say no.
set_unhappy :: proc(m: ^Mob, events: ^[dynamic]MobEvent) {
}
    // rust: m.extra.ints[0] = 40;
    // rust: let sound = if m.species() == Species::WanderingTrader {
    // rust: "entity.wandering_trader.no"
    // rust: } else {
    // rust: "entity.villager.no"
}
    // Mob.makeSound: the sound volume and the voice pitch (babies ~1.5).
    // rust: m.voice(sound, events);
}
// `VillagerModel.setupAnim`.
anim :: proc(m: ^Mob, s: ^State, p: ^Poses) {
}
    // rust: let awake = !sleeping(m);
    // rust: p.yrot("head", if awake { s.y_rot.to_radians() } else { 0.0 });
    // rust: p.xrot("head", if awake { s.x_rot.to_radians() } else { 0.0 });
    // rust: if m.extra.ints[0] > 0 {
    // rust: p.zrot("head", 0.3 * (0.45 * s.age).msin());
    // rust: p.xrot("head", 0.4);
    // rust: } else {
    // rust: p.zrot("head", 0.0);
}
    // rust: let leg = (s.pos * 0.6662).mcos() * 1.4 * s.speed * 0.5;
    // rust: p.xrot("right_leg", leg);
    // rust: p.xrot(
    // rust: "left_leg",
    // rust: (s.pos * 0.6662 + PI).mcos() * 1.4 * s.speed * 0.5,
    // rust: );
    // rust: p.yrot("right_leg", 0.0);
    // rust: p.yrot("left_leg", 0.0);
}

// ---- Raids: the raid activities and the gift for a hero.

// No raid where the villager stands (`ServerLevel.getRaidAt` is null).
RAID_NONE :: 0
// A raid is near, before or between its waves.
PRE_RAID :: 1
// A raid is near and a wave is on.
RAID :: 2
// The raid there was won: the villagers celebrate.
RAID_VICTORY :: 3
// The raid there was lost (still found by `getRaidAt` until it stops).
RAID_LOSS :: 4

// Villager state beyond `Extra`'s scratch fields.
Ext :: struct {
    // The raid `getRaidAt` finds where the villager stands (`RAID_NONE`
    // ... `RAID_LOSS`), set by the game every tick.
    raid: u8,
    // That raid has spawned a wave and is not between waves
    // (`hasFirstWaveSpawned && !isBetweenWaves`).
    raid_wave: bool,
    // What the villager remembers of players (`gossips`).
    gossips: crate::gossip::Gossips,
    last_gossip_time: i64,
    last_gossip_decay: i64,
    // `foodLevel`: eaten but not yet digested, in food points.
    food_level: i32,
    // The eight-slot inventory (`InventoryCarrier`).
    inventory: [dynamic]ItemStack,
    // `LAST_SLEPT` memory.
    last_slept: Maybe(i64),
    // `LivingEntity.getSleepingPos`: the bed head it lies in, saved as
    // `sleeping_pos`.
    sleeping_pos: Option<[i32,
    // `GOLEM_DETECTED_RECENTLY` expires at this game time.
    golem_until: i64,
    // The `last_hurt_by_time` of the player's hit already counted.
    hurt_seen: i32,
    // A zombie villager's cure under way.
    cure: Maybe(super::zombie_villager::Cure),
    // The villager's brain, built at its first tick.
    brain: Maybe(^super::villager_brain::Brain),
}
ext :: proc(m: ^Mob) -> O {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.villager.as_deref()
}
ext_mut :: proc(m: ^Mob) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.villager.get_or_insert_with(Box::default)
}
// The raid where the villager stands (`RAID_NONE` ... `RAID_LOSS`).
raid_status :: proc(m: ^Mob) -> u {
    // Ported from Horizon
    return {}
}
    // rust: ext(m).map_or(RAID_NONE, |e| e.raid)
}
// `ServerLevel.getRaidAt(blockPosition)` is a raid.
raid_nearby :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: ext(m).is_some_and(|e| e.raid != RAID_NONE)
}
// `ResetRaidStatus`: no raid, a stopped one or a lost one.
raid_over_or_lost :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(raid_status(m), RAID_NONE | RAID_LOSS)
}
// `SetRaidStatus`: `Some(true)` while a wave is on
// (`hasFirstWaveSpawned && !isBetweenWaves`), `Some(false)` otherwise.
raid_state :: proc(m: ^Mob) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let e = ext(m)?;
    // rust: (e.raid != RAID_NONE).then_some(e.raid_wave)
}
// `Villager.getVillagerXp`.
xp :: proc(m: ^Mob) -> i {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.trade.as_ref().map_or(0, |t| t.xp)
}
// `Villager.setVillagerData(withProfession)`: a new profession forgets the
// offers (`offers = null`), so the next `getOffers` rolls the new
// profession's trades.
set_profession :: proc(m: ^Mob, profession: u8) {
}
    // rust: if m.extra.variant2 != profession {
    // rust: m.extra.variant2 = profession;
    // rust: if let Some(t) = m.extra.trade.as_mut() {
    // rust: t.offers.clear();
    // rust: t.unset = true;
}
}
}
// `VillagerProfession.workSound`.
work_sound :: proc(profession: u8) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(match super::render::PROFESSIONS[profession as usize % 15] {
    // rust: "armorer" => "entity.villager.work_armorer",
    // rust: "butcher" => "entity.villager.work_butcher",
    // rust: "cartographer" => "entity.villager.work_cartographer",
    // rust: "cleric" => "entity.villager.work_cleric",
    // rust: "farmer" => "entity.villager.work_farmer",
    // rust: "fisherman" => "entity.villager.work_fisherman",
    // rust: "fletcher" => "entity.villager.work_fletcher",
    // rust: "leatherworker" => "entity.villager.work_leatherworker",
    // rust: "librarian" => "entity.villager.work_librarian",
    // rust: "mason" => "entity.villager.work_mason",
    // rust: "shepherd" => "entity.villager.work_shepherd",
    // rust: "toolsmith" => "entity.villager.work_toolsmith",
    // rust: "weaponsmith" => "entity.villager.work_weaponsmith",
    // rust: _ => return None,
    // rust: })
}
// A `CropBlock` at `p`.
crop :: proc(w: ^MobWorld, p: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: w.facts
    // rust: .get(w.world.block(p[0], p[1], p[2]))
    // rust: .has_class("CropBlock")
}
// `CropBlock.isMaxAge` for the block at `p`.
ripe_crop :: proc(w: ^MobWorld, p: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let facts = w.facts.get(w.world.block(p[0], p[1], p[2]));
    // rust: if !facts.has_class("CropBlock") {
    // rust: return false;
}
    // The class chain survives content registration, including the two
    // getMaxAge overrides. PitcherCropBlock is not a CropBlock.
    // rust: let max = if facts.has_class("BeetrootBlock") {
    // rust: 3
    // rust: } else if facts.has_class("TorchflowerCropBlock") {
    // rust: 2
    // rust: } else {
    // rust: 7
}
    // rust: w.prop(p[0], p[1], p[2], "age")
    // rust: .and_then(|age| age.parse::<i32>().ok())
    // rust: .is_some_and(|age| age >= max)
}

// The gift loot table of a villager (`GiveGiftToHero.getLootTableToThrow`).
gift_table :: proc(m: ^Mob) -> S {
    // Ported from Horizon
    return {}
}
    // rust: if m.is_baby() {
    // rust: return "minecraft:gameplay/hero_of_the_village/baby_gift".into();
}
    // rust: let profession = super::render::PROFESSIONS[m.extra.variant2 as usize % 15];
    // rust: let name = match profession {
    // rust: "none" | "nitwit" => "unemployed",
    // rust: other => other,
}
    // rust: format!("minecraft:gameplay/hero_of_the_village/{name}_gift")
}
// ---- Gossip, food, breeding and golems.

// `VillagerFood` nutrition (`DataComponents.VILLAGER_FOOD`).
//
// The item registry's value: a data pack's or a mod's item with the component
// counts, as one with vanilla's four does. Until a registry is loaded (tests)
// those four.
food_points :: proc(item: string) -> i {
    // Ported from Horizon
    return {}
}
    // rust: horizon_items::items::villager_food(item).unwrap_or(match item {
    // rust: "minecraft:bread" => 4,
    // rust: "minecraft:potato" | "minecraft:carrot" | "minecraft:beetroot" => 1,
    // rust: _ => 0,
    // rust: })
}
// The farmer's `requestedItems` (`VillagerProfession.FARMER`). Food is picked
// up and traded separately, through its villager food value.
farmer_items :: proc() -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &[
    // rust: "minecraft:wheat",
    // rust: "minecraft:wheat_seeds",
    // rust: "minecraft:beetroot_seeds",
    // rust: "minecraft:bone_meal",
    // rust: ]
}
// A villager's `requestedItems` by profession.
requested_items :: proc(m: ^Mob) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: if super::render::PROFESSIONS[m.extra.variant2 as usize % 15] == "farmer" {
    // rust: farmer_items()
    // rust: } else {
    // rust: &[]
}
}
is_farmer :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: super::render::PROFESSIONS[m.extra.variant2 as usize % 15] == "farmer"
}
// `SimpleContainer(8)`: stacks the villager carries.
INVENTORY_SLOTS :: 8

    // rust: impl Ext {
    // `countFoodPointsInInventory`.
food_in_inventory :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.inventory
    // rust: .iter()
    // rust: .map(|s| food_points(&s.item) * s.count as i32)
    // rust: .sum()
}
    // `hasExcessFood` and `wantsMoreFood`.
has_excess_food :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.food_in_inventory() >= 24
}
wants_more_food :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.food_in_inventory() < 12
}
hungry :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.food_level < 12
}
    // `Villager.eatAndDigestFood`: eat until full, then digest 12 points.
eat_and_digest :: proc(self: ^Self) {
}
    // rust: if self.hungry() {
    // rust: let mut slot = 0;
    // rust: while slot < self.inventory.len() && self.hungry() {
    // rust: let points = food_points(&self.inventory[slot].item);
    // rust: if points > 0 {
    // rust: while self.inventory[slot].count > 0 && self.hungry() {
    // rust: self.food_level += points;
    // rust: self.inventory[slot].count -= 1;
}
    // rust: if self.inventory[slot].count == 0 {
    // rust: self.inventory.remove(slot);
    // rust: continue;
}
}
    // rust: slot += 1;
}
}
    // rust: self.food_level -= 12;
}
    // Whether the stack fits (`SimpleContainer.canAddItem`).
can_add :: proc(self: ^Self, stack: ^ItemStack, max_stack: u32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.inventory.len() < INVENTORY_SLOTS
    // rust: || self
    // rust: .inventory
    // rust: .iter()
    // rust: .any(|s| s.same_item_same_components(stack) && s.count < max_stack)
}
    // `SimpleContainer.addItem`: merge into stacks, then free slots; the
    // part that did not fit is returned.
add_item :: proc(self: ^Self, mut stack: ItemStack, max_stack: u32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: for s in &mut self.inventory {
    // rust: if stack.count > 0 && s.same_item_same_components(&stack) && s.count < max_stack {
    // rust: let n = (max_stack - s.count).min(stack.count);
    // rust: s.count += n;
    // rust: stack.count -= n;
}
}
    // rust: while stack.count > 0 && self.inventory.len() < INVENTORY_SLOTS {
    // rust: let n = stack.count.min(max_stack);
    // rust: self.inventory.push(ItemStack {
    // rust: count: n,
    // rust: ..stack.clone()
    // rust: });
    // rust: stack.count -= n;
}
    // rust: (stack.count > 0).then_some(stack)
}
    // `SimpleContainer.removeItemType`: take up to `count` of the item from
    // the first stacks that hold it.
remove_item :: proc(self: ^Self, item: string, mut count: u32) {
}
    // rust: let mut slot = 0;
    // rust: while slot < self.inventory.len() && count > 0 {
    // rust: let s = &mut self.inventory[slot];
    // rust: if &*s.item == item {
    // rust: let n = s.count.min(count);
    // rust: s.count -= n;
    // rust: count -= n;
    // rust: if s.count == 0 {
    // rust: self.inventory.remove(slot);
    // rust: continue;
}
}
    // rust: slot += 1;
}
}
count_item :: proc(self: ^Self, item: string) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.inventory
    // rust: .iter()
    // rust: .filter(|s| &*s.item == item)
    // rust: .map(|s| s.count)
    // rust: .sum()
}
    // `TradeWithVillager.throwHalfStack`: the half of a big matching stack
    // (or whatever is over 24) leaves the inventory.
    // rust: pub fn take_half_stack(
    // rust: &mut self,
    // rust: wanted: impl Fn(&ItemStack) -> bool,
    // rust: max_stack: impl Fn(&str) -> u32,
    // rust: ) -> Option<ItemStack> {
    // rust: for i in 0..self.inventory.len() {
    // rust: let s = &self.inventory[i];
    // rust: if s.count == 0 || !wanted(s) {
    // rust: continue;
}
    // rust: let count = if s.count > max_stack(&s.item) / 2 {
    // rust: s.count / 2
    // rust: } else if s.count > 24 {
    // rust: s.count - 24
    // rust: } else {
    // rust: continue;
}
    // rust: let taken = ItemStack { count, ..s.clone() };
    // rust: self.inventory[i].count -= count;
    // rust: if self.inventory[i].count == 0 {
    // rust: self.inventory.remove(i);
}
    // rust: return Some(taken);
}
    // rust: None
}
    // `Villager.wantsToSpawnGolem`: slept within the last day and no golem
    // seen lately.
wants_golem :: proc(self: ^Self, now: i64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.last_slept.is_some_and(|t| now - t < 24000) && now >= self.golem_until
}
    // `maybeDecayGossip`: once a day.
maybe_decay :: proc(self: ^Self, now: i64) {
}
    // rust: if self.last_gossip_decay == 0 {
    // rust: self.last_gossip_decay = now;
    // rust: } else if now >= self.last_gossip_decay + 24000 {
    // rust: self.gossips.decay();
    // rust: self.last_gossip_decay = now;
}
}
    // `Villager.gossip` timing: hearing again waits 1200 ticks.
can_gossip :: proc(self: ^Self, now: i64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: now < self.last_gossip_time || now >= self.last_gossip_time + 1200
}
}
// What a villager ticking later reads of another one this tick (vanilla
// reads the other villager itself).
Seen :: struct {
    gossips: crate::gossip::Gossips,
    last_gossip_time: i64,
    // `countFoodPointsInInventory`.
    food_points: i32,
    // The `INTERACTION_TARGET` memory (play tag's chases).
    interaction_target: Maybe(super::Who),
    // The `PATH` memory, when not done: its previous and next nodes.
    path_nodes: Option<(Option<[i32,
    // `LAST_SLEPT` and whether `GOLEM_DETECTED_RECENTLY` is remembered.
    last_slept: Maybe(i64),
    golem_detected: bool,
}
    // rust: impl Seen {
    // `Villager.wantsToSpawnGolem`.
wants_golem :: proc(self: ^Self, now: i64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.last_slept.is_some_and(|t| now - t < 24000) && !self.golem_detected
}
    // `Villager.wantsMoreFood`.
wants_more_food :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.food_points < 12
}
}
seen :: proc(m: ^Mob) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let e = ext(m);
    // rust: let (interaction_target, path_nodes, golem_detected, last_slept) =
    // rust: super::villager_brain::seen_memories(m);
    // rust: Seen {
    // rust: gossips: e.map(|e| e.gossips.clone()).unwrap_or_default(),
    // rust: last_gossip_time: e.map_or(0, |e| e.last_gossip_time),
    // rust: food_points: e.map_or(0, Ext::food_in_inventory),
    // rust: interaction_target,
    // rust: path_nodes,
    // rust: last_slept: last_slept.or(e.and_then(|e| e.last_slept)),
    // rust: golem_detected,
}
}
// What `TradeWithVillager.tick` hands over: stacks tossed from the first
// villager's hand (`from`, its eye height) toward the second (`to`), and
// whether the gossip happened (`spawnGolemIfNeeded` follows).
Meeting :: struct {
    thrown: [dynamic]ItemStack,
    from: horizon_core::geometry::Vec3,
    eye: f64,
    to: horizon_core::geometry::Vec3,
    gossiped: bool,
}
// `TradeWithVillager.tick` for villagers `a` and `b` (indices into `mobs`):
// `Villager.gossip` (at most once in 1200 ticks for both), then surplus
// food and wanted wares taken out of `a`'s inventory.
    // rust: pub fn meet(
    // rust: mobs: &mut [Mob],
    // rust: a: usize,
    // rust: b: usize,
    // rust: now: i64,
    // rust: max_stack: impl Fn(&str) -> u32,
    // rust: ) -> Meeting {
    // rust: let ready = ext(&mobs[a]).is_none_or(|e| e.can_gossip(now))
    // rust: && ext(&mobs[b]).is_none_or(|e| e.can_gossip(now));
    // rust: if ready {
    // rust: let source = ext(&mobs[b]).map(|e| e.gossips.clone()).unwrap_or_default();
    // rust: let me = &mut mobs[a];
    // rust: let mut random = me.random.clone();
    // rust: let e = ext_mut(me);
    // rust: e.gossips.transfer_from(&source, &mut random, 10);
    // rust: e.last_gossip_time = now;
    // rust: me.random = random;
    // rust: ext_mut(&mut mobs[b]).last_gossip_time = now;
}
    // Surplus food goes to a hungry neighbour (farmers hand it to anyone).
    // rust: let farmer = is_farmer(&mobs[a]);
    // rust: let wants_more = ext(&mobs[b]).is_none_or(Ext::wants_more_food);
    // rust: let excess = ext(&mobs[a]).is_some_and(Ext::has_excess_food);
    // rust: let mut thrown = Vec::new();
    // rust: if excess
    // rust: && (farmer || wants_more)
    // rust: && let Some(s) =
    // rust: ext_mut(&mut mobs[a]).take_half_stack(|s| food_points(&s.item) > 0, &max_stack)
    // rust: {
    // rust: thrown.push(s);
}
    // A farmer's wheat.
    // rust: if farmer
    // rust: && ext(&mobs[a]).is_some_and(|e| e.count_item("minecraft:wheat") > 32)
    // rust: && let Some(s) =
    // rust: ext_mut(&mut mobs[a]).take_half_stack(|s| &*s.item == "minecraft:wheat", &max_stack)
    // rust: {
    // rust: thrown.push(s);
}
    // Wares the neighbour's profession asks for and ours does not.
    // rust: let theirs = requested_items(&mobs[b]);
    // rust: let mine = requested_items(&mobs[a]);
    // rust: let wanted: Vec<&str> = theirs
    // rust: .iter()
    // rust: .copied()
    // rust: .filter(|i| !mine.contains(i))
    // rust: .collect();
    // rust: if !wanted.is_empty()
    // rust: && let Some(s) =
    // rust: ext_mut(&mut mobs[a]).take_half_stack(|s| wanted.contains(&&*s.item), &max_stack)
    // rust: {
    // rust: thrown.push(s);
}
    // rust: Meeting {
    // rust: thrown,
    // rust: from: mobs[a].position,
    // rust: eye: mobs[a].eye_y(),
    // rust: to: mobs[b].position,
    // rust: gossiped: ready,
}
}
// `Villager.spawnGolemIfNeeded` up to the spawn: villager `i` wants a golem
// and so do at least `needed` of the villagers whose boxes meet its own grown
// by 10 blocks. Returns all of those villagers: once the golem stands, they
// remember it ([`super::villager_brain::golem_detected`]).
golem_summoners :: proc(mobs: ^[Mob], i: uint, now: i64, needed: uint) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if !ext(&mobs[i]).is_some_and(|e| e.wants_golem(now)) {
    // rust: return None;
}
    // rust: let area = mobs[i]
    // rust: .bounds()
    // rust: .inflate(horizon_core::geometry::Vec3::new(10.0, 10.0, 10.0));
    // rust: let near: Vec<usize> = mobs
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, m)| {
    // rust: m.species() == Species::Villager && !m.removed && m.bounds().intersects(area)
    // rust: })
    // rust: .map(|(j, _)| j)
    // rust: .collect();
    // rust: let wanting = near
    // rust: .iter()
    // rust: .filter(|&&j| ext(&mobs[j]).is_some_and(|e| e.wants_golem(now)))
    // rust: .take(5)
    // rust: .count();
    // rust: (wanting >= needed).then_some(near)
}
// `SpawnUtil.Strategy.LEGACY_IRON_GOLEM`'s refused floors.
golem_floor_ok :: proc(name: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !matches!(
    // rust: name,
    // rust: "minecraft:cobweb"
    // rust: | "minecraft:cactus"
    // rust: | "minecraft:glass_pane"
    // rust: | "minecraft:conduit"
    // rust: | "minecraft:ice"
    // rust: | "minecraft:tnt"
    // rust: | "minecraft:glowstone"
    // rust: | "minecraft:beacon"
    // rust: | "minecraft:sea_lantern"
    // rust: | "minecraft:frosted_ice"
    // rust: | "minecraft:tinted_glass"
    // rust: | "minecraft:glass"
    // rust: ) && !name.ends_with("_stained_glass_pane")
    // rust: && !name.ends_with("_stained_glass")
    // rust: && !name.ends_with("leaves")
}
// One attempt of `SpawnUtil.trySpawnMob(IRON_GOLEM, ..., 8 across, 6 up and
// down, LEGACY_IRON_GOLEM)`: a column drawn near `start`, searched down from
// 6 above for a solid floor (or powder snow) under air or a liquid block.
// Returns the block the golem would stand in.
    // rust: fn golem_attempt<L: super::spawn_rules::SpawnLevel>(
    // rust: l: &L,
    // rust: start: [i32; 3],
    // rust: random: &mut impl RandomSource,
    // rust: ) -> Option<[i32; 3]> {
    // rust: let dx = random.next_int_bound(17).unwrap_or(8) - 8;
    // rust: let dz = random.next_int_bound(17).unwrap_or(8) - 8;
    // rust: let (x, z) = (start[0] + dx, start[2] + dz);
    // rust: let name = |y: i32| -> &str { &l.facts().get(l.state(x, y, z)).name };
    // rust: let mut y = start[1] + 6;
    // rust: let mut above = l.state(x, y, z);
    // rust: for _ in 0..=12 {
    // rust: y -= 1;
    // rust: let here = l.state(x, y, z);
    // rust: let above_name = &*l.facts().get(above).name;
        // BlockState.liquid(): a water or lava block (not a waterlogged one).
    // rust: let open = l.facts().is_air(above)
    // rust: || above_name == "minecraft:water"
    // rust: || above_name == "minecraft:lava";
    // rust: let solid = l.mob_data().state(here).flags & super::data::SOLID != 0
    // rust: || name(y) == "minecraft:powder_snow";
    // rust: if golem_floor_ok(name(y)) && open && solid {
    // rust: return Some([x, y + 1, z]);
}
    // rust: above = here;
}
    // rust: None
}
// `IronGolem.checkSpawnObstruction`: a floor with a full top face, its feet
// free whatever fluid is there, and the two blocks above free.
    // rust: fn golem_fits<L: super::spawn_rules::SpawnLevel>(l: &L, [x, y, z]: [i32; 3]) -> bool {
//     use super::spawn_rules::is_valid_empty_spawn;
    // entityCanStandOn: Block.isFaceFull(collision shape, UP).
    // rust: let floor = l.mob_data().state(l.state(x, y - 1, z));
    // rust: let stands = floor.flags & super::data::STURDY_TOP != 0 && floor.top >= 1.0;
    // isValidEmptySpawnBlock with Fluids.EMPTY: open water is free too.
    // rust: let feet = is_valid_empty_spawn(Species::IronGolem, l, x, y, z)
    // rust: || &*l.facts().get(l.state(x, y, z)).name == "minecraft:water";
    // rust: stands
    // rust: && feet
    // rust: && is_valid_empty_spawn(Species::IronGolem, l, x, y + 1, z)
    // rust: && is_valid_empty_spawn(Species::IronGolem, l, x, y + 2, z)
}
// `SpawnUtil.trySpawnMob(IRON_GOLEM, MOB_SUMMONED, level, start, 10, 8, 6,
// LEGACY_IRON_GOLEM, false)`: up to ten columns tried. In each spot found
// `create` makes the golem (`EntityType.create`: the yaw drawn here, then its
// `finalizeSpawn` draws, see [`finalize_summoned_golem`]); it is kept only
// when `IronGolem.checkSpawnObstruction` passes, and discarded otherwise.
    // rust: pub fn summon_golem<L: super::spawn_rules::SpawnLevel, R: RandomSource, T>(
    // rust: l: &L,
    // rust: start: [i32; 3],
    // rust: random: &mut R,
    // rust: mut create: impl FnMut(&mut R, horizon_core::geometry::Vec3, f32) -> T,
    // rust: ) -> Option<T> {
    // rust: for _ in 0..10 {
    // rust: let Some([x, y, z]) = golem_attempt(l, start, random) else {
    // rust: continue;
}
        // Mth.wrapDegrees(nextFloat() * 360).
    // rust: let mut yaw = random.next_float() * 360.0;
    // rust: if yaw >= 180.0 {
    // rust: yaw -= 360.0;
}
    // rust: let at =
    // rust: horizon_core::geometry::Vec3::new(f64::from(x) + 0.5, f64::from(y), f64::from(z) + 0.5);
    // rust: let golem = create(random, at, yaw);
    // rust: if golem_fits(l, [x, y, z]) {
    // rust: return Some(golem);
}
}
    // rust: None
}
// `Mob.finalizeSpawn` for a summoned iron golem, from the level's random:
// the follow range spawn bonus and left-handedness.
finalize_summoned_golem :: proc(m: ^Mob, random: ^impl RandomSource) {
}
    // rust: super::finalize::mob_spawn(m, random);
}
// `Villager.canBreed`: enough food, awake and an adult.
can_breed :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.species() == Species::Villager
    // rust: && m.extra.age == 0
    // rust: && !sleeping(m)
    // rust: && ext(m).map_or(0, |e| e.food_level + e.food_in_inventory()) >= 12
}

// The saved fields (`FoodLevel`, `Gossips`, `LastGossipDecay`, `Inventory`,
// `LivingEntity`'s `sleeping_pos` and the sleep and golem memories).
write_nbt :: proc(m: ^Mob, map: ^horizon_world::nbt::Compound) {
}
//     use horizon_world::nbt::Tag;
    // rust: if let Some(p) = sleeping_pos(m) {
    // rust: map.insert("sleeping_pos".into(), Tag::IntArray(p.to_vec()));
    // rust: } else {
        // LivingEntity.addAdditionalSaveData omits an absent modeled position.
    // rust: map.remove(&"sleeping_pos".into());
}
    // rust: let Some(e) = ext(m) else { return };
    // rust: map.insert(
    // rust: "FoodLevel".into(),
    // rust: Tag::Byte(e.food_level.clamp(-128, 127) as i8),
    // rust: );
    // rust: map.insert("Gossips".into(), e.gossips.to_nbt());
    // rust: map.insert("LastGossipDecay".into(), Tag::Long(e.last_gossip_decay));
    // rust: map.insert(
    // rust: "Inventory".into(),
    // rust: Tag::List(e.inventory.iter().map(crate::save::item_to_nbt).collect()),
    // rust: );
}
// The memories of `Brain.memories` the villager keeps besides positions.
write_memories :: proc(m: ^Mob, memories: ^Vec<(^'static str, horizon_world: :nbt::Tag) {
}
//     use horizon_world::nbt::Tag;
    // rust: let Some(e) = ext(m) else { return };
    // rust: if let Some(t) = e.last_slept {
    // rust: memories.push((
    // rust: "minecraft:last_slept",
    // rust: Tag::compound([("value", Tag::Long(t))]),
    // rust: ));
}
}
read_nbt :: proc(m: ^Mob, tag: ^horizon_world::nbt::Tag) {
}
//     use horizon_world::nbt::Tag;
    // rust: let int = |t: Option<&Tag>| match t {
    // rust: Some(Tag::Int(v)) => Some(i64::from(*v)),
    // rust: Some(Tag::Byte(v)) => Some(i64::from(*v)),
    // rust: Some(Tag::Short(v)) => Some(i64::from(*v)),
    // rust: Some(Tag::Long(v)) => Some(*v),
    // rust: _ => None,
}
    // rust: let last_slept = int(tag
    // rust: .get("Brain")
    // rust: .and_then(|b| b.get("memories"))
    // rust: .and_then(|b| b.get("minecraft:last_slept"))
    // rust: .and_then(|j| j.get("value")));
    // rust: let e = ext_mut(m);
    // rust: e.food_level = int(tag.get("FoodLevel")).unwrap_or(0) as i32;
    // rust: e.gossips = tag
    // rust: .get("Gossips")
    // rust: .map(crate::gossip::Gossips::from_nbt)
    // rust: .unwrap_or_default();
    // rust: e.last_gossip_decay = int(tag.get("LastGossipDecay")).unwrap_or(0);
    // rust: e.last_slept = last_slept;
    // LivingEntity.readAdditionalSaveData: asleep in the bed again (the
    // pose; `ai_step` turns it the way the bed faces, or wakes it when the
    // bed is gone, as `baseTick`'s first tick does).
    // rust: e.sleeping_pos = match tag.get("sleeping_pos") {
    // rust: Some(Tag::IntArray(a)) if a.len() == 3 => Some([a[0], a[1], a[2]]),
    // rust: _ => None,
}
    // rust: let asleep = e.sleeping_pos.is_some();
    // rust: if let Some(Tag::List(items)) = tag.get("Inventory") {
    // rust: e.inventory = items
    // rust: .iter()
    // rust: .filter_map(crate::save::item_from_nbt)
    // rust: .take(INVENTORY_SLOTS)
    // rust: .collect();
}
    // rust: if asleep {
    // rust: m.extra.ints[1] = bed_facing_code(None);
}
}

    // rust: mod tests {
//     use super::*;

villager :: proc() -> M {
    // Ported from Horizon
    return {}
}
//         use crate::mobs::{Anim, Brain, Flags, MobType, Part, Species};
//         use std::sync::Arc;
    // rust: let kind = Arc::new(MobType {
    // rust: id: "minecraft:villager".into(),
    // rust: species: Species::Villager,
    // rust: width: 0.6,
    // rust: height: 1.95,
    // rust: eye_height: 1.62,
    // rust: category: "misc".into(),
    // rust: max_health: 20.0,
    // rust: speed: 0.5,
    // rust: flying_speed: 0.02,
    // rust: attack_damage: 0.0,
    // rust: attack_knockback: 0.0,
    // rust: follow_range: 48.0,
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
    // rust: ambient_interval: 80,
    // rust: flags: Flags::default(),
    // rust: model: Arc::new(Part::parse("root", &serde_json::json!({}))),
    // rust: layers: Default::default(),
    // rust: texture: String::new(),
    // rust: brain: Brain::Passive,
    // rust: anim: Anim::Villager,
    // rust: sounds: [""; 3],
    // rust: step_sound: None,
    // rust: food: Arc::default(),
    // rust: tempt: Arc::default(),
    // rust: });
    // rust: Mob::new(1, kind, horizon_core::geometry::Vec3::ZERO, 0.0)
}
waking_faces_the_bed_and_resets_pitch_without_moving_the_chosen_position :: proc() {
}
    // rust: let mut m = villager();
    // rust: m.yaw = -25.0;
    // rust: m.head_pitch = 23.0;
    // rust: let stand = horizon_core::geometry::Vec3::new(3.5, 200.0, 6.5);
    // rust: set_wake_pose(&mut m, [2, 200, 6], stand);
        // Fresh official 26.3 occupied-bed interaction.
    // rust: assert_eq!(m.yaw, 89.99999);
    // rust: assert_eq!(m.head_pitch, 0.0);
    // rust: assert_eq!(m.position, stand);
}
    // A sleeper's box is 0.2 high, but `LivingEntityRenderer` moves it
    // toward the foot of the bed by its standing eye height, so its head
    // lies on the pillow.
a_sleeper_lies_by_its_standing_eye_height :: proc() {
}
    // rust: let mut m = villager();
    // rust: m.extra.ints[1] = bed_facing_code(Some("east"));
    // rust: assert!(sleeping(&m));
    // rust: assert_eq!(m.eye_height(), f64::from(0.2_f32));
    // rust: assert_eq!(m.awake_dims().2, f64::from(1.62_f32));
}
    // `LivingEntity.add/readAdditionalSaveData`: a sleeper is saved with
    // its bed (`sleeping_pos`) and loads asleep in it.
a_sleeper_is_saved_asleep_in_its_bed :: proc() {
}
    // rust: let mut m = villager();
    // rust: m.extra.ints[1] = bed_facing_code(Some("north"));
    // rust: ext_mut(&mut m).sleeping_pos = Some([3, 64, -7]);
    // rust: let mut map = horizon_world::nbt::Compound::new();
    // rust: write_nbt(&m, &mut map);
    // rust: let mut loaded = villager();
    // rust: read_nbt(&mut loaded, &horizon_world::nbt::Tag::Compound(map));
    // rust: assert!(sleeping(&loaded));
    // rust: assert_eq!(sleeping_pos(&loaded), Some([3, 64, -7]));
    // rust: let mut awake = villager();
    // rust: let mut map = horizon_world::nbt::Compound::new();
    // rust: write_nbt(&awake, &mut map);
    // rust: assert!(!map.contains_key(&"sleeping_pos".into()));
    // rust: read_nbt(&mut awake, &horizon_world::nbt::Tag::Compound(map));
    // rust: assert!(!sleeping(&awake));
}
saved_sleeping_position_follows_live_state_over_stale_input :: proc() {
}
//         use horizon_world::nbt::Tag;
    // rust: for asleep in [false, true] {
    // rust: let mut m = villager();
    // rust: if asleep {
    // rust: m.extra.ints[1] = bed_facing_code(Some("north"));
    // rust: ext_mut(&mut m).sleeping_pos = Some([3, 64, -7]);
}
    // rust: let expected = asleep.then_some(Tag::IntArray(vec![3, 64, -7]));
    // rust: for stale in [false, true] {
    // rust: let mut map = horizon_world::nbt::Compound::new();
    // rust: map.insert("h232_control".into(), Tag::Int(42));
    // rust: if stale {
    // rust: map.insert("sleeping_pos".into(), Tag::IntArray(vec![9, 90, 9]));
}
    // rust: write_nbt(&m, &mut map);
    // rust: assert_eq!(map.get(&"sleeping_pos".into()), expected.as_ref());
    // rust: assert_eq!(map.get(&"h232_control".into()), Some(&Tag::Int(42)));
}
    // rust: let saved = crate::entity_nbt::mob_to_nbt(&m, [0; 4], None, None);
    // rust: assert_eq!(saved.get("sleeping_pos"), expected.as_ref());
}
}
    // `Villager.setUnhappy` -> `Mob.makeSound(VILLAGER_NO)` plays with
    // `LivingEntity.getVoicePitch`: a baby is pitched about 1.5, an adult 1.0.
the_unhappy_sound_uses_the_voice_pitch :: proc() {
}
    // rust: let sound_pitch = |age: i32| {
    // rust: let mut m = villager();
    // rust: m.extra.age = age;
    // rust: let mut events = Vec::new();
    // rust: set_unhappy(&mut m, &mut events);
    // rust: match events[0] {
    // rust: MobEvent::Sound(_, _, _, pitch) => pitch,
    // rust: _ => panic!("expected a sound"),
}
}
    // rust: assert!((0.8..=1.2).contains(&sound_pitch(0)));
    // rust: assert!((1.3..=1.7).contains(&sound_pitch(-24000)));
}
a_new_profession_rolls_new_offers :: proc() {
}
    // rust: let mut m = villager();
    // rust: set_profession(&mut m, 1);
        // Offers made for the first profession.
    // rust: m.extra.trade.get_or_insert_default().unset = false;
        // The same profession keeps them.
    // rust: set_profession(&mut m, 1);
    // rust: assert!(!m.extra.trade.as_ref().unwrap().unset);
        // A new one forgets them (offers = null), so the next getOffers
        // (ensure_offers) rolls the new profession's trades.
    // rust: set_profession(&mut m, 2);
    // rust: let t = m.extra.trade.as_ref().unwrap();
    // rust: assert!(t.offers.is_empty());
    // rust: assert!(t.unset);
    // rust: assert_eq!(m.extra.variant2, 2);
}
    // The reported sequence: a villager works at a bench, the bench is
    // destroyed (its job site is gone, so `ResetProfession` makes it
    // unemployed) and it takes another bench's job. The new profession's
    // trades are offered again.
    //
    // `Villager.setVillagerData` drops the offers (`offers = null`) when the
    // profession changes, so `AbstractVillager.getOffers` rolls the new
    // profession's trade set the next time the offers are asked for. A
    // villager that keeps its old offers marked as made never trades again:
    // it shakes its head instead of opening the trading menu.
a_villager_that_loses_its_job_site_offers_its_new_profession_trades :: proc() {
}
    // rust: let mut m = villager();
        // The composter's job: the villager is a farmer.
    // rust: set_profession(&mut m, 5);
    // rust: assert_eq!(m.extra.variant2, 5);
        // Its trades were made, so the offers are there.
    // rust: let trade = m.extra.trade.get_or_insert_default();
    // rust: trade.unset = false;
    // rust: trade.offers = vec![crate::merchant::MerchantOffer {
    // rust: base_cost_a: crate::merchant::ItemCost {
    // rust: stack: ItemStack::new("minecraft:wheat", 20),
    // rust: },
    // rust: cost_b: None,
    // rust: result: ItemStack::new("minecraft:emerald", 1),
    // rust: uses: 0,
    // rust: max_uses: 16,
    // rust: reward_exp: true,
    // rust: special_price_diff: 0,
    // rust: demand: 0,
    // rust: price_multiplier: 0.0,
    // rust: xp: 1,
    // rust: }];
        // The work bench is destroyed: the job site is gone, so the villager
        // is unemployed and its offers are dropped (`offers = null`).
    // rust: set_profession(&mut m, NONE);
    // rust: let t = m.extra.trade.as_ref().unwrap();
    // rust: assert!(t.offers.is_empty());
    // rust: assert!(t.unset);
        // It takes the smithing table's job. The new profession's trades are
        // rolled by the next `getOffers` (ensure_offers).
    // rust: set_profession(&mut m, 13);
    // rust: let t = m.extra.trade.as_ref().unwrap();
    // rust: assert!(t.offers.is_empty());
    // rust: assert!(t.unset);
    // rust: assert_eq!(m.extra.variant2, 13);
}

stack :: proc(item: string, count: u32) -> I {
    // Ported from Horizon
    return {}
}
    // rust: ItemStack::new(item, count)
}
eating_fills_the_food_level_then_digests :: proc() {
}
    // rust: let mut e = Ext {
    // rust: inventory: vec![stack("minecraft:bread", 3), stack("minecraft:carrot", 5)],
    // rust: ..Default::default()
}
    // rust: assert_eq!(e.food_in_inventory(), 17);
        // Hungry below 12: three breads fill it exactly, then 12 digest away.
    // rust: e.eat_and_digest();
    // rust: assert_eq!(e.food_level, 0);
    // rust: assert_eq!(e.inventory.len(), 1);
    // rust: assert_eq!(e.inventory[0].count, 5);
        // Five carrots are not enough to be full again, and are all eaten.
    // rust: e.eat_and_digest();
    // rust: assert_eq!(e.food_level, 5 - 12);
    // rust: assert!(e.inventory.is_empty());
}
willingness_to_breed_needs_twelve_food_points :: proc() {
}
    // rust: let mut e = Ext::default();
    // rust: assert!(e.wants_more_food() && !e.has_excess_food());
    // rust: e.inventory.push(stack("minecraft:bread", 6));
    // rust: assert!(e.has_excess_food() && !e.wants_more_food());
    // rust: e.food_level = -5;
    // rust: assert_eq!(e.food_level + e.food_in_inventory(), 19);
}
the_inventory_has_eight_stacking_slots :: proc() {
}
    // rust: let mut e = Ext::default();
    // rust: assert!(e.add_item(stack("minecraft:bread", 100), 64).is_none());
    // rust: assert_eq!(e.inventory.len(), 2);
    // rust: assert_eq!(e.inventory[0].count, 64);
    // rust: for i in 0..6 {
    // rust: assert!(
    // rust: e.add_item(stack(&format!("minecraft:item_{i}"), 1), 64)
    // rust: .is_none()
    // rust: );
}
    // rust: assert_eq!(e.inventory.len(), 8);
        // Full: another kind is refused, the same kind tops up the stack.
    // rust: assert!(!e.can_add(&stack("minecraft:stick", 1), 64));
    // rust: let left = e.add_item(stack("minecraft:bread", 40), 64).unwrap();
    // rust: assert_eq!(left.count, 40 - 28);
}
half_stacks_are_thrown :: proc() {
}
    // rust: let mut e = Ext {
    // rust: inventory: vec![
    // rust: stack("minecraft:bread", 10),
    // rust: stack("minecraft:wheat", 50),
    // rust: stack("minecraft:wheat", 20),
    // rust: ],
    // rust: ..Default::default()
}
    // rust: let max = |_: &str| 64;
        // Bread is under half a stack and under 24: nothing.
    // rust: assert!(
    // rust: e.take_half_stack(|s| &*s.item == "minecraft:bread", max)
    // rust: .is_none()
    // rust: );
        // 50 wheat is over half a stack: 25 go.
    // rust: let t = e
    // rust: .take_half_stack(|s| &*s.item == "minecraft:wheat", max)
    // rust: .unwrap();
    // rust: assert_eq!(t.count, 25);
    // rust: assert_eq!(e.count_item("minecraft:wheat"), 25 + 20);
}
golems_need_sleep_and_no_golem_nearby :: proc() {
}
    // rust: let mut e = Ext::default();
    // rust: assert!(!e.wants_golem(100));
    // rust: e.last_slept = Some(0);
    // rust: assert!(e.wants_golem(23_999));
    // rust: assert!(!e.wants_golem(24_000));
    // rust: e.last_slept = Some(1000);
    // rust: e.golem_until = 2000 + 599;
    // rust: assert!(!e.wants_golem(2500));
    // rust: assert!(e.wants_golem(2700));
}
gossip_decays_once_a_day_and_heard_gossip_waits :: proc() {
}
    // rust: let player = [1, 2, 3, 4];
    // rust: let mut e = Ext::default();
    // rust: e.gossips
    // rust: .add(player, crate::gossip::GossipType::MajorNegative, 25);
    // rust: e.maybe_decay(100);
    // rust: assert_eq!(e.last_gossip_decay, 100);
    // rust: e.maybe_decay(24_099);
    // rust: assert_eq!(
    // rust: e.gossips
    // rust: .get(player, crate::gossip::GossipType::MajorNegative),
    // rust: 25
    // rust: );
    // rust: e.maybe_decay(24_100);
    // rust: assert_eq!(
    // rust: e.gossips
    // rust: .get(player, crate::gossip::GossipType::MajorNegative),
    // rust: 15
    // rust: );
    // rust: e.last_gossip_time = 5000;
    // rust: assert!(!e.can_gossip(5100));
    // rust: assert!(e.can_gossip(6200));
    // rust: assert!(e.can_gossip(4000));
}
villager_food_values :: proc() {
}
    // rust: assert_eq!(food_points("minecraft:bread"), 4);
    // rust: assert_eq!(food_points("minecraft:beetroot"), 1);
    // rust: assert_eq!(food_points("minecraft:apple"), 0);
}
}
