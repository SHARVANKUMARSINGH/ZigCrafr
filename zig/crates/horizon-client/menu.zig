//! Transpiled from Horizon Rust crate
//! Module: horizon-client_menu
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `AbstractContainerMenu.clicked` over vanilla's slot layouts: every
//! `ContainerInput` (pickup, quick move, swap, clone, throw, the three quick
//! craft drags, pickup all) for the player inventory, the crafting table, the
//! chest family, hoppers, dispensers, shulker boxes, the furnaces, the brewing
//! stand, the crafter (its client menu and the block entity's server menu with
//! `setSlotState`), the loom (`clickMenuButton`, `slotsChanged`), the
//! stonecutter (its recipe buttons and result) and the merchant (`MerchantMenu` over a `merchant::Session`: payment slots, the
//! result slot's trade, `tryMoveItems`).
//! `tools/test_menu_click_parity.py` compares every click with vanilla's menu
//! classes.
// use crate::{
    // rust: banner::{self, Banners},
    // rust: brewing::Brewing,
    // rust: crafting::Recipes,
    // rust: items::{ItemStack, Items},
}
// use std::sync::Arc;

    // rust: mod bundle;
    // rust: pub mod place;

/// `ServerPlayer.getRecipeBook`: whether the player knows a recipe.
    // rust: pub trait KnownRecipes {
pub fn knows(self: *Self, recipe_id: []const u8) b;
}

    // rust: impl KnownRecipes for crate::recipe_book::Settings {
pub fn knows(self: *Self, recipe_id: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let q = crate::crafting::qualified(recipe_id);
    // rust: self.recipes.contains(&q) || self.recipes.contains(recipe_id)
}
}

    // rust: impl KnownRecipes for std::collections::BTreeSet<String> {
pub fn knows(self: *Self, recipe_id: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let q = crate::crafting::qualified(recipe_id);
    // rust: self.contains(&q) || self.contains(recipe_id)
}
}

    // rust: impl KnownRecipes for std::collections::HashSet<String> {
pub fn knows(self: *Self, recipe_id: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let q = crate::crafting::qualified(recipe_id);
    // rust: self.contains(&q) || self.contains(recipe_id)
}
}

    // rust: impl KnownRecipes for [String] {
pub fn knows(self: *Self, recipe_id: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let q = crate::crafting::qualified(recipe_id);
    // rust: self.iter().any(|r| r == &q || r == recipe_id)
}
}

    // rust: impl KnownRecipes for Vec<String> {
pub fn knows(self: *Self, recipe_id: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.as_slice().knows(recipe_id)
}
}

    // rust: impl<const N: usize> KnownRecipes for [&str; N] {
pub fn knows(self: *Self, recipe_id: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let q = crate::crafting::qualified(recipe_id);
    // rust: self.iter().any(|r| *r == q.as_str() || *r == recipe_id)
}
}

    // rust: impl KnownRecipes for &[&str] {
pub fn knows(self: *Self, recipe_id: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let q = crate::crafting::qualified(recipe_id);
    // rust: self.iter().any(|r| *r == q.as_str() || *r == recipe_id)
}
}

/// What a menu needs to know about items and recipes.
pub const Env = struct {
    items: *'a Items,
    recipes: *'a Recipes,
    brewing: *'a Brewing,
    banners: *'a Banners,
    /// The stonecutter's recipes.
    station_recipes: *'a crate::stations::StationRecipes,
    /// The grindstone's and the anvil's enchantment rules.
    enchantments: *'a crate::enchant::Enchantments,
    /// Item display names: the anvil compares the rename box with the
    /// input's hover name.
    names: *'a crate::creative::Names,
    /// What a merchant menu needs for offers made while it is open (level-ups).
    trade: ?*'a crate::merchant::TradeEnv<'a>,
    /// The level's maps (`ContainerLevelAccess`): the cartography table reads
    /// and makes them. None is a client's menu (`ContainerLevelAccess.NULL`):
    /// it makes no result, and a taken result keeps its map id.
    maps: ?*'a dyn Maps,
    /// `GameRules.LIMITED_CRAFTING`: when true, only known or special recipes craft.
    limited_crafting: bool,
    /// The recipes the player knows (`ServerPlayer.getRecipeBook().contains(id)`).
    known_recipes: ?*'a dyn KnownRecipes,
};

/// The maps of the level a menu is in.
    // rust: pub trait Maps {
    /// `MapItem.getSavedData`: whether map `id` is locked, and its scale;
    /// None when the level has no such map.
pub fn state(self: *Self, id: i32) O;
    /// `MapItem.scaleMap` (`scale`) or `lockMap`: the copy of map `id` the
    /// level makes under a new id (`getFreeMapId`), None without the map.
pub fn derive(self: *Self, id: i32, scale: bool) O;
}

pub const Input = enum {
    Pickup,
    QuickMove,
    Swap,
    Clone,
    Throw,
    QuickCraft,
    PickupAll,
};

    // rust: impl Input {
pub fn parse(name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(match name {
    // rust: "PICKUP" => Self::Pickup,
    // rust: "QUICK_MOVE" => Self::QuickMove,
    // rust: "SWAP" => Self::Swap,
    // rust: "CLONE" => Self::Clone,
    // rust: "THROW" => Self::Throw,
    // rust: "QUICK_CRAFT" => Self::QuickCraft,
    // rust: "PICKUP_ALL" => Self::PickupAll,
    // rust: _ => return None,
    // rust: })
}
}

pub const Kind = enum {
    Inventory,
    Crafting,
    Chest(usize),
    Hopper,
    Dispenser,
    Shulker,
    /// The cooking recipe type: smelting, blasting or smoking.
    Furnace(&'static str),
    Brewing,
    /// `CrafterMenu` over a plain crafting container (the client's menu).
    Crafter,
    /// `CrafterMenu` over the `CrafterBlockEntity` (the server's menu): the
    /// result follows the grid, and filling a disabled slot enables it.
    CrafterBlock,
    Loom,
    /// `StonecutterMenu`: the input, the result, then the inventory.
    Stonecutter,
    /// `GrindstoneMenu`: two inputs, the result, then the inventory.
    Grindstone,
    /// `AnvilMenu`: two inputs, the result, then the inventory.
    Anvil,
    /// `SmithingMenu`: template, base, addition, the result, then the inventory.
    Smithing,
    /// `EnchantmentMenu`: the item, the lapis, then the inventory; its data
    /// slots are the three costs, the seed and the clues.
    Enchanting,
    /// `BeaconMenu`: the payment slot, then the inventory; its data slots are
    /// the pyramid's levels and the two powers (`encodeEffect`: id + 1).
    Beacon,
    /// `CartographyTableMenu`: the map, the paper / map / glass pane, the
    /// result, then the inventory.
    Cartography,
    /// `LecternMenu` over the `LecternBlockEntity`: the book's one slot (no
    /// inventory slots); its data slot is the open page.
    Lectern,
    /// `MerchantMenu`: two payment slots, the result, then the inventory.
    Merchant,
    /// `HorseInventoryMenu`: the saddle and body armour slots (`ArmorSlot`s
    /// of the mount, whose entity type is `Menu::mount`), a chest of three
    /// rows of this many columns (`getInventoryColumns`), then the inventory.
    Mount(usize),
    /// `CreativeModeInventoryScreen.ItemPickerMenu`: an item tab's 45
    /// display slots, then the hotbar.
    ItemPicker,
    /// A content mod's menu type: its slots, then the inventory.
    Mod(&'static crate::containers::ModMenuType),
};

    // rust: impl Kind {
pub fn parse(name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(rows) = name.strip_prefix("chest") {
    // rust: return rows.parse().ok().map(Self::Chest);
}
    // rust: if let Some(columns) = name.strip_prefix("mount") {
    // rust: return columns.parse().ok().map(Self::Mount);
}
    // rust: Some(match name {
    // rust: "inventory" => Self::Inventory,
    // rust: "crafting" => Self::Crafting,
    // rust: "hopper" => Self::Hopper,
    // rust: "dispenser" => Self::Dispenser,
    // rust: "shulker" => Self::Shulker,
    // rust: "furnace" => Self::Furnace("smelting"),
    // rust: "blast_furnace" => Self::Furnace("blasting"),
    // rust: "smoker" => Self::Furnace("smoking"),
    // rust: "brewing" => Self::Brewing,
    // rust: "crafter" => Self::Crafter,
    // rust: "crafter_be" => Self::CrafterBlock,
    // rust: "loom" => Self::Loom,
    // rust: "stonecutter" => Self::Stonecutter,
    // rust: "grindstone" => Self::Grindstone,
    // rust: "anvil" => Self::Anvil,
    // rust: "smithing" => Self::Smithing,
    // rust: "enchanting" => Self::Enchanting,
    // rust: "beacon" => Self::Beacon,
    // rust: "cartography" => Self::Cartography,
    // rust: "lectern" => Self::Lectern,
    // rust: "merchant" => Self::Merchant,
    // rust: "item_picker" => Self::ItemPicker,
    // rust: _ => return None,
    // rust: })
}
}

/// `Slot` subclasses that change the rules.
pub const Role = enum {
    Plain,
    /// `ArmorSlot` for the equipment slot with this `EquipmentSlot.getIndex`.
    Armor(usize),
    Shulker,
    Fuel,
    /// `FurnaceResultSlot`.
    Output,
    /// `ResultSlot` of a crafting grid.
    CraftResult,
    /// `CrafterSlot`: refuses items while its disabled flag (data slot) is set.
    CrafterIn,
    /// `NonInteractiveResultSlot`.
    Inert,
    /// `BrewingStandMenu.PotionSlot`.
    Potion,
    /// `BrewingStandMenu.IngredientsSlot`.
    Ingredient,
    /// `BrewingStandMenu.FuelSlot`.
    BrewFuel,
    /// The loom's banner, dye and pattern slots.
    LoomBanner,
    LoomDye,
    LoomPattern,
    /// The loom's result slot (a plain slot whose `onTake` uses the inputs).
    LoomResult,
    /// `MerchantResultSlot`.
    MerchantResult,
    /// The stonecutter's result slot (`onTake` uses up one input).
    StoneResult,
    /// The grindstone's inputs: damageable or enchanted items.
    GrindInput,
    /// The grindstone's result slot (`onTake` clears both inputs).
    GrindResult,
    /// A smithing table input: its recipe property set (template, base, addition).
    SmithInput(usize),
    /// `ItemCombinerMenu`'s result slot (the anvil's and the smithing table's).
    CombineResult,
    /// The enchanting table's item slot (one item).
    EnchantItem,
    /// The enchanting table's lapis slot.
    Lapis,
    /// `BeaconMenu.PaymentSlot`: one beacon payment item.
    BeaconPay,
    /// The cartography table's map slot (anything with a map id).
    CartoMap,
    /// Its paper, empty map or glass pane slot.
    CartoExtra,
    /// Its result (`onTake`: one of each input, the map post-processed).
    CartoResult,
    /// `CustomCreativeSlot`: a creative tab's display slot, which the
    /// screen clicks itself; drags and PICKUP_ALL pass it by.
    CreativeDisplay,
    /// An `ArmorSlot` of a mount for this `EquipmentSlot` ("saddle" or
    /// "body"): `isEquippableInSlot` for `Menu::mount`, one item.
    MountEquip(&'static str),
    /// A mod menu type's slot.
    Mod,
    /// A mod menu type's result (`results`): players only take from it.
    ModResult,
    /// A slot the mod's screen leaves out: no click reaches it.
    Hidden,
};

pub const Slot = struct {
    container: usize,
    index: usize,
    role: Role,
};

/// `BeaconBlockEntity.BEACON_EFFECTS`: the powers of each pyramid level.
    // rust: pub const BEACON_EFFECTS: [&[&str]; 4] = [
    // rust: &["minecraft:speed", "minecraft:haste"],
    // rust: &["minecraft:resistance", "minecraft:jump_boost"],
    // rust: &["minecraft:strength"],
    // rust: &["minecraft:regeneration"],
    // rust: ];

/// `BeaconBlockEntity.getRequiredLevelsFor`: 0 for no power, `i32::MAX`
/// for one no level gives.
pub fn beacon_required_levels(effect: ?[]const u8) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(effect) = effect else {
    // rust: return 0;
}
    // rust: BEACON_EFFECTS
    // rust: .iter()
    // rust: .position(|tier| tier.contains(&effect))
    // rust: .map_or(i32::MAX, |i| i as i32 + 1)
}

/// `Item.canFitInsideContainerItems` (`ShulkerBoxSlot.mayPlace`): shulker
/// boxes cannot nest.
pub fn fits_inside_container_items(stack: *ItemStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !stack.item.ends_with("shulker_box")
}

/// The containers a menu spans.
pub const PLAYER: usize = 0;
pub const MAIN: usize = 1;
pub const GRID: usize = 2;
pub const RESULT: usize = 3;
/// `Container.getMaxStackSize`.
pub const CONTAINER_MAX: u32 = 99;
pub const OFFHAND: usize = 40;

pub const Menu = struct {
    kind: Kind,
    slots: std.ArrayList(Slot),
    containers: [std.ArrayList(?ItemStack),
    grid_size: usize,
    carried: ?ItemStack,
    data: std.ArrayList(i32),
    creative: bool,
    /// The selected hotbar slot (`Inventory.selected`).
    selected: usize,
    /// Dropped stacks (canonical text), `xp+N` and the like, in order.
    drops: std.ArrayList([]const u8),
    /// The dropped stacks themselves, for the caller to throw.
    dropped: std.ArrayList(ItemStack),
    quick_status: i32,
    quick_type: i32,
    quick_slots: std.ArrayList(usize),
    /// `LoomMenu.selectablePatterns`.
    loom_patterns: std.ArrayList(*str),
    /// Sounds the menu plays (`ui.loom.take_result`), for the caller.
    sounds: std.ArrayList(*'static str),
    /// Sounds the player makes (a bundle's insert and remove), for the
    /// caller to play at the player as `Entity.playSound`.
    player_sounds: std.ArrayList(*'static str),
    /// Recipes whose result was taken (`awardUsedRecipes`) and the stacks that
    /// went into each, for the caller.
    crafted: Vec<([]const u8,
    /// A crafting grid's result taken (`ResultSlot.onTake`): the recipe and
    /// the stack taken, for the caller (`native_item_crafted`).
    item_crafted: Vec<([]const u8,
    /// Potions taken from a brewing stand's bottle slots
    /// (`PotionSlot.onTake`), for the caller.
    brewed: std.ArrayList(ItemStack),
    /// `LivingEntity.onEquipItem` calls that change the item: the
    /// `EquipmentSlot` name and the new stack, in order, for the caller.
    equipped: Vec<(*'static str,
    /// The merchant a merchant menu trades with.
    merchant: ?*crate::merchant::Session,
    /// The stonecutter's recipe list (`recipesForInput`).
    stone: Stonecutter,
    /// The grindstone result's `getExperienceAmount` sum before its roll,
    /// set when the result was taken: the caller (with a level) awards the
    /// orbs and plays level event 1042.
    ground: ?i32,
    /// `Player.experienceLevel`, which the anvil's result needs.
    levels: i32,
    /// The levels the menu gave the player (`giveExperienceLevels`), for the caller.
    level_change: i32,
    /// `AnvilMenu`'s state besides its slots and its cost data slot.
    anvil: Anvil,
    /// The anvil's or the smithing table's result was taken: the caller (with
    /// a level) runs the rest of its `onTake` (the anvil's wear and level
    /// event 1030 or 1029, the smithing table's 1044).
    combined: bool,
    /// The caller fires `AnvilCraftEvent.Pre` for a taken anvil result: its
    /// `onTake` waits in `anvil_craft` for the caller to run `anvil_take`, or
    /// to refuse the take with `anvil_cancel` (from an `anvil_undo` made
    /// before the click).
    anvil_hook: bool,
    /// The anvil result taken while `anvil_hook` is set, as it was before
    /// crafting.
    anvil_craft: ?AnvilCraft,
    /// The enchanting table's item changed to an enchantable one: the caller
    /// (with a level) fills the costs and clues (`slotsChanged`'s
    /// `access.execute`).
    enchant_changed: bool,
    /// An enchanting button the menu took (`clickMenuButton` passed its
    /// checks): the caller (with a level) enchants.
    enchant_button: ?usize,
    /// `Player.mayBuild` (not adventure mode): the lectern's Take Book.
    may_build: bool,
    /// A mount menu's entity type (`minecraft:horse`): what its saddle and
    /// body slots take.
    mount: ?[]const u8,
};

/// `AnvilMenu`'s state besides its slots and `cost`.
pub const Anvil = struct {
    /// `itemName`: the rename box's text (`ServerboundRenameItemPacket`).
    name: ?[]const u8,
    /// `repairItemCountCost`.
    repair_count: u32,
    /// `onlyRenaming`.
    only_renaming: bool,
};

/// An anvil craft as `AnvilCraftEvent` reports it: the inputs and the result
/// taken, before the crafting changed anything.
pub const AnvilCraft = struct {
    left: ?ItemStack,
    right: ?ItemStack,
    output: ItemStack,
};

/// An anvil menu before a click, for `Menu::anvil_cancel`: the anvil's three
/// slots and cost, the player's slots and the cursor.
pub const AnvilUndo = struct {
    inputs: std.ArrayList(?ItemStack),
    result: ?ItemStack,
    cost: i32,
    player: std.ArrayList(?ItemStack),
    carried: ?ItemStack,
};

/// `StonecutterMenu`'s state besides its slots and `selectedRecipeIndex`.
pub const Stonecutter = struct {
    /// `recipesForInput`: indices into `StationRecipes.stonecutting`.
    recipes: std.ArrayList(usize),
    /// The item the list was made for (`input`; None for nothing).
    input: ?*str,
    /// `ResultContainer.recipeUsed`.
    used: ?usize,
};

pub fn same_item(a: *ItemStack, b: *ItemStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: a.item == b.item
}

pub fn split(stack: *mut ItemStack, amount: u32) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let real = amount.min(stack.count);
    // rust: let mut out = stack.clone();
    // rust: out.count = real;
    // rust: stack.count -= real;
    // rust: out
}

/// `LecternBlockEntity.getPageCount`: a written book's pages, else a
/// writable book's.
pub fn book_pages(stack: *ItemStack) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: stack.data().map_or(0, |d| match &d.written {
    // rust: Some(w) => w.pages.len(),
    // rust: None => d.writable_pages.len(),
    // rust: })
}

pub fn tidy(slot: *mut ?ItemStack) void {
}
    // rust: if slot.as_ref().is_some_and(|s| s.count == 0) {
    // rust: *slot = None;
}
}

/// Hook point for native mods (docs/native-mods.md, listed in `native-hooks.json`
/// with the game's): container slot `slot` of the content mod menu type `menu`
/// (`data/<id>/horizon/menu/`) is asked whether it takes `stack`
/// (`Slot.mayPlace`) and how many of it it holds (`Slot.getMaxStackSize`).
/// `may_place` and `max_stack` hold the type's own answer (false on one of its
/// `results`, true elsewhere, and 99): change them for your own menu types.
/// `max_stack` is kept to 1 to 99,
/// and the item's own stack size still caps it. Asked on the server, for each
/// click, drag and shift-click that puts an item in a slot, several times for
/// one shift-click: answer from `stack` alone, and fast. API
/// 130.
    // rust: pub fn native_menu_slot_rules(
    // rust: menu: &str,
    // rust: slot: usize,
    // rust: stack: &ItemStack,
    // rust: may_place: &mut bool,
    // rust: max_stack: &mut u32,
    // rust: ) {
    // rust: crate::native_client_hooks::menu_slot_rules(menu, slot, stack, may_place, max_stack);
}

/// An index outside the slot list: vanilla's `IndexOutOfBoundsException`.
pub const OUT_OF_BOUNDS: []const u8 = "IndexOutOfBoundsException";

    // rust: impl Menu {
pub fn new(kind: Kind) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut containers: [Vec<Option<ItemStack>>; 4] = Default::default();
    // rust: containers[PLAYER] = vec![None; 41];
    // rust: let mut slots = Vec::new();
    // rust: let mut grid_size = 0;
    // rust: let main = |n: usize, role: Role| -> Vec<Slot> {
    // rust: (0..n)
    // rust: .map(|index| Slot {
    // rust: container: MAIN,
    // rust: index,
    // rust: role,
    // rust: })
    // rust: .collect()
}
    // rust: let player = |slots: &mut Vec<Slot>| {
    // rust: for i in (9..36).chain(0..9) {
    // rust: slots.push(Slot {
    // rust: container: PLAYER,
    // rust: index: i,
    // rust: role: Role::Plain,
    // rust: });
}
}
    // rust: let grid = |slots: &mut Vec<Slot>, n: usize| {
    // rust: slots.push(Slot {
    // rust: container: RESULT,
    // rust: index: 0,
    // rust: role: Role::CraftResult,
    // rust: });
    // rust: for index in 0..n * n {
    // rust: slots.push(Slot {
    // rust: container: GRID,
    // rust: index,
    // rust: role: Role::Plain,
    // rust: });
}
}
    // rust: let mut data = 0;
    // rust: match kind {
    // rust: Kind::Inventory => {
    // rust: grid_size = 2;
    // rust: grid(&mut slots, 2);
    // rust: for (i, eq) in [3usize, 2, 1, 0].into_iter().enumerate() {
    // rust: slots.push(Slot {
    // rust: container: PLAYER,
    // rust: index: 39 - i,
    // rust: role: Role::Armor(eq),
    // rust: });
}
    // rust: player(&mut slots);
    // rust: slots.push(Slot {
    // rust: container: PLAYER,
    // rust: index: OFFHAND,
    // rust: role: Role::Plain,
    // rust: });
}
    // rust: Kind::Crafting => {
    // rust: grid_size = 3;
    // rust: grid(&mut slots, 3);
    // rust: player(&mut slots);
}
    // rust: Kind::Chest(rows) => {
    // rust: containers[MAIN] = vec![None; rows * 9];
    // rust: slots.extend(main(rows * 9, Role::Plain));
    // rust: player(&mut slots);
}
    // rust: Kind::Hopper => {
    // rust: containers[MAIN] = vec![None; 5];
    // rust: slots.extend(main(5, Role::Plain));
    // rust: player(&mut slots);
}
    // rust: Kind::Dispenser => {
    // rust: containers[MAIN] = vec![None; 9];
    // rust: slots.extend(main(9, Role::Plain));
    // rust: player(&mut slots);
}
    // rust: Kind::Shulker => {
    // rust: containers[MAIN] = vec![None; 27];
    // rust: slots.extend(main(27, Role::Shulker));
    // rust: player(&mut slots);
}
    // rust: Kind::Mod(t) => {
    // rust: containers[MAIN] = vec![None; t.slots];
    // rust: slots.extend((0..t.slots).map(|index| Slot {
    // rust: container: MAIN,
    // rust: index,
    // rust: role: match t.results.contains(&index) {
    // rust: true => Role::ModResult,
    // rust: false => Role::Mod,
    // rust: },
    // rust: }));
    // rust: player(&mut slots);
}
    // rust: Kind::Crafter | Kind::CrafterBlock => {
    // rust: containers[MAIN] = vec![None; 9];
    // rust: slots.extend(main(9, Role::CrafterIn));
    // rust: player(&mut slots);
    // rust: slots.push(Slot {
    // rust: container: RESULT,
    // rust: index: 0,
    // rust: role: Role::Inert,
    // rust: });
    // rust: data = 10;
}
    // rust: Kind::Loom => {
    // rust: containers[MAIN] = vec![None; 3];
    // rust: for (index, role) in [Role::LoomBanner, Role::LoomDye, Role::LoomPattern]
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: {
    // rust: slots.push(Slot {
    // rust: container: MAIN,
    // rust: index,
    // rust: role,
    // rust: });
}
    // rust: slots.push(Slot {
    // rust: container: RESULT,
    // rust: index: 0,
    // rust: role: Role::LoomResult,
    // rust: });
    // rust: player(&mut slots);
    // rust: data = 1;
}
    // rust: Kind::Stonecutter => {
    // rust: containers[MAIN] = vec![None; 1];
    // rust: slots.extend(main(1, Role::Plain));
    // rust: slots.push(Slot {
    // rust: container: RESULT,
    // rust: index: 0,
    // rust: role: Role::StoneResult,
    // rust: });
    // rust: player(&mut slots);
                // selectedRecipeIndex: DataSlot.standalone() starts at 0.
    // rust: data = 1;
}
    // rust: Kind::Grindstone => {
    // rust: containers[MAIN] = vec![None; 2];
    // rust: slots.extend(main(2, Role::GrindInput));
    // rust: slots.push(Slot {
    // rust: container: RESULT,
    // rust: index: 0,
    // rust: role: Role::GrindResult,
    // rust: });
    // rust: player(&mut slots);
}
    // rust: Kind::Anvil => {
    // rust: containers[MAIN] = vec![None; 2];
    // rust: slots.extend(main(2, Role::Plain));
    // rust: slots.push(Slot {
    // rust: container: RESULT,
    // rust: index: 0,
    // rust: role: Role::CombineResult,
    // rust: });
    // rust: player(&mut slots);
                // cost: DataSlot.standalone() starts at 0.
    // rust: data = 1;
}
    // rust: Kind::Smithing => {
    // rust: containers[MAIN] = vec![None; 3];
    // rust: slots.extend((0..3).map(|index| Slot {
    // rust: container: MAIN,
    // rust: index,
    // rust: role: Role::SmithInput(index),
    // rust: }));
    // rust: slots.push(Slot {
    // rust: container: RESULT,
    // rust: index: 0,
    // rust: role: Role::CombineResult,
    // rust: });
    // rust: player(&mut slots);
                // hasRecipeError.
    // rust: data = 1;
}
    // rust: Kind::Enchanting => {
    // rust: containers[MAIN] = vec![None; 2];
    // rust: slots.push(Slot {
    // rust: container: MAIN,
    // rust: index: 0,
    // rust: role: Role::EnchantItem,
    // rust: });
    // rust: slots.push(Slot {
    // rust: container: MAIN,
    // rust: index: 1,
    // rust: role: Role::Lapis,
    // rust: });
    // rust: player(&mut slots);
                // costs[3], enchantmentSeed, enchantClue[3], levelClue[3].
    // rust: data = 10;
}
    // rust: Kind::Beacon => {
    // rust: containers[MAIN] = vec![None; 1];
    // rust: slots.extend(main(1, Role::BeaconPay));
    // rust: player(&mut slots);
                // levels, primary, secondary.
    // rust: data = 3;
}
    // rust: Kind::Cartography => {
    // rust: containers[MAIN] = vec![None; 2];
    // rust: for (index, role) in [Role::CartoMap, Role::CartoExtra].into_iter().enumerate() {
    // rust: slots.push(Slot {
    // rust: container: MAIN,
    // rust: index,
    // rust: role,
    // rust: });
}
    // rust: slots.push(Slot {
    // rust: container: RESULT,
    // rust: index: 0,
    // rust: role: Role::CartoResult,
    // rust: });
    // rust: player(&mut slots);
}
    // rust: Kind::Lectern => {
    // rust: containers[MAIN] = vec![None; 1];
    // rust: slots.extend(main(1, Role::Plain));
                // The open page (LecternBlockEntity.dataAccess).
    // rust: data = 1;
}
    // rust: Kind::Mount(columns) => {
    // rust: containers[MAIN] = vec![None; 2 + columns * 3];
    // rust: for (index, slot) in ["saddle", "body"].into_iter().enumerate() {
    // rust: slots.push(Slot {
    // rust: container: MAIN,
    // rust: index,
    // rust: role: Role::MountEquip(slot),
    // rust: });
}
    // rust: slots.extend((2..2 + columns * 3).map(|index| Slot {
    // rust: container: MAIN,
    // rust: index,
    // rust: role: Role::Plain,
    // rust: }));
    // rust: player(&mut slots);
}
    // rust: Kind::ItemPicker => {
    // rust: containers[MAIN] = vec![None; 45];
    // rust: slots.extend(main(45, Role::CreativeDisplay));
                // addInventoryHotbarSlots.
    // rust: slots.extend((0..9).map(|index| Slot {
    // rust: container: PLAYER,
    // rust: index,
    // rust: role: Role::Plain,
    // rust: }));
}
    // rust: Kind::Merchant => {
    // rust: containers[MAIN] = vec![None; 2];
    // rust: slots.extend(main(2, Role::Plain));
    // rust: slots.push(Slot {
    // rust: container: RESULT,
    // rust: index: 0,
    // rust: role: Role::MerchantResult,
    // rust: });
    // rust: player(&mut slots);
}
    // rust: Kind::Brewing => {
    // rust: containers[MAIN] = vec![None; 5];
    // rust: for (index, role) in [
    // rust: Role::Potion,
    // rust: Role::Potion,
    // rust: Role::Potion,
    // rust: Role::Ingredient,
    // rust: Role::BrewFuel,
    // rust: ]
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: {
    // rust: slots.push(Slot {
    // rust: container: MAIN,
    // rust: index,
    // rust: role,
    // rust: });
}
    // rust: player(&mut slots);
    // rust: data = 4;
}
    // rust: Kind::Furnace(_) => {
    // rust: containers[MAIN] = vec![None; 3];
    // rust: slots.extend([
    // rust: Slot {
    // rust: container: MAIN,
    // rust: index: 0,
    // rust: role: Role::Plain,
    // rust: },
    // rust: Slot {
    // rust: container: MAIN,
    // rust: index: 1,
    // rust: role: Role::Fuel,
    // rust: },
    // rust: Slot {
    // rust: container: MAIN,
    // rust: index: 2,
    // rust: role: Role::Output,
    // rust: },
    // rust: ]);
    // rust: player(&mut slots);
    // rust: data = 4;
}
}
    // rust: containers[GRID] = vec![None; grid_size * grid_size];
    // rust: containers[RESULT] = vec![None; 1];
    // rust: Self {
    // rust: kind,
    // rust: slots,
    // rust: containers,
    // rust: grid_size,
    // rust: carried: None,
    // rust: data: vec![0; data],
    // rust: creative: false,
    // rust: selected: 0,
    // rust: drops: Vec::new(),
    // rust: dropped: Vec::new(),
    // rust: quick_status: 0,
    // rust: quick_type: 0,
    // rust: quick_slots: Vec::new(),
    // rust: loom_patterns: Vec::new(),
    // rust: sounds: Vec::new(),
    // rust: player_sounds: Vec::new(),
    // rust: crafted: Vec::new(),
    // rust: item_crafted: Vec::new(),
    // rust: brewed: Vec::new(),
    // rust: equipped: Vec::new(),
    // rust: merchant: None,
    // rust: stone: Stonecutter::default(),
    // rust: ground: None,
    // rust: levels: 0,
    // rust: level_change: 0,
    // rust: anvil: Anvil::default(),
    // rust: combined: false,
    // rust: anvil_hook: false,
    // rust: anvil_craft: None,
    // rust: enchant_changed: false,
    // rust: enchant_button: None,
    // rust: may_build: true,
    // rust: mount: None,
}
    // rust: .with_initial_data()
}

    /// Data slots that do not start at 0: the enchanting table's clues are -1.
