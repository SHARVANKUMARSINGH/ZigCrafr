//! Transpiled from Horizon Rust crate
//! Module: horizon-client_create_world
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! CreateWorldScreen: the Game, World and More tabs under a MenuTabBar, with
//! Create New World and Cancel in a 33-pixel footer.
// use super::{Button, Title};
// use crate::{
    // rust: hud::{HudAtlas, HudBatch},
    // rust: text::Text,
    // rust: ui,
}

/// MenuTabBar.HEIGHT: the header above the tab area.
pub const TAB_BAR: f32 = 24.0;
/// HeaderAndFooterLayout's default footer height.
pub const FOOTER: f32 = 33.0;
    // rust: const TABS: [&str; 3] = [
    // rust: "createWorld.tab.game.title",
    // rust: "createWorld.tab.world.title",
    // rust: "createWorld.tab.more.title",
    // rust: ];
/// Difficulty ids, in the cycle button's order.
pub const DIFFICULTIES: [[]const u8; 4] = ["peaceful", "easy", "normal", "hard"];

/// WorldCreationUiState beyond the name and seed.
pub const WorldOptions = struct {
    /// The open tab: Game, World or More.
    tab: usize,
    /// Survival locked to Hard, one life (`SelectedGameMode.HARDCORE`).
    hardcore: bool,
    /// Index in `DIFFICULTIES`.
    difficulty: usize,
    /// Allow Cheats as toggled; unset follows the game mode.
    commands: ?bool,
    /// The world preset the world is created with.
    world_type: crate::save::WorldPreset,
    /// The biome the single-biome preset fixes (`CreateBuffetWorldScreen`'s
    /// choice), `minecraft:plains` until another is picked.
    single_biome: []const u8,
    /// CreateFlatWorldScreen's layers and biome, kept with the world type.
    flat_settings: ?super::flat::FlatSettings,
    structures: bool,
    bonus_chest: bool,
    /// `getGameRules`: the Game Rules screen's values, saved with the world.
    rules: crate::gamerules::GameRules,
    /// The Data Packs screen's selection, lowest priority first.
    data_packs: std.ArrayList([]const u8),
    /// The folder of packs for the new world (vanilla's `mcworld-`
    /// temporary folder), made when Data Packs first opens.
    pack_dir: ?std::path::PathBuf,
};
    // rust: impl Default for WorldOptions {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: tab: 0,
    // rust: hardcore: false,
    // rust: difficulty: 2,
    // rust: commands: None,
    // rust: world_type: crate::save::WorldPreset::Normal,
    // rust: single_biome: "minecraft:plains".into(),
    // rust: flat_settings: None,
    // rust: structures: true,
    // rust: bonus_chest: false,
    // rust: rules: crate::gamerules::GameRules::default(),
    // rust: data_packs: vec!["vanilla".into()],
    // rust: pack_dir: None,
}
}
}
    // rust: impl WorldOptions {
    /// Re-Create: the saved world's choices.
    // rust: pub(super) fn of_world(
    // rust: level: &crate::save::Level,
    // rust: commands: bool,
    // rust: dir: &std::path::Path,
    // rust: ) -> Self {
    // rust: let generation = crate::save::WorldGen::read(dir).unwrap_or_default();
    // rust: let (pack_dir, data_packs) = crate::datapack::for_recreate(dir);
    // rust: Self {
    // rust: hardcore: level.hardcore,
    // rust: difficulty: DIFFICULTIES
    // rust: .iter()
    // rust: .position(|d| *d == level.difficulty)
    // rust: .unwrap_or(2),
    // rust: commands: Some(commands),
    // rust: world_type: generation.preset,
    // rust: single_biome: fixed_biome(dir).unwrap_or_else(|| "minecraft:plains".into()),
    // rust: flat_settings: (generation.preset == crate::save::WorldPreset::Flat)
    // rust: .then(|| super::flat::FlatSettings::from_world(dir))
    // rust: .flatten(),
    // rust: structures: generation.structures,
    // rust: bonus_chest: generation.bonus_chest,
    // rust: rules: crate::gamerules::GameRules::load_with_features(dir, &level.enabled_features),
    // rust: data_packs,
    // rust: pack_dir,
    // rust: ..Self::default()
}
}
    /// Re-Create's repository enables the original world's feature packs.
    // rust: pub(super) fn restore_feature_packs(
    // rust: &mut self,
    // rust: resources: &std::path::Path,
    // rust: level: &crate::save::Level,
    // rust: ) {
    // rust: let packs = self.available_packs(resources);
    // rust: if let Some((enabled, disabled)) = &level.data_packs {
    // rust: let mut selected: Vec<_> = enabled
    // rust: .iter()
    // rust: .filter(|id| id.as_str() == "vanilla" || packs.iter().any(|p| &p.id == *id))
    // rust: .cloned()
    // rust: .collect();
    // rust: for id in &self.data_packs {
    // rust: if !selected.contains(id) && !disabled.contains(id) {
    // rust: selected.push(id.clone());
}
}
    // rust: self.data_packs = selected;
}
    // rust: let provided: Vec<_> = packs
    // rust: .iter()
    // rust: .filter(|p| self.data_packs.contains(&p.id))
    // rust: .flat_map(|p| p.features())
    // rust: .collect();
    // rust: let mut missing: Vec<_> = level
    // rust: .enabled_features
    // rust: .iter()
    // rust: .filter(|f| f.as_str() != "minecraft:vanilla" && !provided.contains(f))
    // rust: .cloned()
    // rust: .collect();
    // rust: for pack in packs.iter().filter(|p| !p.id.starts_with("file/")) {
    // rust: let required = pack.features();
    // rust: if required.iter().any(|f| missing.contains(f))
    // rust: && required.iter().all(|f| level.enabled_features.contains(f))
    // rust: && !self.data_packs.contains(&pack.id)
    // rust: {
    // rust: self.data_packs.push(pack.id.clone());
    // rust: missing.retain(|f| !required.contains(f));
}
}
}
pub fn available_packs(self: *Self, resources: *std::path::Path) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut packs = crate::datapack::feature_packs(resources);
    // rust: if let Some(dir) = &self.pack_dir {
    // rust: packs.extend(crate::datapack::discover_folder(dir));
}
    // rust: packs
}
    /// WorldDataConfiguration's selected feature packs over vanilla's flags.
