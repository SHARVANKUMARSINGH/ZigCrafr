//! Transpiled from Horizon Rust crate
//! Module: horizon-mods_registry
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The registry repository (`horizon-rust/horizon-mods`, docs/api/mod-index.md):
//! one `mods/<id>.toml` per project, written by the submission form or by
//! hand and reviewed in a pull request, plus `revoked.toml`. Its CI turns
//! them into `index.json` with [`build`], reading every listed file, and
//! checks a pull request's changes with [`review`].
//!
//! What an entry can't say for itself (a mod's API, side and capabilities,
//! a modpack's mods, a file's size) is read from the file, never typed.
    // rust: pub use super::open;
// use super::{
    // rust: File, Index, Kind, Project, Revoked, SCHEMA, Version, hex64, inspect, page as rules, valid_id,
}
// use serde::{Deserialize, Serialize};
// use std::path::{Path, PathBuf};

/// The folder of entries in the registry repository.
pub const ENTRIES: []const u8 = "mods";
/// The list of files taken down.
pub const REVOKED: []const u8 = "revoked.toml";
/// Ids the site uses for its own pages (`/mods/submit`).
pub const RESERVED: [[]const u8; 1] = ["submit"];
/// The biggest icon, a PNG in `icons/`.
pub const MAX_ICON: u64 = 256 << 10;

/// `mods/<id>.toml`.
pub const Entry = struct {
    id: []const u8,
    kind: Kind,
    /// The project's GitHub repository, `owner/name`. Its releases are its versions
    /// ([`cache`], `scripts/sync_releases.py` in the registry), and its
    /// [`PAGE_FILE`] may fill the page fields the entry leaves out.
    repo: ?[]const u8,
    // The page fields below may be left out when `repo` is set and the repository's page file
    // has them (the entry's own win, see [`Entry::resolved`]).
    name: []const u8,
    summary: []const u8,
    description: []const u8,
    authors: std.ArrayList([]const u8),
    /// GitHub logins allowed to publish updates.
    owners: std.ArrayList([]const u8),
    /// The owners' numeric GitHub IDs, which decide who they are: GitHub hands a renamed or deleted
    /// account's login to whoever claims it next, while an ID is never reused. The form records the
    /// lister's; the registry's backfill fills in older entries. When it is empty, an update is matched
    /// by login and always waits for a reviewer.
    owner_ids: std.ArrayList(u64),
    license: []const u8,
    /// Defaults to the repository's address.
    source: []const u8,
    /// `icons/<id>.png` in the registry repository, or an `https://` address.
    icon: ?[]const u8,
    /// 1 to 3 of the kind's categories ([`rules::categories`]).
    categories: std.ArrayList([]const u8),
    /// Free-form, lowercase, at most 10.
    tags: std.ArrayList([]const u8),
    /// At most 8, in order: `screenshots/<id>/<name>.png|.jpg` in the registry repository, or
    /// `https://` addresses.
    screenshots: std.ArrayList([]const u8),
    /// The author's minisign public key.
    key: ?[]const u8,
    /// Hosted by the registry itself, newest first: the versions of before releases were read from
    /// the repository (and of Horizon's own mods). Optional.
    versions: std.ArrayList(EntryVersion),
};

/// The page fields a project's repository may hold, in its [`PAGE_FILE`]. Only these: who owns the
/// project, its key and its kind are decided when it is listed.
pub const Page = struct {
    name: ?[]const u8,
    summary: ?[]const u8,
    description: ?[]const u8,
    authors: std.ArrayList([]const u8),
    license: ?[]const u8,
};

/// What the registry keeps of a repository between runs (`versions/<id>.json`, on the registry's
/// `versions` branch): the page last read, and every release version that passed its checks, as
/// the index lists it. Written by `cargo horizon-mod registry release|page`, read by [`build`].
pub const Cache = struct {
    page: Page,
    /// Newest first.
    versions: std.ArrayList(Version),
};

