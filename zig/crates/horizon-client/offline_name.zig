//! Transpiled from Horizon Rust crate
//! Module: horizon-client_offline_name
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The offline player name, when neither `--name`, `HORIZON_PLAYER_NAME` nor a
//! signed-in account gives one. Vanilla's client defaults `--username` to
//! `"Player" + System.currentTimeMillis() % 1000` (net.minecraft.client.main.Main)
//! and the official launcher always passes the account's name, so two players
//! rarely share one. Horizon used plain `Player` for everyone, which is also
//! the LAN host's own profile: every guest got the host's offline UUID and was
//! refused with "You logged in from another location". The generated name is
//! kept in `horizon-player.txt` next to `options.txt` so the same player gets
//! the same offline UUID (and inventory on a friend's world) every time.
// use std::{fs, path::Path};

pub const FILE: []const u8 = "horizon-player.txt";
pub const KEY: []const u8 = "name:";

/// StringUtil.isValidPlayerName, plus not empty (the login screen sends at least one character).
pub fn is_valid(name: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: crate::lan::conn::valid_name(name)
}

/// `Player` and five digits (vanilla's default has three: one shared name in a
/// thousand pairs is too many for a game that keeps it).
pub fn generate(seed: u64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: format!("Player{:05}", seed % 100_000)
}

/// The name kept in `dir`, created on first use. A file that can't be written
/// still yields a name for this run.
pub fn load_or_create(dir: *Path) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let path = dir.join(FILE);
    // rust: if let Some(name) = fs::read_to_string(&path).ok().and_then(|text| parse(&text)) {
    // rust: return name;
}
    // rust: let name = generate(seed());
    // rust: if let Err(e) = fs::write(&path, format!("{KEY}{name}\n")) {
    // rust: log::warn!(
    // rust: "Horizon: could not keep the player name in {}: {e}",
    // rust: path.display()
    // rust: );
}
    // rust: name
}

pub fn parse(text: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: text.lines()
    // rust: .find_map(|line| line.trim_end_matches('\r').strip_prefix(KEY))
    // rust: .filter(|name| is_valid(name))
    // rust: .map(str::to_owned)
}

pub fn seed() u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let nanos = std::time::SystemTime::now()
    // rust: .duration_since(std::time::UNIX_EPOCH)
    // rust: .map_or(0, |d| d.as_nanos() as u64);
    // Two players starting the game in the same millisecond still differ.
    // rust: let mut x = nanos ^ u64::from(std::process::id()).rotate_left(32);
    // rust: x ^= x >> 33;
    // rust: x = x.wrapping_mul(0xff51_afd7_ed55_8ccd);
    // rust: x ^ (x >> 33)
}

    // rust: mod tests {
//     use super::*;

pub fn dir(name: []const u8) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let d = std::env::temp_dir().join(format!(
    // rust: "horizon-offline-name-{name}-{}",
    // rust: std::process::id()
    // rust: ));
    // rust: let _ = fs::remove_dir_all(&d);
    // rust: fs::create_dir_all(&d).unwrap();
    // rust: d
}

pub fn generated_names_are_valid_and_never_the_hosts_profile() void {
}
    // rust: for seed in [0, 7, 99_999, 100_000, u64::MAX] {
    // rust: let name = generate(seed);
    // rust: assert!(is_valid(&name), "{name}");
            // The LAN host's own profile (game/chat.rs PLAYER_NAME).
    // rust: assert_ne!(name, "Player");
    // rust: assert_eq!(name.len(), 11);
}
    // rust: assert_eq!(generate(42), "Player00042");
}

pub fn the_name_is_kept_and_reused() void {
}
    // rust: let d = dir("kept");
    // rust: let first = load_or_create(&d);
    // rust: assert_eq!(
    // rust: fs::read_to_string(d.join(FILE)).unwrap(),
    // rust: format!("name:{first}\n")
    // rust: );
    // rust: assert_eq!(load_or_create(&d), first);
        // An edited name is used as it is.
    // rust: fs::write(d.join(FILE), "name:Alex_2\r\n").unwrap();
    // rust: assert_eq!(load_or_create(&d), "Alex_2");
    // rust: let _ = fs::remove_dir_all(&d);
}

pub fn invalid_names_are_replaced() void {
}
    // rust: for text in [
    // rust: "",
    // rust: "name:",
    // rust: "name:has space",
    // rust: "name:ThisNameIsTooLong17",
    // rust: "name:été",
    // rust: ] {
    // rust: let d = dir("invalid");
    // rust: fs::write(d.join(FILE), text).unwrap();
    // rust: let name = load_or_create(&d);
    // rust: assert!(
    // rust: name.starts_with("Player") && is_valid(&name),
    // rust: "{text:?} -> {name}"
    // rust: );
    // rust: assert_eq!(load_or_create(&d), name);
    // rust: let _ = fs::remove_dir_all(&d);
}
}
}
