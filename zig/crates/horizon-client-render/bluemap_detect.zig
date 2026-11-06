//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_bluemap_detect
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Finding a server's BlueMap without the player naming it
//! (`blueMapAutoDetect`, off by default): the BlueMap worker tries a few
//! likely web addresses (`candidates`), taking only one whose `settings.json`
//! is BlueMap's web-app settings, and the answer is kept per server in
//! `server-terrain/<server>/BlueMap/detected.txt` so a rejoin asks nothing.
//! A `blueMap:` line the player wrote always wins.
// use crate::bluemap::Settings;
// use std::{
    // rust: net::IpAddr,
    // rust: path::{Path, PathBuf},
    // rust: sync::Mutex,
    // rust: time::{Duration, SystemTime},
}

/// The answer kept per server, beside its BlueMap tiles.
pub const FILE: []const u8 = "detected.txt";
/// A server found without a map is asked again after this long.
pub const RETRY_NONE: Duration = Duration::from_secs(24 * 3600);
/// A map found is checked again (its address first) after this long.
pub const RETRY_FOUND: Duration = Duration::from_secs(7 * 24 * 3600);
/// Each probe gets this long, connecting included.
pub const TIMEOUT: Duration = Duration::from_secs(4);
/// Probes start this far apart at least.
pub const GAP: Duration = Duration::from_millis(500);

/// Where a level's BlueMap comes from.
pub const Source = enum {
    /// The player's `blueMap:` line, or a map found before.
    Url {,
    url: String,
    maps: Vec<(String, String)>,
    // rust: },
    /// To be looked for at these addresses, in order.
    Detect(Vec<String>),
};

/// What the server at `address` draws far terrain from, its BlueMap folder
/// being `dir`: `None` when the player named no map and either auto-detect
/// is off or the server was found without one recently.
pub fn source(settings: *Settings, address: []const u8, dir: *Path, now: SystemTime) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(server) = settings.server(address) {
    // rust: return Some(Source::Url {
    // rust: url: server.url.clone(),
    // rust: maps: server.maps.clone(),
    // rust: });
}
    // rust: if !settings.auto_detect {
    // rust: return None;
}
    // rust: let mut probes = Vec::new();
    // Only an address this server's would be looked for at: a remembered
    // one from elsewhere (a copied folder) names someone else's.
    // rust: let ours = candidates(address);
    // rust: match remembered(dir, now) {
    // rust: Remembered::Found(url) | Remembered::Stale(Some(url)) if !ours.contains(&url) => {}
    // rust: Remembered::Found(url) => {
    // rust: return Some(Source::Url {
    // rust: url,
    // rust: maps: Vec::new(),
    // rust: });
}
    // rust: Remembered::Nothing => return None,
    // rust: Remembered::Stale(Some(url)) => probes.push(url),
    // rust: Remembered::Stale(None) => {}
}
    // rust: for candidate in ours {
    // rust: if !probes.contains(&candidate) {
    // rust: probes.push(candidate);
}
}
    // rust: (!probes.is_empty()).then_some(Source::Detect(probes))
}

/// The first labels a game server's host name takes beside its site's.
pub const GAME_LABELS: *[[]const u8] = &["play", "mc", "minecraft", "mine", "join", "server"];

/// Domains whose names belong to many customers (dynamic DNS, server
/// hosts): `map.` of them is someone else's.
    // rust: const SHARED: &[&str] = &[
    // rust: "aternos.me",
    // rust: "ddns.net",
    // rust: "duckdns.org",
    // rust: "hopto.org",
    // rust: "minehut.gg",
    // rust: "no-ip.org",
    // rust: "playit.gg",
    // rust: "serveminecraft.net",
    // rust: "zapto.org",
    // rust: ];

