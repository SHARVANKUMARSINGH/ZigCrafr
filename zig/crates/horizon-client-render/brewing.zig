//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_brewing
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Potions and the brewing stand: the `Potions` / `MobEffects` registries (code
//! in vanilla, ported as tables), data-driven `minecraft:brewing` recipes from
//! `data/minecraft/recipe/brewing`, potion colours and tooltips, and
//! `BrewingStandBlockEntity.serverTick`.
    // rust: pub use crate::chunk::block_entity::BrewingStand;
// use crate::{
    // rust: items::{ItemStack, Items},
    // rust: providers::Providers,
}
// use horizon_world::loot::PackOverlay;
// use serde_json::Value;
// use std::{collections::HashSet, path::Path};

    // rust: pub use horizon_client_core::potions::{
    // rust: BASE_POTION_COLOR, Category, EFFECTS, EffectDef, POTIONS, PotionDef, all_effects,
    // rust: description_id, effect, is_mod_effect, mod_effects, namespaced, potion, potion_color,
    // rust: register_mod_effects,
}
/// `MobEffectUtil.formatDuration` at 20 TPS.
pub fn format_duration(ticks: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: format_tick_duration(ticks, 20.0)
}
/// `StringUtil.formatTickDuration`: mm:ss, or hh:mm:ss from an hour up, every
/// field two digits.
pub fn format_tick_duration(ticks: i32, tick_rate: f32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let secs = (ticks as f32 / tick_rate).floor() as i32;
    // rust: let (h, m, s) = (secs / 3600, secs / 60 % 60, secs % 60);
    // rust: if h > 0 {
    // rust: format!("{h:02}:{m:02}:{s:02}")
    // rust: } else {
    // rust: format!("{m:02}:{s:02}")
}
}
/// `item.minecraft.potion.effect.<name>` style translation key for a potion item.
pub fn potion_name_key(item: []const u8, potion: ?[]const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let prefix = item.trim_start_matches("minecraft:");
    // rust: let suffix = potion.and_then(self::potion).map_or("empty", |p| p.name);
    // rust: format!("item.minecraft.{prefix}.effect.{suffix}")
}
/// `PotionContents.getAllEffects`: the potion's effects, then the stack's
/// `custom_effects` (id, duration, amplifier). Unknown effect ids are dropped.
pub fn contents_effects(stack: *ItemStack) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let potion = stack.potion().and_then(self::potion);
    // rust: let custom = stack.custom_potion_effects();
    // rust: potion
    // rust: .map_or(&[][..], |d| d.effects)
    // rust: .iter()
    // rust: .copied()
    // rust: .chain(
    // rust: custom
    // rust: .iter()
    // rust: .filter_map(|(id, duration, amp)| Some((effect(id)?.id, *duration, *amp))),
    // rust: )
    // rust: .collect()
}
/// Roman amplifier suffix (`potion.potency.N`) and duration lines of a potion.
    // rust: pub fn tooltip(
    // rust: potion: Option<&str>,
    // rust: scale: f32,
    // rust: translate: &dyn Fn(&str) -> Option<String>,
    // rust: ) -> Vec<(String, Category)> {
    // rust: let Some(def) = potion.and_then(self::potion) else {
    // rust: return vec![];
}
    // rust: if def.effects.is_empty() {
    // rust: return vec![(
    // rust: translate("effect.none").unwrap_or_else(|| "No Effects".into()),
    // rust: Category::Neutral,
    // rust: )];
}
    // rust: effect_lines(def.effects.iter().copied(), scale, translate)
}
/// `PotionContents.addPotionTooltip`'s line per effect: its name, potency and
/// scaled duration, for (effect id, duration, amplifier) entries.
    // rust: pub fn effect_lines<'a>(
    // rust: effects: impl IntoIterator<Item = (&'a str, i32, i32)>,
    // rust: scale: f32,
    // rust: translate: &dyn Fn(&str) -> Option<String>,
    // rust: ) -> Vec<(String, Category)> {
    // rust: effects
    // rust: .into_iter()
    // rust: .map(|(e, duration, amp)| {
    // rust: let e = e.trim_start_matches("minecraft:");
    // rust: let mut line = translate(&description_id(e)).unwrap_or_else(|| e.to_owned());
    // rust: if amp > 0 {
    // rust: line.push(' ');
    // rust: line.push_str(
    // rust: &translate(&format!("potion.potency.{amp}"))
    // rust: .unwrap_or_else(|| crate::enchant::level_name(amp as u32 + 1)),
    // rust: );
}
    // rust: let instant = effect(e).is_some_and(|d| d.instant);
    // rust: if !instant {
    // rust: if duration == -1 {
                    // MobEffectInstance.isInfiniteDuration: formatDuration says
                    // the infinite sign, not a time.
    // rust: line = format!(
    // rust: "{line} ({})",
    // rust: translate("effect.duration.infinite").unwrap_or_else(|| "∞".to_owned())
    // rust: );
    // rust: } else {
    // rust: let scaled = (duration as f32 * scale) as i32;
    // rust: if scaled > 20 {
    // rust: line = format!("{line} ({})", format_duration(scaled));
}
}
}
    // rust: (line, effect(e).map_or(Category::Neutral, |d| d.category))
    // rust: })
    // rust: .collect()
}

