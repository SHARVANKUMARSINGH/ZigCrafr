//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_sprites
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Shared nearest-sampled sprite array for block and item textures.
// use crate::Result;
// use horizon_assets::animation::{AnimationClip, AnimationMetadata};
// use std::{collections::BTreeMap, path::Path, sync::Arc};

pub const SpriteAnimation = struct {
    layer: u32,
    frames: *std.ArrayList(Vec<u8)>,
    clip: *AnimationClip,
    materials: [?*std.ArrayList(Vec<u8)>,
};
/// What an animated sprite shows: `frame`, mixed `millis` thousandths of the
/// way towards `next` (0 for a single frame).
pub const FrameBlend = struct {
    frame: usize,
    next: usize,
    millis: u32,
};
    // rust: impl SpriteAnimation {
    // rust: pub(crate) fn has_materials(&self) -> bool {
    // rust: self.materials.iter().any(Option::is_some)
}
    /// Material categories follow the selected colour frame, without colour interpolation.
    // rust: pub(crate) fn material_pixels(&self, kind: usize, tick: u64) -> Option<&[u8]> {
    // rust: let frames = self.materials[kind].as_ref()?;
    // rust: Some(&frames[self.frame(tick) % frames.len()])
}
pub fn frame(self: *Self, tick: u64) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.clip.sample(tick).frame as usize
}
    /// `SpriteContents.AnimationState.drawToAtlas`: an animation with
    /// `interpolate` mixes the frame with the next one by
    /// `(int)(subFrame / time * 1000)` thousandths; others show the frame.
pub fn blend(self: *Self, tick: u64) F {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let sample = self.clip.sample(tick);
    // rust: let frame = sample.frame as usize;
    // rust: let next = sample.next_frame as usize;
    // rust: if self.clip.interpolates() && sample.interpolation_millis > 0 && next != frame {
    // rust: FrameBlend {
    // rust: frame,
    // rust: next,
    // rust: millis: sample.interpolation_millis,
}
    // rust: } else {
    // rust: FrameBlend {
    // rust: frame,
    // rust: next: frame,
    // rust: millis: 0,
}
}
}
pub fn resized_pixels(self: *Self, frame: usize, width: u32, height: u32) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let source = self.pixels(frame);
    // rust: let side = (source.len() / 4).isqrt() as u32;
    // rust: let mut out = Vec::with_capacity((width * height * 4) as usize);
    // rust: for y in 0..height {
    // rust: for x in 0..width {
    // rust: let offset = ((y * side / height * side + x * side / width) * 4) as usize;
    // rust: out.extend_from_slice(&source[offset..offset + 4]);
}
}
    // rust: out
}
pub fn pixels(self: *Self, frame: usize) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.frames[frame]
}
pub fn frame_count(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.frames.len()
}
}

pub const StillKey = struct {
    frame: u64,
    pbr: u64,
    side: u32,
    settings: [u32,
    flags: [bool,
};

pub const Sprites = struct {
    /// Edge length of every array layer and the layers' current frames, set
    /// by [`Sprites::finish`].
    size: u32,
    /// Smallest native layer before array-size resampling.
    minimum_size: u32,
    pixels: std.ArrayList(u8),
    layers: BTreeMap<[]const u8,
    animations: std.ArrayList(SpriteAnimation),
    opaque: std.ArrayList(bool),
    translucent: std.ArrayList(bool),
    /// Each layer's `MipmapGenerator` settings.
    mips: std.ArrayList(crate::mipmap::Settings),
    /// Each layer's frames at the texture's own resolution (square), and the
    /// frame shown first.
    native: Vec<(u32,
    /// Each layer's LabPBR maps (`_n` normals, `_s` specular) beside its texture: their
    /// frames at their own resolution (square).
    pbr: Vec<[Option<(u32,
    /// The layers' normal and specular maps at `pbr_size`, layer after layer, set by
    /// [`Sprites::finish`]: empty when no texture has either.
    normals: std.ArrayList(u8),
    specular: std.ArrayList(u8),
    pbr_size: u32,
    /// Still textures by their pixels, their LabPBR maps and mip settings: mods copy vanilla's
    /// textures under their own names, and one layer serves them all (the GPU's array may
    /// hold as few as 2048).
    still: std::collections::HashMap<StillKey,
    /// Decoded textures kept on disk between launches ([`Sprites::with_disk_cache`]).
    disk: ?crate::sprite_cache::SpriteCache,
    /// Textures [`Sprites::prefetch`] decoded ahead of their insert, by sprite name or
    /// resource path.
    ready: std::collections::HashMap<[]const u8,
};
/// Edge length of vanilla's block textures: the smallest array layer.
pub const SPRITE_SIZE: u32 = 16;
/// The largest sprite array (all layers of the top mip level) when the settings leave it to
/// Horizon: resource packs with bigger textures are sampled down to fit.
pub const DEFAULT_TEXTURE_BUDGET: u64 = 256 << 20;
/// The budget in bytes the next resource load keeps to (`set_texture_budget`).
    // rust: static TEXTURE_BUDGET: std::sync::atomic::AtomicU64 =
    // rust: std::sync::atomic::AtomicU64::new(DEFAULT_TEXTURE_BUDGET);
/// The block textures' budget from the `textureBudgetMiB` setting (0 for the default), for
/// resources loaded from now on.
pub fn set_texture_budget(mib: u32) void {
}
    // rust: let bytes = match mib {
    // rust: 0 => DEFAULT_TEXTURE_BUDGET,
    // rust: mib => u64::from(mib) << 20,
}
    // rust: TEXTURE_BUDGET.store(bytes, std::sync::atomic::Ordering::Relaxed);
}
/// Whether resource loads read the resource packs' LabPBR maps (`set_labpbr_maps`).
pub const LABPBR_MAPS: std::sync::atomic::AtomicBool = std::sync::atomic::AtomicBool::new(false);
/// Whether resource loads from now on read the resource packs' LabPBR maps beside their block
/// textures. Native material stages and terrain shader packs read them; without a pack they cost
/// neither loading time nor video memory.
pub fn set_labpbr_maps(on: bool) void {
}
    // rust: LABPBR_MAPS.store(on, std::sync::atomic::Ordering::Relaxed);
}
/// Whether resource loads read the LabPBR maps (`set_labpbr_maps`).
pub fn labpbr_maps() b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: LABPBR_MAPS.load(std::sync::atomic::Ordering::Relaxed)
}
/// Budget for either complete normal or specular image set: a quarter of the block textures'
/// budget, so raising `textureBudgetMiB` sharpens a pack's LabPBR maps along with its colours.
pub fn map_bytes(texture_budget: u64) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: texture_budget / 4
}
/// [`map_bytes`] for the budget the next resource load keeps to.
pub fn max_map_bytes() u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: map_bytes(TEXTURE_BUDGET.load(std::sync::atomic::Ordering::Relaxed))
}
/// Fewer layers than any game has (vanilla's are about 1300): what a map is kept at while
/// loading assumes at least these many share the array.
pub const LAYERS_AT_LEAST: u64 = 1024;
/// A layer's normal map where its texture has none: flat, unoccluded, at full height.
pub const FLAT_NORMAL: [u8; 4] = [128, 128, 255, 255];
/// A layer's specular map where its texture has none: rough, not metal, not glowing.
pub const NO_SPECULAR: [u8; 4] = [0, 0, 0, 0];
/// The largest power-of-two side from `start` down (at least `SPRITE_SIZE`) at which `layers`
/// square RGBA layers take at most `bytes`.
pub fn side_within(start: u32, layers: u64, bytes: u64) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut size = start.max(SPRITE_SIZE).next_power_of_two();
    // rust: while size > SPRITE_SIZE && layers * u64::from(size) * u64::from(size) * 4 > bytes {
    // rust: size /= 2;
}
    // rust: size
}
/// Reduce data maps by selecting whole texels: material IDs and sentinel bytes cannot be averaged.
pub fn shrink_map(frame: std.ArrayList(u8), side: u32, max: u32) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if side <= max || !side.is_power_of_two() || !max.is_power_of_two() {
    // rust: return (side, frame);
}
    // rust: (max, resample(&frame, side, max))
}
/// Nearest-resample a square RGBA frame to another square size.
    // rust: pub(crate) fn resample(frame: &[u8], from: u32, to: u32) -> Vec<u8> {
    // rust: if from == to {
    // rust: return frame.to_vec();
}
    // rust: let mut out = Vec::with_capacity((to * to * 4) as usize);
    // rust: for row in 0..to {
    // rust: let source_row = row * from / to;
    // rust: for column in 0..to {
    // rust: let offset = ((source_row * from + column * from / to) * 4) as usize;
    // rust: out.extend_from_slice(&frame[offset..offset + 4]);
}
}
    // rust: out
}
    // rust: impl Sprites {
    /// Sprites that reuse textures decoded by an earlier launch, kept in a
    /// cache file in `root`.
