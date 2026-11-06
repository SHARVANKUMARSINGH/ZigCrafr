//! Transpiled from Horizon Rust crate
//! Module: horizon-mods_content
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! A content mod's `assets/` and `data/` (API 0.2, docs/modpacks.md): the
//! files it adds to the game's resource tree, and the blocks, items, mob
//! effects, entity types and menu types it declares in
//! `data/<id>/horizon/{block,item,mob_effect,entity_type,menu}/`.
//!
//! Content is data, not code: nothing here runs in the sandbox. What a mod
//! may add is fenced instead. Its own namespaces (its id and the ones its
//! manifest lists), plus additions to vanilla tags and to the convention
//! tags (`c`, which NeoForge and Fabric mods share). Paths are plain, files
//! and totals are capped, vanilla ids cannot be redefined, and no two mods
//! share a namespace ([`clash`]).
// use crate::manifest::{Capability, MANIFEST, Manifest};
// use serde::Deserialize;
// use std::{
    // rust: collections::{BTreeMap, BTreeSet},
    // rust: io::Read,
    // rust: path::{Path, PathBuf},
}

/// Content files per mod, bytes per file and bytes per mod.
pub const MAX_FILES: usize = 65_536;
pub const MAX_FILE: u64 = 16 << 20;
pub const MAX_TOTAL: u64 = 512 << 20;

/// Checks a content path: `assets/` or `data/`, then `/`-separated parts of
/// `[a-z0-9_.-]`, none of them `.` or `..` (vanilla's resource-location
/// characters, so the path means the same on every OS).
pub fn check_path(name: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let bad = || format!("{name:?} is not a plain assets/ or data/ path");
    // rust: let mut parts = name.split('/');
    // rust: if !matches!(parts.next(), Some("assets" | "data")) {
    // rust: return Err(bad());
}
    // rust: let mut count = 0;
    // rust: for part in parts {
    // rust: count += 1;
    // rust: let chars_ok = part
    // rust: .bytes()
    // rust: .all(|b| b.is_ascii_lowercase() || b.is_ascii_digit() || b"_.-".contains(&b));
    // rust: if part.is_empty() || part == "." || part == ".." || !chars_ok {
    // rust: return Err(bad());
}
}
    // assets/<namespace>/<file> at least.
    // rust: if count < 2 {
    // rust: return Err(bad());
}
    // rust: Ok(())
}

/// A vanilla identifier, `minecraft:path`.
/// `Identifier.isValidNamespace` and `isValidPath` on an id with both parts
/// given: `[a-z0-9_.-]`, and `/` in the path too.
pub fn namespaced_id(id: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let ok = |b: u8| b.is_ascii_lowercase() || b.is_ascii_digit() || b"_.-".contains(&b);
    // rust: id.split_once(':').is_some_and(|(namespace, path)| {
    // rust: !namespace.is_empty()
    // rust: && !path.is_empty()
    // rust: && namespace.bytes().all(ok)
    // rust: && path.bytes().all(|b| ok(b) || b == b'/')
    // rust: })
}

pub fn vanilla_id(id: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: id.strip_prefix("minecraft:").is_some_and(|path| {
    // rust: !path.is_empty()
    // rust: && path
    // rust: .bytes()
    // rust: .all(|b| b.is_ascii_lowercase() || b.is_ascii_digit() || b"_./-".contains(&b))
    // rust: })
}

/// What a declared block changes from its template; unset keeps the
/// template's value.
pub const BlockProperties = struct {
    /// Destroy time in seconds of hand mining (-1: unbreakable).
    hardness: ?f32,
    explosion_resistance: ?f32,
    /// Light emitted, 0 to 15.
    light: ?u8,
    requires_tool: ?bool,
    friction: ?f32,
    /// A `MapColor` id, 0 to 61.
    map_color: ?u8,
    /// A vanilla block whose sounds this block uses.
    sounds: ?[]const u8,
    /// Which states tick randomly, whatever the template does (`isRandomlyTicking`).
    random_ticks: ?RandomTicks,
    /// How the block is drawn, whatever the template does (`BlockBehaviour.getRenderShape`).
    render_shape: ?RenderShape,
    /// `false`: the block occludes nothing, so its neighbours' faces are drawn and light passes
    /// it (`BlockBehaviour.Properties.noOcclusion`); unset or `true`: as its template.
    occludes: ?bool,
};

/// Vanilla's `RenderShape`, by its constant's name: `MODEL` puts the block model in the chunk
/// mesh, `ENTITYBLOCK_ANIMATED` leaves it out for a block whose parts are drawn every frame
/// (its block entity's drawing), and `INVISIBLE` draws nothing.
pub const RenderShape = enum {
    Model,
    EntityblockAnimated,
    Invisible,
};

    // rust: impl RenderShape {
    /// The constant's name, as the block tables write it.
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: RenderShape::Model => "MODEL",
    // rust: RenderShape::EntityblockAnimated => "ENTITYBLOCK_ANIMATED",
    // rust: RenderShape::Invisible => "INVISIBLE",
}
}
}

/// Which of a block's states get random ticks (`BlockBehaviour.isRandomlyTicking(state)`), so a
/// crop, sapling or soil on a template that doesn't tick still grows. The sections' random tick
/// counts follow it, and `native_random_tick` fires for the states it picks.
pub const RandomTicks = enum {
    /// Every state (`true`), or none (`false`, for a template that ticks).
    All(bool),
    /// The states whose own state property `property` is one of `values`.
    States {,
    property: String,
    values: Vec<String>,
    // rust: },
};

    // rust: impl RandomTicks {
    /// Whether a state ticks, `combo` being its values of the block's own state properties.
pub fn applies(self: *Self, combo: *[([]const u8) void {
}
    // rust: match self {
    // rust: RandomTicks::All(all) => *all,
    // rust: RandomTicks::States { property, values } => combo
    // rust: .iter()
    // rust: .any(|(name, value)| name == property && values.contains(value)),
}
}
}

/// Boxes selected by one property (legacy) or an ordered tuple of properties.
pub const BlockShapes = struct {
    property: []const u8,
    properties: std.ArrayList([]const u8),
    values: BTreeMap<[]const u8,
    default: Option<Vec<[f64,
};

    // rust: impl BlockShapes {
pub fn property_names(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.property.is_empty() {
    // rust: self.properties.iter().map(String::as_str).collect()
    // rust: } else {
    // rust: vec![self.property.as_str()]
}
}

pub fn check(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let names = self.property_names();
    // rust: if (!self.property.is_empty() && !self.properties.is_empty())
    // rust: || names.iter().any(|name| !state_name(name))
    // rust: || names.iter().collect::<BTreeSet<_>>().len() != names.len()
    // rust: || (names.is_empty() && !self.values.is_empty())
    // rust: || (self.values.is_empty() && self.default.is_none())
    // rust: {
    // rust: return Err("shapes needs distinct properties and values, or a default".into());
}
    // rust: for key in self.values.keys() {
    // rust: let values: Vec<_> = key.split(',').collect();
    // rust: if values.len() != names.len() || values.iter().any(|value| !state_name(value)) {
    // rust: return Err(format!("invalid shape key {key:?}: one value per property"));
}
}
    // rust: for boxes in self.values.values().chain(self.default.iter()) {
    // rust: if boxes.len() > 16
    // rust: || boxes.iter().any(|bounds| {
    // rust: bounds.iter().any(|value| !value.is_finite())
    // rust: || (0..3).any(|axis| bounds[axis] > bounds[axis + 3])
    // rust: })
    // rust: {
    // rust: return Err("shape needs at most 16 finite boxes with ordered bounds".into());
}
}
    // rust: Ok(())
}
}

/// A state property a block declares on its own, beside its template's.
/// A block's states become the template's states times these values, so a
/// pipe can have a connection per side without a template that has one.
pub const StateProperty = enum {
    /// `false` and `true`, in vanilla's spelling.
    Boolean,
    /// A list of values, in the order the state space is built in.
    Enum { values: Vec<String> },
};

    // rust: impl StateProperty {
    /// Its values, in the order the state space is built in; a boolean's two
    /// come `false` first, as vanilla orders them.
pub fn values(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: StateProperty::Boolean => vec!["false", "true"],
    // rust: StateProperty::Enum { values } => values.iter().map(String::as_str).collect(),
}
}
}

/// A vanilla state property's name, and a value's: lower case, digits and
/// underscores (`minecraft:oak_log` is `axis`, a repeater is `delay`).
pub fn state_name(s: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !s.is_empty()
    // rust: && s.bytes()
    // rust: .all(|b| b.is_ascii_lowercase() || b.is_ascii_digit() || b == b'_')
}

pub const BlockFile = struct {
    template: []const u8,
    properties: BlockProperties,
    shapes: ?BlockShapes,
    collision_shapes: ?BlockShapes,
    state_properties: BTreeMap<[]const u8,
    default_state: BTreeMap<[]const u8,
    connects_to: ?[]const u8,
    thickness: ?f32,
    wood_type: ?[]const u8,
    wall_block: ?[]const u8,
    item: bool,
    components: BTreeMap<[]const u8,
};
pub fn yes() b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}

/// A block the mod adds: a vanilla template's behaviour, states and shapes
/// under a new id, with `properties` applied. A native mod may build one in
/// code (`native_blocks`): `..Default::default()` leaves the rest as a file
/// leaves it out, except `item`, which a file sets unless told not to.
pub const Block = struct {
    /// `<mod id>:<path>`.
    id: []const u8,
    /// The vanilla block it copies, `minecraft:<path>`.
    template: []const u8,
    properties: BlockProperties,
    shapes: ?BlockShapes,
    collision_shapes: ?BlockShapes,
    /// State properties of its own, which its template does not have.
    state_properties: BTreeMap<[]const u8,
    /// State properties overlaid on the template default.
    default_state: BTreeMap<[]const u8,
    /// Also add a block item with the same id.
    item: bool,
    /// Its item's component patch, as an [`Item`]'s.
    components: BTreeMap<[]const u8,
    /// A connecting block (template `minecraft:chorus_plant`, a `PipeBlock`
    /// without the chorus plant's rules): the block tag, without `#`, whose
    /// blocks it joins besides itself (a cable's machines).
    connects_to: ?[]const u8,
    /// A connecting block's width in pixels (2 to 14): its shapes, the
    /// chorus plant's (10) when unset.
    thickness: ?f32,
    /// A sign's `WoodType` (template a vanilla sign), which names its editor's
    /// background: `<namespace>:<path>` a mod's texture, a bare name vanilla's.
    /// The template's when unset.
    wood_type: ?[]const u8,
    /// The block a standing or ceiling sign's item places on a wall
    /// (`StandingAndWallBlockItem.wallBlock`): one of this mod's blocks, whose
    /// template is the matching wall sign and which has no item. The
    /// template's when unset.
    wall_block: ?[]const u8,
};

pub const CreativeTabFile = struct {
    title: []const u8,
    icon: []const u8,
    items: std.ArrayList([]const u8),
};

/// A creative inventory tab the mod adds (`data/<id>/horizon/creative_tab/`):
/// its title, the item on its button, and its items in order. Items no mod
/// or vanilla registers are left out when the game loads.
pub const CreativeTab = struct {
    /// `<mod id>:<path>`.
    id: []const u8,
    title: []const u8,
    icon: []const u8,
    items: std.ArrayList([]const u8),
};

pub const Rarity = enum {
    Common,
    Uncommon,
    Rare,
    Epic,
};

pub const ItemFile = struct {
    template: []const u8,
    max_stack_size: ?u8,
    rarity: ?Rarity,
    components: BTreeMap<[]const u8,
    crafting_remainder: ?[]const u8,
};

/// An item the mod adds: a vanilla template item's components under a new
/// id, with these changed. A native mod may build one in code
/// (`native_items`).
pub const Item = struct {
    id: []const u8,
    /// The vanilla item it copies, `minecraft:<path>`.
    template: []const u8,
    max_stack_size: ?u8,
    rarity: ?Rarity,
    /// A 26.3 data component patch over the template's: `!minecraft:<type>` removes one.
    components: BTreeMap<[]const u8,
    /// What it leaves in the crafting grid (`Item.Properties.craftRemainder`):
    /// a vanilla item or one of the mod's own.
    crafting_remainder: ?[]const u8,
};

