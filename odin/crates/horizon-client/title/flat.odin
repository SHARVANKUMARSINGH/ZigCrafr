//! Transpiled from Horizon Rust crate
package horizon_client_flat

import "core:fmt"
import "core:mem"
import "core:math"

// CreateFlatWorldScreen and PresetFlatWorldScreen: the Superflat layer list,
// the preset chooser and the settings they hand back to Create New World.
// use super::{Button, Title};
// use crate::{
    // rust: hud::{HudAtlas, HudBatch, rgba},
    // rust: item_render::{self, ItemRenderState, ItemRenderer, NoHost},
    // rust: items::ItemStack,
    // rust: lang,
    // rust: text::{Text, format_translation},
    // rust: ui,
}
// use horizon_assets::item_model::{DisplayContext, ItemEnv};
// use horizon_world::nbt::Tag;
// use serde_json::Value;
// use std::{collections::BTreeSet, path::Path};

// DimensionType.Y_SIZE: the most blocks a flat generator takes.
Y_SIZE :: 4064
// The list's row width (ObjectSelectionList.getRowWidth).
ROW_WIDTH :: 220.0
// The header row above the layers.
HEADER :: 14.0
// A layer or preset row.
LAYER_ROW :: 20.0
PRESET_ROW :: 24.0

FlatLayer :: struct {
    // A block id such as `minecraft:dirt`.
    block: string,
    // How many blocks tall this layer is (0..=4064).
    height: i32,
}

// FlatLevelGeneratorSettings: the layers (bottom to top), the biome and the
// decorations CreateFlatWorldScreen edits.
FlatSettings :: struct {
    biome: string,
    features: bool,
    lakes: bool,
    layers: [dynamic]FlatLayer,
    structure_overrides: [dynamic]string,
}
    // rust: impl Default for FlatSettings {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
        // worldgen/world_preset/flat.json's overworld.
    // rust: Self {
    // rust: biome: "minecraft:plains".into(),
    // rust: features: false,
    // rust: lakes: false,
    // rust: layers: vec![
    // rust: FlatLayer {
    // rust: block: "minecraft:bedrock".into(),
    // rust: height: 1,
    // rust: },
    // rust: FlatLayer {
    // rust: block: "minecraft:dirt".into(),
    // rust: height: 2,
    // rust: },
    // rust: FlatLayer {
    // rust: block: "minecraft:grass_block".into(),
    // rust: height: 1,
    // rust: },
    // rust: ],
    // rust: structure_overrides: vec!["minecraft:strongholds".into(), "minecraft:villages".into()],
}
}
}
    // rust: impl FlatSettings {
    // A saved world's flat generator settings, for Re-Create.
from_world :: proc(dir: ^Path) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let settings = crate::save::world_gen_settings(dir)?;
    // rust: let generator = settings
    // rust: .get("dimensions")?
    // rust: .get("minecraft:overworld")?
    // rust: .get("generator")?;
    // rust: if crate::save::text(generator.get("type"))?.trim_start_matches("minecraft:") != "flat" {
    // rust: return None;
}
    // rust: Self::from_tag(generator.get("settings")?)
}
from_tag :: proc(tag: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let Some(Tag::List(list)) = tag.get("layers") else {
    // rust: return None;
}
    // rust: let layers: Vec<FlatLayer> = list
    // rust: .iter()
    // rust: .filter_map(|layer| {
    // rust: Some(FlatLayer {
    // rust: block: crate::save::text(layer.get("block"))?,
    // rust: height: crate::save::number(layer.get("height"))?.clamp(0, Y_SIZE as i64)
    // rust: as i32,
    // rust: })
    // rust: })
    // rust: .collect();
        // `layers: []` is a valid void flat world; a list whose entries all
        // fail to parse is not.
    // rust: if layers.is_empty() && !list.is_empty() {
    // rust: return None;
}
    // rust: let flag = |key: &str, default: bool| {
    // rust: crate::save::number(tag.get(key)).map_or(default, |value| value != 0)
}
    // rust: let structure_overrides = match tag.get("structure_overrides") {
    // rust: Some(Tag::String(text)) => vec![text.to_string_lossy()],
    // rust: Some(Tag::List(list)) => list
    // rust: .iter()
    // rust: .filter_map(|value| crate::save::text(Some(value)))
    // rust: .collect(),
    // rust: _ => Vec::new(),
}
    // rust: Some(Self {
    // rust: biome: crate::save::text(tag.get("biome")).unwrap_or_else(|| "minecraft:plains".into()),
    // rust: features: flag("features", false),
    // rust: lakes: flag("lakes", false),
    // rust: layers,
    // rust: structure_overrides,
    // rust: })
}
    // FlatLevelGeneratorSettings.CODEC, as world_gen_settings stores it.
to_tag :: proc(self: ^Self) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let string = |text: &str| Tag::String(text.into());
    // rust: Tag::compound([
    // rust: ("biome", string(&self.biome)),
    // rust: ("features", Tag::Byte(i8::from(self.features))),
    // rust: ("lakes", Tag::Byte(i8::from(self.lakes))),
    // rust: (
    // rust: "layers",
    // rust: Tag::List(
    // rust: self.layers
    // rust: .iter()
    // rust: .map(|layer| {
    // rust: Tag::compound([
    // rust: ("block", string(&layer.block)),
    // rust: ("height", Tag::Int(layer.height)),
    // rust: ])
    // rust: })
    // rust: .collect(),
    // rust: ),
    // rust: ),
    // rust: (
    // rust: "structure_overrides",
    // rust: Tag::List(
    // rust: self.structure_overrides
    // rust: .iter()
    // rust: .map(|id| string(id))
    // rust: .collect(),
    // rust: ),
    // rust: ),
    // rust: ])
}
    // `CreateFlatWorldScreen.save`: the text the preset screen shows.
