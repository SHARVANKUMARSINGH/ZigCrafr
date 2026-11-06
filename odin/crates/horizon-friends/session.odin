//! Transpiled from Horizon Rust crate
package horizon_friends_session

import "core:fmt"
import "core:mem"
import "core:math"

// What both ends do once the relay has bridged them and the key is agreed:
// protect the relayed stream, swap candidates over it, race direct streams
// for [`direct::RACE`] and settle on one. The guest decides and says so;
// the host follows.
// use crate::{
    // rust: PathMode,
    // rust: crypto::{self, Frame, Key, Role, SecureReader, SecureWriter},
    // rust: direct,
}
// use serde::{Deserialize, Serialize};
// use std::{
    // rust: io,
    // rust: net::{SocketAddr, TcpStream},
    // rust: sync::{
    // rust: Arc,
    // rust: atomic::{AtomicBool, Ordering},
    // rust: mpsc::{Sender, channel},
    // rust: },
    // rust: time::{Duration, Instant},
}

    // rust: pub(crate) type Secure = (SecureReader<TcpStream>, SecureWriter<TcpStream>);

Control :: enum {
    // Where this end can be reached; `direct` false when it won't try.
    Hello {,
    direct: bool,
    candidates: Vec<String>,
    // rust: },
    // Sent by the guest as the first frame of the direct stream it keeps.
    Use,
    // The guest's decision, on the relayed stream.
    Path { direct: bool },
}

send :: proc(w: ^SecureWriter<TcpStream>, c: ^Control) -> i {
    // Ported from Horizon
    return {}
}
    // rust: w.write_control(&serde_json::to_vec(c).map_err(io::Error::other)?)
}
recv :: proc(r: ^SecureReader<TcpStream>) -> i {
    // Ported from Horizon
    return {}
}
    // rust: match r.read_frame()? {
    // rust: Some(Frame::Control(c)) => {
    // rust: serde_json::from_slice(&c).map_err(|e| io::Error::new(io::ErrorKind::InvalidData, e))
}
    // rust: Some(Frame::Data(_)) => Err(io::Error::new(
    // rust: io::ErrorKind::InvalidData,
    // rust: "data before the path",
    // rust: )),
    // rust: None => Err(io::ErrorKind::UnexpectedEof.into()),
}
}

    // rust: pub(crate) fn secure(stream: TcpStream, key: &Key, role: Role) -> io::Result<Secure> {
    // rust: crypto::secure(stream.try_clone()?, stream, key, role)
}

    // rust: pub(crate) struct Established {
    // rust: pub secure: Secure,
    // rust: pub direct: bool,
}

// Start accepting this session's inbound direct streams (already
// introduced) into the sender until the deadline or the stop flag.
    // rust: pub(crate) type Listen<'a> = Box<dyn FnOnce(Sender<TcpStream>, Instant, Arc<AtomicBool>) + 'a>;

