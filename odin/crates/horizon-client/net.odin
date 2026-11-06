//! Transpiled from Horizon Rust crate
package horizon_client_net

import "core:fmt"
import "core:mem"
import "core:math"

// Multiplayer session: a network thread that connects to a server, logs in,
// runs the configuration phase and then forwards decoded play packets to the
// game thread. Keep-alives are answered on the network thread; pings wait for
// the game thread, like ClientCommonPacketListenerImpl.handlePing, so a pong
// cannot overtake an earlier world update or teleport acknowledgement.
// Online-mode servers need the Microsoft account the launcher signed in
// (crate::auth): the login joins the server through the session service and
// encrypts the connection (ClientHandshakePacketListenerImpl.handleHello).
// use crate::auth::AuthSession;
// use crate::studio::{Metadata, RecorderStatus, StudioRecorder};
// use horizon_protocol::{
    // rust: PROTOCOL_VERSION,
    // rust: buf::Reader,
    // rust: connection::{ConnReader, ConnWriter, Connection, Counters},
    // rust: crypto::{generate_secret, offline_uuid, server_hash},
    // rust: packets::{Empty, configuration as cfg, handshake, login, play},
    // rust: registry::Dynamic,
    // rust: rsa::RsaPublicKey,
    // rust: servers::parse_address,
    // rust: text::{Language, plain, translatable},
}
// use horizon_world::nbt::{JavaString, Tag};
// use std::{
    // rust: collections::HashMap,
    // rust: path::{Path, PathBuf},
    // rust: sync::{
    // rust: Arc, Mutex,
    // rust: atomic::{AtomicBool, AtomicU32, Ordering},
    // rust: mpsc::{Receiver, Sender, channel},
    // rust: },
    // rust: thread::JoinHandle,
    // rust: time::Duration,
}

// `CommonListenerCookie.serverCookies`: cookies the server asked the client
// to store (`ClientboundStoreCookiePacket`), answered to
// `ClientboundCookieRequestPacket`. A `transfer` carries them to the next
// connection (`TransferState`), so a proxy's backend switch keeps them.
    // rust: pub type Cookies = Arc<Mutex<HashMap<String, Vec<u8>>>>;

// What the network thread reports to the game.
Event :: enum {
    // Progress text for the connecting screen.
    Status(String),
    // The server's `minecraft:brand` custom payload.
    Brand(String),
    // The server runs mods' quiet commands (`horizon_protocol::quiet`).
    QuietCommands,
    // The server carries mod messages (`horizon_protocol::mod_net`).
    ModNet,
    // The server samples far terrain for this client (`lod_net`).
    FarTerrain(crate::lod_net::Offer),
    // ClientConfigurationPacketListenerImpl.handleEnabledFeatures.
    Features(Vec<String>),
    // Configuration finished: the play state begins with these registries.
    Joined {,
    registries: Arc<Dynamic>,
    uuid: u128,
    name: String,
    // rust: },
    Packet(Box<play::Clientbound>),
    // A packet that failed to decode (skipped, like vanilla's skippable packets).
    DecodeError(String),
    // The server sent us back to configuration (`ClientboundStartConfigurationPacket`):
    // the game shows `ServerReconfigScreen` until the server logs it in again.
    Reconfiguring,
    // The server sent us back to configuration and finished it again.
    Reconfigured(Arc<Dynamic>),
    // ClientboundResourcePackPushPacket, in configuration or in play.
    PackPush(cfg::ResourcePackPush),
    // ClientboundResourcePackPopPacket: one pack, or every pack.
    PackPop(Option<u128>),
    // `show_dialog` in configuration: the dialog itself.
    ShowDialog(horizon_world::nbt::Tag),
    // `clear_dialog` in configuration.
    ClearDialog,
    // ClientboundCodeOfConductPacket: the game shows it and answers with
    // `Session::accept_code_of_conduct` or a disconnect; until then the
    // server waits in configuration.
    CodeOfConduct(String),
    // `ClientboundTransferPacket`: the server sent us to another address.
    // The connection ends right after; the game reconnects there with the
    // stored cookies.
    Transfer {,
    host: String,
    port: i32,
    // rust: },
    // `ClientboundServerLinksPacket`: the links the pause menu's "Server
    // Links..." lists (ClientCommonPacketListenerImpl.handleServerLinks).
    ServerLinks(Vec<cfg::ServerLink>),
    // The connection ended. `from_server`: the server gave the reason (or
    // the connection was refused for good), rather than the connection
    // failing (auto-reconnect retries only failures and shutdowns).
    Disconnected {,
    reason: String,
        // The reason's translation key, when it had one
        // (`reconnect::allowed` classifies by it).
    key: Option<String>,
    from_server: bool,
    // rust: },
}

Session :: struct {
    events: Receiver<Event>,
    writer: ^Mutex<Maybe(ConnWriter)>,
    // The connection is in configuration (else in play). Changed only
    // with `writer` locked, as the packet that switches is sent.
    configuring: ^AtomicBool,
    thread: Maybe(JoinHandle<())>,
    address: string,
    name: string,
    counters: ^Mutex<Maybe(Arc<Counters)>>,
    // The cookies this server stored on us (`ClientboundStoreCookiePacket`).
    cookies: Cookies,
    // HORIZON_NET_DEBUG=1 logs every packet sent from the game thread.
    debug: bool,
    // The far terrain requests waiting for the server (`lod_net`).
    far: ^crate::lod_net::Inbox,
    // Active packet recorder for Studio replay recordings.
    recorder: ^Mutex<Maybe(StudioRecorder)>,
}
    // rust: impl Session {
    // Start connecting in the background, as `auth`'s account when there is one.
    // rust: pub fn connect(
    // rust: address: &str,
    // rust: name: &str,
    // rust: auth: Option<Arc<AuthSession>>,
    // rust: info: cfg::ClientInformation,
    // rust: lang: Arc<Language>,
    // rust: resources: PathBuf,
    // rust: ) -> Self {
    // rust: Self::start(
    // rust: address, name, auth, info, lang, None, None, resources, false,
    // rust: )
}
    // `ClientHandshakePacketListenerImpl.handleHello`: LAN entries can continue
    // after session authentication fails; the server still decides whether to admit them.
    // Only for entries selected from LAN discovery, not addresses classified by IP.
    // rust: pub fn connect_lan(
    // rust: address: &str,
    // rust: name: &str,
    // rust: auth: Option<Arc<AuthSession>>,
    // rust: info: cfg::ClientInformation,
    // rust: lang: Arc<Language>,
    // rust: resources: PathBuf,
    // rust: ) -> Self {
    // rust: Self::start(address, name, auth, info, lang, None, None, resources, true)
}
    // `ConnectScreen.startConnecting` for a `transfer`: the cookies the
    // server stored carry to the new connection (`TransferState`).
    // rust: pub fn connect_transferred(
    // rust: address: &str,
    // rust: name: &str,
    // rust: auth: Option<Arc<AuthSession>>,
    // rust: info: cfg::ClientInformation,
    // rust: lang: Arc<Language>,
    // rust: cookies: Cookies,
    // rust: resources: PathBuf,
    // rust: ) -> Self {
    // rust: Self::start(
    // rust: address,
    // rust: name,
    // rust: auth,
    // rust: info,
    // rust: lang,
    // rust: None,
    // rust: Some(cookies),
    // rust: resources,
    // rust: false,
    // rust: )
}
    // Join an integrated server through memory (`Connection.connectToLocalServer`).
    // rust: pub fn connect_local(
    // rust: pipe: horizon_protocol::connection::Pipe,
    // rust: name: &str,
    // rust: info: cfg::ClientInformation,
    // rust: lang: Arc<Language>,
    // rust: resources: PathBuf,
    // rust: ) -> Self {
    // rust: Self::start(
    // rust: "local",
    // rust: name,
    // rust: None,
    // rust: info,
    // rust: lang,
    // rust: Some(pipe),
    // rust: None,
    // rust: resources,
    // rust: false,
    // rust: )
}
    // rust: fn start(
    // rust: address: &str,
    // rust: name: &str,
    // rust: auth: Option<Arc<AuthSession>>,
    // rust: info: cfg::ClientInformation,
    // rust: lang: Arc<Language>,
    // rust: local: Option<horizon_protocol::connection::Pipe>,
    // rust: cookies: Option<Cookies>,
    // rust: resources: PathBuf,
    // rust: lan: bool,
    // rust: ) -> Self {
    // rust: let (send, events) = channel();
    // rust: let writer = Arc::new(Mutex::new(None));
    // rust: let configuring = Arc::new(AtomicBool::new(true));
    // rust: let counters = Arc::new(Mutex::new(None));
        // Connection.initiateServerboundPlayConnection: a transfer's
        // handshake says so (ClientIntent.TRANSFER).
    // rust: let transferred = cookies.is_some();
    // rust: let cookies = cookies.unwrap_or_default();
    // rust: let (thread_writer, thread_counters, thread_cookies) =
    // rust: (writer.clone(), counters.clone(), cookies.clone());
    // rust: let thread_configuring = configuring.clone();
    // rust: let far = Arc::new(crate::lod_net::Inbox::default());
    // rust: let thread_far = far.clone();
    // rust: let recorder = Arc::new(Mutex::new(None));
    // rust: let thread_recorder = recorder.clone();
    // rust: let (address_owned, name_owned) = (address.to_owned(), name.to_owned());
    // rust: let thread = std::thread::Builder::new()
    // rust: .name("horizon-net".into())
    // rust: .spawn(move || {
    // rust: let result = run(
    // rust: local,
    // rust: &address_owned,
    // rust: &name_owned,
    // rust: auth.as_deref(),
    // rust: info,
    // rust: &lang,
    // rust: &send,
    // rust: &thread_writer,
    // rust: &thread_configuring,
    // rust: &thread_counters,
    // rust: &thread_cookies,
    // rust: &thread_far,
    // rust: transferred,
    // rust: &resources,
    // rust: lan,
    // rust: &thread_recorder,
    // rust: );
    // rust: thread_far.cancel();
    // rust: let from_server = result.is_ok();
    // rust: let why = result.unwrap_or_else(|e| e);
    // rust: if let Some(w) = thread_writer.lock().unwrap().take() {
    // rust: w.shutdown();
}
    // rust: let _ = send.send(Event::Disconnected {
    // rust: reason: why.text,
    // rust: key: why.key,
    // rust: from_server,
    // rust: });
    // rust: })
    // rust: .ok();
    // rust: let debug = std::env::var_os("HORIZON_NET_DEBUG").is_some();
    // rust: Self {
    // rust: events,
    // rust: writer,
    // rust: configuring,
    // rust: thread,
    // rust: address: address.to_owned(),
    // rust: name: name.to_owned(),
    // rust: counters,
    // rust: cookies,
    // rust: debug,
    // rust: far,
    // rust: recorder,
}
}
    // Everything received since the last poll.
poll :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.events.try_iter().collect()
}
    // Start recording network packets to `.mcpr` format at `path`.
    // rust: pub fn start_recording(
    // rust: &self,
    // rust: path: impl Into<PathBuf>,
    // rust: metadata: Metadata,
    // rust: ) -> std::io::Result<()> {
    // rust: let rec = StudioRecorder::start(path.into(), metadata)?;
    // rust: *self.recorder.lock().unwrap() = Some(rec);
    // rust: Ok(())
}
    // Stop recording and finalize the `.mcpr` archive.
stop_recording :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let rec = self.recorder.lock().unwrap().take()?;
    // rust: Some(rec.stop())
}
    // Whether recording is currently active.
is_recording :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.recorder
    // rust: .lock()
    // rust: .unwrap()
    // rust: .as_ref()
    // rust: .is_some_and(|r| r.is_active())
}
    // Status of the active recording, if any.
recorder_status :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.recorder.lock().unwrap().as_ref().map(|r| r.status())
}
    // Send a play packet; silently dropped once the connection is gone,
    // and while the server has the connection back in configuration (a
    // proxy switching servers). Vanilla's `handleConfigurationStart` clears
    // the level before it acknowledges, so no play packet follows the
    // acknowledgement; one that did would reach the server as a
    // configuration packet, and Velocity drops such a client.
