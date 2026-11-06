//! Transpiled from Horizon Rust crate
package horizon_client_core_component

import "core:fmt"
import "core:mem"
import "core:math"

// Text components from commands: `ComponentArgument` reads an SNBT (or JSON)
// value, `ComponentSerialization` turns it into styled text.
// use crate::text::{InlineObject, Style, Text, named_color};
// use horizon_world::nbt::Tag;
// use serde_json::{Map, Value};

// `SnbtGrammar`, enough for components: compounds, lists, quoted and
// unquoted strings, numbers (with type suffixes) and booleans. Returns the
// value and the bytes consumed.
parse_snbt :: proc(input: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut p = Parser {
    // rust: s: input.as_bytes(),
    // rust: i: 0,
    // rust: depth: 0,
}
    // rust: let v = p.value()?;
    // rust: Ok((v, p.i))
}
// Nesting deeper than NBT's own limit (`NbtAccounter`'s 512) is refused
// rather than overflowing the stack.
SNBT_MAX_DEPTH :: 512
Parser :: struct {
    s: ^'a [u8],
    i: uint,
    depth: uint,
}
    // rust: impl Parser<'_> {
ws :: proc(self: ^Self) {
}
    // rust: while self.i < self.s.len() && self.s[self.i].is_ascii_whitespace() {
    // rust: self.i += 1;
}
}
peek :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.s.get(self.i).copied()
}
expect :: proc(self: ^Self, c: u8) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.ws();
    // rust: if self.peek() == Some(c) {
    // rust: self.i += 1;
    // rust: Ok(())
    // rust: } else {
    // rust: Err(format!("expected '{}'", c as char))
}
}
value :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.ws();
    // rust: match self.peek() {
    // rust: Some(b'{') => {
    // rust: if self.depth >= SNBT_MAX_DEPTH {
    // rust: return Err(format!("tag nesting too deep at {}", self.i));
}
    // rust: self.depth += 1;
    // rust: let v = self.object();
    // rust: self.depth -= 1;
    // rust: v
}
    // rust: Some(b'[') => {
    // rust: if self.depth >= SNBT_MAX_DEPTH {
    // rust: return Err(format!("tag nesting too deep at {}", self.i));
}
    // rust: self.depth += 1;
    // rust: let v = self.array();
    // rust: self.depth -= 1;
    // rust: v
}
    // rust: Some(b'"' | b'\'') => Ok(Value::String(self.string()?)),
    // rust: Some(_) => {
    // rust: let word = self.unquoted();
    // rust: if word.is_empty() {
    // rust: return Err("expected a value".into());
}
    // rust: Ok(match word.as_str() {
    // rust: "true" => Value::Bool(true),
    // rust: "false" => Value::Bool(false),
    // rust: _ => {
    // rust: let digits = word
    // rust: .trim_end_matches(['b', 'B', 's', 'S', 'l', 'L', 'f', 'F', 'd', 'D']);
                        // Only digits (and an exponent) make a number: `nan`
                        // or `Infinity`, which Rust's parse would take, stays
                        // a string.
    // rust: if digits
    // rust: .bytes()
    // rust: .any(|c| c.is_ascii_alphabetic() && c != b'e' && c != b'E')
    // rust: {
    // rust: Value::String(word)
    // rust: } else {
    // rust: match (digits.parse::<i64>(), digits.parse::<f64>()) {
    // rust: (Ok(n), _) if digits.len() + 1 >= word.len() => Value::from(n),
    // rust: (_, Ok(f)) if digits.len() + 1 >= word.len() => Value::from(f),
    // rust: _ => Value::String(word),
}
}
}
    // rust: })
}
    // rust: None => Err("expected a value".into()),
}
}
object :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.i += 1;
    // rust: let mut map = Map::new();
    // rust: self.ws();
    // rust: if self.peek() == Some(b'}') {
    // rust: self.i += 1;
    // rust: return Ok(Value::Object(map));
}
    // rust: loop {
    // rust: self.ws();
    // rust: let key = self.string()?;
    // rust: self.expect(b':')?;
    // rust: map.insert(key, self.value()?);
    // rust: self.ws();
    // rust: match self.peek() {
    // rust: Some(b',') => self.i += 1,
    // rust: Some(b'}') => {
    // rust: self.i += 1;
    // rust: return Ok(Value::Object(map));
}
    // rust: _ => return Err("expected ',' or '}'".into()),
}
}
}
array :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.i += 1;
    // rust: let mut list = Vec::new();
    // rust: self.ws();
        // Typed arrays [B;...], [I;...], [L;...].
    // rust: if matches!(
    // rust: self.s.get(self.i..self.i + 2),
    // rust: Some([b'B' | b'I' | b'L', b';'])
    // rust: ) {
    // rust: self.i += 2;
}
    // rust: self.ws();
    // rust: if self.peek() == Some(b']') {
    // rust: self.i += 1;
    // rust: return Ok(Value::Array(list));
}
    // rust: loop {
    // rust: list.push(self.value()?);
    // rust: self.ws();
    // rust: match self.peek() {
    // rust: Some(b',') => self.i += 1,
    // rust: Some(b']') => {
    // rust: self.i += 1;
    // rust: return Ok(Value::Array(list));
}
    // rust: _ => return Err("expected ',' or ']'".into()),
}
}
}
unquoted :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let start = self.i;
    // rust: while let Some(c) = self.peek() {
    // rust: if c.is_ascii_alphanumeric() || matches!(c, b'_' | b'-' | b'.' | b'+') {
    // rust: self.i += 1;
    // rust: } else {
    // rust: break;
}
}
    // rust: String::from_utf8_lossy(&self.s[start..self.i]).into_owned()
}
string :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.ws();
    // rust: let Some(q @ (b'"' | b'\'')) = self.peek() else {
    // rust: return Ok(self.unquoted());
}
    // rust: self.i += 1;
    // rust: let mut out = Vec::new();
    // rust: while let Some(c) = self.peek() {
    // rust: self.i += 1;
    // rust: match c {
    // rust: b'\\' => {
    // rust: let Some(e) = self.peek() else { break };
    // rust: self.i += 1;
    // rust: out.push(match e {
    // rust: b'n' => b'\n',
    // rust: b't' => b'\t',
    // rust: other => other,
    // rust: });
}
    // rust: c if c == q => return Ok(String::from_utf8_lossy(&out).into_owned()),
    // rust: c => out.push(c),
}
}
    // rust: Err("unterminated string".into())
}
}
// `click_event` / `hover_event`, or the pre-datafixer `clickEvent` /
// `hoverEvent` names SNBT and older chat JSON still use.
    // rust: fn style_event_object<'a>(
    // rust: o: &'a serde_json::Map<String, Value>,
    // rust: modern: &str,
    // rust: legacy: &str,
    // rust: ) -> Option<&'a serde_json::Map<String, Value>> {
    // rust: o.get(modern)
    // rust: .or_else(|| o.get(legacy))
    // rust: .and_then(Value::as_object)
}

