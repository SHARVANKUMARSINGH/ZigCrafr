//! Transpiled from Horizon Rust crate
//! Module: horizon-client_entity_culling
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Entity mesh occlusion and view-distance checks.
// use super::{
    // rust: Game, Vertex,
    // rust: entity::RenderEntityBounds,
    // rust: occlusion_culling::{QuerySource, SyncOccluder},
}
// use horizon_client::graphics::EntityCullingMode;
// use horizon_client::mobs::Species;
// use horizon_core::geometry::{Aabb, Vec3};

pub const MAX_ENTITY_SECTION_COVERAGE: i64 = 50;

/// The inclusive range of sections an entity's padded render bounds can touch,
/// in the layout whose section 0 starts at `bottom_y`. `None` when the bounds
/// are not finite, hold block coordinates outside `i32`, or span more sections
/// than `MAX_ENTITY_SECTION_COVERAGE`: those go to the per-entity path.
pub fn entity_section_span(bounds: Aabb, bottom_y: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // A half-block border keeps models near section edges checked against
    // every section their geometry could touch.
    // rust: let lo = bounds.min_position();
    // rust: let hi = bounds.max_position();
    // rust: let min_block = [lo.x - 0.5, lo.y - 0.5, lo.z - 0.5];
    // rust: let max_block = [hi.x + 0.5, hi.y + 0.5, hi.z + 0.5];
    // rust: if min_block
    // rust: .into_iter()
    // rust: .chain(max_block)
    // rust: .any(|v| !v.is_finite() || v < f64::from(i32::MIN) || v > f64::from(i32::MAX))
    // rust: {
    // rust: return None;
}
    // rust: let min_block = min_block.map(|v| v.floor() as i32);
    // rust: let max_block = max_block.map(|v| v.floor() as i32);
    // rust: let min_y = min_block[1].checked_sub(bottom_y)?;
    // rust: let max_y = max_block[1].checked_sub(bottom_y)?;
    // rust: let min = [min_block[0] >> 4, min_y >> 4, min_block[2] >> 4];
    // rust: let max = [max_block[0] >> 4, max_y >> 4, max_block[2] >> 4];
    // rust: let sections = (0..3).try_fold(1_i64, |count, axis| {
    // rust: count.checked_mul(i64::from(max[axis]) - i64::from(min[axis]) + 1)
    // rust: });
    // Very large render envelopes (for example, beams) are cheaper and safer to
    // leave to the existing per-entity path.
    // rust: sections
    // rust: .is_some_and(|count| count <= MAX_ENTITY_SECTION_COVERAGE)
    // rust: .then_some((min, max))
}

    // rust: pub(super) enum EntityCullDecision {
    // rust: Bypass,
    // rust: Hidden,
    // rust: CheckVertices,
    // rust: Pending,
}

    // rust: impl EntityCullDecision {
    // rust: pub(super) const fn hides_entity(self) -> bool {
    // rust: matches!(self, Self::Hidden)
}

    // rust: pub(super) const fn checks_vertices(self) -> bool {
    // rust: matches!(self, Self::CheckVertices)
}
}

    // rust: impl Game<'_> {
    // rust: pub(super) fn prepare_entity_culling(&mut self) {
        // Spans tell the pack's passes which entities are hidden; without them, nothing changes.
    // rust: self.pack_shadow_casters = match (&self.renderer, &self.pack_ids) {
    // rust: (Some(r), Some(_)) => r.pack_shadow_casters(),
            // A native pack's shadow pass has no spans to hide entities with: it only needs
            // the first-person model.
    // rust: (Some(r), None) => (false, r.native_shadow()),
    // rust: _ => (false, false),
}
}

    // rust: pub(super) fn cull_entity_vertices(&self, vertices: &mut Vec<Vertex>, start: usize) -> bool {
    // rust: let hidden = self.occlusion_hidden(Some(vertices), start, None);
    // rust: if hidden && !(self.pack_shadow_casters.0 && self.hide_spans_from(start, vertices.len())) {
    // rust: if self.settings.horizon.entity_culling == EntityCullingMode::Asynchronous
    // rust: && let Some(culler) = &self.async_occlusion_culler
    // rust: {
    // rust: culler.record_entity_vertices_culled(vertices.len().saturating_sub(start));
}
    // rust: vertices.truncate(start);
}
    // rust: hidden
}

    // rust: pub(super) fn cull_entity_camera_bounds(&self, lo: glam::Vec3, hi: glam::Vec3) -> bool {
    // rust: if self.occlusion_hidden_camera_bounds(lo, hi) {
    // rust: if self.settings.horizon.entity_culling == EntityCullingMode::Asynchronous
    // rust: && let Some(culler) = &self.async_occlusion_culler
    // rust: {
    // rust: culler.record_entity_vertices_culled(2);
}
    // rust: return true;
}
    // rust: false
}