send :: proc(self: ^Self, packet: play::Serverbound) {
}
    // rust: if self.debug
    // rust: && !matches!(
    // rust: packet,
    // rust: play::Serverbound::ClientTickEnd(_)
    // rust: | play::Serverbound::MovePlayerPos(_)
    // rust: | play::Serverbound::MovePlayerPosRot(_)
    // rust: )
    // rust: {
    // rust: eprintln!("[net] -> {packet:?}");
}
    // rust: let mut writer = self.writer.lock().unwrap();
    // rust: if self.configuring.load(Ordering::Relaxed) {
    // rust: return;
}
    // rust: if let Some(w) = writer.as_mut()
    // rust: && w.send(&packet.encode()).is_err()
    // rust: {
    // rust: w.shutdown();
}
}
    // Far terrain the server samples, as it offered (`Event::FarTerrain`):
    // biomes named by this client's indices, block states below `states`.
    // rust: pub fn far_terrain(
    // rust: &self,
    // rust: offer: crate::lod_net::Offer,
    // rust: biomes: HashMap<String, u16>,
    // rust: states: u32,
    // rust: ) -> Arc<crate::lod_net::RemoteSource> {
    // rust: crate::lod_net::RemoteSource::new(self.far.clone(), offer, biomes, states)
}
    // The far terrain requests its samplers queued go to the server, from
    // the game thread, among its other packets.
send_far_terrain :: proc(self: ^Self) {
}
    // rust: for data in self.far.requests() {
    // rust: self.send(play::Serverbound::CustomPayload(cfg::CustomPayload {
    // rust: channel: crate::lod_net::CHANNEL.into(),
    // rust: data,
    // rust: }));
}
}
    // The far terrain made with [`Self::far_terrain`] ends: its samplers
    // stop waiting for the server.
cancel_far_terrain :: proc(self: ^Self) {
}
    // rust: self.far.cancel();
}
    // The connection is configured again (a proxy's next server): requests
    // the old server held never come back, so their slots are freed.
reset_far_terrain :: proc(self: ^Self) {
}
    // rust: self.far.reset();
}
    // ServerboundResourcePackPacket, in whichever phase the connection is.
send_pack_status :: proc(self: ^Self, id: u128, action: i32) {
}
    // rust: let status = cfg::ResourcePackResponse { id, action };
    // rust: let mut writer = self.writer.lock().unwrap();
    // rust: let body = if self.configuring.load(Ordering::Relaxed) {
    // rust: cfg::Serverbound::ResourcePack(status).encode()
    // rust: } else {
    // rust: play::Serverbound::ResourcePack(status).encode()
}
    // rust: if let Some(w) = writer.as_mut()
    // rust: && w.send(&body).is_err()
    // rust: {
    // rust: w.shutdown();
}
}
    // ServerboundCustomClickActionPacket (a dialog's answer), in whichever
    // phase the connection is.
send_custom_click :: proc(self: ^Self, id: string, payload: Maybe(horizon_world::nbt::Tag)) {
}
    // rust: let click = cfg::CustomClickAction {
    // rust: id: id.to_owned(),
    // rust: payload,
}
    // rust: let mut writer = self.writer.lock().unwrap();
    // rust: let body = if self.configuring.load(Ordering::Relaxed) {
    // rust: cfg::Serverbound::CustomClickAction(click).encode()
    // rust: } else {
    // rust: play::Serverbound::CustomClickAction(click).encode()
}
    // rust: if let Some(w) = writer.as_mut()
    // rust: && w.send(&body).is_err()
    // rust: {
    // rust: w.shutdown();
}
}
    // ServerboundAcceptCodeOfConductPacket, sent in configuration.
accept_code_of_conduct :: proc(self: ^Self) {
}
    // rust: let mut writer = self.writer.lock().unwrap();
    // rust: if let Some(w) = writer.as_mut()
    // rust: && w.send(&cfg::Serverbound::AcceptCodeOfConduct(Empty).encode())
    // rust: .is_err()
    // rust: {
    // rust: w.shutdown();
}
}
    // `Connection.disconnect`: the socket closes and the game goes on at once.
    // The reader thread is left to end on its own: on Windows a shutdown
    // doesn't wake a read already waiting, so joining it held the window until
    // the server dropped the connection, many seconds later.
disconnect :: proc(self: ^Self) {
}
    // rust: if let Some(w) = self.writer.lock().unwrap().take() {
    // rust: w.shutdown();
}
    // rust: drop(self.thread.take());
}
}
    // rust: impl Drop for Session {
drop :: proc(self: ^Self) {
}
    // rust: self.disconnect();
}
}

// An address of the form `friend:K7QM-3XPD` joins a friend's world through
// its invite code (horizon-friends): the session goes through a tunnel the
// client reaches on a loopback port, so everything after is a plain join.
FRIEND :: horizon_friends::ADDRESS_PREFIX

// An address as players and logs see it: a friend's invite code stays
// out of it (its secret is in there).
shown_address :: proc(address: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match address.strip_prefix(FRIEND) {
    // rust: Some(code) => match horizon_friends::invite::parse(code) {
    // rust: Some(horizon_friends::invite::Parsed::Short(c)) => {
    // rust: format!("Friend's world ({}-****)", c.nameplate)
}
    // rust: _ => "Friend's world".to_owned(),
    // rust: },
    // rust: None => address.to_owned(),
}
}

// The relay the player set (`friendsRelay` in horizon.txt, beside
// options.txt), else `HORIZON_RELAY_URL`. None by default.
friends_relay_setting :: proc() -> O {
    // Ported from Horizon
    return {}
}
    // rust: let dir = std::env::current_dir().ok()?;
    // rust: crate::ui_theme::preference(&dir, "friendsRelay")
    // rust: .filter(|r| !r.is_empty())
    // rust: .or_else(horizon_friends::relay_url)
}
// Remember the relay typed on Join a friend (empty forgets it).
save_friends_relay :: proc(relay: string) {
}
    // rust: if let Ok(dir) = std::env::current_dir() {
    // rust: crate::ui_theme::set_preference(&dir, "friendsRelay", (!relay.is_empty()).then_some(relay));
}
}

// Reach the friend's world from the code (directly, or through a relay)
// and open the tunnel: the loopback address to connect to.
join_friend :: proc(code: string, lang: ^Language, send: ^Sender<Event>) -> R {
    // Ported from Horizon
    return {}
}
//     use horizon_friends::{
    // rust: PathMode,
    // rust: guest::{self, GuestConfig},
}
    // rust: status(send, &tr(lang, "horizon.multiplayer.finding_friend"));
    // rust: let tunnel = guest::join(&GuestConfig {
    // rust: code: code.to_owned(),
    // rust: relay: friends_relay_setting(),
    // rust: protocol: PROTOCOL_VERSION,
    // rust: game: horizon_protocol::GAME_VERSION.to_owned(),
    // rust: path: PathMode::from_env(),
    // rust: })
    // rust: .map_err(|e| Reason::plain(e.to_string()))?;
    // rust: status(
    // rust: send,
    // rust: &if tunnel.direct {
    // rust: tr(lang, "horizon.multiplayer.connected_friend_direct")
    // rust: } else {
    // rust: tr(lang, "horizon.multiplayer.connected_friend_relay")
    // rust: },
    // rust: );
    // rust: let (port, _) = tunnel
    // rust: .serve_loopback()
    // rust: .map_err(|e| Reason::plain(e.to_string()))?;
    // rust: Ok(("127.0.0.1".to_owned(), port))
}

status :: proc(send: ^Sender<Event>, text: string) {
}
    // rust: let _ = send.send(Event::Status(text.to_owned()));
}

// Shown when an online-mode server asks a client without an account to authenticate.
NOT_SIGNED_IN :: "This server is in online mode. Sign in with your Microsoft account in the Horizon launcher to join it."

// A translation, or the key itself (Language.getOrDefault).
tr :: proc(lang: ^Language, key: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: lang.get(key).cloned().unwrap_or_else(|| key.to_owned())
}

// Why a connection ended: the shown text and, when the reason was a
// translatable component or a known Horizon error, its translation key —
// the auto-reconnect classifies by key (`reconnect::allowed`), the
// English keyword scan of the text is the fallback for plain reasons.
Reason :: struct {
    text: string,
    key: Maybe(string),
}
    // rust: impl Reason {
plain :: proc(text: impl Into<string>) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: text: text.into(),
    // rust: key: None,
}
}
    // A vanilla key's text in the session's language, with the key.
keyed :: proc(key: string, lang: ^Language) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: text: tr(lang, key),
    // rust: key: Some(key.to_owned()),
}
}
    // A Horizon key's text with a `%s` argument filled.
keyed_arg :: proc(key: string, lang: ^Language, arg: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut r = Self::keyed(key, lang);
    // rust: r.text = r.text.replacen("%s", arg, 1);
    // rust: r
}
    // A server's disconnect component: the resolved text and the
    // `translate` key when the component named one (servers' literal
    // kicks have none; their text is the server's own language).
component :: proc(reason_json: string, lang: ^Language) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match serde_json::from_str::<serde_json::Value>(reason_json) {
    // rust: Ok(v) => Self {
    // rust: text: json_text(&v, lang),
    // rust: key: v["translate"].as_str().map(str::to_owned),
    // rust: },
    // rust: Err(_) => Self::plain(reason_json),
}
}
    // The play/configuration phases' disconnect: the reason arrives as
    // an NBT component.
tag :: proc(tag: ^Tag, lang: ^Language) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let key = match tag {
    // rust: Tag::Compound(map) => map
    // rust: .get(&JavaString::from("translate"))
    // rust: .and_then(|t| match t {
    // rust: Tag::String(s) => s.to_string().ok(),
    // rust: _ => None,
    // rust: }),
    // rust: _ => None,
}
    // rust: Self {
    // rust: text: plain(tag, lang),
    // rust: key,
}
}
}

// `ConnectScreen.connect`'s log line, as vanilla writes it from its "Server Connector #N" thread:
// the address as the player gave it, and the port (25565 when none was given), before any SRV
// lookup. Other launchers read the last one from `latest.log` to offer the server again.
connecting_line :: proc(host: string, port: u16) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!("Connecting to {host}, {port}")
}
log_connecting :: proc(host: string, port: u16) {
}
    // ConnectScreen.UNIQUE_THREAD_ID: the first connector is #1.
CONNECTORS :: AtomicU32::new(0)
    // rust: let n = CONNECTORS.fetch_add(1, Ordering::Relaxed) + 1;
    // rust: crate::logging::write_as(
    // rust: &format!("Server Connector #{n}"),
    // rust: log::Level::Info,
    // rust: &connecting_line(host, port),
    // rust: );
}

// `Connection$1.initChannel`: a client socket's pipeline starts with
// `ReadTimeoutHandler(30)`. A server sends a keep-alive every 15 s, so one
// that sends nothing for 30 s has frozen or dropped off the network.
READ_TIMEOUT :: Duration::from_secs(30)

// `ConnectScreen.startConnecting`: the socket to a server, with `read_timeout`
// ([`READ_TIMEOUT`]) on every read. The friends relay supplies a concrete
// endpoint, not a Minecraft hostname, so it skips the SRV lookup. Returns the
// resolved host and port for `ConnectScreen`'s login handshake.
    // rust: fn connect_tcp(
    // rust: host: &str,
    // rust: port: u16,
    // rust: relayed: bool,
    // rust: read_timeout: Duration,
    // rust: ) -> Result<(Connection, String, u16), String> {
    // rust: let (c, host, port) = if relayed {
    // rust: Connection::connect(host, port, Duration::from_secs(10)).map(|c| (c, host.to_owned(), port))
    // rust: } else {
    // rust: Connection::connect_server_with_address(host, port, Duration::from_secs(10))
}
    // rust: .map_err(|e| e.to_string())?;
    // rust: c.reader
    // rust: .set_read_timeout(Some(read_timeout))
    // rust: .map_err(|e| e.to_string())?;
    // rust: Ok((c, host, port))
}

// Whether joining servers of older releases is on (roadmap `older-servers`): off by default while the
// adapter is incomplete; `HORIZON_OLDER_SERVERS=1` turns it on.
older_servers_enabled :: proc() -> b {
    // Ported from Horizon
    return {}
}
    // rust: std::env::var_os("HORIZON_OLDER_SERVERS").is_some_and(|v| v == "1")
}

// The older release a server speaks, by its status ping, when Horizon can translate it; `None` for the
// pinned version, an unknown one, a failed ping, or with the feature off.
older_server :: proc(address: string) -> O {
    // Ported from Horizon
    return {}
}
//     use horizon_protocol::adapter::ServerVersion;
    // rust: if !older_servers_enabled() {
    // rust: return None;
}
    // rust: let (json, _) = ping(address, Duration::from_secs(5)).ok()?;
    // rust: let protocol = i32::try_from(json["version"]["protocol"].as_i64()?).ok()?;
    // rust: ServerVersion::from_protocol(protocol).filter(|v| *v != ServerVersion::Current)
}

