//! Transpiled from Horizon Rust crate
//! Module: horizon-client_drops
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! What a dying mob leaves behind: `LivingEntity.die`'s drop step. The
//! killer's `killedEntity` hook (a charged creeper's head drop), then
//! `dropAllDeathLoot`: the entity loot table (drawn from the world's random
//! sequence), `Mob.dropCustomDeathLoot` (equipment by drop chance, with the
//! entity random), the species' extra drops (an enderman's carried block) and
//! the experience orbs.
// use super::{Mob, Species, equine, gear, raider, render::DYE_NAMES, species};
// use crate::random_sequences::RandomSequences;
// use horizon_core::random::{LegacyRandom, RandomSource};
// use horizon_world::{
    // rust: loot::{EntityLootParams, LootDamage, LootData, LootEntity, LootStack},
    // rust: registry::BlockStateId,
}

/// `DropChances.DEFAULT_EQUIPMENT_DROP_CHANCE`.
pub const DEFAULT_DROP_CHANCE: f32 = 0.085;
/// `EquipmentSlot.VALUES`.
    // rust: pub use horizon_world::loot::EQUIPMENT_SLOTS as SLOTS;

/// One thing a death leaves in the world, in spawn order.
pub const Drop = enum {
    Item(LootStack),
    /// The whole stack a mob kept in an equipment slot (damage, name,
    /// components), dropped as it is.
    Stack(crate::items::ItemStack),
    /// `Enderman.dropCustomDeathLoot`: the carried block's own drops, rolled
    /// with `enderman::carried_block_tool` (`enderman::carried_block_drops`).
    CarriedBlock(BlockStateId),
    /// An experience orb of this value.
    Orb(i32),
};

/// How the mob died.
pub const Death = struct {
    loot: *'a LootData,
    /// The killing `DamageSource`.
    damage: ?LootDamage,
    /// The player who last hurt the mob, when `lastHurtByPlayerMemoryTime > 0`.
    player: ?LootEntity,
    /// That player's luck.
    luck: f32,
    /// The entity the mob rides.
    vehicle: ?LootEntity,
    /// The `doMobLoot` game rule.
    mob_drops: bool,
    world_seed: i64,
};

