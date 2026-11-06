//! Transpiled from Horizon Rust crate
//! Module: horizon-server-files_user_cache
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! usercache.json (CachedUserNameToIdResolver): the players the server has
//! seen join or has looked up by name, so commands find a player by name
//! without asking the profile service again. Each entry expires a month after
//! it was added; the file keeps the 1000 most recently used.
// use crate::{
    // rust: java_properties::{civil_from_days, days_from_civil, now_millis},
    // rust: json::{self, Json},
    // rust: profiles::valid_player_name,
    // rust: user_lists::{NameAndId, format_date, parse_date},
}
// use std::{collections::HashMap, path::PathBuf};

pub const MRU_LIMIT: usize = 1000;

pub const Info = struct {
    user: NameAndId,
    expires: i64,
    last_access: u64,
};

/// `Calendar.add(MONTH, 1)` on a UTC time: the same day and time a month
/// later, the day clamped to the end of a shorter month.
pub fn one_month_later(millis: i64) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let days = millis.div_euclid(86_400_000);
    // rust: let time = millis.rem_euclid(86_400_000);
    // rust: let (y, m, d) = civil_from_days(days);
    // rust: let (y, m) = if m == 12 { (y + 1, 1) } else { (y, m + 1) };
    // rust: let last = days_from_civil(
    // rust: if m == 12 { y + 1 } else { y },
    // rust: if m == 12 { 1 } else { m + 1 },
    // rust: 1,
    // rust: ) - days_from_civil(y, m, 1);
    // rust: let d = d.min(last as u32);
    // rust: days_from_civil(y, m, d) * 86_400_000 + time
}

pub const UserCache = struct {
    file: PathBuf,
    /// Every entry ever added; the maps point into it, as vanilla's two maps
    /// share their GameProfileInfo objects.
    infos: std.ArrayList(Info),
    by_name: HashMap<[]const u8,
    by_uuid: HashMap<u128,
    operations: u64,
    /// Off on an online-mode server: a name the profile service doesn't know
    /// is then no player at all, rather than an offline one.
    resolve_offline_users: bool,
};

    // rust: impl UserCache {
    /// The cache in `file`, loaded; also returns the warnings vanilla logs.
pub fn load(file: impl Into<PathBuf>) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut cache = Self {
    // rust: file: file.into(),
    // rust: infos: Vec::new(),
    // rust: by_name: HashMap::new(),
    // rust: by_uuid: HashMap::new(),
    // rust: operations: 0,
    // rust: resolve_offline_users: true,
}
    // rust: let mut warnings = Vec::new();
    // rust: let entries = match std::fs::read_to_string(&cache.file) {
    // rust: Ok(text) => cache.parse(&text, &mut warnings),
    // rust: Err(_) => Vec::new(),
}
    // rust: for info in entries.into_iter().rev() {
    // rust: cache.safe_add(info);
}
    // rust: (cache, warnings)
}

pub fn parse(self: *Self, text: []const u8, warnings: *mut std.ArrayList([]const u8)) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let items = match json::parse(text, false) {
    // rust: Ok(Json::Array(items)) => items,
            // An empty file is Gson's null.
    // rust: Ok(Json::Null) => return Vec::new(),
    // rust: _ if text.trim().is_empty() => return Vec::new(),
    // rust: _ => {
    // rust: warnings.push(format!(
    // rust: "Failed to load profile cache {}",
    // rust: self.file.display()
    // rust: ));
    // rust: return Vec::new();
}
}
    // rust: let mut out = Vec::new();
    // rust: for item in &items {
    // rust: if !matches!(item, Json::Object(_)) {
    // rust: continue;
}
    // rust: let Some(user) = NameAndId::from_json(item) else {
    // rust: continue;
}
    // rust: let Some(date) = item.get("expiresOn").and_then(Json::as_string) else {
    // rust: continue;
}
    // rust: match parse_date(&date) {
    // rust: Some(expires) => out.push(Info {
    // rust: user,
    // rust: expires,
    // rust: last_access: 0,
    // rust: }),
    // rust: None => warnings.push(format!("Failed to parse date {date}")),
}
}
    // rust: out
}

pub fn safe_add(self: *Self, mut info: Info) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.operations += 1;
    // rust: info.last_access = self.operations;
    // rust: let index = self.infos.len();
    // rust: self.by_name.insert(info.user.name.to_lowercase(), index);
    // rust: self.by_uuid.insert(info.user.id, index);
    // rust: self.infos.push(info);
    // rust: index
}

    /// `add`: a player who joined, remembered for a month; saves the file.
