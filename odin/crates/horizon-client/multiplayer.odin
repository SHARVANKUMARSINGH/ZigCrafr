//! Transpiled from Horizon Rust crate
package horizon_client_multiplayer

import "core:fmt"
import "core:mem"
import "core:math"

// Multiplayer screens on the title: the server list (JoinMultiplayerScreen,
// stored in servers.dat), Add/Edit Server, Direct Connection, and the
// Disconnected screen. Entries are pinged in the background like
// ServerStatusPinger to show the MOTD, player count and latency.
// use crate::hud::{HudAtlas, HudBatch, rgba};
// use crate::lan::discovery::Scanner;
// use crate::text::{DARK_GRAY, GRAY, Text, format_translation};
// use crate::title::confirm_top;
// use horizon_protocol::servers::{self, ServerEntry};
// use std::{
    // rust: collections::HashMap,
    // rust: path::{Path, PathBuf},
    // rust: sync::{Arc, Mutex},
    // rust: time::{Duration, Instant},
}

SERVER_NAME :: ("server.name", 0)
SERVER_ADDRESS :: ("server.address", 0)
SERVER_DIRECT :: ("server.direct", 0)
FRIEND_CODE :: ("friend.code", 0)
FRIEND_RELAY :: ("friend.relay", 0)

// The result of pinging one address.
Ping :: enum {
    Pinging,
    Ok {,
        // The description component, styled (`sanitizeDescription`).
    motd: Text,
        // Online and max players; None when the status has no `players`.
    players: Option<(i64, i64)>,
        // `ServerData.playerList`: shown over the player count.
    player_list: Vec<Text>,
    ms: u128,
    version: String,
    // rust: },
    // `ServerData.State.INCOMPATIBLE`: the server answered, but not with this
    // game's protocol (or only to the legacy ping).
    Incompatible {,
    motd: Text,
    players: Option<(i64, i64)>,
    player_list: Vec<Text>,
        // `ServerData.version`, shown in red in place of the player count.
    version: Text,
    // rust: },
    Failed(String),
}
    // rust: impl Ping {
    // ServerStatusPinger.formatPlayerCount: dark grey with grey numbers,
    // or `multiplayer.status.unknown` without a player count.
player_count :: proc(players: Option<(i64) {
}
    // rust: match players {
    // rust: Some((online, max)) => Text::translate(
    // rust: "multiplayer.status.player_count",
    // rust: &[
    // rust: Text::colored(online.to_string(), GRAY),
    // rust: Text::colored(max.to_string(), GRAY),
    // rust: ],
    // rust: ),
    // rust: None => Text::translate("multiplayer.status.unknown", &[]),
}
    // rust: .with_color(DARK_GRAY)
}
}
// ServerStatusPinger: each sample name as a literal line (its `§` codes
// styled as the font does), then `multiplayer.status.and_more` for the
// players the sample leaves out.
player_list :: proc(players: ^serde_json::Value, online: i64) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let Some(sample) = players["sample"].as_array().filter(|s| !s.is_empty()) else {
    // rust: return Vec::new();
}
    // rust: let mut lines: Vec<Text> = sample
    // rust: .iter()
    // rust: .map(|p| Text::literal(p["name"].as_str().unwrap_or_default()).resolve_legacy())
    // rust: .collect();
    // rust: let shown = sample.len() as i64;
    // rust: if shown < online {
    // rust: lines.push(Text::translate(
    // rust: "multiplayer.status.and_more",
    // rust: &[Text::literal((online - shown).to_string())],
    // rust: ));
}
    // rust: lines
}
    // rust: type Pings = Arc<Mutex<HashMap<String, Ping>>>;
// Server icons by address as 64x64 RGBA (FaviconTexture), from servers.dat
// and then from each ping's favicon.
    // rust: type Icons = Arc<Mutex<HashMap<String, Arc<Vec<u8>>>>>;

Screen :: enum {
    List {,
    servers: Vec<ServerEntry>,
    selected: Option<usize>,
    pings: Pings,
    icons: Icons,
        // Worlds announced on the local network, listed after the servers.
    lan: Scanner,
    scroll: crate::ui::Scroll,
    // rust: },
    // Add (index None) or edit a server entry.
    Edit {,
    index: Option<usize>,
    name: String,
    address: String,
    focus: u8,
        // Server Resource Packs (`acceptTextures`): Enabled, Disabled, or
        // none for Prompt.
    packs: Option<bool>,
    // rust: },
    Direct {,
    address: String,
    // rust: },
    // ConfirmScreen for Delete: the list it returns to, the server's name
    // and how many lines the warning took when last drawn.
    ConfirmDelete {,
    list: Box<Screen>,
    name: String,
    lines: std::cell::Cell<usize>,
    // rust: },
    // Join a friend's world with its invite code (Horizon's own, behind the
    // title screen's Friends button).
    Friend {,
    code: String,
        // The relay for short codes (optional; saved on Join).
    relay: String,
    focus: u8,
    // rust: },
    Disconnected {,
    reason: String,
        // Auto-reconnect's next attempt, until it is cancelled.
    retry: Option<crate::reconnect::Retry>,
        // Wrapped reason lines, set by the last draw; the buttons sit below them.
    lines: std::cell::Cell<usize>,
    // rust: },
}
// What a click asks the title screen to do.
Outcome :: enum {
    None,
    Back,
    Connect { address: String, lan: bool },
}

// The job of [`Screen::buttons`]'s button `id`, for the controller.
button_action :: proc(id: u8) -> O {
    // Ported from Horizon
    return {}
}
//     use crate::widgets::Action;
    // rust: match id {
    // rust: 46 => Some(Action::Back),
    // rust: 50 => Some(Action::Done),
    // rust: 51 | 53 | 57 | 59 => Some(Action::Cancel),
    // rust: _ => None,
}
}

    // rust: impl Screen {
    // The id native mods see for this screen (`NativeScreenView.id`, the
    // screen hooks): one per variant, a hook's contract, so it stays the
    // same from release to release. A new variant must add one.
id :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::List { .. } => "multiplayer",
    // rust: Self::Edit { index: None, .. } => "add_server",
    // rust: Self::Edit { index: Some(_), .. } => "edit_server",
    // rust: Self::Direct { .. } => "direct_connect",
    // rust: Self::ConfirmDelete { .. } => "server_delete",
    // rust: Self::Friend { .. } => "friends_join",
    // rust: Self::Disconnected { .. } => "disconnected",
}
}
}

// A button: x, y, width, label, enabled, id.
    // rust: pub type ButtonSpec = (f32, f32, f32, String, bool, u8);

// `this.width / 2` (or `height / 2`): `Screen`'s size is an int, so the
// division drops the half and widgets stay on whole GUI pixels. A half
// pixel lands between device pixels and draws thinner borders and uneven
// glyphs at most window heights.
half :: proc(size: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: (size.ceil() / 2.0).floor()
}
// `this.height / 4`, as an int division.
quarter :: proc(size: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: (size.ceil() / 4.0).floor()
}
// `centeredText` around `width / 2`: `x - font.width(text) / 2`.
centered_x :: proc(width: f32, text_width: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: half(width) - half(text_width)
}

// The server list, beside `saves/`; with `--player-dir`, the player's own.
servers_file :: proc(saves: ^Path) -> P {
    // Ported from Horizon
    return {}
}
    // rust: servers_file_of(crate::logging::player_dir_override(), saves)
}

// [`servers_file`] for a given `--player-dir`.
servers_file_of :: proc(player: Maybe(^Path), saves: ^Path) -> P {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(player) = player {
    // rust: return player.join("servers.dat");
}
    // rust: saves
    // rust: .parent()
    // rust: .map_or_else(|| PathBuf::from("servers.dat"), |p| p.join("servers.dat"))
}
// `FaviconTexture.upload`: a PNG of exactly 64x64 pixels, else no icon.
icon_pixels :: proc(png: []u8) -> O {
    // Ported from Horizon
    return {}
}
    // rust: crate::hud::decode_bytes(png)
    // rust: .ok()
    // rust: .filter(|(w, h, _)| *w == 64 && *h == 64)
    // rust: .map(|(_, _, p)| Arc::new(p))
}
// `ServerStatus.Favicon.CODEC`: a base64 PNG behind the data URL prefix.
favicon_bytes :: proc(json: ^serde_json::Value) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let url = json["favicon"].as_str()?;
    // rust: let base64 = url
    // rust: .strip_prefix("data:image/png;base64,")?
    // rust: .replace('\n', "");
    // rust: crate::skins::base64_decode(&base64)
}
ping_all :: proc(servers: ^[ServerEntry], pings: ^Pings, icons: ^Icons, file: ^Path) {
}
    // rust: for s in servers {
    // rust: let address = s.ip.clone();
    // rust: pings.lock().unwrap().insert(address.clone(), Ping::Pinging);
    // rust: let saved = s.icon.clone();
    // rust: if let Some(pixels) = saved
    // rust: .as_deref()
    // rust: .and_then(crate::skins::base64_decode)
    // rust: .and_then(|png| icon_pixels(&png))
    // rust: {
    // rust: icons.lock().unwrap().insert(address.clone(), pixels);
}
    // rust: let (pings, icons, file) = (pings.clone(), icons.clone(), file.to_owned());
    // rust: let _ = std::thread::Builder::new()
    // rust: .name("horizon-ping".into())
    // rust: .spawn(move || {
    // rust: let result = match crate::net::ping(&address, Duration::from_secs(5)) {
    // rust: Ok((json, ms)) => {
    // rust: let motd = crate::component::to_text(&json["description"], &mut |s| {
    // rust: Text::literal(s)
    // rust: });
    // rust: let players = json["players"].as_object().map(|p| {
    // rust: (
    // rust: p.get("online").and_then(|n| n.as_i64()).unwrap_or(0),
    // rust: p.get("max").and_then(|n| n.as_i64()).unwrap_or(0),
    // rust: )
    // rust: });
    // rust: let player_list = players
    // rust: .map(|(online, _)| player_list(&json["players"], online))
    // rust: .unwrap_or_default();
    // rust: let version = json["version"]["name"].as_str().unwrap_or("?").to_owned();
                        // ServerStatus.version absent: `multiplayer.status.old`
                        // and protocol 0.
    // rust: let protocol = json["version"]["protocol"].as_i64().unwrap_or(0);
    // rust: let version_text = if json["version"].is_object() {
    // rust: Text::literal(version.clone())
    // rust: } else {
    // rust: Text::translate("multiplayer.status.old", &[])
}
                        // A new favicon replaces the saved one (an invalid one
                        // clears it) and servers.dat is saved again.
    // rust: if let Some(png) = favicon_bytes(&json) {
    // rust: let encoded = crate::lan::base64(&png);
    // rust: let pixels = icon_pixels(&png);
    // rust: match &pixels {
    // rust: Some(p) => icons.lock().unwrap().insert(address.clone(), p.clone()),
    // rust: None => icons.lock().unwrap().remove(&address),
}
    // rust: let icon = pixels.map(|_| encoded);
    // rust: if icon != saved {
    // rust: save_icon(&file, &address, icon);
}
}
                        // OnlineServerEntry: SUCCESSFUL only for this game's protocol.
    // rust: let joinable = protocol == i64::from(horizon_protocol::PROTOCOL_VERSION)
    // rust: || (crate::net::older_servers_enabled()
    // rust: && i32::try_from(protocol)
    // rust: .ok()
    // rust: .and_then(
    // rust: horizon_protocol::adapter::ServerVersion::from_protocol,
    // rust: )
    // rust: .is_some());
    // rust: if joinable {
    // rust: Ping::Ok {
    // rust: motd,
    // rust: players,
    // rust: player_list,
    // rust: ms,
    // rust: version,
}
    // rust: } else {
    // rust: Ping::Incompatible {
    // rust: motd,
    // rust: players,
    // rust: player_list,
    // rust: version: version_text,
}
}
}
                    // ClientStatusPacketListener.onDisconnect without a
                    // status: pingLegacyServer.
    // rust: Err(e) => match crate::net::ping_legacy(&address, Duration::from_secs(5)) {
    // rust: Ok(legacy) => Ping::Incompatible {
    // rust: motd: Text::literal(legacy.motd),
    // rust: players: Some((
    // rust: i64::from(legacy.players),
    // rust: i64::from(legacy.max_players),
    // rust: )),
    // rust: player_list: Vec::new(),
    // rust: version: Text::literal(legacy.version),
    // rust: },
    // rust: Err(_) => Ping::Failed(e),
    // rust: },
}
    // rust: pings.lock().unwrap().insert(address, result);
    // rust: });
}
}
// Save the list after a move or delete, keeping the icons pings stored in
// servers.dat since it was loaded, and the Code of Conduct accepted on a server.
save_servers :: proc(file: ^Path, servers: ^[ServerEntry]) {
}
    // rust: let _guard = SAVING.lock();
    // rust: let saved = servers::load(file);
    // rust: for entry in servers.iter_mut() {
    // rust: if let Some(s) = saved.iter().find(|s| s.ip == entry.ip) {
    // rust: entry.icon = s.icon.clone();
    // rust: entry.accepted_code_of_conduct = s.accepted_code_of_conduct;
}
}
    // rust: let _ = servers::save(file, servers);
}
// Held while servers.dat is read and written back.
SAVING :: Mutex::new(())
// Store `icon` on the entries for `address` (OnlineServerEntry.updateServerList).
save_icon :: proc(file: ^Path, address: string, icon: Maybe(string)) {
}
    // rust: let _guard = SAVING.lock();
    // rust: let mut list = servers::load(file);
    // rust: let mut changed = false;
    // rust: for entry in list.iter_mut().filter(|e| e.ip == address) {
    // rust: changed |= entry.icon != icon;
    // rust: entry.icon = icon.clone();
}
    // rust: if changed {
    // rust: let _ = servers::save(file, &list);
}
}

// `ClientPacketListener.handleServerData`: a valid icon the joined server
// sends replaces the one its list entries keep.
save_server_icon :: proc(saves: ^Path, address: string, png: []u8) {
}
    // rust: if icon_pixels(png).is_some() {
    // rust: save_icon(&servers_file(saves), address, Some(crate::lan::base64(png)));
}
}

// Horizon's official survival server: a name and an address like any entry. The address is
// `horizon_telemetry::server_status::OFFICIAL_ADDRESS`, the one place it is kept.
    // rust: pub const OFFICIAL_SERVER: (&str, &str) = (
    // rust: "Horizon Official",
    // rust: horizon_telemetry::server_status::OFFICIAL_ADDRESS,
    // rust: );
