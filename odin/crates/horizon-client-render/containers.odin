//! Transpiled from Horizon Rust crate
package horizon_client_render_containers

import "core:fmt"
import "core:mem"
import "core:math"

// Container block entities: chests/barrels (27 slots) and the three furnace
// kinds, ticking as `AbstractFurnaceBlockEntity.serverTick` with fuel times
// from the data-driven `context_int_provider`/`context_float_provider` files.
    // rust: pub use crate::chunk::block_entity::{
    // rust: Banner, Beacon, BlockEntity, Brushable, Campfire, ChiseledBookshelf, Crafter, CreakingHeart,
    // rust: EndGateway, Furnace, FurnaceKind, Jukebox, Lectern, MOD_MENUS, ModBlockEntity,
    // rust: ModBlockEntityFields, ModContainer, ModEnergyBuffer, ModFluidTanks, ModRevision, PotentSulfur,
    // rust: Shelf, Skull, SkullSkin,
}
// use crate::items::ItemStack;
// use std::collections::HashMap;

// a content mod's menu type (`data/<id>/horizon/menu/`, vanilla's
// `MenuType`): its container slots, its data slots (`ContainerData`) and the
// slots players only take from.
ModMenuType :: struct {
    id: ^'static str,
    slots: uint,
    data_slots: uint,
    results: [dynamic]uint,
}

MOD_MENU_TYPES :: std::sync::OnceLock::new()

// registers the content mods' menu types, `(id, slots, data slots,
// results)`, a list set once per process (false when it already was).
    // rust: pub fn register_mod_menu_types(
    // rust: menus: impl IntoIterator<Item = (String, usize, usize, Vec<usize>)>,
    // rust: ) -> bool {
    // rust: if MOD_MENU_TYPES.get().is_some() {
    // rust: return false;
}
    // rust: let menus = menus
    // rust: .into_iter()
    // rust: .map(|(id, slots, data_slots, results)| ModMenuType {
    // rust: id: Box::leak(id.into_boxed_str()),
    // rust: slots,
    // rust: data_slots,
    // rust: results,
    // rust: });
    // rust: MOD_MENU_TYPES.set(menus.collect()).is_ok()
}

// the content mods' menu types, in registry order.
mod_menu_types :: proc() -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: MOD_MENU_TYPES.get().map_or(&[], Vec::as_slice)
}

// the mod menu type named `id`, kept out of line: a vanilla menu never
// looks one up.
mod_menu_type :: proc(id: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: mod_menu_types().iter().find(|m| m.id == id)
}

// whether a client of `brand` can be sent menu type `menu`: a vanilla
// client reads the type through `ByteBufCodecs.registry(Registries.MENU)`,
// and an id it lacks (`IdMap.byIdOrThrow`) disconnects it, so it is sent
// vanilla's only. A Horizon client has the server's (the content identity).
menu_reaches :: proc(brand: string, menu: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: brand == "horizon" || menu.starts_with("minecraft:")
}

    // rust: impl FurnaceKind {
recipe_type :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Furnace => "minecraft:smelting",
    // rust: Self::BlastFurnace => "minecraft:blasting",
    // rust: Self::Smoker => "minecraft:smoking",
}
}
fast :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self != Self::Furnace
}
from_block :: proc(name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match name {
    // rust: "minecraft:furnace" => Some(Self::Furnace),
    // rust: "minecraft:blast_furnace" => Some(Self::BlastFurnace),
    // rust: "minecraft:smoker" => Some(Self::Smoker),
    // rust: _ => None,
}
}
}
// The key `recipes_used` keeps a recipe under: its full id, as vanilla's `ResourceKey<Recipe>`
// writes it in `RecipesUsed`. Horizon's own recipe ids are file names without the namespace, so
// keeping both forms would write a key twice, and vanilla refuses such a furnace
// ("Duplicate entry for key").
recipe_used_key :: proc(id: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: if id.contains(':') {
    // rust: id.to_owned()
    // rust: } else {
    // rust: format!("minecraft:{id}")
}
}
// A hopper's slots: the only plain container with five.
HOPPER_SLOTS :: 5

// `getDefaultName` of the `BaseContainerBlockEntity` that `block` holds: the
// translation key of its menu's title when it has no custom name. Copper
// chests hold a `ChestBlockEntity`, shulker boxes of every colour a
// `ShulkerBoxBlockEntity`.
default_name_key :: proc(block: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(match block {
    // rust: "minecraft:chest" | "minecraft:trapped_chest" => "container.chest",
    // rust: n if n.ends_with("copper_chest") => "container.chest",
    // rust: "minecraft:barrel" => "container.barrel",
    // rust: n if n.ends_with("shulker_box") => "container.shulkerBox",
    // rust: "minecraft:dispenser" => "container.dispenser",
    // rust: "minecraft:dropper" => "container.dropper",
    // rust: "minecraft:hopper" => "container.hopper",
    // rust: "minecraft:furnace" => "container.furnace",
    // rust: "minecraft:smoker" => "container.smoker",
    // rust: "minecraft:blast_furnace" => "container.blast_furnace",
    // rust: "minecraft:brewing_stand" => "container.brewing",
    // rust: "minecraft:crafter" => "container.crafter",
    // rust: _ => return None,
    // rust: })
}

// `BaseContainerBlockEntity.getDisplayName` (`getName`), the title of the
// `ClientboundOpenScreenPacket` that opens it: the block entity's custom
// name (`CustomName`, a literal), else its default name.
display_name :: proc(custom: Maybe(string), default_key: string) -> h {
    // Ported from Horizon
    return {}
}
    // rust: match custom {
    // rust: Some(name) => horizon_protocol::text::literal(name),
    // rust: None => horizon_protocol::text::translatable(default_key, &[]),
}
}

