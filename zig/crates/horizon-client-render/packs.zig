//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_packs
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Resource packs (PackRepository / FolderRepositorySource): discovery of
//! folder and zip packs in `resourcepacks/` plus the built-in Programmer Art
//! and High Contrast packs, `pack.mcmeta` metadata and format compatibility,
//! and an overlay resource root that layers the enabled packs over the
//! vanilla resources (later packs win), so every loader sees one tree.
    // rust: mod cache;
// use crate::text::Style;
// use crate::{text::Text, zip::Zip};
    // rust: pub use horizon_client_core::pattern;
// use pattern::Pattern;
// use std::{
    // rust: collections::{BTreeMap, BTreeSet},
    // rust: fs, io,
    // rust: path::{Path, PathBuf},
}

/// SharedConstants resource pack format of 26.3 (major, minor).
pub const RESOURCE_FORMAT: (i64, i64) = horizon_core::version::RESOURCE_PACK_FORMAT;

pub const Source = enum {
    Dir(PathBuf),
    Zip(PathBuf),
};
pub const Pack = struct {
    /// `file/<name>` for user packs, the bare name for built-in ones.
    id: []const u8,
    source: Source,
    title: Text,
    description: Text,
    /// The description with its legacy codes, and its root style (the pack screen's).
    raw_description: Text,
    description_style: Style,
    compatible: bool,
    compatibility: crate::pack_screen::Compat,
    /// Overlay directories active for this game version, in `pack.mcmeta` order.
    overlays: std.ArrayList([]const u8),
    /// `filter.block` entries (namespace and path patterns) hiding resources
    /// of the packs below this one.
    filter: std.ArrayList(Filter),
};
pub const Filter = struct {
    namespace: ?Pattern,
    path: ?Pattern,
};
    // rust: impl Filter {
pub fn blocks(self: *Self, file: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(rest) = file.strip_prefix("assets/") else {
    // rust: return false;
}
    // rust: let Some((namespace, path)) = rest.split_once('/') else {
    // rust: return false;
}
    // rust: self.namespace
    // rust: .as_ref()
    // rust: .is_none_or(|p| p.is_match(namespace))
    // rust: && self.path.as_ref().is_none_or(|p| p.is_match(path))
}
}
/// A text component from JSON (strings, `text`, `translate`, arrays, `extra`
/// and the style fields), legacy `§` codes resolved as the font does.
pub fn component(v: *serde_json::Value) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: component_root(v).0.resolve_legacy()
}
/// The component, its legacy codes left in place (each span is a
/// component's contents and style), and its root style (`Component.getStyle`).
pub fn component_root(v: *serde_json::Value) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Text::empty();
    // rust: let root = build(v, &Style::default(), &mut out);
    // rust: (out, root)
}
pub fn style_of(o: *serde_json::Map<[]const u8, serde_json: :Value>) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let flag = |k: &str| o.get(k).and_then(|b| b.as_bool());
    // rust: Style {
    // rust: color: o.get("color").and_then(|c| c.as_str()).and_then(|c| {
    // rust: crate::text::named_color(c).or_else(|| {
    // rust: c.strip_prefix('#')
    // rust: .and_then(|h| u32::from_str_radix(h, 16).ok())
    // rust: })
    // rust: }),
    // rust: bold: flag("bold"),
    // rust: italic: flag("italic"),
    // rust: underlined: flag("underlined"),
    // rust: strikethrough: flag("strikethrough"),
    // rust: obfuscated: flag("obfuscated"),
    // rust: font: o.get("font").and_then(crate::text::font_id),
    // rust: ..Style::default()
}
}
/// Appends `v` under `parent`'s style; returns the component's own style.
pub fn build(v: *serde_json::Value, parent: *Style, out: *mut Text) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match v {
    // rust: serde_json::Value::Array(a) => {
    // rust: let Some(first) = a.first() else {
    // rust: return Style::default();
}
    // rust: let own = build(first, parent, out);
    // rust: let mut style = own.clone();
    // rust: style.inherit(parent);
    // rust: for e in &a[1..] {
    // rust: build(e, &style, out);
}
    // rust: own
}
    // rust: serde_json::Value::Object(o) => {
    // rust: let own = style_of(o);
    // rust: let mut style = own.clone();
    // rust: style.inherit(parent);
    // rust: if let Some(s) = o.get("text").and_then(|s| s.as_str()) {
    // rust: out.push(Text::styled(s, style.clone()));
    // rust: } else if let Some(k) = o.get("translate").and_then(|s| s.as_str()) {
    // rust: let args: Vec<Text> = o
    // rust: .get("with")
    // rust: .and_then(|w| w.as_array())
    // rust: .map(|a| a.iter().map(component).collect())
    // rust: .unwrap_or_default();
    // rust: out.push(Text::translate(k, &args).with_style(&style));
}
    // rust: match o.get("extra") {
    // rust: Some(serde_json::Value::Array(extra)) => {
    // rust: for e in extra {
    // rust: build(e, &style, out);
}
}
    // rust: Some(e) => {
    // rust: build(e, &style, out);
}
    // rust: None => {}
}
    // rust: own
}
    // rust: serde_json::Value::String(s) => {
    // rust: out.push(Text::styled(s.as_str(), parent.clone()));
    // rust: Style::default()
}
    // rust: serde_json::Value::Number(n) => {
    // rust: out.push(Text::styled(n.to_string(), parent.clone()));
    // rust: Style::default()
}
    // rust: serde_json::Value::Bool(b) => {
    // rust: out.push(Text::styled(b.to_string(), parent.clone()));
    // rust: Style::default()
}
    // rust: serde_json::Value::Null => Style::default(),
}
}
pub fn format_of(v: *serde_json::Value) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match v {
    // rust: serde_json::Value::Number(n) => Some((n.as_i64()?, 0)),
    // rust: serde_json::Value::Array(a) => Some((
    // rust: a.first()?.as_i64()?,
    // rust: a.get(1).and_then(|m| m.as_i64()).unwrap_or(0),
    // rust: )),
    // rust: _ => None,
}
}
/// `PackFormat`: major and minor.
    // rust: type Format = (i64, i64);
/// `PackFormat.lastPreMinorVersion`: the last major without minor versions,
/// for the resource pack format (64) or the data pack one (81).
pub fn last_pre_minor(current: Format) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if current.0 == horizon_core::version::DATA_PACK_FORMAT.0 {
    // rust: 81
    // rust: } else {
    // rust: 64
}
}
/// `PackFormat.fullCodec(default_minor)`: an int, or a list of 1 to 256
/// non-negative ints whose second is the minor. None: it does not parse.
pub fn format_codec(v: *serde_json::Value, default_minor: i64) O {
    // Implementation ported from Horizon
    return undefined;
}
    // `Codec.INT` reads any JSON number through `Number.intValue`: a decimal such as `97.1`
    // counts as its whole part (97), as it does for the game.
    // rust: let non_negative = |v: &serde_json::Value| {
    // rust: v.as_i64()
    // rust: .or_else(|| {
    // rust: v.as_f64()
    // rust: .filter(|f| f.is_finite())
    // rust: .map(|f| f.trunc() as i64)
    // rust: })
    // rust: .filter(|n| *n >= 0 && *n <= i64::from(i32::MAX))
}
    // rust: match v {
    // rust: serde_json::Value::Array(a) if (1..=256).contains(&a.len()) => {
    // rust: let list: Option<Vec<i64>> = a.iter().map(non_negative).collect();
    // rust: let list = list?;
    // rust: Some((list[0], list.get(1).copied().unwrap_or(default_minor)))
}
    // rust: serde_json::Value::Array(_) => None,
    // rust: v => Some((non_negative(v)?, default_minor)),
}
}
/// `InclusiveRange.codec(Codec.INT)`: `[min, max]` or
/// `{min_inclusive, max_inclusive}`, min not above max.
pub fn int_range_codec(v: *serde_json::Value) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let int = |v: &serde_json::Value| v.as_i64().filter(|n| i32::try_from(*n).is_ok());
    // rust: let (min, max) = match v {
    // rust: serde_json::Value::Array(a) if a.len() == 2 => (int(&a[0])?, int(&a[1])?),
    // rust: serde_json::Value::Object(o) => {
    // rust: (int(o.get("min_inclusive")?)?, int(o.get("max_inclusive")?)?)
}
    // rust: _ => return None,
}
    // rust: (min <= max).then_some((min, max))
}
/// An `optionalFieldOf`: absent is `Ok(None)`, one that does not parse an error.
    // rust: fn optional<T>(
    // rust: v: &serde_json::Value,
    // rust: parse: impl Fn(&serde_json::Value) -> Option<T>,
    // rust: ) -> Result<Option<T>, ()> {
    // rust: if v.is_null() {
    // rust: Ok(None)
    // rust: } else {
    // rust: parse(v).map(Some).ok_or(())
}
}
/// `PackFormat.IntermediaryFormat.validatePackFormatForRange`.
pub fn validate_pack_format_for_range(main_format: i64, min: i64, max: i64) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if main_format < min || main_format > max {
    // rust: Some(format!(
    // rust: "Pack declared support for versions {min} to {max} but declared main format is {main_format}"
    // rust: ))
    // rust: } else if main_format < 15 {
    // rust: Some("Multi-version packs cannot support minimum version of less than 15, since this will leave versions in range unable to load pack.".into())
    // rust: } else {
    // rust: None
}
}
/// `PackFormat` as `toString` prints it.
pub fn format_text(f: Format) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if f.1 == i64::from(i32::MAX) {
    // rust: format!("{}.*", f.0)
    // rust: } else {
    // rust: format!("{}.{}", f.0, f.1)
}
}
/// `PackFormat.IntermediaryFormat.validate` for a pack's `pack` section
/// (`hasPackFormatField`, no `requireOldField`): the supported range, or why
/// vanilla refuses the metadata (it then falls back to a pack of unknown
/// format).
    // rust: pub fn validate_pack_range(
    // rust: pack: &serde_json::Value,
    // rust: last_pre_minor: i64,
    // rust: ) -> Result<(Format, Format), String> {