// Beside servers.dat once the official server was offered, so a player who
// deletes it never gets it back: the address offered, so a new one moves the
// list once. The launcher writes the same file.
OFFICIAL_MARKER :: "horizon_official_server.txt"

// An address as the game connects to it: any case, 25565 when no port is given.
address_key :: proc(ip: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: servers::parse_address(ip).map(|(h, p)| (h.to_ascii_lowercase(), p))
}

// Puts the official server at the top of the list in `game_dir`, once: not
// again after the player deletes it, and not when the list has its address.
// When it moved (the marker names another address), the entries for its
// earlier addresses move to the new one, once (`move_official`).
add_official_server :: proc(game_dir: ^Path) -> s {
    // Ported from Horizon
    return {}
}
    // rust: let (name, address) = OFFICIAL_SERVER;
    // rust: let marker = game_dir.join(OFFICIAL_MARKER);
    // A marker that is there but can't be read: offered already, at an address not known.
    // rust: let offered = match std::fs::read_to_string(&marker) {
    // rust: Ok(text) => Some(text),
    // rust: Err(e) if e.kind() == std::io::ErrorKind::NotFound => None,
    // rust: Err(_) => Some(String::new()),
}
    // rust: if offered
    // rust: .as_deref()
    // rust: .is_some_and(|a| address_key(a) == address_key(address))
    // rust: {
    // rust: return Ok(());
}
    // rust: let file = game_dir.join("servers.dat");
    // rust: let _guard = SAVING.lock();
    // rust: let mut list = servers::load(&file);
    // rust: let previous = horizon_telemetry::server_status::OFFICIAL_PREVIOUS;
    // rust: if move_official(&mut list, address, previous) {
    // rust: servers::save(&file, &list)?;
}
    // rust: if offered.is_none()
    // rust: && !list
    // rust: .iter()
    // rust: .any(|s| address_key(&s.ip) == address_key(address))
    // rust: {
    // rust: servers::prepend(&file, &ServerEntry::new(name, address))?;
}
    // rust: std::fs::write(marker, format!("{address}\n"))
}

// Servers Horizon partners with, offered once below the official server: a name (with the
// players it is for) and an address like any entry.
    // rust: pub const PARTNER_SERVERS: &[(&str, &str)] =
    // rust: &[("Afri-Network (South Africa)", "afri-network.co.za")];
// Beside servers.dat: the partner addresses already offered, one per line, so a player who
// deletes one never gets it back.
PARTNER_MARKER :: "horizon_partner_servers.txt"

// Adds each partner server not offered before to the list in `game_dir`, just below the
// official server (last when the list doesn't have it), unless the list has its address.
add_partner_servers :: proc(game_dir: ^Path) -> s {
    // Ported from Horizon
    return {}
}
    // rust: let marker = game_dir.join(PARTNER_MARKER);
    // rust: let offered = match std::fs::read_to_string(&marker) {
    // rust: Ok(text) => text,
    // rust: Err(e) if e.kind() == std::io::ErrorKind::NotFound => String::new(),
        // Can't tell what was offered: offer nothing rather than twice.
    // rust: Err(_) => return Ok(()),
}
    // rust: let was_offered = |a: &str| offered.lines().any(|l| address_key(l) == address_key(a));
    // rust: let new: Vec<_> = PARTNER_SERVERS
    // rust: .iter()
    // rust: .filter(|(_, a)| !was_offered(a))
    // rust: .collect();
    // rust: if new.is_empty() {
    // rust: return Ok(());
}
    // rust: let file = game_dir.join("servers.dat");
    // rust: let _guard = SAVING.lock();
    // Each new partner goes below the one before it, the first below the official server.
    // rust: let mut anchor = address_key(OFFICIAL_SERVER.1);
    // rust: for (name, address) in &new {
    // rust: if !servers::load(&file)
    // rust: .iter()
    // rust: .any(|s| address_key(&s.ip) == address_key(address))
    // rust: {
    // rust: servers::insert_after(&file, &ServerEntry::new(name, address), |ip| {
    // rust: address_key(ip) == anchor
    // rust: })?;
    // rust: anchor = address_key(address);
}
}
    // rust: let mut text = offered;
    // rust: for (_, address) in &new {
    // rust: text.push_str(address);
    // rust: text.push('\n');
}
    // rust: std::fs::write(marker, text)
}

// Points the entries for an earlier official address at `address`, each
// keeping the player's name and fields. One entry for the server at most: an
// old one goes when the list already has `address`. Whether anything changed.
move_official :: proc(list: ^[dynamic]ServerEntry, address: string, previous: ^[string]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let new = address_key(address);
    // rust: let old = |ip: &str| {
    // rust: let ip = address_key(ip);
    // rust: ip.is_some() && ip != new && previous.iter().any(|p| address_key(p) == ip)
}
    // rust: let mut present = list.iter().any(|s| address_key(&s.ip) == new);
    // rust: let mut changed = false;
    // rust: list.retain_mut(|s| {
    // rust: if !old(&s.ip) {
    // rust: return true;
}
    // rust: changed = true;
    // rust: if present {
    // rust: return false;
}
    // rust: present = true;
    // rust: s.ip = address.to_owned();
    // rust: true
    // rust: });
    // rust: changed
}

// The address and kind of list row `index`: saved servers, then discovered LAN games.
entry_address :: proc(servers: ^[ServerEntry], lan: ^Scanner, index: uint) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match servers.get(index) {
    // rust: Some(s) => Some((s.ip.clone(), false)),
    // rust: None => lan
    // rust: .games()
    // rust: .into_iter()
    // rust: .nth(index - servers.len())
    // rust: .map(|g| (g.address, true)),
}
}

// The Server Resource Packs button's label: `CommonComponents.optionNameValue`.
pack_setting_label :: proc(packs: Maybe(bool)) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let (key, fallback) = match packs {
    // rust: Some(true) => ("manageServer.resourcePack.enabled", "Enabled"),
    // rust: Some(false) => ("manageServer.resourcePack.disabled", "Disabled"),
    // rust: None => ("manageServer.resourcePack.prompt", "Prompt"),
}
    // rust: let name = crate::lang::get_or("manageServer.resourcePack", "Server Resource Packs");
    // rust: crate::lang::get_or("options.generic_value", "%s: %s")
    // rust: .replacen("%s", &name, 1)
    // rust: .replacen("%s", &crate::lang::get_or(key, fallback), 1)
}

// JoinMultiplayerScreen's `HeaderAndFooterLayout(33, 60)`.
HEADER :: 33.0
FOOTER :: 60.0
// ServerSelectionList: rows 305 wide and 36 high.
ROW_WIDTH :: 305.0
ROW_HEIGHT :: 36.0
// One row of the list: the saved servers, the LAN header, the LAN games.
Row :: enum {
    Server(usize),
    LanHeader,
    Lan(usize),
}
// The list's top and bottom and its rows' left edge (`getRowLeft`).
list_area :: proc(w: f32, h: f32) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: (
    // rust: HEADER,
    // rust: h - FOOTER,
    // rust: (w / 2.0).floor() - (ROW_WIDTH / 2.0).floor(),
    // rust: )
}
// `NetworkServerEntry.getServerNarration`: "LAN World" and the MOTD.
lan_narration :: proc(motd: string) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Text::empty()
    // rust: .append(Text::translate("lanServer.title", &[]))
    // rust: .append(Text::literal(" "))
    // rust: .append(Text::literal(motd))
}
rows :: proc(servers: uint, lan: uint) -> i {
    // Ported from Horizon
    return {}
}
    // rust: (0..servers)
    // rust: .map(Row::Server)
    // rust: .chain(std::iter::once(Row::LanHeader))
    // rust: .chain((0..lan).map(Row::Lan))
}
// `contentHeight`: the rows and 4 pixels of padding.
content_height :: proc(servers: uint, lan: uint) -> f {
    // Ported from Horizon
    return {}
}
    // rust: (servers + 1 + lan) as f32 * ROW_HEIGHT + 4.0
}
// The row under `(x, y)` (`getEntryAtPosition`), scrolled by `scroll`.
    // rust: fn row_at(
    // rust: servers: usize,
    // rust: lan: usize,
    // rust: (x, y): (f32, f32),
    // rust: size: (f32, f32),
    // rust: scroll: f32,
    // rust: ) -> Option<Row> {
    // rust: let (top, bottom, left) = list_area(size.0, size.1);
    // rust: if y < top || y >= bottom || x < left || x >= left + ROW_WIDTH {
    // rust: return None;
}
    // rust: let index = ((y - top - 2.0 + scroll.trunc()) / ROW_HEIGHT).floor();
    // rust: if index < 0.0 {
    // rust: return None;
}
    // rust: rows(servers, lan).nth(index as usize)
}
// SelectableEntry's hover areas over the 32-pixel icon, relative to it.
over_right_half :: proc(x: f32, y: f32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: (16.0..32.0).contains(&x) && (0.0..32.0).contains(&y)
}
over_top_left :: proc(x: f32, y: f32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: (0.0..16.0).contains(&x) && (0.0..16.0).contains(&y)
}
over_bottom_left :: proc(x: f32, y: f32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: (0.0..16.0).contains(&x) && (16.0..32.0).contains(&y)
}
// The server's favicon in icon slot `slot`, else `misc/unknown_server`.
    // rust: fn draw_server_icon(
    // rust: atlas: &HudAtlas,
    // rust: batch: &mut HudBatch,
    // rust: pixels: Option<&[u8]>,
    // rust: slot: usize,
    // rust: x: f32,
    // rust: y: f32,
    // rust: ) {
    // rust: let sprite = format!("horizon/world-icon{}", slot % crate::hud::WORLD_ICON_SLOTS);
    // rust: if let Some(pixels) = pixels
    // rust: && let Some(rect) = atlas.sprites.get(&sprite)
    // rust: {
    // rust: batch.patches.push(crate::font::Patch {
    // rust: x: (rect.u0 * atlas.width as f32).round() as u32,
    // rust: y: (rect.v0 * atlas.height as f32).round() as u32,
    // rust: width: 64,
    // rust: height: 64,
    // rust: rgba: pixels.to_vec(),
    // rust: });
    // rust: batch.sprite_scaled(atlas, &sprite, x, y, 32.0, 32.0, u32::MAX);
    // rust: } else {
    // rust: batch.sprite_scaled(atlas, "misc/unknown_server", x, y, 32.0, 32.0, u32::MAX);
}
}
// `LoadingDotsText.get`.
loading_dots :: proc(millis: u128) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: ["O o o", "o O o", "o o O", "o O o"][(millis / 300 % 4) as usize]
}

    // rust: fn ping_tooltip(
    // rust: servers: &[ServerEntry],
    // rust: pings: &HashMap<String, Ping>,
    // rust: size: (f32, f32),
    // rust: scroll: f32,
    // rust: cursor: (f32, f32),
    // rust: ) -> Option<Text> {
    // rust: let Row::Server(i) = row_at(servers.len(), 0, cursor, size, scroll)? else {
    // rust: return None;
}
    // rust: let (top, _, left) = list_area(size.0, size.1);
    // rust: let x = left + 2.0 + ROW_WIDTH - 4.0 - 15.0;
    // rust: let y = top + 4.0 - scroll.trunc() + i as f32 * ROW_HEIGHT;
    // rust: if cursor.0 < x || cursor.0 >= x + 10.0 || cursor.1 < y || cursor.1 >= y + 8.0 {
    // rust: return None;
}
    // rust: Some(match pings.get(&servers[i].ip) {
    // rust: Some(Ping::Ok { ms, .. }) => format_translation(
    // rust: &crate::lang::get_or("multiplayer.status.ping", "%s ms"),
    // rust: &[Text::literal(ms.to_string())],
    // rust: ),
    // rust: Some(Ping::Incompatible { .. }) => Text::literal(crate::lang::get_or(
    // rust: "multiplayer.status.incompatible",
    // rust: "Incompatible version!",
    // rust: )),
    // rust: Some(Ping::Failed(_)) => Text::literal(crate::lang::get_or(
    // rust: "multiplayer.status.no_connection",
    // rust: "(no connection)",
    // rust: )),
    // rust: _ => Text::literal(crate::lang::get_or(
    // rust: "multiplayer.status.pinging",
    // rust: "Pinging...",
    // rust: )),
    // rust: })
}
// OnlineServerEntry's player list, over the player count drawn left of
// the status icon; `width` measures that count.
    // rust: fn player_list_tooltip(
    // rust: servers: &[ServerEntry],
    // rust: pings: &HashMap<String, Ping>,
    // rust: size: (f32, f32),
    // rust: scroll: f32,
    // rust: cursor: (f32, f32),
    // rust: width: impl Fn(&Text) -> f32,
    // rust: ) -> Option<Vec<Text>> {
    // rust: let Row::Server(i) = row_at(servers.len(), 0, cursor, size, scroll)? else {
    // rust: return None;
}
    // rust: let (status, player_list) = match pings.get(&servers[i].ip)? {
    // rust: Ping::Ok {
    // rust: players,
    // rust: player_list,
    // rust: ..
    // rust: } => (Ping::player_count(*players), player_list),
    // rust: Ping::Incompatible {
    // rust: player_list,
    // rust: version,
    // rust: ..
    // rust: } => (version.clone().with_color(crate::text::RED), player_list),
    // rust: _ => return None,
}
    // rust: let (top, _, left) = list_area(size.0, size.1);
    // rust: let icon_x = left + 2.0 + ROW_WIDTH - 4.0 - 15.0;
    // rust: let y = top + 4.0 - scroll.trunc() + i as f32 * ROW_HEIGHT;
    // rust: let w = width(&status).ceil();
    // rust: let x = icon_x - w - 5.0;
    // rust: if cursor.0 < x || cursor.0 >= x + w || cursor.1 < y || cursor.1 >= y + 8.0 {
    // rust: return None;
}
    // rust: (!player_list.is_empty()).then(|| player_list.clone())
}

    // rust: impl Screen {
    // Draw after the list and footer so the tooltip is neither clipped nor covered.
