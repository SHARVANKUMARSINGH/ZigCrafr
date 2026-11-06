//! Transpiled from Horizon Rust crate
package horizon_client_stations

import "core:fmt"
import "core:mem"
import "core:math"

// Workstation menus in the game: enchanting table, anvil, grindstone,
// smithing table, stonecutter and the brewing stand screen. Layouts, sprites,
// colours and sounds follow the vanilla screens (`EnchantmentScreen`,
// `AnvilScreen`, `GrindstoneScreen`, `SmithingScreen`, `StonecutterScreen`,
// `BrewingStandScreen`); item rules live in `horizon_client::stations`.
// Invalid measurements must not reach tooltip positioning or reserve empty space.
tooltip_component_size :: proc(size: Maybe([f32; 2])) -> O {
    // Ported from Horizon
    return {}
}
    // rust: size.filter(|size| size.iter().all(|v| v.is_finite() && *v > 0.0))
}

    // rust: fn tooltip_position(
    // rust: (x, y): (f32, f32),
    // rust: (width, height): (f32, f32),
    // rust: (w, h): (f32, f32),
    // rust: ) -> (f32, f32) {
    // rust: let mut x = x + 12.0;
    // rust: let mut y = y - 12.0;
    // rust: if x + w > width - 4.0 {
    // rust: x = (x - 28.0 - w).max(4.0);
}
    // rust: if y + h + 3.0 > height {
    // rust: y = height - h - 3.0;
}
    // rust: y = y.max(4.0);
    // rust: (x, y)
}

// use super::{Game, Screen};
// use horizon_client::{
    // rust: block_entity_item, brewing,
    // rust: containers::BlockEntity,
    // rust: enchant::Enchantments,
    // rust: hud::{HudBatch, rgba},
    // rust: items::ItemStack,
    // rust: stations::{self, AnvilResult, EnchantOffers},
    // rust: text::Text,
}
// use horizon_core::random::{LegacyRandom, RandomSource};

// The book above the enchanting table's offers: `EnchantmentScreen`'s
// `time`, `flip`, `oFlip`, `flipT`, `flipA`, `open`, `oOpen` and `last`.
    // rust: pub(super) struct EnchantBook {
    // rust: time: i32,
    // rust: flip: f32,
    // rust: o_flip: f32,
    // rust: flip_t: f32,
    // rust: flip_a: f32,
    // rust: open: f32,
    // rust: o_open: f32,
    // rust: last: Option<ItemStack>,
    // rust: random: LegacyRandom,
}
    // rust: impl EnchantBook {
new :: proc(random: LegacyRandom) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: time: 0,
    // rust: flip: 0.0,
    // rust: o_flip: 0.0,
    // rust: flip_t: 0.0,
    // rust: flip_a: 0.0,
    // rust: open: 0.0,
    // rust: o_open: 0.0,
    // rust: last: None,
    // rust: random,
}
}
    // `EnchantmentScreen.tickBook`: a new item in the enchanting slot picks a
    // new page to turn to; the book opens while any offer has a cost.
    // rust: pub(super) fn tick(&mut self, input: Option<&ItemStack>, costs: [i32; 3]) {
    // rust: if input != self.last.as_ref() {
    // rust: self.last = input.cloned();
    // rust: loop {
    // rust: let a = self.random.next_int_bound(4).unwrap_or(0);
    // rust: let b = self.random.next_int_bound(4).unwrap_or(0);
    // rust: self.flip_t += (a - b) as f32;
    // rust: if !(self.flip <= self.flip_t + 1.0 && self.flip >= self.flip_t - 1.0) {
    // rust: break;
}
}
}
    // rust: self.time += 1;
    // rust: self.o_flip = self.flip;
    // rust: self.o_open = self.open;
    // rust: let open = costs.iter().any(|&c| c != 0);
    // rust: self.open = (self.open + if open { 0.2 } else { -0.2 }).clamp(0.0, 1.0);
    // rust: let diff = ((self.flip_t - self.flip) * 0.4).clamp(-0.2, 0.2);
    // rust: self.flip_a += (diff - self.flip_a) * 0.9;
    // rust: self.flip += self.flip_a;
}
    // `EnchantmentScreen.extractBook`'s `open` and `flip` at the partial tick.
    // rust: pub(super) fn at(&self, partial: f32) -> (f32, f32) {
    // rust: (
    // rust: self.o_open + (self.open - self.o_open) * partial,
    // rust: self.o_flip + (self.flip - self.o_flip) * partial,
    // rust: )
}
}

// Slot ids of the open station: inputs from 600, the result at 650.
    // rust: pub(super) const INPUT: usize = 600;
    // rust: pub(super) const RESULT: usize = 650;

    // rust: pub(super) enum Kind {
    // rust: Enchanting,
    // rust: Anvil,
    // rust: Grindstone,
    // rust: Smithing,
    // rust: Stonecutter,
    // Villager trading (game/trading.rs).
    // rust: Merchant,
    // The beacon menu (game/beacon.rs).
    // rust: Beacon,
    // The cartography table (game/cartography.rs).
    // rust: Cartography,
    // The loom (game/loom.rs).
    // rust: Loom,
}
    // rust: impl Kind {
    // rust: pub(super) fn from_block(name: &str) -> Option<Self> {
    // rust: Some(match name {
    // rust: "minecraft:enchanting_table" => Self::Enchanting,
    // rust: "minecraft:anvil" | "minecraft:chipped_anvil" | "minecraft:damaged_anvil" => {
    // rust: Self::Anvil
}
    // rust: "minecraft:grindstone" => Self::Grindstone,
    // rust: "minecraft:smithing_table" => Self::Smithing,
    // rust: "minecraft:stonecutter" => Self::Stonecutter,
    // rust: "minecraft:beacon" => Self::Beacon,
    // rust: "minecraft:cartography_table" => Self::Cartography,
    // rust: "minecraft:loom" => Self::Loom,
    // rust: _ => return None,
    // rust: })
}
    // rust: pub(super) fn inputs(self) -> usize {
    // rust: match self {
    // rust: Self::Smithing | Self::Loom => 3,
    // rust: Self::Stonecutter | Self::Beacon => 1,
    // rust: _ => 2,
}
}
texture :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Enchanting => "gui/container/enchanting_table",
    // rust: Self::Anvil => "gui/container/anvil",
    // rust: Self::Grindstone => "gui/container/grindstone",
    // rust: Self::Smithing => "gui/container/smithing",
    // rust: Self::Stonecutter => "gui/container/stonecutter",
    // rust: Self::Merchant => "gui/container/villager",
    // rust: Self::Beacon => "gui/container/beacon",
    // rust: Self::Cartography => "gui/container/cartography_table",
    // rust: Self::Loom => "gui/container/loom",
}
}
    // rust: pub(super) fn title_key(self) -> &'static str {
    // rust: match self {
    // rust: Self::Enchanting => "container.enchant",
    // rust: Self::Anvil => "container.repair",
    // rust: Self::Grindstone => "container.grindstone_title",
    // rust: Self::Smithing => "container.upgrade",
    // rust: Self::Stonecutter => "container.stonecutter",
    // rust: Self::Merchant => "merchant.trades",
    // rust: Self::Beacon => "container.beacon",
    // rust: Self::Cartography => "container.cartography_table",
    // rust: Self::Loom => "container.loom",
}
}
    // (titleLabelX, titleLabelY).
title_pos :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Anvil => (60.0, 6.0),
    // rust: Self::Smithing => (44.0, 15.0),
    // rust: Self::Stonecutter => (8.0, 5.0),
    // rust: Self::Cartography | Self::Loom => (8.0, 4.0),
    // rust: _ => (8.0, 6.0),
}
}
input_pos :: proc(self: ^Self, i: uint) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let table: &[(f32, f32)] = match self {
    // rust: Self::Enchanting => &[(15.0, 47.0), (35.0, 47.0)],
    // rust: Self::Anvil => &[(27.0, 47.0), (76.0, 47.0)],
    // rust: Self::Grindstone => &[(49.0, 19.0), (49.0, 40.0)],
    // rust: Self::Smithing => &[(8.0, 48.0), (26.0, 48.0), (44.0, 48.0)],
    // rust: Self::Stonecutter => &[(20.0, 33.0)],
    // rust: Self::Merchant => &[(86.0, 37.0), (112.0, 37.0)],
    // rust: Self::Beacon => &[(109.0, 110.0)],
    // rust: Self::Cartography => &[(15.0, 15.0), (15.0, 52.0)],
    // rust: Self::Loom => &[(13.0, 26.0), (33.0, 26.0), (23.0, 45.0)],
}
    // rust: table[i.min(table.len() - 1)]
}
    // Whether the menu has a result slot after its inputs.
    // rust: pub(super) fn has_result(self) -> bool {
    // rust: self.result_pos().is_some()
}
result_pos :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Enchanting => None,
    // rust: Self::Anvil => Some((134.0, 47.0)),
    // rust: Self::Grindstone => Some((129.0, 34.0)),
    // rust: Self::Smithing => Some((98.0, 48.0)),
    // rust: Self::Stonecutter => Some((143.0, 33.0)),
    // rust: Self::Merchant => Some((170.0, 37.0)),
    // rust: Self::Beacon => None,
    // rust: Self::Cartography => Some((145.0, 39.0)),
    // rust: Self::Loom => Some((143.0, 57.0)),
}
}
}

// `CyclingSlotBackground`: the icons an empty slot cycles through, one every
// 30 ticks, the next fading in over 4 (`CyclingSlotBackground.tick` in
// `advance`, `CyclingSlotBackground.extractRenderState` in `shown`).
CyclingSlot :: struct {
    icons: [dynamic]^'static str,
    tick: u32,
    index: uint,
    // The client tick it was last advanced to.
    at: Maybe(u64),
}
    // rust: impl CyclingSlot {
CHANGE_TICKS :: 30
FADE_TICKS :: 4.0
    // `CyclingSlotBackground.tick(newIcons)` for each client tick since the last call.
advance :: proc(self: ^Self, now: u64, icons: ^[^'static str]) {
}
    // rust: let ticks = self.at.map_or(0, |at| now.saturating_sub(at).min(600));
    // rust: self.at = Some(now);
    // rust: if self.icons != icons {
    // rust: self.icons = icons.to_vec();
    // rust: self.index = 0;
}
    // rust: for _ in 0..ticks {
    // rust: if !self.icons.is_empty() {
    // rust: self.tick += 1;
    // rust: if self.tick.is_multiple_of(Self::CHANGE_TICKS) {
    // rust: self.index = (self.index + 1) % self.icons.len();
}
}
}
}
    // What `CyclingSlotBackground.extractRenderState` draws for an empty slot: the icon before
    // this one fading out while this one fades in, with their alphas.
shown :: proc(self: ^Self, partial: f32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: if self.icons.is_empty() {
    // rust: return Vec::new();
}
    // rust: let fading = self.icons.len() > 1 && self.tick >= Self::CHANGE_TICKS;
    // rust: let alpha = if fading {
    // rust: (((self.tick % Self::CHANGE_TICKS) as f32 + partial).min(Self::FADE_TICKS))
    // rust: / Self::FADE_TICKS
    // rust: } else {
    // rust: 1.0
}
    // rust: let mut shown = Vec::new();
    // rust: if alpha < 1.0 {
    // rust: let previous = (self.index + self.icons.len() - 1) % self.icons.len();
    // rust: shown.push((self.icons[previous], 1.0 - alpha));
}
    // rust: shown.push((self.icons[self.index], alpha));
    // rust: shown
}
}
// `SmithingScreen`'s `EMPTY_SLOT_SMITHING_TEMPLATES`.
    // rust: const EMPTY_TEMPLATE_ICONS: [&str; 2] = [
    // rust: "smithing_template_armor_trim",
    // rust: "smithing_template_netherite_upgrade",
    // rust: ];
// The base and additions slot icons of the template in the smithing table:
// `SmithingTemplateItem.createNetheriteUpgradeTemplate` (the 11 tools and
// armour of `SmithingTemplateItem.createNetheriteUpgradeIconList`, then the
// ingot) and `SmithingTemplateItem.createArmorTrimTemplate` (the four armour
// pieces, then the seven trim materials), as `getBaseSlotEmptyIcons` and
// `getAdditionalSlotEmptyIcons` give them.
    // rust: fn smithing_slot_icons(
    // rust: template: Option<&str>,
    // rust: ) -> ([&'static str; 11], usize, [&'static str; 7], usize) {
    // rust: let none = ([""; 11], 0, [""; 7], 0);
    // rust: match template.map(|t| t.trim_start_matches("minecraft:")) {
    // rust: Some("netherite_upgrade_smithing_template") => (
    // rust: [
    // rust: "helmet",
    // rust: "sword",
    // rust: "chestplate",
    // rust: "pickaxe",
    // rust: "leggings",
    // rust: "axe",
    // rust: "boots",
    // rust: "hoe",
    // rust: "shovel",
    // rust: "nautilus_armor",
    // rust: "spear",
    // rust: ],
    // rust: 11,
    // rust: ["ingot", "", "", "", "", "", ""],
    // rust: 1,
    // rust: ),
    // rust: Some(t) if t.ends_with("_armor_trim_smithing_template") => (
    // rust: [
    // rust: "helmet",
    // rust: "chestplate",
    // rust: "leggings",
    // rust: "boots",
    // rust: "",
    // rust: "",
    // rust: "",
    // rust: "",
    // rust: "",
    // rust: "",
    // rust: "",
    // rust: ],
    // rust: 4,
    // rust: [
    // rust: "ingot",
    // rust: "redstone_dust",
    // rust: "lapis_lazuli",
    // rust: "quartz",
    // rust: "diamond",
    // rust: "emerald",
    // rust: "amethyst_shard",
    // rust: ],
    // rust: 7,
    // rust: ),
    // rust: _ => none,
}
}

    // rust: pub(super) struct Station {
    // rust: pub(super) kind: Kind,
    // rust: pub(super) pos: [i32; 3],
    // rust: pub(super) inputs: Vec<Option<ItemStack>>,
    // rust: pub(super) result: Option<ItemStack>,
    // rust: pub(super) offers: EnchantOffers,
    // rust: bookcases: i32,
    // rust: pub(super) anvil: AnvilResult,
    // Anvil rename box text (`AnvilMenu.itemName`).
    // rust: pub(super) name: String,
    // The box itself (`AnvilScreen`'s `EditBox` of 50, unbordered).
    // rust: pub(super) rename: horizon_client::ui::EditBox,
    // Stonecutter: the menu's recipe list (horizon_client::menu), its
    // `selectedRecipeIndex` and the screen's first shown index.
    // rust: pub(super) stone: horizon_client::menu::Stonecutter,
    // rust: pub(super) selected: Option<usize>,
    // rust: start: usize,
    // Stonecutter: the screen's `scrollOffs` (0 to 1) and `scrolling`, the
    // scroller held by the mouse.
    // rust: scroll: f32,
    // rust: scrolling: bool,
    // Anvil: the input the rename box was last filled from.
    // rust: anvil_last: Option<ItemStack>,
    // Anvil on a server: the name last sent (the client menu's `itemName`).
    // rust: pub(super) anvil_sent: Option<String>,
    // rust: pub(super) last_sound: u64,
    // Villager trading state.
    // rust: pub(super) merchant: Option<Box<super::trading::MerchantState>>,
    // Beacon menu: the selected primary and secondary power (EFFECTS index).
    // rust: pub(super) beacon: [Option<usize>; 2],
    // A server's beacon menu: the pyramid's levels (its data slot 0).
    // rust: pub(super) beacon_levels: Option<i32>,
    // The loom's patterns, selection and scroller (game/loom.rs).
    // rust: pub(super) loom: super::loom::LoomState,
    // The smithing table's three `CyclingSlotBackground`s: the template, base and additions slots.
    // rust: cycling: [CyclingSlot; 3],
    // The enchanting table's book (`EnchantmentScreen`'s flip and open state).
    // rust: pub(super) book: EnchantBook,
}
    // rust: impl Station {
new :: proc(kind: Kind, pos: [i32; 3]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: kind,
    // rust: pos,
    // rust: inputs: vec![None; kind.inputs()],
    // rust: result: None,
    // rust: offers: EnchantOffers::default(),
    // rust: bookcases: 0,
    // rust: anvil: AnvilResult::default(),
    // rust: name: String::new(),
    // rust: rename: anvil_box(),
    // rust: stone: Default::default(),
    // rust: selected: None,
    // rust: start: 0,
    // rust: scroll: 0.0,
    // rust: scrolling: false,
    // rust: anvil_last: None,
    // rust: anvil_sent: None,
    // rust: last_sound: 0,
    // rust: merchant: None,
    // rust: beacon: [None; 2],
    // rust: beacon_levels: None,
    // rust: loom: Default::default(),
    // rust: cycling: Default::default(),
    // rust: book: EnchantBook::new(LegacyRandom::new(
    // rust: horizon_client::sound_engine::unique_seed(),
    // rust: )),
}
}
    // rust: pub(super) fn new_kind(kind: Kind, pos: [i32; 3]) -> Self {
    // rust: Self::new(kind, pos)
}
    // `StonecutterScreen.containerChanged`: without recipes to show, the
    // list scrolls back to the top.
    // rust: pub(super) fn stonecutter_changed(&mut self) {
    // rust: if self.inputs[0].is_none() || self.stone.recipes.is_empty() {
    // rust: self.start = 0;
    // rust: self.scroll = 0.0;
}
}
    // `StonecutterScreen.isScrollBarActive`.
