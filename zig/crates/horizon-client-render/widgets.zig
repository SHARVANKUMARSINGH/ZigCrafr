//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_widgets
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The labelled widgets and focus targets drawn in the last frame, for the
//! control socket: a script clicks a button by its label (`horizon-ctl
//! click-button Respawn`) or any widget by its id in [`tree`] (`horizon-ctl
//! click done`), whatever screen drew it. Also the mouse cursor the widget
//! under the mouse asks for.
// use crate::gamepad::ScrollArea;
// use std::cell::{Cell, RefCell};

/// The mouse cursor a frame's widgets asked for (`CursorTypes`; the others
/// aren't asked for yet).
pub const Cursor = enum {
    Arrow,
    PointingHand,
    NotAllowed,
};

    // rust: thread_local! {
    /// `GuiGraphicsExtractor.requestCursor`: the last request since [`take_cursor`].
pub const CURSOR: Cell<Cursor> = const { Cell::new(Cursor::Arrow) };
}

/// `GuiGraphicsExtractor.requestCursor`: the last request of a frame wins.
pub fn request_cursor(cursor: Cursor) void {
}
    // rust: CURSOR.set(cursor);
}

/// `AbstractWidget.handleCursor`: a hovered widget asks for the pointing
/// hand, or for not-allowed when it is inactive.
pub fn widget_cursor(hovered: bool, active: bool) void {
}
    // rust: if hovered {
    // rust: request_cursor(if active {
    // rust: Cursor::PointingHand
    // rust: } else {
    // rust: Cursor::NotAllowed
    // rust: });
}
}

/// The cursor the frame asked for, and back to the arrow for the next one
/// (the window shows the arrow unless a widget asks).
pub fn take_cursor() C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: CURSOR.replace(Cursor::Arrow)
}

/// A labelled widget in GUI pixels (the coordinates screens take input in).
pub const Widget = struct {
    label: []const u8,
    x: f32,
    y: f32,
    w: f32,
    h: f32,
    enabled: bool,
    /// Buttons for [`record`]; sliders and tabs carry their labels too.
    kind: Kind,
};

/// What a controller does with a focus target (docs/controllers.md, "Focus
/// navigation").
pub const Kind = enum {
    /// Clicked with A (buttons, icon buttons, keys).
    Button,
    /// Left and right move the value instead of focus; A does nothing (a
    /// click would jump the handle to the middle). `value` is 0..1 as drawn;
    /// `track` is where a click sets 0 and the width a click spans to 1.
    Slider { value: f32, track: [f32; 2] },
    /// A text field: A focuses it and opens an on-screen keyboard.
    Field,
    /// A list row (worlds, servers, packs, languages): A selects it.
    Row,
    /// An inventory slot: A/X/Y click, right click and quick-move it.
    Slot,
    /// A tab (`true` is the selected one): the bumpers step through them.
    Tab(bool),
};

/// A focus target: a rectangle in GUI pixels and what it is.
pub const Target = struct {
    rect: [f32,
    kind: Kind,
};
    // rust: impl Target {
pub fn center(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [x, y, w, h] = self.rect;
    // rust: (x + w / 2.0, y + h / 2.0)
}
}

    // rust: thread_local! {
    /// Buttons drawn since the last `end_frame`, and the last frame's.
pub const WIDGETS: RefCell<(std.ArrayList(Widget), std.ArrayList(Widget), u64)> = const { RefCell::new((Vec::new(), Vec::new(), 0)) };
    /// Every interactive rectangle (sliders, fields, list rows, the
    /// on-screen keyboard's keys), labelled or not: where a controller can move focus. Drawn since
    /// `end_frame`, the last frame's, and how many frames rotated.
pub const TARGETS: RefCell<(std.ArrayList(Target), std.ArrayList(Target), u64)> = const { RefCell::new((Vec::new(), Vec::new(), 0)) };
    /// The buttons drawn since the last `end_frame` that declared their job, and the last frame's.
pub const ACTIONS: RefCell<(std.ArrayList(DeclaredAction), std.ArrayList(DeclaredAction))> = const { RefCell::new((Vec::new(), Vec::new())) };
    /// The pad drives, so declared buttons show their glyph (labels leave it room).
pub const ACTION_GLYPHS: Cell<bool> = const { Cell::new(false) };
    /// The screen the buttons in `ACTIONS` were declared on, the same two frames.
pub const ACTION_SCREENS: Cell<(u64, u64)> = const { Cell::new((0, 0)) };
    /// The lists drawn with a scrollbar since `end_frame`, and the last frame's.
pub const SCROLL_AREAS: RefCell<(std.ArrayList(ScrollArea), std.ArrayList(ScrollArea))> = const { RefCell::new((Vec::new(), Vec::new())) };
}

/// Splitscreen: one player's buttons and focus targets, kept aside while another player's game
/// runs on this thread ([`take`] and [`put`] around each turn).
pub const Saved = struct {
    // rust: (Vec<Widget>, Vec<Widget>, u64),
    // rust: (Vec<Target>, Vec<Target>, u64),
    // rust: (Vec<DeclaredAction>, Vec<DeclaredAction>),
    // rust: bool,
    // rust: (u64, u64),
    // rust: (Vec<ScrollArea>, Vec<ScrollArea>),
    // rust: );

/// This thread's buttons and targets, leaving none.
pub fn take() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Saved(
    // rust: WIDGETS.take(),
    // rust: TARGETS.take(),
    // rust: ACTIONS.take(),
    // rust: ACTION_GLYPHS.take(),
    // rust: ACTION_SCREENS.take(),
    // rust: SCROLL_AREAS.take(),
    // rust: )
};

/// Bring back what [`take`] kept.
pub fn put(saved: Saved) void {
}
    // rust: WIDGETS.set(saved.0);
    // rust: TARGETS.set(saved.1);
    // rust: SCROLL_AREAS.set(saved.5);
    // rust: ACTIONS.set(saved.2);
    // rust: ACTION_GLYPHS.set(saved.3);
    // rust: ACTION_SCREENS.set(saved.4);
}

/// A button's job on its screen. A screen declares it ([`crate::ui::action_button`]) and the
/// controller's button, its glyph and its place on every pad follow (docs/controllers.md,
/// "Adding a screen").
pub const Action = enum {
    /// Leaves the screen, keeping what was set.
    Done,
    /// Goes back one screen.
    Back,
    /// Leaves the screen, dropping what was set.
    Cancel,
    /// Applies what was set and stays or leaves as the screen does.
    Apply,
    /// Opens the options.
    Options,
    /// Leaves the game or the world: the pad moves the focus here, and A confirms.
    Exit,
};

