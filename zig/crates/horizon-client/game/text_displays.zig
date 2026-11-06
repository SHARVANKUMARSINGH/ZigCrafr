//! Transpiled from Horizon Rust crate
//! Module: horizon-client_text_displays
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Server text displays: metadata, interpolation, billboard transforms and world text.
// use super::Game;
// use horizon_assets::item_model::DisplayContext;
// use horizon_client::{
    // rust: gfx::TEXT_POLYGON_OFFSET_OVERLAY,
    // rust: hud::HudBatch,
    // rust: items::ItemStack,
    // rust: mesher::Vertex,
    // rust: text_display::{self, Lines, TextDisplayData},
}
// use horizon_protocol::entity_data::Value;
// use horizon_world::registry::BlockStateId;

/// What a display shows besides its transformation: its text (in `data`),
/// a block state (`BlockDisplay`) or an item and how it is displayed
/// (`ItemDisplay`).
    // rust: pub(super) enum Shows {
    // rust: Text,
    // rust: Block,
    // rust: Item,
}

    // rust: pub(super) struct RemoteTextDisplay {
    // rust: pub data: TextDisplayData,
    // rust: shows: Shows,
    /// `BlockDisplay.DATA_BLOCK_STATE_ID`.
    // rust: block: Option<BlockStateId>,
    /// `ItemDisplay.DATA_ITEM_STACK` and `DATA_ITEM_DISPLAY_ID`.
    // rust: item: Option<ItemStack>,
    // rust: item_display: u8,
    // rust: from: TextDisplayData,
    // rust: shown: TextDisplayData,
    // rust: position: glam::DVec3,
    // rust: previous: glam::DVec3,
    // rust: target: glam::DVec3,
    // rust: rotation: [f32; 2],
    // rust: old_rotation: [f32; 2],
    // rust: target_rotation: [f32; 2],
    // rust: steps: i32,
    // rust: age: i64,
    // rust: start: i64,
    // rust: duration: i32,
    // rust: dirty: bool,
    // rust: start_dirty: bool,
    // rust: duration_dirty: bool,
    // rust: initialized: bool,
    /// `Display.lastProgress`: the progress the last frame drew, where a new
    /// interpolation starts from.
    // rust: last_progress: f32,
    /// `TextDisplay.clientDisplayCache`: the split lines, until the render
    /// state changes.
    // rust: lines: Option<Lines>,
    /// `Entity.vehicle`: the mob it rides (`SetPassengers`), which places it
    /// every tick (`positionRider`), as NPC plugins hang a name over a head.
    // rust: pub(super) vehicle: Option<u32>,
}

/// `Display.RENDER_STATE_IDS` and `TextDisplay.TEXT_RENDER_STATE_IDS`: the
/// data a render state is built from (not the view range, size or glow).
pub fn renders(id: u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(id, 11..=16 | 18 | 19 | 23..=27)
}

    // rust: impl RemoteTextDisplay {
