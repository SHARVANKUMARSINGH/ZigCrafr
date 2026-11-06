//! Transpiled from Horizon Rust crate
//! Module: horizon-command_tree_misc
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Smaller command trees: `/bossbar`, `/function`, `/return`, `/schedule`,
//! `/random`, `/tick`, `/teammsg`, `/reload` and `/datapack`.
// use super::{
    // rust: Dispatcher,
    // rust: args::ArgType,
    // rust: vanilla::{ENTITIES, GAMEMASTERS, PLAYERS},
}

pub fn int() A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ArgType::Integer {
    // rust: min: i32::MIN,
    // rust: max: i32::MAX,
}
}
pub fn int_min(min: i32) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ArgType::Integer { min, max: i32::MAX }
}
pub const ADMINS: u8 = 3;

pub fn register(d: *mut Dispatcher, root: usize) void {
}
    // rust: item(d, root);
    // rust: bossbar(d, root);
    // rust: function(d, root);
    // rust: stopwatch(d, root);

    // return <value> | fail | run <command>
    // rust: let ret = d.literal(root, "return");
    // rust: d.requires(ret, GAMEMASTERS);
    // rust: let v = d.argument(ret, "value", int());
    // rust: d.executes(v, "return.value");
    // rust: let fail = d.literal(ret, "fail");
    // rust: d.executes(fail, "return.fail");
    // rust: let run = d.literal(ret, "run");
    // rust: d.redirect(run, root);

    // schedule function <function> <time> [append|replace] | clear <function>
    // rust: let schedule = d.literal(root, "schedule");
    // rust: d.requires(schedule, GAMEMASTERS);
    // rust: let f = d.literal(schedule, "function");
    // rust: let name = d.argument(f, "function", ArgType::Function);
    // rust: d.suggests(name, super::Suggests::Functions);
    // rust: let time = d.argument(name, "time", ArgType::Time { min: 0 });
    // rust: d.executes(time, "schedule.function");
    // rust: for mode in ["append", "replace"] {
    // rust: let m = d.literal(time, mode);
    // rust: d.executes(m, "schedule.function");
}
    // rust: let clear = d.literal(schedule, "clear");
    // rust: let id = d.argument(clear, "function", ArgType::Id("schedules"));
    // rust: d.executes(id, "schedule.clear");

    // random (value|roll) <range> [<sequence>] | reset (*|<sequence>) ...
    // rust: let random = d.literal(root, "random");
    // rust: for kind in ["value", "roll"] {
    // rust: let k = d.literal(random, kind);
    // rust: let range = d.argument(k, "range", ArgType::IntRange);
    // rust: let id = if kind == "value" {
    // rust: "random.value"
    // rust: } else {
    // rust: "random.roll"
}
    // rust: d.executes(range, id);
    // rust: let seq = d.argument(range, "sequence", ArgType::Id("random_sequences"));
    // rust: d.requires(seq, GAMEMASTERS);
    // rust: d.executes(seq, id);
}
    // rust: let reset = d.literal(random, "reset");
    // rust: d.requires(reset, GAMEMASTERS);
    // rust: let all = d.literal(reset, "*");
    // rust: d.executes(all, "random.reset");
    // rust: let seq = d.argument(reset, "sequence", ArgType::Id("random_sequences"));
    // rust: d.executes(seq, "random.reset");
    // rust: for parent in [all, seq] {
    // rust: let seed = d.argument(parent, "seed", int());
    // rust: d.executes(seed, "random.reset");
    // rust: let world = d.argument(seed, "includeWorldSeed", ArgType::Bool);
    // rust: d.executes(world, "random.reset");
    // rust: let seq_id = d.argument(world, "includeSequenceId", ArgType::Bool);
    // rust: d.executes(seq_id, "random.reset");
}

    // tick query | rate <rate> | step [stop|<time>] | sprint (stop|<time>) | freeze | unfreeze
    // rust: let tick = d.literal(root, "tick");
    // rust: d.requires(tick, ADMINS);
    // rust: let q = d.literal(tick, "query");
    // rust: d.executes(q, "tick.query");
    // rust: let rate = d.literal(tick, "rate");
    // rust: let r = d.argument(
    // rust: rate,
    // rust: "rate",
    // rust: ArgType::Float {
    // rust: min: 1.0,
    // rust: max: 10000.0,
    // rust: },
    // rust: );
    // rust: d.suggests(r, super::Suggests::Fixed(&["20"]));
    // rust: d.executes(r, "tick.rate");
    // rust: let step = d.literal(tick, "step");
    // rust: d.executes(step, "tick.step");
    // rust: let stop = d.literal(step, "stop");
    // rust: d.executes(stop, "tick.step.stop");
    // rust: let t = d.argument(step, "time", ArgType::Time { min: 1 });
    // rust: d.suggests(t, super::Suggests::Fixed(&["1t", "1s"]));
    // rust: d.executes(t, "tick.step");
    // rust: let sprint = d.literal(tick, "sprint");
    // rust: let stop = d.literal(sprint, "stop");
    // rust: d.executes(stop, "tick.sprint.stop");
    // rust: let t = d.argument(sprint, "time", ArgType::Time { min: 1 });
    // rust: d.suggests(t, super::Suggests::Fixed(&["60s", "1d", "3d"]));
    // rust: d.executes(t, "tick.sprint");
    // rust: let unfreeze = d.literal(tick, "unfreeze");
    // rust: d.executes(unfreeze, "tick.unfreeze");
    // rust: let freeze = d.literal(tick, "freeze");
    // rust: d.executes(freeze, "tick.freeze");

    // teammsg / tm <message>
    // rust: let teammsg = d.literal(root, "teammsg");
    // rust: let m = d.argument(teammsg, "message", ArgType::Message);
    // rust: d.executes(m, "teammsg");
    // rust: let tm = d.literal(root, "tm");
    // rust: d.redirect(tm, teammsg);

    // reload
    // rust: let reload = d.literal(root, "reload");
    // rust: d.requires(reload, GAMEMASTERS);
    // rust: d.executes(reload, "reload");

    // datapack list [available|enabled] | enable|disable <name> ...
    // rust: let datapack = d.literal(root, "datapack");
    // rust: d.requires(datapack, GAMEMASTERS);
    // rust: let list = d.literal(datapack, "list");
    // rust: d.executes(list, "datapack.list");
    // rust: for w in ["available", "enabled"] {
    // rust: let l = d.literal(list, w);
    // rust: d.executes(l, "datapack.list");
}
    // rust: let enable = d.literal(datapack, "enable");
    // rust: let name = d.argument(enable, "name", ArgType::Name("datapacks_disabled"));
    // rust: d.executes(name, "datapack.enable");
    // rust: for w in ["first", "last"] {
    // rust: let l = d.literal(name, w);
    // rust: d.executes(l, "datapack.enable");
}
    // rust: for w in ["before", "after"] {
    // rust: let l = d.literal(name, w);
    // rust: let other = d.argument(l, "existing", ArgType::Name("datapacks_enabled"));
    // rust: d.executes(other, "datapack.enable");
}
    // rust: let create = d.literal(datapack, "create");
    // rust: d.requires(create, 4);
    // rust: let id = d.argument(create, "id", ArgType::Str);
    // rust: let description = d.argument(id, "description", ArgType::Component);
    // rust: d.executes(description, "datapack.create");
    // rust: let disable = d.literal(datapack, "disable");
    // rust: let name = d.argument(disable, "name", ArgType::Name("datapacks_enabled"));
    // rust: d.executes(name, "datapack.disable");
}

