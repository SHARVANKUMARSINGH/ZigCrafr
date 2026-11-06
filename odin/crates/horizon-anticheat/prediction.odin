//! Transpiled from Horizon Rust crate
package horizon_anticheat_prediction

import "core:fmt"
import "core:mem"
import "core:math"

// The movement prediction's record: each of a player's client ticks as the server heard them, so
// the server can play the tick again with vanilla's movement code and compare (docs/anticheat.md).
//
// A vanilla client ends every tick with ServerboundClientTickEndPacket, after the tick's input
// (ServerboundPlayerInputPacket, sent when the keys change) and its move (ServerboundMovePlayerPacket,
// when it moved or turned). Those packets arrive in order, so the packets between two tick ends are one
// client tick.
//
// What the server changes about the player (a push, a teleport, an effect) takes effect on the client
// when it handles the packet, which is some client ticks after the server sent it. At the end of each of
// its ticks the server sends a ClientboundPingPacket whose id is that server tick; the client answers
// with ServerboundPongPacket as soon as it handles it, before its next tick runs. A client tick knows
// the last server tick it had handled: every change of that server tick or an earlier one was in effect
// during the client tick, none of a later one.

// use std::collections::VecDeque;

// Client ticks kept: two seconds at 20 a second.
KEPT :: 40

// Server changes kept, the oldest dropped first.
CHANGES_KEPT :: 64

// Changes near the player kept until every kept tick has seen them.
NEAR_KEPT :: 1024

// Something the server sent the player that changes how its client moves. The client applies it when
// it handles the packet, before its next tick.
Change :: enum {
    // ClientboundSetEntityMotionPacket for the player itself: its new velocity, as the client
    // decodes it.
    Velocity([f64; 3]),
    // ClientboundExplodePacket's player knockback, added to the velocity.
    Knockback([f64; 3]),
    // ClientboundUpdateAttributesPacket for the player itself: the server's attributes as they
    // are when the replay reaches it, but for the movement speed's sprint modifier, which the
    // client's sprinting decides: `sprint` is whether the packet had it when it carried the
    // movement speed (the client takes the modifiers as sent, so a sprint modifier the packet
    // lacks is gone while the client sprints), None when it didn't (the client keeps its own).
    Attributes { sprint: Option<bool> },
    // ClientboundSetEntityDataPacket for the player itself with its shared flags: their sprinting
    // bit, which the client takes as sent (SynchedEntityData.assignValues sets the flag alone, its
    // speed modifier and wasSprinting stay). A client whose sprint the server cleared this way
    // starts it again in its next aiStep, which adds the modifier back, and says nothing.
    Sprinting(bool),
    // ClientboundUpdateMobEffectPacket or ClientboundRemoveMobEffectPacket for the player itself:
    // the server's effects, as they are when the replay reaches it. (Their attribute modifiers
    // are the server's: they reach the client as attributes.)
    Effects,
    // ClientboundPlayerAbilitiesPacket (a game mode, flight given or taken), or the player's chest
    // slot (a glider put on or taken off): the replay takes these from the server every tick, so a
    // tick played before the client had them may be off.
    Abilities,
}

