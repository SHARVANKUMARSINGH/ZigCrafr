//! Transpiled from Horizon Rust crate
package horizon_client_render_split_profiles

import "core:fmt"
import "core:mem"
import "core:math"

// Splitscreen's profile page (Horizon's Splitscreen setting): a joining player picks a profile,
// or makes one, before entering P1's world, and a player in it switches to another from its
// pause menu (Splitscreen Settings), playing on until the new one can join. A profile is a name
// (instance-local offline names and the launcher's Microsoft accounts), with its own options. The
// game fills the list when the page opens (`filled`), takes the choice, and says why a pick
// can't play (`refused`). Built from vanilla's widgets.
// use crate::{
    // rust: gamepad::{Button as PadButton, GlyphStyle},
    // rust: graphics_style,
    // rust: hud::{HudAtlas, HudBatch, rgba},
    // rust: lang, pad_glyph,
    // rust: text::Text,
    // rust: ui,
}

// A string of this page: the language table's, or the English text.
tr :: proc(key: string, english: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: lang::get_or(key, english)
}

// Leave room for navigation, creation and cancellation in a 240-pixel menu.
SHOWN :: 4
    // rust: pub mod store;
NAME_MAX :: 16

// A player name a server takes, and so a profile's folder name: 3 to 16 letters, digits or
// underscores.
valid_name :: proc(name: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: (3..=NAME_MAX).contains(&name.len())
    // rust: && name.chars().all(|c| c.is_ascii_alphanumeric() || c == '_')
}

// `text` in lines no wider than `max` (by `width`), broken between words.
wrap :: proc(text: string, max: f32, width: impl Fn(string) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let mut lines = Vec::new();
    // rust: let mut line = String::new();
    // rust: for word in text.split_whitespace() {
    // rust: let longer = if line.is_empty() {
    // rust: word.to_owned()
    // rust: } else {
    // rust: format!("{line} {word}")
}
    // rust: if width(&longer) > max && !line.is_empty() {
    // rust: lines.push(std::mem::replace(&mut line, word.to_owned()));
    // rust: } else {
    // rust: line = longer;
}
}
    // rust: if !line.is_empty() {
    // rust: lines.push(line);
}
    // rust: lines
}

SplitProfiles :: struct {
    // The game filled the page since it opened.
    filled: bool,
    // The profiles; those playing now (none can be picked twice); the signed-in Microsoft
    // accounts among them; and the one this player plays as (switching; none while joining).
    names: [dynamic]string,
    taken: [dynamic]string,
    accounts: [dynamic]string,
    offline_accounts: [dynamic]string,
    current: Maybe(string),
    // Why the last pick can't play (an online server, an expired sign-in), until the next.
    refused: Maybe(string),
    // Where this player's view is now, as its bumpers name it ("Window 1 (2 of 2)"): the game
    // sets it every frame the page is open.
    place: Maybe(string),
    // A profile's name, or `None` for Cancel. Taken once.
    choice: Maybe(Option<string)>,
    page: uint,
    // The offline profile whose bin button was pressed: the confirmation page.
    forgetting: Maybe(string),
    forgotten: Maybe(string),
    // New Profile...: the name being typed.
    new: Maybe(ui::EditBox),
}

// What a press did, for the options screen.
Click :: enum {
    Nothing,
    Pressed,
    // Cancel: the page closes.
    Done,
}

Target :: enum {
    Profile(usize),
    New,
    Cancel,
    Create,
    Back,
    Remove(usize),
    Forget,
    Keep,
    Previous,
    Next,
}

// A button: where, what it says, whether it can be pressed, what it does.
    // rust: type Button = ([f32; 4], String, bool, Target);

// The name field's top on the New Profile page.
field_top :: proc(h: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: ((h.ceil() - 234.0) / 2.0).floor() + 39.0
}

    // rust: impl SplitProfiles {
    // The page shown: the last one there is once the list has shrunk (a profile forgotten).
page :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.page.min(self.names.len().saturating_sub(1) / SHOWN)
}

    // Opened: empty until the game fills it.
reset :: proc(self: ^Self) {
}
    // rust: *self = Self::default();
}

    // The joining player's pick (`Some(name)`), or Cancel (`None`). Taken once.
take_choice :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.choice.take()
}

