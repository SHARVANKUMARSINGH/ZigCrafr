//! Transpiled from Horizon Rust crate
package horizon_client_pads

import "core:fmt"
import "core:mem"
import "core:math"

// Controllers: which player each drives, joining with one, and one disconnecting (its player
// waits for another). One reader for every player's game (`PadRouter`) while splitscreen
// watches the controllers; otherwise P1 reads them itself, as without splitscreen.
// use super::hud::tr;
// use super::*;
// use crate::game::pad::{PadEvent, PadId};
// use horizon_client::controller_notice::{Notice, NoticeId, Priority};
// use horizon_client::gamepad::{Button, PadState};

// How long a controller's offer to join stays up.
OFFER :: Duration::from_secs(10)

// P1's controller, and one P1 gave away (Give Up Pad) while it's offered to join: until the
// other player is in the world, cancelling, declining or the offer running out gives that same
// pad back, never another player's.
    // rust: pub(super) struct P1Pad<Id> {
    // rust: pub(super) owner: Option<Id>,
    // rust: released: Option<Id>,
}
    // rust: impl<Id> Default for P1Pad<Id> {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: owner: None,
    // rust: released: None,
}
}
}
    // rust: impl<Id: Copy + Eq> P1Pad<Id> {
    // rust: pub(super) fn claim(&mut self, id: Id) {
    // rust: self.owner = Some(id);
    // rust: if self.released == Some(id) {
    // rust: self.released = None;
}
}
release :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let id = self.owner.take()?;
    // rust: self.released = Some(id);
    // rust: Some(id)
}
cancel :: proc(self: ^Self, id: Id) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if self.released != Some(id) {
    // rust: return false;
}
    // rust: self.released = None;
    // rust: if self.owner.is_some() {
    // rust: return false;
}
    // rust: self.owner = Some(id);
    // rust: true
}
    // rust: pub(super) fn joined(&mut self, id: Id) {
    // rust: if self.released == Some(id) {
    // rust: self.released = None;
}
}
gone :: proc(self: ^Self, id: Id) {
}
    // rust: if self.owner == Some(id) {
    // rust: self.owner = None;
}
    // rust: self.joined(id);
}
}

// A player whose controller disconnected, waiting for one: its seat (1 = P1), and the
// controller's id and kind (`PadRouter::uuid`) to know it back.
    // rust: pub(super) struct Lost<Id> {
    // rust: pub(super) seat: usize,
    // rust: pub(super) id: Id,
    // rust: pub(super) uuid: [u8; 16],
}

// What a button on a controller no player has does while players wait for one.
    // rust: pub(super) enum Claim {
    // It goes to `lost[k]`.
    // rust: Give(usize),
    // `lost[k]` leaves instead.
    // rust: Leave(usize),
    // Nothing: the others wait (no offer to join meanwhile).
    // rust: Wait,
    // Nobody but P1 waits, and P1 has the keyboard: as if nobody did.
    // rust: Pass,
}

// The same kind of controller back takes back its player with any button; another takes over
// the player waiting longest with A, or lets it leave with B. P1 is only given its own back
// (another joins as P1 through the offer to join).
//
// `uuid` names the model, not the device (gilrs' SDL-style GUID), so it stands for "the same
// controller" only where a reconnect gets a new id (`model_match`: macOS; elsewhere the id
// survives and `PadEvent::Back` takes it), and only when one waiting player has that model:
// otherwise another DualSense would silently take a DualSense player's seat. On Linux gilrs
// itself reuses a disconnected pad's slot for a new one of the same model, so there a
// `PadEvent::Back` can be that other controller: gilrs can't tell the two apart.
    // rust: pub(super) fn claim<Id>(
    // rust: lost: &[Lost<Id>],
    // rust: uuid: [u8; 16],
    // rust: button: Button,
    // rust: model_match: bool,
    // rust: ) -> Claim {
    // rust: let same_model = || lost.iter().filter(|l| l.uuid == uuid).count() == 1;
    // rust: if model_match
    // rust: && uuid != [0; 16]
    // rust: && same_model()
    // rust: && let Some(k) = lost.iter().position(|l| l.uuid == uuid)
    // rust: {
    // rust: return Claim::Give(k);
}
    // rust: let Some(k) = lost.iter().position(|l| l.seat != 1) else {
    // rust: return Claim::Pass;
}
    // rust: match button {
    // rust: Button::South => Claim::Give(k),
    // rust: Button::East => Claim::Leave(k),
    // rust: _ => Claim::Wait,
}
}

    // rust: impl Split<'_> {
    // Give P1 its normal controller reader again and discard pending joins and handoffs.
    // rust: pub(super) fn stop_routing(&mut self) {
    // rust: if self.host.pad.feed.take().is_some() {
    // rust: self.host.pad.release_hardware();
    // rust: self.host.split_hud = Default::default();
    // rust: self.offers.clear();
    // rust: self.fresh.clear();
    // rust: self.lost.clear();
    // rust: self.p1_pad = P1Pad::default();
    // rust: self.pads.hand_back(&mut self.host.pad);
}
}

    // The pad's state for its player: nothing while the press that gave it is still held.
