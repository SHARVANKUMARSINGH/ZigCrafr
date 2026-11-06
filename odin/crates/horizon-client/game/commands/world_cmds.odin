//! Transpiled from Horizon Rust crate
package horizon_client_world_cmds

import "core:fmt"
import "core:mem"
import "core:math"

// `/recipe`, `/damage`, `/rotate`, `/swing`, `/playsound`, `/stopsound`,
// `/particle`, `/attribute`, `/ride` and `/spreadplayers`.
// use super::{Arg, Context, Game, R, Target, err, wrap_degrees};
// use horizon_client::{
    // rust: mobs::{Damage, DamageKind, MobEvent, Who, finalize},
    // rust: scoreboard_cmd::{Holder, Tracker},
    // rust: settings::SOUND_SOURCES,
    // rust: text::Text,
}
// use horizon_core::random::RandomSource;
// use horizon_protocol::packets::play::{self, Clientbound as C};
// use horizon_world::attribute_map::ValueKind;
// use horizon_world::nbt::Tag;

// Queue bookkeeping for synchronous command damage, preserving prior requests
// and unrelated events. The existing game policy handles each extracted request.
take_new_reinforcements :: proc(events: ^[dynamic]MobEvent, queued: uint) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut requests = Vec::new();
    // rust: let mut index = 0;
    // rust: events.retain(|event| {
    // rust: let new = index >= queued;
    // rust: index += 1;
    // rust: if new && let MobEvent::Reinforcements { mob, target } = event {
    // rust: requests.push((*mob, *target));
    // rust: false
    // rust: } else {
    // rust: true
}
    // rust: });
    // rust: requests
}

num :: proc(n: impl std::fmt::Display) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Text::literal(n.to_string())
}
holder :: proc(text: Text) -> H {
    // Ported from Horizon
    return {}
}
    // rust: Holder {
    // rust: name: String::new(),
    // rust: text,
    // rust: display: None,
}
}
// `ChatFormatting`-free float text as `Component.translatable` prints a `double`.
java_double_text :: proc(v: f64) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Text::literal(horizon_client::snbt::java_double(v))
}

    // rust: impl Game<'_> {
    // ---- /recipe -----------------------------------------------------------

    // Non-special recipes, as resolved by `ResourceKeyArgument.getRecipe` and `/recipe *`.
    // rust: pub(super) fn learnable_recipes(&self) -> Vec<String> {
    // rust: let index = &self.stations().recipe_index;
    // rust: index
    // rust: .ids()
    // rust: .filter(|id| !index.special(id))
    // rust: .cloned()
    // rust: .collect()
}
    // rust: pub(super) fn cmd_recipe(&mut self, id: &str, ctx: &Context) -> R<i32> {
    // rust: let targets = self.entities(ctx, "targets", true)?;
    // rust: let give = id == "recipe.give";
    // rust: let recipes: Vec<String> = match ctx.get("recipe") {
    // rust: Some(Arg::Resource(r)) => {
    // rust: if !self.learnable_recipes().contains(r) {
    // rust: return Err(err("recipe.notFound", &[r]));
}
    // rust: vec![r.clone()]
}
    // rust: _ => self.learnable_recipes(),
}
    // rust: let mut tracker = Tracker::default();
    // rust: for &t in &targets {
    // rust: let h = holder(self.target_name(t));
            // ServerPlayer.awardRecipes / resetRecipes on the target's own
            // ServerRecipeBook: a guest's is swapped in for the call, and the
            // packets go to its client.
    // rust: let n = self
    // rust: .for_player(t, |g| g.change_recipes(give, &recipes))
    // rust: .unwrap_or(0);
    // rust: tracker.track(&h, n);
}
    // rust: let verb = if give { "give" } else { "take" };
    // rust: let (message, total) = tracker.message(
    // rust: false,
    // rust: Some(err(&format!("commands.recipe.{verb}.failed"), &[])),
    // rust: |h, total| {
    // rust: Text::translate(
    // rust: &format!("commands.recipe.{verb}.success.single"),
    // rust: &[num(total), h.text.clone()],
    // rust: )
    // rust: },
    // rust: |count, total| {
    // rust: Text::translate(
    // rust: &format!("commands.recipe.{verb}.success.multiple"),
    // rust: &[num(total), num(count)],
    // rust: )
    // rust: },
    // rust: )?;
    // rust: self.feedback(message);
    // rust: Ok(total)
}

    // ServerRecipeBook.addRecipes/removeRecipes for the player in place: how
    // many recipe book displays changed (a transmute recipe has one per
    // material count).
change_recipes :: proc(self: ^Self, give: bool, recipes: ^[string]) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let index = &world_stations!(self).recipe_index;
    // rust: if give {
    // rust: let (count, unlocked) = self.level.recipe_book.add_recipes(index, recipes);
    // rust: self.recipe_unlocked(&unlocked);
    // rust: return count as i32;
}
    // rust: let removed = self.level.recipe_book.remove_recipes(index, recipes);
    // rust: let count = removed.len() as i32;
        // A network player's client drops them from its book.
    // rust: if self.lan_acting.is_some() && !removed.is_empty() {
    // rust: self.guest_packets.push(C::RecipeBookRemove(
    // rust: horizon_protocol::packets::recipes::RecipeBookRemove { ids: removed },
    // rust: ));
}
    // rust: count
}

    // ---- /damage ----------------------------------------------------------------

