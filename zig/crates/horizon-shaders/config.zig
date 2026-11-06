//! Transpiled from Horizon Rust crate
//! Module: horizon-shaders_config
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The configuration packs write into their stage files (spec 1.7, 6.1): which buffers a fragment
//! shader writes (`/* DRAWBUFFERS:0257 */`, `/* RENDERTARGETS: 0,2 */`) and, per colortex buffer,
//! its format (`const int colortex2Format = RGBA16F;`, inside a block comment because the format
//! names are not GLSL), whether and to what it is cleared, and whether it gets mipmaps.
//!
//! Everything is read from live code only: the preprocessor has already dropped the false
//! branches, so a format chosen by an option is the one the option selects. Every stage file of
//! the programs that run is read (OQ-17), and the shadow programs' when the shadow pass doesn't
//! run; a later file overrides an earlier one, with a note when the values differ. A colortex
//! format counts only in a fragment stage, and in a block comment only where `const` starts its
//! line, as Iris 1.11.7 read our probes ([`Config::read_vertex`], [`Config::read`]).

// use crate::Preprocessed;

/// colortex buffers (6.1.1).
pub const BUFFERS: usize = 16;

/// The shadowcolor buffers there are: two, and `shadowcolor2` to `shadowcolor7` for a pack that
/// names the `HIGHER_SHADOWCOLOR` feature.
pub const SHADOW_COLORS: usize = 8;

/// A colour format of 6.7, as channels, bits per channel and kind. Packed formats are described
/// by their widest channel: `RGB10_A2` is 4 × 10 bits, `R11F_G11F_B10F` 3 × 11 bits float.
pub const Format = struct {
    channels: u8,
    bits: u8,
    kind: Kind,
};

pub const Kind = enum {
    Unorm,
    Snorm,
    Float,
    Int,
    Uint,
};

    // rust: impl Format {
    /// The default `RGBA` (6.1.3).
    // rust: pub const RGBA8: Format = Format {
    // rust: channels: 4,
    // rust: bits: 8,
    // rust: kind: Kind::Unorm,
}

    /// A format name of 6.7, in any case.
pub fn parse(name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = name.trim().to_ascii_uppercase();
    // rust: let packed = |channels, bits, kind| {
    // rust: Some(Format {
    // rust: channels,
    // rust: bits,
    // rust: kind,
    // rust: })
}
    // rust: match name.as_str() {
    // rust: "RGBA" => return Some(Self::RGBA8),
    // rust: "R3_G3_B2" => return packed(3, 3, Kind::Unorm),
    // rust: "RGB5_A1" => return packed(4, 5, Kind::Unorm),
    // rust: "RGB10_A2" => return packed(4, 10, Kind::Unorm),
    // rust: "RGB10_A2UI" => return packed(4, 10, Kind::Uint),
    // rust: "R11F_G11F_B10F" => return packed(3, 11, Kind::Float),
    // rust: "RGB9_E5" => return packed(3, 9, Kind::Float),
    // rust: "RGBA4" => return packed(4, 4, Kind::Unorm),
    // rust: "RGB565" => return packed(3, 6, Kind::Unorm),
    // rust: "RGBA2" => return packed(4, 2, Kind::Unorm),
    // rust: _ => {}
}
    // rust: let letters = name.bytes().take_while(u8::is_ascii_alphabetic).count();
    // rust: let channels = match &name[..letters] {
    // rust: "R" => 1,
    // rust: "RG" => 2,
    // rust: "RGB" => 3,
    // rust: "RGBA" => 4,
    // rust: _ => return None,
}
    // rust: let rest = &name[letters..];
    // rust: let digits = rest.bytes().take_while(u8::is_ascii_digit).count();
    // rust: let bits: u8 = rest[..digits].parse().ok()?;
    // rust: let kind = match &rest[digits..] {
    // rust: "" => Kind::Unorm,
    // rust: "_SNORM" => Kind::Snorm,
    // rust: "F" => Kind::Float,
    // rust: "I" => Kind::Int,
    // rust: "UI" => Kind::Uint,
    // rust: _ => return None,
}
    // rust: let valid = match kind {
    // rust: Kind::Unorm | Kind::Snorm => matches!(bits, 8 | 16),
    // rust: Kind::Float => matches!(bits, 16 | 32),
    // rust: Kind::Int | Kind::Uint => matches!(bits, 8 | 16 | 32),
}
    // rust: valid.then_some(Format {
    // rust: channels,
    // rust: bits,
    // rust: kind,
    // rust: })
}
}

