//! Transpiled from Horizon Rust crate
//! Module: horizon-items_blocks
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Per-state gameplay facts exported from vanilla's own block-state accessors
//! (`gameplay-facts.json`), indexed by registry state ID.
    // rust: mod decode;
// use crate::Result;
// use horizon_world::{
    // rust: level::{Behaviours, GameplayStateSource},
    // rust: registry::{BlockRegistry, BlockStateId},
}
// use serde_json::Value;
// use std::{collections::HashMap, path::Path, sync::Arc};

pub const RenderShape = enum {
    Model,
    Invisible,
    Animated,
};
pub const Fluid = enum {
    None,
    Water,
    Lava,
};
pub const Sounds = struct {
    volume: f32,
    pitch: f32,
    break_sound: *str,
    step: *str,
    place: *str,
    hit: *str,
    fall: *str,
};
pub const StateFacts = struct {
    name: *str,
    emission: u8,
    dampening: u8,
    skylight_down: bool,
    shape_occlusion: bool,
    can_occlude: bool,
    solid_render: bool,
    hardness: f32,
    requires_tool: bool,
    replaceable: bool,
    random_ticks: bool,
    block_entity: bool,
    render_shape: RenderShape,
    full_collision: bool,
    friction: f32,
    explosion_resistance: f32,
    item: *str,
    sounds: Sounds,
    fluid: Fluid,
    /// Fluid amount 1..=8 (8 = source/falling surface), 0 when there is no fluid.
    fluid_level: u8,
    fluid_falling: bool,
    waterlogged: bool,
    /// `hasOffsetFunction`: the model is jittered per column.
    random_offset: bool,
    /// Whether the outline, not just the model, follows BlockState.getOffset.
    outline_offset: bool,
    /// `BlockState.isSolid()` (legacy solidity; fluid surfaces read it).
    legacy_solid: bool,
    /// `isFaceSturdy(.., SupportType.FULL)` by Direction ordinal.
    sturdy_full: u8,
    /// The block's class chain (`TransparentBlock`, `LeavesBlock`, ...), most specific first.
    classes: *[Arc<str]>,
    /// `getShape` (the outline used for picking) as boxes in block space,
    /// without the random offset; and its edges as LevelRenderer draws them.
    outline: Arc<[[f64,
    outline_edges: Arc<[[f64,
    /// `getMapColor(..).id` (0 = NONE).
    map_color: u8,
};
/// `MapColor.col` by id.
    // rust: pub const MAP_COLORS: [u32; 62] = [
    // rust: 0, 8368696, 16247203, 13092807, 16711680, 10526975, 10987431, 31744, 16777215, 10791096,
    // rust: 9923917, 7368816, 4210943, 9402184, 16776437, 14188339, 11685080, 6724056, 15066419, 8375321,
    // rust: 15892389, 5000268, 10066329, 5013401, 8339378, 3361970, 6704179, 6717235, 10040115, 1644825,
    // rust: 16445005, 6085589, 4882687, 55610, 8476209, 7340544, 13742497, 10441252, 9787244, 7367818,
    // rust: 12223780, 6780213, 10505550, 3746083, 8874850, 5725276, 8014168, 4996700, 4993571, 5001770,
    // rust: 9321518, 2430480, 12398641, 9715553, 6035741, 1474182, 3837580, 5647422, 1356933, 6579300,
    // rust: 14200723, 8365974,
    // rust: ];
/// The 12 edges of the unit cube (outline data predating the export).
pub fn cube_edges() V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut edges = Vec::new();
    // rust: for a in 0..3 {
    // rust: for (u, v) in [(0., 0.), (1., 0.), (0., 1.), (1., 1.)] {
    // rust: let mut from = [0.0f64; 3];
    // rust: let (b, c) = ((a + 1) % 3, (a + 2) % 3);
    // rust: from[b] = u;
    // rust: from[c] = v;
    // rust: let mut to = from;
    // rust: to[a] = 1.0;
    // rust: edges.push([from[0], from[1], from[2], to[0], to[1], to[2]]);
}
}
    // rust: edges
}
/// Which of the four `SignBlock` subclasses a block is.
pub const SignForm = struct {
    /// `CeilingHangingSignBlock` or `WallHangingSignBlock`.
    hanging: bool,
    /// `WallSignBlock` or `WallHangingSignBlock`.
    wall: bool,
};
    // rust: impl SignForm {
    /// The block entity type its `newBlockEntity` makes.
pub fn block_entity_type(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.hanging {
    // rust: "minecraft:hanging_sign"
    // rust: } else {
    // rust: "minecraft:sign"
}
}
}
    // rust: impl StateFacts {
