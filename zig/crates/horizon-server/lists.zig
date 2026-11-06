//! Transpiled from Horizon Rust crate
//! Module: horizon-server_lists
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `op`, `deop`, `whitelist`, `ban`, `pardon`, `ban-ip` and `pardon-ip`. While the server runs, the game
//! owns the lists: the command goes to its console. While it is stopped, they edit vanilla's files with the
//! code the game reads them with (horizon-server-files) and answer with vanilla's console messages.
//!
//! One exception: `whitelist add` on a running offline server. The game asks Mojang for the name first, as
//! vanilla does, so a name someone owns gets that account's UUID, and the player, who joins under the
//! offline UUID, is still refused. There the offline entry is written to whitelist.json and the game
//! reloads it (`whitelist reload`), as it would be written while the server is stopped.

// use crate::{config, supervisor};
// use horizon_server_files::user_lists::{
    // rust: BanEntry, BanList, IpBanList, NameAndId, OpEntry, OpList, WhiteEntry, WhiteList,
}
// use std::path::Path;

pub fn run(dir: *Path, command: []const u8, args: *[[]const u8]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let config = config::Config::load(dir)?;
    // Holding the folder's lock keeps the server from starting halfway through.
    // rust: let Ok(_lock) = supervisor::lock(dir) else {
    // rust: if let ("whitelist", [add, name]) = (command, args)
    // rust: && add == "add"
    // rust: && !config.server.online_mode
    // rust: {
    // rust: return add_offline(dir, name);
}
    // rust: let mut words = vec![command.to_owned()];
    // rust: words.extend_from_slice(args);
    // rust: return crate::cli::command(dir, &words);
}
    // rust: let args: Vec<&str> = args.iter().map(String::as_str).collect();
    // rust: let edit = edit_locked(dir, &config, command, &args)?;
    // rust: println!("{}", edit.message);
    // rust: Ok(())
}

/// An edit to one of the vanilla lists, with the console line it would print.
pub const Edit = struct {
    changed: bool,
    message: []const u8,
};

