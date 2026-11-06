//! Transpiled from Horizon Rust crate
package horizon_server_files_user_lists

import "core:fmt"
import "core:mem"
import "core:math"

// ops.json, whitelist.json, banned-players.json and banned-ips.json
// (StoredUserList and its entries): a Java HashMap keyed by the UUID string
// or the address, saved as a pretty-printed Gson array in that map's order.
// use super::{
    // rust: java_properties::{civil_from_days, days_from_civil, now_millis},
    // rust: json::{self, Json},
    // rust: properties::parse_uuid,
}
// use horizon_core::random::java_string_hash;
// use horizon_protocol::crypto::uuid_string;
// use horizon_world::java_hash_map::{JavaHashMap, JavaKey};
// use std::{cmp::Ordering, path::PathBuf};

// A map key: a Java String.
JKey :: struct {
    // rust: impl JavaKey for JKey {
java_hash :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: java_string_hash(self.0.encode_utf16())
}
comparable_compare :: proc(self: ^Self, other: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(self.0.encode_utf16().cmp(other.0.encode_utf16()))
}
tie_break :: proc(self: ^Self, _: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Ordering::Less
}
}

// NameAndId.
NameAndId :: struct {
    id: u128,
    name: string,
}
    // rust: impl NameAndId {
offline :: proc(name: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: id: horizon_protocol::crypto::offline_uuid(name),
    // rust: name: name.to_owned(),
}
}
    // rust: pub(crate) fn from_json(o: &Json) -> Option<Self> {
    // rust: let uuid = o.get("uuid")?.as_string()?;
    // rust: let name = o.get("name")?.as_string()?;
    // rust: Some(Self {
    // rust: id: parse_uuid(&uuid)?,
    // rust: name,
    // rust: })
}
    // rust: pub(crate) fn append_to(&self, o: &mut Json) {
    // rust: o.add("uuid", Json::String(uuid_string(self.id)));
    // rust: o.add("name", Json::String(self.name.clone()));
}
}

// BanListEntry.DATE_FORMAT ("yyyy-MM-dd HH:mm:ss Z"), written in UTC.
format_date :: proc(millis: i64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let secs = millis.div_euclid(1000);
    // rust: let (y, m, d) = civil_from_days(secs.div_euclid(86_400));
    // rust: let rem = secs.rem_euclid(86_400);
    // rust: format!(
    // rust: "{y:04}-{m:02}-{d:02} {:02}:{:02}:{:02} +0000",
    // rust: rem / 3600,
    // rust: rem / 60 % 60,
    // rust: rem % 60
    // rust: )
}
// The lenient SimpleDateFormat parse of that pattern: fields may overflow
// into the next (month 13 is January of the next year).
parse_date :: proc(s: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let s = s.trim_start();
    // rust: let (date, rest) = s.split_once(' ')?;
    // rust: let (time, zone) = rest.trim_start().split_once(' ')?;
    // rust: let num = |p: &str| -> Option<i64> {
    // rust: let p = p.trim();
    // rust: if p.is_empty()
    // rust: || !p
    // rust: .bytes()
    // rust: .all(|b| b.is_ascii_digit() || b == b'-' || b == b'+')
    // rust: {
    // rust: return None;
}
    // rust: p.parse().ok()
}
    // rust: let d: Vec<&str> = date.splitn(3, '-').collect();
    // rust: let t: Vec<&str> = time.splitn(3, ':').collect();
    // rust: if d.len() != 3 || t.len() != 3 {
    // rust: return None;
}
    // rust: let (y, mo, da) = (num(d[0])?, num(d[1])?, num(d[2])?);
    // rust: let (h, mi, se) = (num(t[0])?, num(t[1])?, num(t[2])?);
    // rust: let zone = zone.trim();
    // rust: let sign = match zone.as_bytes().first()? {
    // rust: b'+' => 1,
    // rust: b'-' => -1,
    // rust: _ => return None,
}
    // rust: let digits = &zone[1..];
    // rust: if digits.len() != 4 || !digits.bytes().all(|b| b.is_ascii_digit()) {
    // rust: return None;
}
    // rust: let offset =
    // rust: sign * (digits[..2].parse::<i64>().ok()? * 60 + digits[2..].parse::<i64>().ok()?);
    // Lenient month and day arithmetic, checked: the file is edited by hand, and a value past what
    // milliseconds since 1970 hold is no date (None, as an unparsable one) rather than a wrapped one.
    // rust: let months = y.checked_mul(12)?.checked_add(mo.checked_sub(1)?)?;
    // rust: let (year, month) = (months.div_euclid(12), months.rem_euclid(12) + 1);
    // Far beyond any i64 of milliseconds, and small enough for days_from_civil's own arithmetic.
    // rust: if !(-300_000_000..=300_000_000).contains(&year) {
    // rust: return None;
}
    // rust: let days = days_from_civil(year, month as u32, 1)
    // rust: .checked_add(da)?
    // rust: .checked_sub(1)?;
    // rust: let seconds = days
    // rust: .checked_mul(86_400)?
    // rust: .checked_add(h.checked_mul(3600)?)?
    // rust: .checked_add(mi.checked_mul(60)?)?
    // rust: .checked_add(se)?
    // rust: .checked_sub(offset * 60)?;
    // rust: seconds.checked_mul(1000)
}

