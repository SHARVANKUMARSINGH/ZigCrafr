//! Transpiled from Horizon Rust crate
//! Module: horizon-optifine_fusion
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Fusion's resource pack format (the Fusion Connected Textures mod): a `fusion` section in a
//! texture's `.mcmeta` ([`texture`]: connecting, random, continuous and scrolling textures, and
//! the emissive, render type and tinting options every type takes), the connection predicates
//! that say when a connecting texture joins a neighbour ([`predicate`]), the `connections` of a
//! `fusion:connecting` block model ([`model`]), and which tiles of a connecting texture's image a
//! face draws ([`layout`]).
//!
//! The layouts read the neighbour masks of [`crate::ctm::connect`], which OptiFine's connected
//! textures build too: the two formats share how a face finds its neighbours.
//!
//! Written from Fusion's public wiki (its texture type, model type and model predicate pages)
//! and the MIT-licensed layout templates of SuperMartijn642/FusionExamples, read off the images.
//! Fusion itself is all rights reserved: none of its code was read.

    // rust: pub mod layout;
    // rust: pub mod model;
    // rust: pub mod predicate;
    // rust: pub mod texture;

    // rust: pub use layout::{Layout, Tiles};
    // rust: pub use predicate::Connection;
    // rust: pub use texture::Meta;

// use crate::cem::json::Json;

/// A type name without the `fusion:` namespace packs may give it (`fusion:connecting`).
pub fn kind(name: []const u8) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: name.strip_prefix("fusion:").unwrap_or(name)
}

pub fn bool_field(json: *Json, key: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match json.get(key) {
    // rust: None => Ok(None),
    // rust: Some(Json::Bool(b)) => Ok(Some(*b)),
    // rust: Some(_) => Err(format!("`{key}` is not true or false")),
}
}

    // rust: fn str_field<'a>(json: &'a Json, key: &str) -> Result<Option<&'a str>, String> {
    // rust: match json.get(key) {
    // rust: None => Ok(None),
    // rust: Some(Json::Str(s)) => Ok(Some(s)),
    // rust: Some(_) => Err(format!("`{key}` is not a string")),
}
}

/// An integer field, which must be in `range`.
    // rust: fn int_field(
    // rust: json: &Json,
    // rust: key: &str,
    // rust: range: std::ops::RangeInclusive<i64>,
    // rust: ) -> Result<Option<i64>, String> {
    // rust: match json.get(key) {
    // rust: None => Ok(None),
    // rust: Some(Json::Num(n)) if n.fract() == 0.0 && range.contains(&(*n as i64)) => {
    // rust: Ok(Some(*n as i64))
}
    // rust: Some(_) => Err(format!(
    // rust: "`{key}` is not an integer from {} to {}",
    // rust: range.start(),
    // rust: range.end()
    // rust: )),
}
}