/// The web addresses a server's BlueMap likely answers at: BlueMap's own
/// web server (port 8100), the server's host, and its `map.` subdomain, also
/// under the parent domain of a `play.`/`mc.` style host (`GAME_LABELS`).
pub fn candidates(address: []const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let address = address.trim().to_ascii_lowercase();
    // rust: let host = if let Some(rest) = address.strip_prefix('[') {
    // rust: rest.split(']').next().unwrap_or(rest)
    // rust: } else if address.matches(':').count() > 1 {
    // rust: &address[..]
    // rust: } else {
    // rust: address.split(':').next().unwrap_or(&address)
}
    // rust: let host = host.trim_end_matches('.');
    // rust: if host.is_empty() {
    // rust: return Vec::new();
}
    // rust: let mut out = Vec::new();
    // rust: if let Ok(ip) = host.parse::<IpAddr>() {
        // Certificates are for names: plain HTTP only.
    // rust: let host = match ip {
    // rust: IpAddr::V6(_) => format!("[{host}]"),
    // rust: IpAddr::V4(_) => host.to_owned(),
}
    // rust: out.push(format!("http://{host}:8100"));
    // rust: out.push(format!("http://{host}"));
    // rust: return out;
}
    // rust: if !host
    // rust: .chars()
    // rust: .all(|c| c.is_ascii_alphanumeric() || c == '.' || c == '-')
    // rust: {
    // rust: return Vec::new();
}
    // rust: out.push(format!("http://{host}:8100"));
    // rust: let labels = host.split('.').count();
    // rust: let map = |host: &str| (!host.starts_with("map.")).then(|| format!("map.{host}"));
    // rust: if labels >= 2
    // rust: && let Some(map) = map(host)
    // rust: {
    // rust: out.push(format!("https://{map}"));
}
    // rust: out.push(format!("https://{host}"));
    // rust: if labels >= 2
    // rust: && let Some(map) = map(host)
    // rust: {
    // rust: out.push(format!("http://{map}"));
}
    // rust: out.push(format!("http://{host}"));
    // `play.example.net` → `map.example.net`, only for a game server's
    // usual names: the parent of `name.hosting.example` is another party's.
    // rust: if labels >= 3
    // rust: && let Some((first, parent)) = host.split_once('.')
    // rust: && GAME_LABELS.contains(&first)
    // rust: && !SHARED.contains(&parent)
    // rust: && let Some(map) = map(parent)
    // rust: {
    // rust: out.push(format!("https://{map}"));
    // rust: out.push(format!("http://{map}"));
}
    // rust: let mut seen = Vec::new();
    // rust: out.retain(|url| {
    // rust: let new = !seen.contains(url);
    // rust: seen.push(url.clone());
    // rust: new
    // rust: });
    // rust: out
}

/// Whether `json` is a BlueMap web app's `settings.json`: a list of map ids
/// and where their data lies, not any page a web server returns.
pub fn is_web_app_settings(json: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Ok(v) = serde_json::from_slice::<serde_json::Value>(json) else {
    // rust: return false;
}
    // rust: let maps = v.get("maps").and_then(|m| m.as_array());
    // rust: maps.is_some_and(|maps| !maps.is_empty() && maps.iter().all(|m| m.is_string()))
    // rust: && v.get("mapDataRoot").is_some_and(|r| r.is_string())
}

/// Whether a BlueMap web app answers at `base`.
pub fn probe(agent: *ureq::Agent, base: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
//     use std::io::Read;
    // rust: let Ok(response) = agent
    // rust: .get(&format!("{base}/settings.json"))
    // rust: .timeout(TIMEOUT)
    // rust: .call()
    // rust: else {
    // rust: return false;
}
    // rust: let mut body = Vec::new();
    // rust: response
    // rust: .into_reader()
    // rust: .take(256 << 10)
    // rust: .read_to_end(&mut body)
    // rust: .is_ok()
    // rust: && is_web_app_settings(&body)
}

/// What an earlier look found.
pub const Remembered = enum {
    Found(String),
    /// Nothing, recently.
    Nothing,
    /// Never looked, or long enough ago to look again (first at the map
    /// found then, if any).
    Stale(Option<String>),
};

pub fn remembered(dir: *Path, now: SystemTime) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Ok(text) = std::fs::read_to_string(dir.join(FILE)) else {
    // rust: return Remembered::Stale(None);
}
    // rust: let mut words = text.split_whitespace();
    // rust: let (kind, at) = (words.next(), words.next().and_then(|t| t.parse().ok()));
    // rust: let Some(at) = at.map(|secs| SystemTime::UNIX_EPOCH + Duration::from_secs(secs)) else {
    // rust: return Remembered::Stale(None);
}
    // A time ahead of the clock (a clock set wrong, a copied file) is stale.
    // rust: let Ok(age) = now.duration_since(at) else {
    // rust: return Remembered::Stale(None);
}
    // rust: match (kind, words.next()) {
    // rust: (Some("found"), Some(url)) if age < RETRY_FOUND => Remembered::Found(url.to_owned()),
    // rust: (Some("found"), Some(url)) => Remembered::Stale(Some(url.to_owned())),
    // rust: (Some("none"), _) if age < RETRY_NONE => Remembered::Nothing,
    // rust: _ => Remembered::Stale(None),
}
}

