//! Transpiled from Horizon Rust crate
package horizon_optifine_random_textures

import "core:fmt"
import "core:mem"
import "core:math"

// Where a pack keeps its random entity textures: the numbered variants of each texture and the
// [`Rules`] that choose between them.
//
// A texture `assets/<ns>/textures/<path>.png` has its variants in the first of these folders
// that has any, each mirroring `textures/` (the `mob/` ones mirror `textures/entity/`):
//
// 1. ETF's `assets/<ns>/etf/random/<path>`
// 2. `assets/<ns>/optifine/random/<path>`
// 3. the legacy `assets/<ns>/optifine/mob/`, then `assets/<ns>/mcpatcher/mob/`
// 4. beside the texture itself under `textures/entity/` (ETF's extra). Horizon uses this
//    folder only for a texture with rules there (its own `.properties` or the one of the name
//    it extends), so that a pack without OptiFine files never changes a texture.
//
// Variant `N` (1 to [`MAX_INDEX`]) of `creeper` is `creeper<N>.png`; of a name ending in a
// digit (`warden_pulsating_spots_2`), `warden_pulsating_spots_2.<N>.png`. Variant 1 is the
// texture itself unless a `<name>1.png` exists. `<name>.properties` holds the rules; a texture
// without its own uses the one of the name it extends in the same folder (`wolf_tame` and
// `wolf_angry` use `wolf.properties`, `spider_eyes` uses `spider.properties`). With no rules
// at all, an entity picks evenly between the texture and its variants 2, 3... up to the first
// missing number.
//
// Textures have the names the entity atlas gives them: a vanilla texture its path under
// `textures/` (`entity/zombie/zombie`), another namespace's `<ns>:<path>`, and a file outside
// `textures/` its namespace and its path under the namespace
// (`minecraft:optifine/random/entity/zombie/zombie2`). [`RandomTextures::files`] lists every
// variant's file and name for the atlas, which skips those it already packs.
//
// Written from OptiFine's `random_entities.properties` and ETF's `RANDOM_GUIDE.md`; no mod's
// source was read.

// use std::collections::{BTreeMap, HashMap};
// use std::fs;
// use std::path::Path;

// use crate::paths::files_under;
// use crate::properties::Properties;
// use crate::random::{MAX_INDEX, Rules};

// Every texture a pack varies, by its atlas name.
RandomTextures :: struct {
    entries: HashMap<string,
    rules: [dynamic]Rules,
    // Different for every scan: choices made from another scan's rules are stale.
    generation: u64,
}

// One texture's variants.
Entry :: struct {
    // Index into [`RandomTextures::rules`]: the rules that choose this texture's variant.
    rules: Maybe(uint),
    variants: BTreeMap<u32,
}

Variant :: struct {
    // Its atlas name.
    name: string,
    // Its path from the resource root.
    file: string,
}

// The folders under `assets/<ns>/` that hold variants, in priority order, and the folder under
// `assets/<ns>/` each mirrors. The last is the texture's own folder.
    // rust: const FOLDERS: [(&str, &str); 5] = [
    // rust: ("etf/random", "textures"),
    // rust: ("optifine/random", "textures"),
    // rust: ("optifine/mob", "textures/entity"),
    // rust: ("mcpatcher/mob", "textures/entity"),
    // rust: ("textures/entity", "textures/entity"),
    // rust: ];
// The largest `.properties` file read, in bytes.
    // rust: pub(crate) const MAX_PROPERTIES: u64 = 64 * 1024;

// The texture's own folder, last in priority.
BESIDE :: FOLDERS.len() - 1

Source :: struct {
    properties: Maybe(string),
    variants: BTreeMap<u32,
}

    // rust: impl RandomTextures {
scan :: proc(root: ^Path) -> S {
    // Ported from Horizon
    return {}
}
GENERATION :: std::sync::atomic::AtomicU64::new(1)
    // rust: let generation = GENERATION.fetch_add(1, std::sync::atomic::Ordering::Relaxed);
    // rust: Self {
    // rust: generation,
    // rust: ..Self::scan_files(root)
}
}

    // This scan's number, never 0 (the empty set's).
generation :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.generation
}

