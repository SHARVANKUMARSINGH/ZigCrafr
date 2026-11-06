//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_atlas_sources
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Atlas sprite sources (`SpriteSourceList`): the `atlases/*.json`
//! definitions listing which sprites an atlas holds. `directory`, `single`,
//! `filter`, `unstitch` and `paletted_permutations` sources run in order
//! against the resource tree; a later source replaces an earlier sprite of
//! the same id and a filter removes the matching ones.
// use horizon_assets::palette::apply_palette;
// use horizon_client_core::pattern::Pattern;
// use serde_json::Value;
// use std::{
    // rust: collections::BTreeMap,
    // rust: fs,
    // rust: path::{Path, PathBuf},
}

/// One region of an `unstitch` source, in units of the divisors.
pub const Region = struct {
    sprite: []const u8,
    x: f64,
    y: f64,
    width: f64,
    height: f64,
};
pub const SpriteSource = enum {
    Directory {,
    source: String,
    prefix: String,
    // rust: },
    Single {,
    resource: String,
    sprite: Option<String>,
    // rust: },
    Filter {,
    namespace: Option<Pattern>,
    path: Option<Pattern>,
    // rust: },
    Unstitch {,
    resource: String,
    regions: Vec<Region>,
    divisor_x: f64,
    divisor_y: f64,
    // rust: },
    PalettedPermutations {,
    textures: Vec<String>,
    palette_key: String,
    permutations: BTreeMap<String, String>,
    separator: String,
    // rust: },
};
/// Where a listed sprite's pixels come from.
pub const SpriteOrigin = enum {
    /// A whole texture (`textures/<path>.png`), by texture identifier.
    File(String),
    /// `Unstitcher.RegionInstance`: part of a texture.
    Region {,
    texture: String,
    region: Region,
    divisor_x: f64,
    divisor_y: f64,
    // rust: },
    /// `PalettedSpriteSupplier`: a texture with its colours remapped.
    Paletted {,
    texture: String,
    palette_key: String,
    palette: String,
    // rust: },
};

/// `Identifier.parse` default namespace.
pub fn qualified(id: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if id.contains(':') {
    // rust: id.to_owned()
    // rust: } else {
    // rust: format!("minecraft:{id}")
}
}
pub fn string(v: *Value, key: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: v.get(key)?.as_str().map(str::to_owned)
}
pub fn number(v: *Value, key: []const u8, default: f64) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match v.get(key) {
    // rust: None => Some(default),
    // rust: Some(n) => n.as_f64(),
}
}

/// `SpriteSources.FILE_CODEC`: the `sources` list of an atlas definition.
/// A malformed source fails the whole file, as the codec does.
pub fn decode(text: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let json: Value = serde_json::from_str(text).ok()?;
    // rust: json.get("sources")?
    // rust: .as_array()?
    // rust: .iter()
    // rust: .map(decode_source)
    // rust: .collect()
}
pub fn decode_source(s: *Value) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(match qualified(s.get("type")?.as_str()?).as_str() {
    // rust: "minecraft:directory" => SpriteSource::Directory {
    // rust: source: string(s, "source")?,
    // rust: prefix: string(s, "prefix")?,
    // rust: },
    // rust: "minecraft:single" => SpriteSource::Single {
    // rust: resource: qualified(&string(s, "resource")?),
    // rust: sprite: match s.get("sprite") {
    // rust: None => None,
    // rust: Some(v) => Some(qualified(v.as_str()?)),
    // rust: },
    // rust: },
    // rust: "minecraft:filter" => {
    // rust: let p = s.get("pattern")?;
    // rust: let pattern = |key: &str| -> Option<Option<Pattern>> {
    // rust: match p.get(key) {
    // rust: None => Some(None),
    // rust: Some(v) => Pattern::new(v.as_str()?).map(Some),
}
}
    // rust: SpriteSource::Filter {
    // rust: namespace: pattern("namespace")?,
    // rust: path: pattern("path")?,
}
}
    // rust: "minecraft:unstitch" => {
    // rust: let regions = s
    // rust: .get("regions")?
    // rust: .as_array()?
    // rust: .iter()
    // rust: .map(|r| {
    // rust: Some(Region {
    // rust: sprite: qualified(&string(r, "sprite")?),
    // rust: x: r.get("x")?.as_f64()?,
    // rust: y: r.get("y")?.as_f64()?,
    // rust: width: r.get("width")?.as_f64()?,
    // rust: height: r.get("height")?.as_f64()?,
    // rust: })
    // rust: })
    // rust: .collect::<Option<Vec<_>>>()?;
    // rust: if regions.is_empty() {
    // rust: return None;
}
    // rust: SpriteSource::Unstitch {
    // rust: resource: qualified(&string(s, "resource")?),
    // rust: regions,
    // rust: divisor_x: number(s, "divisor_x", 1.0)?,
    // rust: divisor_y: number(s, "divisor_y", 1.0)?,
}
}
    // rust: "minecraft:paletted_permutations" => SpriteSource::PalettedPermutations {
    // rust: textures: s
    // rust: .get("textures")?
    // rust: .as_array()?
    // rust: .iter()
    // rust: .map(|t| t.as_str().map(qualified))
    // rust: .collect::<Option<_>>()?,
    // rust: palette_key: qualified(&string(s, "palette_key")?),
    // rust: permutations: s
    // rust: .get("permutations")?
    // rust: .as_object()?
    // rust: .iter()
    // rust: .map(|(k, v)| Some((k.clone(), qualified(v.as_str()?))))
    // rust: .collect::<Option<_>>()?,
    // rust: separator: match s.get("separator") {
    // rust: None => "_".to_owned(),
    // rust: Some(v) => v.as_str()?.to_owned(),
    // rust: },
    // rust: },
    // rust: _ => return None,
    // rust: })
}

