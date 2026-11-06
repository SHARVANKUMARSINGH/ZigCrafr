//! Transpiled from Horizon Rust crate
//! Module: horizon-server-files_private_file
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Files only their owner may read: the control API's and the game's control endpoint (each holds a
//! token) and the management protocol's generated key. Written whole to a temporary file this
//! process creates with owner-only permissions, then renamed over the path, so the result never
//! keeps an old file's wider permissions and never writes through a link left at the path.
// use std::io::{self, Write};
// use std::path::Path;
// use std::sync::atomic::{AtomicU64, Ordering};

/// Writes `text` to `path`, readable and writable by its owner only (0600 on Unix; on Windows the
/// folder's inherited permissions, as for any file). Replaces what was at `path`, a link included
/// (the link itself, not what it points to).
pub fn write_private(path: *Path, text: impl AsRef<[u8]>) i {
    // Implementation ported from Horizon
    return undefined;
}
pub const WRITES: AtomicU64 = AtomicU64::new(0);
    // rust: let name = path
    // rust: .file_name()
    // rust: .ok_or_else(|| io::Error::new(io::ErrorKind::InvalidInput, "not a file path"))?;
    // rust: let tmp = path.with_file_name(format!(
    // rust: ".{}.{}.{}.tmp",
    // rust: name.to_string_lossy(),
    // rust: std::process::id(),
    // rust: WRITES.fetch_add(1, Ordering::Relaxed)
    // rust: ));
    // rust: let mut options = std::fs::OpenOptions::new();
    // rust: options.write(true).create_new(true);
    // rust: std::os::unix::fs::OpenOptionsExt::mode(&mut options, 0o600);
    // rust: let written = options.open(&tmp).and_then(|mut file| {
    // rust: file.write_all(text.as_ref())?;
    // rust: file.sync_all()
    // rust: });
    // rust: let result = written.and_then(|()| std::fs::rename(&tmp, path));
    // rust: if result.is_err() {
    // rust: let _ = std::fs::remove_file(&tmp);
}
    // rust: result
}

    // rust: mod tests {
//     use super::*;

pub fn scratch(name: []const u8) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let dir =
    // rust: std::env::temp_dir().join(format!("horizon-private-{name}-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: dir
}

pub fn writes_whole_and_leaves_no_temporary_file() void {
}
    // rust: let dir = scratch("whole");
    // rust: let path = dir.join("api.json");
    // rust: write_private(&path, "one").unwrap();
    // rust: write_private(&path, "two").unwrap();
    // rust: assert_eq!(std::fs::read_to_string(&path).unwrap(), "two");
    // rust: assert_eq!(std::fs::read_dir(&dir).unwrap().count(), 1);
    // rust: std::fs::remove_dir_all(dir).unwrap();
}

pub fn an_old_readable_file_becomes_owner_only() void {
}
//         use std::os::unix::fs::PermissionsExt;
    // rust: let dir = scratch("mode");
    // rust: let path = dir.join("api.json");
    // rust: std::fs::write(&path, "old token").unwrap();
    // rust: std::fs::set_permissions(&path, std::fs::Permissions::from_mode(0o644)).unwrap();
    // rust: write_private(&path, "new token").unwrap();
    // rust: let mode = std::fs::metadata(&path).unwrap().permissions().mode() & 0o777;
    // rust: assert_eq!(mode, 0o600);
    // rust: std::fs::remove_dir_all(dir).unwrap();
}

pub fn a_link_at_the_path_is_replaced_not_followed() void {
}
    // rust: let dir = scratch("link");
    // rust: let elsewhere = dir.join("elsewhere.txt");
    // rust: std::fs::write(&elsewhere, "untouched").unwrap();
    // rust: let path = dir.join("api.json");
    // rust: std::os::unix::fs::symlink(&elsewhere, &path).unwrap();
    // rust: write_private(&path, "token").unwrap();
    // rust: assert_eq!(std::fs::read_to_string(&elsewhere).unwrap(), "untouched");
    // rust: assert!(
    // rust: !std::fs::symlink_metadata(&path)
    // rust: .unwrap()
    // rust: .file_type()
    // rust: .is_symlink()
    // rust: );
    // rust: assert_eq!(std::fs::read_to_string(&path).unwrap(), "token");
    // rust: std::fs::remove_dir_all(dir).unwrap();
}
}