stonecutter_scrolls :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.inputs[0].is_some() && self.stone.recipes.len() > 12
}
    // Moves the stonecutter's scroller to `offs`, and its first shown
    // recipe (`startIndex`) with it.
stonecutter_scroll_to :: proc(self: ^Self, offs: f32) {
}
    // rust: self.scroll = offs.clamp(0.0, 1.0);
    // rust: self.start = stonecutter_start(self.stone.recipes.len(), self.scroll);
}
}

// `at` is on one of a list's `rows`, with no row further that way.
off_visible_rows :: proc(rows: ^[[f32; 4]], at: (f32) {
}
    // rust: let inside =
    // rust: |r: &[f32; 4]| at.0 >= r[0] && at.0 < r[0] + r[2] && at.1 >= r[1] && at.1 < r[1] + r[3];
    // rust: let Some(on) = rows.iter().find(|r| inside(r)) else {
    // rust: return false;
}
    // rust: !rows
    // rust: .iter()
    // rust: .any(|r| r[0] == on[0] && if up { r[1] < on[1] } else { r[1] > on[1] })
}

// `StonecutterScreen.getOffscreenRows`: the recipe rows below the 4x3 grid.
stonecutter_offscreen_rows :: proc(recipes: uint) -> i {
    // Ported from Horizon
    return {}
}
    // rust: recipes.div_ceil(4) as i32 - 3
}
// `startIndex` for a scroller position: the first recipe of the nearest row.
stonecutter_start :: proc(recipes: uint, offs: f32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: ((offs * stonecutter_offscreen_rows(recipes) as f32 + 0.5) as i32).max(0) as usize * 4
}
// `StonecutterScreen.mouseDragged`: the scroller position under the cursor,
// `y` relative to the GUI origin (the 54-px track starts at 14).
stonecutter_drag_offs :: proc(y: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: ((y - 14.0 - 7.5) / (54.0 - 15.0)).clamp(0.0, 1.0)
}

// The 108x19 enchantment button `i` (relative to the GUI origin).
enchant_button :: proc(i: uint) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: (60.0, 14.0 + 19.0 * i as f32, 108.0, 19.0)
}
inside :: proc(p: (f32) {
}
    // rust: p.0 >= x && p.1 >= y && p.0 < x + w && p.1 < y + h
}
// `EnchantmentNames` word list.
    // rust: const WORDS: &[&str] = &[
    // rust: "the",
    // rust: "elder",
    // rust: "scrolls",
    // rust: "klaatu",
    // rust: "berata",
    // rust: "niktu",
    // rust: "xyzzy",
    // rust: "bless",
    // rust: "curse",
    // rust: "light",
    // rust: "darkness",
    // rust: "fire",
    // rust: "air",
    // rust: "earth",
    // rust: "water",
    // rust: "hot",
    // rust: "dry",
    // rust: "cold",
    // rust: "wet",
    // rust: "ignite",
    // rust: "snuff",
    // rust: "embiggen",
    // rust: "twist",
    // rust: "shorten",
    // rust: "stretch",
    // rust: "fiddle",
    // rust: "destroy",
    // rust: "imbue",
    // rust: "galvanize",
    // rust: "enchant",
    // rust: "free",
    // rust: "limited",
    // rust: "range",
    // rust: "of",
    // rust: "towards",
    // rust: "inside",
    // rust: "sphere",
    // rust: "cube",
    // rust: "self",
    // rust: "other",
    // rust: "ball",
    // rust: "mental",
    // rust: "physical",
    // rust: "grow",
    // rust: "shrink",
    // rust: "demon",
    // rust: "elemental",
    // rust: "spirit",
    // rust: "animal",
    // rust: "creature",
    // rust: "beast",
    // rust: "humanoid",
    // rust: "undead",
    // rust: "fresh",
    // rust: "stale",
    // rust: "phnglui",
    // rust: "mglwnafh",
    // rust: "cthulhu",
    // rust: "rlyeh",
    // rust: "wgahnagl",
    // rust: "fhtagn",
    // rust: "baguette",
    // rust: ];
GREY :: 0xFF40_4040
argb :: proc(c: i32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let c = c as u32;
    // rust: rgba(
    // rust: (c >> 16 & 255) as u8,
    // rust: (c >> 8 & 255) as u8,
    // rust: (c & 255) as u8,
    // rust: (c >> 24 & 255) as u8,
    // rust: )
}

// A text style's `0xRRGGBB` colour from a HUD colour (`rgba`).
rgb_of :: proc(rgba: u32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: (rgba & 0xFF) << 16 | (rgba >> 8 & 0xFF) << 8 | (rgba >> 16 & 0xFF)
}
    // rust: impl Game<'_> {
    // `EnchantmentScreen.containerTick`'s `tickBook` for an open enchanting table.
    // rust: pub(super) fn tick_enchanting_book(&mut self) {
    // rust: if let Some(s) = self.station.as_mut().filter(|s| s.kind == Kind::Enchanting) {
    // rust: let costs = s.offers.costs;
    // rust: s.book.tick(s.inputs[0].as_ref(), costs);
}
}
    // `Component.translatable`: the selected language (which `lang` layers
    // over `en_us`), the caller's English text last.
    // rust: pub(super) fn translate(&self, key: &str, fallback: &str) -> String {
    // rust: horizon_client::lang::get_or(key, fallback)
}
brewing_open :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(self.container_kind(), Some(BlockEntity::Brewing(_)))
}
    // Opens a workstation menu for the block; false when it is not one.
    // rust: pub(super) fn open_station(&mut self, pos: [i32; 3], name: &str) -> bool {
    // rust: let Some(kind) = Kind::from_block(name) else {
    // rust: return false;
}
    // rust: if self.level.xp_seed == 0 {
    // rust: self.level.xp_seed = self.world.random.next_int();
}
    // rust: self.station = Some(Station::new(kind, pos));
    // rust: self.station_changed();
    // rust: self.beacon_opened();
        // The block's interaction statistic.
    // rust: let stat = match name {
    // rust: "minecraft:crafting_table" => "interact_with_crafting_table",
    // rust: "minecraft:furnace" => "interact_with_furnace",
    // rust: "minecraft:blast_furnace" => "interact_with_blast_furnace",
    // rust: "minecraft:smoker" => "interact_with_smoker",
    // rust: "minecraft:brewing_stand" => "interact_with_brewingstand",
    // rust: "minecraft:beacon" => "interact_with_beacon",
    // rust: "minecraft:grindstone" => "interact_with_grindstone",
    // rust: "minecraft:smithing_table" => "interact_with_smithing_table",
    // rust: "minecraft:stonecutter" => "interact_with_stonecutter",
    // rust: "minecraft:loom" => "interact_with_loom",
    // rust: "minecraft:cartography_table" => "interact_with_cartography_table",
    // rust: n if n.ends_with("anvil") => "interact_with_anvil",
    // rust: _ => "",
}
    // rust: if !stat.is_empty() {
    // rust: self.award_custom_stat(stat, 1);
}
    // rust: true
}
    // `AbstractContainerMenu.clearContainer`: inputs go back to the player.
    // rust: pub(super) fn close_station(&mut self) {
    // rust: if self
    // rust: .station
    // rust: .as_ref()
    // rust: .is_some_and(|s| s.kind == Kind::Merchant)
    // rust: {
            // MerchantMenu.removed: the carried stack and the payment go back.
    // rust: self.menu_session(|menu, env, _| {
    // rust: menu.merchant_close(env);
    // rust: Some(true)
    // rust: });
}
    // rust: let Some(mut station) = self.station.take() else {
    // rust: return;
}
    // rust: if self.remote.is_some() && station.kind != Kind::Merchant {
            // A server's workstation: its removed() gives the inputs back.
    // rust: return;
}
    // rust: if let Some(m) = station.merchant.as_mut() {
    // rust: self.merchant_closed(m);
}
    // rust: for stack in station.inputs.into_iter().flatten() {
    // rust: self.give_or_drop(stack);
}
}
    // rust: pub(super) fn station_slots(&self) -> Option<Vec<usize>> {
    // rust: let mut v: Vec<usize> = (0..36).collect();
    // rust: if self.brewing_open() {
    // rust: v.extend(300..305);
    // rust: return Some(v);
}
    // rust: let s = self.station.as_ref()?;
    // rust: v.extend((0..s.inputs.len()).map(|i| INPUT + i));
    // rust: if s.kind.result_pos().is_some() {
    // rust: v.push(RESULT);
}
    // rust: Some(v)
}
    // How many slots `station_slots` lists, counted without building it
    // (`Game::slot_count` asks every frame): same branches, same order.
    // rust: pub(super) fn station_slot_count(&self) -> Option<usize> {
    // rust: if self.brewing_open() {
    // rust: return Some(36 + 5);
}
    // rust: let s = self.station.as_ref()?;
    // rust: Some(36 + s.inputs.len() + usize::from(s.kind.result_pos().is_some()))
}
    // rust: pub(super) fn station_slot_position(&self, i: usize) -> Option<(f32, f32)> {
    // rust: if self.brewing_open() && (300..305).contains(&i) {
    // rust: return Some(
    // rust: [
    // rust: (56.0, 51.0),
    // rust: (79.0, 58.0),
    // rust: (102.0, 51.0),
    // rust: (79.0, 17.0),
    // rust: (17.0, 17.0),
    // rust: ][i - 300],
    // rust: );
}
    // rust: let s = self.station.as_ref()?;
    // rust: if s.kind == Kind::Merchant && i < 36 {
    // rust: return Some(super::trading::inventory_slot(i));
}
    // rust: if s.kind == Kind::Beacon {
    // rust: return super::beacon::slot_position(i);
}
    // rust: match i {
    // rust: RESULT => s.kind.result_pos(),
    // rust: _ if i >= INPUT && i < INPUT + s.inputs.len() => Some(s.kind.input_pos(i - INPUT)),
    // rust: _ => None,
}
}
    // rust: pub(super) fn station_slot_mut(&mut self, i: usize) -> &mut Option<ItemStack> {
    // rust: match self.station.as_mut() {
    // rust: Some(s) if i == RESULT => &mut s.result,
    // rust: Some(s) if i >= INPUT && i < INPUT + s.inputs.len() => &mut s.inputs[i - INPUT],
    // rust: _ => &mut self.scratch_slot,
}
}
    // rust: pub(super) fn count_bookshelves(&self, pos: [i32; 3]) -> i32 {
    // rust: let tags = &self.items().block_tags;
    // rust: let is = |p: [i32; 3], tag: &str| {
    // rust: let name = &self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(p[0], p[1], p[2]))
    // rust: .name;
    // rust: tags.get(tag).is_some_and(|t| t.contains(&**name))
}
    // rust: stations::bookshelf_offsets()
    // rust: .into_iter()
    // rust: .filter(|o| {
    // rust: is(
    // rust: [pos[0] + o[0], pos[1] + o[1], pos[2] + o[2]],
    // rust: "minecraft:enchantment_power_provider",
    // rust: ) && is(
    // rust: [pos[0] + o[0] / 2, pos[1] + o[1], pos[2] + o[2] / 2],
    // rust: "minecraft:enchantment_power_transmitter",
    // rust: )
    // rust: })
    // rust: .count() as i32
}
    // The anvil name the menu works with (`AnvilScreen.onNameChanged`).
    // rust: pub(super) fn anvil_item_name(&self, s: &Station) -> String {
    // rust: match &s.inputs[0] {
    // rust: Some(input)
    // rust: if input.custom_name().is_none()
    // rust: && s.name == self.pack.names.display_item(&input.item) =>
    // rust: {
    // rust: String::new()
}
    // rust: Some(_) => s.name.clone(),
    // rust: None => String::new(),
}
}
    // `slotsChanged` / `createResult` for the open station.
    // rust: pub(super) fn station_changed(&mut self) {
    // rust: let Some(mut s) = self.station.take() else {
    // rust: return;
}
    // rust: let creative = self.creative;
    // rust: let data = self.stations();
    // rust: let items = self.items();
    // rust: match s.kind {
            // A server's table: its data slots carry the offers, and its
            // client menu only clears them without an enchantable item.
    // rust: Kind::Enchanting if self.remote.is_some() => {
    // rust: let enchantable = s.inputs[0].as_ref().is_some_and(|i| {
    // rust: data.enchantments.enchantable(&i.item) > 0 && i.enchantments().is_empty()
    // rust: });
    // rust: if !enchantable {
    // rust: s.offers = Default::default();
}
}
    // rust: Kind::Enchanting => {
    // rust: s.bookcases = self.count_bookshelves(s.pos);
    // rust: s.offers = stations::enchant_offers(
    // rust: &data.enchantments,
    // rust: items,
    // rust: self.level.xp_seed,
    // rust: s.bookcases,
    // rust: s.inputs[0].as_ref(),
    // rust: );
}
    // rust: Kind::Anvil => {
    // rust: let name = self.anvil_item_name(&s);
    // rust: let hover = s.inputs[0]
    // rust: .as_ref()
    // rust: .map(|i| stations::hover_name(&|id| self.pack.names.display_item(id), i))
    // rust: .unwrap_or_default();
    // rust: s.anvil = stations::anvil_result(
    // rust: &data.enchantments,
    // rust: items,
    // rust: s.inputs[0].as_ref(),
    // rust: s.inputs[1].as_ref(),
    // rust: Some(&name),
    // rust: &hover,
    // rust: creative,
    // rust: );
    // rust: s.result = s.anvil.result.clone();
}
    // rust: Kind::Grindstone => {
    // rust: s.result = stations::grindstone_result(
    // rust: &data.enchantments,
    // rust: items,
    // rust: s.inputs[0].as_ref(),
    // rust: s.inputs[1].as_ref(),
    // rust: );
}
    // rust: Kind::Smithing => {
    // rust: s.result = data.recipes.smithing_result(
    // rust: &data.enchantments,
    // rust: s.inputs[0].as_ref(),
    // rust: s.inputs[1].as_ref(),
    // rust: s.inputs[2].as_ref(),
    // rust: );
}
            // The menu engine keeps the merchant's result (Game::menu_session).
    // rust: Kind::Merchant => {}
    // rust: Kind::Beacon => {}
            // The menu engine keeps the cartography table's, the loom's and
            // the stonecutter's state (Game::menu_session).
    // rust: Kind::Cartography | Kind::Loom | Kind::Stonecutter => {}
}
    // rust: self.station = Some(s);
}
    // rust: pub(super) fn max_stack(&self, stack: &ItemStack) -> u32 {
    // rust: self.res
    // rust: .items()
    // rust: .get(&stack.item)
    // rust: .map_or(64, |i| i.max_stack)
}
    // `Slot.mayPlace` and `getMaxStackSize` for station slots.
