//! Transpiled from Horizon Rust crate
package horizon_client_arrivals

import "core:fmt"
import "core:mem"
import "core:math"

// Players that are about to arrive from another server, and a connected
// player read out of this one and sent away: the control endpoint's
// `player-expect`, `player-drop`, `player-export`, `player-release` and
// `player-confirm` (`game/dedicated/transfer.rs` runs them; `player-import` is
// `import.rs`'s).
//
// A proxy that moves a player between two servers first tells the target
// server who is coming (`player-expect <uuid>`); the player's next login is then
// taken in as a *held* player: connected, receiving the world, but not
// simulated, shown or announced until the hand-over finishes. It reads the
// player out of the source (`player-export <uuid> [freeze]`). Nothing here may
// last without bound, because a proxy that dies in the middle of a move leaves
// its expectations, its held players and its freezes behind: every expectation
// expires, the table has a size cap, a held player is dropped and a freeze is
// let go by themselves.
//
// All of it is off unless `server.toml`'s `[transfer]` turns it on
// (horizon-server passes it to the game as `--transfers`, [`Settings`]). While
// it is off the hub has no [`Transfers`], every request is refused and nothing
// is done on a tick. It has nothing to do with vanilla's `accepts-transfers`,
// which is about the transfer packet a server sends a client.
// use super::hub::Hub;
// use std::collections::HashMap;
// use std::sync::{Arc, Mutex};
// use std::time::{Duration, Instant};

// `server.toml`'s `[transfer]`, as horizon-server passes it: `--transfers
// expect_seconds=10,max_expect_seconds=60,max_expected=64,max_freeze_seconds=30,max_hold_seconds=60`.
// A key left out keeps its default.
Settings :: struct {
    // How long an expectation lives when the request names no time.
    expect: Duration,
    // The longest an expectation may be asked to live.
    max_expect: Duration,
    // The most expectations the table keeps at once.
    max_expected: uint,
    // Server ticks a player may stay frozen for a hand-over: a proxy that dies
    // in the middle of one must not leave the player stuck.
    max_freeze_ticks: u64,
    // Server ticks a held player may wait for its hand-over before the server
    // drops it.
    max_hold_ticks: u64,
}

    // rust: impl Default for Settings {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: expect: Duration::from_secs(10),
    // rust: max_expect: Duration::from_secs(60),
    // rust: max_expected: 64,
    // rust: max_freeze_ticks: 20 * 30,
    // rust: max_hold_ticks: 20 * 60,
}
}
}

    // rust: impl Settings {
    // Reads `--transfers`' value: `key=value` pairs separated by commas, each a
    // whole number above zero.
parse :: proc(text: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut s = Self::default();
    // rust: for pair in text.split(',').map(str::trim).filter(|p| !p.is_empty()) {
    // rust: let (key, value) = pair
    // rust: .split_once('=')
    // rust: .ok_or_else(|| format!("{pair:?} is not key=value"))?;
    // rust: let key = key.trim();
    // rust: let n: u64 = value
    // rust: .trim()
    // rust: .parse()
    // rust: .ok()
    // rust: .filter(|n| *n > 0)
    // rust: .ok_or_else(|| format!("{key} must be a whole number above zero"))?;
    // rust: match key {
    // rust: "expect_seconds" => s.expect = Duration::from_secs(n),
    // rust: "max_expect_seconds" => s.max_expect = Duration::from_secs(n),
    // rust: "max_expected" => {
    // rust: s.max_expected = usize::try_from(n).map_err(|_| "max_expected is too large")?
}
    // rust: "max_hold_seconds" => {
    // rust: s.max_hold_ticks = n.checked_mul(20).ok_or("max_hold_seconds is too large")?
}
    // rust: "max_freeze_seconds" => {
    // rust: s.max_freeze_ticks =
    // rust: n.checked_mul(20).ok_or("max_freeze_seconds is too large")?
}
    // rust: other => return Err(format!("unknown setting {other:?}")),
}
}
    // rust: if s.expect > s.max_expect {
    // rust: return Err("expect_seconds is above max_expect_seconds".into());
}
    // rust: Ok(s)
}
}

// What a server with transfers on keeps: its settings and the players it was
// told to expect. The table is shared with the network threads, which use an
// expectation up when a login starts.
Transfers :: struct {
    settings: Settings,
    expected: ^Mutex<Expectations>,
}

    // rust: impl Transfers {
new :: proc(settings: Settings) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let expected = Arc::new(Mutex::new(Expectations::new(
    // rust: settings.max_expected,
    // rust: settings.max_expect,
    // rust: )));
    // rust: Self { settings, expected }
}

    // The table, locked. A thread that panicked while holding it left it
    // whole: every change is one map operation.
table :: proc(self: ^Self) -> s {
    // Ported from Horizon
    return {}
}
    // rust: self.expected.lock().unwrap_or_else(|e| e.into_inner())
}
}

// Why an expectation could not be recorded.
ExpectError :: enum {
    // The table is full of live expectations.
    Full,
}

// The players a server was told to expect, by unique id.
Expectations :: struct {
    until: HashMap<u128,
    max: uint,
    max_ttl: Duration,
}

    // rust: impl Default for Expectations {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: let s = Settings::default();
    // rust: Self::new(s.max_expected, s.max_expect)
}
}

    // rust: impl Expectations {
new :: proc(max: uint, max_ttl: Duration) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: until: HashMap::new(),
    // rust: max,
    // rust: max_ttl,
}
}

    // Records that `uuid` will log in within `ttl` (cut to the longest time
    // allowed). A second request for the same player replaces the first one's
    // deadline. Returns whether the player was already expected.
expect :: proc(self: ^Self, uuid: u128, ttl: Duration, now: Instant) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.expire(now);
    // rust: if !self.until.contains_key(&uuid) && self.until.len() >= self.max {
    // rust: return Err(ExpectError::Full);
}
    // rust: let deadline = now + ttl.min(self.max_ttl);
    // rust: Ok(self.until.insert(uuid, deadline).is_some())
}

    // Uses up the expectation of `uuid`, and says whether it was still alive:
    // the login that starts takes it, and a second login of the same player
    // finds none.
take :: proc(self: ^Self, uuid: u128, now: Instant) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.take_until(uuid, now).is_some()
}

    // [`Self::take`], giving the deadline of the expectation used up, for
    // [`Self::put_back`].
take_until :: proc(self: ^Self, uuid: u128, now: Instant) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.until.remove(&uuid).filter(|deadline| now < *deadline)
}

    // Gives back an expectation a login used up and that did not reach play (it
    // failed in configuration), with its own deadline: the proxy's next attempt
    // within that time is still expected. Nothing is put back once its time has
    // passed, over a newer expectation of the same player, or into a full table.
put_back :: proc(self: ^Self, uuid: u128, deadline: Instant, now: Instant) {
}
    // rust: if now < deadline && !self.until.contains_key(&uuid) && self.until.len() < self.max {
    // rust: self.until.insert(uuid, deadline);
}
}

    // Forgets the expectation of `uuid`. Returns whether there was one.
forget :: proc(self: ^Self, uuid: u128) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.until.remove(&uuid).is_some()
}

    // Drops the expectations whose time has passed and returns them, so the
    // caller can log that the player never came.
expire :: proc(self: ^Self, now: Instant) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let gone: Vec<u128> = self
    // rust: .until
    // rust: .iter()
    // rust: .filter(|(_, deadline)| now >= **deadline)
    // rust: .map(|(uuid, _)| *uuid)
    // rust: .collect();
    // rust: for uuid in &gone {
    // rust: self.until.remove(uuid);
}
    // rust: gone
}

    // The longest an expectation may live.
max_ttl :: proc(self: ^Self) -> D {
    // Ported from Horizon
    return {}
}
    // rust: self.max_ttl
}

    // How many expectations are recorded (some may be past their time but not
    // yet swept).
len :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.until.len()
}

is_empty :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.until.is_empty()
}
}

// The version of the record `player-export` answers with.
RECORD_VERSION :: 1

// A hand-over in progress on the source: the player was exported with
// `freeze`. Its id names it in the later requests, and its record is what
// every later export answers with until it ends, the same bytes each time,
// so a proxy that lost the reply can ask again.
Handover :: struct {
    id: u128,
    // The hub tick the freeze started at.
    since: u64,
    record: serde_json::Value,
}

// A hand-over id as a reply writes it: 32 lowercase hexadecimal digits.
handover_text :: proc(id: u128) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!("{id:032x}")
}

// A hand-over id from a request: 32 hexadecimal digits.
parse_handover :: proc(text: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if text.len() != 32 || !text.bytes().all(|b| b.is_ascii_hexdigit()) {
    // rust: return None;
}
    // rust: u128::from_str_radix(text, 16).ok()
}

// A new hand-over id, from the operating system's secure randomness.
new_handover_id :: proc() -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut bytes = [0u8; 16];
    // rust: horizon_protocol::crypto::random_bytes(&mut bytes).map_err(|e| e.to_string())?;
    // rust: Ok(u128::from_le_bytes(bytes))
}

// Whether a held player that joined at tick `since` has waited too long at tick
// `now` for its hand-over, for a wait of at most `max` ticks.
held_too_long :: proc(since: u64, now: u64, max: u64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: now.saturating_sub(since) >= max
}

// Whether a player frozen at tick `since` has been frozen too long at tick
// `now`, for a freeze of at most `max` ticks.
frozen_too_long :: proc(since: u64, now: u64, max: u64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: now.saturating_sub(since) >= max
}

// Why the connected player `uuid` cannot be exported now, or the index of its
// guest. A held player is not exportable: it has no state of its own yet.
check_exportable :: proc(hub: ^Hub, uuid: u128) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let Some(i) = hub.guests.iter().position(|g| g.uuid == uuid) else {
    // rust: return Err("that player is not connected to this server");
}
    // rust: let g = &hub.guests[i];
    // rust: if g.held {
    // rust: Err("that player is held: it has not been handed over yet")
    // rust: } else if !g.placed {
    // rust: Err("that player has not finished joining")
    // rust: } else if !g.left_reason.is_empty() {
    // rust: Err("that player is leaving")
    // rust: } else if g.vehicle.is_some() {
    // rust: Err("that player is riding")
    // rust: } else if g.sleeping {
    // rust: Err("that player is asleep")
    // rust: } else if g.dead {
    // rust: Err("that player is dead")
    // rust: } else {
    // rust: Ok(i)
}
}

// What a record carries besides the player compound: the JSON the server keeps
// for the player's advancements and statistics (null where it keeps none).
Records :: struct {
    advancements: serde_json::Value,
    stats: serde_json::Value,
}

// The record of the player at guest index `i` (which [`check_exportable`] gave,
// with its menus closed and its attachments in place): the player compound as
// the server saves it, as the uncompressed NBT of the compound in base64, its
// advancements and statistics, and the few values a proxy reads without opening
// it. With `freeze`, a hand-over starts: the record gets an id, the player's
// own inputs stop being acted on until the hand-over ends, and every later
// export answers with this same record. A player already frozen is answered
// with its hand-over's record, whatever `freeze` says.
    // rust: pub fn export_record(
    // rust: hub: &mut Hub,
    // rust: i: usize,
    // rust: freeze: bool,
    // rust: records: Records,
    // rust: ) -> Result<serde_json::Value, String> {
//     use horizon_world::nbt::{Limits, NamedTag, write_named};
    // rust: if let Some(h) = &hub.guests[i].handover {
    // rust: return Ok(h.record.clone());
}
    // rust: let id = freeze.then(new_handover_id).transpose()?;
    // rust: let g = &hub.guests[i];
    // rust: let tag = super::playerdata::player_tag(g);
    // rust: let bytes = write_named(
    // rust: &NamedTag {
    // rust: name: "".into(),
    // rust: tag,
    // rust: },
    // rust: Limits::saved(),
    // rust: )
    // rust: .map_err(|e| e.to_string())?;
    // rust: let velocity = g
    // rust: .motion
    // rust: .as_ref()
    // rust: .map_or([0.0; 3], |m| [m.velocity.x, m.velocity.y, m.velocity.z]);
    // rust: let record = serde_json::json!({
    // rust: "version": RECORD_VERSION,
    // rust: "data_version": horizon_world::DATA_VERSION,
    // rust: "handover": id.map(handover_text),
    // rust: "uuid": horizon_protocol::crypto::uuid_string(g.uuid),
    // rust: "name": g.name,
    // rust: "dimension": g.dimension,
    // rust: "position": g.position,
    // rust: "rotation": [g.yaw, g.pitch],
    // rust: "velocity": velocity,
    // rust: "game_mode": g.game_mode,
    // rust: "player": super::base64(&bytes),
    // rust: "advancements": records.advancements,
    // rust: "stats": records.stats,
    // rust: });
    // rust: if let Some(id) = id {
    // rust: let since = hub.ticks;
    // rust: hub.guests[i].handover = Some(Handover {
    // rust: id,
    // rust: since,
    // rust: record: record.clone(),
    // rust: });
}
    // rust: Ok(record)
}

// The reply to an export: the record and, while the player is frozen, the ticks left
// before its hand-over ends by itself (`freeze_ticks_left`), so that a proxy does not
// commit on the target so late that its `moved` would come after the end. The count is
// beside the record, which stays the same bytes from one export to the next.
export_reply :: proc(hub: ^Hub, i: uint, record: serde_json::Value) -> s {
    // Ported from Horizon
    return {}
}
    // rust: let left = hub.guests[i]
    // rust: .handover
    // rust: .as_ref()
    // rust: .zip(hub.transfers.as_ref())
    // rust: .map(|(h, t)| {
    // rust: t.settings
    // rust: .max_freeze_ticks
    // rust: .saturating_sub(hub.ticks.saturating_sub(h.since))
    // rust: });
    // rust: let mut reply = serde_json::json!({ "ok": true, "record": record });
    // rust: if let Some(left) = left {
    // rust: reply["freeze_ticks_left"] = left.into();
}
    // rust: reply
}

// The log line for a proxy's `player-*` request and what became of it, with its level.
// `name` is the player's name when the server knows it. Only the player's id and a few
// words of the outcome are written: never the record, which is large and is the player's.
    // rust: pub fn request_log(
    // rust: verb: &str,
    // rust: name: Option<&str>,
    // rust: args: &str,
    // rust: reply: &serde_json::Value,
    // rust: ) -> (&'static str, String) {
    // rust: let mut words = args.split_whitespace();
    // rust: let id = words.next().unwrap_or("");
    // rust: let who = match (parse_uuid(id), name) {
    // rust: (Some(u), Some(name)) => format!("{name} ({})", horizon_protocol::crypto::uuid_string(u)),
    // rust: (Some(u), None) => horizon_protocol::crypto::uuid_string(u),
    // rust: (None, _) => format!("{id:?}"),
}
    // rust: if let Some(why) = reply.get("error").and_then(serde_json::Value::as_str) {
    // rust: return ("WARN", format!("{verb} {who}: refused: {why}"));
}
    // rust: let flag = |key: &str| reply.get(key).and_then(serde_json::Value::as_bool);
    // The hand-over a request names (release, confirm, drop) or a reply gives (export,
    // import): it ties the lines of one hand-over together on both servers.
    // rust: let named = words.next();
    // rust: let handover = |given: Option<&serde_json::Value>| {
    // rust: given
    // rust: .and_then(serde_json::Value::as_str)
    // rust: .or(named.filter(|w| parse_handover(w).is_some()))
    // rust: .map_or(String::new(), |id| format!(", hand-over {id}"))
}
    // rust: let details = match verb {
    // rust: "player-expect" => format!(
    // rust: "expected for {} s{}",
    // rust: reply["ttl_seconds"],
    // rust: if flag("renewed") == Some(true) {
    // rust: " (renewed)"
    // rust: } else {
    // rust: ""
}
    // rust: ),
    // rust: "player-export" => format!(
    // rust: "record of {} bytes{}",
    // rust: reply["record"]["player"]
    // rust: .as_str()
    // rust: .map_or(0, |p| p.len() / 4 * 3),
    // rust: match reply["record"]["handover"].as_str() {
    // rust: Some(id) => format!(", frozen, hand-over {id}"),
    // rust: None => ", a read".to_owned(),
}
    // rust: ),
    // rust: "player-import" => format!(
    // rust: "parts {}, placed {}, announced {}, recentered {}{}",
    // rust: reply["parts"]
    // rust: .as_array()
    // rust: .map(|p| p
    // rust: .iter()
    // rust: .filter_map(|v| v.as_str())
    // rust: .collect::<Vec<_>>()
    // rust: .join(","))
    // rust: .unwrap_or_default(),
    // rust: flag("placed").unwrap_or(false),
    // rust: flag("announced").unwrap_or(false),
    // rust: flag("recentered").unwrap_or(false),
    // rust: handover(reply.get("handover")),
    // rust: ),
    // rust: "player-confirm" => format!(
    // rust: "placed, announced {}{}",
    // rust: flag("announced").unwrap_or(false),
    // rust: handover(None)
    // rust: ),
    // rust: "player-release" => match reply.get("released").and_then(serde_json::Value::as_str) {
    // rust: Some("moved") => format!(
    // rust: "moved, announced {}{}",
    // rust: flag("announced").unwrap_or(false),
    // rust: handover(None)
    // rust: ),
    // rust: other => format!("{}{}", other.unwrap_or("released"), handover(None)),
    // rust: },
    // rust: "player-drop" => format!(
    // rust: "held {}, expected {}{}",
    // rust: flag("held").unwrap_or(false),
    // rust: flag("expected").unwrap_or(false),
    // rust: handover(None)
    // rust: ),
    // rust: _ => "done".to_owned(),
}
    // A retry after the commit, whose reply was lost: nothing was done again.
    // rust: let retried = if flag("retried") == Some(true) {
    // rust: " (a retry: nothing done again)"
    // rust: } else {
    // rust: ""
}
    // rust: ("INFO", format!("{verb} {who}: ok, {details}{retried}"))
}

// The line written when a player is held: it logged in as the player a proxy expected.
held_line :: proc(name: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!("{name} is held: it arrives from another server")
}

// The line written when a held player is let into the world.
placed_line :: proc(name: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!("{name} placed: it has arrived from another server")
}

