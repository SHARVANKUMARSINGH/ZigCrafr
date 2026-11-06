//! Transpiled from Horizon Rust crate
package horizon_optifine_ctm

import "core:fmt"
import "core:mem"
import "core:math"

// Connected textures (`optifine/ctm/**/*.properties`): the rules a pack defines, which block
// faces each one applies to, and its replacement tiles. Choosing a tile from the neighbours is
// [`connect`]'s.
//
// Written from OptiFine's `ctm.properties` documentation and template images, and Continuity's
// wiki (its "Continuity Connected Textures Specification" page) for what OptiFine does where the
// documentation is silent; no mod's source was read.

    // rust: pub mod connect;

// use crate::{BlockMatch, IdList, Name, Properties, RangeList};
// use std::path::Path;

// In this order: the overlays last ([`Method::is_overlay`]).
Method :: enum {
    // The 47 tiles of the 8-way template.
    Ctm,
    // 5 tiles, cut into quarters, and `ctm.N` replacements.
    CtmCompact,
    Horizontal,
    Vertical,
    HorizontalVertical,
    VerticalHorizontal,
    Top,
    Random,
    Repeat,
    Fixed,
    // The 17 transition tiles drawn over a face beside the connecting blocks.
    Overlay,
    OverlayCtm,
    OverlayRandom,
    OverlayRepeat,
    OverlayFixed,
    // Continuity's overlay forms of the 4-tile methods.
    OverlayHorizontal,
    OverlayVertical,
    OverlayHorizontalVertical,
    OverlayVerticalHorizontal,
}

    // rust: impl Method {
parse :: proc(value: string) -> O {
    // Ported from Horizon
    return {}
}
//         use Method::*;
    // rust: Some(match value {
            // MCPatcher's names for the same methods.
    // rust: "ctm" | "glass" => Ctm,
    // rust: "ctm_compact" => CtmCompact,
    // rust: "horizontal" | "bookshelf" => Horizontal,
    // rust: "vertical" => Vertical,
    // rust: "horizontal+vertical" | "h+v" => HorizontalVertical,
    // rust: "vertical+horizontal" | "v+h" => VerticalHorizontal,
    // rust: "top" | "sandstone" => Top,
    // rust: "random" => Random,
    // rust: "repeat" | "pattern" => Repeat,
    // rust: "fixed" | "static" => Fixed,
    // rust: "overlay" => Overlay,
    // rust: "overlay_ctm" => OverlayCtm,
    // rust: "overlay_random" => OverlayRandom,
    // rust: "overlay_repeat" => OverlayRepeat,
    // rust: "overlay_fixed" => OverlayFixed,
    // rust: "overlay_horizontal" => OverlayHorizontal,
    // rust: "overlay_vertical" => OverlayVertical,
    // rust: "overlay_horizontal+vertical" | "overlay_h+v" => OverlayHorizontalVertical,
    // rust: "overlay_vertical+horizontal" | "overlay_v+h" => OverlayVerticalHorizontal,
    // rust: _ => return None,
    // rust: })
}

    // Draws a second quad over the face instead of replacing its sprite.
is_overlay :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self >= Method::Overlay
}

    // The fewest tiles the method takes, and the exact count when it needs one. `ctm_compact`
    // takes extra tiles for its `ctm.N` replacements; `repeat` needs `width * height`.
tiles_needed :: proc(self: ^Self, width: u32, height: u32) -> ( {
    // Ported from Horizon
    return {}
}
//         use Method::*;
    // rust: let n = |n| (n, Some(n));
    // rust: match self {
    // rust: Ctm | OverlayCtm => n(47),
    // rust: CtmCompact => (5, None),
    // rust: Horizontal | Vertical | OverlayHorizontal | OverlayVertical => n(4),
    // rust: HorizontalVertical
    // rust: | VerticalHorizontal
    // rust: | OverlayHorizontalVertical
    // rust: | OverlayVerticalHorizontal => n(7),
    // rust: Top | Fixed | OverlayFixed => n(1),
    // rust: Random | OverlayRandom => (1, None),
            // `checked_mul`'s `None` (a pattern no pack can fill) asks for 0 tiles: refused.
    // rust: Repeat | OverlayRepeat => n(width.checked_mul(height).unwrap_or(0) as usize),
    // rust: Overlay => n(17),
}
}
}

// When two neighbouring faces join.
Connect :: enum {
    // The same block.
    Block,
    // The same sprite on that face.
    Tile,
    // The same block state.
    State,
}

Tile :: enum {
    // A texture's resource path (`assets/<ns>/....png`).
    Texture(String),
    // Nothing from this rule: the next rule is tried (an overlay draws nothing).
    Skip,
    // The face's own sprite.
    Default,
}

Symmetry :: enum {
    None,
    // Opposite faces share a choice.
    Opposite,
    // All six faces share a choice.
    All,
}

