//! Transpiled from Horizon Rust crate
package horizon_client_render_pack_browser

import "core:fmt"
import "core:mem"
import "core:math"

// Browsing Modrinth for resource packs from the Select Resource Packs
// screen, so a pack can be added without leaving the game.
//
// The launcher has its own browser (`launcher/src/browser/`), but the
// launcher is a separate workspace: nothing there is reachable from the
// game, so this is the small client the screen needs. Search and download
// both run on a worker thread and report back over a channel; the screen
// only ever polls.
// use std::{
    // rust: path::{Path, PathBuf},
    // rust: sync::mpsc::{Receiver, Sender, channel},
}

// Modrinth asks every client to name itself.
    // rust: const AGENT: &str = concat!(
    // rust: "horizon-rust/horizon/",
    // rust: env!("CARGO_PKG_VERSION"),
    // rust: " (in-game resource pack browser)"
    // rust: );
API :: "https://api.modrinth.com/v2"
// Hits one search asks for. The list shows them all; Modrinth's own cap is
// 100.
LIMIT :: 20

// One search hit, as much of it as the list draws.
Hit :: struct {
    id: string,
    title: string,
    author: string,
    description: string,
    downloads: u64,
    // Modrinth's icon for the project, empty when it has none.
    icon_url: string,
}

// What the worker sends back.
Message :: enum {
    Results(Vec<Hit>),
    // A project's icon, as the PNG bytes Modrinth served.
    Icon(String, Vec<u8>),
    // A pack landed in the packs folder under this file name.
    Downloaded(String),
    // A technical reason in English: the screen shows it inside
    // `horizon.pack.addFailed`.
    Failed(String),
}

// The filters the sidebar offers: the label's translation key, and the
// Modrinth facet it adds. Facets of one group are OR-ed, groups AND-ed, so
// each group is its own inner list.
    // rust: pub const FILTERS: [(&str, &str, &str); 6] = [
    // rust: ("horizon.pack.filter.realistic", "categories", "realistic"),
    // rust: ("horizon.pack.filter.simplistic", "categories", "simplistic"),
    // rust: (
    // rust: "horizon.pack.filter.vanillaLike",
    // rust: "categories",
    // rust: "vanilla-like",
    // rust: ),
    // rust: ("horizon.pack.filter.x16", "resolutions", "16x"),
    // rust: ("horizon.pack.filter.x32", "resolutions", "32x"),
    // rust: ("horizon.pack.filter.x64", "resolutions", "64x"),
    // rust: ];

// The search URL for `query` with the chosen filters (indices into
// [`FILTERS`]), restricted to resource packs. An empty query is Modrinth's
// own browse (its default ordering).
search_url :: proc(query: string, chosen: ^std::collections::BTreeSet<uint>) -> S {
    // Ported from Horizon
    return {}
}
    // One inner list per group: within a group Modrinth ORs, between groups
    // it ANDs, so picking 16x and 32x widens rather than excluding both.
    // rust: let mut groups: Vec<(&str, Vec<String>)> = Vec::new();
    // rust: for i in chosen.iter().filter(|i| **i < FILTERS.len()) {
    // rust: let (_, group, value) = FILTERS[*i];
    // rust: let term = format!("\"{group}:{value}\"");
    // rust: match groups.iter_mut().find(|(g, _)| *g == group) {
    // rust: Some((_, terms)) => terms.push(term),
    // rust: None => groups.push((group, vec![term])),
}
}
    // rust: let mut facets = String::from("[[\"project_type:resourcepack\"]]");
    // rust: if !groups.is_empty() {
    // rust: let extra: Vec<String> = groups
    // rust: .iter()
    // rust: .map(|(_, terms)| format!("[{}]", terms.join(",")))
    // rust: .collect();
    // rust: facets = format!("[[\"project_type:resourcepack\"],{}]", extra.join(","));
}
    // rust: format!(
    // rust: "{API}/search?limit={LIMIT}&index=relevance&facets={}&query={}",
    // rust: urlencode(&facets),
    // rust: urlencode(query.trim())
    // rust: )
}