// A teleport the client accepted: the replay starts again from it.
Restart :: struct {
    // Where it put the player.
    at: [f64,
    // It kept the player's motion (an End gateway's).
    kept_motion: bool,
    // Client ticks ended and changes heard before it: the ones after are the replay's.
    ended: u64,
    changed: u64,
}

// One client tick.
ClientTick :: struct {
    // The keys held (ServerboundPlayerInputPacket's flags: forward, backward, left, right, jump,
    // shift, sprint), as last sent.
    input: u8,
    // Sprinting, as the player's commands left it (ServerboundPlayerCommandPacket).
    sprinting: bool,
    // The rotation the client last sent.
    yaw: f32,
    pitch: f32,
    // Where the tick's move said the player is, if it said: a move with a position.
    position: Option<[f64,
    // The tick's move packet's flags (1: on the ground, 2: against a wall), if it sent one.
    flags: Maybe(u8),
    // The last server tick whose packets the client had handled (its pong) before this tick ended.
    seen: Maybe(u64),
}

// A player's last client ticks.
Record :: struct {
    // The tick being heard.
    current: ClientTick,
    // The ended ones, oldest first, at most [`KEPT`].
    ticks: VecDeque<ClientTick>,
    // The last server tick the client answered for.
    seen: Maybe(u64),
    // Client ticks ended since the record began.
    ended: u64,
    // Where an accepted teleport put the player, until the replay starts again from there.
    restart: Maybe(Restart),
    // What the server changed, with the server tick that sent it, oldest first.
    changes: VecDeque<(u64,
    // Changes heard since the record began.
    changed: u64,
    // The blocks the server changed near the player (None: an entity it stopped showing the player
    // from near it, which counts wherever the player has gone since), with the server tick that sent
    // each, until every kept tick has seen them.
    near: VecDeque<(u64,
    // The server tick of the last of them dropped early ([`NEAR_KEPT`] came after it).
    near_dropped: Maybe(u64),
}

    // rust: impl Record {
    // The tick's move: its position if it has one, the rotation if it has one, and its flags.
moved :: proc(self: ^Self, position: Maybe([f64; 3]), rotation: Option<(f32) {
}
    // rust: if position.is_some() {
    // rust: self.current.position = position;
}
    // rust: if let Some((yaw, pitch)) = rotation {
    // rust: (self.current.yaw, self.current.pitch) = (yaw, pitch);
}
    // rust: self.current.flags = Some(flags);
}

    // ServerboundPongPacket for the ping sent at the end of `server_tick`. False for an answer to a
    // ping that was never sent, or one older than an answer already heard: a vanilla client answers
    // every ping, once, in order.
pong :: proc(self: ^Self, server_tick: u64, sent_up_to: u64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if server_tick > sent_up_to || self.seen.is_some_and(|seen| server_tick <= seen) {
    // rust: return false;
}
    // rust: self.seen = Some(server_tick);
    // rust: true
}

    // ServerboundClientTickEndPacket: the tick ends with these keys held and this sprinting. The
    // next tick starts with the same keys and rotation, until the client says otherwise.
tick_end :: proc(self: ^Self, input: u8, sprinting: bool) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.current.input = input;
    // rust: self.current.sprinting = sprinting;
    // rust: self.current.seen = self.seen;
    // rust: let next = ClientTick {
    // rust: yaw: self.current.yaw,
    // rust: pitch: self.current.pitch,
    // rust: ..ClientTick::default()
}
    // rust: let ended = std::mem::replace(&mut self.current, next);
    // rust: if self.ticks.len() == KEPT {
    // rust: self.ticks.pop_front();
}
    // rust: self.ticks.push_back(ended);
    // rust: self.ended += 1;
        // What the oldest tick kept had seen, every later one had too.
    // rust: if let Some(seen) = self.ticks.front().and_then(|t| t.seen) {
    // rust: while self.near.front().is_some_and(|&(sent, _)| sent <= seen) {
    // rust: self.near.pop_front();
}
    // rust: self.near_dropped = self.near_dropped.filter(|&sent| sent > seen);
}
    // rust: self.ticks.back().expect("just pushed")
}

    // The ended ticks, oldest first.
ticks :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.ticks.iter()
}

    // The last server tick the client answered for.
seen :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.seen
}

    // Client ticks ended since the record began.
ended :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.ended
}

    // The ticks ended after the first `played`, oldest first; None when some of them are no longer
    // kept.
since :: proc(self: ^Self, played: u64) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let new = self.ended.checked_sub(played)?;
    // rust: let new = usize::try_from(new)
    // rust: .ok()
    // rust: .filter(|&n| n <= self.ticks.len())?;
    // rust: Some(self.ticks.iter().skip(self.ticks.len() - new))
}

    // `change`, sent during server tick `server_tick` (before that tick's ping).
changed :: proc(self: ^Self, server_tick: u64, change: Change) {
}
    // rust: if self.changes.len() == CHANGES_KEPT {
    // rust: self.changes.pop_front();
}
    // rust: self.changes.push_back((server_tick, change));
    // rust: self.changed += 1;
}

    // Changes heard since the record began.
changes :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.changed
}

    // The changes after the first `applied`, oldest first; None when some of them are no longer kept.
    // rust: pub fn changes_since(
    // rust: &self,
    // rust: applied: u64,
    // rust: ) -> Option<impl Iterator<Item = &(u64, Change)> + Clone> {
    // rust: let new = self.changed.checked_sub(applied)?;
    // rust: let new = usize::try_from(new)
    // rust: .ok()
    // rust: .filter(|&n| n <= self.changes.len())?;
    // rust: Some(self.changes.iter().skip(self.changes.len() - new))
}

    // During server tick `server_tick` (before that tick's ping) the server sent the client the block
    // at `pos`.
changed_near :: proc(self: ^Self, server_tick: u64, pos: [i32; 3]) {
}
    // rust: self.note_near(server_tick, Some(pos));
}

    // During server tick `server_tick` the server stopped showing the client an entity near it (a
    // firework it flew with, a mob that pushed it): the client may still have it, wherever it goes.
