//! Transpiled from Horizon Rust crate
package horizon_client_render_pad_glyph

import "core:fmt"
import "core:mem"
import "core:math"

// A controller button as the player sees it: Horizon's own art where the pad's family has one
// (`assets/horizon/textures/gui/controller/`, which a resource pack can replace), else the label
// printed on the pad, in its colour, on a dark key. Whatever shows a button draws and measures it
// here; `Button::label` stays for plain text and narration.
// use crate::gamepad::{Button, GlyphStyle};
// use crate::hud::{HudAtlas, HudBatch, rgba};
// use crate::pad_cursor;

// The art's height as drawn, in GUI pixels. Its texture is twice that, so it maps pixel for pixel
// at GUI scale 2 and to whole pixels at 4.
DRAWN_HEIGHT :: 16.0
// The clear edge the art has all round.
MARGIN :: 2.0
// How tall a glyph shows, art or key: the text line and 2 above and below it.
HEIGHT :: DRAWN_HEIGHT - 2.0 * MARGIN
// How wide a face button's art shows; a declared button's label leaves it room.
FACE_WIDTH :: 12.0

// A picture of a button in a family (Auto reads as Xbox, as `Button::label` has it). Every family
// has its own file for every button, some of them a copy of another's until theirs is drawn.
Art :: struct {
    family: GlyphStyle,
    button: Button,
    // The atlas sprite: where a pack's own file lands.
    sprite: ^'static str,
    png: ^'static [u8],
}

    // rust: macro_rules! art {
    // rust: ($($family:ident $button:ident $file:literal,)*) => {
    // rust: &[$(Art {
    // rust: family: GlyphStyle::$family,
    // rust: button: Button::$button,
    // rust: sprite: concat!("horizon:gui/controller/", $file),
    // rust: png: include_bytes!(concat!(
    // rust: "../../horizon-client/assets/horizon/textures/gui/controller/",
    // rust: $file,
    // rust: ".png"
    // rust: )),
    // rust: },)*]
}
}

// All the art. A new picture is one line here and its file: a button not listed is text, and a
// picture is measured from its texture, so it can be as wide as it needs.
    // rust: static ART: &[Art] = art![
    // rust: Xbox South "xb_a",
    // rust: Xbox East "xb_b",
    // rust: Xbox West "xb_x",
    // rust: Xbox North "xb_y",
    // rust: Xbox LeftBumper "xb_lb",
    // rust: Xbox RightBumper "xb_rb",
    // rust: Xbox LeftTrigger "xb_lt",
    // rust: Xbox RightTrigger "xb_rt",
    // rust: Xbox Select "xb_view",
    // rust: Xbox Start "xb_menu",
    // rust: Xbox LeftStick "xb_l3",
    // rust: Xbox RightStick "xb_r3",
    // rust: Xbox DPadUp "xb_up",
    // rust: Xbox DPadDown "xb_down",
    // rust: Xbox DPadLeft "xb_left",
    // rust: Xbox DPadRight "xb_right",
    // rust: PlayStation South "psx_cross",
    // rust: PlayStation East "psx_circle",
    // rust: PlayStation West "psx_square",
    // rust: PlayStation North "psx_triangle",
    // rust: PlayStation LeftBumper "psx_l1",
    // rust: PlayStation RightBumper "psx_r1",
    // rust: PlayStation LeftTrigger "psx_l2",
    // rust: PlayStation RightTrigger "psx_r2",
    // rust: PlayStation Select "psx_create",
    // rust: PlayStation Start "psx_options",
    // rust: PlayStation LeftStick "psx_l3",
    // rust: PlayStation RightStick "psx_r3",
    // rust: PlayStation DPadUp "psx_up",
    // rust: PlayStation DPadDown "psx_down",
    // rust: PlayStation DPadLeft "psx_left",
    // rust: PlayStation DPadRight "psx_right",
    // rust: Nintendo South "nx_b",
    // rust: Nintendo East "nx_a",
    // rust: Nintendo West "nx_y",
    // rust: Nintendo North "nx_x",
    // rust: Nintendo LeftBumper "nx_l",
    // rust: Nintendo RightBumper "nx_r",
    // rust: Nintendo LeftTrigger "nx_zl",
    // rust: Nintendo RightTrigger "nx_zr",
    // rust: Nintendo Select "nx_minus",
    // rust: Nintendo Start "nx_plus",
    // rust: Nintendo LeftStick "nx_l3",
    // rust: Nintendo RightStick "nx_r3",
    // rust: Nintendo DPadUp "nx_up",
    // rust: Nintendo DPadDown "nx_down",
    // rust: Nintendo DPadLeft "nx_left",
    // rust: Nintendo DPadRight "nx_right",
    // rust: ];