Layer :: enum {
    Cutout,
    Translucent,
}

// How a face's left, right, up and down are found (Continuity's `orient`).
Orient :: enum {
    // The face's directions on a vanilla cube.
    None,
    // [`Orient::None`], turned with the block's `axis` as a cube column's model is.
    StateAxis,
    // The quad's own texture directions.
    Texture,
}

// Bits of [`Rule::faces`], by `Direction` order: down, up, north, south, west, east.
    // rust: pub mod faces {
DOWN :: 1
UP :: 2
NORTH :: 4
SOUTH :: 8
WEST :: 16
EAST :: 32
SIDES :: NORTH | SOUTH | WEST | EAST
ALL :: 63
}

Rule :: struct {
    // The properties file's resource path: rules are ordered by it.
    path: string,
    method: Method,
    tiles: [dynamic]Tile,
    // Sprites (as texture resource paths) whose faces the rule replaces.
    match_tiles: [dynamic]string,
    match_blocks: [dynamic]BlockMatch,
    weight: i32,
    // [`faces`] bits.
    faces: u8,
    biomes: Maybe(IdList),
    heights: Maybe(RangeList),
    // A nameable block entity's custom name.
    name: Maybe(Name),
    connect: Connect,
    // Overlays: join only to faces with these sprites (texture resource paths) ...
    connect_tiles: [dynamic]string,
    // ... or these blocks.
    connect_blocks: [dynamic]BlockMatch,
    inner_seams: bool,
    // One per tile (`random`); empty when every tile counts the same.
    weights: [dynamic]u32,
    random_loops: u32,
    symmetry: Symmetry,
    linked: bool,
    // `repeat`'s pattern size, in blocks.
    width: u32,
    height: u32,
    // `ctm_compact`'s `ctm.<case>=<tile index>`, by 47-tile case.
    compact_overrides: Vec<(u8,
    // Overlays: the tint index and the block whose tint it is (`None`: the face's block).
    tint_index: i32,
    tint_block: Maybe(string),
    layer: Layer,
    orient: Orient,
    // Applied before every rule without it (Continuity's `prioritize`; OptiFine's "tile-based
    // entries are checked before block-based ones").
    prioritize: bool,
}

// Every rule `root` holds, in the order they are tried: prioritized (tile) rules first, then by
// weight (highest first), then by path. Broken files are logged and left out.
load :: proc(root: ^Path) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut rules: Vec<Rule> = crate::properties_files(root, "ctm")
    // rust: .into_iter()
    // rust: .filter_map(|path| {
    // rust: let bytes = std::fs::read(root.join(&path))
    // rust: .map_err(|e| log::warn!("Horizon: connected textures {path}: {e}"))
    // rust: .ok()?;
            // Java's `Properties.load(InputStream)` reads ISO-8859-1; UTF-8 when it is valid.
    // rust: let text = String::from_utf8(bytes)
    // rust: .unwrap_or_else(|e| e.into_bytes().iter().map(|&b| char::from(b)).collect());
    // rust: Rule::parse(&path, &Properties::parse(&text))
    // rust: .map_err(|e| log::warn!("Horizon: connected textures {path}: {e}"))
    // rust: .ok()
    // rust: .flatten()
    // rust: })
    // rust: .collect();
    // rust: sort(&mut rules);
    // rust: rules
}

// [`load`]'s order, for rules gathered elsewhere.
sort :: proc(rules: ^[Rule]) {
}
    // rust: rules.sort_by(|a, b| (b.prioritize, b.weight, &a.path).cmp(&(a.prioritize, a.weight, &b.path)));
}

    // rust: impl Rule {
    // `Ok(None)` for a file the pack keeps from Continuity (`optifineOnly=true`).
