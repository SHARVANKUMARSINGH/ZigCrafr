//! Transpiled from Horizon Rust crate
//! Module: horizon-client_game_rules_screen
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! AbstractGameRulesScreen: the rules by category under a search box, a
//! switch or a number box each. InWorldGameRulesScreen, opened from World
//! Options, sends the changed ones on Done (ServerboundSetGameRulePacket) and
//! asks before leaving with changes (ConfirmScreen); WorldCreationGameRulesScreen,
//! opened from Create New World, hands them back and leaves without asking.
// use crate::{
    // rust: confirm_screen::Confirm,
    // rust: font::Font,
    // rust: gamerules::{self, GameRules, Rule, Value},
    // rust: hud::{HudAtlas, HudBatch},
    // rust: lang,
    // rust: text::{Style, Text, named_color},
    // rust: ui::{self, EditBox},
}

/// HeaderAndFooterLayout(12 + 9 + 15, 33): the title over the search box.
pub const HEADER: f32 = 36.0;
pub const FOOTER: f32 = 33.0;
/// RuleList: 24 pixel entries in AbstractSelectionList's 220 pixel rows.
pub const ROW: f32 = 24.0;
pub const ROW_WIDTH: f32 = 220.0;
pub const SEARCH_WIDTH: f32 = 200.0;
/// EditBox text colours (`hud::rgba` order, ABGR): IntegerRuleEntry's valid
/// (-2039584) and invalid (-65536).
pub const VALID: u32 = 0xFFE0_E0E0;
pub const INVALID: u32 = 0xFF00_00FF;

pub const Row = enum {
    Category(&'static str),
    Rule(&'static Rule),
};

/// What a click or Escape asks of World Options.
pub const Exit = enum {
    /// Done: the rules that changed.
    Apply(Vec<(&'static str, Value)>),
    /// Cancel, or discarding the changes.
    Discard,
};

pub const RulesScreen = struct {
    search: EditBox,
    values: GameRules,
    initial: GameRules,
    /// IntegerRuleEntry's boxes, by rule.
    numbers: Vec<(*'static str,
    /// RuleList's scrolling: the wheel and the held scrollbar.
    scroll: ui::Scroll,
    /// ConfirmScreen "Game Rule Changes" in its place.
    confirm: bool,
    /// InWorldGameRulesScreen rather than WorldCreationGameRulesScreen.
    in_world: bool,
};

pub fn name_key(r: *Rule) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: format!("gamerule.minecraft.{}", r.name)
}
pub fn category_key(category: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: format!("gamerule.category.minecraft.{category}")
}
/// GameRule.deserialize of an integer rule: Brigadier's readInt (digits,
/// '.' and '-' only, nothing after), then the rule's range.
pub fn parse(r: *Rule, s: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let number = !s.is_empty()
    // rust: && s.chars()
    // rust: .all(|c| c.is_ascii_digit() || c == '-' || c == '.');
    // rust: number
    // rust: .then(|| s.parse::<i32>().ok())
    // rust: .flatten()
    // rust: .filter(|v| (r.min..=r.max).contains(v))
}
pub fn lines(font: *Font, t: *Text, width: f32) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: font.split_lines(t, width)
    // rust: .into_iter()
    // rust: .map(|(line, _)| line)
    // rust: .collect()
}
pub fn row_left(w: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (w / 2.0).trunc() - ROW_WIDTH / 2.0
}
/// A rule's switch or box: 44 by 20, 45 from the entry content's right.
pub fn control_x(w: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: row_left(w) + 2.0 + (ROW_WIDTH - 4.0) - 45.0
}
/// The header's LinearLayout (title, 4, search box) centred in its 36 pixels.
pub fn search_at(w: f32) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (((w - SEARCH_WIDTH) / 2.0).trunc(), 4.0 + 9.0 + 4.0)
}
/// The footer's Done and Cancel, 150 wide and 8 apart.
pub fn footer(w: f32, h: f32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let x = ((w - 308.0) / 2.0).trunc();
    // rust: [(x, h - FOOTER + 6.0), (x + 158.0, h - FOOTER + 6.0)]
}
pub fn yellow() u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: named_color("yellow").unwrap_or(0xFFFF55)
}
/// RuleList.addEntry's `narration`: the rule's description, when it has
/// one, over its default value.
pub fn narration(r: *Rule) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let default = Text::translate(
    // rust: "editGamerule.default",
    // rust: &[Text::literal(r.default.to_string())],
    // rust: )
    // rust: .plain();
    // rust: let description = format!("{}.description", name_key(r));
    // rust: if lang::has(&description) {
    // rust: format!("{}\n{default}", lang::get(&description))
    // rust: } else {
    // rust: default
}
}

