//! Transpiled from Horizon Rust crate
package horizon_client_dedicated

import "core:fmt"
import "core:mem"
import "core:math"

// The dedicated server (net.minecraft.server.Main and DedicatedServer):
// `horizon-client --dedicated [--nogui] [--port N] [--world NAME]
// [--universe DIR] [--initSettings]`. It reads server.properties and
// eula.txt from the working directory, opens `<universe>/<level-name>` and
// runs the same game as single player, without a local player: the world,
// its simulation and the play-state hub that LAN hosting uses, configured
// from server.properties, with the operator, whitelist and ban lists and a
// console on standard input.
// use super::{Game, Options, lan::LanSettings, world_loading::WorldRequest};
// use horizon_client::{
    // rust: Result,
    // rust: lan::{LoginGate, NetConfig, NetLog, OnlineMode, hub::HubConfig},
    // rust: server::{
    // rust: eula, profiles,
    // rust: properties::{GAME_MODES, ServerProperties, SystemEntropy},
    // rust: user_cache::UserCache,
    // rust: user_lists::{
    // rust: BanEntry, BanList, Change, IpBanList, NameAndId, OpEntry, OpList, WhiteEntry,
    // rust: WhiteList, format_date,
    // rust: },
    // rust: },
    // rust: text::Text,
}
// use horizon_protocol::text::translatable;
// use horizon_world::nbt::{JavaString, Tag};
// use std::{
    // rust: io::Write,
    // rust: path::PathBuf,
    // rust: sync::{
    // rust: Arc, Mutex, OnceLock,
    // rust: atomic::{AtomicBool, AtomicU64, Ordering},
    // rust: mpsc,
    // rust: },
    // rust: time::{Duration, Instant},
}

    // rust: pub(super) mod events;
    // rust: mod management;
    // rust: mod report;
    // rust: mod status;
    // rust: mod transfer;

// What the tick loop tells `ServerWatchdog`: when the tick in progress was
// due (`getNextTickTime`), how long a tick is, and whether the server runs.
Watchdog :: struct {
    base: Instant,
    next_nanos: AtomicU64,
    tick_nanos: AtomicU64,
    running: AtomicBool,
}

    // rust: impl Watchdog {
    // `DedicatedServer.initServer`: a thread that stops a server whose tick
    // runs `max_tick_time` ms past its due time; none when that is 0 or less.
start :: proc(max_tick_time: i64) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let max = Duration::from_millis(u64::try_from(max_tick_time).ok().filter(|m| *m > 0)?);
    // rust: let watchdog = Arc::new(Self {
    // rust: base: Instant::now(),
    // rust: next_nanos: AtomicU64::new(0),
    // rust: tick_nanos: AtomicU64::new(50_000_000),
    // rust: running: AtomicBool::new(true),
    // rust: });
    // rust: let shared = watchdog.clone();
    // rust: std::thread::Builder::new()
    // rust: .name("Server Watchdog".into())
    // rust: .spawn(move || shared.run(max))
    // rust: .ok()?;
    // rust: Some(watchdog)
}
    // The tick loop is about to run the tick due at `next`.
tick_due :: proc(self: ^Self, next: Instant, tick: Duration) {
}
    // rust: let nanos = next.saturating_duration_since(self.base).as_nanos();
    // rust: self.next_nanos
    // rust: .store(u64::try_from(nanos).unwrap_or(u64::MAX), Ordering::Relaxed);
    // rust: let tick = u64::try_from(tick.as_nanos()).unwrap_or(u64::MAX);
    // rust: self.tick_nanos.store(tick, Ordering::Relaxed);
}
    // `ServerWatchdog.run`.
run :: proc(self: ^Self, max: Duration) {
}
    // rust: let max = u64::try_from(max.as_nanos()).unwrap_or(u64::MAX);
    // rust: while self.running.load(Ordering::Relaxed) {
    // rust: let next = self.next_nanos.load(Ordering::Relaxed);
    // rust: let now = u64::try_from(self.base.elapsed().as_nanos()).unwrap_or(u64::MAX);
    // rust: let behind = now.saturating_sub(next);
    // rust: if behind > max {
    // rust: let took = format!("{:.2}", behind as f32 / 1e9);
    // rust: let should = format!(
    // rust: "{:.2}",
    // rust: self.tick_nanos.load(Ordering::Relaxed) as f32 / 1e9
    // rust: );
    // rust: log_from(
    // rust: "Server Watchdog",
    // rust: "ERROR",
    // rust: &format!("A single server tick took {took} seconds (should be max {should})"),
    // rust: );
    // rust: log_from(
    // rust: "Server Watchdog",
    // rust: "ERROR",
    // rust: "Considering it to be crashed, server will forcibly shutdown.",
    // rust: );
    // rust: let message = format!(
    // rust: "ServerWatchdog detected that a single server tick took {took} seconds (should be max {should})"
    // rust: );
    // rust: match horizon_client::crash::report_watchdog(
    // rust: std::path::Path::new("."),
    // rust: "server",
    // rust: message,
    // rust: ) {
    // rust: Some(path) => log_from(
    // rust: "Server Watchdog",
    // rust: "ERROR",
    // rust: &format!(
    // rust: "This crash report has been saved to: {}",
    // rust: path.canonicalize().unwrap_or(path).display()
    // rust: ),
    // rust: ),
    // rust: None => log_from(
    // rust: "Server Watchdog",
    // rust: "ERROR",
    // rust: "We were unable to save this crash report to disk.",
    // rust: ),
}
    // rust: std::process::exit(1);
}
            // Thread.sleep(nextTickTime + maxTickTime - now).
    // rust: let wait = (next + max).saturating_sub(now).max(1_000_000);
    // rust: std::thread::sleep(Duration::from_nanos(wait));
}
}
}

// Double.toString for the magnitudes positions have (no exponent form
// between 1e-3 and 1e7).
    // rust: pub(super) fn java_double(v: f64) -> String {
    // rust: if v == 0.0 || (1e-3..1e7).contains(&v.abs()) {
    // rust: format!("{v:?}")
    // rust: } else {
    // rust: let s = format!("{v:E}");
    // rust: let (m, e) = s.split_once('E').unwrap_or((&s, "0"));
    // rust: let m = if m.contains('.') {
    // rust: m.to_owned()
    // rust: } else {
    // rust: format!("{m}.0")
}
    // rust: format!("{m}E{e}")
}
}

// What the startup read before the game's resources were loaded.
Setup :: struct {
    props: ServerProperties,
    universe: PathBuf,
    level_name: string,
    port: Maybe(u16),
    started: Instant,
}
SETUP :: OnceLock::new()
// usercache.json (Services.nameToIdCache): used by the server thread only.
USER_CACHE :: Mutex::new(None)

// PlayerList.placeNewPlayer: a player who joined is cached (and the file saved).
    // rust: pub(super) fn player_joined(id: u128, name: &str) {
    // rust: if let Some(cache) = USER_CACHE.lock().unwrap().as_mut() {
    // rust: cache.add(NameAndId {
    // rust: id,
    // rust: name: name.to_owned(),
    // rust: });
}
}

// `server.toml`'s `[anticheat]`, beside server.properties when horizon-server runs the game; the
// default (on) without the file or the section, off (with an error logged) when the section is wrong.
load_anticheat :: proc() -> h {
    // Ported from Horizon
    return {}
}
    // rust: let Ok(text) = std::fs::read_to_string("server.toml") else {
    // rust: return Default::default();
}
    // rust: match horizon_anticheat::Config::from_server_toml(&text) {
    // rust: Ok(config) => {
    // rust: if config.enabled {
    // rust: log(
    // rust: "INFO",
    // rust: "Anticheat on (server.toml [anticheat]; enabled = false turns it off)",
    // rust: );
}
    // rust: config
}
    // rust: Err(e) => {
    // rust: log(
    // rust: "ERROR",
    // rust: &format!("server.toml: {e}; the anticheat stays off"),
    // rust: );
    // rust: horizon_anticheat::Config {
    // rust: enabled: false,
    // rust: ..Default::default()
}
}
}
}

// `server.toml`'s `[chat_filter]` (docs/chat-filter.md), like `[anticheat]`: on by default, off (with an
// error logged) when the section is wrong. The mutes are kept beside server.properties.
load_chat_filter :: proc() -> O {
    // Ported from Horizon
    return {}
}
    // rust: let text = std::fs::read_to_string("server.toml").unwrap_or_default();
    // rust: let config = match horizon_chat_filter::Config::from_server_toml(&text) {
    // rust: Ok(config) => config,
    // rust: Err(e) => {
    // rust: log(
    // rust: "ERROR",
    // rust: &format!("server.toml: {e}; the chat filter stays off"),
    // rust: );
    // rust: return None;
}
}
    // rust: if !config.enabled {
    // rust: return None;
}
    // rust: let (guard, problem) = horizon_chat_filter::Guard::load(config, std::path::Path::new("."));
    // rust: if let Some(problem) = problem {
    // rust: log("WARN", &problem);
}
    // rust: log(
    // rust: "INFO",
    // rust: &format!(
    // rust: "Chat filter on: {} words (server.toml [chat_filter]; enabled = false turns it off)",
    // rust: guard.filter.len()
    // rust: ),
    // rust: );
    // rust: Some(guard)
}

// `server.toml`'s `[combat]` (docs/pvp.md): `legacy = true` resolves melee hits by 1.8.9's rules. Off without
// the file or the section, and (with an error logged) when the section is wrong.
load_combat :: proc() -> b {
    // Ported from Horizon
    return {}
}
Combat :: struct {
    legacy: bool,
}
    // rust: let Ok(text) = std::fs::read_to_string("server.toml") else {
    // rust: return false;
}
    // rust: let section = toml::from_str::<toml::Table>(&text)
    // rust: .map_err(|e| e.to_string())
    // rust: .and_then(|mut t| match t.remove("combat") {
    // rust: Some(section) => section
    // rust: .try_into::<Combat>()
    // rust: .map(|c| c.legacy)
    // rust: .map_err(|e| format!("[combat]: {e}")),
    // rust: None => Ok(false),
    // rust: });
    // rust: match section {
    // rust: Ok(legacy) => {
    // rust: if legacy {
    // rust: log(
    // rust: "INFO",
    // rust: "1.8 combat rules on (server.toml [combat]; legacy = false turns them off)",
    // rust: );
}
    // rust: legacy
}
    // rust: Err(e) => {
    // rust: log(
    // rust: "ERROR",
    // rust: &format!("server.toml: {e}; fights keep 26.3's rules"),
    // rust: );
    // rust: false
}
}
}

// The secret for Velocity's player information forwarding, from `forwarding.secret` beside server.properties.
// No file means no forwarding. A file that is empty or can't be read stops the start, because an empty secret
// would let anyone sign a login, and a typo must not leave a server open that was meant to be behind a proxy.
forwarding_secret :: proc(online: bool) -> R {
    // Ported from Horizon
    return {}
}
FILE :: "forwarding.secret"
    // rust: if !std::path::Path::new(FILE).exists() {
    // rust: return Ok(None);
}
    // rust: if online {
    // rust: log(
    // rust: "WARN",
    // rust: "forwarding.secret is ignored: the proxy authenticates the players, so set \"online-mode\" to \"false\".",
    // rust: );
    // rust: return Ok(None);
}
    // rust: let text = std::fs::read(FILE).map_err(|e| format!("{FILE}: {e}"))?;
    // rust: let secret = text.trim_ascii().to_vec();
    // rust: if secret.is_empty() {
    // rust: return Err(format!(
    // rust: "{FILE} is empty: put the proxy's forwarding secret in it, or remove the file"
    // rust: )
    // rust: .into());
}
    // rust: log(
    // rust: "INFO",
    // rust: "Velocity player information forwarding is on (forwarding.secret)",
    // rust: );
    // rust: Ok(Some(secret))
}

// `MinecraftServer.runServer`'s overload warning for a server `behind` its
// schedule, in milliseconds and in ticks of `tick`.
overload_warning :: proc(behind: Duration, tick: Duration) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!(
    // rust: "Can't keep up! Is the server overloaded? Running {}ms or {} ticks behind",
    // rust: behind.as_millis(),
    // rust: behind.as_nanos() / tick.as_nanos().max(1)
    // rust: )
}

// Log4j's console pattern: `[HH:mm:ss] [thread/LEVEL]: message`.
    // rust: pub(super) fn log(level: &str, message: &str) {
    // rust: log_from("Server thread", level, message);
}

// A line from another of vanilla's threads (the login's User Authenticator).
log_from :: proc(thread: string, level: string, message: string) {
}
    // rust: let file_level = match level {
    // rust: "WARN" => ::log::Level::Warn,
    // rust: "ERROR" => ::log::Level::Error,
    // rust: _ => ::log::Level::Info,
}
    // rust: horizon_client::logging::write_as(thread, file_level, message);
    // rust: CAPTURE.with_borrow_mut(|lines| {
    // rust: if let Some(lines) = lines {
    // rust: lines.push(message.to_owned());
}
    // rust: });
    // Log4j's %d{HH:mm:ss}: the local time, as in logs/latest.log.
    // The launcher can close its stdout pipe while the server keeps running.
    // rust: let _ = writeln!(
    // rust: std::io::stdout().lock(),
    // rust: "[{}] [{thread}/{level}]: {message}",
    // rust: chrono::Local::now().format("%H:%M:%S")
    // rust: );
}

    // rust: thread_local! {
    // The lines logged while a control request runs a console command.
CAPTURE :: const { std::cell::RefCell::new(None) }
}

// Runs `f` and returns the lines it logged.
capture_log :: proc(f: impl FnOnce() {
}
    // rust: CAPTURE.set(Some(Vec::new()));
    // rust: f();
    // rust: CAPTURE.take().unwrap_or_default()
}

