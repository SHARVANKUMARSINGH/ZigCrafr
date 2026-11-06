//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_hud
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! 2D overlay: one atlas holding GUI sprites, the bitmap font, item and block
//! textures, and a batch of textured quads in GUI pixels (vanilla's automatic
//! GUI scale is applied when drawing).
// use crate::Result;
// use horizon_assets::animation::AnimationMetadata;
// use std::{
    // rust: collections::{HashMap, HashSet},
    // rust: fs,
    // rust: path::{Path, PathBuf},
    // rust: sync::{Arc, OnceLock},
}
// use wgpu::util::DeviceExt;

    // rust: pub mod cit_glint;
    // rust: mod pack_text;

/// A sprite's atlas region, and its size in GUI pixels: the size of the
/// default resources' texture of that name, whatever the resolution of the
/// pack that replaced it (vanilla's GUI code draws in those units: `blit`
/// divides by the texture size it is given, sprites by their `gui.scaling`
/// size). Textures the default resources lack keep their own size.
pub const Rect = struct {
    u0: f32,
    v0: f32,
    u1: f32,
    v1: f32,
    w: u32,
    h: u32,
};
    // rust: impl Rect {
    /// The region's size in texels of an atlas this large.
pub fn texels(self: *Self) void {
}
    // rust: (
    // rust: ((self.u1 - self.u0) * width as f32).round() as u32,
    // rust: ((self.v1 - self.v0) * height as f32).round() as u32,
    // rust: )
}
}
/// `TextureMetadataSection`'s `blur` and `clamp`: how vanilla samples a
/// standalone texture (`ReloadableTexture.setSampler`: linear rather than
/// nearest filtering, clamp-to-edge rather than repeat addressing).
pub const TextureFlags = struct {
    blur: bool,
    clamp: bool,
};
    // rust: impl TextureFlags {
    /// The `texture` section of a `.png.mcmeta` file, if it sets either flag.
pub fn from_mcmeta(json: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let meta: serde_json::Value = serde_json::from_str(json).ok()?;
    // rust: let section = meta.get("texture")?;
    // rust: let flag = |key| section.get(key).and_then(serde_json::Value::as_bool) == Some(true);
    // rust: let flags = Self {
    // rust: blur: flag("blur"),
    // rust: clamp: flag("clamp"),
}
    // rust: (flags != Self::default()).then_some(flags)
}
}
pub const HudAtlas = struct {
    /// Identity of this packed atlas, used to invalidate cached model UV data
    /// even when a resource reload places sprites at the same coordinates.
    revision: u64,
    /// RGBA8, `width` by `height`, as built: empty once `pack_pixels` has
    /// compressed them (read them through `pixels()`).
    pixels: std.ArrayList(u8),
    /// `pixels` compressed (lz4) on a thread of its own once the renderer
    /// has uploaded them: only rebuilding a renderer reads them again.
    packed: ?*OnceLock<std.ArrayList(u8)>,
    /// The width each Standard Galactic letter uses in `font/ascii_sga`'s
    /// cell, by ASCII code (the enchanting table's text), read when built.
    galactic_widths: [u16,
    width: u32,
    height: u32,
    sprites: HashMap<[]const u8,
    /// Resolved player-profile names and UUIDs for inline head components.
    object_skins: HashMap<[]const u8,
    /// Sprites with a 0 < alpha < 255 texel (`SpriteContents.transparency().hasTranslucent`),
    /// which puts their particles on vanilla's translucent layer.
    translucent: std.AutoHashMap([]const u8, void),
    /// Sprites whose `.png.mcmeta` sets `blur` or `clamp`; the others
    /// sample as vanilla's defaults (nearest, repeat).
    flags: HashMap<[]const u8,
    /// Every animated block or item sprite the atlas packs: its atlas rect
    /// and the mcmeta-driven frame list, re-uploaded into the rect as the
    /// frames turn (vanilla's stitched atlas animates all of these).
    sprite_animations: Vec<(Rect,
    /// The default font (bitmap sheets in this atlas, unifont rasterized on demand).
    font: crate::font::Font,
    /// `misc/enchanted_glint_item` as its own image: vanilla's `GlintSampler`
    /// repeats it per pixel, which one sprite inside this atlas cannot.
    glint: (std.ArrayList(u8),
    /// `misc/enchanted_glint_armor`, the armour layers' `GlintSampler`.
    glint_armor: (std.ArrayList(u8),
    /// A resource pack's own `core/text` shader for the GUI's text, translated;
    /// none draws the text natively.
    text_shader: ?std::sync::*horizon_shaders::CoreProgram,
    /// A resource pack's own `core/rendertype_lines` shader for the block outline, translated;
    /// none draws the outline natively.
    lines_shader: ?std::sync::*horizon_shaders::CoreProgram,
    /// The packs' OptiFine random entity textures, whose variants this atlas packs.
    random_textures: horizon_optifine::random_textures::RandomTextures,
    /// Their emissive overlays (`_e`), packed here too.
    emissive: std::sync::*horizon_optifine::emissive::Emissive,
    /// ETF's blinking frames (`_blink`), packed here too.
    blinks: horizon_optifine::blink::Blinks,
    white: Rect,
};
/// Atlas rows reserved for glyphs rasterized at run time.
pub const GLYPH_ROWS: u32 = 512;
/// The largest atlas side: the 2D texture limit of the GPUs Horizon runs on
/// (Apple silicon, RADV and Intel allow 16384; NVIDIA 32768).
pub const MAX_ATLAS_SIZE: u32 = 16384;
/// 128x128 atlas slots for map textures. A lobby paints its signs as walls of
/// framed maps, so the pool holds a wall; too few slots re-upload every map
/// every frame. 26.3's `MapTextureManager` keeps a texture per map instead.
pub const MAP_SLOTS: usize = 256;
/// The atlas sprite of map slot `slot` (`horizon/map{slot}`), named once:
/// every map shown asks for its slot's each frame.
pub fn map_slot_sprite(slot: usize) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: static NAMES: std::sync::LazyLock<Vec<String>> =
    // rust: std::sync::LazyLock::new(|| (0..MAP_SLOTS).map(|i| format!("horizon/map{i}")).collect());
    // rust: NAMES.get(slot).map(String::as_str)
}
/// The atlas slot the minimap extra draws into.
pub const MINIMAP_SPRITE: []const u8 = "horizon/minimap";
/// A mod's own image (`native_mod_image`), drawn with `native_sprite`; big
/// enough for a world map's 1024 blocks at a block a pixel.
pub const MOD_IMAGE_SPRITE: []const u8 = "horizon/modimage";
pub const MOD_IMAGE_SIZE: u32 = 1024;
/// Atlas slots for downloaded player skins (`skins/<sha1>`), 64x64 each.
/// Vanilla registers a texture per skin. Here the slots are shared
/// (`skins::SkinSlots`): skins drawn in the last frame keep theirs, and a
/// skin past them shows the default skin until a slot frees up.
pub const SKIN_SLOTS: usize = 128;
/// Reused by the visible rows of the classic world selector.
pub const WORLD_ICON_SLOTS: usize = 32;
/// Atlas slots for the pack icons on the pack screen, one per icon drawn
/// (`PackSelectionScreen.loadPackIcon` registers a texture per pack): two lists
/// of 36-pixel rows at GUI scale 2 on a 4K screen still fit.
pub const PACK_ICON_SLOTS: usize = 64;
/// A pack icon slot's side: vanilla's own icons are 128x128.
pub const PACK_ICON_SIZE: u32 = 128;
/// Atlas slots for armour trim textures made at run time (`trims`), each the
/// size of the largest trim texture.
pub const TRIM_SLOTS: usize = 32;
pub fn decode(path: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: decode_bytes(&horizon_core::prepared_files::read(path)?)
}
/// The image formats [`decode_image_bytes`] reads, told apart by their own
/// leading bytes rather than by a file name: what a server sends has no name,
/// and a name would not be trustworthy anyway.
///
/// The game's own resources are PNG throughout, and so are a resource pack's
/// (vanilla's `NativeImage.read` takes PNG only), so [`decode_bytes`] stays
/// PNG-only. WebP and JPEG are for images fetched from the network (Modrinth
/// project icons in the resource pack browser), which are commonly either.
pub const ImageFormat = enum {
    Png,
    /// `RIFF....WEBP`.
    WebP,
    /// Starts with the SOI marker `FF D8`.
    Jpeg,
};

    // rust: impl ImageFormat {
    /// The format `data` begins with, or `None` for anything else.
pub fn sniff(data: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
pub const PNG_MAGIC: [u8; 8] = [0x89, b'P', b'N', b'G', 0x0D, 0x0A, 0x1A, 0x0A];
    // rust: if data.starts_with(&PNG_MAGIC) {
    // rust: return Some(Self::Png);
}
    // rust: if data.len() >= 12 && data.starts_with(b"RIFF") && &data[8..12] == b"WEBP" {
    // rust: return Some(Self::WebP);
}
    // rust: if data.starts_with(&[0xFF, 0xD8]) {
    // rust: return Some(Self::Jpeg);
}
    // rust: None
}
}

/// The most pixels a fetched image may claim: its header alone sizes the
/// buffer, and a hostile one could ask for gigabytes. 4096 x 4096 RGBA is 64 MiB.
pub const MAX_FETCHED_PIXELS: u64 = 4096 * 4096;

pub fn check_fetched_size(width: u64, height: u64) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if width * height > MAX_FETCHED_PIXELS {
    // rust: return Err(format!("a {width}x{height} image is too large to decode").into());
}
    // rust: Ok(())
}

/// A WebP image as RGBA8. Still frames and animations both decode; an
/// animation gives its first frame, as an animated PNG would.
pub fn decode_webp(data: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut decoder =
    // rust: image_webp::WebPDecoder::new(std::io::Cursor::new(data)).map_err(|e| e.to_string())?;
    // rust: let (width, height) = decoder.dimensions();
    // rust: check_fetched_size(u64::from(width), u64::from(height))?;
    // Four bytes a pixel whether or not the image carries alpha: the caller
    // always wants RGBA.
    // rust: let mut rgba = vec![0u8; (width as usize) * (height as usize) * 4];
    // rust: if decoder.has_alpha() {
    // rust: decoder.read_image(&mut rgba).map_err(|e| e.to_string())?;
    // rust: } else {
    // rust: let mut rgb = vec![0u8; (width as usize) * (height as usize) * 3];
    // rust: decoder.read_image(&mut rgb).map_err(|e| e.to_string())?;
    // rust: for (out, pixel) in rgba
    // rust: .as_chunks_mut::<4>()
    // rust: .0
    // rust: .iter_mut()
    // rust: .zip(rgb.as_chunks::<3>().0)
    // rust: {
    // rust: out.copy_from_slice(&[pixel[0], pixel[1], pixel[2], 255]);
}
}
    // rust: Ok((width, height, rgba))
}

/// A JPEG image as RGBA8. JPEG has no alpha, so every pixel is opaque.
pub fn decode_jpeg(data: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut decoder = zune_jpeg::JpegDecoder::new(data);
    // The size comes from the headers, before any pixel buffer is made.
    // rust: decoder.decode_headers().map_err(|e| e.to_string())?;
    // rust: let info = decoder.info().ok_or("the JPEG states no size")?;
    // rust: let (width, height) = (u32::from(info.width), u32::from(info.height));
    // rust: check_fetched_size(u64::from(width), u64::from(height))?;
    // rust: let pixels = decoder.decode().map_err(|e| e.to_string())?;
    // rust: let count = (width as usize) * (height as usize);
    // The decoder gives RGB for a colour image and one byte a pixel for a
    // greyscale one; both become RGBA here.
    // rust: let channels = pixels.len().checked_div(count).unwrap_or(0);
    // rust: let mut rgba = Vec::with_capacity(count * 4);
    // rust: match channels {
    // rust: 3 => {
    // rust: for p in pixels.as_chunks::<3>().0 {
    // rust: rgba.extend_from_slice(&[p[0], p[1], p[2], 255]);
}
}
    // rust: 1 => {
    // rust: for p in &pixels {
    // rust: rgba.extend_from_slice(&[*p, *p, *p, 255]);
}
}
    // rust: _ => return Err("the JPEG decoded to an unexpected channel count".into()),
}
    // rust: Ok((width, height, rgba))
}

/// An image fetched from the network (PNG, WebP or JPEG) as RGBA pixels. WebP
/// and JPEG go to their own decoders; anything else goes to the PNG reader, so
/// its error is the one reported.
pub fn decode_image_bytes(data: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match ImageFormat::sniff(data) {
    // rust: Some(ImageFormat::WebP) => decode_webp(data),
    // rust: Some(ImageFormat::Jpeg) => decode_jpeg(data),
        // A PNG's IHDR states the size before the decoder sizes its pixel
        // buffer, so it is checked there like the WebP and JPEG headers: the
        // PNG reader alone would trust the header and allocate it.
    // rust: Some(ImageFormat::Png) | None => {
    // rust: if let Some((width, height)) = png_bytes_size(data) {
    // rust: check_fetched_size(u64::from(width), u64::from(height))?;
}
    // rust: decode_bytes(data)
}
}
}

/// A PNG in memory as RGBA pixels.
pub fn decode_bytes(data: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut decoder = png::Decoder::new(std::io::Cursor::new(data));
    // rust: decoder.ignore_checksums(true);
    // rust: decoder.set_transformations(png::Transformations::EXPAND | png::Transformations::STRIP_16);
    // rust: let mut reader = decoder.read_info()?;
    // rust: let mut bytes = vec![0; reader.output_buffer_size().ok_or("image too large")?];
    // rust: let info = reader.next_frame(&mut bytes)?;
    // rust: let channels = info.color_type.samples();
    // rust: let mut rgba = Vec::with_capacity((info.width * info.height * 4) as usize);
    // rust: for p in bytes[..info.buffer_size()].chunks_exact(channels) {
    // rust: rgba.extend(match channels {
    // rust: 4 => [p[0], p[1], p[2], p[3]],
    // rust: 3 => [p[0], p[1], p[2], 255],
    // rust: 2 => [p[0], p[0], p[0], p[1]],
    // rust: _ => [p[0], p[0], p[0], 255],
    // rust: });
}
    // rust: Ok((info.width, info.height, rgba))
}
/// The most texels of OptiFine random entity variants the entity atlas packs: 2048 rows of
/// its 4096, which keeps the default atlas (4096x5120) under the 8192 rows many GPUs take.
pub const RANDOM_TEXELS: u64 = 4096 * 2048;
/// The variant images (and `overlays`) the atlas packs: every variant before any overlay, by
/// name, while their sizes add up to at most `budget` texels. A full budget drops glows before
/// looks.
    // rust: fn budgeted<'a>(
    // rust: files: impl Iterator<Item = &'a PathBuf>,
    // rust: overlays: &HashSet<PathBuf>,
    // rust: budget: u64,
    // rust: ) -> HashSet<PathBuf> {
    // rust: let mut files: Vec<&PathBuf> = files.collect();
    // rust: files.sort_by_key(|p| (overlays.contains(*p), *p));
    // rust: within_budget(&files, budget)
}
/// The `files` (in order) whose sizes add up to at most `budget` texels.
pub fn within_budget(files: *[*PathBuf], budget: u64) H {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut texels = 0u64;
    // rust: files
    // rust: .iter()
    // rust: .filter(|p| {
    // rust: let (w, h) = png_size(p).unwrap_or((0, 0));
    // rust: texels += u64::from(w) * u64::from(h);
    // rust: texels <= budget
    // rust: })
    // rust: .map(|p| (*p).clone())
    // rust: .collect()
}
/// A PNG's width and height from its first 24 bytes (`IHDR`), before any
/// pixel buffer is made.
pub fn png_bytes_size(data: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let header = data.get(..24)?;
    // rust: if header[..8] != *b"\x89PNG\r\n\x1a\n" || header[12..16] != *b"IHDR" {
    // rust: return None;
}
    // rust: let field = |at: usize| u32::from_be_bytes(header[at..at + 4].try_into().unwrap_or_default());
    // rust: Some((field(16), field(20)))
}
/// A PNG's width and height, from its header alone.
pub fn png_size(path: *Path) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: png_bytes_size(&horizon_core::prepared_files::read_head(path, 24).ok()?)
}
pub fn walk(dir: *Path, out: *mut std.ArrayList(PathBuf)) void {
}
    // A prepared root's folder: from its data file, without listing the disk.
    // rust: if let Some(files) = horizon_core::prepared_files::files_under(dir) {
    // rust: out.extend(
    // rust: files
    // rust: .iter()
    // rust: .filter(|file| file.ends_with(".png"))
    // rust: .map(|file| dir.join(file)),
    // rust: );
    // rust: return;
}
    // rust: let Ok(entries) = fs::read_dir(dir) else {
    // rust: return;
}
    // rust: for entry in entries.flatten() {
    // rust: let path = entry.path();
    // rust: if path.is_dir() {
    // rust: walk(&path, out);
    // rust: } else if path.extension().is_some_and(|e| e == "png") {
    // rust: out.push(path);
}
}
}
/// A packed atlas image: sprite name, size and RGBA pixels.
    // rust: type PackedImage = (String, u32, u32, Vec<u8>);
/// A frame of an animated strip at `x, y`, nearest-resampled to the longer
/// side of the frame: array layers are square, as `Sprites::load` keeps them
/// for the world's sprite arrays.
pub fn strip_frame(pixels: []const u8, stride: u32, x: u32, y: u32, w: u32, h: u32) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let side = w.max(h);
    // rust: let mut out = Vec::with_capacity((side * side * 4) as usize);
    // rust: for row in 0..side {
    // rust: let source_row = y + row * h / side;
    // rust: for column in 0..side {
    // rust: let at = ((source_row * stride + x + column * w / side) * 4) as usize;
    // rust: out.extend_from_slice(&pixels[at..at + 4]);
}
}
    // rust: out
}
/// The `animation` section of a texture's `.mcmeta`.
pub fn animation_of(mcmeta: ?[]const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let meta: serde_json::Value = serde_json::from_str(mcmeta?).ok()?;
    // rust: AnimationMetadata::from_json(&meta.get("animation")?.to_string()).ok()
}
/// An animated strip's first frame: the region the mcmeta's frame size picks
/// (`AnimationMetadataSection.frameSize`), which is the top-left square unless
/// it names other dimensions or the frames run along a row.
    // rust: fn first_frame(
    // rust: (w, h, pixels): (u32, u32, Vec<u8>),
    // rust: animation: Option<&AnimationMetadata>,
    // rust: ) -> (u32, u32, Vec<u8>) {
    // rust: let [fw, fh] = animation.map_or([w.min(h) as i32; 2], |meta| {
    // rust: meta.frame_size(w as i32, h as i32)
    // rust: });
    // rust: match (u32::try_from(fw), u32::try_from(fh)) {
    // rust: (Ok(fw), Ok(fh))
    // rust: if fw > 0 && fh > 0 && w % fw == 0 && h % fh == 0 && (fw, fh) != (w, h) =>
    // rust: {
    // rust: let side = fw.max(fh);
    // rust: (side, side, strip_frame(&pixels, w, 0, 0, fw, fh))
}
    // rust: _ => (w, h, pixels),
}
}
/// `image` inside a one-texel border copied from its opposite edges, the
/// texels repeat addressing reads past each edge.
pub fn wrap_border() void {
}
    // rust: let (bw, bh) = (w + 2, h + 2);
    // rust: let mut out = Vec::with_capacity((bw * bh * 4) as usize);
    // rust: for y in 0..bh {
    // rust: let row = (y + h - 1) % h;
    // rust: for x in 0..bw {
    // rust: let at = ((row * w + (x + w - 1) % w) * 4) as usize;
    // rust: out.extend_from_slice(&data[at..at + 4]);
}
}
    // rust: (name.clone(), bw, bh, out)
}
/// The textures the enabled packs' Custom Item Textures rules draw, beyond those already packed:
/// item rules' textures and their JSON models', armour and elytra rules' textures, under their
/// `cit_assets` ids, with their flags and whether they animate. An animated strip keeps its
/// first frame; a still texture is packed whole. None without `optifine/cit` rules.
    // rust: fn cit_sprites(
    // rust: root: &Path,
    // rust: packed: &[PackedImage],
    // rust: ) -> Vec<(PackedImage, Option<TextureFlags>, bool)> {
    // rust: let have: HashSet<&str> = packed.iter().map(|i| i.0.as_str()).collect();
    // rust: let rules = crate::cit::load_rules(root);
    // rust: let mut ids = crate::cit_assets::item_sprites(&rules);
    // rust: if !rules.is_empty() {
    // rust: let models = crate::cit_assets::load_models(root, &rules);
    // rust: ids.extend(crate::cit_assets::model_sprites(&models));
    // rust: ids.extend(crate::cit_armor::armor_sprites(&rules));
}
    // rust: let ids: Vec<String> = ids
    // rust: .into_iter()
        // Vanilla's sprites are packed without their namespace, as `sprite_name` looks them up;
        // Horizon's own (`horizon/white`, the run-time slots) are added after, and stay its own.
    // rust: .filter(|id| {
    // rust: let name = id.strip_prefix("minecraft:").unwrap_or(id);
    // rust: !have.contains(name) && !name.starts_with("horizon/")
    // rust: })
    // rust: .collect();
    // No more than the atlas could ever hold, by their headers, so a pack naming thousands of
    // big textures is cut short before they are decoded, not after. Each is charged what it
    // can be packed as (a strip's frame, or a still image whole), 1024x512 at most since
    // `cit_sprite` refuses more, with a gutter;
    // the glyph rows and the shelves' waste (a tenth) are kept aside.
    // rust: let side = u64::from(MAX_ATLAS_SIZE);
    // rust: let used: u64 = packed
    // rust: .iter()
    // rust: .map(|i| u64::from(i.1 + 1) * u64::from(i.2 + 1))
    // rust: .sum();
    // rust: let mut left = (side * side * 9 / 10).saturating_sub(side * u64::from(GLYPH_ROWS) + used);
    // rust: let before = ids.len();
    // rust: let ids: Vec<String> = ids
    // rust: .into_iter()
    // rust: .filter(|id| {
    // rust: let path = crate::atlas_sources::texture_path(root, id, "textures");
    // rust: let Some((w, h)) = png_size(&path) else {
    // rust: return true;
}
    // rust: let (w, h) = (u64::from(w), u64::from(h));
    // rust: if w * h > 1024 * 512 * 64 {
                // Refused by `cit_sprite` without decoding: costs nothing.
    // rust: return true;
}
            // A strip's frame is at most its width squared; a still image is all of it.
    // rust: let frame = (w * h).min(w * w).min(1024 * 512) + w + h + 1;
    // rust: match left.checked_sub(frame) {
    // rust: Some(rest) => {
    // rust: left = rest;
    // rust: true
}
    // rust: None => false,
}
    // rust: })
    // rust: .collect();
    // rust: if ids.len() < before {
    // rust: log::warn!(
    // rust: "left out {} custom item textures: more than the atlas holds",
    // rust: before - ids.len()
    // rust: );
}
    // Decoded on the threads `pack` decodes the rest on: a big pack names thousands.
    // rust: let threads = std::thread::available_parallelism().map_or(1, |n| n.get());
    // rust: let chunk = ids.len().div_ceil(threads).max(1);
    // rust: std::thread::scope(|scope| {
    // rust: let workers: Vec<_> = ids
    // rust: .chunks(chunk)
    // rust: .map(|ids| scope.spawn(|| ids.iter().filter_map(|id| cit_sprite(root, id)).collect()))
    // rust: .collect();
    // rust: workers
    // rust: .into_iter()
    // rust: .flat_map(|w| {
    // rust: w.join().unwrap_or_else(|_| {
    // rust: log::warn!("a custom item texture decoder panicked; its textures are left out");
    // rust: Vec::new()
    // rust: })
    // rust: })
    // rust: .collect()
    // rust: })
}
/// One of `cit_sprites`, or `None` (with a warning) when it does not load or is too big.
pub fn cit_sprite(root: *Path, id: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = id.strip_prefix("minecraft:").unwrap_or(id);
    // rust: let path = crate::atlas_sources::texture_path(root, id, "textures");
    // The limit `pack` keeps every other texture to, for a frame; and from the header first,
    // so an image bigger than 64 such frames is never decoded.
    // rust: let fits = |w: u32, h: u32| w <= 1024 && h <= 512;
    // rust: if let Some((w, h)) = png_size(&path)
    // rust: && u64::from(w) * u64::from(h) > 1024 * 512 * 64
    // rust: {
    // rust: log::warn!("skipped custom item texture {}: {w}x{h}", path.display());
    // rust: return None;
}
    // rust: let image = match decode(&path) {
    // rust: Ok(image) => image,
    // rust: Err(e) => {
    // rust: log::warn!("skipped custom item texture {}: {e}", path.display());
    // rust: return None;
}
}
    // rust: let mcmeta =
    // rust: horizon_core::prepared_files::read_to_string(&path.with_extension("png.mcmeta")).ok();
    // rust: let animation = animation_of(mcmeta.as_deref());
    // Only an animation is cut to its first frame: a still CIT texture is drawn whole, and
    // armour layers are twice as wide as they are tall.
    // rust: let (w, h, pixels) = match &animation {
    // rust: Some(animation) => first_frame(image, Some(animation)),
    // rust: None => image,
}
    // rust: if !fits(w, h) {
    // rust: log::warn!("skipped custom item texture {}: {w}x{h}", path.display());
    // rust: return None;
}
    // rust: let flags = mcmeta.as_deref().and_then(TextureFlags::from_mcmeta);
    // rust: Some(((name.to_owned(), w, h, pixels), flags, animation.is_some()))
}
/// Folders of `assets/minecraft/textures/` that [`HudAtlas::pack`] walks for
/// the full atlas. A pack may add others through `atlases/blocks.json`.
    // rust: const WALKED_TEXTURE_FOLDERS: &[&str] = &[
    // rust: "gui",
    // rust: "item",
    // rust: "block",
    // rust: "font",
    // rust: "environment",
    // rust: "misc",
    // rust: "painting",
    // rust: "entity",
    // rust: "particle",
    // rust: "mob_effect",
    // rust: "map",
    // rust: ];