to_share :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let layers = self
    // rust: .layers
    // rust: .iter()
    // rust: .map(|layer| {
    // rust: if layer.height == 1 {
    // rust: layer.block.clone()
    // rust: } else {
    // rust: format!("{}*{}", layer.height, layer.block)
}
    // rust: })
    // rust: .collect::<Vec<_>>()
    // rust: .join(",");
    // rust: format!("{layers};{}", self.biome)
}
    // `PresetFlatWorldScreen.fromString`: `layers;biome`, keeping the
    // decorations the screen was opened with. `None` for a malformed list,
    // as vanilla falls back to the preset's own settings.
    // rust: pub fn parse(
    // rust: text: &str,
    // rust: blocks: &BTreeSet<String>,
    // rust: biomes: &BTreeSet<String>,
    // rust: base: &Self,
    // rust: ) -> Option<Self> {
    // rust: let (layer_text, biome_text) = text.split_once(';').unwrap_or((text, ""));
    // rust: let mut layers = Vec::new();
    // rust: let mut total = 0;
    // rust: for part in layer_text.split(',') {
    // rust: let part = part.trim();
    // rust: if part.is_empty() {
    // rust: continue;
}
    // rust: let (height, block) = match part.split_once('*') {
    // rust: Some((height, block)) => (height.trim().parse::<i32>().ok()?, block.trim()),
    // rust: None => (1, part),
}
    // rust: let block = namespaced(block);
    // rust: if !blocks.is_empty() && !blocks.contains(&block) {
    // rust: return None;
}
    // rust: let height = height.max(0).min(Y_SIZE - total);
    // rust: if height == 0 {
    // rust: continue;
}
    // rust: total += height;
    // rust: layers.push(FlatLayer { block, height });
}
    // rust: if layers.is_empty() {
    // rust: return None;
}
    // rust: let mut biome = namespaced(biome_text.trim());
    // rust: if biome == "minecraft:" || biome.is_empty() {
    // rust: biome = "minecraft:plains".into();
}
    // rust: if !biomes.is_empty() && !biomes.contains(&biome) {
    // rust: biome = "minecraft:plains".into();
}
    // rust: Some(Self {
    // rust: biome,
    // rust: layers,
    // rust: ..base.clone()
    // rust: })
}
}
// `Identifier.parse`: bare names get the default namespace.
namespaced :: proc(id: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: if id.is_empty() || id.contains(':') {
    // rust: id.to_owned()
    // rust: } else {
    // rust: format!("minecraft:{id}")
}
}

    // rust: pub(super) enum Page {
    // rust: Layers,
    // rust: Presets,
}

State :: struct {
    // rust: pub(super) page: Page,
    // rust: pub(super) settings: FlatSettings,
    // The preset screen's share box (`createWorld.customize.presets.share`).
    // rust: pub(super) share: String,
    // rust: pub(super) share_focused: bool,
    // The selected layer, in the list's top-first order.
    // rust: pub(super) selected: Option<usize>,
    // rust: pub(super) scroll: ui::Scroll,
    preset_selected: Maybe(uint),
    // The preset last pressed (`PresetsList.Entry.select`): the focus only selects a row.
    preset_pressed: Maybe(uint),
    preset_scroll: ui::Scroll,
    presets: [dynamic]Preset,
    blocks: BTreeSet<string>,
    biomes: BTreeSet<string>,
}
Preset :: struct {
    id: string,
    display: string,
    settings: FlatSettings,
}
    // rust: impl State {
    // The layers the editor holds, for the control socket's state.
settings :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.settings
}
    // rust: pub(super) fn new(root: &Path, current: Option<FlatSettings>) -> Self {
    // rust: let settings = current.unwrap_or_default();
    // rust: let (presets, blocks, biomes) = load(root);
    // rust: Self {
    // rust: page: Page::Layers,
    // rust: share: settings.to_share(),
    // rust: settings,
    // rust: share_focused: false,
    // rust: selected: None,
    // rust: scroll: ui::Scroll::default(),
    // rust: preset_selected: None,
    // rust: preset_pressed: None,
    // rust: preset_scroll: ui::Scroll::default(),
    // rust: presets,
    // rust: blocks,
    // rust: biomes,
}
}
    // rust: pub(super) fn open_presets(&mut self) {
    // rust: self.page = Page::Presets;
    // rust: self.preset_selected = None;
    // rust: self.preset_pressed = None;
    // rust: self.preset_scroll = ui::Scroll::default();
    // rust: self.share = self.settings.to_share();
    // rust: self.share_focused = false;
}
    // rust: pub(super) fn back_to_layers(&mut self) {
    // rust: self.page = Page::Layers;
    // rust: self.share_focused = false;
}
    // rust: pub(super) fn remove_selected(&mut self) {
    // rust: let Some(row) = self.selected else {
    // rust: return;
}
    // rust: let index = self.settings.layers.len().wrapping_sub(1 + row);
    // rust: if index < self.settings.layers.len() {
    // rust: self.settings.layers.remove(index);
}
    // rust: self.selected = selection_after_removal(row, self.settings.layers.len());
}
    // PresetFlatWorldScreen's Select: parse the share text into the settings
    // the Create New World screen keeps.
    // rust: pub(super) fn apply_share(&mut self) {
        // PresetFlatWorldScreen keeps the selected preset's decorations while
        // the share text supplies its layers and biome.
    // rust: let base = self
    // rust: .preset_pressed
    // rust: .and_then(|index| self.presets.get(index))
    // rust: .map(|preset| preset.settings.clone())
    // rust: .unwrap_or_else(|| self.settings.clone());
        // A malformed list falls back to FlatLevelGeneratorSettings.getDefault.
    // rust: let settings =
    // rust: FlatSettings::parse(&self.share, &self.blocks, &self.biomes, &base).unwrap_or_default();
    // rust: self.settings = settings;
    // rust: self.share = self.settings.to_share();
    // rust: self.page = Page::Layers;
    // rust: self.share_focused = false;
    // rust: self.selected = None;
}
select_preset :: proc(self: ^Self, index: uint) {
}
    // rust: let Some(preset) = self.presets.get(index) else {
    // rust: return;
}
    // rust: self.preset_selected = Some(index);
    // rust: self.preset_pressed = Some(index);
    // rust: self.share = preset.settings.to_share();
    // rust: self.share_focused = false;
}
selecting :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.preset_selected
}
}

