//! Transpiled from Horizon Rust crate
package horizon_client_core_text

import "core:fmt"
import "core:mem"
import "core:math"

// Styled text (a flattened `Component`): spans with ChatFormatting colours
// and decorations, translatable messages formatted like
// `TranslatableContents` (`%s`, `%1$s`, `%%`), and legacy `§` codes.
// use crate::lang;
// use serde_json::{Map, Value, json};

// ChatFormatting colours by legacy code index 0..=15.
    // rust: pub const COLORS: [(char, &str, u32); 16] = [
    // rust: ('0', "black", 0x000000),
    // rust: ('1', "dark_blue", 0x0000AA),
    // rust: ('2', "dark_green", 0x00AA00),
    // rust: ('3', "dark_aqua", 0x00AAAA),
    // rust: ('4', "dark_red", 0xAA0000),
    // rust: ('5', "dark_purple", 0xAA00AA),
    // rust: ('6', "gold", 0xFFAA00),
    // rust: ('7', "gray", 0xAAAAAA),
    // rust: ('8', "dark_gray", 0x555555),
    // rust: ('9', "blue", 0x5555FF),
    // rust: ('a', "green", 0x55FF55),
    // rust: ('b', "aqua", 0x55FFFF),
    // rust: ('c', "red", 0xFF5555),
    // rust: ('d', "light_purple", 0xFF55FF),
    // rust: ('e', "yellow", 0xFFFF55),
    // rust: ('f', "white", 0xFFFFFF),
    // rust: ];
BLACK :: 0x000000
GRAY :: 0xAAAAAA
DARK_GRAY :: 0x555555
GREEN :: 0x55FF55
AQUA :: 0x55FFFF
RED :: 0xFF5555
YELLOW :: 0xFFFF55
GOLD :: 0xFFAA00
WHITE :: 0xFFFFFF
LIGHT_PURPLE :: 0xFF55FF
DARK_PURPLE :: 0xAA00AA

named_color :: proc(name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: COLORS.iter().find(|c| c.1 == name).map(|c| c.2)
}

// Click actions carried by text components.
ClickEvent :: enum {
    // `ClickEvent.OpenUrl`: an http or https link.
    OpenUrl(String),
    // `ClickEvent.ChangePage`: a book's page, counted from 1.
    ChangePage(i32),
    SuggestCommand(String),
    // `ClickEvent.RunCommand`: the command, with or without its `/`.
    RunCommand(String),
    CopyToClipboard(String),
    // `ClickEvent.ShowDialog`: a `minecraft:dialog` registry id, or the
    // dialog itself as the component carried it.
    ShowDialog(horizon_world::nbt::Tag),
    // `ClickEvent.Custom`: a server-defined action with an optional NBT payload.
    Custom {,
    id: String,
    payload: Option<horizon_world::nbt::Tag>,
    // rust: },
    // A local file to open with the system handler.
    // Only allow this in locally constructed messages, never server/LAN text.
    OpenFile(String),
}

// A non-character `minecraft:object` embedded in a text component.
InlineObject :: enum {
    Player {,
    profile: Value,
    hat: bool,
    fallback: String,
    // rust: },
    Atlas {,
    atlas: String,
    sprite: String,
    fallback: String,
    // rust: },
}
    // rust: impl InlineObject {
fallback :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Player { fallback, .. } | Self::Atlas { fallback, .. } => fallback,
}
}
}

