//! Transpiled from Horizon Rust crate
package horizon_client_effects

import "core:fmt"
import "core:mem"
import "core:math"

// `/effect` (EffectCommands) and `/enchant` (EnchantCommand).
// use super::{Arg, Context, Game, R, Target, err, texts};
// use horizon_client::{
    // rust: brewing::{self, namespaced},
    // rust: effects::EffectInstance,
    // rust: text::{self, Style, Text},
}

// `CommandResponseTracker` over targets: elements with a non-zero result.
Tracker :: struct {
    total: i32,
    changed: [dynamic]Target,
}
    // rust: impl Tracker {
track :: proc(self: ^Self, t: Target, changed: bool) {
}
    // rust: if changed {
    // rust: self.total += 1;
    // rust: self.changed.push(t);
}
}
}
effect_name :: proc(id: string) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Text::translate(&brewing::description_id(id), &[])
}
    // rust: impl Game<'_> {
effect_arg :: proc(ctx: ^Context) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let Some(Arg::Resource(id)) = ctx.get("effect") else {
    // rust: return Err(err("argument.resource.invalid_type", &[]));
}
    // rust: brewing::effect(id).ok_or_else(|| {
    // rust: err(
    // rust: "argument.resource.not_found",
    // rust: &[id, &"minecraft:mob_effect"],
    // rust: )
    // rust: })
}
    // The executing entity for argument-less forms (the player).
