//! Transpiled from Horizon Rust crate
//! Module: horizon-client_scoreboard_cmd_tests
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

// use super::*;
// use crate::command::{Registries, vanilla};

pub const Mock = struct {
    sb: Scoreboard,
    out: std.ArrayList([]const u8),
};
    // rust: impl Env for Mock {
pub fn sb(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.sb
}
pub fn sb_mut(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &mut self.sb
}
pub fn select(self: *Self, s: *Selector) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if s.kind == 'e' {
    // rust: vec![self.named("Steve"), self.named("Alex")]
    // rust: } else {
    // rust: vec![self.named("Steve")]
}
}
pub fn named(self: *Self, name: []const u8) H {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Holder {
    // rust: name: name.to_owned(),
    // rust: text: Text::literal(name),
    // rust: display: Some(literal(name)),
}
}
pub fn source(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some((Holder::named("Steve"), true))
}
pub fn feedback(self: *Self, message: Text) void {
}
    // rust: self.out.push(message.plain());
}
}
pub fn mock() M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Mock {
    // rust: sb: Scoreboard::default(),
    // rust: out: Vec::new(),
}
}
pub fn run(env: *mut Mock, line: []const u8) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let reg = Registries {
    // rust: permission: 4,
    // rust: ..Registries::default()
}
    // rust: let parse = vanilla::dispatcher().parse(line, &reg);
    // rust: let (ctx, id) = parse.executable()?;
    // rust: let ctx = ctx.clone();
    // rust: execute(id, &ctx, env).expect("a scoreboard command")
}
pub fn fail(env: *mut Mock, line: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: run(env, line).expect_err(line).message.plain()
}

pub fn objectives() void {
}
    // rust: let mut m = mock();
    // rust: assert_eq!(
    // rust: run(&mut m, "scoreboard objectives add kills playerKillCount").unwrap(),
    // rust: 1
    // rust: );
    // rust: assert_eq!(
    // rust: fail(&mut m, "scoreboard objectives add kills dummy"),
    // rust: "commands.scoreboard.objectives.add.duplicate"
    // rust: );
    // rust: run(
    // rust: &mut m,
    // rust: "scoreboard objectives add hp health {\"text\":\"HP\",\"color\":\"red\"}",
    // rust: )
    // rust: .unwrap();
    // rust: let hp = m.sb.objective("hp").unwrap();
    // rust: assert_eq!(hp.render_type, RenderType::Hearts);
    // rust: assert_eq!(hp.display_name["color"], "red");
    // rust: assert_eq!(run(&mut m, "scoreboard objectives list").unwrap(), 2);
    // rust: run(&mut m, "scoreboard objectives setdisplay sidebar kills").unwrap();
    // rust: assert_eq!(
    // rust: fail(&mut m, "scoreboard objectives setdisplay sidebar kills"),
    // rust: "commands.scoreboard.objectives.display.alreadySet"
    // rust: );
    // rust: run(&mut m, "scoreboard objectives setdisplay sidebar").unwrap();
    // rust: assert_eq!(
    // rust: fail(&mut m, "scoreboard objectives setdisplay sidebar"),
    // rust: "commands.scoreboard.objectives.display.alreadyEmpty"
    // rust: );
    // rust: run(
    // rust: &mut m,
    // rust: "scoreboard objectives modify kills rendertype hearts",
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: m.sb.objective("kills").unwrap().render_type,
    // rust: RenderType::Hearts
    // rust: );
    // rust: run(
    // rust: &mut m,
    // rust: "scoreboard objectives modify kills displayautoupdate true",
    // rust: )
    // rust: .unwrap();
    // rust: run(
    // rust: &mut m,
    // rust: "scoreboard objectives modify kills numberformat fixed \"x\"",
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: m.sb.objective("kills").unwrap().number_format,
    // rust: Some(NumberFormat::Fixed(literal("x")))
    // rust: );
    // rust: run(&mut m, "scoreboard objectives modify kills numberformat").unwrap();
    // rust: assert!(m.sb.objective("kills").unwrap().number_format.is_none());
    // rust: run(&mut m, "scoreboard objectives remove kills").unwrap();
    // rust: assert_eq!(
    // rust: fail(&mut m, "scoreboard objectives remove kills"),
    // rust: "arguments.objective.notFound"
    // rust: );
}

