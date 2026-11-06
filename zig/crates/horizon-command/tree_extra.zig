//! Transpiled from Horizon Rust crate
//! Module: horizon-command_tree_extra
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Commands of the hosted game rather than the world: `/dialog`, `/kick`,
//! `/posteffect`, `/fetchprofile`, `/spectate`, `/publish`, `/unpublish`,
//! `/waypoint`, `/debug`, `/jfr` and `/test`; on a dedicated server only,
//! `/op`, `/deop`, `/ban`, `/ban-ip`, `/banlist`, `/pardon`, `/pardon-ip`,
//! `/setidletimeout`, `/transfer` and `/whitelist`.
// use super::{
    // rust: Dispatcher, Suggests,
    // rust: args::ArgType,
    // rust: vanilla::{ENTITY, GAMEMASTERS, PLAYER, PLAYERS},
}

pub const ADMINS: u8 = 3;
pub const OWNERS: u8 = 4;

pub fn register(d: *mut Dispatcher, root: usize) void {
}
    // DialogCommand
    // rust: let dialog = d.literal(root, "dialog");
    // rust: d.requires(dialog, GAMEMASTERS);
    // rust: let show = d.literal(dialog, "show");
    // rust: let t = d.argument(show, "targets", PLAYERS);
    // rust: let dl = d.argument(t, "dialog", ArgType::ResourceOrId("minecraft:dialog"));
    // rust: d.executes(dl, "dialog.show");
    // rust: let clear = d.literal(dialog, "clear");
    // rust: let t = d.argument(clear, "targets", PLAYERS);
    // rust: d.executes(t, "dialog.clear");

    // KickCommand
    // rust: let kick = d.literal(root, "kick");
    // rust: d.requires(kick, ADMINS);
    // rust: let t = d.argument(kick, "targets", PLAYERS);
    // rust: d.executes(t, "kick");
    // rust: let reason = d.argument(t, "reason", ArgType::Message);
    // rust: d.executes(reason, "kick");

    // PostEffectCommand
    // rust: let pe = d.literal(root, "posteffect");
    // rust: d.requires(pe, GAMEMASTERS);
    // rust: let add = d.literal(pe, "add");
    // rust: let t = d.argument(add, "targets", PLAYERS);
    // rust: let id = d.argument(t, "posteffect", ArgType::Id("post_effects"));
    // rust: d.executes(id, "posteffect.add");
    // rust: let clear = d.literal(pe, "clear");
    // rust: let t = d.argument(clear, "targets", PLAYERS);
    // rust: d.executes(t, "posteffect.clear");
    // rust: let list = d.literal(pe, "list");
    // rust: let t = d.argument(list, "target", PLAYER);
    // rust: d.executes(t, "posteffect.list");
    // rust: let remove = d.literal(pe, "remove");
    // rust: let t = d.argument(remove, "targets", PLAYERS);
    // rust: let id = d.argument(t, "posteffect", ArgType::Id("post_effects"));
    // rust: d.executes(id, "posteffect.remove");

    // FetchProfileCommand
    // rust: let fp = d.literal(root, "fetchprofile");
    // rust: d.requires(fp, GAMEMASTERS);
    // rust: let name = d.literal(fp, "name");
    // rust: let n = d.argument(name, "name", ArgType::Greedy);
    // rust: d.executes(n, "fetchprofile");
    // rust: let id = d.literal(fp, "id");
    // rust: let u = d.argument(id, "id", ArgType::Uuid);
    // rust: d.executes(u, "fetchprofile");
    // rust: let entity = d.literal(fp, "entity");
    // rust: let e = d.argument(entity, "entity", ENTITY);
    // rust: d.executes(e, "fetchprofile");

    // SpectateCommand
    // rust: let spectate = d.literal(root, "spectate");
    // rust: d.requires(spectate, GAMEMASTERS);
    // rust: d.executes(spectate, "spectate");
    // rust: let target = d.argument(spectate, "target", ENTITY);
    // rust: d.executes(target, "spectate");
    // rust: let player = d.argument(target, "player", PLAYER);
    // rust: d.executes(player, "spectate");

    // PublishCommand / UnpublishCommand
    // rust: let publish = d.literal(root, "publish");
    // rust: d.requires(publish, OWNERS);
    // rust: d.executes(publish, "publish");
    // rust: let allow = d.argument(publish, "allowCommands", ArgType::Bool);
    // rust: d.executes(allow, "publish");
    // rust: let port = d.argument(allow, "port", ArgType::Integer { min: 0, max: 65535 });
    // rust: d.executes(port, "publish");
    // rust: let unpublish = d.literal(root, "unpublish");
    // rust: d.requires(unpublish, OWNERS);
    // rust: d.executes(unpublish, "unpublish");

    // WaypointCommand
    // rust: let wp = d.literal(root, "waypoint");
    // rust: d.requires(wp, GAMEMASTERS);
    // rust: let list = d.literal(wp, "list");
    // rust: d.executes(list, "waypoint.list");
    // rust: let modify = d.literal(wp, "modify");
    // rust: let w = d.argument(modify, "waypoint", ENTITY);
    // rust: let color = d.literal(w, "color");
    // rust: let c = d.argument(color, "color", ArgType::TeamColor);
    // rust: d.executes(c, "waypoint.modify");
    // rust: let hex = d.literal(color, "hex");
    // rust: let h = d.argument(hex, "color", ArgType::HexColor);
    // rust: d.executes(h, "waypoint.modify");
    // rust: let reset = d.literal(color, "reset");
    // rust: d.executes(reset, "waypoint.modify");
    // rust: let style = d.literal(w, "style");
    // rust: let reset = d.literal(style, "reset");
    // rust: d.executes(reset, "waypoint.modify");
    // rust: let set = d.literal(style, "set");
    // rust: let st = d.argument(set, "style", ArgType::Id("none"));
    // rust: d.executes(st, "waypoint.modify");

    // DebugCommand
    // rust: let debug = d.literal(root, "debug");
    // rust: d.requires(debug, ADMINS);
    // rust: for name in ["start", "stop"] {
    // rust: let l = d.literal(debug, name);
    // rust: d.executes(l, "debug");
}
    // rust: let function = d.literal(debug, "function");
    // rust: d.requires(function, ADMINS);
    // rust: let n = d.argument(function, "name", ArgType::Function);
    // rust: d.suggests(n, super::Suggests::Functions);
    // rust: d.executes(n, "debug");

    // JfrCommand (registered when the JVM profiler is available)
    // rust: let jfr = d.literal(root, "jfr");
    // rust: d.requires(jfr, OWNERS);
    // rust: for name in ["start", "stop"] {
    // rust: let l = d.literal(jfr, name);
    // rust: d.executes(l, "jfr");
}

    // TestCommand (release build: no export subcommands)
    // rust: let test = d.literal(root, "test");
    // rust: d.requires(test, GAMEMASTERS);
    // rust: let tests = ArgType::ResourceSelector("minecraft:test_instance");
    // rust: let int0 = ArgType::Integer {
    // rust: min: 0,
    // rust: max: i32::MAX,
}
    // rust: let int = ArgType::Integer {
    // rust: min: i32::MIN,
    // rust: max: i32::MAX,
}
    // numberOfTimes [untilFailed [rotationSteps [testsPerRow]]], or only
    // the first two.
    // rust: let retry = |d: &mut Dispatcher, node: usize, id: &'static str, build_info: bool| {
    // rust: let n = d.argument(node, "numberOfTimes", int0.clone());
    // rust: d.executes(n, id);
    // rust: let u = d.argument(n, "untilFailed", ArgType::Bool);
    // rust: d.executes(u, id);
    // rust: if build_info {
    // rust: let r = d.argument(u, "rotationSteps", int.clone());
    // rust: d.executes(r, id);
    // rust: let t = d.argument(r, "testsPerRow", int.clone());
    // rust: d.executes(t, id);
}
}
    // rust: let run = d.literal(test, "run");
    // rust: let t = d.argument(run, "tests", tests.clone());
    // rust: d.executes(t, "test.run");
    // rust: retry(d, t, "test.run", true);
    // rust: let multiple = d.literal(test, "runmultiple");
    // rust: let t = d.argument(multiple, "tests", tests.clone());
    // rust: d.executes(t, "test.run");
    // rust: let a = d.argument(t, "amount", int.clone());
    // rust: d.executes(a, "test.run");
    // rust: for name in ["runthese", "runclosest", "runthat"] {
    // rust: let l = d.literal(test, name);
    // rust: d.executes(l, "test.run.found");
    // rust: retry(d, l, "test.run.found", false);
}
    // rust: let failed = d.literal(test, "runfailed");
    // rust: d.executes(failed, "test.run.found");
    // rust: let only = d.argument(failed, "onlyRequiredTests", ArgType::Bool);
    // rust: d.executes(only, "test.run.found");
    // rust: retry(d, only, "test.run.found", true);
    // rust: retry(d, failed, "test.run.found", true);
    // rust: let verify = d.literal(test, "verify");
    // rust: let t = d.argument(verify, "tests", tests.clone());
    // rust: d.executes(t, "test.verify");
    // rust: let locate = d.literal(test, "locate");
    // rust: let t = d.argument(locate, "tests", tests);
    // rust: d.executes(t, "test.locate");
    // rust: for name in [
    // rust: "resetclosest",
    // rust: "resetthese",
    // rust: "resetthat",
    // rust: "clearthat",
    // rust: "clearthese",
    // rust: ] {
    // rust: let l = d.literal(test, name);
    // rust: d.executes(l, "test.clear");
}
    // rust: let all = d.literal(test, "clearall");
    // rust: d.executes(all, "test.clear");
    // rust: let r = d.argument(all, "radius", int.clone());
    // rust: d.executes(r, "test.clear");
    // rust: let stop = d.literal(test, "stop");
    // rust: d.executes(stop, "test.stop");
    // rust: let pos = d.literal(test, "pos");
    // rust: d.executes(pos, "test.pos");
    // rust: let var = d.argument(pos, "var", ArgType::Word);
    // rust: d.executes(var, "test.pos");
    // rust: let create = d.literal(test, "create");
    // rust: let id = d.argument(create, "id", ArgType::Id("none"));
    // rust: d.executes(id, "test.create");
    // rust: let w = d.argument(id, "width", int.clone());
    // rust: d.executes(w, "test.create");
    // rust: let h = d.argument(w, "height", int.clone());
    // rust: let depth = d.argument(h, "depth", int);
    // rust: d.executes(depth, "test.create");
}