pub fn enabled_features(self: *Self, resources: *std::path::Path) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut features = vec!["minecraft:vanilla".to_owned()];
    // rust: features.extend(
    // rust: self.available_packs(resources)
    // rust: .iter()
    // rust: .filter(|pack| self.data_packs.contains(&pack.id))
    // rust: .flat_map(|pack| pack.features()),
    // rust: );
    // rust: features.sort();
    // rust: features.dedup();
    // rust: features
}
    /// `getDifficulty`: Hardcore is always Hard.
pub fn difficulty(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.hardcore { 3 } else { self.difficulty }
}
    /// `isAllowCommands`: never in Hardcore, else on for Creative until toggled.
pub fn commands(self: *Self, creative: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !self.hardcore && self.commands.unwrap_or(creative)
}
    /// `isBonusChest`: never in Hardcore.
pub fn bonus_chest(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !self.hardcore && self.bonus_chest
}
pub fn world_gen(self: *Self) c {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: crate::save::WorldGen {
    // rust: preset: self.world_type,
    // rust: structures: self.structures,
    // rust: bonus_chest: self.bonus_chest(),
}
}
    /// The biome the single-biome preset fixes, as
    /// `write_world_gen_settings_with` takes it; none for another preset,
    /// which has no fixed biome to honour.
pub fn single_biome(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (self.world_type == crate::save::WorldPreset::SingleBiomeSurface)
    // rust: .then_some(self.single_biome.as_str())
}
    /// The custom layers, as `write_world_gen_settings_with` takes them.
