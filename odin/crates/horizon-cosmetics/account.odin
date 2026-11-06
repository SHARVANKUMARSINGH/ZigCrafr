//! Transpiled from Horizon Rust crate
package horizon_cosmetics_account

import "core:fmt"
import "core:mem"
import "core:math"

// What the game asks the service about its own account: whether it owns a cosmetic (`GET
// /v1/me`: no other player's cosmetics show for one that owns none, unless the player asks), and
// the settings it changes itself, "Show my cosmetics" (`PUT /v1/visible`) and "Show me as a
// Horizon player" (`POST /v1/presence`, also sent every `PRESENCE_EVERY` while on), and the
// emote its player plays (`POST /v1/emote`, with a session kept for it: `Kept`).
//
// The game signs in the way an online-mode server checks a player: the service hands out a
// one-time server id, the game tells Mojang's session server it joins it (`join`, with the
// player's own Minecraft session), and the service asks Mojang. The Minecraft token goes to
// Mojang only; the service's session lives for this one call and is never kept.
// use serde_json::{Value, json};

// A request to the service: `method` on `path`, with the service's session if any.
    // rust: pub trait Call {
    // rust: fn call(
    // rust: &self,
    // rust: method: &str,
    // rust: path: &str,
    // rust: session: Option<&str>,
    // rust: body: &Value,
    // rust: ) -> Result<Value, String>;
}

    // rust: impl Call for crate::Http {
    // rust: fn call(
    // rust: &self,
    // rust: method: &str,
    // rust: path: &str,
    // rust: session: Option<&str>,
    // rust: body: &Value,
    // rust: ) -> Result<Value, String> {
    // rust: let mut request = self
    // rust: .agent()
    // rust: .request(method, &format!("{}{path}", self.base()))
    // rust: .set("Content-Type", "application/json");
    // rust: if let Some(s) = session {
    // rust: request = request.set("Authorization", &format!("Bearer {s}"));
}
    // rust: let bytes = crate::Http::read(request.send_bytes(body.to_string().as_bytes()))?;
    // rust: serde_json::from_slice(&bytes).map_err(|e| e.to_string())
}
}

// How often a running game tells the service its player plays Horizon (the service's
// `PRESENCE_EVERY`; it forgets them some hours after the last time).
PRESENCE_EVERY :: std::time::Duration::from_secs(3600)

// "Show me as a Horizon player": listed, other Horizon players see the mark by `name`'s name for
// a while (sent again every `PRESENCE_EVERY`); not listed, the service forgets it at once.
    // rust: pub fn set_listed(
    // rust: service: &impl Call,
    // rust: name: &str,
    // rust: join: impl FnOnce(&str) -> Result<(), String>,
    // rust: listed: bool,
    // rust: ) -> Result<bool, String> {
    // rust: let session = sign_in(service, name, join)?;
    // rust: let answer = service.call(
    // rust: "POST",
    // rust: "/v1/presence",
    // rust: Some(&session),
    // rust: &json!({ "listed": listed }),
    // rust: )?;
    // rust: answer["listed"].as_bool().ok_or_else(|| "no answer".into())
}

// A session of the service's own for the account `name`; `join` tells Mojang that account joins
// the server id the service chose.
    // rust: fn sign_in(
    // rust: service: &impl Call,
    // rust: name: &str,
    // rust: join: impl FnOnce(&str) -> Result<(), String>,
    // rust: ) -> Result<String, String> {
    // rust: let mut join = Some(join);
    // rust: sign_in_for(service, name, &mut |id: &str| {
    // rust: join.take().ok_or("joined twice")?(id)
    // rust: })
    // rust: .map(|(session, _)| session)
}

// `sign_in`, with how long the session lives (seconds; an hour if the service didn't say).
    // rust: fn sign_in_for(
    // rust: service: &impl Call,
    // rust: name: &str,
    // rust: join: &mut impl FnMut(&str) -> Result<(), String>,
    // rust: ) -> Result<(String, u64), String> {
    // rust: let start = service.call("POST", "/v1/auth/start", None, &json!({}))?;
    // rust: let server_id = start["server_id"].as_str().ok_or("no server id")?;
    // rust: join(server_id)?;
    // rust: let finish = service.call(
    // rust: "POST",
    // rust: "/v1/auth/finish",
    // rust: None,
    // rust: &json!({ "server_id": server_id, "name": name }),
    // rust: )?;
    // rust: let session = finish["session"].as_str().ok_or("no session")?.to_owned();
    // rust: Ok((session, finish["expires_in"].as_u64().unwrap_or(3600)))
}

