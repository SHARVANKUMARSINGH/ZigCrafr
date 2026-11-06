//! Transpiled from Horizon Rust crate
package horizon_client_test_instances

import "core:fmt"
import "core:mem"
import "core:math"

// Test instance blocks on the server: `handleTestInstanceBlockAction` and
// the `TestInstanceBlockEntity` operations behind it (reset, save, export,
// the structure's placement), over the game tests the registry holds.
// use super::{
    // rust: Game,
    // rust: game_tests::Info,
    // rust: lan::LanHost,
    // rust: structure_blocks::{create_seed, template_size},
    // rust: test_entities::{aabb_of, inflate},
}
// use horizon_client::{
    // rust: block_entity_render::vertex_light,
    // rust: component::name_text,
    // rust: containers::BlockEntity,
    // rust: hud::HudBatch,
    // rust: mesher::Vertex,
    // rust: structure_block::rotation_from_ordinal,
    // rust: test_instance_block::{Data, Status, TestInstanceBlock},
    // rust: text::{self, Text},
}
// use horizon_core::{position::BlockPos, ticks::TickArea};
// use horizon_protocol::packets::play::{self, Clientbound as C};
// use horizon_world::{
    // rust: level::{TemplateSettings, flags},
    // rust: worldgen::structure::{BoundingBox, Mirror, Rotation},
}

    // rust: type Pos = (i32, i32, i32);

// `GameTestBlockHighlightRenderer.highlightPos`'s colour, 1610678016: ARGB 0x6000FF00.
HIGHLIGHT_FILL :: 0x6000_FF00

// `ServerboundTestInstanceBlockActionPacket.Action`.
INIT :: 0
QUERY :: 1
RESET :: 3
SAVE :: 4
EXPORT :: 5
RUN :: 6

// The `GameTestInstance` a registry entry describes: `TestData` and what
// `describe()` prints.
    // rust: pub(super) struct TestDef {
    // rust: pub(super) structure: String,
    // rust: pub(super) rotation: Rotation,
    // rust: pub(super) padding: i32,
    // rust: pub(super) required: bool,
    // rust: pub(super) sky_access: bool,
    // `BlockBasedTestInstance` (else a `FunctionGameTestInstance`).
    // rust: pub(super) block_based: bool,
    // The function a function test runs.
    // rust: pub(super) function: Option<String>,
    // The test environment's id (`batch()`).
    // rust: pub(super) environment: String,
    // rust: pub(super) max_ticks: i32,
    // rust: pub(super) setup_ticks: i32,
    // `TestData.maxAttempts` and `requiredSuccesses`.
    // rust: pub(super) max_attempts: i32,
    // rust: pub(super) required_successes: i32,
    // The dimension the test runs in (`TestData.dimension`).
    // rust: pub(super) dimension: String,
    // rust: description: Text,
}

    // rust: impl TestDef {
    // A test with the timing and type a runner test needs.
    // rust: pub(super) fn sample(block_based: bool, max_ticks: i32, setup_ticks: i32) -> Self {
    // rust: Self {
    // rust: structure: "minecraft:empty".into(),
    // rust: rotation: Rotation::None,
    // rust: padding: 0,
    // rust: required: true,
    // rust: sky_access: false,
    // rust: block_based,
    // rust: function: None,
    // rust: environment: "minecraft:default".into(),
    // rust: dimension: "minecraft:overworld".into(),
    // rust: max_ticks,
    // rust: setup_ticks,
    // rust: max_attempts: 1,
    // rust: required_successes: 1,
    // rust: description: Text::literal(""),
}
}
}

// `GameTestInstance.descriptionRow`: the row's value in blue, then a line break.
row :: proc(key: string, value: string) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Text::translate(key, &[Text::literal(value).with_color(0x5555FF)]).append(Text::literal("\n"))
}

