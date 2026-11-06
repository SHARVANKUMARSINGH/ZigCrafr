//! Transpiled from Horizon Rust crate
//! Module: horizon-friends_portmap
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Opening the host's direct port on the home router, for a limited time:
//! PCP (RFC 6887), then NAT-PMP (RFC 6886) on the gateway's port 5351, then
//! UPnP IGD (SSDP discovery, then SOAP `AddPortMapping`). The mapping is
//! renewed while sharing and deleted when it stops; a crashed game's mapping
//! expires with its lease.
// use std::{
    // rust: io::{self, Read, Write},
    // rust: net::{IpAddr, Ipv4Addr, Ipv6Addr, SocketAddr, TcpStream, ToSocketAddrs, UdpSocket},
    // rust: time::{Duration, Instant},
}

/// How long a mapping is asked for; it is renewed at half-time.
pub const LEASE: Duration = Duration::from_secs(3600);
pub const PMP_PORT: u16 = 5351;
pub const DESCRIPTION: []const u8 = "Horizon (play with friends)";

pub const Method = enum {
    Pcp,
    NatPmp,
    Upnp,
};
    // rust: impl Method {
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Pcp => "PCP",
    // rust: Self::NatPmp => "NAT-PMP",
    // rust: Self::Upnp => "UPnP",
}
}
}

pub const Handle = enum {
    Pmp {,
    gateway: SocketAddr,
    client: Ipv4Addr,
    nonce: [u8; 12],
    // rust: },
    NatPmp {,
    gateway: SocketAddr,
    // rust: },
    Upnp {,
    igd: Igd,
    client: Ipv4Addr,
    permanent: bool,
    // rust: },
};

/// A port opened on the router.
pub const Mapping = struct {
    method: Method,
    internal: u16,
    /// The router's public side: its WAN address (unspecified when the
    /// router didn't say) and the external port.
    external: SocketAddr,
    lifetime: Duration,
    renewed: Instant,
    handle: Handle,
};

/// Where to ask: gateways speaking PCP/NAT-PMP, UPnP description URLs.
pub const Targets = struct {
    pmp: std.ArrayList(SocketAddr),
    upnp: std.ArrayList([]const u8),
};
    // rust: impl Targets {
    /// The default gateway's port 5351, and the IGDs answering SSDP.
pub fn discover(timeout: Duration) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut pmp: Vec<SocketAddr> = default_gateway()
    // rust: .into_iter()
    // rust: .map(|g| SocketAddr::new(IpAddr::V4(g), PMP_PORT))
    // rust: .collect();
    // rust: let upnp = ssdp_discover(timeout);
        // An IGD's own address is a gateway too.
    // rust: for l in &upnp {
    // rust: if let Some((host, _, _)) = split_url(l)
    // rust: && let Ok(ip) = host.parse::<Ipv4Addr>()
    // rust: {
    // rust: let a = SocketAddr::new(IpAddr::V4(ip), PMP_PORT);
    // rust: if !pmp.contains(&a) {
    // rust: pmp.push(a);
}
}
}
    // rust: Self { pmp, upnp }
}
}

/// Open `internal` on the router for `client` (this machine's LAN address),
/// trying each method in turn. The error lists why each failed.
    // rust: pub fn map(
    // rust: targets: &Targets,
    // rust: client: Ipv4Addr,
    // rust: internal: u16,
    // rust: lease: Duration,
    // rust: ) -> Result<Mapping, String> {
    // rust: let mut why = Vec::new();
    // rust: for &gw in &targets.pmp {
    // rust: let mut nonce = [0u8; 12];
    // rust: let _ = crate::fill_random(&mut nonce);
    // rust: match pcp_map(gw, client, internal, internal, lease, &nonce) {
    // rust: Ok((external, life)) => {
    // rust: return Ok(Mapping {
    // rust: method: Method::Pcp,
    // rust: internal,
    // rust: external,
    // rust: lifetime: life,
    // rust: renewed: Instant::now(),
    // rust: handle: Handle::Pmp {
    // rust: gateway: gw,
    // rust: client,
    // rust: nonce,
    // rust: },
    // rust: });
}
    // rust: Err(e) => why.push(format!("PCP: {e}")),
}
    // rust: match natpmp_map(gw, internal, internal, lease) {
    // rust: Ok((port, life)) => {
    // rust: let ip = natpmp_external(gw).map_or(IpAddr::V4(Ipv4Addr::UNSPECIFIED), IpAddr::V4);
    // rust: return Ok(Mapping {
    // rust: method: Method::NatPmp,
    // rust: internal,
    // rust: external: SocketAddr::new(ip, port),
    // rust: lifetime: life,
    // rust: renewed: Instant::now(),
    // rust: handle: Handle::NatPmp { gateway: gw },
    // rust: });
}
    // rust: Err(e) => why.push(format!("NAT-PMP: {e}")),
}
}
    // rust: for location in &targets.upnp {
    // rust: match Igd::from_location(location).and_then(|igd| upnp_map(igd, client, internal, lease)) {
    // rust: Ok(m) => return Ok(m),
    // rust: Err(e) => why.push(format!("UPnP: {e}")),
}
}
    // rust: if why.is_empty() {
    // rust: why.push("no router answered".into());
}
    // rust: Err(why.join("; "))
}

