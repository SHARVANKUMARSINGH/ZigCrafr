//! Transpiled from Horizon Rust crate
package horizon_client_beacon

import "core:fmt"
import "core:mem"
import "core:math"

// Beacons (`BeaconBlockEntity`, `BeaconMenu`, `BeaconScreen`,
// `BeaconRenderer`): the beam sections tinted by stained glass, the pyramid
// levels every 80 ticks, the primary/secondary effects for players in
// range, the activate/ambient/deactivate sounds, the 230x219 menu with its
// power buttons and payment slot, and the rotating, scrolling beam.
// use super::{
    // rust: Game,
    // rust: stations::{INPUT, Kind},
}
// use horizon_client::{
    // rust: containers::{Beacon, BlockEntity},
    // rust: effects::EffectInstance,
    // rust: hud::{HudBatch, rgba},
    // rust: items::ItemStack,
    // rust: mesher::Vertex,
    // rust: mobs::render::{DYE, DYE_NAMES},
    // rust: test_instance_block::Status,
}
// use horizon_protocol::packets::play::{self, Serverbound as S};

// The beacon screen is 54 px wider than the 176-px menus it shares an origin with.
    // rust: pub(super) const SHIFT: f32 = -27.0;
    // rust: pub(super) const HEIGHT: f32 = 219.0;
// `BEACON_EFFECTS` in order, with the pyramid level each needs.
    // rust: pub(super) const EFFECTS: [(&str, i32); 6] = [
    // rust: ("speed", 1),
    // rust: ("haste", 1),
    // rust: ("resistance", 2),
    // rust: ("jump_boost", 2),
    // rust: ("strength", 3),
    // rust: ("regeneration", 4),
    // rust: ];
    // rust: const PAYMENT: [&str; 5] = [
    // rust: "minecraft:iron_ingot",
    // rust: "minecraft:gold_ingot",
    // rust: "minecraft:emerald",
    // rust: "minecraft:diamond",
    // rust: "minecraft:netherite_ingot",
    // rust: ];
// `BeaconMenu.PaymentSlot` and the player inventory, relative to the 176 origin.
    // rust: pub(super) fn slot_position(i: usize) -> Option<(f32, f32)> {
    // rust: Some(match i {
    // rust: 0..9 => (36.0 + SHIFT + i as f32 * 18.0, 195.0),
    // rust: 9..36 => (
    // rust: 36.0 + SHIFT + ((i - 9) % 9) as f32 * 18.0,
    // rust: 137.0 + ((i - 9) / 9) as f32 * 18.0,
    // rust: ),
    // rust: INPUT => (136.0 + SHIFT, 110.0),
    // rust: _ => return None,
    // rust: })
}
// A power button: (effect index, x, y, primary) relative to the beacon's left edge.
buttons :: proc() -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::new();
    // rust: let tiers: [&[usize]; 3] = [&[0, 1], &[2, 3], &[4]];
    // rust: for (tier, effects) in tiers.iter().enumerate() {
    // rust: let count = effects.len() as i32;
    // rust: let total = count * 22 + (count - 1) * 2;
    // rust: for (c, &e) in effects.iter().enumerate() {
    // rust: let x = 76 + c as i32 * 24 - total / 2;
    // rust: out.push((e, x as f32, 22.0 + tier as f32 * 25.0, true));
}
}
    // Tier 4: regeneration, then the upgrade (primary II) button.
    // rust: let total = 2 * 22 + 2;
    // rust: out.push((5, (167 - total / 2) as f32, 47.0, false));
    // rust: out
}
upgrade_button :: proc() -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let total = 2 * 22 + 2;
    // rust: ((167 + 24 - total / 2) as f32, 47.0)
}
inside :: proc(p: (f32) {
}
    // rust: p.0 >= x && p.1 >= y && p.0 < x + w && p.1 < y + h
}
effect_id :: proc(name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let n = name.strip_prefix("minecraft:").unwrap_or(name);
    // rust: EFFECTS.iter().map(|(e, _)| *e).find(|e| *e == n)
}
// `ARGB.average`.
average :: proc(a: u32, b: u32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let ch = |c: u32, s: u32| (c >> s) & 255;
    // rust: [16, 8, 0]
    // rust: .iter()
    // rust: .fold(0, |acc, &s| acc | ((ch(a, s) + ch(b, s)) / 2) << s)
}
    // rust: impl Game<'_> {
    // `TestInstanceBlockEntity.getBeamSections`: grey while running, green
    // for a pass, red for a failed required test and orange for an optional
    // one; each section is one block tall and the last runs to the sky.
