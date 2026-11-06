//! Transpiled from Horizon Rust crate
//! Module: horizon-relay_limits
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Token buckets for request rates and relayed bandwidth, and the
//! per-address state behind them (kept in memory, forgotten after ten idle
//! minutes), and the hosts each address holds open.
// use std::{
    // rust: collections::{HashMap, VecDeque},
    // rust: net::{IpAddr, Ipv6Addr},
    // rust: time::{Duration, Instant},
}

/// A token bucket: `rate` tokens a second up to `burst`.
pub const Bucket = struct {
    tokens: f64,
    last: Instant,
    rate: f64,
    burst: f64,
};
    // rust: impl Bucket {
pub fn new(rate: f64, burst: f64, now: Instant) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: tokens: burst,
    // rust: last: now,
    // rust: rate,
    // rust: burst,
}
}
pub fn refill(self: *Self, now: Instant) void {
}
    // rust: let dt = now.saturating_duration_since(self.last).as_secs_f64();
    // rust: self.tokens = (self.tokens + dt * self.rate).min(self.burst);
    // rust: self.last = now;
}
    /// Take one token if there is one.
pub fn try_take(self: *Self, now: Instant) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.refill(now);
    // rust: if self.tokens >= 1.0 {
    // rust: self.tokens -= 1.0;
    // rust: true
    // rust: } else {
    // rust: false
}
}
pub fn has(self: *Self, now: Instant) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.refill(now);
    // rust: self.tokens >= 1.0
}
    /// Take `n` tokens, going into debt if needed; how long to wait before
    /// sending them so the average stays at the rate.
pub fn take(self: *Self, n: f64, now: Instant) D {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.refill(now);
    // rust: self.tokens -= n;
    // rust: if self.tokens >= 0.0 || self.rate <= 0.0 {
    // rust: Duration::ZERO
    // rust: } else {
    // rust: Duration::from_secs_f64(-self.tokens / self.rate)
}
}
}

/// Addresses are counted by IPv4 address and by IPv6 /64 (one home).
pub fn address_key(ip: IpAddr) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match ip {
    // rust: IpAddr::V6(v6) => match v6.to_ipv4_mapped() {
    // rust: Some(v4) => IpAddr::V4(v4),
    // rust: None => {
    // rust: let s = v6.segments();
    // rust: IpAddr::V6(std::net::Ipv6Addr::new(s[0], s[1], s[2], s[3], 0, 0, 0, 0))
}
    // rust: },
    // rust: v4 => v4,
}
}

pub const Rates = struct {
    register_per_min: f64,
    register_burst: f64,
    join_per_min: f64,
    join_burst: f64,
    /// Unknown codes an address may try in `unknown_window` before it is
    /// blocked for `block`.
    unknown_limit: usize,
    unknown_window: Duration,
    block: Duration,
    /// Hosts one address may hold open at once (`RELAY_MAX_HOSTS_PER_ADDRESS`);
    /// an IPv6 /48 (one site, 65536 homes) may hold [`SITE_HOSTS`] times as many.
    hosts_per_address: usize,
};
    // rust: impl Default for Rates {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: register_per_min: 6.0,
    // rust: register_burst: 3.0,
    // rust: join_per_min: 12.0,
    // rust: join_burst: 6.0,
    // rust: unknown_limit: 5,
    // rust: unknown_window: Duration::from_secs(600),
    // rust: block: Duration::from_secs(600),
    // rust: hosts_per_address: 4,
}
}
}

/// How many times an address's open hosts an IPv6 /48 may hold.
pub const SITE_HOSTS: usize = 4;

/// What open hosts are counted under: the address key, and for IPv6 also its
/// /48 with the larger cap. The prefix length keeps a /64 key and a /48 key
/// that print alike apart.
pub fn host_keys(ip: IpAddr, per_address: usize) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let key = address_key(ip);
    // rust: let mut keys = vec![((key, 64), per_address)];
    // rust: if let IpAddr::V6(v6) = key {
    // rust: let s = v6.segments();
    // rust: let site = IpAddr::V6(Ipv6Addr::new(s[0], s[1], s[2], 0, 0, 0, 0, 0));
    // rust: keys.push(((site, 48), per_address.saturating_mul(SITE_HOSTS)));
}
    // rust: keys
}

pub const Address = struct {
    register: Bucket,
    join: Bucket,
    unknown: VecDeque<Instant>,
    blocked_until: ?Instant,
    seen: Instant,
};

