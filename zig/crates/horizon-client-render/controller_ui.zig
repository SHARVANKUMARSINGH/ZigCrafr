//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_controller_ui
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Horizon's controller settings screen: the frame of the graphics settings (`settings_shell`)
//! over one player's `PadSettings`, which that player's options hold. It says whose settings they
//! are and what device the game sees; which controller drives which player stays the splitscreen
//! router's.
// use crate::widgets::Action as Declared;
// use crate::{
    // rust: gamepad::{self, Button, GlyphStyle, PadSettings},
    // rust: graphics_style as style,
    // rust: hud::{HudAtlas, HudBatch},
    // rust: lang,
    // rust: settings::{Opt, Settings},
    // rust: settings_shell::{self as shell, Columns},
    // rust: text::Text,
    // rust: ui,
}

/// The screen's pages, in its order. A page is a variant here, its words below and its groups in
/// `rows`; nothing else names them.
pub const Page = enum {
    General,
    Bindings,
    Device,
};
    // rust: impl Page {
pub const ALL: [Page; 3] = [Page::General, Page::Bindings, Page::Device];
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Page::General => "General",
    // rust: Page::Bindings => "Bindings",
    // rust: Page::Device => "Device",
}
}
    /// What the page holds, in the strip while no setting is pointed at.
pub fn about(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Page::General => "How the sticks turn and move you, and how menus repeat and scroll.",
    // rust: Page::Bindings => "Which button does what. Each player has their own.",
    // rust: Page::Device => "The controller the game sees, its button glyphs and its feedback.",
}
}
}

/// A line of what the game knows, for reading rather than changing.
pub const Info = enum {
    Player,
    Device,
    Ids,
    Detected,
    Using,
};

pub const Item = enum {
    Option(Opt),
    /// Wait for a button to bind to this action.
    Bind(&'static str),
    ResetBinds,
    Info(Info),
};

pub const Setting = struct {
    item: Item,
    text: *'static str,
};
pub fn option(opt: Opt, text: *'static str) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Setting {
    // rust: item: Item::Option(opt),
    // rust: text,
}
}
pub fn info(info: Info, text: *'static str) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Setting {
    // rust: item: Item::Info(info),
    // rust: text,
}
}

/// Shown on a binding's row until it is focused, and in the search.
pub const BIND_TEXT: []const u8 = "Press this row, then the button that should do it.";

/// Every page's settings, in named groups of related rows. Settings another controller feature
/// brings get a group here, or a new `Page` when they are a subject of their own.
pub fn rows() V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let binds: Vec<Setting> = gamepad::ACTIONS
    // rust: .iter()
    // rust: .map(|(action, _)| Setting {
    // rust: item: Item::Bind(action),
    // rust: text: BIND_TEXT,
    // rust: })
    // rust: .collect();
    // rust: vec![
    // rust: (
    // rust: Page::General,
    // rust: vec![
    // rust: (
    // rust: "Controller",
    // rust: vec![option(
    // rust: Opt::PadEnabled,
    // rust: "Off, the game ignores every controller for this player.",
    // rust: )],
    // rust: ),
    // rust: (
    // rust: "Look",
    // rust: vec![
    // rust: option(
    // rust: Opt::PadLookSensitivity,
    // rust: "How fast the right stick turns the view.",
    // rust: ),
    // rust: option(
    // rust: Opt::PadInvertX,
    // rust: "Turn the view the other way, left and right.",
    // rust: ),
    // rust: option(Opt::PadInvertY, "Turn the view the other way, up and down."),
    // rust: option(
    // rust: Opt::PadLookDeadzone,
    // rust: "How far the right stick moves before the view turns. Raise it if the view drifts.",
    // rust: ),
    // rust: ],
    // rust: ),
    // rust: (
    // rust: "Movement",
    // rust: vec![
    // rust: option(
    // rust: Opt::PadToggleSneak,
    // rust: "Hold the button to sneak, or press it once to start and again to stop.",
    // rust: ),
    // rust: option(
    // rust: Opt::PadMoveDeadzone,
    // rust: "How far the left stick moves before you walk. Raise it if you drift.",
    // rust: ),
    // rust: ],
    // rust: ),
    // rust: (
    // rust: "Play",
    // rust: vec![option(
    // rust: Opt::PadTriggerThreshold,
    // rust: "How far a trigger is pulled before it counts as pressed.",
    // rust: )],
    // rust: ),
    // rust: (
    // rust: "Menus",
    // rust: vec![
    // rust: option(
    // rust: Opt::PadPointerSpeed,
    // rust: "How fast the stick moves the crosshair in inventories.",
    // rust: ),
    // rust: option(
    // rust: Opt::PadScrollSpeed,
    // rust: "How fast the right stick scrolls a list.",
    // rust: ),
    // rust: option(
    // rust: Opt::PadRepeatDelay,
    // rust: "How long a held direction waits before it repeats.",
    // rust: ),
    // rust: option(
    // rust: Opt::PadRepeatInterval,
    // rust: "How long a held direction takes between repeats.",
    // rust: ),
    // rust: option(
    // rust: Opt::PadKeyboard,
    // rust: "Which on-screen keyboard opens when a text field is pressed.",
    // rust: ),
    // rust: ],
    // rust: ),
    // rust: ],
    // rust: ),
    // rust: (
    // rust: Page::Bindings,
    // rust: vec![
    // rust: ("Actions", binds),
    // rust: (
    // rust: "Reset",
    // rust: vec![Setting {
    // rust: item: Item::ResetBinds,
    // rust: text: "Every action back on its default button.",
    // rust: }],
    // rust: ),
    // rust: ],
    // rust: ),
    // rust: (
    // rust: Page::Device,
    // rust: vec![
    // rust: (
    // rust: "Detected",
    // rust: vec![
    // rust: info(
    // rust: Info::Player,
    // rust: "These settings belong to this player's profile.",
    // rust: ),
    // rust: info(
    // rust: Info::Device,
    // rust: "The controller driving this player, or else the first one connected.",
    // rust: ),
    // rust: info(
    // rust: Info::Ids,
    // rust: "The USB vendor and product the system reports. Useful when reporting a controller that misbehaves.",
    // rust: ),
    // rust: info(
    // rust: Info::Detected,
    // rust: "The glyph family the game picked from the controller's maker.",
    // rust: ),
    // rust: ],
    // rust: ),
    // rust: (
    // rust: "Glyphs",
    // rust: vec![
    // rust: option(
    // rust: Opt::PadGlyphs,
    // rust: "Follow the controller, or always show one family's buttons.",
    // rust: ),
    // rust: info(Info::Using, "The buttons menus show right now."),
    // rust: ],
    // rust: ),
    // rust: (
    // rust: "Feedback",
    // rust: vec![
    // rust: option(Opt::PadVibration, "Rumble when something happens to you."),
    // rust: option(
    // rust: Opt::PadAdaptiveTriggers,
    // rust: "A DualSense's triggers push back on bows and tools.",
    // rust: ),
    // rust: option(
    // rust: Opt::PadLightbar,
    // rust: "What a DualSense's light shows, over USB or Bluetooth.",
    // rust: ),
    // rust: ],
    // rust: ),
    // rust: ],
    // rust: ),
    // rust: ]
}

