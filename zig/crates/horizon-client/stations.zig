//! Transpiled from Horizon Rust crate
//! Module: horizon-client_stations
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Result rules of the workstation menus, ported from vanilla's
//! `EnchantmentMenu`, `AnvilMenu`, `GrindstoneMenu`, `SmithingMenu` (with
//! `SmithingTransformRecipe` / `SmithingTrimRecipe`) and `StonecutterMenu`.
//! Rendering and clicks live in the game; this module is pure item logic.
// use crate::{
    // rust: crafting::Ingredient,
    // rust: enchant::Enchantments,
    // rust: item_data::{self, Levels},
    // rust: items::{ItemStack, Items},
}
// use horizon_core::random::{LegacyRandom, RandomSource};
// use horizon_world::loot::PackOverlay;
// use serde_json::Value;
// use std::{fs, path::Path, sync::Arc};

/// Everything the workstation menus read, loaded once with the resources.
pub const StationData = struct {
    /// The same registry `Items` carries (`Items::enchantments`).
    enchantments: std::sync::*Enchantments,
    recipes: StationRecipes,
    brewing: crate::brewing::Brewing,
    trades: crate::merchant::Trades,
    banners: crate::banner::Banners,
    /// Every recipe's learnability and display count (the server recipe book).
    recipe_index: crate::recipe_book::RecipeIndex,
};
    // rust: impl StationData {
pub fn load(root: *Path, items: *Items, overlay: *PackOverlay) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: enchantments: std::sync::Arc::clone(&items.enchantments),
    // rust: recipes: StationRecipes::load(root, items, overlay),
    // rust: brewing: crate::brewing::Brewing::load(root, items, overlay),
    // rust: trades: crate::merchant::Trades::load(root, overlay),
    // rust: banners: crate::banner::Banners::load(root),
    // rust: recipe_index: crate::recipe_book::RecipeIndex::load(root, overlay),
}
}
}

// ---------------------------------------------------------------- enchanting

/// `EnchantingTableBlock.BOOKSHELF_OFFSETS`: the 5x5 ring two blocks out, two high.
pub fn bookshelf_offsets() V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut v = Vec::new();
    // rust: for x in -2i32..=2 {
    // rust: for z in -2i32..=2 {
    // rust: if x.abs() == 2 || z.abs() == 2 {
    // rust: for y in 0..=1 {
    // rust: v.push([x, y, z]);
}
}
}
}
    // rust: v
}
/// The three offers of `EnchantmentMenu.slotsChanged`.
pub const EnchantOffers = struct {
    costs: [i32,
    /// Shown clue: enchantment and level (`enchantClue` / `levelClue`).
    clues: [?(Arc<str,
};
/// `EnchantmentMenu.getEnchantmentList`.
    // rust: pub fn enchantment_list(
    // rust: e: &Enchantments,
    // rust: items: &Items,
    // rust: seed: i32,
    // rust: slot: usize,
    // rust: cost: i32,
    // rust: item: &str,
    // rust: ) -> Levels {
    // rust: let mut random = LegacyRandom::new(i64::from(seed.wrapping_add(slot as i32)));
    // rust: let pool = e.tag("minecraft:in_enchanting_table").to_vec();
    // rust: let mut list = e.select(items, &mut random, item, cost, &pool);
    // rust: if item == "minecraft:book" && list.len() > 1 {
    // rust: let i = random.next_int_bound(list.len() as i32).unwrap_or(0) as usize;
    // rust: list.remove(i);
}
    // rust: list
}
/// `EnchantmentMenu.slotsChanged` for an enchantable item.
    // rust: pub fn enchant_offers(
    // rust: e: &Enchantments,
    // rust: items: &Items,
    // rust: seed: i32,
    // rust: bookcases: i32,
    // rust: stack: Option<&ItemStack>,
    // rust: ) -> EnchantOffers {
    // rust: let mut offers = EnchantOffers::default();
    // rust: let Some(stack) = stack else { return offers };
    // ItemStack.isEnchantable: enchantable component and no enchantments yet.
    // rust: if e.enchantable(&stack.item) == 0 || !stack.enchantments().is_empty() {
    // rust: return offers;
}
    // rust: let mut random = LegacyRandom::new(i64::from(seed));
    // rust: for i in 0..3 {
    // rust: offers.costs[i] = e.enchantment_cost(&mut random, i, bookcases, &stack.item);
    // rust: if offers.costs[i] < i as i32 + 1 {
    // rust: offers.costs[i] = 0;
}
}
    // rust: for i in 0..3 {
    // rust: offers.clues[i] = enchant_clue(e, items, seed, i, offers.costs[i], stack);
}
    // rust: offers
}
/// `EnchantmentMenu.slotsChanged`'s clue for offer `slot` at `cost`: one
/// enchantment of the list that cost would give, or None for no offer.
    // rust: pub fn enchant_clue(
    // rust: e: &Enchantments,
    // rust: items: &Items,
    // rust: seed: i32,
    // rust: slot: usize,
    // rust: cost: i32,
    // rust: stack: &ItemStack,
    // rust: ) -> Option<(Arc<str>, u32)> {
    // rust: if cost <= 0 {
    // rust: return None;
}
    // getEnchantmentList reseeds the menu random; the clue draws continue from it.
    // rust: let mut list_random = LegacyRandom::new(i64::from(seed.wrapping_add(slot as i32)));
    // rust: let pool = e.tag("minecraft:in_enchanting_table").to_vec();
    // rust: let mut list = e.select(items, &mut list_random, &stack.item, cost, &pool);
    // rust: if &*stack.item == "minecraft:book" && list.len() > 1 {
    // rust: let r = list_random.next_int_bound(list.len() as i32).unwrap_or(0) as usize;
    // rust: list.remove(r);
}
    // rust: if list.is_empty() {
    // rust: return None;
}
    // rust: let pick = list_random.next_int_bound(list.len() as i32).unwrap_or(0) as usize;
    // rust: Some(list[pick].clone())
}
/// `EnchantmentMenu.clickMenuButton` result: the enchanted item, or None.
    // rust: pub fn apply_enchantment(
    // rust: e: &Enchantments,
    // rust: items: &Items,
    // rust: seed: i32,
    // rust: slot: usize,
    // rust: cost: i32,
    // rust: stack: &ItemStack,
    // rust: ) -> Option<ItemStack> {
    // rust: let list = enchantment_list(e, items, seed, slot, cost, &stack.item);
    // rust: if list.is_empty() {
    // rust: return None;
}
    // rust: let mut out = if &*stack.item == "minecraft:book" {
    // rust: stack.transmute("minecraft:enchanted_book", stack.count)
    // rust: } else {
    // rust: stack.clone()
}
    // rust: for (id, level) in list {
    // rust: out.enchant(&id, level);
}
    // rust: Some(out)
}

