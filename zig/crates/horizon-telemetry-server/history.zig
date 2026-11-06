//! Transpiled from Horizon Rust crate
//! Module: horizon-telemetry-server_history
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The live count over time, for playhorizon.dev/stats: `GET /v1/live/history`.
//!
//! Once a minute the server writes the live count (`live`) down: how many play, how many have a
//! world open to LAN or friends, and how many per platform. Only those totals, never a session,
//! a version or an address. Three tables, coarser as they age:
//!
//! - `live_minute`: one row a minute, kept [`crate::Config::live_minute_days`] (7 days).
//! - `live_hour`: per hour, the minutes' sum and count (for the average) and the highest one with
//!   its minute, kept [`crate::Config::live_hour_days`] (90 days).
//! - `live_day`: the same per day (UTC), kept forever.
//!
//! The `official_` tables hold the official server's player count the same way
//! ([`Series::Official`]), from its server-list status ping (`horizon_telemetry::server_status`),
//! playing only: a minute the server didn't answer has no row, so its downtime shows as a gap.
//!
//! The hour and day rows are updated with each minute, so they hold the current hour and day too.
//! Times are Unix seconds (UTC), each row's the start of its minute, hour or day.
// use std::collections::BTreeMap;

// use horizon_telemetry::live::{Count, PLATFORMS};
// use rusqlite::{OptionalExtension, params};
// use serde::Serialize;

// use crate::store::Store;

    // rust: pub const SCHEMA: &str = "
    // rust: CREATE TABLE IF NOT EXISTS live_minute (
    // rust: t INTEGER PRIMARY KEY, playing INTEGER NOT NULL, lan INTEGER NOT NULL,
    // rust: linux INTEGER NOT NULL, macos INTEGER NOT NULL, windows INTEGER NOT NULL, other INTEGER NOT NULL
    // rust: ) WITHOUT ROWID;
    // rust: CREATE TABLE IF NOT EXISTS live_hour (
    // rust: t INTEGER PRIMARY KEY, samples INTEGER NOT NULL, peak INTEGER NOT NULL, peak_at INTEGER NOT NULL,
    // rust: sum INTEGER NOT NULL, lan_peak INTEGER NOT NULL, lan_sum INTEGER NOT NULL,
    // rust: linux_sum INTEGER NOT NULL, macos_sum INTEGER NOT NULL, windows_sum INTEGER NOT NULL,
    // rust: other_sum INTEGER NOT NULL
    // rust: ) WITHOUT ROWID;
    // rust: CREATE TABLE IF NOT EXISTS live_day (
    // rust: t INTEGER PRIMARY KEY, samples INTEGER NOT NULL, peak INTEGER NOT NULL, peak_at INTEGER NOT NULL,
    // rust: sum INTEGER NOT NULL, lan_peak INTEGER NOT NULL, lan_sum INTEGER NOT NULL,
    // rust: linux_sum INTEGER NOT NULL, macos_sum INTEGER NOT NULL, windows_sum INTEGER NOT NULL,
    // rust: other_sum INTEGER NOT NULL
    // rust: ) WITHOUT ROWID;

    // rust: CREATE TABLE IF NOT EXISTS official_minute (
    // rust: t INTEGER PRIMARY KEY, playing INTEGER NOT NULL, lan INTEGER NOT NULL,
    // rust: linux INTEGER NOT NULL, macos INTEGER NOT NULL, windows INTEGER NOT NULL, other INTEGER NOT NULL
    // rust: ) WITHOUT ROWID;
    // rust: CREATE TABLE IF NOT EXISTS official_hour (
    // rust: t INTEGER PRIMARY KEY, samples INTEGER NOT NULL, peak INTEGER NOT NULL, peak_at INTEGER NOT NULL,
    // rust: sum INTEGER NOT NULL, lan_peak INTEGER NOT NULL, lan_sum INTEGER NOT NULL,
    // rust: linux_sum INTEGER NOT NULL, macos_sum INTEGER NOT NULL, windows_sum INTEGER NOT NULL,
    // rust: other_sum INTEGER NOT NULL
    // rust: ) WITHOUT ROWID;
    // rust: CREATE TABLE IF NOT EXISTS official_day (
    // rust: t INTEGER PRIMARY KEY, samples INTEGER NOT NULL, peak INTEGER NOT NULL, peak_at INTEGER NOT NULL,
    // rust: sum INTEGER NOT NULL, lan_peak INTEGER NOT NULL, lan_sum INTEGER NOT NULL,
    // rust: linux_sum INTEGER NOT NULL, macos_sum INTEGER NOT NULL, windows_sum INTEGER NOT NULL,
    // rust: other_sum INTEGER NOT NULL
    // rust: ) WITHOUT ROWID;
    // rust: ";

