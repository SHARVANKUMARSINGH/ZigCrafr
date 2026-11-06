//! Transpiled from Horizon Rust crate
package horizon_client_core_bossbar

import "core:fmt"
import "core:mem"
import "core:math"

// Custom boss bars (`CustomBossEvents`): the `/bossbar` store, its saved
// form (`data/minecraft/custom_boss_events.dat`) and how a bar is shown.
// use crate::{
    // rust: scoreboard::{Comp, bracketed, comp_text, json_to_tag, literal, tag_to_json},
    // rust: text::{self, Style, Text},
}
// use horizon_world::nbt::{Compound, Tag};

COLORS :: ["pink", "blue", "red", "green", "yellow", "purple", "white"]
    // rust: pub const STYLES: [&str; 5] = [
    // rust: "progress",
    // rust: "notched_6",
    // rust: "notched_10",
    // rust: "notched_12",
    // rust: "notched_20",
    // rust: ];
// `BossBarColor.getFormatting`. Purple is dark blue in 26.3.
color_rgb :: proc(color: string) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let name = match color {
    // rust: "pink" => "red",
    // rust: "red" => "dark_red",
    // rust: "purple" => "dark_blue",
    // rust: other => other,
}
    // rust: text::named_color(name).unwrap_or(text::WHITE)
}

// A version-4 shaped id from a resource id. Saved boss events do not keep
// their UUID (`CustomBossEvents` mints a new one on load).
stable_uuid :: proc(id: string) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let mut h = 0xcbf29ce484222325u64;
    // rust: for b in id.as_bytes() {
    // rust: h ^= u64::from(*b);
    // rust: h = h.wrapping_mul(0x100000001b3);
}
    // rust: let most = (h as i64) & -61441 | 16384;
    // rust: let least = (h.rotate_left(17) as i64) & 4_611_686_018_427_387_903 | i64::MIN;
    // rust: ((most as u64 as u128) << 64) | (least as u64 as u128)
}

BossBar :: struct {
    id: string,
    // The `ServerBossEvent` UUID. Not saved.
    uuid: u128,
    name: Comp,
    color: string,
    style: string,
    value: i32,
    max: i32,
    // `ServerBossEvent.visible`. A new bar is visible; nobody sees it until
    // a player is added.
    visible: bool,
    darken: bool,
    music: bool,
    fog: bool,
    // `CustomBossEvent.players`, the UUIDs told about the bar.
    players: Vec<[i32,
}
    // rust: impl BossBar {
new :: proc(id: string, name: Comp) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: id: id.to_owned(),
    // rust: uuid: stable_uuid(id),
    // rust: name,
    // rust: color: "white".into(),
    // rust: style: "progress".into(),
    // rust: value: 0,
    // rust: max: 100,
    // rust: visible: true,
    // rust: darken: false,
    // rust: music: false,
    // rust: fog: false,
    // rust: players: Vec::new(),
}
}
    // `CustomBossEvent.getDisplayName`.
display_name :: proc(self: ^Self) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let style = Style {
    // rust: color: Some(color_rgb(&self.color)),
    // rust: hover: Some(Box::new(Text::literal(self.id.clone()))),
    // rust: ..Style::default()
}
        // ComponentUtils.wrapInSquareBrackets(name).withStyle(...): the
        // brackets take the colour too.
    // rust: bracketed(comp_text(&self.name)).with_style(&style)
}
    // The filled fraction of the bar (`BossEvent.getProgress`).
progress :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: (self.value as f32 / self.max.max(1) as f32).clamp(0.0, 1.0)
}
}

BossBars :: struct {
    bars: [dynamic]BossBar,
}
    // rust: impl BossBars {
get :: proc(self: ^Self, id: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.bars.iter().find(|b| b.id == id)
}
get_mut :: proc(self: ^Self, id: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.bars.iter_mut().find(|b| b.id == id)
}
add :: proc(self: ^Self, id: string, name: Comp) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if self.get(id).is_some() {
    // rust: return false;
}
    // rust: self.bars.push(BossBar::new(id, name));
    // rust: true
}
remove :: proc(self: ^Self, id: string) {
}
    // rust: self.bars.retain(|b| b.id != id);
}
ids :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.bars.iter().map(|b| b.id.clone()).collect()
}
    // The saved compound (`CustomBossEvent.Packed`).