pub fn with_disk_cache(root: *Path) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: disk: crate::sprite_cache::SpriteCache::open(root),
    // rust: ..Self::default()
}
}
    /// Write what this run decoded to the cache file.
pub fn save_disk_cache(self: *Self) void {
}
    // rust: if let Some(disk) = &mut self.disk {
    // rust: disk.save();
}
}
    /// How many array layers the textures take.
pub fn count(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.native.len()
}
    /// `SpriteContents.computeTransparency(u0, v0, u1, v1)` is NONE: every texel under
    /// the quad's UV box is fully opaque in every frame, so the quad needs no alpha test.
pub fn region_opaque(self: *Self, layer: u32, uv: *[[f32; 2]; 4]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.opaque[layer as usize] {
    // rust: return true;
}
    // rust: let (side, frames, _) = &self.native[layer as usize];
    // rust: let side = *side as usize;
    // rust: let range = |axis: usize| {
    // rust: let lo = uv.iter().map(|p| p[axis]).fold(f32::INFINITY, f32::min);
    // rust: let hi = uv.iter().map(|p| p[axis]).fold(f32::NEG_INFINITY, f32::max);
    // rust: let clamp = |v: f32| (v.max(0.0) as usize).min(side);
    // rust: clamp((lo * side as f32).floor())..clamp((hi * side as f32).ceil())
}
    // rust: let (columns, rows) = (range(0), range(1));
    // rust: frames.iter().all(|frame| {
    // rust: rows.clone().all(|y| {
    // rust: columns
    // rust: .clone()
    // rust: .all(|x| frame[(y * side + x) * 4 + 3] == 255)
    // rust: })
    // rust: })
}
    /// Lay every layer out at one size: the largest texture's (resource packs
    /// may ship 32x, 64x... textures, like vanilla's stitched atlas), rounded
    /// up to a power of two and limited to the texture budget (`set_texture_budget`). Smaller
    /// textures are scaled up by whole pixels, so UVs stay per layer.
pub fn finish(self: *Self) void {
}
    // rust: self.lay_out(true);
}
    /// [`Sprites::finish`] for a server, which draws nothing: the layers'
    /// size, but neither their pixels nor the animations' frames.
pub fn finish_without_pixels(self: *Self) void {
}
    // rust: self.lay_out(false);
}
pub fn lay_out(self: *Self, pixels: bool) void {
}
        // Prefetched textures nothing inserted.
    // rust: self.ready = Default::default();
    // rust: let layers = self.native.len().max(1) as u64;
    // rust: let largest = self.native.iter().map(|n| n.0).max().unwrap_or(SPRITE_SIZE);
    // rust: self.minimum_size = self.native.iter().map(|n| n.0).min().unwrap_or(SPRITE_SIZE);
    // rust: let budget = TEXTURE_BUDGET.load(std::sync::atomic::Ordering::Relaxed);
    // rust: let size = side_within(largest, layers, budget);
    // rust: if pixels {
    // rust: log::info!(
    // rust: "Horizon: block sprites: {layers} layers at {size} px (largest {largest} px, budget {} MiB)",
    // rust: budget >> 20
    // rust: );
}
    // rust: if !pixels {
    // rust: self.pixels = Vec::new();
    // rust: self.animations = Vec::new();
    // rust: self.pbr = Vec::new();
    // rust: self.size = size;
    // rust: return;
}
    // rust: let mut resized = Vec::with_capacity(self.native.len());
    // rust: self.pixels.clear();
    // rust: for (from, frames, initial) in &self.native {
    // rust: let frames: Arc<Vec<Vec<u8>>> =
    // rust: Arc::new(frames.iter().map(|f| resample(f, *from, size)).collect());
    // rust: self.pixels.extend_from_slice(&frames[*initial]);
    // rust: resized.push(frames);
}
    // rust: for animation in &mut self.animations {
    // rust: animation.frames = resized[animation.layer as usize].clone();
}
    // rust: self.size = size;
    // rust: self.normals.clear();
    // rust: self.specular.clear();
    // rust: let largest_map = self.pbr.iter().flatten().flatten().map(|m| m.0).max();
    // rust: self.pbr_size = largest_map.map_or(SPRITE_SIZE, |l| {
    // rust: side_within(l.min(size), layers, max_map_bytes())
    // rust: });
    // rust: if largest_map.is_some() {
    // rust: let pbr_size = self.pbr_size;
    // rust: log::info!("Horizon: LabPBR maps at {pbr_size} px, {layers} layers");
    // rust: for animation in &mut self.animations {
    // rust: animation.materials = self.pbr[animation.layer as usize].each_ref().map(|map| {
    // rust: map.as_ref().map(|(from, frames)| {
    // rust: Arc::new(
    // rust: frames
    // rust: .iter()
    // rust: .map(|frame| resample(frame, *from, pbr_size))
    // rust: .collect(),
    // rust: )
    // rust: })
    // rust: });
}
    // rust: for (layer, maps) in std::mem::take(&mut self.pbr).into_iter().enumerate() {
    // rust: for (map, (out, none)) in maps.into_iter().zip([
    // rust: (&mut self.normals, FLAT_NORMAL),
    // rust: (&mut self.specular, NO_SPECULAR),
    // rust: ]) {
    // rust: match map {
    // rust: Some((from, frames)) => {
    // rust: let initial = self.native[layer].2 % frames.len();
    // rust: let (from, pixels) =
    // rust: shrink_map(frames[initial].clone(), from, pbr_size);
    // rust: out.extend(resample(&pixels, from, pbr_size));
}
    // rust: None => out.extend(none.repeat((pbr_size * pbr_size) as usize)),
}
}
}
}
}
    /// [`Sprites::insert`] without the missing-texture fallback: a file that doesn't load is an
    /// error, and nothing is added.
pub fn try_insert(self: *Self, root: *Path, name: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.layers.get(name) {
    // rust: Some(layer) => Ok(*layer),
    // rust: None => self.load(root, name),
}
}
    /// The layer of a texture, added on first use. A texture that is missing
    /// or does not load (a resource pack's filter or a broken file) becomes
    /// vanilla's missing texture, as in a stitched atlas.
