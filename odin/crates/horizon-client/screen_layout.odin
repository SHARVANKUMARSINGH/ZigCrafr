//! Transpiled from Horizon Rust crate
package horizon_client_screen_layout

import "core:fmt"
import "core:mem"
import "core:math"

// The loom and crafter screens' own drawing as `GuiGraphicsExtractor` calls:
// `LoomScreen.extractBackground` (slot icons, the scroller, the pattern
// buttons with their banner swatches and tooltip, the result banner or the
// six-layer error) and `CrafterScreen`'s background, disabled slots and
// redstone arrow. Computed without drawing so `tools/test_screen_layout_parity.py`
// can compare them with the vanilla client; the game paints the same calls.
// use crate::banner::{self, BannerLayer, Banners};
// use std::sync::Arc;

// One call a screen makes.
ScreenDraw :: enum {
    // `fillGradient(0, 0, width, height, ..)`: the dimmed world behind a menu.
    Gradient { x1: i32, y1: i32 },
    // `blit(texture, x, y, 0, 0, w, h, tw, th)`: a container background.
    Blit {,
    texture: &'static str,
    x: i32,
    y: i32,
    w: i32,
    h: i32,
    tw: i32,
    th: i32,
    // rust: },
    // `blitSprite(sprite, x, y, w, h)` of a GUI sprite.
    Sprite {,
    id: String,
    x: i32,
    y: i32,
    w: i32,
    h: i32,
    // rust: },
    // `bannerPattern(flag, base, layers, x0, y0, x1, y1)`: the result preview.
    Banner {,
    base: String,
    layers: Vec<BannerLayer>,
    x0: i32,
    y0: i32,
    x1: i32,
    y1: i32,
    // rust: },
    // `setTooltipForNextFrame` with a translation key.
    Tooltip { key: String },
    // `getSprite(id)`: the atlas sprite the following `Atlas` blit uses.
    SpriteOf { id: String },
    // `fill(x0, y0, x1, y1, argb)`.
    Fill {,
    x0: i32,
    y0: i32,
    x1: i32,
    y1: i32,
    color: i32,
    // rust: },
    // `blit(atlas, x0, y0, x1, y1, u0, u1, v0, v1)` with the UVs as fractions
    // of the sprite named by the last `SpriteOf`.
    Atlas {,
    x0: i32,
    y0: i32,
    x1: i32,
    y1: i32,
    uv: [f32; 4],
    // rust: },
}

// What `LoomScreen.extractBackground` reads.
LoomView :: struct {
    width: i32,
    height: i32,
    left: i32,
    top: i32,
    has_banner: bool,
    has_dye: bool,
    has_pattern: bool,
    // `menu.getSelectablePatterns()`.
    patterns: ^'a [^str],
    // `menu.getSelectedBannerPatternIndex()`.
    selected: i32,
    display: bool,
    has_max: bool,
    scroll: f32,
    start_row: uint,
    // The result banner's colour and layers (`resultBannerPatterns`).
    result: Option<(^'a str,
    // The dye stack's colour (`DataComponents.DYE`, white without one).
    dye: ^'a str,
    mouse: (f32,
}

// `DyeColor.getTextureDiffuseColor` as an opaque ARGB int.
diffuse :: proc(dye: string) -> i {
    // Ported from Horizon
    return {}
}
    // rust: (banner::dye_rgb(dye) | 0xFF00_0000) as i32
}

sprite :: proc(id: string, x: i32, y: i32, w: i32, h: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: ScreenDraw::Sprite {
    // rust: id: id.to_owned(),
    // rust: x,
    // rust: y,
    // rust: w,
    // rust: h,
}
}

// `LoomScreen.extractBackground`.
loom :: proc(v: ^LoomView, banners: ^Banners) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let (xo, yo) = (v.left, v.top);
    // rust: let mut out = vec![
    // rust: ScreenDraw::Gradient {
    // rust: x1: v.width,
    // rust: y1: v.height,
    // rust: },
    // rust: ScreenDraw::Blit {
    // rust: texture: "textures/gui/container/loom.png",
    // rust: x: xo,
    // rust: y: yo,
    // rust: w: 176,
    // rust: h: 166,
    // rust: tw: 256,
    // rust: th: 256,
    // rust: },
    // rust: ];
    // rust: for (has, icon, x, y) in [
    // rust: (v.has_banner, "banner", 13, 26),
    // rust: (v.has_dye, "dye", 33, 26),
    // rust: (v.has_pattern, "banner_pattern", 23, 45),
    // rust: ] {
    // rust: if !has {
    // rust: out.push(sprite(
    // rust: &format!("container/slot/{icon}"),
    // rust: xo + x,
    // rust: yo + y,
    // rust: 16,
    // rust: 16,
    // rust: ));
}
}
    // rust: let sy = (41.0 * v.scroll) as i32;
    // rust: let active = v.display && v.patterns.len() > 16;
    // rust: out.push(sprite(
    // rust: if active {
    // rust: "container/loom/scroller"
    // rust: } else {
    // rust: "container/loom/scroller_disabled"
    // rust: },
    // rust: xo + 119,
    // rust: yo + 13 + sy,
    // rust: 12,
    // rust: 15,
    // rust: ));
    // rust: match v.result {
    // rust: Some((base, layers)) if !v.has_max => out.push(ScreenDraw::Banner {
    // rust: base: base.to_owned(),
    // rust: layers: layers.to_vec(),
    // rust: x0: xo + 141,
    // rust: y0: yo + 8,
    // rust: x1: xo + 161,
    // rust: y1: yo + 48,
    // rust: }),
    // rust: _ if v.has_max => out.push(sprite("container/loom/error", xo + 138, yo + 52, 26, 26)),
    // rust: _ => {}
}
    // rust: if v.display {
    // rust: let (x, y) = (xo + 60, yo + 13);
    // rust: 'rows: for row in 0..4 {
    // rust: for column in 0..4 {
    // rust: let index = (row + v.start_row) * 4 + column;
    // rust: let Some(pattern) = v.patterns.get(index) else {
    // rust: break 'rows;
}
    // rust: let (px, py) = (x + column as i32 * 14, y + row as i32 * 14);
    // rust: let (mx, my) = v.mouse;
    // rust: let highlighted = mx >= px as f32
    // rust: && my >= py as f32
    // rust: && mx < (px + 14) as f32
    // rust: && my < (py + 14) as f32;
    // rust: let button = if index as i32 == v.selected {
    // rust: "container/loom/pattern_selected"
    // rust: } else if highlighted {
    // rust: out.push(ScreenDraw::Tooltip {
    // rust: key: banners.layer_key(&BannerLayer::new(pattern, v.dye)),
    // rust: });
    // rust: "container/loom/pattern_highlighted"
    // rust: } else {
    // rust: "container/loom/pattern"
}
    // rust: out.push(sprite(button, px, py, 14, 14));
                // extractBannerOnButton: a grey 5x10 swatch with the pattern's front.
    // rust: out.push(ScreenDraw::SpriteOf {
    // rust: id: banners.banner_texture(pattern),
    // rust: });
    // rust: let (bx, by) = (px + 4, py + 2);
    // rust: out.push(ScreenDraw::Fill {
    // rust: x0: bx,
    // rust: y0: by,
    // rust: x1: bx + 5,
    // rust: y1: by + 10,
    // rust: color: diffuse("gray"),
    // rust: });
    // rust: let v0 = 1.0 / 64.0;
    // rust: out.push(ScreenDraw::Atlas {
    // rust: x0: bx,
    // rust: y0: by,
    // rust: x1: bx + 5,
    // rust: y1: by + 10,
    // rust: uv: [0.0, 21.0 / 64.0, v0, v0 + 40.0 / 64.0],
    // rust: });
}
}
}
    // rust: out
}

