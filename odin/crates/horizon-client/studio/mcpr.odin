//! Transpiled from Horizon Rust crate
package horizon_client_mcpr

import "core:fmt"
import "core:mem"
import "core:math"

// `.mcpr` Replay File Container Specification & I/O
//
// An `.mcpr` file is a ZIP archive containing:
// - `metaData.json`: metadata about the recording session (version, duration, player UUIDs, etc.)
// - `recording.tmcpr`: binary stream of chronological timestamped network packets:
//   `[timestamp_ms: u32 big-endian][packet_length: u32 big-endian][packet_data: VarInt(packet_id) + payload]`
// - Optional `markers.json`: timeline markers/chapters.

// use horizon_protocol::buf::{Reader, write_varint};
// use serde::{Deserialize, Serialize};
// use std::{
    // rust: fs::{self, File, OpenOptions},
    // rust: io::{self, BufReader, BufWriter, Read, Write},
    // rust: path::{Path, PathBuf},
}

// The most `metaData.json` may inflate to: real files are a few hundred bytes.
MAX_METADATA_BYTES :: 1 << 20
// The most `recording.tmcpr` may inflate to. The reader keeps the stream in
// memory, so a hostile archive (deflate reaches about 1000:1) must not be able
// to ask for more than this.
MAX_STREAM_BYTES :: 1 << 30
// How much recording time a stream and its metadata may hold in memory before
// both reach disk. A crash costs at most this many milliseconds of packets.
FLUSH_INTERVAL_MS :: 1_000

// High-level session metadata stored in `metaData.json`.
//
// Only the format fields are required: ReplayMod leaves out `serverName` for
// single player and older format versions lack `protocol`, so those read as
// their defaults rather than rejecting the file.
Metadata :: struct {
    singleplayer: bool,
    server_name: string,
    custom_server_name: Maybe(string),
    duration: u32,
    date: u64,
    mcversion: string,
    file_format: string,
    file_format_version: u32,
    // The network protocol the packet ids belong to; `None` when the file
    // doesn't say, which playback has to treat as unknown.
    protocol: Maybe(i32),
    generator: string,
    self_id: i32,
    players: [dynamic]string,
}

    // rust: impl Default for Metadata {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: singleplayer: true,
    // rust: server_name: "Local World".to_owned(),
    // rust: custom_server_name: None,
    // rust: duration: 0,
    // rust: date: 0,
    // rust: mcversion: horizon_core::VANILLA_VERSION.to_owned(),
    // rust: file_format: "MCPR".to_owned(),
    // rust: file_format_version: 14,
    // rust: protocol: Some(horizon_protocol::PROTOCOL_VERSION),
    // rust: generator: "Horizon Studio".to_owned(),
    // rust: self_id: 1,
    // rust: players: Vec::new(),
}
}
}

    // rust: impl Metadata {
    // Construct new metadata with server name and Minecraft version.
new :: proc(server_name: string, singleplayer: bool, mcversion: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: singleplayer,
    // rust: server_name,
    // rust: mcversion,
    // rust: ..Default::default()
}
}
}

// A raw timestamped clientbound network packet from a replay stream.
TimestampedPacket :: struct {
    // Milliseconds since recording start.
    timestamp_ms: u32,
    // Protocol packet ID.
    id: i32,
    // Unframed packet payload bytes (excluding the VarInt packet ID).
    payload: [dynamic]u8,
}

    // rust: impl TimestampedPacket {
new :: proc(timestamp_ms: u32, id: i32, payload: [dynamic]u8) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: timestamp_ms,
    // rust: id,
    // rust: payload,
}
}
}

// A file name beside `dest` that no other writer in this or another process
// picks: `<dest>.<pid>-<nanos>.<suffix>`.
sibling :: proc(dest: ^Path, suffix: string) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let nanos = std::time::SystemTime::now()
    // rust: .duration_since(std::time::UNIX_EPOCH)
    // rust: .map_or(0, |d| d.as_nanos());
    // rust: let mut name = dest.file_name().unwrap_or_default().to_os_string();
    // rust: name.push(format!(".{}-{nanos}.{suffix}", std::process::id()));
    // rust: dest.with_file_name(name)
}

// The metadata beside a stream: `<stream>.meta.json`.
//
// It is written when recording starts, long before the archive exists, so a
// crash leaves enough to package the stream with
// [`recover_crashed_recordings`].
metadata_beside :: proc(stream: ^Path) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let mut name = stream.file_name().unwrap_or_default().to_os_string();
    // rust: name.push(".meta.json");
    // rust: stream.with_file_name(name)
}

// Writer for generating `.mcpr` replay files.
//
// Packets go to a stream file beside the destination
// (`<name>.mcpr.<pid>-<nanos>.tmcpr.tmp`) and the session metadata to
// `<stream>.meta.json`. Both are flushed together about once a second of
// recording, so a crash loses little and leaves what [`recover_crashed_recordings`]
// packages. The stream is only removed once [`finish`](Self::finish) has put the
// finished archive in place, so a failed finish or a writer dropped without one
// leaves the packets on disk.
McprWriter :: struct {
    dest_path: PathBuf,
    temp_tmcpr_path: PathBuf,
    temp_meta_path: PathBuf,
    writer: Maybe(BufWriter<File)>,
    metadata: Metadata,
    packet_count: uint,
    // Bytes of whole frames in the stream: what `finish` packages.
    bytes_written: u64,
    // The latest timestamp written: the duration a recovery can vouch for.
    last_timestamp_ms: u32,
    // The timestamp of the last time the stream and metadata reached disk.
    last_flush_ms: u32,
    // A write failed: the stream may end in a partial frame, and nothing more
    // is appended after it.
    failed: bool,
}

    // rust: impl McprWriter {
    // Create a new replay writer that writes packets to a temporary stream file
    // and finalizes into `dest_path` when finished.
    //
    // Any recording a crash left in the destination's folder is packaged first
    // (see [`recover_crashed_recordings`]).