pub fn upnp_map(igd: Igd, client: Ipv4Addr, internal: u16, lease: Duration) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut permanent = false;
    // rust: let mut last = io::Error::other("no port");
    // The same port outside first (easy to forward by hand later), then others.
    // rust: let mut ports = vec![internal];
    // rust: let mut r = [0u8; 2];
    // rust: for _ in 0..3 {
    // rust: let _ = crate::fill_random(&mut r);
    // rust: ports.push(20000 + u16::from_le_bytes(r) % 40000);
}
    // rust: for port in ports {
    // rust: let secs = if permanent { 0 } else { lease.as_secs() as u32 };
    // rust: match igd.add(port, internal, client, secs) {
    // rust: Ok(()) => {
    // rust: let ip = igd
    // rust: .external_ip()
    // rust: .unwrap_or(IpAddr::V4(Ipv4Addr::UNSPECIFIED));
    // rust: return Ok(Mapping {
    // rust: method: Method::Upnp,
    // rust: internal,
    // rust: external: SocketAddr::new(ip, port),
    // rust: lifetime: if permanent { LEASE } else { lease },
    // rust: renewed: Instant::now(),
    // rust: handle: Handle::Upnp {
    // rust: igd,
    // rust: client,
    // rust: permanent,
    // rust: },
    // rust: });
}
            // OnlyPermanentLeasesSupported: ask without a lease (deleted on stop).
    // rust: Err(UpnpError::Code(725)) if !permanent => {
    // rust: permanent = true;
    // rust: match igd.add(port, internal, client, 0) {
    // rust: Ok(()) => {
    // rust: let ip = igd
    // rust: .external_ip()
    // rust: .unwrap_or(IpAddr::V4(Ipv4Addr::UNSPECIFIED));
    // rust: return Ok(Mapping {
    // rust: method: Method::Upnp,
    // rust: internal,
    // rust: external: SocketAddr::new(ip, port),
    // rust: lifetime: LEASE,
    // rust: renewed: Instant::now(),
    // rust: handle: Handle::Upnp {
    // rust: igd,
    // rust: client,
    // rust: permanent,
    // rust: },
    // rust: });
}
    // rust: Err(e) => last = e.into(),
}
}
            // ConflictInMappingEntry and friends: another port.
    // rust: Err(UpnpError::Code(c)) => last = io::Error::other(format!("error {c}")),
    // rust: Err(UpnpError::Io(e)) => return Err(e),
}
}
    // rust: Err(last)
}

    // rust: impl Mapping {
    /// A mapping as a router would have granted it (tests elsewhere).
    // rust: pub(crate) fn granted(method: Method, external: SocketAddr) -> Self {
    // rust: Self {
    // rust: method,
    // rust: internal: 25580,
    // rust: external,
    // rust: lifetime: LEASE,
    // rust: renewed: Instant::now(),
    // rust: handle: Handle::NatPmp {
    // rust: gateway: SocketAddr::from(([127, 0, 0, 1], 9)),
    // rust: },
}
}
    /// Whether the lease is past half-time.
pub fn due(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.renewed.elapsed() >= self.lifetime / 2
}
pub fn renew(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let internal = self.internal;
    // rust: let lease = LEASE;
    // rust: match &self.handle {
    // rust: Handle::Pmp {
    // rust: gateway,
    // rust: client,
    // rust: nonce,
    // rust: } => {
    // rust: let (external, life) = pcp_map(
    // rust: *gateway,
    // rust: *client,
    // rust: internal,
    // rust: self.external.port(),
    // rust: lease,
    // rust: nonce,
    // rust: )?;
    // rust: self.external = external;
    // rust: self.lifetime = life;
}
    // rust: Handle::NatPmp { gateway } => {
    // rust: let (port, life) = natpmp_map(*gateway, internal, self.external.port(), lease)?;
    // rust: self.external.set_port(port);
    // rust: self.lifetime = life;
}
    // rust: Handle::Upnp {
    // rust: igd,
    // rust: client,
    // rust: permanent,
    // rust: } => {
    // rust: let secs = if *permanent {
    // rust: 0
    // rust: } else {
    // rust: lease.as_secs() as u32
}
    // rust: igd.add(self.external.port(), internal, *client, secs)?;
}
}
    // rust: self.renewed = Instant::now();
    // rust: Ok(())
}
    /// Delete the mapping (best effort).
pub fn remove(self: *Self) void {
}
    // rust: match &self.handle {
    // rust: Handle::Pmp {
    // rust: gateway,
    // rust: client,
    // rust: nonce,
    // rust: } => {
    // rust: let _ = pcp_map(*gateway, *client, self.internal, 0, Duration::ZERO, nonce);
}
    // rust: Handle::NatPmp { gateway } => {
    // rust: let _ = natpmp_map(*gateway, self.internal, 0, Duration::ZERO);
}
    // rust: Handle::Upnp { igd, .. } => {
    // rust: let _ = igd.delete(self.external.port());
}
}
}
}

// ----- PCP and NAT-PMP --------------------------------------------------------------------------