// The service's session for an emote's start and stop, kept for the time the service gave less a
// minute: emotes come often, Mojang's `join` shouldn't each time.
Kept :: struct {
    session: Option<(string,
}

    // rust: impl Kept {
    // `method` on `path` with `body` as the account `name`, signing in first if no session is
    // kept; a session the service no longer knows (401) is dropped and the call made once more
    // after a sign-in.
    // rust: pub fn call(
    // rust: &mut self,
    // rust: service: &impl Call,
    // rust: name: &str,
    // rust: mut join: impl FnMut(&str) -> Result<(), String>,
    // rust: method: &str,
    // rust: path: &str,
    // rust: body: &Value,
    // rust: ) -> Result<Value, String> {
    // rust: for attempt in 0..2 {
    // rust: let fresh = self
    // rust: .session
    // rust: .as_ref()
    // rust: .filter(|(_, until)| std::time::Instant::now() < *until);
    // rust: let session = match fresh {
    // rust: Some((s, _)) => s.clone(),
    // rust: None => {
    // rust: let (session, seconds) = sign_in_for(service, name, &mut join)?;
    // rust: let keep = std::time::Duration::from_secs(seconds.saturating_sub(60));
    // rust: self.session = Some((session.clone(), std::time::Instant::now() + keep));
    // rust: session
}
}
    // rust: match service.call(method, path, Some(&session), body) {
    // rust: Err(e) if e == "HTTP 401" && attempt == 0 => self.session = None,
    // rust: answer => return answer,
}
}
    // rust: Err("HTTP 401".into())
}
}

// Tells the service the player plays the owned emote `emote` now (`None`: stopped); only while
// they show themselves as a Horizon player (else the service answers 409).
    // rust: pub fn play_emote(
    // rust: kept: &mut Kept,
    // rust: service: &impl Call,
    // rust: name: &str,
    // rust: join: impl FnMut(&str) -> Result<(), String>,
    // rust: emote: Option<&str>,
    // rust: ) -> Result<(), String> {
    // rust: kept.call(
    // rust: service,
    // rust: name,
    // rust: join,
    // rust: "POST",
    // rust: "/v1/emote",
    // rust: &json!({ "emote": emote }),
    // rust: )
    // rust: .map(|_| ())
}

// An emote the account owns: its item and its names by locale (`en_us`, `fr_fr`...).
    // rust: pub type OwnedEmote = (crate::Item, std::collections::BTreeMap<String, String>);

// The emotes the account `name` owns (`GET /v1/me`'s `emotes`: id, file hash, names), their
// files read with `get` (`/v1/items/<id>?hash=`). A file that fails to come or to parse, or
// isn't the emote it says, is left out.
    // rust: pub fn owned_emotes(
    // rust: kept: &mut Kept,
    // rust: service: &impl Call,
    // rust: name: &str,
    // rust: join: impl FnMut(&str) -> Result<(), String>,
    // rust: get: impl Fn(&str) -> Result<Vec<u8>, String>,
    // rust: ) -> Result<Vec<OwnedEmote>, String> {
    // rust: let me = kept.call(service, name, join, "GET", "/v1/me", &Value::Null)?;
    // rust: let mut emotes = Vec::new();
    // rust: for e in me["emotes"].as_array().into_iter().flatten() {
    // rust: let (Some(id), Some(hash)) = (e["id"].as_str(), e["hash"].as_str()) else {
    // rust: continue;
}
    // rust: let item = get(&format!("/v1/items/{id}?hash={hash}"))
    // rust: .ok()
    // rust: .and_then(|bytes| crate::Item::parse(&bytes).ok())
    // rust: .filter(|i| i.slot == crate::Slot::Emote && i.id == id);
    // rust: let Some(item) = item else {
    // rust: continue;
}
    // rust: let names = e["names"]
    // rust: .as_object()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(|(k, v)| Some((k.clone(), v.as_str()?.to_owned())))
    // rust: .collect();
    // rust: emotes.push((item, names));
}
    // rust: Ok(emotes)
}

// Whether the account `name` owns at least one cosmetic (signed in as `set_visible` does).
    // rust: pub fn owns(
    // rust: service: &impl Call,
    // rust: name: &str,
    // rust: join: impl FnOnce(&str) -> Result<(), String>,
    // rust: ) -> Result<bool, String> {
    // rust: let session = sign_in(service, name, join)?;
    // rust: let me = service.call("GET", "/v1/me", Some(&session), &Value::Null)?;
    // rust: let owned = me["owned"].as_array().ok_or("no answer")?;
    // rust: Ok(!owned.is_empty())
}

