//! Transpiled from Horizon Rust crate
//! Module: horizon-server-files_profiles
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Finding a player's account by name, as an online-mode server does for the
//! names given to `op`, `whitelist` and `ban` (CachedUserNameToIdResolver,
//! MinecraftServicesProfileRepository.findProfileByName): the services'
//! `profiles` / `getByName` endpoint, found through the discovery document.
// use crate::{
    // rust: json::{self, Json},
    // rust: user_lists::NameAndId,
}
// use horizon_protocol::rsa::RsaPublicKey;
// use std::time::Duration;

/// Mojang's services discovery document.
pub const DEFAULT_DISCOVERY: []const u8 = "https://discovery.minecraftservices.com/minecraft/client";

/// The discovery document's URL: `HORIZON_API_DISCOVERY` overrides it like
/// authlib's `-Dminecraft.api.discovery.host`.
pub fn discovery_url() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::env::var("HORIZON_API_DISCOVERY")
    // rust: .ok()
    // rust: .filter(|u| !u.is_empty())
    // rust: .unwrap_or_else(|| DEFAULT_DISCOVERY.to_owned())
}

/// StringUtil.isValidPlayerName: at most 16 UTF-16 units, none a control
/// character, a space or above ASCII.
pub fn valid_player_name(name: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: name.encode_utf16().count() <= 16 && name.encode_utf16().all(|c| c > 32 && c < 127)
}

/// How a server resolves a name it was given (CachedUserNameToIdResolver.get,
/// without the usercache.json cache): an offline server makes the offline
/// profile; an online one asks the services (for the name in lower case) and
/// knows nobody they don't.
pub fn resolve(name: []const u8, online: bool) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if online && valid_player_name(name) {
    // rust: find_by_name(&discovery_url(), &name.to_ascii_lowercase())
    // rust: } else {
    // rust: (!online).then(|| NameAndId::offline(name))
}
}

/// MinecraftServicesProfileRepository.findProfileByName: the account named
/// `name` (any case), or None when there is none or the services don't
/// answer (vanilla logs both as "Couldn't find profile with name").
pub fn find_by_name(discovery: []const u8, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let agent = ureq::AgentBuilder::new()
    // rust: .timeout(Duration::from_secs(15))
    // rust: .user_agent(&format!("Horizon/{}", horizon_core::release::VERSION))
    // rust: .build();
    // rust: let doc = json::parse(&agent.get(discovery).call().ok()?.into_string().ok()?, true).ok()?;
    // rust: let url = endpoint(&doc, "profiles", "getByName")?.replace("{name}", &name.to_lowercase());
    // rust: found(&agent.get(&url).call().ok()?.into_string().ok()?, name)
}

/// YggdrasilMinecraftSessionService.fetchProfile(id, true), as the management protocol finds a player given by
/// id that the user cache doesn't know: the `session` / `getProfileById` endpoint, or None.
pub fn find_by_id(discovery: []const u8, id: u128) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let agent = ureq::AgentBuilder::new()
    // rust: .timeout(Duration::from_secs(15))
    // rust: .user_agent(&format!("Horizon/{}", horizon_core::release::VERSION))
    // rust: .build();
    // rust: let doc = json::parse(&agent.get(discovery).call().ok()?.into_string().ok()?, true).ok()?;
    // rust: let url =
    // rust: endpoint(&doc, "session", "getProfileById")?.replace("{profileId}", &format!("{id:032x}"));
    // rust: let separator = if url.contains('?') { '&' } else { '?' };
    // rust: let answer = agent
    // rust: .get(&format!("{url}{separator}unsigned=false"))
    // rust: .call()
    // rust: .ok()?
    // rust: .into_string()
    // rust: .ok()?;
    // rust: let name = json::parse(&answer, true).ok()?.get("name")?.as_string()?;
    // rust: found(&answer, &name).filter(|user| user.id == id)
}

/// MinecraftServicesKeyInfo.get: the services' public keys from the
/// discovery document's `authentication` / `getPublicKeys` endpoint. The
/// profile-key keys (`playerCertificateKeys`, ServicesKeyType.PROFILE_KEY)
/// sign the players' chat keys; secure chat checks them. The error is the
/// line vanilla logs, after which it has no keys.
pub fn fetch_profile_key_keys(discovery: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
pub const FAILED: []const u8 = "Failed to request Minecraft Services public key";
    // rust: let agent = ureq::AgentBuilder::new()
    // rust: .timeout(Duration::from_secs(15))
    // rust: .user_agent(&format!("Horizon/{}", horizon_core::release::VERSION))
    // rust: .build();
    // rust: let get = |url: &str| agent.get(url).call().ok()?.into_string().ok();
    // rust: let doc = get(discovery)
    // rust: .and_then(|d| json::parse(&d, true).ok())
    // rust: .ok_or(FAILED)?;
    // rust: let url = endpoint(&doc, "authentication", "getPublicKeys").ok_or(FAILED)?;
    // rust: profile_key_keys(&get(&url).ok_or(FAILED)?)
}

