//! Transpiled from Horizon Rust crate
package horizon_protocol_rsa

import "core:fmt"
import "core:mem"
import "core:math"

// RSA for the online-mode login: the server's X.509 public key
// (Crypt.byteToPublicKey) and PKCS#1 v1.5 encryption of the shared secret
// and challenge (Crypt.encryptUsingKey, Java's "RSA" cipher =
// RSA/ECB/PKCS1Padding), and on the server's side the key pair it makes at
// startup (Crypt.generateKeyPair: 1024 bits) and the decryption
// (Crypt.decryptUsingKey); and the PKCS#1 v1.5 signature checks of secure
// chat (SHA256withRSA for messages, SHA1withRSA for the services' profile
// key signatures). Modular exponentiation uses Montgomery multiplication on
// 32-bit limbs; RSA moduli are always odd.
// use crate::{Error, Result};

// A non-negative integer, little-endian 32-bit limbs.
Big :: struct {

    // rust: impl Big {
from_be_bytes :: proc(bytes: []u8, limbs: uint) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut v = vec![0u32; limbs];
    // rust: for (i, b) in bytes.iter().rev().enumerate() {
    // rust: if *b != 0 {
    // rust: v[i / 4] |= u32::from(*b) << (8 * (i % 4));
}
}
    // rust: Self(v)
}
to_be_bytes :: proc(self: ^Self, len: uint) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = vec![0u8; len];
    // rust: for i in 0..len.min(self.0.len() * 4) {
    // rust: out[len - 1 - i] = (self.0[i / 4] >> (8 * (i % 4))) as u8;
}
    // rust: out
}
bits :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.0
    // rust: .iter()
    // rust: .rposition(|&l| l != 0)
    // rust: .map_or(0, |i| i * 32 + 32 - self.0[i].leading_zeros() as usize)
}
bit :: proc(self: ^Self, i: uint) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.0[i / 32] >> (i % 32) & 1 == 1
}
ge :: proc(self: ^Self, other: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: for (a, b) in self.0.iter().rev().zip(other.0.iter().rev()) {
    // rust: if a != b {
    // rust: return a > b;
}
}
    // rust: true
}
    // self · other, as many limbs as both together.
mul :: proc(self: ^Self, other: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = vec![0u32; self.0.len() + other.0.len()];
    // rust: for (i, &a) in self.0.iter().enumerate() {
    // rust: let mut carry = 0u64;
    // rust: for (j, &b) in other.0.iter().enumerate() {
    // rust: let t = u64::from(out[i + j]) + u64::from(a) * u64::from(b) + carry;
    // rust: out[i + j] = t as u32;
    // rust: carry = t >> 32;
}
    // rust: out[i + other.0.len()] = carry as u32;
}
    // rust: Self(out)
}
    // self · m + a, one limb longer.
mul_small_add :: proc(self: ^Self, m: u32, a: u32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::with_capacity(self.0.len() + 1);
    // rust: let mut carry = u64::from(a);
    // rust: for &l in &self.0 {
    // rust: let t = u64::from(l) * u64::from(m) + carry;
    // rust: out.push(t as u32);
    // rust: carry = t >> 32;
}
    // rust: out.push(carry as u32);
    // rust: Self(out)
}
    // (self / d, self mod d).
div_small :: proc(self: ^Self, d: u32) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = vec![0u32; self.0.len()];
    // rust: let mut rem = 0u64;
    // rust: for i in (0..self.0.len()).rev() {
    // rust: let t = rem << 32 | u64::from(self.0[i]);
    // rust: out[i] = (t / u64::from(d)) as u32;
    // rust: rem = t % u64::from(d);
}
    // rust: (Self(out), rem as u32)
}
is_one :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.0.first() == Some(&1) && self.0[1..].iter().all(|&l| l == 0)
}
sub_assign :: proc(self: ^Self, other: ^Self) {
}
    // rust: let mut borrow = 0i64;
    // rust: for (a, b) in self.0.iter_mut().zip(&other.0) {
    // rust: let d = i64::from(*a) - i64::from(*b) - borrow;
    // rust: borrow = i64::from(d < 0);
    // rust: *a = d.rem_euclid(1 << 32) as u32;
}
}
}

// Montgomery arithmetic modulo an odd `n`.
Mont :: struct {
    n: Big,
    // -n⁻¹ mod 2³².
    n0: u32,
    // R² mod n, R = 2^(32·limbs).
    r2: Big,
}

    // rust: impl Mont {
new :: proc(n: Big) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let k = n.0.len();
        // Newton's iteration for n⁻¹ mod 2³².
    // rust: let mut inv = 1u32;
    // rust: for _ in 0..5 {
    // rust: inv = inv.wrapping_mul(2u32.wrapping_sub(n.0[0].wrapping_mul(inv)));
}
        // R² mod n by doubling 1 2·32·k times.
    // rust: let mut r2 = Big(vec![0; k]);
    // rust: r2.0[0] = 1;
    // rust: for _ in 0..64 * k {
    // rust: let carry = r2.0[k - 1] >> 31;
    // rust: for i in (1..k).rev() {
    // rust: r2.0[i] = r2.0[i] << 1 | r2.0[i - 1] >> 31;
}
    // rust: r2.0[0] <<= 1;
    // rust: if carry == 1 || r2.ge(&n) {
    // rust: r2.sub_assign(&n);
}
}
    // rust: Self {
    // rust: n0: inv.wrapping_neg(),
    // rust: n,
    // rust: r2,
}
}
    // a·b·R⁻¹ mod n (CIOS).
