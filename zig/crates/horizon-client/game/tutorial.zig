//! Transpiled from Horizon Rust crate
//! Module: horizon-client_tutorial
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Client tutorial progression (`net.minecraft.client.tutorial`).

/// The numeric values are the order in `options_file::TUTORIAL_STEPS`.
    // rust: pub(super) enum Step {
    // rust: Movement = 0,
    // rust: FindTree = 1,
    // rust: PunchTree = 2,
    // rust: OpenInventory = 3,
    // rust: CraftPlanks = 4,
    // rust: None = 5,
}

    // rust: impl Step {
    // rust: pub(super) fn from_option(value: i32) -> Self {
    // rust: match value {
    // rust: 0 => Self::Movement,
    // rust: 1 => Self::FindTree,
    // rust: 2 => Self::PunchTree,
    // rust: 3 => Self::OpenInventory,
    // rust: 4 => Self::CraftPlanks,
    // rust: _ => Self::None,
}
}
}

    // rust: pub(super) enum Hint {
    // rust: Move,
    // rust: Look,
    // rust: FindTree,
    // rust: PunchTree,
    // rust: OpenInventory,
    // rust: CraftPlanks,
    // rust: SocialInteractions,
}
    // rust: impl Hint {
    /// The hint's name, as in its `tutorial.<name>.title` key.
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Hint::Move => "move",
    // rust: Hint::Look => "look",
    // rust: Hint::FindTree => "find_tree",
    // rust: Hint::PunchTree => "punch_tree",
    // rust: Hint::OpenInventory => "open_inventory",
    // rust: Hint::CraftPlanks => "craft_planks",
    // rust: Hint::SocialInteractions => "socialInteractions",
}
}
}

/// The observations needed on the first tick of each step.
    // rust: pub(super) struct Previous {
    // rust: pub(super) tree_item: bool,
    // rust: pub(super) log: bool,
    // rust: pub(super) plank: bool,
    // rust: pub(super) mined_tree: bool,
    // rust: pub(super) crafted_plank: bool,
}

    // rust: pub(super) struct Tutorial {
    // rust: pub(super) step: Step,
    // rust: pub(super) waiting: u32,
    // rust: moved: bool,
    // rust: turned: bool,
    // rust: move_ticks: u32,
    // rust: look_ticks: u32,
    // rust: move_finished: Option<u32>,
    // rust: look_finished: bool,
    // rust: reset_count: u32,
    // rust: pub(super) break_progress: f32,
}

    // rust: impl Tutorial {
    // rust: pub(super) fn new(step: Step) -> Self {
    // rust: Self {
    // rust: step,
    // rust: waiting: 0,
    // rust: moved: false,
    // rust: turned: false,
    // rust: move_ticks: 0,
    // rust: look_ticks: 0,
    // rust: move_finished: None,
    // rust: look_finished: false,
    // rust: reset_count: 0,
    // rust: break_progress: 0.0,
}
}

    /// Returns whether the persisted step changed.