/// The folder of [`Cache`] files, in the registry checkout.
pub const CACHE: []const u8 = "versions";
/// The page file at the root of a project's repository (TOML, [`Page`]'s fields).
pub const PAGE_FILE: []const u8 = "horizon-registry.toml";
/// The longest changelog the index keeps of a release's notes.
pub const MAX_CHANGELOG: usize = 6000;

    // rust: impl Cache {
    /// `<registry>/versions/<id>.json`; empty when there is none.
pub fn read(registry: *Path, id: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let path = registry.join(CACHE).join(format!("{id}.json"));
    // rust: match std::fs::read_to_string(&path) {
    // rust: Ok(text) => serde_json::from_str(&text).map_err(|e| format!("{}: {e}", path.display())),
    // rust: Err(e) if e.kind() == std::io::ErrorKind::NotFound => Ok(Cache::default()),
    // rust: Err(e) => Err(format!("{}: {e}", path.display())),
}
}
}

/// `owner/name` of a GitHub repository.
pub fn valid_repo(repo: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let part = |p: &str, max: usize| {
    // rust: !p.is_empty()
    // rust: && p.len() <= max
    // rust: && p != "."
    // rust: && p != ".."
    // rust: && p.bytes()
    // rust: .all(|b| b.is_ascii_alphanumeric() || matches!(b, b'-' | b'_' | b'.'))
}
    // rust: repo.split_once('/')
    // rust: .is_some_and(|(owner, name)| part(owner, 39) && part(name, 100))
}

    // rust: impl Entry {
    /// The entry with the repository's page filling what it leaves out.
pub fn resolved(self: *Self, page: *Page) E {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut e = self.clone();
    // rust: let fill = |own: &mut String, other: &Option<String>| {
    // rust: if own.trim().is_empty() {
    // rust: *own = other.clone().unwrap_or_default().trim().to_owned();
}
}
    // rust: fill(&mut e.name, &page.name);
    // rust: fill(&mut e.summary, &page.summary);
    // rust: fill(&mut e.description, &page.description);
    // rust: fill(&mut e.license, &page.license);
    // rust: if e.authors.is_empty() {
    // rust: e.authors = page.authors.clone();
}
    // rust: if e.source.is_empty()
    // rust: && let Some(repo) = &self.repo
    // rust: {
    // rust: e.source = format!("https://github.com/{repo}");
}
    // rust: e
}

    /// Everything about the project but its versions, once the page is filled in.
pub fn check_fields(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let id = &self.id;
    // rust: let mut errors = Vec::new();
    // rust: if !valid_id(id) {
    // rust: errors.push(format!("{id:?} is not [a-z0-9_]{{1,64}}"));
}
    // rust: if RESERVED.contains(&id.as_str()) {
    // rust: errors.push(format!("{id:?} is reserved: pick another id"));
}
    // rust: if let Err(e) = open(&self.kind) {
    // rust: errors.push(format!("{id}: {e}"));
}
    // rust: if self.repo.as_deref().is_some_and(|r| !valid_repo(r)) {
    // rust: errors.push(format!("{id}: repo must be owner/name on GitHub"));
}
    // rust: if self.owners.is_empty() {
    // rust: errors.push(format!("{id}: needs at least one owner (a GitHub login)"));
}
        // Once an entry records IDs, only they make an owner: a login added to `owners` alone would
        // silently not be one (and be refused while listed). Both lists name the same accounts.
    // rust: if !self.owner_ids.is_empty() && self.owner_ids.len() != self.owners.len() {
    // rust: errors.push(format!(
    // rust: "{id}: owners lists {} login(s) but owner_ids {} ID(s): give each owner's numeric GitHub \
    // rust: ID in owner_ids, in the same order (`gh api users/<login> --jq .id`)",
    // rust: self.owners.len(),
    // rust: self.owner_ids.len()
    // rust: ));
}
    // rust: for (field, value) in [
    // rust: ("name", &self.name),
    // rust: ("summary", &self.summary),
    // rust: ("license", &self.license),
    // rust: ("source", &self.source),
    // rust: ] {
    // rust: if value.trim().is_empty() {
    // rust: errors.push(format!(
    // rust: "{id}: has no {field} (in the entry, or in {PAGE_FILE} of its repo)"
    // rust: ));
}
}
    // rust: if self.summary.chars().count() > 160 {
    // rust: errors.push(format!("{id}: the summary is over 160 characters"));
}
    // rust: for e in rules::check(&self.kind, &self.description, &self.categories, &self.tags) {
    // rust: errors.push(format!("{id}: {e}"));
}
    // rust: if self.screenshots.len() > rules::MAX_SCREENSHOTS {
    // rust: errors.push(format!(
    // rust: "{id}: {} screenshots, at most {}",
    // rust: self.screenshots.len(),
    // rust: rules::MAX_SCREENSHOTS
    // rust: ));
}
    // rust: errors
}
}

