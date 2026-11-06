//! Transpiled from Horizon Rust crate
package horizon_client_experiments

import "core:fmt"
import "core:mem"
import "core:math"

// CreateWorldScreen's Experiments screen (`ExperimentsScreen`): the feature
// packs the jar ships, each with an on/off switch, under the red warning that
// they cannot be turned off after the world is created.
//
// The layout follows vanilla's: `HeaderAndFooterLayout` (a 33-pixel title
// header and footer, the contents starting 30 pixels under the header), a
// `MultiLineTextWidget` warning 310 wide, then a `SwitchGrid` 299 wide with
// its information underneath each switch.
// use crate::{
    // rust: font::Font,
    // rust: hud::{HudAtlas, HudBatch},
    // rust: text::{Text, named_color},
    // rust: ui,
}

// `HeaderAndFooterLayout`'s header and footer.
HEADER :: 33.0
FOOTER :: 33.0
// `SwitchGrid.builder(299)`, its `DEFAULT_SWITCH_BUTTON_WIDTH` and the
// information's maximum width (`width - paddingLeft - buttonWidth`).
GRID :: 299.0
BUTTON :: 44.0
INFO :: 266.0 - 11.0
// `ExperimentsScreen.MAIN_CONTENT_WIDTH`: the warning's maximum width.
WARNING :: 310.0
// `withInfoUnderneath(2, true)`: two rows of information, always that tall.
MAX_INFO_ROWS :: 2
// `withRowSpacing(4)`.
ROW_SPACING :: 4.0
// One switch and its two information rows, `rowSpacing` included.
FLAG_HEIGHT :: 20.0 + ROW_SPACING + (9.0 * MAX_INFO_ROWS )

// One feature pack: `SwitchGrid.addSwitch(...).withInfo(description)`.
Flag :: struct {
    id: string,
    title: Text,
    description: Text,
    enabled: bool,
}

// What a press asked for.
Outcome :: enum {
    // `gui.done`: the switches go to the selection.
    Done,
    // `gui.cancel` or Escape.
    Cancel,
}

// A press on the screen.
Click :: enum {
    // The i-th switch.
    Switch(usize),
    Outcome(Outcome),
}

// The screen.
ExperimentsScreen :: struct {
    flags: [dynamic]Flag,
    in_world: bool,
}
    // rust: impl ExperimentsScreen {
new :: proc(flags: [dynamic]Flag) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: flags,
    // rust: in_world: false,
}
}
    // `HeaderAndFooterLayout.arrangeElements`: the contents start at the
    // header's height plus 30.
content_top :: proc() -> f {
    // Ported from Horizon
    return {}
}
    // rust: HEADER + 30.0
}
    // The warning, red (`ExperimentsScreen.INFO`).
warning :: proc(self: ^Self) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Text::translate("selectWorld.experiments.info", &[])
    // rust: .with_color(named_color("red").unwrap_or(0xFF5555))
}
    // The warning's lines (`MultiLineTextWidget.setMaxWidth(310)`).
warning_lines :: proc(self: ^Self, font: ^Font) -> V {
    // Ported from Horizon
    return {}
}
    // rust: font.split_lines(&self.warning(), WARNING)
    // rust: .into_iter()
    // rust: .map(|(line, _)| line)
    // rust: .collect()
}
    // Where the `SwitchGrid` starts: under the warning and its 15-pixel
    // bottom padding.
grid_top :: proc(self: ^Self, font: ^Font) -> f {
    // Ported from Horizon
    return {}
}
    // rust: Self::content_top() + 9.0 * self.warning_lines(font).len() as f32 + 15.0
}
grid_left :: proc(w: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: ((w - GRID) / 2.0).trunc()
}
    // The i-th switch's button (`alignHorizontallyRight` in the 44-wide
    // column).
switch_rect :: proc(self: ^Self, font: ^Font, w: f32, i: uint) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let top = self.grid_top(font) + i as f32 * FLAG_HEIGHT;
    // rust: (Self::grid_left(w) + GRID - BUTTON, top)
}
    // A press: a switch, Done (`gui.done`) or Cancel (`gui.cancel`).