// `Connection.exceptionCaught`: a read that timed out ends with
// `disconnect.timeout`, any other failure with `disconnect.genericReason`
// ("Internal Exception: ..."); a stream the server closed ends with
// `disconnect.endOfStream` (`Connection.channelInactive`).
connection_lost :: proc(e: horizon_protocol::Error, lang: ^Language) -> S {
    // Ported from Horizon
    return {}
}
    // rust: if e.is_timed_out() {
    // rust: tr(lang, "disconnect.timeout")
    // rust: } else if e.is_end_of_stream() {
    // rust: tr(lang, "disconnect.endOfStream")
    // rust: } else {
    // rust: plain(
    // rust: &translatable(
    // rust: "disconnect.genericReason",
    // rust: &[&format!("Internal Exception: {e}")],
    // rust: ),
    // rust: lang,
    // rust: )
}
}

// `ClientHandshakePacketListenerImpl.handleHello`: the whole connection.
// Ok: why it ended for good (the server's reason, or
// a refusal no retry fixes); Err: the connection failed.
    // rust: fn run(
    // rust: local: Option<horizon_protocol::connection::Pipe>,
    // rust: address: &str,
    // rust: name: &str,
    // rust: auth: Option<&AuthSession>,
    // rust: info: cfg::ClientInformation,
    // rust: lang: &Language,
    // rust: send: &Sender<Event>,
    // rust: shared_writer: &Mutex<Option<ConnWriter>>,
    // rust: configuring: &AtomicBool,
    // rust: shared_counters: &Mutex<Option<Arc<Counters>>>,
    // rust: cookies: &Cookies,
    // rust: far: &crate::lod_net::Inbox,
    // rust: transferred: bool,
    // rust: resources: &Path,
    // rust: lan: bool,
    // rust: recorder: &Arc<Mutex<Option<StudioRecorder>>>,
    // rust: ) -> Result<Reason, Reason> {
    // rust: let (host, port, mut c) = if let Some(pipe) = local {
    // rust: (address.to_owned(), 0, Connection::local(pipe))
    // rust: } else {
    // rust: let (host, port) = match address.strip_prefix(FRIEND) {
    // rust: Some(code) => join_friend(code, lang, send)?,
    // rust: None => {
    // rust: let Some(target) = parse_address(address) else {
                    // A refusal: never retried (`horizon.multiplayer
                    // .invalid_address` is in reconnect's key list).
    // rust: return Err(Reason::keyed_arg(
    // rust: "horizon.multiplayer.invalid_address",
    // rust: lang,
    // rust: address,
    // rust: ));
}
    // rust: status(send, &tr(lang, "connect.connecting"));
    // rust: log_connecting(&target.0, target.1);
    // rust: target
}
}
    // rust: let (mut c, host, port) =
    // rust: connect_tcp(&host, port, address.starts_with(FRIEND), READ_TIMEOUT)
    // rust: .map_err(Reason::plain)?;
    // rust: if !address.starts_with(FRIEND)
    // rust: && let Some(version) = older_server(address)
    // rust: {
    // rust: log::info!("Joining {address} as a {} server", version.name());
    // rust: c.adapt(version);
}
    // rust: (host, port, c)
}
    // rust: *shared_counters.lock().unwrap() = Some(c.reader.counters.clone());
    // rust: let e = |e: horizon_protocol::Error| Reason::plain(connection_lost(e, lang));
    // rust: c.send(
    // rust: &handshake::Serverbound::Intention(handshake::Intention {
    // rust: protocol: PROTOCOL_VERSION,
    // rust: host: host.clone(),
    // rust: port,
    // rust: intent: if transferred {
    // rust: handshake::TRANSFER
    // rust: } else {
    // rust: handshake::LOGIN
    // rust: },
    // rust: })
    // rust: .encode(),
    // rust: )
    // rust: .map_err(e)?;
    // Vanilla's login sends the account's profile id, or the offline one.
    // rust: let uuid = auth.map_or_else(|| offline_uuid(name), |a| a.uuid);
    // rust: c.send(
    // rust: &login::Serverbound::Hello(login::ServerHello {
    // rust: name: name.to_owned(),
    // rust: uuid,
    // rust: })
    // rust: .encode(),
    // rust: )
    // rust: .map_err(e)?;
    // rust: let profile = loop {
    // rust: let (id, payload) = c.recv().map_err(e)?;
    // rust: match login::Clientbound::decode(id, &payload).map_err(e)? {
    // rust: login::Clientbound::Compression(p) => c.set_compression(p.threshold),
    // rust: login::Clientbound::LoginFinished(p) => {
    // rust: c.send(&login::Serverbound::LoginAcknowledged(Empty).encode())
    // rust: .map_err(e)?;
    // rust: break p.profile;
}
    // rust: login::Clientbound::Disconnect(p) => {
    // rust: return Ok(Reason::component(&p.reason_json, lang));
}
    // rust: login::Clientbound::Hello(hello) => {
    // rust: status(send, &tr(lang, "connect.authorizing"));
    // rust: let key = RsaPublicKey::from_der(&hello.public_key)
    // rust: .map_err(|err| Reason::plain(format!("Protocol error: {err}")))?;
    // rust: let secret = generate_secret().map_err(e)?;
    // rust: if hello.should_authenticate {
    // rust: let signed_in = auth.is_some();
    // rust: let authenticated = auth
    // rust: .ok_or_else(|| Reason::keyed("horizon.multiplayer.not_signed_in", lang))
    // rust: .and_then(|account| {
    // rust: let hash = server_hash(&hello.server_id, &secret, &hello.public_key);
                            // The session service's refusal: the wrapped
                            // `disconnect.loginFailedInfo` text is shown, and
                            // the inner key (the reason's own) classifies
                            // (`reconnect::allowed`).
    // rust: crate::auth::join_server(account, &hash).map_err(|err| {
    // rust: let (reason, key) = match err.reason() {
    // rust: Ok(key) => (tr(lang, key), Some(key.to_owned())),
    // rust: Err(message) => (message.to_owned(), None),
}
    // rust: Reason {
    // rust: text: plain(
    // rust: &translatable("disconnect.loginFailedInfo", &[&reason]),
    // rust: lang,
    // rust: ),
    // rust: key,
}
    // rust: })
    // rust: });
    // rust: if let Err(reason) = authenticated {
    // rust: if !continues_after_failed_join(lan, signed_in) {
    // rust: return Err(reason);
}
    // rust: log::warn!("Authentication failed: {}", reason.text);
}
}
    // rust: status(send, &tr(lang, "connect.encrypting"));
    // rust: c.send(
    // rust: &login::Serverbound::Key(login::Key {
    // rust: key: key.encrypt(&secret).map_err(e)?,
    // rust: challenge: key.encrypt(&hello.challenge).map_err(e)?,
    // rust: })
    // rust: .encode(),
    // rust: )
    // rust: .map_err(e)?;
    // rust: c.enable_encryption(&secret);
}
    // rust: login::Clientbound::CustomQuery(q) => {
    // rust: c.send(
    // rust: &login::Serverbound::CustomQueryAnswer(login::CustomQueryAnswer {
    // rust: transaction: q.transaction,
    // rust: payload: None,
    // rust: })
    // rust: .encode(),
    // rust: )
    // rust: .map_err(e)?;
}
            // ClientHandshakePacketListenerImpl.handleRequestCookie: the
            // cookies a transfer carried over (none on a plain join).
    // rust: login::Clientbound::CookieRequest(q) => {
    // rust: let payload = cookies.lock().unwrap().get(&q.key).cloned();
    // rust: c.send(
    // rust: &login::Serverbound::CookieResponse(login::CookieResponse {
    // rust: key: q.key,
    // rust: payload,
    // rust: })
    // rust: .encode(),
    // rust: )
    // rust: .map_err(e)?;
}
    // rust: login::Clientbound::Unknown(..) => {}
}
}
    // rust: status(send, &tr(lang, "connect.joining"));
    // ClientHandshakePacketListenerImpl.handleLoginFinished: the brand, then
    // the client information.
    // rust: c.send(
    // rust: &cfg::Serverbound::CustomPayload(cfg::CustomPayload {
    // rust: channel: "minecraft:brand".into(),
    // rust: data: brand(),
    // rust: })
    // rust: .encode(),
    // rust: )
    // rust: .map_err(e)?;
    // rust: c.send(&cfg::Serverbound::ClientInformation(info).encode())
    // rust: .map_err(e)?;
    // rust: let (mut reader, writer) = c.split();
    // rust: *shared_writer.lock().unwrap() = Some(writer);
    // rust: let registries = configure(
    // rust: &mut reader,
    // rust: shared_writer,
    // rust: configuring,
    // rust: lang,
    // rust: send,
    // rust: cookies,
    // rust: resources,
    // rust: )?;
    // rust: let _ = send.send(Event::Joined {
    // rust: registries: Arc::new(registries),
    // rust: uuid: profile.uuid,
    // rust: name: profile.name,
    // rust: });
    // rust: receive_play(
    // rust: &mut reader,
    // rust: shared_writer,
    // rust: configuring,
    // rust: lang,
    // rust: send,
    // rust: cookies,
    // rust: far,
    // rust: resources,
    // rust: recorder,
    // rust: )
}

    // rust: fn receive_play(
    // rust: reader: &mut ConnReader,
    // rust: shared_writer: &Mutex<Option<ConnWriter>>,
    // rust: configuring: &AtomicBool,
    // rust: lang: &Language,
    // rust: send: &Sender<Event>,
    // rust: cookies: &Cookies,
    // rust: far: &crate::lod_net::Inbox,
    // rust: resources: &Path,
    // rust: recorder: &Arc<Mutex<Option<StudioRecorder>>>,
    // rust: ) -> Result<Reason, Reason> {
    // rust: loop {
    // rust: let (id, payload) = reader
    // rust: .recv()
    // rust: .map_err(|e| Reason::plain(connection_lost(e, lang)))?;
    // rust: let packet = match play::Clientbound::decode(id, &payload) {
    // rust: Ok(p) => p,
    // rust: Err(err) => {
    // rust: let name = horizon_protocol::ids::name(
    // rust: horizon_protocol::State::Play,
    // rust: horizon_protocol::Direction::Clientbound,
    // rust: id,
    // rust: )
    // rust: .unwrap_or("?");
    // rust: let _ = send.send(Event::DecodeError(format!("{name}: {err}")));
    // rust: continue;
}
}
        // Only while a recording runs: the filter copies what it keeps, and re-encodes
        // AddEntity with a fresh UUID.
    // rust: if let Some(rec) = recorder.lock().unwrap().as_ref()
    // rust: && rec.is_active()
    // rust: && let Some((recorded_id, recorded_payload)) =
    // rust: studio_recording_packet(&packet, id, &payload)
    // rust: {
    // rust: rec.record_packet(recorded_id, &recorded_payload);
}
    // rust: let reply = |p: play::Serverbound| {
    // rust: if let Some(w) = shared_writer.lock().unwrap().as_mut() {
    // rust: let _ = w.send(&p.encode());
}
}
    // rust: match packet {
    // rust: play::Clientbound::KeepAlive(k) => reply(play::Serverbound::KeepAlive(k)),
    // rust: play::Clientbound::BundleDelimiter(_) => {}
    // rust: play::Clientbound::ResourcePackPush(p) => {
    // rust: let _ = send.send(Event::PackPush(p));
}
    // rust: play::Clientbound::ResourcePackPop(p) => {
    // rust: let _ = send.send(Event::PackPop(p.id));
}
    // rust: play::Clientbound::StartConfiguration(_) => {
    // rust: let _ = send.send(Event::Reconfiguring);
    // rust: if let Some(w) = shared_writer.lock().unwrap().as_mut() {
    // rust: let _ = w.send(&play::Serverbound::ConfigurationAcknowledged(Empty).encode());
    // rust: configuring.store(true, Ordering::Relaxed);
}
    // rust: let registries = configure(
    // rust: reader,
    // rust: shared_writer,
    // rust: configuring,
    // rust: lang,
    // rust: send,
    // rust: cookies,
    // rust: resources,
    // rust: )?;
    // rust: let _ = send.send(Event::Reconfigured(Arc::new(registries)));
}
            // ClientCommonPacketListenerImpl.handleRequestCookie: the stored
            // cookie (or none) goes straight back.
    // rust: play::Clientbound::CookieRequest(q) => {
    // rust: let payload = cookies.lock().unwrap().get(&q.key).cloned();
    // rust: reply(play::Serverbound::CookieResponse(cfg::CookieResponse {
    // rust: key: q.key,
    // rust: payload,
    // rust: }));
}
    // rust: play::Clientbound::StoreCookie(p) => {
    // rust: cookies.lock().unwrap().insert(p.key, p.payload);
}
    // rust: play::Clientbound::ServerLinks(p) => {
    // rust: let _ = send.send(Event::ServerLinks(p.links));
}
            // ClientCommonPacketListenerImpl.handleTransfer: the connection
            // ends and the game connects to the other address.
    // rust: play::Clientbound::Transfer(p) => {
    // rust: let _ = send.send(Event::Transfer {
    // rust: host: p.host,
    // rust: port: p.port,
    // rust: });
    // rust: return Ok(Reason::keyed("disconnect.transfer", lang));
}
    // rust: play::Clientbound::Disconnect(d) => return Ok(Reason::tag(&d.reason, lang)),
    // rust: play::Clientbound::CustomPayload(p) if p.channel == "minecraft:brand" => {
    // rust: receive_brand(&p, send);
}
            // A far tile, straight to the sampler waiting for it.
    // rust: play::Clientbound::CustomPayload(p) if p.channel == crate::lod_net::CHANNEL => {
    // rust: far.deliver(p.data);
}
    // rust: other => {
    // rust: if send.send(Event::Packet(Box::new(other))).is_err() {
    // rust: return Ok(Reason::plain("Disconnected"));
}
}
}
}
}

