//! Transpiled from Horizon Rust crate
package horizon_client_win_screen

import "core:fmt"
import "core:mem"
import "core:math"

// `WinScreen`: the end poem, the credits and the post-credits text rolling up
// under the logo, after the player leaves the End for the first time (with
// the poem) or from Credits & Attribution (the credits alone). The texts come
// from the resource root, so resource packs can replace them.
// use crate::{
    // rust: font::Font,
    // rust: hud::{Blend, EndPortalFill, HudAtlas, HudBatch},
    // rust: text::{self, Style, Text},
}
// use horizon_core::random::{LegacyRandom, RandomSource};
// use std::{collections::HashSet, path::Path};

// `WinScreen.OBFUSCATE_TOKEN`: `§f§k§a§b` marks where the poem hides a name.
OBFUSCATE_TOKEN :: "\u{a7}f\u{a7}k\u{a7}a\u{a7}b"
// `WinScreen.NAME_PREFIX`.
NAME_PREFIX :: "           "
// `WinScreen.SECTION_HEADING`.
SECTION_HEADING :: "============"
// A key the screen reacts to (`keyPressed` / `keyReleased`).
Key :: enum {
    // `KeyEvent.isUp`: the up arrow scrolls back.
    Up,
    // Space speeds the scroll up.
    Space,
    // Each held Control key speeds it up more.
    LeftControl,
    RightControl,
}
    // rust: impl Key {
from_code :: proc(code: winit::keyboard::KeyCode) -> O {
    // Ported from Horizon
    return {}
}
//         use winit::keyboard::KeyCode;
    // rust: match code {
    // rust: KeyCode::ArrowUp => Some(Self::Up),
    // rust: KeyCode::Space => Some(Self::Space),
    // rust: KeyCode::ControlLeft => Some(Self::LeftControl),
    // rust: KeyCode::ControlRight => Some(Self::RightControl),
    // rust: _ => None,
}
}
}
WinScreen :: struct {
    poem: bool,
    lines: [dynamic]Text,
    centered: map[uint]struct{},
    total_scroll_length: i32,
    scroll: f32,
    speedup_active: bool,
    speedup_modifiers: map[Key]struct{},
    unmodified_scroll_speed: f32,
    scroll_speed: f32,
    direction: i32,
    // `narratorComponents` joined for narration (`getNarrationMessage`):
    // the poem's lines as read, the credits' names and titles (not the
    // section rules), an empty part for each empty line.
    narration: string,
}
    // rust: impl WinScreen {
    // `WinScreen.<init>` and `init`: the poem (`texts/end.txt`) when `poem`,
    // the credits (`texts/credits.json`), then `texts/postcredits.txt`.
new :: proc(poem: bool, root: ^Path, player: string, font: ^Font) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let speed = if poem { 0.5 } else { 0.75 };
    // rust: let mut screen = Self {
    // rust: poem,
    // rust: lines: Vec::new(),
    // rust: centered: HashSet::new(),
    // rust: total_scroll_length: 0,
    // rust: scroll: 0.0,
    // rust: speedup_active: false,
    // rust: speedup_modifiers: HashSet::new(),
    // rust: unmodified_scroll_speed: speed,
    // rust: scroll_speed: speed,
    // rust: direction: 1,
    // rust: narration: String::new(),
}
    // rust: let mut narrated = Vec::new();
    // rust: let texts = root.join("assets/minecraft/texts");
    // rust: let read = |name: &str| match std::fs::read_to_string(texts.join(name)) {
    // rust: Ok(s) => Some(s),
    // rust: Err(e) => {
    // rust: log::error!("Couldn't load credits from file minecraft:texts/{name}: {e}");
    // rust: None
}
}
    // rust: if poem && let Some(s) = read("end.txt") {
    // rust: screen.add_poem_file(&s, player, font, &mut narrated);
}
    // rust: if let Some(s) = read("credits.json") {
    // rust: match serde_json::from_str(&s) {
    // rust: Ok(json) => screen.add_credits_file(&json, &mut narrated),
    // rust: Err(e) => {
    // rust: log::error!("Couldn't load credits from file minecraft:texts/credits.json: {e}")
}
}
}
    // rust: if poem && let Some(s) = read("postcredits.txt") {
    // rust: screen.add_poem_file(&s, player, font, &mut narrated);
}
    // rust: screen.total_scroll_length = screen.lines.len() as i32 * 12;
    // rust: screen.narration = narrated.join(". ");
    // rust: screen
}
    // What the screen narrates: no title of its own
    // (`GameNarrator.NO_TITLE`), its `getNarrationMessage` is
    // `joinForNarration` of the narrator's parts.
