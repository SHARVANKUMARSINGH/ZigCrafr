//! Transpiled from Horizon Rust crate
//! Module: horizon-client_lan_far
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Far terrain for a server's Horizon clients (`horizon_client::lod_net`): a
//! `horizon:lod` request is checked against the player's limits and position,
//! then sampled from the level the player is in on the far terrain thread.
//! The replies come back here and leave with the tick's other packets. A
//! refused request is answered at once, so the client knows to ask again.
// use super::{Dim, Game, lan::LanHost};
// use horizon_client::{
    // rust: lan::conn::PlayerSender,
    // rust: lod_net::{CHANNEL, Delivery, Job, Verdict},
}
// use horizon_protocol::{
    // rust: packets::{configuration::CustomPayload, play},
    // rust: text::translatable,
}
// use std::sync::atomic::Ordering;

/// Bytes a player's connection may have waiting before far terrain holds its
/// replies back: a client that reads slowly gets the game's packets first.
pub const BACKLOG: usize = 1 << 20;

pub fn send(sender: *PlayerSender, data: std.ArrayList(u8)) void {
}
    // rust: let packet = play::Clientbound::CustomPayload(CustomPayload {
    // rust: channel: CHANNEL.into(),
    // rust: data,
    // rust: });
    // rust: sender.send(packet.encode());
}

    // rust: impl Game<'_> {
    /// A `horizon:lod` payload from `conn`.
    // rust: pub(super) fn guest_far_terrain(&mut self, host: &mut LanHost, conn: u32, data: &[u8]) {
    // rust: let Some(far) = host.far.as_mut() else {
    // rust: return;
}
        // Only the clients that heard the offer (lan::conn) may ask.
    // rust: let Some(guest) = host.hub.guest(conn).filter(|g| g.brand == "horizon") else {
    // rust: return;
}
        // Players who left are forgotten once they could matter.
    // rust: if far.players() > host.hub.guests.len() + 8 {
    // rust: let guests = &host.hub.guests;
    // rust: far.retain(|c| guests.iter().any(|g| g.conn == c));
}
    // rust: let dim = Dim::from_id(&guest.dimension);
    // rust: let source = self.lod_source_in(dim);
    // rust: let now = std::time::Instant::now();
    // rust: match far.request(conn, data, guest.position, source.is_some(), now) {
    // rust: Verdict::Serve(request) => far.push(Job {
    // rust: conn,
    // rust: level: dim.id().to_owned(),
    // rust: source: source.expect("served when open"),
    // rust: request,
    // rust: }),
    // rust: Verdict::Refuse(reply) => send(&guest.sender, reply),
    // rust: Verdict::Ignore => {}
    // rust: Verdict::Kick => host.hub.kick(
    // rust: conn,
    // rust: translatable("multiplayer.disconnect.invalid_packet", &[]),
    // rust: ),
}
}

    /// The tiles the far terrain thread finished go to their players, once
    /// their connections have room.
    // rust: pub(super) fn flush_far_terrain(&mut self, host: &mut LanHost) {
    // rust: let Some(far) = host.far.as_mut() else {
    // rust: return;
}
    // rust: let guests = &host.hub.guests;
    // rust: far.deliver(|conn, data| match guests.iter().find(|g| g.conn == conn) {
    // rust: None => Delivery::Gone,
    // rust: Some(g) if g.sender.pending.load(Ordering::Relaxed) > BACKLOG => Delivery::Busy,
    // rust: Some(g) => {
    // rust: send(&g.sender, std::mem::take(data));
    // rust: Delivery::Sent
}
    // rust: });
}
}
