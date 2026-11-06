//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_ban_notice
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The ban notices `Gui.addInitialScreens` queues before the title screen:
//! `Minecraft.multiplayerBan()` (the account's MULTIPLAYER ban from the services
//! attributes call), the forced name change and the banned skin
//! (`ProfileResult.actions()`), and the text `BanNoticeScreens` shows for each.
//! The network calls are in `auth.rs`; this file parses what they return.
// use crate::text::Text;

/// `CommonLinks.SUSPENSION_HELP`.
pub const SUSPENSION_HELP: []const u8 = "https://aka.ms/mcjavamoderation";

/// authlib's `BanDetails` (the id is never shown).
pub const BanDetails = struct {
    /// Epoch milliseconds the ban ends; `None` is permanent.
    expires_ms: ?i64,
    reason: ?[]const u8,
    reason_message: ?[]const u8,
};

/// authlib's `UserProperties`, as far as the title screen reads it.
pub const UserProperties = struct {
    /// `UserFlag.SERVERS_ALLOWED` (`privileges.multiplayerServer.enabled`).
    servers_allowed: bool,
    /// `bannedScopes.get("MULTIPLAYER")`.
    multiplayer_ban: ?BanDetails,
};
    // rust: impl Default for UserProperties {
    /// `UserApiService.OFFLINE_PROPERTIES`: what a failed fetch falls back to.
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: servers_allowed: true,
    // rust: multiplayer_ban: None,
}
}
}

/// authlib's `ProfileResult.actions()`.
pub const ProfileActions = struct {
    forced_name_change: bool,
    using_banned_skin: bool,
};

/// What the title screen learns about the account.
pub const AccountStatus = struct {
    properties: UserProperties,
    actions: ProfileActions,
};
    // rust: impl AccountStatus {
    /// `Minecraft.allowsMultiplayer` (without the `--disableMultiplayer` flag).
pub fn allows_multiplayer(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.properties.servers_allowed
    // rust: && self.properties.multiplayer_ban.is_none()
    // rust: && !self.actions.forced_name_change
}
}

/// One of the screens `Gui.addInitialScreens` adds.
pub const Notice = enum {
    /// `BanNoticeScreens.create`.
    Multiplayer(BanDetails),
    /// `BanNoticeScreens.createNameBan` with the profile's name.
    Name(String),
    /// `BanNoticeScreens.createSkinBan`.
    Skin,
};

/// `Gui.addInitialScreens`' ban part, in its order: the multiplayer ban, the
/// name ban, the skin ban.
pub fn initial_notices(status: *AccountStatus, profile_name: []const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut notices = Vec::new();
    // rust: if let Some(ban) = &status.properties.multiplayer_ban {
    // rust: notices.push(Notice::Multiplayer(ban.clone()));
}
    // rust: if status.actions.forced_name_change {
    // rust: notices.push(Notice::Name(profile_name.to_owned()));
}
    // rust: if status.actions.using_banned_skin {
    // rust: notices.push(Notice::Skin);
}
    // rust: notices
}

    // rust: impl Notice {
    /// The screen's title (bold).
pub fn title(self: *Self) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let key = match self {
    // rust: Self::Multiplayer(ban) if ban.expires_ms.is_some() => "gui.banned.title.temporary",
    // rust: Self::Multiplayer(_) => "gui.banned.title.permanent",
    // rust: Self::Name(_) => "gui.banned.name.title",
    // rust: Self::Skin => "gui.banned.skin.title",
}
    // rust: Text::translate(key, &[]).bold()
}
    /// The screen's message; `now_ms` is `Instant.now()`.
pub fn message(self: *Self, now_ms: i64) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let link = || Text::literal(SUSPENSION_HELP);
    // rust: match self {
    // rust: Self::Multiplayer(ban) => Text::translate(
    // rust: "gui.banned.description",
    // rust: &[reason_text(ban), status_text(ban, now_ms), link()],
    // rust: ),
    // rust: Self::Name(name) => Text::translate(
    // rust: "gui.banned.name.description",
    // rust: &[Text::colored(name.clone(), YELLOW), link()],
    // rust: ),
    // rust: Self::Skin => Text::translate("gui.banned.skin.description", &[link()]),
}
}
}

