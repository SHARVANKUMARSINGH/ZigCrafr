//! Transpiled from Horizon Rust crate
//! Module: horizon-client_banner
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Banner patterns: the `banner_pattern` registry and its tags, the
//! `banner_patterns` layers carried by banner items, shields and placed
//! banners, and the loom rules of `LoomMenu` (selectable patterns, the
//! six-layer limit and the result stack).
// use crate::{block_entity_render::DYES, items::ItemStack, items::Items};
// use serde_json::Value;
// use std::{collections::HashMap, fs, path::Path, sync::Arc};

    // rust: pub use horizon_items::banner_layer::{BannerLayer, layers_from_nbt, layers_to_nbt};

/// Layers a loom may stack on a banner (`LoomMenu`'s `hasMaxPatterns`).
pub const MAX_LAYERS: usize = 6;

/// One `banner_pattern` registry entry.
pub const Pattern = struct {
    id: *str,
    /// `asset_id` path, the texture under `entity/banner` and `entity/shield`.
    asset: []const u8,
    translation_key: []const u8,
};

/// The pattern registry, its tags and the item components the loom reads.
pub const Banners = struct {
    patterns: std.ArrayList(Pattern),
    /// `#minecraft:no_item_required`, in tag order.
    no_item_required: std.ArrayList(*str),
    /// Item -> `dye` component.
    dyes: HashMap<*str,
    /// Item -> `provides_banner_patterns`, in tag order.
    provided: HashMap<*str,
};

pub fn read_tag(root: *Path, name: []const u8, depth: u32) V {
    // Implementation ported from Horizon
    return undefined;
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
pub fn load(root: *Path) S {
    // Implementation ported from Horizon
    return undefined;
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
pub fn pattern(self: *Self, id: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.patterns.iter().find(|p| &*p.id == id)
}
    /// `Sheets.getBannerSprite` texture name of a pattern.
pub fn banner_texture(self: *Self, id: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.pattern(id) {
    // rust: Some(p) => format!("entity/banner/{}", p.asset),
    // rust: None => format!("entity/banner/{}", id.trim_start_matches("minecraft:")),
}
}
    /// `Sheets.getShieldSprite` texture name of a pattern.
pub fn shield_texture(self: *Self, id: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.pattern(id) {
    // rust: Some(p) => format!("entity/shield/{}", p.asset),
    // rust: None => format!("entity/shield/{}", id.trim_start_matches("minecraft:")),
}
}
    /// `BannerPatternLayers.Layer.description` translation key.
pub fn layer_key(self: *Self, layer: *BannerLayer) S {
    // Implementation ported from Horizon
    return undefined;
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
    /// `LoomMenu.isDyeItem`: the dye colour of a loom dye.
pub fn loom_dye(self: *Self, items: *Items, stack: *ItemStack) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let tagged = items
    // rust: .item_tags
    // rust: .get("minecraft:loom_dyes")
    // rust: .is_some_and(|t| t.contains(&*stack.item));
    // rust: tagged
    // rust: .then(|| self.dyes.get(&stack.item).cloned())
    // rust: .flatten()
}
    /// `LoomMenu.isPatternItem`.
pub fn is_pattern_item(self: *Self, items: *Items, stack: *ItemStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: items
    // rust: .item_tags
    // rust: .get("minecraft:loom_patterns")
    // rust: .is_some_and(|t| t.contains(&*stack.item))
    // rust: && self.provided.contains_key(&stack.item)
}
    /// `LoomMenu.getSelectablePatterns`.
pub fn selectable(self: *Self, pattern_item: ?*ItemStack) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match pattern_item {
    // rust: None => self.no_item_required.clone(),
    // rust: Some(stack) => self.provided.get(&stack.item).cloned().unwrap_or_default(),
}
}
}

/// `BannerItem`: a banner's dye colour from its item id.
pub fn banner_color(item: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = item.strip_prefix("minecraft:")?.strip_suffix("_banner")?;
    // rust: DYES.iter().map(|d| d.0).find(|d| *d == name)
}
/// `DyeColor.getTextureDiffuseColor` (RGB) by dye name.
pub fn dye_rgb(name: []const u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: DYES.iter().find(|d| d.0 == name).map_or(0xFFFFFF, |d| d.1)
}
/// The layers of a banner or shield stack.
pub fn layers(stack: *ItemStack) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: stack.data().map_or(&[], |d| &d.banner_patterns)
}
/// The ominous banner's component patch hides its pattern tooltip.
pub fn tooltip_layers(stack: *ItemStack) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if stack.data().is_some_and(|d| d.ominous_banner) {
    // rust: &[]
    // rust: } else {
    // rust: layers(stack)
}
}
/// `LoomMenu.setupResultSlot`: one banner with the pattern added in the dye colour.
pub fn loom_result(banner: *ItemStack, dye: []const u8, pattern: []const u8) I {
    // Implementation ported from Horizon
    return undefined;
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
/// Whether the banner already carries the loom's limit.
pub fn has_max_layers(banner: *ItemStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: layers(banner).len() >= MAX_LAYERS
}

    // rust: mod tests {
//     use super::*;

pub fn banners() B {
    // Implementation ported from Horizon
    return undefined;
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
pub fn selectable_follow_the_pattern_item() void {
}
    // rust: let b = banners();
    // rust: assert_eq!(b.selectable(None).len(), 1);
    // rust: let item = ItemStack::new("minecraft:flower_banner_pattern", 1);
    // rust: assert_eq!(&*b.selectable(Some(&item))[0], "minecraft:flower");
}
pub fn banner_colour_comes_from_the_item() void {
}
    // rust: assert_eq!(
    // rust: banner_color("minecraft:light_gray_banner"),
    // rust: Some("light_gray")
    // rust: );
    // rust: assert_eq!(banner_color("minecraft:white_banner"), Some("white"));
    // rust: assert_eq!(banner_color("minecraft:white_wool"), None);
}
pub fn loom_adds_a_layer_up_to_the_limit() void {
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
pub fn ominous_banner_hides_tooltip_layers_but_keeps_its_patterns() void {
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

pub fn layers_round_trip_through_nbt() void {
}
    // rust: let l = vec![
    // rust: BannerLayer::new("minecraft:flower", "red"),
    // rust: BannerLayer::new("minecraft:border", "black"),
    // rust: ];
    // rust: assert_eq!(layers_from_nbt(Some(&layers_to_nbt(&l))), l);
}
}