// Return the packet bytes safe to persist in a Studio recording.
//
// Unknown packets fail closed so a newly added protocol packet cannot bypass
// the privacy policy. `AddEntity` retains its entity id and state, but gets a
// fresh UUID so the recording cannot link that entity to an account UUID.
    // rust: fn studio_recording_packet<'a>(
    // rust: packet: &play::Clientbound,
    // rust: packet_id: i32,
    // rust: payload: &'a [u8],
    // rust: ) -> Option<(i32, std::borrow::Cow<'a, [u8]>)> {
//     use play::Clientbound as P;
//     use std::borrow::Cow;
    // rust: match packet {
    // rust: P::AddEntity(entity) => {
    // rust: let mut anonymous = entity.clone();
    // rust: anonymous.uuid = u128::from_be_bytes(generate_secret().ok()?);
    // rust: let encoded = P::AddEntity(anonymous).encode();
    // rust: let mut reader = Reader::new(&encoded);
    // rust: let id = reader.varint().ok()?;
    // rust: Some((id, Cow::Owned(reader.rest().to_vec())))
}
    // rust: P::CookieRequest(_)
    // rust: | P::CustomChatCompletions(_)
    // rust: | P::CustomPayload(_)
    // rust: | P::DeleteChat(_)
    // rust: | P::Disconnect(_)
    // rust: | P::DisguisedChat(_)
    // rust: | P::PlayerChat(_)
    // rust: | P::PlayerCombatKill(_)
    // rust: | P::PlayerInfoRemove(_)
    // rust: | P::PlayerInfoUpdate(_)
    // rust: | P::ResetScore(_)
    // rust: | P::ResourcePackPush(_)
    // rust: | P::ServerLinks(_)
    // rust: | P::SetPlayerTeam(_)
    // rust: | P::SetScore(_)
    // rust: | P::StoreCookie(_)
    // rust: | P::SystemChat(_)
    // rust: | P::TabList(_)
    // rust: | P::TrackedWaypoint(_)
    // rust: | P::Transfer(_)
    // rust: | P::Unknown(..) => None,
    // rust: _ => Some((packet_id, Cow::Borrowed(payload))),
}
}

// The configuration phase: registries, tags and known packs until the
// server finishes it (ClientConfigurationPacketListenerImpl).
    // rust: fn configure(
    // rust: reader: &mut ConnReader,
    // rust: writer: &Mutex<Option<ConnWriter>>,
    // rust: configuring: &AtomicBool,
    // rust: lang: &Language,
    // rust: send: &Sender<Event>,
    // rust: cookies: &Cookies,
    // rust: resources: &Path,
    // rust: ) -> Result<Dynamic, Reason> {
    // rust: let mut registries = Dynamic::default();
    // rust: let mut content_verified = false;
    // rust: let reply = |p: cfg::Serverbound| -> Result<(), Reason> {
    // rust: match writer.lock().unwrap().as_mut() {
    // rust: Some(w) => w
    // rust: .send(&p.encode())
    // rust: .map_err(|e| Reason::plain(connection_lost(e, lang))),
    // rust: None => Err(Reason::plain("Disconnected")),
}
}
    // rust: loop {
    // rust: let (id, payload) = reader
    // rust: .recv()
    // rust: .map_err(|e| Reason::plain(connection_lost(e, lang)))?;
    // rust: match cfg::Clientbound::decode(id, &payload)
    // rust: .map_err(|e| Reason::plain(connection_lost(e, lang)))?
    // rust: {
    // rust: cfg::Clientbound::KeepAlive(k) => reply(cfg::Serverbound::KeepAlive(k))?,
    // rust: cfg::Clientbound::CustomPayload(p) if p.channel == crate::content_identity::CHANNEL => {
    // rust: let hash = crate::content_identity::identity(resources)
    // rust: .map_err(|_| Reason::plain(crate::content_identity::MISMATCH.to_string()))?;
    // rust: content_verified = p.data == hash;
    // rust: reply(cfg::Serverbound::CustomPayload(cfg::CustomPayload {
    // rust: channel: crate::content_identity::CHANNEL.into(),
    // rust: data: hash.to_vec(),
    // rust: }))?;
}
            // The server names its mods; the answer is ours, and the server judges.
    // rust: cfg::Clientbound::CustomPayload(p)
    // rust: if p.channel == horizon_protocol::mod_list::CHANNEL =>
    // rust: {
    // rust: reply(cfg::Serverbound::CustomPayload(cfg::CustomPayload {
    // rust: channel: horizon_protocol::mod_list::CHANNEL.into(),
    // rust: data: horizon_protocol::mod_list::encode(&horizon_protocol::mod_list::shared(
    // rust: &horizon_protocol::mod_list::local(),
    // rust: )),
    // rust: }))?;
}
    // rust: cfg::Clientbound::CustomPayload(p) => {
                // Horizon servers use the client brand to negotiate their extensions.
                // Announce those only after the server identifies itself as Horizon.
    // rust: if p.channel == "minecraft:brand"
    // rust: && horizon_protocol::buf::Reader::new(&p.data)
    // rust: .string(32767)
    // rust: .ok()
    // rust: .as_deref()
    // rust: == Some("horizon")
    // rust: {
    // rust: let mut w = horizon_protocol::buf::Writer::new();
    // rust: w.string("horizon");
    // rust: reply(cfg::Serverbound::CustomPayload(cfg::CustomPayload {
    // rust: channel: "minecraft:brand".into(),
    // rust: data: w.data,
    // rust: }))?;
}
    // rust: receive_brand(&p, send);
}
    // rust: cfg::Clientbound::Ping(p) => reply(cfg::Serverbound::Pong(p))?,
    // rust: cfg::Clientbound::SelectKnownPacks(p) => {
    // rust: reply(cfg::Serverbound::SelectKnownPacks(cfg::SelectKnownPacks {
    // rust: packs: select_known_packs(p.packs),
    // rust: }))?
}
    // rust: cfg::Clientbound::UpdateEnabledFeatures(p) => {
    // rust: let _ = send.send(Event::Features(p.features));
}
    // rust: cfg::Clientbound::RegistryData(mut r) => {
    // rust: fill_known_entries(&mut r, resources);
    // rust: registries.add(r);
}
    // rust: cfg::Clientbound::UpdateTags(t) => registries.add_tags(&t),
    // rust: cfg::Clientbound::CodeOfConduct(c) => {
    // rust: let _ = send.send(Event::CodeOfConduct(c.text));
}
            // The game answers: it may prompt the player first.
    // rust: cfg::Clientbound::ResourcePackPush(p) => {
    // rust: let _ = send.send(Event::PackPush(p));
}
    // rust: cfg::Clientbound::ResourcePackPop(p) => {
    // rust: let _ = send.send(Event::PackPop(p.id));
}
            // The game shows it; the answer goes back from there.
    // rust: cfg::Clientbound::ShowDialog(d) => {
    // rust: let _ = send.send(Event::ShowDialog(d.dialog));
}
    // rust: cfg::Clientbound::ClearDialog(_) => {
    // rust: let _ = send.send(Event::ClearDialog);
}
    // rust: cfg::Clientbound::CookieRequest(q) => {
    // rust: let payload = cookies.lock().unwrap().get(&q.key).cloned();
    // rust: reply(cfg::Serverbound::CookieResponse(cfg::CookieResponse {
    // rust: key: q.key,
    // rust: payload,
    // rust: }))?
}
    // rust: cfg::Clientbound::StoreCookie(p) => {
    // rust: cookies.lock().unwrap().insert(p.key, p.payload);
}
    // rust: cfg::Clientbound::ServerLinks(p) => {
    // rust: let _ = send.send(Event::ServerLinks(p.links));
}
    // rust: cfg::Clientbound::Transfer(p) => {
    // rust: let _ = send.send(Event::Transfer {
    // rust: host: p.host,
    // rust: port: p.port,
    // rust: });
    // rust: return Err(Reason::keyed("disconnect.transfer", lang));
}
    // rust: cfg::Clientbound::Disconnect(d) => return Err(Reason::tag(&d.reason, lang)),
    // rust: cfg::Clientbound::FinishConfiguration(_) => {
    // rust: registries.custom_components = content_verified;
    // rust: let mut w = writer.lock().unwrap_or_else(|e| e.into_inner());
    // rust: let w = w.as_mut().ok_or_else(|| Reason::plain("Disconnected"))?;
    // rust: w.send(&cfg::Serverbound::FinishConfiguration(Empty).encode())
    // rust: .map_err(|e| Reason::plain(connection_lost(e, lang)))?;
    // rust: configuring.store(false, Ordering::Relaxed);
    // rust: return Ok(registries);
}
    // rust: _ => {}
}
}
}

// `KnownPacksManager.trySelectingPacks`: the packs of the server's list the
// client has too. Horizon carries vanilla's core pack (the prepared
// resources' `data/`), so it names that one when the server offers it, and
// the server leaves that pack's entries' data out (`fill_known_entries`).
select_known_packs :: proc(offered: [dynamic]cfg::KnownPack) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let (namespace, id, version) = crate::lan::data::CORE_PACK;
    // rust: offered
    // rust: .into_iter()
    // rust: .filter(|p| p.namespace == namespace && p.id == id && p.version == version)
    // rust: .collect()
}

// `RegistryDataCollector`: an entry of a pack both sides know comes without
// its data, which the client reads from its own copy of the pack
// (`data/<namespace>/<registry path>/<path>.json`, `Registries.elementsDirPath`).
fill_known_entries :: proc(r: ^cfg::RegistryData, resources: ^Path) {
}
    // rust: let (registry_ns, registry_path) = r
    // rust: .registry
    // rust: .split_once(':')
    // rust: .unwrap_or(("minecraft", r.registry.as_str()));
    // rust: let dir = if registry_ns == "minecraft" {
    // rust: registry_path.to_owned()
    // rust: } else {
    // rust: format!("{registry_ns}/{registry_path}")
}
    // rust: for entry in r.entries.iter_mut().filter(|e| e.data.is_none()) {
    // rust: let (ns, path) = entry
    // rust: .id
    // rust: .split_once(':')
    // rust: .unwrap_or(("minecraft", entry.id.as_str()));
    // rust: let file = resources
    // rust: .join("data")
    // rust: .join(ns)
    // rust: .join(&dir)
    // rust: .join(format!("{path}.json"));
    // rust: let json = std::fs::read(&file)
    // rust: .ok()
    // rust: .and_then(|bytes| serde_json::from_slice::<serde_json::Value>(&bytes).ok());
    // rust: if let Some(json) = json {
    // rust: entry.data = Some(crate::lan::data::json_to_nbt(&json));
}
}
}