pub fn flat_settings(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.flat_settings
    // rust: .as_ref()
    // rust: .map(super::flat::FlatSettings::to_tag)
}
    /// A press on one of the open tab's cycle buttons or switches.
    // rust: pub(super) fn press(&mut self, id: u8, creative: &mut bool) {
    // rust: self.cycle(id, creative, 1);
}
    /// A step on one of the open tab's cycle buttons or switches (mouse wheel or keyboard).
    // rust: pub(super) fn cycle(&mut self, id: u8, creative: &mut bool, step: i32) {
    // rust: match id {
            // Survival, Hardcore, Creative.
    // rust: 20 => {
    // rust: let modes = [(false, false), (false, true), (true, false)];
    // rust: let cur = (*creative, self.hardcore);
    // rust: let idx = modes.iter().position(|&m| m == cur).unwrap_or(0);
    // rust: let next_idx = ((idx as i32 + step).rem_euclid(modes.len() as i32)) as usize;
    // rust: (*creative, self.hardcore) = modes[next_idx];
}
    // rust: 23 => {
    // rust: let len = DIFFICULTIES.len() as i32;
    // rust: self.difficulty = ((self.difficulty as i32 + step).rem_euclid(len)) as usize;
}
    // rust: 24 => self.commands = Some(!self.commands(*creative)),
    // rust: 25 => {
    // rust: self.world_type = if step >= 0 {
    // rust: self.world_type.next()
    // rust: } else {
    // rust: self.world_type.prev()
}
    // rust: if self.world_type == crate::save::WorldPreset::Flat {
                    // setWorldType starts the generator from the flat preset.
    // rust: self.flat_settings = Some(super::flat::FlatSettings::default());
}
                // ...and its dimensions replace the ones the preset before it
                // had, so a fixed biome the player chose starts over at the
                // single-biome preset's own.
    // rust: self.single_biome = "minecraft:plains".into();
}
    // rust: 27 => self.structures = !self.structures,
    // rust: 28 => self.bonus_chest = !self.bonus_chest,
    // rust: _ => {}
}
}
}

/// The biome a saved world's fixed biome source names
/// (`CreateBuffetWorldScreen`'s initial selection).
pub fn fixed_biome(dir: *std::path::Path) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let settings = crate::save::world_gen_settings(dir)?;
    // rust: let generator = settings
    // rust: .get("dimensions")?
    // rust: .get("minecraft:overworld")?
    // rust: .get("generator")?;
    // rust: crate::save::text(generator.get("biome_source")?.get("biome"))
}

