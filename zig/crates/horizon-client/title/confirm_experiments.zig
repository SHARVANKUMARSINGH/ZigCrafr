//! Transpiled from Horizon Rust crate
//! Module: horizon-client_confirm_experiments
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! CreateWorldScreen's `ConfirmExperimentalFeaturesScreen`: the warning that
//! the picked data packs ask for experimental features, with the packs' own
//! flags on a second screen (`DetailsScreen`).
//!
//! Vanilla centres a grid (columns 10 apart, rows 20 apart): the title, the
//! message wrapped to 310, a 100-wide Details button, then Proceed and Back.

// use crate::{
    // rust: font::Font,
    // rust: hud::{HudAtlas, HudBatch},
    // rust: text::{Style, Text, named_color},
    // rust: ui,
}

/// `ConfirmExperimentalFeaturesScreen.COLUMN_SPACING`.
pub const COLUMN_SPACING: f32 = 10.0;
/// The footer buttons' width (`Button.defaults`).
pub const BUTTON: f32 = 150.0;
/// `DETAILS_BUTTON_WIDTH`.
pub const DETAILS: f32 = 100.0;
/// `MultiLineTextWidget.setMaxWidth(310)`.
pub const WARNING: f32 = 310.0;
/// One button row plus the grid's 20-pixel row spacing, twice.
pub const ROW: f32 = 40.0;

/// A press on the screen.
pub const Click = enum {
    /// The Details button: the packs' flags.
    Details,
    /// `gui.proceed`: apply the pending selection.
    Proceed,
    /// `gui.back` or Escape: leave the selection as it was.
    Back,
};

/// One enabled feature pack, as `DetailsScreen`'s list shows it.
pub const Entry = struct {
    /// The pack's name, bold.
    title: Text,
    /// `selectWorld.experimental.details.entry`'s argument: the flags.
    flags: []const u8,
};

/// The screen; `details` shows `DetailsScreen` instead.
pub const ConfirmExperimentsScreen = struct {
    entries: std.ArrayList(Entry),
    /// The selection to apply on Proceed.
    pending: std.ArrayList([]const u8),
    details: bool,
    in_world: bool,
};
    // rust: impl ConfirmExperimentsScreen {
    /// `ConfirmExperimentalFeaturesScreen::new`: the picked selection's
    /// feature packs, each with the flags it asks for.
pub fn new(resources: *std::path::Path, selected: *[[]const u8]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let entries = crate::datapack::feature_packs(resources)
    // rust: .into_iter()
    // rust: .filter(|p| selected.contains(&p.id))
    // rust: .filter(|p| !p.features().is_empty())
    // rust: .map(|p| {
    // rust: let name = format!("dataPack.{}.name", p.id);
    // rust: let title = (if crate::lang::has(&name) {
    // rust: Text::translate(&name, &[])
    // rust: } else {
    // rust: Text::literal(p.id.clone())
    // rust: })
    // rust: .with_style(&Style {
    // rust: bold: Some(true),
    // rust: ..Style::default()
    // rust: });
    // rust: let flags = p
    // rust: .features()
    // rust: .iter()
    // rust: .map(|f| f.trim_start_matches("minecraft:").to_owned())
    // rust: .collect::<Vec<_>>()
    // rust: .join(", ");
    // rust: Entry { title, flags }
    // rust: })
    // rust: .collect();
    // rust: Self {
    // rust: entries,
    // rust: pending: selected.to_vec(),
    // rust: details: false,
    // rust: in_world: false,
}
}
    /// The message's lines (`MultiLineTextWidget` at 310; the text's own
    /// line breaks kept).
pub fn message_lines(font: *Font) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: crate::lang::get_or(
    // rust: "selectWorld.experimental.message",
    // rust: "Be careful!\nThis configuration requires features that are still under development. \
    // rust: Your world might crash, break, or not work with future updates.",
    // rust: )
    // rust: .split('\n')
    // rust: .flat_map(|line| {
    // rust: font.split_lines(&Text::literal(line.to_owned()), WARNING)
    // rust: .into_iter()
    // rust: .map(|(l, _)| l)
    // rust: })
    // rust: .collect()
}
    /// The grid's top: the whole block centred vertically
    /// (`FrameLayout.alignInRectangle`).
pub fn block_top(message: usize, h: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let rows = 9.0 + message as f32 * 9.0 + ROW + ROW;
    // rust: ((h - rows) / 2.0).max(0.0)
}
    /// The Details button's rect (centred, under the message).
pub fn details_rect(message: usize, w: f32, h: f32) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (
    // rust: ((w - DETAILS) / 2.0).trunc(),
    // rust: Self::block_top(message, h) + 9.0 + ROW,
    // rust: )
}
    /// A press: Details, Proceed (`gui.proceed`) or Back (`gui.back`).
