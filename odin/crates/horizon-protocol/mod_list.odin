//! Transpiled from Horizon Rust crate
package horizon_protocol_mod_list

import "core:fmt"
import "core:mem"
import "core:math"

// The mod list: which content mods a Horizon server and a Horizon client
// have turned on, compared when a client joins (docs/mods.md, "Playing on a
// server with mods").
//
// In the configuration phase the server sends its list on [`CHANNEL`] and
// the client answers with its own on the same channel. The server then
// refuses a client whose mods differ, naming each one, which the registry
// hash of `horizon:block_registry` cannot do (it only sees ids): a mod
// whose loot, recipes or textures were edited keeps its ids, not its file's
// SHA-256. A vanilla client never hears the channel.
// use crate::{
    // rust: Error, Result,
    // rust: buf::{Reader, Writer},
}
// use std::sync::OnceLock;

// The custom payload channel, both ways.
CHANNEL :: "horizon:mod_list"
// Mods in a list at most; a list with more is refused whole.
MAX_ENTRIES :: 128
// Characters in a mod's id or version at most.
MAX_TEXT :: 64
// Mods named in a refusal's reason per kind of difference; the rest is counted.
SHOWN :: 6

// Where a mod runs (a manifest's `side`).
Side :: enum {
    // Both halves must have it: it changes what the world holds.
    Both,
    // Only the server needs it.
    Server,
    // Only the player's game: a HUD, keys, a minimap. Any server accepts it.
    Client,
}

    // rust: impl Side {
code :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Side::Both => 0,
    // rust: Side::Server => 1,
    // rust: Side::Client => 2,
}
}

from_code :: proc(code: u8) -> R {
    // Ported from Horizon
    return {}
}
    // rust: match code {
    // rust: 0 => Ok(Side::Both),
    // rust: 1 => Ok(Side::Server),
    // rust: 2 => Ok(Side::Client),
    // rust: _ => Err(Error::new(format!("mod list: side {code}"))),
}
}
}

// A mod that is on.
Entry :: struct {
    id: string,
    version: string,
    // SHA-256 of the mod's file; none for a mod run from a folder.
    sha256: Option<[u8,
    side: Side,
}

// The mods this game has on, set once when they load (`game/mods.rs`), like
// the registries they fill, and read when a connection is set up, whatever
// side of it this game is.
LOCAL :: OnceLock::new()

// Sets the mods this game has on; false when they were set already (a pack
// reload builds another root, the registries keep the first).
set_local :: proc(mut entries: [dynamic]Entry) -> b {
    // Ported from Horizon
    return {}
}
    // rust: entries.sort_by(|a, b| a.id.cmp(&b.id));
    // rust: entries.truncate(MAX_ENTRIES);
    // rust: LOCAL.set(entries).is_ok()
}

// Whether `set_local` has run: a pack reload then skips reading and hashing
// the mods' files again, since the first list stays.
is_set :: proc() -> b {
    // Ported from Horizon
    return {}
}
    // rust: LOCAL.get().is_some()
}

// The mods this game has on, by id.
local :: proc() -> V {
    // Ported from Horizon
    return {}
}
    // rust: LOCAL.get().cloned().unwrap_or_default()
}

// The entries the other side compares (`side = "both"`): what a join sends. Client-only
// and server-only mods stay private, since any server can ask for the list.
shared :: proc(entries: ^[Entry]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: entries
    // rust: .iter()
    // rust: .filter(|e| e.side == Side::Both)
    // rust: .cloned()
    // rust: .collect()
}

// A list as a payload.
encode :: proc(entries: ^[Entry]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let cut = |s: &str| -> String { s.chars().take(MAX_TEXT).collect() };
    // rust: let entries = &entries[..entries.len().min(MAX_ENTRIES)];
    // rust: let mut w = Writer::new();
    // rust: w.varint(entries.len() as i32);
    // rust: for e in entries {
    // rust: w.string(&cut(&e.id));
    // rust: w.string(&cut(&e.version));
    // rust: w.u8(e.side.code());
    // rust: match &e.sha256 {
    // rust: Some(hash) => {
    // rust: w.bool(true);
    // rust: w.bytes(hash);
}
    // rust: None => w.bool(false),
}
}
    // rust: w.data
}