// The line written when a held player's connection ends before it was placed: it was
// never announced, so it has no "left the game".
dropped_line :: proc(name: string, reason: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!("{name} was dropped while held: {reason}")
}

// A unique id as text, with or without dashes.
parse_uuid :: proc(text: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let plain: String = text.chars().filter(|c| *c != '-').collect();
    // rust: if plain.len() != 32 || !plain.bytes().all(|b| b.is_ascii_hexdigit()) {
    // rust: return None;
}
    // rust: u128::from_str_radix(&plain, 16).ok()
}

error :: proc(message: string) -> s {
    // Ported from Horizon
    return {}
}
    // rust: serde_json::json!({ "error": message })
}

// The reply to every `player-*` request on a server with transfers off.
OFF :: "transfers are off on this server"

// `player-expect <uuid> [seconds]`: the player will log in within that time
// (`[transfer]`'s `expect_seconds` by default, `max_expect_seconds` at most).
// The reply says whether an earlier expectation was renewed. The login uses
// the expectation up when it starts; one that no login used is reported when
// it runs out.
expect_request :: proc(hub: ^Hub, args: string, now: Instant) -> s {
    // Ported from Horizon
    return {}
}
    // rust: let Some(transfers) = &hub.transfers else {
    // rust: return error(OFF);
}
    // rust: let mut parts = args.split_whitespace();
    // rust: let Some(uuid) = parts.next().and_then(parse_uuid) else {
    // rust: return error("player-expect needs the player's unique id");
}
    // rust: let ttl = match parts.next() {
    // rust: None => transfers.settings.expect,
    // rust: Some(seconds) => match seconds.parse::<u64>() {
    // rust: Ok(s) if s > 0 => Duration::from_secs(s),
    // rust: _ => return error("the time must be a number of seconds above zero"),
    // rust: },
}
    // rust: if parts.next().is_some() {
    // rust: return error("player-expect takes a unique id and at most a time");
}
    // rust: if hub.guests.iter().any(|g| g.uuid == uuid) {
    // rust: return error("that player is already connected to this server");
}
    // rust: let mut table = transfers.table();
    // rust: match table.expect(uuid, ttl, now) {
    // rust: Ok(renewed) => serde_json::json!({
    // rust: "ok": true,
    // rust: "renewed": renewed,
    // rust: "ttl_seconds": ttl.min(table.max_ttl()).as_secs(),
    // rust: }),
    // rust: Err(ExpectError::Full) => error("too many players are expected at once"),
}
}

// `player-drop <uuid> [hand-over]`: forgets the expectation of that player, and
// disconnects it if it is already held, without a save or a word to anyone. With a
// hand-over id, the held player must be the one whose record of that hand-over was
// imported: a late drop of an older hand-over leaves a newer one alone. Before any
// import there is no id to name, and the drop goes by the unique id alone.
drop_request :: proc(hub: ^Hub, args: string) -> s {
    // Ported from Horizon
    return {}
}
    // rust: if hub.transfers.is_none() {
    // rust: return error(OFF);
}
    // rust: let mut parts = args.split_whitespace();
    // rust: let Some(uuid) = parts.next().and_then(parse_uuid) else {
    // rust: return error("player-drop needs the player's unique id");
}
    // rust: let id = match parts.next() {
    // rust: None => None,
    // rust: Some(text) => match parse_handover(text) {
    // rust: Some(id) => Some(id),
    // rust: None => return error("player-drop takes a unique id and at most a hand-over id"),
    // rust: },
}
    // rust: if parts.next().is_some() {
    // rust: return error("player-drop takes a unique id and at most a hand-over id");
}
    // rust: if let Some(id) = id
    // rust: && let Err(why) = hub.imported_arrival(uuid, id)
    // rust: {
    // rust: return error(why);
}
    // rust: let held = hub.drop_held(uuid);
    // rust: let expected = hub
    // rust: .transfers
    // rust: .as_ref()
    // rust: .is_some_and(|t| t.table().forget(uuid));
    // rust: if !held && !expected {
    // rust: return error("no player with that unique id is held or expected");
}
    // rust: serde_json::json!({ "ok": true, "held": held, "expected": expected })
}

// `player-confirm <uuid> <hand-over>`: the held player whose record of that hand-over was
// imported, ready to be placed (`Hub::imported_arrival`). The game writes its file, then places
// it (`Hub::confirm_arrival`). Until then `player-drop` removes it without a save or a word to
// anyone.
confirm_args :: proc(hub: ^Hub, args: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut parts = args.split_whitespace();
    // rust: let Some(uuid) = parts.next().and_then(parse_uuid) else {
    // rust: return Err("player-confirm needs the player's unique id".into());
}
    // rust: let Some(id) = parts.next().and_then(parse_handover) else {
    // rust: return Err("player-confirm needs the hand-over id of the record".into());
}
    // rust: if parts.next().is_some() {
    // rust: return Err("player-confirm takes a unique id and a hand-over id".into());
}
    // rust: if hub.placed_arrival(uuid, id).is_none() {
    // rust: hub.imported_arrival(uuid, id)?;
}
    // rust: Ok((uuid, id))
}

// `player-release <uuid> <hand-over> moved [announce]` or `player-release <uuid> <hand-over>
// abort`: ends the hand-over the export with `freeze` started. `moved` takes the player out of
// the world, saving nothing and, unless `announce`, without the "left the game" line; `abort`
// lets it go on as it was. Both name the hand-over, so a late or repeated request for one that
// is over touches nothing.
release_request :: proc(hub: ^Hub, args: string) -> s {
    // Ported from Horizon
    return {}
}
    // rust: let mut parts = args.split_whitespace();
    // rust: let Some(uuid) = parts.next().and_then(parse_uuid) else {
    // rust: return error("player-release needs the player's unique id");
}
    // rust: let Some(id) = parts.next().and_then(parse_handover) else {
    // rust: return error("player-release needs the hand-over id the export gave");
}
    // rust: let how = parts.next();
    // rust: let announce = match (how, parts.next()) {
    // rust: (Some("moved"), None) => false,
    // rust: (Some("moved"), Some("announce")) => true,
    // rust: (Some("abort"), None) => false,
    // rust: _ => {
    // rust: return error(
    // rust: "player-release <uuid> <hand-over> is followed by moved [announce] or abort",
    // rust: );
}
}
    // rust: if parts.next().is_some() {
    // rust: return error(
    // rust: "player-release takes a unique id, a hand-over id, moved or abort, and at most announce",
    // rust: );
}
    // rust: if how == Some("moved") {
    // rust: return match hub.release_moved(uuid, id, announce) {
    // rust: Ok(()) => serde_json::json!({
    // rust: "ok": true,
    // rust: "released": "moved",
    // rust: "announced": announce,
    // rust: }),
    // rust: Err(why) => error(why),
}
}
    // rust: match hub.handover_of(uuid, id) {
    // rust: Ok(i) => {
    // rust: hub.guests[i].handover = None;
    // rust: serde_json::json!({ "ok": true, "released": "abort" })
}
    // rust: Err(why) => error(why),
}
}

    // rust: mod tests {
//     use super::*;

A :: 0xA
B :: 0xB

secs :: proc(n: u64) -> D {
    // Ported from Horizon
    return {}
}
    // rust: Duration::from_secs(n)
}

an_expected_player_is_taken_once_before_the_deadline :: proc() {
}
    // rust: let t0 = Instant::now();
    // rust: let mut e = Expectations::default();
    // rust: assert_eq!(e.expect(A, secs(10), t0), Ok(false));
    // rust: assert!(e.take(A, t0 + secs(9)));
        // The login consumed it: a second login of the same player is ordinary.
    // rust: assert!(!e.take(A, t0 + secs(9)));
    // rust: assert!(e.is_empty());
}

an_expectation_is_dead_at_its_deadline :: proc() {
}
    // rust: let t0 = Instant::now();
    // rust: let mut e = Expectations::default();
    // rust: e.expect(A, secs(10), t0).unwrap();
        // Exactly at the deadline is already too late.
    // rust: assert!(!e.take(A, t0 + secs(10)));
    // rust: assert!(e.is_empty());
}

a_player_nobody_expected_has_no_expectation :: proc() {
}
    // rust: let mut e = Expectations::default();
    // rust: assert!(!e.take(B, Instant::now()));
}

asking_again_moves_the_deadline_and_says_so :: proc() {
}
    // rust: let t0 = Instant::now();
    // rust: let mut e = Expectations::default();
    // rust: e.expect(A, secs(5), t0).unwrap();
    // rust: assert_eq!(e.expect(A, secs(30), t0 + secs(4)), Ok(true));
    // rust: assert!(e.take(A, t0 + secs(20)));
}

a_held_player_waits_one_minute_of_ticks :: proc() {
}
    // rust: let max = Settings::default().max_hold_ticks;
    // rust: assert_eq!(max, 1200);
    // rust: assert!(!held_too_long(100, 100 + 1199, max));
    // rust: assert!(held_too_long(100, 100 + 1200, max));
        // A clock that went backwards never drops anyone.
    // rust: assert!(!held_too_long(500, 100, max));
}

forgetting_removes_only_that_player :: proc() {
}
    // rust: let t0 = Instant::now();
    // rust: let mut e = Expectations::default();
    // rust: e.expect(A, secs(10), t0).unwrap();
    // rust: e.expect(B, secs(10), t0).unwrap();
    // rust: assert!(e.forget(A));
    // rust: assert!(!e.forget(A));
    // rust: assert!(e.take(B, t0));
}

a_long_wait_is_cut_to_the_maximum :: proc() {
}
    // rust: let t0 = Instant::now();
    // rust: let mut e = Expectations::default();
    // rust: e.expect(A, secs(3600), t0).unwrap();
    // rust: assert!(!e.take(A, t0 + Settings::default().max_expect));
}

expiry_returns_the_players_that_never_came_and_keeps_the_others :: proc() {
}
    // rust: let t0 = Instant::now();
    // rust: let mut e = Expectations::default();
    // rust: e.expect(A, secs(5), t0).unwrap();
    // rust: e.expect(B, secs(30), t0).unwrap();
    // rust: assert_eq!(e.expire(t0 + secs(6)), vec![A]);
    // rust: assert_eq!(e.len(), 1);
    // rust: assert!(e.take(B, t0 + secs(7)));
}

the_table_refuses_new_players_when_full_but_expired_ones_make_room :: proc() {
}
    // rust: let t0 = Instant::now();
    // rust: let mut e = Expectations::default();
    // rust: for n in 0..Settings::default().max_expected as u128 {
    // rust: e.expect(100 + n, secs(10), t0).unwrap();
}
    // rust: assert_eq!(e.expect(A, secs(10), t0), Err(ExpectError::Full));
        // A player already in the table can still be renewed when it is full.
    // rust: assert_eq!(e.expect(100, secs(10), t0), Ok(true));
        // Once the old ones are past their time, there is room again.
    // rust: assert_eq!(e.expect(A, secs(10), t0 + secs(11)), Ok(false));
    // rust: assert_eq!(e.len(), 1);
}

the_settings_are_read_from_the_supervisors_line :: proc() {
}
    // rust: assert_eq!(Settings::parse(""), Ok(Settings::default()));
    // rust: let s = Settings::parse(
    // rust: "expect_seconds=5,max_expect_seconds=20,max_expected=3,max_freeze_seconds=12",
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(s.expect, secs(5));
    // rust: assert_eq!(s.max_expect, secs(20));
    // rust: assert_eq!(s.max_expected, 3);
    // rust: assert_eq!(s.max_freeze_ticks, 240);
        // One key alone keeps the others' defaults.
    // rust: assert_eq!(
    // rust: Settings::parse("max_expected=8").unwrap(),
    // rust: Settings {
    // rust: max_expected: 8,
    // rust: ..Settings::default()
}
    // rust: );
    // rust: for bad in [
    // rust: "expect_seconds=0",
    // rust: "expect_seconds=-1",
    // rust: "expect_seconds",
    // rust: "colour=blue",
    // rust: "expect_seconds=90",
    // rust: ] {
    // rust: assert!(Settings::parse(bad).is_err(), "{bad:?} was taken");
}
}

the_table_follows_the_settings :: proc() {
}
    // rust: let t0 = Instant::now();
    // rust: let mut e = Expectations::new(2, secs(5));
    // rust: e.expect(A, secs(60), t0).unwrap();
    // rust: assert!(!e.take(A, t0 + secs(5)), "cut to five seconds");
    // rust: e.expect(A, secs(1), t0).unwrap();
    // rust: e.expect(B, secs(1), t0).unwrap();
    // rust: assert_eq!(e.expect(3, secs(1), t0), Err(ExpectError::Full));
}

    // A login that does not reach play gives its expectation back, with its
    // own deadline, so the proxy's next attempt is still expected.
an_expectation_a_failed_login_used_is_put_back_with_its_deadline :: proc() {
}
    // rust: let t0 = Instant::now();
    // rust: let mut e = Expectations::default();
    // rust: e.expect(A, secs(10), t0).unwrap();
    // rust: let deadline = e.take_until(A, t0 + secs(2)).unwrap();
    // rust: assert!(e.is_empty());
    // rust: e.put_back(A, deadline, t0 + secs(4));
    // rust: assert!(e.take(A, t0 + secs(9)), "the same deadline, not a new one");
        // Not once its time has passed.
    // rust: e.put_back(A, deadline, t0 + secs(10));
    // rust: assert!(e.is_empty());
        // Not over a newer expectation of the same player.
    // rust: e.expect(A, secs(30), t0 + secs(5)).unwrap();
    // rust: e.put_back(A, deadline, t0 + secs(6));
    // rust: assert!(e.take(A, t0 + secs(20)), "the newer deadline stands");
}

a_hand_over_id_is_32_hexadecimal_digits :: proc() {
}
    // rust: let id = 0x0123_4567_89ab_cdef_0011_2233_4455_6677;
    // rust: assert_eq!(handover_text(id), "0123456789abcdef0011223344556677");
    // rust: assert_eq!(parse_handover(&handover_text(id)), Some(id));
    // rust: assert_eq!(parse_handover("0123456789ABCDEF0011223344556677"), Some(id));
    // rust: assert_eq!(parse_handover("0123456789abcdef001122334455667"), None);
    // rust: assert_eq!(parse_handover("01234567-89ab-cdef-0011-223344556677"), None);
    // rust: assert_ne!(new_handover_id().unwrap(), new_handover_id().unwrap());
}
}

// The hub's side: the requests, the record and the freeze.
    // rust: mod hub_tests {
//     use crate::lan::{
    // rust: Joined, Lan, NetConfig, Out, PlayerSender,
    // rust: chunks::ChunkEncoder,
    // rust: data,
    // rust: guest::Guest,
    // rust: hub::{Hub, HubConfig, TickCtx},
}
//     use horizon_protocol::ids::play::clientbound as id;
//     use std::sync::mpsc::{Receiver, channel};
//     use std::time::{Duration, Instant};

hub :: proc() -> H {
    // Ported from Horizon
    return {}
}
    // rust: let config = NetConfig {
    // rust: announce: false,
    // rust: ..NetConfig::loopback(0, "ArrivalsTest".into(), 4)
}
    // rust: let mut sync = data::SyncData::empty();
        // The entity types the tracker names: the player, as id 0.
    // rust: sync.builtin.registries.insert(
    // rust: "minecraft:entity_type".to_string(),
    // rust: horizon_protocol::registry::Ids::from_names(vec!["minecraft:player".to_string()]),
    // rust: );
    // rust: let sync = std::sync::Arc::new(sync);
    // rust: let lan = Lan::start_with(sync.clone(), config).unwrap();
    // rust: let encoder = ChunkEncoder::new(
    // rust: [] as [(std::sync::Arc<str>, bool); 0],
    // rust: &horizon_protocol::registry::Builtin::default(),
    // rust: &[],
    // rust: &[],
    // rust: );
    // rust: let config = HubConfig {
    // rust: default_game_mode: 0,
    // rust: guest_commands: false,
    // rust: force_game_mode: false,
    // rust: hardcore: false,
    // rust: view_distance: 4,
    // rust: simulation_distance: 4,
    // rust: dimension: "minecraft:overworld".into(),
    // rust: allow_flight: false,
    // rust: seed: 0,
    // rust: max_players: 4,
    // rust: integrated: false,
    // rust: levels: Default::default(),
}
    // rust: let mut hub = Hub::new(lan, sync, encoder, config);
    // rust: hub.transfers = Some(super::Transfers::new(super::Settings::default()));
    // rust: hub
}

    // The table a server with transfers on keeps.
table :: proc(hub: ^Hub) -> s {
    // Ported from Horizon
    return {}
}
    // rust: hub.transfers.as_ref().unwrap().table()
}

    // A guest in the overworld and the end of the channel its packets go to.
guest :: proc(conn: u32, uuid: u128, name: string) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let (tx, rx) = channel();
    // rust: let mut g = Guest::new(
    // rust: Joined {
    // rust: conn,
    // rust: uuid,
    // rust: name: name.into(),
    // rust: properties: Vec::new(),
    // rust: info: horizon_protocol::packets::configuration::ClientInformation::new(4),
    // rust: brand: "vanilla".into(),
    // rust: sender: PlayerSender::new(tx, std::sync::Arc::default()),
    // rust: latency: std::sync::Arc::new(std::sync::atomic::AtomicI32::new(0)),
    // rust: address: "127.0.0.1:25565".parse().unwrap(),
    // rust: expected: false,
    // rust: },
    // rust: conn as i32,
    // rust: [0.5, 64.0, 0.5],
    // rust: 4,
    // rust: );
    // rust: g.dimension = "minecraft:overworld".into();
    // rust: (g, rx)
}

    // The packets waiting in a channel, in order, each as its id and payload.
packets :: proc(rx: ^Receiver<Out>) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::new();
    // rust: let mut one = |body: &[u8]| {
    // rust: let mut r = horizon_protocol::buf::Reader::new(body);
    // rust: let id = r.varint().unwrap();
    // rust: out.push((id, r.rest().to_vec()));
}
    // rust: while let Ok(o) = rx.try_recv() {
    // rust: match o {
    // rust: Out::Packet(b) => one(&b),
    // rust: Out::Packets(bs) => bs.iter().for_each(|b| one(b)),
    // rust: _ => {}
}
}
    // rust: out
}

    // The ids of the packets waiting in a channel, in order.
