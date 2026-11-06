//! Transpiled from Horizon Rust crate
package horizon_protocol_attachment_sync

import "core:fmt"
import "core:mem"
import "core:math"

// Attachment sync: the values of a native mod's synced attachments, sent by a
// Horizon server to the Horizon clients that see their holder
// (docs/native-mods.md, "Server attachments").
//
// A payload is the holder (a varint kind and its fields), whether the
// client's copy of the holder is replaced, then each change: the attachment's
// namespace and name and its value as an NBT compound, or no tag for a
// removal.
// use horizon_world::{
    // rust: attachments::{AttachmentSync, Holder},
    // rust: nbt::{self, Tag},
}

// use crate::{
    // rust: Error, Result,
    // rust: buf::{Reader, Writer},
}

// The custom payload channel, clientbound only: a client sends nothing back.
CHANNEL :: "horizon:attachment_sync"
// Characters in a namespace or a name at most.
MAX_NAME :: 256
// Bytes of a payload at most
// (ClientboundCustomPayloadPacket.MAX_PAYLOAD_SIZE).
MAX_PAYLOAD :: 1_048_576

// A holder's changes as they travel.
Message :: struct {
    holder: Holder,
    // The changes are the holder's whole synced state: drop what the client
    // holds first.
    replace: bool,
    changes: [dynamic]AttachmentSync,
}

// A message's payload; an error for a holder it cannot write, a name past
// [`MAX_NAME`], a value that is not an encodable compound, or a payload past
// [`MAX_PAYLOAD`].
encode :: proc(message: ^Message) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut w = Writer::new();
    // rust: match message.holder {
    // rust: Holder::Entity(id) => {
    // rust: w.varint(0);
    // rust: w.varint(id as i32);
}
    // rust: Holder::Player(uuid) => {
    // rust: w.varint(1);
    // rust: w.uuid(uuid);
}
    // rust: Holder::BlockEntity(pos) => {
    // rust: w.varint(2);
    // rust: pos.iter().for_each(|&axis| w.i32(axis));
}
    // rust: Holder::Chunk(pos) => {
    // rust: w.varint(3);
    // rust: pos.iter().for_each(|&axis| w.i32(axis));
}
    // rust: Holder::Level => w.varint(4),
    // rust: _ => return Err(Error::new("attachment sync: unknown holder")),
}
    // rust: w.bool(message.replace);
    // rust: w.varint(message.changes.len() as i32);
    // rust: for change in &message.changes {
    // rust: for name in [&change.namespace, &change.name] {
    // rust: let name = name
    // rust: .to_string()
    // rust: .map_err(|_| Error::new("attachment sync: name is not UTF-16"))?;
    // rust: if name.encode_utf16().count() > MAX_NAME {
    // rust: return Err(Error::new(format!(
    // rust: "attachment sync: name {name} is too long"
    // rust: )));
}
    // rust: w.string(&name);
}
    // rust: match &change.value {
    // rust: Some(value) => {
    // rust: let tag = Tag::Compound(value.clone());
    // rust: let bytes = nbt::write_network(&tag, nbt::Limits::default())
    // rust: .map_err(|e| Error::new(format!("attachment sync: value: {e}")))?;
    // rust: w.bytes(&bytes);
}
    // rust: None => w.bytes(&[0]),
}
}
    // rust: if w.data.len() > MAX_PAYLOAD {
    // rust: return Err(Error::new("attachment sync: payload too big"));
}
    // rust: Ok(w.data)
}

