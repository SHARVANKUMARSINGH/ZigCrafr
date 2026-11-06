//! Transpiled from Horizon Rust crate
package horizon_client_text_commands

import "core:fmt"
import "core:mem"
import "core:math"

// `/tellraw` (TellRawCommand) and `/title` (TitleCommand).
// use super::{Arg, Context, Game, R, Target, err};
// use horizon_client::{hud_overlays::Titles, lan::data::component_nbt, text::Text};
// use horizon_protocol::packets::play::{self, Clientbound as C};

// `EntitySelector.COMPILABLE_CODEC` (`CompilableString.CommandParserHelper.apply`):
// the `selector` of a selector component and the `entity` of an nbt
// component are parsed when the component is decoded, and text left after
// the selector is `command.trailing_data`. Either failure makes the whole
// component invalid, with vanilla's message. (A score `name` is an `Either`
// that falls back to a plain name, so it never fails.)
    // rust: fn invalid_selector(
    // rust: v: &serde_json::Value,
    // rust: reg: &horizon_client::command::Registries,
    // rust: ) -> Option<String> {
    // rust: match v {
    // rust: serde_json::Value::Array(a) => a.iter().find_map(|x| invalid_selector(x, reg)),
    // rust: serde_json::Value::Object(o) => {
    // rust: let source = o.get("selector").and_then(|s| s.as_str()).or_else(|| {
    // rust: o.contains_key("nbt")
    // rust: .then(|| o.get("entity").and_then(|s| s.as_str()))
    // rust: .flatten()
    // rust: });
    // rust: if let Some(source) = source
    // rust: && let Some(why) = compile_selector(source, reg)
    // rust: {
    // rust: return Some(format!("Invalid selector component: {source}: {why}"));
}
    // rust: o.values().find_map(|x| invalid_selector(x, reg))
}
    // rust: _ => None,
}
}