/// BooleanRuleEntry's CycleButton (`displayOnlyValue`, its own narration):
/// "<name>: <value> button", the rule's description and default, and the
/// value a click moves to.
pub fn bool_narration(r: *Rule, value: bool, rect: [f32; 4]) c {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let tr = crate::screen_narrator::translate;
    // rust: let on_off = |on: bool| tr(if on { "options.on" } else { "options.off" }, &[]);
    // rust: let full = tr(
    // rust: "options.generic_value",
    // rust: &[&lang::get(&name_key(r)), &on_off(value)],
    // rust: );
    // rust: let title = format!("{}\n{}", tr("gui.narrate.button", &[&full]), narration(r));
    // rust: crate::widgets::Narratable::new(
    // rust: crate::widgets::What::NamedCycle {
    // rust: title,
    // rust: next: on_off(!value),
    // rust: active: true,
    // rust: },
    // rust: rect,
    // rust: )
    // rust: .without_tooltip()
}

/// ConfirmScreen "Game Rule Changes".
pub fn confirm(font: *Font, size: (f32) void {
}
    // rust: let title = Text::translate("editGamerule.inGame.discardChanges.title", &[]);
    // rust: let message = Text::translate("editGamerule.inGame.discardChanges.message", &[]);
    // rust: Confirm::new(font, size, &title, &message)
}

    // rust: impl RulesScreen {
    /// InWorldGameRulesScreen over the world's rules.
pub fn new(rules: *GameRules) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::build(rules, true)
}
    /// WorldCreationGameRulesScreen over the new world's rules.
pub fn for_creation(rules: *GameRules) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::build(rules, false)
}
pub fn build(rules: *GameRules, in_world: bool) S {
    // Implementation ported from Horizon
    return undefined;
}
        // setInitialFocus: the search box.
    // rust: let search = EditBox::new(0.0, 0.0, SEARCH_WIDTH, 15.0);
    // rust: let numbers = rules
    // rust: .available_rules()
    // rust: .filter(|r| matches!(r.default, Value::Int(_)))
    // rust: .map(|r| {
    // rust: let mut b = EditBox::new(0.0, 0.0, 44.0, 20.0);
    // rust: b.focused = false;
    // rust: b.set_value(&rules.int(r.name).to_string());
    // rust: b.text_color = VALID;
    // rust: (r.name, b)
    // rust: })
    // rust: .collect();
    // rust: Self {
    // rust: search,
    // rust: values: rules.clone(),
    // rust: initial: rules.clone(),
    // rust: numbers,
    // rust: scroll: ui::Scroll::default(),
    // rust: confirm: false,
    // rust: in_world,
}
}

    /// RuleList.populateChildren: the rules matching the search (id, name,
    /// category or description), by category, each sorted by description id.