mul :: proc(self: ^Self, a: ^Big, b: ^Big) -> B {
    // Ported from Horizon
    return {}
}
    // rust: let k = self.n.0.len();
    // rust: let mut t = vec![0u32; k + 2];
    // rust: for i in 0..k {
    // rust: let mut carry = 0u64;
    // rust: for j in 0..k {
    // rust: let s = u64::from(t[j]) + u64::from(a.0[j]) * u64::from(b.0[i]) + carry;
    // rust: t[j] = s as u32;
    // rust: carry = s >> 32;
}
    // rust: let s = u64::from(t[k]) + carry;
    // rust: t[k] = s as u32;
    // rust: t[k + 1] = (s >> 32) as u32;
    // rust: let m = t[0].wrapping_mul(self.n0);
    // rust: let mut carry = (u64::from(t[0]) + u64::from(m) * u64::from(self.n.0[0])) >> 32;
    // rust: for j in 1..k {
    // rust: let s = u64::from(t[j]) + u64::from(m) * u64::from(self.n.0[j]) + carry;
    // rust: t[j - 1] = s as u32;
    // rust: carry = s >> 32;
}
    // rust: let s = u64::from(t[k]) + carry;
    // rust: t[k - 1] = s as u32;
    // rust: t[k] = t[k + 1] + (s >> 32) as u32;
}
    // rust: let overflow = t[k] != 0;
    // rust: let mut r = Big(t[..k].to_vec());
    // rust: if overflow || r.ge(&self.n) {
    // rust: r.sub_assign(&self.n);
}
    // rust: r
}
    // base^exp mod n, base < n.
pow :: proc(self: ^Self, base: ^Big, exp: ^Big) -> B {
    // Ported from Horizon
    return {}
}
    // rust: let k = self.n.0.len();
    // rust: let mut one = Big(vec![0; k]);
    // rust: one.0[0] = 1;
    // rust: let b = self.mul(base, &self.r2);
    // rust: let mut x = self.mul(&one, &self.r2);
    // rust: for i in (0..exp.bits()).rev() {
    // rust: x = self.mul(&x, &x);
    // rust: if exp.bit(i) {
    // rust: x = self.mul(&x, &b);
}
}
    // rust: self.mul(&x, &one)
}
}

// A minimal DER reader: (tag, contents) of the element at the front.
der :: proc(input: []u8) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let bad = || Error::new("Malformed public key");
    // rust: let (&tag, rest) = input.split_first().ok_or_else(bad)?;
    // rust: let (&first, mut rest) = rest.split_first().ok_or_else(bad)?;
    // rust: let len = if first < 0x80 {
    // rust: usize::from(first)
    // rust: } else {
    // rust: let n = usize::from(first & 0x7f);
    // rust: if n == 0 || n > 4 || rest.len() < n {
    // rust: return Err(bad());
}
    // rust: let len = rest[..n]
    // rust: .iter()
    // rust: .fold(0usize, |l, b| l << 8 | usize::from(*b));
    // rust: rest = &rest[n..];
    // rust: len
}
    // rust: if rest.len() < len {
    // rust: return Err(bad());
}
    // rust: Ok((tag, &rest[..len], &rest[len..]))
}

// The DER of OID 1.2.840.113549.1.1.1 (rsaEncryption).
RSA_ENCRYPTION :: &[0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x01, 0x01, 0x01]

RsaPublicKey :: struct {
    // Modulus and exponent, big-endian without leading zeros.
    modulus: [dynamic]u8,
    exponent: [dynamic]u8,
}

strip :: proc(int: []u8) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let start = int.iter().position(|&b| b != 0).unwrap_or(int.len());
    // rust: int[start..].to_vec()
}

    // rust: impl RsaPublicKey {
    // X509EncodedKeySpec: SubjectPublicKeyInfo { AlgorithmIdentifier, BIT STRING RSAPublicKey }.
from_der :: proc(spki: []u8) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let bad = || Error::new("Malformed public key");
    // rust: let (tag, body, _) = der(spki)?;
    // rust: if tag != 0x30 {
    // rust: return Err(bad());
}
    // rust: let (tag, algorithm, rest) = der(body)?;
    // rust: let (oid_tag, oid, _) = der(algorithm)?;
    // rust: if tag != 0x30 || oid_tag != 0x06 || oid != RSA_ENCRYPTION {
    // rust: return Err(Error::new("Not an RSA public key"));
}
    // rust: let (tag, bits, _) = der(rest)?;
    // rust: if tag != 0x03 || bits.first() != Some(&0) {
    // rust: return Err(bad());
}
    // rust: let (tag, key, _) = der(&bits[1..])?;
    // rust: if tag != 0x30 {
    // rust: return Err(bad());
}
    // rust: let (n_tag, n, rest) = der(key)?;
    // rust: let (e_tag, e, _) = der(rest)?;
    // rust: if n_tag != 0x02 || e_tag != 0x02 {
    // rust: return Err(bad());
}
    // rust: let key = Self {
    // rust: modulus: strip(n),
    // rust: exponent: strip(e),
}
    // rust: if key.modulus.len() < 64 || key.modulus.last().is_none_or(|b| b & 1 == 0) {
    // rust: return Err(bad());
}
    // rust: Ok(key)
}
    // Length of the modulus in bytes (and of every ciphertext).
size :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.modulus.len()
}
    // The raw RSA operation m^e mod n on a `size()`-byte block.
apply :: proc(self: ^Self, block: []u8, exponent: []u8) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let limbs = self.size().div_ceil(4);
    // rust: let mont = Mont::new(Big::from_be_bytes(&self.modulus, limbs));
    // rust: let m = Big::from_be_bytes(block, limbs);
    // rust: mont.pow(
    // rust: &m,
    // rust: &Big::from_be_bytes(exponent, limbs.max(exponent.len().div_ceil(4))),
    // rust: )
    // rust: .to_be_bytes(self.size())
}
    // RSAES-PKCS1-v1_5 (RFC 8017 7.2.1) with random non-zero padding.
