//! Transpiled from Horizon Rust crate
//! Module: horizon-client_building_players
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Player candidates for EntityGetter.isUnobstructed while a guest owns the
//! game body. Identity keeps borrowed ancestor bodies distinct from hub copies.
// use super::Dim;
// use horizon_core::geometry::Aabb;

    // rust: pub(super) struct BuildingPlayer {
    // rust: pub(super) conn: Option<u32>,
    // rust: pub(super) dimension: Dim,
    // rust: pub(super) bounds: Option<Aabb>,
    // rust: pub(super) borrowed: bool,
}

    // rust: pub(super) struct BuildingPlayers(Vec<BuildingPlayer>);

    // rust: impl BuildingPlayers {
    /// Refresh hub-owned bodies, preserve live ancestor bodies held outside
    /// the hub, and omit the actor (GameLevel.player_box supplies that body).
    // rust: pub(super) fn for_turn(
    // rust: &self,
    // rust: actor: u32,
    // rust: outer: Option<BuildingPlayer>,
    // rust: current: Vec<BuildingPlayer>,
    // rust: ) -> Self {
        // The borrowed ancestors are the few nested turns (usually none or
        // one): only they are searched, so a turn costs O(players), not
        // O(players²), every guest's turn of every tick.
    // rust: let mut players: Vec<_> = self
    // rust: .0
    // rust: .iter()
    // rust: .copied()
    // rust: .filter(|p| {
    // rust: p.borrowed
    // rust: && p.conn != Some(actor)
    // rust: && (p.conn.is_none() || current.iter().any(|g| g.conn == p.conn))
    // rust: })
    // rust: .collect();
    // rust: if let Some(outer) = outer {
    // rust: players.retain(|p| p.conn != outer.conn);
    // rust: if outer.conn != Some(actor)
    // rust: && (outer.conn.is_none() || current.iter().any(|g| g.conn == outer.conn))
    // rust: {
    // rust: players.push(outer);
}
}
    // rust: let ancestors = players.len();
    // rust: players.reserve(current.len());
    // rust: for player in current {
            // Hub conns are unique, so only the ancestors can already hold one.
    // rust: if player.conn != Some(actor)
    // rust: && !players[..ancestors].iter().any(|p| p.conn == player.conn)
    // rust: {
    // rust: players.push(player);
}
}
    // rust: Self(players)
}

    // rust: pub(super) fn boxes(&self, dimension: Dim) -> Vec<([f64; 3], [f64; 3])> {
    // rust: self.0
    // rust: .iter()
    // rust: .filter(|p| p.dimension == dimension)
    // rust: .filter_map(|p| p.bounds)
    // rust: .map(|bounds| {
    // rust: (
    // rust: bounds.min_position().components(),
    // rust: bounds.max_position().components(),
    // rust: )
    // rust: })
    // rust: .collect()
}
}

    // rust: mod tests {
//     use super::*;
//     use horizon_core::geometry::Vec3;

pub fn player(conn: ?u32, x: f64, dimension: Dim, borrowed: bool) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: BuildingPlayer {
    // rust: conn,
    // rust: dimension,
    // rust: borrowed,
    // rust: bounds: Some(Aabb::new(
    // rust: Vec3::new(x, 0.0, 0.0),
    // rust: Vec3::new(x + 0.6, 1.8, 0.6),
    // rust: )),
}
}
pub fn xs(players: *BuildingPlayers, dim: Dim) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: players.boxes(dim).iter().map(|(lo, _)| lo[0]).collect()
}

