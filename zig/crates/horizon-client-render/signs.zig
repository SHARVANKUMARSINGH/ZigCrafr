//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_signs
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Sign block entities (`SignBlockEntity`, `SignText`): two four-line text
//! sides with a dye colour and glow, saved in vanilla's `front_text` /
//! `back_text` NBT layout.
    // rust: pub use crate::chunk::block_entity::{SavedLine, SignData, SignText};
// use crate::{scoreboard, text::Text};
// use horizon_world::nbt::Tag;

/// `DyeColor` names and `getTextColor` values by id.
    // rust: pub const DYE_TEXT: [(&str, u32); 16] = [
    // rust: ("white", 0xFFFFFF),
    // rust: ("orange", 0xFF681F),
    // rust: ("magenta", 0xFF00FF),
    // rust: ("light_blue", 0x9AC0CD),
    // rust: ("yellow", 0xFFFF00),
    // rust: ("lime", 0xBFFF00),
    // rust: ("pink", 0xFF69B4),
    // rust: ("gray", 0x808080),
    // rust: ("light_gray", 0xD3D3D3),
    // rust: ("cyan", 0x00FFFF),
    // rust: ("purple", 0xA020F0),
    // rust: ("blue", 0x0000FF),
    // rust: ("brown", 0x8B4513),
    // rust: ("green", 0x00FF00),
    // rust: ("red", 0xFF0000),
    // rust: ("black", 0x000000),
    // rust: ];
pub const BLACK: u8 = 15;

    // rust: impl Default for SignText {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: lines: Default::default(),
    // rust: color: BLACK,
    // rust: glowing: false,
    // rust: click: Default::default(),
    // rust: saved: Default::default(),
}
}
}
/// The click events `SignBlockEntity.executeClickCommandsIfPresent` acts on.
pub const ClickAction = enum {
    /// `ClickEvent.RunCommand`.
    RunCommand(String),
    /// `ClickEvent.ShowDialog`: a registry id or the dialog itself.
    ShowDialog(&'a Tag),
    /// `ClickEvent.Custom`.
    Custom {,
    id: String,
    payload: Option<&'a Tag>,
    // rust: },
};
/// A saved `click_event` as its action: the three a sign acts on, read the
/// way `ClickEvent.CODEC` does; any other action or a malformed one is None.
pub fn click_action(event: *Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(Tag::String(action)) = event.get("action") else {
    // rust: return None;
}
    // rust: match action.to_string_lossy().as_str() {
    // rust: "run_command" => match event.get("command") {
    // rust: Some(Tag::String(command)) => Some(ClickAction::RunCommand(command.to_string_lossy())),
    // rust: _ => None,
    // rust: },
    // rust: "show_dialog" => event.get("dialog").map(ClickAction::ShowDialog),
    // rust: "custom" => match event.get("id") {
    // rust: Some(Tag::String(id)) => Some(ClickAction::Custom {
    // rust: id: id.to_string_lossy(),
    // rust: payload: event.get("payload"),
    // rust: }),
    // rust: _ => None,
    // rust: },
    // rust: _ => None,
}
}
    // rust: impl SignText {
pub fn is_empty(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.lines.iter().all(String::is_empty)
}
    /// `DyeColor.getTextColor` of this side.
pub fn text_color(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: DYE_TEXT[usize::from(self.color.min(15))].1
}
    /// `SignText.hasAnyClickCommands`: a line whose style has a `run_command`
    /// click event.
pub fn has_any_click_commands(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.click
    // rust: .iter()
    // rust: .flatten()
    // rust: .any(|event| matches!(click_action(event), Some(ClickAction::RunCommand(_))))
}
    /// `AbstractSignRenderer.getDarkColor`.
pub fn dark_color(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let c = self.text_color();
    // rust: if c == 0 && self.glowing {
    // rust: 0xF0EBCC
    // rust: } else {
    // rust: let s = |shift: u32| ((((c >> shift) & 255) as f32 * 0.4) as u32) << shift;
    // rust: s(16) | s(8) | s(0)
}
}
    /// The component a line is saved as (`SignText.CODEC`): the one it was
    /// read as while its text is unchanged. A line edited since is a literal in
    /// the old line's root style, as `SignBlockEntity.setMessages` makes it
    /// (the style keeps its colour and click event, the siblings go).