/// The controller a player's game sees, from its own reader or the splitscreen router.
pub const Device = struct {
    name: []const u8,
    vendor: ?u16,
    product: ?u16,
};

/// Who and what the screen is about; the game fills it in as it draws.
pub const Context = struct {
    /// The player whose profile holds these settings.
    player: []const u8,
    device: ?Device,
    /// The glyph family of `device`, before the player's choice.
    detected: GlyphStyle,
    /// The family menus show.
    style: GlyphStyle,
    /// The pad goes by its letters (`PadSettings::nintendo_letters`) and the glyphs are
    /// Nintendo's: each part shows the letter of the button playing it.
    by_letter: bool,
};

pub fn glyphs_name(style: GlyphStyle) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: lang::get(match style {
    // rust: GlyphStyle::Auto => "Unknown",
    // rust: GlyphStyle::Xbox => "horizon.options.glyphs.xbox",
    // rust: GlyphStyle::PlayStation => "horizon.options.glyphs.playstation",
    // rust: GlyphStyle::Nintendo => "horizon.options.glyphs.nintendo",
    // rust: })
}

/// Whether a binding differs from its default: only then can it be reset.
pub fn resets(s: *Settings, item: Item) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match item {
    // rust: Item::Bind(action) if !s.controller.is_default(action) => Some(action),
    // rust: _ => None,
}
}

    // rust: impl Item {
pub fn switch(self: *Self, s: *Settings) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let c = &s.controller;
    // rust: match self {
    // rust: Item::Option(Opt::PadEnabled) => Some(c.enabled),
    // rust: Item::Option(Opt::PadVibration) => Some(c.vibration),
    // rust: Item::Option(Opt::PadAdaptiveTriggers) => Some(c.adaptive_triggers),
    // rust: Item::Option(Opt::PadInvertX) => Some(c.invert_x),
    // rust: Item::Option(Opt::PadInvertY) => Some(c.invert_y),
    // rust: _ => None,
}
}
pub fn slider(self: *Self, s: *Settings) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Item::Option(o) => o.slider_position(s),
    // rust: _ => None,
}
}
    /// A value stepped between `<` `>`: not a tick box, a slider or a press.
pub fn steps(self: *Self, s: *Settings) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(self, Item::Option(_)) && self.switch(s).is_none() && self.slider(s).is_none()
}
}

/// What the options screen must do after an interaction here.
pub const Action = enum {
    ButtonClick,
    Changed,
    SliderDrag,
    /// Wait for a controller button to bind to this action.
    BindPad(&'static str),
    Done,
};

/// What the keyboard or a controller can focus.
pub const Target = enum {
    Item(Item),
    /// The reset button on a changed binding's row.
    ResetBind(&'static str),
    Page(Page),
    Search,
    Undo,
    Done,
};

    // rust: type Line = shell::Line<Page, Setting>;

/// A binding row's reset button, at its right end.
pub fn reset_rect(cols: *Columns, y: f32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let w = 36.0;
    // rust: let right = cols.list_x + cols.list_w - 2.0;
    // rust: [right - w, y + 2.0, w, style::CONTROL_H]
}
/// A binding row without its reset button.
pub fn bind_rect(cols: *Columns, y: f32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [x, y, w, h] = cols.row(y);
    // rust: [x, y, w - 40.0, h]
}

pub const ControllerUi = struct {
    /// The list's scroll amount and its held scrollbar (`AbstractScrollArea`).
    scroll: ui::Scroll,
    dragging: ?Item,
    focus: ?Target,
    can_change_value: bool,
    /// The action waiting for a button (`Action::BindPad`).
    binding: ?*'static str,
    search: ui::EditBox,
    /// The page the plate shows, alone, while nothing is searched.
    page: Page,
    /// While searching, the page last picked in the page list: current until the list scrolls.
    picked: ?Page,
    /// The settings as the screen found them, for Undo.
    before: ?*PadSettings,
    context: Context,
};
    // rust: impl Default for ControllerUi {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut search = ui::EditBox::new(0.0, 0.0, 0.0, 8.0);
    // rust: search.bordered = false;
    // rust: search.focused = false;
    // rust: search.message = lang::get("Search options");
    // rust: Self {
    // rust: scroll: ui::Scroll::default(),
    // rust: dragging: None,
    // rust: focus: None,
    // rust: can_change_value: false,
    // rust: binding: None,
    // rust: search,
    // rust: page: Page::General,
    // rust: picked: None,
    // rust: before: None,
    // rust: context: Context::default(),
}
}
}

    // rust: impl ControllerUi {
    /// The screen opens, at `page`.
pub fn open(self: *Self, page: Page) void {
}
    // rust: *self = Self {
    // rust: page,
    // rust: context: std::mem::take(&mut self.context),
    // rust: ..Self::default()
}
}
    /// Settings take effect as they change, so all that can be pending is going back on them:
    /// Undo is there only while they differ from what the screen opened with.
pub fn pending(self: *Self, s: *Settings) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.before.as_deref().is_some_and(|b| *b != s.controller)
}
    /// Undo's button while there is something to undo.
pub fn undo_rect(self: *Self, s: *Settings) void {
}
    // rust: self.pending(s).then(|| Columns::of(w, h).button(1))
}
pub fn query(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.search.value.trim().to_lowercase()
}
    /// The button a binding reads as on this pad.
pub fn shown(self: *Self, b: Button) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.context.by_letter {
    // rust: b.by_letter()
    // rust: } else {
    // rust: b
}
}
    /// A row as its name and its value.
