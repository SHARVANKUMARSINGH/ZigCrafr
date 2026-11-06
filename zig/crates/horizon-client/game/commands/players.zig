//! Transpiled from Horizon Rust crate
//! Module: horizon-client_players
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Commands acting on the other players of a hosted world or a server
//! (EntitySelector.findPlayers and EntityArgument's player targets). The
//! player in place (the host's, or the guest whose turn it is) is
//! `Target::Player`; every other guest is `Target::Guest`, found by name,
//! UUID or selector, and what a command does to them runs with their state
//! swapped in (`for_player`), as their own turn, what it tells them going to
//! their chat.
// use super::{Game, Target};
// use horizon_client::{command::args::Selector, lan::guest::Guest, text::Text};
// use horizon_protocol::packets::play::{self, Clientbound as C};

    // rust: impl Target {
    /// A player, in place or not (`instanceof ServerPlayer`).
    // rust: pub(in crate::game) fn is_player(self) -> bool {
    // rust: matches!(self, Target::Player | Target::Guest(_))
}
}

/// GameType.getName for a guest's game mode id.
pub fn mode_name(id: i32) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match id {
    // rust: 1 => "creative",
    // rust: 2 => "adventure",
    // rust: 3 => "spectator",
    // rust: _ => "survival",
}
}

    // rust: impl Game<'_> {
    /// The guest `conn`, while the hub is in `self.lan`.
    // rust: pub(in crate::game) fn command_guest(&self, conn: u32) -> Option<&Guest> {
    // rust: self.lan.as_ref()?.hub.guest(conn)
}

    /// `PlayerList.getPlayers` but the player in place: the guests who
    /// joined the world.
pub fn command_players(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let acting = self.lan_acting;
    // rust: self.lan
    // rust: .iter()
    // rust: .flat_map(|h| h.hub.guests.iter())
    // rust: .filter(move |g| g.placed && Some(g.conn) != acting)
}

    /// The entity the command runs as (`CommandSourceStack.getEntity`): a
    /// command typed by the player in place runs as them, the server
    /// console's as nobody.
    // rust: pub(in crate::game) fn source_entity(&self) -> Option<Target> {
    // rust: match self.command_source {
    // rust: Some(s) => s.entity,
    // rust: None => self.player.is_some().then_some(Target::Player),
}
}

    /// `CommandSourceStack.getPlayerOrException` for the commands whose
    /// player argument is optional: the source's player (the player in
    /// place when it has none, as before).
    // rust: pub(in crate::game) fn implied_player(&self) -> Target {
    // rust: self.source_entity()
    // rust: .filter(|t| t.is_player())
    // rust: .unwrap_or(Target::Player)
}

    /// `PlayerList.getPlayerByName`: names are not case sensitive. Horizon:
    /// on a server where a mod gave players nicknames
    /// (`native_set_nickname`), a name no player has finds the player going
    /// by it, without its `~` or with it (quoted), so `/msg` and `/tell`
    /// reach a player by the name chat shows. No nickname, no change.
    // rust: pub(super) fn player_named(&self, name: &str) -> Option<Target> {
    // rust: if self.player.is_some() && name.eq_ignore_ascii_case(self.acting_player_name()) {
    // rust: return Some(Target::Player);
}
    // rust: self.command_players()
    // rust: .find(|g| g.name.eq_ignore_ascii_case(name))
    // rust: .map(|g| Target::Guest(g.conn))
    // rust: .or_else(|| self.player_nicknamed(name))
}

    /// The player whose nickname is `name` (any case, a leading `~` either
    /// side ignored).
