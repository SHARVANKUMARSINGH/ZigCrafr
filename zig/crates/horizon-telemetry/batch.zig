//! Transpiled from Horizon Rust crate
//! Module: horizon-telemetry_batch
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! What goes over the wire: an install's items as one JSON object, zstd-compressed
//! (`Content-Encoding: zstd`). The server decodes with [`decode`], which bounds what it inflates.
// use std::io::Read;

// use serde::{Deserialize, Serialize};

// use crate::Item;
// use crate::consent::is_install_id;

/// A batch on the wire, compressed.
pub const MAX_COMPRESSED: usize = 256 * 1024;
/// A batch's JSON: more than the largest item, so any item fits on its own.
pub const MAX_JSON: usize = 1024 * 1024;
pub const MAX_ITEMS: usize = 64;

pub const Batch = struct {
    schema: u32,
    install_id: []const u8,
    items: std.ArrayList(Item),
};

    // rust: impl Batch {
pub fn new(install_id: []const u8, items: std.ArrayList(Item)) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: schema: crate::SCHEMA,
    // rust: install_id: install_id.to_owned(),
    // rust: items,
}
}

pub fn json(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: serde_json::to_vec(self).unwrap_or_default()
}
}

pub fn encode(batch: *Batch) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ruzstd::encoding::compress_to_vec(
    // rust: batch.json().as_slice(),
    // rust: ruzstd::encoding::CompressionLevel::Fastest,
    // rust: )
}

/// Inflates and checks a batch: its size before and after, its schema and install ID, and
/// every item.
pub fn decode(bytes: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if bytes.len() > MAX_COMPRESSED {
    // rust: return Err(format!("over {MAX_COMPRESSED} bytes"));
}
    // rust: let decoder = ruzstd::decoding::StreamingDecoder::new(bytes).map_err(|e| e.to_string())?;
    // rust: let mut json = Vec::new();
    // rust: decoder
    // rust: .take(MAX_JSON as u64 + 1)
    // rust: .read_to_end(&mut json)
    // rust: .map_err(|e| e.to_string())?;
    // rust: if json.len() > MAX_JSON {
    // rust: return Err(format!("over {MAX_JSON} bytes inflated"));
}
    // rust: let batch: Batch = serde_json::from_slice(&json).map_err(|e| e.to_string())?;
    // rust: if batch.schema == 0 || batch.schema > crate::SCHEMA {
    // rust: return Err(format!("unknown schema {}", batch.schema));
}
    // rust: if !is_install_id(&batch.install_id) {
    // rust: return Err("not an install ID".into());
}
    // rust: if batch.items.is_empty() || batch.items.len() > MAX_ITEMS {
    // rust: return Err(format!("1 to {MAX_ITEMS} items"));
}
    // rust: batch.items.iter().try_for_each(Item::validate)?;
    // rust: Ok(batch)
}

/// Splits items into batches of at most [`MAX_ITEMS`] and [`MAX_JSON`] bytes, in order.
    // rust: pub fn split<T>(items: Vec<(T, Item)>) -> Vec<Vec<(T, Item)>> {
    // rust: let mut batches: Vec<Vec<(T, Item)>> = Vec::new();
    // rust: let mut size = 0;
    // rust: for (tag, item) in items {
    // rust: let len = serde_json::to_vec(&item).map_or(0, |j| j.len()) + 1;
    // rust: let full = batches
    // rust: .last()
    // rust: .is_none_or(|b| b.len() >= MAX_ITEMS || size + len > MAX_JSON - 1024);
    // rust: if full {
    // rust: batches.push(Vec::new());
    // rust: size = 0;
}
    // rust: size += len;
    // rust: if let Some(batch) = batches.last_mut() {
    // rust: batch.push((tag, item));
}
}
    // rust: batches
}

    // rust: mod tests {
//     use super::*;
//     use crate::payload::{Crash, Payload, Perf, Source, Timings};

pub const ID: []const u8 = "0123456789abcdef0123456789abcdef";