/// A button that declared its job, as last drawn.
pub const DeclaredAction = struct {
    action: Action,
    rect: [f32,
    enabled: bool,
};

/// `rect` is the button doing `action` on this screen; see [`crate::ui::action_button`], for a
/// screen that draws its buttons itself.
pub fn declare_action(action: Action, rect: [f32; 4], enabled: bool) void {
}
    // rust: ACTIONS.with_borrow_mut(|(current, _)| {
    // rust: if current.len() < 16 {
    // rust: current.push(DeclaredAction {
    // rust: action,
    // rust: rect,
    // rust: enabled,
    // rust: });
}
    // rust: });
}

/// The buttons of the last drawn frame that declared their job, if it drew `screen`: until the
/// screen just opened is drawn, the one it replaced can't be pressed.
pub fn last_actions(screen: u64) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if ACTION_SCREENS.get().1 != screen {
    // rust: return Vec::new();
}
    // rust: ACTIONS.with_borrow(|(_, last)| last.clone())
}

/// The frame being drawn shows `screen` (the controller's own key for it).
pub fn set_action_screen(screen: u64) void {
}
    // rust: ACTION_SCREENS.set((screen, ACTION_SCREENS.get().1));
}

/// Whether declared buttons are showing their glyph: only while the pad drives.
pub fn set_action_glyphs(on: bool) void {
}
    // rust: ACTION_GLYPHS.set(on);
}

/// How much of a declared button's left the glyph takes from its label: a face button's, the only
/// kind declared buttons show, and no family's is wider than its art.
pub fn action_glyph_room() f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if ACTION_GLYPHS.get() {
    // rust: crate::pad_glyph::FACE_WIDTH + 3.0
    // rust: } else {
    // rust: 0.0
}
}

/// An interactive rectangle (GUI pixels) a controller can focus and click.
pub fn target(rect: [f32; 4]) void {
}
    // rust: target_as(rect, Kind::Button);
}

/// An interactive rectangle of a given kind.
pub fn target_as(rect: [f32; 4], kind: Kind) void {
}
    // rust: if !rect.iter().all(|v| v.is_finite()) || rect[2] <= 0.0 || rect[3] <= 0.0 {
    // rust: return;
}
    // rust: TARGETS.with_borrow_mut(|(current, _, _)| {
    // rust: if current.len() < 1024 {
    // rust: current.push(Target { rect, kind });
}
    // rust: });
}

/// How many targets the frame has so far, for [`clip_targets`].
pub fn targets_mark() u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: TARGETS.with_borrow(|(current, _, _)| current.len())
}

/// Drop the targets registered since `mark` that aren't inside `y0..y1`
/// (GUI pixels): rows a scrolling list clipped away.
pub fn clip_targets(mark: usize, y0: f32, y1: f32) void {
}
    // rust: TARGETS.with_borrow_mut(|(current, _, _)| {
    // rust: let mut i = mark.min(current.len());
    // rust: while i < current.len() {
    // rust: let [_, y, _, h] = current[i].rect;
    // rust: if y < y0 - 0.5 || y + h > y1 + 0.5 {
    // rust: current.remove(i);
    // rust: } else {
    // rust: i += 1;
}
}
    // rust: });
}

/// How many labelled widgets and targets the frame has so far, for [`clip_frame`].
pub fn frame_mark() ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let labelled = WIDGETS.with_borrow(|(current, _, _)| current.len());
    // rust: (labelled, targets_mark())
}

/// Drop the labelled widgets and targets since `mark` whose middle isn't in `y0..y1` (GUI pixels):
/// what a scrolling body clipped away, where a press wouldn't land.
pub fn clip_frame() void {
}
    // rust: let shown = |y: f32, h: f32| (y0..y1).contains(&(y + h / 2.0));
    // rust: WIDGETS.with_borrow_mut(|(current, _, _)| {
    // rust: let mut at = 0;
    // rust: current.retain(|w| {
    // rust: at += 1;
    // rust: at <= labelled || shown(w.y, w.h)
    // rust: });
    // rust: });
    // rust: TARGETS.with_borrow_mut(|(current, _, _)| {
    // rust: let mut at = 0;
    // rust: current.retain(|t| {
    // rust: at += 1;
    // rust: at <= targets || shown(t.rect[1], t.rect[3])
    // rust: });
    // rust: });
}

/// A prompt comes up over what the frame drew so far: what it covers can't be reached, by the
/// pointer or a controller, so its widgets, targets, declared buttons and lists go.
pub fn cover_frame() void {
}
    // rust: WIDGETS.with_borrow_mut(|(current, _, _)| current.clear());
    // rust: TARGETS.with_borrow_mut(|(current, _, _)| current.clear());
    // rust: ACTIONS.with_borrow_mut(|(current, _)| current.clear());
    // rust: SCROLL_AREAS.with_borrow_mut(|(current, _)| current.clear());
}

/// This frame drew a list with something to scroll, in `rect`, scrolled `amount`
/// of `max`: a focus step goes through its hidden rows before it leaves
/// (`gamepad::list_step`).
pub fn scroll_area(rect: [f32; 4], amount: f32, max: f32) void {
}
    // rust: let area = ScrollArea {
    // rust: rect,
    // rust: amount,
    // rust: up: amount > 0.5,
    // rust: down: amount < max - 0.5,
}
    // rust: SCROLL_AREAS.with_borrow_mut(|(current, _)| current.push(area));
}

/// The lists the last drawn frame could scroll.
pub fn last_scroll_areas() V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: SCROLL_AREAS.with_borrow(|(_, last)| last.clone())
}

/// A point the open screen's list scrolls under: `at` when it is over one, else
/// the same column at the list's middle. For the right stick, which scrolls the
/// list wherever the hidden pointer is.
pub fn over_scroll_area(at: (f32) void {
}
    // rust: SCROLL_AREAS.with_borrow(|(_, last)| {
    // rust: let over = |a: &ScrollArea| (a.rect[1]..a.rect[1] + a.rect[3]).contains(&at.1);
    // rust: match last.first() {
    // rust: Some(area) if !last.iter().any(over) => (at.0, area.rect[1] + area.rect[3] / 2.0),
    // rust: _ => at,
}
    // rust: })
}

/// The focus targets of the last drawn frame.
pub fn last_targets() V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: TARGETS.with_borrow(|(_, last, _)| last.clone())
}

/// Counts drawn frames: focus waits for a new one after scrolling a list.
pub fn generation() u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: TARGETS.with_borrow(|(_, _, generation)| *generation)
}

/// Called by the button drawers.
pub fn record(label: []const u8, rect: [f32; 4], enabled: bool) void {
}
    // rust: record_as(label, rect, enabled, Kind::Button);
}

/// The label of a widget of another kind (a slider's "FOV: 70", a tab).
pub fn record_as(label: []const u8, h]: [f32; 4], enabled: bool, kind: Kind) void {
}
    // rust: let label = label.trim();
    // rust: if label.is_empty() {
    // rust: return;
}
    // rust: WIDGETS.with_borrow_mut(|(current, _, _)| {
    // rust: if current.len() < 512 {
    // rust: current.push(Widget {
    // rust: label: label.to_owned(),
    // rust: x,
    // rust: y,
    // rust: w,
    // rust: h,
    // rust: enabled,
    // rust: kind,
    // rust: });
}
    // rust: });
}

    // rust: mod cursor_tests {