new :: proc(dest_path: PathBuf, metadata: Metadata) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(parent) = dest_path.parent() {
    // rust: fs::create_dir_all(parent)?;
    // rust: if !parent.as_os_str().is_empty() {
    // rust: match recover_crashed_recordings(parent) {
    // rust: Ok(report) if !report.recovered.is_empty() => log::info!(
    // rust: "Studio: recovered {} recording(s) a crash left behind",
    // rust: report.recovered.len()
    // rust: ),
    // rust: Ok(_) => {}
    // rust: Err(e) => log::warn!("Studio: could not look for crashed recordings: {e}"),
}
}
}
    // rust: let temp_tmcpr_path = sibling(&dest_path, "tmcpr.tmp");
    // rust: let temp_meta_path = metadata_beside(&temp_tmcpr_path);
    // rust: let file = File::create_new(&temp_tmcpr_path)?;
        // A writer holds its stream locked until the file closes, which the
        // operating system does even after a crash. Recovery uses that to tell
        // a leftover from a recording still being written.
    // rust: if let Err(e) = file.try_lock() {
            // Filesystems without locks still record; recovery falls back to the
            // pid in the stream's name there.
    // rust: log::warn!("Studio: recording stream cannot be locked: {e}");
}
    // rust: let writer = Some(BufWriter::with_capacity(64 * 1024, file));
    // rust: let mut this = Self {
    // rust: dest_path,
    // rust: temp_tmcpr_path,
    // rust: temp_meta_path,
    // rust: writer,
    // rust: metadata,
    // rust: packet_count: 0,
    // rust: bytes_written: 0,
    // rust: last_timestamp_ms: 0,
    // rust: last_flush_ms: 0,
    // rust: failed: false,
}
    // rust: if let Err(e) = this.write_sidecar() {
            // Without metadata a crash would be recovered with defaults only:
            // start over rather than record something that can't be identified.
    // rust: this.writer = None;
    // rust: let _ = fs::remove_file(&this.temp_tmcpr_path);
    // rust: return Err(e);
}
    // rust: Ok(this)
}

    // Record a packet at the given elapsed timestamp.
    //
    // After an error the writer refuses further packets; `finish` still
    // packages every frame written whole before it.
write_packet :: proc(self: ^Self, timestamp_ms: u32, id: i32, payload: []u8) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if self.failed {
    // rust: return Err(io::Error::other("an earlier write failed"));
}
    // rust: let writer = self
    // rust: .writer
    // rust: .as_mut()
    // rust: .ok_or_else(|| io::Error::other("writer already closed"))?;
    // rust: let mut frame = Vec::with_capacity(13 + payload.len());
    // rust: frame.extend_from_slice(&timestamp_ms.to_be_bytes());
    // rust: frame.extend_from_slice(&[0; 4]);
    // rust: write_varint(&mut frame, id);
    // rust: frame.extend_from_slice(payload);
    // rust: let packet_length = u32::try_from(frame.len() - 8)
    // rust: .map_err(|_| io::Error::new(io::ErrorKind::InvalidInput, "packet too large"))?;
    // rust: frame[4..8].copy_from_slice(&packet_length.to_be_bytes());

    // rust: if let Err(e) = writer.write_all(&frame) {
    // rust: self.failed = true;
    // rust: return Err(e);
}
    // rust: self.packet_count += 1;
    // rust: self.bytes_written += frame.len() as u64;
    // rust: self.last_timestamp_ms = self.last_timestamp_ms.max(timestamp_ms);

        // Let the packets and the metadata beside them reach disk together, so
        // the sidecar never describes a stream that is further ahead.
    // rust: if self.last_timestamp_ms.wrapping_sub(self.last_flush_ms) >= FLUSH_INTERVAL_MS {
    // rust: self.last_flush_ms = self.last_timestamp_ms;
    // rust: if let Err(e) = self.flush() {
    // rust: self.failed = true;
    // rust: return Err(e);
}
}
    // rust: Ok(())
}

packet_count :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.packet_count
}

bytes_written :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.bytes_written
}

    // The stream file holding the packets until `finish` succeeds.
stream_path :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.temp_tmcpr_path
}

    // The metadata file holding the session until `finish` succeeds.
metadata_path :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.temp_meta_path
}

    // Flush the stream to disk and rewrite the metadata beside it.
    //
    // A crash after this loses at most the packets written since, and recovery
    // knows what the recording is. A write error is reported after the stream
    // flush; a metadata error only logs, since the packets are still sound.
flush :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(w) = self.writer.as_mut() {
    // rust: w.flush()?;
}
    // rust: if let Err(e) = self.write_sidecar() {
    // rust: log::warn!(
    // rust: "Studio: could not update {}: {e}",
    // rust: self.temp_meta_path.display()
    // rust: );
}
    // rust: Ok(())
}

write_sidecar :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let mut metadata = self.metadata.clone();
    // rust: metadata.duration = self.last_timestamp_ms;
    // rust: let json = serde_json::to_vec_pretty(&metadata)
    // rust: .map_err(|e| io::Error::new(io::ErrorKind::InvalidData, e))?;
    // rust: fs::write(&self.temp_meta_path, json)
}

    // Complete recording, write `metaData.json`, package into `.mcpr` ZIP,
    // and clean up temporary files.
    //
    // The archive is written to a temporary file beside `dest_path`, synced and
    // renamed over it, so an existing file at `dest_path` stays whole until the
    // new one is complete. On error the stream file is kept and the error names it.
finish :: proc(duration_ms: u32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if let Err(e) = self.flush() {
            // A failed flush leaves a partial frame at the end at worst: only
            // `bytes_written` are packaged below.
    // rust: log::warn!("Studio: recording flush failed: {e}");
    // rust: self.failed = true;
}
        // Close the stream before packaging reads it again: on Windows the
        // writer's lock would refuse that read.
    // rust: self.writer = None;
    // rust: self.metadata.duration = duration_ms;

    // rust: let part = sibling(&self.dest_path, "mcpr.part");
    // rust: match self.package(&part) {
    // rust: Ok(()) => {
    // rust: let _ = fs::remove_file(&self.temp_tmcpr_path);
    // rust: let _ = fs::remove_file(&self.temp_meta_path);
    // rust: Ok(self.dest_path.clone())
}
    // rust: Err(e) => {
    // rust: let _ = fs::remove_file(&part);
    // rust: Err(io::Error::new(
    // rust: e.kind(),
    // rust: format!(
    // rust: "could not finish the recording ({e}); its packets are kept in {}",
    // rust: self.temp_tmcpr_path.display()
    // rust: ),
    // rust: ))
}
}
}

package :: proc(self: ^Self, part: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: package_stream(
    // rust: &self.metadata,
    // rust: &self.temp_tmcpr_path,
    // rust: self.bytes_written,
    // rust: part,
    // rust: )?;
    // rust: fs::rename(part, &self.dest_path)
}
}

