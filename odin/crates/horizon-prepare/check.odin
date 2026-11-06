//! Transpiled from Horizon Rust crate
package horizon_prepare_check

import "core:fmt"
import "core:mem"
import "core:math"

// `horizon-prepare --check`: whether prepared resources are complete and current for this
// preparer, without Java and without the game files (docs/api/launch.md). A preparation stamps
// its folder with the `OUTPUT_VERSION` that made it (`STAMP`); tools/prepare_output.py leaves the
// stamp out of the output's digest, so it never asks for a new `OUTPUT_VERSION`.

// use crate::pyjson::Value;
// use crate::{artifacts::Lock, read_json, write_json, OUTPUT_VERSION, SCHEMA};
// use std::path::Path;

// The file beside `horizon-resources.json` naming the preparer's `OUTPUT_VERSION`.
STAMP :: "horizon-prepare.json"

    // rust: pub(crate) fn write_stamp(resources: &Path) -> Result<(), String> {
    // rust: write_json(
    // rust: &resources.join(STAMP),
    // rust: &Value::Object(vec![(
    // rust: "output_version".into(),
    // rust: Value::Int(OUTPUT_VERSION.to_string()),
    // rust: )]),
    // rust: )
}

    // rust: pub(crate) fn remove_stamp(resources: &Path) -> Result<(), String> {
    // rust: let path = resources.join(STAMP);
    // rust: match std::fs::remove_file(&path) {
    // rust: Err(e) if e.kind() != std::io::ErrorKind::NotFound => {
    // rust: Err(format!("{}: {e}", path.display()))
}
    // rust: _ => Ok(()),
}
}

// What the resources at `resources` lack for `root`'s pinned version, each with what to run;
// empty when they are complete and current. Err when `root` has no readable research-lock.json.
check :: proc(root: ^Path, resources: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let lock = Lock::read(root)?;
    // rust: let manifest_path = resources.join("horizon-resources.json");
    // rust: if !manifest_path.is_file() {
    // rust: return Ok(vec![format!(
    // rust: "{} is not prepared: horizon-prepare --prepare",
    // rust: resources.display()
    // rust: )]);
}
    // rust: let mut lacking = Vec::new();
    // rust: let manifest = read_json(&manifest_path)?;
    // rust: let int = |value: Option<&Value>| value.and_then(Value::as_i64);
    // rust: if int(manifest.get("schema")) != Some(SCHEMA) {
    // rust: lacking.push(format!(
    // rust: "an older layout (schema {}, this preparer writes {SCHEMA}): horizon-prepare --prepare",
    // rust: int(manifest.get("schema")).map_or("none".into(), |s| s.to_string())
    // rust: ));
}
    // rust: let minecraft = manifest.get("minecraft").and_then(Value::as_str);
    // rust: if minecraft != Some(lock.version.as_str()) {
    // rust: lacking.push(format!(
    // rust: "prepared for Minecraft {}, this preparer pins {}: horizon-prepare --prepare",
    // rust: minecraft.unwrap_or("unknown"),
    // rust: lock.version
    // rust: ));
}
    // rust: let stamp = read_json(&resources.join(STAMP)).ok();
    // rust: let made_by = int(stamp.as_ref().and_then(|s| s.get("output_version")));
    // rust: if made_by != Some(i64::from(OUTPUT_VERSION)) {
    // rust: lacking.push(format!(
    // rust: "made by output version {}, this preparer makes {OUTPUT_VERSION}: horizon-prepare --prepare",
    // rust: made_by.map_or("unknown".into(), |v| v.to_string())
    // rust: ));
}
    // rust: for (command, what) in missing_extras(resources) {
    // rust: lacking.push(format!("{what} missing: horizon-prepare {command}"));
}
    // rust: Ok(lacking)
}

// What the resources at `resources` lack of what a preparation may leave out when the player's
// asset store lacks it: each as its `horizon-prepare` command (`packs`, `panorama`, `fonts`,
// `languages`, `sounds`) and what it is. `--check` and the launcher's `COMPLETIONS`
// (launcher/src/backend.rs) both ask here, so they never disagree.
missing_extras :: proc(resources: ^Path) -> V {
    // Ported from Horizon
    return {}
}
    // rust: EXTRAS
    // rust: .iter()
    // rust: .filter(|(_, lacks, _)| lacks(resources))
    // rust: .map(|(what, _, command)| (*command, *what))
    // rust: .collect()
}

