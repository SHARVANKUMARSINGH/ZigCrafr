//! Transpiled from Horizon Rust crate
//! Module: horizon-client_data
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! What the configuration phase sends: the synchronized registries (names in
//! network order, with their data for clients that do not know the vanilla
//! pack) and the tags of every registry, loaded from the prepared resources
//! (`data/minecraft/...`) and the registries report.
// use crate::chunk::LevelShapes;
// use horizon_protocol::{
    // rust: packets::configuration::{RegistryData, RegistryEntry, RegistryTags, TagEntry, UpdateTags},
    // rust: registry::{Builtin, Dynamic},
}
// use horizon_world::nbt::{JavaString, Tag};
// use serde_json::Value;
// use std::{
    // rust: collections::{BTreeMap, HashMap, HashSet},
    // rust: path::{Path, PathBuf},
}

/// RegistryDataLoader.SYNCHRONIZED_REGISTRIES, in vanilla's order.
    // rust: pub const SYNCHRONIZED: &[&str] = &[
    // rust: "minecraft:worldgen/biome",
    // rust: "minecraft:chat_type",
    // rust: "minecraft:trim_pattern",
    // rust: "minecraft:trim_material",
    // rust: "minecraft:wolf_variant",
    // rust: "minecraft:wolf_sound_variant",
    // rust: "minecraft:pig_variant",
    // rust: "minecraft:pig_sound_variant",
    // rust: "minecraft:frog_variant",
    // rust: "minecraft:cat_variant",
    // rust: "minecraft:cat_sound_variant",
    // rust: "minecraft:cow_sound_variant",
    // rust: "minecraft:cow_variant",
    // rust: "minecraft:chicken_sound_variant",
    // rust: "minecraft:chicken_variant",
    // rust: "minecraft:zombie_nautilus_variant",
    // rust: "minecraft:painting_variant",
    // rust: "minecraft:sulfur_cube_archetype",
    // rust: "minecraft:dimension_type",
    // rust: "minecraft:damage_type",
    // rust: "minecraft:banner_pattern",
    // rust: "minecraft:enchantment",
    // rust: "minecraft:jukebox_song",
    // rust: "minecraft:instrument",
    // rust: "minecraft:test_environment",
    // rust: "minecraft:test_instance",
    // rust: "minecraft:dialog",
    // rust: "minecraft:world_clock",
    // rust: "minecraft:timeline",
    // rust: "minecraft:decorated_pot_pattern",
    // rust: "minecraft:block_transformer",
    // rust: "minecraft:worldgen/block_state_provider",
    // rust: ];
pub const BIOME_REGISTRY: []const u8 = "minecraft:worldgen/biome";
/// The table a client plays a server with: `known` and the biomes of the
/// server's biome registry that it lacks, built from their data; None when
/// there are none.
    // rust: pub fn client_biomes(
    // rust: known: &crate::biome::Biomes,
    // rust: registry: &[(String, Option<Tag>)],
    // rust: ) -> Option<crate::biome::Biomes> {
    // rust: let files: Vec<(&str, Value)> = registry
    // rust: .iter()
    // rust: .filter(|(name, _)| !known.contains(name))
    // rust: .filter_map(|(name, data)| {
    // rust: Some((
    // rust: name.as_str(),
    // rust: crate::scoreboard::tag_to_json(data.as_ref()?),
    // rust: ))
    // rust: })
    // rust: .collect();
    // rust: if files.is_empty() {
    // rust: return None;
}
    // rust: log::info!(
    // rust: "Horizon: the server has {} biomes the game lacks",
    // rust: files.len()
    // rust: );
    // rust: Some(known.with_packs(files.iter().map(|(n, v)| (*n, v))))
}
/// KnownPack.vanilla("core") for this version.
pub const CORE_PACK: ([]const u8, []const u8, []const u8) = ("minecraft", "core", horizon_protocol::GAME_VERSION);

/// Synchronized registries a world's data packs add entries to (or replace
/// them in). The others stay the game's own: Horizon's gameplay reads them
/// from the prepared resources only.
pub const PACK_REGISTRIES: *[[]const u8] = &["minecraft:dialog"];

/// A data-driven registry: entry names in network order and their NBT.
pub const Entries = struct {
    names: std.ArrayList([]const u8),
    data: std.ArrayList(Tag),
    /// The entry comes from a world's data pack, which no client knows, so
    /// its data is always sent.
    from_pack: std.ArrayList(bool),
};

/// The damage registry already bound for gameplay at world entry. Keeping
/// only these entries lets unrelated pack data remain lazy until a hub needs it.
pub const FrozenDamage = struct {};

    // rust: impl FrozenDamage {
    // rust: pub fn new(
    // rust: catalog: &horizon_world::damage_source::Catalog,
    // rust: overlay: &horizon_world::loot::PackOverlay<'_>,
    // rust: ) -> Self {
    // rust: let packed: HashSet<_> = overlay.kind("damage_type").map(|(id, _)| id).collect();
    // rust: let mut definitions: Vec<_> = catalog.entries().map(|(_, d)| d).collect();
    // rust: definitions.sort_by_cached_key(|d| {
    // rust: let (ns, path) = d.name.split_once(':').expect("canonical damage identifier");
    // rust: (format!("{path}.json"), ns.to_owned())
    // rust: });
    // rust: Self(Entries {
    // rust: names: definitions.iter().map(|d| d.name.clone()).collect(),
    // rust: data: definitions.iter().map(|d| d.to_nbt()).collect(),
    // rust: from_pack: definitions
    // rust: .iter()
    // rust: .map(|d| !d.name.starts_with("minecraft:") || packed.contains(d.name.as_str()))
    // rust: .collect(),
    // rust: })
}
}

pub const SyncData = struct {
    content_identity: Option<[u8,
    builtin: Builtin,
    /// Entry names per synchronized registry (for id lookups).
    dynamic: Dynamic,
    registries: Vec<([]const u8,
    tags: UpdateTags,
    features: std.ArrayList([]const u8),
    /// Vanilla's command tree (the commands report), when found.
    commands: ?super::commands::CommandTree,
    /// ClientboundUpdateRecipesPacket's payload.
    recipes: std.ArrayList(u8),
    advancements: super::advancements::ServerAdvancements,
};

// use crate::crafting::qualified;

/// Every `*.json` under `dir`, as (path without extension relative to dir, value), sorted;
/// a file that can't be read or doesn't parse is left out. Through `json_folder`: from the
/// prepared data file, and read once for the tables a load builds from the same folder.
pub fn walk(dir: *Path, out: *mut BTreeMap<[]const u8) void {
}
    // rust: let Ok(folder) = horizon_world::json_folder::read(dir) else {
    // rust: return;
}
    // rust: for file in &folder.files {
    // rust: if let Ok(value) = serde_json::from_slice::<Value>(file.bytes().unwrap_or_default()) {
    // rust: out.insert(file.name.clone(), value);
}
}
}