/// Keeps what a look found (`None`: no map).
pub fn remember(dir: *Path, found: ?[]const u8, now: SystemTime) void {
}
    // rust: let secs = now
    // rust: .duration_since(SystemTime::UNIX_EPOCH)
    // rust: .map_or(0, |d| d.as_secs());
    // rust: let text = match found {
    // rust: Some(url) => format!("found {secs} {url}\n"),
    // rust: None => format!("none {secs}\n"),
}
    // rust: let _ = std::fs::create_dir_all(dir);
    // rust: let _ = std::fs::write(dir.join(FILE), text);
}

/// The servers being looked at now, by BlueMap folder: one look a server at
/// a time, however many levels open meanwhile.
pub const LOOKING: Mutex<std.ArrayList(PathBuf)> = Mutex::new(Vec::new());

/// The right to look for `dir`'s server's map, until dropped.
pub const Claim = struct {};
    // rust: impl Claim {
    /// `None` while another look at the same server runs.
pub fn take(dir: *Path) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut looking = LOOKING.lock().unwrap();
    // rust: if looking.iter().any(|d| d == dir) {
    // rust: return None;
}
    // rust: looking.push(dir.to_owned());
    // rust: Some(Self(dir.to_owned()))
}
}
    // rust: impl Drop for Claim {
pub fn drop(self: *Self) void {
}
    // rust: LOOKING.lock().unwrap().retain(|d| *d != self.0);
}
}

    // rust: mod tests {
//     use super::*;

pub fn candidates_cover_the_web_server_host_and_map_subdomains() void {
}
    // rust: assert_eq!(
    // rust: candidates("Play.Example.net:25566"),
    // rust: [
    // rust: "http://play.example.net:8100",
    // rust: "https://map.play.example.net",
    // rust: "https://play.example.net",
    // rust: "http://map.play.example.net",
    // rust: "http://play.example.net",
    // rust: "https://map.example.net",
    // rust: "http://map.example.net",
    // rust: ]
    // rust: );
    // rust: assert_eq!(
    // rust: candidates("example.net"),
    // rust: [
    // rust: "http://example.net:8100",
    // rust: "https://map.example.net",
    // rust: "https://example.net",
    // rust: "http://map.example.net",
    // rust: "http://example.net",
    // rust: ]
    // rust: );
        // Already the map's host: no `map.map.`.
    // rust: assert_eq!(
    // rust: candidates("map.example.net"),
    // rust: [
    // rust: "http://map.example.net:8100",
    // rust: "https://map.example.net",
    // rust: "http://map.example.net",
    // rust: ]
    // rust: );
    // rust: assert_eq!(
    // rust: candidates("192.0.2.7:25565"),
    // rust: ["http://192.0.2.7:8100", "http://192.0.2.7"]
    // rust: );
    // rust: assert_eq!(
    // rust: candidates("[2001:db8::7]:25565"),
    // rust: ["http://[2001:db8::7]:8100", "http://[2001:db8::7]"]
    // rust: );
    // rust: assert_eq!(
    // rust: candidates("2001:db8::7"),
    // rust: ["http://[2001:db8::7]:8100", "http://[2001:db8::7]"]
    // rust: );
    // rust: assert_eq!(
    // rust: candidates("localhost"),
    // rust: [
    // rust: "http://localhost:8100",
    // rust: "https://localhost",
    // rust: "http://localhost"
    // rust: ]
    // rust: );
        // A hosted name's parent is the host's, not the server's.
    // rust: assert!(
    // rust: !candidates("play.ddns.net")
    // rust: .iter()
    // rust: .any(|url| url.ends_with("//map.ddns.net"))
    // rust: );
    // rust: assert!(
    // rust: !candidates("name.host.example")
    // rust: .iter()
    // rust: .any(|url| url.ends_with("//map.host.example"))
    // rust: );
    // rust: assert!(candidates("").is_empty());
    // rust: assert!(candidates("evil.example.net/path?x").is_empty());
}

pub fn only_blue_maps_settings_count() void {
}
    // rust: let web_app = br#"{"version":"5.4","useCookies":true,"maps":["world","world_nether"],
    // rust: "mapDataRoot":"maps","liveDataRoot":"maps","scripts":[],"styles":[]}"#;
    // rust: assert!(is_web_app_settings(web_app));
    // rust: assert!(!is_web_app_settings(b"<!doctype html><html></html>"));
    // rust: assert!(
    // rust: !is_web_app_settings(br#"{"maps":["world"]}"#),
    // rust: "no data root"
    // rust: );
    // rust: assert!(!is_web_app_settings(br#"{"maps":[],"mapDataRoot":"maps"}"#));
    // rust: assert!(!is_web_app_settings(
    // rust: br#"{"maps":[1],"mapDataRoot":"maps"}"#
    // rust: ));
    // rust: assert!(!is_web_app_settings(
    // rust: br#"{"maps":"world","mapDataRoot":"maps"}"#
    // rust: ));
    // rust: assert!(!is_web_app_settings(
    // rust: br#"[{"maps":["world"],"mapDataRoot":"maps"}]"#
    // rust: ));
}

