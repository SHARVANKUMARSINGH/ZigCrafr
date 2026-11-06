//! Transpiled from Horizon Rust crate
package horizon_client_windows

import "core:fmt"
import "core:mem"
import "core:math"

// Windows and monitors: which window each player plays in, opening and placing them (a
// monitor's over its menu bar), closing them, the views' layout and the windows' titles.
// use super::*;
// use horizon_client::split_layout::Placement;
// use winit::window::Window;

// Where a monitor is and its size, as windows are placed: macOS places them in points, each
// monitor at its own scale (pixels would be read at the window's scale: a window for a 1x TV
// beside a 2x screen would open on the screen, half size); Windows and X11 in desktop pixels.
    // rust: pub(super) fn cover(m: &MonitorHandle) -> (winit::dpi::Position, winit::dpi::Size) {
    // rust: {
    // rust: let scale = m.scale_factor();
    // rust: (
    // rust: m.position().to_logical::<f64>(scale).into(),
    // rust: m.size().to_logical::<f64>(scale).into(),
    // rust: )
}
    // rust: {
    // rust: (m.position().into(), m.size().into())
}
}

// Where new window `number` (854 x 480) opens on monitor `m`, in `cover`'s units: centred, and
// cascaded from the others (`layout::cascade`).
    // rust: pub(super) fn centred(m: &MonitorHandle, number: u8) -> winit::dpi::Position {
    // rust: let (at, size) = cover(m);
    // The numbers as they are, logical or physical.
    // rust: let (at, size) = (at.to_physical::<f64>(1.0), size.to_physical::<f64>(1.0));
    // rust: let u = if cfg!(target_os = "macos") {
    // rust: 1.0
    // rust: } else {
    // rust: m.scale_factor()
}
    // rust: let step = layout::cascade(number) * u;
    // rust: let x = at.x + (size.width - 854.0 * u) / 2.0 + step;
    // rust: let y = at.y + (size.height - 480.0 * u) / 2.0 + step;
    // rust: if cfg!(target_os = "macos") {
    // rust: winit::dpi::LogicalPosition::new(x, y).into()
    // rust: } else {
    // rust: winit::dpi::PhysicalPosition::new(x, y).into()
}
}

// The monitor's window titled `title` over that monitor's menu bar, all of it: one level above
// the menu bar, at the screen's whole frame. Hiding the menu bar (the presentation options) works
// only for the window with the keyboard, and a monitor's window opens without it. AppKit's own
// list of the app's windows, by title: winit's handle to it would need `unsafe`.
    // rust: pub(super) fn above_menu_bar(title: &str) {
    // rust: let Some(main_thread) = objc2::MainThreadMarker::new() else {
    // rust: return;
}
    // rust: let app = objc2_app_kit::NSApplication::sharedApplication(main_thread);
    // rust: for window in app.windows() {
    // rust: if window.title().to_string() != title {
    // rust: continue;
}
        // NSMainMenuWindowLevel (24) + 1.
    // rust: window.setLevel(25);
    // rust: if let Some(screen) = window.screen() {
    // rust: window.setFrame_display(screen.frame(), true);
}
}
}

// Move a player into a native window. Changing only its viewport keeps the grab;
// moving to another window releases it until a click there.
    // rust: pub(super) fn into_window(game: &mut Game<'_>, window: Arc<Window>) {
    // rust: let moved = game
    // rust: .window
    // rust: .as_ref()
    // rust: .is_none_or(|old| old.id() != window.id());
    // rust: if moved && game.captured {
    // rust: game.capture(false);
}
    // rust: game.window = Some(window);
}