take_forgotten :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.forgotten.take()
}

editable :: proc(self: ^Self, name: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.accounts.contains(&name.to_owned()) && !self.taken.contains(&name.to_owned())
}

buttons :: proc(self: ^Self, w: f32, h: f32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let x = (w / 2.0).floor() - 100.0;
    // rust: let button = |y: f32, label: String, enabled: bool, target: Target| {
    // rust: ([x, y, 200.0, 20.0], label, enabled, target)
}
    // rust: if let Some(name) = &self.forgetting {
    // rust: return vec![
    // rust: button(
    // rust: 120.0,
    // rust: tr("horizon.splitscreen.profiles.forget", "Forget"),
    // rust: self.editable(name),
    // rust: Target::Forget,
    // rust: ),
    // rust: button(
    // rust: 144.0,
    // rust: lang::get_or("gui.cancel", "Cancel"),
    // rust: true,
    // rust: Target::Keep,
    // rust: ),
    // rust: ];
}
    // rust: if let Some(field) = &self.new {
    // rust: let name = field.value.trim();
            // A new name: not one on the list already.
    // rust: let ok = valid_name(name) && !self.names.iter().any(|n| n.eq_ignore_ascii_case(name));
    // rust: let top = field_top(h);
    // rust: return vec![
    // rust: button(
    // rust: top + 25.0,
    // rust: tr("horizon.splitscreen.profiles.create", "Create"),
    // rust: ok,
    // rust: Target::Create,
    // rust: ),
    // rust: button(
    // rust: top + 50.0,
    // rust: lang::get_or("gui.back", "Back"),
    // rust: true,
    // rust: Target::Back,
    // rust: ),
    // rust: ];
}
    // rust: let mut buttons = Vec::new();
    // rust: for (i, name) in self
    // rust: .names
    // rust: .iter()
    // rust: .enumerate()
    // rust: .skip(self.page() * SHOWN)
    // rust: .take(SHOWN)
    // rust: {
    // rust: let microsoft = self.accounts.contains(name);
    // rust: let mut label = name.clone();
    // rust: if microsoft {
    // rust: label.push_str(&if self.offline_accounts.contains(name) {
    // rust: tr("horizon.splitscreen.profiles.offline", " (Offline)")
    // rust: } else {
    // rust: tr("horizon.splitscreen.profiles.microsoft", " (Microsoft)")
    // rust: });
}
    // rust: if self.current.as_ref() == Some(name) {
    // rust: label.push_str(&tr("horizon.splitscreen.profiles.you", " - you"));
}
    // rust: let y = 44.0 + (i % SHOWN) as f32 * 24.0;
    // rust: buttons.push((
    // rust: [x, y, if microsoft { 200.0 } else { 176.0 }, 20.0],
    // rust: label,
    // rust: !self.taken.contains(name),
    // rust: Target::Profile(i),
    // rust: ));
    // rust: if !microsoft {
    // rust: buttons.push((
    // rust: [x + 180.0, y, 20.0, 20.0],
    // rust: tr("horizon.splitscreen.profiles.forget_named", "Forget %s")
    // rust: .replacen("%s", name, 1),
    // rust: self.editable(name),
    // rust: Target::Remove(i),
    // rust: ));
}
}
    // rust: let mut y = 52.0 + self.names.len().min(SHOWN) as f32 * 24.0;
    // rust: if self.names.len() > SHOWN {
    // rust: buttons.push((
    // rust: [x, y, 98.0, 20.0],
    // rust: tr("horizon.splitscreen.profiles.previous", "Previous"),
    // rust: self.page() > 0,
    // rust: Target::Previous,
    // rust: ));
    // rust: buttons.push((
    // rust: [x + 102.0, y, 98.0, 20.0],
    // rust: tr("horizon.splitscreen.profiles.next", "Next"),
    // rust: (self.page() + 1) * SHOWN < self.names.len(),
    // rust: Target::Next,
    // rust: ));
    // rust: y += 24.0;
}
    // rust: buttons.push(button(
    // rust: y,
    // rust: tr("horizon.splitscreen.profiles.new_button", "New Profile..."),
    // rust: true,
    // rust: Target::New,
    // rust: ));
    // rust: let cancel = lang::get_or("gui.cancel", "Cancel");
    // rust: buttons.push(button(y + 24.0, cancel, true, Target::Cancel));
    // rust: buttons
}

    // rust: pub fn draw(
    // rust: &mut self,
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: cursor: (f32, f32),
    // rust: in_world: bool,
    // rust: style: GlyphStyle,
    // rust: ) {
    // rust: let (w, h) = (batch.width.ceil(), batch.height.ceil());
    // rust: ui::menu_background(batch, atlas, 0.0, 0.0, w, h, in_world);
    // rust: let grey = rgba(160, 160, 160, 255);
    // rust: let line = |batch: &mut HudBatch, text: &str, y: f32, color: u32| {
    // rust: ui::centered_text(batch, atlas, &Text::literal(text), 0.0, y, w, color);
}
    // rust: let buttons = self.buttons(w, h);
    // rust: if let Some(name) = &self.forgetting {
    // rust: graphics_style::title(
    // rust: batch,
    // rust: atlas,
    // rust: &Text::literal(tr(
    // rust: "horizon.splitscreen.profiles.forget_title",
    // rust: "Forget profile?",
    // rust: )),
    // rust: );
    // rust: line(batch, name, 52.0, u32::MAX);
    // rust: line(
    // rust: batch,
    // rust: &tr(
    // rust: "horizon.splitscreen.profiles.forget_leaves",
    // rust: "It leaves this instance's list.",
    // rust: ),
    // rust: 76.0,
    // rust: grey,
    // rust: );
    // rust: line(
    // rust: batch,
    // rust: &tr(
    // rust: "horizon.splitscreen.profiles.forget_kept",
    // rust: "World progress and settings are kept.",
    // rust: ),
    // rust: 90.0,
    // rust: grey,
    // rust: );
    // rust: if let Some(why) = &self.refused {
    // rust: line(batch, why, 176.0, rgba(255, 85, 85, 255));
}
    // rust: } else if let Some(field) = &mut self.new {
    // rust: graphics_style::title(
    // rust: batch,
    // rust: atlas,
    // rust: &Text::literal(tr("horizon.splitscreen.profiles.new_title", "New Profile")),
    // rust: );
    // rust: let (x, top) = ((w / 2.0).floor() - 100.0, field_top(h));
    // rust: let label = tr(
    // rust: "horizon.splitscreen.profiles.name_hint",
    // rust: "Name (3 to 16 letters, digits, _)",
    // rust: );
    // rust: batch.text(atlas, &label, x, top - 14.0, grey, true);
    // rust: (field.x, field.y, field.width, field.height) = (x, top, 200.0, 20.0);
    // rust: field.draw(batch, atlas, None);
    // rust: } else {
    // rust: let title = match self.current {
    // rust: Some(_) => tr(
    // rust: "horizon.splitscreen.profiles.switch_title",
    // rust: "Switch profile",
    // rust: ),
    // rust: None => tr("horizon.pages.split_profiles", "Who's playing?"),
}
    // rust: graphics_style::title(batch, atlas, &Text::literal(title));
    // rust: self.draw_bumpers(batch, atlas, style);
            // Under Cancel: where offline profiles live.
    // rust: let y = buttons.last().map_or(0.0, |b| b.0[1] + 30.0);
    // rust: line(
    // rust: batch,
    // rust: &tr(
    // rust: "horizon.splitscreen.profiles.offline_note",
    // rust: "Offline profiles belong to this instance",
    // rust: ),
    // rust: y,
    // rust: grey,
    // rust: );
            // Why the last pick can't play, wrapped to the view (a quarter of a window is narrow).
    // rust: let width = |text: &str| HudBatch::text_width(atlas, text).ceil();
    // rust: let why = self.refused.as_deref().unwrap_or_default();
    // rust: for (k, text) in wrap(why, (w - 24.0).min(300.0), width).iter().enumerate() {
    // rust: line(
    // rust: batch,
    // rust: text,
    // rust: y + 14.0 + 10.0 * k as f32,
    // rust: rgba(255, 85, 85, 255),
    // rust: );
}
}
    // rust: let mut tip = None;
    // rust: for ([x, y, bw, bh], label, enabled, target) in &buttons {
    // rust: let hover = ui::hovered(cursor, *x, *y, *bw, *bh);
    // rust: let remove = matches!(target, Target::Remove(_));
    // rust: if hover && let Target::Profile(i) = target {
    // rust: let name = &self.names[*i];
    // rust: if self.accounts.contains(name) {
    // rust: tip = Some(if self.offline_accounts.contains(name) {
    // rust: tr(
    // rust: "horizon.splitscreen.profiles.sign_in",
    // rust: "Sign in again in the launcher",
    // rust: )
    // rust: } else {
    // rust: tr("horizon.splitscreen.profiles.online", "Microsoft online")
    // rust: });
}
}
    // rust: let mut text = Text::literal(if remove { "" } else { label });
    // rust: if matches!(target, Target::Forget) {
    // rust: text = text.with_color(0xFF5555);
}
    // rust: let action = match target {
    // rust: Target::Keep | Target::Cancel => Some(crate::widgets::Action::Cancel),
    // rust: Target::Back => Some(crate::widgets::Action::Back),
    // rust: _ => None,
}
    // rust: if let Some(action) = action {
    // rust: crate::widgets::declare_action(action, [*x, *y, *bw, *bh], *enabled);
}
    // rust: ui::button(batch, atlas, *x, *y, *bw, *bh, &text, *enabled, hover);
    // rust: if remove {
    // rust: crate::widgets::record(label, [*x, *y, *bw, *bh], *enabled);
    // rust: let color = if *enabled { u32::MAX } else { grey };
                // A bin glyph, independent of font coverage, with an accessible widget label.
    // rust: for (row, bits) in [
    // rust: 0b0011100u8,
    // rust: 0b1111111,
    // rust: 0b0101010,
    // rust: 0b0101010,
    // rust: 0b0101010,
    // rust: 0b0111110,
    // rust: ]
    // rust: .iter()
    // rust: .enumerate()
    // rust: {
    // rust: for col in 0..7 {
    // rust: if bits & (1 << (6 - col)) != 0 {
    // rust: batch.fill(
    // rust: atlas,
    // rust: x + 6.0 + col as f32,
    // rust: y + 7.0 + row as f32,
    // rust: 1.0,
    // rust: 1.0,
    // rust: color,
    // rust: );
}
}
}
    // rust: if hover {
    // rust: tip = Some(label.clone());
}
}
}
    // rust: if let Some(tip) = tip {
    // rust: ui::tooltip(batch, atlas, &[Text::literal(tip)], cursor);
}
}

    // Under the title: the bumpers as keys, as the prompts over a player's view draw them (the
    // controller's own symbols, in its colours), then where they put the view.