// `ChestBlock.MENU_PROVIDER_COMBINER`'s `getDisplayName` for a double chest:
// the first half's custom name (the right half, `DoubleBlockCombiner`'s
// `FIRST`), else the second's, else `container.chestDouble`.
double_chest_name :: proc(first: Maybe(string), second: Maybe(string)) -> h {
    // Ported from Horizon
    return {}
}
    // rust: display_name(first.or(second), "container.chestDouble")
}

// `BaseContainerBlockEntity.sendChestLockedNotifications`: the action bar
// message of a container that refuses to open, `container.isLocked` naming it
// by its display name.
locked_message :: proc(title: ^horizon_world::nbt::Tag) -> h {
    // Ported from Horizon
    return {}
}
//     use horizon_world::nbt::Tag;
    // rust: Tag::compound([
    // rust: ("translate", Tag::String("container.isLocked".into())),
    // rust: ("with", Tag::List(vec![title.clone()])),
    // rust: ])
}

// The menu a container vehicle's `createMenu` builds (`ContainerEntity`):
// `AbstractChestBoat.createMenu` and `MinecartChest.createMenu` are
// `ChestMenu.threeRows` (a 9x3 menu), `MinecartHopper.createMenu` is a
// `HopperMenu` (five slots). `None` for any other entity type.
vehicle_menu :: proc(entity_type: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match entity_type {
    // rust: "minecraft:chest_minecart" => Some(("minecraft:generic_9x3", 27)),
    // rust: "minecraft:hopper_minecart" => Some(("minecraft:hopper", HOPPER_SLOTS)),
    // rust: n if n.ends_with("_chest_boat") || n.ends_with("_chest_raft") => {
    // rust: Some(("minecraft:generic_9x3", 27))
}
    // rust: _ => None,
}
}

// `MenuProvider.getDisplayName` for a container vehicle: `Entity.getDisplayName`
// is its custom name, else `getName`, the entity type's name key. Horizon's
// vehicles keep no custom name, so this is the type's name key.
vehicle_menu_name :: proc(entity_type: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!("entity.{}", entity_type.replacen(':', ".", 1))
}

    // rust: impl Campfire {
    // `placeFood`'s slot: the first empty one, given the item's
    // `campfire_cooking` time; it takes one item of `held`.
place_food :: proc(self: ^Self, held: ^ItemStack, cooking_time: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(slot) = self.items.iter().position(Option::is_none) else {
    // rust: return false;
}
    // rust: self.total[slot] = cooking_time;
    // rust: self.progress[slot] = 0;
    // rust: self.items[slot] = Some(ItemStack {
    // rust: count: 1,
    // rust: ..held.clone()
    // rust: });
    // rust: held.count = held.count.saturating_sub(1);
    // rust: true
}
    // `cookTick` (lit): each item's progress rises by one; the slots whose
    // progress reached their cooking time give up their item (the caller
    // drops its result).
cook_tick :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut done = Vec::new();
    // rust: for i in 0..4 {
    // rust: if self.items[i].is_none() {
    // rust: continue;
}
    // rust: self.progress[i] += 1;
    // rust: if self.progress[i] >= self.total[i]
    // rust: && let Some(item) = self.items[i].take()
    // rust: {
    // rust: done.push((i, item));
}
}
    // rust: done
}
    // `cooldownTick` (unlit): the progress falls by two, no lower than 0.
    // Whether anything changed (`setChanged`).
cooldown_tick :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let mut changed = false;
    // rust: for i in 0..4 {
    // rust: if self.progress[i] > 0 {
    // rust: changed = true;
    // rust: self.progress[i] = (self.progress[i] - 2).clamp(0, self.total[i]);
}
}
    // rust: changed
}
idle :: proc(self: ^Self, lit: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if lit {
    // rust: self.items.iter().all(Option::is_none)
    // rust: } else {
    // rust: self.progress.iter().all(|&p| p <= 0)
}
}
}
    // rust: impl Skull {
    // rust: pub fn new(
    // rust: profile: Option<horizon_world::nbt::Tag>,
    // rust: note_block_sound: Option<String>,
    // rust: custom_name: Option<horizon_world::nbt::Tag>,
    // rust: ) -> Self {
    // rust: let skin = profile.as_ref().map(SkullSkin::of);
    // rust: Self {
    // rust: profile,
    // rust: note_block_sound,
    // rust: custom_name,
    // rust: skin,
}
}
}
    // rust: impl SkullSkin {
