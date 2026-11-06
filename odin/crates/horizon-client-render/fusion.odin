//! Transpiled from Horizon Rust crate
package horizon_client_render_fusion

import "core:fmt"
import "core:mem"
import "core:math"

// Fusion connected textures at mesh time. A pack's connecting textures (a `fusion` section in
// their `.mcmeta`) are cut into a sprite per tile at load, and every baked face of a
// `fusion:connecting` model that shows one is given the rule it joins by: the sheet and its
// predicates, with their blocks resolved to state ids. Meshing such a face evaluates them in
// the face's eight directions and draws the layout's tiles through [`crate::connected`]'s
// [`Pick`] and [`Overlay`]. Without Fusion files nothing is loaded and nothing changes.
//
// Directions follow a cube's default UVs ([`Axes::cube`]): the top and bottom of a model
// turned about x, or turned with `uvlock`, join a quarter turn off.
//
// The format is `horizon_optifine::fusion`'s.

// use crate::connected::{Overlay, Pick, TileLayer};
// use crate::models::StateModels;
// use crate::sprites::Sprites;
// use horizon_optifine::cem::json::Json;
// use horizon_optifine::ctm::connect::{self, Axes, Face};
// use horizon_optifine::fusion::{
    // rust: Connection, Layout, Tiles,
    // rust: model::{Connections, ModelType},
    // rust: predicate::Query,
    // rust: texture::{Kind, Meta},
}
// use horizon_world::block_state_properties::BlockProperties;
// use horizon_world::registry::{BlockRegistry, BlockStateId};
// use std::{
    // rust: collections::HashMap,
    // rust: fs,
    // rust: num::NonZeroU16,
    // rust: path::{Path, PathBuf},
}

// A connecting texture as drawn: its layout and its tiles, `None` for an empty one.
Sheet :: struct {
    layout: Layout,
    tiles: [dynamic]Maybe(TileLayer),
}

// A sheet and what it joins by, blocks as sorted state ids.
Rule :: struct {
    sheet: uint,
    connection: Connection<[dynamic]u32>,
}

FusionTextures :: struct {
    sheets: [dynamic]Sheet,
    // By [`crate::models::BakedFace::fusion`].
    rules: [dynamic]Rule,
    // Each state's block, for `is_same_block` (`u32::MAX` for an id the registry skips).
    blocks: [dynamic]u32,
}

// A model's reference to a texture or another model (`block/glass`), namespaced.
namespaced :: proc(reference: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: horizon_optifine::matchers::namespaced(reference)
}

read_model :: proc(root: ^Path, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let (ns, path) = name.split_once(':')?;
    // rust: let text = horizon_core::prepared_files::read_to_string(
    // rust: &root.join(format!("assets/{ns}/models/{path}.json")),
    // rust: )
    // rust: .ok()?;
    // rust: Json::parse(&text).ok()
}

// What a model's face draws and joins by: its sprite, its side in the model, and its
// predicates (`None`: the texture's own).
    // rust: type ModelFace = (String, Face, Option<Connection>);