damage_kind :: proc(ty: string) -> D {
    // Ported from Horizon
    return {}
}
    // rust: match ty.trim_start_matches("minecraft:") {
    // rust: "player_attack" => DamageKind::PlayerAttack,
    // rust: "mace_smash" => DamageKind::MaceSmash,
    // rust: "spear" => DamageKind::Spear,
    // rust: "mob_attack" | "mob_attack_no_aggro" => DamageKind::MobAttack,
    // rust: "arrow" => DamageKind::Arrow,
    // rust: "thrown" | "trident" | "mob_projectile" => DamageKind::Thrown,
    // rust: "fireball" | "unattributed_fireball" => DamageKind::Fireball,
    // rust: "wither_skull" => DamageKind::WitherSkull,
    // rust: "explosion" | "player_explosion" | "bad_respawn_point" => DamageKind::Explosion,
    // rust: "fall" | "ender_pearl" | "fly_into_wall" => DamageKind::Fall,
    // rust: "on_fire" => DamageKind::OnFire,
    // rust: "in_fire" => DamageKind::InFire,
    // rust: "hot_floor" => DamageKind::HotFloor,
    // rust: "campfire" => DamageKind::Campfire,
    // rust: "lava" => DamageKind::Lava,
    // rust: "drown" => DamageKind::Drown,
    // rust: "dry_out" => DamageKind::DryOut,
    // rust: "magic" | "indirect_magic" | "dragon_breath" => DamageKind::Magic,
    // rust: "sting" => DamageKind::Sting,
    // rust: "cactus" => DamageKind::Cactus,
    // rust: "sweet_berry_bush" => DamageKind::SweetBerryBush,
    // rust: "freeze" => DamageKind::Freeze,
    // rust: "in_wall" => DamageKind::InWall,
    // rust: "thorns" => DamageKind::Thorns,
    // rust: "cramming" => DamageKind::Cramming,
    // rust: "falling_anvil" => DamageKind::FallingAnvil,
    // rust: "falling_block" => DamageKind::FallingBlock,
    // rust: "fireworks" => DamageKind::Fireworks,
    // rust: "generic_kill" => DamageKind::GenericKill,
    // rust: "lightning_bolt" => DamageKind::LightningBolt,
    // rust: "out_of_world" => DamageKind::OutOfWorld,
    // rust: "outside_border" => DamageKind::OutsideBorder,
    // rust: "sonic_boom" => DamageKind::SonicBoom,
    // rust: "spit" => DamageKind::Spit,
    // rust: "stalagmite" => DamageKind::Stalagmite,
    // rust: "starve" => DamageKind::Starve,
    // rust: "sulfur_cube_hot" => DamageKind::SulfurCubeHot,
    // rust: "wind_charge" => DamageKind::WindCharge,
    // rust: "wither" => DamageKind::Wither,
    // rust: _ => DamageKind::Generic,
}
}
    // `DamageCommand.damage`: apply its source and report an accepted hit.
    // rust: pub(super) fn cmd_damage(&mut self, ctx: &Context) -> R<i32> {
    // rust: let targets = self.entities(ctx, "target", false)?;
    // rust: let Some(target) = targets.first().copied() else {
    // rust: return Ok(0);
}
    // rust: let amount = match ctx.get("amount") {
    // rust: Some(Arg::Float(a)) => *a,
    // rust: _ => 0.0,
}
    // rust: let ty = match ctx.get("damageType") {
    // rust: Some(Arg::Resource(t)) => t.clone(),
    // rust: _ => "minecraft:generic".into(),
}
    // rust: let by = match ctx.get("entity") {
    // rust: Some(Arg::Entity(_)) => self.entities(ctx, "entity", false)?.first().copied(),
    // rust: _ => None,
}
    // rust: let cause = match ctx.get("cause") {
    // rust: Some(Arg::Entity(_)) => self.entities(ctx, "cause", false)?.first().copied(),
    // rust: _ => None,
}
    // rust: let from = match ctx.get("location") {
    // rust: Some(Arg::Coords(_)) => self.position_arg(ctx, "location"),
    // rust: _ => by.and_then(|t| self.target_position(t)),
}
        // A lethal item hit discards it before the success message is built.
    // rust: let item_name = matches!(target, Target::Item(_)).then(|| self.target_name(target));
    // rust: let hurt = match target {
            // The causing mob is the one the hit is credited to and thorns
            // answer; the source position gives the knockback its direction.
    // rust: Target::Player | Target::Guest(_) => {
                // `DamageSource(type, cause, by)`: the death message names the
                // causing entity, else the direct one. A mob is noted by
                // `hurt_player_from`, a player here.
    // rust: let named = match cause.or(by) {
    // rust: Some(t @ (Target::Player | Target::Guest(_))) => Some(self.target_name(t)),
    // rust: _ => None,
}
    // rust: let attacker = match cause.or(by) {
    // rust: Some(Target::Mob(i)) => Some(Some(i)),
    // rust: _ => Some(None),
}
    // rust: self.for_player(target, |g| {
    // rust: if g.spectator() {
    // rust: return false;
}
    // rust: if let Some(name) = named {
    // rust: g.note_direct_entity(&ty, name);
}
    // rust: g.hurt_player_from(amount, from, &ty, attacker)
    // rust: })
    // rust: .unwrap_or(false)
}
    // rust: Target::Mob(id) => {
    // rust: let attacker = cause.or(by).and_then(|t| match t {
    // rust: Target::Player | Target::Guest(_) => Some(Who::Player),
    // rust: Target::Mob(i) => Some(Who::Mob(i)),
    // rust: _ => None,
    // rust: });
    // rust: let attacker_species = match attacker {
    // rust: Some(Who::Mob(i)) => self.mobs.iter().find(|m| m.id == i).map(|m| m.species()),
    // rust: _ => None,
}
    // rust: let damage = Damage {
    // rust: kind: Self::damage_kind(&ty),
    // rust: attacker,
    // rust: from,
    // rust: attacker_species,
}
                // DamageSource.getEntity is the causing player, even when
                // another client issued the command or supplied the direct entity.
    // rust: let guest = match cause.or(by) {
    // rust: Some(Target::Guest(conn)) if self.lan_acting != Some(conn) => Some(conn),
    // rust: _ => None,
}
    // rust: if let Some(conn) = guest {
    // rust: if let Some(mut host) = self.lan.take() {
    // rust: let hurt = self
    // rust: .as_guest(&mut host, conn, |g| {
    // rust: g.command_damage_mob(id, amount, damage)
    // rust: })
    // rust: .unwrap_or(false);
    // rust: if hurt {
    // rust: host.mob_players.insert(id, conn);
}
    // rust: self.lan = Some(host);
    // rust: hurt
    // rust: } else {
    // rust: false
}
    // rust: } else {
    // rust: self.command_damage_mob(id, amount, damage)
}
}
    // rust: Target::Item(id) => self.command_damage_item(id, amount, &ty, cause.or(by)),
    // rust: _ => false,
}
    // rust: if !hurt {
    // rust: return Err(err("commands.damage.invulnerable", &[]));
}
    // rust: let name = item_name.unwrap_or_else(|| self.target_name(target));
    // rust: self.feedback(Text::translate(
    // rust: "commands.damage.success",
    // rust: &[
    // rust: Text::literal(horizon_client::snbt::java_float(amount)),
    // rust: name,
    // rust: ],
    // rust: ));
    // rust: Ok(1)
}

    // `ItemEntity.hurtServer`: the item branch reached by `DamageCommand.damage`.
    // rust: fn command_damage_item(
    // rust: &mut self,
    // rust: id: u32,
    // rust: amount: f32,
    // rust: damage_type: &str,
    // rust: causing: Option<Target>,
    // rust: ) -> bool {
    // rust: let Some(index) = self.dropped.iter().position(|item| item.id == id) else {
    // rust: return false;
}
    // rust: let registry = &self.motion.health.damage;
    // rust: let Some(kind) = registry.id(damage_type) else {
    // rust: return false;
}
    // rust: let creative = match causing {
    // rust: Some(Target::Player) => self.creative,
    // rust: Some(Target::Guest(conn)) => self.command_guest(conn).is_some_and(|g| g.creative()),
    // rust: _ => false,
}
    // rust: let invulnerable = self
    // rust: .persist
    // rust: .raw
    // rust: .get(&id)
    // rust: .is_some_and(|tag| horizon_client::entity_nbt::flag(tag, "Invulnerable"));
    // rust: if invulnerable && !creative && !registry.in_tag(kind, "minecraft:bypasses_invulnerability")
    // rust: || !self.ui.rules.bool("mob_griefing") && matches!(causing, Some(Target::Mob(_)))
    // rust: || registry.in_tag(kind, "minecraft:is_fall")
    // rust: && self.entity_tag_matches("minecraft:fall_damage_immune", "minecraft:item")
    // rust: {
    // rust: return false;
}
        // Use the same defaults and stack patch as the component resolver,
        // including defaults changed by native mods and removed components.
    // rust: let components =
    // rust: self.pack
    // rust: .item_renderer
    // rust: .models
    // rust: .components(&horizon_client::item_render::stack_view(
    // rust: &self.dropped[index].stack,
    // rust: ));
    // rust: let resistant = |source: &str| {
    // rust: let matches = |value: &str| {
    // rust: let (tag, value) = value
    // rust: .strip_prefix('#')
    // rust: .map_or((false, value), |v| (true, v));
    // rust: let name = if value.contains(':') {
    // rust: value.to_owned()
    // rust: } else {
    // rust: format!("minecraft:{value}")
}
    // rust: if tag {
    // rust: registry
    // rust: .id(source)
    // rust: .is_some_and(|id| registry.in_tag(id, &name))
    // rust: } else {
    // rust: source == name
}
}
    // rust: match components
    // rust: .get("minecraft:damage_resistant")
    // rust: .and_then(|v| v.get("types"))
    // rust: {
    // rust: Some(serde_json::Value::String(value)) => matches(value),
    // rust: Some(serde_json::Value::Array(values)) => {
    // rust: values.iter().any(|v| v.as_str().is_some_and(matches))
}
    // rust: _ => false,
}
}
    // rust: if resistant(damage_type)
    // rust: || registry.in_tag(kind, "minecraft:is_fire") && resistant("minecraft:in_fire")
    // rust: {
    // rust: return false;
}
    // rust: let item = &mut self.dropped[index];
        // Java subtracts in float before truncating to int, including fractions
        // and accepted zero-damage hits.
    // rust: item.health = (item.health as f32 - amount) as i32;
    // rust: item.needs_sync = true;
    // rust: let at = item.position;
    // rust: self.sculk_prepare();
    // rust: let who = match causing {
    // rust: Some(Target::Player) => Some(Who::Player),
    // rust: Some(Target::Mob(id)) => Some(Who::Mob(id)),
    // rust: _ => None,
}
    // rust: let context = self.who_context(who, None);
    // rust: self.post_game_event("minecraft:entity_damage", [at.x, at.y, at.z], context);
    // rust: if self.dropped[index].health <= 0 {
    // rust: let contents = self.dropped[index].hurt(0).unwrap_or_default();
    // rust: self.dropped.remove(index);
    // rust: self.spawn_destroyed_contents(contents.into_iter().map(|stack| (stack, at)).collect());
}
    // rust: true
}

    // `DamageCommand.damage`: retain the accepted hit's player context and run
    // `Zombie.hurtServer`'s reinforcement requests before the command returns.
