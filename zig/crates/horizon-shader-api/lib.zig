//! Transpiled from Horizon Rust crate
//! Module: horizon-shader-api_lib
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Horizon's own shader packs (docs/api/shaders.md): WGSL written against
//! the renderer's stages, described by `horizon-shaders.toml` and shipped as
//! a folder or a `.hshader`. This crate reads and checks packs; the game, the
//! launcher and the registry all use it, so a pack is judged the same way
//! everywhere.
    // rust: pub mod check;
    // rust: pub mod inputs;
    // rust: pub mod manifest;
    // rust: pub mod package;
    // rust: pub mod reference;
    // rust: pub mod stages;

    // rust: pub use check::{Problem, Report, check};
    // rust: pub use inputs::Frame;
    // rust: pub use manifest::{
    // rust: API, Api, Blend, LightColor, MANIFEST, Manifest, Material, OptionKind, OptionPage, PackOption,
    // rust: PackTexture, PageItem, SCHEMA, SpriteTag, Stage,
}
    // rust: pub use package::{EXTENSION, Pack};
    // rust: pub use stages::{Composed, StageKind, compose};