of :: proc(profile: ^horizon_world::nbt::Tag) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let download = crate::skins::profile_skin_url_nbt(profile).and_then(|url| {
    // rust: let location = crate::skins::skin_location(&crate::skins::texture_hash(&url)?);
    // rust: Some((url, location))
    // rust: });
        // A `Dynamic` profile (a name or id only) resolves through the
        // services when the skull is drawn.
    // rust: let dynamic = crate::skins::dynamic_nbt(profile);
        // DefaultPlayerSkin.get(id), or getDefaultSkin (slim steve) without an id.
    // rust: let fallback = crate::skins::profile_uuid_nbt(profile)
    // rust: .or_else(|| {
    // rust: crate::skins::nbt_text(profile.get("name"))
    // rust: .map(|name| horizon_protocol::crypto::offline_uuid(&name))
    // rust: })
    // rust: .map_or("entity/player/slim/steve", crate::tab_list::default_skin);
    // rust: Self {
    // rust: download,
    // rust: dynamic,
    // rust: texture: crate::skins::profile_texture_nbt(profile),
    // rust: fallback,
}
}
}
// The skull and head blocks (`SkullBlock`, `WallSkullBlock`): every
// `*_skull` and `*_head` but the piston's head.
// The item slots of the container `name`'s block carries, if any.
container_size :: proc(name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match name {
    // rust: "minecraft:chest" | "minecraft:trapped_chest" | "minecraft:barrel" => Some(27),
    // rust: n if n.ends_with("copper_chest") => Some(27),
    // rust: "minecraft:hopper" => Some(HOPPER_SLOTS),
    // rust: "minecraft:dispenser" | "minecraft:dropper" => Some(9),
    // rust: n if n.ends_with("shulker_box") => Some(27),
    // rust: _ => None,
}
}
is_skull :: proc(name: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: name.ends_with("_skull") || (name.ends_with("_head") && name != "minecraft:piston_head")
}
    // rust: impl Crafter {
    // `slotCanBeDisabled`: only empty slots.
slot_can_be_disabled :: proc(self: ^Self, slot: uint) -> b {
    // Ported from Horizon
    return {}
}
    // rust: slot < 9 && self.items[slot].is_none()
}
    // `setSlotState`.
set_slot_state :: proc(self: ^Self, slot: uint, enabled: bool) {
}
    // rust: if self.slot_can_be_disabled(slot) {
    // rust: self.disabled[slot] = !enabled;
}
}
    // `getRedstoneSignal`: filled or disabled slots.
redstone_signal :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: (0..9)
    // rust: .filter(|&i| self.items[i].is_some() || self.disabled[i])
    // rust: .count() as i32
}
    // `canPlaceItem`: a hopper fills the smallest stacks first.
can_place :: proc(self: ^Self, slot: uint, _stack: ^ItemStack, max_stack: u32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if slot >= 9 || self.disabled[slot] {
    // rust: return false;
}
    // rust: let Some(current) = &self.items[slot] else {
    // rust: return true;
}
    // rust: if current.count >= max_stack {
    // rust: return false;
}
    // rust: !(slot + 1..9).any(|i| {
    // rust: !self.disabled[i]
    // rust: && match &self.items[i] {
    // rust: None => true,
    // rust: Some(other) => {
    // rust: other.count < current.count && other.same_item_same_components(current)
}
}
    // rust: })
}
}
    // rust: impl BlockEntity {