// Package `bytes` of `stream` and `metadata` into the archive at `part`.
//
// The caller syncs and renames it into place; nothing here touches `stream`.
package_stream :: proc(metadata: ^Metadata, stream: ^Path, bytes: u64, part: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let mut zip = zip::ZipWriter::new(File::create_new(part)?);
    // rust: let options = zip::write::SimpleFileOptions::default()
    // rust: .compression_method(zip::CompressionMethod::Deflated);

    // rust: zip.start_file("metaData.json", options)?;
    // rust: let meta_json = serde_json::to_vec_pretty(metadata)
    // rust: .map_err(|e| io::Error::new(io::ErrorKind::InvalidData, e))?;
    // rust: zip.write_all(&meta_json)?;

    // Zip64, so a recording past 4 GiB still finishes.
    // rust: zip.start_file("recording.tmcpr", options.large_file(true))?;
    // rust: let mut input = BufReader::new(File::open(stream)?).take(bytes);
    // rust: if io::copy(&mut input, &mut zip)? != bytes {
    // rust: return Err(io::Error::new(
    // rust: io::ErrorKind::UnexpectedEof,
    // rust: "the stream file is shorter than what was written",
    // rust: ));
}

    // rust: let file = zip.finish().map_err(io::Error::other)?;
    // rust: file.sync_all()?;
    // rust: drop(file);
    // rust: Ok(())
}

    // rust: impl Drop for McprWriter {
drop :: proc(self: ^Self) {
}
        // An empty stream holds nothing worth keeping; one with packets stays
        // for a later recovery (see the type's doc).
    // rust: if self.packet_count == 0 && self.temp_tmcpr_path.exists() {
    // rust: self.writer = None;
    // rust: let _ = fs::remove_file(&self.temp_tmcpr_path);
    // rust: let _ = fs::remove_file(&self.temp_meta_path);
}
}
}

// The fixed head of the frame at `offset`: `(timestamp_ms, body length, bytes of
// the id VarInt)`, or `None` when the header is short or the id does not fit in
// the body. [`frame_at`] and crash recovery both read a frame's shape through
// this, so they agree on what a whole frame is.
frame_head :: proc(data: []u8, offset: uint) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let header = data.get(offset..offset.checked_add(8)?)?;
    // rust: let timestamp_ms = u32::from_be_bytes([header[0], header[1], header[2], header[3]]);
    // rust: let length = u32::from_be_bytes([header[4], header[5], header[6], header[7]]) as usize;
    // A VarInt is at most five bytes, and the id must fit in the body.
    // rust: let id_bytes = data.get(offset + 8..offset + 8 + length.min(5))?;
    // rust: let mut reader = Reader::new(id_bytes);
    // rust: reader.varint().ok()?;
    // rust: Some((timestamp_ms, length, id_bytes.len() - reader.rest().len()))
}

// The frame at `offset`: `(timestamp_ms, id, payload range, next offset)`, or `None` when it
// isn't whole (a short header, a length past the end, or an id that doesn't
// fit in its length). The index and `next_packet` both read frames through
// this, so they agree on where a damaged stream ends.
frame_at :: proc(data: []u8, offset: uint) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let (timestamp_ms, length, _) = frame_head(data, offset)?;
    // rust: let start = offset + 8;
    // rust: let end = start.checked_add(length)?;
    // rust: let body = data.get(start..end)?;
    // rust: let mut reader = Reader::new(body);
    // rust: let id = reader.varint().ok()?;
    // rust: let payload_start = end - reader.rest().len();
    // rust: Some((timestamp_ms, id, payload_start..end, end))
}

// Reader for opening and streaming `.mcpr` replay files.
McprReader :: struct {
    metadata: Metadata,
    tmcpr_data: [dynamic]u8,
    // Where `next_packet` reads next.
    position: uint,
    // The end of the last whole frame: the stream stops here.
    end: uint,
    // `(timestamp_ms, byte_offset)` of each whole frame. Timestamps never go
    // backwards here: one earlier than the frame before it is indexed at that
    // frame's time, so seeking stays defined on a damaged file.
    packet_index: Vec<(u32,
}

read_entry :: proc(archive: ^zip::ZipArchive<File>, name: string, max: u64) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let entry = archive
    // rust: .by_name(name)
    // rust: .map_err(|e| io::Error::new(io::ErrorKind::NotFound, e))?;
    // rust: let mut bytes = Vec::new();
    // rust: entry.take(max + 1).read_to_end(&mut bytes)?;
    // rust: if bytes.len() as u64 > max {
    // rust: return Err(io::Error::new(
    // rust: io::ErrorKind::InvalidData,
    // rust: format!("{name} is larger than {max} bytes"),
    // rust: ));
}
    // rust: Ok(bytes)
}

    // rust: impl McprReader {
    // Open an `.mcpr` replay archive from disk.
open :: proc(path: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let file = File::open(path)?;
    // rust: let mut archive = zip::ZipArchive::new(file)
    // rust: .map_err(|e| io::Error::new(io::ErrorKind::InvalidData, e))?;

    // rust: let meta_bytes = read_entry(&mut archive, "metaData.json", MAX_METADATA_BYTES)?;
    // rust: let metadata: Metadata = serde_json::from_slice(&meta_bytes)
    // rust: .map_err(|e| io::Error::new(io::ErrorKind::InvalidData, e))?;
    // rust: if metadata.file_format != "MCPR" {
    // rust: return Err(io::Error::new(
    // rust: io::ErrorKind::InvalidData,
    // rust: format!(
    // rust: "not an MCPR recording (fileFormat {:?})",
    // rust: metadata.file_format
    // rust: ),
    // rust: ));
}

    // rust: let tmcpr_data = read_entry(&mut archive, "recording.tmcpr", MAX_STREAM_BYTES)?;

        // A recording that stopped mid-write ends in a frame that isn't whole:
        // indexing and playback both stop before it.
    // rust: let mut packet_index = Vec::new();
    // rust: let mut offset = 0;
    // rust: let mut latest = 0;
    // rust: while let Some((timestamp_ms, _, _, next)) = frame_at(&tmcpr_data, offset) {
    // rust: latest = latest.max(timestamp_ms);
    // rust: packet_index.push((latest, offset));
    // rust: offset = next;
}

    // rust: Ok(Self {
    // rust: metadata,
    // rust: tmcpr_data,
    // rust: position: 0,
    // rust: end: offset,
    // rust: packet_index,
    // rust: })
}

    // Total number of packets indexed in the recording.
