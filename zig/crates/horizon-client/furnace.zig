//! Transpiled from Horizon Rust crate
//! Module: horizon-client_furnace
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `AbstractFurnaceBlockEntity`'s cooking over the furnace data the chunk
//! holds (`containers::Furnace`): it needs the recipes, so it lives above them.
// use crate::{
    // rust: containers::{Furnace, recipe_used_key},
    // rust: crafting::Recipes,
    // rust: items::{ItemStack, Items},
    // rust: providers::Providers,
}

/// The furnace methods that read the recipes.
    // rust: pub trait FurnaceCooking {
    /// `AbstractFurnaceBlockEntity.setItem` on the input slot: anything but
    /// the same item with the same components restarts cooking, with the
    /// total time of the new input's recipe (200 ticks without one).
pub fn set_input(self: *Self, recipes: *Recipes, stack: ?ItemStack) void;
    /// `recipesUsed`, each recipe with its `experience` (0 for one this data pack does
    /// not have), in the order `getRecipesToAwardAndPopExperience` pays them.
pub fn recipe_experience(self: *Self, recipes: *Recipes) V;
    /// A menu click wrote its slots into `items`, and `before` was the input
    /// slot until then: the menu called `setItem` on it only if it changed
    /// (`Slot.setByPlayer`; partial takes and merges keep the stack).
pub fn input_clicked(self: *Self, recipes: *Recipes, before: ?ItemStack) void;
    /// One server tick. Returns `Some(lit)` when the LIT block state must change.
    /// `drops` collects what the furnace lets fall at its position
    /// (`Containers.dropItemStack`): the remainder of a fuel when more of it is left.
    // rust: fn tick(
    // rust: &mut self,
    // rust: recipes: &Recipes,
    // rust: items: &Items,
    // rust: providers: &Providers,
    // rust: drops: &mut Vec<ItemStack>,
    // rust: ) -> Option<bool>;
pub fn idle(self: *Self) b;
}
    // rust: impl FurnaceCooking for Furnace {