draw_bumpers :: proc(self: ^Self, batch: ^HudBatch, atlas: ^HudAtlas, style: GlyphStyle) {
}
    // rust: let width = |text: &str| HudBatch::text_width(atlas, text).ceil();
    // rust: let words = match &self.place {
    // rust: Some(place) => tr(
    // rust: "horizon.splitscreen.profiles.move_place",
    // rust: "Move where you play: %s",
    // rust: )
    // rust: .replacen("%s", place, 1),
    // rust: None => tr("horizon.splitscreen.profiles.move", "Move where you play"),
}
    // rust: let keys = [PadButton::LeftBumper, PadButton::RightBumper];
    // rust: let key_width = |b: PadButton| pad_glyph::width(atlas, b, style);
    // rust: let total = keys.iter().map(|&b| key_width(b) + 4.0).sum::<f32>() + 2.0 + width(&words);
    // rust: let (mut x, y) = (((batch.width - total) / 2.0).floor(), 30.0);
    // rust: for b in keys {
    // rust: let kw = key_width(b);
            // A light edge around a dark key: it stands out on the menu's dark background.
    // rust: if pad_glyph::art(atlas, b, style).is_none() {
    // rust: batch.fill(
    // rust: atlas,
    // rust: x - 2.0,
    // rust: y - 3.0,
    // rust: kw + 2.0,
    // rust: pad_glyph::HEIGHT + 2.0,
    // rust: rgba(170, 170, 170, 255),
    // rust: );
}
    // rust: pad_glyph::draw(batch, atlas, b, style, x, y);
    // rust: x += kw + 4.0;
}
    // rust: batch.text(atlas, &words, x + 2.0, y, rgba(240, 240, 240, 255), true);
}

    // A press at `(x, y)` on a screen `w` x `h`.