pub fn walked_minecraft_texture(name: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: WALKED_TEXTURE_FOLDERS
    // rust: .iter()
    // rust: .any(|folder| name.starts_with(folder) && name.as_bytes().get(folder.len()) == Some(&b'/'))
}

/// Sprites the atlas definitions (`atlases/*.json`) add beyond the texture
/// files already packed: generated ones (`paletted_permutations` such as the
/// armour trim sprites, `unstitch` regions) and files listed under another id,
/// such as other namespaces' item textures; and the animated ones' names.
pub fn atlas_sprites(root: *Path, packed: *[PackedImage]) ( {
    // Implementation ported from Horizon
    return undefined;
}
//     use crate::atlas_sources::{self, SpriteOrigin};
    // rust: let have: std::collections::HashSet<&str> = packed.iter().map(|i| i.0.as_str()).collect();
    // rust: let textures = atlas_sources::list_textures(root);
    // Each new name with its origins in the atlases' order: the first that
    // loads is the sprite. They load at once (a content pack's atlases list
    // tens of thousands of files), and come out in the order a load of one
    // after another would give.
    // rust: let mut names: Vec<(String, Vec<(usize, SpriteOrigin)>)> = Vec::new();
    // rust: let mut slots = std::collections::HashMap::new();
    // rust: let mut order = 0;
    // rust: for (atlas, sources) in atlas_sources::atlases(root) {
        // The other atlases' renamed files (GUI sprites, particles...) are
        // looked up by their texture paths here.
    // rust: let item_models = atlas == "minecraft:blocks" || atlas == "minecraft:items";
    // rust: for (id, origin) in atlas_sources::list(&sources, &textures) {
    // rust: if !item_models && matches!(origin, SpriteOrigin::File(_)) {
    // rust: continue;
}
    // rust: let name = id.strip_prefix("minecraft:").unwrap_or(&id).to_owned();
    // rust: if have.contains(name.as_str()) {
    // rust: continue;
}
            // A file under a walked folder is packed under its own name already:
            // only a renamed one is new. Other namespaces' files (content mods)
            // are never in those folders, nor are extra directories a pack adds
            // to the blocks atlas (`custom/...`).
    // rust: if let SpriteOrigin::File(texture) = &origin
    // rust: && texture.strip_prefix("minecraft:") == Some(name.as_str())
    // rust: && walked_minecraft_texture(name.as_str())
    // rust: {
    // rust: continue;
}
    // rust: let slot = *slots.entry(name.clone()).or_insert_with(|| {
    // rust: names.push((name, Vec::new()));
    // rust: names.len() - 1
    // rust: });
    // rust: names[slot].1.push((order, origin));
    // rust: order += 1;
}
}
    // rust: let load = |texture: &str, directory: &str| {
    // rust: decode(&atlas_sources::texture_path(root, texture, directory)).ok()
}
    // rust: let first = |(name, origins): &(String, Vec<(usize, SpriteOrigin)>)| {
    // rust: origins.iter().find_map(|(order, origin)| {
    // rust: let mut animated = false;
    // rust: let image = match origin {
    // rust: SpriteOrigin::File(texture) => {
                    // Its path under `textures/` in any namespace (a server
                    // pack's `lobby:item/...` as well as vanilla's).
    // rust: let path = texture.split_once(':').map_or(texture.as_str(), |(_, p)| p);
    // rust: let file = atlas_sources::texture_path(root, texture, "textures");
    // rust: decode(&file).ok().map(|image| {
                        // Animated strips keep their first frame and animate, like the
                        // packed files, under any folder: vanilla animates every sprite of
                        // these atlases (a server pack's `wynn/...` as well as `item/...`).
    // rust: let mcmeta = horizon_core::prepared_files::read_to_string(
    // rust: &file.with_extension("png.mcmeta"),
    // rust: )
    // rust: .ok();
    // rust: let animation = animation_of(mcmeta.as_deref());
    // rust: animated = animation.is_some();
    // rust: if animated || path.starts_with("block/") || path.starts_with("item/") {
    // rust: first_frame(image, animation.as_ref())
    // rust: } else {
    // rust: image
}
    // rust: })
}
    // rust: generated => atlas_sources::generate(generated, &load),
}
    // rust: image.map(|(w, h, pixels)| (*order, (name.clone(), w, h, pixels), animated))
    // rust: })
}
    // rust: let mut out: Vec<_> = crate::par::par_map(&names, first)
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .collect();
    // rust: out.sort_unstable_by_key(|(order, ..)| *order);
    // rust: let animated = out
    // rust: .iter()
    // rust: .filter(|(.., animated)| *animated)
    // rust: .map(|(_, image, _)| image.0.clone())
    // rust: .collect();
    // rust: (
    // rust: out.into_iter().map(|(_, image, _)| image).collect(),
    // rust: animated,
    // rust: )
}
/// `MissingTextureAtlasSprite`: what a sprite the atlas lacks draws as.
pub const MISSING_SPRITE: []const u8 = "horizon/missing";

/// The used width of each Standard Galactic letter (A-Z, a-z) in the
/// `font/ascii_sga` sheet: one past its last column with a texel that isn't
/// transparent.
    // rust: fn galactic_widths(
    // rust: sprites: &HashMap<String, Rect>,
    // rust: pixels: &[u8],
    // rust: width: u32,
    // rust: height: u32,
    // rust: ) -> [u16; 128] {
    // rust: let mut widths = [0u16; 128];
    // rust: let Some(sheet) = sprites.get("font/ascii_sga") else {
    // rust: return widths;
}
    // rust: let cell = sheet.w / 16;
    // rust: let (px, py) = (
    // rust: (sheet.u0 * width as f32) as u32,
    // rust: (sheet.v0 * height as f32) as u32,
    // rust: );
    // rust: for code in (0x41..=0x5Au32).chain(0x61..=0x7A) {
    // rust: let (cx, cy) = (px + code % 16 * cell, py + code / 16 * cell);
    // rust: let alpha = |x: u32, y: u32| {
    // rust: pixels
    // rust: .get(((y * width + x) * 4 + 3) as usize)
    // rust: .copied()
    // rust: .unwrap_or(0)
}
    // rust: widths[code as usize] = (0..cell)
    // rust: .rev()
    // rust: .find(|&dx| (0..cell).any(|dy| alpha(cx + dx, cy + dy) != 0))
    // rust: .map_or(0, |dx| (dx + 1).min(u32::from(u16::MAX)) as u16);
}
    // rust: widths
}
/// `TextureAtlas.dumpContents` (`F3 + S`, vanilla's "dynamic textures"): the atlas
/// written as `name.png` beside `name.txt`, every sprite in name order with its
/// rect in texels (`dumpSpriteNames`). Vanilla names each file after its atlas
/// with `/` and `:` as `_` (`Identifier.toDebugFileName`); Horizon packs the GUI,
/// font, particle, map and skin sprites into one atlas, so one file stands in for
/// the atlases vanilla dumps apart.
    // rust: pub fn dump_atlas(
    // rust: dir: &Path,
    // rust: name: &str,
    // rust: width: u32,
    // rust: height: u32,
    // rust: pixels: &[u8],
    // rust: sprites: &HashMap<String, Rect>,
    // rust: ) -> std::io::Result<PathBuf> {
    // A build whose pixels were freed (`fonts`) has the size and no texels:
    // write nothing rather than a file every reader would reject.
    // rust: if pixels.len() != (width as usize) * (height as usize) * 4 {
    // rust: return Err(std::io::Error::other(format!(
    // rust: "wrong data size, expected {} got {}",
    // rust: (width as usize) * (height as usize) * 4,
    // rust: pixels.len()
    // rust: )));
}
    // rust: fs::create_dir_all(dir)?;
    // rust: let png_path = dir.join(format!("{name}.png"));
    // rust: let mut encoder = png::Encoder::new(fs::File::create(&png_path)?, width, height);
    // rust: encoder.set_color(png::ColorType::Rgba);
    // rust: encoder.set_depth(png::BitDepth::Eight);
    // rust: let mut writer = encoder.write_header().map_err(std::io::Error::other)?;
    // rust: writer
    // rust: .write_image_data(pixels)
    // rust: .map_err(std::io::Error::other)?;
    // rust: drop(writer);
    // rust: let mut names = sprites.iter().collect::<Vec<_>>();
    // rust: names.sort_by(|a, b| a.0.cmp(b.0));
    // rust: let mut list = String::new();
    // rust: for (sprite, rect) in names {
    // rust: let (w, h) = rect.texels((width, height));
    // rust: let x = (rect.u0 * width as f32).round() as u32;
    // rust: let y = (rect.v0 * height as f32).round() as u32;
    // rust: list.push_str(&format!("{sprite}\tx={x}\ty={y}\tw={w}\th={h}\n"));
}
    // rust: fs::write(dir.join(format!("{name}.txt")), list)?;
    // rust: Ok(png_path)
}

    // rust: impl HudAtlas {
    /// `TextureAtlas.dumpContents` for this atlas: `dir` is `screenshots/debug`,
    /// the folder `TextureUtil.getDebugTexturePath` names.
pub fn dump_contents(self: *Self, dir: *Path, name: []const u8) s {
    // Implementation ported from Horizon
    return undefined;
}
        // `pixels()`: the copy `pack_pixels` compressed once the GPU had the
        // atlas, decompressed; vanilla reads the texture back from the GPU.
    // rust: let pixels = self.pixels();
    // rust: dump_atlas(dir, name, self.width, self.height, &pixels, &self.sprites)
}

pub fn next_revision() u {
    // Implementation ported from Horizon
    return undefined;
}
pub const NEXT: std::sync::atomic::AtomicU64 = std::sync::atomic::AtomicU64::new(1);
    // rust: NEXT.fetch_add(1, std::sync::atomic::Ordering::Relaxed)
}
    /// The atlas's pixels: as built, or uncompressed again after
    /// `pack_pixels` (a renderer being rebuilt).
pub fn pixels(self: *Self) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(packed) = self.packed.as_ref().filter(|_| self.pixels.is_empty()) else {
    // rust: return std::borrow::Cow::Borrowed(&self.pixels);
}
    // rust: let size = (self.width * self.height * 4) as usize;
    // rust: std::borrow::Cow::Owned(
    // rust: lz4_flex::decompress_size_prepended(packed.wait())
    // rust: .ok()
    // rust: .filter(|p| p.len() == size)
    // rust: .unwrap_or_else(|| vec![0; size]),
    // rust: )
}
    /// Keep the pixels compressed from now on, once a renderer has them: the
    /// window's GPU holds the atlas, and a copy as built only serves a
    /// renderer made again (another window, a lost device, another graphics
    /// API). They are compressed on a thread of their own; `pixels()` waits
    /// for it.
pub fn pack_pixels(self: *Self) void {
}
    // rust: if self.pixels.is_empty() || self.packed.is_some() {
    // rust: return;
}
    // rust: let raw = Arc::new(std::mem::take(&mut self.pixels));
    // rust: let slot = Arc::new(OnceLock::new());
    // rust: let (job_raw, job_slot) = (raw.clone(), slot.clone());
    // rust: let spawned = std::thread::Builder::new()
    // rust: .name("Atlas packing".into())
    // rust: .spawn(move || {
    // rust: let _ = job_slot.set(lz4_flex::compress_prepend_size(&job_raw));
    // rust: });
    // rust: if spawned.is_err() {
    // rust: let _ = slot.set(lz4_flex::compress_prepend_size(&raw));
}
    // rust: self.packed = Some(slot);
}
    /// A sprite, or the missing one when the atlas has no such sprite (an
    /// effect without its icon), as a stitched atlas answers.
pub fn sprite_or_missing(self: *Self, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.sprites
    // rust: .get(name)
    // rust: .or_else(|| self.sprites.get(MISSING_SPRITE))
    // rust: .copied()
}
    /// Keep a ready profile skin when another source only has its default.
pub fn set_object_skin(self: *Self, key: []const u8, skin: []const u8) void {
}
//         use std::collections::hash_map::Entry;
    // rust: if self.object_skins.len() >= 1024 && !self.object_skins.contains_key(&key) {
    // rust: self.object_skins.clear();
}
    // rust: match self.object_skins.entry(key) {
    // rust: Entry::Occupied(entry)
    // rust: if skin.starts_with("entity/player/") && self.sprites.contains_key(entry.get()) => {
}
    // rust: Entry::Occupied(mut entry) => {
    // rust: entry.insert(skin);
}
    // rust: Entry::Vacant(entry) => {
    // rust: entry.insert(skin);
}
}
}
    /// A font glyph's atlas cell (8x8 GUI pixels) and advance.
pub fn glyph(self: *Self, ch: char) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let g = self.font.glyph(ch);
    // rust: g.rect.map(|rect| (rect, g.advance))
}
    /// A font glyph in the default font: its atlas cell (none for blank
    /// glyphs such as the space), its box and advance.
pub fn glyph_cell(self: *Self, ch: char) c {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.font.glyph(ch)
}
pub fn build(root: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::build_over(root, root)
}
    /// The atlas of a resource root that layers packs over `defaults` (the
    /// game's own resources), whose textures give the sprites' GUI sizes.
pub fn build_over(root: *Path, defaults: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::build_over_with_image(root, defaults, false)
}
    /// The atlas above, with a slot for a native mod's own image
    /// (`horizon/modimage`) only when `mod_image` says a mod is loaded that
    /// draws one: the slot costs 4 MiB of pixels, so a game without native
    /// mods holds none of them.
pub fn build_over_with_image(root: *Path, defaults: *Path, mod_image: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut atlas = Self::pack(root, defaults, WALKED_TEXTURE_FOLDERS, true, mod_image)?;
    // rust: atlas.text_shader = pack_text::load(root, defaults);
    // rust: atlas.lines_shader = pack_text::load_core(
    // rust: root,
    // rust: defaults,
    // rust: "rendertype_lines",
    // rust: &[],
    // rust: &crate::gfx::core_lines::GLUE,
    // rust: );
    // rust: Ok(atlas)
}
    /// Empty slots written at run time: map textures (game/maps.rs), the
    /// minimap, a native mod's own image, downloaded skins, world and pack
    /// icons and the on-screen keyboard's text.
pub fn slots(images: *mut std.ArrayList(PackedImage), trim: (u32) void {
}
    // rust: for i in 0..MAP_SLOTS {
    // rust: let name = map_slot_sprite(i).unwrap_or_default();
    // rust: images.push((name.into(), 128, 128, vec![0; 128 * 128 * 4]));
}
        // The minimap extra's image (game/extras.rs).
    // rust: images.push((
    // rust: MINIMAP_SPRITE.into(),
    // rust: crate::minimap::SIZE as u32,
    // rust: crate::minimap::SIZE as u32,
    // rust: vec![0; crate::minimap::SIZE * crate::minimap::SIZE * 4],
    // rust: ));
        // A mod's own image (native `mod_image`), only when a mod is loaded.
    // rust: if mod_image {
    // rust: images.push((
    // rust: MOD_IMAGE_SPRITE.into(),
    // rust: MOD_IMAGE_SIZE,
    // rust: MOD_IMAGE_SIZE,
    // rust: vec![0; (MOD_IMAGE_SIZE * MOD_IMAGE_SIZE * 4) as usize],
    // rust: ));
}
        // Downloaded skins (game/scoreboard.rs).
    // rust: for i in 0..SKIN_SLOTS {
    // rust: images.push((format!("horizon/skin{i}"), 64, 64, vec![0; 64 * 64 * 4]));
}
    // rust: for i in 0..TRIM_SLOTS {
    // rust: images.push((
    // rust: format!("horizon/trim{i}"),
    // rust: trim.0,
    // rust: trim.1,
    // rust: vec![0; (trim.0 * trim.1 * 4) as usize],
    // rust: ));
}
    // rust: for i in 0..WORLD_ICON_SLOTS {
    // rust: images.push((
    // rust: format!("horizon/world-icon{i}"),
    // rust: 64,
    // rust: 64,
    // rust: vec![0; 64 * 64 * 4],
    // rust: ));
}
    // rust: let side = PACK_ICON_SIZE as usize;
    // rust: for i in 0..PACK_ICON_SLOTS {
    // rust: images.push((
    // rust: format!("horizon/pack-icon{i}"),
    // rust: PACK_ICON_SIZE,
    // rust: PACK_ICON_SIZE,
    // rust: vec![0; side * side * 4],
    // rust: ));
}
        // The on-screen keyboard's text and corner masks (ui_theme), rasterized at run time.
    // rust: images.push((
    // rust: "horizon/ui-text".into(),
    // rust: 2048,
    // rust: 1024,
    // rust: vec![0; 2048 * 1024 * 4],
    // rust: ));
}
    /// Only the font's metrics, for a game that draws nothing (the
    /// integrated or dedicated server): text measures as with the full atlas,
    /// without packing textures or rasterizing glyphs.
pub fn fonts(root: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let white = Rect {
    // rust: u0: 0.0,
    // rust: v0: 0.0,
    // rust: u1: 1.0,
    // rust: v1: 1.0,
    // rust: w: 1,
    // rust: h: 1,
}
    // rust: Ok(Self {
    // rust: revision: Self::next_revision(),
    // rust: pixels: Vec::new(),
    // rust: packed: None,
    // rust: galactic_widths: [0; 128],
    // rust: width: 1,
    // rust: height: 1,
    // rust: sprites: HashMap::new(),
    // rust: object_skins: HashMap::new(),
    // rust: translucent: HashSet::new(),
    // rust: flags: HashMap::new(),
    // rust: sprite_animations: Vec::new(),
    // rust: font: crate::font::Font::metrics(root),
    // rust: glint: (Vec::new(), 1, 1),
    // rust: glint_armor: (Vec::new(), 1, 1),
    // rust: text_shader: None,
    // rust: lines_shader: None,
    // rust: random_textures: Default::default(),
    // rust: emissive: Arc::default(),
    // rust: blinks: Default::default(),
    // rust: white,
    // rust: })
}
    /// The boot screen's atlas, before any pack loads: the theme's run-time
    /// glyphs (`horizon/ui-text`), a white sprite and the glyph rows over
    /// transparent black. Nothing from a pack: the boot screen draws with
    /// the theme's bundled faces, so the font here has no sheets to read.
pub fn boot() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (width, height) = (1024, 1024);
    // rust: let text_rows = 512;
    // rust: let glyph_top = text_rows + 4;
    // rust: let mut pixels = vec![0u8; (width * height * 4) as usize];
        // The white sprite the fills and the font's underline pass sample.
    // rust: for row in 0..4 {
    // rust: let at = ((text_rows + row) * width * 4) as usize;
    // rust: pixels[at..at + 16].fill(255);
}
    // rust: let rect = |u0: u32, v0: u32, u1: u32, v1: u32, w: u32, h: u32| Rect {
    // rust: u0: u0 as f32 / width as f32,
    // rust: v0: v0 as f32 / height as f32,
    // rust: u1: u1 as f32 / width as f32,
    // rust: v1: v1 as f32 / height as f32,
    // rust: w,
    // rust: h,
}
    // rust: let mut sprites = HashMap::new();
    // rust: sprites.insert(
    // rust: "horizon/white".into(),
    // rust: rect(0, text_rows, 4, glyph_top, 4, 4),
    // rust: );
    // rust: sprites.insert(
    // rust: "horizon/ui-text".into(),
    // rust: rect(0, 0, width, text_rows, width, text_rows),
    // rust: );
    // rust: let white = sprites["horizon/white"];
    // rust: Self {
    // rust: revision: Self::next_revision(),
    // rust: font: crate::font::Font::load(
    // rust: Path::new("horizon-boot"),
    // rust: &sprites,
    // rust: &pixels,
    // rust: (width, height),
    // rust: (glyph_top, height - glyph_top),
    // rust: white,
    // rust: ),
    // rust: galactic_widths: galactic_widths(&sprites, &pixels, width, height),
    // rust: pixels,
    // rust: packed: None,
    // rust: width,
    // rust: height,
    // rust: sprites,
    // rust: translucent: HashSet::new(),
    // rust: flags: HashMap::new(),
    // rust: object_skins: HashMap::new(),
    // rust: sprite_animations: Vec::new(),
    // rust: glint: (vec![0; 4], 1, 1),
    // rust: glint_armor: (vec![0; 4], 1, 1),
    // rust: white,
    // rust: text_shader: None,
    // rust: lines_shader: None,
    // rust: random_textures: Default::default(),
    // rust: emissive: Default::default(),
    // rust: blinks: Default::default(),
}
}
    /// `layout`, but when `extras` (Custom Item Textures) make the images more than `max`
    /// holds, without them: they are left out, not the packs.
    // rust: fn layout_leaving_out(
    // rust: images: &mut Vec<PackedImage>,
    // rust: animated: &mut Vec<String>,
    // rust: extras: &HashSet<String>,
    // rust: max: u32,
    // rust: ) -> Result<(u32, Vec<(u32, u32)>, u32)> {
    // rust: match Self::layout(images, max) {
    // rust: Err(e) if !extras.is_empty() => {
    // rust: images.retain(|i| !extras.contains(&i.0));
    // rust: animated.retain(|n| !extras.contains(n));
    // rust: let layout = Self::layout(images, max)?;
    // rust: log::warn!("left out the custom item textures: {e}");
    // rust: Ok(layout)
}
    // rust: layout => layout,
}
}
    /// Shelf placements of `images` (tallest first) in the narrowest atlas
    /// width from 4096 up that keeps the atlas, glyph rows included, within
    /// `max` texels a side; and the first row free for glyphs. High-resolution
    /// packs fill a 4096-wide atlas past what GPUs allow (Faithful 64x needs
    /// 32768 rows); vanilla's stitcher fails the reload when its atlases don't
    /// fit, and the packs are then turned off (`Minecraft.clearResourcePacksOnError`).
    /// A width where the plain shelves (each image after the last) leave too
    /// much unused is tried again with each image in the first shelf with
    /// room: a pack of thousands of mixed sizes (server packs with custom
    /// items) fits where the shelves' ragged ends would not.
pub fn layout(images: *[PackedImage], max: u32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut width = 4096.min(max);
    // rust: loop {
    // rust: let wide_enough = images.iter().all(|i| i.1 < width);
    // rust: if wide_enough {
    // rust: for first_fit in [false, true] {
    // rust: let (placements, glyph_region) = Self::shelves(images, width, first_fit);
    // rust: if glyph_region + GLYPH_ROWS <= max {
    // rust: return Ok((width, placements, glyph_region));
}
}
}
    // rust: if width >= max {
    // rust: let texels: u64 = images.iter().map(|i| u64::from(i.1) * u64::from(i.2)).sum();
    // rust: return Err(format!(
    // rust: "the textures ({} images, {texels} texels) do not fit a {max}x{max} atlas",
    // rust: images.len()
    // rust: )
    // rust: .into());
}
    // rust: width = (width * 2).min(max);
}
}
    /// `layout`'s shelves at one width: the placements and the first row below
    /// them. `first_fit` puts an image in the first shelf that is tall enough
    /// and has room, instead of only the last one.
