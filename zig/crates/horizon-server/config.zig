//! Transpiled from Horizon Rust crate
//! Module: horizon-server_config
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `server.toml`, the one file an owner edits (docs/server.md, section 4).
//!
//! It has typed sections for what owners change and `[properties]` for any other vanilla key. Before every
//! start the supervisor writes them into `server.properties`, which the game reads exactly as vanilla's
//! server does; what the game changes there itself (`/whitelist on`) is copied back afterwards.

// use horizon_server_files::{
    // rust: java_properties::{Properties, date_string, now_millis},
    // rust: properties::{DIFFICULTIES, GAME_MODES, ServerProperties, SystemEntropy},
}
// use serde::{Deserialize, Serialize};
// use std::{collections::BTreeMap, path::Path};

pub const FILE: []const u8 = "server.toml";
pub const PROPERTIES: []const u8 = "server.properties";

/// What `init` writes: every typed setting, with vanilla 26.3's defaults and what it means.
    // rust: pub const TEMPLATE: &str = r##"# Horizon server settings (docs/server.md). The server writes them into server.properties before
    // rust: # every start: edit this file, not that one.

    // rust: [server]
    // rust: motd = "A Minecraft Server"  # the line under the server's name in the server list
    // rust: port = 25565                 # the port players connect to
    // rust: bind = ""                    # listen on every address, or only on this one (server-ip)
    // rust: max_players = 20             # how many players can be online at once
    // rust: online_mode = true           # check players' Minecraft accounts (false: anyone joins under any name)
    // rust: whitelist = true             # only whitelisted players and operators can join
    // rust: enforce_whitelist = false    # kick online players taken off the whitelist
    // rust: view_distance = 10           # chunks sent around each player
    // rust: simulation_distance = 10     # chunks around each player where mobs, crops and redstone tick
    // rust: max_view_distance = 0        # past view_distance, saved chunks only, up to this (never generated; 0: off)
    // rust: admin_feedback_to_ops = true # operators see each other's commands ([name: ...], vanilla); false: only the log
    // rust: accept_older_clients = false # true: 26.2 clients join too, their packets translated (docs/hosting.md)

    // rust: [world]
    // rust: name = "world"               # the world folder
    // rust: seed = ""                    # empty: a random seed on the first start
    // rust: game_mode = "survival"       # survival, creative, adventure or spectator
    // rust: difficulty = "easy"          # peaceful, easy, normal or hard
    // rust: hardcore = false             # one life: a player who dies becomes a spectator

    // rust: # Any other server.properties key, spelled as vanilla spells it, for example:
    // rust: # spawn-protection = 16
    // rust: [properties]

    // rust: [engine]
    // rust: path = ""                    # the game program; empty: the one installed beside horizon-server
    // rust: resources = ""               # the prepared game files; empty: resources/ here, else the usual places
    // rust: restart_on_crash = true      # start the game again when it crashes
    // rust: low_memory = false           # true: no transparent huge pages, ~60 MB less idle for ~1 % more tick time

    // rust: [backups]
    // rust: every = "6h"                 # automatic backups while the server runs: 30m, 6h, 1d...; "0" turns them off
    // rust: keep = 12                    # automatic backups kept (backups made by hand are never deleted)

    // rust: [updates]
    // rust: keep = 1                     # other releases kept by updates, besides the one in use and the one rollback goes to

    // rust: [panel]
    // rust: bind = "127.0.0.1:8130"      # the web panel: this computer only, or a tailnet address (100.x); "" turns it off
    // rust: allow_public = false         # true lets bind be any address; never put the panel on the open internet

    // rust: [api]
    // rust: bind = ""                    # the control API: "" a free port on 127.0.0.1; or a fixed one, like 127.0.0.1:8131 or a tailnet address
    // rust: token = ""                   # its token (16 characters or more); "" a new random one at every start
    // rust: allow_public = false         # true lets bind be any address; the token is then all that guards the server

    // rust: # A proxy handing players over between servers (docs/server.md). Not vanilla's accepts-transfers (the transfer packet).
    // rust: [transfer]
    // rust: enabled = false              # true: take a proxy's player-* requests; needs Velocity forwarding (forwarding.secret)
    // rust: expect_seconds = 10          # how long a player the proxy announced is waited for, when it names no time
    // rust: max_expect_seconds = 60      # the longest the proxy may ask for
    // rust: max_expected = 64            # players waited for at once
    // rust: max_freeze_seconds = 30      # the longest a player stays frozen while it is handed over
    // rust: max_hold_seconds = 60        # the longest a player arriving from another server is held before it is dropped

    // rust: # Post the chat, joins, leaves and deaths to a Discord channel, drawn like the in-game chat (docs/hosting.md)
    // rust: [discord]
    // rust: webhook = ""                 # the channel's webhook URL (a secret: anyone with it can post there); "" off
    // rust: events = ["chat", "join", "leave", "death"]   # what is posted; "kick" too if you like
    // rust: enabled = true               # false pauses it and keeps the webhook

    // rust: # Horizon's anticheat (docs/anticheat.md) is on: `combat` drops attacks no vanilla client sends and
    // rust: # `ground` the false ground claims of a no-fall or a walk on water; both kick, and ban at the second kick.
    // rust: # timer and prediction only write logs/anticheat.log until they're trusted. To change it:
    // rust: # [anticheat]
    // rust: # enabled = true             # false: the server checks only what vanilla's checks
    // rust: # alerts = true              # tell online operators (alert_level = 2) in their chat; the console always is
    // rust: # log = "logs/anticheat.log" # every flag, one line each
    // rust: # [anticheat.timer]          # a sped-up game: more client ticks than the server's clock allows
    // rust: # enabled = true             # false turns this check off
    // rust: # setback = 2                # the violation level from which the player is sent back; 0: never
    // rust: # alert = 5
    // rust: # kick = 20
    // rust: # decay = 0.02               # violation level lost each second
    // rust: # ban_after = 0              # the kick (counting this check's earlier ones) that bans instead; 0: never

    // rust: # The chat filter (docs/chat-filter.md) is on: a message, sign, anvil name or book title with a hate slur reaches
    // rust: # nobody, the sender is told, and logs/chat-filter.log keeps it for operators. To change it:
    // rust: # [chat_filter]
    // rust: # enabled = true             # false: players' text goes out as they wrote it
    // rust: # mute_after = 2             # the hit (within window_minutes) that mutes for mute_minutes; 0: never
    // rust: # tempban_after = 3          # the hit that bans for tempban_hours; 0: never
    // rust: # words_file = ""            # your own list, in the format of the built-in one; "": the built-in list

    // rust: # Fights follow 26.3's rules. For 1.8.9's (no attack cooldown or sweep, 1.8 weapon damage; docs/pvp.md):
    // rust: # [combat]
    // rust: # legacy = true
    // rust: "##;