pub fn perf() I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut t = Timings::new();
    // rust: (0..50_000).for_each(|i| t.record(6.0 + (i % 97) as f32 / 10.0));
    // rust: Item::new(
    // rust: Source::Game,
    // rust: "v0.4.2",
    // rust: Payload::Perf(Perf {
    // rust: frames: t.summary(),
    // rust: seconds: 600,
    // rust: ..Perf::default()
    // rust: }),
    // rust: )
}

pub fn a_batch_round_trips_and_compresses() void {
}
    // rust: let batch = Batch::new(ID, vec![perf(); 12]);
    // rust: let bytes = encode(&batch);
    // rust: assert_eq!(decode(&bytes).unwrap(), batch);
    // rust: let json = batch.json().len();
    // rust: assert!(bytes.len() * 4 < json, "{} of {json} bytes", bytes.len());
    // rust: assert!(
    // rust: bytes.len() < 2048,
    // rust: "a day's sessions: {} bytes",
    // rust: bytes.len()
    // rust: );
}

pub fn bad_batches_are_refused() void {
}
    // rust: assert!(decode(b"not zstd").is_err());
    // rust: assert!(
    // rust: decode(&vec![0; MAX_COMPRESSED + 1])
    // rust: .unwrap_err()
    // rust: .contains("over")
    // rust: );
    // rust: let mut batch = Batch::new("someone", vec![perf()]);
    // rust: assert!(decode(&encode(&batch)).unwrap_err().contains("install ID"));
    // rust: batch.install_id = ID.into();
    // rust: batch.schema = crate::SCHEMA + 1;
    // rust: assert!(decode(&encode(&batch)).unwrap_err().contains("schema"));
    // rust: batch.schema = crate::SCHEMA;
    // rust: batch.items.clear();
    // rust: assert!(decode(&encode(&batch)).is_err());
    // rust: let huge = Item::new(
    // rust: Source::Game,
    // rust: "v1",
    // rust: Payload::Crash(Crash {
    // rust: stack: "x".repeat(40_000),
    // rust: ..Crash::default()
    // rust: }),
    // rust: );
    // rust: assert!(
    // rust: decode(&encode(&Batch::new(ID, vec![huge])))
    // rust: .unwrap_err()
    // rust: .contains("over its")
    // rust: );
}

pub fn a_zip_bomb_stops_at_the_limit() void {
}
        // Compresses to a few kilobytes, inflates past the limit.
    // rust: let json = format!(
    // rust: r#"{{"schema":1,"install_id":"{ID}","items":[],"pad":"{}"}}"#,
    // rust: " ".repeat(MAX_JSON * 4)
    // rust: );
    // rust: let bytes = ruzstd::encoding::compress_to_vec(
    // rust: json.as_bytes(),
    // rust: ruzstd::encoding::CompressionLevel::Fastest,
    // rust: );
    // rust: assert!(bytes.len() < MAX_COMPRESSED);
    // rust: assert!(decode(&bytes).unwrap_err().contains("inflated"));
}

pub fn items_split_into_batches_by_count_and_size() void {
}
    // rust: let items: Vec<(usize, Item)> = (0..150).map(|i| (i, perf())).collect();
    // rust: let batches = split(items);
    // rust: assert_eq!(
    // rust: batches.iter().map(Vec::len).collect::<Vec<_>>(),
    // rust: [64, 64, 22]
    // rust: );
    // rust: assert_eq!(batches[2].last().unwrap().0, 149);
    // rust: let big = || {
    // rust: Item::new(
    // rust: Source::Launcher,
    // rust: "0.1.5",
    // rust: Payload::Benchmark(serde_json::json!({"pad": "x".repeat(120_000)})),
    // rust: )
}
    // rust: let batches = split((0..20).map(|i| (i, big())).collect());
    // rust: assert!(batches.len() >= 3);
    // rust: for batch in batches {
    // rust: let json = Batch::new(ID, batch.into_iter().map(|b| b.1).collect()).json();
    // rust: assert!(json.len() <= MAX_JSON);
}
}
}
