//! Transpiled from Horizon Rust crate
package horizon_client_players

import "core:fmt"
import "core:mem"
import "core:math"

// Players coming and going: joining (P1's world through memory, or P1's server) as a profile
// it picks (`split_profiles`), dropping out.
// use super::*;
// use horizon_client::{
    // rust: controller_notice::{Notice, NoticeId, Priority},
    // rust: gamepad::PadState,
    // rust: options_ui::Page,
}

// Whether `game` shows its profile page now.
on_profiles :: proc(game: ^Game<'_>) -> b {
    // Ported from Horizon
    return {}
}
    // rust: game.screen == crate::game::Screen::Options && game.ui.options.page() == Page::SplitProfiles
}

// An offline profile on an online-mode server: the session service knows no such player.
ONLINE_ONLY :: "horizon.splitscreen.online_only"
// An offline profile on a server outside this computer and its local network.
LOCAL_ONLY :: "horizon.splitscreen.local_only"

// A loopback, private (RFC 1918, IPv6 unique local) or link-local address: this computer or
// its local network.
local_ip :: proc(ip: std::net::IpAddr) -> b {
    // Ported from Horizon
    return {}
}
//     use std::net::IpAddr;
    // rust: match ip {
    // rust: IpAddr::V4(v4) => v4.is_loopback() || v4.is_private() || v4.is_link_local(),
    // rust: IpAddr::V6(v6) => match v6.to_ipv4_mapped() {
    // rust: Some(v4) => local_ip(IpAddr::V4(v4)),
    // rust: None => {
    // rust: let first = v6.segments()[0];
    // rust: v6.is_loopback() || first & 0xfe00 == 0xfc00 || first & 0xffc0 == 0xfe80
}
    // rust: },
}
}

// Whether the server at `address` is on this computer or its local network, where an offline
// profile may join P1 (the project's rule: everyone who plays elsewhere owns the game). It
// resolves as the guest's connection will (the SRV redirect, then every address of its host)
// and needs all of them local; a friend's invite or an address that doesn't resolve isn't.
local_server :: proc(address: string) -> b {
    // Ported from Horizon
    return {}
}
//     use std::net::ToSocketAddrs;
    // rust: if address.starts_with(horizon_client::net::FRIEND) {
    // rust: return false;
}
    // rust: let Some((host, port)) = horizon_protocol::servers::parse_address(address) else {
    // rust: return false;
}
    // rust: let (host, port) = horizon_protocol::server_redirect(&host, port);
    // rust: match (host.as_str(), port).to_socket_addrs() {
    // rust: Ok(addresses) => {
    // rust: let addresses: Vec<_> = addresses.collect();
    // rust: !addresses.is_empty() && addresses.iter().all(|a| local_ip(a.ip()))
}
    // rust: Err(_) => false,
}
}

// Why a player's game left its server, when the server said (its Disconnected or error screen).
turned_away :: proc(game: ^Game<'_>) -> O {
    // Ported from Horizon
    return {}
}
//     use horizon_client::{multiplayer::Screen, title::Mode};
    // rust: let why = match &game.title.as_ref()?.mode {
    // rust: Mode::Multiplayer(Screen::Disconnected { reason, .. }) => reason.clone(),
    // rust: Mode::Error { message, .. } => message.clone(),
    // rust: _ => return None,
}
    // An online-mode server: the other players have no Minecraft account of their own here.
    // rust: Some(if why.contains("verify username") {
    // rust: horizon_client::lang::tr("horizon.splitscreen.own_account", &[])
    // rust: } else {
    // rust: why
    // rust: })
}

// The `Game` `start` makes (~67 KB, by value) into a box, in a frame of its own that is gone
// once it is: the copies stay out of the caller's frame, deep in the event loop.
boxed :: proc(start: impl FnOnce() -> R {
    // Ported from Horizon
    return {}
}
    // rust: match start() {
    // rust: Ok(Some(game)) => Ok(Box::new(game)),
    // rust: Ok(None) => Err("the player's game did not start".into()),
    // rust: Err(e) => Err(e),
}
}

