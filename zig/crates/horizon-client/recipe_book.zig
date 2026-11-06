//! Transpiled from Horizon Rust crate
//! Module: horizon-client_recipe_book
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The recipe book: what the book shows for each menu (`RecipeBookType`
//! tabs, `RecipeBookCategories`, groups), which recipes the player can craft
//! with the items at hand (`StackedItemContents.canCraft` and the biggest
//! craftable stack), where a recipe goes in a grid (`PlaceRecipeHelper`) and
//! the book's saved settings.
// use crate::{
    // rust: crafting::{Ingredient, Placement, Recipe, Recipes},
    // rust: items::{ItemStack, Items},
}
// use horizon_world::loot::PackOverlay;
// use horizon_world::nbt::Tag;
// use std::collections::{BTreeSet, HashMap};

/// A native mod's book category for one custom recipe type.
pub const RecipeBookCategory = struct {
    /// A namespaced category id outside `minecraft:`.
    id: []const u8,
    /// A custom type present in the current recipe table.
    recipe_type: []const u8,
    /// A registered item id used as the category's icon.
    icon: []const u8,
};

/// Validate declarations once per recipe table. The first valid declaration
/// owns its category id and recipe type; vanilla categories are never replaced.
    // rust: pub fn mod_categories(
    // rust: declarations: Vec<RecipeBookCategory>,
    // rust: recipes: &Recipes,
    // rust: items: &Items,
    // rust: ) -> HashMap<String, RecipeBookCategory> {
    // rust: let valid_id = |id: &str| {
    // rust: id.split_once(':').is_some_and(|(namespace, path)| {
    // rust: !namespace.is_empty()
    // rust: && !path.is_empty()
    // rust: && namespace.bytes().all(|byte| {
    // rust: byte.is_ascii_lowercase() || byte.is_ascii_digit() || b"_.-".contains(&byte)
    // rust: })
    // rust: && path.bytes().all(|byte| {
    // rust: byte.is_ascii_lowercase() || byte.is_ascii_digit() || b"/_.-".contains(&byte)
    // rust: })
    // rust: })
}
    // rust: let mut categories = HashMap::new();
    // rust: let mut ids = BTreeSet::new();
    // rust: for category in declarations {
    // rust: let reason = if !valid_id(&category.id) || category.id.starts_with("minecraft:") {
    // rust: Some("invalid or reserved category id")
    // rust: } else if !valid_id(&category.recipe_type)
    // rust: || category.recipe_type.starts_with("minecraft:")
    // rust: || !recipes.custom.contains_key(&category.recipe_type)
    // rust: {
    // rust: Some("unknown or vanilla recipe type")
    // rust: } else if !valid_id(&category.icon)
    // rust: || category.icon == "minecraft:air"
    // rust: || items.get(&category.icon).is_none()
    // rust: {
    // rust: Some("missing or unknown icon item")
    // rust: } else if ids.contains(&category.id) || categories.contains_key(&category.recipe_type) {
    // rust: Some("duplicate category id or recipe type")
    // rust: } else {
    // rust: None
}
    // rust: if let Some(reason) = reason {
    // rust: log::warn!("recipe book category {:?} skipped: {reason}", category);
    // rust: continue;
}
    // rust: ids.insert(category.id.clone());
    // rust: categories.insert(category.recipe_type.clone(), category);
}
    // rust: categories
}

/// `RecipeBookType`: the menus with a recipe book and their own settings.
pub const BookType = enum {
    Crafting,
    Furnace,
    BlastFurnace,
    Smoker,
};
    // rust: impl BookType {
    // rust: pub const ALL: [Self; 4] = [
    // rust: Self::Crafting,
    // rust: Self::Furnace,
    // rust: Self::BlastFurnace,
    // rust: Self::Smoker,
    // rust: ];
pub fn index(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self as usize
}
    /// `RecipeBookSettings` keys in the player's `recipeBook` compound.
pub fn keys(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Crafting => ("isGuiOpen", "isFilteringCraftable"),
    // rust: Self::Furnace => ("isFurnaceGuiOpen", "isFurnaceFilteringCraftable"),
    // rust: Self::BlastFurnace => (
    // rust: "isBlastingFurnaceGuiOpen",
    // rust: "isBlastingFurnaceFilteringCraftable",
    // rust: ),
    // rust: Self::Smoker => ("isSmokerGuiOpen", "isSmokerFilteringCraftable"),
}
}
    /// The tab buttons of the book's screen, search first.
pub fn tabs(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
//         use Category::*;
    // rust: let categories: &[Category] = match self {
    // rust: Self::Crafting => &[
    // rust: CraftingEquipment,
    // rust: CraftingBuilding,
    // rust: CraftingMisc,
    // rust: CraftingRedstone,
    // rust: ],
    // rust: Self::Furnace => &[FurnaceFood, FurnaceBlocks, FurnaceMisc],
    // rust: Self::BlastFurnace => &[BlastBlocks, BlastMisc],
    // rust: Self::Smoker => &[SmokerFood],
}
    // rust: std::iter::once(Tab::Search)
    // rust: .chain(categories.iter().map(|c| Tab::Category(*c)))
    // rust: .collect()
}
    /// The categories the search tab lists, in `SearchRecipeBookCategory` order.
pub fn search_categories(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
//         use Category::*;
    // rust: match self {
    // rust: Self::Crafting => &[
    // rust: CraftingEquipment,
    // rust: CraftingBuilding,
    // rust: CraftingMisc,
    // rust: CraftingRedstone,
    // rust: ],
    // rust: Self::Furnace => &[FurnaceFood, FurnaceBlocks, FurnaceMisc],
    // rust: Self::BlastFurnace => &[BlastBlocks, BlastMisc],
    // rust: Self::Smoker => &[SmokerFood],
}
}
}

/// `RecipeBookCategories` of the four menus' recipes.
pub const Category = enum {
    CraftingBuilding,
    CraftingRedstone,
    CraftingEquipment,
    CraftingMisc,
    FurnaceFood,
    FurnaceBlocks,
    FurnaceMisc,
    BlastBlocks,
    BlastMisc,
    SmokerFood,
};
    // rust: impl Category {
    /// The `RecipeBookCategories` registry path.
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::CraftingBuilding => "crafting_building_blocks",
    // rust: Self::CraftingRedstone => "crafting_redstone",
    // rust: Self::CraftingEquipment => "crafting_equipment",
    // rust: Self::CraftingMisc => "crafting_misc",
    // rust: Self::FurnaceFood => "furnace_food",
    // rust: Self::FurnaceBlocks => "furnace_blocks",
    // rust: Self::FurnaceMisc => "furnace_misc",
    // rust: Self::BlastBlocks => "blast_furnace_blocks",
    // rust: Self::BlastMisc => "blast_furnace_misc",
    // rust: Self::SmokerFood => "smoker_food",
}
}
}
/// A tab button: the search tab or one category.
pub const Tab = enum {
    Search,
    Category(Category),
};
    // rust: impl Tab {
    /// The tab's icon items (`TabInfo`).
