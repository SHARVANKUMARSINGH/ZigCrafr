//! Transpiled from Horizon Rust crate
//! Module: horizon-friends_reach
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! How a host can be reached, worked out on its own: its interface
//! addresses (LAN, VPNs such as Tailscale or ZeroTier, IPv6), a port opened
//! on the router (PCP / NAT-PMP / UPnP), and its public address from STUN.
//! The endpoints go into the invite code; the verdict tells the host what
//! friends outside its network can expect, and what to do when it's nothing.
// use crate::portmap::{self, Mapping};
// use std::{
    // rust: net::{IpAddr, Ipv4Addr, SocketAddr},
    // rust: time::Duration,
}

/// Where the troubleshooting lives (shown to hosts nobody can reach).
    // rust: pub const HELP_URL: &str =
    // rust: "https://github.com/horizon-rust/horizon/blob/main/docs/play-with-friends.md#troubleshooting";

pub const Options = struct {
    /// Ask the router to open the port.
    map_port: bool,
    stun: std.ArrayList([]const u8),
    /// Offer 127.0.0.1 too (tests with both ends on one machine).
    loopback: bool,
};

pub const Reach = struct {
    port: u16,
    local: std.ArrayList(IpAddr),
    mapping: ?Mapping,
    mapping_error: ?[]const u8,
    public_ip: ?IpAddr,
};

pub const Verdict = enum {
    /// The router opened the port (method name).
    Mapped(&'static str),
    /// This machine has the public address itself.
    Public,
    /// Only the LAN and VPNs reach it; `cgnat` when the router is itself
    /// behind another NAT (the provider's, or a second router), so port
    /// forwarding on it can't help.
    LocalOnly { cgnat: bool },
};

/// 100.64.0.0/10 (carrier-grade NAT, also Tailscale's range) or private.
pub fn shared(ip: IpAddr) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match ip {
    // rust: IpAddr::V4(v4) => {
    // rust: let o = v4.octets();
    // rust: v4.is_private() || (o[0] == 100 && (64..128).contains(&o[1]))
}
    // rust: IpAddr::V6(_) => false,
}
}

/// Interface names of containers and VMs, whose addresses nobody else reaches.
pub fn virtual_interface(name: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [
    // rust: "docker", "br-", "veth", "virbr", "vboxnet", "vmnet", "lxc", "cni", "podman",
    // rust: ]
    // rust: .iter()
    // rust: .any(|p| name.starts_with(p))
}

/// This machine's addresses worth offering, best first: private IPv4 (the
/// LAN), shared IPv4 (Tailscale's 100.64/10, CGNAT), other IPv4, one global
/// IPv6. No link-local or unique-local; loopback on request.
pub fn interface_addresses(loopback: bool) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut found: Vec<(u8, IpAddr)> = Vec::new();
    // rust: for i in if_addrs::get_if_addrs().unwrap_or_default() {
    // rust: if virtual_interface(&i.name) {
    // rust: continue;
}
    // rust: let ip = i.ip();
    // rust: let rank = match ip {
    // rust: IpAddr::V4(v4) if v4.is_loopback() => {
    // rust: if loopback {
    // rust: 6
    // rust: } else {
    // rust: continue;
}
}
    // rust: IpAddr::V4(v4) if v4.is_link_local() || v4.is_unspecified() => continue,
    // rust: IpAddr::V4(v4) if v4.is_private() => 0,
    // rust: v4 @ IpAddr::V4(_) if shared(v4) => 1,
    // rust: IpAddr::V4(_) => 2,
    // rust: IpAddr::V6(v6) if v6.is_loopback() || v6.is_unspecified() => continue,
            // fe80::/10.
    // rust: IpAddr::V6(v6) if v6.segments()[0] & 0xffc0 == 0xfe80 => continue,
            // fc00::/7: VPNs that use it (Tailscale) also give an IPv4 address.
    // rust: IpAddr::V6(v6) if v6.segments()[0] & 0xfe00 == 0xfc00 => continue,
    // rust: IpAddr::V6(_) => 3,
}
    // rust: if !found.iter().any(|(_, a)| *a == ip) {
    // rust: found.push((rank, ip));
}
}
    // rust: found.sort_by_key(|(r, _)| *r);
    // One global IPv6 address is enough (temporary addresses multiply
    // them), and one address per /24 (Wi-Fi and Ethernet on the same LAN).
    // rust: let mut out: Vec<IpAddr> = Vec::new();
    // rust: for (_, ip) in found {
    // rust: let same = out.iter().any(|o| match (o, ip) {
    // rust: (IpAddr::V6(_), IpAddr::V6(_)) => true,
    // rust: (IpAddr::V4(a), IpAddr::V4(b)) => a.octets()[..3] == b.octets()[..3],
    // rust: _ => false,
    // rust: });
    // rust: if !same {
    // rust: out.push(ip);
}
}
    // rust: out
}

    // rust: impl Reach {
    /// Find out (takes a few seconds: router discovery and STUN).