ids :: proc(rx: ^Receiver<Out>) -> V {
    // Ported from Horizon
    return {}
}
    // rust: packets(rx).into_iter().map(|(id, _)| id).collect()
}

    // What the network thread does as a login starts (`lan/conn.rs`): the login
    // uses up the player's expectation, if there is one.
login_starts :: proc(hub: ^Hub, uuid: u128) {
}
    // rust: let taken = table(hub).take(uuid, Instant::now());
    // rust: if let Some(g) = hub.guests.iter_mut().find(|g| g.uuid == uuid) {
    // rust: g.expected = taken;
}
}

place :: proc(hub: ^Hub, conn: u32) {
}
    // rust: let mut world = crate::world::World::new(horizon_world::registry::BlockStateId(0), 0);
    // rust: let border = crate::worldborder::WorldBorder::default();
    // rust: let mut next = 100;
    // rust: let mut ctx = TickCtx {
    // rust: world: &mut world,
    // rust: entities: &[],
    // rust: next_entity: &mut next,
    // rust: spawn: [0.5, 64.0, 0.5],
    // rust: difficulty: 2,
    // rust: difficulty_locked: false,
    // rust: clock_rate: 1.0,
    // rust: tick_rate: 20.0,
    // rust: tick_frozen: false,
    // rust: tick_steps: Default::default(),
    // rust: collision: None,
    // rust: border: &border,
    // rust: streaming: None,
}
    // rust: hub.place_new_player(conn, &mut ctx);
}

    // rust: fn tick_context<'a>(
    // rust: world: &'a mut crate::world::World,
    // rust: border: &'a crate::worldborder::WorldBorder,
    // rust: next: &'a mut u32,
    // rust: ) -> TickCtx<'a> {
    // rust: TickCtx {
    // rust: world,
    // rust: entities: &[],
    // rust: next_entity: next,
    // rust: spawn: [0.5, 64.0, 0.5],
    // rust: difficulty: 2,
    // rust: difficulty_locked: false,
    // rust: clock_rate: 1.0,
    // rust: tick_rate: 20.0,
    // rust: tick_frozen: false,
    // rust: tick_steps: Default::default(),
    // rust: collision: None,
    // rust: border,
    // rust: streaming: None,
}
}

is_warn :: proc(event: ^crate::lan::hub::HostEvent, needle: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(event, crate::lan::hub::HostEvent::Warn(w) if w.contains(needle))
}

    // An expectation nobody came for is reported once and forgotten.
an_expectation_nobody_came_for_is_reported_and_swept :: proc() {
}
    // rust: let mut hub = hub();
        // Already past its time when the hub next ticks.
    // rust: table(&hub)
    // rust: .expect(7, Duration::ZERO, Instant::now())
    // rust: .unwrap();
    // rust: let mut world = crate::world::World::new(horizon_world::registry::BlockStateId(0), 0);
    // rust: let border = crate::worldborder::WorldBorder::default();
    // rust: let mut next = 100;
    // rust: let mut ctx = tick_context(&mut world, &border, &mut next);
    // rust: let events = hub.poll(&mut ctx);
    // rust: assert_eq!(
    // rust: events.iter().filter(|e| is_warn(e, "never came")).count(),
    // rust: 1
    // rust: );
    // rust: assert!(table(&hub).is_empty());
}

    // The control: a player nobody expected is announced as always, to the
    // others by a chat line and a player-list entry.
an_ordinary_login_is_announced_to_the_others :: proc() {
}
    // rust: let mut hub = hub();
    // rust: let (mut watcher, seen) = guest(1, 1, "Watcher");
    // rust: watcher.placed = true;
    // rust: hub.guests.push(watcher);
    // rust: let (newcomer, mine) = guest(2, 2, "Newcomer");
    // rust: hub.guests.push(newcomer);
    // rust: place(&mut hub, 2);
    // rust: let told = ids(&seen);
    // rust: assert!(told.contains(&id::SYSTEM_CHAT), "{told:?}");
    // rust: assert!(told.contains(&id::PLAYER_INFO_UPDATE), "{told:?}");
    // rust: assert!(hub.guests[1].placed && !hub.guests[1].held);
    // rust: assert_eq!(ids(&mine)[0], id::LOGIN);
}

    // A player the proxy announced is held: it gets the whole join sequence,
    // and the player already there is told nothing at all.
an_expected_player_is_held_and_no_one_else_hears_of_it :: proc() {
}
    // rust: let mut hub = hub();
    // rust: let (mut watcher, seen) = guest(1, 1, "Watcher");
    // rust: watcher.placed = true;
    // rust: hub.guests.push(watcher);
    // rust: let (newcomer, mine) = guest(2, 2, "Newcomer");
    // rust: hub.guests.push(newcomer);
    // rust: table(&hub)
    // rust: .expect(2, Duration::from_secs(10), Instant::now())
    // rust: .unwrap();
    // rust: login_starts(&mut hub, 2);
    // rust: place(&mut hub, 2);
    // rust: assert_eq!(
    // rust: ids(&seen),
    // rust: Vec::<i32>::new(),
    // rust: "the watcher must hear nothing"
    // rust: );
    // rust: let g = &hub.guests[1];
    // rust: assert!(g.held && !g.placed);
    // rust: assert!(table(&hub).is_empty(), "the login used up the expectation");
    // rust: let sent = ids(&mine);
    // rust: assert_eq!(sent[0], id::LOGIN);
    // rust: for wanted in [id::PLAYER_INFO_UPDATE, id::SET_CHUNK_CACHE_CENTER] {
    // rust: assert!(
    // rust: sent.contains(&wanted),
    // rust: "packet {wanted} missing from {sent:?}"
    // rust: );
}
        // The held player is in its own list but did not announce itself.
    // rust: assert!(!sent.contains(&id::SYSTEM_CHAT), "{sent:?}");
}

    // An expectation is for one player: another uuid logs in as usual.
the_expectation_of_one_player_does_not_hold_another :: proc() {
}
    // rust: let mut hub = hub();
    // rust: let (mut watcher, seen) = guest(1, 1, "Watcher");
    // rust: watcher.placed = true;
    // rust: hub.guests.push(watcher);
    // rust: let (newcomer, _mine) = guest(2, 2, "Newcomer");
    // rust: hub.guests.push(newcomer);
    // rust: table(&hub)
    // rust: .expect(3, Duration::from_secs(10), Instant::now())
    // rust: .unwrap();
    // rust: login_starts(&mut hub, 2);
    // rust: place(&mut hub, 2);
    // rust: assert!(hub.guests[1].placed && !hub.guests[1].held);
    // rust: assert!(ids(&seen).contains(&id::SYSTEM_CHAT));
    // rust: assert_eq!(table(&hub).len(), 1, "the other player is still expected");
}

    // A held player whose hand-over never finishes is dropped after a minute of
    // ticks, and the players in the world are told nothing about it.
a_held_player_that_is_never_imported_is_dropped_without_a_word :: proc() {
}
    // rust: let mut hub = hub();
    // rust: let (mut watcher, seen) = guest(1, 1, "Watcher");
    // rust: watcher.placed = true;
    // rust: hub.guests.push(watcher);
    // rust: let (newcomer, mine) = guest(2, 2, "Newcomer");
    // rust: hub.guests.push(newcomer);
    // rust: table(&hub)
    // rust: .expect(2, Duration::from_secs(10), Instant::now())
    // rust: .unwrap();
    // rust: login_starts(&mut hub, 2);
    // rust: place(&mut hub, 2);
    // rust: let _ = (ids(&seen), ids(&mine));
    // rust: let mut world = crate::world::World::new(horizon_world::registry::BlockStateId(0), 0);
    // rust: let border = crate::worldborder::WorldBorder::default();
    // rust: let mut next = 100;
        // Two ticks short of the limit (poll counts one): still waiting.
    // rust: hub.ticks = hub.guests[1].held_since + super::Settings::default().max_hold_ticks - 2;
    // rust: let mut ctx = tick_context(&mut world, &border, &mut next);
    // rust: let events = hub.poll(&mut ctx);
    // rust: assert!(!events.iter().any(|e| is_warn(e, "dropped")));
        // At the limit it is kicked, with a warning in the log.
    // rust: let events = hub.poll(&mut ctx);
    // rust: assert!(
    // rust: events
    // rust: .iter()
    // rust: .any(|e| is_warn(e, "Newcomer") && is_warn(e, "dropped"))
    // rust: );
    // rust: assert!(matches!(mine.try_recv(), Ok(Out::Disconnect(_))));
        // The connection closes: the hub removes the guest.
    // rust: let gone = hub.remove_guest(1, "Timed out");
    // rust: assert!(gone.held && !gone.placed);
    // rust: assert_eq!(
    // rust: ids(&seen),
    // rust: Vec::<i32>::new(),
    // rust: "the watcher must hear nothing"
    // rust: );
}

    // The control for the one above: when a placed player leaves, the others
    // are told.
a_placed_player_leaving_is_announced :: proc() {
}
    // rust: let mut hub = hub();
    // rust: let (mut watcher, seen) = guest(1, 1, "Watcher");
    // rust: watcher.placed = true;
    // rust: hub.guests.push(watcher);
    // rust: let (mut leaver, _mine) = guest(2, 2, "Leaver");
    // rust: leaver.placed = true;
    // rust: hub.guests.push(leaver);
    // rust: hub.remove_guest(1, "bye");
    // rust: let told = ids(&seen);
    // rust: assert!(told.contains(&id::PLAYER_INFO_REMOVE), "{told:?}");
    // rust: assert!(told.contains(&id::SYSTEM_CHAT), "{told:?}");
}

    // A held player is sent the chunks and the entities around it, and takes
    // nothing from the players in the world: they still get their chunks, and
    // never learn the held player's entity.
a_held_player_sees_the_world_without_the_world_seeing_it :: proc() {
}
    // rust: let mut hub = hub();
    // rust: let mut world = crate::world::World::new(horizon_world::registry::BlockStateId(0), 0);
    // rust: for x in -5..=5 {
    // rust: for z in -5..=5 {
                // Only a lit column is sent.
    // rust: let mut chunk = crate::chunk::Chunk::empty(x, z);
    // rust: chunk.lit = true;
    // rust: world.chunks.insert((x, z), std::sync::Arc::new(chunk));
}
}
    // rust: let border = crate::worldborder::WorldBorder::default();
    // rust: let (mut watcher, seen) = guest(1, 1, "Watcher");
    // rust: watcher.placed = true;
    // rust: hub.guests.push(watcher);
    // rust: let (newcomer, mine) = guest(2, 2, "Newcomer");
    // rust: hub.guests.push(newcomer);
        // A second player in the world, to show that players are tracked at all.
    // rust: let (mut other, _other_rx) = guest(3, 3, "Other");
    // rust: other.placed = true;
    // rust: hub.guests.push(other);
    // rust: table(&hub)
    // rust: .expect(2, Duration::from_secs(10), Instant::now())
    // rust: .unwrap();
    // rust: login_starts(&mut hub, 2);
    // rust: place(&mut hub, 2);
        // The server has run a few ticks since they joined.
    // rust: hub.ticks = 10;
    // rust: let mut next = 100;
    // rust: let mut ctx = tick_context(&mut world, &border, &mut next);
    // rust: let (mut held_chunks, mut watcher_chunks) = (0, 0);
    // rust: let (mut held_adds, mut watcher_adds) = (Vec::new(), Vec::new());
    // rust: for _ in 0..30 {
    // rust: hub.tick_level(&mut ctx);
    // rust: hub.end_tick();
    // rust: let mine_now = packets(&mine);
    // rust: let seen_now = packets(&seen);
    // rust: held_chunks += mine_now
    // rust: .iter()
    // rust: .filter(|p| p.0 == id::LEVEL_CHUNK_WITH_LIGHT)
    // rust: .count();
    // rust: watcher_chunks += seen_now
    // rust: .iter()
    // rust: .filter(|p| p.0 == id::LEVEL_CHUNK_WITH_LIGHT)
    // rust: .count();
    // rust: held_adds.extend(added_of(&mine_now));
    // rust: watcher_adds.extend(added_of(&seen_now));
}
    // rust: assert!(
    // rust: held_chunks > 0,
    // rust: "the held player is sent chunks (held {held_chunks}, watcher {watcher_chunks})"
    // rust: );
    // rust: assert!(watcher_chunks > 0, "the placed player is still sent chunks");
    // rust: assert!(
    // rust: watcher_adds.contains(&3),
    // rust: "players are tracked at all: {watcher_adds:?}"
    // rust: );
    // rust: assert!(
    // rust: held_adds.contains(&1),
    // rust: "the held player sees the watcher: {held_adds:?}"
    // rust: );
    // rust: assert!(
    // rust: !watcher_adds.contains(&2),
    // rust: "the watcher must not see the held player: {watcher_adds:?}"
    // rust: );
}

    // The entity ids in the Add Entity packets among some packets.
added_of :: proc(packets: ^[(i32) {
}
    // rust: packets
    // rust: .iter()
    // rust: .filter(|(i, _)| *i == id::ADD_ENTITY)
    // rust: .map(|(_, payload)| {
    // rust: horizon_protocol::buf::Reader::new(payload)
    // rust: .varint()
    // rust: .unwrap()
    // rust: })
    // rust: .collect()
}

    // A held player's acknowledgements are handled (they keep the chunks
    // coming), and nothing else it sends reaches the world.
a_held_player_is_heard_only_when_it_acknowledges :: proc() {
}
//         use horizon_protocol::packets::play::{ChunkBatchReceived, MovePlayerPos, Serverbound};
    // rust: let mut hub = hub();
    // rust: let (newcomer, _mine) = guest(2, 2, "Newcomer");
    // rust: hub.guests.push(newcomer);
    // rust: table(&hub)
    // rust: .expect(2, Duration::from_secs(10), Instant::now())
    // rust: .unwrap();
    // rust: login_starts(&mut hub, 2);
    // rust: place(&mut hub, 2);
    // rust: let g = &mut hub.guests[0];
    // rust: g.unacknowledged = 3;
    // rust: let before = g.position;
    // rust: g.inbox.push_back((
    // rust: Serverbound::MovePlayerPos(MovePlayerPos {
    // rust: x: before[0] + 40.0,
    // rust: y: before[1],
    // rust: z: before[2],
    // rust: flags: 1,
    // rust: }),
    // rust: 10,
    // rust: ));
    // rust: g.inbox.push_back((
    // rust: Serverbound::ChunkBatchReceived(ChunkBatchReceived {
    // rust: chunks_per_tick: 12.0,
    // rust: }),
    // rust: 5,
    // rust: ));
    // rust: g.inbox_bytes = 15;
    // rust: let mut world = crate::world::World::new(horizon_world::registry::BlockStateId(0), 0);
    // rust: let border = crate::worldborder::WorldBorder::default();
    // rust: let mut next = 100;
    // rust: let mut ctx = tick_context(&mut world, &border, &mut next);
    // rust: hub.drain_packets(&mut ctx);
    // rust: let g = &hub.guests[0];
    // rust: assert_eq!(g.position, before, "a held player does not move");
    // rust: assert_eq!(g.unacknowledged, 2, "its acknowledgement was handled");
    // rust: assert_eq!(g.chunks_per_tick, 12.0);
    // rust: assert_eq!(g.inbox_bytes, 0);
}

UUID :: "123e4567-e89b-12d3-a456-426614174000"
UUID_N :: 0x123e4567_e89b_12d3_a456_426614174000

a_unique_id_is_read_with_or_without_dashes_and_nothing_else :: proc() {
}
    // rust: assert_eq!(super::parse_uuid(UUID), Some(UUID_N));
    // rust: assert_eq!(
    // rust: super::parse_uuid("123e4567e89b12d3a456426614174000"),
    // rust: Some(UUID_N)
    // rust: );
    // rust: assert_eq!(
    // rust: super::parse_uuid("123E4567-E89B-12D3-A456-426614174000"),
    // rust: Some(UUID_N)
    // rust: );
    // rust: assert_eq!(
    // rust: super::parse_uuid("123e4567-e89b-12d3-a456-42661417400"),
    // rust: None
    // rust: );
    // rust: assert_eq!(
    // rust: super::parse_uuid("123e4567-e89b-12d3-a456-42661417400g"),
    // rust: None
    // rust: );
    // rust: assert_eq!(super::parse_uuid(""), None);
}

player_expect_records_the_player_and_says_for_how_long :: proc() {
}
    // rust: let mut hub = hub();
    // rust: let now = Instant::now();
    // rust: let reply = super::expect_request(&mut hub, UUID, now);
    // rust: assert_eq!(reply["ok"], true);
    // rust: assert_eq!(reply["renewed"], false);
    // rust: assert_eq!(reply["ttl_seconds"], 10);
        // Asking again renews, with the time asked.
    // rust: let reply = super::expect_request(&mut hub, &format!("{UUID} 30"), now);
    // rust: assert_eq!(
    // rust: (reply["renewed"].as_bool(), reply["ttl_seconds"].as_u64()),
    // rust: (Some(true), Some(30))
    // rust: );
        // A time past the maximum is cut, and the reply says what it became.
    // rust: let reply = super::expect_request(&mut hub, &format!("{UUID} 3600"), now);
    // rust: assert_eq!(reply["ttl_seconds"], 60);
    // rust: assert_eq!(table(&hub).len(), 1);
    // rust: assert!(table(&hub).take(UUID_N, now));
        // The default time is the server's own.
    // rust: hub.transfers = Some(super::Transfers::new(super::Settings {
    // rust: expect: Duration::from_secs(4),
    // rust: ..super::Settings::default()
    // rust: }));
    // rust: let reply = super::expect_request(&mut hub, UUID, now);
    // rust: assert_eq!(reply["ttl_seconds"], 4);
}