// ---------------------------------------------------------------- anvil

pub const AnvilResult = struct {
    result: ?ItemStack,
    /// Level cost (the `cost` data slot).
    cost: i32,
    /// Material items consumed from the second slot on take.
    repair_item_count_cost: u32,
    only_renaming: bool,
};
/// `ItemStack.isDamageableItem`: durability, and not `minecraft:unbreakable`.
pub fn is_damageable(items: *Items, stack: *ItemStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: items.get(&stack.item).is_some_and(|i| i.max_damage > 0)
    // rust: && stack
    // rust: .data()
    // rust: .is_none_or(|d| d.other("minecraft:unbreakable").is_none())
}
pub fn max_damage(items: *Items, stack: *ItemStack) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: items.get(&stack.item).map_or(0, |i| i.max_damage as i32)
}
/// `ItemStack.isValidRepairItem`.
    // rust: pub fn is_valid_repair_item(
    // rust: e: &Enchantments,
    // rust: items: &Items,
    // rust: stack: &ItemStack,
    // rust: material: &ItemStack,
    // rust: ) -> bool {
    // rust: e.props(&stack.item)
    // rust: .is_some_and(|p| Enchantments::item_in(items, &p.repairable, &material.item))
}
/// `AnvilMenu.calculateIncreasedRepairCost`.
pub fn increased_repair_cost(cost: u32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (u64::from(cost) * 2 + 1).min(i32::MAX as u64) as u32
}
/// The display name the rename box starts with (`getHoverName`).
pub fn hover_name(names: *dyn Fn([]const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: stack
    // rust: .custom_name()
    // rust: .or_else(|| stack.item_name())
    // rust: .unwrap_or_else(|| names(&stack.item))
}
/// `AnvilMenu.createResult`. `name` is the rename box text (None = untouched).
    // rust: pub fn anvil_result(
    // rust: e: &Enchantments,
    // rust: items: &Items,
    // rust: input: Option<&ItemStack>,
    // rust: addition: Option<&ItemStack>,
    // rust: name: Option<&str>,
    // rust: hover_name: &str,
    // rust: creative: bool,
    // rust: ) -> AnvilResult {
    // rust: let fail = AnvilResult::default();
    // rust: let Some(input) = input else { return fail };
    // EnchantmentHelper.canStoreEnchantments: enchantable or enchanted book... every
    // item with an enchantments component, which is all of them in 26.3.
    // rust: let mut result = input.clone();
    // rust: let mut enchantments: Levels = input.crafting_enchantments().to_vec();
    // rust: let mut price: i64 = 0;
    // rust: let tax: i64 =
    // rust: i64::from(input.repair_cost()) + i64::from(addition.map_or(0, ItemStack::repair_cost));
    // rust: let mut repair_item_count_cost = 0;
    // rust: let mut naming_cost = 0;
    // rust: if let Some(addition) = addition {
        // addition.has(STORED_ENCHANTMENTS): an enchanted book (its default
        // component), or any item given stored enchantments.
    // rust: let using_book = &*addition.item == "minecraft:enchanted_book"
    // rust: || !addition.stored_enchantments().is_empty();
    // rust: if is_damageable(items, &result) && is_valid_repair_item(e, items, input, addition) {
    // rust: let max = max_damage(items, &result);
    // rust: let mut repair = (result.damage as i32).min(max / 4);
    // rust: if repair <= 0 {
    // rust: return fail;
}
    // rust: let mut count = 0;
    // rust: while repair > 0 && count < addition.count {
    // rust: result.damage = (result.damage as i32 - repair) as u32;
    // rust: price += 1;
    // rust: repair = (result.damage as i32).min(max / 4);
    // rust: count += 1;
}
    // rust: repair_item_count_cost = count;
    // rust: } else {
    // rust: if !using_book && (result.item != addition.item || !is_damageable(items, &result)) {
    // rust: return fail;
}
    // rust: if is_damageable(items, &result) && !using_book {
    // rust: let max = max_damage(items, &result);
    // rust: let remaining1 = max - input.damage as i32;
    // rust: let remaining2 = max_damage(items, addition) - addition.damage as i32;
    // rust: let additional = remaining2 + max * 12 / 100;
    // rust: let remaining = remaining1 + additional;
    // rust: let damage = (max - remaining).max(0);
    // rust: if damage < result.damage as i32 {
    // rust: result.damage = damage as u32;
    // rust: price += 2;
}
}
    // rust: let mut any_compatible = false;
    // rust: let mut any_incompatible = false;
    // rust: for (id, level) in addition.crafting_enchantments() {
    // rust: let current = enchantments
    // rust: .iter()
    // rust: .find(|(x, _)| x == id)
    // rust: .map_or(0, |(_, l)| *l);
    // rust: let mut level = if current == *level {
    // rust: level + 1
    // rust: } else {
    // rust: (*level).max(current)
}
    // rust: let Some(def) = e.get(id) else { continue };
    // rust: let mut compatible = e.can_enchant(items, id, &input.item);
    // rust: if creative || &*input.item == "minecraft:enchanted_book" {
    // rust: compatible = true;
}
    // rust: for (other, _) in &enchantments {
    // rust: if other != id && !e.compatible(id, other) {
    // rust: compatible = false;
    // rust: price += 1;
}
}
    // rust: if !compatible {
    // rust: any_incompatible = true;
    // rust: } else {
    // rust: any_compatible = true;
    // rust: level = level.min(def.max_level);
    // rust: item_data::set_level(&mut enchantments, id, level);
    // rust: let mut fee = def.anvil_cost as i64;
    // rust: if using_book {
    // rust: fee = (fee / 2).max(1);
}
    // rust: price += fee * i64::from(level);
    // rust: if input.count > 1 {
    // rust: price = 40;
}
}
}
    // rust: if any_incompatible && !any_compatible {
    // rust: return fail;
}
}
}
    // rust: match name {
    // rust: Some(n) if !n.trim().is_empty() => {
    // rust: if n != hover_name {
    // rust: naming_cost = 1;
    // rust: price += 1;
    // rust: result.data_mut().custom_name = Some(horizon_world::nbt::Tag::String(n.into()));
}
}
    // rust: _ => {
    // rust: if input.custom_name().is_some() {
    // rust: naming_cost = 1;
    // rust: price += 1;
    // rust: result.data_mut().custom_name = None;
}
}
}
    // rust: let mut cost = if price <= 0 {
    // rust: 0
    // rust: } else {
    // rust: (tax + price).clamp(0, i64::from(i32::MAX)) as i32
}
    // rust: let mut out = (price > 0).then_some(result);
    // rust: let mut only_renaming = false;
    // rust: if naming_cost == price && naming_cost > 0 {
    // rust: if cost >= 40 {
    // rust: cost = 39;
}
    // rust: only_renaming = true;
}
    // rust: if cost >= 40 && !creative {
    // rust: out = None;
}
    // rust: if let Some(r) = out.as_mut() {
    // rust: let mut base = r
    // rust: .repair_cost()
    // rust: .max(addition.map_or(0, ItemStack::repair_cost));
    // rust: if naming_cost != price || naming_cost == 0 {
    // rust: base = increased_repair_cost(base);
}
    // rust: r.data_mut().repair_cost = base;
    // rust: r.set_crafting_enchantments(enchantments);
    // rust: r.tidy();
}
    // rust: AnvilResult {
    // rust: result: out,
    // rust: cost,
    // rust: repair_item_count_cost,
    // rust: only_renaming,
}
}