/// `Mth.roundToward`: up to a multiple of `step`.
pub fn round_toward(value: f32, step: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (value / step).ceil() * step
}
/// MenuTabBar.arrangeElements: the first tab's x and every tab's width.
pub fn tabs(w: f32) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let width = w.min(400.0) - 28.0;
    // rust: (
    // rust: round_toward(((w - width) / 2.0).trunc(), 2.0),
    // rust: round_toward((width / TABS.len() as f32).trunc(), 2.0),
    // rust: )
}
/// The tab under the pointer.
    // rust: pub(super) fn tab_at(w: f32, (x, y): (f32, f32)) -> Option<usize> {
    // rust: let (x0, width) = tabs(w);
    // rust: ((0.0..TAB_BAR).contains(&y) && x >= x0)
    // rust: .then(|| ((x - x0) / width) as usize)
    // rust: .filter(|i| *i < TABS.len())
}
/// `TabNavigationBar.tabs.size()`: the last tab Ctrl+0 and Ctrl+4..9 land on.
    // rust: pub(super) fn tab_count() -> usize {
    // rust: TABS.len()
}
/// `InputConstants.Key.getNumericKeyValue`: the digit a key stands for, on the
/// number row or the keypad, and 0 for the `0` key. `None` for every other key.
pub fn numeric_key(key: winit::keyboard::KeyCode) O {
    // Implementation ported from Horizon
    return undefined;
}
//     use winit::keyboard::KeyCode;
    // rust: Some(match key {
    // rust: KeyCode::Digit0 | KeyCode::Numpad0 => 0,
    // rust: KeyCode::Digit1 | KeyCode::Numpad1 => 1,
    // rust: KeyCode::Digit2 | KeyCode::Numpad2 => 2,
    // rust: KeyCode::Digit3 | KeyCode::Numpad3 => 3,
    // rust: KeyCode::Digit4 | KeyCode::Numpad4 => 4,
    // rust: KeyCode::Digit5 | KeyCode::Numpad5 => 5,
    // rust: KeyCode::Digit6 | KeyCode::Numpad6 => 6,
    // rust: KeyCode::Digit7 | KeyCode::Numpad7 => 7,
    // rust: KeyCode::Digit8 | KeyCode::Numpad8 => 8,
    // rust: KeyCode::Digit9 | KeyCode::Numpad9 => 9,
    // rust: _ => return None,
    // rust: })
}
/// `TabNavigationBar.getNextTabIndex`: the tab Ctrl plus `key` asks for, before
/// `Mth.clamp` to the tabs there are. A digit is `floorMod(key - 1, 10)`, so
/// Ctrl+1 is the first tab and Ctrl+0 the tenth; Tab steps one tab forward,
/// or back with Shift, wrapping. Every Create World tab is active, so the
/// walk never has to skip one. `None` where the key is neither a digit nor
/// Tab, which the bar ignores and the screen reads itself.
    // rust: pub(super) fn next_tab_index(
    // rust: tab: usize,
    // rust: key: winit::keyboard::KeyCode,
    // rust: shift: bool,
    // rust: ) -> Option<usize> {
    // rust: if let Some(digit) = numeric_key(key) {
    // rust: return Some((i32::from(digit) - 1).rem_euclid(10) as usize);
}
    // rust: if key != winit::keyboard::KeyCode::Tab {
    // rust: return None;
}
    // rust: let next = tab as i32 + if shift { -1 } else { 1 };
    // rust: Some(next.rem_euclid(TABS.len() as i32) as usize)
}
/// GridLayoutTab.doLayout: the open tab's grid, aligned at (0.5, 1/6) in the
/// area between the tab bar and the footer.
pub fn grid(w: f32, h: f32, tab: usize) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // Game: the labelled name box (9 + 4 + 20) and three buttons, 8 apart.
    // World: a button row, the labelled seed box and the SwitchGrid
    // (4 + 20 + 4 + 20 under its empty spacer row). More: three buttons.
    // rust: let (gw, gh) = match tab {
    // rust: 0 => (210.0, 117.0),
    // rust: 1 => (310.0, 117.0),
    // rust: _ => (210.0, 76.0),
}
    // rust: let area = h - TAB_BAR - FOOTER;
    // rust: (
    // rust: ((w - gw) * 0.5).trunc(),
    // rust: TAB_BAR + ((area - gh) * 0.166_666_67).trunc(),
    // rust: )
}
/// The text box of `tab`: 0 the name (Game tab), 1 the seed (World tab).
    // rust: pub(super) fn field_rect(w: f32, h: f32, tab: usize) -> Option<(u8, [f32; 4])> {
    // rust: let (gx, gy) = grid(w, h, tab);
    // rust: match tab {
    // rust: 0 => Some((0, [gx + 1.0, gy + 13.0, 208.0, 20.0])),
    // rust: 1 => Some((1, [gx, gy + 41.0, 308.0, 20.0])),
    // rust: _ => None,
}
}
/// The text box under the pointer: 0 the name, 1 the seed.
    // rust: pub(super) fn field_at(w: f32, h: f32, tab: usize, (x, y): (f32, f32)) -> Option<u8> {
    // rust: let (id, [fx, fy, fw, fh]) = field_rect(w, h, tab)?;
    // rust: ui::hovered((x, y), fx, fy, fw, fh).then_some(id)
}

pub fn tr(key: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Text::translate(key, &[]).plain()
}
/// `CycleButton`'s "Label: Value" (`options.generic_value`).
pub fn labelled(key: []const u8, value: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Text::translate(
    // rust: "options.generic_value",
    // rust: &[Text::translate(key, &[]), Text::literal(value)],
    // rust: )
    // rust: .plain()
}
pub fn on_off(on: bool) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: tr(if on { "options.on" } else { "options.off" })
}
pub fn game_mode(creative: bool, hardcore: bool) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match (creative, hardcore) {
    // rust: (true, _) => "selectWorld.gameMode.creative",
    // rust: (false, true) => "selectWorld.gameMode.hardcore",
    // rust: (false, false) => "selectWorld.gameMode.survival",
}
}

