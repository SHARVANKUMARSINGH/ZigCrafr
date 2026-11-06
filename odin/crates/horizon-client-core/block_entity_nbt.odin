//! Transpiled from Horizon Rust crate
package horizon_client_core_block_entity_nbt

import "core:fmt"
import "core:mem"
import "core:math"

// Vanilla 26.3 block entity NBT for every block entity type.
//
// [`canonical`] is `loadAdditional` followed by `saveWithFullMetadata` for each of
// the 47 `BlockEntityType`s: it reads the fields the type reads (with vanilla's
// defaults and clamps), drops everything else and writes the fields `saveAdditional`
// writes (including its omit-when-empty rules). Nested codec values that Horizon does
// not simulate (spawner entity data, vibration listeners, trial spawner configuration,
// vault data, sculk cursors, sign and banner components, profiles) are carried as
// loaded. The common `BaseContainerBlockEntity` fields (`CustomName`, `lock`) and the
// `RandomizableContainer` loot table fields are handled for every container type.
//
// [`overlay`] merges a block entity Horizon models (and re-encodes from its own,
// partial state) with the NBT it was loaded from, so fields Horizon does not model
// survive and only what the game changed is replaced.
// use horizon_world::nbt::{Compound, Tag};

string :: proc(s: string) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Tag::String(s.into())
}
text :: proc(tag: Maybe(^Tag)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match tag {
    // rust: Some(Tag::String(s)) => Some(s.to_string_lossy()),
    // rust: _ => None,
}
}
// `CompoundTag.getIntOr`: any numeric tag (floats floor).
int :: proc(tag: Maybe(^Tag)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(match tag? {
    // rust: Tag::Byte(v) => i32::from(*v),
    // rust: Tag::Short(v) => i32::from(*v),
    // rust: Tag::Int(v) => *v,
    // rust: Tag::Long(v) => *v as i32,
    // rust: Tag::Float(b) => f32::from_bits(*b).floor() as i32,
    // rust: Tag::Double(b) => f64::from_bits(*b).floor() as i32,
    // rust: _ => return None,
    // rust: })
}
long :: proc(tag: Maybe(^Tag)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(match tag? {
    // rust: Tag::Long(v) => *v,
    // rust: Tag::Float(b) => f32::from_bits(*b).floor() as i64,
    // rust: Tag::Double(b) => f64::from_bits(*b).floor() as i64,
    // rust: other => i64::from(int(Some(other))?),
    // rust: })
}
float :: proc(tag: Maybe(^Tag)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(match tag? {
    // rust: Tag::Float(b) => f32::from_bits(*b),
    // rust: Tag::Double(b) => f64::from_bits(*b) as f32,
    // rust: Tag::Long(v) => *v as f32,
    // rust: other => int(Some(other))? as f32,
    // rust: })
}
flag :: proc(tag: Maybe(^Tag)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(int(tag)? != 0)
}
boolean :: proc(v: bool) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Tag::Byte(i8::from(v))
}
f32_tag :: proc(v: f32) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Tag::Float(v.to_bits())
}

// `TheEndGatewayBlockEntity.loadAdditional`: BlockPos.CODEC and Level.isInSpawnableBounds.
gateway_exit :: proc(tag: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let Tag::IntArray(v) = tag else { return None };
    // rust: let p: [i32; 3] = v.as_slice().try_into().ok()?;
    // rust: ((-30_000_000..30_000_000).contains(&p[0])
    // rust: && (-20_000_000..20_000_000).contains(&p[1])
    // rust: && (-30_000_000..30_000_000).contains(&p[2]))
    // rust: .then_some(p)
}

// What a block entity reads and writes, in `saveAdditional` order.
Fields :: struct {
    input: ^'a Tag,
    out: Compound,
}
    // rust: impl<'a> Fields<'a> {
put :: proc(self: ^Self, key: string, value: Tag) {
}
    // rust: self.out.insert(key.into(), value);
}
int :: proc(self: ^Self, key: string, default: i32) {
}
    // rust: let v = int(self.input.get(key)).unwrap_or(default);
    // rust: self.put(key, Tag::Int(v));
}
int_clamped :: proc(self: ^Self, key: string, default: i32, min: i32, max: i32) {
}
    // rust: let v = int(self.input.get(key)).unwrap_or(default).clamp(min, max);
    // rust: self.put(key, Tag::Int(v));
}
short :: proc(self: ^Self, key: string, default: i16) {
}
    // rust: let v = int(self.input.get(key)).map_or(default, |v| v as i16);
    // rust: self.put(key, Tag::Short(v));
}
long :: proc(self: ^Self, key: string, default: i64) {
}
    // rust: let v = long(self.input.get(key)).unwrap_or(default);
    // rust: self.put(key, Tag::Long(v));
}
float :: proc(self: ^Self, key: string, default: f32) {
}
    // rust: let v = float(self.input.get(key)).unwrap_or(default);
    // rust: self.put(key, f32_tag(v));
}
flag :: proc(self: ^Self, key: string, default: bool) {
}
    // rust: let v = flag(self.input.get(key)).unwrap_or(default);
    // rust: self.put(key, boolean(v));
}
string :: proc(self: ^Self, key: string, default: string) {
}
    // rust: let v = text(self.input.get(key)).unwrap_or_else(|| default.to_owned());
    // rust: self.put(key, string(&v));
}
    // An optional value written as loaded, when it has the expected shape.
keep :: proc(self: ^Self, key: string, valid: impl Fn(^Tag) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(t) = self.input.get(key).filter(|t| valid(t)) {
    // rust: self.put(key, t.clone());
}
}
keep_compound :: proc(self: ^Self, key: string) {
}
    // rust: self.keep(key, |t| matches!(t, Tag::Compound(_)));
}
    // A compound that is always written (`default` when absent).