//     use super::*;

pub fn hovered_widgets_ask_for_the_hand_or_not_allowed() void {
}
    // rust: let _ = take_cursor();
    // rust: widget_cursor(false, true);
    // rust: assert_eq!(take_cursor(), Cursor::Arrow);
    // rust: widget_cursor(true, true);
    // rust: assert_eq!(take_cursor(), Cursor::PointingHand);
        // Taken: the next frame starts from the arrow.
    // rust: assert_eq!(take_cursor(), Cursor::Arrow);
    // rust: widget_cursor(true, false);
    // rust: assert_eq!(take_cursor(), Cursor::NotAllowed);
        // The last request of a frame wins.
    // rust: widget_cursor(true, false);
    // rust: widget_cursor(false, true);
    // rust: widget_cursor(true, true);
    // rust: assert_eq!(take_cursor(), Cursor::PointingHand);
}
}

/// Once per event loop turn with the count of rendered frames: when a new
/// frame was drawn since the last call, its buttons become the last frame's.
pub fn end_frame(frames: u64) void {
}
    // rust: WIDGETS.with_borrow_mut(|(current, last, seen)| {
    // rust: if *seen != frames {
    // rust: *seen = frames;
    // rust: *last = std::mem::take(current);
    // rust: TARGETS.with_borrow_mut(|(current, last, generation)| {
    // rust: *last = std::mem::take(current);
    // rust: *generation += 1;
    // rust: });
    // rust: ACTIONS.with_borrow_mut(|(current, last)| {
    // rust: *last = std::mem::take(current);
    // rust: });
    // rust: ACTION_SCREENS.set((ACTION_SCREENS.get().0, ACTION_SCREENS.get().0));
    // rust: SCROLL_AREAS.with_borrow_mut(|(current, last)| {
    // rust: *last = std::mem::take(current);
    // rust: });
    // rust: NARRATION.with_borrow_mut(|(current, last)| {
    // rust: *last = std::mem::replace(current, Narration::EMPTY);
    // rust: });
}
    // rust: });
}

/// The buttons of the last drawn frame, top-most last.
pub fn last() V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: WIDGETS.with_borrow(|(_, last, _)| {
    // rust: last.iter()
    // rust: .filter(|w| w.kind == Kind::Button)
    // rust: .cloned()
    // rust: .collect()
    // rust: })
}

/// Every labelled widget of the last drawn frame, sliders and tabs included.
pub fn last_labelled() V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: WIDGETS.with_borrow(|(_, last, _)| last.clone())
}

// Screen narration: what a frame's screen and widgets would narrate
// (`Screen.updateNarrationState` and each `NarratableEntry`), recorded by the
// drawers as they draw, for horizon-client's `screen_narrator` to read once the
// frame is done. Nothing is recorded (nor built: the record calls take
// closures) unless the narrator asked for it with `set_narrating`.

    // rust: pub use horizon_narrator::screen::ElementType;

/// The screen a frame drew, as `Screen` narrates it.
pub const ScreenInfo = struct {
    /// Which screen this is: a new id is a new `Screen` (narrated as it
    /// opens), the same id a screen still open.
    id: []const u8,
    /// `getNarrationMessage` (TITLE at depth 0): the title, or its
    /// override (`joinForNarration(title, message)` for confirm screens).
    /// Empty for `CommonComponents.EMPTY`, which is narrated all the same.
    title: []const u8,
    /// `shouldNarrateNavigation`: "Use mouse cursor or Tab button to select
    /// element" when no widget is narrated.
    navigation: bool,
    /// `updateNarratedWidget` runs (screens that override
    /// `updateNarrationState`, the chat, don't).
    widgets: bool,
    /// The screen's own elements beyond its title, at their depth (an
    /// element of the title's kind and depth replaces it, as
    /// `LevelLoadingScreen`'s progress does).
    extra: Vec<(ElementType,
    /// `getUsageNarration`, when the screen overrides it.
    usage: ?[]const u8,
    /// `triggerImmediateNarration(true)` every this many milliseconds
    /// (`LevelLoadingScreen`'s progress).
    repeat_ms: ?u32,
};

    // rust: impl ScreenInfo {
pub fn new(id: impl Into<[]const u8>, title: impl Into<[]const u8>) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: id: id.into(),
    // rust: title: title.into(),
    // rust: navigation: true,
    // rust: widgets: true,
    // rust: extra: Vec::new(),
    // rust: usage: None,
    // rust: repeat_ms: None,
}
}
    /// One more element of the screen's own.
pub fn element(self: *Self, kind: ElementType, depth: u32, text: impl Into<[]const u8>) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.lines(kind, depth, vec![text.into()])
}
    /// One more element of several lines, read as sentences.
pub fn lines(kind: ElementType, depth: u32, lines: std.ArrayList([]const u8)) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.extra.push((kind, depth, lines));
    // rust: self
}
pub fn without_widgets() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.widgets = false;
    // rust: self
}
pub fn without_navigation() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.navigation = false;
    // rust: self
}
pub fn usage(usage: impl Into<[]const u8>) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.usage = Some(usage.into());
    // rust: self
}
pub fn repeat_every(ms: u32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.repeat_ms = Some(ms);
    // rust: self
}
}

/// What a list narrates its rows as.
pub const ListKind = enum {
    /// `ObjectSelectionList`: "Selected list row i out of n", the row's
    /// narration, and the selection's usage when focused.
    Object,
    /// `TabNavigationBar`: "Selected tab i out of n", "<title> tab", and
    /// the tab navigation's usage when focused.
    Tabs,
};

/// A row of an `ObjectSelectionList` (its `getNarration`) or a tab (its
/// title and `getTabExtraNarration`).
pub const Row = struct {
    index: usize,
    narration: []const u8,
    hint: ?[]const u8,
};

    // rust: impl Row {
pub fn new(index: usize, narration: impl Into<[]const u8>) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: index,
    // rust: narration: narration.into(),
    // rust: hint: None,
}
}
}