/// A synchronized registry's entries from the world's data packs (`<dir>/`
/// files, the top pack's for each id) over the game's own. Each entry is
/// ((namespace, path), JSON, from a pack); `file_order` sorts them.
    // rust: fn pack_entries(
    // rust: dir: &str,
    // rust: overlay: &horizon_world::loot::PackOverlay,
    // rust: entries: &mut Vec<((String, String), Value, bool)>,
    // rust: ) {
    // rust: for (id, files) in overlay.kind(dir) {
    // rust: let Some((ns, path)) = id.split_once(':') else {
    // rust: continue;
}
    // rust: let top = horizon_world::loot::PackOverlay::top(files);
    // rust: let value = match serde_json::from_slice::<Value>(top) {
    // rust: Ok(value) => value,
    // rust: Err(e) => {
    // rust: log::warn!("Horizon: data pack {dir} {id} is not read: {e}");
    // rust: continue;
}
}
    // rust: let key = (ns.to_owned(), path.to_owned());
    // rust: match entries.iter_mut().find(|(k, ..)| *k == key) {
    // rust: Some(entry) => {
    // rust: entry.1 = value;
    // rust: entry.2 = true;
}
    // rust: None => entries.push((key, value, true)),
}
}
}

/// ResourceManagerRegistryLoadTask.load: the entries register sorted by the
/// file `Identifier` FileToIdConverter.listMatchingResources keys them by
/// (`<dir>/<path>.json`), path first, then namespace (Identifier.compareTo).
/// The `.json` counts: `x-y` comes before `x`, as `-` sorts before `.`.
    // rust: fn file_order<T>(entries: &mut [((String, String), T, bool)]) {
    // rust: entries.sort_by_cached_key(|((ns, path), ..)| (format!("{path}.json"), ns.clone()));
}

/// A JSON value as the NBT that vanilla's NbtOps would produce from the codec
/// (integers are ints, other numbers doubles, booleans bytes).
pub fn json_to_nbt(v: *Value) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match v {
    // rust: Value::Null => Tag::compound(Vec::<(&str, Tag)>::new()),
    // rust: Value::Bool(b) => Tag::Byte(i8::from(*b)),
    // rust: Value::Number(n) => match n.as_i64() {
    // rust: Some(i) => match i32::try_from(i) {
    // rust: Ok(i) => Tag::Int(i),
    // rust: Err(_) => Tag::Long(i),
    // rust: },
    // rust: None => Tag::Double(n.as_f64().unwrap_or(0.0).to_bits()),
    // rust: },
    // rust: Value::String(s) => Tag::String(JavaString::from(s.as_str())),
    // rust: Value::Array(a) => Tag::List(a.iter().map(json_to_nbt).collect()),
    // rust: Value::Object(o) => Tag::compound(o.iter().map(|(k, v)| (k.as_str(), json_to_nbt(v)))),
}
}

/// A component's JSON as NbtOps writes it. A list whose elements differ in type
/// (translation arguments mixing numbers and components) stays one list: the NBT
/// writer wraps each element that isn't a compound under the empty key, as
/// `ListTag.wrapIfNeeded` does, so wrapping it here too would leave the client a
/// `{"": 1}` argument it cannot read.
pub fn component_nbt(v: *Value) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match v {
    // rust: Value::Array(a) => Tag::List(a.iter().map(component_nbt).collect()),
    // rust: Value::Object(o) => Tag::compound(o.iter().map(|(k, v)| (k.as_str(), component_nbt(v)))),
    // rust: other => json_to_nbt(other),
}
}

    // rust: impl SyncData {
    /// No registries, tags or recipes: enough for tests of the login phase.
pub fn empty() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: builtin: Builtin::default(),
    // rust: dynamic: Dynamic::default(),
    // rust: registries: Vec::new(),
    // rust: tags: UpdateTags {
    // rust: registries: Vec::new(),
    // rust: },
    // rust: features: Vec::new(),
    // rust: commands: None,
    // rust: recipes: Vec::new(),
    // rust: advancements: super::advancements::ServerAdvancements::load(
    // rust: Path::new(""),
    // rust: &horizon_world::loot::PackOverlay::NONE,
    // rust: BTreeMap::new(),
    // rust: HashMap::new(),
    // rust: ),
    // rust: content_identity: None,
}
}
    // rust: pub fn load(
    // rust: resources: &Path,
    // rust: overlay: &horizon_world::loot::PackOverlay,
    // rust: ) -> Result<Self, String> {
    // rust: Self::load_with(resources, overlay, None)
}

    /// `load` with the open world's biomes: when its data packs added or
    /// replaced some, the biome registry is that table's, in its order.
    // rust: pub fn load_with(
    // rust: resources: &Path,
    // rust: overlay: &horizon_world::loot::PackOverlay,
    // rust: biomes: Option<&crate::biome::Biomes>,
    // rust: ) -> Result<Self, String> {
    // rust: Self::load_with_kept(resources, overlay, biomes, None)
}

    /// Reload tags and reloadable data against the registries frozen at open.
    // rust: pub fn reload(
    // rust: resources: &Path,
    // rust: overlay: &horizon_world::loot::PackOverlay,
    // rust: kept: &Self,
    // rust: ) -> Result<Self, String> {
    // rust: Self::load_with_kept(resources, overlay, None, Some(kept))
}

    /// Load reloadable data with frozen synchronized registries; an explicit
    /// biome table supplies the world's already-loaded biome registry.
    // rust: pub fn load_with_kept(
    // rust: resources: &Path,
    // rust: overlay: &horizon_world::loot::PackOverlay,
    // rust: biomes: Option<&crate::biome::Biomes>,
    // rust: kept: Option<&Self>,
    // rust: ) -> Result<Self, String> {
    // rust: Self::load_with_frozen(resources, overlay, biomes, kept, None)
}

    /// First lazy load after world entry: damage definitions are the same
    /// snapshot gameplay uses, even if `/reload` happened before the first hub.
    // rust: pub fn load_with_frozen_damage(
    // rust: resources: &Path,
    // rust: overlay: &horizon_world::loot::PackOverlay,
    // rust: damage: &FrozenDamage,
    // rust: ) -> Result<Self, String> {
    // rust: Self::load_with_frozen(resources, overlay, None, None, Some(damage))
}

    // rust: fn load_with_frozen(
    // rust: resources: &Path,
    // rust: overlay: &horizon_world::loot::PackOverlay,
    // rust: biomes: Option<&crate::biome::Biomes>,
    // rust: kept: Option<&Self>,
    // rust: damage: Option<&FrozenDamage>,
    // rust: ) -> Result<Self, String> {
