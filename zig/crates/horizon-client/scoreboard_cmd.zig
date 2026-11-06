//! Transpiled from Horizon Rust crate
//! Module: horizon-client_scoreboard_cmd
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Execution of `/scoreboard`, `/team` and `/trigger` (ScoreboardCommand,
//! TeamCommand, TriggerCommand, `CommandResponseTracker`) against a
//! [`Scoreboard`], with the world supplied through [`Env`].
// use crate::{
    // rust: command::{
    // rust: Arg, CmdResult, CommandError, Context,
    // rust: args::{ScoreHolderArg, Selector},
    // rust: },
    // rust: scoreboard::{
    // rust: self as sb, Comp, NumberFormat, RenderType, Scoreboard, Visibility, comp_text,
    // rust: criteria_read_only, literal,
    // rust: },
    // rust: text::{self, Text},
}

/// A score holder a command resolved: the scoreboard name and the name
/// shown in feedback.
pub const Holder = struct {
    name: []const u8,
    text: Text,
    /// The entity display name (`ScoreHolder.getDisplayName`), if it has one.
    display: ?Comp,
};
    // rust: impl Holder {
pub fn named(name: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: name: name.to_owned(),
    // rust: text: Text::literal(name),
    // rust: display: None,
}
}
}
/// What the commands need from the game.
    // rust: pub trait Env {
pub fn sb(self: *Self) *;
pub fn sb_mut(self: *Self) *;
    /// The holders a selector finds.
pub fn select(self: *Self, selector: *Selector) V;
    /// A holder from a plain name (a player, a UUID, or just a name).
pub fn named(self: *Self, name: []const u8) H;
    /// The executing entity; `player` is whether it is the player.
pub fn source(self: *Self) O;
    /// `ComponentArgument.getResolvedComponent`: selectors and scores resolved.
pub fn resolve(self: *Self, c: Comp) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: c
}
pub fn feedback(self: *Self, message: Text) void;
}

pub fn err(key: []const u8, args: *[*dyn std::fmt::Display]) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: CommandError::tr(key, args)
}
/// `ComponentUtils.formatList` with the gray ", " separator.
pub fn format_list(items: std.ArrayList(Text)) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Text::empty();
    // rust: for (i, t) in items.into_iter().enumerate() {
    // rust: if i > 0 {
    // rust: out.push(Text::literal(", ").with_color(text::GRAY));
}
    // rust: out.push(t);
}
    // rust: out
}
/// `ComponentUtils.formatList(Collection<String>)`: sorted, green.
pub fn format_names(names: std.ArrayList([]const u8)) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut names = names;
    // rust: names.sort();
    // rust: format_list(
    // rust: names
    // rust: .into_iter()
    // rust: .map(|n| Text::literal(n).with_color(text::GREEN))
    // rust: .collect(),
    // rust: )
}

/// `CommandResponseTracker`.
pub const Tracker = struct {
    total: i32,
    count: usize,
    only: ?Holder,
    nz_count: usize,
    nz_only: ?Holder,
};
    // rust: impl Tracker {
pub fn track(self: *Self, h: *Holder, value: i32) void {
}
    // rust: self.total = self.total.wrapping_add(value);
    // rust: self.count += 1;
    // rust: self.only = (self.count == 1).then(|| h.clone());
    // rust: if value != 0 {
    // rust: self.nz_count += 1;
    // rust: self.nz_only = (self.nz_count == 1).then(|| h.clone());
}
}
pub fn mark(self: *Self, h: *Holder) void {
}
    // rust: self.track(h, 1);
}
pub fn total(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.total
}
    /// `sendFeedback`: `zero` fails when nothing counts; `single` and
    /// `multiple` build the message.
    // rust: pub fn send(
    // rust: &self,
    // rust: env: &mut dyn Env,
    // rust: any: bool,
    // rust: zero: Option<CommandError>,
    // rust: single: impl Fn(&Holder, i32) -> Text,
    // rust: multiple: impl Fn(usize, i32) -> Text,
    // rust: ) -> CmdResult<i32> {
    // rust: let (message, total) = self.message(any, zero, single, multiple)?;
    // rust: env.feedback(message);
    // rust: Ok(total)
}
    /// The feedback `send` would produce, and the command's result.
    // rust: pub fn message(
    // rust: &self,
    // rust: any: bool,
    // rust: zero: Option<CommandError>,
    // rust: single: impl Fn(&Holder, i32) -> Text,
    // rust: multiple: impl Fn(usize, i32) -> Text,
    // rust: ) -> CmdResult<(Text, i32)> {
    // rust: let (only, count) = if any {
    // rust: (&self.only, self.count)
    // rust: } else {
    // rust: (&self.nz_only, self.nz_count)
}
    // rust: if let Some(e) = zero
    // rust: && count == 0
    // rust: {
    // rust: return Err(e);
}
    // rust: let message = match only {
    // rust: Some(h) => single(h, self.total),
    // rust: None => multiple(count, self.total),
}
    // rust: Ok((message, self.total))
}
}

pub fn num(n: impl std::fmt::Display) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Text::literal(n.to_string())
}
pub fn tr(key: []const u8, args: *[Text]) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Text::translate(key, args)
}

// ---- argument helpers ------------------------------------------------------