/// `ChatFormatting.YELLOW`.
pub const YELLOW: u32 = 0xFFFF55;

/// `BanReason.byId`: the translation key suffix.
pub fn ban_reason(id: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(match id {
    // rust: 2 => "false_reporting",
    // rust: 5 => "hate_speech",
    // rust: 16 | 25 => "hate_terrorism_notorious_figure",
    // rust: 17 | 19 | 23 | 31 => "generic_violation",
    // rust: 21 => "harassment_or_bullying",
    // rust: 27 => "defamation_impersonation_false_information",
    // rust: 28 => "drugs",
    // rust: 29 => "fraud",
    // rust: 30 => "spam_or_advertising",
    // rust: 32 => "nudity_or_pornography",
    // rust: 33 | 35 | 36 => "sexually_inappropriate",
    // rust: 34 => "extreme_violence_or_gore",
    // rust: 53 => "imminent_harm_to_person_or_property",
    // rust: _ => return None,
    // rust: })
}

/// `BanNoticeScreens.getBanReasonText`.
pub fn reason_text(ban: *BanDetails) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let numeric = ban
    // rust: .reason
    // rust: .as_deref()
    // rust: .filter(|r| !r.is_empty() && r.bytes().all(|b| b.is_ascii_digit()));
    // rust: let Some(reason) = numeric else {
    // rust: return Text::translate("gui.banned.description.unknownreason", &[]);
}
    // Integer.parseInt: past i32 the vanilla screen would throw; show the code as is.
    // rust: let id = reason.parse::<i32>().ok();
    // rust: let text = if let Some(key) = id.and_then(ban_reason) {
    // rust: Text::translate(&format!("gui.banned.reason.{key}"), &[]).bold()
    // rust: } else if let Some(message) = &ban.reason_message {
    // rust: Text::translate(
    // rust: "gui.banned.description.reason_id_message",
    // rust: &[Text::literal(reason), Text::literal(message.clone())],
    // rust: )
    // rust: .bold()
    // rust: } else {
    // rust: Text::translate("gui.banned.description.reason_id", &[Text::literal(reason)]).bold()
}
    // rust: Text::translate("gui.banned.description.reason", &[text])
}

/// `BanNoticeScreens.getBanStatusText`.
pub fn status_text(ban: *BanDetails, now_ms: i64) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match ban.expires_ms {
    // rust: Some(expires) => {
    // rust: let duration = Text::translate(
    // rust: "gui.banned.description.temporary.duration",
    // rust: &[duration_text(expires - now_ms)],
    // rust: )
    // rust: .bold();
    // rust: Text::translate("gui.banned.description.temporary", &[duration])
}
    // rust: None => Text::translate("gui.banned.description.permanent", &[]).bold(),
}
}

/// `BanNoticeScreens.getBanDurationText`: days past 72 hours, else hours,
/// else minutes (`Duration.toHours` and friends truncate toward zero).
pub fn duration_text(millis: i64) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let count = |n: i64| Text::literal(n.to_string());
    // rust: let hours = millis / 3_600_000;
    // rust: if hours > 72 {
    // rust: Text::translate("gui.days", &[count(millis / 86_400_000)])
    // rust: } else if hours < 1 {
    // rust: Text::translate("gui.minutes", &[count(millis / 60_000)])
    // rust: } else {
    // rust: Text::translate("gui.hours", &[count(hours)])
}
}

/// `Instant` as authlib's gson adapter reads it: an ISO-8601 string, or epoch milliseconds.
pub fn parse_instant(value: *serde_json::Value) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match value {
    // rust: serde_json::Value::Number(n) => n.as_i64(),
    // rust: serde_json::Value::String(s) => chrono::DateTime::parse_from_rfc3339(s)
    // rust: .ok()
    // rust: .map(|t| t.timestamp_millis())
    // rust: .or_else(|| s.parse().ok()),
    // rust: _ => None,
}
}