scan_files :: proc(root: ^Path) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut found: HashMap<String, [Source; FOLDERS.len()]> = HashMap::new();
    // rust: let Ok(namespaces) = fs::read_dir(root.join("assets")) else {
    // rust: return Self::default();
}
    // rust: let mut namespaces: Vec<String> = namespaces
    // rust: .flatten()
    // rust: .map(|e| e.file_name().to_string_lossy().into_owned())
    // rust: .collect();
    // rust: namespaces.sort();
    // rust: for ns in &namespaces {
    // rust: let prefix = format!("assets/{ns}/");
    // rust: for (source, (folder, mirror)) in FOLDERS.iter().enumerate() {
    // rust: let folder = format!("{prefix}{folder}");
    // rust: for file in files_under(root, &folder, &[".png", ".properties"]) {
    // rust: let inner = format!("{mirror}{}", &file[folder.len()..]);
    // rust: let own = &file[prefix.len()..];
    // rust: add(&mut found, source, ns, &inner, own, &file);
}
}
}
    // rust: let mut out = Self::default();
    // rust: let mut rules_by_file: HashMap<String, usize> = HashMap::new();
    // rust: for (texture, sources) in &found {
    // rust: let Some(source) = sources
    // rust: .iter()
    // rust: .position(|s| s.properties.is_some() || !s.variants.is_empty())
    // rust: else {
    // rust: continue;
}
    // rust: let chosen = &sources[source];
            // Its own rules, or those of the name it extends: `_`-parts cut from the file name.
    // rust: let (dir, mut name) = texture.rsplit_once('/').unwrap_or(("", texture));
    // rust: let mut rules_file = chosen.properties.clone();
    // rust: while rules_file.is_none()
    // rust: && let Some((shorter, _)) = name.rsplit_once('_')
    // rust: {
    // rust: name = shorter;
    // rust: rules_file = found
    // rust: .get(&format!("{dir}/{name}"))
    // rust: .and_then(|s| s[source].properties.clone());
}
    // rust: if source == BESIDE && rules_file.is_none() {
    // rust: continue;
}
    // rust: let rules = rules_file.map(|file| {
    // rust: if let Some(&id) = rules_by_file.get(&file) {
    // rust: return id;
}
                // A real rules file is a few KB, and parsing grows with the square of its size:
                // a bigger or unreadable one holds no rules, so the texture keeps its default.
    // rust: let path = root.join(&file);
    // rust: let text = fs::metadata(&path)
    // rust: .is_ok_and(|m| m.len() <= MAX_PROPERTIES)
    // rust: .then(|| fs::read(&path).ok())
    // rust: .flatten()
    // rust: .map(decode)
    // rust: .unwrap_or_default();
    // rust: out.rules.push(Rules::parse(&Properties::parse(&text)));
    // rust: rules_by_file.insert(file, out.rules.len() - 1);
    // rust: out.rules.len() - 1
    // rust: });
    // rust: out.entries.insert(
    // rust: texture.clone(),
    // rust: Entry {
    // rust: rules,
    // rust: variants: chosen.variants.clone(),
    // rust: },
    // rust: );
}
    // rust: out
}

is_empty :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.entries.is_empty()
}

    // The variants of the texture with this atlas name.
get :: proc(self: ^Self, texture: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.entries.get(texture)
}

rules :: proc(self: ^Self, id: uint) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.rules[id]
}

    // Every variant's file (its path from the resource root) and atlas name, for the entity
    // atlas to pack. That includes variants beside their texture under `textures/entity/`,
    // which the atlas may already walk.
files :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.entries.values().flat_map(|e| {
    // rust: e.variants
    // rust: .values()
    // rust: .map(|v| (v.file.as_str(), v.name.as_str()))
    // rust: })
}
}

    // rust: impl Entry {
    // The atlas name of variant `index`, or `None` for the texture itself: variant 0, 1 without
    // a `<name>1.png`, and a variant whose file is missing.
texture :: proc(self: ^Self, index: u32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.variants.get(&index).map(|v| v.name.as_str())
}

    // The even choice of an entity with this seed when no rules apply: the texture and its
    // variants 2, 3... up to the first missing one.
even :: proc(self: ^Self, seed: i32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let mut count = 1;
    // rust: while self.variants.contains_key(&(count + 1)) {
    // rust: count += 1;
}
    // rust: seed.unsigned_abs() % count + 1
}
}

// UTF-8, or else ISO-8859-1 as Java's `Properties.load` reads a stream: a properties file
// saved in Latin-1 keeps its rules.
    // rust: pub(crate) fn decode(bytes: Vec<u8>) -> String {
    // rust: String::from_utf8(bytes)
    // rust: .unwrap_or_else(|e| e.into_bytes().iter().map(|&b| char::from(b)).collect())
}