total_packets :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.packet_index.len()
}

    // Read the next timestamped packet from the current position, or `None`
    // at the end of the last whole frame.
next_packet :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if self.position >= self.end {
    // rust: return Ok(None);
}
    // rust: let Some((timestamp_ms, id, payload, next)) = frame_at(&self.tmcpr_data, self.position)
    // rust: else {
    // rust: return Ok(None);
}
    // rust: self.position = next;
    // rust: Ok(Some(TimestampedPacket {
    // rust: timestamp_ms,
    // rust: id,
    // rust: payload: self.tmcpr_data[payload].to_vec(),
    // rust: }))
}

    // Seek to the first packet of the latest timestamp at or before
    // `target_timestamp_ms` (the first packet when the target is earlier than
    // all of them), and return that timestamp.
    //
    // Starting at the first packet of a millisecond keeps the packets that
    // arrived together, such as a chunk and the entities in it, together.
seek_to_timestamp :: proc(self: ^Self, target_timestamp_ms: u32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let after = self
    // rust: .packet_index
    // rust: .partition_point(|&(ts, _)| ts <= target_timestamp_ms);
    // rust: let chosen = match after.checked_sub(1) {
    // rust: Some(last) => self.packet_index[last].0,
    // rust: None => match self.packet_index.first() {
    // rust: Some(&(ts, _)) => ts,
    // rust: None => return Ok(None),
    // rust: },
}
    // rust: let idx = self.packet_index.partition_point(|&(ts, _)| ts < chosen);
    // rust: self.position = self.packet_index[idx].1;
    // rust: Ok(Some(chosen))
}

    // Reset stream reading to the beginning.
rewind :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.position = 0;
    // rust: Ok(())
}
}

// What one [`recover_crashed_recordings`] pass did.
RecoveryReport :: struct {
    // The archives written from crashed recordings.
    recovered: [dynamic]PathBuf,
    // Leftover streams whose writer is still running: left alone.
    skipped: [dynamic]PathBuf,
    // Leftover streams that hold no whole frame: kept beside their metadata.
    kept: [dynamic]PathBuf,
}

// A leftover stream, cut to the frames it holds whole.
WholeStream :: struct {
    // Bytes of whole frames: what can be packaged.
    bytes: u64,
    packets: uint,
    last_timestamp_ms: u32,
}

// Package the recordings a crash left in `dir`.
//
// Every `<name>.mcpr.<pid>-<nanos>.tmcpr.tmp` becomes `<name>.mcpr` (or a
// `.recovered` name when that one is taken), cut to its last whole frame and
// stamped with the metadata written beside the stream when recording began. A
// stream whose writer may still be alive is skipped, and a stream with no whole
// frame is kept with its metadata and logged: recovery never deletes what it
// cannot package.
recover_crashed_recordings :: proc(dir: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let mut report = RecoveryReport::default();
    // rust: for entry in fs::read_dir(dir)? {
    // rust: let path = entry?.path();
    // rust: let Some(name) = path.file_name().and_then(|n| n.to_str()) else {
    // rust: continue;
}
        // Only our own streams: `<name>.mcpr.<pid>-<nanos>.tmcpr.tmp`.
    // rust: let Some(rest) = name.strip_suffix(".tmcpr.tmp") else {
    // rust: continue;
}
    // rust: let Some((dest_name, owner)) = rest.rsplit_once('.') else {
    // rust: continue;
}
    // rust: let Some((pid_text, nanos)) = owner.split_once('-') else {
    // rust: continue;
}
    // rust: let (Ok(pid), Ok(_)) = (pid_text.parse::<u32>(), nanos.parse::<u128>()) else {
    // rust: continue;
}

    // rust: if writer_may_be_alive(&path, pid) {
    // rust: log::info!(
    // rust: "Studio: keeping {}: its writer is still running",
    // rust: path.display()
    // rust: );
    // rust: report.skipped.push(path);
    // rust: continue;
}

    // rust: let metadata = match fs::read(metadata_beside(&path))
    // rust: .ok()
    // rust: .and_then(|bytes| serde_json::from_slice(&bytes).ok())
    // rust: {
    // rust: Some(metadata) => metadata,
    // rust: None => {
    // rust: log::warn!(
    // rust: "Studio: {} has no metadata; recovering it with defaults",
    // rust: path.display()
    // rust: );
    // rust: Metadata {
    // rust: date: modified_ms(&path),
    // rust: ..Default::default()
}
}
}
    // rust: let dest = path.with_file_name(dest_name);
    // rust: match recover_stream(&path, &dest, metadata) {
    // rust: Ok((archive, packets)) => {
    // rust: log::info!(
    // rust: "Studio: recovered {} packet(s) from {} into {}",
    // rust: packets,
    // rust: path.display(),
    // rust: archive.display()
    // rust: );
    // rust: report.recovered.push(archive);
}
    // rust: Err(e) => {
    // rust: log::warn!(
    // rust: "Studio: could not recover {} ({e}); keeping it",
    // rust: path.display()
    // rust: );
    // rust: report.kept.push(path);
}
}
}
    // rust: Ok(report)
}

// Whether the writer of `stream` may still be running.
//
// Err on the side of yes: packaging a live recording would take the stream from
// under its writer.
writer_may_be_alive :: proc(stream: ^Path, pid: u32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if pid == std::process::id() {
    // rust: return true;
}
    // rust: {
        // A process with that pid is running, but only the writer itself holds
        // the stream locked: an unlocked one means the pid was reused.
    // rust: Path::new("/proc").join(pid.to_string()).exists() && !stream_is_unlocked(stream)
}
    // rust: {
        // Without a pid check, ask the file: a writer holds its stream locked
        // until it closes it, and the operating system drops the lock when the
        // process dies.
    // rust: !stream_is_unlocked(stream)
}
}

// Whether no process holds `stream` open with an exclusive lock.
stream_is_unlocked :: proc(stream: ^Path) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Ok(file) = OpenOptions::new().read(true).write(true).open(stream) else {
    // rust: return false;
}
    // rust: file.try_lock().is_ok()
}

