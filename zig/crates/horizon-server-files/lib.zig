//! Transpiled from Horizon Rust crate
//! Module: horizon-server-files_lib
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The dedicated server's files and settings, ported from
//! net.minecraft.server.dedicated and net.minecraft.server.players:
//! server.properties, eula.txt, the four user lists, usercache.json and
//! looking players up by name. The game's dedicated server
//! (`horizon-client --dedicated`) reads them, and `horizon-server` manages
//! them; this crate needs neither a window nor the game.
    // rust: pub mod eula;
    // rust: pub mod java_properties;
    // rust: pub mod json;
    // rust: pub mod private_file;
    // rust: pub mod profiles;
    // rust: pub mod properties;
    // rust: pub mod user_cache;
    // rust: pub mod user_lists;