// A window showing players' views, and the compositor that copies their frames into it.
    // rust: pub(super) struct Surface {
    // Which window this is, by number (1: the game's), and where it was opened: a number
    // given again to a window placed elsewhere opens again there.
    // rust: pub(super) key: u8,
    // rust: pub(super) placement: Placement,
    // rust: pub(super) window: Arc<Window>,
    // rust: pub(super) compositor: Compositor,
    // rust: pub(super) size: PhysicalSize<u32>,
    // rust: pub(super) focused: bool,
    // The title it was last given.
    // rust: pub(super) title: String,
}

    // rust: impl<'a> Split<'a> {
    // The window player `i` chose, by number.
    // rust: pub(super) fn window_number(&self, i: usize) -> u8 {
    // rust: match i {
    // rust: 0 => self.p1_window,
    // rust: _ => self.guests[i - 1].window,
}
}

    // rust: pub(super) fn set_window(&mut self, i: usize, number: u8) {
    // rust: match i {
    // rust: 0 => self.p1_window = number,
    // rust: _ => self.guests[i - 1].window = number,
}
}

    // rust: pub(super) fn placement(&self, number: u8) -> Option<&Placement> {
    // rust: self.windows
    // rust: .iter()
    // rust: .find(|w| w.number == number)
    // rust: .map(|w| &w.placement)
}

    // The monitors now, with their names, left to right, and the one Window 1 is on.
    // rust: pub(super) fn refresh_monitors(&mut self) {
    // rust: let Some(window) = self
    // rust: .surfaces
    // rust: .first()
    // rust: .map(|s| s.window.clone())
    // rust: .or_else(|| self.host.window.clone())
    // rust: else {
    // rust: return;
}
    // rust: self.screens = window
    // rust: .available_monitors()
    // rust: .filter_map(|m| Some((m.name()?, m)))
    // rust: .collect();
    // rust: self.screens
    // rust: .sort_by_key(|(_, m)| (m.position().x, m.position().y));
        // Wayland can list one monitor twice, and not say which one a window is on.
    // rust: self.screens.dedup_by(|a, b| a.0 == b.0);
    // rust: self.main_screen = window.current_monitor().and_then(|m| m.name()).or_else(|| {
    // rust: match self.screens.as_slice() {
    // rust: [(only, _)] => Some(only.clone()),
    // rust: _ => None,
}
    // rust: });
}

    // The monitors, by name, left to right (as of this frame).
    // rust: pub(super) fn monitors(&self) -> &[(String, MonitorHandle)] {
    // rust: &self.screens
}

    // The monitor the game's window is on: Window 1 already shows there.
    // rust: pub(super) fn main_monitor(&self) -> Option<&String> {
    // rust: self.main_screen.as_ref()
}

    // How a monitor is called: numbered left to right, with its size (the system's names are
    // ids on some).
    // rust: pub(super) fn monitor_label(&self, name: &str) -> Option<String> {
    // rust: let (n, (_, m)) = self
    // rust: .monitors()
    // rust: .iter()
    // rust: .enumerate()
    // rust: .find(|(_, (n, _))| n == name)?;
    // rust: let size = m.size();
    // rust: Some(format!(
    // rust: "Monitor {} ({}x{})",
    // rust: n + 1,
    // rust: size.width,
    // rust: size.height
    // rust: ))
}

    // The window player `i` plays in now: Window 1 for a window that fills a monitor that's
    // gone, or the one Window 1 is on.
    // rust: pub(super) fn window_of(&self, i: usize) -> u8 {
    // rust: let number = self.window_number(i);
    // rust: let shown = match self.placement(number) {
    // rust: Some(Placement::Fill(name)) => {
    // rust: Some(name) != self.main_monitor() && self.monitors().iter().any(|(n, _)| n == name)
}
    // rust: Some(Placement::Free(_)) => true,
    // rust: None => false,
}
    // rust: if shown { number } else { 1 }
}

    // Where player `i` can play, as the screens say it: Window 1 (the game's), the other windows
    // open, a new window, and each monitor no window fills but Window 1's. The page's button
    // steps forward through them (buttons take the left click only), a joining player's bumpers
    // both ways. A player alone in its window is at "New window" or its monitor's choice (its
    // window is that), so the list stays the same as it steps.
    // rust: pub(super) fn choices(&self, i: usize) -> Vec<(String, Spot)> {
    // rust: let alone = self.alone(i);
    // rust: let mine = self.window_of(i);
    // rust: let mut open: Vec<u8> = (0..self.players())
    // rust: .map(|j| self.window_of(j))
    // rust: .filter(|&n| !(alone && n == mine))
    // rust: .collect();
    // rust: open.sort_unstable();
    // rust: open.dedup();
    // rust: let filled: Vec<&String> = open
    // rust: .iter()
    // rust: .filter_map(|&n| match self.placement(n) {
    // rust: Some(Placement::Fill(name)) => Some(name),
    // rust: _ => None,
    // rust: })
    // rust: .collect();
    // rust: let main = self.main_monitor();
    // rust: let monitors = self.monitors().iter().filter_map(|(name, _)| {
    // rust: if Some(name) == main || filled.contains(&name) {
    // rust: return None;
}
    // rust: Some((self.monitor_label(name)?, Spot::Fill(name.clone())))
    // rust: });
    // rust: std::iter::once((WINDOW_1.to_owned(), Spot::Window(1)))
    // rust: .chain(
    // rust: open.into_iter()
    // rust: .filter(|&n| n != 1)
    // rust: .map(|n| (self.window_label(n), Spot::Window(n))),
    // rust: )
    // rust: .chain(std::iter::once((NEW_WINDOW.to_owned(), Spot::New)))
    // rust: .chain(monitors)
    // rust: .collect()
}

    // Player `i` plays alone in a window of its own (not Window 1).
    // rust: pub(super) fn alone(&self, i: usize) -> bool {
    // rust: let mine = self.window_of(i);
    // rust: mine != 1 && (0..self.players()).all(|j| j == i || self.window_of(j) != mine)
}

    // Player `i`'s place among its choices: its window, or alone, what its window is.
    // rust: pub(super) fn current(&self, i: usize) -> Spot {
    // rust: let mine = self.window_of(i);
    // rust: match self.placement(mine) {
    // rust: Some(Placement::Free(_)) if self.alone(i) => Spot::New,
    // rust: Some(Placement::Fill(name)) if self.alone(i) => Spot::Fill(name.clone()),
    // rust: _ => Spot::Window(mine),
}
}

    // How window `number` is shown: "Window 2", and the monitor it fills.
    // rust: pub(super) fn window_label(&self, number: u8) -> String {
    // rust: match self.placement(number) {
    // rust: Some(Placement::Fill(name)) if number != 1 => match self.monitor_label(name) {
    // rust: Some(monitor) => format!("Window {number}, {monitor}"),
    // rust: None => format!("Window {number}"),
    // rust: },
    // rust: _ => format!("Window {number}"),
}
}

    // Where player `i` plays, as the screens say it.
    // rust: pub(super) fn label(&self, i: usize) -> String {
    // rust: self.window_label(self.window_of(i))
}

    // Player `i` into a window: one there is, or a new one with the first number free.
    // rust: pub(super) fn choose(&mut self, i: usize, choice: Spot) {
    // rust: let placement = match choice {
    // rust: Spot::Window(n) => return self.set_window(i, n),
    // rust: Spot::New => Placement::Free(None),
    // rust: Spot::Fill(name) => Placement::Fill(name),
}
        // Out of its window first: alone there, its number is free again.
    // rust: self.set_window(i, 1);
    // rust: self.forget_empty_windows();
    // rust: let number = (2..=u8::MAX)
    // rust: .find(|n| self.windows.iter().all(|w| w.number != *n))
    // rust: .unwrap_or(u8::MAX);
    // rust: self.windows.push(layout::Window { number, placement });
    // rust: self.set_window(i, number);
}

    // Windows nobody plays in close (Window 1 stays).
    // rust: pub(super) fn forget_empty_windows(&mut self) {
    // rust: let used: Vec<u8> = (0..self.players()).map(|i| self.window_number(i)).collect();
    // rust: self.windows
    // rust: .retain(|w| w.number == 1 || used.contains(&w.number));
}

    // Every player's view, in the windows there are now.
    // rust: pub(super) fn views(&self) -> Vec<View> {
    // rust: let windows: Vec<usize> = (0..self.players())
    // rust: .map(|i| {
    // rust: let number = self.window_of(i);
    // rust: self.surfaces
    // rust: .iter()
    // rust: .position(|s| s.key == number)
    // rust: .unwrap_or(0)
    // rust: })
    // rust: .collect();
    // rust: let sizes: Vec<_> = self.surfaces.iter().map(|s| s.size).collect();
        // How 2 and 3 players share a window: P1's settings (Setup's layout squares).
    // rust: let e = &self.host.settings.extras;
    // rust: layout::place_ordered(
    // rust: &windows,
    // rust: &self.player_order(),
    // rust: &sizes,
    // rust: e.splitscreen_two,
    // rust: e.splitscreen_three,
    // rust: )
}

    // The players (indices) in the order they fill a window they share (`order`, by seat;
    // players it doesn't name last).
    // rust: pub(super) fn player_order(&self) -> Vec<usize> {
    // rust: let seats: Vec<usize> = std::iter::once(1)
    // rust: .chain(self.guests.iter().map(|g| g.seat))
    // rust: .collect();
    // rust: let named: Vec<usize> = self
    // rust: .order
    // rust: .iter()
    // rust: .filter_map(|seat| seats.iter().position(|s| s == seat))
    // rust: .collect();
    // rust: layout::ordered(&named, seats.len())
}

    // Every player into its view: its window, then its size. Keyboard and mouse follow their
    // player into another window; a player whose view moved or grew shows where on its badge.
    // rust: pub(super) fn relayout(&mut self, event_loop: &ActiveEventLoop) {
    // rust: let views = self.views();
    // rust: let before = std::mem::replace(&mut self.applied, views);
    // rust: for (i, &(surface, at, size)) in self.applied.clone().iter().enumerate() {
    // rust: let Some(window) = self.surfaces.get(surface).map(|s| s.window.clone()) else {
    // rust: continue;
}
    // rust: let moved = self
    // rust: .game(i)
    // rust: .and_then(|g| g.window.as_ref())
    // rust: .is_none_or(|old| old.id() != window.id());
    // rust: if let Some(game) = self.game_mut(i) {
    // rust: into_window(game, window.clone());
    // rust: game.options.split_in_main_window = surface == 0;
    // rust: game.view_at = at;
}
    // rust: if moved && i == self.focus && before.get(i).is_some() {
    // rust: window.focus_window();
}
    // rust: if moved && before.get(i).is_some() {
    // rust: let label = format!("Window {}", self.window_of(i));
    // rust: self.tag(i, &label);
}
    // rust: if let Some((player, id)) = self.player(i) {
    // rust: player.window_event(event_loop, id, WindowEvent::Resized(size));
}
}
    // rust: self.turn(0);
}

    // The places a joining player steps through with its bumpers: each window it could play in,
    // at each place among the players there ("Window 1 (1 of 2)": first is left or on top),
    // then a new window and each monitor (`choices`).
    // rust: pub(super) fn joining_stops(&self, i: usize) -> Vec<(String, Spot, usize)> {
    // rust: let mut stops = Vec::new();
    // rust: for (label, spot) in self.choices(i) {
    // rust: let others = match spot {
    // rust: Spot::Window(n) => self.sharing(i, n).len(),
    // rust: _ => 0,
}
    // rust: if others == 0 {
    // rust: stops.push((label, spot, 0));
    // rust: continue;
}
    // rust: for k in 0..=others {
    // rust: let label = format!("{label} ({} of {})", k + 1, others + 1);
    // rust: stops.push((label, spot.clone(), k));
}
}
    // rust: stops
}

    // The players but `i` in window `number`, in their order.