// The versions of `project` that name this game version, newest first as
// Modrinth returns them.
versions_url :: proc(project: string, game_version: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!(
    // rust: "{API}/project/{}/version?game_versions={}",
    // rust: urlencode(project),
    // rust: urlencode(&format!("[\"{game_version}\"]"))
    // rust: )
}

// Percent-encoding for a query value: everything but the unreserved set.
urlencode :: proc(text: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = String::with_capacity(text.len());
    // rust: for byte in text.as_bytes() {
    // rust: match byte {
    // rust: b'A'..=b'Z' | b'a'..=b'z' | b'0'..=b'9' | b'-' | b'_' | b'.' | b'~' => {
    // rust: out.push(*byte as char);
}
    // rust: _ => out.push_str(&format!("%{byte:02X}")),
}
}
    // rust: out
}

// The hits of a `/search` reply. A hit missing the fields the list draws is
// left out rather than drawn blank.
parse_search :: proc(body: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let value: serde_json::Value = serde_json::from_str(body).map_err(|e| e.to_string())?;
    // rust: let hits = value
    // rust: .get("hits")
    // rust: .and_then(|h| h.as_array())
    // rust: .ok_or("the reply has no hits")?;
    // rust: Ok(hits
    // rust: .iter()
    // rust: .filter_map(|hit| {
    // rust: Some(Hit {
    // rust: id: hit.get("project_id")?.as_str()?.to_owned(),
    // rust: title: hit.get("title")?.as_str()?.to_owned(),
    // rust: author: hit
    // rust: .get("author")
    // rust: .and_then(|a| a.as_str())
    // rust: .unwrap_or_default()
    // rust: .to_owned(),
    // rust: description: hit
    // rust: .get("description")
    // rust: .and_then(|d| d.as_str())
    // rust: .unwrap_or_default()
    // rust: .to_owned(),
    // rust: downloads: hit.get("downloads").and_then(|d| d.as_u64()).unwrap_or(0),
    // rust: icon_url: hit
    // rust: .get("icon_url")
    // rust: .and_then(|u| u.as_str())
    // rust: .unwrap_or_default()
    // rust: .to_owned(),
    // rust: })
    // rust: })
    // rust: .collect())
}

// The primary file of the newest version: its URL, its file name and the
// SHA-1 the index states for it.
parse_version_file :: proc(body: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let value: serde_json::Value = serde_json::from_str(body).map_err(|e| e.to_string())?;
    // rust: let versions = value.as_array().ok_or("the reply is not a version list")?;
    // rust: for version in versions {
    // rust: let Some(files) = version.get("files").and_then(|f| f.as_array()) else {
    // rust: continue;
}
        // `primary` marks the pack itself; some versions ship extras beside it.
    // rust: let file = files
    // rust: .iter()
    // rust: .find(|f| f.get("primary").and_then(|p| p.as_bool()) == Some(true))
    // rust: .or_else(|| files.first());
    // rust: let Some(file) = file else { continue };
    // rust: let (Some(url), Some(name)) = (
    // rust: file.get("url").and_then(|u| u.as_str()),
    // rust: file.get("filename").and_then(|n| n.as_str()),
    // rust: ) else {
    // rust: continue;
}
    // rust: let sha1 = file
    // rust: .get("hashes")
    // rust: .and_then(|h| h.get("sha1"))
    // rust: .and_then(|h| h.as_str())
    // rust: .map(str::to_owned);
    // rust: return Ok((url.to_owned(), name.to_owned(), sha1));
}
    // rust: Err("no version of this pack names this game version".into())
}

// A file name safe to write into the packs folder: Modrinth's own name with
// every separator and parent reference taken out, and a `.zip` ending.
// Without this a reply could name a path outside the folder.
safe_file_name :: proc(name: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let base = name.rsplit(['/', '\\']).next().unwrap_or(name);
    // rust: let mut cleaned: String = base
    // rust: .chars()
    // rust: .map(|c| match c {
    // rust: 'A'..='Z' | 'a'..='z' | '0'..='9' | '-' | '_' | '.' | ' ' | '(' | ')' | '[' | ']' => c,
    // rust: _ => '_',
    // rust: })
    // rust: .collect();
    // rust: cleaned = cleaned.trim_matches(['.', ' ']).to_owned();
    // rust: if cleaned.is_empty() {
    // rust: cleaned = "pack".into();
}
    // Windows' device names cannot be files, whatever their extension.
    // rust: let stem = cleaned.split('.').next().unwrap_or_default().trim_end();
    // rust: let device = matches!(
    // rust: stem.to_ascii_uppercase().as_str(),
    // rust: "CON" | "PRN" | "AUX" | "NUL"
    // rust: ) || (stem.len() == 4
    // rust: && ["COM", "LPT"]
    // rust: .iter()
    // rust: .any(|p| stem[..3].eq_ignore_ascii_case(p))
    // rust: && stem.as_bytes()[3].is_ascii_digit());
    // rust: if device {
    // rust: cleaned.insert(0, '_');
}
    // rust: if !cleaned.to_ascii_lowercase().ends_with(".zip") {
    // rust: cleaned.push_str(".zip");
}
    // rust: cleaned
}