pub fn occlusion_hidden_camera_bounds(self: *Self, lo: glam::Vec3, hi: glam::Vec3) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.settings.horizon.entity_culling {
    // rust: EntityCullingMode::Off => false,
    // rust: EntityCullingMode::Asynchronous => {
    // rust: if let Some(culler) = &self.async_occlusion_culler {
    // rust: if !culler.camera_is_stationary() {
    // rust: return false;
}
    // rust: let Some(query) = culler.query_camera_bounds(lo, hi) else {
    // rust: return false;
}
    // rust: match culler.query_result(&query, QuerySource::EntityMesh) {
    // rust: Some((false, _)) => false,
    // rust: Some((true, Some(proof)))
    // rust: if culler.proof_is_current(
    // rust: &self.world,
    // rust: self.renderer.as_ref(),
    // rust: &self.streaming,
    // rust: &self.pending_uploads,
    // rust: proof,
    // rust: ) =>
    // rust: {
    // rust: true
}
    // rust: Some(_) | None => {
    // rust: culler.queue(query);
    // rust: false
}
}
    // rust: } else {
    // rust: self.entity_hidden_sync_camera_bounds(lo, hi)
}
}
    // rust: EntityCullingMode::Synchronous => self.entity_hidden_sync_camera_bounds(lo, hi),
}
}