compound_or :: proc(self: ^Self, key: string, default: Compound) {
}
    // rust: let v = match self.input.get(key) {
    // rust: Some(Tag::Compound(c)) => c.clone(),
    // rust: _ => default,
}
    // rust: self.put(key, Tag::Compound(v));
}
    // An optional text component (`storeNullable("CustomName", ComponentSerialization.CODEC)`).
component :: proc(self: ^Self, key: string) {
}
    // rust: if let Some(c) = self.input.get(key).and_then(component) {
    // rust: self.put(key, c);
}
}
    // `LockCode.addToTag`.
lock :: proc(self: ^Self) {
}
    // rust: self.keep_compound("lock");
}
    // `BaseContainerBlockEntity`: the custom name and the lock.
base_container :: proc(self: ^Self) {
}
    // rust: self.component("CustomName");
    // rust: self.lock();
}
    // `RandomizableContainer.tryLoadLootTable` / `trySaveLootTable`; true when the
    // block entity has a loot table (and so saves no items).
loot_table :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(table) =
    // rust: text(self.input.get("LootTable")).and_then(|id| crate::identifier::normalize_id(&id))
    // rust: else {
    // rust: return false;
}
    // rust: self.put("LootTable", string(&table));
    // rust: let seed = long(self.input.get("LootTableSeed")).unwrap_or(0);
    // rust: if seed != 0 {
    // rust: self.put("LootTableSeed", Tag::Long(seed));
}
    // rust: true
}
    // `ContainerHelper.loadAllItems` + `saveAllItems`.
items :: proc(self: ^Self, size: uint, also_when_empty: bool) {
}
    // rust: let items = items(self.input.get("Items"), size);
    // rust: if !items.is_empty() || also_when_empty {
    // rust: self.put("Items", Tag::List(items));
}
}
    // A container: loot table or items.
container :: proc(self: ^Self, size: uint, also_when_empty: bool) {
}
    // rust: if !self.loot_table() {
    // rust: self.items(size, also_when_empty);
}
}
    // An optional `ItemStack` (`RecordItem`, `Book`, `item`).
item :: proc(self: ^Self, key: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match self.input.get(key).and_then(stack) {
    // rust: Some(item) => {
    // rust: self.put(key, item);
    // rust: true
}
    // rust: None => false,
}
}
}

// `ComponentSerialization.CODEC` on loaded NBT: a literal without style is a plain
// string; anything else is kept as loaded.
component :: proc(tag: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match tag {
    // rust: Tag::String(_) | Tag::List(_) => Some(tag.clone()),
    // rust: Tag::Compound(c) => {
    // rust: if c.len() == 1
    // rust: && let Some(t @ Tag::String(_)) = c.get(&"text".into())
    // rust: {
    // rust: return Some(t.clone());
}
    // rust: Some(tag.clone())
}
    // rust: _ => None,
}
}

// `ItemStack.CODEC`: `id`, `count` (1..=99, default 1) and a non-empty `components`
// patch kept as loaded. None for the empty stack and for invalid stacks.
stack :: proc(tag: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let id = text(tag.get("id"))?;
    // rust: if id.is_empty() || id == "minecraft:air" {
    // rust: return None;
}
    // rust: let count = int(tag.get("count")).unwrap_or(1);
    // rust: if !(1..=99).contains(&count) {
    // rust: return None;
}
    // rust: let mut out = vec![("id", string(&id)), ("count", Tag::Int(count))];
    // rust: if let Some(c @ Tag::Compound(map)) = tag.get("components")
    // rust: && !map.is_empty()
    // rust: {
    // rust: out.push(("components", c.clone()));
}
    // rust: Some(Tag::compound(out))
}
// `ItemStackTemplate.CODEC`: an item id or `{id, count?, components?}`.
template :: proc(tag: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match tag {
    // rust: Tag::String(_) => Some(tag.clone()),
    // rust: Tag::Compound(_) => {
    // rust: let mut out = vec![("id", string(&text(tag.get("id"))?))];
    // rust: if let Some(count) = int(tag.get("count")).filter(|c| *c != 1) {
    // rust: out.push(("count", Tag::Int(count)));
}
    // rust: if let Some(c @ Tag::Compound(map)) = tag.get("components")
    // rust: && !map.is_empty()
    // rust: {
    // rust: out.push(("components", c.clone()));
}
    // rust: Some(Tag::compound(out))
}
    // rust: _ => None,
}
}
// `ItemStackWithSlot` entries of a container of `size` slots, by ascending slot.
items :: proc(tag: Maybe(^Tag), size: uint) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut slots: Vec<Option<Tag>> = vec![None; size];
    // rust: if let Some(Tag::List(list)) = tag {
    // rust: for entry in list {
    // rust: let (Some(slot), Some(item)) = (int(entry.get("Slot")), stack(entry)) else {
    // rust: continue;
}
    // rust: if (0..size as i32).contains(&slot) {
    // rust: slots[slot as usize] = Some(item);
}
}
}
    // rust: slots
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: .filter_map(|(i, item)| {
    // rust: let Tag::Compound(mut c) = item? else {
    // rust: return None;
}
    // rust: c.insert("Slot".into(), Tag::Byte(i as i8));
    // rust: Some(Tag::Compound(c))
    // rust: })
    // rust: .collect()
}
int_array :: proc(tag: Maybe(^Tag)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match tag {
    // rust: Some(Tag::IntArray(v)) => Some(v),
    // rust: _ => None,
}
}
// A saved `BlockPos` (`[I; x, y, z]`).
is_pos :: proc(tag: ^Tag) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(tag, Tag::IntArray(v) if v.len() == 3)
}
// The loaded `SignText` of one side, or the empty text.
sign_side :: proc(tag: Maybe(^Tag)) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let empty = || string("");
    // rust: let mut messages: Vec<Tag> = match tag.and_then(|t| t.get("messages")) {
    // rust: Some(Tag::List(list)) => list.iter().filter_map(component).collect(),
    // rust: _ => Vec::new(),
}
    // rust: messages.resize_with(4, empty);
    // rust: messages.truncate(4);
    // rust: let mut out = vec![
    // rust: ("messages", Tag::List(messages)),
    // rust: (
    // rust: "color",
    // rust: string(
    // rust: &tag.and_then(|t| text(t.get("color")))
    // rust: .unwrap_or_else(|| "black".into()),
    // rust: ),
    // rust: ),
    // rust: (
    // rust: "has_glowing_text",
    // rust: boolean(
    // rust: tag.and_then(|t| flag(t.get("has_glowing_text")))
    // rust: .unwrap_or(false),
    // rust: ),
    // rust: ),
    // rust: ];
    // rust: if let Some(filtered @ Tag::List(list)) = tag.and_then(|t| t.get("filtered_messages"))
    // rust: && list.len() == 4
    // rust: {
    // rust: out.push(("filtered_messages", filtered.clone()));
}
    // rust: Tag::compound(out)
}