parse :: proc(path: string, props: ^Properties) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let get = |key| props.get(key).filter(|v| !v.is_empty());
        // `Boolean.parseBoolean`.
    // rust: let flag = |key| get(key).map(|v: &str| v.eq_ignore_ascii_case("true"));
        // Continuity's wiki: `optifineOnly` counts only in `minecraft`, the namespace OptiFine
        // reads, so a pack can keep a file from Continuity there and give it another elsewhere.
    // rust: let namespace = path.split('/').nth(1).unwrap_or("minecraft");
    // rust: if namespace == "minecraft" && flag("optifineOnly") == Some(true) {
    // rust: return Ok(None);
}
    // rust: let method = get("method").ok_or("no method")?;
    // rust: let method = Method::parse(method).ok_or(format!("unknown method {method}"))?;

    // rust: let stem = path.rsplit('/').next().unwrap_or(path);
    // rust: let stem = stem.strip_suffix(".properties").unwrap_or(stem);
    // rust: let (mut match_tiles, mut match_blocks) = (Vec::new(), Vec::new());
    // rust: match (get("matchTiles"), get("matchBlocks")) {
    // rust: (None, None) => match stem.strip_prefix("block_") {
                // `block_<name>.properties` and `<name>.properties` name what they match.
    // rust: Some(block) => match_blocks = BlockMatch::parse_list(block),
    // rust: None => match_tiles.extend(sprite_path(stem)),
    // rust: },
    // rust: (tiles, blocks) => {
    // rust: match_tiles = tiles.map_or_else(Vec::new, sprite_list);
    // rust: match_blocks = blocks.map_or_else(Vec::new, BlockMatch::parse_list);
}
}
    // rust: if match_tiles.is_empty() && match_blocks.is_empty() {
    // rust: return Err("matches no block or tile".into());
}

    // rust: let int = |key, default| get(key).and_then(|v| v.parse().ok()).unwrap_or(default);
    // rust: let width = int("width", 0).max(0) as u32;
    // rust: let height = int("height", 0).max(0) as u32;

    // rust: let tiles = match get("tiles") {
    // rust: Some(v) => tile_list(path, v)?,
    // rust: None => Vec::new(),
}
    // rust: let (min, max) = method.tiles_needed(width, height);
    // rust: if tiles.len() < min || max.is_some_and(|max| tiles.len() != max) || min == 0 {
    // rust: return Err(format!("{} tiles for {method:?}", tiles.len()));
}
    // rust: if method.is_overlay() && tiles.contains(&Tile::Default) {
    // rust: return Err("an overlay has no <default> tile".into());
}

    // rust: let mut weights: Vec<u32> = get("weights")
    // rust: .map(|v| {
                // By position: a weight that is not a number (`Integer.parseInt`) counts 1.
    // rust: v.split_whitespace()
    // rust: .map(|w| w.parse::<i32>().map_or(1, |w| w.max(0) as u32))
    // rust: .collect()
    // rust: })
    // rust: .unwrap_or_default();
    // rust: if !weights.is_empty() {
    // rust: weights.resize(tiles.len(), 1);
}
    // rust: if weights.iter().all(|&w| w == 0) {
            // Nothing to pick by: every tile alike.
    // rust: weights.clear();
}

    // rust: let compact_overrides = props
    // rust: .with_prefix("ctm.")
    // rust: .filter_map(|(case, tile)| {
    // rust: let case: u8 = case.parse().ok().filter(|&c| c < 47)?;
    // rust: let tile: usize = tile.parse().ok().filter(|&t| t < tiles.len())?;
    // rust: Some((case, tile))
    // rust: })
    // rust: .collect();

    // rust: let heights = match (get("heights"), get("minHeight"), get("maxHeight")) {
    // rust: (Some(h), ..) => Some(height_list(h).ok_or(format!("bad heights {h}"))?),
    // rust: (None, None, None) => None,
    // rust: (None, lo, hi) => {
    // rust: let bound = |v: Option<&str>, d| match v {
    // rust: Some(v) => v.parse().map_err(|_| format!("bad height {v}")),
    // rust: None => Ok(d),
}
    // rust: Some(RangeList(vec![(
    // rust: bound(lo, i32::MIN)?,
    // rust: bound(hi, i32::MAX)?,
    // rust: )]))
}
}

    // rust: let connect = match get("connect") {
    // rust: Some("block") => Connect::Block,
    // rust: Some("tile") => Connect::Tile,
    // rust: Some("state") => Connect::State,
    // rust: Some(other) => return Err(format!("unknown connect {other}")),
    // rust: None if match_blocks.is_empty() => Connect::Tile,
    // rust: None => Connect::Block,
}

    // rust: let orient = match get("orient").map(str::to_ascii_lowercase).as_deref() {
    // rust: Some("none") => Orient::None,
    // rust: Some("state_axis") => Orient::StateAxis,
    // rust: Some("texture") => Orient::Texture,
            // OptiFine's own behaviour.
    // rust: _ => match method {
    // rust: Method::Horizontal
    // rust: | Method::Vertical
    // rust: | Method::HorizontalVertical
    // rust: | Method::VerticalHorizontal => Orient::StateAxis,
    // rust: _ => Orient::None,
    // rust: },
}

    // rust: Ok(Some(Self {
    // rust: path: path.to_owned(),
    // rust: method,
    // rust: prioritize: flag("prioritize").unwrap_or(!match_tiles.is_empty()),
    // rust: match_tiles,
    // rust: match_blocks,
    // rust: weight: int("weight", 0),
    // rust: faces: get("faces").map_or(faces::ALL, face_bits),
    // rust: biomes: get("biomes").map(IdList::parse),
    // rust: heights,
    // rust: name: match get("name") {
    // rust: Some(n) => Some(Name::parse(n).ok_or(format!("bad name {n}"))?),
    // rust: None => None,
    // rust: },
    // rust: connect,
    // rust: connect_tiles: get("connectTiles").map_or_else(Vec::new, sprite_list),
    // rust: connect_blocks: get("connectBlocks").map_or_else(Vec::new, BlockMatch::parse_list),
    // rust: inner_seams: flag("innerSeams") == Some(true),
    // rust: weights,
    // rust: random_loops: int("randomLoops", 0).clamp(0, 9) as u32,
    // rust: symmetry: match get("symmetry") {
    // rust: Some("opposite") => Symmetry::Opposite,
    // rust: Some("all") => Symmetry::All,
    // rust: _ => Symmetry::None,
    // rust: },
    // rust: linked: flag("linked") == Some(true),
    // rust: width,
    // rust: height,
    // rust: compact_overrides,
    // rust: tint_index: int("tintIndex", -1),
    // rust: tint_block: get("tintBlock").map(crate::matchers::namespaced),
    // rust: layer: match get("layer") {
    // rust: Some("translucent") => Layer::Translucent,
    // rust: _ => Layer::Cutout,
    // rust: },
    // rust: orient,
    // rust: tiles,
    // rust: }))
}

    // The rule names this block state (`state` answers its properties).
    // rust: pub fn matches_block<'a>(&self, id: &str, state: impl Fn(&str) -> Option<&'a str>) -> bool {
    // rust: self.match_blocks.iter().any(|m| m.matches(id, &state))
}

    // The rule names this sprite (a texture resource path, [`sprite_path`]).