/// `UserAttributesResponse` into `UserProperties` (`fetchProperties`). Bad JSON
/// is an error, which vanilla answers with the offline properties.
pub fn parse_properties(body: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let v: serde_json::Value = serde_json::from_str(body).ok()?;
    // rust: let servers_allowed = v
    // rust: .pointer("/privileges/multiplayerServer/enabled")
    // rust: .and_then(|e| e.as_bool())
    // rust: .unwrap_or(false);
    // rust: let multiplayer_ban = v
    // rust: .pointer("/banStatus/bannedScopes/MULTIPLAYER")
    // rust: .filter(|b| b.is_object())
    // rust: .map(|b| {
    // rust: let text = |k: &str| b.get(k).and_then(|s| s.as_str()).map(str::to_owned);
    // rust: BanDetails {
    // rust: expires_ms: b.get("expires").and_then(parse_instant),
    // rust: reason: text("reason"),
    // rust: reason_message: text("reasonMessage"),
}
    // rust: });
    // rust: Some(UserProperties {
    // rust: servers_allowed,
    // rust: multiplayer_ban,
    // rust: })
}

/// `MinecraftProfilePropertiesResponse.profileActions` into `ProfileActionType`s.
pub fn parse_profile_actions(body: []const u8) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut actions = ProfileActions::default();
    // rust: let v: serde_json::Value = serde_json::from_str(body).unwrap_or_default();
    // rust: for action in v
    // rust: .get("profileActions")
    // rust: .and_then(|a| a.as_array())
    // rust: .into_iter()
    // rust: .flatten()
    // rust: {
    // rust: match action.get("type").and_then(|t| t.as_str()) {
    // rust: Some("FORCED_NAME_CHANGE") => actions.forced_name_change = true,
    // rust: Some("USING_BANNED_SKIN") => actions.using_banned_skin = true,
    // rust: _ => {}
}
}
    // rust: actions
}

    // rust: mod tests {
//     use super::*;

pub const HOUR: i64 = 3_600_000;
    /// 2026-11-01T00:00:00Z.
pub const EXPIRES: i64 = 1_793_491_200_000;

pub fn parses_a_multiplayer_ban() void {
}
    // rust: let body = r#"{"privileges":{"multiplayerServer":{"enabled":false}},
    // rust: "banStatus":{"bannedScopes":{"MULTIPLAYER":{"banId":"6b0f0a0e-0000-4000-8000-000000000000",
    // rust: "expires":"2026-11-01T00:00:00Z","reason":"21","reasonMessage":"x"}}}}"#;
    // rust: let p = parse_properties(body).unwrap();
    // rust: assert!(!p.servers_allowed);
    // rust: let ban = p.multiplayer_ban.unwrap();
    // rust: assert_eq!(ban.expires_ms, Some(EXPIRES));
    // rust: assert_eq!(ban.reason.as_deref(), Some("21"));
    // rust: let numeric =
    // rust: parse_properties(r#"{"banStatus":{"bannedScopes":{"MULTIPLAYER":{"expires":5}}}}"#)
    // rust: .unwrap();
    // rust: assert_eq!(numeric.multiplayer_ban.unwrap().expires_ms, Some(5));
    // rust: assert!(parse_properties("nope").is_none());
    // rust: let clean = parse_properties(
    // rust: r#"{"privileges":{"multiplayerServer":{"enabled":true}},"banStatus":{"bannedScopes":{}}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: assert!(clean.servers_allowed && clean.multiplayer_ban.is_none());
}

pub fn parses_profile_actions() void {
}
    // rust: let a = parse_profile_actions(
    // rust: r#"{"id":"x","profileActions":[{"type":"FORCED_NAME_CHANGE"},{"type":"OTHER"}]}"#,
    // rust: );
    // rust: assert!(a.forced_name_change && !a.using_banned_skin);
    // rust: let a = parse_profile_actions(r#"{"profileActions":[{"type":"USING_BANNED_SKIN"}]}"#);
    // rust: assert!(!a.forced_name_change && a.using_banned_skin);
    // rust: assert_eq!(parse_profile_actions("{}"), ProfileActions::default());
}

