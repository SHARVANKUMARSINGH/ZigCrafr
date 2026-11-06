//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_connected
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! OptiFine connected textures (`optifine/ctm`) at mesh time. The active packs' rules are read
//! once at load, their tiles become sprite layers, and each block state and sprite layer gets
//! the short list of rules that can touch it; meshing a face then walks only those lists
//! ([`ConnectedTextures::pick`]). Without CTM files there are no rules and nothing changes.
//!
//! The rules and the tile geometry are `horizon_optifine::ctm`'s.

// use crate::sprites::Sprites;
// use horizon_optifine::ctm::{
    // rust: self, Connect, Method, Orient, Rule, Tile,
    // rust: connect::{self as geometry, Axes, Axis, Face},
}
// use horizon_world::block_state_properties::BlockProperties;
// use horizon_world::registry::{BlockRegistry, BlockStateId};
// use std::{collections::HashMap, path::Path};

/// A tile as the mesher draws it.
pub const TileLayer = enum {
    Layer {,
    layer: u16,
        /// The sprite has fractional alpha (drawn in the translucent pass).
    translucent: bool,
        /// Every texel is opaque (drawn without an alpha test).
    opaque: bool,
    // rust: },
    /// Try the next rule.
    Skip,
    /// The face's own sprite.
    Default,
};

/// What a face draws.
pub const Pick = enum {
    /// Its own sprite.
    Keep,
    Tile(TileLayer),
    /// `ctm_compact`: a tile per quarter of the sprite (top-left, top-right, bottom-left,
    /// bottom-right).
    Quarters([TileLayer; 4]),
    /// Nothing but its overlays: a Fusion face whose tile is empty, or of the overlay layout.
    Nothing,
};

/// A tile drawn over a face, after its own (`overlay*` methods).
pub const Overlay = struct {
    layer: u16,
    /// `layer=translucent`: drawn in the translucent pass, else with an alpha cutout.
    translucent: bool,
    /// `tintIndex` and the state whose tint it is (`tintBlock`, else the face's block).
    tint: Option<(i32,
};

pub const LoadedRule = struct {
    rule: Rule,
    tiles: std.ArrayList(TileLayer),
    overlay: OverlayJoin,
};

/// What an overlay rule joins: `connectBlocks` as state ids and `connectTiles` as sprite
/// layers (sorted), and its tint.
pub const OverlayJoin = struct {
    states: std.ArrayList(u32),
    tiles: std.ArrayList(u16),
    tint: Option<(i32,
};

    // rust: impl OverlayJoin {
pub fn any(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !self.states.is_empty() || !self.tiles.is_empty()
}
}

pub const StateInfo = struct {
    /// Index of the state's block (`connect=block`).
    block: u32,
    axis: ?Axis,
    /// `half=upper`: `linked` random tiles follow the lower half.
    upper: bool,
    /// A pane's arms (`north`, `east`, `south`, `west` true), as bits of [`ARMS`].
    arms: u8,
    /// Rules name the state or one of its sides' sprites ([`ConnectedTextures::stacked_pane_hides`]).
    has_rules: bool,
};

/// A pane's arm properties, in [`StateInfo::arms`]' bit order.
pub const ARMS: [[]const u8; 4] = ["north", "east", "south", "west"];

pub const ConnectedTextures = struct {
    rules: std.ArrayList(LoadedRule),
    /// By block state, then by sprite layer: ranges of `lists` (rule indices, in rule order).
    by_state: Vec<(u32,
    by_layer: Vec<(u32,
    lists: std.ArrayList(u16),
    states: std.ArrayList(StateInfo),
    /// By block state: the sprite of its model's face on each side (`connect=tile`); empty
    /// when no rule connects by tile.
    face_layers: Vec<[u16,
};

/// `list` appended to `lists`, as its range there.
pub fn push_list(lists: *mut std.ArrayList(u16), list: *[u16]) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let start = lists.len() as u32;
    // rust: lists.extend_from_slice(list);
    // rust: (start, list.len() as u32)
}

/// The sprite name of a texture resource path: `ns:path` under `textures/`, else the path
/// itself (as [`Sprites::insert_file`] names a tile).
pub fn sprite_name(resource: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let parts = resource
    // rust: .strip_prefix("assets/")
    // rust: .and_then(|p| p.split_once('/'))
    // rust: .and_then(|(ns, p)| Some((ns, p.strip_prefix("textures/")?.strip_suffix(".png")?)));
    // rust: match parts {
    // rust: Some((ns, path)) => format!("{ns}:{path}"),
    // rust: None => resource.to_owned(),
}
}

    // rust: impl ConnectedTextures {
    /// The rules under `root`, with their tiles inserted into `sprites` (before it finishes).
    /// `face_layer` answers a block state's sprite on a side, for rules that connect by tile.
    // rust: pub fn load(
    // rust: root: &Path,
    // rust: registry: &BlockRegistry,
    // rust: sprites: &mut Sprites,
    // rust: mut face_layer: impl FnMut(BlockStateId, Face) -> Option<u32>,
    // rust: ) -> Self {
    // rust: let mut rules = ctm::load(root);
        // Rules with a custom name load no tiles: section meshes see no block entity.
    // rust: rules.retain(|r| r.name.is_none());
        // Rule indices are `u16`.
    // rust: rules.truncate(usize::from(u16::MAX));
    // rust: if rules.is_empty() {
    // rust: return Self::default();
}
        // The tiles decode side by side; the loop below inserts them in rule order, under the
        // same names.
    // rust: let tiles: Vec<String> = rules
    // rust: .iter()
    // rust: .flat_map(|rule| &rule.tiles)
    // rust: .filter_map(|tile| match tile {
    // rust: Tile::Texture(path) => Some(sprite_name(path)),
    // rust: _ => None,
    // rust: })
    // rust: .collect();
    // rust: sprites.prefetch(root, tiles.iter().map(String::as_str));
    // rust: let loaded = rules
    // rust: .into_iter()
    // rust: .filter_map(|rule| {
    // rust: let tiles = rule
    // rust: .tiles
    // rust: .iter()
    // rust: .map(|tile| match tile {
    // rust: Tile::Skip => Ok(TileLayer::Skip),
    // rust: Tile::Default => Ok(TileLayer::Default),
    // rust: Tile::Texture(path) => {
                            // A tile among the textures is that sprite, under its own name.
    // rust: let layer = match sprite_name(path) {
    // rust: name if name != *path => sprites.insert(root, &name)?,
    // rust: _ => sprites.insert_file(root, path)?,
}
    // rust: Ok(TileLayer::Layer {
    // rust: layer: u16::try_from(layer)?,
    // rust: translucent: sprites.translucent[layer as usize],
    // rust: opaque: sprites.opaque[layer as usize],
    // rust: })
}
    // rust: })
    // rust: .collect::<crate::Result<Vec<_>>>();
    // rust: match tiles {
    // rust: Ok(tiles) => Some(LoadedRule {
    // rust: rule,
    // rust: tiles,
    // rust: overlay: OverlayJoin::default(),
    // rust: }),
    // rust: Err(e) => {
    // rust: log::warn!("Horizon: connected textures {}: a tile: {e}", rule.path);
    // rust: None
}
}
    // rust: })
    // rust: .collect();
    // rust: let states = (0..registry.len() as u32).map(|id| {
    // rust: registry
    // rust: .state(BlockStateId(id))
    // rust: .map(|s| (s.name.as_str(), &s.properties))
    // rust: });
    // rust: let mut out = Self::build(loaded, states, |name| sprites.layers.get(name).copied());
    // rust: if out
    // rust: .rules
    // rust: .iter()
    // rust: .any(|r| r.rule.connect == Connect::Tile || !r.overlay.tiles.is_empty())
    // rust: {
    // rust: out.face_layers = (0..registry.len() as u32)
    // rust: .map(|id| {
    // rust: Face::ALL
    // rust: .map(|f| face_layer(BlockStateId(id), f).map_or(u16::MAX, |l| l as u16))
    // rust: })
    // rust: .collect();
}
        // Panes whose sprites tile rules name (`matchTiles=glass`) are connected too, by a rule
        // that can draw on them: here, one naming no block (a rule naming the pane is in its
        // own list already).
    // rust: for id in (0..out.states.len()).filter(|_| !out.by_layer.is_empty()) {
    // rust: let pane = registry
    // rust: .state(BlockStateId(id as u32))
    // rust: .is_some_and(|s| s.name.ends_with("glass_pane"));
    // rust: if pane && !out.states[id].has_rules {
    // rust: out.states[id].has_rules = Face::ALL.into_iter().any(|f| {
    // rust: face_layer(BlockStateId(id as u32), f).is_some_and(|l| {
    // rust: out.list(&out.by_layer, l as usize)
    // rust: .iter()
    // rust: .any(|&i| out.rules[usize::from(i)].rule.match_blocks.is_empty())
    // rust: })
    // rust: });
}
}
    // rust: out
}

    /// The lookups for `rules` (already ordered) over every block state (`None` for an id the
    /// registry skips), `layer` answering a sprite name's layer.
    // rust: fn build<'a>(
    // rust: rules: Vec<LoadedRule>,
    // rust: states: impl Iterator<Item = Option<(&'a str, &'a BlockProperties)>>,
    // rust: layer: impl Fn(&str) -> Option<u32>,
    // rust: ) -> Self {
    // rust: let mut out = Self {
    // rust: rules,
    // rust: ..Self::default()
}
    // rust: let states: Vec<_> = states.collect();
        // Each block's states, for `connectBlocks` and `tintBlock`.
    // rust: let mut block_states: HashMap<&str, Vec<u32>> = HashMap::new();
    // rust: if out.rules.iter().any(|r| r.rule.method.is_overlay()) {
    // rust: for (id, state) in states.iter().enumerate() {
    // rust: if let Some((name, _)) = state {
    // rust: block_states.entry(name).or_default().push(id as u32);
}
}
}
    // rust: for r in out.rules.iter_mut().filter(|r| r.rule.method.is_overlay()) {
    // rust: let rule = &r.rule;
            // `connectBlocks` and `connectTiles` are "only for method overlay".
    // rust: if rule.method == Method::Overlay {
    // rust: for m in &rule.connect_blocks {
    // rust: let candidates = block_states
    // rust: .get(m.id.as_str())
    // rust: .map_or(&[][..], Vec::as_slice);
    // rust: r.overlay.states.extend(candidates.iter().filter(|&&id| {
    // rust: states[id as usize].is_some_and(|(name, props)| {
    // rust: m.matches(name, |k| props.get(k).map(String::as_str))
    // rust: })
    // rust: }));
}
    // rust: r.overlay.states.sort_unstable();
    // rust: r.overlay.states.dedup();
    // rust: r.overlay.tiles = rule
    // rust: .connect_tiles
    // rust: .iter()
    // rust: .filter_map(|t| layer(&sprite_name(t)).map(|l| l as u16))
    // rust: .collect();
    // rust: r.overlay.tiles.sort_unstable();
}
            // A `tintBlock` the game doesn't have tints nothing.
    // rust: let tint = match rule.tint_block.as_deref() {
    // rust: None => Some(None),
    // rust: Some(block) => block_states.get(block).map(|ids| Some(ids[0])),
}
    // rust: r.overlay.tint = tint
    // rust: .filter(|_| rule.tint_index >= 0)
    // rust: .map(|b| (rule.tint_index, b));
}
    // rust: let mut blocks = HashMap::new();
    // rust: let mut by_layer: Vec<Vec<u16>> = Vec::new();
        // Block rules by the block each entry names, so a state tests only its own.
    // rust: let mut by_block: HashMap<&str, Vec<u16>> = HashMap::new();
    // rust: for (i, r) in out.rules.iter().enumerate() {
    // rust: let i = i as u16;
    // rust: for tile in &r.rule.match_tiles {
    // rust: if let Some(l) = layer(&sprite_name(tile)) {
    // rust: let l = l as usize;
    // rust: if by_layer.len() <= l {
    // rust: by_layer.resize(l + 1, Vec::new());
}
    // rust: if by_layer[l].last() != Some(&i) {
    // rust: by_layer[l].push(i);
}
}
}
    // rust: for m in &r.rule.match_blocks {
    // rust: let list = by_block.entry(m.id.as_str()).or_default();
    // rust: if list.last() != Some(&i) {
    // rust: list.push(i);
}
}
}
    // rust: for list in by_layer {
    // rust: let range = push_list(&mut out.lists, &list);
    // rust: out.by_layer.push(range);
}
    // rust: let mut list = Vec::new();
    // rust: for state in states {
    // rust: let Some((name, props)) = state else {
    // rust: out.by_state.push((0, 0));
    // rust: out.states.push(StateInfo::default());
    // rust: continue;
}
    // rust: let next = blocks.len() as u32;
    // rust: let block = *blocks.entry(name).or_insert(next);
    // rust: let prop = |k: &str| props.get(k).map(String::as_str);
    // rust: out.states.push(StateInfo {
    // rust: block,
    // rust: axis: match prop("axis") {
    // rust: Some("x") => Some(Axis::X),
    // rust: Some("y") => Some(Axis::Y),
    // rust: Some("z") => Some(Axis::Z),
    // rust: _ => None,
    // rust: },
    // rust: upper: prop("half") == Some("upper"),
    // rust: arms: ARMS
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|&(_, arm)| prop(arm) == Some("true"))
    // rust: .fold(0, |bits, (i, _)| bits | 1 << i),
                // Set below, with the state's rule list.
    // rust: has_rules: false,
    // rust: });
    // rust: list.clear();
    // rust: if let Some(candidates) = by_block.get(name) {
    // rust: list.extend(
    // rust: candidates
    // rust: .iter()
    // rust: .filter(|&&i| out.rules[usize::from(i)].rule.matches_block(name, prop)),
    // rust: );
}
    // rust: out.states.last_mut().expect("pushed above").has_rules = !list.is_empty();
    // rust: let range = push_list(&mut out.lists, &list);
    // rust: out.by_state.push(range);
}
    // rust: out
}