draw_tooltip :: proc(self: ^Self, atlas: ^HudAtlas, batch: ^HudBatch, cursor: (f32) {
}
    // rust: let Self::List {
    // rust: servers,
    // rust: pings,
    // rust: lan,
    // rust: scroll,
    // rust: ..
    // rust: } = self
    // rust: else {
    // rust: return;
}
    // rust: let size = (batch.width.ceil(), batch.height.ceil());
    // rust: let (top, bottom, _) = list_area(size.0, size.1);
    // rust: let mut scroll = *scroll;
    // rust: scroll.clamp(
    // rust: top,
    // rust: bottom,
    // rust: content_height(servers.len(), lan.games().len()),
    // rust: );
    // rust: let pings = pings.lock().unwrap();
    // rust: let lines = match ping_tooltip(servers, &pings, size, scroll.amount, cursor) {
    // rust: Some(text) => vec![text],
    // rust: None => player_list_tooltip(servers, &pings, size, scroll.amount, cursor, |t| {
    // rust: atlas.font.width_text(t)
    // rust: })
    // rust: .unwrap_or_default(),
}
    // rust: crate::ui::tooltip(batch, atlas, &lines, cursor);
}

list :: proc(saves: ^Path) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let servers = servers::load(&servers_file(saves));
    // rust: let pings: Pings = Arc::default();
    // rust: let icons: Icons = Arc::default();
    // rust: ping_all(&servers, &pings, &icons, &servers_file(saves));
    // rust: Self::List {
    // rust: servers,
    // rust: selected: None,
    // rust: pings,
    // rust: icons,
    // rust: lan: Scanner::start(),
    // rust: scroll: crate::ui::Scroll::default(),
}
}
buttons :: proc(self: ^Self, w: f32, h: f32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let b = |x: f32, y: f32, bw: f32, label: &str, enabled: bool, id: u8| {
    // rust: (x, y, bw, label.to_owned(), enabled, id)
}
    // rust: match self {
            // JoinMultiplayerScreen's footer: two rows of buttons, 4 apart,
            // centred in the 60-pixel footer. Join needs a server or LAN game
            // selected (onSelectedChange), Edit and Delete a saved server.
    // rust: Self::List {
    // rust: servers, selected, ..
    // rust: } => {
    // rust: let (w, h) = (w.ceil(), h.ceil());
    // rust: let x = ((w - 308.0) / 2.0).floor();
    // rust: let saved = selected.is_some_and(|i| i < servers.len());
    // rust: let label = |key: &str, fallback: &str| crate::lang::get_or(key, fallback);
    // rust: vec![
    // rust: b(
    // rust: x,
    // rust: h - 52.0,
    // rust: 100.0,
    // rust: &label("selectServer.select", "Join Server"),
    // rust: selected.is_some(),
    // rust: 40,
    // rust: ),
    // rust: b(
    // rust: x + 104.0,
    // rust: h - 52.0,
    // rust: 100.0,
    // rust: &label("selectServer.direct", "Direct Connection"),
    // rust: true,
    // rust: 41,
    // rust: ),
    // rust: b(
    // rust: x + 208.0,
    // rust: h - 52.0,
    // rust: 100.0,
    // rust: &label("selectServer.add", "Add Server"),
    // rust: true,
    // rust: 42,
    // rust: ),
    // rust: b(
    // rust: x,
    // rust: h - 28.0,
    // rust: 74.0,
    // rust: &label("selectServer.edit", "Edit"),
    // rust: saved,
    // rust: 43,
    // rust: ),
    // rust: b(
    // rust: x + 78.0,
    // rust: h - 28.0,
    // rust: 74.0,
    // rust: &label("selectServer.delete", "Delete"),
    // rust: saved,
    // rust: 44,
    // rust: ),
    // rust: b(
    // rust: x + 156.0,
    // rust: h - 28.0,
    // rust: 74.0,
    // rust: &label("selectServer.refresh", "Refresh"),
    // rust: true,
    // rust: 45,
    // rust: ),
    // rust: b(
    // rust: x + 234.0,
    // rust: h - 28.0,
    // rust: 74.0,
    // rust: &label("gui.back", "Back"),
    // rust: true,
    // rust: 46,
    // rust: ),
    // rust: ]
}
    // rust: Self::Edit { address, packs, .. } => vec![
                // ManageServerScreen's CycleButton, above Done.
    // rust: b(
    // rust: half(w) - 100.0,
    // rust: quarter(h) + 72.0,
    // rust: 200.0,
    // rust: &pack_setting_label(*packs),
    // rust: true,
    // rust: 60,
    // rust: ),
    // rust: b(
    // rust: half(w) - 100.0,
    // rust: quarter(h) + 96.0 + 18.0,
    // rust: 200.0,
    // rust: &crate::lang::get_or("gui.done", "Done"),
    // rust: servers::parse_address(address).is_some(),
    // rust: 50,
    // rust: ),
    // rust: b(
    // rust: half(w) - 100.0,
    // rust: quarter(h) + 120.0 + 18.0,
    // rust: 200.0,
    // rust: &crate::lang::get_or("gui.cancel", "Cancel"),
    // rust: true,
    // rust: 51,
    // rust: ),
    // rust: ],
            // ConfirmScreen's two 150-wide buttons, 4 apart, under the message.
    // rust: Self::ConfirmDelete { lines, .. } => {
    // rust: let y = confirm_top(h, lines.get()) + 41.0 + lines.get() as f32 * 9.0;
    // rust: let x = (w.ceil() / 2.0).floor();
    // rust: vec![
    // rust: b(
    // rust: x - 152.0,
    // rust: y,
    // rust: 150.0,
    // rust: &crate::lang::get_or("selectServer.deleteButton", "Delete"),
    // rust: true,
    // rust: 58,
    // rust: ),
    // rust: b(
    // rust: x + 2.0,
    // rust: y,
    // rust: 150.0,
    // rust: &crate::lang::get_or("gui.cancel", "Cancel"),
    // rust: true,
    // rust: 59,
    // rust: ),
    // rust: ]
}
    // rust: Self::Direct { address } => vec![
    // rust: b(
    // rust: half(w) - 100.0,
    // rust: quarter(h) + 96.0 + 12.0,
    // rust: 200.0,
    // rust: &crate::lang::get_or("selectServer.select", "Join Server"),
    // rust: servers::parse_address(address).is_some(),
    // rust: 52,
    // rust: ),
    // rust: b(
    // rust: half(w) - 100.0,
    // rust: quarter(h) + 120.0 + 12.0,
    // rust: 200.0,
    // rust: &crate::lang::get_or("gui.cancel", "Cancel"),
    // rust: true,
    // rust: 53,
    // rust: ),
    // rust: ],
    // rust: Self::Friend { code, .. } => vec![
    // rust: b(
    // rust: half(w) - 100.0,
    // rust: quarter(h) + 96.0 + 18.0,
    // rust: 200.0,
    // rust: &crate::lang::get_or("horizon.multiplayer.join", "Join"),
    // rust: horizon_friends::invite::parse(code).is_some(),
    // rust: 56,
    // rust: ),
    // rust: b(
    // rust: half(w) - 100.0,
    // rust: quarter(h) + 120.0 + 18.0,
    // rust: 200.0,
    // rust: &crate::lang::get_or("gui.cancel", "Cancel"),
    // rust: true,
    // rust: 57,
    // rust: ),
    // rust: ],
    // rust: Self::Disconnected { retry, lines, .. } => {
    // rust: let btn = disconnected_layout(h, lines.get(), retry.is_some()).buttons;
    // rust: let mut v = vec![b(
    // rust: half(w) - 100.0,
    // rust: btn,
    // rust: 200.0,
    // rust: &crate::lang::get_or("gui.toMenu", "Back to Server List"),
    // rust: true,
    // rust: 54,
    // rust: )];
    // rust: if retry.is_some() {
    // rust: v.push(b(
    // rust: half(w) - 100.0,
    // rust: btn + 24.0,
    // rust: 200.0,
    // rust: &crate::lang::get_or(
    // rust: "horizon.multiplayer.cancel_reconnecting",
    // rust: "Cancel Reconnecting",
    // rust: ),
    // rust: true,
    // rust: 55,
    // rust: ));
}
    // rust: v
}
}
}
    // An EditBox and its label: the label at `label_y` (one pixel in, in
    // 0xA0A0A0), the 200x20 box at `box_y`. The box is the same `EditBox`
    // the world screens edit (`Caret`): cursor, selection and scrolling.
    // rust: fn field(
    // rust: atlas: &HudAtlas,
    // rust: batch: &mut HudBatch,
    // rust: caret: &mut crate::ui::Caret,
    // rust: focused_at: Instant,
    // rust: label: &str,
    // rust: value: &str,
    // rust: id: crate::clipboard::FieldId,
    // rust: max: usize,
    // rust: (label_y, box_y): (f32, f32),
    // rust: focused: bool,
    // rust: ) {
    // rust: let x = (batch.width.ceil() / 2.0).floor() - 100.0;
    // rust: batch.text(
    // rust: atlas,
    // rust: label,
    // rust: x + 1.0,
    // rust: label_y,
    // rust: rgba(160, 160, 160, 255),
    // rust: true,
    // rust: );
    // rust: caret.draw(
    // rust: batch,
    // rust: atlas,
    // rust: (id, value, max),
    // rust: [x, box_y, 200.0, 20.0],
    // rust: focused,
    // rust: focused_at,
    // rust: );
        // The box's message is its label.
    // rust: crate::widgets::name_last_edit_box(|| label.to_owned());
}
    // The screen as the narrator reads it: its id and `getNarrationMessage`.
narration :: proc(self: ^Self) -> c {
    // Ported from Horizon
    return {}
}
//         use crate::widgets::{ScreenInfo, join_for_narration as join};
    // rust: let get = crate::lang::get_or;
    // rust: match self {
    // rust: Self::List { .. } => {
    // rust: ScreenInfo::new("multiplayer", get("multiplayer.title", "Play Multiplayer"))
}
    // rust: Self::Edit { index, .. } => ScreenInfo::new(
    // rust: "multiplayer/edit",
    // rust: if index.is_some() {
    // rust: get("manageServer.edit.title", "Edit Server Info")
    // rust: } else {
    // rust: get("manageServer.add.title", "Add Server")
    // rust: },
    // rust: ),
    // rust: Self::Direct { .. } => ScreenInfo::new(
    // rust: "multiplayer/direct",
    // rust: get("selectServer.direct", "Direct Connection"),
    // rust: ),
            // ConfirmScreen: its title and its message.
    // rust: Self::ConfirmDelete { name, .. } => {
    // rust: let warning = format_translation(
    // rust: &get(
    // rust: "selectServer.deleteWarning",
    // rust: "'%s' will be lost forever! (A long time!)",
    // rust: ),
    // rust: &[Text::literal(name.clone())],
    // rust: );
    // rust: ScreenInfo::new(
    // rust: "multiplayer/delete",
    // rust: join(&[
    // rust: &get(
    // rust: "selectServer.deleteQuestion",
    // rust: "Are you sure you want to remove this server?",
    // rust: ),
    // rust: &warning.plain(),
    // rust: ]),
    // rust: )
}
    // rust: Self::Friend { .. } => ScreenInfo::new(
    // rust: "multiplayer/friend",
    // rust: get("horizon.multiplayer.join_friend", "Join a Friend"),
    // rust: ),
            // DisconnectedScreen: its title and the reason.
    // rust: Self::Disconnected { reason, .. } => ScreenInfo::new(
    // rust: "multiplayer/disconnected",
    // rust: join(&[&get("disconnect.lost", "Connection Lost"), reason]),
    // rust: ),
}
}
    // What button `id` narrates: Server Resource Packs is a CycleButton,
    // the others say their label.
    // rust: pub fn button_narration(
    // rust: &self,
    // rust: id: u8,
    // rust: rect: [f32; 4],
    // rust: label: &str,
    // rust: enabled: bool,
    // rust: ) -> crate::widgets::Narratable {
//         use crate::widgets::Narratable;
    // rust: match self {
    // rust: Self::Edit { packs, .. } if id == 60 => {
    // rust: let (key, fallback) = match packs {
    // rust: Some(true) => ("manageServer.resourcePack.disabled", "Disabled"),
    // rust: Some(false) => ("manageServer.resourcePack.prompt", "Prompt"),
    // rust: None => ("manageServer.resourcePack.enabled", "Enabled"),
}
    // rust: Narratable::cycle(label, crate::lang::get_or(key, fallback), rect, enabled)
}
    // rust: _ => Narratable::button(label, rect, enabled),
}
}
    // `OnlineServerEntry.getNarration`: the name, then its status.
