//! Transpiled from Horizon Rust crate
package horizon_client_render_pad_cursor

import "core:fmt"
import "core:mem"
import "core:math"

// The controller's menu cursor in inventories: a crosshair whose centre is
// the point it clicks. Horizon's own art, packed with the button glyphs (`pad_glyph`).

// The atlas sprite.
SPRITE :: "horizon:gui/controller/crosshair_inv"
// The size it's drawn at in GUI pixels (an item's); its texture is twice that.
DRAWN :: 16.0

    // rust: pub(crate) const PNG: &[u8] =
    // rust: include_bytes!("../../horizon-client/assets/horizon/textures/gui/controller/crosshair_inv.png");

// Where to draw the cursor (top-left, GUI pixels) so its centre lands on
// the GUI point `at`.
origin :: proc(at: (f32) {
}
    // rust: (at.0 - DRAWN / 2.0, at.1 - DRAWN / 2.0)
}

    // rust: mod tests {
//     use super::*;

the_cursor_is_a_crosshair_centred_on_its_point :: proc() {
}
    // rust: let (_, w, h, px) = crate::pad_glyph::images()
    // rust: .find(|i| i.0 == SPRITE)
    // rust: .expect("the cursor is packed");
    // rust: assert_eq!((w as f32, h as f32), (DRAWN * 2.0, DRAWN * 2.0));
    // rust: let alpha = |x: u32, y: u32| px[((y * w + x) * 4 + 3) as usize];
    // rust: let middle = (w / 2 - 1)..=(w / 2);
    // rust: assert!(
    // rust: middle
    // rust: .clone()
    // rust: .any(|x| middle.clone().any(|y| alpha(x, y) > 0)),
    // rust: "the clicked point sits on the crosshair"
    // rust: );
    // rust: assert_eq!(alpha(0, 0), 0, "corners are clear: a plus, not a square");
    // rust: assert_eq!(origin((100.0, 50.0)), (92.0, 42.0));
}
}
