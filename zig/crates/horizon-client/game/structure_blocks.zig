//! Transpiled from Horizon Rust crate
//! Module: horizon-client_structure_blocks
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Structure blocks on the server: `StructureBlockEntity`'s save, load and
//! scan, the `StructureTemplateManager` they go through (templates kept in
//! memory, written to `<world>/generated/<namespace>/structures/<path>.nbt`),
//! `StructureBlock.neighborChanged` and `handleSetStructureBlock`.
// use super::{Game, lan::LanHost};
// use horizon_client::{
    // rust: containers::BlockEntity,
    // rust: gizmos::{Gizmos, InvisibleBlock},
    // rust: save,
    // rust: structure_block::{
    // rust: self, RenderMode, SCAN_CORNER_BLOCKS_RANGE, StructureBlock, StructureMode, UpdateType,
    // rust: },
    // rust: text::Text,
}
// use horizon_core::position::BlockPos;
// use horizon_protocol::packets::play;
// use horizon_world::{
    // rust: compression::Compression,
    // rust: level::{TemplateSettings, flags},
    // rust: nbt::{self, Compound, Limits, NamedTag, Tag},
    // rust: worldgen::structure::{BlockInfo, EntityInfo, StructureTemplate, save_nbt},
}
// use std::collections::HashSet;

    // rust: type Pos = (i32, i32, i32);

/// A template the manager holds: its file's tree and the author `setAuthor`
/// gave it (the file does not keep one, so a loaded template's is `?`).
    // rust: pub(super) struct TemplateEntry {
    // rust: pub(super) tag: Tag,
    // rust: pub(super) author: String,
}

/// `StructureTemplate.size` of a template's tree.
    // rust: pub(super) fn template_size(tag: &Tag) -> [i32; 3] {
    // rust: let mut size = [0; 3];
    // rust: if let Some(Tag::List(values)) = tag.get("size") {
    // rust: for (slot, value) in size.iter_mut().zip(values) {
    // rust: if let Tag::Int(v) = value {
    // rust: *slot = *v;
}
}
}
    // rust: size
}

/// `FileUtil.isPathPortable`-like check of the path under `structures/`: no
/// empty, `.` or `..` segments.
pub fn portable_path(path: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: path.split('/')
    // rust: .all(|s| !s.is_empty() && s != "." && s != "..")
}

    // rust: impl Game<'_> {
    /// `BlockEntityWithBoundingBoxRenderer`: for a player who may use game
    /// master blocks (or a spectator), each structure block's box and, with
    /// Show Invisible Blocks on, a marker for every barrier, light, structure
    /// void and air block in it. Blocks beyond `getViewDistance` (96) are
    /// not drawn.
    // rust: pub(super) fn bounding_box_gizmos(&self, camera: [f64; 3], g: &mut Gizmos) {
    // rust: let game_master = self.can_use_game_master_blocks() || self.spectator();
    // rust: let facts = self.res.facts();
    // rust: for (pos, entity) in self.world.block_entities.boxes() {
    // rust: let centre = [pos.0, pos.1, pos.2].map(|v| f64::from(v) + 0.5);
    // rust: let dist: f64 = (0..3).map(|i| (centre[i] - camera[i]).powi(2)).sum();
    // rust: let block = [pos.0, pos.1, pos.2];
    // rust: let (mode, area) = match entity {
    // rust: BlockEntity::StructureBlock(b) if game_master && dist < 96.0 * 96.0 => {
    // rust: (b.render_mode(), b.renderable_box())
}
    // rust: BlockEntity::TestInstanceBlock(b) => {
    // rust: if !game_master || dist >= 96.0 * 96.0 {
    // rust: continue;
}
                    // TestInstanceBlockEntity.renderMode: BOX.
    // rust: let padding = self.test_holder_padding(*pos);
    // rust: let (offset, size) = b.renderable_box(padding, self.test_rotation(*pos));
    // rust: (
    // rust: RenderMode::Box,
    // rust: horizon_client::structure_block::RenderableBox { offset, size },
    // rust: )
}
    // rust: _ => continue,
}
    // rust: if mode == RenderMode::None {
    // rust: continue;
}
    // rust: let invisible = (mode == RenderMode::BoxAndInvisibleBlocks).then(|| {
    // rust: let [sx, sy, sz] = area.size;
    // rust: let mut cells = vec![None; (sx.max(0) * sy.max(0) * sz.max(0)) as usize];
    // rust: for x in 0..sx {
    // rust: for y in 0..sy {
    // rust: for z in 0..sz {
    // rust: let at = [0, 1, 2].map(|i| block[i] + area.offset[i] + [x, y, z][i]);
    // rust: let state = self.world.block(at[0], at[1], at[2]);
    // rust: let kind = if facts.is_air(state) {
    // rust: Some(InvisibleBlock::Air)
    // rust: } else {
    // rust: match &*facts.get(state).name {
    // rust: "minecraft:structure_void" => {
    // rust: Some(InvisibleBlock::StructureVoid)
}
    // rust: "minecraft:barrier" => Some(InvisibleBlock::Barrier),
    // rust: "minecraft:light" => Some(InvisibleBlock::Light),
    // rust: _ => None,
}
}
    // rust: cells[(z * sx * sy + y * sx + x) as usize] = kind;
}
}
}
    // rust: cells
    // rust: });
    // rust: g.bounding_box(block, area.offset, area.size, invisible.as_deref());
}
}

