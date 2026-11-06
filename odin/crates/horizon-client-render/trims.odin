//! Transpiled from Horizon Rust crate
package horizon_client_render_trims

import "core:fmt"
import "core:mem"
import "core:math"

// Armour trims on worn armour: `EquipmentLayerRenderer`'s trim layer. A
// trim's texture is `textures/trims/entity/<layer>/<pattern>.png` recoloured
// by `PalettedTextureManager`: every pixel whose colour is in the texture's
// base palette (its `palette` metadata section, `trim_base`) takes the colour
// at the same index of the material's palette (`textures/palettes/trim/*`),
// unless the equipment asset's `trim_overrides` pick another texture or
// palette (iron armour with an iron trim uses `trim/iron_darker`).
// use horizon_assets::palette::apply_palette;
// use serde_json::Value;
// use std::{collections::HashMap, fs, path::Path};

// An RGBA image: width, height, pixels.
    // rust: pub type Image = (u32, u32, Vec<u8>);

// `minecraft:` added to an identifier without a namespace.
qualified :: proc(id: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: if id.contains(':') {
    // rust: id.to_owned()
    // rust: } else {
    // rust: format!("minecraft:{id}")
}
}

// `assets/<namespace>/<folder>/<path><suffix>` of an identifier.
asset_path :: proc(root: ^Path, folder: string, id: string, suffix: string) -> s {
    // Ported from Horizon
    return {}
}
    // rust: let id = qualified(id);
    // rust: let (namespace, path) = id.split_once(':').unwrap_or(("minecraft", &id));
    // rust: root.join("assets")
    // rust: .join(namespace)
    // rust: .join(folder)
    // rust: .join(format!("{path}{suffix}"))
}

// `EquipmentClientInfo.TrimOverride`: when the trim matches (`when`'s
// material and pattern, each optional), use `texture` instead of the
// pattern's asset id and `palette` (none when absent) as the palette.
TrimOverride :: struct {
    material: Maybe(string),
    pattern: Maybe(string),
    texture: Maybe(string),
    palette: Maybe(string),
}
    // rust: impl TrimOverride {
    // An equipment asset's `trim_overrides` list.
list :: proc(equipment: ^Value) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let Some(list) = equipment.get("trim_overrides").and_then(Value::as_array) else {
    // rust: return Vec::new();
}
    // rust: let id = |v: &Value, key: &str| v.get(key).and_then(Value::as_str).map(qualified);
    // rust: list.iter()
    // rust: .filter_map(|o| {
    // rust: let when = o.get("when")?;
    // rust: Some(Self {
    // rust: material: id(when, "material"),
    // rust: pattern: id(when, "pattern"),
    // rust: texture: id(o, "texture"),
    // rust: palette: id(o, "palette"),
    // rust: })
    // rust: })
    // rust: .collect()
}
    // `TrimPredicate.matches`.
matches :: proc(self: ^Self, material: string, pattern: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.material.as_deref().is_none_or(|m| m == material)
    // rust: && self.pattern.as_deref().is_none_or(|p| p == pattern)
}
}

// The `trim_pattern` (asset id) and `trim_material` (palette id) registries.
TrimRegistry :: struct {
    patterns: HashMap<string,
    materials: HashMap<string,
}
    // rust: impl TrimRegistry {
    // Every `data/<namespace>/trim_pattern` and `trim_material` entry.
load :: proc(root: ^Path) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Self::default();
    // rust: let Ok(namespaces) = fs::read_dir(root.join("data")) else {
    // rust: return out;
}
    // rust: for ns in namespaces.flatten() {
    // rust: let namespace = ns.file_name().to_string_lossy().into_owned();
    // rust: for (folder, key, map) in [
    // rust: ("trim_pattern", "asset_id", &mut out.patterns),
    // rust: ("trim_material", "palette_id", &mut out.materials),
    // rust: ] {
    // rust: let Ok(files) = fs::read_dir(ns.path().join(folder)) else {
    // rust: continue;
}
    // rust: for f in files.flatten() {
    // rust: let path = f.path();
    // rust: if path.extension().is_none_or(|e| e != "json") {
    // rust: continue;
}
    // rust: let Some(value) = fs::read(&path)
    // rust: .ok()
    // rust: .and_then(|b| serde_json::from_slice::<Value>(&b).ok())
    // rust: else {
    // rust: continue;
}
    // rust: if let Some(v) = value.get(key).and_then(Value::as_str) {
    // rust: let name = path.file_stem().unwrap_or_default().to_string_lossy();
    // rust: map.insert(format!("{namespace}:{name}"), qualified(v));
}
}
}
}
    // rust: out
}
of :: proc(patterns: ^[(string) {
}
    // rust: let map = |l: &[(&str, &str)]| {
    // rust: l.iter()
    // rust: .map(|(k, v)| (k.to_string(), v.to_string()))
    // rust: .collect()
}
    // rust: Self {
    // rust: patterns: map(patterns),
    // rust: materials: map(materials),
}
}
}

