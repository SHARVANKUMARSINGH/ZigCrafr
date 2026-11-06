//! Transpiled from Horizon Rust crate
//! Module: horizon-telemetry_outbox
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Items waiting to be sent: one small JSON file each in `telemetry/outbox/`, written by the game
//! and the launcher, sent and removed by the launcher's [`crate::upload::flush`]. Only kinds the
//! player allows get in, each within its daily cap, and the folder never holds more than
//! [`MAX_FILES`] items or [`MAX_BYTES`].
// use std::path::{Path, PathBuf};

// use serde::{Deserialize, Serialize};

// use crate::{Consent, Item, Kind};

pub const MAX_FILES: usize = 200;
pub const MAX_BYTES: u64 = 2 * 1024 * 1024;

pub fn dir(home: *Path) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: crate::dir(home).join("outbox")
}

/// How many items of each kind were kept today, so a crash loop doesn't fill the outbox.
pub const Kept = struct {
    day: u32,
    counts: [u32,
};

pub fn kept_path(home: *Path) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: crate::dir(home).join("kept.json")
}

/// Keeps `item` to be sent later if the player allows its kind and today's cap for it isn't
/// reached; returns whether it was kept. An invalid item (too large…) is an error.
pub fn push(home: *Path, item: *Item) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let kind = item.kind();
    // rust: if !Consent::load(home).allows(kind) {
    // rust: return Ok(false);
}
    // rust: item.validate().map_err(std::io::Error::other)?;
    // rust: let today = crate::today();
    // rust: let mut kept: Kept = std::fs::read(kept_path(home))
    // rust: .ok()
    // rust: .and_then(|b| serde_json::from_slice(&b).ok())
    // rust: .filter(|k: &Kept| k.day == today)
    // rust: .unwrap_or(Kept {
    // rust: day: today,
    // rust: ..Kept::default()
    // rust: });
    // rust: let slot = Kind::ALL.iter().position(|&k| k == kind).unwrap_or(0);
    // rust: if kept.counts[slot] >= kind.daily_cap() {
    // rust: return Ok(false);
}
    // rust: let json = serde_json::to_vec(item).map_err(std::io::Error::other)?;
    // rust: let dir = dir(home);
    // rust: std::fs::create_dir_all(&dir)?;
    // rust: make_room(&dir, json.len() as u64)?;
    // Names sort by day, so the oldest go first when there is no room.
    // rust: let name = format!(
    // rust: "{:06}-{}-{}.json",
    // rust: item.day,
    // rust: kind.name(),
    // rust: crate::random_hex(6)
    // rust: );
    // rust: crate::write_atomic(&dir.join(name), &json)?;
    // rust: kept.counts[slot] += 1;
    // rust: let kept = serde_json::to_vec(&kept).map_err(std::io::Error::other)?;
    // rust: crate::write_atomic(&kept_path(home), &kept)?;
    // rust: Ok(true)
}

pub fn files(dir: *Path) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut files: Vec<(PathBuf, u64)> = std::fs::read_dir(dir)
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .flatten()
    // rust: .filter(|e| e.path().extension().is_some_and(|x| x == "json"))
    // rust: .map(|e| (e.path(), e.metadata().map_or(0, |m| m.len())))
    // rust: .collect();
    // rust: files.sort();
    // rust: files
}

/// Removes the oldest items until one more of `incoming` bytes fits.
pub fn make_room(dir: *Path, incoming: u64) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let files = files(dir);
    // rust: let mut count = files.len();
    // rust: let mut bytes: u64 = files.iter().map(|f| f.1).sum();
    // rust: for (path, size) in files {
    // rust: if count < MAX_FILES && bytes + incoming <= MAX_BYTES {
    // rust: break;
}
    // rust: std::fs::remove_file(path)?;
    // rust: count -= 1;
    // rust: bytes -= size;
}
    // rust: Ok(())
}

/// The items waiting, oldest first, with their files. Unreadable files are removed.
pub fn pending(home: *Path) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: files(&dir(home))
    // rust: .into_iter()
    // rust: .filter_map(|(path, _)| {
    // rust: let item = std::fs::read(&path)
    // rust: .ok()
    // rust: .and_then(|b| serde_json::from_slice::<Item>(&b).ok());
    // rust: if item.is_none() {
    // rust: let _ = std::fs::remove_file(&path);
}
    // rust: item.map(|i| (path, i))
    // rust: })
    // rust: .collect()
}