pub fn with_initial_data() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.kind == Kind::Enchanting {
    // rust: self.data[4..].fill(-1);
}
    // rust: self
}

pub fn kind(self: *Self) K {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.kind
}

    /// `clickMenuButton`: the loom's pattern buttons and the stonecutter's
    /// recipes. False when refused.
pub fn button(self: *Self, env: *Env, id: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.kind == Kind::Lectern {
    // rust: return self.lectern_button(env, id);
}
    // rust: if self.kind == Kind::Enchanting {
    // rust: return self.enchant_click(id);
}
    // rust: if self.kind == Kind::Stonecutter {
            // StonecutterMenu.clickMenuButton: an invalid index is taken too.
    // rust: if self.data[0] == id {
    // rust: return false;
}
    // rust: if id >= 0 && (id as usize) < self.stone.recipes.len() {
    // rust: self.data[0] = id;
    // rust: self.stone_setup_result(env, id);
}
    // rust: return true;
}
    // rust: if self.kind != Kind::Loom || id < 0 || id as usize >= self.loom_patterns.len() {
    // rust: return false;
}
    // rust: self.data[0] = id;
    // rust: let pattern = self.loom_patterns[id as usize].clone();
    // rust: self.loom_setup_result(env, &pattern);
    // rust: true
}

    /// `LecternMenu.clickMenuButton`: the page buttons (1 back, 2 forward,
    /// 100 + n to page n) and Take Book (3), which puts the book in the
    /// inventory or drops it.
pub fn lectern_button(self: *Self, env: *Env, id: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match id {
    // rust: 100.. => self.set_data(0, id - 100),
    // rust: 1 => self.set_data(0, self.data[0] - 1),
    // rust: 2 => self.set_data(0, self.data[0] + 1),
    // rust: 3 if self.may_build => {
                // removeItemNoUpdate: the whole book, and onBookItemRemove.
    // rust: let book = self.containers[MAIN][0].take();
    // rust: self.data[0] = 0;
    // rust: if let Some(mut book) = book
    // rust: && !self.inventory_add(env, &mut book)
    // rust: {
    // rust: self.drop_stack(&book);
}
}
    // rust: _ => return false,
}
    // rust: true
}

    /// `AbstractContainerMenu.setData`: the lectern's is
    /// `LecternBlockEntity.setPage`, kept within the book's pages.
pub fn set_data(self: *Self, id: usize, value: i32) void {
}
    // rust: if self.kind == Kind::Lectern && id == 0 {
            // Mth.clamp(page, 0, pageCount - 1).
    // rust: let count = self.containers[MAIN][0].as_ref().map_or(0, book_pages) as i32;
    // rust: self.data[0] = value.max(0).min(count - 1);
    // rust: return;
}
    // rust: self.data[id] = value;
}

    /// Container slot `slot` of a mod menu type is left out by its screen.
pub fn hide_slot(self: *Self, slot: usize) void {
}
    // rust: if matches!(self.kind, Kind::Mod(_)) && slot < self.slots.len() - 36 {
    // rust: self.slots[slot].role = Role::Hidden;
}
}

    /// `CrafterBlockEntity.setSlotState` (the slot state packet): only an
    /// empty slot can be disabled or enabled.
pub fn set_slot_state(self: *Self, slot: usize, enabled: bool) void {
}
    // rust: if self.kind == Kind::CrafterBlock && slot < 9 && self.containers[MAIN][slot].is_none() {
    // rust: self.data[slot] = i32::from(!enabled);
}
}

    /// The menu after a fixture set its slots: the block crafter's slot
    /// listener has refreshed the result (`broadcastChanges`).
pub fn settle(self: *Self, env: *Env) void {
}
    // rust: if self.kind == Kind::CrafterBlock {
    // rust: self.crafter_result(env);
}
}

    /// `CrafterMenu.refreshRecipeResult`.
pub fn crafter_result(self: *Self, env: *Env) void {
}
    // rust: self.containers[RESULT][0] = env
    // rust: .recipes
    // rust: .find(&self.containers[MAIN], 3)
    // rust: .map(|(_, stack)| stack)
    // rust: .filter(|s| s.count > 0);
}

    /// `LoomMenu.setupResultSlot`.
pub fn loom_setup_result(self: *Self, env: *Env, pattern: []const u8) void {
}
    // rust: let mut result = None;
    // rust: if let (Some(banner_stack), Some(dye)) = (
    // rust: self.containers[MAIN][0].as_ref(),
    // rust: self.containers[MAIN][1].as_ref(),
    // rust: ) && let Some(color) = env.banners.loom_dye(env.items, dye)
    // rust: {
    // rust: result = Some(banner::loom_result(banner_stack, &color, pattern));
}
    // rust: self.containers[RESULT][0] = result;
}

    /// `LoomMenu.slotsChanged`.
pub fn loom_changed(self: *Self, env: *Env) void {
}
    // rust: let has_inputs = self.containers[MAIN][0].is_some() && self.containers[MAIN][1].is_some();
    // rust: if !has_inputs {
    // rust: self.containers[RESULT][0] = None;
    // rust: self.loom_patterns.clear();
    // rust: self.data[0] = -1;
    // rust: return;
}
    // rust: let selected = self.data[0];
    // rust: let valid = selected >= 0 && (selected as usize) < self.loom_patterns.len();
    // rust: let pattern_item = self.containers[MAIN][2].clone();
    // rust: let previous = std::mem::replace(
    // rust: &mut self.loom_patterns,
    // rust: env.banners.selectable(pattern_item.as_ref()),
    // rust: );
    // rust: let shown = if self.loom_patterns.len() == 1 {
    // rust: self.data[0] = 0;
    // rust: Some(self.loom_patterns[0].clone())
    // rust: } else if !valid {
    // rust: self.data[0] = -1;
    // rust: None
    // rust: } else {
    // rust: let value = previous[selected as usize].clone();
    // rust: match self.loom_patterns.iter().position(|p| *p == value) {
    // rust: Some(i) => {
    // rust: self.data[0] = i as i32;
    // rust: Some(value)
}
    // rust: None => {
    // rust: self.data[0] = -1;
    // rust: None
}
}
}
    // rust: match shown {
    // rust: Some(pattern) => {
    // rust: let full = self.containers[MAIN][0]
    // rust: .as_ref()
    // rust: .is_some_and(banner::has_max_layers);
    // rust: if full {
    // rust: self.data[0] = -1;
    // rust: self.containers[RESULT][0] = None;
    // rust: } else {
    // rust: self.loom_setup_result(env, &pattern);
}
}
    // rust: None => self.containers[RESULT][0] = None,
}
}

    /// `StonecutterMenu.slotsChanged`: a new input item lists its recipes
    /// (`setupRecipeList`), with none selected and no result.
pub fn stone_changed(self: *Self, env: *Env) void {
}
    // rust: let input = self.containers[MAIN][0].as_ref().map(|s| s.item.clone());
    // rust: if input == self.stone.input {
    // rust: return;
}
    // rust: self.stone.input = input;
    // rust: self.data[0] = -1;
    // rust: self.containers[RESULT][0] = None;
    // rust: self.stone.recipes = match &self.containers[MAIN][0] {
    // rust: Some(stack) => env
    // rust: .station_recipes
    // rust: .stonecutting
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, r)| r.input.test(stack))
    // rust: .map(|(i, _)| i)
    // rust: .collect(),
    // rust: None => Vec::new(),
}
}

    /// `StonecutterMenu.setupResultSlot`.
pub fn stone_setup_result(self: *Self, env: *Env, index: i32) void {
}
    // rust: let recipe = usize::try_from(index)
    // rust: .ok()
    // rust: .and_then(|i| self.stone.recipes.get(i).copied());
    // rust: self.stone.used = recipe;
    // rust: self.containers[RESULT][0] =
    // rust: recipe.map(|r| env.station_recipes.stonecutting[r].result.clone());
}

    /// `Slot.setChanged` on slot `s`: the loom recomputes from its inputs,
    /// the stonecutter lists its recipes, the block crafter refreshes its
    /// result.
pub fn slot_changed(self: *Self, env: *Env, s: usize) void {
}
        // MerchantContainer.setChanged: every slot of it, the result too.
    // rust: if self.kind == Kind::Merchant && self.slots[s].container != PLAYER {
    // rust: self.merchant_update(env);
    // rust: return;
}
        // SmithingMenu.slotsChanged runs for its result container too.
    // rust: if self.kind == Kind::Smithing && self.slots[s].container == RESULT {
    // rust: self.smith_error();
    // rust: return;
}
        // CartographyTableMenu: its result container calls slotsChanged too.
    // rust: if self.kind == Kind::Cartography && self.slots[s].container != PLAYER {
    // rust: self.carto_changed(env);
    // rust: return;
}
    // rust: if self.slots[s].container != MAIN {
    // rust: return;
}
    // rust: match self.kind {
    // rust: Kind::Loom => self.loom_changed(env),
    // rust: Kind::Stonecutter => self.stone_changed(env),
            // GrindstoneMenu.createResult.
    // rust: Kind::Grindstone => {
    // rust: self.containers[RESULT][0] = crate::stations::grindstone_result(
    // rust: env.enchantments,
    // rust: env.items,
    // rust: self.containers[MAIN][0].as_ref(),
    // rust: self.containers[MAIN][1].as_ref(),
    // rust: );
}
    // rust: Kind::CrafterBlock => self.crafter_result(env),
    // rust: Kind::Anvil => self.anvil_result(env),
    // rust: Kind::Enchanting => self.enchant_changed(env),
    // rust: Kind::Smithing => {
    // rust: self.smith_result(env);
    // rust: self.smith_error();
}
    // rust: _ => {}
}
}

    /// `slotsChanged(player.getInventory())`, which a bundle click calls
    /// (`BundleItem.broadcastChangesOnContainerMenu`): the menus that don't
    /// check which container changed recompute from their inputs.
pub fn inventory_slots_changed(self: *Self, env: *Env) void {
}
    // rust: match self.kind {
    // rust: Kind::Inventory | Kind::Crafting => self.recompute(env),
    // rust: Kind::Loom => self.loom_changed(env),
    // rust: Kind::Stonecutter => self.stone_changed(env),
    // rust: Kind::Cartography => self.carto_changed(env),
    // rust: Kind::Merchant => self.merchant_update(env),
            // ItemCombinerMenu.slotsChanged only for its inputs; the
            // smithing table's hasRecipeError always.
    // rust: Kind::Smithing => self.smith_error(),
    // rust: _ => {}
}
}

    /// `EnchantmentMenu.clickMenuButton`'s checks: the lapis, the cost and
    /// the levels (creative pays nothing). The enchanting itself needs a
    /// level and is the caller's (`enchant_button`).