for_block :: proc(name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(hanging) = crate::signs::sign_kind(name) {
    // rust: return Some(Self::Sign(crate::signs::SignData {
    // rust: hanging,
    // rust: ..Default::default()
    // rust: }));
}
    // rust: if let Some(kind) = FurnaceKind::from_block(name) {
    // rust: return Some(Self::Furnace(Furnace {
    // rust: kind,
    // rust: items: [None, None, None],
    // rust: lit_remaining: 0,
    // rust: lit_total: 0,
    // rust: cooking_timer: 0,
    // rust: cooking_total: 0,
    // rust: speed: 1.0,
    // rust: recipes_used: HashMap::new(),
    // rust: }));
}
    // rust: if matches!(
    // rust: name,
    // rust: "minecraft:suspicious_sand"
    // rust: | "minecraft:suspicious_gravel"
    // rust: | "minecraft:brushable_block"
    // rust: ) {
    // rust: return Some(Self::Brushable(Box::default()));
}
    // rust: if name == "minecraft:creaking_heart" {
    // rust: return Some(Self::CreakingHeart(Box::default()));
}
    // rust: if name == "minecraft:spawner" {
    // rust: return Some(Self::Spawner(Box::default()));
}
    // rust: if name == "minecraft:trial_spawner" {
    // rust: return Some(Self::TrialSpawner(Box::default()));
}
    // rust: if name == "minecraft:vault" {
    // rust: return Some(Self::Vault(Box::default()));
}
    // rust: if name == "minecraft:beehive" || name == "minecraft:bee_nest" {
    // rust: return Some(Self::Beehive(Box::default()));
}
    // rust: if name == "minecraft:lectern" {
    // rust: return Some(Self::Lectern(Lectern::default()));
}
    // rust: if crate::command_block::Mode::of_block(name).is_some() {
            // CommandBlock.newBlockEntity: setAutomatic(this.automatic).
    // rust: return Some(Self::CommandBlock(Box::new(
    // rust: crate::command_block::CommandBlock {
    // rust: auto: crate::command_block::automatic_block(name),
    // rust: ..Default::default()
    // rust: },
    // rust: )));
}
    // rust: if let Some(sculk) = crate::sculk::SculkEntity::for_block(name) {
    // rust: return Some(Self::Sculk(Box::new(sculk)));
}
    // rust: if name == "minecraft:crafter" {
            // CrafterBlock.newBlockEntity copies the placed state's flag: the
            // first tick sees it as a change from untriggered.
    // rust: return Some(Self::Crafter(Crafter {
    // rust: state_triggered: Some(false),
    // rust: ..Crafter::default()
    // rust: }));
}
    // rust: if name.ends_with("_banner") {
    // rust: return Some(Self::Banner(Banner::default()));
}
    // rust: if is_skull(name) {
    // rust: return Some(Self::Skull(Skull::default()));
}
    // rust: if name == "minecraft:end_gateway" {
    // rust: return Some(Self::EndGateway(EndGateway::default()));
}
    // rust: if name == "minecraft:daylight_detector" {
    // rust: return Some(Self::DaylightDetector);
}
    // rust: if name == "minecraft:beacon" {
    // rust: return Some(Self::Beacon(Box::new(Beacon {
    // rust: last_check_y: i32::MIN / 2,
    // rust: ..Default::default()
    // rust: })));
}
    // rust: if name == "minecraft:brewing_stand" {
    // rust: return Some(Self::Brewing(Box::new(crate::brewing::BrewingStand::new())));
}
    // rust: if name == "minecraft:campfire" || name == "minecraft:soul_campfire" {
    // rust: return Some(Self::Campfire(Box::default()));
}
    // rust: if name == "minecraft:jukebox" {
    // rust: return Some(Self::Jukebox(Jukebox::default()));
}
    // rust: if name == "minecraft:shelf" || name.ends_with("_shelf") {
    // rust: return Some(Self::Shelf(Box::default()));
}
    // rust: if name == "minecraft:chiseled_bookshelf" {
    // rust: return Some(Self::ChiseledBookshelf(Box::default()));
}
    // rust: if name == "minecraft:structure_block" {
            // The entity's mode is the state's (`StructureBlock.MODE`); the block's
            // state is not known here, so a new one starts in its default, SAVE.
    // rust: return Some(Self::StructureBlock(Box::new(
    // rust: crate::structure_block::StructureBlock::new(
    // rust: crate::structure_block::StructureMode::Save,
    // rust: ),
    // rust: )));
}
    // rust: if name == "minecraft:test_block" {
            // The mode is the state's, which is not known here.
    // rust: return Some(Self::TestBlock(Box::new(
    // rust: crate::test_block::TestBlock::new(crate::test_block::TestBlockMode::Fail),
    // rust: )));
}
    // rust: if name == "minecraft:test_instance_block" {
    // rust: return Some(Self::TestInstanceBlock(Box::default()));
}
    // rust: if name == "minecraft:jigsaw" {
    // rust: return Some(Self::JigsawBlock(Box::default()));
}
    // rust: if name == "minecraft:potent_sulfur" {
    // rust: return Some(Self::PotentSulfur(PotentSulfur::default()));
}
    // rust: Some(Self::Chest(vec![None; container_size(name)?]))
}
    // `BlockEntity.isValidBlockState`: whether this kind of entity belongs
    // under `name`'s block — vanilla keeps a set block's existing entity
    // only when its type is in the block's set, and drops it for the
    // block's own otherwise. Each kind fits the blocks `for_block` maps to
    // it (a furnace is its kind's, a sign only its standing or hanging
    // kind); a mod block's own can't tell its block here, so a non-vanilla
    // name is trusted — a name change drops it either way.
