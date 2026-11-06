//! Transpiled from Horizon Rust crate
//! Module: horizon-client_names
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Custom names: `NameTagItem.interactLivingEntity` and the name tag
//! (`EntityRenderer.submitNameTag`): above the head, facing the camera,
//! on a translucent black background, shown when the name is visible or the
//! mob is under the crosshair within 64 blocks, as its team's name tag
//! visibility allows, in the team's colours, with its score in the
//! objective displayed below names. Other players' names (on a LAN host
//! or a server) show whenever `LivingEntityRenderer.shouldShowName` allows,
//! and the player's own in third person with the `ownNameTag` extra.
// use super::{Game, view_vector};
// use horizon_client::{
    // rust: block_entity_render::vertex_light, hud::HudBatch, mesher::Vertex, mobs::Mob, mod_api,
    // rust: save::uuid_text, scoreboard as sb, text::Text,
}

/// The world size of one text pixel in a name tag: `Matrix4f.scale(0.025F, -0.025F, 0.025F)`.
    // rust: pub(super) const NAME_TAG_UNIT: f32 = 0.025;

    // rust: impl Game<'_> {
    /// A named name tag names the mob under the crosshair.
    // rust: pub(super) fn name_mob(&mut self, index: usize) -> bool {
    // rust: let Some(name) = self
    // rust: .held()
    // rust: .filter(|h| &*h.item == "minecraft:name_tag")
    // rust: .and_then(|h| h.custom_name())
    // rust: else {
    // rust: return false;
}
    // rust: let m = &mut self.mobs[index];
    // rust: if !m.alive() {
    // rust: return false;
}
    // rust: let entity_id = m.id;
    // rust: let entity_name = name.clone();
    // rust: m.custom_name = Some(name);
    // rust: m.persistent = true;
        // itemStack.shrink(1), in creative too.
    // rust: self.consume_held();
    // rust: self.swing_arm();
    // rust: if let (Some(player), Some(player_name)) =
    // rust: (self.lan_acting_uuid, self.lan_acting_name.clone())
    // rust: {
    // rust: self.native_player_name_entity(player, &player_name, entity_id, &entity_name);
}
    // rust: true
}
    /// `Entity.belowNameDisplay`: the score holder's score in the objective
    /// shown below names, then a space and the objective's name.
pub fn below_name_text(self: *Self, holder: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let board = &self.score.board;
    // rust: let objective = board.display_objective(sb::SLOT_BELOW_NAME)?;
    // rust: let score = board.score(holder, &objective.name)?;
        // numberFormatOrDefault(StyledFormat.NO_STYLE).
    // rust: let format = score
    // rust: .number_format
    // rust: .clone()
    // rust: .or_else(|| objective.number_format.clone())
    // rust: .unwrap_or(sb::NumberFormat::Styled(serde_json::json!({})));
    // rust: let mut t = Text::empty();
    // rust: t.push(format.format(score.value));
    // rust: t.push(Text::literal(" "));
    // rust: t.push(objective.display_text());
    // rust: Some(t)
}
    /// The other players' models and names: the players a server sends.
pub fn other_players(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Vec::new();
    // rust: for (id, name) in self.remote_player_names() {
    // rust: if let Some(m) = self.mobs.iter().find(|m| m.id == id) {
    // rust: out.push((m, name));
}
}
    // rust: out
}
    /// Horizon's own name tag extra (`ownNameTag`): the player's own model and
    /// name, while that model shows in third person. Vanilla never names the
    /// camera entity (`LivingEntityRenderer.shouldShowName`).
pub fn own_name_tag(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.settings.extras.own_name_tag
    // rust: || self.camera_type.first_person()
    // rust: || self.sleeping.is_some()
    // rust: || self.spectator()
    // rust: || self.own_invisible()
    // rust: {
    // rust: return None;
}
    // rust: let m = self.player_model.as_ref()?;
    // rust: Some((m, self.own_profile_name()))
}
    /// The local player's profile name as others see it: the session's on a
    /// server (single player's server thread included), else the local player's.
    // rust: pub(super) fn own_profile_name(&self) -> String {
    // rust: match self.remote.as_ref() {
    // rust: Some(r) if !r.profile_name.is_empty() => r.profile_name.clone(),
    // rust: _ => self.acting_player_name().to_owned(),
}
}
    /// The names the name tags show this frame (the control socket's status).
    // rust: pub(super) fn shown_name_tags(&self, camera: glam::DVec3) -> Vec<String> {
    // rust: self.name_tags(camera, 1.0)
    // rust: .into_iter()
    // rust: .filter_map(|t| t.lines.last().map(|(t, _)| t.plain()))
    // rust: .collect()
}
    /// Vanilla name bounds for a native render snapshot; never re-enters name hooks.
    // rust: pub(super) fn client_name_tag_widths(
    // rust: &self,
    // rust: camera: glam::DVec3,
    // rust: alpha: f64,
    // rust: ) -> std::collections::HashMap<[u64; 3], f32> {
    // rust: self.name_tags_with_hooks(camera, alpha, false)
    // rust: .into_iter()
    // rust: .map(|tag| {
    // rust: let width = tag
    // rust: .lines
    // rust: .iter()
    // rust: .map(|(text, _)| self.gui.atlas.font.width_text(text) * NAME_TAG_UNIT * 0.5)
    // rust: .fold(0.0, f32::max);
    // rust: (tag.at.to_array().map(f64::to_bits), width)
    // rust: })
    // rust: .collect()
}
    /// Each name tag this frame.