pub fn icons(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
//         use Category::*;
    // rust: match self {
    // rust: Self::Search => ("minecraft:compass", None),
    // rust: Self::Category(c) => match c {
    // rust: CraftingEquipment => ("minecraft:iron_axe", Some("minecraft:golden_sword")),
    // rust: CraftingBuilding => ("minecraft:bricks", None),
    // rust: CraftingMisc => ("minecraft:lava_bucket", Some("minecraft:apple")),
    // rust: CraftingRedstone => ("minecraft:redstone", None),
    // rust: FurnaceFood | SmokerFood => ("minecraft:porkchop", None),
    // rust: FurnaceBlocks => ("minecraft:stone", None),
    // rust: FurnaceMisc => ("minecraft:lava_bucket", Some("minecraft:emerald")),
    // rust: BlastBlocks => ("minecraft:redstone_ore", None),
    // rust: BlastMisc => ("minecraft:iron_shovel", Some("minecraft:golden_leggings")),
    // rust: },
}
}
}

/// `RecipeDisplay`: how a recipe is laid out.
pub const Display = enum {
    Shaped {,
    width: usize,
    height: usize,
    cells: Vec<Option<Ingredient>>,
    // rust: },
    Shapeless(Vec<Ingredient>),
    /// A smelting-type recipe: its input; the fuel is any fuel.
    Furnace(Ingredient),
};
/// One recipe of the book (`RecipeDisplayEntry`).
pub const Entry = struct {
    /// The recipe id, `minecraft:name`.
    id: []const u8,
    /// `RecipeDisplayId`: the display's index among every recipe's displays
    /// (`Book::set_display_ids`; -1 until then).
    display_id: i32,
    category: Category,
    group: ?[]const u8,
    display: Display,
    result: ItemStack,
    /// Every stack its display can show as the result when that is more than
    /// `result` (a map copy of any map, an arrow of any potion): the search
    /// tree reads them all, the button shows the first.
    variants: std.ArrayList(ItemStack),
    /// Ingredients shown as other stacks than their items (by index in
    /// `requirements`): the potions an imbued arrow's lingering potion is.
    stacks: Vec<(usize,
};
    // rust: impl Entry {
    /// Every stack the result display cycles through.
pub fn results(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.variants.is_empty() {
    // rust: std::slice::from_ref(&self.result)
    // rust: } else {
    // rust: &self.variants
}
}
    /// The ingredients that must be matched to craft it, in order.
pub fn requirements(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match &self.display {
    // rust: Display::Shaped { cells, .. } => cells.iter().flatten().collect(),
    // rust: Display::Shapeless(list) => list.iter().collect(),
    // rust: Display::Furnace(i) => vec![i],
}
}
    /// `CraftingRecipeBookComponent.canDisplay` for a grid.
pub fn fits(self: *Self, grid_width: usize, grid_height: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match &self.display {
    // rust: Display::Shaped { width, height, .. } => grid_width >= *width && grid_height >= *height,
    // rust: Display::Shapeless(list) => grid_width * grid_height >= list.len(),
    // rust: Display::Furnace(_) => true,
}
}
    /// The size the recipe takes in the grid (`PlaceRecipeHelper`).
pub fn size_in(self: *Self, grid_width: usize, grid_height: usize) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match &self.display {
    // rust: Display::Shaped { width, height, .. } => (*width, *height),
    // rust: _ => (grid_width, grid_height),
}
}
    /// The ingredient of each grid cell the recipe fills, with its grid index
    /// (the ghost recipe and the placement use the same layout).
pub fn grid_cells(self: *Self, grid_width: usize, grid_height: usize) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (w, h) = self.size_in(grid_width, grid_height);
        // One entry per recipe cell: the index of its ingredient, if any.
    // rust: let entries: Vec<Option<usize>> = match &self.display {
    // rust: Display::Shaped { cells, .. } => {
    // rust: let mut next = 0;
    // rust: cells
    // rust: .iter()
    // rust: .map(|c| {
    // rust: c.as_ref().map(|_| {
    // rust: next += 1;
    // rust: next - 1
    // rust: })
    // rust: })
    // rust: .collect()
}
    // rust: Display::Shapeless(list) => (0..list.len()).map(Some).collect(),
    // rust: Display::Furnace(_) => vec![Some(0)],
}
    // rust: place_cells(grid_width, grid_height, w, h, &entries)
}
}

/// `PlaceRecipeHelper.placeRecipe`: the grid index each entry goes to; a
/// recipe smaller than half the grid is centred.
    // rust: pub fn place_cells<T: Clone>(
    // rust: grid_width: usize,
    // rust: grid_height: usize,
    // rust: recipe_width: usize,
    // rust: recipe_height: usize,
    // rust: entries: &[T],
    // rust: ) -> Vec<(T, usize)> {
    // rust: let mut out = Vec::new();
    // rust: let mut iter = entries.iter().peekable();
    // rust: let mut index = 0usize;
    // rust: let mut y = 0;
    // rust: while y < grid_height {
    // rust: let center_rows = (recipe_height as f32) < grid_height as f32 / 2.0;
    // rust: let start_row = (grid_height as f32 / 2.0 - recipe_height as f32 / 2.0).floor() as usize;
    // rust: if center_rows && start_row > y {
    // rust: index += grid_width;
    // rust: y += 1;
}
    // rust: for x in 0..grid_width {
    // rust: if iter.peek().is_none() {
    // rust: return out;
}
    // rust: let center_cols = (recipe_width as f32) < grid_width as f32 / 2.0;
    // rust: let start_col = (grid_width as f32 / 2.0 - recipe_width as f32 / 2.0).floor() as usize;
    // rust: let mut total = recipe_width;
    // rust: let mut add = x < recipe_width;
    // rust: if center_cols {
    // rust: total = start_col + recipe_width;
    // rust: add = start_col <= x && x < start_col + recipe_width;
}
    // rust: if add {
    // rust: if let Some(item) = iter.next() {
    // rust: out.push((item.clone(), index));
}
    // rust: } else if total == x {
    // rust: index += grid_width - x;
    // rust: break;
}
    // rust: index += 1;
}
    // rust: y += 1;
}
    // rust: out
}

/// A group of recipes shown as one button (`RecipeCollection`).
pub const Collection = struct {
    /// Indices into `Book::entries`.
    entries: std.ArrayList(usize),
};

/// Every recipe the menus' books can show.
pub const Book = struct {
    entries: std.ArrayList(Entry),
    /// `Recipe.placementInfo` by recipe id: what the book's craftable test
    /// and the server's placement look for.
    placements: HashMap<[]const u8,
    /// Item id -> registry position, to order ingredient choices.
    order: HashMap<[]const u8,
};
    // rust: pub(crate) fn crafting_category(name: &str) -> Category {
    // rust: match name {
    // rust: "building" => Category::CraftingBuilding,
    // rust: "redstone" => Category::CraftingRedstone,
    // rust: "equipment" => Category::CraftingEquipment,
    // rust: _ => Category::CraftingMisc,
}
}
    // rust: impl Book {