// `EntitySelectorParser.parse` on all of `source`; the error's
// `getMessage` on failure.
compile_selector :: proc(source: string, reg: ^horizon_client::command::Registries) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut reader = horizon_client::command::Reader::new(source);
    // rust: match horizon_client::command::selector::parse(&mut reader, reg, true) {
    // rust: Err(e) => Some(match e.context() {
    // rust: Some(context) => format!("{} at position {}: {context}", e.message.plain(), e.cursor),
    // rust: None => e.message.plain(),
    // rust: }),
    // rust: Ok(_) if reader.can_read() => {
    // rust: let parsed = &source[..reader.cursor];
    // rust: let leftovers = &source[reader.cursor..];
    // rust: Some(
    // rust: horizon_client::text::Text::tr(
    // rust: "command.trailing_data",
    // rust: &[&format!("{parsed}[{leftovers}]")],
    // rust: )
    // rust: .plain(),
    // rust: )
}
    // rust: Ok(_) => None,
}
}

    // rust: impl Game<'_> {
    // ComponentArgument with selectors resolved for the source
    // (ComponentUtils.updateForEntity: names joined by ", ").
    // rust: pub(in crate::game) fn component_arg(&mut self, ctx: &Context, name: &str) -> R<Text> {
    // rust: let Some(Arg::Str(json)) = ctx.get(name) else {
    // rust: return Ok(Text::empty());
}
    // rust: let value: serde_json::Value =
    // rust: serde_json::from_str(json).map_err(|e| err("argument.component.invalid", &[&e]))?;
    // rust: if let Some(message) = invalid_selector(&value, &self.ui.registries) {
    // rust: return Err(err("argument.component.invalid", &[&message]));
}
        // NbtContents.resolve: the path's values in the entity, block or
        // storage data, rich-styled (or plain, or interpreted), ", "-joined.
        // ScoreContents.resolve: the holder's score in the objective.
    // rust: let nbt_values = std::cell::RefCell::new(Vec::new());
    // rust: {
    // rust: let mut collect = |o: &serde_json::Map<String, serde_json::Value>| {
    // rust: if o.contains_key("nbt") || o.contains_key("score") {
    // rust: nbt_values.borrow_mut().push(o.clone());
}
}
    // rust: fn walk(
    // rust: v: &serde_json::Value,
    // rust: f: &mut dyn FnMut(&serde_json::Map<String, serde_json::Value>),
    // rust: ) {
    // rust: match v {
    // rust: serde_json::Value::Object(o) => {
    // rust: f(o);
    // rust: for (_, x) in o {
    // rust: walk(x, f);
}
}
    // rust: serde_json::Value::Array(a) => a.iter().for_each(|x| walk(x, f)),
    // rust: _ => {}
}
}
    // rust: walk(&value, &mut collect);
}
    // rust: let mut resolved: Vec<(serde_json::Map<String, serde_json::Value>, Text)> = Vec::new();
    // rust: for o in nbt_values.into_inner() {
    // rust: let t = if o.contains_key("score") {
    // rust: self.resolve_score_component(&o)?
    // rust: } else {
    // rust: self.resolve_nbt_component(&o)
}
    // rust: resolved.push((o, t));
}
    // rust: let mut resolve = |raw: &str| -> Text {
    // rust: let mut reader = horizon_client::command::Reader::new(raw);
    // rust: let entities = horizon_client::command::args::ArgType::Entity {
    // rust: single: false,
    // rust: players: false,
}
    // rust: let Ok(Arg::Entity(sel)) = entities.parse(&mut reader, &self.ui.registries) else {
    // rust: return Text::literal(raw);
}
    // rust: let found = self.select(&sel);
    // rust: let mut out = Text::empty();
    // rust: for (i, t) in found.into_iter().enumerate() {
    // rust: if i > 0 {
    // rust: out.push(Text::literal(", "));
}
    // rust: out.push(self.target_name(t));
}
    // rust: out
}
    // rust: Ok(horizon_client::component::to_text_with(
    // rust: &value,
    // rust: &mut resolve,
    // rust: &mut |o| {
    // rust: resolved
    // rust: .iter()
    // rust: .find(|(k, _)| k == o)
    // rust: .map(|(_, t)| t.clone())
    // rust: },
    // rust: ))
}
    // The text of a `score` component (ScoreContents.resolve): the named
    // holder's score, `*` being the player the command runs for.
    // rust: fn resolve_score_component(
    // rust: &mut self,
    // rust: o: &serde_json::Map<String, serde_json::Value>,
    // rust: ) -> R<Text> {
    // rust: let score = o.get("score");
    // rust: let field = |k: &str| score.and_then(|s| s.get(k)).and_then(|v| v.as_str());
    // rust: let (name, objective) = (
    // rust: field("name").unwrap_or(""),
    // rust: field("objective").unwrap_or(""),
    // rust: );
        // findTargetName: a selector that matches one entity is that entity,
        // one that matches none is just the name.
    // rust: let mut reader = horizon_client::command::Reader::new(name);
    // rust: let ty = horizon_client::command::args::ArgType::Entity {
    // rust: single: false,
    // rust: players: false,
}
    // rust: let mut holder = name.to_owned();
    // rust: if let Ok(Arg::Entity(sel)) = ty.parse(&mut reader, &self.ui.registries)
    // rust: && !reader.can_read()
    // rust: {
    // rust: let found = self.select(&sel);
    // rust: if found.len() > 1 {
    // rust: return Err(err("argument.entity.toomany", &[]));
}
    // rust: if let Some(t) = found.first().and_then(|t| self.holder_name(*t)) {
    // rust: holder = t;
}
}
    // rust: if holder == "*" {
    // rust: holder = self.acting_player_name().to_owned();
}
    // rust: let board = &self.score.board;
    // rust: let (Some(objective), Some(score)) =
    // rust: (board.objective(objective), board.score(&holder, objective))
    // rust: else {
    // rust: return Ok(Text::empty());
}
        // numberFormatOrDefault(StyledFormat.NO_STYLE).
    // rust: let format = (score.number_format.clone())
    // rust: .or_else(|| objective.number_format.clone())
    // rust: .unwrap_or(horizon_client::scoreboard::NumberFormat::Styled(
    // rust: serde_json::json!({}),
    // rust: ));
    // rust: Ok(format.format(score.value))
}
    // The text of an `nbt` component.