pad_state :: proc(self: ^Self, pad: Maybe(PadId)) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let Some(id) = pad else {
    // rust: return Default::default();
}
    // rust: let state = self.pads.state(id);
    // rust: if self.fresh.contains(&id) {
    // rust: if pressing(&state) {
    // rust: return Default::default();
}
    // rust: self.fresh.retain(|&p| p != id);
}
    // rust: state
}

    // Controllers: P1's is the first used in a menu; in a world a controller nobody holds is
    // offered to join (A), or to drive P1 (Y) while P1 has none. The pads whose players
    // should join now.
    // `solo`: no compositor, P1 alone (its controller's output is lent to it after this).
    // rust: pub(super) fn route_pads(&mut self, solo: bool) -> Vec<PadId> {
    // rust: let now = Instant::now();
    // rust: let owner_before = self.p1_pad.owner;
    // rust: let offers_before = self.offers.len();
    // rust: let mut joins = Vec::new();
    // rust: let mut presses = Vec::new();
    // rust: self.pads.adopt(&mut self.host.pad);
    // rust: for event in self.pads.events() {
    // rust: match event {
    // rust: PadEvent::Press(id, button) => presses.push((id, button)),
    // rust: PadEvent::Gone(id) => self.pad_gone(id),
    // rust: PadEvent::Back(id) => {
    // rust: if let Some(k) = self.lost.iter().position(|l| l.id == id) {
    // rust: let seat = self.lost.remove(k).seat;
    // rust: self.give_pad(seat, id);
}
}
}
}
    // rust: self.forget_lost();
    // rust: for (id, button) in presses {
    // rust: if Some(id) == self.p1_pad.owner || self.guests.iter().any(|g| g.pad == Some(id)) {
    // rust: continue;
}
            // Pressed, then gone in the same frame.
    // rust: if !self.pads.connected(id) {
    // rust: continue;
}
            // In a menu the first controller pressed is P1's, so it can drive the menu, and so
            // it is when P1's own disconnected and its view asks for another. Elsewhere in a
            // world it is offered to join (A joins as the next player, Y gives the pad to P1):
            // the one controller pressed while P1 plays with the keyboard and mouse makes a
            // second player rather than taking P1's controls.
    // rust: let in_world = self.in_world();
            // The players waiting for a controller come first: the same kind back takes back
            // its player, another takes over the one waiting longest (`claim`). Only what that
            // passes on, with P1 the one waiting, goes to P1 here.
    // rust: if in_world && self.claim_for_lost(id, button) {
    // rust: continue;
}
    // rust: let p1_waits = self.lost.iter().any(|l| l.seat == 1);
    // rust: let claims_p1 = p1_takes(
    // rust: in_world,
    // rust: p1_waits,
    // rust: self.host.settings.controller.enabled,
    // rust: self.p1_pad.owner.is_some(),
    // rust: );
    // rust: if claims_p1 {
    // rust: self.p1_pad.claim(id);
    // rust: self.fresh.push(id);
    // rust: continue;
}
    // rust: if !in_world {
    // rust: continue;
}
    // rust: match self.offers.iter().position(|(o, _)| *o == id) {
    // rust: Some(k) => match button {
                    // Two pressing A together both join, in the order they pressed.
    // rust: Button::South => {
    // rust: self.offers.remove(k);
    // rust: joins.push(id);
}
    // rust: Button::North
    // rust: if self.p1_pad.owner.is_none() && self.host.settings.controller.enabled =>
    // rust: {
    // rust: self.offers.remove(k);
    // rust: self.p1_pad.claim(id);
    // rust: self.fresh.push(id);
}
                    // No: a pad P1 gave up goes back to P1.
    // rust: Button::East => {
    // rust: self.offers.remove(k);
    // rust: self.restore_given_up_pad(id);
}
    // rust: _ => {}
    // rust: },
                // An offer for each controller while seats are left.
    // rust: None if self.players() + joins.len() + self.offers.len() < MAX_PLAYERS => {
    // rust: self.offers.push((id, now));
    // rust: self.ask_to_join();
}
    // rust: None => {}
}
}
    // rust: let in_world = self.in_world();
        // An offer that ran out: a pad P1 gave up goes back to P1.
    // rust: let expired: Vec<_> = self
    // rust: .offers
    // rust: .iter()
    // rust: .filter(|(_, since)| now - *since > OFFER || !in_world)
    // rust: .map(|(id, _)| *id)
    // rust: .collect();
    // rust: for id in expired {
    // rust: self.restore_given_up_pad(id);
}
    // rust: self.offers
    // rust: .retain(|(_, since)| now - *since <= OFFER && in_world);
    // rust: if self.offers.is_empty() {
    // rust: self.prompt_join(None);
    // rust: } else if self.offers.len() != offers_before
    // rust: || self.p1_pad.owner != owner_before
    // rust: || !joins.is_empty()
    // rust: {
    // rust: self.ask_to_join();
}
        // Each player's glyphs follow its own controller (its game never reads the pads itself).
    // rust: if let Some(id) = self.p1_pad.owner {
    // rust: self.host.pad.style = self.pads.style(id);
}
    // rust: self.host.pad.device = self.p1_pad.owner.and_then(|id| self.pads.device(id));
    // rust: for g in &mut self.guests {
    // rust: if let Some(id) = g.pad {
    // rust: g.game.pad.style = self.pads.style(id);
}
    // rust: g.game.pad.device = g.pad.and_then(|id| self.pads.device(id));
}
        // P1 alone keeps its controller's output (rumble, the DualSense's triggers): the router
        // lends it its reader for P1's turn (`lend_output`), so no second reader opens. Only
        // when nothing is lent does P1's own reader close: releasing a lent one each frame
        // would stop its rumble a frame after it starts.
    // rust: if !lends_output(solo, self.p1_pad.owner.is_some()) {
    // rust: self.host.pad.release_hardware();
}
    // rust: let owner = self.p1_pad.owner;
        // Only something on the control socket can ask.
    // rust: if self.host.control.is_some() {
    // rust: self.pads.report_status(&mut self.host.pad, owner);
}
    // rust: let state = self.pad_state(owner);
    // rust: self.host.pad.feed_from(owner, state);
    // rust: for i in 0..self.guests.len() {
    // rust: let pad = self.guests[i].pad;
    // rust: if self.guests[i].game.control.is_some() {
    // rust: self.pads.report_status(&mut self.guests[i].game.pad, pad);
}
    // rust: let state = self.pad_state(pad);
    // rust: self.guests[i].game.pad.feed_from(pad, state);
}
    // rust: joins
}

    // P1's Give Up Pad: its controller stops driving P1 and is offered to join, for a friend
    // to press A (P1 plays on with the keyboard and mouse).
    // rust: pub(super) fn give_up_pad(&mut self) {
    // rust: let Some(id) = self.p1_pad.release() else {
    // rust: return;
}
    // rust: self.offers.retain(|(o, _)| *o != id);
    // rust: self.offers.push((id, Instant::now()));
    // rust: self.host.pad.release_hardware();
    // rust: self.host.pad.feed = Some(PadState::default());
    // rust: self.ask_to_join();
}

    // A pad P1 gave up whose offer ended without a player in the world: P1's again.
    // rust: pub(super) fn restore_given_up_pad(&mut self, id: PadId) {
    // rust: if self.pads.connected(id) && self.p1_pad.cancel(id) {
            // The Cancel/No press belongs to the transfer, not P1's menu.
    // rust: self.fresh.push(id);
}
}

    // A controller disconnected: its offer and fresh press go; its player waits for one
    // (P1 keeps the keyboard and mouse).