click :: proc(self: ^Self, atlas: ^HudAtlas) {
}
    // rust: for i in 0..self.flags.len() {
    // rust: let (bx, by) = self.switch_rect(&atlas.font, size.0, i);
    // rust: if ui::hovered((x, y), bx, by, BUTTON, 20.0) {
    // rust: return Some(Click::Switch(i));
}
}
    // rust: let [(dx, dy), (cx, cy)] = footer(size.0, size.1);
    // rust: if ui::hovered((x, y), dx, dy, 150.0, 20.0) {
    // rust: return Some(Click::Outcome(Outcome::Done));
}
    // rust: if ui::hovered((x, y), cx, cy, 150.0, 20.0) {
    // rust: return Some(Click::Outcome(Outcome::Cancel));
}
    // rust: None
}
draw :: proc(self: ^Self, batch: ^HudBatch, atlas: ^HudAtlas, cursor: (f32) {
}
    // rust: let (w, h) = (batch.width, batch.height);
    // rust: ui::menu_background(batch, atlas, 0.0, 0.0, w, h, self.in_world);
    // rust: let font = &atlas.font;
        // `addTitleHeader`: the title centred in the header's 33 pixels.
    // rust: let title = Text::translate("selectWorld.experiments", &[]);
    // rust: let tw = font.width_text(&title);
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: &title,
    // rust: ((w - tw) / 2.0).trunc(),
    // rust: 15.0,
    // rust: u32::MAX,
    // rust: true,
    // rust: );
        // The warning, centred as a 310-wide block.
    // rust: let mut y = Self::content_top();
    // rust: for line in self.warning_lines(font) {
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: &line,
    // rust: ((w - WARNING) / 2.0).trunc(),
    // rust: y,
    // rust: u32::MAX,
    // rust: true,
    // rust: );
    // rust: y += 9.0;
}
        // `SwitchGrid`: the label left, the switch right, the information
        // grey underneath.
    // rust: let left = Self::grid_left(w);
    // rust: let gray = named_color("gray").unwrap_or(0xAAAAAA);
    // rust: for (i, flag) in self.flags.iter().enumerate() {
    // rust: let (bx, by) = self.switch_rect(font, w, i);
    // rust: let label_y = by + 5.0;
    // rust: batch.text_styled(atlas, &flag.title, left, label_y, u32::MAX, true);
    // rust: let hover = ui::hovered(cursor, bx, by, BUTTON, 20.0);
    // rust: let value = Text::translate(
    // rust: if flag.enabled {
    // rust: "options.on"
    // rust: } else {
    // rust: "options.off"
    // rust: },
    // rust: &[],
    // rust: );
    // rust: ui::button(batch, atlas, bx, by, BUTTON, 20.0, &value, true, hover);
    // rust: let mut info_y = by + 20.0;
    // rust: for line in font.split_lines(&flag.description.clone().with_color(gray), INFO) {
    // rust: batch.text_styled(atlas, &line.0, left, info_y, u32::MAX, true);
    // rust: info_y += 9.0;
}
}
    // rust: let [(dx, dy), (cx, cy)] = footer(w, h);
    // rust: for (action, fx, fy, key) in [
    // rust: (crate::widgets::Action::Done, dx, dy, "gui.done"),
    // rust: (crate::widgets::Action::Cancel, cx, cy, "gui.cancel"),
    // rust: ] {
    // rust: let hover = ui::hovered(cursor, fx, fy, 150.0, 20.0);
    // rust: ui::action_button(
    // rust: batch,
    // rust: atlas,
    // rust: action,
    // rust: fx,
    // rust: fy,
    // rust: 150.0,
    // rust: 20.0,
    // rust: &Text::translate(key, &[]),
    // rust: true,
    // rust: hover,
    // rust: );
}
}
}

// `HeaderAndFooterLayout`: two 150-wide buttons 8 apart in the 33-pixel
// footer.
footer :: proc(w: f32, h: f32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let x = ((w - 308.0) / 2.0).trunc();
    // rust: let y = h - FOOTER + 6.0;
    // rust: [(x, y), (x + 158.0, y)]
}

// `ExperimentsScreen.init`: every feature pack the jar ships under
// `data/minecraft/datapacks`, switched on when `enabled` holds its id.
repository_flags :: proc(resources: ^std::path::Path, enabled: ^[string]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: crate::datapack::feature_packs(resources)
    // rust: .into_iter()
    // rust: .map(|pack| {
    // rust: let id = pack.id.clone();
            // `ExperimentsScreen.getHumanReadableTitle`.
    // rust: let name = format!("dataPack.{id}.name");
    // rust: let title = if crate::lang::has(&name) {
    // rust: Text::translate(&name, &[])
    // rust: } else {
    // rust: Text::literal(id.clone())
}
    // rust: Flag {
    // rust: enabled: enabled.contains(&id),
    // rust: description: Text::translate(&format!("dataPack.{id}.description"), &[]),
    // rust: id,
    // rust: title,
}
    // rust: })
    // rust: .collect()
}