pub fn set_step(self: *Self, step: Step) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.step == step {
    // rust: return false;
}
    // rust: *self = Self::new(step);
    // rust: true
}

    // rust: pub(super) fn input(&mut self) {
    // rust: self.moved = true;
}
    // rust: pub(super) fn mouse(&mut self, x: f64, y: f64) {
    // rust: self.turned |= x.abs() > 0.01 || y.abs() > 0.01;
}

    // rust: pub(super) fn tick(&mut self, survival: bool, previous: &Previous) -> bool {
    // rust: self.waiting = self.waiting.saturating_add(1);
    // rust: if self.step == Step::Movement {
    // rust: self.move_ticks += u32::from(std::mem::take(&mut self.moved));
    // rust: self.look_ticks += u32::from(std::mem::take(&mut self.turned));
    // rust: if self.move_ticks > 40 && self.move_finished.is_none() {
    // rust: self.move_finished = Some(self.waiting);
}
    // rust: self.look_finished |= self.look_ticks > 40;
    // rust: if self.move_finished.is_some() && self.look_finished {
    // rust: return self.set_step(if survival { Step::FindTree } else { Step::None });
}
    // rust: } else if self.step != Step::None && !survival {
    // rust: return self.set_step(Step::None);
    // rust: } else if self.waiting == 1 {
    // rust: match self.step {
    // rust: Step::FindTree if previous.tree_item || previous.mined_tree => {
    // rust: return self.set_step(Step::CraftPlanks);
}
    // rust: Step::PunchTree if previous.log || previous.mined_tree => {
    // rust: return self.set_step(Step::CraftPlanks);
}
    // rust: Step::CraftPlanks if previous.plank || previous.crafted_plank => {
    // rust: return self.set_step(Step::None);
}
    // rust: _ => {}
}
}
    // rust: false
}

    // rust: pub(super) fn look_at_tree(&mut self) -> bool {
    // rust: self.step == Step::FindTree && self.set_step(Step::PunchTree)
}
    // rust: pub(super) fn destroy(&mut self, is_log: bool, progress: f32) -> bool {
    // rust: if self.step != Step::PunchTree {
    // rust: return false;
}
    // rust: if is_log && progress > 0.0 {
    // rust: self.break_progress = progress;
    // rust: if progress >= 1.0 {
    // rust: return self.set_step(Step::OpenInventory);
}
    // rust: } else {
    // rust: self.break_progress = 0.0;
    // rust: if is_log {
    // rust: self.reset_count = self.reset_count.saturating_add(1);
}
}
    // rust: false
}
    // rust: pub(super) fn open_inventory(&mut self) -> bool {
    // rust: self.step == Step::OpenInventory && self.set_step(Step::CraftPlanks)
}
    // rust: pub(super) fn get_item(&mut self, tree: bool, log: bool, plank: bool) -> bool {
    // rust: match self.step {
    // rust: Step::FindTree if tree => self.set_step(Step::CraftPlanks),
    // rust: Step::PunchTree if log => self.set_step(Step::CraftPlanks),
    // rust: Step::CraftPlanks if plank => self.set_step(Step::None),
    // rust: _ => false,
}
}
    // rust: pub(super) fn hint(&self) -> Option<(Hint, Option<f32>)> {
    // rust: match self.step {
    // rust: Step::Movement if self.waiting >= 100 && self.move_finished.is_none() => {
    // rust: Some((Hint::Move, Some(self.move_ticks as f32 / 40.0)))
}
    // rust: Step::Movement
    // rust: if !self.look_finished
    // rust: && self
    // rust: .move_finished
    // rust: .is_some_and(|t| self.waiting.saturating_sub(t) >= 20)
    // rust: && self.waiting >= 100 =>
    // rust: {
    // rust: Some((Hint::Look, Some(self.look_ticks as f32 / 40.0)))
}
    // rust: Step::FindTree if self.waiting >= 6000 => Some((Hint::FindTree, None)),
    // rust: Step::PunchTree if self.waiting >= 600 || self.reset_count > 3 => {
    // rust: Some((Hint::PunchTree, Some(self.break_progress)))
}
    // rust: Step::OpenInventory if self.waiting >= 600 => Some((Hint::OpenInventory, None)),
    // rust: Step::CraftPlanks if self.waiting >= 1200 => Some((Hint::CraftPlanks, None)),
    // rust: _ => None,
}
}
}

    // rust: impl super::Game<'_> {
    /// `Tutorial.setStep` persists immediately so it survives leaving a world.
    // rust: pub(super) fn persist_tutorial_step(&mut self) {
    // rust: self.settings.file.set(
    // rust: "tutorialStep",
    // rust: horizon_client::options_file::V::Int(self.tutorial.step as i32),
    // rust: );
    // rust: self.settings.save(&Self::options_path());
}
}

    // rust: impl super::Game<'_> {
    // rust: pub(super) fn reset_tutorial(&mut self) {
    // rust: self.tutorial = Tutorial::new(Step::from_option(self.settings.file.int("tutorialStep")));
    // rust: self.tutorial_toasts.clear();
}

