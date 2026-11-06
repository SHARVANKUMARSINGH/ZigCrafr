//! Transpiled from Horizon Rust crate
package horizon_client_core_scoreboard

import "core:fmt"
import "core:mem"
import "core:math"

// The scoreboard (`Scoreboard`, `Objective`, `Score`, `PlayerTeam`,
// `ObjectiveCriteria`, `NumberFormat`) and its saved data
// (`data/minecraft/scoreboard.dat`, `ScoreboardSaveData.Packed`).
// use crate::{
    // rust: component,
    // rust: fastutil_order::{HashSetOrder, OpenOrder},
    // rust: registries::Registries,
    // rust: text::{self, Style, Text},
}
// use horizon_world::nbt::Tag;
// use serde_json::Value;
// use std::collections::BTreeMap;

// A text component in its JSON form (what `ComponentSerialization` holds).
    // rust: pub type Comp = Value;

literal :: proc(s: string) -> C {
    // Ported from Horizon
    return {}
}
    // rust: Value::String(s.to_owned())
}
comp_text :: proc(c: ^Comp) -> T {
    // Ported from Horizon
    return {}
}
    // rust: component::to_text(c, &mut |s| Text::literal(s))
}
// `ComponentUtils.wrapInSquareBrackets`.
bracketed :: proc(inner: Text) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Text::translate("chat.square_brackets", &[inner])
}
hover_name :: proc(text: Text, name: string) -> T {
    // Ported from Horizon
    return {}
}
    // rust: text.with_style(&Style {
    // rust: hover: Some(Box::new(Text::literal(name))),
    // rust: ..Style::default()
    // rust: })
}

// ---- NBT <-> JSON ------------------------------------------------------

json_to_tag :: proc(v: ^Value) -> T {
    // Ported from Horizon
    return {}
}
    // rust: match v {
    // rust: Value::Null => Tag::String("".into()),
    // rust: Value::Bool(b) => Tag::Byte(i8::from(*b)),
    // rust: Value::Number(n) => match n.as_i64() {
    // rust: Some(i) => i32::try_from(i).map_or(Tag::Long(i), Tag::Int),
    // rust: None => Tag::Double(n.as_f64().unwrap_or(0.0).to_bits()),
    // rust: },
    // rust: Value::String(s) => Tag::String(s.as_str().into()),
    // rust: Value::Array(a) => Tag::List(a.iter().map(json_to_tag).collect()),
    // rust: Value::Object(o) => Tag::Compound(
    // rust: o.iter()
    // rust: .map(|(k, v)| (k.as_str().into(), json_to_tag(v)))
    // rust: .collect(),
    // rust: ),
}
}
tag_to_json :: proc(t: ^Tag) -> V {
    // Ported from Horizon
    return {}
}
    // rust: match t {
    // rust: Tag::End => Value::Null,
    // rust: Tag::Byte(b) => Value::Bool(*b != 0),
    // rust: Tag::Short(v) => Value::from(*v),
    // rust: Tag::Int(v) => Value::from(*v),
    // rust: Tag::Long(v) => Value::from(*v),
    // rust: Tag::Float(v) => Value::from(f64::from(f32::from_bits(*v))),
    // rust: Tag::Double(v) => Value::from(f64::from_bits(*v)),
    // rust: Tag::String(s) => Value::String(s.to_string_lossy()),
    // rust: Tag::List(l) => Value::Array(l.iter().map(tag_to_json).collect()),
    // rust: Tag::Compound(c) => Value::Object(
    // rust: c.iter()
    // rust: .map(|(k, v)| (k.to_string_lossy(), tag_to_json(v)))
    // rust: .collect(),
    // rust: ),
    // rust: Tag::ByteArray(b) => Value::Array(b.iter().map(|v| Value::from(*v)).collect()),
    // rust: Tag::IntArray(b) => Value::Array(b.iter().map(|v| Value::from(*v)).collect()),
    // rust: Tag::LongArray(b) => Value::Array(b.iter().map(|v| Value::from(*v)).collect()),
}
}
string_of :: proc(t: Maybe(^Tag)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match t {
    // rust: Some(Tag::String(s)) => Some(s.to_string_lossy()),
    // rust: _ => None,
}
}
bool_of :: proc(t: Maybe(^Tag), default: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match t {
    // rust: Some(Tag::Byte(b)) => *b != 0,
    // rust: _ => default,
}
}
int_of :: proc(t: Maybe(^Tag)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match t {
    // rust: Some(Tag::Int(v)) => Some(*v),
    // rust: Some(Tag::Short(v)) => Some(i32::from(*v)),
    // rust: Some(Tag::Byte(v)) => Some(i32::from(*v)),
    // rust: _ => None,
}
}

// ---- number formats ----------------------------------------------------

// `NumberFormat`: how a score value is shown.
NumberFormat :: enum {
    Blank,
    Fixed(Comp),
    // A style object (`{color: "red", bold: true}`).
    Styled(Comp),
}
// A `Style` from its JSON object form.
style_from_json :: proc(v: ^Value) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut s = Style::default();
    // rust: let Some(o) = v.as_object() else { return s };
    // rust: if let Some(c) = o.get("color").and_then(Value::as_str) {
    // rust: s.color = text::named_color(c).or_else(|| component::hex_color(c));
}
    // rust: s.shadow_color = o.get("shadow_color").and_then(component::shadow_color);
    // rust: let flag = |k: &str| o.get(k).and_then(Value::as_bool);
    // rust: s.bold = flag("bold");
    // rust: s.italic = flag("italic");
    // rust: s.underlined = flag("underlined");
    // rust: s.strikethrough = flag("strikethrough");
    // rust: s.obfuscated = flag("obfuscated");
    // rust: s.font = o.get("font").and_then(text::font_id);
    // rust: s
}
    // rust: impl NumberFormat {
sidebar_default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: NumberFormat::Styled(serde_json::json!({"color": "red"}))
}
player_list_default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: NumberFormat::Styled(serde_json::json!({"color": "yellow"}))
}
format :: proc(self: ^Self, value: i32) -> T {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: NumberFormat::Blank => Text::empty(),
    // rust: NumberFormat::Fixed(c) => comp_text(c),
    // rust: NumberFormat::Styled(style) => {
    // rust: Text::literal(value.to_string()).with_style(&style_from_json(style))
}
}
}
    // `NumberFormatTypes.CODEC` encoding.
to_json :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: NumberFormat::Blank => serde_json::json!({"type": "minecraft:blank"}),
    // rust: NumberFormat::Fixed(c) => {
    // rust: serde_json::json!({"type": "minecraft:fixed", "value": canonical_component(c)})
}
    // rust: NumberFormat::Styled(style) => {
    // rust: let mut v = canonical_style(style);
    // rust: if let Value::Object(o) = &mut v {
    // rust: o.insert("type".into(), Value::String("minecraft:styled".into()));
}
    // rust: v
}
}
}
    // `NumberFormatTypes.CODEC` decoding.
from_json :: proc(v: ^Value) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let kind = v.get("type")?.as_str()?;
    // rust: match kind.trim_start_matches("minecraft:") {
    // rust: "blank" => Some(NumberFormat::Blank),
    // rust: "fixed" => Some(NumberFormat::Fixed(v.get("value")?.clone())),
    // rust: "styled" => {
    // rust: let mut v = v.clone();
    // rust: if let Value::Object(o) = &mut v {
    // rust: o.remove("type");
}
    // rust: Some(NumberFormat::Styled(v))
}
    // rust: _ => None,
}
}
to_tag :: proc(self: ^Self) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let mut tag = json_to_tag(&self.to_json());
    // rust: entity_uuids(&mut tag);
    // rust: tag
}
from_tag :: proc(t: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Self::from_json(&tag_to_json(t))
}
}

// ---- criteria ------------------------------------------------------------

RenderType :: enum {
    Integer,
    Hearts,
}
    // rust: impl RenderType {