pub fn entity_hidden_sync_camera_bounds(self: *Self, lo: glam::Vec3, hi: glam::Vec3) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.sync_occlusion_culler.as_ref().is_some_and(|culler| {
    // rust: let mut occluder = SyncOccluder::new(
    // rust: &self.world,
    // rust: self.res.facts(),
    // rust: self.renderer.as_ref(),
    // rust: &self.streaming,
    // rust: &self.pending_uploads,
    // rust: );
    // rust: culler.hidden_camera_bounds(lo.to_array(), hi.to_array(), |pos| occluder.ready(pos))
    // rust: })
}

    /// Pre-model visibility hook for dynamic block-entity geometry.
    // rust: pub(super) fn block_entity_occluded(&self, bounds: Aabb) -> bool {
    // rust: self.occlusion_hidden(None, 0, Some(bounds))
}

    /// Cull from the shared entity AABB before generating its model vertices.
    // rust: pub(super) fn entity_cull_decision<T: RenderEntityBounds>(
    // rust: &self,
    // rust: entity: &T,
    // rust: alpha: f64,
    // rust: ) -> EntityCullDecision {
    // rust: self.entity_cull_decision_in_bounds(entity, entity.render_bounds(alpha))
}

    /// Cull from a renderer-computed envelope when the rendered transform has
    /// extra offsets or model geometry that the entity type alone cannot see.
    // rust: pub(super) fn entity_cull_decision_in_bounds<T: RenderEntityBounds>(
    // rust: &self,
    // rust: entity: &T,
    // rust: render_bounds: Aabb,
    // rust: ) -> EntityCullDecision {
    // rust: if self.settings.horizon.entity_culling == EntityCullingMode::Off
    // rust: || self.pack_shadow_casters.0
    // rust: || entity.render_glowing(self)
    // rust: {
    // rust: return EntityCullDecision::Bypass;
}
        // `render_bounds` is already the conservative model and animation
        // envelope. Only cover f32 vertex rounding here; another half-block
        // would make coarse walls falsely visible and force mesh generation.
    // rust: let margin = Vec3::new(1.0e-4, 1.0e-4, 1.0e-4);
    // rust: let bounds = render_bounds.inflate(margin);
    // rust: if self.terrain_sections_occlude(bounds) {
    // rust: if let Some(culler) = &self.async_occlusion_culler {
    // rust: culler.record_entity_culled();
}
    // rust: return EntityCullDecision::Hidden;
}
    // rust: match self.settings.horizon.entity_culling {
    // rust: EntityCullingMode::Off => EntityCullDecision::Bypass,
    // rust: EntityCullingMode::Synchronous => {
    // rust: if self.entity_hidden_sync(None, 0, Some(bounds)) {
    // rust: EntityCullDecision::Hidden
    // rust: } else {
    // rust: EntityCullDecision::CheckVertices
}
}
    // rust: EntityCullingMode::Asynchronous => {
    // rust: let Some(culler) = &self.async_occlusion_culler else {
    // rust: return if self.entity_hidden_sync(None, 0, Some(bounds)) {
    // rust: EntityCullDecision::Hidden
    // rust: } else {
    // rust: EntityCullDecision::CheckVertices
}
}
    // rust: if !culler.camera_is_stationary() {
    // rust: return EntityCullDecision::CheckVertices;
}
    // rust: let Some(query) = culler.query_entity_bounds(bounds) else {
    // rust: return EntityCullDecision::CheckVertices;
}
    // rust: culler.sample_entity_aabb(entity.render_id(), &query);
    // rust: match culler.query_result(&query, QuerySource::EntityAabb) {
    // rust: Some((false, _)) => EntityCullDecision::CheckVertices,
    // rust: Some((true, Some(proof)))
    // rust: if culler.proof_is_current(
    // rust: &self.world,
    // rust: self.renderer.as_ref(),
    // rust: &self.streaming,
    // rust: &self.pending_uploads,
    // rust: proof,
    // rust: ) =>
    // rust: {
    // rust: culler.record_entity_culled();
    // rust: EntityCullDecision::Hidden
}
    // rust: Some(_) | None => {
    // rust: culler.queue(query);
    // rust: EntityCullDecision::Pending
}
}
}
}
}

    /// Reject entities whose padded render bounds lie entirely in sections the
    /// terrain visibility graph cannot reach. Unknown graph cells fail open.
