//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_logging
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The game's log, as vanilla's log4j configuration writes it (client-1.21.2.xml, the one
//! 26.3's version manifest names): `logs/latest.log` in the game folder with the pattern
//! `[%d{HH:mm:ss}] [%t/%level]: %msg%n`, rolled over at start (OnStartupTriggeringPolicy, a
//! non-empty file only) and when the day changes (TimeBasedTriggeringPolicy) to
//! `logs/%d{yyyy-MM-dd}-%i.log.gz`, dated by the old file's last write. DefaultRolloverStrategy
//! keeps 7 archives a day, the newest with the highest index.
//!
//! Messages go through the `log` facade. Horizon's own still print their plain text on stderr,
//! as they did before the log existed; other crates' errors only reach the file (their
//! warnings are mostly the Vulkan loader's startup chatter).
// use std::collections::{HashMap, VecDeque};
// use std::fs::{self, File, OpenOptions};
// use std::io::{self, Read, Seek, SeekFrom, Write};
// use std::path::{Path, PathBuf};
// use std::sync::{Mutex, mpsc};
// use std::time::{Duration, Instant};

// use chrono::{DateTime, Local, NaiveDate};

/// DefaultRolloverStrategy's default `max`: archives kept for one date.
pub const MAX_ARCHIVES_PER_DAY: u32 = 7;
/// Formatted lines kept in memory for crash reports.
pub const RECENT: usize = 50;
/// Warnings and errors one line of code may log in a [`FLOOD_WINDOW`]; past that they are counted,
/// not written, so a warning repeated every packet can't fill the disk. Vanilla has no such limit:
/// below it the log is vanilla's, line for line.
pub const FLOOD_LINES: u32 = 100;
pub const FLOOD_WINDOW: Duration = Duration::from_secs(60);

/// The platform data folder (what the `dirs` crate's data_dir gives).
pub fn data_dir() P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let env = |k: &str| {
    // rust: std::env::var_os(k)
    // rust: .filter(|v| !v.is_empty())
    // rust: .map(PathBuf::from)
}
    // rust: let home = env("HOME").or_else(|| env("USERPROFILE"));
    // rust: if cfg!(windows) {
    // rust: if let Some(d) = env("APPDATA") {
    // rust: return d;
}
    // rust: } else if cfg!(target_os = "macos") {
    // rust: if let Some(h) = &home {
    // rust: return h.join("Library/Application Support");
}
    // rust: } else if let Some(d) = env("XDG_DATA_HOME") {
    // rust: return d;
    // rust: } else if let Some(h) = &home {
    // rust: return h.join(".local/share");
}
    // rust: std::env::temp_dir()
}

/// `--home DIR`, set once at start; it wins over `HORIZON_HOME`.
pub const HOME: std::sync::OnceLock<PathBuf> = std::sync::OnceLock::new();

/// Makes `game_home` return `home` for the rest of the run (`--home`).
pub fn set_game_home(home: PathBuf) void {
}
    // rust: let _ = HOME.set(home);
}

/// `--player-dir DIR` (#4952), set once at start: one player's own files, when several games
/// play in one game folder at the same time (the launcher's `play --account`).
pub const PLAYER: std::sync::OnceLock<PathBuf> = std::sync::OnceLock::new();

/// Makes [`player_dir`] return `dir` for the rest of the run (`--player-dir`), creating it.
/// What is a player's own goes there: `options.txt` and the settings files beside it,
/// `logs/`, `crash-reports/`, `horizon-player.txt`, `servers.dat`, `hotbar.nbt` and
/// `screenshots/`. What the game folder's players share stays in it: saves, resource and
/// shader packs, mods and their config, caches.
pub fn set_player_dir(dir: PathBuf) void {
}
    // rust: let _ = fs::create_dir_all(&dir);
    // rust: let _ = PLAYER.set(dir);
}

/// The folder of this player's own files: `--player-dir`, else the game folder (the working
/// directory, where the launcher runs the game).
pub fn player_dir() P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: PLAYER
    // rust: .get()
    // rust: .cloned()
    // rust: .unwrap_or_else(|| std::env::current_dir().unwrap_or_default())
}

/// `--player-dir`, if given.
pub fn player_dir_override() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: PLAYER.get().map(PathBuf::as_path)
}