pub fn tutorial_tagged(self: *Self, item: bool, tag: []const u8, id: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let items = self.res.items();
    // rust: let tags = if item {
    // rust: &items.item_tags
    // rust: } else {
    // rust: &items.block_tags
}
    // rust: tags.get(tag).is_some_and(|members| members.contains(id))
}

    // rust: pub(super) fn tutorial_get_item(&mut self, stack: Option<&horizon_client::items::ItemStack>) {
        // The server thread's settings are a stale copy of the window's: a
        // guest's tutorial is their own client's to record.
    // rust: if self.options.dedicated.is_some()
    // rust: || self.serving.is_some()
    // rust: || self.lan_acting.is_some()
    // rust: || self.title.is_some()
    // rust: || self.player.is_none()
    // rust: {
    // rust: return;
}
    // rust: let Some(stack) = stack else { return };
    // rust: let id = &*stack.item;
    // rust: let tree = self.tutorial_tagged(true, "minecraft:completes_find_tree_tutorial", id);
    // rust: let log = self.tutorial_tagged(true, "minecraft:logs", id);
    // rust: let plank = self.tutorial_tagged(true, "minecraft:planks", id);
    // rust: if self.tutorial.get_item(tree, log, plank) {
    // rust: self.persist_tutorial_step();
}
}

    // rust: pub(super) fn tutorial_destroy(
    // rust: &mut self,
    // rust: state: horizon_world::registry::BlockStateId,
    // rust: progress: f32,
    // rust: ) {
        // The server thread's settings are a stale copy of the window's: a
        // guest's tutorial is their own client's to record.
    // rust: if self.options.dedicated.is_some()
    // rust: || self.serving.is_some()
    // rust: || self.lan_acting.is_some()
    // rust: || self.title.is_some()
    // rust: || self.player.is_none()
    // rust: {
    // rust: return;
}
    // rust: let name = &self.res.facts().get(state).name;
    // rust: let is_log = self.tutorial_tagged(false, "minecraft:logs", name);
    // rust: if self.tutorial.destroy(is_log, progress) {
    // rust: self.persist_tutorial_step();
}
}

    // rust: pub(super) fn tick_tutorial(&mut self) {
