//! Transpiled from Horizon Rust crate
//! Module: horizon-world_mod
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Vanilla's DataFixers (`net.minecraft.util.datafix`, DataVersion 99 on):
//! the data of worlds saved by 1.8 to 26.2 brought to the 26.3 format exactly
//! as 26.3 does when it reads them, and the file fixes it runs when it opens
//! such a world (`net.minecraft.util.filefix`).
//!
//! DataFixerUpper reads the data once with the schema of its version (running
//! the schema's read hooks), applies every fix with a key above that version
//! in order, and writes it with the current schema. Each fix finds its values
//! with the schema just below its own key ([`schema`]). Every
//! fix of the server data is ported ([`OLDEST_SUPPORTED`]). The fixes of client
//! files (options, debug profiles) are not ported either (creative toolbars in
//! `hotbar.nbt` are ported via [`update_hotbar`]).
    // rust: mod block_state_data;
    // rust: mod chunk_flatten;
    // rust: mod chunk_leaves;
    // rust: pub mod dynamic;
    // rust: pub mod files;
    // rust: mod fixes_a;
    // rust: mod fixes_b;
    // rust: mod fixes_c;
    // rust: mod fixes_cliffs;
    // rust: mod fixes_flat;
    // rust: mod fixes_legacy;
    // rust: mod fixes_mid;
    // rust: mod fixes_old;
    // rust: mod flat_tables;
    // rust: mod items;
    // rust: pub mod json;
    // rust: pub mod progress;
    // rust: pub mod schema;
    // rust: mod text;
    // rust: pub mod world_upgrader;

// use crate::nbt::Tag;
// use dynamic::{as_str, string};
// use schema::{Key, Ty, key, walk};

/// The DataVersion of the game.
pub const CURRENT: i32 = crate::DATA_VERSION;
/// Data saved before this DataVersion needs fixes that are not ported. Every
/// server fix is, down to the saves of 1.8, which have no DataVersion (read as -1).
pub const OLDEST_SUPPORTED: i32 = -1;

/// `Identifier.tryParse` validity, as `NamespacedSchema.ensureNamespaced` uses it.
pub fn identifier(id: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (ns, path) = match id.split_once(':') {
    // rust: Some((ns, path)) => (if ns.is_empty() { "minecraft" } else { ns }, path),
    // rust: None => ("minecraft", id),
}
    // rust: let ns_ok = ns
    // rust: .bytes()
    // rust: .all(|c| matches!(c, b'a'..=b'z' | b'0'..=b'9' | b'_' | b'-' | b'.'));
    // rust: let path_ok = path
    // rust: .bytes()
    // rust: .all(|c| matches!(c, b'a'..=b'z' | b'0'..=b'9' | b'_' | b'-' | b'.' | b'/'));
    // rust: (ns_ok && path_ok).then(|| (ns.to_owned(), path.to_owned()))
}

/// What a fix works on: the root value, its type and the fix's key.
pub const Cx = struct {
    root: Ty,
    data: *'a mut Tag,
    k: Key,
};

    // rust: impl Cx<'_> {
    /// Every value of `ty`, read with the fix's input schema.
pub fn each(self: *Self, ty: Ty, mut f: impl FnMut(*mut Tag) void {
}
    // rust: walk(self.root, self.data, self.k - 1, ty, &mut f);
}
    /// Every value of `ty` read with the fix's output schema (fixes declared
    /// on `getOutputSchema().getType(...)`).
pub fn each_out(self: *Self, ty: Ty, mut f: impl FnMut(*mut Tag) void {
}
    // rust: walk(self.root, self.data, self.k, ty, &mut f);
}
    /// Every entity of one type (`NamedEntityFix` and friends).
pub fn entity(self: *Self, id: []const u8, mut f: impl FnMut(*mut Tag) void {
}
    // rust: self.each(Ty::Entity, |e| {
    // rust: if id_is(e, id) {
    // rust: f(e);
}
    // rust: });
}
    /// Every block entity of one type.
pub fn block_entity(self: *Self, id: []const u8, mut f: impl FnMut(*mut Tag) void {
}
    // rust: self.each(Ty::BlockEntity, |e| {
    // rust: if id_is(e, id) {
    // rust: f(e);
}
    // rust: });
}
    /// Every item stack whose id passes `filter`.
