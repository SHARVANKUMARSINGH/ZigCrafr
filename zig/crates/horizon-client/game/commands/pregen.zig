//! Transpiled from Horizon Rust crate
//! Module: horizon-client_pregen
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `/pregen`, Horizon's own command: generate, light and save every chunk of a
//! square or a circle ahead of the players (docs/pregeneration.md). The task
//! lives on the server and hands its band to the level's streaming, whose
//! workers do the work; chunks behind the band unload and are saved as any
//! chunk the players leave.
// use super::{CommandError, Context, Dim, Game, R};
// use horizon_client::{
    // rust: lan::data::component_nbt,
    // rust: pregen::{Pregen, Shape},
    // rust: text::{self, Text},
}
// use horizon_protocol::packets::play::{self, Clientbound as C};
// use std::time::{Duration, Instant};

/// How often the progress is reported.
pub const REPORT_EVERY: Duration = Duration::from_secs(5);
/// How long the band may stay put before the task looks for what holds it.
pub const STALL: Duration = Duration::from_secs(30);

    // rust: pub(in crate::game) struct PregenTask {
    // rust: pregen: Pregen,
    // rust: dim: Dim,
    // rust: paused: bool,
    /// Time spent running, up to the last pause, and when it last resumed.
    // rust: ran: Duration,
    // rust: resumed: Instant,
    // rust: reported: Instant,
    /// When the band last moved, to notice a task that stopped advancing.
    // rust: moved: Instant,
    /// The player who started it, told the progress too (a guest's connection).
    // rust: owner: Option<u32>,
}

    // rust: impl PregenTask {
pub fn running_for(self: *Self) D {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.paused {
    // rust: self.ran
    // rust: } else {
    // rust: self.ran + self.resumed.elapsed()
}
}
pub fn progress(self: *Self) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let p = &self.pregen;
    // rust: let seconds = self.running_for().as_secs_f64();
    // rust: let rate = p.done as f64 / seconds.max(1e-3);
    // rust: let left = p.total - p.done;
    // rust: let eta = if rate > 0.0 {
    // rust: duration(left as f64 / rate)
    // rust: } else {
    // rust: "unknown".into()
}
    // rust: Text::literal(format!(
    // rust: "Pregenerating {}: {} of {} chunks ({:.1}%), {rate:.1} chunks/s, {} left",
    // rust: self.dim.id(),
    // rust: p.done,
    // rust: p.total,
    // rust: 100.0 * p.done as f64 / p.total.max(1) as f64,
    // rust: if p.done == p.total {
    // rust: "nothing".into()
    // rust: } else {
    // rust: eta
    // rust: },
    // rust: ))
}
}

pub fn failure(message: []const u8) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: CommandError::new(Text::literal(message))
}

