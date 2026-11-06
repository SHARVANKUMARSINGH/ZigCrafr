//! Transpiled from Horizon Rust crate
package horizon_client_render_split_ui

import "core:fmt"
import "core:mem"
import "core:math"

// Setup's monitor map and draft window choices. Apply is consumed by the game adapter.
// use crate::{
    // rust: gamepad::Button as PadButton,
    // rust: graphics_style,
    // rust: hud::{HudAtlas, HudBatch, rgba},
    // rust: lang,
    // rust: split_layout::{Draft, Monitor, Placement, Spot, Warning, ordered},
    // rust: split_map::{self, BOTTOM, uncovered},
    // rust: text::Text,
    // rust: ui,
}

// Resolve against the selected language on every draw, with bundled English
// defaults even in a resource-free UI test. Arguments use Minecraft's formatter.
tr :: proc(key: string, args: ^[^dyn std::fmt::Display]) -> S {
    // Ported from Horizon
    return {}
}
ENGLISH :: std::sync::OnceLock::new()
    // rust: let key = if key.starts_with("horizon.") {
    // rust: key.to_owned()
    // rust: } else {
    // rust: format!("horizon.splitscreen.setup.{key}")
}
    // rust: let template = lang::current()
    // rust: .and_then(|language| language.get(&key).map(str::to_owned))
    // rust: .unwrap_or_else(|| {
    // rust: ENGLISH
    // rust: .get_or_init(|| lang::Language::load(&[], "en_us"))
    // rust: .get(&key)
    // rust: .unwrap_or(&key)
    // rust: .to_owned()
    // rust: });
    // rust: let args: Vec<_> = args
    // rust: .iter()
    // rust: .map(|arg| Text::literal(arg.to_string()))
    // rust: .collect();
    // rust: crate::text::format_translation(&template, &args).plain()
}

SplitUi :: struct {
    on: bool,
    idle: bool,
    live: Maybe(Draft),
    monitors: [dynamic]Monitor,
    main: string,
    names: [dynamic]string,
    apply: Maybe(Draft),
    // Identify pressed: every view says which window it is in.
    identify: bool,
    // Names: the names in the views' corners are shown (the game sets it), and pressed.
    names_shown: bool,
    toggle_names: bool,
    // P1 has a controller (the game sets it), and Give Up Pad pressed: it's offered to join.
    p1_pad: bool,
    give_up_pad: bool,
    edit: Maybe(Draft),
    selected: Maybe(uint),
    // A tile held by the mouse: whose, and where the pointer is (`None` until it moves).
    drag: Option<(uint,
    // A player picked up with the controller (A), moved with the bumpers.
    held: Maybe(Held),
    // Dropped or put back: the player whose tile the controller's focus goes to.
    refocus: Maybe(uint),
    // The screen's size: at the last draw (the options screen sets it) or press.
    // rust: pub(crate) size: (f32, f32),
}

// A player picked up with the controller: where it could go, the one picked so far, and the
// draft with it there (the map shows it).
Held :: struct {
    player: uint,
    spots: Vec<(string,
    at: Maybe(uint),
    preview: Maybe(Draft),
}

// Where a dragged player goes: a place (`Spot`), or a place among a window's players.
Drop :: enum {
    At(Spot),
    // Place `k` among the players of a window (before its `k`th; past the last: after them).
    Place(u8, usize),
}

Target :: enum {
    Player(usize),
    Move(Spot),
    Two,
    Three,
    Identify,
    // The players' names in their views' corners, on or off.
    Names,
    // P1's controller freed and offered to join (handed to a friend).
    GiveUpPad,
    Revert,
    Apply,
    Done,
    Switch,
}
    // rust: type Button = ([f32; 4], String, Target, bool);

// How a layout's square button is drawn.
Glyph :: enum {
    Auto,
    // The panes in a 14 x 10 window, 1 px apart.
    Panes(&'static [[f32; 4]]),
}

// The glyph for a layout: 2 sharing (`splitscreen_two`: Auto, side by side, top and bottom) or
// 3 (`splitscreen_three`: one wide on top, one tall on the left, side by side).
layout_glyph :: proc(three: bool, layout: u8) -> G {
    // Ported from Horizon
    return {}
}
    // rust: match (three, layout) {
    // rust: (false, 0) => Glyph::Auto,
    // rust: (false, 1) => Glyph::Panes(&[[0.0, 0.0, 6.5, 10.0], [7.5, 0.0, 6.5, 10.0]]),
    // rust: (false, _) => Glyph::Panes(&[[0.0, 0.0, 14.0, 4.5], [0.0, 5.5, 14.0, 4.5]]),
    // rust: (true, 0) => Glyph::Panes(&[
    // rust: [0.0, 0.0, 14.0, 4.5],
    // rust: [0.0, 5.5, 6.5, 4.5],
    // rust: [7.5, 5.5, 6.5, 4.5],
    // rust: ]),
    // rust: (true, 1) => Glyph::Panes(&[
    // rust: [0.0, 0.0, 6.5, 10.0],
    // rust: [7.5, 0.0, 6.5, 4.5],
    // rust: [7.5, 5.5, 6.5, 4.5],
    // rust: ]),
    // rust: (true, _) => Glyph::Panes(&[
    // rust: [0.0, 0.0, 4.0, 10.0],
    // rust: [5.0, 0.0, 4.0, 10.0],
    // rust: [10.0, 0.0, 4.0, 10.0],
    // rust: ]),
}
}
Click :: enum {
    Nothing,
    Pressed,
    Done,
    Switch,
}

    // rust: impl SplitUi {
reset :: proc(self: ^Self) {
}
    // rust: self.edit = None;
    // rust: self.selected = None;
    // rust: self.apply = None;
    // rust: self.drag = None;
    // rust: self.held = None;
}
    // The draft shown: with a held player where the controller put it, else the changes so
    // far, else the arrangement now.
draft :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let preview = self.held.as_ref().and_then(|h| h.preview.as_ref());
    // rust: preview.or(self.edit.as_ref()).or(self.live.as_ref())
}

    // The controller (`pad_menu`), A at `at`: on a player's tile, picks it up. True when it did
    // (the press is taken).
pad_pick_up :: proc(self: ^Self, at: (f32) {
}
    // rust: let (w, h) = self.size;
    // rust: let hit = self
    // rust: .buttons(w, h)
    // rust: .into_iter()
    // rust: .rev()
    // rust: .find(|([x, y, bw, bh], _, _, active)| *active && ui::hovered(at, *x, *y, *bw, *bh));
    // rust: let Some((_, _, Target::Player(i), _)) = hit else {
    // rust: return false;
}
    // rust: self.selected = Some(i);
    // rust: let spots = self.stops(i);
    // rust: self.held = Some(Held {
    // rust: player: i,
    // rust: spots,
    // rust: at: None,
    // rust: preview: None,
    // rust: });
    // rust: true
}

    // The controller while a player is held: the bumpers or left and right cycle where it goes,
    // as when joining (the map shows it there), A drops it there (into the draft), B puts it
    // back. True when the button was taken: every button, while one is held.
pad_button :: proc(self: ^Self, button: PadButton) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(held) = &self.held else {
    // rust: return false;
}
    // rust: let player = held.player;
    // rust: match button {
    // rust: PadButton::LeftBumper
    // rust: | PadButton::RightBumper
    // rust: | PadButton::DPadLeft
    // rust: | PadButton::DPadRight => {
    // rust: let n = held.spots.len();
    // rust: if n == 0 {
    // rust: return true;
}
    // rust: let back = matches!(button, PadButton::LeftBumper | PadButton::DPadLeft);
    // rust: let next = match held.at {
    // rust: None if back => n - 1,
    // rust: None => 0,
    // rust: Some(k) if back => (k + n - 1) % n,
    // rust: Some(k) => (k + 1) % n,
}
    // rust: let (player, drop) = (held.player, held.spots[next].1.clone());
    // rust: let open = self.open_now();
    // rust: let preview = self.edit.clone().or(self.live.clone()).map(|mut draft| {
    // rust: match drop {
    // rust: Drop::At(spot) => draft.place_player(player, spot),
    // rust: Drop::Place(n, k) => {
    // rust: draft.place_player(player, Spot::Window(n));
    // rust: draft.put_at(player, k);
}
}
    // rust: draft.drop_empty(&open);
    // rust: draft
    // rust: });
    // rust: if let Some(held) = &mut self.held {
    // rust: held.at = Some(next);
    // rust: held.preview = preview;
}
}
    // rust: PadButton::South => {
    // rust: let held = self.held.take().expect("held");
                // One highlight after: the focus on the player where it landed, not selected too.
    // rust: (self.selected, self.refocus) = (None, Some(held.player));
    // rust: match held.at.map(|k| held.spots[k].1.clone()) {
    // rust: Some(Drop::At(spot)) => self.place(held.player, spot),
    // rust: Some(Drop::Place(n, k)) => self.place_at(held.player, n, k),
    // rust: None => {}
}
}
    // rust: PadButton::East => {
    // rust: (self.selected, self.refocus) = (None, Some(player));
    // rust: self.held = None;
}
            // While one is held, the focus stays put: A drops, it presses nothing else.
    // rust: _ => {}
}
    // rust: true
}

    // Whether a player is held (the controller's left and right cycle it).