pub fn name_tags(self: *Self, camera: glam::DVec3, alpha: f64) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.name_tags_with_hooks(camera, alpha, !mod_api::mods().is_empty())
}
pub fn name_tags_with_hooks(self: *Self, camera: glam::DVec3, alpha: f64, hooks: bool) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let target = self.mob_hit().map(|(i, _, _)| self.mobs[i].id);
    // rust: let viewer = self.player_team();
    // rust: let mut tags = Vec::new();
    // rust: let players = self.other_players();
    // rust: let player_ids = named_by_player_list(&players);
    // rust: let named = self.mobs.iter().filter_map(|m| {
            // Already named by the player list: a second tag would sit on the
            // first (`named_by_player_list`).
    // rust: if player_ids.contains(&m.id) {
    // rust: return None;
}
            // A mannequin with no name still shows its description.
    // rust: let name = match &m.custom_name {
    // rust: Some(name) => name.clone(),
    // rust: None if hooks || m.species() == horizon_client::mobs::Species::Mannequin => {
    // rust: String::new()
}
    // rust: None => return None,
}
            // The tag's 64 block distance is measured to the entity: copy the
            // name only for a mob the frame can show it on.
    // rust: let at = glam::DVec3::new(m.position.x, m.position.y, m.position.z);
    // rust: (at.distance_squared(camera) < 64.0 * 64.0).then_some((m, name, false))
    // rust: });
    // rust: let own = self.own_name_tag().map(|(m, _)| m.id);
    // rust: let players = players
    // rust: .into_iter()
    // rust: .chain(self.own_name_tag())
    // rust: .map(|(m, name)| (m, name, true));
        // Who is riding whom: asked once per tag below, and rescanning every entity
        // for each tag made this quadratic in the number of loaded entities.
    // rust: let local_entity_id = self.remote.as_ref().map(|r| r.entity_id as u32);
    // rust: let ridden = collect_vehicle_ids(
    // rust: &self.mobs,
    // rust: self.remote_vehicle_ids(),
    // rust: self.riding,
    // rust: local_entity_id,
    // rust: );
    // rust: for (m, name, player) in named.chain(players) {
    // rust: if !m.alive() {
    // rust: continue;
}
            // EntityAttachment.NAME_TAG: 0.5 above the box of the current pose.
    // rust: let p = name_tag_at(m, alpha);
            // The name tag distance (64) is measured to the entity.
    // rust: let distance_sqr =
    // rust: glam::DVec3::new(m.position.x, m.position.y, m.position.z).distance_squared(camera);
    // rust: if distance_sqr >= 64.0 * 64.0 {
    // rust: continue;
}
            // A player's scores and team go by name, a mob's by UUID.
    // rust: let holder = if player {
    // rust: Some(name.clone())
    // rust: } else {
    // rust: self.persist.uuids.get(&m.id).map(|u| uuid_text(*u))
}
    // rust: let team = if player {
    // rust: self.score.board.players_team(&name)
    // rust: } else {
    // rust: self.mob_team_of(m)
}
            // LivingEntityRenderer.shouldShowName (team rules included), then
            // MobRenderer: a visible name, or the mob under the crosshair.
    // rust: let invisible = sb::invisible_to(
    // rust: team,
    // rust: viewer,
    // rust: self.spectator(),
    // rust: m.invisible || m.has_effect("minecraft:invisibility"),
    // rust: );
            // Entity.isDiscrete: a crouching player.
    // rust: let discrete = player && m.extra.crouching;
    // rust: let view = sb::NameView {
    // rust: discrete,
    // rust: distance_sqr,
    // rust: invisible_to_viewer: invisible,
    // rust: hud_hidden: self.ui.hide_gui,
    // rust: is_camera: false,
    // rust: is_vehicle: ridden.contains(&m.id),
}
            // MobRenderer.shouldShowName: a visible name, or the mob under the
            // crosshair; players (LivingEntityRenderer) need neither.
            // `ClientMannequin.belowNameDisplay`: the description is `scoreText`, drawn
            // within the below-name distance (10) whether the name shows or not.
    // rust: let description = (m.species() == horizon_client::mobs::Species::Mannequin
    // rust: && distance_sqr < 10.0 * 10.0)
    // rust: .then(|| m.extra.description.component())
    // rust: .flatten()
    // rust: .map(|tag| horizon_client::entity_nbt::name_text(&tag).resolve_legacy());
    // rust: let is_own = Some(m.id) == own;
    // rust: let name_shown = sb::name_shown(team, viewer, view)
    // rust: && (!is_own || !view.is_vehicle)
    // rust: && (player || m.name_visible || Some(m.id) == target)
    // rust: && (player || m.custom_name.is_some());
    // rust: let mut visible = name_shown;
    // rust: let mut text = None;
    // rust: if hooks {
    // rust: self.native_render_name_tag(
    // rust: m.id,
    // rust: if player {
    // rust: "minecraft:player"
    // rust: } else {
    // rust: &m.kind.id
    // rust: },
    // rust: name_shown,
    // rust: &mut visible,
    // rust: &mut text,
    // rust: );
}
    // rust: if !visible {
    // rust: if let Some(text) = description {
    // rust: let l = self.world.light(
    // rust: m.position.x.floor() as i32,
    // rust: (m.position.y + f64::from(m.height())).floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: );
    // rust: tags.push(NameTag {
    // rust: at: p,
    // rust: lines: vec![(text, 0.0)],
    // rust: light: l,
    // rust: discrete,
    // rust: marks: Marks::default(),
    // rust: });
}
    // rust: continue;
}
            // getDisplayName: the name in the team's prefix, suffix and colour.
    // rust: let member = if player {
    // rust: Text::literal(&name)
    // rust: } else {
    // rust: m.custom_name_text
    // rust: .clone()
    // rust: .unwrap_or_else(|| Text::literal(&name))
}
            // StringDecomposer.iterateFormatted: `§` codes a server leaves
            // inside the team prefix or the name itself apply at draw time.
    // rust: let shown = match team {
    // rust: Some(t) => t.formatted_name(member),
    // rust: None => member,
}
    // rust: .resolve_legacy();
    // rust: let shown = text
    // rust: .map(|text| Text::literal(text).resolve_legacy())
    // rust: .unwrap_or(shown);
    // rust: let mut lines = Vec::new();
            // EntityRenderer.extractNameTags: the score shows within the
            // below-name distance (10), under the name.
    // rust: let mut lift = 0.0;
    // rust: if m.species() == horizon_client::mobs::Species::Mannequin {
    // rust: if let Some(text) = description {
    // rust: lines.push((text, 0.0));
    // rust: lift = f64::from(9.0f32 * 1.15 * 0.025);
}
    // rust: } else if distance_sqr < 10.0 * 10.0
    // rust: && let Some(score) = holder.and_then(|h| self.below_name_text(&h))
    // rust: {
    // rust: lines.push((score.resolve_legacy(), 0.0));
    // rust: lift = f64::from(9.0f32 * 1.15 * 0.025);
}
    // rust: lines.push((shown, lift));
    // rust: let l = self.world.light(
    // rust: m.position.x.floor() as i32,
    // rust: (m.position.y + f64::from(m.height())).floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: );
            // Horizon's mark before a Horizon player's name and their name tag style (cosmetics).
    // rust: let marks = if player || self.cosmetics_local() {
    // rust: self.cosmetics_marks(m, Some(m.id) == own)
    // rust: } else {
    // rust: Marks::default()
}
            // Horizon: over a tall cosmetic. Without one, vanilla's height, untouched.
    // rust: let at = match marks.top {
    // rust: Some(top) => p + glam::DVec3::Y * cosmetic_lift(top, m.model_scale()),
    // rust: None => p,
}
    // rust: tags.push(NameTag {
    // rust: at,
    // rust: lines,
    // rust: light: l,
    // rust: discrete,
    // rust: marks,
    // rust: });
}
    // rust: drop(player_ids);
        // Armor stands name themselves: an invisible one with a visible name
        // is a hologram (its model is skipped, its name tag is not).
    // rust: for a in &self.armor_stands {
    // rust: if !hooks {
    // rust: let Some(_) = &a.custom_name else {
    // rust: continue;
}
    // rust: if !a.name_visible {
    // rust: continue;
}
}
    // rust: let height = match (a.marker, a.small) {
    // rust: (true, _) => 0.0,
    // rust: (false, true) => 0.9875,
    // rust: (false, false) => 1.975,
}
    // rust: let distance_sqr =
    // rust: glam::DVec3::new(a.position.x, a.position.y, a.position.z).distance_squared(camera);
    // rust: if distance_sqr >= 64.0 * 64.0 {
    // rust: continue;
}
    // rust: let team = self.mob_team(a.id);
    // rust: let invisible = sb::invisible_to(team, viewer, self.spectator(), false);
    // rust: let view = sb::NameView {
    // rust: discrete: false,
    // rust: distance_sqr,
    // rust: invisible_to_viewer: invisible,
    // rust: hud_hidden: self.ui.hide_gui,
    // rust: is_camera: false,
    // rust: is_vehicle: false,
}
    // rust: let name_shown =
    // rust: a.custom_name.is_some() && a.name_visible && sb::name_shown(team, viewer, view);
    // rust: let mut visible = name_shown;
    // rust: let mut text = None;
    // rust: if hooks {
    // rust: self.native_render_name_tag(
    // rust: a.id,
    // rust: "minecraft:armor_stand",
    // rust: name_shown,
    // rust: &mut visible,
    // rust: &mut text,
    // rust: );
}
    // rust: if !visible {
    // rust: continue;
}
    // rust: let name = a.custom_name.clone().unwrap_or_else(Text::empty);
    // rust: let shown = match team {
    // rust: Some(t) => t.formatted_name(name.clone()),
    // rust: None => name.clone(),
}
    // rust: .resolve_legacy();
    // rust: let shown = text
    // rust: .map(|text| Text::literal(text).resolve_legacy())
    // rust: .unwrap_or(shown);
    // rust: let mut lines = Vec::new();
    // rust: let mut lift = 0.0;
    // rust: let holder = self.persist.uuids.get(&a.id).map(|u| uuid_text(*u));
    // rust: if distance_sqr < 10.0 * 10.0
    // rust: && let Some(score) = holder.and_then(|h| self.below_name_text(&h))
    // rust: {
    // rust: lines.push((score.resolve_legacy(), 0.0));
    // rust: lift = f64::from(9.0f32 * 1.15 * 0.025);
}
    // rust: lines.push((shown, lift));
            // The tag rides with the body, between last tick's position and this one's.
    // rust: let at = a.render_position(alpha);
    // rust: let l = self.world.light(
    // rust: at.x.floor() as i32,
    // rust: (at.y + height).floor() as i32,
    // rust: at.z.floor() as i32,
    // rust: );
    // rust: tags.push(NameTag {
    // rust: at: glam::DVec3::new(at.x, at.y + height + 0.5, at.z),
    // rust: lines,
    // rust: light: l,
    // rust: discrete: false,
    // rust: marks: Marks::default(),
    // rust: });
}
        // ItemFrameRenderer.shouldShowName/getNameTag: only the targeted
        // frame's custom-named item, with the HUD visible (also glow frames).
    // rust: let targeted_frame = (hooks || !self.ui.hide_gui)
    // rust: .then(|| self.frame_hit())
    // rust: .flatten()
    // rust: .filter(|(_, distance)| {
    // rust: self.before_block(*distance) && self.mob_hit().is_none_or(|(_, d, _)| d > *distance)
    // rust: })
    // rust: .map(|(index, _)| index);
    // rust: let frames = if hooks {
    // rust: 0..self.item_frames.len()
    // rust: } else {
    // rust: targeted_frame.map_or(0..0, |index| index..index + 1)
}
    // rust: for index in frames {
    // rust: let frame = &self.item_frames[index];
    // rust: let name = frame.item.as_ref().and_then(|item| item.custom_name());
    // rust: if !hooks && name.is_none() {
    // rust: continue;
}
    // rust: let (lo, hi) = frame.bounds();
    // rust: let center = glam::DVec3::from_array(std::array::from_fn(|a| (lo[a] + hi[a]) / 2.0));
    // rust: if center.distance_squared(camera) < 64.0 * 64.0 {
    // rust: let name_shown =
    // rust: !self.ui.hide_gui && targeted_frame == Some(index) && name.is_some();
    // rust: let mut visible = name_shown;
    // rust: let mut text = None;
    // rust: if hooks {
    // rust: self.native_render_name_tag(
    // rust: frame.id,
    // rust: frame.kind(),
    // rust: name_shown,
    // rust: &mut visible,
    // rust: &mut text,
    // rust: );
}
    // rust: if !visible {
    // rust: continue;
}
                // NAME_TAG is at the entity height (0.5), then the name
                // submitter lifts it 0.5. ItemFrameRenderer offsets rendering
                // 0.3 toward its facing and -0.25 vertically.
    // rust: let step = frame.step();
    // rust: tags.push(NameTag {
    // rust: at: center
    // rust: + glam::DVec3::new(
    // rust: f64::from(step[0] as f32 * 0.3),
    // rust: 0.75,
    // rust: f64::from(step[2] as f32 * 0.3),
    // rust: ),
    // rust: lines: vec![(
    // rust: Text::literal(text.or(name).unwrap_or_default()).resolve_legacy(),
    // rust: 0.0,
    // rust: )],
    // rust: light: self.world.light(
    // rust: center.x.floor() as i32,
    // rust: center.y.floor() as i32,
    // rust: center.z.floor() as i32,
    // rust: ),
    // rust: discrete: false,
    // rust: marks: Marks::default(),
    // rust: });
}
}
    // rust: tags
}
    /// `SubmitNodeCollection.submitNameTag`: a discrete name is drawn once,
    /// faded, on its background; any other in full over the world, its faded
    /// copy and background in `see_through`, over everything.
    // rust: pub(super) fn name_tag_geometry(
    // rust: &mut self,
    // rust: camera: glam::DVec3,
    // rust: alpha: f64,
    // rust: out: &mut Vec<Vertex>,
    // rust: see_through: &mut Vec<Vertex>,
    // rust: ) {
        // The text alpha that goes with getBackgroundOpacity(0.25):
        // max((0.25 + 0.75) / 2, 0.5), as ARGB.color (the floor of 255 times it).