// The id of a block entity compound.
id :: proc(tag: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: text(tag.get("id"))
}

// Every `BlockEntityType` id this module knows.
    // rust: pub const TYPES: [&str; 47] = [
    // rust: "minecraft:furnace",
    // rust: "minecraft:chest",
    // rust: "minecraft:trapped_chest",
    // rust: "minecraft:ender_chest",
    // rust: "minecraft:jukebox",
    // rust: "minecraft:dispenser",
    // rust: "minecraft:dropper",
    // rust: "minecraft:sign",
    // rust: "minecraft:hanging_sign",
    // rust: "minecraft:mob_spawner",
    // rust: "minecraft:creaking_heart",
    // rust: "minecraft:piston",
    // rust: "minecraft:brewing_stand",
    // rust: "minecraft:enchanting_table",
    // rust: "minecraft:end_portal",
    // rust: "minecraft:beacon",
    // rust: "minecraft:skull",
    // rust: "minecraft:daylight_detector",
    // rust: "minecraft:hopper",
    // rust: "minecraft:comparator",
    // rust: "minecraft:banner",
    // rust: "minecraft:structure_block",
    // rust: "minecraft:end_gateway",
    // rust: "minecraft:command_block",
    // rust: "minecraft:shulker_box",
    // rust: "minecraft:conduit",
    // rust: "minecraft:barrel",
    // rust: "minecraft:smoker",
    // rust: "minecraft:blast_furnace",
    // rust: "minecraft:lectern",
    // rust: "minecraft:bell",
    // rust: "minecraft:jigsaw",
    // rust: "minecraft:campfire",
    // rust: "minecraft:beehive",
    // rust: "minecraft:sculk_sensor",
    // rust: "minecraft:calibrated_sculk_sensor",
    // rust: "minecraft:sculk_catalyst",
    // rust: "minecraft:sculk_shrieker",
    // rust: "minecraft:chiseled_bookshelf",
    // rust: "minecraft:shelf",
    // rust: "minecraft:brushable_block",
    // rust: "minecraft:decorated_pot",
    // rust: "minecraft:crafter",
    // rust: "minecraft:trial_spawner",
    // rust: "minecraft:vault",
    // rust: "minecraft:test_block",
    // rust: "minecraft:test_instance_block",
    // rust: ];
// The two types added after the ones above in 26.3.
NEWEST :: ["minecraft:copper_golem_statue", "minecraft:potent_sulfur"]