server_narration :: proc(server: ^ServerEntry, ping: Maybe(^Ping)) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let t = |key: &str, args: &[&str]| crate::screen_narrator::translate(key, args);
    // rust: let mut parts = vec![t("narrator.select", &[&server.name])];
    // rust: match ping {
    // rust: Some(Ping::Ok {
    // rust: motd,
    // rust: players,
    // rust: player_list,
    // rust: ms,
    // rust: ..
    // rust: }) => {
    // rust: parts.push(t("multiplayer.status.online", &[]));
    // rust: parts.push(t("multiplayer.status.ping.narration", &[&ms.to_string()]));
    // rust: parts.push(t("multiplayer.status.motd.narration", &[&motd.plain()]));
    // rust: if let Some((online, max)) = players {
    // rust: parts.push(t(
    // rust: "multiplayer.status.player_count.narration",
    // rust: &[&online.to_string(), &max.to_string()],
    // rust: ));
    // rust: let names: Vec<String> = player_list.iter().map(Text::plain).collect();
    // rust: parts.push(names.join(", "));
}
}
    // rust: Some(Ping::Failed(_)) => parts.push(t("multiplayer.status.no_connection", &[])),
    // rust: _ => parts.push(t("multiplayer.status.pinging", &[])),
}
    // rust: let parts: Vec<&str> = parts.iter().map(String::as_str).collect();
    // rust: crate::widgets::join_for_narration(&parts)
}
    // rust: pub fn draw(
    // rust: &self,
    // rust: atlas: &HudAtlas,
    // rust: batch: &mut HudBatch,
    // rust: caret: &mut crate::ui::Caret,
    // rust: focused_at: Instant,
    // rust: cursor: (f32, f32),
    // rust: hide_address: bool,
    // rust: ) {
    // rust: let (w, h) = (batch.width, batch.height);
    // rust: let max = self.max_length();
    // rust: crate::widgets::begin_screen(|| self.narration());
    // rust: crate::ui::menu_background(batch, atlas, 0.0, 0.0, w, h, false);
        // GuiGraphicsExtractor.centeredText at width / 2: x - width(text) / 2.
    // rust: let centered = |batch: &mut HudBatch, text: &str, y: f32, color: u32| {
    // rust: let tw = HudBatch::text_width(atlas, text);
    // rust: batch.text(atlas, text, centered_x(w, tw), y, color, true);
}
    // rust: match self {
    // rust: Self::List {
    // rust: servers,
    // rust: selected,
    // rust: pings,
    // rust: icons,
    // rust: lan,
    // rust: scroll,
    // rust: } => {
    // rust: let (w, h) = (w.ceil(), h.ceil());
    // rust: let title = crate::lang::get_or("multiplayer.title", "Play Multiplayer");
                // The header's StringWidget, centred in its 33 pixels.
    // rust: let tw = HudBatch::text_width(atlas, &title);
    // rust: let tx = ((w - tw.ceil()) / 2.0).floor();
    // rust: batch.text(
    // rust: atlas,
    // rust: &title,
    // rust: tx,
    // rust: ((HEADER - 9.0) / 2.0).floor(),
    // rust: u32::MAX,
    // rust: true,
    // rust: );
    // rust: let games = lan.games();
    // rust: let (top, bottom, left) = list_area(w, h);
    // rust: let content = content_height(servers.len(), games.len());
    // rust: let mut scroll = *scroll;
    // rust: scroll.clamp(top, bottom, content);
                // AbstractSelectionList.extractWidgetRenderState: background,
                // the rows clipped to the list, separators, scrollbar.
    // rust: crate::ui::list_background(batch, atlas, top, bottom, false);
    // rust: let first = batch.vertices.len();
    // rust: let pings = pings.lock().unwrap();
    // rust: let icons = icons.lock().unwrap();
                // The row under the pointer (`isHovered`).
    // rust: let hovered = row_at(servers.len(), games.len(), cursor, (w, h), scroll.amount);
                // ServerSelectionList: the saved servers, the LAN header, the
                // LAN games; the row under the mouse, else the selected one.
    // rust: crate::widgets::narratable(|| {
//                     use crate::widgets::{ListKind, Narratable, Row as Narrated};
    // rust: let all: Vec<Row> = rows(servers.len(), games.len()).collect();
    // rust: let narrate = |i: usize| {
    // rust: let text = match all[i] {
    // rust: Row::Server(k) => {
    // rust: Self::server_narration(&servers[k], pings.get(&servers[k].ip))
}
    // rust: Row::LanHeader => crate::lang::get_or(
    // rust: "lanServer.scanning",
    // rust: "Scanning for games on your local network",
    // rust: ),
    // rust: Row::Lan(k) => crate::screen_narrator::translate(
    // rust: "narrator.select",
    // rust: &[&lan_narration(&games[k].motd).plain()],
    // rust: ),
}
    // rust: Narrated::new(i, text)
}
    // rust: let selected = selected.and_then(|s| {
    // rust: let row = if s < servers.len() {
    // rust: Row::Server(s)
    // rust: } else {
    // rust: Row::Lan(s - servers.len())
}
    // rust: all.iter().position(|r| *r == row)
    // rust: });
    // rust: Narratable::list(
    // rust: ListKind::Object,
    // rust: all.len(),
    // rust: hovered
    // rust: .and_then(|h| all.iter().position(|r| *r == h))
    // rust: .map(narrate),
    // rust: selected.map(narrate),
    // rust: [0.0, top, w, bottom - top],
    // rust: )
    // rust: .key(crate::widgets::key_of(&"multiplayer/servers"))
    // rust: });
    // rust: let millis = std::time::SystemTime::now()
    // rust: .duration_since(std::time::UNIX_EPOCH)
    // rust: .map_or(0, |d| d.as_millis());
    // rust: let gray = rgba(128, 128, 128, 255);
    // rust: for (i, row) in rows(servers.len(), games.len()).enumerate() {
    // rust: let y = top + 2.0 - scroll.amount.trunc() + i as f32 * ROW_HEIGHT;
    // rust: if y + ROW_HEIGHT < top || y > bottom {
    // rust: continue;
}
    // rust: let index = match row {
    // rust: Row::Server(k) => Some(k),
    // rust: Row::Lan(k) => Some(servers.len() + k),
    // rust: Row::LanHeader => None,
}
    // rust: if index.is_some()
    // rust: && y + ROW_HEIGHT / 2.0 > top
    // rust: && y + ROW_HEIGHT / 2.0 < bottom
    // rust: {
    // rust: let rect = [left, y, ROW_WIDTH, ROW_HEIGHT];
                        // The control socket's widget tree names the row.
    // rust: let name = match row {
    // rust: Row::Server(k) => servers[k].name.as_str(),
    // rust: Row::Lan(k) => games[k].motd.as_str(),
    // rust: Row::LanHeader => "",
}
    // rust: crate::widgets::record_as(name, rect, true, crate::widgets::Kind::Row);
    // rust: crate::widgets::target_as(rect, crate::widgets::Kind::Row);
}
                    // extractSelection: a white outline round black (the list
                    // has focus once a row is clicked).
    // rust: if index.is_some() && *selected == index {
    // rust: batch.fill(atlas, left, y, ROW_WIDTH, ROW_HEIGHT, u32::MAX);
    // rust: batch.fill(
    // rust: atlas,
    // rust: left + 1.0,
    // rust: y + 1.0,
    // rust: ROW_WIDTH - 2.0,
    // rust: ROW_HEIGHT - 2.0,
    // rust: rgba(0, 0, 0, 255),
    // rust: );
}
                    // Entry content: 2 pixels in from the row.
    // rust: let (cx, cy) = (left + 2.0, y + 2.0);
    // rust: match row {
    // rust: Row::Server(k) => {
    // rust: let server = &servers[k];
    // rust: let icon = icons.get(&server.ip);
    // rust: draw_server_icon(atlas, batch, icon.map(|p| p.as_slice()), i, cx, cy);
    // rust: batch.text(atlas, &server.name, cx + 35.0, cy + 1.0, u32::MAX, true);
                            // OnlineServerEntry: up to two lines of MOTD, the
                            // player count left of the status icon, all with
                            // GuiGraphics.text's shadow.
    // rust: let (motd, status, sprite) = match pings.get(&server.ip) {
    // rust: Some(Ping::Ok {
    // rust: motd, players, ms, ..
    // rust: }) => (
    // rust: motd.resolve_legacy(),
    // rust: Ping::player_count(*players),
    // rust: format!(
    // rust: "gui/sprites/server_list/ping_{}",
    // rust: match ms {
    // rust: 0..150 => 5,
    // rust: 150..300 => 4,
    // rust: 300..600 => 3,
    // rust: 600..1000 => 2,
    // rust: _ => 1,
}
    // rust: ),
    // rust: ),
    // rust: Some(Ping::Incompatible { motd, version, .. }) => (
    // rust: motd.resolve_legacy(),
    // rust: version.clone().with_color(crate::text::RED),
    // rust: "gui/sprites/server_list/incompatible".to_owned(),
    // rust: ),
    // rust: Some(Ping::Failed(_)) => (
    // rust: Text::translate("multiplayer.status.cannot_connect", &[])
    // rust: .with_color(0xFF0000),
    // rust: Text::empty(),
    // rust: "gui/sprites/server_list/unreachable".to_owned(),
    // rust: ),
    // rust: _ => {
                                    // The pinging bars bounce, offset by the row.
    // rust: let frame = (millis / 100 + i as u128 * 2) & 7;
    // rust: let frame = if frame > 4 { 8 - frame } else { frame };
    // rust: (
    // rust: Text::translate("multiplayer.status.pinging", &[]),
    // rust: Text::empty(),
    // rust: format!("gui/sprites/server_list/pinging_{}", frame + 1),
    // rust: )
}
}
    // rust: for (n, line) in atlas
    // rust: .font
    // rust: .split(&motd, ROW_WIDTH - 4.0 - 32.0 - 2.0)
    // rust: .iter()
    // rust: .take(2)
    // rust: .enumerate()
    // rust: {
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: line,
    // rust: cx + 35.0,
    // rust: cy + 12.0 + 9.0 * n as f32,
    // rust: gray,
    // rust: true,
    // rust: );
}
    // rust: let icon_x = cx + ROW_WIDTH - 4.0 - 15.0;
    // rust: batch.sprite_scaled(atlas, &sprite, icon_x, cy, 10.0, 8.0, u32::MAX);
    // rust: let sw = atlas.font.width_text(&status).ceil();
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: &status,
    // rust: icon_x - sw - 5.0,
    // rust: cy + 1.0,
    // rust: gray,
    // rust: true,
    // rust: );
                            // Hovering the row: the join arrow over the icon
                            // and the move arrows, each highlighted under
                            // the pointer.
    // rust: if hovered == Some(row) {
    // rust: let (rx, ry) = (cursor.0 - cx, cursor.1 - cy);
    // rust: batch.fill(atlas, cx, cy, 32.0, 32.0, 0xA0909090);
    // rust: for (sprite, shown, over) in [
    // rust: ("join", true, over_right_half(rx, ry)),
    // rust: ("move_up", k > 0, over_top_left(rx, ry)),
    // rust: ("move_down", k + 1 < servers.len(), over_bottom_left(rx, ry)),
    // rust: ] {
    // rust: if shown {
    // rust: let lit = if over { "_highlighted" } else { "" };
    // rust: batch.sprite_scaled(
    // rust: atlas,
    // rust: &format!("gui/sprites/server_list/{sprite}{lit}"),
    // rust: cx,
    // rust: cy,
    // rust: 32.0,
    // rust: 32.0,
    // rust: u32::MAX,
    // rust: );
}
}
}
}
    // rust: Row::LanHeader => {
                            // LANHeader's LoadingDotsWidget: the label, then
                            // the dots on its last line, both centred.
    // rust: let label = crate::lang::get_or(
    // rust: "lanServer.scanning",
    // rust: "Scanning for games on your local network",
    // rust: );
    // rust: let middle = cx + ((ROW_WIDTH - 4.0) / 2.0).floor();
    // rust: let lw = HudBatch::text_width(atlas, &label).ceil();
    // rust: let lx = middle - (lw / 2.0).floor();
    // rust: let centre = lx + (lw / 2.0).floor();
    // rust: batch.text(atlas, &label, lx, cy + 2.0, u32::MAX, false);
    // rust: let dots = loading_dots(millis);
    // rust: let dw = HudBatch::text_width(atlas, dots).ceil();
    // rust: batch.text(
    // rust: atlas,
    // rust: dots,
    // rust: centre - (dw / 2.0).floor(),
    // rust: cy + 28.0 - 9.0 - 2.0,
    // rust: gray,
    // rust: false,
    // rust: );
}
    // rust: Row::Lan(k) => {
    // rust: let game = &games[k];
    // rust: let header = crate::lang::get_or("lanServer.title", "LAN World");
    // rust: batch.text(atlas, &header, cx + 35.0, cy + 1.0, u32::MAX, false);
    // rust: batch.text(atlas, &game.motd, cx + 35.0, cy + 12.0, gray, false);
                            // NetworkServerEntry.extractContent: `hideServerAddress`
                            // draws HIDDEN_ADDRESS_TEXT in the address's place.
    // rust: let hidden;
    // rust: let address = if hide_address {
    // rust: hidden =
    // rust: crate::lang::get_or("selectServer.hiddenAddress", "(Hidden)");
    // rust: &hidden
    // rust: } else {
    // rust: &game.address
}
    // rust: batch.text(atlas, address, cx + 35.0, cy + 23.0, gray, false);
}
}
}
    // rust: batch.clip_since(first, 0.0, top, w, bottom);
    // rust: crate::ui::separators(batch, atlas, top, bottom, false);
    // rust: crate::ui::scrollbar(
    // rust: batch,
    // rust: atlas,
    // rust: left + ROW_WIDTH + 8.0,
    // rust: top,
    // rust: bottom,
    // rust: content,
    // rust: scroll.amount,
    // rust: );
}
    // rust: Self::Edit {
    // rust: index,
    // rust: name,
    // rust: address,
    // rust: focus,
    // rust: ..
    // rust: } => {
    // rust: centered(
    // rust: batch,
    // rust: &if index.is_some() {
    // rust: crate::lang::get_or("manageServer.edit.title", "Edit Server Info")
    // rust: } else {
    // rust: crate::lang::get_or("manageServer.add.title", "Add Server")
    // rust: },
    // rust: 17.0,
    // rust: u32::MAX,
    // rust: );
                // ManageServerScreen: labels at 53 and 94, boxes at 66 and 106.
    // rust: Self::field(
    // rust: atlas,
    // rust: batch,
    // rust: caret,
    // rust: focused_at,
    // rust: &crate::lang::get_or("manageServer.enterName", "Server Name"),
    // rust: name,
    // rust: SERVER_NAME,
    // rust: max,
    // rust: (53.0, 66.0),
    // rust: *focus == 0,
    // rust: );
    // rust: Self::field(
    // rust: atlas,
    // rust: batch,
    // rust: caret,
    // rust: focused_at,
    // rust: &crate::lang::get_or("manageServer.enterIp", "Server Address"),
    // rust: address,
    // rust: SERVER_ADDRESS,
    // rust: max,
    // rust: (94.0, 106.0),
    // rust: *focus == 1,
    // rust: );
}
    // rust: Self::Direct { address } => {
                // DirectJoinServerScreen: the title at 20, the label at 100
                // and the box at 116.
    // rust: centered(
    // rust: batch,
    // rust: &crate::lang::get_or("selectServer.direct", "Direct Connection"),
    // rust: 20.0,
    // rust: u32::MAX,
    // rust: );
    // rust: Self::field(
    // rust: atlas,
    // rust: batch,
    // rust: caret,
    // rust: focused_at,
    // rust: &crate::lang::get_or("manageServer.enterIp", "Server Address"),
    // rust: address,
    // rust: SERVER_DIRECT,
    // rust: max,
    // rust: (100.0, 116.0),
    // rust: true,
    // rust: );
}
    // rust: Self::ConfirmDelete { name, lines, .. } => {
                // ConfirmScreen: the title, then the message wrapped to
                // width - 50, centred as a block.
    // rust: let warning = format_translation(
    // rust: &crate::lang::get_or(
    // rust: "selectServer.deleteWarning",
    // rust: "'%s' will be lost forever! (A long time!)",
    // rust: ),
    // rust: &[Text::literal(name.clone())],
    // rust: );
    // rust: let message = atlas.font.split(&warning, (w.ceil() - 50.0).max(1.0));
    // rust: lines.set(message.len());
    // rust: let top = confirm_top(h, message.len());
    // rust: centered(
    // rust: batch,
    // rust: &crate::lang::get_or(
    // rust: "selectServer.deleteQuestion",
    // rust: "Are you sure you want to remove this server?",
    // rust: ),
    // rust: top,
    // rust: u32::MAX,
    // rust: );
    // rust: for (i, line) in message.iter().enumerate() {
    // rust: centered(batch, &line.plain(), top + 17.0 + i as f32 * 9.0, u32::MAX);
}
}
    // rust: Self::Friend { code, relay, focus } => {
    // rust: centered(
    // rust: batch,
    // rust: &crate::lang::get_or("horizon.multiplayer.join_friend", "Join a Friend"),
    // rust: 20.0,
    // rust: u32::MAX,
    // rust: );
    // rust: Self::field(
    // rust: atlas,
    // rust: batch,
    // rust: caret,
    // rust: focused_at,
    // rust: &crate::lang::get_or("horizon.multiplayer.invite_code", "Invite Code"),
    // rust: code,
    // rust: FRIEND_CODE,
    // rust: max,
    // rust: (53.0, 64.0),
    // rust: *focus == 0,
    // rust: );
    // rust: Self::field(
    // rust: atlas,
    // rust: batch,
    // rust: caret,
    // rust: focused_at,
    // rust: &crate::lang::get_or("horizon.multiplayer.relay", "Relay (optional)"),
    // rust: relay,
    // rust: FRIEND_RELAY,
    // rust: max,
    // rust: (94.0, 105.0),
    // rust: *focus == 1,
    // rust: );
}
    // rust: Self::Disconnected {
    // rust: reason,
    // rust: retry,
    // rust: lines,
    // rust: } => {
                // DisconnectedScreen: the reason wraps to width - 50.
    // rust: let wrapped = wrap(reason, (w.ceil() - 50.0).max(1.0), atlas);
    // rust: lines.set(wrapped.len());
    // rust: let l = disconnected_layout(h, wrapped.len(), retry.is_some());
    // rust: centered(
    // rust: batch,
    // rust: &crate::lang::get_or("disconnect.lost", "Connection Lost"),
    // rust: l.title,
    // rust: rgba(170, 170, 170, 255),
    // rust: );
    // rust: for (i, line) in wrapped.iter().enumerate() {
    // rust: centered(batch, line, l.message + i as f32 * 9.0, u32::MAX);
}
    // rust: if let Some(r) = retry {
    // rust: let text = r.text(std::time::Instant::now());
    // rust: centered(batch, &text, l.retry, rgba(170, 170, 170, 255));
}
}
}
}
    // `DirectJoinServerScreen.keyPressed`: Enter joins the typed address
    // while the Join Server button is active. On the server list it is
    // `ServerSelectionList.OnlineServerEntry.keyPressed`: Enter joins the
    // selected server or LAN game, as a click on it does.
