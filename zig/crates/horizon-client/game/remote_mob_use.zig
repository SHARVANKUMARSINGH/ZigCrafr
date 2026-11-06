//! Transpiled from Horizon Rust crate
//! Module: horizon-client_remote_mob_use
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! A server's client right-clicking a mob: vanilla's client runs
//! `Player.interactOn` on its own level (`MultiPlayerGameMode.interact`) to
//! learn whether the click ends on the mob or goes on to the held item
//! (`Minecraft.startUseItem` then sends UseItem). The server does the real
//! interaction; this is what the client's copy of the mob answers.
// use super::Game;
// use horizon_client::actions::Action;
// use horizon_client::{
    // rust: first_person::Hand,
    // rust: mobs::{Mob, Species, armadillo, equine, llama, nautilus},
}

    // rust: impl Game<'_> {
    /// Whether mob `i` takes a right click with `hand`'s item on this
    /// client (`Mob.interact`'s result consumes the action).
    // rust: pub(super) fn remote_mob_takes(&mut self, i: usize, hand: Hand) -> bool {
    // rust: let Some(m) = self.mobs.get(i).filter(|m| m.alive()) else {
    // rust: return false;
}
    // rust: let stack = match hand {
    // rust: Hand::Main => self.stack_in(self.selected),
    // rust: Hand::Off => self.offhand.as_ref(),
}
    // rust: let item = stack.map_or("", |s| &*s.item);
    // rust: let baby = m.is_baby();
        // Mob.checkAndHandleImportantInteractions: a lead, a named name tag,
        // a spawn egg of the mob's own kind.
    // rust: if item == "minecraft:lead"
    // rust: || item == "minecraft:name_tag" && stack.is_some_and(|s| s.custom_name().is_some())
    // rust: || item.strip_suffix("_spawn_egg") == Some(m.kind.id.as_str())
    // rust: {
    // rust: return true;
}
        // Armadillo.mobInteract: a rolled-up armadillo fails before
        // AgeableMob/Animal.mobInteract, so food and age lock are not taken.
        // A brush still reaches brushOffScute below.
    // rust: if m.species() == Species::Armadillo && armadillo::client_rejects_food(m, item) {
    // rust: return false;
}
        // AgeableMob.mobInteract: a golden dandelion on a baby that can be age
        // locked is SUCCESS on a client too (the server sets the lock).
    // rust: if self.age_lock_takes(m, item) {
    // rust: return true;
}
        // Animal.mobInteract: its food is CONSUME on a client. A nautilus
        // overrides mobInteract, and an untamed one only takes its taming
        // items, so it answers in its own arm below.
    // rust: if m.kind.flags.animal
    // rust: && !matches!(m.species(), Species::Nautilus | Species::ZombieNautilus)
    // rust: && m.kind.food.iter().any(|f| f.as_str() == item)
    // rust: {
    // rust: return true;
}
    // rust: let sneaking = self.keys.held(Action::Sneak);
    // rust: match m.species() {
            // Villager / WanderingTrader.mobInteract: trading, or a baby's head shake.
    // rust: Species::Villager | Species::WanderingTrader => item != "minecraft:villager_spawn_egg",
            // AbstractHorse, Camel: ridden (or their inventory opened); a baby only eats.
    // rust: s if equine::is_equine(s)
    // rust: || llama::is_llama(s)
    // rust: || matches!(s, Species::Camel | Species::CamelHusk) =>
    // rust: {
    // rust: !baby
}
            // Pig / Strider.mobInteract: a saddled one is ridden.
    // rust: Species::Pig | Species::Strider => m.extra.saddled && !sneaking,
            // HappyGhast.mobInteract: a harnessed adult is ridden.
    // rust: Species::HappyGhast => !baby && m.extra.body.is_some(),
            // TamableAnimal (wolf, cat, parrot) on a client: CONSUME once tame.
    // rust: Species::Wolf | Species::Cat | Species::Parrot => m.extra.tame,
            // Allay.mobInteract: gives an item or takes it back.
    // rust: Species::Allay => self.predict_allay_interaction(i, hand, stack.cloned()),
    // rust: Species::Cow | Species::Goat => item == "minecraft:bucket" && !baby,
    // rust: Species::Mooshroom => {
    // rust: !baby
    // rust: && (matches!(
    // rust: item,
    // rust: "minecraft:bucket" | "minecraft:bowl" | "minecraft:shears"
    // rust: ) || m.extra.variant == 1
    // rust: && horizon_client::flowers::stew_effect(item).is_some())
}
    // rust: Species::Sheep => item == "minecraft:shears" || self.interact_sheep_dye(i, hand, true),
            // SnowGolem.mobInteract: shears take the pumpkin off.
    // rust: Species::SnowGolem => item == "minecraft:shears" && !m.extra.sheared,
            // AbstractNautilus.mobInteract: an untamed adult only answers its
            // taming items, a tame one is fed, mounted or opens its screen.
    // rust: Species::Nautilus | Species::ZombieNautilus => {
    // rust: let taming: Vec<String> = self
    // rust: .res
    // rust: .items()
    // rust: .item_tags
    // rust: .get("minecraft:nautilus_taming_items")
    // rust: .map(|t| t.iter().cloned().collect())
    // rust: .unwrap_or_default();
    // rust: nautilus_takes(nautilus::is_food(m, item, &taming), m.extra.tame, baby)
}
            // IronGolem.mobInteract.
    // rust: Species::IronGolem => iron_golem_takes(item, m.health, m.attrs.max_health),
            // CopperGolem.mobInteract.
    // rust: Species::CopperGolem => {
    // rust: copper_golem_takes(item, m.extra.main_hand.is_some(), self.golem_shearable(i))
}
            // Bucketable.bucketMobPickup.
    // rust: Species::Cod
    // rust: | Species::Salmon
    // rust: | Species::TropicalFish
    // rust: | Species::Pufferfish
    // rust: | Species::Axolotl => item == "minecraft:water_bucket",
            // Tadpole.mobInteract: frog food (not while age locked), else the bucket.
    // rust: Species::Tadpole => {
    // rust: item == "minecraft:water_bucket"
    // rust: || !m.extra.age_locked && m.kind.food.iter().any(|f| f.as_str() == item)
}
            // Armadillo.brushOffScute fails on a baby, so its brush falls
            // through to FAIL (scared) or Mob.mobInteract's PASS.
    // rust: Species::Armadillo => item == "minecraft:brush" && !baby,
            // ZombieVillager.mobInteract: CONSUME for a golden apple.
    // rust: Species::ZombieVillager => item == "minecraft:golden_apple",
            // Creeper.mobInteract: CREEPER_IGNITERS.
    // rust: Species::Creeper => {
    // rust: matches!(item, "minecraft:flint_and_steel" | "minecraft:fire_charge")
}
            // PiglinAi.mobInteract: an adult admires what it loves.
    // rust: Species::Piglin => {
    // rust: !baby
    // rust: && self
    // rust: .res
    // rust: .items()
    // rust: .item_tags
    // rust: .get("minecraft:piglin_loved")
    // rust: .is_some_and(|tag| tag.contains(item))
}
    // rust: _ => false,
}
}
    /// Whether that answer is `InteractionResult.SUCCESS`, the only result that
    /// swings the hand: `CONSUME` ends the click without one. An adult animal's
    /// food (`Animal.mobInteract`), a zombie villager's golden apple and a
    /// sheep's shears (the server alone checks `readyForShearing`) answer
    /// CONSUME on a client, and a horse's or panda's food SUCCESS_SERVER
    /// (#9437). A tame wolf, cat or parrot sitting down is SUCCESS.
    // rust: pub(super) fn remote_mob_swings(&self, i: usize, hand: Hand) -> bool {
    // rust: let Some(m) = self.mobs.get(i).filter(|m| m.alive()) else {
    // rust: return false;
}
    // rust: let stack = match hand {
    // rust: Hand::Main => self.stack_in(self.selected),
    // rust: Hand::Off => self.offhand.as_ref(),
}
    // rust: let item = stack.map_or("", |s| &*s.item);
    // rust: mob_swings(m, item)
}
    /// `AbstractHorse.handleEating` (`Llama`'s and `Camel`'s too) on this
    /// client's copy: a baby fed something that ages it draws one happy
    /// villager particle. The server draws it on its own level only, so no
    /// packet brings it.
    // rust: pub(super) fn remote_feed_particles(&mut self, i: usize, hand: Hand) {
    // rust: let Some(m) = self.mobs.get(i).filter(|m| m.alive()) else {
    // rust: return;
}
    // rust: let stack = match hand {
    // rust: Hand::Main => self.stack_in(self.selected),
    // rust: Hand::Off => self.offhand.as_ref(),
}
    // rust: let item = stack.map_or("", |s| &*s.item);
    // rust: if !ages_on_food(m, item) {
    // rust: return;
}
    // rust: let id = m.id;
    // rust: self.particles_around_mob(
    // rust: id,
    // rust: "happy_villager",
    // rust: horizon_client::particles::Burst::HORSE_EATING,
    // rust: );
}
}