pub fn set_input(self: *Self, recipes: *Recipes, stack: ?ItemStack) void {
}
    // rust: let same = match (&self.items[0], &stack) {
    // rust: (Some(old), Some(new)) => old.same_item_same_components(new),
    // rust: _ => false,
}
    // rust: self.items[0] = stack;
    // rust: if !same {
    // rust: self.cooking_total = self.items[0]
    // rust: .as_ref()
    // rust: .and_then(|input| recipes.cook(self.kind.recipe_type(), input))
    // rust: .map_or(200, |recipe| total_time(recipe.time, self.speed));
    // rust: self.cooking_timer = 0;
}
}
pub fn recipe_experience(self: *Self, recipes: *Recipes) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.recipes_used
    // rust: .iter()
    // rust: .map(|(id, count)| (*count, recipes.cooking_experience(id)))
    // rust: .collect()
}
pub fn input_clicked(self: *Self, recipes: *Recipes, before: ?ItemStack) void {
}
    // rust: if self.items[0] != before {
    // rust: let after = std::mem::replace(&mut self.items[0], before);
    // rust: self.set_input(recipes, after);
}
}
    // rust: fn tick(
    // rust: &mut self,
    // rust: recipes: &Recipes,
    // rust: items: &Items,
    // rust: providers: &Providers,
    // rust: drops: &mut Vec<ItemStack>,
    // rust: ) -> Option<bool> {
    // rust: let was_lit = self.lit_remaining > 0;
    // rust: let mut lit = false;
    // rust: if self.lit_remaining > 0 {
    // rust: self.lit_remaining -= 1;
    // rust: lit = self.lit_remaining > 0;
}
    // rust: let fast = self.kind.fast();
    // rust: let has_ingredient = self.items[0].is_some();
    // rust: let has_fuel = self.items[1].is_some();
    // rust: if lit || has_fuel && has_ingredient {
    // rust: if let Some(ingredient) = self.items[0].clone() {
    // rust: if let Some(recipe) = recipes.cook(self.kind.recipe_type(), &ingredient) {
    // rust: if self.cooking_timer == 0 {
    // rust: self.cooking_total = total_time(recipe.time, self.speed);
}
    // rust: let max = items.get(&recipe.result.item).map_or(64, |i| i.max_stack);
    // rust: let can_burn = match &self.items[2] {
    // rust: None => true,
    // rust: Some(out) => {
    // rust: out.item == recipe.result.item && out.count + recipe.result.count <= max
}
}
    // rust: if can_burn {
    // rust: if !lit {
    // rust: let fuel = self.items[1].clone();
    // rust: let time = fuel
    // rust: .as_ref()
    // rust: .map_or(0, |f| providers.burn_time(items, f, fast));
    // rust: let speed = fuel
    // rust: .as_ref()
    // rust: .map_or(1.0, |f| providers.speed(items, f, fast));
    // rust: self.lit_remaining = time;
    // rust: self.lit_total = time;
    // rust: self.speed = speed;
    // rust: if self.cooking_total > 0 && self.cooking_timer < self.cooking_total {
    // rust: let ratio = self.cooking_timer as f32 / self.cooking_total as f32;
    // rust: self.cooking_total = total_time(recipe.time, self.speed);
    // rust: self.cooking_timer =
    // rust: (ratio * self.cooking_total as f32).ceil() as i32;
}
    // rust: if time > 0 {
                                // AbstractFurnaceBlockEntity.consumeFuel: the fuel's crafting
                                // remainder takes the slot once the stack is used up, else
                                // it is dropped.
    // rust: if let Some(f) = self.items[1].as_mut() {
    // rust: let remainder = items
    // rust: .get(&f.item)
    // rust: .and_then(|i| i.crafting_remainder.as_deref())
    // rust: .map(|r| ItemStack::new(r, 1));
    // rust: f.count -= 1;
    // rust: if f.count == 0 {
    // rust: self.items[1] = remainder;
    // rust: } else if let Some(remainder) = remainder {
    // rust: drops.push(remainder);
}
}
    // rust: lit = true;
}
}
    // rust: if lit {
    // rust: self.cooking_timer += 1;
    // rust: if self.cooking_timer >= self.cooking_total {
    // rust: self.cooking_timer = 0;
    // rust: self.cooking_total = total_time(recipe.time, self.speed);
    // rust: match &mut self.items[2] {
    // rust: Some(out) => out.count += recipe.result.count,
    // rust: None => self.items[2] = Some(recipe.result.clone()),
}
    // rust: *self
    // rust: .recipes_used
    // rust: .entry(recipe_used_key(&recipe.id))
    // rust: .or_insert(0) += 1;
                                // AbstractFurnaceBlockEntity.burn: drying a wet sponge fills
                                // the bucket in the fuel slot.
    // rust: if self.items[0]
    // rust: .as_ref()
    // rust: .is_some_and(|i| &*i.item == "minecraft:wet_sponge")
    // rust: && self.items[1]
    // rust: .as_ref()
    // rust: .is_some_and(|f| &*f.item == "minecraft:bucket")
    // rust: {
    // rust: self.items[1] =
    // rust: Some(ItemStack::new("minecraft:water_bucket", 1));
}
    // rust: if let Some(i) = self.items[0].as_mut() {
    // rust: i.count -= 1;
    // rust: if i.count == 0 {
    // rust: self.items[0] = None;
}
}
}
    // rust: } else {
    // rust: self.cooking_timer = 0;
}
    // rust: } else {
    // rust: self.cooking_timer = 0;
}
}
    // rust: } else {
    // rust: self.cooking_timer = 0;
}
    // rust: } else if self.cooking_timer > 0 {
    // rust: self.cooking_timer = (self.cooking_timer - 2).clamp(0, self.cooking_total);
}
    // rust: (was_lit != lit).then_some(lit)
}
pub fn idle(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.lit_remaining <= 0
    // rust: && self.cooking_timer <= 0
    // rust: && !(self.items[0].is_some() && self.items[1].is_some())
}
}
pub fn total_time(time: u32, speed: f32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if speed > 0.0 {
    // rust: (time as f32 / speed).ceil() as i32
    // rust: } else {
    // rust: time as i32
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::{containers::FurnaceKind, items::Items};
//     use horizon_world::loot::PackOverlay;
//     use std::{collections::HashMap, fs};

pub fn a_furnace_is_idle_only_while_its_tick_changes_nothing() void {
}
    // rust: let stack = |id: &str| Some(ItemStack::new(id, 1));
    // rust: let furnace = |input, fuel, lit_remaining, cooking_timer| Furnace {
    // rust: kind: FurnaceKind::Furnace,
    // rust: items: [input, fuel, stack("minecraft:iron_ingot")],
    // rust: lit_remaining,
    // rust: lit_total: 0,
    // rust: cooking_timer,
    // rust: cooking_total: 200,
    // rust: speed: 1.0,
    // rust: recipes_used: HashMap::new(),
}
    // rust: assert!(furnace(None, None, 0, 0).idle());
    // rust: assert!(furnace(stack("minecraft:iron_ore"), None, 0, 0).idle());
    // rust: assert!(furnace(None, stack("minecraft:coal"), 0, 0).idle());
    // rust: assert!(!furnace(stack("minecraft:iron_ore"), stack("minecraft:coal"), 0, 0).idle());
    // rust: assert!(!furnace(None, None, 1, 0).idle());
    // rust: assert!(!furnace(stack("minecraft:iron_ore"), None, 0, 5).idle());
}

    /// A data root holding one recipe, `test:ore` into `test:ingot`, and an item table
    /// with two fuels: `test:coal` (no remainder) and `test:cell` (a content mod's item
    /// that leaves `test:husk`). The folder is gone when this returns.