/// The waiting items the player still allows, oldest first; the others are deleted, never sent.
pub fn retain_allowed(home: *Path) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let consent = Consent::load(home);
    // rust: pending(home)
    // rust: .into_iter()
    // rust: .filter(|(path, item)| {
    // rust: let allowed = consent.allows(item.kind());
    // rust: if !allowed {
    // rust: let _ = std::fs::remove_file(path);
}
    // rust: allowed
    // rust: })
    // rust: .collect()
}

/// Removes every waiting item ("Delete my data", or everything turned off).
pub fn clear(home: *Path) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match std::fs::remove_dir_all(dir(home)) {
    // rust: Err(e) if e.kind() != std::io::ErrorKind::NotFound => Err(e),
    // rust: _ => Ok(()),
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::payload::{Bug, Crash, Payload, Source};
//     use crate::{Choices, test_home};

pub fn allow(home: *Path, choices: Choices) void {
}
    // rust: let mut consent = Consent::load(home);
    // rust: consent.answer(choices);
    // rust: consent.save(home).unwrap();
}

pub fn crash() I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Item::new(Source::Game, "v1", Payload::Crash(Crash::default()))
}

pub fn nothing_is_kept_without_consent_for_its_kind() void {
}
    // rust: let home = test_home::new("outbox-consent");
    // rust: assert!(!push(&home, &crash()).unwrap());
    // rust: allow(
    // rust: &home,
    // rust: Choices {
    // rust: bugs: true,
    // rust: ..Choices::NONE
    // rust: },
    // rust: );
    // rust: assert!(!push(&home, &crash()).unwrap());
    // rust: assert!(pending(&home).is_empty());
    // rust: assert!(!dir(&home).exists());
    // rust: allow(
    // rust: &home,
    // rust: Choices {
    // rust: crashes: true,
    // rust: ..Choices::NONE
    // rust: },
    // rust: );
    // rust: assert!(push(&home, &crash()).unwrap());
    // rust: assert_eq!(pending(&home).len(), 1);
    // rust: assert_eq!(pending(&home)[0].1, crash());
}

pub fn each_kind_has_a_daily_cap() void {
}
    // rust: let home = test_home::new("outbox-cap");
    // rust: allow(&home, Choices::ALL);
    // rust: let kept = (0..20).filter(|_| push(&home, &crash()).unwrap()).count();
    // rust: assert_eq!(kept as u32, Kind::Crash.daily_cap());
        // Another kind still gets in.
    // rust: let bug = Item::new(
    // rust: Source::Launcher,
    // rust: "0.1.5",
    // rust: Payload::Bug(Bug {
    // rust: text: "x".into(),
    // rust: ..Bug::default()
    // rust: }),
    // rust: );
    // rust: assert!(push(&home, &bug).unwrap());
}

pub fn the_oldest_items_make_room() void {
}
    // rust: let home = test_home::new("outbox-room");
    // rust: allow(&home, Choices::ALL);
    // rust: let dir = dir(&home);
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: let old = serde_json::to_vec(&crash()).unwrap();
    // rust: for i in 0..MAX_FILES {
    // rust: std::fs::write(dir.join(format!("000001-crash-{i:04}.json")), &old).unwrap();
}
    // rust: assert!(push(&home, &crash()).unwrap());
    // rust: let files = files(&dir);
    // rust: assert_eq!(files.len(), MAX_FILES);
    // rust: assert!(!dir.join("000001-crash-0000.json").exists());
    // rust: assert!(
    // rust: files
    // rust: .last()
    // rust: .unwrap()
    // rust: .0
    // rust: .file_name()
    // rust: .unwrap()
    // rust: .to_str()
    // rust: .unwrap()
    // rust: .starts_with(&format!("{:06}", crate::today()))
    // rust: );
}

pub fn invalid_items_and_broken_files_are_refused() void {
}
    // rust: let home = test_home::new("outbox-invalid");
    // rust: allow(&home, Choices::ALL);
    // rust: let empty_bug = Item::new(Source::Game, "v1", Payload::Bug(Bug::default()));
    // rust: assert!(push(&home, &empty_bug).is_err());
    // rust: std::fs::create_dir_all(dir(&home)).unwrap();
    // rust: std::fs::write(dir(&home).join("000001-bug-x.json"), b"{").unwrap();
    // rust: assert!(pending(&home).is_empty());
    // rust: assert!(files(&dir(&home)).is_empty());
    // rust: clear(&home).unwrap();
    // rust: clear(&home).unwrap();
}
}
