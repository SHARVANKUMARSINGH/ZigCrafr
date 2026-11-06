//! Transpiled from Horizon Rust crate
//! Module: horizon-anticheat_lib
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The dedicated server's anticheat (docs/anticheat.md), without the game: the `[anticheat]` section of
//! `server.toml`, each player's violation levels, and the rules of the checks. The server's hub
//! (`horizon_client::lan`) feeds it what players send and carries out what it decides.
//!
//! It is on by default, and so is every check, but only the checks a vanilla client can't trip act on
//! their own (`combat`); the others log only until they have shown no false positive with real
//! players (their `setback`, `alert` and `kick` are 0). `enabled = false` turns the anticheat, or one
//! check, off. A check that fails *flags* the player: its violation level (VL) rises by the flag's
//! weight and falls back by `decay` a second. From `setback` on, the move or action is cancelled (the
//! player is sent back where the server last had them); from `alert` on, online operators and the
//! console are told; from `kick` on, the player is disconnected. A check's kicks are counted per player
//! across sessions ([`Strikes`]), and the kick that reaches its `ban_after` bans the player instead
//! (`banned-players.json`, reason "Horizon anticheat: <check>"). Any threshold at 0 turns that action
//! off.
//!
//! The checks are written from vanilla 26.3's own rules and from what cheats are publicly described to
//! do, never from another anticheat's code.

// use std::collections::BTreeMap;

// use serde::{Deserialize, Serialize};

    // rust: pub mod combat;
    // rust: pub mod prediction;
    // rust: pub mod timer;

/// What one check's violation level leads to.
pub const Actions = struct {
    setback: f32,
    alert: f32,
    kick: f32,
    /// Violation level lost each second.
    decay: f32,
    /// The kick, counting this check's earlier ones for the player, that bans instead; 0: never.
    ban_after: u32,
};

    // rust: macro_rules! checks {
    // rust: ($(
    // rust: $(#[$doc:meta])*
    // rust: $field:ident: $Check:ident => $Config:ident [$setback:expr, $alert:expr, $kick:expr, $decay:expr, $ban_after:expr] {
    // rust: $( $(#[$xdoc:meta])* $extra:ident: $ty:ty = $default:expr, )*
}
    // rust: )*) => {
        /// Every check, in the order of the players' violation levels.
pub const Check = enum {

    impl Check {,
pub const ALL: *[Check] = &[$(Check::$Check,)*];
            /// Its name in `server.toml` and in alerts.
    pub fn name(self) -> &'static str {,
    match self { $(Check::$Check => stringify!($field),)* },
};
}

    // rust: $(
    // rust: $(#[$doc])*
    // rust: pub struct $Config {
    // rust: pub enabled: bool,
    // rust: pub setback: f32,
    // rust: pub alert: f32,
    // rust: pub kick: f32,
    // rust: pub decay: f32,
    // rust: pub ban_after: u32,
    // rust: $( $(#[$xdoc])* pub $extra: $ty, )*
}

    // rust: impl Default for $Config {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: enabled: true,
    // rust: setback: $setback,
    // rust: alert: $alert,
    // rust: kick: $kick,
    // rust: decay: $decay,
    // rust: ban_after: $ban_after,
    // rust: $($extra: $default,)*
}
}
}
    // rust: )*

        /// `server.toml`'s `[anticheat]`: on by default.
pub const Config = struct {
    enabled: bool,
            /// Tell online operators of an alert in their chat (the console and the log always are).
    alerts: bool,
            /// The permission level a player needs to see alerts.
    alert_level: u8,
            /// Every flag, one line each, relative to the server's folder; empty: no file.
    log: []const u8,
            /// The players' kicks by check ([`Strikes`]), relative to the server's folder; empty: kept
            /// only while the server runs.
    strikes: []const u8,
    // rust: $(pub $field: $Config,)*
};

    // rust: impl Default for Config {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: enabled: true,
    // rust: alerts: true,
    // rust: alert_level: 2,
    // rust: log: "logs/anticheat.log".into(),
    // rust: strikes: "anticheat-strikes.json".into(),
    // rust: $($field: $Config::default(),)*
}
}
}

    // rust: impl Config {
            /// Whether `check` runs: the anticheat and the check both on.
pub fn runs(self: *Self, check: Check) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.enabled && match check { $(Check::$Check => self.$field.enabled,)* }
}