entity_gone :: proc(self: ^Self, server_tick: u64) {
}
    // rust: if self.near.back() != Some(&(server_tick, None)) {
    // rust: self.note_near(server_tick, None);
}
}

note_near :: proc(self: ^Self, server_tick: u64, pos: Maybe([i32; 3])) {
}
    // rust: if self.near.len() == NEAR_KEPT {
    // rust: self.near_dropped = self.near.pop_front().map(|(sent, _)| sent);
}
    // rust: self.near.push_back((server_tick, pos));
}

    // Whether a client tick that had `seen` up to that server tick (its [`ClientTick::seen`]) may
    // not have had a change at a position for which `near` holds: it still had the old block, or the
    // entity, where the server no longer has it.
unseen_near :: proc(self: ^Self, seen: Maybe(u64), near: impl Fn([i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let unseen = |sent: u64| seen.is_none_or(|seen| sent > seen);
    // rust: self.near_dropped.is_some_and(unseen)
    // rust: || self
    // rust: .near
    // rust: .iter()
    // rust: .any(|&(sent, pos)| unseen(sent) && pos.is_none_or(&near))
}

    // The client accepted a teleport to `at` (ServerboundAcceptTeleportationPacket): it goes on from
    // there, standing still unless the teleport `kept_motion` (an End gateway's). The ticks it ended
    // before stay, for a replay that hasn't played them yet; the one under way starts again.
teleported :: proc(self: ^Self, at: [f64; 3], kept_motion: bool) {
}
    // rust: self.restart_tick();
    // rust: self.restart = Some(Restart {
    // rust: at,
    // rust: kept_motion,
    // rust: ended: self.ended,
    // rust: changed: self.changed,
    // rust: });
}

    // The last teleport the client accepted, once.
take_restart :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.restart.take()
}

    // The ticks before now say nothing about the ones after.
clear :: proc(self: ^Self) {
}
    // rust: self.ticks.clear();
    // rust: self.restart_tick();
}

restart_tick :: proc(self: ^Self) {
}
    // rust: self.current = ClientTick {
    // rust: yaw: self.current.yaw,
    // rust: pitch: self.current.pitch,
    // rust: ..ClientTick::default()
}
}
}

    // rust: mod tests {
//     use super::*;

a_change_near_is_unseen_by_the_ticks_before_its_pong :: proc() {
}
    // rust: let mut r = Record::default();
    // rust: r.changed_near(4, [1, 2, 3]);
    // rust: r.changed_near(5, [7, 2, 3]);
    // rust: let near = |p: [i32; 3]| p[0] < 5;
    // rust: assert!(r.unseen_near(None, near));
    // rust: assert!(r.unseen_near(Some(3), near));
    // rust: assert!(!r.unseen_near(Some(4), near));
    // rust: assert!(r.unseen_near(Some(4), |_| true));
        // Kept until the oldest tick kept had seen it: one that ended before the pong hadn't.
    // rust: r.tick_end(0, false);
    // rust: assert!(r.pong(5, 5));
    // rust: r.tick_end(0, false);
    // rust: assert!(r.unseen_near(Some(3), near));
    // rust: for _ in 0..KEPT {
    // rust: r.tick_end(0, false);
}
    // rust: assert!(!r.unseen_near(None, |_| true));
        // An entity gone counts anywhere.
    // rust: r.entity_gone(5);
    // rust: r.entity_gone(5);
    // rust: assert!(r.unseen_near(Some(4), |_| false));
    // rust: assert!(!r.unseen_near(Some(5), |_| false));
        // One dropped early counts for the ticks that hadn't seen it.
    // rust: for i in 0..=NEAR_KEPT as u64 {
    // rust: r.changed_near(6 + i, [100, 0, 0]);
}
    // rust: assert!(
    // rust: r.unseen_near(Some(5), near),
    // rust: "a change dropped unseen counts"
    // rust: );
    // rust: assert!(!r.unseen_near(Some(6), near));
}

a_tick_is_the_packets_between_two_tick_ends :: proc() {
}
    // rust: let mut r = Record::default();
    // rust: r.moved(Some([1.0, 2.0, 3.0]), Some((90.0, 10.0)), 1);
    // rust: let t = *r.tick_end(0b1001, true);
    // rust: assert_eq!(t.position, Some([1.0, 2.0, 3.0]));
    // rust: assert_eq!((t.yaw, t.pitch, t.flags), (90.0, 10.0, Some(1)));
    // rust: assert_eq!((t.input, t.sprinting, t.seen), (0b1001, true, None));
        // A tick without a move keeps the rotation and has no position.
    // rust: let t = *r.tick_end(0, false);
    // rust: assert_eq!((t.position, t.flags, t.yaw), (None, None, 90.0));
    // rust: assert_eq!(r.ticks().len(), 2);
}