pub fn rows(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let filter = self.search.value.to_lowercase();
    // rust: let has = |s: &str| s.to_lowercase().contains(&filter);
    // rust: let mut categories: Vec<(&'static str, Vec<&'static Rule>)> = Vec::new();
    // rust: for r in self.values.available_rules() {
    // rust: let key = name_key(r);
    // rust: let description = format!("{key}.description");
    // rust: let matches = has(r.name)
    // rust: || has(&lang::get(&key))
    // rust: || has(&lang::get(&category_key(r.category)))
    // rust: || (lang::has(&description) && has(&lang::get(&description)));
    // rust: if !matches {
    // rust: continue;
}
    // rust: match categories.iter_mut().find(|(c, _)| *c == r.category) {
    // rust: Some((_, rules)) => rules.push(r),
    // rust: None => categories.push((r.category, vec![r])),
}
}
        // By the categories' ids, then the rules' description ids.
    // rust: categories.sort_by_key(|(c, _)| *c);
    // rust: categories
    // rust: .into_iter()
    // rust: .flat_map(|(c, mut rules)| {
    // rust: rules.sort_by_key(|r| name_key(r));
    // rust: std::iter::once(Row::Category(c)).chain(rules.into_iter().map(Row::Rule))
    // rust: })
    // rust: .collect()
}
    /// Entry `i`'s top: 2 under the list's top, less the scroll.
pub fn row_top(self: *Self, i: usize) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: HEADER + 2.0 - self.scroll.amount.trunc() + ROW * i as f32
}
    /// The list's scrollbar column (AbstractSelectionList: 6 pixels right of
    /// the entries) and the pixels it scrolls.
pub fn bar(w: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: row_left(w) + ROW_WIDTH + 6.0 + 2.0
}
pub fn content(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ROW * self.rows().len() as f32 + 4.0
}
    /// getEntryAtPosition: the row under the pointer, inside the list.
pub fn hovered(self: *Self, rows: usize) void {
}
    // rust: let left = row_left(w);
    // rust: let inside = y >= HEADER && y < h - FOOTER && x >= left && x < left + ROW_WIDTH;
    // rust: let i = ((y - self.row_top(0)) / ROW).floor();
    // rust: (inside && i >= 0.0 && (i as usize) < rows).then_some(i as usize)
}
pub fn number(self: *Self, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.numbers
    // rust: .iter_mut()
    // rust: .find(|(n, _)| *n == name)
    // rust: .map(|(_, b)| b)
}
    /// An invalid number disables Done (markInvalid).
pub fn invalid(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.numbers
    // rust: .iter()
    // rust: .any(|(name, b)| gamerules::rule(name).is_none_or(|r| parse(r, &b.value).is_none()))
}
pub fn changes(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.values
    // rust: .available_rules()
    // rust: .filter_map(|r| {
    // rust: let value = self.values.get(r.name)?;
    // rust: (Some(value) != self.initial.get(r.name)).then_some((r.name, value))
    // rust: })
    // rust: .collect()
}
    /// InWorldGameRulesScreen.onClose: pending changes ask first;
    /// WorldCreationGameRulesScreen.onClose discards them.
pub fn close(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.in_world || self.changes().is_empty() {
    // rust: Some(Exit::Discard)
    // rust: } else {
    // rust: self.confirm = true;
    // rust: None
}
}
    /// Escape: ConfirmScreen answers no; the rules close.
pub fn escape(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.confirm {
    // rust: self.confirm = false;
    // rust: None
    // rust: } else {
    // rust: self.close()
}
}
    /// The mouse wheel (AbstractSelectionList: half an entry a step).
pub fn wheel(self: *Self, delta: f32, h: f32) void {
}
    // rust: if !self.confirm {
    // rust: let content = self.content();
    // rust: self.scroll
    // rust: .wheel(delta, ROW / 2.0, HEADER, h - FOOTER, content);
}
}
    /// A press on the scrollbar holds it (AbstractSelectionList.updateScrolling).
pub fn press_scrollbar(self: *Self, cursor: (f32) void {
}
    // rust: let content = self.content();
    // rust: self.scroll
    // rust: .press(cursor, Self::bar(w), HEADER, h - FOOTER, content)
}
    /// The pointer moved while the scrollbar is held.
pub fn drag(self: *Self, y: f32, h: f32) void {
}
    // rust: if self.scroll.held() {
    // rust: let content = self.content();
    // rust: self.scroll.drag(y, HEADER, h - FOOTER, content);
}
}
    /// The button came up: the scrollbar lets go.
