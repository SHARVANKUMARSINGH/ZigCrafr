//! Transpiled from Horizon Rust crate
//! Module: horizon-client_native_configs
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Native mods' config files, loaded and reloaded (NeoForge's `ModConfig`
//! and `ModConfigEvent`, docs/native-mods.md). A mod lists its configs
//! (`native_register_configs`), each a file of a kind: `Client` on the
//! window, `Common` once per process (the window, or a dedicated server),
//! `Server` on the server for each world it opens, which a world may
//! override in its `serverconfig/` folder. The game writes a missing file's
//! default text, reads it and hands the text to the mod
//! (`native_config_loading`); the mod parses it. Once a second it looks at
//! each file's modification time and hands changed text over again
//! (`native_config_reloading`). A server's configs are dropped when it stops
//! (`native_config_unloading`).
// use super::Game;
// use std::fs;
// use std::path::{Component, Path, PathBuf};
// use std::time::{Duration, Instant, SystemTime};

/// How often the files' modification times are read.
pub const CHECK_EVERY: Duration = Duration::from_secs(1);

/// Which side reads a config and when (NeoForge's `ModConfig.Type`).
pub const NativeConfigKind = enum {
    /// The window only, when the game starts.
    Client,
    /// Once per process: the window when the game starts, or a dedicated
    /// server when it starts. A single player's server thread shares the
    /// window's.
    Common,
    /// The server, before `native_server_about_to_start`, for each world it
    /// opens: the world's `serverconfig/<file>` when there is one, else
    /// `config/<file>`.
    Server,
};

    // rust: impl NativeConfigKind {
    /// The default file name's suffix, as NeoForge's.
pub fn suffix(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Client => "client",
    // rust: Self::Common => "common",
    // rust: Self::Server => "server",
}
}
}

/// A config a mod registers: its kind, its file in `config/` and the text
/// written there when the file is missing.
pub const NativeConfig = struct {
    mod_id: []const u8,
    kind: NativeConfigKind,
    /// A path relative to `config/`: `<mod id>-<kind>.toml` unless named.
    file: []const u8,
    default: []const u8,
};

    // rust: impl NativeConfig {
    /// `config/<mod_id>-<kind>.toml`, `default` when missing.
pub fn new(mod_id: []const u8, kind: NativeConfigKind, default: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: mod_id: mod_id.to_owned(),
    // rust: kind,
    // rust: file: format!("{mod_id}-{}.toml", kind.suffix()),
    // rust: default: default.to_owned(),
}
}
    /// The same in another file of `config/`, such as `mymod/machines.toml`.
pub fn file(file: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: file.clone_into(&mut self.file);
    // rust: self
}
}

/// A config's file as the game read it.
pub const NativeConfigFile = struct {
    mod_id: []const u8,
    kind: NativeConfigKind,
    /// The registered name, relative to `config/`.
    file: []const u8,
    /// Where it was read: in `config/`, or a world's `serverconfig/`.
    path: PathBuf,
    text: []const u8,
};

/// A loaded config and what its file looked like when read.
pub const Tracked = struct {
    config: NativeConfigFile,
    modified: ?SystemTime,
};

/// One game's configs: the window's, a server thread's or a dedicated
/// server's.
    // rust: pub(super) struct NativeConfigs {
    // rust: started: bool,
    // rust: files: Vec<Tracked>,
    // rust: next_check: Option<Instant>,
}

/// Whether `file` stays inside the folder it is joined to.
pub fn inside(file: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let path = Path::new(file);
    // rust: path.components().next().is_some()
    // rust: && path.components().all(|c| matches!(c, Component::Normal(_)))
}

/// The file `config` is read from: the world's `serverconfig/` copy of a
/// server config when there is one, else `config_dir`'s, written from the
/// default when missing.
    // rust: fn locate(
    // rust: config: &NativeConfig,
    // rust: config_dir: &Path,
    // rust: world: Option<&Path>,
    // rust: ) -> std::io::Result<PathBuf> {
    // rust: if config.kind == NativeConfigKind::Server
    // rust: && let Some(world) = world
    // rust: {
    // rust: let own = world.join("serverconfig").join(&config.file);
    // rust: if own.is_file() {
    // rust: return Ok(own);
}
}
    // rust: let path = config_dir.join(&config.file);
    // rust: if !path.exists() {
    // rust: if let Some(parent) = path.parent() {
    // rust: fs::create_dir_all(parent)?;
}
    // rust: fs::write(&path, &config.default)?;
}
    // rust: Ok(path)
}