receive_brand :: proc(payload: ^cfg::CustomPayload, send: ^Sender<Event>) {
}
    // rust: if payload.channel == "minecraft:brand"
    // rust: && let Ok(brand) = horizon_protocol::buf::Reader::new(&payload.data).string(32767)
    // rust: {
    // rust: let _ = send.send(Event::Brand(brand));
    // rust: } else if payload.channel == horizon_protocol::quiet::CHANNEL {
    // rust: let _ = send.send(Event::QuietCommands);
    // rust: } else if payload.channel == horizon_protocol::mod_net::CHANNEL {
    // rust: let _ = send.send(Event::ModNet);
    // rust: } else if payload.channel == crate::lod_net::CHANNEL
    // rust: && let Some(offer) = crate::lod_net::Offer::decode(&payload.data)
    // rust: {
    // rust: let _ = send.send(Event::FarTerrain(offer));
}
}

// `ClientBrandRetriever.getClientModName`: vanilla's default client brand.
brand :: proc() -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut w = horizon_protocol::buf::Writer::new();
    // rust: w.string("vanilla");
    // rust: w.data
}

// Flatten a JSON chat component (login disconnects are JSON).
json_text :: proc(v: ^serde_json::Value, lang: ^Language) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match v {
    // rust: serde_json::Value::String(s) => s.clone(),
    // rust: serde_json::Value::Array(a) => a.iter().map(|e| json_text(e, lang)).collect(),
    // rust: serde_json::Value::Object(o) => {
    // rust: let mut out = if let Some(t) = o.get("text").and_then(|t| t.as_str()) {
    // rust: t.to_owned()
    // rust: } else if let Some(key) = o.get("translate").and_then(|t| t.as_str()) {
    // rust: let args: Vec<String> = o
    // rust: .get("with")
    // rust: .and_then(|w| w.as_array())
    // rust: .map(|a| a.iter().map(|e| json_text(e, lang)).collect())
    // rust: .unwrap_or_default();
    // rust: let pattern = lang
    // rust: .get(key)
    // rust: .cloned()
    // rust: .or_else(|| {
    // rust: o.get("fallback")
    // rust: .and_then(|f| f.as_str())
    // rust: .map(str::to_owned)
    // rust: })
    // rust: .unwrap_or_else(|| key.to_owned());
    // rust: horizon_protocol::text::format_java(&pattern, &args)
    // rust: } else {
    // rust: String::new()
}
    // rust: if let Some(extra) = o.get("extra").and_then(|e| e.as_array()) {
    // rust: for e in extra {
    // rust: out.push_str(&json_text(e, lang));
}
}
    // rust: out
}
    // rust: other => other.to_string(),
}
}

// The language a session resolves server-sent components with: the selected
// one as `lang` loaded it (`en_us` under it, packs included), so a menu title
// the server sends as a key follows the language screen. A process with no
// language set (a dedicated server's log) reads en_us.json.
load_language :: proc(resources: ^std::path::Path) -> L {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(lang) = crate::lang::current() {
    // rust: return lang.map().clone();
}
    // No language screen ran (a dedicated server's log): en_us, with
    // Horizon's own strings included — the net thread resolves keys with
    // this map (`Reason::keyed`).
    // rust: horizon_client_core::lang::Language::load(&[&resources.to_path_buf()], "en_us")
    // rust: .map()
    // rust: .clone()
}

// Ask a server for its status (ServerStatusPinger): MOTD, players and the
// round trip time in milliseconds.
ping :: proc(address: string, timeout: Duration) -> R {
    // Ported from Horizon
    return {}
}
//     use horizon_protocol::packets::status;
    // rust: let (host, port) = parse_address(address).ok_or("Invalid address")?;
    // rust: let mut c = Connection::connect_server(&host, port, timeout).map_err(|e| e.to_string())?;
    // rust: c.reader
    // rust: .set_read_timeout(Some(timeout))
    // rust: .map_err(|e| e.to_string())?;
    // rust: let e = |e: horizon_protocol::Error| e.to_string();
    // rust: c.send(
    // rust: &handshake::Serverbound::Intention(handshake::Intention {
    // rust: protocol: PROTOCOL_VERSION,
    // rust: host: host.clone(),
    // rust: port,
    // rust: intent: handshake::STATUS,
    // rust: })
    // rust: .encode(),
    // rust: )
    // rust: .map_err(e)?;
    // rust: c.send(&status::Serverbound::StatusRequest(Empty).encode())
    // rust: .map_err(e)?;
    // rust: let (id, payload) = c.recv().map_err(e)?;
    // rust: let json = match status::Clientbound::decode(id, &payload).map_err(e)? {
    // rust: status::Clientbound::StatusResponse(s) => {
    // rust: serde_json::from_str(&s.json).map_err(|e| e.to_string())?
}
    // rust: _ => return Err("unexpected status reply".into()),
}
    // rust: let start = std::time::Instant::now();
    // rust: c.send(&status::Serverbound::PingRequest(status::Ping { time: 1 }).encode())
    // rust: .map_err(e)?;
    // rust: let _ = c.recv().map_err(e)?;
    // rust: Ok((json, start.elapsed().as_millis()))
}

// What a server that answers only the legacy ping reports
// (`LegacyServerPinger.Output.handleResponse`).
LegacyStatus :: struct {
    protocol: i32,
    version: string,
    motd: string,
    players: i32,
    max_players: i32,
}

// `Mth.getInt(str, default)`.
legacy_int :: proc(s: string, default: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: s.parse().unwrap_or(default)
}

// `LegacyServerPinger.channelRead0` on the string after the 0xFF byte: split
// on NUL (at most 6 parts) and the first part must be `§1`.
parse_legacy_status :: proc(text: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let parts: Vec<&str> = text.splitn(6, '\0').collect();
    // rust: if parts.first() != Some(&"\u{a7}1") || parts.len() < 6 {
    // rust: return None;
}
    // rust: Some(LegacyStatus {
    // rust: protocol: legacy_int(parts[1], 0),
    // rust: version: parts[2].to_owned(),
    // rust: motd: parts[3].to_owned(),
    // rust: players: legacy_int(parts[4], -1),
    // rust: max_players: legacy_int(parts[5], -1),
    // rust: })
}

// `LegacyProtocolUtils.writeLegacyString`: the UTF-16 length, then UTF-16BE.
write_legacy_string :: proc(out: ^[dynamic]u8, s: string) {
}
    // rust: let units: Vec<u16> = s.encode_utf16().collect();
    // rust: out.extend_from_slice(&(units.len() as u16).to_be_bytes());
    // rust: for unit in units {
    // rust: out.extend_from_slice(&unit.to_be_bytes());
}
}

// `LegacyServerPinger.channelActive`: the 1.6 `0xFE 0x01 0xFA MC|PingHost` request.
legacy_ping_request :: proc(host: string, port: u16) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = vec![254, 1, 250];
    // rust: write_legacy_string(&mut out, "MC|PingHost");
    // rust: let mut payload = vec![127];
    // rust: write_legacy_string(&mut payload, host);
    // rust: payload.extend_from_slice(&i32::from(port).to_be_bytes());
    // rust: out.extend_from_slice(&(payload.len() as u16).to_be_bytes());
    // rust: out.extend_from_slice(&payload);
    // rust: out
}

// `ServerStatusPinger.pingLegacyServer`: ask a server that does not answer
// the status handshake with the pre-1.7 ping.
ping_legacy :: proc(address: string, timeout: Duration) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let (host, port) = parse_address(address).ok_or("Invalid address")?;
    // rust: let mut c = Connection::connect_server(&host, port, timeout).map_err(|e| e.to_string())?;
    // rust: c.reader
    // rust: .set_read_timeout(Some(timeout))
    // rust: .map_err(|e| e.to_string())?;
    // rust: let e = |e: horizon_protocol::Error| e.to_string();
    // rust: c.writer
    // rust: .write_raw(&legacy_ping_request(&host, port))
    // rust: .map_err(e)?;
    // rust: let head = c.reader.read_raw(3).map_err(e)?;
    // rust: if head[0] != 255 {
    // rust: return Err("unexpected legacy reply".into());
}
    // rust: let units = usize::from(u16::from_be_bytes([head[1], head[2]]));
    // rust: let bytes = c.reader.read_raw(units * 2).map_err(e)?;
    // rust: let units: Vec<u16> = bytes
    // rust: .as_chunks::<2>()
    // rust: .0
    // rust: .iter()
    // rust: .map(|p| u16::from_be_bytes(*p))
    // rust: .collect();
    // rust: parse_legacy_status(&String::from_utf16_lossy(&units))
    // rust: .ok_or_else(|| "unexpected legacy reply".to_owned())
}

// `ClientHandshakePacketListenerImpl.handleHello`: a failed session join goes
// on to encryption only for an entry picked from LAN discovery
// (`ServerData.isLan`), and the host decides. A vanilla client always has an
// account; Horizon without one never joins anything (Mojang's rules: no play
// without an account that owns the game), LAN included.
continues_after_failed_join :: proc(lan: bool, signed_in: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: lan && signed_in
}

    // rust: mod tests {
//     use super::*;

pack :: proc(namespace: string, id: string, version: string) -> c {
    // Ported from Horizon
    return {}
}
    // rust: cfg::KnownPack {
    // rust: namespace: namespace.into(),
    // rust: id: id.into(),
    // rust: version: version.into(),
}
}

the_client_knows_vanilla_core_pack_of_its_own_version_only :: proc() {
}
    // rust: let core = pack("minecraft", "core", horizon_protocol::GAME_VERSION);
    // rust: let offered = vec![
    // rust: core.clone(),
    // rust: pack(
    // rust: "minecraft",
    // rust: "trade_rebalance",
    // rust: horizon_protocol::GAME_VERSION,
    // rust: ),
    // rust: pack("example", "server_pack", "1"),
    // rust: ];
    // rust: assert_eq!(select_known_packs(offered), vec![core]);
    // rust: assert_eq!(
    // rust: select_known_packs(vec![pack("minecraft", "core", "1.21.11")]),
    // rust: vec![]
    // rust: );
    // rust: assert_eq!(select_known_packs(vec![]), vec![]);
}

a_known_entry_takes_its_data_from_the_clients_pack :: proc() {
}
    // rust: let root = std::env::temp_dir().join(format!("hz-known-entries-{}", std::process::id()));
    // rust: let dir = root.join("data/minecraft/damage_type");
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: std::fs::write(
    // rust: dir.join("in_fire.json"),
    // rust: br#"{"message_id": "inFire", "exhaustion": 0.1, "scaling": "when_caused_by_living_non_player"}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let sent = Tag::compound(vec![(
    // rust: "message_id",
    // rust: Tag::String(JavaString::from("custom")),
    // rust: )]);
    // rust: let mut r = cfg::RegistryData {
    // rust: registry: "minecraft:damage_type".into(),
    // rust: entries: vec![
    // rust: cfg::RegistryEntry {
    // rust: id: "minecraft:in_fire".into(),
    // rust: data: None,
    // rust: },
    // rust: cfg::RegistryEntry {
    // rust: id: "minecraft:custom".into(),
    // rust: data: Some(sent.clone()),
    // rust: },
    // rust: cfg::RegistryEntry {
    // rust: id: "minecraft:missing".into(),
    // rust: data: None,
    // rust: },
    // rust: ],
}
    // rust: fill_known_entries(&mut r, &root);
    // rust: std::fs::remove_dir_all(&root).unwrap();
    // rust: let Some(Tag::Compound(filled)) = &r.entries[0].data else {
    // rust: panic!("in_fire was not filled: {:?}", r.entries[0].data);
}
    // rust: assert_eq!(
    // rust: filled.get(&JavaString::from("message_id")),
    // rust: Some(&Tag::String(JavaString::from("inFire")))
    // rust: );
        // Data the server sent stays; an entry the client has no file for stays empty.
    // rust: assert_eq!(r.entries[1].data, Some(sent));
    // rust: assert_eq!(r.entries[2].data, None);
}

    // Launchers find the last server joined in `latest.log` by vanilla's line.
the_connecting_line_is_vanillas :: proc() {
}
    // rust: let line = |address: &str| {
    // rust: let (host, port) = parse_address(address).unwrap();
    // rust: connecting_line(&host, port)
}
    // rust: assert_eq!(
    // rust: line("play.example.net"),
    // rust: "Connecting to play.example.net, 25565"
    // rust: );
    // rust: assert_eq!(
    // rust: line("play.example.net:25577"),
    // rust: "Connecting to play.example.net, 25577"
    // rust: );
    // rust: assert_eq!(line("[::1]:25566"), "Connecting to ::1, 25566");
}

