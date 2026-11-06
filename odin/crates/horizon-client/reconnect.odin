//! Transpiled from Horizon Rust crate
package horizon_client_reconnect

import "core:fmt"
import "core:mem"
import "core:math"

// The auto-reconnect extra (`docs/extras.md`): whether a lost multiplayer
// connection may be retried, and when. Only lost connections and the
// server's own shutdown or restart are retried, never kicks, bans or
// refusals; attempts back off and stop after a few.
// use std::time::{Duration, Instant};

// Seconds before each attempt; there are no more after the last.
DELAYS :: [5, 10, 20, 40, 60]
// Staying connected this long counts the next drop as a fresh one.
STABLE :: Duration::from_secs(60)

// Whether a disconnect may be retried. `from_server`: the server (or a
// permanent refusal) gave `reason`, rather than the connection failing.
//
// `key`: the reason's translation key, when it was a translatable
// component or a known Horizon error. A key the classification knows
// decides; the English keyword scan of the text is only the fallback for
// plain reasons (OS errors, servers' literal kicks), whose language is
// the server's own.
allowed :: proc(reason: string, key: Maybe(string), from_server: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(decision) = key.and_then(classified_key) {
    // rust: return decision;
}
    // rust: let r = reason.to_lowercase();
    // Kicks, bans, whitelists, version refusals and the account's session
    // refusals (`disconnect.loginFailedInfo.*` but the unreachable session
    // servers, the server's failed username check, joining an online-mode
    // server without an account): never.
    // rust: const NEVER: [&str; 13] = [
    // rust: "ban",
    // rust: "kick",
    // rust: "white-list",
    // rust: "whitelist",
    // rust: "incompatible",
    // rust: "outdated",
    // rust: "another location",
    // rust: "online mode",
    // rust: "invalid server address",
    // rust: "invalid session",
    // rust: "multiplayer is disabled",
    // rust: "failed to verify username",
    // rust: "microsoft account",
    // rust: ];
    // rust: if NEVER.iter().any(|w| r.contains(w)) {
    // rust: return false;
}
    // rust: if !from_server {
    // rust: return true;
}
    // The server going away for a while: vanilla's shutdown and time-out
    // reasons, a full server, a slow login, the server's own session
    // servers being down, and restart messages.
    // rust: const RETRY: [&str; 6] = [
    // rust: "server closed",
    // rust: "timed out",
    // rust: "the server is full",
    // rust: "took too long to log in",
    // rust: "authentication servers",
    // rust: "restart",
    // rust: ];
    // rust: RETRY.iter().any(|w| r.contains(w))
}

// The key lists' key-based counterpart: `Some` when the key alone
// decides. Prefix match, so a key's arguments' variants
// (`multiplayer.disconnect.banned.expiration`) share the base's verdict.
classified_key :: proc(key: string) -> O {
    // Ported from Horizon
    return {}
}
    // The keyword lists above, as the keys those texts carry: bans, kicks,
    // whitelists, version refusals, the account's session refusals and
    // Horizon's own refusals: never. Shutdowns, timeouts, a full server, a
    // slow login and the session servers being down: retry.
    // rust: const NEVER: [&str; 14] = [
    // rust: "multiplayer.disconnect.banned",
    // rust: "multiplayer.disconnect.ip_banned",
    // rust: "multiplayer.disconnect.kicked",
    // rust: "multiplayer.disconnect.not_whitelisted",
    // rust: "multiplayer.disconnect.incompatible",
    // rust: "multiplayer.disconnect.outdated_client",
    // rust: "multiplayer.disconnect.outdated_server",
    // rust: "multiplayer.disconnect.duplicate_login",
    // rust: "multiplayer.disconnect.unverified_username",
    // rust: "disconnect.loginFailedInfo.invalidSession",
    // rust: "disconnect.loginFailedInfo.insufficientPrivileges",
    // rust: "disconnect.loginFailedInfo.userBanned",
    // rust: "horizon.multiplayer.not_signed_in",
    // rust: "horizon.multiplayer.invalid_address",
    // rust: ];
    // rust: const RETRY: [&str; 6] = [
    // rust: "multiplayer.disconnect.server_shutdown",
    // rust: "multiplayer.disconnect.server_full",
    // rust: "multiplayer.disconnect.slow_login",
    // rust: "multiplayer.disconnect.authservers_down",
    // rust: "disconnect.loginFailedInfo.serversUnavailable",
    // rust: "disconnect.timeout",
    // rust: ];
    // rust: NEVER
    // rust: .iter()
    // rust: .any(|k| key.starts_with(k))
    // rust: .then_some(false)
    // rust: .or_else(|| RETRY.iter().any(|k| key.starts_with(k)).then_some(true))
}