sharing :: proc(self: ^Self, i: uint, number: u8) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.player_order()
    // rust: .into_iter()
    // rust: .filter(|&j| j != i && self.window_of(j) == number)
    // rust: .collect()
}

    // rust: pub(super) fn seat_of(&self, i: usize) -> usize {
    // rust: if i == 0 { 1 } else { self.guests[i - 1].seat }
}

    // Player `i` to place `k` among the others in its window (0: before them all).
    // rust: pub(super) fn put_at(&mut self, i: usize, k: usize) {
    // rust: let others: Vec<usize> = self
    // rust: .sharing(i, self.window_of(i))
    // rust: .into_iter()
    // rust: .map(|j| self.seat_of(j))
    // rust: .collect();
    // rust: let me = self.seat_of(i);
    // rust: let mut order: Vec<usize> = self
    // rust: .player_order()
    // rust: .into_iter()
    // rust: .map(|j| self.seat_of(j))
    // rust: .filter(|&s| s != me)
    // rust: .collect();
    // rust: let at = match others.get(k) {
    // rust: Some(seat) => order.iter().position(|s| s == seat).unwrap_or(order.len()),
            // After the last of them.
    // rust: None => others
    // rust: .last()
    // rust: .and_then(|seat| order.iter().position(|s| s == seat))
    // rust: .map_or(order.len(), |p| p + 1),
}
    // rust: order.insert(at, me);
    // rust: self.order = order;
}

    // A bumper on the profile page (joining or switching): player `i`'s view moves to the next
    // place it could play (`back`: the one before), at once, so it sees where it will be.
    // rust: pub(super) fn move_with_bumpers(&mut self, i: usize, back: bool) {
    // rust: let stops = self.joining_stops(i);
    // rust: let n = stops.len();
    // rust: if n == 0 {
    // rust: return;
}
    // rust: let (spot, before) = (self.current(i), self.sharing_before(i));
    // rust: let at = stops
    // rust: .iter()
    // rust: .position(|(_, s, k)| *s == spot && *k == before)
    // rust: .unwrap_or(0);
    // rust: let (shown, next, k) = stops[if back { (at + n - 1) % n } else { (at + 1) % n }].clone();
    // rust: self.choose(i, next);
    // rust: self.put_at(i, k);
    // rust: if let Some(game) = self.game_mut(i) {
    // rust: game.split_hud.place = Some((
    // rust: format!("LB < {shown} > RB"),
    // rust: Instant::now() + Duration::from_secs(3),
    // rust: ));
}
}

    // Where player `i` plays now, as its bumpers' stops name it ("Window 1 (2 of 2)"); its own
    // window by its name ("Window 2").
    // rust: pub(super) fn stop_label(&self, i: usize) -> Option<String> {
    // rust: let (spot, before) = (self.current(i), self.sharing_before(i));
    // rust: if spot != Spot::Window(self.window_of(i)) {
    // rust: return Some(self.label(i));
}
    // rust: self.joining_stops(i)
    // rust: .into_iter()
    // rust: .find(|(_, s, k)| *s == spot && *k == before)
    // rust: .map(|(label, ..)| label)
}

    // How many players come before `i` in its window.
