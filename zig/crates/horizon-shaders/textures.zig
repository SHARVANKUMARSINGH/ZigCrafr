//! Transpiled from Horizon Rust crate
//! Module: horizon-shaders_textures
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Custom textures: `texture.<stage>.<name>` and `texture.noise` in `shaders.properties` (3.4),
//! and Iris's `customTexture.<name>`, a sampler of its own that every program may read. A
//! texture is a PNG of the pack, a raw dump with its type, formats and size, or a resource
//! location the game resolves (`minecraft:textures/...`, `minecraft:dynamic/lightmap_1`).

// use crate::{Format, Kind, Pack, Properties};

/// The stage of a `customTexture.<name>`: every program's.
pub const EVERY_STAGE: []const u8 = "*";

/// A texture bound to sampler `name` in the programs of `stage` (`gbuffers`, `deferred`,
/// `composite`...; [`EVERY_STAGE`] for a `customTexture`), or the noise texture (stage and
/// name `noise`).
pub const CustomTexture = struct {
    stage: []const u8,
    name: []const u8,
    source: TextureSource,
};

pub const TextureSource = enum {
    Image(Texture),
    /// A resource location for the game to resolve.
    Resource(String),
};

pub const Dim = enum {
    D1,
    D2,
    D3,
};

pub const Texture = struct {
    dim: Dim,
    /// Width, height and depth (1 for the dimensions the texture lacks).
    size: [u32,
    /// The internal format the pack asked for.
    format: Format,
    texels: Texels,
    /// Linear filtering, and clamping instead of repeating: on for a raw texture and off for a
    /// PNG, unless the `.mcmeta` beside it says otherwise.
    blur: bool,
    clamp: bool,
    /// A raw dump rather than a PNG.
    raw: bool,
};

/// Texel values, `components` per texel: 1, 2 or 4 (three widen to four, alpha 1).
pub const Texels = enum {
    Float(Vec<f32>),
    Int(Vec<i32>),
    Uint(Vec<u32>),
};

    // rust: impl Texture {
pub fn components(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: components(self.format.channels)
}
}

pub fn components(channels: u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match channels {
    // rust: 1 => 1,
    // rust: 2 => 2,
    // rust: _ => 4,
}
}

/// Every `texture.*` and `customTexture.*` entry, read and decoded, and a note for each that
/// failed.
pub fn load_textures(pack: *Pack, properties: *Properties) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (mut textures, mut notes) = (Vec::new(), Vec::new());
    // rust: for e in &properties.entries {
    // rust: let (stage, name) = if let Some(name) = e.key.strip_prefix("customTexture.") {
    // rust: (EVERY_STAGE, name)
    // rust: } else if let Some(rest) = e.key.strip_prefix("texture.") {
    // rust: match rest {
    // rust: "noise" => ("noise", "noise"),
    // rust: _ => match rest.split_once('.') {
                    // `.0` to `.9` after the name only keep keys apart.
    // rust: Some((stage, name)) => (stage, strip_suffix(name)),
    // rust: None => {
    // rust: notes.push(format!("`{}`: no sampler name", e.key));
    // rust: continue;
}
    // rust: },
}
    // rust: } else {
    // rust: continue;
}
    // rust: match source(pack, e.value.trim()) {
    // rust: Ok(source) => textures.push(CustomTexture {
    // rust: stage: stage.to_owned(),
    // rust: name: name.to_owned(),
    // rust: source,
    // rust: }),
    // rust: Err(why) => notes.push(format!("`{}`: {why}", e.key)),
}
}
    // rust: (textures, notes)
}