pad_gone :: proc(self: ^Self, id: PadId) {
}
    // rust: self.fresh.retain(|&p| p != id);
    // rust: let offered = self.offers.len();
    // rust: self.offers.retain(|(p, _)| *p != id);
    // rust: if self.offers.len() != offered && !self.offers.is_empty() {
    // rust: self.ask_to_join();
}
    // rust: let uuid = self.pads.uuid(id);
    // rust: let owned = self.p1_pad.owner == Some(id);
    // rust: self.p1_pad.gone(id);
    // rust: if owned {
    // rust: if self.in_world() {
    // rust: self.lost.push(Lost { seat: 1, id, uuid });
    // rust: self.host.split_hud.notice.raise(Notice::new(
    // rust: NoticeId::Connection,
    // rust: Priority::Attention,
    // rust: tr("controller_disconnected", &[]),
    // rust: tr("controller_disconnected.hint", &[]),
    // rust: ));
}
    // rust: return;
}
    // rust: let Some(g) = self.guests.iter_mut().find(|g| g.pad == Some(id)) else {
    // rust: return;
}
    // rust: g.pad = None;
    // rust: let Some(name) = g.name.clone() else {
            // Still picking a profile: as if it pressed Cancel (`pick_profiles`).
    // rust: g.game.screen = crate::game::Screen::Playing;
    // rust: return;
}
    // rust: self.lost.push(Lost {
    // rust: seat: g.seat,
    // rust: id,
    // rust: uuid,
    // rust: });
    // rust: g.game.split_hud.prompt = Some(lost_prompt(&name));
}

    // Player in `seat` plays with controller `id` (back, or another): its question goes.