pub const FADED: u32 = 0x7F;
    // rust: let mut patches = Vec::new();
    // rust: for tag in self.name_tags(camera, alpha) {
    // rust: let o = tag.at - camera;
            // `gbuffers_entities` draws name tag text (2.3); a sneaking player's faded tag, on its
            // background, blends.
    // rust: if tag.discrete {
    // rust: self.mark_translucent_entity(out.len(), "minecraft:name_tag");
    // rust: let light = vertex_light(tag.light);
    // rust: patches.extend(self.styled_name_tag_quads(
    // rust: o,
    // rust: &tag.lines,
    // rust: FADED,
    // rust: true,
    // rust: 0,
    // rust: light,
    // rust: NAME_TAG_UNIT,
    // rust: out,
    // rust: tag.marks,
    // rust: ));
    // rust: continue;
}
            // LightCoordsUtil.lightCoordsWithEmission(lightCoords, 2).
    // rust: let lit = (tag.light >> 4).max(2) << 4 | (tag.light & 15).max(2);
    // rust: self.mark_entity(out.len(), "minecraft:name_tag");
    // rust: let light = vertex_light(lit);
    // rust: patches.extend(self.styled_name_tag_quads(
    // rust: o,
    // rust: &tag.lines,
    // rust: 0xFF,
    // rust: false,
    // rust: 0,
    // rust: light,
    // rust: NAME_TAG_UNIT,
    // rust: out,
    // rust: tag.marks,
    // rust: ));
            // RenderPipelines.TEXT_SEE_THROUGH: no depth test, no lightmap.
    // rust: patches.extend(self.styled_name_tag_quads(
    // rust: o,
    // rust: &tag.lines,
    // rust: FADED,
    // rust: true,
    // rust: 2,
    // rust: 0,
    // rust: NAME_TAG_UNIT,
    // rust: see_through,
    // rust: tag.marks,
    // rust: ));
}
    // rust: self.map_patches.extend(patches);
}
    /// The lines of one name tag, `o` from the camera: the text at
    /// `text_alpha` in its layer, on the translucent black background
    /// (in `text_layer` like the glyphs, a hair behind) when `background`.
    /// Returns the glyph pixels the atlas still needs.
    // rust: pub(super) fn name_tag_quads(
    // rust: &self,
    // rust: o: glam::DVec3,
    // rust: lines: &[(Text, f64)],
    // rust: text_alpha: u32,
    // rust: background: bool,
    // rust: text_layer: u32,
    // rust: light: u32,
    // rust: unit: f32,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) -> Vec<horizon_client::font::Patch> {
    // rust: self.styled_name_tag_quads(
    // rust: o,
    // rust: lines,
    // rust: text_alpha,
    // rust: background,
    // rust: text_layer,
    // rust: light,
    // rust: unit,
    // rust: out,
    // rust: Marks::default(),
    // rust: )
}

    /// [`Self::name_tag_quads`], with Horizon's marks on the last line (the name): the Horizon
    /// player's mark before the text, a name tag style's badge after it and its line under the
    /// background.
    // rust: fn styled_name_tag_quads(
    // rust: &self,
    // rust: o: glam::DVec3,
    // rust: lines: &[(Text, f64)],
    // rust: text_alpha: u32,
    // rust: background: bool,
    // rust: text_layer: u32,
    // rust: light: u32,
    // rust: unit: f32,
    // rust: out: &mut Vec<Vertex>,
    // rust: marks: Marks,
    // rust: ) -> Vec<horizon_client::font::Patch> {
        // Options.getBackgroundOpacity(0.25) black, as ARGB.color.