// Records `file` (a path from the root), whose mirrored path under `assets/<ns>/` is `inner`
// (`textures/entity/zombie/zombie2.png`) and own path there `own`: a texture's rules, or one of
// its variants.
    // rust: fn add(
    // rust: found: &mut HashMap<String, [Source; FOLDERS.len()]>,
    // rust: source: usize,
    // rust: ns: &str,
    // rust: inner: &str,
    // rust: own: &str,
    // rust: file: &str,
    // rust: ) {
    // rust: let Some((dir, name)) = inner.rsplit_once('/') else {
    // rust: return;
}
    // rust: if let Some(stem) = name.strip_suffix(".properties") {
    // rust: let key = atlas_name(ns, &format!("{dir}/{stem}"));
    // rust: found.entry(key).or_default()[source].properties = Some(file.to_owned());
    // rust: } else if let Some((base, n)) = name.strip_suffix(".png").and_then(split_variant) {
    // rust: let key = atlas_name(ns, &format!("{dir}/{base}"));
    // rust: let variant = Variant {
    // rust: name: atlas_name(ns, own.strip_suffix(".png").unwrap_or(own)),
    // rust: file: file.to_owned(),
}
    // rust: found.entry(key).or_default()[source]
    // rust: .variants
    // rust: .insert(n, variant);
}
}

// `creeper7` → (`creeper`, 7); `spots_2.3` → (`spots_2`, 3). Not a variant: `creeper`;
// `spots_22` (a name ending in a digit numbers its variants after a `.`); `spots_2`, `bed_1`
// (no texture name ends in `_`); `creeper02` (the docs number variants without leading
// zeros); index 0 (the texture itself) and indices past [`MAX_INDEX`].
split_variant :: proc(stem: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let digits = stem.len() - stem.trim_end_matches(|c: char| c.is_ascii_digit()).len();
    // rust: let (base, n) = stem.split_at(stem.len() - digits);
    // rust: if n.starts_with('0') {
    // rust: return None;
}
    // rust: let n: u32 = n.parse().ok().filter(|n| (1..=MAX_INDEX).contains(n))?;
    // rust: match base.strip_suffix('.') {
    // rust: Some(b) if b.ends_with(|c: char| c.is_ascii_digit()) => Some((b, n)),
    // rust: None if !base.is_empty() && !base.ends_with(|c: char| c.is_ascii_digit() || c == '_') => {
    // rust: Some((base, n))
}
    // rust: _ => None,
}
}

// A path under `assets/<ns>/` as the entity atlas names it.
    // rust: pub(crate) fn atlas_name(ns: &str, inner: &str) -> String {
    // rust: match inner.strip_prefix("textures/") {
    // rust: Some(path) if ns == "minecraft" => path.to_owned(),
    // rust: Some(path) => format!("{ns}:{path}"),
    // rust: None => format!("{ns}:{inner}"),
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::random::Facts;