holding :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.held.is_some()
}

    // The tile of the player just dropped or put back, for the controller's focus. Taken once.
take_refocus :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let i = self.refocus.take()?;
    // rust: let (w, h) = self.size;
    // rust: self.buttons(w, h)
    // rust: .into_iter()
    // rust: .find(|b| b.2 == Target::Player(i))
    // rust: .map(|b| b.0)
}
map :: proc(self: ^Self, w: f32, h: f32) -> s {
    // Ported from Horizon
    return {}
}
    // rust: if self.idle {
    // rust: return Default::default();
}
    // rust: self.draft()
    // rust: .map_or_else(Default::default, |draft| self.map_of(draft, w, h))
}
    // `draft` on the map (the one shown, or one a drag would make).
map_of :: proc(self: ^Self, draft: ^Draft, w: f32, h: f32) -> s {
    // Ported from Horizon
    return {}
}
    // rust: split_map::project(draft, &self.monitors, &self.main, w, h)
}
editing :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if self.edit.is_none() {
    // rust: self.edit = self.live.clone();
}
    // rust: self.edit.as_mut()
}

monitor_name :: proc(self: ^Self, name: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match self.monitors.iter().position(|m| m.name == name) {
    // rust: Some(n) => tr("monitor", &[&(n + 1)]),
    // rust: None => tr("monitor_unknown", &[]),
}
}

    // Where the selected player can go: the other windows, a new one, a monitor no window fills.
spots :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let (Some(draft), Some(i)) = (self.draft(), self.selected) else {
    // rust: return Vec::new();
}
    // rust: let mine = draft.players.get(i).copied();
    // rust: let mut spots: Vec<(String, Spot)> = draft
    // rust: .windows
    // rust: .iter()
    // rust: .filter(|w| Some(w.number) != mine)
    // rust: .map(|w| (tr("window", &[&w.number]), Spot::Window(w.number)))
    // rust: .collect();
    // rust: spots.push((tr("new_window", &[]), Spot::New));
    // rust: for m in &self.monitors {
    // rust: let filled = draft
    // rust: .windows
    // rust: .iter()
    // rust: .any(|w| w.placement == Placement::Fill(m.name.clone()));
    // rust: if m.name != self.main && !filled {
    // rust: spots.push((
    // rust: tr("fill_monitor", &[&self.monitor_name(&m.name)]),
    // rust: Spot::Fill(m.name.clone()),
    // rust: ));
}
}
    // rust: spots
}

    // Where player `i` can be dropped: each place among the players of each window ("Window 1
    // (2 of 3)"), a window of its own, a new window, a monitor no window fills. Never into
    // another player's place: it joins them.
stops :: proc(self: ^Self, i: uint) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let Some(draft) = self.draft() else {
    // rust: return Vec::new();
}
    // rust: let mut stops = Vec::new();
    // rust: for w in &draft.windows {
    // rust: let others = draft.sharing(i, w.number).len();
    // rust: if others == 0 {
    // rust: stops.push((tr("window", &[&w.number]), Drop::At(Spot::Window(w.number))));
}
    // rust: for k in (0..=others).filter(|_| others > 0) {
    // rust: let label = tr("window_place", &[&w.number, &(k + 1), &(others + 1)]);
    // rust: stops.push((label, Drop::Place(w.number, k)));
}
}
    // rust: stops.push((tr("new_window", &[]), Drop::At(Spot::New)));
    // rust: for m in &self.monitors {
    // rust: let filled = draft
    // rust: .windows
    // rust: .iter()
    // rust: .any(|w| w.placement == Placement::Fill(m.name.clone()));
    // rust: if m.name != self.main && !filled {
    // rust: let label = tr("fill_monitor", &[&self.monitor_name(&m.name)]);
    // rust: stops.push((label, Drop::At(Spot::Fill(m.name.clone()))));
}
}
    // rust: stops
}

    // Where a tile dropped at `(x, y)` goes: the window on top there, else the monitor's (a new
    // window on Window 1's monitor, the one filling another or a new one filling it).
drop_spot :: proc(self: ^Self) {
}
    // rust: let draft = self.draft()?;
    // rust: let (monitors, windows, _) = self.map(w, h);
    // rust: let inside = |[rx, ry, rw, rh]: [f32; 4]| x >= rx && x < rx + rw && y >= ry && y < ry + rh;
    // rust: if let Some((n, _)) = windows.iter().rev().find(|(_, r)| inside(*r)) {
    // rust: return Some(Spot::Window(*n));
}
    // rust: let m = &self.monitors[monitors.iter().position(|r| inside(*r))?];
    // rust: if m.name == self.main {
    // rust: return Some(Spot::New);
}
    // rust: Some(
    // rust: match draft
    // rust: .windows
    // rust: .iter()
    // rust: .find(|w| w.placement == Placement::Fill(m.name.clone()))
    // rust: {
    // rust: Some(win) => Spot::Window(win.number),
    // rust: None => Spot::Fill(m.name.clone()),
    // rust: },
    // rust: )
}

    // Every button: the players' tiles (window by window, as they stack), the move row, the
    // switch, Names and the layouts, and Identify, Revert, Apply and Done. Splitscreen off or
    // idle: the switch and Done.
buttons :: proc(self: ^Self, w: f32, h: f32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let row = |out: &mut Vec<Button>, y: f32, items: Vec<(f32, String, Target, bool)>| {
    // rust: let total: f32 = items.iter().map(|i| i.0 + 4.0).sum::<f32>() - 4.0;
    // rust: let mut x = ((w - total) / 2.0).floor();
    // rust: for (bw, label, target, active) in items {
    // rust: out.push(([x, y, bw, 20.0], label, target, active));
    // rust: x += bw + 4.0;
}
}
    // rust: let done = (
    // rust: 64.0,
    // rust: lang::get_or("gui.done", &tr("done", &[])),
    // rust: Target::Done,
    // rust: true,
    // rust: );
        // The switch, top right (P1's): off only once P1 plays alone (turning it off with others
        // in drops them all at once).
    // rust: let switch = (
    // rust: [w - 110.0, 6.0, 104.0, 20.0],
    // rust: tr(
    // rust: "switch",
    // rust: &[
    // rust: &tr("horizon.extras.splitscreen", &[]),
    // rust: &tr(if self.on { "on" } else { "off" }, &[]),
    // rust: ],
    // rust: ),
    // rust: Target::Switch,
    // rust: !self.on || self.names.len() <= 1,
    // rust: );
        // P1's controller handed to a friend: it's offered to join.
    // rust: let give_up = (
    // rust: [90.0, 6.0, 80.0, 20.0],
    // rust: tr("give_up_pad", &[]),
    // rust: Target::GiveUpPad,
    // rust: true,
    // rust: );
    // rust: if !self.on || self.idle {
    // rust: let mut out = vec![switch];
    // rust: if self.on && self.p1_pad {
    // rust: out.push(give_up);
}
    // rust: row(&mut out, h - 27.0, vec![done]);
    // rust: return out;
}
    // rust: let (_, windows, tiles) = self.map(w, h);
    // rust: let mut order: Vec<usize> = (0..tiles.len()).collect();
    // rust: order.sort_by_key(|&i| windows.iter().position(|(n, _)| *n == tiles[i].0));
    // rust: let mut out: Vec<Button> = order
    // rust: .into_iter()
    // rust: .map(|i| {
    // rust: let name = self
    // rust: .names
    // rust: .get(i)
    // rust: .cloned()
    // rust: .unwrap_or_else(|| tr("player", &[&(i + 1)]));
                // The part no later window covers: what can be seen and pressed.
    // rust: let at = windows.iter().position(|(n, _)| *n == tiles[i].0);
    // rust: let covers = at.map_or(&[][..], |k| &windows[k + 1..]);
    // rust: let rect = uncovered(tiles[i].1, covers.iter().map(|(_, r)| *r));
    // rust: (rect, name, Target::Player(i), true)
    // rust: })
    // rust: .collect();
        // The move row: one button for the windows, which cycles (the next window after the
        // player's, by number, wrapping), then a new window and the monitors.
    // rust: let mut spots = self.spots();
    // rust: let mine = self
    // rust: .selected
    // rust: .and_then(|i| self.draft().and_then(|d| d.players.get(i).copied()))
    // rust: .unwrap_or(0);
    // rust: let next = spots
    // rust: .iter()
    // rust: .filter_map(|(_, s)| match s {
    // rust: Spot::Window(n) => Some(*n),
    // rust: _ => None,
    // rust: })
    // rust: .min_by_key(|&n| (n <= mine, n));
    // rust: spots.retain(|(_, s)| !matches!(s, Spot::Window(n) if Some(*n) != next));
    // rust: if !spots.is_empty() {
    // rust: let items = spots
    // rust: .into_iter()
    // rust: .map(|(label, spot)| (86.0, label, Target::Move(spot), true))
    // rust: .collect();
    // rust: row(&mut out, h - BOTTOM + 4.0, items);
}
        // Names, top left: each player's name in the corner of their view.
    // rust: let names = (
    // rust: [6.0, 6.0, 80.0, 20.0],
    // rust: tr(
    // rust: "switch",
    // rust: &[
    // rust: &tr("names", &[]),
    // rust: &tr(if self.names_shown { "on" } else { "off" }, &[]),
    // rust: ],
    // rust: ),
    // rust: Target::Names,
    // rust: true,
    // rust: );
    // rust: out.extend([switch, names]);
    // rust: if self.p1_pad {
    // rust: out.push(give_up);
}
        // A square for how 2 (or 3) players share a window, while a window has that many (drawn
        // as the layout; the label is for the control socket and the tests).
    // rust: let mut footer = Vec::new();
    // rust: if let Some(draft) = self.draft() {
    // rust: let sharing = |k: usize| {
    // rust: draft
    // rust: .windows
    // rust: .iter()
    // rust: .any(|win| draft.players.iter().filter(|&&n| n == win.number).count() == k)
}
    // rust: if sharing(2) {
    // rust: let two = tr(&format!("layout.two.{}", draft.two.min(2)), &[]);
    // rust: footer.push((20.0, tr("layout.two", &[&two]), Target::Two, true));
}
    // rust: if sharing(3) {
    // rust: let three = tr(&format!("layout.three.{}", draft.three.min(2)), &[]);
    // rust: footer.push((20.0, tr("layout.three", &[&three]), Target::Three, true));
}
}
        // Narrow enough for two squares in the narrowest view (320 GUI pixels).
    // rust: let editing = self.changed();
    // rust: footer.extend([
    // rust: (64.0, tr("identify", &[]), Target::Identify, true),
    // rust: (64.0, tr("revert", &[]), Target::Revert, editing),
    // rust: (64.0, tr("apply", &[]), Target::Apply, editing),
    // rust: done,
    // rust: ]);
    // rust: row(&mut out, h - 27.0, footer);
    // rust: out
}

    // What a button does, for the tooltip while the pointer is on it; for one that can't be
    // pressed, why not.
