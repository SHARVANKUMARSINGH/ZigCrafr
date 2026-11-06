//! Transpiled from Horizon Rust crate
//! Module: horizon-port-pack_fetch
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Step 1b, the jars: for the mods the player asked to port, their own
//! download of each jar into `<work>/jars/`. Only from where the pack itself
//! points (a Modrinth pack's download URLs) or the same file on Modrinth's
//! public CDN (found by its SHA-1), and only kept when the hash matches; or
//! copied from a folder the player already has (an installed instance, a
//! downloads folder). CurseForge's own downloads need an API key, so a file
//! only CurseForge has is listed as needing one. `<work>/fetch.json` says
//! what happened to each file.
// use crate::{
    // rust: import::{Pack, PackFile, sha1_hex},
    // rust: inventory::Record,
    // rust: modrinth::{self, Cache},
    // rust: pipeline::{Log, read_json, write_json},
}
// use serde::{Deserialize, Serialize};
// use serde_json::Value;
// use std::{
    // rust: collections::HashMap,
    // rust: fs,
    // rust: io::{Read, Write},
    // rust: path::{Path, PathBuf},
}

/// Hosts a Modrinth pack may download from (the `.mrpack` format's list).
    // rust: const HOSTS: [&str; 4] = [
    // rust: "https://cdn.modrinth.com/",
    // rust: "https://github.com/",
    // rust: "https://raw.githubusercontent.com/",
    // rust: "https://gitlab.com/",
    // rust: ];
/// No mod jar is this large; a bigger answer is not one.
pub const MAX_JAR: u64 = 512 << 20;

pub const How = enum {
    /// Already in `jars/` (or the imported instance).
    Present,
    /// Downloaded from the pack's URL or Modrinth's CDN, hash checked.
    Downloaded,
    /// Copied from the player's folder.
    Local,
    /// Only on CurseForge, whose downloads are coming soon (its API needs a paid key).
    NeedsKey,
    NotFound,
    Failed,
};

    // rust: impl How {
pub fn label(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: How::Present => "already here",
    // rust: How::Downloaded => "downloaded",
    // rust: How::Local => "copied from your folder",
    // rust: How::NeedsKey => "CurseForge downloads coming soon",
    // rust: How::NotFound => "not found",
    // rust: How::Failed => "failed",
}
}
}

pub const Outcome = struct {
    key: []const u8,
    file: []const u8,
    how: How,
    detail: []const u8,
};

pub const Fetched = struct {
    files: std.ArrayList(Outcome),
};

    // rust: impl Fetched {
pub fn count(self: *Self, how: How) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.files.iter().filter(|o| o.how == how).count()
}
    /// `<work>/fetch.json`, empty when the step has not run.
pub fn load(work: *Path) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: read_json(&work.join("fetch.json")).unwrap_or_default()
}
}

/// A file name from a pack's index that stays inside `jars/`: one plain part, with no separator
/// of any platform, no drive and not `.` or `..`.
pub fn plain_file_name(name: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !name.is_empty() && name != "." && name != ".." && !name.contains(['/', '\\', ':', '\0'])
}