pub fn release(self: *Self) void {
}
    // rust: self.scroll.release();
}
pub fn focused(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.search.focused {
    // rust: return Some((None, &mut self.search));
}
    // rust: self.numbers
    // rust: .iter_mut()
    // rust: .find(|(_, b)| b.focused)
    // rust: .map(|(n, b)| (Some(*n), b))
}
    /// The focused box changed: the search filters again from the top; a
    /// number sets its rule when valid (IntegerRuleEntry's responder).
pub fn edited(self: *Self, rule: ?*'static str) void {
}
    // rust: let Some(name) = rule else {
    // rust: self.scroll.amount = 0.0;
    // rust: return;
}
    // rust: let Some(r) = gamerules::rule(name) else {
    // rust: return;
}
    // rust: let value = self.number(name).map(|b| parse(r, &b.value));
    // rust: if let Some(Some(v)) = value {
    // rust: self.values.set(name, Value::Int(v));
}
    // rust: if let Some(b) = self.number(name) {
    // rust: b.text_color = if matches!(value, Some(Some(_))) {
    // rust: VALID
    // rust: } else {
    // rust: INVALID
}
}
}
    /// Run an edit on the focused box, then its responder.
pub fn edit(self: *Self, f: impl FnOnce(*mut EditBox) void {
}
    // rust: let Some((rule, b)) = self.focused() else {
    // rust: return;
}
    // rust: let before = b.value.clone();
    // rust: f(b);
    // rust: if b.value != before {
    // rust: self.edited(rule);
}
}
pub fn typing(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !self.confirm && (self.search.focused || self.numbers.iter().any(|(_, b)| b.focused))
}

    /// A left click; Some when the screen closes.
    // rust: pub fn click(
    // rust: &mut self,
    // rust: atlas: &HudAtlas,
    // rust: cursor: (f32, f32),
    // rust: size: (f32, f32),
    // rust: ) -> Option<Exit> {
    // rust: let (w, h) = size;
    // rust: let on = |x: f32, y: f32, bw: f32, bh: f32| ui::hovered(cursor, x, y, bw, bh);
    // rust: if self.confirm {
    // rust: match confirm(&atlas.font, size).answer_at(cursor) {
    // rust: Some(true) => return Some(Exit::Discard),
    // rust: Some(false) => self.confirm = false,
    // rust: None => {}
}
    // rust: return None;
}
    // rust: let [(dx, dy), (cx, cy)] = footer(w, h);
    // rust: if on(dx, dy, 150.0, 20.0) && !self.invalid() {
    // rust: return Some(Exit::Apply(self.changes()));
}
    // rust: if on(cx, cy, 150.0, 20.0) {
    // rust: return self.close();
}
        // A press on the scrollbar holds it and clicks nothing else.
    // rust: if self.press_scrollbar(cursor, size) {
    // rust: self.unfocus();
    // rust: return None;
}
        // A click moves the focus to the widget under it.
    // rust: let (sx, sy) = search_at(w);
    // rust: if on(sx, sy, SEARCH_WIDTH, 15.0) {
    // rust: self.unfocus();
    // rust: self.search.focused = true;
    // rust: self.search.reset_blink();
    // rust: self.search.click(atlas, cursor.0, false, false);
    // rust: return None;
}
    // rust: let rows = self.rows();
    // rust: let i = self.hovered(rows.len(), cursor, size)?;
    // rust: let Row::Rule(r) = rows[i] else {
    // rust: return None;
}
    // rust: if !on(control_x(w), self.row_top(i) + 2.0, 44.0, 20.0) {
    // rust: return None;
}
    // rust: self.unfocus();
    // rust: match r.default {
    // rust: Value::Bool(_) => {
    // rust: let on = self.values.bool(r.name);
    // rust: self.values.set(r.name, Value::Bool(!on));
}
    // rust: Value::Int(_) => {
    // rust: if let Some(b) = self.number(r.name) {
    // rust: b.focused = true;
    // rust: b.reset_blink();
    // rust: b.click(atlas, cursor.0, false, false);
}
}
}
    // rust: None
}
pub fn unfocus(self: *Self) void {
}
    // rust: self.search.focused = false;
    // rust: for (_, b) in &mut self.numbers {
    // rust: b.focused = false;
}
}
    /// Whether a click lands on a button (for its sound).