// `<root>/data/<namespace>/worldgen/flat_level_generator_preset/<path>.json`,
// in the order of the `visible` tag, plus the block and biome ids the share
// text is checked against.
load :: proc(root: ^Path) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let mut presets = Vec::new();
    // rust: let tag_path =
    // rust: root.join("data/minecraft/tags/worldgen/flat_level_generator_preset/visible.json");
    // rust: if let Ok(text) = std::fs::read_to_string(tag_path)
    // rust: && let Ok(Value::Object(tag)) = serde_json::from_str(&text)
    // rust: && let Some(Value::Array(ids)) = tag.get("values")
    // rust: {
    // rust: for id in ids.iter().filter_map(Value::as_str) {
    // rust: let Some((namespace, path)) = id.split_once(':') else {
    // rust: continue;
}
    // rust: let path = root.join(format!(
    // rust: "data/{namespace}/worldgen/flat_level_generator_preset/{path}.json"
    // rust: ));
    // rust: let Ok(text) = std::fs::read_to_string(path) else {
    // rust: continue;
}
    // rust: let Ok(value) = serde_json::from_str::<Value>(&text) else {
    // rust: continue;
}
    // rust: let Some(settings) = preset_settings(&value) else {
    // rust: continue;
}
    // rust: presets.push(Preset {
    // rust: id: id.to_owned(),
    // rust: display: value["display"]
    // rust: .as_str()
    // rust: .unwrap_or("minecraft:grass_block")
    // rust: .to_owned(),
    // rust: settings,
    // rust: });
}
}
    // rust: let blocks = registry_ids(root, "minecraft:block");
    // rust: let biomes = json_keys(&root.join("worldgen/biomes.json"));
    // rust: (presets, blocks, biomes)
}
preset_settings :: proc(value: ^Value) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let settings = value.get("settings")?;
    // rust: let layers = settings
    // rust: .get("layers")?
    // rust: .as_array()?
    // rust: .iter()
    // rust: .filter_map(|layer| {
    // rust: Some(FlatLayer {
    // rust: block: layer.get("block")?.as_str()?.to_owned(),
    // rust: height: layer.get("height")?.as_i64()? as i32,
    // rust: })
    // rust: })
    // rust: .collect::<Vec<_>>();
    // rust: if layers.is_empty() {
    // rust: return None;
}
    // rust: let structure_overrides = match settings.get("structure_overrides") {
    // rust: Some(Value::String(id)) => vec![id.clone()],
    // rust: Some(Value::Array(ids)) => ids
    // rust: .iter()
    // rust: .filter_map(Value::as_str)
    // rust: .map(str::to_owned)
    // rust: .collect(),
    // rust: _ => Vec::new(),
}
    // rust: Some(FlatSettings {
    // rust: biome: settings
    // rust: .get("biome")
    // rust: .and_then(Value::as_str)
    // rust: .unwrap_or("minecraft:plains")
    // rust: .to_owned(),
    // rust: features: settings
    // rust: .get("features")
    // rust: .and_then(Value::as_bool)
    // rust: .unwrap_or(false),
    // rust: lakes: settings
    // rust: .get("lakes")
    // rust: .and_then(Value::as_bool)
    // rust: .unwrap_or(false),
    // rust: layers,
    // rust: structure_overrides,
    // rust: })
}
// The ids of a registry in the prepared `registries.json`.
registry_ids :: proc(root: ^Path, registry: string) -> B {
    // Ported from Horizon
    return {}
}
    // rust: let Ok(text) = std::fs::read_to_string(root.join("registries.json")) else {
    // rust: return BTreeSet::new();
}
    // rust: let Ok(value) = serde_json::from_str::<Value>(&text) else {
    // rust: return BTreeSet::new();
}
    // rust: value
    // rust: .get(registry)
    // rust: .and_then(|registry| registry.get("entries"))
    // rust: .and_then(Value::as_object)
    // rust: .map(|entries| entries.keys().cloned().collect())
    // rust: .unwrap_or_default()
}
json_keys :: proc(path: ^Path) -> B {
    // Ported from Horizon
    return {}
}
    // rust: let Ok(text) = std::fs::read_to_string(path) else {
    // rust: return BTreeSet::new();
}
    // rust: let Ok(value) = serde_json::from_str::<Value>(&text) else {
    // rust: return BTreeSet::new();
}
    // rust: value
    // rust: .as_object()
    // rust: .map(|entries| entries.keys().cloned().collect())
    // rust: .unwrap_or_default()
}