pub fn structure_block_at(self: *Self, pos: Pos) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.world.block_entities.get(&pos)? {
    // rust: BlockEntity::StructureBlock(b) => Some(b),
    // rust: _ => None,
}
}
pub fn structure_block_mut(self: *Self, pos: Pos) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.world.block_entities.get_mut(&pos)? {
    // rust: BlockEntity::StructureBlock(b) => Some(b),
    // rust: _ => None,
}
}

    /// `StructureBlock.setPlacedBy`: the placing player is the author.
    // rust: pub(super) fn structure_block_placed(&mut self, pos: Pos) {
    // rust: let author = self
    // rust: .lan_acting_name
    // rust: .clone()
    // rust: .unwrap_or_else(|| self.options.player_name());
    // rust: if let Some(b) = self.structure_block_mut(pos) {
    // rust: b.author = author;
}
}

    /// `StructureTemplateManager.get`: the cache (misses included), else the
    /// world's saved structures, else the game's own.
    // rust: pub(super) fn template_entry(&mut self, name: &str) -> Option<TemplateEntry> {
    // rust: if let Some(cached) = self.structure_templates.get(name) {
    // rust: return cached.clone();
}
    // rust: let loaded = self.read_template_tag(name).map(|tag| TemplateEntry {
    // rust: tag,
    // rust: author: "?".to_owned(),
    // rust: });
    // rust: self.structure_templates
    // rust: .insert(name.to_owned(), loaded.clone());
    // rust: loaded
}

    /// `StructureTemplateManager.save`: the file under the world's
    /// `generated` folder.
pub fn write_template(self: *Self, name: []const u8, tag: *Tag) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (ns, path) = name.split_once(':').unwrap_or(("minecraft", name));
    // rust: if !portable_path(path) || !portable_path(ns) {
    // rust: return false;
}
    // rust: let file = self
    // rust: .world_root
    // rust: .join("generated")
    // rust: .join(ns)
    // rust: .join("structures")
    // rust: .join(format!("{path}.nbt"));
    // rust: let Some(parent) = file.parent() else {
    // rust: return false;
}
    // rust: let named = NamedTag {
    // rust: name: "".into(),
    // rust: tag: tag.clone(),
}
    // rust: let Ok(raw) = nbt::write_named(&named, Limits::templates()) else {
    // rust: return false;
}
    // rust: let Ok(bytes) = Compression::Gzip.encode(&raw) else {
    // rust: return false;
}
    // rust: std::fs::create_dir_all(parent).is_ok() && std::fs::write(file, bytes).is_ok()
}

    /// `StructureTemplate.fillFromWorld` for a box at `origin`: every block
    /// but structure voids with its block entity's data, and the entities
    /// (never players) in it.
    // rust: fn template_from_world(
    // rust: &mut self,
    // rust: origin: [i32; 3],
    // rust: size: [i32; 3],
    // rust: include_entities: bool,
    // rust: ignore_air: bool,
    // rust: ) -> Tag {
    // rust: let registry = self.pack.assets.registry;
    // rust: let void = registry.default_state("minecraft:structure_void");
    // rust: let air = ignore_air
    // rust: .then(|| registry.default_state("minecraft:air"))
    // rust: .flatten();
    // rust: let mut blocks = Vec::new();
    // rust: for y in 0..size[1] {
    // rust: for z in 0..size[2] {
    // rust: for x in 0..size[0] {
    // rust: let at = (origin[0] + x, origin[1] + y, origin[2] + z);
    // rust: let state = self.world.block(at.0, at.1, at.2);
    // rust: if Some(state) == void || Some(state) == air {
    // rust: continue;
}
    // rust: let nbt = self.world.block_entities.get(&at).map(|entity| {
    // rust: let name = &*self.res.facts().get(state).name;
    // rust: let Tag::Compound(mut c) = save::encode_block_entity(at, entity, name)
    // rust: else {
    // rust: return Compound::new();
}
                        // `saveWithId`: the id, not the position.
    // rust: for key in ["x", "y", "z", "keepPacked"] {
    // rust: c.remove(&key.into());
}
    // rust: c
    // rust: });
    // rust: blocks.push(BlockInfo {
    // rust: pos: [x, y, z],
    // rust: state,
    // rust: nbt,
    // rust: });
}
}
}
    // rust: let entities = if include_entities {
    // rust: self.template_entities(origin, size)
    // rust: } else {
    // rust: Vec::new()
}
    // rust: let transforms = self.state_transforms().expect("structure block table");
    // rust: save_nbt(
    // rust: registry,
    // rust: transforms,
    // rust: size,
    // rust: blocks,
    // rust: &entities,
    // rust: horizon_core::version::DATA_VERSION,
    // rust: )
}

    /// `StructureTemplate.fillEntityList`: the entities inside the box, at
    /// positions relative to its minimum corner.
