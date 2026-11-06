//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_split_layout
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Splitscreen's layout, pure data tested without a window: where each player's view goes in
//! its window (`place`), and the setup screen's draft (`Draft`): the windows, where each is, who
//! plays in each, before any of it is applied.
// use winit::dpi::PhysicalSize;

/// Players at most: P1 and fifteen more.
pub const MAX_PLAYERS: usize = 16;

/// A player's view: its window (an index into the windows), its corner there and its size.
    // rust: pub type View = (usize, [u32; 2], PhysicalSize<u32>);

/// Rows of five to sixteen players sharing a window, widest first (columns on a tall window): every
/// view stays near a screen's shape, where a full grid would leave a long thin one.
    // rust: const ROWS: [&[u32]; MAX_PLAYERS - 4] = [
    // rust: &[3, 2],
    // rust: &[3, 3],
    // rust: &[3, 2, 2],
    // rust: &[3, 3, 2],
    // rust: &[3, 3, 3],
    // rust: &[4, 3, 3],
    // rust: &[4, 4, 3],
    // rust: &[4, 4, 4],
    // rust: &[4, 3, 3, 3],
    // rust: &[4, 4, 3, 3],
    // rust: &[4, 4, 4, 3],
    // rust: &[4, 4, 4, 4],
    // rust: ];

/// `order` made a whole order of `n` players: those it names (once, if there are), then the
/// others, P1 first.
pub fn ordered(order: *[usize], n: usize) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out: Vec<usize> = Vec::with_capacity(n);
    // rust: for &i in order {
    // rust: if i < n && !out.contains(&i) {
    // rust: out.push(i);
}
}
    // rust: out.extend((0..n).filter(|i| !order.contains(i)));
    // rust: out
}

/// `place` with the players sharing a window in `order` (`ordered`): the first left or on top.
/// The views are still by player.
    // rust: pub fn place_ordered(
    // rust: windows: &[usize],
    // rust: order: &[usize],
    // rust: sizes: &[PhysicalSize<u32>],
    // rust: two: u8,
    // rust: three: u8,
    // rust: ) -> Vec<View> {
    // rust: let order = ordered(order, windows.len());
    // rust: let in_order: Vec<usize> = order.iter().map(|&i| windows[i]).collect();
    // rust: let placed = place(&in_order, sizes, two, three);
    // rust: let mut views = placed.clone();
    // rust: for (k, &i) in order.iter().enumerate() {
    // rust: views[i] = placed[k];
}
    // rust: views
}

/// Each player's view, given the window each is in and the windows' sizes. Players in one window
/// share it in the order they come: two take halves (`two`: 0 side by side when wider than
/// tall, 1 side by side, 2 top and bottom); three (`three`: 0 the first wide on top and two below,
/// 1 the first tall on the left and two on the right, 2 three columns); four its quarters; five
/// to sixteen in balanced rows (`ROWS`).
pub fn place(windows: *[usize], sizes: *[PhysicalSize<u32>], two: u8, three: u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: windows
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, &window)| {
    // rust: let here = windows.iter().filter(|&&w| w == window).count();
    // rust: let slot = windows[..i].iter().filter(|&&w| w == window).count() as u32;
    // rust: let size = sizes
    // rust: .get(window)
    // rust: .copied()
    // rust: .unwrap_or(PhysicalSize::new(1, 1));
    // rust: let (w, h) = (size.width, size.height);
    // rust: let side_by_side = match two {
    // rust: 1 => true,
    // rust: 2 => false,
    // rust: _ => w >= h,
}
            // The view's cell as fractions of the window: (x0, x1, y0, y1) in halves or thirds.
    // rust: let cell = |x0: u32, x1: u32, y0: u32, y1: u32, of: u32| {
    // rust: [w * x0 / of, w * x1 / of, h * y0 / of, h * y1 / of]
}
    // rust: let [x0, x1, y0, y1] = match (here, slot) {
    // rust: (1, _) => cell(0, 1, 0, 1, 1),
    // rust: (2, s) if side_by_side => cell(s, s + 1, 0, 2, 2),
    // rust: (2, s) => cell(0, 2, s, s + 1, 2),
    // rust: (3, s) => match (three, s) {
    // rust: (2, s) => cell(s, s + 1, 0, 3, 3),
    // rust: (1, 0) => cell(0, 1, 0, 2, 2),
    // rust: (1, s) => cell(1, 2, s - 1, s, 2),
    // rust: (_, 0) => cell(0, 2, 0, 1, 2),
    // rust: (_, s) => cell(s - 1, s, 1, 2, 2),
    // rust: },
    // rust: (4, s) => cell(s % 2, s % 2 + 1, s / 2, s / 2 + 1, 2),
    // rust: (n, s) => rows(n, s, w, h),
}
    // rust: (
    // rust: window,
    // rust: [x0, y0],
    // rust: PhysicalSize::new((x1 - x0).max(1), (y1 - y0).max(1)),
    // rust: )
    // rust: })
    // rust: .collect()
}