// CreateFlatWorldScreen's list and the preset screen's list.
list_area :: proc(state: ^State, size: (f32) {
}
    // rust: let (w, h) = (size.0.ceil(), size.1.ceil());
    // rust: let (top, bottom) = match state.page {
    // rust: Page::Layers => (43.0, h - 60.0),
    // rust: Page::Presets => (80.0, h - 37.0),
}
    // rust: let left = ((w - ROW_WIDTH) * 0.5).floor();
    // rust: let rows = match state.page {
    // rust: Page::Layers => HEADER + state.settings.layers.len() as f32 * LAYER_ROW + 4.0,
    // rust: Page::Presets => state.presets.len() as f32 * PRESET_ROW + 4.0,
}
    // rust: (top, bottom, left, rows)
}

    // rust: pub(super) fn buttons(w: f32, h: f32, state: &State) -> Vec<Button> {
    // rust: let b = |x: f32, y: f32, w: f32, key: &str, fallback: &str, enabled: bool, id: u8| Button {
    // rust: x,
    // rust: y,
    // rust: w,
    // rust: label: lang::get_or(key, fallback),
    // rust: enabled,
    // rust: id,
    // rust: icon: None,
    // rust: trailing: None,
    // rust: action: None,
}
    // rust: match state.page {
    // rust: Page::Layers => {
    // rust: let x = ((w - 308.0) * 0.5).trunc();
    // rust: vec![
    // rust: b(
    // rust: x,
    // rust: h - 52.0,
    // rust: 150.0,
    // rust: "createWorld.customize.flat.removeLayer",
    // rust: "Remove Layer",
    // rust: state.selected.is_some(),
    // rust: 70,
    // rust: ),
    // rust: b(
    // rust: x + 158.0,
    // rust: h - 52.0,
    // rust: 150.0,
    // rust: "createWorld.customize.presets",
    // rust: "Presets",
    // rust: true,
    // rust: 71,
    // rust: ),
    // rust: b(x, h - 28.0, 150.0, "gui.done", "Done", true, 72)
    // rust: .does(crate::widgets::Action::Done),
    // rust: b(x + 158.0, h - 28.0, 150.0, "gui.cancel", "Cancel", true, 73)
    // rust: .does(crate::widgets::Action::Cancel),
    // rust: ]
}
    // rust: Page::Presets => vec![
    // rust: b(
    // rust: w / 2.0 - 155.0,
    // rust: h - 28.0,
    // rust: 150.0,
    // rust: "createWorld.customize.presets.select",
    // rust: "Select",
    // rust: state.selecting().is_some() || state.share.len() > 1,
    // rust: 74,
    // rust: ),
    // rust: b(
    // rust: w / 2.0 + 5.0,
    // rust: h - 28.0,
    // rust: 150.0,
    // rust: "gui.cancel",
    // rust: "Cancel",
    // rust: true,
    // rust: 75,
    // rust: )
    // rust: .does(crate::widgets::Action::Cancel),
    // rust: ],
}
}

// The layer under the pointer (top-first), and whether the pointer is on the
// list at all.
layer_row :: proc(state: ^State, cursor: (f32) {
}
    // rust: let (top, bottom, _, _) = list_area(state, size);
    // rust: if cursor.1 < top || cursor.1 >= bottom {
    // rust: return None;
}
    // rust: let y = cursor.1 - top - 2.0 + state.scroll.amount;
    // rust: if y < HEADER {
    // rust: return None;
}
    // rust: let row = ((y - HEADER) / LAYER_ROW).floor() as usize;
    // rust: (row < state.settings.layers.len()).then_some(row)
}
preset_row :: proc(state: ^State, cursor: (f32) {
}
    // rust: let (top, bottom, _, _) = list_area(state, size);
    // rust: if cursor.1 < top || cursor.1 >= bottom {
    // rust: return None;
}
    // rust: let row = ((cursor.1 - top - 2.0 + state.preset_scroll.amount) / PRESET_ROW).floor() as usize;
    // rust: (row < state.presets.len()).then_some(row)
}

// A press on the list, the share box or its scrollbar.
    // rust: pub(super) fn click(state: &mut State, cursor: (f32, f32), size: (f32, f32)) {
    // rust: let (top, bottom, left, content) = list_area(state, size);
    // rust: let bar = left + ROW_WIDTH + 6.0;
    // rust: match state.page {
    // rust: Page::Layers => {
    // rust: if state.scroll.press(cursor, bar, top, bottom, content) {
    // rust: return;
}
    // rust: state.selected = layer_row(state, cursor, size);
}
    // rust: Page::Presets => {
    // rust: let field = share_field(size);
    // rust: state.share_focused = ui::hovered(cursor, field[0], field[1], field[2], field[3]);
    // rust: if state.preset_scroll.press(cursor, bar, top, bottom, content) {
    // rust: return;
}
    // rust: if let Some(row) = preset_row(state, cursor, size) {
    // rust: state.select_preset(row);
}
}
}
}
// The focus landed on the row at `cursor`: it is selected (`AbstractSelectionList.setFocused`),
// and the share box keeps its text until the row is pressed. Whether a row was there.
    // rust: pub(super) fn focus_row(state: &mut State, cursor: (f32, f32), size: (f32, f32)) -> bool {
    // rust: match state.page {
    // rust: Page::Layers => {
    // rust: let row = layer_row(state, cursor, size);
    // rust: if row.is_some() {
    // rust: state.selected = row;
}
    // rust: row.is_some()
}
    // rust: Page::Presets => {
    // rust: let row = preset_row(state, cursor, size);
    // rust: if row.is_some() {
    // rust: state.preset_selected = row;
    // rust: state.share_focused = false;
}
    // rust: row.is_some()
}
}
}
share_field :: proc(size: (f32) {
}
    // rust: [50.0, 40.0, (size.0.ceil() - 100.0).max(1.0), 20.0]
}