/// Each typed setting: its section, its name, and the vanilla key it writes.
    // rust: pub(crate) const TYPED: [(&str, &str, &str); 17] = [
    // rust: ("server", "motd", "motd"),
    // rust: ("server", "port", "server-port"),
    // rust: ("server", "bind", "server-ip"),
    // rust: ("server", "max_players", "max-players"),
    // rust: ("server", "online_mode", "online-mode"),
    // rust: ("server", "whitelist", "white-list"),
    // rust: ("server", "enforce_whitelist", "enforce-whitelist"),
    // rust: ("server", "view_distance", "view-distance"),
    // rust: ("server", "simulation_distance", "simulation-distance"),
    // rust: ("server", "max_view_distance", "horizon-max-view-distance"),
    // rust: (
    // rust: "server",
    // rust: "admin_feedback_to_ops",
    // rust: "horizon-admin-feedback-to-ops",
    // rust: ),
    // rust: (
    // rust: "server",
    // rust: "accept_older_clients",
    // rust: "horizon-accept-older-clients",
    // rust: ),
    // rust: ("world", "name", "level-name"),
    // rust: ("world", "seed", "level-seed"),
    // rust: ("world", "game_mode", "gamemode"),
    // rust: ("world", "difficulty", "difficulty"),
    // rust: ("world", "hardcore", "hardcore"),
    // rust: ];

pub const Config = struct {
    server: Server,
    world: World,
    properties: BTreeMap<[]const u8,
    engine: Engine,
    backups: Backups,
    updates: Updates,
    panel: Panel,
    api: Api,
    /// A proxy's hand-overs (docs/server.md), passed to the game as `--transfers`.
    transfer: Transfer,
    /// Chat and players posted to a Discord channel (discord.rs).
    discord: crate::discord::Settings,
    /// The game reads this section itself (docs/anticheat.md); written only when it isn't the default.
    anticheat: horizon_anticheat::Config,
    /// The game reads this section itself (docs/chat-filter.md); written only when it isn't the default.
    chat_filter: horizon_chat_filter::Config,
    /// A one-time prune of barely visited chunks before a start (prune.rs); written only when set.
    prune_chunks: crate::prune::Settings,
    /// The game reads this section itself (docs/pvp.md); written only when it isn't the default.
    combat: Combat,
};

/// `[combat]`: `legacy = true` resolves the players' melee hits by 1.8.9's rules (no attack cooldown or sweep,
/// 1.8.9 weapon damage). The game reads it from the same file (game/dedicated.rs, `load_combat`).
pub const Combat = struct {
    legacy: bool,
};
    // rust: impl Combat {
pub fn is_default(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: *self == Self::default()
}
}

/// The game reads this section itself too (docs/chat-filter.md).
pub fn chat_filter_default(c: *horizon_chat_filter::Config) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: *c == horizon_chat_filter::Config::default()
}

pub fn anticheat_default(c: *horizon_anticheat::Config) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: *c == horizon_anticheat::Config::default()
}

pub const Server = struct {
    motd: []const u8,
    port: u16,
    bind: []const u8,
    max_players: u32,
    online_mode: bool,
    whitelist: bool,
    enforce_whitelist: bool,
    view_distance: u32,
    simulation_distance: u32,
    /// Horizon's far ring (docs/hosting.md): saved chunks sent past `view_distance`, up to this; 0 is off.
    max_view_distance: u32,
    /// Whether operators get each other's command feedback (`[name: ...]`, vanilla's broadcastToAdmins);
    /// false leaves it to the console's log, so nobody in game sees an operator's commands.
    admin_feedback_to_ops: bool,
    /// Whether 26.2 clients may join, their packets translated (horizon-protocol's `ClientSession`); off, they
    /// are turned away as vanilla turns away any other release.
    accept_older_clients: bool,
};

