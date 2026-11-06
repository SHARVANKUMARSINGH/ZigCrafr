//! Transpiled from Horizon Rust crate
package horizon_client_setup

import "core:fmt"
import "core:mem"
import "core:math"

// P1's Setup screen's side in the game: the arrangement as a draft, and Apply.
// use super::*;

    // rust: impl<'a> Split<'a> {
    // The arrangement now, for the Setup screen: free windows where they are.
    // rust: pub(super) fn draft(&self) -> layout::Draft {
        // Wayland never says where a window is: those are shown at their real size, side by side
        // from the first monitor's corner, so the map never stacks them.
    // rust: let mut shelf = self.monitors().first().map_or(0, |(_, m)| m.position().x);
    // rust: let windows = self
    // rust: .windows
    // rust: .iter()
    // rust: .map(|w| {
    // rust: let here = self.surfaces.iter().find(|s| s.key == w.number);
    // rust: let placement = match (&w.placement, here) {
    // rust: (Placement::Free(_), Some(s)) => {
                        // On the desktop as windows are placed: macOS in points.
    // rust: let k = if cfg!(target_os = "macos") {
    // rust: s.window.scale_factor()
    // rust: } else {
    // rust: 1.0
}
    // rust: let at = match s.window.outer_position() {
    // rust: Ok(at) => [(f64::from(at.x) / k) as i32, (f64::from(at.y) / k) as i32],
    // rust: Err(_) => {
    // rust: let y = self.monitors().first().map_or(0, |(_, m)| m.position().y);
    // rust: let at = [shelf, y];
    // rust: shelf += (f64::from(s.size.width) / k) as i32 + 16;
    // rust: at
}
}
    // rust: Placement::Free(Some((at, [s.size.width, s.size.height])))
}
    // rust: (p, _) => p.clone(),
}
    // rust: layout::Window {
    // rust: number: w.number,
    // rust: placement,
}
    // rust: })
    // rust: .collect();
    // rust: let e = &self.host.settings.extras;
    // rust: layout::Draft {
    // rust: windows,
    // rust: players: (0..self.players()).map(|i| self.window_number(i)).collect(),
    // rust: two: e.splitscreen_two,
    // rust: three: e.splitscreen_three,
    // rust: order: self.player_order(),
}
}

    // The monitors for the Setup screen, left to right (as `monitor_label` numbers them), and
    // the one Window 1 is on.
    // rust: pub(super) fn setup_monitors(&self) -> (Vec<layout::Monitor>, String) {
    // rust: let monitors = self
    // rust: .monitors()
    // rust: .iter()
    // rust: .map(|(name, m)| layout::Monitor {
    // rust: name: name.clone(),
    // rust: at: [m.position().x, m.position().y],
    // rust: size: [m.size().width, m.size().height],
    // rust: scale: m.scale_factor(),
    // rust: })
    // rust: .collect();
    // rust: (monitors, self.main_monitor().cloned().unwrap_or_default())
}

    // The Setup screen applied: its windows, and every player in its window. Windows nobody
    // plays in close (`forget_empty_windows`).
    // rust: pub(super) fn apply(&mut self, draft: layout::Draft) {
    // rust: let mut windows: Vec<layout::Window> = draft
    // rust: .windows
    // rust: .into_iter()
    // rust: .map(|w| {
                // A free window stays where it is; a new one opens where the system puts it.
    // rust: let placement = match (&w.placement, self.placement(w.number)) {
    // rust: (Placement::Free(_), Some(Placement::Free(p))) => Placement::Free(*p),
    // rust: (Placement::Free(_), _) => Placement::Free(None),
    // rust: (p, _) => p.clone(),
}
    // rust: layout::Window {
    // rust: number: w.number,
    // rust: placement,
}
    // rust: })
    // rust: .collect();
    // rust: if !windows.iter().any(|w| w.number == 1) {
    // rust: windows.insert(
    // rust: 0,
    // rust: layout::Window {
    // rust: number: 1,
    // rust: placement: Placement::Free(None),
    // rust: },
    // rust: );
}
    // rust: self.windows = windows;
        // Players who joined while it was open stay where they are.
    // rust: for (i, &number) in draft.players.iter().enumerate().take(self.players()) {
    // rust: let number = if self.placement(number).is_some() {
    // rust: number
    // rust: } else {
    // rust: 1
}
    // rust: self.set_window(i, number);
}
        // Who is first in a shared window, by seat (players are by index in the draft).
    // rust: let n = self.players();
    // rust: self.order = layout::ordered(&draft.order, n)
    // rust: .into_iter()
    // rust: .map(|i| self.seat_of(i))
    // rust: .collect();
        // How 2 and 3 share a window: P1's settings, saved in its options file (its turn).
    // rust: self.turn(0);
    // rust: let e = &mut self.host.settings.extras;
    // rust: if (e.splitscreen_two, e.splitscreen_three) != (draft.two, draft.three) {
    // rust: e.splitscreen_two = draft.two;
    // rust: e.splitscreen_three = draft.three;
    // rust: self.host.settings.save(&Game::options_path());
}
}

    // P1's Setup screen: the arrangement now, the monitors and the players' names; Apply
    // arranges them. True when it did.
    // rust: pub(super) fn sync_setup(&mut self) -> bool {