pub fn item(self: *Self, filter: impl Fn([]const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.each(Ty::ItemStack, |s| {
    // rust: if let Some(id) = as_str(s.get("id"))
    // rust: && filter(&dynamic::namespaced(&id))
    // rust: {
    // rust: f(s);
}
    // rust: });
}
    /// A name type renamed in place (`fixTypeEverywhere` over a namespaced string).
pub fn rename(self: *Self, ty: Ty, rename: impl Fn([]const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.each(ty, |v| {
    // rust: if let Some(name) = as_str(Some(v))
    // rust: && let Some(new) = rename(&name)
    // rust: {
    // rust: *v = string(new);
}
    // rust: });
}
}

/// DataFixerUpper reads a record's typed fields from its map without taking
/// them out: the record's remainder keeps the whole map it was read from, and
/// writing lays the typed fields over it. A typed field that a fix drops (by
/// casting to a type without it) therefore comes back on write with its value
/// from that read. Each entity keeps that map under this key while fixes run.
    // rust: pub(crate) const LAST_READ: &str = "\u{0}last_read";

/// Remember a record's current fields as the map it was read from.
pub fn mark_read(e: *mut Tag) void {
}
    // rust: if let Tag::Compound(_) = e {
    // rust: let mut raw = e.clone();
    // rust: strip_last_read(&mut raw);
    // rust: dynamic::set(e, LAST_READ, raw);
}
}

/// `Util.writeAndReadTypedOrThrow` over an entity by the fix with key `k`: it is
/// written and read again with the output schema, so it (and every entity inside
/// it) now remembers its current fields as the map it was last read from.
pub fn reread(k: Key, e: *mut Tag) void {
}
    // rust: reread_as(Ty::Entity, k, e);
}

/// [`reread`] for a value of another type (a block entity).
pub fn reread_as(ty: Ty, k: Key, v: *mut Tag) void {
}
    // What was untyped is read again with the new schema.
    // rust: schema::flat::strip_untyped(v);
    // rust: schema::flat::mark_untyped(ty, v, k);
    // rust: walk(ty, v, k, Ty::BlockEntity, &mut mark_read);
    // rust: walk(ty, v, k, Ty::Entity, &mut mark_read);
}

/// A typed field dropped from an entity: what writing the entity gives back for
/// it (its value in the map the entity was last read from, if any).
pub fn drop_typed(e: *mut Tag, field: []const u8) void {
}
    // rust: match e.get(LAST_READ).and_then(|raw| raw.get(field)).cloned() {
    // rust: Some(raw) => dynamic::set(e, field, raw),
    // rust: None => {
    // rust: dynamic::remove(e, field);
}
}
}

pub fn strip_last_read(v: *mut Tag) void {
}
    // rust: match v {
    // rust: Tag::Compound(c) => {
    // rust: c.remove(&dynamic::key(LAST_READ));
    // rust: c.remove(&dynamic::key(schema::flat::UNTYPED));
    // rust: for value in c.values_mut() {
    // rust: strip_last_read(value);
}
}
    // rust: Tag::List(items) => items.iter_mut().for_each(strip_last_read),
    // rust: _ => {}
}
}

/// The entity or block entity `id` field, namespaced.
pub fn id_is(v: *Tag, id: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: as_str(v.get("id")).is_some_and(|s| dynamic::namespaced(&s) == id)
}

/// `createRenamer`: the id namespaced, looked up in a table.
    // rust: pub fn renamer<'a>(
    // rust: table: &'a [(&'a str, &'static str)],
    // rust: ) -> impl Fn(&str) -> Option<&'static str> + 'a {
    // rust: move |id: &str| {
    // rust: let id = dynamic::namespaced(id);
    // rust: table
    // rust: .iter()
    // rust: .find(|(from, _)| *from == id)
    // rust: .map(|(_, to)| *to)
}
}

    // rust: type FixFn = fn(&mut Cx);

/// Every ported fix (from the 1.19 schemas on), in DataFixers order.
pub fn fixes() V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Vec::new();
    // rust: fixes_legacy::register(&mut out);
    // rust: fixes_flat::register(&mut out);
    // rust: fixes_mid::register(&mut out);
    // rust: fixes_cliffs::register(&mut out);
    // rust: fixes_old::register(&mut out);
    // rust: fixes_a::register(&mut out);
    // rust: fixes_b::register(&mut out);
    // rust: fixes_c::register(&mut out);
    // DataFixerBuilder sorts the fixes of equal keys by registration, the rest by key.
    // rust: out.sort_by_key(|(k, _)| *k);
    // rust: out
}

