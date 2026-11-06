//! Transpiled from Horizon Rust crate
//! Module: horizon-client_friends
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Play with friends, host side: "Start Sharing" on the Play with Friends
//! screen (`friends_screen`, the pause menu's Friends button) opens the world to LAN if
//! it isn't (with Open to LAN's defaults) and shares that port behind an
//! invite code (horizon-friends). The code holds this computer's addresses
//! and the key, so friends join with no server of ours; a relay the player
//! configured adds a short code and a fallback. The integrated server is the
//! LAN one, unchanged: tunnelled guests are LAN guests that connect from the
//! loopback address.
// use super::{Game, lan::LanSettings};
// use horizon_client::{
    // rust: Result,
    // rust: friends_screen::{self, Action, FriendsView},
    // rust: hud::HudBatch,
    // rust: lang,
    // rust: text::Text,
}
// use horizon_friends::{Host, HostConfig, HostEvent, PathMode, host::DEFAULT_PORT, reach, stun};
// use horizon_protocol::{GAME_VERSION, PROTOCOL_VERSION};
// use std::time::{Duration, Instant};

    // rust: pub(super) struct Sharing {
    // rust: host: Host,
    /// Sharing opened the world to LAN, so stopping closes it again.
    // rust: opened_lan: bool,
    // rust: code: Option<String>,
    /// Wrong codes tried so far.
    // rust: wrong: u32,
    // rust: notice: Option<String>,
    // rust: copied: Option<Instant>,
    /// Sessions carried directly and through the relay so far.
    // rust: paths: (u32, u32),
}

    // rust: pub const HELP: &[&str] = &[
    // rust: "friends host                   share the open world behind an invite code",
    // rust: "friends stop                   stop sharing",
    // rust: "friends status                 the code, how friends reach this host, the guests",
    // rust: ];

/// `HORIZON_STUN_SERVERS`, else `friendsStun` in horizon.txt, else the defaults.
pub fn stun_servers() V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if std::env::var_os("HORIZON_STUN_SERVERS").is_some() {
    // rust: return stun::servers_from_env();
}
    // rust: let dir = std::env::current_dir().unwrap_or_default();
    // rust: match horizon_client::ui_theme::preference(&dir, "friendsStun") {
    // rust: Some(list) => stun::parse_servers(&list),
    // rust: None => stun::servers_from_env(),
}
}