// The texture and palette of one trim layer.
TrimTexture :: struct {
    // `<namespace>:trims/entity/<layer>/<path>`, under `textures/`.
    texture: string,
    // The target palette under `textures/palettes/`; none draws the
    // texture's own colours.
    palette: Maybe(string),
}
    // rust: impl TrimTexture {
    // `TrimTextureKey.getOrPrepareTexture`: the trim (`material`,
    // `pattern` registry ids) on the `layer` (`humanoid`,
    // `humanoid_leggings`...) of an equipment asset with `overrides`.
    // rust: pub fn resolve(
    // rust: registry: &TrimRegistry,
    // rust: overrides: &[TrimOverride],
    // rust: material: &str,
    // rust: pattern: &str,
    // rust: layer: &str,
    // rust: ) -> Option<Self> {
    // rust: let (material, pattern) = (qualified(material), qualified(pattern));
    // rust: let mut texture = registry.patterns.get(&pattern)?.clone();
    // rust: let mut palette = Some(registry.materials.get(&material)?.clone());
    // rust: if let Some(o) = overrides.iter().find(|o| o.matches(&material, &pattern)) {
    // rust: if let Some(t) = &o.texture {
    // rust: texture.clone_from(t);
}
    // rust: palette.clone_from(&o.palette);
}
    // rust: let (namespace, path) = texture.split_once(':')?;
    // rust: Some(Self {
    // rust: texture: format!("{namespace}:trims/entity/{layer}/{path}"),
    // rust: palette,
    // rust: })
}
    // The atlas sprite name the generated texture is stored under.
sprite :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!(
    // rust: "horizon/trim/{}/{}",
    // rust: self.texture,
    // rust: self.palette.as_deref().unwrap_or("-")
    // rust: )
}
    // `PalettedTextureManager.prepareSlot`: the texture with its base
    // palette's colours swapped for the target palette's (`PaletteMapping`;
    // unchanged when a palette is missing or the sizes differ). None when
    // the texture itself is missing.
generate :: proc(self: ^Self, root: ^Path) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let path = asset_path(root, "textures", &self.texture, ".png");
    // rust: let (w, h, pixels) = crate::hud::decode(&path).ok()?;
    // rust: let Some(palette) = &self.palette else {
    // rust: return Some((w, h, pixels));
}
    // rust: let base = horizon_core::prepared_files::read(&path.with_extension("png.mcmeta"))
    // rust: .ok()
    // rust: .and_then(|b| serde_json::from_slice::<Value>(&b).ok())
    // rust: .and_then(|m| {
    // rust: m.get("palette")?
    // rust: .get("base_palette")?
    // rust: .as_str()
    // rust: .map(str::to_owned)
    // rust: });
    // rust: let load = |id: &str| {
    // rust: crate::hud::decode(&asset_path(root, "textures/palettes", id, ".png"))
    // rust: .ok()
    // rust: .map(|(_, _, p)| argb(&p))
}
    // rust: let mut mapped = argb(&pixels);
    // rust: if let (Some(key), Some(target)) = (base.as_deref().and_then(load), load(palette)) {
            // Different sizes: PaletteMapping.NONE, the texture as it is.
    // rust: let _ = apply_palette(&mut mapped, &key, &target);
}
    // rust: let out = mapped
    // rust: .iter()
    // rust: .flat_map(|p| {
    // rust: let [a, r, g, b] = p.to_be_bytes();
    // rust: [r, g, b, a]
    // rust: })
    // rust: .collect();
    // rust: Some((w, h, out))
}
}

argb :: proc(rgba: []u8) -> V {
    // Ported from Horizon
    return {}
}
    // rust: rgba.as_chunks::<4>()
    // rust: .0
    // rust: .iter()
    // rust: .map(|p| u32::from_be_bytes([p[3], p[0], p[1], p[2]]))
    // rust: .collect()
}

// The largest trim texture of the resources (the size of the atlas's trim
// slots), at least vanilla's 64x32.
slot_size :: proc(root: ^Path) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let mut size = (64, 32);
    // rust: let Ok(namespaces) = fs::read_dir(root.join("assets")) else {
    // rust: return size;
}
    // rust: for ns in namespaces.flatten() {
    // rust: let Ok(layers) = fs::read_dir(ns.path().join("textures/trims/entity")) else {
    // rust: continue;
}
    // rust: for layer in layers.flatten() {
    // rust: for f in fs::read_dir(layer.path()).into_iter().flatten().flatten() {
    // rust: let path = f.path();
    // rust: if path.extension().is_some_and(|e| e == "png")
    // rust: && let Some((w, h)) = png_size(&path)
    // rust: {
    // rust: size = (size.0.max(w.min(512)), size.1.max(h.min(512)));
}
}
}
}
    // rust: size
}