// Main.main up to the server start: arguments, server.properties (stored
// back at once), eula.txt. False when the process should stop here.
    // rust: pub(super) fn preflight(options: &mut Options) -> Result<bool> {
    // rust: let args = options.dedicated.clone().unwrap_or_default();
    // rust: let mut universe = PathBuf::from(".");
    // rust: let mut world = None;
    // rust: let mut port = None;
    // rust: let mut init_settings = false;
    // rust: let mut it = args.iter();
    // rust: while let Some(arg) = it.next() {
    // rust: let name = arg.trim_start_matches('-');
    // rust: match name {
    // rust: "nogui"
    // rust: | "demo"
    // rust: | "bonusChest"
    // rust: | "forceUpgrade"
    // rust: | "eraseCache"
    // rust: | "recreateRegionFiles"
    // rust: | "safeMode"
    // rust: | "jfrProfile" => {}
    // rust: "initSettings" => init_settings = true,
    // rust: "help" => {
    // rust: eprintln!(
    // rust: "Option                Description\n------                -----------\n--help\n--initSettings        Initializes 'server.properties' and 'eula.txt', then quits\n--nogui\n--port <Integer>      (default: -1)\n--universe <String>   (default: .)\n--world <String>"
    // rust: );
    // rust: return Ok(false);
}
    // rust: "universe" => universe = PathBuf::from(it.next().ok_or("--universe needs a value")?),
    // rust: "world" => world = Some(it.next().ok_or("--world needs a value")?.clone()),
    // rust: "port" => {
    // rust: let v: i32 = it.next().ok_or("--port needs a value")?.parse()?;
    // rust: port = u16::try_from(v).ok();
}
    // rust: "serverId" | "pidFile" => {
    // rust: let value = it.next().ok_or("missing value")?;
    // rust: if name == "pidFile" {
    // rust: std::fs::write(value, std::process::id().to_string())?;
}
}
    // rust: _ => return Err(format!("{arg} is not a recognized option").into()),
}
}
    // rust: let started = Instant::now();
    // rust: let settings = PathBuf::from("server.properties");
    // rust: let props = ServerProperties::from_file(&settings, &mut SystemEntropy::default())?;
    // rust: for w in &props.warnings {
    // rust: log("WARN", w);
}
    // A dedicated server's tree: /op, /ban, /whitelist... (single player's
    // server thread is an integrated one and never gets here).
    // rust: horizon_client::command::vanilla::set_dedicated_commands(true);
    // Horizon's own commands are the owner's choice, off as on vanilla.
    // rust: if props
    // rust: .raw
    // rust: .get(horizon_client::command::vanilla::PREGEN_PROPERTY)
    // rust: .is_some_and(|v| v.trim().eq_ignore_ascii_case("true"))
    // rust: {
    // rust: horizon_client::command::vanilla::set_horizon_commands(true);
}
    // rust: props.store(&settings)?;
    // rust: let eula_file = PathBuf::from("eula.txt");
    // rust: let agreed = match eula::agreed(&eula_file) {
    // rust: Ok(a) => a,
    // rust: Err(w) => {
    // rust: log("WARN", &w);
    // rust: false
}
}
    // rust: if init_settings {
    // rust: let abs = |p: &PathBuf| std::env::current_dir().map_or(p.clone(), |d| d.join(p));
    // rust: log(
    // rust: "INFO",
    // rust: &format!(
    // rust: "Initialized '{}' and '{}'",
    // rust: abs(&settings).display(),
    // rust: abs(&eula_file).display()
    // rust: ),
    // rust: );
    // rust: return Ok(false);
}
    // rust: if !agreed {
    // rust: log(
    // rust: "INFO",
    // rust: "You need to agree to the EULA in order to run the server. Go to eula.txt for more info.",
    // rust: );
    // rust: return Ok(false);
}
    // rust: let level_name = world.unwrap_or_else(|| props.level_name.clone());
    // rust: SETUP
    // rust: .get_or_init(|| Mutex::new(None))
    // rust: .lock()
    // rust: .unwrap()
    // rust: .replace(Setup {
    // rust: props,
    // rust: universe,
    // rust: level_name,
    // rust: port,
    // rust: started,
    // rust: });
    // rust: Ok(true)
}

// The event a change of a list is (`operators_added`, `bans_removed`...), and the entry it is about.
    // rust: fn listed<E>(list: &str, change: Change<E>) -> (String, E) {
    // rust: match change {
    // rust: Change::Added(e) => (format!("{list}_added"), e),
    // rust: Change::Removed(e) => (format!("{list}_removed"), e),
}
}

// What a ban says besides who it is for: the reason and the source, and when it ends (milliseconds, or none).
    // rust: fn ban_fields<T>(ban: &BanEntry<T>) -> serde_json::Value {
    // rust: serde_json::json!({ "reason": ban.reason, "source": ban.source, "expires": ban.expires })
}

// The operator, whitelist and ban lists (DedicatedPlayerList), shared with
// the connection threads that check logins, and the server's own switches
// that an operator's command changes.
    // rust: pub(super) struct Lists {
    // rust: pub ops: OpList,
    // rust: pub white: WhiteList,
    // rust: pub bans: BanList,
    // rust: pub ip_bans: IpBanList,
    // rust: pub use_whitelist: bool,
    // rust: pub enforce_whitelist: bool,
    // `op-permission-level`: what `/op` grants (operatorUserPermissions).
    // rust: pub op_level: i32,
    // `MinecraftServer.playerIdleTimeout`: the minutes of idleness after
    // which a player is kicked, `player-idle-timeout` at the start and
    // `/setidletimeout` after it.
    // rust: pub player_idle_timeout: i32,
    // `/stop` (MinecraftServer.halt): the server loop ends after this tick.
    // rust: pub stop: bool,
    // `MinecraftServer.isAutoSave`: all of Horizon's server levels share this save flag.
    // rust: pub autosave: bool,
    // UUID prefixes (lower case, with dashes) that pass the whitelist: `whitelist-bypass.txt`.
    // rust: pub whitelist_bypass: Vec<String>,
}

// The lines of `whitelist-bypass.txt`: one UUID prefix each, e.g. `00000000-0000-0000-0009-` for Floodgate's
// Bedrock players. `#` starts a comment. A prefix has to be a dashed UUID start of at least 8 characters, so
// a typo can't open the whitelist to everybody.
parse_whitelist_bypass :: proc(text: string) -> s {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::new();
    // rust: for (n, line) in text.lines().enumerate() {
    // rust: let line = line
    // rust: .split('#')
    // rust: .next()
    // rust: .unwrap_or("")
    // rust: .trim()
    // rust: .to_ascii_lowercase();
    // rust: if line.is_empty() {
    // rust: continue;
}
    // rust: if line.len() < 8
    // rust: || line.len() > 36
    // rust: || !line.chars().all(|c| c.is_ascii_hexdigit() || c == '-')
    // rust: {
    // rust: return Err(format!(
    // rust: "whitelist-bypass.txt line {}: {line:?} is not a UUID prefix",
    // rust: n + 1
    // rust: ));
}
    // rust: out.push(line);
}
    // rust: Ok(out)
}
    // rust: impl Lists {
load :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut l = Self {
    // rust: ops: OpList::new("ops.json"),
    // rust: white: WhiteList::new("whitelist.json"),
    // rust: bans: BanList::new("banned-players.json"),
    // rust: ip_bans: IpBanList::new("banned-ips.json"),
    // rust: use_whitelist: false,
    // rust: enforce_whitelist: false,
    // rust: op_level: 4,
    // rust: player_idle_timeout: 0,
    // rust: stop: false,
    // rust: autosave: true,
    // rust: whitelist_bypass: Vec::new(),
}
        // Horizon only: players from a proxy's Bedrock bridge (Floodgate) are never on whitelist.json.
    // rust: if let Ok(text) = std::fs::read_to_string("whitelist-bypass.txt") {
    // rust: match parse_whitelist_bypass(&text) {
    // rust: Ok(prefixes) => {
    // rust: log(
    // rust: "INFO",
    // rust: &format!(
    // rust: "whitelist-bypass.txt: {} UUID prefix(es) skip the whitelist",
    // rust: prefixes.len()
    // rust: ),
    // rust: );
    // rust: l.whitelist_bypass = prefixes;
}
    // rust: Err(e) => log("ERROR", &format!("{e}; the file is ignored")),
}
}
        // Each list tells the event stream what changes in it, as vanilla's tell their `NotificationService`.
    // rust: l.ops.watch(|change| {
    // rust: let (kind, e) = listed("operators", change);
    // rust: events::record(
    // rust: &kind,
    // rust: &e.user.name,
    // rust: e.user.id,
    // rust: serde_json::json!({ "level": e.level, "bypassesPlayerLimit": e.bypasses_player_limit }),
    // rust: );
    // rust: });
    // rust: l.white.watch(|change| {
    // rust: let (kind, e) = listed("allowlist", change);
    // rust: events::record(&kind, &e.user.name, e.user.id, serde_json::json!({}));
    // rust: });
    // rust: l.bans.watch(|change| {
    // rust: let (kind, e) = listed("bans", change);
    // rust: events::record(&kind, &e.user.name, e.user.id, ban_fields(&e));
    // rust: });
    // rust: l.ip_bans.watch(|change| {
    // rust: let (kind, e) = listed("ip_bans", change);
    // rust: let mut fields = ban_fields(&e);
    // rust: fields["ip"] = e.user.clone().into();
    // rust: events::record_server(&kind, fields);
    // rust: });
        // DedicatedPlayerList's constructor order and its LOGGER.warn lines.
    // rust: let warn = |what: &str, r: std::result::Result<(), String>| {
    // rust: if let Err(e) = r {
    // rust: log("WARN", &format!("Failed to {what}: {e}"));
}
}
    // rust: let saved = |r: std::io::Result<()>| r.map_err(|e| e.to_string());
    // rust: warn("load user banlist", l.bans.load());
    // rust: warn("save user banlist", saved(l.bans.save()));
    // rust: warn("load ip banlist", l.ip_bans.load());
    // rust: warn("save ip banlist", saved(l.ip_bans.save()));
    // rust: warn("load operators list", l.ops.load());
    // rust: warn("load white-list", l.white.load());
    // rust: warn("save operators list", saved(l.ops.save()));
    // rust: if !l.white.file.exists() {
    // rust: warn("save white-list", saved(l.white.save()));
}
    // rust: l
}
    // PlayerList.isWhiteListed.
whitelisted :: proc(self: ^Self, user: ^NameAndId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.use_whitelist
    // rust: || self.ops.contains(user)
    // rust: || self.white.contains(user)
    // rust: || self.bypasses_whitelist(user.id)
}
bypasses_whitelist :: proc(self: ^Self, id: u128) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let id = horizon_protocol::crypto::uuid_string(id);
    // rust: self.whitelist_bypass
    // rust: .iter()
    // rust: .any(|p| id.starts_with(p.as_str()))
}
    // PlayerList.canPlayerLogin before the player count.
can_login :: proc(self: ^Self, address: std::net::SocketAddr, user: ^NameAndId) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if self.bans.contains(user)
    // rust: && let Some(ban) = self.bans.get(user).cloned()
    // rust: {
    // rust: return Some(ban_message(&ban));
}
    // rust: if !self.whitelisted(user) {
    // rust: return Some(translatable("multiplayer.disconnect.not_whitelisted", &[]));
}
    // rust: let ip = address.ip().to_string();
    // rust: if self.ip_bans.contains(&ip)
    // rust: && let Some(ban) = self.ip_bans.get(&ip).cloned()
    // rust: {
    // rust: let mut reason = translatable_tag(
    // rust: "multiplayer.disconnect.banned_ip.reason",
    // rust: vec![ban_reason(&ban.reason)],
    // rust: );
    // rust: if let Some(expires) = ban.expires {
    // rust: append(
    // rust: &mut reason,
    // rust: translatable_tag(
    // rust: "multiplayer.disconnect.banned_ip.expiration",
    // rust: vec![Tag::String(JavaString::from(ban_date(expires).as_str()))],
    // rust: ),
    // rust: );
}
    // rust: return Some(reason);
}
    // rust: None
}
}

// DedicatedServerProperties.LEGACY_PRESET_NAMES: the old `level-type`
// names, before the presets had their own ids.
    // rust: const LEGACY_PRESET_NAMES: [(&str, horizon_client::save::WorldPreset); 2] = [
    // rust: ("default", horizon_client::save::WorldPreset::Normal),
    // rust: (
    // rust: "largebiomes",
    // rust: horizon_client::save::WorldPreset::LargeBiomes,
    // rust: ),
    // rust: ];

// server.properties' line for `server.toml`'s `max_view_distance` (horizon-server writes it).
FAR_PROPERTY :: "horizon-max-view-distance"
// A dedicated server logs a tick slower than this, in milliseconds, with
// its spans, unless `HORIZON_SPIKES` names another threshold: five ticks'
// worth, a stall players feel as rubber-banding.
    // rust: pub(super) const SLOW_TICK_MS: f32 = 250.0;
// `MinecraftServer.OVERLOADED_WARNING_INTERVAL_NANOS` plus 100 ticks: the
// "Can't keep up!" warning comes at most this often.
OVERLOAD_WARNING_INTERVAL :: Duration::from_secs(15)
// server.properties' line for `server.toml`'s `admin_feedback_to_ops` (horizon-server writes it).
ADMIN_FEEDBACK_PROPERTY :: "horizon-admin-feedback-to-ops"

// Identifier.tryParse: `namespace:path`, or a path in `minecraft`.
parse_identifier :: proc(text: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let (namespace, path) = text.split_once(':').unwrap_or(("minecraft", text));
    // rust: let valid = |s: &str, extra: &[char]| {
    // rust: s.chars()
    // rust: .all(|c| matches!(c, 'a'..='z' | '0'..='9' | '_' | '.' | '-') || extra.contains(&c))
}
    // rust: (valid(namespace, &[]) && valid(path, &['/'])).then(|| format!("{namespace}:{path}"))
}

    // rust: impl Game<'_> {
    // DedicatedServerProperties.createDimensions for a world that doesn't
    // exist yet: `level-type`'s preset, a flat world's `generator-settings`
    // and `generate-structures`, written before the world opens so that
    // streaming reads them.