/// Send `req` and wait for a datagram from the gateway, with RFC 6886's
/// retransmissions (250 ms, doubling), three tries.
pub fn exchange(gateway: SocketAddr, req: []const u8) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let socket = UdpSocket::bind("0.0.0.0:0")?;
    // rust: socket.connect(gateway)?;
    // rust: let mut wait = Duration::from_millis(250);
    // rust: let mut buf = [0u8; 1100];
    // rust: for _ in 0..3 {
    // rust: socket.send(req)?;
    // rust: socket.set_read_timeout(Some(wait))?;
    // rust: match socket.recv(&mut buf) {
    // rust: Ok(n) => return Ok(buf[..n].to_vec()),
    // rust: Err(e) if e.kind() == io::ErrorKind::ConnectionRefused => return Err(e),
    // rust: Err(_) => wait *= 2,
}
}
    // rust: Err(io::Error::new(io::ErrorKind::TimedOut, "no answer"))
}

pub fn mapped_v6(ip: Ipv4Addr) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ip.to_ipv6_mapped().octets()
}

/// PCP MAP for TCP: the external address and the granted lifetime. A
/// zero lifetime deletes.
    // rust: pub fn pcp_map(
    // rust: gateway: SocketAddr,
    // rust: client: Ipv4Addr,
    // rust: internal: u16,
    // rust: external: u16,
    // rust: lease: Duration,
    // rust: nonce: &[u8; 12],
    // rust: ) -> io::Result<(SocketAddr, Duration)> {
    // rust: let mut req = vec![0u8; 60];
    // rust: req[0] = 2;
    // rust: req[1] = 1;
    // rust: req[4..8].copy_from_slice(&(lease.as_secs() as u32).to_be_bytes());
    // rust: req[8..24].copy_from_slice(&mapped_v6(client));
    // rust: req[24..36].copy_from_slice(nonce);
    // rust: req[36] = 6;
    // rust: req[40..42].copy_from_slice(&internal.to_be_bytes());
    // rust: req[42..44].copy_from_slice(&external.to_be_bytes());
    // rust: req[44..60].copy_from_slice(&mapped_v6(Ipv4Addr::UNSPECIFIED));
    // rust: let r = exchange(gateway, &req)?;
    // rust: if r.len() < 2 || r[0] != 2 {
    // rust: return Err(io::Error::other("not a PCP router"));
}
    // rust: if r.len() < 60 || r[1] != 0x81 || &r[24..36] != nonce {
    // rust: return Err(io::Error::other("bad answer"));
}
    // rust: if r[3] != 0 {
    // rust: return Err(io::Error::other(format!("result {}", r[3])));
}
    // rust: let life = Duration::from_secs(u64::from(u32::from_be_bytes(r[4..8].try_into().unwrap())));
    // rust: let port = u16::from_be_bytes([r[42], r[43]]);
    // rust: let o: [u8; 16] = r[44..60].try_into().unwrap();
    // rust: let v6 = Ipv6Addr::from(o);
    // rust: let ip = v6.to_ipv4_mapped().map_or(IpAddr::V6(v6), IpAddr::V4);
    // rust: Ok((SocketAddr::new(ip, port), life))
}

/// NAT-PMP's external address request.
pub fn natpmp_external(gateway: SocketAddr) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let r = exchange(gateway, &[0, 0])?;
    // rust: if r.len() < 12 || r[0] != 0 || r[1] != 128 {
    // rust: return Err(io::Error::other("bad answer"));
}
    // rust: if r[2..4] != [0, 0] {
    // rust: return Err(io::Error::other(format!(
    // rust: "result {}",
    // rust: u16::from_be_bytes([r[2], r[3]])
    // rust: )));
}
    // rust: Ok(Ipv4Addr::new(r[8], r[9], r[10], r[11]))
}

/// NAT-PMP TCP mapping: the external port and lifetime. Zero deletes.
    // rust: pub fn natpmp_map(
    // rust: gateway: SocketAddr,
    // rust: internal: u16,
    // rust: external: u16,
    // rust: lease: Duration,
    // rust: ) -> io::Result<(u16, Duration)> {
    // rust: let mut req = [0u8; 12];
    // rust: req[1] = 2;
    // rust: req[4..6].copy_from_slice(&internal.to_be_bytes());
    // rust: req[6..8].copy_from_slice(&external.to_be_bytes());
    // rust: req[8..12].copy_from_slice(&(lease.as_secs() as u32).to_be_bytes());
    // rust: let r = exchange(gateway, &req)?;
    // rust: if r.len() < 16 || r[0] != 0 || r[1] != 130 {
    // rust: return Err(io::Error::other("not a NAT-PMP router"));
}
    // rust: if r[2..4] != [0, 0] {
    // rust: return Err(io::Error::other(format!(
    // rust: "result {}",
    // rust: u16::from_be_bytes([r[2], r[3]])
    // rust: )));
}
    // rust: Ok((
    // rust: u16::from_be_bytes([r[10], r[11]]),
    // rust: Duration::from_secs(u64::from(u32::from_be_bytes(r[12..16].try_into().unwrap()))),
    // rust: ))
}

// ----- UPnP IGD ---------------------------------------------------------------------------------