pub fn is_empty(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.rules.is_empty()
}

    /// Whether a pane's top or bottom strip, centred at `centre` (block-local x, z), is hidden by
    /// the pane `other` stacked on it (Continuity's "Glass Pane Culling Fix"): only for a pane
    /// with connected-texture rules, under or over the same block, where `other` has the same
    /// part (the post, or the arm toward the strip).
pub fn stacked_pane_hides(self: *Self, state: u32, other: u32, z]: [f32; 2]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (Some(own), Some(theirs)) = (
    // rust: self.states.get(state as usize),
    // rust: self.states.get(other as usize),
    // rust: ) else {
    // rust: return false;
}
    // rust: if own.block != theirs.block || !own.has_rules {
    // rust: return false;
}
    // rust: let (dx, dz) = (x - 0.5, z - 0.5);
        // The post is 2 pixels wide; an arm runs from it to the block's edge.
    // rust: if dx.abs() <= 1.0 / 16.0 && dz.abs() <= 1.0 / 16.0 {
    // rust: return true;
}
    // rust: let arm = if dz.abs() > dx.abs() {
    // rust: if dz < 0.0 { 0 } else { 2 }
    // rust: } else if dx > 0.0 {
    // rust: 1
    // rust: } else {
    // rust: 3
}
    // rust: theirs.arms & 1 << arm != 0
}

