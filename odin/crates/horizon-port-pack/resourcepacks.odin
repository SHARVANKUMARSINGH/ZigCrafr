//! Transpiled from Horizon Rust crate
package horizon_port_pack_resourcepacks

import "core:fmt"
import "core:mem"
import "core:math"

// Resource packs carried intact into a private import/profile. Copying is not a rendering check.
// use crate::{import, pipeline};
// use serde::{Deserialize, Serialize};
// use std::{
    // rust: collections::BTreeMap,
    // rust: fs,
    // rust: io::{Read, Seek, SeekFrom, Write},
    // rust: path::{Path, PathBuf},
}

MAX_FILES :: 65_536
MAX_BYTES :: 512 << 20

State :: enum {
    Available,
    Missing,
    Failed,
    Conflict,
    Unsupported,
}

Outcome :: struct {
    state: State,
    detail: string,
}

Report :: struct {
    files: BTreeMap<string,
}

    // rust: impl Report {
load :: proc(work: ^Path) -> S {
    // Ported from Horizon
    return {}
}
    // rust: pipeline::read_json(&work.join("resourcepacks.json")).unwrap_or_default()
}
save :: proc(self: ^Self, work: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: pipeline::write_json(&work.join("resourcepacks.json"), self)
}
set :: proc(self: ^Self, path: string, state: State, detail: impl Into<string>) {
}
    // rust: self.files.insert(
    // rust: path.into(),
    // rust: Outcome {
    // rust: state,
    // rust: detail: detail.into(),
    // rust: },
    // rust: );
}
}

// Cross-platform relative names: archive paths must mean the same thing on Windows and Unix.
check_path :: proc(name: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if name.len() > 4096 || name.split('/').count() > 64 {
    // rust: return Err("resource-pack path is too deep or long".into());
}
    // rust: for part in name.split('/') {
    // rust: let stem = part
    // rust: .split('.')
    // rust: .next()
    // rust: .unwrap_or_default()
    // rust: .to_ascii_uppercase();
    // rust: if part.is_empty()
    // rust: || matches!(part, "." | "..")
    // rust: || part.ends_with(['.', ' '])
    // rust: || part
    // rust: .chars()
    // rust: .any(|c| c.is_control() || "\\:*?\"<>|".contains(c))
    // rust: || matches!(stem.as_str(), "CON" | "PRN" | "AUX" | "NUL")
    // rust: || (stem.len() == 4
    // rust: && (stem.starts_with("COM") || stem.starts_with("LPT"))
    // rust: && stem.as_bytes()[3].is_ascii_digit())
    // rust: {
    // rust: return Err(format!("unsafe resource-pack path: {name:?}"));
}
}
    // rust: Ok(())
}

regular :: proc(path: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let meta = fs::symlink_metadata(path).map_err(|e| format!("{}: {e}", path.display()))?;
    // rust: if !meta.is_file() && !meta.is_dir() {
    // rust: return Err(format!(
    // rust: "{}: expected a regular file or directory, not a link",
    // rust: path.display()
    // rust: ));
}
    // rust: Ok(meta)
}