pub fn template_entities(self: *Self, origin: [i32; 3], size: [i32; 3]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let min = origin.map(f64::from);
    // rust: let max = [0, 1, 2].map(|i| min[i] + f64::from(size[i]));
    // rust: let chunks: HashSet<(i32, i32)> = (origin[0] >> 4..=(origin[0] + size[0] - 1) >> 4)
    // rust: .flat_map(|cx| {
    // rust: (origin[2] >> 4..=(origin[2] + size[2] - 1) >> 4).map(move |cz| (cx, cz))
    // rust: })
    // rust: .collect();
    // rust: let mut out = Vec::new();
    // rust: for (_, tags) in self.entity_chunks(&chunks, false) {
    // rust: for tag in tags {
    // rust: let Some(Tag::List(pos)) = tag.get("Pos") else {
    // rust: continue;
}
    // rust: let coords: Vec<f64> = pos
    // rust: .iter()
    // rust: .filter_map(|t| match t {
    // rust: Tag::Double(bits) => Some(f64::from_bits(*bits)),
    // rust: _ => None,
    // rust: })
    // rust: .collect();
    // rust: if coords.len() != 3 || (0..3).any(|i| coords[i] < min[i] || coords[i] >= max[i]) {
    // rust: continue;
}
    // rust: let Tag::Compound(mut nbt) = tag else {
    // rust: continue;
}
    // rust: let relative = [0, 1, 2].map(|i| coords[i] - min[i]);
    // rust: let block_pos = relative.map(|v| v.floor() as i32);
    // rust: nbt.remove(&"UUID".into());
    // rust: out.push(EntityInfo {
    // rust: pos: relative,
    // rust: block_pos,
    // rust: nbt,
    // rust: });
}
}
    // rust: out
}

    /// `StructureBlockEntity.saveStructure(boolean)`: the template under the
    /// block's name takes the area, and is written when `to_disk`.