pub fn enchant_click(self: *Self, id: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(i) = usize::try_from(id).ok().filter(|&i| i < 3) else {
    // rust: return false;
}
    // rust: let need = id + 1;
    // rust: let lapis = self.containers[MAIN][1]
    // rust: .as_ref()
    // rust: .map_or(0, |l| l.count as i32);
    // rust: if lapis < need && !self.creative {
    // rust: return false;
}
    // rust: if self.data[i] <= 0
    // rust: || self.containers[MAIN][0].is_none()
    // rust: || (self.levels < need || self.levels < self.data[i]) && !self.creative
    // rust: {
    // rust: return false;
}
    // rust: self.enchant_button = Some(i);
    // rust: true
}

    /// `EnchantmentMenu.slotsChanged`: no costs or clues without an
    /// enchantable item; with one, a level fills them (`enchant_changed`).
pub fn enchant_changed(self: *Self, env: *Env) void {
}
    // rust: let enchantable = self.containers[MAIN][0].as_ref().is_some_and(|s| {
    // rust: env.enchantments.enchantable(&s.item) > 0 && s.enchantments().is_empty()
    // rust: });
    // rust: if enchantable {
    // rust: self.enchant_changed = true;
    // rust: } else {
    // rust: self.data[..3].fill(0);
    // rust: self.data[4..].fill(-1);
}
}

    /// `AnvilMenu.createResult`.
pub fn anvil_result(self: *Self, env: *Env) void {
}
    // rust: let hover = self.containers[MAIN][0]
    // rust: .as_ref()
    // rust: .map(|i| crate::stations::hover_name(&|id| env.names.display_item(id), i))
    // rust: .unwrap_or_default();
    // rust: let out = crate::stations::anvil_result(
    // rust: env.enchantments,
    // rust: env.items,
    // rust: self.containers[MAIN][0].as_ref(),
    // rust: self.containers[MAIN][1].as_ref(),
    // rust: self.anvil.name.as_deref(),
    // rust: &hover,
    // rust: self.creative,
    // rust: );
        // onlyRenaming is reset, repairItemCountCost only where an input is.
    // rust: self.anvil.only_renaming = out.only_renaming;
    // rust: if self.containers[MAIN][0].is_some() {
    // rust: self.anvil.repair_count = out.repair_item_count_cost;
}
    // rust: self.data[0] = out.cost;
    // rust: self.containers[RESULT][0] = out.result;
}

    /// `AnvilMenu.setItemName` (`ServerboundRenameItemPacket`): false when
    /// the name is refused or unchanged.
    /// `BeaconMenu.updateEffects` (`ServerboundSetBeaconPacket`): with a
    /// payment, powers `BeaconBlockEntity.validateEffects` allows for the
    /// pyramid's levels (data 0) become data 1 and 2 and the payment is used.
    /// Each power is its `mob_effect` id and name. False when refused.
    // rust: pub fn beacon_update(
    // rust: &mut self,
    // rust: env: &Env,
    // rust: primary: Option<(i32, &str)>,
    // rust: secondary: Option<(i32, &str)>,
    // rust: ) -> bool {
    // rust: if self.kind != Kind::Beacon || self.containers[MAIN][0].is_none() {
    // rust: return false;
}
    // rust: let levels = self.data[0];
    // rust: let (p, s) = (
    // rust: beacon_required_levels(primary.map(|e| e.1)),
    // rust: beacon_required_levels(secondary.map(|e| e.1)),
    // rust: );
    // rust: let valid = !(secondary.is_some() && levels < 4)
    // rust: && p <= levels
    // rust: && s <= levels
    // rust: && p < 4
    // rust: && !(s != 0 && s < 4 && primary.map(|e| e.0) != secondary.map(|e| e.0));
    // rust: if !valid {
    // rust: return false;
}
    // rust: self.data[1] = primary.map_or(0, |e| e.0 + 1);
    // rust: self.data[2] = secondary.map_or(0, |e| e.0 + 1);
    // rust: self.remove(env, 0, 1);
    // rust: true
}

pub fn rename(self: *Self, env: *Env, name: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
        // StringUtil.filterText, then validateName's length limit.
    // rust: let name: String = name
    // rust: .chars()
    // rust: .filter(|&c| c != '\u{a7}' && c >= ' ' && c != '\u{7f}')
    // rust: .collect();
    // rust: if self.kind != Kind::Anvil
    // rust: || name.encode_utf16().count() > 50
    // rust: || self.anvil.name.as_deref() == Some(&name)
    // rust: {
    // rust: return false;
}
    // rust: if let Some(result) = self.containers[RESULT][0].as_mut() {
    // rust: result.data_mut().custom_name = (!name.trim().is_empty())
    // rust: .then(|| horizon_world::nbt::Tag::String(name.as_str().into()));
    // rust: result.tidy();
}
    // rust: self.anvil.name = Some(name);
    // rust: self.anvil_result(env);
    // rust: true
}

    /// `SmithingMenu.createResult`.
pub fn smith_result(self: *Self, env: *Env) void {
}
    // rust: let [a, b, c] = [0, 1, 2].map(|i| self.containers[MAIN][i].as_ref());
    // rust: self.containers[RESULT][0] = env
    // rust: .station_recipes
    // rust: .smithing_result(env.enchantments, a, b, c);
}

    /// `SmithingMenu.slotsChanged`'s `hasRecipeError`: every input filled and no result.
pub fn smith_error(self: *Self) void {
}
    // rust: let error = self.containers[MAIN].iter().all(Option::is_some)
    // rust: && self.containers[RESULT][0].is_none();
    // rust: self.data[0] = i32::from(error);
}

    /// `CartographyTableMenu.slotsChanged` and `setupResultSlot`: a result
    /// only where the level has the map (`access.execute`), with the post
    /// processing its take runs (`MAP_POST_PROCESSING`: 0 lock, 1 scale).
pub fn carto_changed(self: *Self, env: *Env) void {
}
    // rust: let [map, extra] = [0, 1].map(|i| self.containers[MAIN][i].clone());
    // rust: if self.containers[RESULT][0].is_some() && (map.is_none() || extra.is_none()) {
    // rust: self.containers[RESULT][0] = None;
    // rust: return;
}
    // rust: let (Some(map), Some(extra), Some(maps)) = (map, extra, env.maps) else {
    // rust: return;
}
    // rust: let Some((locked, scale)) = map
    // rust: .data()
    // rust: .and_then(|d| d.map_id)
    // rust: .and_then(|id| maps.state(id))
    // rust: else {
    // rust: return;
}
    // rust: let extendable = env
    // rust: .items
    // rust: .item_tags
    // rust: .get("minecraft:extendable_maps")
    // rust: .is_some_and(|t| t.contains(&*map.item));
    // rust: let copy = |count: u32, post: Option<u8>| {
    // rust: let mut out = ItemStack {
    // rust: count,
    // rust: ..map.clone()
}
    // rust: if post.is_some() {
    // rust: out.data_mut().map_post_processing = post;
}
    // rust: out
}
    // rust: self.containers[RESULT][0] = match &*extra.item {
    // rust: "minecraft:paper" if extendable && !locked && scale < 4 => Some(copy(1, Some(1))),
    // rust: "minecraft:glass_pane" if !locked => Some(copy(1, Some(0))),
    // rust: "minecraft:map" => Some(copy(2, None)),
    // rust: _ => None,
}
}

    /// `MapItem.onCraftedPostProcess`, shared by menu takes and system crafting:
    /// remove the directive and name the level's scaled or locked saved copy.
pub fn map_crafted(maps: ?*dyn Maps, stack: *mut ItemStack) void {
}
    // rust: if &*stack.item != "minecraft:filled_map" {
    // rust: return;
}
    // rust: let Some(post) = stack.data().and_then(|d| d.map_post_processing) else {
    // rust: return;
}
    // rust: stack.data_mut().map_post_processing = None;
    // rust: let id = stack.data().and_then(|d| d.map_id);
    // rust: if let (Some(maps), Some(id)) = (maps, id)
    // rust: && let Some(new) = maps.derive(id, post == 1)
    // rust: {
    // rust: stack.data_mut().map_id = Some(new);
}
    // rust: stack.tidy();
}

pub fn slot_count(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.slots.len()
}

pub fn slot(self: *Self, i: usize) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let s = self.slots[i];
    // rust: self.containers[s.container][s.index].as_ref()
}

    /// Sets a slot as a test fixture does (`Slot.set`).
pub fn set_slot(self: *Self, env: *Env, i: usize, stack: ?ItemStack) void {
}
    // rust: if self.kind == Kind::Lectern {
            // LecternBlockEntity.setBook: the book its slot can't set.
    // rust: self.containers[MAIN][0] = stack;
    // rust: return;
}
    // rust: self.put(env, i, stack);
}

pub fn player_item(self: *Self, i: usize) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.containers[PLAYER][i].as_ref()
}

pub fn set_player_item(self: *Self, i: usize, stack: ?ItemStack) void {
}
    // rust: self.containers[PLAYER][i] = stack;
}

    /// `Inventory.add`: the leftover stays in `stack`.
pub fn give(self: *Self, env: *Env, stack: *mut ItemStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.inventory_add(env, stack)
}

    /// `Inventory.contains(stack)`.
pub fn player_contains(self: *Self, stack: *ItemStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.containers[PLAYER]
    // rust: .iter()
    // rust: .flatten()
    // rust: .any(|have| have.same_item_same_components(stack))
}

    // ---- item helpers ----

pub fn max_stack(env: *Env, stack: *ItemStack) u {
    // Implementation ported from Horizon
    return undefined;
}
        // `ItemStack.getMaxStackSize`: the stack's component, else the item's.
        // A removed component falls back to the item (`!minecraft:max_stack_size`).
    // rust: let patched = stack.data().and_then(|d| {
    // rust: if d.other("!minecraft:max_stack_size").is_some() {
    // rust: return None;
}
    // rust: match d.other("minecraft:max_stack_size") {
    // rust: Some(horizon_world::nbt::Tag::Int(n)) if (1..=99).contains(n) => Some(*n as u32),
    // rust: _ => None,
}
    // rust: });
    // rust: patched.unwrap_or_else(|| env.items.get(&stack.item).map_or(64, |i| i.max_stack))
}

pub fn damageable(env: *Env, stack: *ItemStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: env.items.get(&stack.item).is_some_and(|i| i.max_damage > 0)
}

    /// `ItemStack.isStackable`.
pub fn stackable(env: *Env, stack: *ItemStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::max_stack(env, stack) > 1 && !(Self::damageable(env, stack) && stack.damage > 0)
}

pub fn is_bucket(stack: *ItemStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &*stack.item == "minecraft:bucket"
}

pub fn is_fuel(env: *Env, stack: *ItemStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: env.items.get(&stack.item).is_some_and(|i| i.fuel.is_some())
}

    // ---- Slot ----

pub fn may_place(self: *Self, env: *Env, s: usize, stack: *ItemStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.slots[s].role {
    // rust: Role::Plain | Role::CreativeDisplay => true,
    // rust: Role::Armor(eq) => env
    // rust: .items
    // rust: .get(&stack.item)
    // rust: .and_then(|i| {
    // rust: let slot = match i.equip_slot.as_deref()? {
    // rust: "feet" => 0,
    // rust: "legs" => 1,
    // rust: "chest" => 2,
    // rust: "head" => 3,
    // rust: _ => return None,
}
    // rust: let allowed = i
    // rust: .equip_allowed
    // rust: .as_ref()
    // rust: .is_none_or(|a| a.contains("minecraft:player"));
    // rust: Some(slot == eq && allowed)
    // rust: })
    // rust: .unwrap_or(false),
            // LivingEntity.isEquippableInSlot: the item's equippable slot,
            // and the mount among its allowed entities.
    // rust: Role::MountEquip(slot) => env.items.get(&stack.item).is_some_and(|i| {
    // rust: i.equip_slot.as_deref() == Some(slot)
    // rust: && self
    // rust: .mount
    // rust: .as_deref()
    // rust: .is_some_and(|m| i.equip_allowed.as_ref().is_none_or(|a| a.contains(m)))
    // rust: }),
    // rust: Role::Shulker => fits_inside_container_items(stack),
    // rust: Role::Mod | Role::ModResult => self.mod_slot(s, stack).0,
    // rust: Role::Hidden => false,
    // rust: Role::Fuel => Self::is_fuel(env, stack) || Self::is_bucket(stack),
    // rust: Role::Output | Role::CraftResult | Role::Inert => false,
    // rust: Role::CrafterIn => self.data.get(self.slots[s].index) != Some(&1),
    // rust: Role::Potion => {
    // rust: env.brewing.is_bottle(stack)
    // rust: || env
    // rust: .items
    // rust: .item_tags
    // rust: .get("minecraft:brewing_potion_inputs")
    // rust: .is_some_and(|m| m.contains(&*stack.item))
}
    // rust: Role::Ingredient => env.brewing.is_reagent(stack),
    // rust: Role::BrewFuel => env
    // rust: .items
    // rust: .get(&stack.item)
    // rust: .is_some_and(|i| i.brewing_fuel.is_some()),
    // rust: Role::LoomBanner => Self::is_banner(stack),
    // rust: Role::LoomDye => env.banners.loom_dye(env.items, stack).is_some(),
    // rust: Role::LoomPattern => env.banners.is_pattern_item(env.items, stack),
    // rust: Role::GrindInput => crate::stations::grindstone_accepts(env.items, stack),
    // rust: Role::SmithInput(i) => env.station_recipes.smithing_accepts(i, stack),
    // rust: Role::EnchantItem => true,
    // rust: Role::Lapis => &*stack.item == "minecraft:lapis_lazuli",
    // rust: Role::BeaconPay => env
    // rust: .items
    // rust: .item_tags
    // rust: .get("minecraft:beacon_payment_items")
    // rust: .is_some_and(|t| t.contains(&*stack.item)),
    // rust: Role::CartoMap => stack.data().is_some_and(|d| d.map_id.is_some()),
    // rust: Role::CartoExtra => Self::is_carto_extra(stack),
    // rust: Role::LoomResult
    // rust: | Role::MerchantResult
    // rust: | Role::StoneResult
    // rust: | Role::GrindResult
    // rust: | Role::CombineResult
    // rust: | Role::CartoResult => false,
}
}

    /// What the cartography table's second slot takes.
pub fn is_carto_extra(stack: *ItemStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(
    // rust: &*stack.item,
    // rust: "minecraft:paper" | "minecraft:map" | "minecraft:glass_pane"
    // rust: )
}

    /// `BannerItem`.
pub fn is_banner(stack: *ItemStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: stack.item.ends_with("_banner")
}

pub fn may_pickup(self: *Self, env: *Env, s: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.slots[s].role {
    // rust: Role::Inert | Role::Hidden => false,
            // AnvilMenu.mayPickup: the levels to pay, and a price.
    // rust: Role::CombineResult if self.kind == Kind::Anvil => {
    // rust: (self.creative || self.levels >= self.data[0]) && self.data[0] > 0
}
    // rust: Role::MerchantResult => self
    // rust: .merchant
    // rust: .as_ref()
    // rust: .and_then(|m| m.offers.get(m.active?))
    // rust: .is_some_and(|o| {
    // rust: let (a, b) = (
    // rust: self.containers[MAIN][0].as_ref(),
    // rust: self.containers[MAIN][1].as_ref(),
    // rust: );
    // rust: o.satisfied_by(env.items, a, b) || o.satisfied_by(env.items, b, a)
    // rust: }),
    // rust: Role::Armor(_) | Role::MountEquip(_) => match self.slot(s) {
    // rust: Some(stack) => {
    // rust: self.creative || stack.enchantment_level("minecraft:binding_curse") == 0
}
    // rust: None => true,
    // rust: },
    // rust: _ => true,
}
}

    /// A result slot (`FurnaceResultSlot`, `ResultSlot`): nothing goes in, and
    /// what's taken from it can't be put back.
pub fn is_result(self: *Self, s: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(self.slots[s].role, Role::Output | Role::CraftResult)
}

    /// Slot `s` takes one more item of `stack` (`Slot.mayPlace`, and room).
pub fn takes_one(self: *Self, env: *Env, s: usize, stack: *ItemStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.may_place(env, s, stack)
    // rust: && self.slot(s).is_none_or(|have| {
    // rust: have.same_item_same_components(stack) && have.count < self.slot_max(env, s, have)
    // rust: })
}

    /// The slots `quickMoveStack` would put slot `index`'s items in: one item
    /// of a plain slot, the whole of a result slot, partial stacks first. Empty
    /// when they don't all fit. This runs the move, so call it on a menu that
    /// is thrown away afterwards.
pub fn quick_move_landing(self: *Self, env: *Env, index: usize) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(mut stack) = self.slot(index).cloned() else {
    // rust: return Vec::new();
}
    // rust: if !self.is_result(index) {
    // rust: stack.count = 1;
    // rust: let slot = self.slots[index];
    // rust: self.containers[slot.container][slot.index] = Some(stack.clone());
}
    // rust: let before: Vec<Option<ItemStack>> = (0..self.slots.len())
    // rust: .map(|i| self.slot(i).cloned())
    // rust: .collect();
    // rust: self.quick_move(env, index);
    // rust: let (mut partial, mut empty) = (Vec::new(), Vec::new());
    // rust: let mut moved = 0;
    // rust: for i in (0..self.slots.len()).filter(|&i| i != index && !self.is_result(i)) {
    // rust: let had = before[i].as_ref().map_or(0, |b| b.count);
    // rust: let got = self
    // rust: .slot(i)
    // rust: .filter(|now| now.same_item_same_components(&stack))
    // rust: .map_or(0, |now| now.count.saturating_sub(had));
    // rust: if got > 0 {
    // rust: moved += got;
    // rust: if had > 0 {
    // rust: partial.push(i);
    // rust: } else {
    // rust: empty.push(i);
}
}
}
    // rust: if moved < stack.count {
    // rust: return Vec::new();
}
    // rust: partial.extend(empty);
    // rust: partial
}

    /// A mod menu type's slot `s`: whether it takes `stack` (`Slot.mayPlace`:
    /// anything but on a result) and how many it holds (`Slot.getMaxStackSize`),
    /// then as the mods' hook says.
pub fn mod_slot(self: *Self, s: usize, stack: *ItemStack) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Kind::Mod(t) = self.kind else {
    // rust: return (false, 0);
}
    // rust: let mut may_place = self.slots[s].role == Role::Mod;
    // rust: let mut max_stack = CONTAINER_MAX;
    // rust: let index = self.slots[s].index;
    // rust: native_menu_slot_rules(t.id, index, stack, &mut may_place, &mut max_stack);
    // rust: (may_place, max_stack.clamp(1, CONTAINER_MAX))
}

    /// `Slot.getMaxStackSize(stack)`.
pub fn slot_max(self: *Self, env: *Env, s: usize, stack: *ItemStack) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let own = match self.slots[s].role {
    // rust: Role::Armor(_)
    // rust: | Role::MountEquip(_)
    // rust: | Role::Potion
    // rust: | Role::EnchantItem
    // rust: | Role::BeaconPay => 1,
            // The lectern's bookAccess holds one.
    // rust: Role::Plain if self.kind == Kind::Lectern && self.slots[s].container == MAIN => 1,
    // rust: Role::Fuel if Self::is_bucket(stack) => return 1,
    // rust: Role::Mod | Role::ModResult => self.mod_slot(s, stack).1,
            // `Container.getMaxStackSize` is vanilla's 99, which no data pack's
            // item reaches; a native mod's item may, and its own size is the cap.
    // rust: _ => u32::MAX,
}
    // rust: own.min(Self::max_stack(env, stack))
}

    /// `Container.setItem` (a grid change recomputes the result).
pub fn put(self: *Self, env: *Env, s: usize, mut stack: ?ItemStack) void {
}
    // rust: tidy(&mut stack);
    // rust: let slot = self.slots[s];
        // LecternBlockEntity's bookAccess.setItem does nothing.
    // rust: if self.kind == Kind::Lectern && slot.container == MAIN {
    // rust: return;
}
        // SimpleContainer / BaseContainerBlockEntity.setItem: limitSize to
        // getMaxStackSize(stack). The loom's result is a SimpleContainer too.
    // rust: if (slot.container == MAIN || slot.role == Role::LoomResult)
    // rust: && let Some(st) = stack.as_mut()
    // rust: {
    // rust: st.count = st.count.min(Self::max_stack(env, st));
            // The beacon's container holds one item (getMaxStackSize 1).
    // rust: if self.kind == Kind::Beacon {
    // rust: st.count = st.count.min(1);
}
}
        // CrafterBlockEntity.setItem: filling a disabled (empty) slot enables it.
    // rust: if self.kind == Kind::CrafterBlock
    // rust: && slot.container == MAIN
    // rust: && self.data[slot.index] == 1
    // rust: && self.containers[MAIN][slot.index].is_none()
    // rust: {
    // rust: self.data[slot.index] = 0;
}
    // rust: self.containers[slot.container][slot.index] = stack;
    // rust: if slot.container == GRID {
    // rust: self.recompute(env);
}
    // rust: self.slot_changed(env, s);
}

    /// `Slot.setByPlayer(stack)`: the slot's item is the previous one.
