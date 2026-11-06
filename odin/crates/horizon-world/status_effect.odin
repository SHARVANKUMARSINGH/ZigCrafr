//! Transpiled from Horizon Rust crate
package horizon_world_status_effect

import "core:fmt"
import "core:mem"
import "core:math"

// Shared status-effect instances. Cloning retains identity; copy_instance
// implements the native copy constructor, excluding hidden effects and blend.
// use std::{
    // rust: cell::{Ref, RefCell, RefMut},
    // rust: rc::Rc,
}

Details :: struct {
    duration: i32,
    amplifier: i32,
    ambient: bool,
    visible: bool,
    show_icon: bool,
}
BlendState :: struct {
    factor: f32,
    previous: f32,
}
EffectData :: struct {
    effect: H,
    details: Details,
    hidden: Maybe(EffectInstance<H)>,
    blend: BlendState,
}
EffectInstance :: struct {
    // rust: impl<H> Clone for EffectInstance<H> {
clone :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self(self.0.clone())
}
}
    // rust: impl<H> EffectInstance<H> {
new :: proc(effect: H, mut details: Details, hidden: Maybe(Self)) -> S {
    // Ported from Horizon
    return {}
}
    // rust: details.amplifier = details.amplifier.clamp(0, 255);
    // rust: Self(Rc::new(RefCell::new(EffectData {
    // rust: effect,
    // rust: details,
    // rust: hidden,
    // rust: blend: BlendState::default(),
    // rust: })))
}
read :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.0.borrow()
}
write :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.0.borrow_mut()
}
same_reference :: proc(self: ^Self, other: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: Rc::ptr_eq(&self.0, &other.0)
}
infinite :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.read().details.duration == -1
}
ends_within :: proc(self: ^Self, duration: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.infinite() && self.read().details.duration <= duration
}
has_remaining :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.infinite() || self.read().details.duration > 0
}
shorter_than :: proc(self: ^Self, other: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.infinite()
    // rust: && (self.read().details.duration < other.read().details.duration || other.infinite())
}
    // rust: pub fn map_duration<T>(&self, mapper: impl FnOnce(i32) -> Result<i32, T>) -> Result<i32, T> {
    // rust: let duration = self.read().details.duration;
    // rust: if duration == -1 || duration == 0 {
    // rust: Ok(duration)
    // rust: } else {
    // rust: mapper(duration)
}
}
copy_blend_from :: proc(self: ^Self, other: ^Self) {
}
    // rust: let blend = other.read().blend;
    // rust: self.write().blend = blend;
}
}
    // rust: impl<H: Clone> EffectInstance<H> {
copy_instance :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let data = self.read();
    // rust: Self(Rc::new(RefCell::new(EffectData {
    // rust: effect: data.effect.clone(),
    // rust: details: data.details,
    // rust: hidden: None,
    // rust: blend: BlendState::default(),
    // rust: })))
}
scaled :: proc(self: ^Self, factor: f32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let result = self.copy_instance();
    // rust: let duration = result
    // rust: .map_duration::<std::convert::Infallible>(|duration| {
    // rust: let v = duration as f32 * factor;
    // rust: let floor = f64::from(v).floor() as i32;
    // rust: Ok(floor.max(1))
    // rust: })
    // rust: .unwrap();
    // rust: result.write().details.duration = duration;
    // rust: result
}
    // Updates details and the shared hidden chain. As in vanilla, differing
    // effect holders do not prevent an update; diagnostic logging is external.
update :: proc(self: ^Self, incoming: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let mut changed = false;
    // rust: if incoming.read().details.amplifier > self.read().details.amplifier {
    // rust: if incoming.shorter_than(self) {
    // rust: let old_hidden = self.read().hidden.clone();
    // rust: let hidden = self.copy_instance();
    // rust: hidden.write().hidden = old_hidden;
    // rust: self.write().hidden = Some(hidden);
}
    // rust: let source = incoming.read().details;
    // rust: let mut data = self.write();
    // rust: data.details.amplifier = source.amplifier;
    // rust: data.details.duration = source.duration;
    // rust: changed = true;
    // rust: } else if self.shorter_than(incoming) {
    // rust: if incoming.read().details.amplifier == self.read().details.amplifier {
    // rust: let duration = incoming.read().details.duration;
    // rust: self.write().details.duration = duration;
    // rust: changed = true;
    // rust: } else {
    // rust: let hidden = self.read().hidden.clone();
    // rust: if let Some(hidden) = hidden {
    // rust: hidden.update(incoming);
    // rust: } else {
    // rust: self.write().hidden = Some(incoming.copy_instance());
}
}
}
    // rust: let incoming = incoming.read().details;
    // rust: let mut data = self.write();
    // rust: if (!incoming.ambient && data.details.ambient) || changed {
    // rust: data.details.ambient = incoming.ambient;
    // rust: changed = true;
}
    // rust: if incoming.visible != data.details.visible {
    // rust: data.details.visible = incoming.visible;
    // rust: changed = true;
}
    // rust: if incoming.show_icon != data.details.show_icon {
    // rust: data.details.show_icon = incoming.show_icon;
    // rust: changed = true;
}
    // rust: changed
}
}
    // rust: impl<H: PartialEq> PartialEq for EffectInstance<H> {
eq :: proc(self: ^Self, other: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let a = self.read();
    // rust: let b = other.read();
    // rust: a.effect == b.effect && a.details == b.details
}
}
    // rust: impl<H: Eq> Eq for EffectInstance<H> {}

    // rust: pub trait TickWorld<H> {
    // rust: type Error;
    // rust: type Level: Copy;
