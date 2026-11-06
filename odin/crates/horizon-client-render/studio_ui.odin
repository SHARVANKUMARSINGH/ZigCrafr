//! Transpiled from Horizon Rust crate
package horizon_client_render_studio_ui

import "core:fmt"
import "core:mem"
import "core:math"

// Replay Studio Browser & Saved Recordings UI
//
// Provides an in-game graphical browser to inspect saved `.mcpr` recordings,
// view recording metadata (duration, packet count, timestamp, server),
// and open the recordings directory.

// use crate::{
    // rust: graphics_style as style,
    // rust: hud::{HudAtlas, HudBatch},
    // rust: lang,
    // rust: text::Text,
    // rust: ui,
}
// use serde::{Deserialize, Serialize};
// use std::{
    // rust: fs::{self, File},
    // rust: io::Read,
    // rust: path::{Path, PathBuf},
}

// High-level session metadata read from `metaData.json` inside `.mcpr`.
RecordingMetadata :: struct {
    server_name: string,
    custom_server_name: Maybe(string),
    singleplayer: bool,
    duration: u32,
    date: u64,
    mcversion: string,
    file_format: string,
    file_format_version: u32,
    generator: string,
    players: [dynamic]string,
}

// A saved replay item displayed in the Studio Browser list.
SavedRecordingItem :: struct {
    path: PathBuf,
    filename: string,
    title: string,
    duration_ms: u32,
    date: u64,
    file_size: u64,
    server_name: string,
    singleplayer: bool,
}

    // rust: impl SavedRecordingItem {
    // Formatted duration string `MM:SS` or `HH:MM:SS`.
formatted_duration :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let total_secs = self.duration_ms / 1000;
    // rust: let hours = total_secs / 3600;
    // rust: let mins = (total_secs % 3600) / 60;
    // rust: let secs = total_secs % 60;
    // rust: if hours > 0 {
    // rust: format!("{hours:02}:{mins:02}:{secs:02}")
    // rust: } else {
    // rust: format!("{mins:02}:{secs:02}")
}
}

    // Formatted file size string (KB or MB).
formatted_size :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let bytes = self.file_size;
    // rust: if bytes >= 1024 * 1024 {
    // rust: let mb = bytes as f64 / (1024.0 * 1024.0);
    // rust: format!("{mb:.1} MB")
    // rust: } else {
    // rust: let kb = bytes.div_ceil(1024);
    // rust: format!("{kb} KB")
}
}
}

// User actions triggered by the Studio Browser UI.
StudioAction :: enum {
    None,
    OpenFolder,
    Refresh,
    Back,
}

// The Studio Replay Browser screen state and renderer.
StudioUi :: struct {
    recordings: [dynamic]SavedRecordingItem,
    selected: Maybe(uint),
    scroll: f32,
    search: string,
    record_dir: PathBuf,
}

    // rust: impl Default for StudioUi {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: let dir = PathBuf::from("recordings");
    // rust: let mut ui = Self {
    // rust: recordings: Vec::new(),
    // rust: selected: None,
    // rust: scroll: 0.0,
    // rust: search: String::new(),
    // rust: record_dir: dir.clone(),
}
    // rust: ui.scan(&dir);
    // rust: ui
}
}

    // rust: impl StudioUi {
    // Create a new StudioUi for the given recordings directory.
new :: proc(record_dir: impl Into<PathBuf>) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let dir = record_dir.into();
    // rust: let mut ui = Self {
    // rust: recordings: Vec::new(),
    // rust: selected: None,
    // rust: scroll: 0.0,
    // rust: search: String::new(),
    // rust: record_dir: dir.clone(),
}
    // rust: ui.scan(&dir);
    // rust: ui
}

    // Re-scan the recordings folder.
refresh :: proc(self: ^Self) {
}
    // rust: self.scan(&self.record_dir.clone());
}

    // Read metadata from a `.mcpr` archive without extracting the full packet stream.