//         use crate::spans::startup;
        // The recipe book, the recipe sync and the advancements read the
        // recipe folder: held here, they share one read of it.
    // rust: let _recipe_files = startup::time("sync.recipe_folder", || {
    // rust: horizon_world::json_folder::read(&resources.join("data/minecraft/recipe"))
    // rust: });
    // rust: let registries_step = startup::step("sync.registries");
    // rust: let builtin = Builtin::find(resources)
    // rust: .and_then(|p| Builtin::load(&p).ok())
    // rust: .ok_or("registries.json not found next to the resources")?;
    // rust: let root: PathBuf = resources.join("data/minecraft");
    // rust: let mut registries = Vec::new();
    // rust: let mut dynamic = Dynamic {
    // rust: custom_components: horizon_protocol::item::custom::entries().next().is_some(),
    // rust: ..Default::default()
}
    // rust: for key in SYNCHRONIZED {
    // rust: if let Some(kept) = kept.filter(|_| *key != BIOME_REGISTRY || biomes.is_none()) {
    // rust: if let Some((_, entries)) = kept.registries.iter().find(|(name, _)| name == key) {
    // rust: dynamic
    // rust: .registries
    // rust: .insert((*key).into(), kept.dynamic.registries[*key].clone());
    // rust: registries.push(((*key).into(), entries.clone()));
}
    // rust: continue;
}
    // rust: if *key == "minecraft:damage_type"
    // rust: && let Some(damage) = damage
    // rust: {
    // rust: dynamic.registries.insert(
    // rust: (*key).into(),
    // rust: damage
    // rust: .0
    // rust: .names
    // rust: .iter()
    // rust: .map(|name| (name.clone(), None))
    // rust: .collect(),
    // rust: );
    // rust: registries.push(((*key).into(), damage.0.clone()));
    // rust: continue;
}
    // rust: let path = key.trim_start_matches("minecraft:");
    // rust: let mut found = BTreeMap::new();
    // rust: walk(&root.join(path), &mut found);
    // rust: let mut entries: Vec<_> = found
    // rust: .into_iter()
    // rust: .map(|(p, v)| (("minecraft".to_owned(), p), v, false))
    // rust: .collect();
    // rust: let mut damage_entries = None;
    // rust: if *key == "minecraft:damage_type" {
                // Validate the actual resource bytes before publishing any
                // registry data. Small tools can supply just these files,
                // without the gameplay-only exported damage catalog.
    // rust: let mut files = horizon_world::damage_source::resource_files(resources, path)
    // rust: .map_err(|e| e.to_string())?;
    // rust: let packed: HashSet<_> = overlay.kind(path).map(|(id, _)| id).collect();
    // rust: for (id, versions) in overlay.kind(path) {
    // rust: files.insert(
    // rust: id.into(),
    // rust: horizon_world::loot::PackOverlay::top(versions).to_vec(),
    // rust: );
}
    // rust: let mut decoded = Vec::new();
    // rust: for (id, bytes) in files {
    // rust: let definition =
    // rust: horizon_world::damage_source::Definition::from_json(&id, &bytes)
    // rust: .map_err(|e| format!("damage type {id}: {e}"))?;
    // rust: let (ns, p) = id.split_once(':').ok_or("invalid damage identifier")?;
    // rust: decoded.push((
    // rust: (ns.into(), p.into()),
    // rust: definition.to_nbt(),
    // rust: ns != "minecraft" || packed.contains(id.as_str()),
    // rust: ));
}
    // rust: damage_entries = Some(decoded);
    // rust: } else if PACK_REGISTRIES.contains(key) {
    // rust: pack_entries(path, overlay, &mut entries);
}
    // rust: if *key == BIOME_REGISTRY
    // rust: && let Some(table) = biomes.filter(|b| b.has_packs())
    // rust: {
                // A pack's biome goes with its data: no client knows it.
    // rust: let found: HashMap<_, _> = entries
    // rust: .drain(..)
    // rust: .map(|((ns, p), v, _)| (format!("{ns}:{p}"), v))
    // rust: .collect();
    // rust: for name in table.registry_order() {
    // rust: let (ns, p) = name.split_once(':').unwrap_or(("minecraft", name));
    // rust: let pack = table.pack_file(name);
    // rust: let json = pack.or_else(|| found.get(name)).cloned();
    // rust: let json = json.unwrap_or_else(|| Value::Object(Default::default()));
    // rust: entries.push(((ns.to_owned(), p.to_owned()), json, pack.is_some()));
}
}
    // rust: let mut entries = damage_entries.unwrap_or_else(|| {
    // rust: entries
    // rust: .into_iter()
    // rust: .map(|(key, value, packed)| (key, json_to_nbt(&value), packed))
    // rust: .collect()
    // rust: });
    // rust: file_order(&mut entries);
    // rust: let mut e = Entries {
    // rust: names: Vec::new(),
    // rust: data: Vec::new(),
    // rust: from_pack: Vec::new(),
}
    // rust: for ((ns, p), v, from_pack) in entries {
    // rust: e.names.push(format!("{ns}:{p}"));
    // rust: e.data.push(v);
    // rust: e.from_pack.push(from_pack);
}
    // rust: dynamic.registries.insert(
    // rust: (*key).to_owned(),
    // rust: e.names.iter().map(|n| (n.clone(), None)).collect(),
    // rust: );
    // rust: registries.push(((*key).to_owned(), e));
}
        // The world's packs' dialogs joined the registry above
        // (`pack_entries`); their tags join the root's here, the dialogs'
        // (the Quick Actions key and `show_dialog`) and every other
        // registry's a pack has tag files for (a block made climbable).
    // rust: drop(registries_step);
    // rust: let tags_step = startup::step("sync.tags");
    // rust: let mut tags = Self::load_tags(&root, &builtin, &dynamic);
    // rust: Self::merge_pack_tags(&mut tags, &root, overlay, &builtin, &dynamic);
    // rust: Self::merge_damage_tags(&mut tags, resources, overlay, &builtin, &dynamic)?;
    // rust: drop(tags_step);
    // rust: let content_identity = if resources.join(crate::content_identity::MARKER).exists()
    // rust: || horizon_protocol::item::custom::entries().next().is_some()
    // rust: {
    // rust: Some(
    // rust: startup::time("sync.content_identity", || {
    // rust: crate::content_identity::identity(resources)
    // rust: })
    // rust: .map_err(|error| error.to_string())?,
    // rust: )
    // rust: } else {
    // rust: None
}
    // rust: let mut sync = Self {
    // rust: content_identity,
    // rust: builtin,
    // rust: dynamic,
    // rust: registries,
    // rust: tags,
    // rust: features: vec!["minecraft:vanilla".to_owned()],
    // rust: commands: startup::time("sync.commands", || {
    // rust: super::commands::CommandTree::load(resources)
    // rust: }),
    // rust: recipes: Vec::new(),
    // rust: advancements: {
    // rust: let (recipes, groups) = startup::time("sync.network_recipes", || {
    // rust: super::recipes::network_recipes(resources, overlay)
    // rust: });
    // rust: startup::time("sync.advancements", || {
    // rust: super::advancements::ServerAdvancements::load(
    // rust: resources, overlay, recipes, groups,
    // rust: )
    // rust: })
    // rust: },
}
    // rust: sync.recipes = startup::time("sync.update_recipes", || {
    // rust: super::recipes::update_recipes(&sync.advancements.recipes, &sync)
    // rust: });
    // rust: Ok(sync)
}

    /// MinecraftServer.reloadResources: `/reload` keeps the synchronized
    /// registries the server started with (`kept`'s, its
    /// LayeredRegistryAccess) and reads the tags against them
    /// (TagLoader.loadTagsForExistingRegistries), the world's packs' as well
    /// (`overlay`); the rest stays reloaded.
    // rust: pub fn keep_registries(
    // rust: &mut self,
    // rust: resources: &Path,
    // rust: kept: &SyncData,
    // rust: overlay: &horizon_world::loot::PackOverlay,
    // rust: ) {
    // rust: self.dynamic = kept.dynamic.clone();
    // rust: self.registries = kept.registries.clone();
    // rust: let root = resources.join("data/minecraft");
    // rust: self.tags = Self::load_tags(&root, &self.builtin, &self.dynamic);
    // rust: Self::merge_pack_tags(&mut self.tags, &root, overlay, &self.builtin, &self.dynamic);
}

    /// Whether a synchronized registry holds an entry from a world's pack.
