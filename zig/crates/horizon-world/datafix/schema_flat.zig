//! Transpiled from Horizon Rust crate
//! Module: horizon-world_schema_flat
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The schemas of before 1.14 (keys below 1800): V99 to V1510 as far as the fixes
//! of those versions look. [`Walker::legacy_children`] answers for the types whose
//! shape differs from the general code of [`super`]; the other types fall through.
// use super::{Key, Ty, Walker, as_str, key, namespaced};
// use crate::nbt::Tag;
// use std::cell::Cell;
// use std::collections::HashSet;
// use std::sync::OnceLock;

/// DataFixerUpper reads the data once, with the schema of its version: an entity tree
/// of an id that schema does not register stays untyped for good, even when a later
/// schema registers the id. Such a tree carries this key until the data is written.
    // rust: pub(in crate::datafix) const UNTYPED: &str = "\u{0}untyped";

    // rust: thread_local! {
    /// Set while the data is read with its own schema: the walkers mark what is untyped.
pub const MARKING: Cell<bool> = const { Cell::new(false) };
}

/// Mark the untyped entity trees of data read with the schema at `k`.
    // rust: pub(in crate::datafix) fn mark_untyped(root: Ty, data: &mut Tag, k: Key) {
    // rust: if k >= END {
    // rust: return;
}
    // rust: MARKING.with(|m| m.set(true));
    // rust: super::walk(root, data, k, Ty::BlockEntity, &mut |_| {});
    // rust: MARKING.with(|m| m.set(false));
}

/// Remove the untyped marks of `v` (it is read again).
    // rust: pub(in crate::datafix) fn strip_untyped(v: &mut Tag) {
    // rust: match v {
    // rust: Tag::Compound(c) => {
    // rust: c.remove(&crate::datafix::dynamic::key(UNTYPED));
    // rust: c.values_mut().for_each(strip_untyped);
}
    // rust: Tag::List(items) => items.iter_mut().for_each(strip_untyped),
    // rust: _ => {}
}
}

pub fn mark(tree: *mut Tag) void {
}
    // rust: if let Tag::Compound(_) = tree {
    // rust: crate::datafix::dynamic::set(tree, UNTYPED, Tag::Byte(1));
}
}

/// Whether every tree of a list reads as typed (a list reads only if all its elements do);
/// while the data is read, the trees of a list that does not are marked.
    // rust: pub(in crate::datafix) fn all_trees_typed(trees: &mut [Tag], k: Key) -> bool {
    // rust: let ok = trees.iter().all(|t| entity_tree_known(t, k));
    // rust: if !ok && MARKING.with(Cell::get) {
    // rust: trees.iter_mut().for_each(mark);
}
    // rust: ok
}

/// The schemas below this key are described here.
    // rust: pub(in crate::datafix) const END: Key = key(1800, 0);

    // rust: impl Walker<'_> {
    /// `children` for a schema below [`END`]; false when the general code applies.
    // rust: pub(super) fn legacy_children(&mut self, ty: Ty, v: &mut Tag) -> bool {
    // rust: let k = self.k;
    // rust: match ty {
    // rust: Ty::Entity => {
    // rust: if k < key(705, 0) {
    // rust: self.legacy_entity_old(v);
    // rust: } else {
    // rust: self.legacy_entity(v);
}
    // rust: true
}
            // An entity of an unknown id does not read as a typed value: nothing in it is fixed.
    // rust: Ty::EntityTree => {
    // rust: if entity_tree_known(v, k) {
    // rust: if k < key(135, 0) {
                        // The vehicle this entity rides is a tree of its own.
    // rust: if let Some(vehicle) = v.get_mut("Riding") {
    // rust: if entity_tree_known(vehicle, k) {
    // rust: self.walk(Ty::EntityTree, vehicle);
    // rust: } else if MARKING.with(Cell::get) {
    // rust: mark(vehicle);
}
}
    // rust: } else if let Some(Tag::List(trees)) = v.get_mut("Passengers")
    // rust: && all_trees_typed(trees, k)
    // rust: {
    // rust: for tree in trees {
    // rust: self.walk(Ty::EntityTree, tree);
}
}
    // rust: self.walk(Ty::Entity, v);
    // rust: } else if MARKING.with(Cell::get) {
    // rust: mark(v);
}
    // rust: true
}
    // rust: Ty::UntaggedSpawner if k >= key(106, 0) => {
    // rust: self.legacy_untagged_spawner(v);
    // rust: true
}
    // rust: Ty::BlockEntity if k < key(704, 0) => {
    // rust: self.legacy_block_entity_old(v);
    // rust: true
}
    // rust: Ty::Chunk => {
    // rust: if let Some(level) = v.get_mut("Level") {
    // rust: self.legacy_level_chunk(level);
}
    // rust: true
}
            // STATS is a plain map until V1451_6 turns it into typed counters.
    // rust: Ty::Stats if k < key(1451, 6) => true,
    // rust: Ty::Objective if k < key(1451, 6) => {
    // rust: self.field(Ty::TextComponent, v, "DisplayName");
    // rust: true
}
    // rust: _ => false,
}
}

    /// The `Level` of a chunk (V99 to V1510).