pub const CONTEXT: []const u8 = "Pack";
pub const OLD: []const u8 = "supported_formats";
    // rust: let bad = |field: &str| format!("{CONTEXT} field {field} does not parse");
    // rust: let min =
    // rust: optional(&pack["min_format"], |v| format_codec(v, 0)).map_err(|()| bad("min_format"))?;
    // rust: let max = optional(&pack["max_format"], |v| {
    // rust: format_codec(v, i64::from(i32::MAX))
    // rust: })
    // rust: .map_err(|()| bad("max_format"))?;
    // rust: let format = optional(&pack["pack_format"], |v| {
    // rust: v.as_i64().filter(|n| i32::try_from(*n).is_ok())
    // rust: })
    // rust: .map_err(|()| bad("pack_format"))?;
    // rust: let supported = optional(&pack[OLD], int_range_codec).map_err(|()| bad(OLD))?;
    // rust: if min.is_some() != max.is_some() {
    // rust: return Err(format!(
    // rust: "{CONTEXT} missing field, must declare both min_format and max_format"
    // rust: ));
}
    // rust: if let (Some(min), Some(max)) = (min, max) {
    // rust: return validate_new_format(min, max, format, supported, last_pre_minor);
}
    // rust: if let Some(supported) = supported {
    // rust: return validate_old_format(supported, format, last_pre_minor);
}
    // rust: match format {
    // rust: Some(main) if main > last_pre_minor => Err(format!(
    // rust: "{CONTEXT} declares support for version newer than {last_pre_minor}, but is missing mandatory fields min_format and max_format"
    // rust: )),
    // rust: Some(main) => Ok(((main, 0), (main, 0))),
    // rust: None => Err(format!(
    // rust: "{CONTEXT} could not be parsed, missing format version information"
    // rust: )),
}
}
/// `PackFormat.IntermediaryFormat.validateNewFormat`.
    // rust: fn validate_new_format(
    // rust: min: Format,
    // rust: max: Format,
    // rust: format: Option<i64>,
    // rust: supported: Option<(i64, i64)>,
    // rust: last_pre_minor: i64,
    // rust: ) -> Result<(Format, Format), String> {
pub const OLD: []const u8 = "supported_formats";
    // rust: let (major_min, major_max) = (min.0, max.0);
    // rust: if min > max {
    // rust: return Err(format!(
    // rust: "Pack min_format ({}) is greater than max_format ({})",
    // rust: format_text(min),
    // rust: format_text(max)
    // rust: ));
}
    // rust: if major_min > last_pre_minor {
    // rust: if supported.is_some() {
    // rust: return Err(format!(
    // rust: "Pack key {OLD} is deprecated starting from pack format {}. Remove {OLD} from your pack.mcmeta.",
    // rust: last_pre_minor + 1
    // rust: ));
}
    // rust: if let Some(main) = format
    // rust: && let Some(error) = validate_pack_format_for_range(main, major_min, major_max)
    // rust: {
    // rust: return Err(error);
}
    // rust: } else {
    // rust: let Some(old) = supported else {
    // rust: return Err(format!(
    // rust: "Pack declares support for format {major_min}, but game versions supporting formats 15 to {last_pre_minor} require a {OLD} field. Add \"{OLD}\": [{major_min}, {last_pre_minor}] or require a version greater or equal to {}.0.",
    // rust: last_pre_minor + 1
    // rust: ));
}
    // rust: if old.0 != major_min {
    // rust: return Err(format!(
    // rust: "Pack version declaration mismatch between {OLD} (from {}) and min_format ({})",
    // rust: old.0,
    // rust: format_text(min)
    // rust: ));
}
    // rust: if old.1 != major_max && old.1 != last_pre_minor {
    // rust: return Err(format!(
    // rust: "Pack version declaration mismatch between {OLD} (up to {}) and max_format ({})",
    // rust: old.1,
    // rust: format_text(max)
    // rust: ));
}
    // rust: let Some(main) = format else {
    // rust: return Err(format!(
    // rust: "Pack declares support for formats up to {last_pre_minor}, but game versions supporting formats 15 to {last_pre_minor} require a pack_format field. Add \"pack_format\": {major_min} or require a version greater or equal to {}.0.",
    // rust: last_pre_minor + 1
    // rust: ));
}
    // rust: if let Some(error) = validate_pack_format_for_range(main, major_min, major_max) {
    // rust: return Err(error);
}
}
    // rust: Ok((min, max))
}
/// `PackFormat.IntermediaryFormat.validateOldFormat`.
    // rust: fn validate_old_format(
    // rust: supported: (i64, i64),
    // rust: format: Option<i64>,
    // rust: last_pre_minor: i64,
    // rust: ) -> Result<(Format, Format), String> {
    // rust: let (min, max) = supported;
    // rust: if max > last_pre_minor {
    // rust: return Err(format!(
    // rust: "Pack declares support for version newer than {last_pre_minor}, but is missing mandatory fields min_format and max_format"
    // rust: ));
}
    // rust: let Some(main) = format else {
    // rust: return Err(format!(
    // rust: "Pack declares support for formats up to {last_pre_minor}, but game versions supporting formats 15 to {last_pre_minor} require a pack_format field. Add \"pack_format\": {min} or require a version greater or equal to {}.0.",
    // rust: last_pre_minor + 1
    // rust: ));
}
    // rust: if let Some(error) = validate_pack_format_for_range(main, min, max) {
    // rust: return Err(error);
}
    // rust: Ok(((min, 0), (max, 0)))
}
/// PackCompatibility: inside the pack's declared range.
pub fn compatible(meta: *serde_json::Value) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: compatibility(meta) == crate::pack_screen::Compat::Compatible
}
/// `PackCompatibility.forVersion`: too old, too new, compatible, or unknown
/// when the metadata names no (valid) format.
pub fn compatibility(meta: *serde_json::Value) c {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: compatibility_for(meta, RESOURCE_FORMAT)
}
/// `compatibility` against `current`, the resource or the data pack format.
/// Metadata that fails `PackFormat.packCodec` parses as the fallback type,
/// whose format is `Integer.MAX_VALUE`: unknown.
pub fn compatibility_for(meta: *serde_json::Value, current: Format) c {
    // Implementation ported from Horizon
    return undefined;
}
//     use crate::pack_screen::Compat;
    // rust: match validate_pack_range(&meta["pack"], last_pre_minor(current)) {
    // rust: Err(_) => Compat::Unknown,
    // rust: Ok((_, max)) if max < current => Compat::TooOld,
    // rust: Ok((min, _)) if current < min => Compat::TooNew,
    // rust: Ok(_) => Compat::Compatible,
}
}
/// Whether an `overlays.entries[]` item applies to the current format
/// (OverlayMetadataSection: `formats` as an int, `[min, max]` or
/// `{min_inclusive, max_inclusive}`, or `min_format`/`max_format`).
pub fn overlay_applies(entry: *serde_json::Value) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let current = RESOURCE_FORMAT;
    // rust: if let (Some(min), Some(max)) = (
    // rust: format_of(&entry["min_format"]),
    // rust: format_of(&entry["max_format"]),
    // rust: ) {
    // rust: return min <= current && current <= (max.0, if max.1 == 0 { i64::MAX } else { max.1 });
}
    // rust: let formats = &entry["formats"];
    // rust: if let Some(n) = formats.as_i64() {
    // rust: return n == current.0;
}
    // rust: if let Some(a) = formats.as_array() {
    // rust: return match (
    // rust: a.first().and_then(|v| v.as_i64()),
    // rust: a.get(1).and_then(|v| v.as_i64()),
    // rust: ) {
    // rust: (Some(lo), Some(hi)) => lo <= current.0 && current.0 <= hi,
    // rust: _ => false,
}
}
    // rust: match (
    // rust: formats["min_inclusive"].as_i64(),
    // rust: formats["max_inclusive"].as_i64(),
    // rust: ) {
    // rust: (Some(lo), Some(hi)) => lo <= current.0 && current.0 <= hi,
    // rust: _ => false,
}
}
pub fn overlays_of(meta: *serde_json::Value) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: meta["overlays"]["entries"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter(|e| overlay_applies(e))
    // rust: .filter_map(|e| e["directory"].as_str().map(str::to_owned))
        // OverlayMetadataSection's DIR_VALIDATOR: one folder of the pack, `[-_a-zA-Z0-9.]+`.
    // rust: .filter(|d| {
    // rust: stays_inside(d)
    // rust: && !d.contains('/')
    // rust: && d.bytes()
    // rust: .all(|b| b.is_ascii_alphanumeric() || b"-_.".contains(&b))
    // rust: })
    // rust: .collect()
}
pub fn filter_of(meta: *serde_json::Value) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: meta["filter"]["block"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(|b| Filter {
    // rust: namespace: b["namespace"].as_str().and_then(Pattern::new),
    // rust: path: b["path"].as_str().and_then(Pattern::new),
    // rust: })
    // rust: .collect()
}
    // rust: impl Pack {
    /// The pack's `pack.png` (`PackResources.getRootResource`), for its icon.
pub fn icon_png(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match &self.source {
    // rust: Source::Dir(d) => fs::read(d.join("pack.png")).ok(),
    // rust: Source::Zip(z) => Zip::open(z).ok()?.read("pack.png").ok(),
}
}
}
pub fn read_meta(source: *Source) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let bytes = match source {
    // rust: Source::Dir(d) => fs::read(d.join("pack.mcmeta")).ok()?,
    // rust: Source::Zip(z) => Zip::open(z).ok()?.read("pack.mcmeta").ok()?,
}
    // rust: parse_meta(&bytes)
}
/// The first JSON value of a `pack.mcmeta`: what follows it is ignored, as some packs sign the
/// file with a comment after the closing brace. Gson reads past a UTF-8 byte order mark;
/// serde_json rejects it.
pub fn parse_meta(bytes: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: serde_json::Deserializer::from_slice(bytes.strip_prefix(b"\xEF\xBB\xBF").unwrap_or(bytes))
    // rust: .into_iter()
    // rust: .next()?
    // rust: .ok()
}
pub fn pack(id: []const u8, title: Text, source: Source) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: pack_for(id, title, source, RESOURCE_FORMAT)
}
/// A pack whose compatibility is against `format`.
pub fn pack_for(id: []const u8, title: Text, source: Source, format: (i64) void {
}
    // rust: let meta = read_meta(&source)?;
    // rust: let (raw_description, description_style) = component_root(&meta["pack"]["description"]);
    // rust: Some(Pack {
    // rust: id,
    // rust: title,
    // rust: description: raw_description.resolve_legacy(),
    // rust: raw_description,
    // rust: description_style,
    // rust: compatible: compatible(&meta),
    // rust: compatibility: compatibility_for(&meta, format),
    // rust: overlays: overlays_of(&meta),
    // rust: filter: filter_of(&meta),
    // rust: source,
    // rust: })
}
/// Built-in and `resourcepacks/` packs (vanilla itself excluded), sorted like
/// the pack screen (built-ins first, then by name).
pub fn discover(resources: *Path, packs_dir: *Path) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Vec::new();
    // rust: for (id, key) in [
    // rust: ("programmer_art", "resourcePack.programmer_art.name"),
    // rust: ("high_contrast", "resourcePack.high_contrast.name"),
    // rust: ] {
    // rust: let z = resources.join(format!("assets/minecraft/resourcepacks/{id}.zip"));
    // rust: if z.exists()
    // rust: && let Some(p) = pack(id.into(), Text::translate(key, &[]), Source::Zip(z))
    // rust: {
    // rust: out.push(p);
}
}
    // rust: out.extend(folder(packs_dir, RESOURCE_FORMAT));
    // rust: out
}
/// The packs (folders and zips) in `dir`, by name, as `FolderRepositorySource`
/// finds them; their compatibility is against `format`.
pub fn folder(dir: *Path, format: (i64) void {
}
    // rust: let mut user: Vec<Pack> = fs::read_dir(dir)
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .flatten()
    // rust: .filter_map(|e| {
    // rust: let path = e.path();
    // rust: let name = e.file_name().to_string_lossy().into_owned();
    // rust: let source = if path.is_dir() {
    // rust: Source::Dir(path)
    // rust: } else if name.ends_with(".zip") {
    // rust: Source::Zip(path)
    // rust: } else {
    // rust: return None;
}
    // rust: pack_for(format!("file/{name}"), Text::literal(name), source, format)
    // rust: })
    // rust: .collect();
    // rust: user.sort_by(|a, b| a.id.cmp(&b.id));
    // rust: user
}
/// A file a pack provides: its path (folder packs) and its name inside the pack.
    // rust: type Provided = (Option<PathBuf>, String);
