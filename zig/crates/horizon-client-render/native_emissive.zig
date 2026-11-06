//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_native_emissive
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Optional, texture-matched overlays drawn full bright over their base texture in the same
//! terrain fragment: native mods' (`<ns>:emissive/...`) and OptiFine's emissive block textures
//! (`block/stone_e.png` beside `block/stone.png`). No extra draw calls or world light changes.
// use crate::sprites::Sprites;
// use std::{collections::BTreeMap, path::Path};

/// Overlay pairs the terrain shader reads (`Globals.emissive_layers`, terrain.wgsl).
pub const MAX: usize = 128;
/// Native mods' own `emissive/` textures, as their API documents.
pub const NATIVE: usize = 32;

/// Load only bounded, explicitly named emissive textures from the active pack.
pub fn load(root: *Path, sprites: *mut Sprites) void {
}
    // rust: let mut names: Vec<_> = crate::atlas_sources::list_textures(root)
    // rust: .into_iter()
    // rust: .filter(|name| {
    // rust: name.split_once(':')
    // rust: .is_some_and(|(_, p)| p.starts_with("emissive/"))
    // rust: })
    // rust: .take(NATIVE)
    // rust: .collect();
    // rust: names.sort();
    // rust: for name in names {
    // rust: let file = crate::atlas_sources::texture_path(root, &name, "textures");
    // rust: if std::fs::metadata(file).is_ok_and(|m| m.len() <= 1 << 20) {
    // rust: let _ = sprites.insert(root, &name);
}
}
}

/// A connected-texture tile's sprite name without `.png`: tiles outside `textures/` are named by
/// their resource path (`Sprites::insert_file`, which only they use), block sprites by an id.
pub fn tile_file(name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: name.strip_prefix("assets/")?;
    // rust: name.strip_suffix(".png")
}

/// OptiFine's emissive overlays of the block sprites already loaded (what the terrain draws;
/// items draw from the HUD atlas): for each
/// `<ns>:block/<name>`, or connected-texture tile `assets/<ns>/.../<name>.png`, whose
/// `<name><suffix>.png` sits beside it, the overlay is loaded too and paired with it, blocks
/// first, then tiles, each by name, at most [`MAX`] - [`NATIVE`] (native mods keep their share of
/// the table). A pack without such files adds nothing.
pub fn load_optifine(root: *Path, sprites: *mut Sprites) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let suffix = horizon_optifine::emissive::suffix(root);
    // Blocks with identical pixels share a layer (and the shader pairs by layer): a shared
    // base would glow on every block that shares it, so it gets no overlay.
    // rust: let mut sharing: BTreeMap<u32, usize> = BTreeMap::new();
    // rust: for layer in sprites.layers.values() {
    // rust: *sharing.entry(*layer).or_default() += 1;
}
    // rust: let mut bases: Vec<String> = sprites
    // rust: .layers
    // rust: .iter()
    // rust: .filter(|(name, layer)| {
    // rust: sharing[layer] == 1
    // rust: && (name
    // rust: .split_once(':')
    // rust: .is_some_and(|(_, p)| p.starts_with("block/") && !p.ends_with(&suffix))
    // rust: || tile_file(name).is_some_and(|stem| !stem.ends_with(&suffix)))
    // rust: })
    // rust: .map(|(name, _)| name.clone())
    // rust: .collect();
    // Blocks before tiles: a pack's many tiles must not crowd vanilla blocks' overlays out.
    // rust: bases.sort_by_key(|name| (tile_file(name).is_some(), name.clone()));
    // rust: let mut pairs = Vec::new();
    // rust: for base in bases {
        // A tile is named by its file, a block sprite by its id.
    // rust: let (overlay, file) = match tile_file(&base) {
    // rust: Some(stem) => {
    // rust: let overlay = format!("{stem}{suffix}.png");
    // rust: (overlay.clone(), root.join(overlay))
}
    // rust: None => {
    // rust: let overlay = format!("{base}{suffix}");
    // rust: let file = crate::atlas_sources::texture_path(root, &overlay, "textures");
    // rust: (overlay, file)
}
}
    // rust: if !std::fs::metadata(&file).is_ok_and(|m| m.is_file()) {
    // rust: continue;
}
    // rust: if pairs.len() == MAX - NATIVE {
    // rust: log::warn!(
    // rust: "Horizon: more than {} emissive block overlays: {overlay} and later skipped",
    // rust: MAX - NATIVE
    // rust: );
    // rust: break;
}
    // rust: if std::fs::metadata(&file).is_ok_and(|m| m.len() > 1 << 20) {
    // rust: log::warn!("Horizon: emissive overlay {overlay} is over 1 MiB, skipped");
    // rust: continue;
}
        // A file that doesn't load would glow as the missing texture: no pair instead.
    // rust: let loaded = if overlay.starts_with("assets/") {
    // rust: sprites.insert_file(root, &overlay)
    // rust: } else {
    // rust: sprites.try_insert(root, &overlay)
}
    // rust: match loaded {
    // rust: Ok(_) => pairs.push((base, overlay)),
    // rust: Err(e) => log::warn!("Horizon: emissive overlay {overlay} skipped: {e}"),
}
}
    // rust: pairs
}