/// The jars of the records `want` picks that the work folder lacks.
    // rust: pub fn fetch(
    // rust: work: &Path,
    // rust: records: &[Record],
    // rust: from: Option<&Path>,
    // rust: want: &dyn Fn(&Record) -> bool,
    // rust: log: Log,
    // rust: ) -> Result<Fetched, String> {
    // rust: let pack: Pack = read_json(&work.join("pack.json"))?;
    // rust: let cache = Cache::load(&work.join("modrinth.json"));
    // rust: let files: HashMap<&str, &PackFile> = pack.files.iter().map(|f| (f.path.as_str(), f)).collect();
    // rust: let jars = work.join("jars");
    // rust: fs::create_dir_all(&jars).map_err(|e| format!("{}: {e}", jars.display()))?;
    // rust: let local = from.map(Local::index);
    // rust: let wanted: Vec<&Record> = records.iter().filter(|r| want(r)).collect();
    // rust: let mut fetched = Fetched::default();
    // rust: for (i, r) in wanted.iter().enumerate() {
    // rust: let Some(file) = files.get(r.path.as_str()) else {
    // rust: continue;
}
    // rust: let name = file.file_name();
    // rust: let outcome = |how, detail: String| Outcome {
    // rust: key: r.key.clone(),
    // rust: file: name.to_owned(),
    // rust: how,
    // rust: detail,
}
    // rust: if !plain_file_name(name) {
            // A name like `..\..\x.dll` or `C:\x` would write outside jars/ on Windows.
    // rust: let o = outcome(How::Failed, format!("{name:?} is not a plain file name"));
    // rust: log(format!("{}: {} ({})", o.key, o.how.label(), o.detail));
    // rust: fetched.files.push(o);
    // rust: continue;
}
    // rust: let dest = jars.join(name);
    // rust: let sha1 = file.sha1.as_deref();
    // rust: let o = if r.jar.is_some() || matches(&dest, sha1) {
    // rust: outcome(How::Present, String::new())
    // rust: } else if let Some(path) = local.as_ref().and_then(|l| l.find(file)) {
    // rust: match fs::copy(&path, &dest) {
    // rust: Ok(_) => outcome(How::Local, path.display().to_string()),
    // rust: Err(e) => outcome(How::Failed, format!("{}: {e}", path.display())),
}
    // rust: } else if let Some(url) = url_of(file, &cache) {
    // rust: log(format!("{}/{} {name}", i + 1, wanted.len()));
    // rust: match download(&url, sha1, &dest, true) {
    // rust: Ok(()) => outcome(How::Downloaded, url),
    // rust: Err(e) => outcome(How::Failed, e),
}
    // rust: } else if pack.format == "curseforge" || file.curseforge.is_some() {
    // rust: outcome(
    // rust: How::NeedsKey,
    // rust: "on CurseForge only: choose your installed instance, or put the jar in jars/"
    // rust: .into(),
    // rust: )
    // rust: } else {
    // rust: outcome(How::NotFound, "no download link in the pack".into())
}
    // rust: if matches!(o.how, How::Failed | How::NeedsKey | How::NotFound) {
    // rust: log(format!("{}: {} ({})", o.key, o.how.label(), o.detail));
}
    // rust: fetched.files.push(o);
}
    // The loader's own data (its convention tags), from its own repository.
    // rust: if let Some((dest, url)) = crate::worldgen::loader_jar(work, &pack.loader, &pack.loader_version)
    // rust: .filter(|(dest, _)| !dest.exists())
    // rust: {
    // rust: let checksum = format!("{url}.sha1");
    // rust: let sha1 = crate::net::agent(&checksum)
    // rust: .get(&checksum)
    // rust: .set("User-Agent", modrinth::AGENT)
    // rust: .call()
    // rust: .ok()
    // rust: .and_then(|r| r.into_string().ok())
    // rust: .map(|s| s.trim().to_owned());
    // rust: let made = dest.parent().map(fs::create_dir_all);
    // rust: match made
    // rust: .unwrap_or(Ok(()))
    // rust: .map_err(|e| e.to_string())
    // rust: .and_then(|()| download(&url, sha1.as_deref(), &dest, true))
    // rust: {
    // rust: Ok(()) => log(format!("loader: {}", dest.display())),
    // rust: Err(e) => log(format!(
    // rust: "loader: {e} (structures keep only vanilla biome tags)"
    // rust: )),
}
}
    // rust: write_json(&work.join("fetch.json"), &fetched)?;
    // rust: log(format!(
    // rust: "jars: {} downloaded, {} copied, {} already here, {} on CurseForge only (CurseForge downloads coming soon), {} not found, {} failed",
    // rust: fetched.count(How::Downloaded),
    // rust: fetched.count(How::Local),
    // rust: fetched.count(How::Present),
    // rust: fetched.count(How::NeedsKey),
    // rust: fetched.count(How::NotFound),
    // rust: fetched.count(How::Failed)
    // rust: ));
    // rust: Ok(fetched)
}

/// Whether `path` holds the file with this SHA-1 (any file when none is known).
pub fn matches(path: *Path, sha1: ?[]const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match (fs::read(path), sha1) {
    // rust: (Ok(bytes), Some(h)) => sha1_hex(&bytes).eq_ignore_ascii_case(h),
    // rust: (Ok(_), None) => true,
    // rust: (Err(_), _) => false,
}
}