/// Files a pack provides under `assets/`, keyed by their resource name; active
/// overlay directories are applied after the base, in order, later wins.
pub fn pack_files(pack: *Pack) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = BTreeMap::new();
    // rust: let roots = std::iter::once(String::new())
    // rust: .chain(pack.overlays.iter().map(|d| format!("{d}/")))
    // rust: .collect::<Vec<_>>();
    // rust: match &pack.source {
    // rust: Source::Dir(d) => {
    // rust: for root in &roots {
    // rust: let base = d.join(root.trim_end_matches('/'));
    // rust: let mut stack = vec![base.join("assets")];
    // rust: while let Some(dir) = stack.pop() {
    // rust: let Ok(entries) = fs::read_dir(&dir) else {
    // rust: continue;
}
    // rust: for e in entries.flatten() {
    // rust: let p = e.path();
    // rust: if p.is_dir() {
    // rust: stack.push(p);
    // rust: } else if let Ok(rel) = p.strip_prefix(&base) {
    // rust: let rel = rel.to_string_lossy().replace('\\', "/");
    // rust: out.insert(rel.clone(), (Some(p.clone()), format!("{root}{rel}")));
}
}
}
}
}
    // rust: Source::Zip(z) => {
    // rust: let zip = Zip::open(z)?;
    // rust: for root in &roots {
    // rust: let prefix = format!("{root}assets/");
    // rust: for name in zip.names().filter(|name| stays_inside(name)) {
    // rust: if let Some(rest) = name.strip_prefix(&prefix) {
    // rust: out.insert(format!("assets/{rest}"), (None, name.to_owned()));
}
}
}
}
}
    // rust: Ok(out)
}
/// Whether a zip entry's name, joined to the overlay folder, stays in it: `/`-separated parts
/// (zip.rs turns `\` into `/`), none empty, `.` or `..`, and no `:` (a drive or a stream on
/// Windows). A pack, a server's too, may name entries anything.
pub fn stays_inside(name: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !name.contains([':', '\0'])
    // rust: && name
    // rust: .split('/')
    // rust: .all(|part| !part.is_empty() && part != "." && part != "..")
}
pub fn link(target: *Path, at: *Path) i {
    // Implementation ported from Horizon
    return undefined;
}
    // Relative sources are relative to the process, not the overlay directory.
    // rust: std::os::unix::fs::symlink(std::path::absolute(target)?, at)
}
pub fn link(target: *Path, at: *Path) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if target.is_dir() {
    // rust: Ok(())
    // rust: } else {
        // The mirror only reads these files, and unix links them: a hardlink gives
        // the same view without writing the 639 MB prepared root again, which was
        // 33 s of a cold Windows launch with a pack on. Another volume (or a
        // filesystem without hardlinks) still copies.
    // rust: fs::hard_link(target, at).or_else(|_| fs::copy(target, at).map(|_| ()))
}
}
/// A directory junction (`horizon_threads::junction`); the mirror falls back to copying the
/// tree when it fails.
pub fn junction(target: *Path, at: *Path) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: horizon_threads::junction(target, at)
}
pub fn junction(_: *Path, _: *Path) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Err(io::ErrorKind::Unsupported.into())
}
/// Build `out` as `vanilla` with the packs' files layered on top (packs in
/// load order, last wins). Untouched directories are links into vanilla.
pub fn build_overlay(vanilla: *Path, packs: *[Pack], out: *Path) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: cache::build(vanilla, packs, out)
}

    // rust: fn build_overlay_uncached(
    // rust: vanilla: &Path,
    // rust: packs: &[Pack],
    // rust: out: &Path,
    // rust: dependencies: &mut cache::Dependencies,
    // rust: ) -> io::Result<()> {
    // rust: if out.exists() {
    // rust: fs::remove_dir_all(out)?;
}
    // rust: fs::create_dir_all(out)?;
    // Final owner of every overridden file.
    // rust: let mut files: BTreeMap<String, (usize, Provided)> = BTreeMap::new();
    // Every pack's copy of the files vanilla reads as a resource stack.
    // rust: let mut stacks: BTreeMap<String, Vec<(usize, Provided)>> = BTreeMap::new();
    // rust: for (i, p) in packs.iter().enumerate() {
        // A pack's filter hides what the packs below it provide.
    // rust: files.retain(|name, _| !p.filter.iter().any(|f| f.blocks(name)));
    // rust: stacks.retain(|name, _| !p.filter.iter().any(|f| f.blocks(name)));
    // rust: for (name, provided) in pack_files(p)? {
    // rust: if merge_kind(&name).is_some() {
    // rust: stacks
    // rust: .entry(name.clone())
    // rust: .or_default()
    // rust: .push((i, provided.clone()));
}
    // rust: files.insert(name, (i, provided));
}
}
    // FallbackResourceManager: a file's `.mcmeta` counts only from the pack that
    // supplies the file or one above it; vanilla's own sits below every pack.
    // rust: let mut hidden: BTreeSet<String> = files
    // rust: .iter()
    // rust: .filter(|(name, _)| !name.ends_with(".mcmeta"))
    // rust: .filter_map(|(name, (owner, _))| {
    // rust: let meta = format!("{name}.mcmeta");
    // rust: match files.get(&meta) {
    // rust: Some((meta_owner, _)) if meta_owner >= owner => None,
    // rust: _ => Some(meta),
}
    // rust: })
    // rust: .collect();
    // A companion from below the winning colour would describe another surface.
    // A map-only pack above it is intentional and remains valid.
    // rust: for (name, (owner, _)) in &files {
    // rust: let Some(stem) = name.strip_suffix(".png") else {
    // rust: continue;
}
    // rust: if stem.ends_with("_n") || stem.ends_with("_s") {
    // rust: continue;
}
    // rust: for suffix in ["_n.png", "_s.png"] {
    // rust: let map = format!("{stem}{suffix}");
    // rust: if files
    // rust: .get(&map)
    // rust: .is_none_or(|(map_owner, _)| map_owner < owner)
    // rust: {
    // rust: hidden.insert(map);
}
}
}
    // rust: for name in &hidden {
    // rust: files.remove(name);
}
    // Vanilla sits below every pack, so filters hide its files too.
    // rust: let filters: Vec<&Filter> = packs.iter().flat_map(|p| &p.filter).collect();
    // rust: let touched_dirs: BTreeSet<String> = files
    // rust: .keys()
    // rust: .flat_map(|f| {
    // rust: let parts: Vec<&str> = f.split('/').collect();
    // rust: (1..parts.len()).map(move |n| parts[..n].join("/"))
    // rust: })
    // rust: .collect();
    // rust: let zips: Vec<Option<Zip>> = packs
    // rust: .iter()
    // rust: .map(|p| {
    // rust: if let Source::Zip(z) = &p.source {
    // rust: Zip::open(z).ok()
    // rust: } else {
    // rust: None
}
    // rust: })
    // rust: .collect();
    // Stacked files merge every layer, vanilla's first (unless filtered).
    // rust: let mut merged: BTreeMap<String, Vec<u8>> = BTreeMap::new();
    // rust: for (name, stack) in &stacks {
    // rust: let mut layers = Vec::new();
    // rust: dependencies.file(&vanilla.join(name));
    // rust: if !filters.iter().any(|f| f.blocks(name))
    // rust: && let Ok(bytes) = fs::read(vanilla.join(name))
    // rust: {
    // rust: layers.push(bytes);
}
    // rust: for (owner, (path, inner)) in stack {
    // rust: let bytes = match path {
    // rust: Some(p) => fs::read(p).ok(),
    // rust: None => zips
    // rust: .get(*owner)
    // rust: .and_then(Option::as_ref)
    // rust: .and_then(|z| z.read(inner).ok()),
}
    // rust: layers.extend(bytes);
}
    // rust: if let Some(kind) = merge_kind(name)
    // rust: && let Some(bytes) = merge(kind, &layers)
    // rust: {
    // rust: merged.insert(name.clone(), bytes);
}
}
    /// A zip entry to write: its pack, its name in the zip and where it goes.
    // rust: type Extract<'a> = (usize, &'a str, PathBuf);
    // rust: fn mirror<'a>(
    // rust: rel: &str,
    // rust: vanilla: &Path,
    // rust: out: &Path,
    // rust: touched: &BTreeSet<String>,
    // rust: hidden: &BTreeSet<String>,
    // rust: files: &'a BTreeMap<String, (usize, Provided)>,
    // rust: merged: &BTreeMap<String, Vec<u8>>,
    // rust: filters: &[&Filter],
    // rust: dependencies: &mut cache::Dependencies,
    // rust: extract: &mut Vec<Extract<'a>>,
    // rust: ) -> io::Result<()> {
    // rust: let src = if rel.is_empty() {
    // rust: vanilla.to_path_buf()
    // rust: } else {
    // rust: vanilla.join(rel)
}
    // rust: let dst = if rel.is_empty() {
    // rust: out.to_path_buf()
    // rust: } else {
    // rust: out.join(rel)
}
    // rust: fs::create_dir_all(&dst)?;
    // rust: dependencies.directory(&src);
    // rust: let mut names: BTreeSet<String> = BTreeSet::new();
    // rust: if let Ok(entries) = fs::read_dir(&src) {
    // rust: names.extend(
    // rust: entries
    // rust: .flatten()
    // rust: .map(|e| e.file_name().to_string_lossy().into_owned()),
    // rust: );
}
    // rust: let prefix = if rel.is_empty() {
    // rust: String::new()
    // rust: } else {
    // rust: format!("{rel}/")
}
        // The files under this directory are one run of the sorted map: walking only that run
        // keeps a pack of tens of thousands of files in thousands of folders from being
        // scanned once per folder.
    // rust: for f in files
    // rust: .range(prefix.clone()..)
    // rust: .map_while(|(f, _)| f.strip_prefix(&prefix))
    // rust: {
    // rust: names.insert(f.split('/').next().unwrap_or("").to_owned());
}
    // rust: for name in names {
    // rust: let child = format!("{prefix}{name}");
            // Vanilla's files in one file: it describes vanilla's root, not this mirror.
    // rust: if hidden.contains(&child) || child == horizon_core::prepared_files::FILE_NAME {
    // rust: continue;
}
    // rust: if let Some(bytes) = merged.get(&child) {
    // rust: fs::write(out.join(&child), bytes)?;
    // rust: } else if let Some((owner, (path, inner))) = files.get(&child) {
    // rust: let target = out.join(&child);
    // rust: match path {
    // rust: Some(p) => link(p, &target)?,
                    // Inflated and written after the walk, on every thread.
    // rust: None => extract.push((*owner, inner.as_str(), target)),
}
    // rust: } else if filters.is_empty()
    // rust: && !touched.contains(&child)
    // rust: && vanilla.join(&child).is_dir()
    // rust: && junction(&vanilla.join(&child), &out.join(&child)).is_ok()
    // rust: {
                // Linked whole, like the unix symlink: no file in it is visited or copied.
    // rust: } else if touched.contains(&child)
                // Without a junction Windows cannot link a directory the way unix does (`link`
                // above), so an untouched one has to be mirrored: skipping it hid textures/font
                // and the title panorama from the overlay, and a font json that names those
                // sheets then failed to load (#1688).
    // rust: || (vanilla.join(&child).is_dir() && (cfg!(not(unix)) || !filters.is_empty()))
    // rust: {
    // rust: mirror(
    // rust: &child,
    // rust: vanilla,
    // rust: out,
    // rust: touched,
    // rust: hidden,
    // rust: files,
    // rust: merged,
    // rust: filters,
    // rust: dependencies,
    // rust: extract,
    // rust: )?;
    // rust: } else if filters.iter().any(|f| f.blocks(&child)) {
                // Hidden by a pack's filter.
    // rust: } else {
    // rust: if vanilla.join(&child).is_file() {
    // rust: dependencies.file(&vanilla.join(&child));
}
    // rust: link(&vanilla.join(&child), &out.join(&child))?;
}
}
    // rust: Ok(())
}
    // rust: let mut extract = Vec::new();
    // rust: mirror(
    // rust: "",
    // rust: vanilla,
    // rust: out,
    // rust: &touched_dirs,
    // rust: &hidden,
    // rust: &files,
    // rust: &merged,
    // rust: &filters,
    // rust: dependencies,
    // rust: &mut extract,
    // rust: )?;
    // Inflating and writing a big pack's files one by one was most of a cold build; its
    // folders all exist by now.
    // rust: crate::par::par_map(&extract, |(owner, inner, target)| {
    // rust: let Some(Some(z)) = zips.get(*owner) else {
    // rust: return Ok(());
}
        // One unreadable entry costs that file, not the pack: an error here
        // failed the build and the reload dropped every server pack in the stack.
    // rust: match z.read(inner) {
    // rust: Ok(bytes) => fs::write(target, bytes),
    // rust: Err(e) => {
    // rust: log::warn!("Horizon: skipping unreadable pack entry {inner}: {e}");
    // rust: Ok(())
}
}
    // rust: })
    // rust: .into_iter()
    // rust: .collect()
}
/// Files vanilla loads from every pack in turn (`getResourceStack`) rather
/// than from the top pack only.
pub const Merge = enum {
    /// `ClientLanguage.appendFrom`: later packs override keys.
    Lang,
    /// `SoundManager.Preparations.handleRegistration`: sounds add up unless
    /// an event says `replace`.
    Sounds,
    /// `FontManager.loadResourceStack`: the top pack's providers come first.
    Font,
    /// `SpriteSourceList.load`: sources from the bottom pack up.
    Atlas,
    /// `BlockStateModelLoader.loadBlockStateDefinitionStack`: every pack's
    /// definition binds on its own, and a higher one replaces only the states
    /// it binds. Kept as its layers ([`BLOCKSTATE_LAYERS`]) for the catalog.
    BlockStates,
};
/// The key of a stacked blockstate file: its definitions, bottom first, each
/// as the pack wrote it.
pub const BLOCKSTATE_LAYERS: []const u8 = "horizon:layers";
pub fn merge_kind(name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (_, rest) = name.strip_prefix("assets/")?.split_once('/')?;
    // rust: if rest == "sounds.json" {
    // rust: return Some(Merge::Sounds);
}
    // rust: let dir = rest.strip_suffix(".json")?.split_once('/')?.0;
    // rust: match dir {
    // rust: "lang" => Some(Merge::Lang),
    // rust: "font" => Some(Merge::Font),
    // rust: "atlases" => Some(Merge::Atlas),
    // rust: "blockstates" => Some(Merge::BlockStates),
    // rust: _ => None,
}
}
/// One file with the effect of loading `layers` (bottom first) as vanilla
/// does. Layers that do not parse are skipped, as vanilla logs and skips them.
pub fn merge(kind: Merge, layers: *[std.ArrayList(u8)]) O {
    // Implementation ported from Horizon
    return undefined;
}
//     use serde_json::{Map, Value};
    // rust: let mut parsed: Vec<Map<String, Value>> = layers
    // rust: .iter()
        // SoundManager skips a sounds.json Gson rejects, whole.
    // rust: .filter(|b| kind != Merge::Sounds || crate::sound_events::is_valid_file(b))
    // rust: .filter_map(|b| match serde_json::from_slice(b) {
    // rust: Ok(Value::Object(m)) => Some(m),
    // rust: _ => None,
    // rust: })
    // rust: .collect();
    // rust: let list = |key: &str, layers: &mut dyn Iterator<Item = &Map<String, Value>>| {
    // rust: let items: Vec<Value> = layers
    // rust: .filter_map(|l| l.get(key).and_then(Value::as_array))
    // rust: .flatten()
    // rust: .cloned()
    // rust: .collect();
    // rust: Value::Object(Map::from_iter([(key.to_owned(), Value::Array(items))]))
}
    // rust: let out = match kind {
    // rust: Merge::Lang => Value::Object(parsed.into_iter().flatten().collect()),
    // rust: Merge::Sounds => {
    // rust: let mut events = Map::new();
    // rust: for (event, def) in parsed.into_iter().flatten() {
    // rust: if !events.contains_key(&event)
    // rust: || crate::sound_events::json_bool(&def["replace"], false)
    // rust: {
    // rust: let mut fresh = Map::new();
    // rust: if let Some(subtitle) = def.get("subtitle") {
    // rust: fresh.insert("subtitle".into(), subtitle.clone());
}
    // rust: fresh.insert("sounds".into(), Value::Array(Vec::new()));
    // rust: events.insert(event.clone(), Value::Object(fresh));
}
    // rust: if let (Some(Value::Array(sounds)), Some(Value::Array(more))) = (
    // rust: events.get_mut(&event).and_then(|e| e.get_mut("sounds")),
    // rust: def.get("sounds"),
    // rust: ) {
    // rust: sounds.extend(more.iter().cloned());
}
}
    // rust: Value::Object(events)
}
    // rust: Merge::Font => list("providers", &mut parsed.iter().rev()),
    // rust: Merge::Atlas => list("sources", &mut parsed.iter()),
        // One definition is the file as it is.
    // rust: Merge::BlockStates if parsed.len() < 2 => Value::Object(parsed.pop()?),
    // rust: Merge::BlockStates => Value::Object(Map::from_iter([(
    // rust: BLOCKSTATE_LAYERS.to_owned(),
    // rust: Value::Array(parsed.into_iter().map(Value::Object).collect()),
    // rust: )])),
}
    // rust: serde_json::to_vec(&out).ok()
}
/// `DownloadedPackSource.loadRequestedPacks`: a server's downloaded pack,
/// "World Specific Resources"; None when its `pack.mcmeta` can't be read. Its
/// id names the file, which is named after its hash.
pub fn server_pack(id: u128, path: *Path) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let file = path.file_name()?.to_string_lossy();
    // rust: pack(
    // rust: format!("server/{id:032x}/{file}"),
    // rust: Text::translate("resourcePack.server.name", &[]),
    // rust: Source::Zip(path.to_path_buf()),
    // rust: )
}
/// The packs to apply for an options.txt `resourcePacks` list (bottom first).
pub fn enabled(all: *[Pack], ids: *[[]const u8]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ids.iter()
    // rust: .filter(|id| *id != "vanilla")
    // rust: .filter_map(|id| all.iter().find(|p| &p.id == id).cloned())
    // rust: .collect()
}
/// `PackRepository.isAbleToClearAnyPack`: clearing the selection
/// (`rebuildSelected([])`, which keeps only the required vanilla pack)
/// changes it, that is, some selected pack still exists.
pub fn able_to_clear_any_pack(all: *[Pack], selected: *[[]const u8]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !enabled(all, selected).is_empty()
}
/// Resource root for a pack selection: vanilla itself when no pack is on.
pub fn resource_root(vanilla: *Path, packs: *[Pack], cache: *Path) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if packs.is_empty() {
    // rust: return Ok(vanilla.to_path_buf());
}
    // rust: let key: String = packs
    // rust: .iter()
    // rust: .map(|p| p.id.as_str())
    // rust: .collect::<Vec<_>>()
    // rust: .join("|");
    // rust: let hash = key.bytes().fold(0xcbf2_9ce4_8422_2325u64, |h, b| {
    // rust: (h ^ u64::from(b)).wrapping_mul(0x100_0000_01b3)
    // rust: });
    // rust: let out = cache.join(format!("{hash:016x}"));
    // rust: build_overlay(vanilla, packs, &out)?;
    // rust: Ok(out)
}