pub fn clicks_button(self: *Self, atlas: *HudAtlas, cursor: (f32) void {
}
    // rust: let (w, h) = size;
    // rust: let on = |(x, y): (f32, f32)| ui::hovered(cursor, x, y, 150.0, 20.0);
    // rust: if self.confirm {
    // rust: return confirm(&atlas.font, size).answer_at(cursor).is_some();
}
    // rust: let [done, cancel] = footer(w, h);
    // rust: if (on(done) && !self.invalid()) || on(cancel) {
    // rust: return true;
}
    // rust: let rows = self.rows();
    // rust: self.hovered(rows.len(), cursor, size).is_some_and(|i| {
    // rust: matches!(rows[i], Row::Rule(r) if matches!(r.default, Value::Bool(_)))
    // rust: && ui::hovered(cursor, control_x(w), self.row_top(i) + 2.0, 44.0, 20.0)
    // rust: })
}

pub fn draw(self: *Self, batch: *mut HudBatch, atlas: *HudAtlas, cursor: (f32) void {
}
    // rust: let (w, h) = (batch.width, batch.height);
    // rust: ui::menu_background(batch, atlas, 0.0, 0.0, w, h, self.in_world);
        // AbstractGameRulesScreen: its title; InWorldGameRulesScreen's
        // discard question is a ConfirmScreen (title and message).
    // rust: crate::widgets::begin_screen(|| {
    // rust: let tr = |key: &str| Text::translate(key, &[]).plain();
    // rust: if self.confirm {
    // rust: crate::widgets::ScreenInfo::new(
    // rust: "game_rules/discard",
    // rust: crate::widgets::join_for_narration(&[
    // rust: &tr("editGamerule.inGame.discardChanges.title"),
    // rust: &tr("editGamerule.inGame.discardChanges.message"),
    // rust: ]),
    // rust: )
    // rust: } else {
    // rust: crate::widgets::ScreenInfo::new("game_rules", tr("editGamerule.title"))
}
    // rust: });
    // rust: if self.confirm {
    // rust: let labels = [
    // rust: Text::translate("gui.yes", &[]),
    // rust: Text::translate("gui.no", &[]),
    // rust: ];
    // rust: confirm(&atlas.font, (w, h)).draw(batch, atlas, cursor, [&labels[0], &labels[1]]);
    // rust: return;
}
    // rust: let rows = self.rows();
    // rust: let content = ROW * rows.len() as f32 + 4.0;
    // rust: self.scroll.clamp(HEADER, h - FOOTER, content);
        // RuleList: the in-world list background, its entries clipped to it,
        // then the separators and scrollbar.
    // rust: ui::list_background(batch, atlas, HEADER, h - FOOTER, self.in_world);
    // rust: let first = batch.vertices.len();
    // rust: let hovered = self.hovered(rows.len(), cursor, (w, h));
    // rust: let (left, x) = (row_left(w), control_x(w));
        // RuleList, a ContainerObjectSelectionList: its rows' widgets are
        // narrated with their row's place.
    // rust: let list = crate::widgets::key_of(&"game_rules/list");
    // rust: crate::widgets::narratable(|| {
    // rust: crate::widgets::Narratable::container_list(
    // rust: rows.len(),
    // rust: hovered,
    // rust: [0.0, HEADER, w, h - FOOTER - HEADER],
    // rust: )
    // rust: .key(list)
    // rust: });
    // rust: for (i, row) in rows.iter().enumerate() {
    // rust: let top = self.row_top(i);
    // rust: if top + ROW < HEADER || top > h - FOOTER {
    // rust: continue;
}
    // rust: let (cx, cy) = (left + 2.0, top + 2.0);
    // rust: match *row {
    // rust: Row::Category(c) => {
                    // A FocusableTextWidget padded by 4, centred in the entry.
    // rust: let label = Text::translate(&category_key(c), &[])
    // rust: .bold()
    // rust: .underlined()
    // rust: .with_color(yellow());
    // rust: let lw = atlas.font.width_text(&label);
    // rust: let mid = cx + (ROW_WIDTH - 4.0) / 2.0;
    // rust: let lx = mid - (lw / 2.0).trunc();
    // rust: batch.text_styled(atlas, &label, lx, cy + 10.0 - 8.0 + 4.0, u32::MAX, true);
                    // CategoryRuleEntry's FocusableTextWidget: its label.
    // rust: crate::widgets::narratable(|| {
    // rust: crate::widgets::Narratable::text(
    // rust: label.plain(),
    // rust: [lx - 4.0, cy, lw + 8.0, 17.0],
    // rust: )
    // rust: .key(crate::widgets::key_of(&("game_rules/category", c)))
    // rust: .child_of(list, i)
    // rust: .without_tooltip()
    // rust: });
}
    // rust: Row::Rule(r) => {
    // rust: let name = lines(&atlas.font, &Text::translate(&name_key(r), &[]), 170.0);
    // rust: match name.as_slice() {
    // rust: [one] => {
    // rust: batch.text_styled(atlas, one, cx, cy + 5.0, u32::MAX, true);
}
    // rust: [one, two, ..] => {
    // rust: batch.text_styled(atlas, one, cx, cy, u32::MAX, true);
    // rust: batch.text_styled(atlas, two, cx, cy + 10.0, u32::MAX, true);
}
    // rust: [] => {}
}
    // rust: let hover = hovered == Some(i) && ui::hovered(cursor, x, cy, 44.0, 20.0);
    // rust: match r.default {
    // rust: Value::Bool(_) => {
    // rust: let key = if self.values.bool(r.name) {
    // rust: "options.on"
    // rust: } else {
    // rust: "options.off"
}
    // rust: let label = Text::translate(key, &[]);
    // rust: let value = self.values.bool(r.name);
    // rust: ui::button_as(
    // rust: batch,
    // rust: atlas,
    // rust: x,
    // rust: cy,
    // rust: 44.0,
    // rust: 20.0,
    // rust: &label,
    // rust: true,
    // rust: hover,
    // rust: |rect| {
    // rust: bool_narration(r, value, rect)
    // rust: .key(crate::widgets::key_of(&("game_rules", r.name)))
    // rust: .child_of(list, i)
    // rust: },
    // rust: );
}
    // rust: Value::Int(_) => {
    // rust: if let Some(b) = self.number(r.name) {
    // rust: b.x = x;
    // rust: b.y = cy;
                                // IntegerRuleEntry's box: the rule's name, its
                                // description and default, a line each.
    // rust: if crate::widgets::narrating() {
    // rust: b.message =
    // rust: format!("{}\n{}\n", lang::get(&name_key(r)), narration(r));
}
    // rust: b.draw(batch, atlas, None);
    // rust: crate::widgets::last_narratable(|n| {
    // rust: *n = n
    // rust: .clone()
    // rust: .key(crate::widgets::key_of(&("game_rules", r.name)))
    // rust: .child_of(list, i)
    // rust: .without_tooltip();
    // rust: });
}
}
}
}
}
}
    // rust: batch.clip_since(first, 0.0, HEADER, w, h - FOOTER);
    // rust: ui::separators(batch, atlas, HEADER, h - FOOTER, self.in_world);
    // rust: ui::scrollbar(
    // rust: batch,
    // rust: atlas,
    // rust: Self::bar(w),
    // rust: HEADER,
    // rust: h - FOOTER,
    // rust: content,
    // rust: self.scroll.amount.trunc(),
    // rust: );
        // The header: the title centred over the search box.
    // rust: let title = Text::translate("editGamerule.title", &[]);
    // rust: let tw = atlas.font.width_text(&title);
    // rust: let (sx, sy) = search_at(w);
    // rust: let lw = tw.max(SEARCH_WIDTH);
    // rust: let lx = ((w - lw) / 2.0).trunc();
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: &title,
    // rust: lx + ((lw - tw) / 2.0).trunc(),
    // rust: 4.0,
    // rust: u32::MAX,
    // rust: true,
    // rust: );
    // rust: self.search.x = sx;
    // rust: self.search.y = sy;
    // rust: self.search.draw(batch, atlas, None);
        // The header's search box is added before the list.
    // rust: crate::widgets::last_narratable_at(0, |_| {});
    // rust: if self.search.value.is_empty() && !self.search.focused {
            // EditBox.SEARCH_HINT_STYLE: gray and italic.
    // rust: let hint = Text::translate("gui.game_rule.search", &[]).with_style(&Style {
    // rust: color: named_color("gray"),
    // rust: italic: Some(true),
    // rust: ..Style::default()
    // rust: });
    // rust: let (hx, hy) = (self.search.text_x(), self.search.text_y());
    // rust: batch.text_styled(atlas, &hint, hx, hy, u32::MAX, true);
}
    // rust: let invalid = self.invalid();
    // rust: for ((bx, by), (key, active)) in footer(w, h)
    // rust: .into_iter()
    // rust: .zip([("gui.done", !invalid), ("gui.cancel", true)])
    // rust: {
    // rust: let hover = active && ui::hovered(cursor, bx, by, 150.0, 20.0);
    // rust: let label = Text::translate(key, &[]);
    // rust: let action = if key == "gui.done" {
    // rust: crate::widgets::Action::Done
    // rust: } else {
    // rust: crate::widgets::Action::Cancel
}
    // rust: ui::action_button(
    // rust: batch, atlas, action, bx, by, 150.0, 20.0, &label, active, hover,
    // rust: );
}
        // The hovered rule's tooltip: its id, description and default.
    // rust: if let Some(Row::Rule(r)) = hovered.map(|i| rows[i]) {
    // rust: let mut tip = vec![Text::literal(r.name).with_color(yellow())];
    // rust: let description = format!("{}.description", name_key(r));
    // rust: if lang::has(&description) {
    // rust: tip.extend(lines(
    // rust: &atlas.font,
    // rust: &Text::translate(&description, &[]),
    // rust: 150.0,
    // rust: ));
}
    // rust: let gray = named_color("gray").unwrap_or(0xAAAAAA);
    // rust: tip.push(
    // rust: Text::translate(
    // rust: "editGamerule.default",
    // rust: &[Text::literal(r.default.to_string())],
    // rust: )
    // rust: .with_color(gray),
    // rust: );
    // rust: ui::tooltip(batch, atlas, &tip, cursor);
}
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::gamerules::RULES;