pub const EntryVersion = struct {
    version: []const u8,
    /// `YYYY-MM-DD`.
    published: []const u8,
    /// The Minecraft version it is for.
    game: []const u8,
    /// The name players download, with the kind's extension.
    file: []const u8,
    /// Lowercase hex: pins the reviewed file.
    sha256: []const u8,
    /// The `.minisig` text, when the project has a key.
    signature: ?[]const u8,
    changelog: []const u8,
};

pub const RevokedFile = struct {
    revoked: std.ArrayList(Revoked),
};

/// Where [`build`] reads and what it writes into the index.
pub const Sources = struct {
    /// A checkout of the registry repository.
    registry: *'a Path,
    /// Every listed file, named by its SHA-256 (CI downloads them there).
    files: *'a Path,
    /// Where the files are published: `<files>/<id>-<version>/<file>`
    /// ([`super::FILE_HOST`]; `file:///` for a local test registry).
    release: *'a str,
    /// Where the registry's site is (its icons): `https://.../horizon-mods/`.
    site: *'a str,
    /// RFC 3339.
    generated: []const u8,
};

/// The release tag a version's file is published under.
pub fn tag(id: []const u8, version: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: format!("{id}-{version}")
}

/// Reads `mods/*.toml` and `revoked.toml`: every problem found, not only the
/// first, so a pull request's check lists them all.
pub fn load(registry: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut errors = Vec::new();
    // rust: let mut entries = Vec::new();
    // rust: let dir = registry.join(ENTRIES);
    // rust: let mut paths: Vec<PathBuf> = match std::fs::read_dir(&dir) {
    // rust: Ok(read) => read.filter_map(|e| e.ok().map(|e| e.path())).collect(),
    // rust: Err(e) => return Err(vec![format!("{}: {e}", dir.display())]),
}
    // rust: paths.sort();
    // rust: for path in paths {
    // rust: let name = path.file_name().and_then(|n| n.to_str()).unwrap_or("");
    // rust: let Some(stem) = name.strip_suffix(".toml") else {
    // rust: errors.push(format!("{ENTRIES}/{name}: only <id>.toml files go here"));
    // rust: continue;
}
    // rust: let parsed = std::fs::read_to_string(&path)
    // rust: .map_err(|e| e.to_string())
    // rust: .and_then(|text| toml::from_str::<Entry>(&text).map_err(|e| e.to_string()));
    // rust: match parsed {
    // rust: Ok(entry) if entry.id == stem => entries.push(entry),
    // rust: Ok(entry) => errors.push(format!(
    // rust: "{ENTRIES}/{name}: its id is {:?}; the file must be {ENTRIES}/{}.toml",
    // rust: entry.id, entry.id
    // rust: )),
    // rust: Err(e) => errors.push(format!("{ENTRIES}/{name}: {e}")),
}
}
    // rust: let revoked = match std::fs::read_to_string(registry.join(REVOKED)) {
    // rust: Ok(text) => match toml::from_str::<RevokedFile>(&text) {
    // rust: Ok(file) => file.revoked,
    // rust: Err(e) => {
    // rust: errors.push(format!("{REVOKED}: {e}"));
    // rust: Vec::new()
}
    // rust: },
    // rust: Err(e) if e.kind() == std::io::ErrorKind::NotFound => Vec::new(),
    // rust: Err(e) => {
    // rust: errors.push(format!("{REVOKED}: {e}"));
    // rust: Vec::new()
}
}
    // rust: if errors.is_empty() {
    // rust: Ok((entries, revoked))
    // rust: } else {
    // rust: Err(errors)
}
}