/// `MobEffectCategory`.
pub const EffectCategory = enum {
    Beneficial,
    Harmful,
    Neutral,
};

/// A mob effect the mod adds: what `new MobEffect(category, color)` takes.
pub const MobEffect = struct {
    /// `<mod id>:<path>`.
    id: []const u8,
    category: EffectCategory,
    /// RGB, `0x000000` to `0xFFFFFF`.
    color: u32,
};

/// the vanilla entity types a mod's type may copy: thrown item
/// projectiles (`ThrowableItemProjectile`), then living mobs
/// ([`LIVING_TEMPLATES`]).
    // rust: pub const ENTITY_TEMPLATES: [&str; 4] = [
    // rust: "minecraft:snowball",
    // rust: "minecraft:villager",
    // rust: "minecraft:wandering_trader",
    // rust: "minecraft:zombie",
    // rust: ];

/// the [`ENTITY_TEMPLATES`] that are living mobs: a type copying one is a mob
/// of its template's class (NeoForge's `EntityType.Builder.of(Zombie::new,
/// ...)`), with its own default attributes (`EntityAttributeCreationEvent`).
/// The wandering trader is the neutral one whose behaviour is all goals,
/// which a native mod can replace (`register_goals`); a villager's is its
/// brain.
    // rust: pub const LIVING_TEMPLATES: [&str; 3] = [
    // rust: "minecraft:villager",
    // rust: "minecraft:wandering_trader",
    // rust: "minecraft:zombie",
    // rust: ];

/// an entity type the mod adds: a copy of a vanilla template's. A thrown one
/// is thrown from `item` and drawn as it; a living one is its template's mob
/// with other `attributes`.
pub const EntityType = struct {
    /// `<mod id>:<path>`.
    id: []const u8,
    /// one of [`ENTITY_TEMPLATES`].
    template: []const u8,
    /// a thrown type's: one of the mod's own items, which throws it. A
    /// living type has none.
    item: ?[]const u8,
    /// a thrown type's: what a hit deals to an entity, as `thrown` damage.
    damage: f32,
    /// a living type's default attribute values that differ from its
    /// template's, by attribute id (`minecraft:max_health`): the template's
    /// own attributes only, checked against its row in `entity-types.json`
    /// when the content root builds.
    attributes: BTreeMap<[]const u8,
};

    // rust: impl EntityType {
    /// whether the type copies a living mob ([`LIVING_TEMPLATES`]).
pub fn is_living(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: LIVING_TEMPLATES.contains(&self.template.as_str())
}
}

/// a menu type the mod adds (vanilla's `MenuType`, NeoForge's
/// `IMenuTypeExtension.create`): its container's slot count, the
/// `ContainerData` count its menu syncs, and its take-only slots
/// (`FurnaceResultSlot.mayPlace`). The slots come first in the menu, then the
/// player's 36, and a mod screen (`native_screen`) places them.
pub const MenuType = struct {
    /// `<mod id>:<path>`.
    id: []const u8,
    /// 1 to [`MAX_MENU_SLOTS`].
    slots: u16,
    /// 0 to [`MAX_MENU_SLOTS`].
    data_slots: u16,
    /// slots a player takes from but never puts into, each below `slots`.
    results: std.ArrayList(u16),
};

/// the most container or data slots a mod menu type has, as many as a mod
/// container (`native_block_entity_container`) may.
pub const MAX_MENU_SLOTS: u16 = 256;

pub const Source = enum {
    Dir(PathBuf),
    Zip(PathBuf),
    /// No files: blocks and items a native mod declares in code.
    Code,
};

/// A mod's content: its files and declarations.
pub const Content = struct {
    source: Source,
    /// Every content file (`assets/...`, `data/...`), sorted.
    files: std.ArrayList([]const u8),
    blocks: std.ArrayList(Block),
    items: std.ArrayList(Item),
    effects: std.ArrayList(MobEffect),
    /// Its creative inventory tabs, by id.
    creative_tabs: std.ArrayList(CreativeTab),
    entity_types: std.ArrayList(EntityType),
    menu_types: std.ArrayList(MenuType),
    /// The namespaces it owns: the mod id, then the manifest's `namespaces`.
    namespaces: std.ArrayList([]const u8),
};

/// Reads a mod's content files ([`Content::reader`]).
pub const FileReader = enum {
    Dir(&'a Path),
    Zip(Box<zip::ZipArchive<std::fs::File>>),
};
    // rust: impl FileReader<'_> {
    /// One content file's bytes.
pub fn read(self: *Self, name: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: check_path(name)?;
    // rust: let reader: Box<dyn Read + '_> = match self {
    // rust: Self::Dir(root) => {
    // rust: Box::new(std::fs::File::open(root.join(name)).map_err(|e| format!("{name}: {e}"))?)
}
    // rust: Self::Zip(zip) => Box::new(zip.by_name(name).map_err(|e| format!("{name}: {e}"))?),
}
    // rust: let mut out = Vec::new();
    // rust: reader
    // rust: .take(MAX_FILE + 1)
    // rust: .read_to_end(&mut out)
    // rust: .map_err(|e| format!("{name}: {e}"))?;
    // rust: if out.len() as u64 > MAX_FILE {
    // rust: return Err(format!("{name} is over {} MiB", MAX_FILE >> 20));
}
    // rust: Ok(out)
}
}

/// Why two content mods cannot be on together: a namespace both own (one's
/// id or listed namespace is the other's), which would mix their files.
/// `a` and `b` are (mod id, owned namespaces).
pub fn clash(a: ([]const u8) void {
}
    // rust: let shared = a.1.iter().find(|ns| b.1.contains(ns))?;
    // rust: Some(format!(
    // rust: "mods {} and {} both use the namespace {shared}; turn one of them off",
    // rust: a.0, b.0
    // rust: ))
}

    // rust: impl Content {
    /// The content of the mod at `path` (a `.hmod` or a mod folder).
pub fn read(path: *Path, manifest: *Manifest) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::read_declaring(path, manifest, &[])
}
    /// [`Content::read`] for a mod whose native code also declares items (`native_items`):
    /// a file's `crafting_remainder` may name one of those `declared` ids, which are not in the
    /// files.
    // rust: pub fn read_declaring(
    // rust: path: &Path,
    // rust: manifest: &Manifest,
    // rust: declared: &[String],
    // rust: ) -> Result<Content, String> {
    // rust: let (source, sized) = if path.is_dir() {
    // rust: let mut out = Vec::new();
    // rust: for top in ["assets", "data"] {
    // rust: walk(path, &path.join(top), &mut out)?;
}
    // rust: (Source::Dir(path.to_owned()), out)
    // rust: } else {
    // rust: let mut zip = open_zip(path)?;
    // rust: let mut out = Vec::new();
    // rust: for i in 0..zip.len() {
    // rust: let entry = zip.by_index_raw(i).map_err(|e| e.to_string())?;
    // rust: let name = entry.name().map_err(|e| e.to_string())?.into_owned();
    // rust: if (name.starts_with("assets/") || name.starts_with("data/")) && !entry.is_dir() {
    // rust: out.push((name.to_owned(), entry.size()));
}
}
    // rust: (Source::Zip(path.to_owned()), out)
}
    // rust: let mut files = Vec::with_capacity(sized.len());
    // rust: let mut total = 0u64;
    // rust: for (name, size) in sized {
    // rust: check_path(&name)?;
    // rust: if size > MAX_FILE {
    // rust: return Err(format!("{name} is over {} MiB", MAX_FILE >> 20));
}
    // rust: total += size;
    // rust: files.push(name);
}
    // rust: if files.len() > MAX_FILES {
    // rust: return Err(format!("more than {MAX_FILES} content files"));
}
    // rust: if total > MAX_TOTAL {
    // rust: return Err(format!("content is over {} MiB", MAX_TOTAL >> 20));
}
    // rust: files.sort();
    // rust: files.dedup();
    // rust: let mut content = Content {
    // rust: source,
    // rust: files,
    // rust: blocks: Vec::new(),
    // rust: items: Vec::new(),
    // rust: effects: Vec::new(),
    // rust: creative_tabs: Vec::new(),
    // rust: entity_types: Vec::new(),
    // rust: menu_types: Vec::new(),
    // rust: namespaces: manifest.owned_namespaces().map(str::to_owned).collect(),
}
    // rust: content.check(manifest, declared)?;
    // rust: Ok(content)
}

    /// Content with no files, for the blocks and items native mods declare
    /// in code in `namespace` ([`Content::declare`]).
pub fn declared(namespace: []const u8) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Content {
    // rust: source: Source::Code,
    // rust: files: Vec::new(),
    // rust: blocks: Vec::new(),
    // rust: items: Vec::new(),
    // rust: effects: Vec::new(),
    // rust: creative_tabs: Vec::new(),
    // rust: entity_types: Vec::new(),
    // rust: menu_types: Vec::new(),
    // rust: namespaces: vec![namespace.to_owned()],
}
}

    /// Adds blocks and items a native mod declares in code (`native_blocks`,
    /// `native_items`), checked as declaration files are: ids in this mod's
    /// own namespace (its id, as `data/<id>/horizon/` is) and declared once
    /// with what it already has, a vanilla template, a crafting remainder
    /// that is vanilla or this mod's. All or nothing: on an error nothing is
    /// added.
pub fn declare(self: *Self, blocks: *[Block], items: *[Item]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let own = self
    // rust: .namespaces
    // rust: .first()
    // rust: .map(String::as_str)
    // rust: .unwrap_or_default();
    // rust: let mut ids: BTreeSet<&str> = self
    // rust: .blocks
    // rust: .iter()
    // rust: .map(|b| b.id.as_str())
    // rust: .chain(self.items.iter().map(|i| i.id.as_str()))
    // rust: .collect();
    // rust: let mut item_ids: BTreeSet<&str> = self
    // rust: .blocks
    // rust: .iter()
    // rust: .filter(|b| b.item)
    // rust: .map(|b| b.id.as_str())
    // rust: .chain(self.items.iter().map(|i| i.id.as_str()))
    // rust: .collect();
    // rust: let in_own =
    // rust: |id: &str| namespaced_id(id) && id.split_once(':').is_some_and(|(ns, _)| ns == own);
    // rust: for block in blocks {
    // rust: let id = block.id.as_str();
    // rust: if !in_own(id) {
    // rust: return Err(format!("block {id:?} is not an id in {own}:"));
}
    // rust: check_block(block).map_err(|e| format!("block {id}: {e}"))?;
    // rust: if !ids.insert(id) {
    // rust: return Err(format!("block {id} is declared twice"));
}
    // rust: if block.item {
    // rust: item_ids.insert(id);
}
}
    // rust: let all: Vec<&Block> = self.blocks.iter().chain(blocks).collect();
    // rust: check_sign_walls(&all)?;
    // rust: for item in items {
    // rust: let id = item.id.as_str();
    // rust: if !in_own(id) {
    // rust: return Err(format!("item {id:?} is not an id in {own}:"));
}
    // rust: check_item(item).map_err(|e| format!("item {id}: {e}"))?;
    // rust: if !item_ids.insert(id) {
    // rust: return Err(format!(
    // rust: "item {id} is declared twice, or is also a block's item"
    // rust: ));
}
}
    // rust: for item in items {
    // rust: if let Some(rest) = &item.crafting_remainder
    // rust: && (rest == "minecraft:air"
    // rust: || !vanilla_id(rest) && !item_ids.contains(rest.as_str()))
    // rust: {
    // rust: return Err(format!(
    // rust: "item {}: crafting_remainder {rest:?} is not a vanilla item (minecraft:...) or one of this mod's",
    // rust: item.id
    // rust: ));
}
}
    // rust: self.blocks.extend_from_slice(blocks);
    // rust: self.items.extend_from_slice(items);
    // rust: Ok(())
}

    /// Where the files are read from: the mod's folder or its `.hmod`.
pub fn source(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match &self.source {
    // rust: Source::Dir(path) | Source::Zip(path) => path,
    // rust: Source::Code => Path::new(""),
}
}

    /// No files: a mod with code only.
pub fn is_empty(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.files.is_empty()
}

    /// One content file's bytes.