/// Per-address limits; disabled (everything allowed) when the relay can't
/// see client addresses.
pub const Limiter = struct {
    rates: Rates,
    enabled: bool,
    addresses: HashMap<IpAddr,
    last_sweep: Instant,
    /// Open hosts by address key (and IPv6 site); never swept, each count
    /// is given back by [`Limiter::close_host`].
    hosts: HashMap<(IpAddr,
};
    // rust: impl Limiter {
pub fn new(rates: Rates, enabled: bool) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: rates,
    // rust: enabled,
    // rust: addresses: HashMap::new(),
    // rust: last_sweep: Instant::now(),
    // rust: hosts: HashMap::new(),
}
}
    /// Count one more host open from `ip`, unless its address (or IPv6 site)
    /// holds as many as it may already.
pub fn open_host(self: *Self, ip: IpAddr) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.enabled {
    // rust: return true;
}
    // rust: let keys = host_keys(ip, self.rates.hosts_per_address);
    // rust: if keys
    // rust: .iter()
    // rust: .any(|(k, cap)| self.hosts.get(k).copied().unwrap_or(0) >= *cap)
    // rust: {
    // rust: return false;
}
    // rust: for (k, _) in keys {
    // rust: *self.hosts.entry(k).or_insert(0) += 1;
}
    // rust: true
}
    /// A host [`Limiter::open_host`] let in has gone.
pub fn close_host(self: *Self, ip: IpAddr) void {
}
    // rust: if !self.enabled {
    // rust: return;
}
    // rust: for (k, _) in host_keys(ip, self.rates.hosts_per_address) {
    // rust: if let Some(n) = self.hosts.get_mut(&k) {
    // rust: *n -= 1;
    // rust: if *n == 0 {
    // rust: self.hosts.remove(&k);
}
}
}
}
pub fn entry(self: *Self, ip: IpAddr, now: Instant) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if now.saturating_duration_since(self.last_sweep) > Duration::from_secs(60) {
    // rust: self.last_sweep = now;
    // rust: let keep = Duration::from_secs(600).max(self.rates.block);
    // rust: self.addresses.retain(|_, a| {
    // rust: now.saturating_duration_since(a.seen) < keep
    // rust: || a.blocked_until.is_some_and(|b| b > now)
    // rust: });
}
    // rust: let r = &self.rates;
    // rust: let a = self
    // rust: .addresses
    // rust: .entry(address_key(ip))
    // rust: .or_insert_with(|| Address {
    // rust: register: Bucket::new(r.register_per_min / 60.0, r.register_burst, now),
    // rust: join: Bucket::new(r.join_per_min / 60.0, r.join_burst, now),
    // rust: unknown: VecDeque::new(),
    // rust: blocked_until: None,
    // rust: seen: now,
    // rust: });
    // rust: a.seen = now;
    // rust: a
}
pub fn allow_register(self: *Self, ip: IpAddr, now: Instant) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !self.enabled || self.entry(ip, now).register.try_take(now)
}
pub fn allow_join(self: *Self, ip: IpAddr, now: Instant) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.enabled {
    // rust: return true;
}
    // rust: let a = self.entry(ip, now);
    // rust: if a.blocked_until.is_some_and(|b| b > now) {
    // rust: return false;
}
    // rust: a.blocked_until = None;
    // rust: a.join.try_take(now)
}
    /// An unknown code from this address; blocks it past the limit.
pub fn unknown(self: *Self, ip: IpAddr, now: Instant) void {
}
    // rust: if !self.enabled {
    // rust: return;
}
    // rust: let (limit, window, block) = (
    // rust: self.rates.unknown_limit,
    // rust: self.rates.unknown_window,
    // rust: self.rates.block,
    // rust: );
    // rust: let a = self.entry(ip, now);
    // rust: a.unknown.push_back(now);
    // rust: while a
    // rust: .unknown
    // rust: .front()
    // rust: .is_some_and(|t| now.saturating_duration_since(*t) > window)
    // rust: {
    // rust: a.unknown.pop_front();
}
    // rust: if a.unknown.len() >= limit {
    // rust: a.blocked_until = Some(now + block);
    // rust: a.unknown.clear();
}
}
pub fn tracked(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.addresses.len()
}
}

    // rust: mod tests {
//     use super::*;

pub fn buckets_refill_at_their_rate() void {
}
    // rust: let t = Instant::now();
    // rust: let mut b = Bucket::new(1.0, 2.0, t);
    // rust: assert!(b.try_take(t));
    // rust: assert!(b.try_take(t));
    // rust: assert!(!b.try_take(t));
    // rust: assert!(!b.try_take(t + Duration::from_millis(900)));
    // rust: assert!(b.try_take(t + Duration::from_millis(1000)));
        // Never above the burst.
    // rust: assert!(b.try_take(t + Duration::from_secs(100)));
    // rust: assert!(b.try_take(t + Duration::from_secs(100)));
    // rust: assert!(!b.try_take(t + Duration::from_secs(100)));
}