encrypt :: proc(self: ^Self, message: []u8) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let k = self.size();
    // rust: if message.len() + 11 > k {
    // rust: return Err(Error::new("Message too long for the RSA key"));
}
    // rust: let mut block = vec![0u8; k];
    // rust: block[1] = 2;
    // rust: let padding = &mut block[2..k - message.len() - 1];
    // rust: crate::crypto::random_bytes(padding)?;
    // rust: for b in padding.iter_mut() {
    // rust: while *b == 0 {
    // rust: let mut one = [0u8];
    // rust: crate::crypto::random_bytes(&mut one)?;
    // rust: *b = one[0];
}
}
    // rust: block[k - message.len()..].copy_from_slice(message);
    // rust: Ok(self.apply(&block, &self.exponent))
}
}

// The digest a PKCS#1 v1.5 signature covers: Java's `SHA1withRSA` and
// `SHA256withRSA`.
SignatureHash :: enum {
    Sha1,
    Sha256,
}

    // rust: impl SignatureHash {
    // The DER DigestInfo before the digest (RFC 8017 9.2, note 1).
prefix :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Sha1 => &[
    // rust: 0x30, 0x21, 0x30, 0x09, 0x06, 0x05, 0x2b, 0x0e, 0x03, 0x02, 0x1a, 0x05, 0x00, 0x04,
    // rust: 0x14,
    // rust: ],
    // rust: Self::Sha256 => &[
    // rust: 0x30, 0x31, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86, 0x48, 0x01, 0x65, 0x03, 0x04, 0x02,
    // rust: 0x01, 0x05, 0x00, 0x04, 0x20,
    // rust: ],
}
}
digest :: proc(self: ^Self, message: []u8) -> V {
    // Ported from Horizon
    return {}
}
//         use sha1::Digest;
    // rust: match self {
    // rust: Self::Sha1 => sha1::Sha1::digest(message).to_vec(),
    // rust: Self::Sha256 => sha2::Sha256::digest(message).to_vec(),
}
}
}

    // rust: impl RsaPublicKey {
    // `Signature.verify` for RSASSA-PKCS1-v1_5 (RFC 8017 8.2.2): the
    // signature is exactly the modulus' length and below it, and opens to
    // `00 01 FF.. 00 DigestInfo`. Anything else is a failed check, as
    // SignatureValidator reports Java's exceptions.
verify :: proc(self: ^Self, hash: SignatureHash, message: []u8, signature: []u8) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let k = self.size();
        // Equal lengths compare as big-endian numbers.
    // rust: if signature.len() != k || signature >= self.modulus.as_slice() {
    // rust: return false;
}
    // rust: emsa_pkcs1(hash, message, k)
    // rust: .is_some_and(|expected| self.apply(signature, &self.exponent) == expected)
}
}

// EMSA-PKCS1-v1_5 (RFC 8017 9.2): `00 01 FF.. 00 DigestInfo` for a
// `k`-byte modulus; None when the modulus is too short for the digest.
emsa_pkcs1 :: proc(hash: SignatureHash, message: []u8, k: uint) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let (prefix, digest) = (hash.prefix(), hash.digest(message));
    // rust: let t = prefix.len() + digest.len();
    // rust: if k < t + 11 {
    // rust: return None;
}
    // rust: let mut block = vec![0xff; k];
    // rust: block[0] = 0;
    // rust: block[1] = 1;
    // rust: block[k - t - 1] = 0;
    // rust: block[k - t..k - digest.len()].copy_from_slice(prefix);
    // rust: block[k - digest.len()..].copy_from_slice(&digest);
    // rust: Some(block)
}

// Small odd primes for sieving prime candidates.
    // rust: const SMALL_PRIMES: [u32; 53] = [
    // rust: 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97,
    // rust: 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193,
    // rust: 197, 199, 211, 223, 227, 229, 233, 239, 241, 251,
    // rust: ];
// Miller-Rabin rounds: a composite passes all of them with odds below 2⁻⁸⁰.
ROUNDS :: 40
E :: 65537

// A random odd number of `limbs` limbs with its two top bits set, so two of
// them multiply to exactly twice the bits.
candidate :: proc(limbs: uint) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut bytes = vec![0u8; limbs * 4];
    // rust: crate::crypto::random_bytes(&mut bytes)?;
    // rust: bytes[0] |= 0xC0;
    // rust: bytes[limbs * 4 - 1] |= 1;
    // rust: Ok(Big::from_be_bytes(&bytes, limbs))
}

// Miller-Rabin with random bases.
probably_prime :: proc(p: ^Big) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if SMALL_PRIMES.iter().any(|&q| p.div_small(q).1 == 0) {
    // rust: return Ok(false);
}
    // rust: let k = p.0.len();
    // rust: let mont = Mont::new(p.clone());
    // rust: let mut p_minus_one = p.clone();
    // rust: p_minus_one.0[0] -= 1; // p is odd
    // rust: let s = (0..k * 32).find(|&i| p_minus_one.bit(i)).unwrap_or(0);
    // d = (p - 1) >> s
    // rust: let mut d = Big(vec![0; k]);
    // rust: for i in 0..k * 32 - s {
    // rust: if p_minus_one.bit(i + s) {
    // rust: d.0[i / 32] |= 1 << (i % 32);
}
}
    // rust: let mut two = Big(vec![0; k]);
    // rust: two.0[0] = 2;
    // rust: 'rounds: for _ in 0..ROUNDS {
        // A random base in [2, p - 2].
    // rust: let mut a = candidate(k)?;
    // rust: a.0[k - 1] %= p.0[k - 1];
    // rust: if !a.ge(&two) || a.ge(&p_minus_one) {
    // rust: continue;
}
    // rust: let mut x = mont.pow(&a, &d);
    // rust: if x.is_one() || x == p_minus_one {
    // rust: continue;
}
    // rust: for _ in 1..s {
    // rust: x = mont.pow(&x, &two);
    // rust: if x == p_minus_one {
    // rust: continue 'rounds;
}
    // rust: if x.is_one() {
    // rust: return Ok(false);
}
}
    // rust: return Ok(false);
}
    // rust: Ok(true)
}

