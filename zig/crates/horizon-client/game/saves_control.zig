//! Transpiled from Horizon Rust crate
//! Module: horizon-client_saves_control
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Worlds and the multiplayer server list from the control socket: what the Select World, Edit
//! World and Multiplayer screens do, by world folder. Changing a world needs the title screen
//! (no world open), as those screens do; deleting one needs `--confirm`.
// use super::Game;
// use horizon_client::{Result, title};
// use serde_json::{Value, json};
// use std::{path::PathBuf, sync::mpsc::Sender, time::UNIX_EPOCH};

    // rust: pub(super) const HELP: &[&str] = &[
    // rust: "worlds                         the saved worlds, newest first: folder, name, mode, last played, version",
    // rust: "world-rename FOLDER NAME       rename a world (Edit World; its folder stays)",
    // rust: "world-backup FOLDER            zip a world into backups/ (Edit World > Make Backup)",
    // rust: "world-delete FOLDER --confirm  delete a world for good (Select World > Delete)",
    // rust: "servers                        the multiplayer server list (servers.dat): name and address",
    // rust: ];

pub fn saves() R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(std::env::current_dir()?.join("saves"))
}

    // rust: impl Game<'_> {
    /// Some(reply) for these commands (Some(None): the reply comes later), None for others.
    // rust: pub(super) fn saves_control(
    // rust: &mut self,
    // rust: words: &[&str],
    // rust: line: &str,
    // rust: reply: &Sender<String>,
    // rust: ) -> Result<Option<Option<Value>>> {
    // rust: let folder = || {
    // rust: words
    // rust: .get(1)
    // rust: .copied()
    // rust: .ok_or_else(|| format!("{} FOLDER: the folder from worlds", words[0]))
}
    // rust: let on_title = || {
    // rust: if self.title.is_some() {
    // rust: Ok(())
    // rust: } else {
    // rust: Err(format!(
    // rust: "{} needs the title screen: save and leave the world first (pause, then Save and Quit to Title)",
    // rust: words[0]
    // rust: ))
}
}
    // rust: let value = match words[0] {
    // rust: "worlds" => {
    // rust: let worlds: Vec<Value> = title::list_worlds(&saves()?)
    // rust: .iter()
    // rust: .map(|w| {
    // rust: json!({
    // rust: "folder": w.folder,
    // rust: "name": w.name,
    // rust: "mode": if w.game_mode == 1 { "creative" } else { "survival" },
    // rust: "last_played": w.modified.duration_since(UNIX_EPOCH).map_or(0, |d| d.as_millis() as u64),
    // rust: "commands": w.commands,
    // rust: "version": w.version,
    // rust: "corrupted": w.corrupted,
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: json!({ "worlds": worlds })
}
    // rust: "world-rename" => {
    // rust: on_title()?;
    // rust: let folder = folder()?;
    // rust: let name = line
    // rust: .trim_start()
    // rust: .strip_prefix("world-rename")
    // rust: .and_then(|rest| rest.trim_start().strip_prefix(folder))
    // rust: .map(str::trim)
    // rust: .filter(|n| !n.is_empty())
    // rust: .ok_or("world-rename FOLDER NAME: missing the new name")?;
    // rust: title::world_management::rename(&saves()?, folder, name)?;
    // rust: if let Some(title) = self.title.as_mut() {
    // rust: title.worlds_changed();
}
    // rust: json!({ "ok": true, "folder": folder, "name": name })
}
    // rust: "world-delete" => {
    // rust: on_title()?;
    // rust: let folder = folder()?;
    // rust: if !words.contains(&"--confirm") {
    // rust: return Err(format!(
    // rust: "world-delete deletes {folder} for good: ask the player, then add --confirm"
    // rust: )
    // rust: .into());
}
    // rust: title::world_management::delete(&saves()?, folder)?;
    // rust: if let Some(title) = self.title.as_mut() {
    // rust: title.worlds_changed();
}
    // rust: json!({ "ok": true, "deleted": folder })
}
    // rust: "world-backup" => {
    // rust: on_title()?;
    // rust: let folder = folder()?.to_owned();
    // rust: let saves = saves()?;
    // rust: let backups = title::world_management::backups_path(&saves);
                // A big world takes a while to zip: off the game thread, as Make Backup does.
    // rust: let reply = reply.clone();
    // rust: std::thread::spawn(move || {
    // rust: let answer = match title::world_management::backup(&saves, &folder) {
    // rust: Ok(bytes) => {
    // rust: json!({ "ok": true, "folder": folder, "backups": backups, "bytes": bytes })
}
    // rust: Err(e) => json!({ "error": format!("backup of {folder} failed: {e}") }),
}
    // rust: let _ = reply.send(answer.to_string());
    // rust: });
    // rust: return Ok(Some(None));
}
    // rust: "servers" => {
    // rust: let file = horizon_client::multiplayer::servers_file(&saves()?);
    // rust: let servers: Vec<Value> = horizon_protocol::servers::load(&file)
    // rust: .iter()
    // rust: .map(|s| json!({ "name": s.name, "address": s.ip }))
    // rust: .collect();
    // rust: json!({ "servers": servers })
}
    // rust: _ => return Ok(None),
}
    // rust: Ok(Some(Some(value)))
}
}
