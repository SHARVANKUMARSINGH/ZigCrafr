//! Transpiled from Horizon Rust crate
//! Module: horizon-client_entry
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Startup shared by the gameplay library and its executable.
// use crate::{crash, game, logging};

/// Start the game. The executable supplies the allocator and retains the mod API marker.
pub fn main() void {
}
    // rust: main_with(Default::default());
}

/// Start the game with trait mods in dispatch order.
pub fn main_with(mods: crate::mod_api::Mods) void {
}
    // First: a trait injection into anything below (logging, the crash handler) calls its mod.
    // rust: if crate::mod_api::MODS.set(mods).is_err() {
    // rust: log::warn!("Trait mods already installed; ignoring the second list");
}
    // rust: horizon_threads::configure_allocator();
    // rust: horizon_client::telemetry::mark_start();
    // rust: horizon_client::spans::startup::init(std::time::Instant::now());
    // rust: horizon_client::spans::trace::start_from_env();
    // rust: let args: Vec<String> = std::env::args().skip(1).collect();
    // rust: let game_args = args.iter().take_while(|a| *a != "--dedicated");
    // rust: let help = game_args
    // rust: .clone()
    // rust: .any(|a| a == "--help" || a == "-h" || a == "--launch-api");
    // --home before the log opens in it.
    // rust: if let Some(dir) = game_args.clone().skip_while(|a| *a != "--home").nth(1) {
    // rust: logging::set_game_home(std::path::absolute(dir).unwrap_or_else(|_| dir.into()));
}
    // The dedicated server logs in its own folder (--game-dir's), as vanilla's does; the game in its home.
    // rust: let (home, side, thread) = if args.iter().any(|a| a == "--dedicated") {
    // rust: let folder = game_args
    // rust: .clone()
    // rust: .skip_while(|a| *a != "--game-dir" && *a != "--gameDir")
    // rust: .nth(1)
    // rust: .and_then(|dir| std::path::absolute(dir).ok())
    // rust: .unwrap_or_else(|| ".".into());
    // rust: (folder, "server", "Server thread")
    // rust: } else {
        // --player-dir too (a game's, not a server's): a player of a shared game folder keeps
        // its log and crash reports in its own; crash telemetry stays with the home's consent.
    // rust: if let Some(dir) = game_args
    // rust: .clone()
    // rust: .skip_while(|a| *a != "--player-dir")
    // rust: .nth(1)
    // rust: {
    // rust: logging::set_player_dir(std::path::absolute(dir).unwrap_or_else(|_| dir.into()));
}
    // rust: (logging::game_home(), "client", "Render thread")
}
    // rust: if !help {
    // rust: logging::init(
    // rust: logging::player_dir_override().unwrap_or(home.as_path()),
    // rust: thread,
    // rust: );
        // The log's first line names the build, so a bug report that carries the log says which one it was.
    // rust: log::info!("Horizon {}", crash::version());
    // rust: crash::install(home.clone(), side);
}
    // rust: let renderers = crate::mod_api::mods()
    // rust: .iter()
    // rust: .filter_map(|m| m.render())
    // rust: .collect();
    // rust: if crate::gfx::native_render::install(renderers).is_err() {
    // rust: log::warn!("Trait renderers already installed; keeping the first list");
}
    // rust: if horizon_world::native_load_hooks::install(
    // rust: horizon_world::native_load_hooks::NativeLoadHooks {
    // rust: loot_table_load: |id, table| {
    // rust: crate::mod_api::dispatch_loot_table_load(crate::mod_api::mods(), id, table);
    // rust: },
    // rust: modify_default_components: |item, components| {
    // rust: crate::mod_api::dispatch_modify_default_components(
    // rust: crate::mod_api::mods(),
    // rust: item,
    // rust: components,
    // rust: );
    // rust: },
    // rust: loot_function: |kind, data, ctx, stack| {
    // rust: crate::mod_api::dispatch_loot_function(
    // rust: crate::mod_api::mods(),
    // rust: kind,
    // rust: data,
    // rust: ctx,
    // rust: stack,
    // rust: );
    // rust: },
    // rust: loot_condition: |kind, data, ctx, holds| {
    // rust: crate::mod_api::dispatch_loot_condition(
    // rust: crate::mod_api::mods(),
    // rust: kind,
    // rust: data,
    // rust: ctx,
    // rust: holds,
    // rust: );
    // rust: },
    // rust: },
    // rust: )
    // rust: .is_err()
    // rust: {
    // rust: log::warn!("Native data-load hooks already installed; keeping the first callbacks");
}
    // rust: if crate::native_client_hooks::install(crate::native_client_hooks::NativeClientHooks {
    // rust: menu_slot_rules: |menu, slot, stack, may_place, max_stack| {
    // rust: crate::mod_api::dispatch_menu_slot_rules(
    // rust: crate::mod_api::mods(),
    // rust: menu,
    // rust: slot,
    // rust: stack,
    // rust: may_place,
    // rust: max_stack,
    // rust: );
    // rust: },
    // rust: player_chat: |player, name, message, replies, cancel| {
    // rust: crate::mod_api::dispatch_player_chat(
    // rust: crate::mod_api::mods(),
    // rust: player,
    // rust: name,
    // rust: message,
    // rust: replies,
    // rust: cancel,
    // rust: );
    // rust: },
    // rust: living_heal: |entity, amount, cancel| {
    // rust: crate::mod_api::dispatch_living_heal(crate::mod_api::mods(), entity, amount, cancel);
    // rust: },
    // rust: living_breathe: |entity, kind, can_breathe, consume, refill| {
    // rust: crate::mod_api::dispatch_living_breathe(
    // rust: crate::mod_api::mods(),
    // rust: entity,
    // rust: kind,
    // rust: can_breathe,
    // rust: consume,
    // rust: refill,
    // rust: );
    // rust: },
    // rust: living_drown: |entity, kind, is_drowning, damage_amount, bubble_count, cancel| {
    // rust: crate::mod_api::dispatch_living_drown(
    // rust: crate::mod_api::mods(),
    // rust: entity,
    // rust: kind,
    // rust: is_drowning,
    // rust: damage_amount,
    // rust: bubble_count,
    // rust: cancel,
    // rust: );
    // rust: },
    // rust: living_fall: |entity, kind, distance, multiplier, cancel| {
    // rust: crate::mod_api::dispatch_living_fall(
    // rust: crate::mod_api::mods(),
    // rust: entity,
    // rust: kind,
    // rust: distance,
    // rust: multiplier,
    // rust: cancel,
    // rust: );
    // rust: },
    // rust: living_jump: |entity, kind| {
    // rust: crate::mod_api::dispatch_living_jump(crate::mod_api::mods(), entity, kind);
    // rust: },
    // rust: register_goals: |mob| {
    // rust: crate::mod_api::dispatch_register_goals(crate::mod_api::mods(), mob);
    // rust: },
    // rust: ingredient: |kind, data, items| {
    // rust: crate::mod_api::dispatch_ingredient(crate::mod_api::mods(), kind, data, items);
    // rust: },
    // rust: ingredient_test: |kind, data, stack, accept| {
    // rust: crate::mod_api::dispatch_ingredient_test(
    // rust: crate::mod_api::mods(),
    // rust: kind,
    // rust: data,
    // rust: stack,
    // rust: accept,
    // rust: );
    // rust: },
    // rust: })
    // rust: .is_err()
    // rust: {
    // rust: log::warn!("Native client hooks already installed; keeping the first callbacks");
}
    // rust: raise_open_file_limit();
    // rust: if let Err(error) = game::run_with() {
        // A bad command line is the caller's mistake, not a crash: no report.
    // rust: let usage = error.is::<game::UsageError>();
    // rust: log::error!("Horizon: {error}");
    // rust: logging::flush();
        // The report's path is the last line on stderr (crash::SAVED_LINE).
    // rust: if !help && !usage {
    // rust: crash::report_error(&home, side, &*error);
}
        // Started from Explorer, the console window closes with the game:
        // keep the message on screen until it is read.
    // rust: if std::io::IsTerminal::is_terminal(&std::io::stdin()) {
    // rust: eprintln!("Press Enter to close.");
    // rust: let _ = std::io::stdin().read_line(&mut String::new());
}
    // rust: std::process::exit(if usage {
    // rust: game::exit_code::USAGE
    // rust: } else {
    // rust: game::exit_code::ERROR
    // rust: });
}
    // rust: logging::flush();
}