actor_tick_count :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: fn should_apply(
    // rust: &mut self,
    // rust: effect: H,
    // rust: time: i32,
    // rust: amplifier: i32,
    // rust: instance: &EffectInstance<H>,
    // rust: ) -> Result<bool, Self::Error>;
    // rust: fn apply_tick(
    // rust: &mut self,
    // rust: effect: H,
    // rust: level: Self::Level,
    // rust: amplifier: i32,
    // rust: instance: &EffectInstance<H>,
    // rust: ) -> Result<bool, Self::Error>;
downgraded :: proc(self: ^Self, instance: ^EffectInstance<H>) -> R {
    // Ported from Horizon
    return {}
}
}
    // rust: pub trait BlendWorld<H> {
    // rust: type Error;
    // rust: fn advance_ticks(
    // rust: &mut self,
    // rust: effect: H,
    // rust: instance: &EffectInstance<H>,
    // rust: ) -> Result<i32, Self::Error>;
    // rust: fn duration_ticks(
    // rust: &mut self,
    // rust: effect: H,
    // rust: blending_in: bool,
    // rust: instance: &EffectInstance<H>,
    // rust: ) -> Result<i32, Self::Error>;
}
float_clamp :: proc(v: f32, lo: f32, hi: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if v < lo {
    // rust: lo
    // rust: } else if v.is_nan() || hi.is_nan() {
    // rust: f32::NAN
    // rust: } else if v == 0.0 && hi == 0.0 {
    // rust: f32::from_bits(v.to_bits() | hi.to_bits())
    // rust: } else {
    // rust: v.min(hi)
}
}
    // rust: impl<H> EffectInstance<H> {
tick_down :: proc(self: ^Self) {
}
    // rust: let hidden = self.read().hidden.clone();
    // rust: if let Some(hidden) = hidden {
    // rust: hidden.tick_down();
}
    // rust: let mut data = self.write();
    // rust: if data.details.duration != -1 && data.details.duration != 0 {
    // rust: data.details.duration = data.details.duration.wrapping_sub(1);
}
}
downgrade :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if self.read().details.duration != 0 {
    // rust: return false;
}
    // rust: let hidden = self.read().hidden.clone();
    // rust: if let Some(hidden) = hidden {
    // rust: let details = hidden.read().details;
    // rust: let next = hidden.read().hidden.clone();
    // rust: let mut data = self.write();
    // rust: data.details = details;
    // rust: data.hidden = next;
    // rust: true
    // rust: } else {
    // rust: false
}
}
    // Entity.isRemoved is a final field-based query. Removal snaps the
    // previous factor before interpolation, including for non-finite partials.
blend_factor :: proc(self: ^Self, partial: f32, actor_removed: bool) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let mut data = self.write();
    // rust: if actor_removed {
    // rust: data.blend.previous = data.blend.factor;
}
    // rust: data.blend.previous + partial * (data.blend.factor - data.blend.previous)
}
}
    // rust: impl<H: Clone> EffectInstance<H> {
    // rust: pub fn tick_server<W: TickWorld<H>>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: level: W::Level,
    // rust: ) -> Result<bool, W::Error> {
    // rust: if !self.has_remaining() {
    // rust: return Ok(false);
}
    // rust: let time = if self.infinite() {
    // rust: world.actor_tick_count()
    // rust: } else {
    // rust: self.read().details.duration
}
    // rust: let effect = self.read().effect.clone();
    // rust: let amplifier = self.read().details.amplifier;
    // rust: if world.should_apply(effect, time, amplifier, self)? {
    // rust: let effect = self.read().effect.clone();
    // rust: let amplifier = self.read().details.amplifier;
    // rust: if !world.apply_tick(effect, level, amplifier, self)? {
    // rust: return Ok(false);
}
}
    // rust: self.tick_down();
    // rust: if self.downgrade() {
    // rust: world.downgraded(self)?;
}
    // rust: Ok(self.has_remaining())
}
    // rust: fn blend_has_effect<W: BlendWorld<H>>(&self, world: &mut W) -> Result<bool, W::Error> {
    // rust: let effect = self.read().effect.clone();
    // rust: let advance = world.advance_ticks(effect, self)?;
    // rust: Ok(!self.ends_within(advance))
}
    // rust: pub fn skip_blending<W: BlendWorld<H>>(&self, world: &mut W) -> Result<(), W::Error> {
    // rust: let target = if self.blend_has_effect(world)? {
    // rust: 1.0
    // rust: } else {
    // rust: 0.0
}
    // rust: self.write().blend = BlendState {
    // rust: factor: target,
    // rust: previous: target,
}
    // rust: Ok(())
}
    // rust: pub fn tick_client<W: BlendWorld<H>>(&self, world: &mut W) -> Result<(), W::Error> {
    // rust: if self.has_remaining() {
    // rust: self.tick_down();
    // rust: self.downgrade();
}
    // rust: let previous = self.read().blend.factor;
    // rust: self.write().blend.previous = previous;
    // rust: let has_effect = self.blend_has_effect(world)?;
    // rust: let target = if has_effect { 1.0 } else { 0.0 };
    // rust: if self.read().blend.factor == target {
    // rust: return Ok(());
}
    // rust: let effect = self.read().effect.clone();
    // rust: let ticks = world.duration_ticks(effect, has_effect, self)?;
    // rust: if ticks == 0 {
    // rust: self.write().blend.factor = target;
    // rust: } else {
    // rust: let step = 1.0 / ticks as f32;
    // rust: let mut data = self.write();
    // rust: data.blend.factor += float_clamp(target - data.blend.factor, -step, step);
}
    // rust: Ok(())
}
}