pub fn message(self: *Self, i: usize) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let line = &self.lines[i];
    // rust: let saved = self.saved[i].as_ref();
    // rust: if let Some(saved) = saved.filter(|s| s.text == *line) {
    // rust: return saved.component.clone();
}
    // rust: let mut style = match saved {
    // rust: Some(saved) => root_style(&saved.component),
    // rust: None => self.click[i]
    // rust: .iter()
    // rust: .map(|event| ("click_event", event.clone()))
    // rust: .collect(),
}
    // rust: if style.is_empty() {
    // rust: return Tag::String(line.as_str().into());
}
    // rust: style.insert(0, ("text", Tag::String(line.as_str().into())));
    // rust: Tag::compound(style)
}
    /// A line as the font draws it: its styled runs, `§` codes not yet applied.
pub fn line_text(self: *Self, i: usize) T {
    // Implementation ported from Horizon
    return undefined;
}
        // Signs are drawn every frame: a line read as plain text (most of them) skips the
        // NBT -> JSON -> component round trip. Its click event does not change the drawing.
    // rust: if self.saved[i].is_none() {
    // rust: return Text::literal(self.lines[i].as_str());
}
    // rust: scoreboard::comp_text(&scoreboard::tag_to_json(&self.message(i)))
}
}

    // rust: impl SignData {
pub fn id(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.hanging {
    // rust: "minecraft:hanging_sign"
    // rust: } else {
    // rust: "minecraft:sign"
}
}
    /// `SignBlockEntity.getMaxTextLineWidth`.
pub fn max_line_width(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.hanging { 60.0 } else { 90.0 }
}
    /// `SignBlockEntity.getTextLineHeight`.
pub fn line_height(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.hanging { 9.0 } else { 10.0 }
}
    /// `SignBlockEntity.canExecuteClickCommands`: a waxed sign whose side
    /// has a `run_command` click event. (Horizon keeps no filtered text, so
    /// `Player.isTextFilteringEnabled` never selects it.)
pub fn can_execute_click_commands(self: *Self, front: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let side = if front { &self.front } else { &self.back };
    // rust: self.waxed && side.has_any_click_commands()
}
    /// NBT entries after the common block-entity header.