pub fn env_flag(name: []const u8, default: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::env::var(name).map_or(default, |v| v != "0")
}

    // rust: impl Game<'_> {
    /// Start sharing the open world.
    // rust: pub(super) fn friends_start(&mut self) -> Result<()> {
    // rust: if self.friends.is_some() {
    // rust: return Ok(());
}
        // Single player on its server thread shares that server, as Open to
        // LAN publishes it; another server can't be shared.
    // rust: if self.title.is_some() || (self.remote.is_some() && self.integrated.is_none()) {
    // rust: return Err("open a singleplayer world first".into());
}
    // rust: let opened_lan = self.lan_port().is_none();
    // rust: if opened_lan {
            // ShareToLanScreen's defaults, as the world options screen offers them.
    // rust: self.lan_open(LanSettings {
    // rust: port: horizon_client::lan::available_port(),
    // rust: guest_commands: false,
    // rust: force_game_mode: true,
    // rust: })?;
}
    // rust: let port = self.lan_port().ok_or("the world isn't open to LAN")?;
    // rust: let host = match Host::start(HostConfig {
    // rust: lan: std::net::SocketAddr::from(([127, 0, 0, 1], port)),
    // rust: protocol: PROTOCOL_VERSION,
    // rust: game: GAME_VERSION.to_owned(),
    // rust: relay: horizon_client::net::friends_relay_setting(),
    // rust: path: PathMode::from_env(),
    // rust: port: std::env::var("HORIZON_FRIENDS_PORT")
    // rust: .ok()
    // rust: .and_then(|p| p.parse().ok())
    // rust: .unwrap_or(DEFAULT_PORT),
    // rust: reach: reach::Options {
                // HORIZON_FRIENDS_UPNP=0 leaves the router alone.
    // rust: map_port: env_flag("HORIZON_FRIENDS_UPNP", true),
    // rust: stun: stun_servers(),
                // Both ends on one machine (tests).
    // rust: loopback: env_flag("HORIZON_FRIENDS_LOOPBACK", false),
    // rust: },
    // rust: }) {
    // rust: Ok(h) => h,
    // rust: Err(e) => {
    // rust: if opened_lan {
    // rust: self.lan_close(true);
}
    // rust: return Err(e.into());
}
}
    // rust: self.friends = Some(Sharing {
    // rust: host,
    // rust: opened_lan,
    // rust: code: None,
    // rust: wrong: 0,
    // rust: notice: None,
    // rust: copied: None,
    // rust: paths: (0, 0),
    // rust: });
    // rust: Ok(())
}

    /// Stop sharing: the code ends (direct port closed, router mapping
    /// deleted); the world closes to LAN again if sharing opened it.
    // rust: pub(super) fn friends_stop(&mut self) {
    // rust: let Some(mut sharing) = self.friends.take() else {
    // rust: return;
}
    // rust: sharing.host.stop();
    // rust: if sharing.opened_lan {
    // rust: self.lan_close(true);
    // rust: } else {
    // rust: self.system_message(Text::literal(lang::get_or(
    // rust: "horizon.friends.stopped",
    // rust: "Stopped sharing the invite code.",
    // rust: )));
}
}

    /// The LAN server is closing: the code goes with it.
    // rust: pub(super) fn friends_lan_closed(&mut self) {
    // rust: if let Some(mut sharing) = self.friends.take() {
    // rust: sharing.host.stop();
}
}

    /// New codes and sessions, once a tick and while the pause menu is drawn.
    // rust: pub(super) fn tick_friends(&mut self) {
    // rust: let Some(sharing) = self.friends.as_mut() else {
    // rust: return;
}
    // rust: let mut announce = false;
    // rust: let mut stopped = None;
    // rust: for event in sharing.host.poll() {
    // rust: match event {
    // rust: HostEvent::Code(code) => {
    // rust: if sharing.code.is_some() && sharing.wrong >= horizon_friends::host::MAX_WRONG {
    // rust: sharing.notice = Some(lang::get_or(
    // rust: "horizon.friends.short_code_changed",
    // rust: "Someone kept trying a wrong short code, so it changed.",
    // rust: ));
    // rust: sharing.wrong = 0;
}
    // rust: announce = sharing.code.is_none();
    // rust: sharing.code = Some(code);
}
    // rust: HostEvent::WrongCode { count } => {
    // rust: sharing.wrong = count;
    // rust: sharing.notice = Some(lang::get_or(
    // rust: "horizon.friends.wrong_code",
    // rust: "Someone tried a wrong code.",
    // rust: ));
}
    // rust: HostEvent::Connected { direct: true, .. } => sharing.paths.0 += 1,
    // rust: HostEvent::Connected { direct: false, .. } => sharing.paths.1 += 1,
    // rust: HostEvent::Disconnected { .. } => {}
    // rust: HostEvent::RelayStopped => {
    // rust: let text = lang::get_or(
    // rust: "horizon.friends.relay_stopped",
    // rust: "Too many wrong short codes, so the relay is off until you share again. Friends can still join with the full code.",
    // rust: );
    // rust: sharing.notice = Some(text.clone());
    // rust: stopped = Some(text);
}
}
}
    // rust: if let Some(text) = stopped {
    // rust: self.system_message(Text::literal(text));
}
    // rust: if announce {
    // rust: self.system_message(Text::literal(lang::get_or(
    // rust: "horizon.friends.code_ready",
    // rust: "Your invite code is ready: Game Menu, Play with Friends. Copy it and send it to your friends.",
    // rust: )));
}
}

    // rust: pub(super) fn friends_copy(&mut self) {
    // rust: let Some(code) = self.friends.as_ref().and_then(|s| s.code.clone()) else {
    // rust: return;
}
//         use horizon_client::clipboard::Clipboard;
    // rust: self.clipboard.set(&code);
    // rust: if let Some(s) = self.friends.as_mut() {
    // rust: s.copied = Some(Instant::now());
}
}

    /// Play with Friends. The world is paused under it in singleplayer, so
    /// new codes and sessions are read while it is drawn.
    // rust: pub(super) fn draw_friends_screen(&mut self, batch: &mut HudBatch) {
    // rust: self.tick_friends();
    // rust: let view = self.friends_view();
    // rust: horizon_client::widgets::begin_screen(|| {
    // rust: horizon_client::widgets::ScreenInfo::new("friends", friends_screen::TITLE)
    // rust: });
    // rust: friends_screen::draw(batch, &self.gui.atlas, self.cursor, &view, true);
}
    // rust: pub(super) fn friends_screen_click(&mut self) {
    // rust: let view = self.friends_view();
    // rust: let Some(action) =
    // rust: friends_screen::click(&self.gui.atlas, self.gui_size(), self.cursor, &view)
    // rust: else {
    // rust: return;
}
    // rust: self.audio.play_button_click();
    // rust: match action {
    // rust: Action::Share => {
    // rust: if let Err(e) = self.friends_start() {
    // rust: self.system_message(Text::literal(
    // rust: lang::get_or(
    // rust: "horizon.friends.share_failed",
    // rust: "Couldn't share the world: %s",
    // rust: )
    // rust: .replacen("%s", &e.to_string(), 1),
    // rust: ));
}
}
    // rust: Action::Copy => self.friends_copy(),
    // rust: Action::Stop => self.friends_stop(),
            // The system browser, as the folder buttons open their folders.
    // rust: Action::Help => {
    // rust: if let Some(url) = &view.help {
    // rust: super::packs::open_uri(url);
}
}
    // rust: Action::Done => self.screen = super::Screen::Paused,
}
}

    /// What Play with Friends shows.
    // rust: pub(super) fn friends_view(&self) -> FriendsView {
    // rust: let guests = match &self.lan {
    // rust: Some(h) => h.hub.guests.iter().map(|g| g.name.clone()).collect(),
            // On the server thread: the other players the server lists.
    // rust: None if self.integrated.is_some() => {
    // rust: let me = self.options.player_name();
    // rust: let mut names = self.remote_online_names().unwrap_or_default();
    // rust: names.retain(|n| *n != me);
    // rust: names
}
    // rust: None => Vec::new(),
}
    // rust: let Some(s) = &self.friends else {
    // rust: return FriendsView {
    // rust: shown: self.remote.is_none() || self.integrated.is_some(),
    // rust: ..FriendsView::default()
}
}
    // rust: let state = s.host.state();
    // rust: let mut status = if s.code.is_none() {
    // rust: lang::get_or(
    // rust: "horizon.friends.finding_route",
    // rust: "Finding how friends can reach you…",
    // rust: )
    // rust: } else {
    // rust: state.summary.clone()
}
    // rust: if let Some(short) = &state.short {
    // rust: status.push_str(&format!(" Short code for the relay: {short}."));
}
    // rust: if let Some(problem) = &state.relay_problem {
    // rust: status.push(' ');
    // rust: status.push_str(problem);
}
    // rust: let reachable = matches!(
    // rust: state.verdict,
    // rust: Some(reach::Verdict::Mapped(_) | reach::Verdict::Public)
    // rust: ) || state.short.is_some();
    // rust: FriendsView {
    // rust: shown: true,
    // rust: sharing: true,
    // rust: code: s.code.clone(),
    // rust: status,
    // rust: reachable,
    // rust: help: (!reachable && s.code.is_some()).then(|| reach::HELP_URL.to_owned()),
    // rust: guests,
    // rust: notice: s.notice.clone(),
    // rust: copied: s
    // rust: .copied
    // rust: .is_some_and(|t| t.elapsed() < Duration::from_secs(2)),
}
}

    /// `horizon-ctl friends ...`.
    // rust: pub(super) fn friends_control(&mut self, words: &[&str]) -> Result<Option<serde_json::Value>> {
