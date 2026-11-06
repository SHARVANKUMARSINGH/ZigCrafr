//! Transpiled from Horizon Rust crate
package horizon_optifine_emissive

import "core:fmt"
import "core:mem"
import "core:math"

// Emissive textures: a texture's overlay that draws at full brightness, named after it with
// the pack's emissive suffix (`zombie.png` and `zombie_e.png`).
//
// The suffix is `suffix.emissive` in the first of `assets/minecraft/optifine/emissive.properties`,
// ETF's `assets/minecraft/etf/emissive.properties` and `assets/minecraft/textures/emissive.properties`,
// and `_e` without one (as ETF reads it). An overlay sits beside its texture, so a random
// variant's is beside the variant: `optifine/random/entity/zombie/zombie3_e.png` glows over
// `zombie3`, never over `zombie`.
//
// This pairs entity textures, those under `textures/entity/` (mobs' and block entities'), by
// the entity atlas's names ([`crate::random_textures`]), and through [`Emissive::pair_beside`]
// random variants and their blink frames wherever they are. A blink frame glows with its own
// overlay only: the texture's would paint its open eyes over the shut ones. Blocks and items
// have their own atlas.
//
// Written from OptiFine's `emissive.properties` and ETF's `EMISSIVE_GUIDE.md` and
// `emissive.properties`; no mod's source was read.

// use std::collections::HashMap;
// use std::fs;
// use std::path::Path;

// use crate::paths::files_under;
// use crate::properties::Properties;
// use crate::random_textures::{MAX_PROPERTIES, RandomTextures, atlas_name, decode};

// The pack's emissive overlays, by the atlas name of the texture they glow over.
Emissive :: struct {
    suffix: string,
    overlays: HashMap<string,
    // Overlays outside `textures/` (of random variants): file and atlas name.
    files: Vec<(string,
}

// Where the suffix is read, first found first.
    // rust: const PROPERTIES: [&str; 3] = [
    // rust: "assets/minecraft/optifine/emissive.properties",
    // rust: "assets/minecraft/etf/emissive.properties",
    // rust: "assets/minecraft/textures/emissive.properties",
    // rust: ];

    // rust: impl Emissive {
scan :: proc(root: ^Path, random: ^RandomTextures) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let suffix = suffix(root);
    // rust: let mut out = Self {
    // rust: suffix,
    // rust: ..Self::default()
}
    // rust: let Ok(namespaces) = fs::read_dir(root.join("assets")) else {
    // rust: return out;
}
    // rust: let png = format!("{}.png", out.suffix);
    // rust: for ns in namespaces.flatten() {
    // rust: let ns = ns.file_name().to_string_lossy().into_owned();
    // rust: let prefix = format!("assets/{ns}/");
    // rust: for file in files_under(root, &format!("{prefix}textures/entity"), &[png.as_str()]) {
    // rust: let overlay = &file[prefix.len()..file.len() - ".png".len()];
    // rust: let base = &overlay[..overlay.len() - out.suffix.len()];
    // rust: if root.join(format!("{prefix}{base}.png")).is_file() {
    // rust: out.overlays
    // rust: .insert(atlas_name(&ns, base), atlas_name(&ns, overlay));
}
}
}
    // rust: out.pair_beside(root, random.files());
    // rust: out
}

    // Pairs each of `files` (file from the root, atlas name: random variants, blink frames)
    // with an overlay beside it, and lists those outside `textures/` for the atlas.
    // rust: pub fn pair_beside<'a>(
    // rust: &mut self,
    // rust: root: &Path,
    // rust: files: impl Iterator<Item = (&'a str, &'a str)>,
    // rust: ) {
    // rust: let png = format!("{}.png", self.suffix);
    // rust: for (file, name) in files {
    // rust: let Some(stem) = file.strip_suffix(".png") else {
    // rust: continue;
}
    // rust: let overlay = format!("{stem}{png}");
    // rust: if root.join(&overlay).is_file() {
    // rust: let overlay_name = format!("{name}{}", self.suffix);
    // rust: self.overlays.insert(name.to_owned(), overlay_name.clone());
                // Those under `textures/` are the atlas's already.
    // rust: if !overlay.contains("/textures/") {
    // rust: self.files.push((overlay, overlay_name));
}
}
}
}

is_empty :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.overlays.is_empty()
}

    // The atlas name of the overlay that glows over `texture`.
