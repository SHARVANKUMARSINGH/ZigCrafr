//! Transpiled from Horizon Rust crate
package horizon_items_firework

import "core:fmt"
import "core:mem"
import "core:math"

// Firework explosions (the `firework_explosion` component and its shapes) and
// the dye colours fireworks use.

// FireworkExplosion.Shape.
FireworkShape :: enum {
    SmallBall,
    LargeBall,
    Star,
    Creeper,
    Burst,
}
    // rust: impl FireworkShape {
from_name :: proc(name: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match name {
    // rust: "large_ball" => Self::LargeBall,
    // rust: "star" => Self::Star,
    // rust: "creeper" => Self::Creeper,
    // rust: "burst" => Self::Burst,
    // rust: _ => Self::SmallBall,
}
}
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::SmallBall => "small_ball",
    // rust: Self::LargeBall => "large_ball",
    // rust: Self::Star => "star",
    // rust: Self::Creeper => "creeper",
    // rust: Self::Burst => "burst",
}
}
}
// `DyeColor` names and `getFireworkColor`, by dye id (white to black).
    // rust: pub const DYE_FIREWORK_COLORS: [(&str, u32); 16] = [
    // rust: ("white", 0xF0F0F0),
    // rust: ("orange", 0xEB8844),
    // rust: ("magenta", 0xC354CD),
    // rust: ("light_blue", 0x6689D3),
    // rust: ("yellow", 0xDECF2A),
    // rust: ("lime", 0x41CD34),
    // rust: ("pink", 0xD88198),
    // rust: ("gray", 0x434343),
    // rust: ("light_gray", 0xABABAB),
    // rust: ("cyan", 0x287697),
    // rust: ("purple", 0x7B2FBE),
    // rust: ("blue", 0x253192),
    // rust: ("brown", 0x51301A),
    // rust: ("green", 0x3B511A),
    // rust: ("red", 0xB3312C),
    // rust: ("black", 0x1E1B1B),
    // rust: ];
// The `firework_explosion` component.
FireworkExplosion :: struct {
    shape: FireworkShape,
    colors: [dynamic]u32,
    fade: [dynamic]u32,
    trail: bool,
    twinkle: bool,
}