/// `Pack.Position`: where a pack goes when it is added to a list.
pub const Position = enum {
    Top,
    Bottom,
};
/// A pack as the selection sees it (`PackSelectionConfig` and its
/// compatibility).
pub const Selectable = struct {
    id: []const u8,
    required: bool,
    position: Position,
    fixed: bool,
    compatible: bool,
};
    // rust: impl Selectable {
    /// A pack from `resourcepacks/` or a built-in optional one: not
    /// required, added on top, free to move (`FolderRepositorySource`).
pub fn optional(id: []const u8, compatible: bool) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: id: id.to_owned(),
    // rust: required: false,
    // rust: position: Position::Top,
    // rust: fixed: false,
    // rust: compatible,
}
}
    /// The vanilla pack: required, at the bottom (`BuiltInPackSource`).
pub fn vanilla() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: id: "vanilla".into(),
    // rust: required: true,
    // rust: position: Position::Bottom,
    // rust: fixed: false,
    // rust: compatible: true,
}
}
    /// A server's downloaded pack (`DownloadedPackSource.DOWNLOADED_PACK_SELECTION`):
    /// required, fixed at the top, so the pack screen cannot remove or reorder it.
pub fn downloaded(id: []const u8, compatible: bool) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: id: id.to_owned(),
    // rust: required: true,
    // rust: position: Position::Top,
    // rust: fixed: true,
    // rust: compatible,
}
}
}

