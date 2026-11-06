//! Transpiled from Horizon Rust crate
package horizon_command_vanilla

import "core:fmt"
import "core:mem"
import "core:math"

// The vanilla command tree (Commands.java registrations) for the commands
// Horizon implements. Leaves carry command ids that the game executes;
// mode keywords are read back from the parsed literals.
// use super::{
    // rust: Dispatcher,
    // rust: args::{ArgType, Resource, integer},
}
// use horizon_client_core::gamerules::{MINECART_IMPROVEMENTS, Value, available_rules};

// Permission levels (Commands.LEVEL_*).
ALL :: 0
GAMEMASTERS :: 2

    // rust: pub const PLAYERS: ArgType = ArgType::Entity {
    // rust: single: false,
    // rust: players: true,
}
    // rust: pub const PLAYER: ArgType = ArgType::Entity {
    // rust: single: true,
    // rust: players: true,
}
    // rust: pub const ENTITIES: ArgType = ArgType::Entity {
    // rust: single: false,
    // rust: players: false,
}
    // rust: pub const ENTITY: ArgType = ArgType::Entity {
    // rust: single: true,
    // rust: players: false,
}

DIFFICULTIES :: ["peaceful", "easy", "normal", "hard"]

build :: proc() -> D {
    // Ported from Horizon
    return {}
}
    // rust: build_with(true)
}
// The tree Commands registers; `dev` adds the commands vanilla only
// registers in development builds (raid, warden_spawn_tracker).
build_with :: proc(dev: bool) -> D {
    // Ported from Horizon
    return {}
}
    // rust: build_for(dev, false)
}
// [`build_with`] for a server of the given kind (Commands.CommandSelection):
// an integrated server's tree, or with `dedicated` a dedicated server's.
build_for :: proc(dev: bool, dedicated: bool) -> D {
    // Ported from Horizon
    return {}
}
    // rust: build_for_features(dev, dedicated, false)
}
build_for_features :: proc(dev: bool, dedicated: bool, minecart_improvements: bool) -> D {
    // Ported from Horizon
    return {}
}
    // rust: let mut d = registered_with_features(dev, minecart_improvements);
    // rust: if dedicated {
    // rust: dedicated_selection(&mut d);
}
    // rust: apply_vanilla_order(&mut d);
    // rust: d
}
// Commands(CommandSelection.DEDICATED) where it differs from INTEGRATED:
// `seed` and `version` check permissions (SeedCommand.register and
// VersionCommand.register get `selection != INTEGRATED`), `publish` and
// `unpublish` are not registered (`includeIntegrated`), and the dedicated
// commands are (`includeDedicated`: `/op`, `/ban`, `/whitelist`...).
dedicated_selection :: proc(d: ^Dispatcher) {
}
    // rust: for name in ["seed", "version"] {
    // rust: if let Some(n) = d.find(name) {
    // rust: d.requires(n, GAMEMASTERS);
}
}
    // rust: let kept: Vec<usize> = d.nodes[0]
    // rust: .children
    // rust: .iter()
    // rust: .copied()
    // rust: .filter(|&c| !matches!(d.nodes[c].name(), "publish" | "unpublish"))
    // rust: .collect();
    // rust: d.nodes[0].children = kept;
    // rust: super::tree_extra::register_dedicated(d, 0);
}
// The tree in the order Horizon's code registers it, before
// [`vanilla_order`](super::vanilla_order) puts children in vanilla's order
// (tools/generate_command_order.py compares the two).
registered :: proc(dev: bool) -> D {
    // Ported from Horizon
    return {}
}
    // rust: registered_with_features(dev, false)
}
registered_with_features :: proc(dev: bool, minecart_improvements: bool) -> D {
    // Ported from Horizon
    return {}
}
    // rust: let mut d = Dispatcher::new();
    // rust: let root = 0;

    // rust: advancement(&mut d, root);

    // help [<command>]
    // rust: let help = d.literal(root, "help");
    // rust: d.executes(help, "help");
    // rust: let c = d.argument(help, "command", ArgType::Greedy);
    // rust: d.executes(c, "help");

    // gamemode <gamemode> [<target>]
    // rust: let gm = d.literal(root, "gamemode");
    // rust: d.requires(gm, GAMEMASTERS);
    // rust: let mode = d.argument(gm, "gamemode", ArgType::GameMode);
    // rust: d.executes(mode, "gamemode");
    // rust: let t = d.argument(mode, "target", PLAYERS);
    // rust: d.executes(t, "gamemode");

    // rust: let dgm = d.literal(root, "defaultgamemode");
    // rust: d.requires(dgm, GAMEMASTERS);
    // rust: let mode = d.argument(dgm, "gamemode", ArgType::GameMode);
    // rust: d.executes(mode, "defaultgamemode");

    // give <targets> <item> [<count>]
    // rust: let give = d.literal(root, "give");
    // rust: d.requires(give, GAMEMASTERS);
    // rust: let targets = d.argument(give, "targets", PLAYERS);
    // rust: let item = d.argument(targets, "item", ArgType::Item);
    // rust: d.executes(item, "give");
    // rust: let count = d.argument(item, "count", integer(1));
    // rust: d.executes(count, "give");

    // teleport / tp
    // rust: let tp = d.literal(root, "teleport");
    // rust: d.requires(tp, GAMEMASTERS);
    // rust: let loc = d.argument(tp, "location", ArgType::Vec3 { center: true });
    // rust: d.executes(loc, "teleport.location");
    // rust: let dest = d.argument(tp, "destination", ENTITY);
    // rust: d.executes(dest, "teleport.destination");
    // rust: let targets = d.argument(tp, "targets", ENTITIES);
    // rust: let loc = d.argument(targets, "location", ArgType::Vec3 { center: true });
    // rust: d.executes(loc, "teleport.targets.location");
    // rust: let rot = d.argument(loc, "rotation", ArgType::Rotation);
    // rust: d.executes(rot, "teleport.targets.location");
    // rust: let facing = d.literal(loc, "facing");
    // rust: let fe = d.literal(facing, "entity");
    // rust: let fent = d.argument(fe, "facingEntity", ENTITY);
    // rust: d.executes(fent, "teleport.targets.location");
    // rust: let anchor = d.argument(fent, "facingAnchor", ArgType::Anchor);
    // rust: d.executes(anchor, "teleport.targets.location");
    // rust: let floc = d.argument(facing, "facingLocation", ArgType::Vec3 { center: true });
    // rust: d.executes(floc, "teleport.targets.location");
    // rust: let dest = d.argument(targets, "destination", ENTITY);
    // rust: d.executes(dest, "teleport.targets.destination");
    // rust: let alias = d.literal(root, "tp");
    // rust: d.requires(alias, GAMEMASTERS);
    // rust: d.redirect(alias, tp);

    // time: clock nodes for the dimension's default clock, plus `of <clock>`.
    // rust: let time = d.literal(root, "time");
    // rust: d.requires(time, GAMEMASTERS);
    // rust: clock_nodes(&mut d, time);
    // rust: let query = d.literal(time, "query");
    // rust: let gt = d.literal(query, "gametime");
    // rust: d.executes(gt, "time.query.gametime");
    // rust: let of = d.literal(time, "of");
    // rust: let clock = d.argument(of, "clock", ArgType::Resource(Resource::Clock));
    // rust: clock_nodes(&mut d, clock);

    // weather (clear|rain|thunder) [<duration>]
    // rust: let weather = d.literal(root, "weather");
    // rust: d.requires(weather, GAMEMASTERS);
    // rust: for kind in ["clear", "rain", "thunder"] {
    // rust: let k = d.literal(weather, kind);
    // rust: d.executes(k, "weather");
    // rust: let dur = d.argument(k, "duration", ArgType::Time { min: 1 });
    // rust: d.executes(dur, "weather");
}

    // rust: if dev {
        // raid start <omenlvl> | stop | check | sound <type> | spawnleader | setomen <level> | glow
    // rust: let raid = d.literal(root, "raid");
    // rust: d.requires(raid, 3);
    // rust: let start = d.literal(raid, "start");
    // rust: let level = d.argument(start, "omenlvl", integer(0));
    // rust: d.executes(level, "raid.start");
    // rust: for (name, id) in [
    // rust: ("stop", "raid.stop"),
    // rust: ("check", "raid.check"),
    // rust: ("spawnleader", "raid.spawnleader"),
    // rust: ("glow", "raid.glow"),
    // rust: ] {
    // rust: let n = d.literal(raid, name);
    // rust: d.executes(n, id);
}
    // rust: let sound = d.literal(raid, "sound");
    // rust: let kind = d.argument(sound, "type", ArgType::Greedy);
    // rust: d.executes(kind, "raid.sound");
    // rust: let setomen = d.literal(raid, "setomen");
    // rust: let level = d.argument(setomen, "level", integer(0));
    // rust: d.executes(level, "raid.setomen");
}

    // kill [<targets>]
    // rust: let kill = d.literal(root, "kill");
    // rust: d.requires(kill, GAMEMASTERS);
    // rust: d.executes(kill, "kill");
    // rust: let t = d.argument(kill, "targets", ENTITIES);
    // rust: d.executes(t, "kill");

    // effect clear [<targets> [<effect>]] | give <targets> <effect> [<seconds>|infinite [<amplifier> [<hideParticles>]]]
    // rust: let effect = d.literal(root, "effect");
    // rust: d.requires(effect, GAMEMASTERS);
    // rust: let clear = d.literal(effect, "clear");
    // rust: d.executes(clear, "effect.clear");
    // rust: let t = d.argument(clear, "targets", ENTITIES);
    // rust: d.executes(t, "effect.clear");
    // rust: let e = d.argument(t, "effect", ArgType::Resource(Resource::Effect));
    // rust: d.executes(e, "effect.clear");
    // rust: let give = d.literal(effect, "give");
    // rust: let t = d.argument(give, "targets", ENTITIES);
    // rust: let e = d.argument(t, "effect", ArgType::Resource(Resource::Effect));
    // rust: d.executes(e, "effect.give");
    // rust: let seconds = d.argument(
    // rust: e,
    // rust: "seconds",
    // rust: ArgType::Integer {
    // rust: min: 1,
    // rust: max: 1_000_000,
    // rust: },
    // rust: );
    // rust: let infinite = d.literal(e, "infinite");
    // rust: for duration in [seconds, infinite] {
    // rust: d.executes(duration, "effect.give");
    // rust: let amp = d.argument(duration, "amplifier", ArgType::Integer { min: 0, max: 255 });
    // rust: d.executes(amp, "effect.give");
    // rust: let hide = d.argument(amp, "hideParticles", ArgType::Bool);
    // rust: d.executes(hide, "effect.give");
}

    // enchant <targets> <enchantment> [<level>]
    // rust: let enchant = d.literal(root, "enchant");
    // rust: d.requires(enchant, GAMEMASTERS);
    // rust: let t = d.argument(enchant, "targets", ENTITIES);
    // rust: let e = d.argument(t, "enchantment", ArgType::Resource(Resource::Enchantment));
    // rust: d.executes(e, "enchant");
    // rust: let level = d.argument(e, "level", integer(0));
    // rust: d.executes(level, "enchant");

    // summon <entity> [<pos>] [<nbt>]
    // rust: let summon = d.literal(root, "summon");
    // rust: d.requires(summon, GAMEMASTERS);
    // rust: let e = d.argument(summon, "entity", ArgType::Resource(Resource::EntityType));
    // rust: d.suggests(e, super::Suggests::SummonableEntities);
    // rust: d.executes(e, "summon");
    // rust: let pos = d.argument(e, "pos", ArgType::Vec3 { center: true });
    // rust: d.executes(pos, "summon");
    // rust: let nbt = d.argument(pos, "nbt", ArgType::Nbt);
    // rust: d.executes(nbt, "summon");

    // setblock <pos> <block> [destroy|keep|replace|strict]
    // rust: let sb = d.literal(root, "setblock");
    // rust: d.requires(sb, GAMEMASTERS);
    // rust: let pos = d.argument(sb, "pos", ArgType::BlockPos);
    // rust: let block = d.argument(pos, "block", ArgType::BlockState);
    // rust: d.executes(block, "setblock");
    // rust: for m in ["destroy", "keep", "replace", "strict"] {
    // rust: let l = d.literal(block, m);
    // rust: d.executes(l, "setblock");
}

    // fill <from> <to> <block> [modes]
    // rust: let fill = d.literal(root, "fill");
    // rust: d.requires(fill, GAMEMASTERS);
    // rust: let from = d.argument(fill, "from", ArgType::BlockPos);
    // rust: let to = d.argument(from, "to", ArgType::BlockPos);
    // rust: let block = d.argument(to, "block", ArgType::BlockState);
    // rust: fill_modes(&mut d, block);
    // rust: let replace = d.literal(block, "replace");
    // rust: d.executes(replace, "fill");
    // rust: let filter = d.argument(replace, "filter", ArgType::BlockPredicate);
    // rust: fill_modes(&mut d, filter);
    // rust: let keep = d.literal(block, "keep");
    // rust: d.executes(keep, "fill");

    // clone [from <dim>] <begin> <end> [to <dim>] <destination> [strict] [mask] [mode]
    // rust: let clone = d.literal(root, "clone");
    // rust: d.requires(clone, GAMEMASTERS);
    // rust: clone_begin(&mut d, clone);
    // rust: let from = d.literal(clone, "from");
    // rust: let dim = d.argument(from, "sourceDimension", ArgType::Dimension);
    // rust: clone_begin(&mut d, dim);

    // experience / xp
    // rust: let xp = d.literal(root, "experience");
    // rust: d.requires(xp, GAMEMASTERS);
    // rust: for (op, min) in [("add", i32::MIN), ("set", 0)] {
    // rust: let o = d.literal(xp, op);
    // rust: let t = d.argument(o, "target", PLAYERS);
    // rust: let amount = d.argument(t, "amount", integer(min));
    // rust: d.executes(amount, "experience");
    // rust: for unit in ["points", "levels"] {
    // rust: let u = d.literal(amount, unit);
    // rust: d.executes(u, "experience");
}
}
    // rust: let q = d.literal(xp, "query");
    // rust: let t = d.argument(q, "target", PLAYER);
    // rust: for unit in ["points", "levels"] {
    // rust: let u = d.literal(t, unit);
    // rust: d.executes(u, "experience");
}
    // rust: let alias = d.literal(root, "xp");
    // rust: d.requires(alias, GAMEMASTERS);
    // rust: d.redirect(alias, xp);

    // gamerule <rule> [<value>] (short and namespaced names)
    // rust: let gr = d.literal(root, "gamerule");
    // rust: d.requires(gr, GAMEMASTERS);
    // rust: for rule in available_rules(minecart_improvements) {
    // rust: for name in [rule.name.to_owned(), format!("minecraft:{}", rule.name)] {
    // rust: let r = d.literal(gr, &name);
    // rust: d.executes(r, "gamerule");
    // rust: let ty = match rule.default {
    // rust: Value::Bool(_) => ArgType::Bool,
    // rust: Value::Int(_) => ArgType::Integer {
    // rust: min: rule.min,
    // rust: max: rule.max,
    // rust: },
}
    // rust: let v = d.argument(r, "value", ty);
    // rust: d.executes(v, "gamerule");
}
}

    // difficulty [<difficulty>]
    // rust: let diff = d.literal(root, "difficulty");
    // rust: d.requires(diff, GAMEMASTERS);
    // rust: d.executes(diff, "difficulty");
    // rust: for name in DIFFICULTIES {
    // rust: let l = d.literal(diff, name);
    // rust: d.executes(l, "difficulty");
}

    // seed and version: everyone in the integrated server, game masters on a
    // dedicated one (`dedicated_selection`).
    // rust: let seed = d.literal(root, "seed");
    // rust: d.executes(seed, "seed");
    // rust: let version = d.literal(root, "version");
    // rust: d.executes(version, "version");

    // spawnpoint [<targets>] [<pos>] [<rotation>]
    // rust: let sp = d.literal(root, "spawnpoint");
    // rust: d.requires(sp, GAMEMASTERS);
    // rust: d.executes(sp, "spawnpoint");
    // rust: let t = d.argument(sp, "targets", PLAYERS);
    // rust: d.executes(t, "spawnpoint");
    // rust: let pos = d.argument(t, "pos", ArgType::BlockPos);
    // rust: d.executes(pos, "spawnpoint");
    // rust: let rot = d.argument(pos, "rotation", ArgType::Rotation);
    // rust: d.executes(rot, "spawnpoint");

    // setworldspawn [<pos>] [<rotation>]
    // rust: let ws = d.literal(root, "setworldspawn");
    // rust: d.requires(ws, GAMEMASTERS);
    // rust: d.executes(ws, "setworldspawn");
    // rust: let pos = d.argument(ws, "pos", ArgType::BlockPos);
    // rust: d.executes(pos, "setworldspawn");
    // rust: let rot = d.argument(pos, "rotation", ArgType::Rotation);
    // rust: d.executes(rot, "setworldspawn");

    // clear [<targets>] [<item>] [<maxCount>]
    // rust: let clear = d.literal(root, "clear");
    // rust: d.requires(clear, GAMEMASTERS);
    // rust: d.executes(clear, "clear");
    // rust: let t = d.argument(clear, "targets", PLAYERS);
    // rust: d.executes(t, "clear");
    // rust: let item = d.argument(t, "item", ArgType::ItemPredicate);
    // rust: d.executes(item, "clear");
    // rust: let max = d.argument(item, "maxCount", integer(0));
    // rust: d.executes(max, "clear");

    // locate (structure|biome) <...>
    // rust: let locate = d.literal(root, "locate");
    // rust: d.requires(locate, GAMEMASTERS);
    // rust: let s = d.literal(locate, "structure");
    // rust: let a = d.argument(
    // rust: s,
    // rust: "structure",
    // rust: ArgType::ResOrTagKey("minecraft:worldgen/structure"),
    // rust: );
    // rust: d.executes(a, "locate.structure");
    // rust: let b = d.literal(locate, "biome");
    // rust: let a = d.argument(b, "biome", ArgType::ResOrTag("minecraft:worldgen/biome"));
    // rust: d.executes(a, "locate.biome");
    // rust: let p = d.literal(locate, "poi");
    // rust: let a = d.argument(
    // rust: p,
    // rust: "poi",
    // rust: ArgType::ResOrTag("minecraft:point_of_interest_type"),
    // rust: );
    // rust: d.executes(a, "locate.poi");

    // rust: if dev {
        // warden_spawn_tracker (clear | set <warning_level>)
    // rust: let tracker = d.literal(root, "warden_spawn_tracker");
    // rust: d.requires(tracker, GAMEMASTERS);
    // rust: let clear = d.literal(tracker, "clear");
    // rust: d.executes(clear, "warden_spawn_tracker.clear");
    // rust: let set = d.literal(tracker, "set");
    // rust: let level = d.argument(set, "warning_level", ArgType::Integer { min: 0, max: 4 });
    // rust: d.executes(level, "warden_spawn_tracker.set");
}

    // say / me / msg / list
    // rust: let say = d.literal(root, "say");
    // rust: d.requires(say, GAMEMASTERS);
    // rust: let m = d.argument(say, "message", ArgType::Message);
    // rust: d.executes(m, "say");
    // rust: let me = d.literal(root, "me");
    // rust: let m = d.argument(me, "action", ArgType::Message);
    // rust: d.executes(m, "me");
    // rust: let msg = d.literal(root, "msg");
    // rust: let t = d.argument(msg, "targets", PLAYERS);
    // rust: let m = d.argument(t, "message", ArgType::Message);
    // rust: d.executes(m, "msg");
    // rust: for alias in ["tell", "w"] {
    // rust: let a = d.literal(root, alias);
    // rust: d.redirect(a, msg);
}
    // rust: let list = d.literal(root, "list");
    // rust: d.executes(list, "list");
    // rust: let uuids = d.literal(list, "uuids");
    // rust: d.executes(uuids, "list");

    // tellraw <targets> <message>
    // rust: let tellraw = d.literal(root, "tellraw");
    // rust: d.requires(tellraw, GAMEMASTERS);
    // rust: let t = d.argument(tellraw, "targets", PLAYERS);
    // rust: let m = d.argument(t, "message", ArgType::Component);
    // rust: d.executes(m, "tellraw");

    // title <targets> clear|reset|title|subtitle|actionbar <title>|times <in> <stay> <out>
    // rust: let title = d.literal(root, "title");
    // rust: d.requires(title, GAMEMASTERS);
    // rust: let t = d.argument(title, "targets", PLAYERS);
    // rust: for mode in ["clear", "reset"] {
    // rust: let l = d.literal(t, mode);
    // rust: d.executes(l, "title");
}
    // rust: for mode in ["title", "subtitle", "actionbar"] {
    // rust: let l = d.literal(t, mode);
    // rust: let c = d.argument(l, "title", ArgType::Component);
    // rust: d.executes(c, "title");
}
    // rust: let times = d.literal(t, "times");
    // rust: let fade_in = d.argument(times, "fadeIn", ArgType::Time { min: 0 });
    // rust: let stay = d.argument(fade_in, "stay", ArgType::Time { min: 0 });
    // rust: let fade_out = d.argument(stay, "fadeOut", ArgType::Time { min: 0 });
    // rust: d.executes(fade_out, "title");

    // rust: super::tree_scoreboard::register(&mut d, root);
    // rust: super::tree_data::register(&mut d, root);
    // rust: super::tree_execute::register(&mut d, root);
    // rust: super::tree_misc::register(&mut d, root);
    // rust: super::tree_world::register(&mut d, root);
    // rust: super::tree_extra::register(&mut d, root);
    // rust: d
}

