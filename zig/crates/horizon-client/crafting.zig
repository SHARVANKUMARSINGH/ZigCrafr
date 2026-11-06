//! Transpiled from Horizon Rust crate
//! Module: horizon-client_crafting
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Crafting and cooking recipes from the pinned data pack: shaped patterns
//! (`ShapedRecipePattern.matches`), shapeless recipes (a bipartite match of
//! ingredients to stacks, as `StackedContents.canCraft`), the special and
//! transmuting crafting recipes (`CustomRecipe` and friends), and
//! furnace-type cooking lookups.
// use crate::{
    // rust: Result,
    // rust: item_data::StackData,
    // rust: items::{ItemStack, Items},
    // rust: particles::{DYE_FIREWORK_COLORS, FireworkExplosion, FireworkShape},
}
// use horizon_world::nbt::{JavaString, Tag};
// use horizon_world::{component_patch::Patch, loot::PackOverlay};
// use serde_json::Value;
// use std::{
    // rust: collections::{HashMap, HashSet},
    // rust: path::Path,
    // rust: sync::Arc,
}

/// A recipe ingredient of a mod's own kind: the entry named a type in a
/// namespace outside `minecraft:`, and the loader kept it for this call.
/// The kind and the JSON the file wrote are here; fill `items` with the
/// item ids the ingredient matches (item ids only: components are not
/// checked here; a match-time hook follows separately). Duplicates are
/// removed keeping first-seen order. The hook may be called more than
/// once per recipe; the answer must be the same. An unclaimed kind
/// leaves the list empty and the recipe fails, as an unknown kind does.
/// API 166.
    // rust: pub fn native_ingredient(
    // rust: kind: &str,
    // rust: data: &serde_json::Map<String, Value>,
    // rust: items: &mut Vec<String>,
    // rust: ) {
    // rust: crate::native_client_hooks::ingredient(kind, data, items);
}

/// A mod's own ingredient kind, matching a concrete stack at craft time:
/// the ingredient's `test` calls here with the kind, its JSON and the
/// stack being matched, `accept` already true (the load-time list named
/// the item). Set `accept` to false to refuse the stack — its components
/// are the usual reason. The hook may be called many times a craft; the
/// answer must be the same for the same stack. API 377.
    // rust: pub fn native_ingredient_test(
    // rust: kind: &str,
    // rust: data: &serde_json::Map<String, Value>,
    // rust: stack: &ItemStack,
    // rust: accept: &mut bool,
    // rust: ) {
    // rust: crate::native_client_hooks::ingredient_test(kind, data, stack, accept);
}

/// Keep first-seen order, drop the rest.
pub fn dedup_keep_order(items: *mut std.ArrayList([]const u8)) void {
}
    // rust: let mut seen = std::collections::HashSet::new();
    // rust: items.retain(|i| seen.insert(i.clone()));
}

/// A set of accepted items (expanded from an item, list or tag), and the
/// items in its `HolderSet` order (`Ingredient.display`'s `TagSlotDisplay`).
pub const Ingredient = struct {
    /// The items it accepts, however the source shape named them.
    items: std.AutoHashMap([]const u8, void),
    /// The same items in `HolderSet` order (`display`).
    order: std.ArrayList([]const u8),
    /// A mod's own kind, for matching at craft time: the kind and its
    /// JSON, as the load-time hook saw them (`native_ingredient_test`).
    custom: Option<([]const u8,
    /// NeoForge's shapes, with their children parsed: matching a concrete
    /// stack asks each child its own `test` (a mod's kind among them),
    /// as on NeoForge — the flat list above only names items.
    children: Option<(Shape,
};

/// How a shape's children combine at match time.
pub const Shape = enum {
    /// Any child matching the stack is enough.
    Compound,
    /// Every child must match it.
    Intersection,
    /// The first child must, and the second must not.
    Difference,
};
    // rust: impl Ingredient {
    /// The items of a list, in order.
pub fn of(items: std.ArrayList([]const u8)) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: items: items.iter().cloned().collect(),
    // rust: order: items,
    // rust: custom: None,
    // rust: children: None,
}
}
pub fn parse(v: *Value, items: *Items) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut list: Vec<String> = Vec::new();
    // rust: let mut add = |s: &str| {
    // rust: let more: Vec<String> = match s.strip_prefix('#') {
    // rust: Some(tag) => items.item_tag_order.get(tag).cloned().unwrap_or_default(),
    // rust: None => vec![s.to_owned()],
}
    // rust: for i in more {
    // rust: if !list.contains(&i) {
    // rust: list.push(i);
}
}
}
    // rust: match v {
    // rust: Value::String(s) => add(s),
    // rust: Value::Array(a) => a.iter().filter_map(Value::as_str).for_each(&mut add),
    // rust: Value::Object(o) => return Self::parse_object(o, items),
    // rust: _ => return None,
}
    // rust: (!list.is_empty()).then(|| Self::of(list))
}
    /// NeoForge's ingredient types (`NeoForgeRegistries.Keys.INGREDIENT_TYPES`),
    /// the standard shapes mods' recipes carry, each resolved to the flat item
    /// list it matches. A kind outside these still fails the file: a mod's
    /// own ingredient types come with their own hook, not the loader.
pub fn parse_object(o: *serde_json::Map<[]const u8, items: *Items) O {
    // Implementation ported from Horizon
    return undefined;
}
        // Current NeoForge marks a custom ingredient with
        // `neoforge:ingredient_type`; `type` is the older packs' key.
    // rust: let kind = o
    // rust: .get("neoforge:ingredient_type")
    // rust: .or_else(|| o.get("type"))?
    // rust: .as_str()?;
    // rust: let children = || {
    // rust: o.get("children")
    // rust: .or_else(|| o.get("ingredients"))
    // rust: .and_then(Value::as_array)
}
        // The shapes' parsed children, for matching at craft time: every
        // arm either fills it or returns.
    // rust: let nested;
    // rust: let kept = match kind {
            // `CompoundIngredient`: any of its children matching the stack
            // is enough — the union of their items.
    // rust: "neoforge:compound" => {
    // rust: let subs: Vec<Self> = children()?
    // rust: .iter()
    // rust: .map(|s| Self::parse(s, items))
    // rust: .collect::<Option<_>>()?;
    // rust: let mut seen = Vec::new();
    // rust: for sub in &subs {
    // rust: for item in &sub.order {
    // rust: if !seen.contains(item) {
    // rust: seen.push(item.clone());
}
}
}
    // rust: nested = Some((Shape::Compound, subs));
    // rust: seen
}
            // `IntersectionIngredient`: every child must match the same
            // stack — the items all of them name.
    // rust: "neoforge:intersection" => {
    // rust: let subs: Vec<Self> = children()?
    // rust: .iter()
    // rust: .map(|s| Self::parse(s, items))
    // rust: .collect::<Option<_>>()?;
    // rust: nested = Some((Shape::Intersection, subs.clone()));
    // rust: subs.first()?
    // rust: .order
    // rust: .iter()
    // rust: .filter(|i| subs[1..].iter().all(|s| s.items.contains(*i)))
    // rust: .cloned()
    // rust: .collect()
}
            // The base's items without the subtracted's.
    // rust: "neoforge:difference" => {
    // rust: let base = Self::parse(o.get("base")?, items)?;
    // rust: let gone = Self::parse(o.get("subtracted")?, items)?;
    // rust: nested = Some((Shape::Difference, vec![base.clone(), gone.clone()]));
    // rust: base.order
    // rust: .iter()
    // rust: .filter(|i| !gone.items.contains(*i))
    // rust: .cloned()
    // rust: .collect()
}
            // A mod's own kind: the hook answers with the item list it
            // matches; a bare type name is minecraft's own, not a mod's.
    // rust: k if k.contains(':') && !k.starts_with("minecraft:") => {
    // rust: let mut list = Vec::new();
    // rust: native_ingredient(k, o, &mut list);
    // rust: dedup_keep_order(&mut list);
                // The kind and its JSON stay with the ingredient: the
                // load-time list only names items, and matching a concrete
                // stack (its components) is the match-time hook's.
    // rust: return (!list.is_empty()).then(|| Self {
    // rust: order: list.clone(),
    // rust: items: list.iter().cloned().collect(),
    // rust: custom: Some((k.to_owned(), o.clone())),
    // rust: children: None,
    // rust: });
}
    // rust: _ => return None,
}
    // rust: (!kept.is_empty()).then(|| Self {
    // rust: items: kept.iter().cloned().collect(),
    // rust: order: kept,
    // rust: custom: None,
    // rust: children: nested,
    // rust: })
}
    /// `Ingredient.test`: a stack the list names — and for a mod's own
    /// kind, one the match-time hook accepts (`ICustomIngredient.test`).
pub fn test(self: *Self, stack: *ItemStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match &self.children {
            // Each child its own `test`, as on NeoForge — a mod's kind
            // among them answers through its hook.
    // rust: Some((Shape::Compound, kids)) => kids.iter().any(|k| k.test(stack)),
    // rust: Some((Shape::Intersection, kids)) => kids.iter().all(|k| k.test(stack)),
    // rust: Some((Shape::Difference, kids)) => {
    // rust: kids.first().is_some_and(|k| k.test(stack))
    // rust: && kids.get(1).is_none_or(|k| !k.test(stack))
}
    // rust: None => {
    // rust: if !self.items.contains(&*stack.item) {
    // rust: return false;
}
    // rust: if let Some((kind, data)) = &self.custom {
    // rust: let mut accept = true;
    // rust: native_ingredient_test(kind, data, stack, &mut accept);
    // rust: return accept;
}
    // rust: true
}
}
}
}
/// `PlacementInfo`: the ingredients to find and, per recipe slot, the index
/// of its ingredient (`slotsToIngredientIndex`, -1 for an empty slot). Empty
/// when the recipe is impossible to place.
pub const Placement = struct {
    ingredients: std.ArrayList(Ingredient),
    slots: std.ArrayList(i32),
    /// A `ShapedRecipe`'s width and height (the others fill the grid).
    shaped: Option<(usize,
};
    // rust: impl Placement {
    /// `PlacementInfo.createFromOptionals` (and `create` with no empty slots).
pub fn of(cells: std.ArrayList(?Ingredient), shaped: Option<(usize) void {
}
    // rust: let mut out = Self {
    // rust: shaped,
    // rust: ..Self::default()
}
    // rust: for cell in cells {
    // rust: match cell {
    // rust: Some(i) if i.items.is_empty() => return Self::default(),
    // rust: Some(i) => {
    // rust: out.slots.push(out.ingredients.len() as i32);
    // rust: out.ingredients.push(i);
}
    // rust: None => out.slots.push(-1),
}
}
    // rust: out
}
pub fn impossible(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.slots.is_empty()
}
}
/// A recipe result: `ItemStackTemplate` (`id`, `count`, `components`), or a bare item id
/// (`ItemStackTemplate.CODEC` falls back to `Item.CODEC`), with the id optional for the
/// transmuting recipes that keep the input's item.
pub const Template = struct {
    item: ?*str,
    count: u32,
    damage: u32,
    extra: ?*StackData,
    /// Result patch before decoding defaults, including explicit removals/zeroes.
    components: ?Tag,
};
/// `ItemStackTemplate.CODEC` count: absent means 1, present must be an
/// integer in `1..=99` (`ExtraCodecs.intRange(1, 99)`), else the recipe is
/// not loaded.
    // rust: pub(crate) fn template_count(v: &Value) -> Option<u32> {
    // rust: match v.get("count") {
    // rust: None => Some(1),
    // rust: Some(c) => c
    // rust: .as_u64()
    // rust: .filter(|n| (1..=99).contains(n))
    // rust: .map(|n| n as u32),
}
}
    // rust: impl Template {
pub fn parse(v: *Value) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let components = v.get("components").map(json_tag);
    // rust: let (damage, extra) = crate::item_data::decode_components(components.as_ref());
    // rust: Some(Self {
    // rust: item: horizon_world::loot::recipe_result_id(v).map(Arc::from),
    // rust: count: template_count(v)?,
    // rust: damage,
    // rust: extra,
    // rust: components,
    // rust: })
}
    /// `ItemStackTemplate.create`.
pub fn create(self: *Self) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ItemStack {
    // rust: item: self
    // rust: .item
    // rust: .clone()
    // rust: .unwrap_or_else(|| Arc::from("minecraft:air")),
    // rust: count: self.count,
    // rust: damage: self.damage,
    // rust: extra: self.extra.clone(),
}
}
    /// `TransmuteRecipe.createWithOriginalComponents`: the input's component
    /// patch on the result item, then the template's own components over it.