// A list row the controller can focus and the control socket names, while its
// middle is in the list's view.
    // rust: pub(super) fn row_target(name: &str, rect: [f32; 4], top: f32, bottom: f32) {
    // rust: let mid = rect[1] + rect[3] / 2.0;
    // rust: if mid > top && mid < bottom {
    // rust: crate::widgets::record_as(name, rect, true, crate::widgets::Kind::Row);
    // rust: crate::widgets::target_as(rect, crate::widgets::Kind::Row);
}
}
    // rust: pub(super) fn wheel(state: &mut State, delta: f32, cursor: (f32, f32), size: (f32, f32)) {
    // rust: let (top, bottom, _, content) = list_area(state, size);
    // rust: if cursor.1 < top || cursor.1 >= bottom {
    // rust: return;
}
    // rust: match state.page {
    // rust: Page::Layers => state.scroll.wheel(delta, LAYER_ROW, top, bottom, content),
    // rust: Page::Presets => state
    // rust: .preset_scroll
    // rust: .wheel(delta, PRESET_ROW, top, bottom, content),
}
}
    // rust: pub(super) fn drag(state: &mut State, cursor: (f32, f32), size: (f32, f32)) {
    // rust: let (top, bottom, _, content) = list_area(state, size);
    // rust: match state.page {
    // rust: Page::Layers => state.scroll.drag(cursor.1, top, bottom, content),
    // rust: Page::Presets => state.preset_scroll.drag(cursor.1, top, bottom, content),
}
}
    // rust: pub(super) fn release(state: &mut State) {
    // rust: state.scroll.release();
    // rust: state.preset_scroll.release();
}

    // rust: pub(super) fn draw(
    // rust: title: &Title,
    // rust: atlas: &HudAtlas,
    // rust: items: Option<&ItemRenderer>,
    // rust: batch: &mut HudBatch,
    // rust: cursor: (f32, f32),
    // rust: state: &State,
    // rust: ) {
    // rust: let (w, h) = (batch.width.ceil(), batch.height.ceil());
    // rust: ui::menu_background(batch, atlas, 0.0, 0.0, w, h, false);
    // rust: match state.page {
    // rust: Page::Layers => draw_layers(title, atlas, items, batch, cursor, state, (w, h)),
    // rust: Page::Presets => draw_presets(title, atlas, items, batch, cursor, state, (w, h)),
}
}

    // rust: fn draw_layers(
    // rust: _title: &Title,
    // rust: atlas: &HudAtlas,
    // rust: items: Option<&ItemRenderer>,
    // rust: batch: &mut HudBatch,
    // rust: cursor: (f32, f32),
    // rust: state: &State,
    // rust: (w, h): (f32, f32),
    // rust: ) {
    // rust: super::centered(
    // rust: atlas,
    // rust: batch,
    // rust: &lang::get_or(
    // rust: "createWorld.customize.flat.title",
    // rust: "Superflat Customization",
    // rust: ),
    // rust: 8.0,
    // rust: u32::MAX,
    // rust: );
    // rust: let (top, bottom, left, content) = list_area(state, (w, h));
    // rust: ui::list_background(batch, atlas, top, bottom, false);
    // rust: crate::ui::separators(batch, atlas, top, bottom, false);
    // rust: let first = batch.vertices.len();
    // rust: let mut pending = Vec::new();
    // rust: let right = left + ROW_WIDTH;
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: &Text::translate("createWorld.customize.flat.tile", &[]).underlined(),
    // rust: left + 2.0,
    // rust: top + 3.0,
    // rust: u32::MAX,
    // rust: true,
    // rust: );
    // rust: let height_header = Text::translate("createWorld.customize.flat.height", &[]).underlined();
    // rust: let hw = HudBatch::text_width(atlas, &height_header.plain());
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: &height_header,
    // rust: right - hw - 2.0,
    // rust: top + 3.0,
    // rust: u32::MAX,
    // rust: true,
    // rust: );
    // rust: let offset = state.scroll.amount.trunc();
    // rust: let selected = state.selected;
    // DetailsList: its header row ("Layer Material. Height"), then the layers
    // top first, each "Selected: <item>. Height. <height>".
    // rust: crate::widgets::narratable(|| {