/// A `PotionIngredient`: item ids plus an optional potion filter.
pub const PotionIngredient = struct {
    items: std.AutoHashMap([]const u8, void),
    potions: ?std.AutoHashMap([]const u8, void),
};
    // rust: impl PotionIngredient {
pub fn parse(v: *Value, items: *Items) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut set = HashSet::new();
    // rust: let add = |s: &str, set: &mut HashSet<String>| match s.strip_prefix('#') {
    // rust: Some(tag) => set.extend(items.item_tags.get(tag).into_iter().flatten().cloned()),
    // rust: None => {
    // rust: set.insert(s.to_owned());
}
}
    // rust: match &v["item"] {
    // rust: Value::String(s) => add(s, &mut set),
    // rust: Value::Array(a) => a
    // rust: .iter()
    // rust: .filter_map(Value::as_str)
    // rust: .for_each(|s| add(s, &mut set)),
    // rust: _ => {}
}
    // rust: let potions = match &v["potion_contents"]["potions"] {
    // rust: Value::String(s) => Some([s.clone()].into_iter().collect()),
    // rust: Value::Array(a) => Some(
    // rust: a.iter()
    // rust: .filter_map(|x| x.as_str().map(str::to_owned))
    // rust: .collect(),
    // rust: ),
    // rust: _ => None,
}
    // rust: Self {
    // rust: items: set,
    // rust: potions,
}
}
pub fn test(self: *Self, stack: *ItemStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.items.contains(&*stack.item)
    // rust: && self
    // rust: .potions
    // rust: .as_ref()
    // rust: .is_none_or(|p| stack.potion().is_some_and(|x| p.contains(x)))
}
}
pub const BrewingRecipe = struct {
    id: []const u8,
    input: PotionIngredient,
    reagent: PotionIngredient,
    output: ItemStack,
};
pub const Brewing = struct {
    recipes: std.ArrayList(BrewingRecipe),
    /// `RecipePropertySet.BREWING_REAGENTS`.
    reagents: std.AutoHashMap([]const u8, void),
    /// Items accepted in the bottle slots (`PotionIngredient.isPotionInput`).
    inputs: std.AutoHashMap([]const u8, void),
};
/// The files right in `recipe/brewing/`, parsed, by id: taken from the whole
/// recipe folder's read when another table holds it (the start loads them
/// together), else read alone. A file that doesn't parse is left out.
pub fn brewing_sources(root: *Path) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let recipe = root.join("data/minecraft/recipe");
    // rust: let (folder, prefix) = match crate::json_folder::held(&recipe) {
    // rust: Some(folder) => (folder, "brewing/"),
    // rust: None => match crate::json_folder::read(&recipe.join("brewing")) {
    // rust: Ok(folder) => (folder, ""),
    // rust: Err(_) => return Vec::new(),
    // rust: },
}
    // rust: folder
    // rust: .files
    // rust: .iter()
    // rust: .filter_map(|f| {
    // rust: let name = f.name.strip_prefix(prefix).filter(|n| !n.contains('/'))?;
    // rust: let v = serde_json::from_slice::<Value>(f.bytes().ok()?).ok()?;
    // rust: Some((format!("minecraft:brewing/{name}"), v))
    // rust: })
    // rust: .collect()
}
    // rust: impl Brewing {