// Creates `path` and its missing parents below `base` (the import's work folder or the player's
// home) as ordinary directories. A link between `base` and `path` is refused: it could send the
// packs out of that folder. Links at or above `base` are the player's own layout and are accepted
// (Fedora Silverblue's `/home` is a link to `/var/home`, macOS's `/var` to `/private/var`).
    // rust: pub(crate) fn directory(base: &Path, path: &Path) -> Result<(), String> {
    // rust: let below = path
    // rust: .strip_prefix(base)
    // rust: .map_err(|_| format!("{}: not inside {}", path.display(), base.display()))?;
    // rust: fs::create_dir_all(base).map_err(|e| format!("{}: {e}", base.display()))?;
    // rust: let real_base = base
    // rust: .canonicalize()
    // rust: .map_err(|e| format!("{}: {e}", base.display()))?;
    // rust: let mut at = base.to_path_buf();
    // rust: for part in below.components() {
    // rust: let std::path::Component::Normal(part) = part else {
    // rust: return Err(format!("{}: not a plain path", path.display()));
}
    // rust: at.push(part);
    // rust: match fs::symlink_metadata(&at) {
    // rust: Ok(m) if m.is_dir() && !m.is_symlink() => {}
    // rust: Ok(_) => return Err(format!("{}: not an ordinary directory", at.display())),
    // rust: Err(e) if e.kind() == std::io::ErrorKind::NotFound => {
    // rust: fs::create_dir(&at).map_err(|e| format!("{}: {e}", at.display()))?
}
    // rust: Err(e) => return Err(format!("{}: {e}", at.display())),
}
}
    // Every step was checked above; the resolved paths say the same, whatever changed meanwhile.
    // rust: let real = path
    // rust: .canonicalize()
    // rust: .map_err(|e| format!("{}: {e}", path.display()))?;
    // rust: if !real.starts_with(&real_base) {
    // rust: return Err(format!("{}: leaves {}", path.display(), base.display()));
}
    // rust: Ok(())
}

    // rust: type Files = BTreeMap<String, Vec<u8>>;

add :: proc(files: ^Files, name: string, reader: impl Read, total: ^u64) -> R {
    // Ported from Horizon
    return {}
}
    // rust: check_path(name)?;
    // rust: if files.contains_key(name) {
    // rust: return Err(format!("duplicate resource-pack entry: {name}"));
}
    // rust: if files.len() >= MAX_FILES {
    // rust: return Err(format!("more than {MAX_FILES} resource-pack files"));
}
    // rust: let bytes = read_limited(reader, MAX_BYTES.saturating_sub(*total))?;
    // rust: *total += bytes.len() as u64;
    // rust: files.insert(name.into(), bytes);
    // rust: Ok(())
}

read_limited :: proc(reader: impl Read, limit: u64) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut bytes = Vec::new();
    // rust: reader
    // rust: .take(limit + 1)
    // rust: .read_to_end(&mut bytes)
    // rust: .map_err(|e| e.to_string())?;
    // rust: if bytes.len() as u64 > limit {
    // rust: return Err("resource packs exceed 512 MiB".into());
}
    // rust: Ok(bytes)
}

validate :: proc(files: ^Files) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if files.len() > MAX_FILES {
    // rust: return Err(format!("more than {MAX_FILES} resource-pack files"));
}
    // rust: let mut names = BTreeMap::new();
    // rust: for path in files.keys() {
    // rust: if names.insert(path.to_lowercase(), path.as_str()).is_some() {
    // rust: return Err(format!("case-conflicting resource-pack path: {path}"));
}
}
    // Keep one key per file rather than every directory prefix of every file.
    // rust: let mut previous: Option<&str> = None;
    // rust: for path in names.values().copied() {
    // rust: let mut prefix = String::new();
    // rust: for part in path.split('/') {
    // rust: if !prefix.is_empty() {
    // rust: prefix.push('/');
}
    // rust: prefix.push_str(part);
    // rust: if prefix != path && names.contains_key(&prefix.to_lowercase()) {
    // rust: return Err(format!("file is also a resource-pack directory: {prefix}"));
}
}
    // rust: if let Some(previous) = previous {
    // rust: for (left, right) in previous.split('/').zip(path.split('/')) {
    // rust: if left.to_lowercase() != right.to_lowercase() {
    // rust: break;
}
    // rust: if left != right {
    // rust: return Err(format!(
    // rust: "case-conflicting resource-pack directories: {previous} and {path}"
    // rust: ));
}
}
}
    // rust: previous = Some(path);
}
    // rust: Ok(())
}