slot_rules :: proc(self: ^Self, slot: uint, stack: ^ItemStack) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: if slot >= super::mount_menu::SADDLE {
    // rust: return self.mount_slot_rules(slot, stack);
}
    // rust: if let Some(BlockEntity::Crafter(c)) = self.container_kind()
    // rust: && (300..309).contains(&slot)
    // rust: {
            // CrafterSlot.mayPlace: not a disabled slot.
    // rust: return (!c.disabled[slot - 300], 64);
}
    // rust: if (300..400).contains(&slot) && !self.brewing_open() && self.refuses(slot, stack) {
            // ShulkerBoxSlot.mayPlace.
    // rust: return (false, 64);
}
    // rust: let Some(s) = self.station.as_ref() else {
    // rust: return (true, 64);
}
    // rust: if slot < 36 {
    // rust: return (true, 64);
}
    // rust: if slot == RESULT {
    // rust: return (false, 64);
}
    // rust: (s.kind != Kind::Loom, 64)
}
    // `AbstractContainerMenu.doClick` PICKUP on a filtered slot.
    // rust: pub(super) fn click_filtered(&mut self, slot: usize, right: bool) {
    // rust: let carried = self.carried.take();
    // rust: let current = self.slot_mut(slot).take();
    // rust: let (new_slot, new_carried) = match (carried, current) {
    // rust: (None, None) => (None, None),
    // rust: (None, Some(mut s)) => {
    // rust: let take = if right { s.count.div_ceil(2) } else { s.count };
    // rust: s.count -= take;
    // rust: let taken = ItemStack {
    // rust: count: take,
    // rust: ..s.clone()
}
    // rust: ((s.count > 0).then_some(s), Some(taken))
}
    // rust: (Some(mut c), None) => {
    // rust: let (ok, cap) = self.slot_rules(slot, &c);
    // rust: if ok {
    // rust: let n = if right { 1 } else { c.count }.min(cap.min(self.max_stack(&c)));
    // rust: let placed = ItemStack {
    // rust: count: n,
    // rust: ..c.clone()
}
    // rust: c.count -= n;
    // rust: (Some(placed), (c.count > 0).then_some(c))
    // rust: } else {
    // rust: (None, Some(c))
}
}
    // rust: (Some(mut c), Some(mut s)) => {
    // rust: let (ok, cap) = self.slot_rules(slot, &c);
    // rust: if ok && c.same_item_same_components(&s) {
    // rust: let room = cap.min(self.max_stack(&s)).saturating_sub(s.count);
    // rust: let n = if right { 1 } else { c.count }.min(room);
    // rust: s.count += n;
    // rust: c.count -= n;
    // rust: (Some(s), (c.count > 0).then_some(c))
    // rust: } else if ok && c.count <= cap.min(self.max_stack(&c)) {
    // rust: (Some(c), Some(s))
    // rust: } else if c.same_item_same_components(&s) {
    // rust: let n = s.count.min(self.max_stack(&c).saturating_sub(c.count));
    // rust: s.count -= n;
    // rust: c.count += n;
    // rust: ((s.count > 0).then_some(s), Some(c))
    // rust: } else {
    // rust: (Some(s), Some(c))
}
}
}
    // rust: *self.slot_mut(slot) = new_slot;
    // rust: self.carried = new_carried;
}
    // `moveItemStackTo` over `targets` (menu order), merging first, then empty slots.
    // rust: pub(super) fn move_to(
    // rust: &mut self,
    // rust: stack: &mut ItemStack,
    // rust: targets: &[usize],
    // rust: reverse: bool,
    // rust: ) -> bool {
    // rust: let order: Vec<usize> = if reverse {
    // rust: targets.iter().rev().copied().collect()
    // rust: } else {
    // rust: targets.to_vec()
}
    // rust: let start = stack.count;
    // rust: if self.max_stack(stack) > 1 {
    // rust: for &t in &order {
    // rust: if stack.count == 0 {
    // rust: break;
}
    // rust: let (_, cap) = self.slot_rules(t, stack);
    // rust: let max = cap.min(self.max_stack(stack));
    // rust: if let Some(s) = self.slot_mut(t).as_mut()
    // rust: && s.same_item_same_components(stack)
    // rust: {
    // rust: let n = max.saturating_sub(s.count).min(stack.count);
    // rust: s.count += n;
    // rust: stack.count -= n;
}
}
}
    // rust: for &t in &order {
    // rust: if stack.count == 0 {
    // rust: break;
}
    // rust: let (ok, cap) = self.slot_rules(t, stack);
    // rust: if self.slot_mut(t).is_none() && (t < 36 || ok) {
    // rust: let n = cap.min(self.max_stack(stack)).min(stack.count);
    // rust: *self.slot_mut(t) = Some(ItemStack {
    // rust: count: n,
    // rust: ..stack.clone()
    // rust: });
    // rust: stack.count -= n;
}
}
    // rust: stack.count != start
}
    // After an anvil or smithing click on the menu engine: the anvil's cost
    // and state back into the station and the rename box following the
    // input (`AnvilScreen.slotChanged`), then the rest of a taken result's
    // `onTake` (the levels, the anvil's wear, the use sound) unless a
    // server does it.
    // rust: pub(super) fn combiner_session_end(
    // rust: &mut self,
    // rust: menu: &horizon_client::menu::Menu,
    // rust: predicting: bool,
    // rust: ) {
    // rust: let Some(s) = self.station.as_mut() else {
    // rust: return;
}
    // rust: let (pos, kind) = (s.pos, s.kind);
    // rust: if kind == Kind::Anvil {
    // rust: s.anvil.cost = menu.data[0];
    // rust: s.anvil.repair_item_count_cost = menu.anvil.repair_count;
    // rust: s.anvil.only_renaming = menu.anvil.only_renaming;
    // rust: s.anvil.result = s.result.clone();
}
    // rust: self.station_after_input();
    // rust: if !menu.combined || predicting {
    // rust: return;
}
    // rust: if kind == Kind::Smithing {
    // rust: self.level_event_at(1044, pos, 0);
    // rust: return;
}
    // rust: self.give_levels(menu.level_change);
    // rust: if self.anvil_used(pos, self.creative) {
    // rust: self.close_station();
    // rust: self.screen = Screen::Playing;
    // rust: self.capture(true);
}
}
    // `AnvilMenu.onTake`'s level part: out of creative a 12% chance
    // (`AnvilBlock.damage`) to wear the anvil a stage, or break a damaged one
    // (level event 1029); otherwise level event 1030. True when it broke.
    // rust: pub(super) fn anvil_used(&mut self, pos: [i32; 3], creative: bool) -> bool {
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: let name = self.res.facts().get(state).name.clone();
    // rust: let anvil = matches!(
    // rust: &*name,
    // rust: "minecraft:anvil" | "minecraft:chipped_anvil" | "minecraft:damaged_anvil"
    // rust: );
    // rust: if !creative && anvil && self.world.random.next_float() < 0.12 {
    // rust: match &*name {
    // rust: "minecraft:anvil" => {
    // rust: let _ = self.set_state_named(pos, "minecraft:chipped_anvil", &["facing"]);
    // rust: self.native_anvil_damaged(self.dim.id(), pos, &name, "minecraft:chipped_anvil");
}
    // rust: "minecraft:chipped_anvil" => {
    // rust: let _ = self.set_state_named(pos, "minecraft:damaged_anvil", &["facing"]);
    // rust: self.native_anvil_damaged(self.dim.id(), pos, &name, "minecraft:damaged_anvil");
}
    // rust: _ => {
    // rust: let _ = self.world.set(pos[0], pos[1], pos[2], self.world.air);
    // rust: self.world.modified.insert((pos[0] >> 4, pos[2] >> 4));
    // rust: self.native_anvil_damaged(self.dim.id(), pos, &name, "minecraft:air");
    // rust: self.level_event_at(1029, pos, 0);
    // rust: return true;
}
}
}
    // rust: self.level_event_at(1030, pos, 0);
    // rust: false
}
    // The grindstone result's `onTake` with a level (`amount`: the menu's
    // `getExperienceAmount` sum): the orbs at the block's centre
    // (`ExperienceOrb.award`), then level event 1042, the grindstone's sound
    // for everyone around.
    // rust: pub(super) fn grindstone_taken(&mut self, pos: [i32; 3], amount: i32) {
    // rust: let xp = stations::grindstone_xp_roll(amount, &mut self.world.random);
    // rust: if xp > 0 {
    // rust: self.spawn_orbs(pos.map(|v| f64::from(v) + 0.5), xp);
}
    // rust: self.level_event_at(1042, pos, 0);
}
play_at :: proc(self: ^Self, sound: string, pos: [i32; 3], volume: f32, pitch: f32) {
}
    // rust: let at = [
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(pos[1]) + 0.5,
    // rust: f64::from(pos[2]) + 0.5,
    // rust: ];
    // rust: self.audio.play(sound, Some(at), volume, pitch);
}
    // rust: pub(super) fn give_or_drop(&mut self, stack: ItemStack) {
    // rust: if let Some(rest) = self.give(stack)
    // rust: && let Some(eye) = self.eye_position()
    // rust: {
            // Inventory.placeItemBackInInventory: `player.drop(stack, false)`.
    // rust: self.throw_from_eyes(rest, eye, false);
}
}
    // `Player.giveExperienceLevels`.
    // rust: pub(super) fn give_levels(&mut self, levels: i32) {
    // rust: let old_level = self.experience.level;
    // rust: let xp = &mut self.experience;
    // rust: xp.level = xp.level.saturating_add(levels);
    // rust: if xp.level < 0 {
    // rust: xp.level = 0;
    // rust: xp.progress = 0.0;
    // rust: xp.total = 0;
}
    // rust: let level = xp.level;
    // rust: self.play_level_up(levels, level);
    // rust: self.native_player_level_changed(old_level);
}
    // `Player.giveExperienceLevels`: all players near its feet hear the sound.
    // rust: pub(super) fn play_level_up(&mut self, amount: i32, level: i32) {
    // rust: if let Some(volume) = self.level_up_sound.give_levels(amount, level) {
    // rust: let at = self
    // rust: .player
    // rust: .as_ref()
    // rust: .map(|p| [p.position.x, p.position.y, p.position.z]);
    // rust: self.audio
    // rust: .play("minecraft:entity.player.levelup", at, volume, 1.0);
}
}
    // Whether the result slot may be taken (`mayPickup`).
may_take_result :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(s) = self.station.as_ref() else {
    // rust: return false;
}
    // rust: match s.kind {
    // rust: Kind::Anvil => {
    // rust: (self.creative || self.experience.level >= s.anvil.cost) && s.anvil.cost > 0
}
    // rust: _ => true,
}
}
    // `EnchantmentMenu.clickMenuButton`.
click_enchant :: proc(self: ^Self, button: uint) {
}
    // rust: let Some(s) = self.station.as_ref() else {
    // rust: return;
}
    // rust: let cost = s.offers.costs[button];
    // rust: let lapis_needed = button as u32 + 1;
    // rust: let Some(item) = s.inputs[0].clone() else {
    // rust: return;
}
    // rust: let lapis = s.inputs[1].as_ref().map_or(0, |l| l.count);
    // rust: if lapis < lapis_needed && !self.creative {
    // rust: return;
}
    // rust: if cost <= 0
    // rust: || (self.experience.level < lapis_needed as i32 || self.experience.level < cost)
    // rust: && !self.creative
    // rust: {
    // rust: return;
}
    // rust: if self.remote.is_some() {
            // EnchantmentScreen.mouseClicked: the client menu took it, the server enchants.
    // rust: self.remote_station_button(button as i32);
    // rust: return;
}
    // rust: let Some(enchanted) = stations::apply_enchantment(
    // rust: &self.stations().enchantments,
    // rust: self.items(),
    // rust: self.level.xp_seed,
    // rust: button,
    // rust: cost,
    // rust: &item,
    // rust: ) else {
    // rust: return;
}
    // rust: let pos = s.pos;
    // rust: let enchanted_item = enchanted.clone();
        // Player.onEnchantmentPerformed
    // rust: self.give_levels(-(lapis_needed as i32));
    // rust: self.level.xp_seed = self.world.random.next_int();
    // rust: if let Some(s) = self.station.as_mut() {
    // rust: s.inputs[0] = Some(enchanted);
    // rust: if !self.creative
    // rust: && let Some(l) = s.inputs[1].as_mut()
    // rust: {
    // rust: l.count -= lapis_needed;
    // rust: if l.count == 0 {
    // rust: s.inputs[1] = None;
}
}
}
    // rust: let pitch = self.world.random.next_float() * 0.1 + 0.9;
    // rust: self.award_custom_stat("enchant_item", 1);
    // rust: self.trigger_enchanted_item(&enchanted_item, lapis_needed as i32);
    // rust: self.play_at("minecraft:block.enchantment_table.use", pos, 1.0, pitch);
    // rust: self.station_changed();
}
    // Mouse click while a station or the brewing stand is open. True when handled.
    // A station's own buttons a controller can focus besides its slots
    // (GUI origin relative): offers, patterns, effects, enchantments and
    // stonecutter recipes.
    // rust: pub(super) fn station_targets(&self) -> Vec<[f32; 4]> {
    // rust: let Some(s) = self.station.as_ref() else {
    // rust: return Vec::new();
}
    // rust: match s.kind {
    // rust: Kind::Merchant => self.merchant_targets(),
    // rust: Kind::Loom => self.loom_targets(),
    // rust: Kind::Beacon => self.beacon_targets(),
    // rust: Kind::Enchanting => (0..3)
    // rust: .map(|i| {
    // rust: let (x, y, w, h) = enchant_button(i);
    // rust: [x, y, w, h]
    // rust: })
    // rust: .collect(),
    // rust: Kind::Stonecutter if s.inputs[0].is_some() => (s.start
    // rust: ..(s.start + 12).min(s.stone.recipes.len()))
    // rust: .map(|index| {
    // rust: let p = index - s.start;
    // rust: [
    // rust: 52.0 + (p % 4) as f32 * 16.0,
    // rust: 14.0 + (p / 4) as f32 * 18.0,
    // rust: 16.0,
    // rust: 18.0,
    // rust: ]
    // rust: })
    // rust: .collect(),
    // rust: _ => Vec::new(),
}
}
    // rust: pub(super) fn station_click(&mut self, right: bool) -> bool {
        // A server's brewing stand: its slots are the server's.
    // rust: if self.station.is_none() && (!self.brewing_open() || self.remote.is_some()) {
    // rust: return false;
}
    // rust: let Some(size) = self
    // rust: .renderer
    // rust: .as_ref()
    // rust: .map(|r| [r.config.width, r.config.height])
    // rust: else {
    // rust: return true;
}
    // rust: let batch = HudBatch::new(size);
    // rust: let (ox, oy) = self.inventory_origin(&batch);
    // rust: let local = (self.cursor.0 - ox, self.cursor.1 - oy);
    // rust: let shift = self.has_shift_down();
    // rust: if let Some(kind) = self.station.as_ref().map(|s| s.kind) {
    // rust: if kind == Kind::Merchant && !right && self.merchant_click(local) {
    // rust: return true;
}
    // rust: if kind == Kind::Merchant && self.remote.is_some() {
                // A server's trading window: its slots are the server's.
    // rust: return false;
}
    // rust: if kind == Kind::Loom && !right && self.loom_click(local) {
    // rust: return true;
}
    // rust: if kind == Kind::Beacon && !right && self.beacon_click(local) {
    // rust: return true;
}
    // rust: if kind == Kind::Enchanting && !right {
    // rust: for i in 0..3 {
    // rust: let (x, y, w, h) = enchant_button(i);
    // rust: if inside(local, x, y, w, h) {
    // rust: self.click_enchant(i);
    // rust: return true;
}
}
}
    // rust: if kind == Kind::Stonecutter && self.stonecutter_click(local) {
    // rust: return true;
}
    // rust: if kind == Kind::Anvil && !right && self.anvil_name_click(ox, oy) {
    // rust: return true;
}
}
    // rust: let Some(slot) = self.slot_at(&batch, self.cursor.0, self.cursor.1) else {
    // rust: return true;
}
        // Every station's clicks (and the brewing stand's) run on the
        // verified menu engine.
    // rust: let input = if shift {
    // rust: horizon_client::menu::Input::QuickMove
    // rust: } else {
    // rust: horizon_client::menu::Input::Pickup
}
    // rust: self.menu_click(Some(slot), i32::from(right), input);
    // rust: true
}
    // Recompute after slot changes; the anvil box follows its input item.
station_after_input :: proc(self: ^Self) {
}
    // rust: let Some(s) = self.station.as_mut() else {
    // rust: return;
}
    // rust: if s.kind == Kind::Anvil && s.inputs[0] != s.anvil_last {
            // AnvilScreen.slotChanged: the box shows the new input's name.
    // rust: s.anvil_last = s.inputs[0].clone();
    // rust: s.name = s.inputs[0]
    // rust: .as_ref()
    // rust: .map(|i| stations::hover_name(&|id| self.pack.names.display_item(id), i))
    // rust: .unwrap_or_default();
    // rust: let name = s.name.clone();
    // rust: s.rename.set_value(&name);
}
    // rust: self.station_changed();
}
    // `StonecutterScreen.mouseClicked` on its recipe grid: `clickMenuButton`
    // with the cell's index (an empty cell's too), and the select sound when
    // the menu took it.
    // Beside the grid, a press on the scroller's track holds it (`scrolling`).
