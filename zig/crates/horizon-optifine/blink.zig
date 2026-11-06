//! Transpiled from Horizon Rust crate
//! Module: horizon-optifine_blink
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! ETF's blinking textures: beside a texture, `<name>_blink.png` (eyes shut) and optionally
//! `<name>_blink2.png` (half shut), which the entity wears for a few ticks now and then. A
//! `<name>_blink.properties` beside them sets `blinkLength` and `blinkFrequency` (in ticks); a
//! random variant blinks with its own (`zombie3_blink.png`).
//!
//! Without a properties file a blink lasts [`LENGTH`] ticks every [`FREQUENCY`]: the values of
//! ETF's documented example, as its docs give no defaults. With a half-shut frame, the first and
//! last ticks of a blink of 3 or more show it.
//!
//! Written from ETF's README ("Blinking textures"); no mod's source was read.

// use std::collections::HashMap;
// use std::fs;
// use std::path::Path;

// use crate::paths::files_under;
// use crate::properties::Properties;
// use crate::random_textures::{RandomTextures, atlas_name};

pub const LENGTH: u32 = 5;
pub const FREQUENCY: u32 = 150;

/// The pack's blinking textures, by the atlas name of the texture they replace.
pub const Blinks = struct {
    blinks: HashMap<[]const u8,
    /// The blink frames of random variants: file and atlas name, for the atlas to pack.
    files: Vec<([]const u8,
};

pub const Blink = struct {
    /// The atlas names of the shut and half-shut frames.
    shut: []const u8,
    half: ?[]const u8,
    length: u32,
    frequency: u32,
};

    // rust: impl Blinks {
pub fn scan(root: *Path, random: *RandomTextures) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Self::default();
    // rust: let Ok(namespaces) = fs::read_dir(root.join("assets")) else {
    // rust: return out;
}
    // rust: for ns in namespaces.flatten() {
    // rust: let ns = ns.file_name().to_string_lossy().into_owned();
    // rust: let prefix = format!("assets/{ns}/");
    // rust: for file in files_under(root, &format!("{prefix}textures/entity"), &["_blink.png"]) {
    // rust: let stem = &file[..file.len() - "_blink.png".len()];
    // rust: if root.join(format!("{stem}.png")).is_file() {
    // rust: let blink =
    // rust: Blink::read(root, stem, |path| atlas_name(&ns, &path[prefix.len()..]));
    // rust: out.blinks
    // rust: .insert(atlas_name(&ns, &stem[prefix.len()..]), blink);
}
}
}
    // rust: for (file, name) in random.files() {
    // rust: let Some(stem) = file.strip_suffix(".png") else {
    // rust: continue;
}
    // rust: if !root.join(format!("{stem}_blink.png")).is_file() {
    // rust: continue;
}
    // rust: let frame = |path: &str| format!("{name}{}", &path[stem.len()..]);
    // rust: let blink = Blink::read(root, stem, frame);
    // rust: if !file.contains("/textures/") {
    // rust: out.files
    // rust: .push((format!("{stem}_blink.png"), blink.shut.clone()));
    // rust: if let Some(half) = &blink.half {
    // rust: out.files.push((format!("{stem}_blink2.png"), half.clone()));
}
}
    // rust: out.blinks.insert(name.to_owned(), blink);
}
    // rust: out
}

pub fn is_empty(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.blinks.is_empty()
}

pub fn get(self: *Self, texture: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.blinks.get(texture)
}

    /// The frames of random variants' blinks: file and atlas name, for the entity atlas to pack
    /// (it walks `textures/` itself).
pub fn files(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.files.iter().map(|(f, n)| (f.as_str(), n.as_str()))
}
}

    // rust: impl Blink {
    /// The blink of the texture at `stem` (its path from the root, no `.png`); `name` gives a
    /// frame's atlas name from its path.
pub fn read(root: *Path, stem: []const u8, name: impl Fn([]const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let props = fs::read_to_string(root.join(format!("{stem}_blink.properties")))
    // rust: .map(|text| Properties::parse(&text))
    // rust: .unwrap_or_default();
    // rust: let number = |key, default| {
    // rust: props
    // rust: .get(key)
    // rust: .and_then(|v| v.parse().ok())
    // rust: .unwrap_or(default)
}
        // At least a tick, and short of `u32::MAX` so the frequency can exceed it.
    // rust: let length: u32 = number("blinkLength", LENGTH).clamp(1, u32::MAX - 1);
    // rust: let half = format!("{stem}_blink2");
    // rust: Self {
    // rust: shut: name(&format!("{stem}_blink")),
    // rust: half: root
    // rust: .join(format!("{half}.png"))
    // rust: .is_file()
    // rust: .then(|| name(&half)),
    // rust: length,
    // rust: frequency: number("blinkFrequency", FREQUENCY).max(length + 1),
}
}

    /// The frame an entity shows `tick` ticks into its life: `None` with its eyes open. `phase`
    /// spreads entities' blinks apart.