resolve_nbt_component :: proc(self: ^Self, o: ^serde_json::Map<string, serde_json: :Value>) -> T {
    // Ported from Horizon
    return {}
}
//         use horizon_world::nbt::Tag;
    // rust: let path = o.get("nbt").and_then(|v| v.as_str()).unwrap_or("");
    // rust: let mut sources: Vec<Tag> = Vec::new();
    // rust: if let Some(sel) = o.get("entity").and_then(|v| v.as_str()) {
    // rust: let mut reader = horizon_client::command::Reader::new(sel);
    // rust: let ty = horizon_client::command::args::ArgType::Entity {
    // rust: single: false,
    // rust: players: false,
}
    // rust: if let Ok(Arg::Entity(s)) = ty.parse(&mut reader, &self.ui.registries) {
    // rust: for t in self.select(&s) {
    // rust: if let Ok(tag) = self.data_of(&super::data::DataRef::Entity(t)) {
    // rust: sources.push(tag);
}
}
}
    // rust: } else if let Some(id) = o.get("storage").and_then(|v| v.as_str()) {
    // rust: let id = if id.contains(':') {
    // rust: id.to_owned()
    // rust: } else {
    // rust: format!("minecraft:{id}")
}
    // rust: sources.push(self.score.storage.get(&id));
    // rust: } else if let Some(pos) = o.get("block").and_then(|v| v.as_str()) {
    // rust: let p: Vec<i32> = pos
    // rust: .split_whitespace()
    // rust: .filter_map(|v| v.parse().ok())
    // rust: .collect();
    // rust: if let [x, y, z] = p[..]
    // rust: && let Ok(tag) = self.data_of(&super::data::DataRef::Block([x, y, z]))
    // rust: {
    // rust: sources.push(tag);
}
}
    // rust: let Ok(compiled) = horizon_client::nbt_path::NbtPath::parse(path) else {
    // rust: return Text::empty();
}
    // rust: let plain = o.get("plain").and_then(|v| v.as_bool()) == Some(true);
    // rust: let interpret = o.get("interpret").and_then(|v| v.as_bool()) == Some(true);
    // rust: let mut out = Text::empty();
    // rust: let mut first = true;
    // rust: for data in &sources {
    // rust: for tag in compiled.get(data).unwrap_or_default() {
    // rust: if !first {
    // rust: out.push(Text::literal(", "));
}
    // rust: first = false;
    // rust: let piece = if interpret {
    // rust: horizon_client::scoreboard::comp_text(&horizon_client::scoreboard::tag_to_json(
    // rust: &tag,
    // rust: ))
    // rust: } else if plain {
    // rust: Text::literal(horizon_client::snbt::pretty(&tag).plain())
    // rust: } else {
    // rust: horizon_client::snbt::pretty(&tag)
}
    // rust: out.push(piece);
}
}
    // rust: out
}
    // The players the command reaches: the window's own and the LAN guests.