pub fn string(ctx: *Context, name: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match ctx.get(name) {
    // rust: Some(Arg::Str(s)) => s.clone(),
    // rust: _ => String::new(),
}
}
pub fn int(ctx: *Context, name: []const u8) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match ctx.get(name) {
    // rust: Some(Arg::Int(v)) => *v,
    // rust: _ => 0,
}
}
pub fn boolean(ctx: *Context, name: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(ctx.get(name), Some(Arg::Bool(true)))
}
/// A component argument (kept as JSON text), resolved against the source.
pub fn component(ctx: *Context, name: []const u8, env: *mut dyn Env) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(Arg::Str(json)) = ctx.get(name) else {
    // rust: return Ok(literal(""));
}
    // rust: let value: Comp =
    // rust: serde_json::from_str(json).map_err(|e| err("argument.component.invalid", &[&e]))?;
    // rust: Ok(env.resolve(value))
}
pub fn objective_name(ctx: *Context, env: *dyn Env, name: []const u8) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let id = string(ctx, name);
    // rust: if env.sb().objective(&id).is_none() {
    // rust: return Err(err("arguments.objective.notFound", &[&id]));
}
    // rust: Ok(id)
}
pub fn writable_objective(ctx: *Context, env: *dyn Env, name: []const u8) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let id = objective_name(ctx, env, name)?;
    // rust: let criteria = env.sb().objective(&id).map(|o| o.criteria.clone());
    // rust: if criteria.is_some_and(|c| criteria_read_only(&c)) {
    // rust: return Err(err("arguments.objective.readonly", &[&id]));
}
    // rust: Ok(id)
}
pub fn team_name(ctx: *Context, env: *dyn Env, name: []const u8) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let id = string(ctx, name);
    // rust: if env.sb().team(&id).is_none() {
    // rust: return Err(err("team.notFound", &[&id]));
}
    // rust: Ok(id)
}
/// `ScoreHolderArgument.getNames` (and `getNamesWithDefaultWildcard`).
    // rust: pub fn holders(
    // rust: ctx: &Context,
    // rust: name: &str,
    // rust: env: &mut dyn Env,
    // rust: default_wildcard: bool,
    // rust: ) -> CmdResult<Vec<Holder>> {
    // rust: let Some(Arg::ScoreHolder(arg)) = ctx.get(name).cloned() else {
    // rust: return Ok(Vec::new());
}
    // rust: resolve_holders(&arg, env, default_wildcard)
}
    // rust: pub fn resolve_holders(
    // rust: arg: &ScoreHolderArg,
    // rust: env: &mut dyn Env,
    // rust: default_wildcard: bool,
    // rust: ) -> CmdResult<Vec<Holder>> {
    // rust: let found = match arg {
    // rust: ScoreHolderArg::Wildcard => {
    // rust: let tracked = if default_wildcard {
    // rust: env.sb().tracked()
    // rust: } else {
    // rust: Vec::new()
}
    // rust: if tracked.is_empty() {
    // rust: return Err(err("argument.scoreHolder.empty", &[]));
}
    // rust: return Ok(tracked.iter().map(|n| env.named(n)).collect());
}
    // rust: ScoreHolderArg::Name(n) => vec![env.named(n)],
    // rust: ScoreHolderArg::Selector(s) => env.select(s),
}
    // rust: if found.is_empty() {
    // rust: return Err(err("argument.entity.notfound.entity", &[]));
}
    // rust: Ok(found)
}
pub fn one_holder(ctx: *Context, name: []const u8, env: *mut dyn Env) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(holders(ctx, name, env, false)?.remove(0))
}

/// Run a `scoreboard.*`, `team.*` or `trigger*` command; `None` when `id`
/// is not one of them.
pub fn execute(id: []const u8, ctx: *Context, env: *mut dyn Env) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if id.starts_with("scoreboard.") {
    // rust: Some(scoreboard(id, ctx, env))
    // rust: } else if id.starts_with("team.") {
    // rust: Some(team(id, ctx, env))
    // rust: } else if id.starts_with("trigger") {
    // rust: Some(trigger(id, ctx, env))
    // rust: } else {
    // rust: None
}
}

// ---- /scoreboard -----------------------------------------------------------