// P1's server lets a splitscreen player in (#6399: everyone who plays elsewhere owns the
// game): `account`, its launcher Microsoft session (whether that has expired), else an offline
// profile, `unavailable` when that name is a launcher account that couldn't be handed over.
// An offline profile joins only a server on this computer or its local network
// (`local`, resolved only for it) in offline mode; a Microsoft account any server while its
// session holds. The refusal is its translation key.
    // rust: fn server_gate(
    // rust: account: Option<bool>,
    // rust: unavailable: bool,
    // rust: local: impl FnOnce() -> bool,
    // rust: online: bool,
    // rust: ) -> std::result::Result<(), &'static str> {
    // rust: match account {
    // rust: Some(false) => Ok(()),
    // rust: Some(true) => Err("horizon.splitscreen.account_expired"),
    // rust: None if !local() => Err(LOCAL_ONLY),
    // rust: None if !online => Ok(()),
    // rust: None if unavailable => Err("horizon.splitscreen.account_unavailable"),
    // rust: None => Err(ONLINE_ONLY),
}
}

    // rust: impl Split<'_> {
    // The first seat free (2 to `MAX_PLAYERS`).
    // rust: pub(super) fn free_seat(&self) -> Option<usize> {
    // rust: (2..=MAX_PLAYERS).find(|n| self.guests.iter().all(|g| g.seat != *n))
}

    // The splitscreen folder in the game folder: `profiles/<name>/` holds each profile.
folder :: proc() -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(std::env::current_dir()?.join("splitscreen"))
}

    // Add a player driven by `pad`: it picks a profile first, unless `name` is given (tests).
    // rust: pub(super) fn join(&mut self, pad: Option<PadId>, name: Option<String>) -> Result<()> {
    // rust: let seat = self.free_seat().ok_or("every seat is taken")?;
        // The first other player: P1 moves to the compositor now (back with nobody joined, if
        // this one can't: `about_to_wait`).
    // rust: if self.surfaces.is_empty() {
    // rust: self.enable()?;
}
        // Until it has a profile, a scratch options file: never P1's.
    // rust: let options = Self::folder()?.join(".joining/options.txt");
    // rust: OPTIONS.set(Some(options.clone()));
    // rust: let mut settings = self.host.settings.clone();
    // rust: if pad.is_some() {
            // The Controller setting is P1's own: a player who pressed a pad to join plays
            // with it even when P1 turned controllers off, or its pad would be dead on the
            // profile screen it joins into.
    // rust: settings.controller.enabled = true;
}
    // rust: let game = self.start_guest(seat, &options, settings);
    // rust: OPTIONS.set(None);
    // rust: let mut game = game?;
    // rust: if let Some(pad) = pad {
            // The press that joined it doesn't act in its game.
    // rust: self.fresh.push(pad);
}
        // Over its title screen: Cancel leaves (`pick_profiles`).
    // rust: game.open_options_at(true, Page::SplitProfiles);
    // rust: let i = self.guests.len() + 1;
    // rust: self.guests.push(Guest {
    // rust: game,
    // rust: name: None,
    // rust: seat,
    // rust: options,
    // rust: pad,
    // rust: window: 1,
    // rust: widgets: Default::default(),
    // rust: entered: false,
    // rust: bumpers: [false; 2],
    // rust: });
    // rust: self.planned_window(i, seat);
    // rust: if let Some(name) = name {
    // rust: self.enter(i - 1, name)?;
}
    // rust: Ok(())
}

    // The names playing now: P1's and the joined players'.
taken :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: std::iter::once(self.host.options.player_name())
    // rust: .chain(self.guests.iter().filter_map(|g| g.name.clone()))
            // On a server: everyone in its player list.
    // rust: .chain(self.host.remote_online_names().unwrap_or_default())
    // rust: .collect()
}

    // Whether `name` can play in P1's world, said on the profile page before it tries: P1's
    // own world takes anyone; offline profiles require a local, offline-mode server, while
    // Microsoft accounts require a valid session.