screen_info :: proc(self: ^Self) -> c {
    // Ported from Horizon
    return {}
}
    // rust: crate::widgets::ScreenInfo::new("win", self.narration.clone())
}
    // `addPoemFile`: each line with the player's name in, its obfuscated
    // spans turned into 3 to 6 scrambled characters, wrapped at 256 pixels
    // and followed by an empty line; 8 more empty lines at the end.
add_poem_file :: proc(self: ^Self, file: string, player: string, font: ^Font, narrated: ^[dynamic]string) {
}
    // rust: let mut random = LegacyRandom::new(8124371);
        // BufferedReader.readLine: \n, \r or \r\n end a line; no empty last line.
    // rust: let mut lines: Vec<&str> = file
    // rust: .split('\n')
    // rust: .map(|l| l.strip_suffix('\r').unwrap_or(l))
    // rust: .collect();
    // rust: if file.ends_with('\n') {
    // rust: lines.pop();
}
    // rust: for line in lines.iter().flat_map(|l| l.split('\r')) {
    // rust: let mut line = line.replace("PLAYERNAME", player);
    // rust: while let Some(pos) = line.find(OBFUSCATE_TOKEN) {
    // rust: let n = random.next_int_bound(4).unwrap_or(0) as usize + 3;
    // rust: line = format!(
    // rust: "{}\u{a7}f\u{a7}k{}{}",
    // rust: &line[..pos],
    // rust: &"XXXXXXXX"[..n],
    // rust: &line[pos + OBFUSCATE_TOKEN.len()..]
    // rust: );
}
    // rust: let text = Text::legacy(&line);
    // rust: self.lines
    // rust: .extend(font.split_lines(&text, 256.0).into_iter().map(|(t, _)| t));
            // addPoemLines: the line as read, its codes and all
            // (`Component.literal(line)`).
    // rust: narrated.push(line);
    // rust: self.add_empty_line(narrated);
}
    // rust: for _ in 0..8 {
    // rust: self.add_empty_line(narrated);
}
}
    // `addCreditsFile`: each section's heading, then each discipline's name
    // and its titles with the names under them.
add_credits_file :: proc(self: ^Self, json: ^serde_json::Value, narrated: ^[dynamic]string) {
}
    // rust: let colored = |s: &str, color: u32| Text::styled(s, Style::color(color));
    // rust: let heading = || colored(SECTION_HEADING, text::WHITE);
    // rust: for section in json.as_array().into_iter().flatten() {
    // rust: let name = section["section"].as_str().unwrap_or_default();
    // rust: self.add_credits_line(heading(), true, None);
    // rust: self.add_credits_line(colored(name, text::YELLOW), true, Some(narrated));
    // rust: self.add_credits_line(heading(), true, None);
    // rust: self.add_empty_line(narrated);
    // rust: self.add_empty_line(narrated);
    // rust: for discipline in section["disciplines"].as_array().into_iter().flatten() {
    // rust: let name = discipline["discipline"].as_str().unwrap_or_default();
    // rust: if !name.is_empty() {
    // rust: self.add_credits_line(colored(name, text::YELLOW), true, Some(narrated));
    // rust: self.add_empty_line(narrated);
    // rust: self.add_empty_line(narrated);
}
    // rust: for title in discipline["titles"].as_array().into_iter().flatten() {
    // rust: let name = title["title"].as_str().unwrap_or_default();
    // rust: self.add_credits_line(colored(name, text::GRAY), false, Some(narrated));
    // rust: for name in title["names"].as_array().into_iter().flatten() {
    // rust: let line = format!("{NAME_PREFIX}{}", name.as_str().unwrap_or_default());
    // rust: self.add_credits_line(colored(&line, text::WHITE), false, Some(narrated));
}
    // rust: self.add_empty_line(narrated);
    // rust: self.add_empty_line(narrated);
}
}
}
}
add_empty_line :: proc(self: ^Self, narrated: ^[dynamic]string) {
}
    // rust: self.lines.push(Text::empty());
    // rust: narrated.push(String::new());
}
    // `addCreditsLine`; `narrated` when the narrator reads it too.
add_credits_line :: proc(self: ^Self, line: Text, centered: bool, narrated: Maybe(^[dynamic]string)) {
}
    // rust: if centered {
    // rust: self.centered.insert(self.lines.len());
}
    // rust: if let Some(narrated) = narrated {
    // rust: narrated.push(line.plain());
}
    // rust: self.lines.push(line);
}
    // The lines in order and whether each is centred.