// One list entry kind.
    // rust: pub trait Entry: Clone {
    // rust: type User: Clone;
user :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
key :: proc(user: ^Self::User) -> S {
    // Ported from Horizon
    return {}
}
from_json :: proc(o: ^Json) -> O {
    // Ported from Horizon
    return {}
}
serialize :: proc(self: ^Self, o: ^Json) {
}
expired :: proc(self: ^Self, _now: i64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
    // `infos.equals(previous)` in StoredUserList.add: only ban entries
    // override equals; the others compare by identity, so a new entry is
    // never equal to the stored one.
same :: proc(self: ^Self, _other: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
}

OpEntry :: struct {
    user: NameAndId,
    level: i32,
    bypasses_player_limit: bool,
}
    // rust: impl Entry for OpEntry {
    // rust: type User = NameAndId;
user :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.user
}
key :: proc(user: ^NameAndId) -> S {
    // Ported from Horizon
    return {}
}
    // rust: uuid_string(user.id)
}
from_json :: proc(o: ^Json) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let user = NameAndId::from_json(o)?;
    // rust: let level = o
    // rust: .get("level")
    // rust: .and_then(json_int)
    // rust: .map_or(0, |l| l.clamp(0, 4));
    // rust: let bypasses_player_limit = o.get("bypassesPlayerLimit").is_some_and(json_bool);
    // rust: Some(Self {
    // rust: user,
    // rust: level,
    // rust: bypasses_player_limit,
    // rust: })
}
serialize :: proc(self: ^Self, o: ^Json) {
}
    // rust: self.user.append_to(o);
    // rust: o.add("level", Json::Number(self.level.to_string()));
    // rust: o.add(
    // rust: "bypassesPlayerLimit",
    // rust: Json::Bool(self.bypasses_player_limit),
    // rust: );
}
}

WhiteEntry :: struct {
    user: NameAndId,
}
    // rust: impl Entry for WhiteEntry {
    // rust: type User = NameAndId;
user :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.user
}
key :: proc(user: ^NameAndId) -> S {
    // Ported from Horizon
    return {}
}
    // rust: uuid_string(user.id)
}
from_json :: proc(o: ^Json) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(Self {
    // rust: user: NameAndId::from_json(o)?,
    // rust: })
}
serialize :: proc(self: ^Self, o: ^Json) {
}
    // rust: self.user.append_to(o);
}
}

// BanListEntry for players (NameAndId) or addresses (String).
BanEntry :: struct {
    user: T,
    created: i64,
    source: string,
    expires: Maybe(i64),
    reason: Maybe(string),
}
    // rust: impl<T: PartialEq> PartialEq for BanEntry<T> {
