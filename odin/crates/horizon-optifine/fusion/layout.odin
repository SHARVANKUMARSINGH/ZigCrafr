//! Transpiled from Horizon Rust crate
package horizon_optifine_layout

import "core:fmt"
import "core:mem"
import "core:math"

// A connecting texture's image is a grid of tiles; its layout says which tiles a face draws
// for the neighbours that join it (a [`crate::ctm::connect`] mask). Tiles are numbered row by
// row from the top left of the grid.
//
// The tiles are FusionExamples' `templates/template <layout>.png`: each marks its joined sides
// (and, where both sides beside a corner join, that corner) in green. `compact`'s template
// names its 5 tiles, not their masks; which one a face takes is the wiki's GIF of the layout.

// use crate::ctm::connect::{D, DL, DR, L, R, U, UL, UR, reduce};

Layout :: enum {
    // 5 tiles, a quarter of the face from each.
    Pieced,
    // 16 tiles: the four sides only.
    Simple,
    // 47 tiles: the sides and the corners.
    Full,
    // 4 tiles in a column: alone, a column's top, middle and bottom.
    Vertical,
    // 4 tiles in a row: alone, a row's left end, middle and right end.
    Horizontal,
    // 5 tiles, a whole one per face.
    Compact,
    // Edge pieces drawn over the face toward the neighbours that join it.
    Overlay,
}

// What a face draws.
Tiles :: enum {
    One(u8),
    // A tile per quarter of the face: top left, top right, bottom left, bottom right.
    Quarters([u8; 4]),
    // [`Layout::overlay_tiles`] of this mask, layered; none when nothing joins.
    Overlay(u8),
}

// Every side.
SIDES :: U | R | D | L
CORNERS :: UR | DR | DL | UL

// The full template's tiles as the neighbours each joins. Its one empty cell is never drawn: a
// lone corner, which [`reduce`] never leaves.
EMPTY :: UR
    // rust: const FULL: [u8; 48] = [
    // rust: 0,
    // rust: R,
    // rust: R | L,
    // rust: L,
    // rust: R | D,
    // rust: D | L,
    // rust: U | R | D,
    // rust: R | D | L,
    // rust: D,
    // rust: R | DR | D,
    // rust: R | DR | D | DL | L,
    // rust: D | DL | L,
    // rust: U | R,
    // rust: U | L,
    // rust: U | R | L,
    // rust: U | D | L,
    // rust: U | D,
    // rust: U | UR | R | DR | D,
    // rust: SIDES | CORNERS,
    // rust: U | D | DL | L | UL,
    // rust: U | UR | R | D,
    // rust: R | DR | D | L,
    // rust: U | R | DR | D,
    // rust: R | D | DL | L,
    // rust: U,
    // rust: U | UR | R,
    // rust: U | UR | R | L | UL,
    // rust: U | L | UL,
    // rust: U | R | L | UL,
    // rust: U | D | DL | L,
    // rust: U | UR | R | L,
    // rust: U | D | L | UL,
    // rust: SIDES | UR | DL,
    // rust: SIDES,
    // rust: SIDES | UR | DR,
    // rust: SIDES | DR | DL,
    // rust: SIDES | DR,
    // rust: SIDES | DL,
    // rust: SIDES | UL | UR | DL,
    // rust: SIDES | UL | UR | DR,
    // rust: SIDES | UL | DR,
    // rust: EMPTY,
    // rust: SIDES | UL | UR,
    // rust: SIDES | UL | DL,
    // rust: SIDES | UR,
    // rust: SIDES | UL,
    // rust: SIDES | UL | DL | DR,
    // rust: SIDES | UR | DL | DR,
    // rust: ];

// The simple template's 16 tiles as the sides each joins.
    // rust: const SIMPLE: [u8; 16] = [
    // rust: 0,
    // rust: SIDES,
    // rust: D,
    // rust: L,
    // rust: R | L,
    // rust: U | D,
    // rust: R,
    // rust: U,
    // rust: U | R | D,
    // rust: R | D | L,
    // rust: R | D,
    // rust: D | L,
    // rust: U | R | L,
    // rust: U | D | L,
    // rust: U | R,
    // rust: U | L,
    // rust: ];

// `table`'s tile for each mask its entries can be: the inverse of the template.
    // rust: const fn invert<const N: usize>(table: [u8; N]) -> [u8; 256] {
    // rust: let mut out = [0; 256];
    // rust: let mut i = 0;
    // rust: while i < N {
    // rust: if table[i] != EMPTY {
    // rust: out[table[i] as usize] = i as u8;
}
    // rust: i += 1;
}
    // rust: out
}

