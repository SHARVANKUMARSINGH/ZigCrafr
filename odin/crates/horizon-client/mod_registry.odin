//! Transpiled from Horizon Rust crate
package horizon_client_mod_registry

import "core:fmt"
import "core:mem"
import "core:math"

// Horizon's mod registry from inside the game (Options > Mods > Browse mods,
// docs/design/mod-hotload.md): the same `index.json` the launcher reads, the
// projects this game can install, and installing one exactly as the launcher
// does (`launcher/src/browser/horizon.rs`, `install_version`): downloaded into
// `mod-browser/downloads/`, checked against the index (size, SHA-256, the
// author's signature, the file's own manifest), moved into `horizon-mods/`
// and recorded in `mod-browser.json`, so the launcher lists, updates and
// removes it as one of its own.
//
// The launcher is a separate workspace, so this is the small part of it the
// game needs. Everything here blocks: the game runs it on a worker
// (`game/mod_browser.rs`).
// use crate::mod_browser::Listing;
// use horizon_mods::index::{self, Index, Kind, Project, Trust, Version};
// use std::fs;
// use std::io::Read;
// use std::path::{Path, PathBuf};

// Where the registry publishes its index (the launcher's `INDEX_URL`).
INDEX_URL :: "https://horizon-rust.github.io/horizon-mods/index.json"
// The Minecraft version this game is: the registry's `game`.
GAME :: horizon_core::version::VERSION_ID
// The registry's pages on the website, `<SITE>/<id>`.
SITE :: "https://playhorizon.dev/mods"
// The last index fetched, beside `options.txt`: the launcher keeps its own copy there too.
CACHE :: "mod-browser/horizon-index.json"
// What the launcher's browser installed (`installed::MANIFEST`).
MANIFEST :: "mod-browser.json"
// Where a download waits for its checks.
DOWNLOADS :: "mod-browser/downloads"
// Larger than any index should be.
MAX_INDEX :: 16 << 20
// The game asks the registry by this name.
    // rust: const AGENT: &str = concat!(
    // rust: "horizon-rust/horizon/",
    // rust: env!("CARGO_PKG_VERSION"),
    // rust: " (in-game mod browser)"
    // rust: );

// Where the index comes from: `HORIZON_MOD_INDEX` (a file or an `https://`
// address, for a test registry), else [`INDEX_URL`]; as the launcher reads it.
location :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: std::env::var("HORIZON_MOD_INDEX")
    // rust: .ok()
    // rust: .filter(|v| !v.is_empty())
    // rust: .unwrap_or_else(|| INDEX_URL.to_owned())
}

// A local test registry: its files may be `file://` paths.
is_local :: proc(at: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !at.starts_with("https://")
}

// The index from `at`, kept in `home`'s [`CACHE`]; the kept copy when the
// registry can't be reached.
load_index :: proc(home: ^Path, at: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let local = is_local(at);
    // rust: let parse = |text: &str| match local {
    // rust: true => Index::parse_local(text),
    // rust: false => Index::parse(text),
}
    // rust: let fetched = fetch_text(at).and_then(|text| parse(&text).map(|index| (index, text)));
    // rust: let cache = home.join(CACHE);
    // rust: match fetched {
    // rust: Ok((index, text)) => {
    // rust: if let Some(dir) = cache.parent() {
    // rust: let _ = fs::create_dir_all(dir);
}
    // rust: let _ = fs::write(&cache, text);
    // rust: Ok(index)
}
    // rust: Err(e) => {
    // rust: let kept = fs::read_to_string(&cache).map_err(|_| e.clone())?;
    // rust: parse(&kept).map_err(|_| e)
}
}
}

fetch_text :: proc(at: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if !at.starts_with("https://") {
    // rust: return fs::read_to_string(at).map_err(|e| format!("{at}: {e}"));
}
    // rust: let response = ureq::get(at)
    // rust: .set("User-Agent", AGENT)
    // rust: .call()
    // rust: .map_err(|e| match e {
    // rust: ureq::Error::Status(code, _) => format!("the mod registry answered {code}"),
    // rust: ureq::Error::Transport(t) => format!("the mod registry can't be reached: {t}"),
    // rust: })?;
    // rust: let mut text = String::new();
    // rust: response
    // rust: .into_reader()
    // rust: .take(MAX_INDEX)
    // rust: .read_to_string(&mut text)
    // rust: .map_err(|e| e.to_string())?;
    // rust: Ok(text)
}

// Whether version `v` is a `.hmod` with code: the game doesn't run those any
// more, and the launcher neither lists nor installs them (`needs_port`).
needs_port :: proc(v: ^Version) -> b {
    // Ported from Horizon
    return {}
}
    // rust: v.file.name.ends_with(".hmod")
    // rust: && v.capabilities
    // rust: .iter()
    // rust: .any(|c| *c != horizon_mods::Capability::Registries)
}