// Style flags from JSON bools, or SNBT `1b`/`0b` which parse as numbers.
style_flag :: proc(v: Maybe(^Value)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match v {
    // rust: Some(Value::Bool(b)) => Some(*b),
    // rust: Some(Value::Number(n)) => n.as_i64().map(|i| i != 0),
    // rust: _ => None,
}
}

// ExtraCodecs.UNTRUSTED_URI / Util.parseAndValidateUntrustedUri: http and
// https only, scheme case-insensitive. Every `open_url` a server sends must
// pass it: anything else (`file:`, a UNC path, a custom protocol handler)
// could start a program through the system's URL handler.
untrusted_http_url :: proc(url: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: url.split_once(':').is_some_and(|(scheme, _)| {
    // rust: scheme.eq_ignore_ascii_case("http") || scheme.eq_ignore_ascii_case("https")
    // rust: })
}

// `ClickEvent.CODEC` plus the legacy `value` field TextComponentHoverAndClickEventFix
// renames (`url` / `command` / `page`).
parse_click_event :: proc(e: ^serde_json::Map<string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let text = |k: &str| e.get(k).and_then(Value::as_str).map(str::to_owned);
    // rust: let legacy = || text("value");
    // rust: match e.get("action").and_then(Value::as_str) {
    // rust: Some("open_url") => text("url")
    // rust: .or_else(legacy)
    // rust: .filter(|u| untrusted_http_url(u))
    // rust: .map(crate::text::ClickEvent::OpenUrl),
    // rust: Some("change_page") => e
    // rust: .get("page")
    // rust: .and_then(Value::as_i64)
    // rust: .or_else(|| e.get("value").and_then(Value::as_i64))
    // rust: .or_else(|| {
    // rust: e.get("value")
    // rust: .and_then(Value::as_str)
    // rust: .and_then(|s| s.parse().ok())
    // rust: })
    // rust: .and_then(|p| i32::try_from(p).ok())
    // rust: .filter(|p| *p >= 1)
    // rust: .map(crate::text::ClickEvent::ChangePage),
    // rust: Some("suggest_command") => text("command")
    // rust: .or_else(legacy)
    // rust: .map(crate::text::ClickEvent::SuggestCommand),
    // rust: Some("run_command") => text("command")
    // rust: .or_else(legacy)
    // rust: .map(crate::text::ClickEvent::RunCommand),
    // rust: Some("copy_to_clipboard") => text("value").map(crate::text::ClickEvent::CopyToClipboard),
        // ClickEvent.ShowDialog.CODEC: a `minecraft:dialog` registry id or
        // the dialog itself; the server may send it (isAllowedFromServer).
    // rust: Some("show_dialog") => e.get("dialog").map(|dialog| {
    // rust: crate::text::ClickEvent::ShowDialog(crate::scoreboard::json_to_tag(dialog))
    // rust: }),
    // rust: Some("custom") => Some(crate::text::ClickEvent::Custom {
    // rust: id: crate::identifier::parse_identifier(&text("id")?)?,
    // rust: payload: e
    // rust: .get("payload")
    // rust: .filter(|value| !value.is_null())
    // rust: .map(crate::scoreboard::json_to_tag),
    // rust: }),
    // rust: _ => None,
}
}

// The style fields of a component object.
object_style :: proc(o: ^serde_json::Map<string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut style = Style::default();
    // rust: if let Some(c) = o.get("color").and_then(Value::as_str) {
    // rust: style.color = named_color(c).or_else(|| hex_color(c));
}
    // rust: style.shadow_color = o.get("shadow_color").and_then(shadow_color);
    // rust: style.bold = style_flag(o.get("bold"));
    // rust: style.italic = style_flag(o.get("italic"));
    // rust: style.underlined = style_flag(o.get("underlined"));
    // rust: style.strikethrough = style_flag(o.get("strikethrough"));
    // rust: style.obfuscated = style_flag(o.get("obfuscated"));
    // rust: style.font = o.get("font").and_then(crate::text::font_id);
    // ClickEvent.CODEC: the actions a chat line acts on here. A component
    // from a server never opens a file.
    // rust: if let Some(e) = style_event_object(o, "click_event", "clickEvent") {
    // rust: style.click = parse_click_event(e);
}
    // HoverEvent.ShowText, ShowItem and ShowEntity.
    // rust: if let Some(e) = style_event_object(o, "hover_event", "hoverEvent") {
    // rust: match e.get("action").and_then(Value::as_str) {
    // rust: Some("show_text") => {
                // Modern `value`, or the older `contents` / nested `text`.
    // rust: let value = e
    // rust: .get("value")
    // rust: .or_else(|| e.get("contents"))
    // rust: .or_else(|| e.get("text"));
    // rust: if let Some(value) = value {
    // rust: style.hover = Some(Box::new(to_text(value, &mut |s| Text::literal(s))));
}
}
    // rust: Some("show_item") if e.get("id").is_some_and(Value::is_string) => {
    // rust: style.hover_item = Some(Box::new(Value::Object(e.clone())));
}
    // rust: Some("show_entity") if e.get("id").is_some_and(Value::is_string) => {
    // rust: style.hover_entity = Some(Box::new(Value::Object(e.clone())));
}
    // rust: _ => {}
}
}
    // rust: style.insertion = o
    // rust: .get("insertion")
    // rust: .and_then(Value::as_str)
    // rust: .map(str::to_owned);
    // rust: style
}