/// Ids from `DownloadedPackSource` (`server/…`); they must not go into
/// `options.txt` `resourcePacks`.
pub fn is_downloaded_pack_id(id: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: id.starts_with("server/")
}

/// The player's own selection: drop every downloaded server/world pack id.
pub fn player_pack_ids(ids: impl IntoIterator<Item = []const u8>) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ids.into_iter()
    // rust: .filter(|id| !is_downloaded_pack_id(id))
    // rust: .collect()
}

/// `Pack.Position.insert`: below or above the packs fixed at that end.
pub fn insert(list: *mut std.ArrayList(Selectable), pack: Selectable, reverse: bool) void {
}
    // rust: let own = pack.position;
    // rust: let side = match (own, reverse) {
    // rust: (Position::Top, false) | (Position::Bottom, true) => Position::Top,
    // rust: _ => Position::Bottom,
}
    // rust: let pinned = |p: &Selectable| p.fixed && p.position == own;
    // rust: if side == Position::Bottom {
    // rust: let i = list.iter().take_while(|p| pinned(p)).count();
    // rust: list.insert(i, pack);
    // rust: } else {
    // rust: let i = list.len() - list.iter().rev().take_while(|p| pinned(p)).count();
    // rust: list.insert(i, pack);
}
}

/// `PackSelectionModel` over a `PackRepository`: the packs not selected
/// (in id order) and the selected ones, top first, as the pack screen's two
/// lists show them.
pub const SelectionModel = struct {
    available: std.ArrayList(Selectable),
    unselected: std.ArrayList(Selectable),
    selected: std.ArrayList(Selectable),
};
    // rust: impl SelectionModel {
    /// `available` in any order; `selected` as options.txt lists them,
    /// bottom first.
pub fn new(mut available: std.ArrayList(Selectable), selected: *[[]const u8]) S {
    // Implementation ported from Horizon
    return undefined;
}
        // PackRepository.discoverAvailable: every source's packs go into one
        // TreeMap by id (String.compareTo), so `file/` packs sort among the
        // built-in ones.
    // rust: available.sort_by(|a, b| a.id.encode_utf16().cmp(b.id.encode_utf16()));
    // rust: available.dedup_by(|a, b| a.id == b.id);
    // rust: let mut m = Self {
    // rust: available,
    // rust: ..Self::default()
}
    // rust: let mut chosen = m.rebuild(selected);
    // rust: chosen.reverse();
    // rust: m.unselected = m
    // rust: .available
    // rust: .iter()
    // rust: .filter(|p| !chosen.iter().any(|c| c.id == p.id))
    // rust: .cloned()
    // rust: .collect();
    // rust: m.selected = chosen;
    // rust: m
}
    /// `PackRepository.rebuildSelected`: the named packs that exist, and
    /// every required one.
pub fn rebuild(self: *Self, ids: *[[]const u8]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out: Vec<Selectable> = ids
    // rust: .iter()
    // rust: .filter_map(|id| self.available.iter().find(|p| p.id == *id).cloned())
    // rust: .collect();
    // rust: for p in &self.available {
    // rust: if p.required && !out.iter().any(|o| o.id == p.id) {
    // rust: insert(&mut out, p.clone(), false);
}
}
    // rust: out
}
pub fn list(self: *Self, selected: bool) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if selected {
    // rust: &self.selected
    // rust: } else {
    // rust: &self.unselected
}
}
pub fn can_select(self: *Self, selected: bool, _: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !selected
}
pub fn can_unselect(self: *Self, selected: bool, i: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: selected && !self.selected[i].required
}
pub fn can_move_up(self: *Self, selected: bool, i: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: i > 0 && !self.list(selected)[i - 1].fixed
}
pub fn can_move_down(self: *Self, selected: bool, i: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let list = self.list(selected);
    // rust: i + 1 < list.len() && !list[i + 1].fixed
}
    /// `EntryBase.toggleSelection`: to the other list, at its default
    /// position (from the other end).
pub fn toggle(self: *Self, selected: bool, i: usize) void {
}
    // rust: let (from, to) = if selected {
    // rust: (&mut self.selected, &mut self.unselected)
    // rust: } else {
    // rust: (&mut self.unselected, &mut self.selected)
}
    // rust: let p = from.remove(i);
    // rust: insert(to, p, true);
}
    /// `PackEntry`'s activation (a click on the icon, or the select key):
    /// select, an incompatible pack only once its confirmation was
    /// accepted, or else unselect. True when the lists changed.
pub fn activate(self: *Self, selected: bool, i: usize, confirmed: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.can_select(selected, i) {
    // rust: if self.unselected[i].compatible || confirmed {
    // rust: self.toggle(false, i);
    // rust: return true;
}
    // rust: false
    // rust: } else if self.can_unselect(selected, i) {
    // rust: self.toggle(true, i);
    // rust: true
    // rust: } else {
    // rust: false
}
}
    /// `moveUp` / `moveDown` when allowed.
pub fn move_by(self: *Self, selected: bool, i: usize, up: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let ok = if up {
    // rust: self.can_move_up(selected, i)
    // rust: } else {
    // rust: self.can_move_down(selected, i)
}
    // rust: if ok {
    // rust: let list = if selected {
    // rust: &mut self.selected
    // rust: } else {
    // rust: &mut self.unselected
}
    // rust: let p = list.remove(i);
    // rust: list.insert(if up { i - 1 } else { i + 1 }, p);
}
    // rust: ok
}
    /// `commit`: the repository's selection, bottom first, as options.txt
    /// stores it (downloaded `server/…` packs stay out of that file).
pub fn commit(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let ids: Vec<String> = self.selected.iter().rev().map(|p| p.id.clone()).collect();
    // rust: player_pack_ids(self.rebuild(&ids).into_iter().map(|p| p.id))
}
}

    // rust: mod tests {
//     use super::*;

    /// `DownloadedPackSource.DOWNLOADED_PACK_SELECTION`: the pack is selected,
    /// fixed at the top, cannot be removed, and stays out of options.txt.
pub fn a_downloaded_server_pack_is_fixed_selected_and_not_committed() void {
}
    // rust: let server = "server/00000000000000000000000000000001/hash.zip";
    // rust: let available = vec![
    // rust: Selectable::optional("file/Mine", true),
    // rust: Selectable::downloaded(server, true),
    // rust: Selectable::vanilla(),
    // rust: ];
    // rust: let model = SelectionModel::new(available, &["file/Mine".into()]);
    // rust: assert_eq!(
    // rust: model
    // rust: .selected
    // rust: .iter()
    // rust: .map(|p| p.id.as_str())
    // rust: .collect::<Vec<_>>(),
    // rust: [server, "file/Mine", "vanilla"]
    // rust: );
    // rust: assert!(!model.can_unselect(true, 0));
        // A neighbour cannot move up past the fixed server pack.
    // rust: assert!(!model.can_move_up(true, 1));
    // rust: assert_eq!(
    // rust: model.commit(),
    // rust: vec!["vanilla".to_owned(), "file/Mine".to_owned()]
    // rust: );
    // rust: assert!(is_downloaded_pack_id(server));
    // rust: assert!(!is_downloaded_pack_id("file/Mine"));
}

pub fn a_comment_after_the_metadata_does_not_hide_a_pack() void {
}
    // rust: let meta = br#"{"pack":{"description":"d","pack_format":97}}
