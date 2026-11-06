//! Transpiled from Horizon Rust crate
//! Module: horizon-client_mod
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Hosting a world on the local network. The network side lives here: the
//! listener, the per-connection handshake/login/configuration threads
//! (`conn`), the network threads every player in the play state is served on
//! (`io_pool`), plus the data the configuration phase sends (`data`). The play
//! state is driven by the game thread (`hub`), which only ever exchanges
//! decoded packets with these threads, so a world that is not open to the
//! network pays nothing.
    // rust: mod advancements;
    // rust: pub mod anticheat;
    // rust: pub mod arrivals;
    // rust: pub mod attributes;
    // rust: pub mod border;
    // rust: pub mod chunks;
    // rust: pub mod code_of_conduct;
    // rust: mod command_order;
    // rust: pub mod command_suggestions;
    // rust: pub mod commands;
    // rust: pub mod conn;
    // rust: pub mod containers;
    // rust: pub mod data;
    // rust: pub mod discovery;
    // rust: pub mod entity;
    // rust: pub mod far;
    // rust: pub mod forwarding;
    // rust: pub mod guest;
    // rust: pub mod handoff;
    // rust: pub mod hub;
    // rust: pub mod import;
    // rust: mod io_pool;
    // rust: pub mod menu;
    // rust: pub mod playerdata;
    // rust: pub mod prediction;
    // rust: pub mod recipes;
    // rust: pub mod scoreboard;
    // rust: mod sound_order;
    // rust: pub mod tracking;
    // rust: pub mod waypoints;

    // rust: pub use conn::{Holding, PlayerSender, flush_all};
// use horizon_protocol::packets::play;
// use horizon_protocol::{
    // rust: GAME_VERSION, PROTOCOL_VERSION, crypto::uuid_string, packets::configuration::ClientInformation,
    // rust: text::translatable,
}
// use std::{
    // rust: collections::HashMap,
    // rust: io,
    // rust: net::{IpAddr, SocketAddr, TcpListener, TcpStream},
    // rust: sync::{
    // rust: Arc, Mutex,
    // rust: atomic::{AtomicBool, AtomicI32, AtomicU32, AtomicU64, AtomicUsize, Ordering},
    // rust: mpsc::{Receiver, Sender, channel},
    // rust: },
    // rust: thread::JoinHandle,
    // rust: time::{Duration, Instant},
}

/// IntegratedServer.MAX_PLAYERS.
pub const MAX_PLAYERS: usize = 8;

/// Messages from the connection threads to the game thread.
pub const NetEvent = enum {
    /// A client finished configuration and enters the play state.
    Joined(Box<Joined>),
    /// A packet and the bytes of its body on the wire.
    Packet(u32, Box<play::Serverbound>, usize),
    /// The connection ended (reason for the log).
    Left(u32, String),
    /// PlayerList.disconnectAllPlayersWithProfile: a new login of this
    /// profile replaces the player already in the world.
    Duplicate(u128),
};
pub const Joined = struct {
    conn: u32,
    uuid: u128,
    name: []const u8,
    /// The profile's properties (skin textures, in online mode).
    properties: std.ArrayList(horizon_protocol::packets::login::Property),
    info: ClientInformation,
    brand: []const u8,
    sender: PlayerSender,
    /// Smoothed keep-alive round trip in milliseconds.
    latency: *AtomicI32,
    address: SocketAddr,
    /// The login used up an expectation of a proxy's (`player-expect`) when it
    /// started (`arrivals`).
    expected: bool,
};
/// What a [`PlayerSender`] made for a test's channel gives it.
pub const Out = enum {
    /// A packet body: VarInt id and payload.
    Packet(Vec<u8>),
    /// Packet bodies held during a tick, in order.
    Packets(Vec<Vec<u8>>),
    /// Send a play disconnect with this component, then close.
    Disconnect(horizon_world::nbt::Tag),
};

/// PlayerList.canPlayerLogin for a dedicated server: the disconnect reason
/// (bans, whitelist) for a profile connecting from an address, if refused.
    // rust: pub type LoginGate =
    // rust: Arc<dyn Fn(SocketAddr, u128, &str) -> Option<horizon_world::nbt::Tag> + Send + Sync>;

/// online-mode=true: the key pair the server made at startup
/// (MinecraftServer.initializeKeyPair) and how players are verified.
pub const OnlineMode = struct {
    key: horizon_protocol::rsa::RsaPrivateKey,
    /// The public key as X.509 (PublicKey.getEncoded), sent in the hello.
    public_der: std.ArrayList(u8),
    /// prevent-proxy-connections: the session service also checks the address.
    prevent_proxy: bool,
};

    // rust: impl OnlineMode {
    /// MinecraftServer.initializeKeyPair.
pub fn generate(prevent_proxy: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let key = horizon_protocol::rsa::RsaPrivateKey::generate(1024)
    // rust: .map_err(|e| format!("Failed to generate key pair: {e}"))?;
    // rust: Ok(Self {
    // rust: public_der: key.public_der(),
    // rust: key,
    // rust: prevent_proxy,
    // rust: })
}
    /// IntegratedServer.initServer (`setUsesAuthentication(true)`): a LAN or
    /// friends world authenticates its guests when the host is signed in;
    /// an offline name hosts in offline mode.
pub fn lan() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: crate::auth::current()?;
    // rust: Self::generate(false)
    // rust: .map_err(|e| log::warn!("LAN stays in offline mode: {e}"))
    // rust: .ok()
    // rust: .map(Arc::new)
}
}

