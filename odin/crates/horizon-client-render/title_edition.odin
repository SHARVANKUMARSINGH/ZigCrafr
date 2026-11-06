//! Transpiled from Horizon Rust crate
package horizon_client_render_title_edition

import "core:fmt"
import "core:mem"
import "core:math"

// "RUST EDITION" under the classic title screen's logo.
//
// Vanilla's `textures/gui/title/edition.png` reads "JAVA EDITION". Horizon
// never ships Mojang's art, so the banner is rebuilt at load time from the
// player's own texture: "EDITION" is kept column for column, the "T" is lifted
// out of it, and R, U and S are Horizon's own glyphs (MIT, the rectangles
// below), drawn the way the texture's letters are built (a face with darker
// sides and a light bottom edge, a dark extrusion under it, a black outline
// and a soft rim) in the shades sampled from the texture itself. Only
// vanilla 26.3's exact texture is rebuilt: a resource pack's edition.png
// stays as its author drew it.

// use std::collections::{HashMap, VecDeque};
// use std::ops::Range;

// The atlas sprite.
SPRITE :: "gui/title/edition"
WIDTH :: 512
HEIGHT :: 64
// FNV-1a over the size and RGBA pixels of 26.3's edition.png.
VANILLA :: 0x4249_0538_6dfb_181f
// "EDITION", outline included, starts at this column; left of it is "JAVA".
EDITION_START :: 204
// The columns of the "T"'s body (face and extrusion) inside "EDITION".
T_BODY :: (335, 376)
// Where the texture's letters put their faces, and how deep they are drawn.
FACE_TOP :: 4
EXTRUSION :: 8
OUTLINE :: 3
// The face-to-face spacing between letters.
LETTER_GAP :: 6
// The new glyphs' face width: "RUST" then spans "JAVA"'s columns to within
// a texel, so "EDITION" stays where it is and the banner stays centred.
GLYPH_WIDTH :: 42
// The first face column, as "JAVA"'s.
FIRST_FACE :: 4

// Horizon's R, U and S: face rectangles `[x0, y0, x1, y1)` in texels from the
// face's top-left, 42 wide and 39 tall, with 11-texel stems, 10-texel bars and
// 7-texel notches for the rounded corners.
    // rust: const R: &[[usize; 4]] = &[
    // rust: [0, 0, 11, 39],
    // rust: [0, 0, 35, 10],
    // rust: [31, 7, 42, 19],
    // rust: [0, 15, 35, 25],
    // rust: [31, 25, 42, 39],
    // rust: ];
U :: &[[0, 0, 11, 32], [31, 0, 42, 32], [7, 29, 35, 39]]
    // rust: const S: &[[usize; 4]] = &[
    // rust: [7, 0, 42, 10],
    // rust: [0, 7, 11, 19],
    // rust: [7, 15, 35, 25],
    // rust: [31, 21, 42, 32],
    // rust: [0, 29, 35, 39],
    // rust: ];

// The banner rebuilt to read "RUST EDITION", or `None` when the texture is
// not vanilla's (a resource pack's own).
rust_edition :: proc(width: u32, height: u32, pixels: []u8) -> O {
    // Ported from Horizon
    return {}
}
    // rust: (fingerprint(width, height, pixels) == VANILLA).then(|| compose(pixels))
}

fingerprint :: proc(width: u32, height: u32, pixels: []u8) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let mut hash = 0xcbf2_9ce4_8422_2325u64;
    // rust: let bytes = width.to_le_bytes().into_iter().chain(height.to_le_bytes());
    // rust: for b in bytes.chain(pixels.iter().copied()) {
    // rust: hash = (hash ^ u64::from(b)).wrapping_mul(0x0100_0000_01b3);
}
    // rust: hash
}

    // rust: type Rgba = [u8; 4];

lum :: proc(p: Rgba) -> u {
    // Ported from Horizon
    return {}
}
    // rust: (u32::from(p[0]) + u32::from(p[1]) + u32::from(p[2])) / 3
}

pixel :: proc(pixels: []u8, x: uint, y: uint) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let i = (y * WIDTH + x) * 4;
    // rust: [pixels[i], pixels[i + 1], pixels[i + 2], pixels[i + 3]]
}

// The texture's shades: the most common colour in each brightness band.
Palette :: struct {
    highlight: Rgba,
    face: Rgba,
    rim: Rgba,
    extrusion: Rgba,
    edge: Rgba,
    outline: Rgba,
    soft: Rgba,
}

    // rust: impl Palette {