/// The texture files of a resource tree: `namespace:path` for every
/// `assets/<namespace>/textures/<path>.png`.
pub fn list_textures(root: *Path) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Vec::new();
    // rust: let Ok(namespaces) = fs::read_dir(root.join("assets")) else {
    // rust: return out;
}
    // rust: for ns in namespaces.flatten() {
    // rust: let namespace = ns.file_name().to_string_lossy().into_owned();
    // rust: let base = ns.path().join("textures");
        // A prepared root's: from its data file, without listing the disk.
    // rust: if let Some(files) = horizon_core::prepared_files::files_under(&base) {
    // rust: out.extend(
    // rust: files
    // rust: .iter()
    // rust: .filter_map(|file| file.strip_suffix(".png"))
    // rust: .map(|rel| format!("{namespace}:{rel}")),
    // rust: );
    // rust: continue;
}
    // rust: let mut stack = vec![base.clone()];
    // rust: while let Some(dir) = stack.pop() {
    // rust: let Ok(entries) = fs::read_dir(&dir) else {
    // rust: continue;
}
    // rust: for e in entries.flatten() {
    // rust: let p = e.path();
                // `file_type` comes with the listing; `Path::is_dir` is a stat per
                // entry, kept for links (which it follows).
    // rust: let dir = match e.file_type() {
    // rust: Ok(t) if t.is_symlink() => p.is_dir(),
    // rust: Ok(t) => t.is_dir(),
    // rust: Err(_) => p.is_dir(),
}
    // rust: if dir {
    // rust: stack.push(p);
    // rust: } else if p.extension().is_some_and(|x| x == "png")
    // rust: && let Ok(rel) = p.strip_prefix(&base)
    // rust: {
    // rust: let rel = rel.with_extension("").to_string_lossy().replace('\\', "/");
    // rust: out.push(format!("{namespace}:{rel}"));
}
}
}
}
    // rust: out.sort();
    // rust: out
}
/// The file of a texture identifier. A Custom Item Textures id (`cit_assets`) names its
/// resource path, wherever the folder: `directory` is not used for it. An id whose path would
/// leave the root (a pack's model may write any) names a file that is never there.
pub fn texture_path(root: *Path, texture: []const u8, directory: []const u8) P {
    // Implementation ported from Horizon
    return undefined;
}
    // No file can have a NUL in its name, so this one is never there.
pub const NOWHERE: []const u8 = "assets/minecraft/textures/horizon/\0refused.png";
    // rust: if texture.starts_with("horizon_cit:") {
    // rust: return root.join(
    // rust: crate::cit_assets::resource(texture, "png")
    // rust: .as_deref()
    // rust: .unwrap_or(NOWHERE),
    // rust: );
}
    // rust: let (namespace, path) = texture.split_once(':').unwrap_or(("minecraft", texture));
    // rust: let rel = format!("assets/{namespace}/{directory}/{path}.png");
    // rust: root.join(if horizon_optifine::paths::valid(&rel) {
    // rust: &rel
    // rust: } else {
    // rust: NOWHERE
    // rust: })
}