pub fn file(self: *Self, name: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.reader()?.read(name)
}

    /// A reader of its content files. A packaged mod's archive is opened
    /// once for all of them (opening it reads its whole index).
pub fn reader(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: reader_of(&self.source)
}

    /// Where content may go, and the declarations.
pub fn check(self: *Self, manifest: *Manifest, declared: *[[]const u8]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let id = manifest.id.as_str();
    // rust: if !self.files.is_empty() && !manifest.capabilities.contains(&Capability::Registries) {
    // rust: return Err(format!(
    // rust: "has assets/ or data/ but not capability registries in {MANIFEST}"
    // rust: ));
}
    // rust: let mut blocks = Vec::new();
    // rust: let mut items = Vec::new();
    // rust: let mut effects = Vec::new();
    // rust: let mut tabs = Vec::new();
    // rust: let mut types = Vec::new();
    // rust: let mut menus = Vec::new();
    // rust: for name in &self.files {
    // rust: let mut parts = name.splitn(3, '/');
    // rust: let (top, namespace, rest) = (
    // rust: parts.next().unwrap_or(""),
    // rust: parts.next().unwrap_or(""),
    // rust: parts.next().unwrap_or(""),
    // rust: );
    // rust: let own = namespace == id;
    // rust: let owned = own || manifest.namespaces.iter().any(|n| n == namespace);
            // Vanilla's own files stay vanilla's; a mod may only add to its
            // tags and atlases, and to the convention tags mods share.
    // rust: let shared = matches!(namespace, "minecraft" | "c");
    // rust: let atlas = top == "assets" && namespace == "minecraft" && rest.starts_with("atlases/");
    // rust: let allowed = owned || (top == "data" && shared && rest.starts_with("tags/")) || atlas;
    // rust: if !allowed {
    // rust: return Err(format!(
    // rust: "{name}: a mod adds files in its own namespaces ({top}/{id}/ and those listed in namespaces), to vanilla and convention (c) tags, or to vanilla's atlases"
    // rust: ));
}
    // rust: if !own && top == "data" && rest.starts_with("horizon/") {
    // rust: return Err(format!(
    // rust: "{name}: blocks, items, mob effects, entity types and menu types are declared in data/{id}/horizon/"
    // rust: ));
}
    // rust: let Some(decl) = (own && top == "data")
    // rust: .then(|| rest.strip_prefix("horizon/"))
    // rust: .flatten()
    // rust: else {
    // rust: continue;
}
    // rust: let parse = |kind: &str| -> Option<String> {
    // rust: let path = decl
    // rust: .strip_prefix(kind)?
    // rust: .strip_prefix('/')?
    // rust: .strip_suffix(".json")?;
    // rust: Some(format!("{id}:{path}"))
}
    // rust: if let Some(block) = parse("block") {
    // rust: blocks.push((block, name.clone()));
    // rust: } else if let Some(item) = parse("item") {
    // rust: items.push((item, name.clone()));
    // rust: } else if let Some(effect) = parse("mob_effect") {
    // rust: effects.push((effect, name.clone()));
    // rust: } else if let Some(tab) = parse("creative_tab") {
    // rust: tabs.push((tab, name.clone()));
    // rust: } else if let Some(kind) = parse("entity_type") {
    // rust: types.push((kind, name.clone()));
    // rust: } else if let Some(menu) = parse("menu") {
    // rust: menus.push((menu, name.clone()));
    // rust: } else {
    // rust: return Err(format!(
    // rust: "{name}: data/{id}/horizon/ holds block/, item/, mob_effect/, creative_tab/, entity_type/ and menu/*.json only"
    // rust: ));
}
}
        // One reader for every declaration: opening a packaged mod reads its
        // whole index, so a reader per file made loading a big mod quadratic.
    // rust: let source = self.source.clone();
    // rust: let mut reader = reader_of(&source)?;
    // rust: let mut ids = BTreeSet::new();
    // rust: for (block, name) in blocks {
    // rust: let file: BlockFile =
    // rust: serde_json::from_slice(&reader.read(&name)?).map_err(|e| format!("{name}: {e}"))?;
    // rust: if file
    // rust: .connects_to
    // rust: .as_ref()
    // rust: .is_some_and(|t| !t.starts_with('#'))
    // rust: {
    // rust: return Err(format!(
    // rust: "{name}: connects_to is a block tag, #namespace:path"
    // rust: ));
}
    // rust: let block = Block {
    // rust: id: block,
    // rust: template: file.template,
    // rust: properties: file.properties,
    // rust: shapes: file.shapes,
    // rust: collision_shapes: file.collision_shapes,
    // rust: state_properties: file.state_properties,
    // rust: default_state: file.default_state,
    // rust: item: file.item,
    // rust: components: file.components,
    // rust: connects_to: file
    // rust: .connects_to
    // rust: .map(|t| t.trim_start_matches('#').to_owned()),
    // rust: thickness: file.thickness,
    // rust: wood_type: file.wood_type,
    // rust: wall_block: file.wall_block,
}
    // rust: check_block(&block).map_err(|e| format!("{name}: {e}"))?;
    // rust: if block.item {
    // rust: ids.insert(block.id.clone());
}
    // rust: self.blocks.push(block);
}
        // After every block, so a wall form may be declared in a later file.
    // rust: check_sign_walls(&self.blocks.iter().collect::<Vec<_>>())?;
    // rust: let mut remainders = Vec::new();
    // rust: for (item, name) in items {
    // rust: let file: ItemFile =
    // rust: serde_json::from_slice(&reader.read(&name)?).map_err(|e| format!("{name}: {e}"))?;
    // rust: let item = Item {
    // rust: id: item,
    // rust: template: file.template,
    // rust: max_stack_size: file.max_stack_size,
    // rust: rarity: file.rarity,
    // rust: components: file.components,
    // rust: crafting_remainder: file.crafting_remainder,
}
    // rust: check_item(&item).map_err(|e| format!("{name}: {e}"))?;
    // rust: if !ids.insert(item.id.clone()) {
    // rust: return Err(format!("{name}: {} is also a block's item", item.id));
}
    // rust: if let Some(rest) = &item.crafting_remainder {
    // rust: remainders.push((name, rest.clone()));
}
    // rust: self.items.push(item);
}
    // rust: for (effect, name) in effects {
    // rust: let file: MobEffect =
    // rust: serde_json::from_slice(&reader.read(&name)?).map_err(|e| format!("{name}: {e}"))?;
    // rust: if file.color > 0xFF_FFFF {
    // rust: return Err(format!("{name}: color is RGB, 0 to 16777215 (0xFFFFFF)"));
}
    // rust: self.effects.push(MobEffect { id: effect, ..file });
}
        // After every item, so a remainder may be declared in a later file.
    // rust: for (name, rest) in remainders {
    // rust: if rest == "minecraft:air" {
    // rust: return Err(format!(
    // rust: "{name}: crafting_remainder {rest:?} is no remainder (leave it out)"
    // rust: ));
}
    // rust: if !vanilla_id(&rest) && !ids.contains(&rest) && !declared.contains(&rest) {
    // rust: return Err(format!(
    // rust: "{name}: crafting_remainder {rest:?} is not a vanilla item (minecraft:...) or one of this mod's"
    // rust: ));
}
}
    // rust: for (tab, name) in tabs {
    // rust: let file: CreativeTabFile =
    // rust: serde_json::from_slice(&reader.read(&name)?).map_err(|e| format!("{name}: {e}"))?;
    // rust: let id_like = |s: &str| {
    // rust: s.split_once(':')
    // rust: .is_some_and(|(n, p)| !n.is_empty() && !p.is_empty())
}
    // rust: if !id_like(&file.icon) || !file.items.iter().all(|i| id_like(i)) {
    // rust: return Err(format!(
    // rust: "{name}: icon and items are item ids (namespace:path)"
    // rust: ));
}
    // rust: self.creative_tabs.push(CreativeTab {
    // rust: id: tab,
    // rust: title: file.title,
    // rust: icon: file.icon,
    // rust: items: file.items,
    // rust: });
}
    // rust: for (kind, name) in types {
    // rust: let file: EntityType =
    // rust: serde_json::from_slice(&reader.read(&name)?).map_err(|e| format!("{name}: {e}"))?;
    // rust: if !ENTITY_TEMPLATES.contains(&file.template.as_str()) {
    // rust: return Err(format!(
    // rust: "{name}: template {:?} is not one of {ENTITY_TEMPLATES:?}",
    // rust: file.template
    // rust: ));
}
    // rust: if file.is_living() {
                // a mob is spawned, not thrown: nothing throws it, and its
                // attack is its `minecraft:attack_damage`.
    // rust: if file.item.is_some() || file.damage != 0.0 {
    // rust: return Err(format!(
    // rust: "{name}: a living type has no item or damage (its template is {})",
    // rust: file.template
    // rust: ));
}
    // rust: for (attribute, value) in &file.attributes {
    // rust: let id_like = attribute
    // rust: .split_once(':')
    // rust: .is_some_and(|(n, p)| !n.is_empty() && !p.is_empty());
    // rust: if !id_like {
    // rust: return Err(format!(
    // rust: "{name}: attribute {attribute:?} is an attribute id (namespace:path)"
    // rust: ));
}
    // rust: if !value.is_finite() {
    // rust: return Err(format!("{name}: attribute {attribute} is a finite number"));
}
}
    // rust: self.entity_types.push(EntityType { id: kind, ..file });
    // rust: continue;
}
    // rust: if !file.attributes.is_empty() {
    // rust: return Err(format!(
    // rust: "{name}: only a living type has attributes (its template is {})",
    // rust: file.template
    // rust: ));
}
    // rust: let Some(item) = &file.item else {
    // rust: return Err(format!(
    // rust: "{name}: a thrown type names the item that throws it"
    // rust: ));
}
            // its own item, so no vanilla item loses its use to it.
    // rust: if !ids.contains(item) {
    // rust: return Err(format!(
    // rust: "{name}: item {item:?} is not one of this mod's items"
    // rust: ));
}
    // rust: if self
    // rust: .entity_types
    // rust: .iter()
    // rust: .any(|t| t.item.as_ref() == Some(item))
    // rust: {
    // rust: return Err(format!(
    // rust: "{name}: item {item:?} already throws another entity type"
    // rust: ));
}
    // rust: if !(file.damage.is_finite() && file.damage >= 0.0) {
    // rust: return Err(format!("{name}: damage is 0 or more"));
}
    // rust: self.entity_types.push(EntityType { id: kind, ..file });
}
    // rust: for (menu, name) in menus {
    // rust: let file: MenuType =
    // rust: serde_json::from_slice(&reader.read(&name)?).map_err(|e| format!("{name}: {e}"))?;
    // rust: if !(1..=MAX_MENU_SLOTS).contains(&file.slots) || file.data_slots > MAX_MENU_SLOTS {
    // rust: return Err(format!(
    // rust: "{name}: slots is 1 to {MAX_MENU_SLOTS}, data_slots 0 to {MAX_MENU_SLOTS}"
    // rust: ));
}
    // rust: let mut seen = BTreeSet::new();
    // rust: for &r in &file.results {
    // rust: if r >= file.slots {
    // rust: return Err(format!(
    // rust: "{name}: result {r} is past the last slot, {}",
    // rust: file.slots - 1
    // rust: ));
}
    // rust: if !seen.insert(r) {
    // rust: return Err(format!("{name}: result {r} is listed twice"));
}
}
    // rust: self.menu_types.push(MenuType { id: menu, ..file });
}
    // rust: Ok(())
}
}

/// Namespaced component types, removals as `{}`, and none of `fields`,
/// which the file sets with its own keys.
    // rust: fn check_components(
    // rust: components: &BTreeMap<String, serde_json::Value>,
    // rust: fields: &[&str],
    // rust: ) -> Result<(), String> {
    // rust: for (key, value) in components {
    // rust: let (removed, kind) = match key.strip_prefix('!') {
    // rust: Some(kind) => (true, kind),
    // rust: None => (false, key.as_str()),
}
    // rust: if !namespaced_id(kind) {
    // rust: return Err(format!("component {key:?} must be namespaced and valid"));
}
    // rust: if let Some(own) = kind
    // rust: .strip_prefix("minecraft:")
    // rust: .filter(|k| fields.contains(k))
    // rust: {
    // rust: return Err(format!("component {key:?}: set {own} instead"));
}
    // rust: if removed && !value.as_object().is_some_and(|o| o.is_empty()) {
    // rust: return Err(format!("component {key:?}: a removal's value is {{}}"));
}
}
    // rust: Ok(())
}

