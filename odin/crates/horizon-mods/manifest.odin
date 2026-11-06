//! Transpiled from Horizon Rust crate
package horizon_mods_manifest

import "core:fmt"
import "core:mem"
import "core:math"

// `horizon-mod.toml`, a mod's manifest, and the `.hmod` file around it.
// use serde::{Deserialize, Serialize};
// use std::{
    // rust: fmt,
    // rust: io::Read,
    // rust: path::{Path, PathBuf},
}

// The manifest's file name, beside `mod.wasm`.
MANIFEST :: "horizon-mod.toml"
// The component's file name in a `.hmod` or a mod folder.
WASM :: "mod.wasm"
// The API (WIT package `horizon:mods`) versions this build runs: a mod
// built for any 0.1.x SDK.
API :: "0.1"
// The manifest `api` lines this build loads. 0.2 is 0.1 plus content:
// `assets/` and `data/` in the `.hmod`, with blocks, items, creative tabs, mob effects,
// entity types and menu types declared in `data/<id>/horizon/` (docs/mods.md). Code still links API 0.1.
// 0.3 is a server mod (experimental): the `horizon-server-mod` world.
APIS :: [API, "0.2", SERVER_API]
// The line of server mods, experimental: `side = "server"`.
SERVER_API :: "0.3"
// Namespaces no mod may claim: vanilla's, the convention tags' (mods add
// to those, docs/mods.md) and the game's own.
RESERVED_NAMESPACES :: ["minecraft", "c", "horizon"]
// A mod's data (capability `storage`), in `horizon-mods/` beside the mods
// (`find` never mistakes it for a mod: it has no manifest).
STORAGE_DIR :: ".horizon-mod-data"
// The biggest `mod.wasm` a mod may ship.
MAX_WASM :: 32 << 20

Manifest :: struct {
    // `[a-z0-9_]`, 1 to 64 characters: the mod's folder, log and settings key.
    id: string,
    name: string,
    version: string,
    description: string,
    authors: [dynamic]string,
    // The API line the mod was built for: `0.1`, or `0.2` for content.
    api: string,
    side: Side,
    capabilities: [dynamic]Capability,
    // Namespaces besides `id` that the mod's `assets/` and `data/` use, for
    // a content mod whose files sit under other names than its id (Towns
    // and Towers ships `kaisyn` and `towns_and_towers`). No two content mods
    // that are on may share one (`content::clash`).
    namespaces: [dynamic]string,
    // The experimental capabilities the mod opts into (`["ui"]`): each one
    // it lists in `capabilities` must be named here too, since it may change
    // in any release (docs/api/stability.md). One no longer experimental is
    // accepted here, so the manifest keeps loading once it is promoted.
    experimental: [dynamic]Capability,
}

Side :: enum {
    // Runs in the player's game only (HUD, keys, chat commands).
    Client,
    // Runs where the world is simulated (rules, blocks): `api = "0.3"`.
    Server,
    // Both, and the server tells clients which version it expects.
    Both,
}

// What a mod may do beyond writing its log. Each is a WIT interface the
// component imports; the player sees them before turning the mod on.
Capability :: enum {
    GameRead,
    Chat,
    Hud,
    Storage,
    // Runs vanilla commands as the player, with the player's permissions.
    Command,
    // New blocks, items and mob effects from the mod's `data/` (API 0.2): no WIT
    // interface, the game reads them before the world loads.
    Registries,
    // A screen the mod owns and a settings page in Options > Mods, drawn
    // with the menus' own widgets (interface `ui`, calls `ui-events`).
    Ui,
    // Shapes on the HUD and the camera's shake, drawn by the game's own
    // renderer (interface `render`).
    Render,
    // The use button on items the mod claims, and its own keys
    // (interface `input`).
    Input,
    // The players on the server and messages to them (server mods).
    Players,
    // Blocks in the server's loaded chunks, and changes to them (server
    // mods; client mods later, where the game runs the world).
    World,
    // The recipes and items the game knows, for recipe viewers
    // (interface `recipes`).
    Recipes,
}
    // rust: impl Capability {
    // rust: pub const ALL: [Capability; 12] = [
    // rust: Capability::GameRead,
    // rust: Capability::Chat,
    // rust: Capability::Hud,
    // rust: Capability::Storage,
    // rust: Capability::Command,
    // rust: Capability::Registries,
    // rust: Capability::Ui,
    // rust: Capability::Render,
    // rust: Capability::Input,
    // rust: Capability::Players,
    // rust: Capability::World,
    // rust: Capability::Recipes,
    // rust: ];
    // Whether a server mod may have it: the others act on a local player.