confirm :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Direct { address } if servers::parse_address(address).is_some() => {
    // rust: Outcome::Connect {
    // rust: address: direct_address(address),
    // rust: lan: false,
}
}
    // rust: Self::List {
    // rust: servers,
    // rust: selected,
    // rust: lan,
    // rust: ..
    // rust: } => match selected.and_then(|i| entry_address(servers, lan, i)) {
    // rust: Some((address, lan)) => Outcome::Connect { address, lan },
    // rust: None => Outcome::None,
    // rust: },
    // rust: _ => Outcome::None,
}
}
    // rust: pub fn click(
    // rust: &mut self,
    // rust: id: Option<u8>,
    // rust: x: f32,
    // rust: y: f32,
    // rust: size: (f32, f32),
    // rust: saves: &Path,
    // rust: ) -> Outcome {
    // rust: let (w, h) = size;
    // rust: match (&mut *self, id) {
    // rust: (
    // rust: Self::List {
    // rust: servers,
    // rust: selected,
    // rust: lan,
    // rust: ..
    // rust: },
    // rust: Some(40),
    // rust: ) => {
    // rust: if let Some((address, lan)) = selected.and_then(|i| entry_address(servers, lan, i))
    // rust: {
    // rust: return Outcome::Connect { address, lan };
}
}
    // rust: (Self::List { .. }, Some(41)) => {
    // rust: *self = Self::Direct {
    // rust: address: String::new(),
}
}
    // rust: (Self::List { .. }, Some(47)) => *self = Self::friend(),
    // rust: (Self::List { .. }, Some(42)) => {
    // rust: *self = Self::Edit {
    // rust: index: None,
    // rust: name: crate::lang::get_or("selectServer.defaultName", "Minecraft Server"),
    // rust: address: String::new(),
    // rust: focus: 1,
    // rust: packs: None,
}
}
    // rust: (
    // rust: Self::List {
    // rust: servers, selected, ..
    // rust: },
    // rust: Some(43),
    // rust: ) => {
    // rust: if let Some((i, s)) = selected.and_then(|i| servers.get(i).map(|s| (i, s.clone())))
    // rust: {
    // rust: *self = Self::Edit {
    // rust: index: Some(i),
    // rust: name: s.name,
    // rust: address: s.ip,
    // rust: focus: 0,
    // rust: packs: s.accept_textures,
}
}
}
    // rust: (
    // rust: Self::List {
    // rust: servers, selected, ..
    // rust: },
    // rust: Some(44),
    // rust: ) => {
                // JoinMultiplayerScreen's Delete asks first (ConfirmScreen).
    // rust: if let Some(name) = selected
    // rust: .and_then(|i| servers.get(i))
    // rust: .map(|s| s.name.clone())
    // rust: {
    // rust: let list = std::mem::replace(
    // rust: self,
    // rust: Self::Direct {
    // rust: address: String::new(),
    // rust: },
    // rust: );
    // rust: *self = Self::ConfirmDelete {
    // rust: list: Box::new(list),
    // rust: name,
    // rust: lines: std::cell::Cell::new(1),
}
}
}
            // deleteCallback: yes removes the server and clears the
            // selection; either answer returns to the list as it was.
    // rust: (Self::ConfirmDelete { .. }, Some(id @ (58 | 59))) => {
    // rust: let Self::ConfirmDelete { list, .. } = std::mem::replace(
    // rust: self,
    // rust: Self::Direct {
    // rust: address: String::new(),
    // rust: },
    // rust: ) else {
    // rust: unreachable!()
}
    // rust: *self = *list;
    // rust: if id == 58
    // rust: && let Self::List {
    // rust: servers, selected, ..
    // rust: } = self
    // rust: && let Some(i) = selected.take()
    // rust: && i < servers.len()
    // rust: {
    // rust: servers.remove(i);
    // rust: save_servers(&servers_file(saves), servers);
}
}
    // rust: (Self::List { .. }, Some(45)) => *self = Self::list(saves),
    // rust: (Self::List { .. }, Some(46)) => return Outcome::Back,
    // rust: (
    // rust: Self::List {
    // rust: servers,
    // rust: selected,
    // rust: lan,
    // rust: scroll,
    // rust: ..
    // rust: },
    // rust: None,
    // rust: ) => {
    // rust: let (w, h) = (w.ceil(), h.ceil());
    // rust: let games = lan.games().len();
    // rust: let (top, bottom, left) = list_area(w, h);
    // rust: let content = content_height(servers.len(), games);
    // rust: if scroll.press((x, y), left + ROW_WIDTH + 8.0, top, bottom, content) {
    // rust: return Outcome::None;
}
    // rust: let row = row_at(servers.len(), games, (x, y), (w, h), scroll.amount);
                // OnlineServerEntry.mouseClicked: the icon's right half joins,
                // its left quarters move the server up or down (and keep it
                // selected).
    // rust: if let Some(Row::Server(k)) = row {
    // rust: let row_top = top + 2.0 - scroll.amount.trunc() + k as f32 * ROW_HEIGHT;
    // rust: let (rx, ry) = ((x - left - 2.0).floor(), (y - row_top - 2.0).floor());
    // rust: if over_right_half(rx, ry) {
    // rust: *selected = Some(k);
    // rust: return Outcome::Connect {
    // rust: address: servers[k].ip.clone(),
    // rust: lan: false,
}
}
    // rust: let to = if k > 0 && over_top_left(rx, ry) {
    // rust: Some(k - 1)
    // rust: } else if k + 1 < servers.len() && over_bottom_left(rx, ry) {
    // rust: Some(k + 1)
    // rust: } else {
    // rust: None
}
    // rust: if let Some(to) = to {
    // rust: servers.swap(k, to);
    // rust: save_servers(&servers_file(saves), servers);
    // rust: *selected = Some(to);
    // rust: return Outcome::None;
}
}
                // Clicking a selected row again joins it; the LAN header
                // takes the click without anything to join.
    // rust: let index = match row {
    // rust: Some(Row::Server(k)) => Some(k),
    // rust: Some(Row::Lan(k)) => Some(servers.len() + k),
    // rust: Some(Row::LanHeader) => {
    // rust: *selected = None;
    // rust: None
}
    // rust: None => None,
}
    // rust: if let Some(index) = index
    // rust: && let Some((address, lan)) = entry_address(servers, lan, index)
    // rust: {
    // rust: if *selected == Some(index) {
    // rust: return Outcome::Connect { address, lan };
}
    // rust: *selected = Some(index);
}
}
            // CycleButton: Enabled, Disabled, Prompt, and round again.
    // rust: (Self::Edit { packs, .. }, Some(60)) => {
    // rust: *packs = match *packs {
    // rust: Some(true) => Some(false),
    // rust: Some(false) => None,
    // rust: None => Some(true),
}
}
    // rust: (
    // rust: Self::Edit {
    // rust: index,
    // rust: name,
    // rust: address,
    // rust: packs,
    // rust: ..
    // rust: },
    // rust: Some(50),
    // rust: ) => {
    // rust: let mut list = servers::load(&servers_file(saves));
    // rust: let mut entry = ServerEntry::new(name.trim(), address.trim());
    // rust: entry.accept_textures = *packs;
    // rust: match index.and_then(|i| list.get_mut(i)) {
    // rust: Some(e) => {
    // rust: e.name = entry.name;
    // rust: e.ip = entry.ip;
    // rust: e.accept_textures = entry.accept_textures;
}
    // rust: None => list.push(entry),
}
    // rust: let _ = servers::save(&servers_file(saves), &list);
    // rust: *self = Self::list(saves);
}
    // rust: (
    // rust: Self::Edit { .. }
    // rust: | Self::Direct { .. }
    // rust: | Self::Friend { .. }
    // rust: | Self::Disconnected { .. },
    // rust: Some(51 | 53 | 54 | 57),
    // rust: ) => *self = Self::list(saves),
    // rust: (Self::Disconnected { retry, .. }, Some(55)) => *retry = None,
    // rust: (Self::Direct { address }, Some(52)) => {
    // rust: return Outcome::Connect {
    // rust: address: direct_address(address),
    // rust: lan: false,
}
}
    // rust: (Self::Friend { code, relay, .. }, Some(56)) => {
    // rust: if horizon_friends::invite::parse(code).is_some() {
    // rust: crate::net::save_friends_relay(relay.trim());
    // rust: let code: String = code.chars().filter(|c| !c.is_whitespace()).collect();
    // rust: return Outcome::Connect {
    // rust: address: format!("{}{code}", crate::net::FRIEND),
    // rust: lan: false,
}
}
}
    // rust: (Self::Edit { .. } | Self::Friend { .. }, None) => {
    // rust: let boxes = if matches!(self, Self::Edit { .. }) {
    // rust: [66.0, 106.0]
    // rust: } else {
    // rust: [64.0, 105.0]
}
    // rust: let (Self::Edit { focus, .. } | Self::Friend { focus, .. }) = self else {
    // rust: unreachable!()
}
    // rust: for (i, fy) in [(0u8, boxes[0]), (1, boxes[1])] {
    // rust: if y >= fy && y < fy + 20.0 && (half(w) - 100.0..half(w) + 100.0).contains(&x) {
    // rust: *focus = i;
}
}
}
    // rust: _ => {}
}
    // rust: Outcome::None
}
    // The mouse wheel over the server list (`scrollRate`: half a row).
    // Up or Down on the list (`AbstractSelectionList.nextEntry`): the next
    // server or LAN game, the first (Down) or last (Up) with none selected, and
    // none past the ends. With Shift a saved server swaps with its neighbour
    // (`OnlineServerEntry.keyPressed`) and stays selected. False when the screen
    // is not the list or has no entries.
arrow :: proc(self: ^Self, up: bool, shift: bool, size: (f32) {
}
    // rust: let Self::List {
    // rust: servers,
    // rust: selected,
    // rust: lan,
    // rust: scroll,
    // rust: ..
    // rust: } = self
    // rust: else {
    // rust: return false;
}
    // rust: let total = servers.len() + lan.games().len();
    // rust: if total == 0 {
    // rust: return false;
}
    // rust: let next = match *selected {
    // rust: Some(k) if shift => {
                // A LAN game has no place to move to.
    // rust: let to = if up { k.checked_sub(1) } else { Some(k + 1) };
    // rust: if let Some(to) = to.filter(|&to| k < servers.len() && to < servers.len()) {
    // rust: servers.swap(k, to);
    // rust: save_servers(&servers_file(saves), servers);
    // rust: Some(to)
    // rust: } else {
    // rust: Some(k)
}
}
    // rust: Some(k) if up => Some(k.saturating_sub(1)),
    // rust: Some(k) => Some((k + 1).min(total - 1)),
    // rust: None if shift => None,
    // rust: None => Some(if up { total - 1 } else { 0 }),
}
    // rust: *selected = next;
    // rust: if let Some(k) = next {
            // scrollToEntry: the row, with the LAN header between the servers
            // and the games, into view.
    // rust: let row = if k < servers.len() { k } else { k + 1 };
    // rust: let (top, bottom, _) = list_area(size.0.ceil(), size.1.ceil());
    // rust: let content = content_height(servers.len(), lan.games().len());
    // rust: let (row_top, view) = (2.0 + row as f32 * ROW_HEIGHT, bottom - top);
    // rust: if row_top < scroll.amount {
    // rust: scroll.amount = row_top;
    // rust: } else if row_top + ROW_HEIGHT > scroll.amount + view {
    // rust: scroll.amount = row_top + ROW_HEIGHT - view;
}
    // rust: scroll.clamp(top, bottom, content);
}
    // rust: true
}
wheel :: proc(self: ^Self, delta: f32, cursor: (f32) {
}
    // rust: if let Self::List {
    // rust: servers,
    // rust: lan,
    // rust: scroll,
    // rust: ..
    // rust: } = self
    // rust: {
    // rust: let (top, bottom, _) = list_area(size.0.ceil(), size.1.ceil());
    // rust: if cursor.1 >= top && cursor.1 < bottom {
    // rust: let content = content_height(servers.len(), lan.games().len());
    // rust: scroll.wheel(delta, ROW_HEIGHT / 2.0, top, bottom, content);
}
}
}
    // The pointer moved: a held scrollbar follows it.