/// The overlay layer's flag (its high bit) for an OptiFine overlay, which draws cutout: opaque
/// where its alpha is at least 0.1 (OptiFine renders SOLID textures' overlays as CUTOUT).
pub const CUTOUT: u32 = 1 << 31;

/// The frame's overlay table: native mods' pairs (at most [`NATIVE`] requested), then the packs'
/// OptiFine pairs flagged [`CUTOUT`] (at most [`MAX`] - [`NATIVE`], as [`load_optifine`] loads),
/// one per base layer with native mods' first, sorted by base layer for the shader's early exit.
    // rust: pub fn table<'a>(
    // rust: layers: &BTreeMap<String, u32>,
    // rust: native: impl IntoIterator<Item = (&'a str, &'a str)>,
    // rust: optifine: &'a [(String, String)],
    // rust: ) -> Vec<[u32; 4]> {
    // rust: let mut by_base: BTreeMap<u32, [u32; 4]> = BTreeMap::new();
    // rust: for pair in mappings(layers, native.into_iter().take(NATIVE)) {
    // rust: by_base.insert(pair[0], pair);
}
    // rust: let optifine = optifine.iter().map(|(b, o)| (b.as_str(), o.as_str()));
    // rust: for [b, o, z, w] in mappings(layers, optifine) {
    // rust: by_base.entry(b).or_insert([b, o | CUTOUT, z, w]);
}
    // rust: by_base.into_values().collect()
}

/// Only loaded base/overlay pairs are sent to the GPU; sorted for vertex lookup.
    // rust: pub fn mappings<'a>(
    // rust: layers: &BTreeMap<String, u32>,
    // rust: requests: impl IntoIterator<Item = (&'a str, &'a str)>,
    // rust: ) -> Vec<[u32; 4]> {
    // rust: let mut pairs = BTreeMap::new();
    // rust: for (base, overlay) in requests.into_iter().take(MAX) {
    // rust: if let (Some(&b), Some(&o)) = (layers.get(base), layers.get(overlay)) {
    // rust: pairs.entry(b).or_insert(o);
}
}
    // rust: pairs.into_iter().map(|(b, o)| [b, o, 0, 0]).collect()
}

    // rust: mod tests {
//     use super::*;

    /// A 16x16 image of one colour, `shade` its red (images of different shades never share a
    /// sprite layer).
pub fn png(path: *Path, shade: u8) void {
}
    // rust: std::fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: let file = std::io::BufWriter::new(std::fs::File::create(path).unwrap());
    // rust: let mut encoder = png::Encoder::new(file, 16, 16);
    // rust: encoder.set_color(png::ColorType::Rgba);
    // rust: encoder.set_depth(png::BitDepth::Eight);
    // rust: let mut writer = encoder.write_header().unwrap();
    // rust: let pixels: Vec<u8> = (0..16 * 16).flat_map(|_| [shade, 9, 9, 255]).collect();
    // rust: writer.write_image_data(&pixels).unwrap();
}