/// Where the files all players share live, for settings kept beside `options.txt` in
/// `options_dir` (the enabled mods): that folder, unless `--player-dir` moved `options.txt`
/// out of the game folder.
pub fn shared_dir(options_dir: *Path) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: shared_dir_of(PLAYER.get().map(PathBuf::as_path), options_dir, || {
    // rust: std::env::current_dir().unwrap_or_default()
    // rust: })
}

/// [`shared_dir`] for a given `--player-dir` and game folder.
    // rust: fn shared_dir_of(
    // rust: player: Option<&Path>,
    // rust: options_dir: &Path,
    // rust: game_dir: impl FnOnce() -> PathBuf,
    // rust: ) -> PathBuf {
    // rust: match player {
    // rust: Some(player) if player == options_dir => game_dir(),
    // rust: _ => options_dir.to_path_buf(),
}
}

/// Where the launcher runs the game and keeps its saves: `--home`, else `HORIZON_HOME`, else
/// `horizon` in the platform data folder (launcher/src/backend.rs `game_home`).
pub fn game_home() P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(home) = HOME.get() {
    // rust: return home.clone();
}
    // rust: match std::env::var_os("HORIZON_HOME").filter(|h| !h.is_empty()) {
    // rust: Some(h) => PathBuf::from(h),
    // rust: None => data_dir().join("horizon"),
}
}

/// `logs/` and `crash-reports/` of a game folder.
pub fn logs_dir(home: *Path) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: home.join("logs")
}
pub fn crash_reports_dir(home: *Path) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: home.join("crash-reports")
}

/// `2026-10-14-3.log.gz`
pub fn archive_name(date: NaiveDate, index: u32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: format!("{}-{index}.log.gz", date.format("%Y-%m-%d"))
}

/// The archive index of `name` if it is one of `date`'s archives.
pub fn archive_index(name: []const u8, date: NaiveDate) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let prefix = format!("{}-", date.format("%Y-%m-%d"));
    // rust: name.strip_prefix(&prefix)?
    // rust: .strip_suffix(".log.gz")?
    // rust: .parse()
    // rust: .ok()
    // rust: .filter(|&i| i > 0)
}

/// What one rollover does to the archives already there.
pub const Rollover = struct {
    delete: ?[]const u8,
    /// In order: each target is free when its rename runs.
    renames: Vec<([]const u8,
    archive: []const u8,
};

/// DefaultRolloverStrategy with fileIndex "max": the new archive takes the next index; once
/// `max` are there the lowest goes and the others move down one.
pub fn rollover(existing: *[[]const u8], date: NaiveDate, max: u32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut present: Vec<u32> = existing
    // rust: .iter()
    // rust: .filter_map(|n| archive_index(n, date))
    // rust: .collect();
    // rust: present.sort_unstable();
    // rust: present.dedup();
    // rust: let highest = present.last().copied().unwrap_or(0);
    // rust: if highest < max {
    // rust: return Rollover {
    // rust: delete: None,
    // rust: renames: Vec::new(),
    // rust: archive: archive_name(date, highest + 1),
}
}
    // rust: let delete = Some(archive_name(date, present[0]));
    // rust: let kept = &present[1..];
    // rust: let renames = kept
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, &from)| (from, i as u32 + 1))
    // rust: .filter(|(from, to)| from != to)
    // rust: .map(|(from, to)| (archive_name(date, from), archive_name(date, to)))
    // rust: .collect();
    // rust: Rollover {
    // rust: delete,
    // rust: renames,
    // rust: archive: archive_name(date, kept.len() as u32 + 1),
}
}

/// `[12:04:31] [Render thread/INFO]: message`
    // rust: pub fn format_line(
    // rust: time: &DateTime<Local>,
    // rust: thread: &str,
    // rust: level: log::Level,
    // rust: message: &str,
    // rust: ) -> String {
    // rust: format!(
    // rust: "[{}] [{thread}/{level}]: {message}",
    // rust: time.format("%H:%M:%S")
    // rust: )
}

/// Gzips `text` into the next archive for `date` in `dir`.
pub fn archive(dir: *Path, date: NaiveDate, text: []const u8) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let names: Vec<String> = fs::read_dir(dir)?
    // rust: .flatten()
    // rust: .filter_map(|e| e.file_name().into_string().ok())
    // rust: .collect();
    // rust: let plan = rollover(&names, date, MAX_ARCHIVES_PER_DAY);
    // rust: if let Some(name) = &plan.delete {
    // rust: fs::remove_file(dir.join(name))?;
}
    // rust: for (from, to) in &plan.renames {
    // rust: fs::rename(dir.join(from), dir.join(to))?;
}
    // rust: let mut gz = flate2::write::GzEncoder::new(
    // rust: File::create(dir.join(&plan.archive))?,
    // rust: flate2::Compression::default(),
    // rust: );
    // rust: gz.write_all(text)?;
    // rust: gz.finish()?.sync_all()
}