pub fn add(self: *Self, user: NameAndId) void {
}
    // rust: self.add_internal(user, now_millis());
}

pub fn add_internal(self: *Self, user: NameAndId, now: i64) N {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let index = self.safe_add(Info {
    // rust: user,
    // rust: expires: one_month_later(now),
    // rust: last_access: 0,
    // rust: });
    // rust: self.save();
    // rust: self.infos[index].user.clone()
}

    /// `get(UUID)`: the player with this id, if cached (expired or not, as vanilla's).
pub fn get_by_id(self: *Self, id: u128) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let index = *self.by_uuid.get(&id)?;
    // rust: self.operations += 1;
    // rust: self.infos[index].last_access = self.operations;
    // rust: Some(self.infos[index].user.clone())
}

    /// `get(String)`: the player with this name (any case). An expired entry is
    /// dropped; a name not cached is asked of `lookup` (the profile service,
    /// given the lower-case name) and, failing that, made an offline player
    /// when offline users resolve. What is found is cached.
    // rust: pub fn get_by_name(
    // rust: &mut self,
    // rust: name: &str,
    // rust: lookup: impl FnOnce(&str) -> Option<NameAndId>,
    // rust: ) -> Option<NameAndId> {
    // rust: self.get_by_name_at(name, now_millis(), lookup)
}

    // rust: fn get_by_name_at(
    // rust: &mut self,
    // rust: name: &str,
    // rust: now: i64,
    // rust: lookup: impl FnOnce(&str) -> Option<NameAndId>,
    // rust: ) -> Option<NameAndId> {
    // rust: let name = name.to_lowercase();
    // rust: let mut found = self.by_name.get(&name).copied();
    // rust: let mut needs_save = false;
    // rust: if let Some(index) = found
    // rust: && now >= self.infos[index].expires
    // rust: {
    // rust: let user = self.infos[index].user.clone();
    // rust: self.by_uuid.remove(&user.id);
    // rust: self.by_name.remove(&user.name.to_lowercase());
    // rust: needs_save = true;
    // rust: found = None;
}
    // rust: let result = if let Some(index) = found {
    // rust: self.operations += 1;
    // rust: self.infos[index].last_access = self.operations;
    // rust: Some(self.infos[index].user.clone())
    // rust: } else {
    // rust: let profile = if valid_player_name(&name) {
    // rust: lookup(&name)
    // rust: } else {
    // rust: None
}
    // rust: let profile = profile.or_else(|| {
    // rust: self.resolve_offline_users
    // rust: .then(|| NameAndId::offline(&name))
    // rust: });
    // rust: match profile {
    // rust: Some(profile) => {
    // rust: needs_save = false;
    // rust: Some(self.add_internal(profile, now))
}
    // rust: None => None,
}
}
    // rust: if needs_save {
    // rust: self.save();
}
    // rust: result
}

    /// The file's text: the 1000 most recently used entries, most recent
    /// first, as Gson writes them (compact, HTML-safe).
pub fn to_json(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut entries: Vec<&Info> = self.by_uuid.values().map(|&i| &self.infos[i]).collect();
    // rust: entries.sort_by_key(|info| std::cmp::Reverse(info.last_access));
    // rust: let items = entries
    // rust: .into_iter()
    // rust: .take(MRU_LIMIT)
    // rust: .map(|info| {
    // rust: let mut o = Json::Object(Vec::new());
    // rust: info.user.append_to(&mut o);
    // rust: o.add("expiresOn", Json::String(format_date(info.expires)));
    // rust: o
    // rust: })
    // rust: .collect();
    // rust: Json::Array(items).gson()
}

    /// `save`: errors are ignored, as vanilla does.
pub fn save(self: *Self) void {
}
    // rust: let _ = std::fs::write(&self.file, self.to_json());
}
}

    // rust: mod tests {
//     use super::*;

pub const DAY: i64 = 86_400_000;

pub fn cache(text: []const u8) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let dir = std::env::temp_dir().join(format!(
    // rust: "horizon-usercache-{}-{}",
    // rust: std::process::id(),
    // rust: text.len()
    // rust: ));
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: let file = dir.join("usercache.json");
    // rust: std::fs::write(&file, text).unwrap();
    // rust: UserCache::load(file)
}

pub fn months() void {
}
    // rust: let jan31 = days_from_civil(2026, 1, 31) * DAY + 3_723_000;
    // rust: assert_eq!(
    // rust: format_date(one_month_later(jan31)),
    // rust: "2026-02-28 01:02:03 +0000"
    // rust: );
    // rust: let dec15 = days_from_civil(2026, 12, 15) * DAY;
    // rust: assert_eq!(
    // rust: format_date(one_month_later(dec15)),
    // rust: "2027-01-15 00:00:00 +0000"
    // rust: );
    // rust: let jan31_leap = days_from_civil(2028, 1, 31) * DAY;
    // rust: assert_eq!(
    // rust: format_date(one_month_later(jan31_leap)),
    // rust: "2028-02-29 00:00:00 +0000"
    // rust: );
}

