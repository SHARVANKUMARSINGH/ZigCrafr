//! Transpiled from Horizon Rust crate
//! Module: horizon-port-pack_net
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The agents port-pack's downloads go through: the jars of an imported modpack come from the same
//! places as everything else, so they take the same proxy — and leave the same hosts alone.
//!
//! The launcher hands its own setting over (`set_proxy`, from `proxy.rs`); a run of the
//! `horizon-port-pack` command reads `HTTPS_PROXY`, `HTTP_PROXY` and `ALL_PROXY` instead (`env_for`),
//! taking the one that matches the address's scheme the way the launcher does. Either way a host in
//! `NO_PROXY`, or on this computer, is reached directly: a host that only answers without the proxy
//! would otherwise fail here while the launcher's own downloads worked.
//!
//! Which hosts those are is decided here and nowhere else. The launcher asks `direct`, `env_for`,
//! `host_of`, `scheme_of` and `parse` for its own traffic, and keeps its agents here too
//! (`keep`), so the two agree whatever the player set — and there is one copy of the rules to
//! change when they need it.
// use std::collections::HashMap;
// use std::sync::atomic::{AtomicBool, Ordering};
// use std::sync::{Mutex, MutexGuard};

/// What the launcher set, when it did.
pub const PROXY: Mutex<?[]const u8> = Mutex::new(None);

/// Agents kept for reuse, named by the part that asked and the proxy they use: a fresh `Agent`
/// starts a new connection pool, so building one per request costs a handshake per file.
pub const KEPT: Mutex<?std.AutoHashMap([]const u8, ureq::Agent)> = Mutex::new(None);

/// The proxy to use from now on: the launcher's setting, or None to fall back to the environment.
/// The agents built so far are dropped when it changes, since they hold the address it replaces.
pub fn set_proxy(spec: ?[]const u8) void {
}
    // rust: let spec = spec.map(|s| s.trim().to_owned()).filter(|s| !s.is_empty());
    // rust: let mut proxy = lock(&PROXY);
    // rust: if *proxy == spec {
    // rust: return;
}
    // rust: *proxy = spec;
    // rust: drop(proxy);
    // rust: *lock(&KEPT) = None;
}

/// The proxy address `url` is fetched through: what the launcher set, else the environment's for
/// its scheme, unless `url` is a host that must be reached directly.
pub fn spec_for(url: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if direct(url) {
    // rust: return None;
}
    // rust: lock(&PROXY)
    // rust: .clone()
    // rust: .or_else(|| env_for(scheme_of(url).unwrap_or("https")))
}

/// An agent for downloading `url`: through the proxy when one is set, unless `url` is a host that
/// must be reached directly.
pub fn agent(url: []const u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: keep("port-pack", spec_for(url).as_deref(), |proxy| {
    // rust: let builder = ureq::AgentBuilder::new();
    // rust: match proxy {
    // rust: Some(proxy) => builder.proxy(proxy).build(),
    // rust: None => builder.build(),
}
    // rust: })
}

/// The agent `url` is fetched with, built by `build` and then kept for the next request that names
/// the same `slot` and proxy: a fresh `Agent` starts a new connection pool, so building one per
/// request is a handshake per file, and a modpack's jars are fetched one after another.
    // rust: pub fn keep(
    // rust: slot: &str,
    // rust: spec: Option<&str>,
    // rust: build: impl FnOnce(Option<ureq::Proxy>) -> ureq::Agent,
    // rust: ) -> ureq::Agent {
    // rust: let proxy = spec.and_then(parse);
    // An address that isn't a proxy is used as none, and remembered as none.
    // rust: let key = format!(
    // rust: "{slot} {}",
    // rust: if proxy.is_some() {
    // rust: spec.unwrap_or_default()
    // rust: } else {
    // rust: ""
}
    // rust: );
    // rust: if let Some(agent) = lock(&KEPT).as_ref().and_then(|kept| kept.get(&key)) {
    // rust: return agent.clone();
}
    // rust: let agent = build(proxy);
    // rust: lock(&KEPT)
    // rust: .get_or_insert_with(HashMap::new)
    // rust: .insert(key, agent.clone());
    // rust: agent
}