pub fn optifine_overlays_pair_with_their_loaded_blocks() void {
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-block-emissive-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&root);
    // rust: let block = root.join("assets/minecraft/textures/block");
    // rust: let names = [
    // rust: "stone",
    // rust: "stone_e",
    // rust: "dirt",
    // rust: "glowstone_e",
    // rust: "deepslate",
    // rust: "deepslate_glow",
    // rust: "andesite",
    // rust: "granite",
    // rust: ];
    // rust: for (i, name) in names.iter().enumerate() {
    // rust: png(&block.join(format!("{name}.png")), i as u8 * 20);
}
        // Same pixels as andesite: the two share a layer, so neither gets an overlay.
    // rust: png(&block.join("diorite.png"), 6 * 20);
    // rust: png(&block.join("diorite_e.png"), 200);
        // A broken overlay: skipped, not drawn as the missing texture.
    // rust: std::fs::write(block.join("granite_e.png"), b"not a png").unwrap();
    // rust: png(&root.join("assets/minecraft/textures/item/stick.png"), 210);
    // rust: png(
    // rust: &root.join("assets/minecraft/textures/item/stick_e.png"),
    // rust: 220,
    // rust: );
    // rust: let mut sprites = Sprites::default();
    // rust: for name in [
    // rust: "stone",
    // rust: "dirt",
    // rust: "deepslate",
    // rust: "andesite",
    // rust: "diorite",
    // rust: "granite",
    // rust: ] {
    // rust: sprites
    // rust: .insert(&root, &format!("minecraft:block/{name}"))
    // rust: .unwrap();
}
        // Items draw from the HUD atlas, not the terrain: no pair.
    // rust: sprites.insert(&root, "minecraft:item/stick").unwrap();
        // glowstone isn't loaded: its overlay pairs with nothing.
    // rust: let pairs = load_optifine(&root, &mut sprites);
    // rust: assert_eq!(
    // rust: pairs,
    // rust: [(
    // rust: "minecraft:block/stone".into(),
    // rust: "minecraft:block/stone_e".into()
    // rust: )]
    // rust: );
    // rust: assert!(sprites.layers.contains_key("minecraft:block/stone_e"));
    // rust: assert!(!sprites.layers.contains_key("minecraft:block/granite_e"));
        // The pack's own suffix.
    // rust: let props = root.join("assets/minecraft/optifine/emissive.properties");
    // rust: std::fs::create_dir_all(props.parent().unwrap()).unwrap();
    // rust: std::fs::write(&props, "suffix.emissive=_glow").unwrap();
        // Connected-texture tiles pair with the overlay beside them.
    // rust: let tiles = root.join("assets/minecraft/optifine/ctm/lamp");
    // rust: png(&tiles.join("0.png"), 230);
    // rust: png(&tiles.join("0_glow.png"), 240);
    // rust: png(&tiles.join("1.png"), 250);
        // A tile outside `ctm/` (`tiles=~/glass/2`) is a tile all the same.
    // rust: png(&root.join("assets/minecraft/optifine/glass/2.png"), 245);
    // rust: png(
    // rust: &root.join("assets/minecraft/optifine/glass/2_glow.png"),
    // rust: 246,
    // rust: );
    // rust: for tile in ["ctm/lamp/0", "ctm/lamp/1", "glass/2"] {
    // rust: sprites
    // rust: .insert_file(&root, &format!("assets/minecraft/optifine/{tile}.png"))
    // rust: .unwrap();
}
    // rust: let pairs = load_optifine(&root, &mut sprites);
    // rust: assert_eq!(
    // rust: pairs,
            // Blocks first, then tiles.
    // rust: [
    // rust: (
    // rust: "minecraft:block/deepslate".into(),
    // rust: "minecraft:block/deepslate_glow".into()
    // rust: ),
    // rust: (
    // rust: "assets/minecraft/optifine/ctm/lamp/0.png".into(),
    // rust: "assets/minecraft/optifine/ctm/lamp/0_glow.png".into()
    // rust: ),
    // rust: (
    // rust: "assets/minecraft/optifine/glass/2.png".into(),
    // rust: "assets/minecraft/optifine/glass/2_glow.png".into()
    // rust: ),
    // rust: ]
    // rust: );
    // rust: std::fs::remove_dir_all(&root).unwrap();
}

pub fn the_table_keeps_native_pairs_first_and_flags_optifine_cutout() void {
}
    // rust: let layers: BTreeMap<String, u32> =
    // rust: [("a", 5), ("a_e", 6), ("b", 2), ("b_e", 3), ("native", 9)]
    // rust: .map(|(n, l)| (n.to_owned(), l))
    // rust: .into();
    // rust: let optifine = [
    // rust: ("a".to_owned(), "a_e".to_owned()),
    // rust: ("b".to_owned(), "b_e".to_owned()),
    // rust: ];
        // A native mod pairs `a` too: its pair wins; `b` stays the pack's, flagged.
    // rust: let t = table(&layers, [("a", "native")], &optifine);
    // rust: assert_eq!(
    // rust: t,
    // rust: [[2, 3 | CUTOUT, 0, 0], [5, 9, 0, 0]],
    // rust: "sorted by base layer"
    // rust: );
        // Native mods keep their 32: of 40 requests on 40 bases, the first 32.
    // rust: let layers: BTreeMap<String, u32> =
    // rust: (0..41u32).map(|i| (format!("s{i}"), 100 + i)).collect();
    // rust: let names: Vec<String> = (1..41).map(|i| format!("s{i}")).collect();
    // rust: let many = names.iter().map(|n| (n.as_str(), "s0"));
    // rust: let t = table(&layers, many, &[]);
    // rust: assert_eq!(t.len(), 32);
    // rust: assert_eq!(
    // rust: t.last(),
    // rust: Some(&[132, 100, 0, 0]),
    // rust: "s32 last; s33 to s40 cut"
    // rust: );
}
pub fn only_existing_pairs_are_mapped() void {
}
    // rust: let layers = [
    // rust: ("minecraft:block/ore".into(), 3),
    // rust: ("mine:emissive/ore".into(), 7),
    // rust: ]
    // rust: .into();
    // rust: assert_eq!(
    // rust: mappings(
    // rust: &layers,
    // rust: [
    // rust: ("minecraft:block/ore", "mine:emissive/ore"),
    // rust: ("missing", "mine:emissive/ore")
    // rust: ]
    // rust: ),
    // rust: vec![[3, 7, 0, 0]]
    // rust: );
}
}