// Attempts at one address.
Tracker :: struct {
    address: Maybe(string),
    // The player name the connection used.
    name: string,
    lan: bool,
    // Attempts already made since the last stable connection.
    attempts: uint,
    joined: Maybe(Instant),
}
// A planned attempt.
Retry :: struct {
    address: string,
    name: string,
    lan: bool,
    at: Instant,
    // 1-based, of `DELAYS.len()`.
    attempt: uint,
}
    // rust: impl Retry {
    // Whole seconds left, rounded up.
seconds_left :: proc(self: ^Self, now: Instant) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let left = self.at.saturating_duration_since(now);
    // rust: left.as_secs() + u64::from(left.subsec_nanos() > 0)
}
due :: proc(self: ^Self, now: Instant) -> b {
    // Ported from Horizon
    return {}
}
    // rust: now >= self.at
}
text :: proc(self: ^Self, now: Instant) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!(
    // rust: "Reconnecting in {} s (attempt {} of {})",
    // rust: self.seconds_left(now),
    // rust: self.attempt,
    // rust: DELAYS.len()
    // rust: )
}
}
    // rust: impl Tracker {
    // The server connected to last (splitscreen players join the same one).
address :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.address.as_deref()
}
    // A connection to `address` as `name` starts: a new address starts
    // counting anew.
connecting :: proc(self: ^Self, address: string, name: string, lan: bool) {
}
    // rust: if self.address.as_deref() != Some(address) {
    // rust: self.address = Some(address.to_owned());
    // rust: self.attempts = 0;
}
    // rust: self.name = name.to_owned();
    // rust: self.lan = lan;
    // rust: self.joined = None;
}
    // The server let the player in.
joined :: proc(self: ^Self, now: Instant) {
}
    // rust: self.joined = Some(now);
}
    // The player left on purpose, or cancelled: nothing to retry.
reset :: proc(self: ^Self) {
}
    // rust: *self = Self::default();
}
    // The connection ended: the next attempt, or None (not allowed, or
    // out of attempts).
    // rust: pub fn ended(
    // rust: &mut self,
    // rust: reason: &str,
    // rust: key: Option<&str>,
    // rust: from_server: bool,
    // rust: now: Instant,
    // rust: ) -> Option<Retry> {
    // rust: if self
    // rust: .joined
    // rust: .take()
    // rust: .is_some_and(|t| now.saturating_duration_since(t) >= STABLE)
    // rust: {
    // rust: self.attempts = 0;
}
    // rust: let address = self.address.clone()?;
    // rust: if !allowed(reason, key, from_server) || self.attempts >= DELAYS.len() {
    // rust: self.reset();
    // rust: return None;
}
    // rust: let delay = Duration::from_secs(DELAYS[self.attempts]);
    // rust: self.attempts += 1;
    // rust: Some(Retry {
    // rust: address,
    // rust: name: self.name.clone(),
    // rust: lan: self.lan,
    // rust: at: now + delay,
    // rust: attempt: self.attempts,
    // rust: })
}
}

    // rust: mod tests {
//     use super::*;