lines :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.lines
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, l)| (l, self.centered.contains(&i)))
}
calculate_scroll_speed :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let speed = if self.speedup_active {
    // rust: self.unmodified_scroll_speed * (5.0 + self.speedup_modifiers.len() as f32 * 15.0)
    // rust: } else {
    // rust: self.unmodified_scroll_speed
}
    // rust: speed * self.direction as f32
}
    // `keyPressed` / `keyReleased` (Escape closes the screen: `onClose`).
key :: proc(self: ^Self, key: Key, pressed: bool) {
}
    // rust: match (key, pressed) {
    // rust: (Key::Up, _) => self.direction = if pressed { -1 } else { 1 },
    // rust: (Key::Space, _) => self.speedup_active = pressed,
    // rust: (_, true) => {
    // rust: self.speedup_modifiers.insert(key);
}
    // rust: (_, false) => {
    // rust: self.speedup_modifiers.remove(&key);
}
}
    // rust: self.scroll_speed = self.calculate_scroll_speed();
}
    // `tick`: once the text has rolled past the top, the screen is done
    // (`respawn`, or back to the screen that opened it).
finished :: proc(self: ^Self, height: f32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let height = height as i32;
    // rust: self.scroll > (self.total_scroll_length + height + height + 24) as f32
}
scroll :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.scroll
}
    // Stay `scroll` pixels in (until a key changes the speed), for
    // screenshots.
hold :: proc(self: ^Self, scroll: f32) {
}
    // rust: self.scroll = scroll;
    // rust: self.scroll_speed = 0.0;
}
    // `extractRenderState` after a frame of `delta_ticks` game ticks:
    // `extractBackground`, the vignette, then the logo and the lines
    // scrolled up. The poem's End portal background samples `end_portal`;
    // the credits draw the scrolling menu background (over the blurred
    // panorama on the title screen).
    // rust: pub fn draw(
    // rust: &mut self,
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: delta_ticks: f32,
    // rust: end_portal: EndPortalFill,
    // rust: ) {
    // rust: let (w, h) = (batch.width, batch.height);
    // rust: if self.poem {
    // rust: let start = batch.vertices.len();
    // rust: batch.fill(atlas, 0.0, 0.0, w, h, u32::MAX);
    // rust: batch.blend_since(start, Blend::EndPortal);
    // rust: batch.end_portal = end_portal;
    // rust: } else {
    // rust: self.menu_background(batch, atlas, w, h);
}
        // extractVignette: credits_vignette.png stretched over the screen.
    // rust: if let Some(r) = atlas.sprites.get("misc/credits_vignette").copied() {
    // rust: let start = batch.vertices.len();
    // rust: batch.rect_uv(0.0, 0.0, w, h, r, u32::MAX);
    // rust: batch.blend_since(start, Blend::Vignette);
}
    // rust: self.scroll = (self.scroll + delta_ticks * self.scroll_speed).max(0.0);
    // rust: let logo_x = (w / 2.0).floor() - 128.0;
    // rust: let logo_y = h + 50.0;
        // Everything below is drawn translated by `y_offs`.
    // rust: let y_offs = -self.scroll;
        // LogoRenderer(false) at full alpha.
    // rust: let edition_x = (w / 2.0).floor() - 64.0;
    // rust: batch.sprite_region(
    // rust: atlas,
    // rust: "gui/title/minecraft",
    // rust: [logo_x, logo_y + y_offs, 256.0, 44.0],
    // rust: 256.0,
    // rust: 64.0,
    // rust: );
    // rust: batch.sprite_region(
    // rust: atlas,
    // rust: crate::title_edition::SPRITE,
    // rust: [edition_x, logo_y + 44.0 - 7.0 + y_offs, 128.0, 14.0],
    // rust: 128.0,
    // rust: 16.0,
    // rust: );
    // rust: let mut y_pos = logo_y + 100.0;
    // rust: let last = self.lines.len().saturating_sub(1);
    // rust: for (i, line) in self.lines.iter().enumerate() {
    // rust: let mut shift = y_offs;
    // rust: if i == last {
                // The last line stops in the middle of the screen.
    // rust: let diff = y_pos + y_offs - ((h as i32 / 2) as f32 - 6.0);
    // rust: if diff < 0.0 {
    // rust: shift -= diff;
}
}
    // rust: if y_pos + y_offs + 12.0 + 8.0 > 0.0 && y_pos + y_offs < h {
    // rust: let x = if self.centered.contains(&i) {
                    // GuiGraphicsExtractor.centeredText: x - width / 2.
    // rust: logo_x + 128.0 - (atlas.font.width_text(line) as i32 / 2) as f32
    // rust: } else {
    // rust: logo_x
}
    // rust: batch.text_styled(atlas, line, x, y_pos + shift, u32::MAX, true);
}
    // rust: y_pos += 12.0;
}
}
    // `extractMenuBackground`: `menu_background.png` tiled at 32 pixels,
    // scrolled by half the text's scroll.