/// The key set answer: `{"profilePropertyKeys": [...], "playerCertificateKeys":
/// [...]}`, each `{"publicKey": base64 X.509}`. One bad key makes the whole
/// answer malformed (parseList throws).
pub fn profile_key_keys(answer: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
//     use base64::Engine;
pub const MALFORMED: []const u8 = "Received malformed Minecraft Services public key data";
    // rust: let doc = json::parse(answer, true).map_err(|_| MALFORMED)?;
    // rust: let list = |name: &str| -> Result<Vec<RsaPublicKey>, &'static str> {
    // rust: let Some(entries) = doc.get(name) else {
    // rust: return Ok(Vec::new());
}
    // rust: let Json::Array(entries) = entries else {
    // rust: return Err(MALFORMED);
}
    // rust: entries
    // rust: .iter()
    // rust: .map(|e| {
    // rust: let text = e
    // rust: .get("publicKey")
    // rust: .and_then(Json::as_string)
    // rust: .ok_or(MALFORMED)?;
    // rust: let der = base64::engine::general_purpose::STANDARD
    // rust: .decode(text)
    // rust: .map_err(|_| MALFORMED)?;
    // rust: RsaPublicKey::from_der(&der).map_err(|_| MALFORMED)
    // rust: })
    // rust: .collect()
}
    // rust: list("profilePropertyKeys")?;
    // rust: list("playerCertificateKeys")
}

/// MinecraftServicesDiscoveryService.getUrl(service, endpoint).
pub fn endpoint(doc: *Json, service: []const u8, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: doc.get("discovery")?
    // rust: .get(service)?
    // rust: .get("endpoints")?
    // rust: .get(name)?
    // rust: .get("uri")?
    // rust: .as_string()
}

/// The answer, authlib's NameAndId: `{"id", "name"}`, the id undashed.
pub fn found(answer: []const u8, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let profile = json::parse(answer, true).ok()?;
    // rust: let found = profile.get("name")?.as_string()?;
    // rust: let id = profile.get("id")?.as_string()?.replace('-', "");
    // rust: (found.eq_ignore_ascii_case(name) && id.len() == 32).then_some(())?;
    // rust: Some(NameAndId {
    // rust: id: u128::from_str_radix(&id, 16).ok()?,
    // rust: name: found,
    // rust: })
}

    // rust: mod tests {
//     use super::*;

pub fn names_and_answers() void {
}
    // rust: assert!(valid_player_name("Alex_123"));
    // rust: assert!(!valid_player_name("two words"));
    // rust: assert!(!valid_player_name("ThisNameIsTooLong"));
    // rust: assert!(!valid_player_name("caf\u{e9}"));
    // rust: assert_eq!(resolve("Alex", false), Some(NameAndId::offline("Alex")));
    // rust: assert_eq!(resolve("not valid", true), None);
    // rust: let answer = r#"{"id":"069a79f444e94726a5befca90e38aaf5","name":"Notch"}"#;
    // rust: assert_eq!(
    // rust: found(answer, "notch"),
    // rust: Some(NameAndId {
    // rust: id: 0x069a79f444e94726a5befca90e38aaf5,
    // rust: name: "Notch".into()
    // rust: })
    // rust: );
    // rust: assert_eq!(found(answer, "Steve"), None);
    // rust: assert_eq!(found("{}", "Notch"), None);
    // rust: assert_eq!(found("", "Notch"), None);
}

pub fn services_key_sets() void {
}
        // The 1024-bit test key of horizon-protocol's RSA tests, base64.
    // rust: let key = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCrAmB0+SRQqPcm84lbsRF2yo8GXzEAzUFDusT302dO3P+VtBoFJdI2WlScEG7GaFiBs5IXdCD9Mf9cFE/xG6JDEedRzSxrXRgXtq9mhqQ8ldYSQ2EwBeaUW2CTzZUiPOxeiFaCbanS7hsyM2KsHOvqs2WcvEUxmptUDdqBakeY/wIDAQAB";
    // rust: let answer = format!(
    // rust: r#"{{"profilePropertyKeys":[{{"publicKey":"{key}"}}],"playerCertificateKeys":[{{"publicKey":"{key}"}},{{"publicKey":"{key}"}}]}}"#
    // rust: );
    // rust: let keys = profile_key_keys(&answer).unwrap();
    // rust: assert_eq!(keys.len(), 2);
    // rust: assert_eq!(keys[0].size(), 128);
    // rust: assert_eq!(profile_key_keys("{}").unwrap().len(), 0);
    // rust: let bad = r#"{"profilePropertyKeys":[{"publicKey":"AAAA"}],"playerCertificateKeys":[]}"#;
    // rust: assert!(profile_key_keys(bad).is_err());
    // rust: assert!(profile_key_keys("not json").is_err());
}
}