// Cut a leftover stream to its last whole frame, as [`frame_at`] defines one,
// without holding the whole stream in memory.
whole_stream :: proc(path: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let file = File::open(path)?;
    // rust: let total = file.metadata()?.len();
    // rust: let mut reader = BufReader::new(file);
    // rust: let mut whole = WholeStream::default();
    // rust: let mut offset = 0u64;
    // A frame's eight header bytes and enough of the body to hold its id.
    // rust: let mut probe = [0u8; 13];
    // rust: while total - offset >= 8 {
    // rust: reader.read_exact(&mut probe[..8])?;
    // rust: let length = u32::from_be_bytes([probe[4], probe[5], probe[6], probe[7]]) as u64;
    // rust: let head = 8 + length.min(5);
        // The whole body has to be there, or the frame was cut short.
    // rust: if total - offset < 8 + length {
    // rust: break;
}
    // rust: reader.read_exact(&mut probe[8..head as usize])?;
    // rust: let Some((timestamp_ms, _, _)) = frame_head(&probe[..head as usize], 0) else {
    // rust: break;
}
    // rust: offset += 8 + length;
    // rust: whole.bytes = offset;
    // rust: whole.packets += 1;
    // rust: whole.last_timestamp_ms = whole.last_timestamp_ms.max(timestamp_ms);
    // rust: reader.seek_relative((length - (head - 8)) as i64)?;
}
    // rust: Ok(whole)
}

// Write `dest` from the whole frames of `stream`, and remove the leftover once
// the archive is in place.
    // rust: fn recover_stream(
    // rust: stream: &Path,
    // rust: dest: &Path,
    // rust: mut metadata: Metadata,
    // rust: ) -> io::Result<(PathBuf, usize)> {
    // rust: let whole = whole_stream(stream)?;
    // rust: if whole.packets == 0 {
    // rust: return Err(io::Error::new(
    // rust: io::ErrorKind::InvalidData,
    // rust: "it holds no whole frame",
    // rust: ));
}
    // rust: metadata.duration = whole.last_timestamp_ms;
    // rust: let dest = free_name(dest);
    // rust: let part = sibling(&dest, "mcpr.part");
    // rust: if let Err(e) = package_stream(&metadata, stream, whole.bytes, &part) {
    // rust: let _ = fs::remove_file(&part);
    // rust: return Err(e);
}
    // rust: if let Err(e) = fs::rename(&part, &dest) {
    // rust: let _ = fs::remove_file(&part);
    // rust: return Err(e);
}
    // rust: let _ = fs::remove_file(stream);
    // rust: let _ = fs::remove_file(metadata_beside(stream));
    // rust: Ok((dest, whole.packets))
}

// `dest`, or a `.recovered` name beside it when something already fills it.
free_name :: proc(dest: ^Path) -> P {
    // Ported from Horizon
    return {}
}
    // rust: if !dest.exists() {
    // rust: return dest.to_owned();
}
    // rust: let name = dest
    // rust: .file_name()
    // rust: .unwrap_or_default()
    // rust: .to_string_lossy()
    // rust: .into_owned();
    // rust: let stem = name.strip_suffix(".mcpr").unwrap_or(&name);
    // rust: let mut n = 1;
    // rust: loop {
    // rust: let candidate = dest.with_file_name(if n == 1 {
    // rust: format!("{stem}.recovered.mcpr")
    // rust: } else {
    // rust: format!("{stem}.recovered-{n}.mcpr")
    // rust: });
    // rust: if !candidate.exists() {
    // rust: return candidate;
}
    // rust: n += 1;
}
}

// When a file was last written, in epoch milliseconds as `metaData.json` dates
// are; `0` when the platform or filesystem does not say.
modified_ms :: proc(path: ^Path) -> u {
    // Ported from Horizon
    return {}
}
    // rust: fs::metadata(path)
    // rust: .and_then(|m| m.modified())
    // rust: .ok()
    // rust: .and_then(|t| t.duration_since(std::time::UNIX_EPOCH).ok())
    // rust: .map_or(0, |d| d.as_millis() as u64)
}

    // rust: mod tests {
//     use super::*;

mcpr_roundtrip_metadata_and_packets :: proc() {
}
    // rust: let temp_dir = std::env::temp_dir().join(format!("mcpr_test_{}", std::process::id()));
    // rust: let _ = fs::create_dir_all(&temp_dir);
    // rust: let mcpr_path = temp_dir.join("test_recording.mcpr");

    // rust: let meta = Metadata {
    // rust: server_name: "Studio Test Server".to_owned(),
    // rust: players: vec!["Player1".to_owned(), "Player2".to_owned()],
    // rust: ..Default::default()
}

    // rust: let mut writer = McprWriter::new(mcpr_path.clone(), meta).unwrap();
    // rust: writer.write_packet(0, 0x01, &[10, 20, 30]).unwrap();
    // rust: writer.write_packet(50, 0x24, &[40, 50]).unwrap();
    // rust: writer
    // rust: .write_packet(100, 0x1A, &[99, 100, 101, 102])
    // rust: .unwrap();
    // rust: writer.write_packet(500, 0x05, &[]).unwrap();

    // rust: assert_eq!(writer.packet_count(), 4);
    // rust: let finished_path = writer.finish(550).unwrap();
    // rust: assert_eq!(finished_path, mcpr_path);

    // rust: let mut reader = McprReader::open(&mcpr_path).unwrap();
    // rust: assert_eq!(reader.metadata.server_name, "Studio Test Server");
    // rust: assert_eq!(reader.metadata.duration, 550);
    // rust: assert_eq!(reader.metadata.players, vec!["Player1", "Player2"]);
    // rust: assert_eq!(reader.total_packets(), 4);

    // rust: let p0 = reader.next_packet().unwrap().unwrap();
    // rust: assert_eq!(p0.timestamp_ms, 0);
    // rust: assert_eq!(p0.id, 0x01);
    // rust: assert_eq!(p0.payload, vec![10, 20, 30]);
    // rust: let p1 = reader.next_packet().unwrap().unwrap();
    // rust: assert_eq!(p1.timestamp_ms, 50);
    // rust: assert_eq!(p1.id, 0x24);
    // rust: assert_eq!(p1.payload, vec![40, 50]);
    // rust: let p2 = reader.next_packet().unwrap().unwrap();
    // rust: assert_eq!(p2.timestamp_ms, 100);
    // rust: assert_eq!(p2.id, 0x1A);
    // rust: assert_eq!(p2.payload, vec![99, 100, 101, 102]);
    // rust: let p3 = reader.next_packet().unwrap().unwrap();
    // rust: assert_eq!(p3.timestamp_ms, 500);
    // rust: assert_eq!(p3.id, 0x05);
    // rust: assert!(p3.payload.is_empty());
    // rust: assert!(reader.next_packet().unwrap().is_none());

    // rust: let found_ts = reader.seek_to_timestamp(75).unwrap().unwrap();
    // rust: assert_eq!(found_ts, 50);
    // rust: let seeked = reader.next_packet().unwrap().unwrap();
    // rust: assert_eq!(seeked.timestamp_ms, 50);
    // rust: assert_eq!(seeked.id, 0x24);

    // rust: let _ = fs::remove_file(mcpr_path);
    // rust: let _ = fs::remove_dir(temp_dir);
}

    // A scratch folder for one test, removed when it goes out of scope.