player_expect_refuses_what_it_cannot_do_and_changes_nothing :: proc() {
}
    // rust: let mut hub = hub();
    // rust: let now = Instant::now();
    // rust: for args in [
    // rust: "",
    // rust: "not-a-uuid",
    // rust: &format!("{UUID} 0"),
    // rust: &format!("{UUID} soon"),
    // rust: &format!("{UUID} 5 6"),
    // rust: ] {
    // rust: let reply = super::expect_request(&mut hub, args, now);
    // rust: assert!(reply["error"].is_string(), "{args:?} gave {reply}");
}
        // A player who is on the server already cannot be expected.
    // rust: let (online, _rx) = guest(1, UUID_N, "Online");
    // rust: hub.guests.push(online);
    // rust: let reply = super::expect_request(&mut hub, UUID, now);
    // rust: assert!(
    // rust: reply["error"]
    // rust: .as_str()
    // rust: .unwrap()
    // rust: .contains("already connected"),
    // rust: "{reply}"
    // rust: );
    // rust: assert!(table(&hub).is_empty());
}

player_expect_refuses_when_the_table_is_full :: proc() {
}
    // rust: let mut hub = hub();
    // rust: let now = Instant::now();
    // rust: for n in 0..super::Settings::default().max_expected as u128 {
    // rust: let reply = super::expect_request(&mut hub, &format!("{:032x}", 1000 + n), now);
    // rust: assert_eq!(reply["ok"], true);
}
    // rust: let reply = super::expect_request(&mut hub, UUID, now);
    // rust: assert!(
    // rust: reply["error"].as_str().unwrap().contains("too many"),
    // rust: "{reply}"
    // rust: );
}

    // Dropping a held player disconnects it and says nothing to the world.
player_drop_removes_a_held_player_without_a_word_to_anyone :: proc() {
}
    // rust: let mut hub = hub();
    // rust: let (mut watcher, seen) = guest(1, 1, "Watcher");
    // rust: watcher.placed = true;
    // rust: hub.guests.push(watcher);
        // The proxy announces the player first; then the player logs in.
    // rust: assert_eq!(
    // rust: super::expect_request(&mut hub, UUID, Instant::now())["ok"],
    // rust: true
    // rust: );
    // rust: let (newcomer, mine) = guest(2, UUID_N, "Newcomer");
    // rust: hub.guests.push(newcomer);
    // rust: login_starts(&mut hub, UUID_N);
    // rust: place(&mut hub, 2);
    // rust: let _ = (ids(&seen), ids(&mine));
    // rust: let reply = super::drop_request(&mut hub, UUID);
    // rust: assert_eq!(
    // rust: (reply["held"].as_bool(), reply["expected"].as_bool()),
    // rust: (Some(true), Some(false))
    // rust: );
    // rust: assert!(matches!(mine.try_recv(), Ok(Out::Disconnect(_))));
        // The connection closes and the hub forgets the guest.
    // rust: let gone = hub.remove_guest(1, "dropped");
    // rust: assert!(gone.held && !gone.placed);
    // rust: assert_eq!(
    // rust: ids(&seen),
    // rust: Vec::<i32>::new(),
    // rust: "the watcher must hear nothing"
    // rust: );
}

player_drop_forgets_an_expectation_and_refuses_a_stranger :: proc() {
}
    // rust: let mut hub = hub();
    // rust: super::expect_request(&mut hub, UUID, Instant::now());
    // rust: let reply = super::drop_request(&mut hub, UUID);
    // rust: assert_eq!(
    // rust: (reply["held"].as_bool(), reply["expected"].as_bool()),
    // rust: (Some(false), Some(true))
    // rust: );
    // rust: assert!(table(&hub).is_empty());
    // rust: let reply = super::drop_request(&mut hub, UUID);
    // rust: assert!(reply["error"].is_string(), "{reply}");
    // rust: assert!(super::drop_request(&mut hub, "nonsense")["error"].is_string());
}

    // A placed player cannot be dropped this way: only a held one.
player_drop_leaves_a_placed_player_alone :: proc() {
}
    // rust: let mut hub = hub();
    // rust: let (mut here, rx) = guest(1, UUID_N, "Here");
    // rust: here.placed = true;
    // rust: hub.guests.push(here);
    // rust: let reply = super::drop_request(&mut hub, UUID);
    // rust: assert!(reply["error"].is_string(), "{reply}");
    // rust: assert!(
    // rust: rx.try_recv().is_err(),
    // rust: "a placed player must not be disconnected"
    // rust: );
}

    // The keys a vanilla server writes in every player's file, read with `javap` from the
    // 26.3 server jar: `Player.addAdditionalSaveData` (Inventory, SelectedItemSlot,
    // EnderItems, XpLevel, XpP, XpTotal, XpSeed, abilities), `FoodData` (foodLevel,
    // foodSaturationLevel, foodExhaustionLevel, foodTickTimer), `ServerPlayer` (Dimension),
    // `Entity.saveWithoutId` (Pos, Motion, Rotation, OnGround, Air, Fire) and
    // `LivingEntity` (Health, AbsorptionAmount).
    // rust: const VANILLA_PLAYER_KEYS: [&str; 21] = [
    // rust: "Inventory",
    // rust: "SelectedItemSlot",
    // rust: "EnderItems",
    // rust: "XpLevel",
    // rust: "XpP",
    // rust: "XpTotal",
    // rust: "XpSeed",
    // rust: "abilities",
    // rust: "foodLevel",
    // rust: "foodSaturationLevel",
    // rust: "foodExhaustionLevel",
    // rust: "foodTickTimer",
    // rust: "Dimension",
    // rust: "Pos",
    // rust: "Motion",
    // rust: "Rotation",
    // rust: "OnGround",
    // rust: "Air",
    // rust: "Fire",
    // rust: "Health",
    // rust: "AbsorptionAmount",
    // rust: ];

    // A guest standing at a known place with known values.
exported_guest :: proc() -> ( {
    // Ported from Horizon
    return {}
}
//         use crate::items::ItemStack;
    // rust: let mut hub = hub();
    // rust: let (mut g, _rx) = guest(5, UUID_N, "Alex");
    // rust: g.placed = true;
    // rust: g.position = [10.5, 70.0, -3.25];
    // rust: g.yaw = 90.0;
    // rust: g.pitch = 15.0;
    // rust: g.health = 14.0;
    // rust: g.food = 12;
    // rust: g.xp_level = 7;
    // rust: g.game_mode = 1;
    // rust: g.selected = 3;
    // rust: g.inventory[0] = Some(ItemStack {
    // rust: item: std::sync::Arc::from("minecraft:stone"),
    // rust: count: 5,
    // rust: damage: 0,
    // rust: extra: None,
    // rust: });
    // rust: hub.guests.push(g);
    // rust: (hub, 0)
}

    // Decodes the compound of a record back into its tag.
compound_of :: proc(record: ^serde_json::Value) -> h {
    // Ported from Horizon
    return {}
}
//         use horizon_world::nbt::{Limits, read_named};
    // rust: let bytes = crate::skins::base64_decode(record["player"].as_str().unwrap()).unwrap();
    // rust: read_named(&bytes, Limits::saved()).unwrap().0.tag
}

a_player_who_cannot_be_exported_is_refused_with_the_reason :: proc() {
}
    // rust: let mut hub = hub();
    // rust: let expect = |hub: &Hub| super::check_exportable(hub, UUID_N);
    // rust: assert_eq!(
    // rust: expect(&hub),
    // rust: Err("that player is not connected to this server")
    // rust: );
    // rust: let (g, _rx) = guest(5, UUID_N, "Alex");
    // rust: hub.guests.push(g);
    // rust: assert_eq!(expect(&hub), Err("that player has not finished joining"));
    // rust: hub.guests[0].placed = true;
    // rust: assert_eq!(expect(&hub), Ok(0));
    // rust: hub.guests[0].vehicle = Some(77);
    // rust: assert_eq!(expect(&hub), Err("that player is riding"));
    // rust: hub.guests[0].vehicle = None;
    // rust: hub.guests[0].sleeping = true;
    // rust: assert_eq!(expect(&hub), Err("that player is asleep"));
    // rust: hub.guests[0].sleeping = false;
    // rust: hub.guests[0].dead = true;
    // rust: assert_eq!(expect(&hub), Err("that player is dead"));
    // rust: hub.guests[0].dead = false;
    // rust: hub.guests[0].placed = false;
    // rust: hub.guests[0].held = true;
    // rust: assert_eq!(
    // rust: expect(&hub),
    // rust: Err("that player is held: it has not been handed over yet")
    // rust: );
}

the_record_carries_what_a_proxy_reads_and_the_vanilla_player_compound :: proc() {
}
//         use crate::save::{float, number};
    // rust: let (mut hub, i) = exported_guest();
    // rust: let records = super::Records {
    // rust: advancements: serde_json::json!({"done": []}),
    // rust: stats: serde_json::json!({"stats": {"minecraft:custom": {"minecraft:jump": 3}}}),
}
    // rust: let record = super::export_record(&mut hub, i, false, records).unwrap();
    // rust: assert_eq!(record["version"], 1);
    // rust: assert_eq!(record["data_version"], horizon_world::DATA_VERSION);
    // rust: assert_eq!(record["uuid"], UUID);
    // rust: assert_eq!(record["name"], "Alex");
    // rust: assert_eq!(record["dimension"], "minecraft:overworld");
    // rust: assert_eq!(record["position"], serde_json::json!([10.5, 70.0, -3.25]));
    // rust: assert_eq!(record["rotation"], serde_json::json!([90.0, 15.0]));
    // rust: assert_eq!(record["game_mode"], 1);
    // rust: assert_eq!(record["advancements"], serde_json::json!({"done": []}));
    // rust: assert_eq!(
    // rust: record["stats"]["stats"]["minecraft:custom"]["minecraft:jump"],
    // rust: 3
    // rust: );
        // A read, not a hand-over: no id, and the player goes on.
    // rust: assert_eq!(record["handover"], serde_json::Value::Null);
    // rust: assert_eq!(hub.guests[i].handover, None, "no freeze was asked for");

    // rust: let tag = compound_of(&record);
    // rust: for key in VANILLA_PLAYER_KEYS {
    // rust: assert!(tag.get(key).is_some(), "the compound has no {key}");
}
    // rust: assert_eq!(number(tag.get("XpLevel")), Some(7));
    // rust: assert_eq!(number(tag.get("foodLevel")), Some(12));
    // rust: assert_eq!(number(tag.get("SelectedItemSlot")), Some(3));
    // rust: assert_eq!(float(tag.get("Health")), Some(14.0));
    // rust: let horizon_world::nbt::Tag::String(dimension) = tag.get("Dimension").unwrap() else {
    // rust: panic!("Dimension is not a string");
}
    // rust: assert_eq!(dimension.to_string_lossy(), "minecraft:overworld");
        // The stone in the first slot, as vanilla writes a stack: Slot, id, count.
    // rust: let horizon_world::nbt::Tag::List(items) = tag.get("Inventory").unwrap() else {
    // rust: panic!("Inventory is not a list");
}
    // rust: let first = &items[0];
    // rust: assert_eq!(number(first.get("Slot")), Some(0));
    // rust: assert_eq!(number(first.get("count")), Some(5));
}

    // A frozen player's inputs are not acted on, its acknowledgements are, and a freeze
    // nobody finishes is let go.
a_frozen_player_is_inert_until_it_is_let_go :: proc() {
}
//         use horizon_protocol::packets::play::{ChunkBatchReceived, MovePlayerPos, Serverbound};
    // rust: let (mut hub, i) = exported_guest();
    // rust: let record = super::export_record(&mut hub, i, true, Default::default()).unwrap();
    // rust: let handover = hub.guests[i].handover.clone().unwrap();
    // rust: assert_eq!(handover.since, hub.ticks);
    // rust: assert_eq!(
    // rust: record["handover"].as_str(),
    // rust: Some(super::handover_text(handover.id).as_str())
    // rust: );
    // rust: let before = hub.guests[i].position;
    // rust: let g = &mut hub.guests[i];
    // rust: g.unacknowledged = 2;
    // rust: g.inbox.push_back((
    // rust: Serverbound::MovePlayerPos(MovePlayerPos {
    // rust: x: before[0] + 30.0,
    // rust: y: before[1],
    // rust: z: before[2],
    // rust: flags: 1,
    // rust: }),
    // rust: 10,
    // rust: ));
    // rust: g.inbox.push_back((
    // rust: Serverbound::ChunkBatchReceived(ChunkBatchReceived {
    // rust: chunks_per_tick: 9.0,
    // rust: }),
    // rust: 5,
    // rust: ));
    // rust: g.inbox_bytes = 15;
    // rust: let mut world = crate::world::World::new(horizon_world::registry::BlockStateId(0), 0);
    // rust: let border = crate::worldborder::WorldBorder::default();
    // rust: let mut next = 100;
    // rust: let mut ctx = tick_context(&mut world, &border, &mut next);
    // rust: hub.drain_packets(&mut ctx);
    // rust: assert_eq!(
    // rust: hub.guests[i].position, before,
    // rust: "a frozen player does not move"
    // rust: );
    // rust: assert_eq!(
    // rust: hub.guests[i].unacknowledged, 1,
    // rust: "its acknowledgement was handled"
    // rust: );
        // Nobody finishes the hand-over: thirty seconds of ticks later it is let go.
    // rust: let max = super::Settings::default().max_freeze_ticks;
    // rust: hub.ticks = handover.since + max - 2;
    // rust: assert!(!hub.poll(&mut ctx).iter().any(|e| is_warn(e, "frozen")));
    // rust: assert!(hub.guests[i].handover.is_some());
    // rust: assert!(hub.poll(&mut ctx).iter().any(|e| is_warn(e, "frozen")));
    // rust: assert_eq!(hub.guests[i].handover, None, "the hand-over is over");
}

the_freeze_lasts_the_settings_ticks :: proc() {
}
    // rust: assert_eq!(super::Settings::default().max_freeze_ticks, 600);
    // rust: assert!(!super::frozen_too_long(10, 10 + 599, 600));
    // rust: assert!(super::frozen_too_long(10, 10 + 600, 600));
    // rust: assert!(!super::frozen_too_long(500, 100, 600));
    // rust: assert!(super::frozen_too_long(10, 50, 40));
}

    // A proxy that lost the reply asks again: the same hand-over, the same
    // bytes, and the freeze is not restarted, however the player changed since.
a_repeated_export_answers_with_the_first_record :: proc() {
}
    // rust: let (mut hub, i) = exported_guest();
    // rust: let first = super::export_record(&mut hub, i, true, Default::default()).unwrap();
    // rust: let since = hub.guests[i].handover.as_ref().unwrap().since;
    // rust: hub.ticks += 50;
    // rust: hub.guests[i].health = 3.0;
    // rust: hub.guests[i].position[0] += 4.0;
    // rust: for freeze in [true, false] {
    // rust: let again = super::export_record(&mut hub, i, freeze, Default::default()).unwrap();
    // rust: assert_eq!(
    // rust: serde_json::to_string(&again).unwrap(),
    // rust: serde_json::to_string(&first).unwrap()
    // rust: );
}
    // rust: assert_eq!(hub.guests[i].handover.as_ref().unwrap().since, since);
        // The reply says how long the freeze still lasts: 50 ticks have gone.
    // rust: let reply = super::export_reply(&hub, i, first.clone());
    // rust: assert_eq!(reply["freeze_ticks_left"], 550);
    // rust: assert_eq!(reply["record"], first);
        // Once it is over, a new freeze is a new hand-over.
    // rust: hub.guests[i].handover = None;
    // rust: let next = super::export_record(&mut hub, i, true, Default::default()).unwrap();
    // rust: assert_ne!(next["handover"], first["handover"]);
    // rust: assert_eq!(next["position"][0], 14.5);
}

    // A player frozen in the rising part of a jump is not kicked for flying:
    // its moves are dropped, so the last one's floating is stale.
a_frozen_player_is_not_kicked_for_floating :: proc() {
}
    // rust: let (mut hub, i) = exported_guest();
    // rust: super::export_record(&mut hub, i, true, Default::default()).unwrap();
    // rust: hub.guests[i].client_is_floating = true;
    // rust: let mut world = crate::world::World::new(horizon_world::registry::BlockStateId(0), 0);
    // rust: let border = crate::worldborder::WorldBorder::default();
    // rust: let mut next = 100;
    // rust: let mut ctx = tick_context(&mut world, &border, &mut next);
    // rust: for _ in 0..200 {
    // rust: hub.drain_packets(&mut ctx);
}
    // rust: assert_eq!(hub.guests[i].above_ground_ticks, 0);
    // rust: assert!(hub.guests[i].left_reason.is_empty(), "not kicked");
}

    // A frozen player's chat acknowledgements are still taken, in order with
    // its chat message's last-seen update, and the message is dropped without
    // a kick.
a_frozen_player_keeps_acknowledging_chat :: proc() {
}
//         use horizon_protocol::packets::play::{Chat, ChatAck, LastSeenUpdate, Serverbound};
    // rust: let (mut hub, i) = exported_guest();
    // rust: super::export_record(&mut hub, i, true, Default::default()).unwrap();
    // rust: let g = &mut hub.guests[i];
        // One message sent to the player: the window's 21st entry. The ack that
        // comes first drops the oldest, so the message is at index 19 when the
        // chat names it; taken the other way round, index 19 is still empty and
        // the chat fails validation (a kick).
    // rust: g.last_seen
    // rust: .add_pending(&[7; horizon_protocol::secure_chat::SIGNATURE_BYTES]);
    // rust: g.inbox
    // rust: .push_back((Serverbound::ChatAck(ChatAck { offset: 1 }), 2));
    // rust: g.inbox.push_back((
    // rust: Serverbound::Chat(Chat {
    // rust: message: "hello".into(),
    // rust: timestamp: 0,
    // rust: salt: 0,
    // rust: signature: None,
    // rust: last_seen: LastSeenUpdate {
    // rust: offset: 0,
    // rust: acknowledged: [0, 0, 0b1000],
    // rust: checksum: 0,
    // rust: },
    // rust: }),
    // rust: 10,
    // rust: ));
    // rust: g.inbox_bytes = 12;
    // rust: hub.keep_acknowledgements(i, &mut Vec::new());
        // Both were handled here, in the order they came; nothing is left for the inbox.
    // rust: assert!(hub.guests[i].inbox.is_empty());
    // rust: assert_eq!(hub.guests[i].inbox_bytes, 0);
    // rust: assert!(hub.guests[i].left_reason.is_empty(), "not kicked");
    // rust: assert_eq!(hub.guests[i].last_seen.tracked_count(), 20);
}

    // ---- player-release ------------------------------------------------------

    // A watcher and a placed player frozen for a hand-over, and the hand-over's id.