click :: proc(self: ^Self, atlas: ^HudAtlas) {
}
    // rust: let hit = self
    // rust: .buttons(w, h)
    // rust: .into_iter()
    // rust: .find(|([bx, by, bw, bh], _, enabled, _)| {
    // rust: *enabled && ui::hovered((x, y), *bx, *by, *bw, *bh)
    // rust: });
    // rust: let Some((_, _, _, target)) = hit else {
            // The name field takes the click on it, and the focus.
    // rust: if let Some(field) = &mut self.new {
    // rust: field.focused = ui::hovered((x, y), field.x, field.y, field.width, field.height);
    // rust: if field.focused {
    // rust: field.click(atlas, x, false, false);
}
}
    // rust: return Click::Nothing;
}
    // rust: match target {
    // rust: Target::Profile(i) => {
    // rust: self.refused = None;
    // rust: self.choice = self.names.get(i).cloned().map(Some);
}
    // rust: Target::Remove(i) => {
    // rust: self.forgetting = self.names.get(i).cloned();
    // rust: self.refused = None;
}
    // rust: Target::Keep => self.forgetting = None,
    // rust: Target::Forget => self.forgotten = self.forgetting.take(),
    // rust: Target::New => {
    // rust: let mut field = ui::EditBox::new(0.0, 0.0, 200.0, 20.0);
    // rust: field.max_length = NAME_MAX;
    // rust: self.new = Some(field);
}
    // rust: Target::Previous => self.page = self.page().saturating_sub(1),
    // rust: Target::Next => self.page = self.page() + 1,
    // rust: Target::Create => self.create(),
    // rust: Target::Back => self.new = None,
    // rust: Target::Cancel => {
    // rust: self.choice = Some(None);
    // rust: return Click::Done;
}
}
    // rust: Click::Pressed
}

    // Create (or Enter on the name): the new profile plays, if the name will do.