// Turns "Show my cosmetics" on or off for the account `name`; `join` tells Mojang that account
// joins the server id the service chose. Returns what the service now keeps.
    // rust: pub fn set_visible(
    // rust: service: &impl Call,
    // rust: name: &str,
    // rust: join: impl FnOnce(&str) -> Result<(), String>,
    // rust: visible: bool,
    // rust: ) -> Result<bool, String> {
    // rust: let session = sign_in(service, name, join)?;
    // rust: let session = session.as_str();
    // rust: let me = service.call(
    // rust: "PUT",
    // rust: "/v1/visible",
    // rust: Some(session),
    // rust: &json!({ "visible": visible }),
    // rust: )?;
    // rust: me["visible"].as_bool().ok_or_else(|| "no answer".into())
}

    // rust: mod tests {
//     use super::*;
//     use std::cell::RefCell;

    // The service, as far as this call goes: what it was sent, and whether the id was joined.
Service :: struct {
    sent: RefCell<Vec<(string,
    joined: RefCell<Maybe(string)>,
        // What `GET /v1/me` lists as owned.
    owned: [dynamic]^'static str,
}

    // rust: impl Call for Service {
    // rust: fn call(
    // rust: &self,
    // rust: method: &str,
    // rust: path: &str,
    // rust: s: Option<&str>,
    // rust: body: &Value,
    // rust: ) -> Result<Value, String> {
    // rust: self.sent.borrow_mut().push((
    // rust: method.into(),
    // rust: path.into(),
    // rust: s.map(Into::into),
    // rust: body.clone(),
    // rust: ));
    // rust: match path {
    // rust: "/v1/auth/start" => Ok(json!({"server_id": "id-1"})),
    // rust: "/v1/auth/finish" if self.joined.borrow().as_deref() == Some("id-1") => {
    // rust: Ok(json!({"session": "svc"}))
}
    // rust: "/v1/auth/finish" => Err("HTTP 401".into()),
    // rust: "/v1/visible" if s == Some("svc") => Ok(json!({"visible": body["visible"]})),
    // rust: "/v1/me" if s == Some("svc") => Ok(json!({
    // rust: "owned": self.owned,
    // rust: "emotes": [
    // rust: {"id": "wave", "hash": "h1", "names": {"en_us": "Wave", "fr_fr": "Coucou"}},
    // rust: {"id": "gone", "hash": "h1", "names": {}},
    // rust: {"id": "hat", "hash": "h1", "names": {}},
    // rust: ],
    // rust: })),
    // rust: "/v1/presence" if s == Some("svc") => Ok(json!({"listed": body["listed"]})),
    // rust: "/v1/emote" if s == Some("svc") => Ok(json!({"emote": body["emote"]})),
    // rust: _ => Err("HTTP 401".into()),
}
}
}

hiding_goes_through_mojang_and_sends_only_the_services_session :: proc() {
}
    // rust: let service = Service::default();
    // rust: let shown = set_visible(
    // rust: &service,
    // rust: "Alex",
    // rust: |id| {
    // rust: *service.joined.borrow_mut() = Some(id.to_owned());
    // rust: Ok(())
    // rust: },
    // rust: false,
    // rust: );
    // rust: assert_eq!(shown, Ok(false));
    // rust: let sent = service.sent.borrow();
    // rust: let paths: Vec<&str> = sent.iter().map(|(_, p, ..)| p.as_str()).collect();
    // rust: assert_eq!(paths, ["/v1/auth/start", "/v1/auth/finish", "/v1/visible"]);
    // rust: assert_eq!(sent[1].3["name"], "Alex");
        // Only the last call carries a session, and it is the service's own.
    // rust: let sessions: Vec<Option<&str>> = sent.iter().map(|(.., s, _)| s.as_deref()).collect();
    // rust: assert_eq!(sessions, [None, None, Some("svc")]);
}

ownership_is_whether_the_accounts_own_list_has_anything :: proc() {
}
joined :: proc(service: ^Service) -> i {
    // Ported from Horizon
    return {}
}
    // rust: move |id| {
    // rust: *service.joined.borrow_mut() = Some(id.to_owned());
    // rust: Ok(())
}
}
    // rust: let none = Service::default();
    // rust: assert_eq!(owns(&none, "Alex", joined(&none)), Ok(false));
    // rust: let founder = Service {
    // rust: owned: vec!["founder_visor"],
    // rust: ..Service::default()
}
    // rust: assert_eq!(owns(&founder, "Alex", joined(&founder)), Ok(true));
    // rust: let sent = founder.sent.borrow();
    // rust: assert_eq!(
    // rust: sent.last()
    // rust: .map(|c| (c.0.as_str(), c.1.as_str(), c.2.as_deref())),
    // rust: Some(("GET", "/v1/me", Some("svc")))
    // rust: );
    // rust: drop(sent);
        // Mojang refusing the join: no answer, so the game keeps the vanilla look.
    // rust: assert!(owns(&founder, "Alex", |_| Err("403".into())).is_err());
}