// Of a `fusion:connecting` model: each face's [`ModelFace`]. Empty for any other model.
connecting_model :: proc(root: ^Path, name: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let Some(model) = read_model(root, name) else {
    // rust: return Vec::new();
}
    // rust: if ModelType::of(&model) != Some(ModelType::Connecting) {
    // rust: return Vec::new();
}
    // Its parents, up to one without a file (`builtin/generated`); deeper than vanilla's few
    // levels is a loop.
    // rust: let mut chain = vec![model];
    // rust: while chain.len() < 16
    // rust: && let Some(parent) = chain.last().and_then(|m| m.get("parent")?.as_str())
    // rust: && let Some(parent) = read_model(root, &namespaced(parent))
    // rust: {
    // rust: chain.push(parent);
}
    // Parents first, so a child's keys replace theirs.
    // rust: let mut connections = Connections::Textures;
    // rust: let mut textures: HashMap<&str, &str> = HashMap::new();
    // rust: for model in chain.iter().rev() {
    // rust: match Connections::of(model) {
    // rust: Ok(own) => connections = own.inherit(&connections),
    // rust: Err(e) => log::warn!("Horizon: Fusion model {name}: {e}"),
}
    // rust: for (key, value) in model
    // rust: .get("textures")
    // rust: .and_then(Json::as_object)
    // rust: .unwrap_or(&[])
    // rust: {
            // A sprite, or an object naming one (`{"sprite": ..., "force_translucent": true}`).
    // rust: let value = value.as_str().or_else(|| value.get("sprite")?.as_str());
    // rust: if let Some(value) = value {
    // rust: textures.insert(key.as_str(), value);
}
}
}
    // A `#key` as vanilla resolves it.
    // rust: let resolve = |reference: &str| {
    // rust: let mut value = reference;
    // rust: for _ in 0..16 {
    // rust: match value.strip_prefix('#') {
    // rust: Some(key) => value = textures.get(key)?,
    // rust: None => return Some(namespaced(value)),
}
}
    // rust: None
}
    // The elements are the nearest model's that has some.
    // rust: let elements = chain
    // rust: .iter()
    // rust: .find_map(|m| m.get("elements")?.as_array())
    // rust: .unwrap_or(&[]);
    // rust: let mut out: Vec<ModelFace> = Vec::new();
    // rust: let faces = elements
    // rust: .iter()
    // rust: .filter_map(|e| e.get("faces")?.as_object())
    // rust: .flatten();
    // rust: for (side, face) in faces {
    // rust: let side = match side.as_str() {
    // rust: "down" => Face::Down,
    // rust: "up" => Face::Up,
    // rust: "north" => Face::North,
    // rust: "south" => Face::South,
    // rust: "west" => Face::West,
    // rust: "east" => Face::East,
    // rust: _ => continue,
}
    // rust: let Some(texture) = face.get("texture").and_then(Json::as_str) else {
    // rust: continue;
}
    // rust: let Some(sprite) = resolve(texture) else {
    // rust: continue;
}
    // rust: if !out.iter().any(|(s, f, _)| *s == sprite && *f == side) {
    // rust: let key = face.get("connections").and_then(Json::as_str);
    // rust: out.push((sprite, side, connections.for_face(key, texture).cloned()));
}
}
    // rust: out
}

// Where a model's `face` points once a blockstate turns it `x`, then `y` quarter turns.
turned :: proc(face: Face, _]: [u8; 3]) -> F {
    // Ported from Horizon
    return {}
}
    // rust: let mut n = face.normal();
    // rust: for _ in 0..x % 4 {
        // x=90 takes up to north.
    // rust: n = [n[0], n[2], -n[1]];
}
    // rust: for _ in 0..y % 4 {
        // y=90 takes north to east.
    // rust: n = [-n[2], n[1], n[0]];
}
    // rust: Face::ALL
    // rust: .into_iter()
    // rust: .find(|f| f.normal() == n)
    // rust: .expect("a quarter turn maps faces onto faces")
}

// The connecting textures under `root`, by sprite name.
connecting_textures :: proc(root: ^Path) -> H {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = HashMap::new();
    // rust: let Ok(namespaces) = fs::read_dir(root.join("assets")) else {
    // rust: return out;
}
    // rust: for ns in namespaces.flatten() {
    // rust: let ns_name = ns.file_name().to_string_lossy().into_owned();
    // rust: let textures = ns.path().join("textures");
    // rust: for path in mcmeta_files(&textures) {
    // rust: let Some(png) = path.to_str().and_then(|p| p.strip_suffix(".png.mcmeta")) else {
    // rust: continue;
}
    // rust: let Ok(text) = horizon_core::prepared_files::read_to_string(&path) else {
    // rust: continue;
}
    // rust: if !text.contains("fusion") {
    // rust: continue;
}
    // rust: let Some(rel) = Path::new(png)
    // rust: .strip_prefix(&textures)
    // rust: .ok()
    // rust: .and_then(|p| p.to_str())
    // rust: else {
    // rust: continue;
}
    // rust: let name = format!("{ns_name}:{}", rel.replace('\\', "/"));
    // rust: match Meta::from_mcmeta(&text) {
    // rust: Ok(Some(meta)) => {
    // rust: out.insert(name, meta);
}
    // rust: Ok(None) => {}
    // rust: Err(e) => log::warn!("Horizon: Fusion texture {name}: {e}"),
}
}
}
    // rust: out
}