/// `instanceof Monster` (Monster.shouldDropLoot/shouldDropExperience).
pub fn is_monster(s: Species) b {
    // Implementation ported from Horizon
    return undefined;
}
//     use Species as S;
    // rust: matches!(
    // rust: s,
    // rust: S::Blaze
    // rust: | S::Bogged
    // rust: | S::Breeze
    // rust: | S::CaveSpider
    // rust: | S::Creaking
    // rust: | S::Creeper
    // rust: | S::Drowned
    // rust: | S::ElderGuardian
    // rust: | S::Enderman
    // rust: | S::Endermite
    // rust: | S::Evoker
    // rust: | S::Giant
    // rust: | S::Guardian
    // rust: | S::Husk
    // rust: | S::Illusioner
    // rust: | S::Parched
    // rust: | S::Piglin
    // rust: | S::PiglinBrute
    // rust: | S::Pillager
    // rust: | S::Ravager
    // rust: | S::Silverfish
    // rust: | S::Skeleton
    // rust: | S::Spider
    // rust: | S::Stray
    // rust: | S::Vex
    // rust: | S::Vindicator
    // rust: | S::Warden
    // rust: | S::Witch
    // rust: | S::Wither
    // rust: | S::WitherSkeleton
    // rust: | S::Zoglin
    // rust: | S::Zombie
    // rust: | S::ZombieVillager
    // rust: | S::ZombifiedPiglin
    // rust: )
}
/// `Mob.xpReward` as the constructors set it.
pub fn xp_reward(m: *Mob) i {
    // Implementation ported from Horizon
    return undefined;
}
//     use Species as S;
    // rust: match m.species() {
    // rust: S::Blaze | S::Breeze | S::Guardian | S::ElderGuardian | S::Evoker => 10,
    // rust: S::Vex | S::Endermite => 3,
    // rust: S::PiglinBrute | S::Ravager => 20,
    // rust: S::Wither => 50,
    // rust: S::Creaking => 0,
        // Hoglin.setBaby.
    // rust: S::Hoglin if m.is_baby() => 3,
    // rust: S::Ghast | S::Hoglin | S::Phantom | S::Shulker => 5,
        // Slime.setSize / MagmaCube.setSize (unsized cubes keep 0).
    // rust: S::Slime | S::MagmaCube => m.extra.size.max(0),
    // rust: s if is_monster(s) => 5,
    // rust: _ => 0,
}
}
/// The mobs that extend `Animal`.
pub fn is_animal(s: Species) b {
    // Implementation ported from Horizon
    return undefined;
}
//     use Species as S;
    // rust: matches!(
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
    // rust: | S::HappyGhast
    // rust: | S::Goat
    // rust: | S::Hoglin
    // rust: | S::Horse
    // rust: | S::Llama
    // rust: | S::Mooshroom
    // rust: | S::Mule
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
    // rust: )
}
/// AgeableWaterCreature and WaterAnimal.
pub fn is_water_creature(s: Species) b {
    // Implementation ported from Horizon
    return undefined;
}
//     use Species as S;
    // rust: matches!(
    // rust: s,
    // rust: S::Dolphin
    // rust: | S::GlowSquid
    // rust: | S::Squid
    // rust: | S::Cod
    // rust: | S::Salmon
    // rust: | S::Pufferfish
    // rust: | S::TropicalFish
    // rust: | S::Tadpole
    // rust: )
}
pub fn zombie_family(s: Species) b {
    // Implementation ported from Horizon
    return undefined;
}
//     use Species as S;
    // rust: matches!(
    // rust: s,
    // rust: S::Zombie | S::Husk | S::Drowned | S::ZombieVillager | S::ZombifiedPiglin
    // rust: )
}
pub fn is_raider(s: Species) b {
    // Implementation ported from Horizon
    return undefined;
}
//     use Species as S;
    // rust: matches!(
    // rust: s,
    // rust: S::Pillager | S::Vindicator | S::Evoker | S::Illusioner | S::Witch | S::Ravager
    // rust: )
}
/// Whether `setBaby(true)` makes the species a baby (AgeableMob and the
/// zombies, minus the species that are never babies).
pub fn can_be_baby(s: Species) b {
    // Implementation ported from Horizon
    return undefined;
}
//     use Species as S;
    // rust: matches!(
    // rust: s,
    // rust: S::Armadillo
    // rust: | S::Axolotl
    // rust: | S::Bee
    // rust: | S::Camel
    // rust: | S::Cat
    // rust: | S::Chicken
    // rust: | S::Cow
    // rust: | S::Dolphin
    // rust: | S::Donkey
    // rust: | S::Drowned
    // rust: | S::Fox
    // rust: | S::HappyGhast
    // rust: | S::GlowSquid
    // rust: | S::Goat
    // rust: | S::Hoglin
    // rust: | S::Horse
    // rust: | S::Husk
    // rust: | S::Llama
    // rust: | S::Mooshroom
    // rust: | S::Mule
    // rust: | S::Nautilus
    // rust: | S::Ocelot
    // rust: | S::Panda
    // rust: | S::Pig
    // rust: | S::Piglin
    // rust: | S::PolarBear
    // rust: | S::Rabbit
    // rust: | S::Sheep
    // rust: | S::SkeletonHorse
    // rust: | S::Sniffer
    // rust: | S::Squid
    // rust: | S::Strider
    // rust: | S::SulfurCube
    // rust: | S::TraderLlama
    // rust: | S::Turtle
    // rust: | S::Villager
    // rust: | S::WanderingTrader
    // rust: | S::Wolf
    // rust: | S::Zoglin
    // rust: | S::Zombie
    // rust: | S::ZombieHorse
    // rust: | S::ZombieVillager
    // rust: | S::ZombifiedPiglin
    // rust: )
}
/// The species whose body item Horizon draws and handles as armour (and whose
/// sun-protection slot is the body): the equines (a horse's armour, a llama's
/// carpet, a camel's harness) and the wolf, happy ghast, nautilus and sulfur cube.
pub fn body_slot_species(s: Species) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: species::body_slot(s) || equine::is_equine(s)
}