/// `AbstractNautilus.mobInteract` on a client: its food is answered while the
/// nautilus takes it (taming items for an untamed adult, its food once tamed),
/// and a tame adult answers every click because that is the mount.
pub fn nautilus_takes(food: bool, tame: bool, baby: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: food || (tame && !baby)
}

/// `IronGolem.mobInteract`: an iron ingot heals 25 and only answers SUCCESS when
/// that changed the health, so a full golem leaves the click to the item.
pub fn iron_golem_takes(item: []const u8, health: f32, max_health: f32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: item == "minecraft:iron_ingot" && health < max_health
}

/// `CopperGolem.mobInteract` on a client: an empty hand makes the golem throw
/// what it holds, and shears answer only when `readyForShearing`. Honeycomb and
/// axes return `PASS` here because the waxing and scraping run on the server.
pub fn copper_golem_takes(item: []const u8, holding: bool, shearable: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (item.is_empty() && holding) || (item == "minecraft:shears" && shearable)
}

/// `AbstractHorse.handleEating` (and the llama and camel variants): this
/// mouthful is the one that ages the baby up, which is the same moment the
/// level draws one happy villager particle.
///
/// `handleEating` gates both on `isBaby() && !isAgeLocked()` — a locked baby
/// does not grow, and the particle goes with the growth.
    // rust: pub(super) fn ages_on_food(m: &Mob, item: &str) -> bool {
    // rust: if !m.is_baby() || m.extra.age_locked || item.is_empty() {
    // rust: return false;
}
    // rust: match m.species() {
        // Llama.handleEating: wheat 10, hay 90.
    // rust: s if llama::is_llama(s) => matches!(item, "minecraft:wheat" | "minecraft:hay_block"),
        // Camel.handleEating: its food ages it by 10.
    // rust: Species::Camel => m.kind.food.iter().any(|f| f.as_str() == item),
        // AbstractHorse.handleEating: every food but the red mushroom.
    // rust: Species::Horse | Species::Donkey | Species::Mule => matches!(
    // rust: item,
    // rust: "minecraft:wheat"
    // rust: | "minecraft:sugar"
    // rust: | "minecraft:hay_block"
    // rust: | "minecraft:apple"
    // rust: | "minecraft:carrot"
    // rust: | "minecraft:golden_carrot"
    // rust: | "minecraft:golden_apple"
    // rust: | "minecraft:enchanted_golden_apple"
    // rust: ),
    // rust: _ => false,
}
}