walk :: proc(root: ^Path, relative: string, files: ^Files, total: ^u64) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let path = root.join(relative);
    // rust: let meta = regular(&path)?;
    // rust: if !relative.is_empty() {
    // rust: check_path(relative)?;
}
    // rust: if meta.is_dir() {
    // rust: let mut entries: Vec<_> = fs::read_dir(&path)
    // rust: .map_err(|e| e.to_string())?
    // rust: .collect::<Result<_, _>>()
    // rust: .map_err(|e| e.to_string())?;
    // rust: entries.sort_by_key(|e| e.file_name());
    // rust: for entry in entries {
    // rust: let name = entry
    // rust: .file_name()
    // rust: .into_string()
    // rust: .map_err(|_| "non-UTF-8 resource-pack path")?;
    // rust: let rel = if relative.is_empty() {
    // rust: name
    // rust: } else {
    // rust: format!("{relative}/{name}")
}
    // rust: walk(root, &rel, files, total)?;
}
    // rust: } else {
    // rust: if meta.len() > MAX_BYTES.saturating_sub(*total) {
    // rust: return Err("resource packs exceed 512 MiB".into());
}
    // rust: add(
    // rust: files,
    // rust: relative,
    // rust: fs::File::open(&path).map_err(|e| e.to_string())?,
    // rust: total,
    // rust: )?;
}
    // rust: Ok(())
}

// Each top-level ZIP or directory with pack.mcmeta is one selectable resource pack.
groups :: proc(files: Files) -> B {
    // Ported from Horizon
    return {}
}
    // rust: let mut groups: BTreeMap<String, Files> = BTreeMap::new();
    // rust: for (path, bytes) in files {
    // rust: let top = path.split('/').next().unwrap_or_default().to_owned();
    // rust: groups.entry(top).or_default().insert(path, bytes);
}
    // rust: groups.retain(|name, files| {
    // rust: files.contains_key(&format!("{name}/pack.mcmeta"))
    // rust: || (name.ends_with(".zip") && files.contains_key(name))
    // rust: });
    // rust: groups
}

// Copies one pack into `root`, the `resourcepacks` folder of a work folder or a home.
publish :: proc(root: ^Path, name: string, files: ^Files) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let base = root.parent().ok_or("no resource-pack folder parent")?;
    // rust: directory(base, root)?;
    // rust: let target = root.join(name);
    // rust: for entry in fs::read_dir(root).map_err(|e| e.to_string())? {
    // rust: let entry = entry.map_err(|e| e.to_string())?;
    // rust: let existing = entry.file_name().to_string_lossy().into_owned();
    // rust: if existing != name && existing.to_lowercase() == name.to_lowercase() {
    // rust: return Ok(Outcome {
    // rust: state: State::Conflict,
    // rust: detail: format!("case-conflicting existing pack {existing} preserved"),
    // rust: });
}
}
    // rust: match fs::symlink_metadata(&target) {
    // rust: Ok(_) => {
    // rust: let mut old = Files::new();
    // rust: walk(root, name, &mut old, &mut 0)?;
    // rust: return Ok(Outcome {
    // rust: state: if &old == files {
    // rust: State::Available
    // rust: } else {
    // rust: State::Conflict
    // rust: },
    // rust: detail: if &old == files {
    // rust: "already staged"
    // rust: } else {
    // rust: "existing pack preserved; different incoming content"
}
    // rust: .into(),
    // rust: });
}
    // rust: Err(e) if e.kind() == std::io::ErrorKind::NotFound => {}
    // rust: Err(e) => return Err(e.to_string()),
}
    // rust: let is_directory = !files.contains_key(name);
    // rust: if is_directory {
    // rust: fs::create_dir(&target).map_err(|e| format!("{}: {e}", target.display()))?;
}
    // rust: for (relative, bytes) in files {
    // rust: let dest = root.join(relative);
    // rust: directory(base, dest.parent().ok_or("no resource-pack parent")?)?;
    // rust: let mut file = match fs::OpenOptions::new()
    // rust: .write(true)
    // rust: .create_new(true)
    // rust: .open(&dest)
    // rust: {
    // rust: Ok(file) => file,
    // rust: Err(e) => {
    // rust: if is_directory {
    // rust: let _ = fs::remove_dir_all(&target);
}
    // rust: return Err(format!("{}: {e}", dest.display()));
}
}
    // rust: let result = file.write_all(bytes);
    // rust: if let Err(e) = result {
            // Only this newly created pack is ours; existing packs never enter this branch.
    // rust: if target.is_dir() {
    // rust: let _ = fs::remove_dir_all(&target);
    // rust: } else {
    // rust: let _ = fs::remove_file(&target);
}
    // rust: return Err(format!("{}: {e}", dest.display()));
}
}
    // rust: Ok(Outcome {
    // rust: state: State::Available,
    // rust: detail: "staged; enable in Resource Packs (rendering not checked)".into(),
    // rust: })
}