// What, whether it is missing, the command.
    // rust: type Extra = (&'static str, fn(&Path) -> bool, &'static str);

    // rust: const EXTRAS: [Extra; 5] = [
    // rust: ("the built-in packs", lacks_packs, "packs"),
    // rust: ("the title panorama", lacks_panorama, "panorama"),
    // rust: ("the Unifont glyphs", lacks_unifont, "fonts"),
    // rust: ("the languages", lacks_languages, "languages"),
    // rust: ("the sounds", lacks_sounds, "sounds"),
    // rust: ];

lacks_packs :: proc(resources: ^Path) -> b {
    // Ported from Horizon
    return {}
}
    // rust: crate::BUILT_IN_PACKS
    // rust: .iter()
    // rust: .any(|pack| !resources.join("assets").join(pack).is_file())
}

// The panorama needs six equally sized, non-placeholder square faces and an overlay: prepared
// resources may hold only some of the full-size assets after an interrupted import, and the
// client jar's faces are 1x1 placeholders (a PNG's width and height are the big-endian words at
// bytes 16 and 20, in the IHDR chunk).
lacks_panorama :: proc(resources: ^Path) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let background = resources.join("assets/minecraft/textures/gui/title/background");
    // rust: let mut expected = None;
    // rust: for face in 0..6 {
    // rust: let Ok(png) = std::fs::read(background.join(format!("panorama_{face}.png"))) else {
    // rust: return true;
}
    // rust: if png.get(..16) != Some(b"\x89PNG\r\n\x1a\n\0\0\0\x0dIHDR") {
    // rust: return true;
}
    // rust: let Some(dimensions) = png.get(16..24) else {
    // rust: return true;
}
    // rust: let width =
    // rust: u32::from_be_bytes([dimensions[0], dimensions[1], dimensions[2], dimensions[3]]);
    // rust: let height =
    // rust: u32::from_be_bytes([dimensions[4], dimensions[5], dimensions[6], dimensions[7]]);
    // rust: if width <= 1 || width != height || expected.is_some_and(|size| size != width) {
    // rust: return true;
}
    // rust: expected = Some(width);
}
    // rust: !background.join("panorama_overlay.png").is_file()
}

lacks_unifont :: proc(resources: ^Path) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !resources
    // rust: .join("assets/minecraft/font/unifont.zip")
    // rust: .is_file()
}

// The language list only the asset index holds (the client jar's `lang` has English alone).
lacks_languages :: proc(resources: ^Path) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !resources.join("assets/pack.mcmeta").is_file()
}

// What the game's sound registry reads (horizon-client sound_events.rs).
lacks_sounds :: proc(resources: ^Path) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !resources.join("assets/minecraft/sounds.json").is_file()
}

    // rust: mod tests {
//     use super::*;
//     use std::fs;

folder :: proc(name: string) -> s {
    // Ported from Horizon
    return {}
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-check-{name}-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&dir);
    // rust: fs::create_dir_all(&dir).unwrap();
    // rust: fs::write(
    // rust: dir.join("research-lock.json"),
    // rust: r#"{"minecraft": {"version": "9.9", "java_major": 25}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: dir
}

file :: proc(path: ^Path, data: []u8) {
}
    // rust: fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: fs::write(path, data).unwrap();
}

    // A PNG's signature and IHDR size, all `lacks_panorama` reads.
png_header :: proc(width: u32, height: u32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut png = b"\x89PNG\r\n\x1a\n\0\0\0\x0dIHDR".to_vec();
    // rust: png.extend(width.to_be_bytes());
    // rust: png.extend(height.to_be_bytes());
    // rust: png
}