pub fn save_structure(self: *Self, pos: Pos, to_disk: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(b) = self.structure_block_at(pos).cloned() else {
    // rust: return false;
}
    // rust: let Some(name) = b.name.clone() else {
    // rust: return false;
}
    // rust: let origin = [pos.0 + b.pos[0], pos.1 + b.pos[1], pos.2 + b.pos[2]];
    // rust: self.save_structure_area(
    // rust: &name,
    // rust: origin,
    // rust: b.size,
    // rust: b.ignore_entities,
    // rust: &b.author,
    // rust: to_disk,
    // rust: false,
    // rust: )
}

    /// The static `StructureBlockEntity.saveStructure`: `getOrCreate`, then
    /// `fillFromWorld`, which leaves a template alone when a side of the area
    /// is empty; `ignore_air` is `ignoreBlocks = [AIR]`.
    // rust: pub(super) fn save_structure_area(
    // rust: &mut self,
    // rust: name: &str,
    // rust: origin: [i32; 3],
    // rust: size: [i32; 3],
    // rust: ignore_entities: bool,
    // rust: author: &str,
    // rust: to_disk: bool,
    // rust: ignore_air: bool,
    // rust: ) -> bool {
    // rust: let existing = self.template_entry(name);
    // rust: let tag = if size.iter().all(|s| *s >= 1) {
    // rust: self.template_from_world(origin, size, !ignore_entities, ignore_air)
    // rust: } else {
    // rust: existing.map_or_else(
    // rust: || {
    // rust: let transforms = self.state_transforms().expect("structure block table");
    // rust: save_nbt(
    // rust: self.pack.assets.registry,
    // rust: transforms,
    // rust: [0; 3],
    // rust: Vec::new(),
    // rust: &[],
    // rust: horizon_core::version::DATA_VERSION,
    // rust: )
    // rust: },
    // rust: |e| e.tag,
    // rust: )
}
    // rust: let saved = !to_disk || self.write_template(name, &tag);
    // rust: self.structure_templates.insert(
    // rust: name.to_owned(),
    // rust: Some(TemplateEntry {
    // rust: tag,
    // rust: author: author.to_owned(),
    // rust: }),
    // rust: );
    // rust: saved
}

    /// `StructureBlockEntity.loadStructureInfo(template)`.
pub fn load_structure_info(self: *Self, pos: Pos, entry: *TemplateEntry) void {
}
    // rust: let size = template_size(&entry.tag);
    // rust: if let Some(b) = self.structure_block_mut(pos) {
    // rust: b.author = entry.author.clone();
    // rust: b.size = size;
}
}

    /// `StructureBlockEntity.placeStructure(level, template)`.
pub fn place_structure(self: *Self, pos: Pos, entry: *TemplateEntry) void {
}
    // rust: self.load_structure_info(pos, entry);
    // rust: let Some(b) = self.structure_block_at(pos).cloned() else {
    // rust: return;
}
    // rust: let at = BlockPos::new(pos.0 + b.pos[0], pos.1 + b.pos[1], pos.2 + b.pos[2]);
    // rust: let mut settings = load_settings(b.mirror, b.rotation, b.integrity, b.seed, b.strict);
    // rust: settings.ignore_entities = b.ignore_entities;
    // rust: self.place_template_entry(entry, at, settings, b.mirror, b.rotation);
}

    /// `StructureTemplate.placeInWorld` of a template at `at`: the entities
    /// it brings are spawned and the block entities it loaded sent to the
    /// clients. Returns whether it placed.
    // rust: pub(super) fn place_template_entry(
    // rust: &mut self,
    // rust: entry: &TemplateEntry,
    // rust: at: BlockPos,
    // rust: settings: TemplateSettings,
    // rust: mirror: horizon_world::worldgen::structure::Mirror,
    // rust: rotation: horizon_world::worldgen::structure::Rotation,
    // rust: ) -> bool {
    // rust: let (Some(transforms), registry) = (self.state_transforms(), self.pack.assets.registry)
    // rust: else {
    // rust: return false;
}
    // rust: let template = StructureTemplate::from_nbt(&entry.tag, registry, transforms);
    // rust: let placed = self.with_level(|behaviours, level, ticks| {
    // rust: behaviours.place_template(level, ticks, &template, at, settings)
    // rust: });
    // rust: let _ = self.process_level_events();
    // rust: let Some((placed, entities)) = placed else {
    // rust: return false;
}
    // rust: for entity in entities {
    // rust: self.spawn_entity_from_nbt(Tag::Compound(entity));
}
        // The block entities the template loaded reach the clients.
    // rust: let area = template.bounding_box([at.x, at.y, at.z], rotation, [0; 3], mirror);
    // rust: let keys: Vec<Pos> = self
    // rust: .world
    // rust: .block_entities
    // rust: .keys()
    // rust: .copied()
    // rust: .filter(|k| area.is_inside([k.0, k.1, k.2]))
    // rust: .collect();
    // rust: for key in keys {
    // rust: self.mark_block_entity_updated(key);
}
    // rust: placed
}

    /// `StructureBlockEntity.placeStructureIfSameSize`.
