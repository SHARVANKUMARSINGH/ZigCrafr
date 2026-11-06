//! Transpiled from Horizon Rust crate
package horizon_telemetry_server_live

import "core:fmt"
import "core:mem"
import "core:math"

// Who is playing now, from the games' "I'm playing" pings (`horizon_telemetry::live`). Kept in
// memory only: a session ID, when it last pinged, its version, platform and LAN flag. A
// session counts while its last ping is under the window old and is forgotten after it. No
// address is kept, and nothing is written to disk, so a restart starts the count again (it
// is whole again a minute later).
// use std::collections::{BTreeMap, HashMap};
// use std::time::{Duration, Instant};

// use horizon_telemetry::live::{Count, PLATFORMS, Ping};

// Versions listed by name in a count; the rest are summed under `other`.
VERSIONS_SHOWN :: 12

Seen :: struct {
    at: Instant,
    version: ^str,
    platform: u8,
    lan: bool,
}

Live :: struct {
    sessions: HashMap<u128,
    window: Duration,
    max_sessions: uint,
}

// The table is full and this session is new.
Full :: struct {

    // rust: impl Live {
new :: proc(window: Duration, max_sessions: uint) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    sessions: HashMap::new(),
    // rust: window,
    // rust: max_sessions,
}
}

    // Records `ping` (already checked) as seen at `now`.
ping :: proc(self: ^Self, ping: ^Ping, now: Instant) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let Ok(id) = u128::from_str_radix(&ping.session, 16) else {
    // rust: return Ok(());
}
    // rust: if !self.sessions.contains_key(&id) && self.sessions.len() >= self.max_sessions {
    // rust: self.forget_expired(now);
    // rust: if self.sessions.len() >= self.max_sessions {
    // rust: return Err(Full);
}
}
    // rust: let platform = PLATFORMS
    // rust: .iter()
    // rust: .position(|p| *p == ping.platform)
    // rust: .unwrap_or(PLATFORMS.len() - 1) as u8;
    // rust: self.sessions.insert(
    // rust: id,
    // rust: Seen {
    // rust: at: now,
    // rust: version: ping.version.as_str().into(),
    // rust: platform,
    // rust: lan: ping.lan,
    // rust: },
    // rust: );
    // rust: Ok(())
}

    // Drops the sessions whose last ping is older than the window.
forget_expired :: proc(self: ^Self, now: Instant) {
}
    // rust: let window = self.window;
    // rust: self.sessions
    // rust: .retain(|_, s| now.saturating_duration_since(s.at) < window);
}

    // Who is playing at `now`, exactly.
count :: proc(self: ^Self, now: Instant) -> C {
    // Ported from Horizon
    return {}
}
    // rust: self.forget_expired(now);
    // rust: let mut versions: HashMap<&str, u64> = HashMap::new();
    // rust: let mut platforms = [0u64; PLATFORMS.len()];
    // rust: let mut lan = 0;
    // rust: for s in self.sessions.values() {
    // rust: *versions.entry(&s.version).or_default() += 1;
    // rust: platforms[usize::from(s.platform)] += 1;
    // rust: lan += u64::from(s.lan);
}
    // rust: let mut by_count: Vec<(&str, u64)> = versions.into_iter().collect();
    // rust: by_count.sort_by(|a, b| b.1.cmp(&a.1).then(a.0.cmp(b.0)));
    // rust: let mut shown = BTreeMap::new();
    // rust: let mut other = 0;
    // rust: for (i, (version, n)) in by_count.into_iter().enumerate() {
    // rust: if i < VERSIONS_SHOWN {
    // rust: shown.insert(version.to_owned(), n);
    // rust: } else {
    // rust: other += n;
}
}
    // rust: if other > 0 {
    // rust: *shown.entry("other".to_owned()).or_default() += other;
}
    // rust: Count {
    // rust: playing: self.sessions.len() as u64,
    // rust: lan,
    // rust: versions: shown,
    // rust: platforms: PLATFORMS
    // rust: .iter()
    // rust: .zip(platforms)
    // rust: .filter(|(_, n)| *n > 0)
    // rust: .map(|(p, n)| ((*p).to_owned(), n))
    // rust: .collect(),
}
}

    // Sessions held now, counted or not yet forgotten.