write_world_gen :: proc(self: ^Self, dir: ^std::path::Path, props: ^ServerProperties) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let level_type = &props.level_type;
    // rust: let preset = parse_identifier(level_type)
    // rust: .as_deref()
    // rust: .and_then(horizon_client::save::WorldPreset::of_id)
    // rust: .or_else(|| {
    // rust: LEGACY_PRESET_NAMES
    // rust: .iter()
    // rust: .find(|(name, _)| *name == level_type)
    // rust: .map(|(_, preset)| *preset)
    // rust: })
    // rust: .unwrap_or_else(|| {
    // rust: log_from(
    // rust: "Worker-Main-1",
    // rust: "WARN",
    // rust: &format!(
    // rust: "Failed to parse level-type {level_type}, defaulting to minecraft:normal"
    // rust: ),
    // rust: );
    // rust: horizon_client::save::WorldPreset::Normal
    // rust: });
    // rust: let flat = preset == horizon_client::save::WorldPreset::Flat;
    // rust: let settings = if flat {
    // rust: let biomes = world_biomes!(self);
    // rust: let (settings, errors) = horizon_client::flatgen::settings_from_json(
    // rust: &props.generator_settings,
    // rust: |b| self.pack.assets.registry.default_state(b).is_some(),
    // rust: |b| biomes.get(biomes.id(b)).name == b,
    // rust: );
    // rust: for e in errors {
    // rust: log_from("Worker-Main-1", "ERROR", &e);
}
    // rust: settings
    // rust: } else {
    // rust: None
}
    // rust: let options = horizon_client::save::WorldGen {
    // rust: preset,
    // rust: structures: props.generate_structures,
    // rust: bonus_chest: false,
}
    // rust: horizon_client::save::write_world_gen_settings_with(
    // rust: dir, props.seed, options, settings, None,
    // rust: )
}
}

// PlayerList.BAN_DATE_FORMAT ("yyyy-MM-dd 'at' HH:mm:ss z"), in UTC.
ban_date :: proc(millis: i64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let s = format_date(millis);
    // rust: format!("{} at {} UTC", &s[..10], &s[11..19])
}
// What a banned player is told: `multiplayer.disconnect.banned.reason` and, for a ban that ends,
// `multiplayer.disconnect.banned.expiration` (PlayerList.canPlayerLogin).
    // rust: pub(super) fn ban_message(ban: &BanEntry<NameAndId>) -> Tag {
    // rust: let mut reason = translatable_tag(
    // rust: "multiplayer.disconnect.banned.reason",
    // rust: vec![ban_reason(&ban.reason)],
    // rust: );
    // rust: if let Some(expires) = ban.expires {
    // rust: append(
    // rust: &mut reason,
    // rust: translatable_tag(
    // rust: "multiplayer.disconnect.banned.expiration",
    // rust: vec![Tag::String(JavaString::from(ban_date(expires).as_str()))],
    // rust: ),
    // rust: );
}
    // rust: reason
}
// BanListEntry.getReasonMessage.
ban_reason :: proc(reason: ^Maybe(string)) -> T {
    // Ported from Horizon
    return {}
}
    // rust: match reason {
    // rust: Some(r) => Tag::String(JavaString::from(r.as_str())),
    // rust: None => translatable("multiplayer.disconnect.banned.reason.default", &[]),
}
}
translatable_tag :: proc(key: string, args: [dynamic]Tag) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Tag::compound([
    // rust: ("translate", Tag::String(JavaString::from(key))),
    // rust: ("with", Tag::List(args)),
    // rust: ])
}
// MutableComponent.append.
append :: proc(to: ^Tag, sibling: Tag) {
}
    // rust: if let Tag::Compound(map) = to {
    // rust: let extra = map
    // rust: .entry(JavaString::from("extra"))
    // rust: .or_insert_with(|| Tag::List(Vec::new()));
    // rust: if let Tag::List(items) = extra {
    // rust: items.push(sibling);
}
}
}

// What the server loop keeps between ticks.
ServerState :: struct {
    lists: ^Mutex<Lists>,
    console: mpsc::Receiver<string>,
    empty_ticks: i32,
    // The mutable `DedicatedServer.pauseWhenEmptySeconds` setting.
    pause_when_empty_seconds: i32,
    // When the last passes of the loop ended, for the tick rate horizon-server shows.
    ticks: std::collections::VecDeque<Instant>,
    paused: bool,
    // `broadcast-console-to-ops`.
    broadcast_console: bool,
    // `broadcast-rcon-to-ops` (`MinecraftServer.shouldRconBroadcast`).
    broadcast_rcon: bool,
    // `op-permission-level`: what `/op` grants (operatorUserPermissions).
    op_level: i32,
    // `horizon-report`: the ticks being recorded.
    report: Maybe(report::Recording),
    // View and simulation distance, and the player limit, for the report.
    view: (u32,
    max_players: uint,
    // The mutable `gamemode` server property (`DedicatedServer.gameMode`).
    game_mode: i32,
    // The mutable `force-gamemode` server property (`DedicatedServer.forceGameMode`).
    force_game_mode: bool,
}

// `SaveAllCommand.saveAll`'s reply to its source: `commands.save.success` when
// the save went through, `commands.save.failed` (the `ERROR_FAILED` it throws)
// when it did not.
save_all_reply :: proc(saved: bool) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Text::translate(
    // rust: if saved {
    // rust: "commands.save.success"
    // rust: } else {
    // rust: "commands.save.failed"
    // rust: },
    // rust: &[],
    // rust: )
}

// `BanIpCommands.banIp`'s `commands.banip.info`: the count of affected players and
// `EntitySelector.joinNames` of them (a gray ", " between names). None when no one is affected,
// as vanilla sends no line then.
ban_ip_info :: proc(names: ^[string]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if names.is_empty() {
    // rust: return None;
}
    // rust: Some(Text::translate(
    // rust: "commands.banip.info",
    // rust: &[
    // rust: Text::literal(names.len().to_string()),
    // rust: horizon_client::scoreboard_cmd::format_list(
    // rust: names
    // rust: .iter()
    // rust: .map(|n| Text::literal((*n).to_owned()))
    // rust: .collect(),
    // rust: ),
    // rust: ],
    // rust: ))
}

// `MinecraftServer.isAutoSave`: all of Horizon's server levels share this save flag.
auto_save :: proc(state: ^ServerState) -> b {
    // Ported from Horizon
    return {}
}
    // rust: state.lists.lock().unwrap().autosave
}

// `MinecraftServer.setAutoSave`: enable or disable periodic saves and report whether it changed.
    // rust: pub(super) fn set_auto_save(lists: &Mutex<Lists>, enabled: bool) -> bool {
    // rust: let mut l = lists.lock().unwrap();
    // rust: let changed = l.autosave != enabled;
    // rust: l.autosave = enabled;
    // rust: changed
}

// The dedicated-only commands' replies vanilla sends with `broadcast`
// (`sendSuccess(..., true)`): the operators hear of them.
    // rust: const BROADCAST: &[&str] = &[
    // rust: "commands.ban.success",
    // rust: "commands.banip.info",
    // rust: "commands.banip.success",
    // rust: "commands.deop.success",
    // rust: "commands.kick.success",
    // rust: "commands.op.success",
    // rust: "commands.pardon.success",
    // rust: "commands.pardonip.success",
    // rust: "commands.save.disabled",
    // rust: "commands.save.enabled",
    // rust: "commands.save.success",
    // rust: "commands.stop.stopping",
    // rust: "commands.whitelist.add.success",
    // rust: "commands.whitelist.disabled",
    // rust: "commands.whitelist.enabled",
    // rust: "commands.whitelist.reloaded",
    // rust: "commands.whitelist.remove.success",
    // rust: ];

    // rust: impl Game<'_> {
    // DedicatedServer.initServer and MinecraftServer.runServer.
    // The epoch starts at world open; failures before that send no lifecycle event.
    // rust: pub(super) fn run_dedicated(&mut self) -> Result<()> {
    // rust: let result = self.run_dedicated_inner();
    // rust: if let Err(error) = &result {
    // rust: self.native_players_leaving();
    // rust: self.native_lifecycle_world_failed(&error.to_string());
    // rust: self.native_lifecycle_close_failed(&error.to_string());
}
    // rust: result
}

