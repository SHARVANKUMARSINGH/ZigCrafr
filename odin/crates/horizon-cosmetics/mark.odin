//! Transpiled from Horizon Rust crate
package horizon_cosmetics_mark

import "core:fmt"
import "core:mem"
import "core:math"

// Horizon's mark as the game draws it before a Horizon player's name (and the launcher before
// yours): two white bars over a violet line, their reflection fainter under it, 8×8.

// The mark's rectangles in its 8×8 square: `(x, y, width, height, ARGB)`.
    // rust: pub const MARK: [(u8, u8, u8, u8, u32); 5] = [
    // rust: (2, 1, 1, 3, 0xFFFF_FFFF),
    // rust: (5, 1, 1, 3, 0xFFFF_FFFF),
    // rust: (0, 4, 8, 1, 0xFFA9_8FFF),
    // rust: (2, 5, 1, 2, 0x66FF_FFFF),
    // rust: (5, 5, 1, 2, 0x66FF_FFFF),
    // rust: ];

// The mark as 8×8 RGBA texels, rows from the top.
texels :: proc() -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = [[0; 4]; 64];
    // rust: for (x, y, w, h, argb) in MARK {
    // rust: let [a, r, g, b] = argb.to_be_bytes();
    // rust: for yy in y..y + h {
    // rust: for xx in x..x + w {
    // rust: out[usize::from(yy) * 8 + usize::from(xx)] = [r, g, b, a];
}
}
}
    // rust: out
}