studio_recording_drops_packets_with_direct_player_identity_or_private_text :: proc() {
}
//         use horizon_protocol::packets::configuration::{
    // rust: ResourcePackPush, ServerLink, ServerLinkKind, ServerLinks, StoreCookie, Transfer,
}
//         use play::{
    // rust: ChatTypeBound, Clientbound as P, CustomChatCompletions, PlayerInfo, PlayerInfoRemove,
    // rust: PlayerInfoUpdate, ResetScore, SetPlayerTeam, SetScore, TrackedWaypoint, WaypointId,
    // rust: WaypointTarget,
}

    // rust: let packets = [
    // rust: P::CookieRequest(cfg::CookieRequest {
    // rust: key: "private_cookie".into(),
    // rust: }),
    // rust: P::CustomChatCompletions(CustomChatCompletions {
    // rust: action: 2,
    // rust: entries: vec!["/msg PlayerName private text".into()],
    // rust: }),
    // rust: P::CustomPayload(cfg::CustomPayload {
    // rust: channel: "private:channel".into(),
    // rust: data: b"private payload".to_vec(),
    // rust: }),
    // rust: P::DeleteChat(play::DeleteChat {
    // rust: signature: (3, Some(vec![1, 2, 3])),
    // rust: }),
    // rust: P::DisguisedChat(play::DisguisedChat {
    // rust: message: Tag::String("private message".into()),
    // rust: chat_type: ChatTypeBound {
    // rust: chat_type: 0,
    // rust: name: Tag::String("PlayerName".into()),
    // rust: target: None,
    // rust: },
    // rust: }),
    // rust: P::PlayerCombatKill(play::PlayerCombatKill {
    // rust: id: 7,
    // rust: message: Tag::String("PlayerName was slain".into()),
    // rust: }),
    // rust: P::PlayerChat(play::PlayerChat {
    // rust: global_index: 1,
    // rust: sender: 7,
    // rust: index: 2,
    // rust: signature: None,
    // rust: content: "private message".into(),
    // rust: timestamp: 3,
    // rust: salt: 4,
    // rust: last_seen: vec![],
    // rust: unsigned_content: None,
    // rust: filter: (0, vec![]),
    // rust: chat_type: ChatTypeBound {
    // rust: chat_type: 0,
    // rust: name: Tag::String("PlayerName".into()),
    // rust: target: None,
    // rust: },
    // rust: }),
    // rust: P::ResetScore(ResetScore {
    // rust: owner: "PlayerName".into(),
    // rust: objective: Some("deaths".into()),
    // rust: }),
    // rust: P::SetScore(SetScore {
    // rust: owner: "PlayerName".into(),
    // rust: objective: "deaths".into(),
    // rust: score: 1,
    // rust: display: None,
    // rust: number_format: None,
    // rust: }),
    // rust: P::PlayerInfoRemove(PlayerInfoRemove { uuids: vec![7] }),
    // rust: P::PlayerInfoUpdate(PlayerInfoUpdate {
    // rust: actions: 1,
    // rust: entries: vec![PlayerInfo {
    // rust: uuid: 7,
    // rust: name: Some("PlayerName".into()),
    // rust: ..PlayerInfo::default()
    // rust: }],
    // rust: }),
    // rust: P::ResourcePackPush(ResourcePackPush {
    // rust: id: 8,
    // rust: url: "https://private.example/pack.zip".into(),
    // rust: hash: "hash".into(),
    // rust: required: false,
    // rust: prompt: None,
    // rust: }),
    // rust: P::ServerLinks(ServerLinks {
    // rust: links: vec![ServerLink {
    // rust: kind: ServerLinkKind::Known(0),
    // rust: link: "https://private.example".into(),
    // rust: }],
    // rust: }),
    // rust: P::SetPlayerTeam(SetPlayerTeam {
    // rust: name: "red".into(),
    // rust: method: 3,
    // rust: parameters: None,
    // rust: players: vec!["PlayerName".into()],
    // rust: }),
    // rust: P::StoreCookie(StoreCookie {
    // rust: key: "private_cookie".into(),
    // rust: payload: b"secret".to_vec(),
    // rust: }),
    // rust: P::SystemChat(play::SystemChat {
    // rust: content: Tag::String("private message".into()),
    // rust: overlay: false,
    // rust: }),
    // rust: P::TabList(play::TabList {
    // rust: header: Tag::String("PlayerName".into()),
    // rust: footer: Tag::End,
    // rust: }),
    // rust: P::TrackedWaypoint(TrackedWaypoint {
    // rust: operation: play::waypoint_operation::TRACK,
    // rust: id: WaypointId::Uuid(7),
    // rust: style: "minecraft:default".into(),
    // rust: color: None,
    // rust: target: WaypointTarget::Empty,
    // rust: }),
    // rust: P::Transfer(Transfer {
    // rust: host: "private.example".into(),
    // rust: port: 25565,
    // rust: }),
    // rust: P::Disconnect(cfg::Disconnect {
    // rust: reason: Tag::String("PlayerName was disconnected".into()),
    // rust: }),
    // rust: P::Unknown(999, b"unclassified private payload".to_vec()),
    // rust: ];

    // rust: for packet in packets {
    // rust: assert!(
    // rust: studio_recording_packet(&packet, packet.id(), b"raw packet payload").is_none(),
    // rust: "{} should be excluded from recordings",
    // rust: packet.name()
    // rust: );
}
}

studio_recording_replaces_entity_uuids_but_keeps_entity_state :: proc() {
}
    // rust: let original = play::AddEntity {
    // rust: id: 18,
    // rust: uuid: 0x0102_0304_0506_0708_090a_0b0c_0d0e_0f10,
    // rust: kind: 42,
    // rust: position: [1.0, 64.0, -2.0],
    // rust: velocity: [0.0, 0.0, 0.0],
    // rust: pitch: 1,
    // rust: yaw: 2,
    // rust: head_yaw: 3,
    // rust: data: 4,
}
    // rust: let packet = play::Clientbound::AddEntity(original.clone());
    // rust: let (id, payload) = studio_recording_packet(&packet, packet.id(), b"unused").unwrap();
    // rust: let play::Clientbound::AddEntity(recorded) =
    // rust: play::Clientbound::decode(id, &payload).unwrap()
    // rust: else {
    // rust: panic!("sanitized packet changed type")
}

    // rust: assert_ne!(recorded.uuid, original.uuid);
    // rust: assert_eq!(recorded.id, original.id);
    // rust: assert_eq!(recorded.kind, original.kind);
    // rust: assert_eq!(recorded.position, original.position);
    // rust: assert_eq!(recorded.velocity, original.velocity);
    // rust: assert_eq!(recorded.pitch, original.pitch);
    // rust: assert_eq!(recorded.yaw, original.yaw);
    // rust: assert_eq!(recorded.head_yaw, original.head_yaw);
    // rust: assert_eq!(recorded.data, original.data);
}

direct_login_preserves_hostname_and_negotiates_brand :: proc() {
}
    // rust: for server_brand in [
    // rust: b"\x07vanilla".as_slice(),
    // rust: b"\x07horizon",
    // rust: b"\x05Paper",
    // rust: b"\xff",
    // rust: ] {
    // rust: let listener = std::net::TcpListener::bind("127.0.0.1:0").unwrap();
    // rust: let port = listener.local_addr().unwrap().port();
    // rust: let session = Session::connect(
    // rust: &format!("localhost:{port}"),
    // rust: "Probe",
    // rust: None,
    // rust: cfg::ClientInformation::new(8),
    // rust: Arc::new(Language::new()),
    // rust: PathBuf::new(),
    // rust: );
    // rust: let (stream, _) = listener.accept().unwrap();
    // rust: stream
    // rust: .set_read_timeout(Some(Duration::from_secs(5)))
    // rust: .unwrap();
    // rust: let mut server = Connection::from_stream(stream).unwrap();
    // rust: let (id, body) = server.recv().unwrap();
    // rust: let handshake::Serverbound::Intention(packet) =
    // rust: handshake::Serverbound::decode(id, &body).unwrap()
    // rust: else {
    // rust: panic!("expected login handshake")
}
    // rust: assert_eq!((packet.host.as_str(), packet.port), ("localhost", port));
    // rust: assert_eq!(packet.intent, handshake::LOGIN);
    // rust: server.recv().unwrap(); // login profile
    // rust: server
    // rust: .send(
    // rust: &login::Clientbound::LoginFinished(login::LoginFinished {
    // rust: profile: login::GameProfile {
    // rust: uuid: 1,
    // rust: name: "Probe".into(),
    // rust: properties: vec![],
    // rust: },
    // rust: session: 1,
    // rust: })
    // rust: .encode(),
    // rust: )
    // rust: .unwrap();
    // rust: let (id, body) = server.recv().unwrap();
    // rust: assert!(matches!(
    // rust: login::Serverbound::decode(id, &body).unwrap(),
    // rust: login::Serverbound::LoginAcknowledged(_)
    // rust: ));
            // handleLoginFinished: the brand first, then the information.
    // rust: let (id, body) = server.recv().unwrap();
    // rust: assert_eq!(
    // rust: cfg::Serverbound::decode(id, &body).unwrap(),
    // rust: cfg::Serverbound::CustomPayload(cfg::CustomPayload {
    // rust: channel: "minecraft:brand".into(),
    // rust: data: b"\x07vanilla".to_vec(),
    // rust: })
    // rust: );
    // rust: let (id, body) = server.recv().unwrap();
    // rust: assert!(matches!(
    // rust: cfg::Serverbound::decode(id, &body).unwrap(),
    // rust: cfg::Serverbound::ClientInformation(_)
    // rust: ));
    // rust: server
    // rust: .send(
    // rust: &cfg::Clientbound::CustomPayload(cfg::CustomPayload {
    // rust: channel: "minecraft:brand".into(),
    // rust: data: server_brand.to_vec(),
    // rust: })
    // rust: .encode(),
    // rust: )
    // rust: .unwrap();
    // rust: server
    // rust: .send(
    // rust: &cfg::Clientbound::SelectKnownPacks(cfg::SelectKnownPacks { packs: vec![] })
    // rust: .encode(),
    // rust: )
    // rust: .unwrap();
    // rust: if server_brand == b"\x07horizon" {
    // rust: let (id, body) = server.recv().unwrap();
    // rust: assert_eq!(
    // rust: cfg::Serverbound::decode(id, &body).unwrap(),
    // rust: cfg::Serverbound::CustomPayload(cfg::CustomPayload {
    // rust: channel: "minecraft:brand".into(),
    // rust: data: b"\x07horizon".to_vec(),
    // rust: })
    // rust: );
}
            // The response to the pack query proves any brand reply precedes it.
            // Non-Horizon servers must receive no additional brand announcement.
    // rust: let (id, body) = server.recv().unwrap();
    // rust: assert_eq!(
    // rust: cfg::Serverbound::decode(id, &body).unwrap(),
    // rust: cfg::Serverbound::SelectKnownPacks(cfg::SelectKnownPacks { packs: vec![] })
    // rust: );
    // rust: drop(server);
    // rust: drop(session);
}
}

legacy_ping_request_is_the_1_6_ping_host_packet :: proc() {
}
    // rust: let bytes = legacy_ping_request("a.b", 25565);
    // rust: assert_eq!(&bytes[..3], &[254, 1, 250]);
        // "MC|PingHost": 11 chars.
    // rust: assert_eq!(&bytes[3..5], &[0, 11]);
    // rust: let after = 5 + 22;
        // payload: 127, string (2 + 6 bytes), port.
    // rust: assert_eq!(&bytes[after..after + 2], &[0, 1 + 2 + 6 + 4]);
    // rust: assert_eq!(bytes[after + 2], 127);
    // rust: assert_eq!(&bytes[after + 3..after + 5], &[0, 3]);
    // rust: assert_eq!(&bytes[bytes.len() - 4..], &25565i32.to_be_bytes());
}

legacy_status_is_split_on_nul_after_the_section_one_marker :: proc() {
}
    // rust: let status =
    // rust: parse_legacy_status("\u{a7}1\x00127\x001.6.4\x00A \u{a7}aserver\x003\x0020").unwrap();
    // rust: assert_eq!(
    // rust: status,
    // rust: LegacyStatus {
    // rust: protocol: 127,
    // rust: version: "1.6.4".into(),
    // rust: motd: "A \u{a7}aserver".into(),
    // rust: players: 3,
    // rust: max_players: 20,
}
    // rust: );
        // Unparsable counts are -1, a wrong marker is no status.
    // rust: let status = parse_legacy_status("\u{a7}1\x00x\x00v\x00m\x00?\x00?").unwrap();
    // rust: assert_eq!(
    // rust: (status.protocol, status.players, status.max_players),
    // rust: (0, -1, -1)
    // rust: );
    // rust: assert!(parse_legacy_status("kick\x00127\x00v\x00m\x001\x002").is_none());
}

    // The en_us text of the disconnect reasons.