help :: proc(self: ^Self) {
}
    // rust: let auto = self.draft().is_some_and(|d| d.two == 0);
    // rust: Some(match target {
    // rust: Target::Player(_) => tr("help.player", &[label]),
    // rust: Target::Move(_) | Target::Done => return None,
    // rust: Target::Two if auto => tr("help.layout_auto", &[label]),
    // rust: Target::Two | Target::Three => tr("help.layout", &[label]),
    // rust: Target::Switch if !*active => tr("switch_disabled", &[]),
    // rust: Target::Switch => tr("help.switch", &[]),
    // rust: Target::Identify => tr("help.identify", &[]),
    // rust: Target::Names => tr("help.names", &[]),
    // rust: Target::GiveUpPad => tr("help.give_up_pad", &[]),
    // rust: Target::Revert if *active => tr("help.revert", &[]),
    // rust: Target::Apply if *active => tr("help.apply", &[]),
    // rust: Target::Revert | Target::Apply => tr("help.unchanged", &[]),
    // rust: })
}

warnings :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let Some(draft) = self.draft() else {
    // rust: return Vec::new();
}
    // rust: draft
    // rust: .warnings(&self.monitors, &self.main)
    // rust: .into_iter()
    // rust: .map(|w| match w {
    // rust: Warning::Empty(1) => tr("warning.empty_main", &[]),
                // One open now closes; one only in the draft never opens.
    // rust: Warning::Empty(n) if self.live.as_ref().is_some_and(|l| !l.empty(n)) => {
    // rust: tr("warning.empty_close", &[&n])
}
    // rust: Warning::Empty(n) => tr("warning.empty_new", &[&n]),
    // rust: Warning::OnWindow1(n) => tr("warning.on_main", &[&n]),
    // rust: Warning::Unplugged(n, _) => tr("warning.unplugged", &[&n]),
    // rust: })
    // rust: .collect()
}

    // The state represented by the preview area, also available to agent controls.
status :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: if !self.on {
    // rust: "off"
    // rust: } else if self.idle {
    // rust: "idle"
    // rust: } else {
    // rust: "active"
}
}

status_lines :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if !self.on {
    // rust: Some([
    // rust: tr("status.off", &[]),
    // rust: tr("status.enable_hint", &[]),
    // rust: tr("status.join_hint", &[]),
    // rust: ])
    // rust: } else if self.idle {
    // rust: Some([
    // rust: tr("status.idle", &[]),
    // rust: tr("status.alone", &[]),
    // rust: tr("status.solo_controls", &[]),
    // rust: ])
    // rust: } else {
    // rust: None
}
}

