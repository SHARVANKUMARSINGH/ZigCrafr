//! Transpiled from Horizon Rust crate
package horizon_client_render_datapack

import "core:fmt"
import "core:mem"
import "core:math"

// Data packs (`<world>/datapacks`: folders and zips with `pack.mcmeta`) and
// the parts of them commands use: `.mcfunction` functions (with macros and
// line continuation), function tags and predicates.
// use crate::zip::Zip;
// use horizon_world::{
    // rust: nbt::Tag,
    // rust: worldgen::overrides::{self, PackFile, WorldgenOverrides},
}
// use std::{
    // rust: collections::BTreeMap,
    // rust: path::{Path, PathBuf},
}

// A pack on disk.
DataPack :: struct {
    // `file/<name>` in `/datapack` and level.dat.
    id: string,
    source: Source,
}
Source :: enum {
    Dir(PathBuf),
    Zip(Box<Zip>),
}
    // rust: impl DataPack {
    // Every file path under `prefix` (relative to the pack root).
list :: proc(self: ^Self, prefix: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: match &self.source {
    // rust: Source::Zip(z) => z
    // rust: .names()
    // rust: .filter(|n| n.starts_with(prefix) && !n.ends_with('/'))
    // rust: .map(str::to_owned)
    // rust: .collect(),
    // rust: Source::Dir(root) => {
    // rust: let mut out = Vec::new();
    // rust: walk(root, &root.join(prefix), &mut out);
    // rust: out
}
}
}
    // The files of `data/<namespace>/<kind>/` for each kind, in the order
    // `list("data/")` gives them. A folder pack walks only those folders:
    // the built-in pack holds about 10,000 other data files.
list_kinds :: proc(self: ^Self, kinds: ^[string]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: debug_assert!(kinds.is_sorted(), "kinds in walk order");
    // rust: let Source::Dir(root) = &self.source else {
    // rust: return self.list("data/");
}
    // rust: let Ok(entries) = std::fs::read_dir(root.join("data")) else {
    // rust: return Vec::new();
}
    // rust: let mut namespaces: Vec<_> = entries.flatten().map(|e| e.path()).collect();
    // rust: namespaces.sort();
    // rust: let mut out = Vec::new();
    // rust: for ns in namespaces {
    // rust: for kind in kinds {
    // rust: walk(root, &ns.join(kind), &mut out);
}
}
    // rust: out
}
    // The files of `data/<namespace>/<folder>/` in every namespace, as
    // `list` names them; a folder pack walks only those folders.
list_folder :: proc(self: ^Self, folder: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let files = self.list_kinds(&[folder]);
    // rust: let Source::Zip(_) = &self.source else {
    // rust: return files;
}
    // rust: files
    // rust: .into_iter()
    // rust: .filter(|f| {
    // rust: f.strip_prefix("data/")
    // rust: .and_then(|r| r.split_once('/'))
    // rust: .is_some_and(|(_, r)| {
    // rust: r.strip_prefix(folder).is_some_and(|r| r.starts_with('/'))
    // rust: })
    // rust: })
    // rust: .collect()
}
read :: proc(self: ^Self, path: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match &self.source {
    // rust: Source::Zip(z) => z.read(path).ok(),
    // rust: Source::Dir(root) => std::fs::read(root.join(path)).ok(),
}
}

    // The `description` of `pack.mcmeta`, as text.
description :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let Some(bytes) = self.read("pack.mcmeta") else {
    // rust: return String::new();
}
    // rust: let v: serde_json::Value = serde_json::from_slice(&bytes).unwrap_or_default();
    // rust: match &v["pack"]["description"] {
    // rust: serde_json::Value::String(s) => s.clone(),
    // rust: other => other["text"].as_str().unwrap_or_default().to_owned(),
}
}
    // The `features.enabled` flag ids of `pack.mcmeta`
    // (`FeatureFlagsMetadataSection`): the flags the pack asks to turn on.
features :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.mcmeta()["features"]["enabled"]
    // rust: .as_array()
    // rust: .map(|a| {
    // rust: a.iter()
    // rust: .filter_map(|f| f.as_str().map(str::to_owned))
    // rust: .collect()
    // rust: })
    // rust: .unwrap_or_default()
}
    // The `pack.mcmeta` as JSON, empty when it is missing or unreadable.
mcmeta :: proc(self: ^Self) -> s {
    // Ported from Horizon
    return {}
}
    // rust: self.read("pack.mcmeta")
    // rust: .and_then(|b| serde_json::from_slice(&b).ok())
    // rust: .unwrap_or_default()
}
}
walk :: proc(root: ^Path, dir: ^Path, out: ^[dynamic]string) {
}
    // rust: let Ok(entries) = std::fs::read_dir(dir) else {
    // rust: return;
}
    // rust: let mut entries: Vec<_> = entries.flatten().collect();
    // rust: entries.sort_by_key(std::fs::DirEntry::file_name);
    // rust: for e in entries {
    // rust: let p = e.path();
    // rust: if p.is_dir() {
    // rust: walk(root, &p, out);
    // rust: } else if let Ok(rel) = p.strip_prefix(root) {
    // rust: out.push(rel.to_string_lossy().replace('\\', "/"));
}
}
}
    // rust: impl DataPack {
    // The built-in `vanilla` pack: the game's own data directory.
builtin :: proc(root: ^Path) -> S {
    // Ported from Horizon
    return {}
}
    // rust: DataPack {
    // rust: id: "vanilla".into(),
    // rust: source: Source::Dir(root.to_path_buf()),
}
}
}
// The packs in `<world>/datapacks`, sorted by name.
discover :: proc(world: ^Path) -> V {
    // Ported from Horizon
    return {}
}
    // rust: discover_folder(&world.join("datapacks"))
}
// Packs in Create World's temporary pack folder, before a world exists.
discover_folder :: proc(dir: ^Path) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let Ok(entries) = std::fs::read_dir(dir) else {
    // rust: return Vec::new();
}
    // rust: let mut packs = Vec::new();
    // rust: for e in entries.flatten() {
    // rust: let name = e.file_name().to_string_lossy().into_owned();
    // rust: let path = e.path();
    // rust: if path.is_dir() && path.join("pack.mcmeta").exists() {
    // rust: packs.push(DataPack {
    // rust: id: format!("file/{name}"),
    // rust: source: Source::Dir(path),
    // rust: });
    // rust: } else if name.ends_with(".zip")
    // rust: && let Ok(z) = Zip::open(&path)
    // rust: && z.contains("pack.mcmeta")
    // rust: {
    // rust: packs.push(DataPack {
    // rust: id: format!("file/{name}"),
    // rust: source: Source::Zip(Box::new(z)),
    // rust: });
}
}
    // rust: packs.sort_by(|a, b| a.id.cmp(&b.id));
    // rust: packs
}
// The resources root's built-in feature packs (`ServerPacksSource`
// scanning the game's `data/minecraft/datapacks`): every folder with a
// `pack.mcmeta`, a feature pack (`PackSource.FEATURE`). Off until a world
// selects them.
feature_packs :: proc(resources: ^Path) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let Ok(entries) = std::fs::read_dir(resources.join("data").join("minecraft").join("datapacks"))
    // rust: else {
    // rust: return Vec::new();
}
    // rust: let mut packs = Vec::new();
    // rust: for e in entries.flatten() {
    // rust: let path = e.path();
    // rust: if path.join("pack.mcmeta").exists() {
    // rust: packs.push(DataPack {
    // rust: id: e.file_name().to_string_lossy().into_owned(),
    // rust: source: Source::Dir(path),
    // rust: });
}
}
    // rust: packs.sort_by(|a, b| a.id.cmp(&b.id));
    // rust: packs
}
// The packs of `<world>/datapacks` plus the resources root's feature packs:
// the world's whole repository, as `PackRepository.reload` sees it.
discover_with_features :: proc(world_root: ^Path, resources: ^Path) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut packs = discover(world_root);
    // rust: packs.extend(feature_packs(resources));
    // rust: packs
}