/// The settings of one colortex buffer.
pub const Buffer = struct {
    format: Format,
    /// Cleared every frame (`<buffer>Clear`, default true).
    clear: bool,
    /// `<buffer>ClearColor`, else 6.1.5's default: colortex0 the fog colour, colortex1 white,
    /// the others transparent black.
    clear_color: Option<[f32,
    /// `<buffer>MipmapEnabled`.
    mipmap: bool,
};

    // rust: impl Default for Buffer {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: format: Format::RGBA8,
    // rust: clear: true,
    // rust: clear_color: None,
    // rust: mipmap: false,
}
}
}

/// The shadow map's settings (6.3, 7.1), from `const` lines of the stage files.
pub const Shadow = struct {
    /// `shadowMapResolution`: the map's side in pixels.
    resolution: u32,
    /// `shadowDistance`: half the side of the area the map covers, in blocks.
    distance: f32,
    /// `shadowDistanceRenderMul`: when > 0, geometry beyond `distance × mul` is not drawn.
    render_mul: f32,
    /// `voxelDistance`: with `shadow.culling=reversed`, nothing within it is culled.
    voxel_distance: f32,
    /// `shadowIntervalSize`: the shadow camera moves in steps of this many blocks (0: none).
    interval: f32,
    /// Native packs: the snap's remainder is euclidean, so the centre is within half an interval
    /// of the player at negative coordinates too. `shaders/` packs keep Iris's.
    euclidean_snap: bool,
    /// `sunPathRotation`, degrees.
    sun_path_rotation: f32,
    /// `shadowMapFov`: a perspective projection of this many degrees instead of orthographic.
    fov: ?f32,
    /// `shadowNearPlane`, `shadowFarPlane`: the orthographic projection's planes, as JOML's
    /// `zNear`/`zFar`. None when the pack doesn't set one: Iris 1.11.7 then uses -100.05 and
    /// 156 (measured with a probe pack), each on its own.
    near: ?f32,
    far: ?f32,
    /// `shadowHardwareFiltering(0|1)`: shadowtex0/1 sampled with depth comparison.
    hardware_filtering: [bool,
    /// `shadowtex0Nearest` (or `shadowtexNearest`, `shadow0MinMagNearest`) and
    /// `shadowtex1Nearest` (or `shadow1MinMagNearest`): shadowtex0/1 read through a plain sampler
    /// take the nearest texel. Otherwise Iris 1.11.7 filters them linearly (measured).
    nearest: [bool,
    /// `shadowcolor0` to `shadowcolor7`: format, cleared every frame, clear colour (default
    /// white).
    colors: [Buffer,
};

    // rust: impl Default for Shadow {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let white = Buffer {
    // rust: clear_color: Some([1.0; 4]),
    // rust: ..Buffer::default()
}
    // rust: Self {
    // rust: resolution: 1024,
    // rust: distance: 160.0,
    // rust: render_mul: -1.0,
    // rust: voxel_distance: 160.0,
    // rust: interval: 2.0,
    // rust: euclidean_snap: false,
    // rust: sun_path_rotation: 0.0,
    // rust: fov: None,
    // rust: near: None,
    // rust: far: None,
    // rust: hardware_filtering: [false; 2],
    // rust: nearest: [false; 2],
    // rust: colors: std::array::from_fn(|_| white.clone()),
}
}
}

pub const Config = struct {
    buffers: [Buffer,
    shadow: Shadow,
    /// Conflicting or unreadable settings, as `file:line: message`.
    notes: std.ArrayList([]const u8),
    /// Each setting read so far and its value, to report a later file changing it.
    seen: Vec<([]const u8,
};

    // rust: impl Default for Config {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: buffers: std::array::from_fn(|_| Buffer::default()),
    // rust: shadow: Shadow::default(),
    // rust: notes: Vec::new(),
    // rust: seen: Vec::new(),
}
}
}

