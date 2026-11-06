//! Transpiled from Horizon Rust crate
//! Module: horizon-client_prediction
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The movement prediction's replay on the server (`lan::prediction`): each guest's client ticks
//! played again with the client's own movement code, in the guest's level.
// use super::Game;
// use super::lan::LanHost;
// use horizon_client::lan::entity::EntityState;
// use horizon_client::lan::guest::Guest;
// use horizon_client::lan::prediction::{Replay, near, slack};
// use horizon_client::motion::{MotionWorld, PlayerMotion};
// use horizon_client::world::World;

    // rust: impl Game<'_> {
    /// Guest `conn`'s client ticks since the server's last tick, played again, before the server
    /// moves the guest's own body.
    // rust: pub(super) fn guest_replay(&mut self, host: &mut LanHost, conn: u32) {
    // rust: if !host.hub.recording() {
    // rust: return;
}
    // rust: let tolerance = host
    // rust: .hub
    // rust: .anticheat
    // rust: .as_deref()
    // rust: .map_or(f64::INFINITY, |ac| ac.config.prediction.tolerance);
        // The item the guest is using (eating, a bow, a shield): its client moves at the item's
        // `use_effects` speed (ItemUseModifier, 0.2 for most), and may not sprint. The server's copy
        // of a guest doesn't follow it (Game.sync_player_body is the window's player's), so the
        // replay walked a guest eating at full speed: 0.173 blocks a tick off, the live log's most
        // common flag.
    // rust: let item_use = host
    // rust: .play
    // rust: .get(&conn)
    // rust: .and_then(|play| play.using())
    // rust: .and_then(|(slot, _)| {
    // rust: let g = host.hub.guest(conn)?;
    // rust: let stack = if slot == super::shield::OFFHAND_SLOT {
    // rust: g.offhand.as_ref()
    // rust: } else {
    // rust: g.inventory.get(slot)?.as_ref()
    // rust: }?;
    // rust: self.res.items().get(&stack.item)
    // rust: })
    // rust: .map(|item| (item.use_speed, !item.can_sprint));
    // rust: let Some(g) = host.hub.guest_mut(conn) else {
    // rust: return;
}
        // What moves the player isn't its own movement (a vehicle, a bed), or the server holds it:
        // the replay starts again at the teleport that ends it (dismountTo, stopSleeping, respawn).
    // rust: let held =
    // rust: g.vehicle.is_some() || g.sleeping || g.dead || g.spectator() || !g.client_loaded();
        // A teleport not yet accepted (a setback): the client still moves on its own until it
        // hears it, and the replay follows, but nothing counts.
    // rust: let waiting = g.awaiting_teleport.is_some();
        // The server's copy of a guest doesn't follow its armor (Game.glider_worn).
    // rust: let hand = |stack: Option<&horizon_client::items::ItemStack>, slot: &str| {
    // rust: stack.is_some_and(|s| {
    // rust: horizon_client::item_sync::can_glide_using(s, slot, self.res.items())
    // rust: })
}
    // rust: let glider = super::gliding_pieces(self.res.items(), &g.armor).contains(&true)
    // rust: || hand(
    // rust: g.inventory.get(g.selected).and_then(Option::as_ref),
    // rust: "mainhand",
    // rust: )
    // rust: || hand(g.offhand.as_ref(), "offhand");
    // rust: if let Some(motion) = g.motion.as_deref_mut() {
    // rust: motion.glider = glider;
    // rust: motion.item_use_speed = item_use.map(|(speed, _)| speed);
    // rust: motion.item_use_slows_sprint = item_use.is_some_and(|(_, slows)| slows);
}
    // rust: let (Some(record), Some(server)) = (g.anticheat.record.as_deref_mut(), g.motion.as_deref())
    // rust: else {
    // rust: return;
}
    // rust: let mut run = |body: &mut PlayerMotion, keys, sprinting| {
            // Game.sync_player_body's part that depends on the blocks.
    // rust: body.nudge = super::closest_space_nudge(body, &self.world, self.res.facts());
    // rust: MotionWorld {
    // rust: entities: &[],
    // rust: player: body,
    // rust: scene: &mut self.world,
    // rust: assets: &self.pack.assets,
    // rust: collision_binding: self.collision,
    // rust: resources: self.motion,
    // rust: health: &self.health_resources,
}
    // rust: .replayed_tick(keys, sprinting)
}
    // rust: if let Some(restart) = record.take_restart() {
            // What the client keeps through a teleport (its jump delay, a glide...) is the last
            // replay's, once it has played the ticks before it. The client's motion through the
            // teleport is its own (an End gateway's), and a replay that was excused when the teleport
            // came may be off in what it can't see: either way the replay finds the client again.
    // rust: let mut excused = restart.kept_motion;
    // rust: let mut replay = g
    // rust: .replay
    // rust: .take()
    // rust: .and_then(|mut replay| {
    // rust: let finished = replay.finish(record, server, &restart, &mut run);
    // rust: excused |= replay.excused();
    // rust: finished.then_some(replay)
    // rust: })
    // rust: .unwrap_or_else(|| Box::new(Replay::new(server, &restart)));
    // rust: replay.restart(&restart);
    // rust: if excused {
    // rust: replay.excuse();
}
    // rust: g.replay = Some(replay);
}
    // rust: if held {
    // rust: g.replay = None;
    // rust: return;
}
    // rust: let Some(replay) = g.replay.as_deref_mut() else {
    // rust: return;
}
        // Ticks no longer kept (a server that stalled for seconds): wait for the next teleport.
    // rust: let Some(over) = replay.catch_up(record, server, tolerance, &mut run) else {
    // rust: g.replay = None;
    // rust: return;
}
    // rust: if over.ticks == 0 || waiting {
    // rust: return;
}
    // rust: let g = host.hub.guest(conn).expect("found above");
        // A client that hasn't said it loaded the level is still on its loading screen, where it
        // doesn't move (the server stopped waiting for it after 60 ticks): the replay falls or drifts
        // where it stands. Its first move counts as any other.
    // rust: let loading = g.loading && !over.moved;
    // rust: if loading || excused(g, &self.world, host.states.as_slice(), &host.hub.guests) {
    // rust: if let Some(replay) = host
    // rust: .hub
    // rust: .guest_mut(conn)
    // rust: .and_then(|g| g.replay.as_deref_mut())
    // rust: {
    // rust: replay.excuse();
}
    // rust: return;
}
    // rust: let agreed = g.replay.as_deref().expect("played above").agreed();
    // rust: for event in host.hub.anticheat_prediction(conn, &over, agreed) {
    // rust: self.lan_log_event(event);
}
}
}