pub fn set_by_player(self: *Self, env: *Env, s: usize, stack: ?ItemStack) void {
}
    // rust: let previous = self.slot(s).cloned();
    // rust: self.set_by_player_from(env, s, stack, previous.as_ref());
}

    /// `Slot.setByPlayer(stack, previous)`: `ArmorSlot` and the inventory
    /// menu's off-hand slot first call the owner's `onEquipItem`, which acts
    /// only when the item changes (`isSameItemSameComponents`).
    // rust: fn set_by_player_from(
    // rust: &mut self,
    // rust: env: &Env,
    // rust: s: usize,
    // rust: mut stack: Option<ItemStack>,
    // rust: previous: Option<&ItemStack>,
    // rust: ) {
    // rust: tidy(&mut stack);
    // rust: if let Some(slot) = self.equipment_slot(s) {
    // rust: let same = match (previous.filter(|p| p.count > 0), stack.as_ref()) {
    // rust: (None, None) => true,
    // rust: (Some(a), Some(b)) => a.same_item_same_components(b),
    // rust: _ => false,
}
    // rust: if !same {
    // rust: self.equipped.push((slot, stack.clone()));
}
}
    // rust: self.put(env, s, stack);
}

    /// The `EquipmentSlot` of an `ArmorSlot` or of `InventoryMenu`'s off-hand
    /// slot (the only menu slot over inventory slot 40).
pub fn equipment_slot(self: *Self, s: usize) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let slot = self.slots[s];
    // rust: match slot.role {
    // rust: Role::Armor(eq) => Some(["feet", "legs", "chest", "head"][eq]),
    // rust: _ if slot.container == PLAYER && slot.index == OFFHAND => Some("offhand"),
    // rust: _ => None,
}
}

    /// `Slot.remove`: the container's `removeItem`.
pub fn remove(self: *Self, env: *Env, s: usize, amount: u32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let slot = self.slots[s];
        // ResultContainer.removeItem takes the whole stack; the loom's result
        // is a SimpleContainer slot and splits.
    // rust: if slot.container == RESULT && slot.role != Role::LoomResult {
    // rust: return self.containers[RESULT][0].take();
}
    // rust: let cell = &mut self.containers[slot.container][slot.index];
    // rust: let out = cell
    // rust: .as_mut()
    // rust: .filter(|c| c.count > 0)
    // rust: .map(|c| split(c, amount));
    // rust: tidy(cell);
        // LecternBlockEntity: an emptied book slot is onBookItemRemove (page 0).
    // rust: if self.kind == Kind::Lectern && slot.container == MAIN && cell.is_none() {
    // rust: self.data[0] = 0;
}
    // rust: if out.is_some() && slot.container == GRID {
    // rust: self.recompute(env);
}
        // SimpleContainer.removeItem calls setChanged when it took something;
        // MerchantContainer.removeItem updates the result after a payment slot.
    // rust: if out.is_some()
    // rust: && matches!(
    // rust: self.kind,
    // rust: Kind::Loom
    // rust: | Kind::Merchant
    // rust: | Kind::Stonecutter
    // rust: | Kind::Grindstone
    // rust: | Kind::Anvil
    // rust: | Kind::Smithing
    // rust: | Kind::Enchanting
    // rust: | Kind::Cartography
    // rust: )
    // rust: {
    // rust: self.slot_changed(env, s);
}
    // rust: out
}

    /// The anvil menu as it is before a click that may take its result.
pub fn anvil_undo(self: *Self) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: AnvilUndo {
    // rust: inputs: self.containers[MAIN].clone(),
    // rust: result: self.containers[RESULT][0].clone(),
    // rust: cost: self.data[0],
    // rust: player: self.containers[PLAYER].clone(),
    // rust: carried: self.carried.clone(),
}
}

    /// Refuses a take that `anvil_hook` deferred (a cancelled
    /// `AnvilCraftEvent.Pre`): the result goes back in its slot and the
    /// inputs, cost, inventory and cursor are as `undo` held them, so nothing
    /// the click did (cursor, shift-click, swap, drop) is left.
pub fn anvil_cancel(self: *Self, undo: AnvilUndo) void {
}
    // rust: self.containers[MAIN] = undo.inputs;
    // rust: self.containers[RESULT][0] = undo.result;
    // rust: self.data[0] = undo.cost;
    // rust: self.containers[PLAYER] = undo.player;
    // rust: self.carried = undo.carried;
    // rust: self.anvil_craft = None;
    // rust: self.dropped.clear();
}

    /// `AnvilMenu.onTake`: the levels, the material used up, then the input.
pub fn anvil_take(self: *Self, env: *Env) void {
}
    // rust: let cost = self.data[0];
    // rust: if !self.creative {
            // Player.giveExperienceLevels(-cost).
    // rust: self.level_change -= cost;
    // rust: self.drops.push(format!(
    // rust: "levels{}{}",
    // rust: if cost <= 0 { "+" } else { "" },
    // rust: -cost
    // rust: ));
}
    // rust: let repair = self.anvil.repair_count;
    // rust: if repair > 0 {
    // rust: let addition = self.containers[MAIN][1]
    // rust: .clone()
    // rust: .filter(|a| a.count > repair)
    // rust: .map(|mut a| {
    // rust: a.count -= repair;
    // rust: a
    // rust: });
    // rust: self.put(env, 1, addition);
    // rust: } else if !self.anvil.only_renaming {
    // rust: self.put(env, 1, None);
}
    // rust: self.data[0] = 0;
    // rust: self.put(env, 0, None);
    // rust: self.combined = true;
}

    /// `CraftingMenu.slotChangedCraftingGrid`.
pub fn recompute(self: *Self, env: *Env) void {
}
    // rust: if self.grid_size == 0 {
    // rust: return;
}
    // rust: let result = env
    // rust: .recipes
    // rust: .find(&self.containers[GRID], self.grid_size)
    // rust: .and_then(|(id, stack)| {
    // rust: if env.limited_crafting {
                    // `RecipeCraftingHolder.setRecipeUsed`: special recipes or known recipes craft.
    // rust: let is_special = env.recipes.recipe(id).is_some_and(|r| r.is_special());
    // rust: let known = env.known_recipes.is_some_and(|book| book.knows(id));
    // rust: if !is_special && !known {
    // rust: return None;
}
}
    // rust: Some(stack)
    // rust: });
    // rust: self.containers[RESULT][0] = result;
}

    /// `ResultSlot.onTake` and the other `Slot.onTake` overrides.
pub fn on_take(self: *Self, env: *Env, s: usize, taken: *ItemStack) void {
}
    // rust: if self.slots[s].role == Role::Potion {
            // BrewingStandMenu.PotionSlot.onTake: a stack with potion contents.
    // rust: if matches!(
    // rust: &*taken.item,
    // rust: "minecraft:potion" | "minecraft:splash_potion" | "minecraft:lingering_potion"
    // rust: ) {
    // rust: self.brewed.push(taken.clone());
}
    // rust: return;
}
    // rust: if self.slots[s].role == Role::MerchantResult {
    // rust: self.merchant_take(env);
    // rust: return;
}
    // rust: if self.slots[s].role == Role::StoneResult {
            // StonecutterMenu's result onTake: awardUsedRecipes, one input
            // used up, the result again for the selected recipe.
    // rust: if let Some(r) = self.stone.used {
    // rust: self.crafted.push((
    // rust: env.station_recipes.stonecutting[r].id.clone(),
    // rust: vec![self.containers[MAIN][0].clone()],
    // rust: ));
}
    // rust: if self.remove(env, 0, 1).is_some() {
    // rust: self.stone_setup_result(env, self.data[0]);
}
    // rust: self.sounds.push("minecraft:ui.stonecutter.take_result");
    // rust: return;
}
    // rust: if self.slots[s].role == Role::GrindResult {
            // GrindstoneMenu's result onTake: the experience (from the inputs
            // before they go), then both inputs cleared.
    // rust: self.ground = Some(crate::stations::grindstone_xp_base(
    // rust: env.enchantments,
    // rust: self.containers[MAIN][0].as_ref(),
    // rust: self.containers[MAIN][1].as_ref(),
    // rust: ));
    // rust: self.put(env, 0, None);
    // rust: self.put(env, 1, None);
    // rust: return;
}
    // rust: if self.slots[s].role == Role::CombineResult && self.kind == Kind::Anvil {
    // rust: if self.anvil_hook {
    // rust: self.anvil_craft = Some(AnvilCraft {
    // rust: left: self.containers[MAIN][0].clone(),
    // rust: right: self.containers[MAIN][1].clone(),
    // rust: output: taken.clone(),
    // rust: });
    // rust: return;
}
    // rust: self.anvil_take(env);
    // rust: return;
}
    // rust: if self.slots[s].role == Role::CombineResult {
            // SmithingMenu.onTake: awardUsedRecipes, then one of each input.
    // rust: if self.kind == Kind::Smithing {
    // rust: let inputs = [0, 1, 2].map(|i| self.containers[MAIN][i].clone());
    // rust: if let Some((id, _)) = env.station_recipes.smithing_recipe(
    // rust: env.enchantments,
    // rust: inputs[0].as_ref(),
    // rust: inputs[1].as_ref(),
    // rust: inputs[2].as_ref(),
    // rust: ) {
    // rust: self.crafted.push((id.to_owned(), inputs.to_vec()));
}
}
    // rust: for i in 0..3 {
    // rust: if let Some(mut stack) = self.containers[MAIN][i].clone() {
    // rust: stack.count -= 1;
    // rust: self.put(env, i, Some(stack));
}
}
    // rust: self.combined = true;
    // rust: return;
}
    // rust: if self.slots[s].role == Role::CartoResult {
            // CartographyTableMenu's result onTake: one of each input, the
            // take sound, then Slot.onTake's setChanged. The taken stack's
            // onCraftedBy is the caller's (map_crafted).
    // rust: self.remove(env, 0, 1);
    // rust: self.remove(env, 1, 1);
    // rust: self.sounds
    // rust: .push("minecraft:ui.cartography_table.take_result");
    // rust: self.slot_changed(env, s);
    // rust: return;
}
    // rust: if self.slots[s].role == Role::LoomResult {
            // LoomMenu's result onTake: one banner and one dye are used up.
    // rust: self.remove(env, 0, 1);
    // rust: self.remove(env, 1, 1);
    // rust: if self.containers[MAIN][0].is_none() || self.containers[MAIN][1].is_none() {
    // rust: self.data[0] = -1;
}
    // rust: self.sounds.push("minecraft:ui.loom.take_result");
    // rust: return;
}
    // rust: if matches!(self.kind, Kind::CrafterBlock) && self.slots[s].container == MAIN {
            // Slot.onTake -> CrafterSlot.setChanged -> the result refresh.
    // rust: self.slot_changed(env, s);
    // rust: return;
}
    // rust: if self.slots[s].role != Role::CraftResult {
    // rust: return;
}
    // rust: let n = self.grid_size;
    // rust: let grid = self.containers[GRID].clone();
    // rust: if let Some((id, _)) = env.recipes.find(&grid, n) {
    // rust: self.crafted.push((format!("minecraft:{id}"), grid.clone()));
    // rust: self.item_crafted
    // rust: .push((format!("minecraft:{id}"), taken.clone()));
}
    // rust: let remaining = env
    // rust: .recipes
    // rust: .find(&grid, n)
    // rust: .map(|(id, _)| env.recipes.remainders(id, &grid, n))
    // rust: .unwrap_or_else(|| {
                // CraftingRecipe.defaultCraftingReminder
    // rust: grid.iter()
    // rust: .map(|cell| {
    // rust: cell.as_ref().and_then(|stack| {
    // rust: env.items
    // rust: .get(&stack.item)
    // rust: .and_then(|i| i.crafting_remainder.as_deref())
    // rust: .map(|r| ItemStack::new(r, 1))
    // rust: })
    // rust: })
    // rust: .collect()
    // rust: });
    // rust: for cell in 0..n * n {
    // rust: let mut here = self.containers[GRID][cell].take();
    // rust: if let Some(stack) = here.as_mut() {
    // rust: stack.count -= 1;
}
    // rust: tidy(&mut here);
    // rust: self.containers[GRID][cell] = here;
    // rust: if let Some(replacement) = remaining.get(cell).cloned().flatten() {
    // rust: match self.containers[GRID][cell].as_mut() {
    // rust: None => self.containers[GRID][cell] = Some(replacement),
    // rust: Some(have) if have.same_item_same_components(&replacement) => {
    // rust: let mut merged = replacement;
    // rust: merged.count += have.count;
    // rust: self.containers[GRID][cell] = Some(merged);
}
    // rust: Some(_) => {
    // rust: let mut left = replacement;
    // rust: if !self.inventory_add(env, &mut left) {
    // rust: self.drop_stack(&left);
}
}
}
}
}
    // rust: self.recompute(env);
}

pub fn drop_stack(self: *Self, stack: *ItemStack) void {
}
    // rust: if stack.count > 0 {
    // rust: self.drops.push(crate::item_data::canon_stack(Some(stack)));
    // rust: self.dropped.push(stack.clone());
}
}

    /// `Slot.tryRemove`.
    // rust: fn try_remove(
    // rust: &mut self,
    // rust: env: &Env,
    // rust: s: usize,
    // rust: amount: u32,
    // rust: max_amount: u32,
    // rust: ) -> Option<ItemStack> {
    // rust: if !self.may_pickup(env, s) {
    // rust: return None;
}
    // rust: if !self.allow_modification(env, s) && max_amount < self.slot(s).map_or(0, |c| c.count) {
    // rust: return None;
}
    // rust: let result = self.remove(env, s, amount.min(max_amount))?;
    // rust: if self.slot(s).is_none() {
    // rust: self.set_by_player_from(env, s, None, Some(&result));
}
    // rust: Some(result)
}

pub fn allow_modification(self: *Self, env: *Env, s: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.may_pickup(env, s)
    // rust: && match self.slot(s) {
    // rust: Some(stack) => self.may_place(env, s, stack),
    // rust: None => true,
}
}

    // rust: fn safe_take(
    // rust: &mut self,
    // rust: env: &Env,
    // rust: s: usize,
    // rust: amount: u32,
    // rust: max_amount: u32,
    // rust: ) -> Option<ItemStack> {
    // rust: let mut result = self.try_remove(env, s, amount, max_amount)?;
    // rust: self.on_take(env, s, &result);
    // rust: if self.slots[s].role == Role::CartoResult {
    // rust: Self::map_crafted(env.maps, &mut result);
}
    // rust: Some(result)
}

    /// `Slot.safeInsert`: puts up to `amount` of `input` into the slot.
pub fn safe_insert(self: *Self, env: *Env, s: usize, input: *mut ?ItemStack, amount: u32) void {
}
    // rust: let Some(stack) = input.as_mut() else { return };
    // rust: if !self.may_place(env, s, stack) {
    // rust: return;
}
    // rust: let have = self.slot(s).map_or(0, |c| c.count);
    // rust: let max = self.slot_max(env, s, stack);
    // rust: let transferable = amount.min(stack.count).min(max.saturating_sub(have));
    // rust: if transferable == 0 {
    // rust: return;
}
    // rust: match self.slot(s).cloned() {
    // rust: None => {
    // rust: let part = split(stack, transferable);
    // rust: self.set_by_player(env, s, Some(part));
}
    // rust: Some(mut current) if current.same_item_same_components(stack) => {
    // rust: stack.count -= transferable;
    // rust: current.count += transferable;
    // rust: self.set_by_player(env, s, Some(current));
}
    // rust: Some(_) => {}
}
    // rust: tidy(input);
}

    // ---- Inventory ----

    /// `Inventory.getSlotWithRemainingSpace` (selected slot 0, offhand, rest).
pub fn slot_with_space(self: *Self, env: *Env, stack: *ItemStack) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let inv = &self.containers[PLAYER];
    // rust: [self.selected, OFFHAND]
    // rust: .into_iter()
    // rust: .chain(0..36)
    // rust: .find(|&i| {
    // rust: inv[i].as_ref().is_some_and(|have| {
    // rust: have.same_item_same_components(stack)
    // rust: && Self::stackable(env, have)
    // rust: && have.count < Self::max_stack(env, have)
    // rust: })
    // rust: })
}

    /// `Inventory.addResource`: returns what did not fit.
pub fn add_resource(self: *Self, env: *Env, stack: *ItemStack) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let slot = self.slot_with_space(env, stack).or_else(|| {
    // rust: self.containers[PLAYER][..36]
    // rust: .iter()
    // rust: .position(Option::is_none)
    // rust: });
    // rust: let Some(slot) = slot else { return stack.count };
    // rust: let cell = self.containers[PLAYER][slot].get_or_insert_with(|| {
    // rust: let mut empty = stack.clone();
    // rust: empty.count = 0;
    // rust: empty
    // rust: });
    // rust: let room = Self::max_stack(env, cell).saturating_sub(cell.count);
    // rust: let add = stack.count.min(room);
    // rust: cell.count += add;
    // rust: tidy(&mut self.containers[PLAYER][slot]);
    // rust: stack.count - add
}

    /// `Inventory.add(stack)`: the leftover stays in `stack`.
pub fn inventory_add(self: *Self, env: *Env, stack: *mut ItemStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if stack.count == 0 {
    // rust: return false;
}
    // rust: if Self::damageable(env, stack) && stack.damage > 0 {
    // rust: if let Some(slot) = self.containers[PLAYER][..36]
    // rust: .iter()
    // rust: .position(Option::is_none)
    // rust: {
    // rust: self.containers[PLAYER][slot] = Some(stack.clone());
    // rust: stack.count = 0;
    // rust: return true;
}
    // rust: if self.creative {
    // rust: stack.count = 0;
    // rust: return true;
}
    // rust: return false;
}
    // rust: loop {
    // rust: let last = stack.count;
    // rust: stack.count = self.add_resource(env, stack);
    // rust: if stack.count == 0 || stack.count >= last {
    // rust: if stack.count == last && self.creative {
    // rust: stack.count = 0;
    // rust: return true;
}
    // rust: return stack.count < last;
}
}
}
}

/// `EquipmentSlot` of an item as the inventory menu's quick move sees it.
pub const Equip = enum {
    Armor(usize),
    Offhand,
    Other,
};

    // rust: impl Menu {
pub fn equip(env: *Env, stack: *ItemStack) E {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match env
    // rust: .items
    // rust: .get(&stack.item)
    // rust: .and_then(|i| i.equip_slot.as_deref())
    // rust: {
    // rust: Some("feet") => Equip::Armor(0),
    // rust: Some("legs") => Equip::Armor(1),
    // rust: Some("chest") => Equip::Armor(2),
    // rust: Some("head") => Equip::Armor(3),
    // rust: Some("offhand") => Equip::Offhand,
    // rust: _ => Equip::Other,
}
}

pub fn has_item(self: *Self, s: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.slot(s).is_some()
}

    /// `AbstractContainerMenu.moveItemStackTo`.
    // rust: fn move_to(
    // rust: &mut self,
    // rust: env: &Env,
    // rust: stack: &mut ItemStack,
    // rust: start: usize,
    // rust: end: usize,
    // rust: backwards: bool,
    // rust: ) -> bool {
    // rust: let mut changed = false;
    // rust: let order = |_: ()| -> Vec<usize> {
    // rust: if backwards {
    // rust: (start..end).rev().collect()
    // rust: } else {
    // rust: (start..end).collect()
}
}
    // rust: if Self::stackable(env, stack) {
    // rust: for dest in order(()) {
    // rust: if stack.count == 0 {
    // rust: break;
}
                // A mod menu's result (unless a mod's hook opens it) and a
                // hidden slot get no top-up either, as a furnace's quick move
                // never aims at its result.
    // rust: let refuses = match self.slots[dest].role {
    // rust: Role::Hidden => true,
    // rust: Role::ModResult => !self.mod_slot(dest, stack).0,
    // rust: _ => false,
}
    // rust: let max = match self.slot(dest) {
    // rust: Some(target) if !refuses && target.same_item_same_components(stack) => {
    // rust: self.slot_max(env, dest, target)
}
    // rust: _ => continue,
}
    // rust: let slot = self.slots[dest];
    // rust: let target = self.containers[slot.container][slot.index]
    // rust: .as_mut()
    // rust: .expect("checked");
    // rust: let total = target.count + stack.count;
    // rust: if total <= max {
    // rust: stack.count = 0;
    // rust: target.count = total;
    // rust: changed = true;
    // rust: self.slot_changed(env, dest);
    // rust: } else if target.count < max {
    // rust: stack.count -= max - target.count;
    // rust: target.count = max;
    // rust: changed = true;
    // rust: self.slot_changed(env, dest);
}
}
}
    // rust: if stack.count > 0 {
    // rust: for dest in order(()) {
    // rust: if !self.has_item(dest) && self.may_place(env, dest, stack) {
    // rust: let max = self.slot_max(env, dest, stack);
    // rust: let part = split(stack, stack.count.min(max));
    // rust: self.set_by_player(env, dest, Some(part));
    // rust: changed = true;
    // rust: break;
}
}
}
    // rust: changed
}

    /// `quickMoveStack` of the menu's kind; the moved stack's original copy
    /// (None when nothing moved).
