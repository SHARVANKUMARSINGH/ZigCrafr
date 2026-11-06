//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_mod_list
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Which of the installed Horizon mods are on (`docs/mods.md`), kept in
//! `horizon-mods.txt` beside `options.txt` as `mod.<id>:true` lines. Every
//! mod is off until the player turns it on in Options > Mods. A native mod is
//! built in, so on until turned off (`mod.<id>:false`); the launcher builds
//! only the native mods whose line is `true`.
// use std::{
    // rust: collections::{BTreeMap, BTreeSet},
    // rust: fs,
    // rust: path::Path,
}

pub const FILE: []const u8 = "horizon-mods.txt";
/// The folder holding `.hmod` files, beside `options.txt`.
pub const DIR: []const u8 = "horizon-mods";
/// Where the launcher installs native mods (`<id>.hnmod`), beside [`DIR`]. They run only in a
/// game the launcher built with them.
pub const NATIVE_DIR: []const u8 = "horizon-native-mods";
/// Why a native mod installed in [`NATIVE_DIR`] doesn't run in this game.
pub const NOT_BUILT: []const u8 = "Installed, not built into this game: build the game with it in the launcher (Settings > Native mods), then play the instance that build is in.";

pub const ModList = struct {
    /// Ids of the mods the player turned on.
    enabled: BTreeSet<[]const u8>,
    /// Ids of the native mods the player turned off: they rest
    /// (`native_on`) until the launcher's next build leaves them out.
    disabled: BTreeSet<[]const u8>,
    /// The keys the player chose for mods' keys, mod id → key name → key
    /// (`key.<id>.<name>:key.keyboard.x` lines).
    keys: BTreeMap<[]const u8,
    /// What the Mods page shows, filled by the game from the mods it found.
    installed: std.ArrayList(Installed),
};

/// One installed mod as the Mods page shows it.
pub const Installed = struct {
    id: []const u8,
    /// `Name 1.0` (the file name when the manifest is unreadable).
    title: []const u8,
    description: []const u8,
    /// Why it is not running, when it failed.
    problem: ?[]const u8,
    /// Loaded with `--dev-mod`: always on.
    dev: bool,
    /// A native mod (`game/native_hooks.rs`): built into the game, on until
    /// the player turns it off, and its settings page.
    native: ?NativePage,
};

/// A native mod's settings page: its keys as Key Binds rows, then its
/// buttons. The keys the player chooses are kept in `ModList::keys`.
pub const NativePage = struct {
    /// Each key's name, label and default key (`key.keyboard.z`).
    keys: Vec<[[]const u8,
    buttons: std.ArrayList([]const u8),
};

    // rust: impl ModList {
pub fn load(dir: *Path) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: fs::read_to_string(dir.join(FILE))
    // rust: .map(|t| Self::parse(&t))
    // rust: .unwrap_or_default()
}
pub fn parse(text: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let ids = |value: &str| -> BTreeSet<String> {
    // rust: text.lines()
    // rust: .filter_map(|l| l.split_once(':'))
    // rust: .filter(|(_, v)| v.trim() == value)
    // rust: .filter_map(|(k, _)| k.trim().strip_prefix("mod."))
    // rust: .map(str::to_owned)
    // rust: .collect()
}
    // rust: let (enabled, disabled) = (ids("true"), ids("false"));
    // rust: let mut keys: BTreeMap<String, BTreeMap<String, String>> = BTreeMap::new();
    // rust: for (k, v) in text.lines().filter_map(|l| l.split_once(':')) {
            // Mod ids have no dots; a key's name may.
    // rust: if let Some((id, name)) = k
    // rust: .trim()
    // rust: .strip_prefix("key.")
    // rust: .and_then(|r| r.split_once('.'))
    // rust: {
    // rust: let entry = keys.entry(id.to_owned()).or_default();
    // rust: entry.insert(name.to_owned(), v.trim().to_owned());
}
}
    // rust: Self {
    // rust: enabled,
    // rust: disabled,
    // rust: keys,
    // rust: installed: Vec::new(),
}
}
pub fn serialize(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let on = self.enabled.iter().map(|id| format!("mod.{id}:true\n"));
    // rust: let off = self.disabled.iter().map(|id| format!("mod.{id}:false\n"));
    // rust: let keys = self.keys.iter().flat_map(|(id, keys)| {
    // rust: keys.iter()
    // rust: .map(move |(name, key)| format!("key.{id}.{name}:{key}\n"))
    // rust: });
    // rust: on.chain(off).chain(keys).collect()
}
    /// Mod `id`'s chosen keys, for `Mods::set_bindings`.