pub fn discover(port: u16, options: *Options) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let local = interface_addresses(options.loopback);
    // rust: let stun = {
    // rust: let servers = options.stun.clone();
    // rust: std::thread::spawn(move || crate::stun::public_ip(&servers, Duration::from_secs(2)))
}
    // rust: let (mapping, mapping_error) = if options.map_port {
    // rust: match local.iter().find_map(|ip| match ip {
    // rust: IpAddr::V4(v4) if v4.is_private() => Some(*v4),
    // rust: _ => None,
    // rust: }) {
    // rust: Some(client) => {
    // rust: let targets = portmap::Targets::discover(Duration::from_millis(1500));
    // rust: match portmap::map(&targets, client, port, portmap::LEASE) {
    // rust: Ok(m) => (Some(m), None),
    // rust: Err(e) => (None, Some(e)),
}
}
    // rust: None => (
    // rust: None,
    // rust: Some("no private IPv4 address (no router to ask)".into()),
    // rust: ),
}
    // rust: } else {
    // rust: (None, Some("port mapping is off".into()))
}
    // rust: let public_ip = stun.join().ok().flatten();
    // rust: Self {
    // rust: port,
    // rust: local,
    // rust: mapping,
    // rust: mapping_error,
    // rust: public_ip,
}
}

    /// The router's public side, with the WAN address from STUN when the
    /// router didn't give one.
pub fn mapped_endpoint(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let m = self.mapping.as_ref()?;
    // rust: let ip = if m.external.ip().is_unspecified() {
    // rust: self.public_ip?
    // rust: } else {
    // rust: m.external.ip()
}
    // rust: Some(SocketAddr::new(ip, m.external.port()))
}

pub fn verdict(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(m) = &self.mapping {
    // rust: let wan = m.external.ip();
            // The router's own WAN side is shared or private, or STUN sees
            // another address: a second NAT upstream.
    // rust: let behind = (!wan.is_unspecified() && shared(wan))
    // rust: || self
    // rust: .public_ip
    // rust: .is_some_and(|p| !wan.is_unspecified() && p != wan);
    // rust: if !behind {
    // rust: return Verdict::Mapped(m.method.name());
}
    // rust: return Verdict::LocalOnly { cgnat: true };
}
    // rust: if let Some(p) = self.public_ip
    // rust: && self.local.contains(&p)
    // rust: {
    // rust: return Verdict::Public;
}
    // rust: Verdict::LocalOnly { cgnat: false }
}

    /// The code's endpoints, best first: the router mapping (or this
    /// machine's own public address), then the public address on the
    /// direct port (works once the port is forwarded by hand), then the
    /// interface addresses.
pub fn endpoints(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Vec::new();
    // rust: let mut push = |a: SocketAddr| {
    // rust: if !out.contains(&a) {
    // rust: out.push(a);
}
}
    // rust: if let Some(m) = self.mapped_endpoint() {
    // rust: push(m);
}
    // rust: if let Some(p) = self.public_ip {
    // rust: push(SocketAddr::new(p, self.port));
}
    // rust: for ip in &self.local {
    // rust: push(SocketAddr::new(*ip, self.port));
}
    // rust: out.truncate(crate::invite::MAX_ENDPOINTS);
    // rust: out
}

    /// The LAN address a port forward should point at.
pub fn lan_ip(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.local.iter().find_map(|ip| match ip {
    // rust: IpAddr::V4(v4) if v4.is_private() => Some(*v4),
    // rust: _ => None,
    // rust: })
}

    /// What the host reads under the code.
pub fn summary(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.verdict() {
    // rust: Verdict::Mapped(method) => {
    // rust: let at = self.mapped_endpoint().map(|a| format!(" ({a})")).unwrap_or_default();
    // rust: format!("Friends anywhere can join: your router opened the port with {method}{at}.")
}
    // rust: Verdict::Public => format!(
    // rust: "Friends anywhere can join: this computer has a public address (TCP port {} must not be blocked by a firewall).",
    // rust: self.port
    // rust: ),
    // rust: Verdict::LocalOnly { cgnat: true } => "Friends on your network or VPN can join. From the internet they can't: \
    // rust: your router is itself behind another NAT (your provider's carrier-grade NAT, CGNAT, or a second router), \
    // rust: so opening its port isn't enough. Use a relay or a VPN such as Tailscale or ZeroTier."
    // rust: .to_owned(),
    // rust: Verdict::LocalOnly { cgnat: false } => {
    // rust: let forward = match self.lan_ip() {
    // rust: Some(ip) => format!("forward TCP port {} to {ip}", self.port),
    // rust: None => format!("forward TCP port {}", self.port),
}
    // rust: format!(
    // rust: "Friends on your network or VPN can join. For friends on the internet: turn on UPnP on your router, \
    // rust: or {forward}, or use a relay, or a VPN such as Tailscale or ZeroTier (the code already holds \
    // rust: your VPN address)."
    // rust: )
}
}
}

    /// Delete the router mapping.