/// A version string that is also a plain release tag and file name part.
pub fn plain_version(v: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !v.is_empty()
    // rust: && v.len() <= 64
    // rust: && v.as_bytes()[0].is_ascii_alphanumeric()
    // rust: && v.bytes()
    // rust: .all(|b| b.is_ascii_alphanumeric() || b".-_".contains(&b))
}

pub fn plain_date(d: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let b = d.as_bytes();
    // rust: b.len() == 10
    // rust: && b[4] == b'-'
    // rust: && b[7] == b'-'
    // rust: && b.iter()
    // rust: .enumerate()
    // rust: .all(|(i, c)| i == 4 || i == 7 || c.is_ascii_digit())
}

/// Whether the index lists the project: a project listed by its repository waits for its first
/// release version before it appears.
pub fn listed(entry: *Entry, src: *Sources) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let cached = entry.repo.is_some()
    // rust: && Cache::read(src.registry, &entry.id).is_ok_and(|c| !c.versions.is_empty());
    // rust: !entry.versions.is_empty() || cached || entry.repo.is_none()
}

/// One project's entry and its files, as the index lists them.
pub fn project(entry: *Entry, src: *Sources) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let cache = match &entry.repo {
    // rust: Some(_) => Cache::read(src.registry, &entry.id).map_err(|e| vec![e])?,
    // rust: None => Cache::default(),
}
    // rust: let entry = &entry.resolved(&cache.page);
    // rust: let mut errors = entry.check_fields();
    // rust: let id = &entry.id;
    // rust: if !valid_id(id) || RESERVED.contains(&id.as_str()) {
    // rust: return Err(errors);
}
    // rust: let icon = entry
    // rust: .icon
    // rust: .as_deref()
    // rust: .and_then(|icon| image(src, id, icon, "icons/", &mut errors));
    // rust: let screenshots: Vec<String> = entry
    // rust: .screenshots
    // rust: .iter()
    // rust: .filter_map(|s| image(src, id, s, &format!("screenshots/{id}/"), &mut errors))
    // rust: .collect();
    // rust: if entry.versions.is_empty() && cache.versions.is_empty() {
    // rust: errors.push(format!("{id}: has no version"));
}
    // rust: let mut versions = Vec::new();
    // rust: for v in &entry.versions {
    // rust: match version(entry, v, src) {
            // A mod that turned native keeps its `.hmod` versions published, but the index offers
            // only its native ones: a launcher never installs a content-only `.hmod` as a native mod.
    // rust: Ok(_) if file_kind(entry, v, &src.files.join(&v.sha256)) != entry.kind => {}
    // rust: Ok(v) => versions.push(v),
    // rust: Err(e) => errors.push(format!("{id} {}: {e}", v.version)),
}
}
    // The versions read from the repository's releases passed their checks when they were read.
    // Newest first, the registry's own before them on a tie.
    // rust: versions.extend(cache.versions);
    // rust: versions.sort_by(|a: &Version, b| b.published.cmp(&a.published));
    // rust: if !errors.is_empty() {
    // rust: return Err(errors);
}
    // rust: Ok(Project {
    // rust: id: id.clone(),
    // rust: kind: entry.kind.clone(),
    // rust: name: entry.name.clone(),
    // rust: summary: entry.summary.clone(),
    // rust: description: entry.description.clone(),
    // rust: authors: entry.authors.clone(),
    // rust: owners: entry.owners.clone(),
    // rust: license: entry.license.clone(),
    // rust: source: entry.source.clone(),
    // rust: icon,
    // rust: categories: entry.categories.clone(),
    // rust: tags: entry.tags.clone(),
    // rust: screenshots,
    // rust: key: entry.key.as_ref().map(|k| k.trim().to_owned()),
    // rust: versions,
    // rust: downloads: 0,
    // rust: stars: 0,
    // rust: })
}