/// `item (replace|fill|override) (entity|block) <target> <slots> (with <item> [<count>] | from ...)`.
pub fn item(d: *mut Dispatcher, root: usize) void {
}
    // rust: let item = d.literal(root, "item");
    // rust: d.requires(item, GAMEMASTERS);
    // rust: let modify = d.literal(item, "modify");
    // rust: for provider in ["entity", "block"] {
    // rust: let p = d.literal(modify, provider);
    // rust: let target = if provider == "entity" {
    // rust: d.argument(p, "target", ENTITIES)
    // rust: } else {
    // rust: d.argument(p, "targetPos", ArgType::BlockPos)
}
    // rust: let slot = d.argument(target, "slot", ArgType::SlotSource);
    // rust: let modifier = d.argument(
    // rust: slot,
    // rust: "modifier",
    // rust: ArgType::ResourceOrId("minecraft:item_modifier"),
    // rust: );
    // rust: d.executes(modifier, "item.modify");
}
    // rust: for mode in ["replace", "fill", "override"] {
    // rust: let m = d.literal(item, mode);
    // rust: for provider in ["entity", "block"] {
    // rust: let p = d.literal(m, provider);
    // rust: let target = if provider == "entity" {
    // rust: d.argument(p, "target", ENTITIES)
    // rust: } else {
    // rust: d.argument(p, "targetPos", ArgType::BlockPos)
}
    // rust: let slots = d.argument(target, "slots", ArgType::SlotSource);
    // rust: let with = d.literal(slots, "with");
    // rust: let it = d.argument(with, "item", ArgType::Item);
    // rust: d.executes(it, "item");
    // rust: let count = d.argument(it, "count", ArgType::Integer { min: 1, max: 99 });
    // rust: d.executes(count, "item");
    // rust: let from = d.literal(slots, "from");
    // rust: for src in ["entity", "block"] {
    // rust: let s = d.literal(from, src);
    // rust: let source = if src == "entity" {
    // rust: d.argument(s, "source", ENTITIES)
    // rust: } else {
    // rust: d.argument(s, "sourcePos", ArgType::BlockPos)
}
    // rust: let source_slots = d.argument(source, "sourceSlots", ArgType::SlotSource);
    // rust: d.executes(source_slots, "item");
    // rust: let modifier = d.argument(
    // rust: source_slots,
    // rust: "modifier",
    // rust: ArgType::ResourceOrId("minecraft:item_modifier"),
    // rust: );
    // rust: d.executes(modifier, "item");
}
}
}
}