id :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: RenderType::Integer => "integer",
    // rust: RenderType::Hearts => "hearts",
}
}
by_id :: proc(id: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: if id == "hearts" {
    // rust: RenderType::Hearts
    // rust: } else {
    // rust: RenderType::Integer
}
}
}
CRITERIA_DUMMY :: "dummy"
CRITERIA_TRIGGER :: "trigger"
CRITERIA_DEATH_COUNT :: "deathCount"
CRITERIA_PLAYER_KILLS :: "playerKillCount"
CRITERIA_TOTAL_KILLS :: "totalKillCount"
CRITERIA_HEALTH :: "health"
CRITERIA_FOOD :: "food"
CRITERIA_AIR :: "air"
CRITERIA_ARMOR :: "armor"
CRITERIA_XP :: "xp"
CRITERIA_LEVEL :: "level"
// `ObjectiveCriteria.getCustomCriteriaNames` (without the per-colour ones).
    // rust: pub const CUSTOM_CRITERIA: [&str; 11] = [
    // rust: CRITERIA_DUMMY,
    // rust: CRITERIA_TRIGGER,
    // rust: CRITERIA_DEATH_COUNT,
    // rust: CRITERIA_PLAYER_KILLS,
    // rust: CRITERIA_TOTAL_KILLS,
    // rust: CRITERIA_HEALTH,
    // rust: CRITERIA_FOOD,
    // rust: CRITERIA_AIR,
    // rust: CRITERIA_ARMOR,
    // rust: CRITERIA_XP,
    // rust: CRITERIA_LEVEL,
    // rust: ];
// `Stats` custom statistic ids.
    // rust: pub const CUSTOM_STATS: &[&str] = &[
    // rust: "leave_game",
    // rust: "play_time",
    // rust: "total_world_time",
    // rust: "time_since_death",
    // rust: "time_since_rest",
    // rust: "sneak_time",
    // rust: "walk_one_cm",
    // rust: "crouch_one_cm",
    // rust: "sprint_one_cm",
    // rust: "walk_on_water_one_cm",
    // rust: "fall_one_cm",
    // rust: "climb_one_cm",
    // rust: "fly_one_cm",
    // rust: "walk_under_water_one_cm",
    // rust: "minecart_one_cm",
    // rust: "boat_one_cm",
    // rust: "pig_one_cm",
    // rust: "happy_ghast_one_cm",
    // rust: "horse_one_cm",
    // rust: "aviate_one_cm",
    // rust: "swim_one_cm",
    // rust: "strider_one_cm",
    // rust: "nautilus_one_cm",
    // rust: "jump",
    // rust: "drop",
    // rust: "damage_dealt",
    // rust: "damage_dealt_absorbed",
    // rust: "damage_dealt_resisted",
    // rust: "damage_taken",
    // rust: "damage_blocked_by_shield",
    // rust: "damage_absorbed",
    // rust: "damage_resisted",
    // rust: "deaths",
    // rust: "mob_kills",
    // rust: "animals_bred",
    // rust: "player_kills",
    // rust: "fish_caught",
    // rust: "talked_to_villager",
    // rust: "traded_with_villager",
    // rust: "eat_cake_slice",
    // rust: "fill_cauldron",
    // rust: "use_cauldron",
    // rust: "clean_armor",
    // rust: "clean_banner",
    // rust: "clean_shulker_box",
    // rust: "interact_with_brewingstand",
    // rust: "interact_with_beacon",
    // rust: "inspect_dropper",
    // rust: "inspect_hopper",
    // rust: "inspect_dispenser",
    // rust: "play_noteblock",
    // rust: "tune_noteblock",
    // rust: "pot_flower",
    // rust: "trigger_trapped_chest",
    // rust: "open_enderchest",
    // rust: "enchant_item",
    // rust: "play_record",
    // rust: "interact_with_furnace",
    // rust: "interact_with_crafting_table",
    // rust: "open_chest",
    // rust: "sleep_in_bed",
    // rust: "sleep_in_straw_bed",
    // rust: "open_shulker_box",
    // rust: "open_barrel",
    // rust: "interact_with_blast_furnace",
    // rust: "interact_with_smoker",
    // rust: "interact_with_lectern",
    // rust: "interact_with_campfire",
    // rust: "interact_with_cartography_table",
    // rust: "interact_with_loom",
    // rust: "interact_with_stonecutter",
    // rust: "bell_ring",
    // rust: "raid_trigger",
    // rust: "raid_win",
    // rust: "interact_with_anvil",
    // rust: "interact_with_grindstone",
    // rust: "target_hit",
    // rust: "interact_with_smithing_table",
    // rust: ];
    // rust: pub const STAT_TYPES: &[&str] = &[
    // rust: "mined",
    // rust: "crafted",
    // rust: "used",
    // rust: "broken",
    // rust: "picked_up",
    // rust: "dropped",
    // rust: "killed",
    // rust: "killed_by",
    // rust: "custom",
    // rust: ];

// The 16 team colours (`TeamColor`).
team_colors :: proc() -> i {
    // Ported from Horizon
    return {}
}
    // rust: text::COLORS.iter().map(|c| c.1)
}
team_color_rgb :: proc(name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: text::named_color(name)
}
is_team_criteria :: proc(name: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: ["teamkill.", "killedByTeam."].iter().any(|p| {
    // rust: name.strip_prefix(p)
    // rust: .is_some_and(|c| team_colors().any(|t| t == c))
    // rust: })
}
// `Identifier.bySeparator`: `None` for characters an identifier cannot hold
// (vanilla throws).
identifier_by_separator :: proc(id: string, sep: char) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let (ns, path) = match id.find(sep) {
    // rust: Some(0) => ("minecraft", &id[1..]),
    // rust: Some(i) => (&id[..i], &id[i + 1..]),
    // rust: None => ("minecraft", id),
}
    // rust: let ns_ok = ns
    // rust: .chars()
    // rust: .all(|c| matches!(c, 'a'..='z' | '0'..='9' | '_' | '-' | '.'));
    // rust: let path_ok = path
    // rust: .chars()
    // rust: .all(|c| matches!(c, 'a'..='z' | '0'..='9' | '_' | '-' | '.' | '/'));
    // rust: (ns_ok && path_ok).then(|| format!("{ns}:{path}"))
}
// An identifier vanilla's `Identifier` constructor rejects (it throws).
InvalidIdentifier :: struct {
// `ObjectiveCriteria.byName`: the criteria's canonical name (statistics are
// named `minecraft.<type>:<namespace>.<path>` whatever the spelling used),
// `Ok(None)` for no such criteria and `Err` where vanilla throws on an
// invalid identifier.
criteria_by_name :: proc(name: string, reg: ^Registries) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if CUSTOM_CRITERIA.contains(&name) || is_team_criteria(name) {
    // rust: return Ok(Some(name.to_owned()));
}
    // rust: let Some(colon) = name.find(':') else {
    // rust: return Ok(None);
}
    // rust: let ty = identifier_by_separator(&name[..colon], '.').ok_or(InvalidIdentifier)?;
    // rust: let Some(ty) = ty
    // rust: .strip_prefix("minecraft:")
    // rust: .filter(|t| STAT_TYPES.contains(t))
    // rust: else {
    // rust: return Ok(None);
}
    // rust: let key = identifier_by_separator(&name[colon + 1..], '.').ok_or(InvalidIdentifier)?;
    // rust: let known = match ty {
    // rust: "mined" => reg.blocks.is_empty() || reg.blocks.contains_key(&key),
    // rust: "crafted" | "used" | "broken" | "picked_up" | "dropped" => {
    // rust: reg.items.is_empty() || reg.items.contains(&key)
}
    // rust: "killed" | "killed_by" => reg.entity_types.is_empty() || reg.entity_types.contains(&key),
    // rust: "custom" => key
    // rust: .strip_prefix("minecraft:")
    // rust: .is_some_and(|k| CUSTOM_STATS.contains(&k)),
    // rust: _ => false,
}
    // rust: Ok(known.then(|| stat_criteria(ty, &key)))
}
// Whether `ObjectiveCriteria.byName` finds the criteria.
criteria_exists :: proc(name: string, reg: ^Registries) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(criteria_by_name(name, reg), Ok(Some(_)))
}
// `ObjectiveCriteria.isReadOnly`.
criteria_read_only :: proc(name: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: name,
    // rust: CRITERIA_HEALTH
    // rust: | CRITERIA_FOOD
    // rust: | CRITERIA_AIR
    // rust: | CRITERIA_ARMOR
    // rust: | CRITERIA_XP
    // rust: | CRITERIA_LEVEL
    // rust: )
}
criteria_render_type :: proc(name: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if name == CRITERIA_HEALTH {
    // rust: RenderType::Hearts
    // rust: } else {
    // rust: RenderType::Integer
}
}
// `Stat.buildName`: the criteria that counts a statistic.
stat_criteria :: proc(stat_type: string, key: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!(
    // rust: "minecraft.{}:{}",
    // rust: stat_type.trim_start_matches("minecraft:"),
    // rust: key.replace(':', ".")
    // rust: )
}

// ---- display slots -----------------------------------------------------

SLOT_LIST :: "list"
SLOT_SIDEBAR :: "sidebar"
SLOT_BELOW_NAME :: "below_name"
// Every `DisplaySlot` name, in id order.
display_slots :: proc() -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut v: Vec<String> = ["list", "sidebar", "below_name"]
    // rust: .iter()
    // rust: .map(|s| (*s).to_owned())
    // rust: .collect();
    // rust: v.extend(team_colors().map(|c| format!("sidebar.team.{c}")));
    // rust: v
}
display_slot_valid :: proc(name: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: display_slots().iter().any(|s| s == name)
}