/// `DataFixer.update(type, data, from, to)` for a root value.
pub fn update(root: Ty, data: *mut Tag, from: i32, to: i32) void {
}
    // rust: if from >= to {
    // rust: return;
}
    // rust: let from_key = key(from.max(0) as u32, 0);
    // rust: let to_version = to as u32;
    // The data is read once with the schema of its version (its read hooks)...
    // rust: walk(root, data, from_key, Ty::BlockEntity, &mut mark_read);
    // rust: walk(root, data, from_key, Ty::Entity, &mut mark_read);
    // rust: schema::flat::mark_untyped(root, data, from_key);
    // rust: read_hooks(root, data, from_key);
    // ...then every fix above that key, up to the target version...
    // rust: let mut refreshed = from_key >= schema::flat::END;
    // rust: for (k, fix) in fixes() {
    // rust: if k > from_key && k / 10 <= to_version {
    // rust: if !refreshed && k >= schema::flat::END {
                // The data of before 1.14 is read again once its own fixes are done.
    // rust: refreshed = true;
    // rust: walk(
    // rust: root,
    // rust: data,
    // rust: schema::flat::END - 1,
    // rust: Ty::BlockEntity,
    // rust: &mut mark_read,
    // rust: );
    // rust: walk(
    // rust: root,
    // rust: data,
    // rust: schema::flat::END - 1,
    // rust: Ty::Entity,
    // rust: &mut mark_read,
    // rust: );
}
    // rust: fix(&mut Cx { root, data, k });
}
}
    // ...and written with the target schema (its write hooks).
    // rust: write_hooks(root, data, key(to_version, 9));
    // rust: strip_last_read(data);
}

/// The read hooks of the schema the data was saved with.
pub fn read_hooks(root: Ty, data: *mut Tag, k: Key) void {
}
    // rust: walk(root, data, k, Ty::ItemStack, &mut |stack| {
    // rust: if k < key(3818, 5) {
    // rust: items::add_names_at(stack, k);
    // rust: } else if let Tag::String(_) = stack {
            // V3818_5 UNPACK_PLAIN_ID: a bare item id is a stack of one.
    // rust: *stack = Tag::compound([("id", stack.clone()), ("count", Tag::Int(1))]);
}
    // rust: });
    // rust: if k >= key(1451, 6) {
    // rust: walk(root, data, k, Ty::Objective, &mut fixes_a::unpack_objective);
}
    // Block names are numbers or namespaced strings until V1451_4: a number is read as an
    // int and written as one.
    // rust: walk(root, data, k, Ty::BlockName, &mut |name| {
    // rust: if let Some(n) = as_str(Some(name)) {
    // rust: *name = string(&dynamic::namespaced(&n));
    // rust: } else if k < key(1451, 4)
    // rust: && let Some(n) = dynamic::as_number(name)
    // rust: {
    // rust: *name = Tag::Int(n.int_value());
}
    // rust: });
    // Namespaced name types read their strings with `ensureNamespaced`.
    // rust: for ty in [Ty::Biome, Ty::EntityName, Ty::ItemName] {
    // rust: walk(root, data, k, ty, &mut |name| {
    // rust: if let Some(n) = as_str(Some(name)) {
    // rust: *name = string(&dynamic::namespaced(&n));
}
    // rust: });
}
}

pub fn write_hooks(root: Ty, data: *mut Tag, k: Key) void {
}
    // rust: walk(root, data, k, Ty::Objective, &mut fixes_a::repack_objective);
}

/// `SimpleRegionStorage.upgradeChunkTag` for a region chunk (`ChunkMap`):
/// the dimension and generator are passed to the fixes as `__context`.
pub fn update_chunk(tag: *mut Tag, dimension: []const u8, generator: ?[]const u8) void {
}
    // rust: update_chunk_to(tag, dimension, generator, CURRENT);
}

/// [`update_chunk`] up to an older DataVersion than the current one (the
/// harness checks the fixes of a range of versions on their own).
pub fn update_chunk_to(tag: *mut Tag, dimension: []const u8, generator: ?[]const u8, to: i32) void {
}
    // rust: let version = dynamic::as_int(tag.get("DataVersion"), -1);
    // rust: if version >= to {
    // rust: return;
}
    // rust: let mut context = Tag::compound([("dimension", string(dimension))]);
    // rust: if let Some(g) = generator {
    // rust: dynamic::set(&mut context, "generator", string(g));
}
    // rust: dynamic::set(tag, "__context", context);
    // rust: update(Ty::Chunk, tag, version, to);
    // rust: dynamic::remove(tag, "__context");
    // rust: dynamic::set(tag, "DataVersion", Tag::Int(to));
}