//         use horizon_client::actions::Action;
    // rust: if self.title.is_some()
    // rust: || self.player.is_none()
    // rust: || self.options.dedicated.is_some()
    // rust: || self.serving.is_some()
    // rust: {
    // rust: return;
}
        // Minecraft.tick: also show this in a single-player world once it is
        // published to LAN, but not merely because its client uses memory networking.
    // rust: if !self.settings.file.bool("joinedFirstServer")
    // rust: && (!self.has_singleplayer_server() || self.is_published())
    // rust: {
            // ToastManager.addToast: a mod may cancel it; the hint is still
            // spent (`joinedFirstServer`), as vanilla sets it either way.
    // rust: if self.toast_allowed("tutorial", Hint::SocialInteractions.name()) {
    // rust: let toast = self.tutorial_toast(Hint::SocialInteractions, Some(0.0));
    // rust: self.tutorial_toasts.push(toast);
}
    // rust: self.settings.file.set(
    // rust: "joinedFirstServer",
    // rust: horizon_client::options_file::V::Bool(true),
    // rust: );
    // rust: self.settings.save(&Self::options_path());
}
    // rust: if self.screen == super::Screen::Playing
    // rust: && ([
    // rust: Action::Forward,
    // rust: Action::Left,
    // rust: Action::Back,
    // rust: Action::Right,
    // rust: Action::Jump,
    // rust: ]
    // rust: .into_iter()
    // rust: .any(|action| self.keys.held(action))
    // rust: || self
    // rust: .pad_move()
    // rust: .is_some_and(|[left, forward]| left.abs() > 0.3 || forward.abs() > 0.3))
    // rust: {
    // rust: self.tutorial.input();
}
    // rust: let items = self.res.items();
    // rust: let in_tag =
    // rust: |tag: &str, id: &str| items.item_tags.get(tag).is_some_and(|set| set.contains(id));
    // rust: let mut previous = Previous::default();
    // rust: if self.tutorial.waiting == 0 && !matches!(self.tutorial.step, Step::Movement | Step::None)
    // rust: {
    // rust: for stack in self
    // rust: .inventory
    // rust: .iter()
    // rust: .chain(self.armor.iter())
    // rust: .flatten()
    // rust: .chain(self.offhand.iter())
    // rust: {
    // rust: previous.tree_item |= in_tag("minecraft:completes_find_tree_tutorial", &stack.item);
    // rust: previous.log |= in_tag("minecraft:logs", &stack.item);
    // rust: previous.plank |= in_tag("minecraft:planks", &stack.item);
}
    // rust: if let Some(mined) = self.stats.values.get("minecraft:mined")
    // rust: && let Some(tree) = items
    // rust: .block_tags
    // rust: .get("minecraft:completes_find_tree_tutorial")
    // rust: {
    // rust: previous.mined_tree = mined
    // rust: .iter()
    // rust: .any(|(id, count)| *count > 0 && tree.contains(id));
}
    // rust: if let Some(crafted) = self.stats.values.get("minecraft:crafted")
    // rust: && let Some(planks) = items.item_tags.get("minecraft:planks")
    // rust: {
    // rust: previous.crafted_plank = crafted
    // rust: .iter()
    // rust: .any(|(id, count)| *count > 0 && planks.contains(id));
}
}
    // rust: let survival = self.mode == horizon_client::command::args::GameMode::Survival;
    // rust: if self.tutorial.tick(survival, &previous) {
    // rust: self.persist_tutorial_step();
}
    // rust: if self.tutorial.step == Step::FindTree
    // rust: && self.pick_entity_hit().is_none()
    // rust: && let Some(hit) = self.pick()
    // rust: {
    // rust: let name = &self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(hit.pos[0], hit.pos[1], hit.pos[2]))
    // rust: .name;
    // rust: if self.tutorial_tagged(false, "minecraft:completes_find_tree_tutorial", name)
    // rust: && self.tutorial.look_at_tree()
    // rust: {
    // rust: self.persist_tutorial_step();
}
}
}
}

    // rust: pub(super) struct HintToast {
    // rust: hint: Hint,
    // rust: lines: Vec<(horizon_client::text::Text, bool)>,
    // rust: title_lines: usize,
    // rust: progress: Option<f32>,
    // rust: smooth: f32,
    // rust: last_smooth: i64,
    // rust: wanted: bool,
    // rust: slot: Option<usize>,
    // rust: slots: usize,
    // rust: slide: horizon_client::toasts::Slide,
    /// A mod cancelled it (`ToastAddEvent`): it never takes a slot, and
    /// stays only so the hint isn't offered again while it lasts.
    // rust: cancelled: bool,
}

    // rust: impl super::Game<'_> {
    // rust: pub(super) fn hide_social_tutorial(&mut self) {
    // rust: for toast in &mut self.tutorial_toasts {
    // rust: if toast.hint == Hint::SocialInteractions {
    // rust: toast.wanted = false;
}
}
}

    // rust: pub(super) fn tutorial_toast_slots(&self) -> u32 {
    // rust: self.tutorial_toasts
    // rust: .iter()
    // rust: .filter_map(|t| t.slot.map(|s| ((1u32 << t.slots) - 1) << s))
    // rust: .fold(0, |a, b| a | b)
}