/// [`Game::remote_mob_swings`] for mob `m` and the held `item`.
pub fn mob_swings(m: *Mob, item: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let food = m.kind.food.iter().any(|f| f.as_str() == item);
    // rust: let hurt = m.health < m.attrs.max_health;
    // rust: match m.species() {
        // AbstractHorse.fedFood (Camel's, Llama's too): SUCCESS_SERVER,
        // which swings on the server's side only.
    // rust: s if food
    // rust: && (equine::is_equine(s)
    // rust: || llama::is_llama(s)
    // rust: || matches!(s, Species::Camel | Species::CamelHusk)) =>
    // rust: {
    // rust: return false;
}
        // Panda.mobInteract: its bamboo answers SUCCESS_SERVER.
    // rust: Species::Panda if food => return false,
        // Cat.mobInteract: food tames an untamed cat, and heals a hurt
        // tame one: SUCCESS before Animal.mobInteract is reached.
    // rust: Species::Cat if food && (!m.extra.tame || hurt) => return true,
        // Wolf.mobInteract: food heals a hurt tame wolf (SUCCESS).
    // rust: Species::Wolf if food && m.extra.tame && hurt => return true,
    // rust: _ => {}
}
    // Animal.mobInteract: a baby's food is SUCCESS, since it ages up; an
    // adult's is CONSUME, as only the server knows whether it can breed.
    // rust: if m.kind.flags.animal
    // rust: && !matches!(m.species(), Species::Nautilus | Species::ZombieNautilus)
    // rust: && food
    // rust: {
    // rust: return m.is_baby() && !m.extra.age_locked;
}
    // A tame wolf, cat or parrot sits or stands up: SUCCESS
    // (TamableAnimal's subclasses), so it swings.
    // rust: let consumes = match m.species() {
        // ZombieVillager.mobInteract: a golden apple cures it on the server.
    // rust: Species::ZombieVillager => item == "minecraft:golden_apple",
        // Sheep.mobInteract: shears, sheared or not.
    // rust: Species::Sheep => item == "minecraft:shears",
    // rust: _ => false,
}
    // rust: !consumes
}
    // rust: mod tests {
