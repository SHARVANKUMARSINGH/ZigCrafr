//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_font
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Fonts (FontManager / FontSet): `font/default.json` and every other font a
//! text component names (`minecraft:alt`, `minecraft:uniform`, a pack's own),
//! each a list of providers tried in order: `space`, `bitmap` (sheets in the
//! shared atlas, or rasterized on demand when a pack's sheet is not in it),
//! `unihex` (GNU Unifont) and `ttf` (TrueTypeGlyphProvider, rasterized with
//! ab_glyph). Glyphs drawn at run time go into a reserved atlas region.
//! Vanilla glyph metrics (ascent, oversampling, advances, bold/shadow
//! offsets), styled drawing and StringSplitter-style line wrapping.
// use crate::{
    // rust: hud::Rect,
    // rust: text::{Span, Style, Text, legacy_format},
    // rust: zip::Zip,
}
// use ab_glyph::{Font as _, ScaleFont as _};
// use std::{
    // rust: cell::RefCell,
    // rust: collections::HashMap,
    // rust: path::{Path, PathBuf},
    // rust: sync::Arc,
}

/// `FontDescription.DEFAULT`.
pub const DEFAULT: []const u8 = "minecraft:default";

/// A glyph ready to draw: atlas UVs and its box relative to the pen
/// position (GlyphBitmap left/top/right/bottom), in GUI pixels.
pub const Glyph = struct {
    rect: ?Rect,
    left: f32,
    top: f32,
    right: f32,
    bottom: f32,
    advance: f32,
    /// Shadow and bold offset (1 for bitmap and TrueType glyphs, 0.5 for unihex).
    offset: f32,
};
/// Pixels to copy into the shared atlas before the next HUD draw.
pub const Patch = struct {
    x: u32,
    y: u32,
    width: u32,
    height: u32,
    rgba: std.ArrayList(u8),
};
pub const HexGlyph = struct {
    /// Rows left-aligned in 32 bits.
    rows: [u32,
    left: u32,
    right: u32,
};
/// A provider's `filter` (`FontOption.Filter`): the options it needs.
pub const Filter = struct {
    uniform: ?bool,
    jp: ?bool,
};
    // rust: impl Filter {
pub fn of(provider: *serde_json::Value) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let f = &provider["filter"];
    // rust: Self {
    // rust: uniform: f["uniform"].as_bool(),
    // rust: jp: f["jp"].as_bool(),
}
}
pub fn passes(self: *Self, uniform: bool, japanese: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.uniform.is_none_or(|v| v == uniform) && self.jp.is_none_or(|v| v == japanese)
}
}
/// A bitmap glyph whose sheet is not in the atlas: the cell to copy.
pub const SheetCell = struct {
    sheet: Arc<(u32,
    x: u32,
    y: u32,
    w: u32,
    h: u32,
    glyph: Glyph,
};
pub const BitmapGlyph = enum {
    Atlas(Glyph),
    Sheet(SheetCell),
};
/// `TrueTypeGlyphProvider`.
pub const TrueType = struct {
    font: ab_glyph::FontVec,
    ids: HashMap<char,
    /// FT_Set_Pixel_Sizes: `size * oversample` pixels to the em.
    scale: ab_glyph::PxScale,
    oversample: f32,
    /// FT_Set_Transform's delta, in oversampled pixels (y down).
    shift: (f32,
};
pub const Provider = enum {
    Space(HashMap<char, f32>),
    Bitmap(Filter, HashMap<char, BitmapGlyph>),
    /// The definition, and its glyphs once read.
    Unihex(Filter, serde_json::Value, Option<HashMap<u32, HexGlyph>>),
    TrueType(Filter, Box<TrueType>),
};
/// One font (`FontSet`): its providers and the glyphs resolved so far.
pub const FontSet = struct {
    providers: std.ArrayList(Provider),
    /// Every char drawn looks up here, so the hasher is Fx, not SipHash.
    glyphs: crate::fast_hash::FxHashMap<char,
    /// `SelectedGlyphs.nonFishy` of the characters whose first glyph has a fishy advance (the
    /// others use `glyphs`): what obfuscated text draws.
    non_fishy: crate::fast_hash::FxHashMap<char,
    /// `glyphsByWidth` for obfuscated text (built on first use), by `ceil(advance)`.
    by_width: Option<HashMap<i32,
};
/// The atlas region glyphs are rasterized into, filled in rows.
pub const Region = struct {
    cursor: (u32,
    row: u32,
    pending: std.ArrayList(Patch),
    /// A glyph did not fit since the last `Font::begin_frame`.
    full: bool,
};
pub const Cache = struct {
    /// Every font by id, the default one first (the common lookup).
    sets: Vec<([]const u8,
    region: Region,
    /// `Font.random`: picks obfuscated glyphs.
    random: horizon_core::random::LegacyRandom,
};
pub const Font = struct {
    /// The atlas rects of the sheets under `textures/font`.
    sheets: HashMap<[]const u8,
    missing: Glyph,
    white: Rect,
    root: PathBuf,
    /// Atlas size and the reserved dynamic region (y, height).
    atlas: (u32,
    region: (u32,
    metrics_only: bool,
    cache: RefCell<Cache>,
    /// Set anew for each font and each `reset_cache` (see `epoch`).
    generation: std::cell::Cell<u64>,
    /// "Force Unicode Font": the `uniform` filter option.
    uniform: bool,
    /// "Japanese Glyph Variants": the `jp` filter option.
    japanese: bool,
};
pub fn parse_hex_digit(b: u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (b as char).to_digit(16)
}
/// UnihexProvider.readFromStream over one `.hex` file.
pub fn parse_hex(text: []const u8, out: *mut HashMap<u32) void {
}
    // rust: for line in text.split(|b| *b == b'\n') {
    // rust: let line = line.strip_suffix(b"\r").unwrap_or(line);
    // rust: let Some(colon) = line.iter().position(|b| *b == b':') else {
    // rust: continue;
}
    // rust: let (code, data) = (&line[..colon], &line[colon + 1..]);
    // rust: if !(4..=6).contains(&code.len()) {
    // rust: continue;
}
    // rust: let Some(codepoint) = code
    // rust: .iter()
    // rust: .try_fold(0u32, |a, b| parse_hex_digit(*b).map(|d| a << 4 | d))
    // rust: else {
    // rust: continue;
}
    // rust: let digits_per_row = match data.len() {
    // rust: 32 => 2,
    // rust: 64 => 4,
    // rust: 96 => 6,
    // rust: 128 => 8,
    // rust: _ => continue,
}
    // rust: let bit_width = digits_per_row as u32 * 4;
    // rust: let mut rows = [0u32; 16];
    // rust: let mut mask = 0u32;
    // rust: let mut ok = true;
    // rust: for (r, row) in rows.iter_mut().enumerate() {
    // rust: let chunk = &data[r * digits_per_row..(r + 1) * digits_per_row];
    // rust: match chunk
    // rust: .iter()
    // rust: .try_fold(0u32, |a, b| parse_hex_digit(*b).map(|d| a << 4 | d))
    // rust: {
    // rust: Some(v) => {
    // rust: *row = v << (32 - bit_width);
    // rust: mask |= *row;
}
    // rust: None => ok = false,
}
}
    // rust: if !ok {
    // rust: continue;
}
        // LineData.calculateWidth.
    // rust: let (left, right) = if mask == 0 {
    // rust: (0, bit_width)
    // rust: } else {
    // rust: (mask.leading_zeros(), 31 - mask.trailing_zeros())
}
    // rust: out.insert(codepoint, HexGlyph { rows, left, right });
}
}
pub fn read_json(root: *Path, path: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: serde_json::from_slice(&std::fs::read(root.join(path)).ok()?).ok()
}
pub fn resource_path(id: []const u8, folder: []const u8, ext: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (ns, path) = id.split_once(':').unwrap_or(("minecraft", id));
    // rust: format!("assets/{ns}/{folder}/{}{ext}", path.trim_end_matches(ext))
}
/// Providers of a font definition with references expanded, in order, with
/// their `filter` objects.
pub fn providers(root: *Path, id: []const u8, depth: u32, out: *mut std.ArrayList(serde_json::Value)) void {
}
    // rust: if depth > 8 {
    // rust: return;
}
    // rust: let Some(def) = read_json(root, &resource_path(id, "font", ".json")) else {
    // rust: return;
}
    // rust: for p in def["providers"].as_array().into_iter().flatten() {
    // rust: if p["type"] == "reference" {
    // rust: let mut nested = Vec::new();
    // rust: providers(root, p["id"].as_str().unwrap_or(""), depth + 1, &mut nested);
    // rust: for mut n in nested {
                // A reference's filter applies to everything it includes.
    // rust: if let Some(f) = p["filter"].as_object() {
    // rust: let merged = n["filter"]
    // rust: .as_object()
    // rust: .cloned()
    // rust: .unwrap_or_default()
    // rust: .into_iter()
    // rust: .chain(f.clone())
    // rust: .collect();
    // rust: n["filter"] = serde_json::Value::Object(merged);
}
    // rust: out.push(n);
}
    // rust: } else {
    // rust: out.push(p.clone());
}
}
}
// FontTexture.add nudges UVs inside the glyph to avoid neighboring texels.
pub fn glyph_rect(x: u32, y: u32, w: u32, h: u32, atlas: (u32) void {
}
    // rust: Rect {
    // rust: u0: (x as f32 + 0.01) / atlas.0 as f32,
    // rust: v0: (y as f32 + 0.01) / atlas.1 as f32,
    // rust: u1: ((x + w) as f32 - 0.01) / atlas.0 as f32,
    // rust: v1: ((y + h) as f32 - 0.01) / atlas.1 as f32,
    // rust: w,
    // rust: h,
}
}
/// The unscaled pixel width of a bitmap cell (`BitmapProvider.getActualGlyphWidth`).
pub fn used_width(pixels: []const u8, stride: u32) void {
}
    // rust: (0..cw)
    // rust: .rev()
    // rust: .find(|&x| {
    // rust: (0..ch).any(|y| {
    // rust: pixels
    // rust: .get((((cy + y) * stride + cx + x) * 4 + 3) as usize)
    // rust: .is_some_and(|a| *a != 0)
    // rust: })
    // rust: })
    // rust: .map_or(0, |x| x + 1)
}
/// `FontSet.hasFishyAdvance`: an advance under 0 or over 32. Such a glyph is still the one drawn
/// (`SelectedGlyphs.any` is the first provider's); only `SelectedGlyphs.nonFishy`, what obfuscated
/// text draws, moves on to the next provider that has the character. Packs rely on it: a `space`
/// provider's kerning runs from -512 to 512, and a tall bitmap's glyphs pass 32. Horizon keeps one
/// advance per glyph and tests it here.
pub fn fishy_advance(advance: f32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !(0.0..=32.0).contains(&advance)
}
/// A Unihex glyph's advance (`UnihexProvider.Glyph.advance`): half its width
/// plus one, the width being the bits from its left to its right column.
pub fn hex_advance(h: *HexGlyph) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let width = h.right.saturating_sub(h.left) + 1;
    // rust: (width / 2 + 1) as f32
}
/// `BitmapProvider.Definition.load`: each character's glyph, from the atlas
/// when the sheet is in it (`pixels` its RGBA), else from the sheet's own
/// pixels, copied into the atlas when first drawn.
    // rust: fn load_bitmap(
    // rust: root: &Path,
    // rust: p: &serde_json::Value,
    // rust: sheets: &HashMap<String, Rect>,
    // rust: pixels: &[u8],
    // rust: atlas: (u32, u32),
    // rust: metrics_only: bool,
    // rust: ) -> HashMap<char, BitmapGlyph> {
    // rust: let mut out = HashMap::new();
    // rust: let file = p["file"].as_str().unwrap_or("");
    // rust: let (ns, name) = file.split_once(':').unwrap_or(("minecraft", file));
    // rust: let in_atlas = (ns == "minecraft")
    // rust: .then(|| sheets.get(name.trim_end_matches(".png")).copied())
    // rust: .flatten();
    // The sheet: its size, and its pixels when they are not in the atlas.
    // rust: let (sw, sh, sheet) = match in_atlas {
    // rust: Some(rect) => {
    // rust: let (w, h) = rect.texels(atlas);
    // rust: (w, h, None)
}
    // rust: None => match crate::hud::decode(&root.join(resource_path(file, "textures", ""))) {
    // rust: Ok((w, h, rgba)) => (w, h, Some(Arc::new((w, rgba)))),
    // rust: Err(_) => {
    // rust: log::warn!("font sheet {file} could not be read");
    // rust: return out;
}
    // rust: },
}
    // rust: let rows: Vec<Vec<char>> = p["chars"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(|r| r.as_str().map(|s| s.chars().collect()))
    // rust: .collect();
    // rust: if rows.is_empty() || rows[0].is_empty() {
    // rust: return out;
}
    // rust: let cell_w = sw / rows[0].len() as u32;
    // rust: let cell_h = sh / rows.len() as u32;
    // rust: let height = p["height"].as_f64().unwrap_or(8.0) as f32;
    // rust: let ascent = p["ascent"].as_f64().unwrap_or(7.0) as f32;
    // rust: let scale = height / cell_h as f32;
    // rust: let origin = in_atlas.map_or((0, 0), |rect| {
    // rust: (
    // rust: (rect.u0 * atlas.0 as f32).round() as u32,
    // rust: (rect.v0 * atlas.1 as f32).round() as u32,
    // rust: )
    // rust: });
    // rust: for (r, row) in rows.iter().enumerate() {
    // rust: for (c, ch) in row.iter().enumerate() {
    // rust: if *ch == '\0' || out.contains_key(ch) {
    // rust: continue;
}
    // rust: let (x, y) = (c as u32 * cell_w, r as u32 * cell_h);
    // rust: let used = match &sheet {
    // rust: Some(s) => used_width(&s.1, s.0, (x, y, cell_w, cell_h)),
    // rust: None => used_width(
    // rust: pixels,
    // rust: atlas.0,
    // rust: (origin.0 + x, origin.1 + y, cell_w, cell_h),
    // rust: ),
}
    // rust: let top = 7.0 - ascent;
    // rust: let glyph = Glyph {
    // rust: rect: None,
    // rust: left: 0.0,
    // rust: top,
    // rust: right: cell_w as f32 * scale,
    // rust: bottom: top + cell_h as f32 * scale,
    // rust: advance: (0.5 + used as f32 * scale).floor() + 1.0,
    // rust: offset: 1.0,
}
    // rust: if metrics_only {
    // rust: out.insert(*ch, BitmapGlyph::Atlas(glyph));
    // rust: continue;
}
    // rust: let glyph = match &sheet {
    // rust: None => BitmapGlyph::Atlas(Glyph {
    // rust: rect: Some(glyph_rect(
    // rust: origin.0 + x,
    // rust: origin.1 + y,
    // rust: cell_w,
    // rust: cell_h,
    // rust: atlas,
    // rust: )),
    // rust: ..glyph
    // rust: }),
    // rust: Some(s) => BitmapGlyph::Sheet(SheetCell {
    // rust: sheet: s.clone(),
    // rust: x,
    // rust: y,
    // rust: w: cell_w,
    // rust: h: cell_h,
    // rust: glyph,
    // rust: }),
}
    // rust: out.insert(*ch, glyph);
}
}
    // rust: out
}
/// `TrueTypeGlyphProviderDefinition.load`: a TrueType file (not CFF) under
/// `font/`, its Unicode characters but the `skip` ones.
pub fn load_true_type(root: *Path, p: *serde_json::Value) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let file = p["file"].as_str()?;
    // rust: let data = std::fs::read(root.join(resource_path(file, "font", "")))
    // rust: .map_err(|e| log::warn!("font file {file}: {e}"))
    // rust: .ok()?;
    // FT_Get_Font_Format must say TrueType: CFF outlines ("OTTO") are refused.
    // rust: if data.starts_with(b"OTTO") {
    // rust: log::warn!("font file {file} is not in TTF format");
    // rust: return None;
}
    // rust: let font = ab_glyph::FontVec::try_from_vec(data)
    // rust: .map_err(|e| log::warn!("font file {file}: {e}"))
    // rust: .ok()?;
    // rust: let size = p["size"].as_f64().unwrap_or(11.0) as f32;
    // rust: let oversample = p["oversample"].as_f64().unwrap_or(1.0) as f32;
    // rust: let shift = p["shift"].as_array().map_or((0.0, 0.0), |s| {
    // rust: let f = |i: usize| s.get(i).and_then(|v| v.as_f64()).unwrap_or(0.0) as f32;
    // rust: (f(0), f(1))
    // rust: });
    // rust: let skip: Vec<char> = match &p["skip"] {
    // rust: serde_json::Value::String(s) => s.chars().collect(),
    // rust: serde_json::Value::Array(a) => a
    // rust: .iter()
    // rust: .filter_map(|v| v.as_str())
    // rust: .flat_map(str::chars)
    // rust: .collect(),
    // rust: _ => Vec::new(),
}
    // rust: let ids = font
    // rust: .codepoint_ids()
    // rust: .filter(|(id, c)| id.0 != 0 && !skip.contains(c))
    // rust: .map(|(id, c)| (c, id))
    // rust: .collect();
    // rust: let pixels_per_em = (size * oversample).round();
    // ab_glyph scales by the font's height; FreeType by its em.
    // rust: let units = font.units_per_em().unwrap_or(1000.0);
    // rust: let scale = ab_glyph::PxScale::from(pixels_per_em * font.height_unscaled() / units);
    // rust: Some(TrueType {
    // rust: font,
    // rust: ids,
    // rust: scale,
    // rust: oversample,
    // rust: shift: (shift.0 * oversample, shift.1 * oversample),
    // rust: })
}
    // rust: impl TrueType {
    /// The advance in GUI pixels: hinted FreeType advances are whole
    /// oversampled pixels.