command_damage_mob :: proc(self: ^Self, id: u32, amount: f32, damage: Damage) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let player_uuid = (damage.attacker == Some(Who::Player))
    // rust: .then(|| self.owner_damage_uuid())
    // rust: .flatten();
    // rust: let mut reinforcements = Vec::new();
    // rust: let hurt = self.mobs.iter_mut().find(|m| m.id == id).is_some_and(|m| {
    // rust: let queued = m.outbox.len();
    // rust: let hurt = match player_uuid {
    // rust: Some(uuid) => m.damage_with_player_uuid(amount, damage, uuid, None),
    // rust: None => m.damage(amount, damage),
}
    // rust: if hurt {
    // rust: reinforcements = take_new_reinforcements(&mut m.outbox, queued);
}
    // rust: hurt
    // rust: });
    // rust: if hurt {
    // rust: self.resolve_player_responsible(id, damage);
    // rust: if damage.attacker == Some(Who::Player) {
    // rust: self.last_hurt_by_player.insert(id, self.lan_acting);
    // rust: if let Some(host) = self.lan.as_mut() {
    // rust: match self.lan_acting {
    // rust: Some(conn) => {
    // rust: host.mob_players.insert(id, conn);
}
    // rust: None => {
    // rust: host.mob_players.remove(&id);
}
}
}
}
}
    // rust: for (mob, target) in reinforcements {
    // rust: self.call_reinforcements(mob, target);
}
    // rust: hurt
}

    // ---- /rotate and /swing -----------------------------------------------------------

    // rust: pub(super) fn cmd_rotate(&mut self, ctx: &Context) -> R<i32> {
    // rust: let targets = self.entities(ctx, "target", false)?;
    // rust: let Some(t) = targets.first().copied() else {
    // rust: return Ok(0);
}
    // rust: let Some(pos) = self.target_position(t) else {
    // rust: return Ok(0);
}
    // rust: let current = self.target_rotation(t);
    // rust: let mut look_at_target = None;
    // rust: let rot = if let Some(Arg::Coords(c)) = ctx.get("rotation") {
            // Relative parts are offsets from the entity's own rotation.
    // rust: c.rotation(current)
    // rust: } else {
    // rust: let mut faced_entity = None;
    // rust: let to = if ctx.has("entity") {
    // rust: let faced = self.entities(ctx, "facingEntity", false)?;
    // rust: let Some(f) = faced.first().copied() else {
    // rust: return Ok(0);
}
    // rust: let mut p = self.target_position(f).unwrap_or(pos);
    // rust: let eyes = matches!(ctx.get("facingAnchor"), Some(Arg::Anchor(true)));
    // rust: if eyes {
    // rust: p[1] += self.target_eye_height(f);
}
    // rust: faced_entity = Some((f, eyes));
    // rust: p
    // rust: } else {
    // rust: self.position_arg(ctx, "facingLocation").unwrap_or(pos)
}
            // LookAt.perform: Entity.lookAt from the source's anchor (the
            // feet, unless `anchored eyes`).
    // rust: let anchored_eyes = self.command_source.is_some_and(|s| s.eyes);
    // rust: let eye = if anchored_eyes {
    // rust: self.target_eye_height(t)
    // rust: } else {
    // rust: 0.0
}
    // rust: let from = [pos[0], pos[1] + eye, pos[2]];
    // rust: look_at_target = Some((anchored_eyes, to, faced_entity));
    // rust: look_at(from, to)
}
        // RotateCommand: Entity.forceSetRotation, not a teleport.
    // rust: self.set_rotation(t, rot);
    // rust: if let Some((eyes, to, entity)) = look_at_target {
    // rust: self.send_player_look_at(t, eyes, to, entity);
}
    // rust: if t == Target::Player {
    // rust: self.pitch = rot[1].clamp(-90.0, 90.0);
}
    // rust: let name = self.target_name(t);
    // rust: self.feedback(Text::translate("commands.rotate.success", &[name]));
    // rust: Ok(1)
}
    // rust: pub(super) fn cmd_swing(&mut self, ctx: &Context) -> R<i32> {
    // rust: let targets = if ctx.get("targets").is_some() {
    // rust: self.entities(ctx, "targets", false)?
    // rust: } else {
    // rust: vec![
    // rust: self.command_source
    // rust: .and_then(|s| s.entity)
    // rust: .unwrap_or(Target::Player),
    // rust: ]
}
    // rust: let mut tracker = Tracker::default();
    // rust: for t in targets {
    // rust: match t {
    // rust: Target::Player => self.swing_arm(),
    // rust: Target::Mob(id) => {
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == id) {
    // rust: m.ai.swinging = true;
    // rust: m.ai.swing_time = -1;
}
}
                // An armor stand is a LivingEntity: it swings (invisibly).
    // rust: Target::Stand(_) => {}
    // rust: _ => continue,
}
    // rust: let h = holder(self.target_name(t));
    // rust: tracker.mark(&h);
}
    // rust: let (message, total) = tracker.message(
    // rust: false,
    // rust: Some(err("commands.swing.failed.notliving", &[])),
    // rust: |h, _| {
    // rust: Text::translate(
    // rust: "commands.swing.success.single",
    // rust: std::slice::from_ref(&h.text),
    // rust: )
    // rust: },
    // rust: |c, _| Text::translate("commands.swing.success.multiple", &[num(c)]),
    // rust: )?;
    // rust: self.feedback(message);
    // rust: Ok(total)
}

    // ---- sounds -----------------------------------------------------------------------

    // rust: pub(super) fn cmd_playsound(&mut self, ctx: &Context) -> R<i32> {
    // rust: let Some(Arg::Resource(sound)) = ctx.get("sound").cloned() else {
    // rust: return Ok(0);
}
    // rust: let source = ctx
    // rust: .literals
    // rust: .iter()
    // rust: .find_map(|l| SOUND_SOURCES.iter().position(|s| s == l))
    // rust: .unwrap_or(0);
    // rust: let targets = if ctx.get("targets").is_some() {
    // rust: self.entities(ctx, "targets", true)?
    // rust: } else {
    // rust: vec![Target::Player]
}
    // rust: let pos = self
    // rust: .position_arg(ctx, "pos")
    // rust: .unwrap_or_else(|| self.source_position());
    // rust: let float = |name: &str, default: f32| match ctx.get(name) {
    // rust: Some(Arg::Float(v)) => *v,
    // rust: _ => default,
}
    // rust: let (volume, pitch, min_volume) = (
    // rust: float("volume", 1.0),
    // rust: float("pitch", 1.0),
    // rust: float("minVolume", 0.0),
    // rust: );
    // rust: let range = if volume > 1.0 { 16.0 * volume } else { 16.0 };
        // PlaySoundCommand: one seed for every player.
    // rust: let seed = self.world.random.next_long();
    // rust: let here = self.dim.id();
    // rust: let mut tracker = Tracker::default();
    // rust: for t in targets {
    // rust: if !matches!(t, Target::Player | Target::Guest(_)) {
    // rust: continue;
}
            // Only players in the source's level hear it.
    // rust: if let Target::Guest(conn) = t
    // rust: && self.command_guest(conn).is_none_or(|g| g.dimension != here)
    // rust: {
    // rust: continue;
}
    // rust: let Some(p) = self.target_position(t) else {
    // rust: continue;
}
    // rust: let Some((at, v)) = playsound_placement(pos, p, range, volume, min_volume) else {
    // rust: continue;
}
            // The connection is sent the sound; the window's own player
            // plays it.
    // rust: let guest = match t {
    // rust: Target::Guest(conn) => Some(conn),
    // rust: _ => self.lan_acting,
}
    // rust: match guest.and_then(|conn| Some((conn, self.lan.as_ref()?))) {
    // rust: Some((conn, host)) => {
    // rust: let packet = host
    // rust: .hub
    // rust: .sound_packet(&sound, at, v, pitch, source as i32, seed);
    // rust: if t == Target::Player {
    // rust: self.guest_packets.push(packet);
    // rust: } else {
    // rust: host.hub.send_to(conn, &packet);
}
}
    // rust: None => self.audio.play_on(source, &sound, Some(at), v, pitch),
}
    // rust: tracker.mark(&holder(self.target_name(t)));
}
    // rust: let name = Text::literal(sound.clone());
    // rust: let (message, total) = tracker.message(
    // rust: true,
    // rust: Some(err("commands.playsound.failed", &[])),
    // rust: |h, _| {
    // rust: Text::translate(
    // rust: "commands.playsound.success.single",
    // rust: &[name.clone(), h.text.clone()],
    // rust: )
    // rust: },
    // rust: |c, _| {
    // rust: Text::translate(
    // rust: "commands.playsound.success.multiple",
    // rust: &[name.clone(), num(c)],
    // rust: )
    // rust: },
    // rust: )?;
    // rust: self.feedback(message);
    // rust: Ok(total)
}
    // rust: pub(super) fn cmd_stopsound(&mut self, ctx: &Context) -> R<i32> {
    // rust: let targets = self.entities(ctx, "targets", true)?;
    // rust: let source = ctx
    // rust: .literals
    // rust: .iter()
    // rust: .find_map(|l| SOUND_SOURCES.iter().position(|s| s == l));
    // rust: let sound = match ctx.get("sound") {
    // rust: Some(Arg::Resource(s)) => Some(s.clone()),
    // rust: _ => None,
}
        // StopSoundCommand: each target's connection gets the packet; the
        // window's own player stops its sounds.
    // rust: let packet = C::StopSound(play::StopSound {
    // rust: source: source.map(|s| s as i32),
    // rust: sound: sound.clone(),
    // rust: });
    // rust: for &t in &targets {
    // rust: match t {
    // rust: Target::Player if self.lan_acting.is_some() => {
    // rust: self.guest_packets.push(packet.clone());
}
    // rust: Target::Player => self.audio.stop_sounds(sound.as_deref(), source),
    // rust: Target::Guest(conn) => {
    // rust: if let Some(host) = self.lan.as_ref() {
    // rust: host.hub.send_to(conn, &packet);
}
}
    // rust: _ => {}
}
}
    // rust: let key = match (source, &sound) {
    // rust: (Some(_), Some(_)) => "commands.stopsound.success.source.sound",
    // rust: (Some(_), None) => "commands.stopsound.success.source.any",
    // rust: (None, Some(_)) => "commands.stopsound.success.sourceless.sound",
    // rust: (None, None) => "commands.stopsound.success.sourceless.any",
}
    // rust: let mut args = Vec::new();
    // rust: if let Some(s) = &sound {
    // rust: args.push(Text::literal(s.clone()));
}
    // rust: if let Some(i) = source {
    // rust: args.push(Text::literal(SOUND_SOURCES[i]));
}
    // rust: self.feedback(Text::translate(key, &args));
    // rust: Ok(targets.len() as i32)
}

    // ---- /particle ----------------------------------------------------------------------

    // rust: pub(super) fn cmd_particle(&mut self, ctx: &Context) -> R<i32> {