// zip 2.x silently collapses duplicate names. Count central records before extracting anything.
reject_duplicate_entries :: proc(source: ^Path, zip: ^zip::ZipArchive<fs::File>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut reader = fs::File::open(source).map_err(|e| e.to_string())?;
    // rust: reader
    // rust: .seek(SeekFrom::Start(zip.central_directory_start()))
    // rust: .map_err(|e| e.to_string())?;
    // rust: for _ in 0..zip.len() {
        // ZIP central directory: 46 fixed bytes, then name, extra data and comment.
    // rust: let mut header = [0; 46];
    // rust: reader.read_exact(&mut header).map_err(|e| e.to_string())?;
    // rust: if &header[..4] != b"PK\x01\x02" {
    // rust: return Err("invalid ZIP central directory".into());
}
    // rust: let length: u64 = [28, 30, 32]
    // rust: .into_iter()
    // rust: .map(|i| u64::from(u16::from_le_bytes([header[i], header[i + 1]])))
    // rust: .sum();
    // rust: reader
    // rust: .seek(SeekFrom::Current(length as i64))
    // rust: .map_err(|e| e.to_string())?;
}
    // rust: let mut signature = [0; 4];
    // rust: reader
    // rust: .read_exact(&mut signature)
    // rust: .map_err(|e| e.to_string())?;
    // rust: if &signature == b"PK\x01\x02" {
    // rust: return Err("duplicate ZIP archive entries refused".into());
}
    // rust: Ok(())
}

