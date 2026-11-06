//! Transpiled from Horizon Rust crate
package horizon_server_backup

import "core:fmt"
import "core:mem"
import "core:math"

// Backups and restore (docs/server.md, section 7). A backup is one zip in `backups/`: the world folder and
// the server's settings and lists. On a running server the game first saves everything and stops writing
// (`save-off`, `save-all`), and writes again once the zip is done (`save-on`), so players stay online.
// A restore puts the backup's world in place of the current one, which is moved aside, never deleted.

// use crate::config::Config;
// use std::{
    // rust: fs::File,
    // rust: io::{BufWriter, Write},
    // rust: path::{Path, PathBuf},
    // rust: time::SystemTime,
}
// use zip::{CompressionMethod, ZipArchive, ZipWriter, write::SimpleFileOptions};

DIR :: "backups"
// The settings and lists a backup holds beside the world.
    // rust: const FILES: [&str; 6] = [
    // rust: "server.toml",
    // rust: "server.properties",
    // rust: "ops.json",
    // rust: "whitelist.json",
    // rust: "banned-players.json",
    // rust: "banned-ips.json",
    // rust: ];
// Automatic backups are named `<time>-auto.zip`; only those are pruned.
AUTO :: "auto"

// `2026-10-16_18-30-05`, in UTC: sorts by time, and is valid in a file name everywhere.
stamp :: proc(time: SystemTime) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let secs = time
    // rust: .duration_since(SystemTime::UNIX_EPOCH)
    // rust: .map_or(0, |d| d.as_secs() as i64);
    // rust: let (y, m, d) = horizon_server_files::java_properties::civil_from_days(secs.div_euclid(86_400));
    // rust: let s = secs.rem_euclid(86_400);
    // rust: format!(
    // rust: "{y:04}-{m:02}-{d:02}_{:02}-{:02}-{:02}",
    // rust: s / 3600,
    // rust: s / 60 % 60,
    // rust: s % 60
    // rust: )
}

// A backup's file name: the time, and a name the owner gave (letters, digits, `-` and `_` only).
file_name :: proc(time: SystemTime, name: Maybe(string)) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let name = name.unwrap_or("manual");
    // rust: if name.is_empty()
    // rust: || name.len() > 64
    // rust: || !name
    // rust: .chars()
    // rust: .all(|c| c.is_ascii_alphanumeric() || c == '-' || c == '_')
    // rust: {
    // rust: return Err(format!(
    // rust: "backup names use letters, digits, - and _ only (got {name:?})"
    // rust: ));
}
    // rust: Ok(format!("{}-{name}.zip", stamp(time)))
}

// Adds a folder to the zip, under `prefix`, skipping the game's session lock.
add_dir :: proc(zip: ^ZipWriter<BufWriter<File>>, dir: ^Path, prefix: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let options = SimpleFileOptions::default()
    // rust: .compression_method(CompressionMethod::Deflated)
    // rust: .large_file(true);
    // rust: let mut entries: Vec<_> = std::fs::read_dir(dir)
    // rust: .map_err(|e| format!("{}: {e}", dir.display()))?
    // rust: .flatten()
    // rust: .collect();
    // rust: entries.sort_by_key(|e| e.file_name());
    // rust: for entry in entries {
    // rust: let name = entry.file_name().to_string_lossy().into_owned();
    // rust: let path = entry.path();
    // rust: let inner = format!("{prefix}/{name}");
    // rust: if path.is_dir() {
    // rust: add_dir(zip, &path, &inner)?;
    // rust: } else if name != "session.lock" {
    // rust: zip.start_file(inner.as_str(), options)
    // rust: .map_err(|e| e.to_string())?;
    // rust: let mut file = File::open(&path).map_err(|e| format!("{}: {e}", path.display()))?;
    // rust: std::io::copy(&mut file, zip).map_err(|e| format!("{}: {e}", path.display()))?;
}
}
    // rust: Ok(())
}