disconnect_language :: proc() -> L {
    // Ported from Horizon
    return {}
}
    // rust: [
    // rust: ("disconnect.timeout", "Timed out"),
    // rust: ("disconnect.endOfStream", "End of stream"),
    // rust: ("disconnect.genericReason", "%s"),
    // rust: ]
    // rust: .into_iter()
    // rust: .map(|(k, v)| (k.to_owned(), v.to_owned()))
    // rust: .collect()
}

a_server_that_stops_answering_times_out :: proc() {
}
        // The server accepts and then sends nothing, like a frozen server
        // or a network gone without a reset.
    // rust: let listener = std::net::TcpListener::bind("127.0.0.1:0").unwrap();
    // rust: let port = listener.local_addr().unwrap().port();
    // rust: let held = std::thread::spawn(move || listener.accept().map(|(stream, _)| stream));
    // rust: let (c, _, _) = connect_tcp("127.0.0.1", port, true, Duration::from_millis(300)).unwrap();
    // rust: let _server = held.join().unwrap().unwrap();
    // rust: let (mut reader, writer) = c.split();
    // rust: let (done, result) = channel();
    // rust: std::thread::spawn(move || {
    // rust: let (send, _events) = channel();
    // rust: let _ = done.send(receive_play(
    // rust: &mut reader,
    // rust: &Mutex::new(Some(writer)),
    // rust: &AtomicBool::new(false),
    // rust: &disconnect_language(),
    // rust: &send,
    // rust: &Cookies::default(),
    // rust: &crate::lod_net::Inbox::default(),
    // rust: Path::new("."),
    // rust: &Arc::new(Mutex::new(None)),
    // rust: ));
    // rust: });
    // rust: let ended = result
    // rust: .recv_timeout(Duration::from_secs(10))
    // rust: .expect("the connection never timed out");
    // rust: assert_eq!(
    // rust: ended.map(|r| r.text).map_err(|r| r.text),
    // rust: Err("Timed out".to_owned())
    // rust: );
}

lost_connections_read_like_vanillas_disconnect_reasons :: proc() {
}
    // rust: let lang = disconnect_language();
    // rust: let lost = |e| connection_lost(e, &lang);
    // rust: assert_eq!(lost(horizon_protocol::Error::timed_out()), "Timed out");
    // rust: assert_eq!(
    // rust: lost(horizon_protocol::Error::end_of_stream()),
    // rust: "End of stream"
    // rust: );
    // rust: assert_eq!(
    // rust: lost(horizon_protocol::Error::new("Bad VarInt")),
    // rust: "Internal Exception: Bad VarInt"
    // rust: );
}

configuration_answers_the_content_identity_challenge :: proc() {
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-content-identity-{}", std::process::id()));
    // rust: std::fs::create_dir_all(&root).unwrap();
    // rust: std::fs::write(
    // rust: root.join("facts.json"),
    // rust: br#"{"states":[["minecraft:stone",false,false,"Block{minecraft:stone}",{"id":"minecraft:stone"}]]}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let expected = crate::content_identity::identity(&root).unwrap();
    // rust: let (client, server) = horizon_protocol::connection::Pipe::pair();
    // rust: let (mut reader, writer) = Connection::local(client).split();
    // rust: let writer = Mutex::new(Some(writer));
    // rust: let thread = std::thread::spawn(move || {
    // rust: let (send, _events) = channel();
    // rust: configure(
    // rust: &mut reader,
    // rust: &writer,
    // rust: &AtomicBool::new(true),
    // rust: &Language::new(),
    // rust: &send,
    // rust: &Cookies::default(),
    // rust: &root,
    // rust: )
    // rust: });
    // rust: let mut server = Connection::local(server);
    // rust: server
    // rust: .send(
    // rust: &cfg::Clientbound::CustomPayload(cfg::CustomPayload {
    // rust: channel: crate::content_identity::CHANNEL.into(),
    // rust: data: vec![],
    // rust: })
    // rust: .encode(),
    // rust: )
    // rust: .unwrap();
    // rust: server
    // rust: .send(&cfg::Clientbound::Ping(cfg::Ping { id: 17 }).encode())
    // rust: .unwrap();
    // rust: let (id, body) = server.recv().unwrap();
    // rust: assert_eq!(
    // rust: cfg::Serverbound::decode(id, &body).unwrap(),
    // rust: cfg::Serverbound::CustomPayload(cfg::CustomPayload {
    // rust: channel: crate::content_identity::CHANNEL.into(),
    // rust: data: expected.to_vec(),
    // rust: })
    // rust: );
    // rust: let (id, body) = server.recv().unwrap();
    // rust: assert_eq!(
    // rust: cfg::Serverbound::decode(id, &body).unwrap(),
    // rust: cfg::Serverbound::Pong(cfg::Ping { id: 17 })
    // rust: );
    // rust: server
    // rust: .send(&cfg::Clientbound::FinishConfiguration(Empty).encode())
    // rust: .unwrap();
    // rust: let (id, body) = server.recv().unwrap();
    // rust: assert_eq!(
    // rust: cfg::Serverbound::decode(id, &body).unwrap(),
    // rust: cfg::Serverbound::FinishConfiguration(Empty)
    // rust: );
    // rust: assert!(thread.join().unwrap().is_ok());
    // rust: std::fs::remove_dir_all(
    // rust: std::env::temp_dir().join(format!("horizon-content-identity-{}", std::process::id())),
    // rust: )
    // rust: .unwrap();
}

disconnect_and_drop_do_not_wait_for_a_stalled_reader :: proc() {
}
        // A reader can remain stalled after Windows socket shutdown. It must
        // not delay either an explicit leave or Session's Drop on the UI thread.
    // rust: for explicit_disconnect in [true, false] {
    // rust: let (client, _server) = horizon_protocol::connection::Pipe::pair();
    // rust: let (_reader, writer) = Connection::local(client).split();
    // rust: let writer = Arc::new(Mutex::new(Some(writer)));
    // rust: let (_send, events) = channel();
    // rust: let (release, stalled) = channel();
    // rust: let (finished, completed) = channel();
    // rust: let thread = std::thread::spawn(move || {
    // rust: let _ = stalled.recv_timeout(std::time::Duration::from_secs(3));
    // rust: let _ = finished.send(());
    // rust: });
    // rust: let mut session = Session {
    // rust: events,
    // rust: writer: writer.clone(),
    // rust: configuring: Arc::new(AtomicBool::new(false)),
    // rust: thread: Some(thread),
    // rust: address: "local".into(),
    // rust: name: "TestPlayer".into(),
    // rust: counters: Arc::new(Mutex::new(None)),
    // rust: cookies: Cookies::default(),
    // rust: debug: false,
    // rust: far: Arc::default(),
    // rust: recorder: Arc::new(Mutex::new(None)),
}
    // rust: let started = std::time::Instant::now();
    // rust: if explicit_disconnect {
    // rust: session.disconnect();
    // rust: session.disconnect(); // Repeated cleanup is harmless.
}
    // rust: drop(session);
    // rust: let elapsed = started.elapsed();
    // rust: let reader_still_pending = completed.try_recv().is_err();
            // Always release the synthetic reader before asserting, even if
            // a future regression restores the blocking join.
    // rust: let _ = release.send(());
    // rust: if reader_still_pending {
    // rust: completed
    // rust: .recv_timeout(std::time::Duration::from_secs(2))
    // rust: .unwrap();
}
    // rust: assert!(
    // rust: writer.lock().unwrap().is_none(),
    // rust: "connection was not closed"
    // rust: );
    // rust: assert!(
    // rust: reader_still_pending,
    // rust: "disconnect waited for the stalled reader"
    // rust: );
    // rust: assert!(
    // rust: elapsed < std::time::Duration::from_secs(1),
    // rust: "disconnect took {elapsed:?}"
    // rust: );
}
}

pings_wait_behind_teleports_but_keepalives_do_not_wait_for_the_game :: proc() {
}
    // rust: let (client, server) = horizon_protocol::connection::Pipe::pair();
    // rust: let (mut reader, writer) = Connection::local(client).split();
    // rust: let writer = Arc::new(Mutex::new(Some(writer)));
    // rust: let (send, events) = channel();
    // rust: let thread_writer = writer.clone();
    // rust: let thread = std::thread::spawn(move || {
    // rust: receive_play(
    // rust: &mut reader,
    // rust: &thread_writer,
    // rust: &AtomicBool::new(false),
    // rust: &Language::new(),
    // rust: &send,
    // rust: &Cookies::default(),
    // rust: &crate::lod_net::Inbox::default(),
    // rust: Path::new("."),
    // rust: &Arc::new(Mutex::new(None)),
    // rust: )
    // rust: });
    // rust: let mut server = Connection::local(server);
    // rust: let teleport = play::Clientbound::PlayerPosition(play::PlayerPosition {
    // rust: teleport: 42,
    // rust: position: [10.0, 64.0, 10.0],
    // rust: delta: [0.0; 3],
    // rust: yaw: 90.0,
    // rust: pitch: 0.0,
    // rust: relatives: 0,
    // rust: });
    // rust: server.send(&teleport.encode()).unwrap();
    // rust: server
    // rust: .send(&play::Clientbound::Ping(cfg::Ping { id: 7 }).encode())
    // rust: .unwrap();
        // A reply to this proves the receive loop has passed the ping. The
        // old implementation instead replies with Pong before this keepalive.
    // rust: server
    // rust: .send(&play::Clientbound::KeepAlive(cfg::KeepAlive { id: 9 }).encode())
    // rust: .unwrap();
    // rust: let (id, body) = server.recv().unwrap();
    // rust: assert_eq!(
    // rust: play::Serverbound::decode(id, &body).unwrap(),
    // rust: play::Serverbound::KeepAlive(cfg::KeepAlive { id: 9 })
    // rust: );
    // rust: let timeout = Duration::from_secs(5);
    // rust: assert!(
    // rust: matches!(events.recv_timeout(timeout).unwrap(), Event::Packet(p) if *p == teleport)
    // rust: );
    // rust: assert!(
    // rust: matches!(events.recv_timeout(timeout).unwrap(), Event::Packet(p) if *p == play::Clientbound::Ping(cfg::Ping { id: 7 }))
    // rust: );
    // rust: writer.lock().unwrap().take().unwrap().shutdown();
    // rust: assert!(thread.join().unwrap().is_err());
}

play_packets_wait_out_a_reconfiguration :: proc() {
}
    // rust: let (client, server) = horizon_protocol::connection::Pipe::pair();
    // rust: let (mut reader, writer) = Connection::local(client).split();
    // rust: let (send, events) = channel();
    // rust: let session = Session {
    // rust: events,
    // rust: writer: Arc::new(Mutex::new(Some(writer))),
    // rust: configuring: Arc::new(AtomicBool::new(false)),
    // rust: thread: None,
    // rust: address: "local".into(),
    // rust: name: "Player".into(),
    // rust: counters: Arc::new(Mutex::new(None)),
    // rust: cookies: Cookies::default(),
    // rust: debug: false,
    // rust: far: Arc::default(),
    // rust: recorder: Arc::new(Mutex::new(None)),
}
    // rust: let (thread_writer, thread_configuring, thread_recorder) = (
    // rust: session.writer.clone(),
    // rust: session.configuring.clone(),
    // rust: session.recorder.clone(),
    // rust: );
    // rust: let thread = std::thread::spawn(move || {
    // rust: receive_play(
    // rust: &mut reader,
    // rust: &thread_writer,
    // rust: &thread_configuring,
    // rust: &Language::new(),
    // rust: &send,
    // rust: &Cookies::default(),
    // rust: &crate::lod_net::Inbox::default(),
    // rust: Path::new("."),
    // rust: &thread_recorder,
    // rust: )
    // rust: });
    // rust: let mut server = Connection::local(server);
    // rust: let tick_end = play::Serverbound::ClientTickEnd(Empty);
    // rust: server
    // rust: .send(&play::Clientbound::StartConfiguration(Empty).encode())
    // rust: .unwrap();
    // rust: let (id, body) = server.recv().unwrap();
    // rust: assert_eq!(
    // rust: play::Serverbound::decode(id, &body).unwrap(),
    // rust: play::Serverbound::ConfigurationAcknowledged(Empty)
    // rust: );
        // The game thread still ticks the old level: nothing of it goes out.
    // rust: session.send(tick_end.clone());
    // rust: server
    // rust: .send(&cfg::Clientbound::FinishConfiguration(Empty).encode())
    // rust: .unwrap();
    // rust: let (id, body) = server.recv().unwrap();
    // rust: assert_eq!(
    // rust: cfg::Serverbound::decode(id, &body).unwrap(),
    // rust: cfg::Serverbound::FinishConfiguration(Empty)
    // rust: );
        // Back in play, the game's packets flow again.
    // rust: session.send(tick_end.clone());
    // rust: let (id, body) = server.recv().unwrap();
    // rust: assert_eq!(play::Serverbound::decode(id, &body).unwrap(), tick_end);
    // rust: drop(session);
    // rust: assert!(thread.join().unwrap().is_err());
}