pub fn insert(self: *Self, root: *Path, name: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(layer) = self.layers.get(name) {
    // rust: return Ok(*layer);
}
    // rust: match self.load(root, name) {
    // rust: Ok(layer) => Ok(layer),
    // rust: Err(e) => {
                // `MissingTextureAtlasSprite.getLocation()`: vanilla models name the
                // missing texture on purpose (block/air.json's particle), #853.
    // rust: if name != "minecraft:missingno" {
    // rust: log::warn!("Horizon: using the missing texture for {name}: {e}");
}
                // MissingTextureAtlasSprite.generateMissingImage: 16x16,
                // magenta and black quarters.
    // rust: let frame: Vec<u8> = (0..SPRITE_SIZE * SPRITE_SIZE)
    // rust: .flat_map(|i| {
    // rust: let (x, y) = (i % SPRITE_SIZE, i / SPRITE_SIZE);
    // rust: if (y < SPRITE_SIZE / 2) ^ (x < SPRITE_SIZE / 2) {
    // rust: [248, 0, 248, 255]
    // rust: } else {
    // rust: [0, 0, 0, 255]
}
    // rust: })
    // rust: .collect();
    // rust: let layer = u32::try_from(self.native.len())?;
    // rust: self.opaque.push(true);
    // rust: self.pbr.push([None, None]);
    // rust: self.translucent.push(false);
    // rust: self.mips.push(crate::mipmap::Settings::default());
    // rust: self.layers.insert(name.to_owned(), layer);
    // rust: self.native.push((SPRITE_SIZE, Arc::new(vec![frame]), 0));
    // rust: Ok(layer)
}
}
}
    /// Decode on every thread the textures about to be inserted: sprite names, or resource
    /// paths outside `textures/` (as [`Sprites::insert_file`] takes them). A loader that adds
    /// many (the block models, an OptiFine pack's tiles) calls this first and then inserts
    /// them in its own order, so the layers are the same as without it. What is already a
    /// layer or in the disk cache is skipped; what fails to decode is left for the insert,
    /// which reports it.
    // rust: pub fn prefetch<'a>(&mut self, root: &Path, names: impl IntoIterator<Item = &'a str>) {
    // rust: let names: Vec<&str> = names
    // rust: .into_iter()
    // rust: .filter(|name| {
    // rust: !self.layers.contains_key(*name)
    // rust: && !self.ready.contains_key(*name)
    // rust: && self.disk.as_ref().is_none_or(|d| d.get(name).is_none())
    // rust: })
    // rust: .collect::<std::collections::BTreeSet<_>>()
    // rust: .into_iter()
    // rust: .collect();
    // rust: let decoded = crate::par::par_map(&names, |name| {
    // rust: if name.contains(':') {
    // rust: Self::decode(root, name).ok()
    // rust: } else {
    // rust: Self::decode_file(&root.join(name), name).ok()
}
    // rust: });
    // rust: for (name, decoded) in names.into_iter().zip(decoded) {
    // rust: if let Some(decoded) = decoded {
    // rust: self.ready.insert(name.to_owned(), decoded);
}
}
}
pub fn load(self: *Self, root: *Path, name: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
        // Custom Item Textures' files are outside `textures/`, which the disk cache's
        // fingerprint covers: like `insert_file`'s, they skip it.
    // rust: let cit = name.starts_with("horizon_cit:");
    // rust: let disk = self.disk.as_mut().filter(|_| !cit);
    // rust: let cached = disk.as_ref().and_then(|d| d.get(name)).cloned();
    // rust: let decoded = match cached {
    // rust: Some(decoded) => decoded,
    // rust: None => {
    // rust: let decoded = match self.ready.remove(name) {
    // rust: Some(decoded) => decoded,
    // rust: None => Self::decode(root, name)?,
}
    // rust: if let Some(disk) = disk {
    // rust: disk.insert(name, decoded.clone());
}
    // rust: decoded
}
}
    // rust: self.register(root, name, decoded)
}
    /// The layer of a texture outside `textures/` (an OptiFine pack's connected-texture tile),
    /// named by its resource path and added on first use. Unlike [`Sprites::insert`], a texture
    /// that does not load is an error: the caller drops what needed it. Such files bypass the
    /// disk cache, whose fingerprint covers only `textures/`.
pub fn insert_file(self: *Self, root: *Path, resource: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(layer) = self.layers.get(resource) {
    // rust: return Ok(*layer);
}
    // rust: let decoded = match self.ready.remove(resource) {
    // rust: Some(decoded) => decoded,
    // rust: None => Self::decode_file(&root.join(resource), resource)?,
}
    // rust: self.register(root, resource, decoded)
}
    /// The tiles of the texture `name` (`ns:path`) cut into a `columns` x `rows` grid, row by
    /// row from the top left: a Fusion connecting texture's sheet. Each tile is its own layer
    /// (named `fusion/<ns>/<path>#<tile>`); a fully transparent one is `None`, as Fusion skips
    /// empty tiles. Tiles are square, as wide as a column. An animated sheet's frames are whole
    /// grids one below the other, or with `per_tile` each cell is a column of its tile's frames.
    /// The sheet's own layer, if models already show it, shows its first tile from then on.
    // rust: pub fn insert_tiles(
    // rust: &mut self,
    // rust: root: &Path,
    // rust: name: &str,
    // rust: (columns, rows): (u32, u32),
    // rust: per_tile: bool,
    // rust: ) -> Result<Vec<Option<u32>>> {
    // rust: let path = crate::atlas_sources::texture_path(root, name, "textures");
    // rust: let metadata = match horizon_core::prepared_files::read_to_string(
    // rust: &path.with_extension("png.mcmeta"),
    // rust: ) {
    // rust: Ok(text) => Some(serde_json::from_str::<
    // rust: BTreeMap<String, Box<serde_json::value::RawValue>>,
    // rust: >(&text)?),
    // rust: Err(error) if error.kind() == std::io::ErrorKind::NotFound => None,
    // rust: Err(error) => return Err(error.into()),
}
    // rust: let animation = metadata
    // rust: .as_ref()
    // rust: .and_then(|m| m.get("animation"))
    // rust: .map(|v| v.get().to_owned());
        // The sheet's `texture` section is each tile's.
    // rust: let texture = texture_section(metadata.as_ref());
    // rust: let strategy = texture
    // rust: .as_ref()
    // rust: .and_then(|t| t["mipmap_strategy"].as_str())
    // rust: .and_then(crate::mipmap::Strategy::parse)
    // rust: .unwrap_or_default();
    // rust: let alpha_cutoff_bias = texture
    // rust: .as_ref()
    // rust: .and_then(|t| t["alpha_cutoff_bias"].as_f64())
    // rust: .unwrap_or(0.0) as f32;
    // rust: let (width, height, pixels) = read_rgba(&path)?;
    // rust: let side = width / columns.max(1);
        // How far down the next frame of a tile is, and the next row of tiles.
    // rust: let (frame_step, row_step) = match per_tile {
    // rust: true => (side, height / rows.max(1)),
    // rust: false => (rows * side, side),
}
    // rust: let frames = match per_tile {
    // rust: true => row_step / side.max(1),
    // rust: false => height / frame_step.max(1),
}
    // rust: let whole = match per_tile {
    // rust: true => height % rows.max(1) == 0 && row_step % side.max(1) == 0,
    // rust: false => height % frame_step.max(1) == 0,
}
    // rust: if side == 0 || frames == 0 || width % columns.max(1) != 0 || !whole {
    // rust: return Err(format!("{name} isn't a {columns} x {rows} grid of square tiles").into());
}
    // rust: let tiles = (0..columns * rows)
    // rust: .map(|tile| {
    // rust: let frames: Vec<Vec<u8>> = (0..frames)
    // rust: .map(|f| {
    // rust: let (x, y) = (
    // rust: tile % columns * side,
    // rust: tile / columns * row_step + f * frame_step,
    // rust: );
    // rust: (y..y + side)
    // rust: .flat_map(|row| {
    // rust: let start = ((row * width + x) * 4) as usize;
    // rust: pixels[start..start + side as usize * 4].iter().copied()
    // rust: })
    // rust: .collect()
    // rust: })
    // rust: .collect();
    // rust: let alphas = || frames.iter().flat_map(|f| f.iter().skip(3).step_by(4));
    // rust: if alphas().all(|&a| a == 0) {
    // rust: return Ok(None);
}
    // rust: let decoded = crate::sprite_cache::Decoded {
    // rust: side,
    // rust: animation: animation.clone().filter(|_| frames.len() > 1),
    // rust: strategy,
    // rust: alpha_cutoff_bias,
    // rust: has_transparent: alphas().any(|&a| a == 0),
    // rust: opaque: alphas().all(|&a| a == 255),
    // rust: translucent: alphas().any(|&a| a != 0 && a != 255),
    // rust: frames,
}
    // rust: let tile_name = format!("fusion/{}#{tile}", name.replace(':', "/"));
    // rust: self.register(root, &tile_name, decoded).map(Some)
    // rust: })
    // rust: .collect::<Result<Vec<_>>>()?;
        // Where Fusion doesn't draw the sheet (items, other models), the lone tile rather than
        // the whole sheet squeezed square, whose size would set every layer's.
    // rust: if let (Some(&own), Some(&first)) = (self.layers.get(name), tiles.iter().flatten().next()) {
    // rust: self.show_as(own, first);
}
    // rust: Ok(tiles)
}
    /// Layer `layer` shows what `source` does, and is no longer the layer of its old pixels.
pub fn show_as(self: *Self, layer: u32, source: u32) void {
}
    // rust: self.still.retain(|_, l| *l != layer);
    // rust: let (l, s) = (layer as usize, source as usize);
    // rust: self.native[l] = self.native[s].clone();
    // rust: self.opaque[l] = self.opaque[s];
    // rust: self.translucent[l] = self.translucent[s];
    // rust: self.mips[l] = self.mips[s];
    // rust: self.pbr[l] = self.pbr[s].clone();
    // rust: self.animations.retain(|a| a.layer != layer);
    // rust: if let Some(animation) = self.animations.iter().find(|a| a.layer == source) {
    // rust: let animation = SpriteAnimation {
    // rust: layer,
    // rust: ..animation.clone()
}
    // rust: self.animations.push(animation);
}
}
    /// Read and decode one texture and its `.mcmeta`.