pub fn has_class(self: *Self, name: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.classes.iter().any(|c| &**c == name)
}
    /// A `SignBlock`'s form, by class: a mod's sign has its template's,
    /// whatever its name.
pub fn sign_form(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.has_class("SignBlock").then(|| SignForm {
    // rust: hanging: self.has_class("CeilingHangingSignBlock")
    // rust: || self.has_class("WallHangingSignBlock"),
    // rust: wall: self.has_class("WallSignBlock") || self.has_class("WallHangingSignBlock"),
    // rust: })
}
}
/// Compact, owned behaviour inputs retained until the normal behaviour startup stage.
/// No borrowed gameplay JSON or process-wide cache survives the fact loader.
pub const GameplayProjection = struct {
    flags: u16,
    emission: u64,
    dampening: u64,
    hardness: f64,
    push: *str,
    volume: f64,
    pitch: f64,
    place: *str,
    break_sound: *str,
    fall: *str,
};

    // rust: impl GameplayProjection {
pub fn from_entry(entry: *decode::Entry<'_>, strings: *mut HashMap<[]const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
pub fn intern(strings: *mut HashMap<[]const u8, value: []const u8) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(existing) = strings.get(value) {
    // rust: return Arc::clone(existing);
}
    // rust: let value_arc: Arc<str> = Arc::from(value);
    // rust: strings.insert(value.to_owned(), Arc::clone(&value_arc));
    // rust: value_arc
}
    // rust: const FLAGS: [&str; 11] = [
    // rust: "replaceable",
    // rust: "random_ticks",
    // rust: "solid_render",
    // rust: "liquid",
    // rust: "block_entity",
    // rust: "ignited_by_lava",
    // rust: "can_occlude",
    // rust: "full_collision",
    // rust: "skylight_down",
    // rust: "requires_tool",
    // rust: "shape_occlusion",
    // rust: ];
    // rust: Self {
    // rust: flags: FLAGS.iter().enumerate().fold(0, |flags, (i, name)| {
    // rust: flags | ((u16::from(entry.flag(name))) << i)
    // rust: }),
    // rust: emission: entry.unsigned("emission"),
    // rust: dampening: entry.unsigned("dampening"),
    // rust: hardness: entry.number("hardness"),
    // rust: push: intern(strings, entry.text("push")),
    // rust: volume: entry.sound_number("volume"),
    // rust: pitch: entry.sound_number("pitch"),
    // rust: place: intern(strings, entry.sound_id("place")),
    // rust: break_sound: intern(strings, entry.sound_id("break")),
    // rust: fall: intern(strings, entry.sound_id("fall")),
}
}
}

    // rust: impl GameplayStateSource for GameplayProjection {
