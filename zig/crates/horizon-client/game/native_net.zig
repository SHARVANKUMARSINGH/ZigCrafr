//! Transpiled from Horizon Rust crate
//! Module: horizon-client_native_net
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Mod messages for native mods (docs/native-mods.md, "Mod messages", API
//! 23): a mod's server half and its client half send each other bytes
//! (`horizon_protocol::mod_net`). The hub is out of the game while a guest's
//! packet or turn runs, so both directions wait here: what a guest sent
//! reaches `native_net_from_client` once the hub is back, and what a mod sends
//! a player leaves at the tick's end, from whichever hook sent it.
// use super::{Game, lan::LanHost};
// use horizon_client::mod_api::ServerboundPlayPacket;
// use horizon_protocol::{
    // rust: mod_net::{self, Message},
    // rust: packets::{
    // rust: configuration::CustomPayload,
    // rust: play::{Clientbound as C, Serverbound as S},
    // rust: },
    // rust: quiet,
}
// use std::collections::HashMap;

/// Messages a tick at most: from one player, to one player, and from the
/// window to its server.
    // rust: pub(super) const PER_TICK: u32 = 32;

/// The messages waiting, and what each player used of this tick's allowance.
    // rust: pub(super) struct NativeNet {
    // rust: from_players: Vec<(u128, Message)>,
    // rust: from_counts: HashMap<u128, u32>,
    // rust: to_players: Vec<(u128, Vec<u8>)>,
    // rust: to_counts: HashMap<u128, u32>,
    // rust: pub(super) to_server: u32,
}

/// A message's payload as `native_net_send_*` check it.
pub fn payload(channel: []const u8, data: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !mod_net::channel_ok(channel) {
    // rust: return Err(format!("the channel {channel:?} is not mod_id:name"));
}
    // rust: mod_net::encode(&Message {
    // rust: channel: channel.to_owned(),
    // rust: data: data.to_vec(),
    // rust: })
    // rust: .map_err(|e| e.to_string())
}

    // rust: impl Game<'_> {
    /// A `horizon:mod_net` payload from `conn`: queued for
    /// `run_native_net`. Past the caps it is dropped in silence.
    // rust: pub(super) fn guest_native_net(&mut self, host: &LanHost, conn: u32, data: &[u8]) {
    // rust: let Some(player) = host.hub.guest(conn).map(|g| g.uuid) else {
    // rust: return;
}
    // rust: let count = self.native_net.from_counts.entry(player).or_default();
    // rust: if *count >= PER_TICK {
    // rust: return;
}
    // rust: *count += 1;
    // rust: if let Ok(message) = mod_net::decode(data) {
    // rust: self.native_net.from_players.push((player, message));
}
}

    /// Whether messages from players wait for `run_native_net`.
    // rust: pub(super) fn native_net_waiting(&self) -> bool {
    // rust: !self.native_net.from_players.is_empty()
}

    /// The waiting messages reach the mods, with the hub back in the game.
    // rust: pub(super) fn run_native_net(&mut self) {
    // rust: for (player, m) in std::mem::take(&mut self.native_net.from_players) {
    // rust: self.native_net_from_client(player, &m.channel, &m.data);
}
}

    /// What the mods sent this tick leaves; the tick's allowances start over.
    // rust: pub(super) fn flush_native_net(&mut self, host: &mut LanHost) {
    // rust: for (player, data) in std::mem::take(&mut self.native_net.to_players) {
    // rust: if let Some(g) = host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .find(|g| g.placed && g.uuid == player && g.brand == "horizon")
    // rust: {
    // rust: host.hub.send_to(
    // rust: g.conn,
    // rust: &C::CustomPayload(CustomPayload {
    // rust: channel: mod_net::CHANNEL.into(),
    // rust: data,
    // rust: }),
    // rust: );
}
}
        // The allowance is a server tick's, not a level pass's: it starts over
        // after the last level.
    // rust: if self.level_pass.last {
    // rust: self.native_net.from_counts.clear();
    // rust: self.native_net.to_counts.clear();
}
}

    /// A `horizon:mod_net` payload the server sent the window.
    // rust: pub(super) fn remote_native_net(&mut self, data: &[u8]) {
    // rust: match mod_net::decode(data) {
    // rust: Ok(m) => self.native_net_from_server(&m.channel, &m.data),
    // rust: Err(e) => log::debug!("Horizon: a bad mod message: {e}"),
}
}
}