// `name` in `dir`, numbered when something of that name is already there, so
// a download never replaces a pack the player already has. `None` once every
// number up to 999 is taken.
free_path :: proc(dir: ^Path, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let path = dir.join(name);
    // rust: if !path.exists() {
    // rust: return Some(path);
}
    // rust: let (stem, extension) = name.rsplit_once('.').unwrap_or((name, "zip"));
    // rust: (2..1000)
    // rust: .map(|n| dir.join(format!("{stem} ({n}).{extension}")))
    // rust: .find(|candidate| !candidate.exists())
}

// The browser's state, owned by the pack screen.
Browser :: struct {
    query: string,
    hits: [dynamic]Hit,
    selected: Maybe(uint),
    scroll: f64,
    // Set while a search or a download is in flight.
    busy: bool,
    // Already-translated text, shown in place of the list.
    status: Maybe(string),
    // The hit an install is running for.
    installing: Maybe(uint),
    // Hits already installed this visit, by index.
    installed: std::collections::BTreeSet<uint>,
    // The sidebar filters that are on, as indices into [`FILTERS`].
    filters: std::collections::BTreeSet<uint>,
    sender: Sender<Message>,
    receiver: Receiver<Message>,
}

    // rust: impl std::fmt::Debug for Browser {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter<'_>) -> s {
    // Ported from Horizon
    return {}
}
    // rust: f.debug_struct("Browser")
    // rust: .field("query", &self.query)
    // rust: .field("hits", &self.hits.len())
    // rust: .field("busy", &self.busy)
    // rust: .finish()
}
}

    // rust: impl Clone for Browser {
    // The screen is cloned for drawing; a clone carries the state, not the
    // worker's channel, and starts its own.
clone :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let (sender, receiver) = channel();
    // rust: Self {
    // rust: query: self.query.clone(),
    // rust: hits: self.hits.clone(),
    // rust: selected: self.selected,
    // rust: scroll: self.scroll,
    // rust: busy: self.busy,
    // rust: status: self.status.clone(),
    // rust: installing: self.installing,
    // rust: installed: self.installed.clone(),
    // rust: filters: self.filters.clone(),
    // rust: sender,
    // rust: receiver,
}
}
}

    // rust: impl Default for Browser {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::new()
}
}

    // rust: impl Browser {
new :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: let (sender, receiver) = channel();
    // rust: Self {
    // rust: query: String::new(),
    // rust: hits: Vec::new(),
    // rust: selected: None,
    // rust: scroll: 0.0,
    // rust: busy: false,
    // rust: status: None,
    // rust: installing: None,
    // rust: installed: Default::default(),
    // rust: filters: Default::default(),
    // rust: sender,
    // rust: receiver,
}
}

    // Anything the worker has finished since the last call. The caller
    // refreshes its pack list when a [`Message::Downloaded`] comes back.
poll :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let message = self.receiver.try_recv().ok()?;
    // rust: let was_busy = self.busy;
    // rust: self.busy = false;
    // rust: match &message {
    // rust: Message::Results(hits) => {
    // rust: self.hits = hits.clone();
    // rust: self.selected = None;
    // rust: self.scroll = 0.0;
    // rust: self.status = None;
}
    // rust: Message::Downloaded(_) => {
    // rust: self.status = None;
    // rust: if let Some(i) = self.installing.take() {
    // rust: self.installed.insert(i);
}
}
            // An icon is the screen's to keep; it does not end a search.
    // rust: Message::Icon(..) => self.busy = was_busy,
    // rust: Message::Failed(reason) => {
    // rust: self.status = Some(reason.clone());
    // rust: self.installing = None;
}
}
    // rust: Some(message)
}

    // Searches for the current query on a worker thread.