pub fn over(self: *Self, input: *ItemStack, extra_count: u32) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let original = assembly_components(input);
    // rust: let result = self
    // rust: .components
    // rust: .clone()
    // rust: .unwrap_or_else(|| assembly_components(&self.create()));
        // ItemStackTemplate.apply: the second patch wins for each component;
        // a removal replaces a value rather than coexisting with it.
    // rust: let entries = |tag: Tag| match tag {
    // rust: Tag::Compound(map) => map
    // rust: .into_iter()
    // rust: .map(|(key, value)| {
    // rust: let key = key.to_string_lossy();
    // rust: match key.strip_prefix('!') {
    // rust: Some(key) => (key.to_owned(), None),
    // rust: None => (key.to_owned(), Some(value)),
}
    // rust: })
    // rust: .collect::<Vec<_>>(),
    // rust: _ => Vec::new(),
}
    // rust: let patch = Patch::new(entries(original).into_iter().chain(entries(result)));
    // rust: let components = Tag::compound(patch.entries().iter().map(|(key, value)| match value {
    // rust: Some(value) => (JavaString::from(key.as_str()), value.clone()),
    // rust: None => (
    // rust: JavaString::from(format!("!{key}").as_str()),
    // rust: Tag::Compound(Default::default()),
    // rust: ),
    // rust: }));
    // rust: let (damage, extra) = crate::item_data::decode_components(Some(&components));
    // rust: let mut out = ItemStack {
    // rust: item: self.item.clone().unwrap_or_else(|| input.item.clone()),
    // rust: count: self.count + extra_count,
    // rust: damage,
    // rust: extra,
}
    // rust: if let Some(input) = input.data() {
            // Runtime-only stack bookkeeping is not a saved component patch.
    // rust: let data = out.data_mut();
    // rust: data.wire = input.wire.clone();
    // rust: data.bundle_selected = input.bundle_selected;
}
    // rust: out.tidy();
    // rust: out
}
}
/// Assembly also carries the transient map postprocess component; the saved
/// ItemStack codec deliberately omits it. Do not turn it into saved data.
pub fn assembly_components(stack: *ItemStack) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut components = match crate::item_data::encode_components(stack) {
    // rust: Some(Tag::Compound(map)) => map,
    // rust: _ => Default::default(),
}
    // rust: if let Some(postprocess) = stack.data().and_then(|d| d.map_post_processing) {
    // rust: components.insert(
    // rust: "minecraft:map_post_processing".into(),
    // rust: Tag::Int(i32::from(postprocess)),
    // rust: );
}
    // rust: Tag::Compound(components)
}
/// A JSON recipe value as the NBT a component codec reads.
pub fn json_tag(v: *Value) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match v {
    // rust: Value::Null => Tag::End,
    // rust: Value::Bool(b) => Tag::Byte(i8::from(*b)),
    // rust: Value::Number(n) => match n.as_i64() {
    // rust: Some(i) => i32::try_from(i).map_or(Tag::Long(i), Tag::Int),
    // rust: None => Tag::Double(n.as_f64().unwrap_or(0.0).to_bits()),
    // rust: },
    // rust: Value::String(s) => Tag::String(s.as_str().into()),
    // rust: Value::Array(a) => Tag::List(a.iter().map(json_tag).collect()),
    // rust: Value::Object(o) => Tag::compound(o.iter().map(|(k, v)| (k.as_str(), json_tag(v)))),
}
}
pub const Recipe = enum {
    Shaped {,
    width: usize,
    height: usize,
    cells: Vec<Option<Ingredient>>,
    result: Template,
    // rust: },
    Shapeless {,
    ingredients: Vec<Ingredient>,
    result: Template,
    // rust: },
    /// The recipes with code of their own.
    Special(Special),
};
    // rust: impl Recipe {
    /// `Recipe.isSpecial`: special recipes (e.g. firework rocket, dye) are not in the recipe book.
pub fn is_special(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(self, Recipe::Special(_))
}
}
/// The custom and transmuting crafting recipes.
pub const Special = enum {
    /// A patterned banner and a blank one of the same colour copy the patterns.
    BannerDuplicate { banner: Ingredient, result: String },
    /// A banner decorates an undecorated shield.
    ShieldDecoration {,
    banner: Ingredient,
    target: Ingredient,
    result: String,
    // rust: },
    /// `TransmuteRecipe`: one input, 1..8 materials; shulker box and bundle
    /// dyeing, map cloning.
    Transmute {,
    input: Ingredient,
    material: Ingredient,
    min: usize,
    max: usize,
    add_count: bool,
    result: Template,
    // rust: },
    /// `DyeRecipe`: dyed armour.
    Dye {,
    target: Ingredient,
    dye: Ingredient,
    result: Template,
    // rust: },
    /// `ImbueRecipe`: tipped arrows.
    Imbue {,
    source: Ingredient,
    material: Ingredient,
    result: Template,
    // rust: },
    /// `BookCloningRecipe`.
    BookCloning {,
    source: Ingredient,
    material: Ingredient,
    min: i32,
    max: i32,
    result: Template,
    // rust: },
    /// `FireworkRocketRecipe`.
    FireworkRocket {,
    shell: Ingredient,
    fuel: Ingredient,
    star: Ingredient,
    result: Template,
    // rust: },
    /// `FireworkStarRecipe`.
    FireworkStar {,
    dye: Ingredient,
    fuel: Ingredient,
    trail: Ingredient,
    twinkle: Ingredient,
    shapes: Vec<(FireworkShape, Ingredient)>,
    result: Template,
    // rust: },
    /// `FireworkStarFadeRecipe`.
    FireworkStarFade {,
    dye: Ingredient,
    target: Ingredient,
    result: Template,
    // rust: },
    /// `MapExtendingRecipe`: a map ringed by paper, when its scale is under 4.
    MapExtending {,
    map: Ingredient,
    material: Ingredient,
    result: Template,
    // rust: },
    /// `DecoratedPotRecipe`: four sherds or bricks.
    DecoratedPot {,
    back: Ingredient,
    left: Ingredient,
    right: Ingredient,
    front: Ingredient,
    result: Template,
    // rust: },
    /// `RepairItemRecipe`: two damaged items of one kind.
    RepairItem,
};
    // rust: impl Special {
    /// The recipe-book displays of a learnable (non-custom) crafting recipe:
    /// its layout, its result as the button shows it, and every stack the
    /// result display cycles through when it is more than that one
    /// (`SlotDisplay.resolveForStacks`).
pub fn book_displays(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
//         use crate::recipe_book::Display;
    // rust: let first_of =
    // rust: |all: &Vec<ItemStack>, single: ItemStack| all.first().cloned().unwrap_or(single);
    // rust: let shown = |display, result, variants| BookDisplay {
    // rust: display,
    // rust: result,
    // rust: variants,
    // rust: stacks: Vec::new(),
}
    // rust: match self {
    // rust: Self::Transmute {
    // rust: input,
    // rust: material,
    // rust: min,
    // rust: max,
    // rust: add_count,
    // rust: result,
    // rust: } => (*min..=*max)
    // rust: .map(|n| {
    // rust: let mut ingredients = vec![input.clone()];
    // rust: ingredients.extend(std::iter::repeat_n(material.clone(), n));
    // rust: let mut made = result.create();
    // rust: if *add_count {
    // rust: made.count += n as u32;
}
                    // The result keeps the input's item: any item of the ingredient.
    // rust: let all: Vec<ItemStack> = if result.item.is_none() {
    // rust: input
    // rust: .order
    // rust: .iter()
    // rust: .map(|item| {
    // rust: let mut stack = made.clone();
    // rust: stack.item = Arc::from(item.as_str());
    // rust: stack
    // rust: })
    // rust: .collect()
    // rust: } else {
    // rust: Vec::new()
}
    // rust: shown(Display::Shapeless(ingredients), first_of(&all, made), all)
    // rust: })
    // rust: .collect(),
    // rust: Self::Dye {
    // rust: target,
    // rust: dye,
    // rust: result,
    // rust: } => {
                // DyedSlotDemo: the targets cycle fastest, 16 stacks at most.
    // rust: let (targets, dyes) = (&target.order, &dye.order);
    // rust: let all: Vec<ItemStack> = (0..targets.len() * dyes.len())
    // rust: .map(|i| {
    // rust: let mut made = result.create();
    // rust: made.item = Arc::from(targets[i % targets.len()].as_str());
    // rust: let name = dyes[i / targets.len()].trim_start_matches("minecraft:");
    // rust: let color = crate::block_entity_render::DYES
    // rust: .iter()
    // rust: .find(|(c, _)| name.strip_suffix("_dye") == Some(c))
    // rust: .map_or(crate::block_entity_render::DYES[0].1, |d| d.1);
    // rust: made.data_mut().dyed_color = Some(color as i32);
    // rust: made
    // rust: })
    // rust: .take(16)
    // rust: .collect();
    // rust: let first = result.create();
    // rust: vec![shown(
    // rust: Display::Shapeless(vec![target.clone(), dye.clone()]),
    // rust: first_of(&all, first),
    // rust: all,
    // rust: )]
}
    // rust: Self::Imbue {
    // rust: source,
    // rust: material,
    // rust: result,
    // rust: } => {
    // rust: let cells = (0..9)
    // rust: .map(|i| Some(if i == 4 { source } else { material }.clone()))
    // rust: .collect();
                // Any potion's tipped arrow.
    // rust: let potions = |item: ItemStack| -> Vec<ItemStack> {
    // rust: crate::brewing::POTIONS
    // rust: .iter()
    // rust: .map(|p| item.clone().with_potion(&format!("minecraft:{}", p.id)))
    // rust: .collect()
}
    // rust: let all = potions(result.create());
                // The source ingredient is shown as a lingering potion of each kind.
    // rust: let lingering = source
    // rust: .order
    // rust: .iter()
    // rust: .flat_map(|item| potions(ItemStack::new(item, 1)))
    // rust: .collect();
    // rust: vec![BookDisplay {
    // rust: stacks: vec![(4, lingering)],
    // rust: ..shown(
    // rust: Display::Shaped {
    // rust: width: 3,
    // rust: height: 3,
    // rust: cells,
    // rust: },
    // rust: first_of(&all, result.create()),
    // rust: all,
    // rust: )
    // rust: }]
}
    // rust: _ => Vec::new(),
}
}
}
/// One recipe-book display of a special recipe.
pub const BookDisplay = struct {
    display: crate::recipe_book::Display,
    /// The result as the button shows it (the first of `variants`).
    result: ItemStack,
    /// Every stack the result display cycles through; empty for one stack.
    variants: std.ArrayList(ItemStack),
    /// Ingredients shown as other stacks than their items, by index in
    /// `Entry::requirements`.
    stacks: Vec<(usize,
};
/// `CraftingInput`: the occupied bounding box of the grid.
pub const Input = struct {
    width: usize,
    height: usize,
    /// Position of the box in the grid.
    left: usize,
    top: usize,
    cells: std.ArrayList(?*'a ItemStack),
};
    // rust: impl<'a> Input<'a> {
    /// `CraftingInput.ofPositioned`; None for an empty grid.
pub fn of(grid: *'a [?ItemStack], size: usize) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let occupied: Vec<(usize, usize)> = (0..size * size)
    // rust: .filter(|&i| grid.get(i).is_some_and(|c| c.is_some()))
    // rust: .map(|i| (i % size, i / size))
    // rust: .collect();
    // rust: let (x0, x1) = (
    // rust: occupied.iter().map(|p| p.0).min()?,
    // rust: occupied.iter().map(|p| p.0).max()?,
    // rust: );
    // rust: let (y0, y1) = (
    // rust: occupied.iter().map(|p| p.1).min()?,
    // rust: occupied.iter().map(|p| p.1).max()?,
    // rust: );
    // rust: let (width, height) = (x1 - x0 + 1, y1 - y0 + 1);
    // rust: let cells = (0..width * height)
    // rust: .map(|i| grid[(y0 + i / width) * size + x0 + i % width].as_ref())
    // rust: .collect();
    // rust: Some(Self {
    // rust: width,
    // rust: height,
    // rust: left: x0,
    // rust: top: y0,
    // rust: cells,
    // rust: })
}
pub fn get(self: *Self, x: usize, y: usize) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.cells.get(y * self.width + x).copied().flatten()
}
    /// The non-empty stacks in slot order.
pub fn stacks(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.cells.iter().flatten().copied().collect()
}
pub fn count(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.cells.iter().flatten().count()
}
}
/// What recipes need to know about an item.
pub const Facts = struct {
    /// Index into the dye colours when the item has the `dye` component.
    dye: ?usize,
    max_damage: u32,
    max_stack: u32,
    remainder: ?*str,
};
/// The tables recipes consult.
pub const Context = struct {
    recipes: *'a Recipes,
    /// A filled map's scale, when its data is known.
    map_scale: *'a dyn Fn(i32) -> ?u8,
};
    // rust: impl Context<'_> {
pub fn facts(self: *Self, stack: *ItemStack) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.recipes.facts.get(&stack.item)
}
    /// `itemStack.has(DataComponents.DYE)`.
pub fn dye(self: *Self, stack: *ItemStack) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.facts(stack).and_then(|f| f.dye)
}
pub fn max_stack(self: *Self, item: []const u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.recipes.facts.get(item).map_or(64, |f| f.max_stack)
}
}
    // rust: impl Special {
    /// `Recipe.matches`.