// AdvancementCommands: grant|revoke <targets> only|from|until|through
// <advancement> | everything; `only` takes an optional criterion.
advancement :: proc(d: ^Dispatcher, root: uint) {
}
    // rust: let adv = d.literal(root, "advancement");
    // rust: d.requires(adv, GAMEMASTERS);
    // rust: for action in ["grant", "revoke"] {
    // rust: let a = d.literal(adv, action);
    // rust: let t = d.argument(a, "targets", PLAYERS);
    // rust: for mode in ["only", "from", "until", "through"] {
    // rust: let m = d.literal(t, mode);
    // rust: let id = d.argument(m, "advancement", ArgType::ResKey("minecraft:advancement"));
    // rust: d.executes(id, "advancement");
    // rust: if mode == "only" {
    // rust: let c = d.argument(id, "criterion", ArgType::Greedy);
    // rust: d.suggests(c, super::Suggests::AdvancementCriteria);
    // rust: d.executes(c, "advancement");
}
}
    // rust: let e = d.literal(t, "everything");
    // rust: d.executes(e, "advancement");
}
}

// TimeCommand.addClockNodes.
clock_nodes :: proc(d: ^Dispatcher, node: uint) {
}
    // rust: let set = d.literal(node, "set");
    // rust: let t = d.argument(set, "time", ArgType::Time { min: 0 });
    // rust: d.executes(t, "time.set");
    // rust: let marker = d.argument(set, "timemarker", ArgType::Id("time_markers"));
    // rust: d.suggests(marker, super::Suggests::TimeMarkers);
    // rust: d.executes(marker, "time.set.marker");
    // rust: let add = d.literal(node, "add");
    // rust: let t = d.argument(add, "time", ArgType::Time { min: i32::MIN });
    // rust: d.executes(t, "time.add");
    // rust: let pause = d.literal(node, "pause");
    // rust: d.executes(pause, "time.pause");
    // rust: let resume = d.literal(node, "resume");
    // rust: d.executes(resume, "time.resume");
    // rust: let rate = d.literal(node, "rate");
    // rust: let r = d.argument(
    // rust: rate,
    // rust: "rate",
    // rust: ArgType::Float {
    // rust: min: 1.0e-5,
    // rust: max: 1000.0,
    // rust: },
    // rust: );
    // rust: d.executes(r, "time.rate");
    // rust: let query = d.literal(node, "query");
    // rust: let time = d.literal(query, "time");
    // rust: d.executes(time, "time.query.time");
    // rust: let tl = d.argument(query, "timeline", ArgType::Resource(Resource::Timeline));
    // rust: d.executes(tl, "time.query.timeline");
    // rust: let rep = d.literal(tl, "repetition");
    // rust: d.executes(rep, "time.query.repetition");
}
// FillCommand.wrapWithMode.
fill_modes :: proc(d: ^Dispatcher, node: uint) {
}
    // rust: d.executes(node, "fill");
    // rust: for m in ["outline", "hollow", "destroy", "strict"] {
    // rust: let l = d.literal(node, m);
    // rust: d.executes(l, "fill");
}
}
clone_begin :: proc(d: ^Dispatcher, node: uint) {
}
    // rust: let begin = d.argument(node, "begin", ArgType::BlockPos);
    // rust: let end = d.argument(begin, "end", ArgType::BlockPos);
    // rust: clone_destination(d, end);
    // rust: let to = d.literal(end, "to");
    // rust: let dim = d.argument(to, "targetDimension", ArgType::Dimension);
    // rust: clone_destination(d, dim);
}
clone_destination :: proc(d: ^Dispatcher, node: uint) {
}
    // rust: let dest = d.argument(node, "destination", ArgType::BlockPos);
    // rust: clone_mask(d, dest);
    // rust: let strict = d.literal(dest, "strict");
    // rust: clone_mask(d, strict);
}
clone_mask :: proc(d: ^Dispatcher, node: uint) {
}
    // rust: d.executes(node, "clone");
    // rust: for m in ["replace", "masked"] {
    // rust: let l = d.literal(node, m);
    // rust: clone_mode(d, l);
}
    // rust: let filtered = d.literal(node, "filtered");
    // rust: let filter = d.argument(filtered, "filter", ArgType::BlockPredicate);
    // rust: clone_mode(d, filter);
}
clone_mode :: proc(d: ^Dispatcher, node: uint) {
}
    // rust: d.executes(node, "clone");
    // rust: for m in ["force", "move", "normal"] {
    // rust: let l = d.literal(node, m);
    // rust: d.executes(l, "clone");
}
}
// The shared vanilla tree.
// Reorder node children as vanilla registers them (Brigadier keeps
// children in registration order; smart usage lists them that way).
apply_vanilla_order :: proc(d: ^Dispatcher) {
}
    // rust: for (path, order) in super::vanilla_order::ORDER {
    // rust: let mut node = Some(0usize);
    // rust: for name in path.split(' ').filter(|n| !n.is_empty()) {
    // rust: node = node.and_then(|n| {
    // rust: d.nodes[n]
    // rust: .children
    // rust: .iter()
    // rust: .copied()
    // rust: .find(|&c| d.nodes[c].name() == name)
    // rust: });
}
    // rust: let Some(n) = node else { continue };
    // rust: let mut children = d.nodes[n].children.clone();
    // rust: let rank = |c: usize| {
    // rust: order
    // rust: .iter()
    // rust: .position(|o| *o == d.nodes[c].name())
    // rust: .unwrap_or(order.len())
}
    // rust: children.sort_by_key(|&c| rank(c));
    // rust: d.nodes[n].children = children;
}
}
// The tree the game runs: a release integrated server's, or with
// `HORIZON_DEV_COMMANDS` set the development one
// (SharedConstants.DEBUG_DEV_COMMANDS), plus Horizon's own commands when
// the server turned them on (`set_horizon_commands`).
game_dispatcher :: proc() -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: game_tree(
    // rust: std::env::var_os("HORIZON_DEV_COMMANDS").is_some(),
    // rust: HORIZON_COMMANDS.load(std::sync::atomic::Ordering::Relaxed),
    // rust: DEDICATED_COMMANDS.load(std::sync::atomic::Ordering::Relaxed),
    // rust: )
}
// The server's tree for this world's enabled features. Cache entries are
// separate from vanilla-only worlds and from each server/command selection.
game_dispatcher_with_features :: proc(features: ^[string]) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: if !features.iter().any(|f| f == MINECART_IMPROVEMENTS) {
    // rust: return game_dispatcher();
}
TREES :: [const { std::sync::OnceLock::new() }; 8]
    // rust: let dev = std::env::var_os("HORIZON_DEV_COMMANDS").is_some();
    // rust: let horizon = HORIZON_COMMANDS.load(std::sync::atomic::Ordering::Relaxed);
    // rust: let dedicated = DEDICATED_COMMANDS.load(std::sync::atomic::Ordering::Relaxed);
    // rust: TREES[usize::from(dev) | usize::from(horizon) << 1 | usize::from(dedicated) << 2].get_or_init(
    // rust: || {
    // rust: let mut d = build_for_features(dev, dedicated, true);
    // rust: if horizon {
    // rust: horizon_commands(&mut d, 0);
}
    // rust: d
    // rust: },
    // rust: )
}
// Whether this process is a dedicated server, whose tree has the dedicated
// commands (`/op`, `/ban`, `/whitelist`...). Single player's server thread
// and a LAN world are integrated servers: vanilla registers none of them.
    // rust: static DEDICATED_COMMANDS: std::sync::atomic::AtomicBool =
    // rust: std::sync::atomic::AtomicBool::new(false);