pub fn data(name: []const u8) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-furnace-{name}-{}", std::process::id(),));
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: fs::create_dir_all(root.join("data/minecraft/recipe")).unwrap();
    // rust: fs::write(
    // rust: root.join("data/minecraft/recipe/test_ingot.json"),
    // rust: br#"{"type":"minecraft:smelting","ingredient":"test:ore","result":{"id":"test:ingot"}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: fs::create_dir_all(root.join("data/minecraft/loot_table")).unwrap();
    // rust: let fuel_component =
    // rust: r#"{"minecraft:cooking_fuel": {"burn_time": 200, "speed_multiplier": 1.0}}"#;
    // rust: fs::write(
    // rust: root.join("items.json"),
    // rust: format!(
    // rust: r#"{{"test:ore": {{}}, "test:ingot": {{}}, "test:coal": {fuel_component}, "test:cell": {fuel_component}, "test:husk": {{}}}}"#
    // rust: ),
    // rust: )
    // rust: .unwrap();
    // rust: fs::write(
    // rust: root.join(horizon_items::items::MOD_CRAFT_REMAINDERS),
    // rust: r#"{"test:cell": "test:husk"}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let items = Items::catalog(&root, &PackOverlay::NONE).unwrap();
    // rust: let recipes = Recipes::load(&root, &items, &PackOverlay::NONE).unwrap();
    // rust: let providers = Providers::load(&root);
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: (items, recipes, providers)
}

    /// The furnace sleeps while `idle`, so its tick must change nothing then: run the
    /// real tick on every idle case and compare, and check a furnace that can smelt
    /// isn't idle and does change.