// A payload's message; an error for one that breaks a cap.
decode :: proc(data: []u8) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if data.len() > MAX_PAYLOAD {
    // rust: return Err(Error::new("attachment sync: payload too big"));
}
    // rust: let mut r = Reader::new(data);
    // rust: let holder = match r.varint()? {
    // rust: 0 => Holder::Entity(r.varint()? as u32),
    // rust: 1 => Holder::Player(r.uuid()?),
    // rust: 2 => Holder::BlockEntity([r.i32()?, r.i32()?, r.i32()?]),
    // rust: 3 => Holder::Chunk([r.i32()?, r.i32()?]),
    // rust: 4 => Holder::Level,
    // rust: kind => return Err(Error::new(format!("attachment sync: holder kind {kind}"))),
}
    // rust: let replace = r.bool()?;
    // rust: let max = r.remaining();
    // rust: let changes = (0..r.count(max)?)
    // rust: .map(|_| {
    // rust: let namespace = r.string(MAX_NAME)?;
    // rust: let name = r.string(MAX_NAME)?;
    // rust: let value = match r.nbt()? {
    // rust: Tag::Compound(value) => Some(value),
    // rust: Tag::End => None,
    // rust: _ => return Err(Error::new("attachment sync: value is not a compound")),
}
    // rust: Ok(AttachmentSync {
    // rust: namespace: namespace.as_str().into(),
    // rust: name: name.as_str().into(),
    // rust: value,
    // rust: })
    // rust: })
    // rust: .collect::<Result<Vec<_>>>()?;
    // rust: if r.remaining() > 0 {
    // rust: return Err(Error::new("attachment sync: trailing bytes"));
}
    // rust: Ok(Message {
    // rust: holder,
    // rust: replace,
    // rust: changes,
    // rust: })
}

    // rust: mod tests {
//     use super::*;

changes :: proc() -> V {
    // Ported from Horizon
    return {}
}
    // rust: vec![
    // rust: AttachmentSync {
    // rust: namespace: "mana".into(),
    // rust: name: "pool".into(),
    // rust: value: Some([("value".into(), Tag::Int(12))].into()),
    // rust: },
    // rust: AttachmentSync {
    // rust: namespace: "mana".into(),
    // rust: name: "gone".into(),
    // rust: value: None,
    // rust: },
    // rust: ]
}

every_holder_round_trips_with_either_replace_and_a_removal :: proc() {
}
    // rust: let holders = [
    // rust: Holder::Entity(4_000_000_000),
    // rust: Holder::Player(0x0123_4567_89ab_cdef_0011_2233_4455_6677),
    // rust: Holder::BlockEntity([-30_000_000, -64, 29_999_999]),
    // rust: Holder::Chunk([-5, 7]),
    // rust: Holder::Level,
    // rust: ];
    // rust: for holder in holders {
    // rust: for replace in [true, false] {
    // rust: let message = Message {
    // rust: holder,
    // rust: replace,
    // rust: changes: changes(),
}
    // rust: assert_eq!(decode(&encode(&message).unwrap()).unwrap(), message);
}
}
}

decode_refuses_trailing_bytes_and_an_unknown_holder_kind :: proc() {
}
    // rust: let message = Message {
    // rust: holder: Holder::Level,
    // rust: replace: false,
    // rust: changes: changes(),
}
    // rust: let mut payload = encode(&message).unwrap();
    // rust: payload.push(0);
    // rust: assert!(decode(&payload).is_err(), "trailing bytes");
    // rust: assert!(decode(&[5, 0, 0]).is_err(), "unknown holder kind");
}

encode_refuses_a_change_the_client_would_not_read_as_sent :: proc() {
}
    // rust: let mut message = Message {
    // rust: holder: Holder::Level,
    // rust: replace: false,
    // rust: changes: changes(),
}
    // rust: message.changes[0].name = "n".repeat(MAX_NAME).as_str().into();
    // rust: assert!(decode(&encode(&message).unwrap()).is_ok());
    // rust: message.changes[0].name = "n".repeat(MAX_NAME + 1).as_str().into();
    // rust: assert!(encode(&message).is_err(), "name");
    // rust: message.changes[0].name = "pool".into();
    // rust: let mut deep = Tag::Int(0);
    // rust: for _ in 0..600 {
    // rust: deep = Tag::Compound([("v".into(), deep)].into());
}
    // rust: let Tag::Compound(deep) = deep else {
    // rust: unreachable!()
}
    // rust: message.changes[0].value = Some(deep);
    // rust: assert!(encode(&message).is_err(), "unwritable value");
    // rust: let big = Tag::ByteArray(vec![0; MAX_PAYLOAD]);
    // rust: message.changes[0].value = Some([("big".into(), big)].into());
    // rust: assert!(encode(&message).is_err(), "payload");
}
}