// The `.png.mcmeta` files under `textures`: a prepared root's from its data file, others
// from the folders (linked folders too: mods' content links into the packs' tree).
mcmeta_files :: proc(textures: ^Path) -> V {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(files) = horizon_core::prepared_files::files_under(textures) {
    // rust: return files
    // rust: .iter()
    // rust: .filter(|file| file.ends_with(".png.mcmeta"))
    // rust: .map(|file| textures.join(file))
    // rust: .collect();
}
    // rust: let mut out = Vec::new();
    // rust: let mut dirs = vec![textures.to_owned()];
    // rust: while let Some(dir) = dirs.pop() {
    // rust: for entry in fs::read_dir(&dir).into_iter().flatten().flatten() {
    // rust: let path = entry.path();
    // rust: let dir = match entry.file_type() {
    // rust: Ok(t) if t.is_symlink() => path.is_dir(),
    // rust: Ok(t) => t.is_dir(),
    // rust: Err(_) => path.is_dir(),
}
    // rust: if dir {
    // rust: dirs.push(path);
    // rust: } else if path.to_str().is_some_and(|p| p.ends_with(".png.mcmeta")) {
    // rust: out.push(path);
}
}
}
    // rust: out
}

// `sprites`' tiles of the connecting texture `name`, and the predicates it joins by itself.
    // rust: fn sheet(
    // rust: root: &Path,
    // rust: sprites: &mut Sprites,
    // rust: name: &str,
    // rust: meta: Meta,
    // rust: ) -> Option<(Sheet, Connection)> {
    // rust: let Kind::Connecting {
    // rust: layout,
    // rust: connections,
    // rust: per_tile_animation,
    // rust: ..
    // rust: } = meta.kind
    // rust: else {
    // rust: return None;
}
    // rust: let tiles = sprites
    // rust: .insert_tiles(root, name, layout.grid(), per_tile_animation)
    // rust: .map_err(|e| log::warn!("Horizon: Fusion texture {name}: {e}"))
    // rust: .ok()?;
    // A layer past the mesher's `u16` leaves the sheet to vanilla.
    // rust: let tiles = tiles
    // rust: .into_iter()
    // rust: .map(|t| match t {
    // rust: None => Some(None),
    // rust: Some(l) => Some(Some(TileLayer::Layer {
    // rust: layer: u16::try_from(l).ok()?,
    // rust: translucent: sprites.translucent[l as usize],
    // rust: opaque: sprites.opaque[l as usize],
    // rust: })),
    // rust: })
    // rust: .collect::<Option<Vec<_>>>()?;
    // rust: Some((Sheet { layout, tiles }, connections))
}

    // rust: impl FusionTextures {
    // The connecting textures under `root`: the tiles of those `fusion:connecting` models
    // draw are inserted into `sprites` (before it finishes), and each face in `catalog` that
    // shows one gets its rule.
    // rust: pub fn load(
    // rust: root: &Path,
    // rust: registry: &BlockRegistry,
    // rust: sprites: &mut Sprites,
    // rust: catalog: &mut StateModels,
    // rust: ) -> Self {
    // rust: let mut textures = connecting_textures(root);
    // rust: if textures.is_empty() {
    // rust: return Self::default();
}
        // The layers models show the sheets as: only their models are read.
    // rust: let shown: std::collections::HashSet<u32> = textures
    // rust: .keys()
    // rust: .filter_map(|name| sprites.layers.get(name).copied())
    // rust: .collect();
    // rust: let mut models: HashMap<String, Vec<ModelFace>> = HashMap::new();
    // rust: let mut sheets: Vec<(Sheet, Connection)> = Vec::new();
    // rust: let mut by_name: HashMap<String, Option<usize>> = HashMap::new();
    // rust: let mut rules: Vec<(usize, Connection)> = Vec::new();
    // rust: for (variant, model) in catalog.models_mut() {
    // rust: if !model.faces.iter().any(|f| shown.contains(&f.layer)) {
    // rust: continue;
}
    // rust: let found = models
    // rust: .entry(namespaced(&variant.model))
    // rust: .or_insert_with_key(|name| connecting_model(root, name));
    // rust: for face in &mut model.faces {
    // rust: let sprite = &face.quad.material.sprite;
                // The model's face on the side this one turned to, else any with its sprite.
    // rust: let side = Face::ALL[face.quad.facing as usize];
    // rust: let mut drawing = found.iter().filter(|(s, _, _)| s == sprite);
    // rust: let Some((_, _, connection)) = drawing
    // rust: .clone()
    // rust: .find(|(_, f, _)| turned(*f, variant.rotations) == side)
    // rust: .or_else(|| drawing.next())
    // rust: else {
    // rust: continue;
}
                // The sheet, cut into tiles on first use.
    // rust: let sheet = *by_name.entry(sprite.clone()).or_insert_with(|| {
    // rust: let meta = textures.remove(sprite)?;
    // rust: sheets.push(sheet(root, sprites, sprite, meta)?);
    // rust: Some(sheets.len() - 1)
    // rust: });
    // rust: let Some(sheet) = sheet else {
    // rust: continue;
}
    // rust: let connection = connection
    // rust: .clone()
    // rust: .unwrap_or_else(|| sheets[sheet].1.clone());
    // rust: let rule = match rules.iter().position(|r| r.0 == sheet && r.1 == connection) {
    // rust: Some(rule) => rule,
    // rust: None => {
    // rust: rules.push((sheet, connection));
    // rust: rules.len() - 1
}
}
    // rust: face.fusion = u16::try_from(rule + 1).ok().and_then(NonZeroU16::new);
}
}
    // rust: let states = (0..registry.len() as u32).map(|id| {
    // rust: registry
    // rust: .state(BlockStateId(id))
    // rust: .map(|s| (s.name.as_str(), &s.properties))
    // rust: });
    // rust: let sheets = sheets.into_iter().map(|(sheet, _)| sheet).collect();
    // rust: Self::build(sheets, rules, states)
}

    // The lookups for `rules` over every block state (`None` for an id the registry skips).
    // rust: fn build<'a>(
    // rust: sheets: Vec<Sheet>,
    // rust: rules: Vec<(usize, Connection)>,
    // rust: states: impl Iterator<Item = Option<(&'a str, &'a BlockProperties)>>,
    // rust: ) -> Self {
    // rust: let states: Vec<_> = states.collect();
    // rust: let mut block_states: HashMap<&str, Vec<u32>> = HashMap::new();
    // rust: let mut names = HashMap::new();
    // rust: let blocks = (0..states.len() as u32)
    // rust: .map(|id| match states[id as usize] {
    // rust: Some((name, _)) => {
    // rust: block_states.entry(name).or_default().push(id);
    // rust: let next = names.len() as u32;
    // rust: *names.entry(name).or_insert(next)
}
    // rust: None => u32::MAX,
    // rust: })
    // rust: .collect();
        // Block lists to the states they match.
    // rust: let mut resolve = |list: Vec<horizon_optifine::BlockMatch>| {
    // rust: let mut ids: Vec<u32> = list
    // rust: .iter()
    // rust: .flat_map(|m| {
    // rust: let candidates = block_states
    // rust: .get(m.id.as_str())
    // rust: .map_or(&[][..], Vec::as_slice);
    // rust: candidates.iter().copied().filter(|&id| {
    // rust: states[id as usize].is_some_and(|(name, props)| {
    // rust: m.matches(name, |k| props.get(k).map(String::as_str))
    // rust: })
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: ids.sort_unstable();
    // rust: ids.dedup();
    // rust: ids
}
    // rust: let rules = rules
    // rust: .into_iter()
    // rust: .map(|(sheet, connection)| Rule {
    // rust: sheet,
    // rust: connection: connection.map_blocks(&mut resolve),
    // rust: })
    // rust: .collect();
    // rust: Self {
    // rust: sheets,
    // rust: rules,
    // rust: blocks,
}
}

    // What the `face` of the block `state` draws for a quad whose rule is `rule` and whose
    // tint index is `tint`. `neighbour` answers the state at an offset from the block,
    // `covers` whether a state hides the face of a block beside it; the overlay layout's
    // pieces, tinted as the quad, go to `overlay`.
    // rust: pub fn pick(
    // rust: &self,
    // rust: rule: NonZeroU16,
    // rust: state: u32,
    // rust: face: Face,
    // rust: tint: i32,
    // rust: neighbour: impl Fn([i32; 3]) -> u32,
    // rust: covers: impl Fn(u32) -> bool,
    // rust: mut overlay: impl FnMut(Overlay),
    // rust: ) -> Option<Pick> {
    // rust: let rule = self.rules.get(usize::from(rule.get() - 1))?;
    // rust: let normal = face.normal();
    // rust: let offsets = connect::offsets(Axes::cube(face));
    // rust: let block = self.blocks.get(state as usize).filter(|&&b| b != u32::MAX);
    // rust: let mask = rule.connection.mask(|bit, query| {
    // rust: let &(_, [x, y, z]) = offsets.iter().find(|o| o.0 == bit).expect("a mask bit");
    // rust: let in_front = || neighbour([x + normal[0], y + normal[1], z + normal[2]]);
    // rust: match query {
    // rust: Query::SameBlock => {
    // rust: block.is_some() && self.blocks.get(neighbour([x, y, z]) as usize) == block
}
    // rust: Query::SameState => neighbour([x, y, z]) == state,
    // rust: Query::Neighbour(ids) => ids.binary_search(&neighbour([x, y, z])).is_ok(),
    // rust: Query::InFront(ids) => ids.binary_search(&in_front()).is_ok(),
    // rust: Query::FaceVisible => !covers(in_front()),
}
    // rust: });
    // rust: let sheet = &self.sheets[rule.sheet];
    // rust: let tile = |i: u8| sheet.tiles.get(usize::from(i)).copied().flatten();
        // An empty tile draws nothing: a pack leaves empty only the tiles its layout's uses
        // never need.
    // rust: Some(match sheet.layout.tiles(mask) {
    // rust: Tiles::One(t) => tile(t).map_or(Pick::Nothing, Pick::Tile),
    // rust: Tiles::Quarters(q) => match q.map(tile) {
    // rust: [Some(a), Some(b), Some(c), Some(d)] => Pick::Quarters([a, b, c, d]),
    // rust: _ => Pick::Nothing,
    // rust: },
    // rust: Tiles::Overlay(mask) => {
    // rust: for t in Layout::overlay_tiles(mask) {
    // rust: if let Some(TileLayer::Layer {
    // rust: layer, translucent, ..
    // rust: }) = tile(t)
    // rust: {
    // rust: overlay(Overlay {
    // rust: layer,
    // rust: translucent,
    // rust: tint: (tint >= 0).then_some((tint, None)),
    // rust: });
}
}
    // rust: Pick::Nothing
}
    // rust: })
}
}

    // rust: mod tests {