pub fn frame(self: *Self, tick: u32, phase: u32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let t = (u64::from(tick) + u64::from(phase)) % u64::from(self.frequency);
    // rust: let t = t as u32;
    // rust: if t >= self.length {
    // rust: return None;
}
    // rust: match &self.half {
    // rust: Some(half) if self.length >= 3 && (t == 0 || t == self.length - 1) => Some(half),
    // rust: _ => Some(&self.shut),
}
}
}

    // rust: mod tests {
//     use super::*;

pub fn pack(name: []const u8, files: *[([]const u8) void {
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-blink-{name}-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: for (path, text) in files {
    // rust: let path = root.join(path);
    // rust: fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: fs::write(path, text).unwrap();
}
    // rust: let b = Blinks::scan(&root, &RandomTextures::scan(&root));
    // rust: (root, b)
}

pub const ENTITY: []const u8 = "assets/minecraft/textures/entity";
pub const RANDOM: []const u8 = "assets/minecraft/optifine/random/entity";

pub fn frames_and_timing() void {
}
    // rust: let (root, b) = pack(
    // rust: "frames",
    // rust: &[
    // rust: (&format!("{ENTITY}/creeper/creeper.png"), ""),
    // rust: (&format!("{ENTITY}/creeper/creeper_blink.png"), ""),
    // rust: (&format!("{ENTITY}/creeper/creeper_blink2.png"), ""),
    // rust: (
    // rust: &format!("{ENTITY}/creeper/creeper_blink.properties"),
    // rust: "blinkLength=4\nblinkFrequency=100",
    // rust: ),
    // rust: (&format!("{ENTITY}/pig/pig.png"), ""),
    // rust: (&format!("{ENTITY}/pig/pig_blink.png"), ""),
                // No texture to blink over.
    // rust: (&format!("{ENTITY}/cow/cow_blink.png"), ""),
    // rust: ],
    // rust: );
    // rust: let creeper = b.get("entity/creeper/creeper").unwrap();
    // rust: assert_eq!((creeper.length, creeper.frequency), (4, 100));
        // Ticks 0-3 of every 100 blink: half, shut, shut, half.
    // rust: let frames: Vec<_> = (0..5).map(|t| creeper.frame(t, 0)).collect();
    // rust: let (half, shut) = (
    // rust: Some("entity/creeper/creeper_blink2"),
    // rust: Some("entity/creeper/creeper_blink"),
    // rust: );
    // rust: assert_eq!(frames, [half, shut, shut, half, None]);
    // rust: assert_eq!(creeper.frame(101, 0), shut);
        // A phase of 30 moves the blink to ticks 70-73.
    // rust: assert_eq!(creeper.frame(70, 30), half);
    // rust: assert_eq!(creeper.frame(0, 30), None);
    // rust: let pig = b.get("entity/pig/pig").unwrap();
    // rust: assert_eq!(
    // rust: (pig.length, pig.frequency, pig.half.as_deref()),
    // rust: (LENGTH, FREQUENCY, None)
    // rust: );
    // rust: assert_eq!(pig.frame(0, 0), Some("entity/pig/pig_blink"));
    // rust: assert!(b.get("entity/cow/cow").is_none());
    // rust: let _ = fs::remove_dir_all(root);
}

pub fn a_variant_blinks_with_its_own_frames() void {
}
    // rust: let (root, b) = pack(
    // rust: "variant",
    // rust: &[
    // rust: (&format!("{RANDOM}/zombie/zombie3.png"), ""),
    // rust: (&format!("{RANDOM}/zombie/zombie3_blink.png"), ""),
    // rust: (
    // rust: &format!("{RANDOM}/zombie/zombie3_blink.properties"),
    // rust: "blinkLength=0\nblinkFrequency=0",
    // rust: ),
    // rust: ],
    // rust: );
    // rust: let variant = "minecraft:optifine/random/entity/zombie/zombie3";
    // rust: let blink = b.get(variant).unwrap();
    // rust: assert_eq!(blink.shut, format!("{variant}_blink"));
        // Out-of-range values: at least a tick, every other tick.
    // rust: assert_eq!((blink.length, blink.frequency), (1, 2));
    // rust: assert_eq!(
    // rust: b.files().collect::<Vec<_>>(),
    // rust: [(
    // rust: "assets/minecraft/optifine/random/entity/zombie/zombie3_blink.png",
    // rust: format!("{variant}_blink").as_str()
    // rust: )]
    // rust: );
    // rust: let _ = fs::remove_dir_all(root);
}

pub fn a_huge_blink_length_still_opens_the_eyes() void {
}
    // rust: let (root, b) = pack(
    // rust: "huge",
    // rust: &[
    // rust: (&format!("{ENTITY}/pig/pig.png"), ""),
    // rust: (&format!("{ENTITY}/pig/pig_blink.png"), ""),
    // rust: (
    // rust: &format!("{ENTITY}/pig/pig_blink.properties"),
    // rust: "blinkLength=4294967295",
    // rust: ),
    // rust: ],
    // rust: );
    // rust: let pig = b.get("entity/pig/pig").unwrap();
    // rust: assert_eq!((pig.length, pig.frequency), (u32::MAX - 1, u32::MAX));
    // rust: assert_eq!(pig.frame(u32::MAX - 1, 0), None, "the one open tick");
    // rust: let _ = fs::remove_dir_all(root);
}
}