// `TextColor.parseColor` for `#...`: `Integer.parseInt(rest, 16)` (so a sign
// and any digit count are accepted), kept only within `0..=0xFFFFFF`.
    // rust: pub(crate) fn hex_color(c: &str) -> Option<u32> {
    // rust: let value = i64::from_str_radix(c.strip_prefix('#')?, 16).ok()?;
    // rust: (0..=0xFF_FFFF).contains(&value).then_some(value as u32)
}

// `Style.shadow_color`: a packed ARGB int or normalized RGBA array.
    // rust: pub(crate) fn shadow_color(value: &Value) -> Option<u32> {
    // rust: if let Some(packed) = value.as_i64() {
    // rust: return i32::try_from(packed).ok().map(|n| n as u32);
}
    // rust: let rgba = value.as_array()?;
    // rust: if rgba.len() != 4 {
    // rust: return None;
}
    // rust: let channels = rgba
    // rust: .iter()
    // rust: .map(|channel| {
            // ExtraCodecs.ARGB_COLOR_CODEC reads floats; ARGB.as8BitChannel
            // floors each normalized channel multiplied by 255.
    // rust: let value = channel.as_f64()? as f32;
    // rust: (value.is_finite() && (0.0..=1.0).contains(&value))
    // rust: .then_some((value * 255.0_f32).floor() as u32)
    // rust: })
    // rust: .collect::<Option<Vec<_>>>()?;
    // rust: Some(channels[3] << 24 | channels[0] << 16 | channels[1] << 8 | channels[2])
}
// `ComponentSerialization.CODEC` decoding into text. `selector` components
// are resolved by `resolve` (ComponentUtils.updateForEntity).
to_text :: proc(v: ^Value, resolve: ^dyn FnMut(string) -> T {
    // Ported from Horizon
    return {}
}
    // rust: to_text_with(v, resolve, &mut |_| None)
}
// `to_text` with a hook resolving other contents (`nbt`) from the object.
    // rust: pub fn to_text_with(
    // rust: v: &Value,
    // rust: resolve: &mut dyn FnMut(&str) -> Text,
    // rust: contents: &mut dyn FnMut(&serde_json::Map<String, Value>) -> Option<Text>,
    // rust: ) -> Text {
    // rust: match v {
    // rust: Value::String(s) => Text::literal(s.clone()),
    // rust: Value::Number(n) => Text::literal(n.to_string()),
    // rust: Value::Bool(b) => Text::literal(b.to_string()),
        // A list is its first element with the rest as siblings.
    // rust: Value::Array(list) => {
    // rust: let Some((first, rest)) = list.split_first() else {
    // rust: return Text::empty();
}
    // rust: let mut base = to_text_with(first, resolve, contents);
            // The siblings take the first component's own style, even when
            // its text is empty.
    // rust: let style = match first {
    // rust: Value::Object(o) => object_style(o),
    // rust: _ => base
    // rust: .spans
    // rust: .first()
    // rust: .map(|s| s.style.clone())
    // rust: .unwrap_or_default(),
}
    // rust: for sibling in rest {
    // rust: base.push(to_text_with(sibling, resolve, contents).with_style(&style));
}
    // rust: base
}
    // rust: Value::Object(o) => {
    // rust: let style = object_style(o);
    // rust: let content = if let Some(t) = contents(o) {
    // rust: t
    // rust: } else if let Some(object) = inline_object(o, resolve, contents) {
    // rust: let mut text = Text::literal("\u{fffc}");
    // rust: text.spans[0].style.inline_object = Some(object);
    // rust: text
    // rust: } else if let Some(t) = o.get("text") {
    // rust: match t {
    // rust: Value::String(s) => Text::literal(s.clone()),
    // rust: other => Text::literal(other.to_string()),
}
    // rust: } else if let Some(key) = o.get("translate").and_then(Value::as_str) {
    // rust: let args: Vec<Text> = o
    // rust: .get("with")
    // rust: .and_then(Value::as_array)
    // rust: .map(|a| {
    // rust: a.iter()
    // rust: .map(|x| to_text_with(x, resolve, contents))
    // rust: .collect()
    // rust: })
    // rust: .unwrap_or_default();
    // rust: let translated = Text::translate(key, &args);
    // rust: match o.get("fallback").and_then(Value::as_str) {
    // rust: Some(fallback) if translated.plain() == key => Text::translate(fallback, &args),
    // rust: _ => translated,
}
    // rust: } else if let Some(sel) = o.get("selector").and_then(Value::as_str) {
    // rust: resolve(sel)
    // rust: } else if let Some(key) = o.get("keybind").and_then(Value::as_str) {
    // rust: crate::key_display::display_name(key)
    // rust: } else {
    // rust: Text::empty()
}
    // rust: let mut out = content.with_style(&style);
    // rust: for extra in o
    // rust: .get("extra")
    // rust: .and_then(Value::as_array)
    // rust: .into_iter()
    // rust: .flatten()
    // rust: {
    // rust: out.push(to_text_with(extra, resolve, contents).with_style(&style));
}
    // rust: if o.contains_key("object") || o.contains_key("player") || o.contains_key("sprite") {
    // rust: out.with_component(Value::Object(o.clone()))
    // rust: } else {
    // rust: out
}
}
    // rust: Value::Null => Text::empty(),
}
}

    // rust: fn inline_object(
    // rust: object: &serde_json::Map<String, Value>,
    // rust: resolve: &mut dyn FnMut(&str) -> Text,
    // rust: contents: &mut dyn FnMut(&serde_json::Map<String, Value>) -> Option<Text>,
    // rust: ) -> Option<InlineObject> {
    // rust: let kind = object.get("object").and_then(Value::as_str);
    // rust: let fallback = object
    // rust: .get("fallback")
    // rust: .map(|value| to_text_with(value, resolve, contents).plain());
    // rust: match kind {
    // rust: Some("player") | None if object.contains_key("player") => {
    // rust: let profile = object.get("player")?.clone();
            // PlayerSprite.defaultFallback.
    // rust: let fallback = fallback.unwrap_or_else(|| {
    // rust: match profile
    // rust: .as_str()
    // rust: .or_else(|| profile.get("name").and_then(Value::as_str))
    // rust: {
    // rust: Some(name) => format!("[{name} head]"),
    // rust: None => "[unknown player head]".to_owned(),
}
    // rust: });
    // rust: Some(InlineObject::Player {
    // rust: profile,
    // rust: hat: object.get("hat").and_then(Value::as_bool).unwrap_or(true),
    // rust: fallback,
    // rust: })
}
    // rust: Some("atlas") | None if object.contains_key("sprite") => {
    // rust: let atlas = object
    // rust: .get("atlas")
    // rust: .and_then(Value::as_str)
    // rust: .unwrap_or("minecraft:blocks")
    // rust: .to_owned();
    // rust: let sprite = object.get("sprite")?.as_str()?.to_owned();
            // AtlasSprite.defaultFallback: short names, the atlas unless blocks.
    // rust: let fallback = fallback.unwrap_or_else(|| {
    // rust: let short = |id: &str| match id.split_once(':') {
    // rust: Some(("minecraft", path)) => path.to_owned(),
    // rust: Some(_) => id.to_owned(),
    // rust: None => id.to_owned(),
}
    // rust: if short(&atlas) == "blocks" {
    // rust: format!("[{}]", short(&sprite))
    // rust: } else {
    // rust: format!("[{}@{}]", short(&sprite), short(&atlas))
}
    // rust: });
    // rust: Some(InlineObject::Atlas {
    // rust: atlas,
    // rust: sprite,
    // rust: fallback,
    // rust: })
}
    // rust: _ => None,
}
}

