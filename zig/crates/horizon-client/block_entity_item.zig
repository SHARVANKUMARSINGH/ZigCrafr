//! Transpiled from Horizon Rust crate
//! Module: horizon-client_block_entity_item
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Block entities carried by items, vanilla 26.3: Ctrl + Pick Block in creative
//! (`ServerGamePacketListenerImpl.addBlockDataToItem`) and placing such an item
//! (`BlockItem.updateCustomBlockEntityTag`, then
//! `BlockEntity.applyComponentsFromItemStack`). Both work on the block entity's
//! saved NBT (`block_entity_nbt::canonical`) and the item's component patch.
//!
//! What a type turns into item components (`removeComponentsFromTag`,
//! `collectImplicitComponents`) leaves its NBT; the rest goes to
//! `minecraft:block_entity_data`, tagged with the type's id.
// use crate::block_entity_nbt::{self, canonical};
// use horizon_world::nbt::{Compound, JavaString, Tag};

pub const BLOCK_ENTITY_DATA: []const u8 = "minecraft:block_entity_data";

/// `BlockEntityTypes.OP_ONLY_CUSTOM_DATA`: the types whose data only a player
/// who can use game master blocks places (`BlockEntityType.onlyOpCanSetNbt`).
    // rust: pub const OP_ONLY: [&str; 6] = [
    // rust: "minecraft:command_block",
    // rust: "minecraft:lectern",
    // rust: "minecraft:sign",
    // rust: "minecraft:hanging_sign",
    // rust: "minecraft:mob_spawner",
    // rust: "minecraft:trial_spawner",
    // rust: ];

/// The `minecraft:block_entity_data` of `stack`: its type id and its data.
pub fn data(stack: *crate::items::ItemStack) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let data = stack.data()?.other(BLOCK_ENTITY_DATA)?;
    // rust: Some((block_entity_nbt::id(data)?, data))
}

/// `JukeboxBlock.setPlacedBy`: the item's `minecraft:block_entity_data`
/// carries a `RecordItem`, so the placed jukebox holds a record and its
/// `has_record` state has to say so. Vanilla reads the item's data, not the
/// block entity the placement just filled.
pub fn carries_record(stack: *crate::items::ItemStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: stack
    // rust: .data()
    // rust: .and_then(|d| d.other(BLOCK_ENTITY_DATA))
    // rust: .is_some_and(|data| data.get("RecordItem").is_some())
}

/// `BlockItem.shouldPrintOpWarning` for a player with game master permission:
/// the item carries data of an op-only type.
pub fn op_warning(stack: *crate::items::ItemStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: data(stack).is_some_and(|(id, _)| OP_ONLY.contains(&id.as_str()))
}

/// `EntityTypes.OP_ONLY_CUSTOM_DATA`: the entity types whose data only a player
/// who can use game master blocks sets (`EntityType.onlyOpCanSetNbt`).
pub fn egg_op_only(id: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(
    // rust: id,
    // rust: "minecraft:falling_block"
    // rust: | "minecraft:command_block_minecart"
    // rust: | "minecraft:spawner_minecart"
    // rust: )
}

/// `SpawnEggItem.shouldPrintOpWarning` for a player with game master
/// permission: a spawn egg carries data of an op-only entity type.
pub fn spawn_egg_op_warning(stack: *crate::items::ItemStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: stack.item.ends_with("_spawn_egg")
    // rust: && matches!(
    // rust: stack
    // rust: .data()
    // rust: .and_then(|d| d.other("minecraft:entity_data"))
    // rust: .and_then(|data| data.get("id")),
    // rust: Some(Tag::String(id)) if egg_op_only(&id.to_string_lossy())
    // rust: )
}

/// `SpawnEggItem.useOn` on a spawner: the type it sets (`getType`: the egg's
/// entity data id, else the egg's own type) and, for an op
/// (`PlayerList.isOp`), that entity data for `Spawner.setEntityData`; anyone
/// else sets only the type (`setEntityId`).
    // rust: pub fn spawn_egg_on_spawner(
    // rust: stack: &crate::items::ItemStack,
    // rust: op: bool,
    // rust: ) -> (String, Option<Compound>) {
    // rust: let data = match stack.data().and_then(|d| d.other("minecraft:entity_data")) {
    // rust: Some(Tag::Compound(c)) => Some(c),
    // rust: _ => None,
}
    // rust: let id = match data.and_then(|c| c.get(&JavaString::from("id"))) {
    // rust: Some(Tag::String(id)) => id.to_string_lossy(),
    // rust: _ => {
    // rust: let kind = stack.item.trim_end_matches("_spawn_egg");
    // rust: format!("minecraft:{}", kind.trim_start_matches("minecraft:"))
}
}
    // rust: (id, data.filter(|_| op).cloned())
}