pub fn legacy_level_chunk(self: *Self, v: *mut Tag) void {
}
    // rust: let k = self.k;
        // A list of entity trees reads only if every entity of it is known.
    // rust: if let Some(Tag::List(trees)) = v.get_mut("Entities")
    // rust: && all_trees_typed(trees, k)
    // rust: {
    // rust: for tree in trees {
    // rust: self.walk(Ty::EntityTree, tree);
}
}
    // rust: if let Some(Tag::List(items)) = v.get_mut("TileEntities") {
    // rust: for be in items {
    // rust: if super::block_entity_known(be, k) {
    // rust: self.walk(Ty::BlockEntity, be);
}
}
}
    // rust: self.list_of_field(Ty::BlockName, v, "TileTicks", "i");
    // rust: if k >= key(1451, 1)
    // rust: && let Some(Tag::List(sections)) = v.get_mut("Sections")
    // rust: {
    // rust: for s in sections {
    // rust: self.list(Ty::BlockState, s, "Palette");
}
}
    // rust: if k >= key(1466, 0)
    // rust: && let Some(s) = v.get_mut("Structures")
    // rust: {
    // rust: self.values(Ty::StructureFeature, s, "Starts");
}
}

    /// `UNTAGGED_SPAWNER` of V106 to V2830: the potential entities are a list that
    /// reads only if all of them do.
pub fn legacy_untagged_spawner(self: *Self, v: *mut Tag) void {
}
    // rust: let k = self.k;
    // rust: if let Some(Tag::List(potentials)) = v.get_mut("SpawnPotentials") {
    // rust: let mut trees: Vec<Option<&mut Tag>> =
    // rust: potentials.iter_mut().map(|p| p.get_mut("Entity")).collect();
    // rust: let ok = trees
    // rust: .iter()
    // rust: .all(|t| t.as_deref().is_some_and(|t| entity_tree_known(t, k)));
    // rust: if ok {
    // rust: for tree in trees.iter_mut().flatten() {
    // rust: self.walk(Ty::EntityTree, tree);
}
    // rust: } else if MARKING.with(Cell::get) {
    // rust: trees.iter_mut().flatten().for_each(|t| mark(t));
}
}
    // rust: self.field(Ty::EntityTree, v, "SpawnData");
}

    /// `ENTITY` of the schemas V99 to V703 (CamelCase ids).