/// Decodes the custom textures that name one of the game's textures by its resource location
/// (`customTexture.clouds = minecraft:textures/environment/clouds.png`; Iris reads these from the
/// game's resources, like a PNG of the pack). `read` gives a resource's bytes by namespace and
/// path (resource packs over the game's own). The game's generated textures
/// (`minecraft:dynamic/lightmap_1`, the atlases) stay for the renderer; one that can't be read
/// or decoded is dropped, with a note.
    // rust: pub fn resolve_resources(
    // rust: textures: &mut Vec<CustomTexture>,
    // rust: read: &dyn Fn(&str, &str) -> Option<Vec<u8>>,
    // rust: ) -> Vec<String> {
    // rust: let mut notes = Vec::new();
    // rust: textures.retain_mut(|t| {
    // rust: let TextureSource::Resource(location) = &t.source else {
    // rust: return true;
}
    // rust: let (namespace, path) = location.split_once(':').unwrap_or(("minecraft", location));
    // rust: if path.starts_with("dynamic/") || path.starts_with("textures/atlas/") {
    // rust: return true;
}
    // rust: let key = match t.stage.as_str() {
    // rust: EVERY_STAGE => format!("customTexture.{}", t.name),
    // rust: stage => format!("texture.{stage}.{}", t.name),
}
        // A resource location's characters (`ResourceLocation`): nothing reaches outside the
        // game's resources.
    // rust: let valid = |s: &str, slash: bool| {
    // rust: !s.is_empty()
    // rust: && s.bytes().all(|b| {
    // rust: b.is_ascii_lowercase()
    // rust: || b.is_ascii_digit()
    // rust: || b"_-.".contains(&b)
    // rust: || (slash && b == b'/')
    // rust: })
    // rust: && s.split('/').all(|part| part != ".." && part != ".")
}
    // rust: if !valid(namespace, false) || !valid(path, true) {
    // rust: notes.push(format!("`{key}`: `{location}` is not a resource location"));
    // rust: return false;
}
    // rust: let Some(bytes) = read(namespace, path) else {
    // rust: notes.push(format!("`{key}`: the game has no `{location}`"));
    // rust: return false;
}
    // rust: let Some(mut texture) = decode_png(&bytes) else {
    // rust: notes.push(format!("`{key}`: `{location}` is not a PNG"));
    // rust: return false;
}
    // rust: let meta = read(namespace, &format!("{path}.mcmeta"));
    // rust: let text = meta.as_deref().map(String::from_utf8_lossy);
    // rust: let (blur, clamp) = mcmeta(text.as_deref());
    // rust: (texture.blur, texture.clamp) = (blur.unwrap_or(false), clamp.unwrap_or(false));
    // rust: t.source = TextureSource::Image(texture);
    // rust: true
    // rust: });
    // rust: notes
}

pub fn strip_suffix(name: []const u8) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match name.rsplit_once('.') {
    // rust: Some((base, n)) if n.len() == 1 && n.as_bytes()[0].is_ascii_digit() => base,
    // rust: _ => name,
}
}

pub fn source(pack: *Pack, value: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut words = value.split_whitespace();
    // rust: let path = words.next().ok_or("no path")?;
    // rust: if path.contains(':') {
    // rust: return Ok(TextureSource::Resource(path.to_owned()));
}
    // rust: let path = path.trim_start_matches('/');
    // rust: let bytes = pack
    // rust: .read(path)
    // rust: .ok_or_else(|| format!("can't find `{path}`"))?;
    // rust: let (blur, clamp) = mcmeta(pack.read_text(&format!("{path}.mcmeta")).as_deref());
    // rust: let rest: Vec<&str> = words.collect();
    // rust: let mut texture = if rest.is_empty() {
    // rust: decode_png(&bytes).ok_or_else(|| format!("`{path}` is not a PNG"))?
    // rust: } else {
    // rust: raw(&bytes, &rest)?
}
    // A PNG is nearest and repeating, a raw texture linear and clamped (Iris 1.11.7 with a probe
    // pack of ours, #9064); each key the `.mcmeta` has overrides its own default only.
    // rust: texture.blur = blur.unwrap_or(texture.raw);
    // rust: texture.clamp = clamp.unwrap_or(texture.raw);
    // rust: Ok(TextureSource::Image(texture))
}