pub fn place_structure_if_same_size(self: *Self, pos: Pos) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(b) = self.structure_block_at(pos) else {
    // rust: return false;
}
    // rust: let (mode, name, size) = (b.mode, b.name.clone(), b.size);
    // rust: let Some(name) = name.filter(|_| mode == StructureMode::Load) else {
    // rust: return false;
}
    // rust: let Some(entry) = self.template_entry(&name) else {
    // rust: return false;
}
    // rust: if template_size(&entry.tag) == size {
    // rust: self.place_structure(pos, &entry);
    // rust: true
    // rust: } else {
    // rust: self.load_structure_info(pos, &entry);
    // rust: false
}
}

    /// `StructureBlockEntity.isStructureLoadable`.
pub fn structure_loadable(self: *Self, pos: Pos) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(b) = self.structure_block_at(pos) else {
    // rust: return false;
}
    // rust: let (mode, name) = (b.mode, b.name.clone());
    // rust: mode == StructureMode::Load && name.is_some_and(|name| self.template_entry(&name).is_some())
}

    /// `StructureBlockEntity.detectSize`: the box the corner blocks of this
    /// structure's name enclose.
pub fn detect_structure_size(self: *Self, pos: Pos) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(b) = self.structure_block_at(pos) else {
    // rust: return false;
}
    // rust: if b.mode != StructureMode::Save {
    // rust: return false;
}
    // rust: let name = b.name.clone();
    // rust: let range = SCAN_CORNER_BLOCKS_RANGE;
    // rust: let corners: Vec<[i32; 3]> = (&self.world.block_entities)
    // rust: .into_iter()
    // rust: .filter(|((x, _, z), _)| (x - pos.0).abs() <= range && (z - pos.2).abs() <= range)
    // rust: .filter_map(|(k, e)| match e {
    // rust: BlockEntity::StructureBlock(c)
    // rust: if c.mode == StructureMode::Corner && c.name == name =>
    // rust: {
    // rust: Some([k.0, k.1, k.2])
}
    // rust: _ => None,
    // rust: })
    // rust: .collect();
    // rust: let at = [pos.0, pos.1, pos.2];
    // rust: let Some((min, max)) = StructureBlock::enclosing_box(&corners, at) else {
    // rust: return false;
}
    // rust: let Some((offset, size)) = StructureBlock::detected(min, max, at) else {
    // rust: return false;
}
    // rust: if let Some(b) = self.structure_block_mut(pos) {
    // rust: b.pos = offset;
    // rust: b.size = size;
}
    // rust: true
}

    /// `StructureBlockEntity.setMode`: the entity's and the block state's.
pub fn set_structure_mode(self: *Self, pos: Pos, mode: StructureMode) void {
}
    // rust: if let Some(b) = self.structure_block_mut(pos) {
    // rust: b.mode = mode;
}
    // rust: self.set_mode_property(pos, "minecraft:structure_block", mode.serialized_name());
}

    /// The `mode` of the block state at `pos` (if it is `block`), set with
    /// `UPDATE_CLIENTS` and the block entity kept.
    // rust: pub(super) fn set_mode_property(&mut self, pos: Pos, block: &str, mode: &str) {
    // rust: let registry = self.pack.assets.registry;
    // rust: let current = registry.state(self.world.block(pos.0, pos.1, pos.2));
    // rust: let Some(current) = current.filter(|s| s.name == block) else {
    // rust: return;
}
    // rust: let mut wanted = current.clone();
    // rust: wanted.properties.insert("mode".into(), mode.to_owned());
    // rust: if wanted == *current {
    // rust: return;
}
    // rust: if let Ok(id) = registry.resolve(&wanted) {
            // The block entity stays through the state change.
    // rust: let entity = self.world.block_entities.take(&pos);
    // rust: let at = BlockPos::new(pos.0, pos.1, pos.2);
    // rust: self.with_level(|b, level, ticks| {
    // rust: b.set_block(level, ticks, at, id, flags::UPDATE_CLIENTS)
    // rust: });
    // rust: if let Some(entity) = entity {
    // rust: self.world.block_entities.put(pos, entity);
}
    // rust: let _ = self.process_level_events();
}
}

    /// `StructureBlock.trigger`.
