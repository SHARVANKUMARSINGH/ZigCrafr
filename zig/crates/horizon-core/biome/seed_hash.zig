//! Transpiled from Horizon Rust crate
//! Module: horizon-core_seed_hash
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

// SHA-256 specialized to one eight-byte input. This is a world-seed compatibility
// transform, not a general-purpose cryptography interface.
    // rust: const K: [u32; 64] = [
    // rust: 0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
    // rust: 0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3, 0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
    // rust: 0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc, 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
    // rust: 0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
    // rust: 0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13, 0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
    // rust: 0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
    // rust: 0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
    // rust: 0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208, 0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2,
    // rust: ];
    // rust: pub(super) fn hash(seed: i64) -> i64 {
    // rust: let bytes = seed.to_le_bytes();
    // rust: let mut words = [0_u32; 64];
    // rust: words[0] = u32::from_be_bytes(bytes[..4].try_into().unwrap());
    // rust: words[1] = u32::from_be_bytes(bytes[4..].try_into().unwrap());
    // rust: words[2] = 0x80000000;
    // rust: words[15] = 64;
    // rust: for i in 16..64 {
    // rust: let a = words[i - 15];
    // rust: let b = words[i - 2];
    // rust: let small0 = a.rotate_right(7) ^ a.rotate_right(18) ^ (a >> 3);
    // rust: let small1 = b.rotate_right(17) ^ b.rotate_right(19) ^ (b >> 10);
    // rust: words[i] = words[i - 16]
    // rust: .wrapping_add(small0)
    // rust: .wrapping_add(words[i - 7])
    // rust: .wrapping_add(small1);
}
    // rust: let initial = [
    // rust: 0x6a09e667_u32,
    // rust: 0xbb67ae85,
    // rust: 0x3c6ef372,
    // rust: 0xa54ff53a,
    // rust: 0x510e527f,
    // rust: 0x9b05688c,
    // rust: 0x1f83d9ab,
    // rust: 0x5be0cd19,
    // rust: ];
    // rust: let [mut a, mut b, mut c, mut d, mut e, mut f, mut g, mut h] = initial;
    // rust: for i in 0..64 {
    // rust: let sum1 = e.rotate_right(6) ^ e.rotate_right(11) ^ e.rotate_right(25);
    // rust: let choice = (e & f) ^ (!e & g);
    // rust: let t1 = h
    // rust: .wrapping_add(sum1)
    // rust: .wrapping_add(choice)
    // rust: .wrapping_add(K[i])
    // rust: .wrapping_add(words[i]);
    // rust: let sum0 = a.rotate_right(2) ^ a.rotate_right(13) ^ a.rotate_right(22);
    // rust: let majority = (a & b) ^ (a & c) ^ (b & c);
    // rust: let t2 = sum0.wrapping_add(majority);
    // rust: h = g;
    // rust: g = f;
    // rust: f = e;
    // rust: e = d.wrapping_add(t1);
    // rust: d = c;
    // rust: c = b;
    // rust: b = a;
    // rust: a = t1.wrapping_add(t2);
}
    // rust: let first = a.wrapping_add(initial[0]).to_be_bytes();
    // rust: let second = b.wrapping_add(initial[1]).to_be_bytes();
    // rust: i64::from_le_bytes([
    // rust: first[0], first[1], first[2], first[3], second[0], second[1], second[2], second[3],
    // rust: ])
}