// ---- Create World ------------------------------------------------------------

// Create World's Data Packs screen (`PackSelectionScreen` on vanilla's
// `mcworld-` folder): the folder's packs (`PackSource.WORLD`), the
// built-in one (`resources` holds its `pack.png`), and the feature packs
// of `resources` (`PackSource.FEATURE`), available at the bottom and off
// until picked — the Experiments.
screen_packs :: proc(dir: ^Path, resources: ^Path) -> V {
    // Ported from Horizon
    return {}
}
//     use crate::{
    // rust: pack_screen::{Compat, PackInfo, Source, load_icon},
    // rust: packs::Position,
    // rust: text::{Style, Text},
}
    // rust: let format = horizon_core::version::DATA_PACK_FORMAT;
    // rust: let mut infos: Vec<PackInfo> = crate::packs::folder(dir, format)
    // rust: .into_iter()
    // rust: .map(|p| PackInfo {
    // rust: icon: p.icon_png().as_deref().and_then(load_icon),
    // rust: id: p.id,
    // rust: title: p.title,
    // rust: description: p.raw_description,
    // rust: description_style: p.description_style,
    // rust: source: Source::World,
    // rust: compat: p.compatibility,
    // rust: required: false,
    // rust: position: Position::Top,
    // rust: fixed: false,
    // rust: })
    // rust: .collect();
    // rust: infos.push(PackInfo {
    // rust: id: "vanilla".into(),
    // rust: title: Text::translate("dataPack.vanilla.name", &[]),
    // rust: description: Text::translate("dataPack.vanilla.description", &[]),
    // rust: description_style: Style::default(),
    // rust: source: Source::BuiltIn,
    // rust: compat: Compat::Compatible,
    // rust: icon: std::fs::read(resources.join("pack.png"))
    // rust: .ok()
    // rust: .as_deref()
    // rust: .and_then(load_icon),
    // rust: required: false,
    // rust: position: Position::Bottom,
    // rust: fixed: false,
    // rust: });
    // rust: for p in feature_packs(resources) {
    // rust: let meta = p.mcmeta();
    // rust: let (description, description_style) =
    // rust: crate::packs::component_root(&meta["pack"]["description"]);
    // rust: infos.push(PackInfo {
    // rust: icon: None,
    // rust: id: p.id.clone(),
    // rust: title: Text::translate(&format!("dataPack.{}.name", p.id), &[]),
    // rust: description,
    // rust: description_style,
    // rust: source: Source::Feature,
    // rust: compat: crate::packs::compatibility_for(&meta, format),
    // rust: required: false,
    // rust: position: Position::Bottom,
    // rust: fixed: false,
    // rust: });
}
    // rust: infos
}
// A new empty folder for Create World's packs
// (`Files.createTempDirectory("mcworld-")`).
temp_folder :: proc() -> s {
    // Ported from Horizon
    return {}
}
    // rust: let nanos = std::time::SystemTime::now()
    // rust: .duration_since(std::time::UNIX_EPOCH)
    // rust: .unwrap_or_default()
    // rust: .as_nanos();
    // rust: let dir = std::env::temp_dir().join(format!("mcworld-{}-{nanos}", std::process::id()));
    // rust: std::fs::create_dir_all(&dir)?;
    // rust: Ok(dir)
}
// `PackSelectionScreen.onFilesDrop`'s `PackDetector`: a zip is a pack; a
// folder is one when it holds a `pack.mcmeta`, or exactly one folder that
// does (a folder zipped by the system, which adds a wrapper). Copied into
// `dir`; false when `path` is no pack, or when part of it could not be copied.
copy_pack :: proc(path: ^Path, dir: ^Path) -> b {
    // Ported from Horizon
    return {}
}
copy_dir :: proc(from: ^Path, at: ^Path) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let mut whole = true;
    // rust: if let Err(e) = std::fs::create_dir_all(at) {
    // rust: log::warn!("Horizon: {} is not made: {e}", at.display());
    // rust: whole = false;
}
    // rust: for entry in std::fs::read_dir(from).into_iter().flatten().flatten() {
    // rust: let path = entry.path();
    // rust: let to = at.join(entry.file_name());
    // rust: let copied = if path.is_dir() {
    // rust: copy_dir(&path, &to)
    // rust: } else {
    // rust: match std::fs::copy(&path, &to) {
    // rust: Ok(_) => true,
    // rust: Err(e) => {
    // rust: log::warn!(
    // rust: "Horizon: {} is not copied into the pack: {e}",
    // rust: path.display()
    // rust: );
    // rust: false
}
}
}
    // rust: whole &= copied;
}
    // rust: whole
}
    // rust: let name = || {
    // rust: path.file_name()
    // rust: .map(|n| n.to_string_lossy().into_owned())
    // rust: .unwrap_or_default()
}
    // rust: if path.is_file() {
    // rust: return path
    // rust: .extension()
    // rust: .is_some_and(|e| e.eq_ignore_ascii_case("zip"))
    // rust: && {
    // rust: let _ = std::fs::create_dir_all(dir);
    // rust: std::fs::copy(path, dir.join(name())).is_ok()
}
}
    // rust: if !path.is_dir() {
    // rust: return false;
}
    // rust: if path.join("pack.mcmeta").is_file() {
    // rust: return copy_dir(path, &dir.join(name()));
}
    // rust: let own: Vec<PathBuf> = std::fs::read_dir(path)
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .flatten()
    // rust: .map(|e| e.path())
    // rust: .filter(|p| p.is_dir() && p.join("pack.mcmeta").is_file())
    // rust: .collect();
    // rust: match own.as_slice() {
    // rust: [one] => copy_dir(one, &dir.join(one.file_name().unwrap_or_default())),
    // rust: _ => false,
}
}
// What's in a folder of packs, to notice packs added or removed while the
// screen shows it (`PackSelectionScreen.Watcher`).
folder_stamp :: proc(dir: ^Path) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut stamp: Vec<_> = std::fs::read_dir(dir)
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .flatten()
    // rust: .map(|e| {
    // rust: let modified = e.metadata().and_then(|m| m.modified()).ok();
    // rust: (e.file_name().to_string_lossy().into_owned(), modified)
    // rust: })
    // rust: .collect();
    // rust: stamp.sort();
    // rust: stamp
}
// Create World's packs into the new world before it opens
// (`copyTempDataPackDirToNewWorld`): every pack of `dir` goes to
// `<world>/datapacks`, and `datapacks.json` enables those `selected`
// (lowest priority first) and disables the rest.
install :: proc(dir: ^Path, world: ^Path, selected: ^[string]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let err = |p: &Path, e: std::io::Error| format!("{}: {e}", p.display());
    // rust: let target = world.join("datapacks");
    // rust: std::fs::create_dir_all(&target).map_err(|e| err(&target, e))?;
    // rust: let mut disabled = Vec::new();
    // rust: for pack in crate::packs::folder(dir, horizon_core::version::DATA_PACK_FORMAT) {
    // rust: let (crate::packs::Source::Dir(from) | crate::packs::Source::Zip(from)) = &pack.source;
    // rust: copy(from, &target.join(pack.id.trim_start_matches("file/")))?;
    // rust: if !selected.contains(&pack.id) {
    // rust: disabled.push(pack.id);
}
}
    // rust: if !selected.iter().any(|id| id == "vanilla") {
    // rust: disabled.push("vanilla".into());
}
    // rust: let json = serde_json::json!({ "enabled": selected, "disabled": disabled });
    // rust: let file = world.join("datapacks.json");
    // rust: std::fs::write(&file, json.to_string()).map_err(|e| err(&file, e))
}
// Re-Create World's packs from a saved world: a new folder holding a copy of
// its `datapacks` (`CreateWorldScreen.createTempDataPackDirFromExistingWorld`; `None` when the
// world has none), and the selection its `datapacks.json` makes, lowest
// priority first (`WorldOpenFlows.recreateWorldData` keeps the world's `DataConfiguration`).
// The built-in pack is selected unless the world turned it off.
for_recreate :: proc(world: ^Path) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let packs = discover(world);
    // No flags here: the recreated world keeps the original's
    // `enabled_features`, and the flag-aware load re-adds the feature packs
    // it asks for (`for_recreate`'s selection only seeds the new world's
    // `datapacks.json`).
    // rust: let mut selected = enabled_ids(world, &packs, &[]);
    // rust: let vanilla_off = std::fs::read(world.join("datapacks.json"))
    // rust: .ok()
    // rust: .and_then(|b| serde_json::from_slice::<serde_json::Value>(&b).ok())
    // rust: .and_then(|v| v["disabled"].as_array().cloned())
    // rust: .is_some_and(|a| a.iter().any(|id| id.as_str() == Some("vanilla")));
    // rust: if !vanilla_off {
    // rust: selected.insert(0, "vanilla".into());
}
    // rust: if packs.is_empty() {
    // rust: return (None, selected);
}
    // rust: let dir = temp_folder().ok().and_then(|dir| {
    // rust: if copy(&world.join("datapacks"), &dir).is_ok() {
    // rust: Some(dir)
    // rust: } else {
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: None
}
    // rust: });
    // rust: (dir, selected)
}
// A file, or a folder and everything in it.
copy :: proc(from: ^Path, to: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let err = |e: std::io::Error| format!("{} -> {}: {e}", from.display(), to.display());
    // rust: if !from.is_dir() {
    // rust: return std::fs::copy(from, to).map(drop).map_err(err);
}
    // rust: std::fs::create_dir_all(to).map_err(err)?;
    // rust: for e in std::fs::read_dir(from).map_err(err)?.flatten() {
    // rust: copy(&e.path(), &to.join(e.file_name()))?;
}
    // rust: Ok(())
}