on_server :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: self,
    // rust: Capability::Storage | Capability::Players | Capability::World
    // rust: )
}
    // The WIT interface it grants, in `horizon:mods`.
interface :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Capability::GameRead => "game",
    // rust: Capability::Chat => "chat",
    // rust: Capability::Hud => "hud",
    // rust: Capability::Storage => "storage",
    // rust: Capability::Command => "command",
    // rust: Capability::Registries => "registries",
    // rust: Capability::Ui => "ui",
    // rust: Capability::Render => "render",
    // rust: Capability::Input => "input",
    // rust: Capability::Players => "players",
    // rust: Capability::World => "world",
    // rust: Capability::Recipes => "recipes",
}
}
    // May change in any release: a mod uses it only with
    // `experimental = ["<name>"]` in its manifest.
is_experimental :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: self,
    // rust: Capability::Ui | Capability::Render | Capability::Input | Capability::Recipes
    // rust: )
}
    // What the player reads before turning the mod on: "May <this>".
describe :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Capability::GameRead => "see your position, health and the time",
    // rust: Capability::Chat => "show you chat messages",
    // rust: Capability::Hud => "draw text on your screen",
    // rust: Capability::Storage => "save its own settings to disk",
    // rust: Capability::Command => "run commands as you, with your permissions",
    // rust: Capability::Registries => {
    // rust: "add blocks, items, mob effects and entity types to your worlds"
}
    // rust: Capability::Ui => "show its own screens and a settings page",
    // rust: Capability::Render => "draw on your screen, shake and zoom the camera",
    // rust: Capability::Input => {
    // rust: "see the keys you hold and your clicks, take over the use button on its own items and the mouse wheel, and add keys"
}
    // rust: Capability::Players => "see who is on the server and message them",
    // rust: Capability::World => "read and change the world's blocks",
    // rust: Capability::Recipes => {
    // rust: "read the game's recipes and items and which recipes you know, place recipes in your crafting grid and, in creative mode, give you items"
}
}
}
    // The capability a component import needs, `Ok(None)` for one every
    // mod has; `Err` for an import Horizon does not offer.
of_import :: proc(name: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let unknown = || format!("imports {name}, which Horizon does not offer");
    // rust: let rest = name.strip_prefix("horizon:mods/").ok_or_else(unknown)?;
    // rust: let (interface, version) = rest.split_once('@').ok_or_else(unknown)?;
    // rust: if !version.starts_with("0.1.") {
    // rust: return Err(format!("needs API {version}; this Horizon runs {API}"));
}
    // rust: if interface == "log" {
    // rust: return Ok(None);
}
        // A recipe viewer's panel is part of capability `ui`.
    // rust: if interface == "browser" {
    // rust: return Ok(Some(Capability::Ui));
}
    // rust: Capability::ALL
    // rust: .into_iter()
    // rust: .filter(|c| *c != Capability::Registries)
    // rust: .find(|c| c.interface() == interface)
    // rust: .map(Some)
    // rust: .ok_or_else(unknown)
}
}
    // rust: impl fmt::Display for Capability {
fmt :: proc(self: ^Self, f: ^fmt::Formatter<'_>) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let name = match self {
    // rust: Capability::GameRead => "game-read",
    // rust: Capability::Chat => "chat",
    // rust: Capability::Hud => "hud",
    // rust: Capability::Storage => "storage",
    // rust: Capability::Command => "command",
    // rust: Capability::Registries => "registries",
    // rust: Capability::Ui => "ui",
    // rust: Capability::Render => "render",
    // rust: Capability::Input => "input",
    // rust: Capability::Players => "players",
    // rust: Capability::World => "world",
    // rust: Capability::Recipes => "recipes",
}
    // rust: f.write_str(name)
}
}

    // rust: impl Manifest {