/// The shadowcolor buffer a sampler or image name reads: `shadowcolor` and `shadowcolor0` to
/// `shadowcolor7`.
pub fn shadow_color(name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match name.strip_prefix("shadowcolor")?.as_bytes() {
    // rust: [] => Some(0),
    // rust: &[d @ b'0'..=b'7'] => Some(usize::from(d - b'0')),
    // rust: _ => None,
}
}

/// The colortex index of a buffer name or alias (6.1.1).
pub fn buffer_index(name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let alias = [
    // rust: "gcolor",
    // rust: "gdepth",
    // rust: "gnormal",
    // rust: "composite",
    // rust: "gaux1",
    // rust: "gaux2",
    // rust: "gaux3",
    // rust: "gaux4",
    // rust: ];
    // rust: if let Some(i) = alias.iter().position(|a| *a == name) {
    // rust: return Some(i);
}
    // rust: let n: usize = name.strip_prefix("colortex")?.parse().ok()?;
    // rust: (n < BUFFERS).then_some(n)
}

    // rust: impl Config {
    /// Reads one preprocessed fragment stage file.
pub fn read(self: *Self, pp: *Preprocessed) void {
}
    // rust: self.read_stage(pp, true, true);
}

    /// Reads only the colortex formats of one preprocessed fragment stage file, as [`Self::read`]
    /// reads them.
pub fn read_formats(self: *Self, pp: *Preprocessed) void {
}
    // rust: self.read_stage(pp, true, false);
}

    /// Reads one preprocessed vertex stage file. Its colortex formats don't count: Iris 1.11.7
    /// ignored a `colortexNFormat` declared only in `composite.vsh`, `final.vsh`, `deferred.vsh`,
    /// `gbuffers_terrain.vsh` or `shadow.vsh` of probe packs p9063a, p9063c and p9063s (ours),
    /// while it honoured the same line in each program's fragment shader.
pub fn read_vertex(self: *Self, pp: *Preprocessed) void {
}
    // rust: self.read_stage(pp, false, true);
}

    /// `formats`: whether colortex formats count; `others`: whether every other setting does.
pub fn read_stage(self: *Self, pp: *Preprocessed, formats: bool, others: bool) void {
}
    // rust: let line = |at: usize| pp.locate(code_line(&pp.code, at));
    // rust: for (at, ty, name, value) in constants(&pp.code) {
    // rust: let place = line(at);
    // rust: self.constant(&place, ty, name, value, formats, others);
}
    // rust: for (origin, comment) in &pp.comments {
    // rust: for (at, ty, name, value) in constants(comment) {
    // rust: let file = pp
    // rust: .files
    // rust: .get(origin.file as usize)
    // rust: .map_or("?", String::as_str);
    // rust: let place = format!("{file}:{}", origin.line);
                // Our probes' Iris 1.11.7 values fit this (a fit, not a rule Iris states): a
                // `colortexNFormat` in a block comment counts only when `const` starts its line.
                // Iris ignored one on the line of the `/*` (`/* const int colortex2Format =
                // RGBA16F; */`), after a ` * `, and after another declaration on its line; it
                // honoured one indented, one followed by text or by `*/`, and the first of two.
    // rust: let starts_line = (comment[..at].rfind('\n'))
    // rust: .is_some_and(|n| comment[n + 1..at].trim().is_empty());
    // rust: self.constant(&place, ty, name, value, formats && starts_line, others);
}
}
}

    /// `formats`: whether a colortex format declared here counts; `others`: whether any other
    /// setting does.
    // rust: fn constant(
    // rust: &mut self,
    // rust: place: &str,
    // rust: ty: &str,
    // rust: name: &str,
    // rust: value: &str,
    // rust: formats: bool,
    // rust: others: bool,
    // rust: ) {
    // rust: let format = ty == "int" && name.strip_suffix("Format").and_then(buffer_index).is_some();
    // rust: if !others && !format {
    // rust: return;
}
    // rust: if self.shadow_constant(ty, name, value) {
    // rust: return;
}
    // rust: let settings = [
    // rust: ("Format", "int"),
    // rust: ("ClearColor", "vec4"),
    // rust: ("Clear", "bool"),
    // rust: ("MipmapEnabled", "bool"),
    // rust: ];
    // rust: let Some((buffer, setting)) = settings.iter().find_map(|(suffix, want)| {
    // rust: let buffer = buffer_index(name.strip_suffix(suffix)?)?;
    // rust: (ty == *want).then_some((buffer, *suffix))
    // rust: }) else {
    // rust: return;
}
    // rust: if setting == "Format" && !formats {
    // rust: return;
}
    // rust: let b = &mut self.buffers[buffer];
    // rust: let ok = match setting {
    // rust: "Format" => Format::parse(value).map(|f| b.format = f),
    // rust: "ClearColor" => vec4(value).map(|c| b.clear_color = Some(c)),
    // rust: "Clear" => boolean(value).map(|v| b.clear = v),
    // rust: _ => boolean(value).map(|v| b.mipmap = v),
}
    // rust: if ok.is_none() {
    // rust: let problem = match setting {
    // rust: "Format" => format!("unknown format `{value}`"),
    // rust: "ClearColor" => format!("`{name}` is not a vec4: `{value}`"),
    // rust: _ => format!("`{name}` is not a bool: `{value}`"),
}
    // rust: self.notes.push(format!("{place}: {problem}"));
    // rust: return;
}
        // The same setting under another name (an alias) counts as the same.
    // rust: let key = format!("{buffer}{setting}");
    // rust: match self.seen.iter_mut().find(|(k, _)| *k == key) {
    // rust: Some((_, old)) if old != value => {
    // rust: self.notes.push(format!(
    // rust: "{place}: `{name}` changed by a later file to `{value}`"
    // rust: ));
    // rust: *old = value.to_owned();
}
    // rust: Some(_) => {}
    // rust: None => self.seen.push((key, value.to_owned())),
}
}
}

    // rust: impl Config {
    /// A shadow setting of 6.3 or 7.1; true when `name` is one (read or not).
