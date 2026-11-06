//! Transpiled from Horizon Rust crate
package horizon_protocol_frame

import "core:fmt"
import "core:mem"
import "core:math"

// Packet framing (Varint21FrameDecoder / Varint21LengthFieldPrepender) and
// zlib compression above a threshold (CompressionEncoder / CompressionDecoder).
// use crate::{
    // rust: Error, Result,
    // rust: buf::{Reader, write_varint},
}
// use flate2::{Compression, Decompress, FlushDecompress, Status, write::ZlibEncoder};
// use std::io::Write;

// Frames are at most three VarInt bytes long (21 bits).
MAX_FRAME :: (1 << 21) - 1
// CompressionDecoder.MAXIMUM_UNCOMPRESSED_LENGTH.
MAX_UNCOMPRESSED :: 8_388_608

// Build the frame for one packet body (`id` + payload already concatenated):
// length prefix, and with compression enabled the uncompressed-length
// field (0 when below the threshold).
encode :: proc(body: []u8, threshold: Maybe(uint)) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(prefixed(&contents(body, threshold)?))
}

// What [`encode`] puts after the length prefix: the same for every
// connection with the same threshold.
contents :: proc(body: []u8, threshold: Maybe(uint)) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let inner = match threshold {
    // rust: None => body.to_vec(),
    // rust: Some(t) if body.len() < t => {
    // rust: let mut v = Vec::with_capacity(body.len() + 1);
    // rust: v.push(0);
    // rust: v.extend_from_slice(body);
    // rust: v
}
    // rust: Some(_) => {
    // rust: let mut v = Vec::with_capacity(body.len() / 2 + 8);
    // rust: write_varint(&mut v, body.len() as i32);
    // rust: let mut z = ZlibEncoder::new(v, Compression::default());
    // rust: z.write_all(body)?;
    // rust: z.finish()?
}
}
    // rust: if inner.len() > MAX_FRAME {
    // rust: return Err(Error::new(format!(
    // rust: "packet too large: {} bytes",
    // rust: inner.len()
    // rust: )));
}
    // rust: Ok(inner)
}

// A frame: the length prefix, then the [`contents`].
prefixed :: proc(contents: []u8) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::with_capacity(contents.len() + 3);
    // rust: write_varint(&mut out, contents.len() as i32);
    // rust: out.extend_from_slice(contents);
    // rust: out
}

// The length prefix at the front of `bytes`, once it is complete: its own
// size and the frame's length.
header :: proc(bytes: []u8) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut len = 0usize;
    // rust: for i in 0..3 {
    // rust: let Some(&b) = bytes.get(i) else {
    // rust: return Ok(None);
}
    // rust: len |= usize::from(b & 0x7F) << (7 * i);
    // rust: if b & 0x80 == 0 {
    // rust: if len == 0 {
                // Varint21FrameDecoder: a frame with no bytes is a
                // corrupted frame, not an empty packet.
    // rust: return Err(Error::new("Frame length cannot be zero"));
}
    // rust: return Ok(Some((i + 1, len)));
}
}
    // rust: Err(Error::new("length wider than 21 bits"))
}

// Inflates compressed frames, keeping its state from one to the next
// (`CompressionDecoder`'s one `Inflater`).
Inflater :: struct {
    // rust: impl Default for Inflater {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self(Decompress::new(true))
}
}
    // rust: impl Inflater {
    // The zlib stream at the front of `input`, which must hold exactly `size` bytes.
inflate :: proc(self: ^Self, input: []u8, size: uint) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.0.reset(true);
        // One byte more than declared: a longer stream fills it.
    // rust: let mut out = Vec::with_capacity(size + 1);
    // rust: let status = self
    // rust: .0
    // rust: .decompress_vec(input, &mut out, FlushDecompress::Finish)
    // rust: .map_err(|e| Error::new(format!("Badly compressed packet - {e}")))?;
    // rust: if out.len() != size || !matches!(status, Status::StreamEnd) {
    // rust: return Err(Error::new(format!(
    // rust: "Badly compressed packet - actual length {} does not match declared size {size}",
    // rust: out.len()
    // rust: )));
}
    // rust: Ok(out)
}
}

// A frame's packet body: where it starts in the frame, or inflated.
Body :: enum {
    Plain(usize),
    Inflated(Vec<u8>),
}

// `CompressionDecoder`: the body of a frame, inflated when its data length says so.
body :: proc(frame: []u8, threshold: Maybe(uint), inflater: ^Inflater) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let Some(threshold) = threshold else {
    // rust: return Ok(Body::Plain(0));
}
    // rust: let mut r = Reader::new(frame);
    // rust: let size = r.varint()?;
    // rust: if size == 0 {
    // rust: return Ok(Body::Plain(r.position()));
}
    // rust: let size = usize::try_from(size).map_err(|_| Error::new("negative uncompressed length"))?;
    // rust: if size < threshold {
    // rust: return Err(Error::new(format!(
    // rust: "Badly compressed packet - size of {size} is below server threshold of {threshold}"
    // rust: )));
}
    // rust: if size > MAX_UNCOMPRESSED {
    // rust: return Err(Error::new(format!(
    // rust: "Badly compressed packet - size of {size} is larger than protocol maximum"
    // rust: )));
}
    // rust: inflater
    // rust: .inflate(&frame[r.position()..], size)
    // rust: .map(Body::Inflated)
}

    // rust: mod tests {