stonecutter_click :: proc(self: ^Self, local: (f32) {
}
    // rust: let Some(s) = self.station.as_mut() else {
    // rust: return false;
}
    // rust: s.scrolling = false;
    // rust: if s.inputs[0].is_some() && !s.stone.recipes.is_empty() {
    // rust: let start = s.start;
    // rust: if self.stonecutter_recipe_click(local, start) {
    // rust: return true;
}
}
    // rust: if inside(local, 119.0, 9.0, 12.0, 54.0)
    // rust: && let Some(s) = self.station.as_mut()
    // rust: {
    // rust: s.scrolling = true;
    // rust: return true;
}
    // rust: false
}
stonecutter_recipe_click :: proc(self: ^Self, local: (f32) {
}
    // rust: for index in start..start + 12 {
    // rust: let p = index - start;
    // rust: let (x, y) = (52.0 + (p % 4) as f32 * 16.0, 14.0 + (p / 4) as f32 * 18.0);
    // rust: if !inside(local, x, y, 16.0, 18.0) {
    // rust: continue;
}
    // rust: let mut taken = false;
    // rust: let flag = &mut taken;
    // rust: self.menu_session(|menu, env, _| {
    // rust: *flag = menu.button(env, index as i32);
    // rust: Some(*flag)
    // rust: });
    // rust: if taken {
    // rust: self.audio
    // rust: .play("minecraft:ui.stonecutter.select_recipe", None, 1.0, 1.0);
    // rust: self.remote_station_button(index as i32);
    // rust: return true;
}
}
    // rust: false
}
    // A D-pad step off the visible rows of a station's list, from the row
    // under the cursor: the list scrolls a row, if it can, and the cursor
    // stays. False leaves the step to go on to whatever is that way.
    // rust: pub(super) fn station_list_step(&mut self, up: bool) -> bool {
    // rust: let Some(batch) = self.gui_scale() else {
    // rust: return false;
}
    // rust: let (ox, oy) = self.inventory_origin(&batch);
    // rust: let local = (self.cursor.0 - ox, self.cursor.1 - oy);
    // rust: if !off_visible_rows(&self.station_targets(), local, up) {
    // rust: return false;
}
    // rust: let shown = |g: &Self| {
    // rust: g.station.as_ref().map(|s| {
    // rust: let merchant = s.merchant.as_ref().map(|m| m.scroll);
    // rust: (s.start, s.loom.start_row, merchant)
    // rust: })
}
    // rust: let before = shown(self);
    // rust: self.station_scroll(if up { 1.0 } else { -1.0 });
    // rust: shown(self) != before
}
    // `StonecutterScreen.mouseScrolled`.
    // rust: pub(super) fn station_scroll(&mut self, d: f32) {
    // rust: self.merchant_scroll(d);
    // rust: self.loom_scroll(d);
    // rust: let Some(s) = self.station.as_mut() else {
    // rust: return;
}
    // rust: if s.kind != Kind::Stonecutter || !s.stonecutter_scrolls() {
    // rust: return;
}
    // rust: let rows = stonecutter_offscreen_rows(s.stone.recipes.len());
    // rust: s.stonecutter_scroll_to(s.scroll - d / rows as f32);
}
    // The mouse moved with a button held on a station: the loom's,
    // stonecutter's and merchant's scrollers follow it.
    // rust: pub(super) fn station_drag(&mut self) {
    // rust: self.loom_drag();
    // rust: self.merchant_drag();
    // rust: let Some(size) = self
    // rust: .renderer
    // rust: .as_ref()
    // rust: .map(|r| [r.config.width, r.config.height])
    // rust: else {
    // rust: return;
}
    // rust: let (_, oy) = self.inventory_origin(&HudBatch::new(size));
    // rust: let y = self.cursor.1 - oy;
        // `StonecutterScreen.mouseDragged`.
    // rust: if let Some(s) = self.station.as_mut()
    // rust: && s.kind == Kind::Stonecutter
    // rust: && s.scrolling
    // rust: && s.stonecutter_scrolls()
    // rust: {
    // rust: s.stonecutter_scroll_to(stonecutter_drag_offs(y));
}
}
    // A mouse button let go: no scroller is held any more.
    // rust: pub(super) fn station_release(&mut self) {
    // rust: self.loom_release();
    // rust: if let Some(s) = self.station.as_mut() {
    // rust: s.scrolling = false;
    // rust: if let Some(m) = s.merchant.as_mut() {
    // rust: m.dragging = false;
}
}
}
    // Whether keyboard text goes to the anvil rename box.
    // rust: pub(super) fn station_typing(&self) -> bool {
    // rust: self.screen == Screen::Inventory
    // rust: && self
    // rust: .station
    // rust: .as_ref()
    // rust: .is_some_and(|s| s.kind == Kind::Anvil && s.inputs[0].is_some())
}
    // rust: pub(super) fn station_text(&mut self, text: Option<&str>, backspace: bool) {
        // The recipe book's search box takes scripted typing too.
    // rust: if self.recipe_search_focused() {
    // rust: self.recipe_text(text, backspace);
    // rust: return;
}
    // rust: let Some(s) = self.station.as_mut() else {
    // rust: return;
}
    // rust: if backspace {
    // rust: s.rename.delete_chars(-1);
    // rust: } else if let Some(t) = text {
    // rust: s.rename.insert_text(t);
}
    // rust: s.name.clone_from(&s.rename.value);
    // rust: self.station_changed();
    // rust: self.remote_anvil_rename();
}
    // `AnvilScreen.keyPressed`: the rename box handles the key.
    // rust: pub(super) fn station_key(&mut self, key: winit::keyboard::KeyCode) -> bool {
    // rust: let (ctrl, shift) = (self.has_control_down(), self.has_shift_down());
    // rust: let Some(s) = self.station.as_mut() else {
    // rust: return false;
}
    // rust: if !s.rename.key(key, ctrl, shift) {
    // rust: return false;
}
    // rust: s.name.clone_from(&s.rename.value);
    // rust: self.station_changed();
    // rust: self.remote_anvil_rename();
    // rust: true
}
    // Ctrl+A/C/V/X in the anvil's rename box (an `EditBox` of 50) or the
    // recipe book's search box.
    // rust: pub(super) fn station_shortcut(&mut self, shortcut: horizon_client::clipboard::EditShortcut) {
    // rust: if self.recipe_search_focused() {
    // rust: self.recipe_shortcut(shortcut);
    // rust: return;
}
    // rust: let Some(s) = self.station.as_mut() else {
    // rust: return;
}
    // rust: if s.rename.shortcut(shortcut, &mut self.clipboard) {
    // rust: s.name.clone_from(&s.rename.value);
    // rust: self.station_changed();
    // rust: self.remote_anvil_rename();
}
}
    // A click in the anvil's name box (`EditBox.onClick`).
anvil_name_click :: proc(self: ^Self, ox: f32, oy: f32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let open = self
    // rust: .station
    // rust: .as_ref()
    // rust: .is_some_and(|s| s.kind == Kind::Anvil && s.inputs[0].is_some());
    // rust: if !open {
    // rust: return false;
}
    // rust: let (x, y, w, h) = (ox + 62.0, oy + 24.0, 103.0, 12.0);
    // rust: let (mx, my) = self.cursor;
    // rust: if mx < x || my < y || mx >= x + w || my >= y + h {
    // rust: return false;
}
    // rust: let shift = self.has_shift_down();
    // rust: let Some(s) = self.station.as_mut() else {
    // rust: return false;
}
    // rust: s.rename.x = x;
    // rust: s.rename.y = y;
    // rust: s.rename.width = w;
    // rust: s.rename.click(&self.gui.atlas, mx, shift, false);
    // rust: true
}
    // AnvilScreen's name box, drawn after the station picture.
draw_anvil_name :: proc(self: ^Self, batch: ^HudBatch, ox: f32, oy: f32) {
}
    // rust: let Some(s) = self.station.as_mut() else {
    // rust: return;
}
    // rust: let edit = &mut s.rename;
    // rust: edit.x = ox + 62.0;
    // rust: edit.y = oy + 24.0;
    // rust: edit.width = 103.0;
    // rust: edit.height = 12.0;
    // rust: edit.bordered = false;
    // rust: edit.focused = true;
    // rust: edit.text_color = u32::MAX;
    // rust: edit.max_length = ANVIL_NAME_CHARS;
    // rust: edit.draw(batch, &self.gui.atlas, None);
}

    // ---------------------------------------------------------------- drawing

    // rust: fn part(
    // rust: batch: &mut HudBatch,
    // rust: atlas: &horizon_client::hud::HudAtlas,
    // rust: name: &str,
    // rust: src: (f32, f32),
    // rust: size: (f32, f32),
    // rust: dst: (f32, f32),
    // rust: ) {
    // rust: if let Some(mut r) = atlas.sprites.get(name).copied() {
    // rust: let (du, dv) = ((r.u1 - r.u0) / r.w as f32, (r.v1 - r.v0) / r.h as f32);
    // rust: r.u0 += src.0 * du;
    // rust: r.v0 += src.1 * dv;
    // rust: r.u1 = r.u0 + size.0 * du;
    // rust: r.v1 = r.v0 + size.1 * dv;
    // rust: batch.rect_uv(dst.0, dst.1, size.0, size.1, r, u32::MAX);
}
}
    // Text in the Standard Galactic alphabet (`minecraft:alt`), cut to `max` pixels.