read_metadata :: proc(path: ^Path) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let file = File::open(path).ok()?;
    // rust: let mut archive = zip::ZipArchive::new(file).ok()?;
    // rust: let mut meta_file = archive.by_name("metaData.json").ok()?;
    // rust: let mut meta_bytes = Vec::new();
    // rust: meta_file.read_to_end(&mut meta_bytes).ok()?;
    // rust: serde_json::from_slice(&meta_bytes).ok()
}

    // Scan `dir` for `.mcpr` files and parse their metadata.
scan :: proc(self: ^Self, dir: ^Path) {
}
    // rust: self.recordings.clear();
    // rust: self.selected = None;
    // rust: let Ok(entries) = fs::read_dir(dir) else {
    // rust: return;
}

    // rust: for entry in entries.flatten() {
    // rust: let path = entry.path();
    // rust: if path.extension().and_then(|ext| ext.to_str()) != Some("mcpr") {
    // rust: continue;
}

    // rust: let Ok(meta) = entry.metadata() else {
    // rust: continue;
}
    // rust: let file_size = meta.len();
    // rust: let filename = path
    // rust: .file_name()
    // rust: .map(|f| f.to_string_lossy().into_owned())
    // rust: .unwrap_or_default();
    // rust: let title = path
    // rust: .file_stem()
    // rust: .map(|s| s.to_string_lossy().into_owned())
    // rust: .unwrap_or_else(|| filename.clone());

    // rust: let (duration_ms, date, server_name, singleplayer) =
    // rust: if let Some(parsed) = Self::read_metadata(&path) {
    // rust: let srv = if parsed.singleplayer {
    // rust: lang::get("menu.singleplayer")
    // rust: } else if !parsed.server_name.is_empty() {
    // rust: parsed.server_name
    // rust: } else {
    // rust: lang::get("menu.multiplayer")
}
    // rust: (parsed.duration, parsed.date, srv, parsed.singleplayer)
    // rust: } else {
    // rust: let modified = meta
    // rust: .modified()
    // rust: .ok()
    // rust: .and_then(|t| t.duration_since(std::time::UNIX_EPOCH).ok())
    // rust: .map(|d| d.as_millis() as u64)
    // rust: .unwrap_or(0);
    // rust: (
    // rust: 0,
    // rust: modified,
    // rust: lang::get("horizon.studio.unknown_server"),
    // rust: true,
    // rust: )
}

    // rust: self.recordings.push(SavedRecordingItem {
    // rust: path,
    // rust: filename,
    // rust: title,
    // rust: duration_ms,
    // rust: date,
    // rust: file_size,
    // rust: server_name,
    // rust: singleplayer,
    // rust: });
}

        // Sort descending by date (newest recordings first)
    // rust: self.recordings.sort_by_key(|a| std::cmp::Reverse(a.date));
    // rust: if !self.recordings.is_empty() {
    // rust: self.selected = Some(0);
}
}

    // Draw the Studio Browser screen.
    // rust: pub fn draw(
    // rust: &mut self,
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: cursor: (f32, f32),
    // rust: in_world: bool,
    // rust: ) {
    // rust: let (w, h) = (batch.width, batch.height);
    // rust: ui::menu_background(batch, atlas, 0.0, 0.0, w, h, in_world);

        // Header Title: centered at top
    // rust: style::title(batch, atlas, &Text::tr("horizon.pages.studio", &[]));

        // Subtitle strip: centered info text
    // rust: let subtitle = Text::tr("horizon.studio.saved_recordings", &[]);
    // rust: ui::centered_text(batch, atlas, &subtitle, 0.0, 26.0, w, style::GREY);

        // Main content area layout
    // rust: let panel_w = (w - 40.0).clamp(280.0, 440.0);
    // rust: let panel_x = ((w - panel_w) / 2.0).floor();
    // rust: let panel_y = 42.0;
    // rust: let panel_h = (h - 76.0).max(100.0);

        // Glass panel backdrop for recordings list
    // rust: style::panel(batch, atlas, [panel_x, panel_y, panel_w, panel_h]);

    // rust: if self.recordings.is_empty() {
            // Empty state
    // rust: let empty_text = Text::tr("horizon.studio.empty", &[]);
    // rust: let hint_text = Text::tr("horizon.studio.empty_hint", &[]);
    // rust: ui::centered_text(
    // rust: batch,
    // rust: atlas,
    // rust: &empty_text,
    // rust: panel_x,
    // rust: panel_y + panel_h / 2.0 - 16.0,
    // rust: panel_w,
    // rust: style::WHITE,
    // rust: );
    // rust: ui::centered_text(
    // rust: batch,
    // rust: atlas,
    // rust: &hint_text,
    // rust: panel_x,
    // rust: panel_y + panel_h / 2.0,
    // rust: panel_w,
    // rust: style::GREY,
    // rust: );
    // rust: } else {
            // Render scrollable cards
    // rust: let card_h = 36.0;
    // rust: let card_gap = 4.0;
    // rust: let row_step = card_h + card_gap;
    // rust: let visible_cards = (panel_h / row_step).floor() as usize;
    // rust: let max_scroll =
    // rust: (self.recordings.len().saturating_sub(visible_cards) as f32 * row_step).max(0.0);
    // rust: self.scroll = self.scroll.clamp(0.0, max_scroll);

    // rust: let card_w = panel_w - 12.0;
    // rust: let card_x = panel_x + 6.0;
    // rust: let mut y = panel_y + 6.0 - (self.scroll % row_step);
    // rust: let start_idx = (self.scroll / row_step) as usize;

    // rust: for (idx, item) in self.recordings.iter().enumerate().skip(start_idx) {
    // rust: if y + card_h > panel_y + panel_h - 4.0 {
    // rust: break;
}

    // rust: let rect = [card_x, y, card_w, card_h];
    // rust: let is_hovered = ui::hovered(cursor, card_x, y, card_w, card_h);
    // rust: let is_selected = self.selected == Some(idx);

                // Card background & highlight
    // rust: if is_selected {
    // rust: style::fill(batch, atlas, rect, style::OPEN);
    // rust: } else if is_hovered {
    // rust: style::fill(batch, atlas, rect, style::HOVER);
    // rust: } else {
    // rust: style::well(batch, atlas, rect);
}

    // rust: let border_color = if is_selected {
    // rust: style::ACCENT
    // rust: } else if is_hovered {
    // rust: style::WHITE
    // rust: } else {
    // rust: style::ROW_RULE
}
    // rust: style::ring(batch, atlas, rect, border_color);

                // Card Line 1: Recording Title (bold white)
    // rust: let title_text = Text::literal(&item.title);
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: &title_text,
    // rust: card_x + 8.0,
    // rust: y + 6.0,
    // rust: style::WHITE,
    // rust: true,
    // rust: );

                // Card Line 2: Duration, Size, Server
    // rust: let meta_str = format!(
    // rust: "{} • {} • {}",
    // rust: item.formatted_duration(),
    // rust: item.formatted_size(),
    // rust: item.server_name
    // rust: );
    // rust: let meta_text = Text::literal(&meta_str);
    // rust: batch.text_styled(atlas, &meta_text, card_x + 8.0, y + 20.0, style::GREY, true);

    // rust: y += row_step;
}

            // Scrollbar track & thumb if scrollable
    // rust: if max_scroll > 0.0 {
    // rust: let track_x = panel_x + panel_w - 4.0;
    // rust: let track_y = panel_y + 2.0;
    // rust: let track_h = panel_h - 4.0;
    // rust: let thumb_h = ((panel_h / (panel_h + max_scroll)) * track_h).max(12.0);
    // rust: let thumb_y = track_y + (self.scroll / max_scroll) * (track_h - thumb_h);
    // rust: style::scroller(
    // rust: batch,
    // rust: atlas,
    // rust: [track_x, track_y, 2.0, track_h],
    // rust: [track_x, thumb_y, 2.0, thumb_h],
    // rust: );
}
}

        // Bottom Button Bar
    // rust: let btn_y = h - 28.0;
    // rust: let btn_h = 20.0;

        // Button 1: Open Folder (Left)
    // rust: let f_btn = [panel_x, btn_y, 130.0, btn_h];
    // rust: let f_hover = ui::hovered(cursor, f_btn[0], f_btn[1], f_btn[2], f_btn[3]);
    // rust: style::button(
    // rust: batch,
    // rust: atlas,
    // rust: f_btn,
    // rust: &Text::tr("horizon.studio.open_folder", &[]),
    // rust: (f_hover, true, false),
    // rust: );

        // Button 2: Refresh (Center-Left)
    // rust: let r_btn = [panel_x + 136.0, btn_y, 65.0, btn_h];
    // rust: let r_hover = ui::hovered(cursor, r_btn[0], r_btn[1], r_btn[2], r_btn[3]);
    // rust: style::button(
    // rust: batch,
    // rust: atlas,
    // rust: r_btn,
    // rust: &Text::tr("horizon.studio.refresh", &[]),
    // rust: (r_hover, true, false),
    // rust: );

        // Button 3: Done / Back (Right)
    // rust: let d_btn = [panel_x + panel_w - 64.0, btn_y, 64.0, btn_h];
    // rust: let d_hover = ui::hovered(cursor, d_btn[0], d_btn[1], d_btn[2], d_btn[3]);
    // rust: style::button(
    // rust: batch,
    // rust: atlas,
    // rust: d_btn,
    // rust: &Text::tr("gui.done", &[]),
    // rust: (d_hover, true, false),
    // rust: );
}

    // Process mouse click on the Studio Browser screen.