//         use crate::widgets::{ListKind, Narratable, Row, join_for_narration as join};
    // rust: let tr = |key: &str| Text::translate(key, &[]).plain();
    // rust: let height = tr("createWorld.customize.flat.height");
    // rust: let row = |i: usize| {
    // rust: let narration = match i.checked_sub(1) {
    // rust: None => join(&[&tr("createWorld.customize.flat.tile"), &height]),
    // rust: Some(layer) => {
    // rust: let layer = &state.settings.layers[state.settings.layers.len() - 1 - layer];
    // rust: let item = Text::translate(
    // rust: "narrator.select",
    // rust: &[Text::literal(item_name(&layer.block))],
    // rust: )
    // rust: .plain();
    // rust: join(&[&item, &height, &layer.height.to_string()])
}
}
    // rust: Row::new(i, narration)
}
    // rust: let over_header = cursor.1 >= top
    // rust: && cursor.1 < bottom
    // rust: && cursor.1 - top - 2.0 + state.scroll.amount < HEADER;
    // rust: let hovered = if over_header {
    // rust: Some(0)
    // rust: } else {
    // rust: layer_row(state, cursor, (w, h)).map(|r| r + 1)
}
    // rust: Narratable::list(
    // rust: ListKind::Object,
    // rust: state.settings.layers.len() + 1,
    // rust: hovered.map(row),
    // rust: selected.map(|r| row(r + 1)),
    // rust: [0.0, top, w, bottom - top],
    // rust: )
    // rust: .key(crate::widgets::key_of(&"create_world/flat/layers"))
    // rust: });
    // rust: for (row, layer) in state.settings.layers.iter().rev().enumerate() {
    // rust: let y = top + 2.0 + HEADER + row as f32 * LAYER_ROW - offset;
    // rust: let target = [left - 2.0, y - 1.0, ROW_WIDTH + 4.0, LAYER_ROW];
    // rust: row_target(&item_name(&layer.block), target, top, bottom);
    // rust: let hovered = ui::hovered(cursor, target[0], target[1], target[2], target[3]);
    // rust: if selected == Some(row) {
    // rust: batch.fill(
    // rust: atlas,
    // rust: target[0],
    // rust: target[1],
    // rust: target[2],
    // rust: target[3],
    // rust: rgba(255, 255, 255, 70),
    // rust: );
    // rust: } else if hovered {
    // rust: batch.fill(
    // rust: atlas,
    // rust: target[0],
    // rust: target[1],
    // rust: target[2],
    // rust: target[3],
    // rust: rgba(255, 255, 255, 25),
    // rust: );
}
    // rust: slot(
    // rust: atlas,
    // rust: items,
    // rust: &mut pending,
    // rust: batch,
    // rust: &layer.block,
    // rust: left + 2.0,
    // rust: y + 1.0,
    // rust: );
    // rust: batch.text(
    // rust: atlas,
    // rust: &item_name(&layer.block),
    // rust: left + 2.0 + 18.0 + 5.0,
    // rust: y + 5.0,
    // rust: u32::MAX,
    // rust: true,
    // rust: );
    // rust: let (key, fallback) = if row == 0 {
    // rust: ("createWorld.customize.flat.layer.top", "Top - %s")
    // rust: } else if row + 1 == state.settings.layers.len() {
    // rust: ("createWorld.customize.flat.layer.bottom", "Bottom - %s")
    // rust: } else {
    // rust: ("createWorld.customize.flat.layer", "%s")
}
    // rust: let label = format_translation(
    // rust: &lang::get_or(key, fallback),
    // rust: &[Text::literal(layer.height.to_string())],
    // rust: )
    // rust: .plain();
    // rust: let text_width = HudBatch::text_width(atlas, &label);
    // rust: batch.text(
    // rust: atlas,
    // rust: &label,
    // rust: right - text_width - 2.0,
    // rust: y + 5.0,
    // rust: u32::MAX,
    // rust: true,
    // rust: );
}
    // rust: batch.clip_since(first, 0.0, top, w, bottom);
    // rust: draw_items(atlas, items, batch, pending, [0.0, top, w, bottom]);
    // rust: ui::scrollbar(
    // rust: batch,
    // rust: atlas,
    // rust: left + ROW_WIDTH + 6.0,
    // rust: top,
    // rust: bottom,
    // rust: content,
    // rust: state.scroll.amount,
    // rust: );
}

    // rust: fn draw_presets(
    // rust: title: &Title,
    // rust: atlas: &HudAtlas,
    // rust: items: Option<&ItemRenderer>,
    // rust: batch: &mut HudBatch,
    // rust: cursor: (f32, f32),
    // rust: state: &State,
    // rust: (w, h): (f32, f32),
    // rust: ) {
    // rust: super::centered(
    // rust: atlas,
    // rust: batch,
    // rust: &lang::get_or("createWorld.customize.presets.title", "Select a Preset"),
    // rust: 8.0,
    // rust: u32::MAX,
    // rust: );
    // rust: batch.text(
    // rust: atlas,
    // rust: &lang::get_or(
    // rust: "createWorld.customize.presets.share",
    // rust: "Want to share your preset with someone? Use the box below!",
    // rust: ),
    // rust: 51.0,
    // rust: 30.0,
    // rust: rgba(160, 160, 160, 255),
    // rust: true,
    // rust: );
    // The share box: EditBox at 50,40, width - 100 by 20.
    // rust: let field = share_field((w, h));
    // rust: title.caret.borrow_mut().draw(
    // rust: batch,
    // rust: atlas,
    // rust: (super::FLAT_SHARE, &state.share, 1230),
    // rust: field,
    // rust: state.share_focused,
    // rust: title.started,
    // rust: );
    // rust: crate::widgets::name_last_edit_box(|| {
    // rust: Text::translate("createWorld.customize.presets.share", &[]).plain()
    // rust: });
    // rust: batch.text(
    // rust: atlas,
    // rust: &lang::get_or(
    // rust: "createWorld.customize.presets.list",
    // rust: "Alternatively, here are some we made earlier!",
    // rust: ),
    // rust: 51.0,
    // rust: 68.0,
    // rust: rgba(160, 160, 160, 255),
    // rust: true,
    // rust: );
    // rust: let (top, bottom, left, content) = list_area(state, (w, h));
    // rust: ui::list_background(batch, atlas, top, bottom, false);
    // rust: crate::ui::separators(batch, atlas, top, bottom, false);
    // rust: let first = batch.vertices.len();
    // rust: let mut pending = Vec::new();
    // rust: let offset = state.preset_scroll.amount.trunc();
    // PresetsList: "Selected: <preset>".
    // rust: crate::widgets::narratable(|| {