/// The item a mob has in an `EquipmentSlot` (by name), with its enchantments.
pub fn slot_item(m: *Mob, slot: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (item, index) = match slot {
    // rust: "mainhand" => (m.extra.main_hand.as_deref(), Some(gear::MAIN)),
    // rust: "offhand" => (m.extra.off_hand.as_deref(), Some(gear::OFF)),
    // rust: "head" => (m.extra.head.as_deref(), Some(gear::HEAD)),
    // rust: "chest" => (m.extra.chest.as_deref(), Some(gear::CHEST)),
    // rust: "legs" => (m.extra.legs.as_deref(), Some(gear::LEGS)),
    // rust: "feet" => (m.extra.feet.as_deref(), Some(gear::FEET)),
    // rust: "body" => (m.extra.body.as_deref(), None),
    // rust: "saddle" => {
    // rust: let saddle = m.saddle_item()?;
    // rust: let mut stack = loot_stack(&saddle.item, 1);
    // rust: stack.damage = saddle.damage as i32;
    // rust: for (e, l) in saddle.enchantments() {
    // rust: stack.enchantments.push((e.to_string(), *l as i32));
}
    // rust: return Some(stack);
}
    // rust: _ => (None, None),
}
    // A panda keeps the whole stack it picked up in its mouth.
    // rust: let count = if slot == "mainhand" && m.species() == Species::Panda {
    // rust: super::panda::held_count(m)
    // rust: } else {
    // rust: 1
}
    // rust: let mut stack = loot_stack(item?, count as i32);
    // rust: if slot == "body" && m.species() == Species::Wolf {
    // rust: stack.damage = m.extra.body_damage;
}
    // rust: if let Some(full) = stored_slot_stack(m, slot) {
    // rust: stack.damage = full.damage as i32;
    // rust: if m.species() != Species::Panda {
    // rust: stack.count = full.count as i32;
}
}
    // rust: if let (Some(index), Some(g)) = (index, gear::gear(m)) {
    // rust: for (e, l) in &g.slots[index] {
    // rust: stack.enchantments.push((e.to_string(), *l as i32));
}
    // rust: if let Some((material, pattern)) = &g.trims[index] {
    // rust: let trim = serde_json::json!({ "material": &**material, "pattern": &**pattern });
    // rust: stack.components.push(("minecraft:trim".to_owned(), trim));
}
}
    // rust: Some(stack)
}
/// The `finalize` slot of a drop slot's name, for the slots a stack is kept in.
pub fn slot_index(slot: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
//     use super::finalize as f;
    // rust: Some(match slot {
    // rust: "mainhand" => f::MAINHAND,
    // rust: "offhand" => f::OFFHAND,
    // rust: "head" => f::HEAD,
    // rust: "chest" => f::CHEST,
    // rust: "legs" => f::LEGS,
    // rust: "feet" => f::FEET,
    // rust: _ => return None,
    // rust: })
}
/// The whole stack the mob kept in `slot` (by name), when it kept one.
pub fn stored_slot_stack(m: *Mob, slot: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: super::finalize::stored_stack(m, slot_index(slot)?)
}
/// The drop of what the mob has in `slot`, given its `stack` after the drop
/// rolls: the whole stack the mob kept (with the rolled damage), else the loot stack.
pub fn slot_drop(m: *Mob, slot: []const u8, stack: LootStack) D {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match stored_slot_stack(m, slot).filter(|_| m.species() != Species::Panda) {
    // rust: Some(mut full) => {
    // rust: full.damage = stack.damage.max(0) as u32;
    // rust: Drop::Stack(full)
}
    // rust: None => Drop::Item(stack),
}
}
/// `setItemSlot(slot, EMPTY)`.
pub fn clear_slot(m: *mut Mob, slot: []const u8) void {
}
    // rust: let index = match slot {
    // rust: "mainhand" => {
    // rust: m.extra.set_main_hand(None);
    // rust: gear::MAIN
}
    // rust: "offhand" => {
    // rust: m.extra.off_hand = None;
    // rust: gear::OFF
}
    // rust: "head" => {
    // rust: m.extra.head = None;
    // rust: gear::HEAD
}
    // rust: "chest" => {
    // rust: m.extra.chest = None;
    // rust: gear::CHEST
}
    // rust: "legs" => {
    // rust: m.extra.legs = None;
    // rust: gear::LEGS
}
    // rust: "feet" => {
    // rust: m.extra.feet = None;
    // rust: gear::FEET
}
    // rust: "body" => {
    // rust: m.extra.body = None;
    // rust: m.extra.body_damage = 0;
    // rust: m.extra.body_extra = None;
    // rust: return;
}
    // rust: "saddle" => {
    // rust: m.set_saddle(None);
    // rust: return;
}
    // rust: _ => return,
}
    // rust: if m.extra.gear.is_some() {
    // rust: gear::set(m, index, Vec::new());
}
}
pub fn loot_stack(item: []const u8, count: i32) L {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: LootStack {
    // rust: item: item.to_owned(),
    // rust: count,
    // rust: damage: 0,
    // rust: enchantments: Vec::new(),
    // rust: potion: None,
    // rust: map: false,
    // rust: exploration: None,
    // rust: ominous_amplifier: None,
    // rust: stew_effects: Vec::new(),
    // rust: names: Vec::new(),
    // rust: components: Vec::new(),
}
}
/// `Mob.dropChances.byEquipment(slot)`: the recorded chance, or the one the
/// game's spawn and equip paths give (saddles and body armour are put on by
/// `Equippable` and always drop; a captain's banner always drops; a vex
/// never drops its sword).
pub fn drop_chance(m: *Mob, slot: []const u8) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let index = SLOTS.iter().position(|s| *s == slot).unwrap_or(0);
    // rust: if let Some(chances) = &m.extra.drop_chances {
    // rust: return chances[index];
}
    // rust: match slot {
        // A saddle or a body-slot species' worn armour (put on by `Equippable`)
        // always drops; a body item elsewhere came from a command or a save.
    // rust: "saddle" => 2.0,
    // rust: "body" if body_slot_species(m.species()) => 2.0,
    // rust: "head" if is_raider(m.species()) && m.extra.head.as_deref() == Some(raider::BANNER) => 2.0,
    // rust: "mainhand" if m.species() == Species::Vex => 0.0,
    // rust: _ => DEFAULT_DROP_CHANCE,
}
}
/// The facts loot predicates read about a mob.
pub fn loot_entity(m: *Mob, vehicle: ?LootEntity) L {
    // Implementation ported from Horizon
    return undefined;
}
//     use Species as S;
    // rust: let s = m.species();
    // rust: let mut e = LootEntity::new(&m.kind.id);
    // rust: e.on_fire = m.fire_ticks > 0 && !m.kind.flags.fire_immune;
    // rust: e.baby = m.is_baby();
    // rust: e.vehicle = vehicle.map(Box::new);
    // rust: if matches!(s, S::Slime | S::MagmaCube | S::SulfurCube) {
        // An unsized cube has the synced default size 1.
    // rust: e.cube_size = Some(m.extra.size.max(1));
}
    // rust: if s == S::Sheep {
    // rust: e.sheep = Some((
    // rust: DYE_NAMES[m.extra.color as usize & 15].to_owned(),
    // rust: m.extra.sheared,
    // rust: ));
}
    // rust: if is_raider(s) {
    // rust: e.captain = Some(raider::is_captain(m));
}
    // rust: if s == S::Frog {
    // rust: e.frog_variant = Some(
    // rust: ["minecraft:temperate", "minecraft:warm", "minecraft:cold"]
    // rust: [usize::from(m.extra.variant).min(2)]
    // rust: .to_owned(),
    // rust: );
}
    // rust: if s == S::Chicken {
    // rust: e.chicken_variant = super::finalize::variant_component(m).map(|(_, id)| id);
}
    // rust: e.powered = s == S::Creeper && m.extra.charged;
    // rust: e.equipment = SLOTS
    // rust: .iter()
    // rust: .filter_map(|slot| slot_item(m, slot).map(|i| (slot.to_string(), i)))
    // rust: .collect();
    // rust: e
}
/// `ExperienceOrb.getExperienceValue`.
pub fn orb_value(amount: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: for v in [2477, 1237, 617, 307, 149, 73, 37, 17, 7, 3] {
    // rust: if amount >= v {
    // rust: return v;
}
}
    // rust: 1
}