pub fn has_pack_entries(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.registries
    // rust: .iter()
    // rust: .any(|(_, e)| e.from_pack.contains(&true))
}

    /// The id of a name in a built-in or synchronized registry.
pub fn id(self: *Self, registry: []const u8, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if registry == "minecraft:data_component_type"
    // rust: && self.dynamic.custom_components
    // rust: && let Some(id) = horizon_protocol::item::custom::id(name)
    // rust: {
    // rust: return Some(id);
}
    // rust: if let Some(ids) = self.builtin.get(registry) {
    // rust: return ids.id(name);
}
    // rust: self.dynamic
    // rust: .registries
    // rust: .get(registry)?
    // rust: .iter()
    // rust: .position(|(n, _)| n == name)
    // rust: .map(|i| i as i32)
}

    /// ClientboundRegistryDataPacket per registry. With `known_pack` the
    /// client rebuilds the entries from its own data, so none is sent, the
    /// dialogs among them (`RegistrySynchronization.packRegistry`): only an
    /// entry a world's pack added or replaced (`from_pack`) carries its data.
    /// The registries for a client, with the data of a dimension type the
    /// world's data packs changed (`levels`) even when it knows the vanilla
    /// pack.
pub fn registry_packets(self: *Self, known_pack: bool, levels: *LevelShapes) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.registries
    // rust: .iter()
    // rust: .map(|(key, e)| RegistryData {
    // rust: registry: key.clone(),
    // rust: entries: e
    // rust: .names
    // rust: .iter()
    // rust: .zip(&e.data)
    // rust: .zip(&e.from_pack)
    // rust: .map(|((name, data), &from_pack)| {
    // rust: let changed = (key == "minecraft:dimension_type")
    // rust: .then(|| changed_dimension_type(name, data, levels))
    // rust: .flatten();
    // rust: RegistryEntry {
    // rust: id: name.clone(),
    // rust: data: match changed {
    // rust: Some(changed) => Some(changed),
    // rust: None if known_pack && !from_pack => None,
    // rust: None => Some(data.clone()),
    // rust: },
}
    // rust: })
    // rust: .collect(),
    // rust: })
    // rust: .collect()
}
    // rust: fn merge_damage_tags(
    // rust: tags: &mut UpdateTags,
    // rust: resources: &Path,
    // rust: overlay: &horizon_world::loot::PackOverlay,
    // rust: builtin: &Builtin,
    // rust: dynamic: &Dynamic,
    // rust: ) -> Result<(), String> {
    // rust: let Some(names) = Self::registry_names(builtin, dynamic, "minecraft:damage_type") else {
    // rust: return Ok(());
}
    // rust: let resolved = horizon_world::damage_source::resource_tags(resources, overlay, |id, _| {
    // rust: names.get(id).copied()
    // rust: })
    // rust: .map_err(|e| e.to_string())?;
    // rust: tags.registries
    // rust: .retain(|r| r.registry != "minecraft:damage_type");
    // rust: tags.registries.push(RegistryTags {
    // rust: registry: "minecraft:damage_type".into(),
    // rust: tags: resolved
    // rust: .into_iter()
    // rust: .map(|(name, ids)| TagEntry { name, ids })
    // rust: .collect(),
    // rust: });
    // rust: Ok(())
}

    /// The tags the server sends (`TagNetworkSerialization.serializeTagsToNetwork`
    /// reads the registries' tags as `TagLoader` loaded them from the whole
    /// pack stack): every synchronized registry the world's packs have tag
    /// files for is merged again over the resource root's, and
    /// `minecraft:dialog` always (its tags name the packs' dialogs too).
    /// Without packs, the root's tags stand.
    // rust: fn merge_pack_tags(
    // rust: tags: &mut UpdateTags,
    // rust: root: &Path,
    // rust: overlay: &horizon_world::loot::PackOverlay,
    // rust: builtin: &Builtin,
    // rust: dynamic: &Dynamic,
    // rust: ) {
    // rust: let mut keys: Vec<&String> = builtin
    // rust: .registries
    // rust: .keys()
    // rust: .chain(dynamic.registries.keys())
    // rust: .collect();
    // rust: keys.sort();
    // rust: keys.dedup();
    // rust: for key in keys {
            // Registries.tagsDirPath: `tags/<path>`, a mod's registry under
            // `tags/<namespace>/<path>`.
    // rust: let kind = match key.split_once(':') {
    // rust: Some(("minecraft", path)) => path.to_owned(),
    // rust: Some((ns, path)) => format!("{ns}/{path}"),
    // rust: None => key.clone(),
}
    // rust: if key != "minecraft:dialog" && overlay.tag_kind(&kind).next().is_none() {
    // rust: continue;
}
    // rust: Self::merge_registry_tags(tags, root, overlay, builtin, dynamic, key, &kind);
}
}
    /// One registry's tags of the pack stack: the resource root's files, then
    /// each world pack's in order (`TagLoader`: a file adds its values, or
    /// replaces the earlier ones with `"replace": true`), nested tags expanded
    /// to the registry's ids.
    // rust: fn merge_registry_tags(
    // rust: tags: &mut UpdateTags,
    // rust: root: &Path,
    // rust: overlay: &horizon_world::loot::PackOverlay,
    // rust: builtin: &Builtin,
    // rust: dynamic: &Dynamic,
    // rust: key: &str,
    // rust: kind: &str,
    // rust: ) {
    // rust: let Some(names) = Self::registry_names(builtin, dynamic, key) else {
    // rust: return;
}
    // rust: let mut files: BTreeMap<String, Vec<Value>> = BTreeMap::new();
    // rust: let mut own = BTreeMap::new();
    // rust: walk(&root.join("tags").join(kind), &mut own);
    // rust: for (name, value) in own {
    // rust: Self::add_tag_values(files.entry(qualified(&name)).or_default(), &value);
}
    // rust: for (id, packs) in overlay.tag_kind(kind) {
    // rust: for bytes in packs {
    // rust: if let Ok(value) = serde_json::from_slice::<Value>(bytes) {
    // rust: Self::add_tag_values(files.entry(id.clone()).or_default(), &value);
}
}
}
    // rust: let mut entries = Vec::new();
    // rust: for name in files.keys() {
    // rust: let mut ids = Vec::new();
    // rust: let mut seen = HashSet::new();
    // rust: Self::expand_pack_tag(&files, name, &names, &mut ids, &mut seen);
    // rust: entries.push(TagEntry {
    // rust: name: name.clone(),
    // rust: ids,
    // rust: });
}
    // rust: tags.registries.retain(|r| r.registry != key);
    // rust: if !entries.is_empty() {
    // rust: tags.registries.push(RegistryTags {
    // rust: registry: key.into(),
    // rust: tags: entries,
    // rust: });
}
}

    /// A tag file's values, after `"replace": true` empties the earlier ones.