sample :: proc(pixels: []u8) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut bands: [HashMap<Rgba, u32>; 7] = Default::default();
    // rust: for &p in pixels.as_chunks::<4>().0 {
    // rust: let band = match (p[3], lum(p)) {
    // rust: (0, _) => continue,
    // rust: (255, 215..) => 0,
    // rust: (255, 170..) => 1,
    // rust: (255, 100..) => 2,
    // rust: (255, 45..) => 3,
    // rust: (255, 20..) => 4,
    // rust: (255, _) => 5,
    // rust: _ => 6,
}
    // rust: *bands[band].entry(p).or_default() += 1;
}
    // rust: let mode = |band: &HashMap<Rgba, u32>, fallback: Rgba| {
    // rust: band.iter()
    // rust: .max_by_key(|&(p, n)| (*n, std::cmp::Reverse(*p)))
    // rust: .map_or(fallback, |(p, _)| *p)
}
    // rust: let outline = mode(&bands[5], [0, 0, 0, 255]);
    // rust: let face = mode(&bands[1], [200, 200, 200, 255]);
    // rust: Self {
    // rust: highlight: mode(&bands[0], face),
    // rust: face,
    // rust: rim: mode(&bands[2], face),
    // rust: extrusion: mode(&bands[3], outline),
    // rust: edge: mode(&bands[4], outline),
    // rust: outline,
    // rust: soft: mode(&bands[6], outline),
}
}
}

// Faces of the new glyphs, positioned in the texture.
glyph_faces :: proc() -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut face = vec![false; WIDTH * HEIGHT];
    // rust: for (i, glyph) in [R, U, S].into_iter().enumerate() {
    // rust: let left = FIRST_FACE + i * (GLYPH_WIDTH + LETTER_GAP);
    // rust: for &[x0, y0, x1, y1] in glyph {
    // rust: for y in FACE_TOP + y0..FACE_TOP + y1 {
    // rust: for x in left + x0..left + x1 {
    // rust: face[y * WIDTH + x] = true;
}
}
}
}
    // rust: face
}

// Where the "T" lifted from "EDITION" goes: one letter gap after the S.
t_left :: proc() -> u {
    // Ported from Horizon
    return {}
}
    // rust: FIRST_FACE + 3 * (GLYPH_WIDTH + LETTER_GAP)
}

// Draw faces within `columns` the way the texture's letters are drawn.
draw_glyphs :: proc(out: []u8, face: ^[bool], palette: ^Palette, columns: Range<uint>) {
}
    // rust: let at = |grid: &[bool], x: isize, y: isize| {
    // rust: (columns.start as isize..columns.end as isize).contains(&x)
    // rust: && (0..HEIGHT as isize).contains(&y)
    // rust: && grid[y as usize * WIDTH + x as usize]
}
    // rust: let mut body = face.to_vec();
    // rust: for y in 0..HEIGHT {
    // rust: for x in columns.clone() {
    // rust: let (xi, yi) = (x as isize, y as isize);
    // rust: body[y * WIDTH + x] |= (1..=EXTRUSION as isize).any(|k| at(face, xi, yi - k));
}
}
    // rust: let reach = OUTLINE as isize + 1;
    // rust: for y in 0..HEIGHT {
    // rust: for x in columns.clone() {
    // rust: let (xi, yi) = (x as isize, y as isize);
    // rust: let colour = if at(face, xi, yi) {
    // rust: if !at(face, xi, yi + 1) {
    // rust: palette.highlight
    // rust: } else if !at(face, xi - 1, yi) || !at(face, xi + 1, yi) {
    // rust: palette.rim
    // rust: } else {
    // rust: palette.face
}
    // rust: } else if at(&body, xi, yi) {
    // rust: if at(face, xi, yi - 1) {
    // rust: palette.rim
    // rust: } else if !at(&body, xi - 1, yi) || !at(&body, xi + 1, yi) || !at(&body, xi, yi + 1)
    // rust: {
    // rust: palette.edge
    // rust: } else {
    // rust: palette.extrusion
}
    // rust: } else {
    // rust: let distance = (-reach..=reach)
    // rust: .flat_map(|dy| (-reach..=reach).map(move |dx| (dx, dy)))
    // rust: .filter(|&(dx, dy)| at(&body, xi + dx, yi + dy))
    // rust: .map(|(dx, dy)| dx.abs().max(dy.abs()))
    // rust: .min();
    // rust: match distance {
    // rust: Some(d) if d <= OUTLINE as isize => palette.outline,
    // rust: Some(_) => palette.soft,
    // rust: None => continue,
}
}
    // rust: put(out, x, y, colour);
}
}
}