frozen_with_a_watcher :: proc() -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let mut hub = hub();
    // rust: let (mut watcher, seen) = guest(1, 1, "Watcher");
    // rust: watcher.placed = true;
    // rust: hub.guests.push(watcher);
    // rust: let (mut mover, mine) = guest(2, UUID_N, "Mover");
    // rust: mover.placed = true;
    // rust: hub.guests.push(mover);
    // rust: hub.ticks = 50;
    // rust: let record = super::export_record(&mut hub, 1, true, Default::default()).unwrap();
    // rust: let handover = record["handover"].as_str().unwrap().to_owned();
    // rust: let _ = (ids(&seen), ids(&mine));
    // rust: (hub, seen, mine, handover)
}

poll :: proc(hub: ^Hub) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut world = crate::world::World::new(horizon_world::registry::BlockStateId(0), 0);
    // rust: let border = crate::worldborder::WorldBorder::default();
    // rust: let mut next = 100;
    // rust: let mut ctx = tick_context(&mut world, &border, &mut next);
    // rust: hub.poll(&mut ctx)
}

left_events :: proc(hub: ^Hub) -> V {
    // Ported from Horizon
    return {}
}
    // rust: poll(hub)
    // rust: .into_iter()
    // rust: .filter_map(|e| match e {
    // rust: crate::lan::hub::HostEvent::Left(g) => Some(*g),
    // rust: _ => None,
    // rust: })
    // rust: .collect()
}

    // Moved to another server: the others see it go, but nothing is said and nothing saved.
a_moved_player_leaves_the_world_without_the_leave_line_and_is_not_saved :: proc() {
}
    // rust: let (mut hub, seen, mine, h) = frozen_with_a_watcher();
    // rust: let reply = super::release_request(&mut hub, &format!("{UUID} {h} moved"));
    // rust: assert_eq!(
    // rust: reply,
    // rust: serde_json::json!({"ok": true, "released": "moved", "announced": false})
    // rust: );
    // rust: assert_eq!(hub.guests.len(), 1, "the mover is out of the hub");
    // rust: let told = ids(&seen);
    // rust: assert!(told.contains(&id::PLAYER_INFO_REMOVE), "{told:?}");
    // rust: assert!(told.contains(&id::REMOVE_ENTITIES), "{told:?}");
    // rust: assert!(!told.contains(&id::SYSTEM_CHAT), "no leave line: {told:?}");
    // rust: assert!(matches!(mine.try_recv(), Ok(Out::Disconnect(_))));
        // The game is told it left, released: it saves no file and no record.
    // rust: let left = left_events(&mut hub);
    // rust: assert_eq!(left.len(), 1);
    // rust: assert!(left[0].released && left[0].placed && left[0].handover.is_none());
    // rust: assert_eq!(left[0].left_reason, "moved to another server");
}

a_moved_player_can_be_announced_as_leaving :: proc() {
}
    // rust: let (mut hub, seen, _mine, h) = frozen_with_a_watcher();
    // rust: let reply = super::release_request(&mut hub, &format!("{UUID} {h} moved announce"));
    // rust: assert_eq!(reply["announced"], true);
    // rust: assert!(ids(&seen).contains(&id::SYSTEM_CHAT));
}

an_aborted_hand_over_lets_the_player_go_on_as_it_was :: proc() {
}
    // rust: let (mut hub, seen, mine, h) = frozen_with_a_watcher();
    // rust: let reply = super::release_request(&mut hub, &format!("{UUID} {h} abort"));
    // rust: assert_eq!(reply, serde_json::json!({"ok": true, "released": "abort"}));
    // rust: assert_eq!(hub.guests.len(), 2);
    // rust: assert!(hub.guests[1].handover.is_none() && hub.guests[1].placed);
    // rust: assert_eq!(ids(&seen), Vec::<i32>::new());
    // rust: assert_eq!(ids(&mine), Vec::<i32>::new());
    // rust: assert!(left_events(&mut hub).is_empty());
        // The hand-over is over: a late `moved` for it is refused.
    // rust: let reply = super::release_request(&mut hub, &format!("{UUID} {h} moved"));
    // rust: assert!(reply["error"].is_string(), "{reply}");
    // rust: assert_eq!(hub.guests.len(), 2);
}

    // A release names the hand-over: one for another (an older one, or one the proxy
    // mixed up) changes nothing.
a_release_for_another_hand_over_is_refused_and_changes_nothing :: proc() {
}
    // rust: let (mut hub, seen, _mine, h) = frozen_with_a_watcher();
    // rust: let rest: String = h.chars().skip(1).collect();
    // rust: let other = format!("{}{rest}", if h.starts_with('0') { '1' } else { '0' });
    // rust: for how in ["moved", "abort"] {
    // rust: let reply = super::release_request(&mut hub, &format!("{UUID} {other} {how}"));
    // rust: assert!(
    // rust: reply["error"]
    // rust: .as_str()
    // rust: .unwrap()
    // rust: .contains("not the player's current hand-over"),
    // rust: "{reply}"
    // rust: );
}
    // rust: assert_eq!(hub.guests.len(), 2);
    // rust: assert!(hub.guests[1].handover.is_some(), "still frozen");
    // rust: assert_eq!(ids(&seen), Vec::<i32>::new());
}

a_release_is_refused_for_a_player_who_is_not_frozen_and_changes_nothing :: proc() {
}
    // rust: let (mut hub, seen, _mine, h) = frozen_with_a_watcher();
    // rust: hub.guests[1].handover = None;
    // rust: for how in ["moved", "abort"] {
    // rust: let reply = super::release_request(&mut hub, &format!("{UUID} {h} {how}"));
    // rust: assert!(
    // rust: reply["error"]
    // rust: .as_str()
    // rust: .unwrap()
    // rust: .contains("not in a hand-over"),
    // rust: "{reply}"
    // rust: );
}
        // Not connected at all.
    // rust: let reply = super::release_request(
    // rust: &mut hub,
    // rust: &format!("00000000000000000000000000000001 {h} moved"),
    // rust: );
    // rust: assert!(reply["error"].is_string());
    // rust: assert_eq!(hub.guests.len(), 2);
    // rust: assert_eq!(ids(&seen), Vec::<i32>::new());
}

a_release_must_say_which_hand_over_how_and_nothing_more :: proc() {
}
    // rust: let (mut hub, _seen, _mine, h) = frozen_with_a_watcher();
    // rust: for args in [
    // rust: String::new(),
    // rust: "nonsense moved".to_owned(),
    // rust: UUID.to_owned(),
    // rust: format!("{UUID} moved"),
    // rust: format!("{UUID} {h}"),
    // rust: format!("{UUID} not-an-id moved"),
    // rust: format!("{UUID} {h} later"),
    // rust: format!("{UUID} {h} moved quietly"),
    // rust: format!("{UUID} {h} abort announce"),
    // rust: format!("{UUID} {h} moved announce now"),
    // rust: ] {
    // rust: let reply = super::release_request(&mut hub, &args);
    // rust: assert!(reply["error"].is_string(), "{args:?} gave {reply}");
}
    // rust: assert!(
    // rust: hub.guests[1].handover.is_some(),
    // rust: "no refusal touched the player"
    // rust: );
}

    // Once the freeze ran out the player played on, and the record the other server has is
    // older than it: a late `moved` is refused, and the proxy fails the hand-over.
a_release_that_comes_after_the_freeze_ran_out_is_refused :: proc() {
}
    // rust: let (mut hub, seen, mine, h) = frozen_with_a_watcher();
    // rust: let since = hub.guests[1].handover.as_ref().unwrap().since;
    // rust: hub.ticks = since + super::Settings::default().max_freeze_ticks;
    // rust: assert!(poll(&mut hub).iter().any(|e| is_warn(e, "frozen")));
    // rust: assert!(hub.guests[1].handover.is_none());
    // rust: let reply = super::release_request(&mut hub, &format!("{UUID} {h} moved"));
    // rust: assert!(
    // rust: reply["error"].as_str().unwrap().contains("freeze ran out"),
    // rust: "{reply}"
    // rust: );
    // rust: assert_eq!(hub.guests.len(), 2, "the player stays");
    // rust: assert!(!ids(&seen).contains(&id::PLAYER_INFO_REMOVE));
    // rust: assert!(!matches!(mine.try_recv(), Ok(Out::Disconnect(_))));
}

    // A frozen player takes no damage, but the void and `/kill` still kill it: its record is
    // then not what is left, so `moved` is refused and the next tick ends the hand-over.
a_player_who_died_while_frozen_cannot_be_released_as_moved :: proc() {
}
    // rust: let (mut hub, _seen, _mine, h) = frozen_with_a_watcher();
    // rust: hub.guests[1].dead = true;
    // rust: let reply = super::release_request(&mut hub, &format!("{UUID} {h} moved"));
    // rust: assert!(reply["error"].as_str().unwrap().contains("died"), "{reply}");
    // rust: assert_eq!(hub.guests.len(), 2);
    // rust: assert!(
    // rust: poll(&mut hub)
    // rust: .iter()
    // rust: .any(|e| is_warn(e, "died while frozen"))
    // rust: );
    // rust: assert!(hub.guests[1].handover.is_none());
}

    // ---- the world is loaded for a held player; how a held player's connection ended --

    // ---- the world loaded around a held player; how its connection ended ----

the_world_is_loaded_around_the_players_placed_and_the_held_ones_only :: proc() {
}
    // rust: let mut hub = hub();
    // rust: let overworld = |mut g: Guest, at: [f64; 3]| {
    // rust: g.position = at;
    // rust: g
}
        // Placed in the level in place.
    // rust: let (mut placed, _a) = guest(1, 1, "Placed");
    // rust: placed.placed = true;
    // rust: hub.guests.push(overworld(placed, [8.0, 64.0, 8.0]));
        // Held: sent the level too, so the level must be loaded around it.
    // rust: let (mut held, _b) = guest(2, 2, "Held");
    // rust: held.held = true;
    // rust: hub.guests.push(overworld(held, [100.5, 64.0, -3.0]));
        // Neither (still logging in): nothing to load for it.
    // rust: let (idle, _c) = guest(3, 3, "Idle");
    // rust: hub.guests.push(overworld(idle, [500.0, 64.0, 500.0]));
        // Placed in another level.
    // rust: let (mut elsewhere, _d) = guest(4, 4, "Elsewhere");
    // rust: elsewhere.placed = true;
    // rust: elsewhere.dimension = "minecraft:the_nether".into();
    // rust: hub.guests.push(overworld(elsewhere, [900.0, 64.0, 900.0]));
    // rust: assert_eq!(hub.loading_chunks(|_| true), vec![(0, 0), (6, -1)]);
        // The caller can leave a player out (a spectator that may not load chunks).
    // rust: assert_eq!(hub.loading_chunks(|g| g.name != "Held"), vec![(0, 0)]);
}

a_dropped_held_player_keeps_how_its_connection_really_ended :: proc() {
}
    // rust: let mut hub = hub();
    // rust: let (mut held, _rx) = guest(2, UUID_N, "Held");
    // rust: held.held = true;
    // rust: hub.guests.push(held);
    // rust: assert!(super::drop_request(&mut hub, UUID)["ok"] == true);
    // rust: let gone = hub.remove_guest(0, "Invalid packet 0: unexpected end of data");
    // rust: assert_eq!(
    // rust: gone.left_reason,
    // rust: "dropped before its hand-over (the connection ended: Invalid packet 0: unexpected end of data)"
    // rust: );
}

a_held_player_whose_connection_ends_by_itself_logs_the_real_reason :: proc() {
}
    // rust: let mut hub = hub();
    // rust: let (mut held, _rx) = guest(2, UUID_N, "Held");
    // rust: held.held = true;
    // rust: hub.guests.push(held);
    // rust: let gone = hub.remove_guest(0, "Invalid packet 0: unexpected end of data");
    // rust: assert_eq!(gone.left_reason, "Invalid packet 0: unexpected end of data");
}

    // The control: a placed player keeps the reason it was kicked with, as vanilla logs it.
a_placed_player_keeps_the_reason_it_was_kicked_with :: proc() {
}
    // rust: let mut hub = hub();
    // rust: let (mut placed, _rx) = guest(2, UUID_N, "Placed");
    // rust: placed.placed = true;
    // rust: placed.left_reason = "Timed out".into();
    // rust: hub.guests.push(placed);
    // rust: let gone = hub.remove_guest(0, "Disconnected");
    // rust: assert_eq!(gone.left_reason, "Timed out");
}

    // ---- the held player's limits and its picture of the others ------------

    // A held player held under the hub's own settings.
held_with_a_watcher :: proc(settings: super::Settings) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let mut hub = hub();
    // rust: hub.transfers = Some(super::Transfers::new(settings));
    // rust: let (mut watcher, seen) = guest(1, 1, "Watcher");
    // rust: watcher.placed = true;
    // rust: hub.guests.push(watcher);
    // rust: table(&hub)
    // rust: .expect(2, Duration::from_secs(10), Instant::now())
    // rust: .unwrap();
    // rust: let (newcomer, mine) = guest(2, 2, "Newcomer");
    // rust: hub.guests.push(newcomer);
    // rust: login_starts(&mut hub, 2);
    // rust: place(&mut hub, 2);
    // rust: assert!(hub.guests[1].held);
    // rust: let _ = (ids(&seen), ids(&mine));
    // rust: (hub, seen, mine)
}

    // `[transfer]`'s `max_hold_seconds` sets the wait, and a held player whose
    // connection is slow to close is kicked and reported once, not on every tick.
a_held_player_waits_the_servers_time_and_is_dropped_once :: proc() {
}
    // rust: let settings = super::Settings {
    // rust: max_hold_ticks: 40,
    // rust: ..super::Settings::default()
}
    // rust: let (mut hub, _seen, _mine) = held_with_a_watcher(settings);
    // rust: let mut world = crate::world::World::new(horizon_world::registry::BlockStateId(0), 0);
    // rust: let border = crate::worldborder::WorldBorder::default();
    // rust: let mut next = 100;
    // rust: let mut ctx = tick_context(&mut world, &border, &mut next);
    // rust: hub.ticks = hub.guests[1].held_since + 38;
    // rust: assert!(!hub.poll(&mut ctx).iter().any(|e| is_warn(e, "dropped")));
    // rust: assert!(hub.poll(&mut ctx).iter().any(|e| is_warn(e, "dropped")));
        // The guest stays until its connection closes: no second kick.
    // rust: assert_eq!(hub.guests.len(), 2);
    // rust: for _ in 0..5 {
    // rust: assert!(!hub.poll(&mut ctx).iter().any(|e| is_warn(e, "dropped")));
}
}

    // A player who joins while another is held is in the held one's list, or
    // the held client drops its entity; and one who leaves goes from that list.
a_held_player_hears_of_the_players_who_join_and_leave :: proc() {
}
    // rust: let (mut hub, seen, mine) = held_with_a_watcher(super::Settings::default());
    // rust: let (late, _late_rx) = guest(3, 3, "Late");
    // rust: hub.guests.push(late);
    // rust: place(&mut hub, 3);
    // rust: let told = ids(&mine);
    // rust: assert!(told.contains(&id::PLAYER_INFO_UPDATE), "{told:?}");
    // rust: assert!(
    // rust: !told.contains(&id::SYSTEM_CHAT),
    // rust: "the held player is not in the chat yet: {told:?}"
    // rust: );
    // rust: let _ = ids(&seen);
    // rust: let i = hub.guests.iter().position(|g| g.uuid == 1).unwrap();
    // rust: hub.remove_guest(i, "Disconnected");
    // rust: let told = ids(&mine);
    // rust: assert!(told.contains(&id::PLAYER_INFO_REMOVE), "{told:?}");
    // rust: assert!(told.contains(&id::REMOVE_ENTITIES), "{told:?}");
}

player_drop_is_refused_with_transfers_off :: proc() {
}
    // rust: let mut hub = hub();
    // rust: hub.transfers = None;
    // rust: assert_eq!(super::drop_request(&mut hub, UUID)["error"], super::OFF);
}

    // ---- player-import ------------------------------------------------------

    // The record of the exported guest, and a second hub in which the same player is held
    // (with a placed watcher), ready to take it.
held_in_a_second_hub :: proc() -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let (mut source, i) = exported_guest();
    // rust: let record = super::export_record(&mut source, i, true, Default::default()).unwrap();
    // rust: let mut hub = hub();
    // rust: let (mut watcher, seen) = guest(1, 1, "Watcher");
    // rust: watcher.placed = true;
    // rust: hub.guests.push(watcher);
    // rust: assert_eq!(
    // rust: super::expect_request(&mut hub, UUID, Instant::now())["ok"],
    // rust: true
    // rust: );
    // rust: let (newcomer, mine) = guest(2, UUID_N, "Alex");
    // rust: hub.guests.push(newcomer);
    // rust: login_starts(&mut hub, UUID_N);
    // rust: place(&mut hub, 2);
    // rust: let _ = (ids(&seen), ids(&mine));
    // rust: (record, hub, seen, mine)
}

    // What the game does with a request (`game/dedicated/transfer.rs`), without the disk: the
    // import, then the placing unless `"place": false`.
    // rust: fn import_player(
    // rust: hub: &mut Hub,
    // rust: uuid: u128,
    // rust: request: &serde_json::Value,
    // rust: ) -> Result<crate::lan::import::Imported, String> {
    // rust: let done = crate::lan::import::import_player(hub, uuid, request)?;
    // rust: if done.place {
    // rust: hub.confirm_arrival(uuid, done.handover)?;
}
    // rust: Ok(done)
}

    // `player-confirm` as the game runs it, without the disk. A request of the unique id alone
    // is given the held player's hand-over id, as a proxy would.