pub fn shadow_constant(self: *Self, ty: []const u8, name: []const u8, value: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let s = &mut self.shadow;
    // rust: let float = |v: &mut f32| {
    // rust: if let Some(n) = number(value) {
    // rust: *v = n;
}
}
    // rust: match name {
    // rust: "shadowMapResolution" => {
    // rust: if let Some(n) = number(value).filter(|n| *n >= 1.0) {
    // rust: s.resolution = (n as u32).min(16384);
}
}
    // rust: "shadowDistance" => float(&mut s.distance),
    // rust: "shadowDistanceRenderMul" => float(&mut s.render_mul),
    // rust: "voxelDistance" => float(&mut s.voxel_distance),
    // rust: "shadowIntervalSize" => float(&mut s.interval),
    // rust: "sunPathRotation" => float(&mut s.sun_path_rotation),
    // rust: "shadowNearPlane" => s.near = number(value).or(s.near),
    // rust: "shadowFarPlane" => s.far = number(value).or(s.far),
    // rust: "shadowMapFov" => s.fov = number(value).filter(|f| *f > 0.0),
    // rust: "shadowHardwareFiltering" => {
    // rust: if let Some(b) = boolean(value) {
    // rust: s.hardware_filtering = [b; 2];
}
}
    // rust: "shadowHardwareFiltering0" | "shadowHardwareFiltering1" => {
    // rust: if let Some(b) = boolean(value) {
    // rust: s.hardware_filtering[usize::from(name.ends_with('1'))] = b;
}
}
    // rust: "shadowtexNearest" | "shadowtex0Nearest" | "shadow0MinMagNearest" => {
    // rust: if let Some(b) = boolean(value) {
    // rust: s.nearest[0] = b;
}
}
    // rust: "shadowtex1Nearest" | "shadow1MinMagNearest" => {
    // rust: if let Some(b) = boolean(value) {
    // rust: s.nearest[1] = b;
}
}
    // rust: _ => {
                // `shadowcolor` is shadowcolor0.
    // rust: let color =
    // rust: name.strip_prefix("shadowcolor")
    // rust: .map(|rest| match rest.as_bytes().first() {
    // rust: Some(&d @ b'0'..=b'7') => (usize::from(d - b'0'), &rest[1..]),
    // rust: _ => (0, rest),
    // rust: });
    // rust: let Some((buffer, setting)) = color else {
    // rust: return false;
}
    // rust: let b = &mut s.colors[buffer];
    // rust: match (setting, ty) {
    // rust: ("Format", "int") => {
    // rust: if let Some(f) = Format::parse(value) {
    // rust: b.format = f;
}
}
    // rust: ("Clear", "bool") => {
    // rust: if let Some(v) = boolean(value) {
    // rust: b.clear = v;
}
}
    // rust: ("ClearColor", "vec4") => {
    // rust: if let Some(c) = vec4(value) {
    // rust: b.clear_color = Some(c);
}
}
    // rust: _ => return false,
}
}
}
    // rust: true
}
}