drag :: proc(self: ^Self, y: f32, size: (f32) {
}
    // rust: if let Self::List {
    // rust: servers,
    // rust: lan,
    // rust: scroll,
    // rust: ..
    // rust: } = self
    // rust: {
    // rust: let (top, bottom, _) = list_area(size.0.ceil(), size.1.ceil());
    // rust: scroll.drag(
    // rust: y,
    // rust: top,
    // rust: bottom,
    // rust: content_height(servers.len(), lan.games().len()),
    // rust: );
}
}
release :: proc(self: ^Self) {
}
    // rust: if let Self::List { scroll, .. } = self {
    // rust: scroll.release();
}
}
    // The focused box, in GUI pixels: name at 66, address at 106
    // (`ManageServerScreen`), direct address at 116, friend fields at 64 and 105.
focused_box :: proc(self: ^Self) {
}
    // rust: let y = match self {
    // rust: Self::Edit { focus: 0, .. } => 66.0,
    // rust: Self::Edit { focus: 1, .. } => 106.0,
    // rust: Self::Edit { .. } => return None,
    // rust: Self::Direct { .. } => 116.0,
    // rust: Self::Friend { focus: 0, .. } => 64.0,
    // rust: Self::Friend { focus: 1, .. } => 105.0,
    // rust: Self::Friend { .. } => return None,
    // rust: _ => return None,
}
    // rust: Some([(w / 2.0).floor() - 100.0, y, 200.0, 20.0])
}
focused_field :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Edit {
    // rust: name,
    // rust: address,
    // rust: focus,
    // rust: ..
    // rust: } => match *focus {
    // rust: 0 => Some(name),
    // rust: 1 => Some(address),
                // A button has the focus.
    // rust: _ => None,
    // rust: },
    // rust: Self::Direct { address } => Some(address),
    // rust: Self::Friend {
    // rust: code, relay, focus, ..
    // rust: } => match *focus {
    // rust: 0 => Some(code),
    // rust: 1 => Some(relay),
    // rust: _ => None,
    // rust: },
    // rust: _ => None,
}
}
    // Join a friend, with the relay the player set before.
friend :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::Friend {
    // rust: code: String::new(),
    // rust: relay: crate::net::friends_relay_setting().unwrap_or_default(),
    // rust: focus: 0,
}
}
    // Auto-reconnect's attempt, once its countdown is over.
due_retry :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let Self::Disconnected { retry, .. } = self else {
    // rust: return None;
}
    // rust: if !retry.as_ref()?.due(std::time::Instant::now()) {
    // rust: return None;
}
    // rust: retry.take()
}
    // `ServerSelectionList.updateNetworkServers`' narration: for each LAN
    // world found since the last call whose row is in the list's view,
    // `multiplayer.lan.server_found` with its `getServerNarration`.
lan_found_narrations :: proc(self: ^Self) {
}
    // rust: let Self::List {
    // rust: servers,
    // rust: lan,
    // rust: scroll,
    // rust: ..
    // rust: } = self
    // rust: else {
    // rust: return Vec::new();
}
    // rust: let found = lan.take_found();
    // rust: if found.is_empty() {
    // rust: return Vec::new();
}
    // rust: let (top, bottom, _) = list_area(w.ceil(), h.ceil());
    // rust: let mut scroll = *scroll;
    // rust: scroll.clamp(
    // rust: top,
    // rust: bottom,
    // rust: content_height(servers.len(), lan.games().len()),
    // rust: );
    // rust: found
    // rust: .into_iter()
    // rust: .filter(|(k, _)| {
                // getRowTop / getRowBottom of the entry after the servers and
                // the LAN header.
    // rust: let row = (servers.len() + 1 + k) as f32;
    // rust: let row_top = top + 2.0 - scroll.amount.trunc() + row * ROW_HEIGHT;
    // rust: row_top + ROW_HEIGHT >= top && row_top <= bottom
    // rust: })
    // rust: .map(|(_, game)| {
    // rust: Text::translate("multiplayer.lan.server_found", &[lan_narration(&game.motd)])
    // rust: })
    // rust: .collect()
}
    // The focused text field, its id and maximum length (copy and paste).
focused_text :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let id = match self {
    // rust: Self::Edit { focus: 0, .. } => SERVER_NAME,
    // rust: Self::Edit { .. } => SERVER_ADDRESS,
    // rust: Self::Direct { .. } => SERVER_DIRECT,
    // rust: Self::Friend { focus: 0, .. } => FRIEND_CODE,
    // rust: Self::Friend { .. } => FRIEND_RELAY,
    // rust: _ => return None,
}
    // rust: let max = self.max_length();
    // rust: self.focused_field().map(|f| (id, f, max))
}
    // Invite codes with IPv6 and a relay run past a server address's 128.
max_length :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: if matches!(self, Self::Friend { .. }) {
    // rust: 256
    // rust: } else {
    // rust: 128
}
}
    // Tab (`reverse`: Shift+Tab) through the focus order of `ManageServerScreen`
    // and the friend screen: the text fields, then the enabled `buttons`, then
    // round to the first field. `button` is the focused button, if any; a field
    // has the focus (`focus` below 2) only while no button does.
tab_dir :: proc(self: ^Self, reverse: bool, buttons: []u8, button: ^Maybe(u8)) {
}
    // rust: let (Self::Edit { focus, .. } | Self::Friend { focus, .. }) = self else {
    // rust: return;
}
    // rust: let stops = 2 + buttons.len();
    // rust: let at = match *button {
    // rust: Some(id) => buttons.iter().position(|&b| b == id).map(|i| 2 + i),
    // rust: None => Some(usize::from(*focus).min(1)),
}
    // rust: .unwrap_or(0);
    // rust: let next = if reverse {
    // rust: (at + stops - 1) % stops
    // rust: } else {
    // rust: (at + 1) % stops
}
    // rust: if next < 2 {
    // rust: *focus = next as u8;
    // rust: *button = None;
    // rust: } else {
    // rust: *focus = 2;
    // rust: *button = Some(buttons[next - 2]);
}
}
    // Escape: back to the list, or out of it (true).
escape :: proc(self: ^Self, saves: ^Path) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::List { .. } => true,
            // ConfirmScreen.keyPressed: Escape answers no.
    // rust: Self::ConfirmDelete { list, .. } => {
    // rust: let list = std::mem::replace(
    // rust: &mut **list,
    // rust: Self::Direct {
    // rust: address: String::new(),
    // rust: },
    // rust: );
    // rust: *self = list;
    // rust: false
}
    // rust: _ => {
    // rust: *self = Self::list(saves);
    // rust: false
}
}
}
}

// Direct Connection's address; a full invite code pasted there joins the
// friend (a short relay code could be a host name, so it needs Join a Friend).
direct_address :: proc(address: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let code: String = address.chars().filter(|c| !c.is_whitespace()).collect();
    // rust: if matches!(
    // rust: horizon_friends::invite::parse(&code),
    // rust: Some(horizon_friends::invite::Parsed::Long(_))
    // rust: ) {
    // rust: format!("{}{code}", crate::net::FRIEND)
    // rust: } else {
    // rust: address.trim().to_owned()
}
}
// Y positions on the disconnect screen.
DisconnectedLayout :: struct {
    title: f32,
    message: f32,
    retry: f32,
    buttons: f32,
}
// `DisconnectedScreen.init`: a vertical layout centred on the screen. The
// title and message cells pad 10 on each side, the buttons 2; the message
// is `lines` rows of 9, so the buttons always sit below it.
disconnected_layout :: proc(h: f32, lines: uint, retry: bool) -> D {
    // Ported from Horizon
    return {}
}
    // rust: let message_h = lines as f32 * 9.0 + 20.0;
    // rust: let retry_h = if retry { 13.0 } else { 0.0 };
    // rust: let buttons = if retry { 48.0 } else { 24.0 };
    // rust: let top = half(h - (29.0 + message_h + retry_h + buttons));
    // rust: DisconnectedLayout {
    // rust: title: top + 10.0,
    // rust: message: top + 39.0,
    // rust: retry: top + 29.0 + message_h + 2.0,
    // rust: buttons: top + 29.0 + message_h + retry_h + 2.0,
}
}

// Greedy word wrap to a pixel width.
wrap :: proc(text: string, width: f32, atlas: ^HudAtlas) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut lines = Vec::new();
    // rust: for paragraph in text.lines() {
    // rust: let mut line = String::new();
    // rust: for word in paragraph.split(' ') {
    // rust: let candidate = if line.is_empty() {
    // rust: word.to_owned()
    // rust: } else {
    // rust: format!("{line} {word}")
}
    // rust: if HudBatch::text_width(atlas, &candidate) > width && !line.is_empty() {
    // rust: lines.push(std::mem::take(&mut line));
    // rust: line = word.to_owned();
    // rust: } else {
    // rust: line = candidate;
}
}
    // rust: lines.push(line);
}
    // rust: lines
}

    // rust: mod tests {
//     use super::*;

servers_dat_is_beside_saves_or_in_the_player_dir :: proc() {
}
    // rust: let saves = Path::new("/games/shared/saves");
    // rust: assert_eq!(
    // rust: servers_file_of(None, saves),
    // rust: Path::new("/games/shared/servers.dat")
    // rust: );
    // rust: assert_eq!(
    // rust: servers_file_of(Some(Path::new("/games/players/alex")), saves),
    // rust: Path::new("/games/players/alex/servers.dat")
    // rust: );
}

only_discovered_entries_get_lan_authentication :: proc() {
}
    // rust: let address = "127.0.0.1:25565";
    // rust: let mut screen = Screen::List {
    // rust: servers: vec![ServerEntry::new("Saved", address)],
    // rust: selected: Some(0),
    // rust: pings: Arc::default(),
    // rust: icons: Arc::default(),
    // rust: lan: Scanner::for_tests(vec![crate::lan::discovery::LanGame {
    // rust: motd: "LAN".into(),
    // rust: address: address.into(),
    // rust: }]),
    // rust: scroll: Default::default(),
}
    // rust: for (index, expected_lan) in [(0, false), (1, true)] {
    // rust: if let Screen::List { selected, .. } = &mut screen {
    // rust: *selected = Some(index);
}
    // rust: let Outcome::Connect {
    // rust: address: actual,
    // rust: lan,
    // rust: } = screen.click(Some(40), 0.0, 0.0, (640.0, 480.0), Path::new(""))
    // rust: else {
    // rust: panic!("join did not connect")
}
    // rust: assert_eq!(actual, address);
    // rust: assert_eq!(lan, expected_lan);
}
    // rust: let direct = Screen::Direct {
    // rust: address: address.into(),
}
    // rust: assert!(matches!(
    // rust: direct.confirm(),
    // rust: Outcome::Connect { lan: false, .. }
    // rust: ));
}

direct_connection_joins_a_pasted_invite_and_keeps_host_names :: proc() {
}
    // rust: let invite = horizon_friends::invite::Invite {
    // rust: secret: *b"0123456789",
    // rust: port: 25580,
    // rust: endpoints: vec!["192.168.1.20:25580".parse().unwrap()],
    // rust: relay: None,
}
    // rust: .encode();
    // rust: assert_eq!(
    // rust: direct_address(&format!(" {invite} ")),
    // rust: format!("{}{invite}", crate::net::FRIEND)
    // rust: );
    // rust: for host in ["localhost", "example.org:25566", "abcdefgh", "[::1]:25568"] {
    // rust: assert_eq!(direct_address(host), host);
}
}

ping_tooltip_follows_only_visible_status_bars_and_current_ping :: proc() {
}
    // rust: let servers: Vec<_> = (0..6)
    // rust: .map(|i| ServerEntry::new("Test", &format!("server{i}")))
    // rust: .collect();
    // rust: let mut pings = HashMap::new();
    // rust: let size = (427.0, 240.0);
    // rust: let hover = |pings: &HashMap<String, Ping>, scroll, cursor| {
    // rust: ping_tooltip(&servers, pings, size, scroll, cursor).map(|t| t.plain())
}
        // The first bar is at (349, 37), with a 10 by 8 hit area.
    // rust: assert_eq!(
    // rust: hover(&pings, 0.0, (349.0, 37.0)).as_deref(),
    // rust: Some("Pinging...")
    // rust: );
    // rust: pings.insert(
    // rust: "server0".into(),
    // rust: Ping::Ok {
    // rust: motd: Text::empty(),
    // rust: players: None,
    // rust: player_list: Vec::new(),
    // rust: ms: 42,
    // rust: version: String::new(),
    // rust: },
    // rust: );
    // rust: assert_eq!(hover(&pings, 0.0, (358.9, 44.9)).as_deref(), Some("42 ms"));
    // rust: pings.insert("server1".into(), Ping::Pinging);
    // rust: for cursor in [
    // rust: (348.9, 37.0),
    // rust: (359.0, 37.0),
    // rust: (349.0, 36.9),
    // rust: (349.0, 45.0),
    // rust: (100.0, 40.0),
    // rust: (349.0, 32.0),
    // rust: (349.0, 181.0),
    // rust: ] {
    // rust: assert!(hover(&pings, 0.0, cursor).is_none(), "{cursor:?}");
}
        // Scrolling moves the next row's bars into the same location.
    // rust: assert_eq!(
    // rust: hover(&pings, 36.0, (349.0, 37.0)).as_deref(),
    // rust: Some("Pinging...")
    // rust: );
    // rust: assert_eq!(hover(&pings, 5.0, (349.0, 34.0)).as_deref(), Some("42 ms"));
    // rust: assert!(hover(&pings, 36.0, (349.0, 33.0)).is_none());
    // rust: assert!(hover(&pings, 0.0, (349.0, 179.0)).is_none());
    // rust: assert!(hover(&pings, 216.0, (349.0, 37.0)).is_none()); // LAN header
    // rust: pings.insert(
    // rust: "server0".into(),
    // rust: Ping::Failed("private connection error".into()),
    // rust: );
    // rust: assert_eq!(
    // rust: hover(&pings, 0.0, (349.0, 37.0)).as_deref(),
    // rust: Some("(no connection)")
    // rust: );
}

