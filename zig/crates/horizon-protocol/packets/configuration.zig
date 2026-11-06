//! Transpiled from Horizon Rust crate
//! Module: horizon-protocol_configuration
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Configuration state: registries, tags, known packs, feature flags and the
//! common packets (keep-alive, ping, custom payloads, resource packs).
// use crate::{
    // rust: Result,
    // rust: buf::{
    // rust: Bool, Byte, Codec, Ident, Int, List, Long, Nbt, Opt, Reader, Rest, Str, StrN, UByte, Uuid,
    // rust: VarInt, Writer,
    // rust: },
    // rust: packet, packet_enum,
    // rust: packets::Empty,
}
// use horizon_world::nbt::Tag;

    // rust: packet!(CookieRequest { key: String => Ident });
    // rust: packet!(CustomPayload { channel: String => Ident, data: Vec<u8> => Rest });
    // rust: packet!(
    /// Common disconnect: a chat component (NBT).
    // rust: Disconnect { reason: Tag => Nbt }
    // rust: );
    // rust: packet!(KeepAlive { id: i64 => Long });
    // rust: packet!(Ping { id: i32 => Int });
    // rust: packet!(
    /// RegistrySynchronization.PackedRegistryEntry: data is absent when the
    /// client already has the entry from a known pack.
    // rust: RegistryEntry { id: String => Ident, data: Option<Tag> => Opt<Nbt> }
    // rust: );
    // rust: packet!(RegistryData { registry: String => Ident, entries: Vec<RegistryEntry> => List<RegistryEntry> });
    // rust: packet!(ResourcePackPop { id: Option<u128> => Opt<Uuid> });
    // rust: packet!(ResourcePackPush {
    // rust: id: u128 => Uuid,
    // rust: url: String => Str,
    // rust: hash: String => StrN<40>,
    // rust: required: bool => Bool,
    // rust: prompt: Option<Tag> => Opt<Nbt>,
    // rust: });
    // rust: packet!(StoreCookie { key: String => Ident, payload: Vec<u8> => crate::buf::Bytes });
    // rust: packet!(Transfer { host: String => Str, port: i32 => VarInt });
    // rust: packet!(UpdateEnabledFeatures { features: Vec<String> => List<Ident> });
    // rust: packet!(TagEntry { name: String => Ident, ids: Vec<i32> => List<VarInt> });
    // rust: packet!(RegistryTags { registry: String => Ident, tags: Vec<TagEntry> => List<TagEntry> });
    // rust: packet!(
    /// ClientboundUpdateTagsPacket: tags per registry.
    // rust: UpdateTags { registries: Vec<RegistryTags> => List<RegistryTags> }
    // rust: );
    // rust: packet!(KnownPack { namespace: String => Str, id: String => Str, version: String => Str });
    // rust: packet!(SelectKnownPacks { packs: Vec<KnownPack> => List<KnownPack> });
    // rust: packet!(CodeOfConduct { text: String => Str });

/// ServerLinks.UntrustedEntry's `type` (Either<KnownLinkType, Component>): a
/// known link's id, or a custom label component.
pub const ServerLinkKind = enum {
    /// ServerLinks.KnownLinkType by id (ByIdMap: unknown ids read as 0).
    Known(i32),
    /// A custom label (TRUSTED_CONTEXT_FREE_STREAM_CODEC: a component in NBT).
    Custom(Tag),
};
/// ServerLinks.UntrustedEntry: the label and the unchecked link string (the
/// client keeps only `http`/`https` URIs, Util.parseAndValidateUntrustedUri).
pub const ServerLink = struct {
    kind: ServerLinkKind,
    link: []const u8,
};
    // rust: impl Codec<ServerLink> for ServerLink {