// ---------------------------------------------------------------- grindstone

/// `GrindstoneMenu` slot filter: damageable or enchanted.
pub fn grindstone_accepts(items: *Items, stack: *ItemStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: is_damageable(items, stack) || stack.has_any_enchantments()
}
pub fn remove_non_curses(e: *Enchantments, mut item: ItemStack) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let kept: Levels = item
    // rust: .crafting_enchantments()
    // rust: .iter()
    // rust: .filter(|(id, _)| e.is_curse(id))
    // rust: .cloned()
    // rust: .collect();
    // rust: let n = kept.len();
    // rust: item.set_crafting_enchantments(kept);
    // rust: if &*item.item == "minecraft:enchanted_book" && item.stored_enchantments().is_empty() {
    // rust: item = item.transmute("minecraft:book", item.count);
}
    // rust: let mut cost = 0;
    // rust: for _ in 0..n {
    // rust: cost = increased_repair_cost(cost);
}
    // rust: item.data_mut().repair_cost = cost;
    // rust: item.tidy();
    // rust: item
}
/// `GrindstoneMenu.computeResult`.
    // rust: pub fn grindstone_result(
    // rust: e: &Enchantments,
    // rust: items: &Items,
    // rust: input: Option<&ItemStack>,
    // rust: additional: Option<&ItemStack>,
    // rust: ) -> Option<ItemStack> {
    // rust: if input.is_none() && additional.is_none() {
    // rust: return None;
}
    // rust: if input.is_some_and(|s| s.count > 1) || additional.is_some_and(|s| s.count > 1) {
    // rust: return None;
}
    // rust: match (input, additional) {
    // rust: (Some(a), Some(b)) => {
    // rust: if a.item != b.item {
    // rust: return None;
}
    // rust: let durability = max_damage(items, a).max(max_damage(items, b));
    // rust: let remaining = (max_damage(items, a) - a.damage as i32)
    // rust: + (max_damage(items, b) - b.damage as i32)
    // rust: + durability * 5 / 100;
    // rust: let mut count = 1;
    // rust: if !is_damageable(items, a) {
    // rust: let stack_max = items.get(&a.item).map_or(64, |i| i.max_stack);
    // rust: if stack_max < 2 || a != b {
    // rust: return None;
}
    // rust: count = 2;
}
    // rust: let mut out = ItemStack { count, ..a.clone() };
    // rust: if is_damageable(items, &out) {
    // rust: out.damage = (durability - remaining).max(0) as u32;
}
            // mergeEnchantsFrom
    // rust: let mut levels = out.crafting_enchantments().to_vec();
    // rust: for (id, l) in b.crafting_enchantments() {
    // rust: if !e.is_curse(id) || !levels.iter().any(|(x, _)| x == id) {
    // rust: item_data::upgrade(&mut levels, id, *l);
}
}
    // rust: out.set_crafting_enchantments(levels);
    // rust: Some(remove_non_curses(e, out))
}
    // rust: (Some(s), None) | (None, Some(s)) => s
    // rust: .has_any_enchantments()
    // rust: .then(|| remove_non_curses(e, s.clone())),
    // rust: (None, None) => None,
}
}
/// The grindstone result slot's `getExperienceAmount` before its roll: the
/// minimum costs of the inputs' non-curse enchantments.
    // rust: pub fn grindstone_xp_base(
    // rust: e: &Enchantments,
    // rust: input: Option<&ItemStack>,
    // rust: additional: Option<&ItemStack>,
    // rust: ) -> i32 {
    // rust: let from = |s: Option<&ItemStack>| -> i32 {
    // rust: s.map_or(0, |s| {
    // rust: s.crafting_enchantments()
    // rust: .iter()
    // rust: .filter(|(id, _)| !e.is_curse(id))
    // rust: .map(|(id, l)| e.get(id).map_or(0, |d| d.min_cost.calculate(*l)))
    // rust: .sum()
    // rust: })
}
    // rust: from(input) + from(additional)
}
/// `getExperienceAmount`'s roll of the sum: `half + nextInt(half)`.
pub fn grindstone_xp_roll(amount: i32, random: *mut LegacyRandom) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if amount > 0 {
    // rust: let half = (f64::from(amount) / 2.0).ceil() as i32;
    // rust: (half + random.next_int_bound(half).unwrap_or(0)) as u32
    // rust: } else {
    // rust: 0
}
}
/// Experience from the grindstone result slot's `getExperienceAmount`.
    // rust: pub fn grindstone_experience(
    // rust: e: &Enchantments,
    // rust: random: &mut LegacyRandom,
    // rust: input: Option<&ItemStack>,
    // rust: additional: Option<&ItemStack>,
    // rust: ) -> u32 {
    // rust: grindstone_xp_roll(grindstone_xp_base(e, input, additional), random)
}