find :: proc(button: Button, style: GlyphStyle) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let family = match style {
    // rust: GlyphStyle::Auto => GlyphStyle::Xbox,
    // rust: style => style,
}
    // rust: ART.iter()
    // rust: .find(|art| art.family == family && art.button == button)
}

// The sprite of a button in a family, if it has one.
sprite :: proc(button: Button, style: GlyphStyle) -> O {
    // Ported from Horizon
    return {}
}
    // rust: find(button, style).map(|art| art.sprite)
}

// The sprite this atlas can draw for the button; none (the boot screen's atlas) means text.
art :: proc(atlas: ^HudAtlas, button: Button, style: GlyphStyle) -> O {
    // Ported from Horizon
    return {}
}
    // rust: sprite(button, style).filter(|name| atlas.sprites.contains_key(*name))
}

// How wide the art shows: half its texture (IHDR's width, in a PNG's first bytes) less its edge.
// A pack's own texture of another size is drawn in the same place.
art_width :: proc(art: ^Art) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let texels = u32::from_be_bytes([art.png[16], art.png[17], art.png[18], art.png[19]]);
    // rust: texels as f32 / 2.0 - 2.0 * MARGIN
}

// How wide the glyph shows.
width :: proc(atlas: ^HudAtlas, button: Button, style: GlyphStyle) -> f {
    // Ported from Horizon
    return {}
}
    // rust: match find(button, style).filter(|a| atlas.sprites.contains_key(a.sprite)) {
    // rust: Some(art) => art_width(art),
    // rust: None => HudBatch::text_width(atlas, button.label(style)).ceil() + 4.0,
}
}

// What the glyph covers with its label's text at `(x, y)`: `[x, y, w, h]`.
rect :: proc(atlas: ^HudAtlas, button: Button, style: GlyphStyle, x: f32, y: f32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [x - 1.0, y - 2.0, width(atlas, button, style), HEIGHT]
}

// Draw the glyph over the 8 pixel text line at `(x, y)`, filling [`rect`]. A dark key backs text
// only: the art brings its own.
    // rust: pub fn draw(
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: button: Button,
    // rust: style: GlyphStyle,
    // rust: x: f32,
    // rust: y: f32,
    // rust: ) {
    // rust: let [left, top, wide, tall] = rect(atlas, button, style, x, y);
    // rust: if let Some(name) = art(atlas, button, style) {
    // rust: batch.sprite_scaled(
    // rust: atlas,
    // rust: name,
    // rust: left - MARGIN,
    // rust: top - MARGIN,
    // rust: wide + 2.0 * MARGIN,
    // rust: tall + 2.0 * MARGIN,
    // rust: u32::MAX,
    // rust: );
    // rust: } else {
    // rust: let [r, g, b] = button.color(style);
    // rust: batch.fill(atlas, left, top, wide, tall, rgba(40, 40, 40, 255));
    // rust: batch.text(
    // rust: atlas,
    // rust: button.label(style),
    // rust: x + 1.0,
    // rust: y,
    // rust: rgba(r, g, b, 255),
    // rust: false,
    // rust: );
}
}

// Horizon's art for the atlas: each `(sprite, width, height, RGBA texels)`.
images :: proc() -> i {
    // Ported from Horizon
    return {}
}
    // rust: ART.iter()
    // rust: .map(|art| (art.sprite, art.png))
    // rust: .chain([(pad_cursor::SPRITE, pad_cursor::PNG)])
    // rust: .map(|(name, png)| {
    // rust: let (w, h, pixels) = decode(png).expect("Horizon's controller art is PNG");
    // rust: (name.to_owned(), w, h, pixels)
    // rust: })
}