pub fn add_tag_values(entries: *mut std.ArrayList(Value), json: *Value) void {
}
    // rust: if json["replace"].as_bool() == Some(true) {
    // rust: entries.clear();
}
    // rust: if let Some(values) = json["values"].as_array() {
    // rust: entries.extend(values.iter().cloned());
}
}

    /// A tag's entries as registry ids, nested tags expanded once.
    // rust: fn expand_pack_tag(
    // rust: files: &BTreeMap<String, Vec<Value>>,
    // rust: tag: &str,
    // rust: names: &HashMap<&str, i32>,
    // rust: out: &mut Vec<i32>,
    // rust: seen: &mut HashSet<String>,
    // rust: ) {
    // rust: if !seen.insert(tag.to_owned()) {
    // rust: return;
}
    // rust: let Some(values) = files.get(tag) else {
    // rust: return;
}
    // rust: for value in values {
    // rust: let id = value
    // rust: .as_str()
    // rust: .or_else(|| value["id"].as_str())
    // rust: .unwrap_or_default();
    // rust: if let Some(reference) = id.strip_prefix('#') {
    // rust: Self::expand_pack_tag(files, &qualified(reference), names, out, seen);
    // rust: } else if let Some(&n) = names.get(qualified(id).as_str())
    // rust: && !out.contains(&n)
    // rust: {
    // rust: out.push(n);
}
}
}

    // rust: fn registry_names<'a>(
    // rust: builtin: &'a Builtin,
    // rust: dynamic: &'a Dynamic,
    // rust: key: &str,
    // rust: ) -> Option<HashMap<&'a str, i32>> {
    // rust: if let Some(ids) = builtin.get(key) {
    // rust: return Some(
    // rust: ids.names
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, n)| (n.as_str(), i as i32))
    // rust: .collect(),
    // rust: );
}
    // rust: dynamic.registries.get(key).map(|v| {
    // rust: v.iter()
    // rust: .enumerate()
    // rust: .map(|(i, (n, _))| (n.as_str(), i as i32))
    // rust: .collect()
    // rust: })
}

    /// TagNetworkSerialization.serializeTagsToNetwork from the tag files.