give_pad :: proc(self: ^Self, seat: uint, id: PadId) {
}
    // rust: self.fresh.push(id);
    // rust: let hud = if seat == 1 {
    // rust: self.p1_pad.claim(id);
    // rust: &mut self.host.split_hud
    // rust: } else {
    // rust: let Some(g) = self.guests.iter_mut().find(|g| g.seat == seat) else {
    // rust: return;
}
    // rust: g.pad = Some(id);
    // rust: &mut g.game.split_hud
}
    // rust: if hud.prompt.as_ref().is_some_and(|p| p.ask == Ask::Lost) {
    // rust: hud.prompt = None;
}
    // rust: hud.notice.raise(Notice::new(
    // rust: NoticeId::Connection,
    // rust: Priority::Info,
    // rust: tr("controller_connected", &[]),
    // rust: "",
    // rust: ));
}

    // A button on a controller nobody has while players wait for one: true when it answered
    // them (`claim`).
claim_for_lost :: proc(self: ^Self, id: PadId, button: Button) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match claim(
    // rust: &self.lost,
    // rust: self.pads.uuid(id),
    // rust: button,
    // rust: cfg!(target_os = "macos"),
    // rust: ) {
    // rust: Claim::Give(k) => {
    // rust: let seat = self.lost.remove(k).seat;
    // rust: self.give_pad(seat, id);
}
    // rust: Claim::Leave(k) => {
    // rust: let seat = self.lost.remove(k).seat;
    // rust: if let Some(g) = self.guests.iter_mut().find(|g| g.seat == seat) {
    // rust: g.game.split_hud.prompt = None;
    // rust: if let Err(e) = g.game.leave_server(None) {
    // rust: log::warn!("Horizon: splitscreen: {e}");
}
}
}
    // rust: Claim::Wait => {}
    // rust: Claim::Pass => return false,
}
    // rust: true
}

    // Nobody waits for a player who left or has a controller again (another way), nor for P1
    // out of a world.
