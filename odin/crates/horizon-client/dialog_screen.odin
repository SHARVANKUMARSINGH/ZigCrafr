//! Transpiled from Horizon Rust crate
package horizon_client_dialog_screen

import "core:fmt"
import "core:mem"
import "core:math"

// `DialogScreen` and its kinds (`SimpleDialogScreen`, `MultiButtonDialogScreen`):
// where a server dialog's title, body, inputs and buttons go in a
// `HeaderAndFooterLayout` (a 33 high header, the body in a `ScrollableLayout`,
// the footer), and the `WaitingForResponseScreen` an answer can leave open.
// use crate::{
    // rust: dialog::{Body, Control, Dialog, Kind},
    // rust: font::Font,
    // rust: text::{Style, Text},
}

// `ActiveTextCollector.ClickableStyleFinder.accept`: the style under a drawn
// message glyph, using the same visual order and advances as rendering.
    // rust: pub fn line_style_at(
    // rust: font: &Font,
    // rust: text: &Text,
    // rust: x: f32,
    // rust: y: f32,
    // rust: cursor: (f32, f32),
    // rust: ) -> Option<Style> {
    // rust: let mut left = cursor.0 - x;
    // rust: if left < 0.0 || !(0.0..9.0).contains(&(cursor.1 - y)) {
    // rust: return None;
}
    // rust: let text = text.resolve_legacy();
    // rust: let visual = crate::bidi::visual(&text);
    // rust: for (c, style) in visual.chars() {
    // rust: left -= font.advance(c, style);
    // rust: if left < 0.0 {
    // rust: return Some(style.clone());
}
}
    // rust: None
}

// `HeaderAndFooterLayout.DEFAULT_HEADER_AND_FOOTER_HEIGHT`.
BAR :: 33.0
// `Checkbox.getBoxSize`.
BOX :: 17.0
// `DialogScreen.WARNING_BUTTON_SPRITES`: normal, disabled, highlighted.
    // rust: pub const WARNING_SPRITES: [&str; 3] = [
    // rust: "gui/sprites/dialog/warning_button",
    // rust: "gui/sprites/dialog/warning_button_disabled",
    // rust: "gui/sprites/dialog/warning_button_highlighted",
    // rust: ];

// One drawn piece; `y` is from the top of the body (before it scrolls) for
// the body's parts, from the top of the screen for the footer's.
Part :: enum {
    // A line of text and where it starts.
    Line(Text, f32, f32),
    // A text input's box.
    Field { input: usize, rect: [f32; 4] },
    // A boolean input: the box, its label right of it.
    Check { input: usize, rect: [f32; 4] },
    // A button of `Dialog::buttons`.
    Button { index: usize, rect: [f32; 4] },
    // A single option input's cycle button.
    Cycle { input: usize, rect: [f32; 4] },
    // A number range input's slider.
    Slider { input: usize, rect: [f32; 4] },
    // An item body's widget; `body` indexes `Dialog::body`.
    Item { body: usize, rect: [f32; 4] },
}
    // rust: impl Part {
    // The part moved by `(dx, dy)`.
moved :: proc(self: ^Self, dx: f32, dy: f32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Line(t, x, y) => Self::Line(t, x + dx, y + dy),
    // rust: Self::Field { input, rect } => Self::Field {
    // rust: input,
    // rust: rect: shift(rect, dx, dy),
    // rust: },
    // rust: Self::Check { input, rect } => Self::Check {
    // rust: input,
    // rust: rect: shift(rect, dx, dy),
    // rust: },
    // rust: Self::Button { index, rect } => Self::Button {
    // rust: index,
    // rust: rect: shift(rect, dx, dy),
    // rust: },
    // rust: Self::Cycle { input, rect } => Self::Cycle {
    // rust: input,
    // rust: rect: shift(rect, dx, dy),
    // rust: },
    // rust: Self::Slider { input, rect } => Self::Slider {
    // rust: input,
    // rust: rect: shift(rect, dx, dy),
    // rust: },
    // rust: Self::Item { body, rect } => Self::Item {
    // rust: body,
    // rust: rect: shift(rect, dx, dy),
    // rust: },
}
}
}

