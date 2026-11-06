//! Transpiled from Horizon Rust crate
//! Module: horizon-world_compression
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Region codecs, including lz4-java's block framing (not the LZ4 frame format).
// use flate2::{Compression as Level, Decompress, FlushDecompress, Status};
// use std::io::{self, Read, Write};

pub const Compression = enum {
    Gzip = 1,
    Zlib = 2,
    None = 3,
    Lz4 = 4,
};

    // rust: pub(crate) fn invalid(message: impl Into<String>) -> io::Error {
    // rust: io::Error::new(io::ErrorKind::InvalidData, message.into())
}

    // rust: impl TryFrom<u8> for Compression {
    // rust: type Error = io::Error;
pub fn try_from(value: u8) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match value {
    // rust: 1 => Ok(Self::Gzip),
    // rust: 2 => Ok(Self::Zlib),
    // rust: 3 => Ok(Self::None),
    // rust: 4 => Ok(Self::Lz4),
    // rust: _ => Err(invalid(format!(
    // rust: "unsupported region compression ID {value}"
    // rust: ))),
}
}
}

    // rust: impl Compression {
pub fn decode(self: *Self, bytes: []const u8, max_output: usize) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut output = Vec::new();
    // rust: self.decode_into(bytes, max_output, &mut output)?;
    // rust: Ok(output)
}
    /// [`decode`](Self::decode) into `output`, which keeps what was decoded
    /// before an error: what a stream reader would already have handed out.
    // rust: pub fn decode_into(
    // rust: self,
    // rust: bytes: &[u8],
    // rust: max_output: usize,
    // rust: output: &mut Vec<u8>,
    // rust: ) -> io::Result<()> {
    // rust: match self {
    // rust: Self::None => {
    // rust: if bytes.len() > max_output {
    // rust: return Err(invalid("decompression limit exceeded"));
}
    // rust: output.extend_from_slice(bytes);
    // rust: Ok(())
}
    // rust: Self::Gzip => {
    // rust: let decoder = flate2::read::MultiGzDecoder::new(bytes);
    // rust: decoder
    // rust: .take((max_output as u64).saturating_add(1))
    // rust: .read_to_end(output)?;
    // rust: if output.len() > max_output {
    // rust: return Err(invalid("decompression limit exceeded"));
}
    // rust: Ok(())
}
    // rust: Self::Zlib => {
    // rust: let mut decoder = Decompress::new(true);
    // rust: let mut block = [0; 8192];
    // rust: loop {
    // rust: let before_in = decoder.total_in();
    // rust: let before_out = decoder.total_out();
    // rust: let status = decoder
    // rust: .decompress(
    // rust: &bytes[before_in as usize..],
    // rust: &mut block,
    // rust: FlushDecompress::None,
    // rust: )
    // rust: .map_err(|e| invalid(e.to_string()))?;
    // rust: let produced = (decoder.total_out() - before_out) as usize;
    // rust: if produced > max_output.saturating_sub(output.len()) {
    // rust: return Err(invalid("decompression limit exceeded"));
}
    // rust: output.extend_from_slice(&block[..produced]);
    // rust: if status == Status::StreamEnd {
    // rust: return Ok(());
}
    // rust: if decoder.total_in() == before_in && produced == 0 {
    // rust: return Err(invalid("truncated zlib stream"));
}
}
}
    // rust: Self::Lz4 => decode_lz4(bytes, max_output, output),
}
}

pub fn encode(self: *Self, bytes: []const u8) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::None => Ok(bytes.to_vec()),
    // rust: Self::Gzip => {
    // rust: let mut encoder = flate2::write::GzEncoder::new(Vec::new(), Level::default());
    // rust: encoder.write_all(bytes)?;
    // rust: encoder.finish()
}
    // rust: Self::Zlib => {
    // rust: let mut encoder = flate2::write::ZlibEncoder::new(Vec::new(), Level::default());
    // rust: encoder.write_all(bytes)?;
    // rust: encoder.finish()
}
    // rust: Self::Lz4 => Ok(encode_lz4(bytes)),
}
}
}

pub const MAGIC: *[u8; 8] = b"LZ4Block";
pub fn checksum(bytes: []const u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // The Checksum adapter used by the pinned Java library masks to 28 bits.
    // rust: xxhash_rust::xxh32::xxh32(bytes, 0x9747_b28c) & 0x0fff_ffff
}