/// `EntityType.updateCustomEntityTag`: the `minecraft:entity_data` a spawn egg
/// puts on the mob it spawned — only when the data names the spawned type (data
/// without an `id` is the egg's own), and an op-only type's data only for an op.
    // rust: pub fn spawn_egg_entity_data<'a>(
    // rust: stack: &'a crate::items::ItemStack,
    // rust: spawned: &str,
    // rust: op: bool,
    // rust: ) -> Option<&'a Tag> {
    // rust: let data = stack.data()?.other("minecraft:entity_data")?;
    // rust: if matches!(data.get("id"), Some(Tag::String(id)) if id.to_string_lossy() != spawned) {
    // rust: return None;
}
    // rust: if egg_op_only(spawned) && !op {
    // rust: return None;
}
    // rust: Some(data)
}

/// `Spawner.getSpawnEntityDisplayName` (`SpawnData.entity.id` of the item's
/// data, which `ItemStack.addDetailsToTooltip` reads for spawners and trial
/// spawners alike): the entity type a spawner item spawns.
pub fn spawner_entity(stack: *crate::items::ItemStack) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (_, data) = data(stack)?;
    // rust: match data.get("SpawnData")?.get("entity")?.get("id")? {
    // rust: Tag::String(id) => Some(id.to_string_lossy()),
    // rust: _ => None,
}
}

/// A part of a block entity's NBT that its item holds as a component.
pub const Part = enum {
    /// The NBT key and the component hold the same value.
    Same(&'static str, &'static str),
    /// `Items` as `minecraft:container`, in a container of this many slots.
    Items(usize),
    /// `LootTable` and `LootTableSeed` as `minecraft:container_loot`.
    Loot,
    /// `is_waxed` as `minecraft:waxed`.
    Waxed,
    /// A decorated pot's `item` as `minecraft:container`.
    PotItem,
    /// Left out of the item's data, with no component.
    Drop(&'static str),
};
pub const NAME: Part = Part::Same("CustomName", "minecraft:custom_name");
pub const LOCK: Part = Part::Same("lock", "minecraft:lock");
pub const CONTAINER: []const u8 = "minecraft:container";

/// Each type's `removeComponentsFromTag`, `collectImplicitComponents` and
/// `applyImplicitComponents`.
pub fn parts(id: []const u8) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match id {
    // rust: "minecraft:chest"
    // rust: | "minecraft:trapped_chest"
    // rust: | "minecraft:barrel"
    // rust: | "minecraft:shulker_box" => &[NAME, LOCK, Part::Items(27), Part::Loot],
    // rust: "minecraft:dispenser" | "minecraft:dropper" | "minecraft:crafter" => {
    // rust: &[NAME, LOCK, Part::Items(9), Part::Loot]
}
    // rust: "minecraft:hopper" => &[NAME, LOCK, Part::Items(5), Part::Loot],
    // rust: "minecraft:furnace" | "minecraft:smoker" | "minecraft:blast_furnace" => {
    // rust: &[NAME, LOCK, Part::Items(3)]
}
    // rust: "minecraft:brewing_stand" => &[NAME, LOCK, Part::Items(5)],
    // rust: "minecraft:beacon" => &[NAME, LOCK],
    // rust: "minecraft:enchanting_table" => &[NAME],
    // rust: "minecraft:command_block" => &[NAME, Part::Drop("conditionMet"), Part::Drop("powered")],
    // rust: "minecraft:campfire" => &[Part::Items(4)],
    // rust: "minecraft:chiseled_bookshelf" => &[Part::Items(6)],
    // rust: "minecraft:shelf" => &[Part::Items(3)],
    // rust: "minecraft:beehive" => &[Part::Same("bees", "minecraft:bees")],
    // rust: "minecraft:banner" => &[Part::Same("patterns", "minecraft:banner_patterns"), NAME],
    // rust: "minecraft:decorated_pot" => &[
    // rust: Part::Same("sherds", "minecraft:pot_decorations"),
    // rust: Part::PotItem,
    // rust: ],
    // rust: "minecraft:sign" | "minecraft:hanging_sign" => &[
    // rust: Part::Same("front_text", "minecraft:sign_text_front"),
    // rust: Part::Same("back_text", "minecraft:sign_text_back"),
    // rust: Part::Waxed,
    // rust: ],
    // rust: "minecraft:skull" => &[
    // rust: Part::Same("profile", "minecraft:profile"),
    // rust: Part::Same("note_block_sound", "minecraft:note_block_sound"),
    // rust: Part::Same("custom_name", "minecraft:custom_name"),
    // rust: ],
    // rust: _ => &[],
}
}