// ---- teams ---------------------------------------------------------------

Visibility :: enum {
    Always,
    Never,
    HideForOtherTeams,
    HideForOwnTeam,
}
    // rust: impl Visibility {
    // rust: pub const ALL: [Visibility; 4] = [
    // rust: Visibility::Always,
    // rust: Visibility::Never,
    // rust: Visibility::HideForOtherTeams,
    // rust: Visibility::HideForOwnTeam,
    // rust: ];
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Visibility::Always => "always",
    // rust: Visibility::Never => "never",
    // rust: Visibility::HideForOtherTeams => "hideForOtherTeams",
    // rust: Visibility::HideForOwnTeam => "hideForOwnTeam",
}
}
by_name :: proc(n: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Self::ALL.into_iter().find(|v| v.name() == n)
}
display_name :: proc(self: ^Self) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Text::translate(&format!("team.visibility.{}", self.name()), &[])
}
}
CollisionRule :: enum {
    Always,
    Never,
    PushOtherTeams,
    PushOwnTeam,
}
    // rust: impl CollisionRule {
    // rust: pub const ALL: [CollisionRule; 4] = [
    // rust: CollisionRule::Always,
    // rust: CollisionRule::Never,
    // rust: CollisionRule::PushOtherTeams,
    // rust: CollisionRule::PushOwnTeam,
    // rust: ];
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: CollisionRule::Always => "always",
    // rust: CollisionRule::Never => "never",
    // rust: CollisionRule::PushOtherTeams => "pushOtherTeams",
    // rust: CollisionRule::PushOwnTeam => "pushOwnTeam",
}
}
by_name :: proc(n: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Self::ALL.into_iter().find(|v| v.name() == n)
}
display_name :: proc(self: ^Self) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Text::translate(&format!("team.collision.{}", self.name()), &[])
}
}

Team :: struct {
    name: string,
    display_name: Comp,
    color: Maybe(string),
    allow_friendly_fire: bool,
    see_friendly_invisibles: bool,
    prefix: Comp,
    suffix: Comp,
    nametag_visibility: Visibility,
    death_message_visibility: Visibility,
    collision_rule: CollisionRule,
    // `Sets.newHashSet()`, in its iteration order.
    players: HashSetOrder,
}
    // rust: impl Team {
new :: proc(name: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: name: name.to_owned(),
    // rust: display_name: literal(name),
    // rust: color: None,
    // rust: allow_friendly_fire: true,
    // rust: see_friendly_invisibles: true,
    // rust: prefix: literal(""),
    // rust: suffix: literal(""),
    // rust: nametag_visibility: Visibility::Always,
    // rust: death_message_visibility: Visibility::Always,
    // rust: collision_rule: CollisionRule::Always,
    // rust: players: HashSetOrder::default(),
}
}
apply_color :: proc(self: ^Self, t: Text) -> T {
    // Ported from Horizon
    return {}
}
    // rust: match self.color.as_deref().and_then(team_color_rgb) {
    // rust: Some(c) => t.with_color(c),
    // rust: None => t,
}
}
    // `PlayerTeam.getFormattedDisplayName`.
formatted_display_name :: proc(self: ^Self) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let inner = hover_name(comp_text(&self.display_name), &self.name).with_style(&Style {
    // rust: click: None,
    // rust: ..Style::default()
    // rust: });
    // rust: self.apply_color(bracketed(inner))
}
    // `PlayerTeam.getFormattedName`: prefix, name and suffix in the team colour.
formatted_name :: proc(self: ^Self, member: Text) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let mut t = Text::empty();
    // rust: t.push(comp_text(&self.prefix));
    // rust: t.push(member);
    // rust: t.push(comp_text(&self.suffix));
    // rust: self.apply_color(t)
}
    // `PlayerTeam.getFormattedName` as a component (`Component.empty()
    // .append(prefix).append(name).append(suffix)` with the team colour).
formatted_name_comp :: proc(self: ^Self, member: ^Comp) -> C {
    // Ported from Horizon
    return {}
}
    // rust: let mut c = serde_json::json!({
    // rust: "text": "",
    // rust: "extra": [self.prefix.clone(), member.clone(), self.suffix.clone()],
    // rust: });
    // rust: if let Some(color) = &self.color {
    // rust: c["color"] = Value::String(color.clone());
}
    // rust: c
}
}

// ---- team rules in gameplay ------------------------------------------------