pub fn encode(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let side = |t: &SignText| {
    // rust: Tag::compound([
    // rust: (
    // rust: "messages",
    // rust: Tag::List((0..t.lines.len()).map(|i| t.message(i)).collect()),
    // rust: ),
    // rust: (
    // rust: "color",
    // rust: Tag::String(DYE_TEXT[usize::from(t.color.min(15))].0.into()),
    // rust: ),
    // rust: ("has_glowing_text", Tag::Byte(i8::from(t.glowing))),
    // rust: ])
}
    // rust: let mut out = Vec::new();
    // rust: if self.allow_op_features {
    // rust: out.push(("allow_op_features", Tag::Byte(1)));
}
    // rust: out.extend([
    // rust: ("front_text", side(&self.front)),
    // rust: ("back_text", side(&self.back)),
    // rust: ("is_waxed", Tag::Byte(i8::from(self.waxed))),
    // rust: ]);
    // rust: out
}
pub fn decode(self: *Self, tag: *Tag) void {
}
    // rust: let side = |t: Option<&Tag>| -> SignText {
    // rust: let mut out = SignText::default();
    // rust: let Some(t) = t else { return out };
    // rust: if let Some(Tag::List(messages)) = t.get("messages") {
    // rust: for (i, m) in messages.iter().take(4).enumerate() {
    // rust: out.lines[i] = component_text(m);
    // rust: out.click[i] = click_event(m);
    // rust: out.saved[i] = is_styled(m).then(|| SavedLine {
    // rust: text: out.lines[i].clone(),
    // rust: component: m.clone(),
    // rust: });
}
}
    // rust: if let Some(Tag::String(c)) = t.get("color") {
    // rust: let name = c.to_string_lossy();
    // rust: if let Some(i) = DYE_TEXT.iter().position(|(n, _)| *n == name) {
    // rust: out.color = i as u8;
}
}
    // rust: out.glowing = matches!(t.get("has_glowing_text"), Some(Tag::Byte(b)) if *b != 0);
    // rust: out
}
    // rust: self.front = side(tag.get("front_text"));
    // rust: self.back = side(tag.get("back_text"));
    // rust: self.waxed = matches!(tag.get("is_waxed"), Some(Tag::Byte(b)) if *b != 0);
    // rust: self.allow_op_features =
    // rust: matches!(tag.get("allow_op_features"), Some(Tag::Byte(b)) if *b != 0);
}
}
/// The `click_event` in the style of a stored line: the one of a component
/// object, or of the first component of a list (`createFromList` copies it
/// and appends the rest as siblings).
pub fn click_event(tag: *Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let root = match tag {
    // rust: Tag::List(list) => list.first()?,
    // rust: other => other,
}
    // rust: match root.get("click_event") {
    // rust: Some(event @ Tag::Compound(_)) => Some(event.clone()),
    // rust: _ => None,
}
}
/// Whether a saved message is more than its text: a style, siblings, another
/// kind of content, or a list. A string and a lone `{text: ...}` are not.
pub fn is_styled(tag: *Tag) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match tag {
    // rust: Tag::List(_) => true,
    // rust: Tag::Compound(c) => !(c.len() == 1 && matches!(tag.get("text"), Some(Tag::String(_)))),
    // rust: _ => false,
}
}
/// The fields of a component's own style (`Style.CODEC`), the ones a literal
/// made from it keeps. A list's style is its first element's.
    // rust: const STYLE_KEYS: [&str; 11] = [
    // rust: "color",
    // rust: "bold",
    // rust: "italic",
    // rust: "underlined",
    // rust: "strikethrough",
    // rust: "obfuscated",
    // rust: "shadow_color",
    // rust: "font",
    // rust: "click_event",
    // rust: "hover_event",
    // rust: "insertion",
    // rust: ];
pub fn root_style(component: *Tag) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let root = match component {
    // rust: Tag::List(list) => list.first(),
    // rust: other => Some(other),
}
    // rust: STYLE_KEYS
    // rust: .iter()
    // rust: .filter_map(|key| Some((*key, root?.get(key)?.clone())))
    // rust: .collect()
}
/// Plain text of a stored text component (string, `{text: ...}` or JSON string).
pub fn component_text(tag: *Tag) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match tag {
    // rust: Tag::String(s) => {
    // rust: let s = s.to_string_lossy();
    // rust: match serde_json::from_str::<serde_json::Value>(&s) {
    // rust: Ok(serde_json::Value::String(text)) => text,
    // rust: Ok(v) if v.get("text").is_some() => {
    // rust: v["text"].as_str().unwrap_or_default().to_owned()
}
    // rust: _ => s,
}
}
        // Component.getString: translations and key binds resolved.
    // rust: Tag::Compound(_) | Tag::List(_) => {
    // rust: scoreboard::comp_text(&scoreboard::tag_to_json(tag)).plain()
}
    // rust: _ => String::new(),
}
}
/// Whether a vanilla block's name is a sign (standing, wall, hanging or wall
/// hanging). A mod's sign goes by its template's class, whatever its name; a
/// mod's `road_sign` of stone is no sign.
pub fn sign_kind(name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = name.strip_prefix("minecraft:").unwrap_or(name);
    // rust: if name.contains(':') {
    // rust: None
    // rust: } else if name == "hanging_sign" || name.ends_with("_hanging_sign") {
    // rust: Some(true)
    // rust: } else if name == "sign" || name.ends_with("_sign") {
    // rust: Some(false)
    // rust: } else {
    // rust: None
}
}
/// The sprite of a wood type's editor background, `folder` being `signs` or
/// `hanging_signs`: `textures/gui/<folder>/<wood>.png` (`SignEditScreen`), in
/// a mod's namespace when the wood names one.
pub fn editor_sprite(folder: []const u8, wood: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match wood.split_once(':') {
    // rust: Some((namespace, path)) if namespace != "minecraft" => {
    // rust: format!("{namespace}:gui/{folder}/{path}")
}
    // rust: Some((_, path)) => format!("gui/{folder}/{path}"),
    // rust: None => format!("gui/{folder}/{wood}"),
}
}

    // rust: mod tests {