/// What a mob clears on itself in `LivingEntity.die`, before any loot is
/// rolled: `Wolf.die` drops the wet flag and the shake animation, so a wolf
/// killed mid-shake does not shake on the ground.
pub fn death_state(m: *mut Mob) void {
}
    // rust: if m.species() == Species::Wolf {
    // rust: super::tame::die(m);
}
}
/// `LivingEntity.die`'s drops for `m` (equipment it loses is removed from
/// it). Returns the drops in spawn order and whether a charged creeper
/// killer dropped a head (`Creeper.droppedSkulls`).
/// `level_random` is the level's random: what a table rolls with when it has
/// neither a seed nor a random sequence (`LootContext.Builder.create`).
    // rust: pub fn die(
    // rust: m: &mut Mob,
    // rust: d: &Death,
    // rust: sequences: &mut RandomSequences,
    // rust: level_random: &mut LegacyRandom,
    // rust: ) -> (Vec<Drop>, bool) {
    // rust: let mut out = Vec::new();
    // rust: death_state(m);
    // rust: let this = loot_entity(m, d.vehicle.clone());
    // rust: let mut skulls = false;
    // Creeper.killedEntity: a charged creeper's victim drops its head.
    // rust: if let Some(source) = d.damage.as_ref().and_then(|x| x.source.as_ref())
    // rust: && source.kind == "minecraft:creeper"
    // rust: && source.powered
    // rust: && d.mob_drops
    // rust: {
    // rust: let params = EntityLootParams {
    // rust: this: this.clone(),
    // rust: damage: d.damage.clone(),
    // rust: player: None,
    // rust: luck: 0.0,
}
    // rust: let items = roll(
    // rust: d,
    // rust: "minecraft:charged_creeper/root",
    // rust: &params,
    // rust: sequences,
    // rust: 0,
    // rust: level_random,
    // rust: );
    // rust: skulls = items.iter().any(|i| !i.is_empty());
    // rust: out.extend(items.into_iter().filter(|i| !i.is_empty()).map(Drop::Item));
}
    // rust: let killed_by_player = d.player.is_some();
    // rust: let s = m.species();
    // Fox.dropAllDeathLoot: whatever it holds in its mouth comes out first.
    // rust: if s == Species::Fox
    // rust: && let Some(stack) = slot_item(m, "mainhand")
    // rust: {
    // rust: out.push(slot_drop(m, "mainhand", stack));
    // rust: clear_slot(m, "mainhand");
}
    // rust: if let Some(table) = death_loot_table(m, d.mob_drops) {
    // rust: let params = EntityLootParams {
    // rust: this: this.clone(),
    // rust: damage: d.damage.clone(),
    // rust: player: d.player.clone().filter(|_| killed_by_player),
    // rust: luck: if killed_by_player { d.luck } else { 0.0 },
}
    // rust: let items = roll(
    // rust: d,
    // rust: &table,
    // rust: &params,
    // rust: sequences,
    // rust: m.extra.death_loot_seed,
    // rust: level_random,
    // rust: );
    // rust: out.extend(items.into_iter().filter(|i| !i.is_empty()).map(Drop::Item));
        // Mob.dropCustomDeathLoot.
    // rust: let damage_params = EntityLootParams {
    // rust: this: this.clone(),
    // rust: damage: d.damage.clone(),
    // rust: player: None,
    // rust: luck: 0.0,
}
    // rust: let living_attacker = d
    // rust: .damage
    // rust: .as_ref()
    // rust: .and_then(|x| x.source.as_ref())
    // rust: .is_some_and(|a| a.living);
    // rust: for slot in SLOTS {
    // rust: let stack = slot_item(m, slot);
    // rust: let mut chance = drop_chance(m, slot);
    // rust: if chance == 0.0 {
    // rust: continue;
}
    // rust: let preserve = chance > 1.0;
    // rust: if living_attacker {
    // rust: chance = d.loot.equipment_drop_chance(&damage_params, chance);
}
    // rust: let Some(mut stack) = stack else { continue };
    // rust: if d.loot.prevents_equipment_drop(&stack) || !(killed_by_player || preserve) {
    // rust: continue;
}
    // rust: if m.random.next_float() >= chance {
    // rust: continue;
}
    // rust: let max = d.loot.max_damage(&stack.item);
    // rust: if !preserve && max > 0 {
    // rust: let inner = m.random.next_int_bound((max - 3).max(1)).unwrap_or(0);
    // rust: stack.damage = max - m.random.next_int_bound(1 + inner).unwrap_or(0);
}
    // rust: out.push(slot_drop(m, slot, stack));
    // rust: clear_slot(m, slot);
}
        // Enderman.dropCustomDeathLoot: after Monster's, the carried block.
    // rust: if s == Species::Enderman
    // rust: && let Some(state) = m.extra.carried
    // rust: {
    // rust: out.push(Drop::CarriedBlock(state));
}
        // WitherBoss.dropCustomDeathLoot.
    // rust: if s == Species::Wither {
    // rust: out.push(Drop::Item(loot_stack("minecraft:nether_star", 1)));
}
}
    // Allay.dropEquipment: its inventory, then the main-hand item unless it
    // prevents equipment drops.
    // rust: if s == Species::Allay {
    // rust: if let Some(stack) = m.extra.allay.as_mut().and_then(|st| st.inventory.take()) {
    // rust: out.push(Drop::Stack(stack));
}
    // rust: if let Some(stack) = slot_item(m, "mainhand")
    // rust: && !d.loot.prevents_equipment_drop(&stack)
    // rust: {
    // rust: out.push(slot_drop(m, "mainhand", stack));
    // rust: clear_slot(m, "mainhand");
}
}
    // Piglin.dropCustomDeathLoot: everything in its inventory.
    // rust: if s == Species::Piglin {
    // rust: for stack in m.extra.inventory.drain(..) {
    // rust: let mut item = loot_stack(&stack.item, stack.count as i32);
    // rust: item.damage = stack.damage as i32;
    // rust: out.push(Drop::Item(item));
}
}
    // dropEquipment: AbstractHorse's inventory, then a chested horse's chest.
    // rust: if equine::is_equine(s) {
    // rust: for stack in m.extra.items.iter().flatten() {
    // rust: if stack.count > 0 {
    // rust: let mut item = loot_stack(&stack.item, stack.count as i32);
    // rust: item.damage = stack.damage as i32;
    // rust: out.push(Drop::Item(item));
}
}
    // rust: if m.extra.chested {
    // rust: out.push(Drop::Item(loot_stack("minecraft:chest", 1)));
    // rust: m.extra.chested = false;
}
}
    // dropExperience.
    // rust: if killed_by_player && drops_experience(m) && d.mob_drops {
    // rust: let mut amount = base_experience(m);
    // rust: while amount > 0 {
    // rust: let value = orb_value(amount);
    // rust: amount -= value;
    // rust: out.push(Drop::Orb(value));
}
}
    // rust: (out, skulls)
}
/// The loot table `die` rolls for `m` (`LivingEntity.getLootTable`), when it
/// rolls one: none with `doMobLoot` off, nor for a baby that isn't a monster.
pub fn death_loot_table(m: *Mob, mob_drops: bool) O {
    // Implementation ported from Horizon
    return undefined;
}
    // Mob.getLootTable: the mob's own `DeathLootTable`, else its type's
    // (`EntityType.getDefaultLootTable`: `entities/` before the type's path,
    // in its namespace, so a content mod's type rolls its own table).
    // rust: (mob_drops && (is_monster(m.species()) || !m.is_baby())).then(|| {
    // rust: m.extra.death_loot_table.clone().unwrap_or_else(|| {
    // rust: let id = m.kind.id.as_str();
    // rust: let (namespace, path) = id.split_once(':').unwrap_or(("minecraft", id));
    // rust: format!("{namespace}:entities/{path}")
    // rust: })
    // rust: })
}
/// `LootTable.getRandomItems(params, seed, ...)`: a seed's own random, else
/// the table's random sequence, else the level's random.
    // rust: fn roll(
    // rust: d: &Death,
    // rust: table: &str,
    // rust: params: &EntityLootParams,
    // rust: sequences: &mut RandomSequences,
    // rust: seed: i64,
    // rust: level_random: &mut LegacyRandom,
    // rust: ) -> Vec<LootStack> {
    // rust: if seed != 0 {
    // rust: return d
    // rust: .loot
    // rust: .roll_entity(table, &mut LegacyRandom::new(seed), params);
}
    // rust: match d.loot.random_sequence(table) {
    // rust: Some(id) => {
    // rust: let random = sequences.get(id, d.world_seed);
    // rust: d.loot.roll_entity(table, random, params)
}
    // rust: None => d.loot.roll_entity(table, level_random, params),
}
}
/// `LivingEntity.shouldDropExperience`: babies drop none, except monsters and
/// hoglins; tadpoles never do.
pub fn drops_experience(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match m.species() {
    // rust: Species::Tadpole => false,
    // rust: Species::Hoglin => true,
    // rust: s if is_monster(s) => true,
    // rust: _ => !m.is_baby(),
}
}
/// `getBaseExperienceReward` (no vanilla enchantment changes mob experience).
pub fn base_experience(m: *mut Mob) i {
    // Implementation ported from Horizon
    return undefined;
}
//     use Species as S;
    // rust: let s = m.species();
    // rust: match s {
        // Chicken.getBaseExperienceReward.
    // rust: S::Chicken if m.extra.jockey => 10,
    // rust: S::SulfurCube if m.is_baby() => 0,
    // rust: S::SulfurCube => 1 + m.random.next_int_bound(2).unwrap_or(0),
        // Hoglin / Piglin: the reward without the equipment bonus.
    // rust: S::Hoglin | S::Piglin => xp_reward(m),
    // rust: s if is_animal(s) || is_water_creature(s) => 1 + m.random.next_int_bound(3).unwrap_or(0),
    // rust: _ => {
    // rust: let mut reward = xp_reward(m);
            // Zombie.getBaseExperienceReward: babies are worth 2.5 times as much.
    // rust: if zombie_family(s) && m.is_baby() {
    // rust: reward = (reward as f32 * 2.5) as i32;
}
    // rust: if reward > 0 {
    // rust: let mut result = reward;
    // rust: for slot in SLOTS {
                    // EquipmentSlot.canIncreaseExperience: all but the saddle.
    // rust: if slot != "saddle"
    // rust: && slot_item(m, slot).is_some()
    // rust: && drop_chance(m, slot) <= 1.0
    // rust: {
    // rust: result += 1 + m.random.next_int_bound(3).unwrap_or(0);
}
}
    // rust: result
    // rust: } else {
    // rust: reward
}
}
}
}

    // rust: mod death_loot_table_tests {