// Text style; `None` fields inherit from the enclosing style.
Style :: struct {
    color: Maybe(u32),
    // Text component `shadow_color` as packed ARGB. Zero suppresses shadows.
    shadow_color: Maybe(u32),
    bold: Maybe(bool),
    italic: Maybe(bool),
    underlined: Maybe(bool),
    strikethrough: Maybe(bool),
    obfuscated: Maybe(bool),
    click: Maybe(ClickEvent),
    // Hover text.
    hover: Maybe(^Text),
    // `HoverEvent.ShowItem`: the event's `{id, count?, components?}` object.
    hover_item: Maybe(^Value),
    // `HoverEvent.ShowEntity`: the event's `{id, uuid, name?}` object.
    hover_entity: Maybe(^Value),
    // `Style.insertion`: the text a Shift-click puts in the chat box.
    insertion: Maybe(string),
    // The font (`FontDescription.Resource`), a full id like
    // `minecraft:alt`; the default font when unset.
    font: Maybe(string),
    // Content metadata for a single U+FFFC object span; never inherited.
    inline_object: Maybe(InlineObject),
}
// A style's `font` field: an identifier (`alt` is `minecraft:alt`).
font_id :: proc(v: ^Value) -> O {
    // Ported from Horizon
    return {}
}
    // rust: crate::identifier::parse_identifier(v.as_str()?)
}
    // rust: impl Style {
color :: proc(c: u32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: color: Some(c),
    // rust: ..Self::default()
}
}
    // Fill unset fields from `base` (Style.applyTo).
inherit :: proc(self: ^Self, base: ^Style) {
}
    // rust: self.color = self.color.or(base.color);
    // rust: self.shadow_color = self.shadow_color.or(base.shadow_color);
    // rust: self.bold = self.bold.or(base.bold);
    // rust: self.italic = self.italic.or(base.italic);
    // rust: self.underlined = self.underlined.or(base.underlined);
    // rust: self.strikethrough = self.strikethrough.or(base.strikethrough);
    // rust: self.obfuscated = self.obfuscated.or(base.obfuscated);
    // rust: if self.click.is_none() {
    // rust: self.click.clone_from(&base.click);
}
        // One HoverEvent: its three kinds are inherited together, so a style
        // with its own event never picks up another kind from `base`.
    // rust: if self.hover.is_none() && self.hover_item.is_none() && self.hover_entity.is_none() {
    // rust: self.hover.clone_from(&base.hover);
    // rust: self.hover_item.clone_from(&base.hover_item);
    // rust: self.hover_entity.clone_from(&base.hover_entity);
}
    // rust: if self.insertion.is_none() {
    // rust: self.insertion.clone_from(&base.insertion);
}
    // rust: if self.font.is_none() {
    // rust: self.font.clone_from(&base.font);
}
}
is_bold :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.bold == Some(true)
}
is_italic :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.italic == Some(true)
}
}
Span :: struct {
    text: string,
    style: Style,
}
// A run of styled spans, and the `Component` they came from (its JSON form)
// when it was built through the constructors below, for sending to vanilla
// clients. Equality compares the spans only.
Text :: struct {
    spans: [dynamic]Span,
    source: Maybe(std::sync::^Value),
}
    // rust: impl PartialEq for Text {
eq :: proc(self: ^Self, other: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.spans == other.spans
}
}
    // rust: impl Eq for Text {}
    // rust: impl From<&str> for Text {
from :: proc(s: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Text::literal(s)
}
}
    // rust: impl From<String> for Text {
from :: proc(s: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Text::literal(s)
}
}
    // rust: impl Text {
empty :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::default()
}
literal :: proc(s: impl Into<string>) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let text = s.into();
    // rust: if text.is_empty() {
    // rust: return Self::default();
}
    // rust: Self {
    // rust: source: Some(json!({ "text": text }).into()),
    // rust: spans: vec![Span {
    // rust: text,
    // rust: style: Style::default(),
    // rust: }],
}
}
styled :: proc(s: impl Into<string>, style: Style) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::literal(s).with_style(&style)
}
colored :: proc(s: impl Into<string>, color: u32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::styled(s, Style::color(color))
}
    // ComponentUtils.copyOnClickText: a green, bracketed clipboard link.
copyable :: proc(s: impl Into<string>) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let s = s.into();
    // rust: Self::literal("[")
    // rust: .append(Self::styled(
    // rust: s.clone(),
    // rust: Style {
    // rust: click: Some(ClickEvent::CopyToClipboard(s)),
    // rust: hover: Some(Box::new(Self::translate("chat.copy.click", &[]))),
    // rust: ..Style::color(GREEN)
    // rust: },
    // rust: ))
    // rust: .append("]")
}
    // LocateCommand's coordinate link: suggest a teleport without executing it.
    // Structure and POI results preserve the player's current height (`~`).