overlay :: proc(self: ^Self, texture: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.overlays.get(texture).map(String::as_str)
}

    // The overlays of random variants: file (from the resource root) and atlas name, for the
    // entity atlas to pack (it walks `textures/` itself).
files :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.files.iter().map(|(f, n)| (f.as_str(), n.as_str()))
}
}

// The pack's emissive suffix: `suffix.emissive` from the first of [`PROPERTIES`] that sets it,
// `_e` without one.
suffix :: proc(root: ^Path) -> S {
    // Ported from Horizon
    return {}
}
    // The first file that sets it (read as Java reads properties: Latin-1 when not UTF-8).
    // A suffix is a name's end: no path separators or `..`, so it can't leave the folder.
    // rust: PROPERTIES
    // rust: .iter()
    // rust: .find_map(|p| {
    // rust: let path = root.join(p);
    // rust: if fs::metadata(&path).ok()?.len() > MAX_PROPERTIES {
    // rust: return None;
}
    // rust: let text = decode(fs::read(path).ok()?);
    // rust: Properties::parse(&text)
    // rust: .get("suffix.emissive")
    // rust: .map(str::to_owned)
    // rust: })
    // rust: .filter(|s| !s.is_empty() && !s.contains(['/', '\\']) && !s.contains(".."))
    // rust: .unwrap_or_else(|| "_e".to_owned())
}

    // rust: mod tests {
//     use super::*;

pack :: proc(name: string, files: ^[string], suffix: Maybe(string)) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-emissive-{name}-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: for path in files {
    // rust: let path = root.join(path);
    // rust: fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: fs::write(path, "").unwrap();
}
    // rust: if let Some(suffix) = suffix {
    // rust: let path = root.join(PROPERTIES[0]);
    // rust: fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: fs::write(path, format!("suffix.emissive={suffix}\n")).unwrap();
}
    // rust: let e = Emissive::scan(&root, &RandomTextures::scan(&root));
    // rust: (root, e)
}

ENTITY :: "assets/minecraft/textures/entity"
RANDOM :: "assets/minecraft/optifine/random/entity"

overlays_beside_their_texture :: proc() {
}
    // rust: let (root, e) = pack(
    // rust: "beside",
    // rust: &[
    // rust: &format!("{ENTITY}/zombie/zombie.png"),
    // rust: &format!("{ENTITY}/zombie/zombie_e.png"),
                // No base: no overlay.
    // rust: &format!("{ENTITY}/zombie/husk_e.png"),
    // rust: &format!("{ENTITY}/chest/normal.png"),
    // rust: &format!("{ENTITY}/chest/normal_e.png"),
    // rust: "assets/mymod/textures/entity/bug/bug.png",
    // rust: "assets/mymod/textures/entity/bug/bug_e.png",
                // A variant's overlay glows over the variant only.
    // rust: &format!("{RANDOM}/zombie/zombie3.png"),
    // rust: &format!("{RANDOM}/zombie/zombie3_e.png"),
    // rust: &format!("{RANDOM}/zombie/zombie2.png"),
    // rust: ],
    // rust: None,
    // rust: );
    // rust: assert_eq!(e.suffix, "_e");
    // rust: assert_eq!(
    // rust: e.overlay("entity/zombie/zombie"),
    // rust: Some("entity/zombie/zombie_e")
    // rust: );
    // rust: assert_eq!(e.overlay("entity/zombie/husk"), None);
    // rust: assert_eq!(
    // rust: e.overlay("entity/chest/normal"),
    // rust: Some("entity/chest/normal_e")
    // rust: );
    // rust: assert_eq!(
    // rust: e.overlay("mymod:entity/bug/bug"),
    // rust: Some("mymod:entity/bug/bug_e")
    // rust: );
    // rust: let variant = "minecraft:optifine/random/entity/zombie/zombie3";
    // rust: assert_eq!(e.overlay(variant), Some(format!("{variant}_e").as_str()));
    // rust: assert_eq!(
    // rust: e.overlay("minecraft:optifine/random/entity/zombie/zombie2"),
    // rust: None
    // rust: );
    // rust: assert_eq!(
    // rust: e.files().collect::<Vec<_>>(),
    // rust: [(
    // rust: "assets/minecraft/optifine/random/entity/zombie/zombie3_e.png",
    // rust: "minecraft:optifine/random/entity/zombie/zombie3_e"
    // rust: )]
    // rust: );
    // rust: let _ = fs::remove_dir_all(root);
}