menu_background :: proc(self: ^Self, batch: ^HudBatch, atlas: ^HudAtlas, w: f32, h: f32) {
}
    // rust: let v = (self.scroll * 0.5).rem_euclid(32.0);
    // rust: let start = batch.vertices.len();
    // rust: crate::ui::tiled(
    // rust: batch,
    // rust: atlas,
    // rust: "gui/menu_background",
    // rust: 0.0,
    // rust: -v,
    // rust: w,
    // rust: h + 32.0,
    // rust: 32.0,
    // rust: u32::MAX,
    // rust: );
    // rust: batch.clip_since(start, 0.0, 0.0, w, h);
}
}

    // rust: mod tests {
//     use super::*;

    // A resource root with only the credits texts: every glyph is the
    // missing one, 6 pixels wide.
screen :: proc(poem: bool, end: string, credits: string, post: string) -> W {
    // Ported from Horizon
    return {}
}
        // One directory per call: tests run in parallel, and two of them with
        // the same arguments used to remove each other's files.
NEXT :: std::sync::atomic::AtomicUsize::new(0)
    // rust: let n = NEXT.fetch_add(1, std::sync::atomic::Ordering::Relaxed);
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-win-screen-{}-{n}", std::process::id()));
    // rust: let texts = root.join("assets/minecraft/texts");
    // rust: std::fs::create_dir_all(&texts).unwrap();
    // rust: std::fs::write(texts.join("end.txt"), end).unwrap();
    // rust: std::fs::write(texts.join("credits.json"), credits).unwrap();
    // rust: std::fs::write(texts.join("postcredits.txt"), post).unwrap();
    // rust: let atlas = HudAtlas::fonts(&root).unwrap();
    // rust: let screen = WinScreen::new(poem, &root, "Steve", &atlas.font);
    // rust: let _ = std::fs::remove_dir_all(&root);
    // rust: screen
}
    // rust: const CREDITS: &str = r#"[{"section":"Studio","disciplines":[
    // rust: {"discipline":"","titles":[{"title":"Head","names":["Ada","Bo"]}]},
    // rust: {"discipline":"Art","titles":[{"title":"Artist","names":[]}]}]}]"#;

the_poem_names_the_player_and_scrambles_its_hidden_names :: proc() {
}
    // rust: let s = screen(
    // rust: true,
    // rust: "\u{a7}3Hello PLAYERNAME.\r\n\n\u{a7}2\u{a7}f\u{a7}k\u{a7}a\u{a7}bkey\n",
    // rust: "[]",
    // rust: "End.",
    // rust: );
    // rust: let lines: Vec<(String, bool)> = s.lines().map(|(t, c)| (t.plain(), c)).collect();
        // Each line then an empty one; the empty line adds no text line; 8
        // empty lines after each file.
    // rust: let mut want = vec!["Hello Steve.", ""];
    // rust: want.push("");
        // LegacyRandom(8124371).nextInt(4) + 3 scrambled characters.
    // rust: let n = LegacyRandom::new(8124371).next_int_bound(4).unwrap() as usize + 3;
    // rust: let hidden = format!("{}key", &"XXXXXXXX"[..n]);
    // rust: want.extend([hidden.as_str(), ""]);
    // rust: want.extend([""; 8]);
    // rust: want.extend(["End.", ""]);
    // rust: want.extend([""; 8]);
    // rust: assert_eq!(
    // rust: lines,
    // rust: want.iter()
    // rust: .map(|l| (l.to_string(), false))
    // rust: .collect::<Vec<_>>()
    // rust: );
    // rust: let hidden_line = s.lines().nth(3).unwrap().0;
    // rust: let styles: Vec<_> = hidden_line.chars().map(|(_, s)| s.obfuscated).collect();
    // rust: assert!(styles[..n].iter().all(|o| *o == Some(true)));
    // rust: assert_eq!(s.total_scroll_length, lines.len() as i32 * 12);
}