eq :: proc(self: ^Self, o: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.source == o.source
    // rust: && self.expires == o.expires
    // rust: && self.reason == o.reason
    // rust: && self.user == o.user
}
}
    // rust: impl<T> BanEntry<T> {
    // rust: pub fn new(
    // rust: user: T,
    // rust: source: Option<String>,
    // rust: expires: Option<i64>,
    // rust: reason: Option<String>,
    // rust: ) -> Self {
    // rust: Self {
    // rust: user,
    // rust: created: now_millis(),
    // rust: source: source.unwrap_or_else(|| "(Unknown)".into()),
    // rust: expires,
    // rust: reason,
}
}
fields :: proc(user: T, o: ^Json) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let date = |k: &str| {
    // rust: o.get(k)
    // rust: .and_then(Json::as_string)
    // rust: .and_then(|s| parse_date(&s))
}
    // rust: Self {
    // rust: user,
    // rust: created: date("created").unwrap_or_else(now_millis),
    // rust: source: o
    // rust: .get("source")
    // rust: .and_then(Json::as_string)
    // rust: .unwrap_or_else(|| "(Unknown)".into()),
    // rust: expires: date("expires"),
    // rust: reason: o.get("reason").and_then(Json::as_string),
}
}
serialize_ban :: proc(self: ^Self, o: ^Json) {
}
    // rust: o.add("created", Json::String(format_date(self.created)));
    // rust: o.add("source", Json::String(self.source.clone()));
    // rust: o.add(
    // rust: "expires",
    // rust: Json::String(self.expires.map_or_else(|| "forever".into(), format_date)),
    // rust: );
    // rust: o.add(
    // rust: "reason",
    // rust: self.reason.clone().map_or(Json::Null, Json::String),
    // rust: );
}
}
    // rust: impl Entry for BanEntry<NameAndId> {
    // rust: type User = NameAndId;
same :: proc(self: ^Self, other: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self == other
}
user :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.user
}
key :: proc(user: ^NameAndId) -> S {
    // Ported from Horizon
    return {}
}
    // rust: uuid_string(user.id)
}
from_json :: proc(o: ^Json) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(Self::fields(NameAndId::from_json(o)?, o))
}
serialize :: proc(self: ^Self, o: ^Json) {
}
    // rust: self.user.append_to(o);
    // rust: self.serialize_ban(o);
}
expired :: proc(self: ^Self, now: i64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.expires.is_some_and(|e| e < now)
}
}
    // rust: impl Entry for BanEntry<String> {
    // rust: type User = String;
same :: proc(self: ^Self, other: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self == other
}
user :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.user
}
key :: proc(user: ^string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: user.clone()
}
from_json :: proc(o: ^Json) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(Self::fields(o.get("ip")?.as_string()?, o))
}
serialize :: proc(self: ^Self, o: ^Json) {
}
    // rust: o.add("ip", Json::String(self.user.clone()));
    // rust: self.serialize_ban(o);
}
expired :: proc(self: ^Self, now: i64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.expires.is_some_and(|e| e < now)
}
}

// JsonElement.getAsInt / getAsBoolean on primitives.
json_int :: proc(v: ^Json) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match v {
    // rust: Json::Number(n) => n
    // rust: .parse::<i64>()
    // rust: .ok()
    // rust: .map(|v| v as i32)
    // rust: .or_else(|| n.parse::<f64>().ok().map(|f| f as i32)),
    // rust: Json::String(s) => s.trim().parse::<i32>().ok(),
    // rust: _ => None,
}
}
json_bool :: proc(v: ^Json) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match v {
    // rust: Json::Bool(b) => *b,
    // rust: Json::String(s) => s.eq_ignore_ascii_case("true"),
    // rust: _ => false,
}
}

// What happened to a list, for the one that watches it: what vanilla's `StoredUserList` tells its
// `NotificationService` (`playerOped`/`playerDeoped`, `playerAddedToAllowlist`/`playerRemovedFromAllowlist`,
// `playerBanned`/`playerUnbanned`, `ipBanned`/`ipUnbanned`).
Change :: enum {
    // An entry was added (or replaced by a different one).
    Added(E),
    // An entry was removed; a `clear` says it once for each entry, in the map's order, before it empties.
    Removed(E),
}

// StoredUserList.
UserList :: struct {
    file: PathBuf,
    map: JavaHashMap<JKey,
    watcher: Maybe(^dyn Fn(Change<E)) + Send>,
}
    // rust: impl<E: Entry> UserList<E> {
new :: proc(file: impl Into<PathBuf>) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: file: file.into(),
    // rust: map: JavaHashMap::default(),
    // rust: watcher: None,
}
}
    // Has `watcher` told of every change from now on (`add`, `remove` and `clear`, not a `load`, and not the
    // expired entries `get` drops, as vanilla's don't).
watch :: proc(self: ^Self, watcher: impl Fn(Change<E>) {
}
    // rust: self.watcher = Some(Box::new(watcher));
}
told :: proc(self: ^Self, change: Change<E>) {
}
    // rust: if let Some(watcher) = &self.watcher {
    // rust: watcher(change);
}
}
    // The entries in the map's iteration order.
