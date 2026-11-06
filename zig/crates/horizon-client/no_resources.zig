//! Transpiled from Horizon Rust crate
//! Module: horizon-client_no_resources
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The screen of a game started without its prepared files: the game build
//! run by hand (the release's game zip) instead of through the launcher. It
//! says where to get the launcher, and quits. Drawn in Horizon's design
//! language with the bundled fonts: none of Minecraft's files are there.
// use crate::ui_theme::{self, Face, Ui, color};

/// The launcher's download page.
pub const DOWNLOAD_URL: []const u8 = "https://playhorizon.dev";

pub const TITLE: []const u8 = "Start Horizon from the launcher";
    // rust: const PARAGRAPHS: [&str; 3] = [
    // rust: "This is the game the Horizon launcher installs and starts. On its own it has none of \
    // rust: Minecraft's files, so it can't start.",
    // rust: "Horizon needs your own copy of Minecraft: Java Edition. The launcher signs you in and \
    // rust: prepares the game files from it.",
    // rust: "Download the launcher at playhorizon.dev, then press Play there.",
    // rust: ];
pub const COLUMN: f32 = 560.0;
pub const BUTTON_GAP: f32 = 12.0;

/// What a click on the screen does.
pub const Action = enum {
    /// Open the launcher's download page.
    Download,
    Quit,
};

pub const NoResources = struct {
    /// Where the prepared files were looked for, for whoever starts the game by hand on purpose.
    looked_in: []const u8,
};

    // rust: impl NoResources {
pub fn new(looked_in: *std::path::Path) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let shown = std::path::absolute(looked_in).unwrap_or_else(|_| looked_in.to_path_buf());
    // rust: Self {
    // rust: looked_in: format!("No prepared game files in {}", shown.display()),
}
}

    /// The buttons' labels, actions and rectangles in dp, and the paragraphs' wrapped
    /// lines: one layout for drawing and clicks.
pub fn layout(self: *Self, ui: *Ui) L {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let width = COLUMN.min(ui.w - 64.0).max(160.0);
    // rust: let x = ((ui.w - width) / 2.0).round();
    // rust: let lines: Vec<Vec<String>> = PARAGRAPHS
    // rust: .iter()
    // rust: .map(|p| wrap(ui, Face::Regular, BODY, p, width))
    // rust: .collect();
    // rust: let text_h = lines.iter().map(|l| l.len() as f32 * LINE).sum::<f32>()
    // rust: + (lines.len() - 1) as f32 * PARAGRAPH_GAP;
    // rust: let height = TITLE_LINE + 16.0 + text_h + 28.0 + CONTROL + 20.0 + SMALL_LINE;
    // rust: let y = ((ui.h - height) / 2.0).max(24.0).round();
    // rust: let buttons_y = y + TITLE_LINE + 16.0 + text_h + 28.0;
    // rust: let mut buttons = Vec::new();
    // rust: let mut bx = x;
    // rust: for (label, action) in [
    // rust: ("Download the launcher", Action::Download),
    // rust: ("Quit", Action::Quit),
    // rust: ] {
    // rust: let w = (ui.measure(Face::Medium, BUTTON_TEXT, label) + 40.0).round();
    // rust: buttons.push(Button {
    // rust: label,
    // rust: action,
    // rust: x: bx,
    // rust: y: buttons_y,
    // rust: w,
    // rust: });
    // rust: bx += w + BUTTON_GAP;
}
    // rust: Layout {
    // rust: x,
    // rust: y,
    // rust: width,
    // rust: lines,
    // rust: buttons,
}
}

pub fn draw(self: *Self, ui: *mut Ui) void {
}
    // rust: let layout = self.layout(ui);
    // rust: ui.rounded(0.0, 0.0, ui.w, ui.h, 0.0, color::BG);
    // rust: let mut y = layout.y;
    // rust: ui.text_line(
    // rust: Face::Medium,
    // rust: TITLE_SIZE,
    // rust: TITLE_LINE,
    // rust: layout.x,
    // rust: y,
    // rust: color::TEXT,
    // rust: TITLE,
    // rust: );
    // rust: y += TITLE_LINE + 16.0;
    // rust: for paragraph in &layout.lines {
    // rust: for line in paragraph {
    // rust: ui.text_line(Face::Regular, BODY, LINE, layout.x, y, color::TEXT, line);
    // rust: y += LINE;
}
    // rust: y += PARAGRAPH_GAP;
}
    // rust: for button in &layout.buttons {
    // rust: let hovered = button.contains(ui.cursor);
    // rust: let (plate, ink) = match (button.action, hovered) {
    // rust: (Action::Download, false) => (color::ACCENT, color::ON_ACCENT),
    // rust: (Action::Download, true) => {
    // rust: (color::with_alpha(color::ACCENT, 0.85), color::ON_ACCENT)
}
    // rust: (Action::Quit, false) => (color::RAISED, color::TEXT),
    // rust: (Action::Quit, true) => (color::HOVER, color::TEXT),
}
    // rust: let h = CONTROL;
    // rust: ui.rounded(button.x, button.y, button.w, h, h / 2.0, plate);
    // rust: let lw = ui.measure(Face::Medium, BUTTON_TEXT, button.label);
    // rust: let lx = button.x + ((button.w - lw) / 2.0).round();
    // rust: ui.text_line(
    // rust: Face::Medium,
    // rust: BUTTON_TEXT,
    // rust: h,
    // rust: lx,
    // rust: button.y,
    // rust: ink,
    // rust: button.label,
    // rust: );
}
    // rust: let small_y = layout.buttons[0].y + CONTROL + 20.0;
    // rust: for (i, line) in wrap(
    // rust: ui,
    // rust: Face::Regular,
    // rust: ui_theme::SMALL,
    // rust: &self.looked_in,
    // rust: layout.width,
    // rust: )
    // rust: .iter()
    // rust: .enumerate()
    // rust: {
    // rust: let line_y = small_y + i as f32 * SMALL_LINE;
    // rust: ui.text_line(
    // rust: Face::Regular,
    // rust: ui_theme::SMALL,
    // rust: SMALL_LINE,
    // rust: layout.x,
    // rust: line_y,
    // rust: color::MUTED,
    // rust: line,
    // rust: );
}
}

    /// The button under the cursor (`ui.cursor`, in dp), if any.