// Zips the world and the settings into `backups/<file_name>`. The zip is written under a temporary name
// and renamed when complete, so a backup that looks finished is one.
create :: proc(dir: ^Path, config: ^Config, file_name: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let backups = dir.join(DIR);
    // rust: std::fs::create_dir_all(&backups).map_err(|e| format!("{}: {e}", backups.display()))?;
    // rust: let path = backups.join(file_name);
    // rust: let part = backups.join(format!("{file_name}.part"));
    // rust: let result = (|| {
    // rust: let file = File::create(&part).map_err(|e| format!("{}: {e}", part.display()))?;
    // rust: let mut zip = ZipWriter::new(BufWriter::new(file));
    // rust: let world = dir.join(&config.world.name);
    // rust: if world.is_dir() {
    // rust: add_dir(&mut zip, &world, &config.world.name)?;
}
    // rust: let options = SimpleFileOptions::default().compression_method(CompressionMethod::Deflated);
    // rust: for name in FILES {
    // rust: if let Ok(bytes) = std::fs::read(dir.join(name)) {
    // rust: zip.start_file(name, options).map_err(|e| e.to_string())?;
    // rust: zip.write_all(&bytes).map_err(|e| e.to_string())?;
}
}
    // rust: zip.finish()
    // rust: .map_err(|e| e.to_string())?
    // rust: .into_inner()
    // rust: .map_err(|e| e.to_string())?
    // rust: .sync_all()
    // rust: .map_err(|e| e.to_string())
    // rust: })();
    // rust: match result {
    // rust: Ok(()) => {
    // rust: std::fs::rename(&part, &path).map_err(|e| e.to_string())?;
    // rust: Ok(path)
}
    // rust: Err(e) => {
    // rust: let _ = std::fs::remove_file(&part);
    // rust: Err(e)
}
}
}

Backup :: struct {
    name: string,
    bytes: u64,
}

// The finished backups, newest first.
list :: proc(dir: ^Path) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out: Vec<Backup> = std::fs::read_dir(dir.join(DIR))
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .flatten()
    // rust: .filter_map(|e| {
    // rust: let name = e.file_name().to_string_lossy().into_owned();
    // rust: name.ends_with(".zip").then(|| Backup {
    // rust: bytes: e.metadata().map_or(0, |m| m.len()),
    // rust: name,
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: out.sort_by(|a, b| b.name.cmp(&a.name));
    // rust: out
}

// Deletes the oldest automatic backups beyond `keep`. Backups made by hand are never deleted.
prune :: proc(dir: ^Path, keep: uint) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let auto_suffix = format!("-{AUTO}.zip");
    // rust: list(dir)
    // rust: .into_iter()
    // rust: .filter(|b| b.name.ends_with(&auto_suffix))
    // rust: .skip(keep)
    // rust: .filter(|b| std::fs::remove_file(dir.join(DIR).join(&b.name)).is_ok())
    // rust: .map(|b| b.name)
    // rust: .collect()
}

auto_name :: proc(time: SystemTime) -> S {
    // Ported from Horizon
    return {}
}
    // rust: file_name(time, Some(AUTO)).expect("the automatic name is valid")
}

// The backup a name points at: a file in `backups/`, by its full name or the start of it.
find :: proc(dir: ^Path, name: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let all = list(dir);
    // rust: if let Some(b) = all
    // rust: .iter()
    // rust: .find(|b| b.name == name || b.name == format!("{name}.zip"))
    // rust: {
    // rust: return Ok(b.name.clone());
}
    // rust: let matches: Vec<&Backup> = all.iter().filter(|b| b.name.starts_with(name)).collect();
    // rust: match matches.as_slice() {
    // rust: [one] => return Ok(one.name.clone()),
    // rust: [] => {}
    // rust: _ => {
    // rust: return Err(format!(
    // rust: "{name:?} matches {} backups: be more precise",
    // rust: matches.len()
    // rust: ));
}
}
    // The name given to `backup NAME` (or `auto`, `manual`): the newest backup with it.
    // rust: let label = format!("-{name}.zip");
    // rust: all.iter()
    // rust: .find(|b| b.name.ends_with(&label))
    // rust: .map(|b| b.name.clone())
    // rust: .ok_or_else(|| {
    // rust: format!("no backup {name:?} in {DIR}/ (`horizon-server backups` lists them)")
    // rust: })
}