play_answers_cookie_requests_from_stored_cookies_and_follows_transfers :: proc() {
}
    // rust: let (client, server) = horizon_protocol::connection::Pipe::pair();
    // rust: let (mut reader, writer) = Connection::local(client).split();
    // rust: let writer = Arc::new(Mutex::new(Some(writer)));
    // rust: let (send, events) = channel();
    // rust: let cookies = Cookies::default();
    // rust: let (thread_writer, thread_cookies) = (writer.clone(), cookies.clone());
    // rust: let thread = std::thread::spawn(move || {
    // rust: receive_play(
    // rust: &mut reader,
    // rust: &thread_writer,
    // rust: &AtomicBool::new(false),
    // rust: &Language::new(),
    // rust: &send,
    // rust: &thread_cookies,
    // rust: &crate::lod_net::Inbox::default(),
    // rust: Path::new("."),
    // rust: &Arc::new(Mutex::new(None)),
    // rust: )
    // rust: });
    // rust: let mut server = Connection::local(server);
    // rust: let ask = |server: &mut Connection, key: &str| {
    // rust: let request = play::Clientbound::CookieRequest(cfg::CookieRequest { key: key.into() });
    // rust: server.send(&request.encode()).unwrap();
    // rust: let (id, body) = server.recv().unwrap();
    // rust: play::Serverbound::decode(id, &body).unwrap()
}
        // handleRequestCookie answers an unknown key with no payload.
    // rust: assert_eq!(
    // rust: ask(&mut server, "proxy:session"),
    // rust: play::Serverbound::CookieResponse(cfg::CookieResponse {
    // rust: key: "proxy:session".into(),
    // rust: payload: None,
    // rust: })
    // rust: );
    // rust: let store = play::Clientbound::StoreCookie(cfg::StoreCookie {
    // rust: key: "proxy:session".into(),
    // rust: payload: vec![1, 2, 3],
    // rust: });
    // rust: server.send(&store.encode()).unwrap();
    // rust: assert_eq!(
    // rust: ask(&mut server, "proxy:session"),
    // rust: play::Serverbound::CookieResponse(cfg::CookieResponse {
    // rust: key: "proxy:session".into(),
    // rust: payload: Some(vec![1, 2, 3]),
    // rust: })
    // rust: );
    // rust: let transfer = play::Clientbound::Transfer(cfg::Transfer {
    // rust: host: "example.net".into(),
    // rust: port: 25566,
    // rust: });
    // rust: server.send(&transfer.encode()).unwrap();
    // rust: assert!(thread.join().unwrap().is_ok());
    // rust: assert!(matches!(
    // rust: events.try_iter().last(),
    // rust: Some(Event::Transfer { host, port: 25566 }) if host == "example.net"
    // rust: ));
        // The stored cookie stays for the next connection (TransferState).
    // rust: assert_eq!(
    // rust: cookies.lock().unwrap().get("proxy:session"),
    // rust: Some(&vec![1, 2, 3])
    // rust: );
}

server_brand_payload_is_decoded_and_invalid_or_unrelated_payloads_are_ignored :: proc() {
}
    // rust: let (send, events) = channel();
    // rust: let mut writer = horizon_protocol::buf::Writer::new();
    // rust: writer.string("vanilla");
    // rust: let mut payload = cfg::CustomPayload {
    // rust: channel: "minecraft:brand".into(),
    // rust: data: writer.data,
}
    // rust: receive_brand(&payload, &send);
    // rust: assert!(matches!(events.try_recv(), Ok(Event::Brand(brand)) if brand == "vanilla"));
    // rust: payload.channel = "example:other".into();
    // rust: receive_brand(&payload, &send);
    // rust: assert!(events.try_recv().is_err());
    // rust: payload.channel = "minecraft:brand".into();
    // rust: payload.data = vec![0xff];
    // rust: receive_brand(&payload, &send);
    // rust: assert!(events.try_recv().is_err());
}
    // No account never joins; the signed-in rule is compared with the real
    // client login listener by test_lan_auth_parity.py.
lan_login_continues_after_authentication_failure :: proc() {
}
    // rust: for lan in [true, false] {
    // rust: let listener = std::net::TcpListener::bind("127.0.0.1:0").unwrap();
    // rust: let port = listener.local_addr().unwrap().port();
    // rust: let worker = std::thread::spawn(move || {
    // rust: let (stream, _) = listener.accept().unwrap();
                // Generous: a debug build's key generation on a busy CI runner takes seconds. A pass
                // never waits for these.
    // rust: stream
    // rust: .set_read_timeout(Some(Duration::from_secs(60)))
    // rust: .unwrap();
    // rust: let mut server = Connection::from_stream(stream).unwrap();
    // rust: server.recv().unwrap(); // intention
    // rust: server.recv().unwrap(); // profile
    // rust: let key = horizon_protocol::rsa::RsaPrivateKey::generate(1024).unwrap();
    // rust: let challenge = vec![1, 2, 3, 4];
    // rust: server
    // rust: .send(
    // rust: &login::Clientbound::Hello(login::Hello {
    // rust: server_id: String::new(),
    // rust: public_key: key.public_der(),
    // rust: challenge: challenge.clone(),
    // rust: should_authenticate: true,
    // rust: })
    // rust: .encode(),
    // rust: )
    // rust: .unwrap();
    // rust: let Ok((id, body)) = server.recv() else {
    // rust: return false;
}
    // rust: let login::Serverbound::Key(reply) = login::Serverbound::decode(id, &body).unwrap()
    // rust: else {
    // rust: panic!("client did not send encryption reply")
}
    // rust: assert_eq!(key.decrypt(&reply.challenge).unwrap(), challenge);
    // rust: let secret: [u8; 16] = key.decrypt(&reply.key).unwrap().try_into().unwrap();
    // rust: server.enable_encryption(&secret);
    // rust: server
    // rust: .send(
    // rust: &login::Clientbound::Disconnect(login::Disconnect {
    // rust: reason_json: r#"{"text":"LAN fixture accepted"}"#.into(),
    // rust: })
    // rust: .encode(),
    // rust: )
    // rust: .unwrap();
    // rust: true
    // rust: });
    // rust: let address = format!("127.0.0.1:{port}");
    // rust: let connect = if lan {
    // rust: Session::connect_lan
    // rust: } else {
    // rust: Session::connect
}
            // The session's language carries Horizon's bundled strings
            // (`load_language`), so the keyed refusal resolves.
    // rust: let lang: Language = [(
    // rust: "horizon.multiplayer.not_signed_in".to_owned(),
    // rust: NOT_SIGNED_IN.to_owned(),
    // rust: )]
    // rust: .into_iter()
    // rust: .collect();
    // rust: let session = connect(
    // rust: &address,
    // rust: "Tester",
    // rust: None,
    // rust: cfg::ClientInformation::new(8),
    // rust: Arc::new(lang),
    // rust: PathBuf::new(),
    // rust: );
    // rust: let reason = loop {
    // rust: if let Event::Disconnected { reason, .. } = session
    // rust: .events
    // rust: .recv_timeout(Duration::from_secs(60))
    // rust: .unwrap()
    // rust: {
    // rust: break reason;
}
}
            // Without an account nothing joins, LAN or not.
    // rust: let sent_key = worker.join().unwrap();
    // rust: assert!(!sent_key, "lan {lan}: joined without an account");
    // rust: assert_eq!(reason, NOT_SIGNED_IN);
            // A signed-in account whose join the session service rejects:
            // the case vanilla's listener is run with.
    // rust: let goes_on = continues_after_failed_join(lan, true);
    // rust: assert_eq!(goes_on, lan);
    // rust: println!(
    // rust: "lan_auth={}:{}:{}",
    // rust: if lan { "LAN" } else { "OTHER" },
    // rust: goes_on,
    // rust: !goes_on
    // rust: );
}
}

session_studio_recording_tap_records_packets_to_mcpr :: proc() {
}
    // rust: let (client, server) = horizon_protocol::connection::Pipe::pair();
    // rust: let (mut reader, writer) = Connection::local(client).split();
    // rust: let (send, events) = channel();
    // rust: let session = Session {
    // rust: events,
    // rust: writer: Arc::new(Mutex::new(Some(writer))),
    // rust: configuring: Arc::new(AtomicBool::new(false)),
    // rust: thread: None,
    // rust: address: "local".into(),
    // rust: name: "StudioTester".into(),
    // rust: counters: Arc::new(Mutex::new(None)),
    // rust: cookies: Cookies::default(),
    // rust: debug: false,
    // rust: far: Arc::default(),
    // rust: recorder: Arc::new(Mutex::new(None)),
}

    // rust: let temp_dir = std::env::temp_dir().join(format!(
    // rust: "horizon-studio-test-{}_{}",
    // rust: std::process::id(),
    // rust: std::time::SystemTime::now()
    // rust: .duration_since(std::time::UNIX_EPOCH)
    // rust: .unwrap()
    // rust: .as_nanos()
    // rust: ));
    // rust: let _ = std::fs::create_dir_all(&temp_dir);
    // rust: let mcpr_path = temp_dir.join("test_tap.mcpr");

    // rust: let meta = Metadata::new("Singleplayer World".into(), true, "26.3".into());
    // rust: session.start_recording(&mcpr_path, meta).unwrap();
    // rust: assert!(session.is_recording());

    // rust: let (thread_writer, thread_configuring, thread_recorder) = (
    // rust: session.writer.clone(),
    // rust: session.configuring.clone(),
    // rust: session.recorder.clone(),
    // rust: );
    // rust: let thread = std::thread::spawn(move || {
    // rust: receive_play(
    // rust: &mut reader,
    // rust: &thread_writer,
    // rust: &thread_configuring,
    // rust: &Language::new(),
    // rust: &send,
    // rust: &Cookies::default(),
    // rust: &crate::lod_net::Inbox::default(),
    // rust: Path::new("."),
    // rust: &thread_recorder,
    // rust: )
    // rust: });

    // rust: let mut server = Connection::local(server);
    // rust: let pos_pkt = play::Clientbound::PlayerPosition(play::PlayerPosition {
    // rust: teleport: 1,
    // rust: position: [100.0, 64.0, -200.0],
    // rust: delta: [0.0; 3],
    // rust: yaw: 45.0,
    // rust: pitch: 10.0,
    // rust: relatives: 0,
    // rust: });
    // rust: server.send(&pos_pkt.encode()).unwrap();

        // Disconnect ends receive_play loop
    // rust: let disc_pkt = play::Clientbound::Disconnect(cfg::Disconnect {
    // rust: reason: Tag::String("Replay tap test completed".into()),
    // rust: });
    // rust: server.send(&disc_pkt.encode()).unwrap();

    // rust: let _ = thread.join().unwrap();

    // rust: let saved_path = session.stop_recording().unwrap().unwrap();
    // rust: assert_eq!(saved_path, mcpr_path);
    // rust: assert!(!session.is_recording());
    // rust: assert!(mcpr_path.exists());

        // Verify that the recording archive contains the clientbound packets.
    // rust: let mut recording = crate::studio::McprReader::open(&mcpr_path).unwrap();
    // rust: assert_eq!(recording.total_packets(), 1);
    // rust: assert_eq!(recording.metadata.server_name, "Singleplayer World");
    // rust: assert!(recording.metadata.singleplayer);
    // rust: assert!(recording.metadata.players.is_empty());

    // rust: let packet1 = recording.next_packet().unwrap().unwrap();
    // rust: assert!(recording.next_packet().unwrap().is_none());

    // rust: let decoded1 = play::Clientbound::decode(packet1.id, &packet1.payload).unwrap();
    // rust: assert_eq!(decoded1, pos_pkt);

    // rust: let _ = std::fs::remove_dir_all(&temp_dir);
}
}