decode :: proc(bytes: []u8) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut decoder = png::Decoder::new(std::io::Cursor::new(bytes));
    // rust: decoder.set_transformations(png::Transformations::EXPAND | png::Transformations::STRIP_16);
    // rust: let mut reader = decoder.read_info().ok()?;
    // rust: let (w, h) = (reader.info().width, reader.info().height);
    // rust: let mut buf = vec![0; reader.output_buffer_size()?];
    // rust: let frame = reader.next_frame(&mut buf).ok()?;
    // rust: let channels = frame.color_type.samples();
    // rust: let pixels = buf
    // rust: .chunks(channels)
    // rust: .take((w * h) as usize)
    // rust: .flat_map(|p| match channels {
    // rust: 4 => [p[0], p[1], p[2], p[3]],
    // rust: 3 => [p[0], p[1], p[2], 255],
    // rust: 2 => [p[0], p[0], p[0], p[1]],
    // rust: _ => [p[0], p[0], p[0], 255],
    // rust: })
    // rust: .collect();
    // rust: Some((w, h, pixels))
}

    // rust: mod tests {
//     use super::*;

atlas :: proc() -> H {
    // Ported from Horizon
    return {}
}
    // rust: HudAtlas::build(std::path::Path::new("/nonexistent/horizon-test-assets")).unwrap()
}

file :: proc(button: Button, style: GlyphStyle) -> O {
    // Ported from Horizon
    return {}
}
    // rust: sprite(button, style).and_then(|name| name.strip_prefix("horizon:gui/controller/"))
}

    // The batch's quads as `[left, top, right, bottom]`.
quads :: proc(batch: ^HudBatch) -> V {
    // Ported from Horizon
    return {}
}
    // rust: batch
    // rust: .vertices
    // rust: .as_chunks::<6>()
    // rust: .0
    // rust: .iter()
    // rust: .map(|quad| {
    // rust: let xs = quad.iter().map(|v| v.pos[0]);
    // rust: let ys = quad.iter().map(|v| v.pos[1]);
    // rust: [
    // rust: xs.clone().fold(f32::MAX, f32::min),
    // rust: ys.clone().fold(f32::MAX, f32::min),
    // rust: xs.fold(f32::MIN, f32::max),
    // rust: ys.fold(f32::MIN, f32::max),
    // rust: ]
    // rust: })
    // rust: .collect()
}

xbox_and_auto_show_the_letters_and_shoulders :: proc() {
}
    // rust: for style in [GlyphStyle::Xbox, GlyphStyle::Auto] {
    // rust: for (button, expected) in [
    // rust: (Button::South, "xb_a"),
    // rust: (Button::East, "xb_b"),
    // rust: (Button::West, "xb_x"),
    // rust: (Button::North, "xb_y"),
    // rust: (Button::LeftBumper, "xb_lb"),
    // rust: (Button::RightBumper, "xb_rb"),
    // rust: (Button::LeftTrigger, "xb_lt"),
    // rust: (Button::RightTrigger, "xb_rt"),
    // rust: (Button::Select, "xb_view"),
    // rust: (Button::Start, "xb_menu"),
    // rust: ] {
    // rust: assert_eq!(file(button, style), Some(expected));
}
}
}

playstation_shows_its_symbols_by_position_and_its_own_shoulders :: proc() {
}
    // rust: let style = GlyphStyle::PlayStation;
    // rust: assert_eq!(file(Button::South, style), Some("psx_cross"));
    // rust: assert_eq!(file(Button::East, style), Some("psx_circle"));
    // rust: assert_eq!(file(Button::West, style), Some("psx_square"));
    // rust: assert_eq!(file(Button::North, style), Some("psx_triangle"));
    // rust: assert_eq!(file(Button::LeftBumper, style), Some("psx_l1"));
    // rust: assert_eq!(file(Button::RightTrigger, style), Some("psx_r2"));
    // rust: assert_eq!(file(Button::Select, style), Some("psx_create"));
}

nintendo_shows_what_its_pad_prints_at_each_position :: proc() {
}
    // rust: let style = GlyphStyle::Nintendo;
    // rust: assert_eq!(file(Button::South, style), Some("nx_b"));
    // rust: assert_eq!(file(Button::East, style), Some("nx_a"));
    // rust: assert_eq!(file(Button::West, style), Some("nx_y"));
    // rust: assert_eq!(file(Button::North, style), Some("nx_x"));
    // rust: assert_eq!(file(Button::LeftTrigger, style), Some("nx_zl"));
    // rust: assert_eq!(file(Button::Start, style), Some("nx_plus"));
}

every_family_has_its_own_file_for_every_button :: proc() {
}
    // rust: for (style, prefix) in [
    // rust: (GlyphStyle::Xbox, "xb_"),
    // rust: (GlyphStyle::PlayStation, "psx_"),
    // rust: (GlyphStyle::Nintendo, "nx_"),
    // rust: ] {
    // rust: for button in Button::ALL {
    // rust: let name = file(button, style).unwrap();
    // rust: assert!(name.starts_with(prefix), "{button:?} {name}");
}
}
}