/// `spec` as a proxy, when it is one. An address that can't be used is said once: a download left
/// to go direct would otherwise fail with nothing pointing at the proxy.
pub fn parse(spec: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // `socks5h` is curl's name for SOCKS5 with the proxy resolving host names. `ureq` has only the
    // name `socks5`, which already sends it host names to resolve.
    // rust: let address = match spec.strip_prefix("socks5h://") {
    // rust: Some(rest) => format!("socks5://{rest}"),
    // rust: None => spec.to_owned(),
}
    // rust: match ureq::Proxy::new(&address) {
    // rust: Ok(proxy) => Some(proxy),
    // rust: Err(e) => {
    // rust: say(&format!(
    // rust: "The proxy address {} can't be used ({e}); downloads go without one.",
    // rust: redacted(spec)
    // rust: ));
    // rust: None
}
}
}

/// `spec` as it may be shown: a user name and password in it become `***`. An address that can't
/// be used is printed to stderr and shown in the launcher, and a proxy's credentials don't belong in
/// either. Everything up to the last `@` is the credentials, so a password with an unescaped `/` or
/// `@` is hidden too.
pub fn redacted(spec: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (scheme, rest) = match spec.split_once("://") {
    // rust: Some((scheme, rest)) => (format!("{scheme}://"), rest),
    // rust: None => (String::new(), spec),
}
    // rust: match rest.rfind('@') {
    // rust: Some(at) => format!("{scheme}***@{}", &rest[at + 1..]),
    // rust: None => spec.to_owned(),
}
}

/// Whether `url` is reached without the proxy: a local address, or a host `NO_PROXY` names. The
/// launcher asks this of its own requests, so both reach the same hosts directly.
pub fn direct(url: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: host_of(url).is_some_and(|host| local(host) || excluded(host, &no_proxy()))
}

/// `HTTPS_PROXY` (`HTTP_PROXY` for an http address), then `ALL_PROXY`, in the upper-case spelling
/// first and the lower-case one after, as the tools that write them do.
pub fn env_for(scheme: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let names: &[&str] = if scheme.eq_ignore_ascii_case("http") {
    // rust: &["HTTP_PROXY", "http_proxy", "ALL_PROXY", "all_proxy"]
    // rust: } else {
    // rust: &["HTTPS_PROXY", "https_proxy", "ALL_PROXY", "all_proxy"]
}
    // rust: names.iter().find_map(|name| {
    // rust: std::env::var(name)
    // rust: .ok()
    // rust: .map(|v| v.trim().to_owned())
    // rust: .filter(|v| !v.is_empty())
    // rust: })
}

/// `NO_PROXY`'s list: the hosts reached directly whatever the proxy is.
pub fn no_proxy() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ["NO_PROXY", "no_proxy"]
    // rust: .iter()
    // rust: .find_map(|name| std::env::var(name).ok())
    // rust: .unwrap_or_default()
}

/// The host part of a URL (`https://user@host:port/path` is `host`).
pub fn host_of(url: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let rest = url.split_once("://").map_or(url, |(_, rest)| rest);
    // rust: let rest = rest.split(['/', '?', '#']).next()?;
    // rust: let rest = rest.rsplit_once('@').map_or(rest, |(_, host)| host);
    // rust: Some(match rest.rfind(':') {
        // A port follows the last colon; an IPv6 literal keeps the colons inside its brackets.
    // rust: Some(at) if !rest[at..].contains(']') => &rest[..at],
    // rust: _ => rest,
    // rust: })
}

/// `https` in `https://…`, or None for anything that isn't an absolute address.
pub fn scheme_of(url: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: url.split_once("://").map(|(scheme, _)| scheme)
}

/// Whether `host` is this computer: the game's own API and a server on the same machine.
pub fn local(host: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let host = bare(host);
    // rust: host == "localhost"
    // rust: || host.ends_with(".localhost")
    // rust: || host == "::1"
    // rust: || host == "0.0.0.0"
    // rust: || is_loopback_v4(&host)
}