/// `{"texture": {"blur": true, "clamp": false}}`: each flag, or `None` when it is missing.
pub fn mcmeta(text: ?[]const u8) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let flag = |key: &str| {
    // rust: text.and_then(|t| t.split_once(&format!("\"{key}\"")))
    // rust: .map(|(_, after)| after.trim_start().trim_start_matches(':').trim_start())
    // rust: .map(|v| v.starts_with("true"))
}
    // rust: (flag("blur"), flag("clamp"))
}

/// A PNG as 8-bit RGBA, rows top first.
pub fn decode_png(bytes: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut decoder = png::Decoder::new(std::io::Cursor::new(bytes));
    // Packs ship PNGs with wrong chunk checksums (a server's obfuscated pack);
    // the game's other pack textures decode them, as stb_image does.
    // rust: decoder.ignore_checksums(true);
    // rust: decoder.set_transformations(png::Transformations::EXPAND | png::Transformations::STRIP_16);
    // rust: let mut reader = decoder.read_info().ok()?;
    // rust: let mut buf = vec![0; reader.output_buffer_size()?];
    // rust: let info = reader.next_frame(&mut buf).ok()?;
    // rust: let pixels = &buf[..info.buffer_size()];
    // rust: let rgba: Vec<f32> = match info.color_type {
    // rust: png::ColorType::Rgba => pixels.iter().map(|&b| b as f32 / 255.0).collect(),
    // rust: png::ColorType::Rgb => pixels
    // rust: .chunks_exact(3)
    // rust: .flat_map(|p| [p[0], p[1], p[2], 255])
    // rust: .map(|b| b as f32 / 255.0)
    // rust: .collect(),
    // rust: png::ColorType::GrayscaleAlpha => pixels
    // rust: .chunks_exact(2)
    // rust: .flat_map(|p| [p[0], p[0], p[0], p[1]])
    // rust: .map(|b| b as f32 / 255.0)
    // rust: .collect(),
    // rust: png::ColorType::Grayscale => pixels
    // rust: .iter()
    // rust: .flat_map(|&g| [g, g, g, 255])
    // rust: .map(|b| b as f32 / 255.0)
    // rust: .collect(),
    // rust: png::ColorType::Indexed => return None,
}
    // rust: Some(Texture {
    // rust: dim: Dim::D2,
    // rust: size: [info.width, info.height, 1],
    // rust: format: Format::RGBA8,
    // rust: texels: Texels::Float(rgba),
    // rust: blur: false,
    // rust: clamp: false,
    // rust: raw: false,
    // rust: })
}

/// The largest size a raw texture may give one of its dimensions.
pub const MAX_SIZE: u32 = 16384;