/// Moves what `file` holds into an archive dated `date` and empties it. The file stays open
/// (and locked), so this works on Windows too.
pub fn roll(file: *mut File, dir: *Path, date: NaiveDate) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut text = Vec::new();
    // rust: file.seek(SeekFrom::Start(0))?;
    // rust: file.read_to_end(&mut text)?;
    // rust: if !text.is_empty() {
    // rust: archive(dir, date, &text)?;
}
    // rust: file.set_len(0)?;
    // rust: file.seek(SeekFrom::Start(0))?;
    // rust: Ok(())
}

/// The open `latest.log` and the lock that keeps it this game's.
pub const Latest = struct {
    file: File,
    _lock: File,
};

/// Opens `dir/latest.log` for this run, archiving the last run's. None when another Horizon
/// using the same folder is writing it: that game keeps it, this one logs to stderr only. The
/// lock is a separate file (`.lock`): Windows locks are mandatory, and a locked latest.log could
/// not be read while the game runs.
pub fn open_latest(dir: *Path) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: fs::create_dir_all(dir)?;
    // rust: let lock = OpenOptions::new()
    // rust: .write(true)
    // rust: .create(true)
    // rust: .truncate(false)
    // rust: .open(dir.join(".lock"))?;
    // rust: match lock.try_lock() {
    // rust: Ok(()) => {}
    // rust: Err(fs::TryLockError::WouldBlock) => return Ok(None),
    // rust: Err(fs::TryLockError::Error(e)) => return Err(e),
}
    // rust: let mut file = OpenOptions::new()
    // rust: .read(true)
    // rust: .write(true)
    // rust: .create(true)
    // rust: .truncate(false)
    // rust: .open(dir.join("latest.log"))?;
    // rust: let modified = file.metadata()?.modified()?;
    // rust: let date = DateTime::<Local>::from(modified).date_naive();
    // rust: roll(&mut file, dir, date)?;
    // rust: Ok(Some(Latest { file, _lock: lock }))
}

/// What the writer thread is told.
pub const Out = enum {
    /// Lines for the file, dated, and the message for stderr (Horizon's own).
    Write {,
    date: NaiveDate,
    lines: Vec<String>,
    stderr: Option<String>,
    // rust: },
    /// Answer once everything before is written.
    Flush(mpsc::SyncSender<()>),
};

/// The file side of the log, on its own thread: a line costs the thread that logs it a
/// format and a channel send, never a write that can wait (a full stderr pipe, a slow disk):
/// written on the game thread, a line could hold the tick for milliseconds while the CPU sat
/// idle.
pub const Writer = struct {
    file: ?Latest,
    dir: PathBuf,
    /// The day the open file's lines belong to.
    date: NaiveDate,
};

    // rust: impl Writer {
pub fn run(out: mpsc::Receiver<Out>) void {
}
    // rust: let stderr = io::stderr();
    // rust: for msg in out {
    // rust: match msg {
    // rust: Out::Write {
    // rust: date,
    // rust: lines,
    // rust: stderr: message,
    // rust: } => {
    // rust: if let Some(message) = message {
    // rust: let _ = writeln!(stderr.lock(), "{message}");
}
    // rust: if date != self.date {
    // rust: if let Some(latest) = &mut self.file
    // rust: && let Err(e) = roll(&mut latest.file, &self.dir, self.date)
    // rust: {
    // rust: let _ = writeln!(
    // rust: stderr.lock(),
    // rust: "Horizon: could not roll over the log: {e}"
    // rust: );
}
    // rust: self.date = date;
}
    // rust: if let Some(latest) = &mut self.file {
    // rust: let mut text = lines.join("\n");
    // rust: text.push('\n');
    // rust: let _ = latest.file.write_all(text.as_bytes());
}
}
    // rust: Out::Flush(done) => {
    // rust: if let Some(latest) = &mut self.file {
    // rust: let _ = latest.file.flush();
}
    // rust: let _ = done.send(());
}
}
}
}
}