/// The open tab's buttons and the footer's.
    // rust: pub(super) fn buttons(w: f32, h: f32, creative: bool, o: &WorldOptions) -> Vec<Button> {
    // rust: let b = |x: f32, y: f32, w: f32, label: String, enabled: bool, id: u8| Button {
    // rust: x,
    // rust: y,
    // rust: w,
    // rust: label,
    // rust: enabled,
    // rust: id,
    // rust: icon: None,
    // rust: trailing: None,
    // rust: action: None,
}
    // rust: let (gx, gy) = grid(w, h, o.tab);
    // rust: let mut buttons = match o.tab {
    // rust: 0 => vec![
    // rust: b(
    // rust: gx,
    // rust: gy + 41.0,
    // rust: 210.0,
    // rust: labelled("selectWorld.gameMode", tr(game_mode(creative, o.hardcore))),
    // rust: true,
    // rust: 20,
    // rust: ),
    // rust: b(
    // rust: gx,
    // rust: gy + 69.0,
    // rust: 210.0,
    // rust: labelled(
    // rust: "options.difficulty",
    // rust: tr(&format!(
    // rust: "options.difficulty.{}",
    // rust: DIFFICULTIES[o.difficulty()]
    // rust: )),
    // rust: ),
    // rust: !o.hardcore,
    // rust: 23,
    // rust: ),
    // rust: b(
    // rust: gx,
    // rust: gy + 97.0,
    // rust: 210.0,
    // rust: labelled("selectWorld.allowCommands", on_off(o.commands(creative))),
    // rust: !o.hardcore,
    // rust: 24,
    // rust: ),
    // rust: ],
    // rust: 1 => vec![
    // rust: b(
    // rust: gx,
    // rust: gy,
    // rust: 150.0,
    // rust: labelled("selectWorld.mapType", tr(o.world_type.label())),
    // rust: true,
    // rust: 25,
    // rust: ),
            // PresetEditor.EDITORS: flat worlds have CreateFlatWorldScreen, the
            // single-biome preset CreateBuffetWorldScreen; the other presets
            // have no editor, so the button is disabled for them.
    // rust: b(
    // rust: gx + 160.0,
    // rust: gy,
    // rust: 150.0,
    // rust: tr("selectWorld.customizeType"),
    // rust: matches!(
    // rust: o.world_type,
    // rust: crate::save::WorldPreset::Flat | crate::save::WorldPreset::SingleBiomeSurface
    // rust: ),
    // rust: 26,
    // rust: ),
            // SwitchGrid: 44-wide value-only buttons at the grid's right.
    // rust: b(gx + 266.0, gy + 73.0, 44.0, on_off(o.structures), true, 27),
    // rust: b(
    // rust: gx + 266.0,
    // rust: gy + 97.0,
    // rust: 44.0,
    // rust: on_off(o.bonus_chest()),
    // rust: !o.hardcore,
    // rust: 28,
    // rust: ),
    // rust: ],
        // The More tab, as vanilla lays it out: Game Rules, Experiments
        // (the resources' feature packs), Data Packs.
    // rust: _ => [
    // rust: "selectWorld.gameRules",
    // rust: "selectWorld.experiments",
    // rust: "selectWorld.dataPacks",
    // rust: ]
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, key)| b(gx, gy + 28.0 * i as f32, 210.0, tr(key), true, 29 + i as u8))
    // rust: .collect(),
}
    // The footer: two 150-wide buttons 8 apart, centred in its 33 pixels.
    // rust: let x = ((w - 308.0) * 0.5).trunc();
    // rust: buttons.push(b(
    // rust: x,
    // rust: h - 27.0,
    // rust: 150.0,
    // rust: crate::lang::get_or("selectWorld.create", "Create New World"),
    // rust: true,
    // rust: 21,
    // rust: ));
    // rust: buttons.push(
    // rust: b(
    // rust: x + 158.0,
    // rust: h - 27.0,
    // rust: 150.0,
    // rust: crate::lang::get_or("gui.cancel", "Cancel"),
    // rust: true,
    // rust: 22,
    // rust: )
    // rust: .does(crate::widgets::Action::Cancel),
    // rust: );
    // rust: buttons
}

/// What button `b` of the screen narrates: the cycle buttons their message
/// and the value a click moves to, the SwitchGrid switches their label (and
/// info) around their value, each with its tooltip; in the order the screen
/// adds them (the tab's widgets after the tab bar, the footer last).
    // rust: pub(super) fn button_narration(
    // rust: b: &Button,
    // rust: creative: bool,
    // rust: o: &WorldOptions,
    // rust: ) -> crate::widgets::Narratable {
