//! Transpiled from Horizon Rust crate
package horizon_protocol_resolver

import "core:fmt"
import "core:mem"
import "core:math"

// Minecraft server DNS redirects (`ServerRedirectHandler` / `ServerNameResolver`).
// Port 25565 asks for `_minecraft._tcp.<host>`'s SRV record; no record or a
// failed query leaves the original address in use. Login uses the resolved
// host and port; status requests keep the original address.
// use crate::{Error, Result};
// use std::net::{IpAddr, SocketAddr, ToSocketAddrs};

    // rust: mod dns;

    // rust: pub(crate) struct Resolved {
    // rust: pub host: String,
    // rust: pub port: u16,
    // rust: pub addresses: Vec<SocketAddr>,
}

    // rust: pub(crate) fn resolve(host: &str, port: u16) -> Result<Resolved> {
    // rust: resolve_with(host, port, srv_redirect, |host, port| {
    // rust: (host, port)
    // rust: .to_socket_addrs()
    // rust: .map(|addrs| addrs.collect())
    // rust: .map_err(|e| Error::new(format!("Unknown host {host}: {e}")))
    // rust: })
}

// `ServerNameResolver.resolveAddress`: keep the selected host and port with
// its socket addresses, including a single SRV redirect.
    // rust: fn resolve_with(
    // rust: host: &str,
    // rust: port: u16,
    // rust: srv: impl FnOnce(&str) -> Option<(String, u16)>,
    // rust: addresses: impl FnOnce(&str, u16) -> Result<Vec<SocketAddr>>,
    // rust: ) -> Result<Resolved> {
    // Vanilla also asks for `_minecraft._tcp.127.0.0.1`, which never has a
    // record: IP literals and localhost skip the query.
    // rust: if port == 25565
    // rust: && host.parse::<IpAddr>().is_err()
    // rust: && host != "localhost"
    // rust: && let Some((target, target_port)) =
    // rust: srv(&format!("_minecraft._tcp.{}.", host.trim_end_matches('.')))
    // rust: {
        // No second SRV lookup at the target, and no fallback to the original
        // host when the target is unknown.
    // rust: return Ok(Resolved {
    // rust: addresses: addresses(&target, target_port)?,
    // rust: host: target,
    // rust: port: target_port,
    // rust: });
}
    // rust: Ok(Resolved {
    // rust: addresses: addresses(host, port)?,
    // rust: host: host.to_owned(),
    // rust: port,
    // rust: })
}

// Where a server address leads (`ServerRedirectHandler`): its `_minecraft._tcp` SRV target when
// the port is 25565 and the host a name, else the host and port as given. No address lookup.
server_redirect :: proc(host: string, port: u16) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: resolve_with(host, port, srv_redirect, |_, _| Ok(Vec::new()))
    // rust: .map_or_else(|_| (host.to_owned(), port), |r| (r.host, r.port))
}

srv_redirect :: proc(name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: dns::query_srv(name, &dns::system_name_servers(), dns::SERVER_TIMEOUT)
}

    // rust: mod tests {
//     use super::*;

    // Compared with ServerNameResolver by tools/test_server_address_parity.py.
login_handshake_address_matches_vanilla :: proc() {
}
    // rust: for (scenario, port, redirected) in [
    // rust: ("direct", 25565, false),
    // rust: ("redirect", 25565, true),
    // rust: ("explicit", 25566, false),
    // rust: ] {
    // rust: let result = resolve_with(
    // rust: "play.example.org",
    // rust: port,
    // rust: |_| redirected.then(|| ("backend.example.org.".into(), 25570)),
    // rust: |_, port| Ok(vec![SocketAddr::from(([127, 0, 0, 1], port))]),
    // rust: )
    // rust: .unwrap();
    // rust: let expected = if redirected {
    // rust: ("backend.example.org.", 25570)
    // rust: } else {
    // rust: ("play.example.org", port)
}
    // rust: assert_eq!((result.host.as_str(), result.port), expected);
    // rust: assert_eq!(result.addresses[0].port(), expected.1);
    // rust: println!("server_address={scenario}:{}:{}", result.host, result.port);
}
}

redirects_default_port_even_when_the_original_host_has_no_addresses :: proc() {
}
    // rust: let result = resolve_with(
    // rust: "play.example.org",
    // rust: 25565,
    // rust: |name| {
    // rust: assert_eq!(name, "_minecraft._tcp.play.example.org.");
    // rust: Some(("backend.example.org.".into(), 25570))
    // rust: },
    // rust: |host, port| {
    // rust: assert_eq!((host, port), ("backend.example.org.", 25570));
    // rust: Ok(vec!["127.0.0.1:25570".parse().unwrap()])
    // rust: },
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: result.addresses,
    // rust: vec!["127.0.0.1:25570".parse::<SocketAddr>().unwrap()]
    // rust: );
}

no_record_or_lookup_failure_keeps_the_original_address :: proc() {
}
    // rust: resolve_with(
    // rust: "play.example.org",
    // rust: 25565,
    // rust: |_| None,
    // rust: |host, port| {
    // rust: assert_eq!((host, port), ("play.example.org", 25565));
    // rust: Ok(vec![])
    // rust: },
    // rust: )
    // rust: .unwrap();
}

explicit_nondefault_ports_and_ip_literals_do_not_query_srv :: proc() {
}
    // rust: for (host, port) in [
    // rust: ("play.example.org", 25570),
    // rust: ("127.0.0.1", 25565),
    // rust: ("::1", 25565),
    // rust: ("localhost", 25565),
    // rust: ] {
    // rust: resolve_with(
    // rust: host,
    // rust: port,
    // rust: |_| panic!("unexpected SRV query"),
    // rust: |actual, actual_port| {
    // rust: assert_eq!((actual, actual_port), (host, port));
    // rust: Ok(vec![])
    // rust: },
    // rust: )
    // rust: .unwrap();
}
}

fully_qualified_host_does_not_get_a_second_trailing_dot :: proc() {
}
    // rust: resolve_with(
    // rust: "play.example.org.",
    // rust: 25565,
    // rust: |name| {
    // rust: assert_eq!(name, "_minecraft._tcp.play.example.org.");
    // rust: None
    // rust: },
    // rust: |_, _| Ok(vec![]),
    // rust: )
    // rust: .unwrap();
}

unknown_redirect_target_does_not_fall_back_to_the_original :: proc() {
}
    // rust: let result = resolve_with(
    // rust: "play.example.org",
    // rust: 25565,
    // rust: |_| Some(("missing.example.org.".into(), 25570)),
    // rust: |host, _| {
    // rust: assert_eq!(host, "missing.example.org.");
    // rust: Err(Error::new("unknown redirected host"))
    // rust: },
    // rust: );
    // rust: assert_eq!(result.unwrap_err().to_string(), "unknown redirected host");
}

literal_address_can_connect_without_dns :: proc() {
}
    // rust: let listener = std::net::TcpListener::bind("127.0.0.1:0").unwrap();
    // rust: let address = listener.local_addr().unwrap();
    // rust: let connection = crate::connection::Connection::connect_server(
    // rust: "127.0.0.1",
    // rust: address.port(),
    // rust: std::time::Duration::from_secs(1),
    // rust: )
    // rust: .unwrap();
    // rust: let (accepted, _) = listener.accept().unwrap();
    // rust: drop((connection, accepted));
}
}