pub fn load_tags(root: *Path, builtin: *Builtin, dynamic: *Dynamic) U {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let tag_root = root.join("tags");
    // rust: let mut registries = Vec::new();
    // rust: let mut keys: Vec<String> = builtin
    // rust: .registries
    // rust: .keys()
    // rust: .chain(dynamic.registries.keys())
    // rust: .cloned()
    // rust: .collect();
    // rust: keys.sort();
    // rust: for key in keys {
    // rust: let dir = tag_root.join(key.trim_start_matches("minecraft:"));
    // rust: if !dir.is_dir() {
    // rust: continue;
}
    // rust: let mut files = BTreeMap::new();
    // rust: walk(&dir, &mut files);
    // rust: if files.is_empty() {
    // rust: continue;
}
    // rust: let Some(names) = Self::registry_names(builtin, dynamic, &key) else {
    // rust: continue;
}
    // rust: let mut tags = Vec::new();
    // rust: for name in files.keys() {
    // rust: let mut ids = Vec::new();
    // rust: let mut seen = HashSet::new();
    // rust: Self::expand(&files, name, &names, &mut ids, &mut seen);
    // rust: tags.push(TagEntry {
    // rust: name: format!("minecraft:{name}"),
    // rust: ids,
    // rust: });
}
    // rust: registries.push(RegistryTags {
    // rust: registry: key,
    // rust: tags,
    // rust: });
}
    // rust: UpdateTags { registries }
}

    // rust: fn expand(
    // rust: files: &BTreeMap<String, Value>,
    // rust: tag: &str,
    // rust: names: &HashMap<&str, i32>,
    // rust: out: &mut Vec<i32>,
    // rust: seen: &mut HashSet<String>,
    // rust: ) {
    // rust: if !seen.insert(tag.to_owned()) {
    // rust: return;
}
    // rust: let Some(values) = files.get(tag).and_then(|v| v["values"].as_array()) else {
    // rust: return;
}
    // rust: for value in values {
    // rust: let id = value
    // rust: .as_str()
    // rust: .or_else(|| value["id"].as_str())
    // rust: .unwrap_or_default();
    // rust: if let Some(reference) = id.strip_prefix('#') {
    // rust: let reference = reference.trim_start_matches("minecraft:");
    // rust: Self::expand(files, reference, names, out, seen);
    // rust: } else if let Some(&n) = names.get(id)
    // rust: && !out.contains(&n)
    // rust: {
    // rust: out.push(n);
}
}
}
}

/// The vanilla dimension type `name` (its NBT `data`) with the shape the
/// world gives the level of that name, if its data packs changed it.
pub fn changed_dimension_type(name: []const u8, data: *Tag, levels: *LevelShapes) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !matches!(
    // rust: name,
    // rust: "minecraft:overworld" | "minecraft:the_nether" | "minecraft:the_end"
    // rust: ) {
    // rust: return None;
}
    // rust: let shape = levels.get(name);
    // rust: if shape == LevelShapes::VANILLA.get(name) {
    // rust: return None;
}
    // rust: let mut data = data.clone();
    // rust: let Tag::Compound(fields) = &mut data else {
    // rust: return None;
}
    // rust: fields.insert("min_y".into(), Tag::Int(shape.min_y));
    // rust: fields.insert("height".into(), Tag::Int(shape.height));
    // rust: fields.insert("logical_height".into(), Tag::Int(shape.logical_height));
    // rust: fields.insert("has_skylight".into(), Tag::Byte(i8::from(shape.sky_light)));
    // rust: fields.insert("has_ceiling".into(), Tag::Byte(i8::from(shape.has_ceiling)));
    // rust: Some(data)
}

    // rust: mod tests {
//     use super::*;

pub fn datapack_damage_registry_reload_keeps_wire_ids_and_reloads_tags_before_future_join() void {
}
//         use horizon_world::loot::PackOverlay;
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: let files = vec![
    // rust: ("damage_type/demo:heat".into(), vec![br#"{"message_id":"heat","scaling":"never","exhaustion":0.1,"effects":"burning"}"#.to_vec()]),
    // rust: ("damage_type/demo:infinite".into(), vec![br#"{"message_id":"infinite","scaling":"never","exhaustion":1e400}"#.to_vec()]),
    // rust: ("tags/minecraft:damage_type/is_fire".into(), vec![br#"{"values":["demo:heat"]}"#.to_vec()]),
    // rust: ];
    // rust: let open = SyncData::load(&root, &PackOverlay { files: &files }).unwrap();
    // rust: let heat = open.id("minecraft:damage_type", "demo:heat").unwrap();
    // rust: let packet = open.registry_packets(true, &LevelShapes::VANILLA);
    // rust: let packet = packet
    // rust: .iter()
    // rust: .find(|p| p.registry == "minecraft:damage_type")
    // rust: .unwrap();
    // rust: assert!(
    // rust: packet.entries[heat as usize].data.is_some(),
    // rust: "custom definitions are sent even with known vanilla packs"
    // rust: );
    // rust: let infinite = open.id("minecraft:damage_type", "demo:infinite").unwrap();
    // rust: let data = packet.entries[infinite as usize].data.as_ref().unwrap();
    // rust: assert_eq!(
    // rust: data.get("exhaustion"),
    // rust: Some(&Tag::Float(f32::INFINITY.to_bits()))
    // rust: );
    // rust: assert!(data.get("effects").is_none() && data.get("death_message_type").is_none());
    // rust: let changed = vec![
    // rust: (
    // rust: "damage_type/demo:heat".into(),
    // rust: vec![br#"{"invalid":true}"#.to_vec()],
    // rust: ),
    // rust: (
    // rust: "damage_type/demo:unregistered".into(),
    // rust: vec![br#"{"invalid":true}"#.to_vec()],
    // rust: ),
    // rust: (
    // rust: "tags/demo:damage_type/current".into(),
    // rust: vec![
    // rust: br#"{"values":["demo:heat",{"id":"demo:unregistered","required":false}]}"#
    // rust: .to_vec(),
    // rust: ],
    // rust: ),
    // rust: ];
    // rust: let reloaded = SyncData::reload(&root, &PackOverlay { files: &changed }, &open).unwrap();
    // rust: assert_eq!(
    // rust: reloaded.id("minecraft:damage_type", "demo:heat"),
    // rust: Some(heat)
    // rust: );
    // rust: assert!(
    // rust: reloaded
    // rust: .id("minecraft:damage_type", "demo:unregistered")
    // rust: .is_none()
    // rust: );
    // rust: let tags = reloaded
    // rust: .tags
    // rust: .registries
    // rust: .iter()
    // rust: .find(|r| r.registry == "minecraft:damage_type")
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: tags.tags
    // rust: .iter()
    // rust: .find(|t| t.name == "demo:current")
    // rust: .unwrap()
    // rust: .ids,
    // rust: [heat]
    // rust: );
    // rust: assert!(
    // rust: !tags
    // rust: .tags
    // rust: .iter()
    // rust: .find(|t| t.name == "minecraft:is_fire")
    // rust: .unwrap()
    // rust: .ids
    // rust: .contains(&heat)
    // rust: );
        // Another world performs registry loading again and refuses malformed definitions.
    // rust: assert!(SyncData::load(&root, &PackOverlay { files: &changed }).is_err());
    // rust: let fresh = SyncData::load(&root, &PackOverlay::NONE).unwrap();
    // rust: assert!(fresh.id("minecraft:damage_type", "demo:heat").is_none());
}