// A prime of `limbs` limbs whose p - 1 is prime to E.
prime :: proc(limbs: uint) -> R {
    // Ported from Horizon
    return {}
}
    // rust: loop {
    // rust: let p = candidate(limbs)?;
    // rust: if p.div_small(E).1 != 1 && probably_prime(&p)? {
    // rust: return Ok(p);
}
}
}

// DER: a tag and its length, then the contents.
    // rust: pub(crate) fn der_element(tag: u8, contents: &[u8]) -> Vec<u8> {
    // rust: let mut out = vec![tag];
    // rust: let len = contents.len();
    // rust: if len < 0x80 {
    // rust: out.push(len as u8);
    // rust: } else {
    // rust: let bytes: Vec<u8> = len
    // rust: .to_be_bytes()
    // rust: .into_iter()
    // rust: .skip_while(|&b| b == 0)
    // rust: .collect();
    // rust: out.push(0x80 | bytes.len() as u8);
    // rust: out.extend(bytes);
}
    // rust: out.extend_from_slice(contents);
    // rust: out
}

// A DER INTEGER from big-endian magnitude bytes (a leading zero keeps it positive).
    // rust: pub(crate) fn der_integer(magnitude: &[u8]) -> Vec<u8> {
    // rust: let mut v = strip(magnitude);
    // rust: if v.first().is_none_or(|b| b & 0x80 != 0) {
    // rust: v.insert(0, 0);
}
    // rust: der_element(0x02, &v)
}

// The server's key pair (Crypt.generateKeyPair), or a player's chat key
// pair from the services (Crypt.stringToPemRsaPrivateKey).
RsaPrivateKey :: struct {
    public: RsaPublicKey,
    // The private exponent, big-endian.
    exponent: [dynamic]u8,
}

    // rust: impl std::fmt::Debug for RsaPrivateKey {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter<'_>) -> s {
    // Ported from Horizon
    return {}
}
    // rust: f.debug_struct("RsaPrivateKey")
    // rust: .field("public", &self.public)
    // rust: .finish_non_exhaustive()
}
}

    // rust: impl RsaPrivateKey {
    // A new key pair with a `bits`-bit modulus (a multiple of 64) and
    // public exponent 65537, as Java's RSA KeyPairGenerator makes.
generate :: proc(bits: uint) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let limbs = bits / 64;
    // rust: let p = prime(limbs)?;
    // rust: let q = loop {
    // rust: let q = prime(limbs)?;
    // rust: if q != p {
    // rust: break q;
}
}
    // rust: let n = p.mul(&q);
        // d = (1 + k·φ) / E with k making it whole: k ≡ -φ⁻¹ (mod E).
    // rust: let (mut p1, mut q1) = (p, q);
    // rust: p1.0[0] -= 1;
    // rust: q1.0[0] -= 1;
    // rust: let phi = p1.mul(&q1);
    // rust: let r = u64::from(phi.div_small(E).1);
    // rust: let inverse = (1..u64::from(E))
    // rust: .find(|k| k * r % u64::from(E) == 1)
    // rust: .ok_or_else(|| Error::new("RSA key generation failed"))?;
    // rust: let k = (u64::from(E) - inverse) as u32;
    // rust: let (d, rem) = phi.mul_small_add(k, 1).div_small(E);
    // rust: if rem != 0 {
    // rust: return Err(Error::new("RSA key generation failed"));
}
    // rust: let size = bits / 8;
    // rust: Ok(Self {
    // rust: public: RsaPublicKey {
    // rust: modulus: strip(&n.to_be_bytes(size)),
    // rust: exponent: strip(&E.to_be_bytes()),
    // rust: },
    // rust: exponent: d.to_be_bytes(size),
    // rust: })
}

    // PublicKey.getEncoded: X.509 SubjectPublicKeyInfo.
public_der :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let key = der_element(
    // rust: 0x30,
    // rust: &[
    // rust: der_integer(&self.public.modulus),
    // rust: der_integer(&self.public.exponent),
    // rust: ]
    // rust: .concat(),
    // rust: );
    // rust: let algorithm = der_element(
    // rust: 0x30,
    // rust: &[der_element(0x06, RSA_ENCRYPTION), vec![0x05, 0x00]].concat(),
    // rust: );
    // rust: let bits = der_element(0x03, &[&[0u8][..], &key].concat());
    // rust: der_element(0x30, &[algorithm, bits].concat())
}

    // Crypt.decryptUsingKey: RSAES-PKCS1-v1_5 decryption (RFC 8017 7.2.2).
decrypt :: proc(self: ^Self, ciphertext: []u8) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let bad = || Error::new("Decryption error");
    // rust: let k = self.public.size();
        // The modulus has no leading zero, so equal lengths compare as numbers.
    // rust: if ciphertext.len() != k || ciphertext >= self.public.modulus.as_slice() {
    // rust: return Err(bad());
}
    // rust: let block = self.public.apply(ciphertext, &self.exponent);
    // rust: if block[0] != 0 || block[1] != 2 {
    // rust: return Err(bad());
}
    // rust: let zero = block[2..].iter().position(|&b| b == 0).ok_or_else(bad)? + 2;
    // rust: if zero < 10 {
    // rust: return Err(bad());
}
    // rust: Ok(block[zero + 1..].to_vec())
}

    // PKCS8EncodedKeySpec: PrivateKeyInfo { version, AlgorithmIdentifier,
    // OCTET STRING RSAPrivateKey }. A bare PKCS#1 RSAPrivateKey is read too:
    // the services label their PKCS#8 key "RSA PRIVATE KEY".