pub fn quick_move(self: *Self, env: *Env, index: usize) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut stack = self.slot(index)?.clone();
    // rust: let clicked = stack.clone();
    // rust: let total = self.slots.len();
    // rust: let mut check_count = true;
    // rust: let mut after_take = false;
    // rust: match self.kind {
    // rust: Kind::ItemPicker => {
                // ItemPickerMenu.quickMoveStack: a hotbar stack is deleted.
    // rust: if index >= total - 9 {
    // rust: self.put(env, index, None);
}
    // rust: return None;
}
    // rust: Kind::Chest(rows) => {
    // rust: check_count = false;
    // rust: let n = rows * 9;
    // rust: if index < n {
    // rust: if !self.move_to(env, &mut stack, n, total, true) {
    // rust: return None;
}
    // rust: } else if !self.move_to(env, &mut stack, 0, n, false) {
    // rust: return None;
}
}
    // rust: Kind::Hopper => {
    // rust: check_count = false;
    // rust: if index < 5 {
    // rust: if !self.move_to(env, &mut stack, 5, 41, true) {
    // rust: return None;
}
    // rust: } else if !self.move_to(env, &mut stack, 0, 5, false) {
    // rust: return None;
}
}
            // ChestMenu.quickMoveStack over the mod's slots.
    // rust: Kind::Mod(t) => {
    // rust: check_count = false;
    // rust: let n = t.slots;
    // rust: if index < n {
    // rust: if !self.move_to(env, &mut stack, n, total, true) {
    // rust: return None;
}
    // rust: } else if !self.move_to(env, &mut stack, 0, n, false) {
    // rust: return None;
}
}
    // rust: Kind::Shulker => {
    // rust: check_count = false;
    // rust: if index < 27 {
    // rust: if !self.move_to(env, &mut stack, 27, total, true) {
    // rust: return None;
}
    // rust: } else if !self.move_to(env, &mut stack, 0, 27, false) {
    // rust: return None;
}
}
    // rust: Kind::Dispenser => {
    // rust: after_take = true;
    // rust: if index < 9 {
    // rust: if !self.move_to(env, &mut stack, 9, 45, true) {
    // rust: return None;
}
    // rust: } else if !self.move_to(env, &mut stack, 0, 9, false) {
    // rust: return None;
}
}
    // rust: Kind::Brewing => {
    // rust: after_take = true;
    // rust: let slot = self.slots[index];
    // rust: let commit = |m: &mut Self, stack: &ItemStack| {
    // rust: m.containers[slot.container][slot.index] =
    // rust: (stack.count > 0).then(|| stack.clone());
}
    // rust: if index <= 4 {
    // rust: if !self.move_to(env, &mut stack, 5, 41, true) {
    // rust: return None;
}
    // rust: } else if env
    // rust: .items
    // rust: .get(&clicked.item)
    // rust: .is_some_and(|i| i.brewing_fuel.is_some())
    // rust: {
    // rust: let moved = self.move_to(env, &mut stack, 4, 5, false);
    // rust: if moved
    // rust: || (env.brewing.is_reagent(&stack)
    // rust: && !self.move_to(env, &mut stack, 3, 4, false))
    // rust: {
    // rust: commit(self, &stack);
    // rust: return None;
}
    // rust: } else if env.brewing.is_reagent(&stack) {
    // rust: if !self.move_to(env, &mut stack, 3, 4, false) {
    // rust: return None;
}
    // rust: } else if env.brewing.is_bottle(&stack)
    // rust: || env
    // rust: .items
    // rust: .item_tags
    // rust: .get("minecraft:brewing_potion_inputs")
    // rust: .is_some_and(|m| m.contains(&*stack.item))
    // rust: {
    // rust: if !self.move_to(env, &mut stack, 0, 3, false) {
    // rust: return None;
}
    // rust: } else if (5..32).contains(&index) {
    // rust: if !self.move_to(env, &mut stack, 32, 41, false) {
    // rust: return None;
}
    // rust: } else if (32..41).contains(&index) {
    // rust: if !self.move_to(env, &mut stack, 5, 32, false) {
    // rust: return None;
}
    // rust: } else if !self.move_to(env, &mut stack, 5, 41, false) {
    // rust: return None;
}
}
    // rust: Kind::Loom => {
    // rust: after_take = true;
    // rust: if index == 3 {
    // rust: if !self.move_to(env, &mut stack, 4, 40, true) {
    // rust: return None;
}
    // rust: } else if index > 3 {
    // rust: let target = if Self::is_banner(&stack) {
    // rust: Some(0)
    // rust: } else if env.banners.loom_dye(env.items, &stack).is_some() {
    // rust: Some(1)
    // rust: } else if env.banners.is_pattern_item(env.items, &stack) {
    // rust: Some(2)
    // rust: } else {
    // rust: None
}
    // rust: match target {
    // rust: Some(t) => {
    // rust: if !self.move_to(env, &mut stack, t, t + 1, false) {
    // rust: return None;
}
}
    // rust: None if index < 31 => {
    // rust: if !self.move_to(env, &mut stack, 31, 40, false) {
    // rust: return None;
}
}
    // rust: None => {
    // rust: if index < 40 && !self.move_to(env, &mut stack, 4, 31, false) {
    // rust: return None;
}
}
}
    // rust: } else if !self.move_to(env, &mut stack, 4, 40, false) {
    // rust: return None;
}
}
    // rust: Kind::Stonecutter => {
    // rust: after_take = true;
    // rust: if index == 1 {
    // rust: if !self.move_to(env, &mut stack, 2, 38, true) {
    // rust: return None;
}
    // rust: } else if index == 0 {
    // rust: if !self.move_to(env, &mut stack, 2, 38, false) {
    // rust: return None;
}
    // rust: } else if env
    // rust: .station_recipes
    // rust: .stonecutting
    // rust: .iter()
    // rust: .any(|r| r.input.test(&stack))
    // rust: {
    // rust: if !self.move_to(env, &mut stack, 0, 1, false) {
    // rust: return None;
}
    // rust: } else if (2..29).contains(&index) {
    // rust: if !self.move_to(env, &mut stack, 29, 38, false) {
    // rust: return None;
}
    // rust: } else if (29..38).contains(&index) && !self.move_to(env, &mut stack, 2, 29, false)
    // rust: {
    // rust: return None;
}
}
    // rust: Kind::Grindstone => {
    // rust: after_take = true;
    // rust: let full = self.containers[MAIN].iter().all(Option::is_some);
    // rust: if index == 2 {
    // rust: if !self.move_to(env, &mut stack, 3, 39, true) {
    // rust: return None;
}
    // rust: } else if index == 0 || index == 1 {
    // rust: if !self.move_to(env, &mut stack, 3, 39, false) {
    // rust: return None;
}
    // rust: } else if full {
    // rust: if (3..30).contains(&index) {
    // rust: if !self.move_to(env, &mut stack, 30, 39, false) {
    // rust: return None;
}
    // rust: } else if (30..39).contains(&index)
    // rust: && !self.move_to(env, &mut stack, 3, 30, false)
    // rust: {
    // rust: return None;
}
    // rust: } else if !self.move_to(env, &mut stack, 0, 2, false) {
    // rust: return None;
}
}
    // rust: Kind::Cartography => {
    // rust: after_take = true;
    // rust: if index == 2 {
                    // onCraftedBy edits the result in its slot first.
    // rust: Self::map_crafted(env.maps, &mut stack);
    // rust: self.containers[RESULT][0] = Some(stack.clone());
    // rust: if !self.move_to(env, &mut stack, 3, 39, true) {
    // rust: return None;
}
    // rust: } else if index == 0 || index == 1 {
    // rust: if !self.move_to(env, &mut stack, 3, 39, false) {
    // rust: return None;
}
    // rust: } else if stack.data().is_some_and(|d| d.map_id.is_some()) {
    // rust: if !self.move_to(env, &mut stack, 0, 1, false) {
    // rust: return None;
}
    // rust: } else if Self::is_carto_extra(&stack) {
    // rust: if !self.move_to(env, &mut stack, 1, 2, false) {
    // rust: return None;
}
    // rust: } else if (3..30).contains(&index) {
    // rust: if !self.move_to(env, &mut stack, 30, 39, false) {
    // rust: return None;
}
    // rust: } else if (30..39).contains(&index) && !self.move_to(env, &mut stack, 3, 30, false)
    // rust: {
    // rust: return None;
}
}
            // LecternMenu.quickMoveStack moves nothing.
    // rust: Kind::Lectern => return None,
    // rust: Kind::Mount(columns) => {
                // AbstractMountInventoryMenu.quickMoveStack: no count check
                // and no onTake.
    // rust: check_count = false;
    // rust: let start = 2 + columns * 3;
    // rust: if index < start {
    // rust: if !self.move_to(env, &mut stack, start, total, true) {
    // rust: return None;
}
    // rust: } else if self.may_place(env, 1, &stack) && self.containers[MAIN][1].is_none() {
    // rust: if !self.move_to(env, &mut stack, 1, 2, false) {
    // rust: return None;
}
    // rust: } else if self.may_place(env, 0, &stack) && self.containers[MAIN][0].is_none() {
    // rust: if !self.move_to(env, &mut stack, 0, 1, false) {
    // rust: return None;
}
    // rust: } else if columns == 0 || !self.move_to(env, &mut stack, 2, start, false) {
                    // Between the inventory and the hotbar: the stack shrinks
                    // in its slot and EMPTY is returned either way.
    // rust: let (main_end, hotbar_end) = (start + 27, start + 36);
    // rust: if (main_end..hotbar_end).contains(&index) {
    // rust: self.move_to(env, &mut stack, start, main_end, false);
    // rust: } else if (start..main_end).contains(&index) {
    // rust: self.move_to(env, &mut stack, main_end, hotbar_end, false);
}
    // rust: let slot = self.slots[index];
    // rust: self.containers[slot.container][slot.index] =
    // rust: (stack.count > 0).then(|| stack.clone());
    // rust: return None;
}
}
    // rust: Kind::Beacon => {
                // BeaconMenu.quickMoveStack.
    // rust: after_take = true;
    // rust: if index == 0 {
    // rust: if !self.move_to(env, &mut stack, 1, 37, true) {
    // rust: return None;
}
    // rust: } else if self.containers[MAIN][0].is_none()
    // rust: && self.may_place(env, 0, &stack)
    // rust: && stack.count == 1
    // rust: {
    // rust: if !self.move_to(env, &mut stack, 0, 1, false) {
    // rust: return None;
}
    // rust: } else if (1..28).contains(&index) {
    // rust: if !self.move_to(env, &mut stack, 28, 37, false) {
    // rust: return None;
}
    // rust: } else if (28..37).contains(&index) {
    // rust: if !self.move_to(env, &mut stack, 1, 28, false) {
    // rust: return None;
}
    // rust: } else if !self.move_to(env, &mut stack, 1, 37, false) {
    // rust: return None;
}
}
    // rust: Kind::Enchanting => {
    // rust: after_take = true;
    // rust: if index < 2 {
    // rust: if !self.move_to(env, &mut stack, 2, 38, true) {
    // rust: return None;
}
    // rust: } else if &*stack.item == "minecraft:lapis_lazuli" {
    // rust: if !self.move_to(env, &mut stack, 1, 2, true) {
    // rust: return None;
}
    // rust: } else {
                    // One item into the empty item slot (setByPlayer).
    // rust: if self.containers[MAIN][0].is_some() {
    // rust: return None;
}
    // rust: let single = ItemStack {
    // rust: count: 1,
    // rust: ..stack.clone()
}
    // rust: stack.count -= 1;
                    // The source slot keeps the rest while the item slot changes.
    // rust: let slot = self.slots[index];
    // rust: self.containers[slot.container][slot.index] =
    // rust: (stack.count > 0).then(|| stack.clone());
    // rust: self.set_by_player(env, 0, Some(single));
}
}
    // rust: Kind::Anvil | Kind::Smithing => {
                // ItemCombinerMenu.quickMoveStack.
    // rust: after_take = true;
    // rust: let result = if self.kind == Kind::Anvil { 2 } else { 3 };
    // rust: let (start, use_row) = (result + 1, result + 28);
    // rust: let end = result + 37;
    // rust: let into_inputs = self.kind == Kind::Anvil
    // rust: || (0..3).any(|i| {
    // rust: self.containers[MAIN][i].is_none()
    // rust: && env.station_recipes.smithing_accepts(i, &stack)
    // rust: });
    // rust: if index == result {
    // rust: if !self.move_to(env, &mut stack, start, end, true) {
    // rust: return None;
}
    // rust: } else if index < result {
    // rust: if !self.move_to(env, &mut stack, start, end, false) {
    // rust: return None;
}
    // rust: } else if into_inputs && (start..end).contains(&index) {
    // rust: if !self.move_to(env, &mut stack, 0, result, false) {
    // rust: return None;
}
    // rust: } else if (start..use_row).contains(&index) {
    // rust: if !self.move_to(env, &mut stack, use_row, end, false) {
    // rust: return None;
}
    // rust: } else if (use_row..end).contains(&index)
    // rust: && !self.move_to(env, &mut stack, start, use_row, false)
    // rust: {
    // rust: return None;
}
}
    // rust: Kind::Merchant => {
    // rust: after_take = true;
    // rust: if index == 2 {
    // rust: if !self.move_to(env, &mut stack, 3, 39, true) {
    // rust: return None;
}
    // rust: if let Some(m) = self.merchant.as_mut() {
    // rust: m.events.push(crate::merchant::Event::TradeSound);
}
    // rust: } else if index != 0 && index != 1 {
    // rust: if (3..30).contains(&index) {
    // rust: if !self.move_to(env, &mut stack, 30, 39, false) {
    // rust: return None;
}
    // rust: } else if (30..39).contains(&index)
    // rust: && !self.move_to(env, &mut stack, 3, 30, false)
    // rust: {
    // rust: return None;
}
    // rust: } else if !self.move_to(env, &mut stack, 3, 39, false) {
    // rust: return None;
}
}
    // rust: Kind::Crafter | Kind::CrafterBlock => {
    // rust: after_take = true;
    // rust: if index < 9 {
    // rust: if !self.move_to(env, &mut stack, 9, 45, true) {
    // rust: return None;
}
    // rust: } else if !self.move_to(env, &mut stack, 0, 9, false) {
    // rust: return None;
}
}
    // rust: Kind::Furnace(recipe) => {
    // rust: after_take = true;
    // rust: if index == 2 {
    // rust: if !self.move_to(env, &mut stack, 3, 39, true) {
    // rust: return None;
}
    // rust: } else if index != 1 && index != 0 {
    // rust: let smelts = env
    // rust: .recipes
    // rust: .cook(&format!("minecraft:{recipe}"), &stack)
    // rust: .is_some();
    // rust: if smelts {
    // rust: if !self.move_to(env, &mut stack, 0, 1, false) {
    // rust: return None;
}
    // rust: } else if Self::is_fuel(env, &stack) {
    // rust: if !self.move_to(env, &mut stack, 1, 2, false) {
    // rust: return None;
}
    // rust: } else if (3..30).contains(&index) {
    // rust: if !self.move_to(env, &mut stack, 30, 39, false) {
    // rust: return None;
}
    // rust: } else if (30..39).contains(&index)
    // rust: && !self.move_to(env, &mut stack, 3, 30, false)
    // rust: {
    // rust: return None;
}
    // rust: } else if !self.move_to(env, &mut stack, 3, 39, false) {
    // rust: return None;
}
}
    // rust: Kind::Crafting => {
    // rust: after_take = true;
    // rust: if index == 0 {
    // rust: if !self.move_to(env, &mut stack, 10, 46, true) {
    // rust: return None;
}
    // rust: } else if (10..46).contains(&index) {
    // rust: if !self.move_to(env, &mut stack, 1, 10, false) {
    // rust: if index < 37 {
    // rust: if !self.move_to(env, &mut stack, 37, 46, false) {
    // rust: return None;
}
    // rust: } else if !self.move_to(env, &mut stack, 10, 37, false) {
    // rust: return None;
}
}
    // rust: } else if !self.move_to(env, &mut stack, 10, 46, false) {
    // rust: return None;
}
}
    // rust: Kind::Inventory => {
    // rust: after_take = true;
    // rust: let equip = Self::equip(env, &clicked);
    // rust: let armor_free = |m: &Self, eq: usize| !m.has_item(8 - eq);
    // rust: if index == 0 {
    // rust: if !self.move_to(env, &mut stack, 9, 45, true) {
    // rust: return None;
}
    // rust: } else if (1..9).contains(&index) {
    // rust: if !self.move_to(env, &mut stack, 9, 45, false) {
    // rust: return None;
}
    // rust: } else if matches!(equip, Equip::Armor(eq) if armor_free(self, eq)) {
    // rust: let Equip::Armor(eq) = equip else {
    // rust: unreachable!()
}
    // rust: let pos = 8 - eq;
    // rust: if !self.move_to(env, &mut stack, pos, pos + 1, false) {
    // rust: return None;
}
    // rust: } else if matches!(equip, Equip::Offhand) && !self.has_item(45) {
    // rust: if !self.move_to(env, &mut stack, 45, 46, false) {
    // rust: return None;
}
    // rust: } else if (9..36).contains(&index) {
    // rust: if !self.move_to(env, &mut stack, 36, 45, false) {
    // rust: return None;
}
    // rust: } else if (36..45).contains(&index) {
    // rust: if !self.move_to(env, &mut stack, 9, 36, false) {
    // rust: return None;
}
    // rust: } else if !self.move_to(env, &mut stack, 9, 45, false) {
    // rust: return None;
}
}
}
        // The stack was edited in place in its slot.
    // rust: let slot = self.slots[index];
    // rust: if stack.count == 0 {
    // rust: self.containers[slot.container][slot.index] = None;
            // InventoryMenu: setByPlayer(EMPTY, clicked).
    // rust: self.set_by_player_from(env, index, None, Some(&clicked));
    // rust: } else {
    // rust: self.containers[slot.container][slot.index] = Some(stack.clone());
    // rust: self.slot_changed(env, index);
}
    // rust: if check_count && stack.count == clicked.count {
    // rust: return None;
}
    // rust: if after_take || matches!(self.kind, Kind::Inventory | Kind::Crafting) {
    // rust: self.on_take(env, index, &clicked);
}
        // What the result slot's move left over is dropped.
    // rust: if (index == 0 && matches!(self.kind, Kind::Inventory | Kind::Crafting))
    // rust: || (index == 1 && self.kind == Kind::Stonecutter)
    // rust: {
    // rust: self.drop_stack(&stack);
}
    // rust: Some(clicked)
}

pub fn quick_replace(self: *Self, s: usize, stack: *ItemStack, env: *Env) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.slot(s) {
    // rust: None => true,
    // rust: Some(have) if have.same_item_same_components(stack) => {
    // rust: have.count <= Self::max_stack(env, stack)
}
    // rust: Some(_) => false,
}
}

    /// Whether a drag (quick craft) is in progress (`quickcraftStatus != 0`):
    /// the next click other than a quick craft only ends it.
pub fn quick_crafting(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.quick_status != 0
}