pub fn terrain_sections_occlude(self: *Self, bounds: Aabb) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.entity_section_visibility_valid
    // rust: || (self.sync_occlusion_culler.is_none() && self.async_occlusion_culler.is_none())
    // rust: {
    // rust: return false;
}
    // rust: let Some(renderer) = &self.renderer else {
    // rust: return false;
}
    // rust: let Some(camera_section) = self.entity_section_camera else {
    // rust: return false;
}
    // rust: let Some((min, max)) = entity_section_span(bounds, self.world.bottom_y()) else {
    // rust: return false;
}

    // rust: for x in min[0]..=max[0] {
    // rust: for y in min[1]..=max[1] {
    // rust: for z in min[2]..=max[2] {
    // rust: let Some(visible) =
    // rust: renderer.section_occlusion_visible((x, y, z), camera_section)
    // rust: else {
    // rust: return false;
}
    // rust: if visible {
    // rust: return false;
}
}
}
}
    // rust: true
}

    /// Refine an AABB-visible result with the exact bounds of the rendered mesh.
    // rust: pub(super) fn finish_entity_occlusion<T: RenderEntityBounds>(
    // rust: &self,
    // rust: decision: EntityCullDecision,
    // rust: entity: &T,
    // rust: vertices: &mut Vec<Vertex>,
    // rust: start: usize,
    // rust: ) {
    // rust: if decision.checks_vertices() && !self.pack_shadow_casters.0 && !entity.render_glowing(self)
    // rust: {
    // rust: self.cull_entity_vertices(vertices, start);
}
}

    // rust: fn occlusion_hidden(
    // rust: &self,
    // rust: vertices: Option<&[Vertex]>,
    // rust: start: usize,
    // rust: bounds: Option<Aabb>,
    // rust: ) -> bool {
    // rust: match self.settings.horizon.entity_culling {
    // rust: EntityCullingMode::Off => false,
    // rust: EntityCullingMode::Synchronous => self.entity_hidden_sync(vertices, start, bounds),
    // rust: EntityCullingMode::Asynchronous => {
    // rust: if let Some(culler) = &self.async_occlusion_culler {
    // rust: if !culler.camera_is_stationary() {
    // rust: return false;
}
    // rust: let Some(query) = (match bounds {
    // rust: Some(bounds) => culler.query_entity_bounds(bounds),
    // rust: None => vertices.and_then(|vertices| culler.query(vertices, start)),
    // rust: }) else {
    // rust: return false;
}
    // rust: match culler.query_result(&query, QuerySource::EntityMesh) {
    // rust: Some((false, _)) => false,
    // rust: Some((true, Some(proof)))
    // rust: if culler.proof_is_current(
    // rust: &self.world,
    // rust: self.renderer.as_ref(),
    // rust: &self.streaming,
    // rust: &self.pending_uploads,
    // rust: proof,
    // rust: ) =>
    // rust: {
    // rust: true
}
    // rust: Some(_) | None => {
    // rust: culler.queue(query);
    // rust: false
}
}
    // rust: } else {
    // rust: self.entity_hidden_sync(vertices, start, bounds)
}
}
}
}

    // rust: fn entity_hidden_sync(
    // rust: &self,
    // rust: vertices: Option<&[Vertex]>,
    // rust: start: usize,
    // rust: bounds: Option<Aabb>,
    // rust: ) -> bool {
    // rust: self.sync_occlusion_culler.as_ref().is_some_and(|culler| {
    // rust: let mut occluder = SyncOccluder::new(
    // rust: &self.world,
    // rust: self.res.facts(),
    // rust: self.renderer.as_ref(),
    // rust: &self.streaming,
    // rust: &self.pending_uploads,
    // rust: );
    // rust: match bounds {
    // rust: Some(bounds) => culler.hidden_bounds(bounds, |pos| occluder.ready(pos)),
    // rust: None => vertices.is_some_and(|vertices| {
    // rust: culler.hidden(vertices, start, |pos| occluder.ready(pos))
    // rust: }),
}
    // rust: })
}
}

    // rust: impl Game<'_> {
    /// Entity.setViewScale (LevelExtractor.extractVisibleEntities): the entity
    /// distance option times the render distance's boost — 1 at 8 chunks, 2.5
    /// at 20 or more. The render distance is the client setting, capped by
    /// the server's view distance when connected
    /// (Options.getEffectiveRenderDistance).
    // rust: pub(super) fn view_scale(&self) -> f64 {
    // rust: let distance = match &self.remote {
    // rust: Some(r) => self.settings.render_distance.min(r.view_distance),
    // rust: None => self.settings.render_distance,
}
    // rust: entity_view_scale(distance, self.settings.entity_distance)
}
}

/// Entity.setViewScale: `Mth.clamp(renderDistance / 8, 1, 2.5) *
/// entityDistanceScaling`. Every entity's draw distance is scaled by it, so
/// a small mob is drawn nearer than a big one and a longer render distance
/// draws both further away.
    // rust: pub(super) fn entity_view_scale(render_distance: i32, entity_distance: f32) -> f64 {
    // rust: (f64::from(render_distance) / 8.0).clamp(1.0, 2.5) * f64::from(entity_distance)
}

/// Entity.shouldRenderAtSqrDistance's default range: 64 times the bounding
/// box's mean edge, scaled by the view scale.
    // rust: pub(super) fn default_range(size: glam::DVec3, view_scale: f64) -> f64 {
    // rust: let edge = (size.x + size.y + size.z) / 3.0;
    // rust: let edge = if edge.is_nan() { 1.0 } else { edge };
    // rust: edge * 64.0 * view_scale
}

pub const CullGrow = struct {
    side: f64,
    all: f64,
    down: f64,
};

    // rust: impl CullGrow {