/// Edits a file-backed list while the supervisor owns the server lock and the game is stopped.
pub fn edit_stopped(dir: *Path, command: []const u8, args: *[[]const u8]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let config = config::Config::load(dir)?;
    // rust: edit_locked(dir, &config, command, args)
}

    // rust: fn edit_locked(
    // rust: dir: &Path,
    // rust: config: &config::Config,
    // rust: command: &str,
    // rust: args: &[&str],
    // rust: ) -> Result<Edit, String> {
    // rust: let ops_path = dir.join("ops.json");
    // rust: let white_path = dir.join("whitelist.json");
    // rust: let (changed, message) = match (command, args) {
    // rust: ("op", [name]) => {
    // rust: let mut ops = load(OpList::new(ops_path))?;
    // rust: let user = account(name, config.server.online_mode)?;
    // rust: if ops.contains(&user) {
    // rust: (
    // rust: false,
    // rust: "Nothing changed. The player already is an operator".to_owned(),
    // rust: )
    // rust: } else {
    // rust: ops.add(OpEntry {
    // rust: user,
    // rust: level: 4,
    // rust: bypasses_player_limit: false,
    // rust: });
    // rust: (true, format!("Made {name} a server operator"))
}
}
    // rust: ("deop", [name]) => {
    // rust: let mut ops = load(OpList::new(ops_path))?;
    // rust: let user = listed(ops.entries().iter().map(|e| &e.user), name);
    // rust: if user.is_some_and(|user| ops.remove(&user)) {
    // rust: (true, format!("Made {name} no longer a server operator"))
    // rust: } else {
    // rust: (
    // rust: false,
    // rust: "Nothing changed. The player is not an operator".to_owned(),
    // rust: )
}
}
    // rust: ("whitelist", ["add", name]) => {
    // rust: let mut white = load(WhiteList::new(white_path))?;
    // rust: let user = account(name, config.server.online_mode)?;
    // rust: if white.contains(&user) {
    // rust: (false, "Player is already whitelisted".to_owned())
    // rust: } else {
    // rust: white.add(WhiteEntry { user });
    // rust: (true, format!("Added {name} to the whitelist"))
}
}
    // rust: ("whitelist", ["remove", name]) => {
    // rust: let mut white = load(WhiteList::new(white_path))?;
    // rust: let user = listed(white.entries().iter().map(|e| &e.user), name);
    // rust: if user.is_some_and(|user| white.remove(&user)) {
    // rust: (true, format!("Removed {name} from the whitelist"))
    // rust: } else {
    // rust: (false, "Player is not whitelisted".to_owned())
}
}
    // rust: ("whitelist", [state @ ("on" | "off")]) => {
    // rust: let on = *state == "on";
    // rust: match (on, config.server.whitelist) {
    // rust: (true, true) => (false, "Whitelist is already turned on".to_owned()),
    // rust: (false, false) => (false, "Whitelist is already turned off".to_owned()),
    // rust: _ => {
    // rust: config::update(dir, "server", "whitelist", toml::Value::Boolean(on))?;
    // rust: (true, format!("Whitelist is now turned {state}"))
}
}
}
    // rust: ("whitelist", ["list"]) => {
    // rust: let white = load(WhiteList::new(white_path))?;
    // rust: let names: Vec<String> = white
    // rust: .entries()
    // rust: .iter()
    // rust: .map(|e| e.user.name.clone())
    // rust: .collect();
    // rust: let state = if config.server.whitelist { "on" } else { "off" };
    // rust: if names.is_empty() {
    // rust: (
    // rust: false,
    // rust: format!("There are no whitelisted players (the whitelist is {state})"),
    // rust: )
    // rust: } else {
    // rust: (
    // rust: false,
    // rust: format!(
    // rust: "There are {} whitelisted player(s): {} (the whitelist is {state})",
    // rust: names.len(),
    // rust: names.join(", ")
    // rust: ),
    // rust: )
}
}
    // rust: ("ban", [name, rest @ ..]) => {
    // rust: let user = account(name, config.server.online_mode)?;
    // rust: let reason = reason(rest);
    // rust: let mut bans = load(BanList::new(dir.join("banned-players.json")))?;
    // rust: if bans.add(BanEntry::new(
    // rust: user,
    // rust: Some("Server".into()),
    // rust: None,
    // rust: reason.clone(),
    // rust: )) {
    // rust: (
    // rust: true,
    // rust: format!(
    // rust: "Banned {name}: {}",
    // rust: reason.as_deref().unwrap_or("Banned by an operator.")
    // rust: ),
    // rust: )
    // rust: } else {
    // rust: (
    // rust: false,
    // rust: "Nothing changed. The player is already banned".to_owned(),
    // rust: )
}
}
    // rust: ("pardon", [name]) => {
    // rust: let mut bans = load(BanList::new(dir.join("banned-players.json")))?;
    // rust: let user = listed(bans.entries().iter().map(|e| &e.user), name);
    // rust: if user.as_ref().is_some_and(|user| bans.remove(user)) {
    // rust: (true, format!("Unbanned {name}"))
    // rust: } else {
    // rust: (false, "Nothing changed. The player isn't banned".to_owned())
}
}
    // rust: ("ban-ip", [ip, rest @ ..]) => {
    // rust: if ip.parse::<std::net::IpAddr>().is_err() {
    // rust: return Err("Invalid IP address or unknown player".into());
}
    // rust: let reason = reason(rest);
    // rust: let mut bans = load(IpBanList::new(dir.join("banned-ips.json")))?;
    // rust: if bans.add(BanEntry::new(
    // rust: (*ip).to_owned(),
    // rust: Some("Server".into()),
    // rust: None,
    // rust: reason.clone(),
    // rust: )) {
    // rust: (
    // rust: true,
    // rust: format!(
    // rust: "Banned IP {ip}: {}",
    // rust: reason.as_deref().unwrap_or("Banned by an operator.")
    // rust: ),
    // rust: )
    // rust: } else {
    // rust: (
    // rust: false,
    // rust: "Nothing changed. That IP is already banned".to_owned(),
    // rust: )
}
}
    // rust: ("pardon-ip", [ip]) => {
    // rust: if ip.parse::<std::net::IpAddr>().is_err() {
    // rust: return Err("Invalid IP address".into());
}
    // rust: let mut bans = load(IpBanList::new(dir.join("banned-ips.json")))?;
    // rust: if bans.remove(&(*ip).to_owned()) {
    // rust: (true, format!("Unbanned IP {ip}"))
    // rust: } else {
    // rust: (false, "Nothing changed. That IP isn't banned".to_owned())
}
}
    // rust: _ => {
    // rust: return Err(
    // rust: "use: op NAME, deop NAME, whitelist on|off|list, whitelist add|remove NAME, ban NAME [REASON], pardon NAME, ban-ip ADDRESS [REASON], pardon-ip ADDRESS".into(),
    // rust: );
}
}
    // rust: Ok(Edit { changed, message })
}