pub fn click(self: *Self, ui: *Ui) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.layout(ui)
    // rust: .buttons
    // rust: .iter()
    // rust: .find(|b| b.contains(ui.cursor))
    // rust: .map(|b| b.action)
}
}

pub const TITLE_SIZE: f32 = horizon_theme::TITLE.px;
pub const TITLE_LINE: f32 = 40.0;
pub const BODY: f32 = horizon_theme::BODY.px;
pub const LINE: f32 = 24.0;
pub const PARAGRAPH_GAP: f32 = 10.0;
pub const BUTTON_TEXT: f32 = horizon_theme::UI.px;
pub const SMALL_LINE: f32 = 18.0;
pub const CONTROL: f32 = horizon_theme::CONTROL_LARGE;

pub const Layout = struct {
    x: f32,
    y: f32,
    width: f32,
    lines: std.ArrayList(Vec<[]const u8)>,
    buttons: std.ArrayList(Button),
};

pub const Button = struct {
    label: *'static str,
    action: Action,
    x: f32,
    y: f32,
    w: f32,
};

    // rust: impl Button {
pub fn contains(self: *Self) void {
}
    // rust: cx >= self.x && cx < self.x + self.w && cy >= self.y && cy < self.y + CONTROL
}
}

/// `text` broken at spaces into lines no wider than `width` dp (a longer word,
/// such as a path, gets a line of its own).
pub fn wrap(ui: *Ui, face: Face, size: f32, text: []const u8, width: f32) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut lines = Vec::new();
    // rust: let mut line = String::new();
    // rust: for word in text.split(' ') {
    // rust: let candidate = if line.is_empty() {
    // rust: word.to_owned()
    // rust: } else {
    // rust: format!("{line} {word}")
}
    // rust: if !line.is_empty() && ui.measure(face, size, &candidate) > width {
    // rust: lines.push(std::mem::replace(&mut line, word.to_owned()));
    // rust: } else {
    // rust: line = candidate;
}
}
    // rust: if !line.is_empty() {
    // rust: lines.push(line);
}
    // rust: lines
}

    // rust: mod tests {
//     use super::*;
//     use crate::hud::{HudAtlas, HudBatch};

    /// A Ui over a `size` window at GUI scale 1, the cursor at `cursor` pixels.
    // rust: fn with_ui<R>(size: [u32; 2], cursor: (f32, f32), f: impl FnOnce(&mut Ui) -> R) -> R {
    // rust: let atlas =
    // rust: HudAtlas::build(std::path::Path::new("/nonexistent/horizon-test-assets")).unwrap();
    // rust: let mut batch = HudBatch::new(size);
    // rust: let cursor = (cursor.0 / batch.scale, cursor.1 / batch.scale);
    // rust: let mut ui = Ui::new(&atlas, &mut batch, cursor);
    // rust: f(&mut ui)
}

pub fn the_buttons_are_where_they_are_drawn() void {
}
    // rust: let screen = NoResources::new(std::path::Path::new(".local/horizon-client/26.3"));
    // rust: for size in [[1280, 720], [800, 600], [2560, 1440]] {
    // rust: let (download, quit, density) = with_ui(size, (0.0, 0.0), |ui| {
    // rust: let layout = screen.layout(ui);
    // rust: let center = |b: &Button| (b.x + b.w / 2.0, b.y + CONTROL / 2.0);
    // rust: (
    // rust: center(&layout.buttons[0]),
    // rust: center(&layout.buttons[1]),
    // rust: ui.density,
    // rust: )
    // rust: });
    // rust: let at = |p: (f32, f32)| (p.0 * density, p.1 * density);
    // rust: assert_eq!(
    // rust: with_ui(size, at(download), |ui| screen.click(ui)),
    // rust: Some(Action::Download),
    // rust: "{size:?}"
    // rust: );
    // rust: assert_eq!(
    // rust: with_ui(size, at(quit), |ui| screen.click(ui)),
    // rust: Some(Action::Quit)
    // rust: );
    // rust: assert_eq!(with_ui(size, (1.0, 1.0), |ui| screen.click(ui)), None);
            // Everything fits in the window.
    // rust: with_ui(size, (0.0, 0.0), |ui| {
    // rust: let layout = screen.layout(ui);
    // rust: let last = layout.buttons.last().unwrap();
    // rust: assert!(
    // rust: last.x + last.w <= ui.w && last.y + CONTROL <= ui.h,
    // rust: "{size:?}"
    // rust: );
    // rust: });
}
}

pub fn text_wraps_within_the_column_and_keeps_every_word() void {
}
    // rust: with_ui([1280, 720], (0.0, 0.0), |ui| {
    // rust: for paragraph in PARAGRAPHS {
    // rust: let lines = wrap(ui, Face::Regular, BODY, paragraph, 300.0);
    // rust: assert!(lines.len() > 1, "{paragraph}");
    // rust: for line in &lines {
    // rust: assert!(ui.measure(Face::Regular, BODY, line) <= 300.0, "{line}");
}
    // rust: assert_eq!(lines.join(" "), paragraph);
}
    // rust: });
}
}