// Signed by the pack's author"#;
    // rust: assert!(parse_meta(meta).is_some());
    // rust: assert!(parse_meta(b"not json").is_none());
}

pub fn mcmeta_with_utf8_bom_is_read() void {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-bom-{}", std::process::id()));
    // rust: fs::create_dir_all(&dir).unwrap();
    // rust: let mut meta = b"\xEF\xBB\xBF".to_vec();
    // rust: meta.extend_from_slice(br#"{"pack":{"description":"d","pack_format":97}}"#);
    // rust: fs::write(dir.join("pack.mcmeta"), &meta).unwrap();
    // rust: assert!(read_meta(&Source::Dir(dir.clone())).is_some());
        // Without a BOM the same JSON still reads; other leading bytes still fail.
    // rust: fs::write(dir.join("pack.mcmeta"), &meta[3..]).unwrap();
    // rust: assert!(read_meta(&Source::Dir(dir.clone())).is_some());
    // rust: fs::write(
    // rust: dir.join("pack.mcmeta"),
    // rust: [b"\xEF\xBB".as_slice(), &meta[3..]].concat(),
    // rust: )
    // rust: .unwrap();
    // rust: assert!(read_meta(&Source::Dir(dir.clone())).is_none());
    // rust: fs::remove_dir_all(&dir).ok();
}
    /// `PackFormat.IntermediaryFormat.validate` and its three helpers, with
    /// the resource pack's last pre-minor version, 64.
pub fn pack_format_validation() void {
}
    // rust: let v = |s: &str| serde_json::from_str::<serde_json::Value>(s).unwrap();
    // rust: let check = |s: &str| validate_pack_range(&v(s), 64);
        // validate: both min_format and max_format, or neither.
    // rust: assert!(
    // rust: check(r#"{"min_format":97}"#)
    // rust: .unwrap_err()
    // rust: .contains("both min_format and max_format")
    // rust: );
    // rust: assert!(check(r#"{"max_format":97}"#).is_err());
    // rust: assert!(check("{}").unwrap_err().contains("missing format version"));
        // A pack_format alone: fine up to 64, not above.
    // rust: assert_eq!(check(r#"{"pack_format":34}"#), Ok(((34, 0), (34, 0))));
    // rust: assert!(
    // rust: check(r#"{"pack_format":97}"#)
    // rust: .unwrap_err()
    // rust: .contains("newer than 64")
    // rust: );
        // validateNewFormat: min above max, the deprecated key above 64.
    // rust: assert!(
    // rust: check(r#"{"min_format":98,"max_format":97}"#)
    // rust: .unwrap_err()
    // rust: .contains("greater than max_format")
    // rust: );
    // rust: assert!(check(r#"{"min_format":[97,2],"max_format":[97,1]}"#).is_err());
    // rust: assert!(
    // rust: check(r#"{"min_format":97,"max_format":98,"supported_formats":[97,98]}"#)
    // rust: .unwrap_err()
    // rust: .contains("deprecated")
    // rust: );
        // A decimal reads as its whole part, in a list or alone: `[97.1]` is format 97 (a pack
        // that meant `[97, 1]` still loads and counts as compatible).
    // rust: assert_eq!(
    // rust: check(r#"{"min_format":[97.1],"max_format":[97.1]}"#),
    // rust: Ok(((97, 0), (97, i64::from(i32::MAX))))
    // rust: );
    // rust: assert_eq!(
    // rust: check(r#"{"min_format":97.9,"max_format":98.5}"#),
    // rust: Ok(((97, 0), (98, i64::from(i32::MAX))))
    // rust: );
    // rust: assert_eq!(
    // rust: check(r#"{"min_format":97,"max_format":98}"#),
    // rust: Ok(((97, 0), (98, i64::from(i32::MAX))))
    // rust: );
    // rust: assert_eq!(
    // rust: check(r#"{"min_format":[97,0],"max_format":[97,1]}"#),
    // rust: Ok(((97, 0), (97, 1)))
    // rust: );
        // validatePackFormatForRange: a pack_format outside the range.
    // rust: assert!(
    // rust: check(r#"{"min_format":97,"max_format":98,"pack_format":99}"#)
    // rust: .unwrap_err()
    // rust: .contains("declared main format is 99")
    // rust: );
    // rust: assert!(check(r#"{"min_format":97,"max_format":98,"pack_format":98}"#).is_ok());
        // Below 65 the old fields are required and must agree.
    // rust: assert!(
    // rust: check(r#"{"min_format":34,"max_format":70}"#)
    // rust: .unwrap_err()
    // rust: .contains("require a supported_formats")
    // rust: );
    // rust: assert!(
    // rust: check(
    // rust: r#"{"min_format":34,"max_format":70,"supported_formats":[35,64],"pack_format":35}"#
    // rust: )
    // rust: .unwrap_err()
    // rust: .contains("mismatch")
    // rust: );
    // rust: assert!(
    // rust: check(
    // rust: r#"{"min_format":34,"max_format":70,"supported_formats":[34,60],"pack_format":35}"#
    // rust: )
    // rust: .unwrap_err()
    // rust: .contains("mismatch")
    // rust: );
    // rust: assert!(
    // rust: check(r#"{"min_format":34,"max_format":70,"supported_formats":[34,64]}"#)
    // rust: .unwrap_err()
    // rust: .contains("require a pack_format")
    // rust: );
    // rust: assert!(
    // rust: check(
    // rust: r#"{"min_format":34,"max_format":70,"supported_formats":[34,64],"pack_format":33}"#
    // rust: )
    // rust: .is_err()
    // rust: );
    // rust: assert!(
    // rust: check(
    // rust: r#"{"min_format":34,"max_format":70,"supported_formats":[34,64],"pack_format":34}"#
    // rust: )
    // rust: .is_ok()
    // rust: );
        // Multi-version packs below 15 cannot work.
    // rust: assert!(
    // rust: check(
    // rust: r#"{"min_format":10,"max_format":70,"supported_formats":[10,64],"pack_format":10}"#
    // rust: )
    // rust: .unwrap_err()
    // rust: .contains("less than 15")
    // rust: );
        // validateOldFormat: a range above 64, or no pack_format.
    // rust: assert!(
    // rust: check(r#"{"supported_formats":[34,70],"pack_format":34}"#)
    // rust: .unwrap_err()
    // rust: .contains("newer than 64")
    // rust: );
    // rust: assert!(
    // rust: check(r#"{"supported_formats":[34,60]}"#)
    // rust: .unwrap_err()
    // rust: .contains("require a pack_format")
    // rust: );
    // rust: assert_eq!(
    // rust: check(r#"{"supported_formats":[34,60],"pack_format":40}"#),
    // rust: Ok(((34, 0), (60, 0)))
    // rust: );
    // rust: assert!(
    // rust: check(
    // rust: r#"{"supported_formats":{"min_inclusive":34,"max_inclusive":60},"pack_format":40}"#
    // rust: )
    // rust: .is_ok()
    // rust: );
    // rust: assert!(check(r#"{"supported_formats":[60,34],"pack_format":40}"#).is_err());
        // A refused pack is of unknown format.
