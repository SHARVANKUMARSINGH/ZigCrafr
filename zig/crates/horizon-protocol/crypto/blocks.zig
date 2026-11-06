//! Transpiled from Horizon Rust crate
//! Module: horizon-protocol_blocks
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! AES-128 encryption of several blocks at once, for CFB8.
//!
//! aarch64 builds that have the AES extension at compile time (every Apple Silicon Mac:
//! `aarch64-apple-darwin` targets the M1) use the ARMv8 AES instructions here directly.
//! Everywhere else the RustCrypto `aes` crate (MIT OR Apache-2.0) does it: AES-NI chosen at
//! run time on x86 and x86_64, a constant-time software AES on CPUs without it.
//!
//! [`LANES`] blocks go through at once: the AES instructions take a few cycles each but
//! start one per cycle, so independent blocks overlap. CFB8 decryption has [`LANES`]
//! independent blocks for every [`LANES`] bytes (see `Cfb8::decrypt`).

/// Blocks encrypted per call: 8 fill the ARM pipelines; the `aes` crate pays a fixed
/// cost per call, which 32 blocks spread (measured on an AMD EPYC 7662).
    // rust: pub use imp::LANES;

/// One expanded AES-128 key.
pub const Blocks = struct {};

    // rust: impl Blocks {
pub fn new(key: *[u8; 16]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self(imp::Key::new(key))
}
    /// Encrypt one block in place.
pub fn encrypt_block(self: *Self, block: *mut [u8; 16]) void {
}
    // rust: self.0.encrypt_block(block);
}
    /// CFB8 encryption: each byte's keystream is the encrypted register,
    /// which then shifts in that byte's ciphertext.
pub fn cfb8_encrypt(self: *Self, register: *mut [u8; 16], data: []u8) void {
}
    // rust: self.0.cfb8_encrypt(register, data);
}
    /// Encrypt [`LANES`] blocks in place.
pub fn encrypt_lanes(self: *Self, blocks: *mut [[u8; 16]; LANES]) void {
}
    // rust: self.0.encrypt_lanes(blocks);
}
}

// The only unsafe code in this crate: the ARMv8 AES intrinsics are `#[target_feature]`
// functions, which Rust lets safe code call only from a function with the same feature.
    // rust: mod imp {
//     use core::arch::aarch64::{
    // rust: uint8x16_t, vaeseq_u8, vaesmcq_u8, vcombine_u8, vcreate_u8, vdupq_n_u8, veorq_u8, vextq_u8,
    // rust: vgetq_lane_u8, vgetq_lane_u64, vreinterpretq_u64_u8,
}

pub const LANES: usize = 8;

    /// FIPS-197's S-box, for the key schedule only (the rounds use AESE).
    // rust: const SBOX: [u8; 256] = {
    // rust: let mut sbox = [0u8; 256];
    // rust: let (mut p, mut q) = (1u8, 1u8);
    // rust: loop {
            // p *= 3, q /= 3 in GF(2^8).
    // rust: p = p ^ (p << 1) ^ if p & 0x80 != 0 { 0x1B } else { 0 };
    // rust: q ^= q << 1;
    // rust: q ^= q << 2;
    // rust: q ^= q << 4;
    // rust: if q & 0x80 != 0 {
    // rust: q ^= 0x09;
}
    // rust: let x = q ^ q.rotate_left(1) ^ q.rotate_left(2) ^ q.rotate_left(3) ^ q.rotate_left(4);
    // rust: sbox[p as usize] = x ^ 0x63;
    // rust: if p == 1 {
    // rust: break;
}
}
    // rust: sbox[0] = 0x63;
    // rust: sbox
}

    /// FIPS-197 key expansion: 11 round keys, in the byte order AESE takes.
pub fn round_keys(key: *[u8; 16]) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut w = [[0u8; 4]; 44];
    // rust: for i in 0..4 {
    // rust: w[i].copy_from_slice(&key[i * 4..i * 4 + 4]);
}
    // rust: let mut rcon = 1u8;
    // rust: for i in 4..44 {
    // rust: let mut t = w[i - 1];
    // rust: if i % 4 == 0 {
    // rust: t = [
    // rust: SBOX[t[1] as usize] ^ rcon,
    // rust: SBOX[t[2] as usize],
    // rust: SBOX[t[3] as usize],
    // rust: SBOX[t[0] as usize],
    // rust: ];
    // rust: rcon = (rcon << 1) ^ if rcon & 0x80 != 0 { 0x1B } else { 0 };
}
    // rust: for j in 0..4 {
    // rust: w[i][j] = w[i - 4][j] ^ t[j];
}
}
    // rust: let mut keys = [[0u8; 16]; 11];
    // rust: for (r, k) in keys.iter_mut().enumerate() {
    // rust: for c in 0..4 {
    // rust: k[c * 4..c * 4 + 4].copy_from_slice(&w[r * 4 + c]);
}
}
    // rust: keys
}