pub fn legacy_entity_old(self: *Self, v: *mut Tag) void {
}
    // rust: let k = self.k;
    // rust: if k < key(100, 0) {
    // rust: self.list(Ty::ItemStack, v, "Equipment");
    // rust: } else {
    // rust: self.list(Ty::ItemStack, v, "ArmorItems");
    // rust: self.list(Ty::ItemStack, v, "HandItems");
}
    // rust: let id = as_str(v.get("id")).unwrap_or_default();
    // rust: match id.as_str() {
    // rust: "Item" | "ItemFrame" => self.field(Ty::ItemStack, v, "Item"),
    // rust: "ThrownEgg" | "Snowball" | "Fireball" | "SmallFireball" | "ThrownEnderpearl"
    // rust: | "ThrownExpBottle" | "WitherSkull" | "Arrow" | "TippedArrow" | "SpectralArrow" => {
    // rust: self.field(Ty::BlockName, v, "inTile")
}
    // rust: "ThrownPotion" => {
    // rust: self.field(Ty::BlockName, v, "inTile");
    // rust: self.field(Ty::ItemStack, v, "Potion");
}
    // rust: "FallingSand" => {
    // rust: self.field(Ty::BlockName, v, "Block");
    // rust: self.field(Ty::BlockEntity, v, "TileEntityData");
}
    // rust: "FireworksRocketEntity" => self.field(Ty::ItemStack, v, "FireworksItem"),
    // rust: "Minecart" | "MinecartChest" | "MinecartHopper" => {
    // rust: self.field(Ty::BlockName, v, "DisplayTile");
    // rust: self.list(Ty::ItemStack, v, "Items");
}
    // rust: "MinecartRideable" | "MinecartFurnace" | "MinecartTNT" => {
    // rust: self.field(Ty::BlockName, v, "DisplayTile")
}
    // rust: "MinecartSpawner" => {
    // rust: self.field(Ty::BlockName, v, "DisplayTile");
    // rust: self.spawner(v);
}
    // rust: "MinecartCommandBlock" => {
    // rust: self.field(Ty::BlockName, v, "DisplayTile");
    // rust: self.field(Ty::TextComponent, v, "LastOutput");
}
    // rust: "Enderman" => self.field(Ty::BlockName, v, "carried"),
    // rust: "EntityHorse" => {
    // rust: self.list(Ty::ItemStack, v, "Items");
    // rust: self.field(Ty::ItemStack, v, "ArmorItem");
    // rust: self.field(Ty::ItemStack, v, "SaddleItem");
}
    // rust: "Horse" => {
    // rust: self.field(Ty::ItemStack, v, "ArmorItem");
    // rust: self.field(Ty::ItemStack, v, "SaddleItem");
}
    // rust: "Donkey" | "Mule" => {
    // rust: self.list(Ty::ItemStack, v, "Items");
    // rust: self.field(Ty::ItemStack, v, "SaddleItem");
}
    // rust: "ZombieHorse" | "SkeletonHorse" => self.field(Ty::ItemStack, v, "SaddleItem"),
    // rust: "Villager" => {
    // rust: self.list(Ty::ItemStack, v, "Inventory");
    // rust: if let Some(o) = v.get_mut("Offers") {
    // rust: self.list(Ty::VillagerTrade, o, "Recipes");
}
}
    // rust: "ZombieVillager" => {
    // rust: if let Some(o) = v.get_mut("Offers") {
    // rust: self.list(Ty::VillagerTrade, o, "Recipes");
}
}
    // rust: "AreaEffectCloud" => self.field(Ty::Particle, v, "Particle"),
    // rust: _ => {}
}
}

    /// `BLOCK_ENTITY` of the schemas V99 to V703 (CamelCase ids).
pub fn legacy_block_entity_old(self: *Self, v: *mut Tag) void {
}
    // rust: let id = as_str(v.get("id")).unwrap_or_default();
    // rust: match id.as_str() {
    // rust: "Furnace" | "Chest" | "Trap" | "Dropper" | "Cauldron" | "Hopper" => {
    // rust: self.list(Ty::ItemStack, v, "Items")
}
    // rust: "RecordPlayer" => self.field(Ty::ItemStack, v, "RecordItem"),
    // rust: "Sign" => {
    // rust: for line in ["Text1", "Text2", "Text3", "Text4"] {
    // rust: self.field(Ty::TextComponent, v, line);
}
}
    // rust: "MobSpawner" => self.spawner(v),
    // rust: "FlowerPot" => self.field(Ty::ItemName, v, "Item"),
    // rust: "Control" => self.field(Ty::TextComponent, v, "LastOutput"),
    // rust: "Banner" => self.field(Ty::TextComponent, v, "CustomName"),
    // rust: _ => {}
}
}

    /// `ENTITY` of the schemas V705 to V1510 (the ids are `minecraft:...` since V704).