sharing_before :: proc(self: ^Self, i: uint) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let mine = self.window_of(i);
    // rust: self.player_order()
    // rust: .into_iter()
    // rust: .take_while(|&j| j != i)
    // rust: .filter(|&j| self.window_of(j) == mine)
    // rust: .count()
}

    // What a window's title says: its name and who plays in it.
    // rust: pub(super) fn title(&self, k: usize) -> String {
    // rust: let views = &self.applied;
    // rust: let who: Vec<String> = (0..self.players())
    // rust: .filter(|&i| views.get(i).is_some_and(|v| v.0 == k))
    // rust: .map(|i| self.name(i))
    // rust: .collect();
    // rust: let name = match self.surfaces[k].key {
    // rust: 1 if self.surfaces.len() == 1 => String::new(),
    // rust: n => format!(" - Window {n}"),
}
    // rust: if self.players() > 1 && !who.is_empty() {
    // rust: format!("Horizon{name} · {}", who.join(", "))
    // rust: } else {
    // rust: format!("Horizon{name}")
}
}

    // The windows the players' screens need: the game's (hidden while nobody plays on it), one
    // on each monitor picked, one for each player who wants its own. True when they changed.
    // rust: pub(super) fn sync_surfaces(&mut self, event_loop: &ActiveEventLoop) -> bool {
    // rust: if self.surfaces.is_empty() {
    // rust: return false;
}
    // rust: self.forget_empty_windows();
    // rust: let monitors = self.monitors().to_vec();
    // rust: let wanted: Vec<u8> = (0..self.players()).map(|i| self.window_of(i)).collect();
    // rust: let placements: std::collections::HashMap<u8, Placement> = self
    // rust: .windows
    // rust: .iter()
    // rust: .map(|w| (w.number, w.placement.clone()))
    // rust: .collect();
    // rust: let before = self.surfaces.len();
    // rust: for s in &self.surfaces {
            // A free window's place only: a monitor's would open a later free one monitor-sized.
    // rust: if s.key != 1
    // rust: && !wanted.contains(&s.key)
    // rust: && matches!(s.placement, Placement::Free(_))
    // rust: && let Ok(at) = s.window.outer_position()
    // rust: {
                // In points: a window from a 1x TV opens there again beside a 2x screen.
    // rust: let scale = s.window.scale_factor();
    // rust: let size = s.window.inner_size().to_logical(scale);
    // rust: self.window_rects
    // rust: .insert(s.key, (at.to_logical(scale), size));
}
}
    // rust: self.surfaces.retain(|s| {
    // rust: s.key == 1 || (wanted.contains(&s.key) && placements.get(&s.key) == Some(&s.placement))
    // rust: });
    // rust: let mut changed = self.surfaces.len() != before;
        // macOS would join new windows to the game's as tabs (when the system prefers tabs).
    // rust: {