test_instance_beam :: proc(self: ^Self, e: ^BlockEntity) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let BlockEntity::TestInstanceBlock(b) = e else {
    // rust: return None;
}
    // rust: let color = match b.data.status {
    // rust: Status::Cleared => return None,
    // rust: Status::Running => 0x80_8080,
    // rust: Status::Finished if b.data.error_message.is_none() => 0x00_FF00,
    // rust: Status::Finished => {
    // rust: let required = b
    // rust: .data
    // rust: .test
    // rust: .as_deref()
    // rust: .and_then(|key| self.test_def(key))
    // rust: .is_none_or(|t| t.required);
    // rust: if required { 0xFF_0000 } else { 0xFF_8000 }
}
}
    // rust: Some(vec![(color, 1)])
}

    // The beam color of a `BeaconBeamBlock` (stained glass and panes, the beacon).
beam_color :: proc(self: ^Self, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if name == "minecraft:beacon" {
    // rust: return Some(DYE[0]);
}
    // rust: let n = name.strip_prefix("minecraft:")?;
    // rust: let dye = n
    // rust: .strip_suffix("_stained_glass")
    // rust: .or_else(|| n.strip_suffix("_stained_glass_pane"))?;
    // rust: DYE_NAMES.iter().position(|d| *d == dye).map(|i| DYE[i])
}
    // `getHeight(WORLD_SURFACE)`: above the highest non-air block.
    // rust: pub(super) fn world_surface(&self, x: i32, z: i32) -> i32 {
    // rust: self.world
    // rust: .world_surface(x, z, |id| self.res.facts().is_air(id))
}
    // `BeaconBlockEntity.tick` of the beacon at `key`.
    // rust: pub(super) fn tick_beacon_at(&mut self, key: (i32, i32, i32)) {
    // rust: let Some(BlockEntity::Beacon(mut b)) = self.world.block_entities.take(&key) else {
    // rust: return;
}
    // rust: let previous = b.levels;
    // rust: self.tick_beacon(key, &mut b, false);
    // rust: let current = b.levels;
    // rust: self.world.block_entities.put(key, BlockEntity::Beacon(b));
    // rust: if (previous == 0) != (current == 0) {
    // rust: self.native_beacon_state_change(self.dim.id(), [key.0, key.1, key.2], current > 0);
}
}
    // `ClientLevel.tickBlockEntities` for beacons: a server's chunk data
    // carries no beam sections, so the client builds them too; effects,
    // sounds and the advancement stay with the server.
    // rust: pub(super) fn client_tick_beacons(&mut self) {
    // rust: let keys: Vec<_> = self
    // rust: .world
    // rust: .block_entities
    // rust: .iter()
    // rust: .filter_map(|(k, e)| matches!(e, BlockEntity::Beacon(_)).then_some(*k))
    // rust: .collect();
    // rust: for key in keys {
    // rust: let Some(BlockEntity::Beacon(mut b)) = self.world.block_entities.take(&key) else {
    // rust: continue;
}
    // rust: self.tick_beacon(key, &mut b, true);
    // rust: self.world.block_entities.put(key, BlockEntity::Beacon(b));
}
}
tick_beacon :: proc(self: ^Self) {
}
    // rust: let mut check = if b.last_check_y < y {
    // rust: b.checking.clear();
    // rust: b.last_check_y = y - 1;
    // rust: y
    // rust: } else {
    // rust: b.last_check_y + 1
}
    // rust: let surface = self.world_surface(x, z);
    // rust: let mut i = 0;
    // rust: while i < 10 && check <= surface {
    // rust: let state = self.world.block(x, check, z);
    // rust: let f = self.res.facts().get(state);
    // rust: if let Some(color) = self.beam_color(&f.name) {
    // rust: if b.checking.len() <= 1 {
    // rust: b.checking.push((color, 1));
    // rust: } else if let Some(last) = b.checking.last_mut() {
    // rust: if color == last.0 {
    // rust: last.1 += 1;
    // rust: } else {
    // rust: let mixed = average(last.0, color);
    // rust: b.checking.push((mixed, 1));
}
}
    // rust: } else {
    // rust: let Some(last) = b
    // rust: .checking
    // rust: .last_mut()
    // rust: .filter(|_| f.dampening < 15 || &*f.name == "minecraft:bedrock")
    // rust: else {
    // rust: b.checking.clear();
    // rust: b.last_check_y = surface;
    // rust: break;
}
    // rust: last.1 += 1;
}
    // rust: check += 1;
    // rust: b.last_check_y += 1;
    // rust: i += 1;
}
    // rust: let previous = b.levels;
    // rust: if self.world.game_time % 80 == 0 {
    // rust: if !b.sections.is_empty() {
    // rust: b.levels = self.beacon_base(x, y, z);
}
    // rust: if !client && b.levels > 0 && !b.sections.is_empty() {
    // rust: self.beacon_effects([x, y, z], b);
    // rust: self.beacon_sound([x, y, z], "minecraft:block.beacon.ambient");
}
}
    // rust: if b.last_check_y >= surface {
    // rust: b.last_check_y = self.world.bottom_y() - 1;
    // rust: b.sections = std::mem::take(&mut b.checking);
    // rust: let (was, is) = (previous > 0, b.levels > 0);
    // rust: if !was && is {
    // rust: if !client {
    // rust: self.beacon_sound([x, y, z], "minecraft:block.beacon.activate");
    // rust: let levels = b.levels;
    // rust: self.for_each_player(|g| g.beacon_constructed([x, y, z], levels));
}
    // rust: } else if was && !is && !client {
    // rust: self.beacon_sound([x, y, z], "minecraft:block.beacon.deactivate");
}
}
}
    // `BeaconBlockEntity.tick` after activating: `CONSTRUCT_BEACON` for a
    // player in the box `AABB(x, y, z, x, y - 4, z).inflate(10, 5, 10)`.
