//! Transpiled from Horizon Rust crate
//! Module: horizon-client_raid
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `RaidCommand`: `/raid start|stop|check|spawnleader|setomen|glow|sound`.
// use super::{Game, R, Text, err};
// use horizon_client::{command::Context, mobs::raider};

    // rust: impl Game<'_> {
    // rust: pub(in crate::game) fn cmd_raid(&mut self, id: &str, ctx: &Context) -> R<i32> {
    // rust: let Some(player) = self.player.as_ref().map(|p| p.position) else {
    // rust: return Ok(0);
}
    // rust: let at = [
    // rust: player.x.floor() as i32,
    // rust: player.y.floor() as i32,
    // rust: player.z.floor() as i32,
    // rust: ];
    // rust: let fail = |game: &mut Self, message: &str| {
    // rust: game.command_failure(Text::literal(message));
}
    // rust: match id {
    // rust: "raid.start" => {
    // rust: if self.raiding_nearby(at).is_some() {
    // rust: fail(self, "Raid already started close by");
    // rust: return Ok(-1);
}
    // rust: let level = Self::int(ctx, "omenlvl").unwrap_or(0);
    // rust: match self.raid_command_create(at, level) {
    // rust: true => self.feedback(Text::literal("Created a raid in your local village")),
    // rust: false => fail(self, "Failed to create a raid in your local village"),
}
    // rust: Ok(1)
}
    // rust: "raid.stop" => match self.raiding_nearby(at) {
    // rust: Some(raid) => {
    // rust: self.raid_command_stop(raid);
    // rust: self.feedback(Text::literal("Stopped raid"));
    // rust: Ok(1)
}
    // rust: None => {
    // rust: fail(self, "No raid here");
    // rust: Ok(-1)
}
    // rust: },
    // rust: "raid.check" => match self.raiding_nearby(at).filter(|id| self.raid_started(*id)) {
    // rust: Some(raid) => {
    // rust: self.feedback(Text::literal("Found a started raid!"));
    // rust: let status = self.raid_status_text(raid);
    // rust: self.feedback(Text::literal(&status));
    // rust: Ok(1)
}
    // rust: None => {
    // rust: fail(self, "Found no started raids");
    // rust: Ok(0)
}
    // rust: },
    // rust: "raid.spawnleader" => {
    // rust: let kind = "minecraft:pillager";
    // rust: match self.spawn_mob_for(kind, [player.x, player.y, player.z], true, true) {
    // rust: Some(id) => {
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == id) {
    // rust: raider::set_patrol_leader(m, true);
    // rust: raider::finalize(m, raider::Reason::Other);
}
    // rust: self.feedback(Text::literal("Spawned a raid captain"));
    // rust: Ok(1)
}
    // rust: None => {
    // rust: fail(self, "Pillager failed to spawn");
    // rust: Ok(0)
}
}
}
    // rust: "raid.setomen" => {
    // rust: let level = Self::int(ctx, "level").unwrap_or(0);
    // rust: let Some(raid) = self.raiding_nearby(at) else {
    // rust: fail(self, "No raid found here");
    // rust: return Ok(1);
}
    // rust: if level > horizon_client::raid::MAX_OMEN_LEVEL {
    // rust: fail(
    // rust: self,
    // rust: &format!(
    // rust: "Sorry, the max raid omen level you can set is {}",
    // rust: horizon_client::raid::MAX_OMEN_LEVEL
    // rust: ),
    // rust: );
    // rust: } else {
    // rust: let before = self.raid_set_omen(raid, level);
    // rust: self.feedback(Text::literal(format!(
    // rust: "Changed village's raid omen level from {before} to {level}"
    // rust: )));
}
    // rust: Ok(1)
}
    // rust: "raid.glow" => {
    // rust: if let Some(raid) = self.raiding_nearby(at) {
    // rust: self.raid_glow(raid);
}
    // rust: Ok(1)
}
    // rust: "raid.sound" => {
    // rust: let at = [player.x + 5.0, player.y, player.z];
    // rust: self.audio
    // rust: .play("minecraft:event.raid.horn", Some(at), 1.0, 1.0);
    // rust: Ok(1)
}
    // rust: _ => Err(err("commands.help.failed", &[])),
}
}
}