pub fn trigger_structure_block(self: *Self, pos: Pos) void {
}
    // rust: let Some(mode) = self.structure_block_at(pos).map(|b| b.mode) else {
    // rust: return;
}
    // rust: match mode {
    // rust: StructureMode::Save => {
    // rust: self.save_structure(pos, false);
}
    // rust: StructureMode::Load => {
    // rust: if let Some(name) = self.structure_block_at(pos).and_then(|b| b.name.clone())
    // rust: && let Some(entry) = self.template_entry(&name)
    // rust: {
    // rust: self.place_structure(pos, &entry);
}
}
            // `unloadStructure`: the manager forgets it, the next use reads the file.
    // rust: StructureMode::Corner => {
    // rust: if let Some(name) = self.structure_block_at(pos).and_then(|b| b.name.clone()) {
    // rust: self.structure_templates.remove(&name);
}
}
    // rust: StructureMode::Data => {}
}
}

    /// `StructureBlock.neighborChanged` (the level's neighbour hook): a rising
    /// signal triggers the block once.
    // rust: pub(super) fn structure_block_neighbor_changed(&mut self, pos: Pos) {
    // rust: if self.structure_block_at(pos).is_none() {
    // rust: return;
}
    // rust: let at = BlockPos::new(pos.0, pos.1, pos.2);
    // rust: let signal = self.with_level(|b, level, ticks| b.has_neighbor_signal(level, ticks, at));
    // rust: let powered = self.structure_block_at(pos).is_some_and(|b| b.powered);
    // rust: if signal && !powered {
    // rust: if let Some(b) = self.structure_block_mut(pos) {
    // rust: b.powered = true;
}
    // rust: self.trigger_structure_block(pos);
    // rust: } else if !signal
    // rust: && powered
    // rust: && let Some(b) = self.structure_block_mut(pos)
    // rust: {
    // rust: b.powered = false;
}
}

    /// `ServerGamePacketListenerImpl.handleSetStructureBlock` for a guest:
    /// only a creative player with game master commands edits the block.
    // rust: pub(super) fn lan_set_structure_block(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: p: play::SetStructureBlock,
    // rust: ) {
    // rust: let Some(g) = host.hub.guest(conn) else {
    // rust: return;
}
    // rust: let allowed = g.creative() && g.permission >= 2;
    // rust: self.as_guest_messaged(host, conn, |game| {
    // rust: if allowed {
    // rust: game.apply_set_structure_block(&p);
}
    // rust: });
}

    /// What `handleSetStructureBlock` does once the player may edit blocks.
pub fn apply_set_structure_block(self: *Self, p: *play::SetStructureBlock) void {
}
    // rust: let pos = (p.pos[0], p.pos[1], p.pos[2]);
    // rust: if self.structure_block_at(pos).is_none() {
    // rust: return;
}
    // rust: let (Some(mode), Some(mirror), Some(rotation), Some(update)) = (
    // rust: StructureMode::from_ordinal(p.mode),
    // rust: structure_block::mirror_from_ordinal(p.mirror),
    // rust: structure_block::rotation_from_ordinal(p.rotation),
    // rust: UpdateType::from_ordinal(p.update_type),
    // rust: ) else {
    // rust: return;
}
    // rust: self.set_structure_mode(pos, mode);
    // rust: if let Some(b) = self.structure_block_mut(pos) {
    // rust: b.set_structure_name(&p.name);
    // rust: b.pos = p.offset;
    // rust: b.size = p.size;
    // rust: b.mirror = mirror;
    // rust: b.rotation = rotation;
    // rust: b.metadata = p.data.clone();
    // rust: b.ignore_entities = p.ignore_entities;
    // rust: b.strict = p.strict;
    // rust: b.show_air = p.show_air;
    // rust: b.show_bounding_box = p.show_bounding_box;
    // rust: b.integrity = p.integrity;
    // rust: b.seed = p.seed;
}
    // rust: let message = |key: &str, name: &str| Text::translate(key, &[Text::literal(name)]);
    // rust: match self.structure_block_at(pos).and_then(|b| b.name.clone()) {
    // rust: Some(name) => match update {
    // rust: UpdateType::SaveArea => {
    // rust: let saved = self
    // rust: .structure_block_at(pos)
    // rust: .is_some_and(|b| b.mode == StructureMode::Save)
    // rust: && self.save_structure(pos, true);
    // rust: let key = if saved {
    // rust: "structure_block.save_success"
    // rust: } else {
    // rust: "structure_block.save_failure"
}
    // rust: self.system_message(message(key, &name));
}
    // rust: UpdateType::LoadArea => {
    // rust: let key = if !self.structure_loadable(pos) {
    // rust: "structure_block.load_not_found"
    // rust: } else if self.place_structure_if_same_size(pos) {
    // rust: "structure_block.load_success"
    // rust: } else {
    // rust: "structure_block.load_prepare"
}
    // rust: self.system_message(message(key, &name));
}
    // rust: UpdateType::ScanArea => {
    // rust: if self.detect_structure_size(pos) {
    // rust: self.system_message(message("structure_block.size_success", &name));
    // rust: } else {
    // rust: self.system_message(Text::translate("structure_block.size_failure", &[]));
}
}
    // rust: UpdateType::UpdateData => {}
    // rust: },
    // rust: None => {
    // rust: self.system_message(message("structure_block.invalid_structure_name", &p.name));
}
}
        // `setChanged` and `sendBlockUpdated`: the clients get the new data.
    // rust: self.mark_block_entity_updated(pos);
}
}