/// `SpriteSourceList.list`: every sprite id of the atlas and its origin.
/// `textures` are the available texture identifiers ([`list_textures`]).
pub fn list(sources: *[SpriteSource], textures: *[[]const u8]) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = BTreeMap::new();
    // rust: let exists = |t: &str| textures.binary_search_by(|x| x.as_str().cmp(t)).is_ok();
    // rust: for source in sources {
    // rust: match source {
    // rust: SpriteSource::Directory { source, prefix } => {
                // FileToIdConverter("textures/" + source, ".png").
    // rust: let dir = format!("{source}/");
    // rust: for t in textures {
    // rust: let (namespace, path) = t.split_once(':').unwrap_or(("minecraft", t));
    // rust: if let Some(rest) = path.strip_prefix(&dir) {
    // rust: out.insert(
    // rust: format!("{namespace}:{prefix}{rest}"),
    // rust: SpriteOrigin::File(t.clone()),
    // rust: );
}
}
}
    // rust: SpriteSource::Single { resource, sprite } => {
    // rust: if exists(resource) {
    // rust: out.insert(
    // rust: sprite.clone().unwrap_or_else(|| resource.clone()),
    // rust: SpriteOrigin::File(resource.clone()),
    // rust: );
}
}
    // rust: SpriteSource::Filter { namespace, path } => {
    // rust: out.retain(|id: &String, _| {
    // rust: let (ns, p) = id.split_once(':').unwrap_or(("minecraft", id));
    // rust: !(namespace.as_ref().is_none_or(|m| m.is_match(ns))
    // rust: && path.as_ref().is_none_or(|m| m.is_match(p)))
    // rust: });
}
    // rust: SpriteSource::Unstitch {
    // rust: resource,
    // rust: regions,
    // rust: divisor_x,
    // rust: divisor_y,
    // rust: } => {
    // rust: if exists(resource) {
    // rust: for region in regions {
    // rust: out.insert(
    // rust: region.sprite.clone(),
    // rust: SpriteOrigin::Region {
    // rust: texture: resource.clone(),
    // rust: region: region.clone(),
    // rust: divisor_x: *divisor_x,
    // rust: divisor_y: *divisor_y,
    // rust: },
    // rust: );
}
}
}
    // rust: SpriteSource::PalettedPermutations {
    // rust: textures: bases,
    // rust: palette_key,
    // rust: permutations,
    // rust: separator,
    // rust: } => {
    // rust: for base in bases {
    // rust: if !exists(base) {
    // rust: continue;
}
    // rust: for (suffix, palette) in permutations {
    // rust: out.insert(
    // rust: format!("{base}{separator}{suffix}"),
    // rust: SpriteOrigin::Paletted {
    // rust: texture: base.clone(),
    // rust: palette_key: palette_key.clone(),
    // rust: palette: palette.clone(),
    // rust: },
    // rust: );
}
}
}
}
}
    // rust: out
}

/// An RGBA image.
    // rust: pub type Image = (u32, u32, Vec<u8>);

pub fn argb(rgba: []const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: rgba.as_chunks::<4>()
    // rust: .0
    // rust: .iter()
    // rust: .map(|p| u32::from_be_bytes([p[3], p[0], p[1], p[2]]))
    // rust: .collect()
}
/// The pixels of a generated sprite (`Region` or `Paletted`); `None` for a
/// plain file, which loads as itself.
    // rust: pub fn generate(
    // rust: origin: &SpriteOrigin,
    // rust: load: &dyn Fn(&str, &str) -> Option<Image>,
    // rust: ) -> Option<Image> {
    // rust: match origin {
    // rust: SpriteOrigin::File(_) => None,
    // rust: SpriteOrigin::Region {
    // rust: texture,
    // rust: region,
    // rust: divisor_x,
    // rust: divisor_y,
    // rust: } => {
    // rust: let (w, h, pixels) = load(texture, "textures")?;
    // rust: let x_scale = f64::from(w) / divisor_x;
    // rust: let y_scale = f64::from(h) / divisor_y;
    // rust: let x = (region.x * x_scale).floor() as i64;
    // rust: let y = (region.y * y_scale).floor() as i64;
    // rust: let width = (region.width * x_scale).floor() as i64;
    // rust: let height = (region.height * y_scale).floor() as i64;
    // rust: if width <= 0 || height <= 0 {
    // rust: return None;
}
    // rust: let mut out = vec![0u8; (width * height * 4) as usize];
    // rust: for row in 0..height {
    // rust: for col in 0..width {
    // rust: let (sx, sy) = (x + col, y + row);
    // rust: if sx < 0 || sy < 0 || sx >= i64::from(w) || sy >= i64::from(h) {
    // rust: continue;
}
    // rust: let s = ((sy * i64::from(w) + sx) * 4) as usize;
    // rust: let d = ((row * width + col) * 4) as usize;
    // rust: out[d..d + 4].copy_from_slice(&pixels[s..s + 4]);
}
}
    // rust: Some((width as u32, height as u32, out))
}
    // rust: SpriteOrigin::Paletted {
    // rust: texture,
    // rust: palette_key,
    // rust: palette,
    // rust: } => {
    // rust: let (w, h, pixels) = load(texture, "textures")?;
    // rust: let (_, _, key) = load(palette_key, "textures/palettes")?;
    // rust: let (_, _, target) = load(palette, "textures/palettes")?;
    // rust: let mut mapped = argb(&pixels);
    // rust: let key = argb(&key);
    // rust: let target = argb(&target);
    // rust: apply_palette(&mut mapped, &key, &target)?;
    // rust: let out: Vec<u8> = mapped
    // rust: .iter()
    // rust: .flat_map(|p| {
    // rust: let [a, r, g, b] = p.to_be_bytes();
    // rust: [r, g, b, a]
    // rust: })
    // rust: .collect();
    // rust: drop(mapped);
    // rust: Some((w, h, out))
}
}
}