pub const World = struct {
    name: []const u8,
    /// A number or any text (vanilla hashes text); empty for a random seed.
    seed: []const u8,
    game_mode: []const u8,
    difficulty: []const u8,
    hardcore: bool,
};

pub const Engine = struct {
    path: []const u8,
    resources: []const u8,
    restart_on_crash: bool,
    /// The game without transparent huge pages (docs/hosting.md): less memory, slightly slower ticks.
    low_memory: bool,
};

pub const Panel = struct {
    bind: []const u8,
    allow_public: bool,
};

    // rust: impl Default for Panel {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: bind: "127.0.0.1:8130".into(),
    // rust: allow_public: false,
}
}
}

    // rust: impl Panel {
    /// Where the panel listens; `None` when it is off.
pub fn address(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: listen_address("panel", &self.bind, self.allow_public, 8130)
}
}

/// The control API's fixed address and token (docs/api/server.md); by default neither: a free port on
/// 127.0.0.1 and a random token, both written to `.horizon/api.json`.
pub const Api = struct {
    bind: []const u8,
    token: []const u8,
    allow_public: bool,
};

    // rust: impl Api {
    /// Where the API listens: `bind`, or a free port on 127.0.0.1.
pub fn address(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(listen_address("api", &self.bind, self.allow_public, 8131)?
    // rust: .unwrap_or_else(|| (std::net::Ipv4Addr::LOCALHOST, 0).into()))
}

pub fn check(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.address()?;
    // rust: let token = self.token.trim();
    // rust: if !token.is_empty() && (token.len() < 16 || token.chars().any(|c| !c.is_ascii_graphic())) {
    // rust: return Err(
    // rust: "api.token must be 16 characters or more, without spaces (or \"\": a random one)"
    // rust: .into(),
    // rust: );
}
    // rust: Ok(())
}
}

/// A `bind` setting: `None` when empty; anything but this computer or the tailnet needs `allow_public`.
    // rust: fn listen_address(
    // rust: what: &str,
    // rust: bind: &str,
    // rust: allow_public: bool,
    // rust: example_port: u16,
    // rust: ) -> Result<Option<std::net::SocketAddr>, String> {
    // rust: if bind.trim().is_empty() {
    // rust: return Ok(None);
}
    // rust: let address: std::net::SocketAddr = bind.trim().parse().map_err(|_| {
    // rust: format!(
    // rust: "{what}.bind is \"{bind}\": use an address and a port, like 127.0.0.1:{example_port}"
    // rust: )
    // rust: })?;
    // rust: if !allow_public && !private(address.ip()) {
    // rust: return Err(format!(
    // rust: "{what}.bind is \"{bind}\": the {what} listens only on this computer (127.0.0.1) or a tailnet \
    // rust: address (100.64.0.0/10, fd7a:115c:a1e0::/48); reach it from elsewhere over Tailscale or SSH"
    // rust: ));
}
    // rust: Ok(Some(address))
}

/// Loopback, or a Tailscale address: reachable only from this computer or the owner's tailnet.
pub fn private(ip: std::net::IpAddr) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match ip {
    // rust: std::net::IpAddr::V4(v4) => {
    // rust: v4.is_loopback() || (v4.octets()[0] == 100 && (v4.octets()[1] & 0xc0) == 64)
}
    // rust: std::net::IpAddr::V6(v6) => {
    // rust: v6.is_loopback() || v6.segments()[..3] == [0xfd7a, 0x115c, 0xa1e0]
}
}
}

/// `[transfer]`: a proxy moving players between this server and others (docs/server.md, the game's
/// `lan/arrivals.rs`). Off by default. The supervisor passes it to the game as `--transfers`, not as a
/// server.properties key, which stays vanilla's; and it is not vanilla's `accepts-transfers`, which is about the
/// transfer packet.
pub const Transfer = struct {
    enabled: bool,
    expect_seconds: u32,
    max_expect_seconds: u32,
    max_expected: u32,
    max_freeze_seconds: u32,
    max_hold_seconds: u32,
};

    // rust: impl Default for Transfer {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: enabled: false,
    // rust: expect_seconds: 10,
    // rust: max_expect_seconds: 60,
    // rust: max_expected: 64,
    // rust: max_freeze_seconds: 30,
    // rust: max_hold_seconds: 60,
}
}
}

    // rust: impl Transfer {
pub fn check(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: for (name, n) in [
    // rust: ("expect_seconds", self.expect_seconds),
    // rust: ("max_expect_seconds", self.max_expect_seconds),
    // rust: ("max_expected", self.max_expected),
    // rust: ("max_freeze_seconds", self.max_freeze_seconds),
    // rust: ("max_hold_seconds", self.max_hold_seconds),
    // rust: ] {
    // rust: if n == 0 {
    // rust: return Err(format!("transfer.{name} must be above zero"));
}
}
    // rust: if self.expect_seconds > self.max_expect_seconds {
    // rust: return Err("transfer.expect_seconds is above transfer.max_expect_seconds".into());
}
    // rust: Ok(())
}

    /// The game's `--transfers` value, when the section turns transfers on.