/// The pack's own download link, else the same file on Modrinth.
pub fn url_of(file: *PackFile, cache: *Cache) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let allowed = |u: &&str| HOSTS.iter().any(|h| u.starts_with(h));
    // rust: if let Some(u) = file.downloads.iter().map(String::as_str).find(allowed) {
    // rust: return Some(u.to_owned());
}
    // rust: let sha1 = file.sha1.as_deref()?;
    // rust: cache.versions.get(sha1)?["files"]
    // rust: .as_array()?
    // rust: .iter()
    // rust: .find(|f| f["hashes"]["sha1"].as_str() == Some(sha1))?["url"]
    // rust: .as_str()
    // rust: .filter(allowed)
    // rust: .map(str::to_owned)
}

/// Downloads `url` to `dest`, kept only if its SHA-1 is `sha1`.
    // rust: pub(crate) fn download(
    // rust: url: &str,
    // rust: sha1: Option<&str>,
    // rust: dest: &Path,
    // rust: overwrite: bool,
    // rust: ) -> Result<(), String> {
    // rust: let response = crate::net::agent(url)
    // rust: .get(url)
    // rust: .set("User-Agent", modrinth::AGENT)
    // rust: .call()
    // rust: .map_err(|e| format!("{url}: {e}"))?;
    // rust: store_download(response.into_reader(), sha1, dest, overwrite).map_err(|e| format!("{url}: {e}"))
}

/// Read and verify the whole bounded response before publishing it; a failed read leaves no file.
    // rust: pub(crate) fn store_download(
    // rust: reader: impl Read,
    // rust: sha1: Option<&str>,
    // rust: dest: &Path,
    // rust: overwrite: bool,
    // rust: ) -> Result<(), String> {
    // rust: let mut bytes = Vec::new();
    // rust: reader
    // rust: .take(MAX_JAR + 1)
    // rust: .read_to_end(&mut bytes)
    // rust: .map_err(|e| e.to_string())?;
    // rust: if bytes.len() as u64 > MAX_JAR {
    // rust: return Err("download exceeds 512 MiB".into());
}
    // rust: let got = sha1_hex(&bytes);
    // rust: if let Some(want) = sha1.filter(|w| !w.eq_ignore_ascii_case(&got)) {
    // rust: return Err(format!("SHA-1 {got}, the pack says {want}"));
}
pub const NEXT: std::sync::atomic::AtomicUsize = std::sync::atomic::AtomicUsize::new(0);
    // rust: let suffix = NEXT.fetch_add(1, std::sync::atomic::Ordering::Relaxed);
    // rust: let part = dest.with_file_name(format!(
    // rust: ".horizon-download-{}-{suffix}.part",
    // rust: std::process::id()
    // rust: ));
    // rust: let mut file = fs::OpenOptions::new()
    // rust: .write(true)
    // rust: .create_new(true)
    // rust: .open(&part)
    // rust: .map_err(|e| e.to_string())?;
    // rust: let result = file
    // rust: .write_all(&bytes)
    // rust: .map_err(|e| e.to_string())
    // rust: .and_then(|()| {
    // rust: drop(file);
    // rust: if overwrite {
    // rust: fs::rename(&part, dest).map_err(|e| e.to_string())
    // rust: } else {
                // Publish without replacing a file that appeared while the request was in flight.
    // rust: match fs::hard_link(&part, dest) {
    // rust: Ok(()) => fs::remove_file(&part).map_err(|e| e.to_string()),
    // rust: Err(e) if e.kind() == std::io::ErrorKind::AlreadyExists => Err(e.to_string()),
    // rust: Err(_) => {
                        // No hard links here (FAT, some network mounts): copy into a new file.
    // rust: let mut out = fs::OpenOptions::new()
    // rust: .write(true)
    // rust: .create_new(true)
    // rust: .open(dest)
    // rust: .map_err(|e| e.to_string())?;
    // rust: let written = out.write_all(&bytes).map_err(|e| e.to_string());
    // rust: drop(out);
    // rust: if written.is_err() {
    // rust: let _ = fs::remove_file(dest);
}
    // rust: let _ = fs::remove_file(&part);
    // rust: written
}
}
}
    // rust: });
    // rust: if result.is_err() {
    // rust: let _ = fs::remove_file(&part);
}
    // rust: result
}