fits :: proc(self: ^Self, name: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Chest(items) => container_size(name) == Some(items.len()),
    // rust: Self::Furnace(f) => FurnaceKind::from_block(name) == Some(f.kind),
    // rust: Self::Sign(s) => crate::signs::sign_kind(name) == Some(s.hanging),
    // rust: Self::Sculk(s) => {
    // rust: crate::sculk::SculkEntity::for_block(name).is_some_and(|n| n.id() == s.id())
}
    // rust: Self::CommandBlock(_) => crate::command_block::Mode::of_block(name).is_some(),
    // rust: Self::Skull(_) => is_skull(name),
    // rust: Self::Banner(_) => name.ends_with("_banner"),
    // rust: Self::Shelf(_) => name == "minecraft:shelf" || name.ends_with("_shelf"),
    // rust: Self::Mod(_) => !name.starts_with("minecraft:"),
    // rust: Self::Beehive(_) => matches!(name, "minecraft:beehive" | "minecraft:bee_nest"),
    // rust: Self::Campfire(_) => {
    // rust: matches!(name, "minecraft:campfire" | "minecraft:soul_campfire")
}
    // rust: Self::Brushable(_) => matches!(
    // rust: name,
    // rust: "minecraft:suspicious_sand"
    // rust: | "minecraft:suspicious_gravel"
    // rust: | "minecraft:brushable_block"
    // rust: ),
    // rust: Self::Brewing(_) => name == "minecraft:brewing_stand",
    // rust: Self::Beacon(_) => name == "minecraft:beacon",
    // rust: Self::Jukebox(_) => name == "minecraft:jukebox",
    // rust: Self::Lectern(_) => name == "minecraft:lectern",
    // rust: Self::CreakingHeart(_) => name == "minecraft:creaking_heart",
    // rust: Self::Spawner(_) => name == "minecraft:spawner",
    // rust: Self::TrialSpawner(_) => name == "minecraft:trial_spawner",
    // rust: Self::Vault(_) => name == "minecraft:vault",
    // rust: Self::Crafter(_) => name == "minecraft:crafter",
    // rust: Self::EndGateway(_) => name == "minecraft:end_gateway",
    // rust: Self::DaylightDetector => name == "minecraft:daylight_detector",
    // rust: Self::StructureBlock(_) => name == "minecraft:structure_block",
    // rust: Self::TestBlock(_) => name == "minecraft:test_block",
    // rust: Self::TestInstanceBlock(_) => name == "minecraft:test_instance_block",
    // rust: Self::JigsawBlock(_) => name == "minecraft:jigsaw",
    // rust: Self::PotentSulfur(_) => name == "minecraft:potent_sulfur",
    // rust: Self::ChiseledBookshelf(_) => name == "minecraft:chiseled_bookshelf",
}
}
id :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Chest(items) => match items.len() {
    // rust: HOPPER_SLOTS => "minecraft:hopper",
    // rust: 9 => "minecraft:dispenser",
    // rust: _ => "minecraft:chest",
    // rust: },
    // rust: Self::Furnace(f) => match f.kind {
    // rust: FurnaceKind::Furnace => "minecraft:furnace",
    // rust: FurnaceKind::BlastFurnace => "minecraft:blast_furnace",
    // rust: FurnaceKind::Smoker => "minecraft:smoker",
    // rust: },
    // rust: Self::Brewing(_) => "minecraft:brewing_stand",
    // rust: Self::Sign(s) => s.id(),
    // rust: Self::Jukebox(_) => "minecraft:jukebox",
    // rust: Self::Beacon(_) => "minecraft:beacon",
    // rust: Self::Lectern(_) => "minecraft:lectern",
    // rust: Self::Sculk(s) => s.id(),
    // rust: Self::Banner(_) => "minecraft:banner",
    // rust: Self::Crafter(_) => "minecraft:crafter",
    // rust: Self::CreakingHeart(_) => "minecraft:creaking_heart",
    // rust: Self::Spawner(_) => "minecraft:mob_spawner",
    // rust: Self::TrialSpawner(_) => "minecraft:trial_spawner",
    // rust: Self::Vault(_) => "minecraft:vault",
    // rust: Self::Beehive(_) => "minecraft:beehive",
    // rust: Self::CommandBlock(_) => "minecraft:command_block",
    // rust: Self::Skull(_) => "minecraft:skull",
    // rust: Self::EndGateway(_) => "minecraft:end_gateway",
    // rust: Self::DaylightDetector => "minecraft:daylight_detector",
    // rust: Self::Brushable(_) => "minecraft:brushable_block",
    // rust: Self::Campfire(_) => "minecraft:campfire",
    // rust: Self::ChiseledBookshelf(_) => "minecraft:chiseled_bookshelf",
    // rust: Self::Shelf(_) => "minecraft:shelf",
    // rust: Self::Mod(m) => &m.id,
    // rust: Self::PotentSulfur(_) => "minecraft:potent_sulfur",
    // rust: Self::StructureBlock(_) => "minecraft:structure_block",
    // rust: Self::JigsawBlock(_) => "minecraft:jigsaw",
    // rust: Self::TestBlock(_) => "minecraft:test_block",
    // rust: Self::TestInstanceBlock(_) => "minecraft:test_instance_block",
}
}
contents :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Chest(items) => items.iter().flatten().cloned().collect(),
    // rust: Self::Furnace(f) => f.items.iter().flatten().cloned().collect(),
    // rust: Self::Brewing(b) => b.items.iter().flatten().cloned().collect(),
    // rust: Self::Sign(_) => Vec::new(),
    // rust: Self::Jukebox(j) => j.items.iter().flatten().cloned().collect(),
    // rust: Self::Beacon(_)
    // rust: | Self::CreakingHeart(_)
    // rust: | Self::Spawner(_)
    // rust: | Self::TrialSpawner(_)
    // rust: | Self::Vault(_)
    // rust: | Self::Beehive(_)
    // rust: | Self::CommandBlock(_)
    // rust: | Self::EndGateway(_)
    // rust: | Self::Skull(_)
    // rust: | Self::PotentSulfur(_)
    // rust: | Self::StructureBlock(_)
    // rust: | Self::JigsawBlock(_)
    // rust: | Self::TestBlock(_)
    // rust: | Self::TestInstanceBlock(_)
    // rust: | Self::DaylightDetector
    // rust: | Self::Brushable(_) => Vec::new(),
    // rust: Self::Mod(m) => m.items.iter().flatten().cloned().collect(),
    // rust: Self::Lectern(l) => l.book.iter().cloned().collect(),
    // rust: Self::Sculk(_) => Vec::new(),
    // rust: Self::Banner(_) => Vec::new(),
    // rust: Self::Crafter(c) => c.items.iter().flatten().cloned().collect(),
    // rust: Self::Campfire(c) => c.items.iter().flatten().cloned().collect(),
    // rust: Self::ChiseledBookshelf(b) => b.items.iter().flatten().cloned().collect(),
    // rust: Self::Shelf(b) => b.items.iter().flatten().cloned().collect(),
}
}
slots :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Chest(items) => items,
    // rust: Self::Furnace(f) => &f.items,
    // rust: Self::Brewing(b) => &b.items,
    // rust: Self::Sign(_)
    // rust: | Self::Beacon(_)
    // rust: | Self::Lectern(_)
    // rust: | Self::Sculk(_)
    // rust: | Self::Banner(_)
    // rust: | Self::EndGateway(_)
    // rust: | Self::Skull(_)
    // rust: | Self::PotentSulfur(_)
    // rust: | Self::StructureBlock(_)
    // rust: | Self::JigsawBlock(_)
    // rust: | Self::TestBlock(_)
    // rust: | Self::TestInstanceBlock(_)
    // rust: | Self::DaylightDetector
    // rust: | Self::Brushable(_) => &[],
    // rust: Self::Jukebox(j) => &j.items,
    // rust: Self::Crafter(c) => &c.items,
    // rust: Self::ChiseledBookshelf(b) => &b.items,
    // rust: Self::Shelf(b) => &b.items,
    // rust: Self::Mod(m) => &m.items,
    // rust: Self::CreakingHeart(_)
    // rust: | Self::Spawner(_)
    // rust: | Self::TrialSpawner(_)
    // rust: | Self::Vault(_)
    // rust: | Self::Beehive(_)
    // rust: | Self::CommandBlock(_)
            // Not a Container (only Clearable): hoppers don't reach in.
    // rust: | Self::Campfire(_) => &[],
}
}
slots_mut :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Chest(items) => items,
    // rust: Self::Furnace(f) => &mut f.items,
    // rust: Self::Brewing(b) => &mut b.items,
    // rust: Self::Sign(_)
    // rust: | Self::Beacon(_)
    // rust: | Self::Lectern(_)
    // rust: | Self::Sculk(_)
    // rust: | Self::Banner(_)
    // rust: | Self::EndGateway(_)
    // rust: | Self::Skull(_)
    // rust: | Self::PotentSulfur(_)
    // rust: | Self::StructureBlock(_)
    // rust: | Self::JigsawBlock(_)
    // rust: | Self::TestBlock(_)
    // rust: | Self::TestInstanceBlock(_)
    // rust: | Self::DaylightDetector
    // rust: | Self::Brushable(_) => &mut [],
    // rust: Self::Jukebox(j) => &mut j.items,
    // rust: Self::Crafter(c) => &mut c.items,
    // rust: Self::ChiseledBookshelf(b) => &mut b.items,
    // rust: Self::Shelf(b) => &mut b.items,
    // rust: Self::Mod(m) => &mut m.items,
    // rust: Self::CreakingHeart(_)
    // rust: | Self::Spawner(_)
    // rust: | Self::TrialSpawner(_)
    // rust: | Self::Vault(_)
    // rust: | Self::Beehive(_)
    // rust: | Self::CommandBlock(_)
    // rust: | Self::Campfire(_) => &mut [],
}
}
}
    // rust: pub use crate::providers::Providers;