player_targets :: proc(self: ^Self, ctx: ^Context) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let targets = self.entities(ctx, "targets", true)?;
    // rust: Ok(targets
    // rust: .into_iter()
    // rust: .filter(|t| matches!(t, Target::Player | Target::Guest(_)))
    // rust: .collect())
}
    // rust: pub(super) fn cmd_tellraw(&mut self, ctx: &Context) -> R<i32> {
    // rust: let players = self.player_targets(ctx)?;
    // rust: let message = self.component_arg(ctx, "message")?;
        // Each player's chat (a guest's through the connection).
    // rust: for &t in &players {
    // rust: self.for_player(t, |g| g.system_message(message.clone()));
}
    // rust: Ok(players.len() as i32)
}
    // rust: pub(super) fn cmd_title(&mut self, ctx: &Context) -> R<i32> {
    // rust: let players = self.player_targets(ctx)?;
    // rust: let n = players.len();
    // rust: let name = players
    // rust: .first()
    // rust: .map_or_else(Text::empty, |t| self.target_name(*t));
    // rust: let single = n == 1;
    // rust: let key = if ctx.has("clear") {
    // rust: self.titles_or_packet(
    // rust: &players,
    // rust: Titles::clear,
    // rust: C::ClearTitles(play::Bool1 { value: false }),
    // rust: );
    // rust: "cleared"
    // rust: } else if ctx.has("reset") {
    // rust: self.titles_or_packet(
    // rust: &players,
    // rust: |t| {
    // rust: t.clear();
    // rust: t.reset_times();
    // rust: },
    // rust: C::ClearTitles(play::Bool1 { value: true }),
    // rust: );
    // rust: "reset"
    // rust: } else if ctx.has("times") {
    // rust: let get = |k: &str| match ctx.get(k) {
    // rust: Some(Arg::Int(v)) => *v,
    // rust: _ => -1,
}
    // rust: let (fade_in, stay, fade_out) = (get("fadeIn"), get("stay"), get("fadeOut"));
    // rust: self.titles_or_packet(
    // rust: &players,
    // rust: |t| t.set_times(fade_in, stay, fade_out),
    // rust: C::SetTitlesAnimation(play::TitlesAnimation {
    // rust: fade_in,
    // rust: stay,
    // rust: fade_out,
    // rust: }),
    // rust: );
    // rust: "times"
    // rust: } else {
    // rust: let text = self.component_arg(ctx, "title")?;
    // rust: let sent = play::Text {
    // rust: text: component_nbt(&text.component()),
}
    // rust: if ctx.has("subtitle") {
    // rust: self.titles_or_packet(&players, |t| t.set_subtitle(text), C::SetSubtitleText(sent));
    // rust: "show.subtitle"
    // rust: } else if ctx.has("actionbar") {
    // rust: self.titles_or_packet(
    // rust: &players,
    // rust: |t| t.set_overlay(text, false),
    // rust: C::SetActionBarText(sent),
    // rust: );
    // rust: "show.actionbar"
    // rust: } else {
    // rust: self.titles_or_packet(&players, |t| t.set_title(text), C::SetTitleText(sent));
    // rust: "show.title"
}
}
    // rust: let message = if single {
    // rust: Text::translate(&format!("commands.title.{key}.single"), &[name])
    // rust: } else {
    // rust: Text::translate(
    // rust: &format!("commands.title.{key}.multiple"),
    // rust: &[Text::literal(n.to_string())],
    // rust: )
}
    // rust: self.feedback(message);
    // rust: Ok(n as i32)
}
    // TitleCommand's `connection.send` for each player: a guest is sent the
    // packet, the window's own player shows it.
titles_or_packet :: proc(self: ^Self, players: ^[Target], local: impl FnOnce(^Titles) {
}
    // rust: let mut local = Some(local);
    // rust: for &t in players {
    // rust: match t {
    // rust: Target::Player if self.lan_acting.is_some() => {
    // rust: self.guest_packets.push(packet.clone());
}
    // rust: Target::Player => {
    // rust: if let Some(local) = local.take() {
    // rust: local(&mut self.titles);
}
}
    // rust: Target::Guest(conn) => {
    // rust: if let Some(host) = self.lan.as_ref() {
    // rust: host.hub.send_to(conn, &packet);
}
}
    // rust: _ => {}
}
}
}
}

    // rust: mod tests {
//     use super::invalid_selector;
//     use horizon_client::command::Registries;

check :: proc(json: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: invalid_selector(&serde_json::from_str(json).unwrap(), &Registries::default())
}

a_selector_component_is_compiled_when_decoded :: proc() {
}
    // rust: assert_eq!(check(r#"{"selector":"@a"}"#), None);
    // rust: let bad = check(r#"{"selector":"@a[x"}"#).unwrap();
    // rust: assert!(
    // rust: bad.starts_with("Invalid selector component: @a[x: "),
    // rust: "{bad}"
    // rust: );
}

text_after_the_selector_is_trailing_data :: proc() {
}
    // rust: let bad = check(r#"["x",{"extra":[{"selector":"@s foo"}]}]"#).unwrap();
    // rust: assert!(
    // rust: bad.starts_with("Invalid selector component: @s foo: "),
    // rust: "{bad}"
    // rust: );
    // rust: assert!(
    // rust: bad.contains("command.trailing_data") || bad.contains("Trailing"),
    // rust: "{bad}"
    // rust: );
}

an_nbt_entity_is_compiled_and_a_score_name_is_not :: proc() {
}
    // rust: assert!(check(r#"{"nbt":"a","entity":"@e[type"}"#).is_some());
    // rust: assert_eq!(check(r#"{"nbt":"a","storage":"x:y"}"#), None);
    // rust: assert_eq!(
    // rust: check(r#"{"score":{"name":"@a foo","objective":"o"}}"#),
    // rust: None
    // rust: );
}
}