pub fn build(recipes: *Recipes, items: *Items) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut entries = Vec::new();
    // rust: let group = |s: &str| (!s.is_empty()).then(|| s.to_owned());
    // rust: for (name, recipe) in &recipes.crafting {
    // rust: let (category, grp) = recipes.meta.get(name).cloned().unwrap_or_default();
    // rust: let (display, result) = match recipe {
    // rust: Recipe::Shaped {
    // rust: width,
    // rust: height,
    // rust: cells,
    // rust: result,
    // rust: } => (
    // rust: Display::Shaped {
    // rust: width: *width,
    // rust: height: *height,
    // rust: cells: cells.clone(),
    // rust: },
    // rust: result,
    // rust: ),
    // rust: Recipe::Shapeless {
    // rust: ingredients,
    // rust: result,
    // rust: } => (Display::Shapeless(ingredients.clone()), result),
                // Custom recipes are never learnable; the others show one
                // display per material count (TransmuteRecipe.display).
    // rust: Recipe::Special(special) => {
    // rust: for shown in special.book_displays() {
    // rust: entries.push(Entry {
    // rust: id: crate::crafting::recipe_id(name),
    // rust: display_id: -1,
    // rust: category: crafting_category(&category),
    // rust: group: group(&grp),
    // rust: display: shown.display,
    // rust: result: shown.result,
    // rust: variants: shown.variants,
    // rust: stacks: shown.stacks,
    // rust: });
}
    // rust: continue;
}
}
    // rust: entries.push(Entry {
    // rust: id: crate::crafting::recipe_id(name),
    // rust: display_id: -1,
    // rust: category: crafting_category(&category),
    // rust: group: group(&grp),
    // rust: display,
    // rust: result: result.create(),
    // rust: variants: Vec::new(),
    // rust: stacks: Vec::new(),
    // rust: });
}
    // rust: for c in &recipes.cooking {
    // rust: let category = match (c.kind.as_str(), c.category.as_str()) {
    // rust: ("minecraft:smelting", "food") => Category::FurnaceFood,
    // rust: ("minecraft:smelting", "blocks") => Category::FurnaceBlocks,
    // rust: ("minecraft:smelting", _) => Category::FurnaceMisc,
    // rust: ("minecraft:blasting", "blocks") => Category::BlastBlocks,
    // rust: ("minecraft:blasting", _) => Category::BlastMisc,
    // rust: ("minecraft:smoking", _) => Category::SmokerFood,
    // rust: _ => continue,
}
    // rust: entries.push(Entry {
    // rust: id: crate::crafting::recipe_id(&c.id),
    // rust: display_id: -1,
    // rust: category,
    // rust: group: group(&c.group),
    // rust: display: Display::Furnace(c.ingredient.clone()),
    // rust: result: c.result.clone(),
    // rust: variants: Vec::new(),
    // rust: stacks: Vec::new(),
    // rust: });
}
    // rust: let order = items
    // rust: .order
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, id)| (id.to_string(), i))
    // rust: .collect();
    // rust: let placements = entries
    // rust: .iter()
    // rust: .filter_map(|e| Some((e.id.clone(), recipes.placement(&e.id)?)))
    // rust: .collect();
    // rust: Self {
    // rust: entries,
    // rust: placements,
    // rust: order,
}
}
    /// `RecipeDisplayEntry.canCraft`: the recipe's placement ingredients
    /// (`craftingRequirements`) can all be found in `stock`.
pub fn can_craft(self: *Self, entry: *Entry, stock: *crate::menu::place::Stacked) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.placements
    // rust: .get(&entry.id)
    // rust: .is_some_and(|p| stock.can_craft(&p.ingredients.iter().collect::<Vec<_>>()))
}
    /// Numbers the entries as `RecipeManager.unpackRecipeInfo` numbers the
    /// displays: every recipe in id order, each with its displays.
pub fn set_display_ids(self: *Self, index: *RecipeIndex) void {
}
    // rust: let mut previous: Option<(String, i32)> = None;
    // rust: for e in &mut self.entries {
    // rust: let next = match &previous {
    // rust: Some((id, last)) if *id == e.id => last + 1,
    // rust: _ => index.first_display(&e.id).unwrap_or(-1),
}
    // rust: e.display_id = next;
    // rust: previous = Some((e.id.clone(), next));
}
}
    /// The entry of a display id.
pub fn entry_of_display(self: *Self, display: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.entries.iter().position(|e| e.display_id == display)
}
pub fn entry(self: *Self, id: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.entries.iter().find(|e| e.id == id)
}
    /// `ingredient`'s items as its display resolves them (the cycling order
    /// of ghost slots and the overlay).
pub fn items_of(self: *Self, ingredient: *Ingredient) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ingredient.order.clone()
}
    /// `RecipeBookComponent.fillGhostRecipe` of a book type: the result and the
    /// ingredients faded into the menu's slots, in the order the component
    /// sets them. `grid` is the side of the crafting grid, `fuel_empty`
    /// whether the furnace's fuel slot is empty.
    // rust: pub fn ghost(
    // rust: &self,
    // rust: entry: &Entry,
    // rust: book_type: BookType,
    // rust: grid: usize,
    // rust: fuel_empty: bool,
    // rust: items: &crate::items::Items,
    // rust: ) -> Vec<GhostSlot> {
    // rust: let stacks = |ingredient: &Ingredient| -> Vec<ItemStack> {
    // rust: self.items_of(ingredient)
    // rust: .iter()
    // rust: .map(|i| ItemStack::new(i, 1))
    // rust: .collect()
}
    // rust: let mut out = Vec::new();
    // rust: match book_type {
    // rust: BookType::Crafting => {
    // rust: out.push(GhostSlot {
    // rust: target: GhostTarget::Result,
    // rust: items: entry.results().to_vec(),
    // rust: });
    // rust: let requirements = entry.requirements();
    // rust: for (ingredient, index) in entry.grid_cells(grid, grid) {
    // rust: let Some(i) = ingredient else { continue };
    // rust: let list = match entry.stacks.iter().find(|s| s.0 == i) {
    // rust: Some(shown) => shown.1.clone(),
    // rust: None => stacks(requirements[i]),
}
    // rust: if !list.is_empty() {
    // rust: out.push(GhostSlot {
    // rust: target: GhostTarget::Grid(index),
    // rust: items: list,
    // rust: });
}
}
}
    // rust: _ => {
    // rust: out.push(GhostSlot {
    // rust: target: GhostTarget::Result,
    // rust: items: entry.results().to_vec(),
    // rust: });
    // rust: if let Display::Furnace(ingredient) = &entry.display {
    // rust: out.push(GhostSlot {
    // rust: target: GhostTarget::Input,
    // rust: items: stacks(ingredient),
    // rust: });
    // rust: if fuel_empty {
                        // `SlotDisplay.AnyFuel`: every item with a cooking fuel
                        // component, the registry's component lookup listing the
                        // items of one component value together, the values in
                        // the order of their first item.
    // rust: let mut groups: Vec<(String, Vec<ItemStack>)> = Vec::new();
    // rust: for item in &items.registry_order {
    // rust: let Some(fuel) = items.get(item).and_then(|i| i.fuel.as_ref()) else {
    // rust: continue;
}
    // rust: let key = format!("{fuel:?}");
    // rust: match groups.iter_mut().find(|g| g.0 == key) {
    // rust: Some(group) => group.1.push(ItemStack::new(item, 1)),
    // rust: None => groups.push((key, vec![ItemStack::new(item, 1)])),
}
}
    // rust: let fuels = groups.into_iter().flat_map(|g| g.1).collect();
    // rust: out.push(GhostSlot {
    // rust: target: GhostTarget::Fuel,
    // rust: items: fuels,
    // rust: });
}
}
}
}
        // `GhostSlots.setSlot` keeps only slots with something to show.
    // rust: out.retain(|g| !g.items.is_empty());
    // rust: out
}
    /// The recipe-book search tree (`SessionSearchTrees.updateRecipes`, a
    /// `FullTextSearchTree`): without a colon the text must occur in a
    /// tooltip line of a result item of the collection; `namespace:path`
    /// needs the namespace in a result id and the path in an id or a line.
    // rust: pub fn collection_matches(
    // rust: &self,
    // rust: entries: &[usize],
    // rust: query: &str,
    // rust: tooltip: &dyn Fn(&ItemStack) -> Vec<String>,
    // rust: ) -> bool {
    // rust: let query = query.to_lowercase();
    // rust: let results: Vec<&ItemStack> = entries
    // rust: .iter()
    // rust: .flat_map(|&i| self.entries[i].results())
    // rust: .collect();
    // rust: let in_lines = |text: &str| {
    // rust: results
    // rust: .iter()
    // rust: .any(|r| tooltip(r).iter().any(|l| l.to_lowercase().contains(text)))
}
    // rust: let Some((namespace, path)) = query.split_once(':') else {
    // rust: return in_lines(&query);
}
    // rust: let (namespace, path) = (namespace.trim(), path.trim());
    // rust: let id = |r: &&ItemStack| {
    // rust: let (ns, p) = r.item.split_once(':').unwrap_or(("minecraft", &r.item));
    // rust: (ns.to_lowercase(), p.to_lowercase())
}
    // rust: results.iter().any(|r| id(r).0.contains(namespace))
    // rust: && (results.iter().any(|r| id(r).1.contains(path)) || in_lines(path))
}
}