// The block entity as vanilla would save it after loading `tag` (a full block
// entity compound with `id`, `x`, `y`, `z`); None for an unknown type or a tag
// without a position.
canonical :: proc(tag: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let id = id(tag)?;
    // rust: let (x, y, z) = (int(tag.get("x"))?, int(tag.get("y"))?, int(tag.get("z"))?);
    // rust: let mut f = Fields {
    // rust: input: tag,
    // rust: out: Compound::new(),
}
    // rust: match id.as_str() {
    // rust: "minecraft:furnace" | "minecraft:smoker" | "minecraft:blast_furnace" => {
    // rust: f.base_container();
    // rust: f.int("cooking_time_spent", 0);
    // rust: f.int("cooking_total_time", 0);
    // rust: f.int("lit_time_remaining", 0);
    // rust: f.int("lit_total_time", 0);
    // rust: f.float("speed_multiplier", 1.0);
    // rust: f.items(3, true);
    // rust: let used: Compound = match tag.get("RecipesUsed") {
    // rust: Some(Tag::Compound(c)) => c
    // rust: .iter()
    // rust: .filter_map(|(k, v)| Some((k.clone(), Tag::Int(int(Some(v))?))))
    // rust: .collect(),
    // rust: _ => Compound::new(),
}
    // rust: f.put("RecipesUsed", Tag::Compound(used));
}
    // rust: "minecraft:chest" | "minecraft:trapped_chest" | "minecraft:barrel" => {
    // rust: f.base_container();
    // rust: f.container(27, true);
}
    // rust: "minecraft:dispenser" | "minecraft:dropper" => {
    // rust: f.base_container();
    // rust: f.container(9, true);
}
    // rust: "minecraft:hopper" => {
    // rust: f.base_container();
    // rust: f.container(5, true);
    // rust: f.int("TransferCooldown", -1);
}
    // rust: "minecraft:shulker_box" => {
    // rust: f.base_container();
    // rust: f.container(27, false);
}
    // rust: "minecraft:crafter" => {
    // rust: f.base_container();
    // rust: f.int("crafting_ticks_remaining", 0);
    // rust: f.container(9, true);
    // rust: let disabled: Vec<i32> = int_array(tag.get("disabled_slots"))
    // rust: .map(|v| v.iter().copied().filter(|s| (0..9).contains(s)).collect())
    // rust: .unwrap_or_default();
            // `addDisabledSlots`: the slots whose container data is 1, ascending.
    // rust: let mut slots = disabled;
    // rust: slots.sort_unstable();
    // rust: slots.dedup();
    // rust: f.put("disabled_slots", Tag::IntArray(slots));
    // rust: f.put(
    // rust: "triggered",
    // rust: Tag::Int(int(tag.get("triggered")).unwrap_or(0)),
    // rust: );
}
    // rust: "minecraft:ender_chest"
    // rust: | "minecraft:end_portal"
    // rust: | "minecraft:daylight_detector"
    // rust: | "minecraft:bell"
    // rust: | "minecraft:conduit"
    // rust: | "minecraft:copper_golem_statue" => {
    // rust: if id == "minecraft:conduit" {
    // rust: f.keep("Target", |t| matches!(t, Tag::IntArray(v) if v.len() == 4));
}
}
    // rust: "minecraft:end_gateway" => {
    // rust: f.long("Age", 0);
    // rust: f.keep("exit_portal", |t| gateway_exit(t).is_some());
    // rust: if flag(tag.get("ExactTeleport")) == Some(true) {
    // rust: f.put("ExactTeleport", boolean(true));
}
}
    // rust: "minecraft:jukebox" => {
    // rust: let has_song = f.item("RecordItem");
    // rust: if has_song
    // rust: && let Some(ticks) = tag
    // rust: .get("ticks_since_song_started")
    // rust: .and_then(|t| long(Some(t)))
    // rust: && let Some(Tag::Compound(c)) = f.out.get(&"RecordItem".into())
    // rust: && is_record(c)
    // rust: {
    // rust: f.put("ticks_since_song_started", Tag::Long(ticks));
}
}
    // rust: "minecraft:sign" | "minecraft:hanging_sign" => {
    // rust: if flag(tag.get("allow_op_features")) == Some(true) {
    // rust: f.put("allow_op_features", boolean(true));
}
    // rust: f.put("front_text", sign_side(tag.get("front_text")));
    // rust: f.put("back_text", sign_side(tag.get("back_text")));
    // rust: f.flag("is_waxed", false);
}
    // rust: "minecraft:mob_spawner" => {
    // rust: f.short("Delay", 20);
    // rust: f.short("MinSpawnDelay", 200);
    // rust: f.short("MaxSpawnDelay", 800);
    // rust: f.short("SpawnCount", 4);
    // rust: f.short("MaxNearbyEntities", 6);
    // rust: f.short("RequiredPlayerRange", 16);
    // rust: f.short("SpawnRange", 4);
    // rust: f.keep_compound("SpawnData");
    // rust: let potentials = match tag.get("SpawnPotentials") {
    // rust: Some(t @ Tag::List(_)) => t.clone(),
    // rust: _ => match f.out.get(&"SpawnData".into()) {
    // rust: Some(data) => Tag::List(vec![Tag::compound([
    // rust: ("data", data.clone()),
    // rust: ("weight", Tag::Int(1)),
    // rust: ])]),
    // rust: None => Tag::List(Vec::new()),
    // rust: },
}
    // rust: f.put("SpawnPotentials", potentials);
}
    // rust: "minecraft:creaking_heart" => {
    // rust: f.keep(
    // rust: "creaking",
    // rust: |t| matches!(t, Tag::IntArray(v) if v.len() == 4),
    // rust: );
}
    // rust: "minecraft:piston" => {
    // rust: f.put(
    // rust: "blockState",
    // rust: match tag.get("blockState") {
    // rust: Some(t @ (Tag::String(_) | Tag::Compound(_))) => t.clone(),
    // rust: _ => string("minecraft:air"),
    // rust: },
    // rust: );
            // Direction.LEGACY_ID_CODEC: the 3D data value as a byte.
    // rust: f.put(
    // rust: "facing",
    // rust: Tag::Byte(int(tag.get("facing")).unwrap_or(0) as i8),
    // rust: );
    // rust: f.float("progress", 0.0);
    // rust: f.flag("extending", false);
    // rust: f.flag("source", false);
}
    // rust: "minecraft:brewing_stand" => {
    // rust: f.base_container();
    // rust: f.int("BrewTime", 0);
    // rust: f.int("total_brew_time", 400);
    // rust: f.items(5, true);
    // rust: f.int("Fuel", 0);
    // rust: f.int("total_fuel", 20);
    // rust: f.float("speed_multiplier", 1.0);
}
    // rust: "minecraft:enchanting_table" => f.component("CustomName"),
    // rust: "minecraft:beacon" => {
    // rust: for key in ["primary_effect", "secondary_effect"] {
    // rust: if let Some(effect) = text(tag.get(key)) {
    // rust: f.put(key, string(&effect));
}
}
    // rust: f.int("Levels", 0);
    // rust: f.component("CustomName");
    // rust: f.lock();
}
    // rust: "minecraft:skull" => {
    // rust: f.keep("profile", |t| {
    // rust: matches!(t, Tag::Compound(_) | Tag::String(_))
    // rust: });
    // rust: if let Some(sound) = text(tag.get("note_block_sound")) {
    // rust: f.put("note_block_sound", string(&sound));
}
    // rust: f.component("custom_name");
}
    // rust: "minecraft:comparator" => f.int("OutputSignal", 0),
    // rust: "minecraft:banner" => {
    // rust: if let Some(patterns @ Tag::List(list)) = tag.get("patterns")
    // rust: && !list.is_empty()
    // rust: {
    // rust: f.put("patterns", patterns.clone());
}
    // rust: f.component("CustomName");
}
    // rust: "minecraft:structure_block" => {
    // rust: f.string("name", "");
    // rust: f.string("author", "");
    // rust: f.string("metadata", "");
    // rust: f.int_clamped("posX", 0, -48, 48);
    // rust: f.int_clamped("posY", 1, -48, 48);
    // rust: f.int_clamped("posZ", 0, -48, 48);
    // rust: f.int_clamped("sizeX", 0, 0, 48);
    // rust: f.int_clamped("sizeY", 0, 0, 48);
    // rust: f.int_clamped("sizeZ", 0, 0, 48);
    // rust: f.string("rotation", "NONE");
    // rust: f.string("mirror", "NONE");
    // rust: f.string("mode", "DATA");
    // rust: f.flag("ignoreEntities", true);
    // rust: f.flag("strict", false);
    // rust: f.flag("powered", false);
    // rust: f.flag("showair", false);
    // rust: f.flag("showboundingbox", true);
    // rust: f.float("integrity", 1.0);
    // rust: f.long("seed", 0);
}
    // rust: "minecraft:command_block" => {
    // rust: f.string("Command", "");
    // rust: f.int("SuccessCount", 0);
    // rust: f.component("CustomName");
    // rust: let track = flag(tag.get("TrackOutput")).unwrap_or(true);
    // rust: f.put("TrackOutput", boolean(track));
    // rust: if track {
    // rust: f.component("LastOutput");
}
    // rust: let update = flag(tag.get("UpdateLastExecution")).unwrap_or(true);
    // rust: f.put("UpdateLastExecution", boolean(update));
    // rust: if update && let Some(last) = long(tag.get("LastExecution")).filter(|l| *l != -1) {
    // rust: f.put("LastExecution", Tag::Long(last));
}
    // rust: f.flag("powered", false);
    // rust: f.flag("conditionMet", false);
    // rust: f.flag("auto", false);
}
    // rust: "minecraft:lectern" => {
    // rust: if f.item("Book") {
    // rust: f.int("Page", 0);
}
}
    // rust: "minecraft:jigsaw" => {
    // rust: f.string("name", "minecraft:empty");
    // rust: f.string("target", "minecraft:empty");
    // rust: f.string("pool", "minecraft:empty");
    // rust: f.string("final_state", "minecraft:air");
    // rust: f.string("joint", "rollable");
    // rust: f.int("placement_priority", 0);
    // rust: f.int("selection_priority", 0);
}
    // rust: "minecraft:campfire" => {
    // rust: f.items(4, true);
    // rust: for key in ["CookingTimes", "CookingTotalTimes"] {
    // rust: let mut times = [0; 4];
    // rust: if let Some(v) = int_array(tag.get(key)) {
    // rust: for (slot, t) in times.iter_mut().zip(v) {
    // rust: *slot = *t;
}
}
    // rust: f.put(key, Tag::IntArray(times.to_vec()));
}
}
    // rust: "minecraft:beehive" => {
    // rust: let bees = match tag.get("bees") {
    // rust: Some(Tag::List(list)) => list
    // rust: .iter()
    // rust: .filter_map(|bee| {
    // rust: let data = bee
    // rust: .get("entity_data")
    // rust: .filter(|d| matches!(d, Tag::Compound(_)))?;
    // rust: Some(Tag::compound([
    // rust: ("entity_data", data.clone()),
    // rust: ("ticks_in_hive", Tag::Int(int(bee.get("ticks_in_hive"))?)),
    // rust: (
    // rust: "min_ticks_in_hive",
    // rust: Tag::Int(int(bee.get("min_ticks_in_hive"))?),
    // rust: ),
    // rust: ]))
    // rust: })
    // rust: .collect(),
    // rust: _ => Vec::new(),
}
    // rust: f.put("bees", Tag::List(bees));
    // rust: f.keep("flower_pos", is_pos);
}
    // rust: "minecraft:sculk_sensor" | "minecraft:calibrated_sculk_sensor" => {
    // rust: f.int("last_vibration_frequency", 0);
    // rust: f.compound_or("listener", listener());
}
    // rust: "minecraft:sculk_shrieker" => {
    // rust: f.int("warning_level", 0);
    // rust: f.compound_or("listener", listener());
}
    // rust: "minecraft:sculk_catalyst" => {
    // rust: let cursors = match tag.get("cursors") {
    // rust: Some(t @ Tag::List(_)) => t.clone(),
    // rust: _ => Tag::List(Vec::new()),
}
    // rust: f.put("cursors", cursors);
}
    // rust: "minecraft:chiseled_bookshelf" => {
    // rust: f.items(6, true);
    // rust: f.int("last_interacted_slot", -1);
}
    // rust: "minecraft:shelf" => {
    // rust: f.items(3, true);
    // rust: f.flag("align_items_to_bottom", false);
}
    // rust: "minecraft:brushable_block" => {
    // rust: if !f.loot_table() {
    // rust: f.item("item");
}
}
    // rust: "minecraft:decorated_pot" => {
    // rust: if let Some(Tag::Compound(sherds)) = tag.get("sherds") {
    // rust: let kept: Compound = ["back", "left", "right", "front"]
    // rust: .iter()
    // rust: .filter_map(|side| {
    // rust: Some(((*side).into(), template(sherds.get(&(*side).into())?)?))
    // rust: })
    // rust: .collect();
    // rust: if !kept.is_empty() {
    // rust: f.put("sherds", Tag::Compound(kept));
}
}
    // rust: if !f.loot_table() {
    // rust: f.item("item");
}
}
    // rust: "minecraft:trial_spawner" => {
            // `TrialSpawnerStateData.Packed` and `FullConfig`: every key is optional
            // and defaulted by vanilla; they are kept as loaded. No `spawn_data` is
            // added: an absent one loads as Optional.empty and is not stored, and
            // an empty entity would keep the spawner from ever picking a mob.
    // rust: if let Tag::Compound(c) = tag {
    // rust: for (k, v) in c {
    // rust: let key = k.to_string_lossy();
    // rust: if !matches!(
    // rust: key.as_str(),
    // rust: "id" | "x" | "y" | "z" | "keepPacked" | "components"
    // rust: ) {
    // rust: f.out.insert(k.clone(), v.clone());
}
}
}
}
    // rust: "minecraft:vault" => {
            // `VaultConfig.DEFAULT` (when the config is absent): the trial key and the
            // default reward table, which is not saved.
    // rust: f.compound_or(
    // rust: "config",
    // rust: [(
    // rust: "key_item".into(),
    // rust: Tag::compound([
    // rust: ("count", Tag::Int(1)),
    // rust: ("id", string("minecraft:trial_key")),
    // rust: ]),
    // rust: )]
    // rust: .into_iter()
    // rust: .collect(),
    // rust: );
    // rust: f.compound_or("shared_data", Compound::new());
    // rust: f.compound_or("server_data", Compound::new());
}
    // rust: "minecraft:test_block" => {
    // rust: f.string("mode", "fail");
    // rust: f.string("message", "");
    // rust: f.flag("powered", false);
}
    // rust: "minecraft:test_instance_block" => {
    // rust: f.compound_or(
    // rust: "data",
    // rust: [
    // rust: ("ignore_entities".into(), boolean(false)),
    // rust: ("rotation".into(), string("none")),
    // rust: ("size".into(), Tag::IntArray(vec![0, 0, 0])),
    // rust: ("status".into(), string("cleared")),
    // rust: ]
    // rust: .into_iter()
    // rust: .collect(),
    // rust: );
    // rust: if let Some(errors @ Tag::List(list)) = tag.get("errors")
    // rust: && !list.is_empty()
    // rust: {
    // rust: f.put("errors", errors.clone());
}
}
    // rust: "minecraft:potent_sulfur" => f.int("countdown", -1),
    // rust: _ => return None,
}
    // rust: let mut out = f.out;
    // rust: out.insert("id".into(), string(&id));
    // rust: out.insert("x".into(), Tag::Int(x));
    // rust: out.insert("y".into(), Tag::Int(y));
    // rust: out.insert("z".into(), Tag::Int(z));
    // rust: out.insert("keepPacked".into(), Tag::Byte(0));
    // rust: out.insert(
    // rust: "components".into(),
    // rust: match tag.get("components") {
    // rust: Some(c @ Tag::Compound(_)) => c.clone(),
    // rust: _ => Tag::Compound(Compound::new()),
    // rust: },
    // rust: );
    // rust: Some(Tag::Compound(out))
}