pub const BACKGROUND: u32 = 0x3F00_0000;
        // The camera's facing (Camera.rotation()), turned round in third-person
        // front view, so the text reads the right way from where it is seen.
    // rust: let (view_yaw, view_pitch) = match self.posed_rotation {
            // The frame's camera, already turned round in front view.
    // rust: Some(rotation) => rotation,
    // rust: None if self.camera_type == super::perspective::CameraType::ThirdPersonFront => {
    // rust: (self.yaw + 180.0, -self.pitch)
}
    // rust: None => (self.yaw, self.pitch),
}
    // rust: let forward = glam::DVec3::from_array(view_vector(view_yaw, view_pitch));
    // rust: let right = forward.cross(glam::DVec3::Y).normalize_or_zero();
    // rust: let up = right.cross(forward).normalize_or_zero();
    // rust: let away = forward.as_vec3() * 0.002;
    // rust: let mut batch = HudBatch::new([1, 1]);
    // rust: let last = lines.len().saturating_sub(1);
    // rust: for (n, (text, lift)) in lines.iter().enumerate() {
    // rust: let o = (o + glam::DVec3::new(0.0, *lift, 0.0)).as_vec3();
    // rust: let (r, u) = (right.as_vec3() * unit, up.as_vec3() * unit);
            // Text space: x right, y down (scale 0.025, -0.025).
    // rust: let at = |x: f32, y: f32| o + r * x - u * y;
    // rust: let y0 = if text.plain() == "deadmau5" {
    // rust: -10.0
    // rust: } else {
    // rust: 0.0
}
    // rust: batch.vertices.clear();
            // Font.prepareText, as any text: bold, italic, fonts and each
            // glyph's own box (accented.png's are 12 pixels tall).
    // rust: let behind = batch.name_tag(
    // rust: &self.gui.atlas,
    // rust: text,
    // rust: y0,
    // rust: text_alpha << 24 | 0xFF_FFFF,
    // rust: if background { BACKGROUND } else { 0 },
    // rust: );
    // rust: if n == last && marks.horizon {
    // rust: let x = -self.gui.atlas.font.width_text(text) / 2.0 - 10.0;
                // 8 text pixels square, a pixel left of the background.
    // rust: for (mx, my, w, h, argb) in horizon_cosmetics::mark::MARK {
    // rust: let a = text_alpha * (argb >> 24) / 255;
    // rust: batch.fill(
    // rust: &self.gui.atlas,
    // rust: x + f32::from(mx),
    // rust: y0 + f32::from(my),
    // rust: f32::from(w),
    // rust: f32::from(h),
    // rust: horizon_client::hud_layout::abgr(a << 24 | argb & 0xFF_FFFF),
    // rust: );
}
}
    // rust: if let Some(style) = marks.style.filter(|_| n == last) {
    // rust: let width = self.gui.atlas.font.width_text(text);
    // rust: let x = -width / 2.0;
    // rust: let alpha = text_alpha << 24;
                // The badge, 8 text pixels square, a pixel right of the background.
    // rust: batch.rect_uv(x + width + 2.0, y0, 8.0, 8.0, style.mark, alpha | 0xFF_FFFF);
                // The line, a pixel tall, under the background (which runs from -1 to 9).
    // rust: batch.fill(
    // rust: &self.gui.atlas,
    // rust: x - 1.0,
    // rust: y0 + 9.0,
    // rust: width + 1.0,
    // rust: 1.0,
                    // The batch takes RGBA: the line as ARGB, swapped.
    // rust: horizon_client::hud_layout::abgr(alpha | style.line),
    // rust: );
}
    // rust: for (i, quad) in batch.vertices.as_chunks::<6>().0.iter().enumerate() {
    // rust: let shift = if i * 6 < behind {
    // rust: away
    // rust: } else {
    // rust: glam::Vec3::ZERO
}
                // The corners from the bottom left, as the world draws quads.
    // rust: for v in [quad[5], quad[2], quad[1], quad[0]] {
    // rust: out.push(Vertex {
    // rust: normal: [0; 4],
    // rust: pos: (at(v.pos[0], v.pos[1]) + shift).to_array(),
    // rust: uv: v.uv,
    // rust: layer: text_layer,
    // rust: color: v.color,
    // rust: light,
    // rust: glint_uv: [0.0, 0.0],
    // rust: });
}
}
}
        // Glyphs rasterized on first use (Unifont's) upload with the frame.
    // rust: batch.patches
}
}

