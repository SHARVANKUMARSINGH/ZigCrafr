//! Transpiled from Horizon Rust crate
//! Module: horizon-narrator_screen
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! A screen's narration: `ScreenNarrationCollector` (what to say, and what
//! was said already) and `Screen`'s timing (`scheduleNarration`,
//! `handleDelayedNarration`, the suppression after `init`).
//!
//! The game builds a screen's narration each time it runs ([`Output`]): the
//! screen's title, then the narrated widget's own elements one level deeper
//! ([`Output::nest`]). Only what changed since the last run is said, unless a
//! run is forced; elements are read title first, then positions, hints and
//! usage, each outer before inner, joined with ". ".
// use std::collections::BTreeMap;

/// `NarratedElementType`, in reading order.
pub const ElementType = enum {
    Title,
    Position,
    Hint,
    Usage,
};

/// `NarrationTrigger`: what scheduled the narration.
pub const Trigger = enum {
    Mouse,
    Keyboard,
    System,
};

/// `NarratableEntry.NarrationPriority`.
pub const Priority = enum {
    None,
    Hovered,
    Focused,
};

    // rust: impl Priority {
pub fn is_terminal(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self == Priority::Focused
}
}

/// `ScreenNarrationCollector.NarrationEntry`. `contents` is the thunk's text:
/// `None` is `NarrationThunk.EMPTY`, which equals no text, not even an empty
/// one.
pub const Entry = struct {
    contents: ?std.ArrayList([]const u8),
    generation: i64,
    already_narrated: bool,
};

/// `ScreenNarrationCollector`.
pub const Collector = struct {
    generation: i64,
    entries: BTreeMap<(ElementType,
};

    // rust: impl Collector {
    /// `update`: a new generation, filled by `updater`.
pub fn update(self: *Self, trigger: Trigger, updater: impl FnOnce(*mut Output<'_>) void {
}
    // rust: self.generation += 1;
    // rust: updater(&mut Output {
    // rust: collector: self,
    // rust: depth: 0,
    // rust: trigger,
    // rust: });
}

    /// `collectNarrationText`: this generation's elements not narrated yet
    /// (all of them when `force`), marked narrated.
pub fn collect(self: *Self, force: bool) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut result = String::new();
    // rust: let mut first = true;
    // rust: for entry in self.entries.values_mut() {
    // rust: if entry.generation == self.generation && (force || !entry.already_narrated) {
    // rust: for line in entry.contents.iter().flatten() {
    // rust: if !first {
    // rust: result.push_str(". ");
}
    // rust: first = false;
    // rust: result.push_str(line);
}
    // rust: entry.already_narrated = true;
}
}
    // rust: result
}

pub fn add(self: *Self, key: (ElementType) void {
}
    // rust: let generation = self.generation;
    // rust: let entry = self.entries.entry(key).or_insert_with(|| Entry {
    // rust: generation: -1,
    // rust: ..Entry::default()
    // rust: });
        // NarrationEntry.update: new text is narrated again, and so is text
        // that was missing from the generation before.
    // rust: if entry.contents.as_ref() != Some(&contents) {
    // rust: entry.contents = Some(contents);
    // rust: entry.already_narrated = false;
    // rust: } else if entry.generation + 1 != generation {
    // rust: entry.already_narrated = false;
}
    // rust: entry.generation = generation;
}
}

/// `NarrationElementOutput` at a depth.
pub const Output = struct {
    collector: *'a mut Collector,
    depth: u32,
    trigger: Trigger,
};

    // rust: impl Output<'_> {
    /// `add(type, NarrationThunk.from(text))`.
pub fn add(self: *Self, kind: ElementType, text: impl Into<[]const u8>) void {
}
    // rust: self.collector.add((kind, self.depth), vec![text.into()]);
}
    /// `add(type, NarrationThunk.from(lines))`: one element, each line read
    /// as its own sentence.