pub fn reset_quick_craft(self: *Self) void {
}
    // rust: self.quick_status = 0;
    // rust: self.quick_slots.clear();
}

    /// `AbstractContainerMenu.clicked`: Err carries a vanilla exception name.
    // rust: pub fn click(
    // rust: &mut self,
    // rust: env: &Env,
    // rust: slot_index: i32,
    // rust: button: i32,
    // rust: input: Input,
    // rust: ) -> Result<(), &'static str> {
    // rust: let size = self.slots.len() as i32;
    // rust: let in_range = |i: i32| (0..size).contains(&i);
    // rust: if input == Input::QuickCraft {
    // rust: let expected = self.quick_status;
    // rust: self.quick_status = button & 3;
    // rust: if ((expected != 1 || self.quick_status != 2) && expected != self.quick_status)
    // rust: || self.carried.is_none()
    // rust: {
    // rust: self.reset_quick_craft();
    // rust: } else if self.quick_status == 0 {
    // rust: self.quick_type = (button >> 2) & 3;
    // rust: if self.quick_type == 0
    // rust: || self.quick_type == 1
    // rust: || (self.quick_type == 2 && self.creative)
    // rust: {
    // rust: self.quick_status = 1;
    // rust: self.quick_slots.clear();
    // rust: } else {
    // rust: self.reset_quick_craft();
}
    // rust: } else if self.quick_status == 1 {
    // rust: if !in_range(slot_index) {
    // rust: return Err(OUT_OF_BOUNDS);
}
    // rust: let s = slot_index as usize;
    // rust: let carried = self.carried.clone().expect("checked");
    // rust: if self.quick_replace(s, &carried, env)
    // rust: && self.may_place(env, s, &carried)
    // rust: && (self.quick_type == 2 || carried.count as usize > self.quick_slots.len())
    // rust: && self.can_drag_to(s)
    // rust: && !self.quick_slots.contains(&s)
    // rust: {
    // rust: self.quick_slots.push(s);
}
    // rust: } else if self.quick_status == 2 {
    // rust: if !self.quick_slots.is_empty() {
    // rust: if self.quick_slots.len() == 1 {
    // rust: let s = self.quick_slots[0] as i32;
    // rust: let ty = self.quick_type;
    // rust: self.reset_quick_craft();
    // rust: return self.click(env, s, ty, Input::Pickup);
}
    // rust: let mut source = self.carried.clone().expect("checked");
    // rust: let mut remaining = source.count as i64;
    // rust: let carried = self.carried.clone().expect("checked");
    // rust: for s in self.quick_slots.clone() {
    // rust: if self.quick_replace(s, &carried, env)
    // rust: && self.may_place(env, s, &carried)
    // rust: && (self.quick_type == 2
    // rust: || carried.count as usize >= self.quick_slots.len())
    // rust: && self.can_drag_to(s)
    // rust: {
    // rust: let have = self.slot(s).map_or(0, |c| c.count);
    // rust: let max =
    // rust: Self::max_stack(env, &source).min(self.slot_max(env, s, &source));
    // rust: let each = match self.quick_type {
    // rust: 0 => (source.count as f32 / self.quick_slots.len() as f32).floor()
    // rust: as u32,
    // rust: 1 => 1,
    // rust: 2 => Self::max_stack(env, &source),
    // rust: _ => source.count,
}
    // rust: let new_count = (each + have).min(max);
    // rust: remaining -= i64::from(new_count) - i64::from(have);
    // rust: let mut placed = source.clone();
    // rust: placed.count = new_count;
    // rust: self.set_by_player(env, s, Some(placed));
}
}
    // rust: source.count = remaining.max(0) as u32;
    // rust: self.carried = Some(source);
    // rust: tidy(&mut self.carried);
}
    // rust: self.reset_quick_craft();
    // rust: } else {
    // rust: self.reset_quick_craft();
}
    // rust: return Ok(());
}
    // rust: if self.quick_status != 0 {
    // rust: self.reset_quick_craft();
    // rust: return Ok(());
}
        // A slot the mod's screen leaves out takes no click.
    // rust: if in_range(slot_index) && self.slots[slot_index as usize].role == Role::Hidden {
    // rust: return Ok(());
}
    // rust: if matches!(input, Input::Pickup | Input::QuickMove) && (button == 0 || button == 1) {
    // rust: let primary = button == 0;
    // rust: if slot_index == -999 {
    // rust: if let Some(carried) = self.carried.as_mut() {
    // rust: if primary {
    // rust: let dropped = self.carried.take().expect("some");
    // rust: self.drop_stack(&dropped);
    // rust: } else {
    // rust: let one = split(carried, 1);
    // rust: self.drop_stack(&one);
    // rust: tidy(&mut self.carried);
}
}
    // rust: } else if input == Input::QuickMove {
    // rust: if slot_index < 0 {
    // rust: return Ok(());
}
    // rust: if !in_range(slot_index) {
    // rust: return Err(OUT_OF_BOUNDS);
}
    // rust: let s = slot_index as usize;
    // rust: if !self.may_pickup(env, s) {
    // rust: return Ok(());
}
    // rust: let mut clicked = self.quick_move(env, s);
    // rust: while let Some(c) = &clicked {
    // rust: if !self.slot(s).is_some_and(|now| same_item(now, c)) {
    // rust: break;
}
    // rust: clicked = self.quick_move(env, s);
}
    // rust: } else {
    // rust: if slot_index < 0 {
    // rust: return Ok(());
}
    // rust: if !in_range(slot_index) {
    // rust: return Err(OUT_OF_BOUNDS);
}
    // rust: self.pickup(env, slot_index as usize, primary);
}
    // rust: } else if input == Input::Swap && ((0..9).contains(&button) || button == 40) {
    // rust: if !in_range(slot_index) {
    // rust: return Err(OUT_OF_BOUNDS);
}
    // rust: self.swap(env, slot_index as usize, button as usize);
    // rust: } else if input == Input::Clone
    // rust: && self.creative
    // rust: && self.carried.is_none()
    // rust: && slot_index >= 0
    // rust: {
    // rust: if !in_range(slot_index) {
    // rust: return Err(OUT_OF_BOUNDS);
}
    // rust: if let Some(stack) = self.slot(slot_index as usize) {
    // rust: let mut copy = stack.clone();
    // rust: copy.count = Self::max_stack(env, stack);
                // The cartography result's safeClone runs onCraftedBy.
    // rust: if self.slots[slot_index as usize].role == Role::CartoResult {
    // rust: Self::map_crafted(env.maps, &mut copy);
}
    // rust: self.carried = Some(copy);
}
    // rust: } else if input == Input::Throw && self.carried.is_none() && slot_index >= 0 {
    // rust: if !in_range(slot_index) {
    // rust: return Err(OUT_OF_BOUNDS);
}
    // rust: let s = slot_index as usize;
    // rust: let amount = if button == 0 {
    // rust: 1
    // rust: } else {
    // rust: self.slot(s).map_or(0, |c| c.count)
}
    // rust: let mut taken = self.safe_take(env, s, amount, u32::MAX);
    // rust: if let Some(t) = &taken {
    // rust: self.drop_stack(t);
}
    // rust: if button == 1 {
    // rust: while let Some(t) = &taken {
    // rust: if !self.slot(s).is_some_and(|now| same_item(now, t)) {
    // rust: break;
}
    // rust: taken = self.safe_take(env, s, amount, u32::MAX);
    // rust: if let Some(t) = &taken {
    // rust: self.drop_stack(t);
}
}
}
    // rust: } else if input == Input::PickupAll && slot_index >= 0 {
    // rust: if !in_range(slot_index) {
    // rust: return Err(OUT_OF_BOUNDS);
}
    // rust: self.pickup_all(env, slot_index as usize, button);
}
    // rust: Ok(())
}

    /// The PICKUP branch of `doClick`: a bundle's override, else the
    /// plain click, ending with `slot.setChanged()`.
pub fn pickup(self: *Self, env: *Env, s: usize, primary: bool) void {
}
    // rust: if !self.bundle_click(env, s, primary) {
    // rust: self.pickup_inner(env, s, primary);
}
    // rust: self.slot_changed(env, s);
}

pub fn pickup_inner(self: *Self, env: *Env, s: usize, primary: bool) void {
}
    // rust: let clicked = self.slot(s).cloned();
    // rust: match clicked {
    // rust: None => {
    // rust: if let Some(mut carried) = self.carried.take() {
    // rust: let amount = if primary { carried.count } else { 1 };
    // rust: let mut input = Some(carried.clone());
    // rust: self.safe_insert(env, s, &mut input, amount);
    // rust: carried = input.unwrap_or_else(|| {
    // rust: let mut e = carried.clone();
    // rust: e.count = 0;
    // rust: e
    // rust: });
    // rust: self.carried = Some(carried);
    // rust: tidy(&mut self.carried);
}
}
    // rust: Some(clicked) if self.may_pickup(env, s) => match self.carried.take() {
    // rust: None => {
    // rust: let amount = if primary {
    // rust: clicked.count
    // rust: } else {
    // rust: clicked.count.div_ceil(2)
}
    // rust: if let Some(mut taken) = self.try_remove(env, s, amount, u32::MAX) {
    // rust: self.carried = Some(taken.clone());
    // rust: self.on_take(env, s, &taken);
    // rust: if self.slots[s].role == Role::CartoResult {
                            // onTake's onCraftedBy edits the carried stack.
    // rust: Self::map_crafted(env.maps, &mut taken);
    // rust: self.carried = Some(taken);
}
}
}
    // rust: Some(mut carried) => {
    // rust: if self.may_place(env, s, &carried) {
    // rust: if clicked.same_item_same_components(&carried) {
    // rust: let amount = if primary { carried.count } else { 1 };
    // rust: let mut input = Some(carried.clone());
    // rust: self.safe_insert(env, s, &mut input, amount);
    // rust: carried = input.unwrap_or_else(|| {
    // rust: let mut e = carried.clone();
    // rust: e.count = 0;
    // rust: e
    // rust: });
    // rust: self.carried = Some(carried);
    // rust: tidy(&mut self.carried);
    // rust: } else if carried.count <= self.slot_max(env, s, &carried) {
    // rust: self.carried = Some(clicked);
    // rust: self.set_by_player(env, s, Some(carried));
    // rust: } else {
    // rust: self.carried = Some(carried);
}
    // rust: } else if clicked.same_item_same_components(&carried) {
    // rust: let room = Self::max_stack(env, &carried).saturating_sub(carried.count);
    // rust: self.carried = Some(carried.clone());
    // rust: if let Some(mut taken) = self.try_remove(env, s, clicked.count, room) {
    // rust: if let Some(c) = self.carried.as_mut() {
    // rust: c.count += taken.count;
}
    // rust: self.on_take(env, s, &taken);
    // rust: if self.slots[s].role == Role::CartoResult {
                                // onCraftedBy edits the taken stack, not the carried one.
    // rust: Self::map_crafted(env.maps, &mut taken);
}
}
    // rust: } else {
    // rust: self.carried = Some(carried);
}
}
    // rust: },
    // rust: Some(_) => {}
}
}

    /// The SWAP branch of `doClick`.
pub fn swap(self: *Self, env: *Env, target: usize, button: usize) void {
}
    // rust: let inv_slot = button;
    // rust: let source = self.containers[PLAYER][inv_slot].clone();
    // rust: let target_stack = self.slot(target).cloned();
    // rust: if source.is_none() && target_stack.is_none() {
    // rust: return;
}
    // rust: match (source, target_stack) {
    // rust: (None, Some(taken)) => {
    // rust: if self.may_pickup(env, target) {
    // rust: self.containers[PLAYER][inv_slot] = Some(taken.clone());
    // rust: self.set_by_player(env, target, None);
    // rust: self.on_take(env, target, &taken);
    // rust: if self.slots[target].role == Role::CartoResult
    // rust: && let Some(stack) = self.containers[PLAYER][inv_slot].as_mut()
    // rust: {
    // rust: Self::map_crafted(env.maps, stack);
}
}
}
    // rust: (Some(mut source), None) => {
    // rust: if self.may_place(env, target, &source) {
    // rust: let max = self.slot_max(env, target, &source);
    // rust: if source.count > max {
    // rust: let part = split(&mut source, max);
    // rust: self.containers[PLAYER][inv_slot] = Some(source);
    // rust: self.set_by_player(env, target, Some(part));
    // rust: } else {
    // rust: self.containers[PLAYER][inv_slot] = None;
    // rust: self.set_by_player(env, target, Some(source));
}
}
}
    // rust: (Some(mut source), Some(mut taken)) => {
    // rust: if self.may_pickup(env, target) && self.may_place(env, target, &source) {
    // rust: let max = self.slot_max(env, target, &source);
    // rust: if source.count > max {
    // rust: let part = split(&mut source, max);
    // rust: self.containers[PLAYER][inv_slot] = Some(source);
    // rust: self.set_by_player(env, target, Some(part));
    // rust: self.on_take(env, target, &taken);
    // rust: if !self.inventory_add(env, &mut taken) {
    // rust: self.drop_stack(&taken);
}
    // rust: } else {
    // rust: self.containers[PLAYER][inv_slot] = Some(taken.clone());
    // rust: self.set_by_player(env, target, Some(source));
    // rust: self.on_take(env, target, &taken);
}
}
}
    // rust: (None, None) => {}
}
}

    /// The PICKUP_ALL branch (double click).
    /// `canTakeItemForPickAll`: never the result slots of the menus that
    /// override it (crafting, smithing, stonecutter, cartography), MerchantMenu's
    /// or an item tab's display slots.
pub fn can_take_for_pick_all(self: *Self, t: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.kind != Kind::Merchant
    // rust: && self.slots[t].role != Role::CreativeDisplay
    // rust: && (self.slots[t].container != RESULT
    // rust: || matches!(self.kind, Kind::Loom | Kind::Grindstone | Kind::Anvil))
}

    /// `AbstractContainerScreen.mouseReleased` on a Shift double click:
    /// QUICK_MOVE on every slot of `clicked`'s container that holds
    /// `moved`'s item (`lastQuickMoved`, the stack the first click moved).
    // rust: pub fn quick_move_all(
    // rust: &mut self,
    // rust: env: &Env,
    // rust: clicked: usize,
    // rust: moved: &ItemStack,
    // rust: ) -> Result<(), &'static str> {
    // rust: self.quick_move_all_each(env, clicked, moved, &mut |_, _| {})
}

    /// `quick_move_all`, calling `each` with the menu and the slot after each
    /// QUICK_MOVE (a server's client sends every one of them).
    // rust: pub fn quick_move_all_each(
    // rust: &mut self,
    // rust: env: &Env,
    // rust: clicked: usize,
    // rust: moved: &ItemStack,
    // rust: each: &mut dyn FnMut(&Self, usize),
    // rust: ) -> Result<(), &'static str> {
    // rust: if clicked >= self.slots.len() || !self.can_take_for_pick_all(clicked) {
    // rust: return Ok(());
}
    // rust: let container = self.slots[clicked].container;
    // rust: for t in 0..self.slots.len() {
    // rust: if self.may_pickup(env, t)
    // rust: && self.has_item(t)
    // rust: && self.slots[t].container == container
    // rust: && self.quick_replace(t, moved, env)
    // rust: {
    // rust: self.click(env, t as i32, 0, Input::QuickMove)?;
    // rust: each(self, t);
}
}
    // rust: Ok(())
}

    /// `AbstractContainerScreen.shouldAddSlotToQuickCraft`: whether a drag
    /// of type `ty` over `dragged` slots so far takes slot `s` too.
pub fn quick_craft_accepts(self: *Self, env: *Env, s: usize, ty: i32, dragged: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(carried) = self.carried.as_ref() else {
    // rust: return false;
}
    // rust: s < self.slots.len()
    // rust: && (carried.count as usize > dragged || ty == 2)
    // rust: && self.quick_replace(s, carried, env)
    // rust: && self.may_place(env, s, carried)
    // rust: && self.can_drag_to(s)
}

    /// What a quick craft drag of type `ty` over `slots` shows
    /// (`AbstractContainerScreen.extractSlot` and
    /// `recalculateQuickCraftRemaining`): each slot's would-be count and
    /// whether the slot caps it (a yellow count), then the count left in
    /// hand. Nothing while the drag spans a single slot.
    // rust: pub fn quick_craft_preview(
    // rust: &self,
    // rust: env: &Env,
    // rust: ty: i32,
    // rust: slots: &[usize],
    // rust: ) -> Option<(Vec<Option<(u32, bool)>>, u32)> {
    // rust: let carried = self.carried.as_ref()?;
    // rust: if slots.len() < 2 {
    // rust: return None;
}
    // rust: let carried_max = Self::max_stack(env, carried);
        // AbstractContainerMenu.getQuickCraftPlaceCount.
    // rust: let place = match ty {
    // rust: 0 => carried.count / slots.len() as u32,
    // rust: 1 => 1,
    // rust: 2 => carried_max,
    // rust: _ => carried.count,
}
    // rust: let mut left = i64::from(if ty == 2 { carried_max } else { carried.count });
    // rust: let mut shown = Vec::with_capacity(slots.len());
    // rust: for &s in slots {
    // rust: let carry = self.slot(s).map_or(0, |i| i.count);
    // rust: let max = carried_max.min(self.slot_max(env, s, carried));
    // rust: if ty != 2 {
    // rust: left -= i64::from((place + carry).min(max)) - i64::from(carry);
}
    // rust: shown.push(
    // rust: (s < self.slots.len()
    // rust: && self.quick_replace(s, carried, env)
    // rust: && self.can_drag_to(s))
    // rust: .then(|| ((place + carry).min(max), place + carry > max)),
    // rust: );
}
    // rust: Some((shown, left.max(0) as u32))
}

    /// `canDragTo`: ItemPickerMenu keeps drags off its display slots.
pub fn can_drag_to(self: *Self, s: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.slots[s].role != Role::CreativeDisplay
}

pub fn pickup_all(self: *Self, env: *Env, s: usize, button: i32) void {
}
    // rust: let Some(carried) = self.carried.clone() else {
    // rust: return;
}
    // rust: if self.has_item(s) && self.may_pickup(env, s) {
    // rust: return;
}
    // rust: let total = self.slots.len() as i32;
    // rust: let (start, step) = if button == 0 { (0, 1) } else { (total - 1, -1) };
    // rust: let carried_max = Self::max_stack(env, &carried);
    // rust: for pass in 0..2 {
    // rust: let mut i = start;
    // rust: while i >= 0 && i < total && self.carried.as_ref().map_or(0, |c| c.count) < carried_max
    // rust: {
    // rust: let t = i as usize;
    // rust: i += step;
    // rust: let have = self.carried.clone().expect("some");
    // rust: if self.has_item(t)
    // rust: && self.quick_replace(t, &have, env)
    // rust: && self.may_pickup(env, t)
    // rust: && self.can_take_for_pick_all(t)
    // rust: {
    // rust: let item = self.slot(t).expect("has item").clone();
    // rust: if pass != 0 || item.count != Self::max_stack(env, &item) {
    // rust: let room = carried_max - have.count;
    // rust: if let Some(removed) = self.safe_take(env, t, item.count, room)
    // rust: && let Some(c) = self.carried.as_mut()
    // rust: {
    // rust: c.count += removed.count;
}
}
}
}
}
}
}

/// `MerchantMenu` and `MerchantContainer` over the menu's `merchant` session.
    // rust: impl Menu {
    /// `MerchantContainer.updateSellItem`.
pub fn merchant_update(self: *Self, env: *Env) void {
}
    // rust: let Some(m) = self.merchant.as_mut() else {
    // rust: return;
}
    // rust: let (a, b) = (
    // rust: self.containers[MAIN][0].as_ref(),
    // rust: self.containers[MAIN][1].as_ref(),
    // rust: );
    // rust: let (a, b) = if a.is_none() { (b, None) } else { (a, b) };
    // rust: m.active = None;
    // rust: if a.is_none() {
    // rust: self.containers[RESULT][0] = None;
    // rust: m.future_xp = 0;
    // rust: return;
}
    // rust: if !m.offers.is_empty() {
    // rust: let (active, result) =
    // rust: crate::merchant::sell_item(&m.offers, env.items, a, b, Some(m.selection_hint));
    // rust: m.active = active;
    // rust: m.future_xp = if result.is_some() {
    // rust: active.map_or(0, |i| m.offers[i].xp)
    // rust: } else {
    // rust: 0
}
    // rust: self.containers[RESULT][0] = result;
}
    // rust: let has = self.containers[RESULT][0].is_some();
    // rust: m.notify_trade_updated(has);
}
    /// `MerchantResultSlot.onTake`: the payment is taken and the merchant
    /// told (`notifyTrade`).
pub fn merchant_take(self: *Self, env: *Env) void {
}
    // rust: let Some(m) = self.merchant.as_mut() else {
    // rust: return;
}
    // rust: let Some(i) = m.active else { return };
    // rust: let Some(offer) = m.offers.get(i).cloned() else {
    // rust: return;
}
    // rust: let (mut a, mut b) = (
    // rust: self.containers[MAIN][0].take(),
    // rust: self.containers[MAIN][1].take(),
    // rust: );
    // rust: let took = offer.take(env.items, &mut a, &mut b) || offer.take(env.items, &mut b, &mut a);
        // The payment stacks shrink in place, before the merchant hears of it.
    // rust: self.containers[MAIN][0] = a;
    // rust: self.containers[MAIN][1] = b;
    // rust: if took {
    // rust: let prices = m.notify_trade(i, env.trade, env.items);
    // rust: if prices {
    // rust: self.merchant_update(env);
}
            // setItem(0, buyA), setItem(1, buyB).
    // rust: self.merchant_update(env);
    // rust: self.merchant_update(env);
}
}
    /// `MerchantMenu.tryMoveItems` (the select trade packet, with the
    /// selection hint set first).
pub fn merchant_select(self: *Self, env: *Env, index: usize) void {
}
    // rust: let Some(m) = self.merchant.as_mut() else {
    // rust: return;
}
        // MerchantContainer.setSelectionHint updates the result.
    // rust: m.selection_hint = index;
    // rust: let count = m.offers.len();
    // rust: self.merchant_update(env);
    // rust: if index >= count {
    // rust: return;
}
    // rust: for slot in [0usize, 1] {
    // rust: if let Some(mut old) = self.containers[MAIN][slot].clone() {
    // rust: if !self.move_to(env, &mut old, 3, 39, true) {
    // rust: return;
}
    // rust: self.containers[MAIN][slot] = (old.count > 0).then_some(old);
    // rust: self.put(env, slot, self.containers[MAIN][slot].clone());
}
}
    // rust: if self.containers[MAIN][0].is_some() || self.containers[MAIN][1].is_some() {
    // rust: return;
}
    // rust: let Some(offer) = self
    // rust: .merchant
    // rust: .as_ref()
    // rust: .and_then(|m| m.offers.get(index))
    // rust: .cloned()
    // rust: else {
    // rust: return;
}
    // rust: self.merchant_fill(env, 0, &offer.base_cost_a);
    // rust: if let Some(b) = &offer.cost_b {
    // rust: self.merchant_fill(env, 1, b);
}
}
    /// `MerchantMenu.moveFromInventoryToPaymentSlot`.