Layout :: struct {
    // The title and where it is drawn.
    title: (f32,
    warning: [f32,
    // The body's visible area (`ScrollableLayout`'s container): x, y, w, h.
    area: [f32,
    // The body's full height: more than the area's scrolls.
    content: f32,
    body: [dynamic]Part,
    footer: [dynamic]Part,
}

// A laid-out element of a `LinearLayout` before it is placed.
Element :: struct {
    w: f32,
    h: f32,
    parts: [dynamic]Part,
}
    // rust: impl Element {
    // Its parts moved to `(x, y)`.
at :: proc(self: ^Self, x: f32, y: f32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.parts.into_iter().map(move |p| p.moved(x, y))
}
}
shift :: proc(h]: [f32; 4], dx: f32, dy: f32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [x + dx, y + dy, w, h]
}
// `FrameLayout.alignInDimension` at 0.5: the offset that centres `inner`.
centre :: proc(outer: f32, inner: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: ((outer - inner) * 0.5).trunc()
}

// `FocusableTextWidget` with the body's settings: `width` wide, the text
// wrapped to `width - 8` and centred, 4 of padding all round.
message :: proc(font: ^Font, contents: ^Text, width: f32) -> E {
    // Ported from Horizon
    return {}
}
    // rust: let lines = font.split_lines(contents, width - 8.0);
    // rust: let mid = (width / 2.0).trunc();
    // rust: let parts = lines
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: .map(|(i, (line, _))| {
    // rust: let x = mid - (font.width_text(&line) / 2.0).trunc();
    // rust: Part::Line(line, x, 4.0 + 9.0 * i as f32)
    // rust: })
    // rust: .collect::<Vec<_>>();
    // rust: Element {
    // rust: w: width,
    // rust: h: 9.0 * parts.len() as f32 + 8.0,
    // rust: parts,
}
}

// `DialogBodyHandlers.ItemHandler`: the item widget, with its description 2
// to the right of it, both centred on each other vertically.
    // rust: fn item(
    // rust: font: &Font,
    // rust: body: usize,
    // rust: description: Option<&(Text, i32)>,
    // rust: (w, h): (f32, f32),
    // rust: ) -> Element {
    // rust: let widget = |rect_h: f32, y: f32| Part::Item {
    // rust: body,
    // rust: rect: [0.0, y, w, rect_h],
}
    // rust: let Some((contents, width)) = description else {
    // rust: return Element {
    // rust: w,
    // rust: h,
    // rust: parts: vec![widget(h, 0.0)],
}
}
    // rust: let text = message(font, contents, *width as f32);
    // rust: let height = h.max(text.h);
    // rust: let mut parts = vec![widget(h, centre(height, h))];
    // rust: parts.extend(
    // rust: text.parts
    // rust: .into_iter()
    // rust: .map(|p| p.moved(w + 2.0, centre(height, text.h))),
    // rust: );
    // rust: Element {
    // rust: w: w + 2.0 + text.w,
    // rust: h: height,
    // rust: parts,
}
}

// `TextInputHandler.addControl`: the 20 high `EditBox`, or the
// `MultiLineEditBox` of the options' height, by default as tall as their most
// lines (4 without a limit) need, at most 512.
text_height :: proc(multiline: Maybe((Option<i32)) {
}
    // rust: match multiline {
    // rust: None => 20.0,
    // rust: Some((max_lines, height)) => {
    // rust: height.unwrap_or_else(|| (9 * max_lines.unwrap_or(4) + 8).min(512)) as f32
}
}
}

// `InputControlHandlers`: the control for input `i`.
input :: proc(font: ^Font, i: uint, control: ^Control) -> E {
    // Ported from Horizon
    return {}
}
    // rust: match control {
    // rust: Control::Text {
    // rust: width,
    // rust: label,
    // rust: label_visible,
    // rust: multiline,
    // rust: ..
    // rust: } => {
    // rust: let w = *width as f32;
    // rust: let h = text_height(*multiline);
    // rust: if !label_visible {
    // rust: return Element {
    // rust: w,
    // rust: h,
    // rust: parts: vec![Part::Field {
    // rust: input: i,
    // rust: rect: [0.0, 0.0, w, h],
    // rust: }],
}
}
            // CommonLayouts.labeledElement: the label, 4 below it the box,
            // both on the left. The label is a plain StringWidget: it has no
            // click handler, so a click event in it does nothing.
    // rust: let mut shown = label.clone();
    // rust: for span in &mut shown.spans {
    // rust: span.style.click = None;
}
    // rust: Element {
    // rust: w: w.max(font.width_text(label)),
    // rust: h: 9.0 + 4.0 + h,
    // rust: parts: vec![
    // rust: Part::Line(shown, 0.0, 0.0),
    // rust: Part::Field {
    // rust: input: i,
    // rust: rect: [0.0, 13.0, w, h],
    // rust: },
    // rust: ],
}
}
    // rust: Control::Boolean { label, .. } => {
    // rust: let w = BOX + 4.0 + font.width_text(label);
    // rust: Element {
    // rust: w,
    // rust: h: BOX,
    // rust: parts: vec![Part::Check {
    // rust: input: i,
    // rust: rect: [0.0, 0.0, w, BOX],
    // rust: }],
}
}
        // CycleButton and AbstractSliderButton: one 20 high button whose
        // message holds the label.
    // rust: Control::SingleOption { width, .. } => Element {
    // rust: w: *width as f32,
    // rust: h: 20.0,
    // rust: parts: vec![Part::Cycle {
    // rust: input: i,
    // rust: rect: [0.0, 0.0, *width as f32, 20.0],
    // rust: }],
    // rust: },
    // rust: Control::NumberRange { width, .. } => Element {
    // rust: w: *width as f32,
    // rust: h: 20.0,
    // rust: parts: vec![Part::Slider {
    // rust: input: i,
    // rust: rect: [0.0, 0.0, *width as f32, 20.0],
    // rust: }],
    // rust: },
}
}

