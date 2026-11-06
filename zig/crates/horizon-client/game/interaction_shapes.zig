//! Transpiled from Horizon Rust crate
//! Module: horizon-client_interaction_shapes
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `BlockBehaviour.getInteractionShape` of the four blocks that override it in
//! 26.3, for the player's block pick (`BlockGetter.clipWithInteractionOverride`):
//! a cauldron, a composter, a hopper and scaffolding. When the ray enters the
//! interaction shape before it enters the outline, the hit keeps the outline's
//! point but takes the interaction shape's face, so a bowl is targeted from
//! above where its inside wall is the outline's first hit.

/// The interaction shape's boxes of the block named `name` with `facing`, as
/// `[min x, min y, min z, max x, max y, max z]` within the block; none for any
/// other block.
    // rust: pub(super) fn boxes(name: &str, facing: Option<&str>) -> Vec<[f64; 6]> {
pub const P: f64 = 1.0 / 16.0;
    // rust: let scale = |b: [f64; 6]| b.map(|v| v * P);
    // rust: match name {
        // `AbstractCauldronBlock.SHAPE_INSIDE`: `Block.column(12, 4, 16)`.
    // rust: "minecraft:cauldron"
    // rust: | "minecraft:water_cauldron"
    // rust: | "minecraft:lava_cauldron"
    // rust: | "minecraft:powder_snow_cauldron" => vec![scale([2.0, 4.0, 2.0, 14.0, 16.0, 14.0])],
        // `Shapes.block()`.
    // rust: "minecraft:composter" | "minecraft:scaffolding" => vec![[0.0, 0.0, 0.0, 1.0, 1.0, 1.0]],
    // rust: "minecraft:hopper" => {
            // `inside` is `Block.column(12, 11, 16)`; a hopper pointing sideways adds its
            // spout, `Block.boxZ(4, 8, 10, 0, 4)` turned to face.
    // rust: let mut boxes = vec![scale([2.0, 11.0, 2.0, 14.0, 16.0, 14.0])];
    // rust: match facing {
    // rust: Some("north") => boxes.push(scale([6.0, 6.0, 0.0, 10.0, 10.0, 4.0])),
    // rust: Some("south") => boxes.push(scale([6.0, 6.0, 12.0, 10.0, 10.0, 16.0])),
    // rust: Some("west") => boxes.push(scale([0.0, 6.0, 6.0, 4.0, 10.0, 10.0])),
    // rust: Some("east") => boxes.push(scale([12.0, 6.0, 6.0, 16.0, 10.0, 10.0])),
    // rust: _ => {}
}
    // rust: boxes
}
    // rust: _ => Vec::new(),
}
}

/// The nearest entry of the ray `origin + dir * t` (`t` up to `reach`) into one
/// of `boxes` (world coordinates): its `t` and the normal of the face it
/// enters through, `inside` (the face the ray entered the block through) when it
/// starts in the box.
    // rust: pub(super) fn entry(
    // rust: origin: [f64; 3],
    // rust: dir: [f64; 3],
    // rust: boxes: &[[f64; 6]],
    // rust: reach: f64,
    // rust: inside: [i32; 3],
    // rust: ) -> Option<(f64, [i32; 3])> {
    // rust: let mut best: Option<(f64, [i32; 3])> = None;
    // rust: for b in boxes {
    // rust: let (mut t0, mut t1, mut axis_in, mut sign) = (0.0f64, f64::INFINITY, None, 0);
    // rust: let mut miss = false;
    // rust: for a in 0..3 {
    // rust: if dir[a] == 0.0 {
    // rust: miss |= origin[a] < b[a] || origin[a] > b[a + 3];
    // rust: continue;
}
    // rust: let (lo, hi) = ((b[a] - origin[a]) / dir[a], (b[a + 3] - origin[a]) / dir[a]);
    // rust: let (near, far) = if lo < hi { (lo, hi) } else { (hi, lo) };
    // rust: if near > t0 {
    // rust: t0 = near;
    // rust: axis_in = Some(a);
    // rust: sign = if dir[a] > 0.0 { -1 } else { 1 };
}
    // rust: t1 = t1.min(far);
}
    // rust: if miss || t0 > t1 || t0 > reach {
    // rust: continue;
}
    // rust: let mut normal = inside;
    // rust: if let Some(a) = axis_in {
    // rust: normal = [0; 3];
    // rust: normal[a] = sign;
}
    // rust: if best.is_none_or(|(bt, _)| t0 < bt) {
    // rust: best = Some((t0, normal));
}
}
    // rust: best
}

    // rust: mod tests {
//     use super::*;

    /// The report: standing at eyes [0.5, 101.27, 0.5], a ray pitched 7 degrees down crosses the
    /// cauldron at [0, 100, 2] at the height of its rim, inside the inside shape's top plane:
    /// the inside shape is entered through its top face.
pub fn a_ray_over_a_cauldron_enters_its_inside_through_the_top() void {
}
    // rust: let boxes: Vec<[f64; 6]> = boxes("minecraft:cauldron", None)
    // rust: .iter()
    // rust: .map(|b| {
    // rust: [
    // rust: b[0],
    // rust: b[1] + 100.0,
    // rust: b[2] + 2.0,
    // rust: b[3],
    // rust: b[4] + 100.0,
    // rust: b[5] + 2.0,
    // rust: ]
    // rust: })
    // rust: .collect();
    // rust: let pitch = 7.0f64.to_radians();
    // rust: let dir = [0.0, -pitch.sin(), pitch.cos()];
    // rust: let (_, normal) = entry([0.5, 101.27, 0.5], dir, &boxes, 5.0, [0, 0, -1]).unwrap();
    // rust: assert_eq!(normal, [0, 1, 0]);
}

pub fn only_the_four_blocks_have_one() void {
}
    // rust: assert!(boxes("minecraft:stone", None).is_empty());
    // rust: assert_eq!(
    // rust: boxes("minecraft:composter", None),
    // rust: [[0.0, 0.0, 0.0, 1.0, 1.0, 1.0]]
    // rust: );
    // rust: assert_eq!(boxes("minecraft:hopper", Some("down")).len(), 1);
        // A hopper pointing east: the spout on its east side.
    // rust: assert_eq!(boxes("minecraft:hopper", Some("east")).len(), 2);
}
}