pub fn actions(self: *Self, check: Check) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match check {
    // rust: $(Check::$Check => {
    // rust: let c = &self.$field;
    // rust: Actions {
    // rust: setback: c.setback,
    // rust: alert: c.alert,
    // rust: kick: c.kick,
    // rust: decay: c.decay,
    // rust: ban_after: c.ban_after,
}
    // rust: })*
}
}
}
}
}

    // rust: checks! {
    /// Timer: more client ticks than the server's clock allows (a sped-up game). Vanilla's client ends
    /// every tick with ServerboundClientTickEndPacket, at the server's tick rate; each one spends a tick's
    /// time from a balance that wall-clock time fills, capped so a pause can't be saved up for a burst.
    /// It logs only by default; once trusted: `setback = 2`, `alert = 5`, `kick = 20`.
    // rust: timer: Timer => TimerConfig [0.0, 0.0, 0.0, 0.02, 0] {
        /// How far ahead of the clock, in milliseconds, a client may get before it is flagged.
    // rust: tolerance_ms: f64 = 300.0,
        /// The most time, in milliseconds, a quiet connection banks for the ticks that follow (a lag
        /// spike's backlog arrives at once).
    // rust: max_lag_ms: f64 = 1000.0,
}

    /// Ground: a move that says it ends on the ground with nothing there to stand on: no-fall (claiming
    /// the ground to skip fall damage) and walking on water. The claim is dropped, so vanilla's
    /// fall damage follows (the player is never sent back: `setback = 0` makes the check log only), and
    /// a player that keeps claiming is kicked, then banned at the second kick (`ban_after = 2`). A claim standing still isn't
    /// judged (no fall to skip). On the official server's first two hours (67 players), every player who
    /// wasn't flying or walking on water peaked at level 7 (4 claims standing still in one second); the
    /// ones who were, at 113 to 3749.
    // rust: ground: Ground => GroundConfig [10.0, 15.0, 30.0, 2.0, 2] {}

    /// Prediction: each move played again from the client's own inputs with vanilla's movement code,
    /// and compared (speed, step, fly, jesus...). Each player's client ticks are recorded
    /// (`prediction::Record`), with a ping a tick to place what the server changes, and played again
    /// (horizon-client's `lan::prediction`). A move that lands farther than `tolerance` from the
    /// replay flags, by how far it lands (one `tolerance` off weighs 1, at most 5 a tick), and the
    /// setback puts the player back where its moves last agreed. A tick near what the replay can't
    /// play yet (another entity, a block change or abilities the client hadn't seen, a moving piston,
    /// a chunk the client doesn't have, a riptide launch) is excused, and so are the ticks after it
    /// until the moves agree again. It logs only by default; once trusted: `setback = 5`, `alert = 15`,
    /// `kick = 60`.
    // rust: prediction: Prediction => PredictionConfig [0.0, 0.0, 0.0, 2.0, 0] {
        /// How far, in blocks, a move may land from where the replay puts it.
    // rust: tolerance: f64 = 0.03,
}

    /// Combat: attacks vanilla's client can't send (`combat`): one with no swing after it (a kill aura
    /// that hides its swing), or a second entity attacked in the same client tick (vanilla attacks the
    /// one entity under the crosshair, picked once a tick). Each flags once; from `setback` on the
    /// player's attacks are dropped. A vanilla client never trips it, so it acts by default: the first
    /// kick warns, the second bans (`ban_after = 2`).
    // rust: combat: Combat => CombatConfig [2.0, 5.0, 20.0, 0.5, 2] {}
}

/// How many checks there are.
pub const CHECKS: usize = Check::ALL.len();

    // rust: impl Config {
    /// The `[anticheat]` section of a whole `server.toml`; the default (off) when it has none.
pub fn from_server_toml(text: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
pub const File = struct {
    anticheat: Config,
};
        // Other sections are the supervisor's to check: only this one is read here.
    // rust: let mut table: toml::Table = toml::from_str(text).map_err(|e| e.to_string())?;
    // rust: let mut only = toml::Table::new();
    // rust: if let Some(section) = table.remove("anticheat") {
    // rust: only.insert("anticheat".into(), section);
}
    // rust: let file: File = only
    // rust: .try_into()
    // rust: .map_err(|e: toml::de::Error| format!("[anticheat]: {e}"))?;
    // rust: file.anticheat.check()?;
    // rust: Ok(file.anticheat)
}

    /// Thresholds can't be negative.