/// `http://host:port/path` → host, port, path.
pub fn split_url(url: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let rest = url.strip_prefix("http://")?;
    // rust: let (hostport, path) = match rest.find('/') {
    // rust: Some(i) => (&rest[..i], &rest[i..]),
    // rust: None => (rest, "/"),
}
    // `[v6]` or `[v6]:port`: the colons inside the brackets are not a port's.
    // rust: let (host, port) = match hostport.rfind(']') {
    // rust: Some(i) => match &hostport[i + 1..] {
    // rust: "" => (&hostport[..=i], 80),
    // rust: p => (&hostport[..=i], p.strip_prefix(':')?.parse().ok()?),
    // rust: },
    // rust: None => match hostport.rsplit_once(':') {
    // rust: Some((h, p)) => (h, p.parse().ok()?),
    // rust: None => (hostport, 80),
    // rust: },
}
    // rust: Some((
    // rust: host.trim_matches(|c| c == '[' || c == ']').to_owned(),
    // rust: port,
    // rust: path.to_owned(),
    // rust: ))
}

/// A tiny HTTP/1.1 client (Connection: close; Content-Length, chunked or
/// to the end).
    // rust: fn http(
    // rust: method: &str,
    // rust: url: &str,
    // rust: headers: &[(&str, &str)],
    // rust: body: &str,
    // rust: ) -> io::Result<(u16, String)> {
    // rust: let (host, port, path) = split_url(url).ok_or_else(|| io::Error::other("bad URL"))?;
    // rust: let addr = (host.as_str(), port)
    // rust: .to_socket_addrs()?
    // rust: .next()
    // rust: .ok_or_else(|| io::Error::other("no address"))?;
    // rust: let mut s = TcpStream::connect_timeout(&addr, Duration::from_secs(3))?;
    // rust: s.set_read_timeout(Some(Duration::from_secs(5)))?;
    // rust: let mut req = format!(
    // rust: "{method} {path} HTTP/1.1\r\nHost: {host}:{port}\r\nConnection: close\r\nContent-Length: {}\r\n",
    // rust: body.len()
    // rust: );
    // rust: for (k, v) in headers {
    // rust: req.push_str(&format!("{k}: {v}\r\n"));
}
    // rust: req.push_str("\r\n");
    // rust: req.push_str(body);
    // rust: s.write_all(req.as_bytes())?;
    // rust: let mut raw = Vec::new();
    // rust: s.take(1 << 20).read_to_end(&mut raw)?;
    // rust: let text = String::from_utf8_lossy(&raw).into_owned();
    // rust: let (head, rest) = text
    // rust: .split_once("\r\n\r\n")
    // rust: .ok_or_else(|| io::Error::other("bad response"))?;
    // rust: let status = head
    // rust: .split_whitespace()
    // rust: .nth(1)
    // rust: .and_then(|c| c.parse().ok())
    // rust: .ok_or_else(|| io::Error::other("bad status"))?;
    // rust: let chunked = head.lines().any(|l| {
    // rust: let l = l.to_ascii_lowercase();
    // rust: l.starts_with("transfer-encoding:") && l.contains("chunked")
    // rust: });
    // rust: let body = if chunked {
    // rust: dechunk(rest)
    // rust: } else {
    // rust: rest.to_owned()
}
    // rust: Ok((status, body))
}
pub fn dechunk(mut s: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = String::new();
    // rust: while let Some((size, rest)) = s.split_once("\r\n") {
    // rust: let Ok(n) = usize::from_str_radix(size.split(';').next().unwrap_or("").trim(), 16) else {
    // rust: break;
}
    // rust: if n == 0 || rest.len() < n {
    // rust: break;
}
    // rust: out.push_str(&rest[..n]);
    // rust: s = rest[n..].trim_start_matches("\r\n");
}
    // rust: out
}

/// The text of the first `<tag>` (any namespace prefix) in `xml`.
    // rust: fn tag<'a>(xml: &'a str, name: &str) -> Option<&'a str> {
    // rust: let mut from = 0;
    // rust: while let Some(i) = xml[from..].find('<') {
    // rust: let start = from + i + 1;
    // rust: let end = start + xml[start..].find('>')?;
    // rust: let open = &xml[start..end];
    // rust: let local = open.split_whitespace().next().unwrap_or("");
    // rust: let local = local.rsplit(':').next().unwrap_or(local);
    // rust: if local == name && !open.starts_with('/') {
    // rust: let body = &xml[end + 1..];
    // rust: let close = body.find("</")?;
    // rust: return Some(body[..close].trim());
}
    // rust: from = end + 1;
}
    // rust: None
}