/// An icon (`folder` = `icons/`) or a screenshot (`screenshots/<id>/`) as the index lists it: an
/// `https://` address as it is, or a file in the registry repository checked and served from the
/// registry's site.
    // rust: fn image(
    // rust: src: &Sources,
    // rust: id: &str,
    // rust: path: &str,
    // rust: folder: &str,
    // rust: errors: &mut Vec<String>,
    // rust: ) -> Option<String> {
    // rust: if path.starts_with("https://") {
    // rust: return Some(path.to_owned());
}
    // rust: let icon = folder == "icons/";
    // rust: let name = path.strip_prefix(folder).filter(|n| super::plain_name(n));
    // rust: let Some(name) = name else {
    // rust: errors.push(format!(
    // rust: "{id}: {path:?} is neither {folder}<name> nor https://"
    // rust: ));
    // rust: return None;
}
    // rust: let max = if icon {
    // rust: MAX_ICON
    // rust: } else {
    // rust: rules::MAX_SCREENSHOT
}
    // rust: let checked = std::fs::metadata(src.registry.join(path))
    // rust: .map_err(|e| format!("{path}: {e}"))
    // rust: .and_then(|m| {
    // rust: if m.len() > max {
    // rust: return Err(format!("{path} is over {} KiB", max >> 10));
}
    // rust: let bytes =
    // rust: std::fs::read(src.registry.join(path)).map_err(|e| format!("{path}: {e}"))?;
    // rust: if icon {
    // rust: rules::check_icon(&bytes).map_err(|e| format!("{path}: {e}"))
    // rust: } else {
    // rust: rules::check_screenshot(name, &bytes)
}
    // rust: });
    // rust: match checked {
    // rust: Ok(()) => Some(format!("{}{path}", src.site)),
    // rust: Err(e) => {
    // rust: errors.push(format!("{id}: {e}"));
    // rust: None
}
}
}

/// The kind of a version's file at `path`: the project's, but a `.hmod` without native code of a
/// mod that turned native (`review`) is from before it did.
pub fn file_kind(entry: *Entry, v: *EntryVersion, path: *Path) K {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match entry.kind {
    // rust: Kind::NativeMod if v.file.ends_with(".hmod") && !super::native::holds(path) => Kind::Mod,
    // rust: _ => entry.kind.clone(),
}
}

pub fn version(entry: *Entry, v: *EntryVersion, src: *Sources) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: hex64(&v.sha256)?;
    // rust: let url = format!("{}{}/{}", src.release, tag(&entry.id, &v.version), v.file);
    // rust: version_at(entry, v, &src.files.join(&v.sha256), url)
}