// Stage embedded packs while the archive/instance is still available. Client overrides win.
stage :: proc(source: ^Path, work: ^Path, pack: ^import::Pack) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut files = Files::new();
    // rust: let mut total = 0;
    // rust: let mut report = Report::load(work);
    // rust: if source.is_dir() {
    // rust: regular(source)?;
    // rust: let game = import::game_dir(source)?;
    // rust: regular(&game)?;
    // rust: let root = game.join("resourcepacks");
    // rust: if fs::symlink_metadata(&root).is_ok() {
    // rust: walk(&root, "", &mut files, &mut total)?;
}
    // rust: if game.join("shaderpacks").exists() {
    // rust: report.set(
    // rust: "shaderpacks/",
    // rust: State::Unsupported,
    // rust: "shader-pack conversion is pending",
    // rust: );
}
    // rust: } else if pack.format == "mrpack" || pack.format == "curseforge" {
    // rust: regular(source)?;
    // rust: let mut zip = zip::ZipArchive::new(fs::File::open(source).map_err(|e| e.to_string())?)
    // rust: .map_err(|e| e.to_string())?;
    // rust: reject_duplicate_entries(source, &zip)?;
    // rust: let roots = if pack.format == "mrpack" {
    // rust: vec!["overrides".to_owned(), "client-overrides".to_owned()]
    // rust: } else {
    // rust: let manifest: serde_json::Value =
    // rust: serde_json::from_reader(zip.by_name("manifest.json").map_err(|e| e.to_string())?)
    // rust: .map_err(|e| e.to_string())?;
    // rust: let root = manifest["overrides"]
    // rust: .as_str()
    // rust: .unwrap_or("overrides")
    // rust: .to_owned();
    // rust: check_path(&root)?;
    // rust: vec![root]
}
    // rust: for root in roots {
    // rust: let prefix = format!("{root}/resourcepacks/");
    // rust: let mut layer = Files::new();
    // rust: for i in 0..zip.len() {
    // rust: let entry = zip.by_index(i).map_err(|e| e.to_string())?;
    // rust: let raw = entry.name().map_err(|e| e.to_string())?.into_owned();
    // rust: if raw.starts_with(&format!("{root}/shaderpacks/")) {
    // rust: report.set(
    // rust: "shaderpacks/",
    // rust: State::Unsupported,
    // rust: "shader-pack conversion is pending",
    // rust: );
}
    // rust: let normalized = raw.replace('\\', "/");
    // rust: let Some(name) = normalized.strip_prefix(&prefix) else {
    // rust: continue;
}
    // rust: check_path(raw.trim_end_matches('/'))?;
    // rust: if entry
    // rust: .unix_mode()
    // rust: .is_some_and(|m| !matches!(m & 0o170000, 0 | 0o100000 | 0o040000))
    // rust: {
    // rust: return Err(format!("{raw}: resource-pack symlink refused"));
}
    // rust: if entry.is_dir() {
    // rust: continue;
}
    // rust: if entry.size() > MAX_BYTES.saturating_sub(total) {
    // rust: return Err("resource packs exceed 512 MiB".into());
}
    // rust: add(&mut layer, name, entry, &mut total)?;
}
            // Only an exact same path from a higher-priority root may replace an entry.
    // rust: for (name, bytes) in layer {
    // rust: files.insert(name, bytes);
}
}
}
    // Catch file/directory and case collisions across override layers before publishing anything.
    // rust: validate(&files)?;
    // rust: for (name, files) in groups(files) {
    // rust: report.files.insert(
    // rust: format!("resourcepacks/{name}"),
    // rust: publish(&work.join("resourcepacks"), &name, &files)?,
    // rust: );
}
    // rust: for file in &pack.files {
    // rust: match file.kind() {
    // rust: "resourcepacks" if file.client == "unsupported" => report.set(
    // rust: &file.path,
    // rust: State::Unsupported,
    // rust: "not supported on the client",
    // rust: ),
    // rust: "resourcepacks" => {
    // rust: report.files.entry(file.path.clone()).or_insert(Outcome {
    // rust: state: State::Missing,
    // rust: detail: "not obtained yet; run port".into(),
    // rust: });
}
    // rust: "shaderpacks" => report.set(
    // rust: &file.path,
    // rust: State::Unsupported,
    // rust: "shader-pack conversion is pending",
    // rust: ),
    // rust: _ => {}
}
}
    // rust: Ok(report)
}