/// The `StructurePlaceSettings` that `StructureBlockEntity.placeStructure`
/// and `PlaceCommand.placeTemplate` both build: mirror and rotation, the
/// known shape when strict, the integrity and seed that `place_template`
/// turns into `BlockRotProcessor` and `createRandom(seed)`, and the
/// `setBlock` flags `2 | (strict ? 816 : 0)`.
    // rust: pub(super) fn load_settings(
    // rust: mirror: horizon_world::worldgen::structure::Mirror,
    // rust: rotation: horizon_world::worldgen::structure::Rotation,
    // rust: integrity: f32,
    // rust: seed: i64,
    // rust: strict: bool,
    // rust: ) -> TemplateSettings {
    // rust: TemplateSettings {
    // rust: mirror,
    // rust: rotation,
    // rust: ignore_entities: false,
    // rust: known_shape: strict,
    // rust: integrity,
    // rust: seed: create_seed(seed),
    // rust: flags: flags::UPDATE_CLIENTS | if strict { 816 } else { 0 },
}
}

/// `StructureBlockEntity.createRandom`'s seed: 0 is the clock.
    // rust: pub(super) fn create_seed(seed: i64) -> i64 {
    // rust: if seed == 0 {
    // rust: std::time::SystemTime::now()
    // rust: .duration_since(std::time::UNIX_EPOCH)
    // rust: .map_or(1, |d| d.as_millis() as i64)
    // rust: } else {
    // rust: seed
}
}

    // rust: mod tests {
//     use super::*;

pub fn paths_must_stay_under_structures() void {
}
    // rust: assert!(portable_path("house/small"));
    // rust: assert!(!portable_path("../x"));
    // rust: assert!(!portable_path("a//b"));
    // rust: assert!(!portable_path("a/./b"));
    // rust: assert!(!portable_path(""));
}

pub fn template_size_reads_the_size_list() void {
}
    // rust: let tag = Tag::compound([(
    // rust: "size",
    // rust: Tag::List(vec![Tag::Int(3), Tag::Int(4), Tag::Int(5)]),
    // rust: )]);
    // rust: assert_eq!(template_size(&tag), [3, 4, 5]);
    // rust: assert_eq!(
    // rust: template_size(&Tag::compound(Vec::<(&str, Tag)>::new())),
    // rust: [0; 3]
    // rust: );
}

pub fn a_zero_seed_is_the_clock() void {
}
    // rust: assert_eq!(create_seed(42), 42);
    // rust: assert_ne!(create_seed(0), 0);
}

pub fn template_settings_are_flags_2_and_unknown_shape_unless_strict() void {
}
//         use horizon_world::worldgen::structure::{Mirror, Rotation};
    // rust: let loose = load_settings(Mirror::LeftRight, Rotation::Clockwise90, 0.5, 7, false);
    // rust: assert_eq!(loose.flags, 2);
    // rust: assert!(!loose.known_shape);
    // rust: assert!(!loose.ignore_entities);
    // rust: assert_eq!((loose.integrity, loose.seed), (0.5, 7));
    // rust: assert_eq!(
    // rust: (loose.mirror, loose.rotation),
    // rust: (Mirror::LeftRight, Rotation::Clockwise90)
    // rust: );
    // rust: let strict = load_settings(Mirror::None, Rotation::None, 1.0, 7, true);
    // rust: assert_eq!(strict.flags, 818);
    // rust: assert!(strict.known_shape);
}
}
