//! Transpiled from Horizon Rust crate
package horizon_items_banner_layer

import "core:fmt"
import "core:mem"
import "core:math"

// Banner pattern layers (`BannerPatternLayers`) and their NBT form.
// use horizon_world::nbt::Tag;
// use std::sync::Arc;

// `BannerPatternLayers.Layer`: a pattern id and the dye name it is painted in.
BannerLayer :: struct {
    pattern: ^str,
    color: ^str,
}
    // rust: impl BannerLayer {
new :: proc(pattern: string, color: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: pattern: Arc::from(pattern),
    // rust: color: Arc::from(color),
}
}
}

// The `banner_patterns` NBT list of layers.
layers_to_nbt :: proc(layers: ^[BannerLayer]) -> T {
    // Ported from Horizon
    return {}
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
layers_from_nbt :: proc(tag: Maybe(^Tag)) -> V {
    // Ported from Horizon
    return {}
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