// `CustomName` as text: a string keeps its legacy formatting codes, anything
// else is a component (`ComponentSerialization`).
name_text :: proc(tag: ^Tag) -> T {
    // Ported from Horizon
    return {}
}
    // rust: match tag {
    // rust: Tag::String(s) => Text::legacy(&s.to_string_lossy()),
    // rust: t => crate::scoreboard::comp_text(&crate::scoreboard::tag_to_json(t)),
}
}

    // rust: mod tests {
//     use super::*;

hex_color_follows_text_color_parse_color :: proc() {
}
    // rust: for bad in [
    // rust: "#1000000",
    // rust: "#FFFFFFFF",
    // rust: "#-FF",
    // rust: "#",
    // rust: "#zz",
    // rust: "FFFFFF",
    // rust: "#99999999999",
    // rust: ] {
    // rust: assert_eq!(hex_color(bad), None, "{bad}");
}
    // rust: for (good, want) in [
    // rust: ("#FFFFFF", 0xFFFFFF),
    // rust: ("#000000", 0),
    // rust: ("#F", 15),
    // rust: ("#+FF", 255),
    // rust: ("#-0", 0),
    // rust: ] {
    // rust: assert_eq!(hex_color(good), Some(want), "{good}");
}
    // rust: let out = serde_json::json!({"text": "A", "color": "#1000000"});
    // rust: let text = to_text(&out, &mut |_| Text::empty());
    // rust: assert_eq!(text.spans[0].style.color, None);
}