/// A raw dump: `<type> <internalFormat> <dimensions...> <pixelFormat> <pixelType>`, its rows
/// tightly packed, or padded to four bytes as GL unpacks by default.
pub fn raw(bytes: []const u8, words: *[[]const u8]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (dim, dims) = match words[0] {
    // rust: "TEXTURE_1D" => (Dim::D1, 1),
    // rust: "TEXTURE_2D" | "TEXTURE_RECTANGLE" => (Dim::D2, 2),
    // rust: "TEXTURE_3D" => (Dim::D3, 3),
    // rust: t => return Err(format!("unknown texture type `{t}`")),
}
    // rust: if words.len() != 4 + dims {
    // rust: return Err(format!("`{}` takes {dims} sizes", words[0]));
}
    // rust: let format = Format::parse(words[1]).ok_or_else(|| format!("unknown format `{}`", words[1]))?;
    // rust: let mut size = [1u32; 3];
    // rust: for (k, w) in words[2..2 + dims].iter().enumerate() {
    // rust: size[k] = w
    // rust: .parse()
    // rust: .ok()
    // rust: .filter(|&n| n > 0 && n <= MAX_SIZE)
    // rust: .ok_or(format!("bad size `{w}`"))?;
}
    // rust: let (pixel_format, pixel_type) = (words[2 + dims], words[3 + dims]);
    // rust: let integer = pixel_format.ends_with("_INTEGER");
    // rust: let order: &[usize] = match pixel_format.trim_end_matches("_INTEGER") {
    // rust: "RED" | "R" | "LUMINANCE" => &[0],
    // rust: "GREEN" => &[1],
    // rust: "BLUE" => &[2],
    // rust: "ALPHA" => &[3],
    // rust: "RG" => &[0, 1],
    // rust: "RGB" => &[0, 1, 2],
    // rust: "BGR" => &[2, 1, 0],
    // rust: "RGBA" => &[0, 1, 2, 3],
    // rust: "BGRA" => &[2, 1, 0, 3],
    // rust: f => return Err(format!("unknown pixel format `{f}`")),
}
    // rust: let (width, read): (usize, fn(&[u8]) -> Value) = match pixel_type {
    // rust: "UNSIGNED_BYTE" => (1, |b| Value::U(b[0] as u32, u8::MAX as f32)),
    // rust: "BYTE" => (1, |b| Value::I(b[0] as i8 as i32, i8::MAX as f32)),
    // rust: "UNSIGNED_SHORT" => (2, |b| {
    // rust: Value::U(u16::from_le_bytes([b[0], b[1]]) as u32, u16::MAX as f32)
    // rust: }),
    // rust: "SHORT" => (2, |b| {
    // rust: Value::I(i16::from_le_bytes([b[0], b[1]]) as i32, i16::MAX as f32)
    // rust: }),
    // rust: "UNSIGNED_INT" => (4, |b| {
    // rust: Value::U(
    // rust: u32::from_le_bytes([b[0], b[1], b[2], b[3]]),
    // rust: u32::MAX as f32,
    // rust: )
    // rust: }),
    // rust: "INT" => (4, |b| {
    // rust: Value::I(
    // rust: i32::from_le_bytes([b[0], b[1], b[2], b[3]]),
    // rust: i32::MAX as f32,
    // rust: )
    // rust: }),
    // rust: "HALF_FLOAT" => (2, |b| {
    // rust: Value::F(half::f16::from_le_bytes([b[0], b[1]]).to_f32())
    // rust: }),
    // rust: "FLOAT" => (4, |b| {
    // rust: Value::F(f32::from_le_bytes([b[0], b[1], b[2], b[3]]))
    // rust: }),
    // rust: t => return Err(format!("unknown pixel type `{t}`")),
}
    // rust: let texel = order.len() * width;
    // rust: let row = size[0] as usize * texel;
    // rust: let rows = size[1] as usize * size[2] as usize;
    // rust: let padded = row.next_multiple_of(4);
    // rust: let wanted = |stride: usize| stride.checked_mul(rows - 1)?.checked_add(row);
    // rust: let stride = if padded != row && wanted(padded).is_some_and(|n| bytes.len() >= n) {
    // rust: padded
    // rust: } else {
    // rust: row
}
    // rust: match wanted(stride) {
    // rust: Some(n) if bytes.len() >= n => {}
    // rust: n => {
    // rust: return Err(format!(
    // rust: "{} bytes, {} wanted",
    // rust: bytes.len(),
    // rust: n.map_or_else(|| "more than that".into(), |n| n.to_string())
    // rust: ));
}
}
    // rust: let out = components(format.channels);
    // rust: let count = size[0] as usize * rows;
    // rust: let mut values = Vec::with_capacity(count * out);
    // rust: for r in 0..rows {
    // rust: for x in 0..size[0] as usize {
    // rust: let at = r * stride + x * texel;
    // rust: let mut rgba = [Value::F(0.0), Value::F(0.0), Value::F(0.0), Value::F(1.0)];
    // rust: for (k, &c) in order.iter().enumerate() {
    // rust: rgba[c] = read(&bytes[at + k * width..]);
}
    // rust: values.extend_from_slice(&rgba[..out]);
}
}
    // rust: let texels = match format.kind {
    // rust: Kind::Int => Texels::Int(values.iter().map(|v| v.int()).collect()),
    // rust: Kind::Uint => Texels::Uint(values.iter().map(|v| v.int() as u32).collect()),
        // Integer data fills normalized and float formats normalized, as GL unpacks it.
    // rust: _ => Texels::Float(values.iter().map(|v| v.float(!integer)).collect()),
}
    // rust: Ok(Texture {
    // rust: dim,
    // rust: size,
    // rust: format,
    // rust: texels,
    // rust: blur: true,
    // rust: clamp: true,
    // rust: raw: true,
    // rust: })
}