/// `1h 02m 03s`.
pub fn duration(seconds: f64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let s = seconds.round() as u64;
    // rust: match (s / 3600, s / 60 % 60, s % 60) {
    // rust: (0, 0, s) => format!("{s}s"),
    // rust: (0, m, s) => format!("{m}m {s:02}s"),
    // rust: (h, m, s) => format!("{h}h {m:02}m {s:02}s"),
}
}

    // rust: impl Game<'_> {
    // rust: pub(super) fn cmd_pregen(&mut self, id: &str, ctx: &Context) -> R<i32> {
    // rust: match id {
    // rust: "pregen.start" => {
    // rust: if self.cmds.pregen.is_some() {
    // rust: return Err(failure(
    // rust: "Pregeneration is already running: /pregen cancel stops it",
    // rust: ));
}
    // rust: let radius = Self::int(ctx, "radius").unwrap_or(0);
    // rust: let shape = if ctx.literals.iter().any(|l| l == "circle") {
    // rust: Shape::Circle
    // rust: } else {
    // rust: Shape::Square
}
    // rust: let [x, z] = if ctx.get("center").is_some() {
    // rust: self.column_arg(ctx, "center")?
    // rust: } else {
    // rust: let p = self.source_position();
    // rust: [p[0].floor() as i32, p[2].floor() as i32]
}
    // rust: let pregen = Pregen::new((x >> 4, z >> 4), radius >> 4, shape);
    // rust: let now = Instant::now();
    // rust: let total = pregen.total;
    // rust: self.feedback(Text::literal(format!(
    // rust: "Pregenerating {total} chunks of {}: a {} of radius {radius} around {x} {z}",
    // rust: self.dim.id(),
    // rust: match shape {
    // rust: Shape::Square => "square",
    // rust: Shape::Circle => "circle",
    // rust: },
    // rust: )));
    // rust: self.cmds.pregen = Some(PregenTask {
    // rust: pregen,
    // rust: dim: self.dim,
    // rust: paused: false,
    // rust: ran: Duration::ZERO,
    // rust: resumed: now,
    // rust: reported: now,
    // rust: moved: now,
    // rust: owner: self.lan_acting,
    // rust: });
    // rust: Ok(total as i32)
}
    // rust: "pregen.pause" | "pregen.continue" => {
    // rust: let pause = id == "pregen.pause";
    // rust: let task = self
    // rust: .cmds
    // rust: .pregen
    // rust: .as_mut()
    // rust: .ok_or_else(|| failure("No pregeneration is running"))?;
    // rust: if task.paused != pause {
    // rust: task.paused = pause;
    // rust: if pause {
    // rust: task.ran += task.resumed.elapsed();
    // rust: } else {
    // rust: task.resumed = Instant::now();
}
}
    // rust: let (progress, dim) = (task.progress(), task.dim);
    // rust: if pause && self.dim == dim {
    // rust: self.streaming.set_band(None);
}
    // rust: self.feedback(
    // rust: Text::literal(if pause { "Paused. " } else { "Continuing. " }).append(progress),
    // rust: );
    // rust: Ok(1)
}
    // rust: "pregen.cancel" => {
    // rust: let task = self
    // rust: .cmds
    // rust: .pregen
    // rust: .take()
    // rust: .ok_or_else(|| failure("No pregeneration is running"))?;
    // rust: if self.dim == task.dim {
    // rust: self.streaming.set_band(None);
}
    // rust: self.feedback(Text::literal("Cancelled. ").append(task.progress()));
    // rust: Ok(task.pregen.done as i32)
}
    // rust: _ => {
    // rust: let task = self
    // rust: .cmds
    // rust: .pregen
    // rust: .as_ref()
    // rust: .ok_or_else(|| failure("No pregeneration is running"))?;
    // rust: let progress = task.progress();
    // rust: let done = task.pregen.done as i32;
    // rust: self.feedback(progress);
    // rust: Ok(done)
}
}
}

    /// Move the task's band past the rows that are lit and hand it to the
    /// level's streaming, and report the progress now and then. Runs before
    /// each streaming update of the level in place.
    // rust: pub(in crate::game) fn tick_pregen(&mut self) {
    // rust: let Some(task) = self.cmds.pregen.as_mut() else {
    // rust: return;
}
    // rust: if task.dim != self.dim || task.paused {
    // rust: return;
}
        // A row is done once its chunks are lit and post-processed
        // (`postprocess_chunks`, on the tick), as vanilla's are by the time
        // they are FULL: then they may unload and be saved.
    // rust: let (streaming, chunks) = (&mut self.streaming, &self.world.chunks);
    // rust: if task.pregen.advance(|x, z| {
    // rust: streaming.is_lit(x, z)
    // rust: && chunks
    // rust: .get(&(x, z))
    // rust: .is_some_and(|c| c.postprocess.is_empty())
    // rust: }) {
    // rust: task.moved = Instant::now();
}
    // rust: streaming.set_band(task.pregen.band());
    // rust: if task.moved.elapsed() >= STALL {
            // Nothing advanced for a while: say what the first row waits
            // for, and queue light again for chunks that lost their job.
    // rust: task.moved = Instant::now();
    // rust: let row = task.pregen.first_row();
    // rust: let waiting = row
    // rust: .iter()
    // rust: .filter(|k| chunks.get(k).is_some_and(|c| !c.postprocess.is_empty()))
    // rust: .count();
    // rust: let [missing, lighting, unlit] = streaming.unstick_light(&mut self.world, &row);
    // rust: log::warn!(
    // rust: "Horizon: pregeneration waits on row {:?}: {missing} not loaded, {lighting} being lit, \
    // rust: {unlit} unlit with no light job (queued again), {waiting} not post-processed; {:?}",
    // rust: row.first(),
    // rust: streaming.stages()
    // rust: );
}
    // rust: let finished = task.pregen.finished();
    // rust: if finished || task.reported.elapsed() >= REPORT_EVERY {
    // rust: task.reported = Instant::now();
    // rust: let (owner, mut message) = (task.owner, task.progress());
    // rust: if finished {
    // rust: message = Text::literal("Done. ")
    // rust: .append(message)
    // rust: .with_color(text::GREEN);
    // rust: self.cmds.pregen = None;
}
    // rust: self.pregen_report(owner, message);
}
}

    /// Whether the level in place has a running task, which the server pumps
    /// between its ticks (`pump_chunks`).
    // rust: pub(in crate::game) fn pregen_runs_here(&self) -> bool {
    // rust: self.cmds
    // rust: .pregen
    // rust: .as_ref()
    // rust: .is_some_and(|t| t.dim == self.dim && !t.paused)
}

    /// The level a running task needs ticked, whoever is in it.
    // rust: pub(in crate::game) fn pregen_level(&self) -> Option<Dim> {
    // rust: self.cmds.pregen.as_ref().map(|t| t.dim)
}

    /// Keep the workers fed until `until`: collect what they finished and
    /// hand them the next jobs as soon as each one is done, rather than once
    /// a tick.
    // rust: pub(in crate::game) fn pump_chunks(&mut self, until: Instant, paused: bool) {
        // Force-loaded chunks too, a mod's held ones as `/forceload`'s: decorating in vanilla's order, a chunk
        // waits for its neighbours far more often than once a tick allows.
        // And the players' chunks while they load, as vanilla's server runs
        // its chunk tasks while it waits for the next tick
        // (`MinecraftServer.waitUntilNextTick`): once a tick, a few jobs per
        // worker (`schedule_generation`) capped joining a world at about 120
        // columns a second with two workers, the workers idle most of the
        // time. Not while a respawn search waits for a chunk: its area is
        // only asked for by the tick's own `update_world`.
    // rust: let players = !paused && self.spawn_wait.is_empty();
    // rust: while self.pregen_runs_here()
    // rust: || ((players
    // rust: || !self.streaming.forced.is_empty()
    // rust: || !self.streaming.mod_forced.is_empty())
    // rust: && self.streaming.busy())
    // rust: {
    // rust: let now = Instant::now();
    // rust: if now >= until {
    // rust: break;
}
    // rust: self.streaming
    // rust: .wait((until - now).min(Duration::from_millis(5)));
    // rust: self.update_world();
}
}

    /// The console and the player who started the task get the progress.
pub fn pregen_report(self: *Self, owner: ?u32, message: Text) void {
}
    // rust: if self.options.dedicated.is_some() {
    // rust: super::super::dedicated::log("INFO", &message.plain());
    // rust: } else {
    // rust: log::info!("{}", message.plain());
}
    // rust: if let Some(host) = &self.lan {
    // rust: if let Some(g) = owner.and_then(|c| host.hub.guest(c)) {
    // rust: g.send(&C::SystemChat(play::SystemChat {
    // rust: content: component_nbt(&message.component()),
    // rust: overlay: false,
    // rust: }));
}
    // rust: } else if self.options.dedicated.is_none() {
    // rust: self.system_message(message);
}
}
}