pub fn scoreboard(id: []const u8, ctx: *Context, env: *mut dyn Env) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match id {
    // rust: "scoreboard.objectives.list" => {
    // rust: let names: Vec<Text> = env
    // rust: .sb()
    // rust: .objectives
    // rust: .iter()
    // rust: .map(|o| o.formatted_display_name())
    // rust: .collect();
    // rust: let n = names.len();
    // rust: if n == 0 {
    // rust: env.feedback(tr("commands.scoreboard.objectives.list.empty", &[]));
    // rust: } else {
    // rust: env.feedback(tr(
    // rust: "commands.scoreboard.objectives.list.success",
    // rust: &[num(n), format_list(names)],
    // rust: ));
}
    // rust: Ok(n as i32)
}
    // rust: "scoreboard.objectives.add" => {
    // rust: let name = string(ctx, "objective");
    // rust: let criteria = string(ctx, "criteria");
    // rust: if env.sb().objective(&name).is_some() {
    // rust: return Err(err("commands.scoreboard.objectives.add.duplicate", &[]));
}
    // rust: let display = if ctx.get("displayName").is_some() {
    // rust: component(ctx, "displayName", env)?
    // rust: } else {
    // rust: literal(&name)
}
    // rust: let render = sb::criteria_render_type(&criteria);
    // rust: env.sb_mut()
    // rust: .add_objective(&name, &criteria, display, render, false, None);
    // rust: let shown = env
    // rust: .sb()
    // rust: .objective(&name)
    // rust: .map(|o| o.formatted_display_name())
    // rust: .unwrap_or_default();
    // rust: env.feedback(tr("commands.scoreboard.objectives.add.success", &[shown]));
    // rust: Ok(env.sb().objectives.len() as i32)
}
    // rust: "scoreboard.objectives.modify.displayname" => {
    // rust: let name = objective_name(ctx, env, "objective")?;
    // rust: let display = component(ctx, "displayName", env)?;
    // rust: let o = env.sb_mut().objective_mut(&name).expect("checked");
    // rust: if o.display_name != display {
    // rust: o.display_name = display;
    // rust: let shown = o.formatted_display_name();
    // rust: env.feedback(tr(
    // rust: "commands.scoreboard.objectives.modify.displayname",
    // rust: &[Text::literal(name), shown],
    // rust: ));
}
    // rust: Ok(0)
}
    // rust: "scoreboard.objectives.modify.rendertype" => {
    // rust: let name = objective_name(ctx, env, "objective")?;
    // rust: let render = RenderType::by_id(ctx.literals.last().map_or("", String::as_str));
    // rust: let o = env.sb_mut().objective_mut(&name).expect("checked");
    // rust: if o.render_type != render {
    // rust: o.render_type = render;
    // rust: let shown = o.formatted_display_name();
    // rust: env.feedback(tr(
    // rust: "commands.scoreboard.objectives.modify.rendertype",
    // rust: &[shown],
    // rust: ));
}
    // rust: Ok(0)
}
    // rust: "scoreboard.objectives.modify.displayautoupdate" => {
    // rust: let name = objective_name(ctx, env, "objective")?;
    // rust: let value = boolean(ctx, "value");
    // rust: let o = env.sb_mut().objective_mut(&name).expect("checked");
    // rust: if o.display_auto_update != value {
    // rust: o.display_auto_update = value;
    // rust: let shown = o.formatted_display_name();
    // rust: env.feedback(tr(
    // rust: &format!(
    // rust: "commands.scoreboard.objectives.modify.displayAutoUpdate.{}",
    // rust: if value { "enable" } else { "disable" }
    // rust: ),
    // rust: &[Text::literal(name), shown],
    // rust: ));
}
    // rust: Ok(0)
}
    // rust: "scoreboard.objectives.modify.numberformat" => {
    // rust: let name = objective_name(ctx, env, "objective")?;
    // rust: let format = number_format(ctx, env)?;
    // rust: let set = format.is_some();
    // rust: env.sb_mut()
    // rust: .objective_mut(&name)
    // rust: .expect("checked")
    // rust: .number_format = format;
    // rust: env.feedback(tr(
    // rust: if set {
    // rust: "commands.scoreboard.objectives.modify.objectiveFormat.set"
    // rust: } else {
    // rust: "commands.scoreboard.objectives.modify.objectiveFormat.clear"
    // rust: },
    // rust: &[Text::literal(name)],
    // rust: ));
    // rust: Ok(0)
}
    // rust: "scoreboard.objectives.remove" => {
    // rust: let name = objective_name(ctx, env, "objective")?;
    // rust: let shown = env
    // rust: .sb()
    // rust: .objective(&name)
    // rust: .map(|o| o.formatted_display_name())
    // rust: .unwrap_or_default();
    // rust: env.sb_mut().remove_objective(&name);
    // rust: env.feedback(tr(
    // rust: "commands.scoreboard.objectives.remove.success",
    // rust: &[shown],
    // rust: ));
    // rust: Ok(env.sb().objectives.len() as i32)
}
    // rust: "scoreboard.objectives.setdisplay" => {
    // rust: let slot = string(ctx, "slot");
    // rust: if ctx.get("objective").is_none() {
    // rust: if !env.sb().display.contains_key(&slot) {
    // rust: return Err(err(
    // rust: "commands.scoreboard.objectives.display.alreadyEmpty",
    // rust: &[],
    // rust: ));
}
    // rust: env.sb_mut().set_display_objective(&slot, None);
    // rust: env.feedback(tr(
    // rust: "commands.scoreboard.objectives.display.cleared",
    // rust: &[Text::literal(slot)],
    // rust: ));
    // rust: return Ok(0);
}
    // rust: let name = objective_name(ctx, env, "objective")?;
    // rust: if env.sb().display.get(&slot) == Some(&name) {
    // rust: return Err(err(
    // rust: "commands.scoreboard.objectives.display.alreadySet",
    // rust: &[],
    // rust: ));
}
    // rust: env.sb_mut().set_display_objective(&slot, Some(&name));
    // rust: let shown = env
    // rust: .sb()
    // rust: .objective(&name)
    // rust: .map(|o| o.display_text())
    // rust: .unwrap_or_default();
    // rust: env.feedback(tr(
    // rust: "commands.scoreboard.objectives.display.set",
    // rust: &[Text::literal(slot), shown],
    // rust: ));
    // rust: Ok(0)
}
    // rust: _ => players(id, ctx, env),
}
}

/// `addNumberFormats`: the format the chosen literal denotes (None = clear).
pub fn number_format(ctx: *Context, env: *mut dyn Env) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if ctx.has("blank") {
    // rust: Ok(Some(NumberFormat::Blank))
    // rust: } else if ctx.has("fixed") {
    // rust: Ok(Some(NumberFormat::Fixed(component(ctx, "contents", env)?)))
    // rust: } else if ctx.has("styled") {
    // rust: let Some(Arg::Str(json)) = ctx.get("style") else {
    // rust: return Ok(None);
}
    // rust: let v: Comp =
    // rust: serde_json::from_str(json).map_err(|e| err("argument.component.invalid", &[&e]))?;
    // rust: Ok(Some(NumberFormat::Styled(v)))
    // rust: } else {
    // rust: Ok(None)
}
}