galactic :: proc(self: ^Self, batch: ^HudBatch, text: string, x: f32, y: f32, max: f32, color: u32) {
}
    // rust: let atlas = &self.gui.atlas;
    // rust: let Some(sheet) = atlas.sprites.get("font/ascii_sga").copied() else {
    // rust: batch.text(atlas, text, x, y, color, false);
    // rust: return;
}
    // rust: let cell = sheet.w / 16;
    // rust: let (px, py) = (
    // rust: (sheet.u0 * atlas.width as f32) as u32,
    // rust: (sheet.v0 * atlas.height as f32) as u32,
    // rust: );
    // rust: let mut cursor = x;
    // rust: for ch in text.chars() {
    // rust: let advance = if ch == ' ' {
    // rust: 4.0
    // rust: } else {
    // rust: let code = ch as u32;
    // rust: if !(0x41..=0x5A).contains(&code) && !(0x61..=0x7A).contains(&code) {
    // rust: continue;
}
    // rust: let (col, row) = (code % 16, code / 16);
    // rust: let (cx, cy) = (px + col * cell, py + row * cell);
    // rust: let used = u32::from(atlas.galactic_widths[code as usize]);
    // rust: let advance = (used as f32 * 8.0 / cell as f32 + 0.5).floor() + 1.0;
    // rust: if cursor + advance - x > max {
    // rust: break;
}
    // rust: let r = horizon_client::hud::Rect {
    // rust: u0: cx as f32 / atlas.width as f32,
    // rust: v0: cy as f32 / atlas.height as f32,
    // rust: u1: (cx + cell) as f32 / atlas.width as f32,
    // rust: v1: (cy + cell) as f32 / atlas.height as f32,
    // rust: w: cell,
    // rust: h: cell,
}
    // rust: batch.rect_uv(cursor, y, 8.0, 8.0, r, color);
    // rust: advance
}
    // rust: if cursor + advance - x > max {
    // rust: break;
}
    // rust: cursor += advance;
}
}
    // Draws the open station or brewing stand screen; false when none is open.
    // rust: pub(super) fn draw_station(&mut self, batch: &mut HudBatch) -> bool {
    // rust: if self
    // rust: .station
    // rust: .as_ref()
    // rust: .is_some_and(|s| s.kind == Kind::Merchant)
    // rust: {
    // rust: return self.draw_merchant(batch);
}
    // rust: if self
    // rust: .station
    // rust: .as_ref()
    // rust: .is_some_and(|s| s.kind == Kind::Beacon)
    // rust: {
    // rust: self.draw_beacon(batch);
    // rust: return true;
}
    // rust: let brewing = self.brewing_open();
    // rust: if self.station.is_none() && !brewing {
    // rust: return false;
}
        // `SmithingScreen.containerTick`: the icons of the empty slots follow the template.
    // rust: let (now, partial) = (self.visual_ticks(), self.clock.camera_fraction() as f32);
    // rust: if let Some(s) = self.station.as_mut().filter(|s| s.kind == Kind::Smithing) {
    // rust: let template = s.inputs[0].as_ref().map(|t| t.item.clone());
    // rust: let (base, base_len, additions, additions_len) =
    // rust: smithing_slot_icons(template.as_deref());
    // rust: let lists: [&[&'static str]; 3] = [
    // rust: &EMPTY_TEMPLATE_ICONS,
    // rust: &base[..base_len],
    // rust: &additions[..additions_len],
    // rust: ];
    // rust: for (cycling, icons) in s.cycling.iter_mut().zip(lists) {
    // rust: cycling.advance(now, icons);
}
}
    // rust: let (ox, oy) = self.inventory_origin(batch);
    // rust: let local = (self.cursor.0 - ox, self.cursor.1 - oy);
    // rust: let mut tooltip: Option<Vec<(horizon_client::text::Text, u32)>> = None;
    // rust: let mut anvil_name = false;
        // Keep item tooltips as stacks until drawing: text alone loses the
        // bundle contents component (including in the player's inventory).
    // rust: let mut tooltip_stack: Option<ItemStack> = None;
    // rust: {
    // rust: let atlas = &self.gui.atlas;
    // rust: batch.fill(
    // rust: atlas,
    // rust: 0.0,
    // rust: 0.0,
    // rust: batch.width,
    // rust: batch.height,
    // rust: rgba(16, 16, 16, 160),
    // rust: );
}
    // rust: let inventory_label = self.translate("container.inventory", "Inventory");
    // rust: if brewing {
    // rust: let Some(BlockEntity::Brewing(b)) = self.container_kind() else {
    // rust: return true;
}
    // rust: let (fuel, total_fuel, brew, total_brew) =
    // rust: (b.fuel, b.total_fuel, b.brew_time, b.total_brew_time);
    // rust: let atlas = &self.gui.atlas;
    // rust: Self::part(
    // rust: batch,
    // rust: atlas,
    // rust: "gui/container/brewing_stand",
    // rust: (0.0, 0.0),
    // rust: (176.0, 166.0),
    // rust: (ox, oy),
    // rust: );
    // rust: let fuel_len = if total_fuel > 0 {
    // rust: ((18 * fuel + total_fuel - 1) / total_fuel).clamp(0, 18)
    // rust: } else {
    // rust: 0
}
    // rust: if fuel_len > 0 {
    // rust: Self::part(
    // rust: batch,
    // rust: atlas,
    // rust: "gui/sprites/container/brewing_stand/fuel_length",
    // rust: (0.0, 0.0),
    // rust: (fuel_len as f32, 4.0),
    // rust: (ox + 60.0, oy + 44.0),
    // rust: );
}
    // rust: if brew > 0 && total_brew > 0 {
    // rust: let len = (28.0 * (1.0 - brew as f32 / total_brew as f32)) as i32;
    // rust: if len > 0 {
    // rust: Self::part(
    // rust: batch,
    // rust: atlas,
    // rust: "gui/sprites/container/brewing_stand/brew_progress",
    // rust: (0.0, 0.0),
    // rust: (9.0, len as f32),
    // rust: (ox + 97.0, oy + 16.0),
    // rust: );
}
    // rust: let bubble = [29, 24, 20, 16, 11, 6, 0][(brew / 2 % 7) as usize] as f32;
    // rust: if bubble > 0.0 {
    // rust: Self::part(
    // rust: batch,
    // rust: atlas,
    // rust: "gui/sprites/container/brewing_stand/bubbles",
    // rust: (0.0, 29.0 - bubble),
    // rust: (12.0, bubble),
    // rust: (ox + 63.0, oy + 14.0 + 29.0 - bubble),
    // rust: );
}
}
    // rust: let default = self.translate("container.brewing", "Brewing Stand");
    // rust: let title = self.remote_menu_title().unwrap_or_else(|| {
    // rust: let named = self
    // rust: .station
    // rust: .as_ref()
    // rust: .and_then(|s| self.world.block_names.get(&(s.pos[0], s.pos[1], s.pos[2])));
    // rust: Text::literal(named.cloned().unwrap_or(default)).resolve_legacy()
    // rust: });
    // rust: super::screen_info::name_container(|| title.plain());
    // rust: let tw = atlas.font.width_text(&title);
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: &title,
    // rust: ox + (176.0 - tw) / 2.0,
    // rust: oy + 6.0,
    // rust: GREY,
    // rust: false,
    // rust: );
    // rust: batch.text(atlas, &inventory_label, ox + 8.0, oy + 72.0, GREY, false);
            // Empty-slot icons.
    // rust: for (i, icon) in [
    // rust: (300, "potion"),
    // rust: (301, "potion"),
    // rust: (302, "potion"),
    // rust: (304, "brewing_fuel"),
    // rust: ] {
    // rust: if self.slot_mut(i).is_none() {
    // rust: let (sx, sy) = self.station_slot_position(i).unwrap_or_default();
    // rust: batch.sprite(
    // rust: &self.gui.atlas,
    // rust: &format!("gui/sprites/container/slot/{icon}"),
    // rust: ox + sx,
    // rust: oy + sy,
    // rust: );
}
}
    // rust: } else if let Some(kind) = self.station.as_ref().map(|s| s.kind) {
            // A server's menu has the title it was given.
    // rust: let title = self
    // rust: .remote_menu_title()
    // rust: .unwrap_or_else(|| Text::literal(self.translate(kind.title_key(), "")));
    // rust: super::screen_info::name_container(|| title.plain());
    // rust: {
    // rust: let atlas = &self.gui.atlas;
    // rust: Self::part(
    // rust: batch,
    // rust: atlas,
    // rust: kind.texture(),
    // rust: (0.0, 0.0),
    // rust: (176.0, 166.0),
    // rust: (ox, oy),
    // rust: );
    // rust: let (tx, ty) = kind.title_pos();
    // rust: batch.text_styled(atlas, &title, ox + tx, oy + ty, GREY, false);
    // rust: batch.text(atlas, &inventory_label, ox + 8.0, oy + 72.0, GREY, false);
}
    // rust: if kind == Kind::Cartography {
    // rust: self.draw_cartography(batch, ox, oy);
}
    // rust: if kind == Kind::Loom {
    // rust: tooltip = self.draw_loom(batch, ox, oy, local);
}
    // rust: let atlas = &self.gui.atlas;
    // rust: let s = self.station.as_ref().expect("open station");
    // rust: let has_input = s.inputs.iter().any(Option::is_some);
    // rust: match kind {
    // rust: Kind::Enchanting => {
    // rust: let (open, flip) = s.book.at(self.clock.camera_fraction() as f32);
    // rust: horizon_client::item_render::gui::draw_enchanting_book(
    // rust: &self.pack.item_renderer,
    // rust: &atlas.sprites,
    // rust: batch,
    // rust: ox + 14.0,
    // rust: oy + 14.0,
    // rust: open,
    // rust: flip,
    // rust: );
    // rust: if s.inputs[1].is_none() {
    // rust: batch.sprite(
    // rust: atlas,
    // rust: "gui/sprites/container/slot/lapis_lazuli",
    // rust: ox + 35.0,
    // rust: oy + 47.0,
    // rust: );
}
    // rust: let mut names = LegacyRandom::new(i64::from(self.level.xp_seed));
    // rust: let gold = s.inputs[1].as_ref().map_or(0, |l| l.count as i32);
    // rust: let level = self.experience.level;
    // rust: let offers = s.offers.clone();
    // rust: for i in 0..3 {
    // rust: let (bx, by, bw, bh) = enchant_button(i);
    // rust: let cost = offers.costs[i];
    // rust: if cost == 0 {
    // rust: batch.sprite_scaled(
    // rust: atlas,
    // rust: "gui/sprites/container/enchanting_table/enchantment_slot_disabled",
    // rust: ox + bx,
    // rust: oy + by,
    // rust: bw,
    // rust: bh,
    // rust: u32::MAX,
    // rust: );
    // rust: continue;
}
    // rust: let cost_text = cost.to_string();
    // rust: let text_width = 86.0 - HudBatch::text_width(atlas, &cost_text);
    // rust: let count = names.next_int_bound(2).unwrap_or(0) + 3;
    // rust: let words: Vec<&str> = (0..count)
    // rust: .map(|_| {
    // rust: WORDS
    // rust: [names.next_int_bound(WORDS.len() as i32).unwrap_or(0) as usize]
    // rust: })
    // rust: .collect();
    // rust: let message = words.join(" ");
    // rust: let disabled = (gold < i as i32 + 1 || level < cost) && !self.creative;
    // rust: let col: i32 = if disabled {
    // rust: batch.sprite_scaled(
    // rust: atlas,
    // rust: "gui/sprites/container/enchanting_table/enchantment_slot_disabled",
    // rust: ox + bx,
    // rust: oy + by,
    // rust: bw,
    // rust: bh,
    // rust: u32::MAX,
    // rust: );
    // rust: batch.sprite(
    // rust: atlas,
    // rust: &format!(
    // rust: "gui/sprites/container/enchanting_table/level_{}_disabled",
    // rust: i + 1
    // rust: ),
    // rust: ox + bx + 1.0,
    // rust: oy + by + 1.0,
    // rust: );
    // rust: let c = ((-9937334i32) & 16711422) >> 1;
    // rust: let msg_color = argb(c | 0xFF00_0000u32 as i32);
    // rust: self.galactic_deferred(
    // rust: batch,
    // rust: &message,
    // rust: ox + bx + 20.0,
    // rust: oy + by + 2.0,
    // rust: text_width,
    // rust: msg_color,
    // rust: );
    // rust: -12550384
    // rust: } else {
    // rust: let hover = inside(local, bx, by, bw, bh);
    // rust: let sprite = if hover {
    // rust: "enchantment_slot_highlighted"
    // rust: } else {
    // rust: "enchantment_slot"
}
    // rust: batch.sprite_scaled(
    // rust: atlas,
    // rust: &format!("gui/sprites/container/enchanting_table/{sprite}"),
    // rust: ox + bx,
    // rust: oy + by,
    // rust: bw,
    // rust: bh,
    // rust: u32::MAX,
    // rust: );
    // rust: batch.sprite(
    // rust: atlas,
    // rust: &format!("gui/sprites/container/enchanting_table/level_{}", i + 1),
    // rust: ox + bx + 1.0,
    // rust: oy + by + 1.0,
    // rust: );
    // rust: let msg_color = if hover { -128 } else { -9937334 };
    // rust: self.galactic_deferred(
    // rust: batch,
    // rust: &message,
    // rust: ox + bx + 20.0,
    // rust: oy + by + 2.0,
    // rust: text_width,
    // rust: argb(msg_color),
    // rust: );
    // rust: -8323296
}
    // rust: let atlas = &self.gui.atlas;
    // rust: let cw = HudBatch::text_width(atlas, &cost_text);
    // rust: batch.text(
    // rust: atlas,
    // rust: &cost_text,
    // rust: ox + bx + 20.0 + 86.0 - cw,
    // rust: oy + by + 9.0,
    // rust: argb(col),
    // rust: true,
    // rust: );
                        // Tooltip with the clue (EnchantmentScreen.extractRenderState).
    // rust: if inside(local, bx, by, bw, 17.0)
    // rust: && let Some((id, l)) = &offers.clues[i]
    // rust: {
    // rust: let e = self.enchantments();
    // rust: let (name, _) = e.full_name(id, *l);
    // rust: let clue = self
    // rust: .translate("container.enchant.clue", "%s . . . ?")
    // rust: .replace("%s", &name);
    // rust: let mut lines =
    // rust: vec![(horizon_client::text::Text::literal(clue), u32::MAX)];
    // rust: if !self.creative {
    // rust: lines.push((horizon_client::text::Text::literal(""), u32::MAX));
    // rust: if level < cost {
    // rust: lines.push((
    // rust: horizon_client::text::Text::literal(
    // rust: self.translate(
    // rust: "container.enchant.level.requirement",
    // rust: "Level Requirement: %s",
    // rust: )
    // rust: .replace("%s", &cost.to_string()),
    // rust: ),
    // rust: rgba(255, 85, 85, 255),
    // rust: ));
    // rust: } else {
    // rust: let n = i + 1;
    // rust: let lapis = if n == 1 {
    // rust: self.translate(
    // rust: "container.enchant.lapis.one",
    // rust: "1 Lapis Lazuli",
    // rust: )
    // rust: } else {
    // rust: self.translate(
    // rust: "container.enchant.lapis.many",
    // rust: "%s Lapis Lazuli",
    // rust: )
    // rust: .replace("%s", &n.to_string())
}
    // rust: lines.push((
    // rust: horizon_client::text::Text::literal(lapis),
    // rust: if gold >= n as i32 {
    // rust: rgba(170, 170, 170, 255)
    // rust: } else {
    // rust: rgba(255, 85, 85, 255)
    // rust: },
    // rust: ));
    // rust: let levels = if n == 1 {
    // rust: self.translate(
    // rust: "container.enchant.level.one",
    // rust: "1 Enchantment Level",
    // rust: )
    // rust: } else {
    // rust: self.translate(
    // rust: "container.enchant.level.many",
    // rust: "%s Enchantment Levels",
    // rust: )
    // rust: .replace("%s", &n.to_string())
}
    // rust: lines.push((
    // rust: horizon_client::text::Text::literal(levels),
    // rust: rgba(170, 170, 170, 255),
    // rust: ));
}
}
    // rust: tooltip = Some(lines);
}
}
}
    // rust: Kind::Anvil => {
    // rust: let field = if s.inputs[0].is_some() {
    // rust: "text_field"
    // rust: } else {
    // rust: "text_field_disabled"
}
    // rust: batch.sprite_scaled(
    // rust: atlas,
    // rust: &format!("gui/sprites/container/anvil/{field}"),
    // rust: ox + 59.0,
    // rust: oy + 20.0,
    // rust: 110.0,
    // rust: 16.0,
    // rust: u32::MAX,
    // rust: );
    // rust: if has_input && s.result.is_none() {
    // rust: batch.sprite(
    // rust: atlas,
    // rust: "gui/sprites/container/anvil/error",
    // rust: ox + 99.0,
    // rust: oy + 45.0,
    // rust: );
}
    // rust: if s.inputs[0].is_some() {
                        // Drawn once this borrow of the station ends.
    // rust: anvil_name = true;
}
    // rust: let cost = s.anvil.cost;
    // rust: if cost > 0 {
    // rust: let mut color = argb(-8323296);
    // rust: let line = if cost >= 40 && !self.creative {
    // rust: color = argb(-40864);
    // rust: Some(self.translate("container.repair.expensive", "Too Expensive!"))
    // rust: } else if s.result.is_none() {
    // rust: None
    // rust: } else {
    // rust: if !self.may_take_result() {
    // rust: color = argb(-40864);
}
    // rust: Some(
    // rust: self.translate("container.repair.cost", "Enchantment Cost: %1$s")
    // rust: .replace("%1$s", &cost.to_string()),
    // rust: )
}
    // rust: if let Some(line) = line {
    // rust: let atlas = &self.gui.atlas;
    // rust: let tw = HudBatch::text_width(atlas, &line);
    // rust: let tx = 176.0 - 8.0 - tw - 2.0;
    // rust: batch.fill(
    // rust: atlas,
    // rust: ox + tx - 2.0,
    // rust: oy + 67.0,
    // rust: 176.0 - 8.0 - (tx - 2.0),
    // rust: 12.0,
    // rust: argb(1325400064),
    // rust: );
    // rust: batch.text(atlas, &line, ox + tx, oy + 69.0, color, true);
}
}
}
    // rust: Kind::Grindstone => {
    // rust: if has_input && s.result.is_none() {
    // rust: batch.sprite(
    // rust: atlas,
    // rust: "gui/sprites/container/grindstone/error",
    // rust: ox + 92.0,
    // rust: oy + 31.0,
    // rust: );
}
}
    // rust: Kind::Smithing => {
    // rust: self.draw_smithing_armor_stand(
    // rust: batch,
    // rust: s.result.as_ref(),
    // rust: [ox + 121.0, oy + 20.0, ox + 161.0, oy + 80.0],
    // rust: );
    // rust: let mut onboarding: Option<String> = None;
                    // `CyclingSlotBackground.extractRenderState`: an empty slot shows the
                    // icons of what the template in the table takes.
    // rust: for (i, cycling) in s.cycling.iter().enumerate() {
    // rust: if s.inputs[i].is_some() {
    // rust: continue;
}
    // rust: let (sx, sy) = kind.input_pos(i);
    // rust: for (icon, alpha) in cycling.shown(partial) {
    // rust: batch.sprite_scaled(
    // rust: atlas,
    // rust: &format!("gui/sprites/container/slot/{icon}"),
    // rust: ox + sx,
    // rust: oy + sy,
    // rust: 16.0,
    // rust: 16.0,
    // rust: ((alpha.clamp(0.0, 1.0) * 255.0).round() as u32) << 24
    // rust: | 0x00FF_FFFF,
    // rust: );
}
}
    // rust: if s.inputs.iter().all(Option::is_some) && s.result.is_none() {
    // rust: batch.sprite(
    // rust: atlas,
    // rust: "gui/sprites/container/smithing/error",
    // rust: ox + 65.0,
    // rust: oy + 46.0,
    // rust: );
    // rust: if inside(local, 65.0, 46.0, 28.0, 21.0) {
    // rust: onboarding = Some(self.translate(
    // rust: "container.upgrade.error_tooltip",
    // rust: "Item can't be upgraded this way",
    // rust: ));
}
}
                    // SmithingScreen.extractOnboardingTooltips: an empty template
                    // slot asks for a template; an empty base or addition slot says
                    // what the template wants there.
    // rust: let hovered = (0..3).find(|&i| {
                        // AbstractContainerScreen.isHovering: a pixel round the slot.
    // rust: let (sx, sy) = kind.input_pos(i);
    // rust: inside(local, sx - 1.0, sy - 1.0, 18.0, 18.0)
    // rust: });
    // rust: match (hovered, &s.inputs[0]) {
    // rust: (Some(0), None) => {
    // rust: onboarding = Some(self.translate(
    // rust: "container.upgrade.missing_template_tooltip",
    // rust: "Add Smithing Template",
    // rust: ));
}
    // rust: (Some(slot @ (1 | 2)), Some(template))
    // rust: if s.inputs[slot].is_none()
    // rust: && template.item.ends_with("_smithing_template") =>
    // rust: {
    // rust: let name = if &*template.item
    // rust: == "minecraft:netherite_upgrade_smithing_template"
    // rust: {
    // rust: "netherite_upgrade"
    // rust: } else {
    // rust: "armor_trim"
}
    // rust: let what = if slot == 1 { "base" } else { "additions" };
    // rust: let key = format!(
    // rust: "item.minecraft.smithing_template.{name}.{what}_slot_description"
    // rust: );
    // rust: onboarding = Some(self.translate(&key, &key));
}
    // rust: _ => {}
}
    // rust: if let Some(text) = onboarding {
                        // font.split(component, 115).
    // rust: tooltip = Some(
    // rust: self.gui
    // rust: .atlas
    // rust: .font
    // rust: .split_lines(&horizon_client::text::Text::literal(text), 115.0)
    // rust: .into_iter()
    // rust: .map(|(line, _)| (line, u32::MAX))
    // rust: .collect(),
    // rust: );
}
}
    // rust: Kind::Merchant | Kind::Beacon | Kind::Cartography | Kind::Loom => {}
    // rust: Kind::Stonecutter => {
    // rust: let display = s.inputs[0].is_some() && !s.stone.recipes.is_empty();
    // rust: let active = display && s.stone.recipes.len() > 12;
    // rust: let offs = if active { s.scroll } else { 0.0 };
    // rust: let scroller = if active {
    // rust: "scroller"
    // rust: } else {
    // rust: "scroller_disabled"
}
    // rust: batch.sprite(
    // rust: atlas,
    // rust: &format!("gui/sprites/container/stonecutter/{scroller}"),
    // rust: ox + 119.0,
    // rust: oy + 15.0 + (41.0 * offs).floor(),
    // rust: );
    // rust: if display {
    // rust: let (start, selected) = (s.start, s.selected);
                        // graphics.item: the icon only, without the count.
    // rust: let shown: Vec<(usize, ItemStack)> = (start
    // rust: ..(start + 12).min(s.stone.recipes.len()))
    // rust: .map(|i| {
    // rust: (
    // rust: i,
    // rust: ItemStack {
    // rust: count: 1,
    // rust: ..self.stations().recipes.stonecutting[s.stone.recipes[i]]
    // rust: .result
    // rust: .clone()
    // rust: },
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: for (index, result) in shown {
    // rust: let p = index - start;
    // rust: let (x, y) = (
    // rust: 52.0 + (p % 4) as f32 * 16.0,
    // rust: 14.0 + (p / 4) as f32 * 18.0 + 2.0,
    // rust: );
    // rust: let hover = inside(local, x, y, 16.0, 18.0);
    // rust: let sprite = if Some(index) == selected {
    // rust: "recipe_selected"
    // rust: } else if hover {
    // rust: "recipe_highlighted"
    // rust: } else {
    // rust: "recipe"
}
    // rust: batch.sprite_scaled(
    // rust: &self.gui.atlas,
    // rust: &format!("gui/sprites/container/stonecutter/{sprite}"),
    // rust: ox + x,
    // rust: oy + y - 1.0,
    // rust: 16.0,
    // rust: 18.0,
    // rust: u32::MAX,
    // rust: );
    // rust: self.draw_item(batch, &result, ox + x, oy + y);
    // rust: if hover {
    // rust: tooltip_stack = Some(result);
}
}
}
}
}
}
    // rust: if anvil_name {
    // rust: self.draw_anvil_name(batch, ox, oy);
}
    // rust: let drag = self.drag_view();
    // rust: self.draw_hovered_slot_highlight(batch, false, ox, oy);
    // rust: for i in self.station_slots().unwrap_or_default() {
    // rust: let Some((sx, sy)) = self.slot_position_any(i) else {
    // rust: continue;
}
    // rust: let stack = self.slot_mut(i).clone();
    // rust: self.draw_slot_item(batch, drag.as_ref(), i, &stack, ox + sx, oy + sy);
}
    // rust: self.draw_hovered_slot_highlight(batch, true, ox, oy);
    // rust: if let Some(slot) = self.slot_at(batch, self.cursor.0, self.cursor.1)
    // rust: && tooltip.is_none()
    // rust: && tooltip_stack.is_none()
    // rust: && let Some(stack) = self.slot_mut(slot).clone()
    // rust: && self.tooltip_with_carried(&stack)
    // rust: {
    // rust: tooltip_stack = Some(stack);
}
    // rust: if self.carried.is_some() {
    // rust: self.draw_carried(batch);
    // rust: if let Some(stack) = tooltip_stack.filter(|s| self.tooltip_with_carried(s)) {
    // rust: self.draw_stack_tooltip(batch, &stack, self.cursor.0, self.cursor.1);
}
    // rust: } else if let Some(stack) = tooltip_stack {
    // rust: self.draw_stack_tooltip(batch, &stack, self.cursor.0, self.cursor.1);
    // rust: } else if let Some(lines) = tooltip {
    // rust: self.draw_tooltip_lines(batch, &lines, self.cursor.0, self.cursor.1);
}
    // rust: true
}
    // rust: fn galactic_deferred(
    // rust: &self,
    // rust: batch: &mut HudBatch,
    // rust: text: &str,
    // rust: x: f32,
    // rust: y: f32,
    // rust: max: f32,
    // rust: color: u32,
    // rust: ) {
    // rust: self.galactic(batch, text, x, y, max, color);
}
slot_position_any :: proc(self: ^Self, i: uint) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.station_slot_position(i)
    // rust: .or_else(|| (i < 36).then(|| self.slot_position(i)))
}

    // ---------------------------------------------------------------- tooltips

    // `ItemStack.getTooltipLines` subset: name in rarity colour, lore,
    // potion effects, enchantments (gray, curses red), stored enchantments, trims.
    // rust: pub(super) fn stack_tooltip(
    // rust: &self,
    // rust: stack: &ItemStack,
    // rust: ) -> Vec<(horizon_client::text::Text, u32)> {
    // rust: self.stack_tooltip_lines(stack, false, false)
}
    // `ItemStack.getRarity`'s colour for the name line and a `[name]` link.