/// The optional reason after a moderation target is the rest of the command line as one sentence.
pub fn reason(words: *[[]const u8]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (!words.is_empty()).then(|| words.join(" "))
}

/// `whitelist add` on a running offline server: the offline entry, then the game reloads the list.
pub fn add_offline(dir: *Path, name: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if crate::api::Client::open(dir)?.is_none() {
    // rust: return Err(format!("no server is running in {}", dir.display()));
}
    // rust: let user = account(name, false)?;
    // rust: let mut white = load(WhiteList::new(dir.join("whitelist.json")))?;
    // rust: if white.contains(&user) {
    // rust: println!("Player is already whitelisted");
    // rust: return Ok(());
}
    // rust: white.add(WhiteEntry { user });
    // rust: white
    // rust: .save()
    // rust: .map_err(|e| format!("{}: {e}", white.file.display()))?;
    // rust: crate::cli::command(dir, &["whitelist".to_owned(), "reload".to_owned()])?;
    // rust: println!("Added {name} to the whitelist");
    // rust: Ok(())
}

/// The profile a running server would store for `name`: the offline one, or in online mode the account the
/// services know by that name.
pub fn account(name: []const u8, online: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: horizon_server_files::profiles::resolve(name, online).ok_or_else(|| {
    // rust: if online {
    // rust: format!("That player does not exist (no Minecraft account is named {name}, or the services didn't answer)")
    // rust: } else {
    // rust: "That player does not exist".to_owned()
}
    // rust: })
}

/// The entry already on a list under `name` (any case), so removing needs no lookup.
    // rust: fn listed<'a>(mut users: impl Iterator<Item = &'a NameAndId>, name: &str) -> Option<NameAndId> {
    // rust: users.find(|u| u.name.eq_ignore_ascii_case(name)).cloned()
}

/// A list from its file; a missing file is an empty list, a broken one an error (vanilla would replace it).
    // rust: fn load<E: horizon_server_files::user_lists::Entry>(
    // rust: mut list: horizon_server_files::user_lists::UserList<E>,
    // rust: ) -> Result<horizon_server_files::user_lists::UserList<E>, String> {
    // UserList::load deliberately tolerates I/O errors for the running game's vanilla behavior.
    // A stopped command must not edit an empty replacement for a file it could not read.
    // rust: let text = match std::fs::read_to_string(&list.file) {
    // rust: Ok(text) => text,
    // rust: Err(error) if error.kind() == std::io::ErrorKind::NotFound => return Ok(list),
    // rust: Err(error) => return Err(format!("{}: {error}", list.file.display())),
}
    // rust: list.load_str(&text)
    // rust: .map_err(|e| format!("{}: {e}", list.file.display()))?;
    // rust: Ok(list)
}

    // rust: mod tests {
//     use super::*;