pub fn of(species: Species, height: f64, dragon_head: bool) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut grow = Self::default();
    // rust: if dragon_head {
    // rust: grow.all += 0.5;
}
    // rust: match species {
    // rust: Species::Illusioner => grow.side += 3.0,
    // rust: Species::Sniffer => grow.all += 0.6,
    // rust: Species::HappyGhast => grow.down += height / 2.0,
    // rust: _ => {}
}
    // rust: grow
}
}

    // rust: fn grown_box(
    // rust: pos: glam::DVec3,
    // rust: width: f64,
    // rust: height: f64,
    // rust: grow: CullGrow,
    // rust: ) -> (glam::DVec3, glam::DVec3) {
    // rust: let side = width / 2.0 + grow.side + grow.all;
    // rust: (
    // rust: pos - glam::DVec3::new(side, grow.all + grow.down, side),
    // rust: pos + glam::DVec3::new(side, height + grow.all, side),
    // rust: )
}

/// `LivingEntityRenderer.getBoundingBoxForCulling` for the mob's interpolated
/// position, including renderer-specific growth for mirrors, riders and heads.
    // rust: pub(super) fn cull_box(mob: &horizon_client::mobs::Mob, alpha: f64) -> (glam::DVec3, glam::DVec3) {
    // rust: let (width, height, _) = mob.dims();
    // rust: let grow = CullGrow::of(
    // rust: mob.species(),
    // rust: height,
    // rust: mob.extra.head.as_deref() == Some("minecraft:dragon_head"),
    // rust: );
    // rust: let pos = glam::DVec3::new(
    // rust: mob.previous.x + (mob.position.x - mob.previous.x) * alpha,
    // rust: mob.previous.y + (mob.position.y - mob.previous.y) * alpha,
    // rust: mob.previous.z + (mob.position.z - mob.previous.z) * alpha,
    // rust: );
    // rust: grown_box(pos, width, height, grow)
}

    // rust: impl Game<'_> {
    /// EntityRenderer.shouldRender: the entity within `range` blocks of the
    /// camera, measured from its current `position`, and its culling box
    /// (`lo`..`hi`, interpolated, in world space) grown by 0.5 in the view.
    // rust: pub(super) fn entity_in_view(
    // rust: &self,
    // rust: camera: glam::DVec3,
    // rust: position: glam::DVec3,
    // rust: range: f64,
    // rust: lo: glam::DVec3,
    // rust: hi: glam::DVec3,
    // rust: ) -> bool {
    // rust: if (position - camera).length_squared() >= range * range {
    // rust: return false;
}
    // rust: self.view_frustum.as_ref().is_none_or(|view| {
    // rust: view.intersects(
    // rust: (lo - camera - glam::DVec3::splat(0.5)).as_vec3(),
    // rust: (hi - camera + glam::DVec3::splat(0.5)).as_vec3(),
    // rust: )
    // rust: })
}
}

/// An entity's position as a `DVec3`.
    // rust: pub(super) fn at(p: horizon_core::geometry::Vec3) -> glam::DVec3 {
    // rust: glam::DVec3::new(p.x, p.y, p.z)
}

    // rust: impl Game<'_> {
    /// `entity_in_view` for an entity whose box stands on its position,
    /// `width` wide and `height` tall, interpolated by `alpha` and grown by
    /// `grow` (a renderer's getBoundingBoxForCulling).
    // rust: pub(super) fn standing_entity_in_view(
    // rust: &self,
    // rust: camera: glam::DVec3,
    // rust: previous: glam::DVec3,
    // rust: position: glam::DVec3,
    // rust: alpha: f64,
    // rust: width: f64,
    // rust: height: f64,
    // rust: range: f64,
    // rust: grow: f64,
    // rust: ) -> bool {
    // rust: let p = previous.lerp(position, alpha);
    // rust: let half = glam::DVec3::new(width / 2.0 + grow, grow, width / 2.0 + grow);
    // rust: let lo = p - half;
    // rust: let hi = p + glam::DVec3::new(half.x, height + grow, half.z);
    // rust: self.entity_in_view(camera, position, range, lo, hi)
}
}

    // rust: mod vanilla_entity_tests {