// ---------------------------------------------------------------- smithing & stonecutting

pub const Smithing = enum {
    Transform {,
    id: String,
    template: Ingredient,
    base: Ingredient,
    addition: Ingredient,
    result: String,
    // rust: },
    Trim {,
    id: String,
    template: Ingredient,
    base: Ingredient,
    addition: Ingredient,
    pattern: String,
    // rust: },
};
pub const Stonecutting = struct {
    id: []const u8,
    input: Ingredient,
    result: ItemStack,
};
pub const StationRecipes = struct {
    smithing: std.ArrayList(Smithing),
    /// Sorted by recipe id, the registry order vanilla lists them in.
    stonecutting: std.ArrayList(Stonecutting),
    /// `trim_material` registry: id -> (asset name, description).
    trim_materials: Vec<([]const u8,
};
pub fn ingredient(v: *Value, items: *Items) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ingredient::parse(v, items).unwrap_or_else(|| Ingredient::of(Vec::new()))
}
    // rust: impl StationRecipes {
pub fn load(root: *Path, items: *Items, overlay: *PackOverlay) S {
    // Implementation ported from Horizon
    return undefined;
}
        // Vanilla's recipes, then the content mods' (docs/modpacks.md).
    // rust: let mut files = Vec::new();
    // rust: let namespaces =
    // rust: std::iter::once("minecraft".to_owned()).chain(crate::mod_content::namespaces(root));
        // NeoForge's load conditions: a file whose don't hold is silently
        // absent (`mod_loaded` asks which mods' data is in this root).
    // rust: let mods: Vec<String> = {
    // rust: let mut mods = horizon_items::content_namespaces::mod_ids(root);
    // rust: if !mods.iter().any(|m| m == "minecraft") {
    // rust: mods.push("minecraft".to_owned());
}
    // rust: mods
}
    // rust: let conditions_hold = |v: &Value| {
    // rust: horizon_world::conditions::conditions_hold(v, &|id: &str| mods.iter().any(|m| m == id))
}
    // rust: for namespace in namespaces {
    // rust: let dir = root.join(format!("data/{namespace}/recipe"));
    // rust: if let Ok(folder) = crate::json_folder::read(&dir) {
    // rust: files.push((namespace, folder));
}
}
    // rust: let mut sources: Vec<(String, Value)> = files
    // rust: .iter()
    // rust: .flat_map(|(namespace, folder)| folder.files.iter().map(move |f| (namespace, f)))
    // rust: .filter_map(|(namespace, file)| {
    // rust: let v = serde_json::from_slice::<Value>(file.bytes().ok()?).ok()?;
    // rust: Some((format!("{namespace}:{}", file.name), v))
    // rust: })
    // rust: .collect();
        // The world's packs' recipes over the game's own: the top pack's
        // file for each id replaces it (`SimpleJsonResourceReloadListener`).
        // The gate answers the merged file, as the crafting loader's does:
        // a false-conditioned pack file leaves the lower one gone too.
    // rust: for (id, files) in overlay.kind("recipe") {
    // rust: let Ok(v) = serde_json::from_slice::<Value>(PackOverlay::top(files)) else {
    // rust: continue;
}
    // rust: match sources.iter_mut().find(|(n, _)| n == id) {
    // rust: Some(slot) => slot.1 = v,
    // rust: None => sources.push((id.to_owned(), v)),
}
}
        // The data's recipe filters, over the final set.
    // rust: let filters = horizon_items::recipe_filters::RecipeFilters::load(root, overlay);
    // rust: sources.retain_mut(|(id, v)| conditions_hold(v) && filters.apply(id, v));
        // Registration order, not the game's files before the packs': the
        // stonecutter lists its recipes in it and smithing takes the first match.
    // rust: sources.sort_by_cached_key(|(id, _)| crate::crafting::registration_key(id));
    // rust: let mut smithing = Vec::new();
    // rust: let mut stonecutting = Vec::new();
    // rust: for (id, v) in sources {
    // rust: match v["type"].as_str().unwrap_or("") {
    // rust: "minecraft:smithing_transform" => smithing.push(Smithing::Transform {
    // rust: id,
    // rust: template: ingredient(&v["template"], items),
    // rust: base: ingredient(&v["base"], items),
    // rust: addition: ingredient(&v["addition"], items),
    // rust: result: horizon_world::loot::recipe_result_id(&v["result"])
    // rust: .unwrap_or("minecraft:air")
    // rust: .to_owned(),
    // rust: }),
    // rust: "minecraft:smithing_trim" => smithing.push(Smithing::Trim {
    // rust: id,
    // rust: template: ingredient(&v["template"], items),
    // rust: base: ingredient(&v["base"], items),
    // rust: addition: ingredient(&v["addition"], items),
    // rust: pattern: v["pattern"].as_str().unwrap_or("").to_owned(),
    // rust: }),
    // rust: "minecraft:stonecutting" => {
                    // A result count outside 1..=99 fails vanilla's codec: no recipe.
    // rust: if let Some(count) = crate::crafting::template_count(&v["result"]) {
    // rust: stonecutting.push(Stonecutting {
    // rust: id,
    // rust: input: ingredient(&v["ingredient"], items),
    // rust: result: ItemStack::new(
    // rust: horizon_world::loot::recipe_result_id(&v["result"])
    // rust: .unwrap_or("minecraft:air"),
    // rust: count,
    // rust: ),
    // rust: });
}
}
    // rust: _ => {}
}
}
    // rust: let mut trim_materials = Vec::new();
    // rust: let mut tm: Vec<_> = fs::read_dir(root.join("data/minecraft/trim_material"))
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .flatten()
    // rust: .map(|e| e.path())
    // rust: .collect();
    // rust: tm.sort();
    // rust: for p in tm {
    // rust: if let Ok(bytes) = fs::read(&p)
    // rust: && let Ok(v) = serde_json::from_slice::<Value>(&bytes)
    // rust: {
    // rust: let id = format!(
    // rust: "minecraft:{}",
    // rust: p.file_stem().and_then(|s| s.to_str()).unwrap_or("")
    // rust: );
    // rust: trim_materials.push((
    // rust: id,
    // rust: v["description"]["translate"]
    // rust: .as_str()
    // rust: .unwrap_or("")
    // rust: .to_owned(),
    // rust: ));
}
}
    // rust: Self {
    // rust: smithing,
    // rust: stonecutting,
    // rust: trim_materials,
}
}
    /// Recipes whose input accepts `stack`, in display order.