pub fn parts(self: *Self, item: Item, s: *Settings) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match item {
    // rust: Item::Option(o) => shell::name_and_value(&o.label(s).plain()),
    // rust: Item::Bind(action) => {
    // rust: let name = lang::get(gamepad::action_caption(action));
    // rust: let value = match s.controller.binding(action) {
    // rust: Some(b) => self.shown(b).label(self.context.style).to_owned(),
    // rust: None => lang::get("key.keyboard.unknown"),
}
    // rust: let value = if self.binding == Some(action) {
    // rust: format!("> {value} <")
    // rust: } else if s.controller.conflicts(action) {
    // rust: format!("[ {value} ]")
    // rust: } else {
    // rust: value
}
    // rust: (name, Some(value))
}
    // rust: Item::ResetBinds => (lang::get("controls.resetAll"), None),
    // rust: Item::Info(which) => {
    // rust: let c = &self.context;
    // rust: let (name, value) = match which {
    // rust: Info::Player => ("Player profile", c.player.clone()),
    // rust: Info::Device => (
    // rust: "Controller",
    // rust: c.device
    // rust: .as_ref()
    // rust: .map_or_else(|| lang::get("No controller"), |d| d.name.clone()),
    // rust: ),
    // rust: Info::Ids => (
    // rust: "Vendor and product",
    // rust: match c.device.as_ref().map(|d| (d.vendor, d.product)) {
    // rust: Some((Some(vendor), Some(product))) => {
    // rust: format!("{vendor:04x}:{product:04x}")
}
    // rust: _ => lang::get("Unknown"),
    // rust: },
    // rust: ),
    // rust: Info::Detected => ("Detected glyphs", glyphs_name(c.detected)),
    // rust: Info::Using => ("Glyphs in use", glyphs_name(c.style)),
}
    // rust: (lang::get(name), Some(value))
}
}
}
    /// The list's lines and its content height: the open page's settings in their groups or,
    /// while searching, the settings of every page whose name or description has the search in
    /// it, under their pages' names. The row being changed stays whatever it reads now.
pub fn lines(self: *Self, s: *Settings) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let query = self.query();
    // rust: let mut lines = shell::Lines::new();
    // rust: for (page, groups) in rows() {
    // rust: if query.is_empty() && page != self.page {
    // rust: continue;
}
    // rust: let groups: Vec<(&'static str, Vec<Setting>)> = groups
    // rust: .into_iter()
    // rust: .map(|(name, rows)| {
    // rust: let rows = rows
    // rust: .into_iter()
    // rust: .filter(|r| {
    // rust: query.is_empty()
    // rust: || self.focus == Some(Target::Item(r.item))
    // rust: || self.dragging == Some(r.item)
    // rust: || self.parts(r.item, s).0.to_lowercase().contains(&query)
    // rust: || lang::get(r.text).to_lowercase().contains(&query)
    // rust: })
    // rust: .collect::<Vec<_>>();
    // rust: (name, rows)
    // rust: })
    // rust: .filter(|(_, rows)| !rows.is_empty())
    // rust: .collect();
    // rust: if groups.is_empty() {
    // rust: continue;
}
    // rust: if !query.is_empty() {
    // rust: lines.page(page);
}
    // rust: for (name, rows) in groups {
    // rust: lines.group(page, name, rows);
}
}
    // rust: lines.finish()
}
    /// The columns and the list, with the scroll kept within it.
pub fn layout(self: *Self, s: *Settings, w: f32, h: f32) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let cols = Columns::of(w, h);
    // rust: let (lines, content) = self.lines(s);
    // rust: self.scroll.clamp(cols.top, cols.bottom, content);
    // rust: (cols, lines, content)
}
    /// Pick `page`: the plate shows it alone or, while searching, scrolls to its matches.
pub fn pick(self: *Self, page: Page, lines: *[Line], cols: *Columns, content: f32) void {
}
    // rust: self.page = page;
    // rust: self.scroll.amount = 0.0;
    // rust: if self.query().is_empty() {
    // rust: return;
}
    // rust: if let Some(line) = lines.iter().find(|l| l.page == page) {
    // rust: self.scroll.amount = line.y;
    // rust: self.scroll.clamp(cols.top, cols.bottom, content);
    // rust: self.picked = Some(page);
}
}
    /// Whether the page list's `page` has anything to show.
pub fn has(self: *Self, page: Page, lines: *[Line]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.query().is_empty() || lines.iter().any(|l| l.page == page)
}
    /// The page the plate shows: the open one or, while searching, the one picked, else the
    /// topmost line's.
pub fn current(self: *Self, lines: *[Line]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.query().is_empty() {
    // rust: return Some(self.page);
}
    // rust: self.picked.or_else(|| {
    // rust: lines
    // rust: .iter()
    // rust: .find(|l| l.y + l.h() > self.scroll.amount)
    // rust: .map(|l| l.page)
    // rust: })
}
pub fn row_y(self: *Self, cols: *Columns, line: *Line) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: cols.top + line.y - self.scroll.amount
}
    /// Remember the settings before the first change, for Undo.
pub fn keep(self: *Self, s: *Settings) void {
}
    // rust: if self.before.is_none() {
    // rust: self.before = Some(Box::new(s.controller.clone()));
}
}
    /// Undo: this player's controller settings back to what they were when the screen opened.