pub fn objective_text(env: *dyn Env, name: []const u8) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: env.sb()
    // rust: .objective(name)
    // rust: .map(|o| o.formatted_display_name())
    // rust: .unwrap_or_default()
}

pub fn players(id: []const u8, ctx: *Context, env: *mut dyn Env) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match id {
    // rust: "scoreboard.players.list" => {
    // rust: if ctx.get("target").is_none() {
    // rust: let tracked: Vec<Holder> = env
    // rust: .sb()
    // rust: .tracked()
    // rust: .iter()
    // rust: .map(|n| Holder::named(n))
    // rust: .collect();
    // rust: let n = tracked.len();
    // rust: if n == 0 {
    // rust: env.feedback(tr("commands.scoreboard.players.list.empty", &[]));
    // rust: } else {
    // rust: let names: Vec<Text> = tracked.into_iter().map(|h| h.text).collect();
    // rust: env.feedback(tr(
    // rust: "commands.scoreboard.players.list.success",
    // rust: &[num(n), format_list(names)],
    // rust: ));
}
    // rust: return Ok(n as i32);
}
    // rust: let holder = one_holder(ctx, "target", env)?;
    // rust: let scores: Vec<(Text, i32)> = env
    // rust: .sb()
    // rust: .holder_scores(&holder.name)
    // rust: .into_iter()
    // rust: .map(|(o, v)| (o.formatted_display_name(), v))
    // rust: .collect();
    // rust: if scores.is_empty() {
    // rust: env.feedback(tr(
    // rust: "commands.scoreboard.players.list.entity.empty",
    // rust: &[holder.text],
    // rust: ));
    // rust: } else {
    // rust: env.feedback(tr(
    // rust: "commands.scoreboard.players.list.entity.success",
    // rust: &[holder.text, num(scores.len())],
    // rust: ));
    // rust: for (o, v) in &scores {
    // rust: env.feedback(tr(
    // rust: "commands.scoreboard.players.list.entity.entry",
    // rust: &[o.clone(), num(v)],
    // rust: ));
}
}
    // rust: Ok(scores.len() as i32)
}
    // rust: "scoreboard.players.get" => {
    // rust: let target = one_holder(ctx, "target", env)?;
    // rust: let objective = objective_name(ctx, env, "objective")?;
    // rust: let Some(score) = env.sb().score(&target.name, &objective).map(|s| s.value) else {
    // rust: return Err(CommandError::new(tr(
    // rust: "commands.scoreboard.players.get.null",
    // rust: &[Text::literal(objective), target.text],
    // rust: )));
}
    // rust: let shown = objective_text(env, &objective);
    // rust: env.feedback(tr(
    // rust: "commands.scoreboard.players.get.success",
    // rust: &[target.text, num(score), shown],
    // rust: ));
    // rust: Ok(score)
}
    // rust: "scoreboard.players.set" | "scoreboard.players.add" | "scoreboard.players.remove" => {
    // rust: let targets = holders(ctx, "targets", env, true)?;
    // rust: let objective = writable_objective(ctx, env, "objective")?;
    // rust: let value = int(ctx, "score");
    // rust: let verb = id.rsplit('.').next().unwrap_or("set");
    // rust: let mut tracker = Tracker::default();
    // rust: for t in &targets {
    // rust: let v = match verb {
    // rust: "set" => {
    // rust: env.sb_mut()
    // rust: .set_with(&t.name, &objective, value, t.display.as_ref());
    // rust: value
}
    // rust: "add" => {
    // rust: let v = env.sb_mut().get(&t.name, &objective).wrapping_add(value);
    // rust: env.sb_mut()
    // rust: .set_with(&t.name, &objective, v, t.display.as_ref());
    // rust: v
}
    // rust: _ => {
    // rust: let v = env.sb_mut().get(&t.name, &objective).wrapping_sub(value);
    // rust: env.sb_mut()
    // rust: .set_with(&t.name, &objective, v, t.display.as_ref());
    // rust: v
}
}
    // rust: tracker.track(t, v);
}
    // rust: let shown = objective_text(env, &objective);
    // rust: let key = format!("commands.scoreboard.players.{verb}.success");
    // rust: if verb == "set" {
    // rust: tracker.send(
    // rust: env,
    // rust: false,
    // rust: None,
    // rust: |h, _| {
    // rust: tr(
    // rust: &format!("{key}.single"),
    // rust: &[shown.clone(), h.text.clone(), num(value)],
    // rust: )
    // rust: },
    // rust: |n, _| {
    // rust: tr(
    // rust: &format!("{key}.multiple"),
    // rust: &[shown.clone(), num(n), num(value)],
    // rust: )
    // rust: },
    // rust: )
    // rust: } else {
    // rust: tracker.send(
    // rust: env,
    // rust: true,
    // rust: None,
    // rust: |h, total| {
    // rust: tr(
    // rust: &format!("{key}.single"),
    // rust: &[num(value), shown.clone(), h.text.clone(), num(total)],
    // rust: )
    // rust: },
    // rust: |n, _| {
    // rust: tr(
    // rust: &format!("{key}.multiple"),
    // rust: &[num(value), shown.clone(), num(n)],
    // rust: )
    // rust: },
    // rust: )
}
}
    // rust: "scoreboard.players.reset" => {
    // rust: let targets = holders(ctx, "targets", env, true)?;
    // rust: let mut tracker = Tracker::default();
    // rust: if ctx.get("objective").is_some() {
    // rust: let objective = objective_name(ctx, env, "objective")?;
    // rust: for t in &targets {
    // rust: env.sb_mut().reset_one(&t.name, &objective);
    // rust: tracker.mark(t);
}
    // rust: let shown = objective_text(env, &objective);
    // rust: tracker.send(
    // rust: env,
    // rust: false,
    // rust: None,
    // rust: |h, _| {
    // rust: tr(
    // rust: "commands.scoreboard.players.reset.specific.single",
    // rust: &[shown.clone(), h.text.clone()],
    // rust: )
    // rust: },
    // rust: |n, _| {
    // rust: tr(
    // rust: "commands.scoreboard.players.reset.specific.multiple",
    // rust: &[shown.clone(), num(n)],
    // rust: )
    // rust: },
    // rust: )
    // rust: } else {
    // rust: for t in &targets {
    // rust: env.sb_mut().reset_all(&t.name);
    // rust: tracker.mark(t);
}
    // rust: tracker.send(
    // rust: env,
    // rust: false,
    // rust: None,
    // rust: |h, _| {
    // rust: tr(
    // rust: "commands.scoreboard.players.reset.all.single",
    // rust: std::slice::from_ref(&h.text),
    // rust: )
    // rust: },
    // rust: |n, _| tr("commands.scoreboard.players.reset.all.multiple", &[num(n)]),
    // rust: )
}
}
    // rust: "scoreboard.players.enable" => {
    // rust: let targets = holders(ctx, "targets", env, true)?;
    // rust: let objective = objective_name(ctx, env, "objective")?;
    // rust: let criteria = env.sb().objective(&objective).map(|o| o.criteria.clone());
    // rust: if criteria.as_deref() != Some(sb::CRITERIA_TRIGGER) {
    // rust: return Err(err("commands.scoreboard.players.enable.invalid", &[]));
}
    // rust: let mut tracker = Tracker::default();
    // rust: for t in &targets {
    // rust: let s = env.sb_mut().score_mut(&t.name, &objective);
    // rust: if s.locked {
    // rust: s.locked = false;
    // rust: tracker.mark(t);
}
}
    // rust: let shown = objective_text(env, &objective);
    // rust: tracker.send(
    // rust: env,
    // rust: false,
    // rust: Some(err("commands.scoreboard.players.enable.failed", &[])),
    // rust: |h, _| {
    // rust: tr(
    // rust: "commands.scoreboard.players.enable.success.single",
    // rust: &[shown.clone(), h.text.clone()],
    // rust: )
    // rust: },
    // rust: |n, _| {
    // rust: tr(
    // rust: "commands.scoreboard.players.enable.success.multiple",
    // rust: &[shown.clone(), num(n)],
    // rust: )
    // rust: },
    // rust: )
}
    // rust: "scoreboard.players.display.name" => {
    // rust: let targets = holders(ctx, "targets", env, true)?;
    // rust: let objective = objective_name(ctx, env, "objective")?;
    // rust: let display = if ctx.get("name").is_some() {
    // rust: Some(component(ctx, "name", env)?)
    // rust: } else {
    // rust: None
}
    // rust: let mut tracker = Tracker::default();
    // rust: for t in &targets {
    // rust: env.sb_mut().score_mut(&t.name, &objective).display = display.clone();
    // rust: tracker.mark(t);
}
    // rust: let shown = objective_text(env, &objective);
    // rust: let set_text = display.as_ref().map(comp_text);
    // rust: match set_text {
    // rust: None => tracker.send(
    // rust: env,
    // rust: false,
    // rust: None,
    // rust: |h, _| {
    // rust: tr(
    // rust: "commands.scoreboard.players.display.name.clear.success.single",
    // rust: &[h.text.clone(), shown.clone()],
    // rust: )
    // rust: },
    // rust: |n, _| {
    // rust: tr(
    // rust: "commands.scoreboard.players.display.name.clear.success.multiple",
    // rust: &[num(n), shown.clone()],
    // rust: )
    // rust: },
    // rust: ),
    // rust: Some(d) => tracker.send(
    // rust: env,
    // rust: false,
    // rust: None,
    // rust: |h, _| {
    // rust: tr(
    // rust: "commands.scoreboard.players.display.name.set.success.single",
    // rust: &[d.clone(), h.text.clone(), shown.clone()],
    // rust: )
    // rust: },
    // rust: |n, _| {
    // rust: tr(
    // rust: "commands.scoreboard.players.display.name.set.success.multiple",
    // rust: &[d.clone(), num(n), shown.clone()],
    // rust: )
    // rust: },
    // rust: ),
}
}
    // rust: "scoreboard.players.display.numberformat" => {
    // rust: let targets = holders(ctx, "targets", env, true)?;
    // rust: let objective = objective_name(ctx, env, "objective")?;
    // rust: let format = number_format(ctx, env)?;
    // rust: let set = format.is_some();
    // rust: let mut tracker = Tracker::default();
    // rust: for t in &targets {
    // rust: env.sb_mut().score_mut(&t.name, &objective).number_format = format.clone();
    // rust: tracker.mark(t);
}
    // rust: let shown = objective_text(env, &objective);
    // rust: let kind = if set { "set" } else { "clear" };
    // rust: tracker.send(
    // rust: env,
    // rust: false,
    // rust: None,
    // rust: |h, _| {
    // rust: tr(
    // rust: &format!(
    // rust: "commands.scoreboard.players.display.numberFormat.{kind}.success.single"
    // rust: ),
    // rust: &[h.text.clone(), shown.clone()],
    // rust: )
    // rust: },
    // rust: |n, _| {
    // rust: tr(
    // rust: &format!(
    // rust: "commands.scoreboard.players.display.numberFormat.{kind}.success.multiple"
    // rust: ),
    // rust: &[num(n), shown.clone()],
    // rust: )
    // rust: },
    // rust: )
}
    // rust: "scoreboard.players.operation" => {
    // rust: let targets = holders(ctx, "targets", env, true)?;
    // rust: let target_objective = writable_objective(ctx, env, "targetObjective")?;
    // rust: let op = string(ctx, "operation");
    // rust: let sources = holders(ctx, "source", env, true)?;
    // rust: let source_objective = objective_name(ctx, env, "sourceObjective")?;
    // rust: let mut tracker = Tracker::default();
    // rust: for t in &targets {
    // rust: for s in &sources {
    // rust: let b = env.sb_mut().get(&s.name, &source_objective);
    // rust: let a = env.sb_mut().get(&t.name, &target_objective);
    // rust: let (na, nb) = apply_operation(&op, a, b)?;
    // rust: env.sb_mut()
    // rust: .set_with(&t.name, &target_objective, na, t.display.as_ref());
    // rust: if op == "><" {
    // rust: env.sb_mut().set(&s.name, &source_objective, nb);
}
}
    // rust: let v = env.sb_mut().get(&t.name, &target_objective);
    // rust: tracker.track(t, v);
}
    // rust: let shown = objective_text(env, &target_objective);
    // rust: tracker.send(
    // rust: env,
    // rust: true,
    // rust: None,
    // rust: |h, total| {
    // rust: tr(
    // rust: "commands.scoreboard.players.operation.success.single",
    // rust: &[shown.clone(), h.text.clone(), num(total)],
    // rust: )
    // rust: },
    // rust: |n, _| {
    // rust: tr(
    // rust: "commands.scoreboard.players.operation.success.multiple",
    // rust: &[shown.clone(), num(n)],
    // rust: )
    // rust: },
    // rust: )
}
    // rust: _ => Err(err("command.failed", &[])),
}
}

