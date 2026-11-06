//! Transpiled from Horizon Rust crate
package horizon_client_glowing

import "core:fmt"
import "core:mem"
import "core:math"

// Glowing entities (`EntityRenderer.extractRenderState`'s outlineColor): which entities
// appear glowing, in which team colour, and their silhouettes for the renderer's entity
// outline (`OutlineBufferSource`).
// use super::{Game, Vertex};
// use horizon_client::{mobs::Mob, scoreboard as sb};

// `Entity.getTeamColor`: the team's colour, else white.
    // rust: pub(super) fn team_color(team: Option<&sb::Team>) -> u32 {
    // rust: team.and_then(|t| t.color.as_deref())
    // rust: .and_then(sb::team_color_rgb)
    // rust: .unwrap_or(0xFF_FFFF)
}

    // rust: impl Game<'_> {
    // `Entity.isCurrentlyGlowing` of an entity that is not living (an item, a projectile):
    // its `Glowing` tag, or shared flag 6 as a server sent it.
    // rust: pub(super) fn entity_glowing(&self, id: u32) -> bool {
    // rust: self.remote_glowing(id).unwrap_or_else(|| {
    // rust: self.persist_raw(id)
    // rust: .and_then(|t| horizon_client::save::number(t.get("Glowing")))
    // rust: .is_some_and(|b| b != 0)
    // rust: })
}

    // The outline an entity is drawn with: vanilla's (`Some` team colour when it glows),
    // then what mods made of it (`native_entity_outline`).
    // rust: pub(super) fn entity_outline(&self, id: u32, kind: &str, vanilla: Option<u32>) -> Option<u32> {
    // rust: let mut outline = vanilla;
    // rust: self.native_entity_outline(id, kind, &mut outline);
    // rust: outline.map(|rgb| rgb & 0xFF_FFFF)
}

    // The outline of a dropped item or projectile: its `Glowing` flag, in its team's colour.
    // rust: pub(super) fn thing_outline(&self, id: u32, kind: &str) -> Option<u32> {
    // rust: let vanilla = self
    // rust: .entity_glowing(id)
    // rust: .then(|| team_color(self.mob_team(id)));
    // rust: self.entity_outline(id, kind, vanilla)
}

    // `Minecraft.shouldEntityAppearGlowing` of a mob or another player, with its outline
    // colour (`getTeamColor`; another player's team goes by name).
    // rust: pub(super) fn mob_outline(&self, m: &Mob) -> Option<u32> {
    // rust: let vanilla = m.is_currently_glowing().then(|| {
    // rust: let team = if &*m.kind.id == "minecraft:player" {
    // rust: let names = self.remote_player_names();
    // rust: let name = names.into_iter().find(|(id, _)| *id == m.id);
    // rust: name.and_then(|(_, name)| self.score.board.players_team(&name))
    // rust: } else {
    // rust: self.mob_team_of(m)
}
    // rust: team_color(team)
    // rust: });
    // rust: self.entity_outline(m.id, &m.kind.id, vanilla)
}

    // Adds one glowing entity's geometry to the outline pass in `rgb`, the textures'
    // alpha kept (`OutlineBufferSource`'s team-coloured copy of each draw).
    // rust: pub(super) fn mark_outline(&self, vertices: &[Vertex], rgb: u32) {
    // rust: let color = horizon_client::mobs::render::abgr(rgb);
    // rust: self.glowing_vertices
    // rust: .borrow_mut()
    // rust: .extend(vertices.iter().map(|v| Vertex {
    // rust: color,
    // rust: normal: [0; 4],
    // rust: ..*v
    // rust: }));
}
}