forget_lost :: proc(self: ^Self) {
}
    // rust: let p1 = self.in_world() && self.p1_pad.owner.is_none();
    // rust: let guests = &self.guests;
    // rust: self.lost.retain(|l| match l.seat {
    // rust: 1 => p1,
    // rust: seat => guests.iter().any(|g| g.seat == seat && g.pad.is_none()),
    // rust: });
}

    // Every player sees the controllers waiting to join, whatever it is doing.
ask_to_join :: proc(self: ^Self) {
}
    // rust: let title = match self.offers.as_slice() {
    // rust: [(id, _)] => tr("join.one", &[&self.pads.name(*id)]),
    // rust: offers => tr("join.many", &[&offers.len()]),
}
    // rust: let mut choices = vec![(Button::South, tr("join.yes", &[]))];
    // rust: if self.p1_pad.owner.is_none() && self.host.settings.controller.enabled {
    // rust: choices.push((Button::North, tr("join.as_p1", &[])));
}
    // rust: choices.push((Button::East, tr("join.no", &[])));
    // rust: self.prompt_join(Some(Prompt {
    // rust: ask: Ask::Join,
    // rust: title,
    // rust: choices,
    // rust: }));
}
}

// Whether a controller nobody holds becomes P1's on its first press: in a menu, where it drives
// the menus, or in a world while P1's own is gone and P1's view asks for another ("Use
// another"). Elsewhere in a world it is offered to join, so a controller pressed while P1 plays
// with the keyboard and mouse starts the join flow instead of taking P1's controls; Y in that
// offer gives the pad to P1 when it is free. P1 with controllers off plays on the keyboard and
// mouse: a pad given to it is dead either way.
p1_takes :: proc(in_world: bool, p1_waits: bool, controllers: bool, p1_has_pad: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: (!in_world || p1_waits) && controllers && !p1_has_pad
}

// Whether P1 gets the split's reader for its turn (`lend_output`): solo, with a controller.
lends_output :: proc(solo: bool, p1_has_pad: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: solo && p1_has_pad
}

// Still holding the press that gave the pad its player: a button, or a trigger off its rest.
// Mapped triggers may also report a gilrs button press; unmapped axis triggers
// only appear in `PadState::triggers` and do not create the join `Press` event.
pressing :: proc(state: ^PadState) -> b {
    // Ported from Horizon
    return {}
}
    // rust: state.buttons != 0 || state.triggers.iter().any(|&t| t > 0.05)
}

    // rust: mod tests {
//     use super::*;

lost :: proc(seat: uint, uuid: [u8; 16]) -> L {
    // Ported from Horizon
    return {}
}
    // rust: Lost {
    // rust: seat,
    // rust: id: seat,
    // rust: uuid,
}
}

a_controller_pressed_in_a_world_is_offered_to_join_not_taken_by_p1 :: proc() {
}
        // P1 alone on the keyboard and mouse: the press is offered (A joins, Y gives it to P1).
    // rust: assert!(
    // rust: !p1_takes(true, false, true, false),
    // rust: "a controller pressed in a world never takes P1's controls"
    // rust: );
        // P1's own disconnected and its view asks for another: "Use another" hands it over.
    // rust: assert!(
    // rust: p1_takes(true, true, true, false),
    // rust: "a player waiting for a controller takes the next one"
    // rust: );
        // The menus still hand the first controller to P1, so it can drive them.
    // rust: assert!(
    // rust: p1_takes(false, false, true, false),
    // rust: "a menu's first controller is P1's"
    // rust: );
    // rust: assert!(
    // rust: !p1_takes(false, false, false, false),
    // rust: "controllers off: P1 has none"
    // rust: );
    // rust: assert!(
    // rust: !p1_takes(false, false, true, true),
    // rust: "P1 has a controller already"
    // rust: );
}

a_lone_p1_keeps_its_lent_output_between_frames :: proc() {
}
    // rust: assert!(
    // rust: lends_output(true, true),
    // rust: "rumble and triggers survive the next frame"
    // rust: );
    // rust: assert!(
    // rust: !lends_output(true, false),
    // rust: "no controller: P1's own reader closes"
    // rust: );
    // rust: assert!(
    // rust: !lends_output(false, true),
    // rust: "others play: the router owns every pad"
    // rust: );
}