/// The buffers a fragment shader writes, from the last `DRAWBUFFERS` or `RENDERTARGETS` comment
/// of its live code, or `None` without one (then the program loader decides). 6.1.4.
pub fn draw_buffers(pp: *Preprocessed) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut found = None;
    // rust: for (_, comment) in &pp.comments {
    // rust: let text = comment.trim();
    // rust: if let Some(digits) = text.strip_prefix("DRAWBUFFERS:") {
    // rust: let list: Option<Vec<u32>> = digits.trim().chars().map(|c| c.to_digit(10)).collect();
    // rust: found = list.or(found);
    // rust: } else if let Some(list) = text.strip_prefix("RENDERTARGETS:") {
    // rust: let list: Option<Vec<u32>> = list
    // rust: .split(',')
    // rust: .map(|n| {
    // rust: n.trim()
    // rust: .parse()
    // rust: .ok()
    // rust: .filter(|&n: &u32| (n as usize) < BUFFERS)
    // rust: })
    // rust: .collect();
    // rust: found = list.or(found);
}
}
    // rust: found.map(|mut list| {
    // rust: list.truncate(8);
    // rust: list
    // rust: })
}

/// `const <type> <name> = <value>;` anywhere in `text`: (byte offset, type, name, value).
pub fn constants(text: []const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Vec::new();
    // rust: let mut from = 0;
    // rust: while let Some(found) = text[from..].find("const") {
    // rust: let at = from + found;
    // rust: from = at + 5;
    // rust: let before = text[..at].chars().next_back();
    // rust: if before.is_some_and(|c| c.is_alphanumeric() || c == '_') {
    // rust: continue;
}
    // rust: let rest = &text[from..];
    // rust: let Some(end) = rest.find(';') else { break };
    // rust: let decl = &rest[..end];
    // rust: let Some((left, value)) = decl.split_once('=') else {
    // rust: continue;
}
    // rust: let mut words = left.split_whitespace();
    // rust: if let (Some(ty), Some(name), None) = (words.next(), words.next(), words.next()) {
    // rust: out.push((at, ty, name, value.trim()));
}
}
    // rust: out
}

pub fn code_line(code: []const u8, at: usize) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: code[..at].matches('\n').count()
}

pub fn boolean(value: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match value {
    // rust: "true" => Some(true),
    // rust: "false" => Some(false),
    // rust: _ => None,
}
}

pub fn number(text: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let text = text.trim();
    // rust: text.strip_suffix(['f', 'F']).unwrap_or(text).parse().ok()
}

/// `vec4(r, g, b, a)` or `vec4(x)`.
pub fn vec4(value: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let inner = value
    // rust: .strip_prefix("vec4")?
    // rust: .trim()
    // rust: .strip_prefix('(')?
    // rust: .strip_suffix(')')?;
    // rust: let parts: Option<Vec<f32>> = inner.split(',').map(number).collect();
    // rust: match parts?.as_slice() {
    // rust: [x] => Some([*x; 4]),
    // rust: [r, g, b, a] => Some([*r, *g, *b, *a]),
    // rust: _ => None,
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::pack::tests::zip;
//     use crate::{Macros, Pack, preprocess};

pub fn stage(text: []const u8) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let pack = Pack::from_zip_bytes("t", zip(&[("shaders/composite.fsh", text)])).unwrap();
    // rust: preprocess(&pack, "composite.fsh", &Macros::standard())
}