red :: proc(key: string, args: ^[Text]) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Text::translate(key, args).with_color(text::RED)
}

    // rust: impl Game<'_> {
    // `registryAccess().get(testKey)`: the test instance from the game's
    // data (`data/<namespace>/test_instance/<path>.json`).
    // rust: pub(super) fn test_def(&self, id: &str) -> Option<TestDef> {
    // rust: if let Some(known) = self.test_defs.borrow().get(id) {
    // rust: return known.clone();
}
    // rust: let def = self.read_test_def(id);
    // rust: self.test_defs
    // rust: .borrow_mut()
    // rust: .insert(id.to_owned(), def.clone());
    // rust: def
}

read_test_def :: proc(self: ^Self, id: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let (ns, path) = id.split_once(':').unwrap_or(("minecraft", id));
    // rust: let file = self
    // rust: .options
    // rust: .resources
    // rust: .join("data")
    // rust: .join(ns)
    // rust: .join("test_instance")
    // rust: .join(format!("{path}.json"));
    // rust: let json: serde_json::Value = serde_json::from_slice(&std::fs::read(file).ok()?).ok()?;
    // rust: let string = |key: &str| json.get(key).and_then(|v| v.as_str());
    // rust: let structure = string("structure")?.to_owned();
    // rust: let environment = string("environment")?.to_owned();
    // rust: let dimension = string("dimension").unwrap_or("minecraft:overworld");
    // rust: let function = string("function");
        // `ExtraCodecs.POSITIVE_INT`, 1 when absent.
    // rust: let positive = |key: &str| {
    // rust: json.get(key)
    // rust: .and_then(|v| v.as_i64())
    // rust: .unwrap_or(1)
    // rust: .clamp(1, i64::from(i32::MAX)) as i32
}
        // GameTestInstance.describe: the type, the function (function tests
        // only), then the structure, batch and dimension.
    // rust: let block_based = string("type") == Some("minecraft:block_based");
    // rust: let mut description = Text::translate(
    // rust: "test_instance.description.type",
    // rust: &[Text::translate(
    // rust: if block_based {
    // rust: "test_instance.type.block_based"
    // rust: } else {
    // rust: "test_instance.type.function"
    // rust: },
    // rust: &[],
    // rust: )
    // rust: .with_color(0x5555FF)],
    // rust: )
    // rust: .append(Text::literal("\n"));
    // rust: if !block_based && let Some(function) = function {
    // rust: description = description.append(row("test_instance.description.function", function));
}
    // rust: description = description
    // rust: .append(row("test_instance.description.structure", &structure))
    // rust: .append(row("test_instance.description.batch", &environment))
    // rust: .append(row("test_instance.description.dimension", dimension));
    // rust: Some(TestDef {
    // rust: structure,
    // rust: rotation: string("rotation")
    // rust: .and_then(Rotation::from_name)
    // rust: .unwrap_or(Rotation::None),
    // rust: padding: json
    // rust: .get("padding")
    // rust: .and_then(|v| v.as_i64())
    // rust: .unwrap_or(0)
    // rust: .clamp(0, 128) as i32,
    // rust: required: json
    // rust: .get("required")
    // rust: .and_then(|v| v.as_bool())
    // rust: .unwrap_or(true),
    // rust: sky_access: json
    // rust: .get("sky_access")
    // rust: .and_then(|v| v.as_bool())
    // rust: .unwrap_or(false),
    // rust: block_based,
    // rust: function: function.map(str::to_owned),
    // rust: environment: environment.clone(),
    // rust: dimension: dimension.to_owned(),
    // rust: max_ticks: json
    // rust: .get("max_ticks")
    // rust: .and_then(|v| v.as_i64())
    // rust: .unwrap_or(1)
    // rust: .clamp(1, i64::from(i32::MAX)) as i32,
    // rust: setup_ticks: json
    // rust: .get("setup_ticks")
    // rust: .and_then(|v| v.as_i64())
    // rust: .unwrap_or(0)
    // rust: .clamp(0, i64::from(i32::MAX)) as i32,
    // rust: max_attempts: positive("max_attempts"),
    // rust: required_successes: positive("required_successes"),
    // rust: description,
    // rust: })
}

    // rust: pub(super) fn test_instance_at(&self, pos: Pos) -> Option<&TestInstanceBlock> {
    // rust: match self.world.block_entities.get(&pos)? {
    // rust: BlockEntity::TestInstanceBlock(b) => Some(b),
    // rust: _ => None,
}
}

    // rust: pub(super) fn test_instance_mut(&mut self, pos: Pos) -> Option<&mut TestInstanceBlock> {
    // rust: match self.world.block_entities.get_mut(&pos)? {
    // rust: BlockEntity::TestInstanceBlock(b) => Some(b),
    // rust: _ => None,
}
}

    // `getTestHolder`.
    // rust: pub(super) fn test_holder(&self, pos: Pos) -> Option<TestDef> {
    // rust: let key = self.test_instance_at(pos)?.data.test.clone()?;
    // rust: self.test_def(&key)
}

    // The padding of the block's test, 0 without one.
    // rust: pub(super) fn test_holder_padding(&self, pos: Pos) -> i32 {
    // rust: self.test_holder(pos).map_or(0, |t| t.padding)
}

    // `ClientPacketListener.handleGameTestHighlightPos`:
    // `GameTestBlockHighlightRenderer.highlightPos` shows the block for ten
    // seconds with its position relative to the test.
    // rust: pub(super) fn highlight_test_pos(&mut self, absolute: [i32; 3], relative: [i32; 3]) {
    // rust: let text = format!("{}, {}, {}", relative[0], relative[1], relative[2]);
    // rust: let until = std::time::Instant::now() + std::time::Duration::from_millis(10_000);
    // rust: self.test_highlights
    // rust: .insert((absolute[0], absolute[1], absolute[2]), (text, until));
}

    // `TestInstanceRenderer.submit`'s error markers, for any player within
    // the beacon's view distance of the block: each marked block in a
    // translucent red box (`out`, blending) and its text as a billboard over
    // everything (`see_through`).
    // rust: pub(super) fn test_instance_marker_geometry(
    // rust: &mut self,
    // rust: camera: glam::DVec3,
    // rust: out: &mut Vec<Vertex>,
    // rust: see_through: &mut Vec<Vertex>,
    // rust: ) {