shadow_color_accepts_packed_and_rgba_styles :: proc() {
}
    // rust: let packed = serde_json::json!({"text": "A", "shadow_color": -16711936});
    // rust: let text = to_text(&packed, &mut |_| Text::empty());
    // rust: assert_eq!(text.spans[0].style.shadow_color, Some(0xff00ff00));
    // rust: assert_eq!(text.component()["shadow_color"], -16711936);
    // rust: let rgba = serde_json::json!({"text": "A", "shadow_color": [1, 0, 0.5, 1]});
    // rust: let text = to_text(&rgba, &mut |_| Text::empty());
    // rust: assert_eq!(text.spans[0].style.shadow_color, Some(0xffff007f));
    // rust: let translucent = serde_json::json!({"text": "A", "shadow_color": [1, 0, 0.5, 0.5]});
    // rust: let text = to_text(&translucent, &mut |_| Text::empty());
    // rust: assert_eq!(text.spans[0].style.shadow_color, Some(0x7fff007f));
    // rust: let no_shadow = serde_json::json!({"text": "A", "shadow_color": 0});
    // rust: let text = to_text(&no_shadow, &mut |_| Text::empty());
    // rust: assert_eq!(text.spans[0].style.shadow_color, Some(0));
}

player_object_survives_text_parsing_and_keeps_its_siblings :: proc() {
}
    // rust: let component = serde_json::json!({
    // rust: "text": "<",
    // rust: "extra": [
    // rust: {"object": "player", "player": {"name": "elyapluggin"}, "hat": false,
    // rust: "fallback": "[head]"},
    // rust: {"text": " >", "color": "gold"}
    // rust: ]
    // rust: });
    // rust: let text = to_text(&component, &mut |_| Text::empty());
    // rust: assert_eq!(text.plain(), "<[head] >");
    // rust: assert!(matches!(
    // rust: &text.spans[1].style.inline_object,
    // rust: Some(InlineObject::Player { hat: false, .. })
    // rust: ));
    // rust: assert!(text.spans[2].style.inline_object.is_none());
    // rust: assert_eq!(text.component(), component);
    // rust: let sprite = serde_json::json!({"object": "atlas", "sprite": "minecraft:item/porkchop"});
    // rust: let text = to_text(&sprite, &mut |_| Text::empty());
    // rust: assert!(matches!(
    // rust: &text.spans[0].style.inline_object,
    // rust: Some(InlineObject::Atlas { sprite, .. }) if sprite == "minecraft:item/porkchop"
    // rust: ));
        // ObjectContents.visit without a fallback: the sprite's defaultFallback.
    // rust: assert_eq!(text.plain(), "[item/porkchop]");
    // rust: let head = serde_json::json!({"object": "player", "player": {"name": "Steve"}});
    // rust: assert_eq!(
    // rust: to_text(&head, &mut |_| Text::empty()).plain(),
    // rust: "[Steve head]"
    // rust: );
    // rust: let gui = serde_json::json!({"atlas": "gui", "sprite": "hud/heart/full"});
    // rust: assert_eq!(
    // rust: to_text(&gui, &mut |_| Text::empty()).plain(),
    // rust: "[hud/heart/full@gui]"
    // rust: );
}

