//! Transpiled from Horizon Rust crate
package horizon_world_player_travel

import "core:fmt"
import "core:mem"
import "core:math"

// Player-specific swimming and ability-flight behavior around living travel.
// use horizon_core::{geometry::Vec3, position::BlockPos};
    // rust: pub trait PlayerTravelWorld {
    // rust: type Error;
is_passenger :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
is_swimming :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
look_angle :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
jumping :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
position :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
fluid_is_empty :: proc(self: ^Self, position: BlockPos) -> R {
    // Ported from Horizon
    return {}
}
velocity :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
set_velocity :: proc(self: ^Self, velocity: Vec3) -> R {
    // Ported from Horizon
    return {}
}
    // Virtual getAbilities(), as distinct from direct abilities-field reads.
query_flying_ability :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
flying_ability :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
ability_flying_speed :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
sprinting :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
living_travel :: proc(self: ^Self, input: Vec3) -> R {
    // Ported from Horizon
    return {}
}
}
    // rust: pub fn travel<W: PlayerTravelWorld>(world: &mut W, input: Vec3) -> Result<(), W::Error> {
    // rust: if world.is_passenger()? {
    // rust: return world.living_travel(input);
}
    // rust: if world.is_swimming()? {
    // rust: let look_y = world.look_angle()?.y;
    // rust: let scale = if look_y < -0.2 { 0.085 } else { 0.06 };
    // rust: let apply = if look_y <= 0.0 || world.jumping() {
    // rust: true
    // rust: } else {
    // rust: let p = world.position();
    // rust: !world.fluid_is_empty(BlockPos::new(
    // rust: p.x.floor() as i32,
    // rust: (p.y + 1.0 - 0.1).floor() as i32,
    // rust: p.z.floor() as i32,
    // rust: ))?
}
    // rust: if apply {
    // rust: let v = world.velocity();
    // rust: world.set_velocity(Vec3::new(
    // rust: v.x + 0.0,
    // rust: v.y + (look_y - v.y) * scale,
    // rust: v.z + 0.0,
    // rust: ))?;
}
}
    // rust: if world.query_flying_ability()? {
    // rust: let y = world.velocity().y;
    // rust: world.living_travel(input)?;
    // rust: let v = world.velocity();
    // rust: world.set_velocity(Vec3::new(v.x, y * 0.6, v.z))?;
    // rust: } else {
    // rust: world.living_travel(input)?;
}
    // rust: Ok(())
}
    // rust: pub fn flying_speed<W: PlayerTravelWorld>(world: &mut W) -> Result<f32, W::Error> {
    // rust: if world.flying_ability() && !world.is_passenger()? {
    // rust: let sprinting = world.sprinting()?;
    // rust: let speed = world.ability_flying_speed()?;
    // rust: Ok(if sprinting { speed * 2.0 } else { speed })
    // rust: } else {
    // rust: Ok(if world.sprinting()? {
    // rust: 0.025999999f32
    // rust: } else {
    // rust: 0.02
    // rust: })
}
}
    // rust: pub fn affected_by_fluids<W: PlayerTravelWorld>(world: &W) -> bool {
    // rust: !world.flying_ability()
}