/// Five to sixteen players: `slot`'s cell `[x0, x1, y0, y1]` in balanced rows (`ROWS`), or
/// in columns when the window is taller than wide.
pub fn rows(n: usize, slot: u32, w: u32, h: u32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let counts = ROWS[n.clamp(5, MAX_PLAYERS) - 5];
    // rust: let bands = counts.len() as u32;
    // rust: let (mut band, mut k) = (0, slot);
    // rust: while band + 1 < bands && k >= counts[band as usize] {
    // rust: k -= counts[band as usize];
    // rust: band += 1;
}
    // rust: let across = counts[band as usize];
    // Along: the long side, divided between a band's views; down: the bands.
    // rust: let (along, down) = if w >= h { (w, h) } else { (h, w) };
    // rust: let (a0, a1) = (along * k / across, along * (k + 1) / across);
    // rust: let (d0, d1) = (down * band / bands, down * (band + 1) / bands);
    // rust: if w >= h {
    // rust: [a0, a1, d0, d1]
    // rust: } else {
    // rust: [d0, d1, a0, a1]
}
}

/// A screen as the system reports it: its name, where it is on the desktop and its size (both
/// physical pixels), and its scale.
pub const Monitor = struct {
    name: []const u8,
    at: [i32,
    size: [u32,
    scale: f64,
};

    // rust: impl Monitor {
    /// Where it is on the desktop and its size, as windows are placed: macOS places them in
    /// points, each monitor at its own scale; Windows and X11 in desktop pixels.
pub fn desktop(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let k = if cfg!(target_os = "macos") {
    // rust: self.scale
    // rust: } else {
    // rust: 1.0
}
    // rust: [
    // rust: f64::from(self.at[0]) / k,
    // rust: f64::from(self.at[1]) / k,
    // rust: f64::from(self.size[0]) / k,
    // rust: f64::from(self.size[1]) / k,
    // rust: ]
}
}

/// Where a window is.
pub const Placement = enum {
    /// A normal window: its corner on the desktop (`Monitor::desktop`'s units) and its size in
    /// pixels (`None`: a new one, where the system opens it, `NEW_WINDOW` big).
    Free(Option<([i32; 2], [u32; 2])>),
    /// Borderless over the monitor of this name.
    Fill(String),
};

/// A new free window's size, in logical pixels.
pub const NEW_WINDOW: [f64; 2] = [854.0, 480.0];

/// How far window `number` opens right and down of the centre, in logical pixels: Window 2
/// centred, each next one a step further, as systems cascade new windows (back to the centre
/// after six), so new windows never open exactly on one another.
pub fn cascade(number: u8) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: f64::from(number.saturating_sub(2) % 6) * 32.0
}

/// A window: its number (1 is the game's own) and where it is.
pub const Window = struct {
    number: u8,
    placement: Placement,
};

/// Where a player can go: a window there is (by number), a new free one, or a new one filling a
/// monitor (by name).
pub const Spot = enum {
    Window(u8),
    New,
    Fill(String),
};