FULL_INDEX :: invert(FULL)
SIMPLE_INDEX :: invert(SIMPLE)

// The overlay grid (6 x 3). On its left half an edge piece toward each side and a piece in
// each corner; on its right the pieces for two and three sides joined through the corners
// between them, and the ring for all eight neighbours.
RING :: 10
// Clockwise from the top: each side, and the corner after it.
CYCLE :: [(U, UR), (R, DR), (D, DL), (L, UL)]
// By the side a run starts at, in `CYCLE`'s order: the piece for it alone, with the next side,
// with the next two.
EDGE :: [13, 6, 1, 8]
PAIR :: [15, 3, 5, 17]
TRIPLE :: [9, 4, 11, 16]
// The corner pieces, in `CYCLE`'s order of the corners.
CORNER :: [12, 0, 2, 14]

    // rust: impl Layout {
parse :: proc(name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(match name {
    // rust: "pieced" => Self::Pieced,
    // rust: "simple" => Self::Simple,
    // rust: "full" => Self::Full,
    // rust: "vertical" => Self::Vertical,
    // rust: "horizontal" => Self::Horizontal,
    // rust: "compact" => Self::Compact,
    // rust: "overlay" => Self::Overlay,
    // rust: _ => return None,
    // rust: })
}

    // The image's grid: columns, rows.
grid :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Pieced | Self::Compact => (5, 1),
    // rust: Self::Simple => (4, 4),
    // rust: Self::Full => (8, 6),
    // rust: Self::Vertical => (1, 4),
    // rust: Self::Horizontal => (4, 1),
    // rust: Self::Overlay => (6, 3),
}
}

    // The tiles a face draws when the neighbours in `mask` join it.
tiles :: proc(self: ^Self, mask: u8) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let sides = mask & SIDES;
    // rust: let joined = |bits: u8| mask & bits == bits;
    // rust: let straight = |a, b| match (joined(a), joined(b)) {
    // rust: (false, false) => 0,
    // rust: (false, true) => 1,
    // rust: (true, true) => 2,
    // rust: (true, false) => 3,
}
    // rust: match self {
            // The 5 tiles are `ctm_compact`'s: alone, joined all round, up and down, left and
            // right, all but the corner.
    // rust: Self::Pieced => Tiles::Quarters(crate::ctm::connect::compact_quarters(mask)),
    // rust: Self::Simple => Tiles::One(SIMPLE_INDEX[sides as usize]),
    // rust: Self::Full => Tiles::One(FULL_INDEX[reduce(mask) as usize]),
            // Alone, then the end that joins `b` (a column's top, a row's left end), the
            // middle, the other end.
    // rust: Self::Vertical => Tiles::One(straight(U, D)),
    // rust: Self::Horizontal => Tiles::One(straight(L, R)),
            // An end, the centre, a vertical and a horizontal section and a cross: joined
            // both ways, the centre only with every corner too.
    // rust: Self::Compact => Tiles::One(match (joined(L | R), joined(U | D)) {
    // rust: (true, true) if joined(CORNERS) => 1,
    // rust: (true, true) => 4,
    // rust: (false, true) => 2,
    // rust: (true, false) => 3,
    // rust: (false, false) => 0,
    // rust: }),
    // rust: Self::Overlay => Tiles::Overlay(mask),
}
}

    // The overlay grid's tiles for `mask`, bottom first. Going round the face, each run of
    // joined sides with joined corners between them is one piece; then each joined corner with
    // neither side beside it. Unlike OptiFine's overlay, a corner matters between two joined
    // sides: without it they are two pieces (the wiki's GIF of the layout).
overlay_tiles :: proc(mask: u8) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = [0; 4];
    // rust: let mut n = 0;
    // rust: let mut push = |tile| {
    // rust: out[n] = tile;
    // rust: n += 1;
}
    // rust: let side = |i: usize| mask & CYCLE[i % 4].0 != 0;
        // Side `i` joins the next one clockwise.
    // rust: let linked = |i: usize| side(i) && side(i + 1) && mask & CYCLE[i % 4].1 != 0;
    // rust: if mask == 0xff {
    // rust: push(RING);
    // rust: } else {
    // rust: for start in (0..4).filter(|&i| side(i) && !linked(i + 3)) {
    // rust: let mut len = 1;
    // rust: while len < 4 && linked(start + len - 1) {
    // rust: len += 1;
}
    // rust: match len {
    // rust: 1 => push(EDGE[start]),
    // rust: 2 => push(PAIR[start]),
    // rust: 3 => push(TRIPLE[start]),
                    // Every side, one corner open: the grid has no piece for it. Two three-side
                    // pieces, overlapping on the middle two sides, keep every joined corner.
    // rust: _ => {
    // rust: push(TRIPLE[start]);
    // rust: push(TRIPLE[(start + 1) % 4]);
}
}
}
    // rust: for (i, &(s, corner)) in CYCLE.iter().enumerate() {
    // rust: if mask & corner != 0 && mask & (s | CYCLE[(i + 1) % 4].0) == 0 {
    // rust: push(CORNER[i]);
}
}
}
    // rust: out.into_iter().take(n)
}
}

    // rust: mod tests {