//     use super::*;
//     use std::sync::Arc;

pub fn mob(kind: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("entity-types.json").exists() {
    // rust: return None;
}
    // rust: let data = horizon_client::mobs::MobTypes::load(&root).ok()?;
    // rust: let kind = Arc::new(data.types.get(kind)?.clone());
    // rust: Some(Mob::new(
    // rust: 1,
    // rust: kind,
    // rust: horizon_core::geometry::Vec3::new(0.0, 4.0, 0.0),
    // rust: 0.0,
    // rust: ))
}

    /// Tamables' and horses' own `mobInteract` answer before `Animal.mobInteract`'s
    /// CONSUME (#9450): sitting down and healing are SUCCESS, a horse's food
    /// SUCCESS_SERVER.
pub fn only_a_client_success_swings_the_hand() void {
}
    // rust: let Some(mut wolf) = mob("minecraft:wolf") else {
    // rust: return;
}
    // rust: wolf.extra.tame = true;
    // rust: assert!(
    // rust: mob_swings(&wolf, ""),
    // rust: "a tame wolf sits: SUCCESS.withoutItem"
    // rust: );
    // rust: assert!(
    // rust: !mob_swings(&wolf, "minecraft:beef"),
    // rust: "full health: Animal's CONSUME"
    // rust: );
    // rust: wolf.health = wolf.attrs.max_health - 1.0;
    // rust: assert!(
    // rust: mob_swings(&wolf, "minecraft:beef"),
    // rust: "hurt: Wolf.feed is SUCCESS"
    // rust: );
    // rust: let mut cat = mob("minecraft:cat").unwrap();
    // rust: assert!(mob_swings(&cat, "minecraft:cod"), "taming: SUCCESS");
    // rust: cat.extra.tame = true;
    // rust: assert!(
    // rust: !mob_swings(&cat, "minecraft:cod"),
    // rust: "tame, full health: CONSUME"
    // rust: );
    // rust: assert!(mob_swings(&cat, ""), "a tame cat sits: SUCCESS");
    // rust: let mut parrot = mob("minecraft:parrot").unwrap();
    // rust: parrot.extra.tame = true;
    // rust: assert!(mob_swings(&parrot, ""), "a tame parrot sits: SUCCESS");
    // rust: let horse = mob("minecraft:horse").unwrap();
    // rust: assert!(
    // rust: !mob_swings(&horse, "minecraft:apple"),
    // rust: "AbstractHorse.fedFood: SUCCESS_SERVER"
    // rust: );
    // rust: let cow = mob("minecraft:cow").unwrap();
    // rust: assert!(!mob_swings(&cow, "minecraft:wheat"), "adult: CONSUME");
    // rust: let sheep = mob("minecraft:sheep").unwrap();
    // rust: assert!(!mob_swings(&sheep, "minecraft:shears"), "Sheep: CONSUME");
}

    /// `AbstractNautilus.mobInteract` (#8595): an untamed adult takes its taming
    /// items only, and a tame adult is mounted by any click.