pub fn decode(root: *Path, name: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !name.contains(':') {
    // rust: return Err("invalid sprite identifier".into());
}
        // `texture_path`, so Custom Item Textures' `horizon_cit:` sprites find their file.
    // rust: let path = crate::atlas_sources::texture_path(root, name, "textures");
    // rust: Self::decode_file(&path, name)
}
pub fn decode_file(path: *Path, name: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let metadata = match horizon_core::prepared_files::read_to_string(
    // rust: &path.with_extension("png.mcmeta"),
    // rust: ) {
    // rust: Ok(text) => Some(serde_json::from_str::<
    // rust: BTreeMap<String, Box<serde_json::value::RawValue>>,
    // rust: >(&text)?),
    // rust: Err(error) if error.kind() == std::io::ErrorKind::NotFound => None,
    // rust: Err(error) => return Err(error.into()),
}
    // rust: let animation_text = metadata
    // rust: .as_ref()
    // rust: .and_then(|v| v.get("animation"))
    // rust: .map(|v| v.get().to_owned());
    // rust: let animation = animation_text
    // rust: .as_deref()
    // rust: .map(AnimationMetadata::from_json)
    // rust: .transpose()?;
    // rust: let (png_width, png_height, pixels) = read_rgba(path)?;
    // rust: let (width, height) = if let Some(animation) = &animation {
    // rust: let [width, height] =
    // rust: animation.frame_size(i32::try_from(png_width)?, i32::try_from(png_height)?);
    // rust: (u32::try_from(width)?, u32::try_from(height)?)
    // rust: } else {
    // rust: (png_width, png_height)
}
    // rust: if width == 0 || height == 0 || png_width % width != 0 || png_height % height != 0 {
    // rust: return Err(format!("sprite {name} has invalid frame dimensions").into());
}
    // rust: let columns = png_width / width;
    // rust: let count = columns * (png_height / height);
        // Layers are square; a frame of another shape is nearest-resampled to
        // its longer side so UVs (normalized per layer) are unchanged.
    // rust: let side = width.max(height);
    // rust: let mut frames = Vec::new();
    // rust: for index in 0..count {
    // rust: let x = index % columns * width;
    // rust: let y = index / columns * height;
    // rust: let mut frame = Vec::with_capacity((side * side * 4) as usize);
    // rust: for row in 0..side {
    // rust: let source_row = y + row * height / side;
    // rust: for column in 0..side {
    // rust: let offset =
    // rust: ((source_row * png_width + x + column * width / side) * 4) as usize;
    // rust: frame.extend_from_slice(&pixels[offset..offset + 4]);
}
}
    // rust: frames.push(frame);
}
    // rust: let texture = texture_section(metadata.as_ref());
    // rust: Ok(crate::sprite_cache::Decoded {
    // rust: side,
    // rust: frames,
    // rust: animation: animation_text,
    // rust: strategy: texture
    // rust: .as_ref()
    // rust: .and_then(|t| t["mipmap_strategy"].as_str())
    // rust: .and_then(crate::mipmap::Strategy::parse)
    // rust: .unwrap_or_default(),
    // rust: alpha_cutoff_bias: texture
    // rust: .as_ref()
    // rust: .and_then(|t| t["alpha_cutoff_bias"].as_f64())
    // rust: .unwrap_or(0.0) as f32,
    // rust: has_transparent: pixels.as_chunks::<4>().0.iter().any(|p| p[3] == 0),
    // rust: opaque: pixels.as_chunks::<4>().0.iter().all(|p| p[3] == 255),
    // rust: translucent: pixels
    // rust: .as_chunks::<4>()
    // rust: .0
    // rust: .iter()
    // rust: .any(|p| p[3] != 0 && p[3] != 255),
    // rust: })
}
    /// Give a decoded texture its layer (or the one an identical still has).
    // rust: fn register(
    // rust: &mut self,
    // rust: root: &Path,
    // rust: name: &str,
    // rust: decoded: crate::sprite_cache::Decoded,
    // rust: ) -> Result<u32> {
    // rust: let crate::sprite_cache::Decoded {
    // rust: side,
    // rust: frames,
    // rust: animation: animation_text,
    // rust: strategy,
    // rust: alpha_cutoff_bias,
    // rust: has_transparent,
    // rust: opaque,
    // rust: translucent,
    // rust: } = decoded;
    // rust: let animation = animation_text
    // rust: .as_deref()
    // rust: .map(AnimationMetadata::from_json)
    // rust: .transpose()?;
    // rust: let count = frames.len() as u32;
    // rust: let layer = u32::try_from(self.native.len())?;
    // rust: let pbr = match name.split_once(':') {
    // rust: Some(_) if labpbr_maps() => {
    // rust: let path = crate::atlas_sources::texture_path(root, name, "textures");
    // rust: ["_n", "_s"].map(|suffix| pbr_map(&path, suffix, count, animation.as_ref()))
}
    // rust: None if labpbr_maps() && !name.starts_with("fusion/") => ["_n", "_s"]
    // rust: .map(|suffix| pbr_map(&root.join(name), suffix, count, animation.as_ref())),
    // rust: _ => [None, None],
}
    // rust: let settings = crate::mipmap::Settings {
    // rust: native_size: side,
    // rust: strategy,
    // rust: alpha_cutoff_bias,
    // rust: has_transparent,
            // Custom Item Textures' ids are all item textures.
    // rust: item: name.starts_with("horizon_cit:")
    // rust: || name
    // rust: .split_once(':')
    // rust: .is_some_and(|(_, p)| p.starts_with("item/")),
    // rust: dither_cutouts: crate::mipmap::dither_cutouts(),
}
    // rust: let still = (animation.is_none() && frames.len() == 1).then(|| {
//             use std::hash::{Hash, Hasher};
    // rust: let mut frame = std::collections::hash_map::DefaultHasher::new();
    // rust: frames[0].hash(&mut frame);
    // rust: let mut maps = std::collections::hash_map::DefaultHasher::new();
    // rust: pbr.hash(&mut maps);
    // rust: StillKey {
    // rust: frame: frame.finish(),
    // rust: pbr: maps.finish(),
    // rust: side,
    // rust: settings: [
    // rust: settings.strategy as u32,
    // rust: settings.alpha_cutoff_bias.to_bits(),
    // rust: ],
    // rust: flags: [settings.has_transparent, settings.item, opaque, translucent],
}
    // rust: });
    // rust: if let Some(&same) = still.as_ref().and_then(|k| self.still.get(k)) {
    // rust: self.layers.insert(name.to_owned(), same);
    // rust: return Ok(same);
}
    // rust: if let Some(key) = still {
    // rust: self.still.insert(key, layer);
}
    // rust: let frames = Arc::new(frames);
    // rust: let mut initial = 0;
    // rust: if let Some(clip) = animation
    // rust: .as_ref()
    // rust: .map(|m| m.clip(count))
    // rust: .transpose()?
    // rust: .flatten()
    // rust: {
    // rust: initial = clip.sample(0).frame as usize;
    // rust: self.animations.push(SpriteAnimation {
    // rust: layer,
    // rust: frames: frames.clone(),
    // rust: clip: Arc::new(clip),
    // rust: materials: [None, None],
    // rust: });
}
    // rust: self.mips.push(settings);
    // rust: self.opaque.push(opaque);
    // rust: self.translucent.push(translucent);
    // rust: self.pbr.push(pbr);
    // rust: self.layers.insert(name.to_owned(), layer);
    // rust: self.native.push((side, frames, initial));
    // rust: Ok(layer)
}
}

/// A PNG's width, height and pixels as RGBA. From the prepared data file
/// when it holds the texture: no file opened per texture, nor for its absent
/// LabPBR maps.
pub fn read_rgba(path: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let bytes = horizon_core::prepared_files::read(path)?;
    // rust: let mut decoder = png::Decoder::new(std::io::Cursor::new(bytes));
    // rust: decoder.ignore_checksums(true);
    // rust: decoder.set_transformations(png::Transformations::EXPAND | png::Transformations::STRIP_16);
    // rust: let mut reader = decoder.read_info()?;
    // rust: let mut bytes = vec![
    // rust: 0;
    // rust: reader
    // rust: .output_buffer_size()
    // rust: .ok_or("sprite exceeds decoder limits")?
    // rust: ];
    // rust: let info = reader.next_frame(&mut bytes)?;
    // rust: let channels = info.color_type.samples();
    // rust: let mut pixels = Vec::with_capacity(info.width as usize * info.height as usize * 4);
    // rust: for pixel in bytes[..info.buffer_size()].chunks_exact(channels) {
    // rust: let rgba = match info.color_type {
    // rust: png::ColorType::Rgba => [pixel[0], pixel[1], pixel[2], pixel[3]],
    // rust: png::ColorType::Rgb => [pixel[0], pixel[1], pixel[2], 255],
    // rust: png::ColorType::Grayscale => [pixel[0], pixel[0], pixel[0], 255],
    // rust: png::ColorType::GrayscaleAlpha => [pixel[0], pixel[0], pixel[0], pixel[1]],
    // rust: _ => return Err("unsupported expanded sprite format".into()),
}
    // rust: pixels.extend(rgba);
}
    // rust: Ok((info.width, info.height, pixels))
}