from_der :: proc(der_bytes: []u8) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let bad = || Error::new("Malformed private key");
    // rust: let (tag, body, _) = der(der_bytes)?;
    // rust: if tag != 0x30 {
    // rust: return Err(bad());
}
    // rust: let (tag, _version, rest) = der(body)?;
    // rust: if tag != 0x02 {
    // rust: return Err(bad());
}
    // rust: let key = match der(rest)? {
    // rust: (0x30, algorithm, rest) => {
    // rust: let (oid_tag, oid, _) = der(algorithm)?;
    // rust: if oid_tag != 0x06 || oid != RSA_ENCRYPTION {
    // rust: return Err(Error::new("Not an RSA private key"));
}
    // rust: let (tag, octets, _) = der(rest)?;
    // rust: if tag != 0x04 {
    // rust: return Err(bad());
}
    // rust: let (tag, key, _) = der(octets)?;
    // rust: if tag != 0x30 {
    // rust: return Err(bad());
}
    // rust: let (_, _version, key) = der(key)?;
    // rust: key
}
            // PKCS#1: the version is followed by the modulus.
    // rust: (0x02, ..) => rest,
    // rust: _ => return Err(bad()),
}
    // rust: let (n_tag, n, rest) = der(key)?;
    // rust: let (e_tag, e, rest) = der(rest)?;
    // rust: let (d_tag, d, _) = der(rest)?;
    // rust: if n_tag != 0x02 || e_tag != 0x02 || d_tag != 0x02 {
    // rust: return Err(bad());
}
    // rust: let public = RsaPublicKey {
    // rust: modulus: strip(n),
    // rust: exponent: strip(e),
}
    // rust: if public.modulus.len() < 64 || public.modulus.last().is_none_or(|b| b & 1 == 0) {
    // rust: return Err(bad());
}
    // rust: let size = public.size();
    // rust: let d = strip(d);
    // rust: if d.is_empty() || d.len() > size {
    // rust: return Err(bad());
}
    // rust: let mut exponent = vec![0u8; size - d.len()];
    // rust: exponent.extend_from_slice(&d);
    // rust: Ok(Self { public, exponent })
}

    // `Signature.sign` for RSASSA-PKCS1-v1_5 (RFC 8017 8.2.1), checked with
    // the public exponent before it leaves, so a faulty result is never sent.
sign :: proc(self: ^Self, hash: SignatureHash, message: []u8) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let k = self.public.size();
    // rust: let block = emsa_pkcs1(hash, message, k)
    // rust: .ok_or_else(|| Error::new("RSA key too short for the digest"))?;
    // rust: let signature = self.public.apply(&block, &self.exponent);
    // rust: if !self.public.verify(hash, message, &signature) {
    // rust: return Err(Error::new("RSA signature failed its own check"));
}
    // rust: Ok(signature)
}
}

    // rust: pub(crate) mod tests {
//     use super::*;

hex :: proc(s: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let s = if s.len() % 2 == 1 {
    // rust: format!("0{s}")
    // rust: } else {
    // rust: s.to_owned()
}
    // rust: (0..s.len())
    // rust: .step_by(2)
    // rust: .map(|i| u8::from_str_radix(&s[i..i + 2], 16).unwrap())
    // rust: .collect()
}

    // A 1024-bit test key made with `openssl genrsa 1024`.
TEST_SPKI :: "30819f300d06092a864886f70d010101050003818d0030818902818100ab026074f92450a8f726f3895bb11176ca8f065f3100cd4143bac4f7d3674edcff95b41a0525d2365a549c106ec6685881b392177420fd31ff5c144ff11ba24311e751cd2c6b5d1817b6af6686a43c95d61243613005e6945b6093cd95223cec5e8856826da9d2ee1b323362ac1cebeab3659cbc45319a9b540dda816a4798ff0203010001"
TEST_N :: "ab026074f92450a8f726f3895bb11176ca8f065f3100cd4143bac4f7d3674edcff95b41a0525d2365a549c106ec6685881b392177420fd31ff5c144ff11ba24311e751cd2c6b5d1817b6af6686a43c95d61243613005e6945b6093cd95223cec5e8856826da9d2ee1b323362ac1cebeab3659cbc45319a9b540dda816a4798ff"
TEST_D :: "172bcb460e3c0d71d78b3f946d082105a78c99a06c535f7c6860f62f5e45b139e0a7b82f8e630188bbd49b10def1a351dac12a1a6371d4dce16ce893ac67c2247b9ee13e3a840abaf9ea685304558f1a93c4f354193f5713c3e53bd10dd275300db36e764fc081549afbd30cd00c31e6eb726720337a963913d96b50e4d8fd1"
    // SHA256withRSA signature of "hello" with the test key (openssl pkeyutl), for chat signing.
TEST_SIG_HELLO :: "0bc8716622e44f9bf72432045e91bf1b40a96aae3c402fa86262b83758db1c90d2ed16b9fa86f29af175f2e6eedb864bf8da2667a7ada2bf5433fba36c1951af0c356e45bd5f90fb905b9a08f33a0666c4968ccffbf32fda643d736deec66f82c75fe4a8075c7f2b8a6c0ca630e0ffe4805a1f1d672506b82fc188510fb4ef80"