pub fn tutorial_toast(self: *Self, hint: Hint, progress: ?f32) H {
    // Implementation ported from Horizon
    return undefined;
}
//         use horizon_client::{keybinds, text::Text};
    // rust: let key = |mapping: &str| keybinds::display_name(self.settings.keys.get(mapping)).plain();
    // rust: let (title_key, fallback, description_key, description, icon_args) = match hint {
    // rust: Hint::Move => (
    // rust: "tutorial.move.title",
    // rust: "Move with %1$s, %2$s, %3$s, %4$s",
    // rust: "tutorial.move.description",
    // rust: "Jump with %1$s",
    // rust: vec![
    // rust: key("key.forward"),
    // rust: key("key.left"),
    // rust: key("key.back"),
    // rust: key("key.right"),
    // rust: ],
    // rust: ),
    // rust: Hint::Look => (
    // rust: "tutorial.look.title",
    // rust: "Look around",
    // rust: "tutorial.look.description",
    // rust: "Use your mouse to turn",
    // rust: vec![],
    // rust: ),
    // rust: Hint::FindTree => (
    // rust: "tutorial.find_tree.title",
    // rust: "Find a tree",
    // rust: "tutorial.find_tree.description",
    // rust: "Punch it to collect wood",
    // rust: vec![],
    // rust: ),
    // rust: Hint::PunchTree => (
    // rust: "tutorial.punch_tree.title",
    // rust: "Punch the tree",
    // rust: "tutorial.punch_tree.description",
    // rust: "Hold %1$s to break",
    // rust: vec![],
    // rust: ),
    // rust: Hint::OpenInventory => (
    // rust: "tutorial.open_inventory.title",
    // rust: "Open inventory",
    // rust: "tutorial.open_inventory.description",
    // rust: "Press %1$s",
    // rust: vec![],
    // rust: ),
    // rust: Hint::SocialInteractions => (
    // rust: "tutorial.socialInteractions.title",
    // rust: "Social Interactions",
    // rust: "tutorial.socialInteractions.description",
    // rust: "Press %1$s to open social interactions",
    // rust: vec![],
    // rust: ),
    // rust: Hint::CraftPlanks => (
    // rust: "tutorial.craft_planks.title",
    // rust: "Craft wooden planks",
    // rust: "tutorial.craft_planks.description",
    // rust: "The recipe book can help",
    // rust: vec![],
    // rust: ),
}
    // rust: let substitute = |mut text: String, values: &[String]| {
    // rust: for (i, value) in values.iter().enumerate() {
    // rust: text = text.replace(&format!("%{}$s", i + 1), value);
    // rust: text = text.replacen("%s", value, 1);
}
    // rust: text
}
    // rust: let title = substitute(self.translate(title_key, fallback), &icon_args);
    // rust: let desc_args = match hint {
    // rust: Hint::Move => vec![key("key.jump")],
    // rust: Hint::PunchTree => vec![key("key.attack")],
    // rust: Hint::OpenInventory => vec![key("key.inventory")],
    // rust: Hint::SocialInteractions => vec![key("key.socialInteractions")],
    // rust: _ => vec![],
}
    // rust: let description = substitute(self.translate(description_key, description), &desc_args);
    // rust: let font = &self.gui.atlas.font;
    // rust: let mut lines = font.split_lines(&Text::literal(title), 126.0);
    // rust: let title_lines = lines.len();
    // rust: lines.extend(font.split_lines(&Text::literal(description), 126.0));
    // rust: let height = 10 + 11 * lines.len().max(2);
    // rust: let slots = height.div_ceil(32);
    // rust: HintToast {
    // rust: hint,
    // rust: lines,
    // rust: title_lines,
    // rust: progress,
    // rust: smooth: 0.0,
    // rust: last_smooth: 0,
    // rust: wanted: true,
    // rust: slot: None,
    // rust: slots,
    // rust: slide: Default::default(),
    // rust: cancelled: false,
}
}

    // rust: pub(super) fn draw_tutorial_toasts(
    // rust: &mut self,
    // rust: batch: &mut horizon_client::hud::HudBatch,
    // rust: hidden: bool,
    // rust: ) {
    // rust: let wanted = self.tutorial.hint();
    // rust: for t in &mut self.tutorial_toasts {
    // rust: if t.hint == Hint::SocialInteractions {
    // rust: continue;
}
    // rust: t.wanted = wanted.is_some_and(|(hint, _)| hint == t.hint);
    // rust: if t.wanted {
    // rust: t.progress = wanted.and_then(|(_, progress)| progress);
}
}
    // rust: if let Some((hint, progress)) = wanted
    // rust: && !self
    // rust: .tutorial_toasts
    // rust: .iter()
    // rust: .any(|t| t.wanted && t.hint == hint)
    // rust: {
    // rust: let cancelled = !self.toast_allowed("tutorial", hint.name());
    // rust: let toast = self.tutorial_toast(hint, progress);
    // rust: self.tutorial_toasts.push(HintToast { cancelled, ..toast });
}
    // rust: let mut used = self.toast_slots_used();
    // rust: for t in &mut self.tutorial_toasts {
    // rust: if t.slot.is_none() && t.wanted && !t.cancelled && t.slots <= Self::TOAST_SLOTS {
    // rust: let mask = (1u32 << t.slots) - 1;
    // rust: if let Some(slot) =
    // rust: (0..=Self::TOAST_SLOTS - t.slots).find(|s| used & (mask << s) == 0)
    // rust: {
    // rust: t.slot = Some(slot);
    // rust: used |= mask << slot;
}
}
}
    // rust: let atlas = &self.gui.atlas;
    // rust: let mut i = 0;
    // rust: while i < self.tutorial_toasts.len() {
    // rust: let t = &mut self.tutorial_toasts[i];
    // rust: if t.slot.is_none() {
    // rust: if !t.wanted {
    // rust: self.tutorial_toasts.remove(i);
    // rust: } else {
    // rust: i += 1;
}
    // rust: continue;
}
    // rust: let (sound, finished) = t.slide.update_now(|fully| {
    // rust: t.wanted && (t.hint != Hint::SocialInteractions || social_hint_progress(fully).0)
    // rust: });
    // rust: if let Some(show) = sound {
    // rust: let event = if show { "ui.toast.in" } else { "ui.toast.out" };
    // rust: self.audio
    // rust: .play(&format!("minecraft:{event}"), None, 1.0, 1.0);
}
    // rust: if finished {
    // rust: self.tutorial_toasts.remove(i);
    // rust: continue;
}
    // rust: if t.hint == Hint::SocialInteractions {
    // rust: let (_, progress) = social_hint_progress(t.slide.fully_for);
    // rust: t.progress = Some(progress);
    // rust: t.smooth = progress;
    // rust: } else if let Some(progress) = t.progress {
    // rust: let delta = ((t.slide.fully_for - t.last_smooth) as f32 / 100.0).clamp(0.0, 1.0);
    // rust: t.smooth += (progress - t.smooth) * delta;
    // rust: t.last_smooth = t.slide.fully_for;
}
    // rust: if !hidden {
    // rust: let height = (10 + 11 * t.lines.len().max(2)) as f32;
    // rust: let x = batch.width - 160.0 * t.slide.portion;
    // rust: let y = 32.0 * t.slot.unwrap_or_default() as f32;
    // rust: horizon_client::ui::nine_slice(
    // rust: batch,
    // rust: atlas,
    // rust: "gui/sprites/toast/tutorial",
    // rust: x,
    // rust: y,
    // rust: 160.0,
    // rust: height,
    // rust: u32::MAX,
    // rust: );
    // rust: let icon = match t.hint {
    // rust: Hint::Move => "movement_keys",
    // rust: Hint::Look => "mouse",
    // rust: Hint::FindTree | Hint::PunchTree => "tree",
    // rust: Hint::OpenInventory => "recipe_book",
    // rust: Hint::CraftPlanks => "wooden_planks",
    // rust: Hint::SocialInteractions => "social_interactions",
}
    // rust: batch.sprite_scaled(
    // rust: atlas,
    // rust: &format!("gui/sprites/toast/{icon}"),
    // rust: x + 6.0,
    // rust: y + 6.0,
    // rust: 20.0,
    // rust: 20.0,
    // rust: u32::MAX,
    // rust: );
    // rust: let text_y = y + 7.0 + ((t.lines.len().max(2) - t.lines.len()) * 11) as f32 / 2.0;
    // rust: for (n, (line, _)) in t.lines.iter().enumerate() {
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: line,
    // rust: x + 30.0,
    // rust: text_y + 11.0 * n as f32,
    // rust: if n < t.title_lines {
    // rust: 0xFF50_0050
    // rust: } else {
    // rust: 0xFF00_0000
    // rust: },
    // rust: false,
    // rust: );
}
    // rust: if let Some(progress) = t.progress {
    // rust: batch.fill(atlas, x + 3.0, y + height - 4.0, 154.0, 1.0, u32::MAX);
    // rust: let color = if progress >= t.smooth {
    // rust: 0xFF00_5500
    // rust: } else {
    // rust: 0xFF55_0000
}
    // rust: batch.fill(
    // rust: atlas,
    // rust: x + 3.0,
    // rust: y + height - 4.0,
    // rust: 154.0 * t.smooth.clamp(0.0, 1.0),
    // rust: 1.0,
    // rust: color,
    // rust: );
}
}
    // rust: i += 1;
}
}
}