entries :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.map.entries().map(|(_, v)| v).collect()
}
is_empty :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.map.is_empty()
}
contains :: proc(self: ^Self, user: ^E::User) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.map.get(&JKey(E::key(user))).is_some()
}
    // StoredUserList.get: expired entries are dropped first.
get :: proc(self: ^Self, user: ^E::User) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let now = now_millis();
    // rust: let expired: Vec<JKey> = self
    // rust: .map
    // rust: .entries()
    // rust: .filter(|(_, e)| e.expired(now))
    // rust: .map(|(k, _)| k.clone())
    // rust: .collect();
    // rust: for k in expired {
    // rust: self.map.remove(&k);
}
    // rust: self.map.get(&JKey(E::key(user)))
}
    // Returns false when an equal entry is already there; saves otherwise.
add :: proc(self: ^Self, entry: E) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let key = JKey(E::key(entry.user()));
    // rust: if self.map.get(&key).is_some_and(|old| entry.same(old)) {
    // rust: return false;
}
    // rust: self.map.put(key, entry.clone());
    // rust: if let Err(e) = self.save() {
    // rust: log::warn!("Could not save the list after adding a user. {e}");
}
    // rust: self.told(Change::Added(entry));
    // rust: true
}
remove :: proc(self: ^Self, user: ^E::User) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(entry) = self.map.remove(&JKey(E::key(user))) else {
    // rust: return false;
}
    // rust: if let Err(e) = self.save() {
    // rust: log::warn!("Could not save the list after removing a user. {e}");
}
    // rust: self.told(Change::Removed(entry));
    // rust: true
}
    // StoredUserList.clear: no entry left; saves.
clear :: proc(self: ^Self) {
}
    // rust: let entries: Vec<E> = self.map.entries().map(|(_, e)| e.clone()).collect();
    // rust: for entry in entries {
    // rust: self.told(Change::Removed(entry));
}
    // rust: self.map.clear();
    // rust: if let Err(e) = self.save() {
    // rust: log::warn!("Could not save the list after removing a user. {e}");
}
}
to_json :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let items = self
    // rust: .map
    // rust: .entries()
    // rust: .map(|(_, e)| {
    // rust: let mut o = Json::Object(Vec::new());
    // rust: e.serialize(&mut o);
    // rust: o
    // rust: })
    // rust: .collect();
    // rust: Json::Array(items).pretty()
}
save :: proc(self: ^Self) -> s {
    // Ported from Horizon
    return {}
}
    // rust: std::fs::write(&self.file, self.to_json())
}
    // StoredUserList.load: a missing file leaves the list as it is.
load :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let Ok(text) = std::fs::read_to_string(&self.file) else {
    // rust: return Ok(());
}
    // rust: self.load_str(&text)
}
load_str :: proc(self: ^Self, text: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.map = JavaHashMap::default();
    // rust: if text.trim().is_empty() {
    // rust: return Ok(());
}
    // rust: let Json::Array(items) = json::parse(text, false)? else {
    // rust: return Err("Expected a JSON array".into());
}
    // rust: for item in items {
    // rust: if !matches!(item, Json::Object(_)) {
    // rust: return Err("Expected entry to be an object".into());
}
    // rust: if let Some(e) = E::from_json(&item) {
    // rust: self.map.put(JKey(E::key(e.user())), e);
}
}
    // rust: Ok(())
}
}

    // rust: pub type OpList = UserList<OpEntry>;
    // rust: pub type WhiteList = UserList<WhiteEntry>;
    // rust: pub type BanList = UserList<BanEntry<NameAndId>>;
    // rust: pub type IpBanList = UserList<BanEntry<String>>;

    // rust: mod tests {
//     use super::*;
saves_like_gson :: proc() {
}
    // rust: let mut ops = OpList::new("/nonexistent/ops.json");
    // rust: ops.load_str(
    // rust: r#"[{"uuid":"069a79f4-44e9-4726-a5be-fca90e38aaf5","name":"Notch","level":3}]"#,
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: ops.to_json(),
    // rust: "[\n  {\n    \"uuid\": \"069a79f4-44e9-4726-a5be-fca90e38aaf5\",\n    \"name\": \"Notch\",\n    \"level\": 3,\n    \"bypassesPlayerLimit\": false\n  }\n]"
    // rust: );
    // rust: assert_eq!(
    // rust: parse_date("2026-10-12 10:00:00 +0200"),
    // rust: parse_date("2026-10-12 08:00:00 +0000")
    // rust: );
    // rust: assert_eq!(
    // rust: format_date(parse_date("2026-10-12 08:00:00 +0000").unwrap()),
    // rust: "2026-10-12 08:00:00 +0000"
    // rust: );
    // rust: assert_eq!(parse_date("forever"), None);
}