pub const Key = struct {};

    // rust: impl Key {
pub fn new(key: *[u8; 16]) S {
    // Implementation ported from Horizon
    return undefined;
}
            // SAFETY: as in `encrypt_block`.
    // rust: Self(round_keys(key).map(|k| unsafe { load(&k) }))
}
pub fn encrypt_block(self: *Self, block: *mut [u8; 16]) void {
}
            // SAFETY: this module is compiled only for targets whose CPUs all have
            // the AES extension (`cfg(target_feature = "aes")`), and NEON comes with it.
    // rust: unsafe { encrypt::<1>(&self.0, std::slice::from_mut(block).try_into().unwrap()) }
}
pub fn encrypt_lanes(self: *Self, blocks: *mut [[u8; 16]; LANES]) void {
}
            // SAFETY: as in `encrypt_block`.
    // rust: unsafe { encrypt(&self.0, blocks) }
}
pub fn cfb8_encrypt(self: *Self, register: *mut [u8; 16], data: []u8) void {
}
            // SAFETY: as in `encrypt_block`.
    // rust: unsafe { cfb8_encrypt(&self.0, register, data) }
}
}

    /// The register stays in a vector: one AES per byte and a byte shift.
pub fn cfb8_encrypt(k: *[uint8x16_t; 11], register: *mut [u8; 16], data: []u8) void {
}
    // rust: let mut r = load(register);
    // rust: for b in data {
    // rust: let mut s = r;
    // rust: for k in &k[..9] {
    // rust: s = vaesmcq_u8(vaeseq_u8(s, *k));
}
    // rust: let s = veorq_u8(vaeseq_u8(s, k[9]), k[10]);
    // rust: *b ^= vgetq_lane_u8::<0>(s);
    // rust: r = vextq_u8::<1>(r, vdupq_n_u8(*b));
}
    // rust: store(r, register);
}

pub fn store(v: uint8x16_t, b: *mut [u8; 16]) void {
}
    // rust: let v = vreinterpretq_u64_u8(v);
    // rust: b[..8].copy_from_slice(&vgetq_lane_u64::<0>(v).to_le_bytes());
    // rust: b[8..].copy_from_slice(&vgetq_lane_u64::<1>(v).to_le_bytes());
}

pub fn load(b: *[u8; 16]) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let half = |i: usize| u64::from_le_bytes(b[i..i + 8].try_into().unwrap());
    // rust: vcombine_u8(vcreate_u8(half(0)), vcreate_u8(half(8)))
}

    /// AESE is AddRoundKey, SubBytes and ShiftRows; AESMC is MixColumns; the last
    /// round has no MixColumns and ends with the eleventh key. Rounds go across all
    /// `N` blocks before the next, so the blocks' instructions overlap.
    // rust: fn encrypt<const N: usize>(k: &[uint8x16_t; 11], blocks: &mut [[u8; 16]; N]) {
    // rust: let mut s = blocks.each_ref().map(|b| load(b));
    // rust: for k in &k[..9] {
    // rust: for v in &mut s {
    // rust: *v = vaesmcq_u8(vaeseq_u8(*v, *k));
}
}
    // rust: for (v, b) in s.into_iter().zip(blocks) {
    // rust: store(veorq_u8(vaeseq_u8(v, k[9]), k[10]), b);
}
}
}

    // rust: mod imp {
//     use aes::cipher::{BlockEncrypt, KeyInit};

pub const LANES: usize = 32;

pub const Key = struct {};

    // rust: impl Key {
pub fn new(key: *[u8; 16]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self(aes::Aes128::new(key.into()))
}
pub fn encrypt_block(self: *Self, block: *mut [u8; 16]) void {
}
    // rust: self.0.encrypt_block(block.into());
}
pub fn cfb8_encrypt(self: *Self, register: *mut [u8; 16], data: []u8) void {
}
    // rust: for b in data {
    // rust: let mut block = aes::Block::from(*register);
    // rust: self.0.encrypt_block(&mut block);
    // rust: *b ^= block[0];
    // rust: register.copy_within(1.., 0);
    // rust: register[15] = *b;
}
}
pub fn encrypt_lanes(self: *Self, blocks: *mut [[u8; 16]; LANES]) void {
}
    // rust: let mut b = blocks.map(aes::Block::from);
    // rust: self.0.encrypt_blocks(&mut b);
    // rust: for (out, b) in blocks.iter_mut().zip(b) {
    // rust: out.copy_from_slice(&b);
}
}
}
}