pub const Logger = struct {
    out: mpsc::Sender<Out>,
    /// The last lines, kept here (not on the writer) so a crash report has them at once.
    recent: Mutex<VecDeque<[]const u8>>,
    /// What the main thread is called in the log: "Render thread", or "Server thread" for the
    /// dedicated server, as in vanilla.
    main_thread: *'static str,
    floods: Mutex<Floods>,
};

/// What the flood limit does with one warning or error.
pub const Gate = enum {
    /// Write it, after saying how many lines like it were left out in the window before.
    Write {,
    left_out: u32,
    // rust: },
    /// Write it, then say the next ones from this line of code wait for the next window.
    Last,
    Skip,
};

/// Warnings and errors per line of code, in windows of [`FLOOD_WINDOW`].
pub const Floods = struct {
    sites: HashMap<([]const u8,
};

pub const Flood = struct {
    since: Instant,
    written: u32,
    left_out: u32,
};

    // rust: impl Floods {
pub fn gate(self: *Self, file: []const u8, line: u32, now: Instant) G {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let flood = self.sites.entry((file.to_owned(), line)).or_insert(Flood {
    // rust: since: now,
    // rust: written: 0,
    // rust: left_out: 0,
    // rust: });
    // rust: let mut left_out = 0;
    // rust: if now.duration_since(flood.since) >= FLOOD_WINDOW {
    // rust: left_out = flood.left_out;
    // rust: *flood = Flood {
    // rust: since: now,
    // rust: written: 0,
    // rust: left_out: 0,
}
}
    // rust: flood.written += 1;
    // rust: match flood.written.cmp(&FLOOD_LINES) {
    // rust: std::cmp::Ordering::Less => Gate::Write { left_out },
    // rust: std::cmp::Ordering::Equal => Gate::Last,
    // rust: std::cmp::Ordering::Greater => {
    // rust: flood.left_out += 1;
    // rust: Gate::Skip
}
}
}
}

pub const LOGGER: std::sync::OnceLock<Logger> = std::sync::OnceLock::new();

pub fn ours(target: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: target.starts_with("horizon")
}

    // rust: impl log::Log for Logger {
pub fn enabled(self: *Self, meta: *log::Metadata) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: meta.level() <= log::Level::Info
    // rust: && (ours(meta.target()) || meta.level() <= log::Level::Error)
}

pub fn log(self: *Self, record: *log::Record) void {
}
    // rust: if !self.enabled(record.metadata()) {
    // rust: return;
}
    // rust: let message = record.args().to_string();
    // rust: let current = std::thread::current();
    // rust: let thread = match current.name() {
    // rust: Some("main") => self.main_thread,
    // rust: Some(name) => name,
    // rust: None => "unnamed",
}
    // rust: let gate = if record.level() <= log::Level::Warn {
    // rust: let mut floods = self.floods.lock().unwrap_or_else(|e| e.into_inner());
    // rust: floods.gate(
    // rust: record.file().unwrap_or(record.target()),
    // rust: record.line().unwrap_or(0),
    // rust: Instant::now(),
    // rust: )
    // rust: } else {
    // rust: Gate::Write { left_out: 0 }
}
    // rust: let level = record.level();
    // rust: match gate {
    // rust: Gate::Skip => return,
    // rust: Gate::Write { left_out } if left_out > 0 => self.write(
    // rust: thread,
    // rust: level,
    // rust: &format!(
    // rust: "{left_out} more lines like the next one were not logged in the last minute"
    // rust: ),
    // rust: ),
    // rust: _ => {}
}
    // rust: let stderr = ours(record.target()).then(|| message.clone());
    // rust: self.send(thread, level, &message, stderr);
    // rust: if gate == Gate::Last {
    // rust: self.write(
    // rust: thread,
    // rust: level,
    // rust: &format!("{FLOOD_LINES} lines like this one in a minute: the next ones are counted, not logged"),
    // rust: );
}
}

    /// Waits (a second at most) until every line logged before is in the file.
pub fn flush(self: *Self) void {
}
    // rust: let (done, wait) = mpsc::sync_channel(1);
    // rust: if self.out.send(Out::Flush(done)).is_ok() {
    // rust: let _ = wait.recv_timeout(std::time::Duration::from_secs(1));
}
}
}

    // rust: impl Logger {
pub fn write(self: *Self, thread: []const u8, level: log::Level, message: []const u8) void {
}
    // rust: self.send(thread, level, message, None);
}