// `Team.isAlliedTo`: both on the same team.
teams_allied :: proc(own: Maybe(^Team), other: Maybe(^Team)) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!((own, other), (Some(a), Some(b)) if a.name == b.name)
}
// `Entity.doTeamsAllowDamage`: an entity may hurt another unless they are
// allies on a team without friendly fire (also `Player.canHarmPlayer`).
teams_allow_damage :: proc(own: Maybe(^Team), other: Maybe(^Team)) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match own {
    // rust: None => true,
    // rust: Some(t) => !teams_allied(own, other) || t.allow_friendly_fire,
}
}
// `EntitySelector.pushableBy(entity).test(input)` on the server (or for the
// local player on the client): whether `entity` pushes `input`, which must
// be pushable and not a spectator.
pushable_by :: proc(own: Maybe(^Team), their: Maybe(^Team), their_pushable: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let own_rule = own.map_or(CollisionRule::Always, |t| t.collision_rule);
    // rust: if own_rule == CollisionRule::Never || !their_pushable {
    // rust: return false;
}
    // rust: let their_rule = their.map_or(CollisionRule::Always, |t| t.collision_rule);
    // rust: if their_rule == CollisionRule::Never {
    // rust: return false;
}
    // rust: let same = teams_allied(own, their);
    // rust: if (own_rule == CollisionRule::PushOwnTeam || their_rule == CollisionRule::PushOwnTeam) && same
    // rust: {
    // rust: return false;
}
    // rust: own_rule != CollisionRule::PushOtherTeams && their_rule != CollisionRule::PushOtherTeams || same
}
// `Entity.isInvisibleTo(player)`: invisible unless the viewer spectates or
// shares a team that sees friendly invisibles.
    // rust: pub fn invisible_to(
    // rust: own: Option<&Team>,
    // rust: viewer: Option<&Team>,
    // rust: viewer_spectator: bool,
    // rust: invisible: bool,
    // rust: ) -> bool {
    // rust: if viewer_spectator {
    // rust: return false;
}
    // rust: match own {
    // rust: Some(t) if teams_allied(own, viewer) && t.see_friendly_invisibles => false,
    // rust: _ => invisible,
}
}
// The team part of `LivingEntityRenderer.shouldShowName` for an entity
// other than the viewer: `Some(shown)` when the entity's team decides,
// `None` when it has no team.
    // rust: pub fn team_shows_name(
    // rust: own: Option<&Team>,
    // rust: viewer: Option<&Team>,
    // rust: visible_to_viewer: bool,
    // rust: ) -> Option<bool> {
    // rust: let t = own?;
    // rust: Some(match t.nametag_visibility {
    // rust: Visibility::Always => visible_to_viewer,
    // rust: Visibility::Never => false,
    // rust: Visibility::HideForOtherTeams => match viewer {
    // rust: None => visible_to_viewer,
    // rust: Some(_) => {
    // rust: teams_allied(own, viewer) && (t.see_friendly_invisibles || visible_to_viewer)
}
    // rust: },
    // rust: Visibility::HideForOwnTeam => match viewer {
    // rust: None => visible_to_viewer,
    // rust: Some(_) => !teams_allied(own, viewer) && visible_to_viewer,
    // rust: },
    // rust: })
}
// What `LivingEntityRenderer.shouldShowName` asks of a living entity other
// than the viewer.
NameView :: struct {
    // Crouching (`isDiscrete`): its name hides beyond 32 blocks.
    discrete: bool,
    distance_sqr: f64,
    // `isInvisibleTo(viewer)`.
    invisible_to_viewer: bool,
    // F1 (`Hud.isHidden`).
    hud_hidden: bool,
    // The camera is this entity.
    is_camera: bool,
    // Something rides it.
    is_vehicle: bool,
}
// `LivingEntityRenderer.shouldShowName` (before a mob renderer's own check
// for a visible or targeted custom name).
name_shown :: proc(own: Maybe(^Team), viewer: Maybe(^Team), v: NameView) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if v.discrete && v.distance_sqr >= 1024.0 {
    // rust: return false;
}
    // rust: let visible = !v.invisible_to_viewer;
    // rust: if let Some(shown) = team_shows_name(own, viewer, visible) {
    // rust: return shown;
}
    // rust: !v.hud_hidden && !v.is_camera && visible && !v.is_vehicle
}
// `ServerPlayer.die`: whether `other` hears the death message of `dying`
// (`broadcastSystemMessage`, `broadcastSystemToTeam` or
// `broadcastSystemToAllExceptTeam`, by the team's death message visibility).
death_message_reaches :: proc(board: ^Scoreboard, dying: string, other: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(team) = board.players_team(dying) else {
    // rust: return true;
}
    // rust: let same_team = board
    // rust: .players_team(other)
    // rust: .is_some_and(|t| t.name == team.name);
    // rust: match team.death_message_visibility {
    // rust: Visibility::Always => true,
    // rust: Visibility::Never => false,
    // rust: Visibility::HideForOtherTeams => same_team && other != dying,
    // rust: Visibility::HideForOwnTeam => !same_team,
}
}

// ---- objectives and scores ---------------------------------------------

Objective :: struct {
    name: string,
    criteria: string,
    display_name: Comp,
    render_type: RenderType,
    display_auto_update: bool,
    number_format: Maybe(NumberFormat),
}
    // rust: impl Objective {
    // `Objective.getFormattedDisplayName`.
formatted_display_name :: proc(self: ^Self) -> T {
    // Ported from Horizon
    return {}
}
    // rust: bracketed(hover_name(comp_text(&self.display_name), &self.name))
}
display_text :: proc(self: ^Self) -> T {
    // Ported from Horizon
    return {}
}
    // rust: comp_text(&self.display_name)
}
format_or_default :: proc(self: ^Self, default: NumberFormat) -> N {
    // Ported from Horizon
    return {}
}
    // rust: self.number_format.clone().unwrap_or(default)
}
}
Score :: struct {
    value: i32,
    locked: bool,
    display: Maybe(Comp),
    number_format: Maybe(NumberFormat),
}
    // rust: impl Default for Score {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: value: 0,
    // rust: locked: true,
    // rust: display: None,
    // rust: number_format: None,
}
}
}
// One row of an objective (`PlayerScoreEntry`).
ScoreEntry :: struct {
    owner: string,
    value: i32,
    display: Maybe(Comp),
    number_format: Maybe(NumberFormat),
}
    // rust: impl ScoreEntry {
is_hidden :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.owner.starts_with('#')
}
owner_name :: proc(self: ^Self) -> T {
    // Ported from Horizon
    return {}
}
    // rust: match &self.display {
    // rust: Some(d) => comp_text(d),
    // rust: None => Text::literal(self.owner.clone()),
}
}
format_value :: proc(self: ^Self, default: ^NumberFormat) -> T {
    // Ported from Horizon
    return {}
}
    // rust: self.number_format
    // rust: .as_ref()
    // rust: .unwrap_or(default)
    // rust: .format(self.value)
}
}

// `Scoreboard`: objectives, scores, display slots and teams, kept in the
// iteration orders of vanilla's hash maps.
Scoreboard :: struct {
    // `objectivesByName` in its iterator order (`getObjectives()`).
    objectives: [dynamic]Objective,
    objective_order: OpenOrder,
    // `objectivesByCriteria`: each criteria's objectives in creation order.
    by_criteria: BTreeMap<string,
    // `playerScores`: each holder's scores by objective. A holder stays
    // tracked when its last objective is removed.
    scores: BTreeMap<string,
    holder_order: OpenOrder,
    display: BTreeMap<string,
    // `teamsByName` in its iterator order (`getPlayerTeams()`).
    teams: [dynamic]Team,
    team_order: OpenOrder,
    team_of: BTreeMap<string,
}
    // rust: impl Default for Scoreboard {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: objectives: Vec::new(),
    // rust: objective_order: OpenOrder::new(16, 0.5),
    // rust: by_criteria: BTreeMap::new(),
    // rust: scores: BTreeMap::new(),
    // rust: holder_order: OpenOrder::new(16, 0.5),
    // rust: display: BTreeMap::new(),
    // rust: teams: Vec::new(),
    // rust: team_order: OpenOrder::default(),
    // rust: team_of: BTreeMap::new(),
}
}
}
    // rust: fn ranked<T>(items: &mut [T], order: &OpenOrder, name: impl Fn(&T) -> &str) {
    // rust: let rank: BTreeMap<&str, usize> = order.iter().enumerate().map(|(i, k)| (k, i)).collect();
    // rust: items.sort_by_key(|t| rank.get(name(t)).copied().unwrap_or(usize::MAX));
}
    // rust: impl Scoreboard {
reorder :: proc(self: ^Self) {
}
    // rust: ranked(&mut self.objectives, &self.objective_order, |o| &o.name);
    // rust: ranked(&mut self.teams, &self.team_order, |t| &t.name);
}
objective :: proc(self: ^Self, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.objectives.iter().find(|o| o.name == name)
}
objective_mut :: proc(self: ^Self, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.objectives.iter_mut().find(|o| o.name == name)
}
    // `getObjectives().stream()` (what saving uses).
objectives_streamed :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.objective_order
    // rust: .stream()
    // rust: .filter_map(|n| self.objective(n))
    // rust: .collect()
}
    // rust: pub fn add_objective(
    // rust: &mut self,
    // rust: name: &str,
    // rust: criteria: &str,
    // rust: display_name: Comp,
    // rust: render_type: RenderType,
    // rust: display_auto_update: bool,
    // rust: number_format: Option<NumberFormat>,
    // rust: ) -> bool {
    // rust: if self.objective(name).is_some() {
    // rust: return false;
}
    // rust: self.objectives.push(Objective {
    // rust: name: name.to_owned(),
    // rust: criteria: criteria.to_owned(),
    // rust: display_name,
    // rust: render_type,
    // rust: display_auto_update,
    // rust: number_format,
    // rust: });
    // rust: self.objective_order.insert(name);
    // rust: self.by_criteria
    // rust: .entry(criteria.to_owned())
    // rust: .or_default()
    // rust: .push(name.to_owned());
    // rust: self.reorder();
    // rust: true
}
    // `removeObjective`: holders left without scores stay tracked.