pub fn world_packs_supply_dialog_entries_and_tags() void {
}
//         use horizon_world::loot::PackOverlay;
    // rust: let vanilla = |p: &str| {
    // rust: (
    // rust: ("minecraft".to_owned(), p.to_owned()),
    // rust: serde_json::json!({ "type": "minecraft:dialog_list" }),
    // rust: false,
    // rust: )
}
    // rust: let mut found = vec![vanilla("quick_actions"), vanilla("server_links")];
    // rust: let files = vec![
    // rust: (
    // rust: "dialog/test:menu".to_owned(),
    // rust: vec![br#"{"type":"minecraft:multi_action","title":"Menu"}"#.to_vec()],
    // rust: ),
    // rust: (
    // rust: "dialog/minecraft:quick_actions".to_owned(),
    // rust: vec![br#"{"type":"minecraft:dialog_list","title":"Quick"}"#.to_vec()],
    // rust: ),
    // rust: (
    // rust: "tags/minecraft:dialog/quick_actions".to_owned(),
    // rust: vec![br##"{"values":["test:menu","#minecraft:more"]}"##.to_vec()],
    // rust: ),
    // rust: (
    // rust: "tags/minecraft:dialog/more".to_owned(),
    // rust: vec![br#"{"values":["minecraft:server_links"]}"#.to_vec()],
    // rust: ),
    // rust: ];
    // rust: let overlay = PackOverlay { files: &files };
    // rust: pack_entries("dialog", &overlay, &mut found);
    // rust: file_order(&mut found);
    // rust: let names: Vec<String> = found
    // rust: .iter()
    // rust: .map(|((ns, p), _, _)| format!("{ns}:{p}"))
    // rust: .collect();
        // Identifier order: by path, then namespace.
    // rust: assert_eq!(
    // rust: names,
    // rust: [
    // rust: "test:menu",
    // rust: "minecraft:quick_actions",
    // rust: "minecraft:server_links"
    // rust: ]
    // rust: );
    // rust: assert_eq!(found[1].1["title"], "Quick", "a pack overrides an entry");
    // rust: let dynamic = Dynamic {
    // rust: registries: HashMap::from([(
    // rust: "minecraft:dialog".to_owned(),
    // rust: names.iter().map(|n| (n.clone(), None)).collect(),
    // rust: )]),
    // rust: ..Default::default()
}
    // rust: let mut tags = UpdateTags {
    // rust: registries: Vec::new(),
}
    // rust: SyncData::merge_pack_tags(
    // rust: &mut tags,
    // rust: Path::new("a-resource-root-without-tags"),
    // rust: &overlay,
    // rust: &Builtin::default(),
    // rust: &dynamic,
    // rust: );
    // rust: let dialog = tags
    // rust: .registries
    // rust: .iter()
    // rust: .find(|r| r.registry == "minecraft:dialog")
    // rust: .expect("the dialog tags are sent");
    // rust: let quick = dialog
    // rust: .tags
    // rust: .iter()
    // rust: .find(|t| t.name == "minecraft:quick_actions")
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: quick.ids,
    // rust: [0, 2],
    // rust: "the pack's dialog, then the nested tag's"
    // rust: );
}

    /// #7843: the server sends its tags as `TagLoader` merged them from the
    /// whole pack stack. A world pack that adds dirt to `climbable` and
    /// replaces `mineable/pickaxe` reaches the block tags sent, over the
    /// resource root's; a nested tag expands; a registry no pack has tag files
    /// for keeps what `load_tags` read.
pub fn world_packs_tags_reach_every_synchronized_registry() void {
}
    // rust: let root = std::env::temp_dir().join(format!("horizon-pack-tags-{}", std::process::id()));
    // rust: let block_tags = root.join("tags/block");
    // rust: std::fs::create_dir_all(block_tags.join("mineable")).unwrap();
    // rust: std::fs::write(
    // rust: block_tags.join("climbable.json"),
    // rust: r#"{"values":["minecraft:ladder"]}"#,
    // rust: )
    // rust: .unwrap();
    // rust: std::fs::write(
    // rust: block_tags.join("mineable/pickaxe.json"),
    // rust: r#"{"values":["minecraft:stone"]}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let names = |list: &[&str]| {
    // rust: horizon_protocol::registry::Ids::from_names(
    // rust: list.iter().map(|s| (*s).to_owned()).collect(),
    // rust: )
}
    // rust: let builtin = Builtin {
    // rust: registries: HashMap::from([
    // rust: (
    // rust: "minecraft:block".to_owned(),
    // rust: names(&["minecraft:stone", "minecraft:dirt", "minecraft:ladder"]),
    // rust: ),
    // rust: ("minecraft:item".to_owned(), names(&["minecraft:stick"])),
    // rust: ]),
}
    // rust: let dynamic = Dynamic::default();
    // rust: let mut tags = SyncData::load_tags(&root, &builtin, &dynamic);
    // rust: let item_tags = RegistryTags {
    // rust: registry: "minecraft:item".into(),
    // rust: tags: vec![TagEntry {
    // rust: name: "minecraft:sticks".into(),
    // rust: ids: vec![0],
    // rust: }],
}
    // rust: tags.registries.push(item_tags.clone());
    // rust: let files = vec![
    // rust: (
    // rust: "tags/minecraft:block/climbable".to_owned(),
    // rust: vec![br##"{"values":["minecraft:dirt","#test:more"]}"##.to_vec()],
    // rust: ),
    // rust: (
    // rust: "tags/test:block/more".to_owned(),
    // rust: vec![br#"{"values":["minecraft:stone"]}"#.to_vec()],
    // rust: ),
    // rust: (
    // rust: "tags/minecraft:block/mineable/pickaxe".to_owned(),
    // rust: vec![br#"{"replace":true,"values":["minecraft:dirt"]}"#.to_vec()],
    // rust: ),
    // rust: ];
    // rust: let overlay = horizon_world::loot::PackOverlay { files: &files };
    // rust: SyncData::merge_pack_tags(&mut tags, &root, &overlay, &builtin, &dynamic);
    // rust: let _ = std::fs::remove_dir_all(&root);
    // rust: let sent = |registry: &str, tag: &str| -> Vec<i32> {
    // rust: tags.registries
    // rust: .iter()
    // rust: .find(|r| r.registry == registry)
    // rust: .and_then(|r| r.tags.iter().find(|t| t.name == tag))
    // rust: .map(|t| t.ids.clone())
    // rust: .unwrap_or_else(|| panic!("{registry} {tag} is sent"))
}
        // The root's ladder, then the pack's dirt and its nested tag's stone.
    // rust: assert_eq!(sent("minecraft:block", "minecraft:climbable"), [2, 1, 0]);
        // `"replace": true` drops the root's stone.
    // rust: assert_eq!(sent("minecraft:block", "minecraft:mineable/pickaxe"), [1]);
    // rust: assert_eq!(sent("minecraft:block", "test:more"), [0]);
        // No pack tags for items: the registry stays as it was read.
    // rust: let items = tags
    // rust: .registries
    // rust: .iter()
    // rust: .find(|r| r.registry == "minecraft:item")
    // rust: .unwrap();
    // rust: assert_eq!(items.tags.len(), 1);
    // rust: assert_eq!(items.tags[0].ids, item_tags.tags[0].ids);
    // rust: assert_eq!(
    // rust: tags.registries
    // rust: .iter()
    // rust: .filter(|r| r.registry == "minecraft:block")
    // rust: .count(),
    // rust: 1,
    // rust: "one entry per registry"
    // rust: );
}

    /// RegistrySynchronization.packRegistry: a client that knows the core
    /// pack gets the vanilla dialogs without data; a pack's dialog has it.