//         use horizon_client::particles::{ParticleOptions, ParticleType};
    // rust: let Some(Arg::Str(spec)) = ctx.get("name").cloned() else {
    // rust: return Ok(0);
}
        // ParticleArgument: `id` then optional SNBT options (`dust{color:[1,0,0],scale:2}`).
    // rust: let (name, options_text) = match spec.find('{') {
    // rust: Some(i) => (&spec[..i], &spec[i..]),
    // rust: None => (spec.as_str(), ""),
}
    // rust: let ty = ParticleType::from_name(name).ok_or_else(|| err("particle.notFound", &[&name]))?;
    // rust: let opts = match horizon_client::command::snbt::parse_fully(options_text) {
    // rust: Ok(Tag::Compound(c)) if !options_text.is_empty() => Some(c),
    // rust: _ => None,
}
    // rust: let field = |key: &str| opts.as_ref().and_then(|c| c.get(&key.into()).cloned());
    // rust: let number = |t: &Tag| -> Option<f32> {
    // rust: Some(match t {
    // rust: Tag::Byte(v) => f32::from(*v),
    // rust: Tag::Short(v) => f32::from(*v),
    // rust: Tag::Int(v) => *v as f32,
    // rust: Tag::Long(v) => *v as f32,
    // rust: Tag::Float(v) => f32::from_bits(*v),
    // rust: Tag::Double(v) => f64::from_bits(*v) as f32,
    // rust: _ => return None,
    // rust: })
}
    // rust: let string = |t: &Tag| match t {
    // rust: Tag::String(s) => Some(s.to_string_lossy()),
    // rust: _ => None,
}
        // ExtraCodecs.RGB_COLOR_CODEC: an int or a list of three floats.
    // rust: let rgb = match field("color") {
    // rust: Some(Tag::List(l)) if l.len() >= 3 => [
    // rust: number(&l[0]).unwrap_or(1.0),
    // rust: number(&l[1]).unwrap_or(0.0),
    // rust: number(&l[2]).unwrap_or(0.0),
    // rust: ],
    // rust: Some(Tag::Int(v)) => [
    // rust: ((v >> 16) & 255) as f32 / 255.0,
    // rust: ((v >> 8) & 255) as f32 / 255.0,
    // rust: (v & 255) as f32 / 255.0,
    // rust: ],
    // rust: _ => [1.0, 0.0, 0.0],
}
        // The block state of a block particle, for its packet.
    // rust: let mut block_state = None;
    // rust: let options = match ty {
    // rust: ParticleType::Dust => ParticleOptions::dust(
    // rust: rgb,
    // rust: field("scale")
    // rust: .as_ref()
    // rust: .and_then(number)
    // rust: .unwrap_or(1.0)
    // rust: .clamp(0.01, 4.0),
    // rust: ),
            // ItemParticleOption: an item id, or a stack {id, ...}.
    // rust: ParticleType::Item => {
    // rust: let id = match field("item") {
    // rust: Some(Tag::String(s)) => s.to_string_lossy(),
    // rust: Some(Tag::Compound(c)) => {
    // rust: c.get(&"id".into()).and_then(string).unwrap_or_default()
}
    // rust: _ => String::new(),
}
    // rust: let id = if id.contains(':') {
    // rust: id
    // rust: } else {
    // rust: format!("minecraft:{id}")
}
    // rust: self.item_particle(&horizon_client::items::ItemStack::new(&id, 1))
}
    // rust: ParticleType::ItemSlime | ParticleType::ItemSnowball | ParticleType::ItemCobweb => {
    // rust: self.ensure_item_particle_sprites();
    // rust: ParticleOptions::simple(ty)
}
    // rust: ParticleType::Block
    // rust: | ParticleType::FallingDust
    // rust: | ParticleType::DustPillar
    // rust: | ParticleType::BlockMarker => {
                // BlockParticleOption: a block id, or {Name, Properties}.
    // rust: let text = match field("block_state") {
    // rust: Some(Tag::String(s)) => s.to_string_lossy(),
    // rust: Some(Tag::Compound(c)) => {
    // rust: let name = c.get(&"Name".into()).and_then(string).unwrap_or_default();
    // rust: let props: Vec<String> = match c.get(&"Properties".into()) {
    // rust: Some(Tag::Compound(p)) => p
    // rust: .iter()
    // rust: .filter_map(|(k, v)| {
    // rust: string(v).map(|v| format!("{}={v}", k.to_string_lossy()))
    // rust: })
    // rust: .collect(),
    // rust: _ => Vec::new(),
}
    // rust: if props.is_empty() {
    // rust: name
    // rust: } else {
    // rust: format!("{name}[{}]", props.join(","))
}
}
    // rust: _ => String::new(),
}
    // rust: let mut reader = horizon_client::command::Reader::new(&text);
    // rust: let block = horizon_client::command::args::ArgType::BlockState
    // rust: .parse(&mut reader, &self.ui.registries);
    // rust: match block {
    // rust: Ok(Arg::Block(b)) => {
    // rust: let state = self.block_state(&b)?;
    // rust: block_state = Some(state);
    // rust: let at = self
    // rust: .position_arg(ctx, "pos")
    // rust: .unwrap_or_else(|| self.source_position())
    // rust: .map(|c| c.floor() as i32);
    // rust: let (sprite, tint) = self
    // rust: .particle_sprite(state, at)
    // rust: .unwrap_or_else(|| ("block/stone".into(), 0xFFFFFF));
    // rust: ParticleOptions::block(ty, sprite, tint)
}
    // rust: _ => ParticleOptions::simple(ty),
}
}
    // rust: _ => ParticleOptions::simple(ty),
}
    // rust: let pos = self
    // rust: .position_arg(ctx, "pos")
    // rust: .unwrap_or_else(|| self.source_position());
        // Vec3Argument.getVec3: the spread as given (relative parts from the
        // source), not a position to measure from the source.
    // rust: let delta = self.position_arg(ctx, "delta").unwrap_or([0.0; 3]);
    // rust: let speed = match ctx.get("speed") {
    // rust: Some(Arg::Float(v)) => *v,
    // rust: _ => 0.0,
}
    // rust: let count = match ctx.get("count") {
    // rust: Some(Arg::Int(c)) => *c,
    // rust: _ => 0,
}
        // ParticleCommand.sendParticles: the viewers it reached, each within
        // 32 blocks (512 with `force`) of the particle's block centre.
        // Without viewers, every player (PlayerList.getPlayers).
    // rust: let viewers = if ctx.get("viewers").is_some() {
    // rust: self.entities(ctx, "viewers", true)?
    // rust: } else {
    // rust: let acting = self.lan_acting;
    // rust: let guests = self.lan.iter().flat_map(|h| h.hub.guests.iter());
    // rust: self.player
    // rust: .as_ref()
    // rust: .map(|_| Target::Player)
    // rust: .into_iter()
    // rust: .chain(
    // rust: guests
    // rust: .filter(|g| g.placed && Some(g.conn) != acting)
    // rust: .map(|g| Target::Guest(g.conn)),
    // rust: )
    // rust: .collect()
}
    // rust: let force = ctx.has("force");
    // rust: let limit = if force { 512.0 } else { 32.0 };
    // rust: let reached: Vec<Target> = viewers
    // rust: .into_iter()
    // rust: .filter(|&t| {
    // rust: self.target_position(t).is_some_and(|p| {
    // rust: let c = p.map(|v| v.floor() + 0.5);
    // rust: (c[0] - pos[0]).powi(2) + (c[1] - pos[1]).powi(2) + (c[2] - pos[2]).powi(2)
    // rust: < limit * limit
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: if reached.is_empty() {
    // rust: return Err(err("commands.particle.failed", &[]));
}
        // ServerLevel.sendParticles: each viewer a server serves is sent the
        // particles (the player in place too when it is a guest); the
        // window's own player draws them.
    // rust: let packet = self
    // rust: .network_particle(&options, block_state)
    // rust: .map(|particle| {
    // rust: C::LevelParticles(play::LevelParticles {
    // rust: particle,
    // rust: override_limiter: force,
    // rust: always_show: false,
    // rust: pos,
    // rust: dist: delta.map(|d| d as f32),
    // rust: max_speed: [speed; 3],
    // rust: count: count.max(0),
    // rust: randomization: 0,
    // rust: })
    // rust: });
    // rust: let mut local = false;
    // rust: for &t in &reached {
    // rust: match (t, &packet) {
    // rust: (Target::Player, Some(p)) if self.lan_acting.is_some() => {
    // rust: self.guest_packets.push(p.clone());
}
    // rust: (Target::Player, _) => local = true,
    // rust: (Target::Guest(conn), Some(p)) => {
    // rust: if let Some(host) = self.lan.as_ref() {
    // rust: host.hub.send_to(conn, p);
}
}
    // rust: _ => {}
}
}
    // rust: let reached = reached.len() as i32;
    // rust: if !local {
    // rust: } else if count <= 0 {
            // handleParticleEvent, count 0: one particle, the speed times
            // the delta as velocity (both sent as floats, multiplied as floats).
    // rust: self.particles
    // rust: .create(&options, pos, delta.map(|d| f64::from(speed * d as f32)));
    // rust: } else {
    // rust: for _ in 0..count {
    // rust: let r = self.particles.random();
    // rust: let p = [
    // rust: pos[0] + r.next_gaussian() * delta[0],
    // rust: pos[1] + r.next_gaussian() * delta[1],
    // rust: pos[2] + r.next_gaussian() * delta[2],
    // rust: ];
    // rust: let v = [
    // rust: r.next_gaussian() * f64::from(speed),
    // rust: r.next_gaussian() * f64::from(speed),
    // rust: r.next_gaussian() * f64::from(speed),
    // rust: ];
    // rust: self.particles.create(&options, p, v);
}
}
    // rust: self.feedback(Text::translate(
    // rust: "commands.particle.success",
    // rust: &[Text::literal(name.to_owned())],
    // rust: ));
    // rust: Ok(reached)
}

    // ---- /attribute ---------------------------------------------------------------------

    // The attribute id without `minecraft:`, as the attribute map names it.
