//! Transpiled from Horizon Rust crate
//! Module: horizon-server_import_resources
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `horizon-server import-resources DIR`: puts a folder of prepared game files (made on the owner's own
//! computer by the launcher or `horizon-prepare`) where the server reads them, so a headless machine
//! without Java needs no `prepare`. docs/server.md, section "Game files".
//!
//! The folder is checked first (the same checks the engine makes at start, plus the `minecraft` version
//! stamp in `horizon-resources.json` against the pinned version), copied beside its destination, and
//! moved in with a rename. The previous copy is put back if any step fails.

// use crate::engine::{self, GAME_VERSION};
// use std::{
    // rust: io,
    // rust: path::{Path, PathBuf},
}

/// Where the prepared files go: the first place the server reads them from
/// (`engine::resource_candidates`). That is `[engine] resources` when `server.toml` sets it, else
/// `resources/` in the server folder when it exists or there is no installer, else the installer's
/// `game-files/horizon-client/<version>` (what the release's `.local/horizon-client` links to).
pub fn destination(dir: *Path) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let configured = crate::config::Config::load(dir)
    // rust: .map(|c| c.engine.resources)
    // rust: .unwrap_or_default();
    // rust: destination_for(
    // rust: dir,
    // rust: &configured,
    // rust: crate::update::Install::find().map(|i| i.root),
    // rust: )
}

pub fn destination_for(dir: *Path, configured: []const u8, installer: ?PathBuf) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !configured.is_empty() {
    // rust: return dir.join(configured);
}
    // rust: let here = dir.join("resources");
    // rust: match installer {
    // rust: Some(root) if !here.exists() => root.join("game-files/horizon-client").join(GAME_VERSION),
    // rust: _ => here,
}
}

/// `import-resources DIR`.
pub fn command(dir: *Path, args: *[[]const u8]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [source] = args else {
    // rust: return Err(
    // rust: "import-resources needs the prepared folder to copy (one with horizon-resources.json)"
    // rust: .into(),
    // rust: );
}
    // rust: let target = destination(dir);
    // rust: import(Path::new(source), &target, &mut || Ok(()))?;
    // rust: println!("Imported the game files into {}", target.display());
    // rust: println!(
    // rust: "Next: `horizon-server start` (or `horizon-server restart` if it is running) to start on them."
    // rust: );
    // rust: Ok(())
}

/// What is wrong with `source` as the server's game files, each as one line; empty when it is fit.
pub fn problems(source: *Path) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !source.is_dir() {
    // rust: return vec![format!("{} is not a folder", source.display())];
}
    // rust: let manifest = source.join("horizon-resources.json");
    // rust: let Ok(text) = std::fs::read_to_string(&manifest) else {
    // rust: return vec![format!(
    // rust: "{} has no horizon-resources.json: it is not a prepared folder (the launcher writes one, or \
    // rust: `horizon-prepare --prepare`)",
    // rust: source.display()
    // rust: )];
}
    // rust: let mut out = Vec::new();
    // rust: match serde_json::from_str::<serde_json::Value>(&text) {
    // rust: Ok(manifest) => match manifest.get("minecraft").and_then(|v| v.as_str()) {
    // rust: Some(GAME_VERSION) => {}
    // rust: Some(other) => out.push(format!(
    // rust: "prepared for Minecraft {other}, this server needs {GAME_VERSION}: prepare {GAME_VERSION} \
    // rust: and import that"
    // rust: )),
    // rust: None => out.push("horizon-resources.json names no Minecraft version".into()),
    // rust: },
    // rust: Err(e) => out.push(format!("horizon-resources.json is not valid JSON ({e})")),
}
    // The file and checksum checks the engine makes at start; its message lists one problem per line.
    // rust: if let Err(e) = engine::check_prepared(source) {
    // rust: out.extend(
    // rust: e.lines()
    // rust: .filter(|l| l.starts_with("  "))
    // rust: .map(|l| l.trim().to_owned())
                // The version problem above already covers an unreadable or invalid manifest.
    // rust: .filter(|l| !l.starts_with("horizon-resources.json")),
    // rust: );
}
    // rust: out
}