// `VibrationSystem.Data` for a sensor with no pending vibration.
listener :: proc() -> C {
    // Ported from Horizon
    return {}
}
    // rust: [
    // rust: ("event_delay".into(), Tag::Int(0)),
    // rust: ("selector".into(), Tag::compound([("tick", Tag::Long(-1))])),
    // rust: ]
    // rust: .into_iter()
    // rust: .collect()
}
// Whether a stack plays a song (`JukeboxSong.fromStack`): a music disc or an item
// with the `jukebox_playable` component.
is_record :: proc(item: ^Compound) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let id = match item.get(&"id".into()) {
    // rust: Some(Tag::String(s)) => s.to_string_lossy(),
    // rust: _ => return false,
}
    // rust: id.starts_with("minecraft:music_disc_")
    // rust: || matches!(item.get(&"components".into()), Some(Tag::Compound(c)) if c.contains_key(&"minecraft:jukebox_playable".into()))
}

// Three-way merge of a block entity: `original` is the NBT it was loaded from,
// `loaded` what Horizon encodes right after decoding it, and `current` what Horizon
// encodes now. Whatever the game left unchanged since loading keeps its original
// form (including the detail Horizon does not model, such as styled text), what it
// changed takes the current value, and keys Horizon never models stay.
overlay :: proc(original: ^Tag, loaded: ^Tag, current: ^Tag) -> T {
    // Ported from Horizon
    return {}
}
    // rust: if current == loaded {
    // rust: return original.clone();
}
    // rust: match (original, loaded, current) {
    // rust: (Tag::Compound(o), Tag::Compound(l), Tag::Compound(c)) => {
    // rust: let mut out = Compound::new();
    // rust: for (key, cv) in c {
    // rust: let value = match (o.get(key), l.get(key)) {
    // rust: (Some(ov), Some(lv)) => overlay(ov, lv, cv),
    // rust: _ => cv.clone(),
}
    // rust: out.insert(key.clone(), value);
}
            // Keys the game never models (or models only when present) survive;
            // keys it removed are gone.
    // rust: for (key, ov) in o {
    // rust: if !c.contains_key(key) && !l.contains_key(key) {
    // rust: out.insert(key.clone(), ov.clone());
}
}
    // rust: Tag::Compound(out)
}
    // rust: (Tag::List(o), Tag::List(l), Tag::List(c)) if keyed_by_slot(c) && keyed_by_slot(l) => {
    // rust: let slot = |t: &Tag| int(t.get("Slot"));
    // rust: Tag::List(
    // rust: c.iter()
    // rust: .map(|cv| {
    // rust: let s = slot(cv);