// ---- functions ---------------------------------------------------------------

// A `.mcfunction`: plain command lines and macro lines.
Function :: struct {
    id: string,
    lines: [dynamic]FunctionLine,
    // Macro parameter names in order of first use.
    parameters: [dynamic]string,
}
FunctionLine :: enum {
    Command(String),
    // A `$` line: text with `$(name)` placeholders.
    Macro(String),
}
    // rust: impl Function {
is_macro :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.parameters.is_empty()
}
    // `MacroFunction.instantiate`: the command lines with the arguments
    // substituted. The error is the translation key and its arguments.
    // rust: pub fn instantiate(
    // rust: &self,
    // rust: arguments: Option<&Tag>,
    // rust: ) -> Result<Vec<String>, (String, Vec<String>)> {
    // rust: let mut values: BTreeMap<&str, String> = BTreeMap::new();
    // rust: if self.is_macro() {
    // rust: let Some(args) = arguments else {
    // rust: return Err((
    // rust: "commands.function.error.missing_arguments".into(),
    // rust: vec![self.id.clone()],
    // rust: ));
}
    // rust: for p in &self.parameters {
    // rust: let Some(v) = args.get(p) else {
    // rust: return Err((
    // rust: "commands.function.error.missing_argument".into(),
    // rust: vec![self.id.clone(), p.clone()],
    // rust: ));
}
    // rust: values.insert(p, stringify(v));
}
}
    // rust: Ok(self
    // rust: .lines
    // rust: .iter()
    // rust: .map(|l| match l {
    // rust: FunctionLine::Command(c) => c.clone(),
    // rust: FunctionLine::Macro(t) => substitute(t, &values),
    // rust: })
    // rust: .collect())
}
}
// `MacroFunction.stringify`.
stringify :: proc(tag: ^Tag) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match tag {
    // rust: Tag::Float(v) => decimal(f64::from(f32::from_bits(*v))),
    // rust: Tag::Double(v) => decimal(f64::from_bits(*v)),
    // rust: Tag::Byte(v) => v.to_string(),
    // rust: Tag::Short(v) => v.to_string(),
    // rust: Tag::Long(v) => v.to_string(),
    // rust: Tag::String(s) => s.to_string_lossy(),
    // rust: other => crate::snbt::to_snbt(other),
}
}
// `DecimalFormat("#")` with up to 15 fraction digits.
decimal :: proc(v: f64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: if v.is_nan() {
    // rust: return "NaN".into();
}
    // rust: let s = format!("{v:.15}");
    // rust: let s = s.trim_end_matches('0').trim_end_matches('.');
    // rust: if s == "-0" || s.is_empty() {
    // rust: "0".into()
    // rust: } else {
    // rust: s.to_owned()
}
}
substitute :: proc(template: string, values: ^BTreeMap<string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = String::new();
    // rust: let mut rest = template;
    // rust: while let Some(i) = rest.find("$(") {
    // rust: out.push_str(&rest[..i]);
    // rust: let after = &rest[i + 2..];
    // rust: match after.find(')') {
    // rust: Some(j) => {
    // rust: if let Some(v) = values.get(&after[..j]) {
    // rust: out.push_str(v);
}
    // rust: rest = &after[j + 1..];
}
    // rust: None => {
    // rust: out.push_str(&rest[i..]);
    // rust: rest = "";
}
}
}
    // rust: out.push_str(rest);
    // rust: out
}
macro_parameters :: proc(line: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::new();
    // rust: let mut rest = line;
    // rust: while let Some(i) = rest.find("$(") {
    // rust: let after = &rest[i + 2..];
    // rust: let Some(j) = after.find(')') else {
    // rust: return Err(format!("Unterminated macro variable in '{line}'"));
}
    // rust: let name = &after[..j];
    // rust: if name.is_empty() || !name.chars().all(|c| c.is_ascii_alphanumeric() || c == '_') {
    // rust: return Err(format!("Invalid macro variable name '{name}' in '{line}'"));
}
    // rust: out.push(name.to_owned());
    // rust: rest = &after[j + 1..];
}
    // rust: Ok(out)
}
// `CommandFunction.fromLines`: comments, blank lines, `\` continuation and
// `$` macro lines. Command syntax is checked by the caller.
parse_function :: proc(id: string, text: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let raw: Vec<&str> = text.lines().collect();
    // rust: let mut lines = Vec::new();
    // rust: let mut parameters: Vec<String> = Vec::new();
    // rust: let mut i = 0;
    // rust: while i < raw.len() {
    // rust: let number = i + 1;
    // rust: let mut line = raw[i].trim().to_owned();
    // rust: if line.ends_with('\\') {
    // rust: loop {
    // rust: i += 1;
    // rust: if i == raw.len() {
    // rust: return Err("Line continuation at end of file".into());
}
    // rust: line.pop();
    // rust: line.push_str(raw[i].trim());
    // rust: if !line.ends_with('\\') {
    // rust: break;
}
}
}
    // rust: i += 1;
    // rust: if line.is_empty() || line.starts_with('#') {
    // rust: continue;
}
    // rust: if let Some(rest) = line.strip_prefix('/') {
    // rust: let name: String = rest
    // rust: .chars()
    // rust: .take_while(|c| c.is_ascii_alphanumeric() || matches!(c, '_' | '-' | '.' | '+'))
    // rust: .collect();
    // rust: return Err(if rest.starts_with('/') {
    // rust: format!(
    // rust: "Unknown or invalid command '{line}' on line {number} (if you intended to make a comment, use '#' not '//')"
    // rust: )
    // rust: } else {
    // rust: format!(
    // rust: "Unknown or invalid command '{line}' on line {number} (did you mean '{name}'? Do not use a preceding forwards slash.)"
    // rust: )
    // rust: });
}
    // rust: if let Some(m) = line.strip_prefix('$') {
    // rust: for p in macro_parameters(m)? {
    // rust: if !parameters.contains(&p) {
    // rust: parameters.push(p);
}
}
    // rust: lines.push(FunctionLine::Macro(m.to_owned()));
    // rust: } else {
    // rust: lines.push(FunctionLine::Command(line));
}
}
    // rust: Ok(Function {
    // rust: id: id.to_owned(),
    // rust: lines,
    // rust: parameters,
    // rust: })
}