/// The dedicated server's log for the login phase: (thread, level, line)
/// written as vanilla's Log4j would, and the language that turns a
/// disconnect reason into its text (Component.getString).
pub const NetLog = struct {
    write: Arc<dyn Fn([]const u8,
    lang: *horizon_protocol::text::Language,
    /// log-ips: addresses in the log, or "<ip address withheld>".
    log_ips: bool,
};

/// The server.properties key that lets only the Horizon client join (off unless "true").
pub const HORIZON_CLIENTS_ONLY: []const u8 = "horizon-clients-only";
/// What another client is told.
    // rust: pub const HORIZON_CLIENTS_ONLY_REASON: &str =
    // rust: "This server is for the Horizon client: playhorizon.dev";
/// The server.properties key (server.toml's `server.accept_older_clients`) that lets 26.2 clients join
/// (off unless "true").
pub const ACCEPT_OLDER_CLIENTS: []const u8 = "horizon-accept-older-clients";
/// What a 26.2 client is told while only its packet ids are translated (#10404).
    // rust: pub const OLDER_CLIENTS_UNFINISHED: &str =
    // rust: "This server lets 26.2 join, but Horizon cannot translate 26.2 yet: join with 26.3";

/// How the server side of the network behaves: an integrated server's LAN
/// uses the defaults, a dedicated server takes them from server.properties.
pub const NetConfig = struct {
    /// server-ip (all interfaces when absent).
    bind: ?std::net::IpAddr,
    /// 0 picks a free port.
    port: u16,
    motd: []const u8,
    max_players: usize,
    /// network-compression-threshold; negative disables compression.
    compression_threshold: i32,
    /// rate-limit: packets a second a player may average before being kicked
    /// (RateKickingConnection); 0 is off.
    rate_limit: i32,
    /// enable-status: answer status pings.
    enable_status: bool,
    hide_online_players: bool,
    /// server-icon.png (64x64 PNG bytes).
    favicon: ?std.ArrayList(u8),
    /// Secure chat (a dedicated server; none on a LAN world).
    secure_chat: ?*SecureChat,
    accepts_transfers: bool,
    /// LanServerPinger: announce the world on the local network.
    announce: bool,
    /// Accept connections from the network. Without it only local ones
    /// (`Lan::connect_local`): an integrated server not open to the LAN.
    listen: bool,
    /// Ops bypass a full server (ServerOpList.canBypassPlayerLimit).
    bypasses_limit: ?*dyn Fn(u128) - bool + Send + Sync>,
    gate: ?LoginGate,
    /// Online mode: players are authenticated (a LAN world's when its host is signed in).
    online: ?*OnlineMode,
    /// Behind a Velocity proxy: the secret its forwarded player information is signed with. Only an offline
    /// server (the proxy authenticates) uses it; without it a login is the plain offline one.
    forwarding_secret: ?std.ArrayList(u8),
    /// `[transfer]` on: the players a proxy said would arrive
    /// (`arrivals::Transfers`), shared with the hub. A login uses its
    /// expectation up as it starts, once the bans and the whitelist let it in.
    arrivals: ?*std::sync::Mutex<arrivals::Expectations>,
    log: ?NetLog,
    /// server.properties `resource-pack`: offered to every player during
    /// configuration (a dedicated server's; MinecraftServer.getServerResourcePack).
    resource_pack: ?crate::server::properties::ResourcePackInfo,
    /// `enable-code-of-conduct`: the `codeofconduct/<language>.txt` texts
    /// (`MinecraftServer.getCodeOfConducts`), offered before the resource
    /// pack. Empty: no code of conduct.
    code_of_conducts: Vec<([]const u8,
    /// MinecraftServer.serverLinks (a dedicated server's `bug-report-link`):
    /// sent in configuration when non-empty
    /// (ServerConfigurationPacketListenerImpl.startConfiguration).
    server_links: std.ArrayList(horizon_protocol::packets::configuration::ServerLink),
    /// An integrated server's owner profile: the properties the window's own
    /// (memory) connection logs in with.
    owner_profile: ?*OwnerProfile,
    /// `horizon-clients-only` (Horizon's own server.properties key, off): a
    /// client whose `minecraft:brand` isn't Horizon's is turned away during
    /// configuration. A brand can be spoofed: a gate, not security.
    horizon_clients_only: bool,
    /// `horizon-accept-older-clients` (off): a client of 26.2 joins too, its packets renumbered
    /// (horizon_protocol::adapter::ClientSession). Off, it is turned away as vanilla turns it away.
    accept_older_clients: bool,
    /// Lets an older client past configuration although only its packet ids are translated yet
    /// (#10404's later parts translate the registry ids and the packets whose layout changed): for tests
    /// of the id renumbering, never in server.toml. False, such a client is told
    /// [`OLDER_CLIENTS_UNFINISHED`] before any registry data, tag or play packet would reach it in 26.3's
    /// ids and layouts.
    older_clients_play: bool,
    /// `horizon-lod-distance` (Horizon's own server.properties key, 64): how
    /// far, in chunks, the server samples far terrain for Horizon clients
    /// (`lod_net`); 0 serves none.
    lod_distance: u32,
    /// The shapes of the world's levels: their dimension types go to
    /// clients when the world's data packs changed them.
    levels: crate::chunk::LevelShapes,
};
    // rust: impl NetConfig {
    /// A real TCP server confined to this machine, without multicast announcements.
    /// Use this for socket tests; `lan` retains the public LAN behaviour.
pub fn loopback(port: u16, motd: []const u8, max_players: usize) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: bind: Some(std::net::Ipv4Addr::LOCALHOST.into()),
    // rust: announce: false,
    // rust: ..Self::lan(port, motd, max_players)
}
}
    /// MinecraftServer.enforceSecureProfile.
pub fn enforces_secure_chat(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.secure_chat.as_ref().is_some_and(|s| s.enforced())
}
    /// IntegratedServer.publishServer.
pub fn lan(port: u16, motd: []const u8, max_players: usize) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: bind: None,
    // rust: port,
    // rust: motd,
    // rust: max_players,
    // rust: compression_threshold: 256,
    // rust: rate_limit: 0,
    // rust: enable_status: true,
    // rust: hide_online_players: false,
    // rust: favicon: None,
    // rust: secure_chat: None,
    // rust: accepts_transfers: false,
    // rust: announce: true,
    // rust: listen: true,
    // rust: bypasses_limit: None,
    // rust: gate: None,
    // rust: online: None,
    // rust: forwarding_secret: None,
    // rust: arrivals: None,
    // rust: log: None,
    // rust: resource_pack: None,
    // rust: code_of_conducts: Vec::new(),
    // rust: server_links: Vec::new(),
    // rust: horizon_clients_only: false,
    // rust: accept_older_clients: false,
    // rust: older_clients_play: false,
    // rust: lod_distance: crate::lod_net::DEFAULT_DISTANCE,
    // rust: levels: crate::chunk::LevelShapes::VANILLA,
    // rust: owner_profile: None,
}
}
}