run_dedicated_inner :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
        // This thread ticks the server (MinecraftServer.spin's priority).
    // rust: horizon_threads::favour_current();
    // rust: self.join_world_rest()?;
    // rust: let Setup {
    // rust: props,
    // rust: universe,
    // rust: level_name,
    // rust: port,
    // rust: started,
    // rust: } = SETUP
    // rust: .get()
    // rust: .and_then(|m| m.lock().unwrap().take())
    // rust: .ok_or("dedicated server not prepared")?;
        // Main's WorldLoader: a new world's dimensions come from
        // server.properties before the server starts.
    // rust: let world_dir = std::env::current_dir()?.join(&universe).join(&level_name);
    // rust: let new_world = !world_dir.join("level.dat").exists();
    // rust: if new_world {
    // rust: self.write_world_gen(&world_dir, &props)?;
}
        // The console thread starts first, as in initServer.
    // rust: let (tx, console) = mpsc::channel();
    // rust: std::thread::Builder::new()
    // rust: .name("Server console handler".into())
    // rust: .spawn(move || {
    // rust: let stdin = std::io::stdin();
    // rust: let mut line = String::new();
    // rust: while stdin.read_line(&mut line).is_ok_and(|n| n > 0) {
    // rust: if tx
    // rust: .send(line.trim_end_matches(['\r', '\n']).to_owned())
    // rust: .is_err()
    // rust: {
    // rust: break;
}
    // rust: line.clear();
}
    // rust: })?;
        // Main: Services.create loads the universe's usercache.json.
    // rust: let (mut cache, warnings) = UserCache::load(universe.join("usercache.json"));
    // rust: for warning in warnings {
    // rust: log_from("main", "WARN", &warning);
}
        // DedicatedServer.initServer: names nobody has resolve offline only without authentication.
    // rust: cache.resolve_offline_users = !props.online_mode;
    // rust: *USER_CACHE.lock().unwrap() = Some(cache);
        // Services.create: the services' public keys, fetched in the
        // background (they check players' chat keys).
    // rust: let secure_chat = Arc::new(horizon_client::lan::SecureChat::new(
    // rust: props.enforce_secure_profile && props.online_mode,
    // rust: || {
    // rust: let discovery = profiles::discovery_url();
    // rust: profiles::fetch_profile_key_keys(&discovery).unwrap_or_else(|e| {
    // rust: ::log::error!("{e}");
    // rust: Vec::new()
    // rust: })
    // rust: },
    // rust: ));
    // rust: log(
    // rust: "INFO",
    // rust: &format!(
    // rust: "Starting minecraft server version {}",
    // rust: horizon_core::VANILLA_VERSION
    // rust: ),
    // rust: );
    // rust: log("INFO", "Loading properties");
    // rust: let game_mode = props.game_mode;
    // rust: log(
    // rust: "INFO",
    // rust: &format!(
    // rust: "Default game type: {}",
    // rust: GAME_MODES[game_mode as usize].to_uppercase()
    // rust: ),
    // rust: );
    // rust: let port = port.unwrap_or(props.server_port as u16);
        // MinecraftServer.initializeKeyPair (only online mode uses it).
    // rust: log("INFO", "Generating keypair");
    // rust: let online = if props.online_mode {
    // rust: Some(Arc::new(OnlineMode::generate(
    // rust: props.prevent_proxy_connections,
    // rust: )?))
    // rust: } else {
    // rust: None
}
    // rust: log(
    // rust: "INFO",
    // rust: &format!(
    // rust: "Starting Minecraft server on {}:{port}",
    // rust: if props.server_ip.is_empty() {
    // rust: "*"
    // rust: } else {
    // rust: &props.server_ip
}
    // rust: ),
    // rust: );
    // rust: if online.is_none() {
    // rust: log("WARN", "**** SERVER IS RUNNING IN OFFLINE/INSECURE MODE!");
    // rust: log(
    // rust: "WARN",
    // rust: "The server will make no attempt to authenticate usernames. Beware.",
    // rust: );
    // rust: log(
    // rust: "WARN",
    // rust: "While this makes the game possible to play without internet access, it also opens up the ability for hackers to connect with any username they choose.",
    // rust: );
    // rust: log(
    // rust: "WARN",
    // rust: "To change this, set \"online-mode\" to \"true\" in the server.properties file.",
    // rust: );
}
    // rust: let mut lists = Lists::load();
    // rust: lists.use_whitelist = props.white_list;
    // rust: lists.enforce_whitelist = props.enforce_whitelist;
    // rust: lists.op_level = props.op_permission_level;
    // rust: lists.player_idle_timeout = props.player_idle_timeout;
    // rust: let lists = Arc::new(Mutex::new(lists));
    // rust: self.server_lists = Some(lists.clone());
    // rust: log("INFO", &format!("Preparing level \"{level_name}\""));
    // rust: let folder = world_dir.to_string_lossy().into_owned();
        // The mods' common and server configs, read before the server starts.
    // rust: self.native_configs_server_start(&world_dir, true);
        // MinecraftServer.loadLevel's start: nothing is loaded yet.
    // rust: self.native_server_about_to_start(true);
    // rust: self.native_lifecycle_open_started();
        // The registries the server sends are read while the world prepares.
    // rust: let sync = super::lan::preload_sync_data(&self.options.resources);
    // rust: self.load_world(WorldRequest::new(
    // rust: &folder,
    // rust: Some(&level_name),
    // rust: Some(props.seed),
    // rust: game_mode == 1,
    // rust: None,
    // rust: )?)?;
    // rust: if new_world {
    // rust: self.level.hardcore = props.hardcore;
}
        // The single-player host's state is not used: players have their own files.
    // rust: self.level.position = None;
        // DedicatedServer.initServer: worldData.setGameType; forceDifficulty.
        // `load_world` restored difficulty from level.dat; server.properties wins
        // (vanilla's forceDifficulty), including health_rules used for despawn (#4694).
    // rust: self.set_default_game_mode(game_mode);
        // MinecraftServer.setDifficulty: a hardcore world is always hard.
    // rust: self.ui.difficulty = if self.level.hardcore {
    // rust: 3
    // rust: } else {
    // rust: props.difficulty as u8
}
    // rust: self.level.set_difficulty(self.ui.difficulty);
    // rust: self.sync_rules();
        // DedicatedServer.initServer: a legacy `announce-player-achievements`
        // sets the show_advancement_messages rule once, as the file is read.
    // rust: if let Some(announce) = props.announce_player_achievements {
    // rust: self.ui.rules.set(
    // rust: "show_advancement_messages",
    // rust: horizon_client::gamerules::Value::Bool(announce),
    // rust: );
}
    // rust: self.settings.render_distance = props.view_distance.clamp(2, 32);
    // rust: self.settings.simulation_distance = props.simulation_distance.clamp(2, 32);
        // Nothing is kept around the spawn while nobody is on.
    // rust: self.streaming.radius = -1;
    // rust: self.settle_spawn()?;
    // rust: let gate_lists = lists.clone();
    // rust: let gate: LoginGate = Arc::new(move |address, uuid, name| {
            // `ServerActivityMonitor.reportLoginActivity`: a login attempt, however it ends. The management
            // protocol's `server/activity` notification is rate limited from these.
    // rust: events::record_server("login_activity", serde_json::json!({}));
    // rust: let user = NameAndId {
    // rust: id: uuid,
    // rust: name: name.to_owned(),
}
    // rust: gate_lists.lock().unwrap().can_login(address, &user)
    // rust: });
    // rust: let bypass_lists = lists.clone();
        // DedicatedServer's constructor: `enable-code-of-conduct` reads the
        // `codeofconduct` folder, and a folder it can't read stops the start.
    // rust: let code_of_conducts = if props.code_of_conduct {
    // rust: horizon_client::lan::code_of_conduct::read(std::path::Path::new("codeofconduct"))?
    // rust: } else {
    // rust: Vec::new()
}
    // rust: let favicon = std::fs::read("server-icon.png")
    // rust: .ok()
    // rust: .filter(|b| png_size(b) == Some((64, 64)));
        // Behind a Velocity proxy: `forwarding.secret` in the server folder, like the proxy's own file.
    // rust: let forwarding_secret = forwarding_secret(online.is_some())?;
        // `[transfer]` on: a player's only way in must be the proxy, or one who joins this server
        // directly finds the older copy of itself that a hand-over left here, and items double.
    // rust: let transfers = self
    // rust: .options
    // rust: .transfers
    // rust: .clone()
    // rust: .map(horizon_client::lan::arrivals::Transfers::new);
    // rust: if transfers.is_some() && forwarding_secret.is_none() {
    // rust: return Err("server.toml's [transfer] is on, but players can join this server without the proxy: \
    // rust: turn on Velocity forwarding (forwarding.secret, docs/velocity-forwarding.md) or turn [transfer] off"
    // rust: .into());
}
    // rust: let net = NetConfig {
    // rust: bind: (!props.server_ip.is_empty())
    // rust: .then(|| props.server_ip.parse().ok())
    // rust: .flatten(),
    // rust: port,
    // rust: motd: props.motd.clone(),
    // rust: max_players: props.max_players.max(0) as usize,
    // rust: compression_threshold: props.network_compression_threshold,
    // rust: rate_limit: props.rate_limit,
    // rust: enable_status: props.enable_status,
    // rust: hide_online_players: props.hide_online_players,
    // rust: favicon,
    // rust: secure_chat: Some(secure_chat),
    // rust: accepts_transfers: props.accepts_transfers,
    // rust: announce: false,
    // rust: listen: true,
    // rust: bypasses_limit: Some(Arc::new(move |uuid| {
    // rust: bypass_lists
    // rust: .lock()
    // rust: .unwrap()
    // rust: .ops
    // rust: .entries()
    // rust: .iter()
    // rust: .any(|e| e.user.id == uuid && e.bypasses_player_limit)
    // rust: })),
    // rust: gate: Some(gate),
    // rust: online,
    // rust: forwarding_secret,
    // rust: arrivals: transfers.as_ref().map(|t| t.expected.clone()),
    // rust: log: Some(NetLog {
    // rust: write: Arc::new(log_from),
    // rust: lang: Arc::new(horizon_client::net::load_language(&self.options.resources)),
    // rust: log_ips: props.log_ips,
    // rust: }),
    // rust: resource_pack: props.resource_pack.clone(),
    // rust: code_of_conducts,
            // DedicatedServer.serverLinks: `bug-report-link` as the only link
            // (ServerLinks.KnownLinkType.BUG_REPORT is id 0).
    // rust: levels: self.level_shapes,
    // rust: horizon_clients_only: props
    // rust: .raw
    // rust: .get(horizon_client::lan::HORIZON_CLIENTS_ONLY)
    // rust: .is_some_and(|v| v.trim().eq_ignore_ascii_case("true")),
    // rust: accept_older_clients: props
    // rust: .raw
    // rust: .get(horizon_client::lan::ACCEPT_OLDER_CLIENTS)
    // rust: .is_some_and(|v| v.trim().eq_ignore_ascii_case("true")),
    // rust: older_clients_play: false,
    // rust: lod_distance: horizon_client::lod_net::distance_property(
    // rust: props.raw.get(horizon_client::lod_net::PROPERTY),
    // rust: ),
    // rust: server_links: if props.bug_report_link.is_empty() {
    // rust: Vec::new()
    // rust: } else if super::server_links::valid_untrusted_uri(&props.bug_report_link) {
    // rust: vec![horizon_protocol::packets::configuration::ServerLink {
    // rust: kind: horizon_protocol::packets::configuration::ServerLinkKind::Known(0),
    // rust: link: props.bug_report_link.clone(),
    // rust: }]
    // rust: } else {
    // rust: log(
    // rust: "WARN",
    // rust: &format!("Failed to parse bug link {}", props.bug_report_link),
    // rust: );
    // rust: Vec::new()
    // rust: },
    // rust: owner_profile: None,
}
    // rust: let config = HubConfig {
    // rust: allow_flight: props.allow_flight,
    // rust: default_game_mode: game_mode,
    // rust: guest_commands: true,
    // rust: force_game_mode: props.force_game_mode,
    // rust: hardcore: self.level.hardcore,
    // rust: view_distance: props.view_distance.clamp(2, 32),
    // rust: simulation_distance: props.simulation_distance.clamp(2, 32),
    // rust: dimension: self.dim.id().to_owned(),
    // rust: levels: self.level_shapes,
    // rust: seed: self.level.seed,
    // rust: max_players: props.max_players.max(0) as usize,
    // rust: integrated: false,
}
    // rust: let settings = LanSettings {
    // rust: port,
    // rust: guest_commands: true,
    // rust: force_game_mode: props.force_game_mode,
}
    // rust: if let Some(sync) = sync {
    // rust: sync.adopt(&self.pack_files());
}
    // rust: if let Err(e) = self.lan_host(settings, net, config) {
    // rust: log("WARN", "**** FAILED TO BIND TO PORT!");
    // rust: log("WARN", &format!("The exception was: {e}"));
    // rust: log("WARN", "Perhaps a server is already running on that port?");
    // rust: return Ok(());
}
    // rust: if let Some(transfers) = transfers
    // rust: && let Some(host) = self.lan.as_mut()
    // rust: {
    // rust: let s = &transfers.settings;
    // rust: log(
    // rust: "INFO",
    // rust: &format!(
    // rust: "Transfers on (server.toml [transfer]): players expected for {} s ({} s at most, {} at once), frozen for {} ticks and held for {} ticks at most",
    // rust: s.expect.as_secs(),
    // rust: s.max_expect.as_secs(),
    // rust: s.max_expected,
    // rust: s.max_freeze_ticks,
    // rust: s.max_hold_ticks
    // rust: ),
    // rust: );
    // rust: host.hub.transfers = Some(transfers);
}
    // rust: self.sync_ops(&lists);
    // rust: let anticheat = load_anticheat();
    // rust: let chat_filter = load_chat_filter();
    // rust: self.settings.extras.pvp.combat.rules = load_combat();
        // Horizon's far ring (docs/hosting.md): server.toml's `max_view_distance`.
    // rust: let far = props
    // rust: .raw
    // rust: .get(FAR_PROPERTY)
    // rust: .and_then(|v| v.trim().parse::<i32>().ok())
    // rust: .unwrap_or(0)
    // rust: .clamp(0, 32);
    // rust: let (registry, biomes) = (self.pack.assets.registry, self.res.biomes().clone());
    // rust: if let Some(host) = self.lan.as_mut() {
    // rust: if far > host.hub.config.view_distance {
    // rust: host.hub.far = Some(horizon_client::lan::far::Far::new(far, registry, biomes));
    // rust: log(
    // rust: "INFO",
    // rust: &format!("Sending saved chunks up to {far} chunks away (max_view_distance)"),
    // rust: );
}
    // rust: host.hub.set_anticheat(anticheat);
    // rust: host.hub.set_chat_filter(chat_filter);
    // rust: host.hub.spawn_protection = props.spawn_protection;
    // rust: host.hub.chat_spam_threshold = props.chat_spam_threshold_seconds.wrapping_mul(20);
    // rust: host.hub.command_spam_threshold = props.command_spam_threshold_seconds.wrapping_mul(20);
            // Off: an operator's commands reach no other player, only the log.
    // rust: host.hub.admin_feedback_to_ops = props
    // rust: .raw
    // rust: .get(ADMIN_FEEDBACK_PROPERTY)
    // rust: .is_none_or(|v| v.trim() != "false");
}
    // rust: log(
    // rust: "INFO",
    // rust: &format!(
    // rust: "Done ({:.3}s)! For help, type \"help\"",
    // rust: started.elapsed().as_secs_f64()
    // rust: ),
    // rust: );
        // DedicatedServer.initServer ends with saveEverything(false, true, true).
    // rust: self.save_game()?;
    // rust: self.log_saved_levels();
    // rust: if let Some(host) = self.lan.as_mut() {
    // rust: host.hub.entity_range_percent = props.entity_broadcast_range_percentage;
}
        // The dedicated server's open is complete before its first tick.
    // rust: self.native_lifecycle_world_ready();
    // rust: let mut state = ServerState {
    // rust: lists,
    // rust: console,
    // rust: empty_ticks: 0,
    // rust: pause_when_empty_seconds: props.pause_when_empty_seconds,
    // rust: ticks: Default::default(),
    // rust: paused: false,
    // rust: broadcast_console: props.broadcast_console_to_ops,
    // rust: broadcast_rcon: props.broadcast_rcon_to_ops,
    // rust: op_level: props.op_permission_level,
    // rust: game_mode: props.game_mode,
    // rust: force_game_mode: props.force_game_mode,
    // rust: report: None,
    // rust: view: (
    // rust: props.view_distance.clamp(2, 32) as u32,
    // rust: props.simulation_distance.clamp(2, 32) as u32,
    // rust: ),
    // rust: max_players: props.max_players.max(0) as usize,
}
    // rust: let mut next = Instant::now();
        // The panic that ended the tick loop, when one did.
    // rust: let mut crashed: Option<String> = None;
    // rust: self.fns.permission = Some(props.function_permission_level.clamp(0, 4) as u8);
    // rust: let watchdog = Watchdog::start(props.max_tick_time);
    // rust: let mut braked = Instant::now();
    // rust: let mut overload_warned: Option<Instant> = None;
        // `/stop`, or a stop signal (the shutdown hook's `halt`): either way the players and levels are
        // saved below.
    // rust: while !state.lists.lock().unwrap().stop && horizon_threads::stop_requests() == 0 {
    // rust: let tick_start = Instant::now();
    // rust: if let Some(watchdog) = &watchdog {
    // rust: watchdog.tick_due(next, self.clock.tick_duration());
}
            // The console's lines and the control socket run in the tick too
            // (`handleConsoleInputs`): a panic there is the same crash.
    // rust: let prelude = std::panic::catch_unwind(std::panic::AssertUnwindSafe(|| {
    // rust: while let Ok(line) = state.console.try_recv() {
    // rust: self.console_line(&mut state, &line);
}
    // rust: self.poll_server_control(&mut state);
    // rust: }));
    // rust: if let Err(payload) = prelude {
    // rust: crashed = Some(panic_message(payload.as_ref()));
    // rust: break;
}
    // rust: let players = self.lan.as_ref().map_or(0, |h| h.hub.guests.len());
            // Vanilla reads pauseWhenEmptySeconds on every tick, so management changes take effect
            // without restarting the server.
    // rust: let pause_after = state.pause_when_empty_seconds.wrapping_mul(20);
    // rust: if pause_after > 0 {
                // A `/pregen` task keeps the server busy as a player would:
                // paused, nothing would post-process its chunks.
    // rust: if players == 0 && self.pregen_level().is_none() {
    // rust: state.empty_ticks += 1;
    // rust: } else {
    // rust: state.empty_ticks = 0;
}
}
    // rust: let paused = pause_after > 0 && state.empty_ticks >= pause_after;
    // rust: state.paused = paused;
    // rust: if paused && state.empty_ticks == pause_after {
    // rust: log(
    // rust: "INFO",
    // rust: &format!(
    // rust: "Server empty for {} seconds, pausing",
    // rust: state.pause_when_empty_seconds
    // rust: ),
    // rust: );
    // rust: self.save_game()?;
}
    // rust: if !paused && !auto_save(&state) {
                // `MinecraftServer.autoSave` keeps its schedule while every level's
                // `noSave` flag is set, but writes nothing. The tick below counts down
                // once, so reset one tick early when this save would have been due.
    // rust: if self.ticks_until_autosave <= 1 {
    // rust: self.ticks_until_autosave = self.next_autosave_interval() + 1;
}
}
            // MinecraftServer.tickServer: while paused only the connections run.
            // `MinecraftServer.runServer` catches what the tick throws, writes the crash
            // report and still stops the server (saves). A panic here does the same.
    // rust: let ticked =
    // rust: std::panic::catch_unwind(std::panic::AssertUnwindSafe(|| {
    // rust: match &mut state.report {
    // rust: Some(recording) => {
    // rust: let sampled = recording.sample_next();
    // rust: super::tick_profile::set_sampling(sampled);
    // rust: let ticked =
    // rust: self.tick_server_spans(paused, |wall, cpu, spans, recorded| {
    // rust: recording.add(wall, cpu, spans, recorded, sampled)
    // rust: });
    // rust: super::tick_profile::set_sampling(false);
    // rust: ticked
}
    // rust: None => self.tick_server_timed(paused),
}
    // rust: }));
    // rust: match ticked {
    // rust: Ok(result) => result?,
    // rust: Err(payload) => {
    // rust: crashed = Some(panic_message(payload.as_ref()));
    // rust: break;
}
}
    // rust: if state.report.as_ref().is_some_and(report::Recording::done)
    // rust: && let Some(recording) = state.report.take()
    // rust: {
    // rust: self.finish_report(recording, state.view, state.max_players);
}
    // rust: if horizon_client::spans::trace::due()
    // rust: && let Some(events) = horizon_client::spans::trace::stop()
    // rust: {
    // rust: log(
    // rust: "INFO",
    // rust: &format!("Trace written: {events} events (reports/)"),
    // rust: );
}
            // DedicatedServer.sendLowDiskSpaceWarning: the operators hear of it
            // (no window drains the toasts here).
    // rust: if horizon_client::chunk_io::take().low_disk_space
    // rust: && let Some(host) = self.lan.as_ref()
    // rust: {
    // rust: host.hub.send_low_disk_space_warning();
}
            // `PlayerList.tick` reads `MinecraftServer.playerIdleTimeout`
            // every tick, so `/setidletimeout` changes it while the server runs.
    // rust: let idle_timeout = state.lists.lock().unwrap().player_idle_timeout;
    // rust: if idle_timeout > 0 {
    // rust: self.kick_idle(idle_timeout);
}
            // MinecraftServer.tickServer records each tick's time, for /tick query (and the status).
    // rust: self.clock.record(tick_start.elapsed());
            // The far ring's brake, once a second on the average tick.
    // rust: if braked.elapsed() >= Duration::from_secs(1)
    // rust: && let Some(host) = self.lan.as_mut()
    // rust: && let Some(far) = host.hub.far.as_mut()
    // rust: {
    // rust: braked = Instant::now();
    // rust: let mspt = self.clock.average_nanos() as f64 / 1e6;
    // rust: far.brake(mspt, host.hub.config.view_distance);
}
    // rust: state.ticked(Instant::now());
            // MinecraftServer.runServer: a server more than a second's ticks
            // behind skips them and says so, at most every 15 seconds.
    // rust: if let Some(behind) = self.wait_for_next_server_tick(&mut next, paused)
    // rust: && overload_warned.is_none_or(|at| at.elapsed() >= OVERLOAD_WARNING_INTERVAL)
    // rust: {
    // rust: overload_warned = Some(Instant::now());
    // rust: log(
    // rust: "WARN",
    // rust: &overload_warning(behind, self.clock.tick_duration()),
    // rust: );
}
}
    // rust: if let Some(watchdog) = &watchdog {
    // rust: watchdog.running.store(false, Ordering::Relaxed);
}
    // rust: match crashed {
    // rust: Some(message) => self.stop_after_crash(&message),
    // rust: None => self.stop_dedicated(),
}
}

    // A dedicated server of its own, not single player's server thread
    // (which runs with `options.dedicated` too).
    // rust: pub(super) fn standalone_server(&self) -> bool {
    // rust: self.options.dedicated.is_some() && self.serving.is_none()
}
    // Load the spawn area and find the world spawn as single player does,
    // without keeping a player there. A dedicated server only finds the world
    // spawn (MinecraftServer.setInitialSpawn): a player's spawn is found as
    // one joins.
    // rust: pub(super) fn settle_spawn(&mut self) -> Result<()> {
    // rust: let deadline = Instant::now() + Duration::from_secs(600);
    // rust: if self.standalone_server() {
    // rust: if self.level.spawn.is_none() {
    // rust: let [x, y, z] = loop {
    // rust: self.update_world();
    // rust: if let Some(pos) = self.find_world_spawn()? {
    // rust: break pos;
}
    // rust: if Instant::now() > deadline {
    // rust: return Err("the spawn area did not load".into());
}
    // rust: std::thread::sleep(Duration::from_millis(2));
}
    // rust: self.level.spawn = Some([f64::from(x), f64::from(y), f64::from(z)]);
    // rust: self.level.world_spawn.get_or_insert([x, y, z]);
    // rust: self.streaming.extra.clear();
}
    // rust: self.spawn = self
    // rust: .level
    // rust: .spawn
    // rust: .map(|s| horizon_core::geometry::Vec3::new(s[0] + 0.5, s[1], s[2] + 0.5));
    // rust: return Ok(());
}
    // rust: while self.player.is_none() {
    // rust: self.update_world();
    // rust: self.spawn_player()?;
    // rust: if Instant::now() > deadline {
    // rust: return Err("the spawn area did not load".into());
}
    // rust: std::thread::sleep(Duration::from_millis(2));
}
    // rust: self.player = None;
    // rust: Ok(())
}

    // The chunks to keep loaded: the players' (lan_update_streaming). While
    // nobody is online a dedicated server keeps none (vanilla has no spawn
    // ticket), an integrated one the spawn chunk's.
    // rust: pub(super) fn update_dedicated_streaming(&mut self) {
    // rust: let rule = self.ui.rules.bool("spectators_generate_chunks");
    // rust: let guest = self.lan.as_ref().and_then(|h| {
            // A held player (arriving from another server) is sent the level too, so it
            // holds the world loaded around it as a placed player does.
    // rust: h.hub
    // rust: .loading_chunks(|g| super::game_mode::loads_chunks(rule, g.spectator()))
    // rust: .first()
    // rust: .copied()
    // rust: });
    // rust: if self.standalone_server() {
    // rust: self.streaming.radius = if guest.is_some() {
    // rust: self.settings.render_distance
    // rust: } else {
    // rust: -1
}
}
    // rust: let spawn = self
    // rust: .spawn
    // rust: .map(|s| ((s.x.floor() as i32) >> 4, (s.z.floor() as i32) >> 4));
    // rust: if let Some(c) = guest.or(spawn) {
    // rust: self.streaming.center = c;
}
}

    // ServerGamePacketListenerImpl.tick: players idle longer than the
    // timeout are kicked.