pub fn modified(path: *Path) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: fs::metadata(path).and_then(|m| m.modified()).ok()
}

    // rust: impl NativeConfigs {
    /// Reads `configs` of `kinds` (a duplicate path or a file outside
    /// `config/` is skipped) and answers each loaded file.
    // rust: fn load(
    // rust: &mut self,
    // rust: configs: Vec<NativeConfig>,
    // rust: kinds: &[NativeConfigKind],
    // rust: config_dir: &Path,
    // rust: world: Option<&Path>,
    // rust: ) -> Vec<NativeConfigFile> {
    // rust: self.started = true;
    // rust: let mut loaded = Vec::new();
    // rust: for config in configs.into_iter().filter(|c| kinds.contains(&c.kind)) {
    // rust: if !inside(&config.file) {
    // rust: log::warn!(
    // rust: "Horizon: mod {} config {:?} is not a file in config/",
    // rust: config.mod_id,
    // rust: config.file
    // rust: );
    // rust: continue;
}
    // rust: let path = match locate(&config, config_dir, world) {
    // rust: Ok(path) => path,
    // rust: Err(e) => {
    // rust: log::warn!("Horizon: mod {} config {}: {e}", config.mod_id, config.file);
    // rust: continue;
}
}
    // rust: if self.files.iter().any(|t| t.config.path == path) {
    // rust: log::warn!(
    // rust: "Horizon: mod {} config {} is registered twice",
    // rust: config.mod_id,
    // rust: path.display()
    // rust: );
    // rust: continue;
}
    // rust: let modified = modified(&path);
    // rust: let text = match fs::read_to_string(&path) {
    // rust: Ok(text) => text,
    // rust: Err(e) => {
    // rust: log::warn!(
    // rust: "Horizon: mod {} config {}: {e}",
    // rust: config.mod_id,
    // rust: path.display()
    // rust: );
    // rust: continue;
}
}
    // rust: let file = NativeConfigFile {
    // rust: mod_id: config.mod_id,
    // rust: kind: config.kind,
    // rust: file: config.file,
    // rust: path,
    // rust: text,
}
    // rust: loaded.push(file.clone());
    // rust: self.files.push(Tracked {
    // rust: config: file,
    // rust: modified,
    // rust: });
}
    // rust: loaded
}

    /// The files whose text changed since they were read, read again; a
    /// file that is gone or unreadable keeps its last text.
pub fn changed(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut changed = Vec::new();
    // rust: for tracked in &mut self.files {
    // rust: let now = modified(&tracked.config.path);
    // rust: if now.is_none() || now == tracked.modified {
    // rust: continue;
}
    // rust: let Ok(text) = fs::read_to_string(&tracked.config.path) else {
    // rust: continue;
}
    // rust: tracked.modified = now;
    // rust: if text != tracked.config.text {
    // rust: tracked.config.text = text;
    // rust: changed.push(tracked.config.clone());
}
}
    // rust: changed
}

    /// Whether a second passed since the last look at the files.
pub fn due(self: *Self, now: Instant) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.files.is_empty() || self.next_check.is_some_and(|t| now < t) {
    // rust: return false;
}
    // rust: self.next_check = Some(now + CHECK_EVERY);
    // rust: true
}

    /// Drops the server's configs and answers them.
pub fn drop_server(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (server, rest) = std::mem::take(&mut self.files)
    // rust: .into_iter()
    // rust: .partition(|t| t.config.kind == NativeConfigKind::Server);
    // rust: self.files = rest;
    // rust: server.into_iter().map(|t| t.config).collect()
}
}

    // rust: impl Game<'_> {
    /// Asks the mods for their configs and loads those of `kinds`.
pub fn native_configs_load(self: *Self, kinds: *[NativeConfigKind], world: ?*Path) void {
}
    // rust: let config_dir = match Self::native_config_dir() {
    // rust: Ok(dir) => dir,
    // rust: Err(e) => {
    // rust: log::warn!("Horizon: mod configs: {e}");
    // rust: return;
}
}
    // rust: let mut configs = Vec::new();
    // rust: self.native_register_configs(&mut configs);
    // rust: if configs.is_empty() {
    // rust: self.native_configs.started = true;
    // rust: return;
}
    // rust: for file in self.native_configs.load(configs, kinds, &config_dir, world) {
    // rust: self.native_config_loading(&file);
}
}

    /// The window's `Client` and `Common` configs, once: on its first frame
    /// step, or before it starts a world's server thread if that comes first.
    // rust: pub(super) fn native_configs_client_start(&mut self) {
    // rust: if !self.native_configs.started {