pub fn advance(self: *Self, id: ab_glyph::GlyphId) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.font.as_scaled(self.scale).h_advance(id).round() / self.oversample
}
    /// `loadGlyph` and its bitmap: the grey coverage as `rrrr` texels
    /// (`text_intensity`), below 0.1 cut (its discard).
pub fn glyph(self: *Self, id: ab_glyph::GlyphId) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let advance = self.advance(id);
    // rust: let glyph =
    // rust: id.with_scale_and_position(self.scale, ab_glyph::point(self.shift.0, self.shift.1));
    // rust: let empty = Glyph {
    // rust: rect: None,
    // rust: left: 0.0,
    // rust: top: 0.0,
    // rust: right: 0.0,
    // rust: bottom: 0.0,
    // rust: advance,
    // rust: offset: 1.0,
}
    // rust: let Some(outline) = self.font.outline_glyph(glyph) else {
    // rust: return (empty, None);
}
    // rust: let bounds = outline.px_bounds();
    // rust: let (w, h) = (bounds.width() as u32, bounds.height() as u32);
    // rust: if w == 0 || h == 0 {
    // rust: return (empty, None);
}
    // rust: let mut rgba = vec![0u8; (w * h * 4) as usize];
    // rust: outline.draw(|x, y, coverage| {
    // rust: let v = if coverage < 0.1 {
    // rust: 0
    // rust: } else {
    // rust: (coverage.min(1.0) * 255.0).round() as u8
}
    // rust: let i = ((y * w + x) * 4) as usize;
    // rust: if let Some(px) = rgba.get_mut(i..i + 4) {
    // rust: px.copy_from_slice(&[v; 4]);
}
    // rust: });
    // rust: let os = self.oversample;
        // GlyphBitmap: bitmap_left / bitmap_top over the oversampling, and
        // top = 7 - bearingTop.
    // rust: let (left, top) = (bounds.min.x / os, 7.0 + bounds.min.y / os);
    // rust: (
    // rust: Glyph {
    // rust: rect: None,
    // rust: left,
    // rust: top,
    // rust: right: left + w as f32 / os,
    // rust: bottom: top + h as f32 / os,
    // rust: advance,
    // rust: offset: 1.0,
    // rust: },
    // rust: Some((w, h, rgba)),
    // rust: )
}
}
pub fn load_hex(root: *Path, p: *serde_json::Value) H {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut glyphs = HashMap::new();
    // rust: let Some(file) = p["hex_file"].as_str() else {
    // rust: return glyphs;
}
    // rust: let path = root.join(resource_path(file, "", "").replace("//", "/"));
    // rust: let Ok(zip) = Zip::open(&path) else {
    // rust: return glyphs;
}
    // rust: let names: Vec<String> = zip
    // rust: .names()
    // rust: .filter(|n| n.ends_with(".hex"))
    // rust: .map(str::to_owned)
    // rust: .collect();
    // rust: for name in names {
    // rust: if let Ok(bytes) = zip.read(&name) {
    // rust: parse_hex(&bytes, &mut glyphs);
}
}
    // rust: for o in p["size_overrides"].as_array().into_iter().flatten() {
    // rust: let bound = |k: &str| {
    // rust: o[k].as_str()
    // rust: .and_then(|s| s.chars().next())
    // rust: .map_or(0, u32::from)
}
    // rust: let (left, right) = (
    // rust: o["left"].as_u64().unwrap_or(0) as u32,
    // rust: o["right"].as_u64().unwrap_or(15) as u32,
    // rust: );
    // rust: for c in bound("from")..=bound("to") {
    // rust: if let Some(g) = glyphs.get_mut(&c) {
    // rust: g.left = left;
    // rust: g.right = right;
}
}
}
    // rust: glyphs
}
/// The ids of every font definition (`font/**/*.json` of each namespace).
pub fn font_ids(root: *Path) V {
    // Implementation ported from Horizon
    return undefined;
}
pub fn walk(dir: *Path, prefix: []const u8, out: *mut std.ArrayList([]const u8)) void {
}
    // rust: for entry in std::fs::read_dir(dir).into_iter().flatten().flatten() {
    // rust: let path = entry.path();
    // rust: let name = entry.file_name().to_string_lossy().into_owned();
    // rust: if path.is_dir() {
    // rust: walk(&path, &format!("{prefix}{name}/"), out);
    // rust: } else if let Some(stem) = name.strip_suffix(".json") {
    // rust: out.push(format!("{prefix}{stem}"));
}
}
}
    // rust: let mut ids = Vec::new();
    // rust: for ns in std::fs::read_dir(root.join("assets"))
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .flatten()
    // rust: {
    // rust: let ns = ns.file_name().to_string_lossy().into_owned();
    // rust: walk(
    // rust: &root.join("assets").join(&ns).join("font"),
    // rust: &format!("{ns}:"),
    // rust: &mut ids,
    // rust: );
}
    // rust: ids.sort();
    // rust: ids
}
    // rust: impl Region {
    /// Place `w x h` pixels in the region (rows left to right); their atlas
    /// position, or none when it is full.
    // rust: fn place(
    // rust: &mut self,
    // rust: w: u32,
    // rust: h: u32,
    // rust: rgba: Vec<u8>,
    // rust: atlas: (u32, u32),
    // rust: region: (u32, u32),
    // rust: ) -> Option<(u32, u32)> {
    // rust: let (mut x, mut y) = self.cursor;
    // rust: if x + w + 1 > atlas.0 {
    // rust: x = 0;
    // rust: y += self.row + 1;
    // rust: self.row = 0;
}
    // rust: if y + h > region.1 {
    // rust: self.full = true;
    // rust: return None;
}
    // rust: let (ax, ay) = (x, region.0 + y);
    // rust: self.pending.push(Patch {
    // rust: x: ax,
    // rust: y: ay,
    // rust: width: w,
    // rust: height: h,
    // rust: rgba,
    // rust: });
    // rust: self.cursor = (x + w + 1, y);
    // rust: self.row = self.row.max(h);
    // rust: Some((ax, ay))
}
}
/// A value no font has had yet (`Font::epoch`).
pub fn next_generation() u {
    // Implementation ported from Horizon
    return undefined;
}
pub const NEXT: std::sync::atomic::AtomicU64 = std::sync::atomic::AtomicU64::new(0);
    // rust: NEXT.fetch_add(1, std::sync::atomic::Ordering::Relaxed)
}
    // rust: impl Font {
    /// Build from the atlas holding the bitmap font sheets (`sprites`, of
    /// `atlas` size) with `region` the reserved rows.
    // rust: pub fn load(
    // rust: root: &Path,
    // rust: sprites: &HashMap<String, Rect>,
    // rust: pixels: &[u8],
    // rust: atlas: (u32, u32),
    // rust: region: (u32, u32),
    // rust: white: Rect,
    // rust: ) -> Self {
    // rust: Self::load_with(root, sprites, pixels, atlas, region, white, false)
}
    /// A server measures text but never draws it. Decode bitmap sheets only
    /// to obtain advances, then release their pixels; never rasterize glyphs.