/// Where a ghost recipe's stacks are drawn.
pub const GhostTarget = enum {
    Result,
    /// A crafting grid slot, row by row.
    Grid(usize),
    /// A furnace's input and fuel slots.
    Input,
    Fuel,
};
/// One slot of a ghost recipe and the stacks it cycles through.
pub const GhostSlot = struct {
    target: GhostTarget,
    items: std.ArrayList(ItemStack),
};

/// A `RecipeDisplayId` as a `HashMap` key: a record of one int hashes as it.
pub const DisplayKey = struct {};
    // rust: impl horizon_world::java_hash_map::JavaKey for DisplayKey {
pub fn java_hash(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0
}
pub fn tie_break(self: *Self, other: *Self) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.0 < other.0 {
    // rust: std::cmp::Ordering::Less
    // rust: } else {
    // rust: std::cmp::Ordering::Greater
}
}
}

/// `ClientRecipeBook`: the displays the client was sent, in a `HashMap` whose
/// iteration order (the display ids' buckets, then arrival order) decides the
/// order of the book's buttons.
pub const ClientBook = struct {
    known: horizon_world::java_hash_map::JavaHashMap<DisplayKey,
    highlight: std::collections::std.AutoHashMap(i32, void),
};
    // rust: impl ClientBook {
pub fn add(self: *Self, display: i32) void {
}
    // rust: self.known.put(DisplayKey(display), ());
}
pub fn remove(self: *Self, display: i32) void {
}
    // rust: self.known.remove(&DisplayKey(display));
    // rust: self.highlight.remove(&display);
}
    /// `clear` (a replacing `ClientboundRecipeBookAddPacket`): the table keeps its size.
pub fn clear(self: *Self) void {
}
    // rust: self.known.clear();
    // rust: self.highlight.clear();
}
    /// The known display ids in iteration order.
pub fn displays(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.known.entries().map(|(k, _)| k.0).collect()
}
    /// `rebuildCollections` then `getCollection(tab)`: per category, a
    /// collection per entry without a group or per group, in the order the
    /// known displays iterate; the search tab lists its categories in turn.
pub fn collections(self: *Self, book: *Book, book_type: BookType, tab: Tab) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let by_display: HashMap<i32, usize> = book
    // rust: .entries
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, e)| (e.display_id, i))
    // rust: .collect();
    // rust: let mut by_category: HashMap<Category, Vec<Collection>> = HashMap::new();
    // rust: let mut groups: HashMap<(Category, String), (Category, usize)> = HashMap::new();
    // rust: for display in self.displays() {
    // rust: let Some(&i) = by_display.get(&display) else {
    // rust: continue;
}
    // rust: let e = &book.entries[i];
    // rust: let list = by_category.entry(e.category).or_default();
    // rust: match &e.group {
    // rust: None => list.push(Collection { entries: vec![i] }),
    // rust: Some(g) => match groups.get(&(e.category, g.clone())) {
    // rust: Some(&(_, at)) => list[at].entries.push(i),
    // rust: None => {
    // rust: groups.insert((e.category, g.clone()), (e.category, list.len()));
    // rust: list.push(Collection { entries: vec![i] });
}
    // rust: },
}
}
    // rust: let categories: Vec<Category> = match tab {
    // rust: Tab::Search => book_type.search_categories().to_vec(),
    // rust: Tab::Category(c) => vec![c],
}
    // rust: categories
    // rust: .into_iter()
    // rust: .flat_map(|c| by_category.remove(&c).unwrap_or_default())
    // rust: .collect()
}
}

/// What the server knows of each recipe of the datapack: whether it is
/// special (`Recipe.isSpecial`: never learnable) and how many recipe book
/// displays it has (`RecipeManager.listDisplaysForRecipe`).
pub const RecipeIndex = struct {
    recipes: std::collections::BTreeMap<[]const u8,
};
pub const Known = struct {
    special: bool,
    displays: usize,
    first_display: i32,
    /// `RecipeDisplay.craftingStation`: the workstation item of its displays.
    station: *'static str,
    /// `Recipe.showNotification`: unlocking it shows the `RecipeToast`.
    notify: bool,
    /// `result.id`, for the recipes the book doesn't list.
    result: ?[]const u8,
};
/// `RecipeDisplay.craftingStation` of a recipe type.
    // rust: pub(crate) fn crafting_station(kind: &str) -> &'static str {
    // rust: match kind {
    // rust: "minecraft:smelting" => "minecraft:furnace",
    // rust: "minecraft:blasting" => "minecraft:blast_furnace",
    // rust: "minecraft:smoking" => "minecraft:smoker",
    // rust: "minecraft:campfire_cooking" => "minecraft:campfire",
    // rust: "minecraft:stonecutting" => "minecraft:stonecutter",
    // rust: "minecraft:brewing" => "minecraft:brewing_stand",
    // rust: "minecraft:smithing_transform" | "minecraft:smithing_trim" => "minecraft:smithing_table",
    // rust: _ => "minecraft:crafting_table",
}
}
    // rust: impl RecipeIndex {
    /// Reads `data/minecraft/recipe/*.json` under `root`, with the world's
    /// packs' recipe files over it (`overlay`).
