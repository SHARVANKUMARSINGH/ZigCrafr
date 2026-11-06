//! Transpiled from Horizon Rust crate
package horizon_client_transfer

import "core:fmt"
import "core:mem"
import "core:math"

// A proxy's requests on the control endpoint, for a player it moves between two servers:
// `player-expect <uuid> [seconds]` (the target is told who is coming; its login is held),
// `player-drop <uuid>` (the target forgets it, and lets a held player go),
// `player-export <uuid> [freeze]` (the source answers with the player's record) and
// `player-release <uuid> <hand-over> moved [announce] | abort` (the source lets the player go),
// `player-import <uuid> <json>` and `player-confirm <uuid> <hand-over>` (the target takes the
// record and lets the held player in). They run
// between two ticks, on the server thread, so the player is never caught half-way through a
// tick. The rules are `lan/arrivals.rs`'s. All of them are refused while `server.toml`'s
// `[transfer]` is off.
// use crate::game::{Dim, Game, lan::LanHost};
// use horizon_client::lan::arrivals;
// use horizon_protocol::packets::play::{self, Clientbound as C};
// use serde_json::{Value, json};
// use std::time::Instant;

    // rust: impl Game<'_> {
    // A proxy's `player-*` request; the reply is one JSON line, `{"ok": true, ...}` or
    // `{"error": "..."}`. Each request writes one line to the log with what became of it
    // (`arrivals::request_log`): a hand-over that failed leaves a trace.
    // rust: pub(super) fn player_request(&mut self, verb: &str, args: &str) -> Value {
        // The name is read before the request runs: a release or a drop takes the player away.
    // rust: let name = args
    // rust: .split_whitespace()
    // rust: .next()
    // rust: .and_then(arrivals::parse_uuid)
    // rust: .and_then(|uuid| {
    // rust: self.lan
    // rust: .as_ref()?
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .find(|g| g.uuid == uuid)
    // rust: .map(|g| g.name.clone())
    // rust: });
    // rust: let reply = self.run_player_request(verb, args);
    // rust: let (level, line) = arrivals::request_log(verb, name.as_deref(), args, &reply);
    // rust: super::log(level, &line);
    // rust: reply
}

run_player_request :: proc(self: ^Self, verb: string, args: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let Some(host) = self.lan.as_ref() else {
    // rust: return json!({ "error": "the server is not open to players" });
}
    // rust: if host.hub.transfers.is_none() {
    // rust: return json!({ "error": arrivals::OFF });
}
    // rust: match verb {
    // rust: "player-expect" => match self.lan.as_mut() {
    // rust: Some(host) => arrivals::expect_request(&mut host.hub, args, Instant::now()),
    // rust: None => json!({ "error": "the server is not open to players" }),
    // rust: },
    // rust: "player-drop" => match self.lan.as_mut() {
    // rust: Some(host) => arrivals::drop_request(&mut host.hub, args),
    // rust: None => json!({ "error": "the server is not open to players" }),
    // rust: },
    // rust: "player-export" => self.player_export(args),
    // rust: "player-import" => self.player_import(args),
    // rust: "player-confirm" => self.player_confirm(args),
    // rust: "player-release" => match self.lan.as_mut() {
    // rust: Some(host) => arrivals::release_request(&mut host.hub, args),
    // rust: None => json!({ "error": "the server is not open to players" }),
    // rust: },
    // rust: other => json!({ "error": format!("unknown request {other:?}") }),
}
}

    // `player-export <uuid> [freeze]`: closes the player's menus as vanilla does when a menu closes
    // (the cursor stack and the crafting grids go back into the inventory), then answers with the
    // player's record (`arrivals::export_record`). With `freeze`, a hand-over starts: the player's
    // own inputs stop being acted on until it ends, and a later export answers with the same record.
player_export :: proc(self: ^Self, args: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut parts = args.split_whitespace();
    // rust: let Some(uuid) = parts.next().and_then(arrivals::parse_uuid) else {
    // rust: return json!({ "error": "player-export needs the player's unique id" });
}
    // rust: let freeze = match parts.next() {
    // rust: None => false,
    // rust: Some("freeze") => true,
    // rust: Some(_) => return json!({ "error": "the only option of player-export is freeze" }),
}
    // rust: if parts.next().is_some() {
    // rust: return json!({ "error": "player-export takes a unique id and at most freeze" });
}
    // rust: let Some(mut host) = self.lan.take() else {
    // rust: return json!({ "error": "the server is not open to players" });
}
    // rust: let reply = self.export_from(&mut host, uuid, freeze);
    // rust: self.lan = Some(host);
    // rust: reply
}

    // `player-import <uuid> <json>`: applies a record to the held player (`lan/import.rs`), with
    // its advancements and statistics, which need the game's tree and counters, and the mods'
    // attachments. Unless the request says `"place": false`, it then places the player as
    // `player-confirm` does, its file written first.