// The version of content mod `p` this game installs: the newest for this
// Minecraft version that wasn't taken down and has no code.
    // rust: pub fn installable<'a>(index: &Index, p: &'a Project) -> Option<&'a Version> {
    // rust: if p.kind != Kind::Mod {
    // rust: return None;
}
    // rust: index
    // rust: .installable(p, GAME, horizon_mods::api_level::LEVEL)
    // rust: .filter(|v| !needs_port(v))
}

// The registry's projects the browser offers, most downloaded first: content
// mods this game installs, with the version installed in `home` when there is
// one.
listings :: proc(index: ^Index, home: ^Path) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let installed = Installed::load(home);
    // rust: let mut out: Vec<Listing> = index
    // rust: .projects
    // rust: .iter()
    // rust: .filter_map(|p| {
    // rust: let v = installable(index, p)?;
    // rust: Some(Listing {
    // rust: id: p.id.clone(),
    // rust: name: p.name.clone(),
    // rust: summary: p.summary.clone(),
    // rust: description: p.description.clone(),
    // rust: authors: p.authors.clone(),
    // rust: license: p.license.clone(),
    // rust: categories: p.categories.clone(),
    // rust: tags: p.tags.clone(),
    // rust: version: v.version.clone(),
    // rust: published: v.published.clone(),
    // rust: changelog: v.changelog.clone(),
    // rust: downloads: p.downloads,
    // rust: page: format!("{SITE}/{}", p.id),
    // rust: installed: installed.version_of(home, &p.id),
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: out.sort_by(|a, b| b.downloads.cmp(&a.downloads).then(a.name.cmp(&b.name)));
    // rust: out
}

// What [`install`] did.
Done :: struct {
    id: string,
    version: string,
    // Checked against the author's key, or unsigned (the SHA-256 still pins
    // the reviewed file).
    verified: bool,
}

// Installs the newest installable version of the registry's content mod `id`
// into the game folder `home`, as the launcher does: `horizon-mods/<id>.hmod`,
// recorded in `mod-browser.json`. Turning it on is the caller's
// (`horizon-mods.txt` belongs to the game's settings). `get` downloads a file
// of at most `max` bytes (the network, or a test's files).
    // rust: pub fn install(
    // rust: index: &Index,
    // rust: home: &Path,
    // rust: id: &str,
    // rust: get: &dyn Fn(&str, u64) -> Result<Vec<u8>, String>,
    // rust: ) -> Result<Done, String> {
    // rust: let p = index
    // rust: .project(id)
    // rust: .ok_or_else(|| format!("{id} isn't in Horizon's registry"))?;
    // rust: let v = installable(index, p)
    // rust: .ok_or_else(|| format!("{} has no version this game can install", p.name))?;
    // rust: let relative = format!("{}/{id}.hmod", crate::mod_list::DIR);
    // rust: let target = home.join(&relative);
    // rust: let mut list = Installed::load(home);
    // rust: let ours = list.position(id);
    // rust: let old_file = ours.and_then(|i| list.entries[i]["file"].as_str().map(str::to_owned));
    // rust: if let Some(i) = ours
    // rust: && list.entries[i]["version"].as_str() == Some(v.version.as_str())
    // rust: && target.exists()
    // rust: {
    // rust: return Ok(Done {
    // rust: id: id.to_owned(),
    // rust: version: v.version.clone(),
    // rust: verified: list.entries[i]["verdict"].as_str() == Some("Verified"),
    // rust: });
}
    // Never over a mod the player put there themselves.
    // rust: let theirs = target.exists() && old_file.as_deref() != Some(relative.as_str());
    // rust: if theirs || home.join(crate::mod_list::DIR).join(id).is_dir() {
    // rust: return Err(format!(
    // rust: "a mod with the id {id} is already in {}: move it away first",
    // rust: crate::mod_list::DIR
    // rust: ));
}
    // rust: if let Some(other) = list.taken_by(&relative, id) {
    // rust: return Err(format!("{relative} belongs to {other}: remove it first"));
}
    // rust: let bytes = get(&v.file.url, v.file.size)?;
    // rust: let staging = home.join(DOWNLOADS);
    // rust: fs::create_dir_all(&staging).map_err(|e| format!("{}: {e}", staging.display()))?;
    // rust: let download = staging.join(format!("{id}.hmod.part"));
    // rust: fs::write(&download, &bytes).map_err(|e| format!("{}: {e}", download.display()))?;
    // rust: let trust = index::check_file(index, p, v, &download).inspect_err(|_| {
    // rust: let _ = fs::remove_file(&download);
    // rust: })?;
    // rust: if let Some(dir) = target.parent() {
    // rust: fs::create_dir_all(dir).map_err(|e| format!("{}: {e}", dir.display()))?;
}
    // rust: fs::rename(&download, &target).map_err(|e| format!("{}: {e}", target.display()))?;
    // rust: let verified = trust == Trust::Verified;
    // rust: list.record(serde_json::json!({
    // rust: "source": "horizon",
    // rust: "project": p.id,
    // rust: "slug": p.id,
    // rust: "title": p.name,
    // rust: "kind": "mod",
    // rust: "version": v.version,
    // rust: "number": v.version,
    // rust: "file": relative,
    // rust: "checksum": format!("SHA-256:{}", v.file.sha256),
    // rust: "page": format!("{SITE}/{}", p.id),
    // rust: "dependency": false,
    // rust: "verdict": if verified { "Verified" } else { "Unsigned" },
    // rust: }));
    // rust: list.save(home)?;
    // rust: Ok(Done {
    // rust: id: id.to_owned(),
    // rust: version: v.version.clone(),
    // rust: verified,
    // rust: })
}