rarity_color :: proc(self: ^Self, stack: ^ItemStack) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let props = self.stations().enchantments.props(&stack.item);
    // rust: let rarity = horizon_client::item_tooltip::rarity(
    // rust: stack,
    // rust: props.map_or("common", |p| p.rarity.as_str()),
    // rust: );
    // rust: match rarity {
    // rust: "uncommon" => rgba(255, 255, 85, 255),
    // rust: "rare" => rgba(85, 255, 255, 255),
    // rust: "epic" => rgba(255, 85, 255, 255),
    // rust: _ => u32::MAX,
}
}
    // `ItemStack.getHoverName`: the custom name, a written book's title, the
    // item name component, else the item's or potion's name.
stack_hover_name :: proc(self: ^Self, stack: ^ItemStack) -> S {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(n) = stack.custom_name() {
    // rust: n.to_owned()
    // rust: } else if let Some(title) = stack
    // rust: .data()
    // rust: .and_then(|d| d.written.as_ref())
    // rust: .map(|w| w.title.as_str())
    // rust: .filter(|t| !t.trim().is_empty())
    // rust: {
    // rust: title.to_owned()
    // rust: } else if let Some(n) = stack.item_name() {
    // rust: n
    // rust: } else if stack.data().is_some_and(|d| d.ominous_banner) {
    // rust: self.translate("block.minecraft.ominous_banner", "Ominous Banner")
    // rust: } else if stack.data().and_then(|d| d.potion.as_ref()).is_some()
    // rust: || stack.item.ends_with("potion")
    // rust: || &*stack.item == "minecraft:tipped_arrow"
    // rust: {
    // rust: let key = brewing::potion_name_key(&stack.item, stack.potion());
    // rust: self.pack
    // rust: .names
    // rust: .display_get(&key)
    // rust: .unwrap_or_else(|| self.pack.names.display_item(&stack.item))
    // rust: } else if let Some(head) = horizon_client::item_tooltip::player_head_name(stack) {
    // rust: head.title(&|key| self.pack.names.display_get(key))
    // rust: } else {
    // rust: self.pack.names.display_item(&stack.item)
}
}
    // `ItemStack.getTooltipLines`. A `nested` stack is a crossbow's
    // projectile: `ChargedProjectiles.addProjectileTooltip` takes its details
    // without the name, the player and the advanced flag. `creative` is
    // `TooltipFlag.isCreative`: a creative tab's own slot.
    // rust: fn stack_tooltip_lines(
    // rust: &self,
    // rust: stack: &ItemStack,
    // rust: nested: bool,
    // rust: creative: bool,
    // rust: ) -> Vec<(horizon_client::text::Text, u32)> {
    // rust: let e: &Enchantments = self.enchantments();
    // rust: let color = self.rarity_color(stack);
    // rust: let advanced = !nested && self.options_advanced_tooltips();
    // rust: let display = horizon_client::item_tooltip::TooltipDisplay::for_stack(stack);
    // rust: let mut lines = Vec::new();
    // rust: if !nested && display.name_visible(self.screen == Screen::Creative) {
    // rust: let name =
    // rust: horizon_client::item_tooltip::styled_name(stack, || self.stack_hover_name(stack));
    // rust: lines.push((name, color));
}
    // rust: let translate = |k: &str| self.pack.names.display_get(k);
    // rust: let push = |lines: &mut Vec<(horizon_client::text::Text, u32)>, s: String, c: u32| {
    // rust: lines.push((horizon_client::text::Text::legacy(&s), c));
}
    // rust: let gray = rgba(170, 170, 170, 255);
    // rust: let item_info = self.items().get(&stack.item);
        // SmithingTemplateItem.appendHoverText: `Item.appendHoverText` comes
        // before the components.
    // rust: for (text, c) in horizon_client::item_tooltip::smithing_template_lines(stack, &translate) {
    // rust: push(&mut lines, text, c);
}
        // DiscFragmentItem.appendHoverText.
    // rust: if let Some(text) = horizon_client::item_tooltip::disc_fragment_line(stack, &translate) {
    // rust: push(&mut lines, text, gray);
}
        // HangingEntityItem.appendHoverText: a painting's variant, its title,
        // author and size, or in a creative tab "Random variant".
    // rust: if &*stack.item == "minecraft:painting" && display.shows("minecraft:painting/variant") {
//             use horizon_client::text::Text;
    // rust: if let Some(v) = self.painting_variants.of_stack(stack) {
    // rust: for part in [&v.title, &v.author].into_iter().flatten() {
    // rust: let text = horizon_client::component::to_text(part, &mut |_| Text::empty());
    // rust: lines.push((text, u32::MAX));
}
    // rust: let size = [v.width, v.height].map(|n| Text::literal(n.to_string()));
    // rust: lines.push((Text::translate("painting.dimensions", &size), u32::MAX));
    // rust: } else if creative
    // rust: && stack
    // rust: .data()
    // rust: .and_then(|d| d.other("minecraft:painting/variant"))
    // rust: .is_none()
    // rust: {
    // rust: let random = Text::translate("painting.random", &[]);
    // rust: lines.push((random.with_color(horizon_client::text::GRAY), u32::MAX));
}
}
        // TropicalFish.Pattern.addToTooltip.
    // rust: for text in horizon_client::item_tooltip::tropical_fish_lines(stack, &display) {
    // rust: lines.push((text, gray));
}
        // InstrumentComponent.addToTooltip.
    // rust: if let Some(text) =
    // rust: horizon_client::item_tooltip::instrument_line(stack, &display, &translate)
    // rust: {
    // rust: push(&mut lines, text, gray);
}
        // MapId.addToTooltip: the saved data's lock and scale, when it is known.
    // rust: let map = stack
    // rust: .data()
    // rust: .and_then(|d| d.map_id)
    // rust: .and_then(|id| self.maps.data.get(&id))
    // rust: .map(|m| (m.locked, m.scale));
    // rust: for text in
    // rust: horizon_client::item_tooltip::map_id_lines(stack, &display, advanced, map, &translate)
    // rust: {
    // rust: push(&mut lines, text, gray);
}
        // Bees.addToTooltip.
    // rust: if let Some(text) = horizon_client::item_tooltip::bees_line(stack, &display, &translate) {
    // rust: push(&mut lines, text, gray);
}
        // ItemContainerContents.addToTooltip.
    // rust: let hover_name = |s: &ItemStack| {
    // rust: s.custom_name()
    // rust: .or_else(|| s.item_name())
    // rust: .unwrap_or_else(|| self.pack.names.display_item(&s.item))
}
    // rust: if display.shows("minecraft:container") {
    // rust: for text in
    // rust: horizon_client::item_tooltip::container_lines(stack, &hover_name, &translate)
    // rust: {
    // rust: push(&mut lines, text, u32::MAX);
}
}
        // BannerPatternLayers.addToTooltip: up to six layer names.
    // rust: if display.shows("minecraft:banner_patterns") {
    // rust: for layer in horizon_client::banner::tooltip_layers(stack).iter().take(6) {
    // rust: let key = self.stations().banners.layer_key(layer);
    // rust: push(
    // rust: &mut lines,
    // rust: self.translate(&key, &key),
    // rust: rgba(170, 170, 170, 255),
    // rust: );
}
}
        // WrittenBookContent.addToTooltip.
    // rust: for text in horizon_client::item_tooltip::written_book_lines(stack, &display, &translate) {
    // rust: push(&mut lines, text, gray);
}
        // ChargedProjectiles.addToTooltip: each run of equal projectiles, then
        // the projectile's own details indented under it.
    // rust: if display.shows("minecraft:charged_projectiles") {
    // rust: let charged = stack.data().map_or(&[][..], |d| &d.charged[..]);
    // rust: for run in charged.chunk_by(|a, b| a.same_item_same_components(b)) {
    // rust: let projectile = &run[0];
    // rust: let name = self.stack_hover_name(projectile);
    // rust: let line = if run.len() == 1 {
                    // `getDisplayName`: `[name]` in the rarity colour.
    // rust: let mut shown = horizon_client::text::Text::literal(format!("[{name}]"))
    // rust: .with_color(rgb_of(self.rarity_color(projectile)));
    // rust: if projectile.custom_name().is_some() {
    // rust: shown = shown.italic();
}
    // rust: horizon_client::text::format_translation(
    // rust: &self.translate(
    // rust: "item.minecraft.crossbow.projectile.single",
    // rust: "Projectile: %s",
    // rust: ),
    // rust: &[shown],
    // rust: )
    // rust: } else {
    // rust: horizon_client::text::format_translation(
    // rust: &self.translate(
    // rust: "item.minecraft.crossbow.projectile.multiple",
    // rust: "Projectile: %s x %s",
    // rust: ),
    // rust: &[
    // rust: horizon_client::text::Text::literal(run.len().to_string()),
    // rust: horizon_client::text::Text::literal(name),
    // rust: ],
    // rust: )
}
    // rust: lines.push((line, u32::MAX));
    // rust: for (text, c) in self.stack_tooltip_lines(projectile, true, false) {
                    // `literal("  ").append(line).withStyle(GRAY)`: the line's
                    // own colours win over the gray.
    // rust: let rgb = if c == u32::MAX {
    // rust: horizon_client::text::GRAY
    // rust: } else {
    // rust: rgb_of(c)
}
    // rust: let indented = horizon_client::text::Text::literal("  ")
    // rust: .append(text)
    // rust: .with_color(rgb);
    // rust: lines.push((indented, u32::MAX));
}
}
}
        // Fireworks / FireworkExplosion.addToTooltip.
    // rust: for text in horizon_client::item_tooltip::firework_lines(stack, &translate) {
    // rust: push(&mut lines, text, rgba(170, 170, 170, 255));
}
    // rust: if display.shows("minecraft:potion_contents")
    // rust: && (stack.item.ends_with("potion") || &*stack.item == "minecraft:tipped_arrow")
    // rust: {
    // rust: let scale = match &*stack.item {
    // rust: "minecraft:lingering_potion" => 0.25,
    // rust: "minecraft:tipped_arrow" => 0.125,
    // rust: _ => 1.0,
}
            // PotionContents.getPotionDescription: the effect names are
            // translatable, read in the selected language like every other line.
    // rust: for (text, cat) in brewing::tooltip(stack.potion(), scale, &translate) {
    // rust: let c = match cat {
    // rust: brewing::Category::Beneficial => rgba(85, 85, 255, 255),
    // rust: brewing::Category::Harmful => rgba(255, 85, 85, 255),
    // rust: brewing::Category::Neutral => rgba(170, 170, 170, 255),
}
    // rust: push(&mut lines, text, c);
}
            // The attribute modifiers of the effects (`When Applied:`).
    // rust: for (text, c) in horizon_client::item_tooltip::potion_modifier_lines(stack, &translate)
    // rust: {
    // rust: push(&mut lines, text, c);
}
}
        // JukeboxPlayable.addToTooltip.
    // rust: if let Some(text) =
    // rust: horizon_client::item_tooltip::jukebox_line(stack, item_info, &display, &translate)
    // rust: {
    // rust: push(&mut lines, text, gray);
}
    // rust: if display.shows("minecraft:trim")
    // rust: && let Some((material, pattern)) = stack.data().and_then(|d| d.trim.clone())
    // rust: {
    // rust: push(
    // rust: &mut lines,
    // rust: translate("item.minecraft.smithing_template.upgrade")
    // rust: .unwrap_or_else(|| "Upgrade:".to_owned()),
    // rust: rgba(170, 170, 170, 255),
    // rust: );
    // rust: let short = |s: &str| s.trim_start_matches("minecraft:").to_owned();
    // rust: let p = translate(&format!("trim_pattern.minecraft.{}", short(&pattern)))
    // rust: .unwrap_or_else(|| short(&pattern));
    // rust: let m = translate(&format!("trim_material.minecraft.{}", short(&material)))
    // rust: .unwrap_or_else(|| short(&material));
    // rust: push(&mut lines, format!(" {p}"), rgba(170, 170, 170, 255));
    // rust: push(&mut lines, format!(" {m}"), rgba(170, 170, 170, 255));
}
    // rust: if display.shows("minecraft:stored_enchantments") {
    // rust: for (text, curse) in e.tooltip(stack.stored_enchantments()) {
    // rust: push(
    // rust: &mut lines,
    // rust: text,
    // rust: if curse {
    // rust: rgba(255, 85, 85, 255)
    // rust: } else {
    // rust: rgba(170, 170, 170, 255)
    // rust: },
    // rust: );
}
}
    // rust: if display.shows("minecraft:enchantments") {
    // rust: for (text, curse) in e.tooltip(stack.enchantments()) {
    // rust: push(
    // rust: &mut lines,
    // rust: text,
    // rust: if curse {
    // rust: rgba(255, 85, 85, 255)
    // rust: } else {
    // rust: rgba(170, 170, 170, 255)
    // rust: },
    // rust: );
}
}
        // DyedItemColor.addToTooltip.
    // rust: if let Some((text, italic)) =
    // rust: horizon_client::item_tooltip::dyed_line(stack, &display, advanced, &translate)
    // rust: {
    // rust: let text = horizon_client::text::Text::legacy(&text);
    // rust: lines.push((if italic { text.italic() } else { text }, gray));
}
        // ItemLore.addToTooltip: after the enchantments, before the attributes
        // (ItemStack.addDetailsToTooltip).
    // rust: if display.shows("minecraft:lore") {
    // rust: for text in horizon_client::item_tooltip::lore_texts(stack) {
    // rust: lines.push((text, u32::MAX));
}
}
    // rust: if display.shows("minecraft:attribute_modifiers") {
            // The item's own modifiers, then its enchantments' for each slot
            // group (`ItemStack.forEachModifier`).
    // rust: let mut modifiers = item_info.map(|i| i.modifiers.clone()).unwrap_or_default();
    // rust: modifiers.extend(e.modifier_rows(stack));
    // rust: let base = |name: &str, default| {
    // rust: self.player
    // rust: .as_ref()
    // rust: .and_then(|player| {
    // rust: let key = player.attributes.key(name)?;
    // rust: let handle = player.attributes.lookup(Some(&key))?;
    // rust: player
    // rust: .attributes
    // rust: .instance(&handle)
    // rust: .ok()
    // rust: .map(|value| value.base_value())
    // rust: })
    // rust: .unwrap_or(default)
}
    // rust: let player_base = (!nested).then(|| {
    // rust: [
    // rust: base("minecraft:attack_damage", 1.0),
    // rust: base(
    // rust: "minecraft:attack_speed",
    // rust: horizon_client::attack_strength::BASE_ATTACK_SPEED,
    // rust: ),
    // rust: ]
    // rust: });
    // rust: for (text, c) in
    // rust: horizon_client::item_tooltip::attribute_lines(&modifiers, player_base, &translate)
    // rust: {
    // rust: push(&mut lines, text, c);
}
}
        // ItemStack.UNBREAKABLE_TOOLTIP.
    // rust: if let Some(text) =
    // rust: horizon_client::item_tooltip::unbreakable_line(stack, &display, &translate)
    // rust: {
    // rust: push(&mut lines, text, rgba(85, 85, 255, 255));
}
        // OminousBottleAmplifier.addToTooltip.
    // rust: if let Some((text, c)) =
    // rust: horizon_client::item_tooltip::ominous_bottle_line(stack, &display, &translate)
    // rust: {
    // rust: push(&mut lines, text, c);
}
        // SuspiciousStewEffects.addToTooltip: the creative flag, which vanilla
        // sets for the creative screen's own slots, as `name_visible` above.
    // rust: for (text, c) in horizon_client::item_tooltip::stew_lines(
    // rust: stack,
    // rust: !nested && self.screen == Screen::Creative,
    // rust: &display,
    // rust: &translate,
    // rust: ) {
    // rust: push(&mut lines, text, c);
}
        // BlockItemStateProperties.addToTooltip.
    // rust: if let Some(text) = horizon_client::item_tooltip::honey_line(stack, &display, &translate) {
    // rust: push(&mut lines, text, gray);
}
        // TypedEntityData.addToTooltip: a spawn egg of a monster in Peaceful.
    // rust: if let Some(text) = horizon_client::item_tooltip::spawn_egg_peaceful_line(
    // rust: stack,
    // rust: self.ui.difficulty == 0,
    // rust: &display,
    // rust: &|id| {
    // rust: self.res.mob_types().get(id).is_none_or(|t| {
    // rust: horizon_client::mobs::spawn_rules::allowed_in_peaceful(t.species)
    // rust: })
    // rust: },
    // rust: &translate,
    // rust: ) {
    // rust: push(&mut lines, text, rgba(255, 85, 85, 255));
}
        // Spawner.appendHoverText: what a spawner or trial spawner item spawns.
    // rust: if display.shows("minecraft:block_entity_data")
    // rust: && matches!(
    // rust: &*stack.item,
    // rust: "minecraft:spawner" | "minecraft:trial_spawner"
    // rust: )
    // rust: {
    // rust: let gray = rgba(170, 170, 170, 255);
    // rust: match block_entity_item::spawner_entity(stack) {
    // rust: Some(id) => {
    // rust: let key = format!("entity.{}", id.replacen(':', ".", 1));
    // rust: push(&mut lines, self.translate(&key, &id), gray);
}
    // rust: None => {
    // rust: push(&mut lines, String::new(), u32::MAX);
    // rust: let desc1 =
    // rust: self.translate("block.minecraft.spawner.desc1", "Interact with Spawn Egg:");
    // rust: push(&mut lines, desc1, gray);
    // rust: let desc2 = self.translate("block.minecraft.spawner.desc2", "Sets Mob Type");
    // rust: push(&mut lines, format!(" {desc2}"), rgba(85, 85, 255, 255));
}
}
}
    // rust: if display.shows("minecraft:damage")
    // rust: && let Some(info) = item_info
    // rust: && info.max_damage > 0
    // rust: && stack.damage > 0
    // rust: && advanced
    // rust: {
            // `item.durability`, in the selected language.
    // rust: lines.push((
    // rust: horizon_client::text::Text::translate(
    // rust: "item.durability",
    // rust: &[
    // rust: horizon_client::text::Text::literal(
    // rust: info.max_damage.saturating_sub(stack.damage).to_string(),
    // rust: ),
    // rust: horizon_client::text::Text::literal(info.max_damage.to_string()),
    // rust: ],
    // rust: ),
    // rust: u32::MAX,
    // rust: ));
}
        // ItemStack.addDetailsToTooltipTail: with advanced tooltips the item id
        // and how many components the stack has.
    // rust: if advanced {
    // rust: let dark_gray = rgba(85, 85, 85, 255);
    // rust: push(&mut lines, stack.item.to_string(), dark_gray);
    // rust: let count = horizon_client::item_tooltip::component_count(stack, item_info);
    // rust: if count > 0 {
    // rust: let text = self.translate("item.components", "%s component(s)");
    // rust: push(
    // rust: &mut lines,
    // rust: text.replacen("%s", &count.to_string(), 1),
    // rust: dark_gray,
    // rust: );
}
}
        // ItemStack.OP_NBT_WARNING: `BlockItem` and `SpawnEggItem`
        // `.shouldPrintOpWarning` for a player with game master permission;
        // a nested projectile has no player. The first line is bold.
    // rust: if !nested
    // rust: && self.ui.registries.permission >= 2
    // rust: && (item_info.is_some_and(|i| i.block.is_some())
    // rust: && block_entity_item::op_warning(stack)
    // rust: || block_entity_item::spawn_egg_op_warning(stack))
    // rust: {
    // rust: for (i, (key, fallback)) in [
    // rust: ("item.op_warning.line1", "Warning:"),
    // rust: (
    // rust: "item.op_warning.line2",
    // rust: "Use of this item might lead to command execution.",
    // rust: ),
    // rust: (
    // rust: "item.op_warning.line3",
    // rust: "Do not use unless you know the exact contents!",
    // rust: ),
    // rust: ]
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: {
    // rust: let text = horizon_client::text::Text::legacy(&self.translate(key, fallback));
    // rust: lines.push((
    // rust: if i == 0 { text.bold() } else { text },
    // rust: rgba(255, 85, 85, 255),
    // rust: ));
}
}
        // Native mods last, once getTooltipLines has built every line; a
        // tooltip the stack hides stays hidden.
    // rust: if !nested && !lines.is_empty() {
    // rust: self.native_tooltip(stack, &mut lines);
}
    // rust: lines
}
    // Menu state for the control socket.
    // rust: pub(super) fn station_info(&self) -> serde_json::Value {
    // rust: let Some(s) = self.station.as_ref() else {
    // rust: return match self.container_kind() {
    // rust: Some(BlockEntity::Brewing(b)) => {
    // rust: serde_json::json!({ "brew_time": b.brew_time, "fuel": b.fuel })
}
    // rust: _ => serde_json::Value::Null,
}
}
    // rust: let recipes = &self.stations().recipes.stonecutting;
    // rust: serde_json::json!({
    // rust: "costs": s.offers.costs,
    // rust: "clues": s.offers.clues.iter().map(|c| c.as_ref().map(|(e, l)| format!("{e} {l}"))).collect::<Vec<_>>(),
    // rust: "bookcases": s.bookcases,
    // rust: "anvil_cost": s.anvil.cost,
    // rust: "result": s.result.as_ref().map(|r| format!("{} x{}", r.item, r.count)),
    // rust: "recipes": s.stone.recipes.iter().map(|&i| recipes[i].id.clone()).collect::<Vec<_>>(),
    // rust: "selected": s.selected,
    // rust: })
}
    // Options.advancedItemTooltips (F3+H).