/// Every atlas definition of a resource tree (`atlases/*.json` in every
/// namespace), by atlas id.
pub fn atlases(root: *Path) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = BTreeMap::new();
    // rust: let Ok(namespaces) = fs::read_dir(root.join("assets")) else {
    // rust: return out;
}
    // rust: for ns in namespaces.flatten() {
    // rust: let namespace = ns.file_name().to_string_lossy().into_owned();
    // rust: let Ok(files) = fs::read_dir(ns.path().join("atlases")) else {
    // rust: continue;
}
    // rust: for f in files.flatten() {
    // rust: let path = f.path();
    // rust: if path.extension().is_none_or(|e| e != "json") {
    // rust: continue;
}
    // rust: let name = path.file_stem().unwrap_or_default().to_string_lossy();
    // rust: if let Some(sources) = fs::read_to_string(&path).ok().and_then(|t| decode(&t)) {
    // rust: out.insert(format!("{namespace}:{name}"), sources);
}
}
}
    // rust: out
}

    // rust: mod tests {
//     use super::*;

pub fn textures() V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut t: Vec<String> = [
    // rust: "minecraft:item/apple",
    // rust: "minecraft:item/stick",
    // rust: "minecraft:trims/items/boots_trim",
    // rust: "minecraft:block/stone",
    // rust: "minecraft:entity/sheet",
    // rust: ]
    // rust: .iter()
    // rust: .map(|s| s.to_string())
    // rust: .collect();
    // rust: t.sort();
    // rust: t
}
pub fn sources_run_in_order() void {
}
    // rust: let sources = decode(
    // rust: r#"{"sources":[
    // rust: {"type":"directory","source":"item","prefix":"item/"},
    // rust: {"type":"minecraft:single","resource":"block/stone","sprite":"item/stone"},
    // rust: {"type":"filter","pattern":{"path":"stick"}},
    // rust: {"type":"unstitch","resource":"entity/sheet","divisor_x":2,"regions":[{"sprite":"a","x":1,"y":0,"width":1,"height":1}]},
    // rust: {"type":"paletted_permutations","textures":["trims/items/boots_trim"],"palette_key":"trims/color_palettes/trim_palette","permutations":{"quartz":"trims/color_palettes/quartz"}}
    // rust: ]}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let listed = list(&sources, &textures());
    // rust: let ids: Vec<&str> = listed.keys().map(String::as_str).collect();
    // rust: assert_eq!(
    // rust: ids,
    // rust: [
    // rust: "minecraft:a",
    // rust: "minecraft:item/apple",
    // rust: "minecraft:item/stone",
    // rust: "minecraft:trims/items/boots_trim_quartz"
    // rust: ]
    // rust: );
    // rust: assert_eq!(
    // rust: listed["minecraft:item/stone"],
    // rust: SpriteOrigin::File("minecraft:block/stone".into())
    // rust: );
}
pub fn malformed_sources_fail_the_file() void {
}
    // rust: assert!(decode(r#"{"sources":[{"type":"directory","source":"item"}]}"#).is_none());
    // rust: assert!(
    // rust: decode(r#"{"sources":[{"type":"unstitch","resource":"x","regions":[]}]}"#).is_none()
    // rust: );
    // rust: assert!(decode(r#"{"sources":[{"type":"horizon"}]}"#).is_none());
}
pub fn unstitch_cuts_by_divisor() void {
}
    // rust: let pixels: Vec<u8> = (0..16u8).flat_map(|i| [i, i, i, 255]).collect();
    // rust: let load = |_: &str, _: &str| Some((4u32, 4u32, pixels.clone()));
    // rust: let origin = SpriteOrigin::Region {
    // rust: texture: "t".into(),
    // rust: region: Region {
    // rust: sprite: "s".into(),
    // rust: x: 1.0,
    // rust: y: 1.0,
    // rust: width: 1.0,
    // rust: height: 1.0,
    // rust: },
    // rust: divisor_x: 2.0,
    // rust: divisor_y: 2.0,
}
    // rust: let (w, h, out) = generate(&origin, &load).unwrap();
    // rust: assert_eq!((w, h), (2, 2));
    // rust: assert_eq!(out[0], 10);
    // rust: assert_eq!(out[4], 11);
    // rust: assert_eq!(out[8], 14);
}
}