teleport_link :: proc(x: i32, y: Maybe(i32), z: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let y = y.map_or_else(|| "~".to_owned(), |y| y.to_string());
    // rust: let coords = Self::tr("chat.coordinates", &[&x, &y, &z]);
    // rust: Self::literal("[")
    // rust: .append(coords)
    // rust: .append("]")
    // rust: .with_style(&Style {
    // rust: click: Some(ClickEvent::SuggestCommand(format!("/tp @s {x} {y} {z}"))),
    // rust: hover: Some(Box::new(Self::translate("chat.coordinates.tooltip", &[]))),
    // rust: ..Style::color(GREEN)
    // rust: })
}
    // Component.translatable(key, args) in the current language.
translate :: proc(key: string, args: ^[Text]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut t = format_translation(&lang::get(key), args);
    // rust: let mut c = Map::new();
    // rust: c.insert("translate".into(), key.into());
    // rust: if !args.is_empty() {
    // rust: c.insert("with".into(), args.iter().map(Text::argument).collect());
}
    // rust: t.source = Some(Value::Object(c).into());
    // rust: t
}
    // Component.translatableWithFallback(key, fallback, args): `translate`, with `fallback` as
    // the template when the language has no `key`.
translate_with_fallback :: proc(key: string, fallback: string, args: ^[Text]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let template = lang::current()
    // rust: .and_then(|l| l.get(key).map(str::to_owned))
    // rust: .unwrap_or_else(|| fallback.to_owned());
    // rust: let mut t = format_translation(&template, args);
    // rust: let mut c = Map::new();
    // rust: c.insert("translate".into(), key.into());
    // rust: c.insert("fallback".into(), fallback.into());
    // rust: if !args.is_empty() {
    // rust: c.insert("with".into(), args.iter().map(Text::argument).collect());
}
    // rust: t.source = Some(Value::Object(c).into());
    // rust: t
}
    // CommonComponents.optionNameValue: "Caption: value" joined as the language joins them
    // (`options.generic_value`: "%s : %s" in French, "%s：%s" in Chinese). English's "%s: %s"
    // when the language has no such key, as without prepared resources.
option_name_value :: proc(caption: Text, value: Text) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::translate_with_fallback("options.generic_value", "%s: %s", &[caption, value])
}
    // A translatable message whose arguments are plain strings.
tr :: proc(key: string, args: ^[^dyn std::fmt::Display]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let args: Vec<Text> = args.iter().map(|a| Text::literal(a.to_string())).collect();
    // rust: Self::translate(key, &args)
}
append :: proc(other: impl Into<Text>) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.push(other);
    // rust: self
}
    // MutableComponent.append: `other` becomes a sibling. A styled text is
    // wrapped first, as its style doesn't reach what is appended here.
push :: proc(self: ^Self, other: impl Into<Text>) {
}
    // rust: let other = other.into();
    // rust: let sibling = other.component();
    // rust: let mut root = if self.spans.is_empty() && self.source.is_none() {
    // rust: json!({ "text": "" })
    // rust: } else {
    // rust: let c = self.component();
    // rust: if STYLE_KEYS.iter().any(|k| c.get(*k).is_some()) {
    // rust: json!({ "text": "", "extra": [c] })
    // rust: } else {
    // rust: c
}
}
    // rust: if let Value::Object(o) = &mut root {
    // rust: match o.get_mut("extra") {
    // rust: Some(Value::Array(a)) => a.push(sibling),
    // rust: _ => {
    // rust: o.insert("extra".into(), Value::Array(vec![sibling]));
}
}
}
    // rust: self.source = Some(root.into());
    // rust: self.spans.extend(other.spans);
}
    // Apply `style` underneath every span (MutableComponent.withStyle on a parent).