// Native mods use these; nothing in Horizon does.
    // rust: impl Game<'_> {
    /// Sends `data` on `channel` (`mod_id:name`, at most 30 000 bytes, at
    /// most 32 a player a tick) to `player`'s client, at the tick's end, from
    /// any server hook. Ok means accepted: a player who left or isn't on a
    /// Horizon client doesn't get it. API 40.
    // rust: pub(super) fn native_net_send_to_player(
    // rust: &mut self,
    // rust: player: u128,
    // rust: channel: &str,
    // rust: data: &[u8],
    // rust: ) -> Result<(), String> {
    // rust: if self.remote.is_some() {
    // rust: return Err("a client has no players to send to".into());
}
    // rust: let payload = payload(channel, data)?;
    // rust: let count = self.native_net.to_counts.entry(player).or_default();
    // rust: if *count >= PER_TICK {
    // rust: return Err(format!("past {PER_TICK} messages to this player this tick"));
}
    // rust: *count += 1;
    // rust: self.native_net.to_players.push((player, payload));
    // rust: Ok(())
}

    /// The client half: sends `data` on `channel` to the server (the same
    /// caps, 32 a tick). An error when the server doesn't carry mod messages
    /// (a vanilla server), and until the player has joined: a server says it
    /// carries them during configuration, before it can take one. API 40.
    // rust: pub(super) fn native_net_send_to_server(
    // rust: &mut self,
    // rust: channel: &str,
    // rust: data: &[u8],
    // rust: ) -> Result<(), String> {
        // Not joined first: the announcement may still be on its way, and a
        // mod that gives up on "carries no mod messages" never tries again.
    // rust: let Some(remote) = self.remote.as_ref() else {
    // rust: return Err("the server carries no mod messages".into());
}
        // A server that reconfigures the player has them out of the play state.
    // rust: if !remote.joined || remote.reconfiguring.is_some() {
    // rust: return Err("the player has not joined yet".into());
}
    // rust: if !remote.mod_net {
    // rust: return Err("the server carries no mod messages".into());
}
    // rust: let payload = payload(channel, data)?;
    // rust: if self.native_net.to_server >= PER_TICK {
    // rust: return Err(format!("past {PER_TICK} messages this tick"));
}
    // rust: self.native_net.to_server += 1;
    // rust: self.send(S::CustomPayload(CustomPayload {
    // rust: channel: mod_net::CHANNEL.into(),
    // rust: data: payload,
    // rust: }));
    // rust: Ok(())
}

    /// A mod's chat line or command (`/` first), sent as `send_chat` sends
    /// it (ClientPacketListener.sendChat / sendCommand), to any server: no
    /// chat history, and no client chat event (vanilla's `ClientChatEvent`
    /// comes only from ChatScreen). An error when the player isn't in a
    /// server's play state or the Chat option blocks the message. API
    /// 404.
    // rust: pub(super) fn native_send_chat(&mut self, message: &str) -> Result<(), String> {
    // rust: let Some(remote) = self.remote.as_ref() else {
    // rust: return Err("not connected to a server".into());
}
        // A server that reconfigures the player has them out of the play state.
    // rust: if !remote.joined || remote.reconfiguring.is_some() {
    // rust: return Err("the player has not joined yet".into());
}
    // rust: let message = message.trim();
    // rust: if message.is_empty() {
    // rust: return Err("the message is empty".into());
}
    // rust: if !self.chat_abilities().allows(message) {
    // rust: return Err("the Chat option blocks this message".into());
}
    // rust: self.send_chat(message);
    // rust: Ok(())
}

    /// Sends `packet` to the server as it is, to any server, a vanilla one
    /// included: a plugin channel's payload (`ServerboundCustomPayloadPacket`)
    /// or any other play packet. Nothing counts it, and the game doesn't apply
    /// it on its side: a packet that needs a sequence number, a signature or
    /// the client's own state is the mod's to get right. An error when the
    /// player isn't in a server's play state, and for a custom payload past
    /// `ServerboundCustomPayloadPacket.MAX_PAYLOAD_SIZE`, which a server
    /// disconnects for. API 409.
    // rust: pub(super) fn native_send_packet(
    // rust: &mut self,
    // rust: packet: ServerboundPlayPacket,
    // rust: ) -> Result<(), String> {
    // rust: let Some(remote) = self.remote.as_ref() else {
    // rust: return Err("not connected to a server".into());
}
        // A server that reconfigures the player has them out of the play state.
    // rust: if !remote.joined || remote.reconfiguring.is_some() {
    // rust: return Err("the player has not joined yet".into());
}
    // rust: if let S::CustomPayload(payload) = &packet
    // rust: && payload.data.len() > quiet::MAX_PAYLOAD
    // rust: {
    // rust: return Err(format!("the payload is past {} bytes", quiet::MAX_PAYLOAD));
}
    // rust: self.send(packet);
    // rust: Ok(())
}
}

    // rust: mod tests {