pack :: proc(files: ^[(string) {
}
N :: std::sync::atomic::AtomicU32::new(0)
    // rust: let root = std::env::temp_dir().join(format!(
    // rust: "horizon-random-textures-{}-{}",
    // rust: std::process::id(),
    // rust: N.fetch_add(1, std::sync::atomic::Ordering::Relaxed)
    // rust: ));
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: for (path, text) in files {
    // rust: let path = root.join(path);
    // rust: fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: fs::write(path, text).unwrap();
}
    // rust: let found = RandomTextures::scan(&root);
    // rust: (root, found)
}

RANDOM :: "assets/minecraft/optifine/random/entity"

variants_and_rules_by_texture :: proc() {
}
    // rust: let (root, t) = pack(&[
    // rust: (&format!("{RANDOM}/creeper/creeper2.png"), ""),
    // rust: (&format!("{RANDOM}/creeper/creeper3.png"), ""),
    // rust: (&format!("{RANDOM}/creeper/creeper5.png"), ""),
    // rust: (
    // rust: &format!("{RANDOM}/warden/warden_pulsating_spots_2.2.png"),
    // rust: "",
    // rust: ),
    // rust: (
    // rust: &format!("{RANDOM}/warden/warden_pulsating_spots_22.png"),
    // rust: "",
    // rust: ),
    // rust: (
    // rust: &format!("{RANDOM}/wolf/wolf.properties"),
    // rust: "textures.1=2\nbaby.1=true",
    // rust: ),
    // rust: (&format!("{RANDOM}/wolf/wolf2.png"), ""),
    // rust: (&format!("{RANDOM}/wolf/wolf_tame2.png"), ""),
    // rust: ("assets/minecraft/textures/entity/creeper/creeper.png", ""),
    // rust: ]);
    // rust: let creeper = t.get("entity/creeper/creeper").unwrap();
    // rust: assert_eq!(creeper.rules, None);
    // rust: assert_eq!(
    // rust: creeper.texture(3),
    // rust: Some("minecraft:optifine/random/entity/creeper/creeper3")
    // rust: );
    // rust: assert_eq!(
    // rust: creeper.texture(1),
    // rust: None,
    // rust: "no creeper1.png: the texture itself"
    // rust: );
    // rust: assert_eq!(creeper.texture(4), None, "missing");
        // No rules: an even choice of 1, 2 and 3; 5 is past the gap at 4.
    // rust: assert_eq!(creeper.even(0), 1);
    // rust: assert_eq!(creeper.even(4), 2);
    // rust: assert_eq!(creeper.even(-5), 3);
    // rust: let spots = t.get("entity/warden/warden_pulsating_spots_2").unwrap();
    // rust: assert_eq!(
    // rust: spots.texture(2),
    // rust: Some("minecraft:optifine/random/entity/warden/warden_pulsating_spots_2.2")
    // rust: );
    // rust: assert_eq!(spots.texture(22), None, "spots_22 is no variant of spots_2");
        // wolf_tame has no rules of its own: it uses wolf.properties.
    // rust: let wolf = t.get("entity/wolf/wolf").unwrap();
    // rust: let tame = t.get("entity/wolf/wolf_tame").unwrap();
    // rust: assert!(wolf.rules.is_some());
    // rust: assert_eq!(tame.rules, wolf.rules);
    // rust: let baby = Facts {
    // rust: baby: Some(true),
    // rust: ..Default::default()
}
    // rust: assert_eq!(t.rules(tame.rules.unwrap()).select(&baby, 0), 2);
        // spots_22 is no variant at all: no texture is named `warden_pulsating_spots_`.
    // rust: assert_eq!(t.files().count(), 6);
    // rust: assert!(t.files().any(|(file, name)| {
    // rust: file == "assets/minecraft/optifine/random/entity/wolf/wolf_tame2.png"
    // rust: && name == "minecraft:optifine/random/entity/wolf/wolf_tame2"
    // rust: }));
    // rust: let _ = fs::remove_dir_all(root);
}

folders_in_priority_order :: proc() {
}
    // rust: let (root, t) = pack(&[
    // rust: ("assets/minecraft/etf/random/entity/pig/pig2.png", ""),
    // rust: (&format!("{RANDOM}/pig/pig2.png"), ""),
    // rust: (&format!("{RANDOM}/pig/pig3.png"), ""),
    // rust: ("assets/minecraft/mcpatcher/mob/cow/cow2.png", ""),
    // rust: ("assets/minecraft/optifine/mob/sheep/sheep2.png", ""),
    // rust: ("assets/mymod/optifine/random/entity/bug/bug2.png", ""),
            // Beside the vanilla texture: only with a properties file.
    // rust: ("assets/minecraft/textures/entity/fox/fox2.png", ""),
    // rust: (
    // rust: "assets/minecraft/textures/entity/cat/cat.properties",
    // rust: "textures.1=2",
    // rust: ),
    // rust: ("assets/minecraft/textures/entity/cat/cat2.png", ""),
    // rust: ]);
    // rust: let pig = t.get("entity/pig/pig").unwrap();
    // rust: assert_eq!(pig.texture(2), Some("minecraft:etf/random/entity/pig/pig2"));
    // rust: assert_eq!(pig.texture(3), None, "only the ETF folder is used");
    // rust: assert_eq!(
    // rust: t.get("entity/cow/cow").unwrap().texture(2),
    // rust: Some("minecraft:mcpatcher/mob/cow/cow2")
    // rust: );
    // rust: assert_eq!(
    // rust: t.get("entity/sheep/sheep").unwrap().texture(2),
    // rust: Some("minecraft:optifine/mob/sheep/sheep2")
    // rust: );
    // rust: assert_eq!(
    // rust: t.get("mymod:entity/bug/bug").unwrap().texture(2),
    // rust: Some("mymod:optifine/random/entity/bug/bug2")
    // rust: );
    // rust: assert!(t.get("entity/fox/fox").is_none());
    // rust: let cat = t.get("entity/cat/cat").unwrap();
    // rust: assert_eq!(cat.texture(2), Some("entity/cat/cat2"));
    // rust: assert!(cat.rules.is_some());
    // rust: let _ = fs::remove_dir_all(root);
}