draw :: proc(self: ^Self, batch: ^HudBatch, atlas: ^HudAtlas, cursor: (f32) {
}
    // rust: let (w, h) = (batch.width, batch.height);
    // rust: ui::menu_background(batch, atlas, 0.0, 0.0, w, h, in_world);
    // rust: graphics_style::title(
    // rust: batch,
    // rust: atlas,
    // rust: &Text::literal(tr("horizon.pages.split_setup", &[])),
    // rust: );
    // rust: if let Some(lines) = self.status_lines() {
    // rust: let grey = rgba(170, 170, 170, 255);
    // rust: let lines: Vec<_> = lines
    // rust: .iter()
    // rust: .flat_map(|line| atlas.font.split(&Text::literal(line), (w - 40.0).max(10.0)))
    // rust: .collect();
    // rust: let top = h / 2.0 - 6.0 * lines.len() as f32;
    // rust: for (k, line) in lines.into_iter().enumerate() {
    // rust: let y = (top + 12.0 * k as f32).floor();
    // rust: ui::centered_text(batch, atlas, &line, 0.0, y, w, grey);
}
    // rust: for b in &self.buttons(w, h) {
    // rust: self.draw_button(batch, atlas, cursor, b);
}
    // rust: return;
}
    // rust: let (monitors, windows, tiles) = self.map(w, h);
    // rust: let grey = rgba(160, 160, 160, 255);
    // rust: for &[x, y, mw, mh] in &monitors {
    // rust: batch.fill(atlas, x, y, mw, mh, rgba(255, 255, 255, 60));
    // rust: batch.fill(
    // rust: atlas,
    // rust: x + 1.0,
    // rust: y + 1.0,
    // rust: mw - 2.0,
    // rust: mh - 2.0,
    // rust: rgba(0, 0, 0, 170),
    // rust: );
}
    // rust: let buttons = self.buttons(w, h);
    // rust: let yellow = rgba(255, 255, 85, 255);
        // Each window, then its players: a window over another covers it.
    // rust: let draft = self.draft();
        // A window nobody plays in any more stays until Apply: grey, under the others.
    // rust: let emptied = |n: u8| n != 1 && draft.is_some_and(|d| d.empty(n));
    // rust: for &(number, [x, y, ww, wh]) in &windows {
    // rust: let edge = match emptied(number) {
    // rust: true => rgba(160, 160, 160, 120),
    // rust: false => rgba(255, 255, 85, 200),
}
    // rust: batch.fill(atlas, x, y, ww, wh, edge);
    // rust: if emptied(number) {
    // rust: let label = Text::literal(tr("window_empty", &[&number]));
    // rust: batch.text_styled(atlas, &label, x + 3.0, y - 10.0, grey, true);
}
    // rust: batch.fill(
    // rust: atlas,
    // rust: x + 1.0,
    // rust: y + 1.0,
    // rust: ww - 2.0,
    // rust: wh - 2.0,
    // rust: rgba(40, 40, 40, 230),
    // rust: );
    // rust: for b in buttons
    // rust: .iter()
    // rust: .filter(|b| matches!(b.2, Target::Player(i) if tiles[i].0 == number))
    // rust: {
    // rust: self.draw_button(batch, atlas, cursor, b);
}
}
        // The windows' names over everything, so another window's tiles never hide them.
    // rust: for (number, [x, y, _, _]) in windows.iter().copied().filter(|w| !emptied(w.0)) {
    // rust: let (label, color) = (tr("window", &[&number]), yellow);
            // A title above this window can land on another player's visible tile.
    // rust: let covered = windows.iter().any(|(n, r)| {
    // rust: *n != number && ui::hovered((x + 3.0, y - 10.0), r[0], r[1], r[2], r[3])
    // rust: });
    // rust: let title_y = if covered { y + 3.0 } else { y - 10.0 };
    // rust: batch.text_styled(atlas, &Text::literal(label), x + 3.0, title_y, color, true);
}
    // rust: for b in buttons.iter().filter(|b| !matches!(b.2, Target::Player(_))) {
    // rust: self.draw_button(batch, atlas, cursor, b);
}
        // The tile being dragged, under the pointer.
    // rust: if let Some((i, Some((x, y)))) = self.drag
    // rust: && let Some(name) = self.names.get(i)
    // rust: {
    // rust: let label = Text::colored(name.as_str(), crate::text::YELLOW);
    // rust: ui::button(
    // rust: batch,
    // rust: atlas,
    // rust: x - 30.0,
    // rust: y - 10.0,
    // rust: 60.0,
    // rust: 20.0,
    // rust: &label,
    // rust: true,
    // rust: true,
    // rust: );
}
        // The monitors' names under them, where no window covers them.
    // rust: for (n, [x, y, _, mh]) in monitors.into_iter().enumerate() {
    // rust: let label = Text::literal(tr("monitor", &[&(n + 1)]));
    // rust: batch.text_styled(atlas, &label, x + 1.0, y + mh + 2.0, grey, true);
}
    // rust: self.draw_notes(batch, atlas, cursor, &buttons);
}

    // rust: fn draw_button(
    // rust: &self,
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: cursor: (f32, f32),
    // rust: ([x, y, bw, bh], label, target, active): &Button,
    // rust: ) {
    // rust: let (mut x, mut y, mut bw, mut bh) = (*x, *y, *bw, *bh);
        // While a player is held, only its tile is lit: the controller's pointer stays where
        // the pick-up was, over whichever tile is there now.
    // rust: let hover = *active && self.held.is_none() && ui::hovered(cursor, x, y, bw, bh);
    // rust: let selected = matches!(target, Target::Player(i) if Some(*i) == self.selected);
    // rust: if matches!(target, Target::Player(_)) {
    // rust: (x, y, bw, bh) = (x + 1.0, y + 1.0, (bw - 2.0).max(4.0), (bh - 2.0).max(4.0));
}
    // rust: let glyph = self.draft().and_then(|d| match target {
    // rust: Target::Two => Some(layout_glyph(false, d.two)),
    // rust: Target::Three => Some(layout_glyph(true, d.three)),
    // rust: _ => None,
    // rust: });
    // rust: let action = match target {
    // rust: Target::Apply => Some(crate::widgets::Action::Apply),
    // rust: Target::Done => Some(crate::widgets::Action::Done),
    // rust: _ => None,
}
    // rust: if let Some(action) = action {
            // Off during a hold: every button goes to the held player.
    // rust: let enabled = *active && self.held.is_none();
    // rust: crate::widgets::declare_action(action, [x, y, bw, bh], enabled);
}
        // The selected player's name in yellow: picked, not just under the pointer.
    // rust: let text = if glyph.is_some() {
    // rust: Text::literal("")
    // rust: } else if selected {
    // rust: Text::colored(label.as_str(), crate::text::YELLOW)
    // rust: } else {
    // rust: Text::literal(label.as_str())
}
    // rust: ui::button(
    // rust: batch,
    // rust: atlas,
    // rust: x,
    // rust: y,
    // rust: bw,
    // rust: bh,
    // rust: &text,
    // rust: *active,
    // rust: hover || selected,
    // rust: );
        // The held player: "< Name >", the arrows lit, for left and right.
    // rust: if matches!(target, Target::Player(i) if self.held.as_ref().is_some_and(|h| h.player == *i))
    // rust: {
    // rust: let (half, cx) = (HudBatch::text_width(atlas, label) / 2.0, x + bw / 2.0);
    // rust: let ty = (y + (bh - 8.0) / 2.0).floor();
    // rust: let lit = rgba(255, 255, 85, 255);
    // rust: let lw = HudBatch::text_width(atlas, "<");
    // rust: batch.text(atlas, "<", (cx - half - 4.0 - lw).floor(), ty, lit, true);
    // rust: batch.text(atlas, ">", (cx + half + 4.0).ceil(), ty, lit, true);
}
        // A layout's square: its panes, in a 14 x 10 window; Auto a letter. Its name for the
        // control socket, which lists widgets by what they say.
    // rust: if glyph.is_some() {
    // rust: crate::widgets::record(label, [x, y, bw, bh], *active);
}
    // rust: let (gx, gy) = (
    // rust: (x + (bw - 14.0) / 2.0).floor(),
    // rust: (y + (bh - 10.0) / 2.0).floor(),
    // rust: );
    // rust: match glyph {
    // rust: Some(Glyph::Auto) => {
    // rust: let a = Text::literal("A");
    // rust: ui::centered_text(batch, atlas, &a, x, y + 6.0, bw, rgba(255, 255, 255, 255));
}
    // rust: Some(Glyph::Panes(panes)) => {
    // rust: for &[px, py, pw, ph] in panes {
    // rust: batch.fill(atlas, gx + px, gy + py, pw, ph, rgba(230, 230, 230, 255));
}
}
    // rust: None => {}
}
}
    // rust: fn draw_notes(
    // rust: &self,
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: cursor: (f32, f32),
    // rust: buttons: &[Button],
    // rust: ) {
    // rust: let (w, h) = (batch.width, batch.height);
    // rust: let held = self.held.as_ref().map(|h| {
    // rust: let who = self
    // rust: .names
    // rust: .get(h.player)
    // rust: .cloned()
    // rust: .unwrap_or_else(|| tr("this_player", &[]));
    // rust: match h.at {
    // rust: Some(k) => tr("note.held_at", &[&who, &h.spots[k].0]),
    // rust: None => tr("note.held", &[&who]),
}
    // rust: });
    // rust: let note = match self.selected {
    // rust: _ if held.is_some() => held.unwrap_or_default(),
    // rust: None => tr("note.select", &[]),
    // rust: Some(_) if self.edit.is_some() => tr("note.apply", &[]),
    // rust: Some(i) => tr(
    // rust: "note.place",
    // rust: &[&self
    // rust: .names
    // rust: .get(i)
    // rust: .cloned()
    // rust: .unwrap_or_else(|| tr("this_player", &[]))],
    // rust: ),
}
    // rust: for (k, (line, color)) in std::iter::once((note, rgba(170, 170, 170, 255)))
    // rust: .chain(
    // rust: self.warnings()
    // rust: .into_iter()
    // rust: .map(|w| (w, rgba(255, 170, 85, 255))),
    // rust: )
    // rust: .take(2)
    // rust: .enumerate()
    // rust: {
    // rust: ui::centered_text(
    // rust: batch,
    // rust: atlas,
    // rust: &Text::literal(line),
    // rust: 0.0,
    // rust: h - BOTTOM + 28.0 + k as f32 * 11.0,
    // rust: w,
    // rust: color,
    // rust: );
}
        // What the pointer's button does (disabled ones too, to say why), as the options screens
        // show theirs. Not the selected player's tile: the pointer is still on it after the click.
    // rust: let help = buttons
    // rust: .iter()
    // rust: .filter(|b| ui::hovered(cursor, b.0[0], b.0[1], b.0[2], b.0[3]))
    // rust: .filter(|b| !matches!(b.2, Target::Player(i) if Some(i) == self.selected))
    // rust: .find_map(|b| self.help(b));
    // rust: if let Some(help) = help {
    // rust: ui::tooltip(
    // rust: batch,
    // rust: atlas,
    // rust: &atlas.font.split(&Text::literal(help), 170.0),
    // rust: cursor,
    // rust: );
}
}
    // A press at `(x, y)` on a screen `w` x `h`, or the mouse moving with it held (`drag`).
click :: proc(self: ^Self) {
}
    // rust: self.size = (w, h);
        // The mouse takes over from a player held with the controller.
    // rust: if !drag {
    // rust: self.held = None;
}
    // rust: if drag {
    // rust: if let Some((_, at)) = &mut self.drag {
    // rust: *at = Some((x, y));
}
    // rust: return Click::Nothing;
}
        // The topmost: the last drawn.
    // rust: let hit = self
    // rust: .buttons(w, h)
    // rust: .into_iter()
    // rust: .rev()
    // rust: .find(|([bx, by, bw, bh], _, _, active)| {
    // rust: *active && ui::hovered((x, y), *bx, *by, *bw, *bh)
    // rust: });
    // rust: let Some((_, _, target, _)) = hit else {
    // rust: return Click::Nothing;
}
    // rust: match target {
    // rust: Target::Player(i) => {
    // rust: self.selected = Some(i);
    // rust: self.drag = Some((i, None));
}
    // rust: Target::Move(spot) => {
    // rust: if let Some(i) = self.selected {
    // rust: self.place(i, spot);
}
}
    // rust: Target::Two => {
    // rust: if let Some(draft) = self.editing() {
    // rust: draft.two = (draft.two + 1) % 3;
}
}
    // rust: Target::Three => {
    // rust: if let Some(draft) = self.editing() {
    // rust: draft.three = (draft.three + 1) % 3;
}
}
    // rust: Target::Identify => self.identify = true,
    // rust: Target::Names => self.toggle_names = true,
    // rust: Target::GiveUpPad => self.give_up_pad = true,
    // rust: Target::Revert => self.edit = None,
    // rust: Target::Apply => {
                // Windows emptied in the draft close now, not as players moved.
    // rust: self.apply = self.edit.take().map(|mut d| {
    // rust: d.drop_empty(&[]);
    // rust: d
    // rust: });
}
    // rust: Target::Done => {
    // rust: self.reset();
    // rust: return Click::Done;
}
    // rust: Target::Switch => {
    // rust: self.reset();
    // rust: return Click::Switch;
}
}
    // rust: Click::Pressed
}

    // The mouse let go: a tile dragged somewhere goes there (a draft). True when it moved.