/// Collect entity IDs of all vehicles: entities that have passengers
/// (`passenger_vehicles`: what every entity the server sent rides, text displays,
/// armor stands, item displays and interactions included; vanilla's `isVehicle` is
/// any passenger at all).
///
/// On multiplayer servers (e.g. `mcpvp.club`), server plugins hang custom nametags
/// (ranks, prefixes, stats) over players using `TextDisplay` or `ArmorStand` passengers.
/// In vanilla `LivingEntityRenderer.shouldShowName`, a vehicle does not show its default
/// name tag (`!entity.isVehicle()`).
///
/// If the local player's remote entity ID is in the set, ID 0 (`player_model`) is also
/// added so that Horizon's own name tag extra (`ownNameTag`) recognizes that the player
/// is ridden and suppresses the duplicate tag (#9477).
    // rust: fn collect_vehicle_ids(
    // rust: mobs: &[Mob],
    // rust: passenger_vehicles: impl IntoIterator<Item = u32>,
    // rust: local_riding: Option<u32>,
    // rust: local_entity_id: Option<u32>,
    // rust: ) -> std::collections::HashSet<u32> {
    // rust: let mut ridden: std::collections::HashSet<u32> = mobs
    // rust: .iter()
    // rust: .filter_map(|o| o.extra.mount)
    // rust: .chain(mobs.iter().filter_map(|m| m.extra.rider.map(|_| m.id)))
    // rust: .chain(passenger_vehicles)
    // rust: .collect();
    // rust: if let Some(riding) = local_riding {
    // rust: ridden.insert(riding);
}
    // rust: if let Some(id) = local_entity_id
    // rust: && ridden.contains(&id)
    // rust: {
        // The local player's model has id 0 (player_model).
    // rust: ridden.insert(0);
}
    // rust: ridden
}

