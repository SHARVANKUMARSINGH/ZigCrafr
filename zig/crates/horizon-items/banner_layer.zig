//! Transpiled from Horizon Rust crate
//! Module: horizon-items_banner_layer
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Banner pattern layers (`BannerPatternLayers`) and their NBT form.
// use horizon_world::nbt::Tag;
// use std::sync::Arc;

/// `BannerPatternLayers.Layer`: a pattern id and the dye name it is painted in.
pub const BannerLayer = struct {
    pattern: *str,
    color: *str,
};
    // rust: impl BannerLayer {
pub fn new(pattern: []const u8, color: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: pattern: Arc::from(pattern),
    // rust: color: Arc::from(color),
}
}
}

/// The `banner_patterns` NBT list of layers.
pub fn layers_to_nbt(layers: *[BannerLayer]) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Tag::List(
    // rust: layers
    // rust: .iter()
    // rust: .map(|l| {
    // rust: Tag::compound([
    // rust: ("pattern", Tag::String((&*l.pattern).into())),
    // rust: ("color", Tag::String((&*l.color).into())),
    // rust: ])
    // rust: })
    // rust: .collect(),
    // rust: )
}
pub fn layers_from_nbt(tag: ?*Tag) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(Tag::List(list)) = tag else {
    // rust: return Vec::new();
}
    // rust: list.iter()
    // rust: .filter_map(|e| {
    // rust: let text = |k: &str| match e.get(k) {
    // rust: Some(Tag::String(s)) => Some(s.to_string_lossy()),
    // rust: _ => None,
}
    // rust: let pattern = text("pattern")?;
    // rust: let color = text("color")?;
    // rust: Some(BannerLayer::new(
    // rust: &if pattern.contains(':') {
    // rust: pattern
    // rust: } else {
    // rust: format!("minecraft:{pattern}")
    // rust: },
    // rust: &color,
    // rust: ))
    // rust: })
    // rust: .collect()
}