/// The component a part reads, and what it holds for `tag` (None: unset).
pub fn collect(part: Part, tag: *Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(match part {
    // rust: Part::Same(key, component) => (
    // rust: component,
    // rust: tag.get(key).cloned().or_else(|| unset(component)),
    // rust: ),
    // rust: Part::Items(_) => {
    // rust: let slots = match tag.get("Items") {
    // rust: Some(Tag::List(items)) => items.iter().filter_map(slot_entry).collect(),
    // rust: _ => Vec::new(),
}
    // rust: (CONTAINER, Some(Tag::List(slots)))
}
    // rust: Part::Loot => {
    // rust: let table = tag.get("LootTable").cloned();
    // rust: let loot = table.map(|t| {
    // rust: let mut entries = vec![("loot_table", t)];
    // rust: if let Some(seed) = tag.get("LootTableSeed") {
    // rust: entries.push(("seed", seed.clone()));
}
    // rust: Tag::compound(entries)
    // rust: });
    // rust: ("minecraft:container_loot", loot)
}
    // rust: Part::Waxed => (
    // rust: "minecraft:waxed",
    // rust: matches!(tag.get("is_waxed"), Some(Tag::Byte(1)))
    // rust: .then(|| Tag::Compound(Compound::new())),
    // rust: ),
    // rust: Part::PotItem => {
    // rust: let slots = match tag.get("item") {
    // rust: Some(Tag::Compound(item)) => Some(container_slot(0, item.clone())),
    // rust: _ => None,
}
    // rust: (CONTAINER, Some(Tag::List(slots.into_iter().collect())))
}
    // rust: Part::Drop(_) => return None,
    // rust: })
}

/// What a type that always collects `component` gives when its NBT leaves the
/// value out (its empty value, which the NBT omits).
pub fn unset(component: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(match component {
    // rust: "minecraft:bees" | "minecraft:banner_patterns" => Tag::List(Vec::new()),
    // rust: "minecraft:pot_decorations" => Tag::Compound(Compound::new()),
    // rust: "minecraft:sign_text_front" | "minecraft:sign_text_back" => {
    // rust: block_entity_nbt::sign_side(None)
}
    // rust: _ => return None,
    // rust: })
}

/// An `Items` entry as a `minecraft:container` slot.
pub fn slot_entry(entry: *Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Tag::Compound(entry) = entry else {
    // rust: return None;
}
    // rust: let mut item = entry.clone();
    // rust: let slot = match item.remove(&JavaString::from("Slot"))? {
    // rust: Tag::Byte(s) => i32::from(s),
    // rust: _ => return None,
}
    // rust: Some(container_slot(slot, item))
}

/// An `ItemContainerContents` slot: `ItemStackTemplate` leaves out a count of 1.
pub fn container_slot(slot: i32, mut item: Compound) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if item.get(&JavaString::from("count")) == Some(&Tag::Int(1)) {
    // rust: item.remove(&JavaString::from("count"));
}
    // rust: Tag::compound([("slot", Tag::Int(slot)), ("item", Tag::Compound(item))])
}

/// The value of `component` on the clone item of a type that collects it: a
/// picked item leaves it out of its patch, and a placed item without it in its
/// patch gives it to the block entity.
pub fn item_default(component: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(match component {
    // rust: CONTAINER | "minecraft:bees" | "minecraft:banner_patterns" => Tag::List(Vec::new()),
    // rust: "minecraft:pot_decorations" => {
    // rust: let brick = || Tag::compound([("id", Tag::String("minecraft:brick".into()))]);
    // rust: Tag::compound([
    // rust: ("back", brick()),
    // rust: ("front", brick()),
    // rust: ("left", brick()),
    // rust: ("right", brick()),
    // rust: ])
}
    // rust: "minecraft:sign_text_front" | "minecraft:sign_text_back" => {
    // rust: block_entity_nbt::sign_side(None)
}
    // rust: _ => return None,
    // rust: })
}