matches_tile :: proc(self: ^Self, sprite: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.match_tiles.iter().any(|t| t == sprite)
}

    // The tests that depend on where the face is, not on what it is. `face` is a [`faces`] bit;
    // `name` is the block entity's custom name, if it has one.
applies_at :: proc(self: ^Self, face: u8, y: i32, biome: string, name: Maybe(string)) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.faces & face != 0
    // rust: && self.heights.as_ref().is_none_or(|h| h.contains(y))
    // rust: && self.biomes.as_ref().is_none_or(|b| b.matches(biome))
    // rust: && self
    // rust: .name
    // rust: .as_ref()
    // rust: .is_none_or(|n| name.is_some_and(|name| n.matches(name)))
}
}

// `matchTiles`/`connectTiles` entries as texture resource paths.
sprite_list :: proc(value: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: value
    // rust: .split_whitespace()
    // rust: .take(MAX_TILES)
    // rust: .filter_map(sprite_path)
    // rust: .collect()
}

// A tile name as the texture's resource path: `dirt` is `textures/block/dirt.png`, and a path
// under `textures/` or `optifine/` is that file. Any other path is in `minecraft` (OptiFine; its
// `block/` and `item/` sprites in `textures/`) or, after `ns:`, in `ns:textures/` (Continuity).
sprite_path :: proc(name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let (ns, path, namespaced) = match name.split_once(':') {
        // `Identifier`: an empty namespace is `minecraft`.
    // rust: Some(("", path)) => ("minecraft", path, true),
    // rust: Some((ns, path)) => (ns, path, true),
    // rust: None => ("minecraft", name, false),
}
    // rust: let path = path.strip_suffix(".png").unwrap_or(path);
    // rust: let path = match path {
    // rust: p if !p.contains('/') => format!("textures/block/{p}"),
    // rust: p if p.starts_with("textures/") || p.starts_with("optifine/") => p.to_owned(),
    // rust: p if namespaced || p.starts_with("block/") || p.starts_with("item/") => {
    // rust: format!("textures/{p}")
}
    // rust: p => p.to_owned(),
}
    // rust: crate::paths::in_root(format!("assets/{}/{path}.png", ns.to_ascii_lowercase()))
}

// More tiles than any rule needs (a 64 x 64 `repeat`): a range past it is a broken file, not
// millions of textures.
MAX_TILES :: 4096