pub fn formats_parse() void {
}
    // rust: let f = |channels, bits, kind| {
    // rust: Some(Format {
    // rust: channels,
    // rust: bits,
    // rust: kind,
    // rust: })
}
    // rust: assert_eq!(Format::parse("rgba16f"), f(4, 16, Kind::Float));
    // rust: assert_eq!(Format::parse("R32UI"), f(1, 32, Kind::Uint));
    // rust: assert_eq!(Format::parse("RG8_SNORM"), f(2, 8, Kind::Snorm));
    // rust: assert_eq!(Format::parse("R11F_G11F_B10F"), f(3, 11, Kind::Float));
    // rust: assert_eq!(Format::parse("RGB16"), f(3, 16, Kind::Unorm));
    // rust: assert_eq!(Format::parse("RGBA12"), None);
    // rust: assert_eq!(Format::parse("R16_SNORMX"), None);
}

pub fn draw_buffers_and_constants_come_from_live_code() void {
}
    // rust: let pp = stage(
    // rust: "#version 120\n\
    // rust: #define HQ\n\
    // rust: /*\n\
    // rust: const int colortex2Format = RGBA16F;\n\
    // rust: const int gaux4Format = R32F;\n\
    // rust: */\n\
    // rust: #ifdef HQ\n\
    // rust: /* RENDERTARGETS: 0,2,11 */\n\
    // rust: #else\n\
    // rust: /* DRAWBUFFERS:01 */\n\
    // rust: const bool colortex5Clear = true;\n\
    // rust: #endif\n\
    // rust: const bool colortex5Clear = false;\n\
    // rust: const vec4 colortex3ClearColor = vec4(0.5, 0.25, 0.0, 1.0f);\n\
    // rust: const bool colortex3MipmapEnabled = true;\n\
    // rust: const vec4 gnormalClearColor = vec4(1.0);\n\
    // rust: uniform sampler2D gdepth;\n\
    // rust: void main() {}\n",
    // rust: );
    // rust: assert_eq!(draw_buffers(&pp), Some(vec![0, 2, 11]));
    // rust: let mut config = Config::default();
    // rust: config.read(&pp);
    // rust: let b = &config.buffers;
    // rust: assert_eq!(b[2].format, Format::parse("RGBA16F").unwrap());
    // rust: assert_eq!(b[7].format, Format::parse("R32F").unwrap());
    // rust: assert!(!b[5].clear && b[0].clear);
    // rust: assert_eq!(b[3].clear_color, Some([0.5, 0.25, 0.0, 1.0]));
    // rust: assert!(b[3].mipmap && !b[2].mipmap);
    // rust: assert_eq!(b[2].clear_color, Some([1.0; 4]));
        // Iris 1.11.7 kept RGBA8 for `gdepth` (colortex1) with no format given, in probe pack
        // p9063b of ours; OptiFine's RGBA32F rule doesn't apply.
    // rust: assert_eq!(b[1].format, Format::RGBA8, "gdepth");
    // rust: assert!(config.notes.is_empty(), "{:?}", config.notes);
}

pub fn shadow_settings() void {
}
    // rust: let mut c = Config::default();
    // rust: c.read(&stage(
    // rust: "const int shadowMapResolution = 2048;\nconst float shadowDistance = 128.0f;\n\
    // rust: const float sunPathRotation = -40.0;\nconst bool shadowHardwareFiltering = true;\n\
    // rust: /* const int shadowcolor1Format = RGBA16F; */\nconst bool shadowcolor0Clear = false;\n",
    // rust: ));
    // rust: let s = c.shadow;
    // rust: assert_eq!(
    // rust: (s.resolution, s.distance, s.sun_path_rotation),
    // rust: (2048, 128.0, -40.0)
    // rust: );
    // rust: assert_eq!(
    // rust: (s.interval, s.fov, s.hardware_filtering),
    // rust: (2.0, None, [true; 2])
    // rust: );
    // rust: assert!(!s.colors[0].clear && s.colors[1].clear);
    // rust: assert_eq!(s.colors[1].format, Format::parse("RGBA16F").unwrap());
    // rust: assert_eq!(s.colors[1].clear_color, Some([1.0; 4]));
    // rust: assert_eq!(s.nearest, [false; 2]);
}