kick_idle :: proc(self: ^Self, minutes: i32) {
}
    // rust: let Some(host) = self.lan.as_mut() else {
    // rust: return;
}
    // rust: let limit = u64::try_from(minutes).unwrap_or(0) * 1200;
    // rust: let idle: Vec<u32> = host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| host.hub.ticks.saturating_sub(g.last_action_tick) > limit)
    // rust: .map(|g| g.conn)
    // rust: .collect();
    // rust: for conn in idle {
    // rust: host.hub
    // rust: .kick(conn, translatable("multiplayer.disconnect.idling", &[]));
}
}

    // Ops' permission levels for the hub (PlayerList.getProfilePermissions).
    // rust: pub(super) fn sync_ops(&mut self, lists: &Arc<Mutex<Lists>>) {
    // rust: let Some(host) = self.lan.as_mut() else {
    // rust: return;
}
    // rust: host.hub.ops = lists
    // rust: .lock()
    // rust: .unwrap()
    // rust: .ops
    // rust: .entries()
    // rust: .iter()
    // rust: .map(|e| (e.user.id, e.level as u8))
    // rust: .collect();
    // rust: self.resend_commands_filtered();
}

    // A player on the server, by name.
    // rust: pub(super) fn online_player(&self, name: &str) -> Option<NameAndId> {
    // rust: let hub = &self.lan.as_ref()?.hub;
    // rust: let g = hub
    // rust: .guests
    // rust: .iter()
    // rust: .find(|g| g.name.eq_ignore_ascii_case(name))?;
    // rust: Some(NameAndId {
    // rust: id: g.uuid,
    // rust: name: g.name.clone(),
    // rust: })
}

    // GameProfileArgument for a name: the user cache, else the profile
    // service, else (offline) the offline player. None, told to the console:
    // no such player.
resolve :: proc(self: ^Self, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let found = self.resolve_name(name);
    // rust: if found.is_none() {
    // rust: let unknown = Text::translate("argument.player.unknown", &[]);
    // rust: log("INFO", &format!("System chat: {}", unknown.plain()));
}
    // rust: found
}

    // `Services.nameToIdCache().get(name)`: the user cache, else the profile
    // service, else (offline) the offline player.
    // rust: pub(super) fn resolve_name(&self, name: &str) -> Option<NameAndId> {
    // rust: USER_CACHE.lock().unwrap().as_mut().and_then(|cache| {
    // rust: cache.get_by_name(name, |lower| {
    // rust: let found = profiles::find_by_name(&profiles::discovery_url(), lower);
    // rust: if found.is_none() {
    // rust: log("WARN", &format!("Couldn't find profile with name: {lower}"));
}
    // rust: found
    // rust: })
    // rust: })
}

    // MinecraftServer.sendSystemMessage: what the console is told; while
    // the console runs a command, the replies vanilla broadcasts go to the
    // operators too.
console_reply :: proc(self: ^Self, text: Text) {
}
    // rust: log("INFO", &format!("System chat: {}", text.plain()));
    // rust: if self.console_broadcast.is_some()
    // rust: && text
    // rust: .translation_key()
    // rust: .is_some_and(|k| BROADCAST.contains(&k))
    // rust: {
    // rust: self.broadcast_to_admins(text);
}
}

    // One console line, then the operators' share of its feedback.
console_line :: proc(self: ^Self, state: ^ServerState, line: string) {
}
    // rust: self.console_line_telling(state, line, state.broadcast_console);
}

    // One console line run as `RconConsoleSource` runs an RCON command: the same console at level 4,
    // its source named `Rcon`, and the operators told when `broadcast-rcon-to-ops` is on.
rcon_line :: proc(self: ^Self, state: ^ServerState, line: string) {
}
    // rust: self.rcon_source = true;
    // rust: self.console_line_telling(state, line, state.broadcast_rcon);
    // rust: self.rcon_source = false;
}

    // `console_line` with `inform` as `CommandSource.shouldInformAdmins`.
console_line_telling :: proc(self: ^Self, state: ^ServerState, line: string, inform: bool) {
}
    // rust: self.console_broadcast = Some(inform);
    // rust: self.console_command(state, line);
    // rust: self.console_broadcast = None;
    // rust: if let Some(mut host) = self.lan.take() {
    // rust: crash_fixture("hub", || host.hub.guests.iter().any(|g| g.placed));
    // rust: self.run_level_teleports(&mut host);
    // rust: self.send_admin_feedback(&mut host, None);
    // rust: self.lan = Some(host);
}
    // rust: self.admin_feedback.clear();
}

    // `MinecraftServer.createCommandSourceStack`: the console's source is
    // bound to the overworld, whichever level the last server tick left in
    // place (the last one ticked, often the nether). Its commands run there
    // and the level in place is put back afterwards.
    // rust: fn as_console_in_overworld<T>(&mut self, f: impl FnOnce(&mut Self) -> T) -> T {
    // rust: let back = console_level(self.dim).and_then(|dim| self.enter_command_level(dim));
    // rust: let out = self.as_console(f);
    // rust: if let Some(back) = back {
    // rust: self.enter_command_level(back);
}
    // rust: out
}

    // DedicatedServer.handleConsoleInputs: one console line, run as the
    // server (permission level 4). The dedicated-only commands are here;
    // everything else goes to the game's dispatcher.