/// The jars in a folder of the player's, by SHA-1 and by name, and what a
/// CurseForge app instance (`minecraftinstance.json`) says each
/// project's file is called.
pub const Local = struct {
    by_sha1: HashMap<[]const u8,
    by_name: HashMap<[]const u8,
    curseforge: HashMap<(u64,
};

    // rust: impl Local {
pub fn index(dir: *Path) L {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut local = Local::default();
    // rust: local.walk(dir, 3);
    // rust: if let Ok(text) = fs::read_to_string(dir.join("minecraftinstance.json")) {
    // rust: if let Ok(v) = serde_json::from_str::<Value>(&text) {
    // rust: local.curseforge = curseforge_names(&v);
}
}
    // rust: local
}

pub fn walk(self: *Self, dir: *Path, depth: usize) void {
}
    // rust: let Ok(entries) = fs::read_dir(dir) else {
    // rust: return;
}
    // rust: for path in entries.flatten().map(|e| e.path()) {
    // rust: if path.is_dir() {
    // rust: if depth > 0 {
    // rust: self.walk(&path, depth - 1);
}
    // rust: } else if path.extension().is_some_and(|x| x == "jar") {
    // rust: if let Ok(bytes) = fs::read(&path) {
    // rust: self.by_sha1.insert(sha1_hex(&bytes), path.clone());
}
    // rust: if let Some(n) = path.file_name() {
    // rust: self.by_name
    // rust: .insert(n.to_string_lossy().into_owned(), path.clone());
}
}
}
}

pub fn find(self: *Self, file: *PackFile) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(h) = &file.sha1 {
    // rust: return self.by_sha1.get(&h.to_ascii_lowercase()).cloned();
}
    // rust: let name = file
    // rust: .curseforge
    // rust: .and_then(|ids| self.curseforge.get(&ids))
    // rust: .map_or(file.file_name(), String::as_str);
    // rust: self.by_name.get(name).cloned()
}
}

/// `installedAddons[]`: (project, file) → the jar's file name.
pub fn curseforge_names(instance: *Value) H {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: instance["installedAddons"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(|a| {
    // rust: let file = &a["installedFile"];
    // rust: Some((
    // rust: (a["addonID"].as_u64()?, file["id"].as_u64()?),
    // rust: file["fileName"].as_str()?.to_owned(),
    // rust: ))
    // rust: })
    // rust: .collect()
}

    // rust: mod tests {
//     use super::*;
//     use serde_json::json;

pub fn a_pack_index_name_must_stay_inside_jars() void {
}
    // rust: assert!(plain_file_name("sodium-0.6.jar"));
    // rust: for name in ["", ".", "..", "..\\..\\evil.dll", "C:evil.jar", "a/b.jar"] {
    // rust: assert!(!plain_file_name(name), "{name:?}");
}
}

pub fn file(sha1: ?[]const u8, downloads: *[[]const u8]) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: PackFile {
    // rust: path: "mods/a.jar".into(),
    // rust: sha1: sha1.map(str::to_owned),
    // rust: downloads: downloads.iter().map(|d| (*d).to_owned()).collect(),
    // rust: ..PackFile::default()
}
}

pub fn links_come_from_the_pack_or_modrinth_and_only_allowed_hosts() void {
}
    // rust: let mut cache = Cache::default();
    // rust: cache.versions.insert(
    // rust: "ab".into(),
    // rust: json!({"files": [
    // rust: {"hashes": {"sha1": "cd"}, "url": "https://cdn.modrinth.com/other.jar"},
    // rust: {"hashes": {"sha1": "ab"}, "url": "https://cdn.modrinth.com/a.jar"}]}),
    // rust: );
    // rust: let pack_link = file(
    // rust: Some("ab"),
    // rust: &["https://evil.example/a.jar", "https://github.com/a.jar"],
    // rust: );
    // rust: assert_eq!(
    // rust: url_of(&pack_link, &cache).as_deref(),
    // rust: Some("https://github.com/a.jar")
    // rust: );
    // rust: let modrinth = file(Some("ab"), &["https://evil.example/a.jar"]);
    // rust: assert_eq!(
    // rust: url_of(&modrinth, &cache).as_deref(),
    // rust: Some("https://cdn.modrinth.com/a.jar")
    // rust: );
    // rust: assert_eq!(url_of(&file(Some("ef"), &[]), &cache), None);
    // rust: assert_eq!(url_of(&file(None, &[]), &cache), None);
}