parse :: proc(text: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let m: Manifest = toml::from_str(text).map_err(|e| format!("{MANIFEST}: {e}"))?;
    // rust: let id_ok = (1..=64).contains(&m.id.len())
    // rust: && m.id
    // rust: .bytes()
    // rust: .all(|b| b.is_ascii_lowercase() || b.is_ascii_digit() || b == b'_');
    // rust: if !id_ok {
    // rust: return Err(format!(
    // rust: "{MANIFEST}: id {:?} is not [a-z0-9_]{{1,64}}",
    // rust: m.id
    // rust: ));
}
    // rust: if !APIS.contains(&m.api.as_str()) {
    // rust: return Err(format!(
    // rust: "built for API {}; this Horizon runs {}",
    // rust: m.api,
    // rust: APIS.join(" and ")
    // rust: ));
}
    // rust: if m.capabilities.contains(&Capability::Registries) && m.api == API {
    // rust: return Err(format!(
    // rust: "{MANIFEST}: capability registries needs api = \"0.2\""
    // rust: ));
}
    // rust: let server = m.side == Side::Server;
    // rust: if server != (m.api == SERVER_API) {
    // rust: return Err(format!(
    // rust: "{MANIFEST}: a server mod is side = \"server\" with api = \"{SERVER_API}\", and only it"
    // rust: ));
}
    // rust: if let Some(c) = m
    // rust: .capabilities
    // rust: .iter()
    // rust: .find(|c| c.on_server() != server && **c != Capability::Storage)
    // rust: {
    // rust: let side = if server { "client" } else { "server" };
    // rust: return Err(format!("{MANIFEST}: capability {c} is for {side} mods"));
}
    // rust: if let Some(c) = m
    // rust: .capabilities
    // rust: .iter()
    // rust: .find(|c| c.is_experimental() && !m.experimental.contains(c))
    // rust: {
    // rust: return Err(format!(
    // rust: "{MANIFEST}: capability {c} is experimental and may change in any release: \
    // rust: add experimental = [\"{c}\"] to use it"
    // rust: ));
}
    // rust: if !m.namespaces.is_empty() && !m.capabilities.contains(&Capability::Registries) {
    // rust: return Err(format!(
    // rust: "{MANIFEST}: namespaces are for content, which needs capability registries"
    // rust: ));
}
    // rust: for (i, ns) in m.namespaces.iter().enumerate() {
            // Vanilla's namespace characters, at most as long as an id.
    // rust: let chars_ok = (1..=64).contains(&ns.len())
    // rust: && ns
    // rust: .bytes()
    // rust: .all(|b| b.is_ascii_lowercase() || b.is_ascii_digit() || b"_.-".contains(&b));
    // rust: if !chars_ok {
    // rust: return Err(format!(
    // rust: "{MANIFEST}: namespace {ns:?} is not [a-z0-9_.-]{{1,64}}"
    // rust: ));
}
    // rust: if RESERVED_NAMESPACES.contains(&ns.as_str()) {
    // rust: return Err(format!(
    // rust: "{MANIFEST}: namespace {ns} is not a mod's to claim (only to add to its tags)"
    // rust: ));
}
    // rust: if *ns == m.id || m.namespaces[..i].contains(ns) {
    // rust: return Err(format!("{MANIFEST}: namespace {ns} is listed twice"));
}
}
    // rust: Ok(m)
}
    // The namespaces the mod's content owns: its id, then `namespaces`.
owned_namespaces :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: std::iter::once(self.id.as_str()).chain(self.namespaces.iter().map(String::as_str))
}
    // Checks that the component's imports need only declared capabilities.
    // rust: pub fn check_imports<'a>(
    // rust: &self,
    // rust: imports: impl IntoIterator<Item = &'a str>,
    // rust: ) -> Result<(), String> {
    // rust: for name in imports {
    // rust: if let Some(c) = Capability::of_import(name)?
    // rust: && !self.capabilities.contains(&c)
    // rust: {
    // rust: return Err(format!("uses capability {c}, missing from {MANIFEST}"));
}
}
    // rust: Ok(())
}
}