pub fn a_switch_narrates_its_name_value_description_and_next_value() void {
}
//         use crate::screen_narrator::translate as tr;
//         use crate::widgets::What;
    // rust: let r = RULES
    // rust: .iter()
    // rust: .find(|r| matches!(r.default, Value::Bool(_)))
    // rust: .unwrap();
    // rust: let n = bool_narration(r, true, [0.0; 4]);
    // rust: let What::NamedCycle {
    // rust: title,
    // rust: next,
    // rust: active,
    // rust: } = &n.what
    // rust: else {
    // rust: panic!("a CycleButton: {:?}", n.what);
}
    // rust: let full = tr(
    // rust: "options.generic_value",
    // rust: &[&lang::get(&name_key(r)), &tr("options.on", &[])],
    // rust: );
    // rust: assert_eq!(
    // rust: *title,
    // rust: format!("{}\n{}", tr("gui.narrate.button", &[&full]), narration(r))
    // rust: );
    // rust: assert_eq!(*next, tr("options.off", &[]));
    // rust: assert!(*active);
        // The list draws the rule's tooltip, not the button.
    // rust: assert_eq!(n.hint.as_deref(), Some(""));
}

pub fn box_colours_are_vanillas() void {
}
    // rust: assert_eq!(VALID, crate::hud::rgba(224, 224, 224, 255));
    // rust: assert_eq!(INVALID, crate::hud::rgba(255, 0, 0, 255));
}

