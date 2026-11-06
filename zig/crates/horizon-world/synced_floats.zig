//! Transpiled from Horizon Rust crate
//! Module: horizon-world_synced_floats
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Synchronized float storage using boxed Java Float equality.
//! The scalar implementation also supports bytes; full entity schemas and
//! heterogeneous serializer storage remain separate.
    // rust: pub use crate::synced_values::{DataError, Observer};
    // rust: pub type FloatValue = crate::synced_values::DataValue<f32>;
    // rust: pub type SyncedFloats = crate::synced_values::SyncedValues<f32>;