//         use crate::widgets::{ListKind, Narratable, Row};
    // rust: let row = |i: usize| {
    // rust: let name = Text::literal(preset_name(&state.presets[i].id));
    // rust: Row::new(i, Text::translate("narrator.select", &[name]).plain())
}
    // rust: Narratable::list(
    // rust: ListKind::Object,
    // rust: state.presets.len(),
    // rust: preset_row(state, cursor, (w, h)).map(row),
    // rust: state.preset_selected.map(row),
    // rust: [0.0, top, w, bottom - top],
    // rust: )
    // rust: .key(crate::widgets::key_of(&"create_world/flat/presets"))
    // rust: });
    // rust: for (row, preset) in state.presets.iter().enumerate() {
    // rust: let y = top + 2.0 + row as f32 * PRESET_ROW - offset;
    // rust: let target = [left - 2.0, y - 1.0, ROW_WIDTH + 4.0, PRESET_ROW];
    // rust: row_target(&preset_name(&preset.id), target, top, bottom);
    // rust: let hovered = ui::hovered(cursor, target[0], target[1], target[2], target[3]);
    // rust: if state.preset_selected == Some(row) {
    // rust: batch.fill(
    // rust: atlas,
    // rust: target[0],
    // rust: target[1],
    // rust: target[2],
    // rust: target[3],
    // rust: rgba(255, 255, 255, 70),
    // rust: );
    // rust: } else if hovered {
    // rust: batch.fill(
    // rust: atlas,
    // rust: target[0],
    // rust: target[1],
    // rust: target[2],
    // rust: target[3],
    // rust: rgba(255, 255, 255, 25),
    // rust: );
}
    // rust: slot(
    // rust: atlas,
    // rust: items,
    // rust: &mut pending,
    // rust: batch,
    // rust: &preset.display,
    // rust: left + 2.0,
    // rust: y + 2.0,
    // rust: );
    // rust: batch.text(
    // rust: atlas,
    // rust: &preset_name(&preset.id),
    // rust: left + 2.0 + 18.0 + 5.0,
    // rust: y + 7.0,
    // rust: u32::MAX,
    // rust: true,
    // rust: );
}
    // rust: batch.clip_since(first, 0.0, top, w, bottom);
    // rust: draw_items(atlas, items, batch, pending, [0.0, top, w, bottom]);
    // rust: ui::scrollbar(
    // rust: batch,
    // rust: atlas,
    // rust: left + ROW_WIDTH + 6.0,
    // rust: top,
    // rust: bottom,
    // rust: content,
    // rust: state.preset_scroll.amount,
    // rust: );
}

// The item environment of the layer icons: only the grass colormap is needed
// (`minecraft:grass` tint of the grass block), as the inventory draws it.
GrassEnv :: struct {
    // rust: impl ItemEnv for GrassEnv<'_> {
grass_color :: proc(self: ^Self, temperature: f64, downfall: f64) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.0.grass_color(temperature, downfall)
}
}
// A layer's item model for the GUI, with the grass colormap in its environment.
layer_state :: proc(renderer: ^ItemRenderer, id: string) -> I {
    // Ported from Horizon
    return {}
}
    // rust: let stack = ItemStack::new(&layer_item(id), 1);
    // rust: renderer.resolve(
    // rust: &item_render::stack_view(&stack),
    // rust: DisplayContext::Gui,
    // rust: None,
    // rust: None,
    // rust: 0,
    // rust: &GrassEnv(renderer),
    // rust: )
}
// The 18x18 slot behind a layer's item icon (`container/slot`), then the item
// (`GuiGraphics.renderItem`): its GUI model, so a block shows as the isometric
// block. Without item models, or for an id with none, the flat sprite stands in.
    // rust: fn slot(
    // rust: atlas: &HudAtlas,
    // rust: items: Option<&ItemRenderer>,
    // rust: pending: &mut Vec<(ItemRenderState, f32, f32)>,
    // rust: batch: &mut HudBatch,
    // rust: id: &str,
    // rust: x: f32,
    // rust: y: f32,
    // rust: ) {
    // rust: if let Some(rect) = atlas.sprites.get("gui/sprites/container/slot").copied() {
    // rust: batch.rect_uv(x, y, 18.0, 18.0, rect, u32::MAX);
    // rust: } else {
    // rust: batch.fill(atlas, x, y, 18.0, 18.0, rgba(139, 139, 139, 255));
    // rust: batch.fill(atlas, x + 1.0, y + 1.0, 16.0, 16.0, rgba(55, 55, 55, 255));
}
    // rust: if let Some(renderer) = items {
    // rust: let state = layer_state(renderer, id);
    // rust: if !state.is_empty() {
    // rust: pending.push((state, x + 1.0, y + 1.0));
    // rust: return;
}
}
    // rust: if let Some(icon) = layer_icon(atlas, id) {
    // rust: batch.sprite_scaled(atlas, &icon, x + 1.0, y + 1.0, 16.0, 16.0, u32::MAX);
}
}
// The item models of a list's rows, drawn after the list's own quads are cut
// to its area (`clip_since` keeps or drops a slanted quad whole): each is
// clipped exactly to the list, as vanilla's scissor does.
    // rust: fn draw_items(
    // rust: atlas: &HudAtlas,
    // rust: renderer: Option<&ItemRenderer>,
    // rust: batch: &mut HudBatch,
    // rust: pending: Vec<(ItemRenderState, f32, f32)>,
    // rust: scissor: [f32; 4],
    // rust: ) {
    // rust: let Some(renderer) = renderer else { return };
    // rust: for (state, x, y) in &pending {
    // rust: item_render::gui::draw_scissored(
    // rust: state,
    // rust: renderer,
    // rust: &atlas.sprites,
    // rust: &NoHost,
    // rust: batch,
    // rust: *x,
    // rust: *y,
    // rust: scissor,
    // rust: );
}
}
// The item a layer shows: `FlatLayerInfo` draws `block.asItem()`, and the
// fluids' items are their buckets.
layer_item :: proc(id: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match id.strip_prefix("minecraft:").unwrap_or(id) {
    // rust: "water" => "minecraft:water_bucket".into(),
    // rust: "lava" => "minecraft:lava_bucket".into(),
    // rust: name => format!("minecraft:{name}"),
}
}
layer_icon :: proc(atlas: ^HudAtlas, id: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let name = id.strip_prefix("minecraft:").unwrap_or(id);
    // rust: let candidates: Vec<String> = if name == "water" {
    // rust: vec!["item/water_bucket".into()]
    // rust: } else if name == "lava" {
    // rust: vec!["item/lava_bucket".into()]
    // rust: } else {
    // rust: vec![
    // rust: format!("item/{name}"),
    // rust: format!("block/{name}"),
    // rust: format!("block/{name}_side"),
    // rust: format!("block/{name}_top"),
    // rust: ]
}
    // rust: candidates
    // rust: .into_iter()
    // rust: .find(|sprite| atlas.sprites.contains_key(sprite))
}
item_name :: proc(id: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let name = id.strip_prefix("minecraft:").unwrap_or(id);
    // rust: if name == "water" {
    // rust: return lang::get_or("item.minecraft.water_bucket", "Water Bucket");
}
    // rust: if name == "lava" {
    // rust: return lang::get_or("item.minecraft.lava_bucket", "Lava Bucket");
}
    // rust: for key in [
    // rust: format!("block.minecraft.{name}"),
    // rust: format!("item.minecraft.{name}"),
    // rust: ] {
    // rust: if lang::has(&key) {
    // rust: return lang::get(&key);
}
}
    // rust: pretty(name)
}
preset_name :: proc(id: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let key = format!("flat_world_preset.{}", id.replace(':', "."));
    // rust: lang::get_or(&key, &pretty(id.strip_prefix("minecraft:").unwrap_or(id)))
}
pretty :: proc(name: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: name.split('_')
    // rust: .filter(|word| !word.is_empty())
    // rust: .map(|word| {
    // rust: let mut chars = word.chars();
    // rust: match chars.next() {
    // rust: Some(first) => first.to_uppercase().chain(chars).collect::<String>(),
    // rust: None => String::new(),
}
    // rust: })
    // rust: .collect::<Vec<_>>()
    // rust: .join(" ")
}