pub fn list(self: *Self, ranges: *[(u32) void {
}
    // rust: ranges.get(i).map_or(&[], |&(start, len)| {
    // rust: &self.lists[start as usize..(start + len) as usize]
    // rust: })
}

    /// What the `face` of the block `state` at `pos` draws, for a quad with sprite `layer`.
    /// `neighbour` answers the state at an offset from the block; `biome` its biome, asked only
    /// by rules that test one; `texture` the quad's own texture directions, asked only by rules
    /// with `orient=texture`.
    // rust: pub fn pick<'b>(
    // rust: &self,
    // rust: state: u32,
    // rust: layer: u16,
    // rust: face: Face,
    // rust: pos: [i32; 3],
    // rust: neighbour: impl Fn([i32; 3]) -> u32,
    // rust: biome: impl Fn() -> Option<&'b str>,
    // rust: texture: impl Fn() -> Option<Axes>,
    // rust: mut overlay: impl FnMut(Overlay),
    // rust: ) -> Pick {
    // rust: let (mut by_state, mut by_layer) = (
    // rust: self.list(&self.by_state, state as usize),
    // rust: self.list(&self.by_layer, layer as usize),
    // rust: );
        // Both lists are in rule order: walk them as one. A rule naming blocks and tiles needs
        // both (it is in both lists); one naming either needs that one.
    // rust: loop {
    // rust: let (i, block, tile) = match (by_state.split_first(), by_layer.split_first()) {
    // rust: (None, None) => return Pick::Keep,
    // rust: (Some((&x, rest)), Some((&y, other))) if x == y => {
    // rust: (by_state, by_layer) = (rest, other);
    // rust: (x, true, true)
}
    // rust: (Some((&x, rest)), Some((&y, _))) if x < y => {
    // rust: by_state = rest;
    // rust: (x, true, false)
}
    // rust: (Some((&x, rest)), None) => {
    // rust: by_state = rest;
    // rust: (x, true, false)
}
    // rust: (_, Some((&y, rest))) => {
    // rust: by_layer = rest;
    // rust: (y, false, true)
}
}
    // rust: let r = &self.rules[usize::from(i)];
    // rust: if (block || r.rule.match_blocks.is_empty())
    // rust: && (tile || r.rule.match_tiles.is_empty())
    // rust: && let Some(pick) = self.apply(
    // rust: r,
    // rust: state,
    // rust: layer,
    // rust: face,
    // rust: pos,
    // rust: &neighbour,
    // rust: &biome,
    // rust: &texture,
    // rust: &mut overlay,
    // rust: )
    // rust: {
                // "Tiles output by CTM rules can also be matched by another rule": once, by the
                // tile rules naming the picked tile (and this block, if they name blocks).
                // A tile on the face's own sprite (`tiles=stone`) is no new tile.
    // rust: let Pick::Tile(TileLayer::Layer { layer: picked, .. }) = pick else {
    // rust: return pick;
}
    // rust: if picked == layer {
    // rust: return pick;
}
    // rust: let own = self.list(&self.by_state, state as usize);
                // Rules tried on the face's sprite already (those before this one) are not tried
                // again: an overlay would draw twice.
    // rust: let first = self.list(&self.by_layer, layer as usize);
    // rust: let again = self
    // rust: .list(&self.by_layer, picked as usize)
    // rust: .iter()
    // rust: .map(|&j| (j, &self.rules[usize::from(j)]))
    // rust: .filter(|&(j, r)| {
    // rust: j != i
    // rust: && !(j < i && first.contains(&j))
    // rust: && (r.rule.match_blocks.is_empty() || own.contains(&j))
    // rust: });
    // rust: for (_, r) in again {
                    // Joins by tile still compare the face's own sprite with its neighbours'.
    // rust: match self.apply(
    // rust: r,
    // rust: state,
    // rust: layer,
    // rust: face,
    // rust: pos,
    // rust: &neighbour,
    // rust: &biome,
    // rust: &texture,
    // rust: &mut overlay,
    // rust: ) {
    // rust: Some(Pick::Keep) => return pick,
    // rust: Some(chained) => return chained,
    // rust: None => {}
}
}
    // rust: return pick;
}
}
}

    /// One rule on a face: `None` when it doesn't apply, picks `<skip>` or draws an overlay
    /// (handed to `overlay`: the rules after it still choose the face's own sprite).
    // rust: fn apply<'b>(
    // rust: &self,
    // rust: r: &LoadedRule,
    // rust: state: u32,
    // rust: layer: u16,
    // rust: face: Face,
    // rust: pos: [i32; 3],
    // rust: neighbour: &impl Fn([i32; 3]) -> u32,
    // rust: biome: &impl Fn() -> Option<&'b str>,
    // rust: texture: &impl Fn() -> Option<Axes>,
    // rust: overlay: &mut impl FnMut(Overlay),
    // rust: ) -> Option<Pick> {
    // rust: let rule = &r.rule;
        // `Rule::applies_at`, with the biome looked up only for rules that test one. Rules with
        // a custom name are not loaded.
    // rust: if rule.faces & face.bit() == 0
    // rust: || rule.heights.as_ref().is_some_and(|h| !h.contains(pos[1]))
    // rust: {
    // rust: return None;
}
    // rust: if let Some(biomes) = &rule.biomes
    // rust: && !biome().is_some_and(|b| biomes.matches(b))
    // rust: {
    // rust: return None;
}
    // rust: let info = self.states.get(state as usize).copied().unwrap_or_default();
    // rust: let join = &r.overlay;
    // rust: let joins = |offset: [i32; 3]| {
    // rust: let other = neighbour(offset);
    // rust: if join.any() {
                // An overlay joins the blocks it is drawn beside.
    // rust: return join.states.binary_search(&other).is_ok()
    // rust: || self
    // rust: .face_layers
    // rust: .get(other as usize)
    // rust: .is_some_and(|f| join.tiles.binary_search(&f[face as usize]).is_ok());
}
    // rust: match rule.connect {
    // rust: Connect::Block => {
    // rust: self.states.get(other as usize).map(|s| s.block) == Some(info.block)
}
    // rust: Connect::State => other == state,
    // rust: Connect::Tile => self
    // rust: .face_layers
    // rust: .get(other as usize)
    // rust: .is_some_and(|f| f[face as usize] == layer),
}
}
    // rust: let axes = |face| match (rule.orient, info.axis) {
    // rust: (Orient::StateAxis, Some(axis)) => Axes::column(face, axis),
            // The quad's own texture directions, whatever face `symmetry` stands it for.
            // Not for `overlay`, which Continuity's `orient` leaves out: its 17 tiles always face
            // the standard way.
    // rust: (Orient::Texture, _) if rule.method != Method::Overlay => {
    // rust: texture().unwrap_or(Axes::cube(face))
}
    // rust: _ => Axes::cube(face),
}
    // rust: let mask = || geometry::neighbours(axes(face), face.normal(), rule.inner_seams, joins);
    // rust: let tile = |i: usize| r.tiles.get(i).copied().unwrap_or(TileLayer::Default);
    // rust: let mut draw = |t: TileLayer| {
    // rust: if let TileLayer::Layer { layer, .. } = t {
    // rust: overlay(Overlay {
    // rust: layer,
    // rust: translucent: rule.layer == ctm::Layer::Translucent,
    // rust: tint: join.tint,
    // rust: });
}
}
        // An overlay picks its tile as the method it is the overlay of.
    // rust: let method = match rule.method {
    // rust: Method::Overlay => {
                // The 17 transition tiles, toward the blocks it names (none: it draws nothing).
    // rust: if join.any() {
    // rust: let mask = geometry::neighbours(axes(face), face.normal(), false, joins);
    // rust: geometry::overlay_tiles(mask).for_each(|i| draw(tile(i)));
}
    // rust: return None;
}
    // rust: Method::OverlayCtm => Method::Ctm,
    // rust: Method::OverlayRandom => Method::Random,
    // rust: Method::OverlayRepeat => Method::Repeat,
    // rust: Method::OverlayFixed => Method::Fixed,
    // rust: Method::OverlayHorizontal => Method::Horizontal,
    // rust: Method::OverlayVertical => Method::Vertical,
    // rust: Method::OverlayHorizontalVertical => Method::HorizontalVertical,
    // rust: Method::OverlayVerticalHorizontal => Method::VerticalHorizontal,
    // rust: m => m,
}
    // rust: let index = match method {
    // rust: Method::Ctm => geometry::ctm_index(mask()),
    // rust: Method::CtmCompact => {
    // rust: let mask = mask();
    // rust: let case = geometry::ctm_index(mask) as u8;
    // rust: match rule.compact_overrides.iter().find(|&&(c, _)| c == case) {
    // rust: Some(&(_, t)) => t,
    // rust: None => {
    // rust: let quarters = geometry::compact_quarters(mask).map(|q| tile(q.into()));
    // rust: return if quarters.contains(&TileLayer::Skip) {
    // rust: None
    // rust: } else {
    // rust: Some(Pick::Quarters(quarters))
}
}
}
}
    // rust: Method::Horizontal => geometry::horizontal(mask()),
    // rust: Method::Vertical => geometry::vertical(mask()),
    // rust: Method::HorizontalVertical => geometry::horizontal_vertical(mask()),
    // rust: Method::VerticalHorizontal => geometry::vertical_horizontal(mask()),
    // rust: Method::Top => {
                // Only sides join the block above: the top and bottom go on to the next rule.
    // rust: if matches!(face, Face::Up | Face::Down) {
    // rust: return None;
}
    // rust: if !joins([0, 1, 0]) {
    // rust: return Some(Pick::Keep);
}
    // rust: 0
}
    // rust: Method::Fixed => 0,
    // rust: Method::Random => {
    // rust: let face = geometry::symmetric_face(face, rule.symmetry);
    // rust: let pos = if rule.linked && info.upper {
    // rust: [pos[0], pos[1] - 1, pos[2]]
    // rust: } else {
    // rust: pos
}
    // rust: geometry::random_index(pos, face, rule.random_loops, &rule.weights, r.tiles.len())
}
    // rust: Method::Repeat => {
    // rust: let face = geometry::symmetric_face(face, rule.symmetry);
    // rust: geometry::repeat_index(pos, axes(face), rule.width, rule.height)
}
            // Every overlay was mapped to its method above.
    // rust: _ => return None,
}
    // rust: if rule.method.is_overlay() {
    // rust: draw(tile(index));
    // rust: return None;
}
    // rust: match tile(index) {
    // rust: TileLayer::Skip => None,
    // rust: TileLayer::Default => Some(Pick::Keep),
    // rust: t => Some(Pick::Tile(t)),
}
}
}

    // rust: mod tests {