pub fn engine_arg(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.enabled.then(|| {
    // rust: format!(
    // rust: "expect_seconds={},max_expect_seconds={},max_expected={},max_freeze_seconds={},max_hold_seconds={}",
    // rust: self.expect_seconds,
    // rust: self.max_expect_seconds,
    // rust: self.max_expected,
    // rust: self.max_freeze_seconds,
    // rust: self.max_hold_seconds
    // rust: )
    // rust: })
}
}

pub const Backups = struct {
    every: []const u8,
    keep: u32,
};

pub const Updates = struct {
    /// Releases kept in `releases/` after an update besides the one in use and the one `rollback` goes
    /// back to (crate::update::Install::prune).
    keep: u32,
};

    // rust: impl Default for Updates {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self { keep: 1 }
}
}

    // rust: impl Default for Server {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: motd: "A Minecraft Server".into(),
    // rust: port: 25565,
    // rust: bind: String::new(),
    // rust: max_players: 20,
    // rust: online_mode: true,
    // rust: whitelist: true,
    // rust: enforce_whitelist: false,
    // rust: view_distance: 10,
    // rust: simulation_distance: 10,
    // rust: max_view_distance: 0,
    // rust: admin_feedback_to_ops: true,
    // rust: accept_older_clients: false,
}
}
}
    // rust: impl Default for World {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: name: "world".into(),
    // rust: seed: String::new(),
    // rust: game_mode: "survival".into(),
    // rust: difficulty: "easy".into(),
    // rust: hardcore: false,
}
}
}
    // rust: impl Default for Engine {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: path: String::new(),
    // rust: resources: String::new(),
    // rust: restart_on_crash: true,
    // rust: low_memory: false,
}
}
}

    // rust: impl Default for Backups {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: every: "6h".into(),
    // rust: keep: 12,
}
}
}

    // rust: fn text_or_number<'de, D: serde::Deserializer<'de>>(d: D) -> Result<String, D::Error> {
pub const Seed = enum {
    Text(String),
    Number(i64),
};
    // rust: Ok(match Seed::deserialize(d)? {
    // rust: Seed::Text(s) => s,
    // rust: Seed::Number(n) => n.to_string(),
    // rust: })
}

    // rust: impl Config {
pub fn parse(text: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let config: Self = toml::from_str(text).map_err(|e| e.to_string())?;
    // rust: config.check()?;
    // rust: Ok(config)
}

pub fn load(dir: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let path = dir.join(FILE);
    // rust: let text = std::fs::read_to_string(&path)
    // rust: .map_err(|e| format!("{}: {e} (run `horizon-server init` first)", path.display()))?;
    // rust: Self::parse(&text).map_err(|e| format!("{}: {e}", path.display()))
}

pub fn check(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let w = &self.world;
    // rust: if !GAME_MODES.contains(&w.game_mode.as_str()) {
    // rust: return Err(format!(
    // rust: "world.game_mode is \"{}\": use {}",
    // rust: w.game_mode,
    // rust: GAME_MODES.join(", ")
    // rust: ));
}
    // rust: if !DIFFICULTIES.contains(&w.difficulty.as_str()) {
    // rust: return Err(format!(
    // rust: "world.difficulty is \"{}\": use {}",
    // rust: w.difficulty,
    // rust: DIFFICULTIES.join(", ")
    // rust: ));
}
    // rust: if w.name.is_empty() || w.name.contains(['/', '\\']) || w.name == ".." {
    // rust: return Err(format!(
    // rust: "world.name \"{}\" must be a folder name, without slashes",
    // rust: w.name
    // rust: ));
}
    // rust: crate::backup::interval(&self.backups.every)?;
    // rust: self.panel.address()?;
    // rust: self.api.check()?;
    // rust: self.transfer.check()?;
    // rust: self.discord.check()?;
    // rust: self.anticheat.check()?;
    // rust: self.chat_filter.check()?;
    // rust: self.prune_chunks.check()?;
    // rust: if self.server.port == 0 {
    // rust: return Err("server.port must be a port number from 1 to 65535".into());
}
    // rust: if let Some((section, field, key)) =
    // rust: TYPED.iter().find(|t| self.properties.contains_key(t.2))
    // rust: {
    // rust: return Err(format!(
    // rust: "[properties] sets {key}: set {section}.{field} instead"
    // rust: ));
}
    // rust: Ok(())
}

    /// The vanilla keys and values this configuration sets, typed settings first.
pub fn vanilla(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let table = toml::Table::try_from(self).expect("a configuration is a table");
    // rust: let mut out: Vec<(String, String)> = TYPED
    // rust: .iter()
    // rust: .map(|(section, field, key)| {
    // rust: ((*key).to_owned(), property_text(&table[*section][*field]))
    // rust: })
    // rust: .collect();
    // rust: out.extend(
    // rust: self.properties
    // rust: .iter()
    // rust: .map(|(k, v)| (k.clone(), property_text(v))),
    // rust: );
    // rust: out
}

    /// Writes this configuration into `server.properties`, keeping the keys it doesn't set. Returns what it
    /// wrote, for [`sync_back`].