pub fn check(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: for &c in Check::ALL {
    // rust: let a = self.actions(c);
    // rust: if [a.setback, a.alert, a.kick, a.decay]
    // rust: .iter()
    // rust: .any(|v| !v.is_finite() || *v < 0.0)
    // rust: {
    // rust: return Err(format!(
    // rust: "anticheat.{}: setback, alert, kick and decay are numbers from 0 up",
    // rust: c.name()
    // rust: ));
}
}
    // rust: let tolerance = self.prediction.tolerance;
    // rust: if !tolerance.is_finite() || tolerance <= 0.0 {
    // rust: return Err("anticheat.prediction: tolerance is a number of blocks above 0".into());
}
    // rust: Ok(())
}
}

/// How many times each check kicked each player, kept across sessions (`strikes`, a JSON object of
/// players' UUIDs to check names to counts): the kick that reaches a check's `ban_after` is a ban.
pub const Strikes = struct {};

    // rust: impl Strikes {
    /// Player `uuid` was kicked by `check`: its kicks by it so far, this one included, and whether this
    /// one bans. A ban starts the count again, so a player an operator pardons is kicked before the
    /// next ban.
pub fn kick(self: *Self, uuid: []const u8, check: Check, ban_after: u32) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let count = self
    // rust: .0
    // rust: .entry(uuid.to_owned())
    // rust: .or_default()
    // rust: .entry(check.name().to_owned())
    // rust: .or_default();
    // rust: *count = count.saturating_add(1);
    // rust: let kicks = *count;
    // rust: let ban = ban_after > 0 && kicks >= ban_after;
    // rust: if ban {
    // rust: *count = 0;
}
    // rust: (kicks, ban)
}
}

/// What a flag leads to.
pub const Verdict = struct {
    /// The check's violation level after the flag.
    vl: f32,
    /// Cancel the move or action.
    setback: bool,
    /// Tell operators and the console (at most once a second per check).
    alert: bool,
    kick: bool,
};

/// One player's anticheat state. Clean players cost nothing: levels only change when a check flags.
pub const Player = struct {
    vl: [f32,
    /// The server tick of each check's last flag (its decay runs from there).
    flagged: [u64,
    /// The server tick of each check's last alert.
    alerted: [?u64,
    timer: timer::Balance,
    /// The server tick and height where the ground last held the player.
    ground: Option<(u64,
    /// The client ticks the prediction plays again (only while it runs).
    record: ?*prediction::Record,
    /// Sprinting as the client's own commands left it (ServerboundPlayerCommandPacket's
    /// START_SPRINTING and STOP_SPRINTING: LocalPlayer.wasSprinting), which the record's ticks take.
    /// Not the server's player: a hit with extra knockback stops its sprint
    /// (Player.causeExtraKnockback), the client's own `Player.attack` doesn't (a mob's `hurtClient`
    /// is false), and once the server's flag reaches it LocalPlayer.aiStep starts the sprint again
    /// while the sprint key is held, with nothing to say: wasSprinting never changed.
    sprinting: bool,
    /// The attacks of the client tick being heard.
    attacks: combat::Attacks,
};

    // rust: impl Player {
    /// The check's violation level at `tick`, with its decay since the last flag.
pub fn vl(self: *Self, config: *Config, check: Check, tick: u64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let i = check as usize;
    // rust: let seconds = tick.saturating_sub(self.flagged[i]) as f32 / 20.0;
    // rust: (self.vl[i] - config.actions(check).decay * seconds).max(0.0)
}

    /// `check` failed with this weight at server tick `tick`.
pub fn flag(self: *Self, config: *Config, check: Check, weight: f32, tick: u64) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let i = check as usize;
    // rust: let a = config.actions(check);
    // rust: let vl = self.vl(config, check, tick) + weight;
    // rust: self.vl[i] = vl;
    // rust: self.flagged[i] = tick;
    // rust: let reached = |threshold: f32| threshold > 0.0 && vl >= threshold;
    // rust: let alert = reached(a.alert) && self.alerted[i].is_none_or(|t| tick >= t + 20);
    // rust: if alert {
    // rust: self.alerted[i] = Some(tick);
}
    // rust: Verdict {
    // rust: vl,
    // rust: setback: reached(a.setback),
    // rust: alert,
    // rust: kick: reached(a.kick),
}
}
}

    // rust: mod tests {
//     use super::*;

pub fn on() C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Config {
    // rust: enabled: true,
    // rust: ..Config::default()
}
}