pub const Value = enum {
    U(u32, f32),
    I(i32, f32),
    F(f32),
};

    // rust: impl Value {
pub fn float(self: *Self, normalize: bool) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Value::U(v, max) if normalize => v as f32 / max,
    // rust: Value::I(v, max) if normalize => (v as f32 / max).max(-1.0),
    // rust: Value::U(v, _) => v as f32,
    // rust: Value::I(v, _) => v as f32,
    // rust: Value::F(v) => v,
}
}

pub fn int(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Value::U(v, _) => v as i32,
    // rust: Value::I(v, _) => v,
    // rust: Value::F(v) => v as i32,
}
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::Macros;
//     use crate::pack::tests::zip;

pub fn half(v: f32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: half::f16::from_f32(v).to_le_bytes()
}

pub fn a_png_with_a_wrong_header_checksum_decodes() void {
}
    // rust: let mut encoded = Vec::new();
    // rust: {
    // rust: let mut encoder = png::Encoder::new(&mut encoded, 2, 1);
    // rust: encoder.set_color(png::ColorType::Rgba);
    // rust: encoder.set_depth(png::BitDepth::Eight);
    // rust: let mut writer = encoder.write_header().unwrap();
    // rust: writer
    // rust: .write_image_data(&[255, 0, 0, 255, 0, 255, 0, 255])
    // rust: .unwrap();
    // rust: writer.finish().unwrap();
}
    // rust: let ihdr = encoded.windows(4).position(|w| w == b"IHDR").unwrap();
    // rust: encoded[ihdr + 4 + 13] ^= 0xFF;
    // rust: assert!(decode_png(&encoded).is_some());
}

pub fn raw_sizes_are_bounded() void {
}
    // rust: let huge = raw(
    // rust: &[0; 64],
    // rust: &[
    // rust: "TEXTURE_3D",
    // rust: "RGBA8",
    // rust: "4",
    // rust: "65536",
    // rust: "65536",
    // rust: "RGBA",
    // rust: "UNSIGNED_BYTE",
    // rust: ],
    // rust: );
    // rust: assert_eq!(huge.err().as_deref(), Some("bad size `65536`"));
    // rust: let big = raw(
    // rust: &[0; 64],
    // rust: &[
    // rust: "TEXTURE_3D",
    // rust: "RGBA8",
    // rust: "4",
    // rust: "16384",
    // rust: "16384",
    // rust: "RGBA",
    // rust: "UNSIGNED_BYTE",
    // rust: ],
    // rust: );
    // rust: assert!(big.is_err_and(|e| e.starts_with("64 bytes")));
}

    /// Iris's `customTexture.<name>`: a raw 3D texture (Shrimple's `texClouds`) under a sampler
    /// name of its own, for every stage; `texture.*` beside it keeps its stage.