// `DialogScreen.packControlsIntoColumns`: full rows in a grid 2 apart, what
// is left in a centred row under them.
columns :: proc(widths: ^[f32], columns: uint, first: uint) -> E {
    // Ported from Horizon
    return {}
}
    // rust: let columns = columns.max(1);
    // rust: let full = widths.len() / columns * columns;
    // rust: let row_width = |ws: &[f32]| ws.iter().sum::<f32>() + 2.0 * (ws.len().max(1) - 1) as f32;
    // rust: let mut col = vec![0.0f32; columns];
    // rust: for (i, w) in widths[..full].iter().enumerate() {
    // rust: col[i % columns] = col[i % columns].max(*w);
}
    // rust: let last = &widths[full..];
    // rust: if !last.is_empty() {
        // GridLayout spreads a cell over every column it spans (Divisor).
    // rust: let spread = row_width(last) - 2.0 * (columns - 1) as f32;
    // rust: let (each, extra) = ((spread / columns as f32).floor(), spread % columns as f32);
    // rust: for (c, w) in col.iter_mut().enumerate() {
    // rust: *w = w.max(each + f32::from(u8::from((c as f32) < extra)));
}
}
    // rust: let x_of = |c: usize| col[..c].iter().sum::<f32>() + 2.0 * c as f32;
    // rust: let mut parts = Vec::new();
    // rust: for (i, w) in widths[..full].iter().enumerate() {
    // rust: let (r, c) = (i / columns, i % columns);
    // rust: parts.push(Part::Button {
    // rust: index: first + i,
    // rust: rect: [x_of(c) + centre(col[c], *w), 22.0 * r as f32, *w, 20.0],
    // rust: });
}
    // rust: let width = x_of(columns - 1) + col[columns - 1];
    // rust: if !last.is_empty() {
    // rust: let y = 22.0 * (full / columns) as f32;
    // rust: let mut x = centre(width, row_width(last));
    // rust: for (i, w) in last.iter().enumerate() {
    // rust: parts.push(Part::Button {
    // rust: index: first + full + i,
    // rust: rect: [x, y, *w, 20.0],
    // rust: });
    // rust: x += w + 2.0;
}
}
    // rust: let rows = full / columns + usize::from(!last.is_empty());
    // rust: Element {
    // rust: w: width,
    // rust: h: (22.0 * rows as f32 - 2.0).max(0.0),
    // rust: parts,
}
}

    // rust: impl Layout {
    // `DialogScreen.init` and `repositionElements` on a `w` by `h` screen.