can_join :: proc(self: ^Self, name: string) -> s {
    // Ported from Horizon
    return {}
}
    // rust: if self.taken().iter().any(|n| n.eq_ignore_ascii_case(name)) {
    // rust: return Err(format!("{name} is already playing."));
}
    // rust: let Some(address) = self.p1_server() else {
    // rust: return Ok(());
}
    // rust: let account = self
    // rust: .accounts
    // rust: .iter()
    // rust: .find(|a| a.name.eq_ignore_ascii_case(name));
    // rust: let unavailable = launcher::unavailable()
    // rust: .iter()
    // rust: .any(|a| a.eq_ignore_ascii_case(name));
    // rust: server_gate(
    // rust: account.map(|a| a.expired()),
    // rust: unavailable,
    // rust: || local_server(&address),
    // rust: self.host.online_server(),
    // rust: )
    // rust: .map_err(|key| horizon_client::lang::tr(key, &[&name]))
}

    // A server's resource packs: the others answer as P1 did (asked once, by P1). A player
    // joining after P1 answered is answered at once; one asked before waits for P1's answer.
    // rust: pub(super) fn follow_pack_answer(&mut self) {
    // rust: let Some(yes) = self.host.pack_answer() else {
    // rust: return;
}
    // rust: for i in 0..self.guests.len() {
    // rust: if !self.guests[i].game.pack_prompt_open() {
    // rust: continue;
}
    // rust: self.turn(i + 1);
    // rust: if let Err(e) = self.guests[i].game.answer_pack_prompt(yes) {
    // rust: log::warn!(
    // rust: "Horizon: splitscreen: P{}'s server packs: {e}",
    // rust: self.guests[i].seat
    // rust: );
}
}
    // rust: self.turn(0);
}

    // The profile pages just opened, filled: the list and who plays now.
    // rust: pub(super) fn sync_profiles(&mut self) {
    // rust: let taken = self.taken();
    // rust: for g in self.guests.iter_mut().filter(|g| on_profiles(&g.game)) {
    // rust: g.game.ui.options.split_profiles.taken = taken.clone();
}
    // rust: let open = |g: &Guest<'_>| on_profiles(&g.game) && !g.game.ui.options.split_profiles.filled;
    // rust: if !self.guests.iter().any(open) {
    // rust: return;
}
    // rust: let (names, accounts) = self.profile_names().unwrap_or_else(|e| {
    // rust: log::warn!("Horizon: splitscreen: the profiles: {e}");
    // rust: Default::default()
    // rust: });
    // rust: for g in self.guests.iter_mut().filter(|g| open(g)) {
    // rust: let page = &mut g.game.ui.options.split_profiles;
    // rust: page.filled = true;
    // rust: page.names = names.clone();
    // rust: if let Some(me) = g.name.as_ref().filter(|me| !names.contains(me)) {
    // rust: page.names.insert(0, me.clone());
}
    // rust: page.taken = taken.clone();
    // rust: page.accounts = accounts.clone();
    // rust: page.offline_accounts = launcher::unavailable();
    // rust: page.offline_accounts.extend(
    // rust: self.accounts
    // rust: .iter()
    // rust: .filter(|a| a.expired())
    // rust: .map(|a| a.name.clone()),
    // rust: );
    // rust: page.current = g.name.clone();
}
}

    // The launcher's other Microsoft accounts, then this instance's offline profiles.
profile_names :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let profiles = Self::folder()?.join("profiles");
    // rust: let mut offline = horizon_client::split_profiles::store::names(&profiles)?;
    // rust: let mut accounts: Vec<String> = self.accounts.iter().map(|a| a.name.clone()).collect();
    // rust: accounts.extend(launcher::unavailable());
    // rust: offline.retain(|n| !accounts.iter().any(|a| a.eq_ignore_ascii_case(n)));
    // rust: offline.sort_by_key(|n| n.to_lowercase());
    // rust: let mut names = accounts.clone();
    // rust: names.extend(offline);
    // rust: Ok((names, accounts))
}

    // Guest `i`, playing, switches to profile `name` where it plays: out of the world as its
    // old profile, in as the new one.