find :: proc(list: ^[Tag], slot: Maybe(i32)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: list.iter().find(|t| int(t.get("Slot")) == slot)
}
    // rust: match (find(o, s), find(l, s)) {
    // rust: (Some(ov), Some(lv)) => overlay(ov, lv, cv),
    // rust: _ => cv.clone(),
}
    // rust: })
    // rust: .collect(),
    // rust: )
}
    // rust: _ => current.clone(),
}
}
keyed_by_slot :: proc(list: ^[Tag]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: list.iter().all(|t| t.get("Slot").is_some())
}

    // rust: mod tests {
//     use super::*;
//     use horizon_world::nbt::parse_snbt;

snbt :: proc(s: string) -> T {
    // Ported from Horizon
    return {}
}
    // rust: parse_snbt(s).expect("snbt").0
}
canon :: proc(s: string) -> T {
    // Ported from Horizon
    return {}
}
    // rust: canonical(&snbt(s)).expect("known type")
}

a_trial_spawner_without_spawn_data_saves_none :: proc() {
}
    // rust: let fresh = canon(
    // rust: r#"{id:"minecraft:trial_spawner",x:1,y:2,z:3,normal_config:"minecraft:trial_chamber/ranged/skeleton/normal"}"#,
    // rust: );
    // rust: assert_eq!(fresh.get("spawn_data"), None);
    // rust: let picked = canon(
    // rust: r#"{id:"minecraft:trial_spawner",x:1,y:2,z:3,spawn_data:{entity:{id:"minecraft:skeleton"}}}"#,
    // rust: );
    // rust: assert_eq!(
    // rust: picked.get("spawn_data"),
    // rust: Some(&snbt(r#"{entity:{id:"minecraft:skeleton"}}"#))
    // rust: );
}