snbt_and_json_components :: proc() {
}
    // rust: let input = "{text:'Hi ',color:red,extra:[{text:\"there\",bold:1b}]} rest";
    // rust: let (v, n) = parse_snbt(input).unwrap();
    // rust: assert_eq!(&input[n..], " rest");
    // rust: let t = to_text(&v, &mut |_| Text::empty());
    // rust: assert_eq!(t.plain(), "Hi there");
    // rust: assert_eq!(t.spans[1].style.color, named_color("red"));
        // SNBT `1b` is a number in JSON; style flags still take it as true.
    // rust: assert_eq!(t.spans[1].style.bold, Some(true));
    // rust: let (v, _) = parse_snbt("[\"a\",{\"text\":\"b\"}]").unwrap();
    // rust: assert_eq!(to_text(&v, &mut |_| Text::empty()).plain(), "ab");
}

legacy_click_event_open_url_uses_value_field :: proc() {
}
//         use crate::text::ClickEvent;
    // rust: let modern = serde_json::json!({
    // rust: "text": "site",
    // rust: "click_event": {"action": "open_url", "url": "https://example.com"},
    // rust: "underlined": true
    // rust: });
    // rust: let legacy = serde_json::json!({
    // rust: "text": "site",
    // rust: "clickEvent": {"action": "open_url", "value": "https://example.com"},
    // rust: "underlined": 1
    // rust: });
    // rust: for component in [modern, legacy] {
    // rust: let text = to_text(&component, &mut |_| Text::empty());
    // rust: assert_eq!(
    // rust: text.spans[0].style.click,
    // rust: Some(ClickEvent::OpenUrl("https://example.com".into()))
    // rust: );
    // rust: assert_eq!(text.spans[0].style.underlined, Some(true));
}
    // rust: let snbt = r#"{text:"site",underlined:1b,clickEvent:{action:open_url,value:"https://example.com"}}"#;
    // rust: let (v, _) = parse_snbt(snbt).unwrap();
    // rust: let text = to_text(&v, &mut |_| Text::empty());
    // rust: assert_eq!(
    // rust: text.spans[0].style.click,
    // rust: Some(ClickEvent::OpenUrl("https://example.com".into()))
    // rust: );
    // rust: assert_eq!(text.spans[0].style.underlined, Some(true));
}