pub fn load(root: *Path, items: *Items, overlay: *PackOverlay) S {
    // Implementation ported from Horizon
    return undefined;
}
        // NeoForge's load conditions: a file whose don't hold is silently
        // absent. Vanilla's brewing recipes carry none; a pack's can.
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
    // rust: let mut sources: Vec<(String, Value)> = brewing_sources(root);
        // The world's packs' brewing recipes over the game's own: the top
        // pack's file for each id replaces it (`SimpleJsonResourceReloadListener`).
    // rust: for (id, files) in overlay.kind("recipe") {
    // rust: if !id.starts_with("minecraft:brewing/") {
    // rust: continue;
}
    // rust: let Ok(v) = serde_json::from_slice::<Value>(PackOverlay::top(files)) else {
    // rust: continue;
}
    // rust: match sources.iter_mut().find(|(n, _)| n == id) {
    // rust: Some(slot) => slot.1 = v,
    // rust: None => sources.push((id.to_owned(), v)),
}
}
        // The gate answers the merged file, as the crafting loader's does:
        // a false-conditioned pack file leaves the lower one gone too.
        // The data's recipe filters, over the final set.
    // rust: let filters = horizon_items::recipe_filters::RecipeFilters::load(root, overlay);
    // rust: sources.retain_mut(|(id, v)| conditions_hold(v) && filters.apply(id, v));
    // rust: sources.sort_by(|a, b| a.0.cmp(&b.0));
    // rust: let mut recipes = Vec::new();
    // rust: for (id, v) in sources {
    // rust: if v["type"] != "minecraft:brewing" {
    // rust: continue;
}
    // rust: let mut output = ItemStack::new(
    // rust: v["output"]["id"].as_str().unwrap_or("minecraft:potion"),
    // rust: v["output"]["count"].as_u64().unwrap_or(1) as u32,
    // rust: );
    // rust: if let Some(potion) =
    // rust: v["output"]["components"]["minecraft:potion_contents"]["potion"].as_str()
    // rust: {
    // rust: output = output.with_potion(potion);
}
    // rust: recipes.push(BrewingRecipe {
    // rust: id,
    // rust: input: PotionIngredient::parse(&v["input"], items),
    // rust: reagent: PotionIngredient::parse(&v["reagent"], items),
    // rust: output,
    // rust: });
}
    // rust: let reagents = recipes
    // rust: .iter()
    // rust: .flat_map(|r| r.reagent.items.iter().cloned())
    // rust: .collect();
    // rust: let inputs = recipes
    // rust: .iter()
    // rust: .flat_map(|r| r.input.items.iter().cloned())
    // rust: .chain(std::iter::once("minecraft:glass_bottle".to_owned()))
    // rust: .collect();
    // rust: Self {
    // rust: recipes,
    // rust: reagents,
    // rust: inputs,
}
}
pub fn find(self: *Self, input: *ItemStack, reagent: *ItemStack) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.recipes
    // rust: .iter()
    // rust: .find(|r| r.input.test(input) && r.reagent.test(reagent))
}
pub fn is_reagent(self: *Self, stack: *ItemStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.reagents.contains(&*stack.item)
}
pub fn is_bottle(self: *Self, stack: *ItemStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.inputs.contains(&*stack.item)
}
}

/// What a brewing tick asks the world to do.
pub const BrewTick = struct {
    /// New `has_bottle_0..2` block state values.
    bottles: Option<[bool,
    /// Level event 1035 (brew sound).
    brewed: bool,
    /// Remainders dropped at the stand.
    drops: std.ArrayList(ItemStack),
};
    // rust: impl BrewingStand {
pub fn new() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: total_brew_time: 400,
    // rust: total_fuel: 20,
    // rust: speed: 1.0,
    // rust: ..Default::default()
}
}
pub fn brewable(self: *Self, brewing: *Brewing) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(ingredient) = &self.items[3] else {
    // rust: return false;
}
    // rust: if !brewing.is_reagent(ingredient) {
    // rust: return false;
}
    // rust: self.items[..3]
    // rust: .iter()
    // rust: .flatten()
    // rust: .any(|b| brewing.find(b, ingredient).is_some())
}
    /// `BrewingStandBlockEntity.serverTick`.