// What `CrafterScreen` draws besides the generic container parts.
CrafterView :: struct {
    width: i32,
    height: i32,
    left: i32,
    top: i32,
    disabled: [bool,
    powered: bool,
}

// `CrafterScreen.extractBackground`, the disabled slots of `extractSlot`
// and `extractRedstone`.
crafter :: proc(v: ^CrafterView) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = vec![
    // rust: ScreenDraw::Gradient {
    // rust: x1: v.width,
    // rust: y1: v.height,
    // rust: },
    // rust: ScreenDraw::Blit {
    // rust: texture: "textures/gui/container/crafter.png",
    // rust: x: (v.width - 176) / 2,
    // rust: y: (v.height - 166) / 2,
    // rust: w: 176,
    // rust: h: 166,
    // rust: tw: 256,
    // rust: th: 256,
    // rust: },
    // rust: ];
    // rust: for (i, disabled) in v.disabled.iter().enumerate() {
    // rust: if *disabled {
    // rust: let (x, y) = (26 + (i % 3) as i32 * 18, 17 + (i / 3) as i32 * 18);
    // rust: out.push(sprite(
    // rust: "container/crafter/disabled_slot",
    // rust: v.left + x - 1,
    // rust: v.top + y - 1,
    // rust: 18,
    // rust: 18,
    // rust: ));
}
}
    // rust: out.push(sprite(
    // rust: if v.powered {
    // rust: "container/crafter/powered_redstone"
    // rust: } else {
    // rust: "container/crafter/unpowered_redstone"
    // rust: },
    // rust: v.width / 2 + 9,
    // rust: v.height / 2 - 48,
    // rust: 16,
    // rust: 16,
    // rust: ));
    // rust: out
}