reconnect_keeps_the_selected_server_kind :: proc() {
}
    // rust: let mut tracker = Tracker::default();
    // rust: let now = Instant::now();
    // rust: tracker.connecting("127.0.0.1:25565", "Tester", true);
    // rust: assert!(tracker.ended("Server closed", None, true, now).unwrap().lan);
    // rust: tracker.connecting("127.0.0.1:25565", "Tester", false);
    // rust: assert!(!tracker.ended("Server closed", None, true, now).unwrap().lan);
}

only_lost_connections_and_shutdowns_are_retried :: proc() {
}
    // rust: assert!(allowed(
    // rust: "Connection reset by peer (os error 104)",
    // rust: None,
    // rust: false
    // rust: ));
    // rust: assert!(allowed("Connection refused (os error 111)", None, false));
    // rust: assert!(allowed("Server closed", None, true));
    // rust: assert!(allowed("Timed out", None, true));
    // rust: assert!(allowed("The server is full!", None, true));
    // rust: assert!(allowed("Server is restarting, back soon", None, true));
    // rust: assert!(!allowed("Kicked by an operator", None, true));
    // rust: assert!(!allowed(
    // rust: "You are banned from this server.\nReason: griefing",
    // rust: None,
    // rust: true
    // rust: ));
    // rust: assert!(!allowed(
    // rust: "You are not white-listed on this server!",
    // rust: None,
    // rust: true
    // rust: ));
    // rust: assert!(!allowed("You logged in from another location", None, true));
    // rust: assert!(!allowed("Incompatible client! Please use 26.3", None, true));
    // rust: assert!(!allowed("You have been idle for too long!", None, true));
    // rust: assert!(
    // rust: !allowed("Go away", None, true),
    // rust: "unknown server reasons are not retried"
    // rust: );
    // rust: assert!(!allowed(
    // rust: "This server is in online mode. Horizon only joins offline-mode servers.",
    // rust: Some("horizon.multiplayer.not_signed_in"),
    // rust: true
    // rust: ));
    // rust: assert!(!allowed("Kicked for spamming", None, false));
}

online_mode_login_failures :: proc() {
}
        // The client's join with the session service (net.rs: Err, with
        // vanilla's disconnect.loginFailedInfo texts and the inner key).
    // rust: let failed = |why: &str| format!("Failed to log in: {why}");
    // rust: assert!(!allowed(
    // rust: &failed("Invalid session (Try restarting your game and the launcher)"),
    // rust: Some("disconnect.loginFailedInfo.invalidSession"),
    // rust: false
    // rust: ));
    // rust: assert!(!allowed(
    // rust: &failed("You are banned from playing online"),
    // rust: Some("disconnect.loginFailedInfo.userBanned"),
    // rust: false
    // rust: ));
    // rust: assert!(!allowed(
    // rust: &failed("Multiplayer is disabled. Please check your Microsoft account settings."),
    // rust: Some("disconnect.loginFailedInfo.insufficientPrivileges"),
    // rust: false
    // rust: ));
    // rust: assert!(!allowed(
    // rust: crate::net::NOT_SIGNED_IN,
    // rust: Some("horizon.multiplayer.not_signed_in"),
    // rust: false
    // rust: ));
        // Unreachable session servers are worth another try.
    // rust: assert!(allowed(
    // rust: &failed("The authentication servers are currently not reachable. Please try again."),
    // rust: Some("disconnect.loginFailedInfo.serversUnavailable"),
    // rust: false
    // rust: ));
    // rust: assert!(allowed(&failed("Connection timed out"), None, false));
        // The server's side: its username check failed, or its session
        // servers are down.
    // rust: assert!(!allowed("Failed to verify username!", None, true));
    // rust: assert!(allowed(
    // rust: "Authentication servers are down. Please try again later. Sorry!",
    // rust: Some("multiplayer.disconnect.authservers_down"),
    // rust: true
    // rust: ));
}