pub fn metrics(root: *Path) S {
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
    // rust: Self::load_with(root, &HashMap::new(), &[], (1, 1), (0, 0), white, true)
}
    // rust: fn load_with(
    // rust: root: &Path,
    // rust: sprites: &HashMap<String, Rect>,
    // rust: pixels: &[u8],
    // rust: atlas: (u32, u32),
    // rust: region: (u32, u32),
    // rust: white: Rect,
    // rust: metrics_only: bool,
    // rust: ) -> Self {
    // rust: let sheets = sprites
    // rust: .iter()
    // rust: .filter(|(k, _)| k.starts_with("font/"))
    // rust: .map(|(k, v)| (k.clone(), *v))
    // rust: .collect();
    // rust: let font = Self {
    // rust: sheets,
    // rust: missing: Glyph {
    // rust: rect: None,
    // rust: left: 0.0,
    // rust: top: 0.0,
    // rust: right: 5.0,
    // rust: bottom: 8.0,
    // rust: advance: 6.0,
    // rust: offset: 1.0,
    // rust: },
    // rust: white,
    // rust: root: root.to_owned(),
    // rust: atlas,
    // rust: region,
    // rust: metrics_only,
    // rust: cache: RefCell::new(Cache {
    // rust: sets: Vec::new(),
    // rust: region: Region {
    // rust: cursor: (0, 0),
    // rust: row: 0,
    // rust: pending: Vec::new(),
    // rust: full: false,
    // rust: },
    // rust: random: horizon_core::random::LegacyRandom::new(
    // rust: std::time::SystemTime::now()
    // rust: .duration_since(std::time::UNIX_EPOCH)
    // rust: .map_or(0, |d| d.as_nanos() as i64),
    // rust: ),
    // rust: }),
    // rust: generation: std::cell::Cell::new(next_generation()),
    // rust: uniform: false,
    // rust: japanese: false,
}
        // FontManager.prepare: every font definition of the resources.
    // rust: let mut ids = font_ids(root);
    // rust: ids.sort_by_key(|id| id != DEFAULT);
    // rust: let sets = ids
    // rust: .into_iter()
    // rust: .map(|id| {
    // rust: let set = font.load_set(&id, pixels);
    // rust: (id, set)
    // rust: })
    // rust: .collect();
    // rust: font.cache.borrow_mut().sets = sets;
    // rust: font
}
    /// `FontManager`: a font's providers with references expanded.
pub fn load_set(self: *Self, id: []const u8, pixels: []const u8) F {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut all = Vec::new();
    // rust: providers(&self.root, id, 0, &mut all);
    // rust: let providers = all
    // rust: .iter()
    // rust: .filter_map(|p| match p["type"].as_str()? {
    // rust: "space" => Some(Provider::Space(
    // rust: p["advances"]
    // rust: .as_object()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(|(k, v)| Some((k.chars().next()?, v.as_f64()? as f32)))
    // rust: .collect(),
    // rust: )),
    // rust: "bitmap" => Some(Provider::Bitmap(
    // rust: Filter::of(p),
    // rust: load_bitmap(
    // rust: &self.root,
    // rust: p,
    // rust: &self.sheets,
    // rust: pixels,
    // rust: self.atlas,
    // rust: self.metrics_only,
    // rust: ),
    // rust: )),
    // rust: "unihex" => Some(Provider::Unihex(Filter::of(p), p.clone(), None)),
    // rust: "ttf" => Some(Provider::TrueType(
    // rust: Filter::of(p),
    // rust: Box::new(load_true_type(&self.root, p)?),
    // rust: )),
    // rust: _ => None,
    // rust: })
    // rust: .collect();
    // rust: FontSet {
    // rust: providers,
    // rust: glyphs: Default::default(),
    // rust: non_fishy: Default::default(),
    // rust: by_width: None,
}
}
    /// Forget rasterized glyphs (after changing font options).