montgomery_matches_small_numbers :: proc() {
}
        // 4^13 mod 497 = 445 (the classic example), on one limb.
    // rust: let mont = Mont::new(Big(vec![497]));
    // rust: assert_eq!(mont.pow(&Big(vec![4]), &Big(vec![13])), Big(vec![445]));
        // Two limbs: (2^40 + 5)^3 mod (2^61 - 1).
    // rust: let n = (1u128 << 61) - 1;
    // rust: let m = Mont::new(Big(vec![n as u32, (n >> 32) as u32]));
    // rust: let b = (1u128 << 40) + 5;
    // rust: let expected = b * b % n * b % n;
    // rust: let r = m.pow(&Big(vec![b as u32, (b >> 32) as u32]), &Big(vec![3, 0]));
    // rust: assert_eq!(u128::from(r.0[0]) | u128::from(r.0[1]) << 32, expected);
}

parses_x509_public_keys :: proc() {
}
    // rust: let key = RsaPublicKey::from_der(&hex(TEST_SPKI)).unwrap();
    // rust: assert_eq!(key.modulus, hex(TEST_N));
    // rust: assert_eq!(key.exponent, vec![1, 0, 1]);
    // rust: assert_eq!(key.size(), 128);
    // rust: assert!(RsaPublicKey::from_der(&hex(TEST_SPKI)[..100]).is_err());
    // rust: assert!(RsaPublicKey::from_der(b"not a key").is_err());
}

    // Encrypted with the public key, decrypted with the private exponent:
    // a PKCS#1 v1.5 type 2 block with non-zero padding around the message.
pkcs1_round_trip :: proc() {
}
    // rust: let key = RsaPublicKey::from_der(&hex(TEST_SPKI)).unwrap();
    // rust: let secret = [0x5au8; 16];
    // rust: let a = key.encrypt(&secret).unwrap();
    // rust: let b = key.encrypt(&secret).unwrap();
    // rust: assert_eq!(a.len(), 128);
    // rust: assert_ne!(a, b, "padding is random");
    // rust: for c in [a, b] {
    // rust: let block = key.apply(&c, &hex(TEST_D));
    // rust: assert_eq!(&block[..2], &[0, 2]);
    // rust: let zero = 2 + block[2..].iter().position(|&b| b == 0).unwrap();
    // rust: assert_eq!(zero, 128 - 16 - 1);
    // rust: assert_eq!(&block[zero + 1..], &secret);
}
    // rust: assert!(key.encrypt(&[0; 118]).is_err());
}

    // A key made here: Java-style DER that parses back, and what its public
    // half encrypts its private half decrypts.
generated_keys_round_trip :: proc() {
}
    // rust: let key = RsaPrivateKey::generate(1024).unwrap();
    // rust: assert_eq!(key.public.size(), 128);
    // rust: assert_eq!(key.public.exponent, vec![1, 0, 1]);
    // rust: let der = key.public_der();
    // rust: assert_eq!(
    // rust: &der[..3],
    // rust: &[0x30, 0x81, 0x9f],
    // rust: "a 1024-bit SubjectPublicKeyInfo"
    // rust: );
    // rust: assert_eq!(RsaPublicKey::from_der(&der).unwrap(), key.public);
    // rust: for message in [&[0x5au8; 16][..], &[1, 2, 3, 4], &[]] {
    // rust: let c = key.public.encrypt(message).unwrap();
    // rust: assert_eq!(key.decrypt(&c).unwrap(), message);
}
    // rust: assert!(key.decrypt(&[0u8; 128]).is_err());
    // rust: assert!(key.decrypt(&[1u8; 64]).is_err());
}

decrypts_with_a_known_key :: proc() {
}
    // rust: let key = RsaPrivateKey {
    // rust: public: RsaPublicKey::from_der(&hex(TEST_SPKI)).unwrap(),
    // rust: exponent: hex(TEST_D),
}
    // rust: let c = key.public.encrypt(b"secret").unwrap();
    // rust: assert_eq!(key.decrypt(&c).unwrap(), b"secret");
}

finds_primes :: proc() {
}
    // rust: let p = Big(vec![0xFFFF_FFFB]); // 2^32 - 5 is prime
    // rust: assert!(probably_prime(&p).unwrap());
    // rust: assert!(!probably_prime(&Big(vec![0xFFFF_FFFD])).unwrap()); // 3 · 1431655765
        // 2^61 - 1 (prime) and a Carmichael-free composite 2^61 + 1.
    // rust: let m61 = (1u64 << 61) - 1;
    // rust: assert!(probably_prime(&Big(vec![m61 as u32, (m61 >> 32) as u32])).unwrap());
    // rust: let c = (1u64 << 61) + 1;
    // rust: assert!(!probably_prime(&Big(vec![c as u32, (c >> 32) as u32])).unwrap());
}

    // An OpenSSL signature checked with the public exponent: the block ends
    // with SHA-256("hello"), so the modular arithmetic agrees with OpenSSL's.
verifies_an_openssl_signature :: proc() {
}
    // rust: let key = RsaPublicKey::from_der(&hex(TEST_SPKI)).unwrap();
    // rust: let block = key.apply(&hex(TEST_SIG_HELLO), &key.exponent);
    // rust: assert_eq!(&block[..2], &[0, 1]);
    // rust: assert!(block.ends_with(&hex(
    // rust: "2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824"
    // rust: )));
    // rust: let signature = hex(TEST_SIG_HELLO);
    // rust: assert!(key.verify(SignatureHash::Sha256, b"hello", &signature));
    // rust: assert!(!key.verify(SignatureHash::Sha256, b"hellO", &signature));
    // rust: assert!(!key.verify(SignatureHash::Sha1, b"hello", &signature));
    // rust: let mut flipped = signature.clone();
    // rust: flipped[40] ^= 1;
    // rust: assert!(!key.verify(SignatureHash::Sha256, b"hello", &flipped));
    // rust: assert!(!key.verify(SignatureHash::Sha256, b"hello", &signature[1..]));
    // rust: assert!(!key.verify(SignatureHash::Sha256, b"hello", &key.modulus));
}

    // Signatures made here with the private exponent (EMSA-PKCS1-v1_5 by
    // hand) check out for both digests.