pub fn merchant_fill(self: *Self, env: *Env, payment: usize, cost: *crate::merchant::ItemCost) void {
}
    // rust: for i in 3..39 {
    // rust: let Some(have) = self.slot(i).cloned() else {
    // rust: continue;
}
    // rust: if !cost.test(&have) {
    // rust: continue;
}
    // rust: let current = self.containers[MAIN][payment].clone();
    // rust: if current
    // rust: .as_ref()
    // rust: .is_some_and(|c| !c.same_item_same_components(&have))
    // rust: {
    // rust: continue;
}
    // rust: let max = Self::max_stack(env, &have);
    // rust: let current_count = current.as_ref().map_or(0, |c| c.count);
    // rust: let moved = max.saturating_sub(current_count).min(have.count);
    // rust: let payment_stack = ItemStack {
    // rust: count: current_count + moved,
    // rust: ..have.clone()
}
    // rust: let slot = self.slots[i];
    // rust: let mut left = have;
    // rust: left.count -= moved;
    // rust: self.containers[slot.container][slot.index] = (left.count > 0).then_some(left);
    // rust: self.put(env, payment, Some(payment_stack.clone()));
    // rust: if payment_stack.count >= max {
    // rust: break;
}
}
}
    /// `MerchantMenu.removed` for a living player: the payment goes back to
    /// the inventory (`placeItemBackInInventory`), or is dropped.
pub fn merchant_close(self: *Self, env: *Env) void {
}
        // AbstractContainerMenu.removed: the carried stack first.
    // rust: if let Some(mut carried) = self.carried.take() {
    // rust: self.place_back(env, &mut carried);
}
    // rust: for slot in [0usize, 1] {
    // rust: if let Some(mut stack) = self.containers[MAIN][slot].take() {
    // rust: self.place_back(env, &mut stack);
}
}
}
}

    // rust: pub(crate) mod tests {
//     use super::*;
//     use crate::{banner::Banners, brewing::Brewing, crafting::Recipes};
//     use horizon_world::loot::PackOverlay;

pub fn stack(item: []const u8, count: u32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(ItemStack {
    // rust: item: format!("minecraft:{item}").into(),
    // rust: count,
    // rust: damage: 0,
    // rust: extra: None,
    // rust: })
}

    /// An item tab's ItemPickerMenu: the 45 display slots show `shown`.
pub fn with_picker(shown: []const u8, test: impl FnOnce(*Env) void {
}
    // rust: with_menu(Kind::ItemPicker, |env, menu| {
    // rust: assert_eq!(menu.slot_count(), 54);
    // rust: for i in 0..45 {
    // rust: menu.set_slot(env, i, stack(shown, 1));
}
    // rust: test(env, menu);
    // rust: });
}

    /// A menu over the game's data (`.local/horizon-client`); skipped without it.
    // rust: pub(crate) fn with_menu(kind: Kind, test: impl FnOnce(&Env, &mut Menu)) {
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("items.json").exists() {
    // rust: return;
}
    // rust: let items = Items::catalog(&root, &PackOverlay::NONE).unwrap();
    // rust: let recipes = Recipes::load(&root, &items, &PackOverlay::NONE).unwrap();
    // rust: let brewing = Brewing::load(&root, &items, &PackOverlay::NONE);
    // rust: let banners = Banners::load(&root);
    // rust: let station_recipes =
    // rust: crate::stations::StationRecipes::load(&root, &items, &PackOverlay::NONE);
    // rust: let enchantments = crate::enchant::Enchantments::default();
    // rust: let names = crate::creative::Names::default();
    // rust: let env = Env {
    // rust: items: &items,
    // rust: recipes: &recipes,
    // rust: brewing: &brewing,
    // rust: banners: &banners,
    // rust: station_recipes: &station_recipes,
    // rust: enchantments: &enchantments,
    // rust: names: &names,
    // rust: trade: None,
    // rust: maps: None,
    // rust: limited_crafting: false,
    // rust: known_recipes: None,
}
    // rust: let mut menu = Menu::new(kind);
    // rust: menu.creative = true;
    // rust: test(&env, &mut menu);
}

    /// The Mouse Tweaks wheel's targets: vanilla's routing of one item.
pub fn quick_move_landing_routes_a_furnace_like_vanilla() void {
}
    // rust: with_menu(Kind::Furnace("smelting"), |env, menu| {
    // rust: menu.creative = false;
            // 0 input, 1 fuel, 2 output, 3..30 inventory, 30..39 hotbar.
    // rust: let mut landing = |item, count, from| {
    // rust: menu.set_slot(env, from, stack(item, count));
    // rust: let to = menu.quick_move_landing(env, from);
    // rust: menu.set_slot(env, from, None);
    // rust: for &t in &to {
    // rust: menu.set_slot(env, t, None);
}
    // rust: to
}
    // rust: assert_eq!(landing("raw_iron", 5, 30), [0]);
    // rust: assert_eq!(landing("coal", 5, 30), [1]);
            // Neither: between the hotbar and the inventory, as a shift-click.
    // rust: assert_eq!(landing("dirt", 5, 30), [3]);
    // rust: assert_eq!(landing("dirt", 5, 3), [30]);
            // Out of the fuel slot: moveItemStackTo(3, 39, false).
    // rust: assert_eq!(landing("coal", 5, 1), [3]);
    // rust: });
}

pub fn quick_move_landing_never_fills_a_result() void {
}
    // rust: with_menu(Kind::Furnace("smelting"), |env, menu| {
    // rust: menu.creative = false;
    // rust: menu.set_slot(env, 2, stack("iron_ingot", 5));
    // rust: menu.set_slot(env, 30, stack("iron_ingot", 5));
            // An ingot with room in the output still goes elsewhere.
    // rust: assert_eq!(menu.quick_move_landing(env, 30), [3]);
    // rust: assert_eq!(menu.slot(2).map(|s| s.count), Some(5));
    // rust: });
    // rust: with_menu(Kind::Furnace("smelting"), |env, menu| {
    // rust: menu.creative = false;
            // The whole output moves: into the partial stack, then an empty slot.
    // rust: menu.set_slot(env, 2, stack("iron_ingot", 5));
    // rust: menu.set_slot(env, 20, stack("iron_ingot", 62));
    // rust: assert_eq!(menu.quick_move_landing(env, 2), [20, 38]);
    // rust: });
    // rust: with_menu(Kind::Furnace("smelting"), |env, menu| {
    // rust: menu.creative = false;
            // A full inventory: the output stays, nothing to land on.
    // rust: menu.set_slot(env, 2, stack("iron_ingot", 5));
    // rust: for i in 3..39 {
    // rust: menu.set_slot(env, i, stack("stone", 64));
}
    // rust: assert!(menu.quick_move_landing(env, 2).is_empty());
    // rust: });
}

pub fn quick_move_landing_routes_a_crafting_table_like_vanilla() void {
}
    // rust: with_menu(Kind::Crafting, |env, menu| {
    // rust: menu.creative = false;
            // 0 result, 1..10 grid, 10..37 inventory, 37..46 hotbar.
    // rust: menu.set_slot(env, 37, stack("oak_log", 2));
    // rust: assert_eq!(menu.quick_move_landing(env, 37), [1]);
    // rust: });
    // rust: with_menu(Kind::Crafting, |env, menu| {
    // rust: menu.creative = false;
    // rust: menu.set_slot(env, 1, stack("oak_log", 1));
    // rust: menu.settle(env);
    // rust: assert_eq!(menu.slot(0).map(|s| s.count), Some(4));
    // rust: assert_eq!(menu.quick_move_landing(env, 0), [45]);
    // rust: });
}

    /// A crafting grid's result taken is recorded for `native_item_crafted`:
    /// the recipe the grid matched and the stack the player took.
pub fn taking_a_crafting_result_records_the_crafted_stack() void {
}
    // rust: with_menu(Kind::Crafting, |env, menu| {
    // rust: menu.creative = false;
    // rust: menu.set_slot(env, 1, stack("oak_log", 1));
    // rust: menu.settle(env);
    // rust: menu.click(env, 0, 0, Input::Pickup).unwrap();
    // rust: assert_eq!(
    // rust: menu.item_crafted,
    // rust: vec![(
    // rust: "minecraft:oak_planks".to_owned(),
    // rust: stack("oak_planks", 4).unwrap()
    // rust: )]
    // rust: );
    // rust: });
}

pub fn quick_move_landing_routes_plain_containers() void {
}
    // rust: for (kind, size) in [
    // rust: (Kind::Hopper, 5),
    // rust: (Kind::Dispenser, 9),
    // rust: (Kind::Chest(3), 27),
    // rust: ] {
    // rust: with_menu(kind, |env, menu| {
    // rust: menu.creative = false;
    // rust: let hotbar = size + 27;
    // rust: menu.set_slot(env, hotbar, stack("stone", 3));
    // rust: assert_eq!(menu.quick_move_landing(env, hotbar), [0]);
    // rust: });
    // rust: with_menu(kind, |env, menu| {
    // rust: menu.creative = false;
    // rust: menu.set_slot(env, 0, stack("stone", 3));
    // rust: assert_eq!(menu.quick_move_landing(env, 0), [size + 35]);
    // rust: });
}
}

pub fn takes_one_follows_the_slots_rules() void {
}
    // rust: with_menu(Kind::Furnace("smelting"), |env, menu| {
    // rust: menu.creative = false;
    // rust: let (coal, cobble) = (stack("coal", 1).unwrap(), stack("cobblestone", 1).unwrap());
    // rust: let bucket = stack("bucket", 1).unwrap();
    // rust: assert!(menu.takes_one(env, 0, &cobble), "the input takes anything");
    // rust: assert!(menu.takes_one(env, 1, &coal));
    // rust: assert!(!menu.takes_one(env, 1, &cobble), "not fuel");
    // rust: assert!(!menu.takes_one(env, 2, &coal), "the output");
    // rust: menu.set_slot(env, 1, Some(bucket.clone()));
    // rust: assert!(
    // rust: !menu.takes_one(env, 1, &bucket),
    // rust: "one bucket in the fuel slot"
    // rust: );
    // rust: menu.set_slot(env, 1, stack("coal", 1));
    // rust: assert!(!menu.takes_one(env, 1, &bucket), "another item");
    // rust: assert!(menu.takes_one(env, 1, &coal));
    // rust: });
}

    /// `HorseInventoryMenu`: a shift-click wears horse armour, then saddles,
    /// then fills the chest; the body slot takes only what the mount may wear.
pub fn mount_menu_slots_take_what_the_mount_wears() void {
}
    // rust: with_menu(Kind::Mount(5), |env, menu| {
    // rust: menu.creative = false;
    // rust: menu.mount = Some("minecraft:donkey".into());
            // 2 saddle and body, 15 chest, then the inventory from 17.
    // rust: assert_eq!(menu.slot_count(), 2 + 15 + 36);
    // rust: let hotbar = 17 + 27;
    // rust: menu.set_slot(env, hotbar, stack("iron_horse_armor", 1));
    // rust: menu.click(env, hotbar as i32, 0, Input::QuickMove).unwrap();
            // A donkey wears no horse armour: it goes in the chest.
    // rust: assert_eq!(menu.slot(1), None);
    // rust: assert_eq!(
    // rust: menu.slot(2).map(|s| &*s.item),
    // rust: Some("minecraft:iron_horse_armor")
    // rust: );
    // rust: menu.set_slot(env, hotbar, stack("saddle", 1));
    // rust: menu.click(env, hotbar as i32, 0, Input::QuickMove).unwrap();
    // rust: assert_eq!(menu.slot(0).map(|s| &*s.item), Some("minecraft:saddle"));
            // Back out of the mount: to the inventory, from the hotbar's end.
    // rust: menu.click(env, 0, 0, Input::QuickMove).unwrap();
    // rust: assert_eq!(menu.slot(0), None);
    // rust: assert_eq!(
    // rust: menu.slot(17 + 35).map(|s| &*s.item),
    // rust: Some("minecraft:saddle")
    // rust: );
    // rust: });
    // rust: with_menu(Kind::Mount(0), |env, menu| {
    // rust: menu.creative = false;
    // rust: menu.mount = Some("minecraft:horse".into());
    // rust: let hotbar = 2 + 27;
    // rust: menu.set_slot(env, hotbar, stack("diamond_horse_armor", 1));
    // rust: menu.click(env, hotbar as i32, 0, Input::QuickMove).unwrap();
    // rust: assert_eq!(
    // rust: menu.slot(1).map(|s| &*s.item),
    // rust: Some("minecraft:diamond_horse_armor")
    // rust: );
            // No chest: dirt goes between the hotbar and the inventory.
    // rust: menu.set_slot(env, hotbar, stack("dirt", 3));
    // rust: menu.click(env, hotbar as i32, 0, Input::QuickMove).unwrap();
    // rust: assert_eq!(
    // rust: menu.slot(2).map(|s| (&*s.item, s.count)),
    // rust: Some(("minecraft:dirt", 3))
    // rust: );
    // rust: assert_eq!(menu.slot(hotbar), None);
            // Placing by hand: a saddle doesn't go in the body slot.
    // rust: menu.carried = stack("saddle", 1);
    // rust: menu.click(env, 1, 0, Input::Pickup).unwrap();
    // rust: assert_eq!(
    // rust: menu.slot(1).map(|s| &*s.item),
    // rust: Some("minecraft:diamond_horse_armor")
    // rust: );
    // rust: menu.click(env, 0, 0, Input::Pickup).unwrap();
    // rust: assert_eq!(menu.slot(0).map(|s| &*s.item), Some("minecraft:saddle"));
    // rust: });
}

    /// `onEquipItem` runs from the armour and off-hand slots' `setByPlayer`
    /// when the item changes: never from `Inventory.setItem` (a swap's source).
pub fn armour_and_off_hand_slots_report_what_is_equipped() void {
}
    // rust: with_menu(Kind::Inventory, |env, menu| {
    // rust: menu.creative = false;
    // rust: let name = |e: &[(&str, Option<ItemStack>)]| {
    // rust: e.iter()
    // rust: .map(|(slot, s)| format!("{slot}:{}", s.as_ref().map_or("-", |s| &*s.item)))
    // rust: .collect::<Vec<_>>()
}
            // A shift-click puts the helmet on (InventoryMenu.quickMoveStack).
    // rust: menu.set_slot(env, 9, stack("iron_helmet", 1));
    // rust: menu.click(env, 9, 0, Input::QuickMove).unwrap();
    // rust: assert_eq!(name(&menu.equipped), ["head:minecraft:iron_helmet"]);
            // Taking it off; the same helmet back on is a change both ways.
    // rust: menu.equipped.clear();
    // rust: menu.click(env, 5, 0, Input::Pickup).unwrap();
    // rust: menu.click(env, 5, 0, Input::Pickup).unwrap();
    // rust: assert_eq!(
    // rust: name(&menu.equipped),
    // rust: ["head:-", "head:minecraft:iron_helmet"]
    // rust: );
            // F over a hotbar slot: the shield reaches the off hand by
            // Inventory.setItem, so nothing; a number key onto the off-hand
            // slot sets it by player.
    // rust: menu.equipped.clear();
    // rust: menu.set_slot(env, 36, stack("shield", 1));
    // rust: menu.click(env, 36, 40, Input::Swap).unwrap();
    // rust: assert_eq!(menu.slot(45).map(|s| &*s.item), Some("minecraft:shield"));
    // rust: assert!(menu.equipped.is_empty());
    // rust: menu.click(env, 45, 1, Input::Swap).unwrap();
    // rust: assert_eq!(name(&menu.equipped), ["offhand:-"]);
            // Other menus have no equipment slots.
    // rust: let mut chest = Menu::new(Kind::Chest(1));
    // rust: chest.set_slot(env, 0, stack("iron_helmet", 1));
    // rust: chest.click(env, 0, 0, Input::QuickMove).unwrap();
    // rust: assert!(chest.equipped.is_empty());
    // rust: });
}

pub fn installed_slot_rules_change_mod_menu_placement() void {
}
    // rust: let installed =
    // rust: crate::native_client_hooks::install(crate::native_client_hooks::NativeClientHooks {
    // rust: menu_slot_rules: |menu, slot, _, may_place, max_stack| {
    // rust: if menu == "test:rules" && slot == 0 {
    // rust: *may_place = false;
    // rust: *max_stack = 7;
}
    // rust: },
    // rust: player_chat: |_, _, _, _, _| {},
    // rust: living_heal: |_, _, _| {},
    // rust: living_breathe: |_, _, _, _, _| {},
    // rust: living_drown: |_, _, _, _, _, _| {},
    // rust: living_fall: |_, _, _, _, _| {},
    // rust: living_jump: |_, _| {},
    // rust: register_goals: |_| {},
    // rust: ingredient: |_, _, _| {},
    // rust: ingredient_test: |_, _, _, _| {},
    // rust: });
    // rust: assert!(installed.is_ok());
    // rust: let kind = Kind::Mod(Box::leak(Box::new(crate::containers::ModMenuType {
    // rust: id: "test:rules",
    // rust: slots: 1,
    // rust: data_slots: 0,
    // rust: results: vec![],
    // rust: })));
    // rust: let menu = Menu::new(kind);
    // rust: let stack = ItemStack::new("minecraft:stone", 1);
    // rust: assert_eq!(menu.mod_slot(0, &stack), (false, 7));
}

    /// A cancelled `AnvilCraftEvent.Pre` refuses the take: the result sits in
    /// its slot, both inputs and the cost are as they were, and neither the
    /// cursor nor the inventory holds the item (no dupe).
pub fn a_cancelled_anvil_craft_leaves_the_menu_as_it_was() void {
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-anvil-cancel-{}", std::process::id()));
    // rust: std::fs::create_dir_all(root.join("data/minecraft/recipe")).unwrap();
    // rust: let items = Items::for_tests(Default::default());
    // rust: let recipes = Recipes::load(&root, &items, &PackOverlay::NONE).unwrap();
    // rust: let brewing = Brewing::load(&root, &items, &PackOverlay::NONE);
    // rust: let _ = std::fs::remove_dir_all(&root);
    // rust: let (banners, station_recipes) = (Banners::default(), Default::default());
    // rust: let (enchantments, names) = (Default::default(), Default::default());
    // rust: let env = &Env {
    // rust: items: &items,
    // rust: recipes: &recipes,
    // rust: brewing: &brewing,
    // rust: banners: &banners,
    // rust: station_recipes: &station_recipes,
    // rust: enchantments: &enchantments,
    // rust: names: &names,
    // rust: trade: None,
    // rust: maps: None,
    // rust: limited_crafting: false,
    // rust: known_recipes: None,
}
        // Both a pick-up onto the cursor and a shift-click into the inventory.
    // rust: for input in [Input::Pickup, Input::QuickMove] {
    // rust: let mut menu = Menu::new(Kind::Anvil);
    // rust: menu.creative = false;
    // rust: menu.levels = 10;
    // rust: menu.anvil_hook = true;
    // rust: menu.set_slot(env, 0, stack("iron_sword", 1));
    // rust: menu.set_slot(env, 1, stack("iron_ingot", 2));
    // rust: menu.set_slot(env, 2, stack("iron_sword", 1));
    // rust: menu.data[0] = 3;
    // rust: let before = (
    // rust: menu.slot(0).cloned(),
    // rust: menu.slot(1).cloned(),
    // rust: menu.slot(2).cloned(),
    // rust: );
    // rust: let undo = menu.anvil_undo();
    // rust: menu.click(env, 2, 0, input).unwrap();
            // The take waits for the mods, and the click moved the result.
    // rust: let craft = menu.anvil_craft.take().expect("the take is deferred");
    // rust: assert_eq!(craft.output, before.2.clone().unwrap());
    // rust: assert_eq!(menu.slot(2), None);
    // rust: assert_eq!(menu.data[0], 3);
    // rust: menu.anvil_craft = Some(craft);
    // rust: menu.anvil_cancel(undo);
    // rust: assert_eq!(
    // rust: (
    // rust: menu.slot(0).cloned(),
    // rust: menu.slot(1).cloned(),
    // rust: menu.slot(2).cloned()
    // rust: ),
    // rust: before
    // rust: );
    // rust: assert_eq!(menu.data[0], 3);
    // rust: assert_eq!(menu.level_change, 0);
    // rust: assert_eq!(menu.carried, None);
    // rust: assert!((0..36).all(|i| menu.player_item(i).is_none()));
    // rust: assert!(menu.anvil_craft.is_none() && menu.dropped.is_empty());
}
}

    /// A mod menu type: three slots, then a result (slot 3).