pub fn custom_textures_are_for_every_stage() void {
}
        // 2x2x2 RGBA8: texel i holds (i, 255 - i, 7, 255), x fastest.
    // rust: let raw: Vec<u8> = (0..8u8).flat_map(|i| [i, 255 - i, 7, 255]).collect();
    // rust: let files = [("shaders/clouds.dat", raw.as_slice())];
    // rust: let pack = Pack::from_zip_bytes("P.zip", zip(&files)).unwrap();
    // rust: let properties = "customTexture.texClouds = clouds.dat TEXTURE_3D RGBA8 2 2 2 RGBA UNSIGNED_BYTE\n\
    // rust: customTexture.gone = gone.png\n\
    // rust: texture.composite.colortex5 = clouds.dat TEXTURE_3D RGBA8 2 2 2 RGBA UNSIGNED_BYTE\n";
    // rust: let (textures, notes) =
    // rust: load_textures(&pack, &Properties::parse(properties, &Macros::standard()));
    // rust: assert_eq!(notes, ["`customTexture.gone`: can't find `gone.png`"]);
    // rust: let found: Vec<(&str, &str)> = textures
    // rust: .iter()
    // rust: .map(|t| (t.stage.as_str(), t.name.as_str()))
    // rust: .collect();
    // rust: assert_eq!(
    // rust: found,
    // rust: [(EVERY_STAGE, "texClouds"), ("composite", "colortex5")]
    // rust: );
    // rust: let TextureSource::Image(clouds) = &textures[0].source else {
    // rust: panic!("{:?}", textures[0].source);
}
    // rust: assert_eq!((clouds.dim, clouds.size), (Dim::D3, [2, 2, 2]));
    // rust: let expected: Vec<f32> = (0..8)
    // rust: .flat_map(|i| [i as f32 / 255.0, (255 - i) as f32 / 255.0, 7.0 / 255.0, 1.0])
    // rust: .collect();
    // rust: assert_eq!(clouds.texels, Texels::Float(expected));
}

pub fn raw_textures_and_their_stages() void {
}
        // A 2x1x2 RGB16F LUT, an R8 texture with a suffix to keep its key apart, a PNG with
        // its mcmeta, the noise texture and a resource.
    // rust: let lut: Vec<u8> = (0..4)
    // rust: .flat_map(|i| [half(i as f32), half(0.5), half(-1.0)])
    // rust: .flatten()
    // rust: .collect();
    // rust: let mut png = Vec::new();
    // rust: {
    // rust: let mut e = png::Encoder::new(&mut png, 1, 1);
    // rust: e.set_color(png::ColorType::Rgb);
    // rust: e.set_depth(png::BitDepth::Eight);
    // rust: e.write_header()
    // rust: .unwrap()
    // rust: .write_image_data(&[255, 0, 51])
    // rust: .unwrap();
}
    // rust: let properties = "texture.deferred.depthtex0 = lut.dat TEXTURE_3D RGB16F 2 1 2 RGB HALF_FLOAT\n\
    // rust: texture.composite.colortex6.1 = r8.dat TEXTURE_2D R8 2 2 RED UNSIGNED_BYTE\n\
    // rust: texture.gbuffers.gaux1 = sky.png\ntexture.noise = sky.png\n\
    // rust: texture.composite.colortex3 = minecraft:dynamic/lightmap_1\n\
    // rust: texture.composite.gaux2 = gone.png\n";
    // rust: let r8 = [0u8, 255, 0, 0, 51, 0, 0, 0];
    // rust: let files = [
    // rust: ("shaders/lut.dat", lut.as_slice()),
    // rust: ("shaders/r8.dat", r8.as_slice()),
    // rust: ("shaders/sky.png", png.as_slice()),
    // rust: (
    // rust: "shaders/sky.png.mcmeta",
    // rust: b"{\"texture\": {\"blur\": true, \"clamp\":true}}".as_slice(),
    // rust: ),
    // rust: ];
    // rust: let pack = Pack::from_zip_bytes("P.zip", zip(&files)).unwrap();
    // rust: let (textures, notes) =
    // rust: load_textures(&pack, &Properties::parse(properties, &Macros::standard()));
    // rust: assert_eq!(notes, ["`texture.composite.gaux2`: can't find `gone.png`"]);
    // rust: let names: Vec<(&str, &str)> = textures
    // rust: .iter()
    // rust: .map(|t| (t.stage.as_str(), t.name.as_str()))
    // rust: .collect();
    // rust: assert_eq!(
    // rust: names,
    // rust: [
    // rust: ("deferred", "depthtex0"),
    // rust: ("composite", "colortex6"),
    // rust: ("gbuffers", "gaux1"),
    // rust: ("noise", "noise"),
    // rust: ("composite", "colortex3")
    // rust: ]
    // rust: );
    // rust: let image = |i: usize| match &textures[i].source {
    // rust: TextureSource::Image(t) => t,
    // rust: s => panic!("{s:?}"),
}
    // rust: let lut = image(0);
    // rust: assert_eq!(
    // rust: (lut.dim, lut.size, lut.components()),
    // rust: (Dim::D3, [2, 1, 2], 4)
    // rust: );
    // rust: assert_eq!(
    // rust: lut.texels,
    // rust: Texels::Float((0..4).flat_map(|i| [i as f32, 0.5, -1.0, 1.0]).collect())
    // rust: );
        // Rows of 2 bytes, padded to 4.
    // rust: assert_eq!(image(1).texels, Texels::Float(vec![0.0, 1.0, 0.2, 0.0]));
    // rust: let sky = image(2);
    // rust: assert!(sky.blur && sky.clamp);
    // rust: assert_eq!(sky.texels, Texels::Float(vec![1.0, 0.0, 0.2, 1.0]));
    // rust: assert!(
    // rust: matches!(&textures[4].source, TextureSource::Resource(r) if r == "minecraft:dynamic/lightmap_1")
    // rust: );
}

    /// Raw textures are linear and clamped, PNGs nearest and repeating, and each key of a
    /// `.mcmeta` overrides its own default only (Iris 1.11.7 with a probe pack of ours, #9064).