pub fn bandwidth_debt_turns_into_a_wait() void {
}
    // rust: let t = Instant::now();
    // rust: let mut b = Bucket::new(1000.0, 500.0, t);
    // rust: assert_eq!(b.take(500.0, t), Duration::ZERO);
    // rust: assert_eq!(b.take(1000.0, t), Duration::from_secs(1));
        // After the wait the debt is paid.
    // rust: assert_eq!(b.take(0.0, t + Duration::from_secs(1)), Duration::ZERO);
}

pub fn ipv6_counts_by_home() void {
}
    // rust: let a: IpAddr = "2001:db8:1:2:aaaa::1".parse().unwrap();
    // rust: let b: IpAddr = "2001:db8:1:2:bbbb::9".parse().unwrap();
    // rust: let c: IpAddr = "2001:db8:1:3::1".parse().unwrap();
    // rust: assert_eq!(address_key(a), address_key(b));
    // rust: assert_ne!(address_key(a), address_key(c));
    // rust: let mapped: IpAddr = "::ffff:203.0.113.7".parse().unwrap();
    // rust: assert_eq!(
    // rust: address_key(mapped),
    // rust: "203.0.113.7".parse::<IpAddr>().unwrap()
    // rust: );
}

pub fn unknown_codes_block_an_address_for_a_while() void {
}
    // rust: let t = Instant::now();
    // rust: let ip: IpAddr = "203.0.113.7".parse().unwrap();
    // rust: let other: IpAddr = "203.0.113.8".parse().unwrap();
    // rust: let mut l = Limiter::new(
    // rust: Rates {
    // rust: join_burst: 100.0,
    // rust: ..Rates::default()
    // rust: },
    // rust: true,
    // rust: );
    // rust: for _ in 0..4 {
    // rust: assert!(l.allow_join(ip, t));
    // rust: l.unknown(ip, t);
}
    // rust: assert!(l.allow_join(ip, t));
    // rust: l.unknown(ip, t);
    // rust: assert!(!l.allow_join(ip, t));
    // rust: assert!(!l.allow_join(ip, t + Duration::from_secs(599)));
    // rust: assert!(l.allow_join(other, t));
    // rust: assert!(l.allow_join(ip, t + Duration::from_secs(601)));
        // Unknown codes spread beyond the window don't add up.
    // rust: let mut l = Limiter::new(Rates::default(), true);
    // rust: for i in 0..10 {
    // rust: l.unknown(ip, t + Duration::from_secs(i * 200));
}
    // rust: assert!(l.allow_join(ip, t + Duration::from_secs(2000)));
}

pub fn open_hosts_per_address_and_ipv6_site() void {
}
    // rust: let ip = |s: &str| s.parse::<IpAddr>().unwrap();
    // rust: let mut l = Limiter::new(
    // rust: Rates {
    // rust: hosts_per_address: 2,
    // rust: ..Rates::default()
    // rust: },
    // rust: true,
    // rust: );
    // rust: let v4 = ip("198.51.100.1");
    // rust: assert!(l.open_host(v4) && l.open_host(v4));
    // rust: assert!(!l.open_host(v4));
    // rust: assert!(l.open_host(ip("198.51.100.2")), "another address");
    // rust: l.close_host(v4);
    // rust: assert!(l.open_host(v4));
        // IPv6: 2 per /64, 8 per /48 however many /64s it spreads over.
    // rust: let mut opened = 0;
    // rust: for home in 0..10 {
    // rust: for _ in 0..2 {
    // rust: opened += usize::from(l.open_host(ip(&format!("2001:db8:7:{home}::1"))));
}
}
    // rust: assert_eq!(opened, 2 * SITE_HOSTS);
    // rust: assert!(l.open_host(ip("2001:db8:8::1")), "another site");
    // rust: l.close_host(ip("2001:db8:7:1::1"));
    // rust: assert!(
    // rust: !l.open_host(ip("2001:db8:7:0::1")),
    // rust: "that home is still full"
    // rust: );
    // rust: assert!(l.open_host(ip("2001:db8:7:9::1")));
        // Off when the relay can't see client addresses.
    // rust: let mut off = Limiter::new(Rates::default(), false);
    // rust: assert!((0..100).all(|_| off.open_host(v4)));
}

pub fn join_and_register_rates() void {
}
    // rust: let t = Instant::now();
    // rust: let ip: IpAddr = "198.51.100.1".parse().unwrap();
    // rust: let mut l = Limiter::new(Rates::default(), true);
    // rust: assert_eq!((0..10).filter(|_| l.allow_register(ip, t)).count(), 3);
    // rust: assert_eq!((0..10).filter(|_| l.allow_join(ip, t)).count(), 6);
    // rust: assert!(l.allow_join(ip, t + Duration::from_secs(5)));
    // rust: let mut off = Limiter::new(Rates::default(), false);
    // rust: assert!((0..100).all(|_| off.allow_join(ip, t)));
    // rust: assert_eq!(off.tracked(), 0);
}
}