Scratch :: struct {
    // rust: impl Scratch {
new :: proc(name: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let dir = std::env::temp_dir().join(format!("mcpr_{name}_{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&dir);
    fs: :create_dir_all(^dir).unwrap(),
    // rust: Self(dir)
}
}
    // rust: impl Drop for Scratch {
drop :: proc(self: ^Self) {
}
    // rust: let _ = fs::remove_dir_all(&self.0);
}
}

archive :: proc(path: ^Path, meta: []u8, tmcpr: []u8) {
}
    // rust: let mut zip = zip::ZipWriter::new(File::create(path).unwrap());
    // rust: let options = zip::write::SimpleFileOptions::default();
    // rust: zip.start_file("metaData.json", options).unwrap();
    // rust: zip.write_all(meta).unwrap();
    // rust: zip.start_file("recording.tmcpr", options).unwrap();
    // rust: zip.write_all(tmcpr).unwrap();
    // rust: zip.finish().unwrap();
}

frame :: proc(out: ^[dynamic]u8, ts: u32, length: u32, body: []u8) {
}
    // rust: out.extend_from_slice(&ts.to_be_bytes());
    // rust: out.extend_from_slice(&length.to_be_bytes());
    // rust: out.extend_from_slice(body);
}

open_stream :: proc(scratch: ^Scratch, tmcpr: []u8) -> M {
    // Ported from Horizon
    return {}
}
    // rust: let path = scratch.0.join("r.mcpr");
    // rust: archive(
    // rust: &path,
    // rust: &serde_json::to_vec(&Metadata::default()).unwrap(),
    // rust: tmcpr,
    // rust: );
    // rust: McprReader::open(&path).unwrap()
}

    // A recording whose last packet was cut short indexes and plays only the
    // whole ones, and playback ends cleanly where they end.
a_truncated_last_packet_is_not_indexed :: proc() {
}
    // rust: let scratch = Scratch::new("cut");
    // rust: let mut tmcpr = Vec::new();
    // rust: frame(&mut tmcpr, 7, 3, &[0x01, 10, 20]);
    // rust: frame(&mut tmcpr, 9, 100, &[0x02, 1, 2]);
    // rust: let mut reader = open_stream(&scratch, &tmcpr);
    // rust: assert_eq!(reader.total_packets(), 1);
    // rust: assert_eq!(reader.seek_to_timestamp(50).unwrap(), Some(7));
    // rust: let first = reader.next_packet().unwrap().unwrap();
    // rust: assert_eq!((first.id, first.payload), (0x01, vec![10, 20]));
    // rust: assert_eq!(reader.next_packet().unwrap(), None);
}

    // A length field far past the end allocates nothing and ends the stream.
a_huge_length_field_ends_the_stream :: proc() {
}
    // rust: let scratch = Scratch::new("huge");
    // rust: let mut tmcpr = Vec::new();
    // rust: frame(&mut tmcpr, 0, u32::MAX, &[0x01, 2, 3, 4]);
    // rust: let mut reader = open_stream(&scratch, &tmcpr);
    // rust: assert_eq!(reader.total_packets(), 0);
    // rust: assert_eq!(reader.next_packet().unwrap(), None);
    // rust: assert_eq!(reader.seek_to_timestamp(0).unwrap(), None);
}

    // A zero-length frame has no packet id: it is neither counted nor played,
    // and the stream ends before it.
a_zero_length_frame_ends_the_stream :: proc() {
}
    // rust: let scratch = Scratch::new("zero");
    // rust: let mut tmcpr = Vec::new();
    // rust: frame(&mut tmcpr, 1, 1, &[0x03]);
    // rust: frame(&mut tmcpr, 2, 0, &[]);
    // rust: frame(&mut tmcpr, 3, 1, &[0x04]);
    // rust: let mut reader = open_stream(&scratch, &tmcpr);
    // rust: assert_eq!(reader.total_packets(), 1);
    // rust: assert_eq!(reader.next_packet().unwrap().unwrap().id, 0x03);
    // rust: assert_eq!(reader.next_packet().unwrap(), None);
}

    // Seeking lands on the first packet of a millisecond, never in the middle
    // of packets that share it.
seeking_starts_at_the_first_packet_of_a_millisecond :: proc() {
}
    // rust: let scratch = Scratch::new("seek");
    // rust: let mut tmcpr = Vec::new();
    // rust: frame(&mut tmcpr, 50, 1, &[0x00]);
    // rust: for id in 1..=5 {
    // rust: frame(&mut tmcpr, 100, 1, &[id]);
}
    // rust: frame(&mut tmcpr, 200, 1, &[0x06]);
    // rust: let mut reader = open_stream(&scratch, &tmcpr);
    // rust: for (target, ts, id) in [(100, 100, 1), (150, 100, 1), (10, 50, 0), (999, 200, 6)] {
    // rust: assert_eq!(
    // rust: reader.seek_to_timestamp(target).unwrap(),
    // rust: Some(ts),
    // rust: "{target}"
    // rust: );
    // rust: assert_eq!(reader.next_packet().unwrap().unwrap().id, id, "{target}");
}
}

    // A timestamp that goes backwards is played as stored but indexed at the
    // time before it, so seeking still finds the right place.