pub const METADATA: [[]const u8; 6] = ["id", "x", "y", "z", "keepPacked", "components"];

/// `saveCustomOnly`: the saved NBT without its id, position and components.
pub fn custom_only(saved: *Tag) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match saved {
    // rust: Tag::Compound(c) => c
    // rust: .iter()
    // rust: .filter(|(k, _)| !METADATA.contains(&k.to_string_lossy().as_str()))
    // rust: .map(|(k, v)| (k.clone(), v.clone()))
    // rust: .collect(),
    // rust: _ => Compound::new(),
}
}

/// `BlockEntity.collectComponents`: explicit components plus the type's implicit components.
/// Unlike Ctrl + Pick Block, this does not carry the remaining block entity NBT.
pub fn collected_components(saved: *Tag) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let id = block_entity_nbt::id(saved).unwrap_or_default();
    // rust: let mut collected = match saved.get("components") {
    // rust: Some(Tag::Compound(c)) => c.clone(),
    // rust: _ => Compound::new(),
}
    // rust: for part in parts(&id) {
    // rust: if let Some((component, value)) = collect(*part, saved) {
    // rust: match value {
    // rust: Some(v) => collected.insert(component.into(), v),
    // rust: None => collected.remove(&JavaString::from(component)),
}
}
}
    // rust: collected
}

/// `addBlockDataToItem`: the component patch Ctrl + Pick Block gives the clone
/// item of the block entity saved as `saved` (a full, canonical compound).
pub fn pick(saved: *Tag) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let id = block_entity_nbt::id(saved).unwrap_or_default();
    // rust: let mut patch = Compound::new();
    // BlockItem.setBlockEntityData after removeComponentsFromTag.
    // rust: let mut data = custom_only(saved);
    // rust: for part in parts(&id) {
    // rust: let key = match *part {
    // rust: Part::Same(key, _) | Part::Drop(key) => key,
    // rust: Part::Items(_) => "Items",
    // rust: Part::Loot => {
    // rust: data.remove(&JavaString::from("LootTableSeed"));
    // rust: "LootTable"
}
    // rust: Part::Waxed => "is_waxed",
    // rust: Part::PotItem => "item",
}
    // rust: data.remove(&JavaString::from(key));
}
    // rust: if !data.is_empty() {
    // rust: data.insert("id".into(), Tag::String(id.as_str().into()));
    // rust: patch.insert(BLOCK_ENTITY_DATA.into(), Tag::Compound(data));
}
    // ItemStack.applyComponents(collectComponents()): the block entity's own
    // components, then the implicit ones; a value equal to the item's own is
    // no change.
    // rust: for (component, value) in collected_components(saved) {
    // rust: if item_default(&component.to_string_lossy()).as_ref() == Some(&value) {
    // rust: patch.remove(&component);
    // rust: } else {
    // rust: patch.insert(component, value);
}
}
    // rust: patch
}