custom_click_events_keep_payloads_and_inherit_to_inline_objects :: proc() {
}
//         use crate::text::ClickEvent;
//         use horizon_world::nbt::Tag;

    // rust: for (payload, expected) in [
    // rust: (None, None),
    // rust: (Some(serde_json::Value::Null), None),
    // rust: (Some(serde_json::json!(42)), Some(Tag::Int(42))),
    // rust: (
    // rust: Some(serde_json::json!({"shop": "potions", "amount": 3})),
    // rust: Some(Tag::Compound(
    // rust: [
    // rust: ("amount".into(), Tag::Int(3)),
    // rust: ("shop".into(), Tag::String("potions".into())),
    // rust: ]
    // rust: .into_iter()
    // rust: .collect(),
    // rust: )),
    // rust: ),
    // rust: ] {
    // rust: let mut event = serde_json::json!({"action": "custom", "id": "test:shop"});
    // rust: if let Some(payload) = payload {
    // rust: event["payload"] = payload;
}
    // rust: let component = serde_json::json!({
    // rust: "text": "", "click_event": event,
    // rust: "extra": [{"object": "atlas", "sprite": "minecraft:item/potion"}, "Shop"]
    // rust: });
    // rust: let text = to_text(&component, &mut |_| Text::empty());
    // rust: for (_, style) in text.chars() {
    // rust: assert_eq!(
    // rust: style.click,
    // rust: Some(ClickEvent::Custom {
    // rust: id: "test:shop".into(),
    // rust: payload: expected.clone(),
    // rust: })
    // rust: );
}
    // rust: let encoded = text.component();
    // rust: let decoded = to_text(&encoded, &mut |_| Text::empty());
    // rust: assert_eq!(decoded, text);
    // rust: if expected.is_none() {
    // rust: assert!(!encoded.to_string().contains("\"payload\""));
}
}
    // rust: for id in ["Bad ID", "Uppercase:shop"] {
    // rust: let text = to_text(
    // rust: &serde_json::json!({
    // rust: "text": "Shop", "click_event": {"action": "custom", "id": id}
    // rust: }),
    // rust: &mut |_| Text::empty(),
    // rust: );
    // rust: assert_eq!(text.spans[0].style.click, None);
}
}