pub fn flag(self: *Self, name: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: const FLAGS: [&str; 11] = [
    // rust: "replaceable",
    // rust: "random_ticks",
    // rust: "solid_render",
    // rust: "liquid",
    // rust: "block_entity",
    // rust: "ignited_by_lava",
    // rust: "can_occlude",
    // rust: "full_collision",
    // rust: "skylight_down",
    // rust: "requires_tool",
    // rust: "shape_occlusion",
    // rust: ];
    // rust: FLAGS
    // rust: .iter()
    // rust: .position(|field| *field == name)
    // rust: .is_some_and(|index| self.flags & (1 << index) != 0)
}
pub fn unsigned(self: *Self, name: []const u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match name {
    // rust: "emission" => self.emission,
    // rust: "dampening" => self.dampening,
    // rust: _ => 0,
}
}
pub fn number(self: *Self, name: []const u8) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if name == "hardness" {
    // rust: self.hardness
    // rust: } else {
    // rust: 0.0
}
}
pub fn text(self: *Self, name: []const u8) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if name == "push" { &self.push } else { "" }
}
pub fn sound_number(self: *Self, name: []const u8) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match name {
    // rust: "volume" => self.volume,
    // rust: "pitch" => self.pitch,
    // rust: _ => 1.0,
}
}
pub fn sound_id(self: *Self, name: []const u8) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match name {
    // rust: "place" => &self.place,
    // rust: "break" => &self.break_sound,
    // rust: "fall" => &self.fall,
    // rust: _ => "",
}
}
}

pub const BlockFacts = struct {
    states: std.ArrayList(StateFacts),
    air: BlockStateId,
    /// Each sign block's `SignBlock.getWoodType` name.
    woods: HashMap<*str,
};
    // rust: impl BlockFacts {
pub fn load(root: *Path, registry: *BlockRegistry) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let behaviours: Value =
    // rust: horizon_world::json_file::read(&root.join("block-behaviours.json"))?;
    // rust: Self::load_with_behaviour_json(root, registry, &behaviours)
}

    /// Load both tables from one resource root, sharing each JSON decode.
    /// No data is cached across calls: changes to prepared packs or mods are read again.