remove_objective :: proc(self: ^Self, name: string) {
}
    // rust: let Some(criteria) = self.objective(name).map(|o| o.criteria.clone()) else {
    // rust: return;
}
    // rust: self.objectives.retain(|o| o.name != name);
    // rust: self.objective_order.remove(name);
        // Removing shifts the keys after it back.
    // rust: self.reorder();
    // rust: self.display.retain(|_, o| o != name);
    // rust: if let Some(list) = self.by_criteria.get_mut(&criteria) {
    // rust: list.retain(|n| n != name);
}
    // rust: for s in self.scores.values_mut() {
    // rust: s.remove(name);
}
}
display_objective :: proc(self: ^Self, slot: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.objective(self.display.get(slot)?)
}
set_display_objective :: proc(self: ^Self, slot: string, objective: Maybe(string)) {
}
    // rust: match objective {
    // rust: Some(o) => {
    // rust: self.display.insert(slot.to_owned(), o.to_owned());
}
    // rust: None => {
    // rust: self.display.remove(slot);
}
}
}
score :: proc(self: ^Self, holder: string, objective: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.scores.get(holder)?.get(objective)
}
    // `getOrCreatePlayerScore`: a new score starts locked at zero.
score_mut :: proc(self: ^Self, holder: string, objective: string) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.holder_order.insert(holder);
    // rust: self.scores
    // rust: .entry(holder.to_owned())
    // rust: .or_default()
    // rust: .entry(objective.to_owned())
    // rust: .or_default()
}
get :: proc(self: ^Self, holder: string, objective: string) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.score_mut(holder, objective).value
}
    // `ScoreAccess.set`; `display` is the holder's display name, which an
    // objective that updates its display copies to the score.
set_with :: proc(self: ^Self, holder: string, objective: string, value: i32, display: Maybe(^Comp)) {
}
    // rust: let auto = self
    // rust: .objective(objective)
    // rust: .is_some_and(|o| o.display_auto_update);
    // rust: let s = self.score_mut(holder, objective);
    // rust: if auto
    // rust: && let Some(d) = display
    // rust: && s.display.as_ref().map(canonical_component) != Some(canonical_component(d))
    // rust: {
    // rust: s.display = Some(d.clone());
}
    // rust: s.value = value;
}
set :: proc(self: ^Self, holder: string, objective: string, value: i32) {
}
    // rust: self.set_with(holder, objective, value, None);
}
add :: proc(self: ^Self, holder: string, objective: string, amount: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let v = self.get(holder, objective).wrapping_add(amount);
    // rust: self.set(holder, objective, v);
    // rust: v
}
    // `forAllObjectives`: change the score of `holder` in every objective
    // using `criteria`, writable or not, in the order they were added.
for_all_objectives :: proc(self: ^Self, criteria: string, holder: string, f: impl FnMut(i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.for_all_objectives_with(criteria, holder, None, f);
}
    // `forAllObjectives` for a holder with a display name.
    // rust: pub fn for_all_objectives_with(
    // rust: &mut self,
    // rust: criteria: &str,
    // rust: holder: &str,
    // rust: display: Option<&Comp>,
    // rust: mut f: impl FnMut(i32) -> i32,
    // rust: ) {
    // rust: let names = self.by_criteria.get(criteria).cloned().unwrap_or_default();
    // rust: for n in names {
    // rust: let v = f(self.get(holder, &n));
    // rust: self.set_with(holder, &n, v, display);
}
}
has_objectives_for :: proc(self: ^Self, criteria: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.by_criteria
    // rust: .get(criteria)
    // rust: .is_some_and(|l| !l.is_empty())
}
    // `resetAllPlayerScores`.
reset_all :: proc(self: ^Self, holder: string) {
}
    // rust: if self.scores.remove(holder).is_some() {
    // rust: self.holder_order.remove(holder);
}
}
    // `resetSinglePlayerScore`: a holder left without scores is forgotten.
reset_one :: proc(self: ^Self, holder: string, objective: string) {
}
    // rust: if let Some(s) = self.scores.get_mut(holder) {
    // rust: s.remove(objective);
    // rust: if s.is_empty() {
    // rust: self.reset_all(holder);
}
}
}
    // `listPlayerScores(objective)`, in `playerScores.forEach` order.
list_scores :: proc(self: ^Self, objective: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.holder_order
    // rust: .iter()
    // rust: .filter_map(|owner| {
    // rust: let s = self.scores.get(owner)?.get(objective)?;
    // rust: Some(ScoreEntry {
    // rust: owner: owner.to_owned(),
    // rust: value: s.value,
    // rust: display: s.display.clone(),
    // rust: number_format: s.number_format.clone(),
    // rust: })
    // rust: })
    // rust: .collect()
}
    // A holder's scores as (objective, value) in objective order.
holder_scores :: proc(self: ^Self, holder: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let Some(s) = self.scores.get(holder) else {
    // rust: return Vec::new();
}
    // rust: self.objectives
    // rust: .iter()
    // rust: .filter_map(|o| Some((o, s.get(&o.name)?.value)))
    // rust: .collect()
}
    // `getTrackedPlayers` (`playerScores.keySet().stream()`).
tracked :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.holder_order.stream().map(str::to_owned).collect()
}
    // Every holder on a team (`teamsByPlayer.keySet()`).
team_members :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.team_of.keys().map(String::as_str)
}

    // teams
team :: proc(self: ^Self, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.teams.iter().find(|t| t.name == name)
}
team_mut :: proc(self: ^Self, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.teams.iter_mut().find(|t| t.name == name)
}
add_team :: proc(self: ^Self, name: string) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: if self.team(name).is_none() {
    // rust: self.teams.push(Team::new(name));
    // rust: self.team_order.insert(name);
    // rust: self.reorder();
}
    // rust: self.team_mut(name).expect("just added")
}
    // `getPlayerTeams().stream()` (what saving uses).
teams_streamed :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.team_order
    // rust: .stream()
    // rust: .filter_map(|n| self.team(n))
    // rust: .collect()
}
    // `removePlayerTeam`: its members no longer have a team.
remove_team :: proc(self: ^Self, name: string) {
}
    // rust: let Some(at) = self.teams.iter().position(|t| t.name == name) else {
    // rust: return;
}
    // rust: let team = self.teams.remove(at);
    // rust: for p in team.players.iter() {
    // rust: self.team_of.remove(p);
}
    // rust: self.team_order.remove(name);
    // rust: self.reorder();
}
players_team :: proc(self: ^Self, player: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.team(self.team_of.get(player)?)
}
    // `addPlayerToTeam`: leaves the old team first (even when it is the
    // same one); false when the team already listed the player.
add_to_team :: proc(self: ^Self, player: string, team: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.remove_from_team(player);
    // rust: self.team_of.insert(player.to_owned(), team.to_owned());
    // rust: match self.team_mut(team) {
    // rust: Some(t) => t.players.insert(player),
    // rust: None => false,
}
}
remove_from_team :: proc(self: ^Self, player: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(team) = self.team_of.remove(player) else {
    // rust: return false;
}
    // rust: if let Some(t) = self.team_mut(&team) {
    // rust: t.players.remove(player);
}
    // rust: true
}
    // `Team.isAlliedTo` for two score holder names.
allied :: proc(self: ^Self, a: string, b: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match (self.team_of.get(a), self.team_of.get(b)) {
    // rust: (Some(x), Some(y)) => x == y,
    // rust: _ => false,
}
}
    // `Scoreboard.entityRemoved` for a dead entity that is not a player.
entity_removed :: proc(self: ^Self, holder: string) {
}
    // rust: self.reset_all(holder);
    // rust: self.remove_from_team(holder);
}

    // saved data
    // `ScoreboardSaveData.Packed.CODEC` encoding of `ServerScoreboard.store`:
    // fields equal to their codec default are left out.