pub fn decode_lz4(mut bytes: []const u8, max_output: usize, output: *mut std.ArrayList(u8)) i {
    // Implementation ported from Horizon
    return undefined;
}
    // `LZ4BlockInputStream.compressedBuffer`: each header is read into it,
    // and a block's bytes over its start; it grows by half when too small.
    // The decompressor may read up to its end, past the block.
    // rust: let mut buffer = vec![0; 21];
    // rust: loop {
    // rust: let header = bytes
    // rust: .get(..21)
    // rust: .ok_or_else(|| invalid("truncated LZ4 header"))?;
    // rust: if &header[..8] != MAGIC {
    // rust: return Err(invalid("invalid LZ4 block magic"));
}
    // rust: let method = header[8] & 0xf0;
    // rust: if !matches!(method, 0x10 | 0x20) {
    // rust: return Err(invalid("invalid LZ4 block method"));
}
    // rust: let compressed = u32::from_le_bytes(header[9..13].try_into().unwrap()) as usize;
    // rust: let raw = u32::from_le_bytes(header[13..17].try_into().unwrap()) as usize;
    // rust: let expected = u32::from_le_bytes(header[17..21].try_into().unwrap());
    // rust: if raw > (1 << (10 + (header[8] & 15)))
    // rust: || (raw == 0) != (compressed == 0)
    // rust: || (method == 0x10 && raw != compressed)
    // rust: {
    // rust: return Err(invalid("invalid LZ4 block lengths"));
}
    // rust: buffer[..21].copy_from_slice(header);
    // rust: bytes = &bytes[21..];
    // rust: if raw == 0 {
    // rust: if expected != 0 {
    // rust: return Err(invalid("invalid LZ4 terminator checksum"));
}
    // rust: return Ok(());
}
    // rust: if raw > max_output.saturating_sub(output.len()) {
    // rust: return Err(invalid("decompression limit exceeded"));
}
    // rust: let block = bytes
    // rust: .get(..compressed)
    // rust: .ok_or_else(|| invalid("truncated LZ4 payload"))?;
    // rust: let start = output.len();
    // rust: let decoded = if method == 0x10 {
    // rust: output.extend_from_slice(block);
    // rust: Ok(())
    // rust: } else {
    // rust: if buffer.len() < compressed {
    // rust: buffer = vec![0; compressed.max(buffer.len() * 3 / 2)];
}
    // rust: buffer[..compressed].copy_from_slice(block);
    // rust: output.resize(start + raw, 0);
            // `refill`: the block must be read to its last byte, no further.
    // rust: if decompress_lz4_java(&buffer, &mut output[start..]) == Some(compressed) {
    // rust: Ok(())
    // rust: } else {
    // rust: Err(invalid("LZ4 stream is corrupted"))
}
}
    // rust: .and_then(|()| {
    // rust: if checksum(&output[start..]) == expected {
    // rust: Ok(())
    // rust: } else {
    // rust: Err(invalid("LZ4 checksum mismatch"))
}
    // rust: });
        // lz4-java hands out a block only once it has decoded and checked it.
    // rust: if let Err(e) = decoded {
    // rust: output.truncate(start);
    // rust: return Err(e);
}
    // rust: bytes = &bytes[compressed..];
}
}

/// lz4-java's `LZ4JavaSafeFastDecompressor.decompress`, which
/// `LZ4BlockInputStream` uses: `dest` filled from `src`, returning how many
/// bytes of `src` it read, or `None` where it throws `LZ4Exception`. Its end
/// conditions are its own (a sequence whose literals leave less than 8 bytes of
/// output, or of input past them, must be the last and end the output), and
/// an offset of 0 fills the match with zeros.
pub fn decompress_lz4_java(src: []const u8, dest: []u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (src_end, dest_end) = (src.len(), dest.len());
    // rust: if dest_end == 0 {
    // rust: return (src.first() == Some(&0)).then_some(1);
}
    // The run-length bytes after a 15 in the token; a run cut off by the end of
    // the input adds a last 255, as the Java loop does.
    // rust: let length = |s: &mut usize, mut len: usize| {
    // rust: let mut last = 0xff;
    // rust: while *s < src_end {
    // rust: last = src[*s];
    // rust: *s += 1;
    // rust: if last != 0xff {
    // rust: break;
}
    // rust: len += 255;
}
    // rust: len + usize::from(last)
}
    // rust: let (mut s, mut d) = (0, 0);
    // rust: loop {
    // rust: if s >= src_end {
    // rust: return None;
}
    // rust: let token = src[s];
    // rust: s += 1;
    // rust: let mut literals = usize::from(token >> 4);
    // rust: if literals == 15 {
    // rust: literals = length(&mut s, literals);
}
    // rust: let literal_end = d + literals;
    // rust: if dest_end < literal_end + 8 || src_end - s < 8 + literals {
    // rust: if literal_end != dest_end || src_end - s < literals {
    // rust: return None;
}
    // rust: dest[d..literal_end].copy_from_slice(&src[s..s + literals]);
    // rust: return Some(s + literals);
}
    // rust: dest[d..literal_end].copy_from_slice(&src[s..s + literals]);
    // rust: s += literals;
    // rust: d = literal_end;
    // rust: let offset = usize::from(u16::from_le_bytes([src[s], src[s + 1]]));
    // rust: s += 2;
    // rust: if offset > d {
    // rust: return None;
}
    // rust: let mut matched = usize::from(token & 15);
    // rust: if matched == 15 {
    // rust: matched = length(&mut s, matched);
}
    // rust: let match_end = d + matched + 4;
    // rust: if match_end > dest_end {
    // rust: return None;
}
    // rust: if offset == 0 {
    // rust: dest[d..match_end].fill(0);
    // rust: } else {
    // rust: for i in d..match_end {
    // rust: dest[i] = dest[i - offset];
}
}
    // rust: d = match_end;
}
}