//     use super::*;

one :: proc(layout: Layout, mask: u8) -> u {
    // Ported from Horizon
    return {}
}
    // rust: match layout.tiles(mask) {
    // rust: Tiles::One(t) => t,
    // rust: other => panic!("{other:?}"),
}
}

    // The tiles `layout` draws over every mask.
drawn :: proc(layout: Layout) -> s {
    // Ported from Horizon
    return {}
}
    // rust: (0..=255u8).map(|mask| one(layout, mask)).collect()
}

every_tile_is_drawn_for_some_mask :: proc() {
}
        // A mask a table lacks would fall to tile 0 and leave its own tile unused. The full
        // template's empty cell, (1, 5), is the one never drawn.
    // rust: let mut full: Vec<u8> = drawn(Layout::Full).into_iter().collect();
    // rust: full.sort_unstable();
    // rust: assert_eq!(full, (0..48).filter(|&t| t != 41).collect::<Vec<_>>());
    // rust: for layout in [
    // rust: Layout::Simple,
    // rust: Layout::Vertical,
    // rust: Layout::Horizontal,
    // rust: Layout::Compact,
    // rust: ] {
    // rust: let (w, h) = layout.grid();
    // rust: assert_eq!(drawn(layout).len() as u32, w * h, "{layout:?}");
}
}

full_layout_reads_the_template :: proc() {
}
        // Alone: the top-left tile. A row's middle: the third.
    // rust: assert_eq!(one(Layout::Full, 0), 0);
    // rust: assert_eq!(one(Layout::Full, L | R), 2);
        // Joined all round: (2, 2); with no corners: (1, 4).
    // rust: assert_eq!(one(Layout::Full, 0xff), 18);
    // rust: assert_eq!(one(Layout::Full, SIDES), 33);
        // A corner whose sides don't both join changes nothing: up and the up-right corner is
        // the tile for up alone, (0, 3).
    // rust: assert_eq!(one(Layout::Full, U | UR), 24);
    // rust: assert_eq!(one(Layout::Full, U | UR | R), 25);
        // Every side and only the top-left corner: (5, 5).
    // rust: assert_eq!(one(Layout::Full, SIDES | UL), 45);
        // Every side and some corners, off the bottom two rows: opposite corners (0, 4) and
        // (0, 5); one corner (4, 4); three (6, 4).
    // rust: assert_eq!(one(Layout::Full, SIDES | UR | DL), 32);
    // rust: assert_eq!(one(Layout::Full, SIDES | UL | DR), 40);
    // rust: assert_eq!(one(Layout::Full, SIDES | DR), 36);
    // rust: assert_eq!(one(Layout::Full, SIDES | DL), 37);
    // rust: assert_eq!(one(Layout::Full, SIDES | UL | UR | DL), 38);
        // Three sides and one corner between them: (4, 3) and (6, 3).
    // rust: assert_eq!(one(Layout::Full, U | R | L | UL), 28);
    // rust: assert_eq!(one(Layout::Full, U | R | L | UR), 30);
}

simple_and_straight_layouts :: proc() {
}
    // rust: assert_eq!(one(Layout::Simple, D), 2);
    // rust: assert_eq!(one(Layout::Simple, U | L | UL), 15);
        // Corners don't count.
    // rust: assert_eq!(one(Layout::Simple, R | D | DR), 10);
        // The three-side tiles: (0, 2), (1, 2), (0, 3), (1, 3).
    // rust: assert_eq!(one(Layout::Simple, U | R | D), 8);
    // rust: assert_eq!(one(Layout::Simple, R | D | L), 9);
    // rust: assert_eq!(one(Layout::Simple, U | R | L), 12);
    // rust: assert_eq!(one(Layout::Simple, U | D | L), 13);
        // A column: bottom (joined up), middle, top.
    // rust: assert_eq!(one(Layout::Vertical, U), 3);
    // rust: assert_eq!(one(Layout::Vertical, U | D), 2);
    // rust: assert_eq!(one(Layout::Vertical, D), 1);
    // rust: assert_eq!(one(Layout::Vertical, L | R), 0);
        // A row: the left end joins right.
    // rust: assert_eq!(one(Layout::Horizontal, R), 1);
    // rust: assert_eq!(one(Layout::Horizontal, L | R | U), 2);
    // rust: assert_eq!(one(Layout::Horizontal, L), 3);
}