/// The Location headers of SSDP answers (devices answering an M-SEARCH for
/// internet gateways).
pub fn ssdp_discover(timeout: Duration) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Ok(s) = UdpSocket::bind("0.0.0.0:0") else {
    // rust: return Vec::new();
}
    // rust: let _ = s.set_read_timeout(Some(Duration::from_millis(200)));
    // rust: for st in [
    // rust: "urn:schemas-upnp-org:device:InternetGatewayDevice:1",
    // rust: "urn:schemas-upnp-org:device:InternetGatewayDevice:2",
    // rust: "urn:schemas-upnp-org:service:WANIPConnection:1",
    // rust: ] {
    // rust: let m = format!(
    // rust: "M-SEARCH * HTTP/1.1\r\nHOST: 239.255.255.250:1900\r\nST: {st}\r\nMAN: \"ssdp:discover\"\r\nMX: 2\r\n\r\n"
    // rust: );
    // rust: let _ = s.send_to(m.as_bytes(), "239.255.255.250:1900");
}
    // rust: let deadline = Instant::now() + timeout;
    // rust: let mut found = Vec::new();
    // rust: let mut buf = [0u8; 2048];
    // rust: while Instant::now() < deadline {
    // rust: if let Ok((n, _)) = s.recv_from(&mut buf)
    // rust: && let Some(l) = ssdp_location(&String::from_utf8_lossy(&buf[..n]))
    // rust: && !found.contains(&l)
    // rust: {
    // rust: found.push(l);
}
}
    // rust: found
}
pub fn ssdp_location(response: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: response.lines().find_map(|l| {
    // rust: let (k, v) = l.split_once(':')?;
    // rust: k.trim()
    // rust: .eq_ignore_ascii_case("location")
    // rust: .then(|| v.trim().to_owned())
    // rust: })
}

pub const UpnpError = enum {
    Code(u32),
    Io(io::Error),
};
    // rust: impl From<io::Error> for UpnpError {
pub fn from(e: io::Error) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::Io(e)
}
}
    // rust: impl From<UpnpError> for io::Error {
pub fn from(e: UpnpError) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match e {
    // rust: UpnpError::Code(c) => io::Error::other(format!("error {c}")),
    // rust: UpnpError::Io(e) => e,
}
}
}

/// An internet gateway's connection service.
pub const Igd = struct {
    control: []const u8,
    service: []const u8,
};
    // rust: impl Igd {
    /// Read the device description for a WANIPConnection (or WANPPPConnection) service.
pub fn from_location(location: []const u8) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (status, xml) = http("GET", location, &[], "")?;
    // rust: if status != 200 {
    // rust: return Err(io::Error::other(format!("description: HTTP {status}")));
}
    // rust: let (host, port, _) = split_url(location).ok_or_else(|| io::Error::other("bad URL"))?;
    // rust: let base = tag(&xml, "URLBase")
    // rust: .map(|b| b.trim_end_matches('/').to_owned())
    // rust: .unwrap_or_else(|| format!("http://{host}:{port}"));
    // rust: for block in xml.split("<service>").skip(1) {
    // rust: let Some(service) = tag(block, "serviceType") else {
    // rust: continue;
}
    // rust: if !(service.contains(":WANIPConnection:") || service.contains(":WANPPPConnection:")) {
    // rust: continue;
}
    // rust: let Some(control) = tag(block, "controlURL") else {
    // rust: continue;
}
    // rust: let control = if control.starts_with("http://") {
    // rust: control.to_owned()
    // rust: } else {
    // rust: format!("{base}/{}", control.trim_start_matches('/'))
}
    // rust: return Ok(Self {
    // rust: control,
    // rust: service: service.to_owned(),
    // rust: });
}
    // rust: Err(io::Error::other("no WAN connection service"))
}
pub fn soap(self: *Self, action: []const u8, args: *[([]const u8) void {
}
    // rust: let mut body = format!(
    // rust: "<?xml version=\"1.0\"?>\n<s:Envelope xmlns:s=\"http://schemas.xmlsoap.org/soap/envelope/\" s:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\"><s:Body><u:{action} xmlns:u=\"{}\">",
    // rust: self.service
    // rust: );
    // rust: for (k, v) in args {
    // rust: body.push_str(&format!("<{k}>{v}</{k}>"));
}
    // rust: body.push_str(&format!("</u:{action}></s:Body></s:Envelope>"));
    // rust: let soap_action = format!("\"{}#{action}\"", self.service);
    // rust: let (status, reply) = http(
    // rust: "POST",
    // rust: &self.control,
    // rust: &[
    // rust: ("Content-Type", "text/xml; charset=\"utf-8\""),
    // rust: ("SOAPAction", &soap_action),
    // rust: ],
    // rust: &body,
    // rust: )?;
    // rust: if status == 200 {
    // rust: return Ok(reply);
}
    // rust: match tag(&reply, "errorCode").and_then(|c| c.parse().ok()) {
    // rust: Some(code) => Err(UpnpError::Code(code)),
    // rust: None => Err(UpnpError::Io(io::Error::other(format!("HTTP {status}")))),
}
}
    // rust: fn add(
    // rust: &self,
    // rust: external: u16,
    // rust: internal: u16,
    // rust: client: Ipv4Addr,
    // rust: lease: u32,
    // rust: ) -> Result<(), UpnpError> {
    // rust: self.soap(
    // rust: "AddPortMapping",
    // rust: &[
    // rust: ("NewRemoteHost", String::new()),
    // rust: ("NewExternalPort", external.to_string()),
    // rust: ("NewProtocol", "TCP".into()),
    // rust: ("NewInternalPort", internal.to_string()),
    // rust: ("NewInternalClient", client.to_string()),
    // rust: ("NewEnabled", "1".into()),
    // rust: ("NewPortMappingDescription", DESCRIPTION.into()),
    // rust: ("NewLeaseDuration", lease.to_string()),
    // rust: ],
    // rust: )
    // rust: .map(|_| ())
}
pub fn delete(self: *Self, external: u16) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.soap(
    // rust: "DeletePortMapping",
    // rust: &[
    // rust: ("NewRemoteHost", String::new()),
    // rust: ("NewExternalPort", external.to_string()),
    // rust: ("NewProtocol", "TCP".into()),
    // rust: ],
    // rust: )
    // rust: .map(|_| ())
}
pub fn external_ip(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let r = self.soap("GetExternalIPAddress", &[])?;
    // rust: tag(&r, "NewExternalIPAddress")
    // rust: .and_then(|t| t.parse().ok())
    // rust: .ok_or_else(|| io::Error::other("no external address"))
}
}