confirm :: proc(hub: ^Hub, args: string) -> s {
    // Ported from Horizon
    return {}
}
    // rust: let mut args = args.to_owned();
    // rust: if let [one] = args.split_whitespace().collect::<Vec<_>>().as_slice()
    // rust: && let Some(id) = super::parse_uuid(one)
    // rust: .and_then(|u| hub.guests.iter().find(|g| g.uuid == u))
    // rust: .and_then(|g| g.arrival_handover)
    // rust: {
    // rust: args = format!("{one} {}", super::handover_text(id));
}
    // rust: match super::confirm_args(hub, &args) {
    // rust: Ok((uuid, id)) => match hub.confirm_arrival(uuid, id) {
    // rust: Ok(announced) => {
    // rust: serde_json::json!({ "ok": true, "placed": true, "announced": announced })
}
    // rust: Err(e) => serde_json::json!({ "error": e }),
    // rust: },
    // rust: Err(e) => serde_json::json!({ "error": e }),
}
}

a_whole_record_makes_the_held_player_the_player_it_was_exported_from :: proc() {
}
    // rust: let (record, mut hub, seen, mine) = held_in_a_second_hub();
    // rust: let (source, i) = exported_guest();
    // rust: let done =
    // rust: import_player(&mut hub, UUID_N, &serde_json::json!({ "record": record })).unwrap();
    // rust: assert_eq!(done.parts.len(), crate::lan::import::PARTS.len());
    // rust: assert!(done.announce);
    // rust: let g = &hub.guests[1];
    // rust: assert!(g.placed && !g.held && g.handover.is_none());
        // The whole player: the compound a save would write is the same one.
    // rust: assert_eq!(
    // rust: crate::lan::playerdata::player_tag(g),
    // rust: crate::lan::playerdata::player_tag(&source.guests[i])
    // rust: );
    // rust: assert_eq!(g.position, [10.5, 70.0, -3.25]);
    // rust: assert_eq!((g.xp_level, g.food, g.game_mode, g.selected), (7, 12, 1, 3));
        // The player already there is told it has come, as for a login.
    // rust: let told = ids(&seen);
    // rust: assert!(told.contains(&id::SYSTEM_CHAT), "{told:?}");
    // rust: assert!(told.contains(&id::PLAYER_INFO_UPDATE), "{told:?}");
        // And the player is told what the import changed.
    // rust: let sent = ids(&mine);
    // rust: for wanted in [
    // rust: id::GAME_EVENT,
    // rust: id::PLAYER_ABILITIES,
    // rust: id::SET_HELD_SLOT,
    // rust: id::PLAYER_POSITION,
    // rust: ] {
    // rust: assert!(
    // rust: sent.contains(&wanted),
    // rust: "packet {wanted} missing from {sent:?}"
    // rust: );
}
}

a_part_that_is_not_asked_for_keeps_what_the_held_player_has :: proc() {
}
    // rust: let (record, mut hub, _seen, _mine) = held_in_a_second_hub();
    // rust: let before = (
    // rust: hub.guests[1].position,
    // rust: hub.guests[1].health,
    // rust: hub.guests[1].xp_level,
    // rust: hub.guests[1].game_mode,
    // rust: );
    // rust: let request =
    // rust: serde_json::json!({ "record": record, "parts": ["inventory", "ender_chest"] });
    // rust: let done = import_player(&mut hub, UUID_N, &request).unwrap();
    // rust: assert_eq!(done.parts, vec!["inventory", "ender_chest"]);
    // rust: let g = &hub.guests[1];
        // Only the inventory came; the position, health, experience and mode are the held player's own.
    // rust: assert_eq!((g.position, g.health, g.xp_level, g.game_mode), before);
    // rust: assert!(
    // rust: g.inventory[0].is_some(),
    // rust: "the stone came with the inventory"
    // rust: );
    // rust: assert_eq!(g.selected, 3);
    // rust: assert!(
    // rust: g.placed && !g.held,
    // rust: "a partial import still lets the player in"
    // rust: );
}

the_parts_come_in_a_fixed_order_whatever_order_they_were_asked_in :: proc() {
}
    // rust: let (record, mut hub, _seen, _mine) = held_in_a_second_hub();
    // rust: let request = serde_json::json!({ "record": record, "parts": ["position", "inventory", "inventory"] });
    // rust: let done = import_player(&mut hub, UUID_N, &request).unwrap();
    // rust: assert_eq!(done.parts, vec!["inventory", "position"]);
}

a_silent_import_tells_no_one :: proc() {
}
    // rust: let (record, mut hub, seen, _mine) = held_in_a_second_hub();
    // rust: let request = serde_json::json!({ "record": record, "announce": false });
    // rust: let done = import_player(&mut hub, UUID_N, &request).unwrap();
    // rust: assert!(!done.announce);
    // rust: assert!(hub.guests[1].placed);
        // No join line, but the list entry: the watcher will be sent the player's entity, and a
        // client adds a player's entity only with its list entry.
    // rust: let told = ids(&seen);
    // rust: assert!(!told.contains(&id::SYSTEM_CHAT), "{told:?}");
    // rust: assert!(told.contains(&id::PLAYER_INFO_UPDATE), "{told:?}");
}

    // Every refusal leaves the held player exactly as it was, and tells the world nothing.
a_record_that_cannot_be_taken_changes_nothing :: proc() {
}
    // rust: let (record, mut hub, seen, mine) = held_in_a_second_hub();
    // rust: let mut cases: Vec<(&str, serde_json::Value)> = Vec::new();
    // rust: let with = |key: &str, value: serde_json::Value| {
    // rust: let mut r = record.clone();
    // rust: r[key] = value;
    // rust: serde_json::json!({ "record": r })
}
    // rust: cases.push(("version", with("version", serde_json::json!(2))));
    // rust: cases.push(("no version", with("version", serde_json::Value::Null)));
    // rust: cases.push(("data version", with("data_version", serde_json::json!(1))));
    // rust: cases.push((
    // rust: "another player",
    // rust: with(
    // rust: "uuid",
    // rust: serde_json::json!("00000000-0000-0000-0000-000000000001"),
    // rust: ),
    // rust: ));
    // rust: cases.push(("not base64", with("player", serde_json::json!("%%%"))));
    // rust: cases.push(("not NBT", with("player", serde_json::json!("AAAA"))));
    // rust: cases.push(("no record", serde_json::json!({})));
    // rust: cases.push((
    // rust: "unknown part",
    // rust: serde_json::json!({ "record": record, "parts": ["luck"] }),
    // rust: ));
    // rust: cases.push((
    // rust: "parts not a list",
    // rust: serde_json::json!({ "record": record, "parts": "all" }),
    // rust: ));
    // rust: cases.push((
    // rust: "announce not a bool",
    // rust: serde_json::json!({ "record": record, "announce": "yes" }),
    // rust: ));
    // rust: let before = crate::lan::playerdata::player_tag(&hub.guests[1]);
    // rust: for (what, request) in &cases {
    // rust: let error = import_player(&mut hub, UUID_N, request).expect_err(what);
    // rust: assert!(!error.is_empty(), "{what}");
    // rust: let g = &hub.guests[1];
    // rust: assert!(g.held && !g.placed, "{what}: the player must still be held");
    // rust: assert_eq!(
    // rust: crate::lan::playerdata::player_tag(g),
    // rust: before,
    // rust: "{what}: nothing may change"
    // rust: );
}
    // rust: assert_eq!(ids(&seen), Vec::<i32>::new());
    // rust: assert_eq!(ids(&mine), Vec::<i32>::new());
}

a_position_in_another_dimension_is_refused_but_the_other_parts_can_come :: proc() {
}
    // rust: let (record, mut hub, _seen, _mine) = held_in_a_second_hub();
        // Make the held player's world the Nether: the record is in the Overworld.
    // rust: hub.guests[1].dimension = "minecraft:the_nether".into();
    // rust: let all = serde_json::json!({ "record": record });
    // rust: let error = import_player(&mut hub, UUID_N, &all).unwrap_err();
    // rust: assert!(error.contains("position cannot be taken"), "{error}");
    // rust: assert!(hub.guests[1].held);
    // rust: let without = serde_json::json!({ "record": record, "parts": ["inventory", "experience"] });
    // rust: import_player(&mut hub, UUID_N, &without).unwrap();
    // rust: assert_eq!(
    // rust: hub.guests[1].dimension, "minecraft:the_nether",
    // rust: "the client's world did not change"
    // rust: );
    // rust: assert_eq!(hub.guests[1].xp_level, 7);
}

only_a_held_player_can_be_imported_into :: proc() {
}
    // rust: let (record, mut hub, _seen, _mine) = held_in_a_second_hub();
    // rust: let request = serde_json::json!({ "record": record });
        // A placed player is not a target.
    // rust: hub.guests[1].held = false;
    // rust: hub.guests[1].placed = true;
    // rust: let error = import_player(&mut hub, UUID_N, &request).unwrap_err();
    // rust: assert!(
    // rust: error.contains("no player with that unique id is held"),
    // rust: "{error}"
    // rust: );
        // Nor a player nobody holds.
    // rust: let mut empty = self::hub();
    // rust: let error = import_player(&mut empty, UUID_N, &request).unwrap_err();
    // rust: assert!(
    // rust: error.contains("no player with that unique id is held"),
    // rust: "{error}"
    // rust: );
}

    // ---- player-import without placing, player-confirm, and the cancel ------

    // rust: fn import_without_placing(
    // rust: request_extra: serde_json::Value,
    // rust: ) -> (Hub, Receiver<Out>, Receiver<Out>) {
    // rust: let (record, mut hub, seen, mine) = held_in_a_second_hub();
    // rust: let mut request = serde_json::json!({ "record": record, "place": false });
    // rust: for (k, v) in request_extra.as_object().unwrap() {
    // rust: request[k] = v.clone();
}
    // rust: let done = import_player(&mut hub, UUID_N, &request).unwrap();
    // rust: assert!(!done.place);
    // rust: (hub, seen, mine)
}

    // The import changes the player and tells its client, but the world still does not know it.
an_import_that_does_not_place_leaves_the_player_held_and_tells_only_its_client :: proc() {
}
    // rust: let (hub, seen, mine) = import_without_placing(serde_json::json!({}));
    // rust: let g = &hub.guests[1];
    // rust: assert!(g.held && !g.placed && g.imported && g.arrival_announce);
    // rust: assert_eq!(
    // rust: (g.xp_level, g.food, g.game_mode, g.position),
    // rust: (7, 12, 1, [10.5, 70.0, -3.25])
    // rust: );
    // rust: assert_eq!(
    // rust: ids(&seen),
    // rust: Vec::<i32>::new(),
    // rust: "the watcher must hear nothing"
    // rust: );
    // rust: let sent = ids(&mine);
    // rust: for wanted in [
    // rust: id::GAME_EVENT,
    // rust: id::PLAYER_ABILITIES,
    // rust: id::SET_HELD_SLOT,
    // rust: id::PLAYER_POSITION,
    // rust: ] {
    // rust: assert!(
    // rust: sent.contains(&wanted),
    // rust: "packet {wanted} missing from {sent:?}"
    // rust: );
}
}

confirming_places_the_player_and_announces_it_as_the_import_asked :: proc() {
}
    // rust: let (mut hub, seen, mine) = import_without_placing(serde_json::json!({}));
    // rust: let _ = ids(&mine);
    // rust: let reply = confirm(&mut hub, UUID);
    // rust: assert_eq!(
    // rust: reply,
    // rust: serde_json::json!({"ok": true, "placed": true, "announced": true})
    // rust: );
    // rust: let g = &hub.guests[1];
    // rust: assert!(g.placed && !g.held && !g.imported);
    // rust: let told = ids(&seen);
    // rust: assert!(
    // rust: told.contains(&id::SYSTEM_CHAT) && told.contains(&id::PLAYER_INFO_UPDATE),
    // rust: "{told:?}"
    // rust: );
        // What the client did since the import was not acted on: it is put back where the
        // server has it, the position to confirm again and the inventory.
    // rust: let sent = ids(&mine);
    // rust: assert!(sent.contains(&id::PLAYER_POSITION), "{sent:?}");
    // rust: assert!(sent.contains(&id::CONTAINER_SET_CONTENT), "{sent:?}");
}

    // The arrival's join line names the player as the server's own join line does: by its
    // nickname and team (Player.getDisplayName), not only by its account name.
the_join_line_of_an_arrival_shows_its_nickname :: proc() {
}
    // rust: let (mut hub, seen, _mine) = import_without_placing(serde_json::json!({}));
    // rust: hub.set_nickname(UUID_N, Some("Captain".into()));
    // rust: let _ = packets(&seen);
    // rust: let reply = confirm(&mut hub, UUID);
    // rust: assert_eq!(reply["placed"], true);
    // rust: let lines: Vec<Vec<u8>> = packets(&seen)
    // rust: .into_iter()
    // rust: .filter(|(id, _)| *id == id::SYSTEM_CHAT)
    // rust: .map(|(_, body)| body)
    // rust: .collect();
    // rust: assert_eq!(lines.len(), 1, "one join line");
    // rust: assert!(
    // rust: lines[0].windows(b"Captain".len()).any(|w| w == b"Captain"),
    // rust: "the join line names the nickname"
    // rust: );
}

a_silent_import_stays_silent_when_it_is_confirmed :: proc() {
}
    // rust: let (mut hub, seen, _mine) =
    // rust: import_without_placing(serde_json::json!({ "announce": false }));
    // rust: let reply = confirm(&mut hub, UUID);
    // rust: assert_eq!(
    // rust: reply,
    // rust: serde_json::json!({"ok": true, "placed": true, "announced": false})
    // rust: );
    // rust: assert!(hub.guests[1].placed);
    // rust: let told = ids(&seen);
    // rust: assert!(!told.contains(&id::SYSTEM_CHAT), "{told:?}");
    // rust: assert!(told.contains(&id::PLAYER_INFO_UPDATE), "{told:?}");
}

    // The cancel: a failure after the import, before anything reached the client, removes the
    // player from this server with no file and no word to anyone.
dropping_an_imported_but_unconfirmed_player_cancels_the_arrival_without_a_word :: proc() {
}
    // rust: let (mut hub, seen, mine) = import_without_placing(serde_json::json!({}));
    // rust: let _ = ids(&mine);
    // rust: let reply = super::drop_request(&mut hub, UUID);
    // rust: assert_eq!(
    // rust: (reply["held"].as_bool(), reply["expected"].as_bool()),
    // rust: (Some(true), Some(false))
    // rust: );
    // rust: assert!(matches!(mine.try_recv(), Ok(Out::Disconnect(_))));
    // rust: let gone = hub.remove_guest(1, "dropped");
    // rust: assert!(
    // rust: gone.held && !gone.placed && !gone.released,
    // rust: "never placed: the game saves nothing"
    // rust: );
    // rust: assert_eq!(
    // rust: ids(&seen),
    // rust: Vec::<i32>::new(),
    // rust: "the watcher must hear nothing"
    // rust: );
        // And it cannot be confirmed any more.
    // rust: let reply = confirm(&mut hub, UUID);
    // rust: assert!(reply["error"].is_string(), "{reply}");
}

a_confirmation_is_refused_for_a_player_that_is_not_imported_and_changes_nothing :: proc() {
}
    // rust: let (record, mut hub, seen, _mine) = held_in_a_second_hub();
    // rust: let _ = record;
    // rust: for args in ["", "nonsense", &format!("{UUID} now")] {
    // rust: assert!(confirm(&mut hub, args)["error"].is_string(), "{args:?}");
}
        // Held, but nothing was imported.
    // rust: let reply = confirm(&mut hub, &format!("{UUID} {}", "0".repeat(32)));
    // rust: assert!(
    // rust: reply["error"]
    // rust: .as_str()
    // rust: .unwrap()
    // rust: .contains("not been imported"),
    // rust: "{reply}"
    // rust: );
    // rust: assert!(hub.guests[1].held && !hub.guests[1].placed);
        // Not held at all.
    // rust: let reply = confirm(
    // rust: &mut hub,
    // rust: &format!("00000000000000000000000000000009 {}", "0".repeat(32)),
    // rust: );
    // rust: assert!(
    // rust: reply["error"].as_str().unwrap().contains("no player"),
    // rust: "{reply}"
    // rust: );
    // rust: assert_eq!(ids(&seen), Vec::<i32>::new());
}

place_is_true_or_false :: proc() {
}
    // rust: let (record, mut hub, _seen, _mine) = held_in_a_second_hub();
    // rust: let request = serde_json::json!({ "record": record, "place": "later" });
    // rust: assert!(import_player(&mut hub, UUID_N, &request).is_err());
    // rust: assert!(hub.guests[1].held && !hub.guests[1].imported);
}

    // A proxy that dies between the import and the confirmation leaves nothing behind.
an_imported_player_nobody_confirms_is_dropped_like_any_held_player :: proc() {
}
    // rust: let (mut hub, seen, mine) = import_without_placing(serde_json::json!({}));
    // rust: let _ = ids(&mine);
    // rust: let mut world = crate::world::World::new(horizon_world::registry::BlockStateId(0), 0);
    // rust: let border = crate::worldborder::WorldBorder::default();
    // rust: let mut next = 100;
    // rust: let mut ctx = tick_context(&mut world, &border, &mut next);
    // rust: hub.ticks = hub.guests[1].held_since + super::Settings::default().max_hold_ticks - 1;
    // rust: let events = hub.poll(&mut ctx);
    // rust: assert!(events.iter().any(|e| is_warn(e, "dropped")));
    // rust: assert!(matches!(mine.try_recv(), Ok(Out::Disconnect(_))));
    // rust: assert_eq!(ids(&seen), Vec::<i32>::new());
}

    // ---- an import replaces the inventory, it does not mix with the target's own ----

    // A player who has played on the target before has its own inventory in the file the
    // target loaded when it logged in. The imported inventory must REPLACE it: a slot the
    // record leaves empty is empty afterwards, not the target's old item.