// Puts the backup's world in place of the current one, which goes to `backups/replaced-<time>/`. The
// server must be stopped. Returns where the old world went.
restore :: proc(dir: ^Path, config: ^Config, name: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let zip_path = dir.join(DIR).join(name);
    // rust: let scratch = dir.join(".horizon/restore");
    // rust: let _ = std::fs::remove_dir_all(&scratch);
    // rust: std::fs::create_dir_all(&scratch).map_err(|e| e.to_string())?;
    // rust: let file = File::open(&zip_path).map_err(|e| format!("{}: {e}", zip_path.display()))?;
    // rust: ZipArchive::new(file)
    // rust: .and_then(|mut z| z.extract(&scratch))
    // rust: .map_err(|e| format!("{name}: {e}"))?;
    // rust: let world = &config.world.name;
    // rust: let restored = scratch.join(world);
    // rust: if !restored.join("level.dat").is_file() {
    // rust: let _ = std::fs::remove_dir_all(&scratch);
    // rust: return Err(format!(
    // rust: "{name} holds no world named {world:?} (no {world}/level.dat)"
    // rust: ));
}
    // rust: let current = dir.join(world);
    // rust: let moved = if current.exists() {
    // rust: let aside = dir
    // rust: .join(DIR)
    // rust: .join(format!("replaced-{}", stamp(SystemTime::now())));
    // rust: std::fs::create_dir_all(&aside).map_err(|e| e.to_string())?;
    // rust: let target = aside.join(world);
    // rust: std::fs::rename(&current, &target)
    // rust: .map_err(|e| format!("moving the current world aside: {e}"))?;
    // rust: Some(target)
    // rust: } else {
    // rust: None
}
    // rust: std::fs::rename(&restored, &current)
    // rust: .map_err(|e| format!("putting the backup in place: {e}"))?;
    // rust: let _ = std::fs::remove_dir_all(&scratch);
    // rust: Ok(moved)
}

// A dimension id (`minecraft:the_nether`, or `the_nether` for `minecraft:`) as the id and its folder in the
// world (`dimensions/<namespace>/<path>`, as the game saves it). Only the characters of a resource id.
dimension_folder :: proc(dimension: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let (namespace, path) = dimension
    // rust: .split_once(':')
    // rust: .unwrap_or(("minecraft", dimension));
    // rust: let namespace_ok = !namespace.is_empty()
    // rust: && namespace
    // rust: .chars()
    // rust: .all(|c| matches!(c, 'a'..='z' | '0'..='9' | '_' | '-' | '.'));
    // rust: let path_ok = !path.is_empty()
    // rust: && path
    // rust: .split('/')
    // rust: .all(|s| !s.is_empty() && s != "." && s != "..")
    // rust: && path
    // rust: .chars()
    // rust: .all(|c| matches!(c, 'a'..='z' | '0'..='9' | '_' | '-' | '.' | '/'));
    // rust: if !namespace_ok || !path_ok {
    // rust: return Err(format!(
    // rust: "{dimension:?} is not a dimension id (like minecraft:the_nether)"
    // rust: ));
}
    // rust: Ok((
    // rust: format!("{namespace}:{path}"),
    // rust: format!("dimensions/{namespace}/{path}"),
    // rust: ))
}

// Puts one dimension of the backup in place of the current one, leaving the rest of the world (the other
// dimensions, `level.dat`, the players) as it is. The current dimension goes to
// `backups/replaced-<time>/<world>/dimensions/...`. The server must be stopped. Returns where the old
// folder went (None when the world had none).
    // rust: pub fn restore_dimension(
    // rust: dir: &Path,
    // rust: config: &Config,
    // rust: name: &str,
    // rust: dimension: &str,
    // rust: ) -> Result<Option<PathBuf>, String> {
    // rust: let (id, folder) = dimension_folder(dimension)?;
    // rust: let world = &config.world.name;
    // rust: let prefix = format!("{world}/{folder}/");
    // rust: let zip_path = dir.join(DIR).join(name);
    // rust: let scratch = dir.join(".horizon/restore");
    // rust: let _ = std::fs::remove_dir_all(&scratch);
    // rust: std::fs::create_dir_all(&scratch).map_err(|e| e.to_string())?;
    // rust: let result = (|| {
    // rust: let file = File::open(&zip_path).map_err(|e| format!("{}: {e}", zip_path.display()))?;
    // rust: let mut zip = ZipArchive::new(file).map_err(|e| format!("{name}: {e}"))?;
    // rust: let mut files = 0;
    // rust: for i in 0..zip.len() {
    // rust: let mut entry = zip.by_index(i).map_err(|e| format!("{name}: {e}"))?;
    // rust: let Some(inner) = entry.enclosed_name() else {
    // rust: continue;
}
    // rust: if !inner.starts_with(&prefix) {
    // rust: continue;
}
    // rust: let out = scratch.join(&inner);
    // rust: if entry.is_dir() {
    // rust: std::fs::create_dir_all(&out).map_err(|e| e.to_string())?;
    // rust: continue;
}
    // rust: if let Some(parent) = out.parent() {
    // rust: std::fs::create_dir_all(parent).map_err(|e| e.to_string())?;
}
    // rust: let mut dest = File::create(&out).map_err(|e| format!("{}: {e}", out.display()))?;
    // rust: std::io::copy(&mut entry, &mut dest).map_err(|e| format!("{name}: {e}"))?;
    // rust: files += 1;
}
    // rust: if files == 0 {
    // rust: return Err(format!(
    // rust: "{name} holds nothing of the dimension {id} (no {world}/{folder}/)"
    // rust: ));
}
    // rust: Ok(())
    // rust: })();
    // rust: if let Err(e) = result {
    // rust: let _ = std::fs::remove_dir_all(&scratch);
    // rust: return Err(e);
}
    // rust: let restored = scratch.join(world).join(&folder);
    // rust: let current = dir.join(world).join(&folder);
    // rust: let moved = if current.exists() {
    // rust: let target = dir
    // rust: .join(DIR)
    // rust: .join(format!("replaced-{}", stamp(SystemTime::now())))
    // rust: .join(world)
    // rust: .join(&folder);
    // rust: if target.exists() {
    // rust: let _ = std::fs::remove_dir_all(&scratch);
    // rust: return Err(format!(
    // rust: "{} exists already; try again in a second",
    // rust: target.display()
    // rust: ));
}
    // rust: std::fs::create_dir_all(target.parent().expect("the folder has a parent"))
    // rust: .map_err(|e| e.to_string())?;
    // rust: std::fs::rename(&current, &target)
    // rust: .map_err(|e| format!("moving the current {id} aside: {e}"))?;
    // rust: Some(target)
    // rust: } else {
    // rust: None
}
    // rust: let put = (|| {
    // rust: std::fs::create_dir_all(current.parent().expect("the folder has a parent"))?;
    // rust: std::fs::rename(&restored, &current)
    // rust: })();
    // rust: if let Err(e) = put {
        // Put the old folder back: the world must not be left without the dimension.
    // rust: if let Some(old) = &moved {
    // rust: let _ = std::fs::rename(old, &current);
}
    // rust: let _ = std::fs::remove_dir_all(&scratch);
    // rust: return Err(format!("putting the backup's {id} in place: {e}"));
}
    // rust: let _ = std::fs::remove_dir_all(&scratch);
    // rust: Ok(moved)
}