create :: proc(self: ^Self) {
}
    // rust: let can = self
    // rust: .buttons(0.0, 0.0)
    // rust: .iter()
    // rust: .any(|b| b.3 == Target::Create && b.2);
    // rust: if let (true, Some(field)) = (can, &self.new) {
    // rust: self.refused = None;
    // rust: self.choice = Some(Some(field.value.trim().to_owned()));
    // rust: self.new = None;
}
}

type_text :: proc(self: ^Self, text: string) {
}
    // rust: if let Some(field) = self.new.as_mut().filter(|f| f.focused) {
    // rust: field.insert_text(text);
}
}

    // A key: true when the page took it. On New Profile Escape goes back to the list and Enter
    // creates; on the list Escape is the options screen's (it closes the page) and counts as Cancel.
key :: proc(self: ^Self, key: winit::keyboard::KeyCode, text: Maybe(string)) -> b {
    // Ported from Horizon
    return {}
}
//         use winit::keyboard::KeyCode as K;
    // rust: if self.forgetting.is_some() {
    // rust: if key == K::Escape {
    // rust: self.forgetting = None;
}
    // rust: return true;
}
    // rust: let Some(field) = &mut self.new else {
            // The options screen closes the page: the game hears it as Cancel.
    // rust: if key == K::Escape {
    // rust: self.choice = Some(None);
}
    // rust: return false;
}
    // rust: match key {
    // rust: K::Escape => self.new = None,
    // rust: K::Enter | K::NumpadEnter => self.create(),
    // rust: _ if field.focused => {
    // rust: if !field.key(key, false, false)
    // rust: && let Some(t) = text
    // rust: {
    // rust: let typed: String = t.chars().filter(|c| !c.is_control()).collect();
    // rust: field.insert_text(&typed);
}
}
    // rust: _ => {}
}
    // rust: true
}

    // Ctrl+A/C/V/X in the name field; false when it isn't shown with the focus.
    // rust: pub fn shortcut(
    // rust: &mut self,
    // rust: shortcut: crate::clipboard::EditShortcut,
    // rust: clipboard: &mut dyn crate::clipboard::Clipboard,
    // rust: ) -> bool {
    // rust: match self.new.as_mut().filter(|f| f.focused) {
    // rust: Some(field) => {
    // rust: field.shortcut(shortcut, clipboard);
    // rust: true
}
    // rust: None => false,
}
}

    // For the control socket: the list (once filled), or the new name being typed.