pub fn on_by_default_but_only_combat_and_ground_act() void {
}
    // rust: let c = Config::from_server_toml("[server]\nport = 25565\n").unwrap();
    // rust: assert_eq!(c, Config::default());
    // rust: for &check in Check::ALL {
    // rust: assert!(c.runs(check), "{}", check.name());
    // rust: let a = c.actions(check);
    // rust: let acts = [a.setback, a.alert, a.kick] != [0.0; 3];
    // rust: assert_eq!(
    // rust: acts,
    // rust: matches!(check, Check::Combat | Check::Ground),
    // rust: "{}",
    // rust: check.name()
    // rust: );
}
    // rust: let off = Config::from_server_toml("[anticheat]\nenabled = false\n").unwrap();
    // rust: assert!(Check::ALL.iter().all(|&check| !off.runs(check)));
}

pub fn reads_its_section() void {
}
    // rust: let text = "[server]\nport = 1\n[anticheat]\nenabled = true\n[anticheat.timer]\nkick = 0\ntolerance_ms = 500\n";
    // rust: let c = Config::from_server_toml(text).unwrap();
    // rust: assert!(c.runs(Check::Timer));
    // rust: assert_eq!(c.timer.kick, 0.0);
    // rust: assert_eq!(c.timer.tolerance_ms, 500.0);
    // rust: assert_eq!(c.timer.alert, TimerConfig::default().alert);
    // rust: let zero = "[anticheat]\n[anticheat.prediction]\ntolerance = 0\n";
    // rust: assert!(Config::from_server_toml(zero).is_err());
    // rust: let off = "[anticheat]\nenabled = true\n[anticheat.timer]\nenabled = false\n";
    // rust: assert!(!Config::from_server_toml(off).unwrap().runs(Check::Timer));
}

pub fn refuses_unknown_keys_and_negative_levels() void {
}
    // rust: assert!(Config::from_server_toml("[anticheat]\nenable = true\n").is_err());
    // rust: assert!(Config::from_server_toml("[anticheat.timer]\nkick = -1\n").is_err());
}

pub fn levels_rise_decay_and_act_in_order() void {
}
    // rust: let mut c = on();
    // rust: c.timer = TimerConfig {
    // rust: setback: 2.0,
    // rust: alert: 3.0,
    // rust: kick: 5.0,
    // rust: decay: 1.0,
    // rust: ..TimerConfig::default()
}
    // rust: let mut p = Player::default();
    // rust: let v = p.flag(&c, Check::Timer, 1.0, 100);
    // rust: assert_eq!((v.setback, v.alert, v.kick), (false, false, false));
    // rust: let v = p.flag(&c, Check::Timer, 1.0, 100);
    // rust: assert_eq!((v.vl, v.setback, v.alert), (2.0, true, false));
    // rust: let v = p.flag(&c, Check::Timer, 1.0, 100);
    // rust: assert!(v.alert && !v.kick);
        // At most one alert a second.
    // rust: assert!(!p.flag(&c, Check::Timer, 0.5, 110).alert);
        // 3 at tick 110 (half a level gone, half added); two seconds later two more are gone.
    // rust: assert_eq!(p.vl(&c, Check::Timer, 150), 1.0);
    // rust: assert_eq!(p.vl(&c, Check::Timer, 10_000), 0.0);
    // rust: let v = p.flag(&c, Check::Timer, 5.0, 10_000);
    // rust: assert!(v.kick && v.alert);
}

pub fn the_kick_that_reaches_ban_after_bans() void {
}
    // rust: let c = Config::default();
    // rust: assert_eq!(c.actions(Check::Combat).ban_after, 2);
    // rust: assert_eq!(c.actions(Check::Prediction).ban_after, 0);
    // rust: let mut s = Strikes::default();
    // rust: assert_eq!(s.kick("a", Check::Combat, 2), (1, false));
        // Another player, another check: their own counts.
    // rust: assert_eq!(s.kick("b", Check::Combat, 2), (1, false));
    // rust: assert_eq!(s.kick("a", Check::Timer, 2), (1, false));
    // rust: assert_eq!(s.kick("a", Check::Combat, 2), (2, true));
        // Pardoned, the player is kicked once more before the next ban.
    // rust: assert_eq!(s.kick("a", Check::Combat, 2), (1, false));
        // 0 never bans; 1 bans at the first kick.
    // rust: assert_eq!(s.kick("c", Check::Timer, 0), (1, false));
    // rust: assert_eq!(s.kick("c", Check::Timer, 0), (2, false));
    // rust: assert_eq!(s.kick("d", Check::Ground, 1), (1, true));
}

pub fn zero_turns_an_action_off() void {
}
    // rust: let mut c = on();
    // rust: c.timer.kick = 0.0;
    // rust: let mut p = Player::default();
    // rust: assert!(!p.flag(&c, Check::Timer, 1000.0, 1).kick);
}
}