/// Companion frames use the colour image's grid; a single-frame map stays static.
    // rust: fn pbr_map(
    // rust: path: &Path,
    // rust: suffix: &str,
    // rust: count: u32,
    // rust: animation: Option<&AnimationMetadata>,
    // rust: ) -> Option<(u32, Vec<Vec<u8>>)> {
    // rust: let stem = path.file_stem()?.to_str()?;
    // rust: let map = path.with_file_name(format!("{stem}{suffix}.png"));
    // rust: let (map_width, map_height, pixels) = read_rgba(&map).ok()?;
    // rust: let (width, height, _) = read_rgba(path).ok()?;
    // rust: let [frame_width, frame_height] = animation.map_or([width as i32, height as i32], |a| {
    // rust: a.frame_size(width as i32, height as i32)
    // rust: });
    // rust: let (frame_width, frame_height) = (
    // rust: u32::try_from(frame_width).ok()?,
    // rust: u32::try_from(frame_height).ok()?,
    // rust: );
    // rust: if frame_width == 0 || frame_height == 0 {
    // rust: return None;
}
    // rust: let (columns, rows) = if count <= 1 || (map_width == frame_width && map_height == frame_height)
    // rust: {
    // rust: (1, 1)
    // rust: } else if u64::from(map_width) * u64::from(height) == u64::from(map_height) * u64::from(width) {
    // rust: (width / frame_width, height / frame_height)
    // rust: } else if u64::from(map_width) * u64::from(frame_height)
    // rust: == u64::from(map_height) * u64::from(frame_width)
    // rust: {
    // rust: (1, 1)
    // rust: } else {
    // rust: return None;
}
    // rust: if columns == 0 || rows == 0 || map_width % columns != 0 || map_height % rows != 0 {
    // rust: return None;
}
    // rust: let (w, h) = (map_width / columns, map_height / rows);
    // rust: if w == 0 || h == 0 {
    // rust: return None;
}
    // rust: let side = w.max(h);
    // rust: let output_side = side_within(side, LAYERS_AT_LEAST, max_map_bytes()).min(side);
    // rust: let frames = (0..columns * rows)
    // rust: .map(|index| {
    // rust: let (x, y) = (index % columns * w, index / columns * h);
    // rust: let mut frame = Vec::with_capacity((side * side * 4) as usize);
    // rust: for row in 0..side {
    // rust: for column in 0..side {
    // rust: let offset =
    // rust: (((y + row * h / side) * map_width + x + column * w / side) * 4) as usize;
    // rust: frame.extend_from_slice(&pixels[offset..offset + 4]);
}
}
    // rust: resample(&frame, side, output_side)
    // rust: })
    // rust: .collect();
    // rust: Some((output_side, frames))
}
/// SpriteContents: the `.mcmeta` `texture` section (TextureMetadataSection's
/// mipmap strategy and alpha cutoff bias).
    // rust: fn texture_section(
    // rust: metadata: Option<&BTreeMap<String, Box<serde_json::value::RawValue>>>,
    // rust: ) -> Option<serde_json::Value> {
    // rust: metadata
    // rust: .and_then(|v| v.get("texture"))
    // rust: .and_then(|v| serde_json::from_str(v.get()).ok())
}

    // rust: pub(crate) fn test_animation(size: u32, layer: u32) -> SpriteAnimation {
    // rust: test_clip(size, layer, r#"{"frametime":1,"frames":[0,1]}"#)
}
    // rust: pub(crate) fn test_clip(size: u32, layer: u32, metadata: &str) -> SpriteAnimation {
    // rust: let frame = |blue: u8| {
    // rust: (0..size * size)
    // rust: .flat_map(|i| [(i % size) as u8, (i / size) as u8, blue, 255])
    // rust: .collect()
}
    // rust: test_frames(layer, vec![frame(0), frame(99)], metadata)
}
    // rust: pub(crate) fn test_frames(layer: u32, frames: Vec<Vec<u8>>, metadata: &str) -> SpriteAnimation {
    // rust: let metadata = AnimationMetadata::from_json(metadata).unwrap();
    // rust: SpriteAnimation {
    // rust: layer,
    // rust: clip: Arc::new(metadata.clip(frames.len() as u32).unwrap().unwrap()),
    // rust: frames: Arc::new(frames),
    // rust: materials: [None, None],
}
}

/// How many reduced copies a sprite atlas keeps: the Mipmap Levels option plus the
/// resampling-only levels an upscaled pack needs, within what the atlas holds.
    // rust: pub(crate) fn sprite_mipmap_limit(requested: u32, size: u32, minimum: u32, available: u32) -> u32 {
    // Only the atlas native minimum determines how many resampling-only mips to skip.
    // rust: let upscale = (size / minimum.max(1)).max(1).ilog2();
    // rust: requested.saturating_add(upscale).min(available - 1)
}

    // rust: mod tests {