/// An item's fields, as a file or code gives them.
pub fn check_item(item: *Item) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !vanilla_id(&item.template) {
    // rust: return Err(format!(
    // rust: "template {:?} is not a vanilla item (minecraft:...)",
    // rust: item.template
    // rust: ));
}
    // rust: if item.max_stack_size.is_some_and(|n| !(1..=99).contains(&n)) {
    // rust: return Err("max_stack_size is 1 to 99".into());
}
    // rust: check_components(&item.components, &["max_stack_size", "rarity"])
}

/// A block's fields, as a file or code gives them (`connects_to` without
/// its `#`).
pub fn check_block(file: *Block) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !vanilla_id(&file.template) {
    // rust: return Err(format!(
    // rust: "template {:?} is not a vanilla block (minecraft:...)",
    // rust: file.template
    // rust: ));
}
    // rust: for shapes in file.shapes.iter().chain(file.collision_shapes.iter()) {
    // rust: shapes.check()?;
}
    // rust: for (name, property) in &file.state_properties {
    // rust: if !state_name(name) {
    // rust: return Err(format!(
    // rust: "state property {name:?} is lower case letters, digits and underscores"
    // rust: ));
}
    // rust: let values = property.values();
    // rust: if values.is_empty() {
    // rust: return Err(format!("state property {name:?} needs a value"));
}
    // rust: let mut seen = BTreeSet::new();
    // rust: for value in values {
    // rust: if !state_name(value) {
    // rust: return Err(format!(
    // rust: "state property {name:?}: value {value:?} is lower case letters, digits and underscores"
    // rust: ));
}
    // rust: if !seen.insert(value) {
    // rust: return Err(format!("state property {name:?}: value {value:?} repeats"));
}
}
}
    // rust: for key in file.default_state.keys() {
    // rust: if !state_name(key) {
    // rust: return Err(format!(
    // rust: "default_state key {key:?} is lower case letters, digits and underscores"
    // rust: ));
}
}
    // rust: let p = &file.properties;
    // rust: if let Some(RandomTicks::States { property, values }) = &p.random_ticks {
    // rust: let declared = file
    // rust: .state_properties
    // rust: .get(property)
    // rust: .map(StateProperty::values);
    // rust: if declared.is_none_or(|all| {
    // rust: values.is_empty() || values.iter().any(|v| !all.contains(&v.as_str()))
    // rust: }) {
    // rust: return Err(format!(
    // rust: "random_ticks needs values of the block's own state property {property:?} (state_properties)"
    // rust: ));
}
}
    // rust: let finite = |v: Option<f32>| v.is_none_or(f32::is_finite);
    // rust: if !finite(p.hardness) || !finite(p.explosion_resistance) || !finite(p.friction) {
    // rust: return Err("hardness, explosion_resistance and friction are numbers".into());
}
    // rust: if p.hardness.is_some_and(|h| h < 0.0 && h != -1.0) {
    // rust: return Err("hardness is 0 or more, or -1 (unbreakable)".into());
}
    // rust: if p.explosion_resistance.is_some_and(|r| r < 0.0) {
    // rust: return Err("explosion_resistance is 0 or more".into());
}
    // rust: if p.friction.is_some_and(|f| !(0.0..=2.0).contains(&f)) {
    // rust: return Err("friction is 0 to 2".into());
}
    // rust: if p.light.is_some_and(|l| l > 15) {
    // rust: return Err("light is 0 to 15".into());
}
    // rust: if p.map_color.is_some_and(|c| c > 61) {
    // rust: return Err("map_color is a MapColor id, 0 to 61".into());
}
    // rust: if p.sounds.as_deref().is_some_and(|s| !vanilla_id(s)) {
    // rust: return Err("sounds names a vanilla block (minecraft:...)".into());
}
    // rust: if !file.item && !file.components.is_empty() {
    // rust: return Err("item is false, so the block has no item to take components".into());
}
    // rust: check_components(&file.components, &[])?;
    // A block file has no `max_stack_size` / `rarity` keys, so those two take the same checks here.
    // rust: if let Some(n) = file.components.get("minecraft:max_stack_size")
    // rust: && !n.as_u64().is_some_and(|n| (1..=99).contains(&n))
    // rust: {
    // rust: return Err("component \"minecraft:max_stack_size\" is an integer 1 to 99".into());
}
    // rust: if let Some(r) = file.components.get("minecraft:rarity")
    // rust: && serde_json::from_value::<Rarity>(r.clone()).is_err()
    // rust: {
    // rust: return Err("component \"minecraft:rarity\" is common, uncommon, rare or epic".into());
}
    // rust: if let Some(tag) = &file.connects_to {
    // rust: if file.template != "minecraft:chorus_plant" {
    // rust: return Err("connects_to needs template minecraft:chorus_plant (a PipeBlock)".into());
}
    // rust: let id = tag.as_str();
    // rust: let valid = |s: &str| {
    // rust: !s.is_empty()
    // rust: && s.chars()
    // rust: .all(|c| c.is_ascii_lowercase() || c.is_ascii_digit() || "_-./".contains(c))
}
    // rust: if !id
    // rust: .split_once(':')
    // rust: .is_some_and(|(ns, path)| valid(ns) && valid(path))
    // rust: {
    // rust: return Err("connects_to is a block tag, #namespace:path".into());
}
}
    // rust: match file.thickness {
    // rust: Some(_) if file.connects_to.is_none() => {
    // rust: return Err("thickness is a connecting block's (connects_to)".into());
}
    // rust: Some(t) if !(2.0..=14.0).contains(&t) => return Err("thickness is 2 to 14 pixels".into()),
    // rust: Some(_) if file.shapes.is_some() => {
    // rust: return Err("thickness sets the shapes, so a block has one or the other".into());
}
    // rust: _ => {}
}
    // Every vanilla `SignBlock`'s id ends in `_sign`, and no other block's does.
    // rust: let sign = file.template.ends_with("_sign");
    // rust: if let Some(wood) = &file.wood_type {
    // rust: if !sign {
    // rust: return Err("wood_type needs a vanilla sign template".into());
}
    // rust: let (namespace, path) = wood.split_once(':').unwrap_or(("minecraft", wood));
    // rust: if !namespaced_id(&format!("{namespace}:{path}"))
    // rust: || check_path(&format!("assets/{namespace}/{path}")).is_err()
    // rust: {
    // rust: return Err("wood_type is a name, or namespace:path, in lower case".into());
}
}
    // rust: if let Some(wall) = &file.wall_block {
    // rust: if !sign || file.template.contains("_wall_") {
    // rust: return Err("wall_block needs a standing or ceiling sign template".into());
}
    // rust: if !file.item {
    // rust: return Err("wall_block is where the item places the block, and item is false".into());
}
    // rust: if !namespaced_id(wall) {
    // rust: return Err("wall_block is a block id, namespace:path".into());
}
}
    // rust: Ok(())
}

/// A sign's `wall_block` is one of the mod's own blocks: the wall form of its
/// kind, with no item of its own and no other sign. Checked here, a pair that
/// doesn't fit leaves out its mod alone.
pub fn check_sign_walls(blocks: *[*Block]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut paired = BTreeMap::new();
    // rust: for sign in blocks {
    // rust: let Some(wall) = &sign.wall_block else {
    // rust: continue;
}
    // rust: let id = &sign.id;
    // rust: let form = if sign.template.ends_with("_hanging_sign") {
    // rust: "_wall_hanging_sign"
    // rust: } else {
    // rust: "_wall_sign"
}
    // rust: let Some(block) = blocks.iter().find(|b| b.id == *wall) else {
    // rust: return Err(format!(
    // rust: "{id}: wall_block {wall} is not one of this mod's blocks"
    // rust: ));
}
    // rust: if !block.template.ends_with(form) {
    // rust: return Err(format!(
    // rust: "{id}: wall_block {wall} needs a template ending in {form}"
    // rust: ));
}
    // rust: if block.item {
    // rust: return Err(format!(
    // rust: "{id}: wall_block {wall} has this sign's item, so its own \"item\" is false"
    // rust: ));
}
    // rust: if let Some(other) = paired.insert(wall, id) {
    // rust: return Err(format!(
    // rust: "{id}: wall_block {wall} is already paired with {other}"
    // rust: ));
}
}
    // rust: Ok(())
}

pub fn reader_of(source: *Source) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(match source {
    // rust: Source::Dir(root) => FileReader::Dir(root),
    // rust: Source::Zip(path) => FileReader::Zip(Box::new(open_zip(path)?)),
    // rust: Source::Code => FileReader::Dir(Path::new("")),
    // rust: })
}

pub fn open_zip(path: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let file = std::fs::File::open(path).map_err(|e| e.to_string())?;
    // rust: zip::ZipArchive::new(file).map_err(|e| e.to_string())
}

/// Files under `dir`, relative to `root` with `/` separators. Symbolic links
/// are not followed: a mod folder holds its own files.
pub fn walk(root: *Path, dir: *Path, out: *mut Vec<([]const u8) void {
}
    // rust: let Ok(read) = std::fs::read_dir(dir) else {
    // rust: return Ok(());
}
    // rust: for entry in read.flatten() {
    // rust: let path = entry.path();
    // rust: let meta = std::fs::symlink_metadata(&path).map_err(|e| e.to_string())?;
    // rust: if meta.is_dir() {
    // rust: walk(root, &path, out)?;
    // rust: } else if meta.is_file() {
    // rust: let rel = path.strip_prefix(root).map_err(|e| e.to_string())?;
    // rust: let parts: Option<Vec<&str>> = rel.iter().map(|p| p.to_str()).collect();
    // rust: let name = parts.ok_or_else(|| format!("{} is not UTF-8", rel.display()))?;
    // rust: out.push((name.join("/"), meta.len()));
}
    // rust: if out.len() > MAX_FILES {
    // rust: return Err(format!("more than {MAX_FILES} content files"));
}
}
    // rust: Ok(())
}

    // rust: mod tests {
//     use super::*;
//     use crate::manifest::Package;

    // rust: const MANIFEST_TEXT: &str = r#"
    // rust: id = "ruby"
    // rust: name = "Ruby"
    // rust: version = "0.1.0"
    // rust: api = "0.2"
    // rust: side = "both"
    // rust: capabilities = ["registries"]
    // rust: "#;
    // rust: const BLOCK: &[u8] = br#"{"template": "minecraft:iron_block",
    // rust: "properties": {"hardness": 4.0, "light": 3, "sounds": "minecraft:amethyst_block"}}"#;
pub const ITEM: []const u8 = br#"{"template": "minecraft:diamond", "rarity": "uncommon"}"#;

