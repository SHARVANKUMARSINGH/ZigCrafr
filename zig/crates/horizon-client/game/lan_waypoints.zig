//! Transpiled from Horizon Rust crate
//! Module: horizon-client_lan_waypoints
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The locator bar of the players on a served world (lan/waypoints.rs): what
//! each player looks like to their level's waypoint manager this tick.
// use super::{Game, lan::LanHost};
// use horizon_client::{
    // rust: items::ItemStack,
    // rust: lan::waypoints::{self, HIDING_HEADS, Icon, PLAYER_RANGE},
}

/// `waypoint_transmit_range`: hidden by crouching, invisibility or a head worn.
pub fn transmit_range(crouching: bool, invisible: bool, head: ?*ItemStack) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let hiding_head = head.is_some_and(|s| HIDING_HEADS.contains(&&*s.item));
    // rust: if crouching || invisible || hiding_head {
    // rust: 0.0
    // rust: } else {
    // rust: PLAYER_RANGE
}
}

    // rust: impl Game<'_> {
    /// The player's team and its colour, as the locator bar shows it.
pub fn waypoint_team(self: *Self, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let team = self.score.board.players_team(name)?;
    // rust: let color = team.color.as_deref().and_then(waypoints::team_rgb);
    // rust: Some((team.name.clone(), color))
}

    /// Each level's `ServerWaypointManager` ticked with the players in that
    /// level: a player who changes level leaves the old one's manager
    /// (`ServerLevel.removePlayerImmediately`: untracked for everyone there)
    /// and joins the new one's (`addDuringTeleport`).
    // rust: pub(super) fn lan_update_waypoints(&mut self, host: &mut LanHost) {
    // rust: let mut players: Vec<(&str, waypoints::Player)> = Vec::new();
    // rust: let mut respawned = Vec::new();
    // rust: for g in host.hub.guests.iter().filter(|g| g.placed) {
            // PlayerList.respawn makes a new ServerPlayer.
    // rust: if g.dead {
    // rust: host.waypoint_dead.insert(g.uuid);
    // rust: } else if host.waypoint_dead.remove(&g.uuid) {
    // rust: respawned.push(g.uuid);
}
            // Player.updatePlayerPose: the shift key crouches unless flying.
    // rust: let crouching = g.sneaking && !g.flying && !g.fall_flying && !g.sleeping;
    // rust: players.push((
    // rust: &g.dimension,
    // rust: waypoints::Player {
    // rust: uuid: g.uuid,
    // rust: conn: Some(g.conn),
    // rust: position: g.position,
    // rust: spectator: g.spectator(),
    // rust: transmit_range: transmit_range(
    // rust: crouching,
    // rust: g.effects.get("invisibility").is_some(),
    // rust: g.armor[0].as_ref(),
    // rust: ),
    // rust: receive_range: PLAYER_RANGE,
    // rust: first_tick: g.ticks == 0,
    // rust: view_distance: g.view_distance,
    // rust: team: self.waypoint_team(&g.name),
    // rust: icon: Icon::default(),
    // rust: },
    // rust: ));
}
    // rust: host.waypoint_dead
    // rust: .retain(|uuid| players.iter().any(|(_, p)| p.uuid == *uuid));
    // rust: let locator_bar = self.ui.rules.bool("locator_bar");
    // rust: let mut levels: Vec<String> = host.waypoints.keys().cloned().collect();
    // rust: for (level, _) in &players {
    // rust: if !levels.iter().any(|l| l == level) {
    // rust: levels.push((*level).to_owned());
}
}
    // rust: levels.sort();
    // rust: let mut out = Vec::new();
    // rust: for level in levels {
    // rust: let here: Vec<waypoints::Player> = players
    // rust: .iter()
    // rust: .filter(|(l, _)| *l == level)
    // rust: .map(|(_, p)| p.clone())
    // rust: .collect();
    // rust: let away: Vec<(u128, u32)> = players
    // rust: .iter()
    // rust: .filter(|(l, _)| *l != level)
    // rust: .filter_map(|(_, p)| Some((p.uuid, p.conn?)))
    // rust: .collect();
    // rust: let manager = host.waypoints.entry(level.clone()).or_default();
    // rust: out.extend(manager.tick_level(&here, &away, &respawned, locator_bar));
            // Nobody left in the level: nothing to remember there.
    // rust: if here.is_empty() {
    // rust: host.waypoints.remove(&level);
}
}
    // rust: for (conn, packet) in out {
    // rust: if let Some(g) = host.hub.guest(conn) {
    // rust: g.send(&packet);
}
}
}
}