// `tiles`: `0-3 5 name name.png <skip> <default> path/x.png ~/x /x assets/minecraft/x ns:path`
// (`/` is `~/`). Numbers and bare
// names are beside the properties file; ranges count up (or down). A tile outside the resource
// root fails the list (weights pair with tiles by position), as does a list past [`MAX_TILES`].
tile_list :: proc(props: string, value: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let png = |p: &str| {
    // rust: if p.ends_with(".png") {
    // rust: p.to_owned()
    // rust: } else {
    // rust: format!("{p}.png")
}
}
    // rust: let bad = |t: &str| format!("tile {t} is outside the resource root");
    // rust: let too_many = format!("more than {MAX_TILES} tiles");
    // rust: let mut out = Vec::new();
    // rust: for token in value.split_whitespace() {
        // Before every token: a file can't grow millions of paths first.
    // rust: if out.len() >= MAX_TILES {
    // rust: return Err(too_many);
}
    // rust: match token {
    // rust: "<skip>" => out.push(Tile::Skip),
    // rust: "<default>" => out.push(Tile::Default),
            // Continuity: a namespaced tile is a sprite location, never a range.
    // rust: t if t.contains(':') => out.push(Tile::Texture(sprite_path(t).ok_or(bad(t))?)),
    // rust: t => {
    // rust: if let Some((a, b)) = t.split_once('-')
    // rust: && let (Ok(a), Ok(b)) = (a.parse::<u32>(), b.parse::<u32>())
    // rust: {
    // rust: if out.len() + a.abs_diff(b) as usize >= MAX_TILES {
    // rust: return Err(too_many);
}
    // rust: let dir = props.rsplit_once('/').map_or("", |(d, _)| d);
    // rust: let tile = |n| Tile::Texture(format!("{dir}/{n}.png"));
    // rust: if a <= b {
    // rust: out.extend((a..=b).map(tile));
    // rust: } else {
    // rust: out.extend((b..=a).rev().map(tile));
}
    // rust: continue;
}
    // rust: if let Some(rest) = t.strip_prefix("assets/minecraft/") {
                    // A full path: `minecraft` whatever the file's namespace.
    // rust: let path = crate::paths::in_root(format!("assets/minecraft/{}", png(rest)));
    // rust: out.push(Tile::Texture(path.ok_or(bad(t))?));
    // rust: continue;
}
                // A leading `/` is OptiFine's folder, as `~/` is.
    // rust: let path = match t.strip_prefix('/') {
    // rust: Some(rest) => format!("~/{rest}"),
    // rust: None => t.to_owned(),
}
    // rust: out.push(Tile::Texture(
    // rust: crate::resolve(props, &png(&path)).ok_or(bad(t))?,
    // rust: ));
}
}
}
    // rust: Ok(out)
}

face_bits :: proc(value: string) -> u {
    // Ported from Horizon
    return {}
}
    // rust: value
    // rust: .split_whitespace()
    // rust: .map(|f| match f {
    // rust: "bottom" | "down" => faces::DOWN,
    // rust: "top" | "up" => faces::UP,
    // rust: "north" => faces::NORTH,
    // rust: "south" => faces::SOUTH,
    // rust: "west" => faces::WEST,
    // rust: "east" => faces::EAST,
    // rust: "sides" => faces::SIDES,
    // rust: "all" => faces::ALL,
    // rust: _ => 0,
    // rust: })
    // rust: .fold(0, |a, b| a | b)
}

// `heights`: OptiFine's ranges, or Continuity's `a..b`, `a..`, `..b` (either order).
height_list :: proc(value: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::new();
    // rust: for token in value.split([' ', ',']).filter(|t| !t.is_empty()) {
    // rust: match token.split_once("..") {
    // rust: Some((lo, hi)) => {
                // An empty side is open; anything else must be a number.
    // rust: let side = |v: &str| match v {
    // rust: "" => Some(None),
    // rust: v => v.parse::<i32>().ok().map(Some),
}
    // rust: out.push(match (side(lo)?, side(hi)?) {
    // rust: (Some(a), Some(b)) => (a.min(b), a.max(b)),
    // rust: (Some(a), None) => (a, i32::MAX),
    // rust: (None, Some(b)) => (i32::MIN, b),
    // rust: (None, None) => return None,
    // rust: });
}
    // rust: None => out.extend(RangeList::parse(token)?.0),
}
}
    // rust: Some(RangeList(out))
}

    // rust: mod tests {
//     use super::*;

DIR :: "assets/minecraft/optifine/ctm/glass"

rule :: proc(file: string, text: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Rule::parse(&format!("{DIR}/{file}"), &Properties::parse(text))
}

tex :: proc(path: string) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Tile::Texture(path.to_owned())
}

a_glass_rule :: proc() {
}
    // rust: let r = rule(
    // rust: "glass.properties",
    // rust: "matchBlocks=glass white_stained_glass\nmethod=ctm\ntiles=0-46\nconnect=state\nfaces=sides top\n",
    // rust: )
    // rust: .unwrap()
    // rust: .unwrap();
    // rust: assert_eq!(r.method, Method::Ctm);
    // rust: assert_eq!(r.tiles.len(), 47);
    // rust: assert_eq!(r.tiles[0], tex(&format!("{DIR}/0.png")));
    // rust: assert_eq!(r.tiles[46], tex(&format!("{DIR}/46.png")));
    // rust: assert_eq!(r.connect, Connect::State);
    // rust: assert_eq!(r.faces, faces::SIDES | faces::UP);
    // rust: assert!(r.matches_block("minecraft:white_stained_glass", |_| None));
    // rust: assert!(!r.matches_block("minecraft:glass_pane", |_| None));
    // rust: assert!(!r.prioritize);
    // rust: assert!(r.applies_at(faces::NORTH, 64, "minecraft:plains", None));
    // rust: assert!(!r.applies_at(faces::DOWN, 64, "minecraft:plains", None));
}