// ----- The default gateway ----------------------------------------------------------------------

/// The IPv4 default gateway from the OS routing table.
pub fn default_gateway() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: {
    // rust: linux_gateway(&std::fs::read_to_string("/proc/net/route").ok()?)
}
    // rust: {
    // rust: let out = std::process::Command::new("route")
    // rust: .args(["-n", "get", "default"])
    // rust: .output()
    // rust: .ok()?;
    // rust: bsd_gateway(&String::from_utf8_lossy(&out.stdout))
}
    // rust: {
    // rust: let out = std::process::Command::new("route")
    // rust: .args(["print", "-4", "0.0.0.0"])
    // rust: .output()
    // rust: .ok()?;
    // rust: windows_gateway(&String::from_utf8_lossy(&out.stdout))
}
    // rust: target_os = "linux",
    // rust: target_os = "macos",
    // rust: target_os = "freebsd",
    // rust: target_os = "openbsd",
    // rust: windows
    // rust: )))]
    // rust: {
    // rust: None
}
}
pub fn linux_gateway(table: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: table.lines().skip(1).find_map(|l| {
    // rust: let f: Vec<&str> = l.split_whitespace().collect();
    // rust: if f.len() > 2 && f[1] == "00000000" {
    // rust: let g = u32::from_str_radix(f[2], 16).ok()?;
    // rust: (g != 0).then(|| Ipv4Addr::from(g.swap_bytes()))
    // rust: } else {
    // rust: None
}
    // rust: })
}
pub fn bsd_gateway(text: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: text.lines().find_map(|l| {
    // rust: l.trim()
    // rust: .strip_prefix("gateway:")
    // rust: .and_then(|g| g.trim().parse().ok())
    // rust: })
}
pub fn windows_gateway(text: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: text.lines().find_map(|l| {
    // rust: let f: Vec<&str> = l.split_whitespace().collect();
    // rust: (f.len() >= 3 && f[0] == "0.0.0.0" && f[1] == "0.0.0.0")
    // rust: .then(|| f[2].parse().ok())
    // rust: .flatten()
    // rust: })
}

    // rust: mod tests {
//     use super::*;
//     use std::{
    // rust: collections::HashMap,
    // rust: net::TcpListener,
    // rust: sync::{Arc, Mutex},
}

    // rust: type Table = Arc<Mutex<HashMap<u16, (u16, u32)>>>;

    /// A router on loopback speaking PCP (unless `pmp_only`) and NAT-PMP;
    /// external port = internal + 1000, WAN address 198.51.100.7.
pub fn mock_pmp(pmp_only: bool) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let s = UdpSocket::bind("127.0.0.1:0").unwrap();
    // rust: let addr = s.local_addr().unwrap();
    // rust: let table: Table = Arc::default();
    // rust: let t = table.clone();
    // rust: std::thread::spawn(move || {
    // rust: let mut buf = [0u8; 1100];
    // rust: while let Ok((n, from)) = s.recv_from(&mut buf) {
    // rust: let r = &buf[..n];
    // rust: let reply = match (r[0], r.get(1)) {
    // rust: (2, _) if pmp_only => vec![0, 0x81, 0, 1],
    // rust: (2, Some(1)) => {
    // rust: let internal = u16::from_be_bytes([r[40], r[41]]);
    // rust: let life = u32::from_be_bytes(r[4..8].try_into().unwrap());
    // rust: let mut out = r.to_vec();
    // rust: out[1] = 0x81;
    // rust: out[2] = 0;
    // rust: out[3] = 0;
    // rust: let ext = if life == 0 {
    // rust: t.lock().unwrap().remove(&internal);
    // rust: 0
    // rust: } else {
    // rust: t.lock().unwrap().insert(internal, (internal + 1000, life));
    // rust: internal + 1000
}
    // rust: out[42..44].copy_from_slice(&ext.to_be_bytes());
    // rust: out[44..60].copy_from_slice(
    // rust: &Ipv4Addr::new(198, 51, 100, 7).to_ipv6_mapped().octets(),
    // rust: );
    // rust: out
}
    // rust: (0, Some(0)) => vec![0, 128, 0, 0, 0, 0, 0, 1, 198, 51, 100, 7],
    // rust: (0, Some(2)) => {
    // rust: let internal = u16::from_be_bytes([r[4], r[5]]);
    // rust: let life = u32::from_be_bytes(r[8..12].try_into().unwrap());
    // rust: let ext = if life == 0 {
    // rust: t.lock().unwrap().remove(&internal);
    // rust: 0
    // rust: } else {
    // rust: t.lock().unwrap().insert(internal, (internal + 1000, life));
    // rust: internal + 1000
}
    // rust: let mut out = vec![0, 130, 0, 0, 0, 0, 0, 1];
    // rust: out.extend_from_slice(&internal.to_be_bytes());
    // rust: out.extend_from_slice(&ext.to_be_bytes());
    // rust: out.extend_from_slice(&life.to_be_bytes());
    // rust: out
}
    // rust: _ => continue,
}
    // rust: let _ = s.send_to(&reply, from);
}
    // rust: });
    // rust: (addr, table)
}