pub fn matches(self: *Self, ctx: *Context, input: *Input) b {
    // Implementation ported from Horizon
    return undefined;
}
//         use crate::banner;
    // rust: let stacks = input.stacks();
    // rust: match self {
    // rust: Self::BannerDuplicate { banner: ing, .. } => {
    // rust: if stacks.len() != 2 {
    // rust: return false;
}
    // rust: let mut color = None;
    // rust: let (mut target, mut source) = (false, false);
    // rust: for s in &stacks {
    // rust: let Some(this) = banner::banner_color(&s.item).filter(|_| ing.test(s)) else {
    // rust: return false;
}
    // rust: match color {
    // rust: None => color = Some(this),
    // rust: Some(c) if c != this => return false,
    // rust: _ => {}
}
    // rust: let layers = banner::layers(s).len();
    // rust: if layers > banner::MAX_LAYERS {
    // rust: return false;
}
    // rust: let seen = if layers > 0 { &mut source } else { &mut target };
    // rust: if *seen {
    // rust: return false;
}
    // rust: *seen = true;
}
    // rust: source && target
}
    // rust: Self::ShieldDecoration {
    // rust: banner: ing,
    // rust: target: tgt,
    // rust: ..
    // rust: } => {
    // rust: if stacks.len() != 2 {
    // rust: return false;
}
    // rust: let (mut patterned, mut clear) = (false, false);
    // rust: for s in &stacks {
    // rust: if ing.test(s) && banner::banner_color(&s.item).is_some() {
    // rust: if patterned {
    // rust: return false;
}
    // rust: patterned = true;
    // rust: } else {
    // rust: if !tgt.test(s) || clear || !banner::layers(s).is_empty() {
    // rust: return false;
}
    // rust: clear = true;
}
}
    // rust: patterned && clear
}
    // rust: Self::Transmute {
    // rust: input: base,
    // rust: material,
    // rust: min,
    // rust: max,
    // rust: add_count,
    // rust: result,
    // rust: } => {
    // rust: let n = stacks.len();
    // rust: if n < min + 1 || n > max + 1 {
    // rust: return false;
}
    // rust: let mut found: Option<&ItemStack> = None;
    // rust: let mut materials = 0;
    // rust: for s in &stacks {
    // rust: if base.test(s) {
    // rust: if found.is_some() {
    // rust: return false;
}
    // rust: found = Some(s);
    // rust: } else {
    // rust: if !material.test(s) {
    // rust: return false;
}
    // rust: materials += 1;
    // rust: if materials > *max {
    // rust: return false;
}
}
}
    // rust: let Some(found) = found else {
    // rust: return false;
}
    // rust: if materials < *min || materials > *max {
    // rust: return false;
}
    // rust: let count = if *add_count {
    // rust: materials as u32 + result.count
    // rust: } else {
    // rust: result.count
}
    // rust: if count != 1 {
    // rust: return true;
}
    // rust: let made = result.over(found, 0);
    // rust: made.count <= ctx.max_stack(&made.item) && !made.same_item_same_components(found)
}
    // rust: Self::Dye { target, dye, .. } => {
    // rust: if stacks.len() < 2 {
    // rust: return false;
}
    // rust: let (mut has_target, mut has_dyes) = (false, false);
    // rust: for s in &stacks {
    // rust: if target.test(s) {
    // rust: if has_target {
    // rust: return false;
}
    // rust: has_target = true;
    // rust: } else {
    // rust: if !dye.test(s) || ctx.dye(s).is_none() {
    // rust: return false;
}
    // rust: has_dyes = true;
}
}
    // rust: has_dyes && has_target
}
    // rust: Self::Imbue {
    // rust: source, material, ..
    // rust: } => {
    // rust: if input.width != 3 || input.height != 3 || stacks.len() != 9 {
    // rust: return false;
}
    // rust: (0..3).all(|y| {
    // rust: (0..3).all(|x| {
    // rust: let ing = if x == 1 && y == 1 { source } else { material };
    // rust: input.get(x, y).is_some_and(|s| ing.test(s))
    // rust: })
    // rust: })
}
    // rust: Self::BookCloning {
    // rust: source,
    // rust: material,
    // rust: min,
    // rust: max,
    // rust: ..
    // rust: } => {
    // rust: if stacks.len() < 2 {
    // rust: return false;
}
    // rust: let (mut has_material, mut has_source) = (false, false);
    // rust: for s in &stacks {
    // rust: if source.test(s) {
    // rust: let Some(book) = s.data().and_then(|d| d.written.as_ref()) else {
    // rust: return false;
}
    // rust: let generation = i32::from(book.generation);
    // rust: if generation < *min || generation > *max || has_source {
    // rust: return false;
}
    // rust: has_source = true;
    // rust: } else {
    // rust: if !material.test(s) {
    // rust: return false;
}
    // rust: has_material = true;
}
}
    // rust: has_source && has_material
}
    // rust: Self::FireworkRocket {
    // rust: shell, fuel, star, ..
    // rust: } => {
    // rust: if stacks.len() < 2 {
    // rust: return false;
}
    // rust: let mut has_shell = false;
    // rust: let mut fuels = 0;
    // rust: for s in &stacks {
    // rust: if shell.test(s) {
    // rust: if has_shell {
    // rust: return false;
}
    // rust: has_shell = true;
    // rust: } else if fuel.test(s) {
    // rust: fuels += 1;
    // rust: if fuels > 3 {
    // rust: return false;
}
    // rust: } else if !star.test(s) {
    // rust: return false;
}
}
    // rust: has_shell && fuels >= 1
}
    // rust: Self::FireworkStar {
    // rust: dye,
    // rust: fuel,
    // rust: trail,
    // rust: twinkle,
    // rust: shapes,
    // rust: ..
    // rust: } => {
    // rust: if stacks.len() < 2 {
    // rust: return false;
}
    // rust: let (mut has_fuel, mut has_dye, mut has_shape) = (false, false, false);
    // rust: let (mut has_trail, mut has_twinkle) = (false, false);
    // rust: for s in &stacks {
    // rust: if twinkle.test(s) {
    // rust: if has_twinkle {
    // rust: return false;
}
    // rust: has_twinkle = true;
    // rust: } else if trail.test(s) {
    // rust: if has_trail {
    // rust: return false;
}
    // rust: has_trail = true;
    // rust: } else if fuel.test(s) {
    // rust: if has_fuel {
    // rust: return false;
}
    // rust: has_fuel = true;
    // rust: } else if dye.test(s) && ctx.dye(s).is_some() {
    // rust: has_dye = true;
    // rust: } else {
    // rust: if !shapes.iter().any(|(_, ing)| ing.test(s)) || has_shape {
    // rust: return false;
}
    // rust: has_shape = true;
}
}
    // rust: has_fuel && has_dye
}
    // rust: Self::FireworkStarFade { dye, target, .. } => {
    // rust: if stacks.len() < 2 {
    // rust: return false;
}
    // rust: let (mut has_dye, mut has_target) = (false, false);
    // rust: for s in &stacks {
    // rust: if dye.test(s) && ctx.dye(s).is_some() {
    // rust: has_dye = true;
    // rust: } else {
    // rust: if !target.test(s) || has_target {
    // rust: return false;
}
    // rust: has_target = true;
}
}
    // rust: has_target && has_dye
}
    // rust: Self::MapExtending { map, material, .. } => {
    // rust: if input.width != 3 || input.height != 3 || stacks.len() != 9 {
    // rust: return false;
}
    // rust: let ring = (0..3).all(|y| {
    // rust: (0..3).all(|x| {
    // rust: let ing = if x == 1 && y == 1 { map } else { material };
    // rust: input.get(x, y).is_some_and(|s| ing.test(s))
    // rust: })
    // rust: });
    // rust: if !ring {
    // rust: return false;
}
    // rust: stacks
    // rust: .iter()
    // rust: .find_map(|s| s.data().and_then(|d| d.map_id))
    // rust: .and_then(|id| (ctx.map_scale)(id))
    // rust: .is_some_and(|scale| scale < 4)
}
    // rust: Self::DecoratedPot {
    // rust: back,
    // rust: left,
    // rust: right,
    // rust: front,
    // rust: ..
    // rust: } => {
    // rust: input.width == 3
    // rust: && input.height == 3
    // rust: && stacks.len() == 4
    // rust: && input.get(1, 0).is_some_and(|s| back.test(s))
    // rust: && input.get(0, 1).is_some_and(|s| left.test(s))
    // rust: && input.get(2, 1).is_some_and(|s| right.test(s))
    // rust: && input.get(1, 2).is_some_and(|s| front.test(s))
}
    // rust: Self::RepairItem => Self::repair_pair(ctx, &stacks).is_some(),
}
}
    /// `RepairItemRecipe.getItemsToCombine`.
    // rust: fn repair_pair<'a>(
    // rust: ctx: &Context,
    // rust: stacks: &[&'a ItemStack],
    // rust: ) -> Option<(&'a ItemStack, &'a ItemStack)> {
    // rust: let [first, second] = stacks else {
    // rust: return None;
}
    // rust: let durable = |s: &ItemStack| ctx.facts(s).is_some_and(|f| f.max_damage > 0);
    // rust: (second.item == first.item
    // rust: && first.count == 1
    // rust: && second.count == 1
    // rust: && durable(first)
    // rust: && durable(second))
    // rust: .then_some((*first, *second))
}
    /// `Recipe.assemble`; None is the empty stack.
