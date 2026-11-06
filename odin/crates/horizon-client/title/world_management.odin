//! Transpiled from Horizon Rust crate
package horizon_client_world_management

import "core:fmt"
import "core:mem"
import "core:math"

// World-list operations. Metadata edits preserve every other NBT field;
// backups use vanilla's ZIP layout and never include the session lock.
// use crate::save::{read_dat, write_dat};
// use horizon_world::nbt::Tag;
// use std::{
    // rust: fs,
    // rust: io::{self, Seek, Write},
    // rust: path::{Path, PathBuf},
}

world_path :: proc(saves: ^Path, folder: string) -> c {
    // Ported from Horizon
    return {}
}
    // rust: if Path::new(folder).components().count() != 1
    // rust: || !matches!(
    // rust: Path::new(folder).components().next(),
    // rust: Some(std::path::Component::Normal(_))
    // rust: )
    // rust: {
    // rust: return Err("Invalid world folder".into());
}
    // rust: let path = saves.join(folder);
    // rust: if !fs::symlink_metadata(&path)?.is_dir() {
    // rust: return Err("World folder is not a directory".into());
}
    // rust: Ok(path)
}

// `DirectoryValidator.validateDirectory`: every symbolic link under the
// world folder, never following one. `LevelStorageSource.validateAndCreateAccess`
// asks this before it makes an access, and a world holding any link is not
// opened at all (`ContentValidationException`), so a link planted in a
// downloaded world cannot point the game at the rest of the disk.
symlinks :: proc(saves: ^Path, folder: string) -> c {
    // Ported from Horizon
    return {}
}
    // rust: let mut found = Vec::new();
    // rust: collect_symlinks(&world_path(saves, folder)?, &mut found)?;
    // rust: Ok(found)
}

collect_symlinks :: proc(dir: ^Path, found: ^[dynamic]PathBuf) -> c {
    // Ported from Horizon
    return {}
}
    // rust: for entry in fs::read_dir(dir)? {
    // rust: let entry = entry?;
    // rust: let kind = entry.file_type()?;
    // rust: if kind.is_symlink() {
    // rust: found.push(entry.path());
    // rust: } else if kind.is_dir() {
    // rust: collect_symlinks(&entry.path(), found)?;
}
}
    // rust: Ok(())
}

rename :: proc(saves: ^Path, folder: string, name: string) -> c {
    // Ported from Horizon
    return {}
}
    // rust: let path = world_path(saves, folder)?.join("level.dat");
    // rust: let mut root = read_dat(&path).ok_or("Could not read level.dat")?;
    // rust: let Some(Tag::Compound(data)) = root.get_mut("Data") else {
    // rust: return Err("Missing level data".into());
}
    // rust: data.insert("LevelName".into(), Tag::String(name.trim().into()));
    // rust: write_dat(&path, root)
}

    // rust: pub(super) fn reset_icon(saves: &Path, folder: &str) -> crate::Result<()> {
    // rust: fs::remove_file(world_path(saves, folder)?.join("icon.png"))?;
    // rust: Ok(())
}

// `LevelStorageAccess.deleteLevel`. The world's
// session lock is taken first, so a world open in this or another instance is
// refused rather than pulled from under it; everything but the lock goes,
// then the lock is released and removed with the folder. A failed pass (a
// file briefly held by a virus scanner, say) is retried up to five times,
// half a second apart, as vanilla does. Only the named folder directly in
// `saves` is touched: symbolic links inside it are removed, never followed.
delete :: proc(saves: ^Path, folder: string) -> c {
    // Ported from Horizon
    return {}
}
    // rust: let world = world_path(saves, folder)?;
    // rust: let lock = crate::save::SessionLock::acquire(&world)?;
    // rust: let lock_path = world.join("session.lock");
    // rust: log::info!("Deleting level {folder}");
    // rust: for attempt in 1.. {
    // rust: match remove_contents(&world, &lock_path) {
    // rust: Ok(()) => break,
    // rust: Err(e) if attempt >= 5 => return Err(e.into()),
    // rust: Err(e) => {
    // rust: log::warn!("Failed to delete {}: {e}", world.display());
    // rust: std::thread::sleep(std::time::Duration::from_millis(500));
}
}
}
    // rust: drop(lock);
    // rust: match fs::remove_file(&lock_path) {
    // rust: Err(e) if e.kind() != io::ErrorKind::NotFound => return Err(e.into()),
    // rust: _ => {}
}
    // rust: fs::remove_dir(&world)?;
    // rust: Ok(())
}