/// The entity ids the player-list pass names, which the custom-name pass must
/// therefore skip.
///
/// Vanilla draws one tag per entity, and names a player from its profile:
/// `Player.getName` overrides `Entity.getName` and ignores `customName`. So a
/// server that sets a custom name on a player entity -- a rank, a nickname, a
/// prefix -- must not get a tag of its own drawn over the one the player list
/// already draws.
///
/// Built whether or not native mods are loaded. It was briefly built only with
/// them, as a fast path, and without them both tags were drawn on top of each
/// other on every server that names its players this way. The set is small --
/// the players in view -- and `other_players` has already allocated a name
/// string for each, so skipping it saved very little.
pub fn named_by_player_list(players: *[(*Mob) void {
}
    // rust: players.iter().map(|(player, _)| player.id).collect()
}
/// `EntityAttachment.NAME_TAG`: `(0, bbHeight, 0)` of the box of the entity's
/// current pose, which the submitter lifts 0.5 more, between the last two tick
/// positions. The player box is `Pose::dimensions(1.0)`.
/// shortcut: the scale attribute is not in the tag height, add `model_scale`
/// when tags on scaled players matter.
    // rust: pub(super) fn name_tag_at(m: &Mob, alpha: f64) -> glam::DVec3 {
    // rust: glam::DVec3::new(
    // rust: m.previous.x + (m.position.x - m.previous.x) * alpha,
    // rust: m.previous.y + (m.position.y - m.previous.y) * alpha + f64::from(m.height()) + 0.5,
    // rust: m.previous.z + (m.position.z - m.previous.z) * alpha,
    // rust: )
}

