//! Transpiled from Horizon Rust crate
package horizon_client_banner

import "core:fmt"
import "core:mem"
import "core:math"

// Banner patterns: the `banner_pattern` registry and its tags, the
// `banner_patterns` layers carried by banner items, shields and placed
// banners, and the loom rules of `LoomMenu` (selectable patterns, the
// six-layer limit and the result stack).
// use crate::{block_entity_render::DYES, items::ItemStack, items::Items};
// use serde_json::Value;
// use std::{collections::HashMap, fs, path::Path, sync::Arc};

    // rust: pub use horizon_items::banner_layer::{BannerLayer, layers_from_nbt, layers_to_nbt};

// Layers a loom may stack on a banner (`LoomMenu`'s `hasMaxPatterns`).
MAX_LAYERS :: 6

// One `banner_pattern` registry entry.
Pattern :: struct {
    id: ^str,
    // `asset_id` path, the texture under `entity/banner` and `entity/shield`.
    asset: string,
    translation_key: string,
}

// The pattern registry, its tags and the item components the loom reads.
Banners :: struct {
    patterns: [dynamic]Pattern,
    // `#minecraft:no_item_required`, in tag order.
    no_item_required: [dynamic]^str,
    // Item -> `dye` component.
    dyes: HashMap<^str,
    // Item -> `provides_banner_patterns`, in tag order.
    provided: HashMap<^str,
}

read_tag :: proc(root: ^Path, name: string, depth: u32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: if depth > 8 {
    // rust: return Vec::new();
}
    // rust: let path = root.join(format!(
    // rust: "data/minecraft/tags/banner_pattern/{}.json",
    // rust: name.trim_start_matches("minecraft:")
    // rust: ));
    // rust: let Some(v) = fs::read(path)
    // rust: .ok()
    // rust: .and_then(|b| serde_json::from_slice::<Value>(&b).ok())
    // rust: else {
    // rust: return Vec::new();
}
    // rust: let mut out = Vec::new();
    // rust: for value in v["values"].as_array().into_iter().flatten() {
    // rust: let Some(s) = value.as_str().or_else(|| value["id"].as_str()) else {
    // rust: continue;
}
    // rust: match s.strip_prefix('#') {
    // rust: Some(tag) => out.extend(read_tag(root, tag, depth + 1)),
    // rust: None => out.push(Arc::from(s)),
}
}
    // rust: out
}

    // rust: impl Banners {
load :: proc(root: ^Path) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut banners = Self::default();
    // rust: let mut files: Vec<_> = fs::read_dir(root.join("data/minecraft/banner_pattern"))
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .flatten()
    // rust: .map(|e| e.path())
    // rust: .filter(|p| p.extension().is_some_and(|e| e == "json"))
    // rust: .collect();
    // rust: files.sort();
    // rust: for path in files {
    // rust: let Some(stem) = path.file_stem().and_then(|s| s.to_str()) else {
    // rust: continue;
}
    // rust: let Some(v) = fs::read(&path)
    // rust: .ok()
    // rust: .and_then(|b| serde_json::from_slice::<Value>(&b).ok())
    // rust: else {
    // rust: continue;
}
    // rust: let asset = v["asset_id"]
    // rust: .as_str()
    // rust: .unwrap_or(stem)
    // rust: .trim_start_matches("minecraft:")
    // rust: .to_owned();
    // rust: banners.patterns.push(Pattern {
    // rust: id: Arc::from(format!("minecraft:{stem}").as_str()),
    // rust: asset,
    // rust: translation_key: v["translation_key"].as_str().unwrap_or_default().to_owned(),
    // rust: });
}
    // rust: banners.no_item_required = read_tag(root, "no_item_required", 0);
    // rust: if let Ok(raw) = horizon_world::item_defaults::read(root) {
    // rust: for (item, c) in raw {
    // rust: let id: Arc<str> = Arc::from(item.as_str());
    // rust: if let Some(dye) = c["minecraft:dye"].as_str() {
    // rust: banners.dyes.insert(id.clone(), Arc::from(dye));
}
    // rust: match &c["minecraft:provides_banner_patterns"] {
    // rust: Value::String(tag) if tag.starts_with('#') => {
    // rust: banners.provided.insert(id, read_tag(root, &tag[1..], 0));
}
    // rust: Value::String(single) => {
    // rust: banners
    // rust: .provided
    // rust: .insert(id, vec![Arc::from(single.as_str())]);
}
    // rust: _ => {}
}
}
}
    // rust: banners
}
pattern :: proc(self: ^Self, id: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.patterns.iter().find(|p| &*p.id == id)
}
    // `Sheets.getBannerSprite` texture name of a pattern.