every_type_has_defaults :: proc() {
}
    // rust: for id in TYPES.iter().chain(NEWEST.iter()) {
    // rust: let tag = snbt(&format!("{{id:\"{id}\",x:1,y:2,z:3}}"));
    // rust: let out = canonical(&tag).unwrap_or_else(|| panic!("{id}"));
    // rust: assert_eq!(out.get("id"), tag.get("id"));
    // rust: assert_eq!(out.get("keepPacked"), Some(&Tag::Byte(0)), "{id}");
    // rust: assert_eq!(
    // rust: out.get("components"),
    // rust: Some(&Tag::Compound(Compound::new())),
    // rust: "{id}"
    // rust: );
}
    // rust: assert!(canonical(&snbt("{id:\"minecraft:nope\",x:1,y:2,z:3}")).is_none());
}

furnace_defaults_match_vanilla :: proc() {
}
    // rust: let out = canon("{id:\"minecraft:furnace\",x:1,y:2,z:3}");
    // rust: assert_eq!(out.get("cooking_total_time"), Some(&Tag::Int(0)));
    // rust: assert_eq!(out.get("speed_multiplier"), Some(&f32_tag(1.0)));
    // rust: assert_eq!(out.get("Items"), Some(&Tag::List(vec![])));
    // rust: assert_eq!(
    // rust: out.get("RecipesUsed"),
    // rust: Some(&Tag::Compound(Compound::new()))
    // rust: );
}

    // `PistonMovingBlockEntity.saveAdditional`: `facing` through
    // `Direction.LEGACY_ID_CODEC` (a byte), `progress` a float.
moving_piston_fields_match_vanilla :: proc() {
}
    // rust: let out = canon(
    // rust: "{id:\"minecraft:piston\",x:1,y:2,z:3,blockState:{Name:\"minecraft:stone\"},\
    // rust: facing:5,progress:0.5f,extending:1b,source:0b}",
    // rust: );
    // rust: assert_eq!(out.get("facing"), Some(&Tag::Byte(5)));
    // rust: assert_eq!(out.get("progress"), Some(&f32_tag(0.5)));
    // rust: assert_eq!(out.get("extending"), Some(&Tag::Byte(1)));
    // rust: assert_eq!(out.get("source"), Some(&Tag::Byte(0)));
    // rust: let fresh = canon("{id:\"minecraft:piston\",x:1,y:2,z:3}");
    // rust: assert_eq!(fresh.get("facing"), Some(&Tag::Byte(0)));
    // rust: assert_eq!(fresh.get("blockState"), Some(&string("minecraft:air")));
}

loot_table_replaces_items_and_zero_seed_is_omitted :: proc() {
}
    // rust: let out = canon(
    // rust: "{id:\"minecraft:chest\",x:1,y:2,z:3,LootTable:\"minecraft:chests/x\",LootTableSeed:0L,\
    // rust: Items:[{Slot:0b,id:\"minecraft:stone\",count:1}]}",
    // rust: );
    // rust: assert!(out.get("Items").is_none());
    // rust: assert!(out.get("LootTableSeed").is_none());
    // rust: assert_eq!(out.get("LootTable"), Some(&string("minecraft:chests/x")));
}