// Obtain index-listed client resource packs with the same host and checksum rules as mod jars.
fetch :: proc(work: ^Path, log: pipeline::Log) -> R {
    // Ported from Horizon
    return {}
}
    // rust: fetch_with(work, log, &|url, hash, dest| {
    // rust: crate::fetch::download(url, Some(hash), dest, false)
    // rust: })
}

    // rust: fn fetch_with(
    // rust: work: &Path,
    // rust: log: pipeline::Log,
    // rust: download: &dyn Fn(&str, &str, &Path) -> Result<(), String>,
    // rust: ) -> Result<Report, String> {
    // rust: let pack: import::Pack = pipeline::read_json(&work.join("pack.json"))?;
    // rust: let cache = crate::modrinth::Cache::load(&work.join("modrinth.json"));
    // rust: let mut report = Report::load(work);
    // rust: for file in &pack.files {
    // rust: if file.kind() != "resourcepacks" {
    // rust: continue;
}
    // rust: let result = (|| {
    // rust: if file.client == "unsupported" {
    // rust: return Ok(Outcome {
    // rust: state: State::Unsupported,
    // rust: detail: "not supported on the client".into(),
    // rust: });
}
    // rust: check_path(&file.path)?;
    // rust: if file.path.split('/').count() != 2 || !file.path.ends_with(".zip") {
    // rust: return Err("indexed resource packs must name resourcepacks/<name>.zip".into());
}
    // rust: let hash = file
    // rust: .sha1
    // rust: .as_deref()
    // rust: .filter(|h| h.len() == 40 && h.bytes().all(|c| c.is_ascii_hexdigit()))
    // rust: .ok_or("resource-pack download has no valid SHA-1")?;
    // rust: let root = work.join("resourcepacks");
    // rust: directory(work, &root)?;
    // rust: let dest = root.join(file.file_name());
    // rust: match fs::symlink_metadata(&dest) {
    // rust: Ok(_) => {
    // rust: if !regular(&dest)?.is_file() {
    // rust: return Err("resource-pack destination is a directory".into());
}
    // rust: let bytes =
    // rust: read_limited(fs::File::open(&dest).map_err(|e| e.to_string())?, MAX_BYTES)?;
    // rust: return Ok(Outcome {
    // rust: state: if import::sha1_hex(&bytes).eq_ignore_ascii_case(hash) {
    // rust: State::Available
    // rust: } else {
    // rust: State::Conflict
    // rust: },
    // rust: detail: "existing resource pack preserved".into(),
    // rust: });
}
    // rust: Err(e) if e.kind() == std::io::ErrorKind::NotFound => {}
    // rust: Err(e) => return Err(e.to_string()),
}
    // rust: let Some(url) = crate::fetch::url_of(file, &cache) else {
    // rust: return Ok(Outcome {
    // rust: state: State::Missing,
    // rust: detail: "no permitted download link in the pack".into(),
    // rust: });
}
    // rust: download(&url, hash, &dest)?;
    // rust: Ok(Outcome {
    // rust: state: State::Available,
    // rust: detail:
    // rust: "downloaded and hash checked; enable in Resource Packs (rendering not checked)"
    // rust: .into(),
    // rust: })
    // rust: })();
    // rust: let outcome = result.unwrap_or_else(|detail| Outcome {
    // rust: state: State::Failed,
    // rust: detail,
    // rust: });
    // rust: log(format!(
    // rust: "{}: {:?}: {}",
    // rust: file.path, outcome.state, outcome.detail
    // rust: ));
    // rust: report.files.insert(file.path.clone(), outcome);
}
    // rust: report.save(work)?;
    // rust: Ok(report)
}

// Ordinary staged packs, also supporting work directories created before resourcepacks.json existed.
available :: proc(work: ^Path) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let root = work.join("resourcepacks");
    // rust: if regular(&root).is_err() {
    // rust: return Vec::new();
}
    // rust: let mut paths: Vec<_> = fs::read_dir(root)
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .flatten()
    // rust: .map(|e| e.path())
    // rust: .filter(|p| {
    // rust: regular(p).is_ok_and(|m| {
    // rust: (m.is_file() && p.extension().is_some_and(|e| e == "zip"))
    // rust: || (m.is_dir() && regular(&p.join("pack.mcmeta")).is_ok_and(|m| m.is_file()))
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: paths.sort();
    // rust: paths
}

// Copy missing whole packs. Never merge into or overwrite an existing profile pack.
install :: proc(work: ^Path, home: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut report = Report::default();
    // rust: let root = work.join("resourcepacks");
    // Indexed packs may exceed the embedded-import total together. Bound memory per pack.
    // rust: for path in available(work) {
    // rust: let name = path
    // rust: .file_name()
    // rust: .and_then(|n| n.to_str())
    // rust: .ok_or("non-UTF-8 resource-pack name")?;
    // rust: let mut files = Files::new();
    // rust: walk(&root, name, &mut files, &mut 0)?;
    // rust: validate(&files)?;
    // rust: report.files.insert(
    // rust: format!("resourcepacks/{name}"),
    // rust: publish(&home.join("resourcepacks"), name, &files)?,
    // rust: );
}
    // rust: Ok(report)
}

    // rust: mod tests;