click :: proc(self: ^Self, cursor: (f32) {
}
    // rust: let (w, h) = size;
    // rust: let panel_w = (w - 40.0).clamp(280.0, 440.0);
    // rust: let panel_x = ((w - panel_w) / 2.0).floor();
    // rust: let panel_y = 42.0;
    // rust: let panel_h = (h - 76.0).max(100.0);
    // rust: let btn_y = h - 28.0;
    // rust: let btn_h = 20.0;

        // Button 1: Open Folder
    // rust: let f_btn = [panel_x, btn_y, 130.0, btn_h];
    // rust: if ui::hovered(cursor, f_btn[0], f_btn[1], f_btn[2], f_btn[3]) {
    // rust: return StudioAction::OpenFolder;
}

        // Button 2: Refresh
    // rust: let r_btn = [panel_x + 136.0, btn_y, 65.0, btn_h];
    // rust: if ui::hovered(cursor, r_btn[0], r_btn[1], r_btn[2], r_btn[3]) {
    // rust: self.refresh();
    // rust: return StudioAction::Refresh;
}

        // Button 3: Done
    // rust: let d_btn = [panel_x + panel_w - 64.0, btn_y, 64.0, btn_h];
    // rust: if ui::hovered(cursor, d_btn[0], d_btn[1], d_btn[2], d_btn[3]) {
    // rust: return StudioAction::Back;
}

        // Card clicks
    // rust: let card_h = 36.0;
    // rust: let card_gap = 4.0;
    // rust: let row_step = card_h + card_gap;
    // rust: let card_w = panel_w - 12.0;
    // rust: let card_x = panel_x + 6.0;
    // rust: let start_idx = (self.scroll / row_step) as usize;
    // rust: let mut y = panel_y + 6.0 - (self.scroll % row_step);

    // rust: for (idx, _) in self.recordings.iter().enumerate().skip(start_idx) {
    // rust: if y + card_h > panel_y + panel_h - 4.0 {
    // rust: break;
}

    // rust: if ui::hovered(cursor, card_x, y, card_w, card_h) {
    // rust: self.selected = Some(idx);
    // rust: return StudioAction::None;
}

    // rust: y += row_step;
}

    // rust: StudioAction::None
}

    // Scroll list by mouse wheel delta.