//     use super::*;

    // Tile `i` of a sheet is layer `base + i`; `empty` tiles have none.
sheet :: proc(layout: Layout, base: u16, empty: ^[u16]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let (w, h) = layout.grid();
    // rust: Sheet {
    // rust: layout,
    // rust: tiles: (0..(w * h) as u16)
    // rust: .map(|i| (!empty.contains(&i)).then_some(layer(base + i)))
    // rust: .collect(),
}
}

predicate :: proc(json: string) -> C {
    // Ported from Horizon
    return {}
}
    // rust: Connection::parse(&Json::parse(json).unwrap()).unwrap()
}

layer :: proc(layer: u16) -> T {
    // Ported from Horizon
    return {}
}
    // rust: TileLayer::Layer {
    // rust: layer,
    // rust: translucent: false,
    // rust: opaque: false,
}
}

    // The lookups over blocks named `names` (a state each).
    // rust: fn world(
    // rust: names: &[&str],
    // rust: sheets: Vec<Sheet>,
    // rust: rules: Vec<(usize, Connection)>,
    // rust: ) -> FusionTextures {
    // rust: let none = BlockProperties::default();
    // rust: let states = names.iter().map(|n| Some((*n, &none)));
    // rust: FusionTextures::build(sheets, rules, states)
}

    // `pick` for the block at the origin among `blocks` (offset, state), the opaque ones in
    // `opaque`; with the overlays it hands out.
    // rust: fn pick_in(
    // rust: fusion: &FusionTextures,
    // rust: rule: u16,
    // rust: state: u32,
    // rust: face: Face,
    // rust: blocks: &[([i32; 3], u32)],
    // rust: opaque: &[u32],
    // rust: ) -> (Option<Pick>, Vec<u16>) {
        // A face's rule counts from 1.
    // rust: let rule = NonZeroU16::new(rule + 1).unwrap();
    // rust: let at = |o: [i32; 3]| blocks.iter().find(|(p, _)| *p == o).map_or(0, |b| b.1);
    // rust: let mut overlays = Vec::new();
    // rust: let pick = fusion.pick(
    // rust: rule,
    // rust: state,
    // rust: face,
    // rust: -1,
    // rust: at,
    // rust: |s| opaque.contains(&s),
    // rust: |o| overlays.push(o.layer),
    // rust: );
    // rust: (pick, overlays)
}