/// Something to tell before Apply.
pub const Warning = enum {
    /// Nobody plays in this window: it won't open (Window 1 stays, blank).
    Empty(u8),
    /// This window fills a monitor that isn't there: its players play in Window 1.
    Unplugged(u8, String),
    /// This window fills the monitor Window 1 is on: its players play in Window 1.
    OnWindow1(u8),
};

/// The setup screen's arrangement until Apply: the windows, each player's window (by number, P1
/// first) and the shapes two or three players sharing a window take (`place`'s `two`, `three`).
pub const Draft = struct {
    windows: std.ArrayList(Window),
    players: std.ArrayList(u8),
    two: u8,
    three: u8,
    /// The players (indices) in the order their views fill a window shared with others: first
    /// left or on top. Empty, or missing some: P1, P2... (`ordered`).
    order: std.ArrayList(usize),
};

    // rust: impl Draft {
    /// Everyone in Window 1 (where it is now).
pub fn everyone_here(players: usize, window1: Placement, two: u8, three: u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: windows: vec![Window {
    // rust: number: 1,
    // rust: placement: window1,
    // rust: }],
    // rust: players: vec![1; players],
    // rust: two,
    // rust: three,
    // rust: order: Vec::new(),
}
}

    /// Players `i` and `j` trade places: their windows and their places in them.
pub fn swap(self: *Self, i: usize, j: usize) void {
}
    // rust: let n = self.players.len();
    // rust: if i >= n || j >= n || i == j {
    // rust: return;
}
    // rust: self.players.swap(i, j);
    // rust: let mut order = ordered(&self.order, n);
    // rust: let (a, b) = (
    // rust: order.iter().position(|&p| p == i),
    // rust: order.iter().position(|&p| p == j),
    // rust: );
    // rust: if let (Some(a), Some(b)) = (a, b) {
    // rust: order.swap(a, b);
}
    // rust: self.order = order;
}

    /// Player `i` to place `k` among the others in its window (0: before them all; past the
    /// last: after them), the others keeping their order: the bumpers' "Window 1 (2 of 3)".
pub fn put_at(self: *Self, i: usize, k: usize) void {
}
    // rust: let n = self.players.len();
    // rust: if i >= n {
    // rust: return;
}
    // rust: let mine = self.players[i];
    // rust: let mut order: Vec<usize> = ordered(&self.order, n)
    // rust: .into_iter()
    // rust: .filter(|&p| p != i)
    // rust: .collect();
    // rust: let others: Vec<usize> = order
    // rust: .iter()
    // rust: .copied()
    // rust: .filter(|&p| self.players[p] == mine)
    // rust: .collect();
    // rust: let at = match others.get(k) {
    // rust: Some(j) => order.iter().position(|p| p == j).unwrap_or(order.len()),
    // rust: None => others
    // rust: .last()
    // rust: .and_then(|j| order.iter().position(|p| p == j))
    // rust: .map_or(order.len(), |p| p + 1),
}
    // rust: order.insert(at, i);
    // rust: self.order = order;
}

    /// The players but `i` in window `number`, in their order.
pub fn sharing(self: *Self, i: usize, number: u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ordered(&self.order, self.players.len())
    // rust: .into_iter()
    // rust: .filter(|&p| p != i && self.players[p] == number)
    // rust: .collect()
}

    /// A new free window, numbered with the lowest number free; its number.
pub fn add_window(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.open(Placement::Free(None))
}

pub fn open(self: *Self, placement: Placement) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let number = (2..=u8::MAX)
    // rust: .find(|n| self.windows.iter().all(|w| w.number != *n))
    // rust: .unwrap_or(u8::MAX);
    // rust: self.windows.push(Window { number, placement });
    // rust: number
}

    /// Player `i` to `spot`: a new window opens for it. A window it leaves empty stays in the
    /// draft until `drop_empty` (at Apply), so numbers hold still while players move. A window
    /// number the draft doesn't have is ignored.