/// `IntegratedServer.getSingleplayerProfile` (`Minecraft.getGameProfile`):
/// the signed-in account's profile properties, its signed `textures` among
/// them, which the player list gives the owner so that LAN guests see the
/// owner's skin. Fetched in the background from the world's start; nothing
/// waits for it: until it answers (or when it fails) the owner is listed
/// without properties, as before.
pub const OwnerProfile = struct {
    properties: std::sync::OnceLock<std.ArrayList(horizon_protocol::packets::login::Property)>,
    fetch: Mutex<Receiver<std.ArrayList(horizon_protocol::packets::login::Property)>>,
};

    // rust: impl OwnerProfile {
    // rust: pub fn new(
    // rust: fetch: impl FnOnce() -> Vec<horizon_protocol::packets::login::Property> + Send + 'static,
    // rust: ) -> Self {
    // rust: let (send, receive) = channel();
    // rust: let _ = std::thread::Builder::new()
    // rust: .name("Profile fetcher".into())
    // rust: .spawn(move || {
    // rust: let _ = send.send(fetch());
    // rust: });
    // rust: Self {
    // rust: properties: std::sync::OnceLock::new(),
    // rust: fetch: Mutex::new(receive),
}
}
    /// The owner's properties once fetched; empty while the fetch is out
    /// or when it failed. Never blocks.
pub fn properties(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(properties) = self.properties.get() {
    // rust: return properties;
}
    // rust: let received = self.fetch.lock().ok().and_then(|r| match r.try_recv() {
    // rust: Ok(properties) => Some(properties),
    // rust: Err(std::sync::mpsc::TryRecvError::Disconnected) => Some(Vec::new()),
    // rust: Err(std::sync::mpsc::TryRecvError::Empty) => None,
    // rust: });
    // rust: match received {
    // rust: Some(properties) => self.properties.get_or_init(|| properties),
    // rust: None => &[],
}
}
}

/// A dedicated server's secure chat (DedicatedServer.enforceSecureProfile,
/// Services.profileKeySignatureValidator): the services' profile-key keys,
/// fetched in the background from startup and waited for by their first
/// use, as authlib's RetryableFetch does.
pub const SecureChat = struct {
    /// enforce-secure-profile, in online mode.
    enforce: bool,
    keys: std::sync::OnceLock<std.ArrayList(horizon_protocol::rsa::RsaPublicKey)>,
    fetch: Mutex<?JoinHandle<std.ArrayList(horizon_protocol::rsa::RsaPublicKey)>>,
};

    // rust: impl SecureChat {
    // rust: pub fn new(
    // rust: enforce: bool,
    // rust: fetch: impl FnOnce() -> Vec<horizon_protocol::rsa::RsaPublicKey> + Send + 'static,
    // rust: ) -> Self {
    // rust: let handle = std::thread::Builder::new()
    // rust: .name("Services keys".into())
    // rust: .spawn(fetch)
    // rust: .ok();
    // rust: Self {
    // rust: enforce,
    // rust: keys: std::sync::OnceLock::new(),
    // rust: fetch: Mutex::new(handle),
}
}
    /// The keys players' chat keys must be signed by (none when the
    /// services couldn't be reached).
pub fn keys(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.keys.get_or_init(|| {
    // rust: let handle = self.fetch.lock().ok().and_then(|mut h| h.take());
    // rust: handle.and_then(|h| h.join().ok()).unwrap_or_default()
    // rust: })
}
    /// enforceSecureProfile: enforced, and able to check keys.
pub fn enforced(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.enforce && !self.keys().is_empty()
}
}

/// State shared with the connection threads.
pub const Shared = struct {
    /// What the next login is sent; `PlayerList.reloadResources` swaps it.
    sync: Mutex<*data::SyncData>,
    events: Sender<NetEvent>,
    config: NetConfig,
    motd: Mutex<[]const u8>,
    max_players: AtomicUsize,
    hide_online_players: AtomicBool,
    enable_status: AtomicBool,
    /// `DedicatedServer.setAcceptsTransfers`: whether a login by transfer from another server
    /// is accepted (`accepts-transfers`), live.
    accepts_transfers: AtomicBool,
    /// PlayerList.players in join order: profile id and name.
    online: Mutex<Vec<(u128,
    next: AtomicU32,
    stop: AtomicBool,
    random: Mutex<u64>,
    /// Connections accepted from the network whose thread still runs.
    connections: AtomicUsize,
    /// Those connections by address.
    by_address: Mutex<HashMap<IpAddr,
    /// Those not playing yet (handshake, status, login, configuration), oldest first.
    waiting: Mutex<std.ArrayList(Waiting)>,
    next_connection: AtomicU64,
    /// Those whose play ended, waiting for their writer to finish.
    closing: AtomicUsize,
    /// Connections turned away since the last report of them, and when that was.
    turned_away: Mutex<(usize,
};
    // rust: impl Shared {
    /// The registries and tags a new connection is sent.
pub fn sync(self: *Self) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.sync.lock().unwrap_or_else(|e| e.into_inner()).clone()
}
    /// `/reload`: the data new connections are sent from now on.
pub fn set_sync(self: *Self, sync: *data::SyncData) void {
}
    // rust: *self.sync.lock().unwrap_or_else(|e| e.into_inner()) = sync;
}
pub fn next_id(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.next.fetch_add(1, Ordering::Relaxed)
}
    /// PlayerList.canPlayerLogin then disconnectAllPlayersWithProfile: the
    /// refusal reason, or None once the profile holds a place. A profile
    /// already playing is kicked and its place awaited.
    // rust: pub fn try_admit(
    // rust: &self,
    // rust: address: SocketAddr,
    // rust: uuid: u128,
    // rust: name: &str,
    // rust: ) -> Option<horizon_world::nbt::Tag> {
    // rust: if let Some(gate) = &self.config.gate
    // rust: && let Some(reason) = gate(address, uuid, name)
    // rust: {
    // rust: return Some(reason);
}
    // rust: {
    // rust: let online = self.online.lock().unwrap();
    // rust: let bypass = self.config.bypasses_limit.as_ref().is_some_and(|b| b(uuid));
    // rust: let taken = online.len();
    // rust: if taken >= self.max_players() && !bypass {
    // rust: return Some(translatable("multiplayer.disconnect.server_full", &[]));
}
}
    // rust: if self.is_online(uuid) {
    // rust: let _ = self.events.send(NetEvent::Duplicate(uuid));
    // rust: let deadline = std::time::Instant::now() + Duration::from_secs(30);
    // rust: while self.is_online(uuid) {
    // rust: if std::time::Instant::now() > deadline {
    // rust: return Some(translatable("multiplayer.disconnect.slow_login", &[]));
}
    // rust: std::thread::sleep(Duration::from_millis(10));
}
}
    // rust: self.online.lock().unwrap().push((uuid, name.to_owned()));
    // rust: None
}
pub fn is_online(self: *Self, uuid: u128) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.online.lock().unwrap().iter().any(|(u, _)| *u == uuid)
}
pub fn motd(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.motd.lock().unwrap().clone()
}
pub fn set_motd(self: *Self, motd: []const u8) void {
}
    // rust: *self.motd.lock().unwrap() = motd;
}
pub fn max_players(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.max_players.load(Ordering::Relaxed)
}
    /// `PlayerList.setMaxPlayers`: change the limit used by new logins and status responses.