//     use super::*;

    /// `Entity.setViewScale`: the entity distance option times the render
    /// distance's boost — 1 at eight chunks, 1.5 at twelve, 2.5 at twenty.
pub fn the_view_scale_follows_the_render_distance() void {
}
    // rust: assert_eq!(entity_view_scale(4, 1.0), 1.0);
    // rust: assert_eq!(entity_view_scale(8, 1.0), 1.0);
    // rust: assert_eq!(entity_view_scale(12, 1.0), 1.5);
    // rust: assert_eq!(entity_view_scale(20, 1.0), 2.5);
    // rust: assert_eq!(entity_view_scale(32, 1.0), 2.5);
        // The entity distance option scales it down.
    // rust: assert_eq!(entity_view_scale(12, 0.5), 0.75);
}

    /// `Entity.shouldRenderAtSqrDistance`: a chicken's box (0.4 by 0.7 by
    /// 0.4) is drawn up to 48 blocks away at the vanilla defaults, not the
    /// 32 blocks a missing view scale leaves (#2273).
pub fn a_chicken_is_drawn_forty_eight_blocks_away() void {
}
    // rust: let range = default_range(glam::DVec3::new(0.4, 0.7, 0.4), entity_view_scale(12, 1.0));
    // rust: assert_eq!(range, 48.0);
}

    /// `Entity.shouldRenderAtSqrDistance` for a dropped item (`ItemEntity`
    /// keeps the default and its box is 0.25 on each side): 24 blocks at
    /// render distance 12, 32 at 16, 40 from 20 on; never 64.
pub fn a_dropped_item_is_drawn_sixteen_blocks_times_the_view_scale() void {
}
    // rust: let item = glam::DVec3::splat(0.25);
    // rust: assert_eq!(default_range(item, entity_view_scale(12, 1.0)), 24.0);
    // rust: assert_eq!(default_range(item, entity_view_scale(16, 1.0)), 32.0);
    // rust: assert_eq!(default_range(item, entity_view_scale(32, 1.0)), 40.0);
}

    /// `getBoundingBoxForCulling`: only four living renderers grow the box.
    /// An illusioner asks for three blocks either side (room for its mirror
    /// images, which are drawn outside its own box), a sniffer for 0.6 all
    /// round, a happy ghast for half its height below (its riders hang under
    /// it) and anyone wearing a dragon head for 0.5 all round.
pub fn only_the_four_living_renderers_grow_the_culling_box() void {
}
    // rust: assert_eq!(
    // rust: CullGrow::of(Species::Villager, 1.95, false),
    // rust: CullGrow::default()
    // rust: );
    // rust: let illusioner = CullGrow::of(Species::Illusioner, 1.95, false);
    // rust: assert_eq!(
    // rust: (illusioner.side, illusioner.all, illusioner.down),
    // rust: (3.0, 0.0, 0.0)
    // rust: );
    // rust: let sniffer = CullGrow::of(Species::Sniffer, 1.75, false);
    // rust: assert!((sniffer.all - 0.6).abs() < 1e-7 && sniffer.side == 0.0);
    // rust: let ghast = CullGrow::of(Species::HappyGhast, 4.0, false);
    // rust: assert_eq!((ghast.down, ghast.all), (2.0, 0.0));
        // A dragon head grows every axis, on any living entity.
    // rust: let headed = CullGrow::of(Species::Villager, 1.95, true);
    // rust: assert_eq!((headed.all, headed.side, headed.down), (0.5, 0.0, 0.0));
        // The growths add up: an illusioner in a dragon head gets both.
    // rust: let both = CullGrow::of(Species::Illusioner, 1.95, true);
    // rust: assert_eq!((both.all, both.side), (0.5, 3.0));
}

    /// The box the frustum test sees: an illusioner's own box is 0.6 wide, so
    /// its culling box reaches 3.3 blocks either side of its position and
    /// 0.5 below its feet, where a villager's reaches 0.8.