pub fn undo(self: *Self, s: *mut Settings) void {
}
    // rust: if let Some(before) = self.before.as_deref() {
    // rust: s.controller = before.clone();
}
}

    // rust: pub fn draw(
    // rust: &mut self,
    // rust: s: &Settings,
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: cursor: (f32, f32),
    // rust: in_world: bool,
    // rust: ) {
    // rust: self.keep(s);
    // rust: let (w, h) = (batch.width, batch.height);
    // rust: let (cols, lines, content) = self.layout(s, w, h);
    // rust: shell::backdrop(batch, atlas, in_world);
    // rust: let current = self.current(&lines);
    // rust: self.draw_side(batch, atlas, &cols, &lines, current, cursor);
    // rust: let focused = self.focus == Some(Target::Search);
    // rust: shell::search_field(&mut self.search, batch, atlas, &cols, cursor, focused);

    // rust: let query = self.search.value.trim();
    // rust: let heading = if query.is_empty() {
    // rust: lang::get(current.unwrap_or(self.page).name())
    // rust: } else {
    // rust: lang::get("Results for \"%s\"").replace("%s", query)
}
    // rust: shell::plate(batch, atlas, &cols, &heading);

    // rust: let over_list = cursor.1 >= cols.top && cursor.1 < cols.bottom;
    // rust: let mut described = None;
    // rust: shell::list(
    // rust: batch,
    // rust: atlas,
    // rust: &cols,
    // rust: &lines,
    // rust: self.scroll.amount,
    // rust: Page::name,
    // rust: |batch, setting: Setting, y| {
    // rust: let item = setting.item;
    // rust: let [rx, ry, rw, rh] = cols.row(y);
    // rust: let hover = over_list && ui::hovered(cursor, rx, ry, rw, rh);
    // rust: let focused = self.focus == Some(Target::Item(item))
    // rust: || matches!((self.focus, item), (Some(Target::ResetBind(a)), Item::Bind(b)) if a == b);
                // The pointer's row wins over the keyboard's.
    // rust: if hover || self.dragging == Some(item) || (focused && described.is_none()) {
    // rust: described = Some(setting);
}
    // rust: match item {
    // rust: Item::Bind(action) => {
    // rust: self.draw_bind(batch, atlas, s, &cols, action, y, cursor, over_list)
}
    // rust: Item::Info(_) => self.draw_info(batch, atlas, s, &cols, item, y, hover),
    // rust: _ => {
    // rust: let label = match item {
    // rust: Item::Option(o) => o.label(s).plain(),
    // rust: _ => self.parts(item, s).0,
}
    // rust: let (name, value) = self.parts(item, s);
    // rust: let view = shell::RowView {
    // rust: label: &label,
    // rust: name: &name,
    // rust: value: value.as_deref(),
    // rust: switch: item.switch(s),
    // rust: slider: item.slider(s),
    // rust: live: true,
    // rust: hover,
    // rust: focused,
    // rust: held: self.dragging == Some(item),
}
    // rust: shell::row(batch, atlas, &cols, y, &view);
}
}
    // rust: },
    // rust: );
    // rust: shell::scroller(batch, atlas, &cols, content, self.scroll.amount);
    // rust: self.draw_dock(batch, atlas, s, &cols, described, current);

    // rust: let mut foot = vec![(cols.button(0), "Done", Target::Done, Declared::Done)];
        // Undo only while there is something to undo.
    // rust: if self.pending(s) {
    // rust: foot.push((cols.button(1), "Undo", Target::Undo, Declared::Apply));
}
    // rust: for (rect, label, target, declared) in foot {
    // rust: let label = Text::literal(lang::get(label));
    // rust: let focused = self.focus == Some(target);
    // rust: let primary = target == Target::Done;
    // rust: crate::widgets::declare_action(declared, rect, true);
    // rust: shell::foot_button(batch, atlas, rect, &label, cursor, (focused, primary));
}
}
    /// The mark over the search field, the page list, and under it whose settings these are and
    /// which controller the game sees.
    // rust: fn draw_side(
    // rust: &self,
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: cols: &Columns,
    // rust: lines: &[Line],
    // rust: current: Option<Page>,
    // rust: cursor: (f32, f32),
    // rust: ) {
    // rust: shell::mark(batch, atlas, cols, &lang::get("Controller"));
    // rust: for (i, page) in Page::ALL.into_iter().enumerate() {
    // rust: let has = self.has(page, lines);
    // rust: let open = current == Some(page);
    // rust: let focused = self.focus == Some(Target::Page(page));
    // rust: let name = lang::get(page.name());
    // rust: let flags = (has, open, focused);
    // rust: shell::page_tab(batch, atlas, cols.page(i), &name, flags, cursor);
}
    // rust: let [x, y, w, _] = cols.page(Page::ALL.len());
    // rust: let device = self
    // rust: .context
    // rust: .device
    // rust: .as_ref()
    // rust: .map_or_else(|| lang::get("No controller"), |d| d.name.clone());
    // rust: let player = lang::tr("Editing: %s", &[&self.context.player]);
    // rust: for (i, line) in [player, device].iter().enumerate() {
    // rust: let rect = [x + 2.0, y + 2.0 + i as f32 * 10.0, w - 4.0, 8.0];
    // rust: crate::widgets::record(line, rect, false);
    // rust: let line = Text::literal(style::fit(atlas, line, w - 4.0));
    // rust: batch.text_styled(atlas, &line, rect[0], rect[1], style::MUTED, true);
}
}
    /// A binding's row: its name, its button, and a reset once it isn't the default.
    // rust: fn draw_bind(
    // rust: &self,
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: s: &Settings,
    // rust: cols: &Columns,
    // rust: action: &'static str,
    // rust: y: f32,
    // rust: cursor: (f32, f32),
    // rust: over_list: bool,
    // rust: ) {
    // rust: let item = Item::Bind(action);
    // rust: let rect = bind_rect(cols, y);
    // rust: let reset = reset_rect(cols, y);
    // rust: let over = |[x, y, w, h]: [f32; 4]| over_list && ui::hovered(cursor, x, y, w, h);
    // rust: let hover = over(rect);
    // rust: let focused = self.focus == Some(Target::Item(item));
    // rust: let (name, value) = self.parts(item, s);
    // rust: let value = value.unwrap_or_default();
    // rust: if hover || focused {
    // rust: let lit = [rect[0] + 2.0, y + 1.0, rect[2] - 4.0, style::ROW - 2.0];
    // rust: style::fill(batch, atlas, lit, style::HOVER);
}
    // rust: let label = format!("{name}: {value}");
    // rust: crate::widgets::widget_cursor(hover, true);
    // rust: crate::widgets::record(&label, rect, true);
    // rust: crate::widgets::narratable(|| {
    // rust: crate::widgets::Narratable::button(label.clone(), rect, true)
    // rust: .hovered(hover)
    // rust: .focused(focused)
    // rust: });
    // rust: crate::widgets::target(rect);
    // rust: let ty = y + ((style::ROW - 8.0) / 2.0).floor();
    // rust: let left = rect[0] + style::INSET;
    // rust: let chip_w = 56.0;
    // rust: let chip = [
    // rust: rect[0] + rect[2] - chip_w - 2.0,
    // rust: y + 2.0,
    // rust: chip_w,
    // rust: style::CONTROL_H,
    // rust: ];
        // The button in its colour; yellow over it when another action has it too.
    // rust: let shown = match s.controller.binding(action) {
    // rust: _ if self.binding == Some(action) || s.controller.conflicts(action) => {
    // rust: Text::literal(value).with_color(crate::text::YELLOW)
}
    // rust: Some(b) => {
    // rust: let [r, g, bl] = self.shown(b).color(self.context.style);
    // rust: Text::literal(value)
    // rust: .with_color(u32::from(r) << 16 | u32::from(g) << 8 | u32::from(bl))
}
    // rust: None => Text::literal(value),
}
    // rust: style::button(batch, atlas, chip, &shown, (hover, true, false));
    // rust: let shown = Text::literal(style::fit(atlas, &name, chip[0] - 6.0 - left));
    // rust: batch.text_styled(atlas, &shown, left, ty, style::WHITE, true);
    // rust: if focused {
    // rust: style::ring(batch, atlas, rect, style::WHITE);
}
        // Reset: a target only where it would do something.
    // rust: let live = !s.controller.is_default(action);
    // rust: let reset_label = lang::get("controls.reset");
    // rust: let reset_hover = live && over(reset);
    // rust: let reset_focused = self.focus == Some(Target::ResetBind(action));
    // rust: crate::widgets::widget_cursor(reset_hover, live);
    // rust: crate::widgets::record(&reset_label, reset, live);
    // rust: crate::widgets::narratable(|| {
    // rust: crate::widgets::Narratable::button(
    // rust: lang::tr("narrator.controls.reset", &[&name]),
    // rust: reset,
    // rust: live,
    // rust: )
    // rust: .hovered(reset_hover)
    // rust: .focused(reset_focused)
    // rust: });
    // rust: if live {
    // rust: crate::widgets::target(reset);
}
    // rust: let shown = Text::literal(reset_label);
    // rust: style::button(batch, atlas, reset, &shown, (reset_hover, live, false));
    // rust: if reset_focused {
    // rust: style::ring(batch, atlas, reset, style::WHITE);
}
}
    /// A line to read: focusable, so the narrator and a controller reach it, and it does nothing.
    // rust: fn draw_info(
    // rust: &self,
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: s: &Settings,
    // rust: cols: &Columns,
    // rust: item: Item,
    // rust: y: f32,
    // rust: hover: bool,
    // rust: ) {
    // rust: let rect = cols.row(y);
    // rust: let focused = self.focus == Some(Target::Item(item));
    // rust: let (name, value) = self.parts(item, s);
    // rust: let value = value.unwrap_or_default();
    // rust: let label = format!("{name}: {value}");
    // rust: crate::widgets::record(&label, rect, true);
    // rust: crate::widgets::narratable(|| {
    // rust: crate::widgets::Narratable::button(label.clone(), rect, true)
    // rust: .hovered(hover)
    // rust: .focused(focused)
    // rust: });
    // rust: crate::widgets::target(rect);
    // rust: if hover || focused {
    // rust: let lit = [rect[0] + 2.0, y + 1.0, rect[2] - 4.0, style::ROW - 2.0];
    // rust: style::fill(batch, atlas, lit, style::HOVER);
}
    // rust: let ty = y + ((style::ROW - 8.0) / 2.0).floor();
    // rust: let left = rect[0] + style::INSET;
    // rust: let name_w = atlas.font.width(&name);
    // rust: batch.text_styled(atlas, &Text::literal(name), left, ty, style::WHITE, true);
    // rust: let room = rect[2] - 2.0 * style::INSET - name_w - 8.0;
    // rust: let value = style::fit(atlas, &value, room);
    // rust: let vx = rect[0] + rect[2] - style::INSET - atlas.font.width(&value);
    // rust: batch.text_styled(atlas, &Text::literal(value), vx, ty, style::SOFT, true);
    // rust: if focused {
    // rust: style::ring(
    // rust: batch,
    // rust: atlas,
    // rust: [rect[0] + 1.0, y, rect[2] - 2.0, style::ROW],
    // rust: style::WHITE,
    // rust: );
}
}
    /// The strip under the plate: the hovered or focused setting's name, then what it does; with
    /// none, what the open page holds.
    // rust: fn draw_dock(
    // rust: &self,
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: s: &Settings,
    // rust: cols: &Columns,
    // rust: setting: Option<Setting>,
    // rust: current: Option<Page>,
    // rust: ) {
    // rust: let [x, y, ..] = cols.dock;
    // rust: style::panel(batch, atlas, cols.dock);
    // rust: let (name, text) = match setting {
    // rust: Some(setting) => (self.parts(setting.item, s).0, self.description(setting, s)),
    // rust: None => {
    // rust: let Some(page) = current else { return };
    // rust: (lang::get(page.name()), lang::get(page.about()))
}
}
    // rust: let name = Text::literal(name);
    // rust: batch.text_styled(atlas, &name, x + 12.0, y + 8.0, style::WHITE, true);
    // rust: shell::dock_note(batch, atlas, cols, text, style::GREY);
}
    /// What a row does. A binding names the controller's own buttons, and what else its button
    /// does when it shares it.
