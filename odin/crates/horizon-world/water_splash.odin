//! Transpiled from Horizon Rust crate
package horizon_world_water_splash

import "core:fmt"
import "core:mem"
import "core:math"

// Water-entry sound, particles and game event, with native random draw order.
// use horizon_core::geometry::Vec3;
// use std::fmt;
SplashParticle :: enum {
    Bubble,
    Splash,
}
    // rust: pub trait WaterSplashWorld {
    // rust: type Error;
    // rust: type Entity: Copy + PartialEq;
    // rust: type Sound: Copy;
this_entity :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
controlling_passenger :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
velocity :: proc(self: ^Self, entity: Self::Entity) -> R {
    // Ported from Horizon
    return {}
}
splash_sound :: proc(self: ^Self, high_speed: bool) -> R {
    // Ported from Horizon
    return {}
}
random_float :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
random_double :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: fn play_sound(
    // rust: &mut self,
    // rust: sound: Self::Sound,
    // rust: volume: f32,
    // rust: pitch: f32,
    // rust: ) -> Result<(), Self::Error>;
position :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
width :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: fn particle(
    // rust: &mut self,
    // rust: kind: SplashParticle,
    // rust: position: Vec3,
    // rust: velocity: Vec3,
    // rust: ) -> Result<(), Self::Error>;
splash_event :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
}
SplashError :: enum {
    World(E),
    BudgetExceeded,
}
    // rust: impl<E: fmt::Display> fmt::Display for SplashError<E> {
fmt :: proc(self: ^Self, f: ^fmt::Formatter<'_>) -> f {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::World(e) => e.fmt(f),
    // rust: Self::BudgetExceeded => f.write_str("water splash particle budget exceeded"),
}
}
}
    // rust: impl<E: std::error::Error + 'static> std::error::Error for SplashError<E> {}
    // rust: pub fn water_splash<W: WaterSplashWorld>(
    // rust: world: &mut W,
    // rust: mut budget: usize,
    // rust: ) -> Result<(), SplashError<W::Error>> {
    // rust: let source = world
    // rust: .controlling_passenger()
    // rust: .map_err(SplashError::World)?
    // rust: .unwrap_or(world.this_entity());
    // rust: let scale = if source == world.this_entity() {
    // rust: 0.2f32
    // rust: } else {
    // rust: 0.9f32
}
    // rust: let velocity = world.velocity(source).map_err(SplashError::World)?;
    // rust: let energy = velocity.x * velocity.x * f64::from(0.2f32)
    // rust: + velocity.y * velocity.y
    // rust: + velocity.z * velocity.z * f64::from(0.2f32);
    // rust: let volume = energy.sqrt() as f32 * scale;
    // rust: let volume = if volume.is_nan() {
    // rust: volume
    // rust: } else {
    // rust: 1.0f32.min(volume)
}
    // rust: let sound = world
    // rust: .splash_sound(volume.is_nan() || volume >= 0.25)
    // rust: .map_err(SplashError::World)?;
    // rust: let pitch = 1.0
    // rust: + (world.random_float().map_err(SplashError::World)?
    // rust: - world.random_float().map_err(SplashError::World)?)
    // rust: * 0.4;
    // rust: world
    // rust: .play_sound(sound, volume, pitch)
    // rust: .map_err(SplashError::World)?;
    // rust: let surface = world.position().y.floor() as i32 as f32;
    // rust: for kind in [SplashParticle::Bubble, SplashParticle::Splash] {
    // rust: let mut i = 0i32;
    // rust: while (i as f32) < 1.0 + world.width() * 20.0 {
    // rust: if budget == 0 {
    // rust: return Err(SplashError::BudgetExceeded);
}
    // rust: budget -= 1;
    // rust: let dx = (world.random_double().map_err(SplashError::World)? * 2.0 - 1.0)
    // rust: * f64::from(world.width());
    // rust: let dz = (world.random_double().map_err(SplashError::World)? * 2.0 - 1.0)
    // rust: * f64::from(world.width());
    // rust: let position = Vec3::new(
    // rust: world.position().x + dx,
    // rust: f64::from(surface + 1.0),
    // rust: world.position().z + dz,
    // rust: );
    // rust: let particle_velocity = match kind {
    // rust: SplashParticle::Bubble => Vec3::new(
    // rust: velocity.x,
    // rust: velocity.y
    // rust: - world.random_double().map_err(SplashError::World)? * f64::from(0.2f32),
    // rust: velocity.z,
    // rust: ),
    // rust: SplashParticle::Splash => velocity,
}
    // rust: world
    // rust: .particle(kind, position, particle_velocity)
    // rust: .map_err(SplashError::World)?;
    // rust: i = i.wrapping_add(1);
}
}
    // rust: world.splash_event().map_err(SplashError::World)
}