/// A narratable widget's kind and what its narration reads.
pub const What = enum {
    /// `Button`: "<message> button".
    Button { message: String, active: bool },
    /// A button whose `createNarrationMessage` is its own (TITLE as is), with
    /// a button's usage.
    Named { title: String, active: bool },
    /// `AbstractSliderButton`: "<message> slider".
    Slider { message: String, active: bool },
    /// `CycleButton`: "<message> button" and the value a click moves to.
    Cycle {,
    message: String,
    next: String,
    active: bool,
    // rust: },
    /// A `CycleButton` with its own narration (`withCustomNarration`):
    /// `title` as is, and the value a click moves to.
    NamedCycle {,
    title: String,
    next: String,
    active: bool,
    // rust: },
    /// `Checkbox`: "<message> button" and whether a click checks it.
    Checkbox {,
    message: String,
    selected: bool,
    active: bool,
    // rust: },
    /// `EditBox`: "<message> edit box: <value>"; an inactive one (a box
    /// that can't be edited now) isn't narrated.
    EditBox {,
    message: String,
    value: String,
    active: bool,
    // rust: },
    /// A text widget that narrates its message and nothing else
    /// (`FittingMultiLineTextWidget`, a list's `FocusableTextWidget` header).
    Text { message: String },
    /// An `ObjectSelectionList` or a `TabNavigationBar`: `total` rows, the one
    /// under the mouse and the selected one.
    List {,
    kind: ListKind,
    total: usize,
    hovered: Option<Row>,
    selected: Option<Row>,
    // rust: },
    /// A `ContainerObjectSelectionList` of `rows` rows (options, key binds):
    /// its rows' widgets are the narratables recorded with it as their
    /// parent. `hovered_row` is the row under the mouse.
    ContainerList {,
    rows: usize,
    hovered_row: Option<usize>,
    // rust: },
    /// `RecipeButton`: "Recipe for <item>".
    Recipe { item: String, more: bool },
    /// `RecipeBookComponent`: one narratable, HOVERED whenever `visible`
    /// (whatever the mouse and the focus), that narrates the widget
    /// `findNarratableWidget` picks among its own one level in, with no
    /// position of its own. Its widgets are the narratables recorded with it
    /// as their parent (row 0).
    Group { visible: bool },
};

/// A `NarratableEntry` as drawn this frame.
pub const Narratable = struct {
    /// The widget's identity across frames (`lastNarratable`); 0 derives
    /// one from its kind and place. A list's children need stable keys.
    key: u64,
    /// GUI pixels.
    rect: [f32,
    /// `isHovered`, as the drawer saw it; `None` tests the mouse against
    /// `rect`.
    hovered: ?bool,
    /// `isFocused` (a text field with the caret, a focused list).
    focused: bool,
    what: What,
    /// Its tooltip's narration (HINT); empty for none. Without one, the
    /// tooltip drawn this frame is the hovered widget's.
    hint: ?[]const u8,
    /// A row widget of a `ContainerList`: that list's key and the row.
    parent: Option<(u64,
    /// `getTabOrderGroup`: narratables are numbered in this order, then in
    /// the order they were drawn.
    order: i32,
};

    // rust: impl Narratable {
pub fn new(what: What, rect: [f32; 4]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: key: 0,
    // rust: rect,
    // rust: hovered: None,
    // rust: focused: false,
    // rust: what,
    // rust: hint: None,
    // rust: parent: None,
    // rust: order: 0,
}
}
pub fn button(message: impl Into<[]const u8>, rect: [f32; 4], active: bool) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::new(
    // rust: What::Button {
    // rust: message: message.into(),
    // rust: active,
    // rust: },
    // rust: rect,
    // rust: )
}
pub fn slider(message: impl Into<[]const u8>, rect: [f32; 4], active: bool) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::new(
    // rust: What::Slider {
    // rust: message: message.into(),
    // rust: active,
    // rust: },
    // rust: rect,
    // rust: )
}
pub fn edit_box(message: impl Into<[]const u8>, value: impl Into<[]const u8>, rect: [f32; 4]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::new(
    // rust: What::EditBox {
    // rust: message: message.into(),
    // rust: value: value.into(),
    // rust: active: true,
    // rust: },
    // rust: rect,
    // rust: )
}
    /// A button narrated by its own `createNarrationMessage`.
pub fn named(title: impl Into<[]const u8>, rect: [f32; 4], active: bool) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::new(
    // rust: What::Named {
    // rust: title: title.into(),
    // rust: active,
    // rust: },
    // rust: rect,
    // rust: )
}
    /// A `CycleButton` showing `message`; a click moves it to `next`.
    // rust: pub fn cycle(
    // rust: message: impl Into<String>,
    // rust: next: impl Into<String>,
    // rust: rect: [f32; 4],
    // rust: active: bool,
    // rust: ) -> Self {
    // rust: Self::new(
    // rust: What::Cycle {
    // rust: message: message.into(),
    // rust: next: next.into(),
    // rust: active,
    // rust: },
    // rust: rect,
    // rust: )
}
    // rust: pub fn checkbox(
    // rust: message: impl Into<String>,
    // rust: selected: bool,
    // rust: rect: [f32; 4],
    // rust: active: bool,
    // rust: ) -> Self {
    // rust: Self::new(
    // rust: What::Checkbox {
    // rust: message: message.into(),
    // rust: selected,
    // rust: active,
    // rust: },
    // rust: rect,
    // rust: )
}
pub fn text(message: impl Into<[]const u8>, rect: [f32; 4]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::new(
    // rust: What::Text {
    // rust: message: message.into(),
    // rust: },
    // rust: rect,
    // rust: )
}
    /// An `ObjectSelectionList` (or tabs) of `total` rows over `rect`.
    // rust: pub fn list(
    // rust: kind: ListKind,
    // rust: total: usize,
    // rust: hovered: Option<Row>,
    // rust: selected: Option<Row>,
    // rust: rect: [f32; 4],
    // rust: ) -> Self {
    // rust: Self::new(
    // rust: What::List {
    // rust: kind,
    // rust: total,
    // rust: hovered,
    // rust: selected,
    // rust: },
    // rust: rect,
    // rust: )
}
    /// A `ContainerObjectSelectionList` of `rows` rows over `rect`.
pub fn container_list(rows: usize, hovered_row: ?usize, rect: [f32; 4]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::new(What::ContainerList { rows, hovered_row }, rect)
}
    /// A `RecipeBookComponent`-like group over `rect`, narrated while
    /// `visible`; its widgets are recorded with [`Self::in_group`].
pub fn group(visible: bool, rect: [f32; 4]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::new(What::Group { visible }, rect)
}
    /// `RecipeButton`: the recipe's result `item`, and whether it has more
    /// recipes than one.
pub fn recipe(item: impl Into<[]const u8>, more: bool, rect: [f32; 4]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::new(
    // rust: What::Recipe {
    // rust: item: item.into(),
    // rust: more,
    // rust: },
    // rust: rect,
    // rust: )
}
pub fn key(key: u64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.key = key;
    // rust: self
}
pub fn hovered(hovered: bool) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.hovered = Some(hovered);
    // rust: self
}
pub fn focused(focused: bool) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.focused = focused;
    // rust: self
}
pub fn hint(hint: impl Into<[]const u8>) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.hint = Some(hint.into());
    // rust: self
}
    /// No HINT, whatever tooltip the frame draws: the tooltip isn't the
    /// widget's (a list's row tooltip, drawn by the list).
pub fn without_tooltip(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.hint("")
}
    /// A widget of row `row` of the `ContainerList` keyed `list`.
pub fn child_of(list: u64, row: usize) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.parent = Some((list, row));
    // rust: self
}
    /// A widget of the [`What::Group`] keyed `group`.
pub fn in_group(self: *Self, group: u64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.child_of(group, 0)
}
pub fn order(order: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.order = order;
    // rust: self
}
    /// `isActive`: visible and active. Inactive buttons and sliders are left
    /// out of a screen's narratables.
pub fn is_active(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match &self.what {
    // rust: What::Button { active, .. }
    // rust: | What::Named { active, .. }
    // rust: | What::Slider { active, .. }
    // rust: | What::Cycle { active, .. }
    // rust: | What::NamedCycle { active, .. }
    // rust: | What::Checkbox { active, .. }
    // rust: | What::EditBox { active, .. } => *active,
    // rust: What::Text { .. }
    // rust: | What::List { .. }
    // rust: | What::ContainerList { .. }
    // rust: | What::Recipe { .. }
    // rust: | What::Group { .. } => true,
}
}
    /// `key`, or one from the widget's kind and place (never 0).
pub fn identity(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.key != 0 {
    // rust: return self.key;
}
    // rust: let place = self.rect.map(|v| v.round() as i32);
    // rust: key_of(&(std::mem::discriminant(&self.what), place))
}
}

/// A stable key for a widget from anything that names it (a list's name, an
/// option's id), never 0.
pub fn key_of(name: *impl std::hash::Hash) u {
    // Implementation ported from Horizon
    return undefined;
}
//     use std::hash::Hasher;
    // rust: let mut hasher = std::collections::hash_map::DefaultHasher::new();
    // rust: name.hash(&mut hasher);
    // rust: hasher.finish() | 1
}

/// `CommonComponents.joinForNarration`: the parts, ". " between them.
pub fn join_for_narration(parts: *[[]const u8]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: parts.join(". ")
}

/// A frame's narration records.
pub const Narration = struct {
    screen: ?ScreenInfo,
    items: std.ArrayList(Narratable),
    /// The tooltip drawn this frame, its lines joined.
    tooltip: ?[]const u8,
};

    // rust: impl Narration {
    // rust: const EMPTY: Narration = Narration {
    // rust: screen: None,
    // rust: items: Vec::new(),
    // rust: tooltip: None,
}
}

    // rust: thread_local! {
    /// The narrator wants the frames' narration (`Screen.shouldRunNarration`).
