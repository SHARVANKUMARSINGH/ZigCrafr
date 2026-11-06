//! Transpiled from Horizon Rust crate
//! Module: horizon-client_lan_quiet
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Quiet commands (`horizon_protocol::quiet`): a Horizon client's mod sends a
//! batch of command lines in one payload, and the server runs each exactly as
//! that player typing it would (`guest_command`'s checks, the player's own
//! permission level, at the time it runs) with its output suppressed, as
//! vanilla's functions run (`CommandSourceStack.withSuppressedOutput`): no
//! feedback and no failure in anyone's chat. A batch waits in a queue and runs
//! [`PER_TICK`] lines a player a tick, so a mod can't flood a server; each
//! finished batch is one line in the server's log.
// use super::{Game, lan::LanHost, lan_actions::GuestCommand};
// use horizon_protocol::quiet;
// use std::collections::{HashMap, VecDeque};

/// Lines a player may have waiting at most; a batch past it loses the rest.
    // rust: pub(super) const PENDING: usize = 4096;
/// Lines run a player a tick at most.
    // rust: pub(super) const PER_TICK: usize = 64;

/// A batch waiting to run.
    // rust: pub(super) struct QuietBatch {
    // rust: conn: u32,
    // rust: mod_id: String,
    // rust: lines: VecDeque<String>,
    // rust: ran: usize,
    // rust: failed: usize,
    /// Lines past [`PENDING`], never run.
    // rust: dropped: usize,
}

    // rust: impl Game<'_> {
    /// A `horizon:quiet_commands` payload from `conn`: queued (or logged as
    /// refused when it breaks the payload's caps).
    // rust: pub(super) fn guest_quiet_commands(&mut self, host: &mut LanHost, conn: u32, data: &[u8]) {
    // rust: let Some(name) = host.hub.guest(conn).map(|g| g.name.clone()) else {
    // rust: return;
}
    // rust: let batch = match quiet::decode(data) {
    // rust: Ok(b) => b,
    // rust: Err(e) => {
    // rust: super::dedicated::log(
    // rust: "WARN",
    // rust: &format!("{name} sent quiet commands that were refused: {e}"),
    // rust: );
    // rust: return;
}
}
    // rust: let waiting: usize = host
    // rust: .quiet
    // rust: .iter()
    // rust: .filter(|b| b.conn == conn)
    // rust: .map(|b| b.lines.len())
    // rust: .sum();
    // rust: let room = PENDING.saturating_sub(waiting);
    // rust: let dropped = batch.lines.len().saturating_sub(room);
    // rust: host.quiet.push_back(QuietBatch {
    // rust: conn,
    // rust: mod_id: batch.mod_id,
    // rust: lines: batch.lines.into_iter().take(room).collect(),
    // rust: ran: 0,
    // rust: failed: 0,
    // rust: dropped,
    // rust: });
}

    /// The waiting batches, [`PER_TICK`] lines a player this tick, in order.
    // rust: pub(super) fn run_quiet_commands(&mut self) {
    // rust: let mut left: HashMap<u32, usize> = HashMap::new();
    // rust: let mut i = 0;
    // rust: loop {
    // rust: let Some(host) = self.lan.as_mut() else {
    // rust: return;
}
    // rust: let Some(batch) = host.quiet.get_mut(i) else {
    // rust: return;
}
    // rust: let conn = batch.conn;
    // rust: let budget = left.entry(conn).or_insert(PER_TICK);
    // rust: let gone = host.hub.guest(conn).is_none();
    // rust: if gone || batch.lines.is_empty() {
    // rust: let batch = host.quiet.remove(i).expect("got it above");
    // rust: if !gone {
    // rust: let name = host
    // rust: .hub
    // rust: .guest(conn)
    // rust: .map_or(String::new(), |g| g.name.clone());
    // rust: super::dedicated::log("INFO", &summary(&name, &batch));
}
    // rust: continue;
}
    // rust: if *budget == 0 {
    // rust: i += 1;
    // rust: continue;
}
    // rust: *budget -= 1;
    // rust: let line = batch.lines.pop_front().expect("not empty");
    // rust: let ok = self.run_quiet_line(conn, &line);
    // rust: if let Some(batch) = self.lan.as_mut().and_then(|h| h.quiet.get_mut(i)) {
    // rust: batch.ran += 1;
    // rust: batch.failed += usize::from(!ok);
}
}
}

    /// One line as `guest_command` would run it for `conn`, quietly. False
    /// when it is refused or fails. A command that carries a chat message
    /// (`say`, `msg`...) is refused: it would need the player's signature.
pub fn run_quiet_line(self: *Self, conn: u32, line: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let allowed = self.options.dedicated.is_some() || self.allow_commands();
    // rust: let Some(host) = self.lan.as_ref() else {
    // rust: return false;
}
    // rust: let integrated = host.hub.config.integrated;
    // rust: if !integrated && (!host.settings.guest_commands || !allowed) {
    // rust: return false;
}
    // rust: let Some((permission, uuid, name)) = host
    // rust: .hub
    // rust: .guest(conn)
    // rust: .map(|g| (g.permission, g.uuid, g.name.clone()))
    // rust: else {
    // rust: return false;
}
    // rust: let command = line.trim_start_matches('/');
    // rust: if !self.signable_arguments(permission, command).is_empty() {
    // rust: return false;
}
        // The mods hear it as they hear a typed command; the batch is quiet,
        // so their replies go nowhere.
    // rust: let mut canceled = false;
    // rust: self.native_player_command(uuid, &name, command, &mut canceled, &mut Vec::new());
    // rust: if canceled {
    // rust: return false;
}
    // rust: self.run_guest_command(GuestCommand {
    // rust: conn,
    // rust: command: command.to_owned(),
    // rust: permission,
    // rust: integrated,
    // rust: quiet: true,
    // rust: })
}
}

/// The batch's line in the server's log.
pub fn summary(name: []const u8, b: *QuietBatch) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut line = format!(
    // rust: "{name} ran {} quiet command(s) from mod {}: {} failed",
    // rust: b.ran, b.mod_id, b.failed
    // rust: );
    // rust: if b.dropped > 0 {
    // rust: line += &format!(", {} dropped (more than {PENDING} waiting)", b.dropped);
}
    // rust: line
}

    // rust: mod tests {
//     use super::*;

pub fn the_log_line_counts_the_batch() void {
}
    // rust: let b = QuietBatch {
    // rust: conn: 1,
    // rust: mod_id: "orbital".into(),
    // rust: lines: VecDeque::new(),
    // rust: ran: 12,
    // rust: failed: 3,
    // rust: dropped: 0,
}
    // rust: assert_eq!(
    // rust: summary("Alex", &b),
    // rust: "Alex ran 12 quiet command(s) from mod orbital: 3 failed"
    // rust: );
    // rust: let b = QuietBatch { dropped: 5, ..b };
    // rust: assert!(summary("Alex", &b).ends_with(", 5 dropped (more than 4096 waiting)"));
}
}