//     use super::*;

    // Split one complete frame off the front of `buffer`, if available.
split :: proc(buffer: ^[dynamic]u8) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let Some((start, len)) = header(buffer)? else {
    // rust: return Ok(None);
}
    // rust: if buffer.len() < start + len {
    // rust: return Ok(None);
}
    // rust: let frame = buffer[start..start + len].to_vec();
    // rust: buffer.drain(..start + len);
    // rust: Ok(Some(frame))
}

    // The packet body (id + payload) of a frame.
decompress :: proc(frame: [dynamic]u8, threshold: Maybe(uint)) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(match body(&frame, threshold, &mut Inflater::default())? {
    // rust: Body::Plain(at) => frame[at..].to_vec(),
    // rust: Body::Inflated(body) => body,
    // rust: })
}

uncompressed_frames_round_trip :: proc() {
}
    // rust: let body = vec![0x00, 1, 2, 3];
    // rust: let framed = encode(&body, None).unwrap();
    // rust: assert_eq!(framed, [4, 0, 1, 2, 3]);
    // rust: let mut buffer = framed.clone();
    // rust: buffer.extend_from_slice(&framed[..2]);
    // rust: assert_eq!(split(&mut buffer).unwrap(), Some(body));
    // rust: assert_eq!(split(&mut buffer).unwrap(), None);
    // rust: assert_eq!(buffer, [4, 0]);
}

compression_threshold_like_vanilla :: proc() {
}
        // Below the threshold: a zero data length, then the raw body.
    // rust: let small = vec![7u8; 10];
    // rust: let framed = encode(&small, Some(256)).unwrap();
    // rust: assert_eq!(&framed[..2], &[11, 0]);
    // rust: let mut buffer = framed;
    // rust: let frame = split(&mut buffer).unwrap().unwrap();
    // rust: assert_eq!(decompress(frame, Some(256)).unwrap(), small);
        // At or above: the uncompressed size and a zlib stream.
    // rust: let big: Vec<u8> = (0..5000u32).map(|i| (i % 7) as u8).collect();
    // rust: let framed = encode(&big, Some(256)).unwrap();
    // rust: assert!(framed.len() < big.len());
    // rust: let mut buffer = framed;
    // rust: let frame = split(&mut buffer).unwrap().unwrap();
    // rust: assert_eq!(Reader::new(&frame).varint().unwrap(), 5000);
    // rust: assert_eq!(decompress(frame, Some(256)).unwrap(), big);
}

rejects_bad_compressed_lengths :: proc() {
}
        // Declared size below the threshold is a protocol error.
    // rust: let mut frame = vec![10];
    // rust: let mut z = ZlibEncoder::new(Vec::new(), Compression::default());
    // rust: z.write_all(&[1; 10]).unwrap();
    // rust: frame.extend(z.finish().unwrap());
    // rust: assert!(decompress(frame, Some(256)).is_err());
        // Declared size that does not match the stream.
    // rust: let mut frame = Vec::new();
    // rust: write_varint(&mut frame, 300);
    // rust: let mut z = ZlibEncoder::new(Vec::new(), Compression::default());
    // rust: z.write_all(&[1; 299]).unwrap();
    // rust: frame.extend(z.finish().unwrap());
    // rust: assert!(decompress(frame, Some(256)).is_err());
}

    // One inflater serves every frame, also after a bad one.
the_inflater_is_reused :: proc() {
}
    // rust: let mut inflater = Inflater::default();
    // rust: let frame = |body: &[u8], declared: usize| {
    // rust: let mut frame = Vec::new();
    // rust: write_varint(&mut frame, declared as i32);
    // rust: let mut z = ZlibEncoder::new(frame, Compression::default());
    // rust: z.write_all(body).unwrap();
    // rust: z.finish().unwrap()
}
    // rust: for n in [300usize, 70_000, 256, 5000] {
    // rust: let body: Vec<u8> = (0..n).map(|i| (i * 7 % 13) as u8).collect();
    // rust: match body_of(&frame(&body, n), &mut inflater) {
    // rust: Ok(Body::Inflated(out)) => assert_eq!(out, body),
    // rust: _ => panic!("{n} bytes did not inflate"),
}
            // A stream longer than declared, then one shorter.
    // rust: assert!(body_of(&frame(&body, n - 1), &mut inflater).is_err());
    // rust: assert!(body_of(&frame(&body, n + 1), &mut inflater).is_err());
}
}

body_of :: proc(frame: []u8, inflater: ^Inflater) -> R {
    // Ported from Horizon
    return {}
}
    // rust: body(frame, Some(256), inflater)
}

a_noncanonical_length_prefix_still_reads :: proc() {
}
        // The data-length VarInt is read, not measured: zero as `0x80 0x00`.
    // rust: assert_eq!(
    // rust: decompress(vec![0x80, 0x00, 7, 1, 2], Some(256)).unwrap(),
    // rust: [7, 1, 2]
    // rust: );
        // And a compressed packet whose size was written wide: 300.
    // rust: let body = vec![9; 300];
    // rust: let mut frame = vec![0xAC, 0x82, 0x00];
    // rust: let mut z = ZlibEncoder::new(Vec::new(), Compression::default());
    // rust: z.write_all(&body).unwrap();
    // rust: frame.extend(z.finish().unwrap());
    // rust: assert_eq!(decompress(frame, Some(256)).unwrap(), body);
}
}