pub fn load_pair(root: *Path, registry: *BlockRegistry) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let behaviours: Value =
    // rust: horizon_world::json_file::read(&root.join("block-behaviours.json"))?;
    // rust: Self::load_with_behaviours(root, registry, &behaviours)
}

    /// Decode state facts once, retaining only the small owned fields needed later.
    /// `parallel`: the JSON validation pass may run on a thread of its own.
    // rust: pub fn load_with_projection(
    // rust: root: &Path,
    // rust: registry: &BlockRegistry,
    // rust: behaviours: &Value,
    // rust: parallel: bool,
    // rust: ) -> Result<(Self, Vec<GameplayProjection>)> {
    // rust: Self::load_with_callback(root, registry, behaviours, parallel, |entries| {
    // rust: let mut strings = HashMap::new();
    // rust: Ok(entries
    // rust: .iter()
    // rust: .map(|entry| GameplayProjection::from_entry(entry, &mut strings))
    // rust: .collect())
    // rust: })
}

    // rust: pub fn load_with_behaviour_json(
    // rust: root: &Path,
    // rust: registry: &BlockRegistry,
    // rust: behaviours: &Value,
    // rust: ) -> Result<Self> {
    // rust: Ok(Self::load_with_callback(root, registry, behaviours, true, |_| Ok(()))?.0)
}

    /// Build both tables from the same behaviour document and gameplay decoder.
    // rust: pub fn load_with_behaviours(
    // rust: root: &Path,
    // rust: registry: &BlockRegistry,
    // rust: behaviours: &Value,
    // rust: ) -> Result<(Self, Behaviours)> {
    // rust: Self::load_with_callback(root, registry, behaviours, true, |entries| {
    // rust: Ok(Behaviours::load_with_gameplay(
    // rust: registry, root, behaviours, entries,
    // rust: )?)
    // rust: })
}

    // rust: fn load_with_callback<T>(
    // rust: root: &Path,
    // rust: registry: &BlockRegistry,
    // rust: behaviours: &Value,
    // rust: parallel: bool,
    // rust: callback: impl FnOnce(&[decode::Entry<'_>]) -> Result<T>,
    // rust: ) -> Result<(Self, T)> {
    // rust: let path = root.join("gameplay-facts.json");
    // rust: let bytes = horizon_world::json_file::read_bytes(&path)?;
    // rust: let validate =
    // rust: || horizon_world::json_file::parse::<decode::Validate>(&path, &bytes).map(drop);
    // rust: if !parallel {
    // rust: validate()?;
    // rust: return Self::decode_with_callback(&path, &bytes, registry, behaviours, callback);
}
        // The validation pass (a third of the load) only reports errors: it
        // reads the file beside the decode, and its error still wins.
    // rust: std::thread::scope(|scope| {
    // rust: let validated = scope.spawn(validate);
    // rust: let decoded = Self::decode_with_callback(&path, &bytes, registry, behaviours, callback);
    // rust: validated
    // rust: .join()
    // rust: .unwrap_or_else(|panic| std::panic::resume_unwind(panic))?;
    // rust: decoded
    // rust: })
}

    // rust: fn decode_with_callback<T>(
    // rust: path: &Path,
    // rust: bytes: &[u8],
    // rust: registry: &BlockRegistry,
    // rust: behaviours: &Value,
    // rust: callback: impl FnOnce(&[decode::Entry<'_>]) -> Result<T>,
    // rust: ) -> Result<(Self, T)> {
    // rust: let raw: decode::Gameplay<'_> = horizon_world::json_file::parse(path, bytes)?;
    // rust: let entries = raw
    // rust: .states
    // rust: .0
    // rust: .as_ref()
    // rust: .ok_or("missing gameplay state facts")?;
    // rust: if entries.len() != registry.len() {
    // rust: return Err("gameplay facts do not match the block registry".into());
}
        // Class chains and per-state behaviour flags exported from the actual block objects.
    // rust: let behaviour_states = behaviours["states"]
    // rust: .as_array()
    // rust: .filter(|s| s.len() == registry.len())
    // rust: .ok_or("block behaviour facts do not match the block registry")?;
    // rust: let mut class_names: HashMap<String, Arc<str>> = HashMap::new();
    // rust: let classes: HashMap<&str, Arc<[Arc<str>]>> = behaviours["blocks"]
    // rust: .as_array()
    // rust: .ok_or("missing block behaviour classes")?
    // rust: .iter()
    // rust: .filter_map(|b| {
    // rust: let chain = b["class"]
    // rust: .as_array()?
    // rust: .iter()
    // rust: .filter_map(Value::as_str)
    // rust: .map(|c| {
    // rust: class_names
    // rust: .entry(c.to_owned())
    // rust: .or_insert_with(|| Arc::from(c))
    // rust: .clone()
    // rust: });
    // rust: Some((b["name"].as_str()?, chain.collect()))
    // rust: })
    // rust: .collect();
    // rust: let woods = behaviours["blocks"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter(|b| {
    // rust: b["class"]
    // rust: .as_array()
    // rust: .is_some_and(|chain| chain.iter().any(|c| c == "SignBlock"))
    // rust: })
    // rust: .filter_map(|b| {
    // rust: Some((
    // rust: Arc::from(b["name"].as_str()?),
    // rust: Arc::from(b["fields"]["type"]["name"].as_str()?),
    // rust: ))
    // rust: })
    // rust: .collect();
    // rust: let mut names: HashMap<String, Arc<str>> = HashMap::new();
    // rust: let mut intern = |s: &str| -> Arc<str> {
    // rust: if let Some(name) = names.get(s) {
    // rust: return name.clone();
}
    // rust: let name: Arc<str> = Arc::from(s);
    // rust: names.insert(s.to_owned(), name.clone());
    // rust: name
}
    // rust: let mut shapes = decode::Shapes::default();
    // rust: let mut states = Vec::with_capacity(entries.len());
    // rust: for (index, entry) in entries.iter().enumerate() {
    // rust: let id = BlockStateId(index as u32);
    // rust: if entry.id != Some(index as u64) {
    // rust: return Err("gameplay facts are not in registry order".into());
}
    // rust: let state = registry.state(id).ok_or("missing registry state")?;
    // rust: let sound = &entry.sound;
    // rust: let prop = |k: &str| state.properties.get(k).map(String::as_str);
    // rust: let (fluid, fluid_level, fluid_falling) = match state.name.as_str() {
    // rust: "minecraft:water" | "minecraft:lava" => {
    // rust: let level: u8 = prop("level").and_then(|v| v.parse().ok()).unwrap_or(0);
    // rust: let kind = if state.name == "minecraft:water" {
    // rust: Fluid::Water
    // rust: } else {
    // rust: Fluid::Lava
}
                    // LiquidBlock: level 0 is the source; 1..7 flowing; >=8 falling.
    // rust: if level == 0 {
    // rust: (kind, 8, false)
    // rust: } else if level >= 8 {
    // rust: (kind, 8, true)
    // rust: } else {
    // rust: (kind, 8 - level, false)
}
}
    // rust: "minecraft:bubble_column"
    // rust: | "minecraft:kelp"
    // rust: | "minecraft:kelp_plant"
    // rust: | "minecraft:seagrass"
    // rust: | "minecraft:tall_seagrass" => (Fluid::Water, 8, false),
    // rust: _ if prop("waterlogged") == Some("true") => (Fluid::Water, 8, false),
    // rust: _ => (Fluid::None, 0, false),
}
    // rust: let air = matches!(
    // rust: state.name.as_str(),
    // rust: "minecraft:air" | "minecraft:cave_air" | "minecraft:void_air"
    // rust: );
    // rust: let cube = move || {
    // rust: if air {
    // rust: Vec::new()
    // rust: } else {
    // rust: vec![[0.0, 0.0, 0.0, 1.0, 1.0, 1.0]]
}
}
    // rust: let edges = move || if air { Vec::new() } else { cube_edges() };
    // rust: let outline = shapes.intern(entry.outline, cube)?;
    // rust: let outline_edges = shapes.intern(entry.outline_edges, edges)?;
            // The export holds MapColor.col; ids are positions in MAP_COLORS.
    // rust: let col = entry.map_color.unwrap_or(0) as u32;
    // rust: let map_color = if col == 0 {
    // rust: 0
    // rust: } else {
    // rust: MAP_COLORS.iter().position(|c| *c == col).unwrap_or(0) as u8
}
    // rust: states.push(StateFacts {
    // rust: map_color,
    // rust: outline,
    // rust: outline_edges,
    // rust: name: intern(&state.name),
    // rust: emission: entry.emission.as_f64().unwrap_or(0.0) as u8,
    // rust: dampening: entry.dampening.as_f64().unwrap_or(0.0) as u8,
    // rust: skylight_down: entry.skylight_down,
    // rust: shape_occlusion: entry.shape_occlusion,
    // rust: can_occlude: entry.can_occlude,
    // rust: solid_render: entry.solid_render,
    // rust: hardness: entry.hardness.as_f64().unwrap_or(0.0) as f32,
    // rust: requires_tool: entry.requires_tool,
    // rust: replaceable: entry.replaceable,
    // rust: random_ticks: entry.random_ticks,
    // rust: block_entity: entry.block_entity,
    // rust: render_shape: match entry.render_shape.as_deref() {
    // rust: Some("INVISIBLE") => RenderShape::Invisible,
    // rust: Some("ENTITYBLOCK_ANIMATED") => RenderShape::Animated,
    // rust: _ => RenderShape::Model,
    // rust: },
    // rust: full_collision: entry.full_collision,
    // rust: friction: entry.friction as f32,
    // rust: explosion_resistance: entry.explosion_resistance as f32,
    // rust: item: intern(entry.item.as_deref().unwrap_or("minecraft:air")),
    // rust: sounds: Sounds {
    // rust: volume: sound.volume as f32,
    // rust: pitch: sound.pitch as f32,
    // rust: break_sound: intern(sound.r#break.id.as_deref().unwrap_or("")),
    // rust: step: intern(sound.step.id.as_deref().unwrap_or("")),
    // rust: place: intern(sound.place.id.as_deref().unwrap_or("")),
    // rust: hit: intern(sound.hit.id.as_deref().unwrap_or("")),
    // rust: fall: intern(sound.fall.id.as_deref().unwrap_or("")),
    // rust: },
    // rust: fluid,
    // rust: fluid_level,
    // rust: fluid_falling,
    // rust: waterlogged: prop("waterlogged") == Some("true"),
    // rust: random_offset: entry.offset,
    // rust: outline_offset: entry.outline_offset.unwrap_or(entry.offset),
    // rust: legacy_solid: behaviour_states[index][1].as_u64().unwrap_or(0) & 1 != 0,
    // rust: sturdy_full: (behaviour_states[index][0].as_u64().unwrap_or(0) & 63) as u8,
    // rust: classes: classes
    // rust: .get(state.name.as_str())
    // rust: .cloned()
    // rust: .ok_or("missing block behaviour class chain")?,
    // rust: });
}
    // rust: let extra = callback(entries)?;
    // rust: Ok((
    // rust: Self {
    // rust: states,
    // rust: air: registry
    // rust: .default_state("minecraft:air")
    // rust: .ok_or("missing air")?,
    // rust: woods,
    // rust: },
    // rust: extra,
    // rust: ))
}
    /// A state the registry doesn't have (a server with mods we lack sent it)
    /// has air's facts.