attribute_description :: proc(attribute: string) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let short = attribute.trim_start_matches("minecraft:");
    // rust: Text::translate(&format!("attribute.name.{short}"), &[])
}
    // Read arms follow `AttributeCommand.getAttributeValue` and
    // `AttributeCommand.getAttributeModifier`: effective values include modeled
    // transient modifiers; base reads still use the unmodified base.
    // rust: pub(super) fn cmd_attribute(&mut self, id: &str, ctx: &Context) -> R<i32> {
    // rust: let targets = self.entities(ctx, "target", false)?;
    // rust: let Some(target) = targets.first().copied() else {
    // rust: return Ok(0);
}
    // rust: let Some(Arg::Resource(attribute)) = ctx.get("attribute").cloned() else {
    // rust: return Ok(0);
}
        // An unbounded selector reaches every loaded level, so the target may
        // be in another one than the command's (EntitySelector.findEntities,
        // AttributeCommand acting on the entity itself).
    // rust: self.in_target_level(target, |g| {
    // rust: g.attribute_in_level(id, ctx, target, &attribute)
    // rust: })
    // rust: .unwrap_or(Ok(0))
}
    // `/attribute` on a target, with the target's own level in place.
    // rust: fn attribute_in_level(
    // rust: &mut self,
    // rust: id: &str,
    // rust: ctx: &Context,
    // rust: target: Target,
    // rust: attribute: &str,
    // rust: ) -> R<i32> {
    // rust: let name = self.target_name(target);
    // rust: let description = Self::attribute_description(attribute);
    // rust: let short = attribute.trim_start_matches("minecraft:").to_owned();
    // rust: let no_attribute = |name: &Text, d: &Text| {
    // rust: text_error(
    // rust: "commands.attribute.failed.no_attribute",
    // rust: &[name.clone(), d.clone()],
    // rust: )
}
    // rust: let scale = match ctx.get("scale") {
    // rust: Some(Arg::Double(s)) => *s,
    // rust: _ => 1.0,
}
    // rust: let value_arg = match ctx.get("value") {
    // rust: Some(Arg::Double(v)) => *v,
    // rust: _ => 0.0,
}
    // rust: let modifier_id = match ctx.get("id") {
    // rust: Some(Arg::Resource(m)) => m.clone(),
    // rust: _ => String::new(),
}
    // rust: match target {
    // rust: Target::Player => {
    // rust: let Some(player) = self.player.as_mut() else {
    // rust: return Ok(0);
}
    // rust: let Some(key) = player.attributes.key(attribute) else {
    // rust: return Err(no_attribute(&name, &description));
}
    // rust: let unavailable = |_| no_attribute(&name, &description);
    // rust: match id {
    // rust: "attribute.get" | "attribute.base.get" => {
    // rust: let kind = if id == "attribute.get" {
    // rust: ValueKind::Computed
    // rust: } else {
    // rust: ValueKind::Base
}
    // rust: let v = player
    // rust: .attributes
    // rust: .value(Some(key), kind)
    // rust: .map_err(unavailable)?;
    // rust: let k = if id == "attribute.get" {
    // rust: "commands.attribute.value.get.success"
    // rust: } else {
    // rust: "commands.attribute.base_value.get.success"
}
    // rust: self.feedback(Text::translate(
    // rust: k,
    // rust: &[description, name, java_double_text(v)],
    // rust: ));
    // rust: Ok((v * scale) as i32)
}
    // rust: "attribute.base.set" => {
    // rust: let handle = player
    // rust: .attributes
    // rust: .get_instance(Some(key))
    // rust: .ok()
    // rust: .flatten()
    // rust: .ok_or_else(|| no_attribute(&name, &description))?;
    // rust: let _ = player.attributes.edit(&handle, |value, observer| {
    // rust: value.set_base_value(value_arg, observer)
    // rust: });
                        // onAttributeUpdated: a lowered max_health clamps health.
    // rust: if attribute == "minecraft:max_health" {
    // rust: let _ = player.clamp_health_to_max();
}
    // rust: self.feedback(Text::translate(
    // rust: "commands.attribute.base_value.set.success",
    // rust: &[description, name, java_double_text(value_arg)],
    // rust: ));
    // rust: Ok(1)
}
    // rust: "attribute.base.reset" => {
    // rust: if !player
    // rust: .attributes
    // rust: .reset_base(Some(key.clone()))
    // rust: .unwrap_or(false)
    // rust: {
    // rust: return Err(no_attribute(&name, &description));
}
    // rust: let v = player
    // rust: .attributes
    // rust: .value(Some(key.clone()), ValueKind::Base)
    // rust: .unwrap_or(0.0);
    // rust: if attribute == "minecraft:max_health" {
    // rust: let _ = player.clamp_health_to_max();
}
    // rust: self.feedback(Text::translate(
    // rust: "commands.attribute.base_value.reset.success",
    // rust: &[description, name, java_double_text(v)],
    // rust: ));
    // rust: Ok(1)
}
    // rust: "attribute.modifier.add" => {
    // rust: if player
    // rust: .attributes
    // rust: .has_modifier(Some(key), &modifier_id)
    // rust: .unwrap_or(false)
    // rust: {
    // rust: return Err(text_error(
    // rust: "commands.attribute.failed.modifier_already_present",
    // rust: &[
    // rust: Text::literal(modifier_id.clone()),
    // rust: description.clone(),
    // rust: name.clone(),
    // rust: ],
    // rust: ));
}
    // rust: let op = ctx
    // rust: .literals
    // rust: .last()
    // rust: .cloned()
    // rust: .unwrap_or_else(|| "add_value".into());
    // rust: player
    // rust: .set_modifier(attribute, &modifier_id, value_arg, &op, true)
    // rust: .map_err(|_| no_attribute(&name, &description))?;
    // rust: self.feedback(Text::translate(
    // rust: "commands.attribute.modifier.add.success",
    // rust: &[Text::literal(modifier_id), description, name],
    // rust: ));
    // rust: Ok(1)
}
    // rust: "attribute.modifier.remove" => {
    // rust: if !player
    // rust: .attributes
    // rust: .has_modifier(Some(key), &modifier_id)
    // rust: .unwrap_or(false)
    // rust: {
    // rust: return Err(text_error(
    // rust: "commands.attribute.failed.no_modifier",
    // rust: &[
    // rust: description.clone(),
    // rust: name.clone(),
    // rust: Text::literal(modifier_id.clone()),
    // rust: ],
    // rust: ));
}
    // rust: let _ =
    // rust: player.set_modifier(attribute, &modifier_id, 0.0, "add_value", false);
    // rust: self.feedback(Text::translate(
    // rust: "commands.attribute.modifier.remove.success",
    // rust: &[Text::literal(modifier_id), description, name],
    // rust: ));
    // rust: Ok(1)
}
    // rust: _ => {
    // rust: let Some(handle) = player.attributes.get_instance(Some(key)).ok().flatten()
    // rust: else {
    // rust: return Err(no_attribute(&name, &description));
}
    // rust: let found = player
    // rust: .attributes
    // rust: .edit(&handle, |value, _| {
    // rust: Ok(value
    // rust: .modifiers()
    // rust: .iter()
    // rust: .find(|m| m.id() == modifier_id)
    // rust: .map(|m| m.amount()))
    // rust: })
    // rust: .ok()
    // rust: .flatten();
    // rust: let Some(v) = found else {
    // rust: return Err(text_error(
    // rust: "commands.attribute.failed.no_modifier",
    // rust: &[
    // rust: description.clone(),
    // rust: name.clone(),
    // rust: Text::literal(modifier_id.clone()),
    // rust: ],
    // rust: ));
}
    // rust: self.feedback(Text::translate(
    // rust: "commands.attribute.modifier.value.get.success",
    // rust: &[
    // rust: Text::literal(modifier_id),
    // rust: description,
    // rust: name,
    // rust: java_double_text(v),
    // rust: ],
    // rust: ));
    // rust: Ok((v * scale) as i32)
}
}
}
    // rust: Target::Mob(_) | Target::Stand(_)
    // rust: if !(matches!(target, Target::Mob(_))
    // rust: && finalize::command_attr(short.as_str()).is_some()) =>
    // rust: {
    // rust: let op = ctx
    // rust: .literals
    // rust: .last()
    // rust: .cloned()
    // rust: .unwrap_or_else(|| "add_value".into());
    // rust: self.generic_attribute(
    // rust: target,
    // rust: id,
    // rust: attribute,
    // rust: (&name, &description),
    // rust: (value_arg, scale, &modifier_id, &op),
    // rust: )
}
    // rust: Target::Mob(mob_id) => {
    // rust: let Some(m) = self.mobs.iter_mut().find(|m| m.id == mob_id) else {
    // rust: return Ok(0);
}
                // The attributes the mob's gameplay reads live in `finalize`;
                // the command edits that store, never a copy of it.
    // rust: let Some(attr) = finalize::command_attr(short.as_str())
    // rust: .filter(|a| finalize::default_value(m, *a).is_some())
    // rust: else {
    // rust: return Err(no_attribute(&name, &description));
}
    // rust: let current = if id == "attribute.base.get" {
    // rust: finalize::base_value(m, attr)
    // rust: } else {
    // rust: finalize::value(m, attr)
}
    // rust: let no_modifier = text_error(
    // rust: "commands.attribute.failed.no_modifier",
    // rust: &[
    // rust: description.clone(),
    // rust: name.clone(),
    // rust: Text::literal(modifier_id.clone()),
    // rust: ],
    // rust: );
    // rust: match id {
    // rust: "attribute.get" | "attribute.base.get" => {
    // rust: let k = if id == "attribute.get" {
    // rust: "commands.attribute.value.get.success"
    // rust: } else {
    // rust: "commands.attribute.base_value.get.success"
}
    // rust: self.feedback(Text::translate(
    // rust: k,
    // rust: &[description, name, java_double_text(current)],
    // rust: ));
    // rust: Ok((current * scale) as i32)
}
    // rust: "attribute.base.set" => {
                        // AttributeInstance keeps the raw base and clamps only the
                        // effective value; Health is unchanged.
    // rust: finalize::set_base(m, attr, value_arg);
    // rust: self.feedback(Text::translate(
    // rust: "commands.attribute.base_value.set.success",
    // rust: &[description, name, java_double_text(value_arg)],
    // rust: ));
    // rust: Ok(1)
}
    // rust: "attribute.base.reset" => {
    // rust: let default = finalize::default_value(m, attr).unwrap_or_default();
    // rust: finalize::set_base(m, attr, default);
    // rust: let v = finalize::base_value(m, attr);
    // rust: self.feedback(Text::translate(
    // rust: "commands.attribute.base_value.reset.success",
    // rust: &[description, name, java_double_text(v)],
    // rust: ));
    // rust: Ok(1)
}
    // rust: "attribute.modifier.add" => {
    // rust: if finalize::has_modifier(m, attr, &modifier_id) {
    // rust: return Err(text_error(
    // rust: "commands.attribute.failed.modifier_already_present",
    // rust: &[Text::literal(modifier_id.clone()), description, name],
    // rust: ));
}
    // rust: let op = match ctx.literals.last().map(String::as_str) {
    // rust: Some("add_multiplied_base") => finalize::Op::AddMultipliedBase,
    // rust: Some("add_multiplied_total") => finalize::Op::AddMultipliedTotal,
    // rust: _ => finalize::Op::AddValue,
}
    // rust: finalize::add_modifier(m, attr, modifier_id.clone(), value_arg, op);
    // rust: self.feedback(Text::translate(
    // rust: "commands.attribute.modifier.add.success",
    // rust: &[Text::literal(modifier_id.clone()), description, name],
    // rust: ));
    // rust: Ok(1)
}
    // rust: "attribute.modifier.remove" => {
    // rust: if !finalize::has_modifier(m, attr, &modifier_id) {
    // rust: return Err(no_modifier);
}
    // rust: finalize::remove_modifier(m, attr, &modifier_id);
    // rust: self.feedback(Text::translate(
    // rust: "commands.attribute.modifier.remove.success",
    // rust: &[Text::literal(modifier_id.clone()), description, name],
    // rust: ));
    // rust: Ok(1)
}
    // rust: _ => {
                        // Permanent entries stay authoritative. The modeled baby
                        // modifier is transient and absent from that saved store.
    // rust: let amount =
    // rust: finalize::modifier_amount(m, attr, &modifier_id).or_else(|| {
    // rust: finalize::transient(m, attr)
    // rust: .filter(|_| modifier_id == "minecraft:baby")
    // rust: .map(|(amount, _)| amount)
    // rust: });
    // rust: let Some(v) = amount else {
    // rust: return Err(no_modifier);
}
    // rust: self.feedback(Text::translate(
    // rust: "commands.attribute.modifier.value.get.success",
    // rust: &[
    // rust: Text::literal(modifier_id.clone()),
    // rust: description,
    // rust: name,
    // rust: java_double_text(v),
    // rust: ],
    // rust: ));
    // rust: Ok((v * scale) as i32)
}
}
}
    // rust: _ => Err(text_error(
    // rust: "commands.attribute.failed.entity",
    // rust: std::slice::from_ref(&name),
    // rust: )),
}
}

    // The attribute map of a living entity whose attributes Horizon does
    // not model, created from its type's defaults on first use.
    // rust: pub(in crate::game) fn generic_attributes(
    // rust: &mut self,
    // rust: t: Target,
    // rust: attribute: &str,
    // rust: ) -> Option<&mut horizon_world::attributes::entity::EntityAttributes> {
    // rust: if let Target::Mob(id) = t
    // rust: && matches!(attribute, "minecraft:armor" | "minecraft:armor_toughness")
    // rust: {
    // rust: let mob = self.mobs.iter_mut().find(|m| m.id == id)?;
    // rust: if mob.extra.armor_attributes.is_none() {
    // rust: mob.extra.armor_attributes =
    // rust: self.motion.attributes.create(&mob.kind.id).map(Box::new);
}
    // rust: return mob.extra.armor_attributes.as_deref_mut();
}
    // rust: if !self.cmds.attributes.contains_key(&t) {
    // rust: let ty = self.target_type(t);
    // rust: let map = self.motion.attributes.create(&ty)?;
    // rust: self.cmds.attributes.insert(t, map);
}
    // rust: self.cmds.attributes.get_mut(&t)
}
    // AttributeCommand on a living entity through its generic attribute map.
    // rust: fn generic_attribute(
    // rust: &mut self,
    // rust: target: Target,
    // rust: id: &str,
    // rust: attribute: &str,
    // rust: (name, description): (&Text, &Text),
    // rust: (value_arg, scale, modifier_id, op): (f64, f64, &str, &str),
    // rust: ) -> R<i32> {