pack :: proc(self: ^Self) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let mut c = Compound::new();
    // rust: for b in &self.bars {
    // rust: let players = b
    // rust: .players
    // rust: .iter()
    // rust: .map(|u| Tag::IntArray(u.to_vec()))
    // rust: .collect();
    // rust: c.insert(
    // rust: b.id.as_str().into(),
    // rust: Tag::compound([
    // rust: ("Name", json_to_tag(&b.name)),
    // rust: ("Visible", Tag::Byte(i8::from(b.visible))),
    // rust: ("Value", Tag::Int(b.value)),
    // rust: ("Max", Tag::Int(b.max)),
    // rust: ("Color", Tag::String(b.color.as_str().into())),
    // rust: ("Overlay", Tag::String(b.style.as_str().into())),
    // rust: ("DarkenScreen", Tag::Byte(i8::from(b.darken))),
    // rust: ("PlayBossMusic", Tag::Byte(i8::from(b.music))),
    // rust: ("CreateWorldFog", Tag::Byte(i8::from(b.fog))),
    // rust: ("Players", Tag::List(players)),
    // rust: ]),
    // rust: );
}
    // rust: Tag::Compound(c)
}
unpack :: proc(data: ^Tag) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut bars = Vec::new();
    // rust: if let Tag::Compound(c) = data {
    // rust: for (id, e) in c {
    // rust: let get = |k: &str| e.get(k);
    // rust: let text = |k: &str, d: &str| match get(k) {
    // rust: Some(Tag::String(s)) => s.to_string_lossy(),
    // rust: _ => d.to_owned(),
}
    // rust: let num = |k: &str, d: i32| match get(k) {
    // rust: Some(Tag::Int(v)) => *v,
    // rust: Some(Tag::Short(v)) => i32::from(*v),
    // rust: Some(Tag::Byte(v)) => i32::from(*v),
    // rust: _ => d,
}
    // rust: let players = match get("Players") {
    // rust: Some(Tag::List(l)) => l
    // rust: .iter()
    // rust: .filter_map(|t| match t {
    // rust: Tag::IntArray(a) if a.len() == 4 => Some([a[0], a[1], a[2], a[3]]),
    // rust: _ => None,
    // rust: })
    // rust: .collect(),
    // rust: _ => Vec::new(),
}
    // rust: let id = id.to_string_lossy();
    // rust: bars.push(BossBar {
    // rust: uuid: stable_uuid(&id),
    // rust: id,
    // rust: name: get("Name").map_or_else(|| literal(""), tag_to_json),
    // rust: color: text("Color", "white"),
    // rust: style: text("Overlay", "progress"),
    // rust: value: num("Value", 0),
    // rust: max: num("Max", 100),
    // rust: visible: num("Visible", 0) != 0,
    // rust: darken: num("DarkenScreen", 0) != 0,
    // rust: music: num("PlayBossMusic", 0) != 0,
    // rust: fog: num("CreateWorldFog", 0) != 0,
    // rust: players,
    // rust: });
}
}
    // rust: Self { bars }
}
}

    // rust: mod tests {
//     use super::*;

bars_round_trip_and_show :: proc() {
}
    // rust: let mut b = BossBars::default();
    // rust: assert!(b.add("test:x", literal("Hello")));
    // rust: assert!(!b.add("test:x", literal("Again")));
    // rust: let bar = b.get_mut("test:x").unwrap();
    // rust: bar.color = "pink".into();
    // rust: bar.style = "notched_10".into();
    // rust: bar.value = 25;
    // rust: bar.max = 50;
    // rust: bar.visible = true;
    // rust: bar.darken = true;
    // rust: bar.players = vec![[1, 2, 3, 4]];
    // rust: let back = BossBars::unpack(&b.pack());
    // rust: assert_eq!(back, b);
    // rust: let bar = b.get("test:x").unwrap();
    // rust: assert_eq!(bar.progress(), 0.5);
    // rust: assert_eq!(bar.display_name().plain(), "chat.square_brackets");
    // rust: assert_eq!(color_rgb("pink"), text::RED);
    // rust: assert_eq!(color_rgb("purple"), text::named_color("dark_blue").unwrap());
    // rust: b.remove("test:x");
    // rust: assert!(b.bars.is_empty());
}
}