release :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let (w, h) = self.size;
    // rust: let Some((i, Some(at))) = self.drag.take() else {
    // rust: return false;
}
    // rust: let before = self.draft().cloned();
    // rust: match self.drag_target(i, at, w, h) {
    // rust: Some(Drop::At(spot)) => self.place(i, spot),
    // rust: Some(Drop::Place(n, k)) => self.place_at(i, n, k),
    // rust: None => return false,
}
    // rust: self.draft().cloned() != before
}

    // Where player `i` dropped at `at` goes, as the map shows it: the window drawn on top under
    // the pointer, and in it the place (among its players) that puts the player's view under the
    // pointer, else the nearest. Dropped back where its view was, it goes back there: a move and
    // its reverse cancel out. Outside every window: `drop_spot` (a new window, a monitor).
drag_target :: proc(self: ^Self, i: uint, at: (f32) {
}
    // rust: let base = self.edit.as_ref().or(self.live.as_ref())?;
    // rust: let open = self.open_now();
    // rust: let inside = |[x, y, rw, rh]: [f32; 4]| ui::hovered(at, x, y, rw, rh);
    // rust: let (_, windows, tiles) = self.map_of(base, w, h);
        // Where it is now: no move.
    // rust: if tiles.get(i).is_some_and(|t| inside(t.1)) {
    // rust: return None;
}
    // rust: let Some(&(n, _)) = windows.iter().rev().find(|(_, r)| inside(*r)) else {
    // rust: let spot = self.drop_spot(at, w, h)?;
    // rust: let here = base.players.get(i).copied();
    // rust: return (!matches!(spot, Spot::Window(n) if Some(n) == here)).then_some(Drop::At(spot));
}
        // Each place in that window, by how far its view would be from the pointer (0 inside).
    // rust: let distance = |[x, y, rw, rh]: [f32; 4]| {
    // rust: let dx = (x - at.0).max(at.0 - x - rw).max(0.0);
    // rust: let dy = (y - at.1).max(at.1 - y - rh).max(0.0);
    // rust: dx * dx + dy * dy
}
    // rust: self.stops(i)
    // rust: .into_iter()
    // rust: .filter(|(_, drop)| matches!(drop, Drop::Place(m, _) | Drop::At(Spot::Window(m)) if *m == n))
    // rust: .filter_map(|(_, drop)| {
    // rust: let mut draft = base.clone();
    // rust: match &drop {
    // rust: Drop::At(spot) => draft.place_player(i, spot.clone()),
    // rust: Drop::Place(m, k) => {
    // rust: draft.place_player(i, Spot::Window(*m));
    // rust: draft.put_at(i, *k);
}
}
    // rust: draft.drop_empty(&open);
    // rust: let view = self.map_of(&draft, w, h).2.get(i)?.1;
    // rust: Some((distance(view), drop))
    // rust: })
    // rust: .min_by(|a, b| a.0.total_cmp(&b.0))
    // rust: .map(|(_, drop)| drop)
}

    // Player `i` to place `k` among the players of window `n` in the draft.
place_at :: proc(self: ^Self, i: uint, n: u8, k: uint) {
}
    // rust: self.place(i, Spot::Window(n));
    // rust: if let Some(draft) = self.editing() {
    // rust: draft.put_at(i, k);
}
}

changed :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
        // A free window's spot moves under the draft as it's dragged around: not a change.
    // rust: let windows = |d: &Draft| -> Vec<(u8, Option<String>)> {
    // rust: let fill = |p: &Placement| match p {
    // rust: Placement::Fill(name) => Some(name.clone()),
    // rust: Placement::Free(_) => None,
}
    // rust: d.windows
    // rust: .iter()
    // rust: .map(|w| (w.number, fill(&w.placement)))
    // rust: .collect()
}
        // The order only counts among players sharing a window (who is first in it).
    // rust: let order = |d: &Draft| -> Vec<(u8, usize)> {
    // rust: let mut by_window: Vec<(u8, usize)> = ordered(&d.order, d.players.len())
    // rust: .into_iter()
    // rust: .filter_map(|i| d.players.get(i).map(|&n| (n, i)))
    // rust: .collect();
    // rust: by_window.sort_by_key(|&(n, _)| n);
    // rust: by_window
}
    // rust: let same = |a: &Draft, b: &Draft| {
    // rust: windows(a) == windows(b)
    // rust: && a.players == b.players
    // rust: && (a.two, a.three) == (b.two, b.three)
    // rust: && order(a) == order(b)
}
    // rust: match (&self.edit, &self.live) {
    // rust: (Some(edit), Some(live)) => !same(edit, live),
    // rust: (edit, _) => edit.is_some(),
}
}

    // Player `i` to `spot` in the draft.
place :: proc(self: ^Self, i: uint, spot: Spot) {
}
    // rust: let open = self.open_now();
    // rust: if let Some(draft) = self.editing() {
    // rust: draft.place_player(i, spot);
    // rust: draft.drop_empty(&open);
}
}

    // The windows open now: emptied in a draft, they stay until Apply (a window the draft
    // added goes as soon as nobody is in it).
open_now :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.live
    // rust: .as_ref()
    // rust: .map_or_else(Vec::new, |l| l.windows.iter().map(|w| w.number).collect())
}
}
    // rust: mod tests {
//     use super::*;

SIZE :: (427.0, 300.0)

screen :: proc(players: uint) -> S {
    // Ported from Horizon
    return {}
}
    // rust: SplitUi {
    // rust: live: Some(Draft::everyone_here(
    // rust: players,
    // rust: Placement::Free(Some(([0, 0], [2000, 1200]))),
    // rust: 0,
    // rust: 0,
    // rust: )),
    // rust: monitors: vec![
    // rust: Monitor {
    // rust: name: "Built-in".into(),
    // rust: at: [0, 0],
    // rust: size: [3024, 1964],
    // rust: scale: 2.0,
    // rust: },
    // rust: Monitor {
    // rust: name: "TV".into(),
    // rust: at: [3024, 0],
    // rust: size: [1920, 1080],
    // rust: scale: 1.0,
    // rust: },
    // rust: ],
    // rust: main: "Built-in".into(),
    // rust: names: (1..=players).map(|n| format!("P{n}")).collect(),
    // rust: on: true,
    // rust: ..Default::default()
}
}

labels :: proc(ui: ^SplitUi) -> V {
    // Ported from Horizon
    return {}
}
    // rust: ui.buttons(SIZE.0, SIZE.1)
    // rust: .into_iter()
    // rust: .map(|b| b.1)
    // rust: .collect()
}

off_only_the_switch_and_done :: proc() {
}
    // rust: let mut ui = screen(2);
    // rust: ui.on = false;
    // rust: assert_eq!(labels(&ui), ["Splitscreen: Off", "Done"]);
    // rust: let r = rect(&ui, "Splitscreen: Off");
    // rust: assert!(matches!(
    // rust: ui.click((r[0] + 1.0, r[1] + 1.0), SIZE, false),
    // rust: Click::Switch
    // rust: ));
}

rect :: proc(ui: ^SplitUi, label: string) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: ui.buttons(SIZE.0, SIZE.1)
    // rust: .into_iter()
    // rust: .find(|(_, l, _, _)| l == label)
    // rust: .unwrap_or_else(|| panic!("no {label}"))
    // rust: .0
}

press :: proc(ui: ^SplitUi, label: string) {
}
    // rust: let r = rect(ui, label);
    // rust: ui.click((r[0] + 1.0, r[1] + 1.0), SIZE, false);
}

move_a_player_then_apply :: proc() {
}
    // rust: let mut ui = screen(2);
    // rust: press(&mut ui, "P2");
    // rust: press(&mut ui, "Fill Monitor 2");
        // Nothing applied yet: the draft only.
    // rust: assert_eq!(ui.apply, None);
    // rust: assert_eq!(ui.live.as_ref().unwrap().players, [1, 1]);
    // rust: press(&mut ui, "Apply");
    // rust: let applied = ui.apply.take().unwrap();
    // rust: assert_eq!(applied.players, [1, 2]);
    // rust: assert_eq!(applied.windows[1].placement, Placement::Fill("TV".into()));
}

revert_drops_the_draft :: proc() {
}
    // rust: let mut ui = screen(2);
    // rust: press(&mut ui, "P2");
    // rust: press(&mut ui, "New window");
    // rust: assert!(ui.edit.is_some());
    // rust: press(&mut ui, "Revert");
    // rust: assert!(ui.edit.is_none());
        // Done closes and forgets the selection.
    // rust: press(&mut ui, "Done");
    // rust: assert_eq!(ui.selected, None);
}