/// The per-platform columns, in [`PLATFORMS`]' order.
pub const PLATFORM_COLUMNS: [[]const u8; 4] = ["linux", "macos", "windows", "other"];

pub const HOUR: i64 = 3600;
pub const DAY: i64 = 86_400;

/// Which count: the games' pings, or the official server's status.
pub const Series = enum {
    Players,
    Official,
};

    // rust: impl Series {
pub fn parse(s: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(match s {
    // rust: "players" => Self::Players,
    // rust: "official" => Self::Official,
    // rust: _ => return None,
    // rust: })
}

pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Players => "players",
    // rust: Self::Official => "official",
}
}

pub fn prefix(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Players => "live",
    // rust: Self::Official => "official",
}
}
}

/// One minute's count, as it is stored.
pub const Sample = struct {
    playing: u64,
    lan: u64,
    /// Per platform, in [`PLATFORMS`]' order.
    platforms: [u64,
};

    // rust: impl Sample {
pub fn of(count: *Count) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut platforms = [0; 4];
    // rust: for (slot, name) in platforms.iter_mut().zip(PLATFORMS) {
    // rust: *slot = count.platforms.get(name).copied().unwrap_or(0);
}
    // rust: Self {
    // rust: playing: count.playing,
    // rust: lan: count.lan,
    // rust: platforms,
}
}
}

/// What `GET /v1/live/history?range=` shows.
pub const Range = enum {
    /// The last 24 hours, in 5-minute points.
    Day,
    /// The last 7 days, hourly.
    Week,
    /// The last 30 days, every 3 hours.
    Month,
    /// Every day since the first.
    All,
};

    // rust: impl Range {
pub fn parse(s: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(match s {
    // rust: "24h" => Self::Day,
    // rust: "7d" => Self::Week,
    // rust: "30d" => Self::Month,
    // rust: "all" => Self::All,
    // rust: _ => return None,
    // rust: })
}

pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Day => "24h",
    // rust: Self::Week => "7d",
    // rust: Self::Month => "30d",
    // rust: Self::All => "all",
}
}

    /// The table it reads, its point's length, and how far back it goes (None: all of it).
pub fn plan(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Day => (Table::Minute, 300, Some(DAY)),
    // rust: Self::Week => (Table::Hour, HOUR, Some(7 * DAY)),
    // rust: Self::Month => (Table::Hour, 3 * HOUR, Some(30 * DAY)),
    // rust: Self::All => (Table::Day, DAY, None),
}
}
}

pub const Table = enum {
    Minute,
    Hour,
    Day,
};

    // rust: impl Table {
pub fn name(self: *Self, series: Series) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let table = match self {
    // rust: Self::Minute => "minute",
    // rust: Self::Hour => "hour",
    // rust: Self::Day => "day",
}
    // rust: format!("{}_{table}", series.prefix())
}

    /// The SQL for a row's samples, sum, peak and peak's time, and a platform's sum: a minute row
    /// is one sample.
    // rust: fn columns(
    // rust: self,
    // rust: ) -> (
    // rust: &'static str,
    // rust: &'static str,
    // rust: &'static str,
    // rust: &'static str,
    // rust: &'static str,
    // rust: ) {
    // rust: match self {
    // rust: Self::Minute => ("1", "playing", "playing", "t", ""),
    // rust: Self::Hour | Self::Day => ("samples", "sum", "peak", "peak_at", "_sum"),
}
}
}

/// A count at a time.
pub const Peak = struct {
    playing: u64,
    at: i64,
};