len :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.sessions.len()
}

is_empty :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.sessions.is_empty()
}
}

    // rust: mod tests {
//     use super::*;

ping :: proc(n: u32, version: string, platform: string, lan: bool) -> P {
    // Ported from Horizon
    return {}
}
    // rust: Ping {
    // rust: session: format!("{n:032x}"),
    // rust: version: version.into(),
    // rust: platform: platform.into(),
    // rust: lan,
}
}

sessions_count_until_the_window_passes :: proc() {
}
    // rust: let t = Instant::now();
    // rust: let mut live = Live::new(Duration::from_secs(120), 100);
    // rust: live.ping(&ping(1, "0.2.0", "linux", false), t).unwrap();
    // rust: live.ping(&ping(2, "0.2.0", "macos", true), t).unwrap();
        // The same session again is still one.
    // rust: live.ping(
    // rust: &ping(1, "0.2.0", "linux", false),
    // rust: t + Duration::from_secs(60),
    // rust: )
    // rust: .unwrap();
    // rust: let count = live.count(t + Duration::from_secs(61));
    // rust: assert_eq!((count.playing, count.lan), (2, 1));
    // rust: assert_eq!(count.versions, BTreeMap::from([("0.2.0".into(), 2)]));
    // rust: assert_eq!(
    // rust: count.platforms,
    // rust: BTreeMap::from([("linux".into(), 1), ("macos".into(), 1)])
    // rust: );
        // Session 2 stopped pinging two minutes ago; session 1 pinged a minute later.
    // rust: let count = live.count(t + Duration::from_secs(150));
    // rust: assert_eq!((count.playing, count.lan), (1, 0));
    // rust: assert_eq!(live.len(), 1);
    // rust: assert_eq!(live.count(t + Duration::from_secs(181)), Count::default());
    // rust: assert!(live.is_empty());
}

a_full_table_takes_no_new_session_until_one_expires :: proc() {
}
    // rust: let t = Instant::now();
    // rust: let mut live = Live::new(Duration::from_secs(120), 2);
    // rust: live.ping(&ping(1, "0.2.0", "linux", false), t).unwrap();
    // rust: live.ping(&ping(2, "0.2.0", "linux", false), t).unwrap();
    // rust: assert_eq!(live.ping(&ping(3, "0.2.0", "linux", false), t), Err(Full));
        // A known session still refreshes.
    // rust: live.ping(
    // rust: &ping(1, "0.2.0", "linux", false),
    // rust: t + Duration::from_secs(100),
    // rust: )
    // rust: .unwrap();
    // rust: let later = t + Duration::from_secs(130);
    // rust: live.ping(&ping(3, "0.2.0", "linux", false), later).unwrap();
    // rust: assert_eq!(live.count(later).playing, 2);
}

rare_versions_are_summed_and_counts_exact :: proc() {
}
    // rust: let t = Instant::now();
    // rust: let mut live = Live::new(Duration::from_secs(120), 1000);
    // rust: for n in 0..41 {
    // rust: live.ping(&ping(n, "0.2.0", "windows", n % 4 == 0), t)
    // rust: .unwrap();
}
    // rust: for n in 0..(VERSIONS_SHOWN as u32 + 3) {
    // rust: live.ping(&ping(100 + n, &format!("dev {n}"), "other", false), t)
    // rust: .unwrap();
}
    // rust: let count = live.count(t);
        // Exact to the unit: 41 and 56 stay 41 and 56.
    // rust: assert_eq!(count.playing, 56);
    // rust: assert_eq!(count.lan, 11);
    // rust: assert_eq!(count.versions["0.2.0"], 41);
    // rust: assert_eq!(count.versions["other"], 4);
    // rust: assert_eq!(count.versions.len(), VERSIONS_SHOWN + 1);
    // rust: assert_eq!(count.platforms["windows"], 41);
    // rust: assert_eq!(count.platforms["other"], 15);
}
}
