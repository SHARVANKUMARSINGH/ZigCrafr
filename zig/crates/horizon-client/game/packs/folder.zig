//! Transpiled from Horizon Rust crate
//! Module: horizon-client_folder
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Resolve paths in the game's filesystem context before handing them to a
//! desktop process, which may not inherit Windows AppData virtualization.
// use std::{io, path::Path, process::Command};

    // rust: pub(super) fn command(dir: &Path) -> io::Result<Command> {
    // rust: let program = if cfg!(windows) {
    // rust: "explorer"
    // rust: } else if cfg!(target_os = "macos") {
    // rust: "open"
    // rust: } else {
    // rust: "xdg-open"
}
    // canonicalize opens the directory and resolves its physical location.
    // dunce also removes verbatim syntax where safe: Explorer is not a Win32
    // file API and does not handle every extended-length path form.
    // rust: let dir = dunce::canonicalize(dir)?;
    // rust: let mut command = Command::new(program);
    // rust: command.arg(dir);
    // rust: Ok(command)
}

    // rust: mod tests {
//     use super::*;
//     use std::{
    // rust: fs,
    // rust: path::PathBuf,
    // rust: sync::atomic::{AtomicU64, Ordering},
}

pub const NEXT: AtomicU64 = AtomicU64::new(0);
pub const Scratch = struct {};
    // rust: impl Scratch {
pub fn new() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let path = std::env::temp_dir().join(format!(
    // rust: "horizon-folder-{}-{}",
    // rust: std::process::id(),
    // rust: NEXT.fetch_add(1, Ordering::Relaxed)
    // rust: ));
    // rust: fs::create_dir(&path).unwrap();
    // rust: Self(path)
}
}
    // rust: impl Drop for Scratch {
pub fn drop(self: *Self) void {
}
    // rust: fs::remove_dir_all(&self.0).unwrap();
}
}

pub fn shell_gets_the_existing_folder_as_one_physical_path() void {
}
    // rust: let scratch = Scratch::new();
    // rust: let folder = scratch.0.join("packs & textures \u{2603}");
    // rust: fs::create_dir(&folder).unwrap();
    // rust: fs::write(folder.join("marker"), b"pack scan").unwrap();
    // rust: let logical = folder.join("..").join("packs & textures \u{2603}");
    // rust: let command = command(&logical).unwrap();
    // rust: let args: Vec<_> = command.get_args().collect();
    // rust: assert_eq!(args.len(), 1);
    // rust: let target = Path::new(args[0]);
    // rust: assert!(!target.as_os_str().to_string_lossy().starts_with(r"\\?\"));
    // rust: assert!(
    // rust: !target
    // rust: .components()
    // rust: .any(|component| component == std::path::Component::ParentDir)
    // rust: );
    // rust: assert_eq!(fs::read(target.join("marker")).unwrap(), b"pack scan");
    // rust: assert_eq!(
    // rust: fs::canonicalize(target).unwrap(),
    // rust: fs::canonicalize(&folder).unwrap()
    // rust: );
    // rust: assert_eq!(command.get_program(), "explorer");
}

pub fn missing_folder_is_not_sent_to_explorer() void {
}
    // rust: let scratch = Scratch::new();
    // rust: assert_eq!(
    // rust: command(&scratch.0.join("missing")).unwrap_err().kind(),
    // rust: io::ErrorKind::NotFound
    // rust: );
}
}