pub fn load(root: *std::path::Path, overlay: *PackOverlay) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut recipes = std::collections::BTreeMap::new();
    // rust: let mut insert = |id: String, v: &serde_json::Value| {
    // rust: let kind = v["type"].as_str().unwrap_or_default();
    // rust: let special = kind.starts_with("minecraft:crafting_special_")
    // rust: || kind == "minecraft:crafting_decorated_pot"
                // A brewing recipe has no recipe book display of its own
                // (`BrewingRecipe`), so it never takes display numbers.
    // rust: || kind == "minecraft:brewing";
    // rust: let displays = if special {
    // rust: 0
    // rust: } else if kind == "minecraft:crafting_transmute" {
                // TransmuteRecipe.display: one per material count.
    // rust: match &v["material_count"] {
    // rust: serde_json::Value::Object(o) => {
    // rust: let min = o.get("min").and_then(|m| m.as_u64()).unwrap_or(1);
    // rust: let max = o.get("max").and_then(|m| m.as_u64()).unwrap_or(8);
    // rust: (max.saturating_sub(min) + 1) as usize
}
    // rust: _ => 1,
}
    // rust: } else {
    // rust: 1
}
    // rust: recipes.insert(
    // rust: id,
    // rust: Known {
    // rust: special,
    // rust: displays,
    // rust: first_display: 0,
    // rust: station: crafting_station(kind),
    // rust: notify: v["show_notification"].as_bool().unwrap_or(true),
    // rust: result: horizon_world::loot::recipe_result_id(&v["result"]).map(str::to_owned),
    // rust: },
    // rust: );
}
    // rust: let dir = root.join("data/minecraft/recipe");
        // NeoForge's load conditions: the book lists only what loaded; a
        // recipe gated on an absent mod isn't in the manager either.
    // rust: let mods: Vec<String> = {
    // rust: let mut mods = horizon_items::content_namespaces::mod_ids(root);
    // rust: if !mods.iter().any(|m| m == "minecraft") {
    // rust: mods.push("minecraft".to_owned());
}
    // rust: mods
}
    // rust: let conditions_hold = |v: &serde_json::Value| {
    // rust: horizon_world::conditions::conditions_hold(v, &|id: &str| mods.iter().any(|m| m == id))
}
        // The whole folder, `brewing/` under it too, in id order
        // (`SimpleJsonResourceReloadListener` walks it recursively): a
        // subfolder's recipe keeps it in its id, `minecraft:brewing/<name>`.
        // The packs' files replace first and the gate answers the merged
        // file, as the crafting loader's does: a false-conditioned pack
        // file leaves the lower one gone too.
    // rust: let folder = crate::json_folder::read(&dir).ok();
    // rust: let mut sources: Vec<(String, serde_json::Value)> = folder
    // rust: .iter()
    // rust: .flat_map(|folder| &folder.files)
    // rust: .filter_map(|file| {
    // rust: let v = serde_json::from_slice::<serde_json::Value>(file.bytes().ok()?).ok()?;
    // rust: Some((format!("minecraft:{}", file.name), v))
    // rust: })
    // rust: .collect();
    // rust: for (id, files) in overlay.kind("recipe") {
    // rust: match serde_json::from_slice::<serde_json::Value>(PackOverlay::top(files)) {
    // rust: Ok(v) => match sources.iter_mut().find(|(n, _)| n == id) {
    // rust: Some(slot) => slot.1 = v,
    // rust: None => sources.push((id.to_owned(), v)),
    // rust: },
    // rust: Err(e) => log::warn!("Horizon: pack recipe {id} not shown in the book: {e}"),
}
}
    // rust: let filters = horizon_items::recipe_filters::RecipeFilters::load(root, overlay);
    // rust: for (id, mut v) in sources {
    // rust: if conditions_hold(&v) && filters.apply(&id, &mut v) {
    // rust: insert(id, &v);
}
}
        // RecipeManager.unpackRecipeInfo numbers the displays in registration
        // order (path, then namespace), not in the order of the ids' text.
    // rust: let mut order: Vec<_> = recipes
    // rust: .iter_mut()
    // rust: .map(|(id, r)| (crate::crafting::registration_key(id), r))
    // rust: .collect();
    // rust: order.sort_unstable_by(|a, b| a.0.cmp(&b.0));
    // rust: let mut next = 0;
    // rust: for (_, r) in order {
    // rust: r.first_display = next;
    // rust: next += r.displays as i32;
}
    // rust: Self { recipes }
}
pub fn contains(self: *Self, id: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.recipes.contains_key(id)
}
pub fn special(self: *Self, id: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.recipes.get(id).is_some_and(|r| r.special)
}
pub fn displays(self: *Self, id: []const u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.recipes.get(id).map_or(0, |r| r.displays)
}
    /// The crafting station shown on its displays' toast, when unlocking it
    /// shows one (`Recipe.showNotification`).
pub fn toast_station(self: *Self, id: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.recipes.get(id).filter(|r| r.notify).map(|r| r.station)
}
    /// The result item id its file names (none for trims).
pub fn result(self: *Self, id: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.recipes.get(id).and_then(|r| r.result.as_deref())
}
    /// Every recipe id, in id order.
pub fn ids(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.recipes.keys()
}
    /// The display ids of a recipe (none for a special one).
pub fn display_ids(self: *Self, id: []const u8) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.recipes.get(id).map_or(0..0, |r| {
    // rust: r.first_display..r.first_display + r.displays as i32
    // rust: })
}
    /// The recipe a display id belongs to (`RecipeManager.getRecipeFromDisplay`).
pub fn recipe_of_display(self: *Self, display: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.recipes
    // rust: .iter()
    // rust: .find(|(_, r)| {
    // rust: (r.first_display..r.first_display + r.displays as i32).contains(&display)
    // rust: })
    // rust: .map(|(id, _)| id.as_str())
}
pub fn first_display(self: *Self, id: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.recipes
    // rust: .get(id)
    // rust: .filter(|r| r.displays > 0)
    // rust: .map(|r| r.first_display)
}
}

/// The recipe ids a knowledge book names: its `minecraft:recipes` component
/// (`Recipe.KEY_CODEC.listOf()`, the namespace defaulting to minecraft).
pub fn knowledge_recipes(stack: *ItemStack) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(Tag::List(ids)) = stack.data().and_then(|d| d.other("minecraft:recipes")) else {
    // rust: return Vec::new();
}
    // rust: ids.iter()
    // rust: .filter_map(|t| match t {
    // rust: Tag::String(id) => Some(id.to_string_lossy()),
    // rust: _ => None,
    // rust: })
    // rust: .map(|id| {
    // rust: if id.contains(':') {
    // rust: id
    // rust: } else {
    // rust: format!("minecraft:{id}")
}
    // rust: })
    // rust: .collect()
}