pub fn scratch(name: []const u8) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let dir = std::env::temp_dir().join(format!(
    // rust: "horizon-bluemap-detect-{name}-{}",
    // rust: std::process::id()
    // rust: ));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: dir
}

pub fn answers_are_kept_and_looked_at_again_later() void {
}
    // rust: let dir = scratch("remember");
    // rust: let t0 = SystemTime::UNIX_EPOCH + Duration::from_secs(1_800_000_000);
    // rust: let hour = Duration::from_secs(3600);
    // rust: assert_eq!(remembered(&dir, t0), Remembered::Stale(None));
    // rust: remember(&dir, None, t0);
    // rust: assert_eq!(remembered(&dir, t0 + hour), Remembered::Nothing);
        // Written ahead of the clock: not trusted.
    // rust: assert_eq!(remembered(&dir, t0 - hour), Remembered::Stale(None));
    // rust: assert_eq!(remembered(&dir, t0 + RETRY_NONE), Remembered::Stale(None));
    // rust: remember(&dir, Some("https://map.example.net"), t0);
    // rust: assert_eq!(
    // rust: remembered(&dir, t0 + 2 * RETRY_NONE),
    // rust: Remembered::Found("https://map.example.net".into())
    // rust: );
    // rust: assert_eq!(
    // rust: remembered(&dir, t0 + RETRY_FOUND),
    // rust: Remembered::Stale(Some("https://map.example.net".into()))
    // rust: );
    // rust: std::fs::write(dir.join(FILE), "garbage").unwrap();
    // rust: assert_eq!(remembered(&dir, t0), Remembered::Stale(None));
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}

pub fn the_players_map_wins_and_detection_waits_for_the_setting() void {
}
    // rust: let dir = scratch("source");
    // rust: let now = SystemTime::now();
    // rust: let mut settings = Settings::default();
    // rust: let address = "play.example.net";
    // rust: assert_eq!(
    // rust: source(&settings, address, &dir, now),
    // rust: None,
    // rust: "off by default"
    // rust: );
    // rust: settings.auto_detect = true;
    // rust: let Some(Source::Detect(probes)) = source(&settings, address, &dir, now) else {
    // rust: panic!("looked for");
}
    // rust: assert_eq!(probes, candidates(address));
    // rust: remember(&dir, None, now);
    // rust: assert_eq!(
    // rust: source(&settings, address, &dir, now),
    // rust: None,
    // rust: "none, recently"
    // rust: );
    // rust: remember(&dir, Some("https://map.example.net"), now);
    // rust: assert_eq!(
    // rust: source(&settings, address, &dir, now),
    // rust: Some(Source::Url {
    // rust: url: "https://map.example.net".into(),
    // rust: maps: Vec::new()
    // rust: })
    // rust: );
        // A remembered map this server's addresses don't include (a copied
        // folder's) is no map.
    // rust: remember(&dir, Some("https://tracker.example"), now);
    // rust: let Some(Source::Detect(probes)) = source(&settings, address, &dir, now) else {
    // rust: panic!("looked for, the remembered one ignored");
}
    // rust: assert_eq!(probes, candidates(address));
    // rust: remember(&dir, Some("https://map.example.net"), now);
        // Past a week the found map is tried first, then the rest.
    // rust: let later = now + RETRY_FOUND;
    // rust: let Some(Source::Detect(probes)) = source(&settings, address, &dir, later) else {
    // rust: panic!("looked for again");
}
    // rust: assert_eq!(probes[0], "https://map.example.net");
    // rust: assert_eq!(probes.len(), candidates(address).len());
    // rust: settings.servers.push(
    // rust: Settings::parse_server("play.example.net http://example.net:8123 nether=n").unwrap(),
    // rust: );
    // rust: assert_eq!(
    // rust: source(&settings, address, &dir, now),
    // rust: Some(Source::Url {
    // rust: url: "http://example.net:8123".into(),
    // rust: maps: vec![("minecraft:the_nether".into(), "n".into())]
    // rust: })
    // rust: );
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}

pub fn one_look_a_server_at_a_time() void {
}
    // rust: let dir = scratch("claim");
    // rust: let claim = Claim::take(&dir).unwrap();
    // rust: assert!(Claim::take(&dir).is_none());
    // rust: drop(claim);
    // rust: assert!(Claim::take(&dir).is_some());
}
}