an_imported_inventory_replaces_the_one_the_target_loaded_for_the_player :: proc() {
}
//         use crate::items::ItemStack;
    // rust: let stack = |name: &str, count: u32| ItemStack {
    // rust: item: std::sync::Arc::from(name),
    // rust: count,
    // rust: damage: 0,
    // rust: extra: None,
}
    // rust: let (record, mut hub, _seen, _mine) = held_in_a_second_hub();
        // What the target's file gave the held player: items in slots the record leaves empty,
        // in the armour and the off hand, and an ender chest item.
    // rust: {
    // rust: let g = &mut hub.guests[1];
    // rust: g.inventory[5] = Some(stack("minecraft:dirt", 3));
    // rust: g.inventory[20] = Some(stack("minecraft:cobblestone", 9));
    // rust: g.armor[0] = Some(stack("minecraft:iron_boots", 1));
    // rust: g.offhand = Some(stack("minecraft:shield", 1));
    // rust: g.ender_items[0] = Some(stack("minecraft:diamond", 2));
}
    // rust: import_player(
    // rust: &mut hub,
    // rust: UUID_N,
    // rust: &serde_json::json!({ "record": record, "place": false }),
    // rust: )
    // rust: .unwrap();
    // rust: let g = &hub.guests[1];
        // The exported player had only the stone in slot 0.
    // rust: assert_eq!(
    // rust: g.inventory[0].as_ref().map(|s| (&*s.item, s.count)),
    // rust: Some(("minecraft:stone", 5))
    // rust: );
    // rust: for slot in 1..36 {
    // rust: assert!(
    // rust: g.inventory[slot].is_none(),
    // rust: "slot {slot} still holds the target's old item"
    // rust: );
}
    // rust: assert!(g.armor.iter().all(Option::is_none), "the old armour stayed");
    // rust: assert!(g.offhand.is_none(), "the old off hand item stayed");
    // rust: assert!(
    // rust: g.ender_items.iter().all(Option::is_none),
    // rust: "the old ender chest stayed"
    // rust: );
        // And what the client is told is that inventory: the window content has no dirt.
    // rust: let items = (0..46).filter(|&s| g.menu_slot(s).is_some()).count();
    // rust: assert_eq!(items, 1, "the inventory menu holds the stone only");
}

    // Parts that are not imported keep the target's own, items included.
an_inventory_that_is_not_imported_keeps_the_targets_items :: proc() {
}
//         use crate::items::ItemStack;
    // rust: let (record, mut hub, _seen, _mine) = held_in_a_second_hub();
    // rust: hub.guests[1].inventory[5] = Some(ItemStack {
    // rust: item: std::sync::Arc::from("minecraft:dirt"),
    // rust: count: 3,
    // rust: damage: 0,
    // rust: extra: None,
    // rust: });
    // rust: let request =
    // rust: serde_json::json!({ "record": record, "parts": ["experience"], "place": false });
    // rust: import_player(&mut hub, UUID_N, &request).unwrap();
    // rust: assert!(
    // rust: hub.guests[1].inventory[5].is_some(),
    // rust: "the target's dirt must stay"
    // rust: );
    // rust: assert!(
    // rust: hub.guests[1].inventory[0].is_none(),
    // rust: "the record's stone must not come"
    // rust: );
}

    // ---- the review's points on the import ---------------------------------

    // The source's guest with a body (air, fire, freezing, food exhaustion and timer, a fall
    // and a motion), a key Horizon does not model and a vehicle, exported with `freeze`.
record_with_a_body :: proc() -> s {
    // Ported from Horizon
    return {}
}
//         use horizon_world::nbt::Tag;
    // rust: let (mut source, i) = exported_guest();
    // rust: let g = &mut source.guests[i];
    // rust: g.loaded_body = Some(crate::lan::guest::SavedBody {
    // rust: fire_ticks: 100,
    // rust: air: 40,
    // rust: fall_distance: 2.5,
    // rust: velocity: [0.25, 0.0, -0.125],
    // rust: food_exhaustion: 1.5,
    // rust: food_tick_timer: 33,
    // rust: ticks_frozen: 60,
    // rust: });
    // rust: let mut extra = Tag::Compound(Default::default());
    // rust: if let Tag::Compound(map) = &mut extra {
    // rust: map.insert("HorizonTest".into(), Tag::Int(7));
}
    // rust: g.saved = Some(extra);
    // rust: super::export_record(&mut source, i, true, Default::default()).unwrap()
}

held_for :: proc(record: ^serde_json::Value) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let (_, hub, seen, mine) = held_in_a_second_hub();
    // rust: let _ = record;
    // rust: (hub, seen, mine)
}

    // A whole import carries the whole compound: the body's values and the keys Horizon does
    // not model, which the next save writes again.
a_whole_import_keeps_the_body_and_the_keys_horizon_does_not_model :: proc() {
}
//         use crate::save::number;
    // rust: let record = record_with_a_body();
    // rust: let (mut hub, _seen, _mine) = held_for(&record);
    // rust: import_player(&mut hub, UUID_N, &serde_json::json!({ "record": record })).unwrap();
    // rust: let g = &hub.guests[1];
    // rust: let body = g.loaded_body.unwrap();
    // rust: assert_eq!(
    // rust: (body.air, body.fire_ticks, body.ticks_frozen),
    // rust: (40, 100, 60)
    // rust: );
    // rust: assert_eq!((body.food_exhaustion, body.food_tick_timer), (1.5, 33));
    // rust: assert_eq!(
    // rust: (body.fall_distance, body.velocity),
    // rust: (2.5, [0.25, 0.0, -0.125])
    // rust: );
    // rust: let tag = crate::lan::playerdata::player_tag(g);
    // rust: assert_eq!(number(tag.get("HorizonTest")), Some(7));
    // rust: assert_eq!(number(tag.get("Air")), Some(40));
    // rust: assert_eq!(number(tag.get("Fire")), Some(100));
}

    // The body's values follow their parts: the fall and motion the position, the air, fire,
    // freezing and food exhaustion and timer the health. A part left out keeps the held
    // player's own, and its saved vehicle.
the_body_values_follow_their_parts :: proc() {
}
    // rust: let record = record_with_a_body();
    // rust: let (mut hub, _seen, _mine) = held_for(&record);
    // rust: let mine = crate::lan::guest::SavedBody {
    // rust: fire_ticks: -20,
    // rust: air: 300,
    // rust: fall_distance: 0.0,
    // rust: velocity: [0.0; 3],
    // rust: food_exhaustion: 0.0,
    // rust: food_tick_timer: 0,
    // rust: ticks_frozen: 0,
}
    // rust: hub.guests[1].loaded_body = Some(mine);
    // rust: hub.guests[1].saved_vehicle = Some([1, 2, 3, 4]);
    // rust: let request = serde_json::json!({ "record": record, "parts": ["health"], "place": false });
    // rust: import_player(&mut hub, UUID_N, &request).unwrap();
    // rust: let body = hub.guests[1].loaded_body.unwrap();
    // rust: assert_eq!(
    // rust: (body.air, body.fire_ticks, body.ticks_frozen),
    // rust: (40, 100, 60)
    // rust: );
    // rust: assert_eq!((body.food_exhaustion, body.food_tick_timer), (1.5, 33));
    // rust: assert_eq!(
    // rust: (body.fall_distance, body.velocity),
    // rust: (0.0, [0.0; 3]),
    // rust: "not the position's"
    // rust: );
    // rust: assert_eq!(hub.guests[1].saved_vehicle, Some([1, 2, 3, 4]));
}

    // Values no player can have are refused before the held player is touched.
a_record_with_impossible_values_is_refused :: proc() {
}
    // rust: let cases: [(&str, fn(&mut crate::lan::guest::Guest)); 7] = [
    // rust: ("dead", |g| g.health = 0.0),
    // rust: ("health not a number", |g| g.health = f32::NAN),
    // rust: ("out of the world", |g| g.position = [4.0e7, 64.0, 0.0]),
    // rust: ("height out of the world", |g| {
    // rust: g.position = [0.0, 3.0e7, 0.0]
    // rust: }),
    // rust: ("rotation not a number", |g| g.yaw = f32::INFINITY),
    // rust: ("health past max_health's 1024", |g| g.health = 2000.0),
    // rust: ("food exhaustion past 40", |g| {
    // rust: g.loaded_body = Some(crate::lan::guest::SavedBody {
    // rust: fire_ticks: -20,
    // rust: air: 300,
    // rust: fall_distance: 0.0,
    // rust: velocity: [0.0; 3],
    // rust: food_exhaustion: 41.0,
    // rust: food_tick_timer: 0,
    // rust: ticks_frozen: 0,
    // rust: });
    // rust: }),
    // rust: ];
    // rust: for (what, spoil) in cases {
    // rust: let (mut source, i) = exported_guest();
    // rust: spoil(&mut source.guests[i]);
    // rust: let record = super::export_record(&mut source, i, true, Default::default()).unwrap();
    // rust: let (_, mut hub, seen, _mine) = held_in_a_second_hub();
    // rust: let before = crate::lan::playerdata::player_tag(&hub.guests[1]);
    // rust: let error = import_player(&mut hub, UUID_N, &serde_json::json!({ "record": record }))
    // rust: .expect_err(what);
    // rust: assert!(error.starts_with("the record"), "{what}: {error}");
    // rust: assert_eq!(
    // rust: crate::lan::playerdata::player_tag(&hub.guests[1]),
    // rust: before,
    // rust: "{what}"
    // rust: );
    // rust: assert!(hub.guests[1].held && !hub.guests[1].imported, "{what}");
    // rust: assert_eq!(ids(&seen), Vec::<i32>::new(), "{what}");
}
}

    // The record must be a hand-over's, and the held player takes one hand-over's record.
an_import_names_its_hand_over :: proc() {
}
    // rust: let (source_record, mut hub, _seen, _mine) = held_in_a_second_hub();
        // A read (an export without freeze) is not a hand-over.
    // rust: let (mut source, i) = exported_guest();
    // rust: let read = super::export_record(&mut source, i, false, Default::default()).unwrap();
    // rust: let error =
    // rust: import_player(&mut hub, UUID_N, &serde_json::json!({ "record": read })).unwrap_err();
    // rust: assert!(error.contains("no hand-over id"), "{error}");
    // rust: let request = serde_json::json!({ "record": source_record, "place": false });
    // rust: let done = import_player(&mut hub, UUID_N, &request).unwrap();
    // rust: assert_eq!(
    // rust: source_record["handover"].as_str(),
    // rust: Some(super::handover_text(done.handover).as_str())
    // rust: );
    // rust: assert_eq!(hub.guests[1].arrival_handover, Some(done.handover));
        // The same record again is taken (a retry); another hand-over's is not.
    // rust: import_player(&mut hub, UUID_N, &request).unwrap();
    // rust: let mut other = source_record.clone();
    // rust: other["handover"] = serde_json::json!("0".repeat(32));
    // rust: let error = import_player(
    // rust: &mut hub,
    // rust: UUID_N,
    // rust: &serde_json::json!({ "record": other, "place": false }),
    // rust: )
    // rust: .unwrap_err();
    // rust: assert!(error.contains("another hand-over"), "{error}");
        // A confirmation of another hand-over is refused, and changes nothing.
    // rust: let wrong = confirm(&mut hub, &format!("{UUID} {}", "0".repeat(32)));
    // rust: assert!(
    // rust: wrong["error"]
    // rust: .as_str()
    // rust: .unwrap()
    // rust: .contains("another hand-over"),
    // rust: "{wrong}"
    // rust: );
    // rust: assert!(hub.guests[1].held && hub.guests[1].imported);
}

    // `player-drop` takes the hand-over id, which must be the imported one; without it the
    // drop goes by the unique id alone.
a_drop_that_names_a_hand_over_must_name_the_imported_one :: proc() {
}
    // rust: let (mut hub, _seen, mine) = import_without_placing(serde_json::json!({}));
    // rust: let id = super::handover_text(hub.guests[1].arrival_handover.unwrap());
    // rust: let _ = ids(&mine);
    // rust: let reply = super::drop_request(&mut hub, &format!("{UUID} {}", "0".repeat(32)));
    // rust: assert!(reply["error"].is_string(), "{reply}");
    // rust: assert!(mine.try_recv().is_err(), "nothing was dropped");
    // rust: for bad in [format!("{UUID} soon"), format!("{UUID} {id} now")] {
    // rust: assert!(
    // rust: super::drop_request(&mut hub, &bad)["error"].is_string(),
    // rust: "{bad}"
    // rust: );
}
    // rust: let reply = super::drop_request(&mut hub, &format!("{UUID} {id}"));
    // rust: assert_eq!(reply["held"], true, "{reply}");
    // rust: assert!(matches!(mine.try_recv(), Ok(Out::Disconnect(_))));
        // While its connection closes, neither a confirmation nor an import takes it.
    // rust: let confirmed = confirm(&mut hub, &format!("{UUID} {id}"));
    // rust: assert!(confirmed["error"].is_string(), "{confirmed}");
    // rust: assert!(!hub.guests[1].placed);
}

    // An arrival kicked or dropped, whose connection has not closed yet, is not placed.
a_leaving_arrival_cannot_be_imported_or_confirmed :: proc() {
}
    // rust: let (record, mut hub, _seen, _mine) = held_in_a_second_hub();
    // rust: hub.guests[1].left_reason = "Timed out".into();
    // rust: let error =
    // rust: import_player(&mut hub, UUID_N, &serde_json::json!({ "record": record })).unwrap_err();
    // rust: assert!(error.contains("leaving"), "{error}");
    // rust: let (mut hub, _seen, _mine) = import_without_placing(serde_json::json!({}));
    // rust: let id = super::handover_text(hub.guests[1].arrival_handover.unwrap());
    // rust: hub.guests[1].left_reason = "Timed out".into();
    // rust: let reply = confirm(&mut hub, &format!("{UUID} {id}"));
    // rust: assert!(
    // rust: reply["error"].as_str().unwrap().contains("leaving"),
    // rust: "{reply}"
    // rust: );
    // rust: assert!(!hub.guests[1].placed);
}

    // The login sent the target's recipe book; the import sends the imported one.
an_import_sends_the_recipe_book_again :: proc() {
}
    // rust: let (_hub, _seen, mine) = import_without_placing(serde_json::json!({}));
    // rust: let sent = ids(&mine);
    // rust: assert!(sent.contains(&id::RECIPE_BOOK_SETTINGS), "{sent:?}");
}

    // After the commit, a retry of the confirm (or of the import) whose reply was lost finds the
    // player placed from that same hand-over, and the game answers it the same; another
    // hand-over's id is still refused.
a_retry_after_the_commit_finds_the_player_placed_from_that_hand_over :: proc() {
}
    // rust: let (mut hub, _seen, _mine) = import_without_placing(serde_json::json!({}));
    // rust: let id = hub.guests[1].arrival_handover.unwrap();
    // rust: let args = format!("{UUID} {}", super::handover_text(id));
    // rust: assert_eq!(confirm(&mut hub, &args)["placed"], true);
    // rust: assert_eq!(hub.placed_arrival(UUID_N, id), Some(1));
    // rust: assert_eq!(super::confirm_args(&hub, &args), Ok((UUID_N, id)));
    // rust: assert_eq!(hub.placed_arrival(UUID_N, id ^ 1), None);
    // rust: let other = format!("{UUID} {}", super::handover_text(id ^ 1));
    // rust: assert!(super::confirm_args(&hub, &other).is_err());
}

    // ---- the view follows the imported position ----------------------------

    // rust: fn held_with_a_record_at(
    // rust: at: [f64; 3],
    // rust: center: Option<(i32, i32)>,
    // rust: ) -> (serde_json::Value, Hub, Receiver<Out>) {
    // rust: held_with_a_record_of(|g| g.position = at, center)
}

    // rust: fn held_with_a_record_of(
    // rust: source_player: impl FnOnce(&mut Guest),
    // rust: center: Option<(i32, i32)>,
    // rust: ) -> (serde_json::Value, Hub, Receiver<Out>) {
    // rust: let (mut source, i) = exported_guest();
    // rust: source_player(&mut source.guests[i]);
    // rust: let record = super::export_record(&mut source, i, true, Default::default()).unwrap();
    // rust: let mut hub = hub();
    // rust: assert_eq!(
    // rust: super::expect_request(&mut hub, UUID, Instant::now())["ok"],
    // rust: true
    // rust: );
    // rust: let (newcomer, mine) = guest(2, UUID_N, "Alex");
    // rust: hub.guests.push(newcomer);
    // rust: login_starts(&mut hub, UUID_N);
    // rust: place(&mut hub, 2);
    // rust: hub.guests[0].center = center;
    // rust: let _ = ids(&mine);
    // rust: (record, hub, mine)
}

an_import_to_another_chunk_moves_the_view_at_once_and_says_so :: proc() {
}
        // Chunk (0, 0) before, chunk (6, -1) after: x 100.5 is block 100, chunk 6; z -3.25 is chunk -1.
    // rust: let (record, mut hub, mine) = held_with_a_record_at([100.5, 70.0, -3.25], Some((0, 0)));
    // rust: let request = serde_json::json!({ "record": record, "place": false });
    // rust: let done = import_player(&mut hub, UUID_N, &request).unwrap();
    // rust: assert!(done.recentered);
    // rust: assert_eq!(
    // rust: hub.guests[0].center,
    // rust: Some((6, -1)),
    // rust: "the view is centred on the new chunk"
    // rust: );
    // rust: let sent = packets(&mine);
    // rust: let centre = sent
    // rust: .iter()
    // rust: .position(|(i, _)| *i == id::SET_CHUNK_CACHE_CENTER)
    // rust: .expect("the new chunk centre is sent with the import");
    // rust: let position = sent
    // rust: .iter()
    // rust: .position(|(i, _)| *i == id::PLAYER_POSITION)
    // rust: .unwrap();
    // rust: assert!(
    // rust: centre < position,
    // rust: "the centre goes before the position the client confirms"
    // rust: );
        // The centre is the vanilla pair of VarInts: chunk x then chunk z (6, then -1 as an unsigned VarInt).
    // rust: let mut r = horizon_protocol::buf::Reader::new(&sent[centre].1);
    // rust: assert_eq!((r.varint().unwrap(), r.varint().unwrap()), (6, -1));
}

an_import_inside_the_same_chunk_does_not_recentre :: proc() {
}
    // rust: let (record, mut hub, mine) = held_with_a_record_at([3.5, 64.0, 3.5], Some((0, 0)));
    // rust: let request = serde_json::json!({ "record": record, "place": false });
    // rust: let done = import_player(&mut hub, UUID_N, &request).unwrap();
    // rust: assert!(!done.recentered);
    // rust: assert_eq!(hub.guests[0].center, Some((0, 0)));
    // rust: assert!(!ids(&mine).contains(&id::SET_CHUNK_CACHE_CENTER));
}