pub fn tick(self: *Self, brewing: *Brewing, items: *Items, providers: *Providers) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = BrewTick::default();
    // rust: if self.fuel <= 0
    // rust: && let Some(fuel) = self.items[4].as_mut()
    // rust: && let Some((uses, speed)) = brewing_fuel(items, fuel)
    // rust: {
    // rust: self.fuel = providers.int_value(&uses);
    // rust: self.total_fuel = self.fuel;
    // rust: self.speed = providers.float_value(&speed, 1.0);
    // rust: let remainder = items.get(&fuel.item).and_then(|i| i.remainder.clone());
    // rust: fuel.count -= 1;
    // rust: if fuel.count == 0 {
    // rust: self.items[4] = remainder.map(|r| ItemStack::new(&r, 1));
    // rust: } else if let Some(r) = remainder {
    // rust: out.drops.push(ItemStack::new(&r, 1));
}
}
    // rust: let brewable = self.brewable(brewing);
    // rust: if self.brew_time > 0 {
    // rust: self.brew_time -= 1;
    // rust: let same = self.items[3].as_ref().map(|s| s.item.clone()) == self.ingredient;
    // rust: if self.brew_time == 0 && brewable {
    // rust: self.brew(brewing, items, &mut out);
    // rust: } else if !brewable || !same {
    // rust: self.brew_time = 0;
}
    // rust: } else if brewable && self.fuel > 0 {
    // rust: let speed = if self.speed > 0.0 { self.speed } else { 1.0 };
    // rust: self.fuel -= 1;
    // rust: self.brew_time = (400.0 / speed).ceil() as i32;
    // rust: self.total_brew_time = self.brew_time;
    // rust: self.ingredient = self.items[3].as_ref().map(|s| s.item.clone());
}
    // rust: let bottles = [
    // rust: self.items[0].is_some(),
    // rust: self.items[1].is_some(),
    // rust: self.items[2].is_some(),
    // rust: ];
    // rust: if self.last_bottles != Some(bottles) {
    // rust: self.last_bottles = Some(bottles);
    // rust: out.bottles = Some(bottles);
}
    // rust: out
}
pub fn idle(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let bottles = [
    // rust: self.items[0].is_some(),
    // rust: self.items[1].is_some(),
    // rust: self.items[2].is_some(),
    // rust: ];
    // rust: self.brew_time <= 0
    // rust: && self.items[3].is_none()
    // rust: && (self.fuel > 0 || self.items[4].is_none())
    // rust: && self.last_bottles == Some(bottles)
}
pub fn brew(self: *Self, brewing: *Brewing, items: *Items, out: *mut BrewTick) void {
}
    // rust: let Some(ingredient) = self.items[3].clone() else {
    // rust: return;
}
    // rust: for slot in 0..3 {
    // rust: if let Some(input) = &self.items[slot]
    // rust: && let Some(r) = brewing.find(input, &ingredient)
    // rust: {
    // rust: self.items[slot] = Some(r.output.clone());
}
}
    // rust: let remainder = items
    // rust: .get(&ingredient.item)
    // rust: .and_then(|i| i.remainder.clone());
    // rust: if let Some(i) = self.items[3].as_mut() {
    // rust: i.count -= 1;
    // rust: if i.count == 0 {
    // rust: self.items[3] = remainder.map(|r| ItemStack::new(&r, 1));
    // rust: } else if let Some(r) = remainder {
    // rust: out.drops.push(ItemStack::new(&r, 1));
}
}
    // rust: out.brewed = true;
}
}
/// The `minecraft:brewing_fuel` providers of an item: (uses, speed_multiplier).
pub fn brewing_fuel(items: *Items, stack: *ItemStack) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: items.get(&stack.item).and_then(|i| i.brewing_fuel.clone())
}

    // rust: mod tests {
//     use super::*;

pub fn potion_colours_and_names() void {
}
        // Swiftness: speed colour 3402751 = 0x33EBFF.
    // rust: assert_eq!(potion_color(Some("minecraft:swiftness")), 0x33EBFF);
    // rust: assert_eq!(potion_color(Some("minecraft:water")), BASE_POTION_COLOR);
        // Turtle master mixes slowness x4 and resistance x3.
    // rust: let (s, r) = (9154528u32, 9520880u32);
    // rust: let mix = |sh: u32| ((s >> sh & 255) * 4 + (r >> sh & 255) * 3) / 7;
    // rust: assert_eq!(
    // rust: potion_color(Some("minecraft:turtle_master")),
    // rust: mix(16) << 16 | mix(8) << 8 | mix(0)
    // rust: );
    // rust: assert_eq!(
    // rust: potion_name_key("minecraft:splash_potion", Some("minecraft:long_swiftness")),
    // rust: "item.minecraft.splash_potion.effect.swiftness"
    // rust: );
    // rust: assert_eq!(format_duration(9600), "08:00");
    // rust: assert_eq!(format_duration(450), "00:22");
    // rust: assert_eq!(format_duration(140), "00:07");
    // rust: assert_eq!(format_duration(1800), "01:30");
    // rust: assert_eq!(format_duration(72000), "01:00:00");
    // rust: assert_eq!(format_tick_duration(9600, 40.0), "04:00");
    // rust: let t = tooltip(Some("minecraft:strong_poison"), 1.0, &|_| None);
    // rust: assert_eq!(t[0].0, "poison II (00:21)");
    // rust: assert_eq!(POTIONS.len(), 46);
}