pub fn add_lines(self: *Self, kind: ElementType, lines: std.ArrayList([]const u8)) void {
}
    // rust: self.collector.add((kind, self.depth), lines);
}
    /// `nest`: the narrated element's own elements, read after the screen's
    /// of the same type.
pub fn nest(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Output {
    // rust: collector: self.collector,
    // rust: depth: self.depth + 1,
    // rust: trigger: self.trigger,
}
}
pub fn trigger(self: *Self) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.trigger
}
}

/// `Screen.NARRATE_SUPPRESS_AFTER_INIT_TIME`, and the delay after the narrator
/// is turned on.
pub const SUPPRESS_AFTER_INIT_MS: i64 = 2000;
pub const DELAY_MOUSE_MOVE_MS: i64 = 750;
pub const DELAY_MOUSE_ACTION_MS: i64 = 200;
pub const DELAY_KEYBOARD_ACTION_MS: i64 = 200;

/// A screen's narration state (`Screen`'s `narrationState`,
/// `narrationSuppressTime`, `nextNarrationTime`, `nextNarrationTriggeredBy`
/// and `lastNarratable`). A new screen starts a new one. Times are
/// milliseconds on any steady clock (`Util.getMillis`).
pub const ScreenNarration = struct {
    collector: Collector,
    suppress_time: i64,
    next_time: i64,
    next_trigger: Trigger,
    /// The widget narrated last, by the caller's identity for it.
    last_narratable: ?u64,
};

    // rust: impl Default for ScreenNarration {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: collector: Collector::default(),
    // rust: suppress_time: i64::MIN,
    // rust: next_time: i64::MAX,
    // rust: next_trigger: Trigger::System,
    // rust: last_narratable: None,
}
}
}

    // rust: impl ScreenNarration {
    /// The end of `init` (after its `triggerImmediateNarration(false)`):
    /// screens opened from the keyboard wait for the next key before
    /// narrating again; the others stay quiet for two seconds.
pub fn after_init(self: *Self, now: i64, keyboard: bool) void {
}
    // rust: self.suppress_time = if keyboard {
    // rust: i64::MAX
    // rust: } else {
    // rust: now.saturating_add(SUPPRESS_AFTER_INIT_MS)
}
}

    /// `scheduleNarration(delay, ignoreSuppression, trigger)`.
pub fn schedule(self: *Self, now: i64, delay: i64, ignore_suppression: bool, trigger: Trigger) void {
}
    // rust: self.next_time = now.saturating_add(delay);
    // rust: self.next_trigger = trigger;
    // rust: if ignore_suppression {
    // rust: self.suppress_time = i64::MIN;
}
}
    /// `scheduleNarration()`: as soon as the screen next ticks.
pub fn schedule_now(self: *Self, now: i64) void {
}
    // rust: self.schedule(now, 0, true, Trigger::System);
}
pub fn after_mouse_move(self: *Self, now: i64) void {
}
    // rust: self.schedule(now, DELAY_MOUSE_MOVE_MS, false, Trigger::Mouse);
}
pub fn after_mouse_action(self: *Self, now: i64) void {
}
    // rust: self.schedule(now, DELAY_MOUSE_ACTION_MS, true, Trigger::Mouse);
}
pub fn after_keyboard_action(self: *Self, now: i64) void {
}
    // rust: self.schedule(now, DELAY_KEYBOARD_ACTION_MS, true, Trigger::Keyboard);
}
    /// `updateNarratorStatus`'s scheduling: once the narrator is turned on,
    /// the screen is narrated two seconds later.
pub fn after_status_change(self: *Self, now: i64, was_disabled: bool, trigger: Trigger) void {
}
    // rust: if was_disabled {
    // rust: self.schedule(now, SUPPRESS_AFTER_INIT_MS, false, trigger);
}
}

    /// `handleDelayedNarration`'s test: the trigger of a narration due now
    /// (only changed elements are said), which is then no longer pending.