pub const NARRATING: Cell<bool> = const { Cell::new(false) };
    /// Narration recorded since the last `end_frame`, and the last frame's.
    // rust: static NARRATION: RefCell<(Narration, Narration)> =
    // rust: const { RefCell::new((Narration::EMPTY, Narration::EMPTY)) };
    /// A screen asked for `triggerImmediateNarration(true)`.
pub const NARRATE_NOW: Cell<bool> = const { Cell::new(false) };
    /// Where the narrator's focused widget was last drawn.
pub const FOCUS: Cell<?[f32; 4]> = const { Cell::new(None) };
}

/// The narrator tells the drawers where its focused widget is (a click's
/// or the controller's), so what only a hovered or focused widget narrates
/// (a cycle button's next value) is worked out for it alone.
pub fn set_narration_focus(rect: ?[f32; 4]) void {
}
    // rust: FOCUS.set(rect);
}

/// Whether the widget at `rect` has the narrator's focus.
pub fn narration_focused(rect: [f32; 4]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: FOCUS
    // rust: .get()
    // rust: .is_some_and(|f| f.iter().zip(rect).all(|(a, b)| (a - b).abs() < 0.5))
}

/// Whether the frames record their narration; the narrator switches it.
pub fn set_narrating(on: bool) void {
}
    // rust: NARRATING.set(on);
    // rust: if !on {
    // rust: NARRATION.with_borrow_mut(|(current, _)| *current = Narration::EMPTY);
}
}

pub fn narrating() b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: NARRATING.get()
}

/// The screen being drawn: what it narrates and which one it is. The
/// narratables recorded before it in the frame are dropped: the last screen
/// drawn (an overlay over the screen under it) is the one narrated. So are the
/// jobs declared before it: a popup's buried buttons can't be pressed.
pub fn begin_screen(info: impl FnOnce() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ACTIONS.with_borrow_mut(|(current, _)| current.clear());
    // rust: if NARRATING.get() {
    // rust: NARRATION.with_borrow_mut(|(current, _)| {
    // rust: current.screen = Some(info());
    // rust: current.items.clear();
    // rust: current.tooltip = None;
    // rust: });
}
}

/// Changes the screen begun this frame, if one was.
pub fn screen_mut(f: impl FnOnce(*mut ScreenInfo) void {
}
    // rust: if NARRATING.get() {
    // rust: NARRATION.with_borrow_mut(|(current, _)| {
    // rust: if let Some(screen) = &mut current.screen {
    // rust: f(screen);
}
    // rust: });
}
}

/// A narratable widget of the screen begun this frame (nothing without one).
pub fn narratable(narratable: impl FnOnce() N {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if NARRATING.get() {
    // rust: NARRATION.with_borrow_mut(|(current, _)| {
    // rust: if current.screen.is_some() && current.items.len() < 512 {
    // rust: current.items.push(narratable());
}
    // rust: });
}
}

/// Changes the narratable recorded last this frame (one a shared drawer
/// recorded: an edit box's message, a button's key or row).
pub fn last_narratable(f: impl FnOnce(*mut Narratable) void {
}
    // rust: if NARRATING.get() {
    // rust: NARRATION.with_borrow_mut(|(current, _)| {
    // rust: if let Some(last) = current.items.last_mut() {
    // rust: f(last);
}
    // rust: });
}
}

/// Changes the narratable recorded last this frame and moves it to `index`
/// among the screen's: a widget the screen adds before others it draws first.
pub fn last_narratable_at(index: usize, f: impl FnOnce(*mut Narratable) void {
}
    // rust: if NARRATING.get() {
    // rust: NARRATION.with_borrow_mut(|(current, _)| {
    // rust: if let Some(mut last) = current.items.pop() {
    // rust: f(&mut last);
    // rust: let index = index.min(current.items.len());
    // rust: current.items.insert(index, last);
}
    // rust: });
}
}

/// How many narratables the frame has so far, for [`move_narratables`].
pub fn narratables_mark() u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !NARRATING.get() {
    // rust: return 0;
}
    // rust: NARRATION.with_borrow(|(current, _)| current.items.len())
}

/// Moves the narratables recorded since `mark` to `index`, in their order:
/// widgets a screen adds before others it draws first.
pub fn move_narratables(mark: usize, index: usize) void {
}
    // rust: if NARRATING.get() {
    // rust: NARRATION.with_borrow_mut(|(current, _)| {
    // rust: let items = &mut current.items;
    // rust: let mark = mark.min(items.len());
    // rust: let index = index.min(mark);
    // rust: let moved = items.len() - mark;
    // rust: items[index..].rotate_right(moved);
    // rust: });
}
}