pub fn assemble(self: *Self, ctx: *Context, input: *Input) O {
    // Implementation ported from Horizon
    return undefined;
}
//         use crate::banner;
    // rust: let stacks = input.stacks();
    // rust: let made = match self {
    // rust: Self::BannerDuplicate { result, .. } => {
    // rust: let source = stacks
    // rust: .iter()
    // rust: .find(|s| (1..=banner::MAX_LAYERS).contains(&banner::layers(s).len()))?;
                // TransmuteRecipe.createWithOriginalComponents: the source's components.
    // rust: ItemStack {
    // rust: item: Arc::from(result.as_str()),
    // rust: count: 1,
    // rust: ..(**source).clone()
}
}
    // rust: Self::ShieldDecoration {
    // rust: banner: ing,
    // rust: target,
    // rust: result,
    // rust: } => {
    // rust: let (mut banner_stack, mut shield) = (None, None);
    // rust: for s in &stacks {
    // rust: if ing.test(s) && banner::banner_color(&s.item).is_some() {
    // rust: banner_stack = Some(*s);
    // rust: } else if target.test(s) {
    // rust: shield = Some(*s);
}
}
    // rust: let (banner_stack, shield) = (banner_stack?, shield?);
    // rust: let mut out = ItemStack {
    // rust: item: Arc::from(result.as_str()),
    // rust: count: 1,
    // rust: ..shield.clone()
}
    // rust: let data = out.data_mut();
    // rust: data.banner_patterns = banner::layers(banner_stack).to_vec();
    // rust: data.base_color = banner::banner_color(&banner_stack.item).map(Arc::from);
    // rust: out
}
    // rust: Self::Transmute {
    // rust: input: base,
    // rust: material,
    // rust: add_count,
    // rust: result,
    // rust: ..
    // rust: } => {
    // rust: if *add_count {
    // rust: let mut materials = 0;
    // rust: let mut found = None;
    // rust: for s in &stacks {
    // rust: if base.test(s) {
    // rust: found = Some(*s);
    // rust: } else if material.test(s) {
    // rust: materials += 1;
}
}
    // rust: result.over(found?, materials)
    // rust: } else {
    // rust: let s = stacks.iter().find(|s| base.test(s))?;
    // rust: result.over(s, 0)
}
}
    // rust: Self::Dye {
    // rust: target,
    // rust: dye,
    // rust: result,
    // rust: } => {
    // rust: let mut dyes = Vec::new();
    // rust: let mut target_stack: Option<&ItemStack> = None;
    // rust: for s in &stacks {
    // rust: if target.test(s) {
    // rust: if target_stack.is_some() {
    // rust: return None;
}
    // rust: target_stack = Some(s);
    // rust: } else {
    // rust: if !dye.test(s) {
    // rust: return None;
}
                        // getOrDefault(DYE, WHITE)
    // rust: dyes.push(ctx.dye(s).unwrap_or(0));
}
}
    // rust: let target_stack = target_stack?;
    // rust: if dyes.is_empty() {
    // rust: return None;
}
    // rust: let current = target_stack.data().and_then(|d| d.dyed_color);
    // rust: let mut out = result.over(target_stack, 0);
    // rust: out.data_mut().dyed_color = Some(apply_dyes(current, &dyes));
    // rust: out
}
    // rust: Self::Imbue { result, .. } => {
    // rust: let source = input.get(1, 1)?;
    // rust: let mut out = result.create();
    // rust: out.data_mut().potion = source.data().and_then(|d| d.potion.clone());
    // rust: out
}
    // rust: Self::BookCloning {
    // rust: source,
    // rust: material,
    // rust: result,
    // rust: ..
    // rust: } => {
    // rust: let mut copies = 0u32;
    // rust: let mut book: Option<&ItemStack> = None;
    // rust: for s in &stacks {
    // rust: if source.test(s) && s.data().is_some_and(|d| d.written.is_some()) {
    // rust: if book.is_some() {
    // rust: return None;
}
    // rust: book = Some(s);
    // rust: } else {
    // rust: if !material.test(s) {
    // rust: return None;
}
    // rust: copies += 1;
}
}
    // rust: let book = book?;
                // count - 1 can be -1 when no material was seen; matches() ensures one.
    // rust: let mut out = result.over(book, copies.saturating_sub(1));
    // rust: if let Some(w) = out.data_mut().written.as_mut() {
    // rust: w.generation += 1;
}
    // rust: out
}
    // rust: Self::FireworkRocket {
    // rust: fuel, star, result, ..
    // rust: } => {
    // rust: let mut explosions = Vec::new();
    // rust: let mut fuels = 0u8;
    // rust: for s in &stacks {
    // rust: if fuel.test(s) {
    // rust: fuels += 1;
    // rust: } else if star.test(s)
    // rust: && let Some(e) = s.data().and_then(|d| d.firework_explosion.clone())
    // rust: {
    // rust: explosions.push(e);
}
}
    // rust: let mut out = result.create();
                // A rocket's prototype is one flight and no explosions.
    // rust: if fuels != 1 || !explosions.is_empty() {
    // rust: out.data_mut().fireworks = Some((fuels, explosions));
}
    // rust: out
}
    // rust: Self::FireworkStar {
    // rust: dye,
    // rust: trail,
    // rust: twinkle,
    // rust: shapes,
    // rust: result,
    // rust: ..
    // rust: } => {
    // rust: let mut shape = FireworkShape::SmallBall;
    // rust: let (mut has_twinkle, mut has_trail) = (false, false);
    // rust: let mut colors = Vec::new();
    // rust: for s in &stacks {
    // rust: if let Some((found, _)) = shapes.iter().find(|(_, ing)| ing.test(s)) {
    // rust: shape = *found;
    // rust: } else if twinkle.test(s) {
    // rust: has_twinkle = true;
    // rust: } else if trail.test(s) {
    // rust: has_trail = true;
    // rust: } else if dye.test(s) {
    // rust: colors.push(DYE_FIREWORK_COLORS[ctx.dye(s).unwrap_or(0)].1);
}
}
    // rust: let mut out = result.create();
    // rust: out.data_mut().firework_explosion = Some(FireworkExplosion {
    // rust: shape,
    // rust: colors,
    // rust: fade: Vec::new(),
    // rust: trail: has_trail,
    // rust: twinkle: has_twinkle,
    // rust: });
    // rust: out
}
    // rust: Self::FireworkStarFade {
    // rust: dye,
    // rust: target,
    // rust: result,
    // rust: } => {
    // rust: let mut colors = Vec::new();
    // rust: let mut target_stack = None;
    // rust: for s in &stacks {
    // rust: if dye.test(s) {
    // rust: colors.push(DYE_FIREWORK_COLORS[ctx.dye(s).unwrap_or(0)].1);
    // rust: } else if target.test(s) {
    // rust: target_stack = Some(*s);
}
}
    // rust: let target_stack = target_stack?;
    // rust: if colors.is_empty() {
    // rust: return None;
}
    // rust: let mut out = result.over(target_stack, 0);
    // rust: let explosion = out
    // rust: .data_mut()
    // rust: .firework_explosion
    // rust: .get_or_insert_with(FireworkExplosion::default);
    // rust: explosion.fade = colors;
    // rust: out
}
    // rust: Self::MapExtending { result, .. } => {
    // rust: let map = stacks
    // rust: .iter()
    // rust: .find(|s| s.data().is_some_and(|d| d.map_id.is_some()))?;
    // rust: let mut out = result.over(map, 0);
    // rust: out.data_mut().map_post_processing = Some(1);
    // rust: out
}
    // rust: Self::DecoratedPot { result, .. } => {
    // rust: let side = |x, y| {
    // rust: input.get(x, y).map(|s| ItemStack {
    // rust: count: 1,
    // rust: ..s.clone()
    // rust: })
}
    // rust: let mut out = result.create();
    // rust: let sides = [side(1, 0), side(0, 1), side(2, 1), side(1, 2)];
    // rust: if !crate::item_data::all_bricks(&sides) {
    // rust: out.data_mut().pot_decorations = Some(Box::new(sides));
}
    // rust: out
}
    // rust: Self::RepairItem => {
    // rust: let (first, second) = Self::repair_pair(ctx, &stacks)?;
    // rust: let max = |s: &ItemStack| ctx.facts(s).map_or(0, |f| f.max_damage) as i64;
    // rust: let durability = max(first).max(max(second));
    // rust: let remaining = (max(first) - i64::from(first.damage))
    // rust: + (max(second) - i64::from(second.damage))
    // rust: + durability * 5 / 100;
    // rust: let mut out = ItemStack::new(&first.item, 1);
    // rust: out.damage = (durability - remaining).max(0) as u32;
                // Only the curses of both survive, at the higher level.
    // rust: let (a, b) = (
    // rust: first.crafting_enchantments(),
    // rust: second.crafting_enchantments(),
    // rust: );
    // rust: let mut curses: Vec<(Arc<str>, u32)> = Vec::new();
    // rust: for (id, level) in a.iter().chain(b.iter()) {
    // rust: if !ctx.recipes.curses.contains(&**id) {
    // rust: continue;
}
    // rust: match curses.iter_mut().find(|(c, _)| c == id) {
    // rust: Some((_, l)) => *l = (*l).max(*level),
    // rust: None => curses.push((id.clone(), *level)),
}
}
    // rust: out.set_crafting_enchantments(curses);
    // rust: out
}
}
    // rust: let mut made = made;
    // rust: made.tidy();
        // ItemStackTemplate.validate: oversized stacks become empty.
    // rust: (made.count > 0 && made.count <= ctx.max_stack(&made.item)).then_some(made)
}
}
/// `DyedItemColor.applyDyes` over dye indexes.
    // rust: pub(crate) fn apply_dyes(current: Option<i32>, dyes: &[usize]) -> i32 {
    // rust: let (mut r, mut g, mut b, mut intensity, mut n) = (0i32, 0i32, 0i32, 0i32, 0i32);
    // rust: let mut add = |rgb: u32| {
    // rust: let (red, green, blue) = (
    // rust: (rgb >> 16 & 255) as i32,
    // rust: (rgb >> 8 & 255) as i32,
    // rust: (rgb & 255) as i32,
    // rust: );
    // rust: intensity += red.max(green.max(blue));
    // rust: r += red;
    // rust: g += green;
    // rust: b += blue;
    // rust: n += 1;
}
    // rust: if let Some(c) = current {
    // rust: add(c as u32);
}
    // rust: for d in dyes {
    // rust: add(crate::block_entity_render::DYES[*d].1);
}
    // rust: let (red, green, blue) = (r / n, g / n, b / n);
    // rust: let average = intensity as f32 / n as f32;
    // rust: let result = red.max(green.max(blue)) as f32;
    // rust: let scale = |c: i32| (c as f32 * average / result) as i32;
    // rust: scale(red) << 16 | scale(green) << 8 | scale(blue)
}
pub const Cooking = struct {
    /// The recipe's file name (its id without namespace).
    id: []const u8,
    /// `category` (`food`, `blocks`, `misc`) and `group` of the recipe book.
    category: []const u8,
    group: []const u8,
    kind: []const u8,
    ingredient: Ingredient,
    result: ItemStack,
    experience: f32,
    time: u32,
};
/// A recipe of a type of a mod's own, kept as its file says: the mod reads it.
pub const CustomRecipe = struct {
    /// `<namespace>:<path>`, its place under `data/<namespace>/recipe/`.
    id: []const u8,
    json: *Value,
};
/// An item stack as a recipe's `result` names it (`ItemStackTemplate`); none
/// with no `id` or a count outside 1 to 99.
pub fn recipe_result(v: *Value) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let template = Template::parse(v)?;
    // rust: template.item.is_some().then(|| template.create())
}
/// The type of a recipe the game doesn't craft itself: one outside `minecraft`.
/// A recipe's whole id from its name in the tables: vanilla's are kept bare
/// (`oak_planks`), everyone else's whole (`mymod:crusher/iron`).
pub fn recipe_id(name: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if name.contains(':') {
    // rust: name.to_owned()
    // rust: } else {
    // rust: format!("minecraft:{name}")
}
}
/// The sort key of vanilla's recipe registration order, which first-match
/// lookups (`RecipeManager.getRecipeFor`'s `findFirst`), the stonecutter's
/// list and the recipe book's display numbers all follow:
/// `ResourceManagerRegistryLoadTask` sorts the resource files by `Identifier`
/// (path, then namespace) and `RecipeMap` keeps that order. The file's path
/// ends in `.json`, so `prefix-early` sorts before `prefix`. `name` is a
/// table name (`oak_planks`) or a whole id.
pub fn registration_key(name: []const u8) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (namespace, path) = name.split_once(':').unwrap_or(("minecraft", name));
    // rust: (format!("{path}.json"), namespace.to_owned())
}
pub fn custom_type(v: *Value) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: v["type"]
    // rust: .as_str()
    // rust: .filter(|t| t.contains(':') && !t.starts_with("minecraft:"))
}
pub const Recipes = struct {
    crafting: Vec<([]const u8,
    cooking: std.ArrayList(Cooking),
    /// The recipes of types of mods' own, by type, in registration order.
    custom: HashMap<[]const u8,
    /// `category` and `group` of each crafting recipe, by file name.
    meta: HashMap<[]const u8,
    facts: HashMap<*str,
    /// The `#minecraft:curse` enchantments.
    curses: std.AutoHashMap([]const u8, void),
    /// The first cooking recipe of each kind taking each item, built at the
    /// first lookup (furnaces look theirs up every tick).
    cook_index: std::sync::OnceLock<CookIndex>,
};
    // rust: type CookIndex = HashMap<String, crate::fast_hash::FxHashMap<String, Vec<usize>>>;
/// `MinMaxBounds.Ints` as (min, max) with the given defaults.
pub fn bounds(v: ?*Value, default: (i64) void {
}
    // rust: match v {
    // rust: Some(Value::Number(n)) => {
    // rust: let n = n.as_i64().unwrap_or(default.0);
    // rust: (n, n)
}
    // rust: Some(o @ Value::Object(_)) => (
    // rust: o["min"].as_i64().unwrap_or(open.0),
    // rust: o["max"].as_i64().unwrap_or(open.1),
    // rust: ),
    // rust: _ => default,
}
}
/// `Util.isSymmetrical` is not needed: both orientations are tried.
/// `ShapedRecipePattern.shrink`: the pattern without empty border rows and columns.
pub fn shrink(pattern: *[std.ArrayList(char)]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let rows: Vec<&Vec<char>> = pattern
    // rust: .iter()
    // rust: .skip_while(|r| r.iter().all(|c| *c == ' '))
    // rust: .collect();
    // rust: let mut rows: Vec<Vec<char>> = rows.into_iter().cloned().collect();
    // rust: while rows.last().is_some_and(|r| r.iter().all(|c| *c == ' ')) {
    // rust: rows.pop();
}
    // rust: let left = rows
    // rust: .iter()
    // rust: .filter_map(|r| r.iter().position(|c| *c != ' '))
    // rust: .min();
    // rust: let right = rows
    // rust: .iter()
    // rust: .filter_map(|r| r.iter().rposition(|c| *c != ' '))
    // rust: .max();
    // rust: match (left, right) {
    // rust: (Some(l), Some(r)) => rows.iter().map(|row| row[l..=r].to_vec()).collect(),
    // rust: _ => Vec::new(),
}
}
/// A perfect matching of the ingredients to distinct stacks (`StackedContents.canCraft`).
pub fn matches_all(ingredients: *[Ingredient], stacks: *[*ItemStack]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: fn augment(
    // rust: i: usize,
    // rust: ingredients: &[Ingredient],
    // rust: stacks: &[&ItemStack],
    // rust: owner: &mut [Option<usize>],
    // rust: seen: &mut [bool],
    // rust: ) -> bool {
    // rust: for s in 0..stacks.len() {
    // rust: if seen[s] || !ingredients[i].test(stacks[s]) {
    // rust: continue;
}
    // rust: seen[s] = true;
    // rust: if owner[s].is_none_or(|o| augment(o, ingredients, stacks, owner, seen)) {
    // rust: owner[s] = Some(i);
    // rust: return true;
}
}
    // rust: false
}
    // rust: if ingredients.len() != stacks.len() {
    // rust: return false;
}
    // rust: let mut owner = vec![None; stacks.len()];
    // rust: (0..ingredients.len()).all(|i| {
    // rust: let mut seen = vec![false; stacks.len()];
    // rust: augment(i, ingredients, stacks, &mut owner, &mut seen)
    // rust: })
}
/// A resource id with its default namespace filled in — the whole id the
/// book, the network copy and the advancements' JSON know a recipe by,
/// whatever the caller passes. `sources` names a `minecraft:` recipe bare
/// on purpose (vanilla's own ids); this puts the namespace back.
pub fn qualified(id: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if id.contains(':') {
    // rust: id.to_owned()
    // rust: } else {
    // rust: format!("minecraft:{id}")
}
}

    // rust: impl Recipes {
pub fn empty() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: crafting: Vec::new(),
    // rust: cooking: Vec::new(),
    // rust: custom: HashMap::new(),
    // rust: meta: HashMap::new(),
    // rust: facts: HashMap::new(),
    // rust: curses: HashSet::new(),
    // rust: cook_index: std::sync::OnceLock::new(),
}
}

    /// `RecipeManager.getRecipe`: look up a crafting recipe by its id name.
pub fn recipe(self: *Self, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let bare = name.strip_prefix("minecraft:").unwrap_or(name);
    // rust: self.crafting
    // rust: .iter()
    // rust: .find(|(n, _)| n == name || n == bare)
    // rust: .map(|(_, r)| r)
}

pub fn load(root: *Path, items: *Items, overlay: *PackOverlay) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let sources = Self::sources(root, overlay)?;
    // rust: Self::from_sources(root, items, overlay, sources)
}
    /// The recipe files the tables are built from, each id once: vanilla's by
    /// bare name, then the content mods' as `<ns>:<name>`, the world's packs'
    /// over them (`overlay`), parsed, and only those whose load conditions
    /// hold. A server sends some of them to its clients (`recipe_content`).