pub fn place_player(self: *Self, i: usize, spot: Spot) void {
}
    // rust: if i >= self.players.len() {
    // rust: return;
}
    // rust: let number = match spot {
    // rust: Spot::Window(n) if self.windows.iter().any(|w| w.number == n) => n,
    // rust: Spot::Window(_) => return,
    // rust: Spot::New => self.add_window(),
    // rust: Spot::Fill(name) => self.open(Placement::Fill(name)),
}
    // rust: self.players[i] = number;
}

    /// The windows nobody plays in, gone, but Window 1 and those in `keep`. At Apply, all of
    /// them; while a draft is edited, the ones it added (the windows open now stay until Apply,
    /// so their numbers hold still as players move).
pub fn drop_empty(self: *Self, keep: []const u8) void {
}
    // rust: let players = &self.players;
    // rust: self.windows
    // rust: .retain(|w| w.number == 1 || players.contains(&w.number) || keep.contains(&w.number));
}

    /// Whether nobody plays in window `number`.
pub fn empty(self: *Self, number: u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !self.players.contains(&number)
}

    /// What to tell before Apply, in window order.
pub fn warnings(self: *Self, monitors: *[Monitor], main: []const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Vec::new();
    // rust: for w in &self.windows {
    // rust: if let Placement::Fill(name) = &w.placement
    // rust: && !monitors.iter().any(|m| &m.name == name)
    // rust: {
    // rust: out.push(Warning::Unplugged(w.number, name.clone()));
    // rust: } else if w.number != 1 && w.placement == Placement::Fill(main.to_owned()) {
    // rust: out.push(Warning::OnWindow1(w.number));
    // rust: } else if !self.players.contains(&w.number) {
    // rust: out.push(Warning::Empty(w.number));
}
}
    // rust: out
}

    /// Where each window would be: its corner on the desktop (`Monitor::desktop`'s units) and its
    /// size in pixels, in `windows` order: free ones where they were (new ones at `main`'s
    /// corner), the others over their monitor; a window over a missing monitor or Window 1's
    /// (its players play in Window 1, as the game does): `None`. Window 1 always has one: give
    /// it its real rect (`Free(Some)`); else it is taken as a new window would open.
pub fn rects(self: *Self, monitors: *[Monitor], main: []const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let home = monitors
    // rust: .iter()
    // rust: .find(|m| m.name == main)
    // rust: .or(monitors.first());
        // Centred on Window 1's monitor, as the game opens a new window.
    // rust: let new = |number: u8| {
    // rust: let (at, scale, k) = home.map_or(([0.0; 4], 1.0, 1.0), |m| {
    // rust: let at = m.desktop();
    // rust: (at, m.scale, at[2] / f64::from(m.size[0].max(1)))
    // rust: });
    // rust: let size = NEW_WINDOW.map(|v| (v * scale).round() as u32);
    // rust: let step = cascade(number) * scale * k;
    // rust: let x = at[0] + (at[2] - f64::from(size[0]) * k) / 2.0 + step;
    // rust: let y = at[1] + (at[3] - f64::from(size[1]) * k) / 2.0 + step;
    // rust: ([x as i32, y as i32], size)
}
    // rust: self.windows
    // rust: .iter()
    // rust: .map(|w| {
    // rust: let rect = match &w.placement {
    // rust: Placement::Free(Some(rect)) => Some(*rect),
    // rust: Placement::Free(None) => Some(new(w.number)),
    // rust: Placement::Fill(name) if w.number != 1 && name == main => None,
    // rust: Placement::Fill(name) => monitors.iter().find(|m| &m.name == name).map(|m| {
    // rust: let at = m.desktop();
    // rust: ([at[0] as i32, at[1] as i32], m.size)
    // rust: }),
}
                // Everyone with nowhere else plays in Window 1: it never has no size.
    // rust: if w.number == 1 {
    // rust: rect.or_else(|| Some(new(1)))
    // rust: } else {
    // rust: rect
}
    // rust: })
    // rust: .collect()
}

    /// Every player's view as Apply would make it (`place`, as the game tiles them), with
    /// `View`'s window an index into `windows`; players of a window over a missing monitor in
    /// Window 1's.
