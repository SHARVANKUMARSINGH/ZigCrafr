//! Transpiled from Horizon Rust crate
//! Module: horizon-command_tree_scoreboard
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The `/scoreboard`, `/team` and `/trigger` command trees
//! (ScoreboardCommand, TeamCommand, TriggerCommand).
// use super::{Dispatcher, args::ArgType, vanilla::GAMEMASTERS};

pub const HOLDERS: ArgType = ArgType::ScoreHolder { multiple: true };
pub const HOLDER: ArgType = ArgType::ScoreHolder { multiple: false };

/// `addNumberFormats`: blank | fixed <contents> | styled <style>, and the
/// node itself clears the format.
pub fn number_formats(d: *mut Dispatcher, top: usize, id: *'static str) void {
}
    // rust: d.executes(top, id);
    // rust: let blank = d.literal(top, "blank");
    // rust: d.executes(blank, id);
    // rust: let fixed = d.literal(top, "fixed");
    // rust: let contents = d.argument(fixed, "contents", ArgType::Component);
    // rust: d.executes(contents, id);
    // rust: let styled = d.literal(top, "styled");
    // rust: let style = d.argument(styled, "style", ArgType::Style);
    // rust: d.executes(style, id);
}

pub fn register(d: *mut Dispatcher, root: usize) void {
}
    // rust: scoreboard(d, root);
    // rust: team(d, root);

    // trigger <objective> [add|set <value>]
    // rust: let trigger = d.literal(root, "trigger");
    // rust: let objective = d.argument(trigger, "objective", ArgType::Objective);
    // rust: d.suggests(objective, super::Suggests::Triggers);
    // rust: d.executes(objective, "trigger");
    // rust: for mode in ["add", "set"] {
    // rust: let m = d.literal(objective, mode);
    // rust: let v = d.argument(
    // rust: m,
    // rust: "value",
    // rust: ArgType::Integer {
    // rust: min: i32::MIN,
    // rust: max: i32::MAX,
    // rust: },
    // rust: );
    // rust: d.executes(
    // rust: v,
    // rust: if mode == "add" {
    // rust: "trigger.add"
    // rust: } else {
    // rust: "trigger.set"
    // rust: },
    // rust: );
}
}

pub fn scoreboard(d: *mut Dispatcher, root: usize) void {
}
    // rust: let sb = d.literal(root, "scoreboard");
    // rust: d.requires(sb, GAMEMASTERS);

    // rust: let objectives = d.literal(sb, "objectives");
    // rust: let list = d.literal(objectives, "list");
    // rust: d.executes(list, "scoreboard.objectives.list");
    // rust: let add = d.literal(objectives, "add");
    // rust: let name = d.argument(add, "objective", ArgType::Word);
    // rust: let criteria = d.argument(name, "criteria", ArgType::Criteria);
    // rust: d.executes(criteria, "scoreboard.objectives.add");
    // rust: let display = d.argument(criteria, "displayName", ArgType::Component);
    // rust: d.executes(display, "scoreboard.objectives.add");
    // rust: let modify = d.literal(objectives, "modify");
    // rust: let objective = d.argument(modify, "objective", ArgType::Objective);
    // rust: let dn = d.literal(objective, "displayname");
    // rust: let display = d.argument(dn, "displayName", ArgType::Component);
    // rust: d.executes(display, "scoreboard.objectives.modify.displayname");
    // rust: let rt = d.literal(objective, "rendertype");
    // rust: for kind in ["integer", "hearts"] {
    // rust: let k = d.literal(rt, kind);
    // rust: d.executes(k, "scoreboard.objectives.modify.rendertype");
}
    // rust: let au = d.literal(objective, "displayautoupdate");
    // rust: let v = d.argument(au, "value", ArgType::Bool);
    // rust: d.executes(v, "scoreboard.objectives.modify.displayautoupdate");
    // rust: let nf = d.literal(objective, "numberformat");
    // rust: number_formats(d, nf, "scoreboard.objectives.modify.numberformat");
    // rust: let remove = d.literal(objectives, "remove");
    // rust: let objective = d.argument(remove, "objective", ArgType::Objective);
    // rust: d.executes(objective, "scoreboard.objectives.remove");
    // rust: let setdisplay = d.literal(objectives, "setdisplay");
    // rust: let slot = d.argument(setdisplay, "slot", ArgType::ScoreboardSlot);
    // rust: d.executes(slot, "scoreboard.objectives.setdisplay");
    // rust: let objective = d.argument(slot, "objective", ArgType::Objective);
    // rust: d.executes(objective, "scoreboard.objectives.setdisplay");

    // rust: let players = d.literal(sb, "players");
    // rust: let list = d.literal(players, "list");
    // rust: d.executes(list, "scoreboard.players.list");
    // rust: let target = d.argument(list, "target", HOLDER);
    // rust: d.executes(target, "scoreboard.players.list");
    // set / add / remove <targets> <objective> <score>
    // rust: for (word, min, id) in [
    // rust: ("set", i32::MIN, "scoreboard.players.set"),
    // rust: ("add", 0, "scoreboard.players.add"),
    // rust: ("remove", 0, "scoreboard.players.remove"),
    // rust: ] {
    // rust: let w = d.literal(players, word);
    // rust: let t = d.argument(w, "targets", HOLDERS);
    // rust: let o = d.argument(t, "objective", ArgType::Objective);
    // rust: let s = d.argument(o, "score", ArgType::Integer { min, max: i32::MAX });
    // rust: d.executes(s, id);
}
    // rust: let get = d.literal(players, "get");
    // rust: let t = d.argument(get, "target", HOLDER);
    // rust: let o = d.argument(t, "objective", ArgType::Objective);
    // rust: d.executes(o, "scoreboard.players.get");
    // rust: let reset = d.literal(players, "reset");
    // rust: let t = d.argument(reset, "targets", HOLDERS);
    // rust: d.executes(t, "scoreboard.players.reset");
    // rust: let o = d.argument(t, "objective", ArgType::Objective);
    // rust: d.executes(o, "scoreboard.players.reset");
    // rust: let enable = d.literal(players, "enable");
    // rust: let t = d.argument(enable, "targets", HOLDERS);
    // rust: let o = d.argument(t, "objective", ArgType::Objective);
    // rust: d.suggests(o, super::Suggests::EnableTriggers);
    // rust: d.executes(o, "scoreboard.players.enable");
    // rust: let display = d.literal(players, "display");
    // rust: let name = d.literal(display, "name");
    // rust: let t = d.argument(name, "targets", HOLDERS);
    // rust: let o = d.argument(t, "objective", ArgType::Objective);
    // rust: d.executes(o, "scoreboard.players.display.name");
    // rust: let n = d.argument(o, "name", ArgType::Component);
    // rust: d.executes(n, "scoreboard.players.display.name");
    // rust: let nf = d.literal(display, "numberformat");
    // rust: let t = d.argument(nf, "targets", HOLDERS);
    // rust: let o = d.argument(t, "objective", ArgType::Objective);
    // rust: number_formats(d, o, "scoreboard.players.display.numberformat");
    // rust: let operation = d.literal(players, "operation");
    // rust: let t = d.argument(operation, "targets", HOLDERS);
    // rust: let to = d.argument(t, "targetObjective", ArgType::Objective);
    // rust: let op = d.argument(to, "operation", ArgType::Operation);
    // rust: let source = d.argument(op, "source", HOLDERS);
    // rust: let so = d.argument(source, "sourceObjective", ArgType::Objective);
    // rust: d.executes(so, "scoreboard.players.operation");
}