console_command :: proc(self: ^Self, state: ^ServerState, line: string) {
}
    // rust: let line = line.strip_prefix('/').unwrap_or(line);
    // rust: let mut words = line.split_whitespace();
    // rust: let Some(command) = words.next() else {
    // rust: return;
}
    // rust: let rest: Vec<&str> = words.collect();
    // rust: let lit = |s: &str| Text::literal(s.to_owned());
    // rust: match command {
    // rust: "stop" => {
    // rust: self.console_reply(Text::translate("commands.stop.stopping", &[]));
    // rust: state.lists.lock().unwrap().stop = true;
}
            // Horizon's own, on the console only: a performance report (report.rs).
    // rust: "horizon-report" if rest.first() == Some(&"stop") => match state.report.take() {
    // rust: Some(recording) => {
    // rust: log("INFO", "Stopping the performance report: writing it now");
    // rust: self.finish_report(recording, state.view, state.max_players);
}
    // rust: None => log("INFO", "No performance report is being recorded"),
    // rust: },
    // rust: "horizon-report" if rest.first() == Some(&"status") => match &state.report {
    // rust: Some(recording) => log("INFO", &recording.status()),
    // rust: None => log("INFO", "No performance report is being recorded"),
    // rust: },
    // rust: "horizon-report" => {
    // rust: let seconds = match rest.first().map(|s| s.parse::<u32>()) {
    // rust: None => Ok(60),
    // rust: Some(Ok(s)) if (1..=report::MAX_SECONDS).contains(&s) => Ok(s),
    // rust: Some(_) => Err(()),
}
    // rust: match (seconds, &state.report) {
    // rust: (Err(()), _) => log(
    // rust: "INFO",
    // rust: &format!(
    // rust: "horizon-report [SECONDS | stop | status]: 1 to {} seconds, 60 by default",
    // rust: report::MAX_SECONDS
    // rust: ),
    // rust: ),
    // rust: (Ok(_), Some(_)) => {
    // rust: log("INFO", "A performance report is already being recorded")
}
    // rust: (Ok(seconds), None) => {
    // rust: state.report = Some(report::Recording::start(seconds, self.wire_bytes()));
    // rust: log(
    // rust: "INFO",
    // rust: &format!("Recording a performance report for {seconds} s (reports/)"),
    // rust: );
}
}
}
            // Horizon's own, on the console only: every thread's spans as a timeline (report.rs).
    // rust: "horizon-trace" if rest.first() == Some(&"stop") => {
    // rust: match horizon_client::spans::trace::stop() {
    // rust: Some(events) => log("INFO", &format!("Trace stopped: {events} events written")),
    // rust: None => log("INFO", "No trace is being written"),
}
}
    // rust: "horizon-trace" => {
    // rust: let seconds = match rest.first().map(|s| s.parse::<u32>()) {
    // rust: None => Some(30),
    // rust: Some(Ok(s)) if (1..=report::TRACE_MAX_SECONDS).contains(&s) => Some(s),
    // rust: Some(_) => None,
}
    // rust: match seconds.map(report::start_trace) {
    // rust: None => log(
    // rust: "INFO",
    // rust: &format!(
    // rust: "horizon-trace [SECONDS | stop]: 1 to {} seconds, 30 by default",
    // rust: report::TRACE_MAX_SECONDS
    // rust: ),
    // rust: ),
    // rust: Some(Ok(path)) => log(
    // rust: "INFO",
    // rust: &format!(
    // rust: "Writing a trace for {} s to {} (open it in ui.perfetto.dev)",
    // rust: seconds.unwrap_or_default(),
    // rust: path.display()
    // rust: ),
    // rust: ),
    // rust: Some(Err(e)) => log("ERROR", &format!("Could not start a trace: {e}")),
}
}
    // rust: "save-all" => {
    // rust: self.console_reply(Text::translate("commands.save.saving", &[]));
    // rust: let saved = self.save_game();
    // rust: if let Err(e) = &saved {
                    // The reason the save did not go through is Horizon's own
                    // detail, so it stays in the log; the source hears what
                    // SaveAllCommand tells it (ERROR_FAILED).
    // rust: log("ERROR", &format!("{e}"));
}
    // rust: self.console_reply(save_all_reply(saved.is_ok()));
}
    // rust: "save-off" => {
    // rust: if set_auto_save(&state.lists, false) {
    // rust: self.console_reply(Text::translate("commands.save.disabled", &[]));
    // rust: } else {
    // rust: self.console_reply(Text::translate("commands.save.alreadyOff", &[]));
}
}
    // rust: "save-on" => {
    // rust: if set_auto_save(&state.lists, true) {
    // rust: self.console_reply(Text::translate("commands.save.enabled", &[]));
    // rust: } else {
    // rust: self.console_reply(Text::translate("commands.save.alreadyOn", &[]));
}
}
    // rust: "list" => {
    // rust: let guests: Vec<(String, u128)> = self
    // rust: .lan
    // rust: .as_ref()
    // rust: .map(|h| {
    // rust: h.hub
    // rust: .guests
    // rust: .iter()
    // rust: .map(|g| (g.name.clone(), g.uuid))
    // rust: .collect()
    // rust: })
    // rust: .unwrap_or_default();
    // rust: let max = self
    // rust: .lan
    // rust: .as_ref()
    // rust: .map_or(0, |h| h.hub.lan.shared.max_players());
    // rust: let names: Vec<String> = if rest.first() == Some(&"uuids") {
    // rust: guests
    // rust: .iter()
    // rust: .map(|(n, u)| {
    // rust: format!("{n} ({})", horizon_protocol::crypto::uuid_string(*u))
    // rust: })
    // rust: .collect()
    // rust: } else {
    // rust: guests.iter().map(|(n, _)| n.clone()).collect()
}
    // rust: self.console_reply(Text::translate(
    // rust: "commands.list.players",
    // rust: &[
    // rust: lit(&guests.len().to_string()),
    // rust: lit(&max.to_string()),
    // rust: lit(&names.join(", ")),
    // rust: ],
    // rust: ));
}
    // rust: "op" | "deop" if !rest.is_empty() => {
    // rust: let Some(user) = self.resolve(rest[0]) else {
    // rust: return;
}
    // rust: let level = state.op_level;
    // rust: let changed = {
    // rust: let mut l = state.lists.lock().unwrap();
    // rust: if command == "op" {
    // rust: if l.ops.contains(&user) {
    // rust: false
    // rust: } else {
    // rust: l.ops.add(OpEntry {
    // rust: user: user.clone(),
    // rust: level,
    // rust: bypasses_player_limit: false,
    // rust: })
}
    // rust: } else {
    // rust: l.ops.remove(&user)
}
}
    // rust: let key = match (command, changed) {
    // rust: ("op", true) => "commands.op.success",
    // rust: ("op", false) => "commands.op.failed",
    // rust: (_, true) => "commands.deop.success",
    // rust: _ => "commands.deop.failed",
}
    // rust: self.console_reply(Text::translate(key, &[lit(&user.name)]));
    // rust: let lists = state.lists.clone();
    // rust: self.sync_ops(&lists);
                // DeOpCommands.deopPlayers.
    // rust: if command == "deop" && changed {
    // rust: self.kick_unlisted_players(&lists);
}
}
    // rust: "whitelist" => self.console_whitelist(state, &rest),
            // The chat filter's (game/chat_filter.rs), on servers that filter.
    // rust: command
    // rust: if super::chat_filter::MUTE_COMMANDS.contains(&command)
    // rust: && self.lan.as_ref().is_some_and(|h| h.hub.chat_filter_on()) =>
    // rust: {
    // rust: if let Some(mut host) = self.lan.take() {
    // rust: let words: Vec<&str> = [command].into_iter().chain(rest).collect();
    // rust: let replies = self.mute_command(&mut host, &words, "Server");
    // rust: self.lan = Some(host);
    // rust: for reply in replies {
    // rust: self.console_reply(reply.text());
}
}
}
            // Horizon's temporary ban (game/tempban.rs), as an operator's `/tempban`.
    // rust: command if super::tempban::TEMPBAN_COMMANDS.contains(&command) => {
    // rust: if let Some(mut host) = self.lan.take() {
    // rust: let words: Vec<&str> = [command].into_iter().chain(rest).collect();
    // rust: let replies = self.tempban_command(&mut host, &words, "Server");
    // rust: self.lan = Some(host);
    // rust: for reply in replies {
    // rust: self.console_reply(reply.text());
}
}
}
    // rust: "ban" if !rest.is_empty() => {
    // rust: let Some(user) = self.resolve(rest[0]) else {
    // rust: return;
}
    // rust: let reason = (rest.len() > 1).then(|| rest[1..].join(" "));
    // rust: let added = state.lists.lock().unwrap().bans.add(BanEntry::new(
    // rust: user.clone(),
    // rust: Some("Server".into()),
    // rust: None,
    // rust: reason.clone(),
    // rust: ));
    // rust: if added {
    // rust: self.console_reply(Text::translate(
    // rust: "commands.ban.success",
    // rust: &[
    // rust: lit(&user.name),
    // rust: reason.as_deref().map_or_else(
    // rust: || {
    // rust: Text::translate(
    // rust: "multiplayer.disconnect.banned.reason.default",
    // rust: &[],
    // rust: )
    // rust: },
    // rust: lit,
    // rust: ),
    // rust: ],
    // rust: ));
    // rust: self.kick_uuid(user.id, translatable("multiplayer.disconnect.banned", &[]));
    // rust: } else {
    // rust: self.console_reply(Text::translate("commands.ban.failed", &[]));
}
}
    // rust: "ban-ip" if !rest.is_empty() => {
    // rust: let target = rest[0];
    // rust: let ip = if target.parse::<std::net::IpAddr>().is_ok() {
    // rust: Some(target.to_owned())
    // rust: } else {
    // rust: self.lan.as_ref().and_then(|h| {
    // rust: h.hub
    // rust: .guests
    // rust: .iter()
    // rust: .find(|g| g.name.eq_ignore_ascii_case(target))
    // rust: .map(|g| g.address.ip().to_string())
    // rust: })
}
    // rust: let Some(ip) = ip else {
    // rust: self.console_reply(Text::translate("commands.banip.invalid", &[]));
    // rust: return;
}
    // rust: let reason = (rest.len() > 1).then(|| rest[1..].join(" "));
    // rust: let added = state.lists.lock().unwrap().ip_bans.add(BanEntry::new(
    // rust: ip.clone(),
    // rust: Some("Server".into()),
    // rust: None,
    // rust: reason.clone(),
    // rust: ));
    // rust: if !added {
    // rust: self.console_reply(Text::translate("commands.banip.failed", &[]));
    // rust: return;
}
    // rust: self.console_reply(Text::translate(
    // rust: "commands.banip.success",
    // rust: &[
    // rust: lit(&ip),
    // rust: reason.as_deref().map_or_else(
    // rust: || Text::translate("multiplayer.disconnect.banned.reason.default", &[]),
    // rust: lit,
    // rust: ),
    // rust: ],
    // rust: ));
    // rust: let banned: Vec<(u128, String)> = self
    // rust: .lan
    // rust: .as_ref()
    // rust: .map(|h| {
    // rust: h.hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| g.address.ip().to_string() == ip)
    // rust: .map(|g| (g.uuid, g.name.clone()))
    // rust: .collect()
    // rust: })
    // rust: .unwrap_or_default();
    // rust: let names: Vec<&str> = banned.iter().map(|(_, n)| n.as_str()).collect();
    // rust: if let Some(info) = ban_ip_info(&names) {
    // rust: self.console_reply(info);
}
    // rust: for (uuid, _) in banned {
    // rust: self.kick_uuid(uuid, translatable("multiplayer.disconnect.ip_banned", &[]));
}
}
    // rust: "pardon" if !rest.is_empty() => {
    // rust: let Some(user) = self.resolve(rest[0]) else {
    // rust: return;
}
    // rust: let removed = state.lists.lock().unwrap().bans.remove(&user);
    // rust: let key = if removed {
    // rust: "commands.pardon.success"
    // rust: } else {
    // rust: "commands.pardon.failed"
}
    // rust: self.console_reply(Text::translate(key, &[lit(&user.name)]));
}
    // rust: "pardon-ip" if !rest.is_empty() => {
    // rust: let ip = rest[0].to_owned();
    // rust: if ip.parse::<std::net::IpAddr>().is_err() {
    // rust: self.console_reply(Text::translate("commands.pardonip.invalid", &[]));
    // rust: return;
}
    // rust: let removed = state.lists.lock().unwrap().ip_bans.remove(&ip);
    // rust: let key = if removed {
    // rust: "commands.pardonip.success"
    // rust: } else {
    // rust: "commands.pardonip.failed"
}
    // rust: self.console_reply(Text::translate(key, &[lit(&ip)]));
}
    // rust: "banlist" => {
    // rust: let l = state.lists.lock().unwrap();
    // rust: let mut lines = Vec::new();
    // rust: let which = rest.first().copied().unwrap_or("");
    // rust: if which != "ips" {
    // rust: for b in l.bans.entries() {
    // rust: lines.push((b.user.name.clone(), b.source.clone(), b.reason.clone()));
}
}
    // rust: if which != "players" {
    // rust: for b in l.ip_bans.entries() {
    // rust: lines.push((b.user.clone(), b.source.clone(), b.reason.clone()));
}
}
    // rust: drop(l);
    // rust: if lines.is_empty() {
    // rust: self.console_reply(Text::translate("commands.banlist.none", &[]));
    // rust: } else {
    // rust: self.console_reply(Text::translate(
    // rust: "commands.banlist.list",
    // rust: &[lit(&lines.len().to_string())],
    // rust: ));
    // rust: for (name, source, reason) in lines {
    // rust: self.console_reply(Text::translate(
    // rust: "commands.banlist.entry",
    // rust: &[
    // rust: lit(&name),
    // rust: lit(&source),
    // rust: reason.as_deref().map_or_else(
    // rust: || {
    // rust: Text::translate(
    // rust: "multiplayer.disconnect.banned.reason.default",
    // rust: &[],
    // rust: )
    // rust: },
    // rust: lit,
    // rust: ),
    // rust: ],
    // rust: ));
}
}
}
    // rust: "kick" if !rest.is_empty() => {
    // rust: let Some(user) = self.online_player(rest[0]) else {
    // rust: self.console_reply(Text::translate("argument.entity.notfound.player", &[]));
    // rust: return;
}
    // rust: let reason = if rest.len() > 1 {
    // rust: Tag::String(JavaString::from(rest[1..].join(" ").as_str()))
    // rust: } else {
    // rust: translatable("multiplayer.disconnect.kicked", &[])
}
    // rust: self.kick_uuid(user.id, reason);
    // rust: self.console_reply(Text::translate(
    // rust: "commands.kick.success",
    // rust: &[
    // rust: lit(&user.name),
    // rust: if rest.len() > 1 {
    // rust: lit(&rest[1..].join(" "))
    // rust: } else {
    // rust: Text::translate("multiplayer.disconnect.kicked", &[])
    // rust: },
    // rust: ],
    // rust: ));
}
    // rust: "say" if !rest.is_empty() => {
                // SayCommand from the console: an unsigned system chat
                // message of type say_command, logged as not secure.
    // rust: let message = rest.join(" ");
                // An RCON client's `say` is `[Rcon] message`, and its reply stays empty: the line is
                // the console's own log, not a message to the source.
    // rust: let name = if self.rcon_source { "Rcon" } else { "Server" };
    // rust: let held = self.rcon_source.then(|| CAPTURE.take());
    // rust: log("INFO", &format!("[Not Secure] [{name}] {message}"));
    // rust: if let Some(held) = held {
    // rust: CAPTURE.set(held);
}
    // rust: if let Some(h) = &self.lan {
    // rust: h.hub.say(name, &message);
}
}
    // rust: _ => {
                // The game's dispatcher, captured for the console.
    // rust: self.chat_capture = Some(Vec::new());
                // A command a native mod registered goes to the mods first,
                // looked up by the same first word the match above read.
    // rust: if !self.perform_native_console_command(line.trim()) {
    // rust: self.as_console_in_overworld(|g| g.run_command(line));
}
    // rust: for text in self.chat_capture.take().unwrap_or_default() {
    // rust: self.console_reply(text);
}
                // ServerPlayer.onEffectAdded and onEffectUpdated send an effect
                // the command gave as it was given: vanilla's console runs after
                // the players' tick (`DedicatedServer.tickConnection`), so the
                // next tick is the first to count it down. A player's own
                // commands sync theirs the same way (`run_guest_command`).
    // rust: if let Some(h) = self.lan.as_mut() {
    // rust: h.hub.sync_all_effects();
}
}
}
}