legacy_folders_after_optifine_random :: proc() {
}
    // rust: let both = [
    // rust: (format!("{RANDOM}/pig/pig2.png"), ""),
    // rust: ("assets/minecraft/optifine/mob/pig/pig2.png".into(), ""),
    // rust: ("assets/minecraft/mcpatcher/mob/pig/pig2.png".into(), ""),
    // rust: ];
    // rust: let files: Vec<(&str, &str)> = both.iter().map(|(p, t)| (p.as_str(), *t)).collect();
    // rust: let (root, t) = pack(&files);
    // rust: let pig = t.get("entity/pig/pig").unwrap();
    // rust: assert_eq!(
    // rust: pig.texture(2),
    // rust: Some("minecraft:optifine/random/entity/pig/pig2")
    // rust: );
    // rust: let _ = fs::remove_dir_all(root);
    // rust: let (root, t) = pack(&files[1..]);
    // rust: let pig = t.get("entity/pig/pig").unwrap();
    // rust: assert_eq!(pig.texture(2), Some("minecraft:optifine/mob/pig/pig2"));
    // rust: let _ = fs::remove_dir_all(root);
}

inherited_rules_stay_in_their_folder :: proc() {
}
    // rust: let (root, t) = pack(&[
    // rust: (
    // rust: &format!("{RANDOM}/spider/spider.properties"),
    // rust: "textures.1=2",
    // rust: ),
    // rust: (&format!("{RANDOM}/spider/spider_eyes2.png"), ""),
    // rust: (&format!("{RANDOM}/a/a.properties"), "textures.1=2"),
    // rust: (&format!("{RANDOM}/a/a_b_c2.png"), ""),
            // A flat legacy zombie's rules don't reach the zombie villager's folder.
    // rust: (
    // rust: "assets/minecraft/optifine/mob/zombie.properties",
    // rust: "textures.1=2",
    // rust: ),
    // rust: (
    // rust: "assets/minecraft/optifine/mob/zombie_villager/zombie_villager2.png",
    // rust: "",
    // rust: ),
            // Nor do another folder's.
    // rust: (&format!("{RANDOM}/wolf/wolf.properties"), "textures.1=2"),
    // rust: ("assets/minecraft/etf/random/entity/wolf/wolf_tame2.png", ""),
    // rust: (&format!("{RANDOM}/creeper/creeper1.png"), ""),
    // rust: (&format!("{RANDOM}/creeper/creeper2.png"), ""),
    // rust: ]);
    // rust: let spider = t.get("entity/spider/spider").map(|e| e.rules);
    // rust: assert!(spider.is_some_and(|r| r.is_some()));
    // rust: assert_eq!(
    // rust: t.get("entity/spider/spider_eyes").unwrap().rules,
    // rust: spider.unwrap()
    // rust: );
    // rust: assert!(t.get("entity/a/a_b_c").unwrap().rules.is_some());
    // rust: assert_eq!(
    // rust: t.get("entity/zombie_villager/zombie_villager")
    // rust: .unwrap()
    // rust: .rules,
    // rust: None
    // rust: );
    // rust: assert_eq!(t.get("entity/wolf/wolf_tame").unwrap().rules, None);
        // creeper1.png replaces variant 1.
    // rust: let creeper = t.get("entity/creeper/creeper").unwrap();
    // rust: assert_eq!(
    // rust: creeper.texture(1),
    // rust: Some("minecraft:optifine/random/entity/creeper/creeper1")
    // rust: );
    // rust: let _ = fs::remove_dir_all(root);
}