beacon_constructed :: proc(self: ^Self, p: [i32; 3], levels: i32) {
}
    // rust: let Some(bb) = self
    // rust: .player
    // rust: .as_ref()
    // rust: .map(|pl| pl.dimensions.bounds(pl.position))
    // rust: else {
    // rust: return;
}
    // rust: let (lo, hi) = (bb.min_position(), bb.max_position());
    // rust: let [x, y, z] = p.map(f64::from);
    // rust: if lo.x < x + 10.0
    // rust: && hi.x > x - 10.0
    // rust: && lo.y < y + 5.0
    // rust: && hi.y > y - 9.0
    // rust: && lo.z < z + 10.0
    // rust: && hi.z > z - 10.0
    // rust: {
    // rust: self.trigger_construct_beacon(levels);
}
}
    // rust: pub(super) fn beacon_sound(&mut self, p: [i32; 3], sound: &str) {
    // rust: let at = [
    // rust: f64::from(p[0]) + 0.5,
    // rust: f64::from(p[1]) + 0.5,
    // rust: f64::from(p[2]) + 0.5,
    // rust: ];
    // rust: self.audio.play(sound, Some(at), 1.0, 1.0);
}
    // `updateBase`: complete layers of `beacon_base_blocks` below.
beacon_base :: proc(self: ^Self, x: i32, y: i32, z: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let base = self
    // rust: .res
    // rust: .items()
    // rust: .block_tags
    // rust: .get("minecraft:beacon_base_blocks");
    // rust: let mut levels = 0;
    // rust: for step in 1..=4 {
    // rust: let ly = y - step;
    // rust: if ly < self.world.bottom_y() {
    // rust: break;
}
    // rust: let ok = (x - step..=x + step).all(|lx| {
    // rust: (z - step..=z + step).all(|lz| {
    // rust: let name = &self.res.facts().get(self.world.block(lx, ly, lz)).name;
    // rust: base.is_some_and(|t| t.contains(&**name))
    // rust: })
    // rust: });
    // rust: if !ok {
    // rust: break;
}
    // rust: levels = step;
}
    // rust: levels
}
    // `applyEffects`: the powers for players within `levels * 10 + 10` (any height above).
    // `BeaconBlockEntity.applyEffects`: every player in range.