pub fn new(shows: Shows, position: [f64; 3], yaw: f32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: data: Default::default(),
    // rust: shows,
    // rust: block: None,
    // rust: item: None,
    // rust: item_display: 0,
    // rust: from: Default::default(),
    // rust: shown: Default::default(),
    // rust: position: position.into(),
    // rust: previous: position.into(),
    // rust: target: position.into(),
    // rust: rotation: [yaw, 0.0],
    // rust: old_rotation: [yaw, 0.0],
    // rust: target_rotation: [yaw, 0.0],
    // rust: steps: 0,
    // rust: age: 0,
    // rust: start: 0,
    // rust: duration: 0,
    // rust: dirty: true,
    // rust: start_dirty: false,
    // rust: duration_dirty: false,
    // rust: initialized: false,
    // rust: last_progress: 0.0,
    // rust: lines: None,
    // rust: vehicle: None,
}
}
    /// Where a passenger of this display sits, this tick and the last
    /// (`Display`'s box is 0 by 0, so its passenger attachment is its feet).
    // rust: pub(super) fn seat(&self) -> (glam::DVec3, glam::DVec3) {
    // rust: (self.position, self.previous)
}
    /// `Entity.positionRider` through `setPos`: where its vehicle seats it this
    /// tick. The previous position stays the last tick's, so it moves smoothly
    /// with the vehicle; a teleport's interpolation no longer applies.
    // rust: pub(super) fn ride(&mut self, at: glam::DVec3) {
    // rust: self.position = at;
    // rust: self.target = at;
    // rust: self.steps = 0;
}
    // rust: pub(super) fn position(&self) -> glam::DVec3 {
    // rust: self.position
}
pub fn progress(self: *Self, partial: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.duration <= 0 {
    // rust: 1.0
    // rust: } else {
    // rust: (((self.age - self.start) as f32 + partial) / self.duration as f32).clamp(0.0, 1.0)
}
}
    /// The casters this display adds to the shadow pass: its interpolated
    /// shadow radius and strength (`DisplayRenderer.getShadowRadius` and
    /// `DisplayRenderer.getShadowStrength`), if it has any.
    // rust: pub(super) fn shadow(&self, partial: f64) -> Option<(glam::DVec3, f32, f32)> {
    // rust: horizon_client::shadows::display_caster(
    // rust: self.previous.lerp(self.position, partial),
    // rust: &self.from,
    // rust: &self.shown,
    // rust: self.progress(partial as f32),
    // rust: )
}
    /// The entries after `Display`'s: a block state, or an item with its
    /// display context (the stack comes converted by the caller).
pub fn show(self: *Self, values: *[(u8) void {
}
    // rust: for (id, _, value) in values {
    // rust: match (self.shows, id, value) {
    // rust: (Shows::Block, 23, Value::Id(state)) => {
    // rust: self.block = Some(BlockStateId(u32::try_from(*state).unwrap_or(0)));
}
    // rust: (Shows::Item, 24, Value::Byte(context)) => self.item_display = *context as u8,
    // rust: _ => {}
}
}
    // rust: if let Some(item) = item
    // rust: && self.shows == Shows::Item
    // rust: {
    // rust: self.item = item;
}
}
pub fn metadata(self: *Self, values: *[(u8) void {
}
    // rust: self.start_dirty |= values.iter().any(|v| v.0 == 8);
    // rust: self.duration_dirty |= values.iter().any(|v| v.0 == 9);
    // rust: self.dirty |= values.iter().any(|v| renders(v.0));
    // rust: self.data.apply(values);
}
pub fn tick(self: *Self) void {
}
    // rust: self.age += 1;
    // rust: self.previous = self.position;
    // rust: self.old_rotation = self.rotation;
    // rust: if self.steps > 0 {
    // rust: self.position += (self.target - self.position) / f64::from(self.steps);
    // rust: for i in 0..2 {
    // rust: self.rotation[i] +=
    // rust: angle(self.target_rotation[i] - self.rotation[i]) / self.steps as f32;
}
    // rust: self.steps -= 1;
}
    // rust: if self.start_dirty {
    // rust: self.start = self.age + i64::from(self.data.interpolation_delay);
}
    // rust: if self.duration_dirty {
    // rust: self.duration = self.data.interpolation_duration;
}
    // rust: if self.dirty {
    // rust: self.from = if self.initialized && self.duration > 0 {
    // rust: self.shown.blend(&self.from, self.last_progress)
    // rust: } else {
    // rust: self.data.clone()
}
    // rust: self.shown = self.data.clone();
    // rust: self.initialized = true;
    // rust: self.lines = None;
}
    // rust: self.dirty = false;
    // rust: self.start_dirty = false;
    // rust: self.duration_dirty = false;
}
pub fn move_to(self: *Self, position: [f64; 3], rotation: Option<(f32) void {
}
    // rust: self.target = position.into();
    // rust: if let Some((yaw, pitch)) = rotation {
    // rust: self.target_rotation = [yaw, pitch];
}
    // rust: self.steps = self.data.teleport_duration.clamp(0, 59);
    // rust: if self.steps == 0 {
    // rust: self.position = self.target;
    // rust: self.previous = self.target;
    // rust: self.rotation = self.target_rotation;
    // rust: self.old_rotation = self.rotation;
}
}
}
pub fn angle(d: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (d + 180.0).rem_euclid(360.0) - 180.0
}

    // rust: impl Game<'_> {
    // rust: pub(super) fn move_remote_text_display(
    // rust: &mut self,
    // rust: id: i32,
    // rust: position: [f64; 3],
    // rust: rotation: Option<(f32, f32)>,
    // rust: ) {
    // rust: if let Some(d) = self.text_displays.get_mut(&id) {
    // rust: d.move_to(position, rotation);
}
}
    // rust: pub(super) fn tick_text_displays(&mut self) {
    // rust: for display in self.text_displays.values_mut() {
    // rust: display.tick();
}
}
    /// The camera's yaw and pitch as `DisplayRenderer` reads them (the
    /// front view turns around).