// `CreateFlatWorldScreen.DetailsList.deleteLayer`: after a row is removed the
// same row stays selected, or the last one when the removed row was the last
// of the list. An empty list selects nothing.
    // rust: pub(super) fn selection_after_removal(row: usize, remaining: usize) -> Option<usize> {
    // rust: (remaining > 0).then(|| row.min(remaining - 1))
}

    // rust: mod tests {
//     use super::{
    // rust: FlatSettings, Page, Preset, State, click, focus_row, layer_item, list_area,
    // rust: selection_after_removal,
}
//     use crate::item_render::ItemRenderer;
//     use std::path::Path;

    // Vanilla keeps the deleted row's position selected: the layer that slid
    // into it, or the new last row when the last one was deleted, and nothing
    // when the list is empty.
deleting_a_layer_keeps_the_selection_in_place :: proc() {
}
    // rust: assert_eq!(selection_after_removal(0, 3), Some(0));
    // rust: assert_eq!(selection_after_removal(2, 3), Some(2));
    // rust: assert_eq!(selection_after_removal(3, 3), Some(2), "the last row");
    // rust: assert_eq!(selection_after_removal(0, 0), None, "nothing left");
}

    // `PresetsList`: the focus selects a row and leaves the share box to a press
    // (`Entry.select`), so stepping through the list keeps what was typed there.
only_a_press_puts_a_preset_in_the_share_box :: proc() {
}
    // rust: let mut state = State::new(Path::new("missing"), None);
    // rust: let mut settings = FlatSettings::default();
    // rust: settings.layers.clear();
    // rust: let share = settings.to_share();
    // rust: state.presets.push(Preset {
    // rust: id: "minecraft:test".to_owned(),
    // rust: display: "Test".to_owned(),
    // rust: settings,
    // rust: });
    // rust: state.page = Page::Presets;
    // rust: state.share = "typed".to_owned();
    // rust: let size = (480.0, 262.0);
    // rust: let (top, _, left, _) = list_area(&state, size);
    // rust: let row = (left + 1.0, top + 3.0);
    // rust: assert!(focus_row(&mut state, row, size));
    // rust: assert_eq!(state.selecting(), Some(0));
    // rust: assert_eq!(state.share, "typed");
    // rust: click(&mut state, row, size);
    // rust: assert_eq!(state.share, share);
}

    // The grass block icon of a Superflat layer is tinted by the grass
    // colormap (`minecraft:grass` tint source), not the missing-tint magenta.
the_grass_block_layer_icon_is_tinted_by_the_colormap :: proc() {
}
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("entity-models.json").exists() {
    // rust: return;
}
    // rust: let renderer = ItemRenderer::load(&root).unwrap();
    // rust: let tinted: Vec<i32> = super::layer_state(&renderer, "minecraft:grass_block")
    // rust: .layers
    // rust: .iter()
    // rust: .flat_map(|layer| layer.tints.clone())
    // rust: .collect();
    // rust: assert!(
    // rust: !tinted.is_empty() && !tinted.contains(&-65281),
    // rust: "{tinted:?}"
    // rust: );
}

a_layer_shows_the_item_of_its_block :: proc() {
}
    // rust: assert_eq!(layer_item("minecraft:grass_block"), "minecraft:grass_block");
    // rust: assert_eq!(layer_item("dirt"), "minecraft:dirt");
    // rust: assert_eq!(layer_item("minecraft:water"), "minecraft:water_bucket");
    // rust: assert_eq!(layer_item("minecraft:lava"), "minecraft:lava_bucket");
}
}