pub fn mod_menu() K {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Kind::Mod(Box::leak(Box::new(crate::containers::ModMenuType {
    // rust: id: "test:press",
    // rust: slots: 4,
    // rust: data_slots: 0,
    // rust: results: vec![3],
    // rust: })))
}

    /// A mod menu type's result takes nothing in by a click, a drag, a swap
    /// or a shift-click (`Slot.mayPlace`), not even a top-up of its own item,
    /// and gives what it holds. A slot its screen leaves out takes no click.
pub fn a_mod_menu_result_is_take_only() void {
}
        // No game data: an item table of no items, each stacking to 64.
    // rust: let root = std::env::temp_dir().join(format!("horizon-mod-menu-{}", std::process::id()));
    // rust: std::fs::create_dir_all(root.join("data/minecraft/recipe")).unwrap();
    // rust: let items = Items::for_tests(Default::default());
    // rust: let recipes = Recipes::load(&root, &items, &PackOverlay::NONE).unwrap();
    // rust: let brewing = Brewing::load(&root, &items, &PackOverlay::NONE);
    // rust: let _ = std::fs::remove_dir_all(&root);
    // rust: let (banners, station_recipes) = (Banners::default(), Default::default());
    // rust: let (enchantments, names) = (Default::default(), Default::default());
    // rust: let env = &Env {
    // rust: items: &items,
    // rust: recipes: &recipes,
    // rust: brewing: &brewing,
    // rust: banners: &banners,
    // rust: station_recipes: &station_recipes,
    // rust: enchantments: &enchantments,
    // rust: names: &names,
    // rust: trade: None,
    // rust: maps: None,
    // rust: limited_crafting: false,
    // rust: known_recipes: None,
}
    // rust: let menu = &mut Menu::new(mod_menu());
    // rust: {
    // rust: menu.creative = false;
    // rust: let n = |s: Option<&ItemStack>| s.map(|s| s.count);
            // 0..4 the mod's, 4..31 inventory, 31..40 hotbar.
    // rust: menu.carried = stack("stick", 4);
    // rust: menu.click(env, 3, 0, Input::Pickup).unwrap();
    // rust: menu.click(env, 0, 0, Input::Pickup).unwrap();
    // rust: assert_eq!((n(menu.slot(3)), n(menu.slot(0))), (None, Some(4)));
            // The carried ingots take the result's one instead of going in.
    // rust: menu.put(env, 3, stack("iron_ingot", 1));
    // rust: menu.carried = stack("iron_ingot", 2);
    // rust: menu.click(env, 3, 0, Input::Pickup).unwrap();
    // rust: assert_eq!((n(menu.slot(3)), n(menu.carried.as_ref())), (None, Some(3)));
            // A drag over 1 to 3 passes the result by.
    // rust: menu.carried = stack("dirt", 4);
    // rust: for (slot, button) in [(-999, 0), (1, 1), (2, 1), (3, 1), (-999, 2)] {
    // rust: menu.click(env, slot, button, Input::QuickCraft).unwrap();
}
    // rust: let held = |m: &Menu| [0, 1, 2, 3].map(|s| n(m.slot(s)));
    // rust: assert_eq!(held(menu), [Some(4), Some(2), Some(2), None]);
            // A shift-click from the hotbar tops up no result, and a hotbar
            // key puts nothing in it but takes from it into an empty slot.
    // rust: menu.put(env, 3, stack("iron_ingot", 1));
    // rust: menu.set_player_item(0, stack("iron_ingot", 3));
    // rust: menu.click(env, 31, 0, Input::QuickMove).unwrap();
    // rust: menu.click(env, 3, 0, Input::Swap).unwrap();
    // rust: assert_eq!(
    // rust: (n(menu.slot(3)), n(menu.player_item(0))),
    // rust: (Some(1), Some(3))
    // rust: );
    // rust: menu.click(env, 3, 1, Input::Swap).unwrap();
    // rust: assert_eq!((n(menu.slot(3)), n(menu.player_item(1))), (None, Some(1)));
            // F takes it into an empty off hand, and a double click collects from it.
    // rust: menu.put(env, 3, stack("iron_ingot", 2));
    // rust: menu.click(env, 3, 40, Input::Swap).unwrap();
    // rust: assert_eq!((n(menu.slot(3)), n(menu.player_item(40))), (None, Some(2)));
    // rust: menu.put(env, 3, stack("iron_ingot", 2));
    // rust: menu.set_player_item(0, None);
    // rust: menu.set_player_item(1, None);
    // rust: menu.carried = stack("iron_ingot", 1);
    // rust: menu.click(env, 4, 0, Input::PickupAll).unwrap();
    // rust: assert_eq!((n(menu.slot(3)), n(menu.carried.as_ref())), (None, Some(3)));
            // A hidden slot takes neither a click nor a shift-click.
    // rust: menu.set_player_item(0, stack("iron_ingot", 3));
    // rust: menu.put(env, 0, None);
    // rust: menu.hide_slot(0);
    // rust: menu.carried = stack("stone", 1);
    // rust: menu.click(env, 0, 0, Input::Pickup).unwrap();
    // rust: menu.click(env, 31, 0, Input::QuickMove).unwrap();
    // rust: assert_eq!((n(menu.slot(0)), n(menu.player_item(0))), (None, Some(3)));
}
}

pub fn a_quick_craft_drag_previews_each_slot_and_the_rest_in_hand() void {
}
    // rust: with_menu(Kind::Inventory, |env, menu| {
            // 9 + 36 player slots: 9 is the first main inventory slot.
    // rust: menu.set_slot(env, 10, stack("stone", 60));
    // rust: menu.set_slot(env, 11, stack("dirt", 1));
    // rust: menu.carried = stack("stone", 20);
            // shouldAddSlotToQuickCraft: same item or empty, placeable, not the result.
    // rust: assert!(menu.quick_craft_accepts(env, 9, 0, 0));
    // rust: assert!(menu.quick_craft_accepts(env, 10, 0, 1));
    // rust: assert!(!menu.quick_craft_accepts(env, 11, 0, 1));
    // rust: assert!(!menu.quick_craft_accepts(env, 0, 0, 1));
            // Stone has no place in an armor slot (5).
    // rust: assert!(!menu.quick_craft_accepts(env, 5, 0, 1));
            // A right drag stops once every carried item has a slot.
    // rust: assert!(!menu.quick_craft_accepts(env, 12, 1, 20));
            // A left drag over three slots: 6 each, the 60 capped at 64 (yellow), 2 + 4 left.
    // rust: assert_eq!(menu.quick_craft_preview(env, 0, &[9]), None);
    // rust: let (shown, left) = menu.quick_craft_preview(env, 0, &[9, 10, 12]).unwrap();
    // rust: assert_eq!(
    // rust: shown,
    // rust: vec![Some((6, false)), Some((64, true)), Some((6, false))]
    // rust: );
    // rust: assert_eq!(left, 20 - 6 - 4 - 6);
            // A right drag: one each.
    // rust: let (shown, left) = menu.quick_craft_preview(env, 1, &[9, 10]).unwrap();
    // rust: assert_eq!(shown, vec![Some((1, false)), Some((61, false))]);
    // rust: assert_eq!(left, 18);
    // rust: });
}

pub fn item_picker_quick_move_deletes_a_hotbar_stack() void {
}
    // rust: with_picker("stone", |env, menu| {
    // rust: menu.set_slot(env, 45, stack("dirt", 12));
    // rust: menu.set_slot(env, 46, stack("dirt", 5));
    // rust: menu.click(env, 45, 0, Input::QuickMove).unwrap();
    // rust: assert_eq!(menu.player_item(0), None);
            // Nothing moves anywhere: the other hotbar stack and the tab stay.
    // rust: assert_eq!(menu.player_item(1), stack("dirt", 5).as_ref());
    // rust: assert_eq!(menu.slot(0), stack("stone", 1).as_ref());
    // rust: assert_eq!(menu.carried, None);
    // rust: });
}

pub fn item_picker_drags_and_pickup_all_skip_the_display_slots() void {
}
    // rust: with_picker("dirt", |env, menu| {
            // A right-drag over a display slot and two hotbar slots.
    // rust: menu.carried = stack("dirt", 10);
    // rust: for (slot, header) in [(-999, 0), (3, 1), (45, 1), (47, 1), (-999, 2)] {
    // rust: menu.click(env, slot, header | (1 << 2), Input::QuickCraft)
    // rust: .unwrap();
}
    // rust: assert_eq!(menu.player_item(0), stack("dirt", 1).as_ref());
    // rust: assert_eq!(menu.player_item(2), stack("dirt", 1).as_ref());
    // rust: assert_eq!(menu.slot(3), stack("dirt", 1).as_ref());
    // rust: assert_eq!(menu.carried, stack("dirt", 8));
            // A double click gathers from the hotbar only.
    // rust: menu.click(env, 48, 0, Input::PickupAll).unwrap();
    // rust: assert_eq!(menu.carried, stack("dirt", 10));
    // rust: assert_eq!(menu.player_item(0), None);
    // rust: assert_eq!(menu.slot(0), stack("dirt", 1).as_ref());
    // rust: });
}

    /// #1737: a Shift+Right-Click quick move in a chest (a double chest's
    /// 54 slots) moves the stack and leaves the menu's state clean, so the
    /// next quick move still moves its stack and the inventory still
    /// answers.
pub fn a_chest_quick_move_keeps_the_next_one_working() void {
}
    // rust: with_menu(Kind::Chest(6), |env, menu| {
    // rust: menu.creative = false;
            // The hotbar holds two stacks; the chest is empty.
    // rust: menu.set_slot(env, 81, stack("cobblestone", 64));
    // rust: menu.set_slot(env, 82, stack("dirt", 32));
            // Shift+Right-Click on the hotbar: the stack goes into the chest.
    // rust: menu.click(env, 81, 1, Input::QuickMove).unwrap();
    // rust: assert_eq!(menu.slot(81), None);
    // rust: assert_eq!(menu.slot(0).map(|s| s.count), Some(64));
            // Nothing is left on the cursor and no quick craft is running.
    // rust: assert_eq!(menu.carried, None);
    // rust: assert_eq!(menu.quick_status, 0);
            // The next quick move still works.
    // rust: menu.click(env, 82, 1, Input::QuickMove).unwrap();
    // rust: assert_eq!(menu.slot(82), None);
    // rust: assert_eq!(menu.slot(1).map(|s| s.count), Some(32));
    // rust: assert_eq!(menu.carried, None);
    // rust: assert_eq!(menu.quick_status, 0);
    // rust: });
}

    /// #6907: a drag in progress is seen from outside the menu, and a
    /// quick move during it only ends the drag (`doClick`'s resetQuickCraft).
pub fn a_quick_move_during_a_drag_only_ends_it() void {
}
    // rust: with_menu(Kind::Chest(3), |env, menu| {
    // rust: menu.creative = false;
    // rust: menu.set_slot(env, 27, stack("dirt", 10));
    // rust: menu.carried = stack("cobblestone", 64);
    // rust: assert!(!menu.quick_crafting());
            // Start a left drag, then drag across chest slot 0.
    // rust: menu.click(env, -999, 0, Input::QuickCraft).unwrap();
    // rust: menu.click(env, 0, 1, Input::QuickCraft).unwrap();
    // rust: assert!(menu.quick_crafting());
            // A shift-click now moves nothing and ends the drag.
    // rust: menu.click(env, 27, 0, Input::QuickMove).unwrap();
    // rust: assert!(!menu.quick_crafting());
    // rust: assert_eq!(menu.slot(27).map(|s| s.count), Some(10));
    // rust: assert_eq!(menu.slot(0), None);
    // rust: });
}

    /// #1832: a potion taken from the creative inventory and put in the
    /// hotbar keeps its `PotionContents` (the brew), as vanilla's
    /// `PotionContents.createItemStack` builds it: the item tab's stack is
    /// the real one, and the hotbar slot holds it as it is.
pub fn a_creative_potion_keeps_its_contents_in_the_hotbar() void {
}
    // rust: let snbt = r#"{components:{"minecraft:potion_contents":{potion:"minecraft:swiftness"}},count:1,id:"minecraft:potion"}"#;
    // rust: let potion = crate::item_data::parse_stack(snbt).unwrap().unwrap();
    // rust: assert_eq!(potion.potion(), Some("minecraft:swiftness"));
        // The creative screen hands the stack over...
    // rust: let mut carried = None;
    // rust: crate::creative::click_display(
    // rust: &mut carried,
    // rust: Some(&potion),
    // rust: |_: &ItemStack| 1,
    // rust: 0,
    // rust: Input::Pickup,
    // rust: );
    // rust: assert_eq!(
    // rust: carried.as_ref().and_then(|s| s.potion()),
    // rust: Some("minecraft:swiftness")
    // rust: );
        // ... and the hotbar slot keeps it: it is not the uncraftable
        // potion, which is a `minecraft:potion` with no contents at all.
    // rust: with_menu(Kind::ItemPicker, |env, menu| {
    // rust: menu.carried = carried;
    // rust: menu.click(env, 45, 0, Input::Pickup).unwrap();
    // rust: let in_hand = menu.slot(45).expect("the hotbar slot");
    // rust: assert_eq!(in_hand.potion(), Some("minecraft:swiftness"));
    // rust: assert_eq!(&*in_hand.item, "minecraft:potion");
    // rust: });
}

    /// `RecipeCraftingHolder.setRecipeUsed`: when `limited_crafting` is false,
    /// crafting works even if the recipe is not known by the player.
pub fn limited_crafting_disabled_allows_crafting_unknown_recipe() void {
}
//         use crate::crafting::{Ingredient, Recipe, Template};
    // rust: let mut recipes = Recipes::empty();
    // rust: recipes.crafting.push((
    // rust: "oak_planks".into(),
    // rust: Recipe::Shapeless {
    // rust: ingredients: vec![Ingredient::of(vec!["minecraft:oak_log".into()])],
    // rust: result: Template {
    // rust: item: Some("minecraft:oak_planks".into()),
    // rust: count: 4,
    // rust: damage: 0,
    // rust: extra: None,
    // rust: components: None,
    // rust: },
    // rust: },
    // rust: ));
    // rust: let items = Items::for_tests(Default::default());
    // rust: let brewing = Brewing::load(&std::path::PathBuf::new(), &items, &PackOverlay::NONE);
    // rust: let banners = Banners::default();
    // rust: let station_recipes = crate::stations::StationRecipes::default();
    // rust: let enchantments = crate::enchant::Enchantments::default();
    // rust: let names = crate::creative::Names::default();

    // rust: let env = Env {
    // rust: items: &items,
    // rust: recipes: &recipes,
    // rust: brewing: &brewing,
    // rust: banners: &banners,
    // rust: station_recipes: &station_recipes,
    // rust: enchantments: &enchantments,
    // rust: names: &names,
    // rust: trade: None,
    // rust: maps: None,
    // rust: limited_crafting: false,
    // rust: known_recipes: None,
}

    // rust: let mut menu = Menu::new(Kind::Inventory);
    // rust: menu.set_slot(&env, 1, stack("oak_log", 1));
    // rust: assert_eq!(
    // rust: menu.slot(0).map(|s| (&*s.item, s.count)),
    // rust: Some(("minecraft:oak_planks", 4)),
    // rust: "when limited_crafting is false, unlearned recipe should craft"
    // rust: );
}

    /// `RecipeCraftingHolder.setRecipeUsed`: when `limited_crafting` is true,
    /// an unlearned recipe is blocked (result slot is None).
pub fn limited_crafting_enabled_blocks_unknown_recipe() void {
}
//         use crate::crafting::{Ingredient, Recipe, Template};
    // rust: let mut recipes = Recipes::empty();
    // rust: recipes.crafting.push((
    // rust: "oak_planks".into(),
    // rust: Recipe::Shapeless {
    // rust: ingredients: vec![Ingredient::of(vec!["minecraft:oak_log".into()])],
    // rust: result: Template {
    // rust: item: Some("minecraft:oak_planks".into()),
    // rust: count: 4,
    // rust: damage: 0,
    // rust: extra: None,
    // rust: components: None,
    // rust: },
    // rust: },
    // rust: ));
    // rust: let items = Items::for_tests(Default::default());
    // rust: let brewing = Brewing::load(&std::path::PathBuf::new(), &items, &PackOverlay::NONE);
    // rust: let banners = Banners::default();
    // rust: let station_recipes = crate::stations::StationRecipes::default();
    // rust: let enchantments = crate::enchant::Enchantments::default();
    // rust: let names = crate::creative::Names::default();

    // rust: let known = ["minecraft:stick"];
    // rust: let env = Env {
    // rust: items: &items,
    // rust: recipes: &recipes,
    // rust: brewing: &brewing,
    // rust: banners: &banners,
    // rust: station_recipes: &station_recipes,
    // rust: enchantments: &enchantments,
    // rust: names: &names,
    // rust: trade: None,
    // rust: maps: None,
    // rust: limited_crafting: true,
    // rust: known_recipes: Some(&known),
}

    // rust: let mut menu = Menu::new(Kind::Inventory);
    // rust: menu.set_slot(&env, 1, stack("oak_log", 1));
    // rust: assert_eq!(
    // rust: menu.slot(0),
    // rust: None,
    // rust: "when limited_crafting is true, unknown recipe must produce None in result slot"
    // rust: );
}

    /// `RecipeCraftingHolder.setRecipeUsed`: when `limited_crafting` is true,
    /// a learned recipe (present in `known_recipes`) crafts successfully.
pub fn limited_crafting_enabled_allows_known_recipe() void {
}
//         use crate::crafting::{Ingredient, Recipe, Template};
    // rust: let mut recipes = Recipes::empty();
    // rust: recipes.crafting.push((
    // rust: "oak_planks".into(),
    // rust: Recipe::Shapeless {
    // rust: ingredients: vec![Ingredient::of(vec!["minecraft:oak_log".into()])],
    // rust: result: Template {
    // rust: item: Some("minecraft:oak_planks".into()),
    // rust: count: 4,
    // rust: damage: 0,
    // rust: extra: None,
    // rust: components: None,
    // rust: },
    // rust: },
    // rust: ));
    // rust: let items = Items::for_tests(Default::default());
    // rust: let brewing = Brewing::load(&std::path::PathBuf::new(), &items, &PackOverlay::NONE);
    // rust: let banners = Banners::default();
    // rust: let station_recipes = crate::stations::StationRecipes::default();
    // rust: let enchantments = crate::enchant::Enchantments::default();
    // rust: let names = crate::creative::Names::default();

    // rust: let known = ["minecraft:oak_planks"];
    // rust: let env = Env {
    // rust: items: &items,
    // rust: recipes: &recipes,
    // rust: brewing: &brewing,
    // rust: banners: &banners,
    // rust: station_recipes: &station_recipes,
    // rust: enchantments: &enchantments,
    // rust: names: &names,
    // rust: trade: None,
    // rust: maps: None,
    // rust: limited_crafting: true,
    // rust: known_recipes: Some(&known),
}

    // rust: let mut menu = Menu::new(Kind::Inventory);
    // rust: menu.set_slot(&env, 1, stack("oak_log", 1));
    // rust: assert_eq!(
    // rust: menu.slot(0).map(|s| (&*s.item, s.count)),
    // rust: Some(("minecraft:oak_planks", 4)),
    // rust: "when limited_crafting is true, learned recipe in known_recipes must craft"
    // rust: );
}

    /// `RecipeCraftingHolder.setRecipeUsed`: special recipes bypass the `known_recipes` check
    /// (`recipe.value().isSpecial()`) and craft even when limited crafting is enabled.
pub fn limited_crafting_enabled_allows_special_recipe() void {
}
//         use crate::crafting::{Ingredient, Recipe, Special, Template};
    // rust: let mut recipes = Recipes::empty();
    // rust: recipes.crafting.push((
    // rust: "dye_shulker_box".into(),
    // rust: Recipe::Special(Special::Transmute {
    // rust: input: Ingredient::of(vec!["minecraft:shulker_box".into()]),
    // rust: material: Ingredient::of(vec!["minecraft:red_dye".into()]),
    // rust: min: 1,
    // rust: max: 1,
    // rust: add_count: false,
    // rust: result: Template {
    // rust: item: Some("minecraft:red_shulker_box".into()),
    // rust: count: 1,
    // rust: damage: 0,
    // rust: extra: None,
    // rust: components: None,
    // rust: },
    // rust: }),
    // rust: ));
    // rust: let items = Items::for_tests(Default::default());
    // rust: let brewing = Brewing::load(&std::path::PathBuf::new(), &items, &PackOverlay::NONE);
    // rust: let banners = Banners::default();
    // rust: let station_recipes = crate::stations::StationRecipes::default();
    // rust: let enchantments = crate::enchant::Enchantments::default();
    // rust: let names = crate::creative::Names::default();

    // rust: let known: [&str; 0] = [];
    // rust: let env = Env {
    // rust: items: &items,
    // rust: recipes: &recipes,
    // rust: brewing: &brewing,
    // rust: banners: &banners,
    // rust: station_recipes: &station_recipes,
    // rust: enchantments: &enchantments,
    // rust: names: &names,
    // rust: trade: None,
    // rust: maps: None,
    // rust: limited_crafting: true,
    // rust: known_recipes: Some(&known),
}

    // rust: let mut menu = Menu::new(Kind::Inventory);
    // rust: menu.set_slot(&env, 1, stack("shulker_box", 1));
    // rust: menu.set_slot(&env, 2, stack("red_dye", 1));
    // rust: assert_eq!(
    // rust: menu.slot(0).map(|s| (&*s.item, s.count)),
    // rust: Some(("minecraft:red_shulker_box", 1)),
    // rust: "special recipe must craft with limited_crafting: true without being in known_recipes"
    // rust: );
}
}