pub fn preview(self: *Self, monitors: *[Monitor], main: []const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let rects = self.rects(monitors, main);
    // rust: let index = |number: u8| self.windows.iter().position(|w| w.number == number);
    // rust: let window1 = index(1).unwrap_or(0);
    // rust: let windows: Vec<usize> = self
    // rust: .players
    // rust: .iter()
    // rust: .map(|&n| index(n).filter(|&i| rects[i].is_some()).unwrap_or(window1))
    // rust: .collect();
    // rust: let sizes: Vec<PhysicalSize<u32>> = rects
    // rust: .iter()
    // rust: .map(|r| {
    // rust: r.map_or(PhysicalSize::new(1, 1), |(_, [w, h])| {
    // rust: PhysicalSize::new(w, h)
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: place_ordered(&windows, &self.order, &sizes, self.two, self.three)
}
}

    // rust: mod tests {
//     use super::*;

pub fn window_1_always_has_a_size_and_unknown_windows_take_nobody() void {
}
    // rust: let monitors = [Monitor {
    // rust: name: "Main".into(),
    // rust: at: [0, 0],
    // rust: size: [1920, 1080],
    // rust: scale: 1.0,
    // rust: }];
    // rust: let mut d = Draft::everyone_here(2, Placement::Fill("Gone".into()), 0, 0);
    // rust: assert!(d.rects(&monitors, "Main")[0].is_some());
    // rust: assert!(d.preview(&monitors, "Main").iter().all(|v| v.2.width > 1));
    // rust: d.place_player(1, Spot::Window(9));
    // rust: assert_eq!(d.players, [1, 1], "no Window 9 in the draft");
}

pub fn size(w: u32, h: u32) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: PhysicalSize::new(w, h)
}

pub fn players_on_one_screen_share_it() void {
}
    // rust: let wide = [size(1920, 1080)];
    // rust: assert_eq!(
    // rust: place(&[0, 0], &wide, 0, 0)[1],
    // rust: (0, [960, 0], size(960, 1080))
    // rust: );
    // rust: assert_eq!(
    // rust: place(&[0, 0], &wide, 2, 0)[1],
    // rust: (0, [0, 540], size(1920, 540))
    // rust: );
        // Auto on a tall screen: top and bottom.
    // rust: assert_eq!(place(&[0, 0], &[size(1080, 1920)], 0, 0)[1].1, [0, 960]);
    // rust: assert_eq!(
    // rust: place(&[0; 4], &wide, 0, 0)[3],
    // rust: (0, [960, 540], size(960, 540))
    // rust: );
}

pub fn desk_and_couch() void {
}
        // P1 alone at the desk; P2 and P3 share the TV.
    // rust: let screens = [size(3024, 1964), size(3840, 2160)];
    // rust: let views = place(&[0, 1, 1], &screens, 0, 0);
    // rust: assert_eq!(views[0], (0, [0, 0], size(3024, 1964)));
    // rust: assert_eq!(views[1], (1, [0, 0], size(1920, 2160)));
    // rust: assert_eq!(views[2], (1, [1920, 0], size(1920, 2160)));
}

pub fn three_on_a_screen() void {
}
    // rust: let tv = [size(1920, 1080)];
        // One wide on top, two below.
    // rust: let top = place(&[0; 3], &tv, 0, 0);
    // rust: assert_eq!(top[0], (0, [0, 0], size(1920, 540)));
    // rust: assert_eq!(top[2], (0, [960, 540], size(960, 540)));
        // One tall on the left, two stacked on the right.
    // rust: let left = place(&[0; 3], &tv, 0, 1);
    // rust: assert_eq!(left[0], (0, [0, 0], size(960, 1080)));
    // rust: assert_eq!(left[2], (0, [960, 540], size(960, 540)));
        // Three columns.
    // rust: assert_eq!(
    // rust: place(&[0; 3], &tv, 0, 2)[2],
    // rust: (0, [1280, 0], size(640, 1080))
    // rust: );
}

pub fn two_windows_two_players_each() void {
}
        // P1 and P2 at the desk, P3 and P4 on the TV: halves in each window.
    // rust: let screens = [size(3024, 1964), size(3840, 2160)];
    // rust: let views = place(&[0, 0, 1, 1], &screens, 0, 0);
    // rust: assert_eq!(views[1], (0, [1512, 0], size(1512, 1964)));
    // rust: assert_eq!(views[2], (1, [0, 0], size(1920, 2160)));
    // rust: assert_eq!(views[3], (1, [1920, 0], size(1920, 2160)));
}