//     use super::super::{
    // rust: Audio, Game, Options, Progress, Settings, execution_role::ExecutionRole, load_resources,
}
//     use super::{CustomPayload, S, quiet};
//     use horizon_protocol::{connection::Pipe, packets::configuration::Ping};

    /// A mod's packet goes out only from a joined player, and a custom
    /// payload only within vanilla's size limit.
pub fn mod_packets_need_a_joined_player_and_a_payload_within_the_limit() void {
}
    // rust: let root = std::path::PathBuf::from(
    // rust: std::env::var_os("HORIZON_TEST_RESOURCES")
    // rust: .expect("set HORIZON_TEST_RESOURCES to prepared resources"),
    // rust: );
    // rust: let settings = Settings::default();
    // rust: let loaded = load_resources(
    // rust: root.clone(),
    // rust: None,
    // rust: &root,
    // rust: &settings,
    // rust: std::time::Instant::now(),
    // rust: false,
    // rust: true,
    // rust: &Progress::new(),
    // rust: &mut |_, _| unreachable!("no menu handoff"),
    // rust: )
    // rust: .unwrap();
    // rust: let mut options = Options::parse(std::iter::empty()).unwrap().unwrap();
    // rust: options.resources = root.clone();
    // rust: options.execution_role = ExecutionRole::Client;
    // rust: let mut game = Game::new(
    // rust: &loaded.resources,
    // rust: loaded.pack,
    // rust: loaded.gui.unwrap(),
    // rust: options,
    // rust: settings,
    // rust: Audio::silent(&root),
    // rust: None,
    // rust: )
    // rust: .unwrap();
    // rust: let payload = |len| {
    // rust: S::CustomPayload(CustomPayload {
    // rust: channel: "voicechat:request_secret".into(),
    // rust: data: vec![0; len],
    // rust: })
}

    // rust: assert!(game.native_send_packet(payload(4)).is_err());
    // rust: let (client, _server) = Pipe::pair();
    // rust: game.connect_local(client, "PacketTest").unwrap();
    // rust: assert!(game.native_send_packet(payload(4)).is_err());
    // rust: game.remote.as_mut().unwrap().joined = true;
    // rust: assert!(game.native_send_packet(payload(4)).is_ok());
    // rust: assert!(game.native_send_packet(payload(quiet::MAX_PAYLOAD)).is_ok());
    // rust: assert!(
    // rust: game.native_send_packet(payload(quiet::MAX_PAYLOAD + 1))
    // rust: .is_err()
    // rust: );
    // rust: assert!(game.native_send_packet(S::Pong(Ping { id: 7 })).is_ok());
}
}