// Paint `p` over what is there unless that is more opaque, or as opaque and
// brighter (a letter's body wins over a neighbour's outline).
put :: proc(out: []u8, x: uint, y: uint, p: Rgba) {
}
    // rust: let old = pixel(out, x, y);
    // rust: if (p[3], lum(p)) > (old[3], lum(old)) {
    // rust: out[(y * WIDTH + x) * 4..][..4].copy_from_slice(&p);
}
}

// Every pixel of "EDITION"'s "T": its body, and the outline pixels nearer to
// it than to its neighbours.
t_pixels :: proc(pixels: []u8) -> V {
    // Ported from Horizon
    return {}
}
NONE :: 0
T :: 1
OTHER :: 2
    // rust: let mut owner = vec![NONE; WIDTH * HEIGHT];
    // rust: let mut queue = VecDeque::new();
    // rust: for y in 0..HEIGHT {
    // rust: for x in EDITION_START..WIDTH {
    // rust: let p = pixel(pixels, x, y);
    // rust: if p[3] == 255 && lum(p) >= 30 {
    // rust: owner[y * WIDTH + x] = if (T_BODY.0..=T_BODY.1).contains(&x) {
    // rust: T
    // rust: } else {
    // rust: OTHER
}
    // rust: queue.push_back((x, y));
}
}
}
    // rust: while let Some((x, y)) = queue.pop_front() {
    // rust: let label = owner[y * WIDTH + x];
    // rust: for (dx, dy) in [
    // rust: (-1, -1),
    // rust: (0, -1),
    // rust: (1, -1),
    // rust: (-1, 0),
    // rust: (1, 0),
    // rust: (-1, 1),
    // rust: (0, 1),
    // rust: (1, 1),
    // rust: ] {
    // rust: let (nx, ny) = (x as isize + dx, y as isize + dy);
    // rust: if !(EDITION_START as isize..WIDTH as isize).contains(&nx)
    // rust: || !(0..HEIGHT as isize).contains(&ny)
    // rust: {
    // rust: continue;
}
    // rust: let (nx, ny) = (nx as usize, ny as usize);
    // rust: if owner[ny * WIDTH + nx] == NONE && pixel(pixels, nx, ny)[3] > 0 {
    // rust: owner[ny * WIDTH + nx] = label;
    // rust: queue.push_back((nx, ny));
}
}
}
    // rust: (0..HEIGHT)
    // rust: .flat_map(|y| (EDITION_START..WIDTH).map(move |x| (x, y)))
    // rust: .filter(|&(x, y)| owner[y * WIDTH + x] == T)
    // rust: .collect()
}

// Close the pockets left of "EDITION" that no gap reaches from outside, as
// the texture's letters fill their counters with the outline.
fill_counters :: proc(out: []u8, outline: Rgba) {
}
    // rust: let open = |out: &[u8], x: usize, y: usize| pixel(out, x, y)[3] < 255;
    // rust: let mut seen = vec![false; WIDTH * HEIGHT];
    // rust: let mut queue = VecDeque::new();
    // rust: for y in 0..HEIGHT {
    // rust: for x in 0..EDITION_START {
    // rust: let border = x == 0 || y == 0 || x == EDITION_START - 1 || y == HEIGHT - 1;
    // rust: if border && open(out, x, y) {
    // rust: seen[y * WIDTH + x] = true;
    // rust: queue.push_back((x, y));
}
}
}
    // rust: while let Some((x, y)) = queue.pop_front() {
    // rust: for (dx, dy) in [(-1, 0), (1, 0), (0, -1), (0, 1)] {
    // rust: let (nx, ny) = (x as isize + dx, y as isize + dy);
    // rust: if !(0..EDITION_START as isize).contains(&nx) || !(0..HEIGHT as isize).contains(&ny) {
    // rust: continue;
}
    // rust: let (nx, ny) = (nx as usize, ny as usize);
    // rust: if !seen[ny * WIDTH + nx] && open(out, nx, ny) {
    // rust: seen[ny * WIDTH + nx] = true;
    // rust: queue.push_back((nx, ny));
}
}
}
    // rust: for y in 0..HEIGHT {
    // rust: for x in 0..EDITION_START {
    // rust: if !seen[y * WIDTH + x] && open(out, x, y) {
    // rust: out[(y * WIDTH + x) * 4..][..4].copy_from_slice(&outline);
}
}
}
}