beacon_effects :: proc(self: ^Self, p: [i32; 3], b: ^Beacon) {
}
    // rust: self.for_each_player(|g| g.beacon_effects_on_player(p, b));
}
beacon_effects_on_player :: proc(self: ^Self, p: [i32; 3], b: ^Beacon) {
}
    // rust: let Some(primary) = b.primary.as_deref().and_then(effect_id) else {
    // rust: return;
}
    // rust: let range = f64::from(b.levels * 10 + 10);
    // rust: let Some(pp) = self.player.as_ref().map(|p| p.position) else {
    // rust: return;
}
    // rust: let inside = pp.x >= f64::from(p[0]) - range
    // rust: && pp.x <= f64::from(p[0] + 1) + range
    // rust: && pp.z >= f64::from(p[2]) - range
    // rust: && pp.z <= f64::from(p[2] + 1) + range
    // rust: && pp.y >= f64::from(p[1]) - range;
    // rust: if !inside {
    // rust: return;
}
    // rust: let secondary = b.secondary.as_deref().and_then(effect_id);
    // rust: let amplifier = i32::from(b.levels >= 4 && secondary == Some(primary));
    // rust: let duration = (9 + b.levels * 2) * 20;
    // rust: let ambient = |id, amp| EffectInstance {
    // rust: ambient: true,
    // rust: ..EffectInstance::new(id, duration, amp)
}
    // rust: self.potions.effects.add(ambient(primary, amplifier));
    // rust: if let Some(s) = secondary.filter(|&s| b.levels >= 4 && s != primary) {
    // rust: self.potions.effects.add(ambient(s, 0));
}
}
    // Opening the menu shows the beacon's current powers.
    // rust: pub(super) fn beacon_opened(&mut self) {
    // rust: let Some(s) = self.station.as_ref().filter(|s| s.kind == Kind::Beacon) else {
    // rust: return;
}
    // rust: let pos = s.pos;
    // rust: let (p, sec) = match self.world.block_entities.get(&(pos[0], pos[1], pos[2])) {
    // rust: Some(BlockEntity::Beacon(b)) => (b.primary.clone(), b.secondary.clone()),
    // rust: _ => (None, None),
}
    // rust: let index =
    // rust: |e: Option<String>| e.and_then(|e| EFFECTS.iter().position(|(n, _)| e.ends_with(n)));
    // rust: if let Some(s) = self.station.as_mut() {
    // rust: s.beacon = [index(p), index(sec)];
}
}
beacon_levels :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let Some(s) = self.station.as_ref() else {
    // rust: return 0;
}
    // rust: if let Some(levels) = s.beacon_levels {
    // rust: return levels;
}
    // rust: let pos = s.pos;
    // rust: match self.world.block_entities.get(&(pos[0], pos[1], pos[2])) {
    // rust: Some(BlockEntity::Beacon(b)) => b.levels,
    // rust: _ => 0,
}
}
    // Clicks on the power, confirm and cancel buttons.
    // The effect, upgrade, confirm and cancel buttons a controller can
    // focus (GUI origin relative).
    // rust: pub(super) fn beacon_targets(&self) -> Vec<[f32; 4]> {
    // rust: let (ux, uy) = upgrade_button();
    // rust: buttons()
    // rust: .into_iter()
    // rust: .map(|(_, x, y, _)| (x, y))
    // rust: .chain([(ux, uy), (164.0, 107.0), (190.0, 107.0)])
    // rust: .map(|(x, y)| [x + SHIFT, y, 22.0, 22.0])
    // rust: .collect()
}
    // rust: pub(super) fn beacon_click(&mut self, local: (f32, f32)) -> bool {
    // rust: let l = (local.0 - SHIFT, local.1);
    // rust: let levels = self.beacon_levels();
    // rust: let Some(sel) = self.station.as_ref().map(|s| s.beacon) else {
    // rust: return false;
}
    // rust: for (e, x, y, primary) in buttons() {
    // rust: if !inside(l, x, y, 22.0, 22.0) {
    // rust: continue;
}
    // rust: let tier = EFFECTS[e].1;
    // rust: let selected = if primary {
    // rust: sel[0] == Some(e)
    // rust: } else {
    // rust: sel[1] == Some(e)
}
    // rust: if tier <= levels.min(if primary { 3 } else { 4 })
    // rust: && !selected
    // rust: && (primary || levels >= 4)
    // rust: {
    // rust: if let Some(s) = self.station.as_mut() {
    // rust: if primary {
    // rust: s.beacon[0] = Some(e);
    // rust: if s.beacon[1] != Some(e) {
    // rust: s.beacon[1] = None;
}
    // rust: } else {
    // rust: s.beacon[1] = Some(e);
}
}
    // rust: self.audio
    // rust: .play("minecraft:ui.button.click", None, 0.25, 1.0);
}
    // rust: return true;
}
    // rust: let (ux, uy) = upgrade_button();
    // rust: if inside(l, ux, uy, 22.0, 22.0) {
    // rust: if levels >= 4
    // rust: && let Some(p) = sel[0]
    // rust: && sel[1] != Some(p)
    // rust: && let Some(s) = self.station.as_mut()
    // rust: {
    // rust: s.beacon[1] = Some(p);
    // rust: self.audio
    // rust: .play("minecraft:ui.button.click", None, 0.25, 1.0);
}
    // rust: return true;
}
    // rust: if inside(l, 164.0, 107.0, 22.0, 22.0) {
    // rust: let paid = self.station.as_ref().is_some_and(|s| s.inputs[0].is_some());
    // rust: if paid && sel[0].is_some() {
    // rust: self.audio
    // rust: .play("minecraft:ui.button.click", None, 0.25, 1.0);
    // rust: self.confirm_beacon(sel);
    // rust: self.close_beacon_screen();
}
    // rust: return true;
}
    // rust: if inside(l, 190.0, 107.0, 22.0, 22.0) {
    // rust: self.audio
    // rust: .play("minecraft:ui.button.click", None, 0.25, 1.0);
    // rust: self.close_beacon_screen();
    // rust: return true;
}
    // rust: false
}
close_beacon_screen :: proc(self: ^Self) {
}
    // rust: self.close_container();
    // rust: self.screen = super::Screen::Playing;
    // rust: self.capture(true);
}
    // `BeaconMenu.updateEffects`: spend the payment and set the powers. On
    // a server, `BeaconScreen`'s confirm button sends them
    // (`ServerboundSetBeaconPacket`) and the server's menu does it.