/// Horizon: how far a player's name tag goes up so that it clears the tallest cosmetic drawn on
/// them, `top` pixels above the model's neck (`Item::top`) on a player of `scale`
/// (`LivingEntity.getScale`); 0 when the item stays under vanilla's tag. Measured standing: the
/// model's neck is 1.501 blocks up, times `AvatarRenderer.scale`'s 0.9375 and `scale`; the tag's
/// lowest pixel (the style's line under the background, 10 text pixels under the anchor) is at
/// 1.8 + 0.5 - 10 × 0.025 = 2.05 blocks, and the lift leaves one text pixel between them. Other
/// poses keep the same lift: crouching lowers the model more (0.39 blocks) than the tag (0.3).
    // rust: pub(super) fn cosmetic_lift(top: f32, scale: f32) -> f64 {
    // rust: let item = f64::from(scale) * 0.9375 * (1.501 + f64::from(top) / 16.0);
    // rust: let unit = f64::from(NAME_TAG_UNIT);
    // rust: let bottom = 1.8 + 0.5 - 10.0 * unit;
    // rust: (item + unit - bottom).max(0.0)
}

/// A name tag: where it hangs, its lines (text, lift), the packed light at
/// the entity and whether it is discrete.
pub const NameTag = struct {
    at: glam::DVec3,
    lines: Vec<(Text,
    light: u8,
    discrete: bool,
    marks: Marks,
};

/// What Horizon draws by a player's name: its mark (they play Horizon) and their name tag style.
    // rust: pub(super) struct Marks {
    // rust: pub horizon: bool,
    // rust: pub style: Option<TagStyle>,
    /// How high the cosmetics drawn on their body get above the neck, in model pixels: the tag
    /// goes up over a tall one (`cosmetic_lift`).
    // rust: pub top: Option<f32>,
}

/// A cosmetic name tag style: a badge after the name and a line under it.
    // rust: pub(super) struct TagStyle {
    /// The mark's place in the GUI atlas.
    // rust: pub mark: horizon_client::hud::Rect,
    /// The line's colour, `0xrrggbb`.
    // rust: pub line: u32,
}

    // rust: mod tests {
//     use super::*;
//     use horizon_client::mobs::{Anim, Brain, MobType, Part, Species};
//     use horizon_client::pose::Pose;
//     use horizon_core::geometry::Vec3;
//     use std::sync::Arc;

    /// The player model `perspective::player_type` builds from the prepared
    /// resources, without them: its box only needs the id and the pointer.
pub fn player_mob() M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let part = Part {
    // rust: name: "root".into(),
    // rust: pose: [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0],
    // rust: polygons: Vec::new(),
    // rust: children: Vec::new(),
}
    // rust: let kind = MobType {
    // rust: id: "minecraft:player".into(),
    // rust: species: Species::Zombie,
    // rust: width: 0.6,
    // rust: height: 1.8,
    // rust: eye_height: 1.62,
    // rust: category: "misc".into(),
    // rust: max_health: 20.0,
    // rust: speed: 0.1,
    // rust: flying_speed: 0.02,
    // rust: attack_damage: 1.0,
    // rust: attack_knockback: 0.0,
    // rust: follow_range: 0.0,
    // rust: step_height: 0.6,
    // rust: armor: 0.0,
    // rust: armor_toughness: 0.0,
    // rust: knockback_resistance: 0.0,
    // rust: jump_strength: 0.42,
    // rust: attributes: Default::default(),
    // rust: item_stack_limits: Default::default(),
    // rust: gravity: 0.08,
    // rust: safe_fall_distance: 3.0,
    // rust: fall_damage_multiplier: 1.0,
    // rust: water_efficiency: 0.0,
    // rust: water_slowdown: 0.8,
    // rust: air_speed: 0.02,
    // rust: baby_scale: 0.5,
    // rust: head_rot_speed: 10.0,
    // rust: max_head_x_rot: 40.0,
    // rust: max_head_y_rot: 75.0,
    // rust: ambient_interval: 80,
    // rust: flags: Default::default(),
    // rust: model: Arc::new(part),
    // rust: layers: Default::default(),
    // rust: texture: String::new(),
    // rust: brain: Brain::Passive,
    // rust: anim: Anim::Humanoid { zombie_arms: false },
    // rust: sounds: [
    // rust: "entity.player.hurt",
    // rust: "entity.player.hurt",
    // rust: "entity.player.death",
    // rust: ],
    // rust: step_sound: None,
    // rust: food: Default::default(),
    // rust: tempt: Default::default(),
}
    // rust: Mob::new(0, Arc::new(kind), Vec3::ZERO, 0.0)
}

    /// A server that names its players -- a rank prefix, a nickname -- sets a
    /// custom name on the player entity. The player list already names that
    /// player, so the custom-name pass has to skip it or the two tags are drawn
    /// on top of each other. The set of already-named players was briefly built
    /// only when native mods were loaded, so without mods every such server
    /// showed the pair overlapping.
    ///
    /// An entity the player list does not name keeps its own tag: that is how a
    /// shopkeeper NPC spawned as a player entity is named at all.