/// Checks `source`, copies it next to `target`, and swaps it in; `target` keeps its old content on any
/// failure. `each_file` runs after every copied file (a test makes it fail partway).
    // rust: pub fn import(
    // rust: source: &Path,
    // rust: target: &Path,
    // rust: each_file: &mut dyn FnMut() -> io::Result<()>,
    // rust: ) -> Result<(), String> {
    // rust: let found = problems(source);
    // rust: if !found.is_empty() {
    // rust: return Err(format!(
    // rust: "{} can't be used as the server's game files:\n  {}\nNothing was changed.",
    // rust: source.display(),
    // rust: found.join("\n  ")
    // rust: ));
}
    // rust: let parent = target
    // rust: .parent()
    // rust: .ok_or_else(|| format!("{} has no parent folder", target.display()))?;
    // rust: std::fs::create_dir_all(parent).map_err(|e| format!("{}: {e}", parent.display()))?;
    // rust: let name = target
    // rust: .file_name()
    // rust: .map_or_else(|| "resources".into(), |n| n.to_string_lossy().into_owned());
    // rust: let pid = std::process::id();
    // rust: let fresh = parent.join(format!(".{name}.importing-{pid}"));
    // rust: let old = parent.join(format!(".{name}.previous-{pid}"));
    // rust: let _ = std::fs::remove_dir_all(&fresh);
    // rust: let copied = copy_tree(source, &fresh, each_file)
    // rust: .map_err(|e| format!("copying {}: {e}", source.display()))
    // rust: .and_then(|()| {
            // Copied bytes must still pass the same check before they replace anything.
    // rust: let found = problems(&fresh);
    // rust: if found.is_empty() {
    // rust: Ok(())
    // rust: } else {
    // rust: Err(format!("the copy is incomplete:\n  {}", found.join("\n  ")))
}
    // rust: });
    // rust: if let Err(e) = copied {
    // rust: let _ = std::fs::remove_dir_all(&fresh);
    // rust: return Err(format!("{e}\nThe previous game files are untouched."));
}
    // rust: let had_old = target.symlink_metadata().is_ok();
    // rust: if had_old && let Err(e) = std::fs::rename(target, &old) {
    // rust: let _ = std::fs::remove_dir_all(&fresh);
    // rust: return Err(format!(
    // rust: "{}: {e}\nThe previous game files are untouched.",
    // rust: target.display()
    // rust: ));
}
    // rust: if let Err(e) = std::fs::rename(&fresh, target) {
    // rust: if had_old {
    // rust: let _ = std::fs::rename(&old, target);
}
    // rust: let _ = std::fs::remove_dir_all(&fresh);
    // rust: return Err(format!(
    // rust: "{}: {e}\nThe previous game files are untouched.",
    // rust: target.display()
    // rust: ));
}
    // rust: if had_old {
    // rust: let _ = std::fs::remove_dir_all(&old);
}
    // rust: Ok(())
}

/// Copies the folder `from` to the new folder `to`, following links, calling `each_file` after each file.
    // rust: fn copy_tree(
    // rust: from: &Path,
    // rust: to: &Path,
    // rust: each_file: &mut dyn FnMut() -> io::Result<()>,
    // rust: ) -> io::Result<()> {
    // rust: std::fs::create_dir_all(to)?;
    // rust: let mut entries: Vec<_> = std::fs::read_dir(from)?.collect::<Result<_, _>>()?;
    // rust: entries.sort_by_key(|e| e.file_name());
    // rust: for entry in entries {
    // rust: let (src, dst) = (entry.path(), to.join(entry.file_name()));
    // rust: if std::fs::metadata(&src)?.is_dir() {
    // rust: copy_tree(&src, &dst, each_file)?;
    // rust: } else {
    // rust: std::fs::copy(&src, &dst)?;
    // rust: each_file()?;
}
}
    // rust: Ok(())
}

    // rust: mod tests {
//     use super::*;

pub fn scratch(name: []const u8) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let dir =
    // rust: std::env::temp_dir().join(format!("horizon-import-{name}-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: dir
}

pub fn put(path: *Path, bytes: []const u8) void {
}
    // rust: std::fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: std::fs::write(path, bytes).unwrap();
}

    /// A prepared folder the engine's own check accepts, stamped `minecraft`; `tag` marks its content.
pub fn prepared(root: *Path, minecraft: []const u8, tag: []const u8) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let dir = root.join(format!("prepared-{tag}"));
    // rust: for file in [
    // rust: "facts.json",
    // rust: "block-tags.json",
    // rust: "registries.json",
    // rust: "commands.json",
    // rust: ] {
    // rust: put(&dir.join(file), format!("{{\"{tag}\": 1}}").as_bytes());
}
    // rust: put(&dir.join("assets/minecraft/font/default.json"), b"{}");
    // rust: put(
    // rust: &dir.join("assets/minecraft/textures/block/stone.png"),
    // rust: tag.as_bytes(),
    // rust: );
    // rust: put(
    // rust: &dir.join("horizon-resources.json"),
    // rust: format!("{{\"schema\": 1, \"minecraft\": \"{minecraft}\"}}").as_bytes(),
    // rust: );
    // rust: dir
}

pub fn tag(target: *Path) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::fs::read_to_string(target.join("assets/minecraft/textures/block/stone.png")).unwrap()
}

pub fn leftovers(parent: *Path) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::fs::read_dir(parent)
    // rust: .unwrap()
    // rust: .flatten()
    // rust: .map(|e| e.file_name().to_string_lossy().into_owned())
    // rust: .filter(|n| n.starts_with('.'))
    // rust: .collect()
}

    /// The import goes where the server will read it: a configured folder first, then an existing
    /// `resources/` (which shadows the installer's copy), then the installer's folder.