player_import :: proc(self: ^Self, args: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let Some((id, request)) = args.trim().split_once(char::is_whitespace) else {
    // rust: return json!({ "error": "player-import needs a unique id and a request" });
}
    // rust: let Some(uuid) = arrivals::parse_uuid(id) else {
    // rust: return json!({ "error": "player-import needs the player's unique id" });
}
    // rust: let request: Value = match serde_json::from_str(request.trim()) {
    // rust: Ok(v) => v,
    // rust: Err(e) => return json!({ "error": format!("the request is not JSON: {e}") }),
}
    // rust: let Some(mut host) = self.lan.take() else {
    // rust: return json!({ "error": "the server is not open to players" });
}
        // A retry after the commit, whose reply was lost: the player is placed from this
        // hand-over already, and the answer is the same.
    // rust: let retried = request["record"]["handover"]
    // rust: .as_str()
    // rust: .and_then(arrivals::parse_handover)
    // rust: .and_then(|id| host.hub.placed_arrival(uuid, id).map(|g| (id, g)));
    // rust: if let Some((id, i)) = retried {
    // rust: let reply = json!({
    // rust: "ok": true,
    // rust: "handover": arrivals::handover_text(id),
    // rust: "placed": true,
    // rust: "announced": host.hub.guests[i].arrival_announce,
    // rust: "recentered": host.hub.guests[i].arrival_recentered,
    // rust: "retried": true,
    // rust: });
    // rust: self.lan = Some(host);
    // rust: return reply;
}
    // rust: let result = horizon_client::lan::import::import_player(&mut host.hub, uuid, &request);
    // rust: let reply = match result {
    // rust: Ok(done) => {
    // rust: self.take_arrival_records(&mut host, uuid, &done);
    // rust: let handover = arrivals::handover_text(done.handover);
    // rust: let placed = if done.place {
    // rust: self.place_arrival(&mut host, uuid, done.handover)
    // rust: } else {
    // rust: Ok(false)
}
    // rust: match placed {
    // rust: Ok(placed) => json!({
    // rust: "ok": true,
    // rust: "handover": handover,
    // rust: "parts": done.parts,
    // rust: "placed": placed,
    // rust: "announced": done.announce,
    // rust: "recentered": done.recentered,
    // rust: }),
    // rust: Err(e) => json!({ "error": e }),
}
}
    // rust: Err(e) => json!({ "error": e }),
}
    // rust: self.lan = Some(host);
    // rust: reply
}

    // What an import brought that the game keeps itself: the advancements (`PlayerAdvancements
    // .applyFrom` drops those this server lacks), the statistics, and the attachments of a whole
    // import, which saves copy from the game's own map (`guest_attachments_into`).
    // rust: fn take_arrival_records(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: uuid: u128,
    // rust: done: &horizon_client::lan::import::Imported,
    // rust: ) {
    // rust: let tree = self.advancement_tree();
    // rust: let Some(g) = host.hub.guests.iter_mut().find(|g| g.uuid == uuid) else {
    // rust: return;
}
    // rust: if let Some(saved) = &done.advancements {
    // rust: let mut progress = horizon_client::advancements::Progress::from_json(saved);
    // rust: progress
    // rust: .criteria
    // rust: .retain(|id, _| tree.by_id.contains_key(id));
    // rust: g.advancements = progress;
    // rust: g.advancements_loaded = true;
}
    // rust: if done.attachments {
    // rust: self.guest_attachments.insert(uuid, g.attachments.clone());
}
    // rust: if let Some(stats) = &done.stats {
    // rust: let play = host.play.entry(g.conn).or_default();
    // rust: play.stats = crate::game::stats::Stats::from_json(stats);
    // rust: play.stats.mark_all_dirty();
}
}

    // `player-confirm <uuid> <hand-over>`: places a held player whose record of that hand-over was
    // imported without placing it.
player_confirm :: proc(self: ^Self, args: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let Some(mut host) = self.lan.take() else {
    // rust: return json!({ "error": "the server is not open to players" });
}
    // rust: let reply = match arrivals::confirm_args(&host.hub, args) {
            // A retry after the commit, whose reply was lost: the same answer.
    // rust: Ok((uuid, id)) if host.hub.placed_arrival(uuid, id).is_some() => {
    // rust: let i = host.hub.placed_arrival(uuid, id).unwrap_or_default();
    // rust: json!({
    // rust: "ok": true,
    // rust: "placed": true,
    // rust: "announced": host.hub.guests[i].arrival_announce,
    // rust: "retried": true,
    // rust: })
}
    // rust: Ok((uuid, id)) => match self.place_arrival(&mut host, uuid, id) {
    // rust: Ok(_) => {
    // rust: let announced = host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .find(|g| g.uuid == uuid)
    // rust: .is_some_and(|g| g.arrival_announce);
    // rust: json!({ "ok": true, "placed": true, "announced": announced })
}
    // rust: Err(e) => json!({ "error": e }),
    // rust: },
    // rust: Err(e) => json!({ "error": e }),
}
    // rust: self.lan = Some(host);
    // rust: reply
}

    // The hand-over's commit point on the target: the arrival's player file, advancements and
    // statistics are written, synchronously, then it is placed. Only then does the reply say
    // `ok`, so a proxy that sends `player-release moved` to the source after it knows a copy of
    // the player is on disk here. When the file cannot be written the player stays held and
    // imported: the proxy can confirm again or drop it.