// `every` from server.toml: `"6h"`, `"30m"`, `"1d"`, or `"0"` for no automatic backups.
interval :: proc(every: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let every = every.trim();
    // rust: if every == "0" || every.is_empty() {
    // rust: return Ok(None);
}
    // rust: let (number, unit) = every.split_at(every.len() - 1);
    // rust: let n: u64 = number.trim().parse().map_err(|_| {
    // rust: format!("backups.every is {every:?}: use a number and m, h or d, like \"6h\"")
    // rust: })?;
    // rust: let secs = match unit {
    // rust: "m" => 60,
    // rust: "h" => 3600,
    // rust: "d" => 86_400,
    // rust: _ => {
    // rust: return Err(format!(
    // rust: "backups.every is {every:?}: use a number and m, h or d, like \"6h\""
    // rust: ));
}
}
    // rust: Ok((n > 0).then(|| std::time::Duration::from_secs(n * secs)))
}

    // rust: mod tests {
//     use super::*;

names_sort_by_time :: proc() {
}
    // rust: let t = SystemTime::UNIX_EPOCH + std::time::Duration::from_secs(1_792_000_000);
    // rust: assert_eq!(
    // rust: file_name(t, Some("before-update")).unwrap(),
    // rust: "2026-10-14_17-46-40-before-update.zip"
    // rust: );
    // rust: assert!(file_name(t, Some("../x")).is_err());
    // rust: assert_eq!(auto_name(t), "2026-10-14_17-46-40-auto.zip");
}

intervals :: proc() {
}
    // rust: assert_eq!(
    // rust: interval("6h").unwrap(),
    // rust: Some(std::time::Duration::from_secs(21_600))
    // rust: );
    // rust: assert_eq!(
    // rust: interval("30m").unwrap(),
    // rust: Some(std::time::Duration::from_secs(1800))
    // rust: );
    // rust: assert_eq!(interval("0").unwrap(), None);
    // rust: assert!(interval("6 hours").is_err());
}