//         use horizon_client::gizmos as g;
        // `GameTestBlockHighlightRenderer.emitGizmos`: expired highlights go,
        // the rest are a green box with the relative position over it.
    // rust: let now = std::time::Instant::now();
    // rust: self.test_highlights.retain(|_, (_, until)| now <= *until);
    // rust: let mut markers: Vec<(_, _, u32)> = self
    // rust: .test_highlights
    // rust: .iter()
    // rust: .map(|(&pos, (text, _))| ([pos.0, pos.1, pos.2], text.clone(), HIGHLIGHT_FILL))
    // rust: .collect();
    // rust: for (pos, entity) in &self.world.block_entities {
    // rust: let BlockEntity::TestInstanceBlock(b) = entity else {
    // rust: continue;
}
            // BeaconRenderer.getViewDistance: 256, by the horizontal distance.
    // rust: let dx = f64::from(pos.0) + 0.5 - camera.x;
    // rust: let dz = f64::from(pos.2) + 0.5 - camera.z;
    // rust: if dx * dx + dz * dz >= 256.0 * 256.0 {
    // rust: continue;
}
    // rust: for marker in &b.error_markers {
    // rust: markers.push((
    // rust: marker.pos,
    // rust: name_text(&marker.text).plain(),
    // rust: g::ERROR_MARKER_FILL,
    // rust: ));
}
}
    // rust: if markers.is_empty() {
    // rust: return;
}
    // rust: let light = vertex_light(0xFF);
    // rust: self.mark_translucent_entity(out.len(), "minecraft:test_instance_block");
    // rust: let mut patches = Vec::new();
    // rust: for (pos, text, color) in markers {
            // A plain colour: the atlas's white pixel at the fill's colour.
    // rust: let mut fill = HudBatch::new([1, 1]);
    // rust: fill.fill(&self.gui.atlas, 0.0, 0.0, 1.0, 1.0, color);
    // rust: let Some(v) = fill.vertices.first().copied() else {
    // rust: continue;
}
    // rust: let (min, max, text_at) = g::error_marker_shape(pos);
    // rust: for quad in g::cuboid_fill_quads(min, max) {
    // rust: for corner in quad {
    // rust: out.push(Vertex {
    // rust: normal: [0; 4],
    // rust: pos: (glam::DVec3::from_array(corner) - camera)
    // rust: .as_vec3()
    // rust: .to_array(),
    // rust: uv: v.uv,
    // rust: layer: 0,
    // rust: color: v.color,
    // rust: light,
    // rust: glint_uv: [0.0, 0.0],
    // rust: });
}
}
            // `Gizmos.billboardText(..).setAlwaysOnTop()`: white, centred,
            // without a background.
    // rust: patches.extend(self.name_tag_quads(
    // rust: glam::DVec3::from_array(text_at) - camera,
    // rust: &[(Text::literal(text), 0.0)],
    // rust: 0xFF,
    // rust: false,
    // rust: 2,
    // rust: 0,
    // rust: g::billboard_text_unit(g::ERROR_MARKER_TEXT_SCALE),
    // rust: see_through,
    // rust: ));
}
    // rust: self.map_patches.extend(patches);
}

    // `getRotation`: the test's rotation turned by the block's.
    // rust: pub(super) fn test_rotation(&self, pos: Pos) -> Rotation {
    // rust: let own = self
    // rust: .test_instance_at(pos)
    // rust: .map_or(Rotation::None, |b| b.data.rotation);
    // rust: self.test_holder(pos)
    // rust: .map_or(Rotation::None, |t| t.rotation)
    // rust: .get_rotated(own)
}

    // `getTestName`.
    // rust: pub(super) fn test_name(&self, pos: Pos) -> Text {
    // rust: match self.test_instance_at(pos).and_then(|b| b.data.test.clone()) {
    // rust: Some(key) => Text::literal(key),
    // rust: None => Text::translate("test_instance_block.invalid_test", &[]),
}
}

    // `ServerGamePacketListenerImpl.handleTestInstanceBlockAction` for a
    // guest: only a creative player with game master commands. A query or
    // the screen's first look answers with a status packet.
    // rust: pub(super) fn lan_test_instance_action(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: p: play::TestInstanceBlockAction,
    // rust: ) {
    // rust: let Some(g) = host.hub.guest(conn) else {
    // rust: return;
}
    // rust: let allowed = g.creative() && g.permission >= 2;
    // rust: let reply = self
    // rust: .as_guest_messaged(host, conn, |game| {
    // rust: allowed
    // rust: .then(|| game.apply_test_instance_action(&p))
    // rust: .flatten()
    // rust: })
    // rust: .flatten();
    // rust: if let Some((status, size)) = reply {
    // rust: host.hub.send_to(
    // rust: conn,
    // rust: &C::TestInstanceBlockStatus(play::TestInstanceBlockStatus {
    // rust: status: horizon_client::lan::data::component_nbt(&status.component()),
    // rust: size,
    // rust: }),
    // rust: );
}
}

    // rust: fn apply_test_instance_action(
    // rust: &mut self,
    // rust: p: &play::TestInstanceBlockAction,
    // rust: ) -> Option<(Text, Option<[i32; 3]>)> {
    // rust: let pos = (p.pos[0], p.pos[1], p.pos[2]);
    // rust: self.test_instance_at(pos)?;
        // `ByIdMap.continuous(.., ZERO)`: an unknown action is INIT.
    // rust: let action = if (0..=RUN).contains(&p.action) {
    // rust: p.action
    // rust: } else {
    // rust: INIT
}
    // rust: if action != QUERY && action != INIT {
            // `blockEntity.set(packet.data())`.
    // rust: let data = Data {
    // rust: test: p.data.test.clone(),
    // rust: size: p.data.size,
    // rust: rotation: rotation_from_ordinal(p.data.rotation).unwrap_or(Rotation::None),
    // rust: ignore_entities: p.data.ignore_entities,
    // rust: status: Status::by_index(p.data.status),
    // rust: error_message: p.data.error_message.clone(),
}
    // rust: if let Some(b) = self.test_instance_mut(pos) {
    // rust: b.data = data;
}
    // rust: match action {
    // rust: RESET => self.reset_test(pos),
    // rust: SAVE => {
    // rust: self.save_test(pos);
}
    // rust: EXPORT => self.export_test(pos),
    // rust: RUN => self.run_test(pos),
    // rust: _ => {}
}
    // rust: self.mark_block_entity_updated(pos);
    // rust: return None;
}
    // rust: let def = p.data.test.as_deref().and_then(|key| self.test_def(key));
    // rust: let status = def.map_or_else(
    // rust: || red("test_instance.description.no_test", &[]),
    // rust: |d| d.description,
    // rust: );
        // QUERY: the size of the test's structure.
    // rust: let size = (action == QUERY)
    // rust: .then(|| {
    // rust: let def = p.data.test.as_deref().and_then(|key| self.test_def(key))?;
    // rust: let entry = self.template_entry(&def.structure)?;
    // rust: Some(template_size(&entry.tag))
    // rust: })
    // rust: .flatten();
    // rust: Some((status, size))
}

    // `getStructureBoundingBox`.
    // rust: pub(super) fn test_structure_box(&self, pos: Pos) -> Option<BoundingBox> {
    // rust: let padding = self.test_holder(pos).map_or(0, |t| t.padding);
    // rust: let rotation = self.test_rotation(pos);
    // rust: Some(
    // rust: self.test_instance_at(pos)?
    // rust: .structure_box([pos.0, pos.1, pos.2], padding, rotation),
    // rust: )
}

    // `processStructureBoundary`: the floor and walls (and the ceiling,
    // unless the test has sky access) of the box around the structure.
    // rust: pub(super) fn structure_boundary(&self, pos: Pos) -> Vec<Pos> {
    // rust: let Some(bounds) = self.test_structure_box(pos) else {
    // rust: return Vec::new();
}
    // rust: let ceiling = !self.test_holder(pos).is_some_and(|t| t.sky_access);
    // rust: let low = bounds.min.map(|v| v - 1);
        // BlockPos.containing(maxX...) of the AABB, one past the box.
    // rust: let high = bounds.max.map(|v| v + 1);
    // rust: let mut out = Vec::new();
    // rust: for x in low[0]..=high[0] {
    // rust: for y in low[1]..=high[1] {
    // rust: for z in low[2]..=high[2] {
    // rust: let edge =
    // rust: x == low[0] || x == high[0] || z == low[2] || z == high[2] || y == low[1];
    // rust: if edge || (y == high[1] && ceiling) {
    // rust: out.push((x, y, z));
}
}
}
}
    // rust: out
}

    // `setBlockAndUpdate(pos, state)`.
    // rust: pub(super) fn set_test_block_state(&mut self, at: Pos, name: &str, flags: i32) {
    // rust: let Some(id) = self.pack.assets.registry.default_state(name) else {
    // rust: return;
}
    // rust: let pos = BlockPos::new(at.0, at.1, at.2);
    // rust: self.with_level(|b, level, ticks| b.set_block(level, ticks, pos, id, flags));
}

    // `removeBarriers`.
    // rust: pub(super) fn remove_test_barriers(&mut self, pos: Pos) {
    // rust: let barrier = self.pack.assets.registry.default_state("minecraft:barrier");
    // rust: for at in self.structure_boundary(pos) {
    // rust: if Some(self.world.block(at.0, at.1, at.2)) == barrier {
    // rust: self.set_test_block_state(at, "minecraft:air", flags::UPDATE_ALL);
}
}
    // rust: let _ = self.process_level_events();
}

    // `clearErrorMarkers`.
    // rust: pub(super) fn clear_error_markers(&mut self, pos: Pos) {
    // rust: if let Some(b) = self.test_instance_mut(pos)
    // rust: && !b.error_markers.is_empty()
    // rust: {
    // rust: b.error_markers.clear();
}
}

    // `resetTest`.
    // rust: pub(super) fn reset_test(&mut self, pos: Pos) {
    // rust: self.remove_test_barriers(pos);
    // rust: self.clear_error_markers(pos);
    // rust: if self.place_test_structure(pos) {
    // rust: let name = self.test_name(pos);
    // rust: self.system_message(
    // rust: Text::translate("test_instance_block.reset_success", &[name])
    // rust: .with_color(text::GREEN),
    // rust: );
}
        // `data.withStatus(CLEARED)`: the error message goes too.
    // rust: if let Some(b) = self.test_instance_mut(pos) {
    // rust: b.data.status = Status::Cleared;
    // rust: b.data.error_message = None;
}
}

    // `placeStructure()`: the test's structure, cleared space first.
    // rust: pub(super) fn place_test_structure(&mut self, pos: Pos) -> bool {
    // rust: let Some(def) = self.test_holder(pos) else {
    // rust: return false;
}
    // rust: let Some(entry) = self.template_entry(&def.structure) else {
    // rust: return false;
}
    // rust: let rotation = self.test_rotation(pos);
    // rust: let padding = def.padding;
    // rust: let Some(block) = self.test_instance_at(pos).cloned() else {
    // rust: return false;
}
    // rust: let origin = [pos.0, pos.1, pos.2];
        // `forceLoadChunks`, then `StructureUtils.clearSpaceForStructure(
        // getTestBoundingBox())`.
    // rust: if let Some(inner) = self.test_structure_box(pos) {
    // rust: self.force_load_test_chunks(&inner);
    // rust: let area = BoundingBox::new(
    // rust: inner.min.map(|v| v - padding),
    // rust: inner.max.map(|v| v + padding),
    // rust: );
    // rust: self.clear_test_space(&area);
            // removeEntities: `getTestBounds()`, the structure's box inflated.
    // rust: self.discard_entities_in(inflate(aabb_of(&inner), f64::from(padding)));
}
    // rust: let corner = block.start_corner(origin, padding, rotation);
    // rust: let settings = TemplateSettings {
    // rust: mirror: Mirror::None,
    // rust: rotation,
    // rust: ignore_entities: block.data.ignore_entities,
    // rust: known_shape: true,
    // rust: integrity: 1.0,
    // rust: seed: create_seed(0),
    // rust: flags: 818,
}
    // rust: self.place_template_entry(
    // rust: &entry,
    // rust: BlockPos::new(corner[0], corner[1], corner[2]),
    // rust: settings,
    // rust: Mirror::None,
    // rust: rotation,
    // rust: );
    // rust: true
}

    // `StructureUtils.clearSpaceForStructure`'s blocks: air in the box (stone
    // below the ground height, which no row of the box is).
    // rust: pub(super) fn clear_test_space(&mut self, area: &BoundingBox) {
    // rust: let ground = area.min[1] - 1;
    // rust: for y in area.min[1]..=area.max[1] {
    // rust: for z in area.min[2]..=area.max[2] {
    // rust: for x in area.min[0]..=area.max[0] {
    // rust: let name = if y < ground {
    // rust: "minecraft:stone"
    // rust: } else {
    // rust: "minecraft:air"
}
    // rust: self.set_test_block_state((x, y, z), name, 818);
}
}
}
        // `getBlockTicks().clearArea`, `clearBlockEvents`.
    // rust: self.clear_test_ticks(area);
        // The entities but the players.
    // rust: self.discard_entities_in(aabb_of(area));
}

    // `getBlockTicks().clearArea(bounds)` and `clearBlockEvents(bounds)`.
    // rust: pub(super) fn clear_test_ticks(&mut self, bounds: &BoundingBox) {
    // rust: let area = TickArea::new(
    // rust: BlockPos::new(bounds.min[0], bounds.min[1], bounds.min[2]),
    // rust: BlockPos::new(bounds.max[0], bounds.max[1], bounds.max[2]),
    // rust: );
    // rust: self.block_ticks.blocks.clear_area(area);
    // rust: self.block_ticks.block_events.retain(|e| {
    // rust: !(bounds.min[0]..=bounds.max[0]).contains(&e.pos.x)
    // rust: || !(bounds.min[1]..=bounds.max[1]).contains(&e.pos.y)
    // rust: || !(bounds.min[2]..=bounds.max[2]).contains(&e.pos.z)
    // rust: });
}

    // `saveTest`: the test's structure id, saved from the world.