wheel :: proc(self: ^Self, amount: f32) {
}
    // rust: self.scroll = (self.scroll - amount * 24.0).max(0.0);
}
}

    // rust: mod tests {
//     use super::*;
//     use std::io::Write;

formatted_duration_and_size :: proc() {
}
    // rust: let item = SavedRecordingItem {
    // rust: path: PathBuf::from("recordings/test.mcpr"),
    // rust: filename: "test.mcpr".to_string(),
    // rust: title: "test".to_string(),
    // rust: duration_ms: 125_000,
    // rust: date: 1_700_000_000,
    // rust: file_size: 4_500_000,
    // rust: server_name: "Local World".to_string(),
    // rust: singleplayer: true,
}
    // rust: assert_eq!(item.formatted_duration(), "02:05");
    // rust: assert_eq!(item.formatted_size(), "4.3 MB");

    // rust: let short_item = SavedRecordingItem {
    // rust: path: PathBuf::from("recordings/short.mcpr"),
    // rust: filename: "short.mcpr".to_string(),
    // rust: title: "short".to_string(),
    // rust: duration_ms: 45_000,
    // rust: date: 1_700_000_000,
    // rust: file_size: 512 * 1024,
    // rust: server_name: "Hypixel".to_string(),
    // rust: singleplayer: false,
}
    // rust: assert_eq!(short_item.formatted_duration(), "00:45");
    // rust: assert_eq!(short_item.formatted_size(), "512 KB");
}