/// TutorialToast.update uses the time fully visible (not the slide-in time),
/// and hides only after 8000 ms. Its timed bar does not use progress smoothing.
pub fn social_hint_progress(fully_visible_ms: i64) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (
    // rust: fully_visible_ms <= 8000,
    // rust: (fully_visible_ms as f32 / 8000.0).min(1.0),
    // rust: )
}

    // rust: mod tests {
//     use super::*;

pub fn social_hint_fills_for_eight_seconds_before_hiding() void {
}
    // rust: assert_eq!(social_hint_progress(0), (true, 0.0));
    // rust: assert_eq!(social_hint_progress(4000), (true, 0.5));
    // rust: assert_eq!(social_hint_progress(8000), (true, 1.0));
    // rust: assert_eq!(social_hint_progress(8001), (false, 1.0));
}

pub fn social_hint_counts_from_full_visibility_and_finishes_sliding_out() void {
}
    // rust: let mut slide = horizon_client::toasts::Slide::default();
    // rust: for (now, visible) in [(0, true), (600, true), (8600, true), (8601, false)] {
    // rust: let (_, finished) = slide.update(now, |fully| social_hint_progress(fully).0);
    // rust: assert!(!finished);
    // rust: assert_eq!(social_hint_progress(slide.fully_for).0, visible);
}
    // rust: let (_, finished) = slide.update(9202, |fully| social_hint_progress(fully).0);
    // rust: assert!(finished);
}