pub fn send(self: *Self, thread: []const u8, level: log::Level, message: []const u8, stderr: ?[]const u8) void {
}
    // rust: let now = Local::now();
        // As log4j writes a multi-line message: the pattern once, the rest as it is.
    // rust: let lines: Vec<String> = message
    // rust: .lines()
    // rust: .enumerate()
    // rust: .map(|(i, line)| {
    // rust: if i == 0 {
    // rust: format_line(&now, thread, level, line)
    // rust: } else {
    // rust: line.to_owned()
}
    // rust: })
    // rust: .collect();
    // rust: {
    // rust: let mut recent = self.recent.lock().unwrap_or_else(|e| e.into_inner());
    // rust: for line in &lines {
    // rust: if recent.len() == RECENT {
    // rust: recent.pop_front();
}
    // rust: recent.push_back(line.clone());
}
}
    // rust: let msg = Out::Write {
    // rust: date: now.date_naive(),
    // rust: lines,
    // rust: stderr,
}
    // rust: if let Err(mpsc::SendError(Out::Write {
    // rust: stderr: Some(message),
    // rust: ..
    // rust: })) = self.out.send(msg)
    // rust: {
            // No writer (it could not start): the terminal still gets Horizon's messages.
    // rust: eprintln!("{message}");
}
}
}

/// Starts the log in `home/logs`. The main thread shows as `main_thread` in it. Messages are
/// still printed when the file cannot be opened.
pub fn init(home: *Path, main_thread: *'static str) void {
}
    // rust: let dir = logs_dir(home);
    // rust: let file = match open_latest(&dir) {
    // rust: Ok(Some(latest)) => Some(latest),
    // rust: Ok(None) => {
    // rust: eprintln!(
    // rust: "Horizon: another game is writing {}; this one logs to the terminal only",
    // rust: dir.join("latest.log").display()
    // rust: );
    // rust: None
}
    // rust: Err(e) => {
    // rust: eprintln!(
    // rust: "Horizon: could not open {}: {e}",
    // rust: dir.join("latest.log").display()
    // rust: );
    // rust: None
}
}
    // rust: let logger = LOGGER.get_or_init(|| {
    // rust: let (out, receive) = mpsc::channel();
    // rust: let writer = Writer {
    // rust: file,
    // rust: dir,
    // rust: date: Local::now().date_naive(),
}
    // rust: if let Err(e) = std::thread::Builder::new()
    // rust: .name("Log writer".into())
    // rust: .spawn(move || writer.run(receive))
    // rust: {
    // rust: eprintln!("Horizon: could not start the log writer: {e}");
}
    // rust: Logger {
    // rust: out,
    // rust: recent: Mutex::new(VecDeque::new()),
    // rust: main_thread,
    // rust: floods: Mutex::new(Floods::default()),
}
    // rust: });
    // rust: if log::set_logger(logger).is_ok() {
    // rust: log::set_max_level(log::LevelFilter::Info);
}
}

/// A line in the log from code that prints it elsewhere itself (the dedicated server console).
pub fn write_only(level: log::Level, message: []const u8) void {
}
    // rust: if let Some(logger) = LOGGER.get() {
    // rust: let current = std::thread::current();
    // rust: let thread = match current.name() {
    // rust: Some("main") | None => logger.main_thread,
    // rust: Some(name) => name,
}
    // rust: logger.write(thread, level, message);
}
}

/// Writes `message` to the log file only, under the thread vanilla names for it (`Server thread` for
/// a login refused on a connection's own thread), as the console line beside it shows.
pub fn write_as(thread: []const u8, level: log::Level, message: []const u8) void {
}
    // rust: if let Some(logger) = LOGGER.get() {
    // rust: logger.write(thread, level, message);
}
}

/// The last lines written, oldest first (for crash reports).
pub fn recent_lines() V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: LOGGER.get().map_or_else(Vec::new, |l| {
    // rust: l.recent
    // rust: .lock()
    // rust: .unwrap_or_else(|e| e.into_inner())
    // rust: .iter()
    // rust: .cloned()
    // rust: .collect()
    // rust: })
}

/// Flushes the log file (before the process exits).
pub fn flush() void {
}
    // rust: if let Some(logger) = LOGGER.get() {
    // rust: log::Log::flush(logger);
}
}