pub fn brewing_stand_brews_after_400_ticks() void {
}
    // rust: let mut item_tags = std::collections::HashMap::new();
    // rust: item_tags.insert("x".into(), HashSet::new());
    // rust: let items = Items::for_tests(item_tags);
    // rust: let recipe = BrewingRecipe {
    // rust: id: "awkward".into(),
    // rust: input: PotionIngredient {
    // rust: items: ["minecraft:potion".to_owned()].into_iter().collect(),
    // rust: potions: Some(["minecraft:water".to_owned()].into_iter().collect()),
    // rust: },
    // rust: reagent: PotionIngredient {
    // rust: items: ["minecraft:nether_wart".to_owned()].into_iter().collect(),
    // rust: potions: None,
    // rust: },
    // rust: output: ItemStack::new("minecraft:potion", 1).with_potion("minecraft:awkward"),
}
    // rust: let brewing = Brewing {
    // rust: reagents: ["minecraft:nether_wart".to_owned()].into_iter().collect(),
    // rust: inputs: HashSet::new(),
    // rust: recipes: vec![recipe],
}
    // rust: let providers = Providers::empty();
    // rust: let mut stand = BrewingStand::new();
    // rust: stand.fuel = 1;
    // rust: stand.items[0] = Some(ItemStack::new("minecraft:potion", 1).with_potion("minecraft:water"));
    // rust: stand.items[2] =
    // rust: Some(ItemStack::new("minecraft:potion", 1).with_potion("minecraft:awkward"));
    // rust: stand.items[3] = Some(ItemStack::new("minecraft:nether_wart", 2));
    // rust: let first = stand.tick(&brewing, &items, &providers);
    // rust: assert_eq!(first.bottles, Some([true, false, true]));
    // rust: assert_eq!((stand.brew_time, stand.fuel), (400, 0));
    // rust: let mut brewed_at = 0;
    // rust: for t in 1..=400 {
    // rust: if stand.tick(&brewing, &items, &providers).brewed {
    // rust: brewed_at = t;
}
}
    // rust: assert_eq!(brewed_at, 400);
    // rust: assert_eq!(
    // rust: stand.items[0].as_ref().unwrap().potion(),
    // rust: Some("minecraft:awkward")
    // rust: );
        // The awkward potion had no recipe and stays.
    // rust: assert_eq!(
    // rust: stand.items[2].as_ref().unwrap().potion(),
    // rust: Some("minecraft:awkward")
    // rust: );
    // rust: assert_eq!(stand.items[3].as_ref().unwrap().count, 1);
        // No fuel left: nothing more brews.
    // rust: stand.tick(&brewing, &items, &providers);
    // rust: assert_eq!(stand.brew_time, 0);
}

pub fn a_brewing_stand_is_idle_only_while_its_tick_changes_nothing() void {
}
    // rust: let mut stand = BrewingStand::new();
    // rust: assert!(!stand.idle());
    // rust: stand.last_bottles = Some([false; 3]);
    // rust: assert!(stand.idle());
    // rust: stand.items[0] = Some(ItemStack::new("minecraft:potion", 1));
    // rust: assert!(!stand.idle());
    // rust: stand.last_bottles = Some([true, false, false]);
    // rust: assert!(stand.idle());
    // rust: stand.items[4] = Some(ItemStack::new("minecraft:blaze_powder", 1));
    // rust: assert!(!stand.idle());
    // rust: stand.fuel = 3;
    // rust: assert!(stand.idle());
    // rust: stand.items[3] = Some(ItemStack::new("minecraft:nether_wart", 1));
    // rust: assert!(!stand.idle());
    // rust: stand.items[3] = None;
    // rust: stand.brew_time = 5;
    // rust: assert!(!stand.idle());
}

    /// The stand sleeps while `idle`, so its tick must change nothing then: run the real
    /// tick on idle stands and compare, and check a stand with fuel to take wakes.
