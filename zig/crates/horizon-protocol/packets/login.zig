//! Transpiled from Horizon Rust crate
//! Module: horizon-protocol_login
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Login state: offline/online hello, encryption request, compression,
//! login plugin queries and the finished game profile.
// use crate::{
    // rust: buf::{Bool, Bytes, Ident, Opt, Rest, Str, StrN, Uuid, VarInt},
    // rust: packet, packet_enum,
    // rust: packets::Empty,
}

    // rust: packet!(
    /// com.mojang.authlib.properties.Property.
    // rust: Property {
    // rust: name: String => StrN<64>,
    // rust: value: String => Str,
    // rust: signature: Option<String> => Opt<StrN<1024>>,
}
    // rust: );
    // rust: packet!(
    /// ByteBufCodecs.GAME_PROFILE.
    // rust: GameProfile {
    // rust: uuid: u128 => Uuid,
    // rust: name: String => StrN<16>,
    // rust: properties: Vec<Property> => crate::buf::List<Property>,
}
    // rust: );
    // rust: packet!(Disconnect { reason_json: String => StrN<262144> });
    // rust: packet!(Hello {
    // rust: server_id: String => StrN<20>,
    // rust: public_key: Vec<u8> => Bytes,
    // rust: challenge: Vec<u8> => Bytes,
    // rust: should_authenticate: bool => Bool,
    // rust: });
    // rust: packet!(LoginFinished { profile: GameProfile => GameProfile, session: u128 => Uuid });
    // rust: packet!(Compression { threshold: i32 => VarInt });
    // rust: packet!(CustomQuery { transaction: i32 => VarInt, channel: String => Ident, data: Vec<u8> => Rest });
    // rust: packet!(CookieRequest { key: String => Ident });

    // rust: packet_enum!(Clientbound, crate::ids::login::clientbound {
    // rust: Disconnect(Disconnect) = LOGIN_DISCONNECT,
    // rust: Hello(Hello) = HELLO,
    // rust: LoginFinished(LoginFinished) = LOGIN_FINISHED,
    // rust: Compression(Compression) = LOGIN_COMPRESSION,
    // rust: CustomQuery(CustomQuery) = CUSTOM_QUERY,
    // rust: CookieRequest(CookieRequest) = COOKIE_REQUEST,
    // rust: });

    // rust: packet!(ServerHello { name: String => StrN<16>, uuid: u128 => Uuid });
    // rust: packet!(Key { key: Vec<u8> => Bytes, challenge: Vec<u8> => Bytes });
    // rust: packet!(CustomQueryAnswer { transaction: i32 => VarInt, payload: Option<Vec<u8>> => Opt<Rest> });
    // rust: packet!(CookieResponse { key: String => Ident, payload: Option<Vec<u8>> => Opt<Bytes> });

    // rust: packet_enum!(Serverbound, crate::ids::login::serverbound {
    // rust: Hello(ServerHello) = HELLO,
    // rust: Key(Key) = KEY,
    // rust: CustomQueryAnswer(CustomQueryAnswer) = CUSTOM_QUERY_ANSWER,
    // rust: LoginAcknowledged(Empty) = LOGIN_ACKNOWLEDGED,
    // rust: CookieResponse(CookieResponse) = COOKIE_RESPONSE,
    // rust: });

    // rust: mod tests {
//     use super::*;
//     use crate::packets::round_trip;

pub fn login_round_trips() void {
}
    // rust: let profile = GameProfile {
    // rust: uuid: crate::crypto::offline_uuid("Horizon"),
    // rust: name: "Horizon".into(),
    // rust: properties: vec![Property {
    // rust: name: "textures".into(),
    // rust: value: "e30=".into(),
    // rust: signature: None,
    // rust: }],
}
    // rust: for p in [
    // rust: Clientbound::Disconnect(Disconnect {
    // rust: reason_json: "{\"text\":\"bye\"}".into(),
    // rust: }),
    // rust: Clientbound::Hello(Hello {
    // rust: server_id: String::new(),
    // rust: public_key: vec![1, 2],
    // rust: challenge: vec![3; 4],
    // rust: should_authenticate: true,
    // rust: }),
    // rust: Clientbound::LoginFinished(LoginFinished {
    // rust: profile,
    // rust: session: 7,
    // rust: }),
    // rust: Clientbound::Compression(Compression { threshold: 256 }),
    // rust: Clientbound::CustomQuery(CustomQuery {
    // rust: transaction: 3,
    // rust: channel: "velocity:player_info".into(),
    // rust: data: vec![1],
    // rust: }),
    // rust: Clientbound::CookieRequest(CookieRequest { key: "a:b".into() }),
    // rust: ] {
    // rust: round_trip(p, Clientbound::encode, Clientbound::decode);
}
    // rust: for p in [
    // rust: Serverbound::Hello(ServerHello {
    // rust: name: "Horizon".into(),
    // rust: uuid: 1,
    // rust: }),
    // rust: Serverbound::Key(Key {
    // rust: key: vec![9; 128],
    // rust: challenge: vec![8; 128],
    // rust: }),
    // rust: Serverbound::CustomQueryAnswer(CustomQueryAnswer {
    // rust: transaction: 3,
    // rust: payload: None,
    // rust: }),
    // rust: Serverbound::LoginAcknowledged(Empty),
    // rust: Serverbound::CookieResponse(CookieResponse {
    // rust: key: "a:b".into(),
    // rust: payload: Some(vec![1]),
    // rust: }),
    // rust: ] {
    // rust: round_trip(p, Serverbound::encode, Serverbound::decode);
}
}

pub fn rejects_trailing_bytes_and_long_names() void {
}
    // rust: let mut body = Serverbound::LoginAcknowledged(Empty).encode();
    // rust: body.push(0);
    // rust: assert!(Serverbound::decode(3, &body[1..]).is_err());
    // rust: let long = Serverbound::Hello(ServerHello {
    // rust: name: "x".repeat(17),
    // rust: uuid: 0,
    // rust: })
    // rust: .encode();
    // rust: assert!(Serverbound::decode(0, &long[1..]).is_err());
}
}