/// The last `lines` lines of a text file.
pub fn tail(path: *Path, lines: usize) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let text = fs::read(path)?;
    // rust: let text = String::from_utf8_lossy(&text);
    // rust: let all: Vec<&str> = text.lines().collect();
    // rust: Ok(all[all.len().saturating_sub(lines)..]
    // rust: .iter()
    // rust: .map(|l| l.to_string())
    // rust: .collect())
}

/// The newest `crash-*.txt` in a game folder's crash-reports (names sort by time).
pub fn newest_crash_report(home: *Path) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: fs::read_dir(crash_reports_dir(home))
    // rust: .ok()?
    // rust: .flatten()
    // rust: .map(|e| e.path())
    // rust: .filter(|p| {
    // rust: p.file_name()
    // rust: .and_then(|n| n.to_str())
    // rust: .is_some_and(|n| n.starts_with("crash-") && n.ends_with(".txt"))
    // rust: })
    // rust: .max_by_key(|p| p.file_name().map(|n| n.to_owned()))
}

    // rust: mod tests {
//     use super::*;

pub fn a_player_dir_keeps_the_shared_files_in_the_game_folder() void {
}
    // rust: let (game, player) = (Path::new("/games/shared"), Path::new("/games/players/alex"));
        // options.txt moved to the player's folder: the enabled mods stay the game folder's.
    // rust: assert_eq!(shared_dir_of(Some(player), player, || game.into()), game);
        // No --player-dir, or a splitscreen profile's own folder: beside options.txt as before.
    // rust: assert_eq!(shared_dir_of(None, game, || unreachable!()), game);
    // rust: let profile = Path::new("/games/shared/splitscreen/profiles/P2");
    // rust: assert_eq!(
    // rust: shared_dir_of(Some(player), profile, || unreachable!()),
    // rust: profile
    // rust: );
}

pub fn a_warning_repeated_every_packet_is_counted_past_a_hundred_a_minute() void {
}
    // rust: let (mut floods, start) = (Floods::default(), Instant::now());
    // rust: let gates: Vec<Gate> = (0..140)
    // rust: .map(|i| floods.gate("lan_vehicles.rs", 345, start + Duration::from_millis(i * 7)))
    // rust: .collect();
    // rust: assert!(
    // rust: gates[..99]
    // rust: .iter()
    // rust: .all(|g| *g == Gate::Write { left_out: 0 })
    // rust: );
    // rust: assert_eq!(gates[99], Gate::Last);
    // rust: assert!(gates[100..].iter().all(|g| *g == Gate::Skip));
        // Another line of code has its own count.
    // rust: assert_eq!(
    // rust: floods.gate("lan_vehicles.rs", 330, start),
    // rust: Gate::Write { left_out: 0 }
    // rust: );
        // The next minute writes again, and says how many were left out.
    // rust: assert_eq!(
    // rust: floods.gate("lan_vehicles.rs", 345, start + FLOOD_WINDOW),
    // rust: Gate::Write { left_out: 40 }
    // rust: );
    // rust: assert_eq!(
    // rust: floods.gate("lan_vehicles.rs", 345, start + FLOOD_WINDOW),
    // rust: Gate::Write { left_out: 0 }
    // rust: );
}

pub fn day(d: u32) N {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: NaiveDate::from_ymd_opt(2026, 10, d).unwrap()
}

pub fn archives_are_named_like_vanillas() void {
}
    // rust: assert_eq!(archive_name(day(4), 1), "2026-10-04-1.log.gz");
    // rust: let none: Vec<String> = Vec::new();
    // rust: assert_eq!(
    // rust: rollover(&none, day(14), 7),
    // rust: Rollover {
    // rust: delete: None,
    // rust: renames: vec![],
    // rust: archive: "2026-10-14-1.log.gz".into()
}
    // rust: );
        // Another day's archives and unrelated files do not count.
    // rust: let names: Vec<String> = [
    // rust: "2026-10-13-1.log.gz",
    // rust: "2026-10-13-2.log.gz",
    // rust: "2026-10-14-1.log.gz",
    // rust: "2026-10-14-2.log.gz",
    // rust: "latest.log",
    // rust: "debug-1.log.gz",
    // rust: ]
    // rust: .map(String::from)
    // rust: .to_vec();
    // rust: assert_eq!(rollover(&names, day(14), 7).archive, "2026-10-14-3.log.gz");
    // rust: assert_eq!(rollover(&names, day(13), 7).archive, "2026-10-13-3.log.gz");
    // rust: assert_eq!(rollover(&names, day(15), 7).archive, "2026-10-15-1.log.gz");
}