pub fn player_nicknamed(self: *Self, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let bare = |s: &str| s.strip_prefix('~').unwrap_or(s).to_ascii_lowercase();
    // rust: let wanted = bare(name);
    // rust: let hub = &self.lan.as_ref()?.hub;
    // rust: let uuid = hub
    // rust: .nicknames
    // rust: .iter()
    // rust: .find(|(_, nick)| bare(nick) == wanted)?
    // rust: .0;
    // rust: self.target_by_uuid(*uuid)
}

    /// `EntitySelector.findEntities` with a UUID: the player with it, else
    /// the entity.
    // rust: pub(in crate::game) fn target_by_uuid(&self, uuid: u128) -> Option<Target> {
    // rust: let own = self.lan_acting_uuid.or_else(|| {
    // rust: self.level.player_uuid.map(|[a, b, c, d]| {
    // rust: (u128::from(a as u32) << 96)
    // rust: | (u128::from(b as u32) << 64)
    // rust: | (u128::from(c as u32) << 32)
    // rust: | u128::from(d as u32)
    // rust: })
    // rust: });
    // rust: if self.player.is_some() && own == Some(uuid) {
    // rust: return Some(Target::Player);
}
    // rust: if let Some(g) = self.command_players().find(|g| g.uuid == uuid) {
    // rust: return Some(Target::Guest(g.conn));
}
    // rust: let words = [96, 64, 32, 0].map(|shift| (uuid >> shift) as u32 as i32);
    // rust: self.target_with_uuid(words)
}

    /// The guests a selector looks at, in join order (`PlayerList.getPlayers`),
    /// the one in place as `Target::Player`: all of them, or those in the
    /// source's level when it limits the search to a place
    /// (`isWorldLimited`); `@e` and `@n` skip the dead (`Entity::isAlive`).
    // rust: pub(super) fn player_candidates(&self, s: &Selector) -> Vec<Target> {
    // rust: let limited = s.distance.is_some()
    // rust: || s.pos.iter().any(Option::is_some)
    // rust: || s.delta.iter().any(Option::is_some);
    // rust: let alive = matches!(s.kind, 'e' | 'n');
    // rust: let here = self.dim.id();
    // rust: let in_place = self.lan_acting.filter(|_| self.player.is_some());
    // rust: self.lan
    // rust: .iter()
    // rust: .flat_map(|h| h.hub.guests.iter())
    // rust: .filter(|g| g.placed)
    // rust: .filter(|g| !limited || g.dimension == here || Some(g.conn) == in_place)
    // rust: .filter(|g| !alive || (!g.dead && g.health > 0.0))
    // rust: .map(|g| {
    // rust: if Some(g.conn) == in_place {
    // rust: Target::Player
    // rust: } else {
    // rust: Target::Guest(g.conn)
}
    // rust: })
    // rust: .collect()
}

    /// A guest's experience level and game mode, for `level=` and `gamemode=`.
    // rust: pub(super) fn guest_level_and_mode(&self, conn: u32) -> Option<(i32, &'static str)> {
    // rust: self.command_guest(conn)
    // rust: .map(|g| (g.xp_level, mode_name(g.game_mode)))
}

    /// `Player.getDisplayName`: the name as its team shows it, suggesting a
    /// `/tell`, showing the player on hover, inserting the name.
    // rust: pub(in crate::game) fn player_text(&self, name: &str, uuid: u128) -> Text {
    // rust: let shown = match self.score.board.players_team(name) {
    // rust: Some(team) => team.formatted_name(Text::literal(name)),
    // rust: None => Text::literal(name),
}
    // rust: shown.with_component_fields(vec![
    // rust: (
    // rust: "click_event".into(),
    // rust: serde_json::json!({"action": "suggest_command", "command": format!("/tell {name} ")}),
    // rust: ),
    // rust: (
    // rust: "hover_event".into(),
    // rust: serde_json::json!({"action": "show_entity", "id": "minecraft:player",
    // rust: "uuid": horizon_protocol::crypto::uuid_string(uuid), "name": name}),
    // rust: ),
    // rust: ("insertion".into(), name.into()),
    // rust: ])
}

    /// Run `f` for the player `t` (None for anything else): in place, or
    /// with the guest's state swapped in, in their level, as their own turn.
    /// What `f` tells the player (`system_message`) goes to their chat; the
    /// command's own feedback is the caller's to send.
    // rust: pub(in crate::game) fn for_player<T>(
    // rust: &mut self,
    // rust: t: Target,
    // rust: f: impl FnOnce(&mut Self) -> T,
    // rust: ) -> Option<T> {
    // rust: let conn = match t {
    // rust: Target::Player => return Some(f(self)),
    // rust: Target::Guest(conn) if self.lan_acting == Some(conn) => return Some(f(self)),
    // rust: Target::Guest(conn) => conn,
    // rust: _ => return None,
}
    // rust: let mut host = self.lan.take()?;
    // rust: let back = self.dim;
    // rust: let theirs = host
    // rust: .hub
    // rust: .guest(conn)
    // rust: .map(|g| super::super::Dim::from_id(&g.dimension));
    // rust: if let Some(dim) = theirs.filter(|d| *d != back)
    // rust: && let Err(e) = self.enter_level(Some(&mut host), dim)
    // rust: {
    // rust: log::error!("could not open {}: {e}", dim.id());
}
    // rust: let Some(swap) = self.enter_guest(&mut host, conn, back) else {
    // rust: if self.dim != back
    // rust: && let Err(e) = self.enter_level(Some(&mut host), back)
    // rust: {
    // rust: log::error!("could not reopen {}: {e}", back.id());
}
    // rust: self.lan = Some(host);
    // rust: return None;
}
    // rust: self.lan = Some(host);
    // rust: let source = self.chat_capture.replace(Vec::new());
    // rust: let out = f(self);
    // rust: let told = std::mem::replace(&mut self.chat_capture, source).unwrap_or_default();
    // rust: let mut host = self
    // rust: .lan
    // rust: .take()
    // rust: .expect("the hub is back after a player's turn");
    // rust: self.leave_guest(&mut host, swap);
    // rust: for line in told {
    // rust: host.hub.send_to(
    // rust: conn,
    // rust: &C::SystemChat(play::SystemChat {
    // rust: content: horizon_client::lan::data::component_nbt(&line.component()),
    // rust: overlay: false,
    // rust: }),
    // rust: );
}
    // rust: if self.dim != back
    // rust: && let Err(e) = self.enter_level(Some(&mut host), back)
    // rust: {
    // rust: log::error!("could not reopen {}: {e}", back.id());
}
    // rust: self.lan = Some(host);
    // rust: Some(out)
}
}