pub fn write_properties(self: *Self, dir: *Path) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let path = dir.join(PROPERTIES);
    // rust: let mut properties = read_properties(&path).unwrap_or_default();
    // rust: let written = self.vanilla();
    // rust: for (key, value) in &written {
    // rust: properties.put(key, value.clone());
}
    // rust: let text = properties.store(
    // rust: Some("Minecraft server properties"),
    // rust: &date_string(now_millis()),
    // rust: false,
    // rust: );
    // rust: std::fs::write(path, text)?;
    // rust: Ok(written)
}

    /// A configuration from a vanilla `server.properties`: typed settings from their keys, and every other
    /// key the file sets to something other than vanilla's default under `[properties]`.
pub fn import(source: *Properties) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let parsed = ServerProperties::new(source.clone(), &mut SystemEntropy::default())?;
    // rust: let defaults = ServerProperties::new(Properties::default(), &mut SystemEntropy::default())?;
    // rust: let mut table = toml::Table::try_from(Self::default()).map_err(|e| e.to_string())?;
    // rust: for (section, field, key) in TYPED {
    // rust: let (Some(text), Some(slot)) = (
    // rust: parsed.raw.get(key),
    // rust: table
    // rust: .get_mut(section)
    // rust: .and_then(|s| s.as_table_mut())
    // rust: .and_then(|s| s.get_mut(field)),
    // rust: ) else {
    // rust: continue;
}
    // rust: if let Some(value) = typed_value(text, slot) {
    // rust: *slot = value;
}
}
    // rust: let mut extra = toml::Table::new();
    // rust: let mut keys: Vec<&String> = source.map.keys().collect();
    // rust: keys.sort();
    // rust: for key in keys {
    // rust: let value = parsed.raw.get(key).unwrap_or_default();
    // rust: if TYPED.iter().any(|t| t.2 == key) || defaults.raw.get(key) == Some(value) {
    // rust: continue;
}
    // rust: extra.insert(key.clone(), loose_value(value));
}
    // rust: table.insert("properties".into(), toml::Value::Table(extra));
    // rust: let config: Self = table.try_into().map_err(|e| e.to_string())?;
    // rust: config.check()?;
    // rust: Ok(config)
}
}

/// `server.toml` for a configuration: the template's comments with this configuration's values.
pub fn render(config: *Config) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut doc: toml_edit::DocumentMut = TEMPLATE.parse().expect("the template parses");
    // rust: let table = toml::Table::try_from(config).expect("a configuration is a table");
    // rust: for (section, field, _) in TYPED {
    // rust: set(&mut doc, section, field, &table[section][field]);
}
    // rust: for (key, value) in &config.properties {
    // rust: set(&mut doc, "properties", key, value);
}
    // rust: for (section, field) in [
    // rust: ("engine", "path"),
    // rust: ("engine", "resources"),
    // rust: ("engine", "restart_on_crash"),
    // rust: ("engine", "low_memory"),
    // rust: ("backups", "every"),
    // rust: ("backups", "keep"),
    // rust: ("updates", "keep"),
    // rust: ("panel", "bind"),
    // rust: ("panel", "allow_public"),
    // rust: ("api", "bind"),
    // rust: ("api", "token"),
    // rust: ("api", "allow_public"),
    // rust: ("transfer", "enabled"),
    // rust: ("transfer", "expect_seconds"),
    // rust: ("transfer", "max_expect_seconds"),
    // rust: ("transfer", "max_expected"),
    // rust: ("transfer", "max_freeze_seconds"),
    // rust: ("transfer", "max_hold_seconds"),
    // rust: ] {
    // rust: set(&mut doc, section, field, &table[section][field]);
}
    // rust: let mut text = doc.to_string();
    // rust: for section in ["anticheat", "chat_filter", "prune_chunks", "combat"] {
    // rust: if let Some(settings) = table.get(section) {
    // rust: let mut only = toml::Table::new();
    // rust: only.insert(section.into(), settings.clone());
    // rust: text.push('\n');
    // rust: text.push_str(&toml::to_string(&only).expect("a section's settings are a table"));
}
}
    // rust: text
}

/// After the game stopped: copies into `server.toml` the keys it wrote that the game changed in
/// `server.properties` (`/whitelist on` stores `white-list`), keeping the owner's comments. Returns the keys
/// copied.
pub fn sync_back(dir: *Path, written: *[([]const u8) void {
}
    // rust: let Ok(now) = read_properties(&dir.join(PROPERTIES)) else {
    // rust: return Ok(Vec::new());
}
    // rust: let changed: Vec<(&str, &str)> = written
    // rust: .iter()
    // rust: .filter_map(|(key, value)| {
    // rust: now.get(key)
    // rust: .filter(|v| v != value)
    // rust: .map(|v| (key.as_str(), v))
    // rust: })
    // rust: .collect();
    // rust: if changed.is_empty() {
    // rust: return Ok(Vec::new());
}
    // rust: let path = dir.join(FILE);
    // rust: let text = std::fs::read_to_string(&path).map_err(|e| e.to_string())?;
    // rust: let mut doc: toml_edit::DocumentMut = text.parse().map_err(|e| format!("{e}"))?;
    // rust: let defaults = toml::Table::try_from(Config::default()).map_err(|e| e.to_string())?;
    // rust: for (key, value) in &changed {
    // rust: match TYPED.iter().find(|t| t.2 == *key) {
    // rust: Some((section, field, _)) => {
    // rust: if let Some(v) = typed_value(value, &defaults[*section][*field]) {
    // rust: set(&mut doc, section, field, &v);
}
}
    // rust: None => set(&mut doc, "properties", key, &loose_value(value)),
}
}
    // rust: let updated = doc.to_string();
    // rust: Config::parse(&updated)?;
    // rust: std::fs::write(&path, updated).map_err(|e| e.to_string())?;
    // rust: Ok(changed.iter().map(|(k, _)| (*k).to_owned()).collect())
}