glass_pieces_join_the_same_block :: proc() {
}
        // Glass twice (two states of one block), then stone.
    // rust: let fusion = world(
    // rust: &[
    // rust: "minecraft:air",
    // rust: "minecraft:glass",
    // rust: "minecraft:glass",
    // rust: "minecraft:stone",
    // rust: ],
    // rust: vec![sheet(Layout::Pieced, 100, &[])],
    // rust: vec![(0, Connection::SameBlock)],
    // rust: );
    // rust: let at = |blocks: &[([i32; 3], u32)]| pick_in(&fusion, 0, 1, Face::North, blocks, &[]).0;
        // Alone: every quarter the lone tile.
    // rust: assert_eq!(at(&[]), Some(Pick::Quarters([layer(100); 4])));
        // A north face's right is west: glass there (in its other state) joins the right
        // quarters, the horizontal piece. Stone doesn't.
    // rust: let right = Pick::Quarters([layer(100), layer(103), layer(100), layer(103)]);
    // rust: assert_eq!(at(&[([-1, 0, 0], 2)]), Some(right));
    // rust: assert_eq!(
    // rust: at(&[([-1, 0, 0], 3)]),
    // rust: Some(Pick::Quarters([layer(100); 4]))
    // rust: );
        // A rule that doesn't exist draws as vanilla.
    // rust: assert_eq!(pick_in(&fusion, 1, 1, Face::North, &[], &[]).0, None);
}