pub fn reset_cache(self: *Self) void {
}
    // rust: let mut cache = self.cache.borrow_mut();
    // rust: for (_, set) in &mut cache.sets {
    // rust: set.glyphs.clear();
    // rust: set.non_fishy.clear();
    // rust: set.by_width = None;
}
    // rust: cache.region.cursor = (0, 0);
    // rust: cache.region.row = 0;
    // rust: cache.region.full = false;
    // rust: self.generation.set(next_generation());
}
    /// Call once per frame before any text is laid out. When the dynamic
    /// region ran out of room (vanilla's glyph textures grow instead), the
    /// glyphs are forgotten so they are rasterized again from the start; it
    /// waits for the frame boundary because quads already queued hold the old
    /// rects.
pub fn begin_frame(self: *Self) void {
}
    // rust: if self.cache.borrow().region.full {
    // rust: self.reset_cache();
}
}
    /// Changes whenever a glyph may come out different: another font, a
    /// cache reset (glyphs move in the atlas) or other font options. Text laid
    /// out under one epoch can be kept until it changes.
pub fn epoch(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.generation.get() << 2 | u64::from(self.uniform) << 1 | u64::from(self.japanese)
}
    /// The glyph for a character in the default font (FontSet.getGlyph).
pub fn glyph(self: *Self, c: char) G {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.glyph_of(DEFAULT, c)
}
    /// The glyph for a character drawn in `style`'s font (its id is
    /// already complete, see `text::font_id`).
pub fn glyph_styled(self: *Self, c: char, style: *Style) G {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.glyph_of(style.font.as_deref().unwrap_or(DEFAULT), c)
}
    /// The glyph for a character in the font `id` (`alt` is `minecraft:alt`).
pub fn glyph_in(self: *Self, id: []const u8, c: char) G {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if id.contains(':') {
    // rust: self.glyph_of(id, c)
    // rust: } else {
    // rust: self.glyph_of(&format!("minecraft:{id}"), c)
}
}
    /// The first active provider's glyph, else the missing glyph.
pub fn glyph_of(self: *Self, id: []const u8, c: char) G {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut cache = self.cache.borrow_mut();
    // rust: let Cache { sets, region, .. } = &mut *cache;
        // FontManager.getFontSetRaw: a font that doesn't exist draws every
        // character as the missing glyph.
    // rust: let Some((_, set)) = sets.iter_mut().find(|(k, _)| k == id) else {
    // rust: return self.missing;
}
    // rust: if let Some(g) = set.glyphs.get(&c) {
    // rust: return *g;
}
    // rust: let was_full = std::mem::replace(&mut region.full, false);
    // rust: let found = self.resolve(set, region, c, false);
        // No room: the missing glyph for now, not remembered, so the
        // character is tried again once `begin_frame` cleared the region.
    // rust: let overflowed = std::mem::replace(&mut region.full, was_full);
    // rust: region.full |= overflowed;
    // rust: if overflowed {
    // rust: return self.missing;
}
    // rust: let glyph = found.unwrap_or(self.missing);
    // rust: set.glyphs.insert(c, glyph);
    // rust: glyph
}
    /// `FontSet.getRandomGlyph`'s `SelectedGlyphs.nonFishy`: the glyph of the first provider whose
    /// advance is not fishy, else the missing glyph. A character whose first glyph is fine has
    /// the same one for both.
pub fn glyph_non_fishy(self: *Self, id: []const u8, c: char) G {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let any = self.glyph_of(id, c);
    // rust: if !fishy_advance(any.advance) {
    // rust: return any;
}
    // rust: let mut cache = self.cache.borrow_mut();
    // rust: let Cache { sets, region, .. } = &mut *cache;
    // rust: let Some((_, set)) = sets.iter_mut().find(|(k, _)| k == id) else {
    // rust: return self.missing;
}
    // rust: if let Some(g) = set.non_fishy.get(&c) {
    // rust: return *g;
}
    // rust: let was_full = std::mem::replace(&mut region.full, false);
    // rust: let found = self.resolve(set, region, c, true);
    // rust: let overflowed = std::mem::replace(&mut region.full, was_full);
    // rust: region.full |= overflowed;
    // rust: if overflowed {
    // rust: return self.missing;
}
    // rust: let glyph = found.unwrap_or(self.missing);
    // rust: set.non_fishy.insert(c, glyph);
    // rust: glyph
}
    // rust: fn resolve(
    // rust: &self,
    // rust: set: &mut FontSet,
    // rust: region: &mut Region,
    // rust: c: char,
    // rust: non_fishy: bool,
    // rust: ) -> Option<Glyph> {
    // rust: let (uniform, japanese) = (self.uniform, self.japanese);
    // rust: for provider in &mut set.providers {
    // rust: match provider {
    // rust: Provider::Space(advances) => {
    // rust: if let Some(a) = advances.get(&c)
    // rust: && !(non_fishy && fishy_advance(*a))
    // rust: {
    // rust: return Some(Glyph {
    // rust: rect: None,
    // rust: left: 0.0,
    // rust: top: 0.0,
    // rust: right: 0.0,
    // rust: bottom: 0.0,
    // rust: advance: *a,
    // rust: offset: 1.0,
    // rust: });
}
}
    // rust: Provider::Bitmap(filter, glyphs) if filter.passes(uniform, japanese) => {
    // rust: match glyphs.get(&c) {
    // rust: Some(BitmapGlyph::Atlas(g)) if !(non_fishy && fishy_advance(g.advance)) => {
    // rust: return Some(*g);
}
    // rust: Some(BitmapGlyph::Sheet(cell))
    // rust: if !(non_fishy && fishy_advance(cell.glyph.advance)) =>
    // rust: {
    // rust: let (stride, pixels) = (&cell.sheet.0, &cell.sheet.1);
    // rust: let mut rgba = Vec::with_capacity((cell.w * cell.h * 4) as usize);
    // rust: for y in cell.y..cell.y + cell.h {
    // rust: let at = ((y * stride + cell.x) * 4) as usize;
    // rust: rgba.extend_from_slice(&pixels[at..at + (cell.w * 4) as usize]);
}
    // rust: let (x, y) =
    // rust: region.place(cell.w, cell.h, rgba, self.atlas, self.region)?;
    // rust: return Some(Glyph {
    // rust: rect: Some(glyph_rect(x, y, cell.w, cell.h, self.atlas)),
    // rust: ..cell.glyph
    // rust: });
}
    // rust: _ => {}
}
}
    // rust: Provider::Unihex(filter, def, glyphs) if filter.passes(uniform, japanese) => {
    // rust: let glyphs = glyphs.get_or_insert_with(|| load_hex(&self.root, def));
    // rust: if let Some(h) = glyphs.get(&u32::from(c)).copied()
    // rust: && !(non_fishy && fishy_advance(hex_advance(&h)))
    // rust: {
    // rust: return self.rasterize_hex(region, h);
}
}
    // rust: Provider::TrueType(filter, ttf) if filter.passes(uniform, japanese) => {
    // rust: if let Some(id) = ttf.ids.get(&c)
    // rust: && !(non_fishy && fishy_advance(ttf.advance(*id)))
    // rust: {
    // rust: if self.metrics_only {
    // rust: return Some(Glyph {
    // rust: rect: None,
    // rust: advance: ttf.advance(*id),
    // rust: offset: 1.0,
    // rust: ..self.missing
    // rust: });
}
    // rust: let (glyph, bitmap) = ttf.glyph(*id);
    // rust: return match bitmap {
    // rust: Some((w, h, rgba)) => {
    // rust: let (x, y) = region.place(w, h, rgba, self.atlas, self.region)?;
    // rust: Some(Glyph {
    // rust: rect: Some(glyph_rect(x, y, w, h, self.atlas)),
    // rust: ..glyph
    // rust: })
}
    // rust: None => Some(glyph),
}
}
}
    // rust: _ => {}
}
}
    // rust: None
}
pub fn rasterize_hex(self: *Self, region: *mut Region, h: HexGlyph) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let width = h.right.saturating_sub(h.left) + 1;
    // rust: if self.metrics_only {
    // rust: return Some(Glyph {
    // rust: rect: None,
    // rust: left: 0.0,
    // rust: top: 0.0,
    // rust: right: width as f32 / 2.0,
    // rust: bottom: 8.0,
    // rust: advance: hex_advance(&h),
    // rust: offset: 0.5,
    // rust: });
}
    // rust: let mut rgba = Vec::with_capacity((width * 16 * 4) as usize);
    // rust: for row in h.rows {
    // rust: for bit in h.left..=h.right {
    // rust: let set = bit < 32 && (row >> (31 - bit)) & 1 != 0;
    // rust: rgba.extend(if set { [255; 4] } else { [0; 4] });
}
}
    // rust: let (x, y) = region.place(width, 16, rgba, self.atlas, self.region)?;
    // rust: Some(Glyph {
    // rust: rect: Some(glyph_rect(x, y, width, 16, self.atlas)),
    // rust: left: 0.0,
    // rust: top: 0.0,
    // rust: right: width as f32 / 2.0,
    // rust: bottom: 8.0,
    // rust: advance: hex_advance(&h),
    // rust: offset: 0.5,
    // rust: })
}
    /// Starts the random `random_glyph` draws on over from `seed`.