pub fn a_listed_player_is_named_once_whatever_custom_name_a_server_sets() void {
}
    // rust: let mut listed = player_mob();
    // rust: listed.id = 7;
    // rust: listed.custom_name = Some("[MVP+] Steve".to_owned());
    // rust: let mut unlisted = player_mob();
    // rust: unlisted.id = 9;
    // rust: unlisted.custom_name = Some("Shopkeeper".to_owned());
        // The player list names 7 and knows nothing of 9.
    // rust: let players = vec![(&listed, "Steve".to_owned())];
    // rust: let named = named_by_player_list(&players);
    // rust: assert!(
    // rust: named.contains(&listed.id),
    // rust: "the player list names 7, so its custom name must not add a second tag"
    // rust: );
    // rust: assert!(
    // rust: !named.contains(&unlisted.id),
    // rust: "9 is named by nothing else, so its custom name is its only tag"
    // rust: );
}

    /// #4129: the tag hangs from the box of the pose (0.6 swimming, 1.5
    /// crouching, 1.8 standing) and never from the sneak flag, which a
    /// sprint-swimming or gliding player still has set. Today's
    /// `if player && m.extra.crouching { 1.5 }` gives 2.0 for the first.
pub fn a_name_tag_hangs_from_the_pose_box_not_the_sneak_flag() void {
}
    // rust: let mut m = player_mob();
    // rust: let at_y = |m: &Mob| name_tag_at(m, 1.0).y;
    // rust: m.extra.crouching = true;
    // rust: m.extra.avatar_pose = Pose::Swimming;
    // rust: assert!((at_y(&m) - 1.1).abs() < 1e-6, "0.6 + 0.5, not 2.0");
        // A crouching player's tag keeps the height it had: 1.5 + 0.5.
    // rust: m.extra.avatar_pose = Pose::Crouching;
    // rust: assert!((at_y(&m) - 2.0).abs() < 1e-6, "1.5 + 0.5, as before");
    // rust: m.extra.avatar_pose = Pose::Standing;
    // rust: m.extra.crouching = false;
    // rust: assert!((at_y(&m) - 2.3).abs() < 1e-6, "1.8 + 0.5");
}

    /// #9477: When server plugins attach a TextDisplay or ArmorStand to a player
    /// (e.g. rank prefixes on multiplayer lobbies), vanilla's `LivingEntityRenderer.shouldShowName`
    /// hides the default nametag because `entity.isVehicle()` is true.
    ///
    /// For the local player with `ownNameTag: true`, `player_model` has ID 0 while
    /// the server sends passengers for `local_entity_id`. `collect_vehicle_ids`
    /// maps `local_entity_id -> 0` so that `ownNameTag` is not drawn twice over the
    /// server's rider nametag.
pub fn vehicle_with_text_display_or_armor_stand_passenger_is_marked_ridden() void {
}
    // rust: let mut remote_player = player_mob();
    // rust: remote_player.id = 42;
    // rust: let mobs = vec![remote_player];

        // 1. TextDisplay riding remote player 42
    // rust: let ridden = collect_vehicle_ids(&mobs, vec![42], None, Some(100));
    // rust: assert!(
    // rust: ridden.contains(&42),
    // rust: "remote player 42 is ridden by text display"
    // rust: );
    // rust: assert!(!ridden.contains(&100), "local player 100 has no passenger");
    // rust: assert!(!ridden.contains(&0), "local model 0 has no passenger");

        // 2. ArmorStand riding local player 100 -> model 0 must be in ridden
    // rust: let ridden_local = collect_vehicle_ids(&mobs, vec![100], None, Some(100));
    // rust: assert!(
    // rust: ridden_local.contains(&100),
    // rust: "local player 100 is ridden by armor stand"
    // rust: );
    // rust: assert!(
    // rust: ridden_local.contains(&0),
    // rust: "local player model (id 0) must be mapped to vehicle so ownNameTag is suppressed (#9477)"
    // rust: );

        // 3. Name tag is suppressed for vehicles when team is None
    // rust: let view_vehicle = sb::NameView {
    // rust: is_vehicle: true,
    // rust: ..Default::default()
}
    // rust: assert!(
    // rust: !sb::name_shown(None, None, view_vehicle),
    // rust: "vanilla shouldShowName hides tag for vehicles with no team"
    // rust: );
}
}
