//! Transpiled from Horizon Rust crate
package horizon_client_chat_filter

import "core:fmt"
import "core:mem"
import "core:math"

// The chat filter on the server side (docs/chat-filter.md): a player's text, before the server relays
// it, through `horizon_chat_filter`'s list, mutes and escalation. A refused text reaches nobody; the
// sender is told in private, and the game logs it and bans when the escalation says so
// (`HostEvent::ChatFiltered`).
// use super::{HostEvent, Hub, chat::now_millis};
// use horizon_chat_filter::{Action, Guard, Mute, duration_text};
// use horizon_protocol::{
    // rust: packets::play::{self, Clientbound as C},
    // rust: text::literal,
}
// use horizon_world::nbt::{JavaString, Tag};

// Where a player's text was going.
Place :: enum {
    // A chat message.
    Chat,
    // A command's message: `/msg`, `/tell`, `/w`, `/me`, `/say`, `/teammsg`.
    Command,
    Sign,
    Anvil,
    Book,
}

    // rust: impl Place {
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Place::Chat => "chat",
    // rust: Place::Command => "command",
    // rust: Place::Sign => "sign",
    // rust: Place::Anvil => "anvil",
    // rust: Place::Book => "book",
}
}
    // Chat and commands: a muted player can't use them.
is_chat :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(self, Place::Chat | Place::Command)
}
}

// What the sender reads when their text held a slur.
notice :: proc(place: Place, action: Action, now: i64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let refused = match place {
    // rust: Place::Chat | Place::Command => "That message wasn't sent",
    // rust: Place::Sign => "That sign wasn't changed",
    // rust: Place::Anvil => "That name wasn't used",
    // rust: Place::Book => "That book wasn't signed",
}
    // rust: match action {
    // rust: Action::Muted { until } => format!(
    // rust: "{refused}: slurs aren't allowed here. You're muted for {}.",
    // rust: duration_text(until - now)
    // rust: ),
    // rust: _ => format!("{refused}: slurs aren't allowed here."),
}
}

// What a muted player reads: when they try to chat, and when an operator mutes them.
muted_notice :: proc(mute: ^Mute, now: i64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let time = match mute.until {
        // "2 more minutes".
    // rust: Some(until) => format!(
    // rust: "for {}",
    // rust: duration_text(until - now).replacen(' ', " more ", 1)
    // rust: ),
    // rust: None => "until an operator unmutes you".into(),
}
    // rust: let why = match (&mute.by, &mute.reason) {
    // rust: (None, _) => "slurs aren't allowed here",
    // rust: (Some(_), Some(reason)) => reason,
    // rust: (Some(_), None) => "",
}
    // rust: if why.is_empty() {
    // rust: format!("You're muted {time}.")
    // rust: } else {
    // rust: format!("You're muted {time}: {why}.")
}
}

// The text in red.
red :: proc(text: string) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let mut t = literal(text);
    // rust: if let Tag::Compound(map) = &mut t {
    // rust: map.insert(
    // rust: JavaString::from("color"),
    // rust: Tag::String(JavaString::from("red")),
    // rust: );
}
    // rust: t
}

    // rust: impl Hub {
    // `server.toml`'s `[chat_filter]` (dedicated servers); `None` turns it off.
set_chat_filter :: proc(self: ^Self, guard: Maybe(Guard)) {
}
    // rust: self.chat_filter = guard.map(Box::new);
}