//     use super::*;
//     use horizon_optifine::Properties;

    /// A tile whose layer says which tile of its rule it is: rule `r`'s tile `i` is layer
    /// `1000 * (r + 1) + i`.
pub fn rules(files: *[([]const u8) void {
}
    // rust: let mut rules: Vec<Rule> = files
    // rust: .iter()
    // rust: .map(|(path, text)| {
    // rust: Rule::parse(
    // rust: &format!("assets/minecraft/optifine/ctm/{path}"),
    // rust: &Properties::parse(text),
    // rust: )
    // rust: .unwrap()
    // rust: .unwrap()
    // rust: })
    // rust: .collect();
    // rust: ctm::sort(&mut rules);
    // rust: rules
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: .map(|(n, rule)| LoadedRule {
    // rust: overlay: OverlayJoin::default(),
    // rust: tiles: rule
    // rust: .tiles
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, t)| match t {
    // rust: Tile::Skip => TileLayer::Skip,
    // rust: Tile::Default => TileLayer::Default,
    // rust: Tile::Texture(_) => TileLayer::Layer {
    // rust: layer: (1000 * (n + 1) + i) as u16,
    // rust: translucent: false,
    // rust: opaque: false,
    // rust: },
    // rust: })
    // rust: .collect(),
    // rust: rule,
    // rust: })
    // rust: .collect()
}

    /// State 0 air, 1 glass, 2 stone, 3 and 4 oak logs (axis y, x), 5 and 6 a door (lower,
    /// upper); the stone sprite is layer 7, glass 3.
pub fn world(files: *[([]const u8) void {
}
    // rust: let props = |pairs: &[(&str, &str)]| -> BlockProperties {
    // rust: pairs
    // rust: .iter()
    // rust: .map(|(k, v)| (k.to_string(), v.to_string()))
    // rust: .collect()
}
    // rust: let states = [
    // rust: ("minecraft:air", props(&[])),
    // rust: ("minecraft:glass", props(&[])),
    // rust: ("minecraft:stone", props(&[])),
    // rust: ("minecraft:oak_log", props(&[("axis", "y")])),
    // rust: ("minecraft:oak_log", props(&[("axis", "x")])),
    // rust: ("minecraft:oak_door", props(&[("half", "lower")])),
    // rust: ("minecraft:oak_door", props(&[("half", "upper")])),
    // rust: ];
    // rust: ConnectedTextures::build(
    // rust: rules(files),
    // rust: states.iter().map(|(n, p)| Some((*n, p))),
    // rust: |name| match name {
    // rust: "minecraft:block/stone" => Some(7),
    // rust: "minecraft:block/glass" => Some(3),
                // The tile `b0` of a rule second in order (`a_picked_tile_can_be_picked_again`).
    // rust: "assets/minecraft/optifine/ctm/b0.png" => Some(2000),
                // And `a0` of the first rule.
    // rust: "assets/minecraft/optifine/ctm/a0.png" => Some(1000),
    // rust: _ => None,
    // rust: },
    // rust: )
}

pub fn tile(layer: u16) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Pick::Tile(TileLayer::Layer {
    // rust: layer,
    // rust: translucent: false,
    // rust: opaque: false,
    // rust: })
}

    /// `pick` on `face` of the block at the origin among `blocks` (offset, state).
    // rust: fn pick_in(
    // rust: ctm: &ConnectedTextures,
    // rust: state: u32,
    // rust: layer: u16,
    // rust: face: Face,
    // rust: blocks: &[([i32; 3], u32)],
    // rust: ) -> Pick {
    // rust: let at = |o: [i32; 3]| blocks.iter().find(|(p, _)| *p == o).map_or(0, |b| b.1);
    // rust: ctm.pick(state, layer, face, [0, 64, 0], at, || None, || None, |_| {})
}

pub const GLASS: []const u8 = "matchBlocks=glass\nmethod=ctm\ntiles=0-46";

pub fn glass_joins_its_neighbours() void {
}
    // rust: let ctm = world(&[("glass.properties", GLASS)]);
        // Alone: tile 0. A north face's right is west: glass there is the left end of a row.
    // rust: assert_eq!(pick_in(&ctm, 1, 3, Face::North, &[]), tile(1000));
    // rust: assert_eq!(
    // rust: pick_in(&ctm, 1, 3, Face::North, &[([-1, 0, 0], 1)]),
    // rust: tile(1001)
    // rust: );
        // Glass all around in the face's plane: the middle tile, 26.
    // rust: let ring: Vec<_> = [-1, 0, 1]
    // rust: .into_iter()
    // rust: .flat_map(|x| [-1, 0, 1].map(|y| ([x, y, 0], 1)))
    // rust: .collect();
    // rust: assert_eq!(pick_in(&ctm, 1, 3, Face::North, &ring), tile(1026));
        // Stone beside it doesn't join; stone has no rule.
    // rust: assert_eq!(
    // rust: pick_in(&ctm, 1, 3, Face::North, &[([-1, 0, 0], 2)]),
    // rust: tile(1000)
    // rust: );
    // rust: assert_eq!(pick_in(&ctm, 2, 7, Face::North, &[]), Pick::Keep);
}

pub fn rule_order_faces_and_skips() void {
}
    // rust: let ctm = world(&[
    // rust: (
    // rust: "a_sides.properties",
    // rust: "matchBlocks=stone\nmethod=fixed\ntiles=<skip>\nfaces=sides",
    // rust: ),
    // rust: ("b_glass.properties", GLASS),
    // rust: ("stone.properties", "method=fixed\ntiles=x\nfaces=top"),
    // rust: ("z.properties", "matchBlocks=stone\nmethod=fixed\ntiles=y"),
    // rust: ]);
        // The tile rule (stone.properties, by its file name) comes first, on the top face only.
    // rust: assert_eq!(pick_in(&ctm, 2, 7, Face::Up, &[]), tile(1000));
        // Sides: a_sides skips, so z draws.
    // rust: assert_eq!(pick_in(&ctm, 2, 7, Face::North, &[]), tile(4000));
        // The tile rule follows the sprite, whatever the block: glass with the stone sprite.
    // rust: assert_eq!(pick_in(&ctm, 1, 7, Face::Up, &[]), tile(1000));
}

pub fn compact_quarters_and_overrides() void {
}
    // rust: let ctm = world(&[(
    // rust: "glass.properties",
    // rust: "matchBlocks=glass\nmethod=ctm_compact\ntiles=0-5\nctm.1=5",
    // rust: )]);
    // rust: let layer = |i: u16| TileLayer::Layer {
    // rust: layer: 1000 + i,
    // rust: translucent: false,
    // rust: opaque: false,
}
    // rust: assert_eq!(
    // rust: pick_in(&ctm, 1, 3, Face::North, &[]),
    // rust: Pick::Quarters([layer(0); 4])
    // rust: );
        // Joined right only is case 1, replaced whole by tile 5.
    // rust: assert_eq!(
    // rust: pick_in(&ctm, 1, 3, Face::North, &[([-1, 0, 0], 1)]),
    // rust: tile(1005)
    // rust: );
        // Joined left only (east of a north face): quarters [3, 0, 3, 0].
    // rust: assert_eq!(
    // rust: pick_in(&ctm, 1, 3, Face::North, &[([1, 0, 0], 1)]),
    // rust: Pick::Quarters([layer(3), layer(0), layer(3), layer(0)])
    // rust: );
}

