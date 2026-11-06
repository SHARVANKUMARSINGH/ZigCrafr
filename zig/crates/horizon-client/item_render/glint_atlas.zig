//! Transpiled from Horizon Rust crate
//! Module: horizon-client_glint_atlas
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Vanilla item-atlas coordinates for GUI glint; the HUD's unrelated packing cannot supply them.
// use crate::{atlas_sources, hud::Rect};
// use horizon_assets::animation::AnimationMetadata;
// use std::{collections::HashMap, path::Path};

    // rust: type Entry = (String, u32, u32);

/// `SpriteSourceList.list` and `SpriteResourceLoader.loadSprite` for the non-mipmapped ITEMS atlas.
    // rust: pub(super) fn load(
    // rust: root: &Path,
    // rust: padding: u32,
    // rust: maximum: u32,
    // rust: ) -> crate::Result<HashMap<String, Rect>> {
    // rust: let sources = atlas_sources::atlases(root);
    // rust: let sources = sources
    // rust: .get("minecraft:items")
    // rust: .map(Vec::as_slice)
    // rust: .unwrap_or(&[]);
    // rust: let textures = atlas_sources::list_textures(root);
    // rust: let decode = |name: &str, dir: &str| {
    // rust: crate::hud::decode(&atlas_sources::texture_path(root, name, dir)).ok()
}
    // rust: let mut entries = vec![("minecraft:missingno".into(), 16, 16)];
    // rust: let mut names = Vec::new();
    // rust: for (id, origin) in atlas_sources::list(sources, &textures) {
    // rust: names.push(id.clone());
    // rust: let dimensions = match &origin {
    // rust: atlas_sources::SpriteOrigin::File(texture) => (|| {
    // rust: let (w, h, _) = decode(texture, "textures")?;
    // rust: let path = atlas_sources::texture_path(root, texture, "textures")
    // rust: .with_extension("png.mcmeta");
    // rust: let metadata = horizon_core::prepared_files::read_to_string(&path)
    // rust: .ok()
    // rust: .map(|text| serde_json::from_str::<serde_json::Value>(&text))
    // rust: .transpose()
    // rust: .ok()?;
    // rust: if let Some(metadata) = &metadata {
    // rust: metadata.as_object()?;
    // rust: if let Some(texture) = metadata.get("texture") {
    // rust: texture_metadata(texture)?;
}
}
    // rust: let size = match metadata.as_ref().and_then(|v| v.get("animation")) {
    // rust: Some(animation) => AnimationMetadata::from_json(&animation.to_string())
    // rust: .ok()?
    // rust: .frame_size(w as i32, h as i32)
    // rust: .map(|x| x as u32),
    // rust: None => [w, h],
}
    // rust: (size[0] > 0
    // rust: && size[1] > 0
    // rust: && w.is_multiple_of(size[0])
    // rust: && h.is_multiple_of(size[1]))
    // rust: .then_some((size[0], size[1]))
    // rust: })(),
            // Generated sprites have empty resource metadata, so their whole image is one frame.
    // rust: _ => atlas_sources::generate(&origin, &decode).map(|(w, h, _)| (w, h)),
}
    // rust: if let Some((w, h)) = dimensions {
    // rust: entries.push((id, w, h));
}
}
    // rust: let mut sprites = stitch(&entries, padding, maximum).ok_or_else(|| {
    // rust: std::io::Error::other(format!(
    // rust: "item atlas does not fit texture limit {maximum} with padding {padding}"
    // rust: ))
    // rust: })?;
    // TextureAtlas.getSprite returns missingno for rejected or unplaced source sprites.
    // rust: if let Some(missing) = sprites.get("missingno").copied() {
    // rust: for name in names {
    // rust: sprites
    // rust: .entry(super::sprite_name(&name).to_owned())
    // rust: .or_insert(missing);
}
}
    // rust: Ok(sprites)
}

/// `TextureMetadataSection.CODEC`: invalid fields reject the sprite, even without mipmaps.
pub fn texture_metadata(section: *serde_json::Value) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let fields = section.as_object()?;
    // rust: for (name, value) in fields.iter().filter(|(_, value)| !value.is_null()) {
    // rust: let valid = match name.as_str() {
    // rust: "blur" | "clamp" => value.is_boolean(),
    // rust: "mipmap_strategy" => matches!(
    // rust: value.as_str(),
    // rust: Some("auto" | "mean" | "cutout" | "strict_cutout" | "dark_cutout")
    // rust: ),
    // rust: "alpha_cutoff_bias" => value.is_number(),
    // rust: _ => true,
}
    // rust: if !valid {
    // rust: return None;
}
}
    // rust: Some(())
}

pub const Region = struct {
    x: u32,
    y: u32,
    w: u32,
    h: u32,
    entry: ?usize,
    children: std.ArrayList(Region),
};
    // rust: impl Region {