pub fn legacy_entity(self: *Self, v: *mut Tag) void {
}
    // rust: let k = self.k;
    // rust: self.list(Ty::ItemStack, v, "ArmorItems");
    // rust: self.list(Ty::ItemStack, v, "HandItems");
    // rust: self.field(Ty::TextComponent, v, "CustomName");
    // rust: let id = namespaced(&as_str(v.get("id")).unwrap_or_default());
        // V1451_3 flattens the blocks of entities; V1510 renames some entities.
    // rust: let blocks_as_names = k < key(1451, 3);
    // rust: let renamed = k >= key(1510, 0);
    // rust: let block = |w: &mut Self, v: &mut Tag, old: &str, new: &str| {
    // rust: if blocks_as_names {
    // rust: w.field(Ty::BlockName, v, old);
    // rust: } else {
    // rust: w.field(Ty::BlockState, v, new);
}
}
    // rust: match id.as_str() {
    // rust: "minecraft:area_effect_cloud" => self.field(Ty::Particle, v, "Particle"),
    // rust: "minecraft:arrow" | "minecraft:spectral_arrow" => {
    // rust: block(self, v, "inTile", "inBlockState")
}
    // rust: "minecraft:egg"
    // rust: | "minecraft:ender_pearl"
    // rust: | "minecraft:fireball"
    // rust: | "minecraft:small_fireball"
    // rust: | "minecraft:snowball"
    // rust: | "minecraft:wither_skull" => {
    // rust: if blocks_as_names {
    // rust: self.field(Ty::BlockName, v, "inTile");
}
}
    // rust: "minecraft:xp_bottle" if !renamed => {
    // rust: if blocks_as_names {
    // rust: self.field(Ty::BlockName, v, "inTile");
}
}
    // rust: "minecraft:potion" => {
    // rust: self.field(Ty::ItemStack, v, "Potion");
    // rust: if blocks_as_names {
    // rust: self.field(Ty::BlockName, v, "inTile");
}
}
    // rust: "minecraft:trident" => {
    // rust: self.field(Ty::BlockState, v, "inBlockState");
    // rust: self.field(Ty::ItemStack, v, "Trident");
}
    // rust: "minecraft:chest_minecart" | "minecraft:hopper_minecart" => {
    // rust: block(self, v, "DisplayTile", "DisplayState");
    // rust: self.list(Ty::ItemStack, v, "Items");
}
    // rust: "minecraft:minecart" | "minecraft:furnace_minecart" | "minecraft:tnt_minecart" => {
    // rust: block(self, v, "DisplayTile", "DisplayState");
}
    // rust: "minecraft:commandblock_minecart" if !renamed => {
    // rust: block(self, v, "DisplayTile", "DisplayState");
    // rust: self.field(Ty::TextComponent, v, "LastOutput");
}
    // rust: "minecraft:command_block_minecart" if renamed => {
    // rust: block(self, v, "DisplayTile", "DisplayState");
    // rust: self.field(Ty::TextComponent, v, "LastOutput");
}
    // rust: "minecraft:spawner_minecart" => {
    // rust: block(self, v, "DisplayTile", "DisplayState");
    // rust: self.spawner(v);
}
    // rust: "minecraft:enderman" => block(self, v, "carried", "carriedBlockState"),
    // rust: "minecraft:falling_block" => {
    // rust: block(self, v, "Block", "BlockState");
    // rust: self.field(Ty::BlockEntity, v, "TileEntityData");
}
    // rust: "minecraft:fireworks_rocket" if !renamed => {
    // rust: self.field(Ty::ItemStack, v, "FireworksItem")
}
    // rust: "minecraft:firework_rocket" if renamed => self.field(Ty::ItemStack, v, "FireworksItem"),
    // rust: "minecraft:item" | "minecraft:item_frame" => self.field(Ty::ItemStack, v, "Item"),
    // rust: "minecraft:horse" => {
    // rust: self.field(Ty::ItemStack, v, "ArmorItem");
    // rust: self.field(Ty::ItemStack, v, "SaddleItem");
}
    // rust: "minecraft:donkey" | "minecraft:mule" => {
    // rust: self.list(Ty::ItemStack, v, "Items");
    // rust: self.field(Ty::ItemStack, v, "SaddleItem");
}
    // rust: "minecraft:llama" => {
    // rust: self.list(Ty::ItemStack, v, "Items");
    // rust: self.field(Ty::ItemStack, v, "SaddleItem");
    // rust: self.field(Ty::ItemStack, v, "DecorItem");
}
    // rust: "minecraft:skeleton_horse" | "minecraft:zombie_horse" => {
    // rust: self.field(Ty::ItemStack, v, "SaddleItem");
}
    // rust: "minecraft:villager" => {
    // rust: self.list(Ty::ItemStack, v, "Inventory");
    // rust: if let Some(o) = v.get_mut("Offers") {
    // rust: self.list(Ty::VillagerTrade, o, "Recipes");
}
}
    // rust: "minecraft:zombie_villager" => {
    // rust: if let Some(o) = v.get_mut("Offers") {
    // rust: self.list(Ty::VillagerTrade, o, "Recipes");
}
}
    // rust: _ => {}
}
}
}