pack :: proc(self: ^Self) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let objectives: Vec<Tag> = self
    // rust: .objectives_streamed()
    // rust: .into_iter()
    // rust: .map(|o| {
    // rust: let mut c = vec![
    // rust: ("Name", Tag::String(o.name.as_str().into())),
    // rust: ("DisplayName", component_tag(&o.display_name)),
    // rust: ];
    // rust: if o.criteria != CRITERIA_DUMMY {
    // rust: c.push(("CriteriaName", Tag::String(o.criteria.as_str().into())));
}
    // rust: if o.render_type != RenderType::Integer {
    // rust: c.push(("RenderType", Tag::String(o.render_type.id().into())));
}
    // rust: if o.display_auto_update {
    // rust: c.push(("display_auto_update", Tag::Byte(1)));
}
    // rust: if let Some(f) = &o.number_format {
    // rust: c.push(("format", f.to_tag()));
}
    // rust: Tag::compound(c)
    // rust: })
    // rust: .collect();
    // rust: let mut scores = Vec::new();
    // rust: for owner in self.holder_order.stream() {
    // rust: let Some(per) = self.scores.get(owner) else {
    // rust: continue;
}
    // rust: for o in self.objectives_streamed() {
    // rust: let Some(s) = per.get(&o.name) else { continue };
    // rust: let mut c = vec![
    // rust: ("Name", Tag::String(owner.into())),
    // rust: ("Objective", Tag::String(o.name.as_str().into())),
    // rust: ];
    // rust: if s.value != 0 {
    // rust: c.push(("Score", Tag::Int(s.value)));
}
    // rust: if s.locked {
    // rust: c.push(("Locked", Tag::Byte(1)));
}
    // rust: if let Some(d) = &s.display {
    // rust: c.push(("display", component_tag(d)));
}
    // rust: if let Some(f) = &s.number_format {
    // rust: c.push(("format", f.to_tag()));
}
    // rust: scores.push(Tag::compound(c));
}
}
    // rust: let slots = display_slots()
    // rust: .into_iter()
    // rust: .filter_map(|slot| {
    // rust: let o = self.display.get(&slot)?;
    // rust: self.objective(o)?;
    // rust: Some((slot, Tag::String(o.as_str().into())))
    // rust: })
    // rust: .collect::<Vec<_>>();
    // rust: let slots: Vec<(&str, Tag)> = slots.iter().map(|(k, v)| (k.as_str(), v.clone())).collect();
    // rust: let teams: Vec<Tag> = self
    // rust: .teams_streamed()
    // rust: .into_iter()
    // rust: .map(|t| {
    // rust: let mut c = vec![
    // rust: ("Name", Tag::String(t.name.as_str().into())),
    // rust: ("DisplayName", component_tag(&t.display_name)),
    // rust: ];
    // rust: if let Some(color) = &t.color {
    // rust: c.push(("TeamColor", Tag::String(color.as_str().into())));
}
    // rust: if !t.allow_friendly_fire {
    // rust: c.push(("AllowFriendlyFire", Tag::Byte(0)));
}
    // rust: if !t.see_friendly_invisibles {
    // rust: c.push(("SeeFriendlyInvisibles", Tag::Byte(0)));
}
    // rust: let empty = Value::String(String::new());
    // rust: if canonical_component(&t.prefix) != empty {
    // rust: c.push(("MemberNamePrefix", component_tag(&t.prefix)));
}
    // rust: if canonical_component(&t.suffix) != empty {
    // rust: c.push(("MemberNameSuffix", component_tag(&t.suffix)));
}
    // rust: if t.nametag_visibility != Visibility::Always {
    // rust: c.push((
    // rust: "NameTagVisibility",
    // rust: Tag::String(t.nametag_visibility.name().into()),
    // rust: ));
}
    // rust: if t.death_message_visibility != Visibility::Always {
    // rust: c.push((
    // rust: "DeathMessageVisibility",
    // rust: Tag::String(t.death_message_visibility.name().into()),
    // rust: ));
}
    // rust: if t.collision_rule != CollisionRule::Always {
    // rust: c.push(("CollisionRule", Tag::String(t.collision_rule.name().into())));
}
    // rust: if !t.players.is_empty() {
    // rust: c.push((
    // rust: "Players",
    // rust: Tag::List(
    // rust: t.players
    // rust: .iter()
    // rust: .map(|p| Tag::String(p.as_str().into()))
    // rust: .collect(),
    // rust: ),
    // rust: ));
}
    // rust: Tag::compound(c)
    // rust: })
    // rust: .collect();
        // The codec leaves out empty parts.
    // rust: let mut entries: Vec<(&str, Tag)> = Vec::new();
    // rust: if !objectives.is_empty() {
    // rust: entries.push(("Objectives", Tag::List(objectives)));
}
    // rust: if !scores.is_empty() {
    // rust: entries.push(("PlayerScores", Tag::List(scores)));
}
    // rust: if !slots.is_empty() {
    // rust: entries.push(("DisplaySlots", Tag::compound(slots)));
}
    // rust: if !teams.is_empty() {
    // rust: entries.push(("Teams", Tag::List(teams)));
}
    // rust: Tag::compound(entries)
}
    // `ServerScoreboard.load` of the decoded save data.
unpack :: proc(data: ^Tag) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut sb = Scoreboard::default();
    // rust: let list = |k: &str| match data.get(k) {
    // rust: Some(Tag::List(l)) => l.clone(),
    // rust: _ => Vec::new(),
}
    // rust: for o in list("Objectives") {
    // rust: let Some(name) = string_of(o.get("Name")) else {
    // rust: continue;
}
    // rust: let criteria = string_of(o.get("CriteriaName")).unwrap_or_else(|| "dummy".into());
    // rust: sb.add_objective(
    // rust: &name,
    // rust: &criteria,
    // rust: o.get("DisplayName")
    // rust: .map_or_else(|| literal(&name), tag_to_json),
    // rust: RenderType::by_id(&string_of(o.get("RenderType")).unwrap_or_default()),
    // rust: bool_of(o.get("display_auto_update"), false),
    // rust: o.get("format").and_then(NumberFormat::from_tag),
    // rust: );
}
    // rust: for s in list("PlayerScores") {
    // rust: let (Some(owner), Some(obj)) =
    // rust: (string_of(s.get("Name")), string_of(s.get("Objective")))
    // rust: else {
    // rust: continue;
}
    // rust: if sb.objective(&obj).is_none() {
    // rust: continue;
}
    // rust: *sb.score_mut(&owner, &obj) = Score {
    // rust: value: int_of(s.get("Score")).unwrap_or(0),
    // rust: locked: bool_of(s.get("Locked"), false),
    // rust: display: s.get("display").map(tag_to_json),
    // rust: number_format: s.get("format").and_then(NumberFormat::from_tag),
}
}
    // rust: if let Some(Tag::Compound(slots)) = data.get("DisplaySlots") {
    // rust: for (k, v) in slots {
    // rust: let slot = k.to_string_lossy();
    // rust: if let Tag::String(o) = v
    // rust: && display_slot_valid(&slot)
    // rust: {
    // rust: let o = o.to_string_lossy();
    // rust: if sb.objective(&o).is_some() {
    // rust: sb.display.insert(slot, o);
}
}
}
}
    // rust: for t in list("Teams") {
    // rust: let Some(name) = string_of(t.get("Name")) else {
    // rust: continue;
}
    // rust: let team = sb.add_team(&name);
    // rust: if let Some(d) = t.get("DisplayName") {
    // rust: team.display_name = tag_to_json(d);
}
    // rust: team.color = string_of(t.get("TeamColor")).filter(|c| team_color_rgb(c).is_some());
    // rust: team.allow_friendly_fire = bool_of(t.get("AllowFriendlyFire"), true);
    // rust: team.see_friendly_invisibles = bool_of(t.get("SeeFriendlyInvisibles"), true);
    // rust: team.prefix = t
    // rust: .get("MemberNamePrefix")
    // rust: .map_or_else(|| literal(""), tag_to_json);
    // rust: team.suffix = t
    // rust: .get("MemberNameSuffix")
    // rust: .map_or_else(|| literal(""), tag_to_json);
    // rust: team.nametag_visibility = string_of(t.get("NameTagVisibility"))
    // rust: .and_then(|v| Visibility::by_name(&v))
    // rust: .unwrap_or(Visibility::Always);
    // rust: team.death_message_visibility = string_of(t.get("DeathMessageVisibility"))
    // rust: .and_then(|v| Visibility::by_name(&v))
    // rust: .unwrap_or(Visibility::Always);
    // rust: team.collision_rule = string_of(t.get("CollisionRule"))
    // rust: .and_then(|v| CollisionRule::by_name(&v))
    // rust: .unwrap_or(CollisionRule::Always);
    // rust: if let Some(Tag::List(players)) = t.get("Players") {
    // rust: for p in players {
    // rust: if let Tag::String(p) = p {
    // rust: sb.add_to_team(&p.to_string_lossy(), &name);
}
}
}
}
    // rust: sb
}
}

