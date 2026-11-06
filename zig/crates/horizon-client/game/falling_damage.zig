//! Transpiled from Horizon Rust crate
//! Module: horizon-client_falling_damage
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Landing impacts for falling blocks, before their placement/drop decision.
// use super::{FallingBlock, Game, Landing};
// use horizon_client::falling_block;
// use horizon_core::{geometry::Vec3, position::BlockPos, random::RandomSource};
// use horizon_world::level::LevelEvent;

    // rust: impl Game<'_> {
    /// `FallingBlockEntity.causeFallDamage`: impact damage and anvil wear,
    /// before block effects and portal handling can transfer the entity.
    // rust: pub(super) fn falling_block_impact(&mut self, block: &mut FallingBlock) {
    // rust: let name = self.res.facts().get(block.state).name.clone();
    // rust: let anvil = name.ends_with("anvil");
    // rust: let stalactite = matches!(
    // rust: &*name,
    // rust: "minecraft:pointed_dripstone" | "minecraft:sulfur_spike"
    // rust: );
    // rust: if let Some(impact) = block.damage.impact(block.fall_distance) {
    // rust: if impact.amount > 0.0 {
    // rust: let mob_kind = if stalactite {
    // rust: horizon_client::mobs::DamageKind::FallingStalactite
    // rust: } else {
    // rust: horizon_client::mobs::DamageKind::FallingBlock
}
    // rust: falling_block::hurt_mobs_with_kind(
    // rust: &mut self.mobs,
    // rust: block.position,
    // rust: impact.amount,
    // rust: mob_kind,
    // rust: );
    // rust: let kind = if stalactite {
    // rust: "minecraft:falling_stalactite"
    // rust: } else if anvil {
    // rust: "minecraft:falling_anvil"
    // rust: } else {
    // rust: "minecraft:falling_block"
}
    // rust: self.falling_hurt_player(block.position, impact.amount, kind);
    // rust: if let Some(mut host) = self.lan.take() {
    // rust: let bounds = falling_block::bounds(block.position);
    // rust: let conns = host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| {
    // rust: host.hub.here(g)
    // rust: && g.loaded
    // rust: && !g.dead
    // rust: && !g.creative()
    // rust: && !g.spectator()
    // rust: && bounds.intersects(super::lan_mobs::guest_bounds(g))
    // rust: })
    // rust: .map(|g| g.conn)
    // rust: .collect::<Vec<_>>();
    // rust: for conn in conns {
    // rust: self.guest_hit_by(&mut host, conn, |g| {
    // rust: g.falling_hurt_player(block.position, impact.amount, kind)
    // rust: });
}
    // rust: self.lan = Some(host);
}
}
    // rust: if anvil
    // rust: && impact.wear_chance > 0.0
    // rust: && self.world.random.next_float() < impact.wear_chance
    // rust: && let Some(mut state) = self.pack.assets.registry.state(block.state).cloned()
    // rust: {
    // rust: if falling_block::wear_anvil(&mut state) {
    // rust: block.state = self
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .resolve(&state)
    // rust: .unwrap_or(block.state);
    // rust: } else {
    // rust: block.damage.cancel_drop = true;
}
}
}
}

    /// `FallingBlockEntity.tick`: finish a landing, including the placed block
    /// entity and the carried `TileEntityData` applied through loadWithComponents.
    // rust: pub(super) fn finish_falling_block(&mut self, block: FallingBlock, pos: [i32; 3]) {
    // rust: let name = self.res.facts().get(block.state).name.clone();
    // rust: let anvil = name.ends_with("anvil");
        // Fallable.onBrokenAfterFall: the anvil's, the pointed dripstone's and
        // the sulfur spike's level event.
    // rust: let sound_event = match &*name {
    // rust: "minecraft:pointed_dripstone" => Some(1045),
    // rust: "minecraft:sulfur_spike" => Some(1052),
    // rust: _ if anvil => Some(1029),
    // rust: _ => None,
}
    // rust: if block.damage.cancel_drop {
    // rust: if let Some(id) = sound_event {
    // rust: self.level_events.push(LevelEvent::LevelEvent {
    // rust: id,
    // rust: pos: BlockPos::new(pos[0], pos[1], pos[2]),
    // rust: data: 0,
    // rust: });
    // rust: } else if self
    // rust: .res
    // rust: .facts()
    // rust: .get(block.state)
    // rust: .name
    // rust: .starts_with("minecraft:suspicious_")
    // rust: {
                // BrushableBlock.onBrokenAfterFall.
    // rust: let at = BlockPos::new(pos[0], pos[1], pos[2]);
    // rust: self.level_events.push(LevelEvent::LevelEvent {
    // rust: id: 2001,
    // rust: pos: at,
    // rust: data: block.state.0 as i32,
    // rust: });
    // rust: self.level_events.push(LevelEvent::GameEvent {
    // rust: pos: at,
    // rust: event: "minecraft:block_destroy",
    // rust: state: None,
    // rust: });
}
    // rust: return;
}
    // rust: let landing = self.with_level(|b, level, ticks| {
    // rust: b.falling_block_landed(
    // rust: level,
    // rust: ticks,
    // rust: BlockPos::new(pos[0], pos[1], pos[2]),
    // rust: block.state,
    // rust: false,
    // rust: )
    // rust: });
    // rust: if let Landing::Placed(state) = landing {
    // rust: let name = self.res.facts().get(state).name.clone();
            // LevelChunk.setBlockState creates the new block entity even when
            // the falling entity has no supplied data.
    // rust: if let Some(entity) = self.new_block_entity(&name) {
    // rust: let key = (pos[0], pos[1], pos[2]);
    // rust: let mut tag = horizon_client::save::encode_block_entity(key, &entity, &name);
    // rust: self.world.block_entities.insert(key, entity);
                // FallingBlockEntity.tick copies each supplied field over the
                // new block entity's saved defaults before loadWithComponents.
    // rust: if let Some(horizon_world::nbt::Tag::Compound(carried)) = block
    // rust: .saved
    // rust: .as_ref()
    // rust: .and_then(|saved| saved.1.get("TileEntityData"))
    // rust: && let horizon_world::nbt::Tag::Compound(fields) = &mut tag
    // rust: {
    // rust: fields.extend(carried.clone());
    // rust: self.load_block_entity_nbt(pos, &horizon_client::snbt::to_snbt(&tag));
}
}
}
        // FallingBlockEntity.tick: the players tracking the entity are told to
        // show the block for a moment, after the block update.
    // rust: if let Landing::Placed(state) = landing
    // rust: && block.id != 0
    // rust: && let Some(host) = &self.lan
    // rust: {
    // rust: host.hub.send_to_tracking(
    // rust: block.id as i32,
    // rust: &horizon_protocol::packets::play::Clientbound::AddTransientBlock(
    // rust: horizon_protocol::packets::play::AddTransientBlock {
    // rust: pos,
    // rust: state: state.0 as i32,
    // rust: },
    // rust: ),
    // rust: );
}
    // rust: if matches!(landing, Landing::Broken)
    // rust: && block.drop_item
    // rust: && self.ui.rules.bool("entity_drops")
    // rust: {
    // rust: if let Some(id) = sound_event {
    // rust: self.level_events.push(LevelEvent::LevelEvent {
    // rust: id,
    // rust: pos: BlockPos::new(pos[0], pos[1], pos[2]),
    // rust: data: 0,
    // rust: });
}
            // FallingBlockEntity.tick: spawnAtLocation, from where the entity
            // came to rest (on top of a turtle egg, not inside its cell).
    // rust: self.drop_falling_block(block.state, block.position);
}
}
pub fn falling_hurt_player(self: *Self, position: Vec3, amount: f32, kind: []const u8) void {
}
    // rust: if self.creative || self.spectator() {
    // rust: return;
}
    // rust: if self.player.as_ref().is_none_or(|p| {
    // rust: p.health.dead_or_dying() || !falling_block::bounds(position).intersects(p.bounds())
    // rust: }) {
    // rust: return;
}
    // rust: let original = amount;
    // rust: let amount = if self.armor[0].is_some() {
    // rust: amount * 0.75
    // rust: } else {
    // rust: amount
}
    // rust: let hurt = match (self.player.as_mut(), self.health_resources.damage.id(kind)) {
    // rust: (Some(p), Some(id)) => p
    // rust: .hurt(&self.health_resources, self.world.health_rules, id, amount)
    // rust: .unwrap_or(false),
    // rust: _ => false,
}
    // rust: if hurt {
            // LivingEntity.hurtServer: ENTITY_HURT_PLAYER, the falling block
            // (`DamageSources.fallingBlock(this)` and the like) being both the
            // causing and the direct entity.
    // rust: let block = horizon_client::advancements::EntityView {
    // rust: kind: "minecraft:falling_block".into(),
    // rust: position: [position.x, position.y, position.z],
    // rust: ..Default::default()
}
    // rust: self.trigger_entity_hurt_player(&horizon_client::advancements::DamageView {
    // rust: kind: kind.to_owned(),
    // rust: direct: Some(block.clone()),
    // rust: is_direct: true,
    // rust: source: Some(block),
    // rust: original,
    // rust: actual: amount,
    // rust: blocked: false,
    // rust: });
}
}
}