pub fn team(d: *mut Dispatcher, root: usize) void {
}
    // rust: let team = d.literal(root, "team");
    // rust: d.requires(team, GAMEMASTERS);
    // rust: let list = d.literal(team, "list");
    // rust: d.executes(list, "team.list");
    // rust: let t = d.argument(list, "team", ArgType::Team);
    // rust: d.executes(t, "team.list");
    // rust: let add = d.literal(team, "add");
    // rust: let t = d.argument(add, "team", ArgType::Word);
    // rust: d.executes(t, "team.add");
    // rust: let dn = d.argument(t, "displayName", ArgType::Component);
    // rust: d.executes(dn, "team.add");
    // rust: let remove = d.literal(team, "remove");
    // rust: let t = d.argument(remove, "team", ArgType::Team);
    // rust: d.executes(t, "team.remove");
    // rust: let empty = d.literal(team, "empty");
    // rust: let t = d.argument(empty, "team", ArgType::Team);
    // rust: d.executes(t, "team.empty");
    // rust: let join = d.literal(team, "join");
    // rust: let t = d.argument(join, "team", ArgType::Team);
    // rust: d.executes(t, "team.join");
    // rust: let m = d.argument(t, "members", HOLDERS);
    // rust: d.executes(m, "team.join");
    // rust: let leave = d.literal(team, "leave");
    // rust: let m = d.argument(leave, "members", HOLDERS);
    // rust: d.executes(m, "team.leave");

    // rust: let modify = d.literal(team, "modify");
    // rust: let t = d.argument(modify, "team", ArgType::Team);
    // rust: let dn = d.literal(t, "displayName");
    // rust: let v = d.argument(dn, "displayName", ArgType::Component);
    // rust: d.executes(v, "team.modify.displayname");
    // rust: let color = d.literal(t, "color");
    // rust: let reset = d.literal(color, "reset");
    // rust: d.executes(reset, "team.modify.color.reset");
    // rust: let v = d.argument(color, "value", ArgType::TeamColor);
    // rust: d.executes(v, "team.modify.color");
    // rust: for (word, id) in [
    // rust: ("friendlyFire", "team.modify.friendlyfire"),
    // rust: ("seeFriendlyInvisibles", "team.modify.seefriendlyinvisibles"),
    // rust: ] {
    // rust: let w = d.literal(t, word);
    // rust: let v = d.argument(w, "allowed", ArgType::Bool);
    // rust: d.executes(v, id);
}
    // rust: for (word, id, values) in [
    // rust: (
    // rust: "nametagVisibility",
    // rust: "team.modify.nametagvisibility",
    // rust: ["never", "hideForOtherTeams", "hideForOwnTeam", "always"],
    // rust: ),
    // rust: (
    // rust: "deathMessageVisibility",
    // rust: "team.modify.deathmessagevisibility",
    // rust: ["never", "hideForOtherTeams", "hideForOwnTeam", "always"],
    // rust: ),
    // rust: (
    // rust: "collisionRule",
    // rust: "team.modify.collisionrule",
    // rust: ["never", "pushOwnTeam", "pushOtherTeams", "always"],
    // rust: ),
    // rust: ] {
    // rust: let w = d.literal(t, word);
    // rust: for value in values {
    // rust: let v = d.literal(w, value);
    // rust: d.executes(v, id);
}
}
    // rust: for (word, id) in [
    // rust: ("prefix", "team.modify.prefix"),
    // rust: ("suffix", "team.modify.suffix"),
    // rust: ] {
    // rust: let w = d.literal(t, word);
    // rust: let v = d.argument(w, word, ArgType::Component);
    // rust: d.executes(v, id);
}
}