/// Whether the block entity id is registered in the schema at `k` (before 1.14).
    // rust: pub(super) fn legacy_block_entity_known(id: &str, k: Key) -> bool {
    // rust: if k < key(704, 0) {
    // rust: return crate::datafix::flat_tables::BLOCK_ENTITIES_V99.contains(&id);
}
    // rust: match id {
    // rust: "minecraft:furnace"
    // rust: | "minecraft:chest"
    // rust: | "minecraft:ender_chest"
    // rust: | "minecraft:jukebox"
    // rust: | "minecraft:dispenser"
    // rust: | "minecraft:dropper"
    // rust: | "minecraft:sign"
    // rust: | "minecraft:mob_spawner"
    // rust: | "minecraft:piston"
    // rust: | "minecraft:brewing_stand"
    // rust: | "minecraft:enchanting_table"
    // rust: | "minecraft:end_portal"
    // rust: | "minecraft:beacon"
    // rust: | "minecraft:skull"
    // rust: | "minecraft:daylight_detector"
    // rust: | "minecraft:hopper"
    // rust: | "minecraft:comparator"
    // rust: | "minecraft:banner"
    // rust: | "minecraft:structure_block"
    // rust: | "minecraft:end_gateway"
    // rust: | "minecraft:command_block" => true,
        // V808 adds the shulker box.
    // rust: "minecraft:shulker_box" => k >= key(808, 0),
        // Registered by V1125 and dropped by V1451_5.
    // rust: "minecraft:bed" => k >= key(1125, 0),
    // rust: "minecraft:noteblock" | "minecraft:flower_pot" => k < key(1451, 5),
    // rust: "minecraft:trapped_chest" => k >= key(1451, 0),
    // rust: "DUMMY" => k >= key(1466, 0),
    // rust: "minecraft:conduit" => k >= key(1481, 0),
    // rust: _ => false,
}
}