pub fn scratch(name: []const u8) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let dir =
    // rust: std::env::temp_dir().join(format!("horizon-content-{}-{name}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: dir
}
pub fn shape_tables_validate_tuples_defaults_and_collision() void {
}
    // rust: let content = hmod("shape-tuples", MANIFEST_TEXT, &[(
    // rust: "data/ruby/horizon/block/a.json",
    // rust: br#"{"template":"minecraft:stone","shapes":{"properties":["facing","count"],"values":{"north,2":[[0,0,0,1,0.5,1]]},"default":[[0,0,0,1,1,1]]},"collision_shapes":{"default":[]}}"#,
    // rust: )]).unwrap();
    // rust: let block = &content.blocks[0];
    // rust: assert_eq!(
    // rust: block.shapes.as_ref().unwrap().property_names(),
    // rust: ["facing", "count"]
    // rust: );
    // rust: assert_eq!(
    // rust: block.collision_shapes.as_ref().unwrap().default,
    // rust: Some(vec![])
    // rust: );
    // rust: for value in [
    // rust: r#"{"property":"axis","properties":["count"],"default":[]}"#,
    // rust: r#"{"properties":["axis","axis"],"default":[]}"#,
    // rust: r#"{"properties":["Axis"],"default":[]}"#,
    // rust: r#"{"properties":["axis","count"],"values":{"x":[]}}"#,
    // rust: r#"{"properties":["axis"],"values":{"":[]}}"#,
    // rust: r#"{"values":{"x":[]},"default":[]}"#,
    // rust: r#"{"default":[[1,0,0,0,1,1]]}"#,
    // rust: ] {
    // rust: let shapes: BlockShapes = serde_json::from_str(value).unwrap();
    // rust: assert!(shapes.check().is_err(), "{value}");
    // rust: let declaration =
    // rust: format!(r#"{{"template":"minecraft:stone","collision_shapes":{value}}}"#);
    // rust: assert!(
    // rust: hmod(
    // rust: "bad-collision",
    // rust: MANIFEST_TEXT,
    // rust: &[("data/ruby/horizon/block/a.json", declaration.as_bytes(),)]
    // rust: )
    // rust: .is_err(),
    // rust: "{value}"
    // rust: );
}
    // rust: let oversized = BlockShapes {
    // rust: property: String::new(),
    // rust: properties: vec![],
    // rust: values: BTreeMap::new(),
    // rust: default: Some(vec![[0.0, 0.0, 0.0, 1.0, 1.0, 1.0]; 17]),
}
    // rust: assert!(oversized.check().is_err());
    // rust: let mut nonfinite = oversized;
    // rust: nonfinite.default = Some(vec![[f64::NAN; 6]]);
    // rust: assert!(nonfinite.check().is_err());
}

pub fn hmod(name: []const u8, manifest: []const u8, files: *[([]const u8) void {
}
    // rust: let dir = scratch(name);
    // rust: let path = dir.join("m.hmod");
    // rust: std::fs::write(&path, Package::write_files(manifest, None, files)?).unwrap();
    // rust: let package = Package::read(&path);
    // rust: let content = package.and_then(|p| Content::read(&path, &p.manifest));
    // rust: std::fs::remove_dir_all(&dir).unwrap();
    // rust: content
}

pub fn blocks_and_items_declared_in_code_pass_the_files_checks() void {
}
    // rust: let block = |id: &str| Block {
    // rust: id: id.into(),
    // rust: template: "minecraft:iron_block".into(),
    // rust: item: true,
    // rust: ..Block::default()
}
    // rust: let item = |id: &str| Item {
    // rust: id: id.into(),
    // rust: template: "minecraft:diamond".into(),
    // rust: ..Item::default()
}
    // rust: let mut content = Content::declared("ruby");
    // rust: assert!(content.is_empty());
    // rust: let wrench = Item {
    // rust: crafting_remainder: Some("ruby:gear".into()),
    // rust: ..item("ruby:wrench")
}
    // rust: content
    // rust: .declare(&[block("ruby:gear"), block("ruby:casing")], &[wrench])
    // rust: .unwrap();
    // rust: assert_eq!(content.blocks.len(), 2);
    // rust: assert_eq!(content.items[0].id, "ruby:wrench");
        // Each refusal adds nothing.
    // rust: let refused = |blocks: &[Block], items: &[Item]| {
    // rust: let mut c = Content::declared("ruby");
    // rust: c.declare(&[block("ruby:gear")], &[]).unwrap();
    // rust: let e = c.declare(blocks, items).unwrap_err();
    // rust: assert_eq!((c.blocks.len(), c.items.len()), (1, 0), "{e}");
    // rust: e
}
    // rust: assert!(refused(&[block("emerald:gear")], &[]).contains("not an id in ruby:"));
    // rust: assert!(refused(&[block("minecraft:gear")], &[]).contains("not an id in ruby:"));
    // rust: assert!(refused(&[], &[item("ruby")]).contains("not an id in ruby:"));
    // rust: assert!(refused(&[block("ruby:gear")], &[]).contains("declared twice"));
    // rust: assert!(refused(&[], &[item("ruby:gear")]).contains("block's item"));
    // rust: let modded = Block {
    // rust: template: "ruby:other".into(),
    // rust: ..block("ruby:casing")
}
    // rust: assert!(refused(&[modded], &[]).contains("not a vanilla block"));
    // rust: let dim = Block {
    // rust: properties: BlockProperties {
    // rust: light: Some(16),
    // rust: ..BlockProperties::default()
    // rust: },
    // rust: ..block("ruby:lamp")
}
    // rust: assert!(refused(&[dim], &[]).contains("light is 0 to 15"));
    // rust: let stack = Item {
    // rust: max_stack_size: Some(100),
    // rust: ..item("ruby:ingot")
}
    // rust: assert!(refused(&[], &[stack]).contains("max_stack_size"));
    // rust: let rest = Item {
    // rust: crafting_remainder: Some("emerald:dust".into()),
    // rust: ..item("ruby:dust")
}
    // rust: assert!(refused(&[block("ruby:pipe")], &[rest]).contains("crafting_remainder"));
        // A cable's tag comes bare from code.
    // rust: let cable = Block {
    // rust: template: "minecraft:chorus_plant".into(),
    // rust: connects_to: Some("ruby:cables".into()),
    // rust: ..block("ruby:cable")
}
    // rust: content.declare(&[cable], &[]).unwrap();
}

pub fn a_connecting_block_file_names_its_tag_with_a_hash() void {
}
    // rust: let cable = br#"{"template": "minecraft:chorus_plant", "connects_to": "ruby:cables"}"#;
    // rust: let files: &[(&str, &[u8])] = &[("data/ruby/horizon/block/cable.json", cable)];
    // rust: let e = hmod("bare-tag", MANIFEST_TEXT, files).unwrap_err();
    // rust: assert!(e.contains("#namespace:path"), "{e}");
}

pub fn content_only_mod_round_trips() void {
}
    // rust: let files: &[(&str, &[u8])] = &[
    // rust: ("data/ruby/horizon/block/ruby_block.json", BLOCK),
    // rust: ("data/ruby/horizon/item/ruby.json", ITEM),
    // rust: ("data/ruby/recipe/ruby_block.json", b"{}"),
    // rust: ("data/minecraft/tags/block/mineable/pickaxe.json", b"{}"),
    // rust: ("data/c/tags/item/gems/ruby.json", b"{}"),
    // rust: ("assets/ruby/textures/block/ruby_block.png", b"png"),
    // rust: ("assets/minecraft/atlases/blocks.json", b"{}"),
    // rust: ];
    // rust: let content = hmod("ok", MANIFEST_TEXT, files).unwrap();
    // rust: assert_eq!(content.files.len(), 7);
    // rust: assert_eq!(
    // rust: content.blocks,
    // rust: [Block {
    // rust: id: "ruby:ruby_block".into(),
    // rust: template: "minecraft:iron_block".into(),
    // rust: shapes: None,
    // rust: collision_shapes: None,
    // rust: state_properties: BTreeMap::new(),
    // rust: default_state: BTreeMap::new(),
    // rust: properties: BlockProperties {
    // rust: hardness: Some(4.0),
    // rust: light: Some(3),
    // rust: sounds: Some("minecraft:amethyst_block".into()),
    // rust: ..BlockProperties::default()
    // rust: },
    // rust: item: true,
    // rust: components: BTreeMap::new(),
    // rust: connects_to: None,
    // rust: thickness: None,
    // rust: wood_type: None,
    // rust: wall_block: None,
    // rust: }]
    // rust: );
    // rust: assert_eq!(content.items[0].id, "ruby:ruby");
    // rust: assert_eq!(content.items[0].rarity, Some(Rarity::Uncommon));
    // rust: assert!(content.items[0].components.is_empty());
    // rust: assert_eq!(content.items[0].crafting_remainder, None);
}

pub fn items_name_their_crafting_remainder() void {
}
    // rust: let files: &[(&str, &[u8])] = &[
    // rust: (
    // rust: "data/ruby/horizon/item/a_stew.json",
    // rust: br#"{"template": "minecraft:mushroom_stew", "crafting_remainder": "minecraft:bowl"}"#,
    // rust: ),
    // rust: (
    // rust: "data/ruby/horizon/item/b_flask.json",
    // rust: br#"{"template": "minecraft:potion", "crafting_remainder": "ruby:c_flask"}"#,
    // rust: ),
    // rust: ("data/ruby/horizon/item/c_flask.json", ITEM),
    // rust: ];
    // rust: let content = hmod("remainder", MANIFEST_TEXT, files).unwrap();
    // rust: let rests: Vec<_> = content
    // rust: .items
    // rust: .iter()
    // rust: .map(|i| i.crafting_remainder.as_deref())
    // rust: .collect();
    // rust: assert_eq!(rests, [Some("minecraft:bowl"), Some("ruby:c_flask"), None]);
}

pub fn a_file_item_may_leave_a_code_declared_item_as_its_remainder() void {
}
        // `native_items` declares ruby:wrench in code; a file item names it as its remainder.
    // rust: let files: &[(&str, &[u8])] = &[(
    // rust: "data/ruby/horizon/item/tool.json",
    // rust: br#"{"template": "minecraft:iron_pickaxe", "crafting_remainder": "ruby:wrench"}"#,
    // rust: )];
    // rust: let read = |declared: &[String]| {
    // rust: let dir = scratch("declared-remainder");
    // rust: let path = dir.join("m.hmod");
    // rust: std::fs::write(
    // rust: &path,
    // rust: Package::write_files(MANIFEST_TEXT, None, files).unwrap(),
    // rust: )
    // rust: .unwrap();
    // rust: let package = Package::read(&path).unwrap();
    // rust: let content = Content::read_declaring(&path, &package.manifest, declared);
    // rust: std::fs::remove_dir_all(&dir).unwrap();
    // rust: content
}
    // rust: assert!(read(&[]).is_err(), "a remainder nobody declares is refused");
    // rust: let content = read(&["ruby:wrench".to_owned()]).expect("the code-declared item is known");
    // rust: assert_eq!(
    // rust: content.items[0].crafting_remainder.as_deref(),
    // rust: Some("ruby:wrench")
    // rust: );
}

pub fn items_patch_their_template_components() void {
}
    // rust: let sword = br#"{"template": "minecraft:iron_sword", "components": {
    // rust: "minecraft:max_damage": 900,
    // rust: "minecraft:attribute_modifiers": [{"type": "minecraft:attack_damage",
    // rust: "id": "minecraft:base_attack_damage", "amount": 7.0,
    // rust: "operation": "add_value", "slot": "mainhand"}],
    // rust: "!minecraft:repairable": {}}}"#;
    // rust: let files: &[(&str, &[u8])] = &[("data/ruby/horizon/item/ruby_sword.json", sword)];
    // rust: let content = hmod("components", MANIFEST_TEXT, files).unwrap();
    // rust: let components = &content.items[0].components;
    // rust: assert_eq!(
    // rust: components.keys().collect::<Vec<_>>(),
    // rust: [
    // rust: "!minecraft:repairable",
    // rust: "minecraft:attribute_modifiers",
    // rust: "minecraft:max_damage"
    // rust: ]
    // rust: );
    // rust: assert_eq!(components["minecraft:max_damage"], 900);
}

pub fn mob_effects_take_a_category_and_a_colour() void {
}
    // rust: let files: &[(&str, &[u8])] = &[
    // rust: (
    // rust: "data/ruby/horizon/mob_effect/glow.json",
    // rust: br#"{"category": "beneficial", "color": 16711680}"#,
    // rust: ),
    // rust: (
    // rust: "data/ruby/horizon/mob_effect/curse/dark.json",
    // rust: br#"{"category": "harmful", "color": 0}"#,
    // rust: ),
    // rust: ];
    // rust: let content = hmod("effects", MANIFEST_TEXT, files).unwrap();
    // rust: let effects: Vec<_> = content
    // rust: .effects
    // rust: .iter()
    // rust: .map(|e| (e.id.as_str(), e.category, e.color))
    // rust: .collect();
    // rust: assert_eq!(
    // rust: effects,
    // rust: [
    // rust: ("ruby:curse/dark", EffectCategory::Harmful, 0),
    // rust: ("ruby:glow", EffectCategory::Beneficial, 0xFF0000),
    // rust: ]
    // rust: );
    // rust: for (case, file, why) in [
    // rust: (
    // rust: "effect-colour",
    // rust: r#"{"category": "neutral", "color": 16777216}"#,
    // rust: "color is RGB",
    // rust: ),
    // rust: (
    // rust: "effect-category",
    // rust: r#"{"category": "good", "color": 1}"#,
    // rust: "unknown variant",
    // rust: ),
    // rust: (
    // rust: "effect-key",
    // rust: r#"{"category": "neutral", "color": 1, "id": "x"}"#,
    // rust: "unknown field",
    // rust: ),
    // rust: (
    // rust: "effect-missing",
    // rust: r#"{"category": "neutral"}"#,
    // rust: "missing field",
    // rust: ),
    // rust: ] {
    // rust: let files: &[(&str, &[u8])] =
    // rust: &[("data/ruby/horizon/mob_effect/a.json", file.as_bytes())];
    // rust: let e = hmod(case, MANIFEST_TEXT, files).unwrap_err();
    // rust: assert!(e.contains(why), "{case}: {e}");
}
}