pub fn bossbar(d: *mut Dispatcher, root: usize) void {
}
    // rust: let b = d.literal(root, "bossbar");
    // rust: d.requires(b, GAMEMASTERS);
    // rust: let add = d.literal(b, "add");
    // rust: let id = d.argument(add, "id", ArgType::Id("bossbars_new"));
    // rust: let name = d.argument(id, "name", ArgType::Component);
    // rust: d.executes(name, "bossbar.add");
    // rust: let remove = d.literal(b, "remove");
    // rust: let id = d.argument(remove, "id", ArgType::Id("bossbars"));
    // rust: d.executes(id, "bossbar.remove");
    // rust: let list = d.literal(b, "list");
    // rust: d.executes(list, "bossbar.list");
    // rust: let set = d.literal(b, "set");
    // rust: let id = d.argument(set, "id", ArgType::Id("bossbars"));
    // rust: let name_l = d.literal(id, "name");
    // rust: let name = d.argument(name_l, "name", ArgType::Component);
    // rust: d.executes(name, "bossbar.set.name");
    // rust: let color = d.literal(id, "color");
    // rust: for c in horizon_client_core::bossbar::COLORS {
    // rust: let l = d.literal(color, c);
    // rust: d.executes(l, "bossbar.set.color");
}
    // rust: let style = d.literal(id, "style");
    // rust: for s in horizon_client_core::bossbar::STYLES {
    // rust: let l = d.literal(style, s);
    // rust: d.executes(l, "bossbar.set.style");
}
    // rust: let value = d.literal(id, "value");
    // rust: let v = d.argument(value, "value", int_min(0));
    // rust: d.executes(v, "bossbar.set.value");
    // rust: let max = d.literal(id, "max");
    // rust: let v = d.argument(max, "max", int_min(1));
    // rust: d.executes(v, "bossbar.set.max");
    // rust: let visible = d.literal(id, "visible");
    // rust: let v = d.argument(visible, "visible", ArgType::Bool);
    // rust: d.executes(v, "bossbar.set.visible");
    // rust: let players = d.literal(id, "players");
    // rust: d.executes(players, "bossbar.set.players");
    // rust: let t = d.argument(players, "targets", PLAYERS);
    // rust: d.executes(t, "bossbar.set.players");
    // rust: let get = d.literal(b, "get");
    // rust: let id = d.argument(get, "id", ArgType::Id("bossbars"));
    // rust: for w in ["value", "max", "visible", "players"] {
    // rust: let l = d.literal(id, w);
    // rust: d.executes(l, "bossbar.get");
}
}

pub fn function(d: *mut Dispatcher, root: usize) void {
}
    // rust: let f = d.literal(root, "function");
    // rust: d.requires(f, GAMEMASTERS);
    // rust: let name = d.argument(f, "name", ArgType::Function);
    // rust: d.suggests(name, super::Suggests::Functions);
    // rust: d.executes(name, "function");
    // rust: let args = d.argument(name, "arguments", ArgType::Nbt);
    // rust: d.executes(args, "function");
    // rust: let with = d.literal(name, "with");
    // rust: for provider in ["entity", "block", "storage"] {
    // rust: let p = d.literal(with, provider);
    // rust: let a = match provider {
    // rust: "entity" => d.argument(
    // rust: p,
    // rust: "source",
    // rust: ArgType::Entity {
    // rust: single: true,
    // rust: players: false,
    // rust: },
    // rust: ),
    // rust: "block" => d.argument(p, "sourcePos", ArgType::BlockPos),
    // rust: _ => d.argument(p, "source", ArgType::Id("storages")),
}
    // rust: d.executes(a, "function");
    // rust: let path = d.argument(a, "path", ArgType::NbtPath);
    // rust: d.executes(path, "function");
}
}

/// stopwatch create <id> | query <id> [<scale>] | restart <id> | remove <id>
pub fn stopwatch(d: *mut Dispatcher, root: usize) void {
}
    // rust: let sw = d.literal(root, "stopwatch");
    // rust: d.requires(sw, GAMEMASTERS);
    // rust: let create = d.literal(sw, "create");
    // rust: let id = d.argument(create, "id", ArgType::Id("none"));
    // rust: d.executes(id, "stopwatch.create");
    // rust: let query = d.literal(sw, "query");
    // rust: let id = d.argument(query, "id", ArgType::Id("stopwatches"));
    // rust: d.executes(id, "stopwatch.query");
    // rust: let scale = d.argument(
    // rust: id,
    // rust: "scale",
    // rust: ArgType::Double {
    // rust: min: f64::MIN,
    // rust: max: f64::MAX,
    // rust: },
    // rust: );
    // rust: d.executes(scale, "stopwatch.query");
    // rust: for (name, command) in [
    // rust: ("restart", "stopwatch.restart"),
    // rust: ("remove", "stopwatch.remove"),
    // rust: ] {
    // rust: let l = d.literal(sw, name);
    // rust: let id = d.argument(l, "id", ArgType::Id("stopwatches"));
    // rust: d.executes(id, command);
}
}