pub fn reseed(self: *Self, seed: i64) void {
}
    // rust: self.cache.borrow_mut().random = horizon_core::random::LegacyRandom::new(seed);
}
    /// `FontSet.getRandomGlyph`: what an obfuscated character draws, a random
    /// glyph of the font as wide as `advance` (rounded up), else the missing
    /// glyph.
    ///
    /// Vanilla picks among every glyph of the font set, Unifont's included.
    /// Those are rasterized into a fixed atlas region on demand, which a
    /// line of obfuscated text would fill in seconds, so the candidates are
    /// the glyphs already in the atlas (the bitmap sheets there and spaces),
    /// or for a font without any (Force Unicode Font, a TrueType font) its
    /// glyphs below U+0250.
pub fn random_glyph(self: *Self, style: *Style, advance: f32) G {
    // Implementation ported from Horizon
    return undefined;
}
//         use horizon_core::random::RandomSource;
    // rust: let id = style.font.as_deref().unwrap_or(DEFAULT);
    // rust: let width = advance.ceil() as i32;
    // rust: let pick = {
    // rust: let mut cache = self.cache.borrow_mut();
    // rust: let Cache { sets, random, .. } = &mut *cache;
    // rust: let Some((_, set)) = sets.iter_mut().find(|(k, _)| k == id) else {
    // rust: return self.missing;
}
    // rust: if set.by_width.is_none() {
    // rust: set.by_width = Some(self.glyphs_by_width(set));
}
    // rust: set.by_width
    // rust: .as_ref()
    // rust: .and_then(|m| m.get(&width))
    // rust: .and_then(|chars| {
    // rust: let i = random.next_int_bound(chars.len() as i32).ok()?;
    // rust: chars.get(i as usize).copied()
    // rust: })
}
    // rust: pick.map_or(self.missing, |c| self.glyph_non_fishy(id, c))
}
pub fn glyphs_by_width(self: *Self, set: *mut FontSet) H {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (uniform, japanese) = (self.uniform, self.japanese);
    // rust: let mut chars = std::collections::BTreeSet::new();
    // rust: let mut in_atlas = false;
    // rust: for provider in &set.providers {
    // rust: match provider {
    // rust: Provider::Space(advances) => chars.extend(advances.keys().copied()),
    // rust: Provider::Bitmap(filter, glyphs) if filter.passes(uniform, japanese) => {
    // rust: for (c, g) in glyphs {
    // rust: if matches!(g, BitmapGlyph::Atlas(_)) {
    // rust: in_atlas = true;
    // rust: chars.insert(*c);
}
}
}
    // rust: _ => {}
}
}
    // rust: if !in_atlas {
            // Nothing in the atlas: the glyphs below U+0250, rasterized as used.
    // rust: chars.extend((0..0x250u32).filter_map(char::from_u32));
}
    // rust: let mut out: HashMap<i32, Vec<char>> = HashMap::new();
    // rust: for c in chars {
    // rust: if let Some(advance) = self.provider_advance(set, c) {
    // rust: out.entry(advance.ceil() as i32).or_default().push(c);
}
}
    // rust: out
}
    /// A character's advance in `set` (its first provider that has it, fishy or not, as the
    /// by-width table of `FontSet.reload` takes it), without rasterizing it.
pub fn provider_advance(self: *Self, set: *mut FontSet, c: char) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (uniform, japanese) = (self.uniform, self.japanese);
    // rust: for provider in &mut set.providers {
    // rust: match provider {
    // rust: Provider::Space(advances) => {
    // rust: if let Some(a) = advances.get(&c) {
    // rust: return Some(*a);
}
}
    // rust: Provider::Bitmap(filter, glyphs) if filter.passes(uniform, japanese) => {
    // rust: match glyphs.get(&c) {
    // rust: Some(BitmapGlyph::Atlas(g)) => {
    // rust: return Some(g.advance);
}
    // rust: Some(BitmapGlyph::Sheet(cell)) => {
    // rust: return Some(cell.glyph.advance);
}
    // rust: _ => {}
}
}
    // rust: Provider::Unihex(filter, def, glyphs) if filter.passes(uniform, japanese) => {
    // rust: let glyphs = glyphs.get_or_insert_with(|| load_hex(&self.root, def));
    // rust: if let Some(h) = glyphs.get(&u32::from(c)) {
    // rust: return Some(hex_advance(h));
}
}
    // rust: Provider::TrueType(filter, ttf) if filter.passes(uniform, japanese) => {
    // rust: if let Some(id) = ttf.ids.get(&c) {
    // rust: return Some(ttf.advance(*id));
}
}
    // rust: _ => {}
}
}
    // rust: None
}
    /// Atlas pixels rasterized since the last call.
pub fn take_patches(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::mem::take(&mut self.cache.borrow_mut().region.pending)
}
pub fn advance(self: *Self, c: char, style: *Style) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if c == '\u{fffc}' && style.inline_object.is_some() {
    // rust: return 8.0;
}
    // rust: let g = self.glyph_styled(c, style);
    // rust: g.advance + if style.is_bold() { g.offset } else { 0.0 }
}
    /// Font.width of plain text (legacy codes are formatting, not glyphs).
pub fn width(self: *Self, s: []const u8) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if s.contains('§') {
    // rust: return self.width_text(&Text::legacy(s));
}
    // rust: crate::bidi::visual_str(s)
    // rust: .chars()
    // rust: .map(|c| self.glyph(c).advance)
    // rust: .sum::<f32>()
    // rust: .ceil()
}
    /// Font.width of a component: `§` codes in the spans are formatting,
    /// not glyphs. Right-to-left text is measured as it is drawn, shaped.
pub fn width_text(self: *Self, t: *Text) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let t = t.resolved();
    // rust: crate::bidi::visual(&t)
    // rust: .chars()
    // rust: .map(|(c, s)| self.advance(c, s))
    // rust: .sum::<f32>()
    // rust: .ceil()
}
    /// `Font.width(FormattedCharSequence)` of a sequence a component built
    /// with `FormattedCharSequence.forward`: every character is a glyph, a
    /// `§` included (`StringDecomposer.iterate`, not `iterateFormatted`).
pub fn width_drawn(self: *Self, t: *Text) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: crate::bidi::visual(t)
    // rust: .chars()
    // rust: .map(|(c, s)| self.advance(c, s))
    // rust: .sum::<f32>()
    // rust: .ceil()
}
    /// `StringSplitter.splitLines`: each line and whether it continues a
    /// wrapped one. A line breaks at a `\n`, or once a character overflows
    /// `max_width` (never the first visible one) at the last space so far, or
    /// before that character; the `\n` or space at the break is dropped.
pub fn split_lines(self: *Self, t: *Text, max_width: f32) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let max_width = max_width.max(1.0);
    // rust: let chars: Vec<(char, &Style)> = t.chars().collect();
    // rust: let n = chars.len();
    // rust: let mut out = Vec::new();
    // rust: let (mut start, mut wrapped, mut force_new_line) = (0, false, false);
    // rust: loop {
            // LineBreakFinder over what is left.
    // rust: let (mut width, mut had_visible, mut last_space) = (0.0f32, false, None);
    // rust: let mut split = None;
    // rust: for (i, &(c, style)) in chars.iter().enumerate().skip(start) {
    // rust: if c == '\n' {
    // rust: split = Some(i);
    // rust: break;
}
    // rust: if c == ' ' {
    // rust: last_space = Some(i);
}
    // rust: let advance = self.advance(c, style);
    // rust: width += advance;
    // rust: if !had_visible || width <= max_width {
    // rust: had_visible |= advance != 0.0;
    // rust: } else {
    // rust: split = Some(last_space.unwrap_or(i));
    // rust: break;
}
}
    // rust: let Some(at) = split else { break };
    // rust: let new_line = chars[at].0 == '\n';
    // rust: let skip = usize::from(new_line || chars[at].0 == ' ');
    // rust: force_new_line = new_line;
    // rust: out.push((t.slice(start, at), wrapped));
    // rust: wrapped = !new_line;
    // rust: start = at + skip;
}
    // rust: if start < n {
    // rust: out.push((t.slice(start, n), wrapped));
    // rust: } else if force_new_line {
    // rust: out.push((Text::empty(), false));
}
    // rust: out
}
    /// `Font.split`: `StringSplitter.splitLines(text, width, Style.EMPTY)` over
    /// the text's parts with their `§` codes in. A code styles what follows
    /// (`§r` back to no style while measuring), and the part a line breaks in
    /// goes on in the style at the break. Lines keep their codes for drawing.
pub fn split_formatted(self: *Self, t: *Text, max_width: f32) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let max_width = max_width.max(1.0);
    // rust: let mut parts: Vec<(Vec<char>, Style)> = t
    // rust: .spans
    // rust: .iter()
    // rust: .filter(|s| !s.text.is_empty())
    // rust: .map(|s| (s.text.chars().collect(), s.style.clone()))
    // rust: .collect();
    // rust: let mut flat: Vec<char> = parts.iter().flat_map(|p| p.0.iter().copied()).collect();
    // rust: let mut out = Vec::new();
    // rust: let mut force_new_line = false;
        // One LineBreakFinder per line, over the parts left.
    // rust: while let Some((at, split_style)) = self.line_break(&parts, max_width) {
    // rust: let tail = flat[at];
    // rust: let new_line = tail == '\n';
    // rust: let skip = usize::from(new_line || tail == ' ');
    // rust: force_new_line = new_line;
    // rust: out.push(split_at(&mut parts, at, skip, &split_style));
    // rust: flat.drain(..at + skip);
}
    // rust: if !parts.is_empty() {
    // rust: let mut rest = Text::default();
    // rust: rest.spans = parts
    // rust: .into_iter()
    // rust: .map(|(text, style)| Span {
    // rust: text: text.into_iter().collect(),
    // rust: style,
    // rust: })
    // rust: .collect();
    // rust: out.push(rest);
    // rust: } else if force_new_line {
    // rust: out.push(Text::empty());
}
    // rust: out
}
    /// `StringSplitter.LineBreakFinder` fed by `StringDecomposer.iterateFormatted`:
    /// where the parts break (a character index) and the style there.