// A `ChestBlock`, which `ChestBlock.combine` can join into a double chest:
// chests, trapped chests and copper chests in every weathering state, waxed
// or not (`CopperChestBlock` extends `ChestBlock`). Ender chests are
// `EnderChestBlock`s and always single.
is_chest_block :: proc(name: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(name, "minecraft:chest" | "minecraft:trapped_chest") || name.ends_with("copper_chest")
}

// A chest block's name with its `type` and `facing` properties.
ChestHalf :: struct {
    block: ^'a str,
    kind: ^'a str,
    facing: ^'a str,
}

    // rust: impl ChestHalf<'_> {
    // `ChestBlock.getConnectedDirection` as an (x, z) step to the other
    // half: clockwise from the facing for a left half, counter-clockwise for
    // a right one. None for a single chest.
connected_step :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let step = |facing: &str| match facing {
    // rust: "north" => Some((0, -1)),
    // rust: "south" => Some((0, 1)),
    // rust: "west" => Some((-1, 0)),
    // rust: "east" => Some((1, 0)),
    // rust: _ => None,
}
    // rust: let (x, z) = step(self.facing)?;
        // Turning clockwise seen from above takes (x, z) to (-z, x).
    // rust: match self.kind {
    // rust: "left" => Some((-z, x)),
    // rust: "right" => Some((z, -x)),
    // rust: _ => None,
}
}

    // `DoubleBlockCombiner.combineWithNeigbour` as `ChestBlock.combine` calls
    // it: `other`, the block in this half's connected direction, is its other
    // half when it is the same block, a half of the other side and faces the
    // same way. Copper chests in different weathering states never join
    // (`CopperChestBlock` keeps both halves in one state instead).