remove_contents :: proc(world: ^Path, lock: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: for entry in fs::read_dir(world)? {
    // rust: let entry = entry?;
    // rust: let path = entry.path();
    // rust: if path == lock {
    // rust: continue;
}
        // `file_type` does not follow links, and `remove_dir_all` never does.
    // rust: if entry.file_type()?.is_dir() {
    // rust: fs::remove_dir_all(&path)?;
    // rust: } else {
    // rust: fs::remove_file(&path)?;
}
}
    // rust: Ok(())
}

backups_path :: proc(saves: ^Path) -> P {
    // Ported from Horizon
    return {}
}
    // rust: saves.parent().unwrap_or(saves).join("backups")
}

    // rust: pub(super) fn open_folder(path: &Path) -> crate::Result<()> {
    // rust: fs::create_dir_all(path)?;
    // rust: let path = fs::canonicalize(path)?;
    // rust: let program = if cfg!(target_os = "windows") {
    // rust: "explorer"
    // rust: } else if cfg!(target_os = "macos") {
    // rust: "open"
    // rust: } else {
    // rust: "xdg-open"
}
    // Reap the desktop opener without blocking the UI thread.
    // rust: let mut child = std::process::Command::new(program)
    // rust: .arg(path)
    // rust: .stdout(std::process::Stdio::null())
    // rust: .stderr(std::process::Stdio::null())
    // rust: .spawn()?;
    // rust: std::thread::spawn(move || {
    // rust: let _ = child.wait();
    // rust: });
    // rust: Ok(())
}

backup :: proc(saves: ^Path, folder: string) -> c {
    // Ported from Horizon
    return {}
}
    // rust: let world = world_path(saves, folder)?;
    // rust: let backups = backups_path(saves);
    // rust: fs::create_dir_all(&backups)?;
    // rust: let base = format!(
    // rust: "{}_{}",
    // rust: chrono::Local::now().format("%Y-%m-%d_%H-%M-%S"),
    // rust: folder
    // rust: );
    // rust: let mut index = 0;
    // rust: let (path, file) = loop {
    // rust: let name = if index == 0 {
    // rust: format!("{base}.zip")
    // rust: } else {
    // rust: format!("{base} ({index}).zip")
}
    // rust: let path = backups.join(name);
    // rust: match fs::OpenOptions::new()
    // rust: .write(true)
    // rust: .create_new(true)
    // rust: .open(&path)
    // rust: {
    // rust: Ok(file) => break (path, file),
    // rust: Err(e) if e.kind() == io::ErrorKind::AlreadyExists => index += 1,
    // rust: Err(e) => return Err(e.into()),
}
}
    // rust: let result = (|| {
    // rust: let mut zip = zip::ZipWriter::new(file);
    // rust: write_tree(&mut zip, &world, &world, folder)?;
    // rust: Ok(zip.finish()?.metadata()?.len())
    // rust: })();
    // rust: if result.is_err() {
    // rust: let _ = fs::remove_file(path);
}
    // rust: result
}

    // rust: fn write_tree<W: Write + Seek>(
    // rust: zip: &mut zip::ZipWriter<W>,
    // rust: root: &Path,
    // rust: dir: &Path,
    // rust: folder: &str,
    // rust: ) -> crate::Result<()> {
    // rust: write_tree_skipping(zip, root, dir, folder, &["session.lock"])
}

// Every regular file under `root` (named `<prefix>/<relative>` in the zip),
// except the names in `skip`. Symlinks are refused. The repro bundle zips a
// whole recording with it.
    // rust: pub fn write_tree_skipping<W: Write + Seek>(
    // rust: zip: &mut zip::ZipWriter<W>,
    // rust: root: &Path,
    // rust: dir: &Path,
    // rust: prefix: &str,
    // rust: skip: &[&str],
    // rust: ) -> crate::Result<()> {
    // rust: for entry in fs::read_dir(dir)? {
    // rust: let entry = entry?;
    // rust: let path = entry.path();
    // rust: let kind = entry.file_type()?;
    // rust: if kind.is_symlink() {
    // rust: return Err(format!("Cannot back up symbolic link: {}", path.display()).into());
}
    // rust: let skipped = skip.iter().any(|name| entry.file_name() == *name);
    // rust: if kind.is_dir() {
    // rust: if !skipped {
    // rust: write_tree_skipping(zip, root, &path, prefix, skip)?;
}
    // rust: } else if kind.is_file() && !skipped {
    // rust: let relative = path.strip_prefix(root)?;
    // rust: let name = format!("{prefix}/{}", relative.to_string_lossy().replace('\\', "/"));
    // rust: zip.start_file(
    // rust: name,
    // rust: zip::write::SimpleFileOptions::default()
    // rust: .compression_method(zip::CompressionMethod::Deflated),
    // rust: )?;
    // rust: io::copy(&mut fs::File::open(path)?, zip)?;
}
}
    // rust: Ok(())
}