//         use horizon_world::attributes::{Modifier, Operation};
    // rust: let no_attribute = || {
    // rust: text_error(
    // rust: "commands.attribute.failed.no_attribute",
    // rust: &[name.clone(), description.clone()],
    // rust: )
}
    // rust: let no_modifier = || {
    // rust: text_error(
    // rust: "commands.attribute.failed.no_modifier",
    // rust: &[
    // rust: description.clone(),
    // rust: name.clone(),
    // rust: Text::literal(modifier_id),
    // rust: ],
    // rust: )
}
    // rust: let catalog = self.motion.attributes.clone();
    // rust: let key = catalog.id(attribute).ok_or_else(no_attribute)?;
    // rust: let map = self
    // rust: .generic_attributes(target, attribute)
    // rust: .ok_or_else(no_attribute)?;
    // rust: if !map.has(key) {
    // rust: return Err(no_attribute());
}
    // rust: let (message, args, result) = match id {
    // rust: "attribute.get" | "attribute.base.get" => {
    // rust: let v = if id == "attribute.get" {
    // rust: map.value(key).map_err(|_| no_attribute())?
    // rust: } else {
    // rust: map.base_value(key).map_err(|_| no_attribute())?
}
    // rust: let k = if id == "attribute.get" {
    // rust: "commands.attribute.value.get.success"
    // rust: } else {
    // rust: "commands.attribute.base_value.get.success"
}
    // rust: (
    // rust: k,
    // rust: vec![description.clone(), name.clone(), java_double_text(v)],
    // rust: (v * scale) as i32,
    // rust: )
}
    // rust: "attribute.base.set" => {
    // rust: map.edit(key, |a, o| {
    // rust: let _ = a.set_base_value(value_arg, o);
    // rust: });
    // rust: (
    // rust: "commands.attribute.base_value.set.success",
    // rust: vec![
    // rust: description.clone(),
    // rust: name.clone(),
    // rust: java_double_text(value_arg),
    // rust: ],
    // rust: 1,
    // rust: )
}
    // rust: "attribute.base.reset" => {
    // rust: map.reset_base(key);
    // rust: let v = map.base_value(key).unwrap_or(0.0);
    // rust: (
    // rust: "commands.attribute.base_value.reset.success",
    // rust: vec![description.clone(), name.clone(), java_double_text(v)],
    // rust: 1,
    // rust: )
}
    // rust: "attribute.modifier.add" => {
    // rust: if map.has_modifier(key, modifier_id) {
    // rust: return Err(text_error(
    // rust: "commands.attribute.failed.modifier_already_present",
    // rust: &[
    // rust: Text::literal(modifier_id),
    // rust: description.clone(),
    // rust: name.clone(),
    // rust: ],
    // rust: ));
}
    // rust: let operation = match op {
    // rust: "add_multiplied_base" => Operation::AddMultipliedBase,
    // rust: "add_multiplied_total" => Operation::AddMultipliedTotal,
    // rust: _ => Operation::AddValue,
}
    // rust: let m =
    // rust: Modifier::new(modifier_id, value_arg, operation).map_err(|_| no_attribute())?;
    // rust: map.edit(key, |a, o| {
    // rust: let _ = a.add_permanent(m, o);
    // rust: });
    // rust: (
    // rust: "commands.attribute.modifier.add.success",
    // rust: vec![
    // rust: Text::literal(modifier_id),
    // rust: description.clone(),
    // rust: name.clone(),
    // rust: ],
    // rust: 1,
    // rust: )
}
    // rust: "attribute.modifier.remove" => {
    // rust: if !map.has_modifier(key, modifier_id) {
    // rust: return Err(no_modifier());
}
    // rust: map.edit(key, |a, o| {
    // rust: let _ = a.remove(modifier_id, o);
    // rust: });
    // rust: (
    // rust: "commands.attribute.modifier.remove.success",
    // rust: vec![
    // rust: Text::literal(modifier_id),
    // rust: description.clone(),
    // rust: name.clone(),
    // rust: ],
    // rust: 1,
    // rust: )
}
    // rust: _ => {
    // rust: let v = map
    // rust: .modifier_value(key, modifier_id)
    // rust: .map_err(|_| no_modifier())?;
    // rust: (
    // rust: "commands.attribute.modifier.value.get.success",
    // rust: vec![
    // rust: Text::literal(modifier_id),
    // rust: description.clone(),
    // rust: name.clone(),
    // rust: java_double_text(v),
    // rust: ],
    // rust: (v * scale) as i32,
    // rust: )
}
}
    // rust: self.feedback(Text::translate(message, &args));
    // rust: Ok(result)
}

    // ---- /ride ----------------------------------------------------------------------------

    // rust: pub(super) fn cmd_ride(&mut self, id: &str, ctx: &Context) -> R<i32> {
    // rust: let targets = self.entities(ctx, "target", false)?;
    // rust: let Some(target) = targets.first().copied() else {
    // rust: return Ok(0);
}
    // rust: let name = self.target_name(target);
    // rust: if id == "ride.dismount" {
    // rust: let Some(v) = self.ride_vehicle(target) else {
    // rust: return Err(err("commands.ride.not_riding", &[&name.plain()]));
}
    // rust: let vehicle_name = self.target_name(v);
    // rust: match target {
    // rust: Target::Player => self.stop_riding(),
    // rust: Target::Mob(rider) => self.dismount_mob(rider),
    // rust: _ => {}
}
    // rust: self.feedback(Text::translate(
    // rust: "commands.ride.dismount.success",
    // rust: &[name, vehicle_name],
    // rust: ));
    // rust: return Ok(1);
}
    // rust: let vehicles = self.entities(ctx, "vehicle", false)?;
    // rust: let Some(vehicle) = vehicles.first().copied() else {
    // rust: return Ok(0);
}
    // rust: let vehicle_name = self.target_name(vehicle);
    // rust: if let Some(current) = self.ride_vehicle(target) {
    // rust: let current = self.target_name(current);
    // rust: return Err(err(
    // rust: "commands.ride.already_riding",
    // rust: &[&name.plain(), &current.plain()],
    // rust: ));
}
    // rust: if vehicle == Target::Player {
    // rust: return Err(err("commands.ride.mount.failure.cant_ride_players", &[]));
}
        // getSelfAndPassengers: the vehicle is the target or rides it.
    // rust: let mut up = Some(vehicle);
    // rust: while let Some(v) = up {
    // rust: if v == target {
    // rust: return Err(err("commands.ride.mount.failure.loop", &[]));
}
    // rust: up = self.ride_vehicle(v);
}
    // rust: let rider = match target {
    // rust: Target::Mob(id) => Some(id),
    // rust: _ => None,
}
    // rust: let generic = || {
    // rust: err(
    // rust: "commands.ride.mount.failure.generic",
    // rust: &[&name.plain(), &vehicle_name.plain()],
    // rust: )
}
        // Only players and mobs ride.
    // rust: if !(target == Target::Player || rider.is_some()) {
    // rust: return Err(generic());
}
        // `RideCommand.mount` forces the ride (`startRiding(vehicle, true, true)`),
        // which skips `canRide` and `canAddPassenger`: a boat under water still
        // takes the rider. Horizon's boats seat at most `max_passengers`, so a
        // full boat still refuses. Minecarts carry only players here: Horizon's
        // carts have no mob passengers yet.
    // rust: match vehicle {
    // rust: Target::Boat(id) => {
    // rust: let Some(i) = self.boats.iter().position(|b| b.id == id) else {
    // rust: return Err(generic());
}
    // rust: if self.boat_passengers(id) >= self.boats[i].max_passengers() {
    // rust: return Err(generic());
}
    // rust: if let Some(rider) = rider {
    // rust: if !self.try_mount_mob(rider, id) {
    // rust: return Err(generic());
}
    // rust: } else {
    // rust: if !self.native_may_board(id) {
    // rust: return Err(generic());
}
    // rust: self.yaw = self.boats[i].yaw;
                    // ServerPlayer.startRiding seats the player immediately.
    // rust: let at = self.player_boat_seat(i);
    // rust: if let Some(player) = self.player.as_mut() {
    // rust: player.position = at;
    // rust: player.velocity = horizon_core::geometry::Vec3::ZERO;
    // rust: player.teleported = true;
}
    // rust: self.previous_position = at;
                    // sendEventAndTriggers: START_RIDING_TRIGGER.
    // rust: self.start_riding(id);
}
    // rust: self.feedback(Text::translate(
    // rust: "commands.ride.mount.success",
    // rust: &[name, vehicle_name],
    // rust: ));
    // rust: return Ok(1);
}
    // rust: Target::Cart(id) => {
    // rust: if target != Target::Player
    // rust: || self.ridden_by_guest(id)
    // rust: || !self.native_may_board(id)
    // rust: {
    // rust: return Err(generic());
}
    // rust: self.start_riding(id);
    // rust: self.feedback(Text::translate(
    // rust: "commands.ride.mount.success",
    // rust: &[name, vehicle_name],
    // rust: ));
    // rust: return Ok(1);
}
    // rust: _ => {}
}
        // Mobs carry players and mobs.
    // rust: let Target::Mob(mob_id) = vehicle else {
    // rust: return Err(generic());
}
    // rust: if !self.mobs.iter().any(|m| m.id == mob_id && m.alive()) {
    // rust: return Err(generic());
}
    // rust: if let Some(rider) = rider {
            // Entity.startRiding.
    // rust: if !self.try_mount_mob(rider, mob_id) {
    // rust: return Err(generic());
}
    // rust: self.feedback(Text::translate(
    // rust: "commands.ride.mount.success",
    // rust: &[name, vehicle_name],
    // rust: ));
    // rust: return Ok(1);
}
    // rust: if !self.native_may_board(mob_id) {
    // rust: return Err(generic());
}
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == mob_id) {
    // rust: m.extra.flag = false;
    // rust: m.extra.counter = 0;
    // rust: self.yaw = m.yaw;
}
    // rust: self.mount.jump_ticks = 0;
    // rust: self.mount.jump_scale = 0.0;
    // rust: self.start_riding(mob_id);
    // rust: self.feedback(Text::translate(
    // rust: "commands.ride.mount.success",
    // rust: &[name, vehicle_name],
    // rust: ));
    // rust: Ok(1)
}

    // Entity.getVehicle: the player's mount, or a mob's.
    // rust: pub(super) fn ride_vehicle(&self, t: Target) -> Option<Target> {
    // rust: let id = match t {
    // rust: Target::Player => self.riding?,
    // rust: Target::Mob(id) => self.mobs.iter().find(|m| m.id == id)?.extra.mount?,
    // rust: _ => return None,
}
    // rust: Some(if self.boats.iter().any(|b| b.id == id) {
    // rust: Target::Boat(id)
    // rust: } else if self.carts.iter().any(|c| c.id == id) {
    // rust: Target::Cart(id)
    // rust: } else {
    // rust: Target::Mob(id)
    // rust: })
}
    // LivingEntity.stopRiding for a mob: off its vehicle
    // (Entity.removePassenger), then to where the vehicle lets it out
    // (LivingEntity.dismountVehicle).
    // rust: pub(in crate::game) fn dismount_mob(&mut self, rider: u32) {
    // rust: let Some(i) = self.mobs.iter().position(|m| m.id == rider) else {
    // rust: return;
}
    // rust: let Some(v) = self.mobs[i].extra.mount else {
    // rust: return;
}
    // rust: if !self.native_mob_may_ride(rider, v, false) {
    // rust: return;
}
    // rust: self.mobs[i].extra.mount = None;
    // rust: let remaining = self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.extra.mount == Some(v))
    // rust: .map(|m| m.id);
    // rust: if let Some(vehicle) = self.mobs.iter_mut().find(|m| m.id == v) {
    // rust: vehicle.extra.rider = remaining;
}
    // rust: let (width, yaw) = (f64::from(self.mobs[i].width()), self.mobs[i].yaw);
    // rust: let at = if let Some(b) = self.boats.iter().position(|b| b.id == v) {
    // rust: self.boat_dismount_target(b, width, yaw)
    // rust: } else if let Some(at) = self.horse_dismount_point(v, i) {
    // rust: at
    // rust: } else if let Some(at) = self.cart_dismount_point(v, i) {
    // rust: at
    // rust: } else if let Some(m) = self.mobs.iter_mut().find(|m| m.id == v) {
            // Entity.getDismountLocationForPassenger: on top of the vehicle.
    // rust: let p = m.position;
    // rust: horizon_core::geometry::Vec3::new(p.x, p.y + f64::from(m.height()), p.z)
    // rust: } else {
    // rust: self.mobs[i].position
}
    // rust: let m = &mut self.mobs[i];
    // rust: m.extra.passenger = false;
    // rust: m.extra.boarding_cooldown = super::super::boat_passengers::BOARDING_COOLDOWN;
    // rust: m.position = at;
    // rust: m.previous = at;
}

    // ---- /spreadplayers -----------------------------------------------------------------------

    // rust: pub(super) fn cmd_spreadplayers(&mut self, ctx: &Context) -> R<i32> {
    // rust: let centre = self
    // rust: .position_arg(ctx, "center")
    // rust: .unwrap_or_else(|| self.source_position());
    // rust: let float = |name: &str| match ctx.get(name) {
    // rust: Some(Arg::Float(v)) => f64::from(*v),
    // rust: _ => 0.0,
}
    // rust: let (spread, range) = (float("spreadDistance"), float("maxRange"));
    // rust: let respect = matches!(ctx.get("respectTeams"), Some(Arg::Bool(true)));
    // rust: let max_y = match ctx.get("maxHeight") {
    // rust: Some(Arg::Int(h)) => *h,
    // rust: _ => self.world.top_y(),
}
    // rust: if max_y < self.world.bottom_y() {
    // rust: return Err(err(
    // rust: "commands.spreadplayers.failed.invalid.height",
    // rust: &[&max_y, &self.world.bottom_y()],
    // rust: ));
}
    // rust: let targets = self.entities(ctx, "targets", false)?;
    // rust: if targets.is_empty() {
    // rust: return Err(err("argument.entity.notfound.entity", &[]));
}
        // SpreadPlayersCommand: one position per entity, or per team (every
        // non-player and team-less player sharing one) with respectTeams.
    // rust: let team_of = |g: &mut Self, t: Target| -> Option<String> {
    // rust: if t != Target::Player {
    // rust: return None;
}
    // rust: g.holder_name(t)
    // rust: .and_then(|h| g.score.board.players_team(&h).map(|x| x.name.clone()))
}
    // rust: let count = if respect {
    // rust: let mut seen: Vec<Option<String>> = Vec::new();
    // rust: for &t in &targets {
    // rust: let team = team_of(self, t);
    // rust: if !seen.contains(&team) {
    // rust: seen.push(team);
}
}
    // rust: seen.len()
    // rust: } else {
    // rust: targets.len()
}
    // rust: let centre_f = [centre[0] as f32, centre[2] as f32];
    // rust: let (cx, cz) = (f64::from(centre_f[0]), f64::from(centre_f[1]));
    // rust: let (min_x, max_x) = (cx - range, cx + range);
    // rust: let (min_z, max_z) = (cz - range, cz + range);
        // Mth.nextDouble.
    // rust: let next = |g: &mut Self, lo: f64, hi: f64| {
    // rust: if lo >= hi {
    // rust: lo
    // rust: } else {
    // rust: g.world.random.next_double() * (hi - lo) + lo
}
}
    // rust: let mut points: Vec<[f64; 2]> = Vec::with_capacity(count);
    // rust: for _ in 0..count {
    // rust: let x = next(self, min_x, max_x);
    // rust: let z = next(self, min_z, max_z);
    // rust: points.push([x, z]);
}
    // rust: let mut collisions = true;
    // rust: let mut min_distance = f64::from(f32::MAX);
    // rust: let mut iteration = 0;
    // rust: while iteration < 10_000 && collisions {
    // rust: collisions = false;
    // rust: min_distance = f64::from(f32::MAX);
    // rust: for i in 0..points.len() {
    // rust: let mut neighbours = 0;
    // rust: let mut avg = [0.0f64, 0.0f64];
    // rust: for j in 0..points.len() {
    // rust: if i == j {
    // rust: continue;
}
    // rust: let (dx, dz) = (points[i][0] - points[j][0], points[i][1] - points[j][1]);
    // rust: let dist = (dx * dx + dz * dz).sqrt();
    // rust: min_distance = min_distance.min(dist);
    // rust: if dist < spread {
    // rust: neighbours += 1;
    // rust: avg[0] += points[j][0] - points[i][0];
    // rust: avg[1] += points[j][1] - points[i][1];
}
}
    // rust: if neighbours > 0 {
    // rust: avg[0] /= f64::from(neighbours);
    // rust: avg[1] /= f64::from(neighbours);
    // rust: let length = (avg[0] * avg[0] + avg[1] * avg[1]).sqrt();
    // rust: if length > 0.0 {
    // rust: points[i][0] -= avg[0] / length;
    // rust: points[i][1] -= avg[1] / length;
    // rust: } else {
    // rust: points[i][0] = next(self, min_x, max_x);
    // rust: points[i][1] = next(self, min_z, max_z);
}
    // rust: collisions = true;
}
    // rust: let p = &mut points[i];
    // rust: let before = *p;
    // rust: p[0] = if p[0] < min_x {
    // rust: min_x
    // rust: } else if p[0] > max_x {
    // rust: max_x
    // rust: } else {
    // rust: p[0]
}
    // rust: p[1] = if p[1] < min_z {
    // rust: min_z
    // rust: } else if p[1] > max_z {
    // rust: max_z
    // rust: } else {
    // rust: p[1]
}
    // rust: if before != *p {
    // rust: collisions = true;
}
}
    // rust: if !collisions {
    // rust: for i in 0..points.len() {
    // rust: if !self.spread_safe(points[i], max_y) {
    // rust: points[i][0] = next(self, min_x, max_x);
    // rust: points[i][1] = next(self, min_z, max_z);
    // rust: collisions = true;
}
}
}
    // rust: iteration += 1;
}
    // rust: if min_distance == f64::from(f32::MAX) {
    // rust: min_distance = 0.0;
}
    // rust: let float = |v: f32| Text::literal(horizon_client::snbt::java_float(v));
    // rust: if iteration >= 10_000 {
    // rust: let key = if respect {
    // rust: "commands.spreadplayers.failed.teams"
    // rust: } else {
    // rust: "commands.spreadplayers.failed.entities"
}
    // rust: return Err(text_error(
    // rust: key,
    // rust: &[
    // rust: num(points.len()),
    // rust: float(centre_f[0]),
    // rust: float(centre_f[1]),
    // rust: Text::literal(super::percent_f(min_distance, 2)),
    // rust: ],
    // rust: ));
}
        // setPlayerPositions.
    // rust: let mut total = 0.0;
    // rust: let mut index = 0;
    // rust: let mut team_points: Vec<(Option<String>, usize)> = Vec::new();
    // rust: for &t in &targets {
    // rust: let i = if respect {
    // rust: let team = team_of(self, t);
    // rust: match team_points.iter().find(|(k, _)| *k == team) {
    // rust: Some((_, i)) => *i,
    // rust: None => {
    // rust: team_points.push((team, index));
    // rust: index += 1;
    // rust: index - 1
}
}
    // rust: } else {
    // rust: index += 1;
    // rust: index - 1
}
    // rust: let p = points[i];
    // rust: let y = self.spread_spawn_y(p, max_y);
    // rust: self.teleport_to(
    // rust: t,
    // rust: [p[0].floor() + 0.5, f64::from(y), p[1].floor() + 0.5],
    // rust: None,
    // rust: false,
    // rust: );
    // rust: let closest = points
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(j, _)| *j != i)
    // rust: .map(|(_, q)| ((p[0] - q[0]).powi(2) + (p[1] - q[1]).powi(2)).sqrt())
    // rust: .fold(f64::MAX, f64::min);
    // rust: total += closest;
}
    // rust: let average = if targets.len() < 2 {
    // rust: 0.0
    // rust: } else {
    // rust: total / targets.len() as f64
}
    // rust: let key = if respect {
    // rust: "commands.spreadplayers.success.teams"
    // rust: } else {
    // rust: "commands.spreadplayers.success.entities"
}
    // rust: self.feedback(Text::translate(
    // rust: key,
    // rust: &[
    // rust: num(points.len()),
    // rust: float(centre_f[0]),
    // rust: float(centre_f[1]),
    // rust: Text::literal(super::percent_f(average, 2)),
    // rust: ],
    // rust: ));
    // rust: Ok(points.len() as i32)
}
    // `SpreadPlayersCommand.Position.getSpawnY`.