pub fn an_idle_furnace_tick_changes_nothing() void {
}
    // rust: let (items, recipes, providers) = data("idle");
    // rust: let stack = |id: &str| Some(ItemStack::new(id, 1));
    // rust: let furnace = |input, fuel, output| Furnace {
    // rust: kind: FurnaceKind::Furnace,
    // rust: items: [input, fuel, output],
    // rust: lit_remaining: 0,
    // rust: lit_total: 0,
    // rust: cooking_timer: 0,
    // rust: cooking_total: 200,
    // rust: speed: 1.0,
    // rust: recipes_used: HashMap::new(),
}
    // rust: let idle = [
    // rust: furnace(None, None, None),
    // rust: furnace(stack("test:ore"), None, None),
    // rust: furnace(None, stack("test:coal"), None),
    // rust: furnace(None, None, stack("test:ingot")),
    // rust: furnace(stack("test:ingot"), None, stack("test:ingot")),
    // rust: ];
    // rust: for before in idle {
    // rust: assert!(before.idle(), "{before:?}");
    // rust: let mut after = before.clone();
    // rust: let mut drops = Vec::new();
    // rust: let lit = after.tick(&recipes, &items, &providers, &mut drops);
    // rust: assert_eq!(lit, None, "{before:?}");
    // rust: assert!(drops.is_empty(), "{before:?}");
    // rust: assert_eq!(format!("{after:?}"), format!("{before:?}"));
}
    // rust: let mut busy = furnace(stack("test:ore"), stack("test:coal"), None);
    // rust: assert!(!busy.idle());
    // rust: let before = format!("{busy:?}");
    // rust: assert_eq!(
    // rust: busy.tick(&recipes, &items, &providers, &mut Vec::new()),
    // rust: Some(true)
    // rust: );
    // rust: assert_ne!(format!("{busy:?}"), before);
}

    /// A furnace with `fuel` x `count` burning `test:ore` into `test:ingot` ([`data`]).
pub fn burn(fuel: []const u8, count: u32) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (items, recipes, providers) =
    // rust: data(&format!("remainder-{}-{count}", fuel.replace(':', "-")));
    // rust: let mut furnace = Furnace {
    // rust: kind: FurnaceKind::Furnace,
    // rust: items: [
    // rust: Some(ItemStack::new("test:ore", 1)),
    // rust: Some(ItemStack::new(fuel, count)),
    // rust: None,
    // rust: ],
    // rust: lit_remaining: 0,
    // rust: lit_total: 0,
    // rust: cooking_timer: 0,
    // rust: cooking_total: 0,
    // rust: speed: 1.0,
    // rust: recipes_used: HashMap::new(),
}
    // rust: let mut drops = Vec::new();
    // rust: let lit = furnace.tick(&recipes, &items, &providers, &mut drops);
    // rust: assert_eq!(lit, Some(true), "the fuel lit the furnace");
    // rust: (furnace, drops)
}

pub fn fuel_slot(furnace: *Furnace) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: furnace.items[1].as_ref().map(|s| (&*s.item, s.count))
}

    /// `AbstractFurnaceBlockEntity.consumeFuel`: the last of a fuel with a remainder
    /// leaves it in the fuel slot.
pub fn the_last_fuel_leaves_its_remainder_in_the_slot() void {
}
    // rust: let (furnace, drops) = burn("test:cell", 1);
    // rust: assert_eq!(fuel_slot(&furnace), Some(("test:husk", 1)));
    // rust: assert!(drops.is_empty());
}

    /// With more of the fuel left, the remainder is dropped at the furnace.
pub fn a_fuel_still_in_the_stack_drops_its_remainder() void {
}
    // rust: let (furnace, drops) = burn("test:cell", 3);
    // rust: assert_eq!(fuel_slot(&furnace), Some(("test:cell", 2)));
    // rust: assert_eq!(drops, vec![ItemStack::new("test:husk", 1)]);
}

    /// A fuel without a remainder leaves nothing.
pub fn a_fuel_without_a_remainder_leaves_nothing() void {
}
    // rust: let (furnace, drops) = burn("test:coal", 1);
    // rust: assert_eq!(fuel_slot(&furnace), None);
    // rust: assert!(drops.is_empty());
    // rust: let (furnace, drops) = burn("test:coal", 2);
    // rust: assert_eq!(fuel_slot(&furnace), Some(("test:coal", 1)));
    // rust: assert!(drops.is_empty());
}
}