pub fn sources(root: *Path, overlay: *PackOverlay) R {
    // Implementation ported from Horizon
    return undefined;
}
        // Vanilla's recipes by bare name, then content mods' as `<ns>:<name>`.
    // rust: let mut sources: Vec<(String, Vec<u8>)> = Vec::new();
        // NeoForge's load conditions: `mod_loaded` asks which mods' data is
        // in this root (`minecraft`, always, and the content mods').
        // `mod_loaded` asks which mods are loaded, not which namespaces
        // they own: a mod that also owns a namespace doesn't make that
        // namespace another mod.
    // rust: let mods: Vec<String> = {
    // rust: let mut mods = horizon_items::content_namespaces::mod_ids(root);
    // rust: if !mods.iter().any(|m| m == "minecraft") {
    // rust: mods.push("minecraft".to_owned());
}
    // rust: mods
}
    // rust: for file in &crate::json_folder::read(&root.join("data/minecraft/recipe"))?.files {
    // rust: sources.push((file.name.clone(), file.bytes()?.to_vec()));
}
    // rust: for namespace in crate::mod_content::namespaces(root) {
    // rust: let dir = root.join(format!("data/{namespace}/recipe"));
    // rust: if dir.is_dir() {
    // rust: for file in &crate::json_folder::read(&dir)?.files {
    // rust: sources.push((format!("{namespace}:{}", file.name), file.bytes()?.to_vec()));
}
}
}
        // The world's packs' recipes over the game's own: the top pack's
        // file for each id replaces it (`SimpleJsonResourceReloadListener`
        // sees one resource per id, the resource stack's top).
    // rust: for (id, files) in overlay.kind("recipe") {
    // rust: let Some((ns, path)) = id.split_once(':') else {
    // rust: continue;
}
    // rust: let name = if ns == "minecraft" {
    // rust: path.to_owned()
    // rust: } else {
    // rust: id.to_owned()
}
    // rust: let bytes = PackOverlay::top(files).to_vec();
    // rust: match sources.iter_mut().find(|(n, _)| *n == name) {
    // rust: Some(slot) => slot.1 = bytes,
    // rust: None => sources.push((name, bytes)),
}
}
    // rust: let filters = horizon_items::recipe_filters::RecipeFilters::load(root, overlay);
    // rust: let mut parsed = Vec::with_capacity(sources.len());
    // rust: for (name, bytes) in sources {
            // Vanilla's RecipeManager logs a file that does not parse and
            // goes on ("Couldn't parse data file").
    // rust: let mut v: Value = match serde_json::from_slice(&bytes) {
    // rust: Ok(v) => v,
    // rust: Err(e) => {
    // rust: log::warn!("Horizon: recipe {name} not loaded: {e}");
    // rust: continue;
}
}
            // A file whose load conditions don't hold is silently absent,
            // as NeoForge's ICondition leaves it out of the manager.
    // rust: if !horizon_world::conditions::conditions_hold(&v, &|id: &str| {
    // rust: mods.iter().any(|m| m == id)
    // rust: }) {
    // rust: continue;
}
            // The data's recipe filters, over the final set.
    // rust: if !filters.apply(&recipe_id(&name), &mut v) {
    // rust: continue;
}
    // rust: parsed.push((name, v));
}
    // rust: Ok(parsed)
}
    /// The tables from `sources` (`Recipes::sources`' shape); `root` and
    /// `overlay` give the enchantment tags the tables keep.
    // rust: pub fn from_sources(
    // rust: root: &Path,
    // rust: items: &Items,
    // rust: overlay: &PackOverlay,
    // rust: mut sources: Vec<(String, Value)>,
    // rust: ) -> Result<Self> {
        // Every table in registration order, whatever order the sources come
        // in (the world's packs' files after the game's own).
    // rust: sources.sort_by_cached_key(|(name, _)| registration_key(name));
    // rust: let mut crafting = Vec::new();
    // rust: let mut cooking = Vec::new();
    // rust: let mut custom: HashMap<String, Vec<CustomRecipe>> = HashMap::new();
    // rust: let mut meta = HashMap::new();
    // rust: for (name, v) in sources {
    // rust: if let Some(kind) = custom_type(&v) {
    // rust: let id = if name.contains(':') {
    // rust: name
    // rust: } else {
    // rust: format!("minecraft:{name}")
}
    // rust: let kind = kind.to_owned();
    // rust: let json = Arc::new(v);
    // rust: custom
    // rust: .entry(kind)
    // rust: .or_default()
    // rust: .push(CustomRecipe { id, json });
    // rust: continue;
}
    // rust: let text = |k: &str| v[k].as_str().unwrap_or("").to_owned();
    // rust: meta.insert(name.clone(), (text("category"), text("group")));
    // rust: let ing = |k: &str| Ingredient::parse(&v[k], items);
    // rust: let result = || Template::parse(&v["result"]);
    // rust: let special = |recipe: Option<Special>| recipe.map(Recipe::Special);
    // rust: let parsed: Option<Recipe> = match v["type"].as_str().unwrap_or("") {
    // rust: "minecraft:crafting_shaped" => {
    // rust: let pattern: Vec<Vec<char>> = v["pattern"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(|r| r.as_str().map(|s| s.chars().collect()))
    // rust: .collect();
    // rust: let pattern = shrink(&pattern);
    // rust: let height = pattern.len();
    // rust: let width = pattern.first().map_or(0, Vec::len);
    // rust: let mut cells = Vec::with_capacity(width * height);
    // rust: let mut ok = height > 0;
    // rust: for row in &pattern {
    // rust: for c in row {
    // rust: if *c == ' ' {
    // rust: cells.push(None);
    // rust: } else {
    // rust: match Ingredient::parse(&v["key"][c.to_string()], items) {
    // rust: Some(i) => cells.push(Some(i)),
    // rust: None => ok = false,
}
}
}
}
    // rust: match (ok, result()) {
    // rust: (true, Some(result)) => Some(Recipe::Shaped {
    // rust: width,
    // rust: height,
    // rust: cells,
    // rust: result,
    // rust: }),
    // rust: _ => None,
}
}
    // rust: "minecraft:crafting_shapeless" => {
    // rust: let ingredients: Option<Vec<_>> = v["ingredients"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(|i| Ingredient::parse(i, items))
    // rust: .collect();
    // rust: match (ingredients, result()) {
    // rust: (Some(ingredients), Some(result)) => Some(Recipe::Shapeless {
    // rust: ingredients,
    // rust: result,
    // rust: }),
    // rust: _ => None,
}
}
    // rust: "minecraft:crafting_special_bannerduplicate" => special(
    // rust: ing("banner")
    // rust: .zip(horizon_world::loot::recipe_result_id(&v["result"]))
    // rust: .map(|(banner, id)| Special::BannerDuplicate {
    // rust: banner,
    // rust: result: id.to_owned(),
    // rust: }),
    // rust: ),
    // rust: "minecraft:crafting_special_shielddecoration" => special(
    // rust: ing("banner")
    // rust: .zip(ing("target"))
    // rust: .zip(horizon_world::loot::recipe_result_id(&v["result"]))
    // rust: .map(|((banner, target), id)| Special::ShieldDecoration {
    // rust: banner,
    // rust: target,
    // rust: result: id.to_owned(),
    // rust: }),
    // rust: ),
    // rust: "minecraft:crafting_transmute" => special((|| {
    // rust: let (min, max) = bounds(v.get("material_count"), (1, 1), (1, 8));
    // rust: Some(Special::Transmute {
    // rust: input: ing("input")?,
    // rust: material: ing("material")?,
    // rust: min: min.clamp(1, 8) as usize,
    // rust: max: max.clamp(1, 8) as usize,
    // rust: add_count: v["add_material_count_to_result"].as_bool().unwrap_or(false),
    // rust: result: result()?,
    // rust: })
    // rust: })()),
    // rust: "minecraft:crafting_dye" => special((|| {
    // rust: Some(Special::Dye {
    // rust: target: ing("target")?,
    // rust: dye: ing("dye")?,
    // rust: result: result()?,
    // rust: })
    // rust: })()),
    // rust: "minecraft:crafting_imbue" => special((|| {
    // rust: Some(Special::Imbue {
    // rust: source: ing("source")?,
    // rust: material: ing("material")?,
    // rust: result: result()?,
    // rust: })
    // rust: })()),
    // rust: "minecraft:crafting_special_bookcloning" => special((|| {
    // rust: let (min, max) = bounds(v.get("allowed_generations"), (0, 1), (0, 2));
    // rust: Some(Special::BookCloning {
    // rust: source: ing("source")?,
    // rust: material: ing("material")?,
    // rust: min: min as i32,
    // rust: max: max as i32,
    // rust: result: result()?,
    // rust: })
    // rust: })()),
    // rust: "minecraft:crafting_special_firework_rocket" => special((|| {
    // rust: Some(Special::FireworkRocket {
    // rust: shell: ing("shell")?,
    // rust: fuel: ing("fuel")?,
    // rust: star: ing("star")?,
    // rust: result: result()?,
    // rust: })
    // rust: })()),
    // rust: "minecraft:crafting_special_firework_star" => special((|| {
    // rust: let mut shapes = Vec::new();
    // rust: for (shape, value) in v["shapes"].as_object()? {
    // rust: shapes.push((
    // rust: FireworkShape::from_name(shape),
    // rust: Ingredient::parse(value, items)?,
    // rust: ));
}
    // rust: Some(Special::FireworkStar {
    // rust: dye: ing("dye")?,
    // rust: fuel: ing("fuel")?,
    // rust: trail: ing("trail")?,
    // rust: twinkle: ing("twinkle")?,
    // rust: shapes,
    // rust: result: result()?,
    // rust: })
    // rust: })()),
    // rust: "minecraft:crafting_special_firework_star_fade" => special((|| {
    // rust: Some(Special::FireworkStarFade {
    // rust: dye: ing("dye")?,
    // rust: target: ing("target")?,
    // rust: result: result()?,
    // rust: })
    // rust: })()),
    // rust: "minecraft:crafting_special_mapextending" => special((|| {
    // rust: Some(Special::MapExtending {
    // rust: map: ing("map")?,
    // rust: material: ing("material")?,
    // rust: result: result()?,
    // rust: })
    // rust: })()),
    // rust: "minecraft:crafting_decorated_pot" => special((|| {
    // rust: Some(Special::DecoratedPot {
    // rust: back: ing("back")?,
    // rust: left: ing("left")?,
    // rust: right: ing("right")?,
    // rust: front: ing("front")?,
    // rust: result: result()?,
    // rust: })
    // rust: })()),
    // rust: "minecraft:crafting_special_repairitem" => special(Some(Special::RepairItem)),
    // rust: kind @ ("minecraft:smelting"
    // rust: | "minecraft:blasting"
    // rust: | "minecraft:smoking"
    // rust: | "minecraft:campfire_cooking") => {
    // rust: if let (Some(ingredient), Some(result)) = (ing("ingredient"), result()) {
    // rust: cooking.push(Cooking {
    // rust: id: name.clone(),
    // rust: category: text("category"),
    // rust: group: text("group"),
    // rust: kind: kind.to_owned(),
    // rust: ingredient,
    // rust: result: result.create(),
    // rust: experience: v["experience"].as_f64().unwrap_or(0.0) as f32,
    // rust: time: v["cookingtime"].as_u64().unwrap_or(200) as u32,
    // rust: });
}
    // rust: None
}
    // rust: _ => None,
}
    // rust: if let Some(recipe) = parsed {
    // rust: crafting.push((name, recipe));
}
}
    // rust: let facts = items
    // rust: .items
    // rust: .iter()
    // rust: .map(|(id, info)| {
    // rust: (
    // rust: id.clone(),
    // rust: Facts {
    // rust: dye: info.dye.as_deref().and_then(|d| {
    // rust: crate::block_entity_render::DYES
    // rust: .iter()
    // rust: .position(|(name, _)| *name == d)
    // rust: }),
    // rust: max_damage: info.max_damage,
    // rust: max_stack: info.max_stack,
    // rust: remainder: info.crafting_remainder.as_deref().map(Arc::from),
    // rust: },
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: let curses = crate::items::load_tags(root, "enchantment", overlay)?
    // rust: .remove("minecraft:curse")
    // rust: .unwrap_or_default();
    // rust: Ok(Self {
    // rust: crafting,
    // rust: cooking,
    // rust: custom,
    // rust: meta,
    // rust: facts,
    // rust: curses,
    // rust: cook_index: Default::default(),
    // rust: })
}
    /// Match a `size`x`size` grid (row-major) against the crafting recipes.
pub fn craft(self: *Self, grid: *[?ItemStack], size: usize) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.find(grid, size).map(|(_, result)| result)
}
    /// `craft` with the matched recipe's id (the file name without namespace).