pub fn queues_in_vanilla_order() void {
}
    // rust: let ban = BanDetails {
    // rust: expires_ms: None,
    // rust: reason: None,
    // rust: reason_message: None,
}
    // rust: let status = AccountStatus {
    // rust: properties: UserProperties {
    // rust: servers_allowed: true,
    // rust: multiplayer_ban: Some(ban.clone()),
    // rust: },
    // rust: actions: ProfileActions {
    // rust: forced_name_change: true,
    // rust: using_banned_skin: true,
    // rust: },
}
    // rust: assert_eq!(
    // rust: initial_notices(&status, "Steve"),
    // rust: vec![
    // rust: Notice::Multiplayer(ban),
    // rust: Notice::Name("Steve".into()),
    // rust: Notice::Skin
    // rust: ]
    // rust: );
    // rust: assert!(!status.allows_multiplayer());
    // rust: assert!(initial_notices(&AccountStatus::default(), "Steve").is_empty());
    // rust: assert!(AccountStatus::default().allows_multiplayer());
    // rust: let no_servers = AccountStatus {
    // rust: properties: UserProperties {
    // rust: servers_allowed: false,
    // rust: multiplayer_ban: None,
    // rust: },
    // rust: ..Default::default()
}
    // rust: assert!(!no_servers.allows_multiplayer());
}

    /// The message's component JSON: the keys and arguments, whatever language is loaded.
pub fn json(notice: *Notice, now: i64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: notice.message(now).component().to_string()
}

pub fn ban_text_follows_banned_screens() void {
}
    // rust: let temp = |reason: Option<&str>, message: Option<&str>| {
    // rust: Notice::Multiplayer(BanDetails {
    // rust: expires_ms: Some(100 * HOUR),
    // rust: reason: reason.map(str::to_owned),
    // rust: reason_message: message.map(str::to_owned),
    // rust: })
}
    // rust: assert_eq!(
    // rust: temp(None, None).title().translation_key(),
    // rust: Some("gui.banned.title.temporary")
    // rust: );
    // rust: let perm = Notice::Multiplayer(BanDetails {
    // rust: expires_ms: None,
    // rust: reason: Some("5".into()),
    // rust: reason_message: None,
    // rust: });
    // rust: assert_eq!(
    // rust: perm.title().translation_key(),
    // rust: Some("gui.banned.title.permanent")
    // rust: );
    // rust: let text = json(&perm, 0);
    // rust: assert!(text.contains("gui.banned.reason.hate_speech"));
    // rust: assert!(text.contains("gui.banned.description.permanent"));
    // rust: assert!(text.contains(SUSPENSION_HELP));
        // Unknown ids show their code, with the message when there is one.
    // rust: let with_message = json(&temp(Some("999"), Some("why")), 0);
    // rust: assert!(with_message.contains("gui.banned.description.reason_id_message"));
    // rust: assert!(with_message.contains("why"));
    // rust: assert!(json(&temp(Some("999"), None), 0).contains("gui.banned.description.reason_id\""));
    // rust: assert!(json(&temp(Some("abc"), None), 0).contains("gui.banned.description.unknownreason"));
        // 100 hours left is past 72: days (4); less is hours; under an hour is minutes.
    // rust: let duration = |now| json(&temp(None, None), now);
    // rust: assert!(duration(0).contains("gui.days") && duration(0).contains("[4]"));
    // rust: assert!(duration(60 * HOUR).contains("gui.hours") && duration(60 * HOUR).contains("[40]"));
    // rust: let minutes = duration(100 * HOUR - 90_000);
    // rust: assert!(minutes.contains("gui.minutes") && minutes.contains("[1]"));
    // rust: assert!(json(&Notice::Name("Bob".into()), 0).contains("Bob"));
    // rust: assert!(json(&Notice::Skin, 0).contains(SUSPENSION_HELP));
}
}