the_file_name_names_what_it_matches :: proc() {
}
    // rust: let tile = rule("dirt.properties", "method=random\ntiles=0-3")
    // rust: .unwrap()
    // rust: .unwrap();
    // rust: assert!(tile.matches_tile("assets/minecraft/textures/block/dirt.png"));
    // rust: assert_eq!(tile.connect, Connect::Tile);
    // rust: assert!(tile.prioritize);
    // rust: let block = rule("block_bookshelf.properties", "method=horizontal\ntiles=0-3")
    // rust: .unwrap()
    // rust: .unwrap();
    // rust: assert!(block.matches_block("minecraft:bookshelf", |_| None));
    // rust: assert!(block.match_tiles.is_empty());
    // rust: assert_eq!(block.orient, Orient::StateAxis);
        // An explicit list replaces the file name.
    // rust: let named = rule("x.properties", "matchBlocks=stone\nmethod=fixed\ntiles=0")
    // rust: .unwrap()
    // rust: .unwrap();
    // rust: assert!(named.match_tiles.is_empty());
}

tile_lists :: proc() {
}
    // rust: let r = rule(
    // rust: "a.properties",
    // rust: "matchTiles=stone\nmethod=random\ntiles=3-1 name other.png <skip> <default> ~/shared/x /y textures/block/z.png assets/minecraft/optifine/w mymod:leaf mymod:optifine/ctm/q 0-x",
    // rust: )
    // rust: .unwrap()
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: r.tiles,
    // rust: [
    // rust: tex(&format!("{DIR}/3.png")),
    // rust: tex(&format!("{DIR}/2.png")),
    // rust: tex(&format!("{DIR}/1.png")),
    // rust: tex(&format!("{DIR}/name.png")),
    // rust: tex(&format!("{DIR}/other.png")),
    // rust: Tile::Skip,
    // rust: Tile::Default,
    // rust: tex("assets/minecraft/optifine/shared/x.png"),
    // rust: tex("assets/minecraft/optifine/y.png"),
    // rust: tex("assets/minecraft/textures/block/z.png"),
    // rust: tex("assets/minecraft/optifine/w.png"),
    // rust: tex("assets/mymod/textures/block/leaf.png"),
    // rust: tex("assets/mymod/optifine/ctm/q.png"),
    // rust: tex(&format!("{DIR}/0-x.png")),
    // rust: ]
    // rust: );
}

tile_counts_per_method :: proc() {
}
    // rust: let ok = |m: &str, tiles: &str| {
    // rust: rule(
    // rust: "a.properties",
    // rust: &format!("matchBlocks=stone\nmethod={m}\n{tiles}"),
    // rust: )
    // rust: .is_ok()
}
    // rust: assert!(ok("ctm", "tiles=0-46"));
    // rust: assert!(!ok("ctm", "tiles=0-45"));
    // rust: assert!(ok("ctm_compact", "tiles=0-6"));
    // rust: assert!(!ok("ctm_compact", "tiles=0-3"));
    // rust: assert!(ok("horizontal+vertical", "tiles=0-6"));
    // rust: assert!(ok("repeat", "width=3\nheight=2\ntiles=0-5"));
    // rust: assert!(!ok("repeat", "width=3\nheight=2\ntiles=0-4"));
    // rust: assert!(!ok("repeat", "tiles=0"));
    // rust: assert!(ok("overlay", "tiles=0-15 <skip>"));
    // rust: assert!(!ok("overlay_fixed", "tiles=<default>"));
    // rust: assert!(!ok("spiral", "tiles=0"));
    // rust: assert!(!ok("random", ""));
}

namespaced_sprites :: proc() {
}
    // rust: let r = rule(
    // rust: "a.properties",
    // rust: "matchTiles=mymod:blocks/marble mymod:optifine/ctm/x blocks/marble\nmethod=fixed\ntiles=0",
    // rust: )
    // rust: .unwrap()
    // rust: .unwrap();
    // rust: assert!(r.matches_tile("assets/mymod/textures/blocks/marble.png"));
    // rust: assert!(r.matches_tile("assets/mymod/optifine/ctm/x.png"));
    // rust: assert!(
    // rust: rule(
    // rust: "a.properties",
    // rust: "matchTiles=:glass\nmethod=fixed\ntiles=:dirt"
    // rust: )
    // rust: .unwrap()
    // rust: .unwrap()
    // rust: .matches_tile("assets/minecraft/textures/block/glass.png")
    // rust: );
        // Without a namespace, a path is in minecraft as written.
    // rust: assert!(r.matches_tile("assets/minecraft/blocks/marble.png"));
}