overlays_reach_toward_visible_sand :: proc() {
}
    // rust: let sand = predicate(
    // rust: r#"{"type": "and", "predicates": [{"type": "match_block", "block": "sand"}, {"type": "is_face_visible"}]}"#,
    // rust: );
    // rust: let fusion = world(
    // rust: &["minecraft:air", "minecraft:stone", "minecraft:sand"],
    // rust: vec![sheet(Layout::Overlay, 200, &[7])],
    // rust: vec![(0, sand)],
    // rust: );
        // Sand to the north of stone's top face, its own top open: the top edge piece, (1, 2),
        // over a face that draws nothing itself.
    // rust: let north = [([0, 0, -1], 2)];
    // rust: assert_eq!(
    // rust: pick_in(&fusion, 0, 1, Face::Up, &north, &[]),
    // rust: (Some(Pick::Nothing), vec![213])
    // rust: );
        // Stone over that sand hides its top: no edge.
    // rust: let covered = [([0, 0, -1], 2), ([0, 1, -1], 1)];
    // rust: assert_eq!(
    // rust: pick_in(&fusion, 0, 1, Face::Up, &covered, &[1]),
    // rust: (Some(Pick::Nothing), vec![])
    // rust: );
        // Sand all round: the ring, (4, 1).
    // rust: let ring: Vec<_> = [-1, 0, 1]
    // rust: .into_iter()
    // rust: .flat_map(|x| [-1, 0, 1].map(|z| ([x, 0, z], 2)))
    // rust: .filter(|(o, _)| *o != [0, 0, 0])
    // rust: .collect();
    // rust: assert_eq!(pick_in(&fusion, 0, 1, Face::Up, &ring, &[]).1, [210]);
        // Its pieces take the quad's tint index.
    // rust: let mut tints = Vec::new();
    // rust: let at = |o: [i32; 3]| if o == [0, 0, -1] { 2 } else { 0 };
    // rust: let rule = NonZeroU16::new(1).unwrap();
    // rust: fusion.pick(rule, 1, Face::Up, 0, at, |_| false, |o| tints.push(o.tint));
    // rust: assert_eq!(tints, [Some((0, None))]);
}

in_front_and_empty_tiles :: proc() {
}
        // Dirt's top joins where sand sits on the block beside it; its full sheet leaves the
        // lone tile empty.
    // rust: let front = predicate(r#"{"type": "match_block_in_front", "block": "sand"}"#);
    // rust: let fusion = world(
    // rust: &["minecraft:air", "minecraft:dirt", "minecraft:sand"],
    // rust: vec![sheet(Layout::Full, 300, &[0])],
    // rust: vec![(0, front)],
    // rust: );
        // Sand on the block east of the top face: joined right, the full template's (1, 0).
    // rust: assert_eq!(
    // rust: pick_in(&fusion, 0, 1, Face::Up, &[([1, 1, 0], 2)], &[]).0,
    // rust: Some(Pick::Tile(layer(301)))
    // rust: );
        // Sand beside it, not in front of anything: alone, and the lone tile is empty.
    // rust: assert_eq!(
    // rust: pick_in(&fusion, 0, 1, Face::Up, &[([1, 0, 0], 2)], &[]).0,
    // rust: Some(Pick::Nothing)
    // rust: );
}