options_advanced_tooltips :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.settings.file.bool("advancedItemTooltips")
}
    // `TooltipRenderUtil`: dark box with the purple border, first line spaced.
    // rust: pub(super) fn draw_tooltip_lines<T: Clone + Into<horizon_client::text::Text>>(
    // rust: &self,
    // rust: batch: &mut HudBatch,
    // rust: lines: &[(T, u32)],
    // rust: x: f32,
    // rust: y: f32,
    // rust: ) {
    // rust: if lines.is_empty() {
    // rust: return;
}
    // rust: let lines = Self::resolved(lines);
    // rust: let atlas = &self.gui.atlas;
    // rust: let (x, y, w, h) =
    // rust: Self::tooltip_geometry(atlas, &lines, (x, y), (batch.width, batch.height), [0.0; 2]);
    // rust: self.tooltip_box(batch, None, x, y, w, h);
    // rust: Self::tooltip_text(batch, atlas, &lines, x, y);
}
    // A tooltip's lines with their legacy codes resolved and their colours.
    // rust: fn resolved<T: Clone + Into<horizon_client::text::Text>>(
    // rust: lines: &[(T, u32)],
    // rust: ) -> Vec<(horizon_client::text::Text, u32)> {
    // rust: lines
    // rust: .iter()
    // rust: .map(|(text, color)| {
    // rust: let text: horizon_client::text::Text = text.clone().into();
    // rust: (text.resolve_legacy(), *color)
    // rust: })
    // rust: .collect()
}
    // The tooltip's text's top-left corner and the box's size: beside the
    // cursor, kept on screen. `extra` is [minimum width, height after the text].
    // rust: pub(super) fn tooltip_geometry(
    // rust: atlas: &horizon_client::hud::HudAtlas,
    // rust: lines: &[(horizon_client::text::Text, u32)],
    // rust: (x, y): (f32, f32),
    // rust: (width, height): (f32, f32),
    // rust: extra: [f32; 2],
    // rust: ) -> (f32, f32, f32, f32) {
    // rust: let w = lines
    // rust: .iter()
    // rust: .map(|(t, _)| atlas.font.width_text(t))
    // rust: .fold(0.0, f32::max)
    // rust: .max(extra[0]);
    // rust: let text_h = if lines.len() == 1 {
    // rust: 8.0
    // rust: } else {
    // rust: 8.0 + 2.0 + (lines.len() - 1) as f32 * 10.0
}
    // rust: let h = text_h + extra[1];
    // rust: let (x, y) = tooltip_position((x, y), (width, height), (w, h));
    // rust: (x, y, w, h)
}
    // The box and its frame sprites.
    // rust: pub(super) fn tooltip_box(
    // rust: &self,
    // rust: batch: &mut HudBatch,
    // rust: stack: Option<&ItemStack>,
    // rust: x: f32,
    // rust: y: f32,
    // rust: w: f32,
    // rust: h: f32,
    // rust: ) {
    // rust: let (mut background, mut border_top, mut border_bottom) =
    // rust: (0xf0100010, 0x505000ff, 0x5028007f);
    // rust: self.native_tooltip_color(stack, &mut background, &mut border_top, &mut border_bottom);
    // rust: let convert = |color: u32| {
    // rust: let [a, r, g, b] = color.to_be_bytes();
    // rust: rgba(r, g, b, a)
}
    // rust: let (background, border_top, border_bottom) = (
    // rust: convert(background),
    // rust: convert(border_top),
    // rust: convert(border_bottom),
    // rust: );
    // rust: let atlas = &self.gui.atlas;
    // rust: batch.fill(atlas, x - 3.0, y - 4.0, w + 6.0, 1.0, background);
    // rust: batch.fill(atlas, x - 3.0, y + h + 3.0, w + 6.0, 1.0, background);
    // rust: batch.fill(atlas, x - 4.0, y - 3.0, w + 8.0, h + 6.0, background);
    // rust: batch.fill(atlas, x - 3.0, y - 3.0, w + 6.0, 1.0, border_top);
    // rust: batch.fill(atlas, x - 3.0, y + h + 2.0, w + 6.0, 1.0, border_bottom);
    // rust: batch.fill_gradient(
    // rust: atlas,
    // rust: (x - 3.0, y - 2.0, 1.0, h + 4.0),
    // rust: border_top,
    // rust: border_bottom,
    // rust: );
    // rust: batch.fill_gradient(
    // rust: atlas,
    // rust: (x + w + 2.0, y - 2.0, 1.0, h + 4.0),
    // rust: border_top,
    // rust: border_bottom,
    // rust: );
}
    // rust: pub(super) fn tooltip_text(
    // rust: batch: &mut HudBatch,
    // rust: atlas: &horizon_client::hud::HudAtlas,
    // rust: lines: &[(horizon_client::text::Text, u32)],
    // rust: x: f32,
    // rust: y: f32,
    // rust: ) {
    // rust: let mut ty = y;
    // rust: for (i, (text, color)) in lines.iter().enumerate() {
    // rust: batch.text_styled(atlas, text, x, ty, *color, true);
    // rust: ty += if i == 0 { 12.0 } else { 10.0 };
}
}
    // A stack's tooltip: its lines, and under them a bundle's contents
    // (`ClientBundleTooltip`: the 4 wide grid, the `+N` of what it leaves
    // out, and the weight bar).
    // rust: pub(super) fn draw_stack_tooltip(
    // rust: &mut self,
    // rust: batch: &mut HudBatch,
    // rust: stack: &ItemStack,
    // rust: x: f32,
    // rust: y: f32,
    // rust: ) {
    // rust: self.draw_stack_tooltip_with(batch, stack, false, x, y, Vec::new());
}
    // [`Self::draw_stack_tooltip`] with `TooltipFlag.isCreative` set when
    // `creative` (a creative tab's own slot), and `after_name` inserted from
    // line 1, as the creative screen adds its tab names.
    // rust: pub(super) fn draw_stack_tooltip_with(
    // rust: &mut self,
    // rust: batch: &mut HudBatch,
    // rust: stack: &ItemStack,
    // rust: creative: bool,
    // rust: x: f32,
    // rust: y: f32,
    // rust: after_name: Vec<(horizon_client::text::Text, u32)>,
    // rust: ) {
    // rust: let mut lines = self.stack_tooltip_lines(stack, false, creative);
    // rust: if lines.is_empty() {
    // rust: return;
}
    // rust: lines.splice(1..1, after_name);
    // rust: let lines = Self::resolved(&lines);
        // The component's height does not depend on where it is drawn, so a
        // probe at the origin gives the box its extra height.
    // rust: let probe =
    // rust: horizon_client::item_tooltip::bundle_tooltip(self.items(), stack, 0.0, 0.0, 96.0);
    // rust: let bundle_extra = probe.as_ref().map_or(0.0, |l| l.height + 2.0);
    // rust: let mut component = None;
    // rust: self.native_tooltip_component(stack, &mut component);
    // rust: let component = tooltip_component_size(component);
    // rust: let extra = bundle_extra + component.map_or(0.0, |size| size[1] + 2.0);
    // rust: let min_width = (if probe.is_some() { 96.0_f32 } else { 0.0 })
    // rust: .max(component.map_or(0.0, |size| size[0]));
    // rust: let atlas = &self.gui.atlas;
    // rust: let (x, y, w, h) = Self::tooltip_geometry(
    // rust: atlas,
    // rust: &lines,
    // rust: (x, y),
    // rust: (batch.width, batch.height),
    // rust: [min_width, extra],
    // rust: );
    // rust: self.tooltip_box(batch, Some(stack), x, y, w, h);
    // rust: let text_h = h - extra;
    // rust: Self::tooltip_text(batch, atlas, &lines, x, y);
    // rust: if let Some(layout) = horizon_client::item_tooltip::bundle_tooltip(
    // rust: self.items(),
    // rust: stack,
    // rust: x,
    // rust: y + text_h + 2.0,
    // rust: w,
    // rust: ) {
    // rust: self.draw_bundle_tooltip(batch, &layout);
    // rust: self.draw_bundle_selected_name(batch, &layout, x, y + text_h + 2.0, w);
}
    // rust: if let Some(size) = component {
    // rust: self.native_tooltip_component_draw(
    // rust: stack,
    // rust: batch,
    // rust: [x, y + text_h + bundle_extra + 2.0],
    // rust: size,
    // rust: );
}
}
    // `ClientBundleTooltip.extractSelectedItemTooltip`: the selected item's
    // name in a box of its own, centred over the grid (less 12) and 15 above
    // the component, placed by `DefaultTooltipPositioner` (+12, -12, kept on
    // screen). `x`, `y` and `w` are the component's.
    // rust: fn draw_bundle_selected_name(
    // rust: &self,
    // rust: batch: &mut HudBatch,
    // rust: layout: &horizon_client::bundle::TooltipLayout,
    // rust: x: f32,
    // rust: y: f32,
    // rust: w: f32,
    // rust: ) {
    // rust: let Some((_, stack)) = layout.selected.and_then(|i| layout.slots.get(i)) else {
    // rust: return;
}
    // rust: let name =
    // rust: horizon_client::item_tooltip::styled_name(stack, || self.stack_hover_name(stack));
    // rust: let lines = Self::resolved(&[(name, self.rarity_color(stack))]);
    // rust: let atlas = &self.gui.atlas;
    // rust: let tw = atlas.font.width_text(&lines[0].0);
    // rust: let center = x + (w / 2.0).floor() - 12.0;
    // rust: let mut px = center - (tw / 2.0).floor() + 12.0;
    // rust: let mut py = y - 15.0 - 12.0;
    // rust: if px + tw > batch.width {
    // rust: px = (px - 24.0 - tw).max(4.0);
}
    // rust: if py + 8.0 + 3.0 > batch.height {
    // rust: py = batch.height - 8.0 - 3.0;
}
    // rust: self.tooltip_box(batch, Some(stack), px, py, tw, 8.0);
    // rust: Self::tooltip_text(batch, atlas, &lines, px, py);
}
    // `ClientBundleTooltip.extractImage`: the slots, the count past them and
    // the progress bar.
    // rust: fn draw_bundle_tooltip(
    // rust: &mut self,
    // rust: batch: &mut HudBatch,
    // rust: layout: &horizon_client::bundle::TooltipLayout,
    // rust: ) {
    // rust: for (i, (at, stack)) in layout.slots.iter().enumerate() {
    // rust: let selected = layout.selected == Some(i);
    // rust: let sprite = |name: &str| format!("gui/sprites/container/bundle/{name}");
            // Each draw takes the atlas on its own: the item's needs `&mut self`.
    // rust: horizon_client::ui::nine_slice(
    // rust: batch,
    // rust: &self.gui.atlas,
    // rust: &sprite(if selected {
    // rust: "slot_highlight_back"
    // rust: } else {
    // rust: "slot_background"
    // rust: }),
    // rust: at[0],
    // rust: at[1],
    // rust: 24.0,
    // rust: 24.0,
    // rust: u32::MAX,
    // rust: );
    // rust: let stack = stack.clone();
    // rust: let [x, y] = *at;
    // rust: self.draw_item(batch, &stack, x + 4.0, y + 4.0);
    // rust: if selected {
    // rust: horizon_client::ui::nine_slice(
    // rust: batch,
    // rust: &self.gui.atlas,
    // rust: &sprite("slot_highlight_front"),
    // rust: x,
    // rust: y,
    // rust: 24.0,
    // rust: 24.0,
    // rust: u32::MAX,
    // rust: );
}
}
    // rust: let atlas = &self.gui.atlas;
    // rust: if let Some((at, hidden)) = layout.overflow {
    // rust: let label = horizon_client::text::Text::literal(format!("+{hidden}"));
    // rust: let w = atlas.font.width_text(&label);
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: &label,
    // rust: at[0] + 12.0 - (w / 2.0).floor(),
    // rust: at[1] + 10.0,
    // rust: u32::MAX,
    // rust: true,
    // rust: );
}
    // rust: if let Some((at, description)) = layout
    // rust: .empty_description
    // rust: .zip(Some("item.minecraft.bundle.empty.description"))
    // rust: {
    // rust: let text = horizon_client::text::Text::translate(description, &[]);
    // rust: let mut ty = at[1];
    // rust: for line in atlas.font.split_lines(&text, layout.width) {
    // rust: batch.text_styled(atlas, &line.0, at[0], ty, 0xFFAA_AAAA, false);
    // rust: ty += 9.0;
}
}
    // rust: let [bx, by] = layout.bar;
    // rust: let fill_sprite = if layout.full {
    // rust: "gui/sprites/container/bundle/bundle_progressbar_full"
    // rust: } else {
    // rust: "gui/sprites/container/bundle/bundle_progressbar_fill"
}
    // rust: horizon_client::ui::nine_slice(
    // rust: batch,
    // rust: atlas,
    // rust: fill_sprite,
    // rust: bx + 1.0,
    // rust: by,
    // rust: layout.fill,
    // rust: 13.0,
    // rust: u32::MAX,
    // rust: );
    // rust: horizon_client::ui::nine_slice(
    // rust: batch,
    // rust: atlas,
    // rust: "gui/sprites/container/bundle/bundle_progressbar_border",
    // rust: bx,
    // rust: by,
    // rust: 96.0,
    // rust: 13.0,
    // rust: u32::MAX,
    // rust: );
    // rust: if let Some(key) = layout.label {
    // rust: let label = horizon_client::text::Text::translate(key, &[]);
    // rust: let w = atlas.font.width_text(&label);
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: &label,
    // rust: bx + 48.0 - (w / 2.0).floor(),
    // rust: by + 3.0,
    // rust: u32::MAX,
    // rust: true,
    // rust: );
}
}
    // `AbstractContainerScreen.showTooltipWithItemInHand`: a hovered stack's
    // tooltip shows while a stack is carried only when its image says so, as
    // a bundle's contents do (`ClientBundleTooltip`).
    // rust: pub(super) fn tooltip_with_carried(&self, stack: &ItemStack) -> bool {
    // rust: self.carried.is_none()
    // rust: || horizon_client::bundle::Contents::of(self.items(), stack).is_some()
}
    // Hovered-slot tooltip on the plain inventory, crafting and container screens.
    // rust: pub(super) fn draw_slot_tooltip(&mut self, batch: &mut HudBatch) {
    // rust: let Some(slot) = self.slot_at(batch, self.cursor.0, self.cursor.1) else {
    // rust: return;
}
        // The recipe book's tooltip is drawn after the slot's own, so a ghost wins.
    // rust: if let Some(ghost) = self.ghost_stack(slot) {
    // rust: self.draw_stack_tooltip(batch, &ghost, self.cursor.0, self.cursor.1);
    // rust: return;
}
    // rust: let stack = self.slot_view(slot);
    // rust: if self.carried.is_some() && !stack.as_ref().is_some_and(|s| self.tooltip_with_carried(s)) {
    // rust: return;
}
    // rust: if let Some(stack) = stack {
    // rust: self.draw_stack_tooltip(batch, &stack, self.cursor.0, self.cursor.1);
    // rust: } else if let Some(text) = self.crafter_tooltip(slot) {
    // rust: self.draw_tooltip_lines(
    // rust: batch,
    // rust: &[(horizon_client::text::Text::literal(text), u32::MAX)],
    // rust: self.cursor.0,
    // rust: self.cursor.1,
    // rust: );
}
}

    // ---------------------------------------------------------------- brewing stand

    // `BrewingStandBlockEntity.serverTick` of the brewing stand at `pos`, in
    // its place among the level's block entity tickers.
    // rust: pub(super) fn tick_brewing_stand(
    // rust: &mut self,
    // rust: pos: (i32, i32, i32),
    // rust: ) -> horizon_client::Result<()> {
    // rust: let Some(BlockEntity::Brewing(b)) = self.world.block_entities.get_mut(&pos) else {
    // rust: return Ok(());
}
    // rust: let was_idle = b.brew_time <= 0;
    // rust: let was_unfueled = b.fuel <= 0;
    // rust: let fuel_item = was_unfueled
    // rust: .then(|| b.items[4].as_ref().map(|s| s.item.clone()))
    // rust: .flatten();
    // rust: let out = b.tick(
    // rust: &world_stations!(self).brewing,
    // rust: world_items!(self),
    // rust: self.res.providers(),
    // rust: );
    // rust: let consumed_fuel = was_unfueled && b.fuel > 0;
    // rust: let started = was_idle && b.brew_time > 0;
    // rust: let ingredient = started.then(|| b.ingredient.clone()).flatten();
    // rust: if consumed_fuel && let Some(item) = fuel_item {
    // rust: let (x, y, z) = pos;
    // rust: self.native_brewing_fuel([x, y, z], &item);
}
    // rust: if let Some(ingredient) = ingredient {
    // rust: let (x, y, z) = pos;
    // rust: self.native_brewing_start([x, y, z], &ingredient);
}
    // rust: if out != brewing::BrewTick::default() {
    // rust: let (x, y, z) = pos;
    // rust: self.world.modified.insert((x >> 4, z >> 4));
    // rust: if out.brewed {
    // rust: self.native_brewing_complete([x, y, z]);
    // rust: self.play_at("minecraft:block.brewing_stand.brew", [x, y, z], 1.0, 1.0);
}
    // rust: for d in out.drops {
    // rust: self.pop_resource([x, y, z], d);
}
    // rust: if let Some(bottles) = out.bottles {
    // rust: let state = self.world.block(x, y, z);
    // rust: if let Some(mut s) = self.pack.assets.registry.state(state).cloned()
    // rust: && AsRef::<str>::as_ref(&s.name) == "minecraft:brewing_stand"
    // rust: {
    // rust: for (i, has) in bottles.iter().enumerate() {
    // rust: s.properties
    // rust: .insert(format!("has_bottle_{i}"), has.to_string());
}
    // rust: if let Ok(id) = self.pack.assets.registry.resolve(&s) {
    // rust: self.level_set_with_flags(
    // rust: [x, y, z],
    // rust: id,
    // rust: horizon_world::level::flags::UPDATE_CLIENTS,
    // rust: )?;
}
}
}
}
    // rust: if matches!(self.world.block_entities.get(&pos), Some(BlockEntity::Brewing(b)) if b.idle())
    // rust: {
    // rust: self.world.block_entities.sleep(pos);
}
    // rust: Ok(())
}
}