// The width and height in a PNG's IHDR chunk.
png_size :: proc(path: ^Path) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let head: [u8; 24] = horizon_core::prepared_files::read_head(path, 24)
    // rust: .ok()?
    // rust: .try_into()
    // rust: .ok()?;
    // rust: let be = |i: usize| u32::from_be_bytes(head[i..i + 4].try_into().unwrap());
    // rust: (&head[12..16] == b"IHDR").then(|| (be(16), be(20)))
}

    // rust: mod tests {
//     use super::*;

registry :: proc() -> T {
    // Ported from Horizon
    return {}
}
    // rust: TrimRegistry::of(
    // rust: &[("minecraft:coast", "minecraft:coast")],
    // rust: &[
    // rust: ("minecraft:iron", "minecraft:trim/iron"),
    // rust: ("minecraft:gold", "minecraft:trim/gold"),
    // rust: ],
    // rust: )
}

material_palette_and_layer_folder :: proc() {
}
    // rust: let t = TrimTexture::resolve(
    // rust: &registry(),
    // rust: &[],
    // rust: "minecraft:gold",
    // rust: "minecraft:coast",
    // rust: "humanoid_leggings",
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(t.texture, "minecraft:trims/entity/humanoid_leggings/coast");
    // rust: assert_eq!(t.palette.as_deref(), Some("minecraft:trim/gold"));
        // Unknown registry entries draw nothing.
    // rust: assert!(
    // rust: TrimTexture::resolve(
    // rust: &registry(),
    // rust: &[],
    // rust: "minecraft:wood",
    // rust: "minecraft:coast",
    // rust: "humanoid"
    // rust: )
    // rust: .is_none()
    // rust: );
}

equipment_overrides_pick_the_darker_palette :: proc() {
}
    // rust: let iron = serde_json::json!({"trim_overrides": [
    // rust: {"palette": "minecraft:trim/iron_darker", "when": {"material": "minecraft:iron"}},
    // rust: ]});
    // rust: let overrides = TrimOverride::list(&iron);
    // rust: let resolve =
    // rust: |m| TrimTexture::resolve(&registry(), &overrides, m, "coast", "humanoid").unwrap();
    // rust: assert_eq!(
    // rust: resolve("iron").palette.as_deref(),
    // rust: Some("minecraft:trim/iron_darker")
    // rust: );
    // rust: assert_eq!(
    // rust: resolve("gold").palette.as_deref(),
    // rust: Some("minecraft:trim/gold")
    // rust: );
        // An override without a palette leaves the texture's own colours.
    // rust: let plain = TrimOverride::list(&serde_json::json!({"trim_overrides": [
    // rust: {"texture": "minecraft:other", "when": {"pattern": "minecraft:coast"}},
    // rust: ]}));
    // rust: let t = TrimTexture::resolve(&registry(), &plain, "gold", "coast", "humanoid").unwrap();
    // rust: assert_eq!(t.texture, "minecraft:trims/entity/humanoid/other");
    // rust: assert_eq!(t.palette, None);
}

vanilla_trims_are_recoloured :: proc() {
}
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR")).join("../../.local/horizon-client/26.3");
    // rust: if !root.join("assets/minecraft/textures/trims").is_dir() {
    // rust: return;
}
    // rust: let registry = TrimRegistry::load(&root);
    // rust: let t = TrimTexture::resolve(
    // rust: &registry,
    // rust: &[],
    // rust: "minecraft:gold",
    // rust: "minecraft:coast",
    // rust: "humanoid",
    // rust: )
    // rust: .unwrap();
    // rust: let (w, h, gold) = t.generate(&root).unwrap();
    // rust: assert_eq!((w, h), (64, 32));
    // rust: let plain = TrimTexture {
    // rust: palette: None,
    // rust: ..t.clone()
}
    // rust: let (_, _, grey) = plain.generate(&root).unwrap();
        // Every opaque pixel of the grey pattern takes a gold palette colour.
    // rust: let gold_palette = argb(
    // rust: &crate::hud::decode(&root.join("assets/minecraft/textures/palettes/trim/gold.png"))
    // rust: .unwrap()
    // rust: .2,
    // rust: );
    // rust: let mut opaque = 0;
    // rust: for (g, c) in grey.chunks(4).zip(gold.chunks(4)) {
    // rust: if g[3] != 0 {
    // rust: opaque += 1;
    // rust: let c = u32::from_be_bytes([0xFF, c[0], c[1], c[2]]);
    // rust: assert!(gold_palette.contains(&c), "{c:08x}");
}
}
    // rust: assert!(opaque > 0);
    // rust: assert_eq!(slot_size(&root), (64, 32));
}
}
