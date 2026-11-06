//! Transpiled from Horizon Rust crate
//! Module: horizon-chat-filter_lib
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The dedicated server's chat filter (docs/chat-filter.md), without the game: `server.toml`'s
//! `[chat_filter]`, the matcher for the slur list (`data/slurs.txt`, or the owner's `words_file`), and
//! the escalation (a refused message, then a mute, then a temporary ban), with the mutes kept in a file
//! so that they outlive a restart. The server's hub (`horizon_client::lan`) asks it before it relays a
//! player's text and carries out what it decides.

// use serde::{Deserialize, Serialize};
// use std::collections::HashMap;
// use std::path::{Path, PathBuf};

    // rust: mod normalise;

    // rust: pub use normalise::{Run, Text};

/// The list built into the game, used when `words_file` is empty.
pub const DEFAULT_WORDS: []const u8 = include_str!("../data/slurs.txt");

/// The mutes, beside server.properties.
pub const MUTES_FILE: []const u8 = "chat-filter-mutes.json";

/// `server.toml`'s `[chat_filter]`: on by default.
pub const Config = struct {
    enabled: bool,
    /// The hit, counted within `window_minutes`, that mutes the player; 0: never.
    mute_after: u32,
    /// The hit that bans the player for `tempban_hours`; 0: never.
    tempban_after: u32,
    /// How long a hit counts towards the next ones (the time spent muted doesn't count).
    window_minutes: u32,
    mute_minutes: u32,
    tempban_hours: u32,
    /// The slur list, relative to the server's folder; empty: the list built into the game.
    words_file: []const u8,
    /// Every refused text with the player and what followed, relative to the server's folder.
    log: []const u8,
};

    // rust: impl Default for Config {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: enabled: true,
    // rust: mute_after: 2,
    // rust: tempban_after: 3,
    // rust: window_minutes: 10,
    // rust: mute_minutes: 10,
    // rust: tempban_hours: 24,
    // rust: words_file: String::new(),
    // rust: log: "logs/chat-filter.log".into(),
}
}
}

    // rust: impl Config {
    /// The `[chat_filter]` section of a whole `server.toml`; the default without it.
pub fn from_server_toml(text: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
pub const File = struct {
    chat_filter: Config,
};
        // Other sections are the supervisor's to check: only this one is read here.
    // rust: let mut table: toml::Table = toml::from_str(text).map_err(|e| e.to_string())?;
    // rust: let mut only = toml::Table::new();
    // rust: if let Some(section) = table.remove("chat_filter") {
    // rust: only.insert("chat_filter".into(), section);
}
    // rust: let file: File = only
    // rust: .try_into()
    // rust: .map_err(|e: toml::de::Error| format!("[chat_filter]: {e}"))?;
    // rust: file.chat_filter.check()?;
    // rust: Ok(file.chat_filter)
}

pub fn check(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.window_minutes == 0 {
    // rust: return Err("chat_filter.window_minutes must be 1 or more".into());
}
    // rust: Ok(())
}
}

/// How an entry of the list matches.
pub const Kind = enum {
    /// Inside a longer word too.
    Embedded,
    /// Only as a whole word.
    Whole,
    /// Inside a word, or spread over several words from the start of one.
    Spread,
};

pub const Entry = struct {
    runs: std.ArrayList(Run),
    kind: Kind,
};