/// Whether `id` is an entity registered by the schema at `k` (V705 to V1510).
    // rust: pub(in crate::datafix) fn legacy_entity_known(id: &str, k: Key) -> bool {
    // rust: if k < key(705, 0) {
    // rust: return old_entity_known(id, k);
}
pub const ERAS: OnceLock<[std.AutoHashMap([]const u8, void); 5]> = OnceLock::new();
    // rust: let eras = ERAS.get_or_init(|| {
    // rust: let mut set: HashSet<String> = crate::datafix::flat_tables::ENTITIES_V1460
    // rust: .iter()
    // rust: .map(|s| (*s).to_owned())
    // rust: .collect();
    // rust: let rename = |set: &mut HashSet<String>, from: &str, to: &str| {
    // rust: if set.remove(from) {
    // rust: set.insert(to.to_owned());
}
}
    // rust: let base = set.clone();
        // V1470
    // rust: for id in [
    // rust: "turtle",
    // rust: "cod_mob",
    // rust: "tropical_fish",
    // rust: "salmon_mob",
    // rust: "puffer_fish",
    // rust: "phantom",
    // rust: "dolphin",
    // rust: "drowned",
    // rust: "trident",
    // rust: ] {
    // rust: set.insert(format!("minecraft:{id}"));
}
    // rust: let v1470 = set.clone();
    // rust: rename(&mut set, "minecraft:puffer_fish", "minecraft:pufferfish");
    // rust: let v1483 = set.clone();
    // rust: rename(&mut set, "minecraft:cod_mob", "minecraft:cod");
    // rust: rename(&mut set, "minecraft:salmon_mob", "minecraft:salmon");
    // rust: let v1486 = set.clone();
    // rust: for (from, to) in [
    // rust: ("commandblock_minecart", "command_block_minecart"),
    // rust: ("ender_crystal", "end_crystal"),
    // rust: ("snowman", "snow_golem"),
    // rust: ("evocation_illager", "evoker"),
    // rust: ("evocation_fangs", "evoker_fangs"),
    // rust: ("illusion_illager", "illusioner"),
    // rust: ("vindication_illager", "vindicator"),
    // rust: ("villager_golem", "iron_golem"),
    // rust: ("xp_orb", "experience_orb"),
    // rust: ("xp_bottle", "experience_bottle"),
    // rust: ("eye_of_ender_signal", "eye_of_ender"),
    // rust: ("fireworks_rocket", "firework_rocket"),
    // rust: ] {
    // rust: rename(
    // rust: &mut set,
    // rust: &format!("minecraft:{from}"),
    // rust: &format!("minecraft:{to}"),
    // rust: );
}
    // rust: [base, v1470, v1483, v1486, set]
    // rust: });
    // rust: let era = if k < key(1470, 0) {
    // rust: 0
    // rust: } else if k < key(1483, 0) {
    // rust: 1
    // rust: } else if k < key(1486, 0) {
    // rust: 2
    // rust: } else if k < key(1510, 0) {
    // rust: 3
    // rust: } else {
    // rust: 4
}
    // rust: eras[era].contains(id)
}

/// Whether the entity tree's own entity reads as a typed value at `k`.
    // rust: pub(in crate::datafix) fn entity_tree_known(tree: &Tag, k: Key) -> bool {
    // rust: tree.get(UNTYPED).is_none()
    // rust: && legacy_entity_known(&namespaced(&as_str(tree.get("id")).unwrap_or_default()), k)
}

/// Whether `id` is an entity registered by the schemas V99 to V703 (CamelCase ids).
pub fn old_entity_known(id: []const u8, k: Key) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match id {
    // rust: "Minecart" => k < key(107, 0),
    // rust: "TippedArrow" => k < key(143, 0),
    // rust: "PolarBear" => k >= key(501, 0),
    // rust: "ElderGuardian" => k >= key(700, 0),
    // rust: "WitherSkeleton" | "Stray" => k >= key(701, 0),
    // rust: "ZombieVillager" | "Husk" => k >= key(702, 0),
    // rust: "Horse" | "Donkey" | "Mule" | "ZombieHorse" | "SkeletonHorse" => k >= key(703, 0),
    // rust: "EntityHorse" => k < key(703, 0),
    // rust: _ => crate::datafix::flat_tables::ENTITIES_V99.contains(&id),
}
}