pub fn encode_lz4(bytes: []const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut output = Vec::new();
    // rust: for block in bytes.chunks(65536) {
    // rust: let compressed = lz4_flex::block::compress(block);
    // rust: let (token, payload) = if compressed.len() < block.len() {
    // rust: (0x26, compressed.as_slice())
    // rust: } else {
    // rust: (0x16, block)
}
    // rust: output.extend_from_slice(MAGIC);
    // rust: output.push(token);
    // rust: output.extend_from_slice(&(payload.len() as u32).to_le_bytes());
    // rust: output.extend_from_slice(&(block.len() as u32).to_le_bytes());
    // rust: output.extend_from_slice(&checksum(block).to_le_bytes());
    // rust: output.extend_from_slice(payload);
}
    // rust: output.extend_from_slice(MAGIC);
    // rust: output.push(0x16);
    // rust: output.extend_from_slice(&[0; 12]);
    // rust: output
}

    // rust: mod tests {
//     use super::*;
    /// lz4-java's `LZ4BlockInputStream` decides which blocks are corrupted
    /// (#5064). Each stream below has a correct checksum; the results are
    /// lz4-java 1.10.1's.
pub fn lz4_blocks_are_read_as_lz4_java_reads_them() void {
}
    // rust: let hex = |s: &str| -> Vec<u8> {
    // rust: (0..s.len())
    // rust: .step_by(2)
    // rust: .map(|i| u8::from_str_radix(&s[i..i + 2], 16).unwrap())
    // rust: .collect()
}
    // rust: let lz4 = |s: &str| Compression::Lz4.decode(&hex(s), usize::MAX);
pub const END: []const u8 = "4c5a34426c6f636b16000000000000000000000000";
        // The issue's stream: its last match ends 2 bytes before the output's end.
    // rust: assert!(lz4(&format!(
    // rust: "4c5a34426c6f636b2620000000270000002817d90bb112cd89673ffd3d11ad97420600708664345bbd2cb70b00248fc80b0020a52b{END}"
    // rust: ))
    // rust: .is_err());
        // A literal with less than 8 bytes of input after it must end the output.
    // rust: assert!(
    // rust: lz4(&format!(
    // rust: "4c5a34426c6f636b260500000005000000f5a1570e100301000c{END}"
    // rust: ))
    // rust: .is_err()
    // rust: );
        // An offset of 0 fills the match with zeros.
    // rust: assert_eq!(
    // rust: lz4(&format!(
    // rust: "4c5a34426c6f636b260400000010000000eace86020c000007{END}"
    // rust: ))
    // rust: .unwrap(),
    // rust: [0; 16]
    // rust: );
}
pub fn all_codecs_roundtrip_and_enforce_limits() void {
}
    // rust: for codec in [
    // rust: Compression::Gzip,
    // rust: Compression::Zlib,
    // rust: Compression::None,
    // rust: Compression::Lz4,
    // rust: ] {
    // rust: for bytes in [
    // rust: vec![],
    // rust: vec![0; 131073],
    // rust: (0..262144).map(|i| (i * 37) as u8).collect(),
    // rust: ] {
    // rust: let encoded = codec.encode(&bytes).unwrap();
    // rust: assert_eq!(codec.decode(&encoded, bytes.len()).unwrap(), bytes);
    // rust: if !bytes.is_empty() {
    // rust: assert!(codec.decode(&encoded, bytes.len() - 1).is_err());
}
    // rust: if codec != Compression::None {
    // rust: assert!(
    // rust: codec
    // rust: .decode(&encoded[..encoded.len() - 1], bytes.len())
    // rust: .is_err()
    // rust: );
}
}
}
}
pub fn checksums_reject_corruption() void {
}
    // rust: for codec in [Compression::Gzip, Compression::Zlib, Compression::Lz4] {
    // rust: let mut encoded = codec.encode(b"Horizon world data").unwrap();
    // rust: let i = if codec == Compression::Lz4 {
    // rust: 17
    // rust: } else {
    // rust: encoded.len() - 5
}
    // rust: encoded[i] ^= 1;
    // rust: assert!(codec.decode(&encoded, 1000).is_err());
}
}
}
