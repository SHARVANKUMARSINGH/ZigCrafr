//! Transpiled from Horizon Rust crate
//! Module: horizon-world_long_set
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Iteration order of fastutil's `LongOpenHashSet`, which vanilla uses for
//! structure references. Placing a structure's pieces consumes one shared
//! random stream, so starts must be visited in the set's order.

pub const PHI: i64 = 0x9E37_79B9_7F4A_7C15_u64 as i64;
pub const LOAD_FACTOR: f64 = 0.75;

pub fn mix(key: i64) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut h = key.wrapping_mul(PHI);
    // rust: h ^= ((h as u64) >> 32) as i64;
    // rust: (h ^ (((h as u64) >> 16) as i64)) as i32 as u32 as usize
}

pub fn array_size(expected: usize) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ((expected as f64 / LOAD_FACTOR).ceil() as usize)
    // rust: .next_power_of_two()
    // rust: .max(2)
}

pub fn max_fill(n: usize) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ((n as f64 * LOAD_FACTOR).ceil() as usize).min(n - 1)
}

/// Indices of `keys` (distinct, in insertion order) in the order a default
/// `LongOpenHashSet` holding them iterates: the zero key first, then the table
/// from its last slot down to its first.
pub fn iteration_order(keys: *[i64]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut n = array_size(16);
    // rust: let mut table: Vec<Option<usize>> = vec![None; n];
    // rust: let mut contains_zero = None;
    // rust: let mut size = 0;
    // rust: for (index, &key) in keys.iter().enumerate() {
    // rust: if key == 0 {
    // rust: contains_zero = Some(index);
    // rust: } else {
    // rust: let mask = n - 1;
    // rust: let mut pos = mix(key) & mask;
    // rust: while table[pos].is_some() {
    // rust: pos = (pos + 1) & mask;
}
    // rust: table[pos] = Some(index);
}
    // rust: size += 1;
    // rust: if size > max_fill(n) {
    // rust: let new_n = array_size(size + 1);
    // rust: let mut grown: Vec<Option<usize>> = vec![None; new_n];
    // rust: for slot in table.iter().rev().flatten() {
    // rust: let mask = new_n - 1;
    // rust: let mut pos = mix(keys[*slot]) & mask;
    // rust: while grown[pos].is_some() {
    // rust: pos = (pos + 1) & mask;
}
    // rust: grown[pos] = Some(*slot);
}
    // rust: table = grown;
    // rust: n = new_n;
}
}
    // rust: contains_zero
    // rust: .into_iter()
    // rust: .chain(table.iter().rev().flatten().copied())
    // rust: .collect()
}

    // rust: mod tests {
//     use super::*;

pub fn single_and_zero_keys() void {
}
    // rust: assert_eq!(iteration_order(&[]), Vec::<usize>::new());
    // rust: assert_eq!(iteration_order(&[5]), vec![0]);
    // rust: assert_eq!(iteration_order(&[7, 0]), vec![1, 0]);
}

pub fn every_key_is_visited_once_after_growth() void {
}
    // rust: let keys: Vec<i64> = (0..100).map(|i| i * 4_294_967_297 + 3).collect();
    // rust: let mut order = iteration_order(&keys);
    // rust: order.sort_unstable();
    // rust: assert_eq!(order, (0..100).collect::<Vec<_>>());
}
}