pongs_say_which_server_ticks_a_client_tick_had_seen :: proc() {
}
    // rust: let mut r = Record::default();
    // rust: assert!(r.pong(5, 6));
    // rust: r.tick_end(0, false);
    // rust: assert!(r.pong(6, 6));
    // rust: r.tick_end(0, false);
    // rust: r.tick_end(0, false);
    // rust: let seen: Vec<_> = r.ticks().map(|t| t.seen).collect();
    // rust: assert_eq!(seen, [Some(5), Some(6), Some(6)]);
        // Never sent, answered twice, or out of order.
    // rust: assert!(!r.pong(9, 6));
    // rust: assert!(!r.pong(6, 6));
    // rust: assert!(!r.pong(4, 6));
    // rust: assert_eq!(r.seen(), Some(6));
}

only_the_last_two_seconds_are_kept :: proc() {
}
    // rust: let mut r = Record::default();
    // rust: for i in 0..KEPT + 5 {
    // rust: r.moved(Some([i as f64, 0.0, 0.0]), None, 0);
    // rust: r.tick_end(0, false);
}
    // rust: assert_eq!(r.ticks().len(), KEPT);
    // rust: assert_eq!(r.ticks().next().unwrap().position, Some([5.0, 0.0, 0.0]));
    // rust: r.clear();
    // rust: assert_eq!(r.ticks().len(), 0);
}

the_replay_takes_the_ticks_it_has_not_played :: proc() {
}
    // rust: let mut r = Record::default();
    // rust: for i in 0..3 {
    // rust: r.moved(Some([i as f64, 0.0, 0.0]), None, 0);
    // rust: r.tick_end(0, false);
}
x :: proc(r: ^Record, played: u64) -> O {
    // Ported from Horizon
    return {}
}
    // rust: r.since(played)
    // rust: .map(|t| t.map(|t| t.position.unwrap()[0]).collect())
}
    // rust: assert_eq!(x(&r, 1), Some(vec![1.0, 2.0]));
    // rust: assert_eq!(x(&r, 3), Some(vec![]));
        // Played ahead of the record, or so far behind the ticks are gone.
    // rust: assert_eq!(x(&r, 4), None);
    // rust: r.clear();
    // rust: assert_eq!(x(&r, 2), None);
    // rust: assert_eq!(x(&r, 3), Some(vec![]));
    // rust: r.moved(Some([8.0, 0.0, 0.0]), None, 0);
    // rust: r.tick_end(0, false);
    // rust: r.moved(Some([9.0, 0.0, 0.0]), None, 0);
    // rust: r.teleported([5.0, 6.0, 7.0], false);
        // A tick that ends before the replay starts again is still one after the teleport.
    // rust: r.tick_end(0, false);
    // rust: let restart = r.take_restart().unwrap();
    // rust: assert_eq!((restart.at, restart.kept_motion), ([5.0, 6.0, 7.0], false));
    // rust: assert_eq!(r.since(restart.ended).unwrap().count(), 1);
        // The tick ended before it stays for a replay that hasn't played it; the move of the one
        // under way is gone.
    // rust: let positions: Vec<_> = r.since(3).unwrap().map(|t| t.position).collect();
    // rust: assert_eq!(positions, [Some([8.0, 0.0, 0.0]), None]);
    // rust: assert_eq!(r.take_restart(), None);
}

changes_keep_the_server_tick_that_sent_them :: proc() {
}
    // rust: let mut r = Record::default();
    // rust: r.changed(3, Change::Velocity([0.0, 0.4, 0.0]));
    // rust: r.changed(5, Change::Effects);
    // rust: let all: Vec<_> = r.changes_since(0).unwrap().copied().collect();
    // rust: assert_eq!(
    // rust: all,
    // rust: [(3, Change::Velocity([0.0, 0.4, 0.0])), (5, Change::Effects)]
    // rust: );
    // rust: assert_eq!(r.changes_since(1).unwrap().count(), 1);
    // rust: assert!(r.changes_since(3).is_none());
    // rust: for i in 0..CHANGES_KEPT as u64 {
    // rust: r.changed(6 + i, Change::Effects);
}
        // The first two are gone.
    // rust: assert!(r.changes_since(1).is_none());
    // rust: assert_eq!(r.changes_since(2).unwrap().count(), CHANGES_KEPT);
}
}