search :: proc(self: ^Self) {
}
    // rust: if self.busy {
    // rust: return;
}
    // rust: self.busy = true;
    // rust: self.status = None;
    // rust: let url = search_url(&self.query, &self.filters);
    // rust: let sender = self.sender.clone();
    // rust: spawn("pack-browser-search", move || {
    // rust: let message = match get_text(&url) {
    // rust: Ok(body) => match parse_search(&body) {
    // rust: Ok(hits) => Message::Results(hits),
    // rust: Err(reason) => Message::Failed(reason),
    // rust: },
    // rust: Err(reason) => Message::Failed(reason),
}
    // rust: let _ = sender.send(message);
    // rust: });
}

    // Fetches each hit's icon on one worker, so the list fills in as they
    // arrive. Icons are small; a hit without one is skipped.
fetch_icons :: proc(self: ^Self) {
}
    // rust: let wanted: Vec<(String, String)> = self
    // rust: .hits
    // rust: .iter()
    // rust: .filter(|h| !h.icon_url.is_empty())
    // rust: .map(|h| (h.id.clone(), h.icon_url.clone()))
    // rust: .collect();
    // rust: if wanted.is_empty() {
    // rust: return;
}
    // rust: let sender = self.sender.clone();
    // rust: spawn("pack-browser-icons", move || {
    // rust: for (id, url) in wanted {
    // rust: match get_bytes(&url, MAX_ICON_BYTES) {
    // rust: Ok(bytes) => {
    // rust: if sender.send(Message::Icon(id, bytes)).is_err() {
    // rust: return;
}
}
                    // A missing icon only leaves that row without one.
    // rust: Err(e) => log::debug!("Horizon: pack icon {id} did not load: {e}"),
}
}
    // rust: });
}

    // Downloads the selected pack into `dir` on a worker thread.
download :: proc(self: ^Self, index: uint, dir: ^Path, game_version: string) {
}
    // rust: if self.busy {
    // rust: return;
}
    // rust: let Some(hit) = self.hits.get(index) else {
    // rust: return;
}
    // rust: self.installing = Some(index);
    // rust: self.busy = true;
    // rust: self.status = None;
    // rust: let url = versions_url(&hit.id, game_version);
    // rust: let dir = dir.to_path_buf();
    // rust: let sender = self.sender.clone();
    // rust: spawn("pack-browser-download", move || {
    // rust: let _ = sender.send(download_pack(&url, &dir));
    // rust: });
}
}

spawn :: proc(name: string, work: impl FnOnce() {
}
    // rust: if let Err(e) = std::thread::Builder::new().name(name.into()).spawn(work) {
    // rust: log::warn!("Horizon: {name} did not start: {e}");
}
}

// Fetches the version list, then the pack, and writes it into `dir`.
download_pack :: proc(versions: string, dir: ^Path) -> M {
    // Ported from Horizon
    return {}
}
    // rust: let (url, name, sha1) = match get_text(versions).and_then(|body| parse_version_file(&body)) {
    // rust: Ok(found) => found,
    // rust: Err(reason) => return Message::Failed(reason),
}
    // rust: let body = match get_bytes(&url, MAX_PACK_BYTES) {
    // rust: Ok(body) => body,
    // rust: Err(reason) => return Message::Failed(reason),
}
    // rust: if let Some(expected) = &sha1 {
    // rust: let found = sha1_hex(&body);
    // rust: if !found.eq_ignore_ascii_case(expected) {
    // rust: return Message::Failed(format!(
    // rust: "the download did not match its checksum ({found} for {expected})"
    // rust: ));
}
}
    // rust: let name = safe_file_name(&name);
    // rust: if let Err(e) = std::fs::create_dir_all(dir) {
    // rust: return Message::Failed(e.to_string());
}
    // rust: let Some(path) = free_path(dir, &name) else {
    // rust: return Message::Failed(format!("{name}: every numbered name is taken"));
}
    // Written beside the pack and renamed, so a pack list never sees a
    // half-written zip.
    // rust: let partial = path.with_extension("partial");
    // rust: match std::fs::write(&partial, &body).and_then(|()| std::fs::rename(&partial, &path)) {
    // rust: Ok(()) => Message::Downloaded(
    // rust: path.file_name()
    // rust: .map(|n| n.to_string_lossy().into_owned())
    // rust: .unwrap_or(name),
    // rust: ),
    // rust: Err(e) => {
    // rust: let _ = std::fs::remove_file(&partial);
    // rust: Message::Failed(e.to_string())
}
}
}

// A pack Modrinth serves is capped: a reply past this is refused rather than
// read into memory.
MAX_PACK_BYTES :: 512 * 1024 * 1024
// A project icon is a small image; one past this is not read.
MAX_ICON_BYTES :: 2 * 1024 * 1024