// A component as `ComponentSerialization.CODEC` writes it to NBT.
component_tag :: proc(c: ^Comp) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let mut tag = json_to_tag(&canonical_component(c));
    // rust: entity_uuids(&mut tag);
    // rust: tag
}
// `HoverEvent.ShowEntity` writes its UUID with `UUIDUtil.CODEC`: an int array.
entity_uuids :: proc(tag: ^Tag) {
}
    // rust: match tag {
    // rust: Tag::Compound(c) => {
    // rust: let show_entity = matches!(c.get(&"action".into()), Some(Tag::String(a)) if a.to_string_lossy() == "show_entity");
    // rust: for (k, v) in c.iter_mut() {
    // rust: if show_entity && k.to_string_lossy() == "uuid" {
    // rust: let ints = match v {
    // rust: Tag::List(l) => l
    // rust: .iter()
    // rust: .map(|t| match t {
    // rust: Tag::Int(i) => Some(*i),
    // rust: _ => None,
    // rust: })
    // rust: .collect::<Option<Vec<i32>>>(),
    // rust: Tag::String(s) => {
    // rust: crate::uuid::uuid_from_text(&s.to_string_lossy()).map(Vec::from)
}
    // rust: _ => None,
}
    // rust: if let Some(ints) = ints.filter(|i| i.len() == 4) {
    // rust: *v = Tag::IntArray(ints);
}
    // rust: } else {
    // rust: entity_uuids(v);
}
}
}
    // rust: Tag::List(l) => l.iter_mut().for_each(entity_uuids),
    // rust: _ => {}
}
}

// A style object as `Style.Serializer.MAP_CODEC` re-encodes it.
canonical_style :: proc(style: ^Value) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let (mut node, _) = decompose(style);
    // rust: node.remove("text");
    // rust: Value::Object(node)
}

// A component as vanilla decodes and re-encodes it (`ComponentSerialization`):
// a literal without style or siblings becomes a plain string, a list becomes
// its first element with the others appended as siblings, and the content
// type marker is left out.
canonical_component :: proc(c: ^Comp) -> C {
    // Ported from Horizon
    return {}
}
    // rust: let (mut node, extra) = decompose(c);
    // rust: finish(&mut node, extra)
}
// A component's own fields (content and style) and its siblings.
decompose :: proc(c: ^Comp) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: match c {
    // rust: Value::Array(list) if !list.is_empty() => {
    // rust: let (mut node, mut extra) = decompose(&list[0]);
    // rust: extra.extend(list[1..].iter().map(canonical_component));
    // rust: node.remove("extra");
    // rust: (node, extra)
}
    // rust: Value::Object(o) => {
    // rust: let mut node = serde_json::Map::new();
    // rust: let mut extra = Vec::new();
    // rust: for (k, v) in o {
    // rust: match k.as_str() {
    // rust: "type" => {}
    // rust: "extra" => {
    // rust: if let Value::Array(list) = v {
    // rust: extra.extend(list.iter().map(canonical_component));
}
}
    // rust: "bold" | "italic" | "underlined" | "strikethrough" | "obfuscated" => {
    // rust: let b = match v {
    // rust: Value::Bool(b) => *b,
    // rust: Value::Number(n) => n.as_f64().is_some_and(|f| f as i8 != 0),
    // rust: _ => continue,
}
    // rust: node.insert(k.clone(), Value::Bool(b));
}
    // rust: "color" => {
    // rust: let color = v.as_str().map(|s| match s.strip_prefix('#') {
    // rust: Some(_) => match component::hex_color(s) {
    // rust: Some(rgb) => format!("#{rgb:06X}"),
    // rust: None => s.to_owned(),
    // rust: },
    // rust: None => s.to_owned(),
    // rust: });
    // rust: if let Some(color) = color {
    // rust: node.insert(k.clone(), Value::String(color));
}
}
    // rust: "with" => {
    // rust: if let Value::Array(args) = v {
    // rust: let args = args
    // rust: .iter()
    // rust: .map(|a| match a {
    // rust: Value::Object(_) | Value::Array(_) => canonical_component(a),
    // rust: other => other.clone(),
    // rust: })
    // rust: .collect();
    // rust: node.insert(k.clone(), Value::Array(args));
}
}
    // rust: "separator" => {
    // rust: node.insert(k.clone(), canonical_component(v));
}
    // rust: "hover_event" => {
    // rust: let mut h = v.clone();
    // rust: if let Some(value) = h.get("value").cloned()
    // rust: && h.get("action").and_then(Value::as_str) == Some("show_text")
    // rust: {
    // rust: h["value"] = canonical_component(&value);
}
    // rust: node.insert(k.clone(), h);
}
    // rust: _ => {
    // rust: node.insert(k.clone(), v.clone());
}
}
}
    // rust: (node, extra)
}
    // rust: Value::String(s) => {
    // rust: let mut node = serde_json::Map::new();
    // rust: node.insert("text".into(), Value::String(s.clone()));
    // rust: (node, Vec::new())
}
    // rust: other => {
    // rust: let mut node = serde_json::Map::new();
    // rust: node.insert("text".into(), Value::String(other.to_string()));
    // rust: (node, Vec::new())
}
}
}
finish :: proc(node: ^serde_json::Map<string, extra: [dynamic]Comp) -> C {
    // Ported from Horizon
    return {}
}
    // rust: if extra.is_empty()
    // rust: && node.len() == 1
    // rust: && let Some(Value::String(s)) = node.get("text")
    // rust: {
    // rust: return Value::String(s.clone());
}
    // rust: if !extra.is_empty() {
    // rust: node.insert("extra".into(), Value::Array(extra));
}
    // rust: Value::Object(node.clone())
}

    // rust: mod tests {
//     use super::*;

board :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut sb = Scoreboard::default();
    // rust: sb.add_objective(
    // rust: "kills",
    // rust: "playerKillCount",
    // rust: literal("Kills"),
    // rust: RenderType::Integer,
    // rust: false,
    // rust: None,
    // rust: );
    // rust: sb.add_objective(
    // rust: "hp",
    // rust: "health",
    // rust: literal("HP"),
    // rust: RenderType::Hearts,
    // rust: true,
    // rust: Some(NumberFormat::Blank),
    // rust: );
    // rust: sb
}