pub fn known_pack_dialogs_are_sent_without_data() void {
}
    // rust: let mut sync = SyncData::empty();
    // rust: sync.registries.push((
    // rust: "minecraft:dialog".to_owned(),
    // rust: Entries {
    // rust: names: vec!["minecraft:quick_actions".into(), "test:menu".into()],
    // rust: data: vec![json_to_nbt(&serde_json::json!({ "type": "minecraft:dialog_list" })); 2],
    // rust: from_pack: vec![false, true],
    // rust: },
    // rust: ));
    // rust: let data = |known_pack| -> Vec<bool> {
    // rust: sync.registry_packets(known_pack, &LevelShapes::VANILLA)[0]
    // rust: .entries
    // rust: .iter()
    // rust: .map(|e| e.data.is_some())
    // rust: .collect()
}
    // rust: assert_eq!(data(true), [false, true]);
    // rust: assert_eq!(data(false), [true, true]);
}

pub fn cached_dialog_nbt_keeps_the_existing_wire_payload() void {
}
    // rust: let data = json_to_nbt(&serde_json::json!({"type":"minecraft:dialog_list"}));
    // rust: let mut sync = SyncData::empty();
    // rust: sync.registries.push((
    // rust: "minecraft:dialog".into(),
    // rust: Entries {
    // rust: names: vec!["minecraft:quick_actions".into()],
    // rust: data: vec![data],
    // rust: from_pack: vec![false],
    // rust: },
    // rust: ));
    // rust: let packets = sync.registry_packets(false, &LevelShapes::VANILLA);
    // rust: let data = packets[0].entries[0].data.as_ref().unwrap();
    // rust: let encoded =
    // rust: horizon_world::nbt::write_network(data, horizon_world::nbt::Limits::default()).unwrap();
        // Compound, string key/type, 21-byte value, compound end.
    // rust: let mut expected = vec![10, 8, 0, 4, b't', b'y', b'p', b'e', 0, 21];
    // rust: expected.extend_from_slice(b"minecraft:dialog_list");
    // rust: expected.push(0);
    // rust: assert_eq!(encoded, expected);
}

pub fn json_becomes_nbt() void {
}
    // rust: let v: Value = serde_json::from_str(r#"{"a":1,"b":[true,2.5],"c":"x"}"#).unwrap();
    // rust: let t = json_to_nbt(&v);
    // rust: assert!(matches!(t.get("a"), Some(Tag::Int(1))));
    // rust: assert!(matches!(t.get("c"), Some(Tag::String(_))));
    // rust: assert!(matches!(t.get("b"), Some(Tag::List(l)) if l.len() == 2));
}

pub fn a_changed_dimension_type_is_sent_with_its_shape() void {
}
    // rust: let vanilla: Value =
    // rust: serde_json::from_str(r#"{"min_y":-64,"height":384,"logical_height":384,"has_skylight":true,"ultrawarm":false}"#)
    // rust: .unwrap();
    // rust: let vanilla = json_to_nbt(&vanilla);
    // rust: let mut levels = LevelShapes::VANILLA;
    // rust: assert_eq!(
    // rust: changed_dimension_type("minecraft:overworld", &vanilla, &levels),
    // rust: None
    // rust: );
    // rust: levels.overworld = crate::chunk::LevelShape::new(-64, 2096, 2096, true, true).unwrap();
    // rust: let sent = changed_dimension_type("minecraft:overworld", &vanilla, &levels).unwrap();
    // rust: assert_eq!(
    // rust: (sent.get("min_y"), sent.get("height")),
    // rust: (Some(&Tag::Int(-64)), Some(&Tag::Int(2096)))
    // rust: );
    // rust: assert_eq!(sent.get("has_ceiling"), Some(&Tag::Byte(1)));
    // rust: assert_eq!(
    // rust: sent.get("ultrawarm"),
    // rust: Some(&Tag::Byte(0)),
    // rust: "the rest of the type is kept"
    // rust: );
    // rust: assert_eq!(
    // rust: changed_dimension_type("minecraft:the_nether", &vanilla, &levels),
    // rust: None
    // rust: );
    // rust: assert_eq!(
    // rust: changed_dimension_type("minecraft:overworld_caves", &vanilla, &levels),
    // rust: None
    // rust: );
}
}

    // rust: mod component_tests {
//     use super::*;
//     use horizon_world::nbt::{Limits, read_network, write_network};

    /// `/give`'s reply: a count, then components. On the wire each element is wrapped
    /// once, and read back (ListTag.addAndUnwrap) it is the number again.
pub fn mixed_translation_arguments_are_wrapped_once() void {
}
    // rust: let json = serde_json::json!({
    // rust: "translate": "commands.give.success.single",
    // rust: "with": [1, {"text": "Raw Iron"}, {"text": "Tester"}],
    // rust: });
    // rust: let tag = component_nbt(&json);
    // rust: let Some(Tag::List(args)) = tag.get("with") else {
    // rust: panic!("no arguments: {tag:?}");
}
    // rust: assert_eq!(args[0], Tag::Int(1));
        // Read back as ListTag.addAndUnwrap does: a wrapper wrapped twice stays a compound.
    // rust: let bytes = write_network(&tag, Limits::default()).unwrap();
    // rust: assert_eq!(read_network(&bytes, Limits::default()).unwrap().0, tag);
}
}