//     use super::*;
//     use std::fs::{self, File};
pub fn the_texture_budget_picks_the_largest_side_that_fits() void {
}
        // 1300 layers: vanilla's count, about.
    // rust: assert_eq!(side_within(512, 1300, DEFAULT_TEXTURE_BUDGET), 128);
    // rust: assert_eq!(side_within(512, 1300, 1536 << 20), 512);
    // rust: assert_eq!(side_within(64, 1300, 1536 << 20), 64);
        // Never under vanilla's size, whatever the budget.
    // rust: assert_eq!(side_within(512, 1300, 1), SPRITE_SIZE);
}
pub fn labpbr_maps_follow_the_texture_budget() void {
}
        // 1300 layers of 1024 px maps: 64 px at the default budget, 256 px at 1536 MiB.
    // rust: assert_eq!(
    // rust: side_within(1024, 1300, map_bytes(DEFAULT_TEXTURE_BUDGET)),
    // rust: 64
    // rust: );
    // rust: assert_eq!(side_within(1024, 1300, map_bytes(1536 << 20)), 256);
}
pub fn a_labpbr_map_selects_whole_texels_and_missing_layers_get_defaults() void {
}
        // Selecting a texel preserves encoded channels, including categorical values.
    // rust: let frame = [
    // rust: [200, 100, 0, 255],
    // rust: [0, 0, 0, 0],
    // rust: [200, 100, 0, 255],
    // rust: [0, 0, 0, 0],
    // rust: ]
    // rust: .concat();
    // rust: assert_eq!(shrink_map(frame, 2, 1), (1, vec![200, 100, 0, 255]));
    // rust: let mut sprites = Sprites {
    // rust: native: vec![
    // rust: (SPRITE_SIZE, Arc::new(vec![vec![0; 16 * 16 * 4]]), 0),
    // rust: (SPRITE_SIZE, Arc::new(vec![vec![0; 16 * 16 * 4]]), 0),
    // rust: ],
    // rust: pbr: vec![
    // rust: [Some((16, vec![[9, 8, 7, 6].repeat(16 * 16)])), None],
    // rust: [None, None],
    // rust: ],
    // rust: ..Default::default()
}
    // rust: sprites.finish();
    // rust: assert_eq!(sprites.pbr_size, 16);
    // rust: assert_eq!(sprites.normals[..4], [9, 8, 7, 6]);
    // rust: assert_eq!(sprites.normals[16 * 16 * 4..][..4], FLAT_NORMAL);
    // rust: assert_eq!(sprites.specular[..4], NO_SPECULAR);
    // rust: assert_eq!(sprites.specular.len(), 2 * 16 * 16 * 4);
}
pub fn companion_grid_and_static_map_follow_colour_frame_selection() void {
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-companion-grid-{}", std::process::id()));
    // rust: fs::create_dir_all(&root).unwrap();
    // rust: let write = |name: &str, width, height, pixels: &[u8]| {
    // rust: let mut encoder =
    // rust: png::Encoder::new(File::create(root.join(name)).unwrap(), width, height);
    // rust: encoder.set_color(png::ColorType::Rgba);
    // rust: encoder.set_depth(png::BitDepth::Eight);
    // rust: encoder
    // rust: .write_header()
    // rust: .unwrap()
    // rust: .write_image_data(pixels)
    // rust: .unwrap();
}
    // rust: write("grid.png", 4, 4, &[200, 200, 200, 255].repeat(16));
    // rust: let maps: Vec<u8> = (0..16)
    // rust: .flat_map(|i| {
    // rust: let cell = (i / 8) * 2 + (i % 4) / 2;
    // rust: [10 + cell as u8, 230, 65, 255]
    // rust: })
    // rust: .collect();
    // rust: write("grid_s.png", 4, 4, &maps);
    // rust: write("grid_n.png", 2, 2, &[128, 128, 255, 255].repeat(4));
    // rust: let metadata =
    // rust: r#"{"width":2,"height":2,"frametime":2,"interpolate":true,"frames":[3,1,2,0]}"#;
    // rust: let animation = AnimationMetadata::from_json(metadata).unwrap();
    // rust: let (side, frames) = pbr_map(&root.join("grid.png"), "_s", 4, Some(&animation)).unwrap();
    // rust: assert_eq!(side, 2);
    // rust: assert_eq!(
    // rust: frames.iter().map(|f| f[0]).collect::<Vec<_>>(),
    // rust: [10, 11, 12, 13]
    // rust: );
    // rust: let (_, normals) = pbr_map(&root.join("grid.png"), "_n", 4, Some(&animation)).unwrap();
    // rust: assert_eq!(normals.len(), 1);
    // rust: let mut sprite = test_frames(0, vec![vec![0; 16]; 4], metadata);
    // rust: sprite.materials = [Some(Arc::new(normals)), Some(Arc::new(frames))];
    // rust: for (tick, expected) in [(0, 13), (1, 13), (2, 11), (4, 12), (6, 10)] {
    // rust: assert_eq!(sprite.material_pixels(1, tick).unwrap()[0], expected);
    // rust: assert_eq!(&sprite.material_pixels(0, tick).unwrap()[..4], &FLAT_NORMAL);
}
    // rust: fs::remove_dir_all(root).unwrap();
}
pub fn textures_without_labpbr_maps_keep_none() void {
}
    // rust: let mut sprites = Sprites {
    // rust: native: vec![(SPRITE_SIZE, Arc::new(vec![vec![0; 16 * 16 * 4]]), 0)],
    // rust: pbr: vec![[None, None]],
    // rust: ..Default::default()
}
    // rust: sprites.finish();
    // rust: assert!(sprites.normals.is_empty() && sprites.specular.is_empty());
}
pub fn mipmap_option_keeps_real_16px_reductions() void {
}
    // rust: for levels in 0..=4 {
    // rust: assert_eq!(sprite_mipmap_limit(levels, 32, 16, 6), levels + 1);
    // rust: assert_eq!(sprite_mipmap_limit(levels, 16, 16, 5), levels);
}
}
pub fn files_outside_textures_load_by_path() void {
}
    // rust: let root = std::env::temp_dir().join(format!("horizon-sprite-file-{}", std::process::id()));
    // rust: let tile = "assets/minecraft/optifine/ctm/glass/0.png";
    // rust: fs::create_dir_all(root.join(tile).parent().unwrap()).unwrap();
    // rust: let mut encoder = png::Encoder::new(File::create(root.join(tile)).unwrap(), 16, 16);
    // rust: encoder.set_color(png::ColorType::Rgba);
    // rust: encoder.set_depth(png::BitDepth::Eight);
    // rust: let pixels: Vec<u8> = (0..256).flat_map(|i| [i as u8, 0, 0, 128]).collect();
    // rust: encoder
    // rust: .write_header()
    // rust: .unwrap()
    // rust: .write_image_data(&pixels)
    // rust: .unwrap();
    // rust: let mut sprites = Sprites::default();
    // rust: let layer = sprites.insert_file(&root, tile).unwrap();
    // rust: assert_eq!(sprites.insert_file(&root, tile).unwrap(), layer);
    // rust: assert!(sprites.translucent[layer as usize]);
        // A missing tile is an error, not the missing texture.
    // rust: assert!(
    // rust: sprites
    // rust: .insert_file(&root, "assets/minecraft/optifine/ctm/glass/1.png")
    // rust: .is_err()
    // rust: );
    // rust: assert_eq!(sprites.count(), 1);
    // rust: fs::remove_dir_all(&root).unwrap();
}
pub fn tile_sheets_cut_into_a_layer_per_tile() void {
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-sprite-tiles-{}", std::process::id()));
    // rust: let file = root.join("assets/minecraft/textures/block/sheet.png");
    // rust: fs::create_dir_all(file.parent().unwrap()).unwrap();
        // 3 columns of 2 x 2 tiles over 4 rows of pixels: the pixel at (x, y) has red x, green
        // y; the middle column is transparent, and the top-right tile half see-through.
    // rust: let (w, h) = (6u32, 4u32);
    // rust: let pixels: Vec<u8> = (0..w * h)
    // rust: .flat_map(|i| {
    // rust: let (x, y) = (i % w, i / w);
    // rust: let alpha = match x / 2 {
    // rust: 1 => 0,
    // rust: 2 if y < 2 => 128,
    // rust: _ => 255,
}
    // rust: [x as u8, y as u8, 0, alpha]
    // rust: })
    // rust: .collect();
    // rust: let mut encoder = png::Encoder::new(File::create(&file).unwrap(), w, h);
    // rust: encoder.set_color(png::ColorType::Rgba);
    // rust: encoder.set_depth(png::BitDepth::Eight);
    // rust: encoder
    // rust: .write_header()
    // rust: .unwrap()
    // rust: .write_image_data(&pixels)
    // rust: .unwrap();
        // Red and green of each pixel in a layer's frame.
    // rust: let texels = |sprites: &Sprites, layer: u32, frame: usize| -> Vec<(u8, u8)> {
    // rust: sprites.native[layer as usize].1[frame]
    // rust: .chunks(4)
    // rust: .map(|p| (p[0], p[1]))
    // rust: .collect()
}
    // rust: let mut sprites = Sprites::default();
    // rust: let name = "minecraft:block/sheet";
    // rust: let own = sprites.insert(&root, name).unwrap();
        // Still, as a 3 x 2 grid: the empty middle column draws nothing.
    // rust: let tiles = sprites.insert_tiles(&root, name, (3, 2), false).unwrap();
        // The sheet's own layer now shows the top-left tile, at a tile's size.
    // rust: assert_eq!(texels(&sprites, own, 0), [(0, 0), (1, 0), (0, 1), (1, 1)]);
    // rust: assert_eq!(
    // rust: tiles.iter().map(Option::is_some).collect::<Vec<_>>(),
    // rust: [true, false, true, true, false, true]
    // rust: );
    // rust: let bottom_left = tiles[3].unwrap();
    // rust: assert_eq!(
    // rust: texels(&sprites, bottom_left, 0),
    // rust: [(0, 2), (1, 2), (0, 3), (1, 3)]
    // rust: );
    // rust: assert!(sprites.translucent[tiles[2].unwrap() as usize]);
    // rust: assert!(sprites.opaque[bottom_left as usize]);
        // Animated, as one row of tiles: two frames, the grid's top and then its bottom half;
        // per tile, each cell is the column of a tile's frames, which here is the same.
    // rust: fs::write(file.with_extension("png.mcmeta"), r#"{"animation":{}}"#).unwrap();
    // rust: for per_tile in [false, true] {
    // rust: let mut sprites = Sprites::default();
    // rust: let tiles = sprites.insert_tiles(&root, name, (3, 1), per_tile).unwrap();
    // rust: let first = tiles[0].unwrap();
    // rust: assert_eq!(texels(&sprites, first, 0), [(0, 0), (1, 0), (0, 1), (1, 1)]);
    // rust: assert_eq!(texels(&sprites, first, 1), [(0, 2), (1, 2), (0, 3), (1, 3)]);
    // rust: assert_eq!(sprites.animations.len(), 2, "two non-empty tiles");
}
        // Not a grid of square tiles.
    // rust: assert!(sprites.insert_tiles(&root, name, (4, 1), false).is_err());
    // rust: assert!(sprites.insert_tiles(&root, name, (3, 3), false).is_err());
    // rust: fs::remove_dir_all(&root).unwrap();
}
pub fn custom_item_texture_ids_load_with_their_animation() void {
}
    // rust: let root = std::env::temp_dir().join(format!("horizon-sprite-cit-{}", std::process::id()));
    // rust: let file = root.join("assets/minecraft/optifine/cit/a.png");
    // rust: fs::create_dir_all(file.parent().unwrap()).unwrap();
    // rust: let mut encoder = png::Encoder::new(File::create(&file).unwrap(), 16, 48);
    // rust: encoder.set_color(png::ColorType::Rgba);
    // rust: encoder.set_depth(png::BitDepth::Eight);
    // rust: let pixels: Vec<u8> = (0..16 * 48).flat_map(|_| [200, 10, 10, 255]).collect();
    // rust: encoder
    // rust: .write_header()
    // rust: .unwrap()
    // rust: .write_image_data(&pixels)
    // rust: .unwrap();
    // rust: fs::write(file.with_extension("png.mcmeta"), r#"{"animation":{}}"#).unwrap();
    // rust: let mut sprites = Sprites::default();
    // rust: sprites
    // rust: .insert(&root, "horizon_cit:minecraft/optifine/cit/a")
    // rust: .unwrap();
    // rust: fs::remove_dir_all(&root).unwrap();
        // The missing texture would not animate: this one is the file, in three frames.
    // rust: assert_eq!(sprites.animations.len(), 1);
    // rust: assert_eq!(sprites.animations[0].frame_count(), 3);
}
pub fn custom_item_textures_skip_the_disk_cache() void {
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-sprite-cit-disk-{}", std::process::id()));
        // A realistic root: the cache's fingerprint walks the `textures` trees.
    // rust: let vanilla = root.join("assets/minecraft/textures/item/stick.png");
    // rust: let file = root.join("assets/minecraft/optifine/cit/a.png");
    // rust: let write = |path: &Path, red: u8| {
    // rust: fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: let mut encoder = png::Encoder::new(File::create(path).unwrap(), 16, 16);
    // rust: encoder.set_color(png::ColorType::Rgba);
    // rust: encoder.set_depth(png::BitDepth::Eight);
    // rust: let pixels: Vec<u8> = (0..256).flat_map(|_| [red, 0, 0, 255]).collect();
    // rust: encoder
    // rust: .write_header()
    // rust: .unwrap()
    // rust: .write_image_data(&pixels)
    // rust: .unwrap();
}
    // rust: write(&vanilla, 1);
    // rust: write(&file, 10);
    // rust: let id = "horizon_cit:minecraft/optifine/cit/a";
    // rust: let red = |sprites: &Sprites, layer: u32| sprites.native[layer as usize].1[0][0];
    // rust: let mut first = Sprites::with_disk_cache(&root);
    // rust: let layer = first.insert(&root, id).unwrap();
    // rust: assert_eq!(red(&first, layer), 10);
    // rust: first.save_disk_cache();
        // The pack's file changes; `textures/` does not, so a cached copy would still match.
    // rust: write(&file, 20);
    // rust: let mut second = Sprites::with_disk_cache(&root);
    // rust: let layer = second.insert(&root, id).unwrap();
    // rust: fs::remove_dir_all(&root).unwrap();
    // rust: assert_eq!(red(&second, layer), 20);
}
pub fn custom_item_textures_mip_as_items() void {
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-sprite-cit-mip-{}", std::process::id()));
    // rust: let write = |rel: &str| {
    // rust: let path = root.join(rel);
    // rust: fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: let mut encoder = png::Encoder::new(File::create(path).unwrap(), 16, 16);
    // rust: encoder.set_color(png::ColorType::Rgba);
    // rust: encoder.set_depth(png::BitDepth::Eight);
            // Any pixels: whether a texture mips as an item is part of the shared-layer key.
    // rust: let pixels: Vec<u8> = (0..256)
    // rust: .flat_map(|i| [9, 9, 9, if i % 2 == 0 { 255 } else { 0 }])
    // rust: .collect();
    // rust: encoder
    // rust: .write_header()
    // rust: .unwrap()
    // rust: .write_image_data(&pixels)
    // rust: .unwrap();
}
    // rust: write("assets/a/textures/block/x.png");
    // rust: write("assets/a/textures/item/x.png");
    // rust: write("assets/minecraft/optifine/cit/x.png");
    // rust: let mut sprites = Sprites::default();
    // rust: let block = sprites.insert(&root, "a:block/x").unwrap();
    // rust: let item = sprites.insert(&root, "a:item/x").unwrap();
    // rust: let cit = sprites
    // rust: .insert(&root, "horizon_cit:minecraft/optifine/cit/x")
    // rust: .unwrap();
    // rust: fs::remove_dir_all(&root).unwrap();
        // The same pixels share a layer only with the same mipmap settings: the CIT texture's
        // are the item's.
    // rust: assert_ne!(block, item);
    // rust: assert_eq!(cit, item);
}
pub fn prefetched_textures_take_the_layers_inserting_alone_gives() void {
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-sprite-prefetch-{}", std::process::id()));
    // rust: let png = |path: &str, side: u32, seed: u8| {
    // rust: let file = root.join(path);
    // rust: fs::create_dir_all(file.parent().unwrap()).unwrap();
    // rust: let mut encoder = png::Encoder::new(File::create(file).unwrap(), side, side);
    // rust: encoder.set_color(png::ColorType::Rgba);
    // rust: encoder.set_depth(png::BitDepth::Eight);
    // rust: let pixels: Vec<u8> = (0..side * side)
    // rust: .flat_map(|i| {
    // rust: [
    // rust: seed,
    // rust: i as u8,
    // rust: (i >> 8) as u8,
    // rust: if i % 3 == 0 { 0 } else { 255 },
    // rust: ]
    // rust: })
    // rust: .collect();
    // rust: encoder
    // rust: .write_header()
    // rust: .unwrap()
    // rust: .write_image_data(&pixels)
    // rust: .unwrap();
}
    // rust: for i in 0..40u8 {
    // rust: png(
    // rust: &format!("assets/minecraft/textures/block/b{i}.png"),
    // rust: 16 << (i % 3),
    // rust: i,
    // rust: );
}
        // Two textures alike share a layer; a tile outside `textures/`, a broken file and a
        // missing one take the paths they take without prefetching.
    // rust: png("assets/minecraft/textures/block/same.png", 16, 3);
    // rust: png("assets/minecraft/optifine/ctm/glass/0.png", 32, 77);
    // rust: fs::write(
    // rust: root.join("assets/minecraft/textures/block/broken.png"),
    // rust: b"no png",
    // rust: )
    // rust: .unwrap();
    // rust: let names: Vec<String> = (0..40)
    // rust: .map(|i| format!("minecraft:block/b{}", (i * 7) % 40))
    // rust: .chain(["minecraft:block/same", "minecraft:block/broken"].map(String::from))
    // rust: .chain(["minecraft:block/missing", "minecraft:block/b3"].map(String::from))
    // rust: .collect();
    // rust: let tile = "assets/minecraft/optifine/ctm/glass/0.png";
    // rust: let load = |prefetch: bool| {
    // rust: let mut sprites = Sprites::default();
    // rust: if prefetch {
    // rust: sprites.prefetch(&root, names.iter().map(String::as_str).chain([tile]));
}
    // rust: let mut layers: Vec<u32> = names
    // rust: .iter()
    // rust: .map(|name| sprites.insert(&root, name).unwrap())
    // rust: .collect();
    // rust: layers.push(sprites.insert_file(&root, tile).unwrap());
    // rust: sprites.finish();
    // rust: (
    // rust: layers,
    // rust: sprites.layers,
    // rust: sprites.pixels,
    // rust: sprites.translucent,
    // rust: sprites.size,
    // rust: )
}
    // rust: let alone = load(false);
    // rust: assert_eq!(load(true), alone);
        // The textures alike and the broken one's missing texture: fewer layers than names.
    // rust: assert!(alone.1.values().max().unwrap() + 1 < names.len() as u32);
    // rust: fs::remove_dir_all(&root).unwrap();
}
pub fn identical_still_textures_share_a_layer() void {
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-sprite-share-{}", std::process::id()));
    // rust: let directory = root.join("assets/a/textures/block");
    // rust: fs::create_dir_all(&directory).unwrap();
    // rust: let write = |name: &str, red: u8| {
    // rust: let mut encoder =
    // rust: png::Encoder::new(File::create(directory.join(name)).unwrap(), 16, 16);
    // rust: encoder.set_color(png::ColorType::Rgba);
    // rust: encoder.set_depth(png::BitDepth::Eight);
    // rust: let pixels: Vec<u8> = (0..256).flat_map(|i| [red, i as u8, 0, 255]).collect();
    // rust: encoder
    // rust: .write_header()
    // rust: .unwrap()
    // rust: .write_image_data(&pixels)
    // rust: .unwrap();
}
    // rust: write("one.png", 10);
    // rust: write("copy.png", 10);
    // rust: write("other.png", 20);
    // rust: let mut sprites = Sprites::default();
    // rust: let one = sprites.insert(&root, "a:block/one").unwrap();
    // rust: let copy = sprites.insert(&root, "a:block/copy").unwrap();
    // rust: let other = sprites.insert(&root, "a:block/other").unwrap();
        // The same pixels as an item sprite mip differently: a layer of its own.
    // rust: fs::create_dir_all(root.join("assets/a/textures/item")).unwrap();
    // rust: fs::copy(
    // rust: directory.join("one.png"),
    // rust: root.join("assets/a/textures/item/one.png"),
    // rust: )
    // rust: .unwrap();
    // rust: let item = sprites.insert(&root, "a:item/one").unwrap();
    // rust: fs::remove_dir_all(&root).unwrap();
    // rust: assert_eq!((one, copy, other, item), (0, 0, 1, 2));
    // rust: assert_eq!((sprites.count(), sprites.layers.len()), (3, 4));
    // rust: assert_eq!((sprites.opaque.len(), sprites.mips.len()), (3, 3));
    // rust: sprites.finish();
    // rust: assert_eq!(sprites.pixels.len(), 3 * 16 * 16 * 4);
}
pub fn a_32px_only_atlas_does_not_add_an_extra_mipmap() void {
}
    // rust: let mut sprites = Sprites {
    // rust: native: vec![
    // rust: (32, Arc::new(vec![vec![255; 32 * 32 * 4]]), 0),
    // rust: (32, Arc::new(vec![vec![128; 32 * 32 * 4]]), 0),
    // rust: ],
    // rust: ..Default::default()
}
    // rust: sprites.finish();
    // rust: assert_eq!((sprites.size, sprites.minimum_size), (32, 32));
    // rust: for level in 0..=4 {
    // rust: assert_eq!(
    // rust: sprite_mipmap_limit(level, sprites.size, sprites.minimum_size, 6),
    // rust: level
    // rust: );
}
    // rust: sprites
    // rust: .native
    // rust: .push((16, Arc::new(vec![vec![255; 16 * 16 * 4]]), 0));
    // rust: sprites.finish();
    // rust: assert_eq!((sprites.size, sprites.minimum_size), (32, 16));
    // rust: assert_eq!(
    // rust: sprite_mipmap_limit(0, sprites.size, sprites.minimum_size, 6),
    // rust: 1
    // rust: );
}