// Downloads `url` (at most `max` bytes): `https://` only, or a `file://` path
// when the index itself is a local test registry.
download :: proc(url: string, max: u64) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(path) = url.strip_prefix("file://") {
    // rust: if !is_local(&location()) {
    // rust: return Err(format!("{url} is not an https address"));
}
    // rust: return fs::read(path).map_err(|e| format!("{path}: {e}"));
}
    // rust: if !url.starts_with("https://") {
    // rust: return Err(format!("{url} is not an https address"));
}
    // rust: let response = ureq::get(url)
    // rust: .set("User-Agent", AGENT)
    // rust: .call()
    // rust: .map_err(|e| e.to_string())?;
    // rust: let mut body = Vec::new();
    // rust: response
    // rust: .into_reader()
    // rust: .take(max + 1)
    // rust: .read_to_end(&mut body)
    // rust: .map_err(|e| e.to_string())?;
    // rust: if body.len() as u64 > max {
    // rust: return Err(format!("{url} is larger than the index says"));
}
    // rust: Ok(body)
}

// `mod-browser.json`, kept as JSON values so the launcher's entries this
// game doesn't model (Modrinth resource packs, ported Java mods) are written
// back as they were.
Installed :: struct {
    entries: [dynamic]serde_json::Value,
}

    // rust: impl Installed {
load :: proc(home: ^Path) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let entries = fs::read_to_string(home.join(MANIFEST))
    // rust: .ok()
    // rust: .and_then(|t| serde_json::from_str::<serde_json::Value>(&t).ok())
    // rust: .and_then(|v| v.get("entries")?.as_array().cloned())
    // rust: .unwrap_or_default();
    // rust: Self { entries }
}

save :: proc(self: ^Self, home: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let path = home.join(MANIFEST);
    // rust: let part = home.join(format!(".{MANIFEST}.part"));
    // rust: let text = serde_json::to_string_pretty(&serde_json::json!({ "entries": self.entries }))
    // rust: .map_err(|e| e.to_string())?;
    // rust: fs::write(&part, text).map_err(|e| format!("{}: {e}", part.display()))?;
    // rust: fs::rename(&part, &path).map_err(|e| format!("{}: {e}", path.display()))
}

    // The registry's entry for project `id`.
position :: proc(self: ^Self, id: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.entries
    // rust: .iter()
    // rust: .position(|e| e["source"] == "horizon" && e["project"] == id)
}

    // The title of another entry that owns `file`.
taken_by :: proc(self: ^Self, file: string, id: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.entries
    // rust: .iter()
    // rust: .find(|e| e["file"] == file && !(e["source"] == "horizon" && e["project"] == id))
    // rust: .map(|e| e["title"].as_str().unwrap_or("another mod").to_owned())
}

record :: proc(self: ^Self, entry: serde_json::Value) {
}
    // rust: let id = entry["project"].clone();
    // rust: self.entries
    // rust: .retain(|e| !(e["source"] == "horizon" && e["project"] == id));
    // rust: self.entries.push(entry);
}

    // The version of `id` installed from the registry whose file is still
    // there; for a `horizon-mods/<id>.hmod` put there another way, its
    // manifest's version.
version_of :: proc(self: ^Self, home: ^Path, id: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(e) = self.position(id).map(|i| &self.entries[i])
    // rust: && let (Some(version), Some(file)) = (e["version"].as_str(), e["file"].as_str())
    // rust: && home.join(file).exists()
    // rust: {
    // rust: return Some(version.to_owned());
}
    // rust: let path: PathBuf = home.join(crate::mod_list::DIR).join(format!("{id}.hmod"));
    // rust: horizon_mods::Package::read(&path)
    // rust: .ok()
    // rust: .filter(|p| p.manifest.id == id)
    // rust: .map(|p| p.manifest.version)
}
}

    // rust: mod tests;