/// A version of `entry` whose file is at `path` and is downloaded from `url`.
    // rust: fn version_at(
    // rust: entry: &Entry,
    // rust: v: &EntryVersion,
    // rust: path: &Path,
    // rust: url: String,
    // rust: ) -> Result<Version, String> {
    // rust: if !plain_version(&v.version) {
    // rust: return Err("a version is letters, digits, '.', '-' and '_'".into());
}
    // rust: if !plain_date(&v.published) {
    // rust: return Err(format!("published {:?} is not YYYY-MM-DD", v.published));
}
    // rust: hex64(&v.sha256)?;
    // rust: let size = std::fs::metadata(path)
    // rust: .map_err(|e| format!("its file {}: {e}", v.sha256))?
    // rust: .len();
    // rust: if super::sha256_file(path)? != v.sha256 {
    // rust: return Err("the file isn't the one its sha256 names".into());
}
    // rust: match (&entry.key, &v.signature) {
    // rust: (Some(key), Some(sig)) => super::verify_signature(key, sig, path)?,
    // rust: (Some(_), None) => return Err("the project has a key: sign the file with it".into()),
    // rust: (None, Some(_)) => return Err("signed, but the project has no key".into()),
    // rust: (None, None) => {}
}
    // rust: let facts = inspect(&file_kind(entry, v, path), path)?;
    // rust: if facts.id.as_ref().is_some_and(|id| *id != entry.id) {
    // rust: return Err(format!(
    // rust: "the file's id is {:?}, not {:?}",
    // rust: facts.id.unwrap_or_default(),
    // rust: entry.id
    // rust: ));
}
    // rust: if facts.version.as_ref().is_some_and(|x| *x != v.version) {
    // rust: return Err(format!(
    // rust: "the file says version {:?}",
    // rust: facts.version.unwrap_or_default()
    // rust: ));
}
    // rust: if facts.game.as_ref().is_some_and(|g| *g != v.game) {
    // rust: return Err(format!(
    // rust: "the file is for {:?}, the entry says {:?}",
    // rust: facts.game.unwrap_or_default(),
    // rust: v.game
    // rust: ));
}
    // rust: Ok(Version {
    // rust: version: v.version.clone(),
    // rust: published: v.published.clone(),
    // rust: changelog: v.changelog.clone(),
    // rust: api: facts.api,
    // rust: side: facts.side,
    // rust: capabilities: facts.capabilities,
    // rust: api_level: facts.api_level,
    // rust: hooks: facts.hooks,
    // rust: game: v.game.clone(),
    // rust: broken_on: Vec::new(),
    // rust: requires: facts.requires,
    // rust: file: File {
    // rust: url,
    // rust: name: v.file.clone(),
    // rust: size,
    // rust: sha256: v.sha256.clone(),
    // rust: signature: v.signature.clone(),
    // rust: },
    // rust: })
}

/// A release of a project's repository whose asset was downloaded.
pub const Release = struct {
    /// The release's tag: the version when the file does not say one.
    tag: *'a str,
    /// `YYYY-MM-DD`, the release's date.
    published: *'a str,
    /// The release notes.
    notes: *'a str,
    /// The asset's name.
    asset: *'a str,
    /// The Minecraft version, when the file names none.
    game: *'a str,
    /// The asset's `.minisig` text.
    signature: ?*'a str,
};

/// The version a release of `entry`'s repository is, once its asset at `path` passed the kind's
/// checks: the file's own manifest decides id, version and game (the tag and the default game fill
/// what it leaves out), the index lists the asset's address in the repository, and the SHA-256 is
/// computed here, never read from the release.
pub fn release_version(entry: *Entry, r: *Release, path: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let repo = entry
    // rust: .repo
    // rust: .as_deref()
    // rust: .filter(|r| valid_repo(r))
    // rust: .ok_or("the entry names no GitHub repository")?;
    // rust: let plain = |s: &str| {
    // rust: !s.is_empty()
    // rust: && s.bytes()
    // rust: .all(|b| b.is_ascii_alphanumeric() || matches!(b, b'-' | b'_' | b'.' | b'+'))
}
    // rust: if !plain(r.tag) || !super::plain_name(r.asset) {
    // rust: return Err(format!(
    // rust: "tag {:?} or file {:?} has characters the launcher cannot download: use letters, digits, '.', '-', '_' and '+'",
    // rust: r.tag, r.asset
    // rust: ));
}
    // rust: let want = entry.kind.extension();
    // rust: if want.is_some_and(|e| !r.asset.ends_with(&format!(".{e}"))) {
    // rust: return Err(format!(
    // rust: "{:?} is not a .{} file",
    // rust: r.asset,
    // rust: want.unwrap_or("")
    // rust: ));
}
    // rust: let facts = inspect(&entry.kind, path)?;
    // rust: let version = facts
    // rust: .version
    // rust: .clone()
    // rust: .unwrap_or_else(|| r.tag.trim_start_matches(['v', 'V']).to_owned());
    // rust: let mut notes: String = r.notes.trim().chars().take(MAX_CHANGELOG).collect();
    // rust: if r.notes.trim().chars().count() > MAX_CHANGELOG {
    // rust: notes.push_str("\n\n(Cut: the full notes are on the release.)");
}
    // rust: let v = EntryVersion {
    // rust: game: facts.game.clone().unwrap_or_else(|| r.game.to_owned()),
    // rust: file: r.asset.to_owned(),
    // rust: sha256: super::sha256_file(path)?,
    // rust: signature: r
    // rust: .signature
    // rust: .map(str::to_owned)
    // rust: .filter(|s| !s.trim().is_empty()),
    // rust: changelog: notes,
    // rust: published: r.published.to_owned(),
    // rust: version,
}
    // rust: let url = format!(
    // rust: "https://github.com/{repo}/releases/download/{}/{}",
    // rust: r.tag, r.asset
    // rust: );
    // rust: version_at(entry, &v, path, url)
}