switch :: proc(self: ^Self, i: uint, name: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.turn(i + 1);
    // rust: let left = self.guests[i].game.leave_server(None);
    // rust: self.turn(0);
    // rust: let old = self.guests[i].name.take();
    // rust: if let (Some(server), Some(old)) = (&self.host.integrated, &old) {
    // rust: server.leave_split(old);
}
    // rust: left?;
    // rust: self.enter(i, name)
}

    // Guest `i` plays as profile `name`: its options, then into P1's world.
    // rust: pub(super) fn enter(&mut self, i: usize, name: String) -> Result<()> {
    // rust: self.can_join(&name)?;
        // The page's names are player names; a test seat's (P2) isn't one, but no name leaves
        // the profiles folder.
    // rust: if !folder_name(&name) {
    // rust: return Err(format!("{name:?} can't be a profile.").into());
}
    // rust: let profiles = Self::folder()?.join("profiles");
        // A Microsoft account signs in as itself (its own connections and skin).
    // rust: let account = self
    // rust: .accounts
    // rust: .iter()
    // rust: .find(|a| a.name.eq_ignore_ascii_case(&name))
    // rust: .cloned();
    // rust: self.guests[i].game.split_auth = account.clone();
    // rust: if account.is_none() && horizon_client::split_profiles::valid_name(&name) {
    // rust: horizon_client::split_profiles::store::restore(&profiles, &name)?;
}
    // rust: let profile = profiles.join(&name);
    // rust: let options = profile.join("options.txt");
    // rust: let mut settings = if options.exists() {
    // rust: horizon_client::settings::Settings::load(&options)
    // rust: } else {
    // rust: std::fs::create_dir_all(&profile)?;
    // rust: self.host.settings.save(&options);
    // rust: self.host.settings.clone()
}
        // P1's own world through memory (`Ok`), else P1's server over the network (`Err`).
    // rust: let via = match &self.host.integrated {
    // rust: Some(server) => Ok(server
    // rust: .join_split(&name)
    // rust: .ok_or("P1's world does not let players in")?),
    // rust: None => Err(self.p1_server().ok_or("P1 is not in a world")?),
}
    // rust: self.guests[i].options = options;
    // rust: self.turn(i + 1);
    // rust: let guest = &mut self.guests[i];
        // Its profile page closes as it goes in.
    // rust: guest.game.screen = crate::game::Screen::Playing;
    // rust: settings.extras.agent_control &= guest.game.options.control.is_some();
    // rust: guest.game.settings = settings;
    // rust: guest.game.options.player_name = Some(name.clone());
    // rust: guest.game.apply_settings();
    // rust: let joined = match via {
    // rust: Ok(pipe) => guest.game.connect_local(pipe, &name),
            // A server that refuses it (whitelist, an online-mode sign-in) disconnects it: it
            // picks again, told why (`drop_out`).
    // rust: Err(address) => guest.game.connect_server(&address, &name),
}
    // rust: self.turn(0);
    // rust: if let Err(e) = joined {
            // Let in for nothing: the world pauses again, the name is free.
    // rust: if let Some(server) = &self.host.integrated {
    // rust: server.leave_split(&name);
}
    // rust: return Err(e);
}
    // rust: self.guests[i].name = Some(name);
    // rust: self.guests[i].entered = false;
    // rust: Ok(())
}

    // Players' profile pages: a pick goes in, one that can't says why there; a forgotten
    // profile is hidden; a joining player who cancels (or closes the page) leaves.
    // rust: pub(super) fn pick_profiles(&mut self) -> bool {
    // rust: let mut changed = false;
    // rust: let mut i = 0;
    // rust: while i < self.guests.len() {
    // rust: if let Some(name) = self.guests[i]
    // rust: .game
    // rust: .ui
    // rust: .options
    // rust: .split_profiles
    // rust: .take_forgotten()
    // rust: {
    // rust: let signed_in = self
    // rust: .accounts
    // rust: .iter()
    // rust: .any(|a| a.name.eq_ignore_ascii_case(&name));
    // rust: let signed_in = signed_in
    // rust: || launcher::unavailable()
    // rust: .iter()
    // rust: .any(|a| a.eq_ignore_ascii_case(&name));
    // rust: let hidden = if signed_in
    // rust: || self.taken().iter().any(|n| n.eq_ignore_ascii_case(&name))
    // rust: {
    // rust: Err("This profile cannot be forgotten while it is playing or signed in.".into())
    // rust: } else {
    // rust: Self::folder().and_then(|f| {
    // rust: Ok(horizon_client::split_profiles::store::hide(
    // rust: &f.join("profiles"),
    // rust: &name,
    // rust: )?)
    // rust: })
}
    // rust: match hidden {
    // rust: Ok(()) => {
    // rust: for guest in &mut self.guests {
    // rust: guest.game.ui.options.split_profiles.filled = false;
}
}
    // rust: Err(e) => self.refuse(i, e.to_string()),
}
}
    // rust: let joining = self.guests[i].name.is_none();
    // rust: match self.guests[i].game.ui.options.split_profiles.take_choice() {
    // rust: Some(Some(name)) => match (|| {
    // rust: self.can_join(&name)?;
    // rust: if joining {
    // rust: self.enter(i, name)
    // rust: } else {
    // rust: self.switch(i, name)
}
    // rust: })() {
    // rust: Ok(()) => changed = true,
    // rust: Err(why) => self.refuse(i, why.to_string()),
    // rust: },
    // rust: _ if joining && !on_profiles(&self.guests[i].game) => {
    // rust: self.remove_guest(i);
    // rust: changed = true;
    // rust: continue;
}
    // rust: _ => {}
}
    // rust: i += 1;
}
    // rust: changed
}

    // Guest `i`'s pick can't play: its profile page says why (opened again if it had left the
    // world for it).