pub fn find(self: *Self, grid: *[?ItemStack], size: usize) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.find_with(grid, size, &|_| None)
}
    /// `RecipeManager.getRecipeFor(CRAFTING, ...)` with a lookup for the scale
    /// of a filled map (map extending reads the map's saved data).
    // rust: pub fn find_with(
    // rust: &self,
    // rust: grid: &[Option<ItemStack>],
    // rust: size: usize,
    // rust: map_scale: &dyn Fn(i32) -> Option<u8>,
    // rust: ) -> Option<(&str, ItemStack)> {
    // rust: let input = Input::of(grid, size)?;
    // rust: let ctx = Context {
    // rust: recipes: self,
    // rust: map_scale,
}
    // rust: for (name, recipe) in &self.crafting {
    // rust: if let Some(result) = Self::assemble_if_matches(&ctx, &input, recipe) {
    // rust: return result.map(|r| (name.as_str(), r));
}
}
    // rust: None
}
    /// `Recipe.matches` then `assemble` for one recipe: None when it does
    /// not match, Some(None) when it matches with nothing to make.
    // rust: fn assemble_if_matches(
    // rust: ctx: &Context,
    // rust: input: &Input,
    // rust: recipe: &Recipe,
    // rust: ) -> Option<Option<ItemStack>> {
    // rust: match recipe {
    // rust: Recipe::Special(special) => special
    // rust: .matches(ctx, input)
    // rust: .then(|| special.assemble(ctx, input)),
    // rust: Recipe::Shaped {
    // rust: width,
    // rust: height,
    // rust: cells,
    // rust: result,
    // rust: } => {
    // rust: if *width != input.width
    // rust: || *height != input.height
    // rust: || cells.iter().flatten().count() != input.count()
    // rust: {
    // rust: return None;
}
    // rust: let matches = |mirror: bool| {
    // rust: (0..*height).all(|y| {
    // rust: (0..*width).all(|x| {
    // rust: let rx = if mirror { width - 1 - x } else { x };
    // rust: match (&cells[y * width + rx], input.get(x, y)) {
    // rust: (None, None) => true,
    // rust: (Some(i), Some(s)) => i.test(s),
    // rust: _ => false,
}
    // rust: })
    // rust: })
}
    // rust: (matches(false) || matches(true)).then(|| Some(result.create()))
}
    // rust: Recipe::Shapeless {
    // rust: ingredients,
    // rust: result,
    // rust: } => matches_all(ingredients, &input.stacks()).then(|| Some(result.create())),
}
}
    /// `recipe.matches(craftSlots.asCraftInput())` for one recipe by id
    /// (`minecraft:name`).
pub fn recipe_matches(self: *Self, id: []const u8, grid: *[?ItemStack], size: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = id.trim_start_matches("minecraft:");
    // rust: let Some((_, recipe)) = self.crafting.iter().find(|(n, _)| n == name) else {
    // rust: return false;
}
    // rust: let Some(input) = Input::of(grid, size) else {
    // rust: return false;
}
    // rust: let ctx = Context {
    // rust: recipes: self,
    // rust: map_scale: &|_| None,
}
    // rust: Self::assemble_if_matches(&ctx, &input, recipe).is_some()
}
    /// `Recipe.placementInfo` of a crafting or cooking recipe by id; None for
    /// an unknown id, an empty placement when it is impossible to place.
pub fn placement(self: *Self, id: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = id.trim_start_matches("minecraft:");
    // rust: if let Some(c) = self.cooking.iter().find(|c| c.id == name) {
    // rust: return Some(Placement::of(vec![Some(c.ingredient.clone())], None));
}
    // rust: let (_, recipe) = self.crafting.iter().find(|(n, _)| n == name)?;
    // rust: Some(match recipe {
    // rust: Recipe::Shaped {
    // rust: width,
    // rust: height,
    // rust: cells,
    // rust: ..
    // rust: } => Placement::of(cells.clone(), Some((*width, *height))),
    // rust: Recipe::Shapeless { ingredients, .. } => {
    // rust: Placement::of(ingredients.iter().cloned().map(Some).collect(), None)
}
    // rust: Recipe::Special(Special::Transmute {
    // rust: input,
    // rust: material,
    // rust: max,
    // rust: ..
    // rust: }) => {
    // rust: let mut list = vec![Some(input.clone())];
    // rust: list.extend(std::iter::repeat_n(Some(material.clone()), *max));
    // rust: Placement::of(list, None)
}
    // rust: Recipe::Special(Special::Dye { target, dye, .. }) => {
    // rust: Placement::of(vec![Some(target.clone()), Some(dye.clone())], None)
}
    // rust: Recipe::Special(Special::Imbue {
    // rust: source, material, ..
    // rust: }) => Placement::of(
    // rust: (0..9)
    // rust: .map(|i| Some(if i == 4 { source } else { material }.clone()))
    // rust: .collect(),
    // rust: None,
    // rust: ),
            // CustomRecipe.placementInfo: NOT_PLACEABLE.
    // rust: Recipe::Special(_) => Placement::default(),
    // rust: })
}
    /// `Recipe.getRemainingItems` placed on the `size`x`size` grid: an item's
    /// crafting remainder (buckets, bottles), the patterned banner a duplicate
    /// keeps and the written book a clone keeps.
    // rust: pub fn remainders(
    // rust: &self,
    // rust: recipe: &str,
    // rust: grid: &[Option<ItemStack>],
    // rust: size: usize,
    // rust: ) -> Vec<Option<ItemStack>> {
    // rust: let mut out = vec![None; size * size];
    // rust: let Some(input) = Input::of(grid, size) else {
    // rust: return out;
}
    // rust: let kind = self
    // rust: .crafting
    // rust: .iter()
    // rust: .find(|(n, _)| n == recipe)
    // rust: .map(|(_, r)| r);
    // rust: for (i, cell) in input.cells.iter().enumerate() {
    // rust: let Some(s) = cell else { continue };
    // rust: let at = (input.top + i / input.width) * size + input.left + i % input.width;
    // rust: let rest = self
    // rust: .facts
    // rust: .get(&s.item)
    // rust: .and_then(|f| f.remainder.as_deref())
    // rust: .map(|r| ItemStack::new(r, 1));
    // rust: if rest.is_some() {
    // rust: out[at] = rest;
    // rust: continue;
}
    // rust: let copy = ItemStack {
    // rust: count: 1,
    // rust: ..(*s).clone()
}
    // rust: match kind {
    // rust: Some(Recipe::Special(Special::BannerDuplicate { .. }))
    // rust: if !crate::banner::layers(s).is_empty() =>
    // rust: {
    // rust: out[at] = Some(copy);
}
                // BookCloningRecipe stops at the first copied book.
    // rust: Some(Recipe::Special(Special::BookCloning { .. }))
    // rust: if s.data().is_some_and(|d| d.written.is_some()) =>
    // rust: {
    // rust: out[at] = Some(copy);
    // rust: break;
}
    // rust: _ => {}
}
}
    // rust: out
}
    /// The `experience` of the cooking recipe with this file name, and 0 for one this data
    /// pack does not have (a save from another pack can name it).
    /// `id` with or without the `minecraft:` namespace (a furnace keeps the full id).
pub fn cooking_experience(self: *Self, id: []const u8) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let id = id.strip_prefix("minecraft:").unwrap_or(id);
    // rust: self.cooking
    // rust: .iter()
    // rust: .find(|c| c.id == id)
    // rust: .map_or(0.0, |c| c.experience)
}
pub fn cook(self: *Self, kind: []const u8, input: *ItemStack) O {
    // Implementation ported from Horizon
    return undefined;
}
        // Every recipe an item names, not just the first: a mod's match-time
        // hook may refuse the one the first recipe would take (`Ingredient::test`).
    // rust: let index = self.cook_index.get_or_init(|| {
    // rust: let mut index = CookIndex::new();
    // rust: for (i, c) in self.cooking.iter().enumerate() {
    // rust: let of_kind = index.entry(c.kind.clone()).or_default();
    // rust: for item in &c.ingredient.items {
    // rust: of_kind.entry(item.clone()).or_default().push(i);
}
}
    // rust: index
    // rust: });
    // rust: index
    // rust: .get(kind)?
    // rust: .get(&*input.item)?
    // rust: .iter()
    // rust: .find_map(|i| self.cooking.get(*i).filter(|c| c.ingredient.test(input)))
}
    /// `cook` by scanning every recipe, as it was before the index.
pub fn cook_scan(self: *Self, kind: []const u8, input: *ItemStack) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.cooking
    // rust: .iter()
    // rust: .find(|c| c.kind == kind && c.ingredient.test(input))
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::banner::BannerLayer;
//     use std::fs;

    /// ItemStackTemplate.apply applies the result patch after the input patch.
pub fn transmute_result_patch_preserves_inheritance_and_explicit_removals() void {
}
    // rust: let input_tag = json_tag(&serde_json::json!({
    // rust: "minecraft:damage": 5, "minecraft:lore": ["Old"]
    // rust: }));
    // rust: let (damage, extra) = crate::item_data::decode_components(Some(&input_tag));
    // rust: let input = ItemStack {
    // rust: item: "minecraft:wooden_sword".into(),
    // rust: count: 1,
    // rust: damage,
    // rust: extra,
}
    // rust: for (components, expected_damage, removed) in [
    // rust: (
    // rust: serde_json::json!({"minecraft:custom_name": "Kept"}),
    // rust: 5,
    // rust: false,
    // rust: ),
    // rust: (
    // rust: serde_json::json!({"minecraft:custom_name": "Up", "!minecraft:damage": {}}),
    // rust: 0,
    // rust: true,
    // rust: ),
    // rust: (
    // rust: serde_json::json!({"minecraft:custom_name": "Zero", "minecraft:damage": 0}),
    // rust: 0,
    // rust: false,
    // rust: ),
    // rust: ] {
    // rust: let template = Template::parse(&serde_json::json!({
    // rust: "id": "minecraft:stone_sword", "components": components
    // rust: }))
    // rust: .unwrap();
    // rust: let output = template.over(&input, 0);
    // rust: assert_eq!(output.item.as_ref(), "minecraft:stone_sword");
    // rust: assert_eq!(output.damage, expected_damage);
    // rust: let encoded = crate::item_data::encode_components(&output).unwrap();
    // rust: assert_eq!(
    // rust: encoded.get("minecraft:lore"),
    // rust: input_tag.get("minecraft:lore")
    // rust: );
    // rust: assert_eq!(
    // rust: encoded.get("minecraft:custom_name"),
    // rust: Some(&json_tag(&components["minecraft:custom_name"]))
    // rust: );
    // rust: assert_eq!(encoded.get("!minecraft:damage").is_some(), removed);
    // rust: if expected_damage == 0 {
    // rust: assert!(encoded.get("minecraft:damage").is_none());
}
}
    // rust: let mut map = input.clone();
    // rust: map.data_mut().map_post_processing = Some(1);
    // rust: let template = Template::parse(&serde_json::json!({"id": "minecraft:filled_map"})).unwrap();
    // rust: let output = template.over(&map, 0);
    // rust: assert_eq!(output.data().unwrap().map_post_processing, Some(1));
    // rust: assert!(
    // rust: crate::item_data::encode_components(&output)
    // rust: .unwrap()
    // rust: .get("minecraft:map_post_processing")
    // rust: .is_none()
    // rust: );
}

pub fn result_count_is_bounded_like_vanilla() void {
}
    // rust: let parse = |s: &str| Template::parse(&serde_json::from_str(s).unwrap());
    // rust: assert_eq!(parse(r#"{"id":"minecraft:stone"}"#).unwrap().count, 1);
    // rust: let top = parse(r#"{"id":"minecraft:stone","count":99}"#);
    // rust: assert_eq!(top.unwrap().count, 99);
    // rust: for bad in [
    // rust: "0",
    // rust: "100",
    // rust: "2147483648",
    // rust: "4294967295",
    // rust: "4294967296",
    // rust: "-1",
    // rust: "1.5",
    // rust: "\"2\"",
    // rust: ] {
    // rust: let json = format!(r#"{{"id":"minecraft:stone","count":{bad}}}"#);
    // rust: assert!(parse(&json).is_none(), "count {bad} must be rejected");
}
}

    /// A mod's recipe whose ingredient is one of NeoForge's standard shapes
    /// loads and carries the resolved items, where the plain string parser
    /// used to drop the file whole.
pub fn a_neoforge_ingredient_recipe_loads() void {
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-neo-ingredient-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: fs::create_dir_all(root.join("data/minecraft/recipe")).unwrap();
    // rust: fs::create_dir_all(root.join("data/mymod/recipe")).unwrap();
    // rust: fs::write(
    // rust: root.join(horizon_items::content_namespaces::MARKER),
    // rust: br#"["mymod"]"#,
    // rust: )
    // rust: .unwrap();
    // rust: let recipe = r##"{
    // rust: "type": "minecraft:crafting_shapeless",
    // rust: "ingredients": [
    // rust: {"neoforge:ingredient_type": "neoforge:compound",
    // rust: "children": ["minecraft:oak_planks", "minecraft:birch_planks"]},
    // rust: {"type": "neoforge:difference",
    // rust: "base": ["minecraft:oak_planks", "minecraft:birch_planks"],
    // rust: "subtracted": "minecraft:birch_planks"}
    // rust: ],
    // rust: "result": {"id": "minecraft:stick", "count": 4}
    // rust: }"##;
    // rust: fs::write(root.join("data/mymod/recipe/treated.json"), recipe).unwrap();
    // rust: let items = Items::for_tests(HashMap::new());
    // rust: let recipes = Recipes::load(&root, &items, &PackOverlay::NONE).unwrap();
    // rust: assert_eq!(recipes.crafting.len(), 1);
    // rust: assert_eq!(recipes.crafting[0].0, "mymod:treated");
    // rust: let _ = fs::remove_dir_all(&root);
}

    /// NeoForge's standard ingredient shapes resolve to their flat item
    /// lists; a kind the loader doesn't know still fails the file.
