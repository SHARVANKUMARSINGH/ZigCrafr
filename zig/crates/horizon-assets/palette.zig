//! Transpiled from Horizon Rust crate
//! Module: horizon-assets_palette
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `PalettedPermutations` atlas sources: sprites such as
//! `trims/items/boots_trim_quartz` are the base texture with its colours
//! swapped through a palette pair (`PaletteMapping`), not files of their own.
// use serde_json::Value;
// use std::collections::BTreeMap;

/// One `minecraft:paletted_permutations` source of an atlas definition.
pub const PalettedPermutations = struct {
    /// Base sprite names (`minecraft:trims/items/boots_trim`).
    textures: std.ArrayList([]const u8),
    /// The key palette (`minecraft:trim_base`).
    palette_key: []const u8,
    /// Suffix to target palette (`quartz` → `minecraft:trim/quartz`).
    permutations: BTreeMap<[]const u8,
    separator: []const u8,
};

/// A permuted sprite: its base texture and the palette pair to apply.
pub const Permutation = struct {
    base: *'a str,
    palette_key: *'a str,
    palette: *'a str,
};

pub fn qualified(id: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if id.contains(':') {
    // rust: id.to_owned()
    // rust: } else {
    // rust: format!("minecraft:{id}")
}
}

    // rust: impl PalettedPermutations {
    /// The `paletted_permutations` sources of an atlas JSON (`atlases/items.json`).
pub fn from_atlas(atlas: []const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Ok(json) = serde_json::from_str::<Value>(atlas) else {
    // rust: return Vec::new();
}
    // rust: let sources = json
    // rust: .get("sources")
    // rust: .and_then(Value::as_array)
    // rust: .cloned()
    // rust: .unwrap_or_default();
    // rust: sources
    // rust: .iter()
    // rust: .filter(|s| {
    // rust: s.get("type")
    // rust: .and_then(Value::as_str)
    // rust: .map(qualified)
    // rust: .as_deref()
    // rust: == Some("minecraft:paletted_permutations")
    // rust: })
    // rust: .filter_map(|s| {
    // rust: Some(Self {
    // rust: textures: s
    // rust: .get("textures")?
    // rust: .as_array()?
    // rust: .iter()
    // rust: .filter_map(Value::as_str)
    // rust: .map(qualified)
    // rust: .collect(),
    // rust: palette_key: qualified(s.get("palette_key")?.as_str()?),
    // rust: permutations: s
    // rust: .get("permutations")?
    // rust: .as_object()?
    // rust: .iter()
    // rust: .filter_map(|(k, v)| Some((k.clone(), qualified(v.as_str()?))))
    // rust: .collect(),
    // rust: separator: s
    // rust: .get("separator")
    // rust: .and_then(Value::as_str)
    // rust: .unwrap_or("_")
    // rust: .to_owned(),
    // rust: })
    // rust: })
    // rust: .collect()
}
    /// The permutation that produces `sprite` (`withSuffix(separator + key)`).
pub fn find(self: *Self, sprite: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let sprite = qualified(sprite);
    // rust: self.textures.iter().find_map(|base| {
    // rust: let suffix = sprite
    // rust: .strip_prefix(base.as_str())?
    // rust: .strip_prefix(self.separator.as_str())?;
    // rust: Some(Permutation {
    // rust: base,
    // rust: palette_key: &self.palette_key,
    // rust: palette: self.permutations.get(suffix)?,
    // rust: })
    // rust: })
}
}

/// `PaletteMapping.create(key, target).apply` over ARGB pixels; the palettes
/// are the pixels of their images in reading order (`Palette.from`).
pub fn apply_palette(pixels: *mut [u32], key: *[u32], target: *[u32]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if key.len() != target.len() {
    // rust: return None;
}
    // rust: let mut map = BTreeMap::new();
    // rust: for (&k, &t) in key.iter().zip(target) {
    // rust: if k >> 24 != 0 {
    // rust: map.insert(k | 0xFF00_0000, t);
}
}
    // rust: for pixel in pixels {
    // rust: let alpha = *pixel >> 24;
    // rust: if alpha == 0 {
    // rust: continue;
}
    // rust: let rgb = *pixel | 0xFF00_0000;
    // rust: let target = map.get(&rgb).copied().unwrap_or(rgb);
    // rust: *pixel = (alpha * (target >> 24) / 255) << 24 | target & 0x00FF_FFFF;
}
    // rust: Some(())
}

    // rust: mod tests {
//     use super::*;
pub fn finds_trim_permutations_and_maps_colours() void {
}
    // rust: let atlas = r#"{"sources":[{"type":"minecraft:paletted_permutations","palette_key":"minecraft:trim_base",
    // rust: "permutations":{"quartz":"minecraft:trim/quartz"},"textures":["minecraft:trims/items/boots_trim"]}]}"#;
    // rust: let sources = PalettedPermutations::from_atlas(atlas);
    // rust: let p = sources[0]
    // rust: .find("minecraft:trims/items/boots_trim_quartz")
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: (p.base, p.palette),
    // rust: ("minecraft:trims/items/boots_trim", "minecraft:trim/quartz")
    // rust: );
    // rust: assert!(
    // rust: sources[0]
    // rust: .find("minecraft:trims/items/boots_trim_gold")
    // rust: .is_none()
    // rust: );
    // rust: let mut pixels = [0xFF11_2233, 0x8011_2233, 0x0011_2233, 0xFF44_5566];
    // rust: apply_palette(&mut pixels, &[0xFF11_2233], &[0xFFAA_BBCC]).unwrap();
    // rust: assert_eq!(pixels, [0xFFAA_BBCC, 0x80AA_BBCC, 0x0011_2233, 0xFF44_5566]);
}
}