refuse :: proc(self: ^Self, i: uint, why: string) {
}
    // rust: log::warn!("Horizon: splitscreen: P{}: {why}", self.guests[i].seat);
    // rust: let game = &mut self.guests[i].game;
    // rust: if !on_profiles(game) {
    // rust: game.open_options_at(true, Page::SplitProfiles);
}
    // rust: game.ui.options.split_profiles.refused = Some(why);
}

    // A new player's game in its seat. Boxed as it comes out of `start_game`, and never
    // inlined: a `Game` is ~67 KB, and copies of it in the event loop's frames overflowed
    // Windows' 1 MB main stack.
    // rust: fn start_guest(
    // rust: &mut self,
    // rust: seat: usize,
    // rust: options_file: &Path,
    // rust: settings: horizon_client::settings::Settings,
    // rust: ) -> Result<Box<Game<'static>>> {
        // The players' games borrow P1's resources for the process's lifetime: one copy for all.
    // rust: if self.res.is_none() {
    // rust: self.res = Some(Box::leak(Box::new(self.host.res.clone())));
}
    // rust: let res = self.res.ok_or("no resources")?;
    // rust: let host = &mut self.host;
    // rust: std::fs::create_dir_all(options_file.parent().ok_or("bad options path")?)?;
    // rust: let mut options = host.options.clone();
    // rust: options.world = None;
    // rust: options.server = None;
        // P1's frame-limited test runs end the process; a player's game doesn't.
    // rust: options.frames = None;
    // rust: options.world_frames = None;
    // rust: options.split_guest = true;
    // rust: options.offscreen = true;
    // rust: options.paced_by_split = true;
        // P1's socket (`--control` or Agent Control) + the seat: every game in this process
        // would otherwise take the one default endpoint, P1's.
    // rust: options.control = host.control.as_ref().map(|c| {
    // rust: let mut p = c.path().as_os_str().to_owned();
    // rust: p.push(seat.to_string());
    // rust: p.into()
    // rust: });
    // rust: let mut settings = settings;
    // rust: settings.extras.agent_control &= options.control.is_some();
        // `options.resources` is P1's overlay when a pack is on: never the vanilla root, as a
        // reload would rebuild that overlay out of itself.
    // rust: let vanilla_root = host.vanilla_root();
    // rust: let gui = UiResources::load(&options.resources, &vanilla_root)?;
        // P1's output, heard from this player's camera too (`Audio::share`).
    // rust: let audio = host.audio.share(seat as u8);
    // rust: let window = host.window.clone().ok_or("no window")?;
    // rust: let pack = host.pack.clone();
    // rust: let mut guest = boxed(|| {
    // rust: start_game(
    // rust: res,
    // rust: pack,
    // rust: gui,
    // rust: options,
    // rust: None,
    // rust: audio,
    // rust: vanilla_root,
    // rust: Instant::now(),
    // rust: None,
    // rust: Some(settings),
    // rust: None,
    // rust: )
    // rust: })?;
    // rust: guest.renderer = Some(build_renderer(
    // rust: window.clone(),
    // rust: true,
    // rust: &guest.pack,
    // rust: &guest.gui,
    // rust: host.renderer.as_ref(),
    // rust: None,
    // rust: host.settings.horizon.api,
    // rust: host.settings.horizon.translucent_batching,
    // rust: host.settings.horizon.wide_frame(),
            // The pack its own game loads, from its profile.
    // rust: crate::game::shader_packs::picked_pack_draws_flat(&guest.settings),
    // rust: (
    // rust: guest.settings.file.int("textureFiltering"),
    // rust: guest.settings.file.int("maxAnisotropyBit"),
    // rust: ),
    // rust: )?);
    // rust: guest.window = Some(window);
    // rust: guest.world_renderer_ready = true;
    // rust: guest.keyboard_mouse = false;
    // rust: guest.split_window = host.split_window;
    // rust: guest.apply_settings();
        // Its pad comes from the split (`route_pads`): it never opens the controllers itself.
    // rust: guest.pad.feed = Some(PadState::default());
    // rust: guest.ui.options.split_guest = true;
    // rust: Ok(guest)
}

    // Players who disconnected drop out; all of them once P1 has left its world. One the
    // server turned away as it came in picks again, told why; one it sent away later (a kick)
    // leaves, and P1 hears why. Whether any left.
    // rust: pub(super) fn drop_out(&mut self) -> bool {
        // Out of its world: on the title screen, or neither on its server thread nor a server's.
    // rust: let p1_left = self.host.title.is_some()
    // rust: || (self.host.integrated.is_none() && self.host.remote.is_none());
    // rust: let before = self.guests.len();
    // rust: if p1_left {
    // rust: self.host.split_hud.notice.clear();
}
    // rust: for k in (0..self.guests.len()).rev() {
    // rust: let g = &mut self.guests[k];
    // rust: g.entered |= g.game.remote.is_some() && g.game.player.is_some();
            // In the world: a pad P1 gave up is this player's for good.
    // rust: if g.entered
    // rust: && let Some(id) = g.pad
    // rust: {
    // rust: self.p1_pad.joined(id);
}
    // rust: let g = &self.guests[k];
            // A player picking a profile has no connection yet.
    // rust: let playing = g.name.is_none() || g.game.remote.is_some();
    // rust: let why = (!p1_left && g.game.error.is_none() && !playing)
    // rust: .then(|| turned_away(&g.game))
    // rust: .flatten();
    // rust: if let (true, Some(name), Some(why)) = (g.entered, &g.name, &why) {
    // rust: self.host.split_hud.notice.raise(Notice::new(
    // rust: NoticeId::PlayerLeft,
    // rust: Priority::Attention,
    // rust: format!("{name} could not stay"),
    // rust: why.clone(),
    // rust: ));
    // rust: } else if let Some(why) = why {
    // rust: let old = self.guests[k].name.take();
    // rust: if let (Some(server), Some(old)) = (&self.host.integrated, &old) {
    // rust: server.leave_split(old);
}
    // rust: self.refuse(k, why);
    // rust: continue;
}
    // rust: if p1_left || !playing || g.game.error.is_some() {
    // rust: self.remove_guest(k);
}
}
    // rust: self.guests.len() != before
}

    // Guest `k` (player `k + 1`) leaves: keyboard and mouse stay with whoever had them (P1 if
    // it was this one), and the server forgets the name (the world may pause again).
    // rust: pub(super) fn remove_guest(&mut self, k: usize) {
        // Its turn's buttons and options go back to their owners before the order shifts.
    // rust: self.turn(0);
    // rust: if self.focus == k + 1 {
    // rust: self.handoff(0);
    // rust: self.turn(0);
}
    // rust: let guest = self.guests.remove(k);
        // Gone before it got into the world: a pad P1 gave up goes back to P1.
    // rust: if !guest.entered
    // rust: && let Some(id) = guest.pad
    // rust: {
    // rust: self.restore_given_up_pad(id);
}
    // rust: if self.focus > k + 1 {
    // rust: self.focus -= 1;
}
    // rust: if let (Some(server), Some(name)) = (&self.host.integrated, &guest.name) {
    // rust: server.leave_split(name);
}
}
}