pub fn read(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let kind = if Bool::read(r)? {
    // rust: ServerLinkKind::Known(VarInt::read(r)?)
    // rust: } else {
    // rust: ServerLinkKind::Custom(Nbt::read(r)?)
}
    // rust: Ok(Self {
    // rust: kind,
    // rust: link: Str::read(r)?,
    // rust: })
}
pub fn write(v: *Self, w: *mut Writer) void {
}
    // rust: match &v.kind {
    // rust: ServerLinkKind::Known(id) => {
    // rust: Bool::write(&true, w);
    // rust: VarInt::write(id, w);
}
    // rust: ServerLinkKind::Custom(tag) => {
    // rust: Bool::write(&false, w);
    // rust: Nbt::write(tag, w);
}
}
    // rust: Str::write(&v.link, w);
}
}
    // rust: packet!(
    /// ClientboundServerLinksPacket (a common packet: configuration and play).
    /// Links the pause menu's "Server Links..." screen lists.
    // rust: ServerLinks { links: Vec<ServerLink> => List<ServerLink> }
    // rust: );
    // rust: packet!(
    /// ClientboundShowDialogPacket.CONTEXT_FREE_STREAM_CODEC: the dialog
    /// itself (`Dialog.DIRECT_CODEC` as NBT).
    // rust: ShowDialog { dialog: Tag => Nbt }
    // rust: );
    // rust: packet!(
    /// ServerboundCustomClickActionPacket: a `custom` click event's id and
    /// payload (a dialog's answer).
    // rust: CustomClickAction { id: String => Ident, payload: Option<Tag> => ClickPayload }
    // rust: );
/// ServerboundCustomClickActionPacket.UNTRUSTED_TAG_CODEC: an optional tag
/// (`End` when there is none) behind its length, 65536 bytes at most.
pub const ClickPayload = struct {};
    // rust: impl Codec<Option<Tag>> for ClickPayload {
pub fn read(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let n = r.count(65536)?;
    // rust: let tag = Reader::new(r.bytes(n)?).nbt()?;
    // rust: Ok((tag != Tag::End).then_some(tag))
}
pub fn write(v: *?Tag, w: *mut Writer) void {
}
    // rust: let mut tag = Writer::new();
    // rust: tag.nbt(v.as_ref().unwrap_or(&Tag::End));
    // rust: w.varint(tag.data.len() as i32);
    // rust: w.bytes(&tag.data);
}
}

    // rust: packet_enum!(Clientbound, crate::ids::configuration::clientbound {
    // rust: CookieRequest(CookieRequest) = COOKIE_REQUEST,
    // rust: CustomPayload(CustomPayload) = CUSTOM_PAYLOAD,
    // rust: Disconnect(Disconnect) = DISCONNECT,
    // rust: FinishConfiguration(Empty) = FINISH_CONFIGURATION,
    // rust: KeepAlive(KeepAlive) = KEEP_ALIVE,
    // rust: Ping(Ping) = PING,
    // rust: ResetChat(Empty) = RESET_CHAT,
    // rust: RegistryData(RegistryData) = REGISTRY_DATA,
    // rust: ResourcePackPop(ResourcePackPop) = RESOURCE_PACK_POP,
    // rust: ResourcePackPush(ResourcePackPush) = RESOURCE_PACK_PUSH,
    // rust: StoreCookie(StoreCookie) = STORE_COOKIE,
    // rust: Transfer(Transfer) = TRANSFER,
    // rust: UpdateEnabledFeatures(UpdateEnabledFeatures) = UPDATE_ENABLED_FEATURES,
    // rust: UpdateTags(UpdateTags) = UPDATE_TAGS,
    // rust: SelectKnownPacks(SelectKnownPacks) = SELECT_KNOWN_PACKS,
    // rust: ClearDialog(Empty) = CLEAR_DIALOG,
    // rust: ServerLinks(ServerLinks) = SERVER_LINKS,
    // rust: ShowDialog(ShowDialog) = SHOW_DIALOG,
    // rust: CodeOfConduct(CodeOfConduct) = CODE_OF_CONDUCT,
    // rust: });

/// ClientInformation.
pub const ClientInformation = struct {
    language: []const u8,
    view_distance: i8,
    /// ChatVisiblity: 0 full, 1 system, 2 hidden.
    chat_visibility: i32,
    chat_colors: bool,
    /// Skin layer bits (PlayerModelPart).
    model_customisation: u8,
    /// HumanoidArm: 0 left, 1 right.
    main_hand: i32,
    text_filtering: bool,
    allows_listing: bool,
    /// ParticleStatus: 0 all, 1 decreased, 2 minimal.
    particle_status: i32,
};
    // rust: impl ClientInformation {
    /// ClientInformation.createDefault with a view distance.