pub fn stonecutter(self: *Self, stack: *ItemStack) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.stonecutting
    // rust: .iter()
    // rust: .filter(|r| r.input.test(stack))
    // rust: .collect()
}
pub fn slot_ok(self: *Self, slot: usize, stack: *ItemStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.smithing.iter().any(|r| {
    // rust: let (t, b, a) = match r {
    // rust: Smithing::Transform {
    // rust: template,
    // rust: base,
    // rust: addition,
    // rust: ..
}
    // rust: | Smithing::Trim {
    // rust: template,
    // rust: base,
    // rust: addition,
    // rust: ..
    // rust: } => (template, base, addition),
}
    // rust: [t, b, a][slot].test(stack)
    // rust: })
}
    /// `RecipePropertySet` SMITHING_TEMPLATE / BASE / ADDITION.
pub fn smithing_accepts(self: *Self, slot: usize, stack: *ItemStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: slot < 3 && self.slot_ok(slot, stack)
}
    /// `SmithingMenu.createResult`.
    // rust: pub fn smithing_result(
    // rust: &self,
    // rust: e: &Enchantments,
    // rust: template: Option<&ItemStack>,
    // rust: base: Option<&ItemStack>,
    // rust: addition: Option<&ItemStack>,
    // rust: ) -> Option<ItemStack> {
    // rust: self.smithing_recipe(e, template, base, addition)
    // rust: .map(|(_, result)| result)
}
    /// `SmithingMenu.createResult` with the id of the recipe that made the result.
    // rust: pub fn smithing_recipe(
    // rust: &self,
    // rust: e: &Enchantments,
    // rust: template: Option<&ItemStack>,
    // rust: base: Option<&ItemStack>,
    // rust: addition: Option<&ItemStack>,
    // rust: ) -> Option<(&str, ItemStack)> {
    // rust: let (template, base, addition) = (template?, base?, addition?);
    // rust: for r in &self.smithing {
    // rust: match r {
    // rust: Smithing::Transform {
    // rust: id,
    // rust: template: t,
    // rust: base: b,
    // rust: addition: a,
    // rust: result,
    // rust: } => {
    // rust: if t.test(template) && b.test(base) && a.test(addition) {
                        // SmithingTransformRecipe: transmute the base keeping its components.
    // rust: return Some((id.as_str(), base.transmute(result, 1)));
}
}
    // rust: Smithing::Trim {
    // rust: id,
    // rust: template: t,
    // rust: base: b,
    // rust: addition: a,
    // rust: pattern,
    // rust: ..
    // rust: } => {
    // rust: if t.test(template) && b.test(base) && a.test(addition) {
    // rust: return apply_trim(e, base, addition, pattern).map(|r| (id.as_str(), r));
}
}
}
}
    // rust: None
}
    /// `SmithingTrimDemoSlotDisplay.resolveForFirstStack` of a trim recipe:
    /// a random base trimmed with a random material (`pick(n)` draws below n).
    // rust: pub fn trim_demo(
    // rust: &self,
    // rust: e: &Enchantments,
    // rust: id: &str,
    // rust: pick: &mut dyn FnMut(usize) -> usize,
    // rust: ) -> Option<ItemStack> {
    // rust: let (base, addition, pattern) = self.smithing.iter().find_map(|r| match r {
    // rust: Smithing::Trim {
    // rust: id: i,
    // rust: base,
    // rust: addition,
    // rust: pattern,
    // rust: ..
    // rust: } if i == id => Some((&base.order, &addition.order, pattern)),
    // rust: _ => None,
    // rust: })?;
    // rust: if base.is_empty() || addition.is_empty() {
    // rust: return None;
}
        // applyDemoTransformation: up to 256 draws, the first that isn't empty.
    // rust: (0..256).find_map(|_| {
    // rust: let base = ItemStack::new(&base[pick(base.len())], 1);
    // rust: let material = ItemStack::new(&addition[pick(addition.len())], 1);
    // rust: apply_trim(e, &base, &material, pattern)
    // rust: })
}
}
/// `SmithingTrimRecipe.applyTrim`: none when the material provides no trim
/// or the base already has this one.
    // rust: fn apply_trim(
    // rust: e: &Enchantments,
    // rust: base: &ItemStack,
    // rust: material: &ItemStack,
    // rust: pattern: &str,
    // rust: ) -> Option<ItemStack> {
    // rust: let material = e.props(&material.item)?.trim_material.clone()?;
    // rust: let trim = (Arc::from(material.as_str()), Arc::from(pattern));
    // rust: if base.data().and_then(|d| d.trim.as_ref()) == Some(&trim) {
    // rust: return None;
}
    // rust: let mut out = ItemStack {
    // rust: count: 1,
    // rust: ..base.clone()
}
    // rust: out.data_mut().trim = Some(trim);
    // rust: Some(out)
}

    // rust: mod tests {