/// The block entity saved as `saved` after an item with component patch
/// `components` is placed as it: `BlockItem.updateCustomBlockEntityTag` (the
/// item's data of the same type, op-only types only when `game_master`, the
/// player can use game master blocks), then `applyComponentsFromItemStack`.
pub fn place(saved: *Tag, components: *Compound, game_master: bool) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(id) = block_entity_nbt::id(saved) else {
    // rust: return saved.clone();
}
    // rust: let Tag::Compound(mut tag) = saved.clone() else {
    // rust: return saved.clone();
}
    // TypedEntityData.loadInto: saveCustomOnly, merge, loadCustomOnly when changed.
    // rust: if let Some(Tag::Compound(data)) = components.get(&JavaString::from(BLOCK_ENTITY_DATA))
    // rust: && data
    // rust: .get(&JavaString::from("id"))
    // rust: .is_some_and(|t| matches!(t, Tag::String(s) if s.to_string_lossy() == id))
    // rust: && (game_master || !OP_ONLY.contains(&id.as_str()))
    // rust: {
    // rust: let custom = custom_only(saved);
    // rust: let mut merged = custom.clone();
    // rust: let mut data = data.clone();
    // rust: data.remove(&JavaString::from("id"));
    // rust: crate::data_cmd::merge_compound(&mut merged, &data);
    // rust: if merged != custom {
    // rust: for key in METADATA {
    // rust: if let Some(v) = tag.get(&JavaString::from(key)) {
    // rust: merged.insert(key.into(), v.clone());
}
}
    // rust: if let Some(Tag::Compound(loaded)) = canonical(&Tag::Compound(merged)) {
    // rust: tag = loaded;
}
}
}
    // applyImplicitComponents, then the rest of the patch as the block
    // entity's own components.
    // rust: let mut read = vec![BLOCK_ENTITY_DATA, "minecraft:block_state"];
    // The item's components: its patch over its own defaults.
    // rust: let get = |c: &str| match components.get(&JavaString::from(c)) {
    // rust: Some(v) => Some(v.clone()),
    // rust: None if components.contains_key(&JavaString::from(format!("!{c}").as_str())) => None,
    // rust: None => item_default(c),
}
    // rust: let mut set = |key: &str, value: Option<Tag>| match value {
    // rust: Some(v) => tag.insert(key.into(), v),
    // rust: None => tag.remove(&JavaString::from(key)),
}
    // rust: for part in parts(&id) {
    // rust: match *part {
    // rust: Part::Same(key, component) => {
    // rust: read.push(component);
    // rust: set(key, get(component));
}
    // rust: Part::Items(size) => {
    // rust: read.push(CONTAINER);
    // rust: let items = container_slots(get(CONTAINER).as_ref())
    // rust: .filter(|(slot, _)| (*slot as usize) < size)
    // rust: .map(|(slot, mut item)| {
    // rust: item.insert("Slot".into(), Tag::Byte(slot as i8));
    // rust: Tag::Compound(item)
    // rust: })
    // rust: .collect();
    // rust: set("Items", Some(Tag::List(items)));
}
    // rust: Part::Loot => {
    // rust: read.push("minecraft:container_loot");
    // rust: if let Some(loot) = get("minecraft:container_loot") {
    // rust: set("LootTable", loot.get("loot_table").cloned());
    // rust: set("LootTableSeed", loot.get("seed").cloned());
}
}
    // rust: Part::Waxed => {
    // rust: read.push("minecraft:waxed");
    // rust: set(
    // rust: "is_waxed",
    // rust: Some(Tag::Byte(i8::from(get("minecraft:waxed").is_some()))),
    // rust: );
}
    // rust: Part::PotItem => {
    // rust: read.push(CONTAINER);
    // rust: let first = container_slots(get(CONTAINER).as_ref()).find(|(slot, _)| *slot == 0);
    // rust: set("item", first.map(|(_, item)| Tag::Compound(item)));
}
    // rust: Part::Drop(_) => {}
}
}
    // rust: let own: Compound = components
    // rust: .iter()
    // rust: .filter(|(k, _)| {
    // rust: let k = k.to_string_lossy();
    // rust: !k.starts_with('!') && !read.contains(&k.as_str())
    // rust: })
    // rust: .map(|(k, v)| (k.clone(), v.clone()))
    // rust: .collect();
    // rust: tag.insert("components".into(), Tag::Compound(own));
    // rust: let tag = Tag::Compound(tag);
    // rust: canonical(&tag).unwrap_or(tag)
}

/// The slots of a `minecraft:container` component.
pub fn container_slots(container: ?*Tag) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let list = match container {
    // rust: Some(Tag::List(list)) => list.as_slice(),
    // rust: _ => &[],
}
    // rust: list.iter().filter_map(|entry| {
    // rust: let slot = match entry.get("slot")? {
    // rust: Tag::Int(s) => *s,
    // rust: _ => return None,
}
    // rust: match entry.get("item")? {
    // rust: Tag::Compound(item) => Some((slot, item.clone())),
    // rust: _ => None,
}
    // rust: })
}

    // rust: mod tests {
//     use super::*;

pub fn snbt(text: []const u8) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: horizon_world::nbt::parse_snbt(text).expect("snbt").0
}
pub fn saved(text: []const u8) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: canonical(&snbt(text)).expect("known type")
}
pub fn canon(patch: *Compound) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: crate::item_data::canon_tag(&Tag::Compound(patch.clone()))
}