// A name that stays one folder inside `profiles`.
folder_name :: proc(name: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !name.is_empty() && name != "." && !name.contains(['/', '\\']) && !name.contains("..")
}

    // rust: mod tests {
//     use super::{LOCAL_ONLY, ONLINE_ONLY, folder_name, local_server, server_gate};

a_profile_name_never_leaves_the_profiles_folder :: proc() {
}
    // rust: assert!(folder_name("P2") && folder_name("Steve"));
    // rust: for bad in ["", ".", "..", "../x", "a/b", "a\\b"] {
    // rust: assert!(!folder_name(bad), "{bad:?}");
}
}

offline_guests_join_only_local_servers :: proc() {
}
    // rust: for local in [
    // rust: "127.0.0.1:25565",
    // rust: "localhost:25570",
    // rust: "192.168.1.20",
    // rust: "10.0.0.5:25566",
    // rust: "172.20.1.2",
    // rust: "169.254.3.4",
    // rust: "[::1]:25565",
    // rust: "[fd12:3456::1]:25565",
    // rust: "[fe80::1]:25565",
    // rust: ] {
    // rust: assert!(local_server(local), "{local} is local");
}
    // rust: for elsewhere in [
    // rust: "8.8.8.8:25565",
    // rust: "172.32.0.1",
    // rust: "[2001:db8::1]:25565",
    // rust: "[::ffff:1.1.1.1]:25565",
    // rust: "friend:K7QM-3XPD",
    // rust: "",
    // rust: ] {
    // rust: assert!(!local_server(elsewhere), "{elsewhere} is not local");
}
}