console_whitelist :: proc(self: ^Self, state: ^ServerState, rest: ^[string]) {
}
    // rust: let lit = |s: &str| Text::literal(s.to_owned());
    // rust: match rest {
    // rust: ["on"] | ["off"] => {
    // rust: let on = rest[0] == "on";
    // rust: let l = state.lists.lock().unwrap();
    // rust: let turned_on = on && !l.use_whitelist;
    // rust: let key = match (on, l.use_whitelist) {
    // rust: (true, true) => "commands.whitelist.alreadyOn",
    // rust: (true, false) => "commands.whitelist.enabled",
    // rust: (false, false) => "commands.whitelist.alreadyOff",
    // rust: (false, true) => "commands.whitelist.disabled",
}
    // rust: drop(l);
    // rust: self.set_using_whitelist(&state.lists, on);
    // rust: self.console_reply(Text::translate(key, &[]));
    // rust: if turned_on {
    // rust: let lists = state.lists.clone();
    // rust: self.kick_unlisted_players(&lists);
}
}
    // rust: ["list"] => {
    // rust: let names: Vec<String> = state
    // rust: .lists
    // rust: .lock()
    // rust: .unwrap()
    // rust: .white
    // rust: .entries()
    // rust: .iter()
    // rust: .map(|e| e.user.name.clone())
    // rust: .collect();
    // rust: if names.is_empty() {
    // rust: self.console_reply(Text::translate("commands.whitelist.none", &[]));
    // rust: } else {
    // rust: self.console_reply(Text::translate(
    // rust: "commands.whitelist.list",
    // rust: &[lit(&names.len().to_string()), lit(&names.join(", "))],
    // rust: ));
}
}
    // rust: ["reload"] => {
    // rust: let _ = state.lists.lock().unwrap().white.load();
    // rust: self.console_reply(Text::translate("commands.whitelist.reloaded", &[]));
    // rust: let lists = state.lists.clone();
    // rust: self.kick_unlisted_players(&lists);
}
    // rust: ["add", name] | ["remove", name] => {
    // rust: let Some(user) = self.resolve(name) else {
    // rust: return;
}
    // rust: let mut l = state.lists.lock().unwrap();
    // rust: let (ok, key) = if rest[0] == "add" {
    // rust: if l.white.contains(&user) {
    // rust: (false, "commands.whitelist.add.failed")
    // rust: } else {
    // rust: l.white.add(WhiteEntry { user: user.clone() });
    // rust: (true, "commands.whitelist.add.success")
}
    // rust: } else if l.white.remove(&user) {
    // rust: (true, "commands.whitelist.remove.success")
    // rust: } else {
    // rust: (false, "commands.whitelist.remove.failed")
}
    // rust: drop(l);
    // rust: let args = if ok {
    // rust: vec![lit(&user.name)]
    // rust: } else {
    // rust: Vec::new()
}
    // rust: self.console_reply(Text::translate(key, &args));
    // rust: if ok && rest[0] == "remove" {
    // rust: let lists = state.lists.clone();
    // rust: self.kick_unlisted_players(&lists);
}
}
    // rust: _ => self.console_reply(Text::translate("command.unknown.argument", &[])),
}
}

    // `DedicatedServer.setUsingWhitelist`: the flag, and `white-list` in
    // server.properties.
    // rust: pub(super) fn set_using_whitelist(&mut self, lists: &Arc<Mutex<Lists>>, on: bool) {
    // rust: let changed = {
    // rust: let mut lists = lists.lock().unwrap();
    // rust: let changed = lists.use_whitelist != on;
    // rust: lists.use_whitelist = on;
    // rust: changed
}
    // rust: self.store_property("white-list", on.to_string());
    // rust: if changed {
    // rust: self.native_whitelist_state_update(on);
}
}

    // `DedicatedServer.setPlayerIdleTimeout`: update the live idle sweep and persist its minutes.
    // rust: pub(super) fn set_player_idle_timeout(&mut self, lists: &Arc<Mutex<Lists>>, minutes: i32) {
    // rust: lists.lock().unwrap().player_idle_timeout = minutes;
    // rust: self.store_property("player-idle-timeout", minutes.to_string());
}

    // `DedicatedServer.setMaxPlayers`: the live login limit, and `max-players` in
    // server.properties.
set_max_players :: proc(self: ^Self, state: ^ServerState, max_players: uint) {
}
    // rust: state.max_players = max_players;
    // rust: if let Some(lan) = &self.lan {
    // rust: lan.hub.lan.shared.set_max_players(max_players);
}
    // rust: self.store_property("max-players", max_players.to_string());
}

    // `DedicatedServer.setAcceptsTransfers`: whether a transfer's handshake is accepted from
    // now on, and `accepts-transfers` in server.properties.
set_accepts_transfers :: proc(self: ^Self, accept: bool) {
}
    // rust: if let Some(lan) = &self.lan {
    // rust: lan.hub.lan.shared.set_accepts_transfers(accept);
}
    // rust: self.store_property("accepts-transfers", accept.to_string());
}

    // `DedicatedServer.setEnforceWhitelist`: the flag, and `enforce-whitelist` in
    // server.properties.
    // rust: pub(super) fn set_enforce_whitelist(&mut self, lists: &Arc<Mutex<Lists>>, on: bool) {
    // rust: lists.lock().unwrap().enforce_whitelist = on;
    // rust: self.store_property("enforce-whitelist", on.to_string());
}

    // `DedicatedServer.setPauseWhenEmptySeconds`: the live pause timer, and
    // `pause-when-empty-seconds` in server.properties.
set_pause_when_empty_seconds :: proc(self: ^Self, state: ^ServerState, seconds: i32) {
}
    // rust: state.pause_when_empty_seconds = seconds;
    // rust: self.store_property("pause-when-empty-seconds", seconds.to_string());
}

    // DedicatedServerSettings.update: change one key and store the file.
    // rust: pub(super) fn store_property(&mut self, key: &str, value: String) {
    // rust: let path = PathBuf::from("server.properties");
    // rust: if let Ok(p) = ServerProperties::from_file(&path, &mut SystemEntropy::default())
    // rust: && let Ok(p) = p.update(key, value)
    // rust: {
    // rust: let _ = p.store(&path);
}
}

    // MinecraftServer.kickUnlistedPlayers: with `enforce-whitelist` and the
    // whitelist on, whoever is online and not on the whitelist file is
    // disconnected (operators are not spared here).
    // rust: pub(super) fn kick_unlisted_players(&mut self, lists: &Arc<Mutex<Lists>>) {
    // rust: let unlisted: Vec<u128> = {
    // rust: let l = lists.lock().unwrap();
    // rust: let Some(host) = self.lan.as_ref() else {
    // rust: return;
}
    // rust: if !(l.enforce_whitelist && l.use_whitelist) {
    // rust: return;
}
    // rust: host.hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| {
    // rust: !l.white.contains(&NameAndId {
    // rust: id: g.uuid,
    // rust: name: g.name.clone(),
    // rust: })
    // rust: })
    // rust: .map(|g| g.uuid)
    // rust: .collect()
}
    // rust: for uuid in unlisted {
    // rust: self.kick_uuid(
    // rust: uuid,
    // rust: translatable("multiplayer.disconnect.not_whitelisted", &[]),
    // rust: );
}
}

    // The anticheat bans a player (`HostEvent::Ban`): `banned-players.json` gets it as `/ban` adds it,
    // with the anticheat as its source, and the player is sent away with the ban's message.
    // rust: pub(super) fn anticheat_ban(
    // rust: &mut self,
    // rust: hub: &mut horizon_client::lan::hub::Hub,
    // rust: uuid: u128,
    // rust: name: &str,
    // rust: reason: &str,
    // rust: ) {
    // rust: let Some(lists) = &self.server_lists else {
            // No ban list to add to: the anticheat's kick, so a flagged cheater still doesn't stay.
    // rust: log(
    // rust: "WARN",
    // rust: &format!("Can't ban {name} ({reason}): no ban list; kicked"),
    // rust: );
    // rust: let conns: Vec<u32> = hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| g.uuid == uuid)
    // rust: .map(|g| g.conn)
    // rust: .collect();
    // rust: for conn in conns {
    // rust: hub.anticheat_kick(conn);
}
    // rust: return;
}
    // rust: let user = NameAndId {
    // rust: id: uuid,
    // rust: name: name.to_owned(),
}
    // rust: lists.lock().unwrap().bans.add(BanEntry::new(
    // rust: user,
    // rust: Some("Horizon anticheat".into()),
    // rust: None,
    // rust: Some(reason.to_owned()),
    // rust: ));
    // rust: log("INFO", &format!("Banned {name}: {reason}"));
    // rust: let conns: Vec<u32> = hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| g.uuid == uuid)
    // rust: .map(|g| g.conn)
    // rust: .collect();
    // rust: for conn in conns {
    // rust: hub.kick(conn, translatable("multiplayer.disconnect.banned", &[]));
}
    // rust: events::record("ban", name, uuid, serde_json::json!({ "reason": reason }));
}

    // rust: pub(super) fn kick_uuid(&mut self, uuid: u128, reason: Tag) {
    // rust: if let Some(h) = self.lan.as_mut() {
    // rust: let conns: Vec<u32> = h
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| g.uuid == uuid)
    // rust: .map(|g| g.conn)
    // rust: .collect();
    // rust: for conn in conns {
    // rust: h.hub.kick(conn, reason.clone());
    // rust: if let Some(g) = h.hub.guest(conn) {
    // rust: events::record(
    // rust: "kick",
    // rust: &g.name,
    // rust: uuid,
    // rust: serde_json::json!({ "reason": g.left_reason }),
    // rust: );
}
}
}
}

    // MinecraftServer.stopServer: players saved and sent away, worlds saved.
    // MinecraftServer.saveAllChunks, not silent: one line per level, in
    // the server's level order.
log_saved_levels :: proc(self: ^Self) {
}
    // rust: for dimension in [
    // rust: "minecraft:overworld",
    // rust: "minecraft:the_nether",
    // rust: "minecraft:the_end",
    // rust: ] {
    // rust: log(
    // rust: "INFO",
    // rust: &format!(
    // rust: "Saving chunks for level 'ServerLevel[{}]'/{dimension}",
    // rust: self.level.name
    // rust: ),
    // rust: );
}
}

    // `MinecraftServer.runServer`'s `finally`: a tick that panicked still saves. What the panic
    // interrupted is not trusted: a guest's turn (`as_guest`) holds the game's player state
    // swapped in, so its record is older than what the game holds, and writing it would put
    // back older data than the last autosave; that guest keeps the file it has. A hub that the
    // panic took with it (`self.lan.take()` was in progress) saves no players at all. The
    // levels, the scoreboard and the other state are saved as in a normal stop.
stop_after_crash :: proc(self: ^Self, message: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: log("ERROR", &format!("The server thread panicked: {message}"));
    // rust: let acting = self.lan_acting;
    // rust: let hub_lost = self.lan.is_none();
    // rust: if let (Some(conn), Some(host)) = (acting, self.lan.as_mut())
    // rust: && let Some(guest) = host.hub.guests.iter_mut().find(|g| g.conn == conn)
    // rust: {
    // rust: guest.placed = false;
}
    // rust: if hub_lost {
    // rust: log(
    // rust: "WARN",
    // rust: "The panic interrupted the network tick: players are not saved, only the world",
    // rust: );
    // rust: } else if acting.is_some() {
    // rust: log(
    // rust: "WARN",
    // rust: "The panic interrupted a player's turn: that player keeps the last saved file",
    // rust: );
}
    // rust: self.native_lifecycle.begin_close();
    // rust: log("INFO", "Saving worlds");
    // rust: self.save_game()?;
    // rust: self.log_saved_levels();
    // rust: self.native_lifecycle_world_closed();
    // rust: self.lan_close(false);
    // rust: Err(format!("the server thread panicked: {message}").into())
}

stop_dedicated :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
        // The close request starts before player and world saves.
    // rust: self.native_lifecycle.begin_close();
        // MinecraftServer.stopServer's start: everyone is still here.
    // rust: self.native_server_stopping(true);
    // rust: self.native_configs_server_stop();
    // rust: log("INFO", "Stopping server");
    // rust: self.native_players_leaving();
    // rust: log("INFO", "Saving players");
    // rust: if let Some(mut host) = self.lan.take() {
    // rust: self.flush_native_net(&mut host);
            // PlayerList.removeAll: each player's file, with the vehicle it
            // alone rides, then its records.
    // rust: self.save_leaving_guests(&mut host);
    // rust: self.lan = Some(host);
}
    // rust: if let Some(h) = self.lan.as_mut() {
    // rust: let conns: Vec<u32> = h.hub.guests.iter().map(|g| g.conn).collect();
    // rust: for conn in conns {
    // rust: h.hub.kick(
    // rust: conn,
    // rust: translatable("multiplayer.disconnect.server_shutdown", &[]),
    // rust: );
}
}
    // rust: std::thread::sleep(Duration::from_millis(100));
    // rust: log("INFO", "Saving worlds");
        // ServerPlayer.disconnect: nobody is left in a bed.
    // rust: self.free_player_beds()?;
    // rust: self.save_game()?;
    // rust: self.log_saved_levels();
        // Only a successful final save closes the epoch; storage is still held.
    // rust: self.native_lifecycle_world_closed();
    // rust: self.lan_close(false);
    // rust: Ok(())
}
}

// `tools/test_dedicated_crash_save.py`'s fixture: with `HORIZON_CRASH_FIXTURE` naming `point`
// (`guest`: during a placed guest's turn, `hub`: while a console line has the hub out and a
// player is in), the tick panics there, to see what `stop_after_crash` keeps.
// `armed` is asked only when the variable names `point`, so the tick pays one
// load of a `OnceLock` without it.
    // rust: pub(super) fn crash_fixture(point: &str, armed: impl FnOnce() -> bool) {