banner_texture :: proc(self: ^Self, id: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match self.pattern(id) {
    // rust: Some(p) => format!("entity/banner/{}", p.asset),
    // rust: None => format!("entity/banner/{}", id.trim_start_matches("minecraft:")),
}
}
    // `Sheets.getShieldSprite` texture name of a pattern.
shield_texture :: proc(self: ^Self, id: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match self.pattern(id) {
    // rust: Some(p) => format!("entity/shield/{}", p.asset),
    // rust: None => format!("entity/shield/{}", id.trim_start_matches("minecraft:")),
}
}
    // `BannerPatternLayers.Layer.description` translation key.
layer_key :: proc(self: ^Self, layer: ^BannerLayer) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let base = self.pattern(&layer.pattern).map_or_else(
    // rust: || {
    // rust: format!(
    // rust: "block.minecraft.banner.{}",
    // rust: layer.pattern.trim_start_matches("minecraft:")
    // rust: )
    // rust: },
    // rust: |p| p.translation_key.clone(),
    // rust: );
    // rust: format!("{base}.{}", layer.color)
}
    // `LoomMenu.isDyeItem`: the dye colour of a loom dye.
loom_dye :: proc(self: ^Self, items: ^Items, stack: ^ItemStack) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let tagged = items
    // rust: .item_tags
    // rust: .get("minecraft:loom_dyes")
    // rust: .is_some_and(|t| t.contains(&*stack.item));
    // rust: tagged
    // rust: .then(|| self.dyes.get(&stack.item).cloned())
    // rust: .flatten()
}
    // `LoomMenu.isPatternItem`.
is_pattern_item :: proc(self: ^Self, items: ^Items, stack: ^ItemStack) -> b {
    // Ported from Horizon
    return {}
}
    // rust: items
    // rust: .item_tags
    // rust: .get("minecraft:loom_patterns")
    // rust: .is_some_and(|t| t.contains(&*stack.item))
    // rust: && self.provided.contains_key(&stack.item)
}
    // `LoomMenu.getSelectablePatterns`.
selectable :: proc(self: ^Self, pattern_item: Maybe(^ItemStack)) -> V {
    // Ported from Horizon
    return {}
}
    // rust: match pattern_item {
    // rust: None => self.no_item_required.clone(),
    // rust: Some(stack) => self.provided.get(&stack.item).cloned().unwrap_or_default(),
}
}
}