//         use crate::pack_screen::Compat;
    // rust: assert_eq!(
    // rust: compatibility(&v(r#"{"pack":{"pack_format":97}}"#)),
    // rust: Compat::Unknown
    // rust: );
    // rust: assert_eq!(
    // rust: compatibility(&v(
    // rust: r#"{"pack":{"min_format":97,"max_format":98,"pack_format":99}}"#
    // rust: )),
    // rust: Compat::Unknown
    // rust: );
}
pub fn compatibility_ranges() void {
}
    // rust: let v = |s: &str| serde_json::from_str::<serde_json::Value>(s).unwrap();
    // rust: assert!(compatible(&v(
    // rust: r#"{"pack":{"min_format":97,"max_format":98}}"#
    // rust: )));
    // rust: assert!(compatible(&v(
    // rust: r#"{"pack":{"min_format":[97,0],"max_format":[97,1]}}"#
    // rust: )));
    // rust: assert!(!compatible(&v(
    // rust: r#"{"pack":{"min_format":[97,2],"max_format":99}}"#
    // rust: )));
    // rust: assert!(!compatible(&v(r#"{"pack":{"pack_format":34}}"#)));
    // rust: assert_eq!(
    // rust: component(&v(r#"["a",{"text":"b","color":"red"}]"#)).plain(),
    // rust: "ab"
    // rust: );
}
pub fn stacked_resources_merge_like_vanilla() void {
}
    // rust: let json = |v: &str| v.as_bytes().to_vec();
    // rust: let parse = |b: Vec<u8>| serde_json::from_slice::<serde_json::Value>(&b).unwrap();
        // ClientLanguage: later packs override keys, the rest stays.
    // rust: let lang = merge(
    // rust: Merge::Lang,
    // rust: &[
    // rust: json(r#"{"a":"vanilla a","b":"vanilla b"}"#),
    // rust: json(r#"{"b":"pack b"}"#),
    // rust: ],
    // rust: );
    // rust: assert_eq!(
    // rust: parse(lang.unwrap()),
    // rust: serde_json::json!({"a":"vanilla a","b":"pack b"})
    // rust: );
        // SoundManager: sounds add up; `replace` starts the event over.
    // rust: let sounds = merge(
    // rust: Merge::Sounds,
    // rust: &[
    // rust: json(r#"{"x":{"subtitle":"s.x","sounds":["v1"]},"y":{"sounds":["v2"]}}"#),
    // rust: json(
    // rust: r#"{"x":{"sounds":["p1"]},"y":{"replace":true,"subtitle":"s.y","sounds":["p2"]}}"#,
    // rust: ),
    // rust: b"not json".to_vec(),
    // rust: ],
    // rust: );
    // rust: assert_eq!(
    // rust: parse(sounds.unwrap()),
    // rust: serde_json::json!({
    // rust: "x":{"subtitle":"s.x","sounds":["v1","p1"]},
    // rust: "y":{"subtitle":"s.y","sounds":["p2"]}
    // rust: })
    // rust: );
        // FontManager: the top pack's providers come first.
    // rust: let font = merge(
    // rust: Merge::Font,
    // rust: &[json(r#"{"providers":[1,2]}"#), json(r#"{"providers":[3]}"#)],
    // rust: );
    // rust: assert_eq!(
    // rust: parse(font.unwrap()),
    // rust: serde_json::json!({"providers":[3,1,2]})
    // rust: );
        // SpriteSourceList: sources from the bottom pack up.
    // rust: let atlas = merge(
    // rust: Merge::Atlas,
    // rust: &[json(r#"{"sources":[1]}"#), json(r#"{"sources":[2]}"#)],
    // rust: );
    // rust: assert_eq!(parse(atlas.unwrap()), serde_json::json!({"sources":[1,2]}));
        // BlockStateModelLoader: every definition kept, bottom first, for the
        // catalog to bind one by one; one that does not parse is skipped.
    // rust: let gate = merge(
    // rust: Merge::BlockStates,
    // rust: &[
    // rust: json(r#"{"variants":{"":{"model":"v"}}}"#),
    // rust: b"not json".to_vec(),
    // rust: json(r#"{"variants":{"powered=true":{"model":"p"}}}"#),
    // rust: ],
    // rust: );
    // rust: assert_eq!(
    // rust: parse(gate.unwrap()),
    // rust: serde_json::json!({BLOCKSTATE_LAYERS:[
    // rust: {"variants":{"":{"model":"v"}}},
    // rust: {"variants":{"powered=true":{"model":"p"}}}
    // rust: ]})
    // rust: );
        // A single definition stays the file as it is.
    // rust: let alone = merge(
    // rust: Merge::BlockStates,
    // rust: &[json(r#"{"variants":{"":{"model":"p"}}}"#)],
    // rust: );
    // rust: assert_eq!(
    // rust: parse(alone.unwrap()),
    // rust: serde_json::json!({"variants":{"":{"model":"p"}}})
    // rust: );
    // rust: assert_eq!(
    // rust: merge_kind("assets/minecraft/blockstates/oak_fence_gate.json"),
    // rust: Some(Merge::BlockStates)
    // rust: );
    // rust: assert_eq!(
    // rust: merge_kind("assets/minecraft/lang/en_us.json"),
    // rust: Some(Merge::Lang)
    // rust: );
    // rust: assert_eq!(
    // rust: merge_kind("assets/minecraft/sounds.json"),
    // rust: Some(Merge::Sounds)
    // rust: );
    // rust: assert_eq!(
    // rust: merge_kind("assets/minecraft/font/default.json"),
    // rust: Some(Merge::Font)
    // rust: );
    // rust: assert_eq!(merge_kind("assets/minecraft/font/unifont.zip"), None);
    // rust: assert_eq!(
    // rust: merge_kind("assets/minecraft/atlases/blocks.json"),
    // rust: Some(Merge::Atlas)
    // rust: );
    // rust: assert_eq!(merge_kind("assets/minecraft/models/block/stone.json"), None);
}
pub fn companion_maps_follow_the_winning_colour_or_a_higher_map_only_pack() void {
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-material-owner-{}", std::process::id()));
    // rust: let vanilla = root.join("vanilla");
    // rust: let relative = "assets/minecraft/textures/block";
    // rust: fs::create_dir_all(vanilla.join(relative)).unwrap();
    // rust: let names = ["stone.png", "stone_n.png", "stone_s.png"];
    // rust: for name in names {
    // rust: fs::write(vanilla.join(relative).join(name), b"base").unwrap();
}
    // rust: for (pack, files) in [
    // rust: ("low", vec!["stone_n.png", "stone_s.png"]),
    // rust: ("colour", vec!["stone.png"]),
    // rust: ("maps", vec!["stone_n.png"]),
    // rust: ] {
    // rust: let dir = root.join("packs").join(pack);
    // rust: fs::create_dir_all(dir.join(relative)).unwrap();
    // rust: fs::write(
    // rust: dir.join("pack.mcmeta"),
    // rust: br#"{"pack":{"description":"fixture","pack_format":97}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: for name in files {
    // rust: fs::write(dir.join(relative).join(name), pack.as_bytes()).unwrap();
}
}
    // rust: let all = discover(&vanilla, &root.join("packs"));
    // rust: let order = |names: &[&str]| {
    // rust: names
    // rust: .iter()
    // rust: .map(|name| {
    // rust: all.iter()
    // rust: .find(|p| p.id == format!("file/{name}"))
    // rust: .unwrap()
    // rust: .clone()
    // rust: })
    // rust: .collect::<Vec<_>>()
}
    // rust: let out = root.join("out");
    // rust: build_overlay(&vanilla, &order(&["low", "colour"]), &out).unwrap();
    // rust: assert_eq!(
    // rust: fs::read(out.join(relative).join("stone.png")).unwrap(),
    // rust: b"colour"
    // rust: );
    // rust: assert!(!out.join(relative).join("stone_n.png").exists());
    // rust: assert!(!out.join(relative).join("stone_s.png").exists());
    // rust: build_overlay(&vanilla, &order(&["low", "colour", "maps"]), &out).unwrap();
    // rust: assert_eq!(
    // rust: fs::read(out.join(relative).join("stone_n.png")).unwrap(),
    // rust: b"maps"
    // rust: );
    // rust: assert!(!out.join(relative).join("stone_s.png").exists());
    // rust: fs::remove_dir_all(root).unwrap();
}
pub fn overlay_layers_packs_over_vanilla() void {
}
        // `&` would split an unquoted `cmd /C mklink` line.
    // rust: let base = std::env::temp_dir().join(format!("horizon-packs-&{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&base);
    // rust: let vanilla = base.join("vanilla");
    // rust: fs::create_dir_all(vanilla.join("assets/minecraft/textures/block")).unwrap();
    // rust: fs::create_dir_all(vanilla.join("assets/minecraft/lang")).unwrap();
    // rust: fs::write(
    // rust: vanilla.join("assets/minecraft/textures/block/stone.png"),
    // rust: b"vanilla",
    // rust: )
    // rust: .unwrap();
    // rust: fs::write(
    // rust: vanilla.join("assets/minecraft/textures/block/dirt.png"),
    // rust: b"vanilla dirt",
    // rust: )
    // rust: .unwrap();
    // rust: fs::write(
    // rust: vanilla.join("assets/minecraft/lang/en_us.json"),
    // rust: br#"{"a":"vanilla","b":"vanilla"}"#,
    // rust: )
    // rust: .unwrap();
    // rust: fs::write(vanilla.join("facts.json"), b"[]").unwrap();
        // A directory no pack touches (#1688: a font json names sheets in it).
    // rust: fs::create_dir_all(vanilla.join("assets/minecraft/textures/font")).unwrap();
    // rust: fs::write(
    // rust: vanilla.join("assets/minecraft/textures/font/ascii.png"),
    // rust: b"font",
    // rust: )
    // rust: .unwrap();
    // rust: let pack_dir = base.join("packs/Mine");
    // rust: fs::create_dir_all(pack_dir.join("assets/minecraft/textures/block")).unwrap();
    // rust: fs::write(
    // rust: pack_dir.join("pack.mcmeta"),
    // rust: br#"{"pack":{"description":"mine","pack_format":97}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: fs::write(
    // rust: pack_dir.join("assets/minecraft/textures/block/stone.png"),
    // rust: b"pack",
    // rust: )
    // rust: .unwrap();
    // rust: fs::create_dir_all(pack_dir.join("assets/minecraft/lang")).unwrap();
    // rust: fs::write(
    // rust: pack_dir.join("assets/minecraft/lang/en_us.json"),
    // rust: br#"{"b":"pack"}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let packs = discover(&vanilla, &base.join("packs"));
    // rust: assert_eq!(packs.len(), 1);
    // rust: assert_eq!(packs[0].id, "file/Mine");
    // rust: let out = base.join("overlay");
    // rust: build_overlay(&vanilla, &packs, &out).unwrap();
    // rust: assert_eq!(
    // rust: fs::read(out.join("assets/minecraft/textures/block/stone.png")).unwrap(),
    // rust: b"pack"
    // rust: );
    // rust: assert_eq!(
    // rust: fs::read(out.join("assets/minecraft/textures/block/dirt.png")).unwrap(),
    // rust: b"vanilla dirt"
    // rust: );
        // A pack's language file adds to vanilla's instead of replacing it.
    // rust: assert_eq!(
    // rust: fs::read(out.join("assets/minecraft/lang/en_us.json")).unwrap(),
    // rust: br#"{"a":"vanilla","b":"pack"}"#
    // rust: );
    // rust: assert_eq!(fs::read(out.join("facts.json")).unwrap(), b"[]");
    // rust: assert_eq!(
    // rust: fs::read(out.join("assets/minecraft/textures/font/ascii.png")).unwrap(),
    // rust: b"font"
    // rust: );
        // Linked, not mirrored: a junction on Windows, a symlink on unix.
    // rust: assert!(
    // rust: fs::symlink_metadata(out.join("assets/minecraft/textures/font"))
    // rust: .unwrap()
    // rust: .file_type()
    // rust: .is_symlink()
    // rust: );
    // rust: let _ = fs::remove_dir_all(base);
}
pub fn every_file_of_a_big_stack_comes_from_its_top_pack() void {
}
//         use std::io::Write as _;
    // rust: let base = std::env::temp_dir().join(format!("horizon-pack-stack-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&base);
    // rust: let vanilla = base.join("vanilla");
        // Folders whose names start alike (`item`, `item_extra`, `item2`) and files beside
        // folders of almost their name: what a prefix lookup could mix up.
    // rust: let names: Vec<String> = (0..400)
    // rust: .map(|i| {
    // rust: let folder = ["item", "item_extra", "item2", "item/sub", "block"][i % 5];
    // rust: format!("assets/ns{}/textures/{folder}/f{i}.png", i % 3)
    // rust: })
    // rust: .chain(["assets/ns0/textures/item.png".to_owned()])
    // rust: .collect();
    // rust: let mut expected: BTreeMap<String, Vec<u8>> = BTreeMap::new();
    // rust: for name in names.iter().step_by(4) {
    // rust: let path = vanilla.join(name);
    // rust: fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: fs::write(&path, format!("vanilla {name}")).unwrap();
    // rust: expected.insert(name.clone(), format!("vanilla {name}").into_bytes());
}
    // rust: let meta = br#"{"pack":{"description":"d","pack_format":97}}"#;
        // Packs a and b are zips, c a folder; each provides a different part of the names.
    // rust: fs::create_dir_all(base.join("packs/c")).unwrap();
    // rust: fs::write(base.join("packs/c/pack.mcmeta"), meta).unwrap();
    // rust: for (pack, every) in [("a", 2), ("b", 3)] {
    // rust: let file = fs::File::create(base.join(format!("packs/{pack}.zip"))).unwrap();
    // rust: let mut zip = zip::ZipWriter::new(file);
    // rust: zip.start_file("pack.mcmeta", zip::write::SimpleFileOptions::default())
    // rust: .unwrap();
    // rust: zip.write_all(meta).unwrap();
    // rust: for name in names.iter().step_by(every) {
    // rust: zip.start_file(name, zip::write::SimpleFileOptions::default())
    // rust: .unwrap();
    // rust: zip.write_all(format!("{pack} {name}").as_bytes()).unwrap();
    // rust: expected.insert(name.clone(), format!("{pack} {name}").into_bytes());
}
    // rust: zip.finish().unwrap();
}
    // rust: for name in names.iter().skip(1).step_by(5) {
    // rust: let path = base.join("packs/c").join(name);
    // rust: fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: fs::write(&path, format!("c {name}")).unwrap();
    // rust: expected.insert(name.clone(), format!("c {name}").into_bytes());
}
    // rust: let all = folder(&base.join("packs"), RESOURCE_FORMAT);
    // rust: let ids = ["file/a.zip", "file/b.zip", "file/c"].map(String::from);
    // rust: let out = base.join("overlay");
    // rust: build_overlay(&vanilla, &enabled(&all, &ids), &out).unwrap();