keys_decide_whatever_language_resolved_the_text :: proc() {
}
        // A zh_cn client resolves the server's and the session service's
        // texts: the keyword scan of the text would see none of the
        // English words, the keys do. A tiny fake language file stands in
        // for vanilla's; Horizon's bundled strings come with the map.
//         use horizon_client_core::lang::{Language, ResourceSource};
//         use std::collections::HashMap;
Mem :: struct {
    // rust: impl ResourceSource for Mem {
read :: proc(self: ^Self, path: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.0.get(path).cloned()
}
}
    // rust: let mem = Mem(HashMap::from([(
    // rust: "assets/minecraft/lang/zh_cn.json".into(),
    // rust: r#"{
    // rust: "multiplayer.disconnect.server_shutdown": "服务器已关闭",
    // rust: "multiplayer.disconnect.server_full": "服务器已满！",
    // rust: "multiplayer.disconnect.slow_login": "登录超时",
    // rust: "multiplayer.disconnect.kicked": "被管理员踢出游戏",
    // rust: "multiplayer.disconnect.banned": "你已被此服务器封禁",
    // rust: "multiplayer.disconnect.not_whitelisted": "你不在此服务器的白名单中！",
    // rust: "disconnect.loginFailedInfo.invalidSession": "无效会话（请尝试重启游戏及启动器）"
    // rust: }"#
    // rust: .as_bytes()
    // rust: .to_vec(),
    // rust: )]));
    // rust: let lang = Language::load(&[&mem], "zh_cn");
    // rust: let zh = |key: &str| lang.get(key).unwrap_or(key).to_owned();
    // rust: assert_eq!(zh("multiplayer.disconnect.server_shutdown"), "服务器已关闭");
    // rust: assert_eq!(
    // rust: zh("horizon.multiplayer.not_signed_in"),
    // rust: "该服务器为在线模式服务器。请先在 Horizon 启动器中登录 Microsoft 账户再加入。"
    // rust: );
        // Shutdowns, a full server and a slow login are retried, kicks and
        // bans are not — whatever the resolved text says.
    // rust: assert!(allowed(
    // rust: &zh("multiplayer.disconnect.server_shutdown"),
    // rust: Some("multiplayer.disconnect.server_shutdown"),
    // rust: true
    // rust: ));
    // rust: assert!(allowed(
    // rust: &zh("multiplayer.disconnect.server_full"),
    // rust: Some("multiplayer.disconnect.server_full"),
    // rust: true
    // rust: ));
    // rust: assert!(allowed(
    // rust: &zh("multiplayer.disconnect.slow_login"),
    // rust: Some("multiplayer.disconnect.slow_login"),
    // rust: true
    // rust: ));
    // rust: assert!(!allowed(
    // rust: &zh("multiplayer.disconnect.kicked"),
    // rust: Some("multiplayer.disconnect.kicked"),
    // rust: true
    // rust: ));
    // rust: assert!(!allowed(
    // rust: &zh("multiplayer.disconnect.banned"),
    // rust: Some("multiplayer.disconnect.banned"),
    // rust: true
    // rust: ));
    // rust: assert!(!allowed(
    // rust: &zh("multiplayer.disconnect.not_whitelisted"),
    // rust: Some("multiplayer.disconnect.not_whitelisted"),
    // rust: true
    // rust: ));
    // rust: assert!(!allowed(
    // rust: &zh("disconnect.loginFailedInfo.invalidSession"),
    // rust: Some("disconnect.loginFailedInfo.invalidSession"),
    // rust: false
    // rust: ));
    // rust: assert!(!allowed(
    // rust: &zh("horizon.multiplayer.not_signed_in"),
    // rust: Some("horizon.multiplayer.not_signed_in"),
    // rust: true
    // rust: ));
        // Unknown and missing keys fall back to the text scan.
    // rust: assert!(allowed(
    // rust: "Connection reset by peer (os error 104)",
    // rust: Some("made.up.key"),
    // rust: false
    // rust: ));
    // rust: assert!(allowed("Connection refused (os error 111)", None, false));
    // rust: assert!(!allowed("Go away", Some("made.up.key"), true));
}