new :: proc(dialog: ^Dialog, font: ^Font) {
}
        // The header: the title, 10 right of it the warning button, both
        // centred together.
    // rust: let tw = font.width_text(&dialog.title);
    // rust: let (hx, hy) = (centre(w, tw + 30.0), centre(BAR, 20.0));
    // rust: let title = (hx, hy + centre(20.0, 9.0));
    // rust: let warning = [hx + tw + 10.0, hy, 20.0, 20.0];

    // rust: let mut elements: Vec<Element> = dialog
    // rust: .body
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, b)| match b {
    // rust: Body::Message { contents, width } => message(font, contents, *width as f32),
    // rust: Body::Item {
    // rust: description,
    // rust: width,
    // rust: height,
    // rust: ..
    // rust: } => item(
    // rust: font,
    // rust: i,
    // rust: description.as_ref(),
    // rust: (*width as f32, *height as f32),
    // rust: ),
    // rust: })
    // rust: .collect();
    // rust: elements.extend(
    // rust: dialog
    // rust: .inputs
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, input_)| input(font, i, &input_.control)),
    // rust: );
    // rust: let buttons = dialog.buttons();
    // rust: let (listed, footer_buttons, footer_h) = match &dialog.kind {
    // rust: Kind::MultiAction {
    // rust: exit, columns: n, ..
}
    // rust: | Kind::DialogList {
    // rust: exit, columns: n, ..
    // rust: } => {
    // rust: let listed = buttons.len() - usize::from(exit.is_some());
    // rust: let widths: Vec<f32> = buttons[..listed].iter().map(|b| b.width as f32).collect();
    // rust: elements.push(columns(&widths, *n as usize, 0));
                // ButtonListDialogScreen: the exit button in the footer, else a 5 high one.
    // rust: let footer = exit.as_ref().map(|_| listed).into_iter().collect();
    // rust: (listed, footer, if exit.is_some() { BAR } else { 5.0 })
}
    // rust: Kind::ServerLinks { exit, .. } => {
    // rust: let footer = exit.as_ref().map(|_| 0).into_iter().collect();
    // rust: (0, footer, if exit.is_some() { BAR } else { 5.0 })
}
            // SimpleDialogScreen: the buttons side by side, 8 apart.
    // rust: Kind::Notice(_) | Kind::Confirmation { .. } => {
    // rust: (0, (0..buttons.len()).collect::<Vec<_>>(), BAR)
}
}
    // rust: debug_assert!(listed + footer_buttons.len() <= buttons.len());

        // The body: a column 10 apart, each element centred in it.
    // rust: let body_w = elements.iter().map(|e| e.w).fold(0.0, f32::max);
    // rust: let content = elements.iter().map(|e| e.h).sum::<f32>()
    // rust: + 10.0 * elements.len().saturating_sub(1) as f32;
        // ScrollableLayout: 10 each side for the scrollbar (ReserveStrategy.BOTH),
        // no higher than what the header and footer leave.
    // rust: let area_w = body_w + 20.0;
    // rust: let area_h = content.min(h - BAR - footer_h).max(0.0);
    // rust: let area_y = (BAR + 30.0).min(h - footer_h - area_h);
    // rust: let area_x = centre(w, area_w);
    // rust: let mut body = Vec::new();
    // rust: let mut y = 0.0;
    // rust: for e in elements {
    // rust: let (x, eh) = (area_x + 10.0 + centre(body_w, e.w), e.h);
    // rust: body.extend(e.at(x, y));
    // rust: y += eh + 10.0;
}

    // rust: let widths: Vec<f32> = footer_buttons
    // rust: .iter()
    // rust: .map(|&i| buttons[i].width as f32)
    // rust: .collect();
    // rust: let row = widths.iter().sum::<f32>() + 8.0 * widths.len().saturating_sub(1) as f32;
    // rust: let (mut x, fy) = (centre(w, row), h - footer_h + centre(footer_h, 20.0));
    // rust: let mut footer = Vec::new();
    // rust: for (&i, bw) in footer_buttons.iter().zip(&widths) {
    // rust: footer.push(Part::Button {
    // rust: index: i,
    // rust: rect: [x, fy, *bw, 20.0],
    // rust: });
    // rust: x += bw + 8.0;
}
    // rust: Self {
    // rust: title,
    // rust: warning: Self::in_bounds(warning, w, h),
    // rust: area: [area_x, area_y, area_w, area_h],
    // rust: content,
    // rust: body,
    // rust: footer,
}
}
    // `makeSureWarningButtonIsInBounds`.
in_bounds :: proc(r: [f32; 4], w: f32, h: f32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: if r[0] < 0.0 || r[1] < 0.0 || r[0] > w - 20.0 || r[1] > h - 20.0 {
    // rust: [(w - 40.0).max(0.0), 5.0f32.min(h), 20.0, 20.0]
    // rust: } else {
    // rust: r
}
}
    // Every part where it is drawn with the body scrolled by `scroll`, and
    // whether it is in the body (clipped to its area).
placed :: proc(self: ^Self, scroll: f32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let dy = self.area[1] - scroll;
    // rust: let body = self
    // rust: .body
    // rust: .iter()
    // rust: .map(move |p| (p.clone().moved(0.0, dy), true));
    // rust: body.chain(self.footer.iter().map(|p| (p.clone(), false)))
}
}