// `BannerItem`: a banner's dye colour from its item id.
banner_color :: proc(item: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let name = item.strip_prefix("minecraft:")?.strip_suffix("_banner")?;
    // rust: DYES.iter().map(|d| d.0).find(|d| *d == name)
}
// `DyeColor.getTextureDiffuseColor` (RGB) by dye name.
dye_rgb :: proc(name: string) -> u {
    // Ported from Horizon
    return {}
}
    // rust: DYES.iter().find(|d| d.0 == name).map_or(0xFFFFFF, |d| d.1)
}
// The layers of a banner or shield stack.
layers :: proc(stack: ^ItemStack) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: stack.data().map_or(&[], |d| &d.banner_patterns)
}
// The ominous banner's component patch hides its pattern tooltip.
tooltip_layers :: proc(stack: ^ItemStack) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: if stack.data().is_some_and(|d| d.ominous_banner) {
    // rust: &[]
    // rust: } else {
    // rust: layers(stack)
}
}
// `LoomMenu.setupResultSlot`: one banner with the pattern added in the dye colour.
loom_result :: proc(banner: ^ItemStack, dye: string, pattern: string) -> I {
    // Ported from Horizon
    return {}
}
    // rust: let mut result = ItemStack {
    // rust: count: 1,
    // rust: ..banner.clone()
}
    // rust: result
    // rust: .data_mut()
    // rust: .banner_patterns
    // rust: .push(BannerLayer::new(pattern, dye));
    // rust: result
}
// Whether the banner already carries the loom's limit.
has_max_layers :: proc(banner: ^ItemStack) -> b {
    // Ported from Horizon
    return {}
}
    // rust: layers(banner).len() >= MAX_LAYERS
}

    // rust: mod tests {
//     use super::*;

banners :: proc() -> B {
    // Ported from Horizon
    return {}
}
    // rust: let mut b = Banners {
    // rust: no_item_required: vec![Arc::from("minecraft:stripe_top")],
    // rust: ..Default::default()
}
    // rust: b.provided.insert(
    // rust: Arc::from("minecraft:flower_banner_pattern"),
    // rust: vec![Arc::from("minecraft:flower")],
    // rust: );
    // rust: b
}
selectable_follow_the_pattern_item :: proc() {
}
    // rust: let b = banners();
    // rust: assert_eq!(b.selectable(None).len(), 1);
    // rust: let item = ItemStack::new("minecraft:flower_banner_pattern", 1);
    // rust: assert_eq!(&*b.selectable(Some(&item))[0], "minecraft:flower");
}
banner_colour_comes_from_the_item :: proc() {
}
    // rust: assert_eq!(
    // rust: banner_color("minecraft:light_gray_banner"),
    // rust: Some("light_gray")
    // rust: );
    // rust: assert_eq!(banner_color("minecraft:white_banner"), Some("white"));
    // rust: assert_eq!(banner_color("minecraft:white_wool"), None);
}
loom_adds_a_layer_up_to_the_limit :: proc() {
}
    // rust: let mut banner = ItemStack::new("minecraft:white_banner", 3);
    // rust: for i in 0..MAX_LAYERS {
    // rust: assert!(!has_max_layers(&banner));
    // rust: banner = loom_result(&banner, "red", "minecraft:cross");
    // rust: assert_eq!(banner.count, 1);
    // rust: assert_eq!(layers(&banner).len(), i + 1);
}
    // rust: assert!(has_max_layers(&banner));
}
ominous_banner_hides_tooltip_layers_but_keeps_its_patterns :: proc() {
}
    // rust: let mut banner = crate::mobs::raider::ominous_banner();
    // rust: (banner.damage, banner.extra) = crate::item_data::decode_components(
    // rust: crate::item_data::encode_components(&banner).as_ref(),
    // rust: );
    // rust: assert_eq!(
    // rust: layers(&banner).len(),
    // rust: crate::item_data::OMINOUS_LAYERS.len()
    // rust: );
    // rust: assert!(tooltip_layers(&banner).is_empty());
    // rust: banner.data_mut().custom_name =
    // rust: Some(horizon_world::nbt::Tag::String("Captain's Standard".into()));
    // rust: assert!(tooltip_layers(&banner).is_empty());
    // rust: banner.data_mut().ominous_banner = false;
    // rust: assert_eq!(tooltip_layers(&banner), layers(&banner));
    // rust: assert!(!tooltip_layers(&banner).is_empty());
}

layers_round_trip_through_nbt :: proc() {
}
    // rust: let l = vec![
    // rust: BannerLayer::new("minecraft:flower", "red"),
    // rust: BannerLayer::new("minecraft:border", "black"),
    // rust: ];
    // rust: assert_eq!(layers_from_nbt(Some(&layers_to_nbt(&l))), l);
}
}