// A payload's list; an error for one that breaks a cap.
decode :: proc(data: []u8) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut r = Reader::new(data);
    // rust: let count = r.varint()?;
    // rust: if !(0..=MAX_ENTRIES as i32).contains(&count) {
    // rust: return Err(Error::new(format!("mod list: {count} mods")));
}
    // rust: let entries = (0..count)
    // rust: .map(|_| {
    // rust: let id = r.string(MAX_TEXT)?;
    // rust: let version = r.string(MAX_TEXT)?;
    // rust: let side = Side::from_code(r.u8()?)?;
    // rust: let sha256 = match r.bool()? {
    // rust: true => Some(r.bytes(32)?.try_into().expect("32 bytes")),
    // rust: false => None,
}
    // rust: Ok(Entry {
    // rust: id,
    // rust: version,
    // rust: sha256,
    // rust: side,
    // rust: })
    // rust: })
    // rust: .collect::<Result<Vec<_>>>()?;
    // rust: if r.remaining() > 0 {
    // rust: return Err(Error::new("mod list: trailing bytes"));
}
    // rust: Ok(entries)
}

// How a client's mods differ from a server's.
Difference :: struct {
    // The server has it on and the client does not: `id version`.
    missing: [dynamic]string,
    // The client has it on, the server does not, and it changes the world.
    extra: [dynamic]string,
    // Both have it, not the same: `id (server version, yours version)`, or
    // `id version (your file was changed)` for the same version.
    changed: [dynamic]string,
}

    // rust: impl Difference {
is_empty :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.missing.is_empty() && self.extra.is_empty() && self.changed.is_empty()
}

    // What the refused player reads.
reason :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut parts = Vec::new();
    // rust: for (label, names) in [
    // rust: ("Missing", &self.missing),
    // rust: ("Not on this server", &self.extra),
    // rust: ("Different version or file", &self.changed),
    // rust: ] {
    // rust: if names.is_empty() {
    // rust: continue;
}
    // rust: let mut text = names[..names.len().min(SHOWN)].join(", ");
    // rust: if names.len() > SHOWN {
    // rust: text.push_str(&format!(" and {} more", names.len() - SHOWN));
}
    // rust: parts.push(format!("{label}: {text}"));
}
    // rust: format!("Your mods don't match this server's. {}", parts.join(". "))
}
}

// What a client must change to join a server. Only `Both` mods count, on
// either side: a `Server` mod is the server's business, a `Client` one the
// player's.
compare :: proc(server: ^[Entry], client: ^[Entry]) -> D {
    // Ported from Horizon
    return {}
}
    // rust: let mut difference = Difference::default();
    // rust: for s in server.iter().filter(|s| s.side == Side::Both) {
    // rust: match client.iter().find(|c| c.id == s.id) {
    // rust: None => difference.missing.push(format!("{} {}", s.id, s.version)),
    // rust: Some(c) => {
    // rust: let other_file = matches!((s.sha256, c.sha256), (Some(a), Some(b)) if a != b);
    // rust: if s.version != c.version {
    // rust: difference.changed.push(format!(
    // rust: "{} (server {}, yours {})",
    // rust: s.id, s.version, c.version
    // rust: ));
    // rust: } else if other_file {
    // rust: difference
    // rust: .changed
    // rust: .push(format!("{} {} (your file was changed)", s.id, s.version));
}
}
}
}
    // rust: for c in client.iter().filter(|c| c.side == Side::Both) {
    // rust: if !server.iter().any(|s| s.id == c.id) {
    // rust: difference.extra.push(format!("{} {}", c.id, c.version));
}
}
    // rust: difference
}

    // rust: mod tests {
//     use super::*;

entry :: proc(id: string, version: string, hash: u8, side: Side) -> E {
    // Ported from Horizon
    return {}
}
    // rust: Entry {
    // rust: id: id.into(),
    // rust: version: version.into(),
    // rust: sha256: Some([hash; 32]),
    // rust: side,
}
}

only_shared_mods_are_sent :: proc() {
}
    // rust: let list = [
    // rust: entry("ruby", "1.0", 1, Side::Both),
    // rust: entry("minimap", "2.0", 2, Side::Client),
    // rust: entry("admin", "3.0", 3, Side::Server),
    // rust: ];
    // rust: let sent = shared(&list);
    // rust: assert_eq!(sent.len(), 1);
    // rust: assert_eq!(sent[0].id, "ruby");
    // rust: assert!(compare(&list, &sent).is_empty());
}