with_style :: proc(style: ^Style) -> S {
    // Ported from Horizon
    return {}
}
    // rust: for span in &mut self.spans {
    // rust: span.style.inherit(style);
}
    // rust: let mut c = self.component();
    // rust: if let Value::Object(o) = &mut c {
    // rust: for (k, v) in style_json(style) {
    // rust: o.entry(k).or_insert(v);
}
}
    // rust: self.source = Some(c.into());
    // rust: self
}
    // The `Component` as vanilla's JSON (ComponentSerialization): the one
    // built through the constructors, else the spans as literal siblings.
    // The key of a `Component.translatable` built through [`Text::translate`].
translation_key :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.source.as_deref()?.get("translate")?.as_str()
}
component :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(c) = &self.source {
    // rust: return (**c).clone();
}
    // rust: let span = |s: &Span| {
    // rust: let mut o = Map::new();
    // rust: o.insert("text".into(), s.text.clone().into());
    // rust: o.extend(style_json(&s.style));
    // rust: Value::Object(o)
}
    // rust: match self.spans.as_slice() {
    // rust: [] => json!({ "text": "" }),
    // rust: [one] => span(one),
    // rust: many => json!({ "text": "", "extra": many.iter().map(span).collect::<Vec<_>>() }),
}
}
    // A translation argument: vanilla passes numbers as numbers, which
    // Horizon formats into unstyled literals.
argument :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let c = self.component();
    // rust: match c
    // rust: .as_object()
    // rust: .and_then(|o| o.get("text").filter(|_| o.len() == 1))
    // rust: {
    // rust: Some(Value::String(s)) if s.parse::<i64>().is_ok_and(|n| n.to_string() == *s) => {
    // rust: s.parse::<i64>().map_or(c.clone(), Value::from)
}
    // rust: _ => c,
}
}
    // Style fields the spans don't model (an entity hover, an insertion),
    // set on the component sent to vanilla only.
with_component_fields :: proc(fields: Vec<(string) {
}
    // rust: let mut c = self.component();
    // rust: if let Value::Object(o) = &mut c {
    // rust: for (k, v) in fields {
    // rust: o.entry(k).or_insert(v);
}
}
    // rust: self.source = Some(c.into());
    // rust: self
}
    // The same spans, sent to vanilla as `component` (a shape the spans'
    // own JSON would not take, such as a styled root with siblings).
with_component :: proc(component: Value) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.source = Some(component.into());
    // rust: self
}
with_color :: proc(self: ^Self, color: u32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.with_style(&Style::color(color))
}
italic :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.with_style(&Style {
    // rust: italic: Some(true),
    // rust: ..Style::default()
    // rust: })
}
underlined :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.with_style(&Style {
    // rust: underlined: Some(true),
    // rust: ..Style::default()
    // rust: })
}
bold :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.with_style(&Style {
    // rust: bold: Some(true),
    // rust: ..Style::default()
    // rust: })
}
    // Component.getString: the plain characters.
plain :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.spans
    // rust: .iter()
    // rust: .map(|s| match &s.style.inline_object {
    // rust: Some(object) if s.text == "\u{fffc}" => object.fallback(),
    // rust: _ => s.text.as_str(),
    // rust: })
    // rust: .collect()
}
is_empty :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.spans.iter().all(|s| s.text.is_empty())
}
    // Parse legacy formatting codes (`§a`, `§l`, `§r`...) as the font does.
legacy :: proc(s: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Text::default();
    // rust: let mut style = Style::default();
    // rust: let mut current = String::new();
    // rust: let mut chars = s.chars();
    // rust: while let Some(c) = chars.next() {
    // rust: if c != '§' {
    // rust: current.push(c);
    // rust: continue;
}
    // rust: let Some(code) = chars.next() else { break };
    // rust: if !current.is_empty() {
    // rust: out.spans.push(Span {
    // rust: text: std::mem::take(&mut current),
    // rust: style: style.clone(),
    // rust: });
}
    // rust: let code = code.to_ascii_lowercase();
    // rust: if let Some(c) = COLORS.iter().find(|c| c.0 == code) {
                // Colour codes reset decorations (Style.applyLegacyFormat).
    // rust: style = Style::color(c.2);
    // rust: } else {
    // rust: match code {
    // rust: 'k' => style.obfuscated = Some(true),
    // rust: 'l' => style.bold = Some(true),
    // rust: 'm' => style.strikethrough = Some(true),
    // rust: 'n' => style.underlined = Some(true),
    // rust: 'o' => style.italic = Some(true),
    // rust: 'r' => style = Style::default(),
    // rust: _ => {}
}
}
}
    // rust: if !current.is_empty() {
    // rust: out.spans.push(Span {
    // rust: text: current,
    // rust: style,
    // rust: });
}
    // rust: out
}
    // `StringDecomposer.iterateFormatted` on every span: legacy `§` codes
    // inside the span contents restyle what follows them (colour codes
    // clear the decorations, `§r` returns to the span's own style) and are
    // not drawn.