pub fn menu_types_take_slots_data_slots_and_results() void {
}
    // rust: let files: &[(&str, &[u8])] = &[
    // rust: (
    // rust: "data/ruby/horizon/menu/press.json",
    // rust: br#"{"slots": 9, "data_slots": 2, "results": [7, 8]}"#,
    // rust: ),
    // rust: ("data/ruby/horizon/menu/bag.json", br#"{"slots": 4}"#),
    // rust: ];
    // rust: let content = hmod("menus", MANIFEST_TEXT, files).unwrap();
    // rust: let menus: Vec<_> = content
    // rust: .menu_types
    // rust: .iter()
    // rust: .map(|m| (m.id.as_str(), m.slots, m.data_slots, m.results.clone()))
    // rust: .collect();
    // rust: assert_eq!(
    // rust: menus,
    // rust: [("ruby:bag", 4, 0, vec![]), ("ruby:press", 9, 2, vec![7, 8])]
    // rust: );
    // rust: for (case, file, why) in [
    // rust: ("menu-empty", r#"{"slots": 0}"#, "slots is 1 to 256"),
    // rust: ("menu-large", r#"{"slots": 257}"#, "slots is 1 to 256"),
    // rust: (
    // rust: "menu-data",
    // rust: r#"{"slots": 1, "data_slots": 257}"#,
    // rust: "data_slots 0 to 256",
    // rust: ),
    // rust: (
    // rust: "menu-result",
    // rust: r#"{"slots": 3, "results": [3]}"#,
    // rust: "result 3 is past the last slot, 2",
    // rust: ),
    // rust: (
    // rust: "menu-twice",
    // rust: r#"{"slots": 3, "results": [1, 1]}"#,
    // rust: "result 1 is listed twice",
    // rust: ),
    // rust: ("menu-key", r#"{"slots": 3, "rows": 1}"#, "unknown field"),
    // rust: ("menu-missing", r#"{"data_slots": 1}"#, "missing field"),
    // rust: ] {
    // rust: let files: &[(&str, &[u8])] = &[("data/ruby/horizon/menu/a.json", file.as_bytes())];
    // rust: let e = hmod(case, MANIFEST_TEXT, files).unwrap_err();
    // rust: assert!(e.contains(why), "{case}: {e}");
}
}

pub fn entity_types_copy_a_throwable_and_name_its_item() void {
}
    // rust: let files: &[(&str, &[u8])] = &[
    // rust: ("data/ruby/horizon/item/gem.json", ITEM),
    // rust: (
    // rust: "data/ruby/horizon/entity_type/bolt.json",
    // rust: br#"{"template": "minecraft:snowball", "item": "ruby:gem", "damage": 2.5}"#,
    // rust: ),
    // rust: ("data/ruby/horizon/item/dust.json", ITEM),
    // rust: (
    // rust: "data/ruby/horizon/entity_type/puff.json",
    // rust: br#"{"template": "minecraft:snowball", "item": "ruby:dust"}"#,
    // rust: ),
    // rust: ];
    // rust: let content = hmod("types", MANIFEST_TEXT, files).unwrap();
    // rust: let types: Vec<_> = content
    // rust: .entity_types
    // rust: .iter()
    // rust: .map(|t| (t.id.as_str(), t.item.as_deref(), t.damage))
    // rust: .collect();
    // rust: assert_eq!(
    // rust: types,
    // rust: [
    // rust: ("ruby:bolt", Some("ruby:gem"), 2.5),
    // rust: ("ruby:puff", Some("ruby:dust"), 0.0)
    // rust: ]
    // rust: );
    // rust: let snowball = |rest: &str| format!(r#"{{"template": "minecraft:snowball"{rest}}}"#);
    // rust: for (case, file, why) in [
    // rust: (
    // rust: "type-template",
    // rust: r#"{"template": "minecraft:egg", "item": "ruby:gem"}"#.to_owned(),
    // rust: "is not one of",
    // rust: ),
    // rust: (
    // rust: "type-vanilla-item",
    // rust: snowball(r#", "item": "minecraft:stick""#),
    // rust: "is not one of this mod's items",
    // rust: ),
    // rust: (
    // rust: "type-unknown-item",
    // rust: snowball(r#", "item": "ruby:none""#),
    // rust: "is not one of this mod's items",
    // rust: ),
    // rust: (
    // rust: "type-damage",
    // rust: snowball(r#", "item": "ruby:gem", "damage": -1"#),
    // rust: "damage is 0 or more",
    // rust: ),
    // rust: (
    // rust: "type-key",
    // rust: snowball(r#", "item": "ruby:gem", "size": 1"#),
    // rust: "unknown field",
    // rust: ),
    // rust: (
    // rust: "type-no-item",
    // rust: snowball(""),
    // rust: "names the item that throws it",
    // rust: ),
    // rust: (
    // rust: "type-thrown-attributes",
    // rust: snowball(r#", "item": "ruby:gem", "attributes": {"minecraft:max_health": 4}"#),
    // rust: "only a living type has attributes",
    // rust: ),
    // rust: ] {
    // rust: let files: &[(&str, &[u8])] = &[
    // rust: ("data/ruby/horizon/item/gem.json", ITEM),
    // rust: ("data/ruby/horizon/entity_type/a.json", file.as_bytes()),
    // rust: ];
    // rust: let e = hmod(case, MANIFEST_TEXT, files).unwrap_err();
    // rust: assert!(e.contains(why), "{case}: {e}");
}
    // rust: let shared = snowball(r#", "item": "ruby:gem""#);
    // rust: let files: &[(&str, &[u8])] = &[
    // rust: ("data/ruby/horizon/item/gem.json", ITEM),
    // rust: ("data/ruby/horizon/entity_type/a.json", shared.as_bytes()),
    // rust: ("data/ruby/horizon/entity_type/b.json", shared.as_bytes()),
    // rust: ];
    // rust: let e = hmod("type-shared", MANIFEST_TEXT, files).unwrap_err();
    // rust: assert!(e.contains("already throws another entity type"), "{e}");
}

pub fn living_entity_types_copy_a_mob_with_their_own_attributes() void {
}
    // rust: let files: &[(&str, &[u8])] = &[
    // rust: (
    // rust: "data/ruby/horizon/entity_type/ghoul.json",
    // rust: br#"{"template": "minecraft:zombie",
    // rust: "attributes": {"minecraft:max_health": 40, "minecraft:movement_speed": 0.3}}"#,
    // rust: ),
    // rust: (
    // rust: "data/ruby/horizon/entity_type/settler.json",
    // rust: br#"{"template": "minecraft:villager"}"#,
    // rust: ),
    // rust: (
    // rust: "data/ruby/horizon/entity_type/merchant.json",
    // rust: br#"{"template": "minecraft:wandering_trader"}"#,
    // rust: ),
    // rust: ];
    // rust: let content = hmod("living", MANIFEST_TEXT, files).unwrap();
    // rust: let types: Vec<_> = content
    // rust: .entity_types
    // rust: .iter()
    // rust: .map(|t| {
    // rust: let attributes: Vec<_> =
    // rust: t.attributes.iter().map(|(a, v)| (a.as_str(), *v)).collect();
    // rust: (
    // rust: t.id.as_str(),
    // rust: t.template.as_str(),
    // rust: t.is_living(),
    // rust: attributes,
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: assert_eq!(
    // rust: types,
    // rust: [
    // rust: (
    // rust: "ruby:ghoul",
    // rust: "minecraft:zombie",
    // rust: true,
    // rust: vec![
    // rust: ("minecraft:max_health", 40.0),
    // rust: ("minecraft:movement_speed", 0.3)
    // rust: ]
    // rust: ),
    // rust: ("ruby:merchant", "minecraft:wandering_trader", true, vec![]),
    // rust: ("ruby:settler", "minecraft:villager", true, vec![]),
    // rust: ]
    // rust: );
    // rust: let zombie = |rest: &str| format!(r#"{{"template": "minecraft:zombie"{rest}}}"#);
    // rust: for (case, file, why) in [
    // rust: (
    // rust: "living-item",
    // rust: zombie(r#", "item": "ruby:gem""#),
    // rust: "a living type has no item or damage",
    // rust: ),
    // rust: (
    // rust: "living-damage",
    // rust: zombie(r#", "damage": 2"#),
    // rust: "a living type has no item or damage",
    // rust: ),
    // rust: (
    // rust: "living-attribute-id",
    // rust: zombie(r#", "attributes": {"max_health": 40}"#),
    // rust: "is an attribute id",
    // rust: ),
    // rust: (
    // rust: "living-attribute-value",
    // rust: zombie(r#", "attributes": {"minecraft:max_health": "40"}"#),
    // rust: "invalid type",
    // rust: ),
    // rust: ] {
    // rust: let files: &[(&str, &[u8])] = &[
    // rust: ("data/ruby/horizon/item/gem.json", ITEM),
    // rust: ("data/ruby/horizon/entity_type/a.json", file.as_bytes()),
    // rust: ];
    // rust: let e = hmod(case, MANIFEST_TEXT, files).unwrap_err();
    // rust: assert!(e.contains(why), "{case}: {e}");
}
}

pub fn a_block_may_occlude_nothing() void {
}
    // rust: let block = |occludes: &str| {
    // rust: let text = format!(
    // rust: r#"{{"template": "minecraft:barrel", "properties": {{"occludes": {occludes}}}}}"#
    // rust: );
    // rust: let files: &[(&str, &[u8])] =
    // rust: &[("data/ruby/horizon/block/panel.json", text.as_bytes())];
    // rust: hmod("occludes", MANIFEST_TEXT, files)
}
    // rust: let occludes = |c: Result<Content, String>| c.unwrap().blocks[0].properties.occludes;
    // rust: assert_eq!(occludes(block("false")), Some(false));
    // rust: assert_eq!(occludes(block("true")), Some(true));
    // rust: assert!(block(r#""no""#).is_err());
}

pub fn blocks_choose_their_render_shape() void {
}
    // rust: let block = |shape: &str| {
    // rust: let text = format!(
    // rust: r#"{{"template": "minecraft:stone", "properties": {{"render_shape": {shape}}}}}"#
    // rust: );
    // rust: let files: &[(&str, &[u8])] = &[("data/ruby/horizon/block/gear.json", text.as_bytes())];
    // rust: hmod("render-shape", MANIFEST_TEXT, files)
}
    // rust: let shape = |c: Result<Content, String>| c.unwrap().blocks[0].properties.render_shape;
    // rust: assert_eq!(shape(block(r#""MODEL""#)), Some(RenderShape::Model));
    // rust: assert_eq!(
    // rust: shape(block(r#""ENTITYBLOCK_ANIMATED""#)),
    // rust: Some(RenderShape::EntityblockAnimated)
    // rust: );
    // rust: assert_eq!(shape(block(r#""INVISIBLE""#)), Some(RenderShape::Invisible));
        // Only vanilla's constants, as written there.
    // rust: for bad in [r#""animated""#, r#""model""#, "1"] {
    // rust: assert!(block(bad).is_err(), "{bad}");
}
}

