//! Transpiled from Horizon Rust crate
//! Module: horizon-client_ui_control
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The widget tree of the open screen for agents (`ui`, `click ID`, `set ID
//! VALUE`; docs/agent-control.md): what the last frame drew, with ids, and
//! clicks that go through the same window events as the mouse.
// use super::event_loop::EventLoopCtl;
// use super::{Game, Screen, agent::Handled};
// use horizon_client::{
    // rust: Result,
    // rust: control::Request,
    // rust: creative::Creative,
    // rust: widgets::{self, Kind, Node},
}
// use serde_json::{Value, json};
// use std::{
    // rust: sync::mpsc::Sender,
    // rust: time::{Duration, Instant},
}
// use winit::event::MouseButton;

    // rust: pub(super) const HELP: &[&str] = &[
    // rust: "ui                             every widget of the open screen: id, kind, label, bounds, value",
    // rust: "click ID [right|middle] [shift] click a widget of ui by its id (slot-N: as click-slot N)",
    // rust: "set ID VALUE                   move a slider to VALUE (0..1), as a click on its track",
    // rust: ];

/// After a click, `ui`, `click` and `set` wait for a frame drawn since, so
/// they never read the screen the click left.
    // rust: pub(super) struct UiWait {
    /// The widget generation at the last click, and when it happened.
    // rust: after: Option<(u64, Instant)>,
    // rust: waiting: Vec<Request>,
}

    // rust: impl UiWait {
pub fn stale(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.after.is_some_and(|(generation, at)| {
    // rust: generation == widgets::generation() && at.elapsed() < Duration::from_secs(1)
    // rust: })
}
    /// The commands that can run now.
    // rust: pub(super) fn ready(&mut self) -> Vec<Request> {
    // rust: if self.stale() {
    // rust: return Vec::new();
}
    // rust: self.after = None;
    // rust: std::mem::take(&mut self.waiting)
}
    /// The screen changed: widget commands wait for it to be drawn again.
    // rust: pub(super) fn clicked(&mut self) {
    // rust: self.after = Some((widgets::generation(), Instant::now()));
}
}

    // rust: impl Game<'_> {
    /// The open screen's widgets: those the last frame drew, then the slots
    /// of an open inventory or menu (`slot-ID`, the ids of `click-slot`).
    // rust: pub(super) fn ui_nodes(&self) -> Vec<Node> {
    // rust: let size = self.gui_scale().map(|b| [b.width, b.height]);
    // rust: let mut nodes = widgets::tree(&widgets::last_labelled(), &widgets::last_targets(), size);
    // rust: if matches!(self.screen, Screen::Inventory | Screen::Creative)
    // rust: && self.title.is_none()
    // rust: && self.book.is_none()
    // rust: && let Ok((ox, oy)) = self.gui_origin()
    // rust: {
    // rust: nodes.extend(self.slots().into_iter().map(|i| {
    // rust: let (x, y) = self.slot_position(i);
    // rust: Node {
    // rust: id: format!("slot-{i}"),
    // rust: kind: Kind::Slot,
    // rust: label: None,
    // rust: rect: [ox + x, oy + y, 16.0, 16.0],
    // rust: enabled: true,
}
    // rust: }));
}
    // rust: nodes
}

pub fn node_value(self: *Self, node: *Node) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut v = json!({
    // rust: "id": node.id,
    // rust: "kind": node.kind.name(),
    // rust: "bounds": node.rect,
    // rust: "enabled": node.enabled,
    // rust: });
    // rust: if let Some(label) = &node.label {
    // rust: v["label"] = json!(label);
}
    // rust: match node.kind {
    // rust: Kind::Slider { value, .. } => v["value"] = json!(value),
    // rust: Kind::Tab(selected) => v["selected"] = json!(selected),
    // rust: Kind::Slot => {
    // rust: if let Some(slot) = node.id.strip_prefix("slot-").and_then(|s| s.parse().ok()) {
    // rust: let stack = if slot == 200 {
    // rust: self.craft_result()
    // rust: } else if slot >= Creative::DISPLAY {
                        // An item tab's display slot shows the tab's list.
    // rust: let first = self.creative_screen.first_row(&self.pack.names);
    // rust: self.creative_screen
    // rust: .shown(&self.pack.names, first * 9 + slot - Creative::DISPLAY)
    // rust: } else {
    // rust: self.slot_mut(slot).clone()
}
    // rust: v["stack"] = stack.map_or(Value::Null, |s| self.stack_value(&s));
}
}
    // rust: _ => {}
}
    // rust: v
}