resolve_legacy :: proc(self: ^Self) -> T {
    // Ported from Horizon
    return {}
}
    // rust: if !self.spans.iter().any(|s| s.text.contains('§')) {
    // rust: return self.clone();
}
    // rust: let mut out = Text::default();
    // rust: for span in &self.spans {
    // rust: let mut style = span.style.clone();
    // rust: let mut current = String::new();
    // rust: let mut chars = span.text.chars();
    // rust: while let Some(c) = chars.next() {
    // rust: if c != '§' {
    // rust: current.push(c);
    // rust: continue;
}
    // rust: let Some(code) = chars.next() else { break };
    // rust: let next = legacy_format(&style, code, &span.style);
    // rust: if next != style {
    // rust: if !current.is_empty() {
    // rust: out.spans.push(Span {
    // rust: text: std::mem::take(&mut current),
    // rust: style: style.clone(),
    // rust: });
}
    // rust: style = next;
}
}
    // rust: if !current.is_empty() {
    // rust: out.spans.push(Span {
    // rust: text: current,
    // rust: style,
    // rust: });
}
}
    // rust: out
}
    // `resolve_legacy` borrowing `self` when no span holds a `§` code (the
    // common case).
resolved :: proc(self: ^Self) -> s {
    // Ported from Horizon
    return {}
}
    // rust: if self.spans.iter().any(|s| s.text.contains('§')) {
    // rust: std::borrow::Cow::Owned(self.resolve_legacy())
    // rust: } else {
    // rust: std::borrow::Cow::Borrowed(self)
}
}
    // The text without its legacy `§` codes (ChatFormatting.stripFormatting:
    // a `§` and a code character, `0`-`9`, `a`-`f`, `k`-`o` or `r`).
strip_legacy :: proc(self: ^Self) -> T {
    // Ported from Horizon
    return {}
}
    // rust: if !self.spans.iter().any(|s| s.text.contains('§')) {
    // rust: return self.clone();
}
    // rust: let code =
    // rust: |c: char| matches!(c.to_ascii_lowercase(), '0'..='9' | 'a'..='f' | 'k'..='o' | 'r');
    // rust: let mut out = Text::default();
    // rust: for span in &self.spans {
    // rust: let mut text = String::with_capacity(span.text.len());
    // rust: let mut chars = span.text.chars().peekable();
    // rust: while let Some(c) = chars.next() {
    // rust: if c == '§' && chars.peek().is_some_and(|&n| code(n)) {
    // rust: chars.next();
    // rust: } else {
    // rust: text.push(c);
}
}
    // rust: if !text.is_empty() {
    // rust: out.spans.push(Span {
    // rust: text,
    // rust: style: span.style.clone(),
    // rust: });
}
}
    // rust: out
}
    // Characters with their effective styles.
chars :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.spans
    // rust: .iter()
    // rust: .flat_map(|s| s.text.chars().map(move |c| (c, &s.style)))
}
    // Sub-range of characters [from, to) keeping styles.
slice :: proc(self: ^Self, from: uint, to: uint) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Text::default();
    // rust: let mut index = 0;
    // rust: for span in &self.spans {
    // rust: let mut part = String::new();
    // rust: for c in span.text.chars() {
    // rust: if index >= from && index < to {
    // rust: part.push(c);
}
    // rust: index += 1;
}
    // rust: if !part.is_empty() {
    // rust: out.spans.push(Span {
    // rust: text: part,
    // rust: style: span.style.clone(),
    // rust: });
}
}
    // rust: out
}
}