/// `OperationArgument.getSimpleOperation`: the new (target, source) values.
pub fn apply_operation(op: []const u8, a: i32, b: i32) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let div0 = || err("arguments.operation.div0", &[]);
    // rust: Ok(match op {
    // rust: "=" => (b, b),
    // rust: "+=" => (a.wrapping_add(b), b),
    // rust: "-=" => (a.wrapping_sub(b), b),
    // rust: "*=" => (a.wrapping_mul(b), b),
    // rust: "/=" => {
    // rust: if b == 0 {
    // rust: return Err(div0());
}
    // rust: (
    // rust: a.wrapping_div(b) - i32::from((a.wrapping_rem(b) != 0) && ((a < 0) != (b < 0))),
    // rust: b,
    // rust: )
}
    // rust: "%=" => {
    // rust: if b == 0 {
    // rust: return Err(div0());
}
    // rust: let remainder = a.wrapping_rem(b);
            // Floor remainder has the divisor's sign; only correct opposite signs.
    // rust: let remainder = if remainder != 0 && ((remainder < 0) != (b < 0)) {
    // rust: remainder + b
    // rust: } else {
    // rust: remainder
}
    // rust: (remainder, b)
}
    // rust: "<" => (a.min(b), b),
    // rust: ">" => (a.max(b), b),
    // rust: "><" => (b, a),
    // rust: _ => return Err(err("arguments.operation.invalid", &[])),
    // rust: })
}