pub fn an_unclaimed_ingredient_kind_fails_and_dedup_keeps_order() void {
}
    // rust: let items = Items::for_tests(HashMap::new());
    // rust: let json = |s: &str| serde_json::from_str::<Value>(s).unwrap();
    // rust: assert!(
    // rust: Ingredient::parse(&json(r#"{"type":"mymod:aspect","aspect":"fire"}"#), &items,)
    // rust: .is_none()
    // rust: );
    // rust: assert!(
    // rust: Ingredient::parse(&json(r#"{"type":"minecraft:future_shape"}"#), &items,).is_none()
    // rust: );
    // rust: assert!(Ingredient::parse(&json(r#"{"type":"aspect"}"#), &items,).is_none());
    // rust: let mut list = vec!["b".to_string(), "a".to_string(), "b".to_string()];
    // rust: dedup_keep_order(&mut list);
    // rust: assert_eq!(list, vec!["b".to_string(), "a".to_string()]);
}

    /// NeoForge's shapes keep their children, and matching a concrete
    /// stack asks each child its own way — any for compound, all for
    /// intersection, base-but-not-subtracted for difference. A mod's own
    /// kind among the children answers through its hook the same way
    /// (proven on a staged build).
pub fn nested_shapes_test_each_child_their_own_way() void {
}
    // rust: let items = Items::for_tests(HashMap::new());
    // rust: let parse = |s: &str| {
    // rust: Ingredient::parse(&serde_json::from_str::<Value>(s).unwrap(), &items).unwrap()
}
    // rust: let stack = |n: &str| ItemStack {
    // rust: item: n.into(),
    // rust: count: 1,
    // rust: damage: 0,
    // rust: extra: None,
}
    // rust: let compound = parse(
    // rust: r#"{"type":"neoforge:compound","children":["minecraft:oak_planks","minecraft:birch_planks"]}"#,
    // rust: );
    // rust: assert!(compound.children.is_some(), "the children stay with it");
    // rust: assert!(compound.test(&stack("minecraft:oak_planks")));
    // rust: assert!(compound.test(&stack("minecraft:birch_planks")));
    // rust: assert!(!compound.test(&stack("minecraft:stone")));
    // rust: let inter = parse(
    // rust: r#"{"type":"neoforge:intersection","ingredients":["minecraft:oak_planks",["minecraft:oak_planks","minecraft:birch_planks"]]}"#,
    // rust: );
    // rust: assert!(inter.test(&stack("minecraft:oak_planks")));
    // rust: assert!(!inter.test(&stack("minecraft:birch_planks")));
    // rust: let diff = parse(
    // rust: r#"{"type":"neoforge:difference","base":["minecraft:oak_planks","minecraft:birch_planks"],"subtracted":"minecraft:birch_planks"}"#,
    // rust: );
    // rust: assert!(diff.test(&stack("minecraft:oak_planks")));
    // rust: assert!(!diff.test(&stack("minecraft:birch_planks")));
}

pub fn neoforge_ingredient_shapes_parse() void {
}
    // rust: let mut tags = HashMap::new();
    // rust: tags.insert(
    // rust: "minecraft:planks".to_owned(),
    // rust: ["minecraft:oak_planks", "minecraft:birch_planks"]
    // rust: .iter()
    // rust: .map(|s| s.to_string())
    // rust: .collect::<HashSet<_>>(),
    // rust: );
    // rust: let items = Items::for_tests(tags);
    // rust: let json = |s: &str| serde_json::from_str::<Value>(s).unwrap();
        // Compound (`CompoundIngredient`): any child matching is enough —
        // the union of their items, a tag beside an item gives both.
    // rust: let union = Ingredient::parse(
    // rust: &json(r##"{"neoforge:ingredient_type":"neoforge:compound","children":["#minecraft:planks","minecraft:stone"]}"##),
    // rust: &items,
    // rust: )
    // rust: .unwrap();
        // The tag's items come from a HashSet: their order is not fixed.
    // rust: let mut all = union.order.clone();
    // rust: all.sort();
    // rust: assert_eq!(
    // rust: all,
    // rust: [
    // rust: "minecraft:birch_planks",
    // rust: "minecraft:oak_planks",
    // rust: "minecraft:stone"
    // rust: ]
    // rust: );
        // Intersection: every child must match — only the items all name.
    // rust: let both = Ingredient::parse(
    // rust: &json(r##"{"type":"neoforge:intersection","children":["#minecraft:planks","minecraft:oak_planks"]}"##),
    // rust: &items,
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(both.order, ["minecraft:oak_planks"]);
        // Difference: the base without the subtracted.
    // rust: let no_oak = Ingredient::parse(
    // rust: &json(r##"{"type":"neoforge:difference","base":"#minecraft:planks","subtracted":"minecraft:oak_planks"}"##),
    // rust: &items,
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(no_oak.order, ["minecraft:birch_planks"]);
        // An empty intersection and an unknown kind fail the file, as today.
    // rust: let empty = Ingredient::parse(
    // rust: &json(
    // rust: r#"{"type":"neoforge:intersection","children":["minecraft:oak_planks","minecraft:birch_planks"]}"#,
    // rust: ),
    // rust: &items,
    // rust: );
    // rust: assert!(empty.is_none());
    // rust: let unknown =
    // rust: Ingredient::parse(&json(r#"{"type":"mymod:aspect","aspect":"fire"}"#), &items);
    // rust: assert!(unknown.is_none());
}

pub fn ingredient(items: *[[]const u8]) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ingredient::of(items.iter().map(|s| (*s).to_owned()).collect())
}
pub fn patterned(item: []const u8) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut s = ItemStack::new(item, 1);
    // rust: s.data_mut().banner_patterns = vec![BannerLayer::new("minecraft:cross", "red")];
    // rust: s
}
    /// About vanilla's count of cooking recipes: four kinds, ingredients of
    /// one to twelve items, overlapping (several recipes take some items).
pub fn cooking_book() R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let kinds = ["smelting", "blasting", "smoking", "campfire_cooking"];
    // rust: let cooking = (0..320usize)
    // rust: .map(|i| Cooking {
    // rust: id: format!("r{i}"),
    // rust: category: "misc".into(),
    // rust: group: String::new(),
    // rust: kind: kinds[i % 4].into(),
    // rust: ingredient: ingredient(
    // rust: &(0..1 + i % 12)
    // rust: .map(|k| format!("minecraft:item_{}", (i * 7 + k * 13) % 400))
    // rust: .collect::<Vec<_>>()
    // rust: .iter()
    // rust: .map(String::as_str)
    // rust: .collect::<Vec<_>>(),
    // rust: ),
    // rust: result: ItemStack::new("minecraft:stone", 1),
    // rust: experience: 0.1,
    // rust: time: 200,
    // rust: })
    // rust: .collect();
    // rust: Recipes {
    // rust: crafting: Vec::new(),
    // rust: cooking,
    // rust: custom: HashMap::new(),
    // rust: meta: HashMap::new(),
    // rust: facts: HashMap::new(),
    // rust: curses: HashSet::new(),
    // rust: cook_index: Default::default(),
}
}
pub fn only_types_outside_minecraft_are_custom() void {
}
    // rust: let kind = |json: &str| {
    // rust: let v: Value = serde_json::from_str(json).unwrap();
    // rust: custom_type(&v).map(str::to_owned)
}
    // rust: assert_eq!(
    // rust: kind(r#"{"type":"mymod:crusher"}"#).as_deref(),
    // rust: Some("mymod:crusher")
    // rust: );
    // rust: assert_eq!(kind(r#"{"type":"minecraft:smelting"}"#), None);
    // rust: assert_eq!(kind(r#"{"type":"minecraft:from_a_later_version"}"#), None);
    // rust: assert_eq!(kind(r#"{"type":"no_namespace"}"#), None);
    // rust: assert_eq!(kind(r#"{"type":7}"#), None);
    // rust: assert_eq!(kind("{}"), None);
}
    /// Recipes of a mod's own types land in `custom` by type, in registration order,
    /// with the id the file has; a data pack overrides by id and adds more; a
    /// `minecraft` type the game doesn't know is dropped.
pub fn custom_recipes_load_by_type_with_pack_override() void {
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-custom-recipes-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: fs::create_dir_all(root.join("data/minecraft/recipe")).unwrap();
    // rust: fs::create_dir_all(root.join("data/mymod/recipe")).unwrap();
    // rust: fs::write(
    // rust: root.join(horizon_items::content_namespaces::MARKER),
    // rust: br#"["mymod"]"#,
    // rust: )
    // rust: .unwrap();
    // rust: let file =
    // rust: |kind: &str, tag: &str| format!(r#"{{"type":"{kind}","tag":"{tag}"}}"#).into_bytes();
    // rust: fs::write(
    // rust: root.join("data/mymod/recipe/a.json"),
    // rust: file("mymod:crusher", "a"),
    // rust: )
    // rust: .unwrap();
    // rust: fs::write(
    // rust: root.join("data/mymod/recipe/b.json"),
    // rust: file("mymod:crusher", "b"),
    // rust: )
    // rust: .unwrap();
    // rust: fs::write(
    // rust: root.join("data/mymod/recipe/c.json"),
    // rust: file("mymod:mixer", "c"),
    // rust: )
    // rust: .unwrap();
    // rust: fs::create_dir_all(root.join("data/mymod/recipe/deep/er")).unwrap();
    // rust: fs::write(
    // rust: root.join("data/mymod/recipe/deep/er/d.json"),
    // rust: file("mymod:mixer", "d"),
    // rust: )
    // rust: .unwrap();
    // rust: fs::write(
    // rust: root.join("data/minecraft/recipe/later.json"),
    // rust: file("minecraft:from_a_later_version", "x"),
    // rust: )
    // rust: .unwrap();
    // rust: let items = Items::for_tests(HashMap::new());
    // rust: let recipes = Recipes::load(&root, &items, &PackOverlay::NONE).unwrap();
    // rust: let ids = |kind: &str| -> Vec<String> {
    // rust: recipes.custom[kind].iter().map(|r| r.id.clone()).collect()
}
    // rust: assert_eq!(ids("mymod:crusher"), ["mymod:a", "mymod:b"]);
    // rust: assert_eq!(ids("mymod:mixer"), ["mymod:c", "mymod:deep/er/d"]);
    // rust: assert_eq!(recipes.custom.len(), 2);
        // Not crafted, and no recipe-book meta of their own.
    // rust: assert!(recipes.crafting.is_empty() && recipes.cooking.is_empty());
    // rust: assert!(!recipes.meta.keys().any(|k| k.starts_with("mymod:")));
        // A pack replaces `mymod:b`, and adds `pack:d` and a `minecraft:p` of its own type.
    // rust: let packs = [
    // rust: (
    // rust: "recipe/mymod:b".to_owned(),
    // rust: vec![file("mymod:crusher", "pack-b")],
    // rust: ),
    // rust: ("recipe/pack:d".to_owned(), vec![file("mymod:crusher", "d")]),
    // rust: (
    // rust: "recipe/minecraft:p".to_owned(),
    // rust: vec![file("pack:press", "p")],
    // rust: ),
    // rust: ];
    // rust: let recipes = Recipes::load(&root, &items, &PackOverlay { files: &packs }).unwrap();
    // rust: let crusher = &recipes.custom["mymod:crusher"];
    // rust: assert_eq!(
    // rust: crusher.iter().map(|r| r.id.as_str()).collect::<Vec<_>>(),
    // rust: ["mymod:a", "mymod:b", "pack:d"]
    // rust: );
    // rust: assert_eq!(crusher[1].json["tag"], "pack-b");
    // rust: assert_eq!(recipes.custom["pack:press"][0].id, "minecraft:p");
    // rust: let _ = fs::remove_dir_all(&root);
}
pub fn a_recipe_result_needs_an_item_and_a_sane_count() void {
}
    // rust: let result = |json: &str| recipe_result(&serde_json::from_str(json).unwrap());
    // rust: let stack = result(r#"{"id":"minecraft:iron_ingot","count":2}"#).unwrap();
    // rust: assert_eq!((&*stack.item, stack.count), ("minecraft:iron_ingot", 2));
    // rust: assert_eq!(result(r#"{"id":"minecraft:iron_ingot"}"#).unwrap().count, 1);
    // rust: assert!(result(r#"{"count":2}"#).is_none());
    // rust: assert!(result(r#"{"id":"minecraft:iron_ingot","count":0}"#).is_none());
}
pub fn a_recipe_result_can_be_a_bare_item_id() void {
}
        // `ItemStackTemplate.CODEC` falls back to `Item.CODEC`: `"result": "mod:item"` is one item.
    // rust: let result = |json: &str| recipe_result(&serde_json::from_str(json).unwrap());
    // rust: let stack = result(r#""ruby:ruby""#).unwrap();
    // rust: assert_eq!((&*stack.item, stack.count), ("ruby:ruby", 1));
        // The `item` key of older versions is no `id`, and a number names no item.
    // rust: assert!(result(r#"{"item":"ruby:ruby"}"#).is_none());
    // rust: assert!(result("42").is_none());
}
pub fn a_shapeless_recipe_makes_the_item_its_bare_result_names() void {
}
    // rust: let root = std::env::temp_dir().join(format!("horizon-bare-result-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: fs::create_dir_all(root.join("data/minecraft/recipe")).unwrap();
    // rust: fs::write(
    // rust: root.join("data/minecraft/recipe/bare.json"),
    // rust: br#"{"type":"minecraft:crafting_shapeless","ingredients":["minecraft:flint"],"result":"minecraft:stick"}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let items = Items::for_tests(HashMap::new());
    // rust: let recipes = Recipes::load(&root, &items, &PackOverlay::NONE).unwrap();
    // rust: let grid = [Some(ItemStack::new("minecraft:flint", 1)), None, None, None];
    // rust: let (_, made) = recipes.find(&grid, 2).unwrap();
    // rust: assert_eq!((&*made.item, made.count), ("minecraft:stick", 1));
    // rust: let _ = fs::remove_dir_all(&root);
}

    /// ResourceManagerRegistryLoadTask registers by resource-file Identifier,
    /// and RecipeMap keeps that order when taking the first matching recipe,
    /// for the crafting grid and the furnaces alike.