chat_filter_on :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.chat_filter.is_some()
}

    // Whether guest `i` may send `texts` (`place` says where to): true without a filter. A refusal
    // tells the sender, counts a hit when a text holds a slur, and pushes `ChatFiltered`.
    // rust: pub fn chat_allowed(
    // rust: &mut self,
    // rust: i: usize,
    // rust: texts: &[&str],
    // rust: place: Place,
    // rust: events: &mut Vec<HostEvent>,
    // rust: ) -> bool {
    // rust: let Some(guard) = self.chat_filter.as_deref_mut() else {
    // rust: return true;
}
    // rust: let (uuid, now) = (self.guests[i].uuid, now_millis());
    // rust: let hit = texts.iter().any(|t| guard.filter.matches(t));
    // rust: let muted = place.is_chat().then(|| guard.muted(uuid, now)).flatten();
    // rust: if !hit {
    // rust: let Some(mute) = muted else {
    // rust: return true;
}
    // rust: let text = muted_notice(mute, now);
    // rust: self.guests[i].send(&C::SystemChat(play::SystemChat {
    // rust: content: red(&text),
    // rust: overlay: false,
    // rust: }));
    // rust: return false;
}
        // An anvil renames at every key typed: refused quietly, on the action bar, with no hit.
    // rust: if place == Place::Anvil {
    // rust: self.guests[i].send(&C::SystemChat(play::SystemChat {
    // rust: content: red(&notice(place, Action::Refused, now)),
    // rust: overlay: true,
    // rust: }));
    // rust: return false;
}
    // rust: let name = self.guests[i].name.clone();
    // rust: let (count, action) = guard.strike(uuid, &name, now);
    // rust: if !matches!(action, Action::Banned { .. }) {
    // rust: self.guests[i].send(&C::SystemChat(play::SystemChat {
    // rust: content: red(&notice(place, action, now)),
    // rust: overlay: false,
    // rust: }));
}
    // rust: events.push(HostEvent::ChatFiltered {
    // rust: sender: uuid,
    // rust: name,
    // rust: place,
    // rust: text: texts.join(" | "),
    // rust: count,
    // rust: action,
    // rust: });
    // rust: false
}

    // An operator's `/mute` or `/tempmute`; the player is told if they are here.
    // rust: pub fn mute(
    // rust: &mut self,
    // rust: uuid: u128,
    // rust: name: &str,
    // rust: until: Option<i64>,
    // rust: by: &str,
    // rust: reason: Option<String>,
    // rust: ) {
    // rust: let Some(guard) = self.chat_filter.as_deref_mut() else {
    // rust: return;
}
    // rust: let now = now_millis();
    // rust: guard.mute(uuid, name, until, by, reason);
    // rust: let Some(text) = guard.muted(uuid, now).map(|m| muted_notice(m, now)) else {
    // rust: return;
}
    // rust: for g in self.guests.iter().filter(|g| g.uuid == uuid) {
    // rust: g.send(&C::SystemChat(play::SystemChat {
    // rust: content: red(&text),
    // rust: overlay: false,
    // rust: }));
}
}

    // The mutes in force, by name.
mutes :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.chat_filter.as_deref().map_or_else(Vec::new, |g| {
    // rust: g.mutes(now_millis()).into_iter().cloned().collect()
    // rust: })
}

    // `/unmute <player>`: the name as it was muted, if they were.
unmute :: proc(self: ^Self, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.chat_filter.as_deref_mut()?.unmute(name)
}

    // The `[chat_filter]` log's path, relative to the server's folder.
chat_filter_log :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.chat_filter
    // rust: .as_deref()
    // rust: .map(|g| g.config.log.as_str())
    // rust: .filter(|l| !l.is_empty())
}
}

    // rust: mod tests {
//     use super::*;

the_sender_is_told_why :: proc() {
}
    // rust: let now = 1_000_000;
    // rust: assert_eq!(
    // rust: notice(Place::Chat, Action::Refused, now),
    // rust: "That message wasn't sent: slurs aren't allowed here."
    // rust: );
    // rust: assert_eq!(
    // rust: notice(
    // rust: Place::Command,
    // rust: Action::Muted {
    // rust: until: now + 600_000
    // rust: },
    // rust: now
    // rust: ),
    // rust: "That message wasn't sent: slurs aren't allowed here. You're muted for 10 minutes."
    // rust: );
    // rust: let mute = |until, by: Option<&str>, reason: Option<&str>| Mute {
    // rust: uuid: String::new(),
    // rust: name: "Ann".into(),
    // rust: until,
    // rust: by: by.map(Into::into),
    // rust: reason: reason.map(Into::into),
}
    // rust: assert_eq!(
    // rust: muted_notice(&mute(Some(now + 61_000), None, None), now),
    // rust: "You're muted for 2 more minutes: slurs aren't allowed here."
    // rust: );
    // rust: assert_eq!(
    // rust: muted_notice(&mute(None, Some("Op"), Some("spam")), now),
    // rust: "You're muted until an operator unmutes you: spam."
    // rust: );
    // rust: assert_eq!(
    // rust: muted_notice(&mute(Some(now + 7_200_000), Some("Op"), None), now),
    // rust: "You're muted for 2 more hours."
    // rust: );
    // rust: assert_eq!(
    // rust: notice(Place::Sign, Action::Refused, now),
    // rust: "That sign wasn't changed: slurs aren't allowed here."
    // rust: );
    // rust: assert!(Place::Chat.is_chat() && Place::Command.is_chat() && !Place::Sign.is_chat());
}
}