// ---- /team -----------------------------------------------------------------

pub fn team(id: []const u8, ctx: *Context, env: *mut dyn Env) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let formatted = |env: &dyn Env, name: &str| {
    // rust: env.sb()
    // rust: .team(name)
    // rust: .map(|t| t.formatted_display_name())
    // rust: .unwrap_or_default()
}
    // rust: match id {
    // rust: "team.list" => {
    // rust: if ctx.get("team").is_some() {
    // rust: let name = team_name(ctx, env, "team")?;
    // rust: let members: Vec<String> = env
    // rust: .sb()
    // rust: .team(&name)
    // rust: .map(|t| t.players.iter().cloned().collect())
    // rust: .unwrap_or_default();
    // rust: let shown = formatted(env, &name);
    // rust: let n = members.len();
    // rust: if n == 0 {
    // rust: env.feedback(tr("commands.team.list.members.empty", &[shown]));
    // rust: } else {
    // rust: env.feedback(tr(
    // rust: "commands.team.list.members.success",
    // rust: &[shown, num(n), format_names(members)],
    // rust: ));
}
    // rust: return Ok(n as i32);
}
    // rust: let teams: Vec<Text> = env
    // rust: .sb()
    // rust: .teams
    // rust: .iter()
    // rust: .map(|t| t.formatted_display_name())
    // rust: .collect();
    // rust: let n = teams.len();
    // rust: if n == 0 {
    // rust: env.feedback(tr("commands.team.list.teams.empty", &[]));
    // rust: } else {
    // rust: env.feedback(tr(
    // rust: "commands.team.list.teams.success",
    // rust: &[num(n), format_list(teams)],
    // rust: ));
}
    // rust: Ok(n as i32)
}
    // rust: "team.add" => {
    // rust: let name = string(ctx, "team");
    // rust: if env.sb().team(&name).is_some() {
    // rust: return Err(err("commands.team.add.duplicate", &[]));
}
    // rust: let display = if ctx.get("displayName").is_some() {
    // rust: component(ctx, "displayName", env)?
    // rust: } else {
    // rust: literal(&name)
}
    // rust: env.sb_mut().add_team(&name).display_name = display;
    // rust: let shown = formatted(env, &name);
    // rust: env.feedback(tr("commands.team.add.success", &[shown]));
    // rust: Ok(env.sb().teams.len() as i32)
}
    // rust: "team.remove" => {
    // rust: let name = team_name(ctx, env, "team")?;
    // rust: let shown = formatted(env, &name);
    // rust: env.sb_mut().remove_team(&name);
    // rust: env.feedback(tr("commands.team.remove.success", &[shown]));
    // rust: Ok(env.sb().teams.len() as i32)
}
    // rust: "team.empty" => {
    // rust: let name = team_name(ctx, env, "team")?;
    // rust: let members: Vec<String> = env
    // rust: .sb()
    // rust: .team(&name)
    // rust: .map(|t| t.players.iter().cloned().collect())
    // rust: .unwrap_or_default();
    // rust: if members.is_empty() {
    // rust: return Err(err("commands.team.empty.unchanged", &[]));
}
    // rust: for m in &members {
    // rust: env.sb_mut().remove_from_team(m);
}
    // rust: let shown = formatted(env, &name);
    // rust: env.feedback(tr(
    // rust: "commands.team.empty.success",
    // rust: &[num(members.len()), shown],
    // rust: ));
    // rust: Ok(members.len() as i32)
}
    // rust: "team.join" => {
    // rust: let name = team_name(ctx, env, "team")?;
    // rust: let members = if ctx.get("members").is_some() {
    // rust: holders(ctx, "members", env, true)?
    // rust: } else {
    // rust: match env.source() {
    // rust: Some((h, _)) => vec![h],
    // rust: None => return Err(err("permissions.requires.entity", &[])),
}
}
    // rust: let mut tracker = Tracker::default();
    // rust: for m in &members {
    // rust: let joined = env.sb_mut().add_to_team(&m.name, &name);
                // The message reads the display name after the change.
    // rust: tracker.track(&env.named(&m.name), i32::from(joined));
}
    // rust: let shown = formatted(env, &name);
    // rust: tracker.send(
    // rust: env,
    // rust: false,
    // rust: None,
    // rust: |h, _| {
    // rust: tr(
    // rust: "commands.team.join.success.single",
    // rust: &[h.text.clone(), shown.clone()],
    // rust: )
    // rust: },
    // rust: |n, _| {
    // rust: tr(
    // rust: "commands.team.join.success.multiple",
    // rust: &[num(n), shown.clone()],
    // rust: )
    // rust: },
    // rust: )
}
    // rust: "team.leave" => {
    // rust: let members = holders(ctx, "members", env, true)?;
    // rust: let mut tracker = Tracker::default();
    // rust: for m in &members {
    // rust: let left = env.sb_mut().remove_from_team(&m.name);
    // rust: tracker.track(&env.named(&m.name), i32::from(left));
}
    // rust: tracker.send(
    // rust: env,
    // rust: false,
    // rust: None,
    // rust: |h, _| {
    // rust: tr(
    // rust: "commands.team.leave.success.single",
    // rust: std::slice::from_ref(&h.text),
    // rust: )
    // rust: },
    // rust: |n, _| tr("commands.team.leave.success.multiple", &[num(n)]),
    // rust: )
}
    // rust: _ => team_modify(id, ctx, env),
}
}