panorama_check_finds_missing_and_inconsistent_faces :: proc() {
}
    // rust: let dir = folder("panorama");
    // rust: let background = dir.join("assets/minecraft/textures/gui/title/background");
    // rust: for face in 0..6 {
    // rust: file(
    // rust: &background.join(format!("panorama_{face}.png")),
    // rust: &png_header(2, 2),
    // rust: );
}
    // rust: assert!(lacks_panorama(&dir));
    // rust: file(&background.join("panorama_overlay.png"), b"overlay");
    // rust: assert!(!lacks_panorama(&dir));
    // rust: file(&background.join("panorama_4.png"), &png_header(1, 1));
    // rust: assert!(lacks_panorama(&dir));
    // rust: file(&background.join("panorama_4.png"), &png_header(3, 3));
    // rust: assert!(lacks_panorama(&dir));
    // rust: fs::remove_file(background.join("panorama_4.png")).unwrap();
    // rust: assert!(lacks_panorama(&dir));
    // rust: let _ = fs::remove_dir_all(dir);
}

unprepared_resources_need_a_preparation :: proc() {
}
    // rust: let root = folder("unprepared");
    // rust: let lacking = check(&root, &root.join("out")).unwrap();
    // rust: assert_eq!(lacking.len(), 1);
    // rust: assert!(
    // rust: lacking[0].ends_with("horizon-prepare --prepare"),
    // rust: "{lacking:?}"
    // rust: );
}

complete_resources_pass_and_each_gap_names_its_command :: proc() {
}
    // rust: let root = folder("complete");
    // rust: let out = root.join("out");
    // rust: file(
    // rust: &out.join("horizon-resources.json"),
    // rust: format!(r#"{{"schema": {SCHEMA}, "minecraft": "9.9"}}"#).as_bytes(),
    // rust: );
    // rust: write_stamp(&out).unwrap();
    // rust: let assets = out.join("assets");
    // rust: for pack in crate::BUILT_IN_PACKS {
    // rust: file(&assets.join(pack), b"zip");
}
    // rust: let background = assets.join("minecraft/textures/gui/title/background");
    // rust: for face in 0..6 {
    // rust: file(
    // rust: &background.join(format!("panorama_{face}.png")),
    // rust: &png_header(1024, 1024),
    // rust: );
}
    // rust: file(&background.join("panorama_overlay.png"), b"overlay");
    // rust: file(&assets.join("minecraft/font/unifont.zip"), b"zip");
    // rust: file(&assets.join("pack.mcmeta"), b"{}");
    // rust: file(&assets.join("minecraft/sounds.json"), b"{}");
    // rust: assert_eq!(check(&root, &out).unwrap(), Vec::<String>::new());

    // rust: fs::remove_file(assets.join("minecraft/font/unifont.zip")).unwrap();
    // rust: fs::remove_file(out.join(STAMP)).unwrap();
    // rust: let lacking = check(&root, &out).unwrap();
    // rust: assert_eq!(lacking.len(), 2, "{lacking:?}");
    // rust: assert!(lacking[0].starts_with("made by output version unknown"));
    // rust: assert!(lacking[1].ends_with("horizon-prepare fonts"));
}

a_preparation_removes_the_stamp_before_writing :: proc() {
}
    // rust: let root = folder("restamp");
    // rust: let out = root.join("out");
    // rust: write_stamp(&out).unwrap();
    // rust: remove_stamp(&out).unwrap();
    // rust: assert!(!out.join(STAMP).exists());
        // Nothing to remove is not an error.
    // rust: remove_stamp(&out).unwrap();
}

a_second_preparation_of_a_folder_waits_for_the_first :: proc() {
}
    // rust: let root = folder("lock");
    // rust: let first = crate::hold_lock(&root, &|_| {}).unwrap();
    // rust: let waited = std::sync::Arc::new(std::sync::atomic::AtomicBool::new(false));
    // rust: let second = {
    // rust: let (root, waited) = (root.clone(), waited.clone());
    // rust: std::thread::spawn(move || {
    // rust: let said = std::cell::Cell::new(false);
    // rust: let _lock = crate::hold_lock(&root, &|line| {
    // rust: said.set(line.starts_with("Waiting for another horizon-prepare"))
    // rust: })
    // rust: .unwrap();
    // rust: waited.store(said.get(), std::sync::atomic::Ordering::SeqCst);
    // rust: })
}
    // rust: std::thread::sleep(std::time::Duration::from_millis(200));
    // rust: assert!(!second.is_finished(), "the second lock did not wait");
    // rust: drop(first);
    // rust: second.join().unwrap();
    // rust: assert!(waited.load(std::sync::atomic::Ordering::SeqCst));
}
}
