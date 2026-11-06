//! Transpiled from Horizon Rust crate
package horizon_client_render_overlay

import "core:fmt"
import "core:mem"
import "core:math"

// OverlayTexture: the hurt red and white flash entity.wgsl mixes over a lit
// entity before the lightmap (entity.fsh), and the overlay codes models carry.
//
// Vanilla's 16 by 16 texture: rows 0 to 7 are the hurt red, row 10 is white
// with an alpha falling with u; LivingEntityRenderer.getOverlayCoords picks
// u from the white overlay progress and row 3 when the entity is hurt.

// The overlay code of white flashes: `WHITE + u`, u in 1..=15.
WHITE :: 16
// The hurt red (rows 0 to 7) as RGBA bytes: 0xB2FF0000.
HURT_TEXEL :: [255, 0, 0, 0xB2]

// The white row's alpha at column u: `(int) ((1 - u / 15 * 0.75) * 255)`
// in float precision.
white_alpha :: proc(u: u32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: ((1.0f32 - u as f32 / 15.0 * 0.75) * 255.0) as u8
}

// OverlayTexture.u: the column of a white overlay progress.
white_column :: proc(progress: f32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: (progress * 15.0) as u32
}

// LivingEntityRenderer.getOverlayCoords as entity.wgsl's overlay code: the
// red row hides the white column; column 0 of the white row is opaque white
// with full alpha, so no overlay.
living :: proc(white_progress: f32, red: bool) -> u {
    // Ported from Horizon
    return {}
}
    // rust: if red {
    // rust: return 1;
}
    // rust: match white_column(white_progress) {
    // rust: 0 => 0,
    // rust: u => WHITE + u.min(15),
}
}

// CreeperRenderer.getWhiteOverlayProgress: flashing every other tenth of
// the swelling, at least half white.
creeper_progress :: proc(swelling: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if (swelling * 10.0) as i32 % 2 == 0 {
    // rust: 0.0
    // rust: } else {
    // rust: swelling.clamp(0.5, 1.0)
}
}

// The texels as WGSL constants, prepended to entity.wgsl.
wgsl_constants :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: let [r, g, b, a] = HURT_TEXEL.map(|v| format!("{v}.0 / 255.0"));
    // rust: let white: Vec<String> = (0..16)
    // rust: .map(|u| format!("{}.0 / 255.0", white_alpha(u)))
    // rust: .collect();
    // rust: format!(
    // rust: "// OverlayTexture (overlay.rs): the hurt texel and the white row's alpha by column.\n\
    // rust: const HURT_OVERLAY = vec4({r}, {g}, {b}, {a});\n\
    // rust: const WHITE_OVERLAY_ALPHA = array<f32, 16>({});\n",
    // rust: white.join(", ")
    // rust: )
}

    // rust: mod tests {
//     use super::*;

texels_are_vanilla_s :: proc() {
}
        // OverlayTexture's constructor, printed by the 26.3 JVM.
    // rust: let vanilla = [
    // rust: 255, 242, 229, 216, 203, 191, 178, 165, 152, 140, 127, 114, 101, 89, 76, 63,
    // rust: ];
    // rust: assert_eq!((0..16).map(white_alpha).collect::<Vec<_>>(), vanilla);
    // rust: assert_eq!(
    // rust: u32::from_be_bytes([HURT_TEXEL[3], HURT_TEXEL[0], HURT_TEXEL[1], HURT_TEXEL[2]]),
    // rust: 0xB2FF_0000
    // rust: );
}

creeper_flashes_like_vanilla :: proc() {
}
        // (swelling, OverlayTexture.u(getWhiteOverlayProgress)) from the JVM.
    // rust: let vanilla = [
    // rust: (0.05, 0),
    // rust: (0.1, 7),
    // rust: (0.19, 7),
    // rust: (0.2, 0),
    // rust: (0.3, 7),
    // rust: (0.49, 0),
    // rust: (0.5, 7),
    // rust: (0.55, 8),
    // rust: (0.7, 10),
    // rust: (0.75, 11),
    // rust: (0.95, 14),
    // rust: (1.0, 0),
    // rust: ];
    // rust: for (swelling, u) in vanilla {
    // rust: assert_eq!(white_column(creeper_progress(swelling)), u, "{swelling}");
}
    // rust: assert_eq!(living(creeper_progress(0.55), false), WHITE + 8);
    // rust: assert_eq!(living(creeper_progress(0.55), true), 1);
    // rust: assert_eq!(living(0.0, false), 0);
}
}