the_trigger_that_gave_a_pad_is_held_back_too :: proc() {
}
    // rust: assert!(!pressing(&PadState::default()));
    // rust: let trigger = PadState {
    // rust: triggers: [0.0, 0.8],
    // rust: ..Default::default()
}
    // rust: assert!(pressing(&trigger), "a held trigger would attack or use");
    // rust: let button = PadState {
    // rust: buttons: 1,
    // rust: ..Default::default()
}
    // rust: assert!(pressing(&button));
}

the_same_controller_back_takes_its_player_with_any_button :: proc() {
}
    // rust: let waiting = [lost(2, [7; 16]), lost(3, [9; 16])];
    // rust: assert_eq!(
    // rust: claim(&waiting, [9; 16], Button::North, true),
    // rust: Claim::Give(1)
    // rust: );
}

another_controller_takes_over_or_lets_go_the_longest_waiting :: proc() {
}
    // rust: let waiting = [lost(3, [7; 16]), lost(2, [8; 16])];
    // rust: assert_eq!(
    // rust: claim(&waiting, [1; 16], Button::South, true),
    // rust: Claim::Give(0)
    // rust: );
    // rust: assert_eq!(
    // rust: claim(&waiting, [1; 16], Button::East, true),
    // rust: Claim::Leave(0)
    // rust: );
    // rust: assert_eq!(claim(&waiting, [1; 16], Button::North, true), Claim::Wait);
}

only_p1_waiting_leaves_the_offer_to_join :: proc() {
}
    // rust: let waiting = [lost(1, [7; 16])];
    // rust: assert_eq!(claim(&waiting, [1; 16], Button::South, true), Claim::Pass);
    // rust: assert_eq!(
    // rust: claim(&waiting, [7; 16], Button::South, true),
    // rust: Claim::Give(0)
    // rust: );
}

the_same_model_is_only_known_back_where_ids_change_and_unambiguous :: proc() {
}
        // Windows and Linux keep the id across a reconnect: another of the same model asks.
    // rust: let waiting = [lost(2, [7; 16])];
    // rust: assert_eq!(claim(&waiting, [7; 16], Button::North, false), Claim::Wait);
    // rust: assert_eq!(
    // rust: claim(&waiting, [7; 16], Button::South, false),
    // rust: Claim::Give(0)
    // rust: );
        // Two players wait with the same model: no guess, the longest waiting is asked for.
    // rust: let waiting = [lost(3, [7; 16]), lost(2, [7; 16])];
    // rust: assert_eq!(claim(&waiting, [7; 16], Button::North, true), Claim::Wait);
    // rust: assert_eq!(
    // rust: claim(&waiting, [7; 16], Button::East, true),
    // rust: Claim::Leave(0)
    // rust: );
}

a_controller_the_system_does_not_describe_is_not_known_back :: proc() {
}
    // rust: let waiting = [lost(2, [0; 16])];
    // rust: assert_eq!(claim(&waiting, [0; 16], Button::North, true), Claim::Wait);
}

a_pending_transfer_can_be_canceled_without_claiming_an_unrelated_pad :: proc() {
}
    // rust: let mut p1 = P1Pad::default();
    // rust: p1.claim(7);
    // rust: assert_eq!(p1.release(), Some(7));
    // rust: assert_eq!(p1.owner, None);
    // rust: assert!(!p1.cancel(8));
    // rust: assert!(p1.cancel(7));
    // rust: assert_eq!(p1.owner, Some(7));
    // rust: assert!(!p1.cancel(7));
}

entering_the_world_commits_the_transfer_and_reclaim_does_not_steal_a_pad :: proc() {
}
    // rust: let mut p1 = P1Pad::default();
    // rust: p1.claim(7);
    // rust: p1.release();
    // rust: p1.joined(7);
    // rust: assert!(!p1.cancel(7));
    // rust: assert_eq!(p1.owner, None);
    // rust: p1.claim(7);
    // rust: p1.release();
    // rust: p1.claim(8);
    // rust: assert!(!p1.cancel(7));
    // rust: assert_eq!(p1.owner, Some(8));
    // rust: p1.release();
    // rust: p1.gone(8);
    // rust: assert!(!p1.cancel(8));
}
}