//     use super::*;
//     use crate::enchant::tests::{sample, sample_items};

pub fn sword(ench: *[([]const u8) void {
}
    // rust: let mut s = ItemStack::new("minecraft:diamond_sword", 1);
    // rust: for (id, l) in ench {
    // rust: s.enchant(id, *l);
}
    // rust: s
}
pub fn book(ench: *[([]const u8) void {
}
    // rust: let mut s = ItemStack::new("minecraft:enchanted_book", 1);
    // rust: for (id, l) in ench {
    // rust: s.enchant(id, *l);
}
    // rust: s
}

pub fn bookshelf_ring_has_32_positions() void {
}
    // rust: let o = bookshelf_offsets();
    // rust: assert_eq!(o.len(), 32);
    // rust: assert!(o.contains(&[-2, 0, -2]) && o.contains(&[2, 1, 0]) && !o.contains(&[1, 0, 1]));
}

pub fn enchant_offers_are_deterministic_per_seed() void {
}
    // rust: let e = sample();
    // rust: let items = sample_items();
    // rust: let s = ItemStack::new("minecraft:diamond_sword", 1);
    // rust: let a = enchant_offers(&e, &items, 1234, 15, Some(&s));
    // rust: let b = enchant_offers(&e, &items, 1234, 15, Some(&s));
    // rust: assert_eq!(a, b);
    // rust: assert_eq!(a.costs[2], 30, "{a:?}");
    // rust: assert!(a.costs[0] >= 1 && a.costs[0] <= a.costs[2]);
        // The clue is the first offer's random pick from the same list.
    // rust: for slot in 0..3 {
    // rust: let list = enchantment_list(
    // rust: &e,
    // rust: &items,
    // rust: 1234,
    // rust: slot,
    // rust: a.costs[slot],
    // rust: "minecraft:diamond_sword",
    // rust: );
    // rust: let clue = a.clues[slot].clone().unwrap();
    // rust: assert!(list.contains(&clue));
    // rust: let applied = apply_enchantment(&e, &items, 1234, slot, a.costs[slot], &s).unwrap();
    // rust: assert_eq!(applied.enchantments(), &list[..]);
}
        // Already enchanted items are not enchantable.
    // rust: assert_eq!(
    // rust: enchant_offers(
    // rust: &e,
    // rust: &items,
    // rust: 1234,
    // rust: 15,
    // rust: Some(&sword(&[("minecraft:sharpness", 1)]))
    // rust: )
    // rust: .costs,
    // rust: [0, 0, 0]
    // rust: );
    // rust: let books =
    // rust: apply_enchantment(&e, &items, 99, 2, 30, &ItemStack::new("minecraft:book", 1)).unwrap();
    // rust: assert_eq!(&*books.item, "minecraft:enchanted_book");
    // rust: assert!(!books.stored_enchantments().is_empty());
}