pub fn shelves(images: *[PackedImage], width: u32, first_fit: bool) ( {
    // Implementation ported from Horizon
    return undefined;
}
        // Each shelf: its top row, its height (its first image's) and the next free column.
    // rust: let mut shelves: Vec<(u32, u32, u32)> = Vec::new();
    // rust: let mut placements = Vec::with_capacity(images.len());
    // rust: for (_, w, h, _) in images {
    // rust: let open = if first_fit {
    // rust: shelves.iter().position(|s| s.1 >= *h && s.2 + w < width)
    // rust: } else {
    // rust: shelves
    // rust: .len()
    // rust: .checked_sub(1)
    // rust: .filter(|&i| shelves[i].1 >= *h && shelves[i].2 + w < width)
}
    // rust: let i = open.unwrap_or_else(|| {
    // rust: let top = shelves.last().map_or(0, |s| s.0 + s.1 + 1);
    // rust: shelves.push((top, *h, 0));
    // rust: shelves.len() - 1
    // rust: });
    // rust: placements.push((shelves[i].2, shelves[i].0));
    // rust: shelves[i].2 += w + 1;
}
    // rust: let glyph_region = shelves.last().map_or(1, |s| s.0 + s.1 + 1);
    // rust: (placements, glyph_region)
}
    /// Pack the textures under these folders of `textures/`, and for the
    /// `full` atlas the generated sprites and the run-time slots too.
    // rust: fn pack(
    // rust: root: &Path,
    // rust: defaults: &Path,
    // rust: folders: &[&str],
    // rust: full: bool,
    // rust: mod_image: bool,
    // rust: ) -> Result<Self> {
    // rust: let textures = root.join("assets/minecraft/textures");
    // rust: let default_textures =
    // rust: (defaults != root).then(|| defaults.join("assets/minecraft/textures"));
    // rust: let mut files = Vec::new();
    // rust: for folder in folders {
    // rust: walk(&textures.join(folder), &mut files);
}
        // Content mods' entity textures: their equipment assets name them as
        // `<ns>:<path>`, and native mods draw their block entities with them
        // (`native_draw_quad`: `<ns>:entity/...`); and their mob effects'
        // icons, `<ns>:mob_effect/<path>`.
    // rust: let namespaces = horizon_items::content_namespaces::namespaces(root);
    // rust: for folder in ["entity", "mob_effect"] {
    // rust: if folders.contains(&folder) {
    // rust: for namespace in &namespaces {
    // rust: walk(
    // rust: &root.join(format!("assets/{namespace}/textures/{folder}")),
    // rust: &mut files,
    // rust: );
}
}
}
    // rust: let assets = root.join("assets");
        // A native mod's particle type names its textures `<ns>:particle/<path>`
        // and needn't ship content, so every namespace's folder is packed.
    // rust: if folders.contains(&"particle")
    // rust: && let Ok(namespaces) = fs::read_dir(&assets)
    // rust: {
    // rust: for ns in namespaces.flatten() {
    // rust: if ns.file_name() != "minecraft" {
    // rust: walk(&ns.path().join("textures/particle"), &mut files);
}
}
}
        // Content mods' GUI textures, for their screens: `<namespace>:gui/...`.
    // rust: if full && let Ok(namespaces) = fs::read_dir(&assets) {
    // rust: for ns in namespaces.flatten() {
    // rust: if ns.file_name() != "minecraft" {
    // rust: walk(&ns.path().join("textures/gui"), &mut files);
}
}
}
    // rust: files.retain(|p| {
    // rust: let s = p.to_string_lossy();
    // rust: !s.contains("title/background") && !s.contains("presets")
    // rust: });
        // OptiFine random entity variants, under the names their scan gives them (those
        // outside `textures/` are `<ns>:optifine/random/...`).
    // rust: let random_textures = if folders.contains(&"entity") {
    // rust: horizon_optifine::random_textures::RandomTextures::scan(root)
    // rust: } else {
    // rust: Default::default()
}
    // rust: let blinks = if folders.contains(&"entity") {
    // rust: horizon_optifine::blink::Blinks::scan(root, &random_textures)
    // rust: } else {
    // rust: Default::default()
}
    // rust: let emissive = std::sync::Arc::new(if folders.contains(&"entity") {
    // rust: let mut e = horizon_optifine::emissive::Emissive::scan(root, &random_textures);
    // rust: e.pair_beside(root, blinks.files());
    // rust: e
    // rust: } else {
    // rust: Default::default()
    // rust: });
    // rust: let mut named: HashMap<PathBuf, String> = HashMap::new();
    // rust: let extra = random_textures
    // rust: .files()
    // rust: .chain(emissive.files())
    // rust: .chain(blinks.files());
    // rust: for (file, name) in extra {
    // rust: named.insert(root.join(file), name.to_owned());
}
    // rust: if !named.is_empty() {
            // A pack's variants can't grow the shared atlas past what a GPU takes: every variant
            // (those beside their texture too) counts, in name order, and those past the budget
            // stay out (their mobs wear the texture itself), not the whole pack.
            // Overlays and blink frames only after every variant.
    // rust: let overlays: HashSet<PathBuf> = emissive
    // rust: .files()
    // rust: .chain(blinks.files())
    // rust: .map(|(f, _)| root.join(f))
    // rust: .collect();
    // rust: let kept = budgeted(named.keys(), &overlays, RANDOM_TEXELS);
    // rust: if kept.len() < named.len() {
    // rust: log::warn!(
    // rust: "{} random entity textures left out of the atlas: past its budget",
    // rust: named.len() - kept.len()
    // rust: );
}
            // A dropped variant beside its texture takes its walked overlay and blink frames
            // (and theirs) with it: nothing would draw them.
    // rust: let png = format!("{}.png", emissive.suffix);
    // rust: let png = png.as_str();
    // rust: let orphans: HashSet<PathBuf> = named
    // rust: .keys()
    // rust: .filter(|p| !kept.contains(*p))
    // rust: .filter_map(|p| p.to_str()?.strip_suffix(".png").map(str::to_owned))
    // rust: .flat_map(|stem| {
    // rust: ["", "_blink", "_blink2"]
    // rust: .into_iter()
    // rust: .flat_map(move |frame| {
    // rust: [format!("{stem}{frame}.png"), format!("{stem}{frame}{png}")]
    // rust: })
    // rust: })
    // rust: .map(PathBuf::from)
    // rust: .filter(|p| !named.contains_key(p))
    // rust: .collect();
    // rust: files.retain(|p| (!named.contains_key(p) || kept.contains(p)) && !orphans.contains(p));
            // Those beside their texture are walked already.
    // rust: let walked: HashSet<&PathBuf> = files.iter().collect();
    // rust: let mut extra: Vec<PathBuf> = kept
    // rust: .iter()
    // rust: .filter(|p| !walked.contains(p))
    // rust: .cloned()
    // rust: .collect();
    // rust: extra.sort();
    // rust: files.extend(extra);
}
    // rust: type Decoded = (PackedImage, Option<TextureFlags>, Option<(u32, u32)>, bool);
    // rust: let decode_one = |path: &PathBuf| -> Option<Decoded> {
    // rust: let name = if let Some(name) = named.get(path) {
    // rust: name.clone()
    // rust: } else {
    // rust: match path.strip_prefix(&textures) {
    // rust: Ok(rel) => rel.with_extension("").to_string_lossy().replace('\\', "/"),
    // rust: Err(_) => {
    // rust: let rel = path.strip_prefix(&assets).ok()?.with_extension("");
    // rust: let rel = rel.to_string_lossy().replace('\\', "/");
    // rust: let (namespace, rest) = rel.split_once("/textures/")?;
    // rust: format!("{namespace}:{rest}")
}
}
}
            // LabPBR's maps beside a texture are the world's (sprites.rs), not images to draw.
    // rust: if let Some(base) = name.strip_suffix("_n").or_else(|| name.strip_suffix("_s"))
    // rust: && textures.join(format!("{base}.png")).is_file()
    // rust: {
    // rust: return None;
}
    // rust: let image = decode(path)
    // rust: .map_err(|e| log::warn!("skipped GUI texture {}: {e}", path.display()))
    // rust: .ok()?;
    // rust: let mcmeta =
    // rust: horizon_core::prepared_files::read_to_string(&path.with_extension("png.mcmeta"))
    // rust: .ok();
    // rust: let animation = animation_of(mcmeta.as_deref());
            // An animated strip keeps its first frame.
    // rust: let frames =
    // rust: animation.is_some() || name.starts_with("block/") || name.starts_with("item/");
    // rust: let (w, h, pixels) = if frames {
    // rust: first_frame(image, animation.as_ref())
    // rust: } else {
    // rust: image
}
            // The default texture's size, when a pack's differs from it.
    // rust: let gui_size = default_textures
    // rust: .as_ref()
    // rust: .and_then(|d| png_size(&d.join(format!("{name}.png"))))
    // rust: .map(|(dw, dh)| {
    // rust: let side = dw.min(dh);
    // rust: if frames { (side, side) } else { (dw, dh) }
    // rust: })
    // rust: .filter(|&size| size != (w, h));
    // rust: let flags = mcmeta.as_deref().and_then(TextureFlags::from_mcmeta);
    // rust: let animated = frames && animation.is_some();
    // rust: let (gw, gh) = gui_size.unwrap_or((w, h));
    // rust: (gw <= 1024 && (gh <= 512 || name.starts_with("font/"))).then_some((
    // rust: (name, w, h, pixels),
    // rust: flags,
    // rust: gui_size,
    // rust: animated,
    // rust: ))
}
    // rust: let threads = std::thread::available_parallelism().map_or(2, |n| n.get());
    // rust: let chunk = files.len().div_ceil(threads).max(1);
    // rust: let decoded: Vec<_> = std::thread::scope(|scope| {
    // rust: let handles: Vec<_> = files
    // rust: .chunks(chunk)
    // rust: .map(|part| {
    // rust: scope.spawn(move || part.iter().filter_map(decode_one).collect::<Vec<_>>())
    // rust: })
    // rust: .collect();
    // rust: handles
    // rust: .into_iter()
    // rust: .flat_map(|h| h.join().unwrap_or_default())
    // rust: .collect()
    // rust: });
    // rust: let mut flags = HashMap::new();
    // rust: let mut gui_sizes = HashMap::new();
    // rust: let mut animated: Vec<String> = Vec::new();
    // rust: let mut images: Vec<PackedImage> = Vec::with_capacity(decoded.len());
    // rust: for (image, image_flags, gui_size, is_animated) in decoded {
    // rust: if let Some(f) = image_flags {
    // rust: flags.insert(image.0.clone(), f);
}
    // rust: if let Some(size) = gui_size {
    // rust: gui_sizes.insert(image.0.clone(), size);
}
    // rust: if is_animated {
    // rust: animated.push(image.0.clone());
}
    // rust: images.push(image);
}
    // rust: let mut cit_names = HashSet::new();
    // rust: if full {
    // rust: let (more, more_animated) = atlas_sprites(root, &images);
    // rust: images.extend(more);
    // rust: animated.extend(more_animated);
    // rust: for (image, image_flags, is_animated) in cit_sprites(root, &images) {
    // rust: cit_names.insert(image.0.clone());
    // rust: if let Some(f) = image_flags {
    // rust: flags.insert(image.0.clone(), f);
}
    // rust: if is_animated {
    // rust: animated.push(image.0.clone());
}
    // rust: images.push(image);
}
}
        // The title screen's "JAVA EDITION" banner reads "RUST EDITION".
    // rust: if let Some(edition) = images
    // rust: .iter_mut()
    // rust: .find(|i| i.0 == crate::title_edition::SPRITE)
    // rust: && let Some(pixels) =
    // rust: crate::title_edition::rust_edition(edition.1, edition.2, &edition.3)
    // rust: {
    // rust: edition.3 = pixels;
}
    // rust: images.push(("horizon/white".into(), 4, 4, vec![255; 64]));
        // The controller's art, unless a pack brought its own (walked above, as a mod's GUI
        // textures are).
    // rust: for image in crate::pad_glyph::images() {
    // rust: if !images.iter().any(|i| i.0 == image.0) {
    // rust: images.push(image);
}
}
    // rust: if full {
    // rust: Self::slots(&mut images, crate::trims::slot_size(root), mod_image);
            // MissingTextureAtlasSprite.generateMissingImage: 16x16, magenta
            // and black quarters.
    // rust: let missing = (0..256)
    // rust: .flat_map(|i| match (i / 16 < 8) ^ (i % 16 < 8) {
    // rust: true => [248, 0, 248, 255],
    // rust: false => [0, 0, 0, 255],
    // rust: })
    // rust: .collect();
    // rust: images.push((MISSING_SPRITE.into(), 16, 16, missing));
}
        // Blurred sprites are sampled linearly in the atlas (screen.wgsl): a
        // border wrapped from their own edges keeps the filter off their
        // neighbours, as repeat addressing of their own texture would.
    // rust: let mut bordered = std::collections::HashSet::new();
    // rust: for image in &mut images {
    // rust: if flags.get(&image.0).is_some_and(|f: &TextureFlags| f.blur) {
    // rust: *image = wrap_border(image);
    // rust: bordered.insert(image.0.clone());
}
}
    // rust: images.sort_by(|a, b| b.2.cmp(&a.2).then(b.1.cmp(&a.1)));
    // rust: let (width, placements, glyph_region) =
    // rust: Self::layout_leaving_out(&mut images, &mut animated, &cit_names, MAX_ATLAS_SIZE)?;
        // A multiple of 1024 rather than a power of two: the default resources
        // need 4096x5120 (8192 rows before), Faithful 32x 4096x12288 (16384).
    // rust: let height = (glyph_region + GLYPH_ROWS).next_multiple_of(1024);
    // rust: let mut pixels = vec![0u8; (width * height * 4) as usize];
    // rust: let mut sprites = HashMap::new();
    // rust: let mut translucent = HashSet::new();
    // rust: for ((name, w, h, data), (px, py)) in images.iter().zip(placements) {
    // rust: if data
    // rust: .as_chunks::<4>()
    // rust: .0
    // rust: .iter()
    // rust: .any(|p| p[3] != 0 && p[3] != 255)
    // rust: {
    // rust: translucent.insert(name.clone());
}
    // rust: for row in 0..*h {
    // rust: let src = &data[(row * w * 4) as usize..((row + 1) * w * 4) as usize];
    // rust: let dst = (((py + row) * width + px) * 4) as usize;
    // rust: pixels[dst..dst + (w * 4) as usize].copy_from_slice(src);
}
    // rust: let b = u32::from(bordered.contains(name));
    // rust: let (px, py, w, h) = (px + b, py + b, w - 2 * b, h - 2 * b);
    // rust: let (gw, gh) = gui_sizes.get(name).copied().unwrap_or((w, h));
    // rust: sprites.insert(
    // rust: name.clone(),
    // rust: Rect {
    // rust: u0: px as f32 / width as f32,
    // rust: v0: py as f32 / height as f32,
    // rust: u1: (px + w) as f32 / width as f32,
    // rust: v1: (py + h) as f32 / height as f32,
    // rust: w: gw,
    // rust: h: gh,
    // rust: },
    // rust: );
}
        // Every animated sprite animates: the packed strip is the raw first
        // frame, while the mcmeta's frame list may start anywhere, so each
        // animation's frame(0) overwrites its atlas rect before drawing.
    // rust: let mut loaded = crate::sprites::Sprites::default();
    // rust: let mut sprite_animations = Vec::new();
    // rust: animated.sort();
    // rust: for name in animated {
    // rust: let Some(rect) = sprites.get(&name).copied() else {
    // rust: continue;
}
            // Another namespace's sprite is named with it (`lobby:item/...`).
    // rust: let id = if name.contains(':') {
    // rust: name.clone()
    // rust: } else {
    // rust: format!("minecraft:{name}")
}
    // rust: let Ok(layer) = loaded.insert(root, &id) else {
    // rust: continue;
}
    // rust: let Some(animation) = loaded.animations.iter().find(|a| a.layer == layer).cloned()
    // rust: else {
    // rust: continue;
}
    // rust: let (tw, th) = rect.texels((width, height));
    // rust: let image = animation.resized_pixels(animation.frame(0), tw, th);
    // rust: let x = (rect.u0 * width as f32).round() as usize;
    // rust: let y = (rect.v0 * height as f32).round() as usize;
    // rust: let row_bytes = tw as usize * 4;
    // rust: for row in 0..th as usize {
    // rust: let dst = ((y + row) * width as usize + x) * 4;
    // rust: let src = row * row_bytes;
    // rust: pixels[dst..dst + row_bytes].copy_from_slice(&image[src..src + row_bytes]);
}
    // rust: sprite_animations.push((rect, animation));
}
    // rust: let white = sprites["horizon/white"];
    // rust: let glint = Self::glint_texture(root, defaults, "enchanted_glint_item");
    // rust: let glint_armor = Self::glint_texture(root, defaults, "enchanted_glint_armor");
    // rust: let font = crate::font::Font::load(
    // rust: root,
    // rust: &sprites,
    // rust: &pixels,
    // rust: (width, height),
    // rust: (glyph_region, height - glyph_region),
    // rust: white,
    // rust: );
    // rust: Ok(Self {
    // rust: revision: Self::next_revision(),
    // rust: galactic_widths: galactic_widths(&sprites, &pixels, width, height),
    // rust: pixels,
    // rust: packed: None,
    // rust: width,
    // rust: height,
    // rust: sprites,
    // rust: object_skins: HashMap::new(),
    // rust: translucent,
    // rust: flags,
    // rust: sprite_animations,
    // rust: glint,
    // rust: glint_armor,
    // rust: text_shader: None,
    // rust: lines_shader: None,
    // rust: random_textures,
    // rust: emissive,
    // rust: blinks,
    // rust: font,
    // rust: white,
    // rust: })
}
    /// `misc/<name>.png` on its own, or a transparent texel if the resource
    /// pack lacks it.
pub fn glint_texture(root: *Path, defaults: *Path, name: []const u8) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let relative = format!("assets/minecraft/textures/misc/{name}.png");
    // rust: let mut path = root.join(&relative);
    // rust: if !path.exists() && defaults != root {
    // rust: path = defaults.join(&relative);
}
    // rust: decode(&path).map_or((vec![0; 4], 1, 1), |(w, h, pixels)| (pixels, w, h))
}
}
pub const HudVertex = struct {
    pos: [f32,
    uv: [f32,
    color: u32,
    depth: f32,
    /// The `GLINT_TEXTURING` UV into the repeating glint texture, unused
    /// unless `uv.x >= 2`.
    glint_uv: [f32,
    /// 1 for the GUI's text (`RenderPipelines.GUI_TEXT`), which a resource
    /// pack's text shader draws when it has one.
    text: u32,
};
/// Sutherland-Hodgman against one half plane, interpolating every attribute.
pub fn clip_polygon(poly: *[HudVertex], axis: usize, limit: f32, keep_below: bool) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let inside = |v: &HudVertex| {
    // rust: if keep_below {
    // rust: v.pos[axis] < limit
    // rust: } else {
    // rust: v.pos[axis] >= limit
}
}
    // rust: let lerp = |a: &HudVertex, b: &HudVertex, t: f32| {
    // rust: let mix = |p: f32, q: f32| p + (q - p) * t;
    // rust: let mut v = *a;
    // rust: v.pos = [mix(a.pos[0], b.pos[0]), mix(a.pos[1], b.pos[1])];
    // rust: v.uv = [mix(a.uv[0], b.uv[0]), mix(a.uv[1], b.uv[1])];
    // rust: v.depth = mix(a.depth, b.depth);
    // rust: v.glint_uv = [
    // rust: mix(a.glint_uv[0], b.glint_uv[0]),
    // rust: mix(a.glint_uv[1], b.glint_uv[1]),
    // rust: ];
    // rust: v.pos[axis] = limit;
    // rust: v
}
    // rust: let mut out = Vec::with_capacity(poly.len() + 2);
    // rust: for i in 0..poly.len() {
    // rust: let (a, b) = (&poly[i], &poly[(i + 1) % poly.len()]);
    // rust: let (ia, ib) = (inside(a), inside(b));
    // rust: if ia {
    // rust: out.push(*a);
}
    // rust: if ia != ib {
    // rust: out.push(lerp(
    // rust: a,
    // rust: b,
    // rust: (limit - a.pos[axis]) / (b.pos[axis] - a.pos[axis]),
    // rust: ));
}
}
    // rust: out
}
/// The GUI Scale option (0 = auto).
pub const GUI_SCALE: std::sync::atomic::AtomicU32 = std::sync::atomic::AtomicU32::new(0);
/// One frame of overlay geometry in GUI pixels.
pub const HudBatch = struct {
    vertices: std.ArrayList(HudVertex),
    scale: f32,
    width: f32,
    height: f32,
    /// Glyph pixels to upload into the atlas before drawing.
    patches: std.ArrayList(crate::font::Patch),
    /// Vertex ranges with another blend or depth/scissor state, in order.
    blends: std.ArrayList((std::ops::Range<u32),
    /// The textures and time of the `Blend::EndPortal` runs.
    end_portal: EndPortalFill,
    /// `options.glintStrength` for the glint pass (`GlintAlpha`).
    glint_alpha: f32,
    /// PvP & HUD's glint colour (`pvp::Tweaks::glint_texel`), 0 for vanilla's.
    glint_colour: u32,
    /// A resource pack text shader's `GameTime`: the day's fraction
    /// (`gameTime % 24000` and the partial tick, over 24000).
    game_time: f32,
    /// Screen's first vertex: the preceding HUD is part of its blurred background.
    blur_at: u32,
    /// Player object profiles encountered while painting text this frame.
    inline_profiles: std.ArrayList(serde_json::Value),
};
/// How a run of HUD vertices blends and tests depth.
pub const Blend = enum {
    /// `BlendFunction.TRANSLUCENT`.
    Alpha,
    /// `BlendFunction.INVERT` (`RenderPipelines.CROSSHAIR`, `GUI_INVERT`).
    Invert,
    /// `BlendFunction.ADDITIVE` (`RenderPipelines.GUI_TEXT_HIGHLIGHT`).
    Additive,
    /// Alpha blending with an isolated depth buffer and a pixel scissor.
    Depth([u32; 4]),
    /// `RenderPipelines.VIGNETTE`: the destination darkened by the texture
    /// (`ZERO, ONE_MINUS_SRC_COLOR`).
    Vignette,
    /// `RenderPipelines.END_PORTAL` as a GUI fill: the End portal's layers
    /// projected from the screen (`HudBatch::end_portal` sets the textures).
    EndPortal,
    /// An OptiFine CIT glint layer (`cit_glint`), blended as entry `n` of
    /// `GlintTextures::blends` says.
    CitGlint(u8),
};
/// What a `Blend::EndPortal` fill samples: the atlas rects (u0, v0, width,
/// height) of `end_sky.png` and `end_portal.png`, and the `GameTime` uniform.
pub const EndPortalFill = struct {
    sprites: [[f32,
    game_time: f32,
};
pub fn rgba(r: u8, g: u8, b: u8, a: u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: u32::from(a) << 24 | u32::from(b) << 16 | u32::from(g) << 8 | u32::from(r)
}
    // rust: impl HudBatch {
    /// Window.calculateScale: the largest scale keeping >= 320x240 GUI pixels,
    /// capped by the GUI Scale option (0 = auto).
pub fn new(window: [u32; 2]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let limit = GUI_SCALE.load(std::sync::atomic::Ordering::Relaxed);
    // rust: let mut scale = 1;
    // rust: while (limit == 0 || scale < limit)
    // rust: && window[0] / (scale + 1) >= 320
    // rust: && window[1] / (scale + 1) >= 240
    // rust: {
    // rust: scale += 1;
}
    // rust: Self {
    // rust: vertices: Vec::new(),
    // rust: scale: scale as f32,
    // rust: width: (window[0] as f32 / scale as f32).ceil(),
    // rust: height: (window[1] as f32 / scale as f32).ceil(),
    // rust: patches: Vec::new(),
    // rust: blends: Vec::new(),
    // rust: end_portal: EndPortalFill::default(),
    // rust: glint_alpha: 0.75,
    // rust: glint_colour: 0,
    // rust: game_time: 0.0,
    // rust: blur_at: 0,
    // rust: inline_profiles: Vec::new(),
}
}
    /// Draw the vertices added since `start` with the inverting blend.
pub fn invert_since(self: *Self, start: usize) void {
}
    // rust: self.blend_since(start, Blend::Invert);
}
    /// Draw the vertices added since `start` with `blend`.
pub fn blend_since(self: *Self, start: usize, blend: Blend) void {
}
    // rust: let range = start as u32..self.vertices.len() as u32;
    // rust: if range.is_empty() || blend == Blend::Alpha {
    // rust: return;
}
    // rust: match self.blends.last_mut() {
    // rust: Some((last, b)) if last.end == range.start && *b == blend => last.end = range.end,
    // rust: _ => self.blends.push((range, blend)),
}
}
    /// `GuiGraphicsExtractor.textHighlight`: with `invert_text` the area's
    /// colours are inverted first (white text on a dark field turns blue on
    /// white), then blue is added.
    // rust: pub fn text_highlight(
    // rust: &mut self,
    // rust: atlas: &HudAtlas,
    // rust: (x, y, w, h): (f32, f32, f32, f32),
    // rust: invert_text: bool,
    // rust: ) {
    // rust: if invert_text {
    // rust: let start = self.vertices.len();
    // rust: self.fill(atlas, x, y, w, h, rgba(255, 255, 255, 255));
    // rust: self.invert_since(start);
}
    // rust: let start = self.vertices.len();
    // rust: self.fill(atlas, x, y, w, h, rgba(0, 0, 255, 255));
    // rust: self.blend_since(start, Blend::Additive);
}
    /// The vertex ranges in order, each with its blend.