pub fn shadow_depth_filtering_settings() void {
}
    // rust: let nearest = |text: &str| {
    // rust: let mut c = Config::default();
    // rust: c.read(&stage(text));
    // rust: c.shadow.nearest
}
    // rust: assert_eq!(
    // rust: nearest("const bool shadowtex0Nearest = true;\n"),
    // rust: [true, false]
    // rust: );
    // rust: assert_eq!(
    // rust: nearest("const bool shadowtexNearest = true;\n"),
    // rust: [true, false]
    // rust: );
    // rust: assert_eq!(
    // rust: nearest("const bool shadow0MinMagNearest = true;\n"),
    // rust: [true, false]
    // rust: );
    // rust: assert_eq!(
    // rust: nearest("const bool shadowtex1Nearest = true;\n"),
    // rust: [false, true]
    // rust: );
    // rust: assert_eq!(
    // rust: nearest("const bool shadow1MinMagNearest = true;\n"),
    // rust: [false, true]
    // rust: );
    // rust: assert_eq!(
    // rust: nearest("const bool shadowtex0Nearest = false;\n"),
    // rust: [false; 2]
    // rust: );
}

pub fn no_directive_and_conflicts() void {
}
    // rust: let pp = stage("void main() {}\n");
    // rust: assert_eq!(draw_buffers(&pp), None);
    // rust: let a = stage(
    // rust: "/*\nconst int colortex1Format = RGB8;\n*/\nconst bool colortex1Clear = maybe;\n",
    // rust: );
    // rust: let b = stage(
    // rust: "/*\nconst int colortex1Format = RGBA16;\nconst int colortex2Format = XYZ;\n*/\n",
    // rust: );
    // rust: let mut config = Config::default();
    // rust: config.read(&a);
    // rust: config.read(&b);
    // rust: let notes = config.notes.join("\n");
    // rust: assert!(
    // rust: notes.contains("composite.fsh:4: `colortex1Clear` is not a bool"),
    // rust: "{notes}"
    // rust: );
    // rust: assert!(
    // rust: notes.contains("composite.fsh:1: `colortex1Format` changed"),
    // rust: "{notes}"
    // rust: );
    // rust: assert!(notes.contains("unknown format `XYZ`"), "{notes}");
    // rust: assert_eq!(config.buffers[1].format, Format::parse("RGBA16").unwrap());
}

pub fn a_format_in_a_comment_counts_where_const_starts_its_line() void {
}
        // The placements of probe packs p9063a and p9063c (ours): Iris 1.11.7 kept RGBA8 for
        // buffers 1, 2, 5 and 6, and took RGBA16F for 3, 4 and 7 to 11.
    // rust: let pp = stage(
    // rust: "/*\n * const int colortex1Format = RGBA16F;\n */\n\
    // rust: /* const int colortex2Format = RGBA16F; */\n\
    // rust: /*\nconst int colortex3Format = RGBA16F;\n    const int colortex4Format = RGBA16F;\n\
    // rust: const int colortex16Dummy = 1; const int colortex5Format = RGBA16F;\n*/\n\
    // rust: /* const int colortex6Format = RGBA16F;\n*/\n\
    // rust: /*\nconst int colortex7Format = RGBA16F; */\n\
    // rust: /*\nconst int colortex8Format = RGBA16F; trailing words\n\
    // rust: \tconst int colortex9Format = RGBA16F;\n\
    // rust: const  int  colortex10Format  =  RGBA16F ;\n\
    // rust: const int colortex11Format = RGBA16F; const int colortex16Dummy = 1;\n*/\n",
    // rust: );
    // rust: let mut config = Config::default();
    // rust: config.read(&pp);
    // rust: let half = Format::parse("RGBA16F").unwrap();
    // rust: let read: Vec<bool> = (1..=11).map(|n| config.buffers[n].format == half).collect();
    // rust: assert_eq!(
    // rust: read,
    // rust: [
    // rust: false, false, true, true, false, false, true, true, true, true, true
    // rust: ]
    // rust: );
}
}