// Give every edge left of "EDITION" the soft rim the texture's outlines have
// (the "T"'s right side shared its outline with the next letter).
soften_edges :: proc(out: []u8, soft: Rgba) {
}
    // rust: let opaque = |out: &[u8], x: isize, y: isize| {
    // rust: (0..EDITION_START as isize).contains(&x)
    // rust: && (0..HEIGHT as isize).contains(&y)
    // rust: && pixel(out, x as usize, y as usize)[3] == 255
}
    // rust: let mut rim = Vec::new();
    // rust: for y in 0..HEIGHT {
    // rust: for x in 0..EDITION_START {
    // rust: let (xi, yi) = (x as isize, y as isize);
    // rust: let near = (-1..=1).any(|dy| (-1..=1).any(|dx| opaque(out, xi + dx, yi + dy)));
    // rust: if pixel(out, x, y)[3] == 0 && near {
    // rust: rim.push((x, y));
}
}
}
    // rust: for (x, y) in rim {
    // rust: out[(y * WIDTH + x) * 4..][..4].copy_from_slice(&soft);
}
}

// "RUST" in place of "JAVA"; `pixels` is a 512x64 RGBA banner laid out as
// vanilla's.
compose :: proc(pixels: []u8) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let palette = Palette::sample(pixels);
    // rust: let mut out = pixels.to_vec();
    // rust: for row in out.as_chunks_mut::<{ WIDTH * 4 }>().0 {
    // rust: row[..EDITION_START * 4].fill(0);
}
    // rust: draw_glyphs(&mut out, &glyph_faces(), &palette, 0..EDITION_START);
    // rust: let left = t_left();
    // rust: for (x, y) in t_pixels(pixels) {
    // rust: put(&mut out, x + left - T_BODY.0, y, pixel(pixels, x, y));
}
    // rust: fill_counters(&mut out, palette.outline);
    // rust: soften_edges(&mut out, palette.soft);
    // rust: out
}

    // rust: mod tests {
//     use super::*;

FACE :: [208, 197, 192, 255]

    // A banner laid out as vanilla's, in made-up colours: every letter a
    // solid block over its vanilla columns, with the font's shading.
stand_in :: proc() -> V {
    // Ported from Horizon
    return {}
}
        // Vanilla's letter bodies (extrusion edge included) by column.
    // rust: let runs = [
    // rust: (4, 97),
    // rust: (101, 144),
    // rust: (147, 190),
    // rust: (208, 249),
    // rust: (256, 296),
    // rust: (303, 330),
    // rust: (335, 376),
    // rust: (381, 411),
    // rust: (413, 507),
    // rust: ];
    // rust: let mut face = vec![false; WIDTH * HEIGHT];
    // rust: for (x0, x1) in runs {
    // rust: for y in FACE_TOP..FACE_TOP + 39 {
    // rust: for x in x0..=x1 {
    // rust: face[y * WIDTH + x] = true;
}
}
}
    // rust: let palette = Palette {
    // rust: highlight: [226, 216, 213, 255],
    // rust: face: FACE,
    // rust: rim: [153, 147, 145, 255],
    // rust: extrusion: [61, 57, 56, 255],
    // rust: edge: [45, 42, 42, 255],
    // rust: outline: [0, 0, 0, 255],
    // rust: soft: [0, 0, 0, 244],
}
    // rust: let mut out = vec![0; WIDTH * HEIGHT * 4];
    // rust: draw_glyphs(&mut out, &face, &palette, 0..WIDTH);
        // A colour only "JAVA" has, to see it go.
    // rust: out[(20 * WIDTH + 30) * 4..][..4].copy_from_slice(&[255, 0, 255, 255]);
    // rust: out
}

columns :: proc(pixels: []u8, range: Range<uint>) -> V {
    // Ported from Horizon
    return {}
}
    // rust: pixels
    // rust: .as_chunks::<{ WIDTH * 4 }>()
    // rust: .0
    // rust: .iter()
    // rust: .flat_map(|row| row[range.start * 4..range.end * 4].to_vec())
    // rust: .collect()
}

    // Outlines left of "EDITION" keep their soft rim all round.