/// `ServerRecipeBook`: the player's `recipeBook` compound, the known recipes
/// and the ones still to highlight (`toBeDisplayed`) with the open and
/// filter settings of each `RecipeBookType`.
pub const Settings = struct {
    /// `isGuiOpen`-style flags per `BookType`.
    open: [bool,
    filtering: [bool,
    /// Known recipe ids (`recipes`).
    recipes: BTreeSet<[]const u8>,
    /// Recipes not yet shown in the book (`toBeDisplayed`): they animate once.
    to_be_displayed: BTreeSet<[]const u8>,
};
    // rust: impl Settings {
    /// `ServerRecipeBook.addRecipes`: the displays added (the count
    /// `/recipe give` reports) and the recipes now known, in order.
pub fn add_recipes(self: *Self, index: *RecipeIndex, ids: *[[]const u8]) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut displays = 0;
    // rust: let mut added = Vec::new();
    // rust: for id in ids {
            // The whole id: the crafting copy names a `minecraft:` recipe
            // bare, and every reader of the book (the network copy, the
            // advancements' JSON, the saved file) knows it qualified.
    // rust: let id = crate::crafting::qualified(id);
    // rust: if !self.recipes.contains(&id) && !index.special(&id) {
    // rust: self.recipes.insert(id.clone());
    // rust: self.to_be_displayed.insert(id.clone());
    // rust: displays += index.displays(&id);
    // rust: added.push(id);
}
}
    // rust: (displays, added)
}
    /// `KnowledgeBookItem.use` for the stack in the acting hand: `Ok` is its
    /// `InteractionResult.SUCCESS`, with the recipes now known; `Err` is
    /// `FAIL`, with the recipe id vanilla logs (`Invalid recipe: {}`) or
    /// `None` for a book that names none. The book is used up first, as
    /// vanilla consumes it before either check (`ItemStack.consume(1, player)`;
    /// a player with infinite materials keeps it).
    // rust: pub fn use_knowledge_book(
    // rust: &mut self,
    // rust: index: &RecipeIndex,
    // rust: hand: &mut Option<ItemStack>,
    // rust: infinite: bool,
    // rust: ) -> Result<Vec<String>, Option<String>> {
    // rust: let recipes = hand.as_ref().map_or_else(Vec::new, knowledge_recipes);
    // rust: if !infinite && let Some(stack) = hand.as_mut() {
    // rust: stack.count -= 1;
    // rust: if stack.count == 0 {
    // rust: *hand = None;
}
}
    // rust: if recipes.is_empty() {
    // rust: return Err(None);
}
        // `RecipeManager.byKey`: one id this server has no recipe for stops
        // the use, the recipes beside it unlearned.
    // rust: if let Some(i) = recipes.iter().position(|id| !index.contains(id)) {
    // rust: return Err(Some(recipes[i].clone()));
}
    // rust: Ok(self.add_recipes(index, &recipes).1)
}
    /// `ServerRecipeBook.removeRecipes`: the display ids removed, which its
    /// `ClientboundRecipeBookRemovePacket` lists (a transmute recipe has one
    /// per material count).
pub fn remove_recipes(self: *Self, index: *RecipeIndex, ids: *[[]const u8]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut displays = Vec::new();
    // rust: for id in ids {
    // rust: let id = crate::crafting::qualified(id);
    // rust: if self.recipes.remove(&id) {
    // rust: self.to_be_displayed.remove(&id);
    // rust: displays.extend(index.display_ids(&id));
}
}
    // rust: displays
}
    /// `removeHighlight` (`ServerboundRecipeBookSeenRecipePacket`).
pub fn remove_highlight(self: *Self, id: []const u8) void {
}
    // rust: self.to_be_displayed.remove(id);
}
pub fn knows(self: *Self, id: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.recipes.contains(id)
}
    /// The compound as saved, every recipe kept.
pub fn read(tag: ?*Tag) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::read_valid(tag, &|_| true)
}
    /// `ServerRecipeBook.loadUntrusted`: unknown recipes are dropped. Without
    /// both lists the compound does not decode and nothing is read.
pub fn read_valid(tag: ?*Tag, valid: *dyn Fn([]const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut s = Self::default();
    // rust: let Some(tag) = tag else { return s };
    // rust: let ids = |key: &str| match tag.get(key) {
    // rust: Some(Tag::List(list)) => Some(
    // rust: list.iter()
    // rust: .filter_map(|t| match t {
    // rust: Tag::String(id) => Some(id.to_string_lossy()),
    // rust: _ => None,
    // rust: })
    // rust: .map(|id| {
    // rust: if id.contains(':') {
    // rust: id
    // rust: } else {
    // rust: format!("minecraft:{id}")
}
    // rust: })
    // rust: .filter(|id| valid(id))
    // rust: .collect::<BTreeSet<String>>(),
    // rust: ),
    // rust: _ => None,
}
    // rust: let (Some(recipes), Some(to_be_displayed)) = (ids("recipes"), ids("toBeDisplayed")) else {
    // rust: return s;
}
    // rust: let flag = |k: &str| matches!(tag.get(k), Some(Tag::Byte(b)) if *b != 0);
    // rust: for b in BookType::ALL {
    // rust: let (open, filter) = b.keys();
    // rust: s.open[b.index()] = flag(open);
    // rust: s.filtering[b.index()] = flag(filter);
}
    // rust: s.recipes = recipes;
    // rust: s.to_be_displayed = to_be_displayed;
    // rust: s
}
    /// The compound written to the player file (vanilla's lists follow an
    /// identity hash order; these are sorted).
pub fn write(self: *Self) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut entries: Vec<(&str, Tag)> = Vec::new();
    // rust: for b in BookType::ALL {
    // rust: let (open, filter) = b.keys();
            // The codec omits settings at their default (false).
    // rust: if self.open[b.index()] {
    // rust: entries.push((open, Tag::Byte(1)));
}
    // rust: if self.filtering[b.index()] {
    // rust: entries.push((filter, Tag::Byte(1)));
}
}
    // rust: let list = |ids: &BTreeSet<String>| {
    // rust: Tag::List(ids.iter().map(|i| Tag::String(i.as_str().into())).collect())
}
    // rust: entries.push(("recipes", list(&self.recipes)));
    // rust: entries.push(("toBeDisplayed", list(&self.to_be_displayed)));
    // rust: Tag::compound(entries)
}
}

    // rust: mod tests {
    /// A book saved before #7186's fix holds bare names: reading fills the
    /// namespace in, so those recipes show in the book too.
pub fn a_book_saved_with_bare_names_reads_qualified() void {
}
//         use horizon_world::nbt::{Compound, Tag};
    // rust: let list = || Tag::List(vec![Tag::String("folder_recipe".into())]);
    // rust: let mut compound = Compound::new();
    // rust: compound.insert("recipes".into(), list());
    // rust: compound.insert("toBeDisplayed".into(), list());
    // rust: let tag = Tag::Compound(compound);
    // rust: let read = Settings::read_valid(Some(&tag), &|_| true);
    // rust: assert_eq!(
    // rust: read.recipes,
    // rust: ["minecraft:folder_recipe".to_owned()].into_iter().collect()
    // rust: );
    // rust: assert!(read.to_be_displayed.contains("minecraft:folder_recipe"));
}

//     use super::*;