// The data of every enabled pack: functions, function tags, predicates.
DataStore :: struct {
    functions: BTreeMap<string,
    // Function tag id -> entries (`ns:f`, `#ns:tag`), with `required` flags.
    function_tags: BTreeMap<string,
    predicates: BTreeMap<string,
    // `item_modifier` files, for `/item modify`.
    item_modifiers: BTreeMap<string,
    // The content tables' raw files from the packs after the built-in one:
    // `recipe/`, `recipe_filter/`, `loot_table/`, `advancement/`, `dialog/`, `damage_type/`, `data_maps/` and `tags/…/` files, by
    // `<kind-dir>/<ns>:<path>`, each id's files in pack order. The tables
    // merge them over what they read from the resource root.
    files: BTreeMap<string,
    // Functions that failed to parse (id, message), for logging.
    errors: Vec<(string,
}
// `<kind-dir>/<ns>:<path>` for a pack file the content tables read:
// `recipe/`, `recipe_filter/`, `loot_table/`, `advancement/`, `trade_set/`,
// `villager_trade/`, `dialog/`, `damage_type/`, `data_maps/` or `tags/<sub>/`, where the id keeps the sub
// path so a nested tag kind stays addressable.
content_id :: proc(file: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let rest = file.strip_prefix("data/")?;
    // rust: let (ns, rest) = rest.split_once('/')?;
    // rust: let (kind, rest) = rest.split_once('/')?;
    // rust: let kind = match kind {
    // rust: "recipe" | "recipe_filter" | "loot_table" | "advancement" | "trade_set"
    // rust: | "villager_trade" | "dialog" | "damage_type" | "data_maps" => kind,
        // A tag id is `{ns}:{path-under-tags}` (`tags/worldgen/biome/
        // test:sub/mytag`), the whole path after the namespace, so nested
        // registries keep their directory (`TagLoader`'s id shape).
    // rust: "tags" => {
    // rust: return Some(format!("tags/{ns}:{}", rest.strip_suffix(".json")?));
}
    // rust: _ => return None,
}
    // rust: Some(format!("{kind}/{ns}:{}", rest.strip_suffix(".json")?))
}
// `ns:path` for a file `data/<ns>/<kind>/<path>.<ext>`.
resource_id :: proc(file: string, kind: string, ext: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let rest = file.strip_prefix("data/")?;
    // rust: let (ns, rest) = rest.split_once('/')?;
    // rust: let path = rest
    // rust: .strip_prefix(kind)?
    // rust: .strip_prefix('/')?
    // rust: .strip_suffix(ext)?;
    // rust: Some(format!("{ns}:{path}"))
}
    // rust: impl DataStore {