pub fn reads_a_curseforge_instance() void {
}
    // rust: let instance = json!({"installedAddons": [
    // rust: {"addonID": 238222, "installedFile": {"id": 5101366, "fileName": "jei-1.21.1.jar"}},
    // rust: {"addonID": 1, "installedFile": {"fileName": "no-id.jar"}}]});
    // rust: let names = curseforge_names(&instance);
    // rust: assert_eq!(names.len(), 1);
    // rust: assert_eq!(names[&(238222, 5101366)], "jei-1.21.1.jar");
}

pub fn copies_the_players_jars_and_lists_what_needs_a_key() void {
}
    // rust: let root = std::env::temp_dir().join(format!("horizon-fetch-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: let (work, mine) = (root.join("work"), root.join("instance/mods"));
    // rust: fs::create_dir_all(&mine).unwrap();
    // rust: fs::create_dir_all(&work).unwrap();
    // rust: fs::write(mine.join("renamed.jar"), b"jar a").unwrap();
    // rust: fs::write(mine.join("cf.jar"), b"jar b").unwrap();
    // rust: fs::write(
    // rust: root.join("instance/minecraftinstance.json"),
    // rust: json!({"installedAddons": [{"addonID": 7, "installedFile": {"id": 8, "fileName": "cf.jar"}}]})
    // rust: .to_string(),
    // rust: )
    // rust: .unwrap();
    // rust: let pack = Pack {
    // rust: format: "curseforge".into(),
    // rust: files: vec![
    // rust: PackFile {
    // rust: path: "mods/a.jar".into(),
    // rust: sha1: Some(sha1_hex(b"jar a")),
    // rust: ..PackFile::default()
    // rust: },
    // rust: PackFile {
    // rust: path: "mods/curseforge-7-8".into(),
    // rust: curseforge: Some((7, 8)),
    // rust: ..PackFile::default()
    // rust: },
    // rust: PackFile {
    // rust: path: "mods/curseforge-9-9".into(),
    // rust: curseforge: Some((9, 9)),
    // rust: ..PackFile::default()
    // rust: },
    // rust: ],
    // rust: ..Pack::default()
}
    // rust: write_json(&work.join("pack.json"), &pack).unwrap();
    // rust: let records: Vec<Record> = pack
    // rust: .files
    // rust: .iter()
    // rust: .map(|f| Record {
    // rust: key: f.file_name().into(),
    // rust: path: f.path.clone(),
    // rust: ..Record::default()
    // rust: })
    // rust: .collect();
    // rust: let fetched = fetch(
    // rust: &work,
    // rust: &records,
    // rust: Some(&root.join("instance")),
    // rust: &|_| true,
    // rust: &|_| {},
    // rust: )
    // rust: .unwrap();
    // rust: let hows: Vec<How> = fetched.files.iter().map(|o| o.how).collect();
    // rust: assert_eq!(hows, [How::Local, How::Local, How::NeedsKey]);
    // rust: assert_eq!(fs::read(work.join("jars/a.jar")).unwrap(), b"jar a");
    // rust: assert_eq!(
    // rust: fs::read(work.join("jars/curseforge-7-8")).unwrap(),
    // rust: b"jar b"
    // rust: );
        // A second run finds them in place.
    // rust: let again = fetch(&work, &records, None, &|_| true, &|_| {}).unwrap();
    // rust: assert_eq!(again.count(How::Present), 2);
    // rust: assert_eq!(Fetched::load(&work).count(How::Present), 2);
    // rust: fs::remove_dir_all(&root).unwrap();
}
}
