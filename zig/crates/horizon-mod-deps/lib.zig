//! Transpiled from Horizon Rust crate
//! Module: horizon-mod-deps_lib
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Holds no code. The optional dependencies in `Cargo.toml` keep the registry crates native mods may
//! name in `Cargo.lock` (docs/native-mods.md, "Dependencies come from Horizon's `Cargo.lock`").