a_list_round_trips :: proc() {
}
    // rust: let list = vec![
    // rust: entry("ruby", "1.2.0", 7, Side::Both),
    // rust: Entry {
    // rust: sha256: None,
    // rust: ..entry("dev", "0.1", 0, Side::Client)
    // rust: },
    // rust: ];
    // rust: assert_eq!(decode(&encode(&list)).unwrap(), list);
    // rust: assert_eq!(decode(&encode(&[])).unwrap(), []);
}

lists_over_the_caps_are_refused :: proc() {
}
    // rust: let mut w = Writer::new();
    // rust: w.varint(MAX_ENTRIES as i32 + 1);
    // rust: assert!(decode(&w.data).is_err());
    // rust: let mut w = Writer::new();
    // rust: w.varint(1);
    // rust: w.string(&"x".repeat(MAX_TEXT + 1));
    // rust: assert!(decode(&w.data).is_err());
    // rust: let mut w = Writer::new();
    // rust: w.varint(1);
    // rust: w.string("a");
    // rust: w.string("1");
    // rust: w.u8(9);
    // rust: w.bool(false);
    // rust: assert!(decode(&w.data).is_err());
    // rust: let mut trailing = encode(&[]);
    // rust: trailing.push(0);
    // rust: assert!(decode(&trailing).is_err());
    // rust: assert!(decode(&[0xFF]).is_err());
}

the_same_mods_match_whatever_the_order :: proc() {
}
    // rust: let a = entry("a", "1", 1, Side::Both);
    // rust: let b = entry("b", "2", 2, Side::Both);
    // rust: assert!(compare(&[a.clone(), b.clone()], &[b, a]).is_empty());
}

each_kind_of_difference_is_named :: proc() {
}
    // rust: let server = [
    // rust: entry("ruby", "1.0", 1, Side::Both),
    // rust: entry("pipes", "2.0", 2, Side::Both),
    // rust: entry("glass", "1.0", 3, Side::Both),
    // rust: ];
    // rust: let client = [
    // rust: entry("ruby", "1.0", 1, Side::Both),
    // rust: entry("pipes", "2.0", 99, Side::Both),
    // rust: entry("glass", "0.9", 3, Side::Both),
    // rust: entry("xray_blocks", "1.0", 4, Side::Both),
    // rust: ];
    // rust: let d = compare(&server, &client);
    // rust: assert_eq!(d.missing, Vec::<String>::new());
    // rust: assert_eq!(d.extra, ["xray_blocks 1.0"]);
    // rust: assert_eq!(
    // rust: d.changed,
    // rust: [
    // rust: "pipes 2.0 (your file was changed)",
    // rust: "glass (server 1.0, yours 0.9)"
    // rust: ]
    // rust: );
    // rust: let d = compare(&server, &client[..1]);
    // rust: assert_eq!(d.missing, ["pipes 2.0", "glass 1.0"]);
    // rust: let reason = d.reason();
    // rust: assert!(reason.contains("Missing: pipes 2.0, glass 1.0"), "{reason}");
}

client_only_and_server_only_mods_never_block_a_join :: proc() {
}
    // rust: let server = [
    // rust: entry("anti_grief", "1", 1, Side::Server),
    // rust: entry("ruby", "1", 2, Side::Both),
    // rust: ];
    // rust: let client = [
    // rust: entry("minimap", "3", 3, Side::Client),
    // rust: entry("ruby", "1", 2, Side::Both),
    // rust: ];
    // rust: assert!(compare(&server, &client).is_empty());
    // rust: assert!(compare(&[], &[entry("minimap", "3", 3, Side::Client)]).is_empty());
}

a_mod_run_from_a_folder_matches_by_version :: proc() {
}
    // rust: let mut folder = entry("ruby", "1", 0, Side::Both);
    // rust: folder.sha256 = None;
    // rust: assert!(compare(&[entry("ruby", "1", 5, Side::Both)], &[folder.clone()]).is_empty());
    // rust: assert!(!compare(&[entry("ruby", "2", 5, Side::Both)], &[folder]).is_empty());
}

a_long_refusal_counts_the_rest :: proc() {
}
    // rust: let server: Vec<_> = (0..9)
    // rust: .map(|i| entry(&format!("m{i}"), "1", i, Side::Both))
    // rust: .collect();
    // rust: let reason = compare(&server, &[]).reason();
    // rust: assert!(reason.contains("m5 1 and 3 more"), "{reason}");
    // rust: assert!(!reason.contains("m6"), "{reason}");
}
}