save_test :: proc(self: ^Self, pos: Pos) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let id = self
    // rust: .test_holder(pos)
    // rust: .map(|t| t.structure)
    // rust: .or_else(|| self.test_instance_at(pos).and_then(|b| b.data.test.clone()));
    // rust: let Some(id) = id else {
    // rust: self.system_message(red(
    // rust: "test_instance_block.error.unable_to_save",
    // rust: &[pos.0, pos.1, pos.2].map(|v| Text::literal(v.to_string())),
    // rust: ));
    // rust: return None;
}
    // rust: let block = self.test_instance_at(pos)?.clone();
    // rust: let padding = self.test_holder(pos).map_or(0, |t| t.padding);
    // rust: let corner = TestInstanceBlock::structure_pos_of(
    // rust: [0, 1, 2].map(|i| [pos.0, pos.1, pos.2][i] + padding),
    // rust: );
    // rust: self.save_structure_area(
    // rust: &id,
    // rust: corner,
    // rust: block.data.size,
    // rust: block.data.ignore_entities,
    // rust: "",
    // rust: true,
    // rust: true,
    // rust: );
    // rust: Some(id)
}

    // `exportTest`: saves, then writes to the test template folder, which
    // only a development build has.
export_test :: proc(self: ^Self, pos: Pos) {
}
    // rust: if self.save_test(pos).is_some() {
    // rust: self.system_message(
    // rust: Text::literal("Test structure exporting is disabled").with_color(text::RED),
    // rust: );
}
}

    // `runTest`: the checks, the structure's placement and the test.