pub fn display_camera_angles(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.camera_type == super::perspective::CameraType::ThirdPersonFront {
    // rust: [self.yaw + 180.0, -self.pitch]
    // rust: } else {
    // rust: [self.yaw, self.pitch]
}
}
    /// `DisplayRenderer.getBlockLightLevel` and `getSkyLightLevel`: the
    /// brightness override, else the light at the entity.
    // rust: fn display_light(
    // rust: world: &horizon_client::world::World,
    // rust: d: &TextDisplayData,
    // rust: position: glam::DVec3,
    // rust: ) -> u32 {
    // rust: if d.brightness == -1 {
    // rust: let world_light = world.light(
    // rust: position.x.floor() as i32,
    // rust: position.y.floor() as i32,
    // rust: position.z.floor() as i32,
    // rust: );
    // rust: horizon_client::block_entity_render::vertex_light(world_light)
    // rust: } else {
    // rust: ((d.brightness as u32 >> 20 & 15) * 16) | (((d.brightness as u32 >> 4 & 15) * 16) << 8)
}
}
    /// `Display.shouldRenderAtSqrDistance` and, when width and height are set,
    /// `EntityRenderer.shouldRender` with `Display.getInterpolatedBoundingBox`
    /// inflated by 0.5. Width or height 0 is `noCulling`: distance only.
    // rust: fn display_in_view(
    // rust: &self,
    // rust: camera: glam::DVec3,
    // rust: origin: glam::DVec3,
    // rust: data: &TextDisplayData,
    // rust: view_scale: f64,
    // rust: ) -> bool {
    // rust: let range = f64::from(data.view_range) * 64.0 * view_scale;
    // rust: if text_display::no_culling(data.width, data.height) {
    // rust: return (origin - camera).length_squared() < range * range;
}
    // rust: let (lo, hi) = text_display::culling_box(origin, data.width, data.height);
    // rust: self.entity_in_view(camera, origin, range, lo, hi)
}

    /// `DisplayRenderer.BlockDisplayRenderer` and `ItemDisplayRenderer`: the
    /// block model or the item under the display's transformation, lit like
    /// any entity and never tinted by a hurt overlay.
    // rust: pub(super) fn block_item_display_geometry(
    // rust: &mut self,
    // rust: camera: glam::DVec3,
    // rust: partial: f64,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: let angles = self.display_camera_angles();
    // rust: let scale = self.view_scale();
    // rust: let mut displays = std::mem::take(&mut self.text_displays);
    // rust: for shows in [Shows::Block, Shows::Item] {
    // rust: let kind = if shows == Shows::Block {
    // rust: "minecraft:block_display"
    // rust: } else {
    // rust: "minecraft:item_display"
}
    // rust: self.mark_entity(out.len(), kind);
    // rust: for (id, display) in displays.iter_mut().filter(|(_, d)| d.shows == shows) {
    // rust: display.last_progress = display.progress(partial as f32);
    // rust: let d = display.shown.blend(&display.from, display.last_progress);
    // rust: let position = display.previous.lerp(display.position, partial);
    // rust: if !self.display_in_view(camera, position, &d, scale) {
    // rust: continue;
}
    // rust: let rotation = std::array::from_fn(|i| {
    // rust: display.old_rotation[i]
    // rust: + angle(display.rotation[i] - display.old_rotation[i]) * partial as f32
    // rust: });
    // rust: let matrix = glam::Mat4::from_translation((position - camera).as_vec3())
    // rust: * d.matrix(rotation, angles);
    // rust: if !matrix.is_finite() {
    // rust: continue;
}
    // rust: let light = Self::display_light(&self.world, &d, position);
    // rust: if let Some(state) = display.block {
                    // BlockModelResolver.update: model seed 42.
    // rust: self.block_model_vertices(state, 42, matrix, light, true, out);
                    // CompositeBlockModel.update: the special model of a chest,
                    // head, banner and the like comes on top of the block model.
    // rust: if self
    // rust: .res
    // rust: .facts()
    // rust: .get(state)
    // rust: .name
    // rust: .strip_prefix("minecraft:")
    // rust: .is_some_and(has_special_model)
    // rust: {
    // rust: let packed =
    // rust: ((((light & 0xFF) / 16) << 4) | (((light >> 8) & 0xFF) / 16)) as u8;
    // rust: self.special_block_model(state, matrix, packed, out);
}
    // rust: } else if let Some(stack) = &display.item {
    // rust: let context = match display.item_display {
    // rust: 1 => DisplayContext::ThirdPersonLeftHand,
    // rust: 2 => DisplayContext::ThirdPersonRightHand,
    // rust: 3 => DisplayContext::FirstPersonLeftHand,
    // rust: 4 => DisplayContext::FirstPersonRightHand,
    // rust: 5 => DisplayContext::Head,
    // rust: 6 => DisplayContext::Gui,
    // rust: 7 => DisplayContext::Ground,
    // rust: 8 => DisplayContext::Fixed,
    // rust: 9 => DisplayContext::OnShelf,
    // rust: _ => DisplayContext::None,
}
                    // updateForNonLiving: seeded by the entity id.
    // rust: let state = self.resolve_item(stack, context, None, *id);
    // rust: let pose = matrix * glam::Mat4::from_rotation_y(std::f32::consts::PI);
    // rust: self.submit_item_world(&state, pose, light, out);
}
}
}
    // rust: self.mark_entity(out.len(), "");
    // rust: self.text_displays = displays;
}
    // rust: pub(super) fn text_display_geometry(
    // rust: &mut self,
    // rust: camera: glam::DVec3,
    // rust: partial: f64,
    // rust: normal: &mut Vec<Vertex>,
    // rust: see_through: &mut Vec<Vertex>,
    // rust: ) {
    // rust: self.text_display_vertices = 0;
    // rust: self.mark_translucent_entity(normal.len(), "minecraft:text_display");
    // rust: let angles = self.display_camera_angles();
    // rust: let scale = self.view_scale();
    // rust: let background = self.settings.text_background(0.25);
    // rust: let mut displays = std::mem::take(&mut self.text_displays);
    // rust: for display in displays.values_mut().filter(|d| d.shows == Shows::Text) {
    // rust: display.last_progress = display.progress(partial as f32);
    // rust: let d = display.shown.blend(&display.from, display.last_progress);
    // rust: let position = display.previous.lerp(display.position, partial);
    // rust: if d.text.is_empty() || !self.display_in_view(camera, position, &d, scale) {
    // rust: continue;
}
    // rust: let rotation = std::array::from_fn(|i| {
    // rust: display.old_rotation[i]
    // rust: + angle(display.rotation[i] - display.old_rotation[i]) * partial as f32
    // rust: });
    // rust: let lines = display
    // rust: .lines
    // rust: .get_or_insert_with(|| Lines::split(&self.gui.atlas.font, &d.text, d.line_width));
    // rust: let matrix = glam::Mat4::from_translation((position - camera).as_vec3())
    // rust: * d.matrix(rotation, angles)
    // rust: * lines.pose();
    // rust: if !matrix.is_finite() {
    // rust: continue;
}
    // rust: let mut batch = HudBatch::new([1, 1]);
    // rust: text_display::draw(&mut batch, &self.gui.atlas, &d, lines, background);
    // rust: let light = Self::display_light(&self.world, &d, position);
            // Font.DisplayMode: SEE_THROUGH over everything, else POLYGON_OFFSET.
    // rust: let through = d.flags & 2 != 0;
    // rust: let (out, layer) = if through {
    // rust: (&mut *see_through, 2)
    // rust: } else {
    // rust: (&mut *normal, TEXT_POLYGON_OFFSET_OVERLAY)
}
    // rust: for quad in batch.vertices.as_chunks::<6>().0 {
    // rust: for i in text_display::CORNERS {
    // rust: let v = quad[i];
    // rust: let point =
    // rust: matrix.transform_point3(glam::Vec3::new(v.pos[0], v.pos[1], v.depth));
    // rust: out.push(Vertex {
    // rust: pos: point.to_array(),
    // rust: uv: v.uv,
    // rust: color: v.color,
    // rust: light,
    // rust: layer,
    // rust: normal: [0; 4],

    // rust: glint_uv: [0.0, 0.0],
    // rust: });
}
}
    // rust: self.text_display_vertices += batch.vertices.len() / 6 * 4;
    // rust: self.map_patches.extend(batch.patches);
}
    // rust: self.text_displays = displays;
}
}