pub fn the_eighth_archive_of_a_day_drops_the_oldest() void {
}
    // rust: let names: Vec<String> = (1..=7).map(|i| archive_name(day(14), i)).collect();
    // rust: let plan = rollover(&names, day(14), 7);
    // rust: assert_eq!(plan.delete.as_deref(), Some("2026-10-14-1.log.gz"));
    // rust: assert_eq!(plan.renames.len(), 6);
    // rust: assert_eq!(
    // rust: plan.renames[0],
    // rust: ("2026-10-14-2.log.gz".into(), "2026-10-14-1.log.gz".into())
    // rust: );
    // rust: assert_eq!(
    // rust: plan.renames[5],
    // rust: ("2026-10-14-7.log.gz".into(), "2026-10-14-6.log.gz".into())
    // rust: );
    // rust: assert_eq!(plan.archive, "2026-10-14-7.log.gz");
}

pub fn lines_look_like_log4js_pattern() void {
}
    // rust: let time = chrono::TimeZone::with_ymd_and_hms(&Local, 2026, 10, 14, 9, 5, 7).unwrap();
    // rust: assert_eq!(
    // rust: format_line(
    // rust: &time,
    // rust: "Render thread",
    // rust: log::Level::Info,
    // rust: "load assets: 1.20s"
    // rust: ),
    // rust: "[09:05:07] [Render thread/INFO]: load assets: 1.20s"
    // rust: );
    // rust: assert_eq!(
    // rust: format_line(&time, "Worker-1", log::Level::Warn, "x"),
    // rust: "[09:05:07] [Worker-1/WARN]: x"
    // rust: );
}

pub fn startup_archives_the_last_runs_log() void {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-logs-test-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&dir);
    // rust: fs::create_dir_all(&dir).unwrap();
        // Empty: nothing is archived (OnStartupTriggeringPolicy's minSize is 1 byte).
    // rust: drop(open_latest(&dir).unwrap().unwrap());
    // rust: assert_eq!(fs::read_dir(&dir).unwrap().count(), 2);
    // rust: fs::write(
    // rust: dir.join("latest.log"),
    // rust: "[10:00:00] [Render thread/INFO]: first run\n",
    // rust: )
    // rust: .unwrap();
    // rust: let mut latest = open_latest(&dir).unwrap().unwrap();
        // A second game in the same folder leaves the file alone.
    // rust: assert!(open_latest(&dir).unwrap().is_none());
    // rust: writeln!(latest.file, "second run").unwrap();
    // rust: drop(latest);
    // rust: let today = Local::now().date_naive();
    // rust: let archive = dir.join(archive_name(today, 1));
    // rust: let mut text = String::new();
    // rust: flate2::read::GzDecoder::new(File::open(&archive).unwrap())
    // rust: .read_to_string(&mut text)
    // rust: .unwrap();
    // rust: assert_eq!(text, "[10:00:00] [Render thread/INFO]: first run\n");
    // rust: assert_eq!(
    // rust: fs::read_to_string(dir.join("latest.log")).unwrap(),
    // rust: "second run\n"
    // rust: );
    // rust: assert_eq!(
    // rust: tail(&dir.join("latest.log"), 100).unwrap(),
    // rust: vec!["second run"]
    // rust: );
    // rust: let _ = fs::remove_dir_all(&dir);
}

pub fn the_newest_crash_report_is_found_by_name() void {
}
    // rust: let home = std::env::temp_dir().join(format!("horizon-crash-test-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&home);
    // rust: assert!(newest_crash_report(&home).is_none());
    // rust: let dir = crash_reports_dir(&home);
    // rust: fs::create_dir_all(&dir).unwrap();
    // rust: for name in [
    // rust: "crash-2026-10-13_23.59.59-client.txt",
    // rust: "crash-2026-10-14_08.00.01-client.txt",
    // rust: "notes.txt",
    // rust: ] {
    // rust: fs::write(dir.join(name), "x").unwrap();
}
    // rust: assert_eq!(
    // rust: newest_crash_report(&home).unwrap(),
    // rust: dir.join("crash-2026-10-14_08.00.01-client.txt")
    // rust: );
    // rust: let _ = fs::remove_dir_all(&home);
}
}