a_backwards_timestamp_does_not_break_seeking :: proc() {
}
    // rust: let scratch = Scratch::new("backwards");
    // rust: let mut tmcpr = Vec::new();
    // rust: frame(&mut tmcpr, 100, 1, &[0x01]);
    // rust: frame(&mut tmcpr, 20, 1, &[0x02]);
    // rust: frame(&mut tmcpr, 300, 1, &[0x03]);
    // rust: let mut reader = open_stream(&scratch, &tmcpr);
    // rust: assert_eq!(reader.seek_to_timestamp(250).unwrap(), Some(100));
    // rust: let first = reader.next_packet().unwrap().unwrap();
    // rust: assert_eq!((first.timestamp_ms, first.id), (100, 0x01));
    // rust: assert_eq!(reader.next_packet().unwrap().unwrap().timestamp_ms, 20);
}

    // Metadata written by other tools may leave out the fields a recording
    // can do without; a file that isn't MCPR or has oversized metadata is refused.
metadata_reads_minimal_files_and_refuses_bad_ones :: proc() {
}
    // rust: let scratch = Scratch::new("meta");
    // rust: let path = scratch.0.join("m.mcpr");
    // rust: let minimal = br#"{"mcversion":"1.21.4","fileFormat":"MCPR","fileFormatVersion":14,"customServerName":"My World"}"#;
    // rust: archive(&path, minimal, &[]);
    // rust: let reader = McprReader::open(&path).unwrap();
    // rust: assert_eq!(reader.metadata.protocol, None);
    // rust: assert_eq!(reader.metadata.server_name, "");
    // rust: assert_eq!(
    // rust: reader.metadata.custom_server_name.as_deref(),
    // rust: Some("My World")
    // rust: );

    // rust: archive(
    // rust: &path,
    // rust: br#"{"mcversion":"1.21.4","fileFormat":"OTHER","fileFormatVersion":1}"#,
    // rust: &[],
    // rust: );
    // rust: assert_eq!(
    // rust: McprReader::open(&path).err().unwrap().kind(),
    // rust: io::ErrorKind::InvalidData
    // rust: );

    // rust: let mut big =
    // rust: br#"{"mcversion":"1.21.4","fileFormat":"MCPR","fileFormatVersion":14,"generator":""#
    // rust: .to_vec();
    // rust: big.resize(big.len() + MAX_METADATA_BYTES as usize, b'a');
    // rust: big.extend_from_slice(br#""}"#);
    // rust: archive(&path, &big, &[]);
    // rust: assert_eq!(
    // rust: McprReader::open(&path).err().unwrap().kind(),
    // rust: io::ErrorKind::InvalidData
    // rust: );
}

    // A finish that can't put the archive in place keeps the packets and says
    // where they are; a writer dropped without finishing keeps them too.
a_failed_finish_keeps_the_recording :: proc() {
}
    // rust: let scratch = Scratch::new("finish");
        // A non-empty folder at the destination: the final rename fails.
    // rust: let dest = scratch.0.join("blocked.mcpr");
    // rust: fs::create_dir_all(dest.join("inside")).unwrap();
    // rust: let mut writer = McprWriter::new(dest.clone(), Metadata::default()).unwrap();
    // rust: writer.write_packet(5, 0x07, &[1, 2, 3]).unwrap();
    // rust: let stream = writer.stream_path().to_owned();
    // rust: let err = writer.finish(10).unwrap_err();
    // rust: assert!(
    // rust: err.to_string().contains(&stream.display().to_string()),
    // rust: "{err}"
    // rust: );
    // rust: assert!(stream.exists());
    // rust: let leftovers: Vec<_> = fs::read_dir(&scratch.0)
    // rust: .unwrap()
    // rust: .map(|e| e.unwrap().file_name().into_string().unwrap())
    // rust: .filter(|n| n.ends_with(".part"))
    // rust: .collect();
    // rust: assert!(leftovers.is_empty(), "{leftovers:?}");

    // rust: let mut kept = McprWriter::new(scratch.0.join("kept.mcpr"), Metadata::default()).unwrap();
    // rust: kept.write_packet(0, 0x01, &[]).unwrap();
    // rust: let kept_stream = kept.stream_path().to_owned();
    // rust: drop(kept);
    // rust: assert!(kept_stream.exists(), "a dropped writer keeps its packets");

    // rust: let dropped = McprWriter::new(scratch.0.join("dropped.mcpr"), Metadata::default()).unwrap();
    // rust: let empty_stream = dropped.stream_path().to_owned();
    // rust: drop(dropped);
    // rust: assert!(!empty_stream.exists(), "an empty stream is not kept");
}

    // Finishing over an existing recording replaces it only with a complete one.
finishing_replaces_an_existing_recording :: proc() {
}
    // rust: let scratch = Scratch::new("replace");
    // rust: let dest = scratch.0.join("same.mcpr");
    // rust: for id in [0x01, 0x02] {
    // rust: let mut writer = McprWriter::new(dest.clone(), Metadata::default()).unwrap();
    // rust: writer.write_packet(0, id, &[]).unwrap();
    // rust: writer.finish(1).unwrap();
}
    // rust: let mut reader = McprReader::open(&dest).unwrap();
    // rust: assert_eq!(reader.next_packet().unwrap().unwrap().id, 0x02);
    // rust: assert_eq!(fs::read_dir(&scratch.0).unwrap().count(), 1);
}

    // A stream and the metadata a crash leaves: `u32::MAX` is not a pid any
    // process can have, so recovery takes it for a dead writer.
leftover :: proc(scratch: ^Scratch, name: string, meta: Maybe(^Metadata), tmcpr: []u8) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let stream = scratch
    // rust: .0
    // rust: .join(format!("{name}.mcpr.{}-77.tmcpr.tmp", u32::MAX));
    // rust: fs::write(&stream, tmcpr).unwrap();
    // rust: if let Some(meta) = meta {
    // rust: fs::write(
    // rust: metadata_beside(&stream),
    // rust: serde_json::to_vec_pretty(meta).unwrap(),
    // rust: )
    // rust: .unwrap();
}
    // rust: stream
}

    // The recording a crash cut mid-frame comes back up to its last whole
    // frame, with the metadata written beside it, and the leftover is cleaned up.