pub fn a_filled_named_chest_gives_its_items_and_name_as_components() void {
}
    // rust: let chest = saved(
    // rust: "{id:\"minecraft:chest\",x:1,y:2,z:3,CustomName:\"Loot\",\
    // rust: Items:[{Slot:4b,id:\"minecraft:stone\",count:5}]}",
    // rust: );
    // rust: let patch = pick(&chest);
    // rust: assert_eq!(
    // rust: canon(&patch),
    // rust: crate::item_data::canon_tag(&snbt(
    // rust: "{\"minecraft:container\":[{slot:4,item:{id:\"minecraft:stone\",count:5}}],\
    // rust: \"minecraft:custom_name\":\"Loot\"}"
    // rust: ))
    // rust: );
        // Placing it back gives the same chest.
    // rust: let empty = saved("{id:\"minecraft:chest\",x:1,y:2,z:3}");
    // rust: assert_eq!(place(&empty, &patch, false), chest);
        // An empty chest has nothing to carry.
    // rust: assert!(pick(&empty).is_empty());
}

pub fn a_command_block_keeps_its_command_in_block_entity_data() void {
}
    // rust: let block = saved(
    // rust: "{id:\"minecraft:command_block\",x:0,y:0,z:0,Command:\"say hi\",auto:1b,powered:1b}",
    // rust: );
    // rust: let patch = pick(&block);
    // rust: let data = patch
    // rust: .get(&JavaString::from(BLOCK_ENTITY_DATA))
    // rust: .expect("data");
    // rust: assert_eq!(data.get("Command"), Some(&Tag::String("say hi".into())));
    // rust: assert_eq!(data.get("powered"), None);
    // rust: assert_eq!(
    // rust: data.get("id"),
    // rust: Some(&Tag::String("minecraft:command_block".into()))
    // rust: );
        // Only a player who can use game master blocks places it.
    // rust: let fresh = saved("{id:\"minecraft:command_block\",x:0,y:0,z:0}");
    // rust: assert_eq!(place(&fresh, &patch, false), fresh);
    // rust: assert_eq!(
    // rust: place(&fresh, &patch, true).get("Command"),
    // rust: Some(&Tag::String("say hi".into()))
    // rust: );
        // Data of another type is ignored.
    // rust: let chest = saved("{id:\"minecraft:chest\",x:0,y:0,z:0}");
    // rust: assert_eq!(place(&chest, &patch, true), chest);
}

pub fn a_spawn_egg_sets_its_data_type_and_an_ops_data() void {
}
    // rust: let egg = |entity_data: Option<&str>| {
    // rust: let mut stack = crate::items::ItemStack::new("minecraft:zombie_spawn_egg", 1);
    // rust: if let Some(text) = entity_data {
    // rust: let components = snbt(&format!("{{\"minecraft:entity_data\":{text}}}"));
    // rust: (stack.damage, stack.extra) =
    // rust: crate::item_data::decode_components(Some(&components));
}
    // rust: stack
}
        // A plain egg: its own type, no data, op or not.
    // rust: assert_eq!(
    // rust: spawn_egg_on_spawner(&egg(None), true),
    // rust: ("minecraft:zombie".into(), None)
    // rust: );
        // Entity data: its type for anyone (getType), its data only for an op.
    // rust: let custom = egg(Some("{id:\"minecraft:skeleton\",CustomName:\"Guard\"}"));
    // rust: let (id, data) = spawn_egg_on_spawner(&custom, false);
    // rust: assert_eq!((id.as_str(), data), ("minecraft:skeleton", None));
    // rust: let (id, data) = spawn_egg_on_spawner(&custom, true);
    // rust: assert_eq!(id, "minecraft:skeleton");
    // rust: let data = data.expect("an op's egg carries its data");
    // rust: assert_eq!(
    // rust: data.get(&JavaString::from("CustomName")),
    // rust: Some(&Tag::String("Guard".into()))
    // rust: );
}

pub fn a_spawn_egg_data_needs_its_own_type_and_an_op_for_an_op_only_one() void {
}
    // rust: let egg = |entity_data: &str| {
    // rust: let components = snbt(&format!("{{\"minecraft:entity_data\":{entity_data}}}"));
    // rust: let (damage, extra) = crate::item_data::decode_components(Some(&components));
    // rust: crate::items::ItemStack {
    // rust: damage,
    // rust: extra,
    // rust: ..crate::items::ItemStack::new("minecraft:zombie_spawn_egg", 1)
}
}
        // `entity_data` without an id names the egg's own type: applied for anyone.
    // rust: let own = egg("{NoAI:1b}");
    // rust: assert_eq!(
    // rust: spawn_egg_entity_data(&own, "minecraft:zombie", false)
    // rust: .and_then(|data| data.get("NoAI")),
    // rust: Some(&Tag::Byte(1))
    // rust: );
        // `entity_data.id` names another type: the spawned type keeps no data.
    // rust: let other = egg("{id:\"minecraft:pig\",NoAI:1b}");
    // rust: assert_eq!(
    // rust: spawn_egg_entity_data(&other, "minecraft:zombie", false),
    // rust: None
    // rust: );
        // An op-only type's data needs an op.
    // rust: assert_eq!(
    // rust: spawn_egg_entity_data(&own, "minecraft:falling_block", false),
    // rust: None
    // rust: );
    // rust: assert!(spawn_egg_entity_data(&own, "minecraft:falling_block", true).is_some());
}