pub fn recipe_selection_follows_resource_file_order() void {
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-recipe-order-{}", std::process::id()));
    // rust: fs::create_dir_all(root.join("data/minecraft/recipe")).unwrap();
    // rust: let items = Items::for_tests(HashMap::new());
    // rust: let crafting = |item: &str| {
    // rust: serde_json::json!({
    // rust: "type": "minecraft:crafting_shapeless", "ingredients": ["minecraft:flint"],
    // rust: "result": {"id": item}
    // rust: })
}
    // rust: let smelting = |item: &str| {
    // rust: serde_json::json!({
    // rust: "type": "minecraft:smelting", "ingredient": "minecraft:flint",
    // rust: "result": {"id": item}
    // rust: })
}
    // rust: let flint = ItemStack::new("minecraft:flint", 1);
    // rust: let cases = [
    // rust: (vec!["minecraft:z_pick", "parity:a_pick"], "parity:a_pick"),
    // rust: (
    // rust: vec!["a_priority:z_pick", "z_priority:a_pick"],
    // rust: "z_priority:a_pick",
    // rust: ),
    // rust: (
    // rust: vec!["z_priority:equal", "a_priority:equal"],
    // rust: "a_priority:equal",
    // rust: ),
            // File names include .json: '-' sorts before the parent's '.'.
    // rust: (
    // rust: vec!["parity:prefix", "parity:prefix-early"],
    // rust: "parity:prefix-early",
    // rust: ),
    // rust: (vec!["z_pick", "parity:a_pick"], "parity:a_pick"),
    // rust: ];
    // rust: let kinds: [(&str, &dyn Fn(&str) -> serde_json::Value); 2] =
    // rust: [("crafting", &crafting), ("smelting", &smelting)];
    // rust: for (ids, expected) in cases {
    // rust: for (kind, recipe) in kinds {
    // rust: for reverse in [false, true] {
    // rust: let mut sources: Vec<_> = ids
    // rust: .iter()
    // rust: .map(|id| (id.to_string(), recipe("minecraft:stick")))
    // rust: .collect();
    // rust: if reverse {
    // rust: sources.reverse();
}
    // rust: let recipes =
    // rust: Recipes::from_sources(&root, &items, &PackOverlay::NONE, sources).unwrap();
    // rust: let (id, result) = match kind {
    // rust: "crafting" => recipes.find(&[Some(flint.clone())], 1).unwrap(),
    // rust: _ => {
    // rust: let c = recipes.cook("minecraft:smelting", &flint).unwrap();
    // rust: (c.id.as_str(), c.result.clone())
}
}
    // rust: assert_eq!(
    // rust: id, expected,
    // rust: "{kind}, input order: {ids:?}, reversed={reverse}"
    // rust: );
    // rust: assert_eq!(&*result.item, "minecraft:stick");
}
}
}
    // rust: let _ = fs::remove_dir_all(&root);
}

    /// A recipe whose `neoforge:conditions` hold loads, one whose don't is
    /// silently absent, from the root's own files and a pack's alike.
pub fn load_conditions_gate_recipes() void {
}
    // rust: let root = std::env::temp_dir().join(format!("horizon-conditions-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: fs::create_dir_all(root.join("data/minecraft/recipe")).unwrap();
    // rust: fs::write(
    // rust: root.join(horizon_items::content_namespaces::MARKER),
    // rust: br#"["mymod"]"#,
    // rust: )
    // rust: .unwrap();
    // rust: fs::write(
    // rust: root.join(horizon_items::content_namespaces::MOD_IDS_MARKER),
    // rust: br#"["mymod"]"#,
    // rust: )
    // rust: .unwrap();
    // rust: let file = |conditions: &str, tag: &str| {
    // rust: format!(
    // rust: r#"{{"type":"mymod:crusher","tag":"{tag}","neoforge:conditions":{conditions}}}"#
    // rust: )
    // rust: .into_bytes()
}
        // `mymod` is in the root, `ic2` is not.
    // rust: fs::write(
    // rust: root.join("data/minecraft/recipe/yes.json"),
    // rust: file(r#"[{"type":"neoforge:mod_loaded","modid":"mymod"}]"#, "yes"),
    // rust: )
    // rust: .unwrap();
    // rust: fs::write(
    // rust: root.join("data/minecraft/recipe/no.json"),
    // rust: file(r#"[{"type":"neoforge:mod_loaded","modid":"ic2"}]"#, "no"),
    // rust: )
    // rust: .unwrap();
    // rust: fs::write(
    // rust: root.join("data/minecraft/recipe/inverted.json"),
    // rust: file(
    // rust: r#"[{"type":"neoforge:not","value":{"type":"neoforge:mod_loaded","modid":"ic2"}}]"#,
    // rust: "inverted",
    // rust: ),
    // rust: )
    // rust: .unwrap();
    // rust: let items = Items::for_tests(HashMap::new());
    // rust: let recipes = Recipes::load(&root, &items, &PackOverlay::NONE).unwrap();
    // rust: let ids = &recipes.custom["mymod:crusher"];
    // rust: assert_eq!(
    // rust: ids.iter().map(|r| r.id.as_str()).collect::<Vec<_>>(),
    // rust: ["minecraft:inverted", "minecraft:yes"]
    // rust: );
        // A pack's gated file answers the same gate.
    // rust: let packs = [(
    // rust: "recipe/minecraft:pack_yes".to_owned(),
    // rust: vec![file(r#"[{"type":"neoforge:true"}]"#, "pack_yes")],
    // rust: )];
    // rust: let recipes = Recipes::load(&root, &items, &PackOverlay { files: &packs }).unwrap();
    // rust: let ids = &recipes.custom["mymod:crusher"];
    // rust: assert!(ids.iter().any(|r| r.id == "minecraft:pack_yes"));
    // rust: let _ = fs::remove_dir_all(&root);
}
    /// A pack's recipe filter removes a recipe and swaps a mod recipe's input
    /// in the loaded tables, after the packs are merged.
pub fn recipe_filters_remove_and_swap() void {
}
    // rust: let root = std::env::temp_dir().join(format!("horizon-filters-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: fs::create_dir_all(root.join("data/minecraft/recipe")).unwrap();
    // rust: let crusher = |input: &str| {
    // rust: format!(
    // rust: r#"{{"type":"mymod:crusher","input":"{input}","result":{{"id":"mymod:dust"}}}}"#
    // rust: )
    // rust: .into_bytes()
}
    // rust: fs::write(
    // rust: root.join("data/minecraft/recipe/iron.json"),
    // rust: crusher("minecraft:iron_ingot"),
    // rust: )
    // rust: .unwrap();
    // rust: fs::write(
    // rust: root.join("data/minecraft/recipe/gold.json"),
    // rust: crusher("minecraft:gold_ingot"),
    // rust: )
    // rust: .unwrap();
    // rust: let filter = br##"{"filters":[
    // rust: {"id":"minecraft:gold","remove":true},
    // rust: {"type":"mymod:*","replace_input":{"from":"minecraft:iron_ingot","to":"#c:ingots/iron"}}
    // rust: ]}"##;
    // rust: let packs = [("recipe_filter/pack:f".to_owned(), vec![filter.to_vec()])];
    // rust: let items = Items::for_tests(HashMap::new());
    // rust: let recipes = Recipes::load(&root, &items, &PackOverlay { files: &packs }).unwrap();
    // rust: let crushed = &recipes.custom["mymod:crusher"];
    // rust: assert_eq!(
    // rust: crushed.iter().map(|r| r.id.as_str()).collect::<Vec<_>>(),
    // rust: ["minecraft:iron"]
    // rust: );
    // rust: assert_eq!(crushed[0].json["input"], "#c:ingots/iron");
    // rust: let _ = fs::remove_dir_all(&root);
}
pub fn cook_finds_the_first_recipe_the_scan_finds() void {
}
    // rust: let recipes = cooking_book();
    // rust: for kind in [
    // rust: "smelting",
    // rust: "blasting",
    // rust: "smoking",
    // rust: "campfire_cooking",
    // rust: "other",
    // rust: ] {
    // rust: for n in 0..420 {
    // rust: let stack = ItemStack::new(&format!("minecraft:item_{n}"), 1);
    // rust: let a = recipes.cook(kind, &stack).map(|c| &c.id);
    // rust: let b = recipes.cook_scan(kind, &stack).map(|c| &c.id);
    // rust: assert_eq!(a, b, "{kind} item_{n}");
}
}
}
    /// A furnace's recipe lookup, once per lit furnace per tick.
pub fn cook_cost() void {
}
    // rust: let recipes = cooking_book();
    // rust: let stacks: Vec<ItemStack> = (0..1000)
    // rust: .map(|n| ItemStack::new(&format!("minecraft:item_{}", n % 400), 1))
    // rust: .collect();
    // rust: let t = std::time::Instant::now();
    // rust: let a = stacks
    // rust: .iter()
    // rust: .filter(|s| recipes.cook_scan("smelting", s).cloned().is_some())
    // rust: .count();
    // rust: let before = t.elapsed().as_secs_f64() * 1e3;
    // rust: recipes.cook("smelting", &stacks[0]);
    // rust: let t = std::time::Instant::now();
    // rust: let b = stacks
    // rust: .iter()
    // rust: .filter(|s| recipes.cook("smelting", s).is_some())
    // rust: .count();
    // rust: let after = t.elapsed().as_secs_f64() * 1e3;
    // rust: assert_eq!(a, b);
    // rust: println!("1000 furnace lookups (scan and clone -> index): {before:.3} ms -> {after:.3} ms");
}
pub fn run(special: *Special, cells: *[ItemStack]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let recipes = Recipes {
    // rust: crafting: Vec::new(),
    // rust: cooking: Vec::new(),
    // rust: custom: HashMap::new(),
    // rust: meta: HashMap::new(),
    // rust: facts: HashMap::new(),
    // rust: curses: HashSet::new(),
    // rust: cook_index: Default::default(),
}
    // rust: let ctx = Context {
    // rust: recipes: &recipes,
    // rust: map_scale: &|_| None,
}
    // rust: let mut grid: Vec<Option<ItemStack>> = cells.iter().cloned().map(Some).collect();
    // rust: grid.resize(9, None);
    // rust: let input = Input::of(&grid, 3)?;
    // rust: special
    // rust: .matches(&ctx, &input)
    // rust: .then(|| special.assemble(&ctx, &input))
    // rust: .flatten()
}
pub fn banner_duplicate_copies_the_patterns_of_the_same_colour() void {
}
    // rust: let recipe = Special::BannerDuplicate {
    // rust: banner: ingredient(&["minecraft:white_banner"]),
    // rust: result: "minecraft:white_banner".into(),
}
    // rust: let source = patterned("minecraft:white_banner");
    // rust: let blank = ItemStack::new("minecraft:white_banner", 1);
    // rust: let out = run(&recipe, &[source.clone(), blank.clone()]).expect("copy");
    // rust: assert_eq!(out.data().unwrap().banner_patterns.len(), 1);
        // Two blanks, or two patterned banners, do not match.
    // rust: assert!(run(&recipe, &[blank.clone(), blank.clone()]).is_none());
    // rust: assert!(run(&recipe, &[source.clone(), source.clone()]).is_none());
        // Another colour is not in the recipe's ingredient.
    // rust: let other = ItemStack::new("minecraft:red_banner", 1);
    // rust: assert!(run(&recipe, &[source, other]).is_none());
}
pub fn shield_decoration_needs_a_bare_shield() void {
}
    // rust: let recipe = Special::ShieldDecoration {
    // rust: banner: ingredient(&["minecraft:red_banner"]),
    // rust: target: ingredient(&["minecraft:shield"]),
    // rust: result: "minecraft:shield".into(),
}
    // rust: let banner = patterned("minecraft:red_banner");
    // rust: let shield = ItemStack::new("minecraft:shield", 1);
    // rust: let out = run(&recipe, &[banner.clone(), shield]).expect("decorated");
    // rust: let data = out.data().unwrap();
    // rust: assert_eq!(data.base_color.as_deref(), Some("red"));
    // rust: assert_eq!(data.banner_patterns.len(), 1);
        // A shield that already has patterns cannot be decorated again.
    // rust: assert!(run(&recipe, &[banner, out]).is_none());
}
pub fn shapeless_matching_assigns_each_stack_one_ingredient() void {
}
    // rust: let any = ingredient(&["a", "b"]);
    // rust: let only_a = ingredient(&["a"]);
    // rust: let (a, b) = (ItemStack::new("a", 1), ItemStack::new("b", 1));
        // Greedy matching would give `a` to the first ingredient and fail.
    // rust: assert!(matches_all(&[any.clone(), only_a.clone()], &[&a, &b]));
    // rust: assert!(!matches_all(&[only_a.clone(), only_a], &[&a, &b]));
    // rust: assert!(!matches_all(&[any], &[&a, &b]));
}
pub fn dyes_blend_like_dyed_item_color() void {
}
        // One red dye on an undyed item gives the dye's own colour.
    // rust: assert_eq!(apply_dyes(None, &[14]), 0xB02E26);
}
}