pub fn anvil_combines_and_charges_like_vanilla() void {
}
    // rust: let e = sample();
    // rust: let items = sample_items();
        // Sharpness II + Sharpness II book = Sharpness III; book fee 1/2 -> max(1, 0) = 1 per level.
    // rust: let r = anvil_result(
    // rust: &e,
    // rust: &items,
    // rust: Some(&sword(&[("minecraft:sharpness", 2)])),
    // rust: Some(&book(&[("minecraft:sharpness", 2)])),
    // rust: None,
    // rust: "Diamond Sword",
    // rust: false,
    // rust: );
    // rust: let out = r.result.unwrap();
    // rust: assert_eq!(out.enchantment_level("minecraft:sharpness"), 3);
    // rust: assert_eq!(r.cost, 3);
    // rust: assert_eq!(out.repair_cost(), 1);
        // Incompatible only: no result.
    // rust: let r = anvil_result(
    // rust: &e,
    // rust: &items,
    // rust: Some(&sword(&[("minecraft:sharpness", 1)])),
    // rust: Some(&book(&[("minecraft:smite", 1)])),
    // rust: None,
    // rust: "Diamond Sword",
    // rust: false,
    // rust: );
    // rust: assert!(r.result.is_none());
        // Max level clamps: V + V stays V.
    // rust: let r = anvil_result(
    // rust: &e,
    // rust: &items,
    // rust: Some(&sword(&[("minecraft:sharpness", 5)])),
    // rust: Some(&book(&[("minecraft:sharpness", 5)])),
    // rust: None,
    // rust: "x",
    // rust: false,
    // rust: );
    // rust: assert_eq!(
    // rust: r.result.unwrap().enchantment_level("minecraft:sharpness"),
    // rust: 5
    // rust: );
    // rust: assert_eq!(r.cost, 5);
}

pub fn anvil_rename_and_prior_work() void {
}
    // rust: let e = sample();
    // rust: let items = sample_items();
    // rust: let mut s = sword(&[]);
    // rust: s.data_mut().repair_cost = 7;
    // rust: let r = anvil_result(
    // rust: &e,
    // rust: &items,
    // rust: Some(&s),
    // rust: None,
    // rust: Some("Excalibur"),
    // rust: "Diamond Sword",
    // rust: false,
    // rust: );
    // rust: assert_eq!(r.cost, 8);
    // rust: assert!(r.only_renaming);
    // rust: let out = r.result.unwrap();
    // rust: assert_eq!(out.custom_name().as_deref(), Some("Excalibur"));
        // Renaming alone does not raise the penalty.
    // rust: assert_eq!(out.repair_cost(), 7);
        // Same name: nothing to do.
    // rust: assert!(
    // rust: anvil_result(
    // rust: &e,
    // rust: &items,
    // rust: Some(&s),
    // rust: None,
    // rust: Some("Diamond Sword"),
    // rust: "Diamond Sword",
    // rust: false
    // rust: )
    // rust: .result
    // rust: .is_none()
    // rust: );
        // Too expensive at 40+ unless creative; rename-only caps at 39.
    // rust: s.data_mut().repair_cost = 63;
    // rust: let r = anvil_result(
    // rust: &e,
    // rust: &items,
    // rust: Some(&s),
    // rust: None,
    // rust: Some("A"),
    // rust: "Diamond Sword",
    // rust: false,
    // rust: );
    // rust: assert_eq!(r.cost, 39);
    // rust: assert!(r.result.is_some());
    // rust: let r = anvil_result(
    // rust: &e,
    // rust: &items,
    // rust: Some(&s),
    // rust: Some(&book(&[("minecraft:unbreaking", 1)])),
    // rust: None,
    // rust: "Diamond Sword",
    // rust: false,
    // rust: );
    // rust: assert!(r.cost >= 40 && r.result.is_none());
    // rust: assert!(
    // rust: anvil_result(
    // rust: &e,
    // rust: &items,
    // rust: Some(&s),
    // rust: Some(&book(&[("minecraft:unbreaking", 1)])),
    // rust: None,
    // rust: "Diamond Sword",
    // rust: true
    // rust: )
    // rust: .result
    // rust: .is_some()
    // rust: );
    // rust: assert_eq!(increased_repair_cost(0), 1);
    // rust: assert_eq!(increased_repair_cost(3), 7);
}

    /// Checks against the prepared vanilla resources when they are present.