long_poem_lines_wrap_at_256_pixels :: proc() {
}
        // 6-pixel glyphs: 42 fit a line, and the space at each break goes.
    // rust: let line = vec!["a"; 50].join(" ");
    // rust: let s = screen(true, &line, "[]", "");
    // rust: let lines: Vec<String> = s.lines().take(4).map(|(t, _)| t.plain()).collect();
    // rust: assert_eq!(
    // rust: lines.iter().map(|l| l.chars().count()).collect::<Vec<_>>(),
    // rust: [41, 41, 15, 0]
    // rust: );
    // rust: assert!(lines.iter().all(|l| !l.starts_with(' ')));
}
credits_centre_the_headings_and_list_the_names :: proc() {
}
    // rust: let s = screen(false, "ignored", CREDITS, "ignored");
    // rust: let lines: Vec<(String, bool)> = s.lines().map(|(t, c)| (t.plain(), c)).collect();
    // rust: let l = |s: &str, c| (s.to_string(), c);
    // rust: let names = |n: &str| l(&format!("{NAME_PREFIX}{n}"), false);
    // rust: assert_eq!(
    // rust: lines,
    // rust: vec![
    // rust: l(SECTION_HEADING, true),
    // rust: l("Studio", true),
    // rust: l(SECTION_HEADING, true),
    // rust: l("", false),
    // rust: l("", false),
    // rust: l("Head", false),
    // rust: names("Ada"),
    // rust: names("Bo"),
    // rust: l("", false),
    // rust: l("", false),
    // rust: l("Art", true),
    // rust: l("", false),
    // rust: l("", false),
    // rust: l("Artist", false),
    // rust: l("", false),
    // rust: l("", false),
    // rust: ]
    // rust: );
    // rust: let color = |i: usize| s.lines().nth(i).unwrap().0.chars().next().unwrap().1.color;
    // rust: assert_eq!(
    // rust: [color(0), color(1), color(5), color(6), color(10)],
    // rust: [
    // rust: Some(text::WHITE),
    // rust: Some(text::YELLOW),
    // rust: Some(text::GRAY),
    // rust: Some(text::WHITE),
    // rust: Some(text::YELLOW)
    // rust: ]
    // rust: );
        // narratorComponents: the section rules aren't read, empty lines are
        // empty parts.
    // rust: let p = NAME_PREFIX;
    // rust: assert_eq!(
    // rust: s.screen_info().title,
    // rust: format!("Studio. . . Head. {p}Ada. {p}Bo. . . Art. . . Artist. . ")
    // rust: );
}

the_poem_is_narrated_as_read_line_by_line :: proc() {
}
    // rust: let s = screen(true, "Hello PLAYERNAME.\n", "[]", "End.");
    // rust: let empty = ". ".repeat(9);
    // rust: let poem = format!("Hello Steve.{empty}. End.{empty}");
    // rust: assert_eq!(s.screen_info().title, poem);
    // rust: assert_eq!(s.screen_info().id, "win");
}

keys_set_the_scroll_speed_and_direction :: proc() {
}
    // rust: let mut s = screen(false, "", CREDITS, "");
    // rust: assert_eq!(s.scroll_speed, 0.75);
    // rust: s.key(Key::Space, true);
    // rust: assert_eq!(s.scroll_speed, 0.75 * 5.0);
    // rust: s.key(Key::LeftControl, true);
    // rust: s.key(Key::RightControl, true);
    // rust: assert_eq!(s.scroll_speed, 0.75 * 35.0);
    // rust: s.key(Key::Up, true);
    // rust: assert_eq!(s.scroll_speed, -0.75 * 35.0);
    // rust: s.key(Key::Space, false);
    // rust: assert_eq!(s.scroll_speed, -0.75);
    // rust: s.key(Key::Up, false);
    // rust: s.key(Key::LeftControl, false);
    // rust: assert_eq!(s.scroll_speed, 0.75);
        // The poem rolls at 0.5 pixels a tick.
    // rust: assert_eq!(screen(true, "", CREDITS, "").scroll_speed, 0.5);
}

the_screen_ends_once_everything_rolled_past :: proc() {
}
    // rust: let mut s = screen(false, "", CREDITS, "");
    // rust: let atlas = HudAtlas::fonts(Path::new("/nonexistent")).unwrap();
    // rust: let mut batch = HudBatch::new([640, 480]);
    // rust: let h = batch.height;
    // rust: let end = (s.total_scroll_length as f32 + 2.0 * h + 24.0) / 0.75;
    // rust: s.draw(&mut batch, &atlas, end - 1.0, EndPortalFill::default());
    // rust: assert!(!s.finished(h));
        // Scrolling back never goes above the start.
    // rust: s.key(Key::Up, true);
    // rust: s.draw(&mut batch, &atlas, end * 2.0, EndPortalFill::default());
    // rust: assert_eq!(s.scroll(), 0.0);
    // rust: s.key(Key::Up, false);
    // rust: s.draw(&mut batch, &atlas, end + 1.0, EndPortalFill::default());
    // rust: assert!(s.finished(h));
}
}