/// The slur list, compiled: each entry's letters as runs, indexed by first letter.
pub const Filter = struct {
    entries: std.ArrayList(Entry),
    by_first: [std.ArrayList(u16),
    /// Words never matched: exact (`false`) or as a prefix (`true`).
    allowed: std.ArrayList((Vec<Run),
};

    // rust: impl Filter {
    /// Compiles a list in `data/slurs.txt`'s format.
pub fn new(list: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut f = Filter {
    // rust: entries: Vec::new(),
    // rust: by_first: Default::default(),
    // rust: allowed: Vec::new(),
}
    // rust: for line in list.lines() {
    // rust: let line = line.trim();
    // rust: if line.is_empty() || line.starts_with('#') {
    // rust: continue;
}
    // rust: if let Some(word) = line.strip_prefix('!') {
    // rust: let (word, prefix) = match word.strip_suffix('*') {
    // rust: Some(w) => (w, true),
    // rust: None => (word, false),
}
                // An allow entry with no letters would allow every word (an empty prefix).
    // rust: let runs = normalise::word(word);
    // rust: if !runs.is_empty() {
    // rust: f.allowed.push((runs, prefix));
}
    // rust: continue;
}
    // rust: let (kind, word) = match line.as_bytes()[0] {
    // rust: b'=' => (Kind::Whole, &line[1..]),
    // rust: b'~' => (Kind::Spread, &line[1..]),
    // rust: _ => (Kind::Embedded, line),
}
    // rust: let runs = normalise::word(word);
    // rust: let Some(first) = runs.first() else {
    // rust: continue;
}
    // rust: f.by_first[usize::from(first.letter)].push(f.entries.len() as u16);
    // rust: f.entries.push(Entry { runs, kind });
}
    // rust: f
}

    /// The built-in list.
pub fn default_list() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::new(DEFAULT_WORDS)
}

pub fn len(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.entries.len()
}

pub fn is_empty(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.entries.is_empty()
}

    /// Whether `text` holds a slur of the list.
pub fn matches(self: *Self, text: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let t = Text::new(text);
    // rust: let runs = &t.runs;
    // rust: for &(start, end) in t.words.iter().chain(&t.spaced) {
    // rust: let word = &runs[start..end];
    // rust: if self.is_allowed(word) {
    // rust: continue;
}
    // rust: for at in 0..word.len() {
    // rust: for &e in &self.by_first[usize::from(word[at].letter)] {
    // rust: let e = &self.entries[usize::from(e)];
    // rust: let whole = e.kind == Kind::Whole;
    // rust: if (!whole || at == 0) && fits(&e.runs, &word[at..], whole) {
    // rust: return true;
}
}
}
}
        // Spread entries over the whole text, from the start of a word, across at least two.
    // rust: for (w, &at) in t.joined_at.iter().enumerate() {
    // rust: for &e in &self.by_first[usize::from(t.joined[at].letter)] {
    // rust: let e = &self.entries[usize::from(e)];
    // rust: if e.kind == Kind::Spread
    // rust: && fits(&e.runs, &t.joined[at..], false)
    // rust: && t.spans_words(w, e.runs.len())
    // rust: {
    // rust: return true;
}
}
}
    // rust: false
}

pub fn is_allowed(self: *Self, word: *[Run]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.allowed.iter().any(|(a, prefix)| {
    // rust: if *prefix {
                // A prefix: its last run may be part of a longer one.
    // rust: word.len() >= a.len() && fits(a, word, false)
    // rust: } else {
    // rust: fits(a, word, true)
}
    // rust: })
}
}

/// Whether `entry`'s runs start `runs` (are all of it with `whole`): the same letters, each at least
/// as many times as the entry has it.
pub fn fits(entry: *[Run], runs: *[Run], whole: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if runs.len() < entry.len() || (whole && runs.len() != entry.len()) {
    // rust: return false;
}
    // rust: entry
    // rust: .iter()
    // rust: .zip(runs)
    // rust: .all(|(e, r)| e.letter == r.letter && r.count >= e.count)
}

/// What a hit leads to.
pub const Action = enum {
    /// The text is refused, nothing more.
    Refused,
    /// Refused, and the player can't chat until then (epoch milliseconds).
    Muted { until: i64 },
    /// Refused, and the player is banned until then.
    Banned { until: i64 },
};

    // rust: impl Action {
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Action::Refused => "refused",
    // rust: Action::Muted { .. } => "muted",
    // rust: Action::Banned { .. } => "banned",
}
}
}