FIXTURE :: std::sync::OnceLock::new()
    // rust: let fixture = FIXTURE.get_or_init(|| std::env::var("HORIZON_CRASH_FIXTURE").ok());
    // rust: if fixture.as_deref() == Some(point) && armed() {
    // rust: panic!("crash fixture at {point}");
}
}

// The text of a panic payload (`panic!("..")` is a `&str`, a formatted one a `String`).
panic_message :: proc(payload: ^(dyn std::any::Any + Send) {
}
    // rust: payload
    // rust: .downcast_ref::<&str>()
    // rust: .map(|s| (*s).to_owned())
    // rust: .or_else(|| payload.downcast_ref::<String>().cloned())
    // rust: .unwrap_or_else(|| "unknown panic".to_owned())
}

// The width and height of a PNG (its IHDR chunk).
png_size :: proc(bytes: []u8) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if bytes.len() < 24 || &bytes[..8] != b"\x89PNG\r\n\x1a\n" || &bytes[12..16] != b"IHDR" {
    // rust: return None;
}
    // rust: let w = u32::from_be_bytes(bytes[16..20].try_into().ok()?);
    // rust: let h = u32::from_be_bytes(bytes[20..24].try_into().ok()?);
    // rust: Some((w, h))
}

// The level a console command runs in when `active` is in place: always
// the overworld (`MinecraftServer.createCommandSourceStack` uses
// `overworld()`), so None when it already is.
console_level :: proc(active: super::Dim) -> O {
    // Ported from Horizon
    return {}
}
    // rust: (active != super::Dim::Overworld).then_some(super::Dim::Overworld)
}

    // rust: mod tests {
//     use super::{
    // rust: capture_log, log, log_from, overload_warning, panic_message, parse_whitelist_bypass,
}
//     use std::{
    // rust: fs,
    // rust: io::{self, BufRead, BufReader, Read, Write},
    // rust: process::{Command, Stdio},
    // rust: time::{SystemTime, UNIX_EPOCH},
}

    // A console line runs in the overworld even after a server tick left the nether in place.
console_commands_run_in_the_overworld :: proc() {
}
//         use super::super::Dim;
    // rust: assert_eq!(super::console_level(Dim::Nether), Some(Dim::Overworld));
    // rust: assert_eq!(super::console_level(Dim::End), Some(Dim::Overworld));
    // rust: assert_eq!(super::console_level(Dim::Overworld), None);
}

    // `BanIpCommands.banIp`: the info line names the affected players, one or several, and is
    // absent when no one is affected.
ban_ip_info_names_the_affected_players :: proc() {
}
    // rust: let args = |t: &super::Text| {
    // rust: let c = t.component();
    // rust: c["with"]
    // rust: .as_array()
    // rust: .unwrap()
    // rust: .iter()
    // rust: .map(|a| a.to_string())
    // rust: .collect::<Vec<_>>()
}
    // rust: assert!(super::ban_ip_info(&[]).is_none());
    // rust: let one = super::ban_ip_info(&["Alex"]).unwrap();
    // rust: assert_eq!(one.translation_key(), Some("commands.banip.info"));
    // rust: let a = args(&one);
    // rust: assert!(a[0].contains('1') && a[1].contains("Alex"), "{a:?}");
    // rust: let two = super::ban_ip_info(&["Alex", "Steve"]).unwrap();
    // rust: let a = args(&two);
    // rust: assert!(a[0].contains('2'), "{a:?}");
    // rust: assert!(
    // rust: a[1].contains("Alex") && a[1].contains(", ") && a[1].contains("Steve"),
    // rust: "{a:?}"
    // rust: );
}

whitelist_bypass_file_takes_uuid_prefixes_and_refuses_junk :: proc() {
}
    // rust: let ok =
    // rust: parse_whitelist_bypass("# Bedrock\n00000000-0000-0000-0009-  # floodgate\n\n").unwrap();
    // rust: assert_eq!(ok, vec!["00000000-0000-0000-0009-".to_owned()]);
    // rust: assert!(
    // rust: parse_whitelist_bypass("0-").is_err(),
    // rust: "a short prefix would match nearly everyone"
    // rust: );
    // rust: assert!(parse_whitelist_bypass("not-a-uuid-at-all").is_err());
}

    // `SaveAllCommand.saveAll`: a save that throws is the `ERROR_FAILED` the
    // source is told about, not a log line the caller never sees.
a_failed_save_tells_the_source_that_it_failed :: proc() {
}
    // rust: assert_eq!(
    // rust: super::save_all_reply(true).translation_key(),
    // rust: Some("commands.save.success")
    // rust: );
    // rust: assert_eq!(
    // rust: super::save_all_reply(false).translation_key(),
    // rust: Some("commands.save.failed")
    // rust: );
}

    // Vanilla's words, with how far behind the server is in milliseconds and in whole ticks.
the_overload_warning_reads_as_vanilla_s :: proc() {
}
    // rust: let tick = std::time::Duration::from_millis(50);
    // rust: assert_eq!(
    // rust: overload_warning(std::time::Duration::from_millis(13_027), tick),
    // rust: "Can't keep up! Is the server overloaded? Running 13027ms or 260 ticks behind"
    // rust: );
}

    // A `panic!("literal")` carries a `&str`, a formatted one a `String`; anything else is
    // named as unknown, so the crash line is never empty.
a_panic_payload_is_read_as_text :: proc() {
}
    // rust: let literal = std::panic::catch_unwind(|| panic!("a literal")).unwrap_err();
    // rust: assert_eq!(panic_message(literal.as_ref()), "a literal");
    // rust: let n = 3;
    // rust: let formatted = std::panic::catch_unwind(|| panic!("tick {n}")).unwrap_err();
    // rust: assert_eq!(panic_message(formatted.as_ref()), "tick 3");
    // rust: let other = std::panic::catch_unwind(|| std::panic::panic_any(7_u8)).unwrap_err();
    // rust: assert_eq!(panic_message(other.as_ref()), "unknown panic");
}

LOGIN :: "Player[/127.0.0.1:0] logged in with entity id 2 at (0.5, 115.0, 0.5)"
WARNING :: "Authentication warning"
READY :: "horizon-console-log-ready\n"
CHILD_HOME :: "HORIZON_TEST_CONSOLE_LOG_HOME"

assert_log_lines :: proc(text: string) {
}
    // rust: let expected = [
    // rust: format!("] [Server thread/INFO]: {LOGIN}"),
    // rust: format!("] [User Authenticator #1/WARN]: {WARNING}"),
    // rust: ];
    // rust: assert_eq!(text.lines().count(), expected.len());
    // rust: for (line, suffix) in text.lines().zip(expected) {
    // rust: assert!(line.starts_with('['));
    // rust: assert!(chrono::NaiveTime::parse_from_str(&line[1..9], "%H:%M:%S").is_ok());
    // rust: assert_eq!(&line[9..], suffix);
}
}

console_logging_survives_closed_stdout :: proc() {
}
    // rust: if let Some(home) = std::env::var_os(CHILD_HOME) {
    // rust: horizon_client::logging::init(std::path::Path::new(&home), "Server thread");
            // Let the parent close the real stdout pipe only after libtest's startup output.
    // rust: io::stdout().write_all(READY.as_bytes()).unwrap();
    // rust: io::stdout().flush().unwrap();
    // rust: io::stdin().read_exact(&mut [0]).unwrap();
    // rust: std::thread::Builder::new()
    // rust: .name("Server thread".into())
    // rust: .spawn(|| {
    // rust: let captured = capture_log(|| {
    // rust: log("INFO", LOGIN);
    // rust: log_from("User Authenticator #1", "WARN", WARNING);
    // rust: });
    // rust: assert_eq!(captured, [LOGIN, WARNING]);
    // rust: horizon_client::logging::flush();
    // rust: })
    // rust: .unwrap()
    // rust: .join()
    // rust: .unwrap();
            // Libtest's final status also writes to stdout; only the game logger is under test.
    // rust: std::process::exit(0);
}

    // rust: for closed_stdout in [false, true] {
    // rust: let unique = SystemTime::now()
    // rust: .duration_since(UNIX_EPOCH)
    // rust: .unwrap()
    // rust: .as_nanos();
    // rust: let home = std::env::temp_dir().join(format!(
    // rust: "horizon-console-log-test-{}-{unique}",
    // rust: std::process::id()
    // rust: ));
    // rust: fs::create_dir(&home).unwrap();
    // rust: let mut child = Command::new(std::env::current_exe().unwrap())
    // rust: .args([
    // rust: "--exact",
    // rust: "game::dedicated::tests::console_logging_survives_closed_stdout",
    // rust: "--nocapture",
    // rust: ])
    // rust: .env(CHILD_HOME, &home)
    // rust: .stdin(Stdio::piped())
    // rust: .stdout(Stdio::piped())
    // rust: .stderr(Stdio::piped())
    // rust: .spawn()
    // rust: .unwrap();
    // rust: let mut stdout = BufReader::new(child.stdout.take().unwrap());
    // rust: loop {
    // rust: let mut line = String::new();
    // rust: assert!(
    // rust: stdout.read_line(&mut line).unwrap() > 0,
    // rust: "child was not ready"
    // rust: );
    // rust: if line.ends_with(READY) {
    // rust: break;
}
}
    // rust: if closed_stdout {
    // rust: drop(stdout); // No reader remains: the next console write gets EPIPE.
    // rust: } else {
    // rust: child.stdout = Some(stdout.into_inner());
}
    // rust: child.stdin.take().unwrap().write_all(&[1]).unwrap();
    // rust: let output = child.wait_with_output().unwrap();
    // rust: assert!(
    // rust: output.status.success(),
    // rust: "closed_stdout={closed_stdout}: {}",
    // rust: String::from_utf8_lossy(&output.stderr)
    // rust: );
    // rust: if !closed_stdout {
    // rust: assert_log_lines(std::str::from_utf8(&output.stdout).unwrap());
}
    // rust: assert_log_lines(&fs::read_to_string(home.join("logs/latest.log")).unwrap());
    // rust: fs::remove_dir_all(home).unwrap();
}
}

    // A temporary ban (`/tempban`, the chat filter's) keeps the player out and says when it ends;
    // once it has ended, or after `/pardon`, they come in.
a_temporarily_banned_player_is_refused_with_the_end_until_it_has_passed :: proc() {
}
//         use super::{BanEntry, BanList, Lists, NameAndId};
//         use horizon_chat_filter::now_millis;
    // rust: let dir = std::env::temp_dir().join(format!("horizon-can-login-{}", std::process::id()));
    // rust: fs::create_dir_all(&dir).unwrap();
    // rust: let mut lists = Lists {
    // rust: ops: super::OpList::new(dir.join("ops.json")),
    // rust: white: super::WhiteList::new(dir.join("whitelist.json")),
    // rust: bans: BanList::new(dir.join("banned-players.json")),
    // rust: ip_bans: super::IpBanList::new(dir.join("banned-ips.json")),
    // rust: use_whitelist: false,
    // rust: enforce_whitelist: false,
    // rust: op_level: 4,
    // rust: player_idle_timeout: 0,
    // rust: stop: false,
    // rust: autosave: true,
    // rust: whitelist_bypass: Vec::new(),
}
        // Every translation key and string in a message, in the order they come.
words :: proc(tag: ^super::Tag, out: ^[dynamic]string) {
}
    // rust: match tag {
    // rust: super::Tag::String(s) => out.push(s.to_string_lossy()),
    // rust: super::Tag::List(items) => items.iter().for_each(|t| words(t, out)),
    // rust: super::Tag::Compound(_) => {
    // rust: for key in ["translate", "with", "extra"] {
    // rust: if let Some(t) = tag.get(key) {
    // rust: words(t, out);
}
}
}
    // rust: _ => {}
}
}
    // rust: let message = |tag: Option<super::Tag>| {
    // rust: let mut out = Vec::new();
    // rust: words(&tag.expect("a refusal"), &mut out);
    // rust: out.join(" | ")
}
    // rust: let address: std::net::SocketAddr = "127.0.0.1:25565".parse().unwrap();
    // rust: let user = |id: u128, name: &str| NameAndId {
    // rust: id,
    // rust: name: name.into(),
}
    // rust: let ban = |user: &NameAndId, expires: Option<i64>| {
    // rust: BanEntry::new(
    // rust: user.clone(),
    // rust: Some("Op".into()),
    // rust: expires,
    // rust: Some("griefing".into()),
    // rust: )
}
    // rust: let (steve, alex, dee) = (user(1, "Steve"), user(2, "Alex"), user(3, "Dee"));
        // Free until banned.
    // rust: assert!(lists.can_login(address, &steve).is_none());
        // A ban for an hour: refused, with the reason and when it ends.
    // rust: lists.bans.add(ban(&steve, Some(now_millis() + 3_600_000)));
    // rust: let refused = message(lists.can_login(address, &steve));
    // rust: assert!(
    // rust: refused.contains("multiplayer.disconnect.banned.reason"),
    // rust: "{refused}"
    // rust: );
    // rust: assert!(
    // rust: refused.contains("multiplayer.disconnect.banned.expiration"),
    // rust: "{refused}"
    // rust: );
    // rust: assert!(refused.contains("griefing"), "{refused}");
        // A permanent ban is refused with no end.
    // rust: lists.bans.add(ban(&alex, None));
    // rust: let refused = message(lists.can_login(address, &alex));
    // rust: assert!(!refused.contains("expiration"), "{refused}");
        // A ban that has ended lets the player in, and the list drops it.
    // rust: lists.bans.add(ban(&dee, Some(now_millis() - 1_000)));
    // rust: assert!(lists.can_login(address, &dee).is_none());
    // rust: assert!(!lists.bans.contains(&dee));
        // `/pardon` lifts the hour's ban.
    // rust: assert!(lists.bans.remove(&steve));
    // rust: assert!(lists.can_login(address, &steve).is_none());
    // rust: fs::remove_dir_all(dir).unwrap();
}
}