compact_picks_one_whole_tile :: proc() {
}
        // A row's end draws the end tile; its middle the horizontal section.
    // rust: assert_eq!(one(Layout::Compact, R), 0);
    // rust: assert_eq!(one(Layout::Compact, L | R), 3);
        // The top middle of a 3 x 3 square joins left, right and down: horizontal.
    // rust: assert_eq!(one(Layout::Compact, L | R | D | DL | DR), 3);
    // rust: assert_eq!(one(Layout::Compact, U | D | R), 2);
        // The square's middle, and a plus sign's.
    // rust: assert_eq!(one(Layout::Compact, 0xff), 1);
    // rust: assert_eq!(one(Layout::Compact, SIDES), 4);
        // Some corners aren't all of them: still the cross.
    // rust: assert_eq!(one(Layout::Compact, SIDES | UL | UR | DR), 4);
        // A square's corner joins two sides: an end.
    // rust: assert_eq!(one(Layout::Compact, R | D | DR), 0);
}

pieced_quarters :: proc() {
}
        // Joined right only: the left quarters are the lone tile, the right ones horizontal.
    // rust: assert_eq!(Layout::Pieced.tiles(R), Tiles::Quarters([0, 3, 0, 3]));
        // Joined up and right without the corner: the top-right quarter is the cross piece.
    // rust: assert_eq!(Layout::Pieced.tiles(U | R), Tiles::Quarters([2, 4, 0, 3]));
    // rust: assert_eq!(
    // rust: Layout::Pieced.tiles(U | R | UR),
    // rust: Tiles::Quarters([2, 1, 0, 3])
    // rust: );
}

overlay_layers_edges_and_corners :: proc() {
}
    // rust: let cells = |mask| Layout::overlay_tiles(mask).collect::<Vec<_>>();
    // rust: assert_eq!(cells(0), [0u8; 0]);
        // Sand below: the bottom edge piece, (1, 0); to the right: (0, 1).
    // rust: assert_eq!(cells(D), [1]);
    // rust: assert_eq!(cells(R), [6]);
        // Sand all round: the ring, (4, 1).
    // rust: assert_eq!(cells(0xff), [10]);
        // Two sides and the corner between them: one L-shaped piece off the right half.
    // rust: assert_eq!(cells(L | D | DL), [5]);
    // rust: assert_eq!(cells(R | D | DR), [3]);
    // rust: assert_eq!(cells(U | R | UR), [15]);
    // rust: assert_eq!(cells(U | L | UL), [17]);
        // Without the corner: two edge pieces.
    // rust: assert_eq!(cells(R | D), [6, 1]);
        // Three sides and both corners between them.
    // rust: assert_eq!(cells(R | D | L | DR | DL), [4]);
    // rust: assert_eq!(cells(U | R | D | UR | DR), [9]);
    // rust: assert_eq!(cells(U | D | L | UL | DL), [11]);
    // rust: assert_eq!(cells(U | R | L | UL | UR), [16]);
        // The wiki's GIF: sand up, up-left, left and right, not up-right. The up-left piece,
        // (5, 2), and the right edge, (0, 1).
    // rust: assert_eq!(cells(U | UL | L | R), [6, 17]);
        // Every side and no corner: four edges. Every side but the top-left corner: no
        // template or GIF shows it, so this pins `overlay_tiles`' own choice, the pieces for
        // up-right-down and right-down-left.
    // rust: assert_eq!(cells(U | R | D | L), [13, 6, 1, 8]);
    // rust: assert_eq!(cells(!UL), [9, 4]);
        // A lone corner each.
    // rust: assert_eq!(cells(DL), [2]);
    // rust: assert_eq!(cells(UL), [14]);
        // Above and below: two edge pieces.
    // rust: assert_eq!(cells(U | D), [13, 1]);
        // A column of sand to the left, and sand at the right corners only: the left edge,
        // then the top-right and bottom-right corner pieces.
    // rust: assert_eq!(cells(UL | L | DL | UR | DR), [8, 12, 0]);
}
}