pub fn item_data_names_its_spawn_and_op_only_types() void {
}
    // rust: let item = |text: &str| {
    // rust: let components = snbt(&format!("{{\"minecraft:block_entity_data\":{text}}}"));
    // rust: let (damage, extra) = crate::item_data::decode_components(Some(&components));
    // rust: crate::items::ItemStack {
    // rust: damage,
    // rust: extra,
    // rust: ..crate::items::ItemStack::new("minecraft:spawner", 1)
}
}
    // rust: let spawner =
    // rust: item("{id:\"minecraft:mob_spawner\",SpawnData:{entity:{id:\"minecraft:zombie\"}}}");
    // rust: assert_eq!(
    // rust: spawner_entity(&spawner).as_deref(),
    // rust: Some("minecraft:zombie")
    // rust: );
    // rust: assert!(op_warning(&spawner));
    // rust: let chest = item("{id:\"minecraft:chest\",LootTable:\"x\"}");
    // rust: assert_eq!(spawner_entity(&chest), None);
    // rust: assert!(!op_warning(&chest));
}

    /// `JukeboxBlock.setPlacedBy` looks for a `RecordItem` in the placed
    /// item's block entity data, whatever the type it names: only that key
    /// turns the box's `has_record` on.
pub fn a_jukebox_item_with_a_record_in_its_data_says_so() void {
}
    // rust: let jukebox = |text: &str| {
    // rust: let components = snbt(&format!("{{\"minecraft:block_entity_data\":{text}}}"));
    // rust: let (damage, extra) = crate::item_data::decode_components(Some(&components));
    // rust: crate::items::ItemStack {
    // rust: damage,
    // rust: extra,
    // rust: ..crate::items::ItemStack::new("minecraft:jukebox", 1)
}
}
        // A plain jukebox, and one whose data is only the type id: no record.
    // rust: assert!(!carries_record(&crate::items::ItemStack::new(
    // rust: "minecraft:jukebox",
    // rust: 1
    // rust: )));
    // rust: assert!(!carries_record(&jukebox("{id:\"minecraft:jukebox\"}")));
    // rust: assert!(!carries_record(&jukebox(
    // rust: "{id:\"minecraft:jukebox\",Items:[{Slot:0b,id:\"minecraft:stone\",count:1}]}"
    // rust: )));
        // Creative's Ctrl + Pick Block on a jukebox holding a disc.
    // rust: assert!(carries_record(&jukebox(
    // rust: "{id:\"minecraft:jukebox\",RecordItem:{id:\"minecraft:music_disc_cat\",count:1}}"
    // rust: )));
        // The key alone counts: `TypedEntityData.contains` never checks the
        // type, and the state it sets is the one the block is placed as.
    // rust: assert!(carries_record(&jukebox(
    // rust: "{id:\"minecraft:chest\",RecordItem:{id:\"minecraft:music_disc_cat\",count:1}}"
    // rust: )));
}

pub fn a_written_sign_gives_its_text_and_wax() void {
}
    // rust: let sign = saved(
    // rust: "{id:\"minecraft:sign\",x:0,y:0,z:0,is_waxed:1b,\
    // rust: front_text:{messages:[\"a\",\"b\",\"\",\"\"]}}",
    // rust: );
    // rust: let patch = pick(&sign);
    // rust: let keys: Vec<String> = patch.keys().map(|k| k.to_string_lossy()).collect();
    // rust: assert_eq!(keys, ["minecraft:sign_text_front", "minecraft:waxed"]);
    // rust: let fresh = saved("{id:\"minecraft:sign\",x:0,y:0,z:0}");
    // rust: assert_eq!(place(&fresh, &patch, false), sign);
}
}