pub fn nested_turns_preserve_host_and_live_ancestors_without_the_new_actor() void {
}
    // rust: let hub = || {
    // rust: vec![
    // rust: player(Some(1), 10.0, Dim::Overworld, false),
    // rust: player(Some(2), 20.0, Dim::Overworld, false),
    // rust: player(Some(3), 30.0, Dim::Nether, false),
    // rust: ]
}
    // rust: let host = player(None, 0.0, Dim::Overworld, true);
    // rust: let first = BuildingPlayers::default().for_turn(1, Some(host), hub());
    // rust: let second = first.for_turn(2, Some(player(Some(1), 11.0, Dim::Overworld, true)), hub());
    // rust: assert_eq!(xs(&second, Dim::Overworld), [0.0, 11.0]);
        // A further turn in another level keeps each ancestor's own level.
    // rust: let third = second.for_turn(3, Some(player(Some(2), 21.0, Dim::Nether, true)), hub());
    // rust: assert_eq!(xs(&third, Dim::Overworld), [0.0, 11.0]);
    // rust: assert_eq!(xs(&third, Dim::Nether), [21.0]);
}

pub fn returning_inner_turn_refreshes_moved_and_inactive_hub_bodies() void {
}
    // rust: let host = player(None, 0.0, Dim::Overworld, true);
    // rust: let first = BuildingPlayers::default().for_turn(
    // rust: 1,
    // rust: Some(host),
    // rust: vec![
    // rust: player(Some(1), 10.0, Dim::Overworld, false),
    // rust: player(Some(2), 20.0, Dim::Overworld, false),
    // rust: ],
    // rust: );
        // Restore the first turn after player 2 moved across dimensions.
    // rust: let restored = first.for_turn(
    // rust: 1,
    // rust: None,
    // rust: vec![
    // rust: player(Some(1), 10.0, Dim::Overworld, false),
    // rust: player(Some(2), 25.0, Dim::Nether, false),
    // rust: ],
    // rust: );
    // rust: assert_eq!(xs(&restored, Dim::Overworld), [0.0]);
    // rust: assert_eq!(xs(&restored, Dim::Nether), [25.0]);
        // Death, spectator mode, and unloaded bodies provide no building box.
    // rust: let mut inactive = player(Some(2), 25.0, Dim::Nether, false);
    // rust: inactive.bounds = None;
    // rust: let restored = restored.for_turn(1, None, vec![inactive]);
    // rust: assert_eq!(xs(&restored, Dim::Overworld), [0.0]);
    // rust: assert!(xs(&restored, Dim::Nether).is_empty());
}

pub fn disconnected_ancestors_and_inactive_outer_bodies_do_not_linger() void {
}
    // rust: let first = BuildingPlayers::default().for_turn(
    // rust: 2,
    // rust: Some(player(Some(1), 10.0, Dim::Overworld, true)),
    // rust: vec![player(Some(1), 1.0, Dim::Overworld, false)],
    // rust: );
    // rust: let disconnected = first.for_turn(3, None, Vec::new());
    // rust: assert!(xs(&disconnected, Dim::Overworld).is_empty());
    // rust: let disconnected_outer = first.for_turn(
    // rust: 3,
    // rust: Some(player(Some(1), 11.0, Dim::Overworld, true)),
    // rust: Vec::new(),
    // rust: );
    // rust: assert!(xs(&disconnected_outer, Dim::Overworld).is_empty());
    // rust: let mut outer = player(None, 0.0, Dim::Overworld, true);
    // rust: let first = BuildingPlayers::default().for_turn(1, Some(outer), Vec::new());
    // rust: outer.bounds = None;
    // rust: let second = first.for_turn(2, Some(outer), Vec::new());
    // rust: assert!(xs(&second, Dim::Overworld).is_empty());
}