/// `GET /v1/live/history`'s answer.
pub const History = struct {
    /// `players` or `official`.
    source: *'static str,
    range: *'static str,
    /// Seconds per point.
    step: i64,
    /// The first point's start and now.
    from: i64,
    to: i64,
    /// `[start, average, highest]` per point that has samples, oldest first. A point with no
    /// sample (the server was down) is missing.
    series: Vec<(i64,
    /// The highest count in the range and its minute.
    peak: ?Peak,
    /// The highest count ever recorded and its minute.
    all_time: ?Peak,
    /// The newest minute's count, at most a few minutes old while the series is recorded.
    latest: ?Peak,
    /// The average count per platform over the range.
    platforms: BTreeMap<[]const u8,
};

pub fn tenth(x: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (x * 10.0).round() / 10.0
}

    // rust: impl Store {
    /// Writes down `sample` as `series`' count of the minute starting at `minute` (Unix seconds),
    /// and adds it to its hour and day. False, and nothing changes, when that minute has one
    /// already.
    // rust: pub fn record_live(
    // rust: &mut self,
    // rust: series: Series,
    // rust: minute: i64,
    // rust: sample: &Sample,
    // rust: ) -> rusqlite::Result<bool> {
    // rust: let prefix = series.prefix();
    // rust: let minute = minute - minute.rem_euclid(60);
    // rust: let tx = self.db.transaction()?;
    // rust: let [linux, macos, windows, other] = sample.platforms.map(|n| n as i64);
    // rust: let (playing, lan) = (sample.playing as i64, sample.lan as i64);
    // rust: let new = tx.execute(
    // rust: &format!(
    // rust: "INSERT OR IGNORE INTO {prefix}_minute (t, playing, lan, linux, macos, windows, other)
    // rust: VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7)"
    // rust: ),
    // rust: params![minute, playing, lan, linux, macos, windows, other],
    // rust: )? == 1;
    // rust: if new {
    // rust: for (table, start) in [
    // rust: (format!("{prefix}_hour"), minute - minute.rem_euclid(HOUR)),
    // rust: (format!("{prefix}_day"), minute - minute.rem_euclid(DAY)),
    // rust: ] {
                // SQLite evaluates every SET against the row as it was, so `peak_at` sees the old
                // peak. An equal count keeps the earlier minute.
    // rust: tx.execute(
    // rust: &format!(
    // rust: "INSERT INTO {table} (t, samples, peak, peak_at, sum, lan_peak, lan_sum,
    // rust: linux_sum, macos_sum, windows_sum, other_sum)
    // rust: VALUES (?1, 1, ?2, ?3, ?2, ?4, ?4, ?5, ?6, ?7, ?8)
    // rust: ON CONFLICT (t) DO UPDATE SET
    // rust: samples = samples + 1,
    // rust: peak = max(peak, excluded.peak),
    // rust: peak_at = CASE WHEN excluded.peak > peak THEN excluded.peak_at ELSE peak_at END,
    // rust: sum = sum + excluded.sum,
    // rust: lan_peak = max(lan_peak, excluded.lan_peak),
    // rust: lan_sum = lan_sum + excluded.lan_sum,
    // rust: linux_sum = linux_sum + excluded.linux_sum,
    // rust: macos_sum = macos_sum + excluded.macos_sum,
    // rust: windows_sum = windows_sum + excluded.windows_sum,
    // rust: other_sum = other_sum + excluded.other_sum"
    // rust: ),
    // rust: params![start, playing, minute, lan, linux, macos, windows, other],
    // rust: )?;
}
}
    // rust: tx.commit()?;
    // rust: Ok(new)
}

    /// Removes minutes older than `minute_days` and hours older than `hour_days` before `now`,
    /// in every series. Days stay.
    // rust: pub fn prune_live(
    // rust: &self,
    // rust: now: i64,
    // rust: minute_days: u32,
    // rust: hour_days: u32,
    // rust: ) -> rusqlite::Result<usize> {
    // rust: let mut removed = 0;
    // rust: for series in [Series::Players, Series::Official] {
    // rust: let prefix = series.prefix();
    // rust: removed += self.db.execute(
    // rust: &format!("DELETE FROM {prefix}_minute WHERE t < ?1"),
    // rust: [now - i64::from(minute_days) * DAY],
    // rust: )?;
    // rust: removed += self.db.execute(
    // rust: &format!("DELETE FROM {prefix}_hour WHERE t < ?1"),
    // rust: [now - i64::from(hour_days) * DAY],
    // rust: )?;
}
    // rust: Ok(removed)
}

    /// `which` series over `range`, up to `now` (Unix seconds).