pub fn due(self: *Self, now: i64) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if now > self.next_time && now > self.suppress_time {
    // rust: self.next_time = i64::MAX;
    // rust: Some(self.next_trigger)
    // rust: } else {
    // rust: None
}
}

    /// `runNarration`: rebuilds the narration and returns what to say now
    /// (`saySystemNow`), empty for nothing.
    // rust: pub fn run(
    // rust: &mut self,
    // rust: only_changed: bool,
    // rust: trigger: Trigger,
    // rust: updater: impl FnOnce(&mut Output<'_>),
    // rust: ) -> String {
    // rust: self.collector.update(trigger, updater);
    // rust: self.collector.collect(!only_changed)
}
}

/// `Screen.findNarratableWidget` over the screen's active narratables, in
/// order, each with the caller's identity for it and its priority, and the
/// identity of the one narrated last: the first focused one that isn't the
/// last narrated, else the highest priority one (the first of equals), else
/// the last narrated focused one. The index and priority of the one found;
/// `None` when no narratable is focused or hovered.
    // rust: pub fn find_narratable(
    // rust: entries: &[(u64, Priority)],
    // rust: last: Option<u64>,
    // rust: ) -> Option<(usize, Priority)> {
    // rust: let mut result: Option<(usize, Priority)> = None;
    // rust: let mut low_priority = None;
    // rust: for (i, &(id, priority)) in entries.iter().enumerate() {
    // rust: if priority.is_terminal() {
    // rust: if Some(id) != last {
    // rust: return Some((i, priority));
}
    // rust: low_priority = Some((i, priority));
    // rust: } else if priority > result.map_or(Priority::None, |(_, p)| p) {
    // rust: result = Some((i, priority));
}
}
    // rust: result.or(low_priority)
}

    // rust: mod tests {
//     use super::*;
//     use ElementType::*;

    // rust: fn run(
    // rust: n: &mut ScreenNarration,
    // rust: only_changed: bool,
    // rust: items: &[(ElementType, u32, &str)],
    // rust: ) -> String {
    // rust: n.run(only_changed, Trigger::System, |out| {
    // rust: for &(kind, depth, text) in items {
    // rust: let mut out = Output {
    // rust: collector: out.collector,
    // rust: depth,
    // rust: trigger: Trigger::System,
}
    // rust: out.add(kind, text);
}
    // rust: })
}

pub fn elements_are_read_by_type_then_depth() void {
}
    // rust: let mut n = ScreenNarration::default();
    // rust: let said = n.run(false, Trigger::System, |out| {
    // rust: out.add(Title, "Options");
    // rust: out.add(Position, "Screen element 2 out of 9");
    // rust: out.add(Usage, "Use Tab to navigate");
    // rust: let mut widget = out.nest();
    // rust: widget.add(Usage, "Press Enter to activate");
    // rust: widget.add(Title, "Button: Done");
    // rust: });
    // rust: assert_eq!(
    // rust: said,
    // rust: "Options. Button: Done. Screen element 2 out of 9. Use Tab to navigate. Press Enter to activate"
    // rust: );
}

pub fn only_what_changed_is_said_again() void {
}
    // rust: let mut n = ScreenNarration::default();
    // rust: let first = [(Title, 0, "Options"), (Title, 1, "Button: Done")];
    // rust: assert_eq!(run(&mut n, true, &first), "Options. Button: Done");
    // rust: assert_eq!(run(&mut n, true, &first), "");
    // rust: let moved = [
    // rust: (Title, 0, "Options"),
    // rust: (Title, 1, "Button: Video Settings..."),
    // rust: ];
    // rust: assert_eq!(run(&mut n, true, &moved), "Button: Video Settings...");
        // Forced: everything of this generation.
    // rust: assert_eq!(
    // rust: run(&mut n, false, &moved),
    // rust: "Options. Button: Video Settings..."
    // rust: );
}