pub fn find_node(self: *Self, id: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let nodes = self.ui_nodes();
    // rust: nodes.iter().find(|n| n.id == id).cloned().ok_or_else(|| {
    // rust: let ids: Vec<&str> = nodes.iter().map(|n| n.id.as_str()).collect();
    // rust: format!(
    // rust: "no widget {id:?} on the {} screen; widgets: {ids:?}",
    // rust: self.screen_label()
    // rust: )
    // rust: .into()
    // rust: })
}

    /// `ui`, `click` and `set`; `Handled::No` for other commands.
    // rust: pub(super) fn ui_command(
    // rust: &mut self,
    // rust: words: &[&str],
    // rust: line: &str,
    // rust: reply: &Sender<String>,
    // rust: event_loop: &dyn EventLoopCtl,
    // rust: ) -> Result<Handled> {
    // rust: if !matches!(words[0], "ui" | "click" | "set") {
    // rust: return Ok(Handled::No);
}
    // rust: if self.ui_wait.stale() {
    // rust: self.ui_wait.waiting.push(Request {
    // rust: line: line.to_owned(),
    // rust: reply: reply.clone(),
    // rust: });
    // rust: return Ok(Handled::Deferred);
}
    // rust: let id = || words.get(1).copied().ok_or("missing the widget id; see ui");
    // rust: match words[0] {
    // rust: "ui" => {
    // rust: let nodes = self.ui_nodes();
    // rust: let widgets: Vec<Value> = nodes.iter().map(|n| self.node_value(n)).collect();
    // rust: let size = self
    // rust: .gui_scale()
    // rust: .map(|b| [b.width.round(), b.height.round()]);
    // rust: Ok(Handled::Reply(json!({
    // rust: "screen": self.screen_label(),
    // rust: "gui_size": size,
    // rust: "frame": widgets::generation(),
    // rust: "widgets": widgets,
    // rust: })))
}
    // rust: "click" => {
    // rust: let node = self.find_node(id()?)?;
    // rust: if !node.enabled {
    // rust: return Err(format!("widget {:?} is disabled", node.id).into());
}
    // rust: let right = words.contains(&"right");
    // rust: let middle = words.contains(&"middle");
    // rust: if node.kind == Kind::Slot && !middle {
    // rust: let slot = node.id.trim_start_matches("slot-");
    // rust: let mut click = vec!["click-slot", slot];
    // rust: click.extend(words.iter().filter(|w| matches!(**w, "right" | "shift")));
    // rust: self.station_command(&click)?;
    // rust: } else {
    // rust: let (x, y) = (
    // rust: node.rect[0] + node.rect[2] / 2.0,
    // rust: node.rect[1] + node.rect[3] / 2.0,
    // rust: );
                    // The middle button goes through the window's own
                    // events at the widget's centre, slots included.
    // rust: let button = if middle {
    // rust: MouseButton::Middle
    // rust: } else if right {
    // rust: MouseButton::Right
    // rust: } else {
    // rust: MouseButton::Left
}
    // rust: self.synth_click(event_loop, x, y, button)?;
}
    // rust: self.ui_wait.clicked();
    // rust: Ok(Handled::Reply(
    // rust: json!({ "ok": true, "clicked": node.id, "screen": self.screen_label() }),
    // rust: ))
}
    // rust: "set" => {
    // rust: let node = self.find_node(id()?)?;
    // rust: let value: f32 = words
    // rust: .get(2)
    // rust: .ok_or("set ID VALUE: missing the value")?
    // rust: .parse()
    // rust: .map_err(|_| "set ID VALUE: the value is a number from 0 to 1")?;
    // rust: let Kind::Slider { track, .. } = node.kind else {
    // rust: return Err(format!(
    // rust: "widget {:?} is a {}; set moves sliders (click a button, type into a field)",
    // rust: node.id,
    // rust: node.kind.name()
    // rust: )
    // rust: .into());
}
    // rust: if !node.enabled {
    // rust: return Err(format!("widget {:?} is disabled", node.id).into());
}
                // AbstractSliderButton.setValueFromMouse: (x - track start) / track width.
    // rust: let x = track[0] + value.clamp(0.0, 1.0) * track[1];
    // rust: let y = node.rect[1] + node.rect[3] / 2.0;
    // rust: self.synth_click(event_loop, x, y, MouseButton::Left)?;
    // rust: self.ui_wait.clicked();
    // rust: Ok(Handled::Reply(
    // rust: json!({ "ok": true, "set": node.id, "screen": self.screen_label() }),
    // rust: ))
}
    // rust: _ => Ok(Handled::No),
}
}
}