//         use serde_json::json;
    // rust: if words[0] != "friends" {
    // rust: return Ok(None);
}
    // rust: match words.get(1).copied() {
    // rust: Some("host") => {
    // rust: self.friends_start()?;
    // rust: Ok(Some(json!({ "ok": true, "lan_port": self.lan_port() })))
}
    // rust: Some("stop") => {
    // rust: self.friends_stop();
    // rust: Ok(Some(json!({ "ok": true })))
}
    // rust: Some("status") => {
    // rust: self.tick_friends();
    // rust: let view = self.friends_view();
    // rust: let state = self.friends.as_ref().map(|s| s.host.state());
    // rust: Ok(Some(json!({
    // rust: "sharing": view.sharing,
    // rust: "code": view.code,
    // rust: "short": state.as_ref().and_then(|s| s.short.as_ref().map(ToString::to_string)),
    // rust: "summary": view.status,
    // rust: "reachable": view.reachable,
    // rust: "verdict": state.as_ref().and_then(|s| s.verdict.as_ref().map(|v| format!("{v:?}"))),
    // rust: "direct_port": state.as_ref().map(|s| s.port),
    // rust: "sessions": self.friends.as_ref().map_or(0, |s| s.host.sessions()),
    // rust: "direct": self.friends.as_ref().map_or(0, |s| s.paths.0),
    // rust: "relayed": self.friends.as_ref().map_or(0, |s| s.paths.1),
    // rust: "guests": view.guests,
    // rust: "lan_port": self.lan_port(),
    // rust: })))
}
    // rust: _ => Err("friends host|stop|status".into()),
}
}
}