pub fn new(x: u32, y: u32, w: u32, h: u32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: x,
    // rust: y,
    // rust: w,
    // rust: h,
    // rust: ..Self::default()
}
}
    /// `Stitcher.Region.add`: first fitting child, with vanilla's split order and no rotation.
pub fn add(self: *Self, index: usize, w: u32, h: u32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.entry.is_some() || w > self.w || h > self.h {
    // rust: return false;
}
    // rust: if w == self.w && h == self.h {
    // rust: self.entry = Some(index);
    // rust: return true;
}
    // rust: if self.children.is_empty() {
    // rust: let (dw, dh) = (self.w - w, self.h - h);
    // rust: self.children.push(Self::new(self.x, self.y, w, h));
    // rust: if dw > 0 && dh > 0 {
    // rust: if self.h.max(dw) >= self.w.max(dh) {
    // rust: self.children.push(Self::new(self.x, self.y + h, w, dh));
    // rust: self.children
    // rust: .push(Self::new(self.x + w, self.y, dw, self.h));
    // rust: } else {
    // rust: self.children.push(Self::new(self.x + w, self.y, dw, h));
    // rust: self.children
    // rust: .push(Self::new(self.x, self.y + h, self.w, dh));
}
    // rust: } else if dw == 0 {
    // rust: self.children.push(Self::new(self.x, self.y + h, w, dh));
    // rust: } else {
    // rust: self.children.push(Self::new(self.x + w, self.y, dw, h));
}
}
    // rust: self.children.iter_mut().any(|r| r.add(index, w, h))
}
    // rust: fn gather(
    // rust: &self,
    // rust: entries: &[Entry],
    // rust: size: [u32; 2],
    // rust: padding: u32,
    // rust: out: &mut HashMap<String, Rect>,
    // rust: ) {
    // rust: if let Some(i) = self.entry {
    // rust: let (name, w, h) = &entries[i];
    // rust: let (x, y) = (self.x + padding, self.y + padding);
    // rust: out.insert(
    // rust: super::sprite_name(name).to_owned(),
    // rust: Rect {
    // rust: u0: x as f32 / size[0] as f32,
    // rust: v0: y as f32 / size[1] as f32,
    // rust: u1: (x + w) as f32 / size[0] as f32,
    // rust: v1: (y + h) as f32 / size[1] as f32,
    // rust: w: *w,
    // rust: h: *h,
    // rust: },
    // rust: );
}
    // rust: for child in &self.children {
    // rust: child.gather(entries, size, padding, out);
}
}
}

/// `Stitcher.stitch/expand`: mip level zero, padding from the filtering option.
pub fn stitch(entries: *[Entry], padding: u32, maximum: u32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut order: Vec<_> = entries
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, (name, w, h))| {
    // rust: let (ns, path) = name.split_once(':').unwrap_or(("minecraft", name));
    // rust: (i, w + padding * 2, h + padding * 2, path, ns)
    // rust: })
    // rust: .collect();
    // rust: order.sort_by(|a, b| {
    // rust: b.2.cmp(&a.2)
    // rust: .then(b.1.cmp(&a.1))
    // rust: .then(a.3.cmp(b.3))
    // rust: .then(a.4.cmp(b.4))
    // rust: });
    // rust: let mut regions: Vec<Region> = Vec::new();
    // rust: let (mut width, mut height) = (0u32, 0u32);
    // rust: let pow2 = |x: u32| if x == 0 { 0 } else { x.next_power_of_two() };
    // rust: for (index, w, h, _, _) in order {
    // rust: if regions.iter_mut().any(|r| r.add(index, w, h)) {
    // rust: continue;
}
    // rust: let (next_w, next_h) = (pow2(width.checked_add(w)?), pow2(height.checked_add(h)?));
    // rust: let (can_w, can_h) = (next_w <= maximum, next_h <= maximum);
    // rust: if !can_w && !can_h {
    // rust: return None;
}
    // rust: let (grow_w, grow_h) = (
    // rust: can_w && pow2(width) != next_w,
    // rust: can_h && pow2(height) != next_h,
    // rust: );
    // rust: let horizontal = if grow_w != grow_h {
    // rust: grow_w
    // rust: } else {
    // rust: can_w && pow2(width) <= pow2(height)
}
    // rust: let mut region = if horizontal {
    // rust: if height == 0 {
    // rust: height = next_h;
}
    // rust: let r = Region::new(width, 0, next_w - width, height);
    // rust: width = next_w;
    // rust: r
    // rust: } else {
    // rust: let r = Region::new(0, height, width, next_h - height);
    // rust: height = next_h;
    // rust: r
}
        // Pinned expand ignores add's result for a sprite wider than the device limit.
    // rust: region.add(index, w, h);
    // rust: regions.push(region);
}
    // rust: let mut out = HashMap::new();
    // rust: for r in regions {
    // rust: r.gather(entries, [width, height], padding, &mut out);
}
    // rust: Some(out)
}