/// Names the edit box recorded last, which a shared drawer recorded without
/// its `getMessage`.
pub fn name_last_edit_box(name: impl FnOnce() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: last_narratable(|n| {
    // rust: if let What::EditBox { message, .. } = &mut n.what {
    // rust: *message = name();
}
    // rust: });
}

/// The tooltip drawn this frame: the hovered widget's narration hint.
pub fn frame_tooltip(lines: *[crate::text::Text]) void {
}
    // rust: if NARRATING.get() {
    // rust: NARRATION.with_borrow_mut(|(current, _)| {
    // rust: let text: Vec<String> = lines.iter().map(|l| l.plain()).collect();
    // rust: current.tooltip = Some(text.join(" "));
    // rust: });
}
}

/// `triggerImmediateNarration(true)`: narrate what changed at once.
pub fn narrate_now() void {
}
    // rust: if NARRATING.get() {
    // rust: NARRATE_NOW.set(true);
}
}

/// Whether a screen asked to narrate at once since the last call.
pub fn take_narrate_now() b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: NARRATE_NOW.replace(false)
}

/// The last drawn frame's narration, taken (the narrator is its only reader).
pub fn take_last_narration() N {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: NARRATION.with_borrow_mut(|(_, last)| std::mem::replace(last, Narration::EMPTY))
}

    // rust: mod narration_tests {
//     use super::*;

pub fn frame(n: u64) N {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: end_frame(n);
    // rust: take_last_narration()
}

pub fn nothing_is_recorded_or_built_unless_narrating() void {
}
    // rust: set_narrating(false);
    // rust: let _ = frame(1000);
    // rust: begin_screen(|| unreachable!("not built while the narrator is off"));
    // rust: narratable(|| unreachable!());
    // rust: narrate_now();
    // rust: let last = frame(1001);
    // rust: assert!(last.screen.is_none() && last.items.is_empty());
    // rust: assert!(!take_narrate_now());
}

pub fn a_frame_keeps_the_last_screen_begun_and_its_widgets() void {
}
    // rust: set_narrating(true);
    // rust: let _ = frame(2000);
        // Without a screen, widgets aren't kept.
    // rust: narratable(|| Narratable::button("Stray", [0.0; 4], true));
    // rust: begin_screen(|| ScreenInfo::new("pause", "Game Menu"));
    // rust: narratable(|| Narratable::button("Back to Game", [0.0, 0.0, 200.0, 20.0], true));
    // rust: frame_tooltip(&[crate::text::Text::literal("Under")]);
        // An overlay over the pause menu: its own screen and widgets.
    // rust: begin_screen(|| ScreenInfo::new("confirm", "Sure?"));
    // rust: narratable(|| Narratable::button("Yes", [0.0, 30.0, 100.0, 20.0], true));
    // rust: screen_mut(|s| s.title.push('!'));
    // rust: frame_tooltip(&[
    // rust: crate::text::Text::literal("Two"),
    // rust: crate::text::Text::literal("lines"),
    // rust: ]);
    // rust: let last = frame(2001);
    // rust: assert_eq!(last.screen.unwrap().title, "Sure?!");
    // rust: assert_eq!(last.items.len(), 1);
    // rust: assert_eq!(
    // rust: last.items[0].what,
    // rust: What::Button {
    // rust: message: "Yes".into(),
    // rust: active: true
}
    // rust: );
    // rust: assert_eq!(last.tooltip.as_deref(), Some("Two lines"));
        // Taken: read once.
    // rust: assert!(take_last_narration().screen.is_none());
        // A frame not drawn doesn't rotate.
    // rust: begin_screen(|| ScreenInfo::new("title", ""));
    // rust: assert!(frame(2001).screen.is_none());
    // rust: assert_eq!(frame(2002).screen.unwrap().id, "title");
        // Switching off drops what was recorded.
    // rust: begin_screen(|| ScreenInfo::new("title", ""));
    // rust: set_narrating(false);
    // rust: assert!(frame(2003).screen.is_none());
}

pub fn the_last_widget_recorded_can_be_named_after_the_fact() void {
}
    // rust: set_narrating(true);
    // rust: let _ = frame(3000);
    // rust: begin_screen(|| ScreenInfo::new("select_world", "Select World"));
        // A shared drawer records the box without its message.
    // rust: narratable(|| Narratable::edit_box("", "abc", [0.0; 4]));
    // rust: last_narratable(|n| {
    // rust: if let What::EditBox { message, .. } = &mut n.what {
    // rust: *message = "Search for worlds".into();
}
    // rust: n.order = -1;
    // rust: });
    // rust: let last = frame(3001);
    // rust: assert_eq!(
    // rust: last.items[0].what,
    // rust: What::EditBox {
    // rust: message: "Search for worlds".into(),
    // rust: value: "abc".into(),
    // rust: active: true,
}
    // rust: );
    // rust: assert_eq!(last.items[0].order, -1);
    // rust: set_narrating(false);
    // rust: last_narratable(|_| unreachable!("nothing recorded while off"));
}

pub fn widgets_drawn_late_can_be_moved_to_where_they_were_added() void {
}
    // rust: set_narrating(true);
    // rust: let _ = frame(4000);
    // rust: begin_screen(|| ScreenInfo::new("command_block", ""));
    // rust: narratable(|| Narratable::button("Done", [0.0; 4], true));
    // rust: narratable(|| Narratable::button("Cancel", [0.0; 4], true));
    // rust: let mark = narratables_mark();
    // rust: narratable(|| Narratable::edit_box("Command", "", [0.0; 4]));
    // rust: narratable(|| Narratable::button("Late", [0.0; 4], true));
    // rust: move_narratables(mark, 0);
    // rust: let order: Vec<String> = frame(4001)
    // rust: .items
    // rust: .iter()
    // rust: .map(|n| match &n.what {
    // rust: What::Button { message, .. } | What::EditBox { message, .. } => message.clone(),
    // rust: _ => String::new(),
    // rust: })
    // rust: .collect();
    // rust: assert_eq!(order, ["Command", "Late", "Done", "Cancel"]);
    // rust: set_narrating(false);
    // rust: assert_eq!(narratables_mark(), 0);
}