verifies_both_digests :: proc() {
}
    // rust: let key = RsaPublicKey::from_der(&hex(TEST_SPKI)).unwrap();
    // rust: for hash in [SignatureHash::Sha1, SignatureHash::Sha256] {
    // rust: let (prefix, digest) = (hash.prefix(), hash.digest(b"payload"));
    // rust: let mut block = vec![0xff; 128];
    // rust: block[0] = 0;
    // rust: block[1] = 1;
    // rust: let t = prefix.len() + digest.len();
    // rust: block[127 - t] = 0;
    // rust: block[128 - t..128 - digest.len()].copy_from_slice(prefix);
    // rust: block[128 - digest.len()..].copy_from_slice(&digest);
    // rust: let signature = key.apply(&block, &hex(TEST_D));
    // rust: assert!(key.verify(hash, b"payload", &signature));
    // rust: assert!(!key.verify(hash, b"payloaD", &signature));
}
}

    // A 2048-bit key (`openssl genrsa 2048`, then `openssl pkcs8 -topk8 -nocrypt
    // -outform DER`), the size of a player's chat key: its signatures are
    // MessageSignature's 256 bytes.
CHAT_KEY_PKCS8 :: "308204bc020100300d06092a864886f70d0101010500048204a6308204a20201000282010100bebf25d067e367ba25767067c0464701a109a37699f90a49e413cfba58694c4e51c317e43ad90b171f08dae88aabe0f51958871becf2e62e65282fbb256b70247aa0a7f186b044db793c379d1a332ccc5b50832b8564cf31282d3229abc982439fa3d8085824a8705b1d0d2a4323e300f1ce266f82f09282bbb77ebcd02da8d11c5f118141671497c3e08201e26764f681f50c84ab1475d57bfdc3f648431dcf9c2fa9e215002093ca4c33fc6986bc7e5e430ee4fb269e6b4d04bfd6bbd9d50c9ded5d04325d298815c22334a31e156eeb18aecffa2f64899c6d344723f93691531d816b440fd12a6ede94cdcfa2b86dd32077ae1be0e39c456b5d2d06aee9350203010001028201001bd2874a3b010b3df65d6c7f61a70e8fe104a62474488454eb50ed758d944c56472c49059804d50e8a0f11592672f424e40dcae54a9e526f557f7358dd982a7b13acefda35ae6bd8c47a0155a7beebaba22d1ff8dee3e9a9cea5ab01b38638bb32e3a3ecf1a8652e40480045d815b9b48750adc009ae1bfcb8334767f488986d2978982f12a06f9763bf9eebfdeb60f617521b0bce0756ec379cab2a22d00176b058fabca90175860f66a0634a0dd4219eba51c8c43ab3abbd2d2de4466bef6a815d84585f3cd76420bceaacd15be37fd9e957869ca25d0644c50e5ad399c05359b455b885ed135d3a63b1f80705def62a29cab8904f5ae5fd0f8cfcc9f2048902818100e0611a0d0009e190af7a99e9070ddcf127b41b578515888e18c555488567c2b3ebf970695e44fc7755580245b191fda81a8f670475a4048304652fb7ea9003b2b9985fafbac9f59695132bc6d6e35a3503f407ac2e6efa8dd736d617fad4946c80aabdcf06ab67da7a5cc4a0d69d9320964dc618feb2fc2cfb39c2e11bd1295902818100d9a0afc08108ba70c0a46bb82f1d8beb12cfd50a106d5483fbdf17a7919e0e1373a4c05c4287256faf7be8c42f1788ec3dd33abead70c4a67ec30ef930800f1bb34f5a762946e6fa3c7e296356d1a1059a7068d2bdac29ef4bd5cd25203ffc1a5d10a9bb1d15f6c72e5c830ff9fe5d2f445ce3da61693e6353a8d8fca7f7a73d02818040ef18f0e62ff5dd3f4b45bb50554cb9657a13e79216173cb8227379d7519de11fcb4222dc2b2ebd022fc4089348e295818a3a8fe9d39b92a6f4f9884a137f5e7ba3831d81faec5db5aaa4a29891970b7ca7648909af0847801ed87a7c168515996ed01b579cc7234d0207cd5c0ea2036e3bf7b6480f58375444f506dc5bfd91028180276aa12a7eb47400440403b6a261f99ba4169c816c2441307e8813a2b80f2681836a8da4a8300e29c260f0f1c78dbdb0fc29abf42939c984566541eb044bcd70b8f36071125cd32cf393ee2f1de46e03b3cb345127256d9af7e34b7ab3f2a2d8ab8e7f0f72df2d8939ee6b969332ecf1c8b2025ae555c884f8fc1600fcf330090281802985deefe6ccc4ceb42bbb1ce9a2ecacea4974f5ba8090ba33049e36d0c43a7c9be2da95fc0bf2c7fb0ec2ee73ee628bfda786afa68c75fa08d996b6c1674a759f7f1ec67d95206d69c4b28234b55933748b7930feb9818fa6944bdbf0258894164706d498d2cf29e241fe1b99ec94021cd29ed8a528ee5cf4fe6e6ddcbd1d97"

    // A 1024-bit key from `openssl genrsa` as `openssl pkcs8 -topk8 -nocrypt
    // -outform DER` writes it, its public half, and `openssl dgst -sha256
    // -sign` of "chat".