/// Sets one typed setting in `server.toml` (`whitelist on`), keeping the owner's comments.
pub fn update(dir: *Path, section: []const u8, field: []const u8, value: toml::Value) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: update_all(dir, &[(section.to_owned(), field.to_owned(), value)])
}

/// Sets settings in `server.toml`, keeping the owner's comments; nothing is written unless the result is
/// a valid configuration.
pub fn update_all(dir: *Path, changes: *[([]const u8, toml: :Value) void {
}
    // rust: let path = dir.join(FILE);
    // rust: let text = std::fs::read_to_string(&path).map_err(|e| format!("{}: {e}", path.display()))?;
    // rust: let mut doc: toml_edit::DocumentMut = text.parse().map_err(|e| format!("{e}"))?;
    // rust: for (section, field, value) in changes {
    // rust: set(&mut doc, section, field, value);
}
    // rust: let updated = doc.to_string();
    // rust: Config::parse(&updated)?;
    // rust: std::fs::write(&path, updated).map_err(|e| e.to_string())
}

pub fn read_properties(path: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let bytes = std::fs::read(path).map_err(|e| e.to_string())?;
    // rust: Properties::load_file(&bytes).map_err(|e| format!("{}: {e}", path.display()))
}

/// Sets one value in a TOML document, keeping the comment after the old value.
pub fn set(doc: *mut toml_edit::DocumentMut, section: []const u8, key: []const u8, value: *toml::Value) void {
}
    // rust: let Some(table) = doc
    // rust: .entry(section)
    // rust: .or_insert_with(toml_edit::table)
    // rust: .as_table_mut()
    // rust: else {
    // rust: return;
}
    // rust: let mut new = match value {
    // rust: toml::Value::String(s) => toml_edit::value(s.as_str()),
    // rust: toml::Value::Integer(n) => toml_edit::value(*n),
    // rust: toml::Value::Float(f) => toml_edit::value(*f),
    // rust: toml::Value::Boolean(b) => toml_edit::value(*b),
    // rust: other => toml_edit::value(other.to_string()),
}
    // rust: if let (Some(old), Some(v)) = (
    // rust: table.get(key).and_then(|i| i.as_value()),
    // rust: new.as_value_mut(),
    // rust: ) {
    // rust: *v.decor_mut() = old.decor().clone();
}
    // rust: table.insert(key, new);
}

/// How a TOML value reads in server.properties.
pub fn property_text(value: *toml::Value) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match value {
    // rust: toml::Value::String(s) => s.clone(),
    // rust: other => other.to_string(),
}
}

/// A server.properties value as the TOML type of `like`.
pub fn typed_value(text: []const u8, like: *toml::Value) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(match like {
    // rust: toml::Value::Boolean(_) => toml::Value::Boolean(text.eq_ignore_ascii_case("true")),
    // rust: toml::Value::Integer(_) => toml::Value::Integer(text.trim().parse().ok()?),
    // rust: _ => toml::Value::String(text.to_owned()),
    // rust: })
}

/// A server.properties value for `[properties]`: a boolean or a number when it reads back the same.
pub fn loose_value(text: []const u8) t {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match text {
    // rust: "true" => toml::Value::Boolean(true),
    // rust: "false" => toml::Value::Boolean(false),
    // rust: _ => match text.parse::<i64>() {
    // rust: Ok(n) if n.to_string() == text => toml::Value::Integer(n),
    // rust: _ => toml::Value::String(text.to_owned()),
    // rust: },
}
}

    // rust: mod tests {
//     use super::*;

pub fn properties(pairs: *[([]const u8) void {
}
    // rust: let mut p = Properties::default();
    // rust: for (k, v) in pairs {
    // rust: p.put(k, (*v).to_owned());
}
    // rust: p
}

pub fn template_is_the_default() void {
}
    // rust: assert_eq!(Config::parse(TEMPLATE).unwrap(), Config::default());
    // rust: assert_eq!(render(&Config::default()), TEMPLATE);
}

    /// `[transfer]` is off by default, passes nothing to the game then, and is checked when it is read.