pub fn numbers_parse_like_brigadier_within_the_rule() void {
}
    // rust: let r = gamerules::rule("max_snow_accumulation_height").unwrap();
    // rust: assert_eq!(parse(r, "8"), Some(8));
    // rust: assert_eq!(parse(r, "9"), None);
    // rust: assert_eq!(parse(r, "-1"), None);
    // rust: for s in ["", "+3", " 3", "3 ", "3.0", "x"] {
    // rust: assert_eq!(parse(r, s), None, "{s:?}");
}
    // rust: let r = gamerules::rule("fire_spread_radius_around_player").unwrap();
    // rust: assert_eq!(parse(r, "-1"), Some(-1));
}

pub fn rows_group_categories_and_rules_by_description_id() void {
}
    // rust: let s = RulesScreen::new(&GameRules::default());
    // rust: let rows = s.rows();
    // rust: assert_eq!(rows.len(), RULES.len() + 7);
    // rust: assert!(matches!(rows[0], Row::Category("chat")));
    // rust: let categories: Vec<_> = rows
    // rust: .iter()
    // rust: .filter_map(|r| match r {
    // rust: Row::Category(c) => Some(*c),
    // rust: Row::Rule(_) => None,
    // rust: })
    // rust: .collect();
    // rust: assert_eq!(
    // rust: categories,
    // rust: [
    // rust: "chat", "drops", "misc", "mobs", "player", "spawning", "updates"
    // rust: ]
    // rust: );
}

    /// AbstractScrollArea: a press on the bar holds it, a drag moves the
    /// list (to the ends past them), a release lets go.