// The style fields of a component's JSON.
    // rust: const STYLE_KEYS: [&str; 11] = [
    // rust: "color",
    // rust: "shadow_color",
    // rust: "bold",
    // rust: "italic",
    // rust: "underlined",
    // rust: "strikethrough",
    // rust: "obfuscated",
    // rust: "click_event",
    // rust: "hover_event",
    // rust: "insertion",
    // rust: "font",
    // rust: ];
// `Style.Serializer`: the fields a style sets.
style_json :: proc(style: ^Style) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::new();
    // rust: if let Some(c) = style.color {
    // rust: let name = COLORS
    // rust: .iter()
    // rust: .find(|n| n.2 == c)
    // rust: .map_or_else(|| format!("#{c:06X}"), |n| n.1.to_owned());
    // rust: out.push(("color".to_owned(), name.into()));
}
    // rust: if let Some(shadow) = style.shadow_color {
    // rust: out.push(("shadow_color".to_owned(), Value::from(shadow as i32)));
}
    // rust: for (key, flag) in [
    // rust: ("bold", style.bold),
    // rust: ("italic", style.italic),
    // rust: ("underlined", style.underlined),
    // rust: ("strikethrough", style.strikethrough),
    // rust: ("obfuscated", style.obfuscated),
    // rust: ] {
    // rust: if let Some(f) = flag {
    // rust: out.push((key.to_owned(), f.into()));
}
}
    // rust: if let Some(click) = &style.click {
    // rust: let event = match click {
    // rust: ClickEvent::OpenUrl(url) => json!({ "action": "open_url", "url": url }),
    // rust: ClickEvent::ChangePage(page) => json!({ "action": "change_page", "page": page }),
    // rust: ClickEvent::SuggestCommand(command) => {
    // rust: json!({ "action": "suggest_command", "command": command })
}
    // rust: ClickEvent::CopyToClipboard(value) => {
    // rust: json!({ "action": "copy_to_clipboard", "value": value })
}
    // rust: ClickEvent::RunCommand(command) => {
    // rust: json!({ "action": "run_command", "command": command })
}
            // ClickEvent.ShowDialog.CODEC: the dialog the server sent it with.
    // rust: ClickEvent::ShowDialog(dialog) => json!({
    // rust: "action": "show_dialog",
    // rust: "dialog": crate::scoreboard::tag_to_json(dialog),
    // rust: }),
    // rust: ClickEvent::Custom { id, payload } => {
    // rust: let mut event = json!({ "action": "custom", "id": id });
    // rust: if let Some(payload) = payload {
    // rust: event["payload"] = crate::scoreboard::tag_to_json(payload);
}
    // rust: event
}
    // rust: ClickEvent::OpenFile(path) => json!({ "action": "open_file", "path": path }),
}
    // rust: out.push(("click_event".to_owned(), event));
}
    // rust: if let Some(hover) = &style.hover {
    // rust: out.push((
    // rust: "hover_event".to_owned(),
    // rust: json!({ "action": "show_text", "value": hover.component() }),
    // rust: ));
    // rust: } else if let Some(Value::Object(item)) = style.hover_item.as_deref() {
    // rust: let mut event = item.clone();
    // rust: event.insert("action".into(), "show_item".into());
    // rust: out.push(("hover_event".to_owned(), Value::Object(event)));
    // rust: } else if let Some(Value::Object(entity)) = style.hover_entity.as_deref() {
    // rust: let mut event = entity.clone();
    // rust: event.insert("action".into(), "show_entity".into());
    // rust: out.push(("hover_event".to_owned(), Value::Object(event)));
}
    // rust: if let Some(insertion) = &style.insertion {
    // rust: out.push(("insertion".to_owned(), insertion.clone().into()));
}
    // rust: if let Some(font) = &style.font {
    // rust: out.push(("font".to_owned(), font.clone().into()));
}
    // rust: out
}