every_sprite_has_its_texture_at_twice_gui_size :: proc() {
}
    // rust: let images: Vec<_> = images().collect();
    // rust: assert_eq!(images.len(), ART.len() + 1, "the art and the cursor");
    // rust: for (name, w, h, pixels) in &images {
    // rust: assert_eq!(pixels.len(), (w * h * 4) as usize, "{name}");
    // rust: assert_eq!(*h as f32, DRAWN_HEIGHT * 2.0, "{name}");
}
    // rust: for art in ART {
    // rust: let (_, w, ..) = images.iter().find(|i| i.0 == art.sprite).unwrap();
    // rust: assert_eq!(art_width(art), *w as f32 / 2.0 - 4.0, "{}", art.sprite);
}
}

no_button_has_two_pictures_in_a_family :: proc() {
}
    // rust: for (i, art) in ART.iter().enumerate() {
    // rust: assert!(
    // rust: !ART[..i]
    // rust: .iter()
    // rust: .any(|a| a.family == art.family && a.button == art.button),
    // rust: "{}",
    // rust: art.sprite
    // rust: );
}
}

art_measures_from_its_shape_and_text_from_its_label :: proc() {
}
    // rust: let atlas = atlas();
    // rust: assert_eq!(width(&atlas, Button::South, GlyphStyle::Xbox), 12.0);
    // rust: assert_eq!(width(&atlas, Button::LeftBumper, GlyphStyle::Xbox), 20.0);
    // rust: assert_eq!(
    // rust: width(&atlas, Button::LeftBumper, GlyphStyle::PlayStation),
    // rust: 20.0
    // rust: );
    // rust: assert_eq!(width(&atlas, Button::DPadUp, GlyphStyle::Nintendo), 12.0);
    // rust: let mut no_art = atlas;
    // rust: no_art
    // rust: .sprites
    // rust: .remove(sprite(Button::LeftTrigger, GlyphStyle::Nintendo).unwrap());
    // rust: let label = HudBatch::text_width(&no_art, "ZL").ceil() + 4.0;
    // rust: assert_eq!(
    // rust: width(&no_art, Button::LeftTrigger, GlyphStyle::Nintendo),
    // rust: label
    // rust: );
}

an_atlas_without_the_art_falls_back_to_text :: proc() {
}
    // rust: let mut atlas = atlas();
    // rust: atlas
    // rust: .sprites
    // rust: .remove(sprite(Button::South, GlyphStyle::Xbox).unwrap());
    // rust: assert_eq!(art(&atlas, Button::South, GlyphStyle::Xbox), None);
    // rust: let label = HudBatch::text_width(&atlas, "A").ceil() + 4.0;
    // rust: assert_eq!(width(&atlas, Button::South, GlyphStyle::Xbox), label);
}

art_is_one_quad_centred_on_the_text_line_with_no_key_behind_it :: proc() {
}
    // rust: let atlas = atlas();
    // rust: let mut batch = HudBatch::new([640, 480]);
    // rust: draw(
    // rust: &mut batch,
    // rust: &atlas,
    // rust: Button::South,
    // rust: GlyphStyle::Xbox,
    // rust: 10.0,
    // rust: 20.0,
    // rust: );
    // rust: assert_eq!(quads(&batch), vec![[7.0, 16.0, 23.0, 32.0]]);
    // rust: let mut batch = HudBatch::new([640, 480]);
    // rust: draw(
    // rust: &mut batch,
    // rust: &atlas,
    // rust: Button::LeftBumper,
    // rust: GlyphStyle::Xbox,
    // rust: 10.0,
    // rust: 20.0,
    // rust: );
    // rust: assert_eq!(quads(&batch), vec![[7.0, 16.0, 31.0, 32.0]]);
}

text_sits_on_a_key_covering_what_rect_says :: proc() {
}
    // rust: let mut atlas = atlas();
    // rust: let style = GlyphStyle::Nintendo;
    // rust: atlas.sprites.remove(sprite(Button::South, style).unwrap());
    // rust: let mut batch = HudBatch::new([640, 480]);
    // rust: draw(&mut batch, &atlas, Button::South, style, 10.0, 20.0);
    // rust: let [x, y, w, h] = rect(&atlas, Button::South, style, 10.0, 20.0);
    // rust: assert_eq!(quads(&batch)[0], [x, y, x + w, y + h]);
}
}