pub fn keeps_order_and_skips_bad_entries() void {
}
    // rust: let (c, warnings) = cache(
    // rust: r#"[{"uuid":"069a79f4-44e9-4726-a5be-fca90e38aaf5","name":"Notch","expiresOn":"2099-01-01 00:00:00 +0000"},
    // rust: 1, {"name":"NoId"}, {"uuid":"853c80ef-3c37-49fd-aa49-938b674adae6","name":"NoDate"},
    // rust: {"uuid":"853c80ef-3c37-49fd-aa49-938b674adae6","name":"BadDate","expiresOn":"soon"},
    // rust: {"uuid":"61699b2e-d327-4a01-9f1e-0ea8c3f06bc6","name":"Alex","expiresOn":"2099-01-01 00:00:00 +0000"}]"#,
    // rust: );
    // rust: assert_eq!(warnings, vec!["Failed to parse date soon".to_owned()]);
    // rust: assert_eq!(
    // rust: c.to_json(),
    // rust: r#"[{"uuid":"069a79f4-44e9-4726-a5be-fca90e38aaf5","name":"Notch","expiresOn":"2099-01-01 00:00:00 +0000"},{"uuid":"61699b2e-d327-4a01-9f1e-0ea8c3f06bc6","name":"Alex","expiresOn":"2099-01-01 00:00:00 +0000"}]"#
    // rust: );
}

pub fn names_resolve_through_the_cache() void {
}
    // rust: let (mut c, _) = cache(
    // rust: r#"[{"uuid":"069a79f4-44e9-4726-a5be-fca90e38aaf5","name":"Notch","expiresOn":"2099-01-01 00:00:00 +0000"},
    // rust: {"uuid":"61699b2e-d327-4a01-9f1e-0ea8c3f06bc6","name":"Old","expiresOn":"2000-01-01 00:00:00 +0000"}]"#,
    // rust: );
    // rust: let now = days_from_civil(2026, 10, 17) * DAY;
    // rust: let never = |_: &str| -> Option<NameAndId> { panic!("looked up") };
        // A hit in any case, and it becomes the most recent.
    // rust: let notch = c.get_by_name_at("NOTCH", now, never).unwrap();
    // rust: assert_eq!(notch.name, "Notch");
        // By id: what the cache holds, expired or not (vanilla's `get(UUID)` doesn't check).
    // rust: assert_eq!(c.get_by_id(notch.id), Some(notch.clone()));
    // rust: assert_eq!(
    // rust: c.get_by_id(0x61699b2e_d327_4a01_9f1e_0ea8c3f06bc6)
    // rust: .unwrap()
    // rust: .name,
    // rust: "Old"
    // rust: );
    // rust: assert_eq!(c.get_by_id(1), None);
        // Expired: dropped and looked up again, by its lower-case name.
    // rust: let mut asked = Vec::new();
    // rust: let old = c
    // rust: .get_by_name_at("Old", now, |n| {
    // rust: asked.push(n.to_owned());
    // rust: None
    // rust: })
    // rust: .unwrap();
    // rust: assert_eq!(asked, ["old"]);
    // rust: assert_eq!(old, NameAndId::offline("old"));
        // Not a valid name: never looked up.
    // rust: let odd = c.get_by_name_at("a b", now, never).unwrap();
    // rust: assert_eq!(odd, NameAndId::offline("a b"));
    // rust: c.resolve_offline_users = false;
    // rust: assert_eq!(c.get_by_name_at("Nobody", now, |_| None), None);
    // rust: let found = NameAndId {
    // rust: id: 7,
    // rust: name: "Steve".into(),
}
    // rust: let steve = c.get_by_name_at("steve", now, |_| Some(found.clone()));
    // rust: assert_eq!(steve, Some(found));
    // rust: let json = c.to_json();
    // rust: let names: Vec<&str> = json
    // rust: .split("\"name\":\"")
    // rust: .skip(1)
    // rust: .map(|s| s.split('"').next().unwrap())
    // rust: .collect();
    // rust: assert_eq!(names, ["Steve", "a b", "old", "Notch"]);
    // rust: assert!(json.contains(r#""name":"Steve","expiresOn":"2026-11-17 00:00:00 +0000"}"#));
}
}