// `Style.applyLegacyFormat` for the code after a `§`, `§r` going back to
// `reset` (`StringDecomposer.iterateFormatted`); an unknown code changes nothing.
legacy_format :: proc(style: ^Style, code: char, reset: ^Style) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let code = code.to_ascii_lowercase();
    // rust: if let Some(c) = COLORS.iter().find(|c| c.0 == code) {
        // A colour clears the decorations.
    // rust: return Style {
    // rust: color: Some(c.2),
    // rust: bold: Some(false),
    // rust: italic: Some(false),
    // rust: underlined: Some(false),
    // rust: strikethrough: Some(false),
    // rust: obfuscated: Some(false),
    // rust: ..style.clone()
}
}
    // rust: let mut s = style.clone();
    // rust: match code {
    // rust: 'k' => s.obfuscated = Some(true),
    // rust: 'l' => s.bold = Some(true),
    // rust: 'm' => s.strikethrough = Some(true),
    // rust: 'n' => s.underlined = Some(true),
    // rust: 'o' => s.italic = Some(true),
    // rust: 'r' => s = reset.clone(),
    // rust: _ => {}
}
    // rust: s
}

// TranslatableContents.decomposeTemplate: `%s` takes the next argument,
// `%n$s` a numbered one and `%%` is a percent sign. Malformed templates are
// shown verbatim.
format_translation :: proc(template: string, args: ^[Text]) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Text::default();
    // rust: let mut literal = String::new();
    // rust: let mut next = 0usize;
    // rust: let chars: Vec<char> = template.chars().collect();
    // rust: let mut i = 0;
    // rust: while i < chars.len() {
    // rust: if chars[i] != '%' {
    // rust: literal.push(chars[i]);
    // rust: i += 1;
    // rust: continue;
}
        // %(?:(\d+)\$)?([A-Za-z%]|$)
    // rust: let mut j = i + 1;
    // rust: let mut number = None;
    // rust: let digits_start = j;
    // rust: while j < chars.len() && chars[j].is_ascii_digit() {
    // rust: j += 1;
}
    // rust: if j > digits_start && j < chars.len() && chars[j] == '$' {
    // rust: number = chars[digits_start..j]
    // rust: .iter()
    // rust: .collect::<String>()
    // rust: .parse::<usize>()
    // rust: .ok();
    // rust: j += 1;
    // rust: } else {
    // rust: j = digits_start;
}
    // rust: let conversion = chars.get(j).copied();
    // rust: match conversion {
    // rust: Some('%') if number.is_none() => {
    // rust: literal.push('%');
    // rust: i = j + 1;
}
            // Not a format specifier at all: the percent sign is literal.
    // rust: Some(c) if !c.is_ascii_alphabetic() && c != '%' => {
    // rust: literal.push('%');
    // rust: i += 1;
}
    // rust: Some('s') => {
    // rust: let index = match number {
    // rust: Some(n) => n.wrapping_sub(1),
    // rust: None => {
    // rust: next += 1;
    // rust: next - 1
}
}
    // rust: let Some(arg) = args.get(index) else {
    // rust: return Text::literal(template);
}
    // rust: if !literal.is_empty() {
    // rust: out.spans.push(Span {
    // rust: text: std::mem::take(&mut literal),
    // rust: style: Style::default(),
    // rust: });
}
    // rust: out.spans.extend(arg.spans.iter().cloned());
    // rust: i = j + 1;
}
    // rust: _ => return Text::literal(template),
}
}
    // rust: if !literal.is_empty() {
    // rust: out.spans.push(Span {
    // rust: text: literal,
    // rust: style: Style::default(),
    // rust: });
}
    // rust: out
}

    // rust: mod tests {