mojang_refusing_stops_before_the_service_is_asked_to_trust_it :: proc() {
}
    // rust: let service = Service::default();
    // rust: let refused = set_visible(&service, "Alex", |_| Err("403".into()), false);
    // rust: assert_eq!(refused, Err("403".into()));
    // rust: assert_eq!(service.sent.borrow().len(), 1);
        // A join Mojang never saw: the service refuses the id.
    // rust: assert!(set_visible(&service, "Alex", |_| Ok(()), false).is_err());
}

emotes_sign_in_once_and_again_only_when_the_session_is_gone :: proc() {
}
    // rust: let service = Service::default();
    // rust: let joins = std::cell::Cell::new(0);
    // rust: let join = |id: &str| {
    // rust: joins.set(joins.get() + 1);
    // rust: *service.joined.borrow_mut() = Some(id.to_owned());
    // rust: Ok(())
}
    // rust: let mut kept = Kept::default();
    // rust: for emote in [Some("wave_hello"), None, Some("wave_hello")] {
    // rust: play_emote(&mut kept, &service, "Alex", join, emote).unwrap();
}
    // rust: assert_eq!(joins.get(), 1);
    // rust: let sent = service.sent.borrow();
    // rust: let emotes: Vec<(&str, Option<&str>, &Value)> = sent
    // rust: .iter()
    // rust: .filter(|c| c.1 == "/v1/emote")
    // rust: .map(|c| (c.0.as_str(), c.2.as_deref(), &c.3))
    // rust: .collect();
    // rust: assert_eq!(emotes.len(), 3);
    // rust: assert_eq!(
    // rust: emotes[0],
    // rust: ("POST", Some("svc"), &json!({"emote": "wave_hello"}))
    // rust: );
    // rust: assert_eq!(emotes[1].2, &json!({"emote": null}));
    // rust: drop(sent);
        // The service forgot the session (a restart): one more sign-in, then the call.
    // rust: kept.session = Some((
    // rust: "stale".into(),
    // rust: std::time::Instant::now() + std::time::Duration::from_secs(60),
    // rust: ));
    // rust: play_emote(&mut kept, &service, "Alex", join, Some("wave_hello")).unwrap();
    // rust: assert_eq!(joins.get(), 2);
}

the_wheel_gets_the_owned_emotes_files_and_names :: proc() {
}
    // rust: let service = Service::default();
    // rust: let join = |id: &str| {
    // rust: *service.joined.borrow_mut() = Some(id.to_owned());
    // rust: Ok(())
}
    // rust: let emote = r#"{"format": 1, "id": "wave", "slot": "emote", "parts": [],
    // rust: "emote": {"length": 20, "tracks": [{"part": "right_arm", "keys": [{"t": 0}, {"t": 10, "rotation": [0, 0, 90]}]}]}}"#;
    // rust: let asked = RefCell::new(Vec::new());
    // rust: let get = |path: &str| {
    // rust: asked.borrow_mut().push(path.to_owned());
    // rust: match path {
    // rust: "/v1/items/wave?hash=h1" => Ok(emote.as_bytes().to_vec()),
                // A file that says it is the emote `wave`, asked for as `hat`.
    // rust: "/v1/items/hat?hash=h1" => Ok(emote.as_bytes().to_vec()),
    // rust: _ => Err("HTTP 404".to_owned()),
}
}
    // rust: let mut kept = Kept::default();
    // rust: let owned = owned_emotes(&mut kept, &service, "Alex", join, get).unwrap();
    // rust: assert_eq!(owned.len(), 1);
    // rust: assert_eq!(owned[0].0.id, "wave");
    // rust: assert_eq!(owned[0].1["fr_fr"], "Coucou");
    // rust: assert_eq!(asked.borrow().len(), 3);
    // rust: let sent = service.sent.borrow();
    // rust: assert_eq!(
    // rust: sent.last()
    // rust: .map(|c| (c.0.as_str(), c.1.as_str(), c.2.as_deref())),
    // rust: Some(("GET", "/v1/me", Some("svc")))
    // rust: );
}

leaving_the_list_signs_in_the_same_way :: proc() {
}
    // rust: let service = Service::default();
    // rust: let join = |id: &str| {
    // rust: *service.joined.borrow_mut() = Some(id.to_owned());
    // rust: Ok(())
}
    // rust: assert_eq!(set_listed(&service, "Alex", join, false), Ok(false));
    // rust: let sent = service.sent.borrow();
    // rust: assert_eq!(sent[2].1, "/v1/presence");
    // rust: assert_eq!(
    // rust: (sent[2].2.as_deref(), &sent[2].3),
    // rust: (Some("svc"), &json!({"listed": false}))
    // rust: );
}
}