/// A project's page file as it would fill `entry` (which names the repository): refused when it
/// has keys other than [`Page`]'s, or leaves the page incomplete.
pub fn page(entry: *Entry, text: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let page: Page = toml::from_str(text).map_err(|e| format!("{PAGE_FILE}: {e}"))?;
    // rust: let errors = entry.resolved(&page).check_fields();
    // rust: if errors.is_empty() {
    // rust: Ok(page)
    // rust: } else {
    // rust: Err(errors.join("; "))
}
}

    // rust: impl Entry {
    /// The entry as `mods/<id>.toml` holds it (the submission form writes it).
pub fn to_toml(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: toml::to_string(self).map_err(|e| e.to_string())
}
}

/// The index of the whole registry: every entry and file checked, then the
/// index's own rules ([`Index::check`]: names, a modpack's mods present).
pub fn build(src: *Sources) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (mut entries, revoked) = load(src.registry)?;
    // rust: entries.sort_by(|a, b| a.id.cmp(&b.id));
    // rust: let mut errors = Vec::new();
    // rust: let mut projects = Vec::new();
    // rust: for entry in entries.iter().filter(|e| listed(e, src)) {
        // A listed project's page is complete (registry v2's rollout, step 4).
    // rust: let page = match &entry.repo {
    // rust: Some(_) => Cache::read(src.registry, &entry.id)
    // rust: .map(|c| c.page)
    // rust: .unwrap_or_default(),
    // rust: None => Page::default(),
}
    // rust: let e = entry.resolved(&page);
    // rust: errors.extend(
    // rust: rules::check_required(
    // rust: &e.id,
    // rust: &e.description,
    // rust: &e.categories,
    // rust: e.icon.as_deref(),
    // rust: &e.screenshots,
    // rust: )
    // rust: .into_iter()
    // rust: .map(|problem| format!("{}: {problem}", e.id)),
    // rust: );
    // rust: match project(entry, src) {
    // rust: Ok(p) => projects.push(p),
    // rust: Err(e) => errors.extend(e),
}
}
    // rust: if !errors.is_empty() {
    // rust: return Err(errors);
}
    // rust: let index = Index {
    // rust: schema: SCHEMA,
    // rust: generated: src.generated.clone(),
    // rust: projects,
    // rust: revoked,
}
    // rust: let local = src.release.starts_with("file:///");
    // rust: index.check_with(local).map_err(|e| vec![e])?;
    // rust: Ok(index)
}

/// What a pull request changes, for its reviewers.
pub const Review = struct {
    /// Changes the registry refuses whoever reviews them.
    errors: std.ArrayList([]const u8),
    /// What reviewers should look at: new projects, new owners or keys, a
    /// change by someone who isn't an owner.
    notes: std.ArrayList([]const u8),
};

