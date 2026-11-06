//! Transpiled from Horizon Rust crate
package horizon_client_jigsaw_blocks

import "core:fmt"
import "core:mem"
import "core:math"

// Jigsaw blocks on the server: `handleSetJigsawBlock` and
// `handleJigsawGenerate` (`JigsawBlockEntity.generate`), and the joint a
// placed jigsaw starts with.
// use super::{Game, lan::LanHost};
// use horizon_client::{
    // rust: containers::BlockEntity,
    // rust: jigsaw_block::{self, JigsawBlock, JointType},
}
// use horizon_protocol::packets::play;
// use horizon_world::{nbt::Tag, worldgen::generator::JigsawQuery};

    // rust: type Pos = (i32, i32, i32);

    // rust: impl Game<'_> {
jigsaw_block_mut :: proc(self: ^Self, pos: Pos) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self.world.block_entities.get_mut(&pos)? {
    // rust: BlockEntity::JigsawBlock(b) => Some(b),
    // rust: _ => None,
}
}

    // The block's front facing, from its `orientation` (`JigsawBlock.getFrontFacing`).
    // rust: pub(super) fn jigsaw_front(&self, pos: Pos) -> Option<String> {
    // rust: let state = self.world.block(pos.0, pos.1, pos.2);
    // rust: let orientation = self
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .state(state)?
    // rust: .properties
    // rust: .get("orientation")?;
    // rust: Some(jigsaw_block::front_of_orientation(orientation).to_owned())
}

    // `new JigsawBlockEntity(pos, state)`: the joint a block starts with
    // follows its facing (`StructureTemplate.getDefaultJointType`).
    // rust: pub(super) fn jigsaw_block_placed(&mut self, pos: Pos) {
    // rust: let Some(front) = self.jigsaw_front(pos) else {
    // rust: return;
}
    // rust: if let Some(b) = self.jigsaw_block_mut(pos) {
    // rust: b.joint = JointType::default_for_front(&front);
}
}

    // `handleSetJigsawBlock` for a guest: only a creative player with game
    // master commands edits the block.
    // rust: pub(super) fn lan_set_jigsaw_block(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: p: play::SetJigsawBlock,
    // rust: ) {
    // rust: let Some(g) = host.hub.guest(conn) else {
    // rust: return;
}
    // rust: let allowed = g.creative() && g.permission >= 2;
    // rust: self.as_guest(host, conn, |game| {
    // rust: if allowed {
    // rust: game.apply_set_jigsaw_block(&p);
}
    // rust: });
}

apply_set_jigsaw_block :: proc(self: ^Self, p: ^play::SetJigsawBlock) {
}
    // rust: let pos = (p.pos[0], p.pos[1], p.pos[2]);
    // rust: let Some(b) = self.jigsaw_block_mut(pos) else {
    // rust: return;
}
    // rust: b.name = p.name.clone();
    // rust: b.target = p.target.clone();
    // rust: b.pool = p.pool.clone();
    // rust: b.final_state = p.final_state.clone();
        // JointType.byName(name, ALIGNED).
    // rust: b.joint = JointType::of_serialized_name(&p.joint).unwrap_or(JointType::Aligned);
    // rust: b.placement_priority = p.placement_priority;
    // rust: b.selection_priority = p.selection_priority;
    // rust: self.mark_block_entity_updated(pos);
}

    // `handleJigsawGenerate` for a guest.
    // rust: pub(super) fn lan_jigsaw_generate(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: p: play::JigsawGenerate,
    // rust: ) {
    // rust: let Some(g) = host.hub.guest(conn) else {
    // rust: return;
}
    // rust: let allowed = g.creative() && g.permission >= 2;
    // rust: self.as_guest(host, conn, |game| {
    // rust: if allowed {
    // rust: game.generate_jigsaw_block(&p);
}
    // rust: });
}

    // `JigsawBlockEntity.generate`: the pool is built from the block's
    // front neighbour, `levels` deep.
generate_jigsaw_block :: proc(self: ^Self, p: ^play::JigsawGenerate) {
}
    // rust: let pos = (p.pos[0], p.pos[1], p.pos[2]);
    // rust: let Some(BlockEntity::JigsawBlock(b)) = self.world.block_entities.get(&pos) else {
    // rust: return;
}
    // rust: let (pool, target) = (b.pool.clone(), b.target.clone());
    // rust: let Some(front) = self.jigsaw_front(pos) else {
    // rust: return;
}
    // rust: let step = super::facing_offset(&front);
    // rust: let position = [pos.0 + step[0], pos.1 + step[1], pos.2 + step[2]];
        // registry.getOrThrow(pool): an unknown pool throws, ending the packet.
    // rust: if !self
    // rust: .ui
    // rust: .registries
    // rust: .ids("minecraft:worldgen/template_pool")
    // rust: .contains(&pool)
    // rust: {
    // rust: return;
}
    // rust: let Some(terrain) = self.end.locator() else {
    // rust: return;
}
    // rust: let query = JigsawQuery {
    // rust: pool: &pool,
    // rust: target: &target,
    // rust: max_depth: p.levels,
    // rust: position,
}
    // rust: let keep = p.keep_jigsaws;
    // rust: let (_, entities) = self.with_level(|b, level, ticks| {
    // rust: b.place_jigsaw(level, ticks, position, keep, || {
    // rust: terrain.jigsaw_pieces(&query)
    // rust: })
    // rust: });
    // rust: for entity in entities {
    // rust: self.spawn_entity_from_nbt(Tag::Compound(entity));
}
    // rust: let _ = self.process_level_events();
}
}
