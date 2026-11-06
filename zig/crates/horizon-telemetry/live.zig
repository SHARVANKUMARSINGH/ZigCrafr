//! Transpiled from Horizon Rust crate
//! Module: horizon-telemetry_live
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The anonymous "I'm playing" ping, and the live count it feeds ("N playing now" in the
//! launcher).
//!
//! Unlike everything else in this crate it does not wait for consent: Ludovic decided
//! (2026-10-22) to count every player and tell them, in the launcher's first-run question, its
//! Settings and the privacy page. So a ping holds only what the count needs: a random session ID
//! made when the game starts and kept only in its memory (not the install ID), the Horizon
//! version, the platform and whether a LAN or play-with-friends world is open. The game sends
//! one every [`INTERVAL`]; the server counts a session while its last ping is under
//! [`WINDOW`] old and serves the counts exactly. It writes down only the totals, once a minute,
//! for the history on playhorizon.dev/stats: never a session.
// use std::collections::BTreeMap;
// use std::time::Duration;

// use serde::{Deserialize, Serialize};

/// How often the game pings while it runs.
pub const INTERVAL: Duration = Duration::from_secs(60);

/// How long a session counts after its last ping: two pings, so one lost on the way doesn't
/// drop it.
pub const WINDOW: Duration = Duration::from_secs(120);

/// The platforms a ping may name; anything else is `other`.
pub const PLATFORMS: [[]const u8; 4] = ["linux", "macos", "windows", "other"];

/// The largest ping body the server reads.
pub const MAX_PING_BYTES: usize = 512;

pub const MAX_VERSION: usize = 40;

/// One "I'm playing", as it is sent: `{"session":"…","version":"…","platform":"…","lan":false}`.
pub const Ping = struct {
    /// 128 random bits in hex, made when the game starts ([`session_id`]) and never written down.
    session: []const u8,
    /// The release (`v2026.10.15`, `0.2.0`) or `dev 0.1.0` for a build from source.
    version: []const u8,
    /// One of [`PLATFORMS`].
    platform: []const u8,
    /// A world is open to LAN or to friends over the internet.
    lan: bool,
};

    // rust: impl Ping {
pub fn new(session: []const u8, version: []const u8, lan: bool) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: session: session.to_owned(),
    // rust: version: version.to_owned(),
    // rust: platform: platform().to_owned(),
    // rust: lan,
}
}

    /// Why the server refuses this ping, if it does.
pub fn check(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !crate::consent::is_install_id(&self.session) {
    // rust: return Err("session: 32 lowercase hex digits");
}
    // rust: let version_ok = !self.version.is_empty()
    // rust: && self.version.len() <= MAX_VERSION
    // rust: && self
    // rust: .version
    // rust: .bytes()
    // rust: .all(|b| b.is_ascii_alphanumeric() || b" .+-_".contains(&b));
    // rust: if !version_ok {
    // rust: return Err("version: at most 40 letters, digits, spaces and .+-_");
}
    // rust: if !PLATFORMS.contains(&self.platform.as_str()) {
    // rust: return Err("platform: linux, macos, windows or other");
}
    // rust: Ok(())
}
}

/// A new session ID: 128 random bits in hex.
pub fn session_id() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: crate::random_hex(16)
}

/// This machine's entry in [`PLATFORMS`].
pub fn platform() * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match std::env::consts::OS {
    // rust: os @ ("linux" | "macos" | "windows") => os,
    // rust: _ => "other",
}
}

/// The live count, as `GET /v1/live` serves it: exact numbers.
pub const Count = struct {
    /// Sessions that pinged within the window.
    playing: u64,
    /// Of those, the ones with a LAN or play-with-friends world open.
    lan: u64,
    /// Per version: the most played ones, the rest summed under `other`.
    versions: BTreeMap<[]const u8,
    /// Per platform.
    platforms: BTreeMap<[]const u8,
};

/// Sends `ping` to `endpoint` (`https://host`, without a trailing slash).
pub fn send(endpoint: []const u8, ping: *Ping) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: agent()
    // rust: .post(&format!("{endpoint}/v1/live"))
    // rust: .set("Content-Type", "application/json")
    // rust: .send_string(&serde_json::to_string(ping).map_err(|e| e.to_string())?)
    // rust: .map(drop)
    // rust: .map_err(|e| e.to_string())
}

/// The live count at `endpoint`.
pub fn fetch(endpoint: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let body = agent()
    // rust: .get(&format!("{endpoint}/v1/live"))
    // rust: .call()
    // rust: .map_err(|e| e.to_string())?
    // rust: .into_string()
    // rust: .map_err(|e| e.to_string())?;
    // rust: serde_json::from_str(&body).map_err(|e| e.to_string())
}

pub fn agent() u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ureq::AgentBuilder::new()
    // rust: .timeout(Duration::from_secs(5))
    // rust: .build()
}

    // rust: mod tests {
//     use super::*;

pub fn ping() P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ping::new(&session_id(), "v2026.10.15", false)
}

pub fn a_ping_holds_only_the_four_fields() void {
}
    // rust: let json = serde_json::to_value(Ping::new(&"a".repeat(32), "0.2.0", true)).unwrap();
    // rust: let mut keys: Vec<&str> = json
    // rust: .as_object()
    // rust: .unwrap()
    // rust: .keys()
    // rust: .map(|k| k.as_str())
    // rust: .collect();
    // rust: keys.sort_unstable();
    // rust: assert_eq!(keys, ["lan", "platform", "session", "version"]);
    // rust: assert!(serde_json::to_string(&ping()).unwrap().len() < MAX_PING_BYTES);
}

pub fn session_ids_are_fresh_each_time() void {
}
    // rust: let (a, b) = (session_id(), session_id());
    // rust: assert_ne!(a, b);
    // rust: assert!(ping().check().is_ok());
}

pub fn bad_pings_are_refused() void {
}
    // rust: let bad = |f: fn(&mut Ping)| {
    // rust: let mut p = ping();
    // rust: f(&mut p);
    // rust: p.check().is_err()
}
    // rust: assert!(bad(|p| p.session = "ABC".into()));
    // rust: assert!(bad(|p| p.session = "G".repeat(32)));
    // rust: assert!(bad(|p| p.version = String::new()));
    // rust: assert!(bad(|p| p.version = "1".repeat(41)));
    // rust: assert!(bad(|p| p.version = "<script>".into()));
    // rust: assert!(bad(|p| p.platform = "haiku".into()));
    // rust: assert!(!bad(|p| p.version = "dev 0.1.0".into()));
    // rust: let extra = r#"{"session":"00000000000000000000000000000000","version":"0.2.0","platform":"linux","lan":false,"name":"Steve"}"#;
    // rust: assert!(serde_json::from_str::<Ping>(extra).is_err());
}
}