//             use NativeConfigKind::{Client, Common};
    // rust: self.native_configs_load(&[Client, Common], None);
}
}

    /// The window's frame step: its configs load on the first, and changed
    /// files reload once a second.
    // rust: pub(super) fn native_configs_tick_client(&mut self) {
    // rust: self.native_configs_client_start();
    // rust: self.native_configs_poll();
}

    /// A server about to open `world`: a dedicated server loads its
    /// `Common` configs too, a single player's server thread only `Server`.
    // rust: pub(super) fn native_configs_server_start(&mut self, world: &Path, dedicated: bool) {
//         use NativeConfigKind::{Common, Server};
    // rust: let kinds: &[NativeConfigKind] = if dedicated && !self.native_configs.started {
    // rust: &[Common, Server]
    // rust: } else {
    // rust: &[Server]
}
    // rust: self.native_configs_load(kinds, Some(world));
}

    /// The server stops: its `Server` configs unload.
    // rust: pub(super) fn native_configs_server_stop(&mut self) {
    // rust: for file in self.native_configs.drop_server() {
    // rust: self.native_config_unloading(&file);
}
}

    /// Hands changed files over again, at most once a second.
    // rust: pub(super) fn native_configs_poll(&mut self) {
    // rust: if !self.native_configs.due(Instant::now()) {
    // rust: return;
}
    // rust: for file in self.native_configs.changed() {
    // rust: self.native_config_reloading(&file);
}
}
}

    // rust: mod tests {
//     use super::*;
//     use NativeConfigKind::{Client, Common, Server};

pub const Folder = struct {};

    // rust: impl Folder {
pub fn new(name: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let dir = std::env::temp_dir().join(format!(
    // rust: "horizon-native-configs-{name}-{}",
    // rust: std::process::id()
    // rust: ));
    // rust: let _ = fs::remove_dir_all(&dir);
    // rust: fs::create_dir_all(&dir).unwrap();
    // rust: Self(dir)
}
}

    // rust: impl Drop for Folder {
pub fn drop(self: *Self) void {
}
    // rust: let _ = fs::remove_dir_all(&self.0);
}
}

    /// A time after `path`'s, so the next look sees a change even on a file
    /// system that keeps whole seconds.
pub fn touch_later(path: *Path, text: []const u8) void {
}
    // rust: let before = modified(path).unwrap();
    // rust: fs::write(path, text).unwrap();
    // rust: let file = fs::File::options().write(true).open(path).unwrap();
    // rust: file.set_modified(before + Duration::from_secs(2)).unwrap();
}

pub fn a_missing_file_gets_its_default_and_an_edited_one_is_read() void {
}
    // rust: let root = Folder::new("default");
    // rust: let config = root.0.join("config");
    // rust: fs::create_dir_all(&config).unwrap();
    // rust: fs::write(config.join("gt-common.toml"), "voltage = 512\n").unwrap();
    // rust: let mut configs = NativeConfigs::default();
    // rust: let loaded = configs.load(
    // rust: vec![
    // rust: NativeConfig::new("gt", Client, "hud = true\n"),
    // rust: NativeConfig::new("gt", Common, "voltage = 32\n"),
    // rust: NativeConfig::new("gt", Server, "ores = 1\n"),
    // rust: ],
    // rust: &[Client, Common],
    // rust: &config,
    // rust: None,
    // rust: );
    // rust: let got: Vec<_> = loaded
    // rust: .iter()
    // rust: .map(|f| (f.file.as_str(), f.text.as_str()))
    // rust: .collect();
    // rust: assert_eq!(
    // rust: got,
    // rust: [
    // rust: ("gt-client.toml", "hud = true\n"),
    // rust: ("gt-common.toml", "voltage = 512\n")
    // rust: ]
    // rust: );
    // rust: assert_eq!(
    // rust: fs::read_to_string(config.join("gt-client.toml")).unwrap(),
    // rust: "hud = true\n"
    // rust: );
        // Another side's kind is neither read nor written.
    // rust: assert!(!config.join("gt-server.toml").exists());
}