pub fn five_to_eight_in_rows_of_three_and_two() void {
}
    // rust: let tv = [size(1920, 1080)];
    // rust: let eight = place(&[0; 8], &tv, 0, 0);
    // rust: assert_eq!(eight[0], (0, [0, 0], size(640, 360)));
    // rust: assert_eq!(eight[5], (0, [1280, 360], size(640, 360)));
    // rust: assert_eq!(eight[7], (0, [960, 720], size(960, 360)));
    // rust: let seven = place(&[0; 7], &tv, 0, 0);
    // rust: assert_eq!(seven[3], (0, [0, 360], size(960, 360)));
        // Every count tiles the window exactly: no gap, no overlap.
    // rust: for n in 5..=MAX_PLAYERS {
    // rust: for screen in [size(1920, 1080), size(1080, 1920), size(1711, 997)] {
    // rust: let views = place(&vec![0; n], &[screen], 0, 0);
    // rust: for (i, (_, [x, y], size)) in views.iter().enumerate() {
    // rust: assert!(x + size.width <= screen.width && y + size.height <= screen.height);
    // rust: for (_, [ox, oy], other) in &views[..i] {
    // rust: assert!(
    // rust: x + size.width <= *ox
    // rust: || ox + other.width <= *x
    // rust: || y + size.height <= *oy
    // rust: || oy + other.height <= *y,
    // rust: "overlapping views for {n} in {screen:?}"
    // rust: );
}
}
    // rust: let area: u64 = views
    // rust: .iter()
    // rust: .map(|v| u64::from(v.2.width) * u64::from(v.2.height))
    // rust: .sum();
    // rust: assert_eq!(
    // rust: area,
    // rust: u64::from(screen.width) * u64::from(screen.height),
    // rust: "{n} in {screen:?}"
    // rust: );
}
}
        // A tall window: columns.
    // rust: let tall = place(&[0; 5], &[size(1080, 1920)], 0, 0);
    // rust: assert_eq!(tall[0], (0, [0, 0], size(540, 640)));
    // rust: assert_eq!(tall[4], (0, [540, 960], size(540, 960)));
}

pub fn sixteen_players_form_a_four_by_four_grid() void {
}
    // rust: let views = place(&[0; 16], &[size(3840, 2160)], 0, 0);
    // rust: for (i, view) in views.iter().enumerate() {
    // rust: assert_eq!(
    // rust: *view,
    // rust: (
    // rust: 0,
    // rust: [(i as u32 % 4) * 960, (i as u32 / 4) * 540],
    // rust: size(960, 540)
    // rust: )
    // rust: );
}
    // rust: let mut draft = here(16);
    // rust: draft.place_player(15, Spot::New);
    // rust: let views = draft.preview(&monitors(), "Built-in");
    // rust: assert_eq!(views.len(), 16);
    // rust: assert_ne!(views[0].0, views[15].0);
}

pub fn monitors() V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: vec![
    // rust: Monitor {
    // rust: name: "Built-in".into(),
    // rust: at: [0, 0],
    // rust: size: [3024, 1964],
    // rust: scale: 2.0,
    // rust: },
    // rust: Monitor {
    // rust: name: "TV".into(),
    // rust: at: [3024, 0],
    // rust: size: [3840, 2160],
    // rust: scale: 1.0,
    // rust: },
    // rust: ]
}

    /// P1 in Window 1, everyone else in Window 2 filling the TV.
    // rust: trait DeskAndTv {
pub fn desk_and_tv(self: *Self, monitors: *[Monitor], main: []const u8) O;
}
    // rust: impl DeskAndTv for Draft {
pub fn desk_and_tv(monitors: *[Monitor], main: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let tv = monitors.iter().find(|m| m.name != main)?;
    // rust: self.windows.push(Window {
    // rust: number: 2,
    // rust: placement: Placement::Fill(tv.name.clone()),
    // rust: });
    // rust: for p in self.players.iter_mut().skip(1) {
    // rust: *p = 2;
}
    // rust: Some(self)
}
}