pub fn craft_planks_hint_toast_appears_after_delay_and_clears_on_planks() void {
}
    // rust: let mut tutorial = Tutorial::new(Step::CraftPlanks);
    // rust: tutorial.waiting = 1199;
    // rust: assert_eq!(tutorial.hint(), None);

    // rust: tutorial.waiting = 1200;
    // rust: assert_eq!(tutorial.hint(), Some((Hint::CraftPlanks, None)));

        // Receiving an unrelated item (e.g. log or stick) does not complete the step
    // rust: let changed = tutorial.get_item(false, true, false);
    // rust: assert!(!changed);
    // rust: assert_eq!(tutorial.step, Step::CraftPlanks);
    // rust: assert_eq!(tutorial.hint(), Some((Hint::CraftPlanks, None)));

        // Receiving planks completes the tutorial step and dismisses the hint toast
    // rust: let changed = tutorial.get_item(false, false, true);
    // rust: assert!(changed);
    // rust: assert_eq!(tutorial.step, Step::None);
    // rust: assert_eq!(tutorial.hint(), None);
}

pub fn initial_tick_with_planks_clears_craft_planks_step() void {
}
    // rust: let mut tutorial = Tutorial::new(Step::CraftPlanks);
    // rust: let previous = Previous {
    // rust: plank: true,
    // rust: ..Default::default()
}
    // rust: assert!(tutorial.tick(true, &previous));
    // rust: assert_eq!(tutorial.step, Step::None);
    // rust: assert_eq!(tutorial.hint(), None);
}
}