pub fn runs(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Vec::new();
    // rust: let mut at = 0;
    // rust: for (r, blend) in &self.blends {
    // rust: if r.start > at {
    // rust: out.push((at..r.start, Blend::Alpha));
}
    // rust: out.push((r.clone(), *blend));
    // rust: at = r.end;
}
    // rust: let end = self.vertices.len() as u32;
    // rust: if end > at {
    // rust: out.push((at..end, Blend::Alpha));
}
    // rust: out
}
pub fn runs_in(self: *Self, vertices: std::ops::Range<u32>) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut runs = self.runs();
    // rust: for (range, _) in &mut runs {
    // rust: *range = range.start.max(vertices.start)..range.end.min(vertices.end);
}
    // rust: runs.retain(|(range, _)| !range.is_empty());
    // rust: runs
}
    /// `AbstractContainerScreen.init`: center in integer GUI coordinates.
pub fn centered_origin(self: *Self, width: f32, height: f32) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (
    // rust: ((self.width - width) / 2.0).trunc(),
    // rust: ((self.height - height) / 2.0).trunc(),
    // rust: )
}
pub fn quad(self: *Self, p: [[f32; 2]; 4], uv: [[f32; 2]; 4], color: u32) void {
}
    // rust: for i in [0, 1, 2, 0, 2, 3] {
    // rust: self.vertices.push(HudVertex {
    // rust: pos: p[i],
    // rust: uv: uv[i],
    // rust: color,
    // rust: depth: 0.0,
    // rust: glint_uv: [0.0, 0.0],
    // rust: text: 0,
    // rust: });
}
}
    /// A quad whose texture is the `GLINT_TEXTURING` sample at `glint_uv`;
    /// `uv` is the item's atlas UV, which the shader masks by.
    // rust: pub fn quad_glint(
    // rust: &mut self,
    // rust: p: [[f32; 2]; 4],
    // rust: uv: [[f32; 2]; 4],
    // rust: glint_uv: [[f32; 2]; 4],
    // rust: color: u32,
    // rust: ) {
    // rust: for i in [0, 1, 2, 0, 2, 3] {
    // rust: self.vertices.push(HudVertex {
    // rust: pos: p[i],
    // rust: uv: uv[i],
    // rust: color,
    // rust: depth: 0.0,
    // rust: glint_uv: glint_uv[i],
    // rust: text: 0,
    // rust: });
}
}
pub fn quad_3d(self: *Self, p: [[f32; 3]; 4], uv: [[f32; 2]; 4], color: u32) void {
}
    // rust: for i in [0, 1, 2, 0, 2, 3] {
    // rust: self.vertices.push(HudVertex {
    // rust: pos: [p[i][0], p[i][1]],
    // rust: uv: uv[i],
    // rust: color,
    // rust: depth: p[i][2],
    // rust: glint_uv: [0.0, 0.0],
    // rust: text: 0,
    // rust: });
}
}
    /// Keep per-vertex depth for an orthographic GUI model, with +z toward the viewer.
pub fn depth_since(self: *Self, start: usize, clip: [f32; 4]) void {
}
    // rust: let vertices = &mut self.vertices[start..];
    // rust: if vertices.is_empty() {
    // rust: return;
}
    // rust: let min = vertices
    // rust: .iter()
    // rust: .map(|v| v.depth)
    // rust: .fold(f32::INFINITY, f32::min);
    // rust: let max = vertices
    // rust: .iter()
    // rust: .map(|v| v.depth)
    // rust: .fold(f32::NEG_INFINITY, f32::max);
    // rust: for v in vertices {
    // rust: v.depth = (max - v.depth) / (max - min).max(f32::EPSILON);
}
    // rust: let [x0, y0, x1, y1] = clip.map(|v| (v * self.scale).max(0.0) as u32);
        // Separate previews clear depth independently, even if their scissors match.
    // rust: self.blends.push((
    // rust: start as u32..self.vertices.len() as u32,
    // rust: Blend::Depth([x0, y0, x1.saturating_sub(x0), y1.saturating_sub(y0)]),
    // rust: ));
}
pub fn rect_uv(self: *Self, x: f32, y: f32, w: f32, h: f32, r: Rect, color: u32) void {
}
    // rust: self.quad(
    // rust: [[x, y], [x + w, y], [x + w, y + h], [x, y + h]],
    // rust: [[r.u0, r.v0], [r.u1, r.v0], [r.u1, r.v1], [r.u0, r.v1]],
    // rust: color,
    // rust: );
}
pub fn sprite(self: *Self, atlas: *HudAtlas, name: []const u8, x: f32, y: f32) void {
}
    // rust: if let Some(r) = atlas.sprites.get(name).copied() {
    // rust: self.rect_uv(x, y, r.w as f32, r.h as f32, r, u32::MAX);
}
}
    // rust: pub fn sprite_scaled(
    // rust: &mut self,
    // rust: atlas: &HudAtlas,
    // rust: name: &str,
    // rust: x: f32,
    // rust: y: f32,
    // rust: w: f32,
    // rust: h: f32,
    // rust: color: u32,
    // rust: ) {
    // rust: if let Some(r) = atlas.sprites.get(name).copied() {
    // rust: self.rect_uv(x, y, w, h, r, color);
}
}
    /// Draw part of a sprite, `fraction` of its width from the left.
pub fn sprite_part(self: *Self, atlas: *HudAtlas, name: []const u8, x: f32, y: f32, fraction: f32) void {
}
    // rust: if let Some(mut r) = atlas.sprites.get(name).copied() {
    // rust: let w = r.w as f32 * fraction;
    // rust: r.u1 = r.u0 + (r.u1 - r.u0) * fraction;
    // rust: self.rect_uv(x, y, w, r.h as f32, r, u32::MAX);
}
}
    /// Clip the quads drawn since `start` to `[x0, x1) x [y0, y1)` (the
    /// GUI scissor): axis-aligned quads are cut with their UVs, others (item
    /// triangles) are clipped as polygons.
    /// Scale the vertices pushed since `start` about `(cx, cy)` (a GUI pose
    /// matrix of translate, scale, translate back).
pub fn scale_since(self: *Self, start: usize, cx: f32, cy: f32, sx: f32, sy: f32) void {
}
    // rust: for v in &mut self.vertices[start..] {
    // rust: v.pos[0] = cx + (v.pos[0] - cx) * sx;
    // rust: v.pos[1] = cy + (v.pos[1] - cy) * sy;
}
}
pub fn clip_since(self: *Self, start: usize, x0: f32, y0: f32, x1: f32, y1: f32) void {
}
    // rust: let quads: Vec<[HudVertex; 6]> = self.vertices[start..].as_chunks::<6>().0.to_vec();
    // rust: self.vertices.truncate(start);
        // Where each source quad now begins, to move the blend ranges (foil
        // items are an additive run) along with their vertices.
    // rust: let mut moved = Vec::with_capacity(quads.len() + 1);
    // rust: for q in quads {
    // rust: moved.push(self.vertices.len() as u32);
    // rust: let corners = [q[0], q[1], q[2], q[5]];
    // rust: let (mut x_lo, mut x_hi) = (f32::INFINITY, f32::NEG_INFINITY);
    // rust: let (mut y_lo, mut y_hi) = (f32::INFINITY, f32::NEG_INFINITY);
    // rust: for v in &corners {
    // rust: x_lo = x_lo.min(v.pos[0]);
    // rust: x_hi = x_hi.max(v.pos[0]);
    // rust: y_lo = y_lo.min(v.pos[1]);
    // rust: y_hi = y_hi.max(v.pos[1]);
}
            // An axis-aligned rectangle, its corners in any order.
    // rust: let find = |x: f32, y: f32| corners.iter().find(|v| v.pos == [x, y]).copied();
    // rust: let rect = (
    // rust: find(x_lo, y_lo),
    // rust: find(x_hi, y_lo),
    // rust: find(x_hi, y_hi),
    // rust: find(x_lo, y_hi),
    // rust: );
    // rust: let (Some(tl), Some(tr), Some(br), Some(bl)) = rect else {
                // Item geometry arrives as triangles: clip each against the
                // rectangle and re-emit the fan, so a triangle straddling the
                // edge keeps its visible part instead of vanishing whole.
    // rust: for tri in [[q[0], q[1], q[2]], [q[3], q[4], q[5]]] {
    // rust: let area = (tri[1].pos[0] - tri[0].pos[0]) * (tri[2].pos[1] - tri[0].pos[1])
    // rust: - (tri[2].pos[0] - tri[0].pos[0]) * (tri[1].pos[1] - tri[0].pos[1]);
    // rust: if area == 0.0 {
    // rust: continue;
}
    // rust: let mut poly = tri.to_vec();
    // rust: for (axis, limit, keep_below) in
    // rust: [(0, x0, false), (0, x1, true), (1, y0, false), (1, y1, true)]
    // rust: {
    // rust: poly = clip_polygon(&poly, axis, limit, keep_below);
}
    // rust: for i in 1..poly.len().saturating_sub(1) {
                        // A triangle as the quad `a, b, c, c`.
    // rust: let (a, b, c) = (poly[0], poly[i], poly[i + 1]);
    // rust: self.vertices.extend_from_slice(&[a, b, c, a, c, c]);
}
}
    // rust: continue;
}
    // rust: let (cx0, cy0) = (x_lo.max(x0), y_lo.max(y0));
    // rust: let (cx1, cy1) = (x_hi.min(x1), y_hi.min(y1));
    // rust: if cx0 >= cx1 || cy0 >= cy1 {
    // rust: continue;
}
    // rust: let t = |p: f32, lo: f32, hi: f32| if hi == lo { 0.0 } else { (p - lo) / (hi - lo) };
    // rust: let uv = |x: f32, y: f32| {
    // rust: let (s, r) = (t(x, x_lo, x_hi), t(y, y_lo, y_hi));
    // rust: std::array::from_fn(|i| {
    // rust: let top = tl.uv[i] + (tr.uv[i] - tl.uv[i]) * s;
    // rust: let bottom = bl.uv[i] + (br.uv[i] - bl.uv[i]) * s;
    // rust: top + (bottom - top) * r
    // rust: })
}
    // rust: self.quad(
    // rust: [[cx0, cy0], [cx1, cy0], [cx1, cy1], [cx0, cy1]],
    // rust: [uv(cx0, cy0), uv(cx1, cy0), uv(cx1, cy1), uv(cx0, cy1)],
    // rust: tl.color,
    // rust: );
    // rust: let end = self.vertices.len();
    // rust: for v in &mut self.vertices[end - 6..] {
    // rust: v.text = tl.text;
}
}
    // rust: moved.push(self.vertices.len() as u32);
    // rust: let at = |v: u32| moved[((v as usize).saturating_sub(start) / 6).min(moved.len() - 1)];
    // rust: for (range, _) in &mut self.blends {
    // rust: if range.start as usize >= start {
    // rust: *range = at(range.start)..at(range.end);
}
}
    // rust: self.blends.retain(|(range, _)| !range.is_empty());
}
    /// `blit` of the top-left `w x h` texels of a `tw x th` texture.
    // rust: pub fn sprite_region(
    // rust: &mut self,
    // rust: atlas: &HudAtlas,
    // rust: name: &str,
    // rust: [x, y, w, h]: [f32; 4],
    // rust: tw: f32,
    // rust: th: f32,
    // rust: ) {
    // rust: if let Some(mut r) = atlas.sprites.get(name).copied() {
    // rust: r.u1 = r.u0 + (r.u1 - r.u0) * w / tw;
    // rust: r.v1 = r.v0 + (r.v1 - r.v0) * h / th;
    // rust: self.rect_uv(x, y, w, h, r, u32::MAX);
}
}
pub fn fill(self: *Self, atlas: *HudAtlas, x: f32, y: f32, w: f32, h: f32, color: u32) void {
}
    // rust: let mut r = atlas.white;
    // rust: let (cu, cv) = ((r.u0 + r.u1) / 2.0, (r.v0 + r.v1) / 2.0);
    // rust: r.u0 = cu;
    // rust: r.u1 = cu;
    // rust: r.v0 = cv;
    // rust: r.v1 = cv;
    // rust: self.rect_uv(x, y, w, h, r, color);
}
    /// Any four-cornered shape in one colour, corners in order round it.
pub fn fill_quad(self: *Self, atlas: *HudAtlas, corners: [[f32; 2]; 4], color: u32) void {
}
    // rust: let w = atlas.white;
    // rust: let uv = [(w.u0 + w.u1) / 2.0, (w.v0 + w.v1) / 2.0];
    // rust: self.quad(corners, [uv; 4], color);
}
    /// GuiGraphics.fillGradient: `top` to `bottom`, down the rectangle.
    // rust: pub fn fill_gradient(
    // rust: &mut self,
    // rust: atlas: &HudAtlas,
    // rust: (x, y, w, h): (f32, f32, f32, f32),
    // rust: top: u32,
    // rust: bottom: u32,
    // rust: ) {
    // rust: let r = atlas.white;
    // rust: let uv = [(r.u0 + r.u1) / 2.0, (r.v0 + r.v1) / 2.0];
    // rust: let p = [[x, y], [x + w, y], [x + w, y + h], [x, y + h]];
    // rust: let c = [top, top, bottom, bottom];
    // rust: for i in [0, 1, 2, 0, 2, 3] {
    // rust: self.vertices.push(HudVertex {
    // rust: pos: p[i],
    // rust: uv,
    // rust: color: c[i],
    // rust: depth: 0.0,
    // rust: glint_uv: [0.0, 0.0],
    // rust: text: 0,
    // rust: });
}
}
pub fn text_width(atlas: *HudAtlas, text: []const u8) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: atlas.font.width(text)
}
    /// Draw plain text (legacy `§` codes are honoured); returns the advance.
    // rust: pub fn text(
    // rust: &mut self,
    // rust: atlas: &HudAtlas,
    // rust: text: &str,
    // rust: x: f32,
    // rust: y: f32,
    // rust: color: u32,
    // rust: shadow: bool,
    // rust: ) -> f32 {
    // rust: let t = if text.contains('§') {
    // rust: crate::text::Text::legacy(text)
    // rust: } else {
    // rust: crate::text::Text::literal(text)
}
    // rust: self.text_styled(atlas, &t, x, y, color, shadow)
}
    /// Font.drawInternal: styled glyphs, shadows first, with bold, italic,
    /// underline and strikethrough. `color` is the default colour and alpha.
    // rust: pub fn text_styled(
    // rust: &mut self,
    // rust: atlas: &HudAtlas,
    // rust: text: &crate::text::Text,
    // rust: x: f32,
    // rust: y: f32,
    // rust: color: u32,
    // rust: shadow: bool,
    // rust: ) -> f32 {
    // rust: self.styled_text(atlas, text, x, y, color, shadow, false, None)
}
    /// `text_styled` for text drawn in the world (`TextRenderable.render`
    /// with `flat` false): each quad's `depth` is its z in text units, the
    /// glyphs `Font.SHADOW_DEPTH` in front of their shadow, a bold copy 0.001
    /// in front of its glyph and the lines 0.01 (`BakedSheetGlyph`), so they
    /// do not fight over the same pixels.
    // rust: pub fn text_styled_world(
    // rust: &mut self,
    // rust: atlas: &HudAtlas,
    // rust: text: &crate::text::Text,
    // rust: x: f32,
    // rust: y: f32,
    // rust: color: u32,
    // rust: shadow: bool,
    // rust: ) -> f32 {
    // rust: self.styled_text(atlas, text, x, y, color, shadow, true, None)
}
    /// `Font.drawInBatch8xOutline`: eight glyph offsets in the outline color,
    /// then the original text. Returns (advance, first front-text vertex), so
    /// world rendering can use POLYGON_OFFSET for the front and NORMAL for
    /// its outline. Offsets use each glyph's own shadow offset (unihex: 0.5).
    // rust: pub fn text_styled_outline_world(
    // rust: &mut self,
    // rust: atlas: &HudAtlas,
    // rust: text: &crate::text::Text,
    // rust: x: f32,
    // rust: y: f32,
    // rust: color: u32,
    // rust: outline: u32,
    // rust: ) -> (f32, usize) {
    // rust: for dx in -1..=1 {
    // rust: for dy in -1..=1 {
    // rust: if dx != 0 || dy != 0 {
    // rust: self.styled_text(
    // rust: atlas,
    // rust: text,
    // rust: x,
    // rust: y,
    // rust: color,
    // rust: false,
    // rust: true,
    // rust: Some((outline, [dx as f32, dy as f32])),
    // rust: );
}
}
}
    // rust: let front = self.vertices.len();
    // rust: (
    // rust: self.styled_text(atlas, text, x, y, color, false, true, None),
    // rust: front,
    // rust: )
}
    // rust: fn styled_text(
    // rust: &mut self,
    // rust: atlas: &HudAtlas,
    // rust: text: &crate::text::Text,
    // rust: x: f32,
    // rust: y: f32,
    // rust: color: u32,
    // rust: shadow: bool,
    // rust: world: bool,
    // rust: outline: Option<(u32, [f32; 2])>,
    // rust: ) -> f32 {
        // StringDecomposer.iterateFormatted inside Font.drawInternal:
        // `§` codes inside a span restyle what follows and are not drawn.
    // rust: let text = text.resolved();
        // Language.getVisualOrder: shaped and reordered for right-to-left text.
    // rust: let text = crate::bidi::visual(&text);
    // rust: let font = &atlas.font;
    // rust: let alpha = (color >> 24) as u8;
    // rust: let mut glyphs = Vec::new();
    // rust: let mut cursor = x;
    // rust: let mut previous = None;
    // rust: for (i, (ch, style)) in text.chars().enumerate() {
    // rust: let object = (ch == '\u{fffc}')
    // rust: .then_some(style.inline_object.as_ref())
    // rust: .flatten();
    // rust: if let Some(crate::text::InlineObject::Player { profile, .. }) = object
    // rust: && self.inline_profiles.len() < 256
    // rust: && !self.inline_profiles.contains(profile)
    // rust: {
    // rust: self.inline_profiles.push(profile.clone());
}
            // Font.PreparedTextBuilder.accept: lines start 1 left of a
            // sequence's first character. Language.getVisualOrder makes a
            // sequence of each run of one style, which world text has.
    // rust: let first = i == 0 || world && previous != Some(style);
    // rust: previous = Some(style);
            // The style's font (`Style.getFont`), the default one unless set.
    // rust: let mut g = if object.is_some() {
    // rust: crate::font::Glyph {
    // rust: rect: None,
    // rust: left: 0.0,
    // rust: top: 0.0,
    // rust: right: 0.0,
    // rust: bottom: 8.0,
    // rust: advance: 8.0,
    // rust: offset: 1.0,
}
    // rust: } else {
    // rust: font.glyph_styled(ch, style)
}
            // Font.StringRenderOutput.accept: obfuscated characters draw a
            // random glyph of the same width each frame.
    // rust: if object.is_none() && style.obfuscated == Some(true) && ch != ' ' {
    // rust: g = font.random_glyph(style, g.advance);
}
    // rust: let c = style.color.map_or(color, |rgb| {
    // rust: rgba((rgb >> 16) as u8, (rgb >> 8) as u8, rgb as u8, alpha)
    // rust: });
    // rust: let bold = object.is_none() && style.is_bold();
    // rust: let advance = g.advance + if bold { g.offset } else { 0.0 };
    // rust: glyphs.push((
    // rust: cursor,
    // rust: g,
    // rust: c,
    // rust: style.shadow_color,
    // rust: bold,
    // rust: style.is_italic(),
    // rust: style.underlined == Some(true),
    // rust: style.strikethrough == Some(true),
    // rust: first,
    // rust: advance,
    // rust: object.cloned(),
    // rust: ));
    // rust: cursor += advance;
}
    // rust: self.patches.extend(font.take_patches());
    // rust: let white = font.white();
    // rust: let has_shadow = outline.is_none()
    // rust: && (shadow
    // rust: || glyphs
    // rust: .iter()
    // rust: .any(|glyph| glyph.3.is_some_and(|color| color != 0)));
    // rust: let passes: &[bool] = if has_shadow { &[true, false] } else { &[false] };
        // ARGB.scaleRGB(color, 0.25): the default shadow colour.
    // rust: let shade = |c: u32| {
    // rust: let b = c.to_le_bytes();
    // rust: rgba(
    // rust: (f32::from(b[0]) * 0.25) as u8,
    // rust: (f32::from(b[1]) * 0.25) as u8,
    // rust: (f32::from(b[2]) * 0.25) as u8,
    // rust: b[3],
    // rust: )
}
    // rust: for &is_shadow in passes {
    // rust: for (
    // rust: gx,
    // rust: g,
    // rust: c,
    // rust: custom_shadow,
    // rust: bold,
    // rust: italic,
    // rust: underline,
    // rust: strike,
    // rust: first,
    // rust: advance,
    // rust: object,
    // rust: ) in &glyphs
    // rust: {
    // rust: let shadow_color = if let Some(argb) = custom_shadow {
    // rust: let text_alpha = (c >> 24) as u8 as u16;
    // rust: let shadow_alpha = (argb >> 24) as u8 as u16;
    // rust: let alpha = (shadow_alpha * text_alpha / 255) as u8;
    // rust: rgba((argb >> 16) as u8, (argb >> 8) as u8, *argb as u8, alpha)
    // rust: } else {
    // rust: shade(*c)
}
    // rust: let has_shadow = outline.is_none()
    // rust: && (custom_shadow.is_some_and(|argb| argb != 0)
    // rust: || custom_shadow.is_none() && shadow)
    // rust: && !(world && shadow_color == 0);
    // rust: if is_shadow && !has_shadow {
    // rust: continue;
}
    // rust: let (dx, col) = if is_shadow {
    // rust: (g.offset, shadow_color)
    // rust: } else {
    // rust: (0.0, *c)
}
    // rust: let (px, py, col) = if let Some((color, [dx, dy])) = outline {
    // rust: (*gx + dx * g.offset, y + dy * g.offset, color)
    // rust: } else {
    // rust: (*gx + dx, y + dx, col)
}
    // rust: if let Some(object) = object {
                    // `PlainTextRenderable.render`: sprite glyphs use the same
                    // shadow colour and offset as text, with the front at SHADOW_DEPTH.
    // rust: let start = self.vertices.len();
    // rust: self.draw_inline_object(atlas, object, px, py - 1.0, col);
    // rust: if world && has_shadow && !is_shadow {
    // rust: for v in &mut self.vertices[start..] {
    // rust: v.depth = 0.03;
}
}
    // rust: continue;
}
    // rust: let shear = |v: f32| if *italic { 1.0 - 0.25 * v } else { 0.0 };
    // rust: let thick = if *bold { 0.1 } else { 0.0 };
    // rust: let draw = |batch: &mut Self, ox: f32| match g.rect {
    // rust: Some(r) => {
    // rust: let (x0, x1, y0, y1) = (
    // rust: px + ox + g.left,
    // rust: px + ox + g.right,
    // rust: py + g.top,
    // rust: py + g.bottom,
    // rust: );
    // rust: batch.quad(
    // rust: [
    // rust: [x0 + shear(g.top) - thick, y0 - thick],
    // rust: [x1 + shear(g.top) + thick, y0 - thick],
    // rust: [x1 + shear(g.bottom) + thick, y1 + thick],
    // rust: [x0 + shear(g.bottom) - thick, y1 + thick],
    // rust: ],
    // rust: [[r.u0, r.v0], [r.u1, r.v0], [r.u1, r.v1], [r.u0, r.v1]],
    // rust: col,
    // rust: );
}
    // rust: None if g.right > 0.0 => {
                        // SpecialGlyphs.MISSING: a 5x8 outline.
    // rust: let (bx, by) = (px + ox, py);
    // rust: for (fx, fy, fw, fh) in [
    // rust: (0.0, 0.0, 5.0, 1.0),
    // rust: (0.0, 7.0, 5.0, 1.0),
    // rust: (0.0, 1.0, 1.0, 6.0),
    // rust: (4.0, 1.0, 1.0, 6.0),
    // rust: ] {
    // rust: batch.rect_uv(bx + fx, by + fy, fw, fh, white, col);
}
}
    // rust: None => {}
}
    // rust: let base = if has_shadow && !is_shadow { 0.03 } else { 0.0 };
    // rust: let lift = |batch: &mut Self, start: usize, z: f32| {
    // rust: if world {
    // rust: for v in &mut batch.vertices[start..] {
    // rust: v.depth = z;
}
}
}
    // rust: let glyph = self.vertices.len();
    // rust: let start = self.vertices.len();
    // rust: draw(self, 0.0);
    // rust: lift(self, start, base);
    // rust: if *bold {
    // rust: let start = self.vertices.len();
    // rust: draw(self, g.offset);
    // rust: lift(self, start, base + 0.001);
}
    // rust: let x0 = if *first { px - 1.0 } else { px };
    // rust: let start = self.vertices.len();
    // rust: if *strike {
    // rust: self.rect_uv(x0, py + 3.5, px + *advance - x0, 1.0, white, col);
}
    // rust: if *underline {
    // rust: self.rect_uv(x0, py + 8.0, px + *advance - x0, 1.0, white, col);
}
    // rust: lift(self, start, base + 0.01);
    // rust: if !world {
    // rust: for v in &mut self.vertices[glyph..] {
    // rust: v.text = 1;
}
}
}
}
    // rust: cursor - x
}

    // rust: fn draw_inline_object(
    // rust: &mut self,
    // rust: atlas: &HudAtlas,
    // rust: object: &crate::text::InlineObject,
    // rust: x: f32,
    // rust: y: f32,
    // rust: tint: u32,
    // rust: ) {