models_name_the_predicates_their_faces_draw :: proc() {
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-fusion-models-{}", std::process::id()));
    // rust: let models = root.join("assets/demo/models/block");
    // rust: fs::create_dir_all(&models).unwrap();
        // A pane arm over a template whose `particle` names the pane sheet but draws no face
        // with it (as Fusion Connected Glass's posts do): only the faces count.
    // rust: fs::write(
    // rust: models.join("template.json"),
    // rust: r##"{"textures": {"particle": "#pane"}, "elements": [{"from": [7, 0, 0], "to": [9, 16, 7],
    // rust: "faces": {"up": {"texture": "#edge"}, "west": {"texture": "#pane"}}}]}"##,
    // rust: )
    // rust: .unwrap();
    // rust: fs::write(
    // rust: models.join("arm.json"),
    // rust: r#"{"loader": "fusion:model", "type": "fusion:connecting", "parent": "demo:block/template",
    // rust: "connections": {"edge": {"type": "true"}},
    // rust: "textures": {"pane": "demo:block/glass", "edge": {"sprite": "demo:block/edge"}}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: fs::write(
    // rust: models.join("plain.json"),
    // rust: r#"{"parent": "demo:block/template", "textures": {"pane": "demo:block/glass"}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let arm = connecting_model(&root, "demo:block/arm");
    // rust: let plain = connecting_model(&root, "demo:block/plain");
    // rust: fs::remove_dir_all(&root).unwrap();
        // `edge` has the model's predicate; `pane` none, so the texture's own.
    // rust: assert_eq!(
    // rust: arm,
    // rust: [
    // rust: (
    // rust: "demo:block/edge".to_owned(),
    // rust: Face::Up,
    // rust: Some(Connection::Const(true))
    // rust: ),
    // rust: ("demo:block/glass".to_owned(), Face::West, None),
    // rust: ]
    // rust: );
        // Not a Fusion model: vanilla.
    // rust: assert!(plain.is_empty());
}

faces_of_one_sprite_join_by_their_own_keys :: proc() {
}
    // rust: let root = std::env::temp_dir().join(format!("horizon-fusion-keys-{}", std::process::id()));
    // rust: let models = root.join("assets/demo/models/block");
    // rust: fs::create_dir_all(&models).unwrap();
        // The wiki's example: four keys on one texture, two of them joining by `blue`.
    // rust: fs::write(
    // rust: models.join("tiles.json"),
    // rust: r##"{"loader": "fusion:model", "type": "connecting",
    // rust: "textures": {"ice": "block/oak_tiles", "dirt": "block/oak_tiles", "stone": "block/oak_tiles"},
    // rust: "connections": {"blue": {"type": "match_block", "block": "ice"},
    // rust: "dirt": {"type": "is_same_block"}, "default": {"type": "is_same_state"}},
    // rust: "elements": [{"from": [0, 0, 0], "to": [16, 16, 16], "faces": {
    // rust: "up": {"texture": "#ice", "connections": "#blue"},
    // rust: "north": {"texture": "#dirt"}, "south": {"texture": "#stone"}}}]}"##,
    // rust: )
    // rust: .unwrap();
    // rust: let faces = connecting_model(&root, "demo:block/tiles");
    // rust: fs::remove_dir_all(&root).unwrap();
    // rust: let joins = |side| faces.iter().find(|f| f.1 == side).and_then(|f| f.2.clone());
    // rust: assert!(matches!(joins(Face::Up), Some(Connection::Neighbour(_))));
    // rust: assert_eq!(joins(Face::North), Some(Connection::SameBlock));
    // rust: assert_eq!(joins(Face::South), Some(Connection::SameState));
        // A blockstate's turns move them: x=90 takes the top to the north, y=90 the north to
        // the east.
    // rust: assert_eq!(turned(Face::Up, [1, 0, 0]), Face::North);
    // rust: assert_eq!(turned(Face::North, [0, 1, 0]), Face::East);
    // rust: assert_eq!(turned(Face::Up, [1, 1, 0]), Face::East);
}
}