the_packs_suffix :: proc() {
}
    // rust: let (root, e) = pack(
    // rust: "suffix",
    // rust: &[
    // rust: &format!("{ENTITY}/zombie/zombie.png"),
    // rust: &format!("{ENTITY}/zombie/zombie_e.png"),
    // rust: &format!("{ENTITY}/zombie/zombie_glow.png"),
    // rust: ],
    // rust: Some("_glow"),
    // rust: );
    // rust: assert_eq!(
    // rust: e.overlay("entity/zombie/zombie"),
    // rust: Some("entity/zombie/zombie_glow")
    // rust: );
    // rust: let _ = fs::remove_dir_all(root);
}

where_the_suffix_is_read :: proc() {
}
    // rust: let suffix = |files: &[(&str, &[u8])]| {
    // rust: let root = std::env::temp_dir().join(format!(
    // rust: "horizon-emissive-where-{}-{}",
    // rust: std::process::id(),
    // rust: files.len()
    // rust: ));
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: for (path, bytes) in files {
    // rust: let path = root.join(path);
    // rust: fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: fs::write(path, bytes).unwrap();
}
    // rust: let e = Emissive::scan(&root, &RandomTextures::default());
    // rust: let _ = fs::remove_dir_all(root);
    // rust: e.suffix
}
        // ETF's folder, when OptiFine's file is missing or doesn't set it.
    // rust: assert_eq!(suffix(&[(PROPERTIES[1], b"suffix.emissive=_lit")]), "_lit");
    // rust: assert_eq!(
    // rust: suffix(&[
    // rust: (PROPERTIES[0], b"# trims only"),
    // rust: (PROPERTIES[2], b"suffix.emissive=_lit")
    // rust: ]),
    // rust: "_lit"
    // rust: );
        // A Latin-1 comment doesn't hide it.
    // rust: assert_eq!(
    // rust: suffix(&[
    // rust: (PROPERTIES[0], b"# cr\xe9\xe9\nsuffix.emissive=_glow"),
    // rust: (PROPERTIES[1], b"x=1"),
    // rust: (PROPERTIES[2], b"x=1")
    // rust: ]),
    // rust: "_glow"
    // rust: );
        // Nothing that could leave the texture's folder.
    // rust: for bad in [
    // rust: &b"suffix.emissive=_a\\\\b"[..],
    // rust: b"suffix.emissive=/x",
    // rust: b"suffix.emissive=..",
    // rust: ] {
    // rust: assert_eq!(suffix(&[(PROPERTIES[0], bad)]), "_e");
}
}

blink_frames_glow_with_their_own_overlay_only :: proc() {
}
    // rust: let (root, mut e) = pack(
    // rust: "blink",
    // rust: &[
    // rust: &format!("{RANDOM}/zombie/zombie3.png"),
    // rust: &format!("{RANDOM}/zombie/zombie3_e.png"),
    // rust: &format!("{RANDOM}/zombie/zombie3_blink.png"),
    // rust: &format!("{RANDOM}/zombie/zombie3_blink_e.png"),
    // rust: &format!("{ENTITY}/pig/pig.png"),
    // rust: &format!("{ENTITY}/pig/pig_e.png"),
    // rust: &format!("{ENTITY}/pig/pig_blink.png"),
    // rust: ],
    // rust: None,
    // rust: );
    // rust: let blinks = crate::blink::Blinks::scan(&root, &RandomTextures::scan(&root));
    // rust: e.pair_beside(&root, blinks.files());
    // rust: let frame = "minecraft:optifine/random/entity/zombie/zombie3_blink";
    // rust: assert_eq!(e.overlay(frame), Some(format!("{frame}_e").as_str()));
    // rust: assert!(e.files().any(|(_, name)| name == format!("{frame}_e")));
        // No pig_blink_e: the shut eye doesn't take the pig's glow (its open eyes, mostly).
    // rust: assert_eq!(e.overlay("entity/pig/pig_blink"), None);
    // rust: let _ = fs::remove_dir_all(root);
}

no_overlays_no_entries :: proc() {
}
    // rust: let (root, e) = pack("none", &[&format!("{ENTITY}/zombie/zombie.png")], None);
    // rust: assert!(e.is_empty());
    // rust: let _ = fs::remove_dir_all(root);
}
}