pub fn team_modify(id: []const u8, ctx: *Context, env: *mut dyn Env) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = team_name(ctx, env, "team")?;
    // rust: let shown = |env: &dyn Env| {
    // rust: env.sb()
    // rust: .team(&name)
    // rust: .map(|t| t.formatted_display_name())
    // rust: .unwrap_or_default()
}
    // rust: let last = ctx.literals.last().cloned().unwrap_or_default();
    // rust: match id {
    // rust: "team.modify.displayname" => {
    // rust: let display = component(ctx, "displayName", env)?;
    // rust: let team = env.sb_mut().team_mut(&name).expect("checked");
    // rust: if team.display_name == display {
    // rust: return Err(err("commands.team.option.name.unchanged", &[]));
}
    // rust: team.display_name = display;
    // rust: let s = shown(env);
    // rust: env.feedback(tr("commands.team.option.name.success", &[s]));
}
    // rust: "team.modify.color" | "team.modify.color.reset" => {
    // rust: let reset = id.ends_with("reset");
    // rust: let value = (!reset).then(|| string(ctx, "value"));
    // rust: let team = env.sb_mut().team_mut(&name).expect("checked");
    // rust: if team.color == value {
    // rust: return Err(err("commands.team.option.color.unchanged", &[]));
}
    // rust: team.color.clone_from(&value);
    // rust: let s = shown(env);
    // rust: match value {
    // rust: Some(c) => env.feedback(tr(
    // rust: "commands.team.option.color.success",
    // rust: &[s, Text::literal(c)],
    // rust: )),
    // rust: None => env.feedback(tr("commands.team.option.color.clear.success", &[s])),
}
}
    // rust: "team.modify.friendlyfire" | "team.modify.seefriendlyinvisibles" => {
    // rust: let allowed = boolean(ctx, "allowed");
    // rust: let fire = id.ends_with("friendlyfire");
    // rust: let team = env.sb_mut().team_mut(&name).expect("checked");
    // rust: let current = if fire {
    // rust: team.allow_friendly_fire
    // rust: } else {
    // rust: team.see_friendly_invisibles
}
    // rust: let base = if fire {
    // rust: "commands.team.option.friendlyfire"
    // rust: } else {
    // rust: "commands.team.option.seeFriendlyInvisibles"
}
    // rust: if current == allowed {
    // rust: return Err(err(
    // rust: &format!(
    // rust: "{base}.{}",
    // rust: if allowed {
    // rust: "alreadyEnabled"
    // rust: } else {
    // rust: "alreadyDisabled"
}
    // rust: ),
    // rust: &[],
    // rust: ));
}
    // rust: if fire {
    // rust: team.allow_friendly_fire = allowed;
    // rust: } else {
    // rust: team.see_friendly_invisibles = allowed;
}
    // rust: let s = shown(env);
    // rust: env.feedback(tr(
    // rust: &format!("{base}.{}", if allowed { "enabled" } else { "disabled" }),
    // rust: &[s],
    // rust: ));
}
    // rust: "team.modify.nametagvisibility" | "team.modify.deathmessagevisibility" => {
    // rust: let v = Visibility::by_name(&last).unwrap_or(Visibility::Always);
    // rust: let nametag = id.ends_with("nametagvisibility");
    // rust: let team = env.sb_mut().team_mut(&name).expect("checked");
    // rust: let slot = if nametag {
    // rust: &mut team.nametag_visibility
    // rust: } else {
    // rust: &mut team.death_message_visibility
}
    // rust: let base = if nametag {
    // rust: "commands.team.option.nametagVisibility"
    // rust: } else {
    // rust: "commands.team.option.deathMessageVisibility"
}
    // rust: if *slot == v {
    // rust: return Err(err(&format!("{base}.unchanged"), &[]));
}
    // rust: *slot = v;
    // rust: let s = shown(env);
    // rust: env.feedback(tr(&format!("{base}.success"), &[s, v.display_name()]));
}
    // rust: "team.modify.collisionrule" => {
    // rust: let rule = sb::CollisionRule::by_name(&last).unwrap_or(sb::CollisionRule::Always);
    // rust: let team = env.sb_mut().team_mut(&name).expect("checked");
    // rust: if team.collision_rule == rule {
    // rust: return Err(err("commands.team.option.collisionRule.unchanged", &[]));
}
    // rust: team.collision_rule = rule;
    // rust: let s = shown(env);
    // rust: env.feedback(tr(
    // rust: "commands.team.option.collisionRule.success",
    // rust: &[s, rule.display_name()],
    // rust: ));
}
    // rust: "team.modify.prefix" | "team.modify.suffix" => {
    // rust: let prefix = id.ends_with("prefix");
    // rust: let value = component(ctx, if prefix { "prefix" } else { "suffix" }, env)?;
    // rust: let team = env.sb_mut().team_mut(&name).expect("checked");
    // rust: if prefix {
    // rust: team.prefix = value.clone();
    // rust: } else {
    // rust: team.suffix = value.clone();
}
    // rust: env.feedback(tr(
    // rust: if prefix {
    // rust: "commands.team.option.prefix.success"
    // rust: } else {
    // rust: "commands.team.option.suffix.success"
    // rust: },
    // rust: &[comp_text(&value)],
    // rust: ));
    // rust: return Ok(1);
}
    // rust: _ => return Err(err("command.failed", &[])),
}
    // rust: Ok(0)
}