pub fn set_max_players(self: *Self, max_players: usize) void {
}
    // rust: self.max_players.store(max_players, Ordering::Relaxed);
}
    /// `DedicatedServer.setHidesOnlinePlayers`: change whether status responses include player names.
pub fn hide_online_players(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.hide_online_players.load(Ordering::Relaxed)
}
pub fn set_hide_online_players(self: *Self, hide: bool) void {
}
    // rust: self.hide_online_players.store(hide, Ordering::Relaxed);
}
    /// `DedicatedServer.setRepliesToStatus`: change whether status pings are answered.
pub fn enable_status(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.enable_status.load(Ordering::Relaxed)
}
pub fn set_enable_status(self: *Self, enable: bool) void {
}
    // rust: self.enable_status.store(enable, Ordering::Relaxed);
}
pub fn accepts_transfers(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.accepts_transfers.load(Ordering::Relaxed)
}
    /// `DedicatedServer.setAcceptsTransfers`: the handshake of a transfer is accepted or turned
    /// away from now on.
pub fn set_accepts_transfers(self: *Self, accept: bool) void {
}
    // rust: self.accepts_transfers.store(accept, Ordering::Relaxed);
}
pub fn release(self: *Self, uuid: u128) void {
}
    // rust: self.online.lock().unwrap().retain(|(u, _)| *u != uuid);
}
pub fn online(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.online.lock().unwrap().len()
}
pub fn next_random(self: *Self, bound: usize) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut r = self.random.lock().unwrap();
    // rust: *r = r
    // rust: .wrapping_mul(6_364_136_223_846_793_005)
    // rust: .wrapping_add(1_442_695_040_888_963_407);
    // rust: ((*r >> 33) as usize) % bound.max(1)
}
    /// The status response (MinecraftServer.buildServerStatus encoded with
    /// ServerStatus.CODEC): description, players with up to 12 shuffled
    /// names, version, favicon and enforcesSecureChat when true.
pub fn status_json(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.status_json_for(PROTOCOL_VERSION)
}
    /// [`Self::status_json`] stating `protocol`: an older client's own, when it may join.
pub fn status_json_for(self: *Self, protocol: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
//         use crate::server::json::Json;
    // rust: let motd = self.motd.lock().unwrap().clone();
    // rust: let online: Vec<(u128, String)> = self.online.lock().unwrap().clone();
    // rust: let count = self.online();
    // rust: let mut players = vec![
    // rust: (
    // rust: "max".to_owned(),
    // rust: Json::Number(self.max_players().to_string()),
    // rust: ),
    // rust: ("online".to_owned(), Json::Number(count.to_string())),
    // rust: ];
    // rust: if !self.hide_online_players() && !online.is_empty() {
    // rust: let size = online.len().min(12);
    // rust: let offset = self.next_random(online.len() - size + 1);
    // rust: let mut sample: Vec<(u128, String)> = online[offset..offset + size].to_vec();
    // rust: for i in (1..sample.len()).rev() {
    // rust: let j = self.next_random(i + 1);
    // rust: sample.swap(i, j);
}
    // rust: players.push((
    // rust: "sample".to_owned(),
    // rust: Json::Array(
    // rust: sample
    // rust: .into_iter()
    // rust: .map(|(u, n)| {
    // rust: Json::Object(vec![
    // rust: ("id".to_owned(), Json::String(uuid_string(u))),
    // rust: ("name".to_owned(), Json::String(n)),
    // rust: ])
    // rust: })
    // rust: .collect(),
    // rust: ),
    // rust: ));
}
    // rust: let mut status = vec![
    // rust: ("description".to_owned(), Json::String(motd)),
    // rust: ("players".to_owned(), Json::Object(players)),
    // rust: (
    // rust: "version".to_owned(),
    // rust: Json::Object(vec![
    // rust: ("name".to_owned(), Json::String(GAME_VERSION.to_owned())),
    // rust: ("protocol".to_owned(), Json::Number(protocol.to_string())),
    // rust: ]),
    // rust: ),
    // rust: ];
    // rust: if let Some(icon) = &self.config.favicon {
    // rust: status.push((
    // rust: "favicon".to_owned(),
    // rust: Json::String(format!("data:image/png;base64,{}", base64(icon))),
    // rust: ));
}
    // rust: if self.config.enforces_secure_chat() {
    // rust: status.push(("enforcesSecureChat".to_owned(), Json::Bool(true)));
}
    // rust: Json::Object(status).compact()
}
}

/// java.util.Base64.getEncoder (padded, no line breaks).
pub fn base64(data: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
pub const A: []const u8 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    // rust: let mut out = String::with_capacity(data.len().div_ceil(3) * 4);
    // rust: for chunk in data.chunks(3) {
    // rust: let b = [
    // rust: chunk[0],
    // rust: *chunk.get(1).unwrap_or(&0),
    // rust: *chunk.get(2).unwrap_or(&0),
    // rust: ];
    // rust: let n = u32::from(b[0]) << 16 | u32::from(b[1]) << 8 | u32::from(b[2]);
    // rust: out.push(char::from(A[(n >> 18) as usize & 63]));
    // rust: out.push(char::from(A[(n >> 12) as usize & 63]));
    // rust: out.push(if chunk.len() > 1 {
    // rust: char::from(A[(n >> 6) as usize & 63])
    // rust: } else {
    // rust: '='
    // rust: });
    // rust: out.push(if chunk.len() > 2 {
    // rust: char::from(A[n as usize & 63])
    // rust: } else {
    // rust: '='
    // rust: });
}
    // rust: out
}