// `WaitingForResponseScreen`: its Back button's label after `ticks`, and
// whether it shows and works (it shows after a second, works after five).
waiting_button :: proc(ticks: u32) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let seconds = (ticks / 20).min(5);
    // rust: let label = match seconds {
    // rust: 0 => Text::literal(""),
    // rust: 5 => Text::translate("gui.back", &[]),
    // rust: s => Text::translate(
    // rust: "gui.waitingForResponse.button.inactive",
    // rust: &[Text::literal((5 - s).to_string())],
    // rust: ),
}
    // rust: (label, seconds >= 1, seconds == 5)
}

    // rust: mod tests {
//     use super::*;

message_hit_testing_respects_sprite_advances_and_glyph_bounds :: proc() {
}
//         use crate::{component, hud::Rect, text::ClickEvent};
    // rust: let font = Font::load(
    // rust: std::path::Path::new("/nonexistent-horizon-dialog-test-resources"),
    // rust: &std::collections::HashMap::new(),
    // rust: &[],
    // rust: (1, 1),
    // rust: (0, 0),
    // rust: Rect {
    // rust: u0: 0.0,
    // rust: v0: 0.0,
    // rust: u1: 1.0,
    // rust: v1: 1.0,
    // rust: w: 1,
    // rust: h: 1,
    // rust: },
    // rust: );
    // rust: let text = component::to_text(
    // rust: &serde_json::json!([
    // rust: {"object": "atlas", "sprite": "minecraft:item/potion"},
    // rust: {"object": "atlas", "sprite": "minecraft:item/potion", "click_event": {
    // rust: "action": "custom", "id": "test:shop"
    // rust: }},
    // rust: {"object": "atlas", "sprite": "minecraft:item/potion"},
    // rust: ]),
    // rust: &mut |_| Text::empty(),
    // rust: );
    // rust: let style = |x, y| line_style_at(&font, &text, 10.0, 20.0, (x, y));
    // rust: assert!(style(9.9, 20.0).is_none());
    // rust: assert_eq!(style(17.9, 20.0).unwrap().click, None);
    // rust: for x in [18.0, 21.0, 25.9] {
    // rust: assert_eq!(
    // rust: style(x, 24.0).unwrap().click,
    // rust: Some(ClickEvent::Custom {
    // rust: id: "test:shop".into(),
    // rust: payload: None,
    // rust: })
    // rust: );
}
    // rust: assert_eq!(style(26.0, 20.0).unwrap().click, None);
    // rust: assert!(style(34.0, 20.0).is_none());
    // rust: assert!(style(21.0, 19.9).is_none());
    // rust: assert!(style(21.0, 29.0).is_none());
}

grids_pack_full_rows_and_centre_the_rest :: proc() {
}
        // AuthMe's two buttons: one row, 2 apart.
    // rust: let two = columns(&[150.0, 150.0], 2, 0);
    // rust: assert_eq!((two.w, two.h), (302.0, 20.0));
        // Three in two columns: the third alone, centred under them.
    // rust: let three = columns(&[150.0, 150.0, 150.0], 2, 0);
    // rust: assert_eq!((three.w, three.h), (302.0, 42.0));
    // rust: assert_eq!(
    // rust: three.parts[2],
    // rust: Part::Button {
    // rust: index: 2,
    // rust: rect: [76.0, 22.0, 150.0, 20.0]
}
    // rust: );
        // One in two columns spreads over both.
    // rust: let one = columns(&[100.0], 2, 0);
    // rust: assert_eq!(one.w, 100.0);
}

a_multiline_input_is_as_tall_as_its_lines_or_its_height :: proc() {
}
    // rust: assert_eq!(text_height(None), 20.0);
        // No options: four lines and the padding.
    // rust: assert_eq!(text_height(Some((None, None))), 44.0);
    // rust: assert_eq!(text_height(Some((Some(10), None))), 98.0);
        // Never over 512; a height wins over the lines.
    // rust: assert_eq!(text_height(Some((Some(100), None))), 512.0);
    // rust: assert_eq!(text_height(Some((Some(2), Some(70)))), 70.0);
}

the_waiting_screens_button_counts_down :: proc() {
}
    // rust: assert!(!waiting_button(0).1);
    // rust: assert_eq!(
    // rust: waiting_button(20).0,
    // rust: Text::translate(
    // rust: "gui.waitingForResponse.button.inactive",
    // rust: &[Text::literal("4")]
    // rust: )
    // rust: );
    // rust: assert_eq!(
    // rust: waiting_button(100),
    // rust: (Text::translate("gui.back", &[]), true, true)
    // rust: );
}
}