living_targets :: proc(self: ^Self, ctx: ^Context) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if ctx.get("targets").is_some() {
    // rust: self.entities(ctx, "targets", false)
    // rust: } else {
    // rust: Ok(vec![self.implied_player()])
}
}
    // `EffectCommands.giveEffect`.
    // rust: pub(super) fn cmd_effect_give(&mut self, ctx: &Context) -> R<i32> {
    // rust: let effect = Self::effect_arg(ctx)?;
    // rust: let seconds = if ctx.has("infinite") {
    // rust: Some(-1)
    // rust: } else {
    // rust: Self::int(ctx, "seconds")
}
    // rust: let amplifier = Self::int(ctx, "amplifier").unwrap_or(0);
    // rust: let particles = !matches!(ctx.get("hideParticles"), Some(Arg::Bool(true)));
        // computeDurationInTicks
    // rust: let duration = match seconds {
    // rust: Some(s) if effect.instant => s,
    // rust: Some(-1) => -1,
    // rust: Some(s) => s * 20,
    // rust: None if effect.instant => 1,
    // rust: None => 600,
}
    // rust: let mut tracker = Tracker::default();
    // rust: for t in self.living_targets(ctx)? {
    // rust: let changed = match t {
    // rust: Target::Player | Target::Guest(_) => {
    // rust: let mut instance = EffectInstance::new(effect.id, duration, amplifier);
    // rust: instance.visible = particles;
    // rust: self.for_player(t, |g| g.add_player_effect(instance))
    // rust: .unwrap_or(false)
}
    // rust: Target::Mob(id) => match self.mobs.iter_mut().find(|m| m.id == id) {
    // rust: Some(m) => {
    // rust: let name = namespaced(effect.id);
    // rust: let new = !m.has_effect(name);
                        // `new MobEffectInstance(effect, duration, amplifier, false, particles)`.
    // rust: let changed =
    // rust: m.add_effect_with(name, duration, amplifier, false, particles);
    // rust: self.mod_effect_added(name, Some(id as i32), amplifier, new);
    // rust: changed
}
    // rust: None => false,
    // rust: },
    // rust: _ => continue,
}
    // rust: tracker.track(t, changed);
}
    // rust: let message = match tracker.changed.as_slice() {
    // rust: [] => return Err(err("commands.effect.give.failed", &[])),
    // rust: [one] => Text::translate(
    // rust: "commands.effect.give.success.single",
    // rust: &[
    // rust: effect_name(effect.id),
    // rust: self.target_name(*one),
    // rust: Text::literal((duration / 20).to_string()),
    // rust: ],
    // rust: ),
    // rust: many => Text::translate(
    // rust: "commands.effect.give.success.multiple",
    // rust: &texts(&[
    // rust: effect_name(effect.id),
    // rust: Text::literal(many.len().to_string()),
    // rust: Text::literal((duration / 20).to_string()),
    // rust: ]),
    // rust: ),
}
    // rust: self.feedback(message);
    // rust: Ok(tracker.total)
}
    // `EffectCommands.clearEffects` / `clearEffect`.
    // rust: pub(super) fn cmd_effect_clear(&mut self, ctx: &Context) -> R<i32> {
    // rust: let effect = if ctx.get("effect").is_some() {
    // rust: Some(Self::effect_arg(ctx)?)
    // rust: } else {
    // rust: None
}
    // rust: let mut tracker = Tracker::default();
    // rust: for t in self.living_targets(ctx)? {
    // rust: let changed = match (t, effect) {
    // rust: (Target::Player | Target::Guest(_), None) => self
    // rust: .for_player(t, |g| {
    // rust: let any = !g.potions.effects.list.is_empty();
    // rust: g.potions.effects.clear();
    // rust: g.apply_effect_status();
    // rust: any
    // rust: })
    // rust: .unwrap_or(false),
    // rust: (Target::Player | Target::Guest(_), Some(e)) => self
    // rust: .for_player(t, |g| {
    // rust: let before = g.potions.effects.list.len();
    // rust: g.potions.effects.list.retain(|x| x.id != e.id);
    // rust: g.apply_effect_status();
    // rust: g.potions.effects.list.len() != before
    // rust: })
    // rust: .unwrap_or(false),
    // rust: (Target::Mob(id), e) => match self.mobs.iter_mut().find(|m| m.id == id) {
    // rust: Some(m) => {
    // rust: let before = m.extra.effects.len();
    // rust: m.extra
    // rust: .effects
    // rust: .retain(|x| e.is_some_and(|e| x.0 != namespaced(e.id)));
    // rust: let left = &m.extra.effects;
    // rust: m.extra
    // rust: .hidden_effects
    // rust: .retain(|h| left.iter().any(|x| x.0 == *h));
    // rust: m.extra
    // rust: .ambient_effects
    // rust: .retain(|h| left.iter().any(|x| x.0 == *h));
    // rust: m.extra.effects.len() != before
}
    // rust: None => false,
    // rust: },
    // rust: _ => continue,
}
    // rust: tracker.track(t, changed);
}
    // rust: let message = match (tracker.changed.as_slice(), effect) {
    // rust: ([], None) => return Err(err("commands.effect.clear.everything.failed", &[])),
    // rust: ([], Some(_)) => return Err(err("commands.effect.clear.specific.failed", &[])),
    // rust: ([one], None) => Text::translate(
    // rust: "commands.effect.clear.everything.success.single",
    // rust: &[self.target_name(*one)],
    // rust: ),
    // rust: (many, None) => Text::translate(
    // rust: "commands.effect.clear.everything.success.multiple",
    // rust: &[Text::literal(many.len().to_string())],
    // rust: ),
    // rust: ([one], Some(e)) => Text::translate(
    // rust: "commands.effect.clear.specific.success.single",
    // rust: &[effect_name(e.id), self.target_name(*one)],
    // rust: ),
    // rust: (many, Some(e)) => Text::translate(
    // rust: "commands.effect.clear.specific.success.multiple",
    // rust: &texts(&[effect_name(e.id), Text::literal(many.len().to_string())]),
    // rust: ),
}
    // rust: self.feedback(message);
    // rust: Ok(tracker.total)
}
    // `EnchantCommand.enchant` (mobs hold bare item ids, so only the player's
    // main hand item can carry the enchantment).
    // rust: pub(super) fn cmd_enchant(&mut self, ctx: &Context) -> R<i32> {
    // rust: let Some(Arg::Resource(id)) = ctx.get("enchantment").cloned() else {
    // rust: return Ok(0);
}
    // rust: let level = Self::int(ctx, "level").unwrap_or(1);
    // rust: let enchantments = &self.stations().enchantments;
    // rust: let Some(def) = enchantments.get(&id) else {
    // rust: return Err(err(
    // rust: "argument.resource.not_found",
    // rust: &[&id, &"minecraft:enchantment"],
    // rust: ));
}
    // rust: let max = def.max_level as i32;
    // rust: if level > max {
    // rust: return Err(err("commands.enchant.failed.level", &[&level, &max]));
}
    // rust: let targets = self.entities(ctx, "targets", false)?;
    // rust: let single = targets.len() == 1;
    // rust: let mut tracker = Tracker::default();
    // rust: for t in targets {
    // rust: match t {
    // rust: Target::Player => {
    // rust: let Some(stack) = self.inventory[self.selected].clone() else {
    // rust: if single {
    // rust: return Err(err(
    // rust: "commands.enchant.failed.itemless",
    // rust: &[&self.target_name(t).plain()],
    // rust: ));
}
    // rust: continue;
}
    // rust: let e = &self.stations().enchantments;
    // rust: let compatible = e.can_enchant(self.items(), &id, &stack.item)
    // rust: && stack
    // rust: .crafting_enchantments()
    // rust: .iter()
    // rust: .all(|(other, _)| e.compatible(other, &id));
    // rust: if compatible {
    // rust: if let Some(s) = self.inventory[self.selected].as_mut() {
    // rust: s.enchant(&id, level.max(0) as u32);
}
    // rust: tracker.track(t, true);
    // rust: } else if single {
                        // getHoverName().getString(): the custom or item name, no brackets.
    // rust: return Err(err(
    // rust: "commands.enchant.failed.incompatible",
    // rust: &[&stack
    // rust: .custom_name()
    // rust: .unwrap_or_else(|| self.pack.names.item(&stack.item).to_string())],
    // rust: ));
}
}
    // rust: Target::Mob(mob) => {
    // rust: let held = self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == mob)
    // rust: .and_then(|m| m.extra.main_hand.clone());
    // rust: if single {
    // rust: return Err(match held {
    // rust: None => err(
    // rust: "commands.enchant.failed.itemless",
    // rust: &[&self.target_name(t).plain()],
    // rust: ),
    // rust: Some(item) => err(
    // rust: "commands.enchant.failed.incompatible",
    // rust: &[&self.pack.names.item(&item)],
    // rust: ),
    // rust: });
}
}
    // rust: _ if single => {
    // rust: return Err(err(
    // rust: "commands.enchant.failed.entity",
    // rust: &[&self.target_name(t).plain()],
    // rust: ));
}
    // rust: _ => {}
}
}
    // rust: let (name, curse) = self
    // rust: .res
    // rust: .stations()
    // rust: .enchantments
    // rust: .full_name(&id, level.max(0) as u32);
    // rust: let style = Style {
    // rust: color: Some(if curse { text::RED } else { text::GRAY }),
    // rust: ..Style::default()
}
    // rust: let full = Text::styled(name, style);
    // rust: let message = match tracker.changed.as_slice() {
    // rust: [] => return Err(err("commands.enchant.failed", &[])),
    // rust: [one] => Text::translate(
    // rust: "commands.enchant.success.single",
    // rust: &[full, self.target_name(*one)],
    // rust: ),
    // rust: many => Text::translate(
    // rust: "commands.enchant.success.multiple",
    // rust: &texts(&[full, Text::literal(many.len().to_string())]),
    // rust: ),
}
    // rust: self.feedback(message);
    // rust: Ok(tracker.total)
}
}