pub fn blocks_pick_the_states_that_tick_randomly() void {
}
    // rust: let own = r#""state_properties": {"grown": {"type": "boolean"}}"#;
    // rust: let block = |ticks: &str| {
    // rust: let text = format!(
    // rust: r#"{{"template": "minecraft:dirt", {own}, "properties": {{"random_ticks": {ticks}}}}}"#
    // rust: );
    // rust: let files: &[(&str, &[u8])] = &[("data/ruby/horizon/block/crop.json", text.as_bytes())];
    // rust: hmod("random-ticks", MANIFEST_TEXT, files)
}
    // rust: let ticks =
    // rust: |c: Result<Content, String>| c.unwrap().blocks[0].properties.random_ticks.clone();
    // rust: let state = |v: &str| [("grown".to_owned(), v.to_owned())];
        // Every state, whatever the template does; `false` stops a template that ticks.
    // rust: let all = ticks(block("true")).unwrap();
    // rust: assert!(all.applies(&state("true")) && all.applies(&[]));
    // rust: assert!(!ticks(block("false")).unwrap().applies(&state("false")));
        // Chosen states: a crop that stops ticking once it is grown.
    // rust: let chosen = ticks(block(r#"{"property": "grown", "values": ["false"]}"#)).unwrap();
    // rust: assert!(chosen.applies(&state("false")) && !chosen.applies(&state("true")));
    // rust: assert!(
    // rust: !chosen.applies(&[]),
    // rust: "a state without the property does not tick"
    // rust: );
        // Not the block's own property, no values, or a value it doesn't have.
    // rust: for bad in [
    // rust: r#"{"property": "age", "values": ["0"]}"#,
    // rust: r#"{"property": "grown", "values": []}"#,
    // rust: r#"{"property": "grown", "values": ["maybe"]}"#,
    // rust: ] {
    // rust: let e = block(bad).err().unwrap();
    // rust: assert!(e.contains("random_ticks"), "{bad}: {e}");
}
    // rust: assert!(block("3").is_err());
}

pub fn block_items_patch_their_components() void {
}
    // rust: let block = br#"{"template": "minecraft:iron_block", "components": {
    // rust: "minecraft:max_stack_size": 16, "!minecraft:lore": {}}}"#;
    // rust: let files: &[(&str, &[u8])] = &[("data/ruby/horizon/block/ruby_block.json", block)];
    // rust: let content = hmod("block-components", MANIFEST_TEXT, files).unwrap();
    // rust: let components = &content.blocks[0].components;
    // rust: assert_eq!(
    // rust: components.keys().collect::<Vec<_>>(),
    // rust: ["!minecraft:lore", "minecraft:max_stack_size"]
    // rust: );
    // rust: assert_eq!(components["minecraft:max_stack_size"], 16);
}

pub fn folder_mod_reads_the_same() void {
}
    // rust: let dir = scratch("folder");
    // rust: std::fs::write(dir.join(MANIFEST), MANIFEST_TEXT).unwrap();
    // rust: let block = dir.join("data/ruby/horizon/block");
    // rust: std::fs::create_dir_all(&block).unwrap();
    // rust: std::fs::write(block.join("ruby_block.json"), BLOCK).unwrap();
    // rust: let package = Package::read(&dir).unwrap();
    // rust: assert!(package.wasm.is_none());
    // rust: let content = Content::read(&dir, &package.manifest).unwrap();
    // rust: assert_eq!(content.files, ["data/ruby/horizon/block/ruby_block.json"]);
    // rust: assert_eq!(content.file(&content.files[0]).unwrap(), BLOCK);
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}

    /// A connecting block names a block tag and copies a `PipeBlock`.
pub fn connecting_blocks_copy_a_pipe_and_name_a_tag() void {
}
    // rust: let block = |json: &str| {
    // rust: let files: &[(&str, &[u8])] =
    // rust: &[("data/ruby/horizon/block/cable.json", json.as_bytes())];
    // rust: hmod("cable", MANIFEST_TEXT, files)
}
    // rust: let content = block(
    // rust: r##"{"template": "minecraft:chorus_plant", "connects_to": "#ruby:cable_joins"}"##,
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: content.blocks[0].connects_to.as_deref(),
    // rust: Some("ruby:cable_joins")
    // rust: );
    // rust: let thin =
    // rust: r##"{"template": "minecraft:chorus_plant", "connects_to": "#ruby:j", "thickness": 4}"##;
    // rust: assert_eq!(block(thin).unwrap().blocks[0].thickness, Some(4.0));
    // rust: let e = block(r#"{"template": "minecraft:chorus_plant", "thickness": 4}"#).unwrap_err();
    // rust: assert!(e.contains("connects_to"), "{e}");
    // rust: let e = block(r##"{"template": "minecraft:chorus_plant", "connects_to": "#ruby:j", "thickness": 16}"##)
    // rust: .unwrap_err();
    // rust: assert!(e.contains("2 to 14"), "{e}");
    // rust: let e = block(r##"{"template": "minecraft:stone", "connects_to": "#ruby:cable_joins"}"##)
    // rust: .unwrap_err();
    // rust: assert!(e.contains("chorus_plant"), "{e}");
    // rust: for tag in ["ruby:cable_joins", "#cable_joins", "#Ruby:Cable"] {
    // rust: let json =
    // rust: format!(r#"{{"template": "minecraft:chorus_plant", "connects_to": "{tag}"}}"#);
    // rust: let e = block(&json).unwrap_err();
    // rust: assert!(e.contains("block tag"), "{tag}: {e}");
}
}

    /// A sign names its wood; a standing or ceiling sign names the wall form
    /// its item places. Neither means anything on another template.
pub fn signs_name_their_wood_and_wall_form() void {
}
    // rust: let block = |json: &str| {
    // rust: let files: &[(&str, &[u8])] =
    // rust: &[("data/ruby/horizon/block/notice.json", json.as_bytes())];
    // rust: hmod("sign", MANIFEST_TEXT, files)
}
    // rust: let files: &[(&str, &[u8])] = &[
    // rust: (
    // rust: "data/ruby/horizon/block/notice.json",
    // rust: br#"{"template": "minecraft:oak_sign", "wood_type": "ruby:elm", "wall_block": "ruby:notice_wall"}"#,
    // rust: ),
    // rust: (
    // rust: "data/ruby/horizon/block/notice_wall.json",
    // rust: br#"{"template": "minecraft:oak_wall_sign", "item": false}"#,
    // rust: ),
    // rust: ];
    // rust: let content = hmod("sign-pair", MANIFEST_TEXT, files).unwrap();
    // rust: assert_eq!(content.blocks[0].wood_type.as_deref(), Some("ruby:elm"));
    // rust: assert_eq!(
    // rust: content.blocks[0].wall_block.as_deref(),
    // rust: Some("ruby:notice_wall")
    // rust: );
        // Vanilla's woods go by their bare names, as `WoodType.name` does.
    // rust: let cherry = r#"{"template": "minecraft:cherry_wall_hanging_sign", "wood_type": "cherry", "item": false}"#;
    // rust: assert_eq!(
    // rust: block(cherry).unwrap().blocks[0].wood_type.as_deref(),
    // rust: Some("cherry")
    // rust: );
    // rust: assert_eq!(
    // rust: block(r#"{"template": "minecraft:oak_sign", "wood_type": "ruby-wood:old/elm"}"#)
    // rust: .unwrap()
    // rust: .blocks[0]
    // rust: .wood_type
    // rust: .as_deref(),
    // rust: Some("ruby-wood:old/elm")
    // rust: );
    // rust: for bad in [
    // rust: r#"{"template": "minecraft:stone", "wood_type": "ruby:elm"}"#,
    // rust: r#"{"template": "minecraft:oak_sign", "wood_type": "Ruby:Elm"}"#,
    // rust: r#"{"template": "minecraft:oak_sign", "wood_type": "a:b:c"}"#,
    // rust: r#"{"template": "minecraft:oak_sign", "wood_type": "../elm"}"#,
    // rust: ] {
    // rust: assert!(block(bad).unwrap_err().contains("wood_type"), "{bad}");
}
    // rust: for bad in [
    // rust: r#"{"template": "minecraft:stone", "wall_block": "ruby:notice_wall"}"#,
    // rust: r#"{"template": "minecraft:oak_wall_sign", "wall_block": "ruby:notice_wall", "item": false}"#,
    // rust: r#"{"template": "minecraft:oak_sign", "wall_block": "notice_wall"}"#,
    // rust: r#"{"template": "minecraft:oak_sign", "wall_block": ":wall"}"#,
    // rust: r#"{"template": "minecraft:oak_sign", "wall_block": "ruby:"}"#,
    // rust: r#"{"template": "minecraft:oak_sign", "wall_block": "Ruby:wall"}"#,
    // rust: r#"{"template": "minecraft:oak_sign", "wall_block": "ruby:wall:other"}"#,
    // rust: r#"{"template": "minecraft:oak_sign", "wall_block": "ruby:notice_wall", "item": false}"#,
    // rust: ] {
    // rust: assert!(block(bad).unwrap_err().contains("wall_block"), "{bad}");
}
}

    /// A sign's wall form is one of the mod's blocks, of the matching wall
    /// template, with no item and no other sign. Anything else refuses this
    /// mod when it is read, and leaves the other mods alone.
pub fn a_signs_wall_block_is_its_own_mods_wall_form() void {
}
    // rust: let refused = |template: &str, wall_block: &str, wall: &str, wanted: &str| {
    // rust: let sign =
    // rust: format!(r#"{{"template": "minecraft:{template}", "wall_block": "{wall_block}"}}"#);
    // rust: let second =
    // rust: format!(r#"{{"template": "minecraft:{template}", "wall_block": "ruby:wall"}}"#);
    // rust: let mut files: Vec<(&str, &[u8])> = vec![
    // rust: ("data/ruby/horizon/block/sign.json", sign.as_bytes()),
    // rust: ("data/ruby/horizon/block/wall.json", wall.as_bytes()),
    // rust: ];
    // rust: if wanted == "already paired" {
    // rust: files.push(("data/ruby/horizon/block/second.json", second.as_bytes()));
}
    // rust: let e = hmod("sign-wall", MANIFEST_TEXT, &files).unwrap_err();
    // rust: assert!(e.contains(wanted), "{wanted}: {e}");
}
    // rust: let wall = r#"{"template": "minecraft:oak_wall_sign", "item": false}"#;
    // rust: for (template, wall_template) in [
    // rust: ("oak_sign", "stone"),
    // rust: ("oak_sign", "oak_wall_hanging_sign"),
    // rust: ("oak_hanging_sign", "oak_wall_sign"),
    // rust: ] {
    // rust: let other = format!(r#"{{"template": "minecraft:{wall_template}", "item": false}}"#);
    // rust: refused(template, "ruby:wall", &other, "needs a template");
}
    // rust: refused(
    // rust: "oak_sign",
    // rust: "ruby:wall",
    // rust: r#"{"template": "minecraft:oak_wall_sign"}"#,
    // rust: "\"item\" is false",
    // rust: );
    // rust: refused("oak_sign", "ruby:wall", wall, "already paired");
    // rust: for absent in ["ruby:elsewhere", "other:wall", "minecraft:oak_wall_sign"] {
    // rust: refused("oak_sign", absent, wall, "not one of this mod's blocks");
}

        // Declared in code, the same; nothing is added.
    // rust: let block = |id: &str, template: &str, item, wall_block: Option<&str>| Block {
    // rust: id: id.into(),
    // rust: template: template.into(),
    // rust: item,
    // rust: wall_block: wall_block.map(str::to_owned),
    // rust: ..Block::default()
}
    // rust: let mut content = Content::declared("ruby");
    // rust: let sign = block("ruby:sign", "minecraft:oak_sign", true, Some("ruby:wall"));
    // rust: assert!(content.declare(std::slice::from_ref(&sign), &[]).is_err());
    // rust: assert!(content.blocks.is_empty());
    // rust: let wall = block("ruby:wall", "minecraft:oak_wall_sign", false, None);
    // rust: content.declare(&[sign, wall], &[]).unwrap();
    // rust: assert_eq!(content.blocks.len(), 2);
}

    /// A creative tab: a title, an icon and its items, all item ids.