load :: proc(packs: ^[^DataPack]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut s = Self::default();
    // rust: for pack in packs {
            // `tags` walks the whole tags tree, so a `tags/function` file is
            // listed by both kinds: handle every file once.
    // rust: let mut seen = std::collections::BTreeSet::new();
    // rust: let builtin = pack.id == "vanilla";
    // rust: for f in pack.list_kinds(&[
    // rust: "advancement",
    // rust: "damage_type",
    // rust: "data_maps",
    // rust: "dialog",
    // rust: "function",
    // rust: "item_modifier",
    // rust: "loot_table",
    // rust: "predicate",
    // rust: "recipe",
    // rust: "recipe_filter",
    // rust: "tags",
    // rust: "trade_set",
    // rust: "villager_trade",
    // rust: ]) {
    // rust: if !seen.insert(f.clone()) {
    // rust: continue;
}
    // rust: if let Some(id) = resource_id(&f, "function", ".mcfunction")
    // rust: && let Some(bytes) = pack.read(&f)
    // rust: {
    // rust: match parse_function(&id, &String::from_utf8_lossy(&bytes)) {
    // rust: Ok(func) => {
    // rust: s.functions.insert(id, func);
}
    // rust: Err(e) => s.errors.push((id, e)),
}
    // rust: } else if let Some(id) = resource_id(&f, "tags/function", ".json")
    // rust: && let Some(bytes) = pack.read(&f)
    // rust: && let Ok(v) = serde_json::from_slice::<serde_json::Value>(&bytes)
    // rust: {
    // rust: let entries = tag_entries(&v);
    // rust: let slot = s.function_tags.entry(id).or_default();
    // rust: if v["replace"].as_bool() == Some(true) {
    // rust: slot.clear();
}
    // rust: slot.extend(entries);
    // rust: } else if let Some(id) = resource_id(&f, "predicate", ".json")
    // rust: && let Some(bytes) = pack.read(&f)
    // rust: && let Ok(v) = serde_json::from_slice(&bytes)
    // rust: {
    // rust: s.predicates.insert(id, v);
    // rust: } else if let Some(id) = resource_id(&f, "item_modifier", ".json")
    // rust: && let Some(bytes) = pack.read(&f)
    // rust: && let Ok(v) = serde_json::from_slice(&bytes)
    // rust: {
    // rust: s.item_modifiers.insert(id, v);
    // rust: } else if !builtin
    // rust: && let Some(id) = content_id(&f)
    // rust: && let Some(bytes) = pack.read(&f)
    // rust: {
                    // The built-in pack's content files are the resource
                    // root's own, which the tables read from disk; only the
                    // world's packs come through here.
    // rust: s.files.entry(id).or_default().push(bytes);
}
}
}
    // rust: s
}
    // `FunctionManager.getTag`: the functions a tag expands to (nested tags
    // included, each function once).
tag_functions :: proc(self: ^Self, id: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::new();
    // rust: let mut seen_fns = std::collections::HashSet::new();
    // rust: let mut seen_tags = std::collections::HashSet::new();
    // rust: self.expand(id, &mut out, &mut seen_fns, &mut seen_tags);
    // rust: out
}
    // Depth-first walk keeping first-seen order. Each tag is expanded at most
    // once, so reference cycles end and nesting depth is not capped.
    // rust: fn expand<'a>(
    // rust: &'a self,
    // rust: id: &'a str,
    // rust: out: &mut Vec<String>,
    // rust: seen_fns: &mut std::collections::HashSet<&'a str>,
    // rust: seen_tags: &mut std::collections::HashSet<&'a str>,
    // rust: ) {
    // rust: if !seen_tags.insert(id) {
    // rust: return;
}
    // rust: let Some(entries) = self.function_tags.get(id) else {
    // rust: return;
}
    // rust: for (e, required) in entries {
    // rust: match e.strip_prefix('#') {
    // rust: Some(inner) => self.expand(inner, out, seen_fns, seen_tags),
    // rust: None => {
    // rust: if (self.functions.contains_key(e) || *required) && seen_fns.insert(e) {
    // rust: out.push(e.clone());
}
}
}
}
}
}
normalize :: proc(id: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: if id.contains(':') {
    // rust: id.to_owned()
    // rust: } else {
    // rust: format!("minecraft:{id}")
}
}
tag_entries :: proc(v: ^serde_json::Value) -> V {
    // Ported from Horizon
    return {}
}
    // rust: v["values"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(|e| match e {
    // rust: serde_json::Value::String(s) => Some((hash_normalize(s), true)),
    // rust: serde_json::Value::Object(o) => Some((
    // rust: hash_normalize(o.get("id")?.as_str()?),
    // rust: o.get("required")
    // rust: .and_then(serde_json::Value::as_bool)
    // rust: .unwrap_or(true),
    // rust: )),
    // rust: _ => None,
    // rust: })
    // rust: .collect()
}
hash_normalize :: proc(s: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match s.strip_prefix('#') {
    // rust: Some(rest) => format!("#{}", normalize(rest)),
    // rust: None => normalize(s),
}
}

// Whether every flag `pack` asks for (`Pack.getRequestedFeatures`) is among
// the world's `enabled_features`.
features_enabled :: proc(pack: ^DataPack, enabled_features: ^[string]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: pack.features()
    // rust: .iter()
    // rust: .all(|f| enabled_features.iter().any(|e| e == f))
}