/// A dotted IPv4 address in `127.0.0.0/8`; a DNS name that merely starts with `127.` is not one.
pub fn is_loopback_v4(host: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: host.starts_with("127.")
    // rust: && host
    // rust: .split('.')
    // rust: .all(|part| !part.is_empty() && part.bytes().all(|b| b.is_ascii_digit()))
}

/// Whether `host` is in `NO_PROXY`: `*`, `host`, `.domain`, `*.domain` and `host:port` entries.
pub fn excluded(host: []const u8, no_proxy: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let host = bare(host);
    // rust: no_proxy
    // rust: .split(',')
    // rust: .map(str::trim)
    // rust: .filter(|e| !e.is_empty())
    // rust: .any(|entry| {
    // rust: if entry == "*" {
    // rust: return true;
}
    // rust: let entry = entry.trim_start_matches('*').trim_start_matches('.');
            // A port follows the last colon of a bracketed entry, or of a host with no colon
            // before it; an unbracketed IPv6 literal keeps its colons.
    // rust: let entry = match entry.rfind(':') {
    // rust: Some(at)
    // rust: if !entry[at..].contains(']')
    // rust: && (entry[..at].ends_with(']') || !entry[..at].contains(':')) =>
    // rust: {
    // rust: &entry[..at]
}
    // rust: _ => entry,
}
    // rust: let entry = bare(entry);
    // rust: !entry.is_empty() && (host == entry || host.ends_with(&format!(".{entry}")))
    // rust: })
}

/// A host without the brackets an IPv6 literal wears, lower case.
pub fn bare(host: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: host.trim().trim_matches(['[', ']']).to_ascii_lowercase()
}

/// Said once, however many downloads follow: a wrong address is one thing to report, not one
/// report per file.
pub fn say(what: []const u8) void {
}
pub const SAID: AtomicBool = AtomicBool::new(false);
    // rust: if !SAID.swap(true, Ordering::Relaxed) {
    // rust: eprintln!("{what}");
}
}

/// The lock, even after a thread panicked while holding it: an address lost to a panic is worse
/// than an old one kept.
    // rust: fn lock<T>(m: &Mutex<T>) -> MutexGuard<'_, T> {
    // rust: m.lock().unwrap_or_else(|e| e.into_inner())
}

    // rust: mod tests {
//     use super::*;

    /// What the tests below share, since the address and the agents are one of each for the whole
    /// process: they take it in turn.
pub fn alone() M {
    // Implementation ported from Horizon
    return undefined;
}
pub const TURN: Mutex<()> = Mutex::new(());
    // rust: lock(&TURN)
}

pub fn credentials_are_not_shown() void {
}
    // rust: assert_eq!(redacted("http://127.0.0.1:7890"), "http://127.0.0.1:7890");
    // rust: assert_eq!(redacted("proxy.local:3128"), "proxy.local:3128");
    // rust: assert_eq!(
    // rust: redacted("http://user:pass@proxy.local:3128"),
    // rust: "http://***@proxy.local:3128"
    // rust: );
    // rust: assert_eq!(
    // rust: redacted("socks5://u:p@10.0.0.1:1080"),
    // rust: "socks5://***@10.0.0.1:1080"
    // rust: );
    // rust: assert_eq!(
    // rust: redacted("user:pass@proxy.local:3128"),
    // rust: "***@proxy.local:3128"
    // rust: );
    // rust: assert_eq!(redacted("http://u:p/a@ss@proxy:1"), "http://***@proxy:1");
    // rust: assert_eq!(redacted("http://user:pass@"), "http://***@");
}

pub fn a_proxy_the_launcher_sets_is_trimmed_and_kept() void {
}
    // rust: let _turn = alone();
    // rust: set_proxy(Some("  http://127.0.0.1:7890  ".into()));
    // rust: assert_eq!(
    // rust: PROXY.lock().unwrap().as_deref(),
    // rust: Some("http://127.0.0.1:7890")
    // rust: );
    // rust: set_proxy(Some("   ".into()));
    // rust: assert!(PROXY.lock().unwrap().is_none());
}

    /// An address on this computer is reached directly whatever `NO_PROXY` says: what an import
    /// needs when the launcher's own requests to it go direct.