pub fn creative_tabs_name_their_items() void {
}
    // rust: let tab = |json: &str| {
    // rust: let files: &[(&str, &[u8])] =
    // rust: &[("data/ruby/horizon/creative_tab/gems.json", json.as_bytes())];
    // rust: hmod("tab", MANIFEST_TEXT, files)
}
    // rust: let content =
    // rust: tab(r#"{"title": "Ruby Gems", "icon": "ruby:ruby", "items": ["ruby:ruby", "minecraft:diamond"]}"#)
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: content.creative_tabs,
    // rust: [CreativeTab {
    // rust: id: "ruby:gems".into(),
    // rust: title: "Ruby Gems".into(),
    // rust: icon: "ruby:ruby".into(),
    // rust: items: vec!["ruby:ruby".into(), "minecraft:diamond".into()],
    // rust: }]
    // rust: );
    // rust: let e = tab(r#"{"title": "Gems", "icon": "ruby", "items": []}"#).unwrap_err();
    // rust: assert!(e.contains("item ids"), "{e}");
}

pub fn refuses_content_outside_its_fence() void {
}
    // rust: let refused = |name: &str, files: &[(&str, &[u8])]| {
    // rust: let e = hmod(name, MANIFEST_TEXT, files).unwrap_err();
    // rust: assert!(!e.is_empty());
    // rust: e
}
    // rust: let e = refused("other-ns", &[("data/other/horizon/block/a.json", BLOCK)]);
    // rust: assert!(e.contains("own namespaces"), "{e}");
    // rust: refused(
    // rust: "vanilla-asset",
    // rust: &[("assets/minecraft/textures/block/stone.png", b"x")],
    // rust: );
    // rust: refused(
    // rust: "vanilla-recipe",
    // rust: &[("data/minecraft/recipe/stone.json", b"{}")],
    // rust: );
    // rust: refused("convention-recipe", &[("data/c/recipe/stone.json", b"{}")]);
    // rust: refused("convention-asset", &[("assets/c/lang/en_us.json", b"{}")]);
    // rust: let e = refused(
    // rust: "modded-template",
    // rust: &[(
    // rust: "data/ruby/horizon/block/a.json",
    // rust: br#"{"template": "ruby:other"}"#,
    // rust: )],
    // rust: );
    // rust: assert!(e.contains("not a vanilla block"), "{e}");
    // rust: refused(
    // rust: "light",
    // rust: &[(
    // rust: "data/ruby/horizon/block/a.json",
    // rust: br#"{"template": "minecraft:stone", "properties": {"light": 16}}"#,
    // rust: )],
    // rust: );
    // rust: refused(
    // rust: "unknown-key",
    // rust: &[(
    // rust: "data/ruby/horizon/block/a.json",
    // rust: br#"{"template": "minecraft:stone", "glow": true}"#,
    // rust: )],
    // rust: );
    // rust: refused("shape-reversed", &[("data/ruby/horizon/block/a.json", br#"{"template":"minecraft:stone","shapes":{"property":"axis","values":{"x":[[1,0,0,0,1,1]]}}}"#)]);
    // rust: refused("shape-malformed", &[("data/ruby/horizon/block/a.json", br#"{"template":"minecraft:stone","shapes":{"property":"axis","values":{"x":[[0,0,0,1,1]]}}}"#)]);
    // rust: refused(
    // rust: "shape-no-values",
    // rust: &[(
    // rust: "data/ruby/horizon/block/a.json",
    // rust: br#"{"template":"minecraft:stone","shapes":{"property":"axis","values":{}}}"#,
    // rust: )],
    // rust: );
    // rust: let e = refused(
    // rust: "clash",
    // rust: &[
    // rust: ("data/ruby/horizon/block/a.json", BLOCK),
    // rust: ("data/ruby/horizon/item/a.json", ITEM),
    // rust: ],
    // rust: );
    // rust: assert!(e.contains("also a block's item"), "{e}");
    // rust: refused("other-kind", &[("data/ruby/horizon/entity/a.json", b"{}")]);
    // rust: refused(
    // rust: "stack",
    // rust: &[(
    // rust: "data/ruby/horizon/item/a.json",
    // rust: br#"{"template": "minecraft:stick", "max_stack_size": 100}"#,
    // rust: )],
    // rust: );
    // rust: for (case, components, why) in [
    // rust: (
    // rust: "bare-component",
    // rust: r#"{"max_damage": 3}"#,
    // rust: "must be namespaced",
    // rust: ),
    // rust: (
    // rust: "uppercase-path",
    // rust: r#"{"minecraft:Foo": 3}"#,
    // rust: "must be namespaced and valid",
    // rust: ),
    // rust: (
    // rust: "uppercase-namespace",
    // rust: r#"{"Example:charge": 3}"#,
    // rust: "must be namespaced and valid",
    // rust: ),
    // rust: (
    // rust: "empty-namespace",
    // rust: r#"{":charge": 3}"#,
    // rust: "must be namespaced and valid",
    // rust: ),
    // rust: (
    // rust: "empty-path",
    // rust: r#"{"example:": 3}"#,
    // rust: "must be namespaced and valid",
    // rust: ),
    // rust: (
    // rust: "invalid-removal",
    // rust: r#"{"!example:Foo": {}}"#,
    // rust: "must be namespaced and valid",
    // rust: ),
    // rust: (
    // rust: "own-key",
    // rust: r#"{"minecraft:rarity": "epic"}"#,
    // rust: "set rarity instead",
    // rust: ),
    // rust: (
    // rust: "own-removal",
    // rust: r#"{"!minecraft:max_stack_size": {}}"#,
    // rust: "set max_stack_size",
    // rust: ),
    // rust: (
    // rust: "removal-value",
    // rust: r#"{"!minecraft:food": true}"#,
    // rust: "a removal's value is {}",
    // rust: ),
    // rust: ] {
    // rust: let item = format!(r#"{{"template": "minecraft:stick", "components": {components}}}"#);
    // rust: let e = refused(case, &[("data/ruby/horizon/item/a.json", item.as_bytes())]);
    // rust: assert!(e.contains(why), "{case}: {e}");
}
    // rust: let glass = br#"{"template": "minecraft:glass", "item": false}"#;
    // rust: for (case, rest) in [
    // rust: ("bare-remainder", "bowl"),
    // rust: ("missing-remainder", "ruby:bowl"),
    // rust: ("other-mod-remainder", "jade:bowl"),
    // rust: ("itemless-remainder", "ruby:glass"),
    // rust: ("air-remainder", "minecraft:air"),
    // rust: ] {
    // rust: let item =
    // rust: format!(r#"{{"template": "minecraft:stick", "crafting_remainder": "{rest}"}}"#);
    // rust: let files: &[(&str, &[u8])] = &[
    // rust: ("data/ruby/horizon/item/a.json", item.as_bytes()),
    // rust: ("data/ruby/horizon/block/glass.json", glass),
    // rust: ];
    // rust: let e = refused(case, files);
    // rust: assert!(e.contains("crafting_remainder"), "{case}: {e}");
}
    // rust: for (case, block, why) in [
    // rust: (
    // rust: "block-removal-value",
    // rust: r#"{"template": "minecraft:stone", "components": {"!minecraft:lore": []}}"#,
    // rust: "a removal's value is {}",
    // rust: ),
    // rust: (
    // rust: "block-stack-zero",
    // rust: r#"{"template": "minecraft:stone", "components": {"minecraft:max_stack_size": 0}}"#,
    // rust: "integer 1 to 99",
    // rust: ),
    // rust: (
    // rust: "block-stack-100",
    // rust: r#"{"template": "minecraft:stone", "components": {"minecraft:max_stack_size": 100}}"#,
    // rust: "integer 1 to 99",
    // rust: ),
    // rust: (
    // rust: "block-stack-string",
    // rust: r#"{"template": "minecraft:stone", "components": {"minecraft:max_stack_size": "16"}}"#,
    // rust: "integer 1 to 99",
    // rust: ),
    // rust: (
    // rust: "block-rarity",
    // rust: r#"{"template": "minecraft:stone", "components": {"minecraft:rarity": "bogus"}}"#,
    // rust: "common, uncommon",
    // rust: ),
    // rust: (
    // rust: "block-without-item",
    // rust: r#"{"template": "minecraft:glass", "item": false,
    // rust: "components": {"minecraft:max_stack_size": 16}}"#,
    // rust: "item is false",
    // rust: ),
    // rust: ] {
    // rust: let e = refused(
    // rust: case,
    // rust: &[("data/ruby/horizon/block/a.json", block.as_bytes())],
    // rust: );
    // rust: assert!(e.contains(why), "{case}: {e}");
}
}

pub fn listed_namespaces_hold_content() void {
}
    // rust: let manifest = format!("{MANIFEST_TEXT}namespaces = [\"kaisyn\"]\n");
    // rust: let files: &[(&str, &[u8])] = &[
    // rust: ("data/kaisyn/worldgen/template_pool/a.json", b"{}"),
    // rust: ("data/kaisyn/structure/a.nbt", b"nbt"),
    // rust: ("assets/kaisyn/lang/en_us.json", b"{}"),
    // rust: ];
    // rust: let content = hmod("listed", &manifest, files).unwrap();
    // rust: assert_eq!(content.files.len(), 3);
    // rust: assert_eq!(content.namespaces, ["ruby", "kaisyn"]);
        // Declarations stay in the id's namespace.
    // rust: let decl: &[(&str, &[u8])] = &[("data/kaisyn/horizon/block/a.json", BLOCK)];
    // rust: let e = hmod("listed-decl", &manifest, decl).unwrap_err();
    // rust: assert!(e.contains("declared in data/ruby/horizon/"), "{e}");
        // A namespace it does not list is still outside.
    // rust: let other: &[(&str, &[u8])] = &[("data/other/structure/a.nbt", b"nbt")];
    // rust: assert!(hmod("listed-other", &manifest, other).is_err());
}

pub fn mods_sharing_a_namespace_clash() void {
}
    // rust: let t_and_t = ["t_and_t".to_owned(), "kaisyn".to_owned()];
    // rust: let kaisyn = ["kaisyn".to_owned()];
    // rust: let ruby = ["ruby".to_owned(), "gems".to_owned()];
    // rust: assert_eq!(
    // rust: clash(("t_and_t", &t_and_t), ("kaisyn", &kaisyn)).as_deref(),
    // rust: Some("mods t_and_t and kaisyn both use the namespace kaisyn; turn one of them off")
    // rust: );
    // rust: assert_eq!(clash(("t_and_t", &t_and_t), ("ruby", &ruby)), None);
}

pub fn content_needs_the_registries_capability() void {
}
    // rust: let code_only = MANIFEST_TEXT
    // rust: .replace("api = \"0.2\"", "api = \"0.1\"")
    // rust: .replace("capabilities = [\"registries\"]", "capabilities = []");
        // No code and no registries: nothing to load.
    // rust: let e = hmod("empty", &code_only, &[]).unwrap_err();
    // rust: assert!(e.contains("mod.wasm: missing"), "{e}");
        // Registries on API 0.1.
    // rust: let old = MANIFEST_TEXT.replace("api = \"0.2\"", "api = \"0.1\"");
    // rust: assert!(Manifest::parse(&old).unwrap_err().contains("needs api"));
        // Content without the capability, in a mod with code.
    // rust: let dir = scratch("no-cap");
    // rust: let path = dir.join("m.hmod");
    // rust: let files: &[(&str, &[u8])] = &[("assets/ruby/lang/en_us.json", b"{}")];
    // rust: std::fs::write(
    // rust: &path,
    // rust: Package::write_files(&code_only, Some(b"\0asm"), files).unwrap(),
    // rust: )
    // rust: .unwrap();
    // rust: let package = Package::read(&path).unwrap();
    // rust: let e = Content::read(&path, &package.manifest).err().unwrap();
    // rust: assert!(e.contains("not capability registries"), "{e}");
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}

pub fn paths_are_plain() void {
}
    // rust: assert!(check_path("assets/ruby/textures/block/ruby_block.png").is_ok());
    // rust: assert!(check_path("data/ruby/loot_table/blocks/a.json").is_ok());
    // rust: for bad in [
    // rust: "assets/ruby",
    // rust: "assets/../x/y",
    // rust: "assets/ruby//a",
    // rust: "assets/Ruby/a",
    // rust: "assets/ruby/a b",
    // rust: "/assets/ruby/a",
    // rust: "other/ruby/a",
    // rust: "assets\\ruby\\a",
    // rust: ] {
    // rust: assert!(check_path(bad).is_err(), "{bad}");
}
}
}