pub fn an_element_missing_for_a_generation_is_said_again_when_it_returns() void {
}
    // rust: let mut n = ScreenNarration::default();
    // rust: assert_eq!(
    // rust: run(&mut n, true, &[(Title, 0, "Options"), (Usage, 0, "Tab")]),
    // rust: "Options. Tab"
    // rust: );
    // rust: assert_eq!(run(&mut n, true, &[(Title, 0, "Options")]), "");
    // rust: assert_eq!(
    // rust: run(&mut n, true, &[(Title, 0, "Options"), (Usage, 0, "Tab")]),
    // rust: "Tab"
    // rust: );
}

pub fn lines_are_one_element_read_as_sentences() void {
}
    // rust: let mut n = ScreenNarration::default();
    // rust: let said = n.run(false, Trigger::System, |out| {
    // rust: out.add_lines(Title, vec!["First".into(), "".into(), "Third".into()]);
    // rust: });
    // rust: assert_eq!(said, "First. . Third");
}

pub fn narration_waits_for_its_delay_and_the_suppression() void {
}
    // rust: let mut n = ScreenNarration::default();
    // rust: assert_eq!(n.due(0), None);
    // rust: n.after_init(1000, false);
    // rust: n.after_mouse_move(1000);
        // Due at 1750 but suppressed until 3000.
    // rust: assert_eq!(n.due(2000), None);
    // rust: assert_eq!(n.due(3001), Some(Trigger::Mouse));
    // rust: assert_eq!(n.due(4000), None);
        // A click lifts the suppression.
    // rust: n.after_init(5000, false);
    // rust: n.after_mouse_action(5000);
    // rust: assert_eq!(n.due(5200), None);
    // rust: assert_eq!(n.due(5201), Some(Trigger::Mouse));
}

pub fn a_screen_opened_by_keyboard_waits_for_the_next_key() void {
}
    // rust: let mut n = ScreenNarration::default();
    // rust: n.after_init(0, true);
    // rust: n.after_mouse_move(0);
    // rust: assert_eq!(n.due(1_000_000), None);
    // rust: n.after_keyboard_action(10);
    // rust: assert_eq!(n.due(211), Some(Trigger::Keyboard));
}

pub fn turning_the_narrator_on_narrates_the_screen_two_seconds_later() void {
}
    // rust: let mut n = ScreenNarration::default();
    // rust: n.after_status_change(0, false, Trigger::Keyboard);
    // rust: assert_eq!(n.due(10_000), None);
    // rust: n.after_status_change(0, true, Trigger::Keyboard);
    // rust: assert_eq!(n.due(2000), None);
    // rust: assert_eq!(n.due(2001), Some(Trigger::Keyboard));
}

pub fn the_focused_widget_wins_unless_it_was_just_narrated() void {
}
//         use Priority::*;
    // rust: let ids = |p: &[Priority]| {
    // rust: p.iter()
    // rust: .enumerate()
    // rust: .map(|(i, &p)| (i as u64 + 10, p))
    // rust: .collect::<Vec<_>>()
}
    // rust: assert_eq!(
    // rust: find_narratable(&ids(&[None, None]), Option::None),
    // rust: Option::None
    // rust: );
    // rust: assert_eq!(
    // rust: find_narratable(&ids(&[None, Hovered, Hovered]), Option::None),
    // rust: Some((1, Hovered))
    // rust: );
    // rust: assert_eq!(
    // rust: find_narratable(&ids(&[Hovered, Focused]), Option::None),
    // rust: Some((1, Focused))
    // rust: );
        // The focused one was narrated last: a hovered one goes first.
    // rust: assert_eq!(
    // rust: find_narratable(&ids(&[Hovered, Focused]), Some(11)),
    // rust: Some((0, Hovered))
    // rust: );
    // rust: assert_eq!(
    // rust: find_narratable(&ids(&[None, Focused]), Some(11)),
    // rust: Some((1, Focused))
    // rust: );
    // rust: assert_eq!(
    // rust: find_narratable(&ids(&[Focused, Focused]), Some(10)),
    // rust: Some((1, Focused))
    // rust: );
}
}