// The anvil's rename box (`AnvilScreen`: `setMaxLength(50)`).
ANVIL_NAME_CHARS :: 50

anvil_box :: proc() -> h {
    // Ported from Horizon
    return {}
}
    // rust: let mut edit = horizon_client::ui::EditBox::new(0.0, 0.0, 103.0, 12.0);
    // rust: edit.message = super::screen_info::tr("container.repair", &[]);
    // rust: edit.bordered = false;
    // rust: edit.max_length = ANVIL_NAME_CHARS;
    // rust: edit.text_color = u32::MAX;
    // rust: edit.focused = true;
    // rust: edit
}

    // rust: mod tests {
measured_image_tooltips_position_the_whole_box :: proc() {
}
//         use super::tooltip_position;
    // rust: assert_eq!(
    // rust: tooltip_position((50.0, 90.0), (200.0, 160.0), (40.0, 8.0)),
    // rust: (62.0, 78.0)
    // rust: );
        // A wide image makes the whole tooltip move to the other side.
    // rust: assert_eq!(
    // rust: tooltip_position((90.0, 90.0), (200.0, 160.0), (128.0, 42.0)),
    // rust: (4.0, 78.0)
    // rust: );
        // Its height participates in the existing bottom-edge adjustment too.
    // rust: assert_eq!(
    // rust: tooltip_position((90.0, 90.0), (200.0, 80.0), (128.0, 42.0)),
    // rust: (4.0, 35.0)
    // rust: );
}
image_tooltip_measurements_are_finite_and_nonempty :: proc() {
}
//         use super::tooltip_component_size;
    // rust: assert_eq!(tooltip_component_size(None), None);
    // rust: assert_eq!(
    // rust: tooltip_component_size(Some([128.0, 32.0])),
    // rust: Some([128.0, 32.0])
    // rust: );
    // rust: for size in [
    // rust: [0.0, 32.0],
    // rust: [32.0, -1.0],
    // rust: [f32::NAN, 32.0],
    // rust: [32.0, f32::INFINITY],
    // rust: ] {
    // rust: assert_eq!(tooltip_component_size(Some(size)), None);
}
}
//     use super::*;

enchanting_book_opens_with_offers_and_turns_for_a_new_item :: proc() {
}
    // rust: let mut book = EnchantBook::new(LegacyRandom::new(0));
        // No offers: the book stays shut and on its page.
    // rust: book.tick(None, [0; 3]);
    // rust: assert_eq!(book.at(1.0), (0.0, 0.0));
        // An item with offers: it opens 0.2 a tick and picks a page
        // more than one away to turn to.
    // rust: let sword = ItemStack::new("minecraft:diamond_sword", 1);
    // rust: book.tick(Some(&sword), [3, 10, 30]);
    // rust: assert!((book.open - 0.2).abs() < 1e-6);
    // rust: assert!((book.flip_t - book.flip).abs() > 1.0 - 0.2);
    // rust: let target = book.flip_t;
    // rust: for _ in 0..60 {
    // rust: book.tick(Some(&sword), [3, 10, 30]);
}
    // rust: assert_eq!(book.open, 1.0);
    // rust: assert!(
    // rust: (book.flip - target).abs() < 0.05,
    // rust: "{} {}",
    // rust: book.flip,
    // rust: target
    // rust: );
        // The same item keeps the page; taking it out closes the book.
    // rust: assert_eq!(book.flip_t, target);
    // rust: for _ in 0..6 {
    // rust: book.tick(None, [0; 3]);
}
    // rust: assert_eq!(book.open, 0.0);
    // rust: assert_ne!(book.flip_t, target);
    // rust: let (open, _) = book.at(0.5);
    // rust: assert!(open < 1e-6);
}

a_step_leaves_the_visible_rows_only_from_the_end_one :: proc() {
}
    // rust: let rows = [[10.0, 0.0, 10.0, 10.0], [10.0, 10.0, 10.0, 10.0]];
    // rust: assert!(off_visible_rows(&rows, (15.0, 15.0), false));
    // rust: assert!(!off_visible_rows(&rows, (15.0, 15.0), true));
    // rust: assert!(off_visible_rows(&rows, (15.0, 5.0), true));
    // rust: assert!(!off_visible_rows(&rows, (15.0, 5.0), false));
    // rust: assert!(!off_visible_rows(&rows, (50.0, 5.0), false));
}

stonecutter_scroller_rows :: proc() {
}
        // 26 recipes = 7 rows, 4 below the grid.
    // rust: assert_eq!(stonecutter_offscreen_rows(26), 4);
    // rust: assert_eq!(stonecutter_start(26, 0.0), 0);
    // rust: assert_eq!(stonecutter_start(26, 0.5), 8);
    // rust: assert_eq!(stonecutter_start(26, 0.6), 8);
    // rust: assert_eq!(stonecutter_start(26, 0.65), 12);
    // rust: assert_eq!(stonecutter_start(26, 1.0), 16);
}
stonecutter_drag_follows_the_cursor :: proc() {
}
        // The scroller's middle sits under the cursor, within its track.
    // rust: assert_eq!(stonecutter_drag_offs(0.0), 0.0);
    // rust: assert_eq!(stonecutter_drag_offs(21.5), 0.0);
    // rust: assert_eq!(stonecutter_drag_offs(21.5 + 39.0 / 2.0), 0.5);
    // rust: assert_eq!(stonecutter_drag_offs(21.5 + 39.0), 1.0);
    // rust: assert_eq!(stonecutter_drag_offs(200.0), 1.0);
}
stonecutter_wheel_moves_one_row :: proc() {
}
    // rust: let mut s = Station::new(Kind::Stonecutter, [0, 0, 0]);
    // rust: s.inputs[0] = Some(ItemStack::new("minecraft:stone", 1));
    // rust: s.stone.recipes = (0..26).collect();
    // rust: assert!(s.stonecutter_scrolls());
    // rust: s.stonecutter_scroll_to(s.scroll + 1.0 / 4.0);
    // rust: assert_eq!(s.start, 4);
    // rust: s.stonecutter_scroll_to(s.scroll + 5.0);
    // rust: assert_eq!((s.scroll, s.start), (1.0, 16));
    // rust: s.stone.recipes.truncate(12);
    // rust: assert!(!s.stonecutter_scrolls());
}
}

    // rust: mod cycling_tests {
//     use super::*;

an_empty_slot_cycles_its_icons_every_30_ticks_and_fades_the_next_in_over_4 :: proc() {
}
    // rust: let icons = ["helmet", "sword", "chestplate"];
    // rust: let mut slot = CyclingSlot::default();
    // rust: slot.advance(100, &icons);
        // The first icon, fully shown, until the 30th tick.
    // rust: assert_eq!(slot.shown(0.5), vec![("helmet", 1.0)]);
    // rust: slot.advance(129, &icons);
    // rust: assert_eq!(slot.shown(0.5), vec![("helmet", 1.0)]);
        // The 30th tick moves to the next icon, which fades in over 4 ticks while the
        // one before fades out.
    // rust: slot.advance(130, &icons);
    // rust: assert_eq!(slot.shown(0.0), vec![("helmet", 1.0), ("sword", 0.0)]);
    // rust: assert_eq!(slot.shown(2.0), vec![("helmet", 0.5), ("sword", 0.5)]);
    // rust: assert_eq!(slot.shown(4.0), vec![("sword", 1.0)]);
        // A new list starts again from its first icon, keeping the tick count.
    // rust: slot.advance(131, &["ingot"]);
    // rust: assert_eq!(slot.shown(0.0), vec![("ingot", 1.0)]);
        // No icons, nothing shown.
    // rust: slot.advance(132, &[]);
    // rust: assert!(slot.shown(0.0).is_empty());
}

the_icons_of_a_smithing_slot_follow_the_template :: proc() {
}
    // rust: let (base, n, additions, m) =
    // rust: smithing_slot_icons(Some("minecraft:netherite_upgrade_smithing_template"));
    // rust: assert_eq!(base[..n].len(), 11);
    // rust: assert_eq!(additions[..m], ["ingot"]);
    // rust: let (base, n, additions, m) =
    // rust: smithing_slot_icons(Some("minecraft:coast_armor_trim_smithing_template"));
    // rust: assert_eq!(base[..n], ["helmet", "chestplate", "leggings", "boots"]);
    // rust: assert_eq!(additions[..m].len(), 7);
    // rust: assert_eq!(smithing_slot_icons(Some("minecraft:stick")).1, 0);
    // rust: assert_eq!(smithing_slot_icons(None).3, 0);
}
}