pairs_with :: proc(self: ^Self, other: ^ChestHalf) -> b {
    // Ported from Horizon
    return {}
}
    // rust: is_chest_block(self.block)
    // rust: && self.kind != "single"
    // rust: && other.block == self.block
    // rust: && other.kind != "single"
    // rust: && other.kind != self.kind
    // rust: && other.facing == self.facing
}
}

// `AbstractFurnaceBlockEntity.createExperience`: `count * experience`, floored, and one
// more with the chance of what is left over (a level random draw only when there is some).
    // rust: pub fn create_experience(
    // rust: count: u32,
    // rust: experience: f32,
    // rust: random: &mut impl horizon_core::random::RandomSource,
    // rust: ) -> u32 {
    // rust: let total = count as f32 * experience;
    // rust: let whole = total.floor();
    // rust: let fraction = total - whole;
    // rust: let mut xp = whole.max(0.0) as u32;
    // rust: if fraction != 0.0 && random.next_float() < fraction {
    // rust: xp += 1;
}
    // rust: xp
}

// The `MenuType` the block entity of a one-block storage container opens
// (`createMenu`): `ChestMenu.threeRows` for chests, trapped and copper chests
// and barrels, `ShulkerBoxMenu` for shulker boxes of any colour (its
// `ShulkerBoxSlot`s refuse shulker boxes), `DispenserMenu` for dispensers
// and droppers, `HopperMenu` for hoppers. None for other blocks.
block_menu_type :: proc(block: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(match block {
    // rust: "minecraft:chest" | "minecraft:trapped_chest" | "minecraft:barrel" => {
    // rust: "minecraft:generic_9x3"
}
    // rust: n if n.ends_with("copper_chest") => "minecraft:generic_9x3",
    // rust: n if n.ends_with("shulker_box") => "minecraft:shulker_box",
    // rust: "minecraft:dispenser" | "minecraft:dropper" => "minecraft:generic_3x3",
    // rust: "minecraft:hopper" => "minecraft:hopper",
    // rust: _ => return None,
    // rust: })
}

    // rust: mod tests {
//     use super::*;
//     use horizon_core::random::{LegacyRandom, RandomSource};

    // a client that isn't Horizon's is sent vanilla's menu types only.
a_mod_menu_type_reaches_horizon_clients_only :: proc() {
}
    // rust: assert!(menu_reaches("horizon", "ruby:press"));
    // rust: assert!(!menu_reaches("vanilla", "ruby:press"));
    // rust: assert!(!menu_reaches("fabric", "ruby:press"));
    // rust: assert!(menu_reaches("vanilla", "minecraft:generic_9x3"));
}

a_campfire_is_idle_only_while_its_tick_changes_nothing :: proc() {
}
    // rust: let mut c = Campfire::default();
    // rust: assert!(c.idle(true) && c.idle(false));
    // rust: assert!(c.place_food(&mut ItemStack::new("minecraft:beef", 1), 600));
    // rust: assert!(!c.idle(true));
    // rust: assert!(c.idle(false));
    // rust: c.cook_tick();
    // rust: assert!(!c.idle(false));
    // rust: c.cooldown_tick();
    // rust: assert!(c.idle(false));
}

    // The campfire sleeps while `idle`, so the tick its block runs (`cook_tick` lit,
    // `cooldown_tick` unlit) must change nothing then, and must change an awake one.
an_idle_campfire_tick_changes_nothing :: proc() {
}
    // rust: let tick = |c: &mut Campfire, lit: bool| {
    // rust: if lit {
    // rust: !c.cook_tick().is_empty()
    // rust: } else {
    // rust: c.cooldown_tick()
}
}
    // rust: let empty = Campfire::default();
    // rust: let mut food = Campfire::default();
    // rust: assert!(food.place_food(&mut ItemStack::new("minecraft:beef", 1), 600));
    // rust: let mut warm = food.clone();
    // rust: warm.cook_tick();
    // rust: let mut cooled = warm.clone();
    // rust: while cooled.cooldown_tick() {}
    // rust: for (before, lit) in [
    // rust: (&empty, true),
    // rust: (&empty, false),
    // rust: (&food, false),
    // rust: (&cooled, false),
    // rust: ] {
    // rust: assert!(before.idle(lit), "{before:?} lit {lit}");
    // rust: let mut after = before.clone();
    // rust: assert!(!tick(&mut after, lit));
    // rust: assert_eq!(&after, before, "lit {lit}");
}
    // rust: for (before, lit) in [(&food, true), (&warm, false)] {
    // rust: assert!(!before.idle(lit), "{before:?} lit {lit}");
    // rust: let mut after = before.clone();
    // rust: tick(&mut after, lit);
    // rust: assert_ne!(&after, before, "lit {lit}");
}
}