tiles_split_the_window_on_the_map :: proc() {
}
    // rust: let ui = screen(2);
    // rust: let (monitors, windows, tiles) = ui.map(SIZE.0, SIZE.1);
    // rust: assert_eq!(monitors.len(), 2);
    // rust: assert_eq!(windows.len(), 1);
        // Two halves of Window 1, side by side.
    // rust: let (a, b) = (tiles[0].1, tiles[1].1);
    // rust: assert!((a[2] - b[2]).abs() < 0.01);
    // rust: assert!((a[0] + a[2] - b[0]).abs() < 0.01);
}

a_window_over_another_takes_the_click :: proc() {
}
    // rust: let mut ui = screen(2);
        // P2 in a new window, opened over Window 1's corner.
    // rust: press(&mut ui, "P2");
    // rust: press(&mut ui, "New window");
    // rust: press(&mut ui, "Apply");
    // rust: ui.live = ui.apply.take();
    // rust: press(&mut ui, "P2");
    // rust: assert_eq!(ui.selected, Some(1));
}

one_window_button_cycles_through_the_windows :: proc() {
}
    // rust: let mut ui = screen(4);
        // P2, P3, P4 each in a new window: Windows 2, 3, 4.
    // rust: for p in ["P2", "P3", "P4"] {
    // rust: press(&mut ui, p);
    // rust: press(&mut ui, "New window");
}
    // rust: press(&mut ui, "P2");
    // rust: let windows = |ui: &SplitUi| -> Vec<String> {
    // rust: labels(ui)
    // rust: .into_iter()
    // rust: .filter(|l| l.starts_with("Window "))
    // rust: .collect()
}
    // rust: assert_eq!(windows(&ui), ["Window 3"]);
    // rust: press(&mut ui, "Window 3");
    // rust: assert_eq!(windows(&ui), ["Window 4"]);
    // rust: press(&mut ui, "Window 4");
        // Past the last: back to Window 1, then on.
    // rust: assert_eq!(windows(&ui), ["Window 1"]);
    // rust: press(&mut ui, "Window 1");
    // rust: assert_eq!(ui.edit.as_ref().unwrap().players[1], 1);
    // rust: assert!(labels(&ui).contains(&"New window".to_owned()));
}

windows_hold_still_until_apply :: proc() {
}
    // rust: let mut ui = screen(3);
        // Playing now: P2 in Window 2, P3 in Window 3.
    // rust: let live = ui.live.as_mut().unwrap();
    // rust: live.place_player(1, Spot::New);
    // rust: live.place_player(2, Spot::New);
    // rust: let numbers = |ui: &SplitUi| -> Vec<u8> {
    // rust: ui.draft()
    // rust: .unwrap()
    // rust: .windows
    // rust: .iter()
    // rust: .map(|w| w.number)
    // rust: .collect()
}
    // rust: let next = |ui: &SplitUi| {
    // rust: labels(ui)
    // rust: .into_iter()
    // rust: .find(|l| l.starts_with("Window "))
    // rust: .unwrap()
}
        // P2 into Window 1: Window 2 is open now, so it stays (empty) until Apply, and the
        // window button's list holds still: from Window 1 on to 2, then 3.
    // rust: press(&mut ui, "P2");
    // rust: let to = next(&ui);
    // rust: press(&mut ui, &to);
    // rust: assert_eq!(ui.edit.as_ref().unwrap().players[1], 3);
    // rust: press(&mut ui, "Window 1");
    // rust: assert_eq!(
    // rust: (numbers(&ui), next(&ui)),
    // rust: (vec![1, 2, 3], "Window 2".to_owned())
    // rust: );
        // A window the draft adds goes as soon as nobody is in it: never open, nothing to close.
    // rust: press(&mut ui, "New window");
    // rust: assert_eq!(numbers(&ui), [1, 2, 3, 4]);
    // rust: let to = next(&ui); // Window 1
    // rust: press(&mut ui, &to);
    // rust: assert_eq!(numbers(&ui), [1, 2, 3]);
        // Apply closes the emptied one.
    // rust: press(&mut ui, "Apply");
    // rust: let applied = ui.apply.as_ref().unwrap();
    // rust: assert_eq!(
    // rust: applied.windows.iter().map(|w| w.number).collect::<Vec<_>>(),
    // rust: [1, 3]
    // rust: );
}

names_says_what_the_game_shows_and_asks_it_to_change :: proc() {
}
    // rust: let mut ui = screen(2);
    // rust: ui.names_shown = true;
    // rust: assert!(labels(&ui).contains(&"Names: On".to_owned()));
    // rust: press(&mut ui, "Names: On");
    // rust: assert!(ui.toggle_names);
        // Nothing else changes: no draft.
    // rust: assert_eq!(ui.edit, None);
}

dropped_on_a_player_in_another_window_it_joins_that_window :: proc() {
}
        // Adam (P1) in Window 1, Sam (P2) in Window 2: Sam dropped on Adam joins Window 1;
        // Adam stays there too (they used to swap).
    // rust: let mut ui = screen(2);
    // rust: ui.live.as_mut().unwrap().place_player(1, Spot::New);
    // rust: let (p2, p1) = (rect(&ui, "P2"), rect(&ui, "P1"));
    // rust: ui.click((p2[0] + 2.0, p2[1] + 2.0), SIZE, false);
    // rust: ui.click((p1[0] + 2.0, p1[1] + 2.0), SIZE, true);
    // rust: assert!(ui.release());
    // rust: let draft = ui.edit.as_ref().unwrap();
    // rust: assert_eq!(draft.players, [1, 1]);
        // Its first half: before Adam.
    // rust: assert_eq!(ordered(&draft.order, 2), [1, 0]);
}

any_move_and_its_reverse_leave_nothing_to_apply :: proc() {
}
        // A fixed pseudo-random walk: layouts of 2 to 5 players over up to 3 windows, then one
        // player moved anywhere (another window, a place among its players, a new window) and
        // moved back to its window and its place there.
    // rust: let mut seed = 0x2545_f491_4f6c_dd1du64;
    // rust: let mut next = |n: usize| {
    // rust: seed ^= seed << 13;
    // rust: seed ^= seed >> 7;
    // rust: seed ^= seed << 17;
    // rust: (seed % n as u64) as usize
}
    // rust: for case in 0..2000 {
    // rust: let players = 2 + next(4);
    // rust: let mut ui = screen(players);
    // rust: let live = ui.live.as_mut().unwrap();
    // rust: for i in 1..players {
    // rust: match next(3) {
    // rust: 0 => live.place_player(i, Spot::New),
    // rust: 1 => {
    // rust: let n = live.windows[next(live.windows.len())].number;
    // rust: live.place_player(i, Spot::Window(n));
}
    // rust: _ => {}
}
    // rust: let n = live.players[i];
    // rust: let k = next(live.sharing(i, n).len() + 1);
    // rust: live.put_at(i, k);
}
    // rust: let i = next(players);
    // rust: let live = ui.live.clone().unwrap();
    // rust: let home = live.players[i];
            // Its place: how many of its window's players come before it.
    // rust: let place = ordered(&live.order, players)
    // rust: .into_iter()
    // rust: .filter(|&p| live.players[p] == home)
    // rust: .position(|p| p == i)
    // rust: .unwrap();
    // rust: let to = match next(3) {
    // rust: 0 => Drop::At(Spot::New),
    // rust: 1 => {
    // rust: let n = live.windows[next(live.windows.len())].number;
    // rust: let k = next(live.sharing(i, n).len() + 1);
    // rust: Drop::Place(n, k)
}
    // rust: _ => Drop::At(Spot::Window(live.windows[next(live.windows.len())].number)),
}
    // rust: match to.clone() {
    // rust: Drop::At(spot) => ui.place(i, spot),
    // rust: Drop::Place(n, k) => ui.place_at(i, n, k),
}
    // rust: ui.place_at(i, home, place);
    // rust: assert!(
    // rust: !ui.changed(),
    // rust: "case {case}: {players} players, P{} to {to:?} and back\nlive {live:?}\nedit {:?}",
    // rust: i + 1,
    // rust: ui.edit
    // rust: );
}
}

the_switch_turns_off_only_once_p1_plays_alone :: proc() {
}
    // rust: let mut ui = screen(2);
    // rust: ui.on = true;
    // rust: let switch = |ui: &SplitUi| {
    // rust: ui.buttons(SIZE.0, SIZE.1)
    // rust: .into_iter()
    // rust: .find(|b| b.2 == Target::Switch)
    // rust: .unwrap()
    // rust: .3
}
    // rust: assert!(!switch(&ui), "two players: off is greyed");
    // rust: ui.names.truncate(1);
    // rust: assert!(switch(&ui));
}