pub fn a_local_address_is_reached_directly() void {
}
    // rust: assert!(direct("http://127.0.0.1:8130/api/v1/status"));
    // rust: assert!(direct("http://localhost/api/v1/status"));
    // rust: assert!(direct("https://[::1]:25565/"));
}

pub fn a_host_is_read_out_of_the_address() void {
}
    // rust: assert_eq!(
    // rust: host_of("https://cdn.modrinth.com/v2/x.jar"),
    // rust: Some("cdn.modrinth.com")
    // rust: );
    // rust: assert_eq!(
    // rust: host_of("https://user:pass@piston-meta.mojang.com:8443/a"),
    // rust: Some("piston-meta.mojang.com")
    // rust: );
    // rust: assert_eq!(
    // rust: host_of("http://127.0.0.1:8130/api/v1/status"),
    // rust: Some("127.0.0.1")
    // rust: );
    // rust: assert_eq!(host_of("https://[::1]:25565/"), Some("[::1]"));
    // rust: assert_eq!(host_of("https://example.com?x=1"), Some("example.com"));
    // rust: assert_eq!(host_of("https://example.com#top"), Some("example.com"));
}

pub fn only_absolute_addresses_have_a_scheme() void {
}
    // rust: assert_eq!(scheme_of("https://a.b"), Some("https"));
    // rust: assert_eq!(scheme_of("http://a.b"), Some("http"));
    // rust: assert_eq!(scheme_of("a.b/c"), None);
}

pub fn this_computer_is_never_proxied() void {
}
    // rust: for host in [
    // rust: "localhost",
    // rust: "LOCALHOST",
    // rust: "[::1]",
    // rust: "::1",
    // rust: "127.0.0.1",
    // rust: "127.1.2.3",
    // rust: ] {
    // rust: assert!(local(host), "{host}");
}
    // rust: for host in [
    // rust: "playhorizon.dev",
    // rust: "api.minecraftservices.com",
    // rust: "10.0.0.1",
    // rust: "127.example.com",
    // rust: "127.0.0.1.example.com",
    // rust: ] {
    // rust: assert!(!local(host), "{host}");
}
}

    /// What an import with `NO_PROXY=modrinth.com` needs: the launcher's own requests to it go
    /// direct, so the jars fetched for it must too.
pub fn no_proxy_lists_hosts_and_their_subdomains() void {
}
    // rust: assert!(excluded("anything.at.all", "*"));
    // rust: assert!(excluded("cdn.modrinth.com", "modrinth.com"));
    // rust: assert!(excluded("api.modrinth.com", "modrinth.com"));
    // rust: assert!(excluded("piston-meta.mojang.com", "mojang.com"));
    // rust: assert!(excluded(
    // rust: "wiki.corp.example",
    // rust: " .corp.example , other.host "
    // rust: ));
    // rust: assert!(excluded("github.com", "github.com:443"));
    // rust: assert!(!excluded("notmodrinth.com", "modrinth.com"));
    // rust: assert!(!excluded("modrinth.com", " .corp.example , mojang.com "));
    // rust: assert!(!excluded("edge.forgecdn.net", "modrinth.com"));
    // rust: assert!(!excluded("modrinth.com", ""));
}

    /// A bare IPv6 entry keeps its colons: cut at the last one it would never match the host in
    /// its brackets, and the download would go through the proxy after all.
pub fn no_proxy_keeps_a_bare_ipv6_entry_whole() void {
}
    // rust: assert!(excluded("[2001:db8::1]", "2001:db8::1"));
    // rust: assert!(excluded("[2001:db8::1]", "[2001:db8::1]"));
    // rust: assert!(excluded("[2001:db8::1]", "[2001:db8::1]:8080"));
    // rust: assert!(!excluded("[2001:db8::1]", "2001:db8::2"));
}

pub fn an_address_that_cant_be_used_becomes_no_proxy() void {
}
    // rust: assert!(parse("http://127.0.0.1:7890").is_some());
    // rust: assert!(parse("127.0.0.1:7890").is_some());
    // rust: assert!(parse("socks5://127.0.0.1:7891").is_some());
    // rust: assert!(parse("socks3://127.0.0.1:7890").is_none());
}

    /// A stand-in SOCKS5 proxy: answers one request itself and returns the host it was asked for.