//         use crate::text::InlineObject;
    // rust: match object {
    // rust: InlineObject::Player { profile, hat, .. } => {
    // rust: let id = crate::skins::parse_profile(profile).id;
    // rust: let name = inline_profile_name(profile);
    // rust: let by_id = atlas.object_skins.get(&format!("id:{id:032x}"));
    // rust: let by_name = name.and_then(|name| {
    // rust: atlas
    // rust: .object_skins
    // rust: .get(&format!("name:{}", name.to_ascii_lowercase()))
    // rust: });
    // rust: let resolved = if profile.get("id").is_some() {
    // rust: by_id.or(by_name)
    // rust: } else {
    // rust: by_name.or(by_id)
}
    // rust: let default = crate::tab_list::default_skin(id);
    // rust: let skin = resolved
    // rust: .filter(|path| atlas.sprites.contains_key(*path))
    // rust: .map_or(default, String::as_str);
    // rust: let Some(rect) = atlas.sprites.get(skin).copied() else {
    // rust: return;
}
    // rust: for u in [8.0, 40.0].into_iter().take(if *hat { 2 } else { 1 }) {
    // rust: let du = (rect.u1 - rect.u0) / 64.0;
    // rust: let dv = (rect.v1 - rect.v0) / 64.0;
    // rust: self.rect_uv(
    // rust: x,
    // rust: y,
    // rust: 8.0,
    // rust: 8.0,
    // rust: Rect {
    // rust: u0: rect.u0 + du * u,
    // rust: v0: rect.v0 + dv * 8.0,
    // rust: u1: rect.u0 + du * (u + 8.0),
    // rust: v1: rect.v0 + dv * 16.0,
    // rust: w: 8,
    // rust: h: 8,
    // rust: },
    // rust: tint,
    // rust: );
}
}
    // rust: InlineObject::Atlas { sprite, .. } => {
    // rust: let key = sprite.strip_prefix("minecraft:").unwrap_or(sprite);
    // rust: if let Some(rect) = atlas.sprites.get(key).copied() {
    // rust: self.rect_uv(x, y, 8.0, 8.0, rect, tint);
}
}
}
}

    /// SubmitNodeCollection.submitNameTag's text in its own space (x right,
    /// y down, in GUI pixels): centred at `-Font.width / 2`, drawn as
    /// Font.prepareText draws any text (styles, fonts and glyph boxes; no
    /// shadow), over `background` (RGBA) unless its alpha is 0. Returns how
    /// many vertices at the start of the batch are the background.
    // rust: pub fn name_tag(
    // rust: &mut self,
    // rust: atlas: &HudAtlas,
    // rust: text: &crate::text::Text,
    // rust: y: f32,
    // rust: color: u32,
    // rust: background: u32,
    // rust: ) -> usize {
    // rust: let x = -atlas.font.width_text(text) / 2.0;
    // rust: let start = self.vertices.len();
    // rust: let advance = self.text_styled(atlas, text, x, y, color, false);
    // rust: if background >> 24 == 0 {
    // rust: return 0;
}
        // PreparedTextBuilder.markBackground: one pixel round the advances,
        // from a pixel above the line to 9 below its top.
    // rust: let glyphs = self.vertices.split_off(start);
    // rust: self.fill(atlas, x - 1.0, y - 1.0, advance + 1.0, 10.0, background);
    // rust: let behind = self.vertices.len() - start;
    // rust: self.vertices.extend(glyphs);
    // rust: behind
}
}

pub fn inline_profile_name(profile: *serde_json::Value) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: profile
    // rust: .as_str()
    // rust: .or_else(|| profile.get("name").and_then(serde_json::Value::as_str))
}

pub const HudUniform = struct {
    size: [f32,
    /// `EndPortalFill`: the two sprites, then the game time in x.
    end_portal: [[f32,
};
    // rust: impl HudUniform {
pub fn new(size: [f32; 4], fill: EndPortalFill, glint_colour: u32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [r, g, b, _] = glint_colour.to_le_bytes().map(|c| f32::from(c) / 255.0);
    // rust: let tint = if glint_colour == 0 {
    // rust: [-1.0, 0.0, 0.0]
    // rust: } else {
    // rust: [r, g, b]
}
    // rust: Self {
    // rust: size,
    // rust: end_portal: [
    // rust: fill.sprites[0],
    // rust: fill.sprites[1],
    // rust: [fill.game_time, tint[0], tint[1], tint[2]],
    // rust: ],
}
}
}
pub const HudRenderer = struct {
    sprite_animations: Vec<(Rect,
    /// The shared atlas texture, for run-time glyph uploads.
    atlas_texture: ?wgpu::Texture,
    pipeline: wgpu::RenderPipeline,
    /// `RenderPipelines.CROSSHAIR`.
    invert_pipeline: wgpu::RenderPipeline,
    additive_pipeline: wgpu::RenderPipeline,
    depth_pipeline: wgpu::RenderPipeline,
    vignette_pipeline: wgpu::RenderPipeline,
    end_portal_pipeline: wgpu::RenderPipeline,
    /// The layout of `group`, which the CIT glint pipelines share.
    layout: wgpu::BindGroupLayout,
    group: wgpu::BindGroup,
    /// The pack's CIT enchantment glints, when it has any.
    cit_glint: ?cit_glint::CitGlintPass,
    uniform: wgpu::Buffer,
    buffer: wgpu::Buffer,
    capacity: u64,
    format: wgpu::TextureFormat,
    atlas_view: wgpu::TextureView,
    /// The resource pack's text shader, when it has one that works.
    pack_text: ?pack_text::PackText,
    /// Target pixels per window pixel: above 1 for a screenshot drawn larger than the
    /// window (`Renderer::screenshot_quality`).
    zoom: f32,
};
    // rust: impl HudRenderer {
    // rust: pub fn new(
    // rust: device: &wgpu::Device,
    // rust: format: wgpu::TextureFormat,
    // rust: view: &wgpu::TextureView,
    // rust: glint_view: &wgpu::TextureView,
    // rust: glint_sampler: &wgpu::Sampler,
    // rust: ) -> Result<Self> {
    // rust: let shader = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some("Horizon HUD"),
    // rust: source: wgpu::ShaderSource::Wgsl(include_str!("hud.wgsl").into()),
    // rust: });

    // rust: let sampler = device.create_sampler(&wgpu::SamplerDescriptor {
    // rust: label: Some("HUD"),
    // rust: ..Default::default()
    // rust: });
    // rust: let linear_sampler = device.create_sampler(&wgpu::SamplerDescriptor {
    // rust: label: Some("HUD linear"),
    // rust: mag_filter: wgpu::FilterMode::Linear,
    // rust: min_filter: wgpu::FilterMode::Linear,
    // rust: ..Default::default()
    // rust: });
    // rust: let uniform = device.create_buffer_init(&wgpu::util::BufferInitDescriptor {
    // rust: label: Some("HUD size"),
    // rust: contents: bytemuck::bytes_of(&HudUniform::new([1.0; 4], EndPortalFill::default(), 0)),
    // rust: usage: wgpu::BufferUsages::UNIFORM | wgpu::BufferUsages::COPY_DST,
    // rust: });
    // rust: let layout = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some("HUD bindings"),
    // rust: entries: &[
    // rust: wgpu::BindGroupLayoutEntry {
    // rust: binding: 0,
    // rust: visibility: wgpu::ShaderStages::VERTEX_FRAGMENT,
    // rust: ty: wgpu::BindingType::Buffer {
    // rust: ty: wgpu::BufferBindingType::Uniform,
    // rust: has_dynamic_offset: false,
    // rust: min_binding_size: None,
    // rust: },
    // rust: count: None,
    // rust: },
    // rust: wgpu::BindGroupLayoutEntry {
    // rust: binding: 1,
    // rust: visibility: wgpu::ShaderStages::FRAGMENT,
    // rust: ty: wgpu::BindingType::Texture {
    // rust: sample_type: wgpu::TextureSampleType::Float { filterable: true },
    // rust: view_dimension: wgpu::TextureViewDimension::D2,
    // rust: multisampled: false,
    // rust: },
    // rust: count: None,
    // rust: },
    // rust: wgpu::BindGroupLayoutEntry {
    // rust: binding: 2,
    // rust: visibility: wgpu::ShaderStages::FRAGMENT,
    // rust: ty: wgpu::BindingType::Sampler(wgpu::SamplerBindingType::Filtering),
    // rust: count: None,
    // rust: },
    // rust: wgpu::BindGroupLayoutEntry {
    // rust: binding: 3,
    // rust: visibility: wgpu::ShaderStages::FRAGMENT,
    // rust: ty: wgpu::BindingType::Texture {
    // rust: sample_type: wgpu::TextureSampleType::Float { filterable: true },
    // rust: view_dimension: wgpu::TextureViewDimension::D2,
    // rust: multisampled: false,
    // rust: },
    // rust: count: None,
    // rust: },
    // rust: wgpu::BindGroupLayoutEntry {
    // rust: binding: 4,
    // rust: visibility: wgpu::ShaderStages::FRAGMENT,
    // rust: ty: wgpu::BindingType::Sampler(wgpu::SamplerBindingType::Filtering),
    // rust: count: None,
    // rust: },
    // rust: wgpu::BindGroupLayoutEntry {
    // rust: binding: 5,
    // rust: visibility: wgpu::ShaderStages::FRAGMENT,
    // rust: ty: wgpu::BindingType::Sampler(wgpu::SamplerBindingType::Filtering),
    // rust: count: None,
    // rust: },
    // rust: ],
    // rust: });
    // rust: let group = device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("HUD resources"),
    // rust: layout: &layout,
    // rust: entries: &[
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: uniform.as_entire_binding(),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 1,
    // rust: resource: wgpu::BindingResource::TextureView(view),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 2,
    // rust: resource: wgpu::BindingResource::Sampler(&sampler),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 3,
    // rust: resource: wgpu::BindingResource::TextureView(glint_view),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 4,
    // rust: resource: wgpu::BindingResource::Sampler(glint_sampler),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 5,
    // rust: resource: wgpu::BindingResource::Sampler(&linear_sampler),
    // rust: },
    // rust: ],
    // rust: });
    // rust: let pipeline_layout = device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: Some("HUD layout"),
    // rust: bind_group_layouts: &[Some(&layout)],
    // rust: ..Default::default()
    // rust: });
    // rust: let attributes =
    // rust: wgpu::vertex_attr_array![0=>Float32x2,1=>Float32x2,2=>Unorm8x4,3=>Float32,4=>Float32x2];
    // rust: let create = |label, blend, fragment_entry, depth: bool| {
    // rust: device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some(label),
    // rust: layout: Some(&pipeline_layout),
    // rust: vertex: wgpu::VertexState {
    // rust: module: &shader,
    // rust: entry_point: Some("vs_main"),
    // rust: compilation_options: Default::default(),
    // rust: buffers: &[Some(wgpu::VertexBufferLayout {
    // rust: array_stride: std::mem::size_of::<HudVertex>() as u64,
    // rust: step_mode: wgpu::VertexStepMode::Vertex,
    // rust: attributes: &attributes,
    // rust: })],
    // rust: },
    // rust: primitive: Default::default(),
    // rust: depth_stencil: depth.then_some(wgpu::DepthStencilState {
    // rust: format: wgpu::TextureFormat::Depth32Float,
    // rust: depth_write_enabled: Some(true),
    // rust: depth_compare: Some(wgpu::CompareFunction::LessEqual),
    // rust: stencil: Default::default(),
    // rust: bias: Default::default(),
    // rust: }),
    // rust: multisample: Default::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: &shader,
    // rust: entry_point: Some(fragment_entry),
    // rust: compilation_options: Default::default(),
    // rust: targets: &[Some(wgpu::ColorTargetState {
    // rust: format,
    // rust: blend: Some(blend),
    // rust: write_mask: wgpu::ColorWrites::ALL,
    // rust: })],
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: })
}
    // rust: let pipeline = create("HUD", wgpu::BlendState::ALPHA_BLENDING, "fs_main", false);
    // rust: let depth_pipeline = create(
    // rust: "HUD model",
    // rust: wgpu::BlendState::ALPHA_BLENDING,
    // rust: "fs_main",
    // rust: true,
    // rust: );
        // BlendFunction.INVERT: ONE_MINUS_DST_COLOR, ONE_MINUS_SRC_COLOR,
        // ONE, ZERO.
    // rust: let invert_pipeline = create(
    // rust: "HUD crosshair",
    // rust: wgpu::BlendState {
    // rust: color: wgpu::BlendComponent {
    // rust: src_factor: wgpu::BlendFactor::OneMinusDst,
    // rust: dst_factor: wgpu::BlendFactor::OneMinusSrc,
    // rust: operation: wgpu::BlendOperation::Add,
    // rust: },
    // rust: alpha: wgpu::BlendComponent {
    // rust: src_factor: wgpu::BlendFactor::One,
    // rust: dst_factor: wgpu::BlendFactor::Zero,
    // rust: operation: wgpu::BlendOperation::Add,
    // rust: },
    // rust: },
    // rust: "fs_crosshair",
    // rust: false,
    // rust: );
        // BlendFunction.ADDITIVE: ONE, ONE.
    // rust: let add = wgpu::BlendComponent {
    // rust: src_factor: wgpu::BlendFactor::One,
    // rust: dst_factor: wgpu::BlendFactor::One,
    // rust: operation: wgpu::BlendOperation::Add,
}
    // rust: let additive_pipeline = create(
    // rust: "HUD text highlight",
    // rust: wgpu::BlendState {
    // rust: color: add,
    // rust: alpha: add,
    // rust: },
    // rust: "fs_main",
    // rust: false,
    // rust: );
        // RenderPipelines.VIGNETTE: ZERO, ONE_MINUS_SRC_COLOR, ZERO, ONE.
    // rust: let vignette_pipeline = create(
    // rust: "HUD vignette",
    // rust: wgpu::BlendState {
    // rust: color: wgpu::BlendComponent {
    // rust: src_factor: wgpu::BlendFactor::Zero,
    // rust: dst_factor: wgpu::BlendFactor::OneMinusSrc,
    // rust: operation: wgpu::BlendOperation::Add,
    // rust: },
    // rust: alpha: wgpu::BlendComponent {
    // rust: src_factor: wgpu::BlendFactor::Zero,
    // rust: dst_factor: wgpu::BlendFactor::One,
    // rust: operation: wgpu::BlendOperation::Add,
    // rust: },
    // rust: },
    // rust: "fs_vignette",
    // rust: false,
    // rust: );
        // RenderPipelines.END_PORTAL: opaque.
    // rust: let end_portal_pipeline = create(
    // rust: "HUD end portal",
    // rust: wgpu::BlendState::REPLACE,
    // rust: "fs_end_portal",
    // rust: false,
    // rust: );
    // rust: let capacity = 1 << 16;
    // rust: let buffer = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("HUD vertices"),
    // rust: size: capacity * std::mem::size_of::<HudVertex>() as u64,
    // rust: usage: wgpu::BufferUsages::VERTEX | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: Ok(Self {
    // rust: atlas_texture: None,
    // rust: sprite_animations: Vec::new(),
    // rust: pipeline,
    // rust: invert_pipeline,
    // rust: additive_pipeline,
    // rust: depth_pipeline,
    // rust: vignette_pipeline,
    // rust: end_portal_pipeline,
    // rust: layout,
    // rust: group,
    // rust: cit_glint: None,
    // rust: uniform,
    // rust: buffer,
    // rust: capacity,
    // rust: format,
    // rust: atlas_view: view.clone(),
    // rust: pack_text: None,
    // rust: zoom: 1.0,
    // rust: })
}
    /// Draw the CIT glint layers of `textures` (the pack's enchantment rules); `None` or no
    /// textures draws none.
    // rust: pub fn set_cit_glints(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: textures: Option<&cit_glint::GlintTextures>,
    // rust: ) {
    // rust: self.cit_glint = textures.and_then(|t| {
    // rust: cit_glint::CitGlintPass::new(device, queue, self.format, &self.layout, t)
    // rust: });
}
    /// Draw the GUI's text with `shader` (`HudAtlas::text_shader`), or natively.
    // rust: pub fn set_text_shader(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: shader: Option<&horizon_shaders::CoreProgram>,
    // rust: ) {
    // rust: self.pack_text = shader.and_then(|shader| {
    // rust: pack_text::PackText::new(device, self.format, &self.atlas_view, shader)
    // rust: });
}
    // rust: pub fn animate_sprites(
    // rust: &mut self,
    // rust: uploads: &mut crate::gfx::upload::Uploads,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: tick: u64,
    // rust: ) {
    // rust: let Some(texture) = &self.atlas_texture else {
    // rust: return;
}
    // rust: for (rect, animation, previous) in &mut self.sprite_animations {
            // `SpriteContents.AnimationState`: the frame from the mcmeta's
            // list, blended into the next one by the sub-frame's thousandths
            // when the sprite interpolates.
    // rust: let blend = animation.blend(tick);
    // rust: let state = (blend.frame, blend.next, blend.millis);
    // rust: if state == *previous {
    // rust: continue;
}
    // rust: let (w, h) = rect.texels((texture.width(), texture.height()));
    // rust: let pixels = if blend.millis == 0 {
    // rust: animation.resized_pixels(blend.frame, w, h)
    // rust: } else {
    // rust: let current = animation.resized_pixels(blend.frame, w, h);
    // rust: let next = animation.resized_pixels(blend.next, w, h);
    // rust: let millis = blend.millis;
    // rust: current
    // rust: .iter()
    // rust: .zip(next)
    // rust: .map(|(&a, b)| {
    // rust: ((u32::from(a) * (1000 - millis) + u32::from(b) * millis + 500) / 1000)
    // rust: as u8
    // rust: })
    // rust: .collect()
}
    // rust: uploads.texture(
    // rust: encoder,
    // rust: wgpu::TexelCopyTextureInfo {
    // rust: texture,
    // rust: mip_level: 0,
    // rust: origin: wgpu::Origin3d {
    // rust: x: (rect.u0 * texture.width() as f32).round() as u32,
    // rust: y: (rect.v0 * texture.height() as f32).round() as u32,
    // rust: z: 0,
    // rust: },
    // rust: aspect: wgpu::TextureAspect::All,
    // rust: },
    // rust: w,
    // rust: h,
    // rust: &pixels,
    // rust: );
    // rust: *previous = state;
}
}
    /// Stage `patches` into the shared atlas texture.
    // rust: pub fn upload_patches(
    // rust: &self,
    // rust: uploads: &mut crate::gfx::upload::Uploads,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: patches: &[crate::font::Patch],
    // rust: ) {
    // rust: if let Some(texture) = &self.atlas_texture {
    // rust: for p in patches {
    // rust: if p.x.saturating_add(p.width) <= texture.width()
    // rust: && p.y.saturating_add(p.height) <= texture.height()
    // rust: {
    // rust: uploads.texture(
    // rust: encoder,
    // rust: wgpu::TexelCopyTextureInfo {
    // rust: texture,
    // rust: mip_level: 0,
    // rust: origin: wgpu::Origin3d {
    // rust: x: p.x,
    // rust: y: p.y,
    // rust: z: 0,
    // rust: },
    // rust: aspect: wgpu::TextureAspect::All,
    // rust: },
    // rust: p.width,
    // rust: p.height,
    // rust: &p.rgba,
    // rust: );
}
}
}
}
    /// Stage the batch's atlas patches, vertices and uniform: before the
    /// frame's first pass, so the copies share one command buffer.
    // rust: pub fn prepare(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: uploads: &mut crate::gfx::upload::Uploads,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: batch: &HudBatch,
    // rust: size: [u32; 2],
    // rust: ) {
    // rust: self.upload_patches(uploads, encoder, &batch.patches);
    // rust: if batch.vertices.is_empty() || size.contains(&0) {
    // rust: return;
}
    // rust: let count = batch.vertices.len() as u64;
    // rust: if count > self.capacity {
    // rust: self.capacity = count.next_power_of_two();
    // rust: self.buffer = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("HUD vertices"),
    // rust: size: self.capacity * std::mem::size_of::<HudVertex>() as u64,
    // rust: usage: wgpu::BufferUsages::VERTEX | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
}
    // rust: uploads.buffer(
    // rust: encoder,
    // rust: &self.buffer,
    // rust: 0,
    // rust: bytemuck::cast_slice(&batch.vertices),
    // rust: );
    // rust: uploads.buffer(
    // rust: encoder,
    // rust: &self.uniform,
    // rust: 0,
    // rust: bytemuck::bytes_of(&HudUniform::new(
    // rust: [
    // rust: size[0] as f32,
    // rust: size[1] as f32,
    // rust: batch.scale * self.zoom,
    // rust: batch.glint_alpha,
    // rust: ],
    // rust: batch.end_portal,
    // rust: batch.glint_colour,
    // rust: )),
    // rust: );
    // rust: if let Some(pack_text) = &self.pack_text {
    // rust: pack_text.prepare(uploads, encoder, batch, size, batch.scale * self.zoom);
}
}
    /// Draw the batch `prepare` staged.
    // rust: pub fn draw(
    // rust: &self,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: target: &wgpu::TextureView,
    // rust: depth: &wgpu::TextureView,
    // rust: batch: &HudBatch,
    // rust: size: [u32; 2],
    // rust: ) {
    // rust: self.draw_range(
    // rust: encoder,
    // rust: target,
    // rust: depth,
    // rust: batch,
    // rust: size,
    // rust: 0..batch.vertices.len() as u32,
    // rust: None,
    // rust: );
}
    /// Draw part of the prepared batch, preserving its blend/depth runs.
    // rust: pub fn draw_range(
    // rust: &self,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: target: &wgpu::TextureView,
    // rust: depth: &wgpu::TextureView,
    // rust: batch: &HudBatch,
    // rust: size: [u32; 2],
    // rust: vertices: std::ops::Range<u32>,
    // rust: mut timing: Option<&mut crate::gfx::pack_timing::PassTiming>,
    // rust: ) {
    // rust: if vertices.is_empty() || size.contains(&0) {
    // rust: return;
}
    // rust: let attachments = [Some(wgpu::RenderPassColorAttachment {
    // rust: view: target,
    // rust: resolve_target: None,
    // rust: depth_slice: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Load,
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })];
    // rust: let runs = batch.runs_in(vertices);
    // rust: let mut at = 0;
    // rust: while at < runs.len() {
    // rust: let clip = match runs[at].1 {
    // rust: Blend::Depth(clip) => Some(clip),
    // rust: _ => None,
}
    // rust: let end = if clip.is_some() {
    // rust: at + 1
    // rust: } else {
    // rust: runs[at..]
    // rust: .iter()
    // rust: .position(|(_, b)| matches!(b, Blend::Depth(_)))
    // rust: .map_or(runs.len(), |n| at + n)
}
    // rust: let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some("HUD"),
    // rust: timestamp_writes: timing.as_deref_mut().and_then(|t| t.writes("HUD")),
    // rust: color_attachments: &attachments,
    // rust: depth_stencil_attachment: clip.map(|_| wgpu::RenderPassDepthStencilAttachment {
    // rust: view: depth,
    // rust: depth_ops: Some(wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(1.0),
    // rust: store: wgpu::StoreOp::Discard,
    // rust: }),
    // rust: stencil_ops: None,
    // rust: }),
    // rust: ..Default::default()
    // rust: });
    // rust: pass.set_bind_group(0, &self.group, &[]);
    // rust: pass.set_vertex_buffer(0, self.buffer.slice(..));
    // rust: if let Some(clip) = clip {
    // rust: let [x, y, w, h] = clip.map(|v| (v as f32 * self.zoom) as u32);
    // rust: let (x, y) = (x.min(size[0]), y.min(size[1]));
    // rust: let (w, h) = (w.min(size[0] - x), h.min(size[1] - y));
    // rust: if w == 0 || h == 0 {
    // rust: at = end;
    // rust: continue;
}
    // rust: pass.set_scissor_rect(x, y, w, h);
}
    // rust: for (range, blend) in &runs[at..end] {
    // rust: let pipeline = match blend {
    // rust: Blend::Alpha => &self.pipeline,
    // rust: Blend::Invert => &self.invert_pipeline,
    // rust: Blend::Additive => &self.additive_pipeline,
    // rust: Blend::Depth(_) => &self.depth_pipeline,
    // rust: Blend::Vignette => &self.vignette_pipeline,
    // rust: Blend::EndPortal => &self.end_portal_pipeline,
    // rust: Blend::CitGlint(blend) => {
    // rust: if let Some(cit) = &self.cit_glint {
    // rust: cit.draw(&mut pass, *blend, range.clone());
}
    // rust: continue;
}
}
    // rust: match &self.pack_text {
    // rust: Some(pack_text) if *blend == Blend::Alpha => {
    // rust: for (part, text) in pack_text::text_runs(&batch.vertices, range.clone()) {
    // rust: if text {
    // rust: pack_text.draw(&mut pass, part);
    // rust: pass.set_bind_group(0, &self.group, &[]);
    // rust: } else {
    // rust: pass.set_pipeline(pipeline);
    // rust: pass.draw(part, 0..1);
}
}
}
    // rust: _ => {
    // rust: pass.set_pipeline(pipeline);
    // rust: pass.draw(range.clone(), 0..1);
}
}
}
    // rust: at = end;
}
}
}

    // rust: mod tests {