pub fn description(self: *Self, setting: Setting, s: *Settings) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Item::Bind(action) = setting.item else {
    // rust: return lang::get(setting.text);
}
    // rust: let pad = &s.controller;
    // rust: let style = self.context.style;
    // rust: if self.binding == Some(action) {
    // rust: return lang::tr(
    // rust: "Press the button for this. %s cancels.",
    // rust: &[&Button::Start.label(style)],
    // rust: );
}
    // rust: if pad.conflicts(action)
    // rust: && let Some(button) = pad.binding(action)
    // rust: {
    // rust: let others: Vec<String> = pad
    // rust: .actions_of(button)
    // rust: .into_iter()
    // rust: .filter(|other| *other != action)
    // rust: .map(|other| lang::get(gamepad::action_caption(other)))
    // rust: .collect();
    // rust: return lang::tr("This button also does: %s", &[&others.join(", ")]);
}
    // rust: lang::get(setting.text)
}

    /// A press (or a drag with `drag`) at `(x, y)`.
    // rust: pub fn click(
    // rust: &mut self,
    // rust: s: &mut Settings,
    // rust: (x, y): (f32, f32),
    // rust: (w, h): (f32, f32),
    // rust: framebuffer: [i32; 2],
    // rust: drag: bool,
    // rust: right: bool,
    // rust: shift: bool,
    // rust: ) -> Vec<Action> {
    // rust: self.keep(s);
    // rust: let (cols, lines, content) = self.layout(s, w, h);
    // rust: let at = |[rx, ry, rw, rh]: [f32; 4]| ui::hovered((x, y), rx, ry, rw, rh);
    // rust: if drag {
    // rust: if self.scroll.held() && !cols.scrolls() {
    // rust: self.scroll.release();
}
    // rust: if self.scroll.held() {
    // rust: self.picked = None;
    // rust: self.scroll.drag(y, cols.top, cols.bottom, content);
    // rust: return Vec::new();
}
    // rust: if let Some(Item::Option(o)) = self.dragging {
    // rust: o.set_slider(s, cols.slider_at(x));
    // rust: return vec![Action::SliderDrag];
}
    // rust: return Vec::new();
}
    // rust: if right {
    // rust: return Vec::new();
}
    // rust: if cols.scrolls()
    // rust: && self
    // rust: .scroll
    // rust: .press((x, y), cols.bar_x(), cols.top, cols.bottom, content)
    // rust: {
    // rust: return Vec::new();
}
    // rust: if at(cols.search()) {
    // rust: if !self.search.value.is_empty() && at(cols.clear()) {
    // rust: self.search.set_value("");
    // rust: self.searched();
    // rust: return vec![Action::ButtonClick];
}
    // rust: self.focus = Some(Target::Search);
    // rust: self.search.reset_blink();
    // rust: self.search.move_cursor_to_end(false);
    // rust: return Vec::new();
}
    // rust: if self.focus == Some(Target::Search) {
    // rust: self.focus = None;
}
    // rust: if at(cols.button(0)) {
    // rust: self.focus = Some(Target::Done);
    // rust: return vec![Action::ButtonClick, Action::Done];
}
    // rust: if self.pending(s) && at(cols.button(1)) {
            // Undo goes away with the change it undid.
    // rust: self.focus = None;
    // rust: self.undo(s);
    // rust: return vec![Action::ButtonClick, Action::Changed];
}
    // rust: for (i, page) in Page::ALL.into_iter().enumerate() {
    // rust: if at(cols.page(i)) && self.has(page, &lines) {
    // rust: self.focus = Some(Target::Page(page));
    // rust: self.pick(page, &lines, &cols, content);
    // rust: return vec![Action::ButtonClick];
}
}
    // rust: if y < cols.top || y >= cols.bottom {
    // rust: return Vec::new();
}
    // rust: let Some((item, row_y)) = lines.iter().find_map(|line| {
    // rust: let ry = self.row_y(&cols, line);
    // rust: let setting = line.setting?;
    // rust: at(cols.row(ry)).then_some((setting.item, ry))
    // rust: }) else {
    // rust: return Vec::new();
}
    // rust: if let Some(action) = resets(s, item)
    // rust: && at(reset_rect(&cols, row_y))
    // rust: {
    // rust: return self.reset_bind(s, action);
}
    // rust: self.focus = Some(Target::Item(item));
    // rust: self.activate(s, item, shift, framebuffer, Some((x, &cols)))
}
    /// A binding back on its default; the focus goes back to its row, as its reset goes away.