pub fn line_break(self: *Self, parts: *[(std.ArrayList(char)) void {
}
    // rust: let (mut width, mut had_visible, mut last_space) = (0.0f32, false, None);
    // rust: let mut offset = 0;
    // rust: for (contents, part_style) in parts {
    // rust: let mut style = part_style.clone();
    // rust: let mut i = 0;
    // rust: while i < contents.len() {
    // rust: let c = contents[i];
    // rust: if c == '§' {
                    // A `§` that ends its part ends only that part.
    // rust: let Some(&code) = contents.get(i + 1) else {
    // rust: break;
}
    // rust: style = legacy_format(&style, code, &Style::default());
    // rust: i += 2;
    // rust: continue;
}
    // rust: let at = offset + i;
    // rust: if c == '\n' {
    // rust: return Some((at, style));
}
    // rust: if c == ' ' {
    // rust: last_space = Some((at, style.clone()));
}
    // rust: let advance = self.advance(c, &style);
    // rust: width += advance;
    // rust: if had_visible && width > max_width {
    // rust: return Some(last_space.unwrap_or((at, style)));
}
    // rust: had_visible |= advance != 0.0;
    // rust: i += 1;
}
    // rust: offset += contents.len();
}
    // rust: None
}
    /// `ComponentRenderUtils.wrapComponents`: the split lines, wrapped ones
    /// indented by an unstyled space; one empty line for empty text.
pub fn wrap_components(self: *Self, t: *Text, max_width: i32) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let lines: Vec<Text> = self
    // rust: .split_lines(t, max_width as f32)
    // rust: .into_iter()
    // rust: .map(|(line, wrapped)| {
    // rust: if wrapped {
    // rust: Text::literal(" ").append(line)
    // rust: } else {
    // rust: line
}
    // rust: })
    // rust: .collect();
    // rust: if lines.is_empty() {
    // rust: vec![Text::empty()]
    // rust: } else {
    // rust: lines
}
}
    /// StringSplitter.splitLines: wrap at the last space that fits (or
    /// mid-word when none does); `\n` always breaks. Styles are kept.
pub fn split(self: *Self, t: *Text, max_width: f32) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let chars: Vec<(char, Style)> = t.chars().map(|(c, s)| (c, s.clone())).collect();
    // rust: let mut lines = Vec::new();
    // rust: let mut start = 0;
    // rust: while start < chars.len() {
    // rust: let mut width = 0.0;
    // rust: let mut end = chars.len();
    // rust: let mut next = chars.len();
    // rust: let mut last_space = None;
    // rust: for (i, (c, style)) in chars.iter().enumerate().skip(start) {
    // rust: if *c == '\n' {
    // rust: end = i;
    // rust: next = i + 1;
    // rust: break;
}
    // rust: if *c == ' ' {
    // rust: last_space = Some(i);
}
    // rust: width += self.advance(*c, style);
    // rust: if width > max_width {
    // rust: match last_space {
    // rust: Some(s) if s > start => {
    // rust: end = s;
    // rust: next = s + 1;
}
    // rust: _ => {
    // rust: end = i.max(start + 1);
    // rust: next = end;
}
}
    // rust: break;
}
}
    // rust: lines.push(t.slice(start, end));
    // rust: start = next;
    // rust: if start == chars.len() && chars.last().is_some_and(|c| c.0 == '\n') {
    // rust: lines.push(Text::empty());
}
}
    // rust: if lines.is_empty() {
    // rust: lines.push(Text::empty());
}
    // rust: lines
}
    /// Characters of `s` that fit in `width` (Font.plainSubstrByWidth).
pub fn fit(self: *Self, s: []const u8, width: f32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut w = 0.0;
    // rust: for (i, c) in s.chars().enumerate() {
    // rust: w += self.glyph(c).advance;
    // rust: if w > width {
    // rust: return i;
}
}
    // rust: s.chars().count()
}
    /// Characters of `s` that fit in `width`, measured from the end.
pub fn fit_reverse(self: *Self, s: []const u8, width: f32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut w = 0.0;
    // rust: for (i, c) in s.chars().rev().enumerate() {
    // rust: w += self.glyph(c).advance;
    // rust: if w > width {
    // rust: return i;
}
}
    // rust: s.chars().count()
}
pub fn white(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.white
}
}

/// `StringSplitter.FlatComponents.splitAt`: the parts before `at` as a line,
/// `skip` characters dropped, and the part it ends in restyled as `style`.
pub fn split_at(parts: *mut std.ArrayList((Vec<char)) void {
}
    // rust: let mut line = Text::default();
    // rust: let mut push = |text: &[char], style: &Style| {
    // rust: line.spans.push(Span {
    // rust: text: text.iter().collect(),
    // rust: style: style.clone(),
    // rust: })
}
    // Each part done is removed, so the one at hand is always the first.
    // rust: let (mut position, mut in_skip) = (at, false);
    // rust: while let Some((text, part_style)) = parts.first() {
    // rust: let size = text.len();
    // rust: if !in_skip {
    // rust: if position > size {
    // rust: push(text, part_style);
    // rust: parts.remove(0);
    // rust: position -= size;
    // rust: continue;
}
    // rust: if position > 0 {
    // rust: push(&text[..position], part_style);
}
    // rust: position += skip;
    // rust: in_skip = true;
}
    // rust: if position <= size {
    // rust: if position == size {
    // rust: parts.remove(0);
    // rust: } else {
    // rust: parts[0] = (text[position..].to_vec(), style.clone());
}
    // rust: break;
}
    // rust: parts.remove(0);
    // rust: position -= size;
}
    // rust: line
}

    // rust: mod tests {
//     use super::*;
pub fn unihex_rows_and_widths() void {
}
    // rust: let mut out = HashMap::new();
        // 'A' from unifont (8 wide) and a 16-wide glyph with an empty left column.
    // rust: let wide = format!("4E00:{}7FFE{}\n", "0000".repeat(4), "0000".repeat(11));
    // rust: parse_hex(b"0041:0000000018242442427E424242420000\n", &mut out);
    // rust: parse_hex(wide.as_bytes(), &mut out);
    // rust: let a = out[&0x41];
    // rust: assert_eq!((a.left, a.right), (1, 6));
    // rust: assert_eq!(a.rows[4], 0x18 << 24);
    // rust: let yi = out[&0x4E00];
    // rust: assert_eq!((yi.left, yi.right), (1, 14));
        // Unparseable lines are skipped.
    // rust: parse_hex(b"zz:00\n", &mut out);
    // rust: assert_eq!(out.len(), 2);
}

pub fn glyph_uvs_have_the_native_texel_inset() void {
}
    // rust: for (x, y, w, h) in [(120, 48, 8, 8), (0, 0, 1, 16), (4000, 2000, 32, 16)] {
    // rust: let r = glyph_rect(x, y, w, h, (4096, 4096));
    // rust: assert_eq!((r.w, r.h), (w, h));
    // rust: assert!(r.u0 > x as f32 / 4096.0 && r.v0 > y as f32 / 4096.0);
    // rust: assert!(r.u1 < (x + w) as f32 / 4096.0 && r.v1 < (y + h) as f32 / 4096.0);
    // rust: assert_eq!(r.u0, (x as f32 + 0.01) / 4096.0);
    // rust: assert_eq!(r.v1, ((y + h) as f32 - 0.01) / 4096.0);
}
}

    /// A resource root with these font definitions and files.
pub fn root(name: []const u8, files: *[([]const u8) void {
}
    // rust: let root = std::env::temp_dir().join(format!("horizon-font-{name}-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&root);
    // rust: for (path, bytes) in files {
    // rust: let path = root.join(path);
    // rust: std::fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: std::fs::write(path, bytes).unwrap();
}
    // rust: root
}
pub fn white() R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Rect {
    // rust: u0: 0.0,
    // rust: v0: 0.0,
    // rust: u1: 0.0,
    // rust: v1: 0.0,
    // rust: w: 1,
    // rust: h: 1,
}
}
pub fn load(root: *Path) F {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Font::load(
    // rust: root,
    // rust: &HashMap::new(),
    // rust: &[],
    // rust: (4096, 1024),
    // rust: (512, 512),
    // rust: white(),
    // rust: )
}
pub fn png(width: u32, height: u32, opaque: impl Fn(u32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut pixels = Vec::new();
    // rust: for y in 0..height {
    // rust: for x in 0..width {
    // rust: pixels.extend(if opaque(x, y) { [255; 4] } else { [0; 4] });
}
}
    // rust: let mut out = Vec::new();
    // rust: let mut encoder = png::Encoder::new(&mut out, width, height);
    // rust: encoder.set_color(png::ColorType::Rgba);
    // rust: encoder.set_depth(png::BitDepth::Eight);
    // rust: encoder
    // rust: .write_header()
    // rust: .unwrap()
    // rust: .write_image_data(&pixels)
    // rust: .unwrap();
    // rust: out
}