pub fn players() void {
}
    // rust: let mut m = mock();
    // rust: run(&mut m, "scoreboard objectives add pts dummy").unwrap();
    // rust: run(&mut m, "scoreboard objectives add hp health").unwrap();
    // rust: assert_eq!(
    // rust: run(&mut m, "scoreboard players set Steve pts 5").unwrap(),
    // rust: 5
    // rust: );
    // rust: assert_eq!(
    // rust: run(&mut m, "scoreboard players add Steve pts 3").unwrap(),
    // rust: 8
    // rust: );
    // rust: assert_eq!(
    // rust: run(&mut m, "scoreboard players remove Steve pts 10").unwrap(),
    // rust: -2
    // rust: );
    // rust: assert_eq!(run(&mut m, "scoreboard players get Steve pts").unwrap(), -2);
    // rust: assert_eq!(
    // rust: fail(&mut m, "scoreboard players get Alex pts"),
    // rust: "commands.scoreboard.players.get.null"
    // rust: );
    // rust: assert_eq!(
    // rust: fail(&mut m, "scoreboard players set Steve hp 5"),
    // rust: "arguments.objective.readonly"
    // rust: );
    // rust: assert_eq!(run(&mut m, "scoreboard players set @e pts 4").unwrap(), 8);
    // rust: assert_eq!(m.sb.score("Alex", "pts").unwrap().value, 4);
    // Entity holders get their display name stored when auto-update is on.
    // rust: run(
    // rust: &mut m,
    // rust: "scoreboard objectives modify pts displayautoupdate true",
    // rust: )
    // rust: .unwrap();
    // rust: run(&mut m, "scoreboard players set @s pts 1").unwrap();
    // rust: assert_eq!(
    // rust: m.sb.score("Steve", "pts").unwrap().display,
    // rust: Some(literal("Steve"))
    // rust: );
    // rust: assert_eq!(run(&mut m, "scoreboard players list").unwrap(), 2);
    // rust: assert_eq!(run(&mut m, "scoreboard players list Steve").unwrap(), 1);
    // operation
    // rust: run(&mut m, "scoreboard players set Steve pts 17").unwrap();
    // rust: run(&mut m, "scoreboard players set Alex pts 5").unwrap();
    // rust: run(&mut m, "scoreboard players operation Steve pts %= Alex pts").unwrap();
    // rust: assert_eq!(m.sb.score("Steve", "pts").unwrap().value, 2);
    // rust: run(&mut m, "scoreboard players operation Steve pts >< Alex pts").unwrap();
    // rust: assert_eq!(m.sb.score("Steve", "pts").unwrap().value, 5);
    // rust: assert_eq!(m.sb.score("Alex", "pts").unwrap().value, 2);
    // rust: run(&mut m, "scoreboard players set Alex pts 0").unwrap();
    // rust: assert_eq!(
    // rust: fail(&mut m, "scoreboard players operation Steve pts /= Alex pts"),
    // rust: "arguments.operation.div0"
    // rust: );
    // wildcard
    // rust: assert_eq!(run(&mut m, "scoreboard players reset * pts").unwrap(), 2);
    // rust: assert!(m.sb.tracked().is_empty());
    // rust: assert_eq!(
    // rust: fail(&mut m, "scoreboard players reset * pts"),
    // rust: "argument.scoreHolder.empty"
    // rust: );
}

pub fn operations_use_floor_semantics() void {
}
    // rust: assert_eq!(apply_operation("/=", -7, 2).unwrap().0, -4);
    // rust: assert_eq!(apply_operation("/=", 7, -2).unwrap().0, -4);
    // rust: assert_eq!(apply_operation("/=", 7, 2).unwrap().0, 3);
    // rust: assert_eq!(apply_operation("%=", -7, 3).unwrap().0, 2);
    // rust: assert_eq!(apply_operation("<", 3, 9).unwrap().0, 3);
    // rust: assert_eq!(apply_operation(">", 3, 9).unwrap().0, 9);
    // rust: assert_eq!(apply_operation("*=", i32::MAX, 2).unwrap().0, -2);
}