pub fn for_player_keeps_the_outer_body_in_its_original_dimension() void {
}
//         use crate::game::{Audio, Game, Options, Progress, Settings, load_resources};
//         use horizon_client::{
    // rust: lan::{Joined, NetConfig, PlayerSender, guest::Guest, hub::HubConfig},
    // rust: motion::PlayerMotion,
}
//         use horizon_protocol::packets::configuration::ClientInformation;
//         use std::sync::{Arc, atomic::AtomicI32, mpsc};
    // rust: let root = std::path::PathBuf::from(std::env::var_os("HORIZON_TEST_RESOURCES").unwrap());
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
    // rust: &mut |_, _| unreachable!(),
    // rust: )
    // rust: .unwrap();
    // rust: let mut options = Options::parse(std::iter::empty()).unwrap().unwrap();
    // rust: options.resources = root.clone();
    // rust: options.execution_role = crate::game::execution_role::ExecutionRole::IntegratedServer;
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
    // rust: let scratch = std::env::temp_dir().join(format!(
    // rust: "horizon-building-turn-{}-{}",
    // rust: std::process::id(),
    // rust: std::time::SystemTime::now()
    // rust: .duration_since(std::time::UNIX_EPOCH)
    // rust: .unwrap()
    // rust: .as_nanos()
    // rust: ));
    // rust: std::fs::create_dir_all(&scratch).unwrap();
    // rust: game.world_root = scratch.clone();
    // rust: game.player = Some(PlayerMotion::new(game.motion, Vec3::new(10.5, 64.0, 0.5)).unwrap());
    // rust: let original = game.player.as_ref().unwrap().bounds();
    // rust: let net = NetConfig {
    // rust: announce: false,
    // rust: ..NetConfig::lan(0, "building-test".into(), 2)
}
    // rust: game.lan_host(
    // rust: super::super::lan::LanSettings {
    // rust: port: 0,
    // rust: guest_commands: true,
    // rust: force_game_mode: false,
    // rust: },
    // rust: net,
    // rust: HubConfig {
    // rust: default_game_mode: 0,
    // rust: guest_commands: true,
    // rust: force_game_mode: false,
    // rust: hardcore: false,
    // rust: view_distance: 2,
    // rust: simulation_distance: 2,
    // rust: dimension: Dim::Overworld.id().into(),
    // rust: allow_flight: false,
    // rust: seed: 0,
    // rust: max_players: 2,
    // rust: integrated: false,
    // rust: levels: Default::default(),
    // rust: },
    // rust: )
    // rust: .unwrap();
    // rust: let (tx, _rx) = mpsc::channel();
    // rust: let mut guest = Guest::new(
    // rust: Joined {
    // rust: conn: 2,
    // rust: uuid: 2,
    // rust: name: "NetherGuest".into(),
    // rust: properties: Vec::new(),
    // rust: info: ClientInformation::new(2),
    // rust: brand: "test".into(),
    // rust: sender: PlayerSender::new(tx, Arc::default()),
    // rust: latency: Arc::new(AtomicI32::new(0)),
    // rust: address: "127.0.0.1:25565".parse().unwrap(),
    // rust: expected: false,
    // rust: },
    // rust: 2,
    // rust: [20.5, 64.0, 0.5],
    // rust: 2,
    // rust: );
    // rust: guest.dimension = Dim::Nether.id().into();
    // rust: guest.placed = true;
    // rust: guest.loaded = true;
    // rust: game.lan.as_mut().unwrap().hub.guests.push(guest);
    // rust: let seen = game.for_player(super::super::commands::Target::Guest(2), |g| {
    // rust: assert_eq!(g.dim, Dim::Nether);
            // for_player already switched the level before entering the guest.
            // The host's body must not become a phantom blocker in the Nether.
    // rust: assert!(g.lan_building_boxes.boxes(Dim::Nether).is_empty());
    // rust: assert_eq!(
    // rust: g.lan_building_boxes.boxes(Dim::Overworld),
    // rust: vec![(
    // rust: original.min_position().components(),
    // rust: original.max_position().components()
    // rust: )]
    // rust: );
    // rust: g.player.as_ref().unwrap().position
    // rust: });
    // rust: assert_eq!(seen, Some(Vec3::new(20.5, 64.0, 0.5)));
    // rust: assert_eq!(game.dim, Dim::Overworld);
    // rust: assert_eq!(
    // rust: game.player.as_ref().unwrap().position,
    // rust: Vec3::new(10.5, 64.0, 0.5)
    // rust: );
    // rust: drop(game);
    // rust: assert!(scratch.starts_with(std::env::temp_dir()));
    // rust: std::fs::remove_dir_all(scratch).unwrap();
}
}