// A mod as found on disk: its manifest and component bytes.
Package :: struct {
    manifest: Manifest,
    // None for a content-only mod (capability `registries`, no code).
    wasm: Maybe([dynamic]u8),
}
    // rust: impl Package {
    // A `.hmod` (a zip holding `horizon-mod.toml`, `mod.wasm` and, for
    // content, `assets/` and `data/`) or a folder holding the same.
read :: proc(path: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let (toml, wasm) = if path.is_dir() {
    // rust: let toml = std::fs::read_to_string(path.join(MANIFEST));
    // rust: let wasm = path.join(WASM);
    // rust: let wasm = match wasm.exists() {
    // rust: true => Some(std::fs::read(wasm).map_err(|e| format!("{WASM}: {e}"))?),
    // rust: false => None,
}
    // rust: (toml.map_err(|e| format!("{MANIFEST}: {e}"))?, wasm)
    // rust: } else {
    // rust: let file = std::fs::File::open(path).map_err(|e| e.to_string())?;
    // rust: let mut zip = zip::ZipArchive::new(file).map_err(|e| e.to_string())?;
    // rust: let mut entry = |name: &str| -> Result<Option<Vec<u8>>, String> {
    // rust: let f = match zip.by_name(name) {
    // rust: Ok(f) => f,
    // rust: Err(zip::result::ZipError::FileNotFound) => return Ok(None),
    // rust: Err(e) => return Err(format!("{name}: {e}")),
}
    // rust: let mut out = Vec::new();
    // rust: f.take(MAX_WASM + 1)
    // rust: .read_to_end(&mut out)
    // rust: .map_err(|e| e.to_string())?;
    // rust: Ok(Some(out))
}
    // rust: let toml = entry(MANIFEST)?.ok_or_else(|| format!("{MANIFEST}: missing"))?;
    // rust: let toml = String::from_utf8(toml).map_err(|_| format!("{MANIFEST}: not UTF-8"))?;
    // rust: (toml, entry(WASM)?)
}
    // rust: if wasm.as_ref().is_some_and(|w| w.len() as u64 > MAX_WASM) {
    // rust: return Err(format!("{WASM} is over {} MiB", MAX_WASM >> 20));
}
    // rust: let manifest = Manifest::parse(&toml)?;
    // rust: if wasm.is_none() && !manifest.capabilities.contains(&Capability::Registries) {
    // rust: return Err(format!(
    // rust: "{WASM}: missing (only a content mod, with capability registries, may have no code)"
    // rust: ));
}
    // rust: Ok(Package { manifest, wasm })
}
    // Whether the mod at `path` (a `.hmod` or a folder) has a [`MANIFEST`]: content, or a legacy
    // WebAssembly mod. A `.hmod` holding only native code has none.
has_manifest :: proc(path: ^Path) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if path.is_dir() {
    // rust: return path.join(MANIFEST).is_file();
}
    // rust: std::fs::File::open(path)
    // rust: .ok()
    // rust: .and_then(|f| zip::ZipArchive::new(f).ok())
    // rust: .is_some_and(|mut zip| zip.by_name(MANIFEST).is_ok())
}
    // The `.hmod` bytes for `manifest_text` and a component.
write :: proc(manifest_text: string, wasm: []u8) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Self::write_files(manifest_text, Some(wasm), &[])
}
    // The `.hmod` bytes for `manifest_text`, a component if the mod has
    // code, and content `files` (`assets/...`, `data/...`) by path.
    // rust: pub fn write_files(
    // rust: manifest_text: &str,
    // rust: wasm: Option<&[u8]>,
    // rust: files: &[(&str, &[u8])],
    // rust: ) -> Result<Vec<u8>, String> {