pub fn widgets_know_who_they_are_and_whether_they_are_narrated() void {
}
    // rust: let a = Narratable::button("A", [10.0, 20.0, 200.0, 20.0], true);
    // rust: let moved = Narratable::button("A", [10.0, 44.0, 200.0, 20.0], true);
    // rust: let slider = Narratable::slider("A", [10.0, 20.0, 200.0, 20.0], true);
    // rust: assert_eq!(
    // rust: a.identity(),
    // rust: Narratable::button("B", a.rect, false).identity()
    // rust: );
    // rust: assert_ne!(a.identity(), moved.identity());
    // rust: assert_ne!(a.identity(), slider.identity());
    // rust: assert_eq!(a.clone().key(7).identity(), 7);
    // rust: assert_ne!(key_of(&"options"), 0);
    // rust: assert!(a.is_active());
    // rust: assert!(!Narratable::button("B", a.rect, false).is_active());
    // rust: assert!(Narratable::edit_box("Search", "", a.rect).is_active());
    // rust: let mut port = Narratable::edit_box("Port", "", a.rect);
    // rust: if let What::EditBox { active, .. } = &mut port.what {
    // rust: *active = false;
}
    // rust: assert!(!port.is_active());
    // rust: assert!(Narratable::group(false, a.rect).is_active());
    // rust: let recipe = Narratable::recipe("Torch", true, a.rect).in_group(9);
    // rust: assert_eq!(recipe.parent, Some((9, 0)));
    // rust: assert_eq!(join_for_narration(&["Title", "Message"]), "Title. Message");
}
}

    // rust: impl Kind {
    /// The kind's name in the control socket's `ui` reply.
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Kind::Button => "button",
    // rust: Kind::Slider { .. } => "slider",
    // rust: Kind::Field => "field",
    // rust: Kind::Row => "row",
    // rust: Kind::Slot => "slot",
    // rust: Kind::Tab(_) => "tab",
}
}
}

/// A widget of the `ui` tree: a labelled widget and its focus target merged.
pub const Node = struct {
    /// The label as a slug up to its `:` (`FOV: 70` is `fov`), `-2`, `-3`
    /// for repeats; `<kind>-<n>` in draw order without a label.
    id: []const u8,
    kind: Kind,
    label: ?[]const u8,
    rect: [f32,
    enabled: bool,
};

/// `Video Settings...` → `video-settings`, `FOV: 70` → `fov`.
pub fn slug(label: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = label.split(':').next().unwrap_or(label);
    // rust: let mut out = String::new();
    // rust: for c in name.chars().flat_map(char::to_lowercase) {
    // rust: if c.is_alphanumeric() {
    // rust: out.push(c);
    // rust: } else if !out.is_empty() && !out.ends_with('-') {
    // rust: out.push('-');
}
}
    // rust: out.trim_end_matches('-').to_owned()
}

/// The labelled widgets and the focus targets of a frame as one list with
/// ids: a target drawn at a labelled widget's rectangle is that widget
/// (its kind wins, a slider's value, unless the label says it's a tab:
/// Horizon's segments); other targets follow, unlabelled. With the GUI
/// size, what lies off screen (layout probes) is left out before naming.
pub fn tree(widgets: *[Widget], targets: *[Target], screen: ?[f32; 2]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let same = |a: [f32; 4], b: [f32; 4]| a.iter().zip(b).all(|(p, q)| (p - q).abs() < 0.5);
    // rust: let mut nodes: Vec<Node> = widgets
    // rust: .iter()
    // rust: .map(|w| Node {
    // rust: id: String::new(),
    // rust: kind: w.kind,
    // rust: label: Some(w.label.clone()),
    // rust: rect: [w.x, w.y, w.w, w.h],
    // rust: enabled: w.enabled,
    // rust: })
    // rust: .collect();
    // rust: for t in targets {
    // rust: if let Some(node) = nodes.iter_mut().find(|n| same(n.rect, t.rect)) {
    // rust: if !matches!(node.kind, Kind::Tab(_)) {
    // rust: node.kind = t.kind;
}
    // rust: } else {
    // rust: nodes.push(Node {
    // rust: id: String::new(),
    // rust: kind: t.kind,
    // rust: label: None,
    // rust: rect: t.rect,
    // rust: enabled: true,
    // rust: });
}
}
    // rust: if let Some([w, h]) = screen {
    // rust: nodes.retain(|n| {
    // rust: let [x, y, nw, nh] = n.rect;
    // rust: x >= -0.5 && y >= -0.5 && x + nw <= w + 0.5 && y + nh <= h + 0.5
    // rust: });
}
    // rust: let mut seen = std::collections::HashMap::<String, usize>::new();
    // rust: for node in &mut nodes {
    // rust: let base = node
    // rust: .label
    // rust: .as_deref()
    // rust: .map(slug)
    // rust: .filter(|s| !s.is_empty())
    // rust: .unwrap_or_else(|| node.kind.name().to_owned());
    // rust: let n = seen.entry(base.clone()).or_default();
    // rust: *n += 1;
    // rust: node.id = if node.label.is_none() {
    // rust: format!("{base}-{}", *n - 1)
    // rust: } else if *n > 1 {
    // rust: format!("{base}-{n}")
    // rust: } else {
    // rust: base
}
}
    // rust: nodes
}

/// The button `label` names: an exact match (case-insensitive), else the only
/// button whose label contains it. The top-most wins among equals.
pub fn find(widgets: *[Widget], label: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let want = label.trim().to_lowercase();
    // rust: let exact: Vec<&Widget> = widgets
    // rust: .iter()
    // rust: .filter(|w| w.label.to_lowercase() == want)
    // rust: .collect();
    // rust: if let Some(w) = exact.last() {
    // rust: return Ok((*w).clone());
}
    // rust: let partial: Vec<&Widget> = widgets
    // rust: .iter()
    // rust: .filter(|w| w.label.to_lowercase().contains(&want))
    // rust: .collect();
    // rust: match partial.as_slice() {
    // rust: [w] => Ok((*w).clone()),
    // rust: [] => Err(format!(
    // rust: "no button labelled {label:?}; buttons: {:?}",
    // rust: widgets.iter().map(|w| w.label.as_str()).collect::<Vec<_>>()
    // rust: )),
    // rust: many => Err(format!(
    // rust: "{label:?} matches several buttons: {:?}",
    // rust: many.iter().map(|w| w.label.as_str()).collect::<Vec<_>>()
    // rust: )),
}
}

    // rust: mod tests {
//     use super::*;

pub fn w(label: []const u8) W {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Widget {
    // rust: label: label.into(),
    // rust: x: 0.0,
    // rust: y: 0.0,
    // rust: w: 10.0,
    // rust: h: 10.0,
    // rust: enabled: true,
    // rust: kind: Kind::Button,
}
}

pub fn finds_exact_then_unique_partial() void {
}
    // rust: let list = [w("Play Selected World"), w("Create New World"), w("Back")];
    // rust: assert_eq!(find(&list, "back").unwrap().label, "Back");
    // rust: assert_eq!(find(&list, "create").unwrap().label, "Create New World");
    // rust: assert!(find(&list, "world").is_err());
    // rust: assert!(find(&list, "options").is_err());
}