pub fn click(self: *Self, atlas: *HudAtlas) void {
}
    // rust: let (w, h) = size;
    // rust: if self.details {
    // rust: let [(bx, by)] = footer_single(w, h);
    // rust: return ui::hovered((x, y), bx, by, BUTTON, 20.0).then_some(Click::Back);
}
    // rust: let message = Self::message_lines(&atlas.font).len();
    // rust: let (dx, dy) = Self::details_rect(message, w, h);
    // rust: if ui::hovered((x, y), dx, dy, DETAILS, 20.0) {
    // rust: return Some(Click::Details);
}
    // rust: let [(px, py), (bx, by)] = footer_pair(w, h);
    // rust: if ui::hovered((x, y), px, py, BUTTON, 20.0) {
    // rust: return Some(Click::Proceed);
}
    // rust: ui::hovered((x, y), bx, by, BUTTON, 20.0).then_some(Click::Back)
}
pub fn draw(self: *Self, batch: *mut HudBatch, atlas: *HudAtlas, cursor: (f32) void {
}
    // rust: let (w, h) = (batch.width, batch.height);
    // rust: ui::menu_background(batch, atlas, 0.0, 0.0, w, h, self.in_world);
    // rust: let font = &atlas.font;
    // rust: if self.details {
            // `DetailsScreen`: the header's title, the packs, Back in the
            // footer.
    // rust: let title = Text::translate("selectWorld.experimental.details.title", &[]);
    // rust: let tw = font.width_text(&title);
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: &title,
    // rust: ((w - tw) / 2.0).trunc(),
    // rust: 15.0,
    // rust: u32::MAX,
    // rust: true,
    // rust: );
    // rust: let gray = named_color("gray").unwrap_or(0xAAAAAA);
    // rust: let mut y = 63.0 + 30.0;
    // rust: for entry in &self.entries {
    // rust: let x = (w / 2.0 - 155.0).trunc();
    // rust: batch.text_styled(atlas, &entry.title, x, y, u32::MAX, true);
    // rust: y += 12.0;
    // rust: let line = Text::translate("selectWorld.experimental.details.entry", &[])
    // rust: .append(Text::literal(entry.flags.clone()).with_color(gray));
    // rust: for (l, _) in font.split_lines(&line, WARNING) {
    // rust: batch.text_styled(atlas, &l, x, y, u32::MAX, true);
    // rust: y += 9.0;
}
    // rust: y += 10.0;
}
    // rust: let [(bx, by)] = footer_single(w, h);
    // rust: ui::action_button(
    // rust: batch,
    // rust: atlas,
    // rust: crate::widgets::Action::Back,
    // rust: bx,
    // rust: by,
    // rust: BUTTON,
    // rust: 20.0,
    // rust: &Text::translate("gui.back", &[]),
    // rust: true,
    // rust: ui::hovered(cursor, bx, by, BUTTON, 20.0),
    // rust: );
    // rust: return;
}
    // rust: let message = Self::message_lines(font);
    // rust: let top = Self::block_top(message.len(), h);
        // The title, the message, Details, then the two buttons: the grid's
        // rows 20 apart, the whole block centred.
    // rust: let title = Text::translate("selectWorld.experimental.title", &[]);
    // rust: let tw = font.width_text(&title);
    // rust: batch.text_styled(atlas, &title, ((w - tw) / 2.0).trunc(), top, u32::MAX, true);
    // rust: let (dx, dy) = Self::details_rect(message.len(), w, h);
    // rust: let mut y = top + 9.0;
    // rust: for line in &message {
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: line,
    // rust: ((w - WARNING) / 2.0).trunc(),
    // rust: y,
    // rust: u32::MAX,
    // rust: true,
    // rust: );
    // rust: y += 9.0;
}
    // rust: ui::button(
    // rust: batch,
    // rust: atlas,
    // rust: dx,
    // rust: dy,
    // rust: DETAILS,
    // rust: 20.0,
    // rust: &Text::translate("selectWorld.experimental.details", &[]),
    // rust: true,
    // rust: ui::hovered(cursor, dx, dy, DETAILS, 20.0),
    // rust: );
    // rust: let [(px, py), (bx, by)] = footer_pair(w, h);
    // rust: crate::widgets::declare_action(crate::widgets::Action::Back, [bx, by, BUTTON, 20.0], true);
    // rust: for (fx, fy, key) in [(px, py, "gui.proceed"), (bx, by, "gui.back")] {
    // rust: ui::button(
    // rust: batch,
    // rust: atlas,
    // rust: fx,
    // rust: fy,
    // rust: BUTTON,
    // rust: 20.0,
    // rust: &Text::translate(key, &[]),
    // rust: true,
    // rust: ui::hovered(cursor, fx, fy, BUTTON, 20.0),
    // rust: );
}
}
}

/// Two 150-wide buttons `COLUMN_SPACING` apart, centred.
pub fn footer_pair(w: f32, h: f32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let x = ((w - (BUTTON * 2.0 + COLUMN_SPACING)) / 2.0).trunc();
    // rust: let y = h - 45.0;
    // rust: [(x, y), (x + BUTTON + COLUMN_SPACING, y)]
}
/// One centred footer button (`DetailsScreen`'s Back).
pub fn footer_single(w: f32, h: f32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [(((w - BUTTON) / 2.0).trunc(), h - 45.0)]
}
