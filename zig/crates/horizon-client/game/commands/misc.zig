//! Transpiled from Horizon Rust crate
//! Module: horizon-client_misc
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `/random` (RandomCommand) and `/teammsg` (TeamMsgCommand).
// use super::{Arg, Context, Game, R, Target, err};
// use crate::game::chat::PLAYER_NAME;
// use horizon_client::{
    // rust: clock::SprintReport,
    // rust: java_text::format_fixed,
    // rust: text::{self, Text},
}
// use horizon_core::random::RandomSource;

pub fn millis(nanos: u64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: format_fixed(f64::from(nanos as f32 / 1_000_000.0), 1)
}

    // rust: impl Game<'_> {
    /// `/stopwatch` (StopwatchCommand).
    // rust: pub(super) fn cmd_stopwatch(&mut self, id: &str, ctx: &Context) -> R<i32> {
    // rust: let Some(Arg::Resource(name)) = ctx.get("id").cloned() else {
    // rust: return Ok(0);
}
    // rust: let arg = || Text::literal(name.clone());
    // rust: let missing = || err("commands.stopwatch.does_not_exist", &[&name]);
    // rust: let sw = &mut self.score.stopwatches;
    // rust: match id {
    // rust: "stopwatch.create" => {
    // rust: if !sw.create(&name) {
    // rust: return Err(err("commands.stopwatch.already_exists", &[&name]));
}
    // rust: self.feedback(Text::translate(
    // rust: "commands.stopwatch.create.success",
    // rust: &[arg()],
    // rust: ));
    // rust: Ok(1)
}
    // rust: "stopwatch.query" => {
    // rust: let scale = match ctx.get("scale") {
    // rust: Some(Arg::Double(v)) => *v,
    // rust: _ => 1.0,
}
    // rust: let t = sw.elapsed_seconds(&name).ok_or_else(missing)?;
    // rust: self.feedback(Text::translate(
    // rust: "commands.stopwatch.query",
    // rust: &[arg(), Text::literal(format!("{t:?}"))],
    // rust: ));
    // rust: Ok((t * scale) as i32)
}
    // rust: "stopwatch.restart" => {
    // rust: if !sw.restart(&name) {
    // rust: return Err(missing());
}
    // rust: self.feedback(Text::translate(
    // rust: "commands.stopwatch.restart.success",
    // rust: &[arg()],
    // rust: ));
    // rust: Ok(1)
}
    // rust: _ => {
    // rust: if !sw.remove(&name) {
    // rust: return Err(missing());
}
    // rust: self.feedback(Text::translate(
    // rust: "commands.stopwatch.remove.success",
    // rust: &[arg()],
    // rust: ));
    // rust: Ok(1)
}
}
}
    /// `/tick` (TickCommand) over the game clock.
    // rust: pub(super) fn cmd_tick(&mut self, id: &str, ctx: &Context) -> R<i32> {
    // rust: let t = |key: &str, args: &[Text]| Text::translate(key, args);
    // rust: let lit = |s: String| Text::literal(s);
    // rust: let time = match ctx.get("time") {
    // rust: Some(Arg::Int(v)) => *v,
    // rust: _ => 1,
}
    // rust: match id {
    // rust: "tick.rate" => {
    // rust: let rate = match ctx.get("rate") {
    // rust: Some(Arg::Float(v)) => *v,
    // rust: _ => 20.0,
}
    // rust: self.clock.set_rate(rate);
                // MinecraftServer.setTickRate: the autosave wait already
                // running is shortened when the new rate asks for less.
    // rust: self.on_tick_rate_changed();
    // rust: self.feedback(t(
    // rust: "commands.tick.rate.success",
    // rust: &[lit(format_fixed(f64::from(rate), 1))],
    // rust: ));
    // rust: Ok(rate as i32)
}
    // rust: "tick.query" => {
    // rust: let rate = self.clock.rate();
    // rust: let busy = millis(self.clock.average_nanos());
    // rust: let rate_text = format_fixed(f64::from(rate), 1);
    // rust: if self.clock.sprinting() {
    // rust: self.feedback(t("commands.tick.status.sprinting", &[]));
    // rust: self.feedback(t(
    // rust: "commands.tick.query.rate.sprinting",
    // rust: &[lit(rate_text), lit(busy)],
    // rust: ));
    // rust: } else {
    // rust: let target = self.clock.tick_duration().as_nanos() as u64;
    // rust: let status = if self.clock.frozen() {
    // rust: "commands.tick.status.frozen"
    // rust: } else if target < self.clock.average_nanos() {
    // rust: "commands.tick.status.lagging"
    // rust: } else {
    // rust: "commands.tick.status.running"
}
    // rust: self.feedback(t(status, &[]));
    // rust: self.feedback(t(
    // rust: "commands.tick.query.rate.running",
    // rust: &[lit(rate_text), lit(busy), lit(millis(target))],
    // rust: ));
}
    // rust: let samples = self.clock.sorted_samples();
    // rust: let at = |q: f32| {
    // rust: samples
    // rust: .get(
    // rust: ((samples.len() as f32 * q) as usize)
    // rust: .min(samples.len().saturating_sub(1)),
    // rust: )
    // rust: .copied()
    // rust: .unwrap_or(0)
}
    // rust: self.feedback(t(
    // rust: "commands.tick.query.percentiles",
    // rust: &[
    // rust: lit(millis(at(0.5))),
    // rust: lit(millis(at(0.95))),
    // rust: lit(millis(at(0.99))),
    // rust: lit(samples.len().to_string()),
    // rust: ],
    // rust: ));
    // rust: Ok(rate as i32)
}
    // rust: "tick.sprint" => {
    // rust: if self.clock.start_sprint(time as u32) {
    // rust: self.feedback(t("commands.tick.sprint.stop.success", &[]));
}
    // rust: self.feedback(t("commands.tick.status.sprinting", &[]));
    // rust: Ok(1)
}
    // rust: "tick.sprint.stop" => {
    // rust: let Some(report) = self.clock.stop_sprint() else {
    // rust: return Err(err("commands.tick.sprint.stop.fail", &[]));
}
    // rust: self.sprint_report(&report);
    // rust: self.feedback(t("commands.tick.sprint.stop.success", &[]));
    // rust: Ok(1)
}
    // rust: "tick.freeze" | "tick.unfreeze" => {
    // rust: let freeze = id == "tick.freeze";
    // rust: if freeze {
    // rust: if let Some(report) = self.clock.stop_sprint() {
    // rust: self.sprint_report(&report);
}
    // rust: self.clock.stop_step();
}
    // rust: self.clock.set_frozen(freeze);
    // rust: self.feedback(t(
    // rust: if freeze {
    // rust: "commands.tick.status.frozen"
    // rust: } else {
    // rust: "commands.tick.status.running"
    // rust: },
    // rust: &[],
    // rust: ));
    // rust: Ok(i32::from(freeze))
}
    // rust: "tick.step" => {
    // rust: if !self.clock.start_step(time as u32) {
    // rust: return Err(err("commands.tick.step.fail", &[]));
}
    // rust: self.feedback(t("commands.tick.step.success", &[lit(time.to_string())]));
    // rust: Ok(1)
}
    // rust: _ => {
    // rust: if !self.clock.stop_step() {
    // rust: return Err(err("commands.tick.step.stop.fail", &[]));
}
    // rust: self.feedback(t("commands.tick.step.stop.success", &[]));
    // rust: Ok(1)
}
}
}
    /// The report `/tick sprint` prints when a sprint ends.
    // rust: pub(in crate::game) fn sprint_report(&mut self, report: &SprintReport) {
    // rust: self.feedback(Text::translate(
    // rust: "commands.tick.sprint.report",
    // rust: &[
    // rust: Text::literal(report.ticks_per_second.to_string()),
    // rust: Text::literal(report.milliseconds_per_tick.clone()),
    // rust: ],
    // rust: ));
}
    // rust: pub(super) fn cmd_random(&mut self, id: &str, ctx: &Context) -> R<i32> {
    // rust: let seed = self.level.seed;
    // rust: if id == "random.reset" {
    // rust: let sequence = match ctx.get("sequence") {
    // rust: Some(Arg::Resource(s)) => Some(s.clone()),
    // rust: _ => None,
}
    // rust: let int = |name: &str| match ctx.get(name) {
    // rust: Some(Arg::Int(v)) => Some(*v),
    // rust: _ => None,
}
    // rust: let flag = |name: &str| !matches!(ctx.get(name), Some(Arg::Bool(false)));
    // rust: let name_text = |s: &str| Text::literal(s.to_owned());
    // rust: return match (sequence, int("seed")) {
    // rust: (None, None) => {
    // rust: let n = self.rand_sequences.clear();
    // rust: self.feedback(Text::translate(
    // rust: "commands.random.reset.all.success",
    // rust: &[Text::literal(n.to_string())],
    // rust: ));
    // rust: Ok(n as i32)
}
    // rust: (None, Some(salt)) => {
    // rust: self.rand_sequences.set_defaults(
    // rust: salt,
    // rust: flag("includeWorldSeed"),
    // rust: flag("includeSequenceId"),
    // rust: );
    // rust: let n = self.rand_sequences.clear();
    // rust: self.feedback(Text::translate(
    // rust: "commands.random.reset.all.success",
    // rust: &[Text::literal(n.to_string())],
    // rust: ));
    // rust: Ok(n as i32)
}
    // rust: (Some(s), None) => {
    // rust: self.rand_sequences.reset(&s, seed);
    // rust: self.feedback(Text::translate(
    // rust: "commands.random.reset.success",
    // rust: &[name_text(&s)],
    // rust: ));
    // rust: Ok(1)
}
    // rust: (Some(s), Some(salt)) => {
    // rust: self.rand_sequences.reset_with(
    // rust: &s,
    // rust: seed,
    // rust: salt,
    // rust: flag("includeWorldSeed"),
    // rust: flag("includeSequenceId"),
    // rust: );
    // rust: self.feedback(Text::translate(
    // rust: "commands.random.reset.success",
    // rust: &[name_text(&s)],
    // rust: ));
    // rust: Ok(1)
}
}
}
    // rust: let Some(Arg::IntRange((lo, hi))) = ctx.get("range").cloned() else {
    // rust: return Ok(0);
}
    // rust: let (min, max) = (lo.unwrap_or(i32::MIN), hi.unwrap_or(i32::MAX));
    // rust: let span = i64::from(max) - i64::from(min);
    // rust: if span == 0 {
    // rust: return Err(err("commands.random.error.range_too_small", &[]));
}
    // rust: if span >= i64::from(i32::MAX) {
    // rust: return Err(err("commands.random.error.range_too_large", &[]));
}
    // rust: let value = match ctx.get("sequence") {
    // rust: Some(Arg::Resource(s)) => {
    // rust: let s = s.clone();
    // rust: self.rand_sequences
    // rust: .get(&s, seed)
    // rust: .next_int_between_inclusive(min, max)
}
    // rust: _ => self.world.random.next_int_between_inclusive(min, max),
}
    // rust: .unwrap_or(min);
    // rust: if id == "random.roll" {
    // rust: let who = self.target_name(
    // rust: self.command_source
    // rust: .and_then(|s| s.entity)
    // rust: .unwrap_or(Target::Player),
    // rust: );
    // rust: self.system_message(Text::translate(
    // rust: "commands.random.roll",
    // rust: &[
    // rust: who,
    // rust: Text::literal(value.to_string()),
    // rust: Text::literal(min.to_string()),
    // rust: Text::literal(max.to_string()),
    // rust: ],
    // rust: ));
    // rust: } else {
    // rust: self.feedback(Text::translate(
    // rust: "commands.random.sample.success",
    // rust: &[Text::literal(value.to_string())],
    // rust: ));
}
    // rust: Ok(value)
}
    /// `/teammsg`: the executor's team hears the message.
    // rust: pub(super) fn cmd_teammsg(&mut self, ctx: &Context) -> R<i32> {
    // rust: let entity = match self.command_source {
    // rust: Some(s) => s.entity,
    // rust: None => Some(Target::Player),
}
    // rust: let Some(entity) = entity else {
    // rust: return Err(err("permissions.requires.entity", &[]));
}
    // rust: let Some(holder) = self.holder_name(entity) else {
    // rust: return Err(err("permissions.requires.entity", &[]));
}
    // rust: let Some(team) = self.score.board.players_team(&holder).cloned() else {
    // rust: return Err(err("commands.teammsg.failed.noteam", &[]));
}
        // Only the local player can be on the receiving end.
    // rust: let player_name = PLAYER_NAME.to_owned();
    // rust: let player_in_team = self
    // rust: .score
    // rust: .board
    // rust: .players_team(&player_name)
    // rust: .is_some_and(|t| t.name == team.name);
    // rust: if !player_in_team {
    // rust: return Ok(0);
}
    // rust: let raw = match ctx.get("message") {
    // rust: Some(Arg::Str(m)) => m.clone(),
    // rust: _ => String::new(),
}
    // rust: let message = self.expand_selectors(&raw);
    // rust: let hover = text::Style {
    // rust: hover: Some(Box::new(Text::translate("chat.type.team.hover", &[]))),
    // rust: click: Some(text::ClickEvent::SuggestCommand("/teammsg ".into())),
    // rust: ..text::Style::default()
}
    // rust: let team_name = team.formatted_display_name().with_style(&hover);
    // rust: let sender = self.target_name(entity);
    // rust: let key = if entity == Target::Player {
    // rust: "chat.type.team.sent"
    // rust: } else {
    // rust: "chat.type.team.text"
}
    // rust: self.system_message(Text::translate(key, &[team_name, sender, message]));
    // rust: Ok(1)
}
}