pub fn raw_textures_are_linear_and_clamped_unless_their_mcmeta_says_otherwise() void {
}
    // rust: let mut png = Vec::new();
    // rust: {
    // rust: let mut e = png::Encoder::new(&mut png, 1, 1);
    // rust: e.set_color(png::ColorType::Rgba);
    // rust: e.set_depth(png::BitDepth::Eight);
    // rust: e.write_header()
    // rust: .unwrap()
    // rust: .write_image_data(&[1, 2, 3, 4])
    // rust: .unwrap();
}
    // rust: let texel = [1u8, 2, 3, 4];
    // rust: let files = [
    // rust: ("shaders/a.dat", texel.as_slice()),
    // rust: ("shaders/b.dat", texel.as_slice()),
    // rust: ("shaders/b.dat.mcmeta", b"{\"texture\": {\"blur\": true}}"),
    // rust: ("shaders/c.dat", texel.as_slice()),
    // rust: ("shaders/c.dat.mcmeta", b"{\"texture\": {\"clamp\": false}}"),
    // rust: ("shaders/d.dat", texel.as_slice()),
    // rust: ("shaders/d.dat.mcmeta", b"{\"texture\": {\"blur\": false}}"),
    // rust: ("shaders/p.png", png.as_slice()),
    // rust: ("shaders/q.png", png.as_slice()),
    // rust: ("shaders/q.png.mcmeta", b"{\"texture\": {\"blur\": true}}"),
    // rust: ];
    // rust: let pack = Pack::from_zip_bytes("P.zip", zip(&files)).unwrap();
    // rust: let raw = "TEXTURE_2D RGBA8 1 1 RGBA UNSIGNED_BYTE";
    // rust: let properties = format!(
    // rust: "customTexture.a = a.dat {raw}\ncustomTexture.b = b.dat {raw}\n\
    // rust: texture.composite.c = c.dat {raw}\ntexture.composite.d = d.dat {raw}\n\
    // rust: customTexture.p = p.png\ntexture.composite.gaux2 = q.png\n"
    // rust: );
    // rust: let (textures, notes) =
    // rust: load_textures(&pack, &Properties::parse(&properties, &Macros::standard()));
    // rust: assert!(notes.is_empty(), "{notes:?}");
    // rust: let found: Vec<(&str, bool, bool)> = textures
    // rust: .iter()
    // rust: .map(|t| match &t.source {
    // rust: TextureSource::Image(i) => (t.name.as_str(), i.blur, i.clamp),
    // rust: s => panic!("{s:?}"),
    // rust: })
    // rust: .collect();
    // rust: assert_eq!(
    // rust: found,
    // rust: [
    // rust: ("a", true, true),
    // rust: ("b", true, true),
    // rust: ("c", true, false),
    // rust: ("d", false, true),
    // rust: ("p", false, false),
    // rust: ("gaux2", true, false),
    // rust: ]
    // rust: );
}

    /// A texture may name one of the game's (`minecraft:textures/environment/clouds.png`): it is
    /// read from the game's resources with its `.mcmeta`. The generated lightmap stays for the
    /// renderer; a missing one, or a location reaching outside the resources, is dropped.