/// A running LAN server.
pub const Lan = struct {
    shared: *Shared,
    events: Receiver<NetEvent>,
    port: u16,
    listener: ?JoinHandle<()>,
    /// Stops the accept loop alone: local connections stay.
    listener_stop: *AtomicBool,
    /// The multicast announcement (LanServerPinger); absent when the socket failed.
    _pinger: ?discovery::Pinger,
};
    // rust: impl Lan {
    /// Listen on `port` (0 picks a free one).
    // rust: pub fn start(
    // rust: sync: Arc<data::SyncData>,
    // rust: port: u16,
    // rust: motd: String,
    // rust: max_players: usize,
    // rust: ) -> io::Result<Self> {
    // rust: Self::start_with(sync, NetConfig::lan(port, motd, max_players))
}
    /// ServerConnectionListener.startTcpServerListener with a configuration.
pub fn start_with(sync: *data::SyncData, config: NetConfig) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (tx, events) = channel();
    // rust: let (listen, port, announce) = (config.listen, config.port, config.announce);
    // rust: let hide_online_players = config.hide_online_players;
    // rust: let enable_status = config.enable_status;
    // rust: let shared = Arc::new(Shared {
    // rust: sync: Mutex::new(sync),
    // rust: events: tx,
    // rust: motd: Mutex::new(config.motd.clone()),
    // rust: max_players: AtomicUsize::new(config.max_players),
    // rust: hide_online_players: AtomicBool::new(hide_online_players),
    // rust: enable_status: AtomicBool::new(enable_status),
    // rust: accepts_transfers: AtomicBool::new(config.accepts_transfers),
    // rust: online: Mutex::new(Vec::new()),
    // rust: next: AtomicU32::new(1),
    // rust: stop: AtomicBool::new(false),
    // rust: connections: AtomicUsize::new(0),
    // rust: by_address: Mutex::new(HashMap::new()),
    // rust: waiting: Mutex::new(Vec::new()),
    // rust: next_connection: AtomicU64::new(0),
    // rust: closing: AtomicUsize::new(0),
    // rust: turned_away: Mutex::new((0, None)),
    // rust: random: Mutex::new(crate::server::java_properties::now_millis() as u64 | 1),
    // rust: config,
    // rust: });
    // rust: let mut lan = Self {
    // rust: shared,
    // rust: events,
    // rust: port: 0,
    // rust: listener: None,
    // rust: listener_stop: Arc::new(AtomicBool::new(false)),
    // rust: _pinger: None,
}
    // rust: if listen {
    // rust: lan.listen(port, announce)?;
}
    // rust: Ok(lan)
}
    /// Start accepting connections on `port` (0 picks a free one), and
    /// announce the world on the local network when `announce`
    /// (`IntegratedServer.publishServer`'s LanServerPinger). Returns the port.
pub fn listen(self: *Self, port: u16, announce: bool) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.listener.is_some() {
    // rust: return Err(io::Error::new(
    // rust: io::ErrorKind::AlreadyExists,
    // rust: "already listening",
    // rust: ));
}
    // rust: let listener = Self::bind(self.shared.config.bind, port)?;
    // rust: self.listen_on(listener, announce)
}
    /// The socket [`Lan::listen`] accepts on, bound ahead so that a failure
    /// can be reported before the hub is at hand.
pub fn bind(address: ?std::net::IpAddr, port: u16) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let bind = address.unwrap_or_else(|| {
    // rust: if test_loopback() {
    // rust: std::net::Ipv4Addr::LOCALHOST.into()
    // rust: } else {
    // rust: std::net::Ipv4Addr::UNSPECIFIED.into()
}
    // rust: });
    // rust: let listener = TcpListener::bind((bind, port))?;
    // rust: listener.set_nonblocking(true)?;
    // rust: Ok(listener)
}
    /// [`Lan::listen`] on a socket already bound.
pub fn listen_on(self: *Self, listener: TcpListener, announce: bool) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.listener.is_some() {
    // rust: return Err(io::Error::new(
    // rust: io::ErrorKind::AlreadyExists,
    // rust: "already listening",
    // rust: ));
}
    // rust: let port = listener.local_addr()?.port();
    // rust: let stop = Arc::new(AtomicBool::new(false));
    // rust: let (accept_shared, accept_stop) = (self.shared.clone(), stop.clone());
    // rust: let thread = std::thread::Builder::new()
    // rust: .name("horizon-lan-accept".into())
    // rust: .spawn(move || accept_loop(listener, accept_shared, &accept_stop))?;
    // rust: self._pinger = if announce && !test_loopback() {
    // rust: discovery::Pinger::start(self.shared.motd(), port).ok()
    // rust: } else {
    // rust: None
}
    // rust: self.listener = Some(thread);
    // rust: self.listener_stop = stop;
    // rust: self.port = port;
    // rust: Ok(port)
}
    /// Stop accepting connections and announcing; connections already in
    /// (the local one included) stay.
pub fn stop_listening(self: *Self) void {
}
    // rust: self.listener_stop.store(true, Ordering::Relaxed);
    // rust: if let Some(t) = self.listener.take() {
    // rust: let _ = t.join();
}
    // rust: self._pinger = None;
    // rust: self.port = 0;
}
    /// Whether connections from the network are accepted.
pub fn listening(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.listener.is_some()
}
    /// `Connection.connectToLocalServer`: a connection through memory, its
    /// server end served on its own thread like an accepted socket.
pub fn connect_local(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (client, server) = horizon_protocol::connection::Pipe::pair();
    // rust: let shared = self.shared.clone();
    // rust: std::thread::Builder::new()
    // rust: .name("horizon-local-conn".into())
    // rust: .spawn(move || {
    // rust: if let Err(e) = conn::serve_local(server, shared)
    // rust: && std::env::var_os("HORIZON_NET_DEBUG").is_some()
    // rust: {
    // rust: log::warn!("[lan] local: {e}");
}
    // rust: })?;
    // rust: Ok(client)
}
    /// Everything the connection threads reported since the last call.