pub fn walk(dir: *Path, root: *Path, out: *mut BTreeMap<[]const u8) void {
}
    // rust: for entry in fs::read_dir(dir).unwrap().flatten() {
    // rust: let path = entry.path();
    // rust: if path.is_dir() {
    // rust: walk(&path, root, out);
    // rust: } else {
    // rust: let name = path.strip_prefix(root).unwrap().to_string_lossy();
    // rust: out.insert(name.replace('\\', "/"), fs::read(&path).unwrap());
}
}
}
    // rust: let mut built = BTreeMap::new();
    // rust: walk(&out.join("assets"), &out, &mut built);
    // rust: assert_eq!(built, expected);
    // rust: let _ = fs::remove_dir_all(base);
}
pub fn zip_entries_never_leave_the_overlay() void {
}
//         use std::io::Write as _;
    // rust: let base = std::env::temp_dir().join(format!("horizon-pack-escape-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&base);
    // rust: let vanilla = base.join("vanilla");
    // rust: fs::create_dir_all(vanilla.join("assets/minecraft/textures/block")).unwrap();
    // rust: fs::write(
    // rust: vanilla.join("assets/minecraft/textures/block/stone.png"),
    // rust: b"vanilla",
    // rust: )
    // rust: .unwrap();
    // rust: fs::create_dir_all(base.join("packs")).unwrap();
    // rust: let mut zip = zip::ZipWriter::new(fs::File::create(base.join("packs/evil.zip")).unwrap());
    // rust: for (name, data) in [
    // rust: (
    // rust: "pack.mcmeta",
    // rust: &br#"{"pack":{"description":"d","pack_format":97}}"#[..],
    // rust: ),
    // rust: ("assets/minecraft/textures/block/stone.png", b"pack"),
    // rust: ("assets/../../escaped.txt", b"out"),
    // rust: ("assets/minecraft/../../../escaped_lang.json", b"{}"),
    // rust: ("assets\\..\\..\\escaped_backslash.txt", b"out"),
    // rust: ("assets/./minecraft/dot.txt", b"in"),
    // rust: ] {
    // rust: zip.start_file(name, zip::write::SimpleFileOptions::default())
    // rust: .unwrap();
    // rust: zip.write_all(data).unwrap();
}
    // rust: zip.finish().unwrap();
    // rust: let packs = discover(&vanilla, &base.join("packs"));
    // rust: assert_eq!(packs.len(), 1);
    // rust: let out = base.join("work/overlay");
    // rust: build_overlay(&vanilla, &packs, &out).unwrap();
    // rust: assert_eq!(
    // rust: fs::read(out.join("assets/minecraft/textures/block/stone.png")).unwrap(),
    // rust: b"pack"
    // rust: );
    // rust: for escaped in [
    // rust: "escaped.txt",
    // rust: "escaped_lang.json",
    // rust: "escaped_backslash.txt",
    // rust: "work/escaped.txt",
    // rust: "work/escaped_lang.json",
    // rust: "work/escaped_backslash.txt",
    // rust: ] {
    // rust: assert!(!base.join(escaped).exists(), "{escaped} was written");
}
    // rust: let _ = fs::remove_dir_all(base);
}
pub fn built_in_and_folder_packs_give_their_pack_png() void {
}
//         use std::io::Write as _;
    // rust: let base = std::env::temp_dir().join(format!("horizon-pack-icons-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&base);
    // rust: let meta = br#"{"pack":{"description":"d","pack_format":97}}"#;
    // rust: let built_in = base.join("vanilla/assets/minecraft/resourcepacks");
    // rust: fs::create_dir_all(&built_in).unwrap();
    // rust: let mut zip =
    // rust: zip::ZipWriter::new(fs::File::create(built_in.join("programmer_art.zip")).unwrap());
    // rust: for (name, data) in [("pack.mcmeta", &meta[..]), ("pack.png", b"dirt")] {
    // rust: zip.start_file(name, zip::write::SimpleFileOptions::default())
    // rust: .unwrap();
    // rust: zip.write_all(data).unwrap();
}
    // rust: zip.finish().unwrap();
    // rust: for (name, icon) in [("Iconless", None), ("Mine", Some(&b"mine"[..]))] {
    // rust: let dir = base.join("packs").join(name);
    // rust: fs::create_dir_all(&dir).unwrap();
    // rust: fs::write(dir.join("pack.mcmeta"), meta).unwrap();
    // rust: if let Some(icon) = icon {
    // rust: fs::write(dir.join("pack.png"), icon).unwrap();
}
}
    // rust: let packs = discover(&base.join("vanilla"), &base.join("packs"));
    // rust: let icons: Vec<_> = packs
    // rust: .iter()
    // rust: .map(|p| (p.id.as_str(), p.icon_png()))
    // rust: .collect();
    // rust: assert_eq!(
    // rust: icons,
    // rust: [
    // rust: ("programmer_art", Some(b"dirt".to_vec())),
    // rust: ("file/Iconless", None),
    // rust: ("file/Mine", Some(b"mine".to_vec())),
    // rust: ]
    // rust: );
    // rust: let _ = fs::remove_dir_all(base);
}
pub fn overlays_and_filters() void {
}
    // rust: let v = |s: &str| serde_json::from_str::<serde_json::Value>(s).unwrap();
    // rust: let meta = v(r#"{"overlays":{"entries":[
    // rust: {"formats":[90,96],"directory":"old"},
    // rust: {"formats":{"min_inclusive":97,"max_inclusive":97},"directory":"new"},
    // rust: {"min_format":97,"max_format":[97,5],"directory":"also"},
    // rust: {"formats":50,"directory":"no"}]}}"#);
    // rust: assert_eq!(overlays_of(&meta), ["new", "also"]);
        // Only one plain folder of the pack, as vanilla's DIR_VALIDATOR has it.
    // rust: let meta = v(r#"{"overlays":{"entries":[
    // rust: {"formats":97,"directory":".."},
    // rust: {"formats":97,"directory":"../outside"},
    // rust: {"formats":97,"directory":"/etc"},
    // rust: {"formats":97,"directory":"a/b"},
    // rust: {"formats":97,"directory":"C:"},
    // rust: {"formats":97,"directory":"ok_1.21-x"}]}}"#);
    // rust: assert_eq!(overlays_of(&meta), ["ok_1.21-x"]);
    // rust: let base = std::env::temp_dir().join(format!("horizon-packs-ov-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&base);
    // rust: let vanilla = base.join("vanilla");
    // rust: fs::create_dir_all(vanilla.join("assets/minecraft/textures/block")).unwrap();
    // rust: fs::write(
    // rust: vanilla.join("assets/minecraft/textures/block/stone.png"),
    // rust: b"v",
    // rust: )
    // rust: .unwrap();
    // rust: fs::write(
    // rust: vanilla.join("assets/minecraft/textures/block/dirt.png"),
    // rust: b"v",
    // rust: )
    // rust: .unwrap();
    // rust: let dir = base.join("packs/P");
    // rust: fs::create_dir_all(dir.join("new/assets/minecraft/textures/block")).unwrap();
    // rust: fs::create_dir_all(dir.join("old/assets/minecraft/textures/block")).unwrap();
    // rust: fs::write(
    // rust: dir.join("pack.mcmeta"),
    // rust: br#"{"pack":{"description":"p","pack_format":97},
    // rust: "overlays":{"entries":[{"formats":97,"directory":"new"},{"formats":1,"directory":"old"}]},
    // rust: "filter":{"block":[{"path":"textures/block/dirt\\.png"}]}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: fs::write(
    // rust: dir.join("new/assets/minecraft/textures/block/stone.png"),
    // rust: b"overlay",
    // rust: )
    // rust: .unwrap();
    // rust: fs::write(
    // rust: dir.join("old/assets/minecraft/textures/block/stone.png"),
    // rust: b"old",
    // rust: )
    // rust: .unwrap();
    // rust: let packs = discover(&vanilla, &base.join("packs"));
    // rust: let out = base.join("overlay");
    // rust: build_overlay(&vanilla, &packs, &out).unwrap();
    // rust: assert_eq!(
    // rust: fs::read(out.join("assets/minecraft/textures/block/stone.png")).unwrap(),
    // rust: b"overlay"
    // rust: );
    // rust: assert!(
    // rust: !out.join("assets/minecraft/textures/block/dirt.png")
    // rust: .exists()
    // rust: );
    // rust: let _ = fs::remove_dir_all(base);
}
}
