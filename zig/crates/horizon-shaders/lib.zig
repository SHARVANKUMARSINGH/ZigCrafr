//! Transpiled from Horizon Rust crate
//! Module: horizon-shaders_lib
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Shader packs: the `shaderpacks/*.zip` format, written from Horizon's clean-room specification
//! (`shader-packs-spec.md`, revision 1). This crate reads the format and knows nothing of wgpu;
//! the game's renderer runs what it produces.
//!
//! - [`Pack`]: a pack as a folder or a zip, with paths relative to its `shaders` folder (spec 1.1).
//! - [`discover`]: the packs in a `shaderpacks` folder.
//! - [`Properties`]: `shaders.properties` and the id files, with their conditional directives (3.1, 1.5).
//! - [`Lang`]: the pack's translated names (8.4).
//! - [`options`], [`Screens`]: the options the player can change, and how the pack lays them out
//!   on its screens (8.1 to 8.3); [`Pack::with_chosen`] runs the pack with the player's values.
//! - [`preprocess`]: a stage file through `#include` and the GLSL preprocessor, lines mapped back (1.4, 1.5).
//! - [`translate_composite`], [`translate_gbuffers`], [`translate_shadow`]: a program into naga modules and its interface (1.6, 2.2).
//! - [`translate_core`]: a resource pack's vanilla core shader (`shaders/core/`) into naga modules.
//! - [`Config`] and [`draw_buffers`]: the buffer settings and output lists stage files carry (1.7, 6.1).
//! - [`load_post`]: a dimension's `prepare`, `deferred`, `composite` and `final` programs, in order (2.1).
//! - [`load_textures`]: the custom textures `texture.*` and `customTexture.*` name (3.4).
//! - [`Macros`] and [`eval_condition`]: the macros packs test, and the `#if` arithmetic (1.5).

    // rust: mod biomes;
    // rust: mod block_ids;
    // rust: mod condition;
    // rust: mod config;
    // rust: mod core_shader;
    // rust: mod custom;
    // rust: mod discover;
    // rust: mod lang;
    // rust: mod macros;
    // rust: mod options;
    // rust: mod pack;
    // rust: mod post;
    // rust: mod preprocess;
    // rust: mod properties;
    // rust: mod screens;
    // rust: mod textures;
    // rust: mod translate;

    // rust: pub use biomes::{
    // rust: category as biome_category, pack_id as biome_pack_id, precipitation as biome_precipitation,
}
    // rust: pub use block_ids::BlockIds;
    // rust: pub use condition::eval_condition;
    // rust: pub use config::{
    // rust: BUFFERS, Buffer, Config, Format, Kind, SHADOW_COLORS, Shadow, buffer_index, draw_buffers,
    // rust: shadow_color,
}
    // rust: pub use core_shader::{BLOCKS, CoreProgram, Glue, SAMPLERS, translate_core};
    // rust: pub use custom::{Custom, Val};
    // rust: pub use discover::{Found, discover};
    // rust: pub use lang::Lang;
    // rust: pub use macros::{MC_VERSION, Macros, RENDER_STAGES, render_stage};
    // rust: pub use options::{
    // rust: PackOption, apply as apply_options, chosen_file, chosen_text, options, parse_chosen,
    // rust: properties_macros, read_properties, switches_on, value_options, with_options,
}
    // rust: pub use pack::{Pack, PackError};
    // rust: pub use post::{
    // rust: Blend, BufferObject, BufferSize, CELESTIAL_BLEND, CustomImage, Factor, GameInputs, Group,
    // rust: ImageSize, Post, PostProgram, ShadowCulling, TRANSLUCENT_BLEND, dimension_folder,
    // rust: dimension_folder_named, load_post,
}
    // rust: pub use preprocess::{Diagnostic, Origin, Preprocessed, preprocess};
    // rust: pub use properties::{Entry, Note, Properties};
    // rust: pub use screens::{Item as ScreenItem, Screens};
    // rust: pub use textures::{
    // rust: CustomTexture, Dim as TextureDim, EVERY_STAGE, Texels, Texture, TextureSource, decode_png,
    // rust: load_textures, resolve_resources,
}
    // rust: pub use translate::{
    // rust: AlphaTest, ComputeProgram, DRAW_UNIFORMS, Error, GbuffersInputs, GeometryInputs, Image,
    // rust: Interface, Program, Sampler, Target, Uniform, translate_composite, translate_compute,
    // rust: translate_gbuffers, translate_geometry, translate_shadow,
}