pub fn hud_animation_resampling_uses_the_actual_frame_size() void {
}
    // rust: for size in [16, 32, 64] {
    // rust: let animation = test_animation(size, 0);
    // rust: let resized = animation.resized_pixels(1, 16, 16);
    // rust: let last = (15 * size / 16) as u8;
    // rust: assert_eq!(&resized[15 * 4..16 * 4], &[last, 0, 99, 255]);
    // rust: assert_eq!(&resized[255 * 4..256 * 4], &[last, last, 99, 255]);
}
}

pub fn native_fire_sprites_register_full_animation_sequences() void {
}
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root
    // rust: .join("assets/minecraft/textures/block/fire_0.png")
    // rust: .exists()
    // rust: {
    // rust: return;
}
    // rust: let mut sprites = Sprites::default();
    // rust: for name in ["fire_0", "fire_1", "soul_fire_0", "soul_fire_1"] {
    // rust: let layer = sprites
    // rust: .insert(&root, &format!("minecraft:block/{name}"))
    // rust: .unwrap();
    // rust: let animation = sprites
    // rust: .animations
    // rust: .iter()
    // rust: .find(|a| a.layer == layer)
    // rust: .expect("fire must be animated");
    // rust: assert_ne!(
    // rust: animation.pixels(animation.frame(0)),
    // rust: animation.pixels(animation.frame(1))
    // rust: );
    // rust: assert_ne!(
    // rust: animation.resized_pixels(animation.frame(0), 16, 16),
    // rust: animation.resized_pixels(animation.frame(1), 16, 16)
    // rust: );
    // rust: assert_eq!(
    // rust: animation.pixels(animation.frame(0)).len(),
    // rust: (SPRITE_SIZE * SPRITE_SIZE * 4) as usize
    // rust: );
}
}