three_in_a_window_dragged_and_back_nothing_changed :: proc() {
}
    // rust: let mut ui = screen(3);
    // rust: let centre = |r: [f32; 4]| (r[0] + r[2] / 2.0, r[1] + r[3] / 2.0);
        // Pressed, P3 is selected and the map makes room for the move row: measure after.
    // rust: ui.click(centre(rect(&ui, "P3")), SIZE, false);
    // rust: let (p3, p1) = (rect(&ui, "P3"), rect(&ui, "P1"));
        // P3 to where P1's view is: it takes that place.
    // rust: ui.click(centre(p1), SIZE, true);
    // rust: assert!(ui.release());
    // rust: assert_eq!(ordered(&ui.edit.as_ref().unwrap().order, 3)[0], 2);
    // rust: assert!(rect(&ui, "P3") != p3, "it moved on the map");
        // Back to where its view was: as it was.
    // rust: let now = rect(&ui, "P3");
    // rust: ui.click(centre(now), SIZE, false);
    // rust: ui.click(centre(p3), SIZE, true);
    // rust: assert!(ui.release());
    // rust: assert!(!ui.changed(), "{:?}", ui.edit);
}

dragged_back_where_it_was_nothing_changed :: proc() {
}
    // rust: let mut ui = screen(2);
    // rust: ui.live.as_mut().unwrap().place_player(1, Spot::New);
    // rust: let window2 = ui
    // rust: .map(SIZE.0, SIZE.1)
    // rust: .1
    // rust: .iter()
    // rust: .find(|(n, _)| *n == 2)
    // rust: .unwrap()
    // rust: .1;
    // rust: let (p2, p1) = (rect(&ui, "P2"), rect(&ui, "P1"));
    // rust: ui.click((p2[0] + 2.0, p2[1] + 2.0), SIZE, false);
    // rust: ui.click((p1[0] + 2.0, p1[1] + 2.0), SIZE, true);
    // rust: assert!(ui.release());
        // Back into Window 2, emptied in the draft: where it was, so nothing to apply.
    // rust: let p2 = rect(&ui, "P2");
    // rust: ui.click((p2[0] + 2.0, p2[1] + 2.0), SIZE, false);
    // rust: ui.click(
    // rust: (window2[0] + window2[2] / 2.0, window2[1] + window2[3] / 2.0),
    // rust: SIZE,
    // rust: true,
    // rust: );
    // rust: assert!(ui.release(), "dropped into Window 2");
    // rust: assert_eq!(ui.draft().unwrap().players, [1, 2]);
    // rust: assert!(!ui.changed());
}

a_tile_under_a_window_is_pressed_where_it_shows :: proc() {
}
        // The left half of a tile hidden: its right half is left.
    // rust: let r = uncovered([0.0, 0.0, 10.0, 4.0], [[-5.0, -1.0, 10.0, 9.0]].into_iter());
    // rust: assert_eq!(r, [5.0, 0.0, 5.0, 4.0]);
        // All of it hidden: nothing to press.
    // rust: let r = uncovered([0.0, 0.0, 10.0, 4.0], [[-1.0, -1.0, 20.0, 9.0]].into_iter());
    // rust: assert_eq!(r[2] * r[3], 0.0);
        // P3 in a new window over the middle of Window 1: P2's tile, partly under it, still
        // answers at the middle of what shows of it.
    // rust: let mut ui = screen(3);
    // rust: press(&mut ui, "P3");
    // rust: press(&mut ui, "New window");
    // rust: press(&mut ui, "Apply");
    // rust: ui.live = ui.apply.take();
    // rust: let [x, y, w, h] = rect(&ui, "P2");
    // rust: ui.click((x + w / 2.0, y + h / 2.0), SIZE, false);
    // rust: assert_eq!(ui.selected, Some(1));
}

drag_a_player_onto_a_monitor :: proc() {
}
    // rust: let mut ui = screen(3);
    // rust: let (monitors, _, _) = ui.map(SIZE.0, SIZE.1);
    // rust: let tv = monitors[1];
    // rust: let p3 = rect(&ui, "P3");
    // rust: ui.click((p3[0] + 2.0, p3[1] + 2.0), SIZE, false);
    // rust: ui.click((tv[0] + 5.0, tv[1] + 5.0), SIZE, true);
    // rust: assert!(ui.release());
    // rust: assert_eq!(ui.edit.as_ref().unwrap().players, [1, 1, 2]);
        // P2 dropped on P3 (its tile fills that window): it joins P3 there, nobody swaps.
    // rust: let p2 = rect(&ui, "P2");
    // rust: ui.click((p2[0] + 2.0, p2[1] + 2.0), SIZE, false);
    // rust: ui.click((tv[0] + 5.0, tv[1] + 5.0), SIZE, true);
    // rust: assert!(ui.release());
    // rust: assert_eq!(ui.edit.as_ref().unwrap().players, [1, 2, 2]);
        // A click without moving only selects.
    // rust: let p1 = rect(&ui, "P1");
    // rust: ui.click((p1[0] + 2.0, p1[1] + 2.0), SIZE, false);
    // rust: assert!(!ui.release());
}

layout_squares_show_while_a_window_has_that_many :: proc() {
}
    // rust: let labels = |ui: &SplitUi| labels(ui).into_iter().filter(|l| l.contains("sharing"));
        // Three in Window 1: only the 3's square, drawn as its panes.
    // rust: let mut ui = screen(3);
    // rust: assert_eq!(
    // rust: labels(&ui).collect::<Vec<_>>(),
    // rust: ["3 sharing: One wide on top"]
    // rust: );
    // rust: press(&mut ui, "3 sharing: One wide on top");
    // rust: assert_eq!(ui.edit.as_ref().unwrap().three, 1);
    // rust: assert!(matches!(layout_glyph(true, 1), Glyph::Panes(p) if p.len() == 3));
        // Two: only the 2's, Auto a letter, explained under the pointer.
    // rust: let ui = screen(2);
    // rust: assert_eq!(labels(&ui).collect::<Vec<_>>(), ["2 sharing: Auto"]);
    // rust: assert!(matches!(layout_glyph(false, 0), Glyph::Auto));
    // rust: let buttons = ui.buttons(SIZE.0, SIZE.1);
    // rust: let two = buttons.iter().find(|b| b.2 == Target::Two).unwrap();
    // rust: assert_eq!(
    // rust: ui.help(two).as_deref(),
    // rust: Some("2 sharing: Auto (side by side when the window is wide). Press to change.")
    // rust: );
        // Alone: neither.
    // rust: assert_eq!(labels(&screen(1)).count(), 0);
}

centre :: proc(ui: ^SplitUi, label: string) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let [x, y, w, h] = rect(ui, label);
    // rust: (x + w / 2.0, y + h / 2.0)
}

a_controller_picks_a_player_up_moves_it_and_drops_it :: proc() {
}
    // rust: let mut ui = screen(2);
    // rust: ui.size = SIZE;
    // rust: assert!(ui.pad_pick_up(centre(&ui, "P2")));
        // Nothing moves until the bumpers do; then the map shows it there: the places in Window 1
        // first, then a new window.
    // rust: assert_eq!(ui.draft().unwrap().players, [1, 1]);
    // rust: for _ in 0..3 {
    // rust: assert!(ui.pad_button(PadButton::RightBumper));
}
    // rust: assert_eq!(ui.draft().unwrap().players, [1, 2]);
    // rust: assert_eq!(ui.edit, None);
        // Right again: filling the TV; A drops it there, into the draft.
    // rust: assert!(ui.pad_button(PadButton::RightBumper));
    // rust: assert!(ui.pad_button(PadButton::South));
    // rust: let draft = ui.edit.as_ref().unwrap();
    // rust: assert_eq!(draft.players, [1, 2]);
    // rust: assert_eq!(draft.windows[1].placement, Placement::Fill("TV".into()));
        // Not held any more: the buttons go back to the menu.
    // rust: assert!(!ui.pad_button(PadButton::RightBumper));
}

a_controller_moves_a_player_to_a_place_among_the_others :: proc() {
}
    // rust: let mut ui = screen(2);
    // rust: ui.size = SIZE;
    // rust: assert!(ui.pad_pick_up(centre(&ui, "P2")));
    // rust: let stops: Vec<String> = ui
    // rust: .held
    // rust: .as_ref()
    // rust: .unwrap()
    // rust: .spots
    // rust: .iter()
    // rust: .map(|s| s.0.clone())
    // rust: .collect();
    // rust: assert_eq!(
    // rust: &stops[..3],
    // rust: ["Window 1 (1 of 2)", "Window 1 (2 of 2)", "New window"]
    // rust: );
    // rust: assert!(
    // rust: !stops.iter().any(|s| s.starts_with("Swap")),
    // rust: "no swaps: it joins"
    // rust: );
        // RB to the first place: before P1.
    // rust: assert!(ui.pad_button(PadButton::RightBumper));
    // rust: assert!(ui.pad_button(PadButton::South));
    // rust: assert_eq!(ui.edit.as_ref().unwrap().order, [1, 0]);
}