invalid_loot_table_leaves_items_intact :: proc() {
}
    // rust: let out = canon(
    // rust: "{id:\"minecraft:barrel\",x:1,y:2,z:3,LootTable:\"INVALID TABLE\",\
    // rust: Items:[{Slot:0b,id:\"minecraft:stone\",count:1}]}",
    // rust: );
    // rust: assert!(out.get("Items").is_some());
    // rust: assert!(out.get("LootTable").is_none());
}

items_are_validated_and_sorted_by_slot :: proc() {
}
    // rust: let out = canon(
    // rust: "{id:\"minecraft:hopper\",x:1,y:2,z:3,Items:[\
    // rust: {Slot:4b,id:\"minecraft:stone\",count:2},{Slot:5b,id:\"minecraft:stone\",count:1},\
    // rust: {Slot:0b,id:\"minecraft:air\",count:1},{Slot:1b,id:\"minecraft:dirt\"},\
    // rust: {Slot:2b,id:\"minecraft:dirt\",count:100}]}",
    // rust: );
    // rust: let Some(Tag::List(items)) = out.get("Items") else {
    // rust: panic!("items")
}
    // rust: let slots: Vec<_> = items.iter().map(|i| i.get("Slot").cloned()).collect();
    // rust: assert_eq!(slots, vec![Some(Tag::Byte(1)), Some(Tag::Byte(4))]);
    // rust: assert_eq!(items[0].get("count"), Some(&Tag::Int(1)));
    // rust: assert_eq!(out.get("TransferCooldown"), Some(&Tag::Int(-1)));
}

plain_text_components_become_strings :: proc() {
}
    // rust: let out =
    // rust: canon("{id:\"minecraft:banner\",x:1,y:2,z:3,CustomName:{text:\"Flag\"},patterns:[]}");
    // rust: assert_eq!(out.get("CustomName"), Some(&string("Flag")));
    // rust: assert!(out.get("patterns").is_none());
    // rust: let styled =
    // rust: canon("{id:\"minecraft:banner\",x:1,y:2,z:3,CustomName:{text:\"F\",color:\"red\"}}");
    // rust: assert!(matches!(styled.get("CustomName"), Some(Tag::Compound(_))));
}

shulker_box_omits_empty_items_and_structure_block_clamps :: proc() {
}
    // rust: let shulker = canon("{id:\"minecraft:shulker_box\",x:1,y:2,z:3}");
    // rust: assert!(shulker.get("Items").is_none());
    // rust: let structure = canon("{id:\"minecraft:structure_block\",x:1,y:2,z:3,posX:99,sizeY:-4}");
    // rust: assert_eq!(structure.get("posX"), Some(&Tag::Int(48)));
    // rust: assert_eq!(structure.get("sizeY"), Some(&Tag::Int(0)));
    // rust: assert_eq!(structure.get("posY"), Some(&Tag::Int(1)));
    // rust: assert_eq!(structure.get("showboundingbox"), Some(&Tag::Byte(1)));
}

canonical_is_idempotent :: proc() {
}
    // rust: for id in TYPES.iter().chain(NEWEST.iter()) {
    // rust: let once = canonical(&snbt(&format!("{{id:\"{id}\",x:1,y:2,z:3}}"))).expect("known");
    // rust: assert_eq!(canonical(&once).as_ref(), Some(&once), "{id}");
}
}

overlay_keeps_unchanged_detail_and_takes_changes :: proc() {
}
    // rust: let original = snbt(
    // rust: "{id:\"minecraft:sign\",front_text:{messages:[{text:\"a\",color:\"red\"},\"\",\"\",\"\"]},\
    // rust: back_text:{messages:[\"x\",\"\",\"\",\"\"]},extra:1b}",
    // rust: );
    // rust: let loaded = snbt(
    // rust: "{id:\"minecraft:sign\",front_text:{messages:[\"a\",\"\",\"\",\"\"]},\
    // rust: back_text:{messages:[\"x\",\"\",\"\",\"\"]}}",
    // rust: );
    // rust: let current = snbt(
    // rust: "{id:\"minecraft:sign\",front_text:{messages:[\"a\",\"\",\"\",\"\"]},\
    // rust: back_text:{messages:[\"y\",\"\",\"\",\"\"]}}",
    // rust: );
    // rust: let merged = overlay(&original, &loaded, &current);
    // rust: assert_eq!(merged.get("front_text"), original.get("front_text"));
    // rust: assert_eq!(merged.get("back_text"), current.get("back_text"));
    // rust: assert_eq!(merged.get("extra"), original.get("extra"));
}

overlay_merges_container_slots :: proc() {
}
    // rust: let item = |slot: i8, count: i32, extra: &str| {
    // rust: snbt(&format!(
    // rust: "{{Slot:{slot}b,id:\"minecraft:stone\",count:{count}{extra}}}"
    // rust: ))
}
    // rust: let original = Tag::compound([(
    // rust: "Items",
    // rust: Tag::List(vec![
    // rust: item(0, 1, ",components:{\"minecraft:lore\":[\"x\"]}"),
    // rust: item(1, 1, ""),
    // rust: ]),
    // rust: )]);
    // rust: let loaded = Tag::compound([("Items", Tag::List(vec![item(0, 1, ""), item(1, 1, "")]))]);
    // rust: let current = Tag::compound([("Items", Tag::List(vec![item(0, 1, ""), item(1, 5, "")]))]);
    // rust: let merged = overlay(&original, &loaded, &current);
    // rust: let Some(Tag::List(items)) = merged.get("Items") else {
    // rust: panic!("items")
}
    // rust: assert!(
    // rust: items[0].get("components").is_some(),
    // rust: "slot 0 keeps its lore"
    // rust: );
    // rust: assert_eq!(items[1].get("count"), Some(&Tag::Int(5)));
}
}