beside_the_texture_with_rules :: proc() {
}
WOLF :: "assets/minecraft/textures/entity/wolf"
    // rust: let (root, t) = pack(&[
    // rust: (&format!("{WOLF}/wolf.properties"), "textures.1=5"),
    // rust: (&format!("{WOLF}/wolf.png"), ""),
    // rust: (&format!("{WOLF}/wolf2.png"), ""),
    // rust: (&format!("{WOLF}/wolf5.png"), ""),
    // rust: (&format!("{WOLF}/wolf_tame2.png"), ""),
    // rust: ]);
        // A rule may name a variant past a gap.
    // rust: assert_eq!(
    // rust: t.get("entity/wolf/wolf").unwrap().texture(5),
    // rust: Some("entity/wolf/wolf5")
    // rust: );
    // rust: let tame = t.get("entity/wolf/wolf_tame").unwrap();
    // rust: assert!(
    // rust: tame.rules.is_some(),
    // rust: "wolf_tame beside uses wolf.properties"
    // rust: );
    // rust: let _ = fs::remove_dir_all(root);
        // The texture's own folder comes after the others.
    // rust: let (root, t) = pack(&[
    // rust: (&format!("{WOLF}/wolf.properties"), "textures.1=2"),
    // rust: (&format!("{WOLF}/wolf2.png"), ""),
    // rust: (&format!("{RANDOM}/wolf/wolf2.png"), ""),
    // rust: ]);
    // rust: let wolf = t.get("entity/wolf/wolf").unwrap();
    // rust: assert_eq!(
    // rust: wolf.texture(2),
    // rust: Some("minecraft:optifine/random/entity/wolf/wolf2")
    // rust: );
    // rust: assert_eq!(wolf.rules, None, "optifine/random's folder holds no rules");
    // rust: let _ = fs::remove_dir_all(root);
}

an_oversized_rules_file_keeps_the_default :: proc() {
}
    // rust: let big = format!("textures.1=2\n#{}\n", "x".repeat(MAX_PROPERTIES as usize));
    // rust: let (root, t) = pack(&[
    // rust: (&format!("{RANDOM}/wolf/wolf.properties"), &big),
    // rust: (&format!("{RANDOM}/wolf/wolf2.png"), ""),
    // rust: ]);
    // rust: let wolf = t.get("entity/wolf/wolf").unwrap();
    // rust: let rules = t.rules(wolf.rules.expect("rules, empty ones"));
    // rust: assert_eq!(
    // rust: rules.select(&Facts::default(), 1),
    // rust: 1,
    // rust: "not textures.1=2, not even"
    // rust: );
    // rust: let _ = fs::remove_dir_all(root);
}

latin1_rules_are_read :: proc() {
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-random-latin1-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: let dir = root.join(RANDOM).join("creeper");
    // rust: fs::create_dir_all(&dir).unwrap();
        // `Ébène` in ISO-8859-1: 0xC9 and 0xE8 are no UTF-8.
    // rust: fs::write(
    // rust: dir.join("creeper.properties"),
    // rust: b"textures.1=2\nname.1=\xc9b\xe8ne\n",
    // rust: )
    // rust: .unwrap();
    // rust: fs::write(dir.join("creeper2.png"), b"").unwrap();
    // rust: let t = RandomTextures::scan(&root);
    // rust: let id = t.get("entity/creeper/creeper").unwrap().rules.unwrap();
    // rust: let named = |name| Facts {
    // rust: name: Some(name),
    // rust: ..Default::default()
}
    // rust: assert_eq!(t.rules(id).select(&named("Ébène"), 0), 2);
    // rust: assert_eq!(t.rules(id).select(&named("Ebene"), 0), 1);
    // rust: let _ = fs::remove_dir_all(root);
}

no_files_no_entries :: proc() {
}
    // rust: let (root, t) = pack(&[("assets/minecraft/textures/entity/pig/pig.png", "")]);
    // rust: assert!(t.is_empty());
    // rust: let _ = fs::remove_dir_all(root);
}

variant_names :: proc() {
}
    // rust: assert_eq!(split_variant("creeper12"), Some(("creeper", 12)));
    // rust: assert_eq!(split_variant("spots_2.3"), Some(("spots_2", 3)));
    // rust: assert_eq!(split_variant("creeper"), None);
    // rust: assert_eq!(
    // rust: split_variant("spots_2"),
    // rust: None,
    // rust: "no texture is named `spots_`"
    // rust: );
    // rust: assert_eq!(split_variant("creeper1"), Some(("creeper", 1)));
    // rust: assert_eq!(split_variant("creeper0"), None, "0 is the texture itself");
    // rust: assert_eq!(split_variant("creeper02"), None);
    // rust: assert_eq!(split_variant("spots_2.02"), None);
    // rust: assert_eq!(split_variant("2"), None);
    // rust: assert_eq!(split_variant("a.3"), None, "a `.` only follows a digit");
    // rust: assert_eq!(split_variant("x99999"), None);
}
}