pub fn server_metrics_preserve_bitmap_true_type_and_unihex_advances() void {
}
    // rust: let sheet = png(16, 8, |x, _| x < 2 || (8..14).contains(&x));
    // rust: let def = br#"{"providers":[{"type":"space","advances":{" ":4}},{"type":"bitmap","file":"minecraft:font/a.png","ascent":7,"chars":["ab"]}]}"#;
    // rust: let ttf = br#"{"providers":[{"type":"ttf","file":"minecraft:mono.ttf","size":11,"oversample":2}]}"#;
    // rust: let root = root(
    // rust: "metrics",
    // rust: &[
    // rust: ("assets/minecraft/font/default.json", def),
    // rust: ("assets/minecraft/font/alt.json", ttf),
    // rust: (
    // rust: "assets/minecraft/font/mono.ttf",
    // rust: horizon_theme::fonts::GEIST_MONO,
    // rust: ),
    // rust: ("assets/minecraft/textures/font/a.png", &sheet),
    // rust: ],
    // rust: );
    // rust: let rendered = load(&root);
    // rust: let metrics = Font::metrics(&root);
    // rust: assert_eq!(metrics.width("a b"), 14.0);
    // rust: assert_eq!(metrics.width("§lab"), 12.0);
    // rust: let text = Text::literal("ab ab");
    // rust: assert_eq!(
    // rust: metrics.split_formatted(&text, 10.0),
    // rust: rendered.split_formatted(&text, 10.0)
    // rust: );
    // rust: let alt = Style {
    // rust: font: Some("minecraft:alt".into()),
    // rust: bold: Some(true),
    // rust: ..Style::default()
}
    // rust: for c in ['A', 'i', ' ', '\u{fffd}'] {
    // rust: assert_eq!(metrics.advance(c, &alt), rendered.advance(c, &alt));
    // rust: assert!(metrics.glyph_styled(c, &alt).rect.is_none());
}
    // rust: let mut hex = HashMap::new();
    // rust: parse_hex(b"0041:0000000018242442427E424242420000\n", &mut hex);
    // rust: let h = hex[&0x41];
    // rust: let glyph = metrics
    // rust: .rasterize_hex(&mut metrics.cache.borrow_mut().region, h)
    // rust: .unwrap();
    // rust: assert_eq!(glyph.advance, 4.0);
    // rust: assert_eq!(glyph.offset, 0.5);
    // rust: assert!(glyph.rect.is_none());
    // rust: assert!(metrics.take_patches().is_empty());
    // rust: assert!(!rendered.take_patches().is_empty());
    // rust: let _ = std::fs::remove_dir_all(root);
}

pub fn true_type_glyphs_are_rasterized_at_the_provider_size() void {
}
    // rust: let def = br#"{"providers":[{"type":"ttf","file":"minecraft:mono.ttf","size":11,"oversample":2,"shift":[0.5,1],"skip":["B"]}]}"#;
    // rust: let root = root(
    // rust: "ttf",
    // rust: &[
    // rust: ("assets/minecraft/font/default.json", def),
    // rust: (
    // rust: "assets/minecraft/font/mono.ttf",
    // rust: horizon_theme::fonts::GEIST_MONO,
    // rust: ),
    // rust: ],
    // rust: );
    // rust: let font = load(&root);
    // rust: let _ = std::fs::remove_dir_all(&root);
    // rust: let a = font.glyph('A');
    // rust: let rect = a.rect.expect("A is drawn");
        // Oversampled 2x: the bitmap is twice the glyph's GUI size.
    // rust: assert_eq!(rect.w as f32 / 2.0, a.right - a.left);
    // rust: assert_eq!(rect.h as f32 / 2.0, a.bottom - a.top);
        // A monospaced font: every advance is the same, in half pixels.
    // rust: assert_eq!(a.advance, font.glyph('i').advance);
    // rust: assert_eq!((a.advance * 2.0).fract(), 0.0);
    // rust: assert!(a.advance > 4.0 && a.advance < 9.0, "{}", a.advance);
        // Capitals sit on the baseline at y = 7, shifted down a pixel.
    // rust: assert!((a.bottom - 8.0).abs() <= 0.5, "{}", a.bottom);
    // rust: assert_eq!(a.offset, 1.0);
        // The space has an advance and nothing to draw.
    // rust: let space = font.glyph(' ');
    // rust: assert!(space.rect.is_none() && space.advance > 0.0);
        // Skipped characters fall through to the missing glyph.
    // rust: assert_eq!(font.glyph('B').advance, 6.0);
        // Coverage as `rrrr` texels, faint coverage cut.
    // rust: let patches = font.take_patches();
    // rust: assert_eq!(patches.len(), 2);
    // rust: let texels: Vec<&[u8]> = patches.iter().flat_map(|p| p.rgba.chunks(4)).collect();
    // rust: assert!(texels.iter().all(|t| t.iter().all(|v| *v == t[0])));
    // rust: assert!(texels.iter().all(|t| t[0] == 0 || t[0] >= 25));
    // rust: assert!(texels.iter().any(|t| t[0] == 255));
}

pub fn styles_pick_their_font_and_unknown_fonts_draw_missing_glyphs() void {
}
    // rust: let sheet = png(16, 8, |x, _| x < 2 || (8..14).contains(&x));
    // rust: let default = br#"{"providers":[{"type":"space","advances":{" ":4}},{"type":"bitmap","file":"minecraft:font/a.png","ascent":7,"chars":["ab"]}]}"#;
    // rust: let alt = br#"{"providers":[{"type":"bitmap","file":"minecraft:font/a.png","ascent":7,"chars":["ba"]}]}"#;
    // rust: let root = root(
    // rust: "styles",
    // rust: &[
    // rust: ("assets/minecraft/font/default.json", default),
    // rust: ("assets/minecraft/font/alt.json", alt),
    // rust: ("assets/minecraft/textures/font/a.png", &sheet),
    // rust: ],
    // rust: );
    // rust: let font = load(&root);
    // rust: let _ = std::fs::remove_dir_all(&root);
        // The sheet is not in this atlas: glyphs are copied in when first drawn.
    // rust: assert_eq!(font.glyph('a').advance, 3.0);
    // rust: assert_eq!(font.glyph('b').advance, 7.0);
    // rust: let alt = Style {
    // rust: font: Some("minecraft:alt".into()),
    // rust: ..Style::default()
}
    // rust: assert_eq!(font.glyph_styled('a', &alt).advance, 7.0);
    // rust: assert_eq!(font.glyph_in("alt", 'b').advance, 3.0);
    // rust: assert!(font.glyph_styled('a', &alt).rect.is_some());
        // Not in alt (no space provider there), or no such font at all.
    // rust: assert_eq!(font.glyph_styled(' ', &alt).advance, 6.0);
    // rust: let missing = Style {
    // rust: font: Some("minecraft:nope".into()),
    // rust: ..Style::default()
}
    // rust: assert_eq!(font.glyph_styled(' ', &missing).advance, 6.0);
    // rust: assert_eq!(font.advance('a', &alt), 7.0);
    // rust: let text = Text::literal("ab").with_style(&alt);
    // rust: assert_eq!(font.width_text(&text), 10.0);
    // rust: assert_eq!(font.random_glyph(&alt, 7.0).advance, 7.0);
    // rust: assert!(!font.take_patches().is_empty());
}

    /// `FontSet.computeGlyphInfo`: `SelectedGlyphs.any` is the first provider's glyph, fishy
    /// advance or not, and is what is drawn and measured; `nonFishy`, what obfuscated text draws,
    /// is the first provider whose advance is within 0..32, else the missing glyph.
pub fn a_fishy_glyph_is_drawn_and_only_obfuscated_text_falls_through() void {
}
        // 64 opaque columns: the first provider's 'a' advances 65, past the 32 vanilla
        // calls fishy, and the narrow provider's 'a' advances 3.
    // rust: let wide = png(64, 8, |_, _| true);
    // rust: let narrow = png(16, 8, |x, _| x < 2);
    // rust: let def = br#"{"providers":[{"type":"bitmap","file":"minecraft:font/wide.png","ascent":7,"chars":["a"]},{"type":"bitmap","file":"minecraft:font/narrow.png","ascent":7,"chars":["a"]}]}"#;
    // rust: let root = root(
    // rust: "fishy",
    // rust: &[
    // rust: ("assets/minecraft/font/default.json", def),
    // rust: ("assets/minecraft/textures/font/wide.png", &wide),
    // rust: ("assets/minecraft/textures/font/narrow.png", &narrow),
    // rust: ],
    // rust: );
    // rust: let font = load(&root);
    // rust: let _ = std::fs::remove_dir_all(&root);
    // rust: let drawn = font.glyph('a');
    // rust: assert_eq!(drawn.advance, 65.0, "the first provider's glyph is drawn");
    // rust: assert!(drawn.rect.is_some());
    // rust: assert_eq!(font.advance('a', &Style::default()), 65.0);
        // The by-width table files 'a' under its first glyph's 65; the glyph it then draws is
        // the narrow provider's (`nonFishy`).
    // rust: assert_eq!(font.random_glyph(&Style::default(), 65.0).advance, 3.0);
        // Nothing else is 3 wide in the table, and the missing glyph is 6.
    // rust: assert_eq!(font.random_glyph(&Style::default(), 3.0).advance, 6.0);
}

    /// A `space` provider's shift glyphs (kerning in server packs: -512 to 512) are drawn and
    /// measured as they are, and `nonFishy` has nothing else to draw for them.