pub fn new(view_distance: i8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: language: "en_us".into(),
    // rust: view_distance,
    // rust: chat_visibility: 0,
    // rust: chat_colors: true,
    // rust: model_customisation: 0x7F,
    // rust: main_hand: 1,
    // rust: text_filtering: false,
    // rust: allows_listing: true,
    // rust: particle_status: 0,
}
}
}
    // rust: impl Codec<ClientInformation> for ClientInformation {
pub fn read(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(Self {
    // rust: language: StrN::<16>::read(r)?,
    // rust: view_distance: Byte::read(r)?,
    // rust: chat_visibility: VarInt::read(r)?,
    // rust: chat_colors: Bool::read(r)?,
    // rust: model_customisation: UByte::read(r)?,
    // rust: main_hand: VarInt::read(r)?,
    // rust: text_filtering: Bool::read(r)?,
    // rust: allows_listing: Bool::read(r)?,
    // rust: particle_status: VarInt::read(r)?,
    // rust: })
}
pub fn write(v: *Self, w: *mut Writer) void {
}
    // rust: w.string(&v.language);
    // rust: w.i8(v.view_distance);
    // rust: w.varint(v.chat_visibility);
    // rust: w.bool(v.chat_colors);
    // rust: w.u8(v.model_customisation);
    // rust: w.varint(v.main_hand);
    // rust: w.bool(v.text_filtering);
    // rust: w.bool(v.allows_listing);
    // rust: w.varint(v.particle_status);
}
}
    // rust: packet!(CookieResponse { key: String => Ident, payload: Option<Vec<u8>> => Opt<crate::buf::Bytes> });
    // rust: packet!(
    /// ServerboundResourcePackPacket.Action: 0 loaded, 1 declined, 2 failed
    /// download, 3 accepted, 4 downloaded, 5 invalid url, 6 failed reload, 7 discarded.
    // rust: ResourcePackResponse { id: u128 => Uuid, action: i32 => VarInt }
    // rust: );

    // rust: packet_enum!(Serverbound, crate::ids::configuration::serverbound {
    // rust: ClientInformation(ClientInformation) = CLIENT_INFORMATION,
    // rust: CookieResponse(CookieResponse) = COOKIE_RESPONSE,
    // rust: CustomPayload(CustomPayload) = CUSTOM_PAYLOAD,
    // rust: FinishConfiguration(Empty) = FINISH_CONFIGURATION,
    // rust: KeepAlive(KeepAlive) = KEEP_ALIVE,
    // rust: Pong(Ping) = PONG,
    // rust: ResourcePack(ResourcePackResponse) = RESOURCE_PACK,
    // rust: SelectKnownPacks(SelectKnownPacks) = SELECT_KNOWN_PACKS,
    // rust: AcceptCodeOfConduct(Empty) = ACCEPT_CODE_OF_CONDUCT,
    // rust: CustomClickAction(CustomClickAction) = CUSTOM_CLICK_ACTION,
    // rust: });

    // rust: mod tests {
//     use super::*;
//     use crate::packets::round_trip;