/// Whether guest `g`'s last moves may be off for a reason the replay can't play yet: an entity near
/// it (a push, a boat or shulker to stand on, a firework it flies with); a block change near it the
/// server hasn't sent yet (one sent but unseen, or an entity gone that the client may still have, the
/// replay excuses itself); a moving piston; a chunk around it the client doesn't have; a riptide
/// launch (the trident's push is the client's own).
pub fn excused(g: *Guest, world: *World, entities: *[EntityState], guests: *[Guest]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let at = g.position;
    // rust: let slack = slack(std::array::from_fn(|i| at[i] - g.previous_position[i]));
    // rust: let close = |p: [f64; 3]| {
    // rust: let r = 3.0 + slack;
    // rust: (p[0] - at[0]).abs() <= r
    // rust: && (p[2] - at[2]).abs() <= r
    // rust: && (-3.0 - slack..=4.0 + slack).contains(&(p[1] - at[1]))
}
    // rust: let unsent = world
    // rust: .block_log
    // rust: .iter()
    // rust: .flatten()
    // rust: .chain(&world.block_log_held)
    // rust: .any(|&(x, y, z)| near(at, [x, y, z], slack));
    // rust: let pistons = world
    // rust: .moving_pistons
    // rust: .iter()
    // rust: .any(|&(p, _)| near(at, p, slack));
    // A client doesn't move in a chunk it doesn't have.
    // rust: let (cx, cz) = ((at[0].floor() as i32) >> 4, (at[2].floor() as i32) >> 4);
    // rust: let unloaded =
    // rust: (-1..=1).any(|dx| (-1..=1).any(|dz| !g.sent_chunks.contains(&(cx + dx, cz + dz))));
    // rust: let riptide = g
    // rust: .motion
    // rust: .as_deref()
    // rust: .is_some_and(|m: &PlayerMotion| m.auto_spin_attack_ticks > 0);
    // Items and experience orbs neither push nor hold anyone up; the list holds the player itself.
    // rust: let entity = entities.iter().any(|e| {
    // rust: e.id != g.entity_id
    // rust: && !matches!(
    // rust: e.kind.as_str(),
    // rust: "minecraft:item" | "minecraft:experience_orb"
    // rust: )
    // rust: && close(e.position)
    // rust: });
    // rust: let player = guests
    // rust: .iter()
    // rust: .any(|o| o.conn != g.conn && o.placed && o.dimension == g.dimension && close(o.position));
    // rust: unsent || pistons || unloaded || riptide || entity || player
}