pub fn logs_turn_with_their_axis() void {
}
    // rust: let ctm = world(&[(
    // rust: "log.properties",
    // rust: "matchBlocks=oak_log\nmethod=vertical\ntiles=0-3",
    // rust: )]);
        // An upright log with a log above: the bottom of a column.
    // rust: assert_eq!(
    // rust: pick_in(&ctm, 3, 3, Face::North, &[([0, 1, 0], 3)]),
    // rust: tile(1000)
    // rust: );
        // A log lying along x: on its north face the texture's up points east, so a log to the
        // east (same block, other axis state) is above it.
    // rust: assert_eq!(
    // rust: pick_in(&ctm, 4, 3, Face::North, &[([1, 0, 0], 4)]),
    // rust: tile(1000)
    // rust: );
    // rust: assert_eq!(
    // rust: pick_in(&ctm, 4, 3, Face::North, &[([0, 1, 0], 4)]),
    // rust: tile(1003)
    // rust: );
}

pub fn top_and_connect_state() void {
}
    // rust: let ctm = world(&[(
    // rust: "block_oak_log.properties",
    // rust: "method=top\ntiles=0\nconnect=state",
    // rust: )]);
    // rust: assert_eq!(
    // rust: pick_in(&ctm, 3, 3, Face::North, &[([0, 1, 0], 3)]),
    // rust: tile(1000)
    // rust: );
        // The other axis is another state.
    // rust: assert_eq!(
    // rust: pick_in(&ctm, 3, 3, Face::North, &[([0, 1, 0], 4)]),
    // rust: Pick::Keep
    // rust: );
    // rust: assert_eq!(pick_in(&ctm, 3, 3, Face::Up, &[([0, 1, 0], 3)]), Pick::Keep);
}