pub fn native_32_pixel_animation_frames_keep_every_texel() void {
}
    // rust: let root = std::env::temp_dir().join(format!(
    // rust: "horizon-sprite-detail-{}-{}",
    // rust: std::process::id(),
    // rust: std::time::SystemTime::now()
    // rust: .duration_since(std::time::UNIX_EPOCH)
    // rust: .unwrap()
    // rust: .as_nanos()
    // rust: ));
    // rust: let directory = root.join("assets/test/textures");
    // rust: fs::create_dir_all(&directory).unwrap();
    // rust: let path = directory.join("flow.png");
    // rust: let mut pixels = Vec::new();
    // rust: for y in 0..64u8 {
    // rust: for x in 0..32u8 {
    // rust: pixels.extend([x, y, 0, 255]);
}
}
    // rust: let mut encoder = png::Encoder::new(File::create(&path).unwrap(), 32, 64);
    // rust: encoder.set_color(png::ColorType::Rgba);
    // rust: encoder.set_depth(png::BitDepth::Eight);
    // rust: encoder
    // rust: .write_header()
    // rust: .unwrap()
    // rust: .write_image_data(&pixels)
    // rust: .unwrap();
    // rust: fs::write(path.with_extension("png.mcmeta"), r#"{"animation":{}}"#).unwrap();
    // rust: let mut sprites = Sprites::default();
    // rust: sprites.insert(&root, "test:flow").unwrap();
    // rust: sprites.finish();
    // rust: let size = sprites.size;
    // rust: let initial = sprites.pixels.clone();
    // rust: let animation = sprites.animations[0].clone();
    // rust: fs::remove_dir_all(root).unwrap();
    // rust: assert_eq!(
    // rust: size, 32,
    // rust: "half a flowing-water frame must retain 16 texels, not 8"
    // rust: );
    // rust: assert_eq!(initial, pixels[..32 * 32 * 4]);
    // rust: assert_eq!(animation.pixels(animation.frame(1)), &pixels[32 * 32 * 4..]);
}

pub fn animation_boundaries_and_repeated_frames_do_not_depend_on_render_rate() void {
}
    // rust: let animation = SpriteAnimation {
    // rust: layer: 0,
    // rust: materials: [None, None],
    // rust: frames: Arc::new(vec![vec![], vec![], vec![]]),
    // rust: clip: Arc::new(AnimationMetadata::from_json(r#"{"frames":[{"index":2,"time":8},{"index":1,"time":3},{"index":1,"time":2},0]}"#).unwrap().clip(3).unwrap().unwrap()),
}
    // rust: for (tick, frame) in [
    // rust: (0, 2),
    // rust: (7, 2),
    // rust: (8, 1),
    // rust: (10, 1),
    // rust: (11, 1),
    // rust: (12, 1),
    // rust: (13, 0),
    // rust: (14, 2),
    // rust: (29, 2),
    // rust: (u64::MAX, 2),
    // rust: ] {
    // rust: assert_eq!(animation.frame(tick), frame);
}
}

pub fn interpolated_animations_blend_towards_the_next_frame() void {
}
    // rust: let animation = test_clip(16, 0, r#"{"frametime":4,"interpolate":true}"#);
    // rust: let blend = |frame, next, millis| FrameBlend {
    // rust: frame,
    // rust: next,
    // rust: millis,
}
    // rust: for (tick, expected) in [
    // rust: (0, blend(0, 0, 0)),
    // rust: (1, blend(0, 1, 250)),
    // rust: (3, blend(0, 1, 750)),
    // rust: (4, blend(1, 1, 0)),
    // rust: (5, blend(1, 0, 250)),
    // rust: (8, blend(0, 0, 0)),
    // rust: ] {
    // rust: assert_eq!(animation.blend(tick), expected, "tick {tick}");
}
    // rust: let stepped = test_clip(16, 0, r#"{"frametime":4}"#);
    // rust: assert_eq!(stepped.blend(1), blend(0, 0, 0));
    // rust: assert_eq!(stepped.blend(5), blend(1, 1, 0));
}
}