pub fn a_world_overrides_a_server_config_and_the_folder_serves_the_rest() void {
}
    // rust: let root = Folder::new("world");
    // rust: let (config, world) = (root.0.join("config"), root.0.join("saves/W"));
    // rust: fs::create_dir_all(world.join("serverconfig/gt")).unwrap();
    // rust: fs::write(world.join("serverconfig/gt/ores.toml"), "veins = 9\n").unwrap();
    // rust: let mut configs = NativeConfigs::default();
    // rust: let loaded = configs.load(
    // rust: vec![
    // rust: NativeConfig::new("gt", Server, "veins = 3\n").file("gt/ores.toml"),
    // rust: NativeConfig::new("gt", Server, "tiers = 4\n"),
                // A Common config of the world's folder is not looked for.
    // rust: NativeConfig::new("gt", Common, "a = 1\n"),
    // rust: ],
    // rust: &[Server],
    // rust: &config,
    // rust: Some(&world),
    // rust: );
    // rust: let got: Vec<_> = loaded
    // rust: .iter()
    // rust: .map(|f| (f.path.clone(), f.text.as_str()))
    // rust: .collect();
    // rust: assert_eq!(
    // rust: got,
    // rust: [
    // rust: (world.join("serverconfig/gt/ores.toml"), "veins = 9\n"),
    // rust: (config.join("gt-server.toml"), "tiers = 4\n"),
    // rust: ]
    // rust: );
        // The world's copy stands for the default: nothing is written beside it.
    // rust: assert!(!config.join("gt/ores.toml").exists());
    // rust: assert_eq!(configs.drop_server().len(), 2);
    // rust: assert!(configs.files.is_empty());
}

pub fn a_file_outside_config_or_registered_twice_is_skipped() void {
}
    // rust: let root = Folder::new("skip");
    // rust: let config = root.0.join("config");
    // rust: let mut configs = NativeConfigs::default();
    // rust: let loaded = configs.load(
    // rust: vec![
    // rust: NativeConfig::new("a", Common, "x").file("../options.txt"),
    // rust: NativeConfig::new("a", Common, "x").file(""),
    // rust: NativeConfig::new("a", Common, "first"),
    // rust: NativeConfig::new("b", Common, "second").file("a-common.toml"),
    // rust: ],
    // rust: &[Common],
    // rust: &config,
    // rust: None,
    // rust: );
    // rust: assert_eq!(
    // rust: loaded.iter().map(|f| f.mod_id.as_str()).collect::<Vec<_>>(),
    // rust: ["a"]
    // rust: );
    // rust: assert!(!root.0.join("options.txt").exists());
}

pub fn a_change_reloads_once_and_a_touch_without_one_does_not() void {
}
    // rust: let root = Folder::new("reload");
    // rust: let config = root.0.join("config");
    // rust: let mut configs = NativeConfigs::default();
    // rust: configs.load(
    // rust: vec![NativeConfig::new("gt", Common, "a = 1\n")],
    // rust: &[Common],
    // rust: &config,
    // rust: None,
    // rust: );
    // rust: let path = config.join("gt-common.toml");
    // rust: assert!(configs.changed().is_empty());
    // rust: touch_later(&path, "a = 2\n");
    // rust: let changed = configs.changed();
    // rust: assert_eq!(
    // rust: changed.iter().map(|f| f.text.as_str()).collect::<Vec<_>>(),
    // rust: ["a = 2\n"]
    // rust: );
    // rust: assert!(configs.changed().is_empty());
        // Saved again with the same text: nothing to reload.
    // rust: touch_later(&path, "a = 2\n");
    // rust: assert!(configs.changed().is_empty());
        // Gone: the last text stays, and nothing fires.
    // rust: fs::remove_file(&path).unwrap();
    // rust: assert!(configs.changed().is_empty());
    // rust: assert_eq!(configs.files[0].config.text, "a = 2\n");
}

pub fn files_are_looked_at_once_a_second_and_never_without_configs() void {
}
    // rust: let mut configs = NativeConfigs::default();
    // rust: let start = Instant::now();
    // rust: assert!(!configs.due(start));
    // rust: configs.files.push(Tracked {
    // rust: config: NativeConfigFile {
    // rust: mod_id: "gt".into(),
    // rust: kind: Common,
    // rust: file: "gt-common.toml".into(),
    // rust: path: PathBuf::new(),
    // rust: text: String::new(),
    // rust: },
    // rust: modified: None,
    // rust: });
    // rust: assert!(configs.due(start));
    // rust: assert!(!configs.due(start + Duration::from_millis(999)));
    // rust: assert!(configs.due(start + CHECK_EVERY));
}
}