pub fn socks5_proxy() ( {
    // Implementation ported from Horizon
    return undefined;
}
//         use std::io::{BufRead, BufReader, Read, Write};
    // rust: let listener = std::net::TcpListener::bind("127.0.0.1:0").unwrap();
    // rust: let port = listener.local_addr().unwrap().port();
    // rust: let server = std::thread::spawn(move || {
    // rust: let (mut stream, _) = listener.accept().unwrap();
    // rust: let mut greeting = [0; 2];
    // rust: stream.read_exact(&mut greeting).unwrap();
    // rust: assert_eq!(greeting[0], 5);
    // rust: let mut methods = vec![0; greeting[1].into()];
    // rust: stream.read_exact(&mut methods).unwrap();
    // rust: stream.write_all(&[5, 0]).unwrap();
    // rust: let mut request = [0; 5];
    // rust: stream.read_exact(&mut request).unwrap();
    // rust: assert_eq!(request[..4], [5, 1, 0, 3], "a CONNECT to a host name");
    // rust: let mut host = vec![0; request[4].into()];
    // rust: stream.read_exact(&mut host).unwrap();
    // rust: let mut target_port = [0; 2];
    // rust: stream.read_exact(&mut target_port).unwrap();
    // rust: stream.write_all(&[5, 0, 0, 1, 0, 0, 0, 0, 0, 0]).unwrap();
    // rust: let mut http = BufReader::new(stream.try_clone().unwrap());
    // rust: let mut line = String::new();
    // rust: while http.read_line(&mut line).unwrap() > 2 {
    // rust: line.clear();
}
    // rust: stream
    // rust: .write_all(b"HTTP/1.1 200 OK\r\nContent-Length: 2\r\nConnection: close\r\n\r\nok")
    // rust: .unwrap();
    // rust: String::from_utf8(host).unwrap()
    // rust: });
    // rust: (port, server)
}

    /// `.invalid` never resolves here (RFC 2606), so the answer can only have come through the
    /// proxy, which is handed the name to resolve.
pub fn a_request_goes_through_a_socks_proxy() void {
}
    // rust: for scheme in ["socks5", "socks5h"] {
    // rust: let (port, server) = socks5_proxy();
    // rust: let proxy = parse(&format!("{scheme}://127.0.0.1:{port}")).unwrap();
    // rust: let agent = ureq::AgentBuilder::new().proxy(proxy).build();
    // rust: let answer = agent.get("http://horizon.invalid/a.jar").call().unwrap();
    // rust: assert_eq!(answer.into_string().unwrap(), "ok", "{scheme}");
    // rust: assert_eq!(server.join().unwrap(), "horizon.invalid", "{scheme}");
}
}

    /// The agent a second request gets is the one the first built: one connection pool, not one
    /// handshake per jar.
pub fn an_agent_is_kept_for_the_next_request() void {
}
    // rust: let _turn = alone();
    // rust: set_proxy(None);
    // rust: let mut built = 0;
    // rust: for _ in 0..3 {
    // rust: keep("kept", None, |_| {
    // rust: built += 1;
    // rust: ureq::AgentBuilder::new().build()
    // rust: });
}
    // rust: assert_eq!(built, 1, "three requests, one agent");
        // Another address is another agent, and a new setting drops the ones before it.
    // rust: keep("kept", Some("http://127.0.0.1:7890"), |proxy| {
    // rust: assert!(proxy.is_some());
    // rust: built += 1;
    // rust: ureq::AgentBuilder::new().build()
    // rust: });
    // rust: assert_eq!(built, 2, "a second address needs a second agent");
    // rust: set_proxy(Some("http://127.0.0.1:7891".into()));
    // rust: keep("kept", Some("http://127.0.0.1:7891"), |_| {
    // rust: built += 1;
    // rust: ureq::AgentBuilder::new().build()
    // rust: });
    // rust: assert_eq!(built, 3, "a new setting drops the agents kept before it");
    // rust: set_proxy(None);
}
}