method_options :: proc() {
}
    // rust: let r = rule(
    // rust: "a.properties",
    // rust: "matchBlocks=stone\nmethod=ctm_compact\ntiles=0-6\nctm.46=5\nctm.17=6\nctm.50=1\nctm.3=9\ninnerSeams=true\nweights=1 2\nheights=(-64)-0 100..\nbiomes=plains !desert\nname=ipattern:*vault*",
    // rust: )
    // rust: .unwrap()
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: r.compact_overrides.len(),
    // rust: 2,
    // rust: "case 50 and tile 9 do not exist"
    // rust: );
    // rust: assert!(r.compact_overrides.contains(&(46, 5)));
    // rust: assert!(r.inner_seams);
    // rust: assert_eq!(r.weights, [1, 2, 1, 1, 1, 1, 1]);
    // rust: for (y, ok) in [
    // rust: (-64, true),
    // rust: (0, true),
    // rust: (50, false),
    // rust: (100, true),
    // rust: (319, true),
    // rust: ] {
    // rust: assert_eq!(
    // rust: r.applies_at(faces::UP, y, "plains", Some("Vault")),
    // rust: ok,
    // rust: "{y}"
    // rust: );
}
    // rust: assert!(!r.applies_at(faces::UP, 0, "plains", None));
    // rust: let legacy = rule(
    // rust: "a.properties",
    // rust: "matchBlocks=stone\nmethod=fixed\ntiles=0\nminHeight=10",
    // rust: )
    // rust: .unwrap()
    // rust: .unwrap();
    // rust: assert!(legacy.heights.as_ref().unwrap().contains(10));
    // rust: assert!(!legacy.heights.as_ref().unwrap().contains(9));
}

order_and_continuity_only_files :: proc() {
}
    // rust: let mk = |path: &str, text: &str| {
    // rust: Rule::parse(path, &Properties::parse(text))
    // rust: .unwrap()
    // rust: .unwrap()
}
    // rust: let mut rules = vec![
    // rust: mk(
    // rust: "assets/minecraft/optifine/ctm/b.properties",
    // rust: "matchBlocks=stone\nmethod=fixed\ntiles=0",
    // rust: ),
    // rust: mk(
    // rust: "assets/minecraft/optifine/ctm/c.properties",
    // rust: "matchBlocks=stone\nmethod=fixed\ntiles=0\nweight=5",
    // rust: ),
    // rust: mk(
    // rust: "assets/minecraft/optifine/ctm/a.properties",
    // rust: "matchBlocks=stone\nmethod=fixed\ntiles=0",
    // rust: ),
    // rust: mk(
    // rust: "assets/minecraft/optifine/ctm/z.properties",
    // rust: "matchTiles=stone\nmethod=fixed\ntiles=0",
    // rust: ),
    // rust: ];
    // rust: sort(&mut rules);
    // rust: let names: Vec<_> = rules
    // rust: .iter()
    // rust: .map(|r| r.path.rsplit('/').next().unwrap())
    // rust: .collect();
    // rust: assert_eq!(
    // rust: names,
    // rust: [
    // rust: "z.properties",
    // rust: "c.properties",
    // rust: "a.properties",
    // rust: "b.properties"
    // rust: ]
    // rust: );

    // rust: let full = Rule::parse(
    // rust: "assets/mymod/optifine/ctm/a.properties",
    // rust: &Properties::parse(
    // rust: "matchBlocks=stone\nmethod=fixed\ntiles=assets/minecraft/textures/block/stone.png",
    // rust: ),
    // rust: );
    // rust: assert_eq!(
    // rust: full.unwrap().unwrap().tiles,
    // rust: [tex("assets/minecraft/textures/block/stone.png")]
    // rust: );
    // rust: let text = "matchBlocks=stone\nmethod=fixed\ntiles=0\noptifineOnly=true";
    // rust: assert!(rule("a.properties", text).unwrap().is_none());
    // rust: assert!(
    // rust: Rule::parse(
    // rust: "assets/mymod/optifine/ctm/a.properties",
    // rust: &Properties::parse(text)
    // rust: )
    // rust: .unwrap()
    // rust: .is_some()
    // rust: );
}
broken_values :: proc() {
}
    // rust: let base = "matchBlocks=furnace\nmethod=random\n";
    // rust: let r = |extra: &str| rule("a.properties", &format!("{base}{extra}"));
        // A pack can't ask for billions of tiles, or a pattern too big to count.
    // rust: assert!(r("tiles=0-4294967295").is_err());
    // rust: assert!(r("tiles=0-2999 3000-5000").is_err());
    // rust: assert!(r("tiles=0-4096").is_err());
    // rust: assert!(r(&format!("tiles={}0-0", "<skip> ".repeat(4097))).is_err());
    // rust: assert_eq!(
    // rust: r(&format!("tiles={}", "a ".repeat(4096)))
    // rust: .unwrap()
    // rust: .unwrap()
    // rust: .tiles
    // rust: .len(),
    // rust: 4096
    // rust: );
    // rust: assert!(r(&format!("tiles={}", "a ".repeat(4097))).is_err());
        // Namespaced tiles stay in the resource root too, and a `\` (written `\\` in the file)
        // is no separator on any platform.
    // rust: for bad in ["mymod:../../x", "..:x", r"~/..\\..\\x", r"a\\b"] {
    // rust: assert!(r(&format!("tiles={bad}")).is_err(), "{bad}");
}
    // rust: assert!(r("tiles=0\nheights=abc..64").is_err());
    // rust: assert!(r("tiles=0\nminHeight=abc").is_err());
    // rust: assert_eq!(r("tiles=0-4095").unwrap().unwrap().tiles.len(), 4096);
    // rust: let repeat = "matchBlocks=stone\nmethod=repeat\nwidth=65536\nheight=65536\ntiles=0";
    // rust: assert!(rule("a.properties", repeat).is_err());
        // A name test that can't be read matches no block, so the rule is dropped.
    // rust: assert!(r("tiles=0\nname=regex:[").is_err());
        // Weights pair with tiles by position.
    // rust: let w = r("tiles=0-2\nweights=10 x 4294967295").unwrap().unwrap();
    // rust: assert_eq!(w.weights, [10, 1, 1]);
    // rust: assert!(r("tiles=a ../b c\nweights=1 2 3").is_err());
    // rust: assert_eq!(
    // rust: r("tiles=0-2\nweights=-5 2 x").unwrap().unwrap().weights,
    // rust: [0, 2, 1]
    // rust: );
    // rust: assert!(
    // rust: r("tiles=0-1\nweights=-1 0")
    // rust: .unwrap()
    // rust: .unwrap()
    // rust: .weights
    // rust: .is_empty()
    // rust: );
    // rust: assert!(
    // rust: r("tiles=0-2\nweights=0 0 0")
    // rust: .unwrap()
    // rust: .unwrap()
    // rust: .weights
    // rust: .is_empty()
    // rust: );
    // rust: assert!(r("tiles=0\nprioritize=TRUE").unwrap().unwrap().prioritize);
    // rust: assert!(r("tiles=0\nheights=..").is_err());
    // rust: assert!(r("tiles=0\nconnect=sideways").is_err());
    // rust: assert_eq!(r("tiles=0").unwrap().unwrap().connect, Connect::Block);
}