pub fn get(self: *Self, id: BlockStateId) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.states
    // rust: .get(id.0 as usize)
    // rust: .unwrap_or_else(|| &self.states[self.air.0 as usize])
}
    /// `SignBlock.getWoodType`'s name for a sign block.
pub fn wood_type(self: *Self, block: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.woods.get(block).map(|wood| &**wood)
}
pub fn is_air(self: *Self, id: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(
    // rust: &*self.get(id).name,
    // rust: "minecraft:air" | "minecraft:cave_air" | "minecraft:void_air"
    // rust: )
}
}

    // rust: impl GameplayStateSource for decode::Entry<'_> {
pub fn flag(self: *Self, name: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match name {
    // rust: "replaceable" => self.replaceable,
    // rust: "random_ticks" => self.random_ticks,
    // rust: "solid_render" => self.solid_render,
    // rust: "liquid" => self.liquid,
    // rust: "block_entity" => self.block_entity,
    // rust: "ignited_by_lava" => self.ignited_by_lava,
    // rust: "can_occlude" => self.can_occlude,
    // rust: "full_collision" => self.full_collision,
    // rust: "skylight_down" => self.skylight_down,
    // rust: "requires_tool" => self.requires_tool,
    // rust: "shape_occlusion" => self.shape_occlusion,
    // rust: _ => false,
}
}
pub fn unsigned(self: *Self, name: []const u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match name {
    // rust: "emission" => self.emission.as_u64().unwrap_or(0),
    // rust: "dampening" => self.dampening.as_u64().unwrap_or(0),
    // rust: _ => 0,
}
}
pub fn number(self: *Self, name: []const u8) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match name {
    // rust: "hardness" => self.hardness.as_f64().unwrap_or(0.0),
    // rust: _ => 0.0,
}
}
pub fn text(self: *Self, name: []const u8) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match name {
    // rust: "push" => self.push.as_deref().unwrap_or(""),
    // rust: _ => "",
}
}
pub fn sound_number(self: *Self, name: []const u8) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match name {
    // rust: "volume" => self.sound.volume,
    // rust: "pitch" => self.sound.pitch,
    // rust: _ => 1.0,
}
}
pub fn sound_id(self: *Self, name: []const u8) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match name {
    // rust: "place" => self.sound.place.id.as_deref().unwrap_or(""),
    // rust: "break" => self.sound.r#break.id.as_deref().unwrap_or(""),
    // rust: "fall" => self.sound.fall.id.as_deref().unwrap_or(""),
    // rust: _ => "",
}
}
}