place_arrival :: proc(self: ^Self, host: ^LanHost, uuid: u128, id: u128) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let i = host.hub.imported_arrival(uuid, id)?;
    // rust: let mut g = host.hub.guests.remove(i);
    // rust: self.guest_attachments_into(&mut g);
        // An autosave of this player still in flight must not land after this write.
    // rust: let _ = self.finish_player_autosaves(true);
    // rust: let written = horizon_client::lan::playerdata::save_now(&g, &self.world_root)
    // rust: .and_then(|()| self.write_arrival_records(host, &g));
    // rust: let name = g.name.clone();
    // rust: host.hub.guests.insert(i, g);
    // rust: written?;
    // rust: let announced = host.hub.confirm_arrival(uuid, id)?;
    // rust: self.arrival_placed(uuid, &name, announced);
    // rust: Ok(true)
}

    // What the game does once a held player is placed: the log's lines, and the mods' "logged
    // in" (`native_player_logged_in`), which a held login did not send, so a placed arrival
    // is heard of as any login and its leaving later is not the mods' first word of it.
arrival_placed :: proc(self: ^Self, uuid: u128, name: string, announced: bool) {
}
    // rust: super::log("INFO", &arrivals::placed_line(name));
    // rust: if announced {
    // rust: super::log("INFO", &format!("System chat: {name} joined the game"));
}
    // rust: self.native_player_logged_in(uuid, name);
}

export_from :: proc(self: ^Self, host: ^LanHost, uuid: u128, freeze: bool) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let i = match arrivals::check_exportable(&host.hub, uuid) {
    // rust: Ok(i) => i,
    // rust: Err(why) => return json!({ "error": why }),
}
        // A repeat while the hand-over lasts: the same record, and nothing touched.
    // rust: if let Some(h) = &host.hub.guests[i].handover {
    // rust: return arrivals::export_reply(&host.hub, i, h.record.clone());
}
    // rust: let conn = host.hub.guests[i].conn;
    // rust: let window = host.hub.guests[i].menu.as_ref().map(|m| m.window);
        // The menu closes in the player's own level, as when it leaves (`game/lan.rs`'s close of
        // every guest): a chest's lid, a villager's trade and a dropped cursor stack belong there.
    // rust: let back = self.dim;
    // rust: let level = Dim::from_id(&host.hub.guests[i].dimension);
    // rust: if let Err(e) = self.enter_level(Some(host), level) {
    // rust: return json!({ "error": format!("the player's level could not be opened: {e}") });
}
        // Nothing is sent to the client by this: it is for a player who is leaving.
    // rust: self.guest_close_all(host, conn);
        // The inventory's own 2x2 grid too (`InventoryMenu.removed`): `guest_close_all` empties it
        // only with a real `ContainerClose(0)`, and a frozen client's is dropped. Its items are
        // not in the player compound, so they would be lost with `player-release moved`.
    // rust: self.lan_crafting_closed(host, conn, Some(0));
    // rust: if let Err(e) = self.enter_level(Some(host), back) {
    // rust: log::error!("could not reopen {}: {e}", back.id());
}
    // rust: let Some(i) = host.hub.guests.iter().position(|g| g.conn == conn) else {
    // rust: return json!({ "error": "that player is not connected to this server" });
}
        // The player may stay (a hand-over that does not finish): its client closes the menu too
        // and shows the inventory as it now is.
    // rust: if let Some(container) = window {
    // rust: host.hub
    // rust: .send_to(conn, &C::ContainerClose(play::ContainerClose { container }));
}
    // rust: host.hub.send_inventory(i);
        // What a mod attached to the player since it joined, as a save writes it.
    // rust: self.guest_attachments_into(&mut host.hub.guests[i]);
    // rust: let advancements = if self.adv.tree.list.is_empty() {
    // rust: Value::Null
    // rust: } else {
    // rust: host.hub.guests[i]
    // rust: .advancements
    // rust: .to_json(&self.adv.tree, horizon_world::DATA_VERSION)
}
    // rust: let stats = host
    // rust: .play
    // rust: .get(&conn)
    // rust: .map_or(Value::Null, |p| p.stats.to_json());
    // rust: let records = arrivals::Records {
    // rust: advancements,
    // rust: stats,
}
    // rust: match arrivals::export_record(&mut host.hub, i, freeze, records) {
    // rust: Ok(record) => arrivals::export_reply(&host.hub, i, record),
    // rust: Err(e) => json!({ "error": e }),
}
}
}