pub fn transfers_are_off_by_default_and_checked() void {
}
    // rust: assert_eq!(Config::default().transfer.engine_arg(), None);
    // rust: let on = TEMPLATE.replace(
    // rust: "enabled = false              # true: take",
    // rust: "enabled = true               # true: take",
    // rust: );
    // rust: let config = Config::parse(&on).unwrap();
    // rust: assert_eq!(
    // rust: config.transfer.engine_arg().as_deref(),
    // rust: Some(
    // rust: "expect_seconds=10,max_expect_seconds=60,max_expected=64,max_freeze_seconds=30,max_hold_seconds=60"
    // rust: )
    // rust: );
    // rust: assert_eq!(Config::parse(&render(&config)).unwrap(), config);
    // rust: for (from, to) in [
    // rust: ("expect_seconds = 10 ", "expect_seconds = 0  "),
    // rust: ("max_expect_seconds = 60", "max_expect_seconds = 5 "),
    // rust: ("max_freeze_seconds = 30", "max_freeze_seconds = 0 "),
    // rust: ] {
    // rust: let bad = on.replace(from, to);
    // rust: assert_ne!(bad, on, "{from} is in the template");
    // rust: assert!(Config::parse(&bad).is_err(), "{to} was taken");
}
}

pub fn the_chat_filter_is_on_unless_its_section_turns_it_off() void {
}
    // rust: assert!(Config::default().chat_filter.enabled);
    // rust: assert!(!TEMPLATE.lines().any(|l| l.trim() == "[chat_filter]"));
    // rust: let text =
    // rust: format!("{TEMPLATE}\n[chat_filter]\nmute_after = 3\nwords_file = \"slurs.txt\"\n");
    // rust: let c = Config::parse(&text).unwrap();
    // rust: assert_eq!(c.chat_filter.mute_after, 3);
    // rust: assert_eq!(Config::parse(&render(&c)).unwrap(), c);
        // The game reads the same section from the same file.
    // rust: assert_eq!(
    // rust: horizon_chat_filter::Config::from_server_toml(&text).unwrap(),
    // rust: c.chat_filter
    // rust: );
    // rust: let off = Config::parse(&format!("{TEMPLATE}\n[chat_filter]\nenabled = false\n")).unwrap();
    // rust: assert!(!off.chat_filter.enabled);
    // rust: assert_eq!(Config::parse(&render(&off)).unwrap(), off);
    // rust: assert!(Config::parse("[chat_filter]\nmute = 2\n").is_err());
}

pub fn anticheat_is_on_unless_its_section_turns_it_off() void {
}
    // rust: assert!(Config::default().anticheat.enabled);
    // rust: assert!(!TEMPLATE.lines().any(|l| l.trim() == "[anticheat]"));
    // rust: let text =
    // rust: format!("{TEMPLATE}\n[anticheat]\nenabled = true\n[anticheat.timer]\nkick = 20\n");
    // rust: let c = Config::parse(&text).unwrap();
    // rust: assert!(c.anticheat.enabled);
    // rust: assert_eq!(c.anticheat.timer.kick, 20.0);
    // rust: let off = Config::parse(&format!("{TEMPLATE}\n[anticheat]\nenabled = false\n")).unwrap();
    // rust: assert!(!off.anticheat.enabled);
    // rust: assert_eq!(Config::parse(&render(&off)).unwrap(), off);
        // The game reads the same section from the same file.
    // rust: assert_eq!(
    // rust: horizon_anticheat::Config::from_server_toml(&text).unwrap(),
    // rust: c.anticheat
    // rust: );
    // rust: assert_eq!(Config::parse(&render(&c)).unwrap(), c);
    // rust: assert!(Config::parse("[anticheat]\nenable = true\n").is_err());
    // rust: assert!(Config::parse("[anticheat.timer]\nalert = -1\n").is_err());
}

pub fn legacy_combat_is_off_unless_its_section_turns_it_on() void {
}
    // rust: assert!(!Config::default().combat.legacy);
    // rust: assert!(!TEMPLATE.lines().any(|l| l.trim() == "[combat]"));
    // rust: let on = Config::parse(&format!("{TEMPLATE}\n[combat]\nlegacy = true\n")).unwrap();
    // rust: assert!(on.combat.legacy);
        // Kept when the file is written again, and left out while off.
    // rust: assert_eq!(Config::parse(&render(&on)).unwrap(), on);
    // rust: let off = render(&Config::default());
    // rust: assert!(!off.lines().any(|l| l.trim() == "[combat]"), "{off}");
    // rust: assert!(Config::parse("[combat]\nlegacy = 1\n").is_err());
    // rust: assert!(Config::parse("[combat]\nlegcy = true\n").is_err());
}

pub fn defaults_are_vanilla() void {
}
        // Every typed default is what vanilla 26.3 writes for a missing key.
    // rust: let vanilla =
    // rust: ServerProperties::new(Properties::default(), &mut SystemEntropy::default()).unwrap();
    // rust: for (key, value) in Config::default().vanilla() {
            // Horizon's own, which vanilla doesn't have: their defaults behave as vanilla does
            // (the far ring off, operators told of each other's commands, other releases turned away).
    // rust: if key.starts_with("horizon-") {
    // rust: let vanilla_like = match key.as_str() {
    // rust: "horizon-admin-feedback-to-ops" => "true",
    // rust: "horizon-accept-older-clients" => "false",
    // rust: _ => "0",
}
    // rust: assert_eq!(value, vanilla_like, "{key}");
    // rust: continue;
}
    // rust: assert_eq!(vanilla.raw.get(&key), Some(value.as_str()), "{key}");
}
}