a_crashed_recording_recovers_to_its_last_whole_frame :: proc() {
}
    // rust: let scratch = Scratch::new("recover");
    // rust: let mut tmcpr = Vec::new();
    // rust: frame(&mut tmcpr, 10, 3, &[0x01, 10, 20]);
    // rust: frame(&mut tmcpr, 20, 2, &[0x02, 30]);
        // The crash cut the third frame after its header and its packet id.
    // rust: frame(&mut tmcpr, 30, 40, &[0x03, 1, 2]);
    // rust: let meta = Metadata {
    // rust: server_name: "Crashed World".to_owned(),
    // rust: players: vec!["Steve".to_owned()],
    // rust: ..Default::default()
}
    // rust: let stream = leftover(&scratch, "session", Some(&meta), &tmcpr);

    // rust: let report = recover_crashed_recordings(&scratch.0).unwrap();
    // rust: let archive = scratch.0.join("session.mcpr");
    // rust: assert_eq!(report.recovered, vec![archive.clone()]);
    // rust: assert!(report.skipped.is_empty(), "{report:?}");
    // rust: assert!(report.kept.is_empty(), "{report:?}");
    // rust: assert!(!stream.exists(), "a recovered leftover is cleaned up");

    // rust: let mut reader = McprReader::open(&archive).unwrap();
    // rust: assert_eq!(reader.metadata.server_name, "Crashed World");
    // rust: assert_eq!(reader.metadata.players, vec!["Steve".to_owned()]);
    // rust: assert_eq!(reader.metadata.duration, 20);
    // rust: assert_eq!(reader.total_packets(), 2);
    // rust: let first = reader.next_packet().unwrap().unwrap();
    // rust: assert_eq!((first.timestamp_ms, first.id), (10, 0x01));
    // rust: assert_eq!(first.payload, vec![10, 20]);
    // rust: assert_eq!(reader.next_packet().unwrap().unwrap().id, 0x02);
    // rust: assert_eq!(reader.next_packet().unwrap(), None);
}

    // A leftover from before the sidecar existed is still packaged, with the
    // format's defaults standing in for the session it can no longer name.
a_leftover_without_metadata_recovers_with_defaults :: proc() {
}
    // rust: let scratch = Scratch::new("nometa");
    // rust: let mut tmcpr = Vec::new();
    // rust: frame(&mut tmcpr, 5, 1, &[0x09]);
    // rust: let stream = leftover(&scratch, "bare", None, &tmcpr);

    // rust: let report = recover_crashed_recordings(&scratch.0).unwrap();
    // rust: let archive = scratch.0.join("bare.mcpr");
    // rust: assert_eq!(report.recovered, vec![archive.clone()]);
    // rust: assert!(!stream.exists());

    // rust: let reader = McprReader::open(&archive).unwrap();
    // rust: assert_eq!(reader.metadata.server_name, Metadata::default().server_name);
    // rust: assert_eq!(
    // rust: reader.metadata.protocol,
    // rust: Some(horizon_protocol::PROTOCOL_VERSION)
    // rust: );
    // rust: assert!(
    // rust: reader.metadata.date > 0,
    // rust: "the leftover's age dates the file"
    // rust: );
    // rust: assert_eq!(reader.total_packets(), 1);
}

    // A writer that is still running is left alone: its stream stays, and the
    // metadata written at recording start is there for when it can be recovered.
recovery_leaves_a_live_writers_stream_alone :: proc() {
}
    // rust: let scratch = Scratch::new("live");
    // rust: let dest = scratch.0.join("live.mcpr");
    // rust: let mut writer = McprWriter::new(dest.clone(), Metadata::default()).unwrap();
    // rust: writer.write_packet(0, 0x04, &[1]).unwrap();
    // rust: let stream = writer.stream_path().to_owned();
    // rust: assert!(
    // rust: writer.metadata_path().exists(),
    // rust: "metadata is written when recording starts"
    // rust: );

    // rust: let report = recover_crashed_recordings(&scratch.0).unwrap();
    // rust: assert_eq!(report.skipped, vec![stream.clone()]);
    // rust: assert!(report.recovered.is_empty(), "{report:?}");
    // rust: assert!(report.kept.is_empty(), "{report:?}");
    // rust: assert!(stream.exists(), "a live stream is not touched");
    // rust: assert!(!dest.exists(), "a live recording is not packaged");

    // rust: writer.finish(1).unwrap();
    // rust: assert!(!stream.exists(), "finish still cleans up");
}

    // A stream with no whole frame cannot become a recording, so it and its
    // metadata are kept rather than deleted.
a_leftover_with_no_whole_frame_is_kept :: proc() {
}
    // rust: let scratch = Scratch::new("kept");
    // rust: let stream = leftover(&scratch, "broken", Some(&Metadata::default()), &[0, 0, 0]);
    // rust: let report = recover_crashed_recordings(&scratch.0).unwrap();
    // rust: assert_eq!(report.kept, vec![stream.clone()]);
    // rust: assert!(report.recovered.is_empty(), "{report:?}");
    // rust: assert!(stream.exists(), "an unrecoverable leftover is kept");
    // rust: assert!(metadata_beside(&stream).exists());
}

    // Recovery never overwrites a recording that is already there.
recovery_does_not_replace_an_existing_recording :: proc() {
}
    // rust: let scratch = Scratch::new("existing");
    // rust: let existing = scratch.0.join("taken.mcpr");
    // rust: archive(&existing, b"{}", &[]);
    // rust: let mut tmcpr = Vec::new();
    // rust: frame(&mut tmcpr, 1, 1, &[0x02]);
    // rust: let stream = leftover(&scratch, "taken", None, &tmcpr);

    // rust: let report = recover_crashed_recordings(&scratch.0).unwrap();
    // rust: assert_eq!(
    // rust: report.recovered,
    // rust: vec![scratch.0.join("taken.recovered.mcpr")]
    // rust: );
    // rust: assert!(!stream.exists());
    // rust: assert!(existing.exists());
}

    // The metadata beside a stream follows it while recording, so a crash can
    // never leave a sidecar describing packets the stream does not hold.
the_metadata_follows_the_stream_it_belongs_to :: proc() {
}
    // rust: let scratch = Scratch::new("cadence");
    // rust: let mut writer = McprWriter::new(scratch.0.join("c.mcpr"), Metadata::default()).unwrap();
    // rust: writer.write_packet(0, 0x01, &[]).unwrap();
    // rust: writer
    // rust: .write_packet(2 * FLUSH_INTERVAL_MS, 0x02, &[])
    // rust: .unwrap();
    // rust: let sidecar: Metadata =
    // rust: serde_json::from_slice(&fs::read(writer.metadata_path()).unwrap()).unwrap();
    // rust: assert_eq!(sidecar.duration, 2 * FLUSH_INTERVAL_MS);
    // rust: assert_eq!(sidecar.generator, "Horizon Studio");
}
}