dates_too_far_out_are_none_not_wrapped :: proc() {
}
        // Lenient overflow still works within range: month 13 is January of the next year.
    // rust: assert_eq!(
    // rust: parse_date("2026-13-01 00:00:00 +0000"),
    // rust: parse_date("2027-01-01 00:00:00 +0000")
    // rust: );
    // rust: for text in [
    // rust: "9223372036854775807-01-01 00:00:00 +0000",
    // rust: "2026-9223372036854775807-01 00:00:00 +0000",
    // rust: "2026-01-9223372036854775807 00:00:00 +0000",
    // rust: "2026-01-01 9223372036854775807:00:00 +0000",
    // rust: "2026-01-01 00:00:9223372036854775807 +0000",
    // rust: "-9223372036854775808-01-01 00:00:00 +0000",
    // rust: "300000001-01-01 00:00:00 +0000",
    // rust: "2026--9223372036854775808-01 00:00:00 +0000",
    // rust: ] {
    // rust: assert_eq!(parse_date(text), None, "{text}");
}
        // The far end of what milliseconds hold still parses (year 292 million).
    // rust: assert!(parse_date("292000000-01-01 00:00:00 +0000").is_some());
}

a_watcher_hears_what_vanillas_notification_service_does :: proc() {
}
//         use std::sync::{Arc, Mutex};
    // rust: let dir = std::env::temp_dir().join(format!("horizon-lists-watch-{}", std::process::id()));
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: let heard = Arc::new(Mutex::new(Vec::new()));
    // rust: let mut ops = OpList::new(dir.join("ops.json"));
    // rust: let sink = heard.clone();
    // rust: ops.watch(move |change| sink.lock().unwrap().push(change));
    // rust: let op = |name: &str, level| OpEntry {
    // rust: user: NameAndId::offline(name),
    // rust: level,
    // rust: bypasses_player_limit: false,
}
    // rust: assert!(ops.add(op("Kim", 4)));
    // rust: assert!(ops.add(op("Lee", 2)));
        // A removal that finds nothing says nothing; one that finds an entry says which.
    // rust: assert!(!ops.remove(&NameAndId::offline("Nobody")));
    // rust: assert!(ops.remove(&NameAndId::offline("Kim")));
        // A clear says it for each entry that is left, and the list is empty after.
    // rust: ops.clear();
    // rust: assert!(ops.is_empty());
    // rust: assert_eq!(
    // rust: *heard.lock().unwrap(),
    // rust: [
    // rust: Change::Added(op("Kim", 4)),
    // rust: Change::Added(op("Lee", 2)),
    // rust: Change::Removed(op("Kim", 4)),
    // rust: Change::Removed(op("Lee", 2)),
    // rust: ]
    // rust: );
        // A ban equal to the stored one is not added again, so nothing is said.
    // rust: let mut bans = BanList::new(dir.join("banned-players.json"));
    // rust: let said = Arc::new(Mutex::new(0));
    // rust: let counter = said.clone();
    // rust: bans.watch(move |_| *counter.lock().unwrap() += 1);
    // rust: let ban = BanEntry::new(NameAndId::offline("Kim"), None, None, None);
    // rust: assert!(bans.add(ban.clone()));
    // rust: assert!(!bans.add(ban));
    // rust: assert_eq!(*said.lock().unwrap(), 1);
    // rust: let _ = std::fs::remove_dir_all(&dir);
}

a_cleared_list_saves_empty :: proc() {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-lists-{}", std::process::id()));
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: let mut white = WhiteList::new(dir.join("whitelist.json"));
    // rust: assert!(white.add(WhiteEntry {
    // rust: user: NameAndId::offline("Kim")
    // rust: }));
    // rust: white.clear();
    // rust: assert!(white.is_empty());
    // rust: assert_eq!(
    // rust: std::fs::read_to_string(dir.join("whitelist.json")).unwrap(),
    // rust: "[]"
    // rust: );
    // rust: let _ = std::fs::remove_dir_all(&dir);
}
}