//     use super::*;

    /// The mod image slot is paid only by a game with a native mod loaded.
pub fn the_mod_image_slot_exists_only_when_a_mod_is_loaded() void {
}
    // rust: let root = Path::new("/nonexistent/horizon-test-assets");
    // rust: let plain = HudAtlas::build(root).unwrap();
    // rust: assert!(!plain.sprites.contains_key(MOD_IMAGE_SPRITE));
    // rust: let with_mod = HudAtlas::build_over_with_image(root, root, true).unwrap();
    // rust: assert!(with_mod.sprites.contains_key(MOD_IMAGE_SPRITE));
}

pub fn dumping_the_atlas_writes_its_pixels_and_sprite_rects() void {
}
    // rust: let root = std::env::temp_dir().join("horizon-atlas-dump-test");
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: let pixels: Vec<u8> = (0..4u8).flat_map(|i| [i, 0, 0, 255]).collect();
    // rust: let rect = |u0: f32, v0: f32| Rect {
    // rust: u0,
    // rust: v0,
    // rust: u1: u0 + 0.5,
    // rust: v1: v0 + 0.5,
    // rust: w: 8,
    // rust: h: 8,
}
    // rust: let sprites = HashMap::from([
    // rust: ("particle/smoke".to_string(), rect(0.5, 0.0)),
    // rust: ("gui/sprites/bars/experience".to_string(), rect(0.0, 0.5)),
    // rust: ]);
    // rust: let path = dump_atlas(
    // rust: &root,
    // rust: "minecraft_textures_atlas_gui",
    // rust: 2,
    // rust: 2,
    // rust: &pixels,
    // rust: &sprites,
    // rust: )
    // rust: .expect("the dump writes");
    // rust: assert_eq!(path, root.join("minecraft_textures_atlas_gui.png"));
    // rust: let written = fs::read(&path).expect("the PNG is there");
    // rust: let (width, height, rgba) = decode_bytes(&written).expect("the PNG decodes");
    // rust: assert_eq!((width, height), (2, 2));
    // rust: assert_eq!(rgba, pixels);
        // Sorted by sprite name, rects in texels, as `dumpSpriteNames` writes them.
    // rust: let mut expected = String::from("gui/sprites/bars/experience\tx=0\ty=1\tw=1\th=1\n");
    // rust: expected.push_str("particle/smoke\tx=1\ty=0\tw=1\th=1\n");
    // rust: assert_eq!(
    // rust: fs::read_to_string(root.join("minecraft_textures_atlas_gui.txt")).unwrap(),
    // rust: expected
    // rust: );
        // A build with no texels in hand writes no file at all.
    // rust: let empty = dump_atlas(&root, "empty", 2, 2, &[], &sprites);
    // rust: assert!(empty.is_err());
    // rust: assert!(!root.join("empty.png").exists());
    // rust: let _ = fs::remove_dir_all(&root);
}

pub fn image_formats_are_told_apart_by_their_leading_bytes() void {
}
    // rust: let png = [0x89, b'P', b'N', b'G', 0x0D, 0x0A, 0x1A, 0x0A, 0, 0];
    // rust: assert!(matches!(ImageFormat::sniff(&png), Some(ImageFormat::Png)));
        // RIFF with a WEBP tag at byte 8; RIFF alone is not enough (WAV is
        // RIFF too).
    // rust: let mut webp = b"RIFF    WEBPVP8 ".to_vec();
    // rust: assert!(matches!(ImageFormat::sniff(&webp), Some(ImageFormat::WebP)));
    // rust: webp[8..12].copy_from_slice(b"WAVE");
    // rust: assert!(ImageFormat::sniff(&webp).is_none());
    // rust: assert!(matches!(
    // rust: ImageFormat::sniff(&[0xFF, 0xD8, 0xFF, 0xE0]),
    // rust: Some(ImageFormat::Jpeg)
    // rust: ));
        // Too short to be any of them, and plainly something else.
    // rust: assert!(ImageFormat::sniff(b"RIFF").is_none());
    // rust: assert!(ImageFormat::sniff(b"").is_none());
    // rust: assert!(ImageFormat::sniff(b"<html>").is_none());
}

pub fn a_fetched_image_may_not_claim_more_than_4096_squared() void {
}
    // rust: assert!(check_fetched_size(4096, 4096).is_ok());
    // rust: assert!(check_fetched_size(4097, 4096).is_err());
    // rust: assert!(check_fetched_size(16_383, 16_383).is_err());
}

    /// A fetched PNG is refused by the size its own header claims, before the
    /// reader makes the pixel buffer: a few hundred bytes of payload would
    /// otherwise ask for 64 MiB or much more.
pub fn a_fetched_png_is_refused_by_the_size_its_header_claims() void {
}
    // rust: let mut encoded = Vec::new();
    // rust: {
    // rust: let mut encoder = png::Encoder::new(&mut encoded, 2, 2);
    // rust: encoder.set_color(png::ColorType::Rgba);
    // rust: encoder.set_depth(png::BitDepth::Eight);
    // rust: let mut writer = encoder.write_header().unwrap();
    // rust: writer.write_image_data(&[7; 16]).unwrap();
    // rust: writer.finish().unwrap();
}
    // rust: assert!(matches!(
    // rust: ImageFormat::sniff(&encoded),
    // rust: Some(ImageFormat::Png)
    // rust: ));
    // rust: assert_eq!(
    // rust: decode_image_bytes(&encoded).expect("a small PNG decodes").0,
    // rust: 2
    // rust: );

        // The same image, its IHDR claiming one pixel row past the limit: the
        // CRC is ignored on purpose, so this stands in for a hostile header.
    // rust: let ihdr = encoded.windows(4).position(|w| w == b"IHDR").expect("IHDR");
    // rust: encoded[ihdr + 4..ihdr + 8].copy_from_slice(&4097u32.to_be_bytes());
    // rust: encoded[ihdr + 8..ihdr + 12].copy_from_slice(&4096u32.to_be_bytes());
    // rust: let refused = decode_image_bytes(&encoded).expect_err("the size is refused");
    // rust: assert!(
    // rust: refused.to_string().contains("too large to decode"),
    // rust: "{refused}"
    // rust: );
}

    /// Only the network path reads WebP and JPEG: a resource pack's texture
    /// stays PNG-only, as vanilla's `NativeImage.read` is.
pub fn decode_bytes_stays_png_only() void {
}
    // rust: let jpeg = [0xFF, 0xD8, 0xFF, 0xE0, 0, 0x10];
    // rust: assert!(decode_bytes(&jpeg).is_err());
    // rust: let webp = b"RIFF\x00\x00\x00\x00WEBPVP8 ";
    // rust: assert!(decode_bytes(webp).is_err());
}

pub fn decode_bytes_ignores_crc_checksum_error() void {
}
    // rust: let mut encoded = Vec::new();
    // rust: {
    // rust: let mut encoder = png::Encoder::new(&mut encoded, 2, 2);
    // rust: encoder.set_color(png::ColorType::Rgba);
    // rust: encoder.set_depth(png::BitDepth::Eight);
    // rust: let mut writer = encoder.write_header().unwrap();
    // rust: writer
    // rust: .write_image_data(&[
    // rust: 255, 0, 0, 255, 0, 255, 0, 255, 0, 0, 255, 255, 255, 255, 255, 255,
    // rust: ])
    // rust: .unwrap();
    // rust: writer.finish().unwrap();
}
    // rust: let idat_pos = encoded
    // rust: .windows(4)
    // rust: .position(|w| w == b"IDAT")
    // rust: .expect("IDAT chunk");
    // rust: let len = u32::from_be_bytes([
    // rust: encoded[idat_pos - 4],
    // rust: encoded[idat_pos - 3],
    // rust: encoded[idat_pos - 2],
    // rust: encoded[idat_pos - 1],
    // rust: ]) as usize;
    // rust: let crc_pos = idat_pos + 4 + len;
    // rust: encoded[crc_pos] ^= 0xFF;

    // rust: let (w, h, rgba) = decode_bytes(&encoded).expect("should decode despite bad CRC");
    // rust: assert_eq!(w, 2);
    // rust: assert_eq!(h, 2);
    // rust: assert_eq!(rgba.len(), 16);
}

pub fn decode_bytes_ignores_a_bad_ihdr_checksum() void {
}
    // rust: let mut encoded = Vec::new();
    // rust: {
    // rust: let mut encoder = png::Encoder::new(&mut encoded, 2, 2);
    // rust: encoder.set_color(png::ColorType::Rgba);
    // rust: encoder.set_depth(png::BitDepth::Eight);
    // rust: let mut writer = encoder.write_header().unwrap();
    // rust: writer.write_image_data(&[7; 16]).unwrap();
    // rust: writer.finish().unwrap();
}
        // The IHDR chunk's CRC is the 4 bytes after its 13 data bytes.
    // rust: let ihdr = encoded.windows(4).position(|w| w == b"IHDR").unwrap();
    // rust: encoded[ihdr + 4 + 13] ^= 0xFF;
    // rust: let (w, h, rgba) = decode_bytes(&encoded).expect("a bad IHDR CRC decodes, as stb_image's");
    // rust: assert_eq!((w, h, rgba.len()), (2, 2, 16));
}

pub fn clip_since_keeps_the_visible_part_of_a_straddling_triangle() void {
}
    // rust: let mut batch = HudBatch::new([320, 240]);
    // rust: let start = batch.vertices.len();
        // A right triangle (a quad `a, b, c, c`) whose centre lies outside the rect.
    // rust: batch.quad(
    // rust: [[0.0, 0.0], [16.0, 0.0], [0.0, 16.0], [0.0, 16.0]],
    // rust: [[0.0, 0.0], [1.0, 0.0], [0.0, 1.0], [0.0, 1.0]],
    // rust: u32::MAX,
    // rust: );
    // rust: batch.clip_since(start, 0.0, 0.0, 16.0, 4.0);
    // rust: assert!(!batch.vertices.is_empty());
    // rust: assert!(batch.vertices.iter().all(|v| v.pos[1] <= 4.0));
    // rust: let area: f32 = batch
    // rust: .vertices
    // rust: .as_chunks::<3>()
    // rust: .0
    // rust: .iter()
    // rust: .map(|t| {
    // rust: ((t[1].pos[0] - t[0].pos[0]) * (t[2].pos[1] - t[0].pos[1])
    // rust: - (t[2].pos[0] - t[0].pos[0]) * (t[1].pos[1] - t[0].pos[1]))
    // rust: .abs()
    // rust: / 2.0
    // rust: })
    // rust: .sum();
        // Rows 0..4 of the triangle: 16 * 16 / 2 - 12 * 12 / 2.
    // rust: assert!((area - 56.0).abs() < 1e-3, "{area}");
}

pub fn clip_since_moves_blend_ranges_with_their_vertices() void {
}
    // rust: let mut batch = HudBatch::new([320, 240]);
    // rust: let start = batch.vertices.len();
    // rust: let tri = |batch: &mut HudBatch, y: f32| {
    // rust: batch.quad(
    // rust: [[0.0, y], [8.0, y], [0.0, y + 8.0], [0.0, y + 8.0]],
    // rust: [[0.0; 2]; 4],
    // rust: u32::MAX,
    // rust: );
}
    // rust: tri(&mut batch, 100.0); // outside, dropped
    // rust: let foil = batch.vertices.len();
    // rust: tri(&mut batch, 0.0); // straddles the bottom edge
    // rust: batch.blend_since(foil, Blend::Additive);
    // rust: batch.clip_since(start, 0.0, 0.0, 16.0, 4.0);
    // rust: assert_eq!(
    // rust: batch.blends,
    // rust: [(0..batch.vertices.len() as u32, Blend::Additive)]
    // rust: );
}

    /// Write a PNG `width x height` whose `frames` stacked rows are solid
    /// colours, then its mcmeta beside it.
pub fn write_strip(path: *Path, width: u32, height: u32, frames: *[[u8; 4]], mcmeta: ?[]const u8) void {
}
    // rust: let file = std::io::BufWriter::new(fs::File::create(path).unwrap());
    // rust: let mut encoder = png::Encoder::new(file, width, height);
    // rust: encoder.set_color(png::ColorType::Rgba);
    // rust: encoder.set_depth(png::BitDepth::Eight);
    // rust: let mut writer = encoder.write_header().unwrap();
    // rust: let mut pixels = Vec::with_capacity((width * height * 4) as usize);
    // rust: for frame in frames {
    // rust: let rows = height / frames.len() as u32;
    // rust: pixels.extend((0..width * rows).flat_map(|_| *frame));
}
    // rust: writer.write_image_data(&pixels).unwrap();
    // rust: writer.finish().unwrap();
    // rust: if let Some(mcmeta) = mcmeta {
    // rust: let meta = path.with_extension("png.mcmeta");
    // rust: fs::write(meta, mcmeta).unwrap();
}
}
    /// A resource root holding one animated block texture: a strip of two
    /// 16x16 frames, red then blue, whose mcmeta starts on the blue one.
    /// Each call gets its own folder: tests run side by side, and one adds
    /// a strip of its own that another would otherwise find.
pub fn animated_root() P {
    // Implementation ported from Horizon
    return undefined;
}
pub const NEXT: std::sync::atomic::AtomicU32 = std::sync::atomic::AtomicU32::new(0);
    // rust: let n = NEXT.fetch_add(1, std::sync::atomic::Ordering::Relaxed);
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-atlas-anim-{}-{n}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: let block = root.join("assets/minecraft/textures/block");
    // rust: fs::create_dir_all(&block).unwrap();
    // rust: write_strip(
    // rust: &block.join("test_anim.png"),
    // rust: 16,
    // rust: 32,
    // rust: &[[255, 0, 0, 255], [0, 0, 255, 255]],
    // rust: Some(r#"{"animation": {"frames": [1, 0]}}"#),
    // rust: );
    // rust: root
}
pub fn texel_at(atlas: *HudAtlas, rect: Rect, x: u32, y: u32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let px = (rect.u0 * atlas.width as f32).round() as u32 + x;
    // rust: let py = (rect.v0 * atlas.height as f32).round() as u32 + y;
    // rust: let at = ((py * atlas.width + px) * 4) as usize;
    // rust: atlas.pixels[at..at + 4].try_into().unwrap()
}
pub fn content_mod_entity_textures_pack_under_their_namespace() void {
}
    // rust: let root = std::env::temp_dir().join(format!("horizon-atlas-equip-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: let equipment = root.join("assets/gems/textures/entity/equipment/humanoid");
    // rust: fs::create_dir_all(&equipment).unwrap();
    // rust: write_strip(
    // rust: &equipment.join("ruby.png"),
    // rust: 64,
    // rust: 32,
    // rust: &[[200, 0, 0, 255]],
    // rust: None,
    // rust: );
    // rust: let other = root.join("assets/gems/textures/item");
    // rust: fs::create_dir_all(&other).unwrap();
    // rust: write_strip(&other.join("ruby.png"), 16, 16, &[[0, 200, 0, 255]], None);
    // rust: fs::write(
    // rust: root.join(horizon_items::content_namespaces::MARKER),
    // rust: br#"["gems"]"#,
    // rust: )
    // rust: .unwrap();
        // A block entity's texture, for a native mod's renderer.
    // rust: let machine = root.join("assets/gems/textures/entity/machine");
    // rust: fs::create_dir_all(&machine).unwrap();
    // rust: write_strip(&machine.join("cog.png"), 32, 32, &[[0, 0, 200, 255]], None);
    // rust: let atlas = HudAtlas::build(&root).unwrap();
    // rust: let rect = atlas.sprites["gems:entity/equipment/humanoid/ruby"];
    // rust: assert_eq!(texel_at(&atlas, rect, 0, 0), [200, 0, 0, 255]);
    // rust: let rect = atlas.sprites["gems:entity/machine/cog"];
    // rust: assert_eq!(rect.texels((atlas.width, atlas.height)), (32, 32));
    // rust: assert_eq!(texel_at(&atlas, rect, 0, 0), [0, 0, 200, 255]);
        // Only entity textures: the mods' others reach the atlas through atlas definitions.
    // rust: assert!(!atlas.sprites.contains_key("gems:item/ruby"));
    // rust: fs::remove_dir_all(&root).unwrap();
}
    /// OptiFine random entity variants outside `textures/` pack under the names
    /// `RandomTextures` gives them; one beside its texture packs once, under its own.
pub fn random_entity_variants_pack_under_their_scan_names() void {
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-atlas-random-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: let random = root.join("assets/minecraft/optifine/random/entity/pig");
    // rust: fs::create_dir_all(&random).unwrap();
    // rust: write_strip(&random.join("pig2.png"), 64, 64, &[[0, 200, 0, 255]], None);
    // rust: let beside = root.join("assets/minecraft/textures/entity/cat");
    // rust: fs::create_dir_all(&beside).unwrap();
    // rust: fs::write(beside.join("cat.properties"), "textures.1=2").unwrap();
    // rust: write_strip(&beside.join("cat.png"), 64, 32, &[[1, 1, 1, 255]], None);
    // rust: write_strip(&beside.join("cat2.png"), 64, 32, &[[0, 0, 200, 255]], None);
    // rust: let atlas = HudAtlas::build(&root).unwrap();
    // rust: let rect = atlas.sprites["minecraft:optifine/random/entity/pig/pig2"];
    // rust: assert_eq!(texel_at(&atlas, rect, 0, 0), [0, 200, 0, 255]);
    // rust: let rect = atlas.sprites["entity/cat/cat2"];
    // rust: assert_eq!(texel_at(&atlas, rect, 0, 0), [0, 0, 200, 255]);
    // rust: assert!(atlas.random_textures.get("entity/pig/pig").is_some());
    // rust: fs::remove_dir_all(&root).unwrap();
}
    /// A random variant's emissive overlay packs beside the variant, under its name.
pub fn variant_overlays_pack_under_their_names() void {
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-atlas-overlay-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: let random = root.join("assets/minecraft/optifine/random/entity/zombie");
    // rust: fs::create_dir_all(&random).unwrap();
    // rust: write_strip(
    // rust: &random.join("zombie3.png"),
    // rust: 64,
    // rust: 64,
    // rust: &[[0, 200, 0, 255]],
    // rust: None,
    // rust: );
    // rust: write_strip(
    // rust: &random.join("zombie3_e.png"),
    // rust: 64,
    // rust: 64,
    // rust: &[[200, 0, 0, 255]],
    // rust: None,
    // rust: );
        // A variant's blink frame, with its own overlay.
    // rust: write_strip(
    // rust: &random.join("zombie3_blink.png"),
    // rust: 64,
    // rust: 64,
    // rust: &[[0, 0, 200, 255]],
    // rust: None,
    // rust: );
    // rust: write_strip(
    // rust: &random.join("zombie3_blink_e.png"),
    // rust: 64,
    // rust: 64,
    // rust: &[[9, 9, 9, 255]],
    // rust: None,
    // rust: );
    // rust: let atlas = HudAtlas::build(&root).unwrap();
    // rust: let rect = atlas.sprites["minecraft:optifine/random/entity/zombie/zombie3_blink_e"];
    // rust: assert_eq!(texel_at(&atlas, rect, 0, 0), [9, 9, 9, 255]);
    // rust: let rect = atlas.sprites["minecraft:optifine/random/entity/zombie/zombie3_e"];
    // rust: assert_eq!(texel_at(&atlas, rect, 0, 0), [200, 0, 0, 255]);
    // rust: assert_eq!(
    // rust: atlas
    // rust: .emissive
    // rust: .overlay("minecraft:optifine/random/entity/zombie/zombie3"),
    // rust: Some("minecraft:optifine/random/entity/zombie/zombie3_e")
    // rust: );
    // rust: fs::remove_dir_all(&root).unwrap();
}
    /// Variants past the budget, in name order, stay out of the atlas.