/// The commands only a dedicated server registers
/// (`Commands.CommandSelection.includeDedicated`): an integrated server, and
/// so single player and a LAN world, has none of them.
pub fn register_dedicated(d: *mut Dispatcher, root: usize) void {
}
    // BanIpCommands, BanListCommands
    // rust: let ban_ip = d.literal(root, "ban-ip");
    // rust: d.requires(ban_ip, ADMINS);
    // rust: let t = d.argument(ban_ip, "target", ArgType::Word);
    // rust: d.executes(t, "ban-ip");
    // rust: let reason = d.argument(t, "reason", ArgType::Message);
    // rust: d.executes(reason, "ban-ip");
    // rust: let banlist = d.literal(root, "banlist");
    // rust: d.requires(banlist, ADMINS);
    // rust: d.executes(banlist, "banlist");
    // rust: for (word, id) in [("ips", "banlist.ips"), ("players", "banlist.players")] {
    // rust: let w = d.literal(banlist, word);
    // rust: d.executes(w, id);
}

    // OpCommand, DeOpCommands, BanPlayerCommands, PardonCommand
    // rust: for (name, id, suggests) in [
    // rust: ("op", "op", Suggests::NonOperators),
    // rust: ("deop", "deop", Suggests::Operators),
    // rust: ("pardon", "pardon", Suggests::BannedPlayers),
    // rust: ] {
    // rust: let n = d.literal(root, name);
    // rust: d.requires(n, ADMINS);
    // rust: let t = d.argument(n, "targets", ArgType::GameProfile);
    // rust: d.suggests(t, suggests);
    // rust: d.executes(t, id);
}
    // PardonIpCommand
    // rust: let pardon_ip = d.literal(root, "pardon-ip");
    // rust: d.requires(pardon_ip, ADMINS);
    // rust: let t = d.argument(pardon_ip, "target", ArgType::Word);
    // rust: d.suggests(t, Suggests::BannedIps);
    // rust: d.executes(t, "pardon-ip");

    // SaveAllCommand (`flush` too), SaveOffCommand, SaveOnCommand, StopCommand
    // rust: let save_all = d.literal(root, "save-all");
    // rust: d.requires(save_all, OWNERS);
    // rust: d.executes(save_all, "save-all");
    // rust: let flush = d.literal(save_all, "flush");
    // rust: d.executes(flush, "save-all");
    // rust: for name in ["save-off", "save-on", "stop"] {
    // rust: let n = d.literal(root, name);
    // rust: d.requires(n, OWNERS);
    // rust: d.executes(n, name);
}

    // rust: let ban = d.literal(root, "ban");
    // rust: d.requires(ban, ADMINS);
    // rust: let t = d.argument(ban, "targets", ArgType::GameProfile);
    // rust: d.executes(t, "ban");
    // rust: let reason = d.argument(t, "reason", ArgType::Message);
    // rust: d.executes(reason, "ban");

    // SetPlayerIdleTimeoutCommand: minutes, 0 to never kick for idleness.
    // rust: let idle = d.literal(root, "setidletimeout");
    // rust: d.requires(idle, ADMINS);
    // rust: let minutes = d.argument(
    // rust: idle,
    // rust: "minutes",
    // rust: ArgType::Integer {
    // rust: min: 0,
    // rust: max: i32::MAX,
    // rust: },
    // rust: );
    // rust: d.executes(minutes, "setidletimeout");

    // TransferCommand: <hostname> [<port> [<players>]], the port 1 to 65535.
    // rust: let transfer = d.literal(root, "transfer");
    // rust: d.requires(transfer, ADMINS);
    // rust: let hostname = d.argument(transfer, "hostname", ArgType::Str);
    // rust: d.executes(hostname, "transfer");
    // rust: let port = d.argument(hostname, "port", ArgType::Integer { min: 1, max: 65535 });
    // rust: d.executes(port, "transfer");
    // rust: let players = d.argument(port, "players", PLAYERS);
    // rust: d.executes(players, "transfer");

    // WhitelistCommand
    // rust: let whitelist = d.literal(root, "whitelist");
    // rust: d.requires(whitelist, ADMINS);
    // rust: for (word, id) in [
    // rust: ("on", "whitelist.on"),
    // rust: ("off", "whitelist.off"),
    // rust: ("list", "whitelist.list"),
    // rust: ] {
    // rust: let w = d.literal(whitelist, word);
    // rust: d.executes(w, id);
}
    // rust: for (word, id, suggests) in [
    // rust: ("add", "whitelist.add", Suggests::NonWhitelisted),
    // rust: ("remove", "whitelist.remove", Suggests::Whitelisted),
    // rust: ] {
    // rust: let w = d.literal(whitelist, word);
    // rust: let t = d.argument(w, "targets", ArgType::GameProfile);
    // rust: d.suggests(t, suggests);
    // rust: d.executes(t, id);
}
    // rust: let reload = d.literal(whitelist, "reload");
    // rust: d.executes(reload, "whitelist.reload");
}