pub fn unreadable_lists_are_rejected(name: []const u8, directory: bool, bytes: []const u8) void {
}
    // rust: let dir = std::env::temp_dir().join(format!(
    // rust: "horizon-server-unreadable-lists-{name}-{}",
    // rust: std::process::id()
    // rust: ));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: let commands: &[(&str, &[&str], &str)] = &[
    // rust: ("op", &["Alex"], "ops.json"),
    // rust: ("deop", &["Alex"], "ops.json"),
    // rust: ("whitelist", &["add", "Alex"], "whitelist.json"),
    // rust: ("whitelist", &["remove", "Alex"], "whitelist.json"),
    // rust: ("whitelist", &["list"], "whitelist.json"),
    // rust: ("ban", &["Alex"], "banned-players.json"),
    // rust: ("pardon", &["Alex"], "banned-players.json"),
    // rust: ("ban-ip", &["203.0.113.7"], "banned-ips.json"),
    // rust: ("pardon-ip", &["203.0.113.7"], "banned-ips.json"),
    // rust: ];
    // rust: for (i, &(command, args, file)) in commands.iter().enumerate() {
    // rust: let home = dir.join(i.to_string());
    // rust: std::fs::create_dir_all(&home).unwrap();
    // rust: std::fs::write(home.join(config::FILE), config::TEMPLATE).unwrap();
    // rust: config::update(&home, "server", "online_mode", toml::Value::Boolean(false)).unwrap();
    // rust: let path = home.join(file);
    // rust: if directory {
    // rust: std::fs::create_dir(&path).unwrap();
    // rust: std::fs::write(path.join("sentinel"), bytes).unwrap();
    // rust: } else {
    // rust: std::fs::write(&path, bytes).unwrap();
}
    // rust: match edit_stopped(&home, command, args) {
    // rust: Err(error) => assert!(error.contains(file), "{error}"),
    // rust: Ok(edit) => panic!("{command} accepted unreadable {file}: {}", edit.message),
}
    // rust: let contents = if directory {
    // rust: path.join("sentinel")
    // rust: } else {
    // rust: path
}
    // rust: assert_eq!(std::fs::read(contents).unwrap(), bytes);
}
    // rust: std::fs::remove_dir_all(dir).unwrap();
}

pub fn invalid_utf8_lists_are_not_overwritten_by_stopped_commands() void {
}
    // rust: unreadable_lists_are_rejected("utf8", false, &[0xff, 0xfe]);
}

pub fn directories_are_not_empty_user_lists() void {
}
    // rust: unreadable_lists_are_rejected("directory", true, b"sentinel");
}

pub fn malformed_json_keeps_its_existing_error_and_is_not_overwritten() void {
}
    // rust: unreadable_lists_are_rejected("json", false, b"{invalid JSON");
}

pub fn an_exclusively_open_list_is_not_treated_as_empty() void {
}
//         use std::os::windows::fs::OpenOptionsExt;
    // rust: let dir =
    // rust: std::env::temp_dir().join(format!("horizon-server-denied-list-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: std::fs::write(dir.join(config::FILE), config::TEMPLATE).unwrap();
    // rust: config::update(&dir, "server", "online_mode", toml::Value::Boolean(false)).unwrap();
    // rust: let path = dir.join("ops.json");
    // rust: let original = b"[]";
    // rust: std::fs::write(&path, original).unwrap();
    // rust: let locked = std::fs::OpenOptions::new()
    // rust: .read(true)
    // rust: .share_mode(0)
    // rust: .open(&path)
    // rust: .unwrap();
    // rust: let denied = std::fs::read_to_string(&path).unwrap_err();
    // rust: assert_eq!(
    // rust: denied.raw_os_error(),
    // rust: Some(windows_sys::Win32::Foundation::ERROR_SHARING_VIOLATION as i32)
    // rust: );
    // rust: let rejected = edit_stopped(&dir, "op", &["Alex"]).is_err();
    // rust: drop(locked);
    // rust: assert!(
    // rust: rejected,
    // rust: "an inaccessible existing list must not become an empty list"
    // rust: );
    // rust: assert_eq!(std::fs::read(path).unwrap(), original);
    // rust: std::fs::remove_dir_all(dir).unwrap();
}