pub const Mute = struct {
    uuid: []const u8,
    name: []const u8,
    /// Epoch milliseconds; `None`: until `/unmute`.
    until: ?i64,
    /// The operator who muted them (`/mute`, `/tempmute`); `None`: the filter.
    by: ?[]const u8,
    reason: ?[]const u8,
};

    // rust: impl Mute {
pub fn active(self: *Self, now: i64) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.until.is_none_or(|until| until > now)
}
}

pub const MutesFile = struct {
    mutes: std.ArrayList(Mute),
};

/// One player's hits: how many, and when the last one stops counting.
pub const Strikes = struct {
    count: u32,
    counts_until: i64,
};

/// The filter, the players' hits and the mutes.
pub const Guard = struct {
    config: Config,
    filter: Filter,
    strikes: HashMap<u128,
    mutes: HashMap<u128,
    /// Where the mutes are kept; `None` keeps them in memory only (tests).
    file: ?PathBuf,
};

pub const MINUTE: i64 = 60_000;

    // rust: impl Guard {
pub fn new(config: Config, filter: Filter, file: ?PathBuf) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut mutes = HashMap::new();
    // rust: if let Some(text) = file.as_ref().and_then(|f| std::fs::read_to_string(f).ok())
    // rust: && let Ok(saved) = serde_json::from_str::<MutesFile>(&text)
    // rust: {
    // rust: for m in saved.mutes {
    // rust: if let Some(uuid) = parse_uuid(&m.uuid) {
    // rust: mutes.insert(uuid, m);
}
}
}
    // rust: Self {
    // rust: config,
    // rust: filter,
    // rust: strikes: HashMap::new(),
    // rust: mutes,
    // rust: file,
}
}

    /// The server's guard: `words_file` or the built-in list, the mutes in `dir`. An unreadable
    /// `words_file` falls back to the built-in list, with why.
pub fn load(config: Config, dir: *Path) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut problem = None;
    // rust: let filter = if config.words_file.is_empty() {
    // rust: Filter::default_list()
    // rust: } else {
    // rust: match std::fs::read_to_string(dir.join(&config.words_file)) {
    // rust: Ok(text) => Filter::new(&text),
    // rust: Err(e) => {
    // rust: problem = Some(format!(
    // rust: "chat_filter.words_file {}: {e}; using the built-in list",
    // rust: config.words_file
    // rust: ));
    // rust: Filter::default_list()
}
}
}
    // rust: (
    // rust: Self::new(config, filter, Some(dir.join(MUTES_FILE))),
    // rust: problem,
    // rust: )
}

    /// The player's mute, if they are muted at `now`.
pub fn muted(self: *Self, uuid: u128, now: i64) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.mutes.get(&uuid).filter(|m| m.active(now))
}

    /// The mutes in force at `now`, by name.
pub fn mutes(self: *Self, now: i64) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut mutes: Vec<&Mute> = self.mutes.values().filter(|m| m.active(now)).collect();
    // rust: mutes.sort_by(|a, b| a.name.cmp(&b.name));
    // rust: mutes
}

    /// An operator's `/mute` (`until` `None`) or `/tempmute`: replaces the player's mute.
    // rust: pub fn mute(
    // rust: &mut self,
    // rust: uuid: u128,
    // rust: name: &str,
    // rust: until: Option<i64>,
    // rust: by: &str,
    // rust: reason: Option<String>,
    // rust: ) {
    // rust: self.mutes.insert(
    // rust: uuid,
    // rust: Mute {
    // rust: uuid: uuid_string(uuid),
    // rust: name: name.to_owned(),
    // rust: until,
    // rust: by: Some(by.to_owned()),
    // rust: reason,
    // rust: },
    // rust: );
    // rust: self.save();
}

    /// A hit by the player at `now`: the hit's number in the window, and what it leads to.