back_up_and_restore :: proc() {
}
    // rust: let dir =
    // rust: std::env::temp_dir().join(format!("horizon-server-backup-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: let config = Config::default();
    // rust: let world = dir.join("world");
    // rust: std::fs::create_dir_all(world.join("region")).unwrap();
    // rust: std::fs::write(world.join("level.dat"), b"before").unwrap();
    // rust: std::fs::write(world.join("region/r.0.0.mca"), vec![7u8; 10_000]).unwrap();
    // rust: std::fs::write(world.join("session.lock"), b"x").unwrap();
    // rust: std::fs::write(dir.join("server.toml"), crate::config::TEMPLATE).unwrap();
    // rust: let t = SystemTime::now();
    // rust: let name = file_name(t, None).unwrap();
    // rust: create(&dir, &config, &name).unwrap();
    // rust: assert_eq!(list(&dir).len(), 1);
        // The world changes, then the backup comes back.
    // rust: std::fs::write(world.join("level.dat"), b"after").unwrap();
    // rust: let moved = restore(&dir, &config, &find(&dir, &name[..10]).unwrap())
    // rust: .unwrap()
    // rust: .unwrap();
    // rust: assert_eq!(std::fs::read(world.join("level.dat")).unwrap(), b"before");
    // rust: assert_eq!(
    // rust: std::fs::read(world.join("region/r.0.0.mca")).unwrap().len(),
    // rust: 10_000
    // rust: );
    // rust: assert!(!world.join("session.lock").exists());
    // rust: assert_eq!(std::fs::read(moved.join("level.dat")).unwrap(), b"after");
        // Only automatic backups are pruned.
    // rust: for i in 0..3 {
    // rust: let later = t + std::time::Duration::from_secs(10 + i);
    // rust: create(&dir, &config, &auto_name(later)).unwrap();
}
    // rust: assert_eq!(prune(&dir, 1).len(), 2);
    // rust: let left: Vec<String> = list(&dir).into_iter().map(|b| b.name).collect();
    // rust: assert_eq!(left.len(), 2);
    // rust: assert!(left.iter().any(|n| n.ends_with("-manual.zip")));
        // A backup is found by its name, or the newest with a label.
    // rust: assert_eq!(find(&dir, "manual").unwrap(), name);
    // rust: assert_eq!(find(&dir, &left[0]).unwrap(), left[0]);
    // rust: assert_eq!(
    // rust: find(&dir, left[0].trim_end_matches(".zip")).unwrap(),
    // rust: left[0]
    // rust: );
    // rust: assert_eq!(find(&dir, "auto").unwrap(), left[0]);
    // rust: assert!(find(&dir, "nothing").is_err());
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}

restore_one_dimension_only :: proc() {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-server-dim-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: let config = Config::default();
    // rust: let world = dir.join("world");
    // rust: let overworld = world.join("dimensions/minecraft/overworld/region/r.0.0.mca");
    // rust: let nether = world.join("dimensions/minecraft/the_nether/region/r.0.0.mca");
    // rust: for (file, bytes) in [(&overworld, "ow-before"), (&nether, "nether-before")] {
    // rust: std::fs::create_dir_all(file.parent().unwrap()).unwrap();
    // rust: std::fs::write(file, bytes).unwrap();
}
    // rust: std::fs::write(world.join("level.dat"), b"level-before").unwrap();
    // rust: let name = file_name(SystemTime::now(), None).unwrap();
    // rust: create(&dir, &config, &name).unwrap();
    // rust: std::fs::write(&overworld, "ow-after").unwrap();
    // rust: std::fs::write(&nether, "nether-after").unwrap();
    // rust: std::fs::write(world.join("level.dat"), b"level-after").unwrap();

        // Unknown or malformed dimensions change nothing.
    // rust: assert!(restore_dimension(&dir, &config, &name, "minecraft:the_end").is_err());
    // rust: assert!(restore_dimension(&dir, &config, &name, "../world").is_err());
    // rust: assert!(restore_dimension(&dir, &config, &name, "minecraft:../x").is_err());
    // rust: assert_eq!(std::fs::read(&nether).unwrap(), b"nether-after");

        // `the_nether` means `minecraft:the_nether`.
    // rust: let moved = restore_dimension(&dir, &config, &name, "the_nether")
    // rust: .unwrap()
    // rust: .unwrap();
    // rust: assert_eq!(std::fs::read(&nether).unwrap(), b"nether-before");
    // rust: assert_eq!(std::fs::read(&overworld).unwrap(), b"ow-after");
    // rust: assert_eq!(
    // rust: std::fs::read(world.join("level.dat")).unwrap(),
    // rust: b"level-after"
    // rust: );
    // rust: assert_eq!(
    // rust: std::fs::read(moved.join("region/r.0.0.mca")).unwrap(),
    // rust: b"nether-after"
    // rust: );
    // rust: assert!(!dir.join(".horizon/restore").exists());

        // A dimension the world lost comes back too, with nothing to put aside.
    // rust: std::fs::remove_dir_all(world.join("dimensions/minecraft/the_nether")).unwrap();
    // rust: assert!(
    // rust: restore_dimension(&dir, &config, &name, "minecraft:the_nether")
    // rust: .unwrap()
    // rust: .is_none()
    // rust: );
    // rust: assert_eq!(std::fs::read(&nether).unwrap(), b"nether-before");
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}
}