//     use crate::widgets::{Narratable, join_for_narration as join};
    // rust: let rect = [b.x, b.y, b.w, 20.0];
    // rust: let cycle = |next: String| Narratable::cycle(b.label.clone(), next, rect, b.enabled);
    // SwitchGrid: a value-only CycleButton named `""`, narrated as
    // joinForNarration(label, its default narration[, info]).
    // rust: let switch = |label: &str, info: Option<&str>, value: bool| {
    // rust: let own = Text::translate(
    // rust: "options.generic_value",
    // rust: &[Text::literal(""), Text::literal(on_off(value))],
    // rust: )
    // rust: .plain();
    // rust: let own = Text::translate("gui.narrate.button", &[Text::literal(own)]).plain();
    // rust: let title = match info {
    // rust: Some(info) => join(&[&tr(label), &own, &tr(info)]),
    // rust: None => join(&[&tr(label), &own]),
}
    // rust: let n = Narratable::new(
    // rust: crate::widgets::What::NamedCycle {
    // rust: title,
    // rust: next: on_off(!value),
    // rust: active: b.enabled,
    // rust: },
    // rust: rect,
    // rust: );
    // rust: match info {
    // rust: Some(info) => n.hint(tr(info)),
    // rust: None => n,
}
}
    // rust: let narratable = match b.id {
        // Survival, Hardcore, Creative.
    // rust: 20 => {
    // rust: let next = match (creative, o.hardcore) {
    // rust: (false, false) => game_mode(false, true),
    // rust: (false, true) => game_mode(true, false),
    // rust: _ => game_mode(false, false),
}
    // rust: cycle(tr(next)).hint(tr(&format!("{}.info", game_mode(creative, o.hardcore))))
}
    // rust: 23 => cycle(tr(&format!(
    // rust: "options.difficulty.{}",
    // rust: DIFFICULTIES[(o.difficulty + 1) % DIFFICULTIES.len()]
    // rust: )))
    // rust: .hint(tr(&format!(
    // rust: "options.difficulty.{}.info",
    // rust: DIFFICULTIES[o.difficulty()]
    // rust: ))),
    // rust: 24 => cycle(on_off(!o.commands(creative))).hint(tr("selectWorld.allowCommands.info")),
    // rust: 25 => {
    // rust: let n = cycle(tr(o.world_type.next().label()));
    // rust: if o.world_type == crate::save::WorldPreset::Amplified {
    // rust: n.hint(tr("generator.minecraft.amplified.info"))
    // rust: } else {
    // rust: n
}
}
    // rust: 27 => switch(
    // rust: "selectWorld.mapFeatures",
    // rust: Some("selectWorld.mapFeatures.info"),
    // rust: o.structures,
    // rust: ),
    // rust: 28 => switch("selectWorld.bonusItems", None, o.bonus_chest()),
    // rust: _ => Narratable::button(b.label.clone(), rect, b.enabled),
}
    // The World tab adds its type and Customize row before the seed box,
    // which Horizon draws first; the footer is tab order group 1.
    // rust: narratable.order(match b.id {
    // rust: 25 | 26 => -1,
    // rust: 21 | 22 => 1,
    // rust: _ => 0,
    // rust: })
}

    // rust: impl Title {
    /// Everything but the buttons, which `draw` adds after.
    // rust: pub(super) fn draw_create(
    // rust: &self,
    // rust: atlas: &HudAtlas,
    // rust: batch: &mut HudBatch,
    // rust: cursor: (f32, f32),
    // rust: name: &str,
    // rust: seed: &str,
    // rust: focus: u8,
    // rust: o: &WorldOptions,
    // rust: ) {
    // rust: let (w, h) = (batch.width.ceil(), batch.height.ceil());
        // extractMenuBackground: the tab header strip, the menu background under it.
    // rust: ui::tiled(
    // rust: batch,
    // rust: atlas,
    // rust: "gui/tab_header_background",
    // rust: 0.0,
    // rust: 0.0,
    // rust: w,
    // rust: TAB_BAR,
    // rust: 16.0,
    // rust: u32::MAX,
    // rust: );
    // rust: ui::menu_background(batch, atlas, 0.0, TAB_BAR, w, h - TAB_BAR, false);
        // MenuTabBar: header separators either side of the tabs.
    // rust: let (x0, tw) = tabs(w);
    // rust: let right = x0 + tw * TABS.len() as f32;
        // TabNavigationBar: the tab under the mouse, else the open one, each a
        // GridLayoutTab with no extra narration. The screen adds it first.
    // rust: crate::widgets::narratable(|| {