pub fn here(players: usize) D {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Draft::everyone_here(
    // rust: players,
    // rust: Placement::Free(Some(([100, 100], [2000, 1200]))),
    // rust: 0,
    // rust: 0,
    // rust: )
}

pub fn presets() void {
}
    // rust: let m = monitors();
        // Everyone here: four quarters of Window 1.
    // rust: let views = here(4).preview(&m, "Built-in");
    // rust: assert_eq!(views[3], (0, [1000, 600], size(1000, 600)));
        // P1 alone, the others share the TV in rows.
    // rust: let tv = here(4).desk_and_tv(&m, "Built-in").unwrap();
    // rust: assert_eq!(tv.players, [1, 2, 2, 2]);
    // rust: assert_eq!(tv.windows[1].placement, Placement::Fill("TV".into()));
    // rust: let views = tv.preview(&m, "Built-in");
    // rust: assert_eq!(views[0], (0, [0, 0], size(2000, 1200)));
    // rust: assert_eq!(views[1], (1, [0, 0], size(3840, 1080)));
}

pub fn new_windows_cascade_instead_of_stacking() void {
}
    // rust: let m = monitors();
    // rust: let mut d = here(3);
    // rust: d.place_player(1, Spot::New);
    // rust: d.place_player(2, Spot::New);
    // rust: let rects = d.rects(&m, "Built-in");
    // rust: let ((a, _), (b, _)) = (rects[1].unwrap(), rects[2].unwrap());
        // Window 3 a step right and down of Window 2, on the same diagonal.
    // rust: assert!(b[0] > a[0] && b[0] - a[0] == b[1] - a[1]);
    // rust: assert_eq!((cascade(2), cascade(3), cascade(8)), (0.0, 32.0, 0.0));
}

pub fn put_at_a_place_among_a_window_s_players() void {
}
    // rust: let mut d = here(3);
    // rust: d.put_at(2, 0);
    // rust: assert_eq!(d.order, [2, 0, 1]);
    // rust: d.put_at(2, 5); // past the last: after them
    // rust: assert_eq!(d.order, [0, 1, 2]);
        // Players in another window keep their places.
    // rust: d.players = vec![1, 2, 1];
    // rust: d.put_at(2, 0);
    // rust: assert_eq!(d.sharing(2, 1), [0]);
    // rust: assert_eq!(d.order, [2, 0, 1]);
}

pub fn an_order_names_each_player_once_and_the_others_come_last() void {
}
    // rust: assert_eq!(ordered(&[], 3), [0, 1, 2]);
    // rust: assert_eq!(ordered(&[2, 0], 3), [2, 0, 1]);
        // Gone players and repeats are dropped.
    // rust: assert_eq!(ordered(&[5, 1, 1], 3), [1, 0, 2]);
}

pub fn players_sharing_a_window_fill_it_in_their_order() void {
}
    // rust: let wide = [size(2000, 1000)];
        // P2 first: P2 on the left, P1 on the right.
    // rust: let views = place_ordered(&[0, 0], &[1, 0], &wide, 0, 0);
    // rust: assert_eq!(views[1].1, [0, 0]);
    // rust: assert_eq!(views[0].1, [1000, 0]);
        // P3 first of three: the wide view on top is P3's.
    // rust: let views = place_ordered(&[0, 0, 0], &[2], &wide, 0, 0);
    // rust: assert_eq!(views[2].2, size(2000, 500));
}

pub fn two_players_swap_in_a_window_and_between_windows() void {
}
    // rust: let m = monitors();
        // In one window: P1 and P2 trade sides.
    // rust: let mut d = here(2);
    // rust: d.swap(0, 1);
    // rust: assert_eq!(d.order, [1, 0]);
    // rust: let views = d.preview(&m, "Built-in");
    // rust: assert!(views[1].1[0] < views[0].1[0], "P2 left of P1");
        // Between windows: P2 on the TV, P3 in Window 1; they trade windows.
    // rust: let mut d = here(3);
    // rust: d.place_player(1, Spot::Fill("TV".into()));
    // rust: d.swap(1, 2);
    // rust: assert_eq!(d.players, [1, 1, 2]);
}