state :: proc(self: ^Self) -> s {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(name) = &self.forgetting {
    // rust: return serde_json::json!({"mode": "splitscreen-forget-profile", "profile": name});
}
    // rust: match &self.new {
    // rust: Some(field) => serde_json::json!({
    // rust: "mode": "splitscreen-new-profile",
    // rust: "fields": { "name": field.value },
    // rust: }),
            // Until the game fills the list: the page is not ready to pick from.
    // rust: None if !self.filled => serde_json::json!({ "mode": "splitscreen-profiles-loading" }),
    // rust: None => serde_json::json!({
    // rust: "mode": "splitscreen-profiles",
    // rust: "profiles": self.names,
    // rust: "taken": self.taken,
    // rust: "refused": self.refused,
    // rust: }),
}
}
}

    // rust: mod tests {
//     use super::*;

a_notice_wraps_to_the_view_between_words :: proc() {
}
        // Each character 6 wide: no line over 60.
    // rust: let width = |s: &str| 6.0 * s.len() as f32;
    // rust: let lines = wrap("This server needs each player's own account", 60.0, width);
    // rust: assert!(lines.iter().all(|l| width(l) <= 60.0));
    // rust: assert_eq!(
    // rust: lines.join(" "),
    // rust: "This server needs each player's own account"
    // rust: );
        // A word longer than the line keeps a line of its own.
    // rust: assert_eq!(
    // rust: wrap("a verylongwordindeed b", 30.0, width),
    // rust: ["a", "verylongwordindeed", "b"]
    // rust: );
    // rust: assert!(wrap("", 60.0, width).is_empty());
}

forgetting_the_last_page_s_only_profile_shows_the_page_before :: proc() {
}
    // rust: let atlas = atlas();
    // rust: let mut p = SplitProfiles {
    // rust: names: (0..5).map(|i| format!("Player{i}")).collect(),
    // rust: ..Default::default()
}
    // rust: press(&mut p, &atlas, "Next");
        // Player4 forgotten: the game fills the list again with four names.
    // rust: p.names.pop();
    // rust: assert!(p.buttons(427.0, 240.0).iter().any(|b| b.1 == "Player3"));
}

every_profile_can_be_picked_across_pages :: proc() {
}
    // rust: let atlas = atlas();
    // rust: let mut p = SplitProfiles {
    // rust: names: (0..11).map(|i| format!("Player{i}")).collect(),
    // rust: ..Default::default()
}
    // rust: p.accounts = vec!["Player10".into()];
    // rust: press(&mut p, &atlas, "Next");
    // rust: press(&mut p, &atlas, "Next");
    // rust: press(&mut p, &atlas, "Player10 (Microsoft)");
    // rust: assert_eq!(p.take_choice(), Some(Some("Player10".into())));
    // rust: press(&mut p, &atlas, "Previous");
    // rust: assert!(p.buttons(427.0, 240.0).iter().any(|b| b.1 == "Player4"));
}

unavailable_accounts_are_marked_and_cannot_be_forgotten :: proc() {
}
    // rust: let mut p = SplitProfiles {
    // rust: names: vec!["Cal".into()],
    // rust: accounts: vec!["Cal".into()],
    // rust: offline_accounts: vec!["Cal".into()],
    // rust: ..Default::default()
}
    // rust: assert!(!p.editable("Cal"));
    // rust: let buttons = p.buttons(427.0, 240.0);
    // rust: assert!(buttons.iter().any(|b| b.1 == "Cal (Offline)" && b.2));
    // rust: assert!(!buttons.iter().any(|b| b.1 == "Forget Cal"));
    // rust: press(&mut p, &atlas(), "Cal (Offline)");
    // rust: assert_eq!(p.take_choice(), Some(Some("Cal".into())));
}

profile_names_are_player_names :: proc() {
}
    // rust: assert!(valid_name("Steve_2"));
    // rust: assert!(!valid_name(""));
    // rust: assert!(!valid_name("ab"));
    // rust: assert!(!valid_name("has space"));
    // rust: assert!(!valid_name("seventeen_chars_x"));
}