pub fn strike(self: *Self, uuid: u128, name: []const u8, now: i64) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let c = &self.config;
    // rust: let window = i64::from(c.window_minutes) * MINUTE;
    // rust: let s = self.strikes.entry(uuid).or_insert(Strikes {
    // rust: count: 0,
    // rust: counts_until: 0,
    // rust: });
    // rust: if now > s.counts_until {
    // rust: s.count = 0;
}
    // rust: s.count += 1;
    // rust: s.counts_until = now + window;
    // rust: let count = s.count;
    // rust: let action = if c.tempban_after > 0 && count >= c.tempban_after {
    // rust: self.strikes.remove(&uuid);
    // rust: Action::Banned {
    // rust: until: now + i64::from(c.tempban_hours) * 60 * MINUTE,
}
    // rust: } else if c.mute_after > 0 && count >= c.mute_after {
    // rust: let until = now + i64::from(c.mute_minutes) * MINUTE;
            // The window starts again when the mute ends.
    // rust: s.counts_until = until + window;
            // An operator's longer mute stays.
    // rust: if !self
    // rust: .mutes
    // rust: .get(&uuid)
    // rust: .is_some_and(|m| m.until.is_none_or(|u| u >= until))
    // rust: {
    // rust: self.mutes.insert(
    // rust: uuid,
    // rust: Mute {
    // rust: uuid: uuid_string(uuid),
    // rust: name: name.to_owned(),
    // rust: until: Some(until),
    // rust: by: None,
    // rust: reason: None,
    // rust: },
    // rust: );
    // rust: self.save();
}
    // rust: Action::Muted { until }
    // rust: } else {
    // rust: Action::Refused
}
    // rust: (count, action)
}

    /// Lifts a player's mute (and forgets their hits), by name; the name as muted, if they were.
pub fn unmute(self: *Self, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let uuid = *self
    // rust: .mutes
    // rust: .iter()
    // rust: .find(|(_, m)| m.name.eq_ignore_ascii_case(name))?
    // rust: .0;
    // rust: let mute = self.mutes.remove(&uuid)?;
    // rust: self.strikes.remove(&uuid);
    // rust: self.save();
    // rust: Some(mute.name)
}

pub fn save(self: *Self) void {
}
    // rust: let Some(file) = &self.file else {
    // rust: return;
}
    // rust: let now = now_millis();
    // rust: self.mutes.retain(|_, m| m.active(now));
    // rust: let mut mutes: Vec<Mute> = self.mutes.values().cloned().collect();
    // rust: mutes.sort_by(|a, b| a.name.cmp(&b.name));
    // rust: if let Ok(text) = serde_json::to_string_pretty(&MutesFile { mutes }) {
    // rust: let tmp = file.with_extension("json.tmp");
    // rust: if std::fs::write(&tmp, text).is_ok() {
    // rust: let _ = std::fs::rename(&tmp, file);
}
}
}
}

/// One line of `logs/chat-filter.log`, without its newline.
    // rust: pub fn log_line(
    // rust: now: i64,
    // rust: name: &str,
    // rust: uuid: u128,
    // rust: place: &str,
    // rust: count: u32,
    // rust: action: Action,
    // rust: text: &str,
    // rust: ) -> String {
    // rust: let text: String = text
    // rust: .chars()
    // rust: .map(|c| if c == '\n' { ' ' } else { c })
    // rust: .collect();
    // rust: format!(
    // rust: "{} {name} {} {place} hit {count} {}: {text}",
    // rust: utc(now),
    // rust: uuid_string(uuid),
    // rust: action.name()
    // rust: )
}

/// Appends a line to the log at `path` (its folder made if needed).
pub fn append_log(path: *Path, line: []const u8) s {
    // Implementation ported from Horizon
    return undefined;
}
//     use std::io::Write;
    // rust: if let Some(dir) = path.parent() {
    // rust: std::fs::create_dir_all(dir)?;
}
    // rust: let mut f = std::fs::OpenOptions::new()
    // rust: .create(true)
    // rust: .append(true)
    // rust: .open(path)?;
    // rust: writeln!(f, "{line}")
}