// Only HTTPS: a reply names the URLs fetched next (icons, files), and a plain
// `http://` one could point anywhere unencrypted, the player's own network
// included.
https_only :: proc(url: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if url.starts_with("https://") {
    // rust: Ok(())
    // rust: } else {
    // rust: Err(format!("{url} is not an https address"))
}
}

get_text :: proc(url: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: ureq::get(url)
    // rust: .set("User-Agent", AGENT)
    // rust: .call()
    // rust: .map_err(|e| e.to_string())?
    // rust: .into_string()
    // rust: .map_err(|e| e.to_string())
}

get_bytes :: proc(url: string, max: uint) -> R {
    // Ported from Horizon
    return {}
}
//     use std::io::Read;
    // rust: https_only(url)?;
    // rust: let response = ureq::get(url)
    // rust: .set("User-Agent", AGENT)
    // rust: .call()
    // rust: .map_err(|e| e.to_string())?;
    // rust: let mut body = Vec::new();
    // rust: response
    // rust: .into_reader()
    // rust: .take(max as u64 + 1)
    // rust: .read_to_end(&mut body)
    // rust: .map_err(|e| e.to_string())?;
    // rust: if body.len() > max {
    // rust: return Err(format!("{url} is larger than {max} bytes"));
}
    // rust: Ok(body)
}

// SHA-1 of `bytes` as lowercase hex, for the checksum Modrinth states beside
// each file (the `sha1` crate the skins already use).
sha1_hex :: proc(bytes: []u8) -> S {
    // Ported from Horizon
    return {}
}
    // rust: crate::skins::sha1(bytes)
    // rust: .iter()
    // rust: .map(|b| format!("{b:02x}"))
    // rust: .collect()
}

    // rust: mod tests {
//     use super::*;

sha1_matches_the_published_vectors :: proc() {
}
        // FIPS 180-4's own examples, independent of this implementation.
    // rust: assert_eq!(sha1_hex(b""), "da39a3ee5e6b4b0d3255bfef95601890afd80709");
    // rust: assert_eq!(sha1_hex(b"abc"), "a9993e364706816aba3e25717850c26c9cd0d89d");
    // rust: assert_eq!(
    // rust: sha1_hex(b"abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq"),
    // rust: "84983e441c3bd26ebaae4aa1f95129e5e54670f1"
    // rust: );
        // Past one block, so the padding and the length word are exercised.
    // rust: assert_eq!(
    // rust: sha1_hex(&b"a".repeat(1000)),
    // rust: "291e9a6c66994949b57ba5e650361e98fc36b1ba"
    // rust: );
}

search_asks_only_for_resource_packs :: proc() {
}
    // rust: let none = std::collections::BTreeSet::new();
    // rust: let url = search_url("blue", &none);
    // rust: assert!(url.starts_with("https://api.modrinth.com/v2/search?"));
    // rust: assert!(url.contains("project_type%3Aresourcepack"));
    // rust: assert!(url.ends_with("query=blue"));
        // A query with its own separators cannot add parameters.
    // rust: assert!(search_url("a&b=c", &none).ends_with("query=a%26b%3Dc"));
}

filters_of_one_group_widen_and_groups_narrow :: proc() {
}
    // rust: let chosen = |v: &[usize]| v.iter().copied().collect();
        // Two resolutions are one group: Modrinth ORs inside a list.
    // rust: let both: std::collections::BTreeSet<usize> = chosen(&[3, 4]);
    // rust: let url = search_url("", &both);
    // rust: assert!(url.contains(&urlencode(
    // rust: r#"[["project_type:resourcepack"],["resolutions:16x","resolutions:32x"]]"#
    // rust: )));
        // A category and a resolution are separate lists, so they AND.
    // rust: let mixed: std::collections::BTreeSet<usize> = chosen(&[0, 3]);
    // rust: let url = search_url("", &mixed);
    // rust: assert!(url.contains(&urlencode(
    // rust: r#"[["project_type:resourcepack"],["categories:realistic"],["resolutions:16x"]]"#
    // rust: )));
        // Out-of-range indices are ignored rather than panicking.
    // rust: let silly: std::collections::BTreeSet<usize> = chosen(&[99]);
    // rust: assert!(search_url("", &silly).contains(&urlencode(r#"[["project_type:resourcepack"]]"#)));
}