pub fn reset_bind(self: *Self, s: *mut Settings, action: *'static str) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: s.controller.bind(action, PadSettings::default_of(action));
    // rust: self.focus = Some(Target::Item(Item::Bind(action)));
    // rust: vec![Action::ButtonClick, Action::Changed]
}
    /// Press `item`: `at` is where on its row and its slider's track (`None` from the keyboard).
    // rust: fn activate(
    // rust: &mut self,
    // rust: s: &mut Settings,
    // rust: item: Item,
    // rust: back: bool,
    // rust: framebuffer: [i32; 2],
    // rust: at: Option<(f32, &Columns)>,
    // rust: ) -> Vec<Action> {
    // rust: match item {
    // rust: Item::Info(_) => Vec::new(),
    // rust: Item::Bind(action) => vec![Action::ButtonClick, Action::BindPad(action)],
    // rust: Item::ResetBinds => {
    // rust: s.controller.reset_bindings();
    // rust: vec![Action::ButtonClick, Action::Changed]
}
    // rust: Item::Option(o) if o.slider_position(s).is_some() => {
    // rust: self.can_change_value = true;
                // A press on the track sets the value there; on the name, only focuses.
    // rust: match at {
    // rust: Some((x, cols)) if x >= cols.track().0 => {
    // rust: self.dragging = Some(item);
    // rust: o.set_slider(s, cols.slider_at(x));
    // rust: vec![Action::SliderDrag]
}
    // rust: _ => Vec::new(),
}
}
    // rust: Item::Option(o) => {
    // rust: self.can_change_value = false;
    // rust: o.cycle(s, back, framebuffer);
    // rust: vec![Action::ButtonClick, Action::Changed]
}
}
}
    /// Lets go of a slider (true: it plays its click) or the scrollbar.
pub fn release(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.scroll.release();
    // rust: self.dragging.take().is_some()
}
    /// The mouse wheel at the cursor: it scrolls the list, except that a hovered value stepped by
    /// `<` `>` takes the step while the "Scroll wheel changes settings" extra is on.
    // rust: pub fn wheel(
    // rust: &mut self,
    // rust: s: &mut Settings,
    // rust: (w, h): (f32, f32),
    // rust: (x, y): (f32, f32),
    // rust: framebuffer: [i32; 2],
    // rust: amount: f32,
    // rust: ) -> Vec<Action> {
    // rust: if amount != 0.0 && s.extras.wheel_cycles_settings {
    // rust: let (cols, lines, _) = self.layout(s, w, h);
    // rust: let hovered = (y >= cols.top && y < cols.bottom)
    // rust: .then(|| {
    // rust: lines.iter().find_map(|line| {
    // rust: let setting = line.setting?;
    // rust: let ry = self.row_y(&cols, line);
    // rust: ui::hovered((x, y), cols.list_x, ry, cols.list_w, style::ROW)
    // rust: .then_some(setting.item)
    // rust: })
    // rust: })
    // rust: .flatten();
    // rust: if let Some(item @ Item::Option(o)) = hovered
    // rust: && item.steps(s)
    // rust: {
    // rust: o.cycle(s, amount > 0.0, framebuffer);
    // rust: return vec![Action::ButtonClick, Action::Changed];
}
}
    // rust: self.scroll(s, (w, h), amount);
    // rust: Vec::new()
}
    /// The mouse wheel scrolls the list.
pub fn scroll(self: *Self, s: *Settings) void {
}
    // rust: let (cols, _, content) = self.layout(s, w, h);
    // rust: self.picked = None;
    // rust: self.scroll
    // rust: .wheel(amount, 18.0, cols.top, cols.bottom, content);
}
    /// What Tab steps through, in order, with where each is on screen (`shell::reach`).
    // rust: fn focusables(
    // rust: &self,
    // rust: s: &Settings,
    // rust: cols: &Columns,
    // rust: lines: &[Line],
    // rust: near: bool,
    // rust: ) -> Vec<(Target, [f32; 4])> {
    // rust: let mut out = vec![(Target::Search, cols.search())];
    // rust: for (i, page) in Page::ALL.into_iter().enumerate() {
    // rust: if self.has(page, lines) {
    // rust: out.push((Target::Page(page), cols.page(i)));
}
}
    // rust: let rows: Vec<(Item, f32, bool)> = lines
    // rust: .iter()
    // rust: .filter_map(|line| Some((line.setting?.item, self.row_y(cols, line), true)))
    // rust: .collect();
    // rust: let reach = shell::reach(&rows, cols, near);
    // rust: for &(item, y, _) in &rows[reach] {
    // rust: let rect = match item {
    // rust: Item::Bind(_) => bind_rect(cols, y),
    // rust: _ => cols.row(y),
}
    // rust: out.push((Target::Item(item), rect));
    // rust: if let Some(action) = resets(s, item) {
    // rust: out.push((Target::ResetBind(action), reset_rect(cols, y)));
}
}
    // rust: if self.pending(s) {
    // rust: out.push((Target::Undo, cols.button(1)));
}
    // rust: out.push((Target::Done, cols.button(0)));
    // rust: out
}
    /// Focus `target`, scrolling its row into the list's view.
    // rust: fn focus_on(
    // rust: &mut self,
    // rust: s: &Settings,
    // rust: target: Target,
    // rust: rect: [f32; 4],
    // rust: cols: &Columns,
    // rust: content: f32,
    // rust: ) {
    // rust: self.focus = Some(target);
    // rust: self.can_change_value = matches!(target, Target::Item(i) if i.slider(s).is_some());
    // rust: if matches!(target, Target::Item(_) | Target::ResetBind(_)) {
    // rust: shell::scroll_into_view(&mut self.scroll, rect, cols, content);
    // rust: self.picked = None;
}
}

    /// Keys: typing in the search field, Tab and the arrows between controls, Left and Right on a
    /// slider, Enter or Space to press. False: the screen handles it (Escape closes it).
    // rust: pub fn key_modifiers(
    // rust: &mut self,
    // rust: s: &mut Settings,
    // rust: key: winit::keyboard::KeyCode,
    // rust: text: Option<&str>,
    // rust: shift: bool,
    // rust: (w, h): (f32, f32),
    // rust: framebuffer: [i32; 2],
    // rust: ) -> (Vec<Action>, bool) {