/// Whether vanilla's built-in block models give this block a special model,
/// drawn by its block-entity renderer.
pub fn has_special_model(block: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(
    // rust: block,
    // rust: "bell"
    // rust: | "conduit"
    // rust: | "decorated_pot"
    // rust: | "enchanting_table"
    // rust: | "end_gateway"
    // rust: | "end_portal"
    // rust: | "chest"
    // rust: | "trapped_chest"
    // rust: | "ender_chest"
    // rust: | "shulker_box"
    // rust: ) || block.ends_with("_banner")
    // rust: || block.ends_with("_shulker_box")
    // rust: || block.ends_with("_skull")
    // rust: || (block.ends_with("_head") && block != "piston_head")
    // rust: || block.contains("copper_chest")
    // rust: || block.contains("copper_golem_statue")
}

    // rust: mod tests {
//     use super::*;
pub fn metadata_and_position_interpolation_keep_their_separate_clocks() void {
}
    // rust: let mut d = RemoteTextDisplay::new(Shows::Text, [0.0; 3], 0.0);
    // rust: d.tick();
    // rust: d.metadata(&[
    // rust: (8, 1, Value::Int(0)),
    // rust: (9, 1, Value::Int(4)),
    // rust: (10, 1, Value::Int(2)),
    // rust: (11, 0, Value::Floats(vec![4.0, 0.0, 0.0])),
    // rust: ]);
    // rust: d.tick();
    // rust: assert_eq!(d.shown.blend(&d.from, d.progress(0.5)).translation[0], 0.5);
    // rust: d.move_to([2.0, 0.0, 0.0], Some((90.0, 0.0)));
    // rust: d.tick();
    // rust: assert_eq!(d.position.x, 1.0);
    // rust: assert_eq!(d.rotation[0], 45.0);
    // rust: d.tick();
    // rust: assert_eq!(d.position.x, 2.0);
    // rust: assert_eq!(d.shown.blend(&d.from, d.progress(0.0)).translation[0], 2.0);
}

    /// A display riding a vehicle sits where the vehicle seats it each tick,
    /// moving from the last tick's seat, and a teleport sent meanwhile does
    /// not drag it off the seat.
pub fn a_ridden_display_moves_from_seat_to_seat() void {
}
    // rust: let mut d = RemoteTextDisplay::new(Shows::Text, [0.0, 64.0, 0.0], 0.0);
    // rust: d.metadata(&[(10, 1, Value::Int(3))]);
    // rust: d.move_to([9.0, 64.0, 9.0], None);
    // rust: let seat = glam::DVec3::new(0.0, 65.8, 0.0);
    // rust: d.ride(seat);
    // rust: assert_eq!(d.position, seat);
    // rust: d.tick();
    // rust: assert_eq!((d.previous, d.position), (seat, seat));
    // rust: let next = glam::DVec3::new(1.0, 65.8, 0.0);
    // rust: d.ride(next);
    // rust: assert_eq!((d.previous, d.position), (seat, next));
}
}