pub fn import_keeps_what_differs() void {
}
    // rust: let source = properties(&[
    // rust: ("motd", "Hello"),
    // rust: ("server-port", "25600"),
    // rust: ("white-list", "false"),
    // rust: ("gamemode", "1"),
    // rust: ("level-seed", "12345"),
    // rust: ("spawn-protection", "0"),
    // rust: ("allow-flight", "false"),
    // rust: ("rate-limit", "10"),
    // rust: ]);
    // rust: let c = Config::import(&source).unwrap();
    // rust: assert_eq!(c.server.motd, "Hello");
    // rust: assert_eq!(c.server.port, 25600);
    // rust: assert!(!c.server.whitelist);
    // rust: assert_eq!(c.world.game_mode, "creative");
    // rust: assert_eq!(c.world.seed, "12345");
        // allow-flight=false is vanilla's default: dropped.
    // rust: assert_eq!(
    // rust: c.properties,
    // rust: BTreeMap::from([
    // rust: ("rate-limit".to_owned(), toml::Value::Integer(10)),
    // rust: ("spawn-protection".to_owned(), toml::Value::Integer(0)),
    // rust: ])
    // rust: );
    // rust: let text = render(&c);
    // rust: assert!(text.contains("spawn-protection = 0"), "{text}");
    // rust: assert!(text.contains("port = 25600"), "{text}");
    // rust: assert_eq!(Config::parse(&text).unwrap(), c);
}

pub fn the_panel_stays_private() void {
}
    // rust: let panel = |bind: &str, allow_public| Panel {
    // rust: bind: bind.into(),
    // rust: allow_public,
}
    // rust: assert!(panel("127.0.0.1:8130", false).address().unwrap().is_some());
    // rust: assert!(panel("[::1]:8130", false).address().unwrap().is_some());
    // rust: assert!(
    // rust: panel("100.101.102.103:8130", false)
    // rust: .address()
    // rust: .unwrap()
    // rust: .is_some()
    // rust: );
    // rust: assert!(
    // rust: panel("[fd7a:115c:a1e0::1]:8130", false)
    // rust: .address()
    // rust: .unwrap()
    // rust: .is_some()
    // rust: );
    // rust: assert_eq!(panel("", false).address().unwrap(), None);
    // rust: assert!(panel("0.0.0.0:8130", false).address().is_err());
    // rust: assert!(panel("100.128.0.1:8130", false).address().is_err());
    // rust: assert!(panel("192.168.1.2:8130", false).address().is_err());
    // rust: assert!(panel("192.168.1.2:8130", true).address().unwrap().is_some());
    // rust: assert!(panel("localhost", false).address().is_err());
}

pub fn seed_may_be_a_number() void {
}
    // rust: let c = Config::parse("[world]\nseed = -42\n").unwrap();
    // rust: assert_eq!(c.world.seed, "-42");
}

pub fn rejects_mistakes() void {
}
    // rust: assert!(Config::parse("[world]\ngame_mode = \"creatve\"\n").is_err());
    // rust: assert!(Config::parse("[server]\nprot = 1\n").is_err());
    // rust: assert!(Config::parse("[properties]\nmotd = \"x\"\n").is_err());
    // rust: assert!(Config::parse("[world]\nname = \"../x\"\n").is_err());
}

pub fn writes_properties_and_syncs_back() void {
}
    // rust: let dir =
    // rust: std::env::temp_dir().join(format!("horizon-server-config-{}", std::process::id()));
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: let mut c = Config::default();
    // rust: c.properties
    // rust: .insert("spawn-protection".into(), toml::Value::Integer(0));
    // rust: std::fs::write(dir.join(FILE), render(&c)).unwrap();
    // rust: std::fs::write(dir.join(PROPERTIES), "rcon.port=25576\nmotd=old\n").unwrap();
    // rust: let written = c.write_properties(&dir).unwrap();
    // rust: let p = read_properties(&dir.join(PROPERTIES)).unwrap();
    // rust: assert_eq!(p.get("motd"), Some("A Minecraft Server"));
    // rust: assert_eq!(p.get("rcon.port"), Some("25576"), "other keys are kept");
    // rust: assert_eq!(p.get("spawn-protection"), Some("0"));
        // The game turns the whitelist off and changes spawn protection.
    // rust: let mut p = p;
    // rust: p.put("white-list", "false".into());
    // rust: p.put("spawn-protection", "4".into());
    // rust: std::fs::write(dir.join(PROPERTIES), p.store(None, "date", false)).unwrap();
    // rust: let mut changed = sync_back(&dir, &written).unwrap();
    // rust: changed.sort();
    // rust: assert_eq!(changed, ["spawn-protection", "white-list"]);
    // rust: let text = std::fs::read_to_string(dir.join(FILE)).unwrap();
    // rust: assert!(
    // rust: text.contains("whitelist = false             # only whitelisted"),
    // rust: "the comment stays: {text}"
    // rust: );
    // rust: let back = Config::parse(&text).unwrap();
    // rust: assert!(!back.server.whitelist);
    // rust: assert_eq!(back.properties["spawn-protection"], toml::Value::Integer(4));
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}
}