campfire_slots_take_food_cook_it_and_cool_down :: proc() {
}
    // rust: let mut c = Campfire::default();
    // rust: let mut beef = ItemStack::new("minecraft:beef", 2);
        // placeFood: the first free slot, one item, its recipe's time.
    // rust: assert!(c.place_food(&mut beef, 600));
    // rust: assert_eq!(beef.count, 1);
    // rust: assert_eq!(c.items[0].as_ref().map(|s| s.count), Some(1));
    // rust: assert_eq!((c.progress[0], c.total[0]), (0, 600));
    // rust: let mut fish = ItemStack::new("minecraft:cod", 1);
    // rust: assert!(c.place_food(&mut fish, 3));
    // rust: assert_eq!(c.items[1].as_ref().map(|s| &*s.item), Some("minecraft:cod"));
        // cookTick: the cod is done on its third tick, the beef keeps cooking.
    // rust: assert!(c.cook_tick().is_empty());
    // rust: assert!(c.cook_tick().is_empty());
    // rust: let done = c.cook_tick();
    // rust: assert_eq!(done.len(), 1);
    // rust: assert_eq!((done[0].0, &*done[0].1.item), (1, "minecraft:cod"));
    // rust: assert!(c.items[1].is_none());
    // rust: assert_eq!(c.progress[0], 3);
        // cooldownTick: two a tick, never below zero.
    // rust: assert!(c.cooldown_tick());
    // rust: assert_eq!(c.progress[0], 1);
    // rust: assert!(c.cooldown_tick());
    // rust: assert_eq!(c.progress[0], 0);
        // Full: four slots, no fifth.
    // rust: for _ in 0..3 {
    // rust: let mut more = ItemStack::new("minecraft:potato", 1);
    // rust: assert!(c.place_food(&mut more, 600));
}
    // rust: let mut fifth = ItemStack::new("minecraft:potato", 1);
    // rust: assert!(!c.place_food(&mut fifth, 600));
    // rust: assert_eq!(fifth.count, 1);
}

    // `JukeboxBlockEntity`'s single slot is a `Container` slot, so a hopper
    // (`HopperBlockEntity.getContainerAt`) can reach the disc in it.
a_jukebox_offers_its_record_as_its_one_container_slot :: proc() {
}
    // rust: let mut entity = BlockEntity::Jukebox(Jukebox::default());
    // rust: assert_eq!(entity.slots().len(), 1);
    // rust: assert!(entity.slots()[0].is_none(), "empty until a disc lands");
    // rust: let disc = ItemStack::new("minecraft:cat", 1);
    // rust: entity.slots_mut()[0] = Some(disc.clone());
    // rust: let slots = entity.slots();
    // rust: assert_eq!(slots[0].as_ref().map(|s| &*s.item), Some("minecraft:cat"));
    // rust: match &entity {
    // rust: BlockEntity::Jukebox(j) => {
    // rust: assert_eq!(j.record().map(|s| &*s.item), Some("minecraft:cat"));
}
    // rust: _ => panic!("a jukebox"),
}
    // rust: assert_eq!(entity.contents().len(), 1);
}

    // A placed jukebox gets its block entity (`JukeboxBlock.newBlockEntity`),
    // so the item's block entity data lands somewhere and the box can hold a
    // disc without a player putting one in.
a_placed_jukebox_starts_as_an_empty_jukebox_entity :: proc() {
}
    // rust: let entity = BlockEntity::for_block("minecraft:jukebox").expect("a jukebox");
    // rust: assert_eq!(entity.id(), "minecraft:jukebox");
    // rust: assert!(matches!(entity, BlockEntity::Jukebox(_)));
    // rust: assert_eq!(entity.slots().len(), 1);
    // rust: assert!(entity.slots()[0].is_none());
        // Another block's name is not a jukebox.
    // rust: assert!(BlockEntity::for_block("minecraft:stone").is_none());
}

    // A whole amount pays itself without a draw; a fraction is a chance of one more.
create_experience_rounds_the_fraction_by_chance :: proc() {
}
    // rust: let mut random = LegacyRandom::new(7);
    // rust: let mut untouched = LegacyRandom::new(7);
    // rust: assert_eq!(create_experience(4, 0.5, &mut random), 2);
    // rust: assert_eq!(create_experience(3, 0.0, &mut random), 0);
    // rust: assert_eq!(random.next_long(), untouched.next_long());
    // rust: let paid: u32 = (0..1000)
    // rust: .map(|_| create_experience(1, 0.35, &mut random))
    // rust: .sum();
    // rust: assert!((250..450).contains(&paid), "{paid}");
    // rust: assert!((0..100).all(|_| (1..=2).contains(&create_experience(1, 1.7, &mut random))));
}
}