//         use horizon_client::options_ui::Page;
    // rust: if self.host.ui.options.page() != Page::SplitSetup {
    // rust: return false;
}
        // Window/fullscreen changes during P1's turn can invalidate Windows monitor handles.
    // rust: self.refresh_monitors();
    // rust: let live = self.draft();
    // rust: let (monitors, main) = self.setup_monitors();
        // A player whose controller disconnected says so on its tile.
    // rust: let names = (0..self.players())
    // rust: .map(|i| {
    // rust: let name = self.name(i);
    // rust: match self.lost.iter().any(|l| l.seat == self.seat_of(i)) {
    // rust: true => format!("{name} (no controller)"),
    // rust: false => name,
}
    // rust: })
    // rust: .collect();
    // rust: let seats: Vec<usize> = (0..self.players()).map(|i| self.seat_of(i)).collect();
    // rust: let moved = std::mem::replace(&mut self.setup_seats, seats) != self.setup_seats;
    // rust: let setup = &mut self.host.ui.options.split_setup;
        // Someone joined or left: the draft would put the players in the wrong places.
    // rust: if moved {
    // rust: setup.reset();
}
    // rust: let applied = setup.apply.take();
    // rust: let identify = std::mem::take(&mut setup.identify);
    // rust: let give_up = std::mem::take(&mut setup.give_up_pad);
    // rust: if std::mem::take(&mut setup.toggle_names) {
    // rust: let e = &mut self.host.settings.extras;
    // rust: e.splitscreen_names = !e.splitscreen_names;
    // rust: self.host.settings.save(&Game::options_path());
}
    // rust: let names_shown = self.host.settings.extras.splitscreen_names;
    // rust: if give_up {
    // rust: self.give_up_pad();
}
        // Give Up Pad shows while P1 has a controller in a world others can join.
    // rust: let p1_pad = self.p1_pad.owner.is_some() && self.in_world();
    // rust: let setup = &mut self.host.ui.options.split_setup;
    // rust: setup.names_shown = names_shown;
    // rust: setup.p1_pad = p1_pad;
    // rust: setup.idle = self.surfaces.is_empty();
    // rust: setup.live = Some(live);
    // rust: setup.monitors = monitors;
    // rust: setup.main = main;
    // rust: setup.names = names;
    // rust: let changed = applied.is_some();
    // rust: if let Some(draft) = applied {
    // rust: self.apply(draft);
}
        // Every view says where it is: after a change, or asked (Identify).
    // rust: if changed || identify {
    // rust: for i in 0..self.players() {
    // rust: let label = horizon_client::lang::tr(
    // rust: "horizon.splitscreen.setup.window",
    // rust: &[&self.window_of(i)],
    // rust: );
    // rust: self.tag(i, &label);
}
}
    // rust: changed
}
}