//     use super::*;
//     use horizon_world::loot::{LootData, PackOverlay};

    /// Mob.getLootTable and LootTable.getRandomItems: a mob's own
    /// `DeathLootTable` is rolled instead of its type's, with the level's
    /// random when the table has no random sequence (as a pack's tables
    /// mostly don't), and with its `DeathLootTableSeed` when set.
pub fn a_mob_drops_its_own_death_loot_table() void {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("data").exists() {
    // rust: return;
}
    // rust: let table = br#"{"type":"minecraft:entity","pools":[{"rolls":1,
    // rust: "entries":[{"type":"minecraft:item","name":"minecraft:diamond"}]}]}"#;
    // rust: let packs = [("loot_table/pack:boss".to_owned(), vec![table.to_vec()])];
    // rust: let loot = LootData::load(&root, &PackOverlay { files: &packs }).unwrap();
    // rust: let death = Death {
    // rust: loot: &loot,
    // rust: damage: None,
    // rust: player: None,
    // rust: luck: 0.0,
    // rust: vehicle: None,
    // rust: mob_drops: true,
    // rust: world_seed: 0,
}
    // rust: let items = |seed: i64, own: bool| {
    // rust: let kind = crate::mobs::sensor_scan_tests::kind();
    // rust: let mut m = Mob::new(1, kind, horizon_core::geometry::Vec3::ZERO, 0.0);
    // rust: if own {
    // rust: m.extra.death_loot_table = Some("pack:boss".into());
}
    // rust: m.extra.death_loot_seed = seed;
    // rust: let mut sequences = RandomSequences::default();
    // rust: let (out, _) = die(&mut m, &death, &mut sequences, &mut LegacyRandom::new(7));
    // rust: out.into_iter()
    // rust: .filter_map(|d| match d {
    // rust: Drop::Item(s) => Some(s.item),
    // rust: _ => None,
    // rust: })
    // rust: .collect::<Vec<_>>()
}
    // rust: assert_eq!(items(0, true), ["minecraft:diamond"]);
    // rust: assert_eq!(items(42, true), ["minecraft:diamond"]);
        // Without one, the type's table (a cow's beef and leather).
    // rust: assert!(items(0, false).iter().all(|i| i != "minecraft:diamond"));
}
}
    // rust: mod slot_tests {