/// `SimpleRegionStorage.upgradeChunkTag` for entity chunks (default version -1)
/// and POI chunks (default 1945).
pub fn update_region_tag(root: Ty, tag: *mut Tag) void {
}
    // rust: update_region_tag_to(root, tag, CURRENT);
}

/// [`update_region_tag`] up to an older DataVersion.
pub fn update_region_tag_to(root: Ty, tag: *mut Tag, to: i32) void {
}
    // rust: let default = if root == Ty::PoiChunk { 1945 } else { -1 };
    // rust: let version = dynamic::as_int(tag.get("DataVersion"), default);
    // rust: if version >= to {
    // rust: return;
}
    // rust: update(root, tag, version, to);
    // rust: dynamic::set(tag, "DataVersion", Tag::Int(to));
}

/// `PlayerDataStorage.load`: the DataVersion field stays as loaded.
pub fn update_player(tag: *mut Tag) void {
}
    // rust: let version = dynamic::as_int(tag.get("DataVersion"), -1);
    // rust: update(Ty::Player, tag, version, CURRENT);
}

/// [`update_player`] up to an older DataVersion.
pub fn update_player_to(tag: *mut Tag, to: i32) void {
}
    // rust: let version = dynamic::as_int(tag.get("DataVersion"), -1);
    // rust: update(Ty::Player, tag, version, to);
    // rust: dynamic::set(tag, "DataVersion", Tag::Int(to));
}

/// `HotbarManager.load`: a creative toolbar file (`hotbar.nbt`, its DataVersion
/// 1343 when missing) brought to the current version.
pub fn update_hotbar(tag: *mut Tag) void {
}
    // rust: let version = dynamic::as_int(tag.get("DataVersion"), 1343);
    // rust: update(Ty::Hotbar, tag, version, CURRENT);
}

/// The saved data type of a file below a `data` folder (`namespace/path.dat`).
pub fn saved_data_type(relative: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = relative.strip_suffix(".dat").unwrap_or(relative);
    // rust: if name.ends_with("/command_storage") {
    // rust: return Some(Ty::SavedCommandStorage);
}
    // rust: if let Some(n) = name.strip_prefix("minecraft/maps/")
    // rust: && !n.is_empty()
    // rust: && n.bytes().all(|b| b.is_ascii_digit())
    // rust: {
    // rust: return Some(Ty::SavedMapData);
}
    // rust: Some(match name {
    // rust: "minecraft/custom_boss_events" => Ty::SavedCustomBossEvents,
    // rust: "minecraft/scoreboard" => Ty::SavedScoreboard,
    // rust: "minecraft/chunk_tickets" => Ty::SavedTickets,
    // rust: "minecraft/world_border" => Ty::SavedWorldBorder,
    // rust: "minecraft/game_rules" => Ty::SavedGameRules,
    // rust: "minecraft/ender_dragon_fight" => Ty::SavedEnderDragonFight,
    // rust: "minecraft/wandering_trader" => Ty::SavedWanderingTrader,
    // rust: "minecraft/maps/last_id" => Ty::SavedMapIndex,
    // rust: "minecraft/weather" => Ty::SavedWeather,
    // rust: "minecraft/scheduled_events" => Ty::SavedScheduledEvents,
    // rust: "minecraft/world_gen_settings" => Ty::SavedWorldGenSettings,
    // rust: "minecraft/random_sequences" => Ty::SavedRandomSequences,
    // rust: "minecraft/stopwatches" => Ty::SavedStopwatches,
    // rust: "minecraft/raids" => Ty::SavedRaids,
    // rust: "minecraft/world_clocks" => Ty::SavedWorldClocks,
    // rust: _ => return None,
    // rust: })
}

/// `SavedDataStorage.readTagFromDisk`: default version 1343, field kept.
pub fn update_saved_data(ty: Ty, tag: *mut Tag) void {
}
    // rust: let version = dynamic::as_int(tag.get("DataVersion"), 1343);
    // rust: update(ty, tag, version, CURRENT);
}

    // rust: mod tests;