pub fn tree_merges_labels_with_targets_and_names_them() void {
}
    // rust: let slider = Kind::Slider {
    // rust: value: 0.25,
    // rust: track: [4.0, 142.0],
}
    // rust: let mut fov = w("FOV: 70");
    // rust: fov.kind = slider;
    // rust: let mut done = w("Done");
    // rust: done.y = 30.0;
    // rust: let mut done2 = w("Done");
    // rust: done2.y = 60.0;
    // rust: let widgets = [fov, w("Video Settings..."), done, done2];
    // rust: let targets = [
    // rust: Target {
    // rust: rect: [0.0, 0.0, 10.0, 10.0],
    // rust: kind: slider,
    // rust: },
    // rust: Target {
    // rust: rect: [0.0, 90.0, 10.0, 10.0],
    // rust: kind: Kind::Row,
    // rust: },
    // rust: Target {
    // rust: rect: [0.0, 100.0, 10.0, 10.0],
    // rust: kind: Kind::Row,
    // rust: },
    // rust: ];
    // rust: let mut probe = w("Done");
    // rust: probe.x = -10_000.0;
    // rust: let widgets = [&[probe][..], &widgets].concat();
    // rust: let nodes = tree(&widgets, &targets, Some([400.0, 200.0]));
    // rust: let ids: Vec<&str> = nodes.iter().map(|n| n.id.as_str()).collect();
    // rust: assert_eq!(
    // rust: ids,
    // rust: ["fov", "video-settings", "done", "done-2", "row-0", "row-1"]
    // rust: );
    // rust: assert_eq!(nodes[0].kind, slider, "the target's kind carries the value");
    // rust: assert_eq!(nodes[4].label, None);
    // rust: assert_eq!(slug("Music & Sounds..."), "music-sounds");
    // rust: assert_eq!(slug("Difficulty: Normal"), "difficulty");
    // rust: assert_eq!(slug("Économie"), "économie");
}

pub fn declared_buttons_are_only_those_of_the_screen_drawn() void {
}
    // rust: let done = |x| declare_action(Action::Done, [x, 0.0, 5.0, 5.0], true);
    // rust: done(0.0);
    // rust: set_action_screen(7);
    // rust: end_frame(200);
    // rust: assert_eq!(last_actions(7).len(), 1);
        // Another screen opened and hasn't been drawn yet.
    // rust: assert!(last_actions(8).is_empty());
}

pub fn a_popup_drops_the_buttons_declared_under_it() void {
}
    // rust: declare_action(Action::Done, [0.0, 0.0, 5.0, 5.0], true);
    // rust: begin_screen(|| ScreenInfo::new("popup", ""));
    // rust: declare_action(Action::Cancel, [9.0, 0.0, 5.0, 5.0], true);
    // rust: set_action_screen(7);
    // rust: end_frame(300);
    // rust: let actions = last_actions(7);
    // rust: assert_eq!(actions.len(), 1);
    // rust: assert_eq!(actions[0].action, Action::Cancel);
}

pub fn last_lists_buttons_only() void {
}
    // rust: end_frame(100);
    // rust: record("Back", [0.0, 0.0, 5.0, 5.0], true);
    // rust: record_as("FOV: 70", [0.0, 9.0, 5.0, 5.0], true, Kind::Tab(true));
    // rust: end_frame(101);
    // rust: assert_eq!(last().len(), 1);
    // rust: assert_eq!(last_labelled().len(), 2);
}

pub fn frames_rotate_only_when_drawn() void {
}
    // rust: record("Respawn", [1.0, 2.0, 3.0, 4.0], true);
    // rust: target_as(
    // rust: [1.0, 2.0, 3.0, 4.0],
    // rust: Kind::Slider {
    // rust: value: 0.5,
    // rust: track: [1.0, 3.0],
    // rust: },
    // rust: );
    // rust: target_as([1.0, 2.0, 0.0, 4.0], Kind::Row);
    // rust: let before = generation();
    // rust: end_frame(1);
    // rust: assert_eq!(last().len(), 1);
    // rust: assert_eq!(last_targets().len(), 1, "an empty rectangle isn't a target");
    // rust: assert!(matches!(last_targets()[0].kind, Kind::Slider { value, .. } if value == 0.5));
    // rust: assert_eq!(last_targets()[0].center(), (2.5, 4.0));
    // rust: end_frame(1);
    // rust: assert_eq!(last().len(), 1);
    // rust: assert_eq!(generation(), before + 1);
    // rust: end_frame(2);
    // rust: assert!(last().is_empty() && last_targets().is_empty());
    // rust: target([0.0, 0.0, 5.0, 5.0]);
    // rust: let mark = targets_mark();
    // rust: target([0.0, 10.0, 5.0, 5.0]);
    // rust: target([0.0, 40.0, 5.0, 5.0]);
    // rust: clip_targets(mark, 8.0, 30.0);
    // rust: end_frame(3);
    // rust: assert_eq!(
    // rust: last_targets().len(),
    // rust: 2,
    // rust: "the clipped row is gone, earlier ones stay"
    // rust: );
}

pub fn a_scrolled_body_loses_what_it_clips_and_nothing_before_it() void {
}
    // rust: let _ = take();
    // rust: target([0.0, 0.0, 5.0, 5.0]);
    // rust: record("warning", [0.0, 0.0, 5.0, 5.0], true);
    // rust: let mark = frame_mark();
    // rust: record("shown", [0.0, 10.0, 5.0, 10.0], true);
    // rust: target([0.0, 10.0, 5.0, 10.0]);
        // Half in view is still pressed at its middle, which a mouse could reach.
    // rust: record("half", [0.0, 25.0, 5.0, 10.0], true);
    // rust: target([0.0, 25.0, 5.0, 10.0]);
    // rust: record("gone", [0.0, 40.0, 5.0, 10.0], true);
    // rust: target([0.0, 40.0, 5.0, 10.0]);
    // rust: clip_frame(mark, 8.0, 32.0);
    // rust: end_frame(101);
    // rust: let names: Vec<String> = last_labelled().into_iter().map(|w| w.label).collect();
    // rust: assert_eq!(names, ["warning", "shown", "half"]);
    // rust: assert_eq!(last_targets().len(), 3);
}

pub fn a_prompt_covers_what_was_drawn_before_it() void {
}
    // rust: let _ = take();
    // rust: record("under", [0.0, 0.0, 5.0, 5.0], true);
    // rust: target([0.0, 10.0, 5.0, 5.0]);
    // rust: declare_action(Action::Done, [0.0, 0.0, 5.0, 5.0], true);
    // rust: scroll_area([0.0, 0.0, 5.0, 5.0], 0.0, 5.0);
    // rust: cover_frame();
    // rust: record("over", [0.0, 20.0, 5.0, 5.0], true);
    // rust: set_action_screen(7);
    // rust: end_frame(102);
    // rust: let names: Vec<String> = last_labelled().into_iter().map(|w| w.label).collect();
    // rust: assert_eq!(names, ["over"]);
    // rust: assert!(last_targets().is_empty());
    // rust: assert!(last_actions(7).is_empty());
    // rust: assert!(last_scroll_areas().is_empty());
}
}