versions_are_asked_for_this_game_version :: proc() {
}
    // rust: let url = versions_url("abc", "26.3");
    // rust: assert_eq!(
    // rust: url,
    // rust: "https://api.modrinth.com/v2/project/abc/version?game_versions=%5B%2226.3%22%5D"
    // rust: );
}

search_hits_are_read_and_incomplete_ones_left_out :: proc() {
}
    // rust: let body = r#"{"hits":[
    // rust: {"project_id":"aa","title":"Blue","author":"someone","description":"d","downloads":12},
    // rust: {"title":"no id"},
    // rust: {"project_id":"bb","title":"Bare"}
    // rust: ]}"#;
    // rust: let hits = parse_search(body).unwrap();
    // rust: assert_eq!(hits.len(), 2);
    // rust: assert_eq!(hits[0].id, "aa");
    // rust: assert_eq!(hits[0].downloads, 12);
        // The fields the list can do without default rather than drop the hit.
    // rust: assert_eq!(hits[1].id, "bb");
    // rust: assert_eq!(hits[1].author, "");
    // rust: assert_eq!(hits[1].downloads, 0);
    // rust: assert!(parse_search("not json").is_err());
    // rust: assert!(parse_search(r#"{"total":0}"#).is_err());
}

the_primary_file_of_the_newest_version_wins :: proc() {
}
    // rust: let body = r#"[
    // rust: {"files":[
    // rust: {"url":"https://e/x.txt","filename":"x.txt","primary":false},
    // rust: {"url":"https://e/p.zip","filename":"p.zip","primary":true,
    // rust: "hashes":{"sha1":"abc"}}
    // rust: ]},
    // rust: {"files":[{"url":"https://e/old.zip","filename":"old.zip","primary":true}]}
    // rust: ]"#;
    // rust: let (url, name, sha1) = parse_version_file(body).unwrap();
    // rust: assert_eq!((url.as_str(), name.as_str()), ("https://e/p.zip", "p.zip"));
    // rust: assert_eq!(sha1.as_deref(), Some("abc"));
        // No file marked primary: the first one stands in.
    // rust: let single = r#"[{"files":[{"url":"https://e/a.zip","filename":"a.zip"}]}]"#;
    // rust: assert_eq!(parse_version_file(single).unwrap().1, "a.zip");
    // rust: assert!(parse_version_file("[]").is_err());
}

a_served_name_cannot_leave_the_packs_folder :: proc() {
}
    // rust: assert_eq!(safe_file_name("../../evil.zip"), "evil.zip");
    // rust: assert_eq!(safe_file_name("a/b/c.zip"), "c.zip");
    // rust: assert_eq!(safe_file_name(r"a\b\c.zip"), "c.zip");
    // rust: assert_eq!(safe_file_name("pack"), "pack.zip");
    // rust: assert_eq!(safe_file_name(""), "pack.zip");
    // rust: assert_eq!(safe_file_name("..."), "pack.zip");
    // rust: assert_eq!(safe_file_name("Nice Pack (v2).zip"), "Nice Pack (v2).zip");
        // Keeps its ending whatever its case, rather than gaining a second one.
    // rust: assert_eq!(safe_file_name("Pack.ZIP"), "Pack.ZIP");
        // Windows' device names get a prefix; a longer stem keeps its name.
    // rust: assert_eq!(safe_file_name("CON"), "_CON.zip");
    // rust: assert_eq!(safe_file_name("aux.zip"), "_aux.zip");
    // rust: assert_eq!(safe_file_name("com1.tar.zip"), "_com1.tar.zip");
    // rust: assert_eq!(safe_file_name("console.zip"), "console.zip");
    // rust: assert_eq!(safe_file_name("COM10.zip"), "COM10.zip");
}

a_download_never_replaces_a_pack_already_there :: proc() {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-browser-{}", std::process::id()));
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: let _ = std::fs::remove_file(dir.join("p.zip"));
    // rust: let _ = std::fs::remove_file(dir.join("p (2).zip"));
    // rust: assert_eq!(free_path(&dir, "p.zip"), Some(dir.join("p.zip")));
    // rust: std::fs::write(dir.join("p.zip"), b"x").unwrap();
    // rust: assert_eq!(free_path(&dir, "p.zip"), Some(dir.join("p (2).zip")));
    // rust: std::fs::write(dir.join("p (2).zip"), b"x").unwrap();
    // rust: assert_eq!(free_path(&dir, "p.zip"), Some(dir.join("p (3).zip")));
    // rust: let _ = std::fs::remove_dir_all(&dir);
}
}