pub fn edits_the_lists_while_stopped() void {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-server-lists-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: std::fs::write(dir.join(config::FILE), config::TEMPLATE).unwrap();
        // This test edits local lists; it must not look names up through Mojang's services.
    // rust: config::update(&dir, "server", "online_mode", toml::Value::Boolean(false)).unwrap();
    // rust: let s = |v: &[&str]| v.iter().map(|a| (*a).to_owned()).collect::<Vec<_>>();
        // Each edit takes the folder's lock: retried past a fork-held descriptor (see supervisor::retried).
    // rust: let edit = |v: &[&str]| supervisor::retried(|| run(&dir, v[0], &s(&v[1..])));
    // rust: edit(&["op", "Alex"]).unwrap();
    // rust: edit(&["whitelist", "add", "Steve"]).unwrap();
    // rust: edit(&["whitelist", "off"]).unwrap();
    // rust: assert!(
    // rust: std::fs::read_to_string(dir.join("ops.json"))
    // rust: .unwrap()
    // rust: .contains("Alex")
    // rust: );
    // rust: assert!(
    // rust: std::fs::read_to_string(dir.join("whitelist.json"))
    // rust: .unwrap()
    // rust: .contains("Steve")
    // rust: );
    // rust: assert!(!config::Config::load(&dir).unwrap().server.whitelist);
    // rust: edit(&["deop", "Alex"]).unwrap();
    // rust: assert!(
    // rust: !std::fs::read_to_string(dir.join("ops.json"))
    // rust: .unwrap()
    // rust: .contains("Alex")
    // rust: );
        // A running server owns the lists: without its API, nothing changes.
    // rust: let lock = supervisor::retried(|| supervisor::lock(&dir)).unwrap();
    // rust: assert!(run(&dir, "op", &s(&["Alex"])).is_err());
    // rust: assert!(run(&dir, "whitelist", &s(&["add", "Kai"])).is_err());
    // rust: drop(lock);
    // rust: assert!(
    // rust: !std::fs::read_to_string(dir.join("ops.json"))
    // rust: .unwrap()
    // rust: .contains("Alex")
    // rust: );
    // rust: assert!(
    // rust: !std::fs::read_to_string(dir.join("whitelist.json"))
    // rust: .unwrap()
    // rust: .contains("Kai")
    // rust: );
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}

pub fn stopped_moderation_replies_match_goldens() void {
}
    // rust: let golden: serde_json::Value =
    // rust: serde_json::from_str(include_str!("../testdata/server-admin-cli.json")).unwrap();
    // rust: let dir = std::env::temp_dir().join(format!(
    // rust: "horizon-server-stopped-moderation-goldens-{}",
    // rust: std::process::id()
    // rust: ));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: std::fs::write(dir.join(config::FILE), config::TEMPLATE).unwrap();
    // rust: config::update(&dir, "server", "online_mode", toml::Value::Boolean(false)).unwrap();

    // rust: let check = |case: &str, command: &str, args: &[&str]| {
    // rust: let edit = edit_stopped(&dir, command, args).unwrap();
    // rust: let actual = serde_json::json!({
    // rust: "changed": edit.changed,
    // rust: "output": [edit.message],
    // rust: });
    // rust: assert_eq!(actual, golden[case], "{case}");
}

    // rust: check("ban", "ban", &["Alex", "griefing"]);
    // rust: let mut players = BanList::new(dir.join("banned-players.json"));
    // rust: players.load().unwrap();
    // rust: assert_eq!(players.entries().len(), 1);
    // rust: assert_eq!(players.entries()[0].user.name, "Alex");
    // rust: assert_eq!(players.entries()[0].source, "Server");
    // rust: assert_eq!(players.entries()[0].reason.as_deref(), Some("griefing"));
    // rust: check("ban_again", "ban", &["Alex", "griefing"]);
    // rust: check("pardon", "pardon", &["Alex"]);
    // rust: check("pardon_again", "pardon", &["Alex"]);
    // rust: check("ban_default", "ban", &["Alex"]);

    // rust: check("ban_ip", "ban-ip", &["203.0.113.7", "abuse"]);
    // rust: let mut addresses = IpBanList::new(dir.join("banned-ips.json"));
    // rust: addresses.load().unwrap();
    // rust: assert_eq!(addresses.entries().len(), 1);
    // rust: assert_eq!(addresses.entries()[0].user, "203.0.113.7");
    // rust: assert_eq!(addresses.entries()[0].reason.as_deref(), Some("abuse"));
    // rust: check("ban_ip_again", "ban-ip", &["203.0.113.7", "abuse"]);
    // rust: check("pardon_ip", "pardon-ip", &["203.0.113.7"]);
    // rust: check("pardon_ip_again", "pardon-ip", &["203.0.113.7"]);
    // rust: for (command, message) in [
    // rust: ("ban-ip", "Invalid IP address or unknown player"),
    // rust: ("pardon-ip", "Invalid IP address"),
    // rust: ] {
    // rust: match edit_stopped(&dir, command, &["not-an-ip"]) {
    // rust: Err(error) => assert_eq!(error, message),
    // rust: Ok(_) => panic!("{command} accepted an invalid address"),
}
}
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}
}