/// Compares the entries of a pull request (`head`) with `main`'s (`base`):
/// a published file never changes and is never removed (take it down in
/// `revoked.toml`), a project's kind never changes but for a mod turning
/// native (its next versions carry native code), and changes by someone who
/// isn't an owner, or to owners and keys, are pointed out.
pub fn review(base: *[Entry], head: *[Entry], author: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut r = Review::default();
    // rust: for old in base {
    // rust: let Some(new) = head.iter().find(|e| e.id == old.id) else {
    // rust: r.errors.push(format!(
    // rust: "{}: removed; take its files down in {REVOKED} instead",
    // rust: old.id
    // rust: ));
    // rust: continue;
}
    // rust: if new == old {
    // rust: continue;
}
    // rust: if !old.owners.iter().any(|o| o.eq_ignore_ascii_case(author)) {
    // rust: r.notes.push(format!(
    // rust: "{}: changed by {author}, who isn't one of its owners ({})",
    // rust: old.id,
    // rust: old.owners.join(", ")
    // rust: ));
}
    // rust: if (&old.kind, &new.kind) == (&Kind::Mod, &Kind::NativeMod) {
    // rust: r.notes.push(format!(
    // rust: "{}: turns native; its content-only .hmod versions stay published, and launchers keep the installed copies",
    // rust: old.id
    // rust: ));
    // rust: } else if new.kind != old.kind {
    // rust: r.errors.push(format!("{}: its kind can't change", old.id));
}
    // rust: for v in &old.versions {
    // rust: match new.versions.iter().find(|w| w.version == v.version) {
    // rust: None => r.errors.push(format!(
    // rust: "{} {}: removed; take it down in {REVOKED} instead",
    // rust: old.id, v.version
    // rust: )),
    // rust: Some(w) if w.sha256 != v.sha256 || w.file != v.file => r.errors.push(format!(
    // rust: "{} {}: a published file never changes: publish a new version",
    // rust: old.id, v.version
    // rust: )),
    // rust: Some(_) => {}
}
}
    // rust: if new.repo != old.repo {
    // rust: r.notes.push(format!(
    // rust: "{}: its repository {} -> {}: new releases will come from the second; versions already read stay",
    // rust: old.id,
    // rust: old.repo.as_deref().unwrap_or("(none)"),
    // rust: new.repo.as_deref().unwrap_or("(none)")
    // rust: ));
}
    // rust: if new.owners != old.owners {
    // rust: r.notes.push(format!(
    // rust: "{}: owners {} -> {}",
    // rust: old.id,
    // rust: old.owners.join(", "),
    // rust: new.owners.join(", ")
    // rust: ));
}
    // rust: if new.owner_ids != old.owner_ids {
    // rust: let ids = |ids: &[u64]| match ids {
    // rust: [] => "(none)".to_owned(),
    // rust: ids => ids
    // rust: .iter()
    // rust: .map(u64::to_string)
    // rust: .collect::<Vec<_>>()
    // rust: .join(", "),
}
    // rust: r.notes.push(format!(
    // rust: "{}: owner IDs {} -> {}: check each is the account its login names",
    // rust: old.id,
    // rust: ids(&old.owner_ids),
    // rust: ids(&new.owner_ids)
    // rust: ));
}
    // rust: if new.key != old.key {
    // rust: r.notes.push(format!(
    // rust: "{}: its signing key changes; updates signed with the old one stop working",
    // rust: old.id
    // rust: ));
}
    // rust: let added = new.versions.len().saturating_sub(old.versions.len());
    // rust: if added > 0 {
    // rust: r.notes.push(format!("{}: {added} new version(s)", old.id));
}
}
    // rust: for new in head {
        // Every version is a submission, checked and reviewed: the registry no longer follows a
        // repository's releases (entries from before keep theirs until they are pinned).
    // rust: if new.repo.is_some() && base.iter().all(|e| e.id != new.id || e.repo.is_none()) {
    // rust: r.errors.push(format!(
    // rust: "{}: the registry doesn't follow repositories any more: list each version's file (the form, or [[versions]])",
    // rust: new.id
    // rust: ));
}
    // rust: if !base.iter().any(|e| e.id == new.id) {
    // rust: r.notes.push(format!(
    // rust: "{}: a new {} by {}{}",
    // rust: new.id,
    // rust: new.kind.name(),
    // rust: new.owners.join(", "),
    // rust: new.repo.as_deref().map_or(String::new(), |repo| format!(
    // rust: "; its releases come from https://github.com/{repo} with no further review: check the repository is the author\'s and read its source"
    // rust: ))
    // rust: ));
}
}
    // rust: r
}

    // rust: mod tests;