screens_lay_out_on_whole_gui_pixels_at_any_window_size :: proc() {
}
        // A 1000-pixel-high window at GUI scale 3 is 334 GUI pixels high and
        // a 1281-wide one 427 wide: vanilla's `height / 4` is 83 and
        // `width / 2` 213, never 83.5 and 213.5.
    // rust: let direct = Screen::Direct {
    // rust: address: "localhost".into(),
}
    // rust: let at = |screen: &Screen, w, h| -> Vec<(f32, f32)> {
    // rust: screen.buttons(w, h).iter().map(|b| (b.0, b.1)).collect()
}
    // rust: assert_eq!(at(&direct, 427.0, 334.0), [(113.0, 191.0), (113.0, 215.0)]);
    // rust: assert_eq!(at(&direct, 320.0, 240.0), [(60.0, 168.0), (60.0, 192.0)]);
    // rust: let friend = Screen::Friend {
    // rust: code: String::new(),
    // rust: relay: String::new(),
    // rust: focus: 0,
}
    // rust: assert_eq!(at(&friend, 427.0, 253.0), [(113.0, 177.0), (113.0, 201.0)]);
    // rust: let lost = Screen::Disconnected {
    // rust: reason: String::new(),
    // rust: retry: None,
    // rust: lines: std::cell::Cell::new(1),
}
    // rust: assert_eq!(at(&lost, 427.0, 253.0), [(113.0, 145.0)]);
        // Taller messages push the button down instead of under the text.
    // rust: let l1 = disconnected_layout(253.0, 1, false);
    // rust: let l6 = disconnected_layout(253.0, 6, false);
    // rust: assert!(l6.buttons >= l6.message + 6.0 * 9.0);
    // rust: assert!(l1.buttons >= l1.message + 9.0);
        // centeredText: `width / 2 - font.width(text) / 2`.
    // rust: assert_eq!(centered_x(427.0, 85.0), 171.0);
    // rust: assert_eq!(centered_x(320.0, 84.0), 118.0);
}

player_list_styles_sample_names_and_counts_the_rest :: proc() {
}
    // rust: let players = serde_json::json!({
    // rust: "online": 5,
    // rust: "sample": [
    // rust: {"name": "\u{a7}b\u{a7}lBIT\u{a7}rMADE"},
    // rust: {"name": ""},
    // rust: {"name": "\u{a7}8\u{2022}\u{a7}r \u{a7}bLobby"},
    // rust: ]
    // rust: });
    // rust: let lines = player_list(&players, 5);
    // rust: assert_eq!(lines.len(), 4);
    // rust: let plain: Vec<String> = lines.iter().take(3).map(Text::plain).collect();
    // rust: assert_eq!(plain, ["BITMADE", "", "\u{2022} Lobby"]);
    // rust: assert_eq!(player_list(&players, 3).len(), 3);
    // rust: assert!(player_list(&serde_json::json!({"online": 2}), 2).is_empty());
    // rust: assert!(player_list(&serde_json::json!({"online": 2, "sample": []}), 2).is_empty());
}

player_list_tooltip_covers_only_the_player_count :: proc() {
}
    // rust: let servers = vec![ServerEntry::new("Test", "server0")];
    // rust: let size = (427.0, 240.0);
    // rust: let mut pings = HashMap::new();
    // rust: let hover = |pings: &HashMap<String, Ping>, cursor| {
    // rust: player_list_tooltip(&servers, pings, size, 0.0, cursor, |_| 20.0)
    // rust: .map(|l| l.iter().map(Text::plain).collect::<Vec<_>>())
}
    // rust: assert!(hover(&pings, (324.0, 37.0)).is_none());
    // rust: let ok = |player_list| Ping::Ok {
    // rust: motd: Text::empty(),
    // rust: players: Some((0, 500)),
    // rust: player_list,
    // rust: ms: 1,
    // rust: version: String::new(),
}
    // rust: pings.insert("server0".into(), ok(vec![Text::literal("Lobby")]));
        // The 20-wide count ends 5 pixels left of the bars at (349, 37).
    // rust: for cursor in [(324.0, 37.0), (343.9, 44.9)] {
    // rust: assert_eq!(hover(&pings, cursor), Some(vec!["Lobby".to_owned()]));
}
    // rust: for cursor in [
    // rust: (323.9, 37.0),
    // rust: (344.0, 37.0),
    // rust: (324.0, 36.9),
    // rust: (324.0, 45.0),
    // rust: (349.0, 37.0),
    // rust: ] {
    // rust: assert!(hover(&pings, cursor).is_none(), "{cursor:?}");
}
    // rust: pings.insert("server0".into(), ok(Vec::new()));
    // rust: assert!(hover(&pings, (324.0, 37.0)).is_none());
}

the_lan_header_follows_the_saved_servers :: proc() {
}
    // rust: let all: Vec<Row> = rows(2, 1).collect();
    // rust: assert_eq!(
    // rust: all,
    // rust: [Row::Server(0), Row::Server(1), Row::LanHeader, Row::Lan(0)]
    // rust: );
        // No saved servers: the list is the scanning header alone.
    // rust: assert_eq!(rows(0, 0).collect::<Vec<_>>(), [Row::LanHeader]);
    // rust: assert_eq!(content_height(0, 0), 40.0);
}

rows_sit_two_pixels_under_the_header_and_scroll_with_the_list :: proc() {
}
        // 427x240 GUI: the list spans 33..180, rows 305 wide from x 61.
    // rust: let size = (427.0, 240.0);
    // rust: assert_eq!(list_area(size.0, size.1), (33.0, 180.0, 61.0));
    // rust: assert_eq!(row_at(3, 0, (100.0, 35.0), size, 0.0), Some(Row::Server(0)));
    // rust: assert_eq!(row_at(3, 0, (100.0, 70.9), size, 0.0), Some(Row::Server(0)));
    // rust: assert_eq!(row_at(3, 0, (100.0, 71.0), size, 0.0), Some(Row::Server(1)));
    // rust: assert_eq!(
    // rust: row_at(3, 0, (100.0, 35.0), size, 36.0),
    // rust: Some(Row::Server(1))
    // rust: );
    // rust: assert_eq!(
    // rust: row_at(3, 0, (100.0, 143.0), size, 0.0),
    // rust: Some(Row::LanHeader)
    // rust: );
    // rust: assert_eq!(row_at(3, 0, (60.0, 40.0), size, 0.0), None);
    // rust: assert_eq!(row_at(3, 0, (100.0, 32.0), size, 0.0), None);
}

loading_dots_step_every_300_ms :: proc() {
}
    // rust: let frames: Vec<&str> = [0, 299, 300, 600, 900, 1200].map(loading_dots).to_vec();
    // rust: assert_eq!(
    // rust: frames,
    // rust: ["O o o", "O o o", "o O o", "o o O", "o O o", "O o o"]
    // rust: );
}

player_count_is_dark_gray_with_gray_numbers :: proc() {
}
    // rust: assert_eq!(
    // rust: Ping::player_count(Some((3, 20))).component(),
    // rust: serde_json::json!({
    // rust: "translate": "multiplayer.status.player_count",
    // rust: "with": [{"text": "3", "color": "gray"}, {"text": "20", "color": "gray"}],
    // rust: "color": "dark_gray",
    // rust: })
    // rust: );
    // rust: assert_eq!(
    // rust: Ping::player_count(None).component(),
    // rust: serde_json::json!({"translate": "multiplayer.status.unknown", "color": "dark_gray"})
    // rust: );
}

png :: proc(size: u32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::new();
    // rust: let mut encoder = png::Encoder::new(&mut out, size, size);
    // rust: encoder.set_color(png::ColorType::Rgba);
    // rust: let mut writer = encoder.write_header().unwrap();
    // rust: writer
    // rust: .write_image_data(&vec![200; (size * size * 4) as usize])
    // rust: .unwrap();
    // rust: writer.finish().unwrap();
    // rust: out
}

favicons_are_64_pixel_pngs_behind_the_data_url :: proc() {
}
    // rust: let icon = png(64);
    // rust: let encoded = crate::lan::base64(&icon);
    // rust: let (a, b) = encoded.split_at(10);
    // rust: let json = serde_json::json!({ "favicon": format!("data:image/png;base64,{a}\n{b}") });
    // rust: let bytes = favicon_bytes(&json).unwrap();
    // rust: assert_eq!(bytes, icon);
    // rust: assert_eq!(icon_pixels(&bytes).unwrap().len(), 64 * 64 * 4);
        // FaviconTexture refuses other sizes; other formats are not icons.
    // rust: assert!(icon_pixels(&png(32)).is_none());
    // rust: assert!(favicon_bytes(&serde_json::json!({ "favicon": encoded })).is_none());
}

the_official_server_is_added_once_at_the_top :: proc() {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-mp-official-{}", std::process::id()));
    // rust: let (name, address) = OFFICIAL_SERVER;
    // rust: let file = dir.join("servers.dat");
    // rust: let ips = || -> Vec<String> { servers::load(&file).into_iter().map(|s| s.ip).collect() };
    // rust: let fresh = |list: &[ServerEntry]| {
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: if !list.is_empty() {
    // rust: servers::save(&file, list).unwrap();
}
}
        // A fresh list: just the official server, named like it.
    // rust: fresh(&[]);
    // rust: add_official_server(&dir).unwrap();
    // rust: assert_eq!(servers::load(&file), [ServerEntry::new(name, address)]);
        // An existing list: on top, the player's servers kept in their order.
    // rust: let mine = [
    // rust: ServerEntry::new("Mine", "127.0.0.1:2"),
    // rust: ServerEntry::new("Other", "example.org"),
    // rust: ];
    // rust: fresh(&mine);
    // rust: add_official_server(&dir).unwrap();
    // rust: assert_eq!(ips(), [address, "127.0.0.1:2", "example.org"]);
        // Once only: a second start adds nothing.
    // rust: add_official_server(&dir).unwrap();
    // rust: assert_eq!(ips(), [address, "127.0.0.1:2", "example.org"]);
        // Already there under the player's own name and spelling: not duplicated.
    // rust: fresh(&[
    // rust: ServerEntry::new("SMP", "Play.PlayHorizon.dev:25565"),
    // rust: mine[0].clone(),
    // rust: ]);
    // rust: add_official_server(&dir).unwrap();
    // rust: assert_eq!(ips(), ["Play.PlayHorizon.dev:25565", "127.0.0.1:2"]);
        // Deleted by the player: never back.
    // rust: fresh(&mine);
    // rust: add_official_server(&dir).unwrap();
    // rust: servers::save(&file, &mine).unwrap();
    // rust: add_official_server(&dir).unwrap();
    // rust: assert_eq!(ips(), ["127.0.0.1:2", "example.org"]);
    // rust: let _ = std::fs::remove_dir_all(&dir);
}

partner_servers_are_offered_once_below_the_official_server :: proc() {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-mp-partner-{}", std::process::id()));
    // rust: let official = OFFICIAL_SERVER.1;
    // rust: let (name, partner) = PARTNER_SERVERS[0];
    // rust: let file = dir.join("servers.dat");
    // rust: let ips = || -> Vec<String> { servers::load(&file).into_iter().map(|s| s.ip).collect() };
    // rust: let fresh = |list: &[ServerEntry]| {
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: if !list.is_empty() {
    // rust: servers::save(&file, list).unwrap();
}
}
        // A first start: the official server on top, the partner just below it.
    // rust: fresh(&[ServerEntry::new("Mine", "127.0.0.1:2")]);
    // rust: add_official_server(&dir).unwrap();
    // rust: add_partner_servers(&dir).unwrap();
    // rust: assert_eq!(ips(), [official, partner, "127.0.0.1:2"]);
    // rust: assert_eq!(servers::load(&file)[1].name, name);
        // Once only.
    // rust: add_partner_servers(&dir).unwrap();
    // rust: assert_eq!(ips(), [official, partner, "127.0.0.1:2"]);
        // A player who already had the official server moved it down: the partner follows it.
    // rust: fresh(&[
    // rust: ServerEntry::new("Mine", "127.0.0.1:2"),
    // rust: ServerEntry::new("SMP", official),
    // rust: ServerEntry::new("Last", "example.org"),
    // rust: ]);
    // rust: add_partner_servers(&dir).unwrap();
    // rust: assert_eq!(ips(), ["127.0.0.1:2", official, partner, "example.org"]);
        // No official server: last. Already listed in another spelling: not duplicated.
    // rust: fresh(&[ServerEntry::new("Mine", "127.0.0.1:2")]);
    // rust: add_partner_servers(&dir).unwrap();
    // rust: assert_eq!(ips(), ["127.0.0.1:2", partner]);
    // rust: fresh(&[ServerEntry::new("ZA", "Afri-Network.co.za:25565")]);
    // rust: add_partner_servers(&dir).unwrap();
    // rust: assert_eq!(ips(), ["Afri-Network.co.za:25565"]);
        // Deleted by the player: never back.
    // rust: fresh(&[]);
    // rust: add_partner_servers(&dir).unwrap();
    // rust: servers::save(&file, &[]).unwrap();
    // rust: add_partner_servers(&dir).unwrap();
    // rust: assert!(ips().is_empty());
    // rust: let _ = std::fs::remove_dir_all(&dir);
}