height_forms :: proc() {
}
    // rust: let h = |v: &str| {
    // rust: rule(
    // rust: "a.properties",
    // rust: &format!("matchBlocks=stone\nmethod=fixed\ntiles=0\n{v}"),
    // rust: )
    // rust: .unwrap()
    // rust: .unwrap()
    // rust: .heights
    // rust: .unwrap()
}
    // rust: let below = h("heights=..10");
    // rust: assert!(below.contains(i32::MIN) && below.contains(10) && !below.contains(11));
    // rust: let swapped = h("heights=128..-16");
    // rust: assert!(swapped.contains(-16) && swapped.contains(128) && !swapped.contains(129));
    // rust: let max = h("maxHeight=5");
    // rust: assert!(max.contains(-64) && max.contains(5) && !max.contains(6));
}

loading_a_pack :: proc() {
}
    // rust: let root = std::env::temp_dir().join(format!("horizon-ctm-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&root);
    // rust: let ctm = root.join("assets/minecraft/optifine/ctm");
    // rust: std::fs::create_dir_all(ctm.join("b")).unwrap();
    // rust: std::fs::write(
    // rust: ctm.join("b/block_stone.properties"),
    // rust: "method=fixed\ntiles=0",
    // rust: )
    // rust: .unwrap();
    // rust: std::fs::write(ctm.join("a.properties"), "matchBlocks=stone\nmethod=spiral").unwrap();
        // ISO-8859-1, as Java reads it: "É" is one byte.
    // rust: let latin1 = b"matchBlocks=furnace\nmethod=fixed\ntiles=0\nname=\xc9p\xe9e\n";
    // rust: std::fs::write(ctm.join("c.properties"), latin1).unwrap();
    // rust: std::fs::write(ctm.join("z.properties"), "method=fixed\ntiles=0").unwrap();
    // rust: let rules = load(&root);
    // rust: let names: Vec<_> = rules
    // rust: .iter()
    // rust: .map(|r| r.path.rsplit('/').next().unwrap())
    // rust: .collect();
        // The broken a.properties is left out; the tile rule z comes first.
    // rust: assert_eq!(
    // rust: names,
    // rust: ["z.properties", "block_stone.properties", "c.properties"]
    // rust: );
    // rust: assert!(rules[2].applies_at(faces::UP, 0, "plains", Some("Épée")));
    // rust: std::fs::remove_dir_all(&root).unwrap();
}
}