// The ids of `packs` (a world's, from `discover`) that are enabled, lowest
// priority first: those `<world>/datapacks.json` lists as enabled, in its
// order, then every pack it lists neither way, in name order.
//
// `enabled_features` are the world's feature flags
// (`WorldDataConfiguration.enabledFeatures`): a pack a pack file selected
// while asking for missing features comes off
// (`MinecraftServer.configurePackRepository`), and a feature pack whose
// features the world enables is forced on however the world's selection
// feels about it (`MinecraftServer.enableForcedFeaturePacks`).
enabled_ids :: proc(world: ^Path, packs: ^[DataPack], enabled_features: ^[string]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let saved: Option<serde_json::Value> = std::fs::read(world.join("datapacks.json"))
    // rust: .ok()
    // rust: .and_then(|b| serde_json::from_slice(&b).ok());
    // rust: let list = |key: &str| -> Vec<String> {
    // rust: saved
    // rust: .as_ref()
    // rust: .and_then(|v| v[key].as_array())
    // rust: .map(|a| {
    // rust: a.iter()
    // rust: .filter_map(|s| s.as_str().map(str::to_owned))
    // rust: .collect()
    // rust: })
    // rust: .unwrap_or_default()
}
    // rust: let disabled = list("disabled");
    // rust: let mut enabled: Vec<String> = list("enabled")
    // rust: .into_iter()
    // rust: .filter(|id| packs.iter().any(|p| &p.id == id))
    // rust: .filter(|id| {
    // rust: packs
    // rust: .iter()
    // rust: .find(|p| &p.id == id)
    // rust: .is_none_or(|p| features_enabled(p, enabled_features))
    // rust: })
    // rust: .collect();
    // rust: for p in packs {
        // A pack nobody mentions comes on (`PackRepository.reload` selects
        // every new pack), but a feature pack stays off until the world
        // enabled its flag (`PackSource.FEATURE` starts unselected).
    // rust: if !enabled.contains(&p.id)
    // rust: && !disabled.contains(&p.id)
    // rust: && p.id.starts_with("file/")
    // rust: && features_enabled(p, enabled_features)
    // rust: {
    // rust: enabled.push(p.id.clone());
}
}
    // rust: for p in packs {
    // rust: let feature_pack = !p.id.starts_with("file/") && p.id != "vanilla";
    // rust: if feature_pack
    // rust: && !p.features().is_empty()
    // rust: && features_enabled(p, enabled_features)
    // rust: && !enabled.contains(&p.id)
    // rust: {
    // rust: enabled.push(p.id.clone());
}
}
    // rust: enabled
}

// The level stems of `packs` (`data/<namespace>/dimension/<path>.json`, lowest priority first,
// as `enabled_ids` orders them): the id `namespace:path` and the parsed JSON, a later pack's
// file for an id replacing an earlier one's. This is `context.datapackDimensions()` of
// `WorldOpenFlows.loadWorldStem`.
dimension_stems :: proc(packs: ^[^DataPack]) -> B {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = BTreeMap::new();
    // rust: for pack in packs {
    // rust: for file in pack.list_kinds(&["dimension"]) {
    // rust: let Some(rest) = file.strip_prefix("data/") else {
    // rust: continue;
}
    // rust: let Some((namespace, rest)) = rest.split_once('/') else {
    // rust: continue;
}
    // rust: let Some(path) = rest
    // rust: .strip_prefix("dimension/")
    // rust: .and_then(|p| p.strip_suffix(".json"))
    // rust: else {
    // rust: continue;
}
    // rust: if let Some(json) = pack
    // rust: .read(&file)
    // rust: .and_then(|b| serde_json::from_slice(&b).ok())
    // rust: {
    // rust: out.insert(format!("{namespace}:{path}"), json);
}
}
}
    // rust: out
}

// ---- worldgen ----------------------------------------------------------------

// The worldgen entries of `packs` (lowest priority first, the built-in pack
// left out: the prepared bundles are it) for the chunk generator, and what
// it leaves out, for the log. `biomes` says which biomes the game has: a
// pack's new biome is left out (the game has no colours, sounds or id for it).
    // rust: pub fn worldgen_overrides(
    // rust: packs: &[&DataPack],
    // rust: biomes: impl Fn(&str) -> bool,
    // rust: ) -> (WorldgenOverrides, Vec<String>) {
    // rust: let mut out = WorldgenOverrides::default();
    // rust: let mut not_read: BTreeMap<String, usize> = BTreeMap::new();
    // rust: let mut warnings = Vec::new();
    // rust: for pack in packs {
    // rust: for file in pack.list_kinds(&overrides::PACK_KINDS) {
    // rust: let read = || String::from_utf8(pack.read(&file)?).ok();
    // rust: match out.add_file(&pack.id, &file, read) {
    // rust: PackFile::Read | PackFile::Other => {}
    // rust: PackFile::NotRead(kind) => {
    // rust: *not_read.entry(format!("{}: {kind}", pack.id)).or_default() += 1
}
    // rust: PackFile::Unreadable => warnings.push(format!("{}: {file}: unreadable", pack.id)),
}
}
}
    // rust: warnings.extend(out.finish(biomes));
    // rust: for (kind, files) in not_read {
    // rust: warnings.push(format!("{kind}: {files} files the generator does not read"));
}
    // rust: (out, warnings)
}

    // rust: mod tests {
//     use super::*;

data_map_files_are_content_files_keyed_by_map_namespace_and_registry :: proc() {
}
    // rust: assert_eq!(
    // rust: content_id("data/mymod/data_maps/item/fuel.json").as_deref(),
    // rust: Some("data_maps/mymod:item/fuel")
    // rust: );
    // rust: assert_eq!(content_id("data/mymod/data_maps/item/fuel.txt"), None);
}

a_pack_that_cannot_be_copied_is_reported :: proc() {
}
    // rust: let root = std::env::temp_dir().join(format!("hz-datapack-copy-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&root);
    // rust: let pack = root.join("pack");
    // rust: std::fs::create_dir_all(pack.join("data")).unwrap();
    // rust: std::fs::write(pack.join("pack.mcmeta"), "{}").unwrap();
    // rust: std::fs::write(pack.join("data/functions.mcfunction"), "").unwrap();
        // A file where the pack's folder goes: every copy under it fails.
    // rust: let blocked = root.join("blocked");
    // rust: std::fs::write(&blocked, "").unwrap();
    // rust: assert!(!copy_pack(&pack, &blocked));
    // rust: let dir = root.join("packs");
    // rust: assert!(copy_pack(&pack, &dir));
    // rust: assert!(dir.join("pack/pack.mcmeta").is_file());
    // rust: let _ = std::fs::remove_dir_all(&root);
}