/// The JVM raises its open-file limit to the hard limit as it starts
/// (`-XX:+MaxFDLimit`, on by default), so a vanilla server may hold as many
/// sockets and region files as the host allows, not the soft default (often
/// 1024 in a container). The same here; macOS caps it at `OPEN_MAX`, as the
/// JVM does there.
pub fn raise_open_file_limit() void {
}
    // rust: {
//         use rustix::process::{Resource, Rlimit, getrlimit, setrlimit};
    // rust: let limit = getrlimit(Resource::Nofile);
    // rust: let hard = if cfg!(target_os = "macos") {
    // rust: Some(limit.maximum.map_or(10_240, |h| h.min(10_240)))
    // rust: } else {
    // rust: limit.maximum
}
    // rust: let raised = match (limit.current, hard) {
    // rust: (Some(soft), Some(hard)) => hard > soft,
    // rust: (Some(_), None) => true,
    // rust: (None, _) => false,
}
    // rust: if raised {
    // rust: let to = Rlimit {
    // rust: current: hard,
    // rust: maximum: limit.maximum,
}
    // rust: match setrlimit(Resource::Nofile, to) {
    // rust: Ok(()) => log::info!(
    // rust: "Open file limit raised from {:?} to {hard:?}",
    // rust: limit.current
    // rust: ),
    // rust: Err(e) => log::warn!("Open file limit stays at {:?}: {e}", limit.current),
}
}
}
}