pub fn linked_random_follows_the_lower_half() void {
}
    // rust: let ctm = world(&[(
    // rust: "door.properties",
    // rust: "matchBlocks=oak_door\nmethod=random\ntiles=0-7\nlinked=true",
    // rust: )]);
    // rust: let mut tiles = std::collections::HashSet::new();
    // rust: for x in 0..20 {
    // rust: let lower = ctm.pick(
    // rust: 5,
    // rust: 3,
    // rust: Face::North,
    // rust: [x, 64, 0],
    // rust: |_| 0,
    // rust: || None,
    // rust: || None,
    // rust: |_| {},
    // rust: );
    // rust: let upper = ctm.pick(
    // rust: 6,
    // rust: 3,
    // rust: Face::North,
    // rust: [x, 65, 0],
    // rust: |_| 0,
    // rust: || None,
    // rust: || None,
    // rust: |_| {},
    // rust: );
    // rust: assert_eq!(lower, upper, "{x}");
    // rust: tiles.insert(format!("{lower:?}"));
}
    // rust: assert!(tiles.len() > 3, "the doors are not all alike");
}

pub fn heights_and_biomes() void {
}
    // rust: let ctm = world(&[(
    // rust: "glass.properties",
    // rust: "matchBlocks=glass\nmethod=fixed\ntiles=0\nheights=0-63\nbiomes=desert",
    // rust: )]);
    // rust: let at = |y, biome: &'static str| {
    // rust: ctm.pick(
    // rust: 1,
    // rust: 3,
    // rust: Face::Up,
    // rust: [0, y, 0],
    // rust: |_| 0,
    // rust: || Some(biome),
    // rust: || None,
    // rust: |_| {},
    // rust: )
}
    // rust: assert_eq!(at(10, "minecraft:desert"), tile(1000));
    // rust: assert_eq!(at(64, "minecraft:desert"), Pick::Keep);
    // rust: assert_eq!(at(10, "minecraft:plains"), Pick::Keep);
}

pub fn connect_by_tile_reads_the_neighbours_same_side() void {
}
    // rust: let mut ctm = world(&[(
    // rust: "glass.properties",
    // rust: "matchBlocks=glass\nmethod=horizontal\nconnect=tile\ntiles=0-3",
    // rust: )]);
        // Stone shows the glass sprite (3) on its north side; the door only on its south.
    // rust: let mut faces = vec![[9u16; 6]; 7];
    // rust: faces[1][Face::North as usize] = 3;
    // rust: faces[2][Face::North as usize] = 3;
    // rust: faces[5][Face::South as usize] = 3;
    // rust: ctm.face_layers = faces;
    // rust: assert_eq!(
    // rust: pick_in(&ctm, 1, 3, Face::North, &[([-1, 0, 0], 2)]),
    // rust: tile(1000)
    // rust: );
    // rust: assert_eq!(
    // rust: pick_in(&ctm, 1, 3, Face::North, &[([-1, 0, 0], 5)]),
    // rust: tile(1003)
    // rust: );
}

pub fn repeat_and_rows_then_columns() void {
}
    // rust: let ctm = world(&[(
    // rust: "glass.properties",
    // rust: "matchBlocks=glass\nmethod=repeat\nwidth=2\nheight=2\ntiles=0-3",
    // rust: )]);
    // rust: let at = |pos| ctm.pick(1, 3, Face::North, pos, |_| 0, || None, || None, |_| {});
    // rust: assert_eq!(at([0, 64, 0]), tile(1000));
        // The north face's right is west; rows run down.
    // rust: assert_eq!(at([-1, 64, 0]), tile(1001));
    // rust: assert_eq!(at([0, 63, 0]), tile(1002));
    // rust: let hv = world(&[(
    // rust: "glass.properties",
    // rust: "matchBlocks=glass\nmethod=horizontal+vertical\ntiles=0-6",
    // rust: )]);
        // Alone in its row, glass above: the column's bottom, tile 4.
    // rust: assert_eq!(
    // rust: pick_in(&hv, 1, 3, Face::North, &[([0, 1, 0], 1)]),
    // rust: tile(1004)
    // rust: );
    // rust: assert_eq!(
    // rust: pick_in(&hv, 1, 3, Face::North, &[([-1, 0, 0], 1)]),
    // rust: tile(1000)
    // rust: );
}

pub fn skips_defaults_and_narrowed_rules() void {
}
    // rust: let ctm = world(&[
    // rust: (
    // rust: "a.properties",
    // rust: "matchBlocks=glass\nmethod=ctm_compact\ntiles=<skip> 1-4",
    // rust: ),
    // rust: (
    // rust: "b.properties",
    // rust: "matchBlocks=glass\nmethod=fixed\ntiles=0\nfaces=sides",
    // rust: ),
    // rust: (
    // rust: "c.properties",
    // rust: "matchBlocks=glass\nmethod=fixed\ntiles=<default>",
    // rust: ),
    // rust: ("d.properties", "matchBlocks=glass\nmethod=fixed\ntiles=0"),
    // rust: (
    // rust: "e.properties",
    // rust: "matchBlocks=stone\nmatchTiles=glass_pane_top\nmethod=fixed\ntiles=0",
    // rust: ),
    // rust: ]);
        // e names a tile, so it is tried first (tile 1000s), but needs a stone with the pane
        // sprite. a's skipped quarter drops it; b (3000s) draws the sides; on top c draws the
        // glass itself, which stops d.
    // rust: assert_eq!(pick_in(&ctm, 1, 3, Face::North, &[]), tile(3000));
    // rust: assert_eq!(pick_in(&ctm, 1, 3, Face::Up, &[]), Pick::Keep);
    // rust: assert_eq!(pick_in(&ctm, 2, 7, Face::Up, &[]), Pick::Keep);
    // rust: let both = world(&[(
    // rust: "e.properties",
    // rust: "matchBlocks=glass\nmatchTiles=stone\nmethod=fixed\ntiles=0",
    // rust: )]);
    // rust: assert_eq!(pick_in(&both, 1, 7, Face::Up, &[]), tile(1000));
    // rust: assert_eq!(pick_in(&both, 1, 3, Face::Up, &[]), Pick::Keep);
    // rust: assert_eq!(pick_in(&both, 2, 7, Face::Up, &[]), Pick::Keep);
        // `top` passes the top face on.
    // rust: let top = world(&[
    // rust: ("block_glass.properties", "method=top\ntiles=0"),
    // rust: (
    // rust: "z.properties",
    // rust: "matchBlocks=glass\nmethod=fixed\ntiles=0\nfaces=top",
    // rust: ),
    // rust: ]);
    // rust: assert_eq!(pick_in(&top, 1, 3, Face::Up, &[]), tile(2000));
}

    /// The overlays `pick` hands out, with what it picks for the face itself.
    // rust: fn overlays_in(
    // rust: ctm: &ConnectedTextures,
    // rust: state: u32,
    // rust: face: Face,
    // rust: blocks: &[([i32; 3], u32)],
    // rust: ) -> (Vec<u16>, Pick) {
    // rust: let at = |o: [i32; 3]| blocks.iter().find(|(p, _)| *p == o).map_or(0, |b| b.1);
    // rust: let mut out = Vec::new();
    // rust: let pick = ctm.pick(
    // rust: state,
    // rust: 3,
    // rust: face,
    // rust: [0, 64, 0],
    // rust: at,
    // rust: || None,
    // rust: || None,
    // rust: |o| out.push(o.layer),
    // rust: );
    // rust: (out, pick)
}