only_a_microsoft_session_lifts_the_local_server_rule :: proc() {
}
EXPIRED :: "horizon.splitscreen.account_expired"
UNAVAILABLE :: "horizon.splitscreen.account_unavailable"
        // (account: None offline, Some(expired)), unavailable, local, online => the answer.
    // rust: let cases: [(Option<bool>, bool, bool, bool, Result<(), &str>); 11] = [
            // An offline profile: home-network offline-mode servers only.
    // rust: (None, false, true, false, Ok(())),
    // rust: (None, false, false, false, Err(LOCAL_ONLY)),
    // rust: (None, false, false, true, Err(LOCAL_ONLY)),
    // rust: (None, false, true, true, Err(ONLINE_ONLY)),
            // A launcher account that couldn't be handed over plays as an offline profile.
    // rust: (None, true, false, false, Err(LOCAL_ONLY)),
    // rust: (None, true, true, true, Err(UNAVAILABLE)),
    // rust: (None, true, true, false, Ok(())),
            // Its own Microsoft session: any server, while it holds.
    // rust: (Some(false), false, false, false, Ok(())),
    // rust: (Some(false), false, false, true, Ok(())),
    // rust: (Some(true), false, false, true, Err(EXPIRED)),
    // rust: (Some(true), false, true, false, Err(EXPIRED)),
    // rust: ];
    // rust: for (account, unavailable, local, online, want) in cases {
    // rust: assert_eq!(
    // rust: server_gate(account, unavailable, || local, online),
    // rust: want,
    // rust: "{account:?} unavailable={unavailable} local={local} online={online}"
    // rust: );
}
        // A Microsoft session never needs the address resolved.
    // rust: assert_eq!(
    // rust: server_gate(Some(false), false, || unreachable!(), true),
    // rust: Ok(())
    // rust: );
}
}