confirm_beacon :: proc(self: ^Self, sel: [Maybe(uint); 2]) {
}
    // rust: if self.remote.is_some() {
    // rust: let id = |e: Option<usize>| e.and_then(|e| self.remote_effect_network_id(EFFECTS[e].0));
    // rust: let (primary, secondary) = (id(sel[0]), id(sel[1]));
    // rust: self.send(S::SetBeacon(play::SetBeacon { primary, secondary }));
    // rust: return;
}
    // rust: let Some(s) = self.station.as_mut() else {
    // rust: return;
}
    // rust: let pos = s.pos;
    // rust: s.inputs[0] = None;
    // rust: let name = |e: Option<usize>| e.map(|e| format!("minecraft:{}", EFFECTS[e].0));
    // rust: let mut select_sound = false;
    // rust: if let Some(BlockEntity::Beacon(b)) =
    // rust: self.world.block_entities.get_mut(&(pos[0], pos[1], pos[2]))
    // rust: {
    // rust: b.primary = name(sel[0]);
    // rust: b.secondary = name(sel[1]);
    // rust: select_sound = !b.sections.is_empty();
}
    // rust: if select_sound {
    // rust: self.beacon_sound(pos, "minecraft:block.beacon.power_select");
}
    // rust: self.world.modified.insert((pos[0] >> 4, pos[2] >> 4));
}
    // `BeaconScreen`: background, labels, payment icons, power buttons.
    // rust: pub(super) fn draw_beacon(&mut self, batch: &mut HudBatch) {
    // rust: let (ox, oy) = self.inventory_origin(batch);
    // rust: let (bx, by) = (ox + SHIFT, oy);
    // rust: let local = (self.cursor.0 - bx, self.cursor.1 - by);
    // rust: let levels = self.beacon_levels();
    // rust: let sel = self.station.as_ref().map_or([None; 2], |s| s.beacon);
    // rust: let paid = self.station.as_ref().is_some_and(|s| s.inputs[0].is_some());
        // BeaconScreen draws no title, but has the menu's.
    // rust: super::screen_info::name_container(|| {
    // rust: self.remote_menu_title().map_or_else(
    // rust: || self.translate("container.beacon", "Beacon"),
    // rust: |t| t.plain(),
    // rust: )
    // rust: });
    // rust: let atlas = &self.gui.atlas;
    // rust: batch.fill(
    // rust: atlas,
    // rust: 0.0,
    // rust: 0.0,
    // rust: batch.width,
    // rust: batch.height,
    // rust: rgba(16, 16, 16, 160),
    // rust: );
    // rust: if let Some(mut r) = atlas.sprites.get("gui/container/beacon").copied() {
    // rust: let (du, dv) = ((r.u1 - r.u0) / r.w as f32, (r.v1 - r.v0) / r.h as f32);
    // rust: r.u1 = r.u0 + 230.0 * du;
    // rust: r.v1 = r.v0 + HEIGHT * dv;
    // rust: batch.rect_uv(bx, by, 230.0, HEIGHT, r, u32::MAX);
}
    // rust: let label = 0xFFE0_E0E0;
    // rust: for (key, fallback, cx) in [
    // rust: ("block.minecraft.beacon.primary", "Primary Power", 62.0),
    // rust: ("block.minecraft.beacon.secondary", "Secondary Power", 169.0),
    // rust: ] {
    // rust: let text = self.translate(key, fallback);
    // rust: let atlas = &self.gui.atlas;
    // rust: let w = HudBatch::text_width(atlas, &text);
    // rust: batch.text(
    // rust: atlas,
    // rust: &text,
    // rust: bx + cx - (w / 2.0).floor(),
    // rust: by + 10.0,
    // rust: label,
    // rust: false,
    // rust: );
}
    // rust: for (i, item) in PAYMENT.iter().rev().enumerate() {
    // rust: let x = [20.0, 41.0, 63.0, 86.0, 108.0][i];
    // rust: self.draw_item(batch, &ItemStack::new(item, 1), bx + x, by + 109.0);
}
    // rust: let atlas = &self.gui.atlas;
    // rust: let mut tooltip = None;
    // rust: let button =
    // rust: |batch: &mut HudBatch, x: f32, y: f32, active: bool, selected: bool, icon: &str| {
    // rust: let hover = inside(local, x, y, 22.0, 22.0);
    // rust: let sprite = if !active {
    // rust: "button_disabled"
    // rust: } else if selected {
    // rust: "button_selected"
    // rust: } else if hover {
    // rust: "button_highlighted"
    // rust: } else {
    // rust: "button"
}
    // rust: batch.sprite(
    // rust: atlas,
    // rust: &format!("gui/sprites/container/beacon/{sprite}"),
    // rust: bx + x,
    // rust: by + y,
    // rust: );
    // rust: batch.sprite_scaled(
    // rust: atlas,
    // rust: icon,
    // rust: bx + x + 2.0,
    // rust: by + y + 2.0,
    // rust: 18.0,
    // rust: 18.0,
    // rust: u32::MAX,
    // rust: );
    // rust: hover
}
    // rust: for (e, x, y, primary) in buttons() {
    // rust: let tier = EFFECTS[e].1;
    // rust: let active = if primary {
    // rust: tier <= levels && tier < 4
    // rust: } else {
    // rust: levels >= 4
}
    // rust: let selected = if primary {
    // rust: sel[0] == Some(e)
    // rust: } else {
    // rust: sel[1] == Some(e)
}
    // rust: let icon = format!("mob_effect/{}", EFFECTS[e].0);
    // rust: if button(batch, x, y, active, selected, &icon) {
    // rust: tooltip = Some(format!("effect.minecraft.{}", EFFECTS[e].0));
}
}
    // rust: if let Some(p) = sel[0] {
    // rust: let (x, y) = upgrade_button();
    // rust: let icon = format!("mob_effect/{}", EFFECTS[p].0);
    // rust: if button(batch, x, y, levels >= 4, sel[1] == Some(p), &icon) {
    // rust: tooltip = Some(format!("effect.minecraft.{}", EFFECTS[p].0));
}
}
    // rust: button(
    // rust: batch,
    // rust: 164.0,
    // rust: 107.0,
    // rust: paid && sel[0].is_some(),
    // rust: false,
    // rust: "gui/sprites/container/beacon/confirm",
    // rust: );
    // rust: button(
    // rust: batch,
    // rust: 190.0,
    // rust: 107.0,
    // rust: true,
    // rust: false,
    // rust: "gui/sprites/container/beacon/cancel",
    // rust: );
    // rust: let slots: Vec<usize> = (0..36).chain([INPUT]).collect();
    // rust: self.draw_hovered_slot_highlight(batch, false, ox, oy);
    // rust: for i in slots {
    // rust: let (sx, sy) = self.slot_position(i);
    // rust: if let Some(stack) = self.slot_mut(i).clone() {
    // rust: self.draw_item(batch, &stack, ox + sx, oy + sy);
}
}
    // rust: self.draw_hovered_slot_highlight(batch, true, ox, oy);
    // rust: let mut stack_tip = None;
    // rust: if let Some(slot) = self.slot_at(batch, self.cursor.0, self.cursor.1) {
    // rust: stack_tip = self.slot_mut(slot).clone();
}
    // rust: if self.carried.is_some() {
    // rust: self.draw_carried(batch);
    // rust: if let Some(stack) = stack_tip.filter(|s| self.tooltip_with_carried(s)) {
    // rust: self.draw_stack_tooltip(batch, &stack, self.cursor.0, self.cursor.1);
}
    // rust: } else if let Some(stack) = stack_tip {
    // rust: self.draw_stack_tooltip(batch, &stack, self.cursor.0, self.cursor.1);
    // rust: } else if let Some(key) = tooltip {
    // rust: let text = self.translate(&key, &key);
    // rust: self.draw_tooltip_lines(
    // rust: batch,
    // rust: &[(horizon_client::text::Text::literal(text), u32::MAX)],
    // rust: self.cursor.0,
    // rust: self.cursor.1,
    // rust: );
}
}
    // `BeaconRenderer`: each section's rotating solid beam and its glow.
    // rust: pub(super) fn beacon_geometry(
    // rust: &mut self,
    // rust: camera: glam::DVec3,
    // rust: alpha: f64,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: let Some(s) = self
    // rust: .gui
    // rust: .atlas
    // rust: .sprites
    // rust: .get("entity/beacon/beacon_beam")
    // rust: .copied()
    // rust: else {
    // rust: return;
}
    // rust: let time = (self.world.game_time.rem_euclid(40)) as f32 + alpha as f32;
    // rust: let scoping = self.scoping();
        // `BeaconRenderer.shouldRender` culls at the render distance; far
        // terrain extends that to its own distance.
    // rust: let view = f64::from(self.terrain_distance() * 16);
    // rust: let world = &self.world;
    // rust: if self.lod.is_some() {
            // The beam stays after its chunk unloads; once the chunk is back,
            // its block entity decides whether the beam is still there.
    // rust: self.far_beacons.retain(|&pos, _| {
    // rust: let (x, _, z) = pos;
    // rust: !world.chunks.contains_key(&(x >> 4, z >> 4))
    // rust: || world
    // rust: .block_entities
    // rust: .get(&pos)
    // rust: .is_some_and(|e| beam(e).is_some() || is_test_instance_beam(e))
    // rust: });
    // rust: } else {
    // rust: self.far_beacons.clear();
}
    // rust: let test_beams: Vec<_> = world
    // rust: .block_entities
    // rust: .iter()
    // rust: .filter_map(|(k, e)| Some((*k, self.test_instance_beam(e)?)))
    // rust: .collect();
    // rust: for (k, e) in &world.block_entities {
    // rust: if let Some(sections) = beam(e) {
    // rust: self.far_beacons.insert(*k, sections.to_vec());
}
}
    // rust: for (k, sections) in test_beams {
    // rust: self.far_beacons.insert(k, sections);
}
    // rust: for (k, sections) in &self.far_beacons {
    // rust: let base = glam::DVec3::new(f64::from(k.0) + 0.5, f64::from(k.1), f64::from(k.2) + 0.5);
    // rust: let offset = base - camera;
    // rust: let horizontal = glam::DVec2::new(offset.x, offset.z).length();
    // rust: if horizontal >= view {
    // rust: continue;
}
    // rust: let distance = horizontal as f32;
    // rust: let scale = if scoping {
    // rust: 1.0
    // rust: } else {
    // rust: (distance / 96.0).max(1.0)
}
    // rust: let origin = (glam::DVec3::new(f64::from(k.0), f64::from(k.1), f64::from(k.2))
    // rust: - camera)
    // rust: .as_vec3();
    // rust: let start = out.len();
    // rust: horizon_client::block_entity_render::beacon_beam(origin, sections, time, scale, s, out);
            // HDR output: the beam shines (entity.wgsl fs_hdr_mark).
    // rust: for v in &mut out[start..] {
    // rust: v.layer |= u32::from(horizon_client::mesher::BRIGHT) << 16;
}
}
}
}
// Whether a test instance block shows a beam (`getBeamSections` not empty).
is_test_instance_beam :: proc(e: ^BlockEntity) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(e, BlockEntity::TestInstanceBlock(b) if b.data.status != Status::Cleared)
}
// The beam sections of an active beacon (`BeaconRenderer` draws no beam for
// a beacon without a pyramid or with all sections cleared).
beam :: proc(e: ^BlockEntity) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match e {
    // rust: BlockEntity::Beacon(b) if b.levels > 0 && !b.sections.is_empty() => Some(&b.sections),
    // rust: _ => None,
}
}
    // rust: mod tests {
//     use super::*;
only_active_beacons_have_beams :: proc() {
}
    // rust: let mut b = Beacon::default();
    // rust: assert!(beam(&BlockEntity::Beacon(Box::new(b.clone()))).is_none());
    // rust: b.levels = 1;
    // rust: b.sections.push((0xFFFFFF, 10));
    // rust: assert_eq!(
    // rust: beam(&BlockEntity::Beacon(Box::new(b))),
    // rust: Some(&[(0xFFFFFF, 10)][..])
    // rust: );
}
}