pub fn random_variants_stop_at_their_budget() void {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-atlas-budget-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&dir);
    // rust: fs::create_dir_all(&dir).unwrap();
    // rust: let files: Vec<PathBuf> = ["a2.png", "a3.png", "a4.png"]
    // rust: .iter()
    // rust: .map(|n| dir.join(n))
    // rust: .collect();
    // rust: for f in &files {
    // rust: write_strip(f, 16, 16, &[[1, 2, 3, 255]], None);
}
    // rust: let refs: Vec<&PathBuf> = files.iter().collect();
        // 256 texels each: 600 holds two.
    // rust: let kept = within_budget(&refs, 600);
    // rust: assert_eq!(kept, files[..2].iter().cloned().collect());
    // rust: assert_eq!(within_budget(&refs, 768).len(), 3);
        // a2's overlay sorts before a3 by name, but every variant comes first.
    // rust: let overlay = dir.join("a2_e.png");
    // rust: write_strip(&overlay, 16, 16, &[[1, 2, 3, 255]], None);
    // rust: let overlays: HashSet<PathBuf> = [overlay.clone()].into();
    // rust: let all = [&files[0], &overlay, &files[1]];
    // rust: let kept = budgeted(all.into_iter(), &overlays, 600);
    // rust: assert_eq!(kept, [files[0].clone(), files[1].clone()].into());
    // rust: fs::remove_dir_all(&dir).unwrap();
}
pub fn content_mod_effect_icons_pack_under_their_namespace() void {
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-atlas-effect-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: let icons = root.join("assets/gems/textures/mob_effect");
    // rust: fs::create_dir_all(&icons).unwrap();
    // rust: write_strip(&icons.join("glow.png"), 18, 18, &[[0, 0, 200, 255]], None);
    // rust: fs::write(
    // rust: root.join(horizon_items::content_namespaces::MARKER),
    // rust: br#"["gems"]"#,
    // rust: )
    // rust: .unwrap();
    // rust: let atlas = HudAtlas::build(&root).unwrap();
    // rust: let rect = atlas.sprites[horizon_client_core::potions::sprite("gems:glow").as_str()];
    // rust: assert_eq!(texel_at(&atlas, rect, 0, 0), [0, 0, 200, 255]);
        // The HUD and the inventory draw it from the effect's id, as vanilla's.
    // rust: let effect = crate::effects::EffectInstance::new("gems:glow", 600, 0);
    // rust: let icon = crate::hud_overlays::EffectIcon::from(&effect);
    // rust: let draws = crate::hud_overlays::effects(320, false, &[icon]);
    // rust: let mut batch = HudBatch::new([320, 240]);
    // rust: crate::hud_layout::paint(&mut batch, &atlas, &draws);
    // rust: assert!(batch.vertices.iter().any(|v| v.uv == [rect.u0, rect.v0]));
    // rust: let panels = crate::inventory_effects::panels(
    // rust: 320,
    // rust: [72, 37],
    // rust: 176,
    // rust: &[effect],
    // rust: 20.0,
    // rust: &|_| None,
    // rust: &|_| 60,
    // rust: );
    // rust: batch.vertices.clear();
    // rust: crate::inventory_effects::paint(&mut batch, &atlas, &panels, [0, 0]);
    // rust: assert!(batch.vertices.iter().any(|v| v.uv == [rect.u0, rect.v0]));
        // An effect without an icon draws the missing sprite.
    // rust: let missing = atlas.sprites[MISSING_SPRITE];
    // rust: assert_eq!(texel_at(&atlas, missing, 0, 0), [0, 0, 0, 255]);
    // rust: assert_eq!(texel_at(&atlas, missing, 8, 0), [248, 0, 248, 255]);
    // rust: let effect = crate::effects::EffectInstance::new("gems:none", 600, 0);
    // rust: let draws = crate::hud_overlays::effects(320, false, &[(&effect).into()]);
    // rust: batch.vertices.clear();
    // rust: crate::hud_layout::paint(&mut batch, &atlas, &draws);
    // rust: assert!(
    // rust: batch
    // rust: .vertices
    // rust: .iter()
    // rust: .any(|v| v.uv == [missing.u0, missing.v0])
    // rust: );
    // rust: fs::remove_dir_all(&root).unwrap();
}
pub fn animated_block_sprites_register_and_pack_their_first_mcmeta_frame() void {
}
    // rust: let root = animated_root();
    // rust: let atlas = HudAtlas::build(&root).unwrap();
    // rust: let (rect, animation) = atlas
    // rust: .sprite_animations
    // rust: .iter()
    // rust: .find(|(_, animation)| animation.frame_count() == 2)
    // rust: .expect("the animated block sprite");
        // The mcmeta's list starts on the strip's second (blue) frame.
    // rust: assert_eq!(animation.frame(0), 1);
    // rust: assert_eq!(rect.texels((atlas.width, atlas.height)), (16, 16));
    // rust: assert_eq!(texel_at(&atlas, *rect, 0, 0), [0, 0, 255, 255]);
    // rust: assert_eq!(texel_at(&atlas, *rect, 15, 15), [0, 0, 255, 255]);
}
pub fn packed_pixels_come_back_the_same() void {
}
    // rust: let root = animated_root();
    // rust: let mut atlas = HudAtlas::build(&root).unwrap();
    // rust: let built = atlas.pixels.clone();
    // rust: atlas.pack_pixels();
    // rust: assert!(atlas.pixels.is_empty());
    // rust: assert!(atlas.pixels() == built.as_slice());
        // Packing again keeps the same image.
    // rust: atlas.pack_pixels();
    // rust: assert!(atlas.pixels() == built.as_slice());
}
pub fn a_strip_frames_size_comes_from_its_mcmeta() void {
}
    // rust: let root = animated_root();
    // rust: let block = root.join("assets/minecraft/textures/block");
        // A row of two frames with the animation's own frame size.
    // rust: write_strip(
    // rust: &block.join("test_row.png"),
    // rust: 32,
    // rust: 16,
    // rust: &[[0, 255, 0, 255], [255, 255, 0, 255]],
    // rust: Some(r#"{"animation": {"width": 16, "height": 16}}"#),
    // rust: );
    // rust: let atlas = HudAtlas::build(&root).unwrap();
    // rust: let rect = atlas.sprites["block/test_row"];
        // The first frame is the left 16x16, not the whole row.
    // rust: assert_eq!(rect.texels((atlas.width, atlas.height)), (16, 16));
    // rust: assert_eq!(texel_at(&atlas, rect, 0, 0), [0, 255, 0, 255]);
}
pub fn a_pack_directory_outside_the_walked_folders_still_packs() void {
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-atlas-custom-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: let atlases = root.join("assets/minecraft/atlases");
    // rust: let custom = root.join("assets/minecraft/textures/custom");
    // rust: fs::create_dir_all(&atlases).unwrap();
    // rust: fs::create_dir_all(&custom).unwrap();
    // rust: fs::write(
    // rust: atlases.join("blocks.json"),
    // rust: r#"{"sources":[{"type":"directory","source":"custom","prefix":"custom/"}]}"#,
    // rust: )
    // rust: .unwrap();
    // rust: write_strip(
    // rust: &custom.join("test.png"),
    // rust: 16,
    // rust: 16,
    // rust: &[[40, 180, 80, 255]],
    // rust: None,
    // rust: );
    // rust: let atlas = HudAtlas::build(&root).unwrap();
    // rust: let rect = atlas.sprites["custom/test"];
    // rust: assert_eq!(rect.texels((atlas.width, atlas.height)), (16, 16));
    // rust: assert_eq!(texel_at(&atlas, rect, 0, 0), [40, 180, 80, 255]);
    // rust: let _ = fs::remove_dir_all(&root);
}
pub fn another_namespaces_animated_item_texture_packs_its_first_frame_and_animates() void {
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-atlas-ns-anim-{}", std::process::id()));
    // rust: let atlases = root.join("assets/minecraft/atlases");
    // rust: let item = root.join("assets/lobby/textures/item/npc");
    // rust: fs::create_dir_all(&atlases).unwrap();
    // rust: fs::create_dir_all(&item).unwrap();
    // rust: fs::write(
    // rust: atlases.join("items.json"),
    // rust: r#"{"sources": [{"type": "directory", "source": "item", "prefix": "item/"}]}"#,
    // rust: )
    // rust: .unwrap();
        // A server pack's NPC skin: two 16x16 frames, green then red.
    // rust: write_strip(
    // rust: &item.join("skin.png"),
    // rust: 16,
    // rust: 32,
    // rust: &[[0, 255, 0, 255], [255, 0, 0, 255]],
    // rust: Some(r#"{"animation": {"frametime": 3}}"#),
    // rust: );
    // rust: let atlas = HudAtlas::build(&root).unwrap();
    // rust: let rect = atlas.sprites["lobby:item/npc/skin"];
        // One frame, not the whole strip, which a model's UVs would span.
    // rust: assert_eq!(rect.texels((atlas.width, atlas.height)), (16, 16));
    // rust: assert_eq!(texel_at(&atlas, rect, 0, 15), [0, 255, 0, 255]);
    // rust: let (_, animation) = atlas
    // rust: .sprite_animations
    // rust: .iter()
    // rust: .find(|(r, _)| r.u0 == rect.u0 && r.v0 == rect.v0)
    // rust: .expect("the namespaced sprite animates");
    // rust: assert_eq!(animation.frame_count(), 2);
}
pub fn an_animated_texture_outside_item_folders_packs_its_first_frame_and_animates() void {
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-atlas-dir-anim-{}", std::process::id()));
    // rust: let atlases = root.join("assets/minecraft/atlases");
    // rust: let custom = root.join("assets/minecraft/textures/custom");
    // rust: fs::create_dir_all(&atlases).unwrap();
    // rust: fs::create_dir_all(&custom).unwrap();
    // rust: fs::write(
    // rust: atlases.join("items.json"),
    // rust: r#"{"sources": [{"type": "directory", "source": "custom", "prefix": "custom/"}]}"#,
    // rust: )
    // rust: .unwrap();
        // A server pack's item under its own folder: two 16x16 frames, blue then yellow, and
        // a still 16x32 texture beside it.
    // rust: write_strip(
    // rust: &custom.join("gem.png"),
    // rust: 16,
    // rust: 32,
    // rust: &[[0, 0, 255, 255], [255, 255, 0, 255]],
    // rust: Some(r#"{"animation": {"frametime": 20}}"#),
    // rust: );
    // rust: write_strip(&custom.join("banner.png"), 16, 32, &[[9, 9, 9, 255]], None);
    // rust: let atlas = HudAtlas::build(&root).unwrap();
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: let rect = atlas.sprites["custom/gem"];
        // One frame, not the whole strip squeezed into a slot.
    // rust: assert_eq!(rect.texels((atlas.width, atlas.height)), (16, 16));
    // rust: assert_eq!(texel_at(&atlas, rect, 0, 15), [0, 0, 255, 255]);
    // rust: let (_, animation) = atlas
    // rust: .sprite_animations
    // rust: .iter()
    // rust: .find(|(r, _)| r.u0 == rect.u0 && r.v0 == rect.v0)
    // rust: .expect("the sprite animates");
    // rust: assert_eq!(animation.frame_count(), 2);
        // A still texture there stays whole, as vanilla stitches it.
    // rust: let banner = atlas.sprites["custom/banner"];
    // rust: assert_eq!(banner.texels((atlas.width, atlas.height)), (16, 32));
}
pub fn an_animated_gui_sprite_packs_its_first_frame_and_animates() void {
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-atlas-gui-anim-{}", std::process::id()));
    // rust: let sprites = root.join("assets/minecraft/textures/gui/sprites/icon");
    // rust: fs::create_dir_all(&sprites).unwrap();
        // A GUI sprite like icon/music_notes: 4 frames stacked vertically (16x64),
        // with animation metadata, and a still 16x32 texture beside it.
    // rust: write_strip(
    // rust: &sprites.join("music_notes.png"),
    // rust: 16,
    // rust: 64,
    // rust: &[
    // rust: [10, 20, 30, 255],
    // rust: [40, 50, 60, 255],
    // rust: [70, 80, 90, 255],
    // rust: [100, 110, 120, 255],
    // rust: ],
    // rust: Some(r#"{"animation": {"frametime": 2}}"#),
    // rust: );
    // rust: write_strip(
    // rust: &sprites.join("static_badge.png"),
    // rust: 16,
    // rust: 32,
    // rust: &[[9, 9, 9, 255]],
    // rust: None,
    // rust: );
    // rust: let atlas = HudAtlas::build(&root).unwrap();
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: let rect = atlas.sprites["gui/sprites/icon/music_notes"];
        // One frame, not the whole 16x64 strip squeezed into a slot.
    // rust: assert_eq!(rect.texels((atlas.width, atlas.height)), (16, 16));
    // rust: assert_eq!(texel_at(&atlas, rect, 0, 15), [10, 20, 30, 255]);
    // rust: let (_, animation) = atlas
    // rust: .sprite_animations
    // rust: .iter()
    // rust: .find(|(r, _)| r.u0 == rect.u0 && r.v0 == rect.v0)
    // rust: .expect("the gui sprite animates");
    // rust: assert_eq!(animation.frame_count(), 4);
        // A still texture there stays whole.
    // rust: let static_badge = atlas.sprites["gui/sprites/icon/static_badge"];
    // rust: assert_eq!(static_badge.texels((atlas.width, atlas.height)), (16, 32));
}
    /// A resource root with one plain item texture and these CIT files (relative path, contents).
pub fn cit_root(name: []const u8, files: *[([]const u8) void {
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-atlas-cit-{name}-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: let item = root.join("assets/minecraft/textures/item");
    // rust: fs::create_dir_all(&item).unwrap();
    // rust: write_strip(&item.join("stick.png"), 16, 16, &[[90, 60, 30, 255]], None);
    // rust: let cit = root.join("assets/minecraft/optifine/cit");
    // rust: fs::create_dir_all(&cit).unwrap();
    // rust: for (rel, text) in files {
    // rust: fs::write(cit.join(rel), text).unwrap();
}
    // rust: root
}
pub fn a_cit_item_rules_texture_is_packed_under_its_id() void {
}
    // rust: let root = cit_root("plain", &[("a.properties", "items=stick\ntexture=a")]);
    // rust: let cit = root.join("assets/minecraft/optifine/cit");
    // rust: write_strip(&cit.join("a.png"), 2, 2, &[[10, 200, 30, 255]], None);
    // rust: let atlas = HudAtlas::build(&root).unwrap();
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: let rect = atlas.sprites["horizon_cit:minecraft/optifine/cit/a"];
    // rust: assert_eq!(rect.texels((atlas.width, atlas.height)), (2, 2));
    // rust: assert_eq!(texel_at(&atlas, rect, 1, 1), [10, 200, 30, 255]);
}
pub fn a_cit_models_relative_texture_is_packed() void {
}
    // rust: let root = cit_root(
    // rust: "model",
    // rust: &[
    // rust: ("a.properties", "items=stick\nmodel=sword"),
    // rust: (
    // rust: "sword.json",
    // rust: r#"{"parent":"item/generated","textures":{"layer0":"./blade"}}"#,
    // rust: ),
    // rust: ],
    // rust: );
    // rust: let cit = root.join("assets/minecraft/optifine/cit");
    // rust: write_strip(&cit.join("blade.png"), 2, 2, &[[40, 50, 60, 255]], None);
    // rust: let atlas = HudAtlas::build(&root).unwrap();
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: let rect = atlas.sprites["horizon_cit:minecraft/optifine/cit/blade"];
    // rust: assert_eq!(texel_at(&atlas, rect, 1, 1), [40, 50, 60, 255]);
}
pub fn a_still_cit_texture_is_packed_whole() void {
}
        // Not cut to a square as an unmarked strip would be: armour layers are 2:1.
    // rust: let root = cit_root("still", &[("a.properties", "items=stick\ntexture=a")]);
    // rust: let cit = root.join("assets/minecraft/optifine/cit");
    // rust: write_strip(&cit.join("a.png"), 4, 2, &[[7, 8, 9, 255]], None);
    // rust: let atlas = HudAtlas::build(&root).unwrap();
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: let rect = atlas.sprites["horizon_cit:minecraft/optifine/cit/a"];
    // rust: assert_eq!(rect.texels((atlas.width, atlas.height)), (4, 2));
}
pub fn an_animated_cit_texture_packs_one_frame_and_animates() void {
}
    // rust: let root = cit_root("anim", &[("a.properties", "items=stick\ntexture=a")]);
    // rust: let cit = root.join("assets/minecraft/optifine/cit");
    // rust: write_strip(
    // rust: &cit.join("a.png"),
    // rust: 16,
    // rust: 48,
    // rust: &[[255, 0, 0, 255], [0, 255, 0, 255], [0, 0, 255, 255]],
    // rust: Some(r#"{"animation": {"frametime": 2}}"#),
    // rust: );
    // rust: let atlas = HudAtlas::build(&root).unwrap();
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: let rect = atlas.sprites["horizon_cit:minecraft/optifine/cit/a"];
    // rust: assert_eq!(rect.texels((atlas.width, atlas.height)), (16, 16));
    // rust: assert_eq!(texel_at(&atlas, rect, 0, 0), [255, 0, 0, 255]);
    // rust: let animations: Vec<_> = atlas
    // rust: .sprite_animations
    // rust: .iter()
    // rust: .filter(|(r, _)| r.u0 == rect.u0 && r.v0 == rect.v0)
    // rust: .collect();
    // rust: assert_eq!(animations.len(), 1);
    // rust: assert_eq!(animations[0].1.frame_count(), 3);
}
pub fn an_armor_rules_texture_is_packed_too() void {
}
    // rust: let root = cit_root(
    // rust: "armor",
    // rust: &[(
    // rust: "a.properties",
    // rust: "type=armor\nitems=iron_chestplate\ntexture.iron_layer_1=a",
    // rust: )],
    // rust: );
    // rust: let cit = root.join("assets/minecraft/optifine/cit");
    // rust: write_strip(&cit.join("a.png"), 64, 32, &[[1, 2, 3, 255]], None);
    // rust: let rules = crate::cit::load_rules(&root);
    // rust: assert_eq!(rules.len(), 1);
    // rust: let atlas = HudAtlas::build(&root).unwrap();
    // rust: let _ = fs::remove_dir_all(&root);
        // Worn armour draws from the same atlas, under the name the layer looks up.
    // rust: let rect = atlas.sprites["horizon_cit:minecraft/optifine/cit/a"];
    // rust: assert_eq!(rect.texels((atlas.width, atlas.height)), (64, 32));
    // rust: let layer = crate::cit_armor::layer_sprite(&rules[0], "minecraft:iron", false, false);
    // rust: assert!(atlas.sprites.contains_key(&layer.unwrap()));
}
pub fn named_cit_textures_pack_once_and_bad_ones_are_skipped() void {
}
    // rust: let root = cit_root(
    // rust: "mixed",
    // rust: &[
                // Vanilla's own texture: already packed, under its usual name.
    // rust: (
    // rust: "v.properties",
    // rust: "items=stick
    // rust: texture=item/stick",
    // rust: ),
    // rust: (
    // rust: "sub.properties",
    // rust: "items=bow
    // rust: texture.bow_pulling_0=b",
    // rust: ),
    // rust: (
    // rust: "broken.properties",
    // rust: "items=apple
    // rust: texture=broken",
    // rust: ),
    // rust: (
    // rust: "wide.properties",
    // rust: "items=egg
    // rust: texture=wide",
    // rust: ),
    // rust: ],
    // rust: );
    // rust: let cit = root.join("assets/minecraft/optifine/cit");
    // rust: write_strip(&cit.join("b.png"), 2, 2, &[[5, 6, 7, 255]], None);
    // rust: fs::write(cit.join("broken.png"), b"not a png").unwrap();
        // A still image past the 1024x512 limit.
    // rust: write_strip(&cit.join("wide.png"), 1040, 1040, &[[1, 1, 1, 255]], None);
        // Vanilla's stick is already packed when the CIT pass runs.
    // rust: let stick = ("item/stick".to_owned(), 16, 16, vec![0; 16 * 16 * 4]);
    // rust: let added = cit_sprites(&root, &[stick]);
    // rust: let names: Vec<_> = added.iter().map(|(image, _, _)| image.0.as_str()).collect();
    // rust: assert_eq!(names, ["horizon_cit:minecraft/optifine/cit/b"]);
        // And the atlas still builds around the broken and the too-wide texture.
    // rust: let atlas = HudAtlas::build(&root).unwrap();
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: assert!(
    // rust: atlas
    // rust: .sprites
    // rust: .contains_key("horizon_cit:minecraft/optifine/cit/b")
    // rust: );
    // rust: assert!(atlas.sprites.contains_key("item/stick"));
}
pub fn one_oversized_texture_leaves_the_others_in() void {
}
        // `a` sorts first and claims more than any atlas; `b` is small and must still pack.
    // rust: let root = cit_root(
    // rust: "oversized",
    // rust: &[
    // rust: ("a.properties", "items=stick\ntexture=a"),
    // rust: ("b.properties", "items=apple\ntexture=b"),
    // rust: ],
    // rust: );
    // rust: let cit = root.join("assets/minecraft/optifine/cit");
        // Only the header is read for `a`: a PNG signature and an IHDR of 20000x20000.
    // rust: let mut header = b"\x89PNG\r\n\x1a\n\0\0\0\x0dIHDR".to_vec();
    // rust: header.extend(20000u32.to_be_bytes());
    // rust: header.extend(20000u32.to_be_bytes());
    // rust: fs::write(cit.join("a.png"), header).unwrap();
    // rust: write_strip(&cit.join("b.png"), 2, 2, &[[4, 5, 6, 255]], None);
    // rust: let added = cit_sprites(&root, &[]);
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: let names: Vec<_> = added.iter().map(|(i, _, _)| i.0.as_str()).collect();
    // rust: assert_eq!(names, ["horizon_cit:minecraft/optifine/cit/b"]);
}
pub fn a_wide_grid_animation_packs_its_frame() void {
}
        // 1104 wide is past the limit for a still texture, not for a row of 16x16 frames.
    // rust: let root = cit_root("grid", &[("a.properties", "items=stick\ntexture=a")]);
    // rust: let cit = root.join("assets/minecraft/optifine/cit");
    // rust: write_strip(&cit.join("a.png"), 1104, 16, &[[9, 9, 9, 255]], None);
    // rust: let mcmeta = r#"{"animation":{"width":16,"height":16}}"#;
    // rust: fs::write(cit.join("a.png.mcmeta"), mcmeta).unwrap();
    // rust: let added = cit_sprites(&root, &[]);
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: let sizes: Vec<_> = added.iter().map(|(i, _, _)| (i.1, i.2)).collect();
    // rust: assert_eq!(sizes, [(16, 16)]);
}
pub fn too_many_custom_item_textures_leave_them_out() void {
}
        // A 1024 atlas holds the stick and the glyph rows, not an image 1100 wide.
    // rust: let image = |name: &str, side: u32| {
    // rust: let pixels = vec![0; (side * side * 4) as usize];
    // rust: (name.to_owned(), side, side, pixels)
}
    // rust: let mut images = vec![image("item/stick", 16), image("horizon_cit:big", 1100)];
    // rust: let mut animated = vec!["horizon_cit:big".to_owned()];
    // rust: let extras = HashSet::from(["horizon_cit:big".to_owned()]);
    // rust: assert!(HudAtlas::layout(&images, 1024).is_err());
    // rust: HudAtlas::layout_leaving_out(&mut images, &mut animated, &extras, 1024).unwrap();
    // rust: let names: Vec<_> = images.iter().map(|i| i.0.as_str()).collect();
    // rust: assert_eq!(names, ["item/stick"]);
    // rust: assert!(animated.is_empty());
        // Without extras to leave out, it fails as before.
    // rust: let mut alone = vec![image("item/big", 1100)];
    // rust: let none = HashSet::new();
    // rust: assert!(HudAtlas::layout_leaving_out(&mut alone, &mut animated, &none, 1024).is_err());
}
pub fn a_root_without_cit_rules_packs_the_same_sprites() void {
}
    // rust: let root = cit_root("none", &[("a.properties", "items=stick\ntexture=a")]);
    // rust: let cit = root.join("assets/minecraft/optifine/cit");
    // rust: write_strip(&cit.join("a.png"), 2, 2, &[[10, 200, 30, 255]], None);
    // rust: let with: HashSet<String> = HudAtlas::build(&root)
    // rust: .unwrap()
    // rust: .sprites
    // rust: .into_keys()
    // rust: .collect();
    // rust: fs::remove_dir_all(root.join("assets/minecraft/optifine")).unwrap();
    // rust: let without: HashSet<String> = HudAtlas::build(&root)
    // rust: .unwrap()
    // rust: .sprites
    // rust: .into_keys()
    // rust: .collect();
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: assert!(without.is_subset(&with));
    // rust: let added: Vec<_> = with.difference(&without).collect();
    // rust: assert_eq!(added, ["horizon_cit:minecraft/optifine/cit/a"]);
    // rust: assert!(without.contains("item/stick"));
}
    /// `count` images of `w x h`; layout reads only their sizes.
pub fn sized(count: usize, w: u32, h: u32) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (0..count)
    // rust: .map(|i| (format!("i{i}"), w, h, Vec::new()))
    // rust: .collect()
}
pub fn assert_inside(images: *[PackedImage], width: u32, placements: *[(u32) void {
}
    // rust: for ((_, w, h, _), (x, y)) in images.iter().zip(placements) {
    // rust: assert!(
    // rust: x + w <= width && y + h < free,
    // rust: "{x},{y} {w}x{h} outside {width}x{free}"
    // rust: );
}
}
pub fn write_png(root: *Path, name: []const u8, w: u32, h: u32) void {
}
    // rust: let path = root.join(format!("assets/minecraft/textures/{name}.png"));
    // rust: fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: let mut encoder = png::Encoder::new(fs::File::create(path).unwrap(), w, h);
    // rust: encoder.set_color(png::ColorType::Rgba);
    // rust: encoder.set_depth(png::BitDepth::Eight);
    // rust: let pixels = vec![255; (w * h * 4) as usize];
    // rust: encoder
    // rust: .write_header()
    // rust: .unwrap()
    // rust: .write_image_data(&pixels)
    // rust: .unwrap();
}
pub fn a_pack_texture_keeps_the_default_textures_gui_size() void {
}
    // rust: let temp = std::env::temp_dir().join(format!("horizon-gui-size-{}", std::process::id()));
    // rust: let (defaults, pack) = (temp.join("defaults"), temp.join("pack"));
    // rust: write_png(&defaults, "gui/container/inventory", 256, 256);
    // rust: write_png(&defaults, "gui/sprites/widget/button", 200, 20);
    // rust: write_png(&defaults, "block/stone", 16, 16);
    // rust: write_png(&defaults, "item/compass", 16, 512);
        // Faithful 64x's inventory (past the 512 rows a texture may have),
        // 32x's button and stone, an animated strip, and a texture of its own.
    // rust: write_png(&pack, "gui/container/inventory", 1024, 1024);
    // rust: write_png(&pack, "gui/sprites/widget/button", 400, 40);
    // rust: write_png(&pack, "block/stone", 32, 32);
    // rust: write_png(&pack, "item/compass", 32, 1024);
    // rust: write_png(&pack, "gui/sprites/pack_only", 30, 10);
    // rust: let atlas = HudAtlas::build_over(&pack, &defaults).unwrap();
    // rust: let _ = fs::remove_dir_all(&temp);
    // rust: let size = (atlas.width, atlas.height);
    // rust: for (name, gui, texels) in [
    // rust: ("gui/container/inventory", (256, 256), (1024, 1024)),
    // rust: ("gui/sprites/widget/button", (200, 20), (400, 40)),
    // rust: ("block/stone", (16, 16), (32, 32)),
    // rust: ("item/compass", (16, 16), (32, 32)),
    // rust: ("gui/sprites/pack_only", (30, 10), (30, 10)),
    // rust: ] {
    // rust: let r = atlas.sprites[name];
    // rust: assert_eq!(((r.w, r.h), r.texels(size)), (gui, texels), "{name}");
}
}
    /// A content mod's GUI textures join the atlas under its namespace;
    /// its other textures and vanilla's names stay as they were.
pub fn a_content_mods_gui_textures_are_sprites_under_its_namespace() void {
}
    // rust: let root = std::env::temp_dir().join(format!("horizon-mod-gui-{}", std::process::id()));
    // rust: write_png(&root, "gui/container/furnace", 256, 256);
    // rust: let png = |rel: &str, w: u32, h: u32| {
    // rust: let path = root.join(rel);
    // rust: fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: let mut encoder = png::Encoder::new(fs::File::create(path).unwrap(), w, h);
    // rust: encoder.set_color(png::ColorType::Rgba);
    // rust: encoder.set_depth(png::BitDepth::Eight);
    // rust: let pixels = vec![255; (w * h * 4) as usize];
    // rust: encoder
    // rust: .write_header()
    // rust: .unwrap()
    // rust: .write_image_data(&pixels)
    // rust: .unwrap();
}
    // rust: png("assets/mymod/textures/gui/container/machine.png", 176, 166);
    // rust: png("assets/mymod/textures/block/machine.png", 16, 16);
    // rust: let atlas = HudAtlas::build(&root).unwrap();
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: assert_eq!(atlas.sprites["mymod:gui/container/machine"].w, 176);
    // rust: assert!(atlas.sprites.contains_key("gui/container/furnace"));
    // rust: assert!(!atlas.sprites.contains_key("mymod:block/machine"));
}
pub fn the_default_textures_keep_a_4096_wide_atlas() void {
}
    // rust: let images = sized(400, 64, 64);
    // rust: let (width, placements, free) = HudAtlas::layout(&images, MAX_ATLAS_SIZE).unwrap();
    // rust: assert_eq!(width, 4096);
    // rust: assert_inside(&images, width, &placements, free);
}
pub fn a_high_resolution_pack_widens_the_atlas_to_fit_the_gpu() void {
}
        // 34 rows of three 1024x512 GUI textures: 17442 rows at 4096 wide,
        // past the 16384 GPUs allow (Faithful 64x needed 32768).
    // rust: let images = sized(100, 1024, 512);
    // rust: let (width, placements, free) = HudAtlas::layout(&images, MAX_ATLAS_SIZE).unwrap();
    // rust: assert_eq!(width, 8192);
    // rust: assert!(free + GLYPH_ROWS <= MAX_ATLAS_SIZE);
    // rust: assert_inside(&images, width, &placements, free);
}
pub fn mixed_sizes_fill_the_ends_of_the_shelves() void {
}
        // 15 images 9000 wide leave 7383 of a 16384 shelf unused each; the
        // 4000-wide ones (same height) come after them, and on shelves of their
        // own (4 to a shelf) the atlas is 19 shelves tall: past 16384 rows.
        // Each in a gap, it is 15.
    // rust: let mut images = sized(15, 9000, 1000);
    // rust: images.extend(sized(15, 4000, 1000));
    // rust: let (width, placements, free) = HudAtlas::layout(&images, 16384).unwrap();
    // rust: assert_eq!(width, 16384);
    // rust: assert!(free + GLYPH_ROWS <= 16384);
    // rust: assert_inside(&images, width, &placements, free);
}
pub fn textures_that_cannot_fit_are_an_error_not_a_gpu_panic() void {
}
    // rust: let error = HudAtlas::layout(&sized(300, 1024, 1024), MAX_ATLAS_SIZE).unwrap_err();
    // rust: assert!(error.to_string().contains("do not fit a 16384x16384 atlas"));
        // One image wider than the largest atlas.
    // rust: assert!(HudAtlas::layout(&sized(1, 2048, 16), 2048).is_err());
}