criteria_names :: proc() {
}
    // rust: let reg = Registries::default();
    // rust: assert!(criteria_exists("dummy", &reg));
    // rust: assert!(criteria_exists("teamkill.red", &reg));
    // rust: assert!(criteria_exists("killedByTeam.dark_blue", &reg));
    // rust: assert!(!criteria_exists("teamkill.pink", &reg));
    // rust: assert!(criteria_exists("minecraft.mined:minecraft.stone", &reg));
    // rust: assert!(criteria_exists("minecraft.custom:minecraft.jump", &reg));
    // rust: assert!(!criteria_exists("minecraft.custom:minecraft.nope", &reg));
    // rust: assert!(!criteria_exists("minecraft.flown:minecraft.stone", &reg));
    // rust: assert!(!criteria_exists("nonsense", &reg));
    // rust: assert!(criteria_read_only("health") && !criteria_read_only("dummy"));
    // rust: assert_eq!(criteria_render_type("health"), RenderType::Hearts);
    // rust: assert_eq!(
    // rust: stat_criteria("minecraft:mined", "minecraft:stone"),
    // rust: "minecraft.mined:minecraft.stone"
    // rust: );
    // rust: let reg = Registries {
    // rust: items: vec!["minecraft:stick".into()],
    // rust: ..Registries::default()
}
    // rust: assert!(criteria_exists("minecraft.crafted:minecraft.stick", &reg));
    // rust: assert!(!criteria_exists("minecraft.crafted:minecraft.dirt", &reg));
}

scores_and_criteria_updates :: proc() {
}
    // rust: let mut sb = board();
    // rust: assert!(!sb.add_objective(
    // rust: "kills",
    // rust: "dummy",
    // rust: literal("x"),
    // rust: RenderType::Integer,
    // rust: false,
    // rust: None
    // rust: ));
        // A new score starts locked at zero.
    // rust: assert!(sb.score_mut("Steve", "kills").locked);
    // rust: sb.for_all_objectives("playerKillCount", "Steve", |v| v + 1);
    // rust: sb.for_all_objectives("playerKillCount", "Steve", |v| v + 1);
    // rust: assert_eq!(sb.get("Steve", "kills"), 2);
    // rust: assert_eq!(sb.add("Steve", "kills", 5), 7);
    // rust: assert_eq!(sb.holder_scores("Steve").len(), 1);
    // rust: sb.set("Alex", "hp", 20);
    // rust: let mut tracked = sb.tracked();
    // rust: tracked.sort();
    // rust: assert_eq!(tracked, vec!["Alex".to_owned(), "Steve".to_owned()]);
    // rust: sb.reset_one("Alex", "hp");
    // rust: assert_eq!(sb.tracked(), vec!["Steve".to_owned()]);
    // rust: sb.set_display_objective("sidebar", Some("kills"));
    // rust: sb.remove_objective("kills");
    // rust: assert!(sb.display_objective("sidebar").is_none());
        // removeObjective keeps the holder, now without scores.
    // rust: assert_eq!(sb.tracked(), vec!["Steve".to_owned()]);
    // rust: assert!(sb.holder_scores("Steve").is_empty());
}

teams_membership :: proc() {
}
    // rust: let mut sb = Scoreboard::default();
    // rust: sb.add_team("red");
    // rust: sb.add_team("blue");
    // rust: assert!(sb.add_to_team("Steve", "red"));
        // Joining the same team leaves it first, so it succeeds again.
    // rust: assert!(sb.add_to_team("Steve", "red"));
    // rust: assert!(sb.add_to_team("Alex", "red"));
    // rust: assert!(sb.allied("Steve", "Alex"));
    // rust: assert!(sb.add_to_team("Steve", "blue"));
    // rust: assert!(!sb.allied("Steve", "Alex"));
    // rust: assert_eq!(sb.team("red").map(|t| t.players.len()), Some(1));
    // rust: assert!(sb.remove_from_team("Alex"));
    // rust: assert!(!sb.remove_from_team("Alex"));
    // rust: sb.remove_team("blue");
    // rust: assert!(sb.players_team("Steve").is_none());
}

pack_round_trip :: proc() {
}
    // rust: let mut sb = board();
    // rust: sb.set("Steve", "kills", 3);
    // rust: sb.score_mut("Steve", "kills").locked = false;
    // rust: sb.score_mut("Steve", "kills").display =
    // rust: Some(serde_json::json!({"text": "S", "color": "red"}));
    // rust: sb.score_mut("Steve", "kills").number_format = Some(NumberFormat::Fixed(literal("many")));
    // rust: sb.set_display_objective("sidebar.team.red", Some("kills"));
    // rust: let t = sb.add_team("red");
    // rust: t.color = Some("red".into());
    // rust: t.prefix = literal("[R] ");
    // rust: t.allow_friendly_fire = false;
    // rust: t.nametag_visibility = Visibility::HideForOtherTeams;
    // rust: t.collision_rule = CollisionRule::PushOwnTeam;
    // rust: sb.add_to_team("Steve", "red");
    // rust: sb.objective_mut("hp").unwrap().number_format = Some(NumberFormat::Styled(
    // rust: serde_json::json!({"color": "gold", "bold": true}),
    // rust: ));
    // rust: let back = Scoreboard::unpack(&sb.pack());
    // rust: assert_eq!(back, sb);
        // And through the binary NBT format.
    // rust: let bytes = horizon_world::nbt::write_named(
    // rust: &horizon_world::nbt::NamedTag {
    // rust: name: "".into(),
    // rust: tag: sb.pack(),
    // rust: },
    // rust: Default::default(),
    // rust: )
    // rust: .unwrap();
    // rust: let (named, _) = horizon_world::nbt::read_named(&bytes, Default::default()).unwrap();
    // rust: assert_eq!(Scoreboard::unpack(&named.tag), sb);
}

number_formats :: proc() {
}
    // rust: assert_eq!(NumberFormat::Blank.format(5).plain(), "");
    // rust: assert_eq!(NumberFormat::sidebar_default().format(5).plain(), "5");
    // rust: assert_eq!(
    // rust: NumberFormat::sidebar_default().format(5).spans[0]
    // rust: .style
    // rust: .color,
    // rust: Some(text::RED)
    // rust: );
    // rust: assert_eq!(
    // rust: NumberFormat::Fixed(literal("lots")).format(5).plain(),
    // rust: "lots"
    // rust: );
    // rust: let t = NumberFormat::Styled(serde_json::json!({"color": "gold"})).to_tag();
    // rust: assert_eq!(
    // rust: NumberFormat::from_tag(&t),
    // rust: Some(NumberFormat::Styled(serde_json::json!({"color": "gold"})))
    // rust: );
}
}

// `DamageSource.getLocalizedDeathMessage`: the cause's item with a custom
// name gets the `<id>.item` message, with the item's name as a third
// argument.
    // rust: pub fn death_message_args(
    // rust: key: &str,
    // rust: victim: &Text,
    // rust: cause: &Text,
    // rust: item: Option<&Text>,
    // rust: ) -> (String, Vec<Text>) {
    // rust: match item {
    // rust: Some(item) => (
    // rust: format!("{key}.item"),
    // rust: vec![victim.clone(), cause.clone(), item.clone()],
    // rust: ),
    // rust: None => (key.to_owned(), vec![victim.clone(), cause.clone()]),
}
}

    // rust: mod death_message_tests {
//     use super::*;

the_death_message_names_the_causes_item_when_it_has_a_custom_name :: proc() {
}
    // rust: let victim = Text::literal("Steve");
    // rust: let cause = Text::literal("Zombie");
        // DamageSource.getLocalizedDeathMessage: the item variant, with the
        // item's name as the third argument.
    // rust: let (key, args) = death_message_args(
    // rust: "death.attack.arrow",
    // rust: &victim,
    // rust: &cause,
    // rust: Some(&Text::literal("My Sword")),
    // rust: );
    // rust: assert_eq!(key, "death.attack.arrow.item");
    // rust: assert_eq!(args.len(), 3);
    // rust: assert_eq!(args[0].plain(), "Steve");
    // rust: assert_eq!(args[1].plain(), "Zombie");
    // rust: assert_eq!(args[2].plain(), "My Sword");
        // Without a custom name the message keeps its two arguments.
    // rust: let (key, args) = death_message_args("death.attack.arrow", &victim, &cause, None);
    // rust: assert_eq!(key, "death.attack.arrow");
    // rust: assert_eq!(args.len(), 2);
}
}