pub fn division_wraps_minimum_integer_by_negative_one() void {
}
    // rust: let mut m = mock();
    // rust: run(&mut m, "scoreboard objectives add poc dummy").unwrap();
    // rust: run(&mut m, "scoreboard players set target poc -2147483648").unwrap();
    // rust: run(&mut m, "scoreboard players set divisor poc -1").unwrap();
    // rust: run(
    // rust: &mut m,
    // rust: "scoreboard players operation target poc /= divisor poc",
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: run(&mut m, "scoreboard players get target poc").unwrap(),
    // rust: i32::MIN
    // rust: );
    // rust: assert_eq!(
    // rust: run(&mut m, "scoreboard players get divisor poc").unwrap(),
    // rust: -1
    // rust: );
}

pub fn remainder_handles_integer_boundaries() void {
}
    // rust: for (dividend, divisor, expected) in [
    // rust: (i32::MAX - 1, i32::MAX, i32::MAX - 1),
    // rust: (7, -3, -2),
    // rust: (-7, 3, 2),
    // rust: (i32::MIN, -1, 0),
    // rust: (-1, i32::MIN, -1),
    // rust: (1, i32::MIN, i32::MIN + 1),
    // rust: (0, i32::MAX, 0),
    // rust: ] {
    // rust: let mut m = mock();
    // rust: run(&mut m, "scoreboard objectives add boundary dummy").unwrap();
    // rust: run(
    // rust: &mut m,
    // rust: &format!("scoreboard players set left boundary {dividend}"),
    // rust: )
    // rust: .unwrap();
    // rust: run(
    // rust: &mut m,
    // rust: &format!("scoreboard players set right boundary {divisor}"),
    // rust: )
    // rust: .unwrap();
    // rust: run(
    // rust: &mut m,
    // rust: "scoreboard players operation left boundary %= right boundary",
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: run(&mut m, "scoreboard players get left boundary").unwrap(),
    // rust: expected,
    // rust: "{dividend} %= {divisor}"
    // rust: );
    // rust: assert_eq!(
    // rust: run(&mut m, "scoreboard players get right boundary").unwrap(),
    // rust: divisor
    // rust: );
}
    // rust: assert!(apply_operation("%=", 1, 0).is_err());
}

pub fn triggers() void {
}
    // rust: let mut m = mock();
    // rust: run(&mut m, "scoreboard objectives add t trigger").unwrap();
    // rust: run(&mut m, "scoreboard objectives add d dummy").unwrap();
    // rust: assert_eq!(
    // rust: fail(&mut m, "trigger t"),
    // rust: "commands.trigger.failed.unprimed"
    // rust: );
    // rust: assert_eq!(fail(&mut m, "trigger d"), "commands.trigger.failed.invalid");
    // rust: run(&mut m, "scoreboard players enable Steve t").unwrap();
    // rust: assert_eq!(
    // rust: fail(&mut m, "scoreboard players enable Steve t"),
    // rust: "commands.scoreboard.players.enable.failed"
    // rust: );
    // rust: assert_eq!(run(&mut m, "trigger t").unwrap(), 1);
    // Triggering locks the objective again.
    // rust: assert_eq!(
    // rust: fail(&mut m, "trigger t"),
    // rust: "commands.trigger.failed.unprimed"
    // rust: );
    // rust: run(&mut m, "scoreboard players enable Steve t").unwrap();
    // rust: assert_eq!(run(&mut m, "trigger t add 4").unwrap(), 5);
    // rust: run(&mut m, "scoreboard players enable Steve t").unwrap();
    // rust: assert_eq!(run(&mut m, "trigger t set 9").unwrap(), 9);
    // rust: assert_eq!(
    // rust: fail(&mut m, "scoreboard players enable Steve d"),
    // rust: "commands.scoreboard.players.enable.invalid"
    // rust: );
}