// A dedicated server turns its commands on, for the trees `game_dispatcher`
// returns from now on.
set_dedicated_commands :: proc(on: bool) {
}
    // rust: DEDICATED_COMMANDS.store(on, std::sync::atomic::Ordering::Relaxed);
}
// Whether this process's server has Horizon's own commands (`/pregen`). Off
// by default, so `/help` and the command tree are vanilla's; a dedicated
// server turns them on with `horizon-pregen=true` in server.properties, the
// game with `--pregen` (docs/pregeneration.md).
HORIZON_COMMANDS :: std::sync::atomic::AtomicBool::new(false)
// Turns Horizon's own commands on or off for the trees `game_dispatcher`
// returns from now on.
set_horizon_commands :: proc(on: bool) {
}
    // rust: HORIZON_COMMANDS.store(on, std::sync::atomic::Ordering::Relaxed);
}
// The server.properties key that turns `/pregen` on (Horizon's own; vanilla
// ignores keys it doesn't know).
PREGEN_PROPERTY :: "horizon-pregen"
    // rust: pub(crate) fn game_tree(dev: bool, horizon: bool, dedicated: bool) -> &'static Dispatcher {
TREES :: [const { std::sync::OnceLock::new() }; 8]
    // rust: match (dev, horizon, dedicated) {
    // rust: (true, false, false) => dispatcher(),
    // rust: (false, false, false) => release_dispatcher(),
    // rust: _ => TREES[usize::from(dev) | usize::from(horizon) << 1 | usize::from(dedicated) << 2]
    // rust: .get_or_init(|| {
    // rust: let mut d = build_for(dev, dedicated);
    // rust: if horizon {
    // rust: horizon_commands(&mut d, 0);
}
    // rust: d
    // rust: }),
}
}
// Commands vanilla doesn't have, after its own: `/pregen`
// (docs/pregeneration.md).
horizon_commands :: proc(d: ^Dispatcher, root: uint) {
}
    // rust: let pregen = d.literal(root, "pregen");
    // rust: d.requires(pregen, GAMEMASTERS);
    // rust: let start = d.literal(pregen, "start");
    // rust: let radius = d.argument(
    // rust: start,
    // rust: "radius",
    // rust: ArgType::Integer {
    // rust: min: 0,
    // rust: max: 30_000_000,
    // rust: },
    // rust: );
    // rust: d.executes(radius, "pregen.start");
    // rust: for shape in ["square", "circle"] {
    // rust: let shape = d.literal(radius, shape);
    // rust: d.executes(shape, "pregen.start");
    // rust: let center = d.argument(shape, "center", ArgType::ColumnPos);
    // rust: d.executes(center, "pregen.start");
}
    // rust: for (word, id) in [
    // rust: ("pause", "pregen.pause"),
    // rust: ("continue", "pregen.continue"),
    // rust: ("cancel", "pregen.cancel"),
    // rust: ("status", "pregen.status"),
    // rust: ] {
    // rust: let w = d.literal(pregen, word);
    // rust: d.executes(w, id);
}
}
dispatcher :: proc() -> ^ {
    // Ported from Horizon
    return {}
}
TREE :: std::sync::OnceLock::new()
    // rust: TREE.get_or_init(build)
}
// The tree of a release integrated server (no development commands).
release_dispatcher :: proc() -> ^ {
    // Ported from Horizon
    return {}
}
TREE :: std::sync::OnceLock::new()
    // rust: TREE.get_or_init(|| build_with(false))
}