pub fn keys_of(self: *Self, id: []const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.keys.get(id).map_or_else(Vec::new, |k| {
    // rust: k.iter().map(|(n, k)| (n.as_str(), k.as_str())).collect()
    // rust: })
}
pub fn save(self: *Self, dir: *Path) void {
}
    // rust: let path = dir.join(FILE);
    // rust: if self.enabled.is_empty()
    // rust: && self.disabled.is_empty()
    // rust: && self.keys.is_empty()
    // rust: && !path.exists()
    // rust: {
    // rust: return;
}
    // rust: let _ = fs::write(path, self.serialize());
}
pub fn is_on(self: *Self, i: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.installed.get(i).is_some_and(|m| {
    // rust: m.dev
    // rust: || if m.native.is_some() {
    // rust: !self.disabled.contains(&m.id)
    // rust: } else {
    // rust: self.enabled.contains(&m.id)
}
    // rust: })
}
    /// Turns installed mod `i` on or off (a dev mod stays on). A native mod's
    /// line says `false` when off, so that the launcher's next build leaves
    /// it out, and `true` when on again.
    /// Turn the installed mod `id` on (nothing when it isn't installed).
pub fn turn_on(self: *Self, id: []const u8) void {
}
    // rust: let Some(m) = self.installed.iter().find(|m| m.id == id && !m.dev) else {
    // rust: return;
}
    // rust: if m.native.is_some() {
    // rust: self.disabled.remove(&m.id);
}
    // rust: self.enabled.insert(m.id.clone());
}
pub fn toggle(self: *Self, i: usize) void {
}
    // rust: let Some(m) = self.installed.get(i).filter(|m| !m.dev) else {
    // rust: return;
}
    // rust: if m.native.is_some() {
    // rust: if self.disabled.remove(&m.id) {
    // rust: self.enabled.insert(m.id.clone());
    // rust: } else {
    // rust: self.enabled.remove(&m.id);
    // rust: self.disabled.insert(m.id.clone());
}
    // rust: } else if !self.enabled.remove(&m.id) {
    // rust: self.enabled.insert(m.id.clone());
}
}
}

    // rust: mod tests {
//     use super::*;

pub fn round_trips_and_ignores_the_rest() void {
}
    // rust: let list = ModList::parse("mod.coords_hud:true\nmod.other:false\nzoom:true\n");
    // rust: assert_eq!(list.enabled.iter().collect::<Vec<_>>(), ["coords_hud"]);
    // rust: assert_eq!(ModList::parse(&list.serialize()), list);
    // rust: assert_eq!(ModList::default().serialize(), "");
}

pub fn keeps_the_keys_players_chose() void {
}
    // rust: let text = "mod.zoom:true\nkey.zoom.zoom.in:key.mouse.4\nkey.zoom.out:key.keyboard.x\n";
    // rust: let list = ModList::parse(text);
    // rust: assert_eq!(
    // rust: list.keys_of("zoom"),
    // rust: [("out", "key.keyboard.x"), ("zoom.in", "key.mouse.4")]
    // rust: );
    // rust: assert!(list.keys_of("other").is_empty());
    // rust: assert_eq!(ModList::parse(&list.serialize()), list);
}

pub fn toggles_installed_and_native_mods_but_not_dev_ones() void {
}
    // rust: let installed = |id: &str, dev| Installed {
    // rust: id: id.into(),
    // rust: title: id.into(),
    // rust: description: String::new(),
    // rust: problem: None,
    // rust: dev,
    // rust: native: None,
}
    // rust: let mut list = ModList {
    // rust: installed: vec![installed("a", false), installed("b", true)],
    // rust: ..Default::default()
}
    // rust: assert!(!list.is_on(0) && list.is_on(1));
    // rust: list.toggle(0);
    // rust: list.toggle(1);
    // rust: assert!(list.is_on(0) && list.is_on(1));
    // rust: assert_eq!(list.serialize(), "mod.a:true\n");
    // rust: list.toggle(0);
    // rust: assert!(!list.is_on(0));
    // rust: list.installed.push(Installed {
    // rust: native: Some(NativePage::default()),
    // rust: ..installed("c", false)
    // rust: });
        // On until turned off; off, the launcher leaves it out.
    // rust: assert!(list.is_on(2));
    // rust: list.toggle(2);
    // rust: assert!(!list.is_on(2));
    // rust: assert_eq!(list.serialize(), "mod.c:false\n");
    // rust: assert_eq!(ModList::parse(&list.serialize()).disabled, list.disabled);
    // rust: list.toggle(2);
    // rust: assert!(list.is_on(2));
    // rust: assert_eq!(list.serialize(), "mod.c:true\n");
}
}