pub fn mod_category_mapping_validates_ids_icons_and_conflicts() void {
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-book-categories-{}", std::process::id()));
    // rust: std::fs::create_dir_all(&root).unwrap();
    // rust: std::fs::write(
    // rust: root.join("items.json"),
    // rust: r#"{"minecraft:stone":{},"mymod:crusher":{},"minecraft:air":{}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let items = Items::catalog(&root, &PackOverlay::NONE).unwrap();
    // rust: let recipes = Recipes::from_sources(
    // rust: &root,
    // rust: &items,
    // rust: &PackOverlay::NONE,
    // rust: vec![
    // rust: (
    // rust: "mymod:crush".into(),
    // rust: serde_json::json!({"type":"mymod:crusher"}),
    // rust: ),
    // rust: (
    // rust: "mymod:mix".into(),
    // rust: serde_json::json!({"type":"mymod:mixer"}),
    // rust: ),
    // rust: ],
    // rust: )
    // rust: .unwrap();
    // rust: let declare = |id: &str, recipe_type: &str, icon: &str| RecipeBookCategory {
    // rust: id: id.into(),
    // rust: recipe_type: recipe_type.into(),
    // rust: icon: icon.into(),
}
    // rust: let crusher = declare("mymod:crushing", "mymod:crusher", "mymod:crusher");
    // rust: let mixer = declare("mymod:mixing", "mymod:mixer", "minecraft:stone");
    // rust: let mapped = mod_categories(
    // rust: vec![
    // rust: declare("mymod:crushing", "mymod:crusher", ""),
    // rust: crusher.clone(),
    // rust: declare("mymod:duplicate", "mymod:crusher", "minecraft:stone"),
    // rust: declare("mymod:crushing", "mymod:mixer", "minecraft:stone"),
    // rust: mixer.clone(),
    // rust: ],
    // rust: &recipes,
    // rust: &items,
    // rust: );
    // rust: assert_eq!(mapped.len(), 2);
    // rust: assert_eq!(mapped.get("mymod:crusher"), Some(&crusher));
    // rust: assert_eq!(mapped.get("mymod:mixer"), Some(&mixer));
    // rust: assert!(!mapped.contains_key("minecraft:crafting"));
    // rust: for invalid in [
    // rust: declare(
    // rust: "minecraft:crafting_misc",
    // rust: "mymod:crusher",
    // rust: "minecraft:stone",
    // rust: ),
    // rust: declare("bare", "mymod:crusher", "minecraft:stone"),
    // rust: declare("mymod:", "mymod:crusher", "minecraft:stone"),
    // rust: declare(":category", "mymod:crusher", "minecraft:stone"),
    // rust: declare("mymod:Bad", "mymod:crusher", "minecraft:stone"),
    // rust: declare("mymod:bad:id", "mymod:crusher", "minecraft:stone"),
    // rust: declare("mymod:crushing", "mymod:absent", "minecraft:stone"),
    // rust: declare("mymod:crushing", "minecraft:smelting", "minecraft:stone"),
    // rust: declare("mymod:crushing", "mymod:crusher", ""),
    // rust: declare("mymod:crushing", "mymod:crusher", "minecraft:absent"),
    // rust: declare("mymod:crushing", "mymod:crusher", "minecraft:air"),
    // rust: ] {
    // rust: assert!(
    // rust: mod_categories(vec![invalid.clone()], &recipes, &items).is_empty(),
    // rust: "{invalid:?}"
    // rust: );
}
    // rust: assert!(mod_categories(Vec::new(), &recipes, &items).is_empty());
    // rust: let vanilla = Recipes::from_sources(&root, &items, &PackOverlay::NONE, Vec::new()).unwrap();
    // rust: assert!(mod_categories(vec![crusher], &vanilla, &items).is_empty());
    // rust: std::fs::remove_dir_all(root).unwrap();
}