pub fn overlays_draw_toward_the_blocks_they_name() void {
}
        // Stone gets glass's edge where glass is beside it; then a fixed tile for the stone.
    // rust: let ctm = world(&[
    // rust: (
    // rust: "a_overlay.properties",
    // rust: "matchBlocks=stone\nmethod=overlay\nconnectBlocks=glass\ntiles=0-16\ntintIndex=0\ntintBlock=oak_log",
    // rust: ),
    // rust: ("b.properties", "matchBlocks=stone\nmethod=fixed\ntiles=0"),
    // rust: ]);
        // Nothing beside: no overlay, and b draws.
    // rust: assert_eq!(overlays_in(&ctm, 2, Face::Up, &[]), (vec![], tile(2000)));
        // Glass to the north of a top face (its texture's up): tile 15. Glass east and west
        // too: one tile for the three sides, 13.
    // rust: assert_eq!(overlays_in(&ctm, 2, Face::Up, &[([0, 0, -1], 1)]).0, [1015]);
    // rust: let three = [([0, 0, -1], 1), ([1, 0, 0], 1), ([-1, 0, 0], 1)];
    // rust: assert_eq!(overlays_in(&ctm, 2, Face::Up, &three).0, [1013]);
        // Glass only at the north-east corner: the corner tile, 14.
    // rust: assert_eq!(overlays_in(&ctm, 2, Face::Up, &[([1, 0, -1], 1)]).0, [1014]);
        // Stone beside stone draws nothing.
    // rust: assert_eq!(
    // rust: overlays_in(&ctm, 2, Face::Up, &[([0, 0, -1], 2)]).0,
    // rust: [0u16; 0]
    // rust: );
    // rust: let mut tint = None;
    // rust: ctm.pick(
    // rust: 2,
    // rust: 3,
    // rust: Face::Up,
    // rust: [0, 64, 0],
    // rust: |o| if o == [0, 0, -1] { 1 } else { 0 },
    // rust: || None,
    // rust: || None,
    // rust: |o| {
    // rust: tint = Some((o.tint, o.translucent));
    // rust: },
    // rust: );
    // rust: assert_eq!(
    // rust: tint,
    // rust: Some((Some((0, Some(3))), false)),
    // rust: "oak_log's first state is 3"
    // rust: );
}

pub fn overlay_joins_layers_and_tints() void {
}
    // rust: let mut ctm = world(&[
    // rust: (
    // rust: "a.properties",
    // rust: "matchBlocks=stone\nmethod=overlay\nconnectTiles=glass\ntiles=0-16\nlayer=translucent\ntintIndex=0\ntintBlock=no_such_block",
    // rust: ),
    // rust: (
    // rust: "b.properties",
    // rust: "matchBlocks=glass\nmethod=overlay_ctm\nconnectBlocks=stone\ntiles=0-46",
    // rust: ),
    // rust: ]);
        // connectTiles joins neighbours showing a named sprite on the same side: the door to the
        // north shows glass (sprite 3) on top.
    // rust: let mut faces = vec![[9u16; 6]; 7];
    // rust: faces[5][Face::Up as usize] = 3;
    // rust: ctm.face_layers = faces;
    // rust: let mut got = Vec::new();
    // rust: let door_north = |o: [i32; 3]| if o == [0, 0, -1] { 5 } else { 0 };
    // rust: ctm.pick(
    // rust: 2,
    // rust: 7,
    // rust: Face::Up,
    // rust: [0, 64, 0],
    // rust: door_north,
    // rust: || None,
    // rust: || None,
    // rust: |o| got.push(o),
    // rust: );
    // rust: assert_eq!(
    // rust: got,
    // rust: [Overlay {
    // rust: layer: 1015,
    // rust: translucent: true,
                // A tintBlock the game lacks tints nothing.
    // rust: tint: None,
    // rust: }]
    // rust: );
        // connectBlocks is only for `overlay`: overlay_ctm joins glass by `connect`, not stone.
    // rust: let (layers, _) = overlays_in(&ctm, 1, Face::North, &[([-1, 0, 0], 2)]);
    // rust: assert_eq!(layers, [2000]);
    // rust: let (layers, _) = overlays_in(&ctm, 1, Face::North, &[([-1, 0, 0], 1)]);
    // rust: assert_eq!(layers, [2001]);
}

pub fn overlay_methods_pick_like_their_own() void {
}
    // rust: let ctm = world(&[
    // rust: (
    // rust: "a.properties",
    // rust: "matchBlocks=glass\nmethod=overlay_ctm\ntiles=0-46\nlayer=translucent",
    // rust: ),
    // rust: (
    // rust: "b.properties",
    // rust: "matchBlocks=glass\nmethod=overlay_fixed\ntiles=<skip>",
    // rust: ),
    // rust: (
    // rust: "c.properties",
    // rust: "matchBlocks=glass\nmethod=overlay_fixed\ntiles=0",
    // rust: ),
    // rust: ]);
        // overlay_ctm joins glass (connect=block): the left end of a row, tile 1; b's <skip>
        // draws nothing; c draws; the face keeps its own sprite.
    // rust: let (layers, pick) = overlays_in(&ctm, 1, Face::North, &[([-1, 0, 0], 1)]);
    // rust: assert_eq!((layers, pick), (vec![1001, 3000], Pick::Keep));
}