idle_replaces_preview_but_keeps_the_switch_and_pad_handoff :: proc() {
}
    // rust: let mut ui = screen(1);
    // rust: ui.on = true;
    // rust: ui.idle = true;
    // rust: ui.p1_pad = true;
    // rust: assert_eq!(ui.status_lines().unwrap()[0], "Splitscreen idle");
    // rust: assert!(ui.map(SIZE.0, SIZE.1).2.is_empty());
    // rust: let buttons = ui.buttons(SIZE.0, SIZE.1);
    // rust: assert!(buttons.iter().any(|b| b.2 == Target::GiveUpPad));
    // rust: assert!(
    // rust: !buttons
    // rust: .iter()
    // rust: .any(|b| matches!(b.2, Target::Player(_) | Target::Apply | Target::Revert))
    // rust: );
    // rust: press(&mut ui, "Give Up Pad");
    // rust: assert!(ui.give_up_pad);
    // rust: ui.idle = false;
    // rust: assert!(ui.status_lines().is_none());
    // rust: assert_eq!(ui.map(SIZE.0, SIZE.1).2.len(), 1);
    // rust: ui.on = false;
    // rust: assert_eq!(ui.status_lines().unwrap()[0], "Splitscreen is off.");
}

give_up_pad_shows_only_while_p1_has_one :: proc() {
}
    // rust: let mut ui = screen(1);
    // rust: ui.on = true;
    // rust: let shown = |ui: &SplitUi| {
    // rust: ui.buttons(SIZE.0, SIZE.1)
    // rust: .iter()
    // rust: .any(|b| b.2 == Target::GiveUpPad)
}
    // rust: assert!(!shown(&ui));
    // rust: ui.p1_pad = true;
    // rust: assert!(shown(&ui));
    // rust: press(&mut ui, "Give Up Pad");
    // rust: assert!(ui.give_up_pad);
}

done_is_declared_off_while_a_player_is_held :: proc() {
}
//         use crate::widgets::{Action, end_frame, last_actions, set_action_screen};
    // rust: let atlas =
    // rust: HudAtlas::build(std::path::Path::new("/nonexistent/horizon-test-assets")).unwrap();
    // rust: let mut ui = screen(2);
    // rust: ui.size = SIZE;
    // rust: let done = |ui: &SplitUi, frame: u64| {
    // rust: let mut batch = HudBatch::new([427, 300]);
    // rust: ui.draw(&mut batch, &atlas, (0.0, 0.0), false);
    // rust: set_action_screen(9);
    // rust: end_frame(frame);
    // rust: last_actions(9)
    // rust: .into_iter()
    // rust: .find(|a| a.action == Action::Done)
    // rust: .map(|a| a.enabled)
}
    // rust: assert_eq!(done(&ui, 9001), Some(true));
    // rust: assert!(ui.pad_pick_up(centre(&ui, "P2")));
    // rust: assert_eq!(done(&ui, 9002), Some(false));
    // rust: assert!(ui.pad_button(PadButton::East));
    // rust: assert_eq!(done(&ui, 9003), Some(true));
}

b_puts_a_held_player_back :: proc() {
}
    // rust: let mut ui = screen(2);
    // rust: ui.size = SIZE;
    // rust: assert!(ui.pad_pick_up(centre(&ui, "P2")));
    // rust: ui.pad_button(PadButton::RightBumper);
    // rust: assert!(ui.pad_button(PadButton::East));
    // rust: assert_eq!(ui.edit, None);
    // rust: assert_eq!(ui.draft().unwrap().players, [1, 1]);
}

dropped_or_put_back_one_highlight_and_the_focus_follows :: proc() {
}
    // rust: let mut ui = screen(2);
    // rust: ui.size = SIZE;
    // rust: assert!(ui.pad_pick_up(centre(&ui, "P2")));
    // rust: assert!(ui.pad_button(PadButton::RightBumper)); // to a new window
    // rust: assert!(ui.pad_button(PadButton::South));
        // Not selected (the focus is its highlight), and the focus goes to its new tile.
    // rust: assert_eq!(ui.selected, None);
    // rust: assert_eq!(ui.take_refocus(), Some(rect(&ui, "P2")));
    // rust: assert_eq!(ui.take_refocus(), None);
        // Put back: the same.
    // rust: assert!(ui.pad_pick_up(centre(&ui, "P2")));
    // rust: assert!(ui.pad_button(PadButton::East));
    // rust: assert_eq!(
    // rust: (ui.selected, ui.take_refocus()),
    // rust: (None, Some(rect(&ui, "P2")))
    // rust: );
}

locale_switch_and_pack_overrides_keep_the_same_draft :: proc() {
}
        // The language table is process-wide. Run this test alone in a child so
        // other UI tests cannot observe its temporary French language.
CHILD :: "HORIZON_TEST_SPLIT_SETUP_LOCALE"
    // rust: if std::env::var_os(CHILD).is_none() {
    // rust: let module = module_path!().split_once("::").unwrap().1;
    // rust: let output = std::process::Command::new(std::env::current_exe().unwrap())
    // rust: .args([
    // rust: "--exact",
    // rust: &format!("{module}::locale_switch_and_pack_overrides_keep_the_same_draft"),
    // rust: "--nocapture",
    // rust: ])
    // rust: .env(CHILD, "1")
    // rust: .output()
    // rust: .unwrap();
    // rust: assert!(
    // rust: String::from_utf8_lossy(&output.stdout).contains("1 passed;"),
    // rust: "locale child test did not run: {}",
    // rust: String::from_utf8_lossy(&output.stdout)
    // rust: );
    // rust: assert!(
    // rust: output.status.success(),
    // rust: "{}\n{}",
    // rust: String::from_utf8_lossy(&output.stdout),
    // rust: String::from_utf8_lossy(&output.stderr)
    // rust: );
    // rust: return;
}
Pack :: struct {
    // rust: impl lang::ResourceSource for Pack {
namespaces :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: vec!["horizon".into()]
}
read :: proc(self: ^Self, path: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: (path == "assets/horizon/lang/fr_fr.json").then(|| {
    // rust: serde_json::to_vec(&serde_json::json!({
    // rust: "horizon.splitscreen.setup.new_window": "Créer une fenêtre",
    // rust: "horizon.splitscreen.setup.monitor": "Écran personnalisé %s",
    // rust: "horizon.splitscreen.setup.fill_monitor": "Occuper %s",
    // rust: "horizon.splitscreen.setup.warning.empty_main": "Fenêtre principale masquée"
    // rust: }))
    // rust: .unwrap()
    // rust: })
}
}
    // rust: let mut ui = screen(2);
    // rust: ui.names[1] = "Élodie %s".into();
    // rust: lang::set(lang::Language::load(&[], "en_us"));
    // rust: press(&mut ui, "Élodie %s");
    // rust: assert!(labels(&ui).contains(&"New window".to_owned()));
    // rust: lang::set(lang::Language::load(&[], "fr_fr"));
    // rust: assert!(labels(&ui).contains(&"Nouvelle fenêtre".to_owned()));
    // rust: assert!(labels(&ui).contains(&"Appliquer".to_owned()));
    // rust: assert!(labels(&ui).contains(&"Noms : Désactivé".to_owned()));
    // rust: assert!(labels(&ui).contains(&"2 par fenêtre : Auto".to_owned()));
    // rust: assert!(
    // rust: labels(&ui).contains(&"Élodie %s".to_owned()),
    // rust: "player names remain literal"
    // rust: );
    // rust: press(&mut ui, "Nouvelle fenêtre");
    // rust: let draft = ui.edit.clone().unwrap();
    // rust: assert_eq!(draft.players, [1, 2]);
    // rust: lang::set(lang::Language::load(&[&Pack], "fr_fr"));
    // rust: let translated = labels(&ui);
    // rust: assert!(translated.contains(&"Créer une fenêtre".to_owned()));
    // rust: assert!(translated.contains(&"Occuper Écran personnalisé 2".to_owned()));
    // rust: assert_eq!(
    // rust: ui.edit,
    // rust: Some(draft),
    // rust: "a language change must not reset the arrangement"
    // rust: );
    // rust: ui.place(0, Spot::Window(2));
    // rust: assert!(
    // rust: ui.warnings()
    // rust: .contains(&"Fenêtre principale masquée".to_owned())
    // rust: );
    // rust: press(&mut ui, "Appliquer");
    // rust: assert_eq!(ui.apply.take().unwrap().players, [2, 2]);
    // rust: ui.on = false;
    // rust: assert_eq!(
    // rust: ui.status(),
    // rust: "off",
    // rust: "agent protocol states stay language independent"
    // rust: );
    // rust: assert_eq!(
    // rust: ui.status_lines().unwrap()[0],
    // rust: "L'écran partagé est désactivé."
    // rust: );
    // rust: assert!(labels(&ui).contains(&"Écran partagé : Désactivé".to_owned()));
    // rust: lang::set(lang::Language::load(&[], "de_de"));
    // rust: assert_eq!(
    // rust: ui.status_lines().unwrap()[0],
    // rust: "Splitscreen is off.",
    // rust: "untranslated new keys use bundled English"
    // rust: );
}
}