attempts_back_off_and_stop :: proc() {
}
    // rust: let mut t = Tracker::default();
    // rust: let now = Instant::now();
    // rust: t.connecting("localhost:25565", "Tester", false);
    // rust: let mut delays = Vec::new();
    // rust: while let Some(r) = t.ended("Connection refused", None, false, now) {
    // rust: assert_eq!(
    // rust: (r.address.as_str(), r.name.as_str()),
    // rust: ("localhost:25565", "Tester")
    // rust: );
    // rust: assert_eq!(r.attempt, delays.len() + 1);
    // rust: delays.push(r.at.duration_since(now).as_secs());
    // rust: t.connecting(&r.address, &r.name, false);
}
    // rust: assert_eq!(delays, DELAYS);
        // Out of attempts, the tracker forgets the address.
    // rust: assert_eq!(t.ended("Connection refused", None, false, now), None);
}

a_short_stay_does_not_reset_the_count :: proc() {
}
    // rust: let mut t = Tracker::default();
    // rust: let now = Instant::now();
    // rust: t.connecting("a", "P", false);
    // rust: for _ in 0..DELAYS.len() {
    // rust: t.connecting("a", "P", false);
    // rust: t.joined(now);
    // rust: assert!(
    // rust: t.ended("Server closed", None, true, now + Duration::from_secs(5))
    // rust: .is_some()
    // rust: );
}
    // rust: t.connecting("a", "P", false);
    // rust: t.joined(now);
    // rust: assert_eq!(
    // rust: t.ended("Server closed", None, true, now + Duration::from_secs(5)),
    // rust: None
    // rust: );
        // A minute connected starts over.
    // rust: t.connecting("a", "P", false);
    // rust: for _ in 0..3 {
    // rust: t.ended("Timed out", None, true, now);
    // rust: t.connecting("a", "P", false);
}
    // rust: t.joined(now);
    // rust: let r = t.ended("Timed out", None, true, now + STABLE).unwrap();
    // rust: assert_eq!(r.attempt, 1);
}

kicks_and_leaving_reset_and_new_addresses_start_over :: proc() {
}
    // rust: let mut t = Tracker::default();
    // rust: let now = Instant::now();
    // rust: t.connecting("a", "P", false);
    // rust: assert!(t.ended("Server closed", None, true, now).is_some());
    // rust: assert_eq!(t.ended("Kicked by an operator", None, true, now), None);
    // rust: assert_eq!(
    // rust: t.ended("Server closed", None, true, now),
    // rust: None,
    // rust: "forgotten after a kick"
    // rust: );
    // rust: t.connecting("a", "P", false);
    // rust: t.ended("Server closed", None, true, now);
    // rust: t.connecting("b", "P", false);
    // rust: assert_eq!(
    // rust: t.ended("Server closed", None, true, now).unwrap().attempt,
    // rust: 1
    // rust: );
    // rust: let mut t = Tracker::default();
    // rust: assert_eq!(
    // rust: t.ended("Server closed", None, true, now),
    // rust: None,
    // rust: "never connected"
    // rust: );
}

the_countdown_rounds_up :: proc() {
}
    // rust: let now = Instant::now();
    // rust: let r = Retry {
    // rust: address: "a".into(),
    // rust: name: "P".into(),
    // rust: lan: false,
    // rust: at: now + Duration::from_millis(4200),
    // rust: attempt: 2,
}
    // rust: assert_eq!(r.seconds_left(now), 5);
    // rust: assert_eq!(r.text(now), "Reconnecting in 5 s (attempt 2 of 5)");
    // rust: assert!(!r.due(now));
    // rust: assert!(r.due(now + Duration::from_secs(5)));
    // rust: assert_eq!(r.seconds_left(now + Duration::from_secs(9)), 0);
}
}