enabled_packs_override_worldgen_in_order :: proc() {
}
    // rust: let dir = std::env::temp_dir().join(format!("hz-datapack-worldgen-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: let write = |pack: &str, p: &str, t: &str| {
    // rust: let path = dir.join("datapacks").join(pack).join(p);
    // rust: std::fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: std::fs::write(path, t).unwrap();
}
    // rust: for pack in ["a", "b", "off"] {
    // rust: write(pack, "pack.mcmeta", "{}");
    // rust: write(pack, "data/minecraft/worldgen/noise/cave.json", pack);
    // rust: write(
    // rust: pack,
    // rust: "data/minecraft/tags/worldgen/biome/is_hill.json",
    // rust: "{\"values\":[]}",
    // rust: );
}
    // rust: write("a", "data/minecraft/worldgen/biome/new_peaks.json", "{}");
    // rust: write("a", "data/minecraft/worldgen/biome/plains.json", "{}");
    // rust: write(
    // rust: "a",
    // rust: "data/minecraft/worldgen/world_preset/normal.json",
    // rust: "{}",
    // rust: );
    // rust: write(
    // rust: "b",
    // rust: "data/minecraft/dimension_type/overworld.json",
    // rust: "{\"min_y\":-64,\"height\":2096}",
    // rust: );
        // `b` is enabled first, so `a` (enabled after it) wins.
    // rust: std::fs::write(
    // rust: dir.join("datapacks.json"),
    // rust: "{\"enabled\":[\"file/b\",\"file/a\"],\"disabled\":[\"file/off\"]}",
    // rust: )
    // rust: .unwrap();
    // rust: let packs = discover(&dir);
    // rust: let enabled = enabled_ids(&dir, &packs, &[]);
    // rust: assert_eq!(enabled, ["file/b", "file/a"]);
    // rust: let enabled: Vec<&DataPack> = enabled
    // rust: .iter()
    // rust: .map(|id| packs.iter().find(|p| &p.id == id).unwrap())
    // rust: .collect();
    // rust: let (o, warnings) = worldgen_overrides(&enabled, |b| b == "minecraft:plains");
    // rust: assert_eq!(
    // rust: o.entries("noises").collect::<Vec<_>>(),
    // rust: [("minecraft:cave", "a")]
    // rust: );
    // rust: assert_eq!(
    // rust: o.entries("biomes").collect::<Vec<_>>(),
    // rust: [("minecraft:plains", "{}")]
    // rust: );
    // rust: let tag_packs: Vec<&str> = o.tags("biome_tags").map(|(_, p, _)| p).collect();
    // rust: assert_eq!(tag_packs, ["file/b", "file/a"]);
    // rust: assert_eq!(warnings.len(), 2, "{warnings:?}");
    // rust: assert!(warnings[0].contains("minecraft:new_peaks"));
    // rust: assert!(warnings[1].contains("worldgen/world_preset"));
    // rust: assert_eq!(
    // rust: o.level_height("minecraft:overworld").map(|h| h.height),
    // rust: Some(2096)
    // rust: );
    // rust: let _ = std::fs::remove_dir_all(&dir);
}
//     use horizon_world::nbt::parse_snbt;

parses_comments_continuations_and_macros :: proc() {
}
    // rust: let f = parse_function(
    // rust: "a:b",
    // rust: "# a comment\n\nsay hi\n  say \\\n  there  \n$say $(who) is $(n)\n$tell $(who) $(who)\n",
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: f.lines,
    // rust: vec![
    // rust: FunctionLine::Command("say hi".into()),
    // rust: FunctionLine::Command("say there".into()),
    // rust: FunctionLine::Macro("say $(who) is $(n)".into()),
    // rust: FunctionLine::Macro("tell $(who) $(who)".into()),
    // rust: ]
    // rust: );
    // rust: assert_eq!(f.parameters, ["who", "n"]);
    // rust: assert!(
    // rust: parse_function("a:b", "/say hi")
    // rust: .unwrap_err()
    // rust: .contains("did you mean 'say'")
    // rust: );
    // rust: assert!(
    // rust: parse_function("a:b", "//x")
    // rust: .unwrap_err()
    // rust: .contains("use '#'")
    // rust: );
    // rust: assert!(parse_function("a:b", "say \\").is_err());
    // rust: assert!(parse_function("a:b", "$say $(bad name)").is_err());
}

macros_substitute_vanilla_text :: proc() {
}
    // rust: let f = parse_function("a:b", "$say $(s) $(i) $(d) $(l) $(b) $(c)\nsay plain").unwrap();
    // rust: let args = parse_snbt("{s:\"hi\",i:5,d:1.5d,l:7L,b:1b,c:{x:1}}")
    // rust: .unwrap()
    // rust: .0;
    // rust: let out = f.instantiate(Some(&args)).unwrap();
    // rust: assert_eq!(out, ["say hi 5 1.5 7 1 {x:1}", "say plain"]);
    // rust: let args = parse_snbt("{s:\"x\",i:1,d:3.0d,l:1L,b:0b,c:{}}").unwrap().0;
    // rust: assert_eq!(f.instantiate(Some(&args)).unwrap()[0], "say x 1 3 1 0 {}");
    // rust: assert_eq!(
    // rust: f.instantiate(None).unwrap_err().0,
    // rust: "commands.function.error.missing_arguments"
    // rust: );
    // rust: let partial = parse_snbt("{s:\"x\"}").unwrap().0;
    // rust: assert_eq!(
    // rust: f.instantiate(Some(&partial)).unwrap_err().0,
    // rust: "commands.function.error.missing_argument"
    // rust: );
        // A plain function needs no arguments.
    // rust: let plain = parse_function("a:p", "say 1").unwrap();
    // rust: assert_eq!(plain.instantiate(None).unwrap(), ["say 1"]);
}

packs_provide_functions_and_tags :: proc() {
}
    // rust: let dir = std::env::temp_dir().join(format!("hz-datapack-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: let pack = dir.join("datapacks/mypack");
    // rust: let write = |p: &str, t: &str| {
    // rust: let path = pack.join(p);
    // rust: std::fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: std::fs::write(path, t).unwrap();
}
    // rust: write(
    // rust: "pack.mcmeta",
    // rust: "{\"pack\":{\"description\":\"Hello\",\"pack_format\":1}}",
    // rust: );
    // rust: write(
    // rust: "data/mine/function/a.mcfunction",
    // rust: "say a\nfunction mine:sub/b\n",
    // rust: );
    // rust: write("data/mine/function/sub/b.mcfunction", "say b");
    // rust: write(
    // rust: "data/minecraft/tags/function/tick.json",
    // rust: "{\"values\":[\"mine:a\",\"#mine:more\",{\"id\":\"mine:gone\",\"required\":false}]}",
    // rust: );
    // rust: write(
    // rust: "data/mine/tags/function/more.json",
    // rust: "{\"values\":[\"mine:sub/b\",\"mine:a\"]}",
    // rust: );
    // rust: write(
    // rust: "data/mine/predicate/p.json",
    // rust: "{\"condition\":\"minecraft:random_chance\",\"chance\":1}",
    // rust: );
    // rust: write(
    // rust: "data/mine/dialog/config/points.json",
    // rust: "{\"type\":\"minecraft:notice\",\"title\":\"Points\"}",
    // rust: );
    // rust: let packs = discover(&dir);
    // rust: assert_eq!(packs.len(), 1);
    // rust: assert_eq!(packs[0].id, "file/mypack");
    // rust: assert_eq!(packs[0].description(), "Hello");
    // rust: let store = DataStore::load(&[&packs[0]]);
    // rust: assert_eq!(store.functions.len(), 2);
    // rust: assert!(store.functions.contains_key("mine:sub/b"));
    // rust: assert_eq!(
    // rust: store.tag_functions("minecraft:tick"),
    // rust: ["mine:a", "mine:sub/b"]
    // rust: );
    // rust: assert!(store.predicates.contains_key("mine:p"));
        // Dialogs reach the synchronized registry through the content files.
    // rust: assert_eq!(
    // rust: store.files["dialog/mine:config/points"],
    // rust: [b"{\"type\":\"minecraft:notice\",\"title\":\"Points\"}".to_vec()]
    // rust: );
    // rust: let _ = std::fs::remove_dir_all(&dir);
}