//     use super::*;
click_events_serialize_and_inherit_as_one_style_field :: proc() {
}
    // rust: for (event, json) in [
    // rust: (
    // rust: ClickEvent::SuggestCommand("/seed".into()),
    // rust: json!({"action": "suggest_command", "command": "/seed"}),
    // rust: ),
    // rust: (
    // rust: ClickEvent::CopyToClipboard("-9223372036854775808".into()),
    // rust: json!({"action": "copy_to_clipboard", "value": "-9223372036854775808"}),
    // rust: ),
    // rust: (
    // rust: ClickEvent::OpenFile("/tmp/My screenshots/世界.png".into()),
    // rust: json!({"action": "open_file", "path": "/tmp/My screenshots/世界.png"}),
    // rust: ),
    // rust: ] {
    // rust: let style = Style {
    // rust: click: Some(event.clone()),
    // rust: ..Style::default()
}
    // rust: let text = Text::literal("link").with_style(&style);
    // rust: assert_eq!(text.component()["click_event"], json);
    // rust: assert_eq!(text.spans[0].style.click, Some(event));
    // rust: let child = Text::copyable("42").with_style(&style);
    // rust: assert_eq!(
    // rust: child.spans[1].style.click,
    // rust: Some(ClickEvent::CopyToClipboard("42".into()))
    // rust: );
    // rust: assert_eq!(
    // rust: child.component()["extra"][0]["click_event"],
    // rust: json!({"action": "copy_to_clipboard", "value": "42"})
    // rust: );
}
}

formats_like_translatable_contents :: proc() {
}
    // rust: let a = [Text::literal("Steve"), Text::colored("Zombie", RED)];
    // rust: assert_eq!(
    // rust: format_translation("%s was slain by %s", &a).plain(),
    // rust: "Steve was slain by Zombie"
    // rust: );
    // rust: assert_eq!(
    // rust: format_translation("%2$s then %1$s", &a).plain(),
    // rust: "Zombie then Steve"
    // rust: );
    // rust: assert_eq!(
    // rust: format_translation("100%% sure %s", &a).plain(),
    // rust: "100% sure Steve"
    // rust: );
        // Missing arguments or unknown conversions show the template.
    // rust: assert_eq!(format_translation("%s %s %s", &a).plain(), "%s %s %s");
    // rust: assert_eq!(format_translation("%d", &a).plain(), "%d");
    // rust: assert_eq!(
    // rust: format_translation("50% off %s", &a).plain(),
    // rust: "50% off Steve"
    // rust: );
    // rust: assert_eq!(format_translation("end %", &a).plain(), "end %");
    // rust: let t = format_translation("%s was slain by %s", &a);
    // rust: assert_eq!(t.spans.last().unwrap().style.color, Some(RED));
}
legacy_codes_and_inheritance :: proc() {
}
    // rust: let t = Text::legacy("§aGreen §lbold§r plain");
    // rust: assert_eq!(t.plain(), "Green bold plain");
    // rust: assert_eq!(t.spans[0].style.color, Some(GREEN));
    // rust: assert!(t.spans[1].style.is_bold());
    // rust: assert_eq!(t.spans[2].style, Style::default());
    // rust: let t = Text::literal("x")
    // rust: .append(Text::colored("y", GOLD))
    // rust: .with_color(RED);
    // rust: assert_eq!(t.spans[0].style.color, Some(RED));
    // rust: assert_eq!(t.spans[1].style.color, Some(GOLD));
    // rust: assert_eq!(t.slice(1, 2).plain(), "y");
}
resolved_borrows_clean_text_and_restyles_codes :: proc() {
}
    // rust: let clean = Text::colored("Steve", GOLD);
    // rust: assert!(matches!(clean.resolved(), std::borrow::Cow::Borrowed(_)));
        // A colour code inside a span clears its decorations (a bold
        // "§cSteve" draws "Steve" red, not bold).
    // rust: let styled = Style {
    // rust: bold: Some(true),
    // rust: ..Style::default()
}
    // rust: let styled = Text::styled("§cSteve", styled);
    // rust: let resolved = styled.resolved();
    // rust: assert_eq!(resolved.plain(), "Steve");
    // rust: assert_eq!(resolved.spans[0].style.color, Some(RED));
    // rust: assert_eq!(resolved.spans[0].style.bold, Some(false));
}
}