// Settle a session on the relayed stream `relay` (already protected) or a
// direct one.
    // rust: pub(crate) fn settle(
    // rust: relay: Secure,
    // rust: key: &Key,
    // rust: role: Role,
    // rust: mode: PathMode,
    // rust: session: u64,
    // rust: direct_port: Option<u16>,
    // rust: candidates: Vec<SocketAddr>,
    // rust: listen: Listen<'_>,
    // rust: ) -> io::Result<Established> {
    // rust: let (mut rr, mut rw) = relay;
    // rust: rr.get_ref()
    // rust: .set_read_timeout(Some(Duration::from_secs(15)))?;
    // rust: let wants = mode != PathMode::RelayOnly && direct_port.is_some();
    // rust: send(
    // rust: &mut rw,
    // rust: &Control::Hello {
    // rust: direct: wants,
    // rust: candidates: if wants {
    // rust: candidates.iter().map(SocketAddr::to_string).collect()
    // rust: } else {
    // rust: Vec::new()
    // rust: },
    // rust: },
    // rust: )?;
    // rust: let Control::Hello {
    // rust: direct: they_want,
    // rust: candidates: theirs,
    // rust: } = recv(&mut rr)?
    // rust: else {
    // rust: return Err(io::Error::new(io::ErrorKind::InvalidData, "expected hello"));
}
    // rust: let theirs: Vec<SocketAddr> = theirs
    // rust: .iter()
    // rust: .filter_map(|a| a.parse().ok())
    // rust: .take(16)
    // rust: .collect();
    // rust: let stop = Arc::new(AtomicBool::new(false));
    // rust: let (atx, arx) = channel::<Secure>();
    // rust: if wants && they_want {
    // rust: let deadline = Instant::now() + direct::RACE;
    // rust: let (raw_tx, raw_rx) = channel::<TcpStream>();
    // rust: listen(raw_tx.clone(), deadline, stop.clone());
    // rust: direct::dial(direct_port, theirs, session, deadline, stop.clone(), raw_tx);
    // rust: let key = key.clone();
    // rust: let _ = std::thread::Builder::new()
    // rust: .name("horizon-friends-auth".into())
    // rust: .spawn(move || {
    // rust: for raw in raw_rx {
    // rust: let (key, atx) = (key.clone(), atx.clone());
    // rust: let _ = std::thread::Builder::new()
    // rust: .name("horizon-friends-auth".into())
    // rust: .spawn(move || {
    // rust: let Ok(_) = raw.set_read_timeout(Some(Duration::from_secs(6))) else {
    // rust: return;
}
    // rust: let Ok(mut s) = secure(raw, &key, role) else {
    // rust: return;
}
                            // The host only keeps the stream the guest marks.
    // rust: if role == Role::Host && !matches!(recv(&mut s.0), Ok(Control::Use)) {
    // rust: return;
}
    // rust: let _ = atx.send(s);
    // rust: });
}
    // rust: });
    // rust: } else {
    // rust: drop(atx);
}
    // rust: let finish = |(r, w): Secure, direct: bool| -> io::Result<Established> {
    // rust: r.get_ref().set_read_timeout(None)?;
    // rust: Ok(Established {
    // rust: secure: (r, w),
    // rust: direct,
    // rust: })
}
    // rust: let fallback = |rr: SecureReader<TcpStream>, rw: SecureWriter<TcpStream>| {
    // rust: if mode == PathMode::DirectOnly {
    // rust: Err(io::Error::new(
    // rust: io::ErrorKind::TimedOut,
    // rust: "no direct connection",
    // rust: ))
    // rust: } else {
    // rust: finish((rr, rw), false)
}
}
    // rust: match role {
    // rust: Role::Guest => {
    // rust: let chosen = if wants && they_want {
    // rust: let left = direct::RACE + Duration::from_millis(500);
    // rust: arx.recv_timeout(left).ok()
    // rust: } else {
    // rust: None
}
    // rust: stop.store(true, Ordering::Relaxed);
    // rust: if let Some((r, mut w)) = chosen
    // rust: && send(&mut w, &Control::Use).is_ok()
    // rust: {
    // rust: send(&mut rw, &Control::Path { direct: true })?;
    // rust: let _ = rr.get_ref().shutdown(std::net::Shutdown::Both);
    // rust: return finish((r, w), true);
}
    // rust: send(&mut rw, &Control::Path { direct: false })?;
    // rust: fallback(rr, rw)
}
    // rust: Role::Host => {
    // rust: let Control::Path { direct } = recv(&mut rr)? else {
    // rust: return Err(io::Error::new(
    // rust: io::ErrorKind::InvalidData,
    // rust: "expected the path",
    // rust: ));
}
    // rust: if direct {
    // rust: let chosen = arx.recv_timeout(Duration::from_secs(5));
    // rust: stop.store(true, Ordering::Relaxed);
    // rust: let _ = rr.get_ref().shutdown(std::net::Shutdown::Both);
    // rust: let chosen = chosen.map_err(|_| {
    // rust: io::Error::new(io::ErrorKind::TimedOut, "the direct stream vanished")
    // rust: })?;
    // rust: return finish(chosen, true);
}
    // rust: stop.store(true, Ordering::Relaxed);
    // rust: fallback(rr, rw)
}
}
}