tag_resolution_dedupes_fast_ends_cycles_and_nests_deeply :: proc() {
}
    // rust: let mut store = DataStore::default();
    // rust: let big: Vec<(String, bool)> = (0..50_000)
    // rust: .map(|i| (format!("t:f{}", i % 25_000), true))
    // rust: .collect();
    // rust: store.function_tags.insert("t:big".into(), big);
    // rust: let start = std::time::Instant::now();
    // rust: let got = store.tag_functions("t:big");
    // rust: assert_eq!(got.len(), 25_000);
    // rust: assert_eq!(got[0], "t:f0");
    // rust: assert!(start.elapsed() < std::time::Duration::from_secs(5));
        // A cycle terminates and keeps first-seen order.
    // rust: store.function_tags.insert(
    // rust: "t:a".into(),
    // rust: vec![("#t:b".into(), true), ("t:x".into(), true)],
    // rust: );
    // rust: store.function_tags.insert(
    // rust: "t:b".into(),
    // rust: vec![("#t:a".into(), true), ("t:y".into(), true)],
    // rust: );
    // rust: assert_eq!(store.tag_functions("t:a"), ["t:y", "t:x"]);
        // Nesting deeper than the old cap of 16 still resolves.
    // rust: for i in 0..40 {
    // rust: store
    // rust: .function_tags
    // rust: .insert(format!("d:{i}"), vec![(format!("#d:{}", i + 1), true)]);
}
    // rust: store
    // rust: .function_tags
    // rust: .insert("d:40".into(), vec![("t:deep".into(), true)]);
    // rust: assert_eq!(store.tag_functions("d:0"), ["t:deep"]);
}

folder_packs_list_the_needed_kinds_in_walk_order :: proc() {
}
    // rust: let dir = std::env::temp_dir().join(format!("hz-datapack-kinds-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: let pack = dir.join("datapacks/p");
    // rust: let files = [
    // rust: "data/b/function/z.mcfunction",
    // rust: "data/b/function/a/y.mcfunction",
    // rust: "data/b/loot_table/l.json",
    // rust: "data/b/tags/block/t.json",
    // rust: "data/b/tags/function/load.json",
    // rust: "data/b/predicate/p.json",
    // rust: "data/a/item_modifier/m.json",
    // rust: "data/a/function/f.mcfunction",
    // rust: "data/a/functions/old.mcfunction",
    // rust: "data/a/recipe/r.json",
    // rust: "data/a/tags/function/tick.json",
    // rust: "data/c/worldgen/noise/n.json",
    // rust: ];
    // rust: for f in files {
    // rust: let path = pack.join(f);
    // rust: std::fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: std::fs::write(path, "{}").unwrap();
}
    // rust: std::fs::write(pack.join("pack.mcmeta"), "{}").unwrap();
    // rust: let p = DataPack::builtin(&pack);
    // rust: let kinds = ["function", "item_modifier", "predicate", "tags/function"];
    // rust: let wanted: Vec<String> = p
    // rust: .list("data/")
    // rust: .into_iter()
    // rust: .filter(|f| {
    // rust: let rest = f.splitn(3, '/').nth(2).unwrap_or_default();
    // rust: kinds.iter().any(|k| rest.starts_with(&format!("{k}/")))
    // rust: })
    // rust: .collect();
    // rust: assert_eq!(wanted.len(), 7);
    // rust: assert_eq!(p.list_kinds(&kinds), wanted);
    // rust: let _ = std::fs::remove_dir_all(&dir);
}

create_world_installs_its_packs :: proc() {
}
    // rust: let root = std::env::temp_dir().join(format!("hz-datapack-install-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&root);
    // rust: let (dir, world) = (root.join("mcworld"), root.join("world"));
    // rust: let write = |pack: &str, p: &str, t: &str| {
    // rust: let path = dir.join(pack).join(p);
    // rust: std::fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: std::fs::write(path, t).unwrap();
}
    // rust: write(
    // rust: "fns",
    // rust: "pack.mcmeta",
    // rust: r#"{"pack":{"min_format":121,"max_format":121}}"#,
    // rust: );
    // rust: write("fns", "data/x/function/f.mcfunction", "say hi");
    // rust: write(
    // rust: "off",
    // rust: "pack.mcmeta",
    // rust: r#"{"pack":{"min_format":121,"max_format":121}}"#,
    // rust: );
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: let mut zip = zip::ZipWriter::new(std::fs::File::create(dir.join("old.zip")).unwrap());
    // rust: zip.start_file("pack.mcmeta", zip::write::SimpleFileOptions::default())
    // rust: .unwrap();
    // rust: std::io::Write::write_all(&mut zip, br#"{"pack":{"pack_format":48}}"#).unwrap();
    // rust: zip.finish().unwrap();
    // rust: let infos = screen_packs(&dir, &root);
    // rust: let ids: Vec<&str> = infos.iter().map(|p| p.id.as_str()).collect();
    // rust: assert_eq!(ids, ["file/fns", "file/off", "file/old.zip", "vanilla"]);
    // rust: let compat: Vec<_> = infos.iter().map(|p| p.compat).collect();
//         use crate::pack_screen::Compat;
    // rust: assert_eq!(
    // rust: compat,
    // rust: [
    // rust: Compat::Compatible,
    // rust: Compat::Compatible,
    // rust: Compat::TooOld,
    // rust: Compat::Compatible
    // rust: ]
    // rust: );
    // rust: let selected = ["vanilla", "file/old.zip", "file/fns"].map(String::from);
    // rust: install(&dir, &world, &selected).unwrap();
    // rust: let packs = discover(&world);
    // rust: let ids: Vec<&str> = packs.iter().map(|p| p.id.as_str()).collect();
    // rust: assert_eq!(ids, ["file/fns", "file/off", "file/old.zip"]);
    // rust: let saved: serde_json::Value =
    // rust: serde_json::from_slice(&std::fs::read(world.join("datapacks.json")).unwrap()).unwrap();
    // rust: assert_eq!(
    // rust: saved,
    // rust: serde_json::json!({"enabled": selected, "disabled": ["file/off"]})
    // rust: );
    // rust: let _ = std::fs::remove_dir_all(&root);
}
}