pub fn pcp_maps_renews_and_deletes() void {
}
    // rust: let (gw, table) = mock_pmp(false);
    // rust: let targets = Targets {
    // rust: pmp: vec![gw],
    // rust: upnp: vec![],
}
    // rust: let mut m = map(&targets, Ipv4Addr::new(192, 168, 1, 20), 25580, LEASE).unwrap();
    // rust: assert_eq!(m.method, Method::Pcp);
    // rust: assert_eq!(m.external, "198.51.100.7:26580".parse().unwrap());
    // rust: assert_eq!(table.lock().unwrap()[&25580], (26580, 3600));
    // rust: assert!(!m.due());
    // rust: m.renew().unwrap();
    // rust: m.remove();
    // rust: assert!(table.lock().unwrap().is_empty());
}

pub fn nat_pmp_when_pcp_is_unsupported() void {
}
    // rust: let (gw, table) = mock_pmp(true);
    // rust: let targets = Targets {
    // rust: pmp: vec![gw],
    // rust: upnp: vec![],
}
    // rust: let m = map(&targets, Ipv4Addr::new(192, 168, 1, 20), 25580, LEASE).unwrap();
    // rust: assert_eq!(m.method, Method::NatPmp);
    // rust: assert_eq!(m.external, "198.51.100.7:26580".parse().unwrap());
    // rust: m.remove();
    // rust: assert!(table.lock().unwrap().is_empty());
}

    /// An IGD on loopback: description, then SOAP. `permanent_only` answers
    /// 725 to leases; `taken` ports answer 718.
    // rust: fn mock_igd(
    // rust: permanent_only: bool,
    // rust: taken: u16,
    // rust: ) -> (String, Arc<Mutex<HashMap<u16, (u16, String, u32)>>>) {
    // rust: let l = TcpListener::bind("127.0.0.1:0").unwrap();
    // rust: let port = l.local_addr().unwrap().port();
    // rust: let table: Arc<Mutex<HashMap<u16, (u16, String, u32)>>> = Arc::default();
    // rust: let t = table.clone();
    // rust: std::thread::spawn(move || {
    // rust: for s in l.incoming() {
    // rust: let Ok(mut s) = s else { continue };
    // rust: let mut req = Vec::new();
    // rust: let mut buf = [0u8; 4096];
                // Read the headers, then Content-Length bytes.
    // rust: loop {
    // rust: let n = s.read(&mut buf).unwrap_or(0);
    // rust: if n == 0 {
    // rust: break;
}
    // rust: req.extend_from_slice(&buf[..n]);
    // rust: let text = String::from_utf8_lossy(&req);
    // rust: if let Some((head, body)) = text.split_once("\r\n\r\n") {
    // rust: let len: usize = head
    // rust: .lines()
    // rust: .find_map(|l| l.strip_prefix("Content-Length: "))
    // rust: .and_then(|v| v.trim().parse().ok())
    // rust: .unwrap_or(0);
    // rust: if body.len() >= len {
    // rust: break;
}
}
}
    // rust: let text = String::from_utf8_lossy(&req).into_owned();
    // rust: let (status, body) = if text.starts_with("GET /desc.xml") {
    // rust: (200, "<root><device><serviceList><service><serviceType>urn:schemas-upnp-org:service:WANCommonInterfaceConfig:1</serviceType><controlURL>/wrong</controlURL></service><service><serviceType>urn:schemas-upnp-org:service:WANIPConnection:1</serviceType><controlURL>/ctl</controlURL></service></serviceList></device></root>".to_owned())
    // rust: } else if text.contains("#GetExternalIPAddress") {
    // rust: (200, "<s:Envelope><s:Body><u:GetExternalIPAddressResponse><NewExternalIPAddress>198.51.100.8</NewExternalIPAddress></u:GetExternalIPAddressResponse></s:Body></s:Envelope>".to_owned())
    // rust: } else if text.contains("#AddPortMapping") {
    // rust: let ext: u16 = tag(&text, "NewExternalPort").unwrap().parse().unwrap();
    // rust: let int: u16 = tag(&text, "NewInternalPort").unwrap().parse().unwrap();
    // rust: let client = tag(&text, "NewInternalClient").unwrap().to_owned();
    // rust: let lease: u32 = tag(&text, "NewLeaseDuration").unwrap().parse().unwrap();
    // rust: if permanent_only && lease != 0 {
    // rust: (500, "<s:Fault><detail><UPnPError><errorCode>725</errorCode></UPnPError></detail></s:Fault>".to_owned())
    // rust: } else if ext == taken {
    // rust: (500, "<s:Fault><detail><UPnPError><errorCode>718</errorCode></UPnPError></detail></s:Fault>".to_owned())
    // rust: } else {
    // rust: t.lock().unwrap().insert(ext, (int, client, lease));
    // rust: (200, "<ok/>".to_owned())
}
    // rust: } else if text.contains("#DeletePortMapping") {
    // rust: let ext: u16 = tag(&text, "NewExternalPort").unwrap().parse().unwrap();
    // rust: t.lock().unwrap().remove(&ext);
    // rust: (200, "<ok/>".to_owned())
    // rust: } else {
    // rust: (404, String::new())
}
    // rust: let _ = write!(
    // rust: s,
    // rust: "HTTP/1.1 {status} X\r\nContent-Type: text/xml\r\nTransfer-Encoding: chunked\r\n\r\n{:x}\r\n{body}\r\n0\r\n\r\n",
    // rust: body.len()
    // rust: );
}
    // rust: });
    // rust: (format!("http://127.0.0.1:{port}/desc.xml"), table)
}