pub fn poll(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.events.try_iter().collect()
}
pub fn stop(self: *Self) void {
}
    // rust: self.shared.stop.store(true, Ordering::Relaxed);
    // rust: self.stop_listening();
}
}
    // rust: impl Drop for Lan {
pub fn drop(self: *Self) void {
}
    // rust: self.stop();
}
}

/// Connections from the network accepted beyond the server's player limit.
pub const SPARE_CONNECTIONS: usize = 64;

/// Connections from one address at once (a household or a school behind one address plays well
/// under it): past it a new one is closed, so that one machine can't take the places
/// [`SPARE_CONNECTIONS`] leaves for everyone's logins and server-list pings. Not for a local or
/// private address: a proxy, a tunnel or a container's port forward hands every player over from
/// one of those.
pub const PER_ADDRESS: usize = 10;

/// Whether connections from `ip` may be many: it is this machine or the local network's.
pub fn shared_address(ip: IpAddr) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match ip {
    // rust: IpAddr::V4(v4) => v4.is_loopback() || v4.is_private() || v4.is_link_local(),
    // rust: IpAddr::V6(v6) => {
    // rust: v6.is_loopback()
    // rust: || v6.is_unique_local()
    // rust: || v6.is_unicast_link_local()
    // rust: || v6
    // rust: .to_ipv4_mapped()
    // rust: .is_some_and(|v4| shared_address(IpAddr::V4(v4)))
}
}
}

/// How often the log says how many connections were turned away, and who held the places.
pub const TURNED_AWAY_EVERY: Duration = Duration::from_secs(60);

/// How long a connection may wait before a full server closes it for a new one.
pub const MAKE_ROOM_AFTER: Duration = Duration::from_secs(2);

/// A network connection not playing yet.
pub const Waiting = struct {
    id: u64,
    since: Instant,
    stream: TcpStream,
};

    // rust: thread_local! {
    /// The [`Waiting`] connection this thread serves.
pub const WAITING: std::cell::Cell<?u64> = const { std::cell::Cell::new(None) };
}

/// An accepted connection, uncounted once its thread ends (or couldn't start).
pub const Counted = struct {};
    // rust: impl Drop for Counted {
pub fn drop(self: *Self) void {
}
    // rust: self.0
    // rust: .waiting
    // rust: .lock()
    // rust: .unwrap_or_else(|e| e.into_inner())
    // rust: .retain(|w| w.id != self.2);
    // rust: let mut by = self.0.by_address.lock().unwrap_or_else(|e| e.into_inner());
    // rust: if let Some(n) = by.get_mut(&self.1) {
    // rust: *n -= 1;
    // rust: if *n == 0 {
    // rust: by.remove(&self.1);
}
}
    // rust: self.0.connections.fetch_sub(1, Ordering::AcqRel);
}
}

    // rust: impl Shared {
    /// Counts a connection from `ip`, or None when `ip` holds its own most, or the server its
    /// most and no connection that waits could be closed to make room ([`Shared::make_room`]).
pub fn count(self: **Self, ip: IpAddr) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let most = self.max_players().saturating_add(SPARE_CONNECTIONS);
    // rust: let here = |by: &HashMap<IpAddr, usize>| by.get(&ip).copied().unwrap_or(0);
    // rust: let by = self.by_address.lock().unwrap_or_else(|e| e.into_inner());
    // rust: if here(&by) >= PER_ADDRESS && !shared_address(ip) {
    // rust: return None;
}
        // make_room logs, which reads by_address: never call it holding that lock.
    // rust: drop(by);
    // rust: if self.connections.load(Ordering::Acquire) >= most && !self.make_room() {
    // rust: return None;
}
    // rust: let mut by = self.by_address.lock().unwrap_or_else(|e| e.into_inner());
    // rust: let n = here(&by) + 1;
    // rust: by.insert(ip, n);
    // rust: self.connections.fetch_add(1, Ordering::AcqRel);
    // rust: let id = self.next_connection.fetch_add(1, Ordering::Relaxed);
    // rust: Some(Counted(self.clone(), ip, id))
}

    /// Notes `stream`, counted as `counted`, as waiting until it plays.
pub fn wait(self: *Self, counted: *Counted, stream: *TcpStream) void {
}
    // rust: if let Ok(stream) = stream.try_clone() {
    // rust: let w = Waiting {
    // rust: id: counted.2,
    // rust: since: Instant::now(),
    // rust: stream,
}
    // rust: self.waiting
    // rust: .lock()
    // rust: .unwrap_or_else(|e| e.into_inner())
    // rust: .push(w);
}
}

    /// The connection this thread serves plays now: a full server no longer closes it.
    // rust: pub(crate) fn entered_play(&self) {
    // rust: if let Some(id) = WAITING.take() {
    // rust: self.waiting
    // rust: .lock()
    // rust: .unwrap_or_else(|e| e.into_inner())
    // rust: .retain(|w| w.id != id);
}
}

    /// The server is full: closes the connection that has waited longest, if for more than
    /// [`MAKE_ROOM_AFTER`] (a login or a server-list ping takes a fraction of that), so that a
    /// crowd of sockets that never finish can't keep players out. Its thread ends at once. A
    /// player in the game is never closed.
pub fn make_room(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut waiting = self.waiting.lock().unwrap_or_else(|e| e.into_inner());
    // rust: let Some(oldest) = waiting
    // rust: .first()
    // rust: .filter(|w| w.since.elapsed() > MAKE_ROOM_AFTER)
    // rust: else {
    // rust: return false;
}
    // rust: let _ = oldest.stream.shutdown(std::net::Shutdown::Both);
    // rust: waiting.remove(0);
    // rust: drop(waiting);
    // rust: self.turned_away();
    // rust: true
}

    /// A connection was turned away: once a minute the log says how many, how many places were
    /// taken and by which addresses most.