//         use std::io::Write;
    // rust: Manifest::parse(manifest_text)?;
    // rust: let mut zip = zip::ZipWriter::new(std::io::Cursor::new(Vec::new()));
    // rust: let options = zip::write::SimpleFileOptions::default();
    // rust: let err = |e: zip::result::ZipError| e.to_string();
    // rust: let mut put = |name: &str, bytes: &[u8]| -> Result<(), String> {
    // rust: zip.start_file(name, options).map_err(err)?;
    // rust: zip.write_all(bytes).map_err(|e| e.to_string())
}
    // rust: put(MANIFEST, manifest_text.as_bytes())?;
    // rust: if let Some(wasm) = wasm {
    // rust: put(WASM, wasm)?;
}
    // rust: for (name, bytes) in files {
    // rust: crate::content::check_path(name)?;
    // rust: put(name, bytes)?;
}
    // rust: Ok(zip.finish().map_err(err)?.into_inner())
}
}

// The `.hmod` files and mod folders in `dir`, by name.
find :: proc(dir: ^Path) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let Ok(read) = std::fs::read_dir(dir) else {
    // rust: return Vec::new();
}
    // rust: let mut found: Vec<PathBuf> = read
    // rust: .flatten()
    // rust: .map(|e| e.path())
    // rust: .filter(|p| p.extension().is_some_and(|e| e == "hmod") || p.join(MANIFEST).is_file())
    // rust: .collect();
    // rust: found.sort();
    // rust: found
}

    // rust: mod tests {
//     use super::*;

    // rust: const EXAMPLE: &str = r#"
    // rust: id = "coords_hud"
    // rust: name = "Coordinates HUD"
    // rust: version = "0.1.0"
    // rust: api = "0.1"
    // rust: capabilities = ["game-read", "hud"]
    // rust: "#;

parses_and_checks_imports :: proc() {
}
    // rust: let m = Manifest::parse(EXAMPLE).unwrap();
    // rust: assert_eq!(m.side, Side::Client);
    // rust: assert_eq!(m.capabilities, [Capability::GameRead, Capability::Hud]);
    // rust: let ok = [
    // rust: "horizon:mods/log@0.1.0",
    // rust: "horizon:mods/game@0.1.0",
    // rust: "horizon:mods/hud@0.1.2",
    // rust: ];
    // rust: assert_eq!(m.check_imports(ok), Ok(()));
    // rust: let chat = m.check_imports(["horizon:mods/chat@0.1.0"]);
    // rust: assert_eq!(
    // rust: chat,
    // rust: Err("uses capability chat, missing from horizon-mod.toml".into())
    // rust: );
    // rust: assert!(m.check_imports(["wasi:filesystem/types@0.2.0"]).is_err());
    // rust: assert!(m.check_imports(["horizon:mods/game@0.2.0"]).is_err());
    // rust: let storage = m.check_imports(["horizon:mods/storage@0.1.0"]);
    // rust: assert_eq!(
    // rust: storage,
    // rust: Err("uses capability storage, missing from horizon-mod.toml".into())
    // rust: );
    // rust: assert_eq!(
    // rust: m.check_imports(["horizon:mods/command@0.1.0"]),
    // rust: Err("uses capability command, missing from horizon-mod.toml".into())
    // rust: );
    // rust: let with_storage = EXAMPLE.replace("\"hud\"", "\"hud\", \"storage\"");
    // rust: let m = Manifest::parse(&with_storage).unwrap();
    // rust: assert_eq!(m.check_imports(["horizon:mods/storage@0.1.0"]), Ok(()));
}

refuses_bad_ids_and_apis :: proc() {
}
    // rust: let bad_id = EXAMPLE.replace("coords_hud", "Coords HUD");
    // rust: assert!(Manifest::parse(&bad_id).unwrap_err().contains("is not"));
    // rust: let bad_api = EXAMPLE.replace("api = \"0.1\"", "api = \"0.4\"");
    // rust: assert!(Manifest::parse(&bad_api).unwrap_err().contains("API 0.4"));
    // rust: let unknown = format!("{EXAMPLE}network = true\n");
    // rust: assert!(Manifest::parse(&unknown).is_err());
}