pub fn space_glyphs_with_any_advance_are_kept() void {
}
    // rust: let shifts: Vec<i32> = (0..10)
    // rust: .map(|i| -(1 << i))
    // rust: .chain((0..10).map(|i| 1 << i))
    // rust: .collect();
    // rust: let advances: Vec<String> = shifts
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, a)| format!("\"\\ue{:03x}\": {a}", i))
    // rust: .collect();
    // rust: let def = format!(
    // rust: r#"{{"providers":[{{"type":"space","advances":{{{}}}}}]}}"#,
    // rust: advances.join(",")
    // rust: );
    // rust: let root = root(
    // rust: "space-shifts",
    // rust: &[("assets/minecraft/font/default.json", def.as_bytes())],
    // rust: );
    // rust: let font = load(&root);
    // rust: let _ = std::fs::remove_dir_all(&root);
    // rust: for (i, a) in shifts.iter().enumerate() {
    // rust: let c = char::from_u32(0xe000 + i as u32).unwrap();
    // rust: assert_eq!(font.glyph(c).advance, *a as f32, "{c:?}");
    // rust: assert_eq!(font.advance(c, &Style::default()), *a as f32);
}
        // Obfuscated text asks for a glyph of a given width: a fishy space has none to give.
    // rust: let c = char::from_u32(0xe000 + 19).unwrap();
    // rust: assert_eq!(font.glyph(c).advance, 512.0);
    // rust: assert_eq!(
    // rust: font.glyph_non_fishy(DEFAULT, c).advance,
    // rust: 6.0,
    // rust: "the missing glyph"
    // rust: );
    // rust: assert_eq!(font.random_glyph(&Style::default(), 512.0).advance, 6.0);
}

    /// Nexo's GUI glyphs: a bitmap `height` of 287 with no advance, so every glyph wider than 31
    /// pixels has a fishy advance, and is still drawn.
pub fn a_wide_bitmap_glyph_is_drawn() void {
}
    // rust: let sheet = png(40, 287, |_, _| true);
    // rust: let def = br#"{"providers":[{"type":"bitmap","file":"minecraft:font/gui.png","height":287,"ascent":65,"chars":["a"]}]}"#;
    // rust: let root = root(
    // rust: "wide-bitmap",
    // rust: &[
    // rust: ("assets/minecraft/font/default.json", def),
    // rust: ("assets/minecraft/textures/font/gui.png", &sheet),
    // rust: ],
    // rust: );
    // rust: let font = load(&root);
    // rust: let _ = std::fs::remove_dir_all(&root);
    // rust: let g = font.glyph('a');
    // rust: assert_eq!(g.advance, 41.0, "the glyph's 40 columns and one");
    // rust: assert!(g.rect.is_some(), "drawn, not the missing glyph");
    // rust: assert!(fishy_advance(g.advance));
    // rust: assert_eq!(
    // rust: font.glyph_non_fishy(DEFAULT, 'a').advance,
    // rust: 6.0,
    // rust: "excluded from what obfuscated text draws"
    // rust: );
}

    /// StringDecomposer.iterateFormatted: a `§` that ends a part stops that
    /// part only; the next part is still measured and can break.
pub fn a_section_sign_ending_a_part_still_breaks_the_next() void {
}
    // rust: let sheet = png(16, 8, |x, _| x < 2);
    // rust: let default = br#"{"providers":[{"type":"space","advances":{" ":4}},{"type":"bitmap","file":"minecraft:font/a.png","ascent":7,"chars":["ab"]}]}"#;
    // rust: let root = root(
    // rust: "section-sign",
    // rust: &[
    // rust: ("assets/minecraft/font/default.json", default),
    // rust: ("assets/minecraft/textures/font/a.png", &sheet),
    // rust: ],
    // rust: );
    // rust: let font = load(&root);
    // rust: let _ = std::fs::remove_dir_all(&root);
    // rust: let mut text = Text::default();
    // rust: text.spans = ["a§", "a a"]
    // rust: .map(|part| Span {
    // rust: text: part.into(),
    // rust: style: Style::default(),
    // rust: })
    // rust: .into();
        // 3 + 3 + 4 + 3 is past 12: the line breaks at the space.
    // rust: let lines: Vec<String> = font
    // rust: .split_formatted(&text, 12.0)
    // rust: .iter()
    // rust: .map(Text::plain)
    // rust: .collect();
    // rust: assert_eq!(lines, ["a§a", "a"]);
}

    /// A renderer rebuilt over the same font (the loading screen's handoff)
    /// makes its atlas texture from the textures alone, so the glyphs it had
    /// rasterized into the previous texture must be placed into the new one.
pub fn a_rebuilt_atlas_gets_its_glyphs_again() void {
}
    // rust: let sheet = png(16, 8, |x, _| x < 2 || (8..14).contains(&x));
    // rust: let default = br#"{"providers":[{"type":"bitmap","file":"minecraft:font/a.png","ascent":7,"chars":["ab"]}]}"#;
    // rust: let root = root(
    // rust: "rebuild",
    // rust: &[
    // rust: ("assets/minecraft/font/default.json", default),
    // rust: ("assets/minecraft/textures/font/a.png", &sheet),
    // rust: ],
    // rust: );
    // rust: let font = load(&root);
    // rust: let _ = std::fs::remove_dir_all(&root);
    // rust: let first = font.glyph('a');
    // rust: assert_eq!(font.take_patches().len(), 1);
    // rust: font.reset_cache();
        // Nothing is left over: drawing the character again places its pixels.
    // rust: assert!(font.take_patches().is_empty());
    // rust: assert_eq!(font.glyph('a').advance, first.advance);
    // rust: assert_eq!(font.take_patches().len(), 1);
}

pub fn provider_filters_follow_the_font_options() void {
}
    // rust: let sheet = png(8, 8, |x, _| x < 4);
    // rust: let default = br#"{"providers":[{"type":"reference","id":"minecraft:include/sheet","filter":{"uniform":false}},{"type":"space","advances":{"a":2}}]}"#;
    // rust: let sheet_def = br#"{"providers":[{"type":"bitmap","file":"minecraft:font/s.png","ascent":7,"chars":["a"]}]}"#;
    // rust: let root = root(
    // rust: "filters",
    // rust: &[
    // rust: ("assets/minecraft/font/default.json", default),
    // rust: ("assets/minecraft/font/include/sheet.json", sheet_def),
    // rust: ("assets/minecraft/textures/font/s.png", &sheet),
    // rust: ],
    // rust: );
    // rust: let mut font = load(&root);
    // rust: let _ = std::fs::remove_dir_all(&root);
    // rust: assert_eq!(font.glyph('a').advance, 5.0);
    // rust: font.uniform = true;
    // rust: font.reset_cache();
    // rust: assert_eq!(font.glyph('a').advance, 2.0);
}

pub fn a_full_glyph_region_recovers_at_the_next_frame() void {
}
        // Two 8x8 glyphs from a sheet outside the atlas; the region holds one row.
    // rust: let sheet = png(16, 8, |x, _| x % 8 < 4);
    // rust: let default = br#"{"providers":[{"type":"bitmap","file":"pack:font/s.png","ascent":7,"chars":["ab"]}]}"#;
    // rust: let root = root(
    // rust: "full",
    // rust: &[
    // rust: ("assets/minecraft/font/default.json", default),
    // rust: ("assets/pack/textures/font/s.png", &sheet),
    // rust: ],
    // rust: );
        // A 10 wide atlas fits one 8 pixel glyph per row; the region two rows.
    // rust: let font = Font::load(&root, &HashMap::new(), &[], (10, 64), (0, 8), white());
    // rust: let _ = std::fs::remove_dir_all(&root);
    // rust: let epoch = font.epoch();
    // rust: let a = font.glyph('a');
    // rust: assert!(a.rect.is_some());
        // No room for 'b': missing for now, and asked again next time.
    // rust: assert!(font.glyph('b').rect.is_none());
    // rust: assert!(font.glyph('b').rect.is_none());
    // rust: assert_eq!(font.epoch(), epoch);
    // rust: font.begin_frame();
    // rust: assert_ne!(font.epoch(), epoch);
    // rust: let b = font.glyph('b');
    // rust: assert!(b.rect.is_some());
    // rust: assert_eq!(b.advance, a.advance);
        // Nothing overflowed since: the next frame keeps the glyphs.
    // rust: let epoch = font.epoch();
    // rust: font.begin_frame();
    // rust: assert_eq!(font.epoch(), epoch);
}

pub fn a_character_without_a_provider_does_not_reset_the_region() void {
}
    // rust: let sheet = png(8, 8, |x, _| x < 4);
    // rust: let default = br#"{"providers":[{"type":"bitmap","file":"pack:font/s.png","ascent":7,"chars":["a"]}]}"#;
    // rust: let root = root(
    // rust: "nofill",
    // rust: &[
    // rust: ("assets/minecraft/font/default.json", default),
    // rust: ("assets/pack/textures/font/s.png", &sheet),
    // rust: ],
    // rust: );
    // rust: let font = Font::load(&root, &HashMap::new(), &[], (10, 64), (0, 8), white());
    // rust: let _ = std::fs::remove_dir_all(&root);
    // rust: let epoch = font.epoch();
    // rust: assert!(font.glyph('z').rect.is_none());
    // rust: font.begin_frame();
    // rust: assert_eq!(font.epoch(), epoch);
}
}