scan_and_select_recordings :: proc() {
}
    // rust: let temp_dir = std::env::temp_dir().join(format!("studio_test_{}", std::process::id()));
    // rust: let _ = fs::create_dir_all(&temp_dir);

    // rust: let rec_path = temp_dir.join("sample.mcpr");
    // rust: {
    // rust: let file = File::create(&rec_path).unwrap();
    // rust: let mut zip = zip::ZipWriter::new(file);
    // rust: let options = zip::write::SimpleFileOptions::default();
    // rust: zip.start_file("metaData.json", options).unwrap();
    // rust: let meta = RecordingMetadata {
    // rust: server_name: "Test Server".to_string(),
    // rust: duration: 65_000,
    // rust: date: 1_700_000_500,
    // rust: ..Default::default()
}
    // rust: let json_bytes = serde_json::to_vec(&meta).unwrap();
    // rust: zip.write_all(&json_bytes).unwrap();
    // rust: zip.finish().unwrap();
}

    // rust: let mut ui = StudioUi::new(&temp_dir);
    // rust: assert_eq!(ui.recordings.len(), 1);
    // rust: assert_eq!(ui.recordings[0].title, "sample");
    // rust: assert_eq!(ui.recordings[0].duration_ms, 65_000);
    // rust: assert_eq!(ui.recordings[0].server_name, "Test Server");
    // rust: assert_eq!(ui.selected, Some(0));

        // Clicking a card selects it for inspection without opening the editor.
    // rust: let action = ui.click((200.0, 60.0), (427.0, 720.0));
    // rust: assert_eq!(action, StudioAction::None);
    // rust: assert_eq!(ui.selected, Some(0));

        // Clean up
    // rust: let _ = fs::remove_dir_all(&temp_dir);
}

studio_wheel_scrolling :: proc() {
}
    // rust: let mut ui = StudioUi::default();
    // rust: ui.wheel(2.0);
    // rust: assert_eq!(ui.scroll, 0.0); // clamped at 0
    // rust: ui.scroll = 100.0;
    // rust: ui.wheel(1.0);
    // rust: assert_eq!(ui.scroll, 76.0);
}
}