// ---- /trigger --------------------------------------------------------------

pub fn trigger(id: []const u8, ctx: *Context, env: *mut dyn Env) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some((player, true)) = env.source() else {
    // rust: return Err(err("permissions.requires.player", &[]));
}
    // rust: let objective = objective_name(ctx, env, "objective")?;
    // getScore: only primed trigger objectives, locked again afterwards.
    // rust: let criteria = env.sb().objective(&objective).map(|o| o.criteria.clone());
    // rust: if criteria.as_deref() != Some(sb::CRITERIA_TRIGGER) {
    // rust: return Err(err("commands.trigger.failed.invalid", &[]));
}
    // rust: if env
    // rust: .sb()
    // rust: .score(&player.name, &objective)
    // rust: .is_none_or(|s| s.locked)
    // rust: {
    // rust: return Err(err("commands.trigger.failed.unprimed", &[]));
}
    // rust: env.sb_mut().score_mut(&player.name, &objective).locked = true;
    // rust: let shown = objective_text(env, &objective);
    // rust: let (value, message) = match id {
    // rust: "trigger.add" => {
    // rust: let amount = int(ctx, "value");
    // rust: let v = env.sb_mut().add(&player.name, &objective, amount);
    // rust: (v, tr("commands.trigger.add.success", &[shown, num(amount)]))
}
    // rust: "trigger.set" => {
    // rust: let amount = int(ctx, "value");
    // rust: env.sb_mut().set(&player.name, &objective, amount);
    // rust: (
    // rust: amount,
    // rust: tr("commands.trigger.set.success", &[shown, num(amount)]),
    // rust: )
}
    // rust: _ => {
    // rust: let v = env.sb_mut().add(&player.name, &objective, 1);
    // rust: (v, tr("commands.trigger.simple.success", &[shown]))
}
}
    // rust: env.feedback(message);
    // rust: Ok(value)
}

    // rust: mod tests;
