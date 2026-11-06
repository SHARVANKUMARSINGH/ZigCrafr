//! Transpiled from Horizon Rust crate
//! Module: horizon-world_player_hurt
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Player difficulty/ability gates and server PvP dispatch before living hurt.
// use crate::{
    // rust: food::Difficulty,
    // rust: living_hurt::{self, HurtState, HurtWorld},
}
    // rust: pub trait PlayerHurtWorld: HurtWorld {
pub fn ability_invulnerable(self: *Self) b;
    // rust: fn bypasses_invulnerability(
    // rust: &mut self,
    // rust: s: &mut HurtState<Self::Source>,
    // rust: ) -> Result<bool, Self::Error>;
pub fn remove_shoulders(self: *Self, s: *mut HurtState<Self::Source>) R;
    // rust: fn scales_with_difficulty(
    // rust: &mut self,
    // rust: s: &mut HurtState<Self::Source>,
    // rust: ) -> Result<bool, Self::Error>;
pub fn difficulty(self: *Self, s: *mut HurtState<Self::Source>) R;
}
pub fn min(a: f32, b: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if a.is_nan() || b.is_nan() {
    // rust: f32::NAN
    // rust: } else if a == 0.0 && b == 0.0 {
    // rust: f32::from_bits(a.to_bits() | b.to_bits())
    // rust: } else {
    // rust: a.min(b)
}
}
    // rust: pub fn player_hurt_server<W: PlayerHurtWorld>(
    // rust: s: &mut HurtState<W::Source>,
    // rust: w: &mut W,
    // rust: mut damage: f32,
    // rust: ) -> Result<bool, W::Error> {
    // rust: if w.invulnerable(s)? {
    // rust: return Ok(false);
}
    // rust: if w.ability_invulnerable() && !w.bypasses_invulnerability(s)? {
    // rust: return Ok(false);
}
    // rust: s.no_action_time = 0;
    // rust: if w.dead_or_dying(s)? {
    // rust: return Ok(false);
}
    // rust: w.remove_shoulders(s)?;
    // rust: if w.scales_with_difficulty(s)? {
    // rust: if w.difficulty(s)? == Difficulty::Peaceful {
    // rust: damage = 0.0;
}
    // rust: if w.difficulty(s)? == Difficulty::Easy {
    // rust: damage = min(damage / 2.0 + 1.0, damage);
}
    // rust: if w.difficulty(s)? == Difficulty::Hard {
    // rust: damage = damage * 3.0 / 2.0;
}
}
    // rust: if damage == 0.0 {
    // rust: return Ok(false);
}
    // rust: living_hurt::hurt_server(s, w, damage)
}
pub const CausingEntity = enum {
    Other,
    Player(P),
    Arrow(A),
};
    // rust: pub trait ServerPlayerHurtWorld: PlayerHurtWorld {
    // rust: type Player: Copy;
    // rust: type Arrow: Copy;
    // rust: fn causing_entity(
    // rust: &mut self,
    // rust: s: &mut HurtState<Self::Source>,
    // rust: ) -> Result<CausingEntity<Self::Player, Self::Arrow>, Self::Error>;
    // rust: fn arrow_player_owner(
    // rust: &mut self,
    // rust: s: &mut HurtState<Self::Source>,
    // rust: arrow: Self::Arrow,
    // rust: ) -> Result<Option<Self::Player>, Self::Error>;
    // rust: fn can_harm_player(
    // rust: &mut self,
    // rust: s: &mut HurtState<Self::Source>,
    // rust: player: Self::Player,
    // rust: ) -> Result<bool, Self::Error>;
}
    // rust: pub fn server_player_hurt_server<W: ServerPlayerHurtWorld>(
    // rust: s: &mut HurtState<W::Source>,
    // rust: w: &mut W,
    // rust: damage: f32,
    // rust: ) -> Result<bool, W::Error> {
    // rust: if w.invulnerable(s)? {
    // rust: return Ok(false);
}
    // rust: match w.causing_entity(s)? {
    // rust: CausingEntity::Player(p) => {
    // rust: if !w.can_harm_player(s, p)? {
    // rust: return Ok(false);
}
}
    // rust: CausingEntity::Arrow(a) => {
    // rust: if let Some(p) = w.arrow_player_owner(s, a)? {
    // rust: if !w.can_harm_player(s, p)? {
    // rust: return Ok(false);
}
}
}
    // rust: CausingEntity::Other => {}
}
    // rust: player_hurt_server(s, w, damage)
}