pub fn ing(items: *[[]const u8]) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ingredient::of(items.iter().map(|s| (*s).to_owned()).collect())
}
pub fn the_index_knows_each_recipes_toast_station_and_result() void {
}
    // rust: let root = std::env::temp_dir().join(format!("horizon-toast-index-{}", std::process::id()));
    // rust: let dir = root.join("data/minecraft/recipe");
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: for (name, json) in [
    // rust: (
    // rust: "stick",
    // rust: r#"{"type":"minecraft:crafting_shaped","result":{"id":"minecraft:stick"}}"#,
    // rust: ),
    // rust: (
    // rust: "crafting_table",
    // rust: r#"{"type":"minecraft:crafting_shaped","show_notification":false,"result":{"id":"minecraft:crafting_table"}}"#,
    // rust: ),
    // rust: (
    // rust: "cooked_beef_from_campfire_cooking",
    // rust: r#"{"type":"minecraft:campfire_cooking","result":{"id":"minecraft:cooked_beef"}}"#,
    // rust: ),
    // rust: (
    // rust: "stone_slab_from_stonecutting",
    // rust: r#"{"type":"minecraft:stonecutting","result":{"id":"minecraft:stone_slab"}}"#,
    // rust: ),
    // rust: (
    // rust: "coast_trim",
    // rust: r#"{"type":"minecraft:smithing_trim","pattern":"minecraft:coast"}"#,
    // rust: ),
    // rust: ] {
    // rust: std::fs::write(dir.join(format!("{name}.json")), json).unwrap();
}
    // rust: let index = RecipeIndex::load(&root, &PackOverlay::NONE);
    // rust: std::fs::remove_dir_all(&root).unwrap();
    // rust: let toast = |id: &str| (index.toast_station(id), index.result(id));
    // rust: assert_eq!(
    // rust: toast("minecraft:stick"),
    // rust: (Some("minecraft:crafting_table"), Some("minecraft:stick"))
    // rust: );
        // show_notification: false unlocks silently.
    // rust: assert_eq!(toast("minecraft:crafting_table").0, None);
    // rust: assert_eq!(
    // rust: toast("minecraft:cooked_beef_from_campfire_cooking"),
    // rust: (Some("minecraft:campfire"), Some("minecraft:cooked_beef"))
    // rust: );
    // rust: assert_eq!(
    // rust: toast("minecraft:stone_slab_from_stonecutting").0,
    // rust: Some("minecraft:stonecutter")
    // rust: );
    // rust: assert_eq!(
    // rust: toast("minecraft:coast_trim"),
    // rust: (Some("minecraft:smithing_table"), None)
    // rust: );
}
pub fn small_recipes_are_centred_in_the_grid() void {
}
        // One ingredient in a 3x3 grid goes to the middle cell.
    // rust: assert_eq!(place_cells(3, 3, 1, 1, &['a']), vec![('a', 4)]);
        // A 2x2 recipe fills the top-left corner.
    // rust: let cells: Vec<usize> = place_cells(3, 3, 2, 2, &['a', 'b', 'c', 'd'])
    // rust: .into_iter()
    // rust: .map(|(_, i)| i)
    // rust: .collect();
    // rust: assert_eq!(cells, vec![0, 1, 3, 4]);
        // A one-row recipe sits on the middle row.
    // rust: let row: Vec<usize> = place_cells(3, 3, 3, 1, &['a', 'b', 'c'])
    // rust: .into_iter()
    // rust: .map(|(_, i)| i)
    // rust: .collect();
    // rust: assert_eq!(row, vec![3, 4, 5]);
        // The 2x2 grid is never centred.
    // rust: let small: Vec<usize> = place_cells(2, 2, 1, 1, &['a'])
    // rust: .into_iter()
    // rust: .map(|(_, i)| i)
    // rust: .collect();
    // rust: assert_eq!(small, vec![0]);
}
pub fn collections_group_recipes_of_a_category() void {
}
    // rust: let entry = |id: &str, display_id, group: Option<&str>, category| Entry {
    // rust: id: id.into(),
    // rust: display_id,
    // rust: category,
    // rust: group: group.map(str::to_owned),
    // rust: display: Display::Shapeless(vec![ing(&["minecraft:stick"])]),
    // rust: result: ItemStack::new("minecraft:stick", 1),
    // rust: variants: Vec::new(),
    // rust: stacks: Vec::new(),
}
    // rust: let book = Book {
    // rust: entries: vec![
    // rust: entry("minecraft:a", 0, Some("planks"), Category::CraftingBuilding),
    // rust: entry("minecraft:b", 1, Some("planks"), Category::CraftingBuilding),
    // rust: entry("minecraft:c", 2, None, Category::CraftingBuilding),
    // rust: entry("minecraft:d", 3, Some("planks"), Category::CraftingMisc),
    // rust: ],
    // rust: placements: HashMap::new(),
    // rust: order: HashMap::new(),
}
    // rust: let mut client = ClientBook::default();
    // rust: for d in 0..4 {
    // rust: client.add(d);
}
    // rust: let tab = Tab::Category(Category::CraftingBuilding);
    // rust: let c = client.collections(&book, BookType::Crafting, tab);
    // rust: assert_eq!(c.len(), 2);
    // rust: assert_eq!(c[0].entries, vec![0, 1]);
        // The search tab lists every category; the same group in another category is separate.
    // rust: let all = client.collections(&book, BookType::Crafting, Tab::Search);
    // rust: assert_eq!(all.len(), 3);
        // Displays the client was not sent are not listed.
    // rust: client.clear();
    // rust: client.add(2);
    // rust: assert_eq!(client.collections(&book, BookType::Crafting, tab).len(), 1);
}
pub fn display_ids_collide_in_a_small_table() void {
}
        // A 16-bucket table: 17 and 1 share a bucket and keep arrival order.
    // rust: let mut client = ClientBook::default();
    // rust: for d in [17, 3, 1] {
    // rust: client.add(d);
}
    // rust: assert_eq!(client.displays(), vec![17, 1, 3]);
}
pub fn search_reads_tooltip_lines_and_ids() void {
}
    // rust: let book = Book {
    // rust: entries: vec![Entry {
    // rust: id: "minecraft:stick".into(),
    // rust: display_id: 0,
    // rust: category: Category::CraftingMisc,
    // rust: group: None,
    // rust: display: Display::Shapeless(Vec::new()),
    // rust: result: ItemStack::new("minecraft:stick", 4),
    // rust: variants: Vec::new(),
    // rust: stacks: Vec::new(),
    // rust: }],
    // rust: placements: HashMap::new(),
    // rust: order: HashMap::new(),
}
    // rust: let lines = |s: &ItemStack| vec![format!("Item {}", s.item), "Stick".to_owned()];
    // rust: assert!(book.collection_matches(&[0], "STI", &lines));
        // Plain text searches tooltips only, not the registry path.
    // rust: assert!(!book.collection_matches(&[0], "stick:", &lines));
    // rust: assert!(book.collection_matches(&[0], "minecraft:stic", &lines));
    // rust: assert!(!book.collection_matches(&[0], "other:stick", &lines));
}
pub fn settings_round_trip() void {
}
    // rust: let mut s = Settings::default();
    // rust: s.open[BookType::Furnace.index()] = true;
    // rust: s.filtering[BookType::Crafting.index()] = true;
    // rust: s.recipes = ["minecraft:stick".to_owned()].into();
    // rust: let back = Settings::read(Some(&s.write()));
    // rust: assert_eq!(back.open, s.open);
    // rust: assert_eq!(back.filtering, s.filtering);
    // rust: assert_eq!(back.recipes, s.recipes);
}
pub fn a_knowledge_book_unlocks_its_recipes_and_is_used_up() void {
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-knowledge-book-{}", std::process::id()));
    // rust: let dir = root.join("data/minecraft/recipe");
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: for name in ["stick", "crafting_table", "torch"] {
    // rust: std::fs::write(
    // rust: dir.join(format!("{name}.json")),
    // rust: format!(
    // rust: r#"{{"type":"minecraft:crafting_shaped","result":{{"id":"minecraft:{name}"}}}}"#
    // rust: ),
    // rust: )
    // rust: .unwrap();
}
    // rust: let index = RecipeIndex::load(&root, &PackOverlay::NONE);
    // rust: std::fs::remove_dir_all(&root).unwrap();
    // rust: let book = |recipes: &[&str], count: u32| {
    // rust: let ids = recipes.iter().map(|id| Tag::String((*id).into())).collect();
    // rust: let mut stack = ItemStack::new("minecraft:knowledge_book", count);
    // rust: stack
    // rust: .data_mut()
    // rust: .set_other("minecraft:recipes", Some(Tag::List(ids)));
    // rust: stack
}

        // A player who knows no recipe, with a stack of two books naming two.
    // rust: let mut settings = Settings::default();
    // rust: let mut hand = Some(book(&["minecraft:stick", "minecraft:crafting_table"], 2));
    // rust: let unlocked = settings
    // rust: .use_knowledge_book(&index, &mut hand, false)
    // rust: .unwrap();
    // rust: assert_eq!(unlocked, ["minecraft:stick", "minecraft:crafting_table"]);
    // rust: assert!(settings.knows("minecraft:stick"));
    // rust: assert!(settings.knows("minecraft:crafting_table"));
        // One book used up, the second still in the hand.
    // rust: assert_eq!(hand.as_ref().map(|s| s.count), Some(1));

        // A creative player has infinite materials: the book stays, and a
        // recipe already known is still the success `awardRecipes` reports.
    // rust: let mut hand = Some(book(&["minecraft:stick"], 1));
    // rust: assert_eq!(
    // rust: settings.use_knowledge_book(&index, &mut hand, true),
    // rust: Ok(Vec::new())
    // rust: );
    // rust: assert_eq!(hand.as_ref().map(|s| s.count), Some(1));

        // One id this server has no recipe for (vanilla's "Invalid recipe: {}"):
        // the recipe beside it is not learned either, and the book is gone all
        // the same — vanilla consumes it before it looks the ids up.
    // rust: let mut hand = Some(book(&["minecraft:torch", "minecraft:no_such_recipe"], 1));
    // rust: assert_eq!(
    // rust: settings.use_knowledge_book(&index, &mut hand, false),
    // rust: Err(Some("minecraft:no_such_recipe".to_owned()))
    // rust: );
    // rust: assert!(!settings.knows("minecraft:torch"));
    // rust: assert_eq!(hand, None);

        // A book that names no recipe at all (a bare `/give`): nothing to
        // learn, and vanilla fails after using it up like any other.
    // rust: let mut hand = Some(ItemStack::new("minecraft:knowledge_book", 1));
    // rust: assert_eq!(
    // rust: settings.use_knowledge_book(&index, &mut hand, false),
    // rust: Err(None)
    // rust: );
    // rust: assert_eq!(hand, None);
}

    /// `RecipeManager.unpackRecipeInfo` numbers the displays in registration
    /// order: the file's path (with `.json`) first, then its namespace.
pub fn display_ids_follow_registration_order() void {
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-display-order-{}", std::process::id()));
    // rust: let dir = root.join("data/minecraft/recipe");
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: let recipe = r#"{"type":"minecraft:crafting_shapeless","result":{"id":"minecraft:stick"}}"#;
    // rust: for name in ["z_pick", "prefix", "prefix-early"] {
    // rust: std::fs::write(dir.join(format!("{name}.json")), recipe).unwrap();
}
    // rust: let packs = [(
    // rust: "recipe/parity:a_pick".to_owned(),
    // rust: vec![recipe.as_bytes().to_vec()],
    // rust: )];
    // rust: let index = RecipeIndex::load(&root, &PackOverlay { files: &packs });
    // rust: std::fs::remove_dir_all(&root).unwrap();
    // rust: let ids = [
    // rust: "parity:a_pick",
    // rust: "minecraft:prefix-early",
    // rust: "minecraft:prefix",
    // rust: "minecraft:z_pick",
    // rust: ];
    // rust: assert_eq!(
    // rust: ids.map(|id| index.first_display(id)),
    // rust: [Some(0), Some(1), Some(2), Some(3)]
    // rust: );
    // rust: assert_eq!(index.recipe_of_display(0), Some("parity:a_pick"));
}
}