pub fn prepared_vanilla_data() void {
}
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("items.json").exists() {
    // rust: return;
}
    // rust: let items = Items::tags_only(&root, &PackOverlay::NONE).unwrap();
    // rust: let data = StationData::load(&root, &items, &PackOverlay::NONE);
    // rust: let e = &data.enchantments;
    // rust: assert_eq!(e.list.len(), 43);
    // rust: assert_eq!(
    // rust: &*e.tag("minecraft:in_enchanting_table")[0],
    // rust: "minecraft:protection"
    // rust: );
    // rust: assert!(!e.compatible("minecraft:fortune", "minecraft:silk_touch"));
    // rust: assert!(e.is_curse("minecraft:binding_curse"));
    // rust: assert_eq!(e.full_name("minecraft:sharpness", 5).0, "Sharpness V");
    // rust: assert_eq!(e.enchantable("minecraft:golden_sword"), 22);
        // Brewing: water + nether wart = awkward.
    // rust: assert_eq!(data.brewing.recipes.len(), 279);
    // rust: let water = ItemStack::new("minecraft:potion", 1).with_potion("minecraft:water");
    // rust: let r = data
    // rust: .brewing
    // rust: .find(&water, &ItemStack::new("minecraft:nether_wart", 1))
    // rust: .unwrap();
    // rust: assert_eq!(r.output.potion(), Some("minecraft:awkward"));
    // rust: assert!(
    // rust: data.brewing
    // rust: .is_reagent(&ItemStack::new("minecraft:blaze_powder", 1))
    // rust: );
        // Smithing: netherite upgrade keeps enchantments.
    // rust: let mut sword = ItemStack::new("minecraft:diamond_sword", 1);
    // rust: sword.enchant("minecraft:sharpness", 2);
    // rust: let out = data
    // rust: .recipes
    // rust: .smithing_result(
    // rust: e,
    // rust: Some(&ItemStack::new(
    // rust: "minecraft:netherite_upgrade_smithing_template",
    // rust: 1,
    // rust: )),
    // rust: Some(&sword),
    // rust: Some(&ItemStack::new("minecraft:netherite_ingot", 1)),
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: (&*out.item, out.enchantment_level("minecraft:sharpness")),
    // rust: ("minecraft:netherite_sword", 2)
    // rust: );
    // rust: assert!(
    // rust: data.recipes
    // rust: .stonecutter(&ItemStack::new("minecraft:stone", 1))
    // rust: .len()
    // rust: >= 10
    // rust: );
        // Trades: every profession level set yields offers.
    // rust: let ctx = crate::merchant::TradeContext {
    // rust: items: &items,
    // rust: enchantments: e,
    // rust: variant: "minecraft:plains",
    // rust: origin: [0.0; 3],
    // rust: maps: None,
}
    // rust: for p in crate::merchant::PROFESSIONS {
    // rust: let set = crate::merchant::Trades::set_for(p, 1);
    // rust: let mut random = crate::merchant::sequence_random(
    // rust: 12345,
    // rust: &format!(
    // rust: "minecraft:trade_set/{}",
    // rust: set.trim_start_matches("minecraft:")
    // rust: ),
    // rust: );
    // rust: assert!(
    // rust: !data
    // rust: .trades
    // rust: .offers_from_set(&ctx, &set, &mut random)
    // rust: .is_empty(),
    // rust: "{p}"
    // rust: );
}
}

pub fn grindstone_strips_non_curses() void {
}
    // rust: let e = sample();
    // rust: let items = sample_items();
    // rust: let s = sword(&[("minecraft:sharpness", 3)]);
    // rust: let out = grindstone_result(&e, &items, Some(&s), None).unwrap();
    // rust: assert!(out.enchantments().is_empty());
    // rust: assert_eq!(out.repair_cost(), 0);
    // rust: assert!(out.extra.is_none());
    // rust: let b =
    // rust: grindstone_result(&e, &items, None, Some(&book(&[("minecraft:mending", 1)]))).unwrap();
    // rust: assert_eq!(&*b.item, "minecraft:book");
    // rust: assert!(grindstone_result(&e, &items, Some(&sword(&[])), None).is_none());
    // rust: let mut r = LegacyRandom::new(5);
        // min cost of Sharpness III = 23; ceil(23/2)=12 -> 12..23.
    // rust: let xp = grindstone_experience(&e, &mut r, Some(&s), None);
    // rust: assert!((12..24).contains(&xp));
}
pub fn smithing_ingredient_parses_holders() void {
}
    // rust: let items = sample_items();
    // rust: let a = ingredient(&serde_json::json!("minecraft:diamond_sword"), &items);
    // rust: assert_eq!(a.order, vec!["minecraft:diamond_sword"]);
    // rust: let b = ingredient(
    // rust: &serde_json::json!(["minecraft:diamond_sword", "minecraft:diamond_axe"]),
    // rust: &items,
    // rust: );
    // rust: assert_eq!(
    // rust: b.order,
    // rust: vec!["minecraft:diamond_sword", "minecraft:diamond_axe"]
    // rust: );
}
    /// A world pack's stonecutting recipe takes its place in registration
    /// order (path, then namespace), not a place after the game's own.
pub fn stonecutter_lists_recipes_in_registration_order() void {
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-stonecutter-order-{}", std::process::id()));
    // rust: let dir = root.join("data/minecraft/recipe");
    // rust: fs::create_dir_all(&dir).unwrap();
    // rust: let cut = |result: &str| {
    // rust: format!(
    // rust: r#"{{"type":"minecraft:stonecutting","ingredient":"minecraft:stone","result":{{"id":"{result}"}}}}"#
    // rust: )
}
    // rust: fs::write(dir.join("z_cut.json"), cut("minecraft:stone_slab")).unwrap();
    // rust: fs::write(dir.join("b_cut.json"), cut("minecraft:stone_bricks")).unwrap();
    // rust: let packs = [(
    // rust: "recipe/pack:a_cut".to_owned(),
    // rust: vec![cut("minecraft:stone_stairs").into_bytes()],
    // rust: )];
    // rust: let recipes = StationRecipes::load(&root, &sample_items(), &PackOverlay { files: &packs });
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: let listed: Vec<_> = recipes
    // rust: .stonecutter(&ItemStack::new("minecraft:stone", 1))
    // rust: .iter()
    // rust: .map(|r| (r.id.as_str(), &*r.result.item))
    // rust: .collect();
    // rust: assert_eq!(
    // rust: listed,
    // rust: [
    // rust: ("pack:a_cut", "minecraft:stone_stairs"),
    // rust: ("minecraft:b_cut", "minecraft:stone_bricks"),
    // rust: ("minecraft:z_cut", "minecraft:stone_slab"),
    // rust: ]
    // rust: );
}
}