without_the_position_part_the_view_stays_where_it_is :: proc() {
}
    // rust: let (record, mut hub, mine) = held_with_a_record_at([100.5, 70.0, -3.25], Some((0, 0)));
    // rust: let request =
    // rust: serde_json::json!({ "record": record, "place": false, "parts": ["inventory"] });
    // rust: let done = import_player(&mut hub, UUID_N, &request).unwrap();
    // rust: assert!(!done.recentered);
    // rust: assert_eq!(hub.guests[0].center, Some((0, 0)));
    // rust: assert!(!ids(&mine).contains(&id::SET_CHUNK_CACHE_CENTER));
}

    // A held player that has not been sent any chunk has no view to move: the first tick builds it
    // around the new place.
a_view_not_yet_built_is_not_recentred :: proc() {
}
    // rust: let (record, mut hub, _mine) = held_with_a_record_at([100.5, 70.0, -3.25], None);
    // rust: let request = serde_json::json!({ "record": record, "place": false });
    // rust: assert!(
    // rust: !import_player(&mut hub, UUID_N, &request)
    // rust: .unwrap()
    // rust: .recentered
    // rust: );
}

    // A retried import of the same hand-over (its reply was lost) finds the view already moved,
    // and still says the chunks around the new place are on their way.
a_retried_import_still_reports_the_recentring :: proc() {
}
    // rust: let (record, mut hub, _mine) = held_with_a_record_at([100.5, 70.0, -3.25], Some((0, 0)));
    // rust: let request = serde_json::json!({ "record": record, "place": false });
    // rust: for _ in 0..2 {
    // rust: let done = import_player(&mut hub, UUID_N, &request).unwrap();
    // rust: assert!(done.recentered);
}
}

    // A record whose vehicle is still to be restored puts the player back on it at the vehicle's
    // own place, so a position the request names would be undone: it is refused, and the record's
    // own place is still taken.
a_named_position_is_refused_for_a_record_with_a_vehicle_to_restore :: proc() {
}
    // rust: let (record, mut hub, _mine) = held_with_a_record_of(
    // rust: |g| {
    // rust: g.position = [10.5, 70.0, -3.25];
    // rust: g.saved_vehicle = Some([1, 2, 3, 4]);
    // rust: },
    // rust: Some((0, 0)),
    // rust: );
    // rust: let named = serde_json::json!({
    // rust: "record": record.clone(), "place": false, "position": [300.5, 64.0, 300.5],
    // rust: });
    // rust: let error = import_player(&mut hub, UUID_N, &named).unwrap_err();
    // rust: assert!(error.contains("vehicle"), "{error}");
    // rust: assert!(!hub.guests[0].imported);
    // rust: let plain = serde_json::json!({ "record": record, "place": false });
    // rust: import_player(&mut hub, UUID_N, &plain).unwrap();
    // rust: assert_eq!(hub.guests[0].position, [10.5, 70.0, -3.25]);
    // rust: assert_eq!(hub.guests[0].saved_vehicle, Some([1, 2, 3, 4]));
}

placing_at_once_reports_the_recentring_too :: proc() {
}
    // rust: let (record, mut hub, mine) = held_with_a_record_at([100.5, 70.0, -3.25], Some((0, 0)));
    // rust: let done =
    // rust: import_player(&mut hub, UUID_N, &serde_json::json!({ "record": record })).unwrap();
    // rust: assert!(done.place && done.recentered);
    // rust: assert!(ids(&mine).contains(&id::SET_CHUNK_CACHE_CENTER));
}

    // ---- where the player arrives: the request's own position, rotation, on-ground -----

    // The position a PlayerPosition packet carries, with its look.
position_sent :: proc(mine: ^Receiver<Out>) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let (id_, payload) = packets(mine)
    // rust: .into_iter()
    // rust: .rev()
    // rust: .find(|(i, _)| *i == id::PLAYER_POSITION)
    // rust: .expect("the import sends a position");
    // rust: match horizon_protocol::packets::play::Clientbound::decode(id_, &payload).unwrap() {
    // rust: horizon_protocol::packets::play::Clientbound::PlayerPosition(p) => {
    // rust: (p.position, p.yaw, p.pitch)
}
    // rust: other => panic!("not a position: {other:?}"),
}
}

the_requests_position_wins_over_the_records_and_the_client_is_told_it :: proc() {
}
    // rust: let (record, mut hub, mine) = held_with_a_record_at([10.5, 70.0, -3.25], Some((0, 0)));
    // rust: let request = serde_json::json!({
    // rust: "record": record, "place": false,
    // rust: "position": [300.5, 64.0, 300.5], "rotation": [90.0, 20.0], "on_ground": false,
    // rust: });
    // rust: let done = import_player(&mut hub, UUID_N, &request).unwrap();
    // rust: let g = &hub.guests[0];
    // rust: assert_eq!(g.position, [300.5, 64.0, 300.5]);
    // rust: assert_eq!(g.previous_position, [300.5, 64.0, 300.5]);
    // rust: assert_eq!((g.yaw, g.pitch, g.head_yaw), (90.0, 20.0, 90.0));
    // rust: assert!(!g.on_ground);
        // The chunk is the one of the request's position, not the record's.
    // rust: assert!(done.recentered);
    // rust: assert_eq!(g.center, Some((18, 18)));
    // rust: let (at, yaw, pitch) = position_sent(&mine);
    // rust: assert_eq!((at, yaw, pitch), ([300.5, 64.0, 300.5], 90.0, 20.0));
}

without_the_requests_fields_the_records_place_is_taken :: proc() {
}
    // rust: let (record, mut hub, mine) = held_with_a_record_at([10.5, 70.0, -3.25], Some((0, 0)));
    // rust: import_player(
    // rust: &mut hub,
    // rust: UUID_N,
    // rust: &serde_json::json!({ "record": record, "place": false }),
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(hub.guests[0].position, [10.5, 70.0, -3.25]);
    // rust: assert_eq!(position_sent(&mine).0, [10.5, 70.0, -3.25]);
}

a_pitch_is_taken_modulo_a_turn_then_cut_to_a_quarter_turn :: proc() {
}
        // Entity.setXRot: Math.clamp(pitch % 360, -90, 90); setYRot keeps the yaw as it is.
    // rust: for (asked, yaw, pitch) in [
    // rust: ([10.0, 120.0], 10.0, 90.0),
    // rust: ([10.0, -120.0], 10.0, -90.0),
    // rust: ([10.0, 370.0], 10.0, 10.0),
    // rust: ([-30.0, -350.0], -30.0, -90.0),
    // rust: ([725.0, 45.0], 725.0, 45.0),
    // rust: ] {
    // rust: let (record, mut hub, _mine) = held_with_a_record_at([10.5, 70.0, -3.25], None);
    // rust: let request =
    // rust: serde_json::json!({ "record": record, "place": false, "rotation": asked });
    // rust: import_player(&mut hub, UUID_N, &request).unwrap();
    // rust: assert_eq!(
    // rust: (hub.guests[0].yaw, hub.guests[0].pitch),
    // rust: (yaw, pitch),
    // rust: "{asked:?}"
    // rust: );
}
}

    // Every refusal leaves the held player as it was and tells its client nothing.
a_place_that_is_not_one_is_refused_and_nothing_changes :: proc() {
}
    // rust: let (record, mut hub, mine) = held_with_a_record_at([10.5, 70.0, -3.25], Some((0, 0)));
    // rust: let before = crate::lan::playerdata::player_tag(&hub.guests[0]);
    // rust: let place = hub.guests[0].position;
    // rust: let with = |extra: serde_json::Value| {
    // rust: let mut r = serde_json::json!({ "record": record.clone(), "place": false });
    // rust: for (k, v) in extra.as_object().unwrap() {
    // rust: r[k] = v.clone();
}
    // rust: r
}
    // rust: let cases = [
    // rust: (
    // rust: "beyond the world",
    // rust: with(serde_json::json!({ "position": [40_000_000.0, 64.0, 0.0] })),
    // rust: ),
    // rust: (
    // rust: "far below",
    // rust: with(serde_json::json!({ "position": [0.0, -40_000_000.0, 0.0] })),
    // rust: ),
    // rust: (
    // rust: "two numbers",
    // rust: with(serde_json::json!({ "position": [1.0, 2.0] })),
    // rust: ),
    // rust: (
    // rust: "a string",
    // rust: with(serde_json::json!({ "position": ["a", "b", "c"] })),
    // rust: ),
    // rust: ("not a list", with(serde_json::json!({ "position": 5 }))),
    // rust: (
    // rust: "rotation of one",
    // rust: with(serde_json::json!({ "rotation": [1.0] })),
    // rust: ),
    // rust: (
    // rust: "a rotation past what a float holds",
    // rust: with(serde_json::json!({ "rotation": [1e39, 1e39] })),
    // rust: ),
    // rust: (
    // rust: "a velocity that is not three numbers",
    // rust: with(serde_json::json!({ "velocity": [0.25, "up", 0.0] })),
    // rust: ),
    // rust: (
    // rust: "on_ground a number",
    // rust: with(serde_json::json!({ "on_ground": 1 })),
    // rust: ),
    // rust: (
    // rust: "the position part left out",
    // rust: with(serde_json::json!({ "position": [1.0, 64.0, 1.0], "parts": ["inventory"] })),
    // rust: ),
    // rust: ];
    // rust: for (what, request) in &cases {
    // rust: let error = import_player(&mut hub, UUID_N, request).expect_err(what);
    // rust: assert!(!error.is_empty(), "{what}");
    // rust: let g = &hub.guests[0];
    // rust: assert!(
    // rust: g.held && !g.imported,
    // rust: "{what}: the player must still be held and not imported"
    // rust: );
    // rust: assert_eq!(g.position, place, "{what}");
    // rust: assert_eq!(
    // rust: crate::lan::playerdata::player_tag(g),
    // rust: before,
    // rust: "{what}: nothing may change"
    // rust: );
}
    // rust: assert_eq!(
    // rust: ids(&mine),
    // rust: Vec::<i32>::new(),
    // rust: "a refusal tells the client nothing"
    // rust: );
}

a_position_is_finite_and_inside_the_worlds_limit :: proc() {
}
//         use crate::lan::import::check_position_for_tests as check;
    // rust: assert!(check([0.0, 64.0, 0.0]));
        // Entity.load's clamp: 3.0000512E7 on x and z, 2.0E7 on y.
    // rust: assert!(check([-30_000_512.0, -64.0, 30_000_512.0]));
    // rust: assert!(check([0.0, -20_000_000.0, 0.0]));
    // rust: assert!(!check([30_000_512.5, 64.0, 0.0]));
    // rust: assert!(!check([0.0, 20_000_000.5, 0.0]));
    // rust: assert!(!check([f64::NAN, 64.0, 0.0]));
    // rust: assert!(!check([0.0, f64::INFINITY, 0.0]));
    // rust: assert!(!check([0.0, 64.0, f64::NEG_INFINITY]));
}

    // The request's velocity is the body's from now on, a component over 10 blocks a tick
    // taken as 0 as `Entity.load` takes a saved `Motion`; it belongs to the position part.
the_requests_velocity_is_taken_with_the_position :: proc() {
}
    // rust: let (record, mut hub, _mine) = held_with_a_record_at([10.5, 70.0, -3.25], None);
    // rust: let request = serde_json::json!({
    // rust: "record": record,
    // rust: "place": false,
    // rust: "velocity": [0.25, -0.0784, 12.0],
    // rust: });
    // rust: import_player(&mut hub, UUID_N, &request).unwrap();
    // rust: let body = hub.guests[0].loaded_body.unwrap();
    // rust: assert_eq!(body.velocity, [0.25, -0.0784, 0.0]);
    // rust: let alone = serde_json::json!({
    // rust: "record": record,
    // rust: "parts": ["inventory"],
    // rust: "velocity": [0.0, 0.0, 0.0],
    // rust: });
    // rust: let error = import_player(&mut hub, UUID_N, &alone).unwrap_err();
    // rust: assert!(error.contains("belong to the position part"), "{error}");
}

    // ---- the lines of the log ------------------------------------------------

//     use super::{dropped_line, held_line, placed_line, request_log};
//     use serde_json::json;

a_refused_request_is_a_warning_with_the_reason :: proc() {
}
    // rust: let reply = json!({ "error": "that player is riding" });
    // rust: let (level, line) = request_log(
    // rust: "player-export",
    // rust: Some("Alex"),
    // rust: &format!("{UUID} freeze"),
    // rust: &reply,
    // rust: );
    // rust: assert_eq!(level, "WARN");
    // rust: assert_eq!(
    // rust: line,
    // rust: "player-export Alex (123e4567-e89b-12d3-a456-426614174000): refused: that player is riding"
    // rust: );
}

an_accepted_request_says_what_it_did_and_never_writes_the_record :: proc() {
}
    // rust: let id = UUID.replace('-', "");
    // rust: let (level, line) = request_log(
    // rust: "player-expect",
    // rust: None,
    // rust: &format!("{id} 30"),
    // rust: &json!({"ok": true, "renewed": true, "ttl_seconds": 30}),
    // rust: );
    // rust: assert_eq!(level, "INFO");
    // rust: assert_eq!(
    // rust: line,
    // rust: "player-expect 123e4567-e89b-12d3-a456-426614174000: ok, expected for 30 s (renewed)"
    // rust: );
        // 8 base64 characters are 6 bytes.
    // rust: let reply = json!({"ok": true, "record": {"player": "AAAAAAAA", "name": "Alex", "handover": "0123456789abcdef0123456789abcdef"}});
    // rust: let (_, line) = request_log(
    // rust: "player-export",
    // rust: Some("Alex"),
    // rust: &format!("{UUID} freeze"),
    // rust: &reply,
    // rust: );
    // rust: assert!(
    // rust: line.ends_with(
    // rust: "ok, record of 6 bytes, frozen, hand-over 0123456789abcdef0123456789abcdef"
    // rust: ),
    // rust: "{line}"
    // rust: );
        // An export without freeze is a read.
    // rust: let read = json!({"ok": true, "record": {"player": "AAAAAAAA", "handover": null}});
    // rust: let (_, line) = request_log("player-export", None, UUID, &read);
    // rust: assert!(line.ends_with("ok, record of 6 bytes, a read"), "{line}");
    // rust: assert!(
    // rust: !line.contains("AAAA"),
    // rust: "the record itself must not be written: {line}"
    // rust: );
    // rust: let reply = json!({"ok": true, "handover": "0123456789abcdef0123456789abcdef", "parts": ["inventory", "experience"], "placed": false, "announced": true, "recentered": true});
    // rust: let (_, line) = request_log(
    // rust: "player-import",
    // rust: Some("Alex"),
    // rust: &format!("{UUID} {{\"record\":{{}}}}"),
    // rust: &reply,
    // rust: );
    // rust: assert!(
    // rust: line.ends_with(
    // rust: "ok, parts inventory,experience, placed false, announced true, recentered true, hand-over 0123456789abcdef0123456789abcdef"
    // rust: ),
    // rust: "{line}"
    // rust: );
    // rust: assert!(
    // rust: !line.contains("record"),
    // rust: "the request body must not be written: {line}"
    // rust: );
    // rust: let (_, line) = request_log(
    // rust: "player-release",
    // rust: Some("Alex"),
    // rust: &format!("{UUID} 0123456789abcdef0123456789abcdef moved"),
    // rust: &json!({"ok": true, "released": "moved", "announced": false}),
    // rust: );
    // rust: assert!(
    // rust: line.ends_with(
    // rust: "ok, moved, announced false, hand-over 0123456789abcdef0123456789abcdef"
    // rust: ),
    // rust: "{line}"
    // rust: );
    // rust: let (_, line) = request_log(
    // rust: "player-drop",
    // rust: None,
    // rust: UUID,
    // rust: &json!({"ok": true, "held": true, "expected": false}),
    // rust: );
    // rust: assert!(line.ends_with("ok, held true, expected false"), "{line}");
    // rust: let (_, line) = request_log(
    // rust: "player-drop",
    // rust: None,
    // rust: &format!("{UUID} 0123456789abcdef0123456789abcdef"),
    // rust: &json!({"ok": true, "held": true, "expected": false}),
    // rust: );
    // rust: assert!(
    // rust: line.ends_with(
    // rust: "ok, held true, expected false, hand-over 0123456789abcdef0123456789abcdef"
    // rust: ),
    // rust: "{line}"
    // rust: );
    // rust: let (_, line) = request_log(
    // rust: "player-confirm",
    // rust: None,
    // rust: &format!("{UUID} 0123456789abcdef0123456789abcdef"),
    // rust: &json!({"ok": true, "placed": true, "announced": true}),
    // rust: );
    // rust: assert!(
    // rust: line.ends_with(
    // rust: "ok, placed, announced true, hand-over 0123456789abcdef0123456789abcdef"
    // rust: ),
    // rust: "{line}"
    // rust: );
}

a_request_without_a_readable_id_is_logged_as_typed :: proc() {
}
    // rust: let (level, line) = request_log(
    // rust: "player-drop",
    // rust: None,
    // rust: "nonsense",
    // rust: &json!({"error": "player-drop needs the player's unique id"}),
    // rust: );
    // rust: assert_eq!(level, "WARN");
    // rust: assert!(
    // rust: line.starts_with("player-drop \"nonsense\": refused"),
    // rust: "{line}"
    // rust: );
}

the_lines_of_a_held_player_never_say_it_joined_or_left :: proc() {
}
    // rust: assert_eq!(
    // rust: held_line("Alex"),
    // rust: "Alex is held: it arrives from another server"
    // rust: );
    // rust: assert_eq!(
    // rust: placed_line("Alex"),
    // rust: "Alex placed: it has arrived from another server"
    // rust: );
    // rust: let dropped = dropped_line("Alex", "dropped before its hand-over");
    // rust: assert_eq!(
    // rust: dropped,
    // rust: "Alex was dropped while held: dropped before its hand-over"
    // rust: );
    // rust: for line in [held_line("Alex"), dropped] {
    // rust: assert!(
    // rust: !line.contains("joined the game") && !line.contains("left the game"),
    // rust: "{line}"
    // rust: );
}
}

    // ---- the view follows the imported position ------------------------------
}