//         use winit::keyboard::KeyCode as K;
    // rust: self.keep(s);
    // rust: if key == K::Escape {
    // rust: self.can_change_value = false;
    // rust: return (Vec::new(), false);
}
    // rust: if self.focus == Some(Target::Search)
    // rust: && !matches!(key, K::Tab | K::ArrowDown | K::Enter | K::NumpadEnter)
    // rust: {
    // rust: let before = self.search.value.clone();
    // rust: if !self.search.key(key, false, shift)
    // rust: && let Some(t) = text
    // rust: {
    // rust: let typed: String = t.chars().filter(|c| !c.is_control()).collect();
    // rust: self.type_text(&typed);
}
    // rust: if self.search.value != before {
    // rust: self.searched();
}
    // rust: return (Vec::new(), true);
}
    // rust: let (cols, lines, content) = self.layout(s, w, h);
    // rust: let near = key != K::Tab;
    // rust: let focusables = self.focusables(s, &cols, &lines, near);
    // rust: let current = self
    // rust: .focus
    // rust: .and_then(|f| focusables.iter().position(|&(t, _)| t == f));
    // rust: if key == K::Tab {
    // rust: let next = shell::tab_step(focusables.len(), current, shift);
    // rust: let (target, rect) = focusables[next];
    // rust: self.focus_on(s, target, rect, &cols, content);
    // rust: return (Vec::new(), true);
}
    // rust: if matches!(key, K::ArrowLeft | K::ArrowRight)
    // rust: && self.can_change_value
    // rust: && let Some(Target::Item(Item::Option(o))) = self.focus
    // rust: && let Some(pos) = o.slider_position(s)
    // rust: {
    // rust: let next = shell::slider_step(
    // rust: pos,
    // rust: o.slider_steps(),
    // rust: cols.track().1 + 8.0,
    // rust: key == K::ArrowRight,
    // rust: );
    // rust: o.set_slider(s, next);
    // rust: return (vec![Action::SliderDrag], true);
}
    // rust: if matches!(
    // rust: key,
    // rust: K::ArrowUp | K::ArrowDown | K::ArrowLeft | K::ArrowRight
    // rust: ) {
    // rust: let is_row = |t: Target| matches!(t, Target::Item(_));
    // rust: let next = shell::arrow_step(&focusables, current, key, &cols, is_row);
    // rust: let Some(next) = next else {
    // rust: return (Vec::new(), false);
}
    // rust: let (target, rect) = focusables[next];
    // rust: self.focus_on(s, target, rect, &cols, content);
    // rust: self.can_change_value = false;
    // rust: return (Vec::new(), true);
}
    // rust: if matches!(key, K::Space | K::Enter | K::NumpadEnter)
    // rust: && let Some(target) = self.focus
    // rust: {
    // rust: let actions = match target {
    // rust: Target::Search => Vec::new(),
    // rust: Target::Page(page) => {
    // rust: self.pick(page, &lines, &cols, content);
    // rust: vec![Action::ButtonClick]
}
    // rust: Target::Item(item) if item.slider(s).is_some() => {
    // rust: self.can_change_value = !self.can_change_value;
    // rust: Vec::new()
}
    // rust: Target::Item(item) => self.activate(s, item, shift, framebuffer, None),
    // rust: Target::ResetBind(action) => self.reset_bind(s, action),
    // rust: Target::Undo => {
    // rust: self.undo(s);
                    // Undo goes away with the change it undid.
    // rust: self.focus = Some(Target::Done);
    // rust: return (vec![Action::ButtonClick, Action::Changed], true);
}
    // rust: Target::Done => vec![Action::ButtonClick, Action::Done],
}
    // rust: return (actions, true);
}
    // rust: (Vec::new(), false)
}
    /// Whether the search field takes the keys.
pub fn typing(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.focus == Some(Target::Search)
}
    /// Text typed into the search field (the keyboard, a controller's on-screen keyboard).
pub fn type_text(self: *Self, text: []const u8) void {
}
    // rust: if !text.is_empty() {
    // rust: self.search.insert_text(text);
    // rust: self.searched();
}
}
    /// Ctrl+A/C/V/X in the search field.
    // rust: pub fn shortcut(
    // rust: &mut self,
    // rust: shortcut: crate::clipboard::EditShortcut,
    // rust: clipboard: &mut dyn crate::clipboard::Clipboard,
    // rust: ) -> bool {
    // rust: if !self.typing() {
    // rust: return false;
}
    // rust: let before = self.search.value.clone();
    // rust: self.search.shortcut(shortcut, clipboard);
    // rust: if self.search.value != before {
    // rust: self.searched();
}
        // Whatever it did: the key is the field's, not something to type.
    // rust: true
}
    /// The search changed: the list starts over at its top.
pub fn searched(self: *Self) void {
}
    // rust: self.scroll.amount = 0.0;
    // rust: self.picked = None;
}
    /// The names of the open page's rows, for the language tests.
    // rust: pub(crate) fn row_names(&self, s: &Settings) -> Vec<String> {
    // rust: self.lines(s)
    // rust: .0
    // rust: .iter()
    // rust: .filter_map(|l| Some(self.parts(l.setting?.item, s).0))
    // rust: .collect()
}
}

    // rust: mod tests {
//     use super::*;
//     use winit::keyboard::KeyCode as K;

pub const SIZE: (f32, f32) = (854.0, 480.0);
pub const FB: [i32; 2] = [1708, 960];

pub fn key(ui: *mut ControllerUi, s: *mut Settings, key: K) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ui.key_modifiers(s, key, None, false, SIZE, FB).0
}

    /// Tab reaches every row of every page from nothing but the keyboard, as a controller's
    /// focus reaches the same targets.
pub fn tab_reaches_every_setting_on_every_page() void {
}
    // rust: let mut s = Settings::default();
    // rust: let mut ui = ControllerUi::default();
    // rust: for (page, groups) in rows() {
    // rust: ui.open(page);
    // rust: let want: Vec<Item> = groups
    // rust: .iter()
    // rust: .flat_map(|(_, rows)| rows.iter().map(|r| r.item))
    // rust: .collect();
    // rust: let mut seen = Vec::new();
    // rust: for _ in 0..want.len() + Page::ALL.len() + 3 {
    // rust: key(&mut ui, &mut s, K::Tab);
    // rust: if let Some(Target::Item(item)) = ui.focus {
    // rust: seen.push(item);
}
}
    // rust: assert_eq!(seen, want, "{page:?}");
}
}