server_mods_are_api_0_3_with_server_capabilities :: proc() {
}
    // rust: let server = |api: &str, side: &str, caps: &str| {
    // rust: Manifest::parse(&format!(
    // rust: "id = \"w\"\nname = \"W\"\nversion = \"1\"\napi = \"{api}\"\nside = \"{side}\"\ncapabilities = [{caps}]\n"
    // rust: ))
}
    // rust: let m = server("0.3", "server", "\"players\", \"storage\"").unwrap();
    // rust: let imports = ["horizon:mods/players@0.1.0", "horizon:mods/storage@0.1.0"];
    // rust: assert_eq!(m.check_imports(imports), Ok(()));
    // rust: for (api, side) in [("0.3", "client"), ("0.3", "both"), ("0.1", "server")] {
    // rust: let e = server(api, side, "").unwrap_err();
    // rust: assert!(e.contains("a server mod is side"), "{e}");
}
    // rust: let e = server("0.3", "server", "\"hud\"").unwrap_err();
    // rust: assert!(e.contains("capability hud is for client mods"), "{e}");
    // rust: let e = server("0.1", "client", "\"players\"").unwrap_err();
    // rust: assert!(e.contains("capability players is for server mods"), "{e}");
}

checks_extra_namespaces :: proc() {
}
    // rust: let content = "id = \"t_and_t\"\nname = \"T\"\nversion = \"1\"\napi = \"0.2\"\ncapabilities = [\"registries\"]\n";
    // rust: let with = |list: &str| Manifest::parse(&format!("{content}namespaces = [{list}]\n"));
    // rust: let m = with("\"kaisyn\", \"towns_and_towers\"").unwrap();
    // rust: let owned: Vec<&str> = m.owned_namespaces().collect();
    // rust: assert_eq!(owned, ["t_and_t", "kaisyn", "towns_and_towers"]);
    // rust: for reserved in ["minecraft", "c", "horizon"] {
    // rust: let e = with(&format!("\"{reserved}\"")).unwrap_err();
    // rust: assert!(e.contains("not a mod's to claim"), "{e}");
}
    // rust: assert!(with("\"t_and_t\"").unwrap_err().contains("twice"));
    // rust: assert!(with("\"a\", \"a\"").unwrap_err().contains("twice"));
    // rust: assert!(with("\"Kaisyn\"").unwrap_err().contains("is not"));
    // rust: assert!(with("\"\"").unwrap_err().contains("is not"));
    // rust: let code = format!("{EXAMPLE}namespaces = [\"kaisyn\"]\n");
    // rust: assert!(Manifest::parse(&code).unwrap_err().contains("registries"));
}

hmod_round_trips :: proc() {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-mods-{}", std::process::id()));
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: let path = dir.join("coords_hud.hmod");
    // rust: std::fs::write(&path, Package::write(EXAMPLE, b"\0asm").unwrap()).unwrap();
    // rust: let p = Package::read(&path).unwrap();
    // rust: assert_eq!(p.manifest.id, "coords_hud");
    // rust: assert_eq!(p.wasm.as_deref(), Some(&b"\0asm"[..]));
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}

experimental_capabilities_need_the_opt_in :: proc() {
}
    // rust: let base = "id = \"m\"\nname = \"M\"\nversion = \"1\"\napi = \"0.1\"\n";
    // rust: let err = Manifest::parse(&format!("{base}capabilities = [\"ui\"]\n")).unwrap_err();
    // rust: assert!(err.contains("experimental = [\"ui\"]"), "{err}");
    // rust: let m = Manifest::parse(&format!(
    // rust: "{base}capabilities = [\"ui\"]\nexperimental = [\"ui\"]\n"
    // rust: ))
    // rust: .unwrap();
    // rust: assert_eq!(m.experimental, [Capability::Ui]);
        // A capability that is (or became) stable is fine in the list.
    // rust: Manifest::parse(&format!(
    // rust: "{base}capabilities = [\"hud\"]\nexperimental = [\"hud\"]\n"
    // rust: ))
    // rust: .unwrap();
}
}