//             use winit::platform::macos::ActiveEventLoopExtMacOS;
    // rust: event_loop.set_allows_automatic_window_tabbing(false);
}
    // rust: let mut failed = Vec::new();
    // rust: for key in &wanted {
    // rust: if failed.contains(key) || self.surfaces.iter().any(|s| &s.key == key) {
    // rust: continue;
}
            // Opened without the focus: whoever types in the game's window keeps the keyboard.
    // rust: let attributes = Window::default_attributes()
    // rust: .with_window_icon(horizon_client::window::icon())
    // rust: .with_active(false);
            // A monitor's window covers it, borderless. On macOS not the system's fullscreen, a
            // Space of its own that hides the other windows as it slides in.
    // rust: let placement = self.placement(*key).cloned();
    // rust: let fill = match &placement {
    // rust: Some(Placement::Fill(name)) => monitors
    // rust: .iter()
    // rust: .find(|(n, _)| n == name)
    // rust: .map(|(_, m)| m.clone()),
    // rust: _ => None,
}
    // rust: let cover = fill.as_ref().map(cover);
    // rust: let attributes = match cover {
                // Its own title for a moment: `above_menu_bar` finds it by it.
    // rust: Some((at, size)) => {
    // rust: let attributes = attributes
    // rust: .with_title(format!("Horizon {key}"))
    // rust: .with_decorations(false)
    // rust: .with_position(at)
    // rust: .with_inner_size(size);
                    // Elsewhere the system's borderless fullscreen (F11's): over the taskbar too.
    // rust: let attributes = attributes.with_fullscreen(
    // rust: fill.clone()
    // rust: .map(|m| winit::window::Fullscreen::Borderless(Some(m))),
    // rust: );
    // rust: attributes
}
                // A numbered window where it was last, else 854 x 480.
    // rust: None => {
    // rust: let last = self.window_rects.get(key).copied();
    // rust: match last {
    // rust: Some((at, size)) => attributes.with_position(at).with_inner_size(size),
    // rust: None => {
    // rust: let main = self.main_monitor();
    // rust: let home = monitors.iter().find(|(n, _)| Some(n) == main);
    // rust: let attributes =
    // rust: attributes.with_inner_size(LogicalSize::new(854.0, 480.0));
    // rust: match home {
    // rust: Some((_, m)) => attributes.with_position(centred(m, *key)),
    // rust: None => attributes,
}
}
}
    // rust: .with_title("Horizon")
}
}
    // rust: let made = event_loop
    // rust: .create_window(attributes)
    // rust: .map_err(Into::into)
    // rust: .and_then(|w| {
    // rust: let w = Arc::new(w);
                    // The new surface configures itself on the players' device, and that
                    // wait breaks on a frame submitted meanwhile: drain every queue first.
    // rust: self.wait_queues();
    // rust: let renderer = self.host.renderer.as_ref().ok_or("no renderer")?;
    // rust: Ok::<_, Box<dyn std::error::Error>>((w.clone(), renderer.compositor(w)?))
    // rust: });
    // rust: if let (Ok((window, _)), Some((at, size))) = (&made, cover) {
                // macOS moves a new window under the menu bar: place it again, size first (it
                // keeps a window's bottom-left corner when it resizes).
    // rust: let _ = window.request_inner_size(size);
    // rust: window.set_outer_position(at);
    // rust: above_menu_bar(&format!("Horizon {key}"));
}
    // rust: match made {
    // rust: Ok((window, compositor)) => {
    // rust: self.surfaces.push(Surface {
    // rust: key: *key,
    // rust: placement: placement.clone().unwrap_or(Placement::Free(None)),
    // rust: size: window.inner_size(),
    // rust: window,
    // rust: compositor,
    // rust: focused: false,
    // rust: title: String::new(),
    // rust: });
    // rust: changed = true;
}
                // Not tried again each frame: its players play in Window 1 (where they were
                // drawn meanwhile) and the window is forgotten.
    // rust: Err(e) => {
    // rust: log::warn!("Horizon: splitscreen: no Window {key}: {e}");
    // rust: failed.push(*key);
}
}
}
    // rust: for key in failed {
    // rust: for i in 0..self.players() {
    // rust: if self.window_number(i) == key {
    // rust: self.set_window(i, 1);
}
}
    // rust: self.windows.retain(|w| w.number != key);
}
        // The game's window only while someone plays on it.
    // rust: let main_used = (0..self.players()).any(|i| self.window_of(i) == 1);
    // rust: if self.window1_shown != main_used {
    // rust: self.surfaces[0].window.set_visible(main_used);
    // rust: self.window1_shown = main_used;
}
    // rust: for k in 0..self.surfaces.len() {
    // rust: let title = self.title(k);
    // rust: if self.surfaces[k].title != title {
    // rust: self.surfaces[k].window.set_title(&title);
    // rust: self.surfaces[k].title = title;
}
}
    // rust: changed
}

    // A window other than Window 1 was closed: its players leave, P1 goes back to Window 1.
    // rust: pub(super) fn close_window(&mut self, surface: usize) -> Result<()> {
    // rust: let views = self.views();
    // rust: for i in (0..self.players()).rev() {
    // rust: if views.get(i).is_none_or(|v| v.0 != surface) {
    // rust: continue;
}
    // rust: if i == 0 {
    // rust: self.p1_window = 1;
    // rust: continue;
}
    // rust: self.turn(i);
    // rust: let guest = &mut self.guests[i - 1];
    // rust: if guest.game.remote.is_some() {
                // One failing to leave doesn't keep the others in.
    // rust: if let Err(e) = guest.game.leave_server(None) {
    // rust: log::warn!("Horizon: splitscreen: P{} could not leave: {e}", guest.seat);
}
    // rust: } else {
                // No connection yet: remove the picker and its view immediately.
    // rust: self.remove_guest(i - 1);
}
}
    // rust: self.turn(0);
    // rust: Ok(())
}
}

// The surface whose presenting waits for the display (vsync), and whose monitor's refresh rate
// paces the frames: Window 1, or the next while Window 1 is hidden (a hidden window's present
// can block or be throttled).
    // rust: pub(super) fn paced_surface(window1_shown: bool, surfaces: usize) -> usize {
    // rust: if window1_shown || surfaces < 2 { 0 } else { 1 }
}

    // rust: mod paced_tests {
//     use super::paced_surface;

vsync_follows_the_first_shown_window :: proc() {
}
    // rust: assert_eq!(paced_surface(true, 3), 0);
    // rust: assert_eq!(
    // rust: paced_surface(false, 3),
    // rust: 1,
    // rust: "Window 1 hidden: the next window waits"
    // rust: );
    // rust: assert_eq!(paced_surface(false, 1), 0);
}
}