pub fn teams() void {
}
    // rust: let mut m = mock();
    // rust: assert_eq!(run(&mut m, "team add red").unwrap(), 1);
    // rust: assert_eq!(fail(&mut m, "team add red"), "commands.team.add.duplicate");
    // rust: assert_eq!(fail(&mut m, "team remove nope"), "team.notFound");
    // rust: run(&mut m, "team modify red color red").unwrap();
    // rust: assert_eq!(
    // rust: fail(&mut m, "team modify red color red"),
    // rust: "commands.team.option.color.unchanged"
    // rust: );
    // rust: assert_eq!(m.sb.team("red").unwrap().color.as_deref(), Some("red"));
    // rust: run(&mut m, "team modify red color reset").unwrap();
    // rust: assert!(m.sb.team("red").unwrap().color.is_none());
    // rust: run(&mut m, "team modify red friendlyFire false").unwrap();
    // rust: assert_eq!(
    // rust: fail(&mut m, "team modify red friendlyFire false"),
    // rust: "commands.team.option.friendlyfire.alreadyDisabled"
    // rust: );
    // rust: run(
    // rust: &mut m,
    // rust: "team modify red nametagVisibility hideForOtherTeams",
    // rust: )
    // rust: .unwrap();
    // rust: run(&mut m, "team modify red collisionRule pushOwnTeam").unwrap();
    // rust: run(&mut m, "team modify red prefix {\"text\":\"[R] \"}").unwrap();
    // rust: run(&mut m, "team modify red seeFriendlyInvisibles false").unwrap();
    // rust: let t = m.sb.team("red").unwrap();
    // rust: assert_eq!(t.nametag_visibility, Visibility::HideForOtherTeams);
    // rust: assert_eq!(t.collision_rule, sb::CollisionRule::PushOwnTeam);
    // rust: assert!(!t.see_friendly_invisibles);
    // join defaults to the executor
    // rust: assert_eq!(run(&mut m, "team join red").unwrap(), 1);
    // addPlayerToTeam leaves and rejoins: the player counts again.
    // rust: assert_eq!(run(&mut m, "team join red @e").unwrap(), 2);
    // rust: assert_eq!(m.sb.team("red").unwrap().players.len(), 2);
    // rust: assert_eq!(run(&mut m, "team list red").unwrap(), 2);
    // rust: assert_eq!(run(&mut m, "team leave Alex").unwrap(), 1);
    // rust: assert_eq!(run(&mut m, "team empty red").unwrap(), 1);
    // rust: assert_eq!(
    // rust: fail(&mut m, "team empty red"),
    // rust: "commands.team.empty.unchanged"
    // rust: );
    // rust: assert_eq!(run(&mut m, "team remove red").unwrap(), 0);
    // rust: assert_eq!(run(&mut m, "team list").unwrap(), 0);
}

pub fn selector_options_parse() void {
}
    // rust: let reg = Registries {
    // rust: permission: 4,
    // rust: ..Registries::default()
}
    // rust: let parse = vanilla::dispatcher().parse(
    // rust: "scoreboard players get @e[scores={kills=1..,deaths=..3},team=!red,nbt={a:1b},tag=x,limit=1] kills",
    // rust: &reg,
    // rust: );
    // rust: let (ctx, _) = parse.executable().unwrap();
    // rust: let Some(Arg::ScoreHolder(ScoreHolderArg::Selector(s))) = ctx.get("target") else {
    // rust: panic!("selector");
}
    // rust: assert_eq!(
    // rust: s.scores,
    // rust: vec![
    // rust: ("kills".to_owned(), (Some(1), None)),
    // rust: ("deaths".to_owned(), (None, Some(3)))
    // rust: ]
    // rust: );
    // rust: assert_eq!(s.teams, vec![("red".to_owned(), true)]);
    // rust: assert_eq!(s.nbt.len(), 1);
    // Single-target arguments refuse multi-entity selectors.
    // rust: let parse = vanilla::dispatcher().parse("scoreboard players get @e kills", &reg);
    // rust: assert!(parse.executable().is_err());
}