pub fn configuration_round_trips() void {
}
    // rust: let biome = Tag::compound([
    // rust: ("has_precipitation", Tag::Byte(1)),
    // rust: ("temperature", Tag::Float(0.8f32.to_bits())),
    // rust: ]);
    // rust: for p in [
    // rust: Clientbound::CustomPayload(CustomPayload {
    // rust: channel: "minecraft:brand".into(),
    // rust: data: vec![7, b'v', b'a', b'n', b'i', b'l', b'l', b'a'],
    // rust: }),
    // rust: Clientbound::Disconnect(Disconnect {
    // rust: reason: crate::text::literal("bye"),
    // rust: }),
    // rust: Clientbound::FinishConfiguration(Empty),
    // rust: Clientbound::KeepAlive(KeepAlive { id: 99 }),
    // rust: Clientbound::Ping(Ping { id: -3 }),
    // rust: Clientbound::RegistryData(RegistryData {
    // rust: registry: "minecraft:worldgen/biome".into(),
    // rust: entries: vec![
    // rust: RegistryEntry {
    // rust: id: "minecraft:plains".into(),
    // rust: data: Some(biome),
    // rust: },
    // rust: RegistryEntry {
    // rust: id: "minecraft:desert".into(),
    // rust: data: None,
    // rust: },
    // rust: ],
    // rust: }),
    // rust: Clientbound::ResourcePackPush(ResourcePackPush {
    // rust: id: 5,
    // rust: url: "http://x".into(),
    // rust: hash: String::new(),
    // rust: required: false,
    // rust: prompt: None,
    // rust: }),
    // rust: Clientbound::UpdateEnabledFeatures(UpdateEnabledFeatures {
    // rust: features: vec!["minecraft:vanilla".into()],
    // rust: }),
    // rust: Clientbound::UpdateTags(UpdateTags {
    // rust: registries: vec![RegistryTags {
    // rust: registry: "minecraft:block".into(),
    // rust: tags: vec![TagEntry {
    // rust: name: "minecraft:logs".into(),
    // rust: ids: vec![1, 2, 300],
    // rust: }],
    // rust: }],
    // rust: }),
    // rust: Clientbound::SelectKnownPacks(SelectKnownPacks {
    // rust: packs: vec![KnownPack {
    // rust: namespace: "minecraft".into(),
    // rust: id: "core".into(),
    // rust: version: "26.3".into(),
    // rust: }],
    // rust: }),
    // rust: Clientbound::CodeOfConduct(CodeOfConduct {
    // rust: text: "Be nice".into(),
    // rust: }),
    // rust: Clientbound::ServerLinks(ServerLinks {
    // rust: links: vec![
    // rust: ServerLink {
    // rust: kind: ServerLinkKind::Known(0),
    // rust: link: "https://bugs.example.net".into(),
    // rust: },
    // rust: ServerLink {
    // rust: kind: ServerLinkKind::Custom(crate::text::literal("Custom link")),
    // rust: link: "https://example.net".into(),
    // rust: },
    // rust: ],
    // rust: }),
    // rust: Clientbound::ShowDialog(ShowDialog {
    // rust: dialog: Tag::compound([("type", Tag::String("minecraft:notice".into()))]),
    // rust: }),
    // rust: Clientbound::ClearDialog(Empty),
    // rust: ] {
    // rust: round_trip(p, Clientbound::encode, Clientbound::decode);
}
    // rust: for p in [
    // rust: Serverbound::ClientInformation(ClientInformation::new(12)),
    // rust: Serverbound::FinishConfiguration(Empty),
    // rust: Serverbound::KeepAlive(KeepAlive { id: 99 }),
    // rust: Serverbound::Pong(Ping { id: -3 }),
    // rust: Serverbound::ResourcePack(ResourcePackResponse { id: 5, action: 1 }),
    // rust: Serverbound::SelectKnownPacks(SelectKnownPacks { packs: vec![] }),
    // rust: Serverbound::AcceptCodeOfConduct(Empty),
    // rust: Serverbound::CustomClickAction(CustomClickAction {
    // rust: id: "authme:prejoin-register/submit".into(),
    // rust: payload: Some(Tag::compound([("password", Tag::String("hunter2".into()))])),
    // rust: }),
    // rust: Serverbound::CustomClickAction(CustomClickAction {
    // rust: id: "minecraft:x".into(),
    // rust: payload: None,
    // rust: }),
    // rust: ] {
    // rust: round_trip(p, Serverbound::encode, Serverbound::decode);
}
}

pub fn client_information_carries_the_main_hand() void {
}
        // Skin Customization's Main Hand: HumanoidArm LEFT is 0, RIGHT is 1.
    // rust: for main_hand in [0, 1] {
    // rust: round_trip(
    // rust: Serverbound::ClientInformation(ClientInformation {
    // rust: main_hand,
    // rust: ..ClientInformation::new(12)
    // rust: }),
    // rust: Serverbound::encode,
    // rust: Serverbound::decode,
    // rust: );
}
}

    /// The bytes vanilla writes: the length, then the tag (a lone `End` byte
    /// for none).
pub fn click_payload_is_length_prefixed() void {
}
    // rust: let mut w = Writer::new();
    // rust: ClickPayload::write(&None, &mut w);
    // rust: assert_eq!(w.data, [1, 0]);
    // rust: let mut w = Writer::new();
    // rust: ClickPayload::write(&Some(Tag::Byte(1)), &mut w);
    // rust: assert_eq!(w.data, [2, 1, 1]);
}
}