pub fn a_wrapped_border_repeats_the_opposite_edges() void {
}
        // 2x2 texels a b / c d, one byte each in red.
    // rust: let image = (
    // rust: "x".to_owned(),
    // rust: 2,
    // rust: 2,
    // rust: [1u8, 2, 3, 4]
    // rust: .iter()
    // rust: .flat_map(|&v| [v, 0, 0, 255])
    // rust: .collect(),
    // rust: );
    // rust: let (_, w, h, data) = wrap_border(&image);
    // rust: assert_eq!((w, h), (4, 4));
    // rust: let red: Vec<u8> = data.chunks(4).map(|t| t[0]).collect();
    // rust: assert_eq!(red, [
    // rust: 4, 3, 4, 3,
    // rust: 2, 1, 2, 1,
    // rust: 4, 3, 4, 3,
    // rust: 2, 1, 2, 1,
    // rust: ]);
}

    /// A synthetic default font: two 8x8 glyphs, 3 and 5 pixels wide.
pub fn two_glyph_font(name: []const u8) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-fonts-{name}-{}", std::process::id()));
    // rust: let font = root.join("assets/minecraft/font");
    // rust: let textures = root.join("assets/minecraft/textures/font");
    // rust: fs::create_dir_all(&font).unwrap();
    // rust: fs::create_dir_all(&textures).unwrap();
    // rust: fs::write(
    // rust: font.join("default.json"),
    // rust: r#"{"providers":[{"type":"bitmap","file":"minecraft:font/test.png","ascent":7,"chars":["ab"]}]}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let mut pixels = vec![0u8; 16 * 8 * 4];
    // rust: for y in 0..8 {
    // rust: for x in (0..3).chain(8..13) {
    // rust: pixels[(y * 16 + x) * 4 + 3] = 255;
}
}
    // rust: let mut encoder =
    // rust: png::Encoder::new(fs::File::create(textures.join("test.png")).unwrap(), 16, 8);
    // rust: encoder.set_color(png::ColorType::Rgba);
    // rust: encoder.set_depth(png::BitDepth::Eight);
    // rust: encoder
    // rust: .write_header()
    // rust: .unwrap()
    // rust: .write_image_data(&pixels)
    // rust: .unwrap();
    // rust: root
}
pub fn the_fonts_only_atlas_measures_text_like_the_full_one() void {
}
    // rust: let root = two_glyph_font("atlas");
    // rust: let full = HudAtlas::build(&root).unwrap();
    // rust: let fonts = HudAtlas::fonts(&root).unwrap();
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: assert!(fonts.pixels.is_empty());
    // rust: let width = full.font.width("abba");
    // rust: assert!(width > 0.0);
    // rust: assert_eq!(fonts.font.width("abba"), width);
}
pub fn outlined_world_text_keeps_font_metrics_and_overrides_outline_color() void {
}
    // rust: let root = two_glyph_font("world-outline");
    // rust: let atlas = HudAtlas::build(&root).unwrap();
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: let mut batch = HudBatch::new([1, 1]);
    // rust: let text = crate::text::Text::colored("ab", 0xff0000);
    // rust: let outline = rgba(1, 2, 3, 128);
    // rust: let (advance, front) =
    // rust: batch.text_styled_outline_world(&atlas, &text, 10.0, 20.0, u32::MAX, outline);
    // rust: assert_eq!((advance, front, batch.vertices.len()), (10.0, 96, 108));
    // rust: assert!(batch.vertices[..front].iter().all(|v| v.color == outline));
    // rust: assert!(
    // rust: batch.vertices[front..]
    // rust: .iter()
    // rust: .all(|v| v.color == rgba(255, 0, 0, 255))
    // rust: );
        // Eight independently offset silhouettes, retaining both glyphs and
        // the bitmap font's advance (a=4, b=6); front text has no shadow.
    // rust: for (i, [dx, dy]) in [
    // rust: [-1.0, -1.0],
    // rust: [-1.0, 0.0],
    // rust: [-1.0, 1.0],
    // rust: [0.0, -1.0],
    // rust: [0.0, 1.0],
    // rust: [1.0, -1.0],
    // rust: [1.0, 0.0],
    // rust: [1.0, 1.0],
    // rust: ]
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: {
    // rust: let at = batch.vertices[i * 12].pos;
    // rust: let main = batch.vertices[front].pos;
    // rust: assert_eq!(at, [main[0] + dx, main[1] + dy]);
    // rust: assert_eq!(batch.vertices[i * 12 + 6].pos[0] - at[0], 4.0);
}
}
pub fn obfuscated_glyphs_keep_the_width() void {
}
    // rust: let root = two_glyph_font("obfuscated");
    // rust: let fonts = HudAtlas::fonts(&root).unwrap();
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: let (a, b) = (fonts.font.glyph('a').advance, fonts.font.glyph('b').advance);
    // rust: assert_ne!(a, b);
    // rust: for _ in 0..20 {
    // rust: assert_eq!(fonts.font.random_glyph(&Default::default(), a).advance, a);
    // rust: assert_eq!(fonts.font.random_glyph(&Default::default(), b).advance, b);
}
        // No glyph that wide: FontSet's missing glyph.
    // rust: let missing = fonts.font.random_glyph(&Default::default(), 30.0);
    // rust: assert!(missing.rect.is_none() && missing.right == 5.0);
}

pub fn component_shadow_color_overrides_text_call_shadow() void {
}
    // rust: let root = two_glyph_font("component-shadow");
    // rust: let atlas = HudAtlas::build(&root).unwrap();
    // rust: let mut batch = HudBatch::new([320, 240]);
    // rust: let text = crate::text::Text::styled(
    // rust: "a",
    // rust: crate::text::Style {
    // rust: shadow_color: Some(0x8040_2010),
    // rust: ..Default::default()
    // rust: },
    // rust: );
    // rust: batch.text_styled(&atlas, &text, 10.0, 10.0, u32::MAX, false);
    // rust: assert_eq!(batch.vertices.len(), 12);
    // rust: assert_eq!(batch.vertices[0].color, rgba(0x40, 0x20, 0x10, 0x80));
    // rust: batch.vertices.clear();
    // rust: batch.text_styled_world(&atlas, &text, 10.0, 10.0, u32::MAX, false);
    // rust: assert_eq!(batch.vertices.len(), 12);
    // rust: assert_eq!(batch.vertices[0].depth, 0.0);
    // rust: assert_eq!(batch.vertices[6].depth, 0.03);
    // rust: batch.vertices.clear();
    // rust: let no_shadow = crate::text::Text::styled(
    // rust: "a",
    // rust: crate::text::Style {
    // rust: shadow_color: Some(0),
    // rust: ..Default::default()
    // rust: },
    // rust: );
    // rust: batch.text_styled(&atlas, &no_shadow, 10.0, 10.0, u32::MAX, true);
    // rust: assert_eq!(batch.vertices.len(), 6);
    // rust: batch.vertices.clear();
    // rust: let gradient = crate::component::to_text(
    // rust: &serde_json::json!({
    // rust: "text": "",
    // rust: "extra": [
    // rust: {"text": "a", "color": "#ff0000"},
    // rust: {"text": "b", "color": "#0000ff"}
    // rust: ]
    // rust: }),
    // rust: &mut |_| crate::text::Text::empty(),
    // rust: );
    // rust: batch.text_styled(&atlas, &gradient, 10.0, 10.0, u32::MAX, false);
    // rust: assert_eq!(batch.vertices[0].color, rgba(255, 0, 0, 255));
    // rust: assert_eq!(batch.vertices[6].color, rgba(0, 0, 255, 255));
}

pub fn player_object_draws_an_inline_head() void {
}
    // rust: let root = two_glyph_font("inline-head");
    // rust: write_png(&root, "entity/player/slim/alex", 64, 64);
    // rust: write_png(&root, "entity/player/wide/steve", 64, 64);
    // rust: let mut atlas = HudAtlas::build(&root).unwrap();
    // rust: let text = crate::component::to_text(
    // rust: &serde_json::json!({"object":"player","player":{"id":"00000000-0000-0000-0000-000000000000"}}),
    // rust: &mut |_| crate::text::Text::empty(),
    // rust: );
    // rust: let mut batch = HudBatch::new([320, 240]);
    // rust: assert_eq!(
    // rust: batch.text_styled(&atlas, &text, 10.0, 10.0, u32::MAX, false),
    // rust: 8.0
    // rust: );
    // rust: assert_eq!(batch.vertices.len(), 12); // face and hat, six vertices each
    // rust: assert_eq!(batch.inline_profiles.len(), 1);
    // rust: atlas.set_object_skin("name:elyapluggin".into(), "entity/player/wide/steve".into());
    // rust: let named = crate::component::to_text(
    // rust: &serde_json::json!({"object":"player","player":{"name":"elyapluggin"}}),
    // rust: &mut |_| crate::text::Text::empty(),
    // rust: );
    // rust: batch.vertices.clear();
    // rust: batch.text_styled(&atlas, &named, 10.0, 10.0, u32::MAX, false);
    // rust: let skin = atlas.sprites["entity/player/wide/steve"];
    // rust: assert_eq!(batch.vertices[0].uv[0], skin.u0 + (skin.u1 - skin.u0) / 8.0);
    // rust: batch.vertices.clear();
    // rust: batch.text_styled(&atlas, &named, 10.0, 10.0, u32::MAX, true);
    // rust: assert_eq!(batch.vertices.len(), 24); // shadow and front, each with face and hat
    // rust: assert_eq!(batch.vertices[0].pos, [11.0, 10.0]);
    // rust: assert_eq!(batch.vertices[0].color, rgba(63, 63, 63, 255));
    // rust: assert_eq!(batch.vertices[12].pos, [10.0, 9.0]);
    // rust: assert_eq!(batch.vertices[12].color, u32::MAX);
    // rust: fs::remove_dir_all(root).unwrap();
}

pub fn atlas_object_draws_an_item_sprite_inline() void {
}
    // rust: let root = two_glyph_font("inline-item");
    // rust: write_png(&root, "item/porkchop", 16, 16);
    // rust: let atlas = HudAtlas::build(&root).unwrap();
    // rust: let text = crate::component::to_text(
    // rust: &serde_json::json!({
    // rust: "text": "a",
    // rust: "extra": [{"object": "atlas", "sprite": "minecraft:item/porkchop"}]
    // rust: }),
    // rust: &mut |_| crate::text::Text::empty(),
    // rust: );
    // rust: let mut batch = HudBatch::new([320, 240]);
    // rust: let width = batch.text_styled(&atlas, &text, 10.0, 10.0, u32::MAX, false);
    // rust: assert_eq!(width, atlas.font.glyph('a').advance + 8.0);
    // rust: assert_eq!(batch.vertices.len(), 12); // glyph and one sprite
    // rust: let sprite = atlas.sprites["item/porkchop"];
    // rust: assert_eq!(batch.vertices[6].uv, [sprite.u0, sprite.v0]);
    // rust: fs::remove_dir_all(root).unwrap();
}

pub fn name_tags_draw_bold_text_and_tall_glyphs_like_any_text() void {
}
        // `ascii.png`'s 8x8 'a' (4 pixels wide) and `accented.png`'s 9x12
        // 'й' (height 12, ascent 10: the breve above the line), 7 wide.
    // rust: let root = std::env::temp_dir().join(format!("horizon-name-tag-{}", std::process::id()));
    // rust: let textures = root.join("assets/minecraft/textures/font");
    // rust: fs::create_dir_all(root.join("assets/minecraft/font")).unwrap();
    // rust: fs::create_dir_all(&textures).unwrap();
    // rust: fs::write(
    // rust: root.join("assets/minecraft/font/default.json"),
    // rust: r#"{"providers":[
    // rust: {"type":"bitmap","file":"minecraft:font/a.png","ascent":7,"chars":["a"]},
    // rust: {"type":"bitmap","file":"minecraft:font/tall.png","height":12,"ascent":10,"chars":["й"]}]}"#,
    // rust: )
    // rust: .unwrap();
    // rust: for (name, (w, h), used) in [("a", (8, 8), 4), ("tall", (9, 12), 7)] {
    // rust: let pixels: Vec<u8> = (0..w * h)
    // rust: .flat_map(|i| [255, 255, 255, if i % w < used { 255 } else { 0 }])
    // rust: .collect();
    // rust: let file = fs::File::create(textures.join(format!("{name}.png"))).unwrap();
    // rust: let mut encoder = png::Encoder::new(file, w, h);
    // rust: encoder.set_color(png::ColorType::Rgba);
    // rust: encoder.set_depth(png::BitDepth::Eight);
    // rust: let mut writer = encoder.write_header().unwrap();
    // rust: writer.write_image_data(&pixels).unwrap();
}
    // rust: let atlas = HudAtlas::build(&root).unwrap();
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: let text = crate::text::Text::literal("aй").bold();
    // rust: let mut batch = HudBatch::new([1, 1]);
    // rust: let behind = batch.name_tag(&atlas, &text, 0.0, u32::MAX, 0x3F00_0000);
        // Each quad's box: x0, y0, x1, y1.
    // rust: let boxes: Vec<[f32; 4]> = batch
    // rust: .vertices
    // rust: .as_chunks::<6>()
    // rust: .0
    // rust: .iter()
    // rust: .map(|q| [q[0].pos[0], q[0].pos[1], q[2].pos[0], q[2].pos[1]])
    // rust: .collect();
        // Advances 5 and 8, plus 1 each for bold: Font.width 15, centred.
    // rust: let x = -7.5;
        // Each glyph twice (bold), the copy a pixel right; 'й' in its 9x12
        // box from 3 pixels above the line, each bold quad 0.1 larger.
    // rust: let near = |a: [f32; 4], b: [f32; 4]| a.iter().zip(b).all(|(a, b)| (a - b).abs() < 1e-4);
    // rust: let expected = [
    // rust: [x - 0.1, -0.1, x + 8.1, 8.1],
    // rust: [x + 0.9, -0.1, x + 9.1, 8.1],
    // rust: [x + 5.9, -3.1, x + 15.1, 9.1],
    // rust: [x + 6.9, -3.1, x + 16.1, 9.1],
    // rust: ];
    // rust: for (got, want) in boxes[1..].iter().zip(expected) {
    // rust: assert!(near(*got, want), "{got:?} != {want:?}");
}
    // rust: assert_eq!(boxes.len(), 1 + expected.len());
        // The background first: a pixel round the advances, 10 pixels tall.
    // rust: assert_eq!(behind, 6);
    // rust: assert_eq!(boxes[0], [x - 1.0, -1.0, x + 15.0, 9.0]);
}

pub fn effect_icons_are_painted_from_the_mob_effect_directory() void {
}
//         use crate::{effects::EffectInstance, hud_layout, hud_overlays, inventory_effects};
        // A synthetic resource tree exercises loading and painting together.
        // No Minecraft installation or GPU is needed for this regression test.
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-effect-icons-{}", std::process::id()));
    // rust: for (name, size) in [
    // rust: ("mob_effect/levitation", 18),
    // rust: ("gui/sprites/hud/effect_background", 24),
    // rust: ("gui/sprites/container/inventory/effect_background", 32),
    // rust: ] {
    // rust: let path = root.join(format!("assets/minecraft/textures/{name}.png"));
    // rust: fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: let mut encoder = png::Encoder::new(fs::File::create(path).unwrap(), size, size);
    // rust: encoder.set_color(png::ColorType::Rgba);
    // rust: encoder.set_depth(png::BitDepth::Eight);
    // rust: encoder
    // rust: .write_header()
    // rust: .unwrap()
    // rust: .write_image_data(&vec![255; (size * size * 4) as usize])
    // rust: .unwrap();
}
    // rust: let atlas = HudAtlas::build(&root).unwrap();
    // rust: let effect = EffectInstance::new("levitation", -1, 0);
    // rust: let icon = hud_overlays::EffectIcon::from(&effect);
    // rust: let draws = hud_overlays::effects(320, false, &[icon]);
    // rust: let mut batch = HudBatch::new([320, 240]);
    // rust: hud_layout::paint(&mut batch, &atlas, &draws);
        // Both the background and the 18x18 effect icon must reach the batch.
    // rust: assert_eq!(batch.vertices.len(), 12);
    // rust: let rect = atlas.sprites["mob_effect/levitation"];
    // rust: assert_eq!(batch.vertices[6].pos, [298.0, 30.0]);
    // rust: assert_eq!(batch.vertices[6].uv, [rect.u0, rect.v0]);
    // rust: assert_eq!(batch.vertices[8].uv, [rect.u1, rect.v1]);

    // rust: let panels = inventory_effects::panels(
    // rust: 320,
    // rust: [72, 37],
    // rust: 176,
    // rust: std::slice::from_ref(&effect),
    // rust: 20.0,
    // rust: &|_| None,
    // rust: &|_| 60,
    // rust: );
    // rust: batch.vertices.clear();
    // rust: let tooltip = inventory_effects::paint(&mut batch, &atlas, &panels, [257, 44]);
    // rust: assert_eq!(tooltip.unwrap()[0].0, "levitation");
    // rust: assert_eq!(batch.vertices.len(), 24);
    // rust: assert_eq!(batch.vertices[18].pos, [257.0, 44.0]);
    // rust: assert_eq!(batch.vertices[18].uv, [rect.u0, rect.v0]);
    // rust: assert_eq!(batch.vertices[20].uv, [rect.u1, rect.v1]);

        // Wide panels retain the four-pixel border instead of stretching it.
    // rust: let panels =
    // rust: inventory_effects::panels(480, [72, 37], 176, &[effect], 20.0, &|_| None, &|_| 60);
    // rust: batch.vertices.clear();
    // rust: assert!(inventory_effects::paint(&mut batch, &atlas, &panels, [0, 0]).is_none());
    // rust: assert!(batch.vertices.iter().any(|v| v.color == 0xff808080));
    // rust: assert_eq!(batch.vertices[0].pos, [250.0, 37.0]);
    // rust: assert_eq!(batch.vertices[1].pos, [254.0, 37.0]);
    // rust: let background = atlas.sprites["gui/sprites/container/inventory/effect_background"];
    // rust: assert!(
    // rust: (batch.vertices[1].uv[0] - background.u0 - (background.u1 - background.u0) / 8.0).abs()
    // rust: < 1e-6
    // rust: );
    // rust: fs::remove_dir_all(root).unwrap();
}

pub fn gui_models_keep_separate_depth_runs_between_overlay_draws() void {
}
    // rust: let mut batch = HudBatch::new([640, 480]);
    // rust: batch.scale = 2.0;
    // rust: let p = [
    // rust: [0.0, 0.0, 2.0],
    // rust: [0.0, 1.0, 2.0],
    // rust: [1.0, 1.0, 2.0],
    // rust: [1.0, 0.0, 2.0],
    // rust: ];
    // rust: let uv = [[0.0; 2]; 4];
    // rust: batch.quad([[0.0; 2]; 4], uv, u32::MAX);
    // rust: for _ in 0..2 {
    // rust: let start = batch.vertices.len();
    // rust: batch.quad_3d(p, uv, u32::MAX);
    // rust: batch.depth_since(start, [1.0, 2.0, 4.0, 6.0]);
}
    // rust: batch.quad([[0.0; 2]; 4], uv, u32::MAX);
    // rust: assert_eq!(
    // rust: batch.runs(),
    // rust: vec![
    // rust: (0..6, Blend::Alpha),
    // rust: (6..12, Blend::Depth([2, 4, 6, 8])),
    // rust: (12..18, Blend::Depth([2, 4, 6, 8])),
    // rust: (18..24, Blend::Alpha),
    // rust: ]
    // rust: );
    // rust: assert!(
    // rust: batch
    // rust: .vertices
    // rust: .iter()
    // rust: .all(|v| v.depth.is_finite() && (0.0..=1.0).contains(&v.depth))
    // rust: );
}

pub fn hud_shader_validates_both_fragment_entries() void {
}
    // rust: let module = naga::front::wgsl::parse_str(include_str!("hud.wgsl")).unwrap();
    // rust: naga::valid::Validator::new(
    // rust: naga::valid::ValidationFlags::all(),
    // rust: naga::valid::Capabilities::all(),
    // rust: )
    // rust: .validate(&module)
    // rust: .unwrap();
}

pub fn inverted_ranges_split_the_draws_in_order() void {
}
    // rust: let mut batch = HudBatch::new([854, 480]);
    // rust: let quad = |b: &mut HudBatch| b.quad([[0.0; 2]; 4], [[0.0; 2]; 4], 0);
    // rust: quad(&mut batch);
    // rust: let start = batch.vertices.len();
    // rust: quad(&mut batch);
    // rust: batch.invert_since(start);
    // rust: let start = batch.vertices.len();
    // rust: quad(&mut batch);
    // rust: batch.invert_since(start);
    // rust: batch.invert_since(batch.vertices.len());
    // rust: let start = batch.vertices.len();
    // rust: quad(&mut batch);
    // rust: batch.blend_since(start, Blend::Additive);
    // rust: quad(&mut batch);
    // rust: assert_eq!(
    // rust: batch.blends,
    // rust: vec![(6..18, Blend::Invert), (18..24, Blend::Additive)]
    // rust: );
    // rust: assert_eq!(
    // rust: batch.runs(),
    // rust: vec![
    // rust: (0..6, Blend::Alpha),
    // rust: (6..18, Blend::Invert),
    // rust: (18..24, Blend::Additive),
    // rust: (24..30, Blend::Alpha)
    // rust: ]
    // rust: );
}

pub fn blur_boundary_splits_blend_runs_without_losing_or_repeating_vertices() void {
}
    // rust: let mut batch = HudBatch::new([854, 480]);
    // rust: for _ in 0..5 {
    // rust: batch.quad([[0.0; 2]; 4], [[0.0; 2]; 4], 0);
}
    // rust: batch.blends = vec![
    // rust: (6..18, Blend::Invert),
    // rust: (18..24, Blend::Depth([0, 0, 10, 10])),
    // rust: ];
    // rust: for split in [0, 6, 12, 18, 24, 30] {
    // rust: let before = batch.runs_in(0..split);
    // rust: let after = batch.runs_in(split..30);
    // rust: let actual: Vec<_> = before
    // rust: .into_iter()
    // rust: .chain(after)
    // rust: .flat_map(|(range, blend)| range.map(move |v| (v, blend)))
    // rust: .collect();
    // rust: let expected: Vec<_> = batch
    // rust: .runs()
    // rust: .into_iter()
    // rust: .flat_map(|(range, blend)| range.map(move |v| (v, blend)))
    // rust: .collect();
    // rust: assert_eq!(actual, expected, "blur at {split}");
}
}
pub fn container_origins_use_java_integer_division() void {
}
        // Odd scaled dimensions, odd image sizes and an oversized panel.
    // rust: for (width, height) in [(640, 360), (641, 361), (456, 256), (534, 300), (100, 100)] {
    // rust: let batch = HudBatch {
    // rust: vertices: Vec::new(),
    // rust: scale: 3.0,
    // rust: width: width as f32,
    // rust: height: height as f32,
    // rust: patches: Vec::new(),
    // rust: blends: Vec::new(),
    // rust: end_portal: EndPortalFill::default(),
    // rust: glint_alpha: 0.75,
    // rust: glint_colour: 0,
    // rust: game_time: 0.0,
    // rust: blur_at: 0,
    // rust: inline_profiles: Vec::new(),
}
    // rust: for (image_width, image_height) in [(195, 136), (176, 166), (176, 222)] {
    // rust: assert_eq!(
    // rust: batch.centered_origin(image_width as f32, image_height as f32),
    // rust: (
    // rust: ((width - image_width) / 2) as f32,
    // rust: ((height - image_height) / 2) as f32
    // rust: )
    // rust: );
}
}
}
}