run_test :: proc(self: ^Self, pos: Pos) {
}
    // rust: let coordinates = [pos.0, pos.1, pos.2].map(|v| Text::literal(v.to_string()));
    // rust: let Some(def) = self.test_holder(pos) else {
    // rust: self.system_message(red("test_instance_block.error.no_test", &coordinates));
    // rust: return;
}
    // rust: if !self.place_test_structure(pos) {
    // rust: self.system_message(red(
    // rust: "test_instance_block.error.no_test_structure",
    // rust: &coordinates,
    // rust: ));
    // rust: return;
}
    // rust: self.clear_error_markers(pos);
        // GameTestTicker.SINGLETON.clear(), FailedTestTracker.forgetFailedTests().
    // rust: self.clear_game_tests();
    // rust: self.game_tests.failed.clear();
    // rust: let Some(block) = self.test_instance_at(pos) else {
    // rust: return;
}
    // rust: let key = block.data.test.clone().unwrap_or_default();
    // rust: let rotation = block.data.rotation;
    // rust: let key = if key.contains(':') {
    // rust: key
    // rust: } else {
    // rust: format!("minecraft:{key}")
}
    // rust: self.system_message(Text::translate(
    // rust: "test_instance_block.starting",
    // rust: &[Text::literal(key.clone())],
    // rust: ));
    // rust: let id = self.game_tests.next_id();
    // rust: let info = Info::new(id, key, def, Some(pos), self.dim, rotation);
    // rust: self.track_and_start_runner(vec![info], false, None);
}
}

    // rust: mod tests {
//     use super::*;

rows_print_the_value_in_blue_then_a_line_break :: proc() {
}
    // rust: let text = row("test_instance.description.structure", "minecraft:empty");
    // rust: assert!(text.plain().ends_with('\n'));
}
}