assert_soft_rim :: proc(out: []u8) {
}
    // rust: for y in 1..HEIGHT - 1 {
    // rust: for x in 1..EDITION_START - 1 {
    // rust: if pixel(out, x, y)[3] == 255 {
    // rust: let near = [(x - 1, y), (x + 1, y), (x, y - 1), (x, y + 1)];
    // rust: assert!(
    // rust: near.iter().all(|&(nx, ny)| pixel(out, nx, ny)[3] > 0),
    // rust: "{x},{y}"
    // rust: );
}
}
}
}

rust_replaces_java_and_edition_is_untouched :: proc() {
}
    // rust: let source = stand_in();
    // rust: let out = compose(&source);
    // rust: assert_eq!(out.len(), WIDTH * HEIGHT * 4);
    // rust: assert_eq!(
    // rust: columns(&out, EDITION_START..WIDTH),
    // rust: columns(&source, EDITION_START..WIDTH)
    // rust: );
    // rust: assert!(!out.as_chunks::<4>().0.contains(&[255, 0, 255, 255]));
        // R, U and S: their strokes are faces, their notches and counters not.
    // rust: let lit = |x: usize, y: usize| lum(pixel(&out, x, y)) >= 100;
    // rust: let glyph = |i: usize, x: usize, y: usize| {
    // rust: lit(
    // rust: FIRST_FACE + i * (GLYPH_WIDTH + LETTER_GAP) + x,
    // rust: FACE_TOP + y,
    // rust: )
}
    // rust: for (i, shape) in [R, U, S].into_iter().enumerate() {
    // rust: for &[x0, y0, x1, y1] in shape {
    // rust: assert!(glyph(i, (x0 + x1) / 2, (y0 + y1) / 2), "glyph {i}");
}
}
    // rust: assert!(!glyph(0, 38, 21), "R's notch between bowl and leg");
    // rust: assert!(!glyph(0, 20, 30), "R's open bottom");
    // rust: assert!(!glyph(1, 20, 5), "U's open top");
    // rust: assert!(!glyph(1, 2, 36), "U's rounded corner");
    // rust: assert!(!glyph(2, 2, 22), "S's lower-left notch");
    // rust: assert!(!glyph(2, 38, 17), "S's upper-right notch");
        // The T is EDITION's, moved.
    // rust: let shift = T_BODY.0 - t_left();
    // rust: for y in 0..HEIGHT {
    // rust: for x in T_BODY.0..=T_BODY.1 {
    // rust: let p = pixel(&source, x, y);
    // rust: if p[3] == 255 && lum(p) >= 30 {
    // rust: assert_eq!(pixel(&out, x - shift, y), p, "T at {x},{y}");
}
}
}
    // rust: assert_soft_rim(&out);
        // Nothing below the 14 GUI rows vanilla draws, and the word gap stays open.
    // rust: assert!(out[WIDTH * 55 * 4..].iter().all(|&b| b == 0));
    // rust: let gap = columns(&out, 195..EDITION_START);
    // rust: assert!(gap.as_chunks::<4>().0.iter().all(|p| p[3] == 0));
        // Centred: "RUST" spans "JAVA"'s columns to within a texel.
    // rust: let used = |x: usize| (0..HEIGHT).any(|y| pixel(&out, x, y)[3] > 0);
    // rust: let last = (0..EDITION_START).rev().find(|&x| used(x)).unwrap();
    // rust: assert!(
    // rust: used(0) && (193..=195).contains(&last),
    // rust: "RUST ends at {last}"
    // rust: );
}

only_vanilla_is_rebuilt :: proc() {
}
    // rust: let source = stand_in();
    // rust: assert!(rust_edition(512, 64, &source).is_none());
}

    // Against the prepared vanilla resources when they are present.
prepared_vanilla_edition :: proc() {
}
    // rust: let path = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION)
    // rust: .join("assets/minecraft/textures/gui/title/edition.png");
    // rust: let Ok((w, h, pixels)) = crate::hud::decode(&path) else {
    // rust: return;
}
    // rust: let out = rust_edition(w, h, &pixels).expect("vanilla's edition.png");
    // rust: assert_eq!(
    // rust: columns(&out, EDITION_START..WIDTH),
    // rust: columns(&pixels, EDITION_START..WIDTH)
    // rust: );
    // rust: assert_eq!(Palette::sample(&pixels).face, FACE);
    // rust: assert_soft_rim(&out);
    // rust: let mut edited = pixels.clone();
    // rust: edited[3] ^= 1;
    // rust: assert!(rust_edition(w, h, &edited).is_none());
}
}