pub fn an_illusioner_is_culled_three_blocks_wider_than_its_box() void {
}
    // rust: let pos = glam::DVec3::new(10.0, 64.0, -4.0);
    // rust: let (lo, hi) = grown_box(
    // rust: pos,
    // rust: 0.6,
    // rust: 1.95,
    // rust: CullGrow::of(Species::Illusioner, 1.95, false),
    // rust: );
    // rust: assert_eq!(lo, glam::DVec3::new(10.0 - 3.3, 64.0, -4.0 - 3.3));
    // rust: assert_eq!(hi, glam::DVec3::new(10.0 + 3.3, 64.0 + 1.95, -4.0 + 3.3));
    // rust: let (lo, hi) = grown_box(pos, 0.6, 1.95, CullGrow::of(Species::Villager, 1.95, false));
    // rust: assert!((lo.x - (10.0 - 0.3)).abs() < 1e-9);
    // rust: assert!((hi.y - (64.0 + 1.95)).abs() < 1e-9);
        // A happy ghast's box drops by half its height below its feet.
    // rust: let (lo, hi) = grown_box(pos, 4.0, 4.0, CullGrow::of(Species::HappyGhast, 4.0, false));
    // rust: assert_eq!(lo.y, 62.0);
    // rust: assert_eq!(hi.y, 68.0);
}

    /// `Entity.shouldRenderAtSqrDistance` on a broken box: the size falls
    /// back to one block.
pub fn a_broken_bounding_box_falls_back_to_one_block() void {
}
    // rust: let range = default_range(
    // rust: glam::DVec3::new(f64::NAN, 0.7, 0.4),
    // rust: entity_view_scale(12, 1.0),
    // rust: );
    // rust: assert_eq!(range, 96.0);
}

    /// The sections an entity's padded bounds can touch: the half-block border
    /// a model near a section edge reaches into, the layout `bottom_y` sets,
    /// and the boxes that get no answer and stay on the per-entity path.
pub fn entity_section_spans_cover_the_border_and_fail_open() void {
}
    // rust: let span = |lo: [f64; 3], hi: [f64; 3], bottom_y: i32| {
    // rust: entity_section_span(
    // rust: Aabb::new(
    // rust: Vec3::new(lo[0], lo[1], lo[2]),
    // rust: Vec3::new(hi[0], hi[1], hi[2]),
    // rust: ),
    // rust: bottom_y,
    // rust: )
}

        // A chicken well inside one section stays in it.
    // rust: assert_eq!(
    // rust: span([100.2, -63.4, 7.1], [100.6, -62.9, 7.5], -64),
    // rust: Some(([6, 0, 0], [6, 0, 0]))
    // rust: );
        // A box 0.8 wide inside the next section does not spill out of it.
    // rust: assert_eq!(
    // rust: span([16.6, -60.0, 100.6], [17.4, -59.4, 101.4], -64),
    // rust: Some(([1, 0, 6], [1, 0, 6]))
    // rust: );
        // On a section border the model reaches the section either side.
    // rust: assert_eq!(
    // rust: span([16.0, -60.0, 100.0], [16.0, -59.0, 100.0], -64),
    // rust: Some(([0, 0, 6], [1, 0, 6]))
    // rust: );
        // `bottom_y` places section 0: the same box in the Nether.
    // rust: assert_eq!(
    // rust: span([100.2, -63.4, 7.1], [100.6, -62.9, 7.5], 0),
    // rust: Some(([6, -4, 0], [6, -4, 0]))
    // rust: );
        // Not finite, beyond `i32`, or more sections than the coverage cap:
        // no answer.
    // rust: assert_eq!(span([f64::NAN, 0.0, 0.0], [f64::NAN, 1.0, 1.0], -64), None);
    // rust: assert_eq!(span([0.0; 3], [f64::INFINITY; 3], -64), None);
    // rust: assert_eq!(
    // rust: span([0.0; 3], [f64::from(i32::MAX) + 1.0, 1.0, 1.0], -64),
    // rust: None
    // rust: );
        // A beam across the world spans far more than the cap.
    // rust: assert_eq!(span([0.0, -63.0, 0.0], [1.0e6, -62.0, 1.0], -64), None);
}
}
    // rust: mod tests;