atlas :: proc() -> H {
    // Ported from Horizon
    return {}
}
    // rust: HudAtlas::build(std::path::Path::new("/nonexistent/horizon-test-assets")).unwrap()
}

page :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: SplitProfiles {
    // rust: filled: true,
    // rust: names: vec!["Ann".into(), "Bea".into()],
    // rust: taken: vec!["Ann".into()],
    // rust: current: Some("Ann".into()),
    // rust: ..Default::default()
}
}

press :: proc(page: ^SplitProfiles, atlas: ^HudAtlas, label: string) -> C {
    // Ported from Horizon
    return {}
}
    // rust: let ([x, y, _, _], ..) = page
    // rust: .buttons(427.0, 240.0)
    // rust: .into_iter()
    // rust: .find(|b| b.1 == label)
    // rust: .unwrap_or_else(|| panic!("no {label}"));
    // rust: page.click(atlas, (x + 1.0, y + 1.0), (427.0, 240.0))
}

the_bin_asks_then_forgets_a_free_offline_profile :: proc() {
}
    // rust: let atlas = atlas();
    // rust: let mut p = page();
        // Ann plays: her bin is greyed.
    // rust: let buttons = p.buttons(427.0, 240.0);
    // rust: assert!(buttons.iter().any(|b| b.1 == "Forget Ann" && !b.2));
    // rust: press(&mut p, &atlas, "Forget Bea");
    // rust: assert_eq!(p.state()["mode"], "splitscreen-forget-profile");
    // rust: press(&mut p, &atlas, "Cancel");
    // rust: assert_eq!(p.take_forgotten(), None);
    // rust: press(&mut p, &atlas, "Forget Bea");
    // rust: press(&mut p, &atlas, "Forget");
    // rust: assert_eq!(p.take_forgotten(), Some("Bea".into()));
    // rust: assert_ne!(p.state()["mode"], "splitscreen-forget-profile");
}

the_one_playing_now_is_marked_and_cant_be_picked :: proc() {
}
    // rust: let p = page();
    // rust: let buttons = p.buttons(427.0, 240.0);
    // rust: let you = buttons.iter().find(|b| b.1 == "Ann - you").unwrap();
    // rust: assert!(!you.2);
    // rust: assert!(buttons.iter().any(|b| b.1 == "Bea" && b.2));
}

a_pick_clears_the_last_refusal_and_cancel_closes :: proc() {
}
    // rust: let atlas = atlas();
    // rust: let mut p = page();
    // rust: p.refused = Some("This server is in online mode".into());
    // rust: press(&mut p, &atlas, "Bea");
    // rust: assert_eq!(
    // rust: (p.take_choice(), p.refused.as_ref()),
    // rust: (Some(Some("Bea".into())), None)
    // rust: );
    // rust: assert!(p.take_choice().is_none());
    // rust: assert!(matches!(press(&mut p, &atlas, "Cancel"), Click::Done));
    // rust: assert_eq!(p.take_choice(), Some(None));
}

a_new_name_must_be_new_and_valid :: proc() {
}
    // rust: let atlas = atlas();
    // rust: let mut p = page();
    // rust: press(&mut p, &atlas, "New Profile...");
    // rust: let create = |p: &SplitProfiles| p.buttons(427.0, 240.0)[0].2;
    // rust: p.type_text("bea");
    // rust: assert!(!create(&p), "on the list already, whatever the case");
    // rust: p.key(winit::keyboard::KeyCode::Backspace, None);
    // rust: p.type_text("x");
    // rust: assert!(create(&p));
    // rust: p.key(winit::keyboard::KeyCode::Enter, None);
    // rust: assert_eq!(p.take_choice(), Some(Some("bex".into())));
        // Escape on New Profile goes back to the list, not out of the page.
    // rust: press(&mut p, &atlas, "New Profile...");
    // rust: assert!(p.key(winit::keyboard::KeyCode::Escape, None));
    // rust: assert!(!p.key(winit::keyboard::KeyCode::Escape, None));
    // rust: assert_eq!(
    // rust: p.take_choice(),
    // rust: Some(None),
    // rust: "Escape on the list cancels, as Cancel does"
    // rust: );
}
}