pub fn turned_away(self: *Self) void {
}
    // rust: let mut away = self.turned_away.lock().unwrap_or_else(|e| e.into_inner());
    // rust: away.0 += 1;
    // rust: let now = Instant::now();
    // rust: if away.1.is_some_and(|last| now < last + TURNED_AWAY_EVERY) {
    // rust: return;
}
    // rust: let count = std::mem::take(&mut away.0);
    // rust: away.1 = Some(now);
    // rust: drop(away);
    // rust: let Some(log) = &self.config.log else {
    // rust: return;
}
    // rust: let most = self.max_players().saturating_add(SPARE_CONNECTIONS);
    // rust: let before_play = self.waiting.lock().unwrap_or_else(|e| e.into_inner()).len();
    // rust: let closing = self.closing.load(Ordering::Acquire);
    // rust: let mut held: Vec<(IpAddr, usize)> = self
    // rust: .by_address
    // rust: .lock()
    // rust: .unwrap_or_else(|e| e.into_inner())
    // rust: .iter()
    // rust: .map(|(&ip, &n)| (ip, n))
    // rust: .collect();
    // rust: held.sort_by_key(|a| std::cmp::Reverse(a.1));
    // rust: let addresses = held.len();
    // rust: let top = held
    // rust: .iter()
    // rust: .take(5)
    // rust: .map(|(ip, n)| {
    // rust: if log.log_ips {
    // rust: format!("{ip} ({n})")
    // rust: } else {
    // rust: format!("<ip address withheld> ({n})")
}
    // rust: })
    // rust: .collect::<Vec<_>>()
    // rust: .join(", ");
    // rust: (log.write)(
    // rust: "Server Connection Thread",
    // rust: "WARN",
    // rust: &format!(
    // rust: "Turned away {count} connection(s), or closed one that waited to make room: {} of \
    // rust: {most} places taken ({before_play} before play, {closing} closing), by \
    // rust: {addresses} address(es), most by {top} (at most {PER_ADDRESS} an address)",
    // rust: self.connections.load(Ordering::Acquire)
    // rust: ),
    // rust: );
}
}

pub fn accept_loop(listener: TcpListener, shared: *Shared, stop: *AtomicBool) void {
}
    // rust: while !shared.stop.load(Ordering::Relaxed) && !stop.load(Ordering::Relaxed) {
    // rust: match listener.accept() {
    // rust: Ok((stream, addr)) => {
                // A thread a connection, where vanilla's Netty has a few for all: past the players
                // the server takes and [`SPARE_CONNECTIONS`] more (logins, server-list pings), a
                // new one is closed at once, so that a flood of sockets can't use up the threads a
                // container allows and crash the server.
    // rust: let Some(counted) = shared.count(addr.ip()) else {
    // rust: drop(stream);
    // rust: shared.turned_away();
    // rust: continue;
}
    // rust: shared.wait(&counted, &stream);
    // rust: let _ = std::thread::Builder::new()
    // rust: .name("horizon-lan-conn".into())
    // rust: .spawn(move || {
    // rust: WAITING.set(Some(counted.2));
    // rust: handle(stream, addr, counted);
    // rust: });
}
    // rust: Err(e) if e.kind() == io::ErrorKind::WouldBlock => {
    // rust: std::thread::sleep(Duration::from_millis(25));
}
    // rust: Err(_) => std::thread::sleep(Duration::from_millis(100)),
}
}
}
pub fn handle(stream: TcpStream, addr: SocketAddr, counted: Counted) void {
}
    // rust: let _ = stream.set_nonblocking(false);
    // rust: let shared = counted.0.clone();
    // rust: if let Err(e) = conn::serve(stream, addr, shared, counted)
    // rust: && std::env::var_os("HORIZON_NET_DEBUG").is_some()
    // rust: {
    // rust: log::warn!("[lan] {addr}: {e}");
}
}

/// HttpUtil.getAvailablePort: a free local port.
pub fn available_port() u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let bind = if cfg!(test) || test_loopback() {
    // rust: "127.0.0.1"
    // rust: } else {
    // rust: "0.0.0.0"
}
    // rust: TcpListener::bind((bind, 0))
    // rust: .and_then(|l| l.local_addr())
    // rust: .map_or(25565, |a| a.port())
}

/// Same-machine harnesses opt in; real LAN runs keep the normal network interfaces.
    // rust: pub(super) fn test_loopback() -> bool {
    // rust: std::env::var_os("HORIZON_TEST_LOOPBACK").is_some_and(|v| v == "1")
}

    // rust: mod tests {
pub fn a_local_server_accepts_only_the_requested_loopback_address() void {
}
    // rust: let lan = super::Lan::start_with(
    // rust: std::sync::Arc::new(super::data::SyncData::empty()),
    // rust: super::NetConfig::loopback(0, "Local test".into(), 1),
    // rust: )
    // rust: .unwrap();
    // rust: let local = std::net::TcpStream::connect(("127.0.0.1", lan.port)).unwrap();
    // rust: let other = "127.0.0.2".parse::<std::net::IpAddr>().unwrap();
    // rust: assert!(
    // rust: std::net::TcpStream::connect_timeout(
    // rust: &std::net::SocketAddr::new(other, lan.port),
    // rust: std::time::Duration::from_millis(500),
    // rust: )
    // rust: .is_err()
    // rust: );
    // rust: drop(local);
}
//     use super::conn::MEMORY_ADDRESS;
//     use super::*;
//     use std::{io::Read, time::Instant};

    /// Sockets that never say a word each hold a connection thread until their read times out: past
    /// the player limit and [`SPARE_CONNECTIONS`], a new one is closed at once instead of taking one
    /// more thread, and the room comes back as they go.
pub fn a_flood_of_silent_sockets_is_turned_away() void {
}
    // rust: let config = NetConfig {
    // rust: announce: false,
    // rust: ..NetConfig::loopback(0, "Flood".into(), 1)
}
    // rust: let lan = Lan::start_with(Arc::new(data::SyncData::empty()), config).unwrap();
    // rust: let address = (std::net::Ipv4Addr::LOCALHOST, lan.port);
    // rust: let most = 1 + SPARE_CONNECTIONS;
    // rust: let held: Vec<TcpStream> = (0..most)
    // rust: .map(|_| TcpStream::connect(address).unwrap())
    // rust: .collect();
    // rust: let deadline = Instant::now() + Duration::from_secs(10);
    // rust: while lan.shared.connections.load(Ordering::Acquire) < most {
    // rust: assert!(
    // rust: Instant::now() < deadline,
    // rust: "the held sockets were not all accepted"
    // rust: );
    // rust: std::thread::sleep(Duration::from_millis(10));
}
    // rust: let mut late = TcpStream::connect(address).unwrap();
    // rust: late.set_read_timeout(Some(Duration::from_secs(5))).unwrap();
    // rust: let mut byte = [0u8; 1];
    // rust: assert!(
    // rust: match late.read(&mut byte) {
    // rust: Ok(n) => n == 0,
    // rust: Err(e) => !matches!(
    // rust: e.kind(),
    // rust: io::ErrorKind::WouldBlock | io::ErrorKind::TimedOut
    // rust: ),
    // rust: },
    // rust: "the socket past the limit should be closed"
    // rust: );
    // rust: assert_eq!(lan.shared.connections.load(Ordering::Acquire), most);
    // rust: drop(held);
    // rust: while lan.shared.connections.load(Ordering::Acquire) > 0 {
    // rust: assert!(
    // rust: Instant::now() < deadline,
    // rust: "the closed sockets' threads did not end"
    // rust: );
    // rust: std::thread::sleep(Duration::from_millis(10));
}
}