a_moved_official_server_moves_the_old_entry_once :: proc() {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-mp-moved-{}", std::process::id()));
    // rust: let address = OFFICIAL_SERVER.1;
    // rust: let file = dir.join("servers.dat");
    // rust: let marker = dir.join(OFFICIAL_MARKER);
    // rust: let ips = || -> Vec<String> { servers::load(&file).into_iter().map(|s| s.ip).collect() };
    // rust: let offered_before = |list: &[ServerEntry]| {
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: servers::save(&file, list).unwrap();
    // rust: std::fs::write(&marker, "horizon.bunchy7s.dev\n").unwrap();
}
        // The old address under the player's own name and spelling: moved, name and place kept.
    // rust: let mut old = ServerEntry::new("Our SMP", "Horizon.Bunchy7s.dev:25565");
    // rust: old.icon = Some("AAAA".into());
    // rust: offered_before(&[ServerEntry::new("Mine", "127.0.0.1:2"), old]);
    // rust: add_official_server(&dir).unwrap();
    // rust: let list = servers::load(&file);
    // rust: assert_eq!(ips(), ["127.0.0.1:2", address]);
    // rust: assert_eq!(
    // rust: (list[1].name.as_str(), list[1].icon.as_deref()),
    // rust: ("Our SMP", Some("AAAA"))
    // rust: );
    // rust: assert_eq!(
    // rust: std::fs::read_to_string(&marker).unwrap(),
    // rust: format!("{address}\n")
    // rust: );
        // Once: the old address added back afterwards is the player's.
    // rust: servers::prepend(&file, &ServerEntry::new("Old", "horizon.bunchy7s.dev")).unwrap();
    // rust: add_official_server(&dir).unwrap();
    // rust: assert_eq!(ips(), ["horizon.bunchy7s.dev", "127.0.0.1:2", address]);
        // The new address already listed: no second entry.
    // rust: offered_before(&[
    // rust: ServerEntry::new("Old", "horizon.bunchy7s.dev"),
    // rust: ServerEntry::new("New", address),
    // rust: ]);
    // rust: add_official_server(&dir).unwrap();
    // rust: assert_eq!(ips(), [address]);
        // Deleted by the player before the move: not offered again; another port is left alone.
    // rust: offered_before(&[ServerEntry::new("Test", "horizon.bunchy7s.dev:25570")]);
    // rust: add_official_server(&dir).unwrap();
    // rust: assert_eq!(ips(), ["horizon.bunchy7s.dev:25570"]);
    // rust: let _ = std::fs::remove_dir_all(&dir);
}

arrow_keys_select_servers_and_shift_moves_them :: proc() {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-mp-keys-{}", std::process::id()));
    // rust: let saves = dir.join("saves");
    // rust: std::fs::create_dir_all(&saves).unwrap();
    // rust: let file = servers_file(&saves);
    // rust: let list: Vec<ServerEntry> = ["a", "b", "c"]
    // rust: .iter()
    // rust: .map(|n| ServerEntry::new(n, "127.0.0.1:2"))
    // rust: .collect();
    // rust: servers::save(&file, &list).unwrap();
    // rust: let mut screen = Screen::list(&saves);
    // rust: let size = (427.0, 240.0);
    // rust: let state = |screen: &Screen| match screen {
    // rust: Screen::List {
    // rust: servers, selected, ..
    // rust: } => (
    // rust: servers.iter().map(|s| s.name.clone()).collect::<Vec<_>>(),
    // rust: *selected,
    // rust: ),
    // rust: _ => unreachable!(),
}
    // rust: let abc = vec!["a".to_owned(), "b".into(), "c".into()];
        // None selected: Down takes the first, as vanilla's nextEntry does.
    // rust: assert!(screen.arrow(false, false, size, &saves));
    // rust: assert_eq!(state(&screen), (abc.clone(), Some(0)));
        // Up at the top stays; Down walks; the last stays.
    // rust: screen.arrow(true, false, size, &saves);
    // rust: assert_eq!(state(&screen).1, Some(0));
    // rust: screen.arrow(false, false, size, &saves);
    // rust: screen.arrow(false, false, size, &saves);
    // rust: screen.arrow(false, false, size, &saves);
    // rust: assert_eq!(state(&screen).1, Some(2));
        // Shift+Up moves "c" above "b", keeps it selected and saves the order.
    // rust: screen.arrow(true, true, size, &saves);
    // rust: assert_eq!(
    // rust: state(&screen),
    // rust: (vec!["a".to_owned(), "c".into(), "b".into()], Some(1))
    // rust: );
    // rust: let saved: Vec<String> = servers::load(&file).into_iter().map(|s| s.name).collect();
    // rust: assert_eq!(saved, ["a", "c", "b"]);
        // Nothing moves past the first server.
    // rust: screen.arrow(true, true, size, &saves);
    // rust: screen.arrow(true, true, size, &saves);
    // rust: assert_eq!(state(&screen).1, Some(0));
    // rust: assert_eq!(state(&screen).0[0], "c");
    // rust: let _ = std::fs::remove_dir_all(&dir);
}

enter_joins_the_selected_server :: proc() {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-mp-enter-{}", std::process::id()));
    // rust: let saves = dir.join("saves");
    // rust: std::fs::create_dir_all(&saves).unwrap();
    // rust: let file = servers_file(&saves);
    // rust: let list = vec![
    // rust: ServerEntry::new("a", "127.0.0.1:2"),
    // rust: ServerEntry::new("b", "127.0.0.1:3"),
    // rust: ];
    // rust: servers::save(&file, &list).unwrap();
    // rust: let mut screen = Screen::list(&saves);
        // Nothing selected: Enter joins nothing.
    // rust: assert!(matches!(screen.confirm(), Outcome::None));
    // rust: let size = (427.0, 240.0);
    // rust: assert!(screen.arrow(false, false, size, &saves));
    // rust: match screen.confirm() {
    // rust: Outcome::Connect { address, lan } => {
    // rust: assert_eq!(address, "127.0.0.1:2");
    // rust: assert!(!lan);
}
    // rust: _ => panic!("Enter did not join the selected server"),
}
        // Down picks the next server, and Enter joins that one.
    // rust: assert!(screen.arrow(false, false, size, &saves));
    // rust: match screen.confirm() {
    // rust: Outcome::Connect { address, lan } => {
    // rust: assert_eq!(address, "127.0.0.1:3");
    // rust: assert!(!lan);
}
    // rust: _ => panic!("Enter did not join the second server"),
}
    // rust: let _ = std::fs::remove_dir_all(&dir);
}

icon_arrows_join_and_move_servers :: proc() {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-mp-arrows-{}", std::process::id()));
    // rust: let saves = dir.join("saves");
    // rust: std::fs::create_dir_all(&saves).unwrap();
    // rust: let file = servers_file(&saves);
    // rust: let names = ["a", "b", "c"];
    // rust: let list: Vec<ServerEntry> = names
    // rust: .iter()
    // rust: .map(|n| ServerEntry::new(n, &format!("127.0.0.1:{}", 1 + n.len())))
    // rust: .collect();
    // rust: servers::save(&file, &list).unwrap();
    // rust: let mut screen = Screen::list(&saves);
    // rust: let size = (427.0, 240.0);
    // rust: let order = |screen: &Screen| match screen {
    // rust: Screen::List {
    // rust: servers, selected, ..
    // rust: } => (
    // rust: servers.iter().map(|s| s.name.clone()).collect::<Vec<_>>(),
    // rust: *selected,
    // rust: ),
    // rust: _ => unreachable!(),
}
        // 427x240: rows start at x 61, the first icon at (63, 37).
    // rust: let (ix, iy) = (63.0, 37.0);
        // The first server has no up arrow: its top-left quarter selects it.
    // rust: assert!(matches!(
    // rust: screen.click(None, ix + 4.0, iy + 4.0, size, &saves),
    // rust: Outcome::None
    // rust: ));
    // rust: assert_eq!(
    // rust: order(&screen),
    // rust: (vec!["a".into(), "b".into(), "c".into()], Some(0))
    // rust: );
        // Bottom-left quarter: down, saved, and still selected.
    // rust: screen.click(None, ix + 4.0, iy + 20.0, size, &saves);
    // rust: assert_eq!(
    // rust: order(&screen),
    // rust: (vec!["b".into(), "a".into(), "c".into()], Some(1))
    // rust: );
    // rust: let saved: Vec<String> = servers::load(&file).into_iter().map(|s| s.name).collect();
    // rust: assert_eq!(saved, ["b", "a", "c"]);
        // Top-left quarter of the second row: back up.
    // rust: screen.click(None, ix + 4.0, iy + ROW_HEIGHT + 4.0, size, &saves);
    // rust: assert_eq!(
    // rust: order(&screen),
    // rust: (vec!["a".into(), "b".into(), "c".into()], Some(0))
    // rust: );
        // The right half joins at once.
    // rust: match screen.click(None, ix + 20.0, iy + 2.0 * ROW_HEIGHT + 10.0, size, &saves) {
    // rust: Outcome::Connect { address, lan } => {
    // rust: assert_eq!(address, list[2].ip);
    // rust: assert!(!lan);
}
    // rust: _ => panic!("the join arrow connects"),
}
    // rust: let _ = std::fs::remove_dir_all(&dir);
}

delete_asks_before_removing_the_server :: proc() {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-mp-delete-{}", std::process::id()));
    // rust: let saves = dir.join("saves");
    // rust: std::fs::create_dir_all(&saves).unwrap();
    // rust: let file = servers_file(&saves);
    // rust: let list = vec![
    // rust: ServerEntry::new("Keep", "127.0.0.1:2"),
    // rust: ServerEntry::new("Gone", "127.0.0.1:3"),
    // rust: ];
    // rust: servers::save(&file, &list).unwrap();
    // rust: let size = (427.0, 240.0);
    // rust: let names =
    // rust: || -> Vec<String> { servers::load(&file).into_iter().map(|s| s.name).collect() };
    // rust: let mut screen = Screen::list(&saves);
    // rust: let select = |screen: &mut Screen| {
    // rust: if let Screen::List { selected, .. } = screen {
    // rust: *selected = Some(1);
}
}
    // rust: select(&mut screen);
        // Delete opens the ConfirmScreen: nothing is removed yet.
    // rust: screen.click(Some(44), 0.0, 0.0, size, &saves);
    // rust: assert!(matches!(&screen, Screen::ConfirmDelete { name, .. } if name == "Gone"));
    // rust: let labels: Vec<(f32, f32, String, u8)> = screen
    // rust: .buttons(size.0, size.1)
    // rust: .into_iter()
    // rust: .map(|b| (b.0, b.1, b.3, b.5))
    // rust: .collect();
    // rust: assert_eq!(
    // rust: labels,
    // rust: [
    // rust: (61.0, 135.0, "Delete".to_owned(), 58),
    // rust: (215.0, 135.0, "Cancel".to_owned(), 59),
    // rust: ]
    // rust: );
    // rust: assert_eq!(names(), ["Keep", "Gone"]);
        // Cancel and Escape return to the list with the selection kept.
    // rust: screen.click(Some(59), 0.0, 0.0, size, &saves);
    // rust: assert!(matches!(
    // rust: &screen,
    // rust: Screen::List {
    // rust: selected: Some(1),
    // rust: ..
}
    // rust: ));
    // rust: screen.click(Some(44), 0.0, 0.0, size, &saves);
    // rust: assert!(!screen.escape(&saves));
    // rust: assert!(matches!(
    // rust: &screen,
    // rust: Screen::List {
    // rust: selected: Some(1),
    // rust: ..
}
    // rust: ));
    // rust: assert_eq!(names(), ["Keep", "Gone"]);
        // Delete removes it, saves, and clears the selection.
    // rust: screen.click(Some(44), 0.0, 0.0, size, &saves);
    // rust: screen.click(Some(58), 0.0, 0.0, size, &saves);
    // rust: assert!(
    // rust: matches!(&screen, Screen::List { selected: None, servers, .. } if servers.len() == 1)
    // rust: );
    // rust: assert_eq!(names(), ["Keep"]);
    // rust: let _ = std::fs::remove_dir_all(&dir);
}

edit_cycles_and_saves_the_server_resource_pack_setting :: proc() {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-mp-packs-{}", std::process::id()));
    // rust: let saves = dir.join("saves");
    // rust: std::fs::create_dir_all(&saves).unwrap();
    // rust: let file = servers_file(&saves);
    // rust: let mut entry = ServerEntry::new("Packs", "127.0.0.1:4");
    // rust: entry.accept_textures = Some(false);
    // rust: servers::save(&file, &[entry]).unwrap();
    // rust: let size = (427.0, 240.0);
    // rust: let mut screen = Screen::list(&saves);
    // rust: if let Screen::List { selected, .. } = &mut screen {
    // rust: *selected = Some(0);
}
    // rust: screen.click(Some(43), 0.0, 0.0, size, &saves);
    // rust: let cycle = |screen: &Screen| {
    // rust: screen
    // rust: .buttons(size.0, size.1)
    // rust: .into_iter()
    // rust: .find(|b| b.5 == 60)
    // rust: .map(|b| (b.0, b.1, b.2, b.3))
}
        // ManageServerScreen: 200 wide at width / 2 - 100 (ints: 427 / 2 is
        // 213) and height / 4 + 72, the saved value first.
    // rust: assert_eq!(
    // rust: cycle(&screen),
    // rust: Some((
    // rust: 113.0,
    // rust: 132.0,
    // rust: 200.0,
    // rust: "Server Resource Packs: Disabled".into()
    // rust: ))
    // rust: );
        // Disabled, Prompt, Enabled: Cancel keeps what was saved.
    // rust: screen.click(Some(60), 0.0, 0.0, size, &saves);
    // rust: assert_eq!(cycle(&screen).unwrap().3, "Server Resource Packs: Prompt");
    // rust: screen.click(Some(51), 0.0, 0.0, size, &saves);
    // rust: assert_eq!(servers::load(&file)[0].accept_textures, Some(false));
        // Done saves it.
    // rust: if let Screen::List { selected, .. } = &mut screen {
    // rust: *selected = Some(0);
}
    // rust: screen.click(Some(43), 0.0, 0.0, size, &saves);
    // rust: screen.click(Some(60), 0.0, 0.0, size, &saves);
    // rust: screen.click(Some(60), 0.0, 0.0, size, &saves);
    // rust: assert_eq!(cycle(&screen).unwrap().3, "Server Resource Packs: Enabled");
    // rust: screen.click(Some(50), 0.0, 0.0, size, &saves);
    // rust: assert_eq!(servers::load(&file)[0].accept_textures, Some(true));
        // A new server asks.
    // rust: screen.click(Some(42), 0.0, 0.0, size, &saves);
    // rust: assert_eq!(cycle(&screen).unwrap().3, "Server Resource Packs: Prompt");
    // rust: let _ = std::fs::remove_dir_all(&dir);
}
}