//     use super::*;
pub fn round_trips_nbt() void {
}
    // rust: let mut data = SignData {
    // rust: hanging: false,
    // rust: ..SignData::default()
}
    // rust: data.front.lines[0] = "Hello".into();
    // rust: data.front.color = 14;
    // rust: data.back.glowing = true;
    // rust: let tag = Tag::compound(data.encode());
    // rust: let mut decoded = SignData::default();
    // rust: decoded.decode(&tag);
    // rust: assert_eq!(decoded, data);
}
    /// A sign as a server sends it: a green "Online" and a plain line, the
    /// way `ComponentSerialization.CODEC` writes them to NBT.
pub fn styled_sign() T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let green = Tag::compound([
    // rust: ("text", Tag::String("Online".into())),
    // rust: ("color", Tag::String("green".into())),
    // rust: ]);
    // rust: let front = Tag::compound([(
    // rust: "messages",
    // rust: Tag::List(vec![
    // rust: Tag::String("[KnockIT-1]".into()),
    // rust: green,
    // rust: Tag::String("".into()),
    // rust: Tag::String("0 / 20".into()),
    // rust: ]),
    // rust: )]);
    // rust: Tag::compound([("front_text", front)])
}
pub fn front_messages(tag: *Tag) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match tag.get("front_text").and_then(|t| t.get("messages")) {
    // rust: Some(Tag::List(list)) => list,
    // rust: other => panic!("no messages: {other:?}"),
}
}
pub fn run_colors(text: *SignText, line: usize) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: text.line_text(line)
    // rust: .spans
    // rust: .into_iter()
    // rust: .map(|s| (s.text, s.style.color))
    // rust: .collect()
}
pub fn a_lines_color_is_read_and_written_back() void {
}
    // rust: let saved = styled_sign();
    // rust: let mut data = SignData::default();
    // rust: data.decode(&saved);
    // rust: assert_eq!(data.front.lines[1], "Online");
        // Green is `ChatFormatting.GREEN`; the dye colour of the side is untouched.
    // rust: assert_eq!(
    // rust: run_colors(&data.front, 1),
    // rust: [("Online".to_owned(), Some(0x55FF55))]
    // rust: );
    // rust: assert_eq!(
    // rust: run_colors(&data.front, 0),
    // rust: [("[KnockIT-1]".to_owned(), None)]
    // rust: );
    // rust: assert!(run_colors(&data.front, 2).is_empty());
        // Saved and sent as it came: the coloured line keeps its component and
        // the plain ones stay plain strings.
    // rust: let encoded = Tag::compound(data.encode());
    // rust: assert_eq!(front_messages(&encoded), front_messages(&saved));
}
pub fn a_list_component_shows_all_its_parts_in_their_own_styles() void {
}
    // rust: let tag = Tag::compound([(
    // rust: "front_text",
    // rust: Tag::compound([(
    // rust: "messages",
    // rust: Tag::List(vec![Tag::List(vec![
    // rust: Tag::compound([
    // rust: ("text", Tag::String("Hi ".into())),
    // rust: ("color", Tag::String("red".into())),
    // rust: ]),
    // rust: Tag::compound([
    // rust: ("text", Tag::String("there".into())),
    // rust: ("color", Tag::String("#00FF00".into())),
    // rust: ]),
    // rust: ])]),
    // rust: )]),
    // rust: )]);
    // rust: let mut data = SignData::default();
    // rust: data.decode(&tag);
    // rust: assert_eq!(data.front.lines[0], "Hi there");
        // The list's later parts take the first one's style unless they set their own.
    // rust: assert_eq!(
    // rust: run_colors(&data.front, 0),
    // rust: [
    // rust: ("Hi ".to_owned(), Some(0xFF5555)),
    // rust: ("there".to_owned(), Some(0x00FF00))
    // rust: ]
    // rust: );
}
pub fn an_edited_line_keeps_only_the_old_lines_style() void {
}
    // rust: let mut data = SignData::default();
    // rust: data.decode(&styled_sign());
        // `SignBlockEntity.setMessages`: a new literal with the old line's style.
    // rust: data.front.lines[1] = "Full".into();
    // rust: let encoded = Tag::compound(data.encode());
    // rust: assert_eq!(
    // rust: front_messages(&encoded),
    // rust: &vec![
    // rust: Tag::String("[KnockIT-1]".into()),
    // rust: Tag::compound([
    // rust: ("text", Tag::String("Full".into())),
    // rust: ("color", Tag::String("green".into())),
    // rust: ]),
    // rust: Tag::String("".into()),
    // rust: Tag::String("0 / 20".into()),
    // rust: ]
    // rust: );
    // rust: assert_eq!(
    // rust: run_colors(&data.front, 1),
    // rust: [("Full".to_owned(), Some(0x55FF55))]
    // rust: );
        // A line that had no style stays plain.
    // rust: data.front.lines[0] = "[KnockIT-2]".into();
    // rust: assert!(matches!(data.front.message(0), Tag::String(_)));
}
pub fn a_translated_line_is_not_flattened_by_a_round_trip() void {
}
    // rust: let tag = Tag::compound([(
    // rust: "front_text",
    // rust: Tag::compound([(
    // rust: "messages",
    // rust: Tag::List(vec![Tag::compound([(
    // rust: "translate",
    // rust: Tag::String("block.minecraft.stone".into()),
    // rust: )])]),
    // rust: )]),
    // rust: )]);
    // rust: let mut data = SignData::default();
    // rust: data.decode(&tag);
    // rust: let encoded = Tag::compound(data.encode());
    // rust: assert_eq!(front_messages(&encoded)[0], front_messages(&tag)[0]);
}
pub fn a_mods_sign_like_name_does_not_make_it_a_sign() void {
}
    // rust: assert_eq!(sign_kind("ruby:road_sign"), None);
    // rust: assert!(crate::containers::BlockEntity::for_block("ruby:road_sign").is_none());
}
pub fn names_and_colors() void {
}
    // rust: assert_eq!(sign_kind("minecraft:oak_wall_hanging_sign"), Some(true));
    // rust: assert_eq!(sign_kind("minecraft:sign"), Some(false));
    // rust: assert_eq!(sign_kind("minecraft:spruce_wall_sign"), Some(false));
    // rust: assert_eq!(sign_kind("minecraft:stone"), None);
    // rust: assert_eq!(editor_sprite("signs", "dark_oak"), "gui/signs/dark_oak");
    // rust: assert_eq!(
    // rust: editor_sprite("signs", "minecraft:cherry"),
    // rust: "gui/signs/cherry"
    // rust: );
    // rust: assert_eq!(
    // rust: editor_sprite("hanging_signs", "ruby:elm"),
    // rust: "ruby:gui/hanging_signs/elm"
    // rust: );
    // rust: assert_eq!(SignText::default().dark_color(), 0);
    // rust: let red = SignText {
    // rust: color: 14,
    // rust: ..SignText::default()
}
    // rust: assert_eq!(red.dark_color(), 0x660000);
}
}