pub fn a_picked_tile_can_be_picked_again() void {
}
        // b (rule 1) gives glass its tile b0, layer 2000; t (rule 0, a tile rule, tried first)
        // names that tile, so it draws in b0's place.
    // rust: let chain = |t: &str| {
    // rust: world(&[
    // rust: ("b.properties", "matchBlocks=glass\nmethod=fixed\ntiles=b0"),
    // rust: ("t.properties", t),
    // rust: ])
}
    // rust: let ctm = chain("matchTiles=optifine/ctm/b0.png\nmethod=fixed\ntiles=0");
    // rust: assert_eq!(pick_in(&ctm, 1, 3, Face::Up, &[]), tile(1000));
        // A chained rule keeping the tile (<default>) leaves b's.
    // rust: let ctm = chain("matchTiles=optifine/ctm/b0.png\nmethod=fixed\ntiles=<default>");
    // rust: assert_eq!(pick_in(&ctm, 1, 3, Face::Up, &[]), tile(2000));
        // One that names another block doesn't chain on glass.
    // rust: let ctm = chain("matchTiles=optifine/ctm/b0.png\nmatchBlocks=stone\nmethod=fixed\ntiles=0");
    // rust: assert_eq!(pick_in(&ctm, 1, 3, Face::Up, &[]), tile(2000));
        // An overlay tried on the face's own sprite and on the picked tile draws once.
    // rust: let ctm = chain("matchTiles=glass optifine/ctm/b0.png\nmethod=overlay_fixed\ntiles=0");
    // rust: let (overlays, pick) = overlays_in(&ctm, 1, Face::Up, &[]);
    // rust: assert_eq!((overlays, pick), (vec![1000], tile(2000)));
        // A rule after the one that picked, naming both the face's sprite and the tile, wasn't
        // tried: it chains.
    // rust: let ctm = world(&[
    // rust: ("a.properties", "matchTiles=glass\nmethod=fixed\ntiles=a0"),
    // rust: (
    // rust: "c.properties",
    // rust: "matchTiles=glass optifine/ctm/a0.png\nmethod=fixed\ntiles=0",
    // rust: ),
    // rust: ]);
    // rust: assert_eq!(pick_in(&ctm, 1, 3, Face::Up, &[]), tile(2000));
}

pub fn orient_texture_follows_the_quads_uvs() void {
}
    // rust: let rule = |orient: &str| {
    // rust: world(&[(
    // rust: "glass.properties",
    // rust: &*format!("matchBlocks=glass\nmethod=horizontal\ntiles=0-3\norient={orient}"),
    // rust: )])
}
        // A mirrored north face (a vanilla pane's): its texture's right is east.
    // rust: let mirrored = || {
    // rust: Some(Axes {
    // rust: right: [1, 0, 0],
    // rust: up: [0, 1, 0],
    // rust: })
}
    // rust: let east = |o: [i32; 3]| if o == [1, 0, 0] { 1 } else { 0 };
    // rust: let at = |ctm: &ConnectedTextures| {
    // rust: ctm.pick(
    // rust: 1,
    // rust: 3,
    // rust: Face::North,
    // rust: [0, 64, 0],
    // rust: east,
    // rust: || None,
    // rust: mirrored,
    // rust: |_| {},
    // rust: )
}
        // Glass to the east is to the texture's right: the row's left end.
    // rust: assert_eq!(at(&rule("texture")), tile(1000));
        // By the cube's directions it is to the left: the row's right end.
    // rust: assert_eq!(at(&rule("none")), tile(1002));
        // A plain overlay keeps the standard directions: glass north of a top face is above it
        // (tile 15) whatever the quad's texture says.
    // rust: let overlay = world(&[(
    // rust: "a.properties",
    // rust: "matchBlocks=stone\nmethod=overlay\nconnectBlocks=glass\ntiles=0-16\norient=texture",
    // rust: )]);
    // rust: let turned = || {
    // rust: Some(Axes {
    // rust: right: [0, 0, 1],
    // rust: up: [1, 0, 0],
    // rust: })
}
    // rust: let north = |o: [i32; 3]| if o == [0, 0, -1] { 1 } else { 0 };
    // rust: let mut got = Vec::new();
    // rust: overlay.pick(
    // rust: 2,
    // rust: 7,
    // rust: Face::Up,
    // rust: [0, 64, 0],
    // rust: north,
    // rust: || None,
    // rust: turned,
    // rust: |o| got.push(o.layer),
    // rust: );
    // rust: assert_eq!(got, [1015]);
}

pub fn stacked_panes_hide_the_strips_they_share() void {
}
    // rust: let props = |pairs: &[(&str, &str)]| -> BlockProperties {
    // rust: pairs
    // rust: .iter()
    // rust: .map(|(k, v)| (k.to_string(), v.to_string()))
    // rust: .collect()
}
        // 0 a pane with north and east arms, 1 the same pane with only a north arm, 2 another
        // pane block, 3 a pane no rule names.
    // rust: let states = [
    // rust: (
    // rust: "minecraft:glass_pane",
    // rust: props(&[("north", "true"), ("east", "true")]),
    // rust: ),
    // rust: ("minecraft:glass_pane", props(&[("north", "true")])),
    // rust: (
    // rust: "minecraft:white_stained_glass_pane",
    // rust: props(&[("north", "true")]),
    // rust: ),
    // rust: ("minecraft:iron_bars", props(&[("north", "true")])),
    // rust: ];
    // rust: let ctm = ConnectedTextures::build(
    // rust: rules(&[(
    // rust: "pane.properties",
    // rust: "matchBlocks=glass_pane white_stained_glass_pane\nmethod=ctm\ntiles=0-46",
    // rust: )]),
    // rust: states.iter().map(|(n, p)| Some((*n, p))),
    // rust: |_| None,
    // rust: );
    // rust: let (post, north, east) = ([0.5, 0.5], [0.5, 0.2], [0.8, 0.5]);
    // rust: assert!(ctm.stacked_pane_hides(0, 1, post));
    // rust: assert!(ctm.stacked_pane_hides(0, 1, north));
        // The pane above has no east arm: the strip shows; one with it hides it.
    // rust: assert!(!ctm.stacked_pane_hides(0, 1, east));
    // rust: assert!(ctm.stacked_pane_hides(1, 0, east));
    // rust: let (south, west) = ([0.5, 0.8], [0.2, 0.5]);
    // rust: assert!(!ctm.stacked_pane_hides(1, 0, south));
    // rust: assert!(!ctm.stacked_pane_hides(1, 0, west));
    // rust: assert!(ctm.stacked_pane_hides(1, 0, north));
        // Another block, or a pane without rules, hides nothing.
    // rust: assert!(!ctm.stacked_pane_hides(1, 2, post));
    // rust: assert!(!ctm.stacked_pane_hides(3, 3, post));
}

pub fn sprite_names() void {
}
    // rust: assert_eq!(
    // rust: sprite_name("assets/minecraft/textures/block/dirt.png"),
    // rust: "minecraft:block/dirt"
    // rust: );
    // rust: assert_eq!(
    // rust: sprite_name("assets/minecraft/optifine/ctm/glass/0.png"),
    // rust: "assets/minecraft/optifine/ctm/glass/0.png"
    // rust: );
}
}