spread_spawn_y :: proc(self: ^Self, p: [f64; 2], max_y: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let (x, z) = (p[0].floor() as i32, p[1].floor() as i32);
    // rust: let air = |y: i32| {
    // rust: let name: &str = &self.res.facts().get(self.world.block(x, y, z)).name;
    // rust: matches!(
    // rust: name,
    // rust: "minecraft:air" | "minecraft:cave_air" | "minecraft:void_air"
    // rust: )
}
    // rust: let mut y = max_y + 1;
    // rust: let mut air2 = air(y);
    // rust: y -= 1;
    // rust: let mut air1 = air(y);
    // rust: while y > self.world.bottom_y() {
    // rust: y -= 1;
    // rust: let current = air(y);
    // rust: if !current && air1 && air2 {
    // rust: return y + 1;
}
    // rust: air2 = air1;
    // rust: air1 = current;
}
    // rust: max_y + 1
}
    // `SpreadPlayersCommand.Position.isSafe`.
spread_safe :: proc(self: ^Self, p: [f64; 2], max_y: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let y = self.spread_spawn_y(p, max_y) - 1;
    // rust: let (x, z) = (p[0].floor() as i32, p[1].floor() as i32);
    // rust: let name = self.res.facts().get(self.world.block(x, y, z)).name.clone();
    // rust: let liquid = matches!(&*name, "minecraft:water" | "minecraft:lava");
    // rust: let teleportable = self
    // rust: .res
    // rust: .items()
    // rust: .block_tags
    // rust: .get("entities_can_teleport_to")
    // rust: .or_else(|| {
    // rust: self.res
    // rust: .items()
    // rust: .block_tags
    // rust: .get("minecraft:entities_can_teleport_to")
    // rust: })
    // rust: .is_some_and(|set| {
    // rust: set.contains(&*name) || set.contains(name.trim_start_matches("minecraft:"))
    // rust: });
    // rust: y < max_y && !liquid && teleportable
}
}

// A `CommandError` whose message is a translation with component arguments.
text_error :: proc(key: string, args: ^[Text]) -> h {
    // Ported from Horizon
    return {}
}
    // rust: horizon_client::command::CommandError::new(Text::translate(key, args))
}