pub fn the_destination_is_the_folder_the_server_reads_first() void {
}
    // rust: let root = scratch("destination");
    // rust: let installer = Some(root.join("install"));
    // rust: let installed = root
    // rust: .join("install/game-files/horizon-client")
    // rust: .join(GAME_VERSION);
    // rust: assert_eq!(destination_for(&root, "", installer.clone()), installed);
    // rust: assert_eq!(destination_for(&root, "", None), root.join("resources"));
    // rust: assert_eq!(
    // rust: destination_for(&root, "files/mc", installer.clone()),
    // rust: root.join("files/mc")
    // rust: );
    // rust: std::fs::create_dir_all(root.join("resources")).unwrap();
    // rust: assert_eq!(
    // rust: destination_for(&root, "", installer),
    // rust: root.join("resources")
    // rust: );
    // rust: let _ = std::fs::remove_dir_all(&root);
}

pub fn a_good_folder_is_copied_whole_and_replaces_the_old_one() void {
}
    // rust: let root = scratch("good");
    // rust: let source = prepared(&root, GAME_VERSION, "new");
    // rust: let target = root.join("game-files/horizon-client").join(GAME_VERSION);
    // rust: put(&target.join("stale.txt"), b"old");
    // rust: import(&source, &target, &mut || Ok(())).unwrap();
    // rust: assert_eq!(tag(&target), "new");
    // rust: assert!(target.join("horizon-resources.json").is_file());
    // rust: assert!(
    // rust: !target.join("stale.txt").exists(),
    // rust: "the old copy is replaced, not merged"
    // rust: );
    // rust: assert!(engine::check_prepared(&target).is_ok());
    // rust: assert!(leftovers(target.parent().unwrap()).is_empty());
    // rust: let _ = std::fs::remove_dir_all(&root);
}

pub fn a_wrong_version_is_refused_and_nothing_changes() void {
}
    // rust: let root = scratch("version");
    // rust: let source = prepared(&root, "26.2", "new");
    // rust: let old = prepared(&root, GAME_VERSION, "old");
    // rust: let target = root.join("target");
    // rust: import(&old, &target, &mut || Ok(())).unwrap();
    // rust: let e = import(&source, &target, &mut || Ok(())).unwrap_err();
    // rust: assert!(
    // rust: e.contains("prepared for Minecraft 26.2") && e.contains(GAME_VERSION),
    // rust: "{e}"
    // rust: );
    // rust: assert_eq!(tag(&target), "old");
    // rust: let _ = std::fs::remove_dir_all(&root);
}

pub fn a_missing_file_or_manifest_is_named() void {
}
    // rust: let root = scratch("missing");
    // rust: let source = prepared(&root, GAME_VERSION, "new");
    // rust: std::fs::remove_file(source.join("registries.json")).unwrap();
    // rust: let target = root.join("target");
    // rust: let e = import(&source, &target, &mut || Ok(())).unwrap_err();
    // rust: assert!(e.contains("registries.json is missing"), "{e}");
    // rust: assert!(!target.exists());
    // rust: std::fs::remove_file(source.join("horizon-resources.json")).unwrap();
    // rust: let e = import(&source, &target, &mut || Ok(())).unwrap_err();
    // rust: assert!(e.contains("no horizon-resources.json"), "{e}");
    // rust: let e = import(&root.join("nope"), &target, &mut || Ok(())).unwrap_err();
    // rust: assert!(e.contains("is not a folder"), "{e}");
    // rust: let _ = std::fs::remove_dir_all(&root);
}

pub fn a_failure_partway_keeps_the_old_copy_and_leaves_no_temp_folder() void {
}
    // rust: let root = scratch("partway");
    // rust: let old = prepared(&root, GAME_VERSION, "old");
    // rust: let source = prepared(&root, GAME_VERSION, "new");
    // rust: let target = root.join("target");
    // rust: import(&old, &target, &mut || Ok(())).unwrap();
    // rust: let mut copied = 0;
    // rust: let e = import(&source, &target, &mut || {
    // rust: copied += 1;
    // rust: if copied == 3 {
    // rust: Err(io::Error::other("disk full"))
    // rust: } else {
    // rust: Ok(())
}
    // rust: })
    // rust: .unwrap_err();
    // rust: assert!(e.contains("disk full") && e.contains("untouched"), "{e}");
    // rust: assert_eq!(copied, 3);
    // rust: assert_eq!(tag(&target), "old");
    // rust: assert!(engine::check_prepared(&target).is_ok());
    // rust: assert!(leftovers(&root).is_empty(), "{:?}", leftovers(&root));
    // rust: let _ = std::fs::remove_dir_all(&root);
}
}