pub fn game_textures_come_from_the_game_resources() void {
}
    // rust: let mut png = Vec::new();
    // rust: {
    // rust: let mut e = png::Encoder::new(&mut png, 2, 1);
    // rust: e.set_color(png::ColorType::Rgba);
    // rust: e.set_depth(png::BitDepth::Eight);
    // rust: e.write_header()
    // rust: .unwrap()
    // rust: .write_image_data(&[255, 0, 0, 255, 0, 0, 255, 128])
    // rust: .unwrap();
}
    // rust: let properties = "customTexture.clouds = minecraft:textures/environment/clouds.png\n\
    // rust: texture.composite.gaux2 = minecraft:textures/block/stone.png\n\
    // rust: texture.composite.colortex3 = minecraft:dynamic/lightmap_1\n\
    // rust: customTexture.gone = minecraft:textures/none.png\n\
    // rust: customTexture.escape = minecraft:../../secret.png\n";
    // rust: let pack = Pack::from_zip_bytes("P.zip", zip(&[("shaders/final.fsh", "")])).unwrap();
    // rust: let (mut textures, notes) =
    // rust: load_textures(&pack, &Properties::parse(properties, &Macros::standard()));
    // rust: assert!(notes.is_empty(), "{notes:?}");
    // rust: let read = |namespace: &str, path: &str| match (namespace, path) {
    // rust: ("minecraft", "textures/environment/clouds.png" | "textures/block/stone.png") => {
    // rust: Some(png.clone())
}
    // rust: ("minecraft", "textures/block/stone.png.mcmeta") => {
    // rust: Some(b"{\"texture\": {\"blur\": true}}".to_vec())
}
    // rust: ("minecraft", p) if p.contains("secret") => Some(png.clone()),
    // rust: _ => None,
}
    // rust: let notes = resolve_resources(&mut textures, &read);
    // rust: let names: Vec<&str> = textures.iter().map(|t| t.name.as_str()).collect();
    // rust: assert_eq!(names, ["clouds", "gaux2", "colortex3"], "{notes:?}");
    // rust: assert_eq!(notes.len(), 2, "{notes:?}");
    // rust: for (t, blur) in [(&textures[0], false), (&textures[1], true)] {
    // rust: let TextureSource::Image(image) = &t.source else {
    // rust: panic!("{} was not read", t.name);
}
    // rust: assert_eq!(image.size, [2, 1, 1]);
    // rust: assert_eq!(
    // rust: image.texels,
    // rust: Texels::Float(vec![1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 128.0 / 255.0])
    // rust: );
    // rust: assert_eq!((image.blur, image.clamp), (blur, false), "{}", t.name);
}
    // rust: assert!(
    // rust: matches!(&textures[2].source, TextureSource::Resource(r) if r == "minecraft:dynamic/lightmap_1")
    // rust: );
}
}