pub fn hide_online_players_updates_status_response() void {
}
    // rust: let config = NetConfig {
    // rust: announce: false,
    // rust: listen: false,
    // rust: ..NetConfig::loopback(0, "Status".into(), 8)
}
    // rust: let lan = Lan::start_with(Arc::new(data::SyncData::empty()), config).unwrap();
    // rust: assert!(lan.shared.try_admit(MEMORY_ADDRESS, 1, "Player").is_none());
    // rust: assert!(lan.shared.status_json().contains("\"sample\""));
    // rust: lan.shared.set_hide_online_players(true);
    // rust: let hidden = lan.shared.status_json();
    // rust: assert!(!hidden.contains("\"sample\""));
    // rust: assert!(!hidden.contains("Player"));
}

    /// One public address takes at most [`PER_ADDRESS`] places, its own coming back as they end;
    /// another address, or a local one (a proxy hands everyone over from it), still gets one.
pub fn one_address_takes_at_most_its_share() void {
}
    // rust: let config = NetConfig {
    // rust: announce: false,
    // rust: listen: false,
    // rust: ..NetConfig::loopback(0, "Share".into(), 20)
}
    // rust: let lan = Lan::start_with(Arc::new(data::SyncData::empty()), config).unwrap();
    // rust: let ip = |s: &str| s.parse::<IpAddr>().unwrap();
    // rust: let mut one: Vec<Counted> = (0..PER_ADDRESS)
    // rust: .map(|_| lan.shared.count(ip("203.0.113.7")).unwrap())
    // rust: .collect();
    // rust: assert!(lan.shared.count(ip("203.0.113.7")).is_none());
    // rust: assert!(lan.shared.count(ip("198.51.100.2")).is_some());
    // rust: let local: Vec<Counted> = (0..PER_ADDRESS + 5)
    // rust: .map(|_| lan.shared.count(ip("127.0.0.1")).unwrap())
    // rust: .collect();
    // rust: assert!(lan.shared.count(ip("172.17.0.1")).is_some());
    // rust: one.pop();
    // rust: assert!(lan.shared.count(ip("203.0.113.7")).is_some());
    // rust: drop((one, local));
    // rust: assert!(lan.shared.by_address.lock().unwrap().is_empty());
    // rust: assert_eq!(lan.shared.connections.load(Ordering::Acquire), 0);
}

pub fn a_full_server_closes_the_connection_that_waited_longest() void {
}
//         use std::io::Read;
        // With a log writer, as on a dedicated server: making room logs, and must not deadlock.
    // rust: let lines = Arc::new(Mutex::new(Vec::<String>::new()));
    // rust: let into = lines.clone();
    // rust: let config = NetConfig {
    // rust: announce: false,
    // rust: listen: false,
    // rust: log: Some(NetLog {
    // rust: write: Arc::new(move |_, _, line| into.lock().unwrap().push(line.to_owned())),
    // rust: lang: Arc::new(Default::default()),
    // rust: log_ips: true,
    // rust: }),
    // rust: ..NetConfig::loopback(0, "Room".into(), 1)
}
    // rust: let lan = Lan::start_with(Arc::new(data::SyncData::empty()), config).unwrap();
    // rust: let shared = &lan.shared;
    // rust: let listener = std::net::TcpListener::bind("127.0.0.1:0").unwrap();
    // rust: let mut client = TcpStream::connect(listener.local_addr().unwrap()).unwrap();
    // rust: let (server_side, _) = listener.accept().unwrap();
    // rust: let ip: IpAddr = "127.0.0.1".parse().unwrap();
    // rust: let most = shared.max_players() + SPARE_CONNECTIONS;
    // rust: let mut held: Vec<Counted> = (0..most).map(|_| shared.count(ip).unwrap()).collect();
        // A player who reached the game, and a socket that never finished its login.
    // rust: let playing = shared.count(ip);
    // rust: assert!(playing.is_none(), "full");
    // rust: shared.wait(&held[1], &server_side);
    // rust: assert!(shared.count(ip).is_none(), "a fresh wait isn't closed");
    // rust: shared.waiting.lock().unwrap()[0].since -= MAKE_ROOM_AFTER * 2;
    // rust: let newcomer = shared.count(ip).expect("room made");
    // rust: let mut byte = [0u8; 1];
    // rust: client
    // rust: .set_read_timeout(Some(Duration::from_secs(5)))
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: client.read(&mut byte).unwrap(),
    // rust: 0,
    // rust: "the waiting socket was closed"
    // rust: );
    // rust: assert!(shared.waiting.lock().unwrap().is_empty());
    // rust: assert!(shared.count(ip).is_none(), "nothing else to close");
    // rust: let logged = lines.lock().unwrap().clone();
    // rust: assert_eq!(logged.len(), 1, "one report a minute: {logged:?}");
    // rust: assert!(logged[0].contains("127.0.0.1"), "{logged:?}");
        // Its thread ends and uncounts it; a connection that plays is never closed.
    // rust: held.remove(1);
    // rust: shared.wait(&newcomer, &server_side);
    // rust: WAITING.set(Some(newcomer.2));
    // rust: shared.entered_play();
    // rust: assert!(shared.waiting.lock().unwrap().is_empty());
    // rust: drop((held, newcomer));
    // rust: assert_eq!(shared.connections.load(Ordering::Acquire), 0);
}
}