PKCS8 :: "30820275020100300d06092a864886f70d01010105000482025f3082025b02010002818100a483a9a2ce1762edb78b7359b96415e35885db2cebb0615d36ce314623a5c3ddb5fe1dccdb6066c4dfe16125baf73ca48b4658285da6adf1ccf0bd18be0f67e3a1d68e9547fc129b6d3fe74413ed5f987123f556b54a8c3a434a0fd4a02d4599d73fbdbf403bc229ed3c6e45877fbb2a20fd3850f1a19c5adbefb703eac785eb02030100010281803e646cb68100df9516523dea1e6475e4a61305ffb0575165bfbe4d73b35b4fc04b2057fef48848118c72f69c0f9f6a9160fcc9bc6d6024821ade8668d6d412eae70f2c19d1890877c4fe46aebbbf2324ad3f304dfc7bd6ec484befe4730cc72c749a557c0d0bb6a73093ef571e4fc543ff5a5ec146e9799ca98f9a71b6c08831024100d5e071afe69c04174eea3023c16a3226a577a3ae01c0166ce68dac20791c75aec47ee115ab52a86ae0a7860ba87bfb6f37a8754d72feec7073eff4d6485dd2b3024100c4ea63df21d6711e15a431400a84c127acb6a77c22f475fc807be941a6a80fc0edd4bab09f09a157e517580777c2caf832e5fa07375fc8f3f1286e9f9e9ebbe90240609199e37975a2673fcb7ff6f502d5281bf83c207a4bd8144db95429c9656f417d1968da16e4188541708296caf9481afc7f848f76c7e1cc189d14e897fe3cff024043ba4e817774f7511ea66b9e184012e35f7f2f59fdf7d100f8fc257d4421f7d126bc0d3e24653e8e29a87ec98ac27fe72032836da9f912f7fc5128c353de4ac902401a16b013e8717963d6f938b0126db15eecc678ccd0b3b8497aa6528d522f89087112694fd5082b9838ba162de4831589195284a6aa24711fc7d54ec073dfddf1"
PKCS8_SPKI :: "30819f300d06092a864886f70d010101050003818d0030818902818100a483a9a2ce1762edb78b7359b96415e35885db2cebb0615d36ce314623a5c3ddb5fe1dccdb6066c4dfe16125baf73ca48b4658285da6adf1ccf0bd18be0f67e3a1d68e9547fc129b6d3fe74413ed5f987123f556b54a8c3a434a0fd4a02d4599d73fbdbf403bc229ed3c6e45877fbb2a20fd3850f1a19c5adbefb703eac785eb0203010001"
PKCS8_SIG_CHAT :: "3a6ed84b109a293d92a53b2120925f3fa33d3b81b686e9a9f0f1f935bd80a263b0912cf0bcd5ac5ca14ffcd3301a23cb2c3d828a092bb49cc8831a3c1f9be674a44a7c906dd8d48e00edcf7c899a75b19e2eea6d94f868507005448692f8c500192268a286988a025c09ad8fa99ffb50de52c2e892310111c22cdb8b3ac4eb8a"

    // PKCS#1 v1.5 signatures are deterministic, so signing here must give
    // OpenSSL's bytes exactly.
signs_like_openssl_with_a_pkcs8_key :: proc() {
}
    // rust: let key = RsaPrivateKey::from_der(&hex(PKCS8)).unwrap();
    // rust: assert_eq!(
    // rust: key.public,
    // rust: RsaPublicKey::from_der(&hex(PKCS8_SPKI)).unwrap()
    // rust: );
    // rust: assert_eq!(key.public_der(), hex(PKCS8_SPKI));
    // rust: let signature = key.sign(SignatureHash::Sha256, b"chat").unwrap();
    // rust: assert_eq!(signature, hex(PKCS8_SIG_CHAT));
    // rust: assert!(
    // rust: key.public
    // rust: .verify(SignatureHash::Sha256, b"chat", &signature)
    // rust: );
    // rust: assert!(RsaPrivateKey::from_der(&hex(PKCS8)[..200]).is_err());
    // rust: assert!(RsaPrivateKey::from_der(&hex(PKCS8_SPKI)).is_err());
    // rust: assert!(RsaPrivateKey::from_der(b"not a key").is_err());
}

    // The bare PKCS#1 form: version, n, e, d (the CRT fields aren't used).
reads_pkcs1_private_keys :: proc() {
}
    // rust: let body = [
    // rust: der_integer(&[0]),
    // rust: der_integer(&hex(TEST_N)),
    // rust: der_integer(&[1, 0, 1]),
    // rust: der_integer(&hex(TEST_D)),
    // rust: ]
    // rust: .concat();
    // rust: let key = RsaPrivateKey::from_der(&der_element(0x30, &body)).unwrap();
    // rust: assert_eq!(key.public, RsaPublicKey::from_der(&hex(TEST_SPKI)).unwrap());
    // rust: let signature = key.sign(SignatureHash::Sha256, b"hello").unwrap();
    // rust: assert_eq!(signature, hex(TEST_SIG_HELLO));
}

generated_keys_sign :: proc() {
}
    // rust: let key = RsaPrivateKey::generate(1024).unwrap();
    // rust: for hash in [SignatureHash::Sha1, SignatureHash::Sha256] {
    // rust: let signature = key.sign(hash, b"message").unwrap();
    // rust: assert_eq!(signature.len(), 128);
    // rust: assert!(key.public.verify(hash, b"message", &signature));
    // rust: assert!(!key.public.verify(hash, b"messagE", &signature));
}
}
}