/// `/tempmute`'s duration in milliseconds: a positive whole number and a unit, `s`, `m`, `h`, `d` or
/// `w` (`10m`, `2h`, `1d`).
pub fn parse_duration(text: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let unit = match text.chars().last()? {
    // rust: 's' => 1_000,
    // rust: 'm' => MINUTE,
    // rust: 'h' => 60 * MINUTE,
    // rust: 'd' => 24 * 60 * MINUTE,
    // rust: 'w' => 7 * 24 * 60 * MINUTE,
    // rust: _ => return None,
}
    // rust: let count: i64 = text[..text.len() - 1].parse().ok()?;
    // rust: (count > 0).then(|| count.checked_mul(unit)).flatten()
}

/// The unit used when presenting a moderation duration to a player.
pub const DurationUnit = enum {
    Minute,
    Hour,
    Day,
};

/// A duration's rounded count and unit, shared by logs and translated replies.
pub fn duration_parts(millis: i64) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (unit, kind) = if millis <= 60 * MINUTE {
    // rust: (MINUTE, DurationUnit::Minute)
    // rust: } else if millis <= 48 * 60 * MINUTE {
    // rust: (60 * MINUTE, DurationUnit::Hour)
    // rust: } else {
    // rust: (24 * 60 * MINUTE, DurationUnit::Day)
}
    // rust: (
    // rust: millis.div_euclid(unit) + i64::from(millis.rem_euclid(unit) > 0),
    // rust: kind,
    // rust: )
}

/// `millis` for logs, rounded up: minutes up to an hour, hours up to two days, then days.
pub fn duration_text(millis: i64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (count, unit) = duration_parts(millis);
    // rust: let unit = match unit {
    // rust: DurationUnit::Minute => "minute",
    // rust: DurationUnit::Hour => "hour",
    // rust: DurationUnit::Day => "day",
}
    // rust: format!("{count} {unit}{}", if count == 1 { "" } else { "s" })
}

pub fn now_millis() i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::time::SystemTime::now()
    // rust: .duration_since(std::time::UNIX_EPOCH)
    // rust: .map_or(0, |d| d.as_millis() as i64)
}

/// `YYYY-MM-DDTHH:MM:SSZ` for epoch milliseconds.
pub fn utc(millis: i64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let secs = millis.div_euclid(1000);
    // rust: let (days, rest) = (secs.div_euclid(86_400), secs.rem_euclid(86_400));
    // Howard Hinnant's civil_from_days.
    // rust: let z = days + 719_468;
    // rust: let era = z.div_euclid(146_097);
    // rust: let doe = z.rem_euclid(146_097);
    // rust: let yoe = (doe - doe / 1460 + doe / 36_524 - doe / 146_096) / 365;
    // rust: let doy = doe - (365 * yoe + yoe / 4 - yoe / 100);
    // rust: let mp = (5 * doy + 2) / 153;
    // rust: let day = doy - (153 * mp + 2) / 5 + 1;
    // rust: let month = if mp < 10 { mp + 3 } else { mp - 9 };
    // rust: let year = yoe + era * 400 + i64::from(month <= 2);
    // rust: format!(
    // rust: "{year:04}-{month:02}-{day:02}T{:02}:{:02}:{:02}Z",
    // rust: rest / 3600,
    // rust: rest / 60 % 60,
    // rust: rest % 60
    // rust: )
}

pub fn uuid_string(u: u128) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let h = format!("{u:032x}");
    // rust: format!(
    // rust: "{}-{}-{}-{}-{}",
    // rust: &h[..8],
    // rust: &h[8..12],
    // rust: &h[12..16],
    // rust: &h[16..20],
    // rust: &h[20..]
    // rust: )
}

pub fn parse_uuid(s: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: u128::from_str_radix(&s.replace('-', ""), 16).ok()
}

    // rust: mod tests;