pub fn players_placed() void {
}
    // rust: let m = monitors();
    // rust: let mut d = here(3);
    // rust: d.place_player(1, Spot::Fill("TV".into()));
    // rust: d.place_player(2, Spot::Window(2));
    // rust: assert_eq!(d.players, [1, 2, 2]);
    // rust: d.place_player(2, Spot::New);
    // rust: assert_eq!(d.players, [1, 2, 3]);
    // rust: assert!(d.warnings(&m, "Built-in").is_empty());
        // The window left behind stays while the draft is edited (numbers hold still), and
        // closes at Apply; Window 1 never.
    // rust: d.place_player(1, Spot::Window(1));
    // rust: let numbers = |d: &Draft| d.windows.iter().map(|w| w.number).collect::<Vec<_>>();
    // rust: assert_eq!(numbers(&d), [1, 2, 3]);
    // rust: assert!(d.empty(2));
    // rust: d.drop_empty(&[]);
    // rust: assert_eq!(numbers(&d), [1, 3]);
    // rust: assert!(d.warnings(&m, "Built-in").is_empty());
    // rust: d.place_player(0, Spot::Window(3));
    // rust: d.place_player(1, Spot::Window(3));
    // rust: assert_eq!(d.warnings(&m, "Built-in"), [Warning::Empty(1)]);
}

pub fn windows_numbered_lowest_free() void {
}
    // rust: let mut d = here(3);
    // rust: assert_eq!(d.add_window(), 2);
    // rust: assert_eq!(d.add_window(), 3);
    // rust: d.windows.retain(|w| w.number != 2);
    // rust: assert_eq!(d.add_window(), 2);
        // Nobody to place: no window opens for it.
    // rust: d.place_player(9, Spot::New);
    // rust: assert_eq!(d.windows.len(), 3);
}

pub fn a_window_over_window_1s_monitor() void {
}
    // rust: let m = monitors();
    // rust: let mut d = here(2);
    // rust: d.place_player(1, Spot::Fill("Built-in".into()));
    // rust: assert_eq!(d.warnings(&m, "Built-in"), [Warning::OnWindow1(2)]);
        // As the game does: P2 beside P1 in Window 1.
    // rust: assert_eq!(d.preview(&m, "Built-in")[1].0, 0);
}

pub fn warnings_and_an_unplugged_monitor() void {
}
    // rust: let m = monitors();
    // rust: let mut d = here(2).desk_and_tv(&m, "Built-in").unwrap();
    // rust: let three = d.add_window();
    // rust: assert_eq!(d.warnings(&m, "Built-in"), [Warning::Empty(three)]);
        // The TV unplugged: its player plays in Window 1 beside P1.
    // rust: assert_eq!(
    // rust: d.warnings(&m[..1], "Built-in"),
    // rust: [Warning::Unplugged(2, "TV".into()), Warning::Empty(three)]
    // rust: );
    // rust: let views = d.preview(&m[..1], "Built-in");
    // rust: assert_eq!(views[1], (0, [1000, 0], size(1000, 1200)));
        // P1 elsewhere: Window 1 is blank.
    // rust: d.players = vec![2, 2];
    // rust: assert_eq!(d.warnings(&m, "Built-in")[0], Warning::Empty(1));
}

pub fn eight_players_two_windows() void {
}
    // rust: let m = monitors();
    // rust: let d = here(8).desk_and_tv(&m, "Built-in").unwrap();
    // rust: let views = d.preview(&m, "Built-in");
        // Seven on the TV: rows of 3, 2 and 2, the whole TV covered.
    // rust: let area: u64 = views[1..]
    // rust: .iter()
    // rust: .map(|v| u64::from(v.2.width) * u64::from(v.2.height))
    // rust: .sum();
    // rust: assert_eq!(area, 3840 * 2160);
    // rust: assert!(views[1..].iter().all(|v| v.0 == 1));
}
}