//     use super::*;
//     use crate::mobs::sensor_scan_tests::kind;
//     use horizon_core::geometry::Vec3;
//     use std::sync::Arc;

pub fn mob(id: []const u8, species: Species) M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut kind = kind();
    // rust: let k = Arc::make_mut(&mut kind);
    // rust: k.id = id.into();
    // rust: k.species = species;
    // rust: Mob::new(1, kind, Vec3::ZERO, 0.0)
}

    /// A wolf's armor is the body slot, with the durability it lost; a
    /// helmet beside it reads from the head slot.
pub fn a_wolfs_slots_read_apart() void {
}
    // rust: let mut wolf = mob("minecraft:wolf", Species::Wolf);
    // rust: wolf.extra.body = Some("minecraft:wolf_armor".into());
    // rust: wolf.extra.body_damage = 9;
    // rust: wolf.extra.head = Some("minecraft:iron_helmet".into());
    // rust: let body = slot_item(&wolf, "body").unwrap();
    // rust: let head = slot_item(&wolf, "head").unwrap();
    // rust: assert_eq!(
    // rust: (body.item.as_str(), body.damage),
    // rust: ("minecraft:wolf_armor", 9)
    // rust: );
    // rust: assert_eq!(head.item, "minecraft:iron_helmet");
        // The armor was put on by `Equippable`, so it always drops.
    // rust: assert_eq!(drop_chance(&wolf, "body"), 2.0);
}

    /// A body item nothing equipped (a `/item replace ... armor.body` on a
    /// zombie) drops by the default chance, as vanilla's unequipped slot.
pub fn a_zombies_body_item_drops_by_the_default_chance() void {
}
    // rust: let mut zombie = mob("minecraft:zombie", Species::Zombie);
    // rust: zombie.extra.body = Some("minecraft:iron_helmet".into());
    // rust: assert_eq!(drop_chance(&zombie, "body"), DEFAULT_DROP_CHANCE);
    // rust: let body = slot_item(&zombie, "body").unwrap();
    // rust: assert_eq!(body.item, "minecraft:iron_helmet");
    // rust: assert!(slot_item(&zombie, "head").is_none());
}
}