// `PlaySoundCommand.playSound`: the point and the volume one target hears the
// sound at. A target past `range` hears nothing unless `minVolume` is above
// zero, and then the point moves two blocks from the target towards the sound
// and the volume is `minVolume`; a target exactly at `range` still hears it
// (the command's test is `>`, unlike `PlayerList.broadcast`'s `<`).
    // rust: fn playsound_placement(
    // rust: pos: [f64; 3],
    // rust: target: [f64; 3],
    // rust: range: f32,
    // rust: volume: f32,
    // rust: min_volume: f32,
    // rust: ) -> Option<([f64; 3], f32)> {
    // rust: let d = [pos[0] - target[0], pos[1] - target[1], pos[2] - target[2]];
    // rust: let dist2 = d[0] * d[0] + d[1] * d[1] + d[2] * d[2];
    // PlaySoundCommand compares against Mth.square(float range): the square
    // rounds in float and only then widens, so a point between that square and
    // the double square is out of range in vanilla.
    // rust: if dist2 <= f64::from(range * range) {
    // rust: return Some((pos, volume));
}
    // rust: if min_volume <= 0.0 {
    // rust: return None;
}
    // rust: let dist = dist2.sqrt();
    // rust: Some((
    // rust: [
    // rust: target[0] + d[0] / dist * 2.0,
    // rust: target[1] + d[1] / dist * 2.0,
    // rust: target[2] + d[2] / dist * 2.0,
    // rust: ],
    // rust: min_volume,
    // rust: ))
}

// `Entity.lookAt`: yaw and pitch from `from` towards `to`, the yaw wrapped
// to -180..180 as `Mth.wrapDegrees` does.
    // rust: pub(super) fn look_at(from: [f64; 3], to: [f64; 3]) -> [f32; 2] {
    // rust: let (dx, dy, dz) = (to[0] - from[0], to[1] - from[1], to[2] - from[2]);
    // rust: let horizontal = (dx * dx + dz * dz).sqrt();
    // `Entity.lookAt` turns radians to degrees with the float constant
    // `57.2957763671875`, not `Math.toDegrees`.
    // rust: let pitch = wrap_degrees((-(dy.atan2(horizontal) * 57.295_776_367_187_5)) as f32);
    // rust: let yaw = (dz.atan2(dx) * 57.295_776_367_187_5) as f32 - 90.0;
    // rust: [wrap_degrees(yaw), pitch]
}

    // rust: mod allay_owner_damage_tests {
//     use crate::game::{Audio, Game, Options, Progress, Settings, load_resources};
//     use horizon_client::mobs::{Damage, Mob};
//     use horizon_core::geometry::Vec3;

allay_owner_adapters_compare_the_actual_player_uuid :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("entity-types.json").exists() {
    // rust: eprintln!("Prepared resources unavailable; Allay Game damage coverage did not run");
    // rust: return;
}
    // rust: let settings = Settings::default();
    // rust: let loaded = load_resources(
    // rust: root.clone(),
    // rust: None,
    // rust: &root,
    // rust: &settings,
    // rust: std::time::Instant::now(),
    // rust: false,
    // rust: true,
    // rust: &Progress::new(),
    // rust: &mut |_, _| unreachable!(),
    // rust: )
    // rust: .unwrap();
    // rust: let mut options = Options::parse(std::iter::empty()).unwrap().unwrap();
    // rust: options.resources = root.clone();
    // rust: options.execution_role = crate::game::execution_role::ExecutionRole::IntegratedServer;
    // rust: let mut game = Game::new(
    // rust: &loaded.resources,
    // rust: loaded.pack,
    // rust: loaded.gui.unwrap(),
    // rust: options,
    // rust: settings,
    // rust: Audio::silent(&root),
    // rust: None,
    // rust: )
    // rust: .unwrap();
    // rust: game.build_registries();
    // rust: let actual = [101, 102, 103, 104];
    // rust: let other = [10, 20, 30, 40];
    // rust: game.level.player_uuid = Some(actual);
    // rust: game.lan_acting_uuid = Some(horizon_client::lan::playerdata::ints_uuid(actual));
    // rust: assert_eq!(game.owner_damage_uuid(), Some(actual));
    // rust: game.lan_acting_uuid = Some(horizon_client::lan::playerdata::ints_uuid(other));
    // rust: assert_eq!(
    // rust: game.owner_damage_uuid(),
    // rust: None,
    // rust: "a guest is not the owner route"
    // rust: );
    // rust: game.lan_acting_uuid = None;
    // rust: game.level.player_uuid = None;
    // rust: assert_eq!(
    // rust: game.owner_damage_uuid(),
    // rust: None,
    // rust: "no invented UUID for an unknown source"
    // rust: );
    // rust: game.level.player_uuid = Some(actual);
    // rust: game.lan_acting_uuid = Some(horizon_client::lan::playerdata::ints_uuid(actual));
    // rust: let kind = game.res.mob_types().get("minecraft:allay").unwrap().clone();
    // rust: let before = game.world.game_time;
    // rust: for melee in [true, false] {
    // rust: for liked in [Some(actual), None, Some(other)] {
    // rust: game.mobs.clear();
    // rust: let mut mob = Mob::new(1, kind.clone(), Vec3::new(22.5, 101.0, 22.5), 0.0);
    // rust: mob.no_ai = true;
    // rust: mob.extra.tame = liked.is_some();
    // rust: mob.extra.owner = liked;
    // rust: assert_eq!((mob.health, mob.hurt_time), (20.0, 0));
    // rust: game.mobs.push(mob);
    // rust: let source = Damage::player([20.5, 102.0, 20.5]);
    // rust: let accepted = if melee {
    // rust: game.hurt_by_player(0, 2.0, source)
    // rust: } else {
    // rust: game.command_damage_mob(1, 2.0, source)
}
    // rust: let expected = liked != Some(actual);
    // rust: assert_eq!(accepted, expected, "melee={melee}, liked={liked:?}");
    // rust: assert_eq!(game.mobs[0].health, if expected { 18.0 } else { 20.0 });
    // rust: assert_eq!(game.mobs[0].extra.owner, liked);
    // rust: assert_eq!(game.world.game_time, before);
}
}
}
}

    // rust: mod tests {
//     use super::{look_at, playsound_placement, take_new_reinforcements};
//     use horizon_client::mobs::{MobEvent, Who};

command_reinforcements_leave_prior_requests_and_other_events_queued :: proc() {
}
    // rust: let request = |mob| MobEvent::Reinforcements {
    // rust: mob,
    // rust: target: Who::Player,
}
    // rust: let mut events = vec![request(1), MobEvent::Sound("before", [0.; 3], 1., 1.)];
    // rust: let queued = events.len();
    // rust: events.extend([
    // rust: request(2),
    // rust: MobEvent::Sound("after", [0.; 3], 1., 1.),
    // rust: request(3),
    // rust: ]);
    // rust: assert_eq!(
    // rust: take_new_reinforcements(&mut events, queued),
    // rust: [(2, Who::Player), (3, Who::Player)]
    // rust: );
    // rust: assert!(matches!(
    // rust: events.as_slice(),
    // rust: [
    // rust: MobEvent::Reinforcements { mob: 1, .. },
    // rust: MobEvent::Sound("before", ..),
    // rust: MobEvent::Sound("after", ..)
    // rust: ]
    // rust: ));
    // rust: assert!(take_new_reinforcements(&mut events, queued).is_empty());
    // rust: assert_eq!(events.len(), 3);
}

command_reinforcements_tolerate_a_damage_handler_clearing_its_outbox :: proc() {
}
    // rust: let mut events = vec![MobEvent::Sound("after", [0.; 3], 1., 1.)];
    // rust: assert!(take_new_reinforcements(&mut events, 4).is_empty());
    // rust: assert_eq!(events.len(), 1);
}

assert_angle :: proc(got: f32, want: f32) {
}
    // rust: assert!((got - want).abs() < 1.0e-4, "{got} is not {want}");
}

    // `Entity.lookAt` wraps the yaw with `Mth.wrapDegrees`, so a target to
    // the north-west turns the entity to 135 degrees, not to -225, and a
    // target due north leaves -180 rather than 180.
a_facing_target_wraps_the_yaw_to_180 :: proc() {
}
    // rust: let at = [0.0, 64.0, 0.0];
    // rust: assert_angle(look_at(at, [-1.0, 64.0, -1.0])[0], 135.0);
    // rust: assert_angle(look_at(at, [0.0, 64.0, -1.0])[0], -180.0);
    // rust: assert_angle(look_at(at, [1.0, 64.0, 0.0])[0], -90.0);
    // rust: assert_angle(look_at(at, [0.0, 64.0, 1.0])[0], 0.0);
    // rust: assert_angle(look_at(at, [-1.0, 64.0, 0.0])[0], 90.0);
        // The pitch is the elevation, unchanged; its own wrap is a no-op.
    // rust: assert_angle(look_at(at, [0.0, 65.0, 1.0])[1], -45.0);
}

    // `PlaySoundCommand.playSound`: inside the range the point and volume are
    // the command's own, exactly on it still is, past it there is nothing
    // without a minimum volume, and with one the point is two blocks from the
    // target towards the sound and the volume is that minimum.
a_target_past_the_range_hears_it_two_blocks_away :: proc() {
}
    // rust: let pos = [0.0, 64.0, 0.0];
    // rust: let near = [0.0, 64.0, 15.0];
    // rust: assert_eq!(
    // rust: playsound_placement(pos, near, 16.0, 3.0, 0.0),
    // rust: Some((pos, 3.0))
    // rust: );
    // rust: let on_the_edge = [16.0, 64.0, 0.0];
    // rust: assert_eq!(
    // rust: playsound_placement(pos, on_the_edge, 16.0, 3.0, 0.0),
    // rust: Some((pos, 3.0))
    // rust: );
    // rust: let far = [0.0, 64.0, 32.0];
    // rust: assert_eq!(playsound_placement(pos, far, 16.0, 3.0, 0.0), None);
    // rust: assert_eq!(
    // rust: playsound_placement(pos, far, 16.0, 3.0, 0.5),
    // rust: Some(([0.0, 64.0, 30.0], 0.5))
    // rust: );
}

    // The range is squared as a float, as `Mth.square(getRange(volume))` is:
    // a point between that square and the double one is past the range in
    // vanilla, so it gets the `minVolume` placement rather than full volume.
the_range_square_rounds_as_a_float :: proc() {
}
    // rust: let volume = 1.1f32;
    // rust: let range = 16.0 * volume;
    // rust: let float_square = f64::from(range * range);
    // rust: let double_square = f64::from(range) * f64::from(range);
    // rust: assert!(float_square < double_square);
    // rust: let dist2 = (float_square + double_square) / 2.0;
    // rust: let pos = [0.0, 64.0, 0.0];
    // rust: let target = [dist2.sqrt(), 64.0, 0.0];
    // rust: assert_eq!(
    // rust: playsound_placement(pos, target, range, volume, 0.0),
    // rust: None,
    // rust: "past the float range"
    // rust: );
    // rust: let moved = playsound_placement(pos, target, range, volume, 0.7);
    // rust: let Some((point, heard)) = moved else {
    // rust: panic!("minVolume should place it");
}
    // rust: assert_eq!(heard, 0.7);
    // rust: assert!((point[0] - (target[0] - 2.0)).abs() < 1e-9, "{point:?}");
    // rust: assert_eq!(point[1..], [64.0, 0.0]);
}
}