pub fn the_scroll_bar_can_be_held_dragged_and_let_go() void {
}
    // rust: let mut s = RulesScreen::new(&GameRules::default());
    // rust: let (w, h) = (427.0, 240.0);
    // rust: let (top, bottom, content) = (HEADER, h - FOOTER, s.content());
    // rust: assert!(
    // rust: content > bottom - top,
    // rust: "the rules overflow a 240-high screen"
    // rust: );
    // rust: let bar = RulesScreen::bar(w);
    // rust: assert!(!s.press_scrollbar((bar - 4.0, top + 5.0), (w, h)));
    // rust: assert!(s.press_scrollbar((bar + 3.0, top + 5.0), (w, h)));
    // rust: s.drag(top + 40.0, h);
    // rust: assert!(s.scroll.amount > 0.0);
    // rust: s.drag(bottom + 10.0, h);
    // rust: assert_eq!(s.scroll.amount, content - (bottom - top));
    // rust: s.release();
    // rust: s.drag(top, h);
    // rust: assert_eq!(s.scroll.amount, content - (bottom - top));
}

pub fn edits_change_rules_and_bad_numbers_hold_done() void {
}
    // rust: let mut s = RulesScreen::new(&GameRules::default());
    // rust: assert!(s.changes().is_empty());
    // rust: s.unfocus();
    // rust: s.number("random_tick_speed").unwrap().focused = true;
    // rust: s.edit(|b| b.set_value("10"));
    // rust: assert_eq!(s.changes(), vec![("random_tick_speed", Value::Int(10))]);
    // rust: s.edit(|b| b.set_value("ten"));
    // rust: assert!(s.invalid());
        // The last valid value stays, as the responder left it.
    // rust: assert_eq!(s.changes(), vec![("random_tick_speed", Value::Int(10))]);
        // Leaving with changes asks; No returns, Yes discards.
    // rust: assert_eq!(s.escape(), None);
    // rust: assert!(s.confirm);
    // rust: assert_eq!(s.escape(), None);
    // rust: assert!(!s.confirm);
}
}