pub fn every_bindable_action_has_a_row_and_no_option_is_listed_twice() void {
}
    // rust: let items: Vec<Item> = rows()
    // rust: .into_iter()
    // rust: .flat_map(|(_, groups)| groups)
    // rust: .flat_map(|(_, rows)| rows)
    // rust: .map(|r| r.item)
    // rust: .collect();
    // rust: for (action, _) in gamepad::ACTIONS {
    // rust: assert!(items.contains(&Item::Bind(action)), "{action}");
}
    // rust: for (i, item) in items.iter().enumerate() {
    // rust: assert!(!items[i + 1..].contains(item), "{item:?}");
}
        // Every setting the old page had is still here.
    // rust: for opt in [
    // rust: Opt::PadEnabled,
    // rust: Opt::PadVibration,
    // rust: Opt::PadAdaptiveTriggers,
    // rust: Opt::PadLightbar,
    // rust: Opt::PadLookSensitivity,
    // rust: Opt::PadToggleSneak,
    // rust: Opt::PadInvertX,
    // rust: Opt::PadInvertY,
    // rust: Opt::PadMoveDeadzone,
    // rust: Opt::PadLookDeadzone,
    // rust: Opt::PadTriggerThreshold,
    // rust: Opt::PadGlyphs,
    // rust: Opt::PadKeyboard,
    // rust: Opt::PadPointerSpeed,
    // rust: Opt::PadScrollSpeed,
    // rust: Opt::PadRepeatDelay,
    // rust: Opt::PadRepeatInterval,
    // rust: ] {
    // rust: assert!(items.contains(&Item::Option(opt)), "{opt:?}");
}
}

pub fn undo_is_there_only_while_something_differs() void {
}
    // rust: let mut s = Settings::default();
    // rust: let mut ui = ControllerUi::default();
    // rust: ui.keep(&s);
    // rust: assert!(!ui.pending(&s));
    // rust: assert_eq!(ui.undo_rect(&s, SIZE), None);
        // Changing a value back isn't a change.
    // rust: let vibration = s.controller.vibration;
    // rust: s.controller.vibration = !vibration;
    // rust: assert!(ui.pending(&s));
    // rust: assert!(ui.undo_rect(&s, SIZE).is_some());
    // rust: s.controller.vibration = vibration;
    // rust: assert!(!ui.pending(&s));
    // rust: s.controller.bind("key.jump", Some(Button::North));
    // rust: s.controller.invert_y = !s.controller.invert_y;
    // rust: ui.undo(&mut s);
    // rust: assert_eq!(s.controller, PadSettings::default());
    // rust: assert!(!ui.pending(&s));
}

pub fn the_search_finds_rows_across_pages_and_drops_empty_pages() void {
}
    // rust: let s = Settings::default();
    // rust: let mut ui = ControllerUi::default();
    // rust: ui.type_text("rumble");
    // rust: let (lines, _) = ui.lines(&s);
    // rust: assert!(lines.iter().all(|l| l.page == Page::Device));
    // rust: assert!(ui.has(Page::Device, &lines) && !ui.has(Page::General, &lines));
        // By what it does, not only its name.
    // rust: ui.search.set_value("drift");
    // rust: let (lines, _) = ui.lines(&s);
    // rust: assert!(lines.iter().any(|l| l.page == Page::General));
    // rust: ui.search.set_value("no setting says this");
    // rust: assert!(ui.lines(&s).0.is_empty());
}

pub fn a_changed_binding_gains_a_reset_that_the_arrows_reach_and_it_goes_away() void {
}
    // rust: let mut s = Settings::default();
    // rust: s.controller.bind("key.jump", Some(Button::North));
    // rust: let mut ui = ControllerUi::default();
    // rust: ui.open(Page::Bindings);
    // rust: key(&mut ui, &mut s, K::Tab);
        // Search, the three pages, then the first action.
    // rust: for _ in 0..Page::ALL.len() + 1 {
    // rust: key(&mut ui, &mut s, K::Tab);
}
    // rust: assert_eq!(ui.focus, Some(Target::Item(Item::Bind("key.jump"))));
    // rust: key(&mut ui, &mut s, K::ArrowRight);
    // rust: assert_eq!(ui.focus, Some(Target::ResetBind("key.jump")));
    // rust: let actions = key(&mut ui, &mut s, K::Enter);
    // rust: assert!(actions.contains(&Action::Changed));
    // rust: assert!(s.controller.is_default("key.jump"));
    // rust: assert_eq!(ui.focus, Some(Target::Item(Item::Bind("key.jump"))));
        // A default binding has nothing to the right of it.
    // rust: key(&mut ui, &mut s, K::ArrowRight);
    // rust: assert_eq!(ui.focus, Some(Target::Item(Item::Bind("key.jump"))));
}

pub fn pressing_a_binding_waits_for_a_button_and_reading_rows_change_nothing() void {
}
    // rust: let mut s = Settings::default();
    // rust: let mut ui = ControllerUi::default();
    // rust: let actions = ui.activate(&mut s, Item::Bind("key.jump"), false, FB, None);
    // rust: assert_eq!(actions, [Action::ButtonClick, Action::BindPad("key.jump")]);
    // rust: let before = s.controller.clone();
    // rust: assert!(
    // rust: ui.activate(&mut s, Item::Info(Info::Device), false, FB, None)
    // rust: .is_empty()
    // rust: );
    // rust: assert_eq!(s.controller, before);
}

pub fn the_keyboard_steps_a_slider_after_enter_and_leaves_it_with_the_arrows() void {
}
    // rust: let mut s = Settings::default();
    // rust: let mut ui = ControllerUi {
    // rust: focus: Some(Target::Item(Item::Option(Opt::PadMoveDeadzone))),
    // rust: ..ControllerUi::default()
}
    // rust: let before = s.controller.move_deadzone;
    // rust: key(&mut ui, &mut s, K::Enter);
    // rust: key(&mut ui, &mut s, K::ArrowRight);
    // rust: assert!((s.controller.move_deadzone - before - 0.01).abs() < 0.001);
}

pub fn every_text_is_in_the_language_table() void {
}
    // rust: let (_, missed) = lang::scoped(lang::Language::load(&[], "de_de"), || {
    // rust: for (page, groups) in rows() {
    // rust: lang::get(page.name());
    // rust: lang::get(page.about());
    // rust: for (group, rows) in groups {
    // rust: lang::get(group);
    // rust: for row in rows {
    // rust: lang::get(row.text);
}
}
}
    // rust: for text in [
    // rust: "Controller",
    // rust: "Player profile",
    // rust: "Vendor and product",
    // rust: "Detected glyphs",
    // rust: "Glyphs in use",
    // rust: "Unknown",
    // rust: "No controller",
    // rust: "Editing: %s",
    // rust: "Press the button for this. %s cancels.",
    // rust: "This button also does: %s",
    // rust: ] {
    // rust: lang::get(text);
}
    // rust: });
    // rust: assert_eq!(missed, Vec::<String>::new());
}
}