pub fn upnp_maps_and_deletes() void {
}
    // rust: let (location, table) = mock_igd(false, 0);
    // rust: let targets = Targets {
    // rust: pmp: vec![],
    // rust: upnp: vec![location],
}
    // rust: let client = Ipv4Addr::new(192, 168, 1, 20);
    // rust: let mut m = map(&targets, client, 25580, LEASE).unwrap();
    // rust: assert_eq!(m.method, Method::Upnp);
    // rust: assert_eq!(m.external, "198.51.100.8:25580".parse().unwrap());
    // rust: assert_eq!(
    // rust: table.lock().unwrap()[&25580],
    // rust: (25580, "192.168.1.20".into(), 3600)
    // rust: );
    // rust: m.renew().unwrap();
    // rust: m.remove();
    // rust: assert!(table.lock().unwrap().is_empty());
}

pub fn upnp_permanent_leases_and_taken_ports() void {
}
    // rust: let (location, table) = mock_igd(true, 25580);
    // rust: let targets = Targets {
    // rust: pmp: vec![],
    // rust: upnp: vec![location],
}
    // rust: let m = map(&targets, Ipv4Addr::new(10, 0, 0, 2), 25580, LEASE).unwrap();
        // 725 → no lease; 718 on 25580 → another port.
    // rust: assert_ne!(m.external.port(), 25580);
    // rust: let entry = table.lock().unwrap()[&m.external.port()].clone();
    // rust: assert_eq!(entry, (25580, "10.0.0.2".into(), 0));
    // rust: m.remove();
    // rust: assert!(table.lock().unwrap().is_empty());
}

pub fn nothing_answering_says_why() void {
}
    // rust: let quiet = UdpSocket::bind("127.0.0.1:0").unwrap();
    // rust: let targets = Targets {
    // rust: pmp: vec![quiet.local_addr().unwrap()],
    // rust: upnp: vec![],
}
    // rust: let e = map(&targets, Ipv4Addr::new(10, 0, 0, 2), 1, LEASE).unwrap_err();
    // rust: assert!(e.contains("PCP") && e.contains("NAT-PMP"), "{e}");
    // rust: assert_eq!(
    // rust: map(&Targets::default(), Ipv4Addr::LOCALHOST, 1, LEASE).unwrap_err(),
    // rust: "no router answered"
    // rust: );
}

pub fn parsers() void {
}
    // rust: assert_eq!(
    // rust: ssdp_location(
    // rust: "HTTP/1.1 200 OK\r\nCACHE-CONTROL: max-age=120\r\nLOCATION: http://192.168.1.1:5000/rootDesc.xml\r\nST: x\r\n\r\n"
    // rust: ),
    // rust: Some("http://192.168.1.1:5000/rootDesc.xml".into())
    // rust: );
    // rust: assert_eq!(
    // rust: split_url("http://192.168.1.1:5000/a/b"),
    // rust: Some(("192.168.1.1".into(), 5000, "/a/b".into()))
    // rust: );
    // rust: assert_eq!(
    // rust: split_url("http://[fe80::1]/rootDesc.xml"),
    // rust: Some(("fe80::1".into(), 80, "/rootDesc.xml".into()))
    // rust: );
    // rust: assert_eq!(
    // rust: split_url("http://[fe80::1]:5000/x"),
    // rust: Some(("fe80::1".into(), 5000, "/x".into()))
    // rust: );
    // rust: assert_eq!(
    // rust: split_url("http://router/"),
    // rust: Some(("router".into(), 80, "/".into()))
    // rust: );
    // rust: assert_eq!(
    // rust: linux_gateway(
    // rust: "Iface\tDestination\tGateway \tFlags\neth0\t0001A8C0\t00000000\t0001\neth0\t00000000\t0101A8C0\t0003\n"
    // rust: ),
    // rust: Some(Ipv4Addr::new(192, 168, 1, 1))
    // rust: );
    // rust: assert_eq!(
    // rust: bsd_gateway("   route to: default\ndestination: default\n    gateway: 192.168.1.254\n"),
    // rust: Some(Ipv4Addr::new(192, 168, 1, 254))
    // rust: );
    // rust: assert_eq!(
    // rust: windows_gateway(
    // rust: "Network Destination        Netmask          Gateway       Interface  Metric\n          0.0.0.0          0.0.0.0      10.0.0.138      10.0.0.12     25\n"
    // rust: ),
    // rust: Some(Ipv4Addr::new(10, 0, 0, 138))
    // rust: );
    // rust: assert_eq!(
    // rust: tag("<a:Body><x:Name attr=\"1\"> v </x:Name></a:Body>", "Name"),
    // rust: Some("v")
    // rust: );
}
}