pub fn an_idle_brewing_stand_tick_changes_nothing() void {
}
    // rust: let items = Items::for_tests(std::collections::HashMap::new());
    // rust: let brewing = Brewing {
    // rust: reagents: ["minecraft:nether_wart".to_owned()].into_iter().collect(),
    // rust: inputs: HashSet::new(),
    // rust: recipes: vec![BrewingRecipe {
    // rust: id: "awkward".into(),
    // rust: input: PotionIngredient {
    // rust: items: ["minecraft:potion".to_owned()].into_iter().collect(),
    // rust: potions: Some(["minecraft:water".to_owned()].into_iter().collect()),
    // rust: },
    // rust: reagent: PotionIngredient {
    // rust: items: ["minecraft:nether_wart".to_owned()].into_iter().collect(),
    // rust: potions: None,
    // rust: },
    // rust: output: ItemStack::new("minecraft:potion", 1).with_potion("minecraft:awkward"),
    // rust: }],
}
    // rust: let providers = Providers::empty();
    // rust: let water = || Some(ItemStack::new("minecraft:potion", 1).with_potion("minecraft:water"));
    // rust: let stand = |bottle: bool, fuel: i32, powder: bool| {
    // rust: let mut s = BrewingStand::new();
    // rust: s.fuel = fuel;
    // rust: if bottle {
    // rust: s.items[1] = water();
}
    // rust: if powder {
    // rust: s.items[4] = Some(ItemStack::new("minecraft:blaze_powder", 1));
}
    // rust: s.last_bottles = Some([false, bottle, false]);
    // rust: s
}
    // rust: for before in [
    // rust: stand(false, 0, false),
    // rust: stand(true, 0, false),
    // rust: stand(true, 5, false),
    // rust: stand(true, 5, true),
    // rust: ] {
    // rust: assert!(before.idle(), "{before:?}");
    // rust: let mut after = before.clone();
    // rust: assert_eq!(
    // rust: after.tick(&brewing, &items, &providers),
    // rust: BrewTick::default()
    // rust: );
    // rust: assert_eq!(format!("{after:?}"), format!("{before:?}"));
}
        // A brewable ingredient starts the brew: not idle, and the tick changes it.
    // rust: let mut brewing_now = stand(true, 5, false);
    // rust: brewing_now.items[3] = Some(ItemStack::new("minecraft:nether_wart", 1));
    // rust: assert!(!brewing_now.idle());
    // rust: brewing_now.tick(&brewing, &items, &providers);
    // rust: assert_eq!(brewing_now.brew_time, 400);
}

    /// #3312: `PotionContents.getPotionDescription` names the effects with
    /// translatable components, so a Russian game reads them from ru_ru.json
    /// (the prepared one; skipped without it), as the tooltip's other lines.
pub fn effect_lines_read_the_selected_language() void {
}
    // rust: let root = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("assets/minecraft/lang/ru_ru.json").exists() {
    // rust: return;
}
    // rust: let ru = crate::lang::Language::load(&[&root], "ru_ru");
    // rust: let translate = |key: &str| ru.get(key).map(str::to_owned);
    // rust: let lines = tooltip(Some("minecraft:turtle_master"), 0.125, &translate);
    // rust: assert_eq!(lines.len(), 2);
    // rust: assert!(lines[0].0.starts_with("Замедление IV ("), "{lines:?}");
    // rust: assert!(lines[1].0.starts_with("Сопротивление III ("), "{lines:?}");
}

pub fn infinite_effects_say_the_infinite_sign() void {
}
        // MobEffectInstance.isInfiniteDuration: a -1 duration says the
        // infinite sign, not a time; a short one still says nothing.
    // rust: let translate = |key: &str| (key == "effect.duration.infinite").then(|| "∞".to_owned());
    // rust: let lines = effect_lines([("minecraft:resistance", -1, 0)], 1.0, &translate);
    // rust: assert_eq!(lines[0].0, "resistance (∞)");
    // rust: let lines = effect_lines([("minecraft:resistance", 15, 0)], 1.0, &translate);
    // rust: assert_eq!(lines[0].0, "resistance");
}
}