pub fn live_history(self: *Self, which: Series, range: Range, now: i64) r {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (table, step, span) = range.plan();
    // rust: let (samples, sum, peak, peak_at, suffix) = table.columns();
    // rust: let name = table.name(which);
    // rust: let day_table = Table::Day.name(which);
    // rust: let from = span.map_or(0, |span| {
    // rust: let from = now - span;
    // rust: from - from.rem_euclid(step)
    // rust: });
    // rust: let mut series = Vec::new();
    // rust: let mut rows = self.db.prepare(&format!(
    // rust: "SELECT t / ?2 * ?2 AS b, CAST(SUM({sum}) AS REAL) / SUM({samples}), MAX({peak})
    // rust: FROM {name} WHERE t >= ?1 GROUP BY b ORDER BY b"
    // rust: ))?;
    // rust: for row in rows.query_map(params![from, step], |r| {
    // rust: Ok((
    // rust: r.get::<_, i64>(0)?,
    // rust: r.get::<_, f64>(1)?,
    // rust: r.get::<_, i64>(2)?,
    // rust: ))
    // rust: })? {
    // rust: let (t, avg, max) = row?;
    // rust: series.push((t, tenth(avg), max.max(0) as u64));
}
    // rust: let peak_of = |since: i64| {
    // rust: self.db
    // rust: .query_row(
    // rust: &format!(
    // rust: "SELECT {peak}, {peak_at} FROM {name} WHERE t >= ?1
    // rust: ORDER BY {peak} DESC, {peak_at} ASC LIMIT 1"
    // rust: ),
    // rust: [since],
    // rust: |r| {
    // rust: Ok(Peak {
    // rust: playing: r.get::<_, i64>(0)?.max(0) as u64,
    // rust: at: r.get(1)?,
    // rust: })
    // rust: },
    // rust: )
    // rust: .optional()
}
    // rust: let all_time = self
    // rust: .db
    // rust: .query_row(
    // rust: &format!(
    // rust: "SELECT peak, peak_at FROM {day_table} ORDER BY peak DESC, peak_at ASC LIMIT 1"
    // rust: ),
    // rust: [],
    // rust: |r| {
    // rust: Ok(Peak {
    // rust: playing: r.get::<_, i64>(0)?.max(0) as u64,
    // rust: at: r.get(1)?,
    // rust: })
    // rust: },
    // rust: )
    // rust: .optional()?;
    // rust: let minute_table = Table::Minute.name(which);
    // rust: let latest = self
    // rust: .db
    // rust: .query_row(
    // rust: &format!("SELECT playing, t FROM {minute_table} ORDER BY t DESC LIMIT 1"),
    // rust: [],
    // rust: |r| {
    // rust: Ok(Peak {
    // rust: playing: r.get::<_, i64>(0)?.max(0) as u64,
    // rust: at: r.get(1)?,
    // rust: })
    // rust: },
    // rust: )
    // rust: .optional()?;
    // rust: let averages = PLATFORM_COLUMNS
    // rust: .iter()
    // rust: .map(|c| format!("CAST(SUM({c}{suffix}) AS REAL) / SUM({samples})"))
    // rust: .collect::<Vec<_>>()
    // rust: .join(", ");
    // rust: let platforms = self.db.query_row(
    // rust: &format!("SELECT {averages} FROM {name} WHERE t >= ?1"),
    // rust: [from],
    // rust: |r| {
    // rust: (0..PLATFORM_COLUMNS.len())
    // rust: .map(|i| r.get::<_, Option<f64>>(i))
    // rust: .collect::<rusqlite::Result<Vec<_>>>()
    // rust: },
    // rust: )?;
    // rust: Ok(History {
    // rust: source: which.name(),
    // rust: range: range.name(),
    // rust: step,
    // rust: from,
    // rust: to: now,
    // rust: series,
    // rust: peak: peak_of(from)?,
    // rust: all_time,
    // rust: latest,
    // rust: platforms: PLATFORMS
    // rust: .iter()
    // rust: .zip(platforms)
    // rust: .filter_map(|(p, avg)| Some(((*p).to_owned(), tenth(avg?))))
    // rust: .filter(|(_, avg)| *avg > 0.0)
    // rust: .collect(),
    // rust: })
}
}

    // rust: mod tests {
//     use super::*;

pub fn sample(playing: u64, linux: u64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Sample {
    // rust: playing,
    // rust: lan: playing / 2,
    // rust: platforms: [linux, playing - linux, 0, 0],
}
}

pub fn the_columns_follow_the_platforms() void {
}
    // rust: assert_eq!(PLATFORM_COLUMNS, PLATFORMS);
}