pub fn release(self: *Self) void {
}
    // rust: if let Some(m) = self.mapping.take() {
    // rust: m.remove();
}
}
}

    // rust: mod tests {
//     use super::*;

pub fn reach(public: ?[]const u8, local: *[[]const u8]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Reach {
    // rust: port: 25580,
    // rust: local: local.iter().map(|s| s.parse().unwrap()).collect(),
    // rust: mapping: None,
    // rust: mapping_error: Some("no router answered".into()),
    // rust: public_ip: public.map(|s| s.parse().unwrap()),
}
}

pub fn endpoints_put_the_public_side_first() void {
}
    // rust: let r = reach(
    // rust: Some("203.0.113.5"),
    // rust: &["192.168.1.20", "100.72.51.8", "2001:db8::20"],
    // rust: );
    // rust: assert_eq!(
    // rust: r.endpoints(),
    // rust: [
    // rust: "203.0.113.5:25580",
    // rust: "192.168.1.20:25580",
    // rust: "100.72.51.8:25580",
    // rust: "[2001:db8::20]:25580"
    // rust: ]
    // rust: .map(|s| s.parse::<SocketAddr>().unwrap())
    // rust: );
    // rust: assert_eq!(r.verdict(), Verdict::LocalOnly { cgnat: false });
    // rust: let s = r.summary();
    // rust: assert!(
    // rust: s.contains("forward TCP port 25580 to 192.168.1.20") && s.contains("Tailscale"),
    // rust: "{s}"
    // rust: );
}

pub fn a_public_address_on_this_machine() void {
}
    // rust: let r = reach(Some("203.0.113.5"), &["203.0.113.5"]);
    // rust: assert_eq!(r.verdict(), Verdict::Public);
    // rust: assert_eq!(
    // rust: r.endpoints(),
    // rust: vec!["203.0.113.5:25580".parse::<SocketAddr>().unwrap()]
    // rust: );
}

pub fn a_router_mapping_and_what_is_behind_it() void {
}
//         use crate::portmap::{Mapping, Method};
    // rust: let mut r = reach(Some("203.0.113.5"), &["192.168.1.20"]);
    // rust: r.mapping = Some(Mapping::granted(
    // rust: Method::Upnp,
    // rust: "203.0.113.5:40123".parse().unwrap(),
    // rust: ));
    // rust: assert_eq!(r.verdict(), Verdict::Mapped("UPnP"));
    // rust: assert_eq!(
    // rust: r.endpoints()[0],
    // rust: "203.0.113.5:40123".parse::<SocketAddr>().unwrap()
    // rust: );
    // rust: assert!(r.summary().contains("UPnP (203.0.113.5:40123)"));
        // The router didn't say its address: STUN's is used.
    // rust: r.mapping = Some(Mapping::granted(
    // rust: Method::NatPmp,
    // rust: "0.0.0.0:40123".parse().unwrap(),
    // rust: ));
    // rust: assert_eq!(
    // rust: r.endpoints()[0],
    // rust: "203.0.113.5:40123".parse::<SocketAddr>().unwrap()
    // rust: );
        // The router's WAN side is in the carrier's shared range: CGNAT.
    // rust: r.mapping = Some(Mapping::granted(
    // rust: Method::Pcp,
    // rust: "100.80.1.2:40123".parse().unwrap(),
    // rust: ));
    // rust: assert_eq!(r.verdict(), Verdict::LocalOnly { cgnat: true });
    // rust: assert!(r.summary().contains("CGNAT"));
        // STUN sees another address than the router's: a second NAT.
    // rust: r.mapping = Some(Mapping::granted(
    // rust: Method::Pcp,
    // rust: "198.51.100.1:40123".parse().unwrap(),
    // rust: ));
    // rust: assert_eq!(r.verdict(), Verdict::LocalOnly { cgnat: true });
}

pub fn shared_ranges() void {
}
    // rust: assert!(shared("100.72.51.8".parse().unwrap()));
    // rust: assert!(shared("10.1.2.3".parse().unwrap()));
    // rust: assert!(!shared("100.128.0.1".parse().unwrap()));
    // rust: assert!(!shared("8.8.8.8".parse().unwrap()));
    // rust: assert!(
    // rust: virtual_interface("docker0")
    // rust: && !virtual_interface("tailscale0")
    // rust: && !virtual_interface("en0")
    // rust: );
}

pub fn interface_addresses_skip_loopback_unless_asked() void {
}
    // rust: assert!(interface_addresses(false).iter().all(|a| !a.is_loopback()));
    // rust: assert!(interface_addresses(true).contains(&IpAddr::V4(Ipv4Addr::LOCALHOST)));
}
}