pub fn a_nautilus_answers_its_food_and_a_tame_one_is_ridden() void {
}
    // rust: assert!(
    // rust: !nautilus_takes(false, false, false),
    // rust: "untamed, taming item missing"
    // rust: );
    // rust: assert!(nautilus_takes(true, false, false), "a taming item");
    // rust: assert!(
    // rust: nautilus_takes(false, true, false),
    // rust: "a tame adult is mounted"
    // rust: );
    // rust: assert!(!nautilus_takes(false, true, true), "a baby is not mounted");

        // `AbstractNautilus.isFood`: taming items while untamed, its food after.
    // rust: let Some(mut m) = mob("minecraft:nautilus") else {
    // rust: return;
}
    // rust: let taming = vec!["minecraft:pufferfish".to_string()];
    // rust: m.extra.age = 0;
    // rust: m.extra.tame = false;
    // rust: assert!(nautilus::is_food(&m, "minecraft:pufferfish", &taming));
    // rust: assert!(
    // rust: !nautilus::is_food(&m, "minecraft:cod", &taming),
    // rust: "cod tames nothing"
    // rust: );
    // rust: m.extra.tame = true;
    // rust: assert!(
    // rust: nautilus::is_food(&m, "minecraft:cod", &taming),
    // rust: "a tame one eats cod"
    // rust: );
}

    /// `IronGolem.mobInteract` and `CopperGolem.mobInteract` (#8630): the click
    /// has to end on the golem, or the client goes on to use the item and turns
    /// to the off hand.
pub fn the_golems_answer_the_click() void {
}
    // rust: assert!(iron_golem_takes("minecraft:iron_ingot", 50.0, 100.0));
    // rust: assert!(
    // rust: !iron_golem_takes("minecraft:iron_ingot", 100.0, 100.0),
    // rust: "full"
    // rust: );
    // rust: assert!(
    // rust: !iron_golem_takes("minecraft:stick", 50.0, 100.0),
    // rust: "not ingot"
    // rust: );

    // rust: assert!(copper_golem_takes("", true, false), "takes its item back");
    // rust: assert!(!copper_golem_takes("", false, false), "nothing to take");
    // rust: assert!(
    // rust: copper_golem_takes("minecraft:shears", false, true),
    // rust: "shears"
    // rust: );
    // rust: assert!(
    // rust: !copper_golem_takes("minecraft:shears", false, false),
    // rust: "no flower"
    // rust: );
    // rust: assert!(
    // rust: !copper_golem_takes("minecraft:honeycomb", false, true),
    // rust: "waxing is server-only"
    // rust: );
    // rust: assert!(
    // rust: !copper_golem_takes("minecraft:iron_axe", false, true),
    // rust: "scraping too"
    // rust: );
}

    /// `AbstractHorse.handleEating` draws the particle only while the baby can
    /// still grow: `isBaby() && !isAgeLocked()` (#8590).
pub fn a_locked_baby_draws_no_happy_villager() void {
}
    // rust: let Some(mut horse) = mob("minecraft:horse") else {
    // rust: return;
}
    // rust: horse.extra.age = -24000;
    // rust: assert!(ages_on_food(&horse, "minecraft:wheat"));
    // rust: horse.extra.age_locked = true;
    // rust: assert!(!ages_on_food(&horse, "minecraft:wheat"), "locked");
    // rust: horse.extra.age_locked = false;
    // rust: horse.extra.age = 0;
    // rust: assert!(!ages_on_food(&horse, "minecraft:wheat"), "adult");
    // rust: horse.extra.age = -24000;
    // rust: assert!(!ages_on_food(&horse, "minecraft:red_mushroom"), "no food");

    // rust: if let Some(mut llama) = mob("minecraft:llama") {
    // rust: llama.extra.age = -24000;
    // rust: assert!(ages_on_food(&llama, "minecraft:hay_block"));
    // rust: llama.extra.age_locked = true;
    // rust: assert!(!ages_on_food(&llama, "minecraft:hay_block"), "locked llama");
}
    // rust: if let Some(mut camel) = mob("minecraft:camel")
    // rust: && camel.kind.food.iter().any(|f| f == "minecraft:cactus")
    // rust: {
    // rust: camel.extra.age = -24000;
    // rust: assert!(ages_on_food(&camel, "minecraft:cactus"));
    // rust: camel.extra.age_locked = true;
    // rust: assert!(!ages_on_food(&camel, "minecraft:cactus"), "locked camel");
}
}
}