pub fn a_minute_is_recorded_once_and_rolls_up() void {
}
    // rust: let mut store = Store::open(":memory:").unwrap();
    // rust: let day = 20_000 * DAY;
    // rust: assert!(
    // rust: store
    // rust: .record_live(Series::Players, day + 10, &sample(4, 1))
    // rust: .unwrap()
    // rust: );
        // The same minute again (a late tick) changes nothing.
    // rust: assert!(
    // rust: !store
    // rust: .record_live(Series::Players, day + 59, &sample(9, 9))
    // rust: .unwrap()
    // rust: );
    // rust: store
    // rust: .record_live(Series::Players, day + 60, &sample(8, 2))
    // rust: .unwrap();
    // rust: store
    // rust: .record_live(Series::Players, day + 120, &sample(8, 8))
    // rust: .unwrap();
    // rust: store
    // rust: .record_live(Series::Players, day + HOUR, &sample(2, 0))
    // rust: .unwrap();

    // rust: let now = day + HOUR + 30;
    // rust: let h = store
    // rust: .live_history(Series::Players, Range::Day, now)
    // rust: .unwrap();
    // rust: assert_eq!(h.series, [(day, 6.7, 8), (day + HOUR, 2.0, 2)]);
        // The first minute that reached 8.
    // rust: assert_eq!(
    // rust: h.peak,
    // rust: Some(Peak {
    // rust: playing: 8,
    // rust: at: day + 60
    // rust: })
    // rust: );
    // rust: assert_eq!(h.all_time, h.peak);
    // rust: assert_eq!(h.platforms["linux"], 2.8);
    // rust: assert_eq!(h.platforms["macos"], 2.8);
    // rust: assert!(!h.platforms.contains_key("windows"));

    // rust: let week = store
    // rust: .live_history(Series::Players, Range::Week, now)
    // rust: .unwrap();
    // rust: assert_eq!(week.series, [(day, 6.7, 8), (day + HOUR, 2.0, 2)]);
    // rust: assert_eq!(week.peak, h.peak);
    // rust: let all = store
    // rust: .live_history(Series::Players, Range::All, now)
    // rust: .unwrap();
    // rust: assert_eq!(all.series, [(day, 5.5, 8)]);
    // rust: assert_eq!(all.step, DAY);
}

pub fn old_minutes_and_hours_go_and_days_stay() void {
}
    // rust: let mut store = Store::open(":memory:").unwrap();
    // rust: let start = 20_000 * DAY;
    // rust: store
    // rust: .record_live(Series::Players, start, &sample(30, 0))
    // rust: .unwrap();
    // rust: let later = start + 100 * DAY;
    // rust: store
    // rust: .record_live(Series::Players, later, &sample(3, 0))
    // rust: .unwrap();
    // rust: assert_eq!(store.prune_live(later, 7, 90).unwrap(), 2);
    // rust: let all = store
    // rust: .live_history(Series::Players, Range::All, later)
    // rust: .unwrap();
    // rust: assert_eq!(all.series, [(start, 30.0, 30), (later, 3.0, 3)]);
    // rust: assert_eq!(all.all_time.unwrap().playing, 30);
        // The 24 hours hold only today; the all-time peak is still the old one.
    // rust: let day = store
    // rust: .live_history(Series::Players, Range::Day, later + 60)
    // rust: .unwrap();
    // rust: assert_eq!(day.series, [(later, 3.0, 3)]);
    // rust: assert_eq!(day.peak.unwrap().playing, 3);
    // rust: assert_eq!(day.all_time.unwrap().at, start);
}

pub fn an_empty_history_has_no_peak() void {
}
    // rust: let store = Store::open(":memory:").unwrap();
    // rust: let h = store
    // rust: .live_history(Series::Players, Range::Month, 20_000 * DAY)
    // rust: .unwrap();
    // rust: assert!(h.series.is_empty());
    // rust: assert_eq!((h.peak, h.all_time, h.latest), (None, None, None));
    // rust: assert!(h.platforms.is_empty());
    // rust: assert_eq!(Range::parse("30d"), Some(Range::Month));
    // rust: assert_eq!(Range::parse("1y"), None);
    // rust: assert_eq!(Series::parse("official"), Some(Series::Official));
    // rust: assert_eq!(Series::parse("lan"), None);
}

pub fn the_official_series_is_kept_apart() void {
}
    // rust: let mut store = Store::open(":memory:").unwrap();
    // rust: let day = 20_000 * DAY;
    // rust: store
    // rust: .record_live(Series::Players, day, &sample(40, 10))
    // rust: .unwrap();
    // rust: let official = Sample {
    // rust: playing: 6,
    // rust: ..Sample::default()
}
    // rust: assert!(store.record_live(Series::Official, day, &official).unwrap());
    // rust: let h = store
    // rust: .live_history(Series::Official, Range::Day, day + 60)
    // rust: .unwrap();
    // rust: assert_eq!(h.series, [(day, 6.0, 6)]);
    // rust: assert_eq!(h.all_time.unwrap().playing, 6);
    // rust: assert_eq!(
    // rust: h.latest,
    // rust: Some(Peak {
    // rust: playing: 6,
    // rust: at: day
    // rust: })
    // rust: );
    // rust: assert!(h.platforms.is_empty());
    // rust: let players = store
    // rust: .live_history(Series::Players, Range::Day, day + 60)
    // rust: .unwrap();
    // rust: assert_eq!(players.all_time.unwrap().playing, 40);
    // rust: assert_eq!(store.prune_live(day + 100 * DAY, 7, 90).unwrap(), 4);
}
}