the_font_is_inherited_and_kept :: proc() {
}
    // rust: let (v, _) =
    // rust: parse_snbt(r#"{text:"a",font:"alt",extra:["b",{text:"c",font:"minecraft:uniform"}]}"#)
    // rust: .unwrap();
    // rust: let t = to_text(&v, &mut |_| Text::empty());
    // rust: let fonts: Vec<_> = t.chars().map(|(_, s)| s.font.clone()).collect();
    // rust: let (alt, uniform) = (
    // rust: Some("minecraft:alt".into()),
    // rust: Some("minecraft:uniform".into()),
    // rust: );
    // rust: assert_eq!(fonts, [alt.clone(), alt, uniform]);
        // Back to JSON with the field, which a re-read keeps.
    // rust: let again = to_text(&t.component(), &mut |_| Text::empty());
    // rust: let kept: Vec<_> = again.chars().map(|(_, s)| s.font.clone()).collect();
    // rust: assert_eq!(kept, fonts);
        // Not an identifier: no font.
    // rust: let (v, _) = parse_snbt(r#"{text:"a",font:"Bad Font"}"#).unwrap();
    // rust: let t = to_text(&v, &mut |_| Text::empty());
    // rust: assert_eq!(t.spans[0].style.font, None);
}

snbt_nesting_is_bounded :: proc() {
}
    // rust: let nest = |n: usize| format!("{}1{}", "[".repeat(n), "]".repeat(n));
    // rust: assert!(parse_snbt(&nest(512)).is_ok());
    // rust: assert!(parse_snbt(&nest(513)).is_err());
    // rust: assert!(parse_snbt(&nest(100_000)).is_err());
}

bare_words_that_look_numeric_stay_strings :: proc() {
}
    // rust: let (v, _) = parse_snbt("{text:nan}").unwrap();
    // rust: assert_eq!(v["text"], Value::String("nan".into()));
    // rust: let (v, _) = parse_snbt("{text:Infinity}").unwrap();
    // rust: assert_eq!(v["text"], Value::String("Infinity".into()));
    // rust: let (v, _) = parse_snbt("{n:1.5}").unwrap();
    // rust: assert_eq!(v["n"], Value::from(1.5));
}

name_text_preserves_legacy_and_decodes_components :: proc() {
}
    // rust: let legacy = Tag::String("§6Golden Name".into());
    // rust: let text = name_text(&legacy);
    // rust: assert_eq!(text.plain(), "Golden Name");

    // rust: let comp = Tag::compound([("text", Tag::String("Custom Name".into()))]);
    // rust: let text = name_text(&comp);
    // rust: assert_eq!(text.plain(), "Custom Name");
}
}