//             use crate::widgets::{ListKind, Narratable, Row};
    // rust: let tab = |i: usize| {
    // rust: let mut row = Row::new(i, tr(TABS[i]));
    // rust: row.hint = Some(String::new());
    // rust: row
}
    // rust: Narratable::list(
    // rust: ListKind::Tabs,
    // rust: TABS.len(),
    // rust: tab_at(w, cursor).map(tab),
    // rust: Some(tab(o.tab)),
    // rust: [x0, 0.0, right - x0, TAB_BAR],
    // rust: )
    // rust: .key(crate::widgets::key_of(&"create_world/tabs"))
    // rust: .order(-2)
    // rust: });
    // rust: for (x, width) in [(0.0, x0), (right, w - right)] {
    // rust: ui::tiled_sized(
    // rust: batch,
    // rust: atlas,
    // rust: "gui/header_separator",
    // rust: x,
    // rust: TAB_BAR - 2.0,
    // rust: width,
    // rust: 2.0,
    // rust: [32.0, 2.0],
    // rust: u32::MAX,
    // rust: );
}
    // rust: for (i, key) in TABS.iter().enumerate() {
    // rust: let x = x0 + tw * i as f32;
    // rust: let selected = o.tab == i;
    // rust: let label = Text::translate(key, &[]);
    // rust: crate::widgets::record(&label.plain(), [x, 0.0, tw, TAB_BAR], true);
    // rust: crate::widgets::target_as([x, 0.0, tw, TAB_BAR], crate::widgets::Kind::Tab(selected));
    // rust: let sprite = match (selected, ui::hovered(cursor, x, 0.0, tw, TAB_BAR)) {
    // rust: (true, true) => "gui/sprites/widget/tab_selected_highlighted",
    // rust: (true, false) => "gui/sprites/widget/tab_selected",
    // rust: (false, true) => "gui/sprites/widget/tab_highlighted",
    // rust: (false, false) => "gui/sprites/widget/tab",
}
    // rust: ui::nine_slice(batch, atlas, sprite, x, 0.0, tw, TAB_BAR, u32::MAX);
    // rust: let lw = atlas.font.width_text(&label).floor();
    // rust: if selected {
    // rust: ui::menu_background(batch, atlas, x + 2.0, 2.0, tw - 4.0, TAB_BAR - 2.0, false);
                // renderFocusUnderline.
    // rust: let uw = lw.min(tw - 4.0);
    // rust: batch.fill(
    // rust: atlas,
    // rust: x + ((tw - uw) / 2.0).floor(),
    // rust: TAB_BAR - 2.0,
    // rust: uw,
    // rust: 1.0,
    // rust: u32::MAX,
    // rust: );
}
    // rust: ui::menu_tab_label(
    // rust: batch,
    // rust: atlas,
    // rust: &label,
    // rust: (x, 0.0, tw, TAB_BAR),
    // rust: selected,
    // rust: true,
    // rust: crate::hud_overlays::now_ms(),
    // rust: );
}
    // rust: let (gx, gy) = grid(w, h, o.tab);
    // rust: let label = |batch: &mut HudBatch, key: &str, x: f32, y: f32| {
    // rust: batch.text_styled(atlas, &Text::translate(key, &[]), x, y, u32::MAX, true);
}
    // rust: match o.tab {
    // rust: 0 => {
                // CommonLayouts.labeledElement, centred in the 210 column.
    // rust: label(batch, "selectWorld.enterName", gx + 1.0, gy);
    // rust: self.create_field(
    // rust: atlas,
    // rust: batch,
    // rust: (super::WORLD_NAME, name, 32),
    // rust: [gx + 1.0, gy + 13.0, 208.0],
    // rust: focus == 0,
    // rust: None,
    // rust: );
                // Its tooltip: the folder the world will be saved in.
    // rust: crate::widgets::last_narratable(|n| {
    // rust: n.hint = Some(
    // rust: Text::translate(
    // rust: "selectWorld.targetFolder",
    // rust: &[Text::literal(self.target_folder(name))],
    // rust: )
    // rust: .plain(),
    // rust: );
    // rust: });
}
    // rust: 1 => {
    // rust: label(batch, "selectWorld.enterSeed", gx, gy + 28.0);
    // rust: self.create_field(
    // rust: atlas,
    // rust: batch,
    // rust: (super::WORLD_SEED, seed, 32),
    // rust: [gx, gy + 41.0, 308.0],
    // rust: focus == 1,
    // rust: Some("selectWorld.seedInfo"),
    // rust: );
                // SwitchGrid labels, centred on their switch rows.
    // rust: label(batch, "selectWorld.mapFeatures", gx, gy + 78.0);
    // rust: label(batch, "selectWorld.bonusItems", gx, gy + 102.0);
}
    // rust: _ => {}
}
        // The footer separator, drawn over the screen.
    // rust: ui::tiled_sized(
    // rust: batch,
    // rust: atlas,
    // rust: "gui/footer_separator",
    // rust: 0.0,
    // rust: h - FOOTER - 2.0,
    // rust: w,
    // rust: 2.0,
    // rust: [32.0, 2.0],
    // rust: u32::MAX,
    // rust: );
}
    /// An EditBox; `hint` shows while it is empty and unfocused.
    // rust: fn create_field(
    // rust: &self,
    // rust: atlas: &HudAtlas,
    // rust: batch: &mut HudBatch,
    // rust: (id, value, max): (crate::clipboard::FieldId, &str, usize),
    // rust: [x, y, width]: [f32; 3],
    // rust: focused: bool,
    // rust: hint: Option<&str>,
    // rust: ) {
    // rust: let rect = [x, y, width, 20.0];
    // rust: self.caret
    // rust: .borrow_mut()
    // rust: .draw(batch, atlas, (id, value, max), rect, focused, self.started);
    // rust: crate::widgets::name_last_edit_box(|| {
    // rust: tr(if id == super::WORLD_NAME {
    // rust: "selectWorld.enterName"
    // rust: } else {
    // rust: "selectWorld.enterSeed"
    // rust: })
    // rust: });
    // rust: let field = ui::EditBox::new(x, y, width, 20.0);
    // rust: if let Some(hint) = hint
    // rust: && value.is_empty()
    // rust: && !focused
    // rust: {
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: &Text::translate(hint, &[]).with_color(crate::text::DARK_GRAY),
    // rust: field.text_x(),
    // rust: field.text_y(),
    // rust: u32::MAX,
    // rust: true,
    // rust: );
}
}
    /// The hovered widget's tooltip, wrapped to Tooltip's 170 pixels.
    // rust: pub(super) fn create_tooltip(
    // rust: &self,
    // rust: atlas: &HudAtlas,
    // rust: batch: &mut HudBatch,
    // rust: cursor: (f32, f32),
    // rust: name: &str,
    // rust: creative: bool,
    // rust: o: &WorldOptions,
    // rust: ) {
    // rust: let (w, h) = (batch.width.ceil(), batch.height.ceil());
    // rust: let (gx, gy) = grid(w, h, o.tab);
    // rust: let over = |x: f32, y: f32, width: f32| ui::hovered(cursor, x, y, width, 20.0);
    // rust: let text = match o.tab {
    // rust: 0 if over(gx + 1.0, gy + 13.0, 208.0) => Some(Text::translate(
    // rust: "selectWorld.targetFolder",
    // rust: &[Text::literal(self.target_folder(name)).italic()],
    // rust: )),
    // rust: 0 if over(gx, gy + 41.0, 210.0) => Some(Text::translate(
    // rust: &format!("{}.info", game_mode(creative, o.hardcore)),
    // rust: &[],
    // rust: )),
    // rust: 0 if over(gx, gy + 69.0, 210.0) => Some(Text::translate(
    // rust: &format!("options.difficulty.{}.info", DIFFICULTIES[o.difficulty()]),
    // rust: &[],
    // rust: )),
    // rust: 0 if over(gx, gy + 97.0, 210.0) => {
    // rust: Some(Text::translate("selectWorld.allowCommands.info", &[]))
}
            // WorldTab: the Amplified preset's help text on the type button.
    // rust: 1 if o.world_type == crate::save::WorldPreset::Amplified && over(gx, gy, 150.0) => {
    // rust: Some(Text::translate("generator.minecraft.amplified.info", &[]))
}
    // rust: 1 if over(gx + 266.0, gy + 73.0, 44.0) => {
    // rust: Some(Text::translate("selectWorld.mapFeatures.info", &[]))
}
    // rust: _ => None,
}
    // rust: if let Some(text) = text {
    // rust: ui::tooltip(batch, atlas, &atlas.font.split(&text, 170.0), cursor);
}
}
}
